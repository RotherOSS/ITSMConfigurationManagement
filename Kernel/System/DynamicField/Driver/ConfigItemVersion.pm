# --
# OTOBO is a web-based ticketing system for service organisations.
# --
# Copyright (C) 2001-2020 OTRS AG, https://otrs.com/
# Copyright (C) 2019-2026 Rother OSS GmbH, https://otobo.io/
# --
# This program is free software: you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation, either version 3 of the License, or (at your option) any later version.
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <https://www.gnu.org/licenses/>.
# --

package Kernel::System::DynamicField::Driver::ConfigItemVersion;

use v5.24;
use strict;
use warnings;
use namespace::autoclean;
use utf8;

use parent qw(Kernel::System::DynamicField::Driver::ConfigItem);

# core modules
use List::Util qw(any);

# CPAN modules

# OTOBO modules
use Kernel::Language              qw(Translatable);
use Kernel::System::VariableCheck qw(IsArrayRefWithData);

our @ObjectDependencies = (
    'Kernel::Config',
    'Kernel::System::DynamicField',
    'Kernel::System::DynamicField::Backend',
    'Kernel::System::GeneralCatalog',
    'Kernel::System::Log',
    'Kernel::System::ITSMConfigItem',
    'Kernel::System::Web::FormCache',
);

=head1 NAME

Kernel::System::DynamicField::Driver::ConfigItemVersion - backend for the Reference dynamic field

=head1 DESCRIPTION

ITSMConfigItemVersion backend for the Reference dynamic field.

=head1 PUBLIC INTERFACE

=head2 new()

it is usually not necessary to explicitly create instances of dynamic field drivers.
Instances of the drivers are created in the constructor of the
dynamic field backend object C<Kernel::System::DynamicField::Backend>.

=cut

sub new {
    my ($Type) = @_;

    # allocate new hash for object
    my $Self = bless {}, $Type;

    # Some reference dynamic fields are stored in the database table attribute dynamic_field_value.value_int.
    $Self->{ValueType}      = 'Integer';
    $Self->{ValueKey}       = 'ValueInt';
    $Self->{TableAttribute} = 'value_int';

    # Used for declaring CSS classes
    $Self->{FieldCSSClass} = 'DynamicFieldReference';

    # set field behaviors
    $Self->{Behaviors} = {
        'IsACLReducible'               => 0,
        'IsNotificationEventCondition' => 0,
        'IsSortable'                   => 1,
        'IsFiltrable'                  => 1,
        'IsStatsCondition'             => 0,
        'IsCustomerInterfaceCapable'   => 1,
        'IsHiddenInTicketInformation'  => 0,
        'IsReferenceField'             => 1,
    };

    $Self->{ReferencedObjectType} = 'ITSMConfigItemVersion';

    return $Self;
}

sub EditFieldRender {
    my ( $Self, %Param ) = @_;

    # take config from field config
    my $DFDetails         = $Param{DynamicFieldConfig}{Config};
    my $FieldName         = 'DynamicField_' . $Param{DynamicFieldConfig}{Name};
    my $FieldLabel        = $Param{DynamicFieldConfig}->{Label};
    my $FieldLabelEscaped = $Param{LayoutObject}->Ascii2Html(
        Text => $Param{LayoutObject}{LanguageObject}->Translate($FieldLabel),
    );

    my $Value = '';

    # set the field value or default
    if ( $Param{UseDefaultValue} ) {
        $Value = $DFDetails->{DefaultValue} // '';
    }
    $Value = $Param{Value} // $Value;

    # Extract the dynamic field value from the web request and set it if present. Do this after
    #   stored value is retrieved and processed, so it can be overridden if form has refreshed for
    #   some reasons (i.e. attachment has been uploaded). See bug#12453 for more information.
    my $FieldValue = $Self->EditFieldValueGet(
        %Param,
    );

    # set values from ParamObject if present
    if ( defined $FieldValue && $FieldValue && $FieldValue->@* ) {
        $Value = $FieldValue;
    }

    if ( !ref $Value ) {
        $Value = [$Value];
    }
    elsif ( !$Value->@* ) {
        $Value = [undef];
    }

    # check and set class if necessary
    my $FieldClass = "$Self->{FieldCSSClass} DynamicFieldText Modernize";    # for field specific JS
    if ( defined $Param{Class} && $Param{Class} ne '' ) {
        $FieldClass .= ' ' . $Param{Class};
    }

    # set classes according to mandatory and acl hidden params
    if ( $Param{ACLHidden} && $Param{Mandatory} ) {
        $FieldClass .= ' Validate_Required_IfVisible';
    }
    elsif ( $Param{Mandatory} ) {
        $FieldClass .= ' Validate_Required';
    }

    # set error css class
    if ( $Param{ServerError} ) {
        $FieldClass .= ' ServerError';
    }

    my %FieldTemplateData = (
        FieldClass      => $FieldClass,
        FieldLabel      => $FieldLabelEscaped,
        FormUpdateClass => $Param{AJAXUpdate} ? 'FormUpdate' : '',
        FieldName       => $FieldName,
        Readonly        => $Param{DynamicFieldConfig}->{Readonly},
    );

    my $FieldTemplateFile = $Param{CustomerInterface}
        ?
        'DynamicField/Customer/'
        :
        'DynamicField/Agent/';

    my $PossibleValues;
    my @SelectionHTML;
    if ( $DFDetails->{EditFieldMode} eq 'AutoComplete' ) {
        $FieldTemplateFile .= 'Reference';

        # Get default agent autocomplete config.
        my $AutoCompleteConfig = $Kernel::OM->Get('Kernel::Config')->Get( 'AutoComplete::' . ( $Param{CustomerInterface} ? 'Customer' : 'Agent' ) )->{'Default'};

        $Param{LayoutObject}->AddJSData(
            Key   => 'AutoCompleteActive',
            Value => $AutoCompleteConfig->{AutoCompleteActive},
        );
    }
    else {
        $FieldTemplateFile .= 'BaseSelect';

        $PossibleValues = $Self->PossibleValuesGet(%Param);

        if ( $DFDetails->{MultiValue} ) {
            for my $ValueIndex ( 0 .. $#{$Value} ) {
                my $DataValues = $Self->BuildSelectionDataGet(
                    DynamicFieldConfig => $Param{DynamicFieldConfig},
                    PossibleValues     => $PossibleValues,
                    Value              => $Value->[$ValueIndex],
                );
                my $FieldID = $FieldName . '_' . $ValueIndex;
                push @SelectionHTML, $Param{LayoutObject}->BuildSelection(
                    Data       => $DataValues,
                    Sort       => 'AlphanumericValue',
                    Disabled   => $Param{Readonly},
                    Name       => $FieldName,
                    ID         => $FieldID,
                    SelectedID => $Value->[$ValueIndex],
                    Class      => $FieldClass . ( $Param{AJAXUpdate} ? ' FormUpdate' : '' ),
                    TreeView   => $DFDetails->{TreeView},
                    HTMLQuote  => 1,
                );
            }
        }
        else {
            my @SelectedIDs = grep {$_} $Value->@*;
            my $DataValues  = $Self->BuildSelectionDataGet(
                DynamicFieldConfig => $Param{DynamicFieldConfig},
                PossibleValues     => $PossibleValues,
                Value              => \@SelectedIDs,
            );
            push @SelectionHTML, $Param{LayoutObject}->BuildSelection(
                Data       => $DataValues,
                Sort       => 'AlphanumericValue',
                Disabled   => $Param{Readonly},
                Name       => $FieldName,
                SelectedID => \@SelectedIDs,
                Class      => $FieldClass . ( $Param{AJAXUpdate} ? ' FormUpdate' : '' ),
                TreeView   => $DFDetails->{TreeView},
                HTMLQuote  => 1,
                Multiple   => $DFDetails->{Multiselect},
            );
        }
    }

    my %Error = (
        ServerError => $Param{ServerError},
        Mandatory   => $Param{Mandatory},
    );
    my @ResultHTML;
    for my $ValueIndex ( 0 .. ( $DFDetails->{Multiselect} ? 0 : $#{$Value} ) ) {
        my $FieldID = $DFDetails->{MultiValue} ? $FieldName . '_' . $ValueIndex : $FieldName;

        if ( !$ValueIndex ) {
            if ( $Error{ServerError} ) {
                $Error{DivIDServerError} = "${FieldID}ServerError";
                $Error{ErrorMessage}     = Translatable( $Param{ErrorMessage} || 'This field is required.' );
            }
            if ( $Error{Mandatory} ) {
                $Error{DivIDMandatory}       = "${FieldID}Error";
                $Error{FieldRequiredMessage} = Translatable('This field is required.');
            }
        }

        # The actual value is the technical ID of the referenced object.
        # This might be empty e.g. in a ticket creation mask.
        my $ValueEscaped;
        my $ReferencedObjectID = $Value->[$ValueIndex];
        if ($ReferencedObjectID) {

            # The visible value depends on the referenced object
            my %Description = $Self->ObjectDescriptionGet(
                DynamicFieldConfig => $DFDetails,
                LayoutObject       => $Param{LayoutObject},
                ObjectID           => $ReferencedObjectID,
                UserID             => 1,                      # TODO: what about Permission check
            );
            $ValueEscaped = $Param{LayoutObject}->Ascii2Html(
                Text => $Description{Long},
            );
        }

        push @ResultHTML, $Param{LayoutObject}->Output(
            TemplateFile => $FieldTemplateFile,
            Data         => {
                %FieldTemplateData,
                %Error,
                FieldID       => $FieldID,
                Value         => ( $Value->[$ValueIndex] // '' ),
                ValueEscaped  => ( $ValueEscaped         // '' ),
                SelectionHTML => ( $DFDetails->{EditFieldMode} ne 'AutoComplete' ? $SelectionHTML[$ValueIndex] : undef ),
            },
        );
    }

    my $TemplateHTML;
    if ( $DFDetails->{MultiValue} && !$Param{Readonly} ) {
        $FieldTemplateData{FieldID} = $FieldName . '_Template';

        my $SelectionHTML = $Param{LayoutObject}->BuildSelection(
            Data      => $PossibleValues || {},
            Sort      => 'AlphanumericValue',
            Disabled  => $Param{Readonly},
            Name      => $FieldName,
            ID        => $FieldTemplateData{FieldID},
            Class     => $FieldClass . ( $Param{AJAXUpdate} ? ' FormUpdate' : '' ),
            TreeView  => $DFDetails->{TreeView},
            HTMLQuote => 1,
            Multiple  => $DFDetails->{Multiselect},
        );
        $TemplateHTML = $Param{LayoutObject}->Output(
            TemplateFile => $FieldTemplateFile,
            Data         => {
                %FieldTemplateData,
                SelectionHTML => ( $DFDetails->{EditFieldMode} ne 'AutoComplete' ? $SelectionHTML : undef ),
            },
        );
    }

    # write rendered value to FormCache for later usage in EditFieldValueValidate
    if ( $Value && !$Param{ServerError} ) {
        $Kernel::OM->Get('Kernel::System::Web::FormCache')->SetFormData(
            LayoutObject => $Param{LayoutObject},
            Key          => 'RenderedValue_DynamicField_' . $Param{DynamicFieldConfig}{Name},
            Value        => $Value,
        );
    }

    # call EditLabelRender on the common Driver
    my $LabelString = $Self->EditLabelRender(
        %Param,
        Mandatory => $Param{Mandatory} || '0',
        FieldName => $DFDetails->{MultiValue} ? "${FieldName}_0" : $FieldName,
    );

    my %Data = (
        Label => $LabelString,
    );

    # decide which structure to return
    if ( $DFDetails->{MultiValue} ) {
        $Data{MultiValue}         = \@ResultHTML;
        $Data{MultiValueTemplate} = $TemplateHTML;
    }
    else {
        $Data{Field} = $ResultHTML[0];
    }

    return \%Data;
}

sub GetFieldTypeSettings {
    my ( $Self, %Param ) = @_;

    # First fetch the settings from ConfigItem driver.
    my @FieldTypeSettings = $Self->SUPER::GetFieldTypeSettings(
        %Param,
    );

    # clean up settings which we will replace here
    @FieldTypeSettings = grep {
        $_->{ConfigParamName} ne 'SearchAttribute'
            && $_->{ConfigParamName} ne 'ImportSearchAttribute'
            && $_->{ConfigParamName} ne 'DisplayType'
    } @FieldTypeSettings;

    # Support configurable search key
    push @FieldTypeSettings,
        {
            ConfigParamName => 'SearchAttribute',
            Label           => Translatable('Attribute which will be searched on autocomplete'),
            Explanation     => Translatable('Select the attribute which config items will be searched by'),
            InputType       => 'Selection',
            SelectionData   => {
                'Number'        => 'Number',
                'Name'          => 'Name',
                'VersionString' => 'VersionString',
            },
            PossibleNone => 1,
            Multiple     => 0,
        };

    my $DynamicFieldsList = $Kernel::OM->Get('Kernel::System::DynamicField')->DynamicFieldList(
        ObjectType => ['ITSMConfigItem'],
        Valid      => 1,
        ResultType => 'HASH',
    );
    my %DFSelectionData = map { ( "DynamicField_$_" => "DynamicField_$_" ) } values $DynamicFieldsList->%*;

    # Support configurable import search attribute
    push @FieldTypeSettings,
        {
            ConfigParamName => 'ImportSearchAttribute',
            Label           => Translatable('External-source key'),
            Explanation     => Translatable('When set via an external source (e.g. web service or import / export), the value will be interpreted as this attribute.'),
            InputType       => 'Selection',
            SelectionData   => {
                'Name'          => 'Name',
                'Number'        => 'Number',
                'VersionString' => 'VersionString',
                %DFSelectionData,
            },
            PossibleNone => 1,
            Multiple     => 0,
        };

    # TreeView support (grouped by ConfigItems)
    push @FieldTypeSettings,
        {
            ConfigParamName => 'TreeView',
            Label           => Translatable('Tree View'),
            Explanation     => Translatable('Activate this option to display values as a tree, grouped by config items.'),
            InputType       => 'Selection',
            SelectionData   => {
                0 => Translatable('No'),
                1 => Translatable('Yes'),
            },
            PossibleNone => 0,
            Multiple     => 0,
        };

    # Support various display options
    push @FieldTypeSettings,
        {
            ConfigParamName => 'DisplayType',
            Label           => Translatable('Attribute which is displayed for values'),
            Explanation     => Translatable('Select the type of display.'),
            InputType       => 'Selection',
            SelectionData   => {
                'VersionString'                 => '<Version String>',
                'ConfigItemNumberVersionString' => '<Config Item Number>: <Version Name>',
                'ConfigItemNameVersionString'   => '<Config Item Name>: <Version Name>',
                'VersionStringConfigItemNumber' => '<Version Name>: <Config Item Number>',
                'VersionStringConfigItemName'   => '<Version Name>: <Config Item Name>',
            },
            PossibleNone => 1,
            Multiple     => 0,
        };

    return @FieldTypeSettings;
}

=head2 ObjectDescriptionGet()

return a hash of object descriptions.

    my %Description = $BackendObject->ObjectDescriptionGet(
        DynamicFieldConfig => $DynamicFieldConfig,
        ObjectID           => 123,
        UserID             => 1,
    );

Return

    %Description = (
        Normal => "CI# 1234455",
        Long   => "CI# 1234455: Need a sample config item title",
    );

=cut

sub ObjectDescriptionGet {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Argument (qw(ObjectID)) {
        if ( !$Param{$Argument} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Argument!",
            );

            return;
        }
    }

    my $ConfigItem = $Kernel::OM->Get('Kernel::System::ITSMConfigItem')->ConfigItemGet(
        VersionID => $Param{ObjectID},
        Silent    => 1,
    );

    if ( !$ConfigItem ) {
        return (
            Normal => "$Param{ObjectID} (deleted)",
            Long   => "$Param{ObjectID} (deleted)",
        );
    }

    # prepare TreeView prefix if needed
    my $TreeViewPrefix = '';
    if ( $Param{DynamicFieldConfig}{Config}{TreeView} ) {
        $TreeViewPrefix = "$ConfigItem->{Name}::";
    }

    my %Descriptions;
    if ( $Param{DynamicFieldConfig} && $Param{DynamicFieldConfig}{Config}{DisplayType} ) {

        # prepare string as configured
        my $DisplayType = $Param{DynamicFieldConfig}{Config}{DisplayType};
        if ( $DisplayType eq 'VersionString' ) {
            $Descriptions{Normal} = $TreeViewPrefix . $ConfigItem->{VersionString};
            $Descriptions{Long}   = $ConfigItem->{VersionString};
        }
        if ( $DisplayType eq 'ConfigItemNumberVersionString' ) {
            $Descriptions{Normal} = $TreeViewPrefix . "$ConfigItem->{Number}: $ConfigItem->{VersionString}";
            $Descriptions{Long}   = "$ConfigItem->{Number}: $ConfigItem->{VersionString}";
        }
        elsif ( $DisplayType eq 'ConfigItemNameVersionString' ) {
            $Descriptions{Normal} = $TreeViewPrefix . "$ConfigItem->{Name}: $ConfigItem->{VersionString}";
            $Descriptions{Long}   = "$ConfigItem->{Name}: $ConfigItem->{VersionString}";
        }
        elsif ( $DisplayType eq 'VersionStringConfigItemNumber' ) {
            $Descriptions{Normal} = $TreeViewPrefix . "$ConfigItem->{VersionString}: $ConfigItem->{Number}";
            $Descriptions{Long}   = "$ConfigItem->{VersionString}: $ConfigItem->{Number}";
        }
        elsif ( $DisplayType eq 'VersionStringConfigItemName' ) {
            $Descriptions{Normal} = $TreeViewPrefix . "$ConfigItem->{VersionString}: $ConfigItem->{Name}";
            $Descriptions{Long}   = "$ConfigItem->{VersionString}: $ConfigItem->{Name}";
        }
    }
    else {
        $Descriptions{Normal} = $TreeViewPrefix . "$ConfigItem->{VersionString}";
        $Descriptions{Long}   = "$ConfigItem->{Name}: $ConfigItem->{VersionString}";
    }

    my $Link;
    if ( $Param{Link} && $Param{LayoutObject}{SessionSource} ) {
        if ( $Param{LayoutObject}{SessionSource} eq 'AgentInterface' ) {

            # TODO: only show the link if the user $Param{UserID} has permissions
            $Link = $Param{LayoutObject}{Baselink} . "Action=AgentITSMConfigItemZoom;ConfigItemID=$ConfigItem->{ConfigItemID};VersionID=$Param{ObjectID}";
        }
        elsif ( $Param{LayoutObject}{SessionSource} eq 'CustomerInterface' ) {
            $Link = $Param{LayoutObject}{Baselink} . "Action=CustomerITSMConfigItemZoom;ConfigItemID=$ConfigItem->{ConfigItemID};VersionID=$Param{ObjectID}";
        }
    }

    # create description
    return (
        %Descriptions,
        Link => $Link,
    );
}

=head2 SearchObjects()

This is used in auto completion when searching for possible object IDs.

    my @ObjectIDs = $BackendObject->SearchObjects(
        DynamicFieldConfig => $DynamicFieldConfig,
        ObjectID           => $ObjectID,                # (optional) if given, takes precedence over Term
        Term               => $Term,                    # (optional) defaults to wildcard search with empty string
        MaxResults         => $MaxResults,
        UserID             => 1,
        Object             => {
            %Data,
        },
        ParamObject        => $ParamObject,
    );

=cut

sub SearchObjects {
    my ( $Self, %Param ) = @_;

    $Param{Term} //= '';

    my $DFDetails = $Param{DynamicFieldConfig}{Config} // {};

    my %SearchParams;

    if ( $Param{ObjectID} ) {
        $SearchParams{ConfigItemID} = $Param{ObjectID};
    }
    elsif ( $Param{ExternalSource} ) {

        # include configured search param if present
        my $SearchAttribute = $DFDetails->{ImportSearchAttribute} || 'Name';

        $SearchParams{$SearchAttribute} = "$Param{Term}";
    }
    else {

        # include configured search param if present
        my $SearchAttribute = $DFDetails->{SearchAttribute} || 'Name';

        $SearchParams{$SearchAttribute} = "*$Param{Term}*";
    }

    # prepare mapping of edit mask attribute names
    my %AttributeNameMapping = (
        CustomerUser => [

            # AgentTicketEmail
            'From',

            # AgentTicketPhone
            'SelectedCustomerUser',
        ],
        ResponsibleID => [
            'NewResponsibleID',
        ],
        OwnerID => [
            'NewOwnerID',
            'NewUserID',
        ],
        QueueID => [
            'Dest',
            'NewQueueID',
        ],
        StateID => [
            'NewStateID',
            'NextStateID',
        ],
        PriorityID => [
            'NewPriorityID',
        ],
    );

    # incorporate referencefilterlist into search params
    if ( IsArrayRefWithData( $DFDetails->{ReferenceFilterList} ) && !$Param{ExternalSource} ) {
        FILTERITEM:
        for my $FilterItem ( $DFDetails->{ReferenceFilterList}->@* ) {

            # map ID to IDs if necessary
            my $AttributeName = $FilterItem->{ReferenceObjectAttribute};
            if ( any { $_ eq $AttributeName } qw(QueueID TypeID StateID PriorityID ServiceID SLAID OwnerID ResponsibleID ) ) {
                $AttributeName .= 's';
            }

            # check filter config
            next FILTERITEM unless $FilterItem->{ReferenceObjectAttribute};
            next FILTERITEM unless ( $FilterItem->{EqualsObjectAttribute} || $FilterItem->{EqualsString} );

            if ( $FilterItem->{EqualsObjectAttribute} ) {

                # don't perform search if object attribute to search for is empty
                my $EqualsObjectAttribute;
                if ( IsHashRefWithData( $Param{Object} ) ) {
                    $EqualsObjectAttribute = $Param{Object}{DynamicField}{ $FilterItem->{EqualsObjectAttribute} } // $Param{Object}{ $FilterItem->{EqualsObjectAttribute} };
                }
                elsif ( defined $Param{ParamObject} ) {
                    if ( $FilterItem->{EqualsObjectAttribute} =~ /^DynamicField_(?<DFName>\S+)/ ) {
                        my $FilterItemDFConfig = $Kernel::OM->Get('Kernel::System::DynamicField')->DynamicFieldGet(
                            Name => $+{DFName},
                        );
                        next FILTERITEM unless IsHashRefWithData($FilterItemDFConfig);
                        $EqualsObjectAttribute = $Kernel::OM->Get('Kernel::System::DynamicField::Backend')->EditFieldValueGet(
                            ParamObject        => $Param{ParamObject},
                            DynamicFieldConfig => $FilterItemDFConfig,
                            TransformDates     => 0,
                        );
                    }
                    else {

                        # match standard ticket attribute names with edit mask attribute names
                        my @ParamNames = $Param{ParamObject}->GetParamNames;

                        # check if attribute name itself is in params
                        # NOTE trying attribute itself is crucially important in case of QueueID
                        #   because AgentTicketPhone does not provide QueueID, but puts the id in
                        #   Dest, and AgentTicketEmail leaves Dest as a string but puts the id in QueueID
                        my ($ParamName) = grep { $_ eq $FilterItem->{EqualsObjectAttribute} } @ParamNames;

                        # if not, try to find a mapped attribute name
                        if ( !$ParamName ) {

                            # check if mapped attribute names exist at all
                            my $MappedAttributes = $AttributeNameMapping{ $FilterItem->{EqualsObjectAttribute} };
                            if ( ref $MappedAttributes eq 'ARRAY' ) {

                                MAPPEDATTRIBUTE:
                                for my $MappedAttribute ( $MappedAttributes->@* ) {
                                    ($ParamName) = grep { $_ eq $MappedAttribute } @ParamNames;

                                    last MAPPEDATTRIBUTE if $ParamName;
                                }
                            }
                        }

                        return unless $ParamName;

                        $EqualsObjectAttribute = $Param{ParamObject}->GetParam( Param => $ParamName );

                        # when called by AgentReferenceSearch, Dest is a string and we need to extract the QueueID
                        if ( $ParamName eq 'Dest' ) {
                            my $QueueID = '';
                            if ( $EqualsObjectAttribute =~ /^(\d{1,100})\|\|.+?$/ ) {
                                $QueueID = $1;
                            }
                            $EqualsObjectAttribute = $QueueID;
                        }
                    }
                }

                # ensure that for EqualsObjectAttribute UserID always $Self->{UserID} is used in the end
                if ( $FilterItem->{EqualsObjectAttribute} eq 'UserID' ) {
                    $EqualsObjectAttribute = $Param{UserID};
                }

                return unless $EqualsObjectAttribute;
                return if ( ref $EqualsObjectAttribute eq 'ARRAY' && !$EqualsObjectAttribute->@* );

                # config item attribute
                if ( $FilterItem->{ReferenceObjectAttribute} =~ m{^Con}i ) {
                    $SearchParams{$AttributeName} = $EqualsObjectAttribute;
                }

                # dynamic field attribute
                elsif ( $FilterItem->{ReferenceObjectAttribute} =~ m{^Dyn}i ) {
                    $SearchParams{$AttributeName} = {
                        Equals => $EqualsObjectAttribute,
                    };
                }

                # array attribute
                else {
                    $SearchParams{$AttributeName} = [$EqualsObjectAttribute];
                }
            }
            elsif ( $FilterItem->{EqualsString} ) {

                # config item attribute
                # TODO check if this has to be adapted for ticket search
                if ( $FilterItem->{ReferenceObjectAttribute} =~ m{^Con}i ) {
                    $SearchParams{$AttributeName} = $FilterItem->{EqualsString};
                }

                # dynamic field attribute
                elsif ( $FilterItem->{ReferenceObjectAttribute} =~ m{^Dyn}i ) {
                    $SearchParams{$AttributeName} = {
                        Equals => $FilterItem->{EqualsString},
                    };
                }

                # array attribute
                else {
                    $SearchParams{$AttributeName} = [ $FilterItem->{EqualsString} ];
                }
            }
        }
    }

    # Support restriction by class
    if ( IsArrayRefWithData( $DFDetails->{ClassIDs} ) && !$Param{ExternalSource} ) {
        if ( $SearchParams{ClassIDs} ) {
            my @ClassIDs;
            for my $ClassID ( $SearchParams{ClassIDs}->@* ) {
                if ( any { $_ eq $ClassID } $DFDetails->{ClassIDs}->@* ) {
                    push @ClassIDs, $ClassID;
                }
            }

            return unless @ClassIDs;

            $SearchParams{ClassIDs} = \@ClassIDs;
        }
        else {
            $SearchParams{ClassIDs} = $DFDetails->{ClassIDs};
        }
    }

    # Support restriction by deployment state
    if ( IsArrayRefWithData( $DFDetails->{DeplStateIDs} ) ) {
        if ( $SearchParams{DeplStateIDs} ) {
            my @DeploymentStateIDs;
            for my $DeploymentStateID ( $SearchParams{DeplStateIDs}->@* ) {
                if ( any { $_ eq $DeploymentStateID } $DFDetails->{DeplStateIDs}->@* ) {
                    push @DeploymentStateIDs, $DeploymentStateID;
                }
            }

            return unless @DeploymentStateIDs;

            $SearchParams{DeplStateIDs} = \@DeploymentStateIDs;
        }
        else {
            $SearchParams{DeplStateIDs} = $DFDetails->{DeplStateIDs};
        }
    }

    # get a list of config item IDs
    my $ConfigItemObject = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');
    my $ConfigItemIDs    = $ConfigItemObject->VersionSearch(
        Limit            => $Param{MaxResults},
        Result           => 'ARRAY',
        OrderBy          => ['Number'],
        OrderByDirection => ['Down'],
        %SearchParams,
    );
    return unless IsArrayRefWithData($ConfigItemIDs);

    # actually store latest version ID
    my @VersionIDs;
    for my $ConfigItemID ( $ConfigItemIDs->@* ) {
        my $VersionList = $ConfigItemObject->VersionList(
            ConfigItemID => $ConfigItemID,
        );

        if ( IsArrayRefWithData($VersionList) ) {
            push @VersionIDs, $VersionList->@*;
        }
    }

    return @VersionIDs;
}

=head2 ValueForLens()

this method returns the passed value unchanged. It is only implemented so that
the implementation from the parent class C<Kernel::System::DynamicField::Driver::ITSMConfigItemReference> is not used.

=cut

sub ValueForLens {
    my ( $Self, %Param ) = @_;

    return $Param{Value};
}

1;

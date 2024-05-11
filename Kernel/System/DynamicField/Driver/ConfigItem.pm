# --
# OTOBO is a web-based ticketing system for service organisations.
# --
# Copyright (C) 2001-2020 OTRS AG, https://otrs.com/
# Copyright (C) 2019-2024 Rother OSS GmbH, https://otobo.de/
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

package Kernel::System::DynamicField::Driver::ConfigItem;

## nofilter(TidyAll::Plugin::OTOBO::Perl::ParamObject)

use v5.24;
use strict;
use warnings;
use namespace::autoclean;
use utf8;

use parent qw(Kernel::System::DynamicField::Driver::BaseReference);

# core modules
use List::Util qw(any);

# CPAN modules

# OTOBO modules
use Kernel::Language              qw(Translatable);
use Kernel::System::VariableCheck qw(IsArrayRefWithData IsHashRefWithData);

our @ObjectDependencies = (
    'Kernel::Config',
    'Kernel::System::DynamicField',
    'Kernel::System::DynamicField::Backend',
    'Kernel::System::Log',
    'Kernel::System::GeneralCatalog',
    'Kernel::System::LinkObject',
    'Kernel::System::ITSMConfigItem',
);

=head1 NAME

Kernel::System::DynamicField::Driver::ConfigItem - backend for the Reference dynamic field

=head1 DESCRIPTION

ITSMConfigItem backend for the Reference dynamic field.

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
        'IsSetCapable'                 => 1,
        'SetsDynamicContent'           => 1,
    };

    $Self->{ReferencedObjectType} = 'ITSMConfigItem';

    return $Self;
}

=head2 ValueGet()

This method contains special support for the case of Lenses. A Lens operates directly on dynamic field of an specific object.
The specific object is usually identified by the value of the Reference dynamic field. But there is at least one special case.
When the reference is to an C<ITSMConfigItem> then the relevant ID is the ID of the last version. This case is handled
when the parameter C<ForLens> is passed.

=cut

sub ValueGet {
    my ( $Self, %Param ) = @_;

    # get the value from the parent class
    my $Value = $Self->SUPER::ValueGet(%Param);

    # special handling only for Lens
    return $Value unless $Param{ForLens};

    # for usage in lenses we might have to interpret the values to be usable for their ValueGet()
    return $Self->ValueForLens( Value => $Value );
}

sub EditFieldValueGet {
    my ( $Self, %Param ) = @_;

    # get the value from the parent class
    my $Value = $Self->SUPER::EditFieldValueGet(%Param);

    # for this field the normal return an the ReturnValueStructure are the same
    return $Value unless $Param{ForLens};

    # for usage in lenses we might have to interpret the values to be usable for their ValueGet()
    return $Self->ValueForLens( Value => $Value );
}

=head2 GetFieldTypeSettings()

Get the field type settings for the referenced object type C<ITSMConfigItem>.
The generic settings for all referenced object types are included as well.

=cut

sub GetFieldTypeSettings {
    my ( $Self, %Param ) = @_;

    my $ReferencingObjectType = $Param{ObjectType};

    # First fetch the generic settings.
    my @FieldTypeSettings = $Self->SUPER::GetFieldTypeSettings(
        %Param,
    );

    # Add the selection of the config item class.
    {
        my $ClassID2Name = $Kernel::OM->Get('Kernel::System::GeneralCatalog')->ItemList(
            Class => 'ITSM::ConfigItem::Class',
        );

        push @FieldTypeSettings,
            {
                ConfigParamName => 'ClassIDs',
                Label           => Translatable('Class restrictions for the config item'),
                Explanation     => Translatable('Select one or more classes to restrict selectable config items'),
                InputType       => 'Selection',
                SelectionData   => $ClassID2Name,
                PossibleNone    => 0,                                                                                # the class is required
                Multiple        => 1,
            };
    }

    # Select the link type.
    # The same link types as with the generic LinkObject feature are available.
    # The direction can be selected in a separate dropdown.
    # No distinction is made between the object types ITSMConfigItem  and ITSMConfigItemVersion.
    {
        my $LinkObject = $Kernel::OM->Get('Kernel::System::LinkObject');

        # Create the selectable type list from the possible types from the SysConfig.
        my @SelectionData;

        # get possible types list,
        # actually the order of Object1 and Object2 is not relevant
        my $Object1           = $ReferencingObjectType        =~ s/^ITSMConfigItemVersion$/ITSMConfigItem/r;
        my $Object2           = $Self->{ReferencedObjectType} =~ s/^ITSMConfigItemVersion$/ITSMConfigItem/r;
        my %PossibleTypesList = $LinkObject->PossibleTypesList(
            Object1 => $Object1,    # the entity that holds the Reference dynamic field can be a config item or a ticket
            Object2 => $Object2,    # the referenced object
        );

        POSSIBLETYPE:
        for my $PossibleType ( sort { lc $a cmp lc $b } keys %PossibleTypesList ) {

            # look up type id,
            # insert the name into the table link_type if it does not exist yet
            my $TypeID = $LinkObject->TypeLookup(
                Name   => $PossibleType,
                UserID => 1,               # TODO: get the actual id of the current user
            );

            # get type
            my %Type = $LinkObject->TypeGet(
                TypeID => $TypeID,
                UserID => $Self->{UserID},
            );

            push @SelectionData,
                {
                    Key   => $PossibleType,
                    Value => "$Type{SourceName} -> $Type{TargetName}",
                };
        }

        # TODO: saner grouping, and saner ordering
        push @FieldTypeSettings,
            {
                InputType       => 'Selection',
                ConfigParamName => 'LinkType',
                Label           => Translatable('Link type'),
                Explanation     => Translatable('Select the link type.'),
                SelectionData   => \@SelectionData,
                PossibleNone    => 1,
            };
    }

    # Select the link direction
    {
        my @SelectionData = (
            {
                Key   => 'ReferencingIsSource',
                Value => Translatable('Forwards: Referencing (Source) -> Referenced (Target)'),
            },
            {
                Key   => 'ReferencingIsTarget',
                Value => Translatable('Backwards: Referenced (Source) -> Referencing (Target)'),
            },
        );

        push @FieldTypeSettings,
            {
                ConfigParamName => 'LinkDirection',
                Label           => Translatable('Link Direction'),
                Explanation     =>
                Translatable('The referencing object is the one containing this dynamic field, the referenced object is the one selected as value of the dynamic field.'),
                InputType     => 'Selection',
                SelectionData => \@SelectionData,
                DefaultKey    => 'ReferencingIsSource',
                PossibleNone  => 0,
            };
    }

    # Select the link referencing type
    if ( $ReferencingObjectType =~ m/^ITSMConfigItem/ ) {
        my @SelectionData = (
            {
                Key   => 'Dynamic',
                Value => Translatable('Dynamic (ConfigItem)'),
            },
            {
                Key   => 'Static',
                Value => Translatable('Static (Version)'),
            },
        );

        push @FieldTypeSettings,
            {
                ConfigParamName => 'LinkReferencingType',
                Label           => Translatable('Link Referencing Type'),
                Explanation     => Translatable(
                'Whether this link applies to the ConfigItem or the static version of the referencing object. Current Incident State calculation only is performed on dynamic links.'
                ),
                InputType     => 'Selection',
                SelectionData => \@SelectionData,
                DefaultKey    => 'Dynamic',
                PossibleNone  => 0,
            };
    }

    # Support configurable search key
    push @FieldTypeSettings,
        {
            ConfigParamName => 'SearchAttribute',
            Label           => Translatable('Attribute which will be searched on autocomplete'),
            Explanation     => Translatable('Select the attribute which config items will be searched by'),
            InputType       => 'Selection',
            SelectionData   => {
                'Number' => 'Number',
                'Name'   => 'Name',
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
                'Name'   => 'Name',
                'Number' => 'Number',
                %DFSelectionData,
            },
            PossibleNone => 1,
            Multiple     => 0,
        };

    # Support various display options
    push @FieldTypeSettings,
        {
            ConfigParamName => 'DisplayType',
            Label           => Translatable('Attribute which is displayed for values'),
            Explanation     => Translatable('Select the type of display'),
            InputType       => 'Selection',
            SelectionData   => {
                'ConfigItemNumber'      => '<Config Item Number>',
                'ConfigItemName'        => '<Config Item Name>',
                'ClassConfigItemNumber' => '<Class Name>: <Config Item Number>',
                'ClassConfigItemName'   => '<Class Name>: <Config Item Name>',
            },
            PossibleNone => 1,
            Multiple     => 0,
        };

    # Support reference filters
    push @FieldTypeSettings,
        {
            ConfigParamName => 'ReferenceFilterList',
        };

    return @FieldTypeSettings;
}

=head2 ObjectPermission()

checks read permission for a given object and UserID.

    $Permission = $BackendObject->ObjectPermission(
        Key     => 123,
        UserID  => 1,
    );

=cut

sub ObjectPermission {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Argument (qw(Key UserID)) {
        if ( !$Param{$Argument} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Argument!",
            );

            return;
        }
    }

    return $Kernel::OM->Get('Kernel::System::ITSMConfigItem')->Permission(
        Scope  => 'Item',
        ItemID => $Param{Key},
        UserID => $Param{UserID},
        Type   => 'ro',
    );
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
        ConfigItemID => $Param{ObjectID},
    );

    return unless $ConfigItem;

    my %Descriptions;
    if ( $Param{DynamicFieldConfig} && $Param{DynamicFieldConfig}{Config}{DisplayType} ) {

        # prepare string as configured
        my $DisplayType = $Param{DynamicFieldConfig}{Config}{DisplayType};
        if ( $DisplayType eq 'ConfigItemNumber' ) {
            $Descriptions{Normal} = "$ConfigItem->{ConfigItemNumber}";
            $Descriptions{Long}   = "$ConfigItem->{ConfigItemNumber}";
        }
        elsif ( $DisplayType eq 'ConfigItemName' ) {
            $Descriptions{Normal} = "$ConfigItem->{Name}";
            $Descriptions{Long}   = "$ConfigItem->{Name}";
        }
        elsif ( $DisplayType eq 'ClassConfigItemNumber' ) {
            $Descriptions{Normal} = "$ConfigItem->{Class}: $ConfigItem->{Number}";
            $Descriptions{Long}   = "$ConfigItem->{Class}: $ConfigItem->{Number}";
        }
        elsif ( $DisplayType eq 'ClassConfigItemName' ) {
            $Descriptions{Normal} = "$ConfigItem->{Class}: $ConfigItem->{Name}";
            $Descriptions{Long}   = "$ConfigItem->{Class}: $ConfigItem->{Name}";
        }
    }
    else {
        $Descriptions{Normal} = "$ConfigItem->{Name}";
        $Descriptions{Long}   = "$ConfigItem->{Class}: $ConfigItem->{Name}";
    }

    my $Link;
    if ( $Param{Link} && $Param{LayoutObject}{SessionSource} ) {
        if ( $Param{LayoutObject}{SessionSource} eq 'AgentInterface' ) {

            # TODO: only show the link if the user $Param{UserID} has permissions
            $Link = $Param{LayoutObject}{Baselink} . "Action=AgentITSMConfigItemZoom;ConfigItemID=$Param{ObjectID}";
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

    my $DFDetails = $Param{DynamicFieldConfig}->{Config} // {};

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
            'To',
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

            # map ID to IDs if neccessary
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

    # return a list of config item IDs
    return $Kernel::OM->Get('Kernel::System::ITSMConfigItem')->ConfigItemSearch(
        Limit   => $Param{MaxResults},
        Result  => 'ARRAY',
        SortBy  => 'Number',
        OrderBy => 'Down',
        %SearchParams,
    );
}

=head2 ValueForLens()

return the current last version ids used in dynamic_field_value.
The passed in value is a list of config item IDs. These IDs are
transformed into the respective last version IDs.

    my $Value = $BackendObject->ValueForLens(
        Value => [17,17,19,20],
    );

=cut

sub ValueForLens {
    my ( $Self, %Param ) = @_;

    return if !$Param{Value};

    if ( ref $Param{Value} ne 'ARRAY' ) {
        $Param{Value} = [ $Param{Value} ];
    }

    my @LastVersionIDs;
    CONFIG_ITEM_ID:
    for my $ConfigItemID ( $Param{Value}->@* ) {
        my $ConfigItem = $Kernel::OM->Get('Kernel::System::ITSMConfigItem')->ConfigItemGet(
            ConfigItemID => $ConfigItemID,
        );

        # only valid IDs
        next CONFIG_ITEM_ID unless $ConfigItem;
        next CONFIG_ITEM_ID unless $ConfigItem->{LastVersionID};

        push @LastVersionIDs, $ConfigItem->{LastVersionID};
    }

    return \@LastVersionIDs;
}

1;

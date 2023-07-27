# --
# OTOBO is a web-based ticketing system for service organisations.
# --
# Copyright (C) 2001-2020 OTRS AG, https://otrs.com/
# Copyright (C) 2019-2023 Rother OSS GmbH, https://otobo.de/
# --
# $origin: otobo - 8fb09f1a854199ebe93c21ed7ae689b248ef264e - Kernel/Modules/AdminDynamicField.pm
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

package Kernel::Modules::AdminDynamicField;

use v5.24;
use strict;
use warnings;
use namespace::autoclean;
use utf8;

# core modules

# CPAN modules

# OTOBO modules
use Kernel::System::VariableCheck qw(:all);
use Kernel::Language qw(Translatable);
use Kernel::System::CheckItem;

our $ObjectManagerDisabled = 1;

sub new {
    my ( $Type, %Param ) = @_;

    return bless {%Param}, $Type;
}

sub Run {
    my ( $Self, %Param ) = @_;

    if ( $Self->{Subaction} eq 'DynamicFieldDelete' ) {

        # challenge token check for write action
        $Kernel::OM->Get('Kernel::Output::HTML::Layout')->ChallengeTokenCheck();

        return $Self->_DynamicFieldDelete(
            %Param,
        );
    }

# Rother OSS / ITSMConfigurationManagement
    elsif ( $Self->{Subaction} eq 'ITSMConfigItemVersionUpdate' ) {

        # challenge token check for write action
        $Kernel::OM->Get('Kernel::Output::HTML::Layout')->ChallengeTokenCheck();

        if ( !$Kernel::OM->Get('Kernel::System::ITSMConfigItem')->DefinitionSync() ) {
            return $Kernel::OM->Get('Kernel::Output::HTML::Layout')->ErrorScreen(
                Message => Translatable('Error synchronizing the definitions. Please check the log.'),
            );
        }
    }
# EO ITSMConfigurationManagement

    return $Self->_ShowOverview(
        %Param,
        Action => 'Overview',
    );
}

# AJAX sub-action
sub _DynamicFieldDelete {
    my ( $Self, %Param ) = @_;

    my $ParamObject = $Kernel::OM->Get('Kernel::System::Web::Request');
    my $LogObject   = $Kernel::OM->Get('Kernel::System::Log');

    my $Confirmed = $ParamObject->GetParam( Param => 'Confirmed' );

    if ( !$Confirmed ) {
        $LogObject->Log(
            'Priority' => 'error',
            'Message'  => "Need 'Confirmed'!",
        );
        return;
    }

    my $ID = $ParamObject->GetParam( Param => 'ID' );

    my $DynamicFieldObject = $Kernel::OM->Get('Kernel::System::DynamicField');
    my $DynamicFieldConfig = $DynamicFieldObject->DynamicFieldGet(
        ID => $ID,
    );

    if ( !IsHashRefWithData($DynamicFieldConfig) ) {
        $LogObject->Log(
            'Priority' => 'error',
            'Message'  => "Could not find DynamicField $ID!",
        );
        return;
    }

    if ( $DynamicFieldConfig->{InternalField} ) {
        $LogObject->Log(
            'Priority' => 'error',
            'Message'  => "Could not delete internal DynamicField $ID!",
        );
        return;
    }

    my $ValuesDeleteSuccess = $Kernel::OM->Get('Kernel::System::DynamicField::Backend')->AllValuesDelete(
        DynamicFieldConfig => $DynamicFieldConfig,
        UserID             => $Self->{UserID},
    );

    my $Success;

    if ($ValuesDeleteSuccess) {
        $Success = $DynamicFieldObject->DynamicFieldDelete(
            ID     => $ID,
            UserID => $Self->{UserID},
        );
    }

    # encoding does not matter, as $Success is either undef or an integer
    return $Kernel::OM->Get('Kernel::Output::HTML::Layout')->Attachment(
        ContentType => 'text/html',
        Content     => $Success,
        Type        => 'inline',
        NoCache     => 1,
    );
}

sub _ShowOverview {
    my ( $Self, %Param ) = @_;

    my $LayoutObject       = $Kernel::OM->Get('Kernel::Output::HTML::Layout');
    my $ConfigObject       = $Kernel::OM->Get('Kernel::Config');
    my $DynamicFieldObject = $Kernel::OM->Get('Kernel::System::DynamicField');
    my $FieldTypeConfig    = $ConfigObject->Get('DynamicFields::Driver');
    my $ObjectTypeFilter   = $Kernel::OM->Get('Kernel::System::Web::Request')->GetParam( Param => 'ObjectType' ) || '';
    my $NamespaceFilter    = $Kernel::OM->Get('Kernel::System::Web::Request')->GetParam( Param => 'Namespace' )  || '';

    my $Output = join '',
        $LayoutObject->Header,
        $LayoutObject->NavigationBar;

# Rother OSS / ITSMConfigurationManagement
    my %CIDefinitionsOutOfSync = $Kernel::OM->Get('Kernel::System::ITSMConfigItem')->DefinitionNeedSync();

    if ( %CIDefinitionsOutOfSync ) {
        my $CISynchronizeMessage = Translatable(
            'You have ITSMConfigItem definitions which are not synchronized. Please deploy your ITSMConfigItem dynamic field changes.'
        );

        $Output .= $LayoutObject->Notify(
            Info => $CISynchronizeMessage,
        );
    }
# EO ITSMConfigurationManagement

    # check for possible order collisions or gaps
    my $OrderSuccess = $DynamicFieldObject->DynamicFieldOrderCheck();
    if ( !$OrderSuccess ) {
        return $Self->_DynamicFieldOrderReset(
            %Param,
        );
    }

    # call all needed template blocks
    $LayoutObject->Block(
        Name => 'Main',
        Data => {
            %Param,
        }
    );

    if ( !IsHashRefWithData($FieldTypeConfig) ) {
        return $LayoutObject->ErrorScreen(
            Message => Translatable('Fields configuration is not valid'),
        );
    }

    # get the field types (backends) and its config dialogs
    my %FieldTypes;
    my %FieldDialogs;
    FIELDTYPE:
    for my $FieldType ( sort keys %{$FieldTypeConfig} ) {

        next FIELDTYPE if !$FieldTypeConfig->{$FieldType};
        next FIELDTYPE if $FieldTypeConfig->{$FieldType}->{DisabledAdd};

        # add the field type to the list
        $FieldTypes{$FieldType} = $FieldTypeConfig->{$FieldType}->{DisplayName};

        # get the config dialog
        $FieldDialogs{$FieldType} = $FieldTypeConfig->{$FieldType}->{ConfigDialog};
    }

    my $ObjectTypeConfig = $ConfigObject->Get('DynamicFields::ObjectType');
    my $Namespaces       = $ConfigObject->Get('DynamicField::Namespaces');

    if ( !IsHashRefWithData($ObjectTypeConfig) ) {
        return $LayoutObject->ErrorScreen(
            Message => Translatable('Objects configuration is not valid'),
        );
    }

    # make ObjectTypeConfig local variable to proper sorting
    my %ObjectTypeConfig = %{$ObjectTypeConfig};

    # cycle thought all objects to create the select add field selects
    my @ObjectTypes;
    my %ObjectTypesTranslated;

    OBJECTTYPE:
    for my $ObjectType (
        sort {
            ( int $ObjectTypeConfig{$a}->{Prio} || 0 ) <=> ( int $ObjectTypeConfig{$b}->{Prio} || 0 )
        } keys %ObjectTypeConfig
        )
    {
        next OBJECTTYPE unless $ObjectTypeConfig->{$ObjectType};

        my $SelectName = $ObjectType . 'DynamicField';

        my @FieldList = map {
            {
                Key   => $_,
                Value => $FieldTypes{$_}
            }
        } sort grep { $_ ne 'Reference' } keys %FieldTypes;

        for my $Field (@FieldList) {

            if ( !$ConfigObject->Get("Frontend::Module")->{ $FieldDialogs{ $Field->{Key} } } ) {
                $Field->{Disabled} = 1;
            }
        }

        # This is a workaround for Reference dynamic fields.
        # We want a entry for each of the possible referenced object types.
        # E.g. Ticket, ITSMConfigItem, ITSMConfigItemVersion.
        # The list of referenced object types may come from several XML-files,
        # therefore we assemble the complete list from several smaller lists.
        # Sorting is handled by TreeView.
        # The Key must be unique as otherwise the JS handler becomes confused.
        if ( $FieldTypes{Reference} && $FieldTypeConfig->{Reference}->{ReferencedObjectTypes} ) {
            for my $Types ( values $FieldTypeConfig->{Reference}->{ReferencedObjectTypes}->%* ) {
                for my $Type ( $Types->@* ) {
                    push @FieldList,
                        {
                            Key   => join( '::', 'Reference', $Type ),
                            Value => join( '::', 'Reference', $Type ),
                        };
                }
            }
        }

        # create the Add Dynamic Field select
        my $AddDynamicFieldStrg = $LayoutObject->BuildSelection(
            Data          => \@FieldList,
            Name          => $SelectName,
            PossibleNone  => 1,
            Translation   => 1,
            Sort          => 'AlphanumericValue',
            SelectedValue => '-',
            TreeView      => 1,
            Class         => 'Modernize W75pc',
        );

        # This is a workaround for Reference dynamic fields.
        # Inject additional data into the option tag.
        # E.g. <option value="Reference::ITSMConfigItem" data-referenced_object_type="ITSMConfigItem">&nbsp;&nbsp;ITSMConfigItem</option>
        # See https://www.w3schools.com/tags/att_data-.asp
        $AddDynamicFieldStrg =~ s[ (value="Reference::(\w+)")>][ $1 data-referenced_object_type="$2">]g;

        my $ObjectTypeName = $Kernel::OM->Get('Kernel::Config')->Get('DynamicFields::ObjectType')
            ->{$ObjectType}->{DisplayName} || $ObjectType;

        push @ObjectTypes, $ObjectType;

        if ( $ObjectTypeName ne 'Article' ) {
            $ObjectTypesTranslated{$ObjectType} = $LayoutObject->{LanguageObject}->Translate($ObjectTypeName);
        }

        # call ActionAddDynamicField block
        $LayoutObject->Block(
            Name => 'ActionAddDynamicField',
            Data => {
                %Param,
                AddDynamicFieldStrg => $AddDynamicFieldStrg,
                ObjectType          => $ObjectType,
                ObjectTypeName      => $ObjectTypeName,
                SelectName          => $SelectName,
            },
        );
# Rother OSS / ITSMConfigurationManagement
        if ( $ObjectTypeName eq 'ITSM ConfigItem' && %CIDefinitionsOutOfSync ) {
            $LayoutObject->Block(
                Name => 'ActionDynamicFieldExtra',
                Data => {
                    Action      => 'AdminDynamicField',
                    Subaction   => 'ITSMConfigItemVersionUpdate',
                    Text        => 'Sync CI Definitions',
                    Description => 'Deploy dynamic field changes: Add new definitions for all affected ITSMConfigItem classes.',
                },
            );
        }
# EO ITSMConfigurationManagement
    }

    my $DynamicFieldObjectStrg = $LayoutObject->BuildSelection(
        Data         => \%ObjectTypesTranslated,
        Name         => 'DynamicFieldObjectType',
        PossibleNone => 1,
        Sort         => 'AlphanumericValue',
        SelectedID   => $ObjectTypeFilter,
        Class        => 'Modernize W95pc',
    );

    $LayoutObject->Block(
        Name => 'DynamicFieldObjectType',
        Data => {
            %Param,
            DynamicFieldObjectStrg => $DynamicFieldObjectStrg,
        },
    );

    if ( IsArrayRefWithData($Namespaces) ) {
        my $DynamicFieldNamespaceStrg = $LayoutObject->BuildSelection(
            Data         => $Namespaces,
            Name         => 'DynamicFieldNamespace',
            PossibleNone => 1,
            Sort         => 'AlphanumericValue',
            SelectedID   => $NamespaceFilter,
            Class        => 'Modernize W95pc',
        );

        $LayoutObject->Block(
            Name => 'DynamicFieldNamespace',
            Data => {
                %Param,
                DynamicFieldNamespaceStrg => $DynamicFieldNamespaceStrg,
            },
        );
    }

    # send data to JS
    $LayoutObject->AddJSData(
        Key   => 'ObjectTypes',
        Value => \@ObjectTypes
    );

    # send data to JS
    $LayoutObject->AddJSData(
        Key   => 'DynamicFields',
        Value => \%FieldDialogs
    );

    # call hint block
    $LayoutObject->Block(
        Name => 'Hint',
        Data => \%Param,
    );

    # merge Ticket and Article into one type
    my $ObjectTypeFilterArrayRef;
    if ( $ObjectTypeFilter eq 'Ticket' ) {
        $ObjectTypeFilterArrayRef = [ 'Ticket', 'Article' ];
    }
    else {
        $ObjectTypeFilterArrayRef = $ObjectTypeFilter ? [$ObjectTypeFilter] : undef;
    }

    # get dynamic fields list
    my $DynamicFieldsList = $DynamicFieldObject->DynamicFieldList(
        ObjectType => $ObjectTypeFilterArrayRef,
        Namespace  => $NamespaceFilter,
        Valid      => 0,
    );

    # print the list of dynamic fields
    $Self->_DynamicFieldsListShow(
        DynamicFields => $DynamicFieldsList,
        Total         => scalar @{$DynamicFieldsList},
    );

    $Output .= $LayoutObject->Output(
        TemplateFile => 'AdminDynamicField',
        Data         => {
            %Param,
        },
    );

    $Output .= $LayoutObject->Footer();
    return $Output;
}

sub _DynamicFieldsListShow {
    my ( $Self, %Param ) = @_;

    my $LayoutObject    = $Kernel::OM->Get('Kernel::Output::HTML::Layout');
    my $FieldTypeConfig = $Kernel::OM->Get('Kernel::Config')->Get('DynamicFields::Driver');

    # check start option, if higher than fields available, set
    # it to the last field page
    my $StartHit = $Kernel::OM->Get('Kernel::System::Web::Request')->GetParam( Param => 'StartHit' ) || 1;

    # get personal page shown count
    my $PageShownPreferencesKey = 'AdminDynamicFieldsOverviewPageShown';
    my $PageShown               = $Self->{$PageShownPreferencesKey} || 35;
    my $Group                   = 'DynamicFieldsOverviewPageShown';

    # get data selection
    my %Data;
    my $Config = $Kernel::OM->Get('Kernel::Config')->Get('PreferencesGroups');
    if ( $Config && $Config->{$Group} && $Config->{$Group}->{Data} ) {
        %Data = %{ $Config->{$Group}->{Data} };
    }

    # calculate max. shown per page
    if ( $StartHit > $Param{Total} ) {
        my $Pages = int( ( $Param{Total} / $PageShown ) + 0.99999 );
        $StartHit = ( ( $Pages - 1 ) * $PageShown ) + 1;
    }

    # build nav bar
    my $Limit   = $Param{Limit} || 20_000;
    my %PageNav = $LayoutObject->PageNavBar(
        Limit     => $Limit,
        StartHit  => $StartHit,
        PageShown => $PageShown,
        AllHits   => $Param{Total} || 0,
        Action    => 'Action=' . $LayoutObject->{Action},
        Link      => $Param{LinkPage},
        IDPrefix  => $LayoutObject->{Action},
    );

    # build shown dynamic fields per page
    $Param{RequestedURL}    = "Action=$Self->{Action}";
    $Param{Group}           = $Group;
    $Param{PreferencesKey}  = $PageShownPreferencesKey;
    $Param{PageShownString} = $LayoutObject->BuildSelection(
        Name        => $PageShownPreferencesKey,
        SelectedID  => $PageShown,
        Translation => 0,
        Data        => \%Data,
        Sort        => 'NumericValue',
        Class       => 'Modernize',
    );

    if (%PageNav) {
        $LayoutObject->Block(
            Name => 'OverviewNavBarPageNavBar',
            Data => \%PageNav,
        );

        $LayoutObject->Block(
            Name => 'ContextSettings',
            Data => { %PageNav, %Param, },
        );
    }

    # check if at least 1 dynamic field is registered in the system
    if ( $Param{Total} ) {

        # get dynamic fields details
        my $Counter = 0;

        DYNAMICFIELDID:
        for my $DynamicFieldID ( @{ $Param{DynamicFields} } ) {
            $Counter++;
            if ( $Counter >= $StartHit && $Counter < ( $PageShown + $StartHit ) ) {

                my $DynamicFieldData = $Kernel::OM->Get('Kernel::System::DynamicField')->DynamicFieldGet(
                    ID => $DynamicFieldID,
                );
                next DYNAMICFIELDID if !IsHashRefWithData($DynamicFieldData);

                # convert ValidID to Validity string
                my $Valid = $Kernel::OM->Get('Kernel::System::Valid')->ValidLookup(
                    ValidID => $DynamicFieldData->{ValidID},
                );

                # get the object type display name
                my $ObjectTypeName = $Kernel::OM->Get('Kernel::Config')->Get('DynamicFields::ObjectType')
                    ->{ $DynamicFieldData->{ObjectType} }->{DisplayName}
                    || $DynamicFieldData->{ObjectType};

                # get the field type display name
                my $FieldTypeName = $FieldTypeConfig->{ $DynamicFieldData->{FieldType} }->{DisplayName}
                    || $DynamicFieldData->{FieldType};

                # get the field backend dialog
                my $ConfigDialog = $FieldTypeConfig->{ $DynamicFieldData->{FieldType} }->{ConfigDialog}
                    || '';

                # print each dynamic field row
                $LayoutObject->Block(
                    Name => 'DynamicFieldsRow',
                    Data => {
                        %{$DynamicFieldData},
                        Valid          => $Valid,
                        ConfigDialog   => $ConfigDialog,
                        FieldTypeName  => $FieldTypeName,
                        ObjectTypeName => $ObjectTypeName,
                    },
                );

                # Internal fields can not be deleted.
                if ( !$DynamicFieldData->{InternalField} ) {
                    $LayoutObject->Block(
                        Name => 'DeleteLink',
                        Data => {
                            %{$DynamicFieldData},
                            Valid          => $Valid,
                            ConfigDialog   => $ConfigDialog,
                            FieldTypeName  => $FieldTypeName,
                            ObjectTypeName => $ObjectTypeName,
                        },
                    );
                }
            }
        }
    }

    # otherwise show a no data found message
    else {
        $LayoutObject->Block(
            Name => 'NoDataFound',
            Data => \%Param,
        );
    }

    $LayoutObject->Block(
        Name => 'MaxFieldOrder',
        Data => {
            MaxFieldOrder => scalar @{ $Param{DynamicFields} },
        },
    );

    return;
}

sub _DynamicFieldOrderReset {
    my ( $Self, %Param ) = @_;

    my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');
    my $ResetSuccess = $Kernel::OM->Get('Kernel::System::DynamicField')->DynamicFieldOrderReset();

    # show error message if the order reset was not successful
    if ( !$ResetSuccess ) {
        return $LayoutObject->ErrorScreen(
            Message => Translatable(
                'Could not reset Dynamic Field order properly, please check the error log for more details.'
            ),
        );
    }

    # redirect to main screen
    return $LayoutObject->Redirect(
        OP => "Action=AdminDynamicField",
    );
}

1;
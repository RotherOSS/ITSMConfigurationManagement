# --
# OTOBO is a web-based ticketing system for service organisations.
# --
# Copyright (C) 2001-2020 OTRS AG, https://otrs.com/
# Copyright (C) 2019-2023 Rother OSS GmbH, https://otobo.de/
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
package Kernel::Modules::AgentITSMConfigItemBulk;

use strict;
use warnings;

use Kernel::Language qw(Translatable);
use Kernel::System::VariableCheck qw(:all);

our $ObjectManagerDisabled = 1;

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {%Param};
    bless( $Self, $Type );

    return $Self;
}

sub Run {
    my ( $Self, %Param ) = @_;

    # get needed objects
    my $ConfigObject = $Kernel::OM->Get('Kernel::Config');
    my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');

    # check if bulk feature is enabled
    if ( !$ConfigObject->Get('ITSMConfigItem::Frontend::BulkFeature') ) {
        return $LayoutObject->ErrorScreen(
            Message => Translatable('Bulk feature is not enabled!'),
        );
    }

    # get param object
    my $ParamObject = $Kernel::OM->Get('Kernel::System::Web::Request');

    # get involved config items, filtering empty ConfigItemIDs
    my @ConfigItemIDs = grep {$_}
        $ParamObject->GetArray( Param => 'ConfigItemID' );

    # check needed stuff
    if ( !@ConfigItemIDs ) {
        return $LayoutObject->ErrorScreen(
            Message => Translatable('No ConfigItemID is given!'),
            Comment => Translatable('You need at least one selected Configuration Item!'),
        );
    }
    my $Output = $LayoutObject->Header(
        Type => 'Small',
    );

    # declare the variables for all the parameters
    my %Error;

    my %GetParam;

    # get config item object
    my $ConfigItemObject = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');

    # get all parameters and check for errors
    if ( $Self->{Subaction} eq 'Do' ) {

        # challenge token check for write action
        $LayoutObject->ChallengeTokenCheck();

        # get all parameters
        for my $Key (
            qw( LinkTogether LinkTogetherAnother LinkType LinkTogetherLinkType DeplStateID
            InciStateID )
            )
        {
            $GetParam{$Key} = $ParamObject->GetParam( Param => $Key ) || '';
        }

        if ( $GetParam{'LinkTogetherAnother'} ) {
            $Kernel::OM->Get('Kernel::System::CheckItem')->StringClean(
                StringRef => \$GetParam{'LinkTogetherAnother'},
                TrimLeft  => 1,
                TrimRight => 1,
            );
            my $ConfigItemID = $ConfigItemObject->ConfigItemLookup(
                ConfigItemNumber => $GetParam{'LinkTogetherAnother'},
            );
            if ( !$ConfigItemID ) {
                $Error{'LinkTogetherAnotherInvalid'} = 'ServerError';
            }
        }
    }

    # preprocess config item
    my @SelectedConfigItems;
    my %ConfigItemClasses;

    # get link object
    my $LinkObject = $Kernel::OM->Get('Kernel::System::LinkObject');

    # loop over config items to predetermine access and dynamic field handling
    CONFIGITEM_ID:
    for my $ConfigItemID (@ConfigItemIDs) {
        my $ConfigItem = $ConfigItemObject->ConfigItemGet(
            ConfigItemID  => $ConfigItemID,
            DynamicFields => 1,
        );

        next CONFIGITEM_ID unless IsHashRefWithData($ConfigItem);

        my $Config = $ConfigObject->Get("ITSMConfigItem::Frontend::AgentITSMConfigItemEdit");

        # TODO change this, use config item permission check instead
        # check permissions
        my $Access = $ConfigItemObject->Permission(
            Scope  => 'Item',
            ItemID => $ConfigItemID,
            UserID => $Self->{UserID},
            Type   => $Config->{Permission},
        );

        if ( !$Access ) {

            # error screen, don't show config item
            $Output .= $LayoutObject->Notify(
                Data => $LayoutObject->{LanguageObject}->Translate(
                    'You don\'t have write access to this configuration item: %s.',
                    $ConfigItem->{Number},
                ),
            );
            next CONFIGITEM_ID;
        }

        # remember selected config item classes and ids
        push @SelectedConfigItems, $ConfigItem;
        $ConfigItemClasses{ $ConfigItem->{Class} } = $ConfigItem->{ClassID};
    }

    # check if dynamic fields should be displayed and which ones
    my $DynamicFieldList;
    my %DynamicFieldValues;
    my %ACLReducibleDynamicFields;

    # dynamic fields are only displayed if all config items are from the same class
    if ( scalar keys %ConfigItemClasses == 1 ) {
        my $Class      = ( keys %ConfigItemClasses )[0];
        my $Definition = $Kernel::OM->Get('Kernel::System::ITSMConfigItem')->DefinitionGet(
            ClassID => $ConfigItemClasses{$Class},
        );

        # TODO ask about this - maybe not necessary
        if ( !$Definition->{DefinitionID} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "No definition was defined for class $Class!",
            );
        }
        else {
            $Self->{Definition} = $Definition;
            $Self->{Class}      = $Class;
            $DynamicFieldList   = $Definition->{DynamicFieldRef} ? [ values $Definition->{DynamicFieldRef}->%* ] : [];
        }
    }

    # get dynamic field backend object
    my $DynamicFieldBackendObject = $Kernel::OM->Get('Kernel::System::DynamicField::Backend');

    # fetch dynamic field values
    DYNAMICFIELD:
    for my $DynamicFieldConfig ( $DynamicFieldList->@* ) {
        next DYNAMICFIELD unless IsHashRefWithData($DynamicFieldConfig);

        # extract the dynamic field value from the web request
        $DynamicFieldValues{"DynamicField_$DynamicFieldConfig->{Name}"} = $DynamicFieldBackendObject->EditFieldValueGet(
            DynamicFieldConfig => $DynamicFieldConfig,
            ParamObject        => $ParamObject,
            LayoutObject       => $LayoutObject,
        );

        # perform ACLs on values
        my $IsACLReducible = $DynamicFieldBackendObject->HasBehavior(
            DynamicFieldConfig => $DynamicFieldConfig,
            Behavior           => 'IsACLReducible'
        );

        if ($IsACLReducible) {
            $ACLReducibleDynamicFields{ $DynamicFieldConfig->{Name} } = 1;
        }
    }

    # process config items
    my $ActionFlag = 0;
    my $Counter    = 1;

    CONFIGITEM_ID:
    for my $ConfigItem (@SelectedConfigItems) {

        # do some actions on CIs
        if ( ( $Self->{Subaction} eq 'Do' ) && ( !%Error ) ) {

            # challenge token check for write action
            $LayoutObject->ChallengeTokenCheck();

            # bulk action configitem update
            $ConfigItemObject->ConfigItemUpdate(
                $ConfigItem->%*,
                %GetParam,
                %DynamicFieldValues,
                UserID => $Self->{UserID},
            );

            # bulk action links
            # link all config items to another config item
            if ( $GetParam{'LinkTogetherAnother'} ) {
                my $MainConfigItemID = $ConfigItemObject->ConfigItemLookup(
                    ConfigItemNumber => $GetParam{'LinkTogetherAnother'},
                );

                # split the type identifier
                my @Type = split /::/, $GetParam{LinkType};

                if ( $Type[0] && $Type[1] && ( $Type[1] eq 'Source' || $Type[1] eq 'Target' ) ) {

                    my $SourceKey = $ConfigItem->{ConfigItemID};
                    my $TargetKey = $MainConfigItemID;

                    if ( $Type[1] eq 'Target' ) {
                        $SourceKey = $MainConfigItemID;
                        $TargetKey = $ConfigItem->{ConfigItemID};
                    }

                    for my $ConfigItemIDPartner ( map { $_->{ConfigItemID} } @SelectedConfigItems ) {
                        if ( $MainConfigItemID ne $ConfigItemIDPartner ) {
                            $LinkObject->LinkAdd(
                                SourceObject => 'ITSMConfigItem',
                                SourceKey    => $SourceKey,
                                TargetObject => 'ITSMConfigItem',
                                TargetKey    => $TargetKey,
                                Type         => $Type[0],
                                State        => 'Valid',
                                UserID       => $Self->{UserID},
                            );
                        }
                    }
                }
            }

            # link together
            if ( $GetParam{'LinkTogether'} ) {

                # split the type identifier
                my @Type = split /::/, $GetParam{LinkTogetherLinkType};

                if ( $Type[0] && $Type[1] && ( $Type[1] eq 'Source' || $Type[1] eq 'Target' ) ) {
                    for my $ConfigItemIDPartner ( map { $_->{ConfigItemID} } @SelectedConfigItems ) {

                        my $SourceKey = $ConfigItem->{ConfigItemID};
                        my $TargetKey = $ConfigItemIDPartner;

                        if ( $Type[1] eq 'Target' ) {
                            $SourceKey = $ConfigItemIDPartner;
                            $TargetKey = $ConfigItem->{ConfigItemID};
                        }

                        if ( $ConfigItem->{ConfigItemID} ne $ConfigItemIDPartner ) {
                            $LinkObject->LinkAdd(
                                SourceObject => 'ITSMConfigItem',
                                SourceKey    => $SourceKey,
                                TargetObject => 'ITSMConfigItem',
                                TargetKey    => $TargetKey,
                                Type         => $Type[0],
                                State        => 'Valid',
                                UserID       => $Self->{UserID},
                            );
                        }
                    }
                }
            }
            $ActionFlag = 1;
        }
        $Counter++;
    }

    # redirect
    if ($ActionFlag) {
        return $LayoutObject->PopupClose(
            URL => ( $Self->{LastScreenOverview} || 'Action=AgentDashboard' ),
        );
    }

    $Output .= $Self->_Mask(
        %Param,
        %GetParam,
        DynamicField  => \%DynamicFieldValues,
        ConfigItemIDs => [ map { $_->{ConfigItemID} } @SelectedConfigItems ],
        Errors        => \%Error,
    );
    $Output .= $LayoutObject->Footer(
        Type => 'Small',
    );
    return $Output;
}

sub _Mask {
    my ( $Self, %Param ) = @_;

    # get layout object
    my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');

    # prepare errors!
    if ( $Param{Errors} ) {
        for my $KeyError ( sort keys %{ $Param{Errors} } ) {
            $Param{$KeyError} = $LayoutObject->Ascii2Html( Text => $Param{Errors}->{$KeyError} );
        }
    }

    $LayoutObject->Block(
        Name => 'BulkAction',
        Data => \%Param,
    );

    # remember config item ids
    if ( $Param{ConfigItemIDs} ) {
        for my $ConfigItemID ( @{ $Param{ConfigItemIDs} } ) {
            $LayoutObject->Block(
                Name => 'UsedConfigItemID',
                Data => {
                    ConfigItemID => $ConfigItemID,
                },
            );
        }
    }

    # get needed objects
    my $GeneralCatalogObject = $Kernel::OM->Get('Kernel::System::GeneralCatalog');
    my $ConfigObject         = $Kernel::OM->Get('Kernel::Config');

    $Self->{Config} = $ConfigObject->Get("ITSMConfigItem::Frontend::$Self->{Action}");

    # deployment state
    if ( $Self->{Config}->{DeplState} ) {
        my $DeplStateList = $GeneralCatalogObject->ItemList(
            Class => 'ITSM::ConfigItem::DeploymentState',
        );

        # generate DeplStateStrg
        $Param{DeplStateStrg} = $LayoutObject->BuildSelection(
            Class        => 'Modernize',
            Data         => $DeplStateList,
            Name         => 'DeplStateID',
            PossibleNone => 1,
            SelectedID   => $Param{DeplStateID},
            Sort         => 'AlphanumericValue',
        );
        $LayoutObject->Block(
            Name => 'DeplState',
            Data => {%Param},
        );
    }

    # incident state
    if ( $Self->{Config}->{InciState} ) {

        # get incident state list
        my $InciStateList = $GeneralCatalogObject->ItemList(
            Class       => 'ITSM::Core::IncidentState',
            Preferences => {
                Functionality => [ 'operational', 'incident' ],
            },
        );

        # generate InciStateStrg
        $Param{InciStateStrg} = $LayoutObject->BuildSelection(
            Class        => 'Modernize',
            Data         => $InciStateList,
            Name         => 'InciStateID',
            PossibleNone => 1,
            SelectedID   => $Param{InciStateID},
            Sort         => 'AlphanumericValue',
        );
        $LayoutObject->Block(
            Name => 'InciState',
            Data => {%Param},
        );
    }

    # get link object
    my $LinkObject = $Kernel::OM->Get('Kernel::System::LinkObject');

    # link types list
    # get possible types list
    my %PossibleTypesList = $LinkObject->PossibleTypesList(
        Object1 => 'ITSMConfigItem',
        Object2 => 'ITSMConfigItem',
        UserID  => $Self->{UserID},
    );

    # define blank line entry
    my %BlankLine = (
        Key      => '-',
        Value    => '-------------------------',
        Disabled => 1,
    );

    # create the selectable type list
    my $Counter = 0;
    my @SelectableTypesList;
    my @LinkTogetherTypeList;
    POSSIBLETYPE:
    for my $PossibleType ( sort { lc $a cmp lc $b } keys %PossibleTypesList ) {

        # lookup type id
        my $TypeID = $LinkObject->TypeLookup(
            Name   => $PossibleType,
            UserID => $Self->{UserID},
        );

        # get type
        my %Type = $LinkObject->TypeGet(
            TypeID => $TypeID,
            UserID => $Self->{UserID},
        );

        # type list for link together can contain only
        # link types which are not directed (not pointed)
        if ( !$Type{Pointed} ) {

            # create the source name
            my %SourceName;
            $SourceName{Key}   = $PossibleType . '::Source';
            $SourceName{Value} = $Type{SourceName};

            push @LinkTogetherTypeList, \%SourceName;
        }

        # create the source name
        my %SourceName;
        $SourceName{Key}   = $PossibleType . '::Source';
        $SourceName{Value} = $Type{SourceName};

        push @SelectableTypesList, \%SourceName;

        next POSSIBLETYPE if !$Type{Pointed};

        # create the target name
        my %TargetName;
        $TargetName{Key}   = $PossibleType . '::Target';
        $TargetName{Value} = $Type{TargetName};

        push @SelectableTypesList, \%TargetName;
    }
    continue {

        # add blank line
        push @SelectableTypesList, \%BlankLine;

        $Counter++;
    }

    # removed last (empty) entry
    pop @SelectableTypesList;

    # add blank lines on top and bottom of the list if more then two linktypes
    if ( $Counter > 2 ) {
        unshift @SelectableTypesList, \%BlankLine;
        push @SelectableTypesList, \%BlankLine;
    }

    # generate LinkTypeStrg
    $Param{LinkTypeStrg} = $LayoutObject->BuildSelection(
        Class        => 'Modernize',
        Data         => \@SelectableTypesList,
        Name         => 'LinkType',
        PossibleNone => 0,
        SelectedID   => $Param{TypeIdentifier} || 'AlternativeTo::Source',
        Sort         => 'AlphanumericValue',
    );
    $Param{LinkTogetherLinkTypeStrg} = $LayoutObject->BuildSelection(
        Class        => 'Modernize',
        Data         => \@LinkTogetherTypeList,
        Name         => 'LinkTogetherLinkType',
        PossibleNone => 0,
        SelectedID   => $Param{TypeIdentifier} || 'AlternativeTo::Source',
        Sort         => 'AlphanumericValue',
    );

    $Param{LinkTogetherYesNoOption} = $LayoutObject->BuildSelection(
        Class      => 'Modernize',
        Data       => $ConfigObject->Get('YesNoOptions'),
        Name       => 'LinkTogether',
        SelectedID => $Param{LinkTogether} || 0,
    );

    # render dynamic fields
    if ( IsHashRefWithData( $Self->{Definition} ) && IsHashRefWithData( $Self->{Definition}{DefinitionRef} ) && $Self->{Definition}{DefinitionRef}{Sections} ) {

        # TODO: It would be nice to switch between pages for the edit mask, too. Keeping the fields in sync
        #       while editing needs a bit more preparation though
        # Thus for now make sure to show dynamic fields only once, even if present on multiple pages/sections
        my $FieldsSeen = {};

        for my $Page ( $Self->{Definition}{DefinitionRef}{Pages}->@* ) {

            SECTION:
            for my $SectionConfig ( $Page->{Content}->@* ) {
                my $Section = $Self->{Definition}{DefinitionRef}{Sections}{ $SectionConfig->{Section} };

                next SECTION unless $Section;
                next SECTION if $Section->{Type} && $Section->{Type} ne 'DynamicFields';

                # weed out multiple occurances of dynamic fields - see comment above
                $Section->{Content} = $Self->_DiscardFieldsSeen(
                    Content => $Section->{Content},
                    Seen    => $FieldsSeen,
                );

                $Param{DynamicFieldHTML} .= $Kernel::OM->Get('Kernel::Output::HTML::DynamicField::Mask')->EditSectionRender(
                    Content       => $Section->{Content},
                    DynamicFields => $Self->{Definition}{DynamicFieldRef},

                    # TODO ask if this should be used
                    # UpdatableFields      => \@UpdatableFields,
                    LayoutObject       => $LayoutObject,
                    ParamObject        => $Kernel::OM->Get('Kernel::System::Web::Request'),
                    DynamicFieldValues => $Param{DynamicField},

                    # TODO ask if this should be used
                    # PossibleValuesFilter => \%DynamicFieldPossibleValues,
                    # Errors               => \%DynamicFieldValidationResult,
                    # Visibility           => \%DynamicFieldVisibility,
                    Object => {
                        Class => $Self->{Class},
                        $Param{DynamicField}->%*,
                    },
                );
            }
        }
    }

    # get output back
    return $LayoutObject->Output(
        TemplateFile => 'AgentITSMConfigItemBulk',
        Data         => \%Param,
    );
}

sub _DiscardFieldsSeen {
    my ( $Self, %Param ) = @_;

    my $Content;
    my $Ref = ref $Param{Content};

    if ( $Ref eq 'ARRAY' ) {
        my @CleanedArray;

        ELEMENT:
        for my $Element ( $Param{Content}->@* ) {
            my $RefElement = ref $Element;

            if ( $RefElement eq 'ARRAY' ) {
                push @CleanedArray, $Self->_DiscardFieldsSeen(
                    Content => $Element,
                    Seen    => $Param{Seen},
                );

                next ELEMENT;
            }

            elsif ( $RefElement eq 'HASH' ) {
                if ( !$Element->{DF} ) {
                    push @CleanedArray, $Self->_DiscardFieldsSeen(
                        Content => $Element,
                        Seen    => $Param{Seen},
                    );

                    next ELEMENT;
                }

                if ( $Param{Seen}{ $Element->{DF} }++ ) {
                    next ELEMENT;
                }
            }

            push @CleanedArray, $Element;
        }

        $Content = \@CleanedArray;
    }

    elsif ( $Ref eq 'HASH' ) {
        my %CleanedHash;

        for my $Key ( keys $Param{Content}->%* ) {
            $CleanedHash{$Key} = $Self->_DiscardFieldsSeen(
                Content => $Param{Content}{$Key},
                Seen    => $Param{Seen},
            );
        }

        $Content = \%CleanedHash;
    }

    else {
        $Content = $Param{Content};
    }

    return $Content;
}

1;

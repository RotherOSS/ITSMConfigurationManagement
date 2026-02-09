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

package Kernel::Modules::PublicITSMConfigItemSearch;

use strict;
use warnings;

# core modules
use List::Util qw(any);

# CPAN modules

# OTOBO modules
use Kernel::System::VariableCheck qw(:all);
use Kernel::Language qw(Translatable);

our $ObjectManagerDisabled = 1;

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {%Param};

    # clear any active login to enforce security
    delete $Self->{UserID};

    $Self->{CacheType} = 'ITSMConfigurationManagement';
    $Self->{CacheTTL}  = 60 * 60 * 24 * 20;

    bless( $Self, $Type );

    return $Self;
}

sub Run {
    my ( $Self, %Param ) = @_;

    # get needed objects
    my $BackendObject        = $Kernel::OM->Get('Kernel::System::DynamicField::Backend');
    my $ConfigObject         = $Kernel::OM->Get('Kernel::Config');
    my $ConfigItemObject     = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');
    my $GeneralCatalogObject = $Kernel::OM->Get('Kernel::System::GeneralCatalog');
    my $LayoutObject         = $Kernel::OM->Get('Kernel::Output::HTML::Layout');
    my $ParamObject          = $Kernel::OM->Get('Kernel::System::Web::Request');

    my $Config = $ConfigObject->Get("ITSMConfigItem::Frontend::$Self->{Action}");

    # get configured dynamic fields for this screen
    $Self->{DynamicField} = $Kernel::OM->Get('Kernel::System::DynamicField')->DynamicFieldListGet(
        Valid       => 1,
        ObjectType  => ['ITSMConfigItem'],
        FieldFilter => $Config->{DynamicField},
    );

    # build NavigationBar & to get the output faster!
    my $Refresh = '';
    if ( $Self->{UserRefreshTime} ) {
        $Refresh = 60 * $Self->{UserRefreshTime};
    }

    my $Output = $LayoutObject->PublicHeader(
        Refresh => $Refresh,
    );

    # get class list
    my $ClassList = $GeneralCatalogObject->ItemList(
        Class => 'ITSM::ConfigItem::Class',
        Valid => 1,
    );

    # get deployment state list
    my $DeplStateList = $GeneralCatalogObject->ItemList(
        Class => 'ITSM::ConfigItem::DeploymentState',
        Valid => 1,
    );

    # get incident state list
    my $InciStateList = $GeneralCatalogObject->ItemList(
        Class => 'ITSM::Core::IncidentState',
        Valid => 1,
    );

    # fetch filters from config
    my $PermissionConditionConfigs = $ConfigObject->Get('Public::ConfigItem::PermissionConditions');
    if ( !IsHashRefWithData($PermissionConditionConfigs) ) {
        my $Output = $LayoutObject->PublicHeader(
            Title => Translatable('Error'),
        );
        $Output .= $LayoutObject->PublicError(
            Message => Translatable('No permission'),
        );
        $Output .= $LayoutObject->PublicFooter();

        return $Output;
    }

    # get filter from web request or use first valid permission condition
    my $Filter =
        $ParamObject->GetParam( Param => 'PermissionCondition' ) ||
        $ParamObject->GetParam( Param => 'Filter' ) ||
        ( sort { $a <=> $b } keys $PermissionConditionConfigs->%* )[0];

    my $PermissionConditionConfig = $PermissionConditionConfigs->{ sprintf( "%02d", $Filter ) };
    if ( !IsHashRefWithData($PermissionConditionConfig) ) {

        my $Output = $LayoutObject->PublicHeader(
            Title => Translatable('Error'),
        );
        $Output .= $LayoutObject->PublicError(
            Message => Translatable('Filter invalid!'),
        );
        $Output .= $LayoutObject->PublicFooter();

        return $Output;
    }

    my %PageNav;
    if ( $Self->{Subaction} eq 'SearchAction' ) {

        my $SortBy = $ParamObject->GetParam( Param => 'SortBy' )
            || $Config->{'SortBy::Default'}
            || 'Age';

        if ( $SortBy eq 'LastChanged' ) {
            $SortBy = 'Changed';
        }

        # Determine the default ordering to be used.
        my $DefaultOrderBy = $Config->{'Order::Default'}
            || 'Up';

        # Set the sort order from the request parameters, or take the default.
        my $OrderBy = $ParamObject->GetParam( Param => 'OrderBy' )
            || $DefaultOrderBy;

        # sort on default by using both (Priority, Age) else use only one sort argument
        my %Sort;

        # get if search result should be pre-sorted by priority
        my $PreSortByPriority = $Config->{'PreSort::ByPriority'};
        if ( !$PreSortByPriority ) {
            %Sort = (
                SortBy  => $SortBy,
                OrderBy => $OrderBy,
            );
        }
        else {
            %Sort = (
                SortBy  => [ 'Priority', $SortBy ],
                OrderBy => [ 'Down',     $OrderBy ],
            );
        }

        my $View = $ParamObject->GetParam( Param => 'View' ) || '';

        # lookup latest used view mode
        if ( !$View && $Self->{ 'UserConfigItemOverview' . $Self->{Action} } ) {
            $View = $Self->{ 'UserConfigItemOverview' . $Self->{Action} };
        }

        # otherwise use Preview as default as in LayoutConfigItem
        $View ||= 'Small';

        my $LinkPage = 'Filter='
            . $LayoutObject->Ascii2Html( Text => $Filter )
            . ';Subaction=' . $LayoutObject->Ascii2Html( Text => $Self->{Subaction} )
            . ';View=' . $LayoutObject->Ascii2Html( Text => $View )
            . ';SortBy=' . $LayoutObject->Ascii2Html( Text => $SortBy )
            . ';OrderBy=' . $LayoutObject->Ascii2Html( Text => $OrderBy );

        my $LinkSort = 'Filter='
            . $LayoutObject->Ascii2Html( Text => $Filter )
            . ';Subaction=' . $LayoutObject->Ascii2Html( Text => $Self->{Subaction} )
            . ';View=' . $LayoutObject->Ascii2Html( Text => $View );

        # get search params from web request
        my %GetParam;
        PARAM:
        for my $SearchParam (qw(Number Name)) {
            next PARAM if !$Config->{ $SearchParam };

            # fetch single value params
            $GetParam{$SearchParam} = $ParamObject->GetParam( Param => $SearchParam );

            # supress fuzzy logic operators
            if ( $Config->{SuppressFuzzyLogic} ) {
                $GetParam{$SearchParam} =~ s/[\*%_]//g;
            }
            $LinkPage .= ";$SearchParam=" . $LayoutObject->Ascii2Html( Text => $GetParam{$SearchParam} );
            $LinkSort .= ";$SearchParam=" . $LayoutObject->Ascii2Html( Text => $GetParam{$SearchParam} );
        }

        my @ArraySearchParams;

        if ( $Config->{Class} ) {
            push @ArraySearchParams, 'ClassIDs';
        }

        if ( $Config->{DeploymentState} ) {
            push @ArraySearchParams, 'DeplStateIDs';
        }

        if ( $Config->{IncidentState} ) {
            push @ArraySearchParams, 'InciStateIDs';
        }

        for my $SearchParamArray (@ArraySearchParams) {

            # fetch multi value params
            my @Array = $ParamObject->GetArray( Param => $SearchParamArray );

            if ( grep {$_} @Array ) {
                $GetParam{$SearchParamArray} = \@Array;
                $LinkPage .= join( '', map { ";$SearchParamArray=" . $LayoutObject->Ascii2Html( Text => $_ ) } @Array );
                $LinkSort .= join( '', map { ";$SearchParamArray=" . $LayoutObject->Ascii2Html( Text => $_ ) } @Array );
            }
        }

        my %SearchConfig;
        my %DynamicFieldSearchParameters;

        DYNAMICFIELD:
        for my $DynamicFieldConfig ( $Self->{DynamicField}->@* ) {
            next DYNAMICFIELD unless IsHashRefWithData($DynamicFieldConfig);

            # get search field preferences
            my $SearchFieldPreferences = $BackendObject->SearchFieldPreferences(
                DynamicFieldConfig => $DynamicFieldConfig,
            );

            next DYNAMICFIELD if !IsArrayRefWithData($SearchFieldPreferences);

            PREFERENCE:
            for my $Preference ( @{$SearchFieldPreferences} ) {

                # extract the dynamic field value from the web request
                my $DynamicFieldValue = $BackendObject->SearchFieldValueGet(
                    DynamicFieldConfig     => $DynamicFieldConfig,
                    ParamObject            => $ParamObject,
                    ReturnProfileStructure => 1,
                    LayoutObject           => $LayoutObject,
                    Type                   => $Preference->{Type},
                );

                # set the complete value structure in GetParam to store it later in the search
                # profile
                if ( IsHashRefWithData($DynamicFieldValue) ) {
                    %GetParam = ( %GetParam, %{$DynamicFieldValue} );
                }

                # extract the dynamic field value from the profile
                my $SearchParameter = $BackendObject->SearchFieldParameterBuild(
                    DynamicFieldConfig => $DynamicFieldConfig,
                    Profile            => \%GetParam,
                    LayoutObject       => $LayoutObject,
                    Type               => $Preference->{Type},
                );

                # set search parameter
                if ( defined $SearchParameter ) {

                    # append search params to links
                    if ( IsArrayRefWithData( $SearchParameter->{Parameter}{Equals} ) ) {
                        $LinkPage .= join(
                            '',
                            map { ";Search_DynamicField_$DynamicFieldConfig->{Name}=" . $LayoutObject->Ascii2Html( Text => $_ ) } $SearchParameter->{Parameter}{Equals}->@*
                        );
                        $LinkSort .= join(
                            '',
                            map { ";Search_DynamicField_$DynamicFieldConfig->{Name}=" . $LayoutObject->Ascii2Html( Text => $_ ) } $SearchParameter->{Parameter}{Equals}->@*
                        );
                    }
                    else {
                        $LinkPage .= ";Search_DynamicField_$DynamicFieldConfig->{Name}=" . $LayoutObject->Ascii2Html( Text => $SearchParameter->{Parameter}{Equals} );
                        $LinkSort .= ";Search_DynamicField_$DynamicFieldConfig->{Name}=" . $LayoutObject->Ascii2Html( Text => $SearchParameter->{Parameter}{Equals} );
                    }
                    $DynamicFieldSearchParameters{ 'DynamicField_' . $DynamicFieldConfig->{Name} } = $SearchParameter->{Parameter};
                }
            }
        }
        $LinkPage .= ';';
        $LinkSort .= ';';

        %SearchConfig = (
            %SearchConfig,
            %DynamicFieldSearchParameters,
            %Sort,
        );

        # merge filtered classes with permission condition classes
        if ( IsArrayRefWithData( $GetParam{ClassIDs} ) ) {
            my @SearchClasses;
            for my $ClassID ( $GetParam{ClassIDs}->@* ) {
                if ( any { $_ eq $ClassList->{$ClassID} } $PermissionConditionConfig->{Classes}->@* ) {
                    push @SearchClasses, $ClassList->{$ClassID};
                }
            }
            $SearchConfig{Classes} = \@SearchClasses;
        }
        else {
            $SearchConfig{Classes} = $PermissionConditionConfig->{Classes};
        }

        if ( !$SearchConfig{Classes}->@* ) {
            my $Output = $LayoutObject->PublicHeader(
                Title => Translatable('Error'),
            );
            $Output .= $LayoutObject->PublicError(
                Message => Translatable('No permission'),
            );
            $Output .= $LayoutObject->PublicFooter();

            return $Output;
        }

        # merge filtered deployment states with permission condition deployment states
        if ( IsArrayRefWithData( $GetParam{DeplStateIDs} ) ) {
            my @SearchDeplStates;
            for my $DeplStateID ( $GetParam{DeplStateIDs}->@* ) {
                if ( IsArrayRefWithData( $PermissionConditionConfig->{DeploymentStates} ) ) {
                    if ( any { $_ eq $DeplStateList->{$DeplStateID} } $PermissionConditionConfig->{DeploymentStates}->@* ) {
                        push @SearchDeplStates, $DeplStateList->{$DeplStateID};
                    }
                }
                else {
                    push @SearchDeplStates, $DeplStateList->{$DeplStateID};
                }
            }

            if ( !@SearchDeplStates ) {
                my $Output = $LayoutObject->PublicHeader(
                    Title => Translatable('Error'),
                );
                $Output .= $LayoutObject->PublicError(
                    Message => Translatable('No permission'),
                );
                $Output .= $LayoutObject->PublicFooter();

                return $Output;
            }

            $SearchConfig{DeplStates} = \@SearchDeplStates;
        }
        elsif ( IsArrayRefWithData( $PermissionConditionConfig->{DeploymentStates} ) ) {
            $SearchConfig{DeplStates} = $PermissionConditionConfig->{DeploymentStates};
        }

        # map filtered incident state ids
        if ( IsArrayRefWithData( $GetParam{InciStateIDs} ) ) {
            my @SearchInciStates = map { $InciStateList->{$_} } $GetParam{InciStateIDs}->@*;
            $SearchConfig{InciStates} = \@SearchInciStates;
        }

        $SearchConfig{Number} = $GetParam{Number} ? $GetParam{Number} : undef;
        $SearchConfig{Name}   = $GetParam{Name}   ? $GetParam{Name}   : undef;

        # collect dynamic field search params
        if ( IsHashRefWithData( $PermissionConditionConfig->{DynamicFieldValues} ) ) {
            my $DynamicFieldObject = $Kernel::OM->Get('Kernel::System::DynamicField');
            DYNAMICFIELD:
            for my $FieldName ( keys $PermissionConditionConfig->{DynamicFieldValues}->%* ) {
                next DYNAMICFIELD unless $PermissionConditionConfig->{DynamicFieldValues}{$FieldName};

                my $DynamicFieldConfig = $DynamicFieldObject->DynamicFieldGet(
                    Name => $FieldName,
                );

                next DYNAMICFIELD if !IsHashRefWithData($DynamicFieldConfig);
                next DYNAMICFIELD if !$DynamicFieldConfig->{Name};

                $SearchConfig{"DynamicField_$FieldName"} = {
                    Equals => $PermissionConditionConfig->{DynamicFieldValues}{$FieldName},
                };
            }
        }

        my %Filters = (
            $Filter => {
                Name   => $PermissionConditionConfig->{Name},
                Prio   => 1000,
                Search => \%SearchConfig,
            },
        );

        if ( !%SearchConfig ) {
            my $Output = $LayoutObject->PublicHeader(
                Title => Translatable('Error'),
            );
            $Output .= $LayoutObject->PublicError(
                Message => Translatable('Search params invalid!'),
            );
            $Output .= $LayoutObject->PublicFooter();

            return $Output;
        }

        # Check if selected view is available.

        my $Backends = $ConfigObject->Get('ITSMConfigItem::Frontend::PublicOverview');
        if ( !$Backends->{$View} ) {

            # Try to find fallback, take first configured view mode.
            KEY:
            for my $Key ( sort keys %{$Backends} ) {
                $View = $Key;
                last KEY;
            }
        }

        my $PageShownPreferencesKey = 'UserConfigItemOverview' . $View . 'PageShown';
        my $PageShown               = $Self->{$PageShownPreferencesKey} || 10;

        # do shown config item lookup
        my $Limit = 1_000;

        # get data (viewable config items...)
        # search all config items
        my @OriginalViewableConfigItems = $ConfigItemObject->ConfigItemSearch(
            %SearchConfig,
            Limit  => $Limit,
            Result => 'ARRAY',
        );

        # SHOULD KEEP?
        if ( scalar @OriginalViewableConfigItems == 1 ) {
            return $LayoutObject->Redirect(
                OP => "Action=PublicITSMConfigItemZoom;ConfigItemID=$OriginalViewableConfigItems[0]",
            );
        }

        my $Total = scalar @OriginalViewableConfigItems;

        my $StartHit = $ParamObject->GetParam( Param => 'StartHit' ) || 1;

        my @ViewableConfigItems = $ConfigItemObject->ConfigItemSearch(
            %SearchConfig,
            Limit  => $StartHit + $PageShown - 1,
            Result => 'ARRAY',
        );

        %PageNav = $LayoutObject->PageNavBar(
            Limit     => 10000,
            StartHit  => $StartHit,
            PageShown => $PageShown,
            AllHits   => scalar @OriginalViewableConfigItems,
            Action    => 'Action=PublicITSMConfigItemSearch',
            Link      => $LinkPage,
            IDPrefix  => 'PublicITSMConfigItemSearch',
        );

        # TODO Maybe there is a more elegant way to do this?
        $Self->{Filter}  = $Filter;
        $Self->{Filters} = \%Filters;

        # show config items
        my $ConfigItemListHTML = $LayoutObject->ITSMConfigItemListShow(
            Filter                => $Filter,
            ConfigItemIDs         => \@ViewableConfigItems,
            OriginalConfigItemIDs => \@OriginalViewableConfigItems,
            Action                => $Self->{Action},
            LinkPage              => $LinkPage,
            LinkSort              => $LinkSort,
            EnableColumnFilter    => 0,
            View                  => $View,
            Total                 => $Total,
            OrderBy               => $OrderBy,
            SortBy                => $SortBy,
            Env                   => $Self,
            Frontend              => 'Public',

            # do not print the result earlier, but return complete content
            Output => 1,
        );

        $LayoutObject->Block(
            Name => 'SearchBox',
        );

        my %PublicActions = %{ $ConfigObject->Get('PublicFrontend::Module') // {} };
        if ( $PublicActions{PublicITSMConfigItem} ) {
            $LayoutObject->Block(
                Name => 'OverviewLink',
            );
        }

        $LayoutObject->Block(
            Name => 'SearchResult',
            Data => {
                ITSMConfigItemListHTML => $ConfigItemListHTML,
            },
        );
    }
    elsif ( !$Self->{Subaction} ) {

        # store dropdown restrictions from permission condition
        my %SearchableParams = (
            InciState => $InciStateList,
        );

        # set searchable params
        my %ClassLookup = reverse $ClassList->%*;
        $SearchableParams{Class} = {
            map {
                $ClassLookup{$_}
                    ? ( $ClassLookup{$_} => $_ )
                    : ()
            } $PermissionConditionConfig->{Classes}->@*
        };

        if ( IsArrayRefWithData( $PermissionConditionConfig->{DeploymentStates} ) ) {
            my %DeplStateLookup = reverse $DeplStateList->%*;
            $SearchableParams{DeplState} = {
                map {
                    $DeplStateLookup{$_}
                        ? ( $DeplStateLookup{$_} => $_ )
                        : ()
                } $PermissionConditionConfig->{DeploymentStates}->@*
            };
        }
        else {
            $SearchableParams{DeplState} = $DeplStateList;
        }

        my $PermissionConditionConfigs = $ConfigObject->Get('Public::ConfigItem::PermissionConditions');

        if ( !IsHashRefWithData($PermissionConditionConfigs) ) {
            my $Output = $LayoutObject->PublicHeader(
                Title => Translatable('Error'),
            );
            $Output .= $LayoutObject->PublicError(
                Message => Translatable('No permission!'),
            );
            $Output .= $LayoutObject->PublicFooter();

            return $Output;
        }

        my %PublicActions = %{ $ConfigObject->Get('PublicFrontend::Module') // {} };
        if ( $PublicActions{PublicITSMConfigItem} ) {
            $LayoutObject->Block(
                Name => 'OverviewLink',
            );
        }

        $LayoutObject->Block(
            Name => 'SearchForm',
        );

        my %Defaults;
        if ( $Config->{Defaults} ) {
            KEY:
            for my $Key ( sort keys %{ $Config->{Defaults} } ) {
                next KEY if !$Config->{Defaults}->{$Key};
                next KEY if $Key eq 'DynamicField';

                if ( $Key =~ /^ConfigItem(Create|Change)/ ) {
                    my @Items = split /;/, $Config->{Defaults}->{$Key};
                    for my $Item (@Items) {
                        my ( $Key, $Value ) = split /=/, $Item;
                        $Defaults{$Key} = $Value;
                    }
                }
                else {
                    $Defaults{$Key} = $Config->{Defaults}->{$Key};
                }
            }
        }

        # generate dropdown for selecting the permission condition
        my %PermissionConditionData = map { int($_) => $PermissionConditionConfigs->{$_}->{Name} } keys $PermissionConditionConfigs->%*;
        my $PermissionConditionStrg = $LayoutObject->BuildSelection(
            Data        => \%PermissionConditionData,
            Name        => 'PermissionCondition',
            SelectedID  => $Filter || '',
            Translation => 1,
            Class       => 'Modernize',
        );

        $LayoutObject->Block(
            Name => 'PermissionCondition',
            Data => {
                PermissionConditionStrg => $PermissionConditionStrg,
            },
        );

        # cycle trough the activated Dynamic Fields for this screen
        DYNAMICFIELD:
        for my $DynamicFieldConfig ( $Self->{DynamicField}->@* ) {
            next DYNAMICFIELD if !IsHashRefWithData($DynamicFieldConfig);

            my $PossibleValuesFilter;

            my $IsACLReducible = $BackendObject->HasBehavior(
                DynamicFieldConfig => $DynamicFieldConfig,
                Behavior           => 'IsACLReducible',
            );

            if ($IsACLReducible) {

                # get PossibleValues
                my $PossibleValues = $BackendObject->PossibleValuesGet(
                    DynamicFieldConfig => $DynamicFieldConfig,
                );

                # check if field has PossibleValues property in its configuration
                if ( IsHashRefWithData($PossibleValues) ) {

                    # get historical values from database
                    my $HistoricalValues = $BackendObject->HistoricalValuesGet(
                        DynamicFieldConfig => $DynamicFieldConfig,
                    );

                    my $Data = $PossibleValues;

                    # add historic values to current values (if they don't exist anymore)
                    if ( IsHashRefWithData($HistoricalValues) ) {
                        for my $Key ( sort keys %{$HistoricalValues} ) {
                            if ( !$Data->{$Key} ) {
                                $Data->{$Key} = $HistoricalValues->{$Key};
                            }
                        }
                    }

                    # convert possible values key => value to key => key for ACLs using a Hash slice
                    my %AclData = %{$Data};
                    @AclData{ keys %AclData } = keys %AclData;

                    # set possible values filter from ACLs
                    my $ACL = $ConfigItemObject->ConfigItemAcl(
                        Action        => $Self->{Action},
                        ReturnType    => 'ITSMConfigItem',
                        ReturnSubType => 'DynamicField_' . $DynamicFieldConfig->{Name},
                        Data          => \%AclData,
                    );
                    if ($ACL) {
                        my %Filter = $ConfigItemObject->ConfigItemAclData();

                        # convert Filer key => key back to key => value using map
                        %{$PossibleValuesFilter} = map { $_ => $Data->{$_} } keys %Filter;
                    }
                }
            }

            # get search field preferences
            my $SearchFieldPreferences = $BackendObject->SearchFieldPreferences(
                DynamicFieldConfig => $DynamicFieldConfig,
            );

            next DYNAMICFIELD if !IsArrayRefWithData($SearchFieldPreferences);

            PREFERENCE:
            for my $Preference ( @{$SearchFieldPreferences} ) {

                # get field HTML
                my $DynamicFieldHTML = $BackendObject->SearchFieldRender(
                    DynamicFieldConfig   => $DynamicFieldConfig,
                    PossibleValuesFilter => $PossibleValuesFilter,
                    Profile              => {},
                    DefaultValue         =>
                        $Config->{Defaults}{DynamicField}{ $DynamicFieldConfig->{Name} },
                    LayoutObject => $LayoutObject,
                    Type         => $Preference->{Type},
                );

                $LayoutObject->Block(
                    Name => 'DynamicField',
                    Data => {
                        Field => $DynamicFieldHTML->{Field},
                        Label => $DynamicFieldHTML->{Label},
                    },
                );
            }
        }

        if ( $Config->{Number} ) {
            $LayoutObject->Block(
                Name => 'Number',
            );
        }

        if ( $Config->{Name} ) {
            $LayoutObject->Block(
                Name => 'Name',
            );
        }

        if ( $Config->{Class} ) {
            my $ClassStrg = $LayoutObject->BuildSelection(
                Data         => $SearchableParams{Class},
                Name         => 'ClassIDs',
                Class        => 'Modernize',
                SelectedID   => $Defaults{ClassIDs},
                PossibleNone => 1,
                Multiple     => 1,
            );

            $LayoutObject->Block(
                Name => 'Class',
                Data => {
                    ClassStrg => $ClassStrg,
                },
            );
        }

        if ( $Config->{DeploymentState} ) {

            # generate dropdown for selecting the wanted deployment states
            my $CurDeplStateOptionStrg = $LayoutObject->BuildSelection(
                Data         => $SearchableParams{DeplState},
                Name         => 'DeplStateIDs',
                SelectedID   => $Defaults{DeploymentStateIDs},
                Size         => 5,
                PossibleNone => 1,
                Multiple     => 1,
                Class        => 'Modernize',
            );

            $LayoutObject->Block(
                Name => 'DeplState',
                Data => {
                    CurDeplStateOptionStrg => $CurDeplStateOptionStrg,
                },
            );
        }

        if ( $Config->{IncidentState} ) {

            # generate dropdown for selecting the wanted incident states
            my $CurInciStateOptionStrg = $LayoutObject->BuildSelection(
                Data         => $SearchableParams{InciState},
                Name         => 'InciStateIDs',
                SelectedID   => $Defaults{IncidentStateIDs},
                Size         => 5,
                PossibleNone => 1,
                Multiple     => 1,
                Class        => 'Modernize',
            );

            $LayoutObject->Block(
                Name => 'InciState',
                Data => {
                    CurInciStateOptionStrg => $CurInciStateOptionStrg,
                },
            );
        }
    }
    else {
        my $Output = $LayoutObject->PublicHeader(
            Title => Translatable('Error'),
        );
        $Output .= $LayoutObject->PublicError(
            Message => Translatable('No permission!'),
        );
        $Output .= $LayoutObject->PublicFooter();

        return $Output;
    }

    my $HeaderTitle = $ConfigObject->Get("ITSMConfigItem::Frontend::PublicITSMConfigItemSearch")->{Title} || "ConfigItem Search";
    $Output .= $LayoutObject->Output(
        TemplateFile => 'PublicITSMConfigItemSearch',
        Data         => {
            Title    => $HeaderTitle,
            %PageNav,
        },
    );

    # get page footer
    $Output .= $LayoutObject->PublicFooter();

    return $Output;
}

1;

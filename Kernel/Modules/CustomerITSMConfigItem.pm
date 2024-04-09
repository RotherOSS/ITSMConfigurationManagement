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

package Kernel::Modules::CustomerITSMConfigItem;

use strict;
use warnings;

# core modules
use List::Util qw(any);

# CPAN modules

# OTOBO modules
use Kernel::System::VariableCheck qw(:all);
use Kernel::Language              qw(Translatable);

our $ObjectManagerDisabled = 1;

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {%Param};
    bless( $Self, $Type );

    # set debug
    $Self->{Debug} = 0;

    return $Self;
}

sub Run {
    my ( $Self, %Param ) = @_;

    # get needed objects
    my $ConfigObject = $Kernel::OM->Get('Kernel::Config');
    my $ParamObject  = $Kernel::OM->Get('Kernel::System::Web::Request');

    my $Config = $ConfigObject->Get("ITSMConfigItem::Frontend::$Self->{Action}");

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

    # get session object
    my $SessionObject = $Kernel::OM->Get('Kernel::System::AuthSession');

    # store last queue screen
    $SessionObject->UpdateSessionID(
        SessionID => $Self->{SessionID},
        Key       => 'LastScreenOverview',
        Value     => $Self->{RequestedURL},
    );

    # store last screen
    $SessionObject->UpdateSessionID(
        SessionID => $Self->{SessionID},
        Key       => 'LastScreenView',
        Value     => $Self->{RequestedURL},
    );

    # get user object
    my $UserObject = $Kernel::OM->Get('Kernel::System::CustomerUser');

    # get filter from web request
    my $Filter = $ParamObject->GetParam( Param => 'Filter' ) || '';

    # get filters stored in the user preferences
    my %Preferences = $UserObject->GetPreferences(
        UserID => $Self->{UserID},
    );
    my $StoredFiltersKey = 'UserStoredFilterColumns-' . $Self->{Action} . '-' . $Filter;
    my $JSONObject       = $Kernel::OM->Get('Kernel::System::JSON');
    my $StoredFilters    = $JSONObject->Decode(
        Data => $Preferences{$StoredFiltersKey},
    );

    # delete stored filters if needed
    if ( $ParamObject->GetParam( Param => 'DeleteFilters' ) ) {
        $StoredFilters = {};
    }

    # get the column filters from the web request or user preferences
    my %ColumnFilter;
    my %GetColumnFilter;
    COLUMNNAME:
    for my $ColumnName (
        qw(DeplState CurDeplState InciState CurInciState Class)
        )
    {
        # get column filter from web request
        my $FilterValue = $ParamObject->GetParam( Param => 'ColumnFilter' . $ColumnName )
            || '';

        # if filter is not present in the web request, try with the user preferences
        if ( $FilterValue eq '' ) {
            $FilterValue = $StoredFilters->{ $ColumnName . 'IDs' }->[0] || '';
        }
        next COLUMNNAME if $FilterValue eq '';
        next COLUMNNAME if $FilterValue eq 'DeleteFilter';

        push @{ $ColumnFilter{ $ColumnName . 'IDs' } }, $FilterValue;
        $GetColumnFilter{$ColumnName} = $FilterValue;
    }

    # get all dynamic fields
    $Self->{DynamicField} = $Kernel::OM->Get('Kernel::System::DynamicField')->DynamicFieldListGet(
        Valid      => 1,
        ObjectType => ['ITSMConfigItem'],
    );

    DYNAMICFIELD:
    for my $DynamicFieldConfig ( @{ $Self->{DynamicField} } ) {
        next DYNAMICFIELD if !IsHashRefWithData($DynamicFieldConfig);
        next DYNAMICFIELD if !$DynamicFieldConfig->{Name};

        # get filter from web request
        my $FilterValue = $ParamObject->GetParam(
            Param => 'ColumnFilterDynamicField_' . $DynamicFieldConfig->{Name}
        );

        # if no filter from web request, try from user preferences
        if ( !defined $FilterValue || $FilterValue eq '' ) {
            $FilterValue = $StoredFilters->{ 'DynamicField_' . $DynamicFieldConfig->{Name} }->{Equals};
        }

        next DYNAMICFIELD if !defined $FilterValue;
        next DYNAMICFIELD if $FilterValue eq '';
        next DYNAMICFIELD if $FilterValue eq 'DeleteFilter';

        $ColumnFilter{ 'DynamicField_' . $DynamicFieldConfig->{Name} } = {
            Equals => $FilterValue,
        };
        $GetColumnFilter{ 'DynamicField_' . $DynamicFieldConfig->{Name} } = $FilterValue;
    }

    # build NavigationBar & to get the output faster!
    my $Refresh = '';
    if ( $Self->{UserRefreshTime} ) {
        $Refresh = 60 * $Self->{UserRefreshTime};
    }

    # get layout object
    my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');

    my $Output;
    if ( $Self->{Subaction} ne 'AJAXFilterUpdate' ) {
        $Output = $LayoutObject->CustomerHeader(
            Refresh => $Refresh,
        );
    }

    # get permissions
    my $Permission = 'rw';

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

    # my config item object
    my $ConfigItemObject = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');

    # define position of the filter in the frontend
    my $PrioCounter = 1000;

    # to store the NavBar filters
    my %Filters;

    my $ClassIDAuto = '1';

    # get general catalog object
    my $GeneralCatalogObject = $Kernel::OM->Get('Kernel::System::GeneralCatalog');

    # get class list
    my $ClassList = $GeneralCatalogObject->ItemList(
        Class => 'ITSM::ConfigItem::Class',
        Valid => 1,
    );

    my $DeplStateList = $GeneralCatalogObject->ItemList(
        Class => 'ITSM::ConfigItem::DeploymentState',
        Valid => 1,
    );

    my @ViewableDeplStateIDs;
    my @ViewableClassIDs;

    # fetch filters from config
    my $PermissionConditionsConfig = $ConfigObject->Get('Customer::ConfigItem::PermissionConditions');
    my %GroupLookup;

    if ( IsHashRefWithData($PermissionConditionsConfig) ) {
        PERMCONF:
        for my $ConfigCounter ( 1 .. 5 ) {
            my $ConfigIdentifier          = sprintf( "%02d", $ConfigCounter );
            my $PermissionConditionConfig = $PermissionConditionsConfig->{$ConfigIdentifier};
            next PERMCONF unless IsHashRefWithData($PermissionConditionConfig);

            # check for group permission
            if ( IsArrayRefWithData( $PermissionConditionConfig->{Groups} ) ) {

                # prepare group lookup if necessary
                if ( !%GroupLookup ) {
                    %GroupLookup = reverse $Kernel::OM->Get('Kernel::System::CustomerGroup')->GroupMemberList(
                        UserID => $Self->{UserID},
                        Type   => 'ro',
                        Result => 'HASH',
                    );
                }

                my $AccessOk = 0;
                GROUP:
                for my $GroupName ( $PermissionConditionConfig->{Groups}->@* ) {
                    next GROUP if !$GroupLookup{$GroupName};

                    $AccessOk = 1;
                }

                next PERMCONF unless $AccessOk;
            }

            # set as selected filter if not present
            $Filter ||= $PermissionConditionConfig->{Name};

            # collect dynamic field search params
            my %DFSearchParams;
            if ( IsHashRefWithData( $PermissionConditionConfig->{DynamicFieldValues} ) ) {
                my $DynamicFieldObject = $Kernel::OM->Get('Kernel::System::DynamicField');
                my $BackendObject      = $Kernel::OM->Get('Kernel::System::DynamicField::Backend');
                DYNAMICFIELD:
                for my $FieldName ( keys $PermissionConditionConfig->{DynamicFieldValues}->%* ) {
                    next DYNAMICFIELD unless $PermissionConditionConfig->{DynamicFieldValues}{$FieldName};

                    my $DynamicFieldConfig = $DynamicFieldObject->DynamicFieldGet(
                        Name => $FieldName,
                    );

                    next DYNAMICFIELD if !IsHashRefWithData($DynamicFieldConfig);
                    next DYNAMICFIELD if !$DynamicFieldConfig->{Name};

                    $DFSearchParams{"DynamicField_$FieldName"} = {
                        Equals => $PermissionConditionConfig->{DynamicFieldValues}{$FieldName},
                    };
                }
            }

            my %FilterSearch = (
                Classes    => $PermissionConditionConfig->{Classes},
                DeplStates => $PermissionConditionConfig->{DeploymentStates},
                %DFSearchParams,
                "DynamicField_$PermissionConditionConfig->{CustomerCompanyDynamicField}" => {
                    Equals => $Self->{CustomerID},
                },
                "DynamicField_$PermissionConditionConfig->{CustomerUserDynamicField}" => {
                    Equals => $Self->{UserID},
                },
                %Sort,
                Limit => $Self->{SearchLimit} // '1000',
            );

            # apply filter restrictions to search for
            if ( $GetColumnFilter{Class} ) {
                if ( $PermissionConditionConfig->{Classes}->@* ) {
                    if ( any { $ClassList->{ $GetColumnFilter{Class} } eq $_ } $PermissionConditionConfig->{Classes}->@* ) {
                        @ViewableClassIDs = ( $GetColumnFilter{Class} );
                        $FilterSearch{Classes} = [ $ClassList->{ $GetColumnFilter{Class} } ];
                    }
                }
                else {
                    @ViewableClassIDs = ( $GetColumnFilter{Class} );
                    $FilterSearch{Classes} = [ $ClassList->{ $GetColumnFilter{Class} } ];
                }
            }
            else {
                @ViewableClassIDs = sort keys $ClassList->%*;
            }
            if ( $GetColumnFilter{DeplState} ) {
                if ( $PermissionConditionConfig->{DeploymentStates}->@* ) {
                    if ( any { $DeplStateList->{ $GetColumnFilter{DeplState} } eq $_ } $PermissionConditionConfig->{DeploymentStates}->@* ) {
                        @ViewableDeplStateIDs = ( $GetColumnFilter{DeplState} );
                        $FilterSearch{DeplStates} = [ $DeplStateList->{ $GetColumnFilter{DeplState} } ];
                    }
                }
                else {
                    @ViewableDeplStateIDs = ( $GetColumnFilter{DeplState} );
                    $FilterSearch{DeplStates} = [ $DeplStateList->{ $GetColumnFilter{DeplState} } ];
                }
            }
            else {
                @ViewableDeplStateIDs = sort keys $DeplStateList->%*;
            }

            my $Count = 0;
            if ( @ViewableClassIDs && @ViewableDeplStateIDs ) {
                $Count = $ConfigItemObject->ConfigItemSearch(
                    %FilterSearch,
                    Result => 'COUNT',
                );
            }

            $Filters{$ConfigCounter} = {
                Name   => $PermissionConditionConfig->{Name},
                Prio   => $PrioCounter,
                Count  => $Count,
                Search => \%FilterSearch,
            };
            $PrioCounter++;
        }
    }

    # if only one filter exists
    if ( scalar keys %Filters == 1 ) {

        # get the name of the only filter
        my ($FilterName) = keys %Filters;

        # activate this filter
        $Filter = $FilterName;
    }

    # check if filter is valid
    if ( $Filter && !$Filters{$Filter} ) {
        $LayoutObject->FatalError(
            Message => $LayoutObject->{LanguageObject}->Translate( 'Invalid Filter: %s!', $Filter ),
        );
    }

    # show header filter
    for my $Key ( sort keys %Filters ) {

        $LayoutObject->Block(
            Name => 'FilterHeader',
            Data => {
                %Param,
                %{ $Filters{$Key} },
                Filter => $Key,
                ClassA => $Key eq $Filter ? 'Selected' : '',
            },
        );
    }

    # show filter delete if needed
    if (%GetColumnFilter) {
        $LayoutObject->Block(
            Name => 'FilterDelete',
        );
    }

    my $View = $ParamObject->GetParam( Param => 'View' ) || '';

    # lookup latest used view mode
    if ( !$View && $Self->{ 'UserConfigItemOverview' . $Self->{Action} } ) {
        $View = $Self->{ 'UserConfigItemOverview' . $Self->{Action} };
    }

    # otherwise use Preview as default as in LayoutConfigItem
    $View ||= 'Small';

    # Check if selected view is available.
    my $Backends = $ConfigObject->Get('ITSMConfigItem::Frontend::CustomerOverview');
    if ( !$Backends->{$View} ) {

        # Try to find fallback, take first configured view mode.
        KEY:
        for my $Key ( sort keys %{$Backends} ) {
            $View = $Key;
            last KEY;
        }
    }

    # get personal page shown count
    my $PageShownPreferencesKey = 'UserConfigItemOverview' . $View . 'PageShown';
    my $PageShown               = $Self->{$PageShownPreferencesKey} || 10;
    my %PageNav;

    # do shown config item lookup
    my $Limit = 1_000;

    my $ElementChanged = $ParamObject->GetParam( Param => 'ElementChanged' ) || '';
    my $HeaderColumn   = $ElementChanged;
    $HeaderColumn =~ s{\A ColumnFilter }{}msxg;

    # get data (viewable config items...)
    # search all config items
    my @ViewableConfigItems;
    my @OriginalViewableConfigItems;

    # build links
    my $ColumnFilterLink = '';
    COLUMNNAME:
    for my $ColumnName ( sort keys %GetColumnFilter ) {
        next COLUMNNAME if !$ColumnName;
        next COLUMNNAME if !defined $GetColumnFilter{$ColumnName};
        next COLUMNNAME if $GetColumnFilter{$ColumnName} eq '';
        $ColumnFilterLink
            .= ';' . $LayoutObject->Ascii2Html( Text => 'ColumnFilter' . $ColumnName )
            . '=' . $LayoutObject->LinkEncode( $GetColumnFilter{$ColumnName} );
    }

    my $LinkPage = 'Filter='
        . $LayoutObject->Ascii2Html( Text => $Filter )
        . ';View=' . $LayoutObject->Ascii2Html( Text => $View )
        . ';SortBy=' . $LayoutObject->Ascii2Html( Text => $SortBy )
        . ';OrderBy=' . $LayoutObject->Ascii2Html( Text => $OrderBy )
        . $ColumnFilterLink
        . ';';

    my $LinkSort = 'View=' . $LayoutObject->Ascii2Html( Text => $View )
        . ';Filter='
        . $LayoutObject->Ascii2Html( Text => $Filter )
        . $ColumnFilterLink
        . ';';

    my $LinkFilter = 'SortBy=' . $LayoutObject->Ascii2Html( Text => $SortBy )
        . ';OrderBy=' . $LayoutObject->Ascii2Html( Text => $OrderBy )
        . ';View=' . $LayoutObject->Ascii2Html( Text => $View )
        . ';';

    my $LastColumnFilter = $ParamObject->GetParam( Param => 'LastColumnFilter' ) || '';

    if ( !$LastColumnFilter && $ColumnFilterLink ) {

        # is planned to have a link to go back here
        $LastColumnFilter = 1;
    }

    if ( @ViewableDeplStateIDs && @ViewableClassIDs ) {

        # get config item values
        if (
            !IsStringWithData($HeaderColumn)
            || (
                IsStringWithData($HeaderColumn)
                && (
                    $ConfigObject->Get('OnlyValuesOnConfigItem')
                )
            )
            )
        {
            @OriginalViewableConfigItems = $ConfigItemObject->ConfigItemSearch(
                %{ $Filters{$Filter}->{Search} },
                Limit  => $Limit,
                Result => 'ARRAY',
            );

            my $StartHit = $ParamObject->GetParam( Param => 'StartHit' ) || 1;

            %PageNav = $LayoutObject->PageNavBar(
                Limit     => 10000,
                StartHit  => $StartHit,
                PageShown => $PageShown,
                AllHits   => scalar @OriginalViewableConfigItems,
                Action    => 'Action=CustomerITSMConfigItem',
                Link      => $LinkPage,
                IDPrefix  => 'CustomerITSMConfigItem',
            );

            @ViewableConfigItems = $ConfigItemObject->ConfigItemSearch(
                %{ $Filters{$Filter}->{Search} },
                %ColumnFilter,
                Limit  => $StartHit + $PageShown - 1,
                Result => 'ARRAY',
            );
        }

    }

    # TODO Maybe there is a more elegant way to do this?
    $Self->{Filter}  = $Filter;
    $Self->{Filters} = \%Filters;

    if ( $Self->{Subaction} eq 'AJAXFilterUpdate' ) {

        my $FilterContent = $LayoutObject->ITSMConfigItemListShow(
            FilterContentOnly     => 1,
            HeaderColumn          => $HeaderColumn,
            ElementChanged        => $ElementChanged,
            OriginalConfigItemIDs => \@OriginalViewableConfigItems,
            Action                => 'CustomerITSMConfigItem',
            Env                   => $Self,
            View                  => $View,
            EnableColumnFilters   => 1,
            Frontend              => 'Customer',
            Filter                => $Filter,
            Filters               => \%Filters,
        );

        if ( !$FilterContent ) {
            $LayoutObject->FatalError(
                Message => $LayoutObject->{LanguageObject}->Translate( 'Can\'t get filter content data of %s!', $HeaderColumn ),
            );
        }

        return $LayoutObject->Attachment(
            ContentType => 'application/json',
            Content     => $FilterContent,
            Type        => 'inline',
            NoCache     => 1,
        );
    }
    else {

        # store column filters
        my $StoredFilters = \%ColumnFilter;

        my $StoredFiltersKey = 'UserStoredFilterColumns-' . $Self->{Action} . '-' . $Self->{Filter};

        $UserObject->SetPreferences(
            UserID => $Self->{UserID},
            Key    => $StoredFiltersKey,
            Value  => $JSONObject->Encode( Data => $StoredFilters ),
        );
    }

    my $CountTotal = 0;
    my %NavBarFilter;
    for my $FilterColumn ( sort keys %Filters ) {
        my $Count = 0;
        if (@ViewableDeplStateIDs) {
            $Count = $ConfigItemObject->ConfigItemSearch(
                %{ $Filters{$FilterColumn}->{Search} },
                %ColumnFilter,
                Result => 'COUNT',
            ) || 0;
        }

        if ( $FilterColumn eq $Filter ) {
            $CountTotal = $Count;
        }

        $NavBarFilter{ $Filters{$FilterColumn}->{Prio} } = {
            Count  => $Count,
            Filter => $FilterColumn,
            %{ $Filters{$FilterColumn} },
        };
    }

    # show config items
    my $ConfigItemListHTML = $LayoutObject->ITSMConfigItemListShow(
        Filter                => $Filter,
        Filters               => \%NavBarFilter,
        ConfigItemIDs         => \@ViewableConfigItems,
        OriginalConfigItemIDs => \@OriginalViewableConfigItems,
        GetColumnFilter       => \%GetColumnFilter,
        LastColumnFilter      => $LastColumnFilter,
        Action                => 'CustomerITSMConfigItem',
        Total                 => $CountTotal,
        RequestedURL          => $Self->{RequestedURL},
        View                  => $View,
        TitleName             => $LayoutObject->{LanguageObject}->Translate('Overview: ITSM ConfigItem'),
        TitleValue            => $Self->{Filters}{$Filter}->{Name},
        Env                   => $Self,
        LinkPage              => $LinkPage,
        LinkSort              => $LinkSort,
        LinkFilter            => $LinkFilter,
        OrderBy               => $OrderBy,
        SortBy                => $SortBy,
        EnableColumnFilters   => 1,
        ColumnFilterForm      => {
            Filter => $Filter || '',
        },
        Frontend => 'Customer',

        # do not print the result earlier, but return complete content
        Output => 1,
    );

    if ( defined $ConfigObject->Get("CustomerFrontend::Module")->{"CustomerITSMConfigItemSearch"} ) {
        $LayoutObject->Block(
            Name => 'SearchBox',
        );
    }

    $Output .= $LayoutObject->Output(
        TemplateFile => 'CustomerITSMConfigItem',
        Data         => {
            ITSMConfigItemListHTML => $ConfigItemListHTML,
            %PageNav,
        },
    );

    # build NavigationBar
    $Output .= $LayoutObject->CustomerNavigationBar();

    # get page footer
    $Output .= $LayoutObject->CustomerFooter();

    return $Output;
}

1;

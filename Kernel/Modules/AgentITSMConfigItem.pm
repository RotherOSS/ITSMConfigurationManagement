# --
# OTOBO is a web-based ticketing system for service organisations.
# --
# Copyright (C) 2001-2020 OTRS AG, https://otrs.com/
# Copyright (C) 2019-2024 Rother OSS GmbH, https://otobo.io/
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

package Kernel::Modules::AgentITSMConfigItem;

use v5.24;
use strict;
use warnings;
use namespace::autoclean;

# core modules

# CPAN modules

# OTOBO modules
use Kernel::System::VariableCheck qw(IsArrayRefWithData IsHashRefWithData IsStringWithData);

our $ObjectManagerDisabled = 1;

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = bless {%Param}, $Type;

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
    my $UserObject = $Kernel::OM->Get('Kernel::System::User');

    # get filter from web request
    my $Filter         = $ParamObject->GetParam( Param => 'Filter' )   || 'All';
    my $CategoryFilter = $ParamObject->GetParam( Param => 'Category' ) || $Config->{DefaultCategory};

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
        $Output = $LayoutObject->Header(
            Refresh => $Refresh,
        );
        $Output .= $LayoutObject->NavigationBar();
    }

    # get general catalog object
    my $GeneralCatalogObject = $Kernel::OM->Get('Kernel::System::GeneralCatalog');

    # get class list
    my $ClassList = $GeneralCatalogObject->ItemList(
        Class => 'ITSM::ConfigItem::Class',
    );

    # get possible deployment state list for config items to be shown
    my $StateList = $GeneralCatalogObject->ItemList(
        Class       => 'ITSM::ConfigItem::DeploymentState',
        Preferences => {
            Functionality => [ 'preproductive', 'productive' ],
        },
    );

    # set the deployment state IDs parameter for the search
    my $DeplStateIDs;
    for my $DeplStateKey ( sort keys %{$StateList} ) {
        push @{$DeplStateIDs}, $DeplStateKey;
    }

    # viewable deployment states
    my @ViewableDeplStateIDs = keys %{
        $GeneralCatalogObject->ItemList(
            Class => 'ITSM::ConfigItem::DeploymentState',
            Valid => 1,
        )
    };

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
    my $PrioCounter         = 1000;
    my $CategoryPrioCounter = 1000;

    # to store the NavBar filters
    my %Filters;
    my %Category2ClassID;

    CLASSID:
    for my $ClassID ( sort { $ClassList->{$a} cmp $ClassList->{$b} } keys $ClassList->%* ) {

        # show menu link only if user has access rights
        my $HasAccess = $ConfigItemObject->Permission(
            Scope   => 'Class',
            ClassID => $ClassID,
            UserID  => $Self->{UserID},
            Type    => $Config->{Permission},
        );

        next CLASSID if !$HasAccess;

        # fetch class preferences to retrieve categories for class
        my %ClassPreferences = $GeneralCatalogObject->GeneralCatalogPreferencesGet(
            ItemID => $ClassID,
        );

        next CLASSID if !IsArrayRefWithData( $ClassPreferences{Categories} );

        for my $Category ( $ClassPreferences{Categories}->@* ) {
            push @{ $Category2ClassID{$Category} }, $ClassID;
        }
    }

    # order the category filters and - if not yet set - select the categpry shown
    my %CategoryFilters;
    {
        my @SortedCategories = sort keys %Category2ClassID;

        if ( !$CategoryFilter || !$Category2ClassID{$CategoryFilter} ) {
            $CategoryFilter = $Category2ClassID{Default} ? 'Default' : $SortedCategories[0];
        }

        my $Prio = 2;
        %CategoryFilters = map {
            $_ => {
                Name => $_,
                Prio => $Prio++,
            }
        } @SortedCategories;

        if ( $CategoryFilters{Default} ) {
            $CategoryFilters{Default}{Prio} = 1;
        }
    }

    # get the class filters for the selected category
    my $CountTotal = 0;
    my @AllCurrentClasses;
    if ($CategoryFilter) {

        my $Prio = 2;
        for my $ClassID ( $Category2ClassID{$CategoryFilter}->@* ) {
            my $CountClass = $ConfigItemObject->ConfigItemCount(
                ClassID => $ClassID,
            );
            if ( $Filter eq 'All' || ( $Filter && $Filter == $ClassID ) ) {
                $CountTotal += $CountClass;
            }

            push @AllCurrentClasses, $ClassID;

            # add filter with params for the search method
            $Filters{$ClassID} = {
                Name   => $ClassList->{$ClassID},
                Prio   => $Prio++,
                Count  => $CountClass,
                Search => {
                    ClassIDs     => [$ClassID],
                    DeplStateIDs => $DeplStateIDs,
                    %Sort,
                    Limit      => $Self->{SearchLimit},
                    Permission => $Permission,
                    UserID     => $Self->{UserID},
                },
            };
        }
    }

    # add "all" filter if there is not only one current filter, set the filter if not provided
    if ( scalar keys %Filters == 1 ) {
        ($Filter) = keys %Filters;
    }
    else {
        $Filters{All} = {
            Name   => 'All',
            Prio   => 1,
            Count  => $CountTotal,
            Search => {
                ClassIDs     => \@AllCurrentClasses,
                DeplStateIDs => $DeplStateIDs,
                %Sort,
                Limit      => $Self->{SearchLimit},
                Permission => $Permission,
                UserID     => $Self->{UserID},
            },
        };

        if ( !$Filter || !$Filters{$Filter} ) {
            $Filter = 'All';
        }
    }

    my $View = $ParamObject->GetParam( Param => 'View' ) || '';

    # lookup latest used view mode
    if ( !$View && $Self->{ 'UserConfigItemOverview' . $Self->{Action} } ) {
        $View = $Self->{ 'UserConfigItemOverview' . $Self->{Action} };
    }

    # otherwise use Preview as default as in LayoutConfigItem
    $View ||= 'Small';

    # Check if selected view is available.
    my $Backends = $ConfigObject->Get('ITSMConfigItem::Frontend::Overview');
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

    # do shown config item lookup
    my $Limit = 1_000;

    my $ElementChanged = $ParamObject->GetParam( Param => 'ElementChanged' ) || '';
    my $HeaderColumn   = $ElementChanged;
    $HeaderColumn =~ s{\A ColumnFilter }{}msxg;

    # get data (viewable config items...)
    # search all config items
    my @ViewableConfigItems;
    my @OriginalViewableConfigItems;

    if ( @ViewableDeplStateIDs && @AllCurrentClasses ) {

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

            my $Start = $ParamObject->GetParam( Param => 'StartHit' ) || 1;

            @ViewableConfigItems = $ConfigItemObject->ConfigItemSearch(
                %{ $Filters{$Filter}->{Search} },
                %ColumnFilter,
                Limit  => $Start + $PageShown - 1,
                Result => 'ARRAY',
            );
        }

    }

    # TODO Maybe there is a more elegant way to do this?
    $Self->{Filter}          = $Filter;
    $Self->{Filters}         = \%Filters;
    $Self->{CategoryFilters} = \%CategoryFilters;
    $Self->{CategoryFilter}  = $CategoryFilter;

    if ( $Self->{Subaction} eq 'AJAXFilterUpdate' ) {

        my $FilterContent = $LayoutObject->ITSMConfigItemListShow(
            FilterContentOnly     => 1,
            HeaderColumn          => $HeaderColumn,
            ElementChanged        => $ElementChanged,
            OriginalConfigItemIDs => \@OriginalViewableConfigItems,
            Action                => 'AgentITSMConfigItem',
            Env                   => $Self,
            View                  => $View,
            EnableColumnFilters   => 1,
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

    my %NavBarFilter = map {
        $CategoryFilters{$_}{Prio} => {
            CategoryFilter => $_,
            $CategoryFilters{$_}->%*,
        }
    } keys %CategoryFilters;

    my %ClassFilter = map {
        $Filters{$_}{Prio} => {
            Filter => $_,
            $Filters{$_}->%*,
        }
    } keys %Filters;

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
        . ';Category=' . $LayoutObject->Ascii2Html( Text => $CategoryFilter )
        . ';Filter=' . $LayoutObject->Ascii2Html( Text => $Filter )
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

    # show config items
    $Output .= $LayoutObject->ITSMConfigItemListShow(
        Filter                => $Filter,
        CategoryFilter        => $CategoryFilter,
        Filters               => \%ClassFilter,
        CategoryFilters       => \%NavBarFilter,
        ConfigItemIDs         => \@ViewableConfigItems,
        OriginalConfigItemIDs => \@OriginalViewableConfigItems,
        GetColumnFilter       => \%GetColumnFilter,
        LastColumnFilter      => $LastColumnFilter,
        Action                => 'AgentITSMConfigItem',
        Total                 => $CountTotal,
        RequestedURL          => $Self->{RequestedURL},
        View                  => $View,
        Bulk                  => 1,
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

        # do not print the result earlier, but return complete content
        Output => 1,
    );

    # get page footer
    $Output .= $LayoutObject->Footer() if $Self->{Subaction} ne 'AJAXFilterUpdate';

    return $Output;
}

1;

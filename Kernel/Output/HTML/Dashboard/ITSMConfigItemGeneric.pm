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

package Kernel::Output::HTML::Dashboard::ITSMConfigItemGeneric;

use strict;
use warnings;
use utf8;
use namespace::autoclean;

# core modules

# CPAN modules

# OTOBO modules
use Kernel::Language              qw(Translatable);
use Kernel::System::VariableCheck qw(:all);

our $ObjectManagerDisabled = 1;

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = \%Param;
    bless( $Self, $Type );

    # get needed parameters
    for my $Needed (qw(Config Name UserID)) {
        die "Got no $Needed!" if ( !$Self->{$Needed} );
    }

    # get general catalog object
    my $GeneralCatalogObject = $Kernel::OM->Get('Kernel::System::GeneralCatalog');

    # get class list
    my $ClassList = $GeneralCatalogObject->ItemList(
        Class => 'ITSM::ConfigItem::Class',
    );
    my %RevertedClassList = reverse $ClassList->%*;

    # get param object
    my $ParamObject = $Kernel::OM->Get('Kernel::System::Web::Request');

    my $RemoveFilters = $ParamObject->GetParam( Param => 'RemoveFilters' ) || $Param{RemoveFilters} || 0;

    # get sorting params
    for my $Item (qw(SortBy OrderBy)) {
        $Self->{$Item} = $ParamObject->GetParam( Param => $Item ) || $Param{$Item};
    }

    # Get add filters param.
    $Self->{AddFilters} = $ParamObject->GetParam( Param => 'AddFilters' ) || $Param{AddFilters} || 0;
    $Self->{TabAction}  = $ParamObject->GetParam( Param => 'TabAction' )  || $Param{TabAction}  || 0;

    # Get previous sorting column.
    $Self->{SortingColumn} = $ParamObject->GetParam( Param => 'SortingColumn' ) || $Param{SortingColumn};

    # set filter settings
    for my $Item (qw(ColumnFilter GetColumnFilter GetColumnFilterSelect)) {
        $Self->{$Item} = $Param{$Item};
    }

    # save column filters
    $Self->{PrefKeyColumnFilters}         = 'UserDashboardITSMConfigItemGenericColumnFilters' . $Self->{Name};
    $Self->{PrefKeyColumnFiltersRealKeys} = 'UserDashboardITSMConfigItemGenericColumnFiltersRealKeys' . $Self->{Name};

    # get needed objects
    my $JSONObject   = $Kernel::OM->Get('Kernel::System::JSON');
    my $ConfigObject = $Kernel::OM->Get('Kernel::Config');
    my $UserObject   = $Kernel::OM->Get('Kernel::System::User');

    if ($RemoveFilters) {
        $UserObject->SetPreferences(
            UserID => $Self->{UserID},
            Key    => $Self->{PrefKeyColumnFilters},
            Value  => '',
        );
        $UserObject->SetPreferences(
            UserID => $Self->{UserID},
            Key    => $Self->{PrefKeyColumnFiltersRealKeys},
            Value  => '',
        );
    }

    # just in case new filter values arrive
    elsif (
        IsHashRefWithData( $Self->{GetColumnFilter} )
        && IsHashRefWithData( $Self->{GetColumnFilterSelect} )
        && IsHashRefWithData( $Self->{ColumnFilter} )
        )
    {

        if ( !$ConfigObject->Get('DemoSystem') ) {

            # check if the user has filter preferences for this widget
            my %Preferences = $UserObject->GetPreferences(
                UserID => $Self->{UserID},
            );
            my $ColumnPrefValues;
            if ( $Preferences{ $Self->{PrefKeyColumnFilters} } ) {
                $ColumnPrefValues = $JSONObject->Decode(
                    Data => $Preferences{ $Self->{PrefKeyColumnFilters} },
                );
            }

            PREFVALUES:
            for my $Column ( sort keys %{ $Self->{GetColumnFilterSelect} } ) {
                if ( $Self->{GetColumnFilterSelect}->{$Column} eq 'DeleteFilter' ) {
                    delete $ColumnPrefValues->{$Column};
                    next PREFVALUES;
                }
                $ColumnPrefValues->{$Column} = $Self->{GetColumnFilterSelect}->{$Column};
            }

            $UserObject->SetPreferences(
                UserID => $Self->{UserID},
                Key    => $Self->{PrefKeyColumnFilters},
                Value  => $JSONObject->Encode( Data => $ColumnPrefValues ),
            );

            # save real key's name
            my $ColumnPrefRealKeysValues;
            if ( $Preferences{ $Self->{PrefKeyColumnFiltersRealKeys} } ) {
                $ColumnPrefRealKeysValues = $JSONObject->Decode(
                    Data => $Preferences{ $Self->{PrefKeyColumnFiltersRealKeys} },
                );
            }
            REALKEYVALUES:
            for my $Column ( sort keys %{ $Self->{ColumnFilter} } ) {
                next REALKEYVALUES if !$Column;

                my $DeleteFilter = 0;
                if ( IsArrayRefWithData( $Self->{ColumnFilter}->{$Column} ) ) {
                    if ( grep { $_ eq 'DeleteFilter' } @{ $Self->{ColumnFilter}->{$Column} } ) {
                        $DeleteFilter = 1;
                    }
                }
                elsif ( IsHashRefWithData( $Self->{ColumnFilter}->{$Column} ) ) {

                    if (
                        grep { $Self->{ColumnFilter}->{$Column}->{$_} eq 'DeleteFilter' }
                        keys %{ $Self->{ColumnFilter}->{$Column} }
                        )
                    {
                        $DeleteFilter = 1;
                    }
                }

                if ($DeleteFilter) {
                    delete $ColumnPrefRealKeysValues->{$Column};
                    delete $Self->{ColumnFilter}->{$Column};
                    next REALKEYVALUES;
                }
                $ColumnPrefRealKeysValues->{$Column} = $Self->{ColumnFilter}->{$Column};
            }
            $UserObject->SetPreferences(
                UserID => $Self->{UserID},
                Key    => $Self->{PrefKeyColumnFiltersRealKeys},
                Value  => $JSONObject->Encode( Data => $ColumnPrefRealKeysValues ),
            );

        }
    }

    # check if the user has filter preferences for this widget
    my %Preferences = $UserObject->GetPreferences(
        UserID => $Self->{UserID},
    );

    # get column names from Preferences
    my $PreferencesColumnFilters;
    if ( $Preferences{ $Self->{PrefKeyColumnFilters} } ) {
        $PreferencesColumnFilters = $JSONObject->Decode(
            Data => $Preferences{ $Self->{PrefKeyColumnFilters} },
        );
    }

    if ($PreferencesColumnFilters) {
        $Self->{GetColumnFilterSelect} = $PreferencesColumnFilters;
        my @ColumnFilters = keys %{$PreferencesColumnFilters};
        for my $Field (@ColumnFilters) {
            $Self->{GetColumnFilter}->{ $Field . $Self->{Name} } = $PreferencesColumnFilters->{$Field};
        }
    }

    # get column real names from Preferences
    my $PreferencesColumnFiltersRealKeys;
    if ( $Preferences{ $Self->{PrefKeyColumnFiltersRealKeys} } ) {
        $PreferencesColumnFiltersRealKeys = $JSONObject->Decode(
            Data => $Preferences{ $Self->{PrefKeyColumnFiltersRealKeys} },
        );
    }

    if ($PreferencesColumnFiltersRealKeys) {
        my @ColumnFiltersReal = keys %{$PreferencesColumnFiltersRealKeys};
        for my $Field (@ColumnFiltersReal) {
            $Self->{ColumnFilter}->{$Field} = $PreferencesColumnFiltersRealKeys->{$Field};
        }
    }

    # get current filter
    my $Name                     = $ParamObject->GetParam( Param => 'Name' ) || '';
    my $PreferencesKey           = 'UserDashboardITSMConfigItemGenericFilter' . $Self->{Name};
    my $AdditionalPreferencesKey = 'UserDashboardITSMConfigItemGenericAdditionalFilter' . $Self->{Name};
    if ( $Self->{Name} eq $Name ) {
        $Self->{Filter}           = $ParamObject->GetParam( Param => 'Filter' )           || '';
        $Self->{AdditionalFilter} = $ParamObject->GetParam( Param => 'AdditionalFilter' ) || '';
    }

    # Remember the selected filter in the session.
    if ( $Self->{Filter} ) {

        # update session
        $Kernel::OM->Get('Kernel::System::AuthSession')->UpdateSessionID(
            SessionID => $Self->{SessionID},
            Key       => $PreferencesKey,
            Value     => $Self->{Filter},
        );

        # update preferences
        if ( !$ConfigObject->Get('DemoSystem') ) {
            $UserObject->SetPreferences(
                UserID => $Self->{UserID},
                Key    => $PreferencesKey,
                Value  => $Self->{Filter},
            );
        }
    }
    else {
        $Self->{Filter} = $Self->{$PreferencesKey} || $Self->{Config}->{Filter} || 'AssignedToEntity';
    }

    # Remember the selected filter in the session.
    if ( $Self->{AdditionalFilter} ) {

        # update session
        $Kernel::OM->Get('Kernel::System::AuthSession')->UpdateSessionID(
            SessionID => $Self->{SessionID},
            Key       => $AdditionalPreferencesKey,
            Value     => $Self->{AdditionalFilter},
        );

        # update preferences
        if ( !$ConfigObject->Get('DemoSystem') ) {
            $UserObject->SetPreferences(
                UserID => $Self->{UserID},
                Key    => $AdditionalPreferencesKey,
                Value  => $Self->{AdditionalFilter},
            );
        }
    }
    else {
        $Self->{AdditionalFilter} = $Self->{$AdditionalPreferencesKey} || $Self->{Config}->{AdditionalFilter} || 'AssignedToEntity';
    }

    $Self->{PrefKeyShown}   = 'UserDashboardPref' . $Self->{Name} . '-Shown';
    $Self->{PrefKeyColumns} = 'UserDashboardPref' . $Self->{Name} . '-Columns';
    $Self->{PageShown}      = $Kernel::OM->Get('Kernel::Output::HTML::Layout')->{ $Self->{PrefKeyShown} }
        || $Self->{Config}->{Limit};
    $Self->{StartHit} = int( $ParamObject->GetParam( Param => 'StartHit' ) || 1 );

    # hash with all valid sortable columns (taken from ITSMConfigItemSearch)
    # SortBy  => 'Age',   # Created|Number|Changed|Name|DeplState|CurDeplState
    # |InciState|CurInciState
    $Self->{ValidSortableColumns} = {
        'Age'          => 1,
        'Number'       => 1,
        'Name'         => 1,
        'Created'      => 1,
        'LastChanged'  => 1,
        'DeplState'    => 1,
        'CurDeplState' => 1,
        'InciState'    => 1,
        'CurInciState' => 1,
    };

    # define filterable columns
    $Self->{ValidFiltrableColumns} = {
        'Class'        => 1,
        'DeplState'    => 1,
        'CurDeplState' => 1,
        'InciState'    => 1,
        'CurInciState' => 1,
    };

    # set config item key filter
    my %ConfigItemKeys;
    my %RemoveKeys;

    if ( IsHashRefWithData( $Self->{Config}{ConfigItemKey} ) ) {
        for my $Class ( keys $Self->{Config}{ConfigItemKey}->%* ) {
            push $ConfigItemKeys{ $Self->{Config}{ConfigItemKey}{$Class} }->@*, $RevertedClassList{$Class};
            $RemoveKeys{ $Self->{Config}{ConfigItemKey}{$Class} } = 1;
        }
    }
    $Self->{ConfigItemKeys} = \%ConfigItemKeys;

    if ( $Self->{Action} eq 'AgentCustomerInformationCenter' ) {
        my $CustomerUserWidgetConfig = $ConfigObject->Get('AgentCustomerUserInformationCenter::Backend###0060-CUIC-ITSMConfigItemCustomerUser');
        for my $ConfigItemKey ( keys $CustomerUserWidgetConfig->{Config}{ConfigItemKey}->%* ) {
            $RemoveKeys{$ConfigItemKey} = 1;
        }
    }

    # remove CustomerID if Customer Information Center
    for my $RemoveKey ( keys %RemoveKeys ) {
        delete $Self->{ColumnFilter}{$RemoveKey};
        delete $Self->{GetColumnFilter}{$RemoveKey};
        delete $Self->{GetColumnFilterSelect}{$RemoveKey};
        delete $Self->{ValidFiltrableColumns}{$RemoveKey};
    }

    return $Self;
}

sub Preferences {
    my ( $Self, %Param ) = @_;

    # configure columns
    my @ColumnsEnabled;
    my @ColumnsAvailable;
    my @ColumnsAvailableNotEnabled;

    # check for default settings
    if (
        $Self->{Config}->{DefaultColumns}
        && IsHashRefWithData( $Self->{Config}->{DefaultColumns} )
        )
    {
        @ColumnsAvailable = grep { $Self->{Config}->{DefaultColumns}->{$_} }
            keys %{ $Self->{Config}->{DefaultColumns} };
        @ColumnsEnabled = grep { $Self->{Config}->{DefaultColumns}->{$_} eq '2' }
            sort { $Self->_DefaultColumnSort() } keys %{ $Self->{Config}->{DefaultColumns} };
    }

    # check if the user has filter preferences for this widget
    my %Preferences = $Kernel::OM->Get('Kernel::System::User')->GetPreferences(
        UserID => $Self->{UserID},
    );

    # get JSON object
    my $JSONObject = $Kernel::OM->Get('Kernel::System::JSON');

    # if preference settings are available, take them
    if ( $Preferences{ $Self->{PrefKeyColumns} } ) {

        my $ColumnsEnabled = $JSONObject->Decode(
            Data => $Kernel::OM->Get('Kernel::Output::HTML::Layout')->{ $Self->{PrefKeyColumns} },
        );

        @ColumnsEnabled = grep { $ColumnsEnabled->{Columns}->{$_} == 1 }
            keys %{ $ColumnsEnabled->{Columns} };

        if ( $ColumnsEnabled->{Order} && @{ $ColumnsEnabled->{Order} } ) {
            @ColumnsEnabled = @{ $ColumnsEnabled->{Order} };
        }

        # remove duplicate columns
        my %UniqueColumns;
        my @ColumnsEnabledAux;

        for my $Column (@ColumnsEnabled) {
            if ( !$UniqueColumns{$Column} ) {
                push @ColumnsEnabledAux, $Column;
            }
            $UniqueColumns{$Column} = 1;
        }

        # set filtered column list
        @ColumnsEnabled = @ColumnsEnabledAux;
    }

    my %Columns;
    for my $ColumnName ( sort { $a cmp $b } @ColumnsAvailable ) {
        $Columns{Columns}->{$ColumnName} = ( grep { $ColumnName eq $_ } @ColumnsEnabled ) ? 1 : 0;
        if ( !grep { $_ eq $ColumnName } @ColumnsEnabled ) {
            push @ColumnsAvailableNotEnabled, $ColumnName;
        }
    }

    my @Params = (
        {
            Desc  => Translatable('Shown config items'),
            Name  => $Self->{PrefKeyShown},
            Block => 'Option',
            Data  => {
                5  => ' 5',
                10 => '10',
                15 => '15',
                20 => '20',
                25 => '25',
                50 => '50',
            },
            SelectedID  => $Self->{PageShown},
            Translation => 0,
        },
        {
            Desc             => Translatable('Shown Columns'),
            Name             => $Self->{PrefKeyColumns},
            Block            => 'AllocationList',
            Columns          => $JSONObject->Encode( Data => \%Columns ),
            ColumnsEnabled   => $JSONObject->Encode( Data => \@ColumnsEnabled ),
            ColumnsAvailable => $JSONObject->Encode( Data => \@ColumnsAvailableNotEnabled ),
            Translation      => 1,
        },
    );

    return @Params;
}

sub Config {
    my ( $Self, %Param ) = @_;

    # check if frontend module of link is used
    if ( $Self->{Config}->{Link} && $Self->{Config}->{Link} =~ /Action=(.+?)([&;].+?|)$/ ) {
        my $Action = $1;
        if ( !$Kernel::OM->Get('Kernel::Config')->Get('Frontend::Module')->{$Action} ) {
            $Self->{Config}->{Link} = '';
        }
    }

    return (
        %{ $Self->{Config} },

        # Don't cache this globally as it contains JS that is not inside of the HTML.
        CacheTTL => undef,
        CacheKey => undef,
    );
}

sub FilterContent {
    my ( $Self, %Param ) = @_;

    return if !$Param{FilterColumn};

    my $HeaderColumn = $Param{FilterColumn};
    my @OriginalViewableConfigItems;

    if (
        # TODO check
        $Kernel::OM->Get('Kernel::Config')->Get('OnlyValuesOnConfigItem')
        )
    {
        my %SearchParams            = $Self->_SearchParamsGet(%Param);
        my %ConfigItemSearch        = %{ $SearchParams{ConfigItemSearch} };
        my %ConfigItemSearchSummary = %{ $SearchParams{ConfigItemSearchSummary} };

        # Add the additional filter to the config item search param.
        if ( $Self->{AdditionalFilter} ) {
            %ConfigItemSearch = (
                %ConfigItemSearch,
                %{ $ConfigItemSearchSummary{ $Self->{AdditionalFilter} } },
            );
        }
    }

    if ( $HeaderColumn =~ m/^DynamicField_/ && !defined $Self->{DynamicField} ) {

        # get the dynamic fields for this screen
        $Self->{DynamicField} = $Kernel::OM->Get('Kernel::System::DynamicField')->DynamicFieldListGet(
            Valid      => 0,
            ObjectType => ['ITSMConfigItem'],
        );
    }

    # get column values for to build the filters later
    my $ColumnValues = $Self->_GetColumnValues(
        OriginalConfigItemIDs => \@OriginalViewableConfigItems,
        HeaderColumn          => $HeaderColumn,
    );

    # make sure that even a value of 0 is passed as a Selected value, e.g. Unchecked value of a
    # check-box dynamic field.
    my $SelectedValue = defined $Self->{GetColumnFilter}->{ $HeaderColumn . $Self->{Name} }
        ? $Self->{GetColumnFilter}->{ $HeaderColumn . $Self->{Name} }
        : '';

    my $LabelColumn = $HeaderColumn;
    if ( $LabelColumn =~ m{ \A DynamicField_ }xms ) {

        my $DynamicFieldConfig;
        $LabelColumn =~ s{\A DynamicField_ }{}xms;

        DYNAMICFIELD:
        for my $DFConfig ( @{ $Self->{DynamicField} } ) {
            next DYNAMICFIELD if !IsHashRefWithData($DFConfig);
            next DYNAMICFIELD if $DFConfig->{Name} ne $LabelColumn;

            $DynamicFieldConfig = $DFConfig;
            last DYNAMICFIELD;
        }
        if ( IsHashRefWithData($DynamicFieldConfig) ) {
            $LabelColumn = $DynamicFieldConfig->{Label};
        }
    }

    # variable to save the filter's HTML code
    my $ColumnFilterJSON = $Self->_ColumnFilterJSON(
        ColumnName    => $HeaderColumn,
        Label         => $LabelColumn,
        ColumnValues  => $ColumnValues->{$HeaderColumn},
        SelectedValue => $SelectedValue,
        DashboardName => $Self->{Name},
    );

    return $ColumnFilterJSON;

}

sub Run {
    my ( $Self, %Param ) = @_;

    my %SearchParams            = $Self->_SearchParamsGet(%Param);
    my @Columns                 = @{ $SearchParams{Columns} };
    my %ConfigItemSearch        = %{ $SearchParams{ConfigItemSearch} };
    my %ConfigItemSearchSummary = %{ $SearchParams{ConfigItemSearchSummary} };

    # define incident signals
    my %InciSignals = (
        Translatable('operational') => 'greenled',
        Translatable('warning')     => 'yellowled',
        Translatable('incident')    => 'redled',
    );

    # store deployment signals
    my %DeplSignals;

    # get general catalog object
    my $GeneralCatalogObject = $Kernel::OM->Get('Kernel::System::GeneralCatalog');

    # get list of deployment states
    my $DeploymentStatesList = $GeneralCatalogObject->ItemList(
        Class => 'ITSM::ConfigItem::DeploymentState',
    );

    # set deployment style colors
    my $StyleClasses = '';

    ITEMID:
    for my $ItemID ( sort keys %{$DeploymentStatesList} ) {

        # get deployment state preferences
        my %GeneralCatalogPreferences = $GeneralCatalogObject->GeneralCatalogPreferencesGet(
            ItemID => $ItemID,
        );

        # check if a color is defined in preferences
        next ITEMID unless $GeneralCatalogPreferences{Color};
        my ($Color) = $GeneralCatalogPreferences{Color}->@*;
        next ITEMID unless $Color;

        # get deployment state
        my $DeplState = $DeploymentStatesList->{$ItemID};

        # remove any non ascii word characters
        $DeplState =~ s{ [^a-zA-Z0-9] }{_}msxg;

        # store the original deployment state as key
        # and the ss safe converted deployment state as value
        $DeplSignals{ $DeploymentStatesList->{$ItemID} } = $DeplState;

        # convert to lower case
        my $DeplStateColor = lc $Color =~ s/[^0-9a-f]//msgr;

        # add to style classes string
        $StyleClasses .= "
            .Flag span.$DeplState {
                background-color: #$DeplStateColor;
            }
        ";
    }

    # wrap into style tags
    if ($StyleClasses) {
        $StyleClasses = "<style>$StyleClasses</style>";
    }

    my $CacheKey     = join '-', $Self->{Name}, $Self->{Action}, $Self->{PageShown}, $Self->{StartHit}, $Self->{UserID};
    my $CacheColumns = join(
        ',',
        map { $_ . '=>' . $Self->{GetColumnFilterSelect}->{$_} } sort keys %{ $Self->{GetColumnFilterSelect} }
    );
    $CacheKey .= '-' . $CacheColumns if $CacheColumns;

    # If SortBy parameter is not defined, set to value from %ConfigItemSearch, otherwise set to default value 'Age'.
    if ( !defined $Self->{SortBy} ) {
        if ( defined $ConfigItemSearch{SortBy} && $Self->{ValidSortableColumns}->{ $ConfigItemSearch{SortBy} } ) {
            $Self->{SortBy} = $ConfigItemSearch{SortBy};
        }
        else {
            $Self->{SortBy} = 'Age';
        }
    }

    $CacheKey .= '-' . $Self->{SortBy} if defined $Self->{SortBy};

    # Set OrderBy parameter to the search.
    my $IsCacheForUse = 0;
    if ( $Self->{OrderBy} ) {
        if (
            $Self->{AddFilters}
            || $Self->{TabAction}
            || !defined $Self->{SortingColumn}
            || $Self->{SortingColumn} ne $Self->{SortBy}
            )
        {
            $ConfigItemSearch{OrderBy} = $Self->{OrderBy};
            $IsCacheForUse = 1;
        }
        else {
            $ConfigItemSearch{OrderBy} = $Self->{OrderBy} eq 'Up' ? 'Down' : 'Up';
        }
    }

    # Set order for blocks.
    $ConfigItemSearch{OrderBy} = $ConfigItemSearch{OrderBy} || 'Down';

    # Set previous sorting column parameter for all columns.
    $Param{SortingColumn} = $Self->{SortBy};

    $CacheKey .= '-' . $ConfigItemSearch{OrderBy} if defined $ConfigItemSearch{OrderBy};

    # CustomerInformationCenter shows data per CustomerID
    if ( $Param{CustomerID} ) {
        $CacheKey .= '-' . $Param{CustomerID};
    }

    # CustomerUserInformationCenter shows data per CustomerUserID
    if ( $Param{CustomerUserID} ) {
        $CacheKey .= '-' . $Param{CustomerUserID};
    }

    # Add the additional filter always to the cache key, if a additional filter exists.
    if ( $Self->{AdditionalFilter} ) {
        $CacheKey .= '-' . $Self->{AdditionalFilter};
    }

    # get cache object
    my $CacheObject = $Kernel::OM->Get('Kernel::System::Cache');

    # check cache
    my $ConfigItemIDs = $CacheObject->Get(
        Type => 'Dashboard',
        Key  => $CacheKey . '-' . $Self->{Filter} . '-List',
    );

    # find and show config item list
    my $CacheUsed = 1;

    # get ticket object
    my $ConfigItemObject = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');

    if ( !$ConfigItemIDs ) {

        # add sort by parameter to the search
        if ( !defined $ConfigItemSearch{SortBy} || !$Self->{ValidSortableColumns}->{ $ConfigItemSearch{SortBy} } ) {
            if ( $Self->{SortBy} && $Self->{ValidSortableColumns}->{ $Self->{SortBy} } ) {
                $ConfigItemSearch{SortBy} = $Self->{SortBy};
            }
            else {
                $ConfigItemSearch{SortBy} = 'Age';
            }
        }

        $CacheUsed = $IsCacheForUse ? 1 : 0;

        my @ConfigItemIDsArray;

        # TODO understand
        if ( !$Self->{Config}->{IsProcessWidget} || IsArrayRefWithData( $Self->{ProcessList} ) ) {

            # Copy original column filter.
            my %ColumnFilter = %{ $Self->{ColumnFilter} || {} };

            # Execute search.
            if ( $Self->{AdditionalFilter} && IsArrayRefWithData( $ConfigItemSearchSummary{ $Self->{AdditionalFilter} } ) ) {

                for my $KeyConfig ( $ConfigItemSearchSummary{ $Self->{AdditionalFilter} }->@* ) {

                    # if classes are filtered, adjust search config accordingly
                    if ( $ColumnFilter{ClassIDs} ) {
                        my @FilteredClassIDs;
                        for my $ClassID ( $KeyConfig->{ClassIDs}->@* ) {
                            if ( grep { $_ == $ClassID } $ColumnFilter{ClassIDs}->@* ) {
                                push @FilteredClassIDs, $ClassID;
                            }
                        }
                        $KeyConfig->{ClassIDs} = \@FilteredClassIDs;
                    }

                    push @ConfigItemIDsArray, $ConfigItemObject->ConfigItemSearch(
                        Result => 'ARRAY',
                        %ConfigItemSearch,
                        $KeyConfig->%*,
                        %{ $ConfigItemSearchSummary{ $Self->{Filter} } },
                        %ColumnFilter,
                        Limit => $Self->{PageShown} + $Self->{StartHit} - 1,
                    );
                }
            }
        }
        $ConfigItemIDs = \@ConfigItemIDsArray;
    }

    # check cache
    my $Summary = $CacheObject->Get(
        Type => 'Dashboard',
        Key  => $CacheKey . '-Summary',
    ) // {};

    # If no cache or new list result, do count lookup.
    if ( !$Summary || !$CacheUsed ) {

        # Define the summary types for which no count is needed, because we have no output.
        my %LookupNoCountSummaryType = (
            AssignedToEntity => 1,
        );

        TYPE:
        for my $Type ( sort keys %ConfigItemSearchSummary ) {
            next TYPE if $LookupNoCountSummaryType{$Type};
            next TYPE if !$ConfigItemSearchSummary{$Type};

            # Copy original column filter.
            my %ColumnFilter = %{ $Self->{ColumnFilter} || {} };

            # Loop through all column filter elements.
            for my $Element ( sort keys %ColumnFilter ) {

                # Verify if current column filter element is already present in the config item search
                #   summary, to delete it from the column filter hash.
                if ( $Self->{AdditionalFilter} && grep { $_->{$Element} } $ConfigItemSearchSummary{ $Self->{AdditionalFilter} }->@* ) {
                    delete $ColumnFilter{$Element};
                }
            }

            $Summary->{$Type} = 0;

            if ( !$Self->{Config}->{IsProcessWidget} || IsArrayRefWithData( $Self->{ProcessList} ) ) {

                # Change filter name accordingly.
                my $Filter;

                # Filter is used and is not in user prefered values, show no results.
                # See bug#12808 ( https://bugs.otrs.org/show_bug.cgi?id=12808 ).
                if (
                    $Filter
                    && IsArrayRefWithData( $ConfigItemSearchSummary{$Type}->{$Filter} )
                    && IsArrayRefWithData( $ColumnFilter{$Filter} )
                    && !grep { $ColumnFilter{$Filter}->[0] == $_ } @{ $ConfigItemSearchSummary{$Type}->{$Filter} }
                    )
                {
                    $Summary->{$Type} = 0;
                }

                # Execute search.
                else {
                    $Summary->{$Type} = $ConfigItemObject->ConfigItemSearch(
                        Result => 'COUNT',
                        %ConfigItemSearch,
                        %{ $ConfigItemSearchSummary{$Type} },
                        %ColumnFilter,
                    ) || 0;
                }
            }
        }
    }

    # set cache
    if ( !$CacheUsed && $Self->{Config}->{CacheTTLLocal} ) {
        $CacheObject->Set(
            Type  => 'Dashboard',
            Key   => $CacheKey . '-Summary',
            Value => $Summary,
            TTL   => $Self->{Config}->{CacheTTLLocal} * 60,
        );
        $CacheObject->Set(
            Type  => 'Dashboard',
            Key   => $CacheKey . '-' . $Self->{Filter} . '-List',
            Value => $ConfigItemIDs,
            TTL   => $Self->{Config}->{CacheTTLLocal} * 60,
        );
    }

    # Set the css class for the selected filter and additional filter.
    $Summary->{ $Self->{Filter} . '::Selected' } = 'Selected';
    if ( $Self->{AdditionalFilter} ) {
        $Summary->{ $Self->{AdditionalFilter} . '::Selected' } = 'Selected';
    }

    my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');

    # show table header
    $LayoutObject->Block(
        Name => 'ContentLargeConfigItemGenericHeader',
        Data => {},
    );

    # remove (-) from name for JS config
    my $WidgetName = $Self->{Name};
    $WidgetName =~ s{-}{}g;

    # show non-labeled table headers
    my $CSS = '';

    # Send data to JS for init container.
    $LayoutObject->AddJSData(
        Key   => 'InitContainerDashboard' . $Self->{Name},
        Value => {
            SortBy  => $Self->{SortBy} || 'Age',
            OrderBy => $ConfigItemSearch{OrderBy},
        },
    );

    # send data to JS
    $LayoutObject->AddJSData(
        Key   => 'HeaderColumn' . $WidgetName,
        Value => \@Columns
    );

    # show all needed headers
    HEADERCOLUMN:
    for my $HeaderColumn (@Columns) {

        if ( $HeaderColumn !~ m{\A DynamicField_}xms ) {

            $CSS = '';
            my $Title = $LayoutObject->{LanguageObject}->Translate($HeaderColumn);

            # Set title description.
            if ( $Self->{SortBy} && $Self->{SortBy} eq $HeaderColumn ) {
                my $TitleDesc = '';
                if ( $ConfigItemSearch{OrderBy} eq 'Down' ) {
                    $CSS .= ' SortDescendingLarge';
                    $TitleDesc = Translatable('sorted descending');
                }
                else {
                    $CSS .= ' SortAscendingLarge';
                    $TitleDesc = Translatable('sorted ascending');
                }

                $TitleDesc = $LayoutObject->{LanguageObject}->Translate($TitleDesc);
                $Title .= ', ' . $TitleDesc;
            }

            # translate the column name to write it in the current language
            my $TranslatedWord;
            if ( $HeaderColumn eq 'DeplState' ) {
                $TranslatedWord = Translatable('Deployment State');
            }
            elsif ( $HeaderColumn eq 'CurDeplState' || $HeaderColumn eq 'CurDeplSignal' ) {
                $TranslatedWord = Translatable('Current Deployment State');
            }
            elsif ( $HeaderColumn eq 'CurDeplStateType' ) {
                $TranslatedWord = Translatable('Deployment State Type');
            }
            elsif ( $HeaderColumn eq 'InciState' ) {
                $TranslatedWord = Translatable('Incident State');
            }
            elsif ( $HeaderColumn eq 'CurInciState' || $HeaderColumn eq 'CurInciSignal' ) {
                $TranslatedWord = Translatable('Current Incident State');
            }
            elsif ( $HeaderColumn eq 'CurInciStateType' ) {
                $TranslatedWord = Translatable('Current Incident State Type');
            }
            elsif ( $HeaderColumn eq 'LastChanged' ) {
                $TranslatedWord = Translatable('Last changed');
            }
            else {
                $TranslatedWord = $LayoutObject->{LanguageObject}->Translate($HeaderColumn);
            }

            # add surrounding container
            $LayoutObject->Block(
                Name => 'GeneralOverviewHeader',
            );
            $LayoutObject->Block(
                Name => 'ContentLargeConfigItemGenericHeaderConfigItemHeader',
                Data => {},
            );

            my $FilterTitle     = $TranslatedWord;
            my $FilterTitleDesc = Translatable('filter not active');
            if ( $Self->{GetColumnFilterSelect} && $Self->{GetColumnFilterSelect}->{$HeaderColumn} ) {
                $CSS .= ' FilterActive';
                $FilterTitleDesc = Translatable('filter active');
            }
            $FilterTitleDesc = $LayoutObject->{LanguageObject}->Translate($FilterTitleDesc);
            $FilterTitle .= ', ' . $FilterTitleDesc;

            $LayoutObject->Block(
                Name => 'ContentLargeConfigItemGenericHeaderColumn',
                Data => {
                    HeaderColumnName     => $HeaderColumn   || '',
                    HeaderNameTranslated => $TranslatedWord || $HeaderColumn,
                    CSS                  => $CSS            || '',
                },
            );

            # verify if column is filterable and sortable
            if (
                $Self->{ValidSortableColumns}->{$HeaderColumn}
                && $Self->{ValidFiltrableColumns}->{$HeaderColumn}
                )
            {

                my $Css;

                # variable to save the filter's HTML code
                my $ColumnFilterHTML = $Self->_InitialColumnFilter(
                    ColumnName => $HeaderColumn,
                    Css        => $Css,
                );

                # send data to JS
                $LayoutObject->AddJSData(
                    Key   => 'ColumnFilterSort' . $HeaderColumn . $WidgetName,
                    Value => {
                        HeaderColumnName => $HeaderColumn,
                        Name             => $Self->{Name},
                        SortBy           => $Self->{SortBy} || 'Age',
                        OrderBy          => $ConfigItemSearch{OrderBy},
                        SortingColumn    => $Param{SortingColumn},
                    },
                );

                $LayoutObject->Block(
                    Name => 'ContentLargeConfigItemGenericHeaderColumnFilterLink',
                    Data => {
                        %Param,
                        HeaderColumnName     => $HeaderColumn,
                        CSS                  => $CSS,
                        HeaderNameTranslated => $TranslatedWord || $HeaderColumn,
                        ColumnFilterStrg     => $ColumnFilterHTML,
                        OrderBy              => $ConfigItemSearch{OrderBy},
                        SortBy               => $Self->{SortBy} || 'Age',
                        Name                 => $Self->{Name},
                        Title                => $Title,
                        FilterTitle          => $FilterTitle,
                    },
                );
            }

            # verify if column is just filterable
            elsif ( $Self->{ValidFiltrableColumns}->{$HeaderColumn} ) {

                my $Css;

                # variable to save the filter's HTML code
                my $ColumnFilterHTML = $Self->_InitialColumnFilter(
                    ColumnName => $HeaderColumn,
                    Css        => $Css,
                );

                # send data to JS
                $LayoutObject->AddJSData(
                    Key   => 'ColumnFilter' . $HeaderColumn . $WidgetName,
                    Value => {
                        HeaderColumnName => $HeaderColumn,
                        Name             => $Self->{Name},
                        SortBy           => $Self->{SortBy} || 'Age',
                        OrderBy          => $ConfigItemSearch{OrderBy},
                    },
                );

                $LayoutObject->Block(
                    Name => 'ContentLargeConfigItemGenericHeaderColumnFilter',
                    Data => {
                        %Param,
                        HeaderColumnName     => $HeaderColumn,
                        CSS                  => $CSS,
                        HeaderNameTranslated => $TranslatedWord || $HeaderColumn,
                        ColumnFilterStrg     => $ColumnFilterHTML,
                        Name                 => $Self->{Name},
                        Title                => $Title,
                        FilterTitle          => $FilterTitle,
                    },
                );
            }

            # verify if column is just sortable
            elsif ( $Self->{ValidSortableColumns}->{$HeaderColumn} ) {

                # send data to JS
                $LayoutObject->AddJSData(
                    Key   => 'ColumnSortable' . $HeaderColumn . $WidgetName,
                    Value => {
                        HeaderColumnName => $HeaderColumn,
                        Name             => $Self->{Name},
                        SortBy           => $Self->{SortBy} || $HeaderColumn,
                        OrderBy          => $ConfigItemSearch{OrderBy},
                        SortingColumn    => $Param{SortingColumn},
                    },
                );

                $LayoutObject->Block(
                    Name => 'ContentLargeConfigItemGenericHeaderColumnLink',
                    Data => {
                        %Param,
                        HeaderColumnName     => $HeaderColumn,
                        CSS                  => $CSS,
                        HeaderNameTranslated => $TranslatedWord || $HeaderColumn,
                        OrderBy              => $ConfigItemSearch{OrderBy},
                        SortBy               => $Self->{SortBy} || $HeaderColumn,
                        Name                 => $Self->{Name},
                        Title                => $Title,
                    },
                );
            }
            else {
                $LayoutObject->Block(
                    Name => 'ContentLargeConfigItemGenericHeaderColumnEmpty',
                    Data => {
                        %Param,
                        HeaderNameTranslated => $TranslatedWord || $HeaderColumn,
                        HeaderColumnName     => $HeaderColumn,
                        CSS                  => $CSS,
                        Title                => $Title,
                    },
                );
            }
        }

        # Dynamic fields
        else {
            my $DynamicFieldConfig;
            my $DFColumn = $HeaderColumn;
            $DFColumn =~ s/DynamicField_//g;
            DYNAMICFIELD:
            for my $DFConfig ( @{ $Self->{DynamicField} } ) {
                next DYNAMICFIELD if !IsHashRefWithData($DFConfig);
                next DYNAMICFIELD if $DFConfig->{Name} ne $DFColumn;

                $DynamicFieldConfig = $DFConfig;
                last DYNAMICFIELD;
            }
            next HEADERCOLUMN if !IsHashRefWithData($DynamicFieldConfig);

            my $Label = $DynamicFieldConfig->{Label};

            my $TranslatedLabel = $LayoutObject->{LanguageObject}->Translate($Label);

            my $DynamicFieldName = 'DynamicField_' . $DynamicFieldConfig->{Name};

            my $CSS             = '';
            my $FilterTitle     = $Label;
            my $FilterTitleDesc = Translatable('filter not active');
            if ( $Self->{GetColumnFilterSelect} && defined $Self->{GetColumnFilterSelect}->{$DynamicFieldName} ) {
                $CSS .= 'FilterActive ';
                $FilterTitleDesc = Translatable('filter active');
            }
            $FilterTitleDesc = $LayoutObject->{LanguageObject}->Translate($FilterTitleDesc);
            $FilterTitle .= ', ' . $FilterTitleDesc;

            # get field sortable condition
            my $IsSortable = $Kernel::OM->Get('Kernel::System::DynamicField::Backend')->HasBehavior(
                DynamicFieldConfig => $DynamicFieldConfig,
                Behavior           => 'IsSortable',
            );

            # set title
            my $Title = $Label;

            # add surrounding container
            $LayoutObject->Block(
                Name => 'GeneralOverviewHeader',
            );
            $LayoutObject->Block(
                Name => 'ContentLargeConfigItemGenericHeaderConfigItemHeader',
                Data => {},
            );

            if ($IsSortable) {
                my $TitleDesc = '';
                if (
                    $Self->{SortBy}
                    && ( $Self->{SortBy} eq ( 'DynamicField_' . $DynamicFieldConfig->{Name} ) )
                    )
                {
                    if ( $ConfigItemSearch{OrderBy} eq 'Down' ) {
                        $CSS .= ' SortDescendingLarge';
                        $TitleDesc = Translatable('sorted descending');
                    }
                    else {
                        $CSS .= ' SortAscendingLarge';
                        $TitleDesc = Translatable('sorted ascending');
                    }

                    $TitleDesc = $LayoutObject->{LanguageObject}->Translate($TitleDesc);
                    $Title .= ', ' . $TitleDesc;
                }

                $LayoutObject->Block(
                    Name => 'ContentLargeConfigItemGenericHeaderColumn',
                    Data => {
                        HeaderColumnName => $DynamicFieldName || '',
                        CSS              => $CSS              || '',
                    },
                );

                # check if the dynamic field is sortable and filterable (sortable check was made before)
                if ( $Self->{ValidFiltrableColumns}->{$DynamicFieldName} ) {

                    # variable to save the filter's HTML code
                    my $ColumnFilterHTML = $Self->_InitialColumnFilter(
                        ColumnName => $DynamicFieldName,
                        Label      => $Label,
                    );

                    # send data to JS
                    $LayoutObject->AddJSData(
                        Key   => 'ColumnFilterSort' . $DynamicFieldName . $WidgetName,
                        Value => {
                            HeaderColumnName => $DynamicFieldName,
                            Name             => $Self->{Name},
                            SortBy           => $Self->{SortBy} || 'Age',
                            OrderBy          => $ConfigItemSearch{OrderBy},
                            SortingColumn    => $Param{SortingColumn},
                        },
                    );

                    # output sortable and filterable dynamic field
                    $LayoutObject->Block(
                        Name => 'ContentLargeConfigItemGenericHeaderColumnFilterLink',
                        Data => {
                            %Param,
                            HeaderColumnName     => $DynamicFieldName,
                            CSS                  => $CSS,
                            HeaderNameTranslated => $TranslatedLabel || $DynamicFieldName,
                            ColumnFilterStrg     => $ColumnFilterHTML,
                            OrderBy              => $ConfigItemSearch{OrderBy},
                            SortBy               => $Self->{SortBy} || 'Age',
                            Name                 => $Self->{Name},
                            Title                => $Title,
                            FilterTitle          => $FilterTitle,
                        },
                    );
                }

                # otherwise the dynamic field is only sortable (sortable check was made before)
                else {

                    # send data to JS
                    $LayoutObject->AddJSData(
                        Key   => 'ColumnSortable' . $DynamicFieldName . $WidgetName,
                        Value => {
                            HeaderColumnName => $DynamicFieldName,
                            Name             => $Self->{Name},
                            SortBy           => $Self->{SortBy} || $DynamicFieldName,
                            OrderBy          => $ConfigItemSearch{OrderBy},
                            SortingColumn    => $Param{SortingColumn},
                        },
                    );

                    # output sortable dynamic field
                    $LayoutObject->Block(
                        Name => 'ContentLargeConfigItemGenericHeaderColumnLink',
                        Data => {
                            %Param,
                            HeaderColumnName     => $DynamicFieldName,
                            CSS                  => $CSS,
                            HeaderNameTranslated => $TranslatedLabel || $DynamicFieldName,
                            OrderBy              => $ConfigItemSearch{OrderBy},
                            SortBy               => $Self->{SortBy} || $DynamicFieldName,
                            Name                 => $Self->{Name},
                            Title                => $Title,
                            FilterTitle          => $FilterTitle,
                        },
                    );
                }
            }

            # if the dynamic field was not sortable (check was made and fail before)
            # it might be filterable
            elsif ( $Self->{ValidFiltrableColumns}->{$DynamicFieldName} ) {

                $LayoutObject->Block(
                    Name => 'ContentLargeConfigItemGenericHeaderColumn',
                    Data => {
                        HeaderColumnName => $DynamicFieldName || '',
                        CSS              => $CSS              || '',
                        Title            => $Title,
                    },
                );

                # variable to save the filter's HTML code
                my $ColumnFilterHTML = $Self->_InitialColumnFilter(
                    ColumnName => $DynamicFieldName,
                    Label      => $Label,
                );

                # send data to JS
                $LayoutObject->AddJSData(
                    Key   => 'ColumnFilter' . $DynamicFieldName . $WidgetName,
                    Value => {
                        HeaderColumnName => $DynamicFieldName,
                        Name             => $Self->{Name},
                        SortBy           => $Self->{SortBy} || 'Age',
                        OrderBy          => $ConfigItemSearch{OrderBy},
                    },
                );

                # output filterable (not sortable) dynamic field
                $LayoutObject->Block(
                    Name => 'ContentLargeConfigItemGenericHeaderColumnFilter',
                    Data => {
                        %Param,
                        HeaderColumnName     => $DynamicFieldName,
                        CSS                  => $CSS,
                        HeaderNameTranslated => $TranslatedLabel || $DynamicFieldName,
                        ColumnFilterStrg     => $ColumnFilterHTML,
                        Name                 => $Self->{Name},
                        Title                => $Title,
                        FilterTitle          => $FilterTitle,
                    },
                );
            }

            # otherwise the field is not filterable and not sortable
            else {

                $LayoutObject->Block(
                    Name => 'ContentLargeConfigItemGenericHeaderColumn',
                    Data => {
                        HeaderColumnName => $DynamicFieldName || '',
                        CSS              => $CSS              || '',
                    },
                );

                # output plain dynamic field header (not filterable, not sortable)
                $LayoutObject->Block(
                    Name => 'ContentLargeConfigItemGenericHeaderColumnEmpty',
                    Data => {
                        %Param,
                        HeaderNameTranslated => $TranslatedLabel || $DynamicFieldName,
                        HeaderColumnName     => $DynamicFieldName,
                        CSS                  => $CSS,
                        Title                => $Title,
                    },
                );
            }
        }
    }

    # show tickets
    my $Count = 0;
    CONFIGITEMID:
    for my $ConfigItemID ( @{$ConfigItemIDs} ) {
        $Count++;
        next CONFIGITEMID if $Count < $Self->{StartHit};
        my $ConfigItemRef = $ConfigItemObject->ConfigItemGet(
            ConfigItemID  => $ConfigItemID,
            DynamicFields => 0,
        );
        my %ConfigItem = $ConfigItemRef->%*;

        # set deployment and incident signals
        $ConfigItem{CurDeplSignal} = $DeplSignals{ $ConfigItem{CurDeplState} };
        $ConfigItem{CurInciSignal} = $InciSignals{ $ConfigItem{CurInciStateType} };

        next CONFIGITEMID if !%ConfigItem;

        # set a default title if config item has no title
        if ( !$ConfigItem{Title} ) {
            $ConfigItem{Title} = $LayoutObject->{LanguageObject}->Translate(
                'This ticket has no title or subject'
            );
        }

        # show config item
        $LayoutObject->Block(
            Name => 'ContentLargeConfigItemGenericRow',
            Data => \%ConfigItem,
        );

        # save column content
        my $DataValue;

        # get needed objects
        my $DynamicFieldBackendObject = $Kernel::OM->Get('Kernel::System::DynamicField::Backend');

        # show all needed columns
        COLUMN:
        for my $ConfigItemColumn (@Columns) {

            if ( $ConfigItemColumn !~ m{\A DynamicField_}xms ) {

                $LayoutObject->Block(
                    Name => 'GeneralOverviewRow',
                );
                $LayoutObject->Block(
                    Name => 'ContentLargeConfigItemGenericConfigItemColumn',
                    Data => {},
                );

                my $BlockType = '';
                my $CSSClass  = '';

                if ( $ConfigItemColumn eq 'Number' ) {
                    $LayoutObject->Block(
                        Name => 'ContentLargeConfigItemGenericConfigItemNumber',
                        Data => {
                            %ConfigItem,
                            Title => $ConfigItem{Number},
                        },
                    );
                    next COLUMN;
                }
                if ( $ConfigItemColumn eq 'Age' ) {
                    $DataValue = $LayoutObject->CustomerAge(
                        Age   => $ConfigItem{Age},
                        Space => ' ',
                    );
                }
                elsif (
                    $ConfigItemColumn eq 'CurDeplSignal'
                    )
                {
                    $BlockType = 'CurDepl';
                }
                elsif (
                    $ConfigItemColumn eq 'CurInciSignal'
                    )
                {
                    $BlockType = 'CurInci';
                }
                elsif ( $ConfigItemColumn eq 'Created' || $ConfigItemColumn eq 'Changed' ) {
                    $BlockType = 'Time';
                    $DataValue = $ConfigItem{$ConfigItemColumn};
                }
                else {
                    $DataValue = $ConfigItem{$ConfigItemColumn};
                }

                if ( $ConfigItemColumn eq 'Title' ) {
                    $LayoutObject->Block(
                        Name => "ContentLargeConfigItemTitle",
                        Data => {
                            Title      => "$DataValue " || '',
                            WholeTitle => "Dumb title",
                            Class      => $CSSClass || '',
                        },
                    );
                }
                elsif ( $ConfigItemColumn eq 'CurDeplSignal' || $ConfigItemColumn eq 'CurInciSignal' ) {
                    $LayoutObject->Block(
                        Name => "ContentLargeConfigItemSignal",
                        Data => {
                            State  => $ConfigItem{ $BlockType . 'State' },
                            Signal => $ConfigItem{ $BlockType . 'Signal' },
                            Class  => $CSSClass || '',
                        },
                    );

                }
                else {
                    $LayoutObject->Block(
                        Name => "ContentLargeConfigItemGenericColumn$BlockType",
                        Data => {
                            GenericValue => $DataValue || '-',
                            Class        => $CSSClass  || '',
                        },
                    );
                }

            }

            # dynamic fields
            else {

                # cycle trough the activated dynamic fields for this screen
                my $DynamicFieldConfig;
                my $DFColumn = $ConfigItemColumn;
                $DFColumn =~ s/DynamicField_//g;
                DYNAMICFIELD:
                for my $DFConfig ( @{ $Self->{DynamicField} } ) {
                    next DYNAMICFIELD if !IsHashRefWithData($DFConfig);
                    next DYNAMICFIELD if $DFConfig->{Name} ne $DFColumn;

                    $DynamicFieldConfig = $DFConfig;
                    last DYNAMICFIELD;
                }
                next CONFIGITEMCOLUMN if !IsHashRefWithData($DynamicFieldConfig);

                # get field value
                my $Value = $DynamicFieldBackendObject->ValueGet(
                    DynamicFieldConfig => $DynamicFieldConfig,
                    ObjectID           => $ConfigItem{VersionID},
                );

                my $ValueStrg = $DynamicFieldBackendObject->DisplayValueRender(
                    DynamicFieldConfig => $DynamicFieldConfig,
                    Value              => $Value,
                    ValueMaxChars      => 20,
                    LayoutObject       => $LayoutObject,
                );

                $LayoutObject->Block(
                    Name => 'ContentLargeConfigItemGenericDynamicField',
                    Data => {
                        Value => $ValueStrg->{Value},
                        Title => $ValueStrg->{Title},
                    },
                );

                if ( $ValueStrg->{Link} ) {
                    $LayoutObject->Block(
                        Name => 'ContentLargeConfigItemGenericDynamicFieldLink',
                        Data => {
                            Value                       => $ValueStrg->{Value},
                            Title                       => $ValueStrg->{Title},
                            Link                        => $ValueStrg->{Link},
                            $DynamicFieldConfig->{Name} => $ValueStrg->{Title},
                        },
                    );
                }
                else {
                    $LayoutObject->Block(
                        Name => 'ContentLargeConfigItemGenericDynamicFieldPlain',
                        Data => {
                            Value => $ValueStrg->{Value},
                            Title => $ValueStrg->{Title},
                        },
                    );
                }
            }

        }

    }

    # show "none" if no config item is available
    if ( !$ConfigItemIDs || !@{$ConfigItemIDs} ) {
        $LayoutObject->Block(
            Name => 'ContentLargeConfigItemGenericNone',
            Data => {},
        );
    }

    # check for refresh time
    my $Refresh = '';
    if ( $Self->{UserRefreshTime} ) {
        $Refresh = 60 * $Self->{UserRefreshTime};

        # send data to JS
        $LayoutObject->AddJSData(
            Key   => 'WidgetRefresh' . $WidgetName,
            Value => {
                Name           => $Self->{Name},
                NameHTML       => $WidgetName,
                RefreshTime    => $Refresh,
                CustomerID     => $Param{CustomerID},
                CustomerUserID => $Param{CustomerUserID},
            },
        );
    }

    # check for active filters and add a 'remove filters' button to the widget header
    my $FilterActive = 0;
    if ( $Self->{GetColumnFilterSelect} && IsHashRefWithData( $Self->{GetColumnFilterSelect} ) ) {
        $FilterActive = 1;
    }

    # send data to JS
    $LayoutObject->AddJSData(
        Key   => 'WidgetContainer' . $WidgetName,
        Value => {
            Name           => $Self->{Name},
            CustomerID     => $Param{CustomerID},
            CustomerUserID => $Param{CustomerUserID},
            FilterActive   => $FilterActive,
            SortBy         => $Self->{SortBy} || 'Age',
            OrderBy        => $ConfigItemSearch{OrderBy},
            SortingColumn  => $Param{SortingColumn},
        },
    );

    my $Content = $LayoutObject->Output(
        TemplateFile => 'AgentDashboardITSMConfigItemGeneric',
        Data         => {
            %{ $Self->{Config} },
            Name => $Self->{Name},
            %{$Summary},
            FilterValue      => $Self->{Filter},
            AdditionalFilter => $Self->{AdditionalFilter},
            CustomerID       => $Self->{CustomerID},
            CustomerUserID   => $Self->{CustomerUserID},
        },
        AJAX => $Param{AJAX},
    );

    return $Content;
}

sub _InitialColumnFilter {
    my ( $Self, %Param ) = @_;

    return if !$Param{ColumnName};
    return if !$Self->{ValidFiltrableColumns}->{ $Param{ColumnName} };

    # get layout object
    my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');

    my $Label = $Param{Label} || $Param{ColumnName};
    $Label = $LayoutObject->{LanguageObject}->Translate($Label);

    # set fixed values
    my $Data = [
        {
            Key   => '',
            Value => uc $Label,
        },
    ];

    # define if column filter values should be translatable
    my $TranslationOption = 0;

    if (
        $Param{ColumnName} eq 'DeplState'
        || $Param{ColumnName} eq 'CurDeplState'
        || $Param{ColumnName} eq 'InciState'
        || $Param{ColumnName} eq 'CurInciState'
        || $Param{ColumnName} eq 'Class'
        )
    {
        $TranslationOption = 1;
    }

    my $Class = 'ColumnFilter';
    if ( $Param{Css} ) {
        $Class .= ' ' . $Param{Css};
    }

    # build select HTML
    my $ColumnFilterHTML = $LayoutObject->BuildSelection(
        Name        => 'ColumnFilter' . $Param{ColumnName} . $Self->{Name},
        Data        => $Data,
        Class       => $Class,
        Translation => $TranslationOption,
        SelectedID  => '',
    );
    return $ColumnFilterHTML;
}

sub _GetColumnValues {
    my ( $Self, %Param ) = @_;

    return if !IsStringWithData( $Param{HeaderColumn} );

    my $HeaderColumn = $Param{HeaderColumn};
    my %ColumnFilterValues;
    my $ConfigItemIDs;

    if ( IsArrayRefWithData( $Param{OriginalConfigItemIDs} ) ) {
        $ConfigItemIDs = $Param{OriginalConfigItemIDs};
    }

    if ( $HeaderColumn !~ m/^DynamicField_/ ) {
        my $FunctionName = $HeaderColumn . 'FilterValuesGet';

        $ColumnFilterValues{$HeaderColumn} = $Kernel::OM->Get('Kernel::System::ITSMConfigItem::ColumnFilter')->$FunctionName(
            ConfigItemIDs => $ConfigItemIDs,
            HeaderColumn  => $HeaderColumn,
            UserID        => $Self->{UserID},
        );
    }
    else {
        DYNAMICFIELD:
        for my $DynamicFieldConfig ( @{ $Self->{DynamicField} } ) {

            next DYNAMICFIELD if !IsHashRefWithData($DynamicFieldConfig);

            my $FieldName = 'DynamicField_' . $DynamicFieldConfig->{Name};

            next DYNAMICFIELD if $FieldName ne $HeaderColumn;

            # get dynamic field backend object
            my $BackendObject = $Kernel::OM->Get('Kernel::System::DynamicField::Backend');

            my $IsFiltrable = $BackendObject->HasBehavior(
                DynamicFieldConfig => $DynamicFieldConfig,
                Behavior           => 'IsFiltrable',
            );

            next DYNAMICFIELD if !$IsFiltrable;

            $Self->{ValidFiltrableColumns}->{$HeaderColumn} = $IsFiltrable;
            if ( IsArrayRefWithData($ConfigItemIDs) ) {

                # get the historical values for the field
                $ColumnFilterValues{$HeaderColumn} = $BackendObject->ColumnFilterValuesGet(
                    DynamicFieldConfig => $DynamicFieldConfig,
                    LayoutObject       => $Kernel::OM->Get('Kernel::Output::HTML::Layout'),
                    ConfigItemIDs      => $ConfigItemIDs,
                );
            }
            else {

                # get PossibleValues
                $ColumnFilterValues{$HeaderColumn} = $BackendObject->PossibleValuesGet(
                    DynamicFieldConfig => $DynamicFieldConfig,
                );
            }
            last DYNAMICFIELD;
        }
    }

    return \%ColumnFilterValues;
}

# =head2 _ColumnFilterJSON()

#     creates a JSON select filter for column header

#     my $ColumnFilterJSON = $ITSMConfigItemOverviewSmallObject->_ColumnFilterJSON(
#         ColumnName => 'Queue',
#         Label      => 'Queue',
#         ColumnValues => {
#             1 => 'PostMaster',
#             2 => 'Junk',
#         },
#         SelectedValue '1',
#     );

# =cut

sub _ColumnFilterJSON {
    my ( $Self, %Param ) = @_;

    return if !$Param{ColumnName};
    return if !$Self->{ValidFiltrableColumns}->{ $Param{ColumnName} };

    # get layout object
    my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');

    my $Label = $Param{Label};
    $Label =~ s{ \A DynamicField_ }{}gxms;
    $Label = $LayoutObject->{LanguageObject}->Translate($Label);

    # set fixed values
    my $Data = [
        {
            Key   => 'DeleteFilter',
            Value => uc $Label,
        },
        {
            Key      => '-',
            Value    => '-',
            Disabled => 1,
        },
    ];

    if ( $Param{ColumnValues} && ref $Param{ColumnValues} eq 'HASH' ) {

        my %Values = %{ $Param{ColumnValues} };

        # Set possible values.
        for my $ValueKey ( sort { lc $Values{$a} cmp lc $Values{$b} } keys %Values ) {
            push @{$Data}, {
                Key   => $ValueKey,
                Value => $Values{$ValueKey},
            };
        }
    }

    # define if column filter values should be translatable
    my $TranslationOption = 0;

    if (
        $Param{ColumnName} eq 'DeplState'
        || $Param{ColumnName} eq 'CurDeplState'
        || $Param{ColumnName} eq 'InciState'
        || $Param{ColumnName} eq 'CurInciState'
        || $Param{ColumnName} eq 'Class'
        )
    {
        $TranslationOption = 1;
    }

    # build select HTML
    my $JSON = $LayoutObject->BuildSelectionJSON(
        [
            {
                Name         => 'ColumnFilter' . $Param{ColumnName} . $Param{DashboardName},
                Data         => $Data,
                Class        => 'ColumnFilter',
                Sort         => 'AlphanumericKey',
                TreeView     => 1,
                SelectedID   => $Param{SelectedValue},
                Translation  => $TranslationOption,
                AutoComplete => 'off',
            },
        ],
    );

    return $JSON;
}

sub _SearchParamsGet {
    my ( $Self, %Param ) = @_;

    # get all search base attributes
    my %ConfigItemSearch;
    my %DynamicFieldsParameters;
    my @Params = split /;/, $Self->{Config}->{Attributes};

    # read user preferences and config to get columns that
    # should be shown in the dashboard widget (the preferences
    # have precedence)
    my %Preferences = $Kernel::OM->Get('Kernel::System::User')->GetPreferences(
        UserID => $Self->{UserID},
    );

    # get column names from Preferences
    my $PreferencesColumn = $Kernel::OM->Get('Kernel::System::JSON')->Decode(
        Data => $Preferences{ $Self->{PrefKeyColumns} },
    );

    # check for default settings
    my @Columns;
    if ( $Self->{Config}->{DefaultColumns} && IsHashRefWithData( $Self->{Config}->{DefaultColumns} ) ) {
        @Columns = grep { $Self->{Config}->{DefaultColumns}->{$_} eq '2' }
            sort { $Self->_DefaultColumnSort() } keys %{ $Self->{Config}->{DefaultColumns} };
    }
    if ($PreferencesColumn) {
        if ( $PreferencesColumn->{Columns} && %{ $PreferencesColumn->{Columns} } ) {
            @Columns = grep {
                defined $PreferencesColumn->{Columns}->{$_}
                    && $PreferencesColumn->{Columns}->{$_} eq '1'
            } sort { $Self->_DefaultColumnSort() } keys %{ $Self->{Config}->{DefaultColumns} };
        }
        if ( $PreferencesColumn->{Order} && @{ $PreferencesColumn->{Order} } ) {
            @Columns = @{ $PreferencesColumn->{Order} };
        }

        # remove duplicate columns
        my %UniqueColumns;
        my @ColumnsEnabledAux;

        for my $Column (@Columns) {
            if ( !$UniqueColumns{$Column} ) {
                push @ColumnsEnabledAux, $Column;
            }
            $UniqueColumns{$Column} = 1;
        }

        # set filtered column list
        @Columns = @ColumnsEnabledAux;
    }

    {

        # loop through all the dynamic fields to get the ones that should be shown
        DYNAMICFIELDNAME:
        for my $DynamicFieldName (@Columns) {

            next DYNAMICFIELDNAME if $DynamicFieldName !~ m{ DynamicField_ }xms;

            # remove dynamic field prefix
            my $FieldName = $DynamicFieldName;
            $FieldName =~ s/DynamicField_//gi;
            $Self->{DynamicFieldFilter}->{$FieldName} = 1;
        }
    }

    # get the dynamic fields for this screen
    $Self->{DynamicField} = $Kernel::OM->Get('Kernel::System::DynamicField')->DynamicFieldListGet(
        Valid       => 1,
        ObjectType  => ['ITSMConfigItem'],
        FieldFilter => $Self->{DynamicFieldFilter} || {},
    );

    # get dynamic field backend object
    my $BackendObject = $Kernel::OM->Get('Kernel::System::DynamicField::Backend');

    # get filterable Dynamic fields
    # cycle trough the activated Dynamic Fields for this screen
    DYNAMICFIELD:
    for my $DynamicFieldConfig ( @{ $Self->{DynamicField} } ) {
        next DYNAMICFIELD if !IsHashRefWithData($DynamicFieldConfig);

        my $IsFiltrable = $BackendObject->HasBehavior(
            DynamicFieldConfig => $DynamicFieldConfig,
            Behavior           => 'IsFiltrable',
        );

        # if the dynamic field is filterable add it to the ValidFiltrableColumns hash
        if ($IsFiltrable) {
            $Self->{ValidFiltrableColumns}->{ 'DynamicField_' . $DynamicFieldConfig->{Name} } = 1;
        }
    }

    # get sortable Dynamic fields
    # cycle trough the activated Dynamic Fields for this screen
    DYNAMICFIELD:
    for my $DynamicFieldConfig ( @{ $Self->{DynamicField} } ) {
        next DYNAMICFIELD if !IsHashRefWithData($DynamicFieldConfig);

        my $IsSortable = $BackendObject->HasBehavior(
            DynamicFieldConfig => $DynamicFieldConfig,
            Behavior           => 'IsSortable',
        );

        # if the dynamic field is sortable add it to the ValidSortableColumns hash
        if ($IsSortable) {
            $Self->{ValidSortableColumns}->{ 'DynamicField_' . $DynamicFieldConfig->{Name} } = 1;
        }
    }

    STRING:
    for my $String (@Params) {
        next STRING if !$String;
        my ( $Key, $Value ) = split /=/, $String;

        # push ARRAYREF attributes directly in an ARRAYREF
        if (
            $Key
            =~ /^(StateType|StateTypeIDs|States|StateIDs|ArchiveFlags|CreatedUserIDs|CreatedStates|CreatedStateIDs)$/
            )
        {
            if ( $Value =~ m{,}smx ) {
                push @{ $ConfigItemSearch{$Key} }, split( /,/, $Value );
            }
            else {
                push @{ $ConfigItemSearch{$Key} }, $Value;
            }
        }

        # check if parameter is a dynamic field and capture dynamic field name (with DynamicField_)
        # in $1 and the Operator in $2
        # possible Dynamic Fields options include:
        #   DynamicField_NameX_Equals=123;
        #   DynamicField_NameX_Like=value*;
        #   DynamicField_NameX_GreaterThan=2001-01-01 01:01:01;
        #   DynamicField_NameX_GreaterThanEquals=2001-01-01 01:01:01;
        #   DynamicField_NameX_SmallerThan=2002-02-02 02:02:02;
        #   DynamicField_NameX_SmallerThanEquals=2002-02-02 02:02:02;
        elsif ( $Key =~ m{\A (DynamicField_.+?) _ (.+?) \z}sxm ) {
            push @{ $DynamicFieldsParameters{$1}->{$2} }, $Value;
        }

        elsif ( !defined $ConfigItemSearch{$Key} ) {

            # change sort by, if needed
            if (
                $Key eq 'SortBy'
                && $Self->{SortBy}
                && $Self->{ValidSortableColumns}->{ $Self->{SortBy} }
                )
            {
                $Value = $Self->{SortBy};
            }
            elsif ( $Key eq 'SortBy' && !$Self->{ValidSortableColumns}->{$Value} ) {
                $Value = 'Age';
            }
            $ConfigItemSearch{$Key} = $Value;
        }
        elsif ( !ref $ConfigItemSearch{$Key} ) {
            my $ValueTmp = $ConfigItemSearch{$Key};
            $ConfigItemSearch{$Key} = [$ValueTmp];
            push @{ $ConfigItemSearch{$Key} }, $Value;
        }
        else {
            push @{ $ConfigItemSearch{$Key} }, $Value;
        }
    }
    %ConfigItemSearch = (
        %ConfigItemSearch,
        %DynamicFieldsParameters,

        # TODO check if permission is needed
        Permission => $Self->{Config}->{Permission} || 'ro',
        UserID     => $Self->{UserID},
    );

    my %ConfigItemSearchSummary;
    if ( $Self->{Action} eq 'AgentCustomerUserInformationCenter' ) {

        # Add filters for assigend and accessible config items for the customer user information center as a
        #   additional filter together with the other filters. One of them must be always active.
        my @ConfigItemKeyConfigs;
        for my $ConfigItemKeyDF ( keys $Self->{ConfigItemKeys}->%* ) {
            push @ConfigItemKeyConfigs, {
                ClassIDs                        => $Self->{ConfigItemKeys}{$ConfigItemKeyDF},
                "DynamicField_$ConfigItemKeyDF" => {
                    Equals => $Param{CustomerUserID} // undef,
                },
            };
        }
        %ConfigItemSearchSummary = (
            AssignedToEntity => \@ConfigItemKeyConfigs,
            %ConfigItemSearchSummary,
        );
    }
    elsif ( $Self->{Action} eq 'AgentCustomerInformationCenter' ) {

        # Add filters for assigend and accessible config items for the customer user information center as a
        #   additional filter together with the other filters. One of them must be always active.
        my @ConfigItemKeyConfigs;
        for my $ConfigItemKeyDF ( keys $Self->{ConfigItemKeys}->%* ) {
            push @ConfigItemKeyConfigs, {
                ClassIDs                        => $Self->{ConfigItemKeys}{$ConfigItemKeyDF},
                "DynamicField_$ConfigItemKeyDF" => {
                    Equals => $Param{CustomerID} // undef,
                },
            };
        }
        %ConfigItemSearchSummary = (
            AssignedToEntity => \@ConfigItemKeyConfigs,
            %ConfigItemSearchSummary,
        );
    }

    return (
        Columns                 => \@Columns,
        ConfigItemSearch        => \%ConfigItemSearch,
        ConfigItemSearchSummary => \%ConfigItemSearchSummary,
    );
}

sub _DefaultColumnSort {

    my %DefaultColumns = (
        CurDeplSignal => 110,
        CurInciSignal => 111,
        Class         => 112,
        Number        => 113,
        Name          => 114,
        CurDeplState  => 115,
        CurInciState  => 116,
        LastChanged   => 117,
    );

    # dynamic fields can not be on the DefaultColumns sorting hash
    # when comparing 2 dynamic fields sorting must be alphabetical
    if ( !$DefaultColumns{$a} && !$DefaultColumns{$b} ) {
        return $a cmp $b;
    }

    # when a dynamic field is compared to a config item attribute it must be higher
    elsif ( !$DefaultColumns{$a} ) {
        return 1;
    }

    # when a config item attribute is compared to a dynamic field it must be lower
    elsif ( !$DefaultColumns{$b} ) {
        return -1;
    }

    # otherwise do a numerical comparison with the config item attributes
    return $DefaultColumns{$a} <=> $DefaultColumns{$b};
}

1;

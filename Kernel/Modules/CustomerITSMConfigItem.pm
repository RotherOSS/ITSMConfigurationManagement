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

package Kernel::Modules::CustomerITSMConfigItem;
## nofilter(TidyAll::Plugin::OTOBO::Perl::DBObject)

use strict;
use warnings;

our $ObjectManagerDisabled = 1;

use Kernel::System::VariableCheck qw(:all);
use Kernel::Language qw(Translatable);

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {%Param};
    bless( $Self, $Type );

    return $Self;
}

sub Run {
    my ( $Self, %Param ) = @_;

    my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');
    my $ConfigObject = $Kernel::OM->Get('Kernel::Config');
    my $ParamObject  = $Kernel::OM->Get('Kernel::System::Web::Request');

    if ( !$Self->{Subaction} ) {
        return $LayoutObject->Redirect(
            OP => 'Action=CustomerITSMConfigItem;Subaction=MyITSMConfigItems',
        );
    }

    # check needed CustomerID
    if ( !$Self->{UserCustomerID} ) {
        my $Output = $LayoutObject->CustomerHeader(
            Title => Translatable('Error'),
        );
        $Output .= $LayoutObject->CustomerError(
            Message => Translatable('Need CustomerID!'),
        );
        $Output .= $LayoutObject->CustomerFooter();

        return $Output;
    }

    # store last queue screen
    $Kernel::OM->Get('Kernel::System::AuthSession')->UpdateSessionID(
        SessionID => $Self->{SessionID},
        Key       => 'LastScreenOverview',
        Value     => $Self->{RequestedURL},
    );

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

    # filter definition
    my %Filters = (
        MyITSMConfigItems => {
            All => {
                Name   => 'All',
                Prio   => 1000,
                Search => {
                    OrderBy => $OrderBy,
                    SortBy  => $SortBy,
                },
            },
        },
    );

    my $UserObject = $Kernel::OM->Get('Kernel::System::CustomerUser');

    my @CustomerIDs;

    my %AccessibleCustomers = $Kernel::OM->Get('Kernel::System::CustomerGroup')->GroupContextCustomers(
        CustomerUserID => $Self->{UserID},
    );

    @CustomerIDs = sort keys %AccessibleCustomers;

    if ( $Self->{Subaction} eq 'Search' ) {

        # check whether company tickets are shown
        my %Selection = @CustomerIDs
            ?
            ( CustomerIDRaw => \@CustomerIDs )
            :
            ( CustomerUserLoginRaw => $Self->{UserID} );

        $Filters{Search} = {
            All => {
                Name   => 'All',
                Prio   => 1000,
                Search => {
                    %Selection,
                    OrderBy => $OrderBy,
                    SortBy  => $SortBy,

                    # TODO check which params are needed
                    # Fulltext            => $Fulltext,
                    # FullTextIndex       => 1,
                    # ContentSearchPrefix => '*',
                    # ContentSearchSuffix => '*',
                },
            },
        };
    }

    my $FilterCurrent = $ParamObject->GetParam( Param => 'Filter' );
    if ( !$FilterCurrent ) {

        # TODO adapt
        $FilterCurrent = ( $Self->{Subaction} && $Self->{Subaction} eq 'Search' ) ? 'All' : 'All';
    }

    # check if filter is valid
    if ( !$Filters{ $Self->{Subaction} }->{$FilterCurrent} ) {
        my $Output = $LayoutObject->CustomerHeader(
            Title => Translatable('Error'),
        );
        $Output .= $LayoutObject->CustomerError(
            Message => $LayoutObject->{LanguageObject}->Translate( 'Invalid Filter: %s!', $FilterCurrent ),
        );
        $Output .= $LayoutObject->CustomerFooter();

        return $Output;
    }

    # TODO check if this stuff is needed
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

    # viewable incident states
    my @ViewableInciStateIDs = keys %{
        $GeneralCatalogObject->ItemList(
            Class => 'ITSM::Core::IncidentState',
            Valid => 1,
        )
    };

    # get permissions
    my $Permission = 'rw';

    my %NavBarFilter;
    my $Counter                 = 0;
    my $AllITSMConfigItems      = 0;
    my $AllITSMConfigItemsTotal = 0;
    my $ITSMConfigItemObject    = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');

    for my $Filter ( sort keys %{ $Filters{ $Self->{Subaction} } } ) {
        $Counter++;

        my $Count = $ITSMConfigItemObject->ConfigItemSearch(
            %{ $Filters{ $Self->{Subaction} }->{$Filter}->{Search} },
            Result => 'COUNT',
        ) || 0;

        my $ClassA = '';
        if ( $Filter eq $FilterCurrent ) {
            $ClassA             = 'Selected';
            $AllITSMConfigItems = $Count;
        }
        if ( $Filter eq 'All' ) {
            $AllITSMConfigItemsTotal = $Count;
        }
        $NavBarFilter{ $Filters{ $Self->{Subaction} }->{$Filter}->{Prio} } = {
            %{ $Filters{ $Self->{Subaction} }->{$Filter} },
            Count  => $Count,
            Filter => $Filter,
            ClassA => $ClassA,
        };
    }

    my $StartHit  = int( $ParamObject->GetParam( Param => 'StartHit' ) || 1 );
    my $PageShown = $Self->{UserShowITSMConfigItems} || 1;
    my $ITSMConfigItemListHTML;
    my %PageNav;

    if ( !$AllITSMConfigItemsTotal ) {

        # TODO check sysconfig key
        my $CustomTexts = $ConfigObject->Get('ITSMConfigItem::Frontend::CustomerITSMConfigItemOverviewCustomEmptyText');

        # show message if there are no tickets
        my $ITSMConfigItemListObject = $Kernel::OM->Get('Kernel::Output::HTML::ITSMConfigItem::CustomerList');
        $ITSMConfigItemListHTML = $ITSMConfigItemListObject->Run(
            ITSMConfigItemIDs => [],
            NoAllTotal        => $Self->{Subaction} eq 'Search' ? 0            : 1,
            CustomTexts       => ( ref $CustomTexts eq 'HASH' ) ? $CustomTexts : 0,
        );

    }
    else {

        if ( $AllITSMConfigItems > $PageShown ) {

            # create pagination
            my $Link = 'SortBy=' . $LayoutObject->Ascii2Html( Text => $SortBy )
                . ';OrderBy=' . $LayoutObject->Ascii2Html( Text => $OrderBy )
                . ';Filter=' . $LayoutObject->Ascii2Html( Text => $FilterCurrent )
                . ';Subaction=' . $LayoutObject->Ascii2Html( Text => $Self->{Subaction} )
                . ';';

            # # remember fulltext query
            # if ( defined $Fulltext ) {
            #     $Link .= 'Fulltext=' . $LayoutObject->Ascii2Html( Text => $Fulltext ) . ';';
            # }

            # Add CustomerIDs parameter if needed.
            if ( IsArrayRefWithData( \@CustomerIDs ) ) {
                for my $CustomerID (@CustomerIDs) {
                    $Link .= "CustomerIDs=$CustomerID;";
                }
            }

            %PageNav = $LayoutObject->PageNavBar(
                Limit     => 10000,
                StartHit  => $StartHit,
                PageShown => $PageShown,
                AllHits   => $AllITSMConfigItems,
                Action    => 'Action=CustomerITSMConfigItem',
                Link      => $Link,
                IDPrefix  => 'CustomerITSMConfigItem',
            );
        }

        my $Sort               = '';
        my $ITSMConfigItemSort = '';
        my $TitleSort          = '';
        my $AgeSort            = '';

        # this sets the opposite to the $OrderBy
        if ( $OrderBy eq 'Down' ) {
            $Sort = 'SortAscending';
        }
        if ( $OrderBy eq 'Up' ) {
            $Sort = 'SortDescending';
        }

        if ( $SortBy eq 'ITSMConfigItem' ) {
            $ITSMConfigItemSort = $Sort;
        }
        elsif ( $SortBy eq 'Title' ) {
            $TitleSort = $Sort;
        }
        elsif ( $SortBy eq 'Age' ) {
            $AgeSort = $Sort;
        }

        # TODO maybe use owner stuff later for configured customeruser or customercompany
        # my $Owner = $ConfigObject->Get('ITSMConfigItem::Frontend::CustomerITSMConfigItemOverview')->{Owner};

        # if ($Owner) {
        #     $LayoutObject->Block(
        #         Name => 'OverviewNavBarPageOwner',
        #         Data => {
        #             OrderBy   => $OrderBy,
        #             OwnerSort => $OwnerSort,
        #             Filter    => $FilterCurrent,
        #         },
        #     );
        # }

        # show header filter
        for my $Key ( sort keys %NavBarFilter ) {
            $LayoutObject->Block(
                Name => 'FilterHeader',
                Data => {
                    %Param,
                    %{ $NavBarFilter{$Key} },
                    Fulltext => $ParamObject->GetParam( Param => 'Fulltext' ),
                },
            );
        }

        # get the dynamic fields for this screen
        my $DynamicFieldObject = $Kernel::OM->Get('Kernel::System::DynamicField');
        my $BackendObject      = $Kernel::OM->Get('Kernel::System::DynamicField::Backend');

        # TODO check sysconfig name
        # get dynamic field config for frontend module
        my $DynamicFieldFilter = $ConfigObject->Get("ITSMConfigItem::Frontend::CustomerITSMConfigItem")->{DynamicField};
        my $DynamicField       = $DynamicFieldObject->DynamicFieldListGet(
            Valid       => 1,
            ObjectType  => ['ITSMConfigItem'],
            FieldFilter => $DynamicFieldFilter || {},
        );

        # reduce the dynamic fields to only the ones that are desinged for customer interface
        my @CustomerDynamicFields;
        DYNAMICFIELD:
        for my $DynamicFieldConfig ( @{$DynamicField} ) {
            next DYNAMICFIELD if !IsHashRefWithData($DynamicFieldConfig);

            # TODO check which new fields maybe need customerinterface capability
            my $IsCustomerInterfaceCapable = $BackendObject->HasBehavior(
                DynamicFieldConfig => $DynamicFieldConfig,
                Behavior           => 'IsCustomerInterfaceCapable',
            );
            next DYNAMICFIELD if !$IsCustomerInterfaceCapable;

            push @CustomerDynamicFields, $DynamicFieldConfig;
        }
        $DynamicField = \@CustomerDynamicFields;

        # Dynamic fields
        # cycle trough the activated Dynamic Fields for this screen
        DYNAMICFIELD:
        for my $DynamicFieldConfig ( @{$DynamicField} ) {
            next DYNAMICFIELD if !IsHashRefWithData($DynamicFieldConfig);

            my $Label = $DynamicFieldConfig->{Label};

            # get field sortable condition
            my $IsSortable = $BackendObject->HasBehavior(
                DynamicFieldConfig => $DynamicFieldConfig,
                Behavior           => 'IsSortable',
            );

            if ($IsSortable) {
                my $CSS = '';
                if (
                    $SortBy
                    && ( $SortBy eq ( 'DynamicField_' . $DynamicFieldConfig->{Name} ) )
                    )
                {
                    if ( $OrderBy && ( $OrderBy eq 'Up' ) ) {
                        $CSS .= ' SortDescending';
                    }
                    else {
                        $CSS .= ' SortAscending';
                    }
                }

                $LayoutObject->Block(
                    Name => 'OverviewNavBarPageDynamicField',
                    Data => {
                        %Param,
                        CSS => $CSS,
                    },
                );

                $LayoutObject->Block(
                    Name => 'OverviewNavBarPageDynamicFieldSortable',
                    Data => {
                        %Param,
                        OrderBy          => $OrderBy,
                        Label            => $Label,
                        DynamicFieldName => $DynamicFieldConfig->{Name},
                        Filter           => $FilterCurrent,
                    },
                );

                # example of dynamic fields order customization
                $LayoutObject->Block(
                    Name => 'OverviewNavBarPageDynamicField_' . $DynamicFieldConfig->{Name},
                    Data => {
                        %Param,
                        CSS => $CSS,
                    },
                );

                $LayoutObject->Block(
                    Name => 'OverviewNavBarPageDynamicField_'
                        . $DynamicFieldConfig->{Name}
                        . '_Sortable',
                    Data => {
                        %Param,
                        OrderBy          => $OrderBy,
                        Label            => $Label,
                        DynamicFieldName => $DynamicFieldConfig->{Name},
                        Filter           => $FilterCurrent,
                    },
                );
            }
            else {

                $LayoutObject->Block(
                    Name => 'OverviewNavBarPageDynamicField',
                    Data => {
                        %Param,
                    },
                );

                $LayoutObject->Block(
                    Name => 'OverviewNavBarPageDynamicFieldNotSortable',
                    Data => {
                        %Param,
                        Label => $Label,
                    },
                );

                # example of dynamic fields order customization
                $LayoutObject->Block(
                    Name => 'OverviewNavBarPageDynamicField_' . $DynamicFieldConfig->{Name},
                    Data => {
                        %Param,
                    },
                );

                $LayoutObject->Block(
                    Name => 'OverviewNavBarPageDynamicField_'
                        . $DynamicFieldConfig->{Name}
                        . '_NotSortable',
                    Data => {
                        %Param,
                        Label => $Label,
                    },
                );
            }
        }

        my @ViewableITSMConfigItems = $ITSMConfigItemObject->ConfigItemSearch(
            %{ $Filters{ $Self->{Subaction} }->{$FilterCurrent}->{Search} },
            Result => 'ARRAY',
        );

        my $ITSMConfigItemListObject = $Kernel::OM->Get('Kernel::Output::HTML::ITSMConfigItem::CustomerList');
        $ITSMConfigItemListHTML = $ITSMConfigItemListObject->Run(
            StartHit      => $StartHit,
            PageShown     => $PageShown,
            ConfigItemIDs => \@ViewableITSMConfigItems,
        );

    }

    # create & return output
    my $Title = $Self->{Subaction};
    if ( $Title eq 'MyITSMConfigItems' ) {
        $Title = Translatable('My ITSMConfigItems');
    }
    my $Refresh = '';
    if ( $Self->{UserRefreshTime} ) {
        $Refresh = 60 * $Self->{UserRefreshTime};
    }
    my $Output = $LayoutObject->CustomerHeader(
        Title   => $Title,
        Refresh => $Refresh,
    );

    # TODO likely needed later for elasticsearch implementation
    # AddJSData for ES
    my $ESActive = $ConfigObject->Get('Elasticsearch::Active');

    $LayoutObject->AddJSData(
        Key   => 'ESActive',
        Value => $ESActive,
    );

    # TODO check what this does
    my $NewITSMConfigItemAccessKey = $ConfigObject->Get('CustomerFrontend::Navigation')->{'CustomerITSMConfigItemMessage'}{'002-ITSMConfigItem'}[0]{'AccessKey'}
        || '';

    $Output .= $LayoutObject->Output(
        TemplateFile => 'CustomerITSMConfigItem',
        Data         => {
            %Param,
            %PageNav,
            AccessKey              => $NewITSMConfigItemAccessKey,
            ITSMConfigItemListHTML => $ITSMConfigItemListHTML,
            Fulltext               => $ParamObject->GetParam( Param => 'Fulltext' ),
        },
    );

    # build NavigationBar
    $Output .= $LayoutObject->CustomerNavigationBar();

    # get page footer
    $Output .= $LayoutObject->CustomerFooter();

    return $Output;

    # # show config items
    # $Output .= $LayoutObject->ITSMConfigItemListShow(
    #     Filter                => $Filter,
    #     Filters               => \%NavBarFilter,
    #     ConfigItemIDs         => \@ViewableConfigItems,
    #     OriginalConfigItemIDs => \@OriginalViewableConfigItems,
    #     GetColumnFilter       => \%GetColumnFilter,
    #     LastColumnFilter      => $LastColumnFilter,
    #     Action                => 'CustomerITSMConfigItem',
    #     Total                 => $CountTotal,
    #     RequestedURL          => $Self->{RequestedURL},
    #     View                  => $View,
    #     Bulk                  => 1,
    #     TitleName             => $LayoutObject->{LanguageObject}->Translate('Overview: ITSM ConfigItem'),
    #     TitleValue            => $Self->{Filters}{$Filter}->{Name},
    #     Env                   => $Self,
    #     LinkPage              => $LinkPage,
    #     LinkSort              => $LinkSort,
    #     LinkFilter            => $LinkFilter,
    #     OrderBy               => $OrderBy,
    #     SortBy                => $SortBy,
    #     EnableColumnFilters   => 1,
    #     ColumnFilterForm      => {
    #         Filter => $Filter || '',
    #     },

    #     # do not print the result earlier, but return complete content
    #     Output => 1,
    # );

    # # get page footer
    # $Output .= $LayoutObject->Footer() if $Self->{Subaction} ne 'AJAXFilterUpdate';
    # return $Output;
}

1;

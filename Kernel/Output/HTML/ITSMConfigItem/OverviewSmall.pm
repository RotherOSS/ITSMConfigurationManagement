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

package Kernel::Output::HTML::ITSMConfigItem::OverviewSmall;

use strict;
use warnings;
use utf8;
use namespace::autoclean;

# core modules

# CPAN modules

# OTOBO modules
use Kernel::Language              qw(Translatable);
use Kernel::System::VariableCheck qw(:all);

our @ObjectDependencies = (
    'Kernel::Config',
    'Kernel::System::GeneralCatalog',
    'Kernel::Language',
    'Kernel::System::Log',
    'Kernel::Output::HTML::Layout',
    'Kernel::System::Group',
    'Kernel::System::User',
    'Kernel::System::JSON',
    'Kernel::System::DynamicField',
    'Kernel::System::ITSMConfigItem::ColumnFilter',
    'Kernel::System::DynamicField::Backend',
    'Kernel::System::ITSMConfigItem',
    'Kernel::System::Main',
);

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = \%Param;
    bless( $Self, $Type );

    # get UserID param
    $Self->{UserID} = $Param{UserID} || die "Got no UserID!";

    # get config object
    my $ConfigObject = $Kernel::OM->Get('Kernel::Config');

    # set pref for columns key
    $Self->{PrefKeyColumns} = 'UserFilterColumnsEnabled' . '-' . $Self->{Action} . '-' . $Self->{Filter};

    # load backend config
    my $BackendConfigKey = 'ITSMConfigItem::Frontend::' . $Self->{Action};
    $Self->{Config} = $ConfigObject->Get($BackendConfigKey);

    my %Preferences = $Kernel::OM->Get('Kernel::System::User')->GetPreferences(
        UserID => $Self->{UserID},
    );

    # set stored filters if present
    my $StoredFiltersKey = 'UserStoredFilterColumns-' . $Self->{Action} . '-' . $Self->{Filter};
    if ( $Preferences{$StoredFiltersKey} ) {
        my $StoredFilters = $Kernel::OM->Get('Kernel::System::JSON')->Decode(
            Data => $Preferences{$StoredFiltersKey},
        );
        $Self->{StoredFilters} = $StoredFilters;
    }

    # check for filter
    my $FilterName = IsHashRefWithData( $Self->{Filters}->{ $Self->{Filter} } ) ? $Self->{Filters}->{ $Self->{Filter} }->{Name} : 'All';

    # check for default settings
    my %DefaultColumns = %{ $Self->{Config}->{DefaultColumns} || {} };

    # if class filter is set, display class specific fields
    my %ClassColumnDefinition;
    if ( $FilterName && $FilterName ne 'All' ) {

        if ( $Self->{Config}{ClassColumnsAvailable} && IsArrayRefWithData( $Self->{Config}{ClassColumnsAvailable}{$FilterName} ) ) {
            for my $AvailableColumn ( $Self->{Config}{ClassColumnsAvailable}{$FilterName}->@* ) {
                $ClassColumnDefinition{$AvailableColumn} = 1;
            }
        }

        if ( $Self->{Config}{ClassColumnsDefault} && IsArrayRefWithData( $Self->{Config}{ClassColumnsDefault}{$FilterName} ) ) {
            for my $DefaultColumn ( $Self->{Config}{ClassColumnsDefault}{$FilterName}->@* ) {
                $ClassColumnDefinition{$DefaultColumn} = 2;
            }
        }
    }

    # merge settings from class config and default config
    for my $Column ( sort _DefaultColumnSort ( keys %DefaultColumns, keys %ClassColumnDefinition ) ) {
        if ( ( $ClassColumnDefinition{$Column} || $DefaultColumns{$Column} ) && !grep { $_ eq $Column } $Self->{ColumnsAvailable}->@* ) {
            push $Self->{ColumnsAvailable}->@*, $Column;
        }

        if ( ( ( $ClassColumnDefinition{$Column} || $DefaultColumns{$Column} ) // 0 ) == 2 && !grep { $_ eq $Column } $Self->{ColumnsEnabled}->@* ) {
            push $Self->{ColumnsEnabled}->@*, $Column;
        }
    }

    # if preference settings are available, overwrite enabled columns with preferences
    if ( $Preferences{ $Self->{PrefKeyColumns} } ) {

        my $ColumnsEnabled = $Kernel::OM->Get('Kernel::System::JSON')->Decode(
            Data => $Preferences{ $Self->{PrefKeyColumns} },
        );

        $Self->{ColumnsEnabled} = IsArrayRefWithData($ColumnsEnabled) ? $ColumnsEnabled : [];
    }

    # always set config item number
    if ( !grep { $_ eq 'Number' } $Self->{ColumnsEnabled}->@* ) {
        unshift $Self->{ColumnsEnabled}->@*, 'Number';
    }
    if ( !grep { $_ eq 'Number' } $Self->{ColumnsAvailable}->@* ) {
        unshift $Self->{ColumnsAvailable}->@*, 'Number';
    }

    # get necessary dynamic field objects
    my $DynamicFieldObject        = $Kernel::OM->Get('Kernel::System::DynamicField');
    my $DynamicFieldBackendObject = $Kernel::OM->Get('Kernel::System::DynamicField::Backend');

    # collect dynamic fields and set available and valid filter and sortable columns
    DYNAMICFIELDNAME:
    for my $DynamicFieldName ( $Self->{ColumnsAvailable}->@* ) {

        my $FieldName;
        if ( $DynamicFieldName =~ m{ DynamicField_(?<FieldName>[A-Za-z0-9\-]+) }xms ) {
            $FieldName = $+{FieldName};
        }
        else {
            next DYNAMICFIELDNAME;
        }

        my $DynamicFieldConfig = $DynamicFieldObject->DynamicFieldGet(
            Name => $FieldName,
        );

        next DYNAMICFIELD if !IsHashRefWithData($DynamicFieldConfig);

        # store field config
        if ( $DynamicFieldConfig->{ObjectType} eq 'ITSMConfigItem' ) {
            push $Self->{DynamicField}->@*, $DynamicFieldConfig;
        }

        # check filtrable and sortable behaviors
        for my $Behavior (qw(Filtrable Sortable)) {

            my $HasBehavior = $DynamicFieldBackendObject->HasBehavior(
                DynamicFieldConfig => $DynamicFieldConfig,
                Behavior           => "Is$Behavior",
            );

            if ($HasBehavior) {
                $Self->{"Available${Behavior}Columns"}{ 'DynamicField_' . $DynamicFieldConfig->{Name} } = 1;
            }
        }
    }

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

    $Self->{AvailableFiltrableColumns} = {
        defined $Self->{AvailableFiltrableColumns}
        ? $Self->{AvailableFiltrableColumns}->%*
        : (),
        'Class'        => 1,
        'DeplState'    => 1,
        'CurDeplState' => 1,
        'InciState'    => 1,
        'CurInciState' => 1,
    };

    return $Self;
}

sub ActionRow {
    my ( $Self, %Param ) = @_;

    # set frontend per default to agent
    $Param{Frontend} //= 'Agent';

    # get needed objects
    my $ConfigObject = $Kernel::OM->Get('Kernel::Config');
    my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');

    # check if bulk feature is enabled
    my $BulkFeature = 0;
    if ( $Param{Bulk} && $ConfigObject->Get('ITSMConfigItem::Frontend::BulkFeature') ) {
        my @Groups;
        if ( $ConfigObject->Get('ITSMConfigItem::Frontend::BulkFeatureGroup') ) {
            @Groups = @{ $ConfigObject->Get('ITSMConfigItem::Frontend::BulkFeatureGroup') };
        }
        if ( !@Groups ) {
            $BulkFeature = 1;
        }
        else {
            my $GroupObject = $Kernel::OM->Get('Kernel::System::Group');
            GROUP:
            for my $Group (@Groups) {
                my $HasPermission = $GroupObject->PermissionCheck(
                    UserID    => $Self->{UserID},
                    GroupName => $Group,
                    Type      => 'rw',
                );
                if ($HasPermission) {
                    $BulkFeature = 1;
                    last GROUP;
                }
            }
        }
    }

    $LayoutObject->Block(
        Name => 'DocumentActionRow',
        Data => \%Param,
    );

    if ($BulkFeature) {
        $LayoutObject->Block(
            Name => 'DocumentActionRowBulk',
            Data => {
                %Param,
                Name => Translatable('Bulk'),
            },
        );
    }

    # check if there was a column filter and no results, and print a link to back
    if ( scalar @{ $Param{ConfigItemIDs} } == 0 && $Param{LastColumnFilter} ) {
        $LayoutObject->Block(
            Name => 'DocumentActionRowLastColumnFilter',
            Data => {
                %Param,
            },
        );
    }

    my $LanguageObject = $Kernel::OM->Get('Kernel::Language');

    # add translations for the allocation lists for regular columns
    my $Columns = $Self->{Config}->{DefaultColumns} || $ConfigObject->Get('DefaultOverviewColumns') || {};
    if ( $Columns && IsHashRefWithData($Columns) ) {

        COLUMN:
        for my $Column ( sort keys %{$Columns} ) {

            # dynamic fields will be translated in the next block
            next COLUMN if $Column =~ m{ \A DynamicField_ }xms;

            my $TranslatedWord = $Column;
            if ( $Column eq 'DeplState' ) {
                $TranslatedWord = Translatable('Deployment State');
            }
            elsif ( $Column eq 'CurDeplState' ) {
                $TranslatedWord = Translatable('Current Deployment State');
            }
            elsif ( $Column eq 'CurDeplStateType' ) {
                $TranslatedWord = Translatable('Deployment State Type');
            }
            elsif ( $Column eq 'InciState' ) {
                $TranslatedWord = Translatable('Incident State');
            }
            elsif ( $Column eq 'CurInciState' ) {
                $TranslatedWord = Translatable('Current Incident State');
            }
            elsif ( $Column eq 'CurInciStateType' ) {
                $TranslatedWord = Translatable('Current Incident State Type');
            }
            elsif ( $Column eq 'LastChanged' ) {
                $TranslatedWord = Translatable('Last changed');
            }
            else {
                $TranslatedWord = $LayoutObject->{LanguageObject}->Translate($Column);
            }

            # send data to JS
            $LayoutObject->AddJSData(
                Key   => 'Column' . $Column,
                Value => $LanguageObject->Translate($TranslatedWord),
            );
        }
    }

    # add translations for the allocation lists for dynamic field columns
    my $ColumnsDynamicField = $Kernel::OM->Get('Kernel::System::DynamicField')->DynamicFieldListGet(
        Valid      => 0,
        ObjectType => ['ITSMConfigItem'],
    );

    if ( $ColumnsDynamicField && IsArrayRefWithData($ColumnsDynamicField) ) {

        my $Counter = 0;

        DYNAMICFIELD:
        for my $DynamicField ( sort @{$ColumnsDynamicField} ) {

            next DYNAMICFIELD if !$DynamicField;

            $Counter++;

            # send data to JS
            $LayoutObject->AddJSData(
                Key   => 'ColumnDynamicField_' . $DynamicField->{Name},
                Value => $LanguageObject->Translate( $DynamicField->{Label} ),
            );
        }
    }

    my $Output = $LayoutObject->Output(
        TemplateFile => 'AgentITSMConfigItemOverviewSmall',
        Data         => \%Param,
    );

    return $Output;
}

sub SortOrderBar {
    my ( $Self, %Param ) = @_;

    return '';
}

sub Run {
    my ( $Self, %Param ) = @_;

    # If $Param{EnableColumnFilters} is not sent, we want to disable all filters
    #   for the current screen. We localize the setting for this sub and change it
    #   after that, if needed. The original value will be restored after this function.
    local $Self->{AvailableFiltrableColumns} = $Self->{AvailableFiltrableColumns};
    if ( !$Param{EnableColumnFilters} ) {
        $Self->{AvailableFiltrableColumns} = {};    # disable all column filters
    }

    for my $Item (qw(ConfigItemIDs PageShown StartHit)) {
        if ( !$Param{$Item} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Item!",
            );
            return;
        }
    }

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
        my $DeplStateColor = ( lc $Color ) =~ s/[^0-9a-f]//msgr;

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

    # get needed objects
    my $ConfigObject = $Kernel::OM->Get('Kernel::Config');
    my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');

    # check if bulk feature is enabled
    my $BulkFeature = 0;
    if ( $Param{Bulk} && $ConfigObject->Get('ITSMConfigItem::Frontend::BulkFeature') ) {
        my @Groups;
        if ( $ConfigObject->Get('ITSMConfigItem::Frontend::BulkFeatureGroup') ) {
            @Groups = @{ $ConfigObject->Get('ITSMConfigItem::Frontend::BulkFeatureGroup') };
        }
        if ( !@Groups ) {
            $BulkFeature = 1;
        }
        else {
            my $GroupObject = $Kernel::OM->Get('Kernel::System::Group');
            GROUP:
            for my $Group (@Groups) {
                my $HasPermission = $GroupObject->PermissionCheck(
                    UserID    => $Self->{UserID},
                    GroupName => $Group,
                    Type      => 'rw',
                );
                if ($HasPermission) {
                    $BulkFeature = 1;
                    last GROUP;
                }
            }
        }
    }

    my $Counter = 0;
    my @ConfigItemBox;

    my $ConfigItemObject = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');

    for my $ConfigItemID ( @{ $Param{ConfigItemIDs} } ) {
        $Counter++;
        if ( $Counter >= $Param{StartHit} && $Counter < ( $Param{PageShown} + $Param{StartHit} ) ) {

            # Get config item data.
            my $ConfigItemRef = $ConfigItemObject->ConfigItemGet(
                ConfigItemID  => $ConfigItemID,
                DynamicFields => 0,
            );
            my %ConfigItem = $ConfigItemRef->%*;

            # set deployment and incident signals
            $ConfigItem{CurDeplSignal} = $DeplSignals{ $ConfigItem{CurDeplState} };
            $ConfigItem{CurInciSignal} = $InciSignals{ $ConfigItem{CurInciStateType} };

            # fill column name attribute with corresponding item attribute
            $ConfigItem{Created}     = $ConfigItem{CreateTime};
            $ConfigItem{LastChanged} = $ConfigItem{ChangeTime};

            # get ACL restrictions
            my %PossibleActions;
            my $Counter = 0;

            # get all registered Actions
            if ( ref $ConfigObject->Get('ITSMConfigItem::Frontend::Module') eq 'HASH' ) {

                my %Actions = %{ $ConfigObject->Get('ITSMConfigItem::Frontend::Module') };

                # only use those Actions that stats with AgentITSMConfigItem
                %PossibleActions = map { ++$Counter => $_ }
                    grep { substr( $_, 0, length 'AgentITSMConfigItem' ) eq 'AgentITSMConfigItem' }
                    sort keys %Actions;
            }

            my $ACL;
            my %AclAction = %PossibleActions;

            $ACL = $ConfigItemObject->ConfigItemAcl(
                Data          => \%PossibleActions,
                Action        => $Self->{Action},
                ConfigItemID  => $ConfigItem{ConfigItemID},
                ReturnType    => 'Action',
                ReturnSubType => '-',
                UserID        => $Self->{UserID},
            );
            if ($ACL) {
                %AclAction = $ConfigItemObject->ConfigItemAclActionData();
            }

            # run config item pre menu modules
            my @ActionItems;
            if ( ref $ConfigObject->Get('ITSMConfigItem::Frontend::PreMenuModule') eq 'HASH' ) {
                my %Menus = %{ $ConfigObject->Get('ITSMConfigItem::Frontend::PreMenuModule') };
                MENU:
                for my $Menu ( sort keys %Menus ) {

                    # load module
                    if ( !$Kernel::OM->Get('Kernel::System::Main')->Require( $Menus{$Menu}->{Module} ) ) {
                        return $LayoutObject->FatalError();
                    }
                    my $Object = $Menus{$Menu}->{Module}->new(
                        %{$Self},
                        ConfigItemID => $ConfigItem{ConfigItemID},
                    );

                    # run module
                    my $Item = $Object->Run(
                        %Param,
                        ConfigItem => \%ConfigItem,
                        ACL        => \%AclAction,
                        Config     => $Menus{$Menu},
                    );
                    next MENU if !$Item;
                    next MENU if ref $Item ne 'HASH';

                    # add session id if needed
                    if ( !$LayoutObject->{SessionIDCookie} && $Item->{Link} ) {
                        $Item->{Link}
                            .= ';'
                            . $LayoutObject->{SessionName} . '='
                            . $LayoutObject->{SessionID};
                    }

                    # create id
                    $Item->{ID} = $Item->{Name};
                    $Item->{ID} =~ s/(\s|&|;)//ig;

                    my $Output;
                    if ( $Item->{Block} ) {
                        $LayoutObject->Block(
                            Name => $Item->{Block},
                            Data => $Item,
                        );
                        $Output = $LayoutObject->Output(
                            TemplateFile => 'AgentITSMConfigItemOverviewSmall',
                            Data         => $Item,
                        );
                    }
                    else {
                        $Output = '<li id="'
                            . $Item->{ID}
                            . '"><a href="#" title="'
                            . $LayoutObject->{LanguageObject}->Translate( $Item->{Description} )
                            . '">'
                            . $LayoutObject->{LanguageObject}->Translate( $Item->{Name} )
                            . '</a></li>';
                    }

                    $Output =~ s/\n+//g;
                    $Output =~ s/\s+/ /g;
                    $Output =~ s/<\!--.+?-->//g;

                    push @ActionItems, {
                        HTML        => $Output,
                        ID          => $Item->{ID},
                        Link        => $LayoutObject->{Baselink} . $Item->{Link},
                        Target      => $Item->{Target},
                        PopupType   => $Item->{PopupType},
                        Description => $Item->{Description},
                    };
                    $ConfigItem{ActionItems} = \@ActionItems;
                }
            }
            push @ConfigItemBox, \%ConfigItem;
        }
    }

    # check if columnsenabled is a filled array referencd
    if ( IsArrayRefWithData( $Self->{ColumnsEnabled} ) ) {

        # check if column is really filterable
        COLUMNNAME:
        for my $ColumnName ( @{ $Self->{ColumnsEnabled} } ) {
            next COLUMNNAME if !$Self->{AvailableFiltrableColumns}->{$ColumnName};
            $Self->{ValidFiltrableColumns}->{$ColumnName} = 1;
        }
    }

    my $ColumnValues = $Self->_GetColumnValues(
        OriginalConfigItemIDs => $Param{OriginalConfigItemIDs},
    );

    # send data to JS
    $LayoutObject->AddJSData(
        Key   => 'LinkPage',
        Value => $Param{LinkPage},
    );

    $LayoutObject->Block(
        Name => 'DocumentContent',
        Data => \%Param,
    );

    # array to save the column names to do the query
    my @Col = @{ $Self->{ColumnsEnabled} };

    # define special config item columns
    my %SpecialColumns = (
        Number       => 1,
    );

    my $DynamicFieldBackendObject = $Kernel::OM->Get('Kernel::System::DynamicField::Backend');

    $Param{OrderBy} = $Param{OrderBy} || 'Up';
    $Param{SortBy}  = $Param{SortBy}  || 'Number';

    my $ConfigItemData = scalar @ConfigItemBox;
    if ($ConfigItemData) {

        $LayoutObject->Block(
            Name => 'OverviewTable',
            Data => {
                StyleClasses => $StyleClasses,
            },
        );
        $LayoutObject->Block( Name => 'TableHeader' );

        if ($BulkFeature) {
            $LayoutObject->Block(
                Name => 'GeneralOverviewHeader',
            );
            $LayoutObject->Block(
                Name => 'BulkNavBar',
                Data => \%Param,
            );
        }

        my $CSS = '';

        # show special config item columns, if needed
        my $Counter = 0;
        COLUMN:
        for my $Column (@Col) {
            my $StaticColumn = !$Counter;
            $Counter++;

            $LayoutObject->Block(
                Name => 'GeneralOverviewHeader',
            );

            $CSS = $Column . ( $StaticColumn ? ' StaticColumn' : '' );
            my $Title   = $LayoutObject->{LanguageObject}->Translate($Column);
            my $OrderBy = $Param{OrderBy};

            # Transform filter name to column name
            if ( $Param{SortBy} eq 'Changed' ) {
                $Param{SortBy} = 'LastChanged';
            }

            # output overall block so Number as well as other columns can be ordered
            $LayoutObject->Block(
                Name => 'OverviewNavBarPageConfigItemHeader',
                Data => {},
            );

            if ( $SpecialColumns{$Column} ) {

                if ( $Param{SortBy} && ( $Param{SortBy} eq $Column ) ) {
                    my $TitleDesc;

                    # Change order for sorting column.
                    $OrderBy = $OrderBy eq 'Up' ? 'Down' : 'Up';

                    if ( $OrderBy eq 'Down' ) {
                        $CSS .= ' SortAscendingLarge';
                        $TitleDesc = Translatable('sorted ascending');
                    }
                    else {
                        $CSS .= ' SortDescendingLarge';
                        $TitleDesc = Translatable('sorted descending');
                    }

                    $TitleDesc = $LayoutObject->{LanguageObject}->Translate($TitleDesc);
                    $Title .= ', ' . $TitleDesc;
                }

                # translate the column name to write it in the current language
                my $TranslatedWord = $LayoutObject->{LanguageObject}->Translate($Column);

                my $FilterTitle     = $TranslatedWord;
                my $FilterTitleDesc = Translatable('filter not active');
                if (
                    $Self->{StoredFilters} &&
                    (
                        $Self->{StoredFilters}->{$Column} ||
                        $Self->{StoredFilters}->{ $Column . 'IDs' }
                    )
                    )
                {
                    $CSS .= ' FilterActive';
                    $FilterTitleDesc = Translatable('filter active');
                }
                $FilterTitleDesc = $LayoutObject->{LanguageObject}->Translate($FilterTitleDesc);
                $FilterTitle .= ', ' . $FilterTitleDesc;

                $LayoutObject->Block(
                    Name => "OverviewNavBarPage$Column",
                    Data => {
                        %Param,
                        OrderBy              => $OrderBy,
                        ColumnName           => $Column         || '',
                        CSS                  => $CSS            || '',
                        ColumnNameTranslated => $TranslatedWord || $Column,
                        Title                => $Title,
                    },
                );

                # verify if column is filterable and sortable
                if (
                    $Self->{ValidFiltrableColumns}->{$Column}
                    && $Self->{ValidSortableColumns}->{$Column}
                    )
                {
                    # variable to save the filter's html code
                    my $ColumnFilterHTML = $Self->_InitialColumnFilter(
                        ColumnName    => $Column,
                        Label         => $Column,
                        ColumnValues  => $ColumnValues->{$Column},
                        SelectedValue => $Param{GetColumnFilter}->{$Column} || '',
                    );

                    $LayoutObject->Block(
                        Name => 'OverviewNavBarPageColumnFilterLink',
                        Data => {
                            %Param,
                            ColumnName           => $Column,
                            CSS                  => $CSS,
                            ColumnNameTranslated => $TranslatedWord || $Column,
                            ColumnFilterStrg     => $ColumnFilterHTML,
                            OrderBy              => $OrderBy,
                            Title                => $Title,
                            FilterTitle          => $FilterTitle,
                        },
                    );
                }

                # verify if column is filterable
                elsif ( $Self->{ValidFiltrableColumns}->{$Column} ) {

                    # variable to save the filter's HTML code
                    my $ColumnFilterHTML = $Self->_InitialColumnFilter(
                        ColumnName    => $Column,
                        Label         => $Column,
                        ColumnValues  => $ColumnValues->{$Column},
                        SelectedValue => $Param{GetColumnFilter}->{$Column} || '',
                    );

                    $LayoutObject->Block(
                        Name => 'OverviewNavBarPageColumnFilter',
                        Data => {
                            %Param,
                            ColumnName           => $Column,
                            CSS                  => $CSS,
                            ColumnNameTranslated => $TranslatedWord || $Column,
                            ColumnFilterStrg     => $ColumnFilterHTML,
                            OrderBy              => $OrderBy,
                            Title                => $Title,
                            FilterTitle          => $FilterTitle,
                        },
                    );
                }

                # verify if column is sortable
                elsif ( $Self->{ValidSortableColumns}->{$Column} ) {
                    $LayoutObject->Block(
                        Name => 'OverviewNavBarPageColumnLink',
                        Data => {
                            %Param,
                            ColumnName           => $Column,
                            CSS                  => $CSS,
                            ColumnNameTranslated => $TranslatedWord || $Column,
                            OrderBy              => $OrderBy,
                            Title                => $Title,
                        },
                    );
                }
                else {
                    $LayoutObject->Block(
                        Name => 'OverviewNavBarPageColumnEmpty',
                        Data => {
                            %Param,
                            ColumnName           => $Column,
                            CSS                  => $CSS,
                            ColumnNameTranslated => $TranslatedWord || $Column,
                            Title                => $Title,
                        },
                    );
                }
                next COLUMN;
            }
            elsif ( $Column !~ m{\A DynamicField_}xms ) {

                if ( $Param{SortBy} && ( $Param{SortBy} eq $Column ) ) {
                    my $TitleDesc;

                    # Change order for sorting column.
                    $OrderBy = $OrderBy eq 'Up' ? 'Down' : 'Up';

                    if ( $OrderBy eq 'Down' ) {
                        $CSS .= ' SortAscendingLarge';
                        $TitleDesc = Translatable('sorted ascending');
                    }
                    else {
                        $CSS .= ' SortDescendingLarge';
                        $TitleDesc = Translatable('sorted descending');
                    }

                    $TitleDesc = $LayoutObject->{LanguageObject}->Translate($TitleDesc);
                    $Title .= ', ' . $TitleDesc;
                }

                # translate the column name to write it in the current language
                my $TranslatedWord;
                if ( $Column eq 'DeplState' ) {
                    $TranslatedWord = $LayoutObject->{LanguageObject}->Translate('Deployment State');
                }
                elsif ( $Column eq 'CurDeplState' ) {
                    $TranslatedWord = $LayoutObject->{LanguageObject}->Translate('Current Deployment State');
                }
                elsif ( $Column eq 'CurDeplStateType' ) {
                    $TranslatedWord = $LayoutObject->{LanguageObject}->Translate('Deployment State Type');
                }
                elsif ( $Column eq 'InciState' ) {
                    $TranslatedWord = $LayoutObject->{LanguageObject}->Translate('Incident State');
                }
                elsif ( $Column eq 'CurInciState' ) {
                    $TranslatedWord = $LayoutObject->{LanguageObject}->Translate('Current Incident State');
                }
                elsif ( $Column eq 'CurInciStateType' ) {
                    $TranslatedWord = $LayoutObject->{LanguageObject}->Translate('Current Incident State Type');
                }
                elsif ( $Column eq 'LastChanged' ) {
                    $TranslatedWord = $LayoutObject->{LanguageObject}->Translate('Last changed');
                }
                else {
                    $TranslatedWord = $LayoutObject->{LanguageObject}->Translate($Column);
                }

                my $FilterTitle     = $TranslatedWord;
                my $FilterTitleDesc = Translatable('filter not active');
                if ( $Self->{StoredFilters} && $Self->{StoredFilters}->{ $Column . 'IDs' } ) {
                    $CSS .= ' FilterActive';
                    $FilterTitleDesc = Translatable('filter active');
                }
                $FilterTitleDesc = $LayoutObject->{LanguageObject}->Translate($FilterTitleDesc);
                $FilterTitle .= ', ' . $FilterTitleDesc;

                $LayoutObject->Block(
                    Name => 'OverviewNavBarPageColumn',
                    Data => {
                        %Param,
                        ColumnName           => $Column,
                        CSS                  => $CSS,
                        ColumnNameTranslated => $TranslatedWord || $Column,
                    },
                );

                # verify if column is filterable and sortable
                if (
                    $Self->{ValidFiltrableColumns}->{$Column}
                    && $Self->{ValidSortableColumns}->{$Column}
                    )
                {

                    # variable to save the filter's HTML code
                    my $ColumnFilterHTML = $Self->_InitialColumnFilter(
                        ColumnName    => $Column,
                        Label         => $Column,
                        ColumnValues  => $ColumnValues->{$Column},
                        SelectedValue => $Param{GetColumnFilter}->{$Column} || '',
                    );

                    $LayoutObject->Block(
                        Name => 'OverviewNavBarPageColumnFilterLink',
                        Data => {
                            %Param,
                            ColumnName           => $Column,
                            CSS                  => $CSS,
                            ColumnNameTranslated => $TranslatedWord || $Column,
                            ColumnFilterStrg     => $ColumnFilterHTML,
                            OrderBy              => $OrderBy,
                            Title                => $Title,
                            FilterTitle          => $FilterTitle,
                        },
                    );
                }

                # verify if column is just filterable
                elsif ( $Self->{ValidFiltrableColumns}->{$Column} ) {

                    # variable to save the filter's HTML code
                    my $ColumnFilterHTML = $Self->_InitialColumnFilter(
                        ColumnName    => $Column,
                        Label         => $Column,
                        ColumnValues  => $ColumnValues->{$Column},
                        SelectedValue => $Param{GetColumnFilter}->{$Column} || '',
                    );
                    $LayoutObject->Block(
                        Name => 'OverviewNavBarPageColumnFilter',
                        Data => {
                            %Param,
                            ColumnName           => $Column,
                            CSS                  => $CSS,
                            ColumnNameTranslated => $TranslatedWord || $Column,
                            ColumnFilterStrg     => $ColumnFilterHTML,
                            OrderBy              => $OrderBy,
                            Title                => $Title,
                            FilterTitle          => $FilterTitle,
                        },
                    );
                }

                # verify if column is sortable
                elsif ( $Self->{ValidSortableColumns}->{$Column} ) {
                    $LayoutObject->Block(
                        Name => 'OverviewNavBarPageColumnLink',
                        Data => {
                            %Param,
                            ColumnName           => $Column,
                            CSS                  => $CSS,
                            ColumnNameTranslated => $TranslatedWord || $Column,
                            OrderBy              => $OrderBy,
                            Title                => $Title,
                        },
                    );
                }
                else {
                    $LayoutObject->Block(
                        Name => 'OverviewNavBarPageColumnEmpty',
                        Data => {
                            %Param,
                            ColumnName           => $Column,
                            CSS                  => $CSS,
                            ColumnNameTranslated => $TranslatedWord || $Column,
                            Title                => $Title,
                        },
                    );
                }
            }

            # show the DFs
            else {

                my $DynamicFieldConfig;
                my $DFColumn = $Column;
                $DFColumn =~ s/DynamicField_//g;
                DYNAMICFIELD:
                for my $DFConfig ( @{ $Self->{DynamicField} } ) {
                    next DYNAMICFIELD if !IsHashRefWithData($DFConfig);
                    next DYNAMICFIELD if $DFConfig->{Name} ne $DFColumn;

                    $DynamicFieldConfig = $DFConfig;
                    last DYNAMICFIELD;
                }
                next COLUMN if !IsHashRefWithData($DynamicFieldConfig);

                my $Label = $DynamicFieldConfig->{Label};
                $Title = $Label;
                my $FilterTitle = $Label;

                # get field sortable condition
                my $IsSortable = $DynamicFieldBackendObject->HasBehavior(
                    DynamicFieldConfig => $DynamicFieldConfig,
                    Behavior           => 'IsSortable',
                );

                if ($IsSortable) {
                    my $CSS = 'DynamicField_' . $DynamicFieldConfig->{Name};
                    if (
                        $Param{SortBy}
                        && ( $Param{SortBy} eq ( 'DynamicField_' . $DynamicFieldConfig->{Name} ) )
                        )
                    {
                        my $TitleDesc;

                        # Change order for sorting column.
                        $OrderBy = $OrderBy eq 'Up' ? 'Down' : 'Up';

                        if ( $OrderBy eq 'Down' ) {
                            $CSS .= ' SortAscendingLarge';
                            $TitleDesc = Translatable('sorted ascending');
                        }
                        else {
                            $CSS .= ' SortDescendingLarge';
                            $TitleDesc = Translatable('sorted descending');
                        }

                        $TitleDesc = $LayoutObject->{LanguageObject}->Translate($TitleDesc);
                        $Title .= ', ' . $TitleDesc;
                    }

                    my $FilterTitleDesc = Translatable('filter not active');
                    if ( $Self->{StoredFilters} && $Self->{StoredFilters}->{$Column} ) {
                        $CSS .= ' FilterActive';
                        $FilterTitleDesc = Translatable('filter active');
                    }
                    $FilterTitleDesc = $LayoutObject->{LanguageObject}->Translate($FilterTitleDesc);
                    $FilterTitle .= ', ' . $FilterTitleDesc;

                    $LayoutObject->Block(
                        Name => 'OverviewNavBarPageDynamicField',
                        Data => {
                            %Param,
                            CSS => $CSS,
                        },
                    );

                    my $DynamicFieldName = 'DynamicField_' . $DynamicFieldConfig->{Name};

                    if ( $Self->{ValidFiltrableColumns}->{$DynamicFieldName} ) {

                        # variable to save the filter's HTML code
                        my $ColumnFilterHTML = $Self->_InitialColumnFilter(
                            ColumnName    => $DynamicFieldName,
                            Label         => $Label,
                            ColumnValues  => $ColumnValues->{$DynamicFieldName},
                            SelectedValue => $Param{GetColumnFilter}->{$DynamicFieldName} || '',
                        );

                        $LayoutObject->Block(
                            Name => 'OverviewNavBarPageDynamicFieldFiltrableSortable',
                            Data => {
                                %Param,
                                OrderBy          => $OrderBy,
                                Label            => $Label,
                                DynamicFieldName => $DynamicFieldConfig->{Name},
                                ColumnFilterStrg => $ColumnFilterHTML,
                                Title            => $Title,
                                FilterTitle      => $FilterTitle,
                            },
                        );
                    }

                    else {
                        $LayoutObject->Block(
                            Name => 'OverviewNavBarPageDynamicFieldSortable',
                            Data => {
                                %Param,
                                OrderBy          => $OrderBy,
                                Label            => $Label,
                                DynamicFieldName => $DynamicFieldConfig->{Name},
                                Title            => $Title,
                            },
                        );
                    }

                    # example of dynamic fields order customization
                    $LayoutObject->Block(
                        Name => 'OverviewNavBarPageDynamicField_' . $DynamicFieldConfig->{Name},
                        Data => {
                            %Param,
                            CSS => $CSS,
                        },
                    );

                    if ( $Self->{ValidFiltrableColumns}->{$DynamicFieldName} ) {

                        # variable to save the filter's HTML code
                        my $ColumnFilterHTML = $Self->_InitialColumnFilter(
                            ColumnName    => $DynamicFieldName,
                            Label         => $Label,
                            ColumnValues  => $ColumnValues->{$DynamicFieldName},
                            SelectedValue => $Param{GetColumnFilter}->{$DynamicFieldName} || '',
                        );

                        $LayoutObject->Block(
                            Name => 'OverviewNavBarPageDynamicField'
                                . $DynamicFieldConfig->{Name}
                                . '_FiltrableSortable',
                            Data => {
                                %Param,
                                OrderBy          => $OrderBy,
                                Label            => $Label,
                                DynamicFieldName => $DynamicFieldConfig->{Name},
                                ColumnFilterStrg => $ColumnFilterHTML,
                                Title            => $Title,
                            },
                        );
                    }
                    else {
                        $LayoutObject->Block(
                            Name => 'OverviewNavBarPageDynamicField_'
                                . $DynamicFieldConfig->{Name}
                                . '_Sortable',
                            Data => {
                                %Param,
                                OrderBy          => $OrderBy,
                                Label            => $Label,
                                DynamicFieldName => $DynamicFieldConfig->{Name},
                                Title            => $Title,
                            },
                        );
                    }
                }
                else {

                    my $DynamicFieldName = 'DynamicField_' . $DynamicFieldConfig->{Name};
                    my $CSS              = $DynamicFieldName;

                    $LayoutObject->Block(
                        Name => 'OverviewNavBarPageDynamicField',
                        Data => {
                            %Param,
                            CSS => $CSS,
                        },
                    );

                    if ( $Self->{ValidFiltrableColumns}->{$DynamicFieldName} ) {

                        # variable to save the filter's HTML code
                        my $ColumnFilterHTML = $Self->_InitialColumnFilter(
                            ColumnName    => $DynamicFieldName,
                            Label         => $Label,
                            ColumnValues  => $ColumnValues->{$DynamicFieldName},
                            SelectedValue => $Param{GetColumnFilter}->{$DynamicFieldName} || '',
                        );

                        $LayoutObject->Block(
                            Name => 'OverviewNavBarPageDynamicFieldFiltrableNotSortable',
                            Data => {
                                %Param,
                                Label            => $Label,
                                DynamicFieldName => $DynamicFieldConfig->{Name},
                                ColumnFilterStrg => $ColumnFilterHTML,
                                Title            => $Title,
                                FilterTitle      => $FilterTitle,
                            },
                        );
                    }
                    else {
                        $LayoutObject->Block(
                            Name => 'OverviewNavBarPageDynamicFieldNotSortable',
                            Data => {
                                %Param,
                                Label => $Label,
                                Title => $Title,
                            },
                        );
                    }

                    # example of dynamic fields order customization
                    $LayoutObject->Block(
                        Name => 'OverviewNavBarPageDynamicField_' . $DynamicFieldConfig->{Name},
                        Data => {
                            %Param,
                        },
                    );

                    if ( $Self->{ValidFiltrableColumns}->{$DynamicFieldName} ) {

                        # variable to save the filter's HTML code
                        my $ColumnFilterHTML = $Self->_InitialColumnFilter(
                            ColumnName    => $DynamicFieldName,
                            Label         => $Label,
                            ColumnValues  => $ColumnValues->{$DynamicFieldName},
                            SelectedValue => $Param{GetColumnFilter}->{$DynamicFieldName} || '',
                        );

                        $LayoutObject->Block(
                            Name => 'OverviewNavBarPageDynamicField_'
                                . $DynamicFieldConfig->{Name}
                                . '_FiltrableNotSortable',
                            Data => {
                                %Param,
                                Label            => $Label,
                                DynamicFieldName => $DynamicFieldConfig->{Name},
                                ColumnFilterStrg => $ColumnFilterHTML,
                                Title            => $Title,
                            },
                        );
                    }
                    else {
                        $LayoutObject->Block(
                            Name => 'OverviewNavBarPageDynamicField_'
                                . $DynamicFieldConfig->{Name}
                                . '_NotSortable',
                            Data => {
                                %Param,
                                Label => $Label,
                                Title => $Title,
                            },
                        );
                    }
                }

            }

        }

        $LayoutObject->Block( Name => 'TableBody' );

    }
    else {
        $LayoutObject->Block( Name => 'NoConfigItemFound' );
    }

    # back link
    if ( $Param{LinkBack} ) {
        $LayoutObject->Block(
            Name => 'OverviewNavBarPageBack',
            Data => \%Param,
        );
        $LayoutObject->AddJSData(
            Key   => 'ITSMConfigItemSearch',
            Value => {
                Profile => $Param{Profile},
                ClassID => $Param{ClassID},
            },
        );
    }

    # filter selection
    if ( $Param{Filters} ) {

        $LayoutObject->Block(
            Name => 'Filters',
        );

        my @NavBarFilters;
        for my $Prio ( sort keys %{ $Param{Filters} } ) {
            push @NavBarFilters, $Param{Filters}->{$Prio};
        }
        $LayoutObject->Block(
            Name => 'SideBarFilter',
        );
        my $Count = 0;
        for my $Filter (@NavBarFilters) {
            $Count++;
            if ( $Count == scalar @NavBarFilters ) {
                $Filter->{CSS} = 'Last';
            }
            $LayoutObject->Block(
                Name => 'SideBarFilterItem',
                Data => {
                    %Param,
                    %{$Filter},
                },
            );
            if ( $Filter->{Filter} eq $Param{Filter} ) {
                $LayoutObject->Block(
                    Name => 'SideBarFilterItemSelected',
                    Data => {
                        %Param,
                        %{$Filter},
                    },
                );
            }
            else {
                $LayoutObject->Block(
                    Name => 'SideBarFilterItemSelectedNot',
                    Data => {
                        %Param,
                        %{$Filter},
                    },
                );
            }
        }
    }

    my %SpecialColumns = (
        Number       => 1,
        CurDeplState => 1,
        CurInciState => 1,
    );

    for my $ConfigItemRef (@ConfigItemBox) {

        # get config item data
        my %ConfigItem = %{$ConfigItemRef};

        $LayoutObject->Block(
            Name => 'Record',
            Data => {%ConfigItem},
        );

        # check if bulk feature is enabled
        if ($BulkFeature) {
            $LayoutObject->Block(
                Name => 'GeneralOverviewRow',
            );
            $LayoutObject->Block(
                Name => Translatable('Bulk'),
                Data => {%ConfigItem},
            );
        }

        my $UserObject = $Kernel::OM->Get('Kernel::System::User');

        # save column content
        my $DataValue;

        my $Counter = 0;

        # show all needed columns
        CONFIGITEMCOLUMN:
        for my $ConfigItemColumn (@Col) {
            $LayoutObject->Block(
                Name => 'GeneralOverviewRow',
            );
            my $StaticColumn = !$Counter;
            $Counter++;

            if ( $ConfigItemColumn !~ m{\A DynamicField_}xms ) {
                $LayoutObject->Block(
                    Name => 'RecordConfigItemData',
                    Data => {},
                );

                if ( $SpecialColumns{$ConfigItemColumn} ) {
                    $LayoutObject->Block(
                        Name => 'Record' . $ConfigItemColumn,
                        Data => {
                            %ConfigItem,
                            StaticColumn => $StaticColumn,
                        },
                    );

                    next CONFIGITEMCOLUMN;
                }

                if ( $ConfigItemColumn eq 'CreatedBy' ) {

                    my %ConfigItemCreatedByInfo = $UserObject->GetUserData(
                        UserID => $ConfigItem{CreateBy},
                    );

                    $LayoutObject->Block(
                        Name => 'RecordConfigItemCreatedBy',
                        Data => {
                            %ConfigItemCreatedByInfo,
                            StaticColumn => $StaticColumn,
                        },
                    );
                    next CONFIGITEMCOLUMN;
                }

                my $BlockType = '';
                my $CSSClass  = $StaticColumn ? 'StaticColumn' : '';
                if (
                    $ConfigItemColumn eq 'DeplState'
                    || $ConfigItemColumn eq 'CurDeplState'
                    || $ConfigItemColumn eq 'InciState'
                    || $ConfigItemColumn eq 'CurInciState'
                    || $ConfigItemColumn eq 'Class'
                    )
                {
                    $BlockType = 'Translatable';
                    $DataValue = $ConfigItem{$ConfigItemColumn};
                }
                elsif ( $ConfigItemColumn eq 'Created' || $ConfigItemColumn eq 'Changed' ) {
                    $BlockType = 'Time';
                    $DataValue = $ConfigItem{$ConfigItemColumn};
                }
                else {
                    $DataValue = $ConfigItem{$ConfigItemColumn};

                    # If value is in date format, change block type to 'Time' so it can be localized. See bug#14542.
                    if (
                        defined $DataValue
                        && $DataValue =~ /^\d\d\d\d-(\d|\d\d)-(\d|\d\d)\s(\d|\d\d):(\d|\d\d):(\d|\d\d)$/
                        )
                    {
                        $BlockType = 'Time';
                    }
                }

                $LayoutObject->Block(
                    Name => "RecordConfigItemColumn$BlockType",
                    Data => {
                        GenericValue => $DataValue || '-',
                        Class        => $CSSClass  || '',
                    },
                );
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
                    Name => 'RecordDynamicField',
                    Data => {
                        Value => $ValueStrg->{Value},
                        Title => $ValueStrg->{Title},
                    },
                );

                if ( $ValueStrg->{Link} ) {
                    $LayoutObject->Block(
                        Name => 'RecordDynamicFieldLink',
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
                        Name => 'RecordDynamicFieldPlain',
                        Data => {
                            Value => $ValueStrg->{Value},
                            Title => $ValueStrg->{Title},
                        },
                    );
                }

                # example of dynamic fields order customization
                $LayoutObject->Block(
                    Name => 'RecordDynamicField_' . $DynamicFieldConfig->{Name},
                    Data => {
                        Value => $ValueStrg->{Value},
                        Title => $ValueStrg->{Title},
                    },
                );

                if ( $ValueStrg->{Link} ) {
                    $LayoutObject->Block(
                        Name => 'RecordDynamicField_' . $DynamicFieldConfig->{Name} . '_Link',
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
                        Name => 'RecordDynamicField_' . $DynamicFieldConfig->{Name} . '_Plain',
                        Data => {
                            Value => $ValueStrg->{Value},
                            Title => $ValueStrg->{Title},
                        },
                    );
                }
            }
        }

        # add action items as js
        if ( $ConfigItem{ActionItems} ) {

            # replace TT directives from string with values
            for my $ActionItem ( @{ $ConfigItem{ActionItems} } ) {
                $ActionItem->{Link} = $LayoutObject->Output(
                    Template => $ActionItem->{Link},
                    Data     => {
                        ConfigItemID => $ConfigItem{ConfigItemID},
                    },
                );
            }

            # $ActionRowConfigItems{ $ConfigItem{ConfigItemID} } = $LayoutObject->JSONEncode( Data => $ConfigItem{ActionItems} );
            $LayoutObject->AddJSData(
                Key   => 'ITSMConfigItemActionRow.' . $ConfigItem{ConfigItemID},
                Value => $ConfigItem{ActionItems},
            );
        }
    }

    # set column filter form, to correctly fill the column filters is necessary to pass each
    #    overview some information in the AJAX call, for example the fixed Filters or NavBarFilters
    #    and also other values like the Queue in AgentITSMConfigItemQueue, otherwise the filters will be
    #    filled with default restrictions, resulting in more options than the ones that the
    #    available config items should provide, see Bug#9902
    if ( IsHashRefWithData( $Param{ColumnFilterForm} ) ) {
        $LayoutObject->Block(
            Name => 'DocumentColumnFilterForm',
            Data => {},
        );

        for my $Element ( sort keys %{ $Param{ColumnFilterForm} } ) {
            $LayoutObject->Block(
                Name => 'DocumentColumnFilterFormElement',
                Data => {
                    ElementName  => $Element,
                    ElementValue => $Param{ColumnFilterForm}->{$Element},
                },
            );
        }
    }

    # use template
    my $Output = $LayoutObject->Output(
        TemplateFile => 'AgentITSMConfigItemOverviewSmall',
        Data         => {
            %Param,
            Type => $Self->{ViewType},
        },
    );

    return $Output;
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
            my $DynamicFieldBackendObject = $Kernel::OM->Get('Kernel::System::DynamicField::Backend');
            my $IsFiltrable               = $DynamicFieldBackendObject->HasBehavior(
                DynamicFieldConfig => $DynamicFieldConfig,
                Behavior           => 'IsFiltrable',
            );
            next DYNAMICFIELD if !$IsFiltrable;
            $Self->{ValidFiltrableColumns}->{$HeaderColumn} = $IsFiltrable;
            if ( IsArrayRefWithData($ConfigItemIDs) ) {

                # get the historical values for the field
                $ColumnFilterValues{$HeaderColumn} = $DynamicFieldBackendObject->ColumnFilterValuesGet(
                    DynamicFieldConfig => $DynamicFieldConfig,
                    LayoutObject       => $Kernel::OM->Get('Kernel::Output::HTML::Layout'),
                    ITSMConfigItemIDs  => $ConfigItemIDs,
                );
            }
            else {

                # get PossibleValues
                $ColumnFilterValues{$HeaderColumn} = $DynamicFieldBackendObject->PossibleValuesGet(
                    DynamicFieldConfig => $DynamicFieldConfig,
                );
            }
            last DYNAMICFIELD;
        }
    }

    return \%ColumnFilterValues;
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
        Name        => 'ColumnFilter' . $Param{ColumnName},
        Data        => $Data,
        Class       => $Class,
        Translation => $TranslationOption,
        SelectedID  => '',
    );
    return $ColumnFilterHTML;
}

sub FilterContent {
    my ( $Self, %Param ) = @_;

    return if !$Param{HeaderColumn};

    my $HeaderColumn = $Param{HeaderColumn};

    # get column values for to build the filters later
    my $ColumnValues = $Self->_GetColumnValues(
        OriginalConfigItemIDs => $Param{OriginalConfigItemIDs},
        HeaderColumn          => $HeaderColumn,
    );

    my $SelectedValue  = '';
    my $SelectedColumn = $HeaderColumn;
    if ( $HeaderColumn !~ m{ \A DynamicField_ }xms ) {
        $SelectedColumn .= 'IDs';
    }

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

    if ( $SelectedColumn && $Self->{StoredFilters}->{$SelectedColumn} ) {

        if ( IsArrayRefWithData( $Self->{StoredFilters}->{$SelectedColumn} ) ) {
            $SelectedValue = $Self->{StoredFilters}->{$SelectedColumn}->[0];
        }
        elsif ( IsHashRefWithData( $Self->{StoredFilters}->{$SelectedColumn} ) ) {
            $SelectedValue = $Self->{StoredFilters}->{$SelectedColumn}->{Equals};
        }
    }

    # variable to save the filter's HTML code
    my $ColumnFilterJSON = $Self->_ColumnFilterJSON(
        ColumnName    => $HeaderColumn,
        Label         => $LabelColumn,
        ColumnValues  => $ColumnValues->{$HeaderColumn},
        SelectedValue => $SelectedValue,
    );

    return $ColumnFilterJSON;
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

    if (
        !$Self->{AvailableFiltrableColumns}->{ $Param{ColumnName} } &&
        !$Self->{AvailableFiltrableColumns}->{ $Param{ColumnName} . 'IDs' }
        )
    {
        return;
    }

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
                Name         => 'ColumnFilter' . $Param{ColumnName},
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

sub _DefaultColumnSort {

    my %DefaultColumns = (
        CurDeplState => 110,
        CurInciState => 111,
        Class        => 112,
        Number       => 113,
        Name         => 114,
        LastChanged  => 115,
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

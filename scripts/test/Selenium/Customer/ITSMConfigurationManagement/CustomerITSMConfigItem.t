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

use strict;
use warnings;
use utf8;

# core modules

# CPAN modules

# OTOBO modules
use Kernel::System::UnitTest::RegisterDriver;    # Set up $Kernel::OM and the test driver $Self
use Kernel::System::UnitTest::Selenium;

our $Self;

my $Selenium = Kernel::System::UnitTest::Selenium->new;

$Selenium->RunTest(
    sub {

        my $Helper               = $Kernel::OM->Get('Kernel::System::UnitTest::Helper');
        my $GeneralCatalogObject = $Kernel::OM->Get('Kernel::System::GeneralCatalog');
        my $ConfigObject         = $Kernel::OM->Get('Kernel::Config');

        $Kernel::OM->ObjectParamAdd(
            $Helper => {
                RestoreDatabase => 1,
            },
        );

        # get catalog class IDs
        my $ITSMConfigItemHelper = $Kernel::OM->Get('Kernel::System::UnitTest::ITSMConfigItemHelper');
        $ITSMConfigItemHelper->TestConfigItemCreateLegacyClasses(
            HelperObject => $Helper
        );
        my @ConfigItemClassIDs;
        my @TestClasses = qw(Computer Hardware Location Network);
        for my $ConfigItemClass (@TestClasses) {
            my $ConfigItemDataRef = $GeneralCatalogObject->ItemGet(
                Class => 'ITSM::ConfigItem::Class',
                Name  => $ConfigItemClass,
            );
            push @ConfigItemClassIDs, $ConfigItemDataRef->{ItemID};
        }

        # Get 'Production' deployment state ID.
        my $DeplStateDataRef = $GeneralCatalogObject->ItemGet(
            Class => 'ITSM::ConfigItem::DeploymentState',
            Name  => 'Production',
        );
        my $DeplStateID      = $DeplStateDataRef->{ItemID};
        my $ConfigItemObject = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');

        #        my $Owner           = '"Test Test" <test@test.com>';
        #        my $ComputerClassID = $GeneralCatalogObject->ItemGet(
        #            Class => 'ITSM::ConfigItem::Class',
        #            Name  => 'Computer',
        #        );

        # Create ConfigItem for each ConfigItem class.
        my @ConfigItemNumbers;
        my @ConfigItemIDs;
        for my $ITSMConfigItem (@ConfigItemClassIDs) {

            # Create ConfigItem number.
            my $ConfigItemNumber = $ConfigItemObject->ConfigItemNumberCreate(
                Type    => 'Kernel::System::ITSMConfigItem::Number::AutoIncrement',
                ClassID => $ITSMConfigItem,
            );
            $Self->True(
                $ConfigItemNumber,
                "ConfigItem number is created - $ConfigItemNumber"
            );
            push @ConfigItemNumbers, $ConfigItemNumber;

            # Add the new ConfigItem.
            my $ConfigItemID = $ConfigItemObject->ConfigItemAdd(
                Name        => 'SeleniumTest',
                Number      => $ConfigItemNumber,
                ClassID     => $ITSMConfigItem,
                UserID      => 1,
                DeplStateID => $DeplStateID,
                InciStateID => 1,
            );
            $Self->True(
                $ConfigItemID,
                "ConfigItem is created - ID $ConfigItemID"
            );

            #            my %XMLData;
            #            if ( $ComputerClassID->{ItemID} == $ITSMConfigItem ) {
            #                %XMLData = (
            #                    XMLData => [
            #                        undef,
            #                        {
            #                            Version => [
            #                                undef,
            #                                {
            #                                    Owner => [
            #                                        undef,
            #                                        {
            #                                            Content => $Owner,
            #                                        },
            #                                    ],
            #                                },
            #                            ],
            #                        },
            #                    ],
            #                );
            #            }

            #            # Add a new version.
            #            my $VersionID = $ConfigItemObject->VersionAdd(
            #                Name         => 'SeleniumTest',
            #                DefinitionID => 1,
            #                DeplStateID  => $DeplStateID,
            #                InciStateID  => 1,
            #                UserID       => 1,
            #                ConfigItemID => $ConfigItemID,
            #                %XMLData,
            #            );
            #            $Self->True(
            #                $VersionID,
            #                "Version is created - ID $VersionID"
            #            );
            push @ConfigItemIDs, $ConfigItemID;
        }

        my %CustomerITSMConfigItemSysConfig = $Kernel::OM->Get('Kernel::System::SysConfig')->SettingGet(
            Name => 'CustomerFrontend::Module###CustomerITSMConfigItem',
        );
        $Helper->ConfigSettingChange(
            Valid => 1,
            Key   => 'CustomerFrontend::Module###CustomerITSMConfigItem',
            Value => $CustomerITSMConfigItemSysConfig{EffectiveValue}
        );

        for my $Index ( 1 .. 5 ) {
            my %PermissionConditionsSysConfig = $Kernel::OM->Get('Kernel::System::SysConfig')->SettingGet(
                Name => "Customer::ConfigItem::PermissionConditions###0$Index",
            );

            if ( $Index > 1 ) {
                $PermissionConditionsSysConfig{EffectiveValue}{Name}    = $TestClasses[ $Index - 2 ];
                $PermissionConditionsSysConfig{EffectiveValue}{Classes} = [ $TestClasses[ $Index - 2 ] ];
            }

            $Helper->ConfigSettingChange(
                Valid => 1,
                Key   => "Customer::ConfigItem::PermissionConditions###0$Index",
                Value => $PermissionConditionsSysConfig{EffectiveValue}
            );
        }

        # Create test user and login.
        my $TestUserLogin = $Helper->TestUserCreate(
            Groups => [ 'admin', 'itsm-configitem' ],
        ) || die "Did not get test user";

        $Selenium->Login(
            Type     => 'Customer',
            User     => 'tina',
            Password => 'tina',
        );

        my $ScriptAlias = $ConfigObject->Get('ScriptAlias');

        # Navigate to CustomerITSMConfigItem, sorted by created time by clicking ConfigItems icon on the side menu bar
        $Selenium->find_element(
            "//a[contains(\@href, \'Action=CustomerITSMConfigItem' )]"
        )->VerifiedClick();

        # Navigate to CustomerITSMConfigItem, sorted by created time.
        #$Selenium->VerifiedGet(
        #    "${ScriptAlias}index.pl?Action=CustomerITSMConfigItem;View=Small;Filter=1;;SortBy=Created;OrderBy=Down"
        #);

        # Check for created test ConfigItems with 'All' filter active
        #for my $AllConfigItem (@ConfigItemNumbers) {
        #    $Self->True(
        #        $Selenium->find_element("//div[contains(\@title, \'$AllConfigItem\' )]"),
        #        "Test ConfigItem number $AllConfigItem - found",
        #    );
        #}

        # Check each of ConfigItem class filters for their respective test ConfigItem
        my $Index = 0;
        CONFIGITEM:
        for my $Index ( 1 .. 5 ) {

            # Click on ConfigItem class
            $Selenium->find_element(
                "//a[contains(\@href, \'Action=CustomerITSMConfigItem;Subaction=;Filter=$Index;SortBy=;OrderBy=;Fulltext=' )]"
            )->VerifiedClick();

            next CONFIGITEM if $Index == 1;

            # order by descending creation time
            $Selenium->find_element(
                "//th[contains(\@class, \'OverviewHeader\' ) and contains(\@class, \'Created\' )]"
            )->VerifiedClick();
            $Selenium->find_element(
                "//th[contains(\@class, \'OverviewHeader\' ) and contains(\@class, \'Created\' )]"
            )->VerifiedClick();

            # Check for ConfigItem number
            my $ConfigItemNumber = $ConfigItemNumbers[ $Index - 2 ];
            $Self->True(
                $Selenium->find_element("//a[contains(text(), \'$ConfigItemNumber\' )]"),
                "Test ConfigItem number $ConfigItemNumber - found",
            );

            #            # Check if there is column Create Time for Computer class
            #            # See bug#14049
            #            my $ConfigItemData = $ConfigItemObject->ConfigItemGet(
            #                ConfigItemID => $CheckConfigItem,
            #            );
            #            if ( $ConfigItemData->{Class} eq 'Computer' ) {
            #
            #                # Check if CustomerITSMConfigItem Owner is displayed correctly. See bug#14633.
            #                $Self->Is(
            #                    $Selenium->execute_script(
            #                        "return \$('#ConfigItemID_$CheckConfigItem td:contains($Owner)').text().trim();"
            #                    ),
            #                    $Owner,
            #                    'Owner name and address is displayed correctly',
            #                );
            #
            #                $Self->True(
            #                    $Selenium->find_element("//a[contains(.,'Create Time')]"),
            #                    "There is column 'CreateTime', enabled by sysconfig item  CustomerITSMConfigItem###ShowColumnsByClass",
            #                );
            #            }
        }

        # Verify there is a link to CustomerITSMConfigItemZoom on ConfigItem Number column.
        $Self->True(
            $Selenium->execute_script(
                "return \$('tr:eq(\"1\") a:contains($ConfigItemNumbers[3])[href*=\"ItemID=$ConfigItemIDs[3]\"]').length;"
            ),
            "Link on ConfigItem 'Number' column correct."
        );

        # Delete created test ConfigItems.
        for my $ConfigItemDelete (@ConfigItemIDs) {
            my $Success = $ConfigItemObject->ConfigItemDelete(
                ConfigItemID => $ConfigItemDelete,
                UserID       => 1,
            );
            $Self->True(
                $Success,
                "ConfigItem is deleted - ID $ConfigItemDelete",
            );
        }
    }
);

$Self->DoneTesting;

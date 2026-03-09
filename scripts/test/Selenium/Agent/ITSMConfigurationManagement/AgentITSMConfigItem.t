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
        for my $ConfigItemClass (qw(Computer Hardware Location Network Software)) {
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
        my $DeplStateID = $DeplStateDataRef->{ItemID};

        my $ConfigItemObject = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');

        my $Owner           = '"Test Test" <test@test.com>';
        my $ComputerClassID = $GeneralCatalogObject->ItemGet(
            Class => 'ITSM::ConfigItem::Class',
            Name  => 'Computer',
        );

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
                DeplStateID => $DeplStateID,
                InciStateID => 1,
                UserID      => 1,
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
            #                Name         => 'SeleniumTest2',
            #                DefinitionID => 1,
            #                DeplStateID  => $DeplStateID,
            #                InciStateID  => 1,
            #                UserID       => 1,
            #                ConfigItemID => $ConfigItemID,
            #
            #                #%XMLData,
            #            );
            #            $Self->True(
            #                $VersionID,
            #                "Version is created - ID $VersionID"
            #            );
            push @ConfigItemIDs, $ConfigItemID;
        }

        # Create test user and login.
        my $TestUserLogin = $Helper->TestUserCreate(
            Groups => [ 'admin', 'itsm-configitem' ],
        ) || die "Did not get test user";

        $Selenium->Login(
            Type     => 'Agent',
            User     => $TestUserLogin,
            Password => $TestUserLogin,
        );

        my $ScriptAlias = $ConfigObject->Get('ScriptAlias');

        # Navigate to AgentITSMConfigItem, sorted by created time.
        $Selenium->VerifiedGet(
            "${ScriptAlias}index.pl?Action=AgentITSMConfigItem;Filter=All;View=;SortBy=LastChanged;OrderBy=Down"
        );

        # Check for created test ConfigItems with 'All' filter active
        for my $ConfigItemNumber (@ConfigItemNumbers) {
            $Self->True(
                $Selenium->execute_script(
                    "return \$('a:contains($ConfigItemNumber)').length === 1"
                ),
                "Test ConfigItem value $ConfigItemNumber - found",
            );
        }

        # Check each of ConfigItem class filters for their respective test ConfigItem
        my $Count = 0;
        for my $ConfigItemNumber (@ConfigItemNumbers) {

            # Click on ConfigItem class
            $Selenium->find_element(
                "//a[contains(\@href, \'Action=AgentITSMConfigItem;SortBy=Changed;OrderBy=Down;View=Small;Filter=$ConfigItemClassIDs[$Count]' )]"
            )->VerifiedClick();

            # Check for table structure
            $Selenium->find_element( "#OverviewBody .TableSmall", 'css' );

            # Check for ConfigItem number
            $Self->True(
                $Selenium->execute_script(
                    "return \$('a:contains($ConfigItemNumber)').length"
                ),
                "Test ConfigItem value $ConfigItemNumber - found",
            );

            $Count++;

            #            # Check if there is column Create Time for Computer class
            #            # See bug#14049
            #            my $ConfigItemData = $ConfigItemObject->ConfigItemGet(
            #                ConfigItemID => $CheckConfigItem,
            #            );
            #            if ( $ConfigItemData->{Class} eq 'Computer' ) {
            #
            #                # Check if AgentITSMConfigItem Owner is displayed correctly. See bug#14633.
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
            #                    "There is column 'CreateTime', enabled by sysconfig item  AgentITSMConfigItem###ShowColumnsByClass",
            #                );
            #            }
        }

        # check if the number column has a link to the config item zoom
        $Self->True(
            $Selenium->execute_script(
                "return \$('tr:eq(\"1\") a:contains($ConfigItemNumbers[4])[href*=\"ItemID=$ConfigItemIDs[4]\"]').length;"
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

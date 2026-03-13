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

        # get helper objects
        my $Helper               = $Kernel::OM->Get('Kernel::System::UnitTest::Helper');
        my $ITSMConfigItemHelper = $Kernel::OM->Get('Kernel::System::UnitTest::ITSMConfigItemHelper');
        $Kernel::OM->ObjectParamAdd(
            $Helper => {
                RestoreDatabase => 1,
            },
        );

        my $ConfigItemObject     = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');
        my $GeneralCatalogObject = $Kernel::OM->Get('Kernel::System::GeneralCatalog');
        my $ConfigObject         = $Kernel::OM->Get('Kernel::Config');

        # get catalog class IDs
        $ITSMConfigItemHelper->TestConfigItemCreateLegacyClasses(
            HelperObject => $Helper
        );

        # Get 'Computer' catalog class IDs.
        my $ConfigItemDataRef = $GeneralCatalogObject->ItemGet(
            Class => 'ITSM::ConfigItem::Class',
            Name  => 'Computer',
        );
        my $ComputerConfigItemID = $ConfigItemDataRef->{ItemID};

        # Get 'Production' and 'Repair' deployment state IDs.
        my @DeplStateIDs;
        for my $DeplState (qw (Production Repair)) {
            my $DeplStateDataRef = $GeneralCatalogObject->ItemGet(
                Class => 'ITSM::ConfigItem::DeploymentState',
                Name  => $DeplState,
            );
            push @DeplStateIDs, $DeplStateDataRef->{ItemID};
        }

        # Create three test ConfigItems for 'Computer' ConfigItem class.
        my @ConfigItems;
        for ( 1 .. 3 ) {

            # Create ConfigItem number.
            my $ConfigItemNumber = $ConfigItemObject->ConfigItemNumberCreate(
                Type    => 'Kernel::System::ITSMConfigItem::Number::AutoIncrement',
                ClassID => $ComputerConfigItemID,
            );
            $Self->True(
                $ConfigItemNumber,
                "ConfigItem number is created - $ConfigItemNumber",
            );

            # Add the new ConfigItem.
            my $ConfigItemName = 'Hardware' . $Helper->GetRandomID();
            my $ConfigItemID   = $ConfigItemObject->ConfigItemAdd(
                Number      => $ConfigItemNumber,
                Name        => $ConfigItemName,
                ClassID     => $ComputerConfigItemID,
                DeplStateID => $DeplStateIDs[0],
                InciStateID => 1,
                UserID      => 1,
            );
            $Self->True(
                $ConfigItemID,
                "ConfigItem is created - ID $ConfigItemID"
            );

            push @ConfigItems,
                {
                    ID               => $ConfigItemID,
                    ConfigItemNumber => $ConfigItemNumber,
                };
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
            "${ScriptAlias}index.pl?Action=AgentITSMConfigItem;Filter=All;View=;;SortBy=LastChanged;OrderBy=Down"
        );

        # Select two created test ConfigItems.
        for my $SelectConfigItem (@ConfigItems) {

            # Don't click on third test ConfigItem.
            if ( $SelectConfigItem->{ID} ne $ConfigItems[2]->{ID} ) {
                $Selenium->find_element("//input[\@value='$SelectConfigItem->{ID}']")->click();
            }
        }

        # Click on bulk action.
        $Selenium->find_element("//*[text()='Bulk']")->click();

        # Switch to 'Bulk' window.
        $Selenium->WaitFor( WindowCount => 2 );
        my $Handles = $Selenium->get_window_handles();
        $Selenium->switch_to_window( $Handles->[1] );

        # wait until page has loaded, if necessary
        $Selenium->WaitFor( JavaScript => 'return typeof($) === "function" && $("#DeplStateID").length;' );

        # Check screen
        for my $ID (
            qw(DeplStateID InciStateID LinkTogether LinkTogetherLinkType LinkTogetherAnother LinkType submitRichText)
            )
        {
            my $Element = $Selenium->find_element( "#$ID", 'css' );
            $Element->is_enabled();
            $Element->is_displayed();
        }

        # Change deployment state to 'Repair' for test ConfigItems
        $Selenium->execute_script(
            "\$('#DeplStateID').val('$DeplStateIDs[1]').trigger('redraw.InputField').trigger('change')"
        );

        # link 'Alternative to' test ConfigItems together
        $Selenium->execute_script(
            "\$('#LinkTogether').val('1').trigger('redraw.InputField').trigger('change')"
        );
        $Selenium->execute_script(
            "\$('#LinkTogetherLinkType').val('ConnectedTo::Source').trigger('redraw.InputField').trigger('change')"
        );

        # link third test ConfigItem as part of first two
        $Selenium->find_element( "#LinkTogetherAnother", 'css' )->send_keys( $ConfigItems[2]->{ConfigItemNumber} );
        $Selenium->execute_script(
            "\$('#LinkType').val('Includes::Target').trigger('redraw.InputField').trigger('change')"
        );

        #$Selenium->find_element( "#LinkType option[value='Includes::Target']", 'css' )->click();

        # Submit bulk changes
        $Selenium->find_element( "#submitRichText", 'css' )->click();

        # Switch window
        $Selenium->WaitFor( WindowCount => 1 );
        $Selenium->switch_to_window( $Handles->[0] );

        # Navigate to first created test ConfigItems zoom view.
        $Selenium->VerifiedGet(
            "${ScriptAlias}index.pl?Action=AgentITSMConfigItemZoom;ConfigItemID=$ConfigItems[1]->{ID}"
        );

        # Check for other two created test ConfigItems.
        # Verify that link action in bulk screen was success.
        my $Count = 1;
        ITEM:
        for my $CheckConfigItem (@ConfigItems) {

            next ITEM if $ConfigItems[1]->{ConfigItemNumber} == $CheckConfigItem->{ConfigItemNumber};
            $Self->True(
                $Selenium->find_element(
                    "//a[\@class=\'AsBlock LinkObjectLink\'][contains(.,\'$CheckConfigItem->{ConfigItemNumber}\')]"
                ),
                "Test ConfigItem number $CheckConfigItem->{ConfigItemNumber} - found",
            );
            $Count++;
        }

        $DB::single = 1;

        $Self->True(
            $Selenium->find_element("//div[\@class='Value' and \@title='Repair']"),
            "Deployment state is Repair.",
        );

        # Delete created test ConfigItems.
        for my $ConfigItemDelete (@ConfigItems) {
            my $Success = $ConfigItemObject->ConfigItemDelete(
                ConfigItemID => $ConfigItemDelete->{ID},
                UserID       => 1,
            );
            $Self->True(
                $Success,
                "Config item is deleted - ID $ConfigItemDelete->{ID}",
            );
        }
    }
);

$Self->DoneTesting;

# --
# OTOBO is a web-based ticketing system for service organisations.
# --
# Copyright (C) 2001-2020 OTRS AG, https://otrs.com/
# Copyright (C) 2019-2025 Rother OSS GmbH, https://otobo.io/
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

use Test2::V0;
use Kernel::System::UnitTest::RegisterDriver;    # Set up $Kernel::OM and the test driver $Self
use Kernel::System::UnitTest::Selenium;

our $Self;

my $Selenium = Kernel::System::UnitTest::Selenium->new;

$Selenium->RunTest(
    sub {

        my $Helper               = $Kernel::OM->Get('Kernel::System::UnitTest::Helper');
        my $GeneralCatalogObject = $Kernel::OM->Get('Kernel::System::GeneralCatalog');
        my $ConfigItemObject     = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');
        my $ConfigObject         = $Kernel::OM->Get('Kernel::Config');

        # Get 'Hardware' catalog class IDs.
        my $ConfigItemDataRef = $GeneralCatalogObject->ItemGet(
            Class => 'ITSM::ConfigItem::Class',
            Name  => 'Hardware',
        );
        my $HardwareConfigItemID = $ConfigItemDataRef->{ItemID};

        # Get 'Production' deployment state IDs.
        my $ProductionDeplStateDataRef = $GeneralCatalogObject->ItemGet(
            Class => 'ITSM::ConfigItem::DeploymentState',
            Name  => 'Production',
        );
        my $ProductionDeplStateID = $ProductionDeplStateDataRef->{ItemID};

        # Create ConfigItem number.
        my $ConfigItemNumber = $ConfigItemObject->ConfigItemNumberCreate(
            Type    => 'Kernel::System::ITSMConfigItem::Number::AutoIncrement',
            ClassID => $HardwareConfigItemID,
        );
        $Self->True(
            $ConfigItemNumber,
            "ConfigItem number is created - $ConfigItemNumber"
        );

        # Add the new ConfigItem.
        my $ConfigItemID = $ConfigItemObject->ConfigItemAdd(
            Number  => $ConfigItemNumber,
            ClassID => $HardwareConfigItemID,
            UserID  => 1,
        );
        $Self->True(
            $ConfigItemID,
            "ConfigItem is created - ID $ConfigItemID"
        );

        # Add a new version.
        my $ConfigItemName = 'Hardware' . $Helper->GetRandomID();
        my $VersionID      = $ConfigItemObject->VersionAdd(
            Name         => $ConfigItemName,
            DefinitionID => 1,
            DeplStateID  => $ProductionDeplStateID,
            InciStateID  => 1,
            UserID       => 1,
            ConfigItemID => $ConfigItemID,
        );
        $Self->True(
            $VersionID,
            "Version is created - ID $VersionID"
        );

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

        # Navigate to AgentITSMConfigItemZoom screen.
        $Selenium->VerifiedGet(
            "${ScriptAlias}index.pl?Action=AgentITSMConfigItemZoom;ConfigItemID=$ConfigItemID;Version=$VersionID"
        );

        # Get ConfigItem value params.
        my @ConfigItemValues = (
            {
                Value => 'Hardware',
                Check => 'p.Value:contains(Hardware)',
            },
            {
                Value => $ConfigItemName,
                Check => "h1:contains($ConfigItemName)",
            },
        );

        # Check ConfigItem values on screen
        for my $CheckConfigItemValue (@ConfigItemValues) {
            $Self->True(
                $Selenium->execute_script(
                    "return \$('$CheckConfigItemValue->{Check}').length;"
                ),
                "Test ConfigItem value $CheckConfigItemValue->{Value} - found",
            );
        }

        # Click on 'Duplicate' menu item and switch window
        $Selenium->find_element(
            "//a[contains(\@href, \'Action=AgentITSMConfigItemEdit;DuplicateID=$ConfigItemID;VersionID=$VersionID\' )]"
        )->click();

        # switch window
        $Selenium->WaitFor( WindowCount => 2 );
        my $Handles = $Selenium->get_window_handles();
        $Selenium->switch_to_window( $Handles->[1] );

        # wait until page has loaded, if necessary
        $Selenium->WaitFor( JavaScript => 'return typeof($) === "function" && $("#DeplStateID").length;' );

        # Check for created ConfigItem values
        $Self->Is(
            $Selenium->find_element( '#Name', 'css' )->get_value(),
            $ConfigItemName,
            "#Name stored value",
        );
        $Self->Is(
            $Selenium->find_element( '#DeplStateID', 'css' )->get_value(),
            $ProductionDeplStateID,
            "#DeplStateID stored value",
        );
        $Self->Is(
            $Selenium->find_element( '#InciStateID', 'css' )->get_value(),
            1,
            "#InciStateID stored value",
        );

        # Edit name for duplicate test ConfigItem.
        my $DuplicateConfigItemName = "Duplicate" . $ConfigItemName;
        $Selenium->find_element( "#Name", 'css' )->clear();
        $Selenium->find_element( "#Name", 'css' )->send_keys($DuplicateConfigItemName);
        sleep 2;
        $Selenium->find_element("//button[\@value='Submit'][\@type='submit']")->click();

        # Switch back to zoom view.
        $Selenium->WaitFor( WindowCount => 1 );
        $Selenium->switch_to_window( $Handles->[0] );

        # Wait until page has loaded, if necessary.
        $Selenium->WaitFor(
            JavaScript =>
                'return typeof(Core) == "object" && typeof(Core.App) == "object" && Core.App.PageLoadComplete;'
        );
        $Selenium->WaitFor(
            JavaScript => "return typeof(\$) === 'function' && \$('h1:contains($DuplicateConfigItemName)').length;"
        );

        # Check for duplicated ConfigItem value.
        $Self->True(
            $Selenium->execute_script(
                "return \$('h1:contains($DuplicateConfigItemName)').length;"
            ),
            "Test ConfigItem value $DuplicateConfigItemName - found",
        );

        # Delete created test ConfigItems.
        for ( 1 .. 2 ) {
            my $Success = $ConfigItemObject->ConfigItemDelete(
                ConfigItemID => $ConfigItemID,
                UserID       => 1,
            );
            ok( $Success, "ConfigItem is deleted - ID $ConfigItemID" );
            $ConfigItemID++;
        }
    }
);

$Self->DoneTesting;

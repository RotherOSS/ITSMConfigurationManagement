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

# get selenium object
my $Selenium = Kernel::System::UnitTest::Selenium->new;

$Selenium->RunTest(
    sub {

        # get needed objects
        my $Helper               = $Kernel::OM->Get('Kernel::System::UnitTest::Helper');
        my $GeneralCatalogObject = $Kernel::OM->Get('Kernel::System::GeneralCatalog');

        $Kernel::OM->ObjectParamAdd(
            $Helper => {
                RestoreDatabase => 1,
            },
        );

        # get 'Hardware' catalog class IDs
        my $ConfigItemDataRef = $GeneralCatalogObject->ItemGet(
            Class => 'ITSM::ConfigItem::Class',
            Name  => 'Hardware',
        );
        my $HardwareConfigItemID = $ConfigItemDataRef->{ItemID};

        # get 'Production' and 'Repair' deployment state IDs
        my @DeplStateIDs;
        my @DeplStates = (qw(Production Repair));
        my $DeplStateDataRef;
        for my $DeplState (@DeplStates) {
            $DeplStateDataRef = $GeneralCatalogObject->ItemGet(
                Class => 'ITSM::ConfigItem::DeploymentState',
                Name  => $DeplState,
            );
            push @DeplStateIDs, $DeplStateDataRef->{ItemID};
        }

        # get needed objects
        my $ConfigItemObject = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');
        my $ConfigObject     = $Kernel::OM->Get('Kernel::Config');

        my $HardwareClassDataRef = $GeneralCatalogObject->ItemGet(
            Class => 'ITSM::ConfigItem::Class',
            Name  => 'Hardware',
        );

        # set Name update as a version triggering event
        $GeneralCatalogObject->GeneralCatalogPreferencesSet(
            ItemID => $HardwareClassDataRef->{ItemID},
            Key    => 'VersionTrigger',
            Value  => ['Name']
        );

        # create ConfigItem number
        my $ConfigItemNumber = $ConfigItemObject->ConfigItemNumberCreate(
            Type    => 'Kernel::System::ITSMConfigItem::Number::AutoIncrement',
            ClassID => $HardwareConfigItemID,
        );
        $Self->True(
            $ConfigItemNumber,
            "ConfigItem number is created - $ConfigItemNumber"
        );

        # add the new ConfigItem
        my $ConfigItemID = $ConfigItemObject->ConfigItemAdd(
            Number      => $ConfigItemNumber,
            ClassID     => $HardwareConfigItemID,
            DeplStateID => $DeplStateDataRef->{ItemID},
            InciStateID => 1,
            Name        => 'SeleniumTest',
            UserID      => 1,
        );
        $Self->True(
            $ConfigItemID,
            "ConfigItem is created - ID $ConfigItemID"
        );

        # add two versions
        my @UpdatedNames = ( 'SeleniumTest2', 'SeleniumTest3' );
        my %NamesByVersion;
        for my $Name (@UpdatedNames) {
            my $Success = $ConfigItemObject->ConfigItemUpdate(
                Name         => $Name,
                UserID       => 1,
                ConfigItemID => $ConfigItemID,
                Number       => $ConfigItemNumber,
            );
            $Self->True(
                $Success,
                "Name is updated - '$Name'"
            );
            my $ConfigItem = $ConfigItemObject->ConfigItemGet(
                ConfigItemID => $ConfigItemID,
            );
            $Self->True(
                $ConfigItem->{LastVersionID},
                "Version is created - ID $ConfigItem->{LastVersionID}"
            );
            $NamesByVersion{ $ConfigItem->{LastVersionID} } = $Name;
        }
        my @VersionIDs = sort keys %NamesByVersion;

        # create test user and login
        my $TestUserLogin = $Helper->TestUserCreate(
            Groups => [ 'admin', 'itsm-configitem' ],
        ) || die "Did not get test user";

        $Selenium->Login(
            Type     => 'Agent',
            User     => $TestUserLogin,
            Password => $TestUserLogin,
        );

        # get script alias
        my $ScriptAlias = $ConfigObject->Get('ScriptAlias');

        # Navigate to AgentITSMConfigItem screen.
        $Selenium->VerifiedGet(
            "${ScriptAlias}index.pl?Action=AgentITSMConfigItem;SortBy=Number;OrderBy=Down;View=;Filter=$HardwareConfigItemID"
        );

        # Click on created ConfigItem.
        $Selenium->find_element("//a[contains( text(), '$ConfigItemNumber' )]")->VerifiedClick();

        # get ConfigItem value params
        my @ConfigItemValues = (
            {
                Value => 'Hardware',
                Check => 'p.Value:contains(Hardware)',
            },
            {
                Value => 'SeleniumTest',
                Check => 'p.Value:contains(SeleniumTest3)',
            },
            {
                Value => 'Repair',
                Check => 'div.Value:contains(Repair)',
            },
            {
                Value => 'Operational',
                Check => 'div.Value:contains(Operational)',
            },
            {
                Value => "$ConfigItemNumber",
                Check => "h1:contains($ConfigItemNumber)",
            },
        );

        # check ConfigItem values on screen
        for my $CheckConfigItemValue (@ConfigItemValues) {
            $Self->True(
                $Selenium->execute_script(
                    "return \$('$CheckConfigItemValue->{Check}').length"
                ),
                "Test ConfigItem value $CheckConfigItemValue->{Value} - found",
            );
        }

        for my $VersionID (@VersionIDs) {
            my $Value = "${ScriptAlias}index.pl?Action=AgentITSMConfigItemZoom;ConfigItemID=$ConfigItemID;VersionID=$VersionID";
            $Selenium->execute_script(
                "\$('#VersionSelection').val('$Value').trigger('redraw.InputField').trigger('change')"
            );

            $Self->True(
                "return \$('$NamesByVersion{$VersionID}').length",
                "$NamesByVersion{$VersionID} ($VersionID) - found",
            );
        }

        # get test menu buttons params
        my @MenuButtons = (
            {
                Name => 'Back',
                Link => "Action=AgentITSMConfigItem;SortBy=Number;OrderBy=Down;View=;Filter=$HardwareConfigItemID",
            },
            {
                Name => 'History',
                Link => "AgentITSMConfigItemHistory;ConfigItemID=$ConfigItemID;VersionID=$VersionIDs[1]",
            },
            {
                Name => 'Edit',
                Link => "AgentITSMConfigItemEdit;ConfigItemID=$ConfigItemID",
            },
            {
                Name => 'Print',
                Link => "AgentITSMConfigItemPrint;ConfigItemID=$ConfigItemID;VersionID=$VersionIDs[1]",
            },
            {
                Name => 'Link',
                Link => "AgentLinkObject;SourceObject=ITSMConfigItem;SourceKey=$ConfigItemID",
            },
            {
                Name => 'Duplicate',
                Link => "Action=AgentITSMConfigItemEdit;DuplicateID=$ConfigItemID;VersionID=$VersionIDs[1]",
            },
        );

        # check menu buttons
        for my $MenuButtonCheck (@MenuButtons) {
            my $Success = $Selenium->find_element("//a[contains(\@href, \'$MenuButtonCheck->{Link}' )]");
            $Self->True(
                $Success,
                "Menu button $MenuButtonCheck->{Name} - found",
            );
        }

        # delete created test ConfigItem
        my $Success = $ConfigItemObject->ConfigItemDelete(
            ConfigItemID => $ConfigItemID,
            UserID       => 1,
        );
        $Self->True(
            $Success,
            "ConfigItem is deleted - ID $ConfigItemID",
        );
    }

);

$Self->DoneTesting;

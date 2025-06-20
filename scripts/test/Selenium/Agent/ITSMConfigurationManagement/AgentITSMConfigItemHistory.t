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

        # get 'Hardware' catalog class IDs
        my $ConfigItemDataRef = $GeneralCatalogObject->ItemGet(
            Class => 'ITSM::ConfigItem::Class',
            Name  => 'Hardware',
        );
        my $HardwareConfigItemID = $ConfigItemDataRef->{ItemID};

        # get 'Production' deployment state IDs
        my $ProductionDeplStateDataRef = $GeneralCatalogObject->ItemGet(
            Class => 'ITSM::ConfigItem::DeploymentState',
            Name  => 'Production',
        );
        my $ProductionDeplStateID = $ProductionDeplStateDataRef->{ItemID};

        # get needed objects
        my $ConfigItemObject = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');
        my $ConfigObject     = $Kernel::OM->Get('Kernel::Config');

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
            Number  => $ConfigItemNumber,
            ClassID => $HardwareConfigItemID,
            UserID  => 1,
        );
        $Self->True(
            $ConfigItemID,
            "ConfigItem is created - ID $ConfigItemID"
        );

        # add a new version
        my $VersionID = $ConfigItemObject->VersionAdd(
            Name         => 'SeleniumTest',
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

        # create test user and login
        my $TestUserLogin = $Helper->TestUserCreate(
            Groups => [ 'admin', 'itsm-configitem' ],
        ) || die "Did not get test user";

        $Selenium->Login(
            Type     => 'Agent',
            User     => $TestUserLogin,
            Password => $TestUserLogin,
        );

        # get test user ID
        my $TestUserID = $Kernel::OM->Get('Kernel::System::User')->UserLookup(
            UserLogin => $TestUserLogin,
        );

        # get script alias
        my $ScriptAlias = $ConfigObject->Get('ScriptAlias');

        # check for error message when no ConfigItemID is provided in history screen
        $Selenium->VerifiedGet("${ScriptAlias}index.pl?Action=AgentITSMConfigItemHistory");

        my $ErrorMessageNoID = 'Can\'t show history, no ConfigItemID is given!';
        $Self->True(
            index( $Selenium->get_page_source(), $ErrorMessageNoID ) > -1,
            "Error message $ErrorMessageNoID - found",
        );

        # create history messages list
        my @HistoryMessages = (
            'New ConfigItem (ID=' . $ConfigItemID . ')',
            'New version (ID=' . $VersionID . ')',
            'ConfigItem definition updated (ID=1)',
            'Name updated (new=SeleniumTest, old=)',
            'Incident state updated (new=Operational, old=)',
            'Deployment state updated (new=Production, old=)',
        );

        # check for history messages in history screen of created test ConfigItem
        $Selenium->VerifiedGet(
            "${ScriptAlias}index.pl?Action=AgentITSMConfigItemHistory;ConfigItemID=$ConfigItemID;VersionID=$VersionID"
        );

        for my $HistoryMessage (@HistoryMessages) {
            $Self->True(
                index( $Selenium->get_page_source(), $HistoryMessage ) > -1,
                "History message $HistoryMessage - found",
            );
        }

        # remove itsm-configitem 'ro' access right for test user
        # get group object
        my $GroupObject = $Kernel::OM->Get('Kernel::System::Group');

        # get 'itsm-configitem' group ID
        my $ITSMConfigItemGroupID = $GroupObject->GroupLookup(
            Group => 'itsm-configitem',
        );

        # remove access rights to test user
        $GroupObject->GroupMemberAdd(
            GID        => $ITSMConfigItemGroupID,
            UID        => $TestUserID,
            Permission => {
                ro => 0,
            },
            UserID => 1,
        );

        # check for error message when user have no access rights in history screen
        $Selenium->VerifiedGet(
            "${ScriptAlias}index.pl?Action=AgentITSMConfigItemHistory;ConfigItemID=$ConfigItemID;VersionID=$VersionID"
        );

        my $ErrorMessageNoPermission = 'No Permission to use this frontend module!';
        $Self->True(
            index( $Selenium->get_page_source(), $ErrorMessageNoPermission ) > -1,
            "Error message $ErrorMessageNoPermission - found",
        );

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

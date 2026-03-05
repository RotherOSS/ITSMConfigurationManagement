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

use v5.24;
use strict;
use warnings;
use utf8;

# core modules

# CPAN modules
#use Test2::V0;

# OTOBO modules
use Kernel::System::UnitTest::RegisterDriver;    # Set up $Kernel::OM and the test driver $Self
use Kernel::System::UnitTest::Selenium;

our $Self;

my $Selenium = Kernel::System::UnitTest::Selenium->new;

$Selenium->RunTest(
    sub {

        my $Helper               = $Kernel::OM->Get('Kernel::System::UnitTest::Helper');
        my $CIHelper             = $Kernel::OM->Get('Kernel::System::UnitTest::ITSMConfigItemHelper');
        my $ConfigItemObject     = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');
        my $GeneralCatalogObject = $Kernel::OM->Get('Kernel::System::GeneralCatalog');

        # get helper objects
        $Kernel::OM->ObjectParamAdd(
            $Helper => {
                RestoreDatabase => 1,
            },
        );

        # create config item classes

        my @Test = (
            {
                ConfigItemClass => 'Computer',
                CheckEditFields => [
                    'Name', 'DeplStateID', 'InciStateID', 'Vendor', 'Model', 'Description', 'Type', 'Owner',
                    'SerialNumber',
                    'OperatingSystem', 'CPU', 'Ram', 'HardDisk', 'Capacity', 'FQDN', 'DynamicField_Computer-NICSubPrimaryAttribute', 'PoverDHCP',
                    'GraphicAdapter',
                    'OtherEquipment', 'WarrantyExpirationDate', 'InstallDate', 'Note', 'FileUpload', 'Submit'
                ],
            },
            {
                ConfigItemClass => 'Hardware',
                CheckEditFields => [
                    'Name', 'DeplStateID', 'InciStateID', 'Vendor', 'Model', 'Description', 'Type', 'Owner',
                    'SerialNumber',
                    'WarrantyExpirationDate', 'InstallDate', 'Note', 'FileUpload', 'Submit'
                ],
            },
            {
                ConfigItemClass => 'Location',
                CheckEditFields => [
                    'Name', 'DeplStateID', 'InciStateID', 'Type', 'Phone1', 'Phone2', 'Fax', 'DynamicField_Location-EMail', 'Address',
                    'Note', 'FileUpload',  'Submit'
                ],
            },
            {
                ConfigItemClass => 'Network',
                CheckEditFields => [
                    'Name', 'DeplStateID', 'InciStateID', 'Description', 'Type', 'NetworkAddress', 'SubnetMask',
                    'Gateway',
                    'Note', 'FileUpload', 'Submit'
                ],
            },
            {
                ConfigItemClass => 'Software',
                CheckEditFields => [
                    'Name', 'DeplStateID', 'InciStateID', 'Vendor', 'Version', 'Description', 'Type', 'Owner',
                    'SerialNumber',
                    'LicenceType', 'LicenceKey', 'Media', 'Note', 'Submit'
                ],
            },
        );

        # Get 'Production' deployment state ID.
        my $DeplStateDataRef = $GeneralCatalogObject->ItemGet(
            Class => 'ITSM::ConfigItem::DeploymentState',
            Name  => 'Production',
        );
        my $DeplStateID = $DeplStateDataRef->{ItemID};

        # Create test user and login.
        my $TestUserLogin = $Helper->TestUserCreate(
            Groups => [ 'admin', 'itsm-configitem' ],
        ) || die "Did not get test user";

        $Selenium->Login(
            Type     => 'Agent',
            User     => $TestUserLogin,
            Password => $TestUserLogin,
        );

        my $ScriptAlias = $Kernel::OM->Get('Kernel::Config')->Get('ScriptAlias');
        my $RandomID    = $Helper->GetRandomID();

        for my $ConfigItemEdit (@Test) {

            # Navigate to AgentITSMConfigItemAdd screen.
            $Selenium->VerifiedGet("${ScriptAlias}index.pl?Action=AgentITSMConfigItemAdd");

            # Get ConfigItem class ID.
            my $ConfigItemDataRef = $GeneralCatalogObject->ItemGet(
                Class => 'ITSM::ConfigItem::Class',
                Name  => $ConfigItemEdit->{ConfigItemClass},
            );
            my $ConfigItemClassID = $ConfigItemDataRef->{ItemID};

            $Selenium->WaitFor(
                JavaScript =>
                    "return typeof(\$) === 'function' && \$('a[href*=\"Action=AgentITSMConfigItemEdit;ClassID=$ConfigItemClassID\"]').length"
            );

            # Click on ConfigItem class.
            $Selenium->find_element(
                "//a[contains(\@href, \'Action=AgentITSMConfigItemEdit;ClassID=$ConfigItemClassID\' )]"
            )->VerifiedClick();

            $Selenium->WaitFor(
                JavaScript => "return typeof(\$) === 'function' && \$('#Name').length && \$('#SubmitButton').length"
            );

            # Check for ConfigItemEdit fields.
            for my $CheckConfigItemField ( @{ $ConfigItemEdit->{CheckEditFields} } ) {

                my $Element = $Selenium->find_element("//*[contains(\@name, \'$CheckConfigItemField\' )]");
                $Element->is_enabled();
                $Element->is_displayed();
            }

            # Create test ConfigItem.
            my $ConfigItemName = $ConfigItemEdit->{ConfigItemClass} . $RandomID;
            $Selenium->find_element( "#Name", 'css' )->send_keys($ConfigItemName);

            $Selenium->execute_script(
                "\$('#DeplStateID').val('$DeplStateID').trigger('redraw.InputField').trigger('change')"
            );
            $Selenium->WaitFor(
                JavaScript => "return typeof(\$) === 'function' && \$('#DeplStateID').val() === '$DeplStateID'"
            );

            $Selenium->execute_script("\$('#InciStateID').val('1').trigger('redraw.InputField').trigger('change')");
            $Selenium->WaitFor( JavaScript => "return typeof(\$) === 'function' && \$('#InciStateID').val() === '1'" );

            if ( $ConfigItemEdit->{ConfigItemClass} eq 'Computer' ) {

                # Get General Catalog ID for 'Yes'.
                my $YesDataRef = $GeneralCatalogObject->ItemGet(
                    Class => 'ITSM::ConfigItem::YesNo',
                    Name  => 'Yes',
                );
                my $YesID = $YesDataRef->{ItemID};

                # Enter NIC name.
                $Selenium->find_element("//*[contains(\@name, \'DynamicField_Computer-NICSubPrimaryAttribute_0\' )]")->send_keys('SeleniumNetwork');

                # Select Yes for DHCPOverIP.
                $Selenium->execute_script(
                    "\$('#' + Core.App.EscapeSelector('DynamicField_Computer-NICIPoverDHCP_0')).val('$YesID').trigger('redraw.InputField').trigger('change');"
                );

                # Enter Other Equipment.
                $Selenium->find_element("//*[contains(\@name, \'DynamicField_Computer-OtherEquipment\' )]")->send_keys('Selenium Equipment');

                # Enter Notes.
                $Selenium->find_element("//*[contains(\@name, \'DynamicField_Computer-Note\' )]")->send_keys('Selenium Notes');

                # Select current date as the installation date.
                $Selenium->find_element("//*[contains(\@name, \'DynamicField_Computer-InstallDateUsed\' )]")->click();
            }
            elsif ( $ConfigItemEdit->{ConfigItemClass} eq 'Network' ) {
                $Selenium->find_element("//*[contains(\@name, \'DynamicField_Network-NetworkAddressSubPrimaryAttribute_0\' )]")->send_keys('Selenium LAN');

                # Enter Notes.
                $Selenium->find_element("//*[contains(\@name, \'DynamicField_Network-Note\' )]")->send_keys('Selenium Notes');
            }
            elsif ( $ConfigItemEdit->{ConfigItemClass} eq 'Hardware' ) {

                # Enter Notes.
                $Selenium->find_element("//*[contains(\@name, \'DynamicField_Hardware-Note\' )]")->send_keys('Selenium Notes');

                # Select current date as the installation date.
                $Selenium->find_element("//*[contains(\@name, \'DynamicField_Hardware-InstallDateUsed\' )]")->click();
            }
            elsif ( $ConfigItemEdit->{ConfigItemClass} eq 'Location' ) {

                # Enter Notes.
                $Selenium->find_element("//*[contains(\@name, \'DynamicField_Location-Note\' )]")->send_keys('Selenium Notes');
            }
            elsif ( $ConfigItemEdit->{ConfigItemClass} eq 'Software' ) {

                # Enter Notes.
                $Selenium->find_element("//*[contains(\@name, \'DynamicField_Software-Note\' )]")->send_keys('Selenium Notes');
            }
            $Selenium->find_element("//button[\@value='Submit'][\@type='submit']")->VerifiedClick();

            $Selenium->WaitFor(
                JavaScript => "return typeof(\$) === 'function' && \$('h1:contains($ConfigItemName)').length"
            );

            # Get ConfigItem value.
            my @ConfigItemValues = (
                {
                    Value       => $ConfigItemName,
                    Check       => "h1:contains($ConfigItemName)",
                    CheckResult => 1,
                },
                {
                    Value       => $ConfigItemEdit->{ConfigItemClass},
                    Check       => "p.Value:contains($ConfigItemEdit->{ConfigItemClass})",
                    CheckResult => 2,
                },
            );

            # Check submitted values in AgentITSMConfigItemZoom screen.
            for my $CheckConfigItemValue (@ConfigItemValues) {
                $Self->True(
                    $Selenium->execute_script(
                        "return \$('$CheckConfigItemValue->{Check}').length === $CheckConfigItemValue->{CheckResult}"
                    ),
                    "Test ConfigItem value $CheckConfigItemValue->{Value} - found",
                );
            }

            # Get ConfigItemID.
            my @ConfigItemIDs = $ConfigItemObject->ConfigItemSearch(
                Name   => $ConfigItemName,
                Result => 'ARRAY'
            );
            $Self->True(
                @ConfigItemIDs,
                "ConfigItem found for deletion - ID $ConfigItemIDs[0]",
            );

            # Delete created test ConfigItem.
            my $Success = $ConfigItemObject->ConfigItemDelete(
                ConfigItemID => $ConfigItemIDs[0],
                UserID       => 1,
            );
            $Self->True(
                $Success,
                "ConfigItem is deleted - ID $ConfigItemIDs[0]",
            );
        }
    }
);

$Self->DoneTesting;

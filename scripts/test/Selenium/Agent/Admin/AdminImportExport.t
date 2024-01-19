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

use v5.24;
use strict;
use warnings;
use utf8;

# core modules

# CPAN modules
use Test2::V0;

# OTOBO modules
use Kernel::System::UnitTest::RegisterOM;    # Set up $Kernel::OM
use Kernel::System::UnitTest::Selenium;

# some setup before starting the Selenium test

# needed objects
my $GeneralCatalogObject = $Kernel::OM->Get('Kernel::System::GeneralCatalog');
my $ConfigItemObject     = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');
my $ConfigObject         = $Kernel::OM->Get('Kernel::Config');

# The helper mustn't run in a transaction, because otherwise
# the webserver would not see the changes in the database.
my $Helper = $Kernel::OM->Get('Kernel::System::UnitTest::Helper');

# Create test user and login.
my $TestUserLogin = $Helper->TestUserCreate(
    Groups => [ 'admin', 'itsm-configitem' ],
) || die "Did not get test user";
ok( $TestUserLogin, 'test user created' );
my $TestUserID = $Kernel::OM->Get('Kernel::System::User')->UserLookup( UserLogin => $TestUserLogin );
ok( $TestUserID, 'got ID for test user' );

my $RandomID = $Helper->GetRandomID;

# The definition itself is irrelevant, it just has to be valid
my $ConfigItemYAMLDefinition = <<'END_YAML';
---
Pages:
  - Name: CI_1_Page1
    Interfaces: []
    Layout:
      Columns: 3
      ColumnWidth: 1fr
    Content:
      - Section: CI_1_Section1
        ColumnStart: 1
        RowStart: 1
  - Name: CI_1_Page2
    Layout:
      Columns: 3
      ColumnWidth: 1fr
    Content:
      - Section: CI_1_Section2
        ColumnStart: 1
        RowStart: 2

Sections:
  CI_1_Section1:
    Content:
       - Header: "This is section 1"
  CI_1_Section2:
    Content:
       - Header: "This is section 2"
END_YAML

my $TestClassID = $GeneralCatalogObject->ItemAdd(
    Class   => 'ITSM::ConfigItem::Class',
    Name    => "Class_$RandomID",
    ValidID => 1,
    UserID  => $TestUserID,
);
ok( $TestClassID, "Class added to GeneralCatalog" );

# give permission
{
    my $GroupID = $Kernel::OM->Get('Kernel::System::Group')->GroupLookup(
        Group  => 'itsm-configitem',
        UserID => 1,
    );
    ok( $GroupID, 'got ID for group itsm-configitem' );

    # Set permission.
    my $Success = $GeneralCatalogObject->GeneralCatalogPreferencesSet(
        ItemID => $TestClassID,
        Key    => 'Permission',
        Value  => $GroupID,
    );
    ok( $Success, 'setting permission was successful' );
}

# The config item class needs a valid definition
my $DefinitinAddResult = $ConfigItemObject->DefinitionAdd(
    ClassID    => $TestClassID,
    UserID     => $TestUserID,
    CreateBy   => $TestUserID,
    Definition => $ConfigItemYAMLDefinition,
);
ok( $DefinitinAddResult->{Success}, "DefinitionAdd() successful" );
my $DefinitionID = $DefinitinAddResult->{DefinitionID};
ok( $DefinitionID, "DefinitionAdd() got definition ID" );

# Get 'Production' deployment state ID.
my $DeplStateDataRef = $GeneralCatalogObject->ItemGet(
    Class => 'ITSM::ConfigItem::DeploymentState',
    Name  => 'Production',
);
my $ProductionDeplStateID = $DeplStateDataRef->{ItemID};

my $Selenium = Kernel::System::UnitTest::Selenium->new;

$Selenium->RunTest(
    sub {
        # Create ConfigItem number.
        my $ConfigItemNumber = $ConfigItemObject->ConfigItemNumberCreate(
            Type    => $ConfigObject->Get('ITSMConfigItem::NumberGenerator'),
            ClassID => $TestClassID,
        );
        ok( $ConfigItemNumber, "ConfigItem number is created - $ConfigItemNumber" );

        # Add 'Location' test ConfigItem.
        my $ConfigItemName = "Selenium" . $Helper->GetRandomID;
        my $ConfigItemID   = $ConfigItemObject->ConfigItemAdd(
            Name        => $ConfigItemName,
            Number      => $ConfigItemNumber,
            DeplStateID => $ProductionDeplStateID,
            InciStateID => 1,
            ClassID     => $TestClassID,
            UserID      => $TestUserID,
        );
        ok( $ConfigItemID, "ConfigItem 'Location' is created - ID $ConfigItemID" );

        $Selenium->Login(
            Type     => 'Agent',
            User     => $TestUserLogin,
            Password => $TestUserLogin,
        );

        # Navigate to AdminImportExport screen.
        my $ScriptAlias = $ConfigObject->Get('ScriptAlias');
        $Selenium->VerifiedGet("${ScriptAlias}index.pl?Action=AdminImportExport");

        # Check screen.
        $Selenium->find_element_by_css_ok("table");
        $Selenium->find_element_by_css_ok("table thead tr th");
        $Selenium->find_element_by_css_ok("table tbody tr td");

        # Click on 'Add template'.
        $Selenium->find_element("//a[contains(\@href, \'Action=AdminImportExport;Subaction=TemplateEdit' )]")->VerifiedClick();

        # Check and input step 1 of 5 screen.
        diag('Step 1');
        for my $StepOneID (
            qw(Name Object Format ValidID Comment)
            )
        {
            my $Element = $Selenium->find_element( "#$StepOneID", 'css' );
            ok( $Element, "$StepOneID found in step 1" );
            $Element->is_enabled_ok;
            $Element->is_displayed_ok;
        }
        my $ImportExportName = "ImportExport" . $Helper->GetRandomID();
        $Selenium->find_element( "#Name", 'css' )->send_keys($ImportExportName);
        $Selenium->execute_script(
            "\$('#Object').val('ITSMConfigItem').trigger('redraw.InputField').trigger('change');"
        );
        $Selenium->execute_script("\$('#Format').val('CSV').trigger('redraw.InputField').trigger('change');");
        $Selenium->find_element( "#Comment", 'css' )->send_keys('SeleniumTest');
        $Selenium->find_element("//button[\@class='Primary CallForAction'][\@type='submit']")->VerifiedClick();

        # Check and input step 2 of 5 screen.
        diag('Step 2');
        for my $StepTwoID (
            qw(ClassID CountMax EmptyFieldsLeaveTheOldValues)
            )
        {
            my $Element = $Selenium->find_element( "#$StepTwoID", 'css' );
            ok( $Element, "$StepTwoID found in step 2" );
            $Element->is_enabled_ok;
            $Element->is_displayed_ok;
        }
        $Selenium->execute_script(
            "\$('#ClassID').val('$TestClassID').trigger('redraw.InputField').trigger('change');"
        );
        $Selenium->find_element("//button[\@class='Primary CallForAction'][\@type='submit']")->VerifiedClick();

        # Check and input step 3 of 5 screen.
        diag('Step 3: format definition');
        for my $StepThreeID (
            qw(ColumnSeparator Charset IncludeColumnHeaders)
            )
        {
            my $Element = $Selenium->find_element( "#$StepThreeID", 'css' );
            ok( $Element, "$StepThreeID found in step 3" );
            $Element->is_enabled_ok;
            $Element->is_displayed_ok;
        }
        $Selenium->execute_script(
            "\$('#ColumnSeparator').val('Comma').trigger('redraw.InputField').trigger('change');"
        );

        # Check and input step 4 of 5 screen.
        $Selenium->find_element("//button[\@class='Primary CallForAction'][\@type='submit']")->VerifiedClick();
        $Selenium->find_element( "#MappingAddButton", 'css' )->VerifiedClick();
        diag('Step 4');
        for my $StepFourID (
            qw(Key Identifier)
            )
        {
            my $Element = $Selenium->find_element(".//*[\@id='Object::0::$StepFourID']");
            ok( $Element, "$StepFourID found in step 4" );
            $Element->is_enabled_ok;
            $Element->is_displayed_ok;
        }

        for my $StepFourClass (
            qw(ArrowUp ArrowDown DeleteColumn)
            )
        {
            my $Element = $Selenium->find_element( ".$StepFourClass", 'css' );
            ok( $Element, "$StepFourClass class found in step 4" );
            $Element->is_enabled_ok;
            $Element->is_displayed_ok;
        }
        $Selenium->find_element_by_css_ok("table");
        $Selenium->find_element_by_css_ok("table thead tr th");
        $Selenium->find_element_by_css_ok("table tbody tr td");

        # Select 'Number' mapping element.
        $Selenium->find_element(".//*[\@id='Object::0::Key']/option[2]")->click();

        # Add and select 'Name' mapping element.
        $Selenium->find_element( "#MappingAddButton", 'css' )->VerifiedClick();
        $Selenium->find_element(".//*[\@id='Object::1::Key']/option[3]")->click();

        # Add and select 'Deployment State' mapping element.
        $Selenium->find_element( "#MappingAddButton", 'css' )->VerifiedClick();
        $Selenium->find_element(".//*[\@id='Object::2::Key']/option[4]")->click();

        # Add and select 'Incident State' mapping element.
        $Selenium->find_element( "#MappingAddButton", 'css' )->VerifiedClick();
        $Selenium->find_element(".//*[\@id='Object::3::Key']/option[5]")->click();
        $Selenium->find_element( "#SubmitNextButton", 'css' )->VerifiedClick();

        # Check step 5 of 5 screen.
        diag('Step 5, restrict what is exported');
        for my $StepFiveID (
            qw(RestrictExport Number Name DeplStateIDs InciStateIDs)
            )
        {
            my $Element = $Selenium->find_element( "#$StepFiveID", 'css' );
            ok( $Element, "$StepFiveID found in step 5" );
            $Element->is_enabled_ok;
            $Element->is_displayed_ok;
        }

        # Search ConfigItem by number and deployment state.
        $Selenium->find_element( "#RestrictExport", 'css' )->click();
        $Selenium->find_element( "#Number",         'css' )->send_keys($ConfigItemNumber);
        $Selenium->find_element( "#Name",           'css' )->send_keys($ConfigItemName);
        $Selenium->execute_script(
            "\$('#DeplStateIDs').val('$ProductionDeplStateID').trigger('redraw.InputField').trigger('change');"
        );
        $Selenium->execute_script("\$('#InciStateIDs').val('1').trigger('redraw.InputField').trigger('change');");
        $Selenium->find_element("//button[\@class='Primary CallForAction'][\@type='submit']")->VerifiedClick();

        # Get TemplateID of created test template.
        my $DBObject = $Kernel::OM->Get('Kernel::System::DB');
        my ($TemplateID) = $DBObject->SelectRowArray(
            SQL  => 'SELECT id FROM imexport_template WHERE name = ?',
            Bind => [ \$ImportExportName ],
        );
        ok( $TemplateID, 'got the template ID' );

        # Navigate to test created ConfigItem and verify it.
        $Selenium->VerifiedGet("${ScriptAlias}index.pl?Action=AgentITSMConfigItemZoom;ConfigItemID=$ConfigItemID");
        $Selenium->content_contains(
            $ConfigItemName,
            "Test ConfigItem name $ConfigItemName - found",
        );

        # Export using the created test template.
        my $ImportExportObject = $Kernel::OM->Get('Kernel::System::ImportExport');
        my $ExportResultRef    = $ImportExportObject->Export(
            TemplateID => $TemplateID,
            UserID     => $TestUserID,
        );

        # sanity check of the export
        is(
            $ExportResultRef,
            {
                DestinationContent => [
                    qq{"$ConfigItemNumber","$ConfigItemName","Production","Operational"},
                ],
                Failed  => 0,
                Success => 1,
            },
            'export result'
        );

        # Delete created test ConfigItem and verify the deletion
        {
            $ConfigItemObject->ConfigItemDelete(
                ConfigItemID => $ConfigItemID,
                UserID       => $TestUserID,
            );

            my $ConfigItem = $ConfigItemObject->ConfigItemGet(
                ConfigItemID => $ConfigItemID,
                Cache        => 0,
            );

            # Check if ConfigItem is deleted.
            ok( !$ConfigItem, "ConfigItem is deleted - ID $ConfigItemID" );

            # Refresh screen and verify that test ConfigItem does not exist anymore.
            $Selenium->VerifiedRefresh();
            $Selenium->content_contains(
                "Can\'t show item, no access rights for ConfigItem are given!",
                "Test ConfigItem name $ConfigItemName is not found",
            );
        }

        # Before importing verify that the config items do not already exists
        for my $Count ( 1 .. 2 ) {
            my $ImportedConfigItemName = 'Seleniumtest_AdminImportExport_' . $Count;
            my $Count                  = $ConfigItemObject->ConfigItemSearch(
                Name   => $ImportedConfigItemName,
                Result => 'COUNT',
            );
            is( $Count, 0, "$ImportedConfigItemName does not exist before import" );
        }

        # Navigate to AdminImportExport screen.
        $Selenium->VerifiedGet("${ScriptAlias}index.pl?Action=AdminImportExport");

        # Click on 'Import'.
        $Selenium->find_element("//a[contains(\@href, \'Subaction=ImportInformation;TemplateID=$TemplateID' )]")->VerifiedClick();

        # Select Exported file and start importing.
        # The directory /opt/otobo/scripts/test/sample has been copied from OTOBO core into the Selenium image.
        # The content is:
        #   "10495000101","Seleniumtest_AdminImportExport_1","Production","Operational"
        #   "10495000102","Seleniumtest_AdminImportExport_2","Production","Operational"
        my $ImportLocation = '/opt/otobo/scripts/test/sample/ImportExport/TemplateImport.csv';
        $Selenium->find_element("//input[contains(\@name, \'SourceFile' )]")->send_keys($ImportLocation);
        $Selenium->find_element("//button[\@value='Start Import'][\@type='submit']")->VerifiedClick();

        # Check for expected outcome.
        $Selenium->content_contains(
            '(Created: 2)',
            "Import test ConfigItem - success",
        );

        # Navigate to imported test created ConfigItem and verify it.
        for my $Count ( 1 .. 2 ) {
            my $ImportedConfigItemName = 'Seleniumtest_AdminImportExport_' . $Count;

            subtest "checking import of $ImportedConfigItemName" => sub {
                my $ExpectedImportedConfigItemID = $ConfigItemID + $Count;
                my ( $FoundImportedConfigItemID, @OtherIDs ) = $ConfigItemObject->ConfigItemSearch(
                    Name   => $ImportedConfigItemName,
                    Result => 'ARRAY',
                );
                is( $ExpectedImportedConfigItemID, $FoundImportedConfigItemID, "$FoundImportedConfigItemID has been imported" );
                is( \@OtherIDs,                    [],                         "only one item found" );
                $Selenium->VerifiedGet(
                    "${ScriptAlias}index.pl?Action=AgentITSMConfigItemZoom;ConfigItemID=$FoundImportedConfigItemID"
                );
                $Selenium->content_contains(
                    $ImportedConfigItemName,
                    "Test ConfigItem name $ImportedConfigItemName is found",
                );

                # clean up, delete the test imported ConfigItem.
                my $DeleteSuccess = $ConfigItemObject->ConfigItemDelete(
                    ConfigItemID => $FoundImportedConfigItemID,
                    UserID       => $TestUserID,
                );
                ok( $DeleteSuccess, "ConfigItem $ImportedConfigItemName is deleted - ID $FoundImportedConfigItemID" );
            }
        }

        # Navigate to AdminImportExport screen.
        $Selenium->VerifiedGet("${ScriptAlias}index.pl?Action=AdminImportExport");

        $Selenium->WaitForjQueryEventBound(
            CSSSelector => "a.ImportExportDelete[data-id='$TemplateID']",
        );

        # Click to delete test template.
        $Selenium->find_element( "a.ImportExportDelete[data-id='$TemplateID']", 'css' )->click();

        $Selenium->WaitForjQueryEventBound(
            CSSSelector => "#DialogButton1:visible",
        );

        $Selenium->find_element( '#DialogButton1', 'css' )->click();
        $Selenium->WaitFor( ElementMissing => [ "a.ImportExportDelete[data-id='$TemplateID']", 'css' ] );

        # Check if test template is deleted.
        ok(
            !$Selenium->execute_script(
                "return \$('a.ImportExportDelete[data-id*=\"$TemplateID\"]').length;"
            ),
            "Test template is deleted",
        );
    }
);

# TODO: clean up of the database

done_testing;

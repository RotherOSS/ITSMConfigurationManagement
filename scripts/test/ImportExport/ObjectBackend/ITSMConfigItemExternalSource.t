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

use v5.24;
use strict;
use warnings;
use utf8;

# core modules

# CPAN modules
use Test2::V0;
use List::AllUtils qw(max min true);

# OTOBO modules
use Kernel::System::UnitTest::RegisterOM;    # Set up $Kernel::OM

# Sanity check whether ImportExport is available.
# This should succeed since ImportExport has been integrated into OTOBO core
{
    # get ImportExport module directory
    my $ImportExportModule = $Kernel::OM->Get('Kernel::Config')->Get('Home') . '/Kernel/System/ImportExport.pm';
    ok( -f $ImportExportModule, 'ImportExport.pm exists' );
}

# get needed objects
my $GeneralCatalogObject = $Kernel::OM->Get('Kernel::System::GeneralCatalog');
my $ImportExportObject   = $Kernel::OM->Get('Kernel::System::ImportExport');
my $ObjectBackendObject  = $Kernel::OM->Get('Kernel::System::ImportExport::ObjectBackend::ITSMConfigItem');
my $ConfigItemObject     = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');
my $ConfigObject         = $Kernel::OM->Get('Kernel::Config');

# get helper object
$Kernel::OM->ObjectParamAdd(
    'Kernel::System::UnitTest::Helper' => {
        RestoreDatabase => 1,
    },
);
my $Helper = $Kernel::OM->Get('Kernel::System::UnitTest::Helper');

# ------------------------------------------------------------ #
# make preparations
# ------------------------------------------------------------ #

# define needed variable
my $RandomID     = $Helper->GetRandomID;
my $TestIDSuffix = "UnitTest$RandomID";
diag "TestIDSuffix: '$TestIDSuffix'";

# create test user
my ( undef, $TestUserID ) = $Helper->TestUserCreate(
    Groups => [ 'users', 'itsm-configitem' ],
);

_LoadReadyToImportClasses();

# get the config item classes as name 2 id list
my $CIClassListRef = $GeneralCatalogObject->ItemList(
    Class => 'ITSM::ConfigItem::Class',
);
my %CIClassName2ID = reverse $CIClassListRef->%*;

# add ImportExport template
my $TemplateID = $ImportExportObject->TemplateAdd(
    Object  => 'ITSMConfigItem',
    Format  => 'CSV',
    Name    => 'UnitTest' . $RandomID,
    ValidID => 1,
    UserID  => $TestUserID,
);
$ImportExportObject->ObjectDataSave(
    TemplateID => $TemplateID,
    ObjectData => {
        ClassID                      => $CIClassName2ID{Subsidiary},
        EmptyFieldsLeaveTheOldValues => 'on',
    },
    UserID => $TestUserID,
);

my @MappingObjectData = (
    {
        Key        => 'Name',
        Identifier => 1,
    },
    {
        Key => 'DeplState',
    },
    {
        Key => 'InciState',
    },
    {
        Key => 'DynamicField_Location-City',
    },
    {
        Key => 'DynamicField_Location-ReferenceToCountry',
    },
);

MAPPINGOBJECTDATA:
for my $MappingObjectData (@MappingObjectData) {

    # add a new mapping row
    my $MappingID = $ImportExportObject->MappingAdd(
        TemplateID => $TemplateID,
        UserID     => $TestUserID,
    );

    # add the mapping object data
    $ImportExportObject->MappingObjectDataSave(
        MappingID         => $MappingID,
        MappingObjectData => $MappingObjectData,
        UserID            => $TestUserID,
    );
}

# add a general catalog test list
my $ConfigItemGroupID = $Kernel::OM->Get('Kernel::System::Group')->GroupLookup(
    Group  => 'itsm-configitem',
    UserID => $TestUserID,
);
ok( $ConfigItemGroupID, 'got group id for itsm-configitem' );

# don't care about valid emails
$ConfigObject->Set(
    Key   => 'CheckEmailAddresses',
    Value => 0,
);

# get deployment state list
my $DeplStateList = $GeneralCatalogObject->ItemList(
    Class => 'ITSM::ConfigItem::DeploymentState',
);
ref_ok( $DeplStateList, 'HASH', 'deployment state list is a hashref' );
my %DeplStateListReverse = reverse %{$DeplStateList};

# get incident state list
my $InciStateList = $GeneralCatalogObject->ItemList(
    Class => 'ITSM::Core::IncidentState',
);
ref_ok( $DeplStateList, 'HASH', 'incident state list is a hashref' );
my %InciStateListReverse = reverse %{$InciStateList};

# add the test config items
diag "add config item: Country";
my $CICountryID = $ConfigItemObject->ConfigItemAdd(
    Name        => 'TestCountry',
    ClassID     => $CIClassName2ID{Country},
    DeplStateID => $DeplStateListReverse{Production},
    InciStateID => $InciStateListReverse{Operational},
    UserID      => $TestUserID,
);
ok( $CICountryID, 'config item added' );

diag "add config item: Subsidiary";
my $CISubsidiaryID = $ConfigItemObject->ConfigItemAdd(
    Name                                       => 'TestSubsidiary',
    ClassID                                    => $CIClassName2ID{Subsidiary},
    DeplStateID                                => $DeplStateListReverse{Production},
    InciStateID                                => $InciStateListReverse{Operational},
    UserID                                     => $TestUserID,
    'DynamicField_Location-City'               => 'Bonn',
    'DynamicField_Location-ReferenceToCountry' => [$CICountryID],
);
ok( $CISubsidiaryID, 'config item added' );

# ------------------------------------------------------------ #
# define general ImportDataSave tests
# ------------------------------------------------------------ #
my @ImportDataTests = (
    {
        Name             => 'Importing data triggering a new version, keeping the old value',
        SourceImportData => {
            ObjectData => {
                ClassID                      => $CIClassName2ID{Subsidiary},
                EmptyFieldsLeaveTheOldValues => 'on',
            },
            ImportDataSave => {
                TemplateID    => $TemplateID,
                ImportDataRow => [
                    'TestSubsidiary',
                    'Production',
                    'Operational',
                    'Straubing',
                    '',
                ],
                UserID => $TestUserID,
            },
        },
        ReferenceImportData => {
            VersionCount => 2,
            LastVersion  => {
                Name                                       => 'TestSubsidiary',
                DeplState                                  => 'Production',
                InciState                                  => 'Operational',
                'DynamicField_Location-City'               => 'Straubing',
                'DynamicField_Location-ReferenceToCountry' => [$CICountryID],
            }
        },
    },
    {
        Name             => 'Importing data triggering a new version, emptying the old value',
        SourceImportData => {
            ObjectData => {
                ClassID                      => $CIClassName2ID{Subsidiary},
                EmptyFieldsLeaveTheOldValues => 'off',
            },
            ImportDataSave => {
                TemplateID    => $TemplateID,
                ImportDataRow => [
                    'TestSubsidiary',
                    'Production',
                    'Operational',
                    'München',
                    '',
                ],
                UserID => $TestUserID,
            },
        },
        ReferenceImportData => {
            VersionCount => 3,
            LastVersion  => {
                Name                         => 'TestSubsidiary',
                DeplState                    => 'Production',
                InciState                    => 'Operational',
                'DynamicField_Location-City' => 'München',
            }
        },
    },
);

# run general ImportDataTests tests
my $ImportTestCount = 1;
for my $Test (@ImportDataTests) {

    subtest "ImportData: $Test->{Name}" => sub {

        # check SourceImportData attribute
        if ( !$Test->{SourceImportData} || ref $Test->{SourceImportData} ne 'HASH' ) {

            fail("SourceImportData not found for this test.");

            return;
        }

        # set the object data
        if (
            $Test->{SourceImportData}{ObjectData}
            && ref $Test->{SourceImportData}{ObjectData} eq 'HASH'
            && $Test->{SourceImportData}{ImportDataSave}{TemplateID}
            )
        {
            $ImportExportObject->ObjectDataSave(
                TemplateID => $Test->{SourceImportData}{ImportDataSave}{TemplateID},
                ObjectData => $Test->{SourceImportData}{ObjectData},
                UserID     => $TestUserID,
            );
        }

        # set the general catalog preferences
        if (
            $Test->{SourceImportData}{ClassPreferences}
            && ref $Test->{SourceImportData}{ClassPreferences} eq 'HASH'
            )
        {
            for my $ClassName ( sort keys $Test->{SourceImportData}{ClassPreferences}->%* ) {
                for my $PreferenceKey ( sort keys $Test->{SourceImportData}{ClassPreferences}{$ClassName}->%* ) {
                    my $Success = $GeneralCatalogObject->GeneralCatalogPreferencesSet(
                        ItemID => $CIClassName2ID{$ClassName},
                        Key    => $PreferenceKey,
                        Value  => $Test->{SourceImportData}{ClassPreferences}{$ClassName}{$PreferenceKey},
                    );
                    ok( $Success, "Successfully set preference $PreferenceKey for class $ClassName" );
                }
            }
        }

        # import data save
        my ( $ConfigItemID, $RetCode ) = $ObjectBackendObject->ImportDataSave(
            %{ $Test->{SourceImportData}{ImportDataSave} },
            Counter => $ImportTestCount,
        );

        if ( !$Test->{ReferenceImportData} ) {

            ok( !$ConfigItemID, "ImportDataSave() - return no ConfigItemID" );
            ok( !$RetCode,      "ImportDataSave() - return no RetCode" );

            return;
        }

        ok( $ConfigItemID, "ImportDataSave() - return ConfigItemID: $ConfigItemID" );
        ok( $RetCode,      "ImportDataSave() - return RetCode: $RetCode" );

        # check the number of versions
        {
            my $VersionList = $ConfigItemObject->VersionList(
                ConfigItemID => $ConfigItemID,
            ) // [];

            is(
                scalar $VersionList->@*,
                $Test->{ReferenceImportData}{VersionCount} || 0,
                "ImportDataSave() - correct number of versions",
            );
        }

        # get the latest version
        my $VersionData = $ConfigItemObject->ConfigItemGet(
            ConfigItemID  => $ConfigItemID,
            DynamicFields => 1,
        );

        # check general elements
        ELEMENT:
        for my $Element (qw(Number Name DeplState InciState)) {

            next ELEMENT unless exists $Test->{ReferenceImportData}{LastVersion}{$Element};

            is(
                $VersionData->{$Element},
                $Test->{ReferenceImportData}{LastVersion}{$Element},
                "ImportDataSave() $Element is identical",
            );
        }

        # check dynamic field elements
        DF_KEY:
        for my $DFKey ( sort keys $Test->{ReferenceImportData}{LastVersion}->%* ) {
            next DF_KEY unless $DFKey =~ m/^DynamicField_/;

            ok( exists $VersionData->{$DFKey}, "$DFKey retrieved from new config item" );
            is(
                $VersionData->{$DFKey},
                $Test->{ReferenceImportData}{LastVersion}{$DFKey},
                "$DFKey has expected value"
            );
        }

        # tidy the general catalog preferences up
        if (
            $Test->{SourceImportData}{ClassPreferences}
            && ref $Test->{SourceImportData}{ClassPreferences} eq 'HASH'
            )
        {
            for my $ClassName ( sort keys $Test->{SourceImportData}{ClassPreferences}->%* ) {
                for my $PreferenceKey ( sort keys $Test->{SourceImportData}{ClassPreferences}{$ClassName}->%* ) {
                    my $Success = $GeneralCatalogObject->GeneralCatalogPreferencesSet(
                        ItemID => $CIClassName2ID{$ClassName},
                        Key    => $PreferenceKey,
                        Value  => [''],
                    );
                    ok( $Success, "Successfully reset preference $PreferenceKey for class $ClassName" );
                }
            }
        }
    };
}
continue {
    $ImportTestCount++;
}

sub _LoadReadyToImportClasses {

    my $Home = $Kernel::OM->Get('Kernel::Config')->Get('Home');

    my $MainObject = $Kernel::OM->Get('Kernel::System::Main');

    my $Content = $MainObject->FileRead(
        Location => "$Home/var/itsm/configitemclasses/IT-Servicemanagement-11_0_3.yml",
        Mode     => 'utf8',
    );

    ok( $Content, "Classes have been loaded" );

    $Content = ${ $Content || \'' };

    $Content = $Kernel::OM->Get('Kernel::System::YAML')->Load(
        Data => $Content,
    );

    if ( ref $Content eq 'HASH' ) {
        $Content = [$Content];
    }

    my $ConfigItemObject = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');

    # import the class YAML file
    my $Result = $ConfigItemObject->ClassImport(
        Content     => $Content,
        ClassExists => 'UPDATE',
    );

    ok( $Result->{Success}, "Classes have been imported" );

    return;
}

done_testing;

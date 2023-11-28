# --
# OTOBO is a web-based ticketing system for service organisations.
# --
# Copyright (C) 2001-2020 OTRS AG, https://otrs.com/
# Copyright (C) 2019-2023 Rother OSS GmbH, https://otobo.de/
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
use Path::Class qw(dir file);

# CPAN modules
use Test2::V0;

# OTOBO modules
use Kernel::System::UnitTest::RegisterOM;    # Set up $Kernel::OM

# get needed objects
my $CommandObject        = $Kernel::OM->Get('Kernel::System::Console::Command::Admin::ITSM::ImportExport::Export');
my $GeneralCatalogObject = $Kernel::OM->Get('Kernel::System::GeneralCatalog');
my $ConfigItemObject     = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');

# get helper object
$Kernel::OM->ObjectParamAdd(
    'Kernel::System::UnitTest::Helper' => {
        RestoreDatabase => 1,
    },
);
my $Helper   = $Kernel::OM->Get('Kernel::System::UnitTest::Helper');
my $RandomID = $Helper->GetRandomID();
ok( $RandomID, 'got a random ID' );
diag("RandomID: $RandomID");

# test command without --template-number option
my $ExitCode = $CommandObject->Execute;

is(
    $ExitCode,
    1,
    "No --template-number  - exit code",
);

# get 'Hardware' catalog class ID
my $ConfigItemDataRef = $GeneralCatalogObject->ItemGet(
    Class => 'ITSM::ConfigItem::Class',
    Name  => 'Hardware',
);
ref_ok( $ConfigItemDataRef, 'HASH', 'ConfigItemDataRef' );
my $HardwareConfigItemID = $ConfigItemDataRef->{ItemID};
ok( $HardwareConfigItemID, 'got an ID for config item class Hardware' );

# get 'Production' deployment state IDs
my $ProductionDeplStateDataRef = $GeneralCatalogObject->ItemGet(
    Class => 'ITSM::ConfigItem::DeploymentState',
    Name  => 'Production',
);
ref_ok( $ProductionDeplStateDataRef, 'HASH' );
my $ProductionDeplStateID = $ProductionDeplStateDataRef->{ItemID};
ok( $ProductionDeplStateID, 'got an ID for deployment state Production' );

# add test config items
my @ConfigItemIDs;
subtest 'create sample config items' => sub {
    for my $Count ( 1 .. 10 ) {

        # create ConfigItem number
        my $ConfigItemNumber = $ConfigItemObject->ConfigItemNumberCreate(
            Type    => $Kernel::OM->Get('Kernel::Config')->Get('ITSMConfigItem::NumberGenerator'),
            ClassID => $HardwareConfigItemID,
        );
        diag("ConfigItemNumber: '$ConfigItemNumber'");
        ok( $ConfigItemNumber, 'got a config item number' );

        # add sample ConfigItem
        my $ConfigItemID = $ConfigItemObject->ConfigItemAdd(
            Name        => join( '_', 'TestConfigItem🌞', $RandomID, $Count ),
            Number      => $ConfigItemNumber,
            ClassID     => $HardwareConfigItemID,
            DeplStateID => $ProductionDeplStateID,
            InciStateID => 1,
            UserID      => 1,
        );
        ok( $ConfigItemID, "Config item is created - $ConfigItemID" );

        push @ConfigItemIDs, $ConfigItemID;
    }
};

# get ImportExport object
my $ImportExportObject = $Kernel::OM->Get('Kernel::System::ImportExport');

# add test template
my $TemplateID = $ImportExportObject->TemplateAdd(
    Object  => 'ITSMConfigItem',
    Format  => 'CSV',
    Name    => 'Template' . $RandomID,
    ValidID => 1,
    Comment => 'Comment',
    UserID  => 1,
);
ok( $TemplateID, "Import/Export template is created" );
diag("TemplateID: $TemplateID");

# get object data for test template
my %TemplateRef = (
    'ClassID'  => $HardwareConfigItemID,
    'CountMax' => 10,
);
my $ObjectDataSaveSuccess = $ImportExportObject->ObjectDataSave(
    TemplateID => $TemplateID,
    ObjectData => \%TemplateRef,
    UserID     => 1,
);

ok( $ObjectDataSaveSuccess, "ObjectData for test template is added" );

# add the format data of the test template
my %FormatData = (
    Charset              => 'UTF-8',
    ColumnSeparator      => 'Comma',
    IncludeColumnHeaders => 1,
);
my $FormatDataSaveSuccess = $ImportExportObject->FormatDataSave(
    TemplateID => $TemplateID,
    FormatData => \%FormatData,
    UserID     => 1,
);
ok( $FormatDataSaveSuccess, "format data for test template is added" );

# save the search data of a template
my %SearchData = (
    Name => 'TestConfigItem*',
);
my $SearchDataSaveSuccess = $ImportExportObject->SearchDataSave(
    TemplateID => $TemplateID,
    SearchData => \%SearchData,
    UserID     => 1,
);
ok( $SearchDataSaveSuccess, "search data for test template is added" );

# add mapping data for test template
for my $ObjectDataValue (qw( Name DeplState InciState )) {

    my $MappingID = $ImportExportObject->MappingAdd(
        TemplateID => $TemplateID,
        UserID     => 1,
    );

    my $Success = $ImportExportObject->MappingObjectDataSave(
        MappingID         => $MappingID,
        MappingObjectData => { Key => $ObjectDataValue },
        UserID            => 1,
    );

    ok( $Success, "ObjectData for test template is mapped - $ObjectDataValue" );
}

# make directory for export file
my $Home            = $Kernel::OM->Get('Kernel::Config')->Get('Home');
my $TempDir         = $Kernel::OM->Get('Kernel::Config')->Get('TempDir');
my $DestinationPath = join '/', $TempDir, 'ImportExport';
my $ExportFilename  = "$DestinationPath/TemplateExport_$RandomID.csv";
ok( !-f $ExportFilename, 'no leftover export file' );
dir($DestinationPath)->mkpath;
ok( -d $DestinationPath, 'export dir was created' );

# test command with wrong template number
$ExitCode = $CommandObject->Execute(
    '--template-number', $Helper->GetRandomNumber,
    $ExportFilename
);

is(
    $ExitCode,
    1,
    "Command with wrong template number - exit code",
);
ok( !-e $ExportFilename, 'no export file was generated' );

# test command without destination argument
$ExitCode = $CommandObject->Execute( '--template-number', $TemplateID );

is(
    $ExitCode,
    1,
    "No destination argument - exit code",
);
ok( !-e $ExportFilename, 'no export file was generated' );

# test command with --template-number option and destination argument
$ExitCode = $CommandObject->Execute( '--template-number', $TemplateID, $ExportFilename );

is(
    $ExitCode,
    0,
    "Option - --template-number option and destination argument",
);
ok( -e $ExportFilename, 'export file was finally generated' );

# Content of the exported file, with considering the random id in the config item name
{
    my $ExpectedResultFile = dir($Home)->file('scripts/test/sample/ImportExport/TemplateExport.csv');
    my @ExpectedLines      = map {s/<<RANDOM_ID>>/$RandomID/r} $ExpectedResultFile->slurp;
    is( scalar @ExpectedLines, 11, 'got some expected content' );
    is(
        [ file($ExportFilename)->slurp ],
        \@ExpectedLines,
        "Content of $ExportFilename"
    );
}

# remove test destination path
diag("deleting $DestinationPath");
dir($DestinationPath)->rmtree;
ok( !-d $DestinationPath, 'test directory deleted' );

done_testing;

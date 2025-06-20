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

# OTOBO modules
use Kernel::System::UnitTest::RegisterOM;    # Set up $Kernel::OM

my $CommandObject = $Kernel::OM->Get('Kernel::System::Console::Command::Admin::ITSM::ConfigItem::Delete');

# get helper object, database changes should be restored
$Kernel::OM->ObjectParamAdd(
    'Kernel::System::UnitTest::Helper' => {
        RestoreDatabase => 1,
    },
);
my $Helper = $Kernel::OM->Get('Kernel::System::UnitTest::Helper');

# define needed variable
my $RandomID = $Helper->GetRandomID;

my $ExitCode = $CommandObject->Execute;
is(
    $ExitCode,
    1,
    "Admin::ITSM::ConfigItem::Delete exit code without options",
);

# check command with option --all and argument --accept n ( cancel deleting all config item)
$ExitCode = $CommandObject->Execute( '--all', 'n' );

is(
    $ExitCode,
    0,
    "Option '--all' n",
);

# check command with class options (invalid class)
my $RandomClass = 'TestClass' . $Helper->GetRandomID();
$ExitCode = $CommandObject->Execute( '--class', $RandomClass );

is(
    $ExitCode,
    1,
    "Option 'class' (but class $RandomClass doesn't exist) ",
);

# get general catalog object
my $GeneralCatalogObject = $Kernel::OM->Get('Kernel::System::GeneralCatalog');

my $ConfigItemGroupID = $Kernel::OM->Get('Kernel::System::Group')->GroupLookup(
    Group  => 'itsm-configitem',
    UserID => 1,
);
ok( $ConfigItemGroupID, 'got group id for itsm-configitem' );

# add test general catalog item
my $GeneralCatalogItemID = $GeneralCatalogObject->ItemAdd(
    Class   => 'ITSM::ConfigItem::Class',
    Name    => $RandomClass,
    ValidID => 1,
    Comment => 'Comment',
    UserID  => 1,
);

$GeneralCatalogObject->GeneralCatalogPreferencesSet(
    ItemID => $GeneralCatalogItemID,
    Key    => 'Permission',
    Value  => [$ConfigItemGroupID],
);
$GeneralCatalogObject->GeneralCatalogPreferencesSet(
    ItemID => $GeneralCatalogItemID,
    Key    => 'VersionStringModule',
    Value  => ['Incremental'],
);

ok(
    $GeneralCatalogItemID,
    "Test general catalog item is created - $GeneralCatalogItemID ",
);

# Add config item definitions
my $ConfigItemPerlDefinition = {
    Pages => [
        {
            Name   => 'Description',    # will be reused in class name
            Layout => {
                Columns     => 1,
                ColumnWidth => '1fr'
            },
            Content => [
                {
                    Section     => 'Section1',
                    ColumnStart => 1,
                    RowStart    => 1
                }
            ],
        }
    ],
    Sections => {
        Section1 => {
            Type => 'Description',
        }
    },
};

# get ConfigItem object
my $ConfigItemObject = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');

# get list of all deployment states
my $DeplStateList = $GeneralCatalogObject->ItemList(
    Class => 'ITSM::ConfigItem::DeploymentState',
);
my %ReverseDeplStateList = reverse %{$DeplStateList};

# get list of all incident states
my $InciStateList = $GeneralCatalogObject->ItemList(
    Class => 'ITSM::Core::IncidentState',
);
my %ReverseInciStateList = reverse %{$InciStateList};

my @ConfigItemNumbers;
my $ConfigItemID;

my $YAMLObject = $Kernel::OM->Get('Kernel::System::YAML');

# add a definition to the class
my $YAMLDefinition = $YAMLObject->Dump(
    Data => $ConfigItemPerlDefinition,
);
ok( $YAMLDefinition, 'got some YAML' );

my $Result = $ConfigItemObject->DefinitionAdd(
    ClassID    => $GeneralCatalogItemID,
    Definition => $YAMLDefinition,
    UserID     => 1,
);
ok( $Result->{Success},      'DefinitionAdd() successful' );
ok( $Result->{DefinitionID}, 'got DefinitionID' );

for ( 1 .. 10 ) {

    # create ConfigItem number
    my $ConfigItemNumber = $ConfigItemObject->ConfigItemNumberCreate(
        Type    => 'Kernel::System::ITSMConfigItem::Number::AutoIncrement',
        ClassID => $GeneralCatalogItemID,
    );

    # add test ConfigItem
    $ConfigItemID = $ConfigItemObject->ConfigItemAdd(
        Number       => $ConfigItemNumber,
        Name         => 'CI' . $RandomID++,
        ClassID      => $GeneralCatalogItemID,
        DefinitionID => $Result->{DefinitionID},
        DeplStateID  => $ReverseDeplStateList{Production},
        InciStateID  => $ReverseInciStateList{Operational},
        UserID       => 1,
    );

    push @ConfigItemNumbers, $ConfigItemNumber;

    # add new versions for the last added in previous loop
    my $ConfigItemName = 'TestConfigItem' . $Helper->GetRandomID();

    COUNT:
    for my $Count ( 1 .. 50 ) {

        my $VersionID = $ConfigItemObject->VersionAdd(
            Name         => $ConfigItemName . '-' . $Count,
            DefinitionID => 1,
            DeplStateID  => $ReverseDeplStateList{Planned},
            InciStateID  => $ReverseInciStateList{Operational},
            UserID       => 1,
            ConfigItemID => $ConfigItemID,
        );

        ok(
            $VersionID,
            "Version $Count for config item $ConfigItemID is created - $ConfigItemName",
        );

        # change the date into past for the first 20 versions
        next COUNT if $Count > 10;

        my $VersionTestCreateTime = '2010-01-01 00:00:00';

        # insert new version
        my $Success = $Kernel::OM->Get('Kernel::System::DB')->Do(
            SQL => 'UPDATE configitem_version
                SET create_time = ?
                WHERE id = ?',
            Bind => [
                \$VersionTestCreateTime,
                \$VersionID,
            ],
        );
    }

    # check command with all-older-than-days-versions options (delete all versions older than one day)
    $ExitCode = $CommandObject->Execute( '--all-older-than-days-versions', 1 );

    is(
        $ExitCode,
        0,
        "Exit code: Options --all-older-than-days-versions 1",
    );

    # get the list of remaining versions of this config item
    my $VersionList = $ConfigItemObject->VersionList(
        ConfigItemID => $ConfigItemID,
    );

    # result should only be 40 versions now
    is(
        scalar @{$VersionList},
        41,
        "Number of remaining versions after running command with Options --all-older-than-days-versions 1",
    );

    # check command with all-but-keep-last-versions options (delete all versions but keep the last 30 versions)
    $ExitCode = $CommandObject->Execute( '--all-but-keep-last-versions', 30 );

    is(
        $ExitCode,
        0,
        "Exit code: Options --all-but-keep-last-versions 30",
    );

    # get the list of remaining versions of this config item
    $VersionList = $ConfigItemObject->VersionList(
        ConfigItemID => $ConfigItemID,
    );

    # result should only be 40 versions now
    is(
        scalar @{$VersionList},
        30,
        "Number of remaining versions after running command with Options --all-but-keep-last-versions 30",
    );

    # check command with all-old-versions options (delete all old versions except the last one)
    $ExitCode = $CommandObject->Execute('--all-old-versions');

    is(
        $ExitCode,
        0,
        "Exit code: Options --all-old-versions",
    );

    # get the list of remaining versions of this config item
    $VersionList = $ConfigItemObject->VersionList(
        ConfigItemID => $ConfigItemID,
    );

    # result should only be 40 versions now
    is(
        scalar @{$VersionList},
        1,
        "Number of remaining versions after running command with Options --all-old-versions",
    );
}

# check command with class options ($RandomClass class) and deployment-state 'Planned'
$ExitCode = $CommandObject->Execute( '--class', $RandomClass, '--deployment-state', 'Planned' );

is(
    $ExitCode,
    0,
    "Exit code: Options --class $RandomClass --deployment-state' Planned",
);

# check command with configitem-number options
$ExitCode = $CommandObject->Execute(
    '--configitem-number', $ConfigItemNumbers[0], '--configitem-number',
    $ConfigItemNumbers[1]
);

is(
    $ExitCode,
    0,
    "Exit code: Options --configitem-number",
);

# check command with class options ($RandomClass class)
# three config Items of ten created in test were deleted with the previous commands
# with the next command other seven will be deleted
$ExitCode = $CommandObject->Execute( '--class', $RandomClass );

is(
    $ExitCode,
    0,
    "Exit code: Option --class $RandomClass",
);

# check command with configitem-number options and not allowed additional class option
$ExitCode = $CommandObject->Execute( '--configitem-number', $ConfigItemNumbers[0], '--class', $RandomClass );

is(
    $ExitCode,
    1,
    "Exit code: Options --configitem-number --class",
);

# check command with configitem-number options and not allowed additional deployment state option
$ExitCode = $CommandObject->Execute( '--configitem-number', $ConfigItemNumbers[0], '--deployment-state', 'Planned' );

is(
    $ExitCode,
    1,
    "Exit code: Options --configitem-number --deployment-state",
);

# check command with --all, --all-old-versions, --all-but-keep-last-versions, --all-older-than-days-versions mixed together.
$ExitCode = $CommandObject->Execute(
    '--all', '--all-old-versions',             '--all-but-keep-last-versions',
    2,       '--all-older-than-days-versions', '10'
);

is(
    $ExitCode,
    1,
    "Exit code: Options --all --all-old-versions --all-but-keep-last-versions 2 --all-older-than-days-versions 10",
);

done_testing;

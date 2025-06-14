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
use Kernel::System::UnitTest::RegisterDriver;    # Set up $Kernel::OM and the test driver $Self

our $Self;

# get needed objects
my $ConfigObject         = $Kernel::OM->Get('Kernel::Config');
my $GeneralCatalogObject = $Kernel::OM->Get('Kernel::System::GeneralCatalog');
my $ConfigItemObject     = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');

# get helper object
$Kernel::OM->ObjectParamAdd(
    'Kernel::System::UnitTest::Helper' => {
        RestoreDatabase => 1,
    },
);
my $Helper = $Kernel::OM->Get('Kernel::System::UnitTest::Helper');

# define needed variable
my $RandomID = $Helper->GetRandomID();

# ------------------------------------------------------------ #
# make preparations
# ------------------------------------------------------------ #

# add the test classes
my @ConfigItemClassIDs;
my @ConfigItemClasses;
my @ConfigItemDefinitionIDs;

# generate a random name
my $FirstClassName  = 'UnitTestClass1' . $RandomID;
my $SecondClassName = 'UnitTestClass2' . $RandomID;

# set a name prefix
my $NamePrefix = 'UnitTestName' . $RandomID;

# add both unittest config item classes
my $FirstClassID = $GeneralCatalogObject->ItemAdd(
    Class   => 'ITSM::ConfigItem::Class',
    Name    => $FirstClassName,
    ValidID => 1,
    UserID  => 1,
);

# check first class id
if ( !$FirstClassID ) {

    $Self->True(
        0,
        "Can't add first config item class.",
    );
}

# set version string module
$Kernel::OM->Get('Kernel::System::GeneralCatalog')->GeneralCatalogPreferencesSet(
    ItemID => $FirstClassID,
    Key    => 'VersionStringModule',
    Value  => ['Incremental'],
);

push @ConfigItemClassIDs, $FirstClassID;
push @ConfigItemClasses,  $FirstClassName;

my $SecondClassID = $GeneralCatalogObject->ItemAdd(
    Class   => 'ITSM::ConfigItem::Class',
    Name    => $SecondClassName,
    ValidID => 1,
    UserID  => 1,
);

# set version string module
$Kernel::OM->Get('Kernel::System::GeneralCatalog')->GeneralCatalogPreferencesSet(
    ItemID => $SecondClassID,
    Key    => 'VersionStringModule',
    Value  => ['Incremental'],
);

# check second class id
if ( !$SecondClassID ) {

    $Self->True(
        0,
        "Can't add second config item class.",
    );
}

push @ConfigItemClassIDs, $SecondClassID;
push @ConfigItemClasses,  $SecondClassName;

my @ConfigItemPerlDefinitions;

$ConfigItemPerlDefinitions[0] = "
{
        Pages  => [
            {
                Name => 'Content',
                Layout => {
                    Columns => 1,
                    ColumnWidth => '1fr'
                },
                Content => [
                    {
                        Section => 'Section1',
                        ColumnStart => 1,
                        RowStart => 1
                    }
                ],
            }
        ],
        Sections => {
            Section1 => {
                Type => 'Description',
            },
        },
}";

my $YAMLObject = $Kernel::OM->Get('Kernel::System::YAML');

my @ConfigItemDefinitions;
for my $PerlDefinition (@ConfigItemPerlDefinitions) {
    my $YAMLDefinition = $YAMLObject->Dump(
        Data => eval $PerlDefinition,    ## no critic qw(BuiltinFunctions::ProhibitStringyEval)
    );
    push @ConfigItemDefinitions, $YAMLDefinition;
}

# add an empty definition to the class. the definition doesn't need any elements, as we're only
# testing the name which isn't part of the definition, but of the config item itself
my $FirstResult = $ConfigItemObject->DefinitionAdd(
    ClassID    => $FirstClassID,
    Definition => $ConfigItemDefinitions[0],
    UserID     => 1,
);
ok( $FirstResult->{DefinitionID}, 'first config item definition added' );

my $FirstDefinitionID = $FirstResult->{DefinitionID};
push @ConfigItemDefinitionIDs, $FirstResult->{DefinitionID};

my $SecondResult = $ConfigItemObject->DefinitionAdd(
    ClassID    => $SecondClassID,
    Definition => $ConfigItemDefinitions[0],
    UserID     => 1,
);
ok( $SecondResult->{DefinitionID}, 'second config item definition added' );

my $SecondDefinitionID = $SecondResult->{DefinitionID};
push @ConfigItemDefinitionIDs, $SecondDefinitionID;

# get deployment state list
my $DeplStateList = $GeneralCatalogObject->ItemList(
    Class => 'ITSM::ConfigItem::DeploymentState',
);
my %DeplStateListReverse = reverse %{$DeplStateList};

# get incident state list
my $InciStateList = $GeneralCatalogObject->ItemList(
    Class => 'ITSM::Core::IncidentState',
);
my %InciStateListReverse = reverse %{$InciStateList};

my @ConfigItemIDs;

my $FirstClassResult = $ConfigItemObject->DefinitionAdd(
    ClassID    => $FirstClassID,
    Definition => <<'DEFINITION',
---
Pages:
  - Name: Content
    Layout:
      Columns: 1
      ColumnWidth: 1fr
    Content:
      - Section: Attributes
        ColumnStart: 1
        RowStart: 1

Sections:
  Attributes:
    Type: Description
DEFINITION
    UserID => 1,
);

# fetch the definition id
my $FirstClassDefinition = $ConfigItemObject->DefinitionGet(
    ClassID => $FirstClassID,
);

# add a configitem to each class
my $FirstConfigItemID = $ConfigItemObject->ConfigItemAdd(
    ClassID      => $FirstClassID,
    Name         => $NamePrefix . 'First#001',
    DefinitionID => $FirstClassDefinition->{DefinitionID},
    DeplStateID  => $DeplStateListReverse{Production},
    InciStateID  => $InciStateListReverse{Operational},
    UserID       => 1,
);

if ( !$FirstConfigItemID ) {
    $Self->True(
        0,
        "Failed to add the first configitem",
    );
}

push @ConfigItemIDs, $FirstConfigItemID;

my $SecondClassResult = $ConfigItemObject->DefinitionAdd(
    ClassID    => $SecondClassID,
    Definition => <<'DEFINITION',
---
Pages:
  - Name: Content
    Layout:
      Columns: 1
      ColumnWidth: 1fr
    Content:
      - Section: Attributes
        ColumnStart: 1
        RowStart: 1

Sections:
  Attributes:
    Type: Description
DEFINITION
    UserID => 1,
);

# fetch the definition id
my $SecondClassDefinition = $ConfigItemObject->DefinitionGet(
    ClassID => $SecondClassID,
);

my $SecondConfigItemID = $ConfigItemObject->ConfigItemAdd(
    ClassID      => $SecondClassID,
    Name         => $NamePrefix . 'Second#001',
    DefinitionID => $SecondClassDefinition->{DefinitionID},
    DeplStateID  => $DeplStateListReverse{Production},
    InciStateID  => $InciStateListReverse{Operational},
    UserID       => 1,
);

if ( !$SecondConfigItemID ) {
    $Self->True(
        0,
        "Failed to add the second configitem",
    );
}

push @ConfigItemIDs, $SecondConfigItemID;

# create a 3rd configitem in the 2nd class
my $ThirdConfigItemID = $ConfigItemObject->ConfigItemAdd(
    ClassID      => $SecondClassID,
    Name         => $NamePrefix . 'Second#002',
    DefinitionID => $SecondDefinitionID,
    DeplStateID  => $DeplStateListReverse{Production},
    InciStateID  => $InciStateListReverse{Operational},
    UserID       => 1,
);

if ( !$ThirdConfigItemID ) {
    $Self->True(
        0,
        "Failed to add the third configitem",
    );
}

push @ConfigItemIDs, $ThirdConfigItemID;

# set a name for each configitem
my $FirstInitialVersionID = $ConfigItemObject->ConfigItemUpdate(
    ConfigItemID => $FirstConfigItemID,
    Name         => $NamePrefix . 'First#001',
    DefinitionID => $FirstClassDefinition->{DefinitionID},
    DeplStateID  => $DeplStateListReverse{Production},
    InciStateID  => $InciStateListReverse{Operational},
    UserID       => 1,
);

if ( !$FirstInitialVersionID ) {
    $Self->True(
        0,
        "Failed to add the initial version for the first configitem",
    );
}

my $SecondInitialVersionID = $ConfigItemObject->ConfigItemUpdate(
    ConfigItemID => $SecondConfigItemID,
    Name         => $NamePrefix . 'Second#001',
    DefinitionID => $SecondClassDefinition->{DefinitionID},
    DeplStateID  => $DeplStateListReverse{Production},
    InciStateID  => $InciStateListReverse{Operational},
    UserID       => 1,
);

if ( !$SecondInitialVersionID ) {
    $Self->True(
        0,
        "Failed to add the initial version for the second configitem",
    );
}

my $ThirdInitialVersionID = $ConfigItemObject->ConfigItemUpdate(
    ConfigItemID => $ThirdConfigItemID,
    Name         => $NamePrefix . 'Second#002',
    DefinitionID => $SecondClassDefinition->{DefinitionID},
    DeplStateID  => $DeplStateListReverse{Production},
    InciStateID  => $InciStateListReverse{Operational},
    UserID       => 1,
);

if ( !$ThirdInitialVersionID ) {
    $Self->True(
        0,
        "Failed to add the initial version for the third configitem",
    );
}

# ------------------------------------------------------------ #
# run the actual tests
# ------------------------------------------------------------ #

# read the original setting for the setting EnableUniquenessCheck
my $OrigEnableSetting = $ConfigObject->Get('UniqueCIName::EnableUniquenessCheck');

# enable the uniqueness check
$ConfigObject->Set(
    Key   => 'UniqueCIName::EnableUniquenessCheck',
    Value => 1,
);

# read the original setting for the scope of the uniqueness check
my $OrigScope = $ConfigObject->Get('UniqueCIName::UniquenessCheckScope');

# make sure, the scope for the uniqueness check is set to 'global'
$ConfigObject->Set(
    Key   => 'UniqueCIName::UniquenessCheckScope',
    Value => 'global',
);

my $RenameSuccess;

# try to give the 1st configitem the same name as the 2nd one
$RenameSuccess = $ConfigItemObject->ConfigItemUpdate(
    ConfigItemID => $FirstConfigItemID,
    ClassID      => $FirstClassID,
    Name         => $NamePrefix . 'Second#001',
    DefinitionID => $FirstClassDefinition->{DefinitionID},
    DeplStateID  => $DeplStateListReverse{Production},
    InciStateID  => $InciStateListReverse{Operational},
    UserID       => 1,
);

$Self->False(
    $RenameSuccess,
    "Scope => global: Renaming First#001 to already existing Second#001 successfully prevented"
);

# try to give the 2nd configitem the same name as the 3rd one
$RenameSuccess = $ConfigItemObject->ConfigItemUpdate(
    ConfigItemID => $SecondConfigItemID,
    ClassID      => $SecondClassID,
    Name         => $NamePrefix . 'Second#002',
    DefinitionID => $FirstClassDefinition->{DefinitionID},
    DeplStateID  => $DeplStateListReverse{Production},
    InciStateID  => $InciStateListReverse{Operational},
    UserID       => 1,
);

$Self->False(
    $RenameSuccess,
    "Scope => global: Renaming Second#001 to already existing Second#002 successfully prevented"
);

# set the scope for the uniqueness check to 'class'
$ConfigObject->Set(
    Key   => 'UniqueCIName::UniquenessCheckScope',
    Value => 'class',
);

# try to rename First#001 again to Second#001 which should work now, due to the different class
$RenameSuccess = $ConfigItemObject->ConfigItemUpdate(
    ConfigItemID => $FirstConfigItemID,
    ClassID      => $FirstClassID,
    Name         => $NamePrefix . 'Second#001',
    DefinitionID => $FirstClassDefinition->{DefinitionID},
    DeplStateID  => $DeplStateListReverse{Production},
    InciStateID  => $InciStateListReverse{Operational},
    UserID       => 1,
);

$Self->True(
    $RenameSuccess,
    "Scope => class: Renaming First#001 to already existing Second#001 succeeded"
);

# trying now to create a duplicate name within a class
$RenameSuccess = $ConfigItemObject->ConfigItemUpdate(
    ConfigItemID => $SecondConfigItemID,
    ClassID      => $SecondClassID,
    Name         => $NamePrefix . 'Second#002',
    DefinitionID => $SecondClassDefinition->{DefinitionID},
    DeplStateID  => $DeplStateListReverse{Production},
    InciStateID  => $InciStateListReverse{Operational},
    UserID       => 1,
);

$Self->False(
    $RenameSuccess,
    "Scope => class: Renaming Second#001 to already existing Second#002 successfully prevented"
);

# reset the enabled setting for the uniqueness check to its original value
$ConfigObject->Set(
    Key   => 'UniqueCIName::EnableUniquenessCheck',
    Value => $OrigEnableSetting,
);

# reset the scope for the uniqueness check to its original value
$ConfigObject->Set(
    Key   => 'UniqueCIName::UniquenessCheckScope',
    Value => $OrigScope,
);

done_testing;

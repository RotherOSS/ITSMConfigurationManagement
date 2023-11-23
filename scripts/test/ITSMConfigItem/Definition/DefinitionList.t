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

# CPAN modules
use Test2::V0;

# OTOBO modules
use Kernel::System::UnitTest::RegisterOM;    # Set up $Kernel::OM

$Kernel::OM->ObjectParamAdd(
    'Kernel::System::UnitTest::Helper' => {
        RestoreDatabase => 1,
    },
);
my $Helper = $Kernel::OM->Get('Kernel::System::UnitTest::Helper');

my $TestUserLogin = $Helper->TestUserCreate(
    Groups => [ 'admin', 'users' ],
);
my $UserID = $Kernel::OM->Get('Kernel::System::User')->UserLookup( UserLogin => $TestUserLogin );

my $RandomID = $Helper->GetRandomID();

my @ConfigItemYAMLDefinitions = <<'END_YAML';
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

# second item is a variant of the first item
push @ConfigItemYAMLDefinitions, ( $ConfigItemYAMLDefinitions[0] =~ s/CI_1_/CI_2_/rg );

my $YAMLObject = $Kernel::OM->Get('Kernel::System::YAML');

my $ClassID = $Kernel::OM->Get('Kernel::System::GeneralCatalog')->ItemAdd(
    Class   => 'ITSM::ConfigItem::Class',
    Name    => $RandomID,
    ValidID => 1,
    UserID  => $UserID,
);
ok( $ClassID, "Class added to GeneralCatalog" );

my $ConfigItemObject = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');

my $Result1 = $ConfigItemObject->DefinitionAdd(
    ClassID    => $ClassID,
    UserID     => $UserID,
    CreateBy   => $UserID,
    Definition => $ConfigItemYAMLDefinitions[0]
);
ok( $Result1->{Success}, "DefinitionAdd() 1 successful" );
my $DefinitionID1 = $Result1->{DefinitionID};
ok( $DefinitionID1, "DefinitionAdd() 1 got definition ID " );

my $Result2 = $ConfigItemObject->DefinitionAdd(
    ClassID    => $ClassID,
    UserID     => $UserID,
    CreateBy   => $UserID,
    Definition => $ConfigItemYAMLDefinitions[1]
);
ok( $Result1->{Success}, "DefinitionAdd() 2 successful" );
my $DefinitionID2 = $Result2->{DefinitionID};
ok( $DefinitionID1, "DefinitionAdd() 2 got definition ID " );

my @Tests = (
    {
        Name    => 'Empty',
        Config  => {},
        Success => 0,
    },
    {
        Name   => 'By ClassID',
        Config => {
            ClassID => $ClassID,
        },
        Success         => 1,
        ExpectedResults => [
            {
                CreateBy     => $UserID,
                Definition   => $ConfigItemYAMLDefinitions[0],
                Version      => 1,
                DefinitionID => $DefinitionID1,
            },
            {
                CreateBy     => $UserID,
                Definition   => $ConfigItemYAMLDefinitions[1],
                Version      => 2,
                DefinitionID => $DefinitionID2,
            },
        ],
    },
);

TEST:
for my $Test (@Tests) {

    # DefinitionRef is not included in the list
    my $DefinitionList = $ConfigItemObject->DefinitionList(
        $Test->{Config}->%*
    );

    if ( !$Test->{Success} ) {
        ok(
            !$DefinitionList,
            "$Test->{Name} DefinitionList() - failure expected",
        );

        next TEST;
    }

    for my $Definition ( $DefinitionList->@* ) {
        delete $Definition->{CreateTime};
    }

    is(
        $DefinitionList,
        $Test->{ExpectedResults},
        "$Test->{Name} DefinitionList() - Definition"
    );
}

done_testing;

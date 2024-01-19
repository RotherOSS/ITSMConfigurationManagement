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

my $RandomID = $Helper->GetRandomID;

my $ClassID = $Kernel::OM->Get('Kernel::System::GeneralCatalog')->ItemAdd(
    Class   => 'ITSM::ConfigItem::Class',
    Name    => $RandomID,
    ValidID => 1,
    UserID  => $UserID,
);
ok( $ClassID, "Class added to GeneralCatalog" );

my @Tests = (
    {
        Name    => 'Empty',
        Config  => {},
        Success => 0,
    },
    {
        Name   => 'Missing ClasssID',
        Config => {
            Definition => << 'EOF',
---
- Pages:
  - Content:
    - ColumnStart: 1
      RowStart: 1
      Section: Section1
    - ColumnStart: 2
      RowStart: 1
      Section: Section2
    Layout:
      ColumnWidth: 1fr 1fr
      Columns: 2
    Name: Content
EOF
            UserID => $UserID,
        },
        Success => 0,
    },
    {
        Name   => 'Missing Definition',
        Config => {
            ClassID => $ClassID,
            UserID  => $UserID,
        },
        Success => 0,
    },
    {
        Name   => 'Missing UserID',
        Config => {
            ClassID    => $ClassID,
            Definition => << 'EOF',
---
- Pages:
  - Content:
    - ColumnStart: 1
      RowStart: 1
      Section: Section1
    - ColumnStart: 2
      RowStart: 1
      Section: Section2
    Layout:
      ColumnWidth: 1fr 1fr
      Columns: 2
    Name: Content
EOF
        },
        Success => 0,
    },
    {
        Name   => 'Wrong Definition (Legacy Perl)',
        Config => {
            ClassID    => $ClassID,
            Definition => << 'EOF',
[
{
        Pages  => [
            {
                Name => 'Content',
                Layout => {
                    Columns => 2,
                    ColumnWidth => '1fr 1fr'
                },
                Content => [
                    {
                        Section => 'Section1',
                        ColumnStart => 1,
                        RowStart => 1
                    },
                    {
                        Section => 'Section2',
                        ColumnStart => 2,
                        RowStart => 1
                    }
                ],
            }
        ]
}
];
EOF
            UserID => $UserID,
        },
        Success => 0,
    },
    {
        Name   => 'Wrong Definition (Invalid YAML)',
        Config => {
            ClassID    => $ClassID,
            Definition => << 'EOF',
---
- Pages:
  - Content:
    ColumnStart: 1
      RowStart 1
      Section: Section1
    ColumnStart 2
      RowStart: 1
      Section: Section2
    Layout:
      ColumnWidth: 1fr 1fr
      Columns: 2
    Name: Content
EOF
            UserID => $UserID,
        },
        Success => 0,
    },
    {
        Name   => 'Correct YAML',
        Config => {
            ClassID    => $ClassID,
            Definition => << 'EOF',
---
Pages:
  - Name: Page1
    Interfaces: []
    Layout:
      Columns: 3
      ColumnWidth: 1fr
    Content:
      - Section: Section1
        ColumnStart: 1
        RowStart: 1
  - Name: Page2
    Layout:
      Columns: 3
      ColumnWidth: 1fr
    Content:
      - Section: Section2
        ColumnStart: 1
        RowStart: 2

Sections:
  Section1:
    Content:
       - Header: "This is section 1"
  Section2:
    Content:
       - Header: "This is section 2"
EOF
            UserID => $UserID,
        },
        Success => 1,
    },

);

my $ConfigItemObject = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');

TEST:
for my $Test (@Tests) {

    my $Result = $ConfigItemObject->DefinitionAdd(
        $Test->{Config}->%*
    );
    my $DefinitionID = $Result->{DefinitionID};

    if ( !$Test->{Success} ) {
        ok(
            !$DefinitionID,
            "$Test->{Name} DefinitionAdd() - failure expected",
        );

        next TEST;
    }

    ok(
        ( $DefinitionID // 0 ) > 0,
        "$Test->{Name} DefinitionAdd() - DefinitionID"
    );

}

done_testing;

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

my @ConfigItemPerlDefinitions;

# define the first test definition (basic definition without DynamicFields)
$ConfigItemPerlDefinitions[0] = " [
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
]";

# define the second test definition (definition with DynamicFields)
$ConfigItemPerlDefinitions[1] = " [
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
                Content => [
                    {
                        DF => 'Test1'
                    },
                    {
                        DF => 'Test2'
                    }
                ]
            }
        },
}
]";

my $YAMLObject = $Kernel::OM->Get('Kernel::System::YAML');

my @ConfigItemDefinitions;
for my $PerlDefinition (@ConfigItemPerlDefinitions) {
    my $YAMLDefinition = $YAMLObject->Dump(
        Data => eval $PerlDefinition,    ## no critic qw(BuiltinFunctions::ProhibitStringyEval)
    );
    push @ConfigItemDefinitions, $YAMLDefinition;
}

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
    Definition => $ConfigItemDefinitions[0]
);
my $DefinitionID1 = $Result1->{DefinitionID};
ok( $DefinitionID1, "DefinitionAdd() 1" );

my $Result2 = $ConfigItemObject->DefinitionAdd(
    ClassID    => $ClassID,
    UserID     => $UserID,
    CreateBy   => $UserID,
    Definition => $ConfigItemDefinitions[1]
);
my $DefinitionID2 = $Result2->{DefinitionID};
ok( $DefinitionID2, "DefinitionAdd() 2" );

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
                CreateBy   => $UserID,
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
                Version      => 1,
                DefinitionID => $DefinitionID1,
            },
            {
                CreateBy   => $UserID,
                Definition => << 'EOF',
---
- Pages:
  - Content:
    - ColumnStart: 1
      RowStart: 1
      Section: Section1
    Layout:
      ColumnWidth: 1fr
      Columns: 1
    Name: Content
  Sections:
    Section1:
      Content:
      - DF: Test1
      - DF: Test2
EOF
                Version      => 2,
                DefinitionID => $DefinitionID2,
            },
        ],
    },
);

TEST:
for my $Test (@Tests) {

    my $DefinitionList = $ConfigItemObject->DefinitionList( %{ $Test->{Config} } );

    if ( !$Test->{Success} ) {
        ok(
            !$DefinitionList,
            "$Test->{Name} DefinitionList() - failure expected",
        );
        next TEST;
    }

    for my $Definition ( @{$DefinitionList} ) {
        delete $Definition->{CreateTime};
    }

    is(
        $DefinitionList,
        $Test->{ExpectedResults},
        "$Test->{Name} DefinitionList() - Definition"
    );
}

done_testing;

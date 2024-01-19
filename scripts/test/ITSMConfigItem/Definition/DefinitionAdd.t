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

use strict;
use warnings;
use utf8;

use vars qw($Self);

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

my $ClassID = $Kernel::OM->Get('Kernel::System::GeneralCatalog')->ItemAdd(
    Class   => 'ITSM::ConfigItem::Class',
    Name    => $RandomID,
    ValidID => 1,
    UserID  => $UserID,
);
$Self->True(
    $ClassID,
    "Class added to GeneralCatalog",
);

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
- Key: Vendor
  Name: Vendor
  Searchable: 1
  Input:
    Type: Text
    Size: 50
    MaxLength: 50
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
- Key: Vendor
  Name: Vendor
  Searchable: 1
  Input:
    Type: Text
    Size: 50
    MaxLength: 50
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
        Key        => 'Vendor',
        Name       => 'Vendor',
        Searchable => 1,
        Input      => {
            Type      => 'Text',
            Size      => 50,
            MaxLength => 50
        },
    },
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
Test
 Invalid
- Key: Vendor
  Name: Vendor
  Searchable: 1
  Input:
    Type: Text
    Size: 50
    MaxLength: 50
EOF
            UserID => $UserID,
        },
        Success => 0,
    },
    {
        Name   => 'Correct ASCII',
        Config => {
            ClassID    => $ClassID,
            Definition => << 'EOF',
---
- Key: Vendor
  Name: Vendor
  Searchable: 1
  Input:
    Type: Text
    Size: 50
    MaxLength: 50
EOF
            UserID => $UserID,
        },
        Success => 1,
    },

);

my $ConfigItemObject = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');

TEST:
for my $Test (@Tests) {

    my $DefinitionID = $ConfigItemObject->DefinitionAdd( %{ $Test->{Config} } );

    if ( !$Test->{Success} ) {
        $Self->False(
            $DefinitionID,
            "$Test->{Name} DefinitionAdd() - With false",
        );
        next TEST;
    }

    $Self->IsNot(
        $DefinitionID // 0,
        0,
        "$Test->{Name} DefinitionAdd() - DefinitionID"
    );

}

1;

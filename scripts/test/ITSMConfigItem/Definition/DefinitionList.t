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

use strict;
use warnings;
use utf8;

our $Self;

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

my $ConfigItemObject = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');
my $DefinitionID1    = $ConfigItemObject->DefinitionAdd(
    ClassID    => $ClassID,
    UserID     => $UserID,
    CreateBy   => $UserID,
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
);
$Self->True(
    $DefinitionID1,
    "DefinitionAdd()",
);
my $DefinitionID2 = $ConfigItemObject->DefinitionAdd(
    ClassID    => $ClassID,
    UserID     => $UserID,
    CreateBy   => $UserID,
    Definition => << 'EOF',
---
- Key: Vendor
  Name: Vendor
  Searchable: 0
  Input:
    Type: Text
    Size: 50
    MaxLength: 50
EOF
);

$Self->True(
    $DefinitionID2,
    "DefinitionAdd()",
);

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
- Key: Vendor
  Name: Vendor
  Searchable: 1
  Input:
    Type: Text
    Size: 50
    MaxLength: 50
EOF
                Version      => 1,
                DefinitionID => $DefinitionID1,
            },
            {
                CreateBy   => $UserID,
                Definition => << 'EOF',
---
- Key: Vendor
  Name: Vendor
  Searchable: 0
  Input:
    Type: Text
    Size: 50
    MaxLength: 50
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
        $Self->False(
            $DefinitionList,
            "$Test->{Name} DefinitionList() - With false",
        );
        next TEST;
    }

    for my $Definition ( @{$DefinitionList} ) {
        delete $Definition->{CreateTime};
    }

    $Self->IsDeeply(
        $DefinitionList,
        $Test->{ExpectedResults},
        "$Test->{Name} DefinitionList() - Definition"
    );
}

1;

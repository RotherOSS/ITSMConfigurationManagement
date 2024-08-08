# --
# OTOBO is a web-based ticketing system for service organisations.
# --
# Copyright (C) 2019-2024 Rother OSS GmbH, https://otobo.io/
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

my $DynamicFieldObject = $Kernel::OM->Get('Kernel::System::DynamicField');
my $ConfigItemObject   = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');

# add dynamic fields for testing
my $FieldOrder = 1;
my %DynamicFieldShortName2ID;
for my $ShortName (qw(DF1 DF2 DF3 DF4)) {

    # add a new item
    my $DFName         = join '-', $ShortName, $RandomID;
    my $DynamicFieldID = $DynamicFieldObject->DynamicFieldAdd(
        InternalField => 0,
        Name          => $DFName,
        Label         => "$DFName ☔",
        FieldOrder    => $FieldOrder++,
        FieldType     => 'Text',
        ObjectType    => 'ITSMConfigItem',
        Config        => {
            DefaultValue => "default value for $DFName ☔",
        },
        Reorder => 1,
        ValidID => 1,
        UserID  => 1,
    );
    ok( $DynamicFieldID, "created dynamic field $DFName" );
    $DynamicFieldShortName2ID{$ShortName} = $DynamicFieldID;
}

# add Role
{
    # declare the role in the general catalog
    my $RoleID = $Kernel::OM->Get('Kernel::System::GeneralCatalog')->ItemAdd(
        Class   => 'ITSM::ConfigItem::Role',
        Name    => "Role_$RandomID",
        ValidID => 1,
        UserID  => $UserID,
    );
    ok( $RoleID, "Role added to GeneralCatalog" );

    my $YAMLDefinition = <<"END_YAML";
---
Sections:
  NoDynamicField:
    Content:
       - Header: "No dynamic field"
  OneDynamicField:
    Content:
       - Header: "No dynamic field"
       - DF: DF1-$RandomID
  TwoDynamicFields:
    Content:
       - Header: "No dynamic field"
       - DF: DF1-$RandomID
       - DF: DF2-$RandomID
  ThreeDynamicFields:
    Content:
       - Header: "No dynamic field"
       - DF: DF1-$RandomID
       - DF: DF2-$RandomID
       - DF: DF3-$RandomID
  OnlyDF4:
    Content:
       - Header: "only the dynamic field DF4, not referenced in any page"
       - DF: DF4-$RandomID
END_YAML
    my $Result = $ConfigItemObject->RoleDefinitionAdd(
        RoleID     => $RoleID,
        Definition => $YAMLDefinition,
        UserID     => $UserID,
    );
    ok( $Result->{Success}, "Role_$RandomID successfully added" );
}

# TODO: refer to Role in Definition

my $ClassID = $Kernel::OM->Get('Kernel::System::GeneralCatalog')->ItemAdd(
    Class   => 'ITSM::ConfigItem::Class',
    Name    => "Class_$RandomID",
    ValidID => 1,
    UserID  => $UserID,
);
ok( $ClassID, "Class added to GeneralCatalog" );

my %DefinitionTemplate = (
    ClassID    => $ClassID,
    Class      => "Class_$RandomID",
    CreateBy   => $UserID,
    Version    => 1,
    Definition => << "END_YAML",
---
Pages:
  - Name: Page1
    Interfaces: []
    Layout:
      Columns: 3
      ColumnWidth: 1fr
    Content:
      - Section: EmptySection1
        ColumnStart: 1
        RowStart: 1
  - Name: Page2
    Layout:
      Columns: 3
      ColumnWidth: 1fr
    Content:
      - Section: EmptySection2
        ColumnStart: 1
        RowStart: 2
  - Name: Page3
    Layout:
      Columns: 3
      ColumnWidth: 1fr
    Content:
      - Section: TestRole::NoDynamicField
        ColumnStart: 1
        RowStart: 2
      - Section: TestRole::OneDynamicField
        ColumnStart: 1
        RowStart: 2
      - Section: TestRole::ThreeDynamicFields
        ColumnStart: 1
        RowStart: 2

Sections:
  EmptySection1:
    Content:
       - Header: "This is the empty section 1"
  EmptySection2:
    Content:
       - Header: "This is the empty section 2"
Roles:
  TestRole:
    Name: "Role_$RandomID"
    Version: 1
END_YAML
);

my $Result = $ConfigItemObject->DefinitionAdd(
    %DefinitionTemplate,
    UserID => $UserID,
);
ok( $Result->{Success}, "DefinitionAdd() was successful" );
my $DefinitionID = $Result->{DefinitionID};
ok( $DefinitionID, "DefinitionAdd() returned a definition ID" );

my $ExpectedDefinitionRef = {
    Pages => [
        {
            Content => [
                {
                    ColumnStart => 1,
                    RowStart    => 1,
                    Section     => "EmptySection1"
                },
            ],
            Interfaces => [],
            Layout     => {
                Columns     => 3,
                ColumnWidth => "1fr"
            },
            Name => "Page1",
        },
        {
            Content => [
                {
                    ColumnStart => 1,
                    RowStart    => 2,
                    Section     => "EmptySection2"
                },
            ],
            Layout => {
                Columns     => 3,
                ColumnWidth => "1fr"
            },
            Name => "Page2",
        },
        {
            Content => [
                {
                    ColumnStart => 1,
                    RowStart    => 2,
                    Section     => "TestRole::NoDynamicField"
                },
                {
                    ColumnStart => 1,
                    RowStart    => 2,
                    Section     => "TestRole::OneDynamicField"
                },
                {
                    ColumnStart => 1,
                    RowStart    => 2,
                    Section     => "TestRole::ThreeDynamicFields",
                },
            ],
            Layout => {
                Columns     => 3,
                ColumnWidth => "1fr"
            },
            Name => "Page3",
        },
    ],
    Roles => {
        TestRole => {
            Name    => "Role_$RandomID",
            Version => 1
        },
    },
    Sections => {
        "EmptySection1"             => { Content => [ { Header => "This is the empty section 1" } ] },
        "EmptySection2"             => { Content => [ { Header => "This is the empty section 2" } ] },
        "TestRole::NoDynamicField"  => { Content => [ { Header => "No dynamic field" } ] },
        "TestRole::OneDynamicField" => {
            Content => [
                { Header => "No dynamic field" },
                { DF     => "DF1-$RandomID" },
            ],
        },
        "TestRole::OnlyDF4" => {
            Content => [
                { Header => "only the dynamic field DF4, not referenced in any page" },
                { DF     => "DF4-$RandomID" },
            ],
        },
        "TestRole::ThreeDynamicFields" => {
            Content => [
                { Header => "No dynamic field" },
                { DF     => "DF1-$RandomID" },
                { DF     => "DF2-$RandomID" },
                { DF     => "DF3-$RandomID" },
            ],
        },
        "TestRole::TwoDynamicFields" => {
            Content => [
                { Header => "No dynamic field" },
                { DF     => "DF1-$RandomID" },
                { DF     => "DF2-$RandomID" },
            ],
        },
    },
};
my $ExpectedDynamicFieldRef = {
    "DF1-$RandomID" => {
        CIClass => "Class_$RandomID",
        Config  => {
            DefaultValue => "default value for DF1-$RandomID \x{2614}",
        },
        FieldType  => "Text",
        ID         => $DynamicFieldShortName2ID{DF1},
        Label      => "DF1-$RandomID \x{2614}",
        Name       => "DF1-$RandomID",
        ObjectType => "ITSMConfigItem",
    },
    "DF2-$RandomID" => {
        CIClass => "Class_$RandomID",
        Config  => {
            DefaultValue => "default value for DF2-$RandomID \x{2614}",
        },
        FieldType  => "Text",
        ID         => $DynamicFieldShortName2ID{DF2},
        Label      => "DF2-$RandomID \x{2614}",
        Name       => "DF2-$RandomID",
        ObjectType => "ITSMConfigItem",
    },
    "DF3-$RandomID" => {
        CIClass => "Class_$RandomID",
        Config  => {
            DefaultValue => "default value for DF3-$RandomID \x{2614}",
        },
        FieldType  => "Text",
        ID         => $DynamicFieldShortName2ID{DF3},
        Label      => "DF3-$RandomID \x{2614}",
        Name       => "DF3-$RandomID",
        ObjectType => "ITSMConfigItem",
    },
    "DF4-$RandomID" => {
        CIClass => "Class_$RandomID",
        Config  => {
            DefaultValue => "default value for DF4-$RandomID \x{2614}",
        },
        FieldType  => "Text",
        ID         => $DynamicFieldShortName2ID{DF4},
        Label      => "DF4-$RandomID \x{2614}",
        Name       => "DF4-$RandomID",
        ObjectType => "ITSMConfigItem",
    },
};

my @Tests = (
    {
        Name   => 'By DefinitionID',
        Config => {
            DefinitionID => $DefinitionID,
        },
        Success         => 1,
        ExpectedResults => {
            %DefinitionTemplate,
            DefinitionID    => $DefinitionID,
            DefinitionRef   => $ExpectedDefinitionRef,
            DynamicFieldRef => $ExpectedDynamicFieldRef,
        },
    },
    {
        Name   => 'By ClassID',
        Config => {
            ClassID => $ClassID,
        },
        Success         => 1,
        ExpectedResults => {
            %DefinitionTemplate,
            DefinitionID    => $DefinitionID,
            DefinitionRef   => $ExpectedDefinitionRef,
            DynamicFieldRef => $ExpectedDynamicFieldRef,
        },
    },
);

TEST:
for my $Test (@Tests) {

    my $Definition = $ConfigItemObject->DefinitionGet(
        $Test->{Config}->%*
    );

    if ( !$Test->{Success} ) {
        ok( !$Definition, "$Test->{Name} DefinitionGet() - failure expected" );

        next TEST;
    }

    delete $Definition->{CreateTime};

    is(
        $Definition,
        $Test->{ExpectedResults},
        "$Test->{Name} DefinitionGet() - Definition"
    );
}

done_testing;

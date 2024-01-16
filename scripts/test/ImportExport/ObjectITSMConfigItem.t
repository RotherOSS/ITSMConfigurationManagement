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

# Sanity check whether ImportExport is available.
# This should succeed since ImportExport has been integrated into OTOBO core
{
    # get ImportExport module directory
    my $ImportExportModule = $Kernel::OM->Get('Kernel::Config')->Get('Home') . '/Kernel/System/ImportExport.pm';
    ok( -f $ImportExportModule, 'ImportExport.pm exists' );
}

# get needed objects
my $CustomerUserObject   = $Kernel::OM->Get('Kernel::System::CustomerUser');
my $DynamicFieldObject   = $Kernel::OM->Get('Kernel::System::DynamicField');
my $GeneralCatalogObject = $Kernel::OM->Get('Kernel::System::GeneralCatalog');
my $ImportExportObject   = $Kernel::OM->Get('Kernel::System::ImportExport');
my %FormatBackendObject  = (
    CSV  => $Kernel::OM->Get('Kernel::System::ImportExport::FormatBackend::CSV'),
    JSON => $Kernel::OM->Get('Kernel::System::ImportExport::FormatBackend::JSON'),
);
my $ObjectBackendObject = $Kernel::OM->Get('Kernel::System::ImportExport::ObjectBackend::ITSMConfigItem');
my $ConfigItemObject    = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');
my $UserObject          = $Kernel::OM->Get('Kernel::System::User');
my $ConfigObject        = $Kernel::OM->Get('Kernel::Config');

# get helper object
$Kernel::OM->ObjectParamAdd(
    'Kernel::System::UnitTest::Helper' => {
        RestoreDatabase => 1,
    },
);
my $Helper = $Kernel::OM->Get('Kernel::System::UnitTest::Helper');

# define needed variable
my $RandomID = $Helper->GetRandomID;

# ------------------------------------------------------------ #
# make preparations
# ------------------------------------------------------------ #

# add some ITSMConfigItem test templates for later checks
# mostly with dummy formats, but use 5 and 6 for CSV and JSON tests.
my @TemplateIDs;
{
    my %Format = (
        5 => 'CSV',
        6 => 'JSON',
    );

    for my $i ( 0 .. 29 ) {
        my $TemplateID = $ImportExportObject->TemplateAdd(
            Object  => 'ITSMConfigItem',
            Format  => ( $Format{$i} || 'UnitTest' . $i . $RandomID ),
            Name    => 'UnitTest' . $i . $RandomID,
            ValidID => 1,
            UserID  => 1,
        );

        push @TemplateIDs, $TemplateID;
    }
}

# ObjectList test 1 (check CSV item)
{
    my $ObjectList = $ImportExportObject->ObjectList;
    ok(
        $ObjectList && ref $ObjectList eq 'HASH' && $ObjectList->{ITSMConfigItem},
        "ObjectList() - ITSMConfigItem exists",
    );
}

# ObjectAttributesGet test 1 (check attribute hash)
{
    my $ObjectAttributesGet1 = $ImportExportObject->ObjectAttributesGet(
        TemplateID => $TemplateIDs[0],
        UserID     => 1,
    );

    # check object attribute reference
    ok(
        $ObjectAttributesGet1 && ref $ObjectAttributesGet1 eq 'ARRAY',
        "ObjectAttributesGet() - check array reference",
    );

    # get class list
    my $ClassList = $GeneralCatalogObject->ItemList(
        Class => 'ITSM::ConfigItem::Class',
    );

    # define the reference hash
    my $ObjectAttributesGet1Reference = [
        {
            Key   => 'ClassID',
            Name  => 'Class',
            Input => {
                Type         => 'Selection',
                Data         => $ClassList,
                Required     => 1,
                Translation  => 0,
                PossibleNone => 1,
            },
        },
        {
            Key   => 'CountMax',
            Name  => 'Maximum number of one element',
            Input => {
                Type         => 'Text',
                ValueDefault => '10',
                Required     => 1,
                Regex        => qr{ \A \d+ \z }xms,
                Translation  => 0,
                Size         => 5,
                MaxLength    => 5,
                DataType     => 'IntegerBiggerThanZero',
            },
        },
        {
            'Input' => {
                'Type' => 'Checkbox'
            },
            'Name' => 'Empty fields indicate that the current values are kept',
            'Key'  => 'EmptyFieldsLeaveTheOldValues',
        }
    ];

    is(
        $ObjectAttributesGet1,
        $ObjectAttributesGet1Reference,
        "ObjectAttributesGet() - attributes of the row are identical",
    );
}

# ObjectAttributesGet test 2 (check with non existing template)
{
    my $ObjectAttributesGet2 = $ImportExportObject->ObjectAttributesGet(
        TemplateID => $TemplateIDs[-1] + 1,
        UserID     => 1,
    );
    is(
        $ObjectAttributesGet2,
        undef,
        "ObjectAttributesGet() - expected to fail",
    );
}

# MappingObjectAttributesGet test 1 (check attribute hash)
{
    my $MappingObjectAttributesGet1 = $ImportExportObject->MappingObjectAttributesGet(
        TemplateID => $TemplateIDs[0],
        UserID     => 1,
    );

    # check mapping object attribute reference
    ok(
        $MappingObjectAttributesGet1 && ref $MappingObjectAttributesGet1 eq 'ARRAY',
        "MappingObjectAttributesGet() - check array reference",
    );
}

# MappingObjectAttributesGet test 2 (check with non existing template)
{
    my $MappingObjectAttributesGet2 = $ImportExportObject->MappingObjectAttributesGet(
        TemplateID => $TemplateIDs[-1] + 1,
        UserID     => 1,
    );

    is(
        $MappingObjectAttributesGet2,
        undef,
        "MappingObjectAttributesGet() - expected to fail",
    );
}

# add a general catalog test list
my $ConfigItemGroupID = $Kernel::OM->Get('Kernel::System::Group')->GroupLookup(
    Group  => 'itsm-configitem',
    UserID => 1,
);
ok( $ConfigItemGroupID, 'got group id for itsm-configitem' );

# don't care about valid emails
$ConfigObject->Set(
    Key   => 'CheckEmailAddresses',
    Value => 0,
);

# create customer users which will be referenced in CustomerUser dynamic fields
# with double quotes for testing CSV
# with high order letters
# with random id, useful during development when RestoreDatabase is deactivated
my %CustomerUsers = (

    # for CustomerCIO
    CIO => 'chief information officer "🗄"' . $RandomID,

    # fruit sales for CustomerSalesTeam
    apple => 'apple sales "🍎"' . $RandomID,
    onion => 'onion sales "🧅"' . $RandomID,

    # tress sales for CustomerSalesTeam
    tanabate => 'tanabate tree sales "🎋"' . $RandomID,
    palm     => 'palm tree sales "🌴"' . $RandomID,
);
for my $Key ( sort keys %CustomerUsers ) {
    my $Login           = $CustomerUsers{$Key};
    my $CustomerUserAdd = $CustomerUserObject->CustomerUserAdd(
        Source         => 'CustomerUser',
        UserFirstname  => "$Key first name $RandomID",
        UserLastname   => "$Key last name $RandomID",
        UserCustomerID => 'TestCustomerCompany1' . $RandomID,
        UserLogin      => $Login,
        UserEmail      => $Key . $RandomID . '@example.com',
        ValidID        => 1,
        UserID         => 1,
    );
    is( $CustomerUserAdd, $Login, "customer user '$Login' added" );
}

# create agents that will be referenced in Agend dynamic fields
my %Agent2UserID;
{
    my %LastName = (

        # for ZZZSetOfAgents
        DeskAgent     => 'INFORMATION DESK PERSON 💁',
        LotusAgent    => 'PERSON IN LOTUS POSITION 🧘',
        ClimbingAgent => 'PERSON CLIMBING 🧗',
        FrowningAgent => 'PERSON FROWNING 🙍',
    );

    for my $Key ( sort keys %LastName ) {
        my $UserID = $UserObject->UserAdd(
            UserFirstname => $Key,
            UserLastname  => $LastName{$Key},
            UserLogin     => $Key . $RandomID,
            UserPw        => 'some-pass',
            UserEmail     => $Key . $RandomID . 'email@example.com',
            ValidID       => 1,
            ChangeUserID  => 1,
        );
        ok( $UserID, "user $Key added" );
        $Agent2UserID{$Key} = $UserID;
    }
}

# Add generic catalog items for testing the GeneralCatalog dynamic field class.
# TODO: actually test GeneralCatalog dynamic fields
my $GeneralCatalogClass = 'UnitTest' . $RandomID;
diag "GeneralCatalogClass: '$GeneralCatalogClass'";

for my $Name (qw(Test1 Test2 Test3 Test4)) {

    # add a new item
    my $ItemID = $GeneralCatalogObject->ItemAdd(
        Class   => $GeneralCatalogClass,
        Name    => $Name,
        Comment => "added by " . __FILE__,
        ValidID => 1,
        UserID  => 1,
    );
    ok( $ItemID, "$Name added to the general catalog" );

    # Set permission.
    $GeneralCatalogObject->GeneralCatalogPreferencesSet(
        ItemID => $ItemID,
        Key    => 'Permission',
        Value  => $ConfigItemGroupID,
    );
}

# Add dynamic fields for testing. These dynamic fields will be referenced
# by name in dynamic field definitions.
my $TestIDSuffix = "UnitTest$RandomID";
diag "TestIDSuffix: '$TestIDSuffix'";
{
    my $Order = 20000;

    # not the no underscores are allowed in dynamic field names
    my %DynamicFieldDefinitions = (
        CustomerCIO => {
            FieldType => 'CustomerUser',
            Config    => {
                MultiValue => 0,
                Tooltip    => 'Tooltip for customer chief information officer',
            },
        },
        CustomerSalesTeam => {
            FieldType => 'CustomerUser',
            Config    => {
                MultiValue => 1,
                Tooltip    => 'Tooltip for customer sales team',
            },
        },

        # Agent1 and Agent2 will be included in the Set AgentSet
        Agent1 => {
            FieldType => 'Agent',
            Config    => {
                PossibleNone => 1,
                Multiselect  => 0,
                MultiValue   => 0,
                GroupFilter  => [],
                Tooltip      => 'Tooltip for Agent1',
            },
        },
        Agent2 => {
            FieldType => 'Agent',
            Config    => {
                PossibleNone => 1,
                Multiselect  => 0,
                MultiValue   => 0,
                GroupFilter  => [],
                Tooltip      => 'Tooltip for Agent2',
            },
        },
        ZZZSetOfAgents => {
            FieldType => 'Set',
            Config    => {
                MultiValue => 1,
                Include    => [
                    { DF => 'Agent1' . $TestIDSuffix },
                    { DF => 'Agent2' . $TestIDSuffix },
                ],
                Tooltip => 'Tooltip for ZZZSetOfAgents',
            },
        },
    );

    for my $Name ( sort keys %DynamicFieldDefinitions ) {
        my $DFName         = $Name . $TestIDSuffix;
        my $DynamicFieldID = $DynamicFieldObject->DynamicFieldAdd(
            Name       => $DFName,
            Label      => $DFName,
            FieldOrder => $Order++,
            FieldType  => $DynamicFieldDefinitions{$Name}->{FieldType},
            ObjectType => 'ITSMConfigItem',
            Config     => $DynamicFieldDefinitions{$Name}->{Config},
            ValidID    => 1,
            UserID     => 1,
        );
        ok( $DynamicFieldID, "created dynamic field $DFName" );
    }
}

# Add config item definitions
my ( @ConfigItemClassIDs, @ConfigItemDefinitionIDs );
{
    my @ConfigItemPerlDefinitions;

    # config item with two CustomerUser fields
    push @ConfigItemPerlDefinitions, {
        Pages => [
            {
                Name   => 'Content',
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
                Content => [
                    {
                        DF => 'CustomerCIO' . $TestIDSuffix,
                    },
                    {
                        DF => 'CustomerSalesTeam' . $TestIDSuffix,
                    },
                ]
            }
        },
    };

    # config item with a Set dynamic field
    push @ConfigItemPerlDefinitions, {
        Pages => [
            {
                Name   => 'Content',
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
                Content => [
                    {
                        DF => 'CustomerCIO' . $TestIDSuffix,
                    },
                    {
                        DF => 'ZZZSetOfAgents' . $TestIDSuffix,
                    },
                ]
            }
        },
    };

=for never

$ConfigItemPerlDefinitions[0] = " [
    {
        Key        => 'Customer1',
        Name       => 'Customer 1',
        Searchable => 1,
        Input      => {
            Type => 'Customer',
        },
    },
    {
        Key        => 'Date1',
        Name       => 'Date 1',
        Searchable => 1,
        Input      => {
            Type => 'Date',
        },
    },
    {
        Key        => 'DateTime1',
        Name       => 'Date Time 1',
        Searchable => 1,
        Input      => {
            Type => 'DateTime',
        },
    },
    {
        Key   => 'Dummy1',
        Name  => 'Dummy 1',
        Input => {
            Type => 'Dummy',
        },
    },
    {
        Key        => 'GeneralCatalog1',
        Name       => 'GeneralCatalog 1',
        Searchable => 1,
        Input      => {
            Type  => 'GeneralCatalog',
            Class => '$GeneralCatalogClass',
        },
    },
    {
        Key        => 'Integer1',
        Name       => 'Integer 1',
        Searchable => 1,
        Input      => {
            Type => 'Integer',
        },
    },
    {
        Key        => 'Text1',
        Name       => 'Text 1',
        Searchable => 1,
        Input      => {
            Type      => 'Text',
            Size      => 50,
            MaxLength => 50,
        },
    },
    {
        Key        => 'TextArea1',
        Name       => 'TextArea 1',
        Searchable => 1,
        Input      => {
            Type => 'TextArea',
        },
    },
] ";

# define the second test definition (sub data types)
$ConfigItemPerlDefinitions[1] = " [
    {
        Key        => 'Main1',
        Name       => 'Main 1',
        Searchable => 1,
        Input      => {
            Type      => 'Text',
            Size      => 50,
            MaxLength => 50,
        },
        CountMax => 10,
        Sub => [
            {
                Key        => 'Main1Sub1',
                Name       => 'Main 1 Sub 1',
                Searchable => 1,
                Input      => {
                    Type      => 'Text',
                    Size      => 50,
                    MaxLength => 50,
                },
                CountMax => 10,
                Sub => [
                    {
                        Key        => 'Main1Sub1SubSub1',
                        Name       => 'Main 1 Sub 1 SubSub 1',
                        Searchable => 1,
                        Input      => {
                            Type      => 'Text',
                            Size      => 50,
                            MaxLength => 50,
                        },
                        CountMax => 10,
                    },
                    {
                        Key        => 'Main1Sub1SubSub2',
                        Name       => 'Main 1 Sub 1 SubSub 2',
                        Searchable => 1,
                        Input      => {
                            Type => 'TextArea',
                        },
                        CountMax => 10,
                    },
                ],
            },
            {
                Key        => 'Main1Sub2',
                Name       => 'Main 1 Sub 2',
                Searchable => 1,
                Input      => {
                    Type => 'TextArea',
                },
                CountMax => 10,
            },
        ],
    },
    {
        Key        => 'Main2',
        Name       => 'Main 2',
        Searchable => 1,
        Input      => {
            Type => 'TextArea',
        },
        CountMax => 10,
        Sub => [
            {
                Key        => 'Main2Sub1',
                Name       => 'Main 2 Sub 1',
                Searchable => 1,
                Input      => {
                    Type      => 'Text',
                    Size      => 50,
                    MaxLength => 50,
                },
                CountMax => 10,
            },
            {
                Key        => 'Main2Sub2',
                Name       => 'Main 2 Sub 2',
                Searchable => 1,
                Input      => {
                    Type => 'TextArea',
                },
                CountMax => 10,
            },
        ],
    },
] ";

# Define the third test definition with required attribute 'Type'.
$ConfigItemPerlDefinitions[2] = " [
    {
        'Key' => 'Type',
        'Input' => {
            'Class' => '$GeneralCatalogClass',
            'Required' => 1,
            'Translation' => 1,
            'Type' => 'GeneralCatalog'
        },
        'Searchable' => 1,
        'CountMin' => 1,
        'CountDefault' => 1,
        'CountMax' => 3,
        'Name' => 'Type',
    },
] ";

=cut

    my $YAMLObject = $Kernel::OM->Get('Kernel::System::YAML');

    my @ConfigItemDefinitions;
    for my $PerlDefinition (@ConfigItemPerlDefinitions) {
        my $YAMLDefinition = $YAMLObject->Dump(
            Data => $PerlDefinition,
        );
        push @ConfigItemDefinitions, $YAMLDefinition;
    }

    # add the test config item classes
    my $i = 0;
    for my $Definition (@ConfigItemDefinitions) {

        # generate a random name
        my $ClassName = join '_', 'UnitTest', ++$i, $TestIDSuffix;

        # add an unittest config item class
        my $ClassID = $GeneralCatalogObject->ItemAdd(
            Class   => 'ITSM::ConfigItem::Class',
            Name    => $ClassName,
            ValidID => 1,
            UserID  => 1,
        );
        ok( $ClassID, "added general catalog item for config item class $ClassName" );

        # Set permission.
        $GeneralCatalogObject->GeneralCatalogPreferencesSet(
            ItemID => $ClassID,
            Key    => 'Permission',
            Value  => $ConfigItemGroupID,
        );

        push @ConfigItemClassIDs, $ClassID;

        # add a definition to the class
        my $Result = $ConfigItemObject->DefinitionAdd(
            ClassID    => $ClassID,
            Definition => $Definition,
            UserID     => 1,
        );
        ok( $Result->{Success},      'DefinitionAdd() successful' );
        ok( $Result->{DefinitionID}, 'got DefinitionID' );
        push @ConfigItemDefinitionIDs, $Result->{DefinitionID};
    }
}

# Create some random numbers. The numbers must be sorted because
# ExportDataGet() sorts per default by the config item number in descending order.
my @ConfigItemNumbers =
    sort
    map
    { $Helper->GetRandomNumber }
    ( 1 .. 10 );

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

# get general catalog test list
my $GeneralCatalogList = $GeneralCatalogObject->ItemList(
    Class => $GeneralCatalogClass,
);
ref_ok( $GeneralCatalogList, 'HASH', 'general catalog list is a hashref' );
my %GeneralCatalogListReverse = reverse %{$GeneralCatalogList};

# define the test config items
my @ConfigItemSetups;

my $ConfigItemCnt = 0;

# two config items with CustomerCI0 and CustomerSalesTeam
push @ConfigItemSetups,
    {
        Description   => 'config item with two CustomerUser dynamic fields',
        ConfigItemAdd => {
            Number                                        => $ConfigItemNumbers[$ConfigItemCnt],
            Name                                          => "UnitTest - ConfigItem @{[ ++$ConfigItemCnt ]} Version 1",
            ClassID                                       => $ConfigItemClassIDs[0],
            DefinitionID                                  => $ConfigItemDefinitionIDs[0],
            DeplStateID                                   => $DeplStateListReverse{Production},
            InciStateID                                   => $InciStateListReverse{Operational},
            UserID                                        => 1,
            "DynamicField_CustomerCIO$TestIDSuffix"       => $CustomerUsers{CIO},
            "DynamicField_CustomerSalesTeam$TestIDSuffix" => [
                $CustomerUsers{palm},
                $CustomerUsers{tanabate},
            ],
        },
    },
    {
        Description   => 'config item with two CustomerUser dynamic fields',
        ConfigItemAdd => {
            Number                                        => $ConfigItemNumbers[$ConfigItemCnt],
            Name                                          => "UnitTest - ConfigItem @{[ ++$ConfigItemCnt ]} Version 1",
            ClassID                                       => $ConfigItemClassIDs[0],
            DefinitionID                                  => $ConfigItemDefinitionIDs[0],
            DeplStateID                                   => $DeplStateListReverse{Production},
            InciStateID                                   => $InciStateListReverse{Operational},
            UserID                                        => 1,
            "DynamicField_CustomerCIO$TestIDSuffix"       => $CustomerUsers{CIO},
            "DynamicField_CustomerSalesTeam$TestIDSuffix" => [
                $CustomerUsers{onion},
                $CustomerUsers{apple},
            ],
        },
    };

# two config items with CustomerCI0 and ZZZSetOfAgents
push @ConfigItemSetups,
    {
        Description   => 'config item with CustomerCIO and ZZZSetOfAgents',
        ConfigItemAdd => {
            Number                                     => $ConfigItemNumbers[$ConfigItemCnt],
            Name                                       => "UnitTest - ConfigItem @{[ ++$ConfigItemCnt ]} Version 1",
            ClassID                                    => $ConfigItemClassIDs[1],
            DefinitionID                               => $ConfigItemDefinitionIDs[1],
            DeplStateID                                => $DeplStateListReverse{Production},
            InciStateID                                => $InciStateListReverse{Operational},
            UserID                                     => 1,
            "DynamicField_CustomerCIO$TestIDSuffix"    => $CustomerUsers{CIO},
            "DynamicField_ZZZSetOfAgents$TestIDSuffix" => [
                [ [ $Agent2UserID{LotusAgent} ],    [ $Agent2UserID{DeskAgent} ] ],
                [ [ $Agent2UserID{ClimbingAgent} ], [ $Agent2UserID{DeskAgent} ] ],
                [ [ $Agent2UserID{FrowningAgent} ], [ $Agent2UserID{DeskAgent} ] ],
            ],
        },
    },
    {
        Description   => 'config item with CustomerCIO and ZZZSetOfAgents',
        ConfigItemAdd => {
            Number                                     => $ConfigItemNumbers[$ConfigItemCnt],
            Name                                       => "UnitTest - ConfigItem @{[ ++$ConfigItemCnt ]} Version 1",
            ClassID                                    => $ConfigItemClassIDs[1],
            DefinitionID                               => $ConfigItemDefinitionIDs[1],
            DeplStateID                                => $DeplStateListReverse{Production},
            InciStateID                                => $InciStateListReverse{Operational},
            UserID                                     => 1,
            "DynamicField_CustomerCIO$TestIDSuffix"    => $CustomerUsers{CIO},
            "DynamicField_ZZZSetOfAgents$TestIDSuffix" => [
                [ [ $Agent2UserID{DeskAgent} ],     [ $Agent2UserID{LotusAgent} ] ],
                [ [ $Agent2UserID{ClimbingAgent} ], [ $Agent2UserID{FrowningAgent} ] ],
            ],
        },
    };

=for never

 10.1 test cases

 (

    # config item for all provided data types
    {
        ConfigItem => {
            Number  => $ConfigItemNumbers[0],
            ClassID => $ConfigItemClassIDs[0],
            UserID  => 1,
        },
        Versions => [
            {
                Name         => 'UnitTest - ConfigItem 1 Version 1',
                DefinitionID => $ConfigItemDefinitionIDs[0],
                DeplStateID  => $DeplStateListReverse{Production},
                InciStateID  => $InciStateListReverse{Operational},
                XMLData      => [
                    undef,
                    {
                        Version => [
                            undef,
                            {
                                Customer1 => [
                                    undef,
                                    {
                                        Content => 'UnitTest',
                                    },
                                ],
                                Date1 => [
                                    undef,
                                    {
                                        Content => '2008-02-01',
                                    },
                                ],
                                DateTime1 => [
                                    undef,
                                    {
                                        Content => '2008-02-01 03:59',
                                    },
                                ],
                                GeneralCatalog1 => [
                                    undef,
                                    {
                                        Content => $GeneralCatalogListReverse{Test1},
                                    },
                                ],
                                Integer1 => [
                                    undef,
                                    {
                                        Content => '1',
                                    },
                                ],
                                Text1 => [
                                    undef,
                                    {
                                        Content => 'Test Text Test',
                                    },
                                ],
                                TextArea1 => [
                                    undef,
                                    {
                                        Content => "Test\nText Array\nTest",
                                    },
                                ],
                            },
                        ],
                    },
                ],
                UserID => 1,
            },
        ],
    },

    # a second config item for all provided data types
    # (duplicate name of first version for search checks)
    {
        ConfigItem => {
            Number  => $ConfigItemNumbers[1],
            ClassID => $ConfigItemClassIDs[0],
            UserID  => 1,
        },
        Versions => [
            {
                Name         => 'UnitTest - ConfigItem 1 Version 1',    # duplicate name for tests
                DefinitionID => $ConfigItemDefinitionIDs[0],
                DeplStateID  => $DeplStateListReverse{Production},
                InciStateID  => $InciStateListReverse{Operational},
                XMLData      => [
                    undef,
                    {
                        Version => [
                            undef,
                            {
                                Customer1 => [
                                    undef,
                                    {
                                        Content => 'UnitTest',
                                    },
                                ],
                                Date1 => [
                                    undef,
                                    {
                                        Content => '2008-02-01',
                                    },
                                ],
                                DateTime1 => [
                                    undef,
                                    {
                                        Content => '2008-02-01 03:59',
                                    },
                                ],
                                GeneralCatalog1 => [
                                    undef,
                                    {
                                        Content => $GeneralCatalogListReverse{Test1},
                                    },
                                ],
                                Integer1 => [
                                    undef,
                                    {
                                        Content => '1',
                                    },
                                ],
                                Text1 => [
                                    undef,
                                    {
                                        Content => 'Test Text Test',
                                    },
                                ],
                                TextArea1 => [
                                    undef,
                                    {
                                        Content => "Test\nText Array\nTest",
                                    },
                                ],
                            },
                        ],
                    },
                ],
                UserID => 1,
            },
            {
                Name         => 'UnitTest - ConfigItem 2 Version 2',
                DefinitionID => $ConfigItemDefinitionIDs[0],
                DeplStateID  => $DeplStateListReverse{Production},
                InciStateID  => $InciStateListReverse{Operational},
                XMLData      => [
                    undef,
                    {
                        Version => [
                            undef,
                            {
                                Customer1 => [
                                    undef,
                                    {
                                        Content => 'UnitTest2',
                                    },
                                ],
                                Date1 => [
                                    undef,
                                    {
                                        Content => '2008-02-02',
                                    },
                                ],
                                DateTime1 => [
                                    undef,
                                    {
                                        Content => '2008-02-02 03:59',
                                    },
                                ],
                                GeneralCatalog1 => [
                                    undef,
                                    {
                                        Content => $GeneralCatalogListReverse{Test2},
                                    },
                                ],
                                Integer1 => [
                                    undef,
                                    {
                                        Content => '2',
                                    },
                                ],
                                Text1 => [
                                    undef,
                                    {
                                        Content => 'Test Text Test2',
                                    },
                                ],
                                TextArea1 => [
                                    undef,
                                    {
                                        Content => "Test2\nText Array\nTest 2",
                                    },
                                ],
                            },
                        ],
                    },
                ],
                UserID => 1,
            },
        ],
    },

    # config item for sub element tests
    {
        ConfigItem => {
            Number  => $ConfigItemNumbers[2],
            ClassID => $ConfigItemClassIDs[1],
            UserID  => 1,
        },
        Versions => [
            {
                Name         => 'UnitTest - ConfigItem 3 Version 1',
                DefinitionID => $ConfigItemDefinitionIDs[1],
                DeplStateID  => $DeplStateListReverse{Production},
                InciStateID  => $InciStateListReverse{Operational},
                XMLData      => [
                    undef,
                    {
                        Version => [
                            undef,
                            {
                                Main1 => [
                                    undef,
                                    {
                                        Content   => 'Main1 (1)',
                                        Main1Sub1 => [
                                            undef,
                                            {
                                                Content          => 'Main1 (1) Sub1 (1)',
                                                Main1Sub1SubSub1 => [
                                                    undef,
                                                    {
                                                        Content => 'Main1 (1) Sub1 (1) SubSub1 (1)',
                                                    },
                                                    {
                                                        Content => 'Main1 (1) Sub1 (1) SubSub1 (2)',
                                                    },
                                                    {
                                                        Content => 'Main1 (1) Sub1 (1) SubSub1 (3)',
                                                    },
                                                ],
                                                Main1Sub1SubSub2 => [
                                                    undef,
                                                    {
                                                        Content => 'Main1 (1) Sub1 (1) SubSub2 (1)',
                                                    },
                                                ],
                                            },
                                            {
                                                Content          => 'Main1 (1) Sub1 (2)',
                                                Main1Sub1SubSub1 => [
                                                    undef,
                                                    {
                                                        Content => 'Main1 (1) Sub1 (2) SubSub1 (1)',
                                                    },
                                                ],
                                                Main1Sub1SubSub2 => [
                                                    undef,
                                                    {
                                                        Content => 'Main1 (1) Sub1 (2) SubSub2 (1)',
                                                    },
                                                    {
                                                        Content => 'Main1 (1) Sub1 (2) SubSub2 (2)',
                                                    },
                                                ],
                                            },
                                        ],
                                        Main1Sub2 => [
                                            undef,
                                            {
                                                Content => 'Main1 (1) Sub2 (1)',
                                            },
                                            {
                                                Content => 'Main1 (1) Sub2 (2)',
                                            },
                                        ],
                                    },
                                ],
                                Main2 => [
                                    undef,
                                    {
                                        Content   => 'Main2 (1)',
                                        Main2Sub1 => [
                                            undef,
                                            {
                                                Content => 'Main2 (1) Sub1 (1)',
                                            },
                                        ],
                                        Main2Sub2 => [
                                            undef,
                                            {
                                                'Content' => 'Main2 (1) Sub2 (1)',
                                            },
                                            {
                                                'Content' => 'Main2 (1) Sub2 (2)',
                                            },
                                        ],
                                    },
                                ],
                            },
                        ],
                    },
                ],
                UserID => 1,
            },
        ],
    },

    # config item for sub element tests
    {
        ConfigItem => {
            Number  => $ConfigItemNumbers[3],
            ClassID => $ConfigItemClassIDs[1],
            UserID  => 1,
        },
        Versions => [
            {
                Name         => 'UnitTest - ConfigItem 4 Version 1',
                DefinitionID => $ConfigItemDefinitionIDs[1],
                DeplStateID  => $DeplStateListReverse{Production},
                InciStateID  => $InciStateListReverse{Operational},
                XMLData      => [
                    undef,
                    {
                        Version => [
                            undef,
                            {
                                Main1 => [
                                    undef,
                                    {
                                        Content   => '',
                                        Main1Sub1 => [
                                            undef,
                                            {
                                                Content          => '',
                                                Main1Sub1SubSub1 => [
                                                    undef,
                                                    {
                                                        Content => '',
                                                    },
                                                ],
                                                Main1Sub1SubSub2 => [
                                                    undef,
                                                    {
                                                        Content => '',
                                                    },
                                                ],
                                            },
                                        ],
                                        Main1Sub2 => [
                                            undef,
                                            {
                                                Content => '',
                                            },
                                        ],
                                    },
                                ],
                                Main2 => [
                                    undef,
                                    {
                                        Content   => '',
                                        Main2Sub1 => [
                                            undef,
                                            {
                                                Content => '',
                                            },
                                        ],
                                        Main2Sub2 => [
                                            undef,
                                            {
                                                Content => '',
                                            },
                                        ],
                                    },
                                ],
                            },
                        ],
                    },
                ],
                UserID => 1,
            },
        ],
    },

    # config item for special character tests
    {
        ConfigItem => {
            Number  => $ConfigItemNumbers[4],
            ClassID => $ConfigItemClassIDs[1],
            UserID  => 1,
        },
        Versions => [
            {
                Name         => 'UnitTest - ConfigItem 5 Version 1',
                DefinitionID => $ConfigItemDefinitionIDs[1],
                DeplStateID  => $DeplStateListReverse{Production},
                InciStateID  => $InciStateListReverse{Operational},
                XMLData      => [
                    undef,
                    {
                        Version => [
                            undef,
                            {
                                Main1 => [
                                    undef,
                                    {
                                        Content   => '"";;::..--__##',
                                        Main1Sub1 => [
                                            undef,
                                            {
                                                Content          => 'Test;:_°^!"§$%&/()=?´`*+Test',
                                                Main1Sub1SubSub1 => [
                                                    undef,
                                                    {
                                                        Content => '><@~\'}{[]\\',
                                                    },
                                                ],
                                                Main1Sub1SubSub2 => [
                                                    undef,
                                                    {
                                                        Content => '><@~\'}{[]\\',
                                                    },
                                                ],
                                            },
                                        ],
                                        Main1Sub2 => [
                                            undef,
                                            {
                                                Content => 'Test;:_°^!"§$%&/()=?´`*+Test',
                                            },
                                        ],
                                    },
                                ],
                                Main2 => [
                                    undef,
                                    {
                                        Content   => '"";;::..--__##',
                                        Main2Sub1 => [
                                            undef,
                                            {
                                                Content => 'Test Test',
                                            },
                                        ],
                                        Main2Sub2 => [
                                            undef,
                                            {
                                                Content => "Test\nTest\tTest",
                                            },
                                        ],
                                    },
                                ],
                            },
                        ],
                    },
                ],
                UserID => 1,
            },
        ],
    },

    # config item for UTF-8 tests
    {
        ConfigItem => {
            Number  => $ConfigItemNumbers[5],
            ClassID => $ConfigItemClassIDs[1],
            UserID  => 1,
        },
        Versions => [
            {
                Name         => 'UnitTest - ConfigItem 6 Version 1',
                DefinitionID => $ConfigItemDefinitionIDs[1],
                DeplStateID  => $DeplStateListReverse{Production},
                InciStateID  => $InciStateListReverse{Operational},
                XMLData      => [
                    undef,
                    {
                        Version => [
                            undef,
                            {
                                Main1 => [
                                    undef,
                                    {
                                        Content   => 'ↂ ⅻ ⅛',
                                        Main1Sub1 => [
                                            undef,
                                            {
                                                Content          => '☄ ↮ ↹ →',
                                                Main1Sub1SubSub1 => [
                                                    undef,
                                                    {
                                                        Content => '₤ ₡ ₩ ₯ ₵',
                                                    },
                                                ],
                                                Main1Sub1SubSub2 => [
                                                    undef,
                                                    {
                                                        Content => '♊ ♈ ♉ ♊ ♋ ♍ ♑',
                                                    },
                                                ],
                                            },
                                        ],
                                        Main1Sub2 => [
                                            undef,
                                            {
                                                Content => '✈ ❤ ☮',
                                            },
                                        ],
                                    },
                                ],
                                Main2 => [
                                    undef,
                                    {
                                        Content   => 'Պ Մ Հ',
                                        Main2Sub1 => [
                                            undef,
                                            {
                                                Content => '® ©',
                                            },
                                        ],
                                        Main2Sub2 => [
                                            undef,
                                            {
                                                Content => 'か げ を',
                                            },
                                        ],
                                    },
                                ],
                            },
                        ],
                    },
                ],
                UserID => 1,
            },
        ],
    },

=cut

# add the test config items
my @ConfigItemIDs;
for my $Setup (@ConfigItemSetups) {

    # add a config item
    diag $Setup->{Description};
    my $ConfigItemID = $ConfigItemObject->ConfigItemAdd(
        $Setup->{ConfigItemAdd}->%*,
    );
    ok( $ConfigItemID, 'config item added' );

    push @ConfigItemIDs, $ConfigItemID;

    # add the versions
    for my $ConfigItemUpdate ( ( $Setup->{ConfigItemUpdate} // [] )->@* ) {

        # add updates
        my $VersionID = $ConfigItemObject->ConfigItemUpdate(
            $ConfigItemUpdate->%*,
            ConfigItemID => $ConfigItemID,
        );
        ok( $VersionID, 'config item version added' );
    }
}

# declare ExportData tests
my @ExportDataTests = (
    {
        Name             => q{ImportDataGet doesn't contains all data (check required attributes)},
        SourceExportData => {
            ExportDataGet => {
                UserID => 1,
            },
        },
    },

    {
        Name             => q{ImportDataGet doesn't contains all data (check required attributes)},
        SourceExportData => {
            ExportDataGet => {
                TemplateID => $TemplateIDs[1],
            },
        },
    },

    {
        Name             => q{no existing template id is given (check return false)},
        SourceExportData => {
            ExportDataGet => {
                TemplateID => $TemplateIDs[-1] + 1,
                UserID     => 1,
            },
        },
    },

    {
        Name             => q{no class id is given (check return false)},
        SourceExportData => {
            ExportDataGet => {
                TemplateID => $TemplateIDs[2],
                UserID     => 1,
            },
        },
    },

    {
        Name             => q{invalid class id is given (check return false)},
        SourceExportData => {
            ObjectData => {
                ClassID => $ConfigItemClassIDs[-1] + 1,
            },
            ExportDataGet => {
                TemplateID => $TemplateIDs[2],
                UserID     => 1,
            },
        },
    },

    {
        Name             => q{mapping list is empty (check return false)},
        SourceExportData => {
            ObjectData => {
                ClassID => $ConfigItemClassIDs[0],
            },
            ExportDataGet => {
                TemplateID => $TemplateIDs[3],
                UserID     => 1,
            },
        },
    },

    {
        Name             => q{all required values are given (number search check)},
        SourceExportData => {
            ObjectData => {
                ClassID => $ConfigItemClassIDs[0],
            },
            MappingObjectData => [
                {
                    Key => 'Number',
                },
            ],
            SearchData => {
                Number => $ConfigItemNumbers[0],
            },
            ExportDataGet => {
                TemplateID => $TemplateIDs[5],
                UserID     => 1,
            },
        },
        ReferenceExportData => [
            [ $ConfigItemNumbers[0] ],
        ],
    },

    {
        Name             => q{all required values are given (name search check)},
        SourceExportData => {
            ObjectData => {
                ClassID => $ConfigItemClassIDs[0],
            },
            MappingObjectData => [
                {
                    Key => 'Number',
                },
            ],
            SearchData => {
                Name => 'UnitTest - ConfigItem 1 Version 1',
            },
            ExportDataGet => {
                TemplateID => $TemplateIDs[5],
                UserID     => 1,
            },
        },
        ReferenceExportData => [
            [ $ConfigItemNumbers[0] ],
        ],
    },

    {
        Name             => q{all required values are given (case insensitive name search check)},
        SourceExportData => {
            ObjectData => {
                ClassID => $ConfigItemClassIDs[0],
            },
            MappingObjectData => [
                {
                    Key => 'Number',
                },
            ],
            SearchData => {
                Name => 'unittest - configitem 1 version 1',
            },
            ExportDataGet => {
                TemplateID => $TemplateIDs[5],
                UserID     => 1,
            },
        },
        ReferenceExportData => [
            [ $ConfigItemNumbers[0] ],
        ],
    },

    {
        Name             => q{all required values are given (name and number search check)},
        SourceExportData => {
            ObjectData => {
                ClassID => $ConfigItemClassIDs[0],
            },
            MappingObjectData => [
                {
                    Key => 'Number',
                },
            ],
            SearchData => {
                Number => $ConfigItemNumbers[0],
                Name   => 'UnitTest - ConfigItem 1 Version 1',
            },
            ExportDataGet => {
                TemplateID => $TemplateIDs[5],
                UserID     => 1,
            },
        },
        ReferenceExportData => [
            [ $ConfigItemNumbers[0] ],
        ],
    },

    # CSV exports

    {
        Name             => q{Export Name, Number, CustomerCIO, and CustomerSalesTeam as CSV},
        SourceExportData => {
            ObjectData => {
                ClassID => $ConfigItemClassIDs[0],
            },
            MappingObjectData => [
                {
                    Key => 'Name',
                },
                {
                    Key => 'Number',
                },

                # CustomerCIO is a singlevalue field. Thus no index is passed.
                {
                    Key => "CustomerCIO${TestIDSuffix}",
                },

                # CustomerSalesTeam is a multivalue field.
                # Two cases are covered here:
                # - get the value at a specific index, that is the first and the second element
                # - get the complete list
                {
                    Key => "CustomerSalesTeam${TestIDSuffix}::1",
                },
                {
                    Key => "CustomerSalesTeam${TestIDSuffix}::2",
                },
                {
                    Key => "CustomerSalesTeam${TestIDSuffix}",
                },
            ],
            SearchData => {

                # Empty hash must be specified, as otherwise the previously set up SearchData prevails
            },
            ExportDataGet => {
                TemplateID => $TemplateIDs[5],
                UserID     => 1,
            },
            ExportDataSave => {
                TemplateID => $TemplateIDs[5],    # usually same as for ExportDataGet
                Format     => 'CSV',
                FormatData => {
                    ColumnSeparator => 'Semicolon',
                    Charset         => 'UTF-8',
                },
            },
        },

        # The expected rows need to be sorted by config item number in descending order.
        # There is no way to specify the sort order in ExportDataGet().
        ReferenceExportData => [
            [
                'UnitTest - ConfigItem 2 Version 1',
                $ConfigItemNumbers[1],
                qq{chief information officer "🗄"$RandomID},
                qq{onion sales "🧅"$RandomID},
                qq{apple sales "🍎"$RandomID},
                qq{["onion sales \\"🧅\\"$RandomID","apple sales \\"🍎\\"$RandomID"]},
            ],
            [
                'UnitTest - ConfigItem 1 Version 1',
                $ConfigItemNumbers[0],
                qq{chief information officer "🗄"$RandomID},
                qq{palm tree sales "🌴"$RandomID},
                qq{tanabate tree sales "🎋"$RandomID},
                qq{["palm tree sales \\"🌴\\"$RandomID","tanabate tree sales \\"🎋\\"$RandomID"]},
            ],
        ],
        ReferenceExportContent => [
            join(
                ';',
                qq{"UnitTest - ConfigItem 2 Version 1"},
                qq{"$ConfigItemNumbers[1]"},
                qq{"chief information officer ""🗄""$RandomID"},    # not JSON because single value
                qq{"onion sales ""🧅""$RandomID"},                  # not JSON because explicit index
                qq{"apple sales ""🍎""$RandomID"},                  # not JSON because explicit index
                qq{"[""onion sales \\""🧅\\""$RandomID"",""apple sales \\""🍎\\""$RandomID""]"}
            ),
            join(
                ';',
                qq{"UnitTest - ConfigItem 1 Version 1"},
                qq{"$ConfigItemNumbers[0]"},
                qq{"chief information officer ""🗄""$RandomID"},
                qq{"palm tree sales ""🌴""$RandomID"},
                qq{"tanabate tree sales ""🎋""$RandomID"},
                qq{"[""palm tree sales \\""🌴\\""$RandomID"",""tanabate tree sales \\""🎋\\""$RandomID""]"}
            ),
        ],
    },

    {
        Name             => q{Export Number, CustomerCIO, and ZZZSetOfAgents as CSV},
        SourceExportData => {
            ObjectData => {
                ClassID => $ConfigItemClassIDs[1],
            },
            MappingObjectData => [
                {
                    Key => 'Number',
                },

                # CustomerCIO is a singlevalue field. Thus no index is passed.
                {
                    Key => "CustomerCIO${TestIDSuffix}",
                },

                # ZZZSetOfAgents is a multivalue field.
                # Two cases are covered here:
                # - get the value at a specific index, that is second element
                # - get the complete list
                {
                    Key => "ZZZSetOfAgents${TestIDSuffix}::2",
                },
                {
                    Key => "ZZZSetOfAgents${TestIDSuffix}",
                },
            ],
            SearchData => {

                # Empty hash must be specified, as otherwise the previously set up SearchData prevails
            },
            ExportDataGet => {
                TemplateID => $TemplateIDs[5],
                UserID     => 1,
            },
            ExportDataSave => {
                TemplateID => $TemplateIDs[5],    # usually same as for ExportDataGet
                Format     => 'CSV',
                FormatData => {
                    ColumnSeparator => 'Semicolon',
                    Charset         => 'UTF-8',
                },
            },
        },

        # The expected rows need to be sorted by config item number in descending order.
        # There is no way to specify the sort order in ExportDataGet().
        ReferenceExportData => [
            [
                $ConfigItemNumbers[3],
                qq{chief information officer "🗄"$RandomID},
                qq{[[$Agent2UserID{ClimbingAgent}],[$Agent2UserID{FrowningAgent}]]},
                qq{[[[$Agent2UserID{DeskAgent}],[$Agent2UserID{LotusAgent}]],[[$Agent2UserID{ClimbingAgent}],[$Agent2UserID{FrowningAgent}]]]},
            ],
            [
                $ConfigItemNumbers[2],
                qq{chief information officer "🗄"$RandomID},
                qq{[[$Agent2UserID{ClimbingAgent}],[$Agent2UserID{DeskAgent}]]},
                qq{[[[$Agent2UserID{LotusAgent}],[$Agent2UserID{DeskAgent}]],[[$Agent2UserID{ClimbingAgent}],[$Agent2UserID{DeskAgent}]],[[$Agent2UserID{FrowningAgent}],[$Agent2UserID{DeskAgent}]]]},
            ],
        ],
        ReferenceExportContent => [
            join(
                ';',
                qq{"$ConfigItemNumbers[3]"},
                qq{"chief information officer ""🗄""$RandomID"},    # not JSON because single value
                qq{"[[$Agent2UserID{ClimbingAgent}],[$Agent2UserID{FrowningAgent}]]"},
                qq{"[[[$Agent2UserID{DeskAgent}],[$Agent2UserID{LotusAgent}]],[[$Agent2UserID{ClimbingAgent}],[$Agent2UserID{FrowningAgent}]]]"},
            ),
            join(
                ';',
                qq{"$ConfigItemNumbers[2]"},
                qq{"chief information officer ""🗄""$RandomID"},
                qq{"[[$Agent2UserID{ClimbingAgent}],[$Agent2UserID{DeskAgent}]]"},
                qq{"[[[$Agent2UserID{LotusAgent}],[$Agent2UserID{DeskAgent}]],[[$Agent2UserID{ClimbingAgent}],[$Agent2UserID{DeskAgent}]],[[$Agent2UserID{FrowningAgent}],[$Agent2UserID{DeskAgent}]]]"},
            ),
        ],
    },

    # JSON exports

    {
        Name             => q{Export Name, Number, CustomerCIO, and CustomerSalesTeam as JSON},
        SourceExportData => {
            ObjectData => {
                ClassID => $ConfigItemClassIDs[0],
            },
            MappingObjectData => [
                {
                    Key => 'Name',
                },
                {
                    Key => 'Number',
                },

                # CustomerCIO is a singlevalue field. Thus no index is passed.
                {
                    Key => "CustomerCIO${TestIDSuffix}",
                },

                # CustomerSalesTeam is a multivalue field.
                # Two cases are covered here:
                # - get the value at a specific index, that is the first and the second element
                # - get the complete list
                {
                    Key => "CustomerSalesTeam${TestIDSuffix}::1",
                },
                {
                    Key => "CustomerSalesTeam${TestIDSuffix}::2",
                },
                {
                    Key => "CustomerSalesTeam${TestIDSuffix}",
                },
            ],
            SearchData => {

                # Empty hash must be specified, as otherwise the previously set up SearchData prevails
            },
            ExportDataGet => {
                TemplateID => $TemplateIDs[6],    # with JSON format
                UserID     => 1,
            },
            ExportDataSave => {
                TemplateID => $TemplateIDs[6],    # usually same as for ExportDataGet
                Format     => 'JSON',
                FormatData => {
                },
            },
        },

        # The expected rows need to be sorted by config item number in descending order.
        # There is no way to specify the sort order in ExportDataGet().
        ReferenceExportData => [
            [
                'UnitTest - ConfigItem 2 Version 1',
                $ConfigItemNumbers[1],
                qq{chief information officer "🗄"$RandomID},
                qq{onion sales "🧅"$RandomID},
                qq{apple sales "🍎"$RandomID},
                [
                    qq{onion sales "🧅"$RandomID},
                    qq{apple sales "🍎"$RandomID}
                ],
            ],
            [
                'UnitTest - ConfigItem 1 Version 1',
                $ConfigItemNumbers[0],
                qq{chief information officer "🗄"$RandomID},
                qq{palm tree sales "🌴"$RandomID},
                qq{tanabate tree sales "🎋"$RandomID},
                [
                    qq{palm tree sales "🌴"$RandomID},
                    qq{tanabate tree sales "🎋"$RandomID},
                ],
            ],
        ],
        ReferenceExportContent => [
            qq{["UnitTest - ConfigItem 2 Version 1","$ConfigItemNumbers[1]","chief information officer \\"\x{1F5C4}\\"$RandomID","onion sales \\"\x{1F9C5}\\"$RandomID","apple sales \\"\x{1F34E}\\"$RandomID",["onion sales \\"\x{1F9C5}\\"$RandomID","apple sales \\"\x{1F34E}\\"$RandomID"]]},
            qq{["UnitTest - ConfigItem 1 Version 1","$ConfigItemNumbers[0]","chief information officer \\"\x{1F5C4}\\"$RandomID","palm tree sales \\"\x{1F334}\\"$RandomID","tanabate tree sales \\"\x{1F38B}\\"$RandomID",["palm tree sales \\"\x{1F334}\\"$RandomID","tanabate tree sales \\"\x{1F38B}\\"$RandomID"]]},

        ],
    },

    {
        Name             => q{Export Number, CustomerCIO, and ZZZSetOfAgents as JSON},
        SourceExportData => {
            ObjectData => {
                ClassID => $ConfigItemClassIDs[1],
            },
            MappingObjectData => [
                {
                    Key => 'Number',
                },

                # CustomerCIO is a singlevalue field. Thus no index is passed.
                {
                    Key => "CustomerCIO${TestIDSuffix}",
                },

                # ZZZSetOfAgents is a multivalue field.
                # Two cases are covered here:
                # - get the value at a specific index, that is second element
                # - get the complete list
                {
                    Key => "ZZZSetOfAgents${TestIDSuffix}::2",
                },
                {
                    Key => "ZZZSetOfAgents${TestIDSuffix}",
                },
            ],
            SearchData => {

                # Empty hash must be specified, as otherwise the previously set up SearchData prevails
            },
            ExportDataGet => {
                TemplateID => $TemplateIDs[6],
                UserID     => 1,
            },
            ExportDataSave => {
                TemplateID => $TemplateIDs[6],    # usually same as for ExportDataGet
                Format     => 'JSON',
                FormatData => {
                },
            },
        },

        # The expected rows need to be sorted by config item number in descending order.
        # There is no way to specify the sort order in ExportDataGet().
        ReferenceExportData => [
            [
                $ConfigItemNumbers[3],
                qq{chief information officer "🗄"$RandomID},
                [ [ $Agent2UserID{ClimbingAgent} ], [ $Agent2UserID{FrowningAgent} ] ],
                [
                    [ [ $Agent2UserID{DeskAgent} ],     [ $Agent2UserID{LotusAgent} ] ],
                    [ [ $Agent2UserID{ClimbingAgent} ], [ $Agent2UserID{FrowningAgent} ] ],
                ],
            ],
            [
                $ConfigItemNumbers[2],
                qq{chief information officer "🗄"$RandomID},
                [ [ $Agent2UserID{ClimbingAgent} ], [ $Agent2UserID{DeskAgent} ] ],
                [
                    [ [ $Agent2UserID{LotusAgent} ],    [ $Agent2UserID{DeskAgent} ] ],
                    [ [ $Agent2UserID{ClimbingAgent} ], [ $Agent2UserID{DeskAgent} ] ],
                    [ [ $Agent2UserID{FrowningAgent} ], [ $Agent2UserID{DeskAgent} ] ],
                ],
            ],
        ],
        ReferenceExportContent => [
            qq{["$ConfigItemNumbers[3]","chief information officer \\"\x{1F5C4}\\"$RandomID",[[$Agent2UserID{ClimbingAgent}],[$Agent2UserID{FrowningAgent}]],[[[$Agent2UserID{DeskAgent}],[$Agent2UserID{LotusAgent}]],[[$Agent2UserID{ClimbingAgent}],[$Agent2UserID{FrowningAgent}]]]]},
            qq{["$ConfigItemNumbers[2]","chief information officer \\"\x{1F5C4}\\"$RandomID",[[$Agent2UserID{ClimbingAgent}],[$Agent2UserID{DeskAgent}]],[[[$Agent2UserID{LotusAgent}],[$Agent2UserID{DeskAgent}]],[[$Agent2UserID{ClimbingAgent}],[$Agent2UserID{DeskAgent}]],[[$Agent2UserID{FrowningAgent}],[$Agent2UserID{DeskAgent}]]]]},
        ],
    },
);

=for never

10.1 tests
    {
        Name             => q{all required values are given (deployment state search check)},
        SourceExportData => {
            ObjectData => {
                ClassID => $ConfigItemClassIDs[0],
            },
            MappingObjectData => [
                {
                    Key => 'Number',
                },
            ],
            SearchData => {
                DeplStateIDs => $DeplStateListReverse{Production},
            },
            ExportDataGet => {
                TemplateID => $TemplateIDs[5],
                UserID     => 1,
            },
        },
        ReferenceExportData => [
            [ $ConfigItemNumbers[0] ],
            [ $ConfigItemNumbers[1] ],
        ],
    },

    {
        Name             => q{all required values are given (incident state search check)},
        SourceExportData => {
            ObjectData => {
                ClassID => $ConfigItemClassIDs[0],
            },
            MappingObjectData => [
                {
                    Key => 'Number',
                },
            ],
            SearchData => {
                InciStateIDs => $InciStateListReverse{Operational},
            },
            ExportDataGet => {
                TemplateID => $TemplateIDs[5],
                UserID     => 1,
            },
        },
        ReferenceExportData => [
            [ $ConfigItemNumbers[0] ],
            [ $ConfigItemNumbers[1] ],
        ],
    },

    {
        Name             => q{all required values are given (combined search check)},
        SourceExportData => {
            ObjectData => {
                ClassID => $ConfigItemClassIDs[0],
            },
            MappingObjectData => [
                {
                    Key => 'Number',
                },
            ],
            SearchData => {
                Number       => $ConfigItemNumbers[0],
                Name         => 'UnitTest - ConfigItem 1 Version 1',
                DeplStateIDs => $DeplStateListReverse{Production},
                InciStateIDs => $InciStateListReverse{Operational},
            },
            ExportDataGet => {
                TemplateID => $TemplateIDs[5],
                UserID     => 1,
            },
        },
        ReferenceExportData => [
            [ $ConfigItemNumbers[0] ],
        ],
    },

    {
        Name             => q{all required values are given (XML data search check)},
        SourceExportData => {
            ObjectData => {
                ClassID => $ConfigItemClassIDs[0],
            },
            MappingObjectData => [
                {
                    Key => 'Number',
                },
            ],
            SearchData => {
                Date1           => '2008-02-01',
                TextArea1       => "Test\nText Array\nTest",
                Customer1       => 'UnitTest',
                Text1           => 'Test Text Test',
                DateTime1       => '2008-02-01 03:59',
                Integer1        => '1',
                GeneralCatalog1 => $GeneralCatalogListReverse{Test1},
            },
            ExportDataGet => {
                TemplateID => $TemplateIDs[5],
                UserID     => 1,
            },
        },
        ReferenceExportData => [
            [ $ConfigItemNumbers[0] ],
        ],
    },

    {
        Name             => q{all required values are given (combined all search check)},
        SourceExportData => {
            ObjectData => {
                ClassID => $ConfigItemClassIDs[0],
            },
            MappingObjectData => [
                {
                    Key => 'Number',
                },
            ],
            SearchData => {
                Number          => $ConfigItemNumbers[0],
                Name            => 'UnitTest - ConfigItem 1 Version 1',
                DeplStateIDs    => $DeplStateListReverse{Production},
                InciStateIDs    => $InciStateListReverse{Operational},
                Date1           => '2008-02-01',
                TextArea1       => "Test\nText Array\nTest",
                Customer1       => 'UnitTest',
                Text1           => 'Test Text Test',
                DateTime1       => '2008-02-01 03:59',
                Integer1        => '1',
                GeneralCatalog1 => $GeneralCatalogListReverse{Test1},
            },
            ExportDataGet => {
                TemplateID => $TemplateIDs[5],
                UserID     => 1,
            },
        },
        ReferenceExportData => [
            [ $ConfigItemNumbers[0] ],
        ],
    },

    {
        Name             => q{all required values are given (check the returned array)},
        SourceExportData => {
            ObjectData => {
                ClassID => $ConfigItemClassIDs[0],
            },
            MappingObjectData => [
                {
                    Key => 'Number',
                },
                {
                    Key => 'Name',
                },
                {
                    Key => 'DeplState',
                },
                {
                    Key => 'InciState',
                },
                {
                    Key => 'Customer1::1',
                },
                {
                    Key => 'Date1::1',
                },
                {
                    Key => 'DateTime1::1',
                },
                {
                    Key => 'Dummy1::1',
                },
                {
                    Key => 'GeneralCatalog1::1',
                },
                {
                    Key => 'Integer1::1',
                },
                {
                    Key => 'Text1::1',
                },
                {
                    Key => 'TextArea1::1',
                },
            ],
            SearchData => {
                Number => $ConfigItemNumbers[0],
            },
            ExportDataGet => {
                TemplateID => $TemplateIDs[6],
                UserID     => 1,
            },
        },
        ReferenceExportData => [
            [
                $ConfigItemNumbers[0],
                'UnitTest - ConfigItem 1 Version 1',
                'Production',
                'Operational',
                'UnitTest',
                '2008-02-01',
                '2008-02-01 03:59',
                undef,
                'Test1',
                '1',
                'Test Text Test',
                "Test\nText Array\nTest",
            ],
        ],
    },

    {
        Name             => q{all required values are given (double element checks)},
        SourceExportData => {
            ObjectData => {
                ClassID => $ConfigItemClassIDs[0],
            },
            MappingObjectData => [
                {
                    Key => 'Number',
                },
                {
                    Key => 'Number',
                },
                {
                    Key => 'Name',
                },
                {
                    Key => 'Name',
                },
                {
                    Key => 'DeplState',
                },
                {
                    Key => 'DeplState',
                },
                {
                    Key => 'InciState',
                },
                {
                    Key => 'InciState',
                },
                {
                    Key => 'Customer1::1',
                },
                {
                    Key => 'Customer1::1',
                },
                {
                    Key => 'Date1::1',
                },
                {
                    Key => 'Date1::1',
                },
                {
                    Key => 'DateTime1::1',
                },
                {
                    Key => 'DateTime1::1',
                },
                {
                    Key => 'Dummy1::1',
                },
                {
                    Key => 'Dummy1::1',
                },
                {
                    Key => 'GeneralCatalog1::1',
                },
                {
                    Key => 'GeneralCatalog1::1',
                },
                {
                    Key => 'Integer1::1',
                },
                {
                    Key => 'Integer1::1',
                },
                {
                    Key => 'Text1::1',
                },
                {
                    Key => 'Text1::1',
                },
                {
                    Key => 'TextArea1::1',
                },
                {
                    Key => 'TextArea1::1',
                },
            ],
            SearchData => {
                Number => $ConfigItemNumbers[0],
            },
            ExportDataGet => {
                TemplateID => $TemplateIDs[6],
                UserID     => 1,
            },
        },
        ReferenceExportData => [
            [
                $ConfigItemNumbers[0],
                $ConfigItemNumbers[0],
                'UnitTest - ConfigItem 1 Version 1',
                'UnitTest - ConfigItem 1 Version 1',
                'Production',
                'Production',
                'Operational',
                'Operational',
                'UnitTest',
                'UnitTest',
                '2008-02-01',
                '2008-02-01',
                '2008-02-01 03:59',
                '2008-02-01 03:59',
                undef,
                undef,
                'Test1',
                'Test1',
                '1',
                '1',
                'Test Text Test',
                'Test Text Test',
                "Test\nText Array\nTest",
                "Test\nText Array\nTest",
            ],
        ],
    },

    {
        Name             => q{all required values are given (sub element checks)},
        SourceExportData => {
            ObjectData => {
                ClassID => $ConfigItemClassIDs[1],
            },
            MappingObjectData => [
                {
                    Key => 'Number',
                },
                {
                    Key => 'Name',
                },
                {
                    Key => 'DeplState',
                },
                {
                    Key => 'InciState',
                },
                {
                    Key => 'Main1::1',
                },
                {
                    Key => 'Main1::1::Main1Sub1::1',
                },
                {
                    Key => 'Main1::1::Main1Sub1::1::Main1Sub1SubSub1::1',
                },
                {
                    Key => 'Main1::1::Main1Sub1::1::Main1Sub1SubSub1::2',
                },
                {
                    Key => 'Main1::1::Main1Sub1::1::Main1Sub1SubSub1::3',
                },
                {
                    Key => 'Main1::1::Main1Sub1::1::Main1Sub1SubSub2::1',
                },
                {
                    Key => 'Main1::1::Main1Sub1::2',
                },
                {
                    Key => 'Main1::1::Main1Sub1::2::Main1Sub1SubSub1::1',
                },
                {
                    Key => 'Main1::1::Main1Sub1::2::Main1Sub1SubSub2::1',
                },
                {
                    Key => 'Main1::1::Main1Sub1::2::Main1Sub1SubSub2::2',
                },
                {
                    Key => 'Main1::1::Main1Sub2::1',
                },
                {
                    Key => 'Main1::1::Main1Sub2::2',
                },
                {
                    Key => 'Main2::1',
                },
                {
                    Key => 'Main2::1::Main2Sub1::1',
                },
                {
                    Key => 'Main2::1::Main2Sub2::1',
                },
                {
                    Key => 'Main2::1::Main2Sub2::2',
                },
            ],
            SearchData => {
                Number => $ConfigItemNumbers[2],
            },
            ExportDataGet => {
                TemplateID => $TemplateIDs[7],
                UserID     => 1,
            },
        },
        ReferenceExportData => [
            [
                $ConfigItemNumbers[2],
                'UnitTest - ConfigItem 3 Version 1',
                'Production',
                'Operational',
                'Main1 (1)',
                'Main1 (1) Sub1 (1)',
                'Main1 (1) Sub1 (1) SubSub1 (1)',
                'Main1 (1) Sub1 (1) SubSub1 (2)',
                'Main1 (1) Sub1 (1) SubSub1 (3)',
                'Main1 (1) Sub1 (1) SubSub2 (1)',
                'Main1 (1) Sub1 (2)',
                'Main1 (1) Sub1 (2) SubSub1 (1)',
                'Main1 (1) Sub1 (2) SubSub2 (1)',
                'Main1 (1) Sub1 (2) SubSub2 (2)',
                'Main1 (1) Sub2 (1)',
                'Main1 (1) Sub2 (2)',
                'Main2 (1)',
                'Main2 (1) Sub1 (1)',
                'Main2 (1) Sub2 (1)',
                'Main2 (1) Sub2 (2)',
            ],
        ],
    },

    {
        Name             => q{all required values are given (sub element checks with undef values)},
        SourceExportData => {
            ObjectData => {
                ClassID => $ConfigItemClassIDs[1],
            },
            MappingObjectData => [
                {
                    Key => 'Number',
                },
                {
                    Key => 'Name',
                },
                {
                    Key => 'DeplState',
                },
                {
                    Key => 'InciState',
                },
                {
                    Key => 'Main1::1',
                },
                {
                    Key => 'Main1::1::Main1Sub1::1',
                },
                {
                    Key => 'Main1::1::Main1Sub1::1::Main1Sub1SubSub1::1',
                },
                {
                    Key => 'Main1::1::Main1Sub1::1::Main1Sub1SubSub1::2',
                },
                {
                    Key => 'Main1::1::Main1Sub1::1::Main1Sub1SubSub1::3',
                },
                {
                    Key => 'Main1::1::Main1Sub1::1::Main1Sub1SubSub1::4',
                },
                {
                    Key => 'Main1::1::Main1Sub1::1::Main1Sub1SubSub2::1',
                },
                {
                    Key => 'Main1::1::Main1Sub1::1::Main1Sub1SubSub2::2',
                },
                {
                    Key => 'Main1::1::Main1Sub1::2',
                },
                {
                    Key => 'Main1::1::Main1Sub1::2::Main1Sub1SubSub1::1',
                },
                {
                    Key => 'Main1::1::Main1Sub1::2::Main1Sub1SubSub1::2',
                },
                {
                    Key => 'Main1::1::Main1Sub1::2::Main1Sub1SubSub2::1',
                },
                {
                    Key => 'Main1::1::Main1Sub1::2::Main1Sub1SubSub2::2',
                },
                {
                    Key => 'Main1::1::Main1Sub1::2::Main1Sub1SubSub2::3',
                },
                {
                    Key => 'Main1::1::Main1Sub2::1',
                },
                {
                    Key => 'Main1::1::Main1Sub2::2',
                },
                {
                    Key => 'Main1::1::Main1Sub2::3',
                },
                {
                    Key => 'Main2::1',
                },
                {
                    Key => 'Main2::1::Main2Sub1::1',
                },
                {
                    Key => 'Main2::1::Main2Sub1::2',
                },
                {
                    Key => 'Main2::1::Main2Sub2::1',
                },
                {
                    Key => 'Main2::1::Main2Sub2::2',
                },
                {
                    Key => 'Main2::1::Main2Sub2::3',
                },
                {
                    Key => 'Main2::2',
                },
            ],
            SearchData => {
                Number => $ConfigItemNumbers[2],
            },
            ExportDataGet => {
                TemplateID => $TemplateIDs[7],
                UserID     => 1,
            },
        },
        ReferenceExportData => [
            [
                $ConfigItemNumbers[2],
                'UnitTest - ConfigItem 3 Version 1',
                'Production',
                'Operational',
                'Main1 (1)',
                'Main1 (1) Sub1 (1)',
                'Main1 (1) Sub1 (1) SubSub1 (1)',
                'Main1 (1) Sub1 (1) SubSub1 (2)',
                'Main1 (1) Sub1 (1) SubSub1 (3)',
                undef,
                'Main1 (1) Sub1 (1) SubSub2 (1)',
                undef,
                'Main1 (1) Sub1 (2)',
                'Main1 (1) Sub1 (2) SubSub1 (1)',
                undef,
                'Main1 (1) Sub1 (2) SubSub2 (1)',
                'Main1 (1) Sub1 (2) SubSub2 (2)',
                undef,
                'Main1 (1) Sub2 (1)',
                'Main1 (1) Sub2 (2)',
                undef,
                'Main2 (1)',
                'Main2 (1) Sub1 (1)',
                undef,
                'Main2 (1) Sub2 (1)',
                'Main2 (1) Sub2 (2)',
                undef,
                undef,
            ],
        ],
    },

    {
        Name             => q{all required values are given (sub element checks with undef values and empty strings)},
        SourceExportData => {
            ObjectData => {
                ClassID => $ConfigItemClassIDs[1],
            },
            MappingObjectData => [
                {
                    Key => 'Number',
                },
                {
                    Key => 'Name',
                },
                {
                    Key => 'DeplState',
                },
                {
                    Key => 'InciState',
                },
                {
                    Key => 'Main1::1',
                },
                {
                    Key => 'Main1::1::Main1Sub1::1',
                },
                {
                    Key => 'Main1::1::Main1Sub1::1::Main1Sub1SubSub1::1',
                },
                {
                    Key => 'Main1::1::Main1Sub1::1::Main1Sub1SubSub1::2',
                },
                {
                    Key => 'Main1::1::Main1Sub1::1::Main1Sub1SubSub1::3',
                },
                {
                    Key => 'Main1::1::Main1Sub1::1::Main1Sub1SubSub1::4',
                },
                {
                    Key => 'Main1::1::Main1Sub1::1::Main1Sub1SubSub2::1',
                },
                {
                    Key => 'Main1::1::Main1Sub1::1::Main1Sub1SubSub2::2',
                },
                {
                    Key => 'Main1::1::Main1Sub1::2',
                },
                {
                    Key => 'Main1::1::Main1Sub1::2::Main1Sub1SubSub1::1',
                },
                {
                    Key => 'Main1::1::Main1Sub1::2::Main1Sub1SubSub1::2',
                },
                {
                    Key => 'Main1::1::Main1Sub1::2::Main1Sub1SubSub2::1',
                },
                {
                    Key => 'Main1::1::Main1Sub1::2::Main1Sub1SubSub2::2',
                },
                {
                    Key => 'Main1::1::Main1Sub1::2::Main1Sub1SubSub2::3',
                },
                {
                    Key => 'Main1::1::Main1Sub2::1',
                },
                {
                    Key => 'Main1::1::Main1Sub2::2',
                },
                {
                    Key => 'Main1::1::Main1Sub2::3',
                },
                {
                    Key => 'Main2::1',
                },
                {
                    Key => 'Main2::1::Main2Sub1::1',
                },
                {
                    Key => 'Main2::1::Main2Sub1::2',
                },
                {
                    Key => 'Main2::1::Main2Sub2::1',
                },
                {
                    Key => 'Main2::1::Main2Sub2::2',
                },
                {
                    Key => 'Main2::1::Main2Sub2::3',
                },
                {
                    Key => 'Main2::2',
                },
            ],
            SearchData => {
                Number => $ConfigItemNumbers[3],
            },
            ExportDataGet => {
                TemplateID => $TemplateIDs[7],
                UserID     => 1,
            },
        },
        ReferenceExportData => [
            [
                $ConfigItemNumbers[3],
                'UnitTest - ConfigItem 4 Version 1',
                'Production',
                'Operational',
                '',
                '',
                '',
                undef,
                undef,
                undef,
                '',
                undef,
                undef,
                undef,
                undef,
                undef,
                undef,
                undef,
                '',
                undef,
                undef,
                '',
                '',
                undef,
                '',
                undef,
                undef,
                undef,
            ],
        ],
    },

    {
        Name             => q{all required values are given (special character checks)},
        SourceExportData => {
            ObjectData => {
                ClassID => $ConfigItemClassIDs[1],
            },
            MappingObjectData => [
                {
                    Key => 'Number',
                },
                {
                    Key => 'Name',
                },
                {
                    Key => 'DeplState',
                },
                {
                    Key => 'InciState',
                },
                {
                    Key => 'Main1::1',
                },
                {
                    Key => 'Main1::1::Main1Sub1::1',
                },
                {
                    Key => 'Main1::1::Main1Sub1::1::Main1Sub1SubSub1::1',
                },
                {
                    Key => 'Main1::1::Main1Sub1::1::Main1Sub1SubSub2::1',
                },
                {
                    Key => 'Main1::1::Main1Sub2::1',
                },
                {
                    Key => 'Main2::1',
                },
                {
                    Key => 'Main2::1::Main2Sub1::1',
                },
                {
                    Key => 'Main2::1::Main2Sub2::1',
                },
            ],
            SearchData => {
                Number => $ConfigItemNumbers[4],
            },
            ExportDataGet => {
                TemplateID => $TemplateIDs[8],
                UserID     => 1,
            },
        },
        ReferenceExportData => [
            [
                $ConfigItemNumbers[4],
                'UnitTest - ConfigItem 5 Version 1',
                'Production',
                'Operational',
                '"";;::..--__##',
                'Test;:_°^!"§$%&/()=?´`*+Test',
                '><@~\'}{[]\\',
                '><@~\'}{[]\\',
                'Test;:_°^!"§$%&/()=?´`*+Test',
                '"";;::..--__##',
                'Test Test',
                "Test\nTest\tTest",
            ],
        ],
    },

    {
        Name             => q{all required values are given (UTF-8 checks)},
        SourceExportData => {
            ObjectData => {
                ClassID => $ConfigItemClassIDs[1],
            },
            MappingObjectData => [
                {
                    Key => 'Number',
                },
                {
                    Key => 'Name',
                },
                {
                    Key => 'DeplState',
                },
                {
                    Key => 'InciState',
                },
                {
                    Key => 'Main1::1',
                },
                {
                    Key => 'Main1::1::Main1Sub1::1',
                },
                {
                    Key => 'Main1::1::Main1Sub1::1::Main1Sub1SubSub1::1',
                },
                {
                    Key => 'Main1::1::Main1Sub1::1::Main1Sub1SubSub2::1',
                },
                {
                    Key => 'Main1::1::Main1Sub2::1',
                },
                {
                    Key => 'Main2::1',
                },
                {
                    Key => 'Main2::1::Main2Sub1::1',
                },
                {
                    Key => 'Main2::1::Main2Sub2::1',
                },
            ],
            SearchData => {
                Number => $ConfigItemNumbers[5],
            },
            ExportDataGet => {
                TemplateID => $TemplateIDs[9],
                UserID     => 1,
            },
        },
        ReferenceExportData => [
            [
                $ConfigItemNumbers[5],
                'UnitTest - ConfigItem 6 Version 1',
                'Production',
                'Operational',
                'ↂ ⅻ ⅛',
                '☄ ↮ ↹ →',
                '₤ ₡ ₩ ₯ ₵',
                '♊ ♈ ♉ ♊ ♋ ♍ ♑',
                '✈ ❤ ☮',
                'Պ Մ Հ',
                '® ©',
                'か げ を',
            ],
        ],
    },

=cut

# run general ExportDataGet tests
for my $Test (@ExportDataTests) {

    subtest "ExportData: $Test->{Name}" => sub {

        # check SourceExportData attribute
        if ( !$Test->{SourceExportData} || ref $Test->{SourceExportData} ne 'HASH' ) {

            fail("SourceExportData not found for this test.");

            return;
        }

        # set the object data
        if (
            $Test->{SourceExportData}->{ObjectData}
            && ref $Test->{SourceExportData}->{ObjectData} eq 'HASH'
            && $Test->{SourceExportData}->{ExportDataGet}->{TemplateID}
            )
        {

            # save object data
            $ImportExportObject->ObjectDataSave(
                TemplateID => $Test->{SourceExportData}->{ExportDataGet}->{TemplateID},
                ObjectData => $Test->{SourceExportData}->{ObjectData},
                UserID     => 1,
            );
        }

        # set the mapping object data
        if (
            $Test->{SourceExportData}->{MappingObjectData}
            && ref $Test->{SourceExportData}->{MappingObjectData} eq 'ARRAY'
            && $Test->{SourceExportData}->{ExportDataGet}->{TemplateID}
            )
        {

            # delete all existing mapping data
            $ImportExportObject->MappingDelete(
                TemplateID => $Test->{SourceExportData}->{ExportDataGet}->{TemplateID},
                UserID     => 1,
            );

            # add the mapping object rows
            MAPPINGOBJECTDATA:
            for my $MappingObjectData ( @{ $Test->{SourceExportData}->{MappingObjectData} } ) {

                # add a new mapping row
                my $MappingID = $ImportExportObject->MappingAdd(
                    TemplateID => $Test->{SourceExportData}->{ExportDataGet}->{TemplateID},
                    UserID     => 1,
                );

                # add the mapping object data
                $ImportExportObject->MappingObjectDataSave(
                    MappingID         => $MappingID,
                    MappingObjectData => $MappingObjectData,
                    UserID            => 1,
                );
            }
        }

        # add the search data
        if (
            $Test->{SourceExportData}->{SearchData}
            && ref $Test->{SourceExportData}->{SearchData} eq 'HASH'
            && $Test->{SourceExportData}->{ExportDataGet}->{TemplateID}
            )
        {

            # save search data
            $ImportExportObject->SearchDataSave(
                TemplateID => $Test->{SourceExportData}->{ExportDataGet}->{TemplateID},
                SearchData => $Test->{SourceExportData}->{SearchData},
                UserID     => 1,
            );
        }

        # get export data as an arrayref
        my $ExportData = $ObjectBackendObject->ExportDataGet(
            %{ $Test->{SourceExportData}->{ExportDataGet} },
        );

        if ( !$Test->{ReferenceExportData} ) {
            ok( !$ExportData, "ExportDataGet() returned not data as was expected" );

            return;
        }

        if ( ref $ExportData ne 'ARRAY' ) {

            # check array reference
            fail("ExportDataGet() - return value is not an array reference");

            return;
        }

        # check number of rows
        is(
            scalar @{$ExportData},
            scalar @{ $Test->{ReferenceExportData} },
            "ExportDataGet() - correct number of rows",
        );

        # check the individual rows of export data
        my $CounterRow = 0;
        ROW:
        for my $ExportRow ( $ExportData->@* ) {
            subtest "ExportDataGet(): row $CounterRow in exported data" => sub {
                ref_ok( $ExportRow, 'ARRAY', 'exported row is an arrayref' );

                # extract reference row
                my $ReferenceRow = $Test->{ReferenceExportData}->[$CounterRow];
                ref_ok( $ReferenceRow, 'ARRAY', 'expected row is an arrayref' );

                # check number of columns
                is(
                    scalar @{$ExportRow},
                    scalar @{$ReferenceRow},
                    "correct number of columns",
                );

                # check values
                is( $ExportRow, $ReferenceRow, 'values in exported row' );
            };
        }
        continue {
            $CounterRow++;
        }

        # optionally test the CSV formatted export
        if ( $Test->{SourceExportData}->{ExportDataSave} ) {
            if ( !$Test->{ReferenceExportContent} ) {
                fail("ReferenceExportContent is set up");

                return;
            }
            if ( ref $Test->{ReferenceExportContent} ne 'ARRAY' ) {
                fail("ReferenceExportContent is an arrayref");

                return;
            }

            my $TemplateID = $Test->{SourceExportData}->{ExportDataSave}->{TemplateID};

            # specify the format
            $ImportExportObject->FormatDataSave(
                TemplateID => $TemplateID,
                FormatData => $Test->{SourceExportData}->{ExportDataSave}->{FormatData},
                UserID     => 1,
            );

            # get export data rows
            my $Format = $Test->{SourceExportData}->{ExportDataSave}->{Format};
            diag "Format of content is: $Format";
            my $FormatBackend = $FormatBackendObject{$Format};
            my @Content;
            for my $Row ( $ExportData->@* ) {
                push @Content, $FormatBackend->ExportDataSave(
                    TemplateID    => $TemplateID,
                    ExportDataRow => $Row,
                    UserID        => 1,
                );
            }
            is(
                \@Content,
                $Test->{ReferenceExportContent},
                'ExportDataSave() produced expected content'
            );
        }
    };
}

# ------------------------------------------------------------ #
# define general ImportDataSave tests
# ------------------------------------------------------------ #

my @ImportDataTests = (

    {
        Name             => q{ImportDataSave doesn't contains all data (check required attributes)},
        SourceImportData => {
            ImportDataSave => {
                ImportDataRow => [],
                UserID        => 1,
            },
        },
    },

    {
        Name             => q{ImportDataSave doesn't contains all data (check required attributes)},
        SourceImportData => {
            ImportDataSave => {
                TemplateID => $TemplateIDs[20],
                UserID     => 1,
            },
        },
    },

    {
        Name             => q{ImportDataSave doesn't contains all data (check required attributes)},
        SourceImportData => {
            ImportDataSave => {
                TemplateID    => $TemplateIDs[20],
                ImportDataRow => [],
            },
        },
    },

    {
        Name             => q{import data row must be an array reference (check return false)},
        SourceImportData => {
            ImportDataSave => {
                TemplateID    => $TemplateIDs[20],
                ImportDataRow => '',
                UserID        => 1,
            },
        },
    },

    {
        Name             => q{import data row must be an array reference (check return false)},
        SourceImportData => {
            ImportDataSave => {
                TemplateID    => $TemplateIDs[20],
                ImportDataRow => {},
                UserID        => 1,
            },
        },
    },

    {
        Name             => q{no existing template id is given (check return false)},
        SourceImportData => {
            ImportDataSave => {
                TemplateID    => $TemplateIDs[-1] + 1,
                ImportDataRow => ['Dummy'],
                UserID        => 1,
            },
        },
    },

    {
        Name             => q{no class id is given (check return false)},
        SourceImportData => {
            ImportDataSave => {
                TemplateID    => $TemplateIDs[21],
                ImportDataRow => ['Dummy'],
                UserID        => 1,
            },
        },
    },

);

=for never

    {
        Name             => q{invalid class id is given (check return false)},
        SourceImportData => {
            ObjectData => {
                ClassID => $ConfigItemClassIDs[-1] + 1,
            },
            ImportDataSave => {
                TemplateID    => $TemplateIDs[22],
                ImportDataRow => ['Dummy'],
                UserID        => 1,
            },
        },
    },

    {
        Name             => q{mapping list is empty (check return false)},
        SourceImportData => {
            ObjectData => {
                ClassID => $ConfigItemClassIDs[0],
            },
            ImportDataSave => {
                TemplateID    => $TemplateIDs[23],
                ImportDataRow => ['Dummy'],
                UserID        => 1,
            },
        },
    },

    {
        Name             => q{more than one identifier with the same name (check return false)},
        SourceImportData => {
            ObjectData => {
                ClassID => $ConfigItemClassIDs[0],
            },
            MappingObjectData => [
                {
                    Key        => 'Number',
                    Identifier => 1,
                },
                {
                    Key        => 'Number',
                    Identifier => 1,
                },
            ],
            ImportDataSave => {
                TemplateID    => $TemplateIDs[23],
                ImportDataRow => [ '123', '321' ],
                UserID        => 1,
            },
        },
    },

    {
        Name             => q{identifier is empty (check return false)},
        SourceImportData => {
            ObjectData => {
                ClassID => $ConfigItemClassIDs[0],
            },
            MappingObjectData => [
                {
                    Key        => 'Number',
                    Identifier => 1,
                },
            ],
            ImportDataSave => {
                TemplateID    => $TemplateIDs[23],
                ImportDataRow => [''],
                UserID        => 1,
            },
        },
    },

    {
        Name             => q{identifier is undef (check return false)},
        SourceImportData => {
            ObjectData => {
                ClassID => $ConfigItemClassIDs[0],
            },
            MappingObjectData => [
                {
                    Key        => 'Number',
                    Identifier => 1,
                },
            ],
            ImportDataSave => {
                TemplateID    => $TemplateIDs[23],
                ImportDataRow => [undef],
                UserID        => 1,
            },
        },
    },

    {
        Name             => q{both identifiers are empty (check return false)},
        SourceImportData => {
            ObjectData => {
                ClassID => $ConfigItemClassIDs[0],
            },
            MappingObjectData => [
                {
                    Key        => 'Number',
                    Identifier => 1,
                },
                {
                    Key        => 'Name',
                    Identifier => 1,
                },
            ],
            ImportDataSave => {
                TemplateID    => $TemplateIDs[23],
                ImportDataRow => [ '', '' ],
                UserID        => 1,
            },
        },
    },

    {
        Name             => q{both identifiers are undef (check return false)},
        SourceImportData => {
            ObjectData => {
                ClassID => $ConfigItemClassIDs[0],
            },
            MappingObjectData => [
                {
                    Key        => 'Number',
                    Identifier => 1,
                },
                {
                    Key        => 'Name',
                    Identifier => 1,
                },
            ],
            ImportDataSave => {
                TemplateID    => $TemplateIDs[23],
                ImportDataRow => [ undef, undef ],
                UserID        => 1,
            },
        },
    },

    {
        Name             => q{one identifiers is empty, one is undef (check return false)},
        SourceImportData => {
            ObjectData => {
                ClassID => $ConfigItemClassIDs[0],
            },
            MappingObjectData => [
                {
                    Key        => 'Number',
                    Identifier => 1,
                },
                {
                    Key        => 'Name',
                    Identifier => 1,
                },
            ],
            ImportDataSave => {
                TemplateID    => $TemplateIDs[23],
                ImportDataRow => [ '', undef ],
                UserID        => 1,
            },
        },
    },

    {
        Name             => q{one of the identifiers is empty (check return false)},
        SourceImportData => {
            ObjectData => {
                ClassID => $ConfigItemClassIDs[0],
            },
            MappingObjectData => [
                {
                    Key        => 'Number',
                    Identifier => 1,
                },
                {
                    Key        => 'Name',
                    Identifier => 1,
                },
            ],
            ImportDataSave => {
                TemplateID    => $TemplateIDs[23],
                ImportDataRow => [ '123', '' ],
                UserID        => 1,
            },
        },
    },

    {
        Name             => q{one of the identifiers is undef (check return false)},
        SourceImportData => {
            ObjectData => {
                ClassID => $ConfigItemClassIDs[0],
            },
            MappingObjectData => [
                {
                    Key        => 'Number',
                    Identifier => 1,
                },
                {
                    Key        => 'Name',
                    Identifier => 1,
                },
            ],
            ImportDataSave => {
                TemplateID    => $TemplateIDs[23],
                ImportDataRow => [ '123', undef ],
                UserID        => 1,
            },
        },
    },

    {
        Name             => q{one of the identifiers is empty (check return false)},
        SourceImportData => {
            ObjectData => {
                ClassID => $ConfigItemClassIDs[0],
            },
            MappingObjectData => [
                {
                    Key        => 'Number',
                    Identifier => 1,
                },
                {
                    Key        => 'Name',
                    Identifier => 1,
                },
            ],
            ImportDataSave => {
                TemplateID    => $TemplateIDs[23],
                ImportDataRow => [ '', '123' ],
                UserID        => 1,
            },
        },
    },

    {
        Name             => q{one of the identifiers is empty (check return false)},
        SourceImportData => {
            ObjectData => {
                ClassID => $ConfigItemClassIDs[0],
            },
            MappingObjectData => [
                {
                    Key        => 'Number',
                    Identifier => 1,
                },
                {
                    Key        => 'Name',
                    Identifier => 1,
                },
            ],
            ImportDataSave => {
                TemplateID    => $TemplateIDs[23],
                ImportDataRow => [ undef, '123' ],
                UserID        => 1,
            },
        },
    },

    # TODO Add some identifier tests

    {
        Name             => q{empty name is given (check return false)},
        SourceImportData => {
            ObjectData => {
                ClassID => $ConfigItemClassIDs[0],
            },
            MappingObjectData => [
                {
                    Key => 'Name',
                },
                {
                    Key => 'DeplState',
                },
                {
                    Key => 'InciState',
                },
            ],
            ImportDataSave => {
                TemplateID    => $TemplateIDs[24],
                ImportDataRow => [ '', 'Production', 'Operational' ],
                UserID        => 1,
            },
        },
    },

    {
        Name             => q{invalid deployment state is given (check return false)},
        SourceImportData => {
            ObjectData => {
                ClassID => $ConfigItemClassIDs[0],
            },
            MappingObjectData => [
                {
                    Key => 'Name',
                },
                {
                    Key => 'DeplState',
                },
                {
                    Key => 'InciState',
                },
            ],
            ImportDataSave => {
                TemplateID    => $TemplateIDs[24],
                ImportDataRow => [ 'UnitTest - Importtest 1', 'Dummy', 'Operational' ],
                UserID        => 1,
            },
        },
    },

    {
        Name             => q{invalid incident state is given (check return false)},
        SourceImportData => {
            ObjectData => {
                ClassID => $ConfigItemClassIDs[0],
            },
            MappingObjectData => [
                {
                    Key => 'Name',
                },
                {
                    Key => 'DeplState',
                },
                {
                    Key => 'InciState',
                },
            ],
            ImportDataSave => {
                TemplateID    => $TemplateIDs[24],
                ImportDataRow => [ 'UnitTest - Importtest 2', 'Production', 'Dummy' ],
                UserID        => 1,
            },
        },
    },

    {
        Name             => q{all required values are given (a NEW config item must be created)},
        SourceImportData => {
            ObjectData => {
                ClassID => $ConfigItemClassIDs[0],
            },
            MappingObjectData => [
                {
                    Key => 'Name',
                },
                {
                    Key => 'DeplState',
                },
                {
                    Key => 'InciState',
                },
                {
                    Key => 'Customer1::1',
                },
                {
                    Key => 'Date1::1',
                },
                {
                    Key => 'DateTime1::1',
                },
                {
                    Key => 'GeneralCatalog1::1',
                },
                {
                    Key => 'Integer1::1',
                },
                {
                    Key => 'Text1::1',
                },
                {
                    Key => 'TextArea1::1',
                },
            ],
            ImportDataSave => {
                TemplateID    => $TemplateIDs[25],
                ImportDataRow => [
                    'UnitTest - Importtest 3',
                    'Production',
                    'Operational',
                    'UnitTest',
                    '2008-06-05',
                    '2008-08-05 04:50',
                    'Test3',
                    '3',
                    'Test3 Text3 Test3',
                    "Test3\nTextArray3\nTest3",
                ],
                UserID => 1,
            },
        },
        ReferenceImportData => {
            VersionNumber => 1,
            LastVersion   => {
                Name                 => 'UnitTest - Importtest 3',
                DeplState            => 'Production',
                InciState            => 'Operational',
                'Customer1::1'       => 'UnitTest',
                'Date1::1'           => '2008-06-05',
                'DateTime1::1'       => '2008-08-05 04:50',
                'GeneralCatalog1::1' => $GeneralCatalogListReverse{Test3},
                'Integer1::1'        => '3',
                'Text1::1'           => 'Test3 Text3 Test3',
                'TextArea1::1'       => "Test3\nTextArray3\nTest3",
            },
        },
    },

    {
        Name             => q{all required values are given (a second NEW config item must be created)},
        SourceImportData => {
            ObjectData => {
                ClassID => $ConfigItemClassIDs[0],
            },
            MappingObjectData => [
                {
                    Key => 'Name',
                },
                {
                    Key => 'DeplState',
                },
                {
                    Key => 'InciState',
                },
                {
                    Key => 'Customer1::1',
                },
                {
                    Key => 'Date1::1',
                },
                {
                    Key => 'DateTime1::1',
                },
                {
                    Key => 'GeneralCatalog1::1',
                },
                {
                    Key => 'Integer1::1',
                },
                {
                    Key => 'Text1::1',
                },
                {
                    Key => 'TextArea1::1',
                },
            ],
            ImportDataSave => {
                TemplateID    => $TemplateIDs[25],
                ImportDataRow => [
                    'UnitTest - Importtest 4',
                    'Production',
                    'Operational',
                    'UnitTest',
                    '2008-09-05',
                    '2008-12-05 04:50',
                    'Test4',
                    '4',
                    'Test4 Text4 Test4',
                    "Test4\nTextArray4\nTest4",
                ],
                UserID => 1,
            },
        },
        ReferenceImportData => {
            VersionNumber => 1,
            LastVersion   => {
                Name                 => 'UnitTest - Importtest 4',
                DeplState            => 'Production',
                InciState            => 'Operational',
                'Customer1::1'       => 'UnitTest',
                'Date1::1'           => '2008-09-05',
                'DateTime1::1'       => '2008-12-05 04:50',
                'GeneralCatalog1::1' => $GeneralCatalogListReverse{Test4},
                'Integer1::1'        => '4',
                'Text1::1'           => 'Test4 Text4 Test4',
                'TextArea1::1'       => "Test4\nTextArray4\nTest4",
            },
        },
    },

    {
        Name             => q{all required values are given (a new version must be added to first test config item)},
        SourceImportData => {
            ObjectData => {
                ClassID => $ConfigItemClassIDs[0],
            },
            MappingObjectData => [
                {
                    Key        => 'Number',
                    Identifier => 1,
                },
                {
                    Key => 'Name',
                },
                {
                    Key => 'DeplState',
                },
                {
                    Key => 'InciState',
                },
                {
                    Key => 'Customer1::1',
                },
                {
                    Key => 'Date1::1',
                },
                {
                    Key => 'DateTime1::1',
                },
                {
                    Key => 'GeneralCatalog1::1',
                },
                {
                    Key => 'Integer1::1',
                },
                {
                    Key => 'Text1::1',
                },
                {
                    Key => 'TextArea1::1',
                },
            ],
            ImportDataSave => {
                TemplateID    => $TemplateIDs[26],
                ImportDataRow => [
                    $ConfigItemNumbers[0],
                    'UnitTest - ConfigItem 1 Version 2',
                    'Pilot',
                    'Incident',
                    'UnitTest',
                    '2008-02-02',
                    '2008-02-02 03:59',
                    'Test2',
                    '2',
                    'Test Text UPDATE1 Test',
                    "Test\nText Array UPDATE1\nTest",
                ],
                UserID => 1,
            },
        },
        ReferenceImportData => {
            VersionNumber => 2,
            LastVersion   => {
                Name                 => 'UnitTest - ConfigItem 1 Version 2',
                DeplState            => 'Pilot',
                InciState            => 'Incident',
                'Customer1::1'       => 'UnitTest',
                'Date1::1'           => '2008-02-02',
                'DateTime1::1'       => '2008-02-02 03:59',
                'GeneralCatalog1::1' => $GeneralCatalogListReverse{Test2},
                'Integer1::1'        => '2',
                'Text1::1'           => 'Test Text UPDATE1 Test',
                'TextArea1::1'       => "Test\nText Array UPDATE1\nTest",
            },
        },
    },

    {
        Name             => q{all required values are given (a new version must be added to first test config item again)},
        SourceImportData => {
            ObjectData => {
                ClassID => $ConfigItemClassIDs[0],
            },
            MappingObjectData => [
                {
                    Key        => 'Number',
                    Identifier => 1,
                },
                {
                    Key => 'Name',
                },
                {
                    Key => 'DeplState',
                },
                {
                    Key => 'InciState',
                },
                {
                    Key => 'Customer1::1',
                },
                {
                    Key => 'Date1::1',
                },
                {
                    Key => 'DateTime1::1',
                },
                {
                    Key => 'GeneralCatalog1::1',
                },
                {
                    Key => 'Integer1::1',
                },
                {
                    Key => 'Text1::1',
                },
                {
                    Key => 'TextArea1::1',
                },
            ],
            ImportDataSave => {
                TemplateID    => $TemplateIDs[27],
                ImportDataRow => [
                    $ConfigItemNumbers[0],
                    'UnitTest - ConfigItem 1 Version 3',
                    'Repair',
                    'Operational',
                    'UnitTest',
                    '2008-02-03',
                    '2008-02-03 03:59',
                    'Test3',
                    '3',
                    'Test Text UPDATE2 Test',
                    "Test\nText Array UPDATE2\nTest",
                ],
                UserID => 1,
            },
        },
        ReferenceImportData => {
            VersionNumber => 3,
            LastVersion   => {
                Name                 => 'UnitTest - ConfigItem 1 Version 3',
                DeplState            => 'Repair',
                InciState            => 'Operational',
                'Customer1::1'       => 'UnitTest',
                'Date1::1'           => '2008-02-03',
                'DateTime1::1'       => '2008-02-03 03:59',
                'GeneralCatalog1::1' => $GeneralCatalogListReverse{Test3},
                'Integer1::1'        => '3',
                'Text1::1'           => 'Test Text UPDATE2 Test',
                'TextArea1::1'       => "Test\nText Array UPDATE2\nTest",
            },
        },
    },

    {
        Name             => q{all required values are given (a new version must be added to third test config item)},
        SourceImportData => {
            ObjectData => {
                ClassID => $ConfigItemClassIDs[1],
            },
            MappingObjectData => [
                {
                    Key        => 'Number',
                    Identifier => 1,
                },
                {
                    Key => 'Name',
                },
                {
                    Key => 'DeplState',
                },
                {
                    Key => 'InciState',
                },
                {
                    Key => 'Main1::1',
                },
                {
                    Key => 'Main1::1::Main1Sub1::1',
                },
                {
                    Key => 'Main1::1::Main1Sub1::1::Main1Sub1SubSub1::1',
                },
                {
                    Key => 'Main1::1::Main1Sub1::1::Main1Sub1SubSub1::2',
                },
                {
                    Key => 'Main1::1::Main1Sub1::1::Main1Sub1SubSub1::3',
                },
                {
                    Key => 'Main1::1::Main1Sub1::1::Main1Sub1SubSub2::1',
                },
                {
                    Key => 'Main1::1::Main1Sub1::2',
                },
                {
                    Key => 'Main1::1::Main1Sub1::2::Main1Sub1SubSub1::1',
                },
                {
                    Key => 'Main1::1::Main1Sub1::2::Main1Sub1SubSub2::1',
                },
                {
                    Key => 'Main1::1::Main1Sub1::2::Main1Sub1SubSub2::2',
                },
                {
                    Key => 'Main1::1::Main1Sub2::1',
                },
                {
                    Key => 'Main1::1::Main1Sub2::2',
                },
                {
                    Key => 'Main2::1',
                },
                {
                    Key => 'Main2::1::Main2Sub1::1',
                },
                {
                    Key => 'Main2::1::Main2Sub2::1',
                },
                {
                    Key => 'Main2::1::Main2Sub2::2',
                },
            ],
            ImportDataSave => {
                TemplateID    => $TemplateIDs[27],
                ImportDataRow => [
                    $ConfigItemNumbers[2],
                    'UnitTest - ConfigItem 3 Version 2',
                    'Production',
                    'Operational',
                    'Main1 (1)',
                    'Main1 (1) Main1Sub1 (1)',
                    'Main1 (1) Main1Sub1 (1) Main1Sub1SubSub1 (1)',
                    'Main1 (1) Main1Sub1 (1) Main1Sub1SubSub1 (2)',
                    'Main1 (1) Main1Sub1 (1) Main1Sub1SubSub1 (3)',
                    'Main1 (1) Main1Sub1 (1) Main1Sub1SubSub2 (1)',
                    'Main1 (1) Main1Sub1 (2)',
                    'Main1 (1) Main1Sub1 (2) Main1Sub1SubSub1 (1)',
                    'Main1 (1) Main1Sub1 (2) Main1Sub1SubSub2 (1)',
                    'Main1 (1) Main1Sub1 (2) Main1Sub1SubSub2 (2)',
                    'Main1 (1) Main1Sub2 (1)',
                    'Main1 (1) Main1Sub2 (2)',
                    'Main2 (1)',
                    'Main2 (1) Main2Sub1 (1)',
                    'Main2 (1) Main2Sub2 (1)',
                    'Main2 (1) Main2Sub2 (2)',
                ],
                UserID => 1,
            },
        },
        ReferenceImportData => {
            VersionNumber => 2,
            LastVersion   => {
                Name                                          => 'UnitTest - ConfigItem 3 Version 2',
                DeplState                                     => 'Production',
                InciState                                     => 'Operational',
                'Main1::1'                                    => 'Main1 (1)',
                'Main1::1::Main1Sub1::1'                      => 'Main1 (1) Main1Sub1 (1)',
                'Main1::1::Main1Sub1::1::Main1Sub1SubSub1::1' =>
                    'Main1 (1) Main1Sub1 (1) Main1Sub1SubSub1 (1)',
                'Main1::1::Main1Sub1::1::Main1Sub1SubSub1::2' =>
                    'Main1 (1) Main1Sub1 (1) Main1Sub1SubSub1 (2)',
                'Main1::1::Main1Sub1::1::Main1Sub1SubSub1::3' =>
                    'Main1 (1) Main1Sub1 (1) Main1Sub1SubSub1 (3)',
                'Main1::1::Main1Sub1::1::Main1Sub1SubSub2::1' =>
                    'Main1 (1) Main1Sub1 (1) Main1Sub1SubSub2 (1)',
                'Main1::1::Main1Sub1::2'                      => 'Main1 (1) Main1Sub1 (2)',
                'Main1::1::Main1Sub1::2::Main1Sub1SubSub1::1' =>
                    'Main1 (1) Main1Sub1 (2) Main1Sub1SubSub1 (1)',
                'Main1::1::Main1Sub1::2::Main1Sub1SubSub2::1' =>
                    'Main1 (1) Main1Sub1 (2) Main1Sub1SubSub2 (1)',
                'Main1::1::Main1Sub1::2::Main1Sub1SubSub2::2' =>
                    'Main1 (1) Main1Sub1 (2) Main1Sub1SubSub2 (2)',
                'Main1::1::Main1Sub2::1' => 'Main1 (1) Main1Sub2 (1)',
                'Main1::1::Main1Sub2::2' => 'Main1 (1) Main1Sub2 (2)',
                'Main2::1'               => 'Main2 (1)',
                'Main2::1::Main2Sub1::1' => 'Main2 (1) Main2Sub1 (1)',
                'Main2::1::Main2Sub2::1' => 'Main2 (1) Main2Sub2 (1)',
                'Main2::1::Main2Sub2::2' => 'Main2 (1) Main2Sub2 (2)',
            },
        },
    },

    # all required values are given (special character checks)
    # In 'UnitTest - ConfigItem 3 Version 2' 16 Attributes were imported,
    # so there will be 8 lingering attributes.
    {
        Name             => '8 lingering attributes',
        SourceImportData => {
            ObjectData => {
                ClassID => $ConfigItemClassIDs[1],
            },
            MappingObjectData => [
                {
                    Key        => 'Number',
                    Identifier => 1,
                },
                {
                    Key => 'Name',
                },
                {
                    Key => 'DeplState',
                },
                {
                    Key => 'InciState',
                },
                {
                    Key => 'Main1::1',
                },
                {
                    Key => 'Main1::1::Main1Sub1::1',
                },
                {
                    Key => 'Main1::1::Main1Sub1::1::Main1Sub1SubSub1::1',
                },
                {
                    Key => 'Main1::1::Main1Sub1::1::Main1Sub1SubSub2::1',
                },
                {
                    Key => 'Main1::1::Main1Sub2::1',
                },
                {
                    Key => 'Main2::1',
                },
                {
                    Key => 'Main2::1::Main2Sub1::1',
                },
                {
                    Key => 'Main2::1::Main2Sub2::1',
                },
            ],
            ImportDataSave => {
                TemplateID    => $TemplateIDs[27],
                ImportDataRow => [
                    $ConfigItemNumbers[2],
                    'UnitTest - ConfigItem 3 Version 3',
                    'Production',
                    'Operational',
                    '"";;::..--__##',
                    'Test;:_°^!"§$%&/()=?´`*+Test',
                    '><@~\'}{[]\\',
                    '><@~\'}{[]\\',
                    'Test;:_°^!"§$%&/()=?´`*+Test',
                    '"";;::..--__##',
                    'Test Test',
                    "Test\nTest\tTest",
                ],
                UserID => 1,
            },
        },
        ReferenceImportData => {
            VersionNumber => 3,
            LastVersion   => {
                Name                                          => 'UnitTest - ConfigItem 3 Version 3',
                DeplState                                     => 'Production',
                InciState                                     => 'Operational',
                'Main1::1'                                    => '"";;::..--__##',
                'Main1::1::Main1Sub1::1'                      => 'Test;:_°^!"§$%&/()=?´`*+Test',
                'Main1::1::Main1Sub1::1::Main1Sub1SubSub1::1' => '><@~\'}{[]\\',
                'Main1::1::Main1Sub1::1::Main1Sub1SubSub2::1' => '><@~\'}{[]\\',
                'Main1::1::Main1Sub2::1'                      => 'Test;:_°^!"§$%&/()=?´`*+Test',
                'Main2::1'                                    => '"";;::..--__##',
                'Main2::1::Main2Sub1::1'                      => 'Test Test',
                'Main2::1::Main2Sub2::1'                      => "Test\nTest\tTest",

                # lingering from 'UnitTest - ConfigItem 3 Version 2',
                'Main1::1::Main1Sub1::1::Main1Sub1SubSub1::2' =>
                    'Main1 (1) Main1Sub1 (1) Main1Sub1SubSub1 (2)',
                'Main1::1::Main1Sub1::1::Main1Sub1SubSub1::3' =>
                    'Main1 (1) Main1Sub1 (1) Main1Sub1SubSub1 (3)',
                'Main1::1::Main1Sub1::2'                      => 'Main1 (1) Main1Sub1 (2)',
                'Main1::1::Main1Sub1::2::Main1Sub1SubSub1::1' =>
                    'Main1 (1) Main1Sub1 (2) Main1Sub1SubSub1 (1)',
                'Main1::1::Main1Sub1::2::Main1Sub1SubSub2::1' =>
                    'Main1 (1) Main1Sub1 (2) Main1Sub1SubSub2 (1)',
                'Main1::1::Main1Sub1::2::Main1Sub1SubSub2::2' =>
                    'Main1 (1) Main1Sub1 (2) Main1Sub1SubSub2 (2)',
                'Main1::1::Main1Sub2::2' => 'Main1 (1) Main1Sub2 (2)',
                'Main2::1::Main2Sub2::2' => 'Main2 (1) Main2Sub2 (2)',
            },
        },
    },

    # all required values are given (UTF-8 checks)
    # In 'UnitTest - ConfigItem 3 Version 2' 16 Attributes were imported,
    # so there will be 8 lingering attributes.
    {
        Name             => '8 lingering attributes, again',
        SourceImportData => {
            ObjectData => {
                ClassID => $ConfigItemClassIDs[1],
            },
            MappingObjectData => [
                {
                    Key        => 'Number',
                    Identifier => 1,
                },
                {
                    Key => 'Name',
                },
                {
                    Key => 'DeplState',
                },
                {
                    Key => 'InciState',
                },
                {
                    Key => 'Main1::1',
                },
                {
                    Key => 'Main1::1::Main1Sub1::1',
                },
                {
                    Key => 'Main1::1::Main1Sub1::1::Main1Sub1SubSub1::1',
                },
                {
                    Key => 'Main1::1::Main1Sub1::1::Main1Sub1SubSub2::1',
                },
                {
                    Key => 'Main1::1::Main1Sub2::1',
                },
                {
                    Key => 'Main2::1',
                },
                {
                    Key => 'Main2::1::Main2Sub1::1',
                },
                {
                    Key => 'Main2::1::Main2Sub2::1',
                },
            ],
            ImportDataSave => {
                TemplateID    => $TemplateIDs[27],
                ImportDataRow => [
                    $ConfigItemNumbers[2],
                    'UnitTest - ConfigItem 3 Version 4',
                    'Production',
                    'Operational',
                    'Ϋ δ λ',
                    'π χ Ϙ',
                    'Ϻ ϱ Ϯ',
                    'ɯ ʓ ʠ',
                    'ʬ ʯ',
                    'й ф щ',
                    'њ ё',
                    'Ѭ Ѧ',
                ],
                UserID => 1,
            },
        },
        ReferenceImportData => {
            VersionNumber => 4,
            LastVersion   => {
                Name                                          => 'UnitTest - ConfigItem 3 Version 4',
                DeplState                                     => 'Production',
                InciState                                     => 'Operational',
                'Main1::1'                                    => 'Ϋ δ λ',
                'Main1::1::Main1Sub1::1'                      => 'π χ Ϙ',
                'Main1::1::Main1Sub1::1::Main1Sub1SubSub1::1' => 'Ϻ ϱ Ϯ',
                'Main1::1::Main1Sub1::1::Main1Sub1SubSub2::1' => 'ɯ ʓ ʠ',
                'Main1::1::Main1Sub2::1'                      => 'ʬ ʯ',
                'Main2::1'                                    => 'й ф щ',
                'Main2::1::Main2Sub1::1'                      => 'њ ё',
                'Main2::1::Main2Sub2::1'                      => 'Ѭ Ѧ',

                # lingering from 'UnitTest - ConfigItem 3 Version 2',
                'Main1::1::Main1Sub1::1::Main1Sub1SubSub1::2' =>
                    'Main1 (1) Main1Sub1 (1) Main1Sub1SubSub1 (2)',
                'Main1::1::Main1Sub1::1::Main1Sub1SubSub1::3' =>
                    'Main1 (1) Main1Sub1 (1) Main1Sub1SubSub1 (3)',
                'Main1::1::Main1Sub1::2'                      => 'Main1 (1) Main1Sub1 (2)',
                'Main1::1::Main1Sub1::2::Main1Sub1SubSub1::1' =>
                    'Main1 (1) Main1Sub1 (2) Main1Sub1SubSub1 (1)',
                'Main1::1::Main1Sub1::2::Main1Sub1SubSub2::1' =>
                    'Main1 (1) Main1Sub1 (2) Main1Sub1SubSub2 (1)',
                'Main1::1::Main1Sub1::2::Main1Sub1SubSub2::2' =>
                    'Main1 (1) Main1Sub1 (2) Main1Sub1SubSub2 (2)',
                'Main1::1::Main1Sub2::2' => 'Main1 (1) Main1Sub2 (2)',
                'Main2::1::Main2Sub2::2' => 'Main2 (1) Main2Sub2 (2)',
            },
        },
    },

    {
        Name             => q{a simple import for testing the overriding behavior of empty values},
        SourceImportData => {
            ObjectData => {
                ClassID => $ConfigItemClassIDs[0],
            },
            MappingObjectData => [
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
                    Key => 'Text1::1',
                },
                {
                    Key => 'GeneralCatalog1::1',
                },
            ],
            ImportDataSave => {
                TemplateID    => $TemplateIDs[25],
                ImportDataRow => [
                    'UnitTest - Importtest 5',
                    'Production',
                    'Operational',
                    'Importtest 5 for behavior of empty values',
                    'Test1',
                ],
                UserID => 1,
            },
        },
        ReferenceImportData => {
            VersionNumber => 1,
            LastVersion   => {
                Name                 => 'UnitTest - Importtest 5',
                DeplState            => 'Production',
                InciState            => 'Operational',
                'Text1::1'           => 'Importtest 5 for behavior of empty values',
                'GeneralCatalog1::1' => $GeneralCatalogListReverse{Test1},
            },
        },
    },

    # import an empty value for Text1, with EmptyFieldsLeaveTheOldValues turned on
    # no new version should be created
    {
        Name             => 'import an empty value for Text1',
        SourceImportData => {
            ObjectData => {
                ClassID                      => $ConfigItemClassIDs[0],
                EmptyFieldsLeaveTheOldValues => 'on',
            },
            MappingObjectData => [
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
                    Key => 'Text1::1',
                },
                {
                    Key => 'GeneralCatalog1::1',
                },
            ],
            ImportDataSave => {
                TemplateID    => $TemplateIDs[25],
                ImportDataRow => [
                    'UnitTest - Importtest 5',
                    'Production',
                    'Operational',
                    '',
                    'Test1',
                ],
                UserID => 1,
            },
        },
        ReferenceImportData => {
            VersionNumber => 1,
            LastVersion   => {
                Name                 => 'UnitTest - Importtest 5',
                DeplState            => 'Production',
                InciState            => 'Operational',
                'Text1::1'           => 'Importtest 5 for behavior of empty values',
                'GeneralCatalog1::1' => $GeneralCatalogListReverse{Test1},
            },
        },
    },

    # no new version should be created
    {
        Name             => q{import undef for Text1, with EmptyFieldsLeaveTheOldValues turned on},
        SourceImportData => {
            ObjectData => {
                ClassID                      => $ConfigItemClassIDs[0],
                EmptyFieldsLeaveTheOldValues => 'on',
            },
            MappingObjectData => [
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
                    Key => 'Text1::1',
                },
                {
                    Key => 'GeneralCatalog1::1',
                },
            ],
            ImportDataSave => {
                TemplateID    => $TemplateIDs[25],
                ImportDataRow => [
                    'UnitTest - Importtest 5',
                    'Production',
                    'Operational',
                    undef,
                    'Test1',
                ],
                UserID => 1,
            },
        },
        ReferenceImportData => {
            VersionNumber => 1,
            LastVersion   => {
                Name                 => 'UnitTest - Importtest 5',
                DeplState            => 'Production',
                InciState            => 'Operational',
                'Text1::1'           => 'Importtest 5 for behavior of empty values',
                'GeneralCatalog1::1' => $GeneralCatalogListReverse{Test1},
            },
        },
    },

    # a new version should be created
    {
        Name             => q{import an empty value for Text1, with EmptyFieldsLeaveTheOldValues turned off},
        SourceImportData => {
            ObjectData => {
                ClassID                      => $ConfigItemClassIDs[0],
                EmptyFieldsLeaveTheOldValues => '',
            },
            MappingObjectData => [
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
                    Key => 'Text1::1',
                },
                {
                    Key => 'GeneralCatalog1::1',
                },
            ],
            ImportDataSave => {
                TemplateID    => $TemplateIDs[25],
                ImportDataRow => [
                    'UnitTest - Importtest 5',
                    'Production',
                    'Operational',
                    '',
                    'Test1',
                ],
                UserID => 1,
            },
        },
        ReferenceImportData => {
            VersionNumber => 2,
            LastVersion   => {
                Name                 => 'UnitTest - Importtest 5',
                DeplState            => 'Production',
                InciState            => 'Operational',
                'Text1::1'           => '',
                'GeneralCatalog1::1' => $GeneralCatalogListReverse{Test1},
            },
        },
    },

    # a new version should be created
    {
        Name             => q{import a single space value for Text1, with EmptyFieldsLeaveTheOldValues turned on},
        SourceImportData => {
            ObjectData => {
                ClassID                      => $ConfigItemClassIDs[0],
                EmptyFieldsLeaveTheOldValues => '',
            },
            MappingObjectData => [
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
                    Key => 'Text1::1',
                },
                {
                    Key => 'GeneralCatalog1::1',
                },
            ],
            ImportDataSave => {
                TemplateID    => $TemplateIDs[25],
                ImportDataRow => [
                    'UnitTest - Importtest 5',
                    'Production',
                    'Operational',
                    ' ',
                    'Test1',
                ],
                UserID => 1,
            },
        },
        ReferenceImportData => {
            VersionNumber => 3,
            LastVersion   => {
                Name                 => 'UnitTest - Importtest 5',
                DeplState            => 'Production',
                InciState            => 'Operational',
                'Text1::1'           => ' ',
                'GeneralCatalog1::1' => $GeneralCatalogListReverse{Test1},
            },
        },
    },

    # a new version should be created
    {
        Name             => q{import the string '0' value for Text1, with EmptyFieldsLeaveTheOldValues turned on},
        SourceImportData => {
            ObjectData => {
                ClassID                      => $ConfigItemClassIDs[0],
                EmptyFieldsLeaveTheOldValues => '',
            },
            MappingObjectData => [
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
                    Key => 'Text1::1',
                },
                {
                    Key => 'GeneralCatalog1::1',
                },
            ],
            ImportDataSave => {
                TemplateID    => $TemplateIDs[25],
                ImportDataRow => [
                    'UnitTest - Importtest 5',
                    'Production',
                    'Operational',
                    '0',
                    'Test1',
                ],
                UserID => 1,
            },
        },
        ReferenceImportData => {
            VersionNumber => 4,
            LastVersion   => {
                Name                 => 'UnitTest - Importtest 5',
                DeplState            => 'Production',
                InciState            => 'Operational',
                'Text1::1'           => '0',
                'GeneralCatalog1::1' => $GeneralCatalogListReverse{Test1},
            },
        },
    },

    # no new version should be created
    {
        Name             => q{import an empty value for GeneralCatalog1, with EmptyFieldsLeaveTheOldValues turned on},
        SourceImportData => {
            ObjectData => {
                ClassID                      => $ConfigItemClassIDs[0],
                EmptyFieldsLeaveTheOldValues => 'on',
            },
            MappingObjectData => [
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
                    Key => 'Text1::1',
                },
                {
                    Key => 'GeneralCatalog1::1',
                },
            ],
            ImportDataSave => {
                TemplateID    => $TemplateIDs[25],
                ImportDataRow => [
                    'UnitTest - Importtest 5',
                    'Production',
                    'Operational',
                    '',
                    '',
                ],
                UserID => 1,
            },
        },
        ReferenceImportData => {
            VersionNumber => 4,
            LastVersion   => {
                Name                 => 'UnitTest - Importtest 5',
                DeplState            => 'Production',
                InciState            => 'Operational',
                'Text1::1'           => '0',
                'GeneralCatalog1::1' => $GeneralCatalogListReverse{Test1},
            },
        },
    },

    # the import should fail
    {
        Name             => q{import an invalid value for GeneralCatalog1, with EmptyFieldsLeaveTheOldValues turned on},
        SourceImportData => {
            ObjectData => {
                ClassID                      => $ConfigItemClassIDs[0],
                EmptyFieldsLeaveTheOldValues => 'on',
            },
            MappingObjectData => [
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
                    Key => 'Text1::1',
                },
                {
                    Key => 'GeneralCatalog1::1',
                },
            ],
            ImportDataSave => {
                TemplateID    => $TemplateIDs[25],
                ImportDataRow => [
                    'UnitTest - Importtest 5',
                    'Production',
                    'Operational',
                    '',
                    'non-existent general catalog entry',
                ],
                UserID => 1,
            },
        },
    },

    # the import should fail
    {
        Name             => q{import an invalid value for GeneralCatalog1, with EmptyFieldsLeaveTheOldValues turned off},
        SourceImportData => {
            ObjectData => {
                ClassID                      => $ConfigItemClassIDs[0],
                EmptyFieldsLeaveTheOldValues => '',
            },
            MappingObjectData => [
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
                    Key => 'Text1::1',
                },
                {
                    Key => 'GeneralCatalog1::1',
                },
            ],
            ImportDataSave => {
                TemplateID    => $TemplateIDs[25],
                ImportDataRow => [
                    'UnitTest - Importtest 5',
                    'Production',
                    'Operational',
                    '',
                    'non-existent general catalog entry',
                ],
                UserID => 1,
            },
        },
    },

    # no new version should be created
    {
        Name             => q{import an empty value for DeplState, with EmptyFieldsLeaveTheOldValues turned on},
        SourceImportData => {
            ObjectData => {
                ClassID                      => $ConfigItemClassIDs[0],
                EmptyFieldsLeaveTheOldValues => 'on',
            },
            MappingObjectData => [
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
                    Key => 'Text1::1',
                },
                {
                    Key => 'GeneralCatalog1::1',
                },
            ],
            ImportDataSave => {
                TemplateID    => $TemplateIDs[25],
                ImportDataRow => [
                    'UnitTest - Importtest 5',
                    '',
                    'Operational',
                    '',
                    '',
                ],
                UserID => 1,
            },
        },
        ReferenceImportData => {
            VersionNumber => 4,
            LastVersion   => {
                Name                 => 'UnitTest - Importtest 5',
                DeplState            => 'Production',
                InciState            => 'Operational',
                'Text1::1'           => '0',
                'GeneralCatalog1::1' => $GeneralCatalogListReverse{Test1},
            },
        },
    },

    # an error should be generated
    {
        Name             => q{import an invalid value for DeplState, with EmptyFieldsLeaveTheOldValues turned on},
        SourceImportData => {
            ObjectData => {
                ClassID                      => $ConfigItemClassIDs[0],
                EmptyFieldsLeaveTheOldValues => 'on',
            },
            MappingObjectData => [
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
                    Key => 'Text1::1',
                },
                {
                    Key => 'GeneralCatalog1::1',
                },
            ],
            ImportDataSave => {
                TemplateID    => $TemplateIDs[25],
                ImportDataRow => [
                    'UnitTest - Importtest 5',
                    'invalid deployment state',
                    'Operational',
                    '',
                    '',
                ],
                UserID => 1,
            },
        },
    },

    # no new version should be created
    {
        Name             => q{import an empty value for InciState, with EmptyFieldsLeaveTheOldValues turned on},
        SourceImportData => {
            ObjectData => {
                ClassID                      => $ConfigItemClassIDs[0],
                EmptyFieldsLeaveTheOldValues => 'on',
            },
            MappingObjectData => [
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
                    Key => 'Text1::1',
                },
                {
                    Key => 'GeneralCatalog1::1',
                },
            ],
            ImportDataSave => {
                TemplateID    => $TemplateIDs[25],
                ImportDataRow => [
                    'UnitTest - Importtest 5',
                    'Production',
                    '',
                    '',
                    '',
                ],
                UserID => 1,
            },
        },
        ReferenceImportData => {
            VersionNumber => 4,
            LastVersion   => {
                Name                 => 'UnitTest - Importtest 5',
                DeplState            => 'Production',
                InciState            => 'Operational',
                'Text1::1'           => '0',
                'GeneralCatalog1::1' => $GeneralCatalogListReverse{Test1},
            },
        },
    },

    # an error should be generated
    {
        Name             => q{import an invalid value for InciState, with EmptyFieldsLeaveTheOldValues turned on},
        SourceImportData => {
            ObjectData => {
                ClassID                      => $ConfigItemClassIDs[0],
                EmptyFieldsLeaveTheOldValues => 'on',
            },
            MappingObjectData => [
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
                    Key => 'Text1::1',
                },
                {
                    Key => 'GeneralCatalog1::1',
                },
            ],
            ImportDataSave => {
                TemplateID    => $TemplateIDs[25],
                ImportDataRow => [
                    'UnitTest - Importtest 5',
                    'Production',
                    'invalid incident state',
                    '',
                    '',
                ],
                UserID => 1,
            },
        },
    },

    {
        Name             => q{Import without required attribute 'Type', an error should be generated (see bug#14098).},
        SourceImportData => {
            ObjectData => {
                ClassID                      => $ConfigItemClassIDs[2],
                EmptyFieldsLeaveTheOldValues => '',
            },
            MappingObjectData => [
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
            ],
            ImportDataSave => {
                TemplateID    => $TemplateIDs[25],
                ImportDataRow => [
                    'UnitTest - Importtest 5',
                    'Production',
                    'Operational',
                ],
                UserID => 1,
            },
        },
    },

=cut

# run general ImportDataTests tests
my $ImportTestCount = 0;
for my $Test (@ImportDataTests) {

    subtest "ImportData: $Test->{Name}" => sub {

        # check SourceImportData attribute
        if ( !$Test->{SourceImportData} || ref $Test->{SourceImportData} ne 'HASH' ) {

            fail("SourceImportData not found for this test.");

            return;
        }

        # set the object data
        if (
            $Test->{SourceImportData}->{ObjectData}
            && ref $Test->{SourceImportData}->{ObjectData} eq 'HASH'
            && $Test->{SourceImportData}->{ImportDataSave}->{TemplateID}
            )
        {

            # save object data
            $ImportExportObject->ObjectDataSave(
                TemplateID => $Test->{SourceImportData}->{ImportDataSave}->{TemplateID},
                ObjectData => $Test->{SourceImportData}->{ObjectData},
                UserID     => 1,
            );
        }

        # set the mapping object data
        if (
            $Test->{SourceImportData}->{MappingObjectData}
            && ref $Test->{SourceImportData}->{MappingObjectData} eq 'ARRAY'
            && $Test->{SourceImportData}->{ImportDataSave}->{TemplateID}
            )
        {

            # delete all existing mapping data
            $ImportExportObject->MappingDelete(
                TemplateID => $Test->{SourceImportData}->{ImportDataSave}->{TemplateID},
                UserID     => 1,
            );

            # add the mapping object rows
            MAPPINGOBJECTDATA:
            for my $MappingObjectData ( @{ $Test->{SourceImportData}->{MappingObjectData} } ) {

                # add a new mapping row
                my $MappingID = $ImportExportObject->MappingAdd(
                    TemplateID => $Test->{SourceImportData}->{ImportDataSave}->{TemplateID},
                    UserID     => 1,
                );

                # add the mapping object data
                $ImportExportObject->MappingObjectDataSave(
                    MappingID         => $MappingID,
                    MappingObjectData => $MappingObjectData,
                    UserID            => 1,
                );
            }
        }

        # import data save
        my ( $ConfigItemID, $RetCode ) = $ObjectBackendObject->ImportDataSave(
            %{ $Test->{SourceImportData}->{ImportDataSave} },
            Counter => $ImportTestCount,
        );

        if ( !$Test->{ReferenceImportData} ) {

            ok( !$ConfigItemID, "ImportDataSave() - return no ConfigItemID" );
            ok( !$RetCode,      "ImportDataSave() - return no RetCode" );

            return;
        }

        ok( $ConfigItemID, "ImportDataSave() - return ConfigItemID" );
        ok( $RetCode,      "ImportDataSave() - return RetCode" );

        # get the version list
        my $VersionList = $ConfigItemObject->VersionList(
            ConfigItemID => $ConfigItemID,
        ) // [];

        # check number of versions
        is(
            scalar @{$VersionList},
            $Test->{ReferenceImportData}->{VersionNumber} || 0,
            "ImportDataSave() - correct number of versions",
        );

        # get the last version
        my $VersionData = $ConfigItemObject->VersionGet(
            ConfigItemID => $ConfigItemID,
            XMLDataGet   => 1,
        );

        # translate xmldata in a 2d hash
        # TODO: check the data
        my %XMLHash;

        # clean the xml hash
        KEY:
        for my $Key ( sort keys %XMLHash ) {

            next KEY if $Key =~ m{ \{'Content'\} \z }xms;

            delete $XMLHash{$Key};
        }

        # check general elements
        ELEMENT:
        for my $Element (qw(Number Name DeplState InciState)) {

            next ELEMENT if !exists $Test->{ReferenceImportData}->{LastVersion}->{$Element};

            # set content if values are undef
            if ( !defined $Test->{ReferenceImportData}->{LastVersion}->{$Element} ) {
                $Test->{ReferenceImportData}->{LastVersion}->{$Element} = 'UNDEF-unittest';
            }
            if ( !defined $Test->{ReferenceImportData}->{LastVersion}->{$Element} ) {
                $Test->{ReferenceImportData}->{LastVersion}->{$Element} = 'UNDEF-unittest';
            }

            # check element
            is(
                $VersionData->{$Element},
                $Test->{ReferenceImportData}->{LastVersion}->{$Element},
                "ImportDataSave() $Element is identical",
            );

            delete $Test->{ReferenceImportData}->{LastVersion}->{$Element};
        }

        # check number of XML elements
        is(
            scalar keys %XMLHash,
            scalar keys %{ $Test->{ReferenceImportData}->{LastVersion} },
            "ImportDataSave() - correct number of XML elements",
        );

        # check XML elements
        ELEMENT:
        for my $Key ( sort keys %{ $Test->{ReferenceImportData}->{LastVersion} } ) {

            # duplicate key
            my $XMLKey = $Key;

            # prepare key
            my $Counter = 0;
            while ( $XMLKey =~ m{ :: }xms ) {

                if ( $Counter % 2 ) {
                    $XMLKey =~ s{ :: }{]\{'}xms;
                }
                else {
                    $XMLKey =~ s{ :: }{'\}[}xms;
                }

                $Counter++;
            }

            next ELEMENT if !exists $XMLHash{ '[1]{\'Version\'}[1]{\'' . $XMLKey . ']{\'Content\'}' };

            # set content if values are undef
            if ( !defined $XMLHash{ '[1]{\'Version\'}[1]{\'' . $XMLKey . ']{\'Content\'}' } ) {
                $XMLHash{ '[1]{\'Version\'}[1]{\'' . $XMLKey . ']{\'Content\'}' } = 'UNDEF-unittest';
            }
            if ( !defined $Test->{ReferenceImportData}->{LastVersion}->{$Key} ) {
                $Test->{ReferenceImportData}->{LastVersion}->{$Key} = 'UNDEF-unittest';
            }

            # check XML element
            is(
                $XMLHash{ '[1]{\'Version\'}[1]{\'' . $XMLKey . ']{\'Content\'}' },
                $Test->{ReferenceImportData}->{LastVersion}->{$Key},
                "ImportDataSave() $Key is identical",
            );
        }
    };
}
continue {
    $ImportTestCount++;
}

done_testing;

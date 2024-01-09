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
use Kernel::System::UnitTest::RegisterDriver;    # Set up $Kernel::OM and the test driver $Self

our $Self;

# get needed objects
my $DBObject             = $Kernel::OM->Get('Kernel::System::DB');
my $ConfigObject         = $Kernel::OM->Get('Kernel::Config');
my $ConfigItemObject     = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');
my $GeneralCatalogObject = $Kernel::OM->Get('Kernel::System::GeneralCatalog');
my $DynamicFieldObject   = $Kernel::OM->Get('Kernel::System::DynamicField');
my $UserObject           = $Kernel::OM->Get('Kernel::System::User');

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

# create needed users
my @UserIDs;
{

    # disable email checks to create new user
    my $CheckEmailAddressesOrg = $ConfigObject->Get('CheckEmailAddresses') || 1;
    $ConfigObject->Set(
        Key   => 'CheckEmailAddresses',
        Value => 0,
    );

    for my $Counter ( 1 .. 3 ) {

        # create new users for the tests
        my $UserID = $UserObject->UserAdd(
            UserFirstname => 'ITSMConfigItem' . $Counter,
            UserLastname  => 'UnitTest',
            UserLogin     => 'UnitTest-ITSMConfigItem-' . $Counter . $RandomID,
            UserEmail     => 'UnitTest-ITSMConfigItem-' . $Counter . '@localhost',
            ValidID       => 1,
            ChangeUserID  => 1,
        );

        push @UserIDs, $UserID;
    }

    # restore original email check param
    $ConfigObject->Set(
        Key   => 'CheckEmailAddresses',
        Value => $CheckEmailAddressesOrg,
    );
}

my $TestIDSuffix = 'UnitTest' . $RandomID;
my $Order        = 10000;

my %DynamicFieldDefinitions = (
    Test1 => {
        'DefaultValue' => '',
        'RegExList'    => [],
        'MultiValue'   => '0',
        'Link'         => '',
        'Tooltip'      => '',
        'LinkPreview'  => '',
        'FieldType'    => 'Text'
    },
    Test2 => {
        'Link'               => '',
        'Tooltip'            => '',
        'PossibleNone'       => '1',
        'MultiValue'         => '1',
        'DefaultValue'       => '',
        'TranslatableValues' => '0',
        'PossibleValues'     => {
            'VALUE 1' => 'VALUE 1',
            'VALUE 2' => 'VALUE 2'
        },
        'TreeView'    => '1',
        'LinkPreview' => '',
        'FieldType'   => 'Dropdown'
    },
    Test3 => {
        'YearsInFuture'   => '5',
        'DateRestriction' => '',
        'YearsPeriod'     => '0',
        'LinkPreview'     => '',
        'YearsInPast'     => '5',
        'MultiValue'      => '0',
        'DefaultValue'    => 0,
        'Link'            => '',
        'Tooltip'         => '',
        'FieldType'       => 'Date'
    },
    Test4 => {
        'Cols'         => '',
        'Rows'         => '',
        'DefaultValue' => '',
        'RegExList'    => [],
        'MultiValue'   => '0',
        'Tooltip'      => '',
        'FieldType'    => 'TextArea'
    },
    Test5 => {
        'YearsInFuture'   => '5',
        'DateRestriction' => '',
        'YearsPeriod'     => '0',
        'LinkPreview'     => '',
        'YearsInPast'     => '5',
        'MultiValue'      => '0',
        'DefaultValue'    => 0,
        'Link'            => '',
        'Tooltip'         => '',
        'FieldType'       => 'DateTime'
    },
);

# Add dynamic fields for testing. These dynamic fields will be referenced
# by name in dynamic field definitions.
for my $Name ( sort keys %DynamicFieldDefinitions ) {
    my $DFName = $Name . $TestIDSuffix;
    my $ItemID = $DynamicFieldObject->DynamicFieldAdd(
        InternalField => 0,
        Name          => $DFName,
        Label         => $DFName,
        FieldOrder    => $Order++,
        FieldType     => $DynamicFieldDefinitions{$Name}->{FieldType},
        ObjectType    => 'ITSMConfigItem',
        Config        => $DynamicFieldDefinitions{$Name},
        Reorder       => 1,
        ValidID       => 1,
        UserID        => 1,
    );
    ok( $ItemID, "created dynamic field $DFName" );
}

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
                        DF => 'Test1$TestIDSuffix'
                    },
                    {
                        DF => 'Test2$TestIDSuffix'
                    }
                ]
            }
        },
}
]";

# define the third test definition (especially for search tests with XMLData)
$ConfigItemPerlDefinitions[2] = " [
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
        ],
        Sections => {
            Section1 => {
                Content => [
                    {
                        DF => 'Test1$TestIDSuffix'
                    },
                    {
                        DF => 'Test2$TestIDSuffix'
                    }
                ]
            },
            Section2 => {
                Content => [
                    {
                        DF => 'Test3$TestIDSuffix'
                    },
                    {
                        DF => 'Test4$TestIDSuffix'
                    }
                ]
            }
        },
}
]";

# define the fourth test definition (only for search tests)
$ConfigItemPerlDefinitions[3] = " [
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
        ],
        Sections => {
            Section1 => {
                Content => [
                    {
                        DF => 'Test1$TestIDSuffix'
                    },
                    {
                        DF => 'Test2$TestIDSuffix'
                    }
                ]
            },
            Section2 => {
                Content => [
                    {
                        DF => 'Test3$TestIDSuffix'
                    },
                    {
                        DF => 'Test4$TestIDSuffix'
                    }
                ]
            }
        },
}
]";

# define the fifth test definition (only for search tests)

$ConfigItemPerlDefinitions[4] = " [
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
                    },
                ],
            }
        ],
        Sections => {
            Section1 => {
                Content => [
                    {
                        DF => 'Test5$TestIDSuffix'
                    },
                ]
            },
        },
}
]";

# define the sixth test definition (only for search tests)

$ConfigItemPerlDefinitions[5] = " [
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
                    },
                ],
            }
        ],
        Sections => {
            Section1 => {
                Content => [
                    {
                        DF => 'Test1$TestIDSuffix'
                    },
                    {
                        DF => 'Test4$TestIDSuffix'
                    }
                ]
            },
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

# add the test classes
my @ConfigItemClassIDs;
my @ConfigItemClasses;
my @ConfigItemDefinitionIDs;
for my $Definition (@ConfigItemDefinitions) {

    # generate a random name
    my $ClassName = 'UnitTest' . $Helper->GetRandomID();

    # add an unittest config item class
    my $ClassID = $GeneralCatalogObject->ItemAdd(
        Class   => 'ITSM::ConfigItem::Class',
        Name    => $ClassName,
        ValidID => 1,
        UserID  => 1,
    );

    # check class id
    if ( !$ClassID ) {

        $Self->True(
            0,
            "Can't add new config item class.",
        );
    }

    push @ConfigItemClassIDs, $ClassID;
    push @ConfigItemClasses,  $ClassName;

    # add a definition to the class
    my $Result = $ConfigItemObject->DefinitionAdd(
        ClassID    => $ClassID,
        Definition => $Definition,
        UserID     => 1,
    );
    ok( $Result->{Success},      'added new config item definition' );
    ok( $Result->{DefinitionID}, 'got a definition ID' );

    push @ConfigItemDefinitionIDs, $Result->{DefinitionID};
}

# test DefinitionList for those simple cases
my $Counter = 0;
for my $ClassID (@ConfigItemClassIDs) {
    my $DefinitionListRef = $ConfigItemObject->DefinitionList(
        ClassID => $ClassID,
    );

    # expect a single definition per config item class
    $Self->Is(
        scalar @{$DefinitionListRef},
        1,
        "DefinitionList() for class id $ClassID: got a single result",
    );

    # expect the remembered definition id in the first definition
    $Self->Is(
        $DefinitionListRef->[0]->{DefinitionID},
        $ConfigItemDefinitionIDs[$Counter],
        "DefinitionList() for class id $ClassID: got expected definition id",
    );

    $Counter++;
}

# create some random numbers
my @ConfigItemNumbers;
for ( 1 .. 100 ) {
    push @ConfigItemNumbers, $Helper->GetRandomNumber();
}

# get class list
my $ClassList = $GeneralCatalogObject->ItemList(
    Class => 'ITSM::ConfigItem::Class',
);
my %ClassListReverse = reverse %{$ClassList};

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

# ------------------------------------------------------------ #
# define general config item tests
# ------------------------------------------------------------ #

my $ConfigItemTests = [

    #ConfigItemAdd doesn't contains all data (check required attributes)
    {
        SourceData => {
            ConfigItemAdd => {
                UserID => 1,
            },
        },
    },

    # ConfigItemAdd doesn't contains all data (check required attributes)
    {
        SourceData => {
            ConfigItemAdd => {
                ClassID => $ConfigItemClassIDs[0],
            },
        },
    },

    # invalid class id is given (check return false)
    {
        SourceData => {
            ConfigItemAdd => {
                ClassID => $ConfigItemClassIDs[-1] + 1,
                UserID  => 1,
            },
        },
    },

    # all required config item values are given (check returned config item values)
    {
        SourceData => {
            ConfigItemAdd => {
                ClassID     => $ConfigItemClassIDs[0],
                DeplStateID => $DeplStateListReverse{Production},
                InciStateID => $InciStateListReverse{Operational},
                Name        => "UnitTest - $ClassList->{ $ConfigItemClassIDs[0] } - 1",
                UserID      => 1,
            },
        },
        ReferenceData => {
            ConfigItemGet => {
                ClassID      => $ConfigItemClassIDs[0],
                Class        => $ClassList->{ $ConfigItemClassIDs[0] },
                CurDeplState => 'Production',
                CurInciState => 'Operational',
                CreateBy     => 1,
                ChangeBy     => 1,
            },
        },
    },

    # all required config item values are given (check number attribute)
    {
        SourceData => {
            ConfigItemAdd => {
                Number      => $ConfigItemNumbers[0],
                ClassID     => $ConfigItemClassIDs[0],
                DeplStateID => $DeplStateListReverse{Production},
                InciStateID => $InciStateListReverse{Operational},
                Name        => "UnitTest - $ClassList->{ $ConfigItemClassIDs[0] } - 2",
                UserID      => $UserIDs[1],
            },
        },
        ReferenceData => {
            ConfigItemGet => {
                Number       => $ConfigItemNumbers[0],
                ClassID      => $ConfigItemClassIDs[0],
                Class        => $ClassList->{ $ConfigItemClassIDs[0] },
                CurDeplState => 'Production',
                CurInciState => 'Operational',
                CreateBy     => $UserIDs[1],
                ChangeBy     => $UserIDs[1],
            },
        },
    },

    # config item with this number already exists (check return false)
    {
        SourceData => {
            ConfigItemAdd => {
                Number      => $ConfigItemNumbers[0],
                ClassID     => $ConfigItemClassIDs[0],
                DeplStateID => $DeplStateListReverse{Production},
                InciStateID => $InciStateListReverse{Operational},
                Name        => "UnitTest - $ClassList->{ $ConfigItemClassIDs[0] } - 3",
                UserID      => 1,
            },
        },
    },

    # all required config item values are given plus not defined DynamicFields
    {
        SourceData => {
            ConfigItemAdd => {
                Number      => $ConfigItemNumbers[35],
                DeplStateID => $DeplStateListReverse{Production},
                InciStateID => $InciStateListReverse{Operational},
                ClassID     => $ConfigItemClassIDs[0],
                Name        => "UnitTest - $ClassList->{ $ConfigItemClassIDs[0] } - 35",
                UserID      => 1,
            },
        },
        ReferenceData => {
            ConfigItemGet => {
                Number       => $ConfigItemNumbers[35],
                ClassID      => $ConfigItemClassIDs[0],
                Class        => $ClassList->{ $ConfigItemClassIDs[0] },
                CurDeplState => 'Production',
                CurInciState => 'Operational',
                CreateBy     => 1,
                ChangeBy     => 1,
            },
        },
    },

    # VersionAdd doesn't contains all data (check required attributes) (Missing UserID)
    {
        SourceData => {
            ConfigItemAdd => {
                Number      => $ConfigItemNumbers[1],
                ClassID     => $ConfigItemClassIDs[0],
                DeplStateID => $DeplStateListReverse{Production},
                InciStateID => $InciStateListReverse{Operational},
                Name        => "UnitTest - $ClassList->{ $ConfigItemClassIDs[0] } - 4",
                UserID      => $UserIDs[1],
            },
            VersionAdd => [
                {
                    DeplStateID => $DeplStateListReverse{Production},
                    InciStateID => $InciStateListReverse{Operational},
                },
            ],
        },
        ReferenceData => {
            ConfigItemGet => {
                Number       => $ConfigItemNumbers[1],
                ClassID      => $ConfigItemClassIDs[0],
                Class        => $ClassList->{ $ConfigItemClassIDs[0] },
                CurDeplState => 'Production',
                CurInciState => 'Operational',
                CreateBy     => $UserIDs[1],
                ChangeBy     => $UserIDs[1],
            },
        },
    },

    # Invalid deployment state id is given (check required attributes)
    {
        SourceData => {
            ConfigItemAdd => {
                Number      => $ConfigItemNumbers[2],
                ClassID     => $ConfigItemClassIDs[0],
                DeplStateID => $DeplStateListReverse{Production},
                InciStateID => $InciStateListReverse{Operational},
                Name        => "UnitTest - $ClassList->{ $ConfigItemClassIDs[0] } - 5",
                UserID      => $UserIDs[2],
            },
            VersionAdd => [
                {
                    Name        => "UnitTest - $ClassList->{ $ConfigItemClassIDs[0] } - 5",
                    DeplStateID => undef,
                    InciStateID => $InciStateListReverse{Operational},
                    UserID      => $UserIDs[2],
                },
            ],
        },
        ReferenceData => {
            ConfigItemGet => {
                Number       => $ConfigItemNumbers[2],
                ClassID      => $ConfigItemClassIDs[0],
                Class        => $ClassList->{ $ConfigItemClassIDs[0] },
                CurDeplState => 'Production',
                CurInciState => 'Operational',
                CreateBy     => $UserIDs[2],
                ChangeBy     => $UserIDs[2],
            },
        },
    },

    # Invalid incident state id is given (check required attributes)
    {
        SourceData => {
            ConfigItemAdd => {
                Number      => $ConfigItemNumbers[3],
                ClassID     => $ConfigItemClassIDs[0],
                DeplStateID => $DeplStateListReverse{Production},
                InciStateID => $InciStateListReverse{Operational},
                Name        => "UnitTest - $ClassList->{ $ConfigItemClassIDs[0] } - 6",
                UserID      => $UserIDs[2],
            },
            VersionAdd => [
                {
                    DeplStateID => $DeplStateListReverse{Production},
                    InciStateID => undef,
                    UserID      => $UserIDs[2],
                },
            ],
        },
        ReferenceData => {
            ConfigItemGet => {
                Number       => $ConfigItemNumbers[3],
                ClassID      => $ConfigItemClassIDs[0],
                Class        => $ClassList->{ $ConfigItemClassIDs[0] },
                CurDeplState => 'Production',
                CurInciState => 'Operational',
                CreateBy     => $UserIDs[2],
                ChangeBy     => $UserIDs[2],
            },
        },
    },

    # all required values are given (general check with two versions)
    {
        SourceData => {
            ConfigItemAdd => {
                Number      => $ConfigItemNumbers[9],
                DeplStateID => $DeplStateListReverse{Production},
                InciStateID => $InciStateListReverse{Operational},
                ClassID     => $ConfigItemClassIDs[0],
                Name        => "UnitTest - $ClassList->{ $ConfigItemClassIDs[0] } - 7",
                UserID      => 1,
            },
            VersionAdd => [
                {
                    Name        => "UnitTest - Class $ConfigItemClassIDs[0] ConfigItem 9 Version 1",
                    DeplStateID => $DeplStateListReverse{Production},
                    InciStateID => $InciStateListReverse{Operational},
                    UserID      => 1,
                },
                {
                    Name        => "UnitTest - Class $ConfigItemClassIDs[0] ConfigItem 9 Version 2",
                    DeplStateID => $DeplStateListReverse{Production},
                    InciStateID => $InciStateListReverse{Operational},
                    UserID      => $UserIDs[1],
                },
            ],
        },
        ReferenceData => {
            ConfigItemGet => {
                Number           => $ConfigItemNumbers[9],
                ClassID          => $ConfigItemClassIDs[0],
                Class            => $ClassList->{ $ConfigItemClassIDs[0] },
                CurDeplStateID   => $DeplStateListReverse{Production},
                CurDeplState     => 'Production',
                CurDeplStateType => 'productive',
                CurInciStateID   => $InciStateListReverse{Operational},
                CurInciState     => 'Operational',
                CurInciStateType => 'operational',
                CreateBy         => 1,
                ChangeBy         => $UserIDs[1],
            },
            VersionGet => [
                {
                    Number           => $ConfigItemNumbers[9],
                    ClassID          => $ConfigItemClassIDs[0],
                    Class            => $ClassList->{ $ConfigItemClassIDs[0] },
                    Name             => "UnitTest - Class $ConfigItemClassIDs[0] ConfigItem 9 Version 1",
                    DefinitionID     => $ConfigItemDefinitionIDs[0],
                    DeplStateID      => $DeplStateListReverse{Production},
                    DeplState        => 'Production',
                    DeplStateType    => 'productive',
                    CurDeplStateID   => $DeplStateListReverse{Production},
                    CurDeplState     => 'Production',
                    CurDeplStateType => 'productive',
                    InciStateID      => $InciStateListReverse{Operational},
                    InciState        => 'Operational',
                    InciStateType    => 'operational',
                    CurInciStateID   => $InciStateListReverse{Operational},
                    CurInciState     => 'Operational',
                    CurInciStateType => 'operational',
                    CreateBy         => 1,
                },
                {
                    Number           => $ConfigItemNumbers[9],
                    ClassID          => $ConfigItemClassIDs[0],
                    Class            => $ClassList->{ $ConfigItemClassIDs[0] },
                    Name             => "UnitTest - Class $ConfigItemClassIDs[0] ConfigItem 9 Version 2",
                    DefinitionID     => $ConfigItemDefinitionIDs[0],
                    DeplStateID      => $DeplStateListReverse{Production},
                    DeplState        => 'Production',
                    DeplStateType    => 'productive',
                    CurDeplStateID   => $DeplStateListReverse{Production},
                    CurDeplState     => 'Production',
                    CurDeplStateType => 'productive',
                    InciStateID      => $InciStateListReverse{Operational},
                    InciState        => 'Operational',
                    InciStateType    => 'operational',
                    CurInciStateID   => $InciStateListReverse{Operational},
                    CurInciState     => 'Operational',
                    CurInciStateType => 'operational',
                    CreateBy         => $UserIDs[1],
                },
            ],
        },
    },

    # all required values are given (check the calculation of deployment and incident state)
    {
        SourceData => {
            ConfigItemAdd => {
                Number      => $ConfigItemNumbers[10],
                DeplStateID => $DeplStateListReverse{Maintenance},
                InciStateID => $InciStateListReverse{Incident},
                ClassID     => $ConfigItemClassIDs[0],
                Name        => "UnitTest - $ClassList->{ $ConfigItemClassIDs[0] } - 8",
                UserID      => 1,
            },
            VersionAdd => [
                {
                    Name        => "UnitTest - Class $ConfigItemClassIDs[0] ConfigItem 10 Version 1",
                    DeplStateID => $DeplStateListReverse{Planned},
                    InciStateID => $InciStateListReverse{Operational},
                    UserID      => 1,
                },
                {
                    Name        => "UnitTest - Class $ConfigItemClassIDs[0] ConfigItem 10 Version 2",
                    DeplStateID => $DeplStateListReverse{Maintenance},
                    InciStateID => $InciStateListReverse{Incident},
                    UserID      => 1,
                },
            ],
        },
        ReferenceData => {
            ConfigItemGet => {
                Number           => $ConfigItemNumbers[10],
                ClassID          => $ConfigItemClassIDs[0],
                Class            => $ClassList->{ $ConfigItemClassIDs[0] },
                CurDeplStateID   => $DeplStateListReverse{Maintenance},
                CurDeplState     => 'Maintenance',
                CurDeplStateType => 'productive',
                CurInciStateID   => $InciStateListReverse{Incident},
                CurInciState     => 'Incident',
                CurInciStateType => 'incident',
                CreateBy         => 1,
                ChangeBy         => 1,
            },
            VersionGet => [
                {
                    Number           => $ConfigItemNumbers[10],
                    ClassID          => $ConfigItemClassIDs[0],
                    Class            => $ClassList->{ $ConfigItemClassIDs[0] },
                    Name             => "UnitTest - Class $ConfigItemClassIDs[0] ConfigItem 10 Version 1",
                    DefinitionID     => $ConfigItemDefinitionIDs[0],
                    DeplStateID      => $DeplStateListReverse{Planned},
                    DeplState        => 'Planned',
                    DeplStateType    => 'preproductive',
                    CurDeplStateID   => $DeplStateListReverse{Maintenance},
                    CurDeplState     => 'Maintenance',
                    CurDeplStateType => 'productive',
                    InciStateID      => $InciStateListReverse{Operational},
                    InciState        => 'Operational',
                    InciStateType    => 'operational',
                    CurInciStateID   => $InciStateListReverse{Incident},
                    CurInciState     => 'Incident',
                    CurInciStateType => 'incident',
                    CreateBy         => 1,
                },
                {
                    Number           => $ConfigItemNumbers[10],
                    ClassID          => $ConfigItemClassIDs[0],
                    Class            => $ClassList->{ $ConfigItemClassIDs[0] },
                    Name             => "UnitTest - Class $ConfigItemClassIDs[0] ConfigItem 10 Version 2",
                    DefinitionID     => $ConfigItemDefinitionIDs[0],
                    DeplStateID      => $DeplStateListReverse{Maintenance},
                    DeplState        => 'Maintenance',
                    DeplStateType    => 'productive',
                    CurDeplStateID   => $DeplStateListReverse{Maintenance},
                    CurDeplState     => 'Maintenance',
                    CurDeplStateType => 'productive',
                    InciStateID      => $InciStateListReverse{Incident},
                    InciState        => 'Incident',
                    InciStateType    => 'incident',
                    CurInciStateID   => $InciStateListReverse{Incident},
                    CurInciState     => 'Incident',
                    CurInciStateType => 'incident',
                    CreateBy         => 1,
                },
            ],
        },
    },

    # add config item only for later search tests
    {
        SourceData => {
            ConfigItemAdd => {
                Number      => $ConfigItemNumbers[50],
                DeplStateID => $DeplStateListReverse{Production},
                InciStateID => $InciStateListReverse{Incident},
                ClassID     => $ConfigItemClassIDs[2],
                Name        => "UnitTest - $ClassList->{ $ConfigItemClassIDs[2] } - 50",
                UserID      => $UserIDs[2],
            },
            VersionAdd => [
                {
                    Name        => "UnitTest - Class $ConfigItemClassIDs[2] ConfigItem 50 Version 1",
                    DeplStateID => $DeplStateListReverse{Production},
                    InciStateID => $InciStateListReverse{Incident},
                    UserID      => $UserIDs[2],
                },
            ],
        },
        ReferenceData => {
            ConfigItemGet => {
                Number           => $ConfigItemNumbers[50],
                ClassID          => $ConfigItemClassIDs[2],
                Class            => $ClassList->{ $ConfigItemClassIDs[2] },
                CurDeplStateID   => $DeplStateListReverse{Production},
                CurDeplState     => 'Production',
                CurDeplStateType => 'productive',
                CurInciStateID   => $InciStateListReverse{Incident},
                CurInciState     => 'Incident',
                CurInciStateType => 'incident',
                CreateBy         => $UserIDs[2],
                ChangeBy         => $UserIDs[2],
            },
            VersionGet => [
                {
                    Number           => $ConfigItemNumbers[50],
                    ClassID          => $ConfigItemClassIDs[2],
                    Class            => $ClassList->{ $ConfigItemClassIDs[2] },
                    Name             => "UnitTest - Class $ConfigItemClassIDs[2] ConfigItem 50 Version 1",
                    DefinitionID     => $ConfigItemDefinitionIDs[2],
                    DeplStateID      => $DeplStateListReverse{Production},
                    DeplState        => 'Production',
                    DeplStateType    => 'productive',
                    CurDeplStateID   => $DeplStateListReverse{Production},
                    CurDeplState     => 'Production',
                    CurDeplStateType => 'productive',
                    InciStateID      => $InciStateListReverse{Incident},
                    InciState        => 'Incident',
                    InciStateType    => 'incident',
                    CurInciStateID   => $InciStateListReverse{Incident},
                    CurInciState     => 'Incident',
                    CurInciStateType => 'incident',
                    CreateBy         => $UserIDs[2],
                },
            ],
        },
    },

    # add config item only for later search tests
    {
        SourceData => {
            ConfigItemAdd => {
                Number      => $ConfigItemNumbers[51],
                DeplStateID => $DeplStateListReverse{Production},
                InciStateID => $InciStateListReverse{Operational},
                ClassID     => $ConfigItemClassIDs[2],
                Name        => "UnitTest - $ClassList->{ $ConfigItemClassIDs[2] } - 51",
                UserID      => 1,
            },
            VersionAdd => [
                {
                    Name        => "UnitTest - Class $ConfigItemClassIDs[2] ConfigItem 51 Version 1",
                    DeplStateID => $DeplStateListReverse{Production},
                    InciStateID => $InciStateListReverse{Operational},
                    UserID      => 1,
                },
                {
                    Name        => "UnitTest - Class $ConfigItemClassIDs[2] ConfigItem 51 Version 2",
                    DeplStateID => $DeplStateListReverse{Maintenance},
                    InciStateID => $InciStateListReverse{Incident},
                    UserID      => $UserIDs[1],
                },
            ],
        },
        ReferenceData => {
            ConfigItemGet => {
                Number           => $ConfigItemNumbers[51],
                ClassID          => $ConfigItemClassIDs[2],
                Class            => $ClassList->{ $ConfigItemClassIDs[2] },
                CurDeplStateID   => $DeplStateListReverse{Production},
                CurDeplState     => 'Production',
                CurDeplStateType => 'productive',
                CurInciStateID   => $InciStateListReverse{Operational},
                CurInciState     => 'Operational',
                CurInciStateType => 'operational',
                CreateBy         => 1,
                ChangeBy         => $UserIDs[1],
            },
            VersionGet => [
                {
                    Number           => $ConfigItemNumbers[51],
                    ClassID          => $ConfigItemClassIDs[2],
                    Class            => $ClassList->{ $ConfigItemClassIDs[2] },
                    Name             => "UnitTest - Class $ConfigItemClassIDs[2] ConfigItem 51 Version 1",
                    DefinitionID     => $ConfigItemDefinitionIDs[2],
                    DeplStateID      => $DeplStateListReverse{Production},
                    DeplState        => 'Production',
                    DeplStateType    => 'productive',
                    CurDeplStateID   => $DeplStateListReverse{Production},
                    CurDeplState     => 'Production',
                    CurDeplStateType => 'productive',
                    InciStateID      => $InciStateListReverse{Operational},
                    InciState        => 'Operational',
                    InciStateType    => 'operational',
                    CurInciStateID   => $InciStateListReverse{Incident},
                    CurInciState     => 'Incident',
                    CurInciStateType => 'incident',
                    CreateBy         => 1,
                },
                {
                    Number           => $ConfigItemNumbers[51],
                    ClassID          => $ConfigItemClassIDs[2],
                    Class            => $ClassList->{ $ConfigItemClassIDs[2] },
                    Name             => "UnitTest - Class $ConfigItemClassIDs[2] ConfigItem 51 Version 2",
                    DefinitionID     => $ConfigItemDefinitionIDs[2],
                    DeplStateID      => $DeplStateListReverse{Maintenance},
                    DeplState        => 'Maintenance',
                    DeplStateType    => 'productive',
                    CurDeplStateID   => $DeplStateListReverse{Production},
                    CurDeplState     => 'Production',
                    CurDeplStateType => 'productive',
                    InciStateID      => $InciStateListReverse{Incident},
                    InciState        => 'Incident',
                    InciStateType    => 'incident',
                    CurInciStateID   => $InciStateListReverse{Incident},
                    CurInciState     => 'Incident',
                    CurInciStateType => 'incident',
                    CreateBy         => $UserIDs[1],
                },
            ],
        },
    },

    # add config item only for later search tests, including DynamicFieldData
    {
        SourceData => {
            ConfigItemAdd => {
                Number      => $ConfigItemNumbers[53],
                DeplStateID => $DeplStateListReverse{Production},
                InciStateID => $InciStateListReverse{Operational},
                ClassID     => $ConfigItemClassIDs[5],
                Name        => "UnitTest - $ClassList->{ $ConfigItemClassIDs[5] } - 53",
                UserID      => 1,
            },
            VersionAdd => [
                {
                    Name                              => "UnitTest - Class $ConfigItemClassIDs[5] ConfigItem 53 Version 1",
                    DeplStateID                       => $DeplStateListReverse{Production},
                    InciStateID                       => $InciStateListReverse{Incident},
                    UserID                            => 1,
                    "DynamicField_Test1$TestIDSuffix" => 'Test value for text field Test1',
                    "DynamicField_Test4$TestIDSuffix" => 'Test value for text area field Test4',
                },
            ],
        },
        ReferenceData => {
            ConfigItemGet => {
                Number           => $ConfigItemNumbers[53],
                ClassID          => $ConfigItemClassIDs[5],
                Class            => $ClassList->{ $ConfigItemClassIDs[5] },
                CurDeplStateID   => $DeplStateListReverse{Production},
                CurDeplState     => 'Production',
                CurDeplStateType => 'productive',
                CurInciStateID   => $InciStateListReverse{Operational},
                CurInciState     => 'Operational',
                CurInciStateType => 'operational',
                CreateBy         => 1,
                ChangeBy         => 1,
            },
            VersionGet => [
                {
                    Number                            => $ConfigItemNumbers[53],
                    ClassID                           => $ConfigItemClassIDs[5],
                    Class                             => $ClassList->{ $ConfigItemClassIDs[5] },
                    Name                              => "UnitTest - Class $ConfigItemClassIDs[5] ConfigItem 53 Version 1",
                    DefinitionID                      => $ConfigItemDefinitionIDs[5],
                    DeplStateID                       => $DeplStateListReverse{Production},
                    DeplState                         => 'Production',
                    DeplStateType                     => 'productive',
                    CurDeplStateID                    => $DeplStateListReverse{Production},
                    CurDeplState                      => 'Production',
                    CurDeplStateType                  => 'productive',
                    InciStateID                       => $InciStateListReverse{Incident},
                    InciState                         => 'Incident',
                    InciStateType                     => 'incident',
                    CurInciStateID                    => $InciStateListReverse{Incident},
                    CurInciState                      => 'Incident',
                    CurInciStateType                  => 'incident',
                    CreateBy                          => 1,
                    "DynamicField_Test1$TestIDSuffix" => 'Test value for text field Test1',
                    "DynamicField_Test4$TestIDSuffix" => 'Test value for text area field Test4',
                },
            ],
        },
    },

    # add config item only for later search tests, including DynamicFieldData
    {
        SourceData => {
            ConfigItemAdd => {
                Number      => $ConfigItemNumbers[52],
                DeplStateID => $DeplStateListReverse{Production},
                InciStateID => $InciStateListReverse{Operational},
                ClassID     => $ConfigItemClassIDs[2],
                Name        => "UnitTest - $ClassList->{ $ConfigItemClassIDs[2] } - 52",
                UserID      => $UserIDs[2],
            },
            VersionAdd => [
                {
                    Name                              => "UnitTest - Class $ConfigItemClassIDs[2] ConfigItem 52 Version 1",
                    DeplStateID                       => $DeplStateListReverse{Production},
                    InciStateID                       => $InciStateListReverse{Incident},
                    UserID                            => $UserIDs[2],
                    "DynamicField_Test1$TestIDSuffix" => 'Test value for text field Test1',
                    "DynamicField_Test2$TestIDSuffix" => [ 'VALUE1', 'VALUE2' ],
                    "DynamicField_Test3$TestIDSuffix" => '2023-09-01 00:00:00',
                    "DynamicField_Test4$TestIDSuffix" => 'Test value for text area field Test4',
                },
            ],
        },
        ReferenceData => {
            ConfigItemGet => {
                Number           => $ConfigItemNumbers[52],
                ClassID          => $ConfigItemClassIDs[2],
                Class            => $ClassList->{ $ConfigItemClassIDs[2] },
                CurDeplStateID   => $DeplStateListReverse{Production},
                CurDeplState     => 'Production',
                CurDeplStateType => 'productive',
                CurInciStateID   => $InciStateListReverse{Operational},
                CurInciState     => 'Operational',
                CurInciStateType => 'operational',
                CreateBy         => $UserIDs[2],
                ChangeBy         => $UserIDs[2],
            },
            VersionGet => [
                {
                    Number                            => $ConfigItemNumbers[52],
                    ClassID                           => $ConfigItemClassIDs[2],
                    Class                             => $ClassList->{ $ConfigItemClassIDs[2] },
                    Name                              => "UnitTest - Class $ConfigItemClassIDs[2] ConfigItem 52 Version 1",
                    DefinitionID                      => $ConfigItemDefinitionIDs[2],
                    DeplStateID                       => $DeplStateListReverse{Production},
                    DeplState                         => 'Production',
                    DeplStateType                     => 'productive',
                    CurDeplStateID                    => $DeplStateListReverse{Production},
                    CurDeplState                      => 'Production',
                    CurDeplStateType                  => 'productive',
                    InciStateID                       => $InciStateListReverse{Incident},
                    InciState                         => 'Incident',
                    InciStateType                     => 'incident',
                    CurInciStateID                    => $InciStateListReverse{Incident},
                    CurInciState                      => 'Incident',
                    CurInciStateType                  => 'incident',
                    CreateBy                          => $UserIDs[2],
                    "DynamicField_Test1$TestIDSuffix" => 'Test value for text field Test1',
                    "DynamicField_Test2$TestIDSuffix" => [ 'VALUE1', 'VALUE2' ],
                    "DynamicField_Test3$TestIDSuffix" => '2023-09-01 00:00:00',
                    "DynamicField_Test4$TestIDSuffix" => 'Test value for text area field Test4',
                },
            ],
        },
    },

    # add config item only for later search tests, including DynamicFieldData
    {
        SourceData => {
            ConfigItemAdd => {
                Number      => $ConfigItemNumbers[80],
                DeplStateID => $DeplStateListReverse{Production},
                InciStateID => $InciStateListReverse{Operational},
                ClassID     => $ConfigItemClassIDs[4],
                Name        => "UnitTest - $ClassList->{ $ConfigItemClassIDs[4] } - 80",
                UserID      => $UserIDs[2],
            },
            VersionAdd => [
                {
                    Name                              => "UnitTest - Class $ConfigItemClassIDs[4] ConfigItem 80 Version 1",
                    DeplStateID                       => $DeplStateListReverse{Production},
                    InciStateID                       => $InciStateListReverse{Incident},
                    UserID                            => $UserIDs[2],
                    "DynamicField_Test5$TestIDSuffix" => '2023-01-01 12:00:00'
                },
            ],
        },
        ReferenceData => {
            ConfigItemGet => {
                Number           => $ConfigItemNumbers[80],
                ClassID          => $ConfigItemClassIDs[4],
                Class            => $ClassList->{ $ConfigItemClassIDs[4] },
                CurDeplStateID   => $DeplStateListReverse{Production},
                CurDeplState     => 'Production',
                CurDeplStateType => 'productive',
                CurInciStateID   => $InciStateListReverse{Operational},
                CurInciState     => 'Operational',
                CurInciStateType => 'operational',
                CreateBy         => $UserIDs[2],
                ChangeBy         => $UserIDs[2],
            },
            VersionGet => [
                {
                    Number                            => $ConfigItemNumbers[80],
                    ClassID                           => $ConfigItemClassIDs[4],
                    Class                             => $ClassList->{ $ConfigItemClassIDs[4] },
                    Name                              => "UnitTest - Class $ConfigItemClassIDs[4] ConfigItem 80 Version 1",
                    DefinitionID                      => $ConfigItemDefinitionIDs[4],
                    DeplStateID                       => $DeplStateListReverse{Production},
                    DeplState                         => 'Production',
                    DeplStateType                     => 'productive',
                    CurDeplStateID                    => $DeplStateListReverse{Production},
                    CurDeplState                      => 'Production',
                    CurDeplStateType                  => 'productive',
                    InciStateID                       => $InciStateListReverse{Incident},
                    InciState                         => 'Incident',
                    InciStateType                     => 'incident',
                    CurInciStateID                    => $InciStateListReverse{Incident},
                    CurInciState                      => 'Incident',
                    CurInciStateType                  => 'incident',
                    CreateBy                          => $UserIDs[2],
                    "DynamicField_Test5$TestIDSuffix" => '2023-01-01 12:00:00'
                },
            ],
        },
    },

    #add config item only for later search tests
    {
        SourceData => {
            ConfigItemAdd => {
                Number      => $ConfigItemNumbers[60],
                DeplStateID => $DeplStateListReverse{Production},
                InciStateID => $InciStateListReverse{Operational},
                ClassID     => $ConfigItemClassIDs[3],
                Name        => "UnitTest - $ClassList->{ $ConfigItemClassIDs[3] } - 60",
                UserID      => $UserIDs[1],
            },
            VersionAdd => [
                {
                    Name        => "UnitTest - Class $ConfigItemClassIDs[3] ConfigItem 60 Version 1",
                    DeplStateID => $DeplStateListReverse{Production},
                    InciStateID => $InciStateListReverse{Operational},
                    UserID      => $UserIDs[1],
                },
            ],
        },
        ReferenceData => {
            ConfigItemGet => {
                Number           => $ConfigItemNumbers[60],
                ClassID          => $ConfigItemClassIDs[3],
                Class            => $ClassList->{ $ConfigItemClassIDs[3] },
                CurDeplStateID   => $DeplStateListReverse{Production},
                CurDeplState     => 'Production',
                CurDeplStateType => 'productive',
                CurInciStateID   => $InciStateListReverse{Operational},
                CurInciState     => 'Operational',
                CurInciStateType => 'operational',
                CreateBy         => $UserIDs[1],
                ChangeBy         => $UserIDs[1],
            },
            VersionGet => [
                {
                    Number           => $ConfigItemNumbers[60],
                    ClassID          => $ConfigItemClassIDs[3],
                    Class            => $ClassList->{ $ConfigItemClassIDs[3] },
                    Name             => "UnitTest - Class $ConfigItemClassIDs[3] ConfigItem 60 Version 1",
                    DefinitionID     => $ConfigItemDefinitionIDs[3],
                    DeplStateID      => $DeplStateListReverse{Production},
                    DeplState        => 'Production',
                    DeplStateType    => 'productive',
                    CurDeplStateID   => $DeplStateListReverse{Production},
                    CurDeplState     => 'Production',
                    CurDeplStateType => 'productive',
                    InciStateID      => $InciStateListReverse{Operational},
                    InciState        => 'Operational',
                    InciStateType    => 'operational',
                    CurInciStateID   => $InciStateListReverse{Operational},
                    CurInciState     => 'Operational',
                    CurInciStateType => 'operational',
                    CreateBy         => $UserIDs[1],
                },
            ],
        },
    },

    # added to check history functions
    # all required values are given (check the calculation of deployment and incident state)
    {
        SourceData => {
            ConfigItemAdd => {
                Number      => $ConfigItemNumbers[70],
                DeplStateID => $DeplStateListReverse{Production},
                InciStateID => $InciStateListReverse{Operational},
                ClassID     => $ConfigItemClassIDs[0],
                Name        => "UnitTest - $ClassList->{ $ConfigItemClassIDs[0] } - 70",
                UserID      => 1,
            },
            VersionAdd => [
                {
                    Name        => 'UnitTest - HistoryTest',
                    DeplStateID => $DeplStateListReverse{Planned},
                    InciStateID => $InciStateListReverse{Operational},
                    UserID      => 1,
                },
                {
                    Name        => 'UnitTest - HistoryTest Version 2',
                    DeplStateID => $DeplStateListReverse{Maintenance},
                    InciStateID => $InciStateListReverse{Incident},
                    UserID      => 1,
                },
            ],
        },
        ReferenceData => {
            ConfigItemGet => {
                Number           => $ConfigItemNumbers[70],
                ClassID          => $ConfigItemClassIDs[0],
                Class            => $ClassList->{ $ConfigItemClassIDs[0] },
                CurDeplStateID   => $DeplStateListReverse{Production},
                CurDeplState     => 'Production',
                CurDeplStateType => 'productive',
                CurInciStateID   => $InciStateListReverse{Operational},
                CurInciState     => 'Operational',
                CurInciStateType => 'operational',
                CreateBy         => 1,
                ChangeBy         => 1,
            },
            VersionGet => [
                {
                    Number           => $ConfigItemNumbers[70],
                    ClassID          => $ConfigItemClassIDs[0],
                    Class            => $ClassList->{ $ConfigItemClassIDs[0] },
                    Name             => 'UnitTest - HistoryTest',
                    DefinitionID     => $ConfigItemDefinitionIDs[0],
                    DeplStateID      => $DeplStateListReverse{Planned},
                    DeplState        => 'Planned',
                    DeplStateType    => 'preproductive',
                    CurDeplStateID   => $DeplStateListReverse{Production},
                    CurDeplState     => 'Production',
                    CurDeplStateType => 'productive',
                    InciStateID      => $InciStateListReverse{Operational},
                    InciState        => 'Operational',
                    InciStateType    => 'operational',
                    CurInciStateID   => $InciStateListReverse{Incident},
                    CurInciState     => 'Incident',
                    CurInciStateType => 'incident',
                    CreateBy         => 1,
                },
                {
                    Number           => $ConfigItemNumbers[70],
                    ClassID          => $ConfigItemClassIDs[0],
                    Class            => $ClassList->{ $ConfigItemClassIDs[0] },
                    Name             => 'UnitTest - HistoryTest Version 2',
                    DefinitionID     => $ConfigItemDefinitionIDs[0],
                    DeplStateID      => $DeplStateListReverse{Maintenance},
                    DeplState        => 'Maintenance',
                    DeplStateType    => 'productive',
                    CurDeplStateID   => $DeplStateListReverse{Production},
                    CurDeplState     => 'Production',
                    CurDeplStateType => 'productive',
                    InciStateID      => $InciStateListReverse{Incident},
                    InciState        => 'Incident',
                    InciStateType    => 'incident',
                    CurInciStateID   => $InciStateListReverse{Incident},
                    CurInciState     => 'Incident',
                    CurInciStateType => 'incident',
                    CreateBy         => 1,
                },
            ],
            HistoryGet => [
                {
                    HistoryType   => 'VersionCreate',
                    HistoryTypeID => 6,
                    CreateBy      => 1,
                },
                {
                    HistoryType   => 'ConfigItemCreate',
                    HistoryTypeID => 1,
                    CreateBy      => 1,
                },
                {
                    HistoryType   => 'VersionCreate',
                    HistoryTypeID => 6,
                    CreateBy      => 1,
                },
                {
                    HistoryType   => 'NameUpdate',
                    HistoryTypeID => 5,
                    CreateBy      => 1,
                },
                {
                    HistoryType   => 'DeploymentStateUpdate',
                    HistoryTypeID => 11,
                    CreateBy      => 1
                },
                {
                    HistoryType   => 'VersionCreate',
                    HistoryTypeID => 6,
                    CreateBy      => 1,
                },
                {
                    HistoryType   => 'IncidentStateUpdate',
                    HistoryTypeID => 10,
                    CreateBy      => 1,
                },
                {
                    HistoryType   => 'NameUpdate',
                    HistoryTypeID => 5,
                    CreateBy      => 1,
                },
                {
                    HistoryType   => 'DeploymentStateUpdate',
                    HistoryTypeID => 11,
                    CreateBy      => 1
                },
            ],
        },
    },

    # added for Bug4196
    # all required values are given (check the calculation of deployment and incident state)
    {
        SourceData => {
            ConfigItemAdd => {
                Number      => $ConfigItemNumbers[71],
                DeplStateID => $DeplStateListReverse{Maintenance},
                InciStateID => $InciStateListReverse{Incident},
                ClassID     => $ConfigItemClassIDs[0],
                Name        => "UnitTest - $ClassList->{ $ConfigItemClassIDs[0] } - Bugfix4196",
                UserID      => 1,
            },
            VersionAdd => [
                {
                    Name        => 'UnitTest - Bugfix4196',
                    DeplStateID => $DeplStateListReverse{Planned},
                    InciStateID => $InciStateListReverse{Operational},
                    UserID      => 1,
                },
                {
                    Name        => 'UnitTest - Bugfix4196 V2',
                    DeplStateID => $DeplStateListReverse{Maintenance},
                    InciStateID => $InciStateListReverse{Incident},
                    UserID      => 1,
                },
                {
                    Name        => 'UnitTest - Bugfix4196 V2',
                    DeplStateID => $DeplStateListReverse{Maintenance},
                    InciStateID => $InciStateListReverse{Incident},
                    UserID      => 1,
                },
                {
                    Name        => 'UnitTest - Bugfix4196 V2',
                    DeplStateID => $DeplStateListReverse{Maintenance},
                    InciStateID => $InciStateListReverse{Incident},
                    UserID      => 1,
                },
            ],
        },
        ReferenceData => {
            ConfigItemGet => {
                Number           => $ConfigItemNumbers[71],
                ClassID          => $ConfigItemClassIDs[0],
                Class            => $ClassList->{ $ConfigItemClassIDs[0] },
                CurDeplStateID   => $DeplStateListReverse{Maintenance},
                CurDeplState     => 'Maintenance',
                CurDeplStateType => 'productive',
                CurInciStateID   => $InciStateListReverse{Incident},
                CurInciState     => 'Incident',
                CurInciStateType => 'incident',
                CreateBy         => 1,
                ChangeBy         => 1,
            },
            VersionGet => [
                {
                    Number           => $ConfigItemNumbers[71],
                    ClassID          => $ConfigItemClassIDs[0],
                    Class            => $ClassList->{ $ConfigItemClassIDs[0] },
                    Name             => 'UnitTest - Bugfix4196',
                    DefinitionID     => $ConfigItemDefinitionIDs[0],
                    DeplStateID      => $DeplStateListReverse{Planned},
                    DeplState        => 'Planned',
                    DeplStateType    => 'preproductive',
                    CurDeplStateID   => $DeplStateListReverse{Maintenance},
                    CurDeplState     => 'Maintenance',
                    CurDeplStateType => 'productive',
                    InciStateID      => $InciStateListReverse{Operational},
                    InciState        => 'Operational',
                    InciStateType    => 'operational',
                    CurInciStateID   => $InciStateListReverse{Incident},
                    CurInciState     => 'Incident',
                    CurInciStateType => 'incident',
                    CreateBy         => 1,
                },
                {
                    Number           => $ConfigItemNumbers[71],
                    ClassID          => $ConfigItemClassIDs[0],
                    Class            => $ClassList->{ $ConfigItemClassIDs[0] },
                    Name             => 'UnitTest - Bugfix4196 V2',
                    DefinitionID     => $ConfigItemDefinitionIDs[0],
                    DeplStateID      => $DeplStateListReverse{Maintenance},
                    DeplState        => 'Maintenance',
                    DeplStateType    => 'productive',
                    CurDeplStateID   => $DeplStateListReverse{Maintenance},
                    CurDeplState     => 'Maintenance',
                    CurDeplStateType => 'productive',
                    InciStateID      => $InciStateListReverse{Incident},
                    InciState        => 'Incident',
                    InciStateType    => 'incident',
                    CurInciStateID   => $InciStateListReverse{Incident},
                    CurInciState     => 'Incident',
                    CurInciStateType => 'incident',
                    CreateBy         => 1,
                },
                {
                    Number           => $ConfigItemNumbers[71],
                    ClassID          => $ConfigItemClassIDs[0],
                    Class            => $ClassList->{ $ConfigItemClassIDs[0] },
                    Name             => 'UnitTest - Bugfix4196 V2',
                    DefinitionID     => $ConfigItemDefinitionIDs[0],
                    DeplStateID      => $DeplStateListReverse{Maintenance},
                    DeplState        => 'Maintenance',
                    DeplStateType    => 'productive',
                    CurDeplStateID   => $DeplStateListReverse{Maintenance},
                    CurDeplState     => 'Maintenance',
                    CurDeplStateType => 'productive',
                    InciStateID      => $InciStateListReverse{Incident},
                    InciState        => 'Incident',
                    InciStateType    => 'incident',
                    CurInciStateID   => $InciStateListReverse{Incident},
                    CurInciState     => 'Incident',
                    CurInciStateType => 'incident',
                    CreateBy         => 1,
                },
                {
                    Number           => $ConfigItemNumbers[71],
                    ClassID          => $ConfigItemClassIDs[0],
                    Class            => $ClassList->{ $ConfigItemClassIDs[0] },
                    Name             => 'UnitTest - Bugfix4196 V2',
                    DefinitionID     => $ConfigItemDefinitionIDs[0],
                    DeplStateID      => $DeplStateListReverse{Maintenance},
                    DeplState        => 'Maintenance',
                    DeplStateType    => 'productive',
                    CurDeplStateID   => $DeplStateListReverse{Maintenance},
                    CurDeplState     => 'Maintenance',
                    CurDeplStateType => 'productive',
                    InciStateID      => $InciStateListReverse{Incident},
                    InciState        => 'Incident',
                    InciStateType    => 'incident',
                    CurInciStateID   => $InciStateListReverse{Incident},
                    CurInciState     => 'Incident',
                    CurInciStateType => 'incident',
                    CreateBy         => 1,
                },
            ],
        },
    },

    # added for Bug 4377 - CI-A
    {
        SourceData => {
            ConfigItemAdd => {
                Number      => $ConfigItemNumbers[72],
                DeplStateID => $DeplStateListReverse{Production},
                InciStateID => $InciStateListReverse{Operational},
                ClassID     => $ConfigItemClassIDs[0],
                Name        => "UnitTest - $ClassList->{ $ConfigItemClassIDs[0] } - Bug 4377 - CI-A",
                UserID      => 1,
            },
            VersionAdd => [
                {
                    Name        => 'UnitTest - Bugfix4377 - CI-A',
                    DeplStateID => $DeplStateListReverse{Production},
                    InciStateID => $InciStateListReverse{Operational},
                    UserID      => 1,
                },
            ],
        },
        ReferenceData => {
            ConfigItemGet => {
                Number           => $ConfigItemNumbers[72],
                ClassID          => $ConfigItemClassIDs[0],
                Class            => $ClassList->{ $ConfigItemClassIDs[0] },
                CurDeplStateID   => $DeplStateListReverse{Production},
                CurDeplState     => 'Production',
                CurDeplStateType => 'productive',
                CurInciStateID   => $InciStateListReverse{Operational},
                CurInciState     => 'Operational',
                CurInciStateType => 'operational',
                CreateBy         => 1,
                ChangeBy         => 1,
            },
            VersionGet => [
                {
                    Number           => $ConfigItemNumbers[72],
                    ClassID          => $ConfigItemClassIDs[0],
                    Class            => $ClassList->{ $ConfigItemClassIDs[0] },
                    Name             => 'UnitTest - Bugfix4377 - CI-A',
                    DefinitionID     => $ConfigItemDefinitionIDs[0],
                    DeplStateID      => $DeplStateListReverse{Production},
                    DeplState        => 'Production',
                    DeplStateType    => 'productive',
                    CurDeplStateID   => $DeplStateListReverse{Production},
                    CurDeplState     => 'Production',
                    CurDeplStateType => 'productive',
                    InciStateID      => $InciStateListReverse{Operational},
                    InciState        => 'Operational',
                    InciStateType    => 'operational',
                    CurInciStateID   => $InciStateListReverse{Operational},
                    CurInciState     => 'Operational',
                    CurInciStateType => 'operational',
                    CreateBy         => 1,
                },
            ],
        },
    },

    # added for Bug 4377 - CI-B
    {
        SourceData => {
            ConfigItemAdd => {
                Number      => $ConfigItemNumbers[73],
                DeplStateID => $DeplStateListReverse{Production},
                InciStateID => $InciStateListReverse{Operational},
                ClassID     => $ConfigItemClassIDs[0],
                Name        => "UnitTest - $ClassList->{ $ConfigItemClassIDs[0] } - Bug 4377 - CI-B",
                UserID      => 1,
            },
            VersionAdd => [
                {
                    Name        => 'UnitTest - Bugfix4377 - CI-B',
                    DeplStateID => $DeplStateListReverse{Production},
                    InciStateID => $InciStateListReverse{Operational},
                    UserID      => 1,
                },
            ],
        },
        ReferenceData => {
            ConfigItemGet => {
                Number           => $ConfigItemNumbers[73],
                ClassID          => $ConfigItemClassIDs[0],
                Class            => $ClassList->{ $ConfigItemClassIDs[0] },
                CurDeplStateID   => $DeplStateListReverse{Production},
                CurDeplState     => 'Production',
                CurDeplStateType => 'productive',
                CurInciStateID   => $InciStateListReverse{Operational},
                CurInciState     => 'Operational',
                CurInciStateType => 'operational',
                CreateBy         => 1,
                ChangeBy         => 1,
            },
            VersionGet => [
                {
                    Number           => $ConfigItemNumbers[73],
                    ClassID          => $ConfigItemClassIDs[0],
                    Class            => $ClassList->{ $ConfigItemClassIDs[0] },
                    Name             => 'UnitTest - Bugfix4377 - CI-B',
                    DefinitionID     => $ConfigItemDefinitionIDs[0],
                    DeplStateID      => $DeplStateListReverse{Production},
                    DeplState        => 'Production',
                    DeplStateType    => 'productive',
                    CurDeplStateID   => $DeplStateListReverse{Production},
                    CurDeplState     => 'Production',
                    CurDeplStateType => 'productive',
                    InciStateID      => $InciStateListReverse{Operational},
                    InciState        => 'Operational',
                    InciStateType    => 'operational',
                    CurInciStateID   => $InciStateListReverse{Operational},
                    CurInciState     => 'Operational',
                    CurInciStateType => 'operational',
                    CreateBy         => 1,
                },
            ],
        },
    },

];

# ------------------------------------------------------------ #
# run general config item tests
# ------------------------------------------------------------ #

my $TestCount = 1;
my @ConfigItemIDs;

TEST:
for my $Test ( @{$ConfigItemTests} ) {

    # check SourceData attribute
    if ( !$Test->{SourceData} || ref $Test->{SourceData} ne 'HASH' ) {

        $Self->True(
            0,
            "Test $TestCount: No SourceData found for this test.",
        );

        next TEST;
    }

    # extract source data
    my $SourceData = $Test->{SourceData};

    # add a new config item
    my $ConfigItemID;
    if ( $SourceData->{ConfigItemAdd} ) {

        # add the new config item
        $ConfigItemID = $ConfigItemObject->ConfigItemAdd(
            %{ $SourceData->{ConfigItemAdd} },
        );

        if ($ConfigItemID) {
            push @ConfigItemIDs, $ConfigItemID;
        }
    }

    # check the config item
    if ( $Test->{ReferenceData} && $Test->{ReferenceData}->{ConfigItemGet} ) {

        $Self->True(
            $ConfigItemID,
            "Test $TestCount: ConfigItemAdd() - Add new config item. Insert success.",
        );

        next TEST if !$ConfigItemID;
    }
    else {

        $Self->False(
            $ConfigItemID,
            "Test $TestCount: ConfigItemAdd() - Add new config item. Return false.",
        );
    }

    # add all defined versions
    my @VersionIDs;
    my %VersionIDsSeen;
    if ( $SourceData->{VersionAdd} ) {

        for my $Version ( @{ $SourceData->{VersionAdd} } ) {

            if ($ConfigItemID) {
                $Version->{ConfigItemID} = $ConfigItemID;
            }

            # get the last version id before ConfigItemUpdate
            my $ConfigItemData = $ConfigItemObject->ConfigItemGet(
                ConfigItemID => $ConfigItemID,
            );

            my $LastVersionID = $ConfigItemData->{LastVersionID};

            $ConfigItemObject->ConfigItemUpdate(
                %{$Version},
                ForceAdd => 1
            );

            # get the last version id after ConfigItemUpdate
            $ConfigItemData = $ConfigItemObject->ConfigItemGet(
                ConfigItemID => $ConfigItemID,
            );

            my $VersionID = $ConfigItemData->{LastVersionID};

            if ( $VersionID ne $LastVersionID ) {
                push @VersionIDs, $VersionID if !$VersionIDsSeen{$VersionID}++;
            }
        }
    }

    # check the config item
    my $ConfigItemData;
    if ( $Test->{ReferenceData} && $Test->{ReferenceData}->{ConfigItemGet} ) {

        # get the config item data
        $ConfigItemData = $ConfigItemObject->ConfigItemGet(
            ConfigItemID => $ConfigItemID,
        );

        if ( !$ConfigItemData ) {

            $Self->True(
                0,
                "Test $TestCount: ConfigItemGet() - get config item data."
            );
        }

        # check all config item attributes
        my $Counter = 0;
        for my $Attribute ( sort keys %{ $Test->{ReferenceData}->{ConfigItemGet} } ) {

            # set content if values are undef
            if ( !defined $ConfigItemData->{$Attribute} ) {
                $ConfigItemData->{$Attribute} = 'UNDEF-unittest';
            }
            if ( !defined $Test->{ReferenceData}->{ConfigItemGet}->{$Attribute} ) {
                $Test->{ReferenceData}->{ConfigItemGet}->{$Attribute} = 'UNDEF-unittest';
            }

            # check attributes
            $Self->Is(
                $ConfigItemData->{$Attribute},
                $Test->{ReferenceData}->{ConfigItemGet}->{$Attribute},
                "Test $TestCount: ConfigItemGet() - $Attribute",
            );

            $Counter++;
        }
    }

    # check the versions
    if (
        $Test->{ReferenceData}
        && $Test->{ReferenceData}->{VersionGet}
        && @{ $Test->{ReferenceData}->{VersionGet} }
        )
    {

        $Self->Is(
            scalar @VersionIDs,
            scalar @{ $Test->{ReferenceData}->{VersionGet} },
            "Test $TestCount: VersionAdd() - correct number of versions",
        );

        next TEST if !$ConfigItemID;
    }
    else {

        $Self->False(
            scalar @VersionIDs,
            "Test $TestCount: VersionAdd() - no versions exits",
        );
    }

    next TEST if !$Test->{ReferenceData};
    next TEST if !$Test->{ReferenceData}->{VersionGet};

    my $Counter           = 0;
    my $LastVersionIDMust = 'UNDEF-unittest';

    # Refresh ITSMConfigurationManagement cache to avoid issues with previously cached values.
    $Kernel::OM->Get('Kernel::System::Cache')->CleanUp(
        Type => 'ITSMConfigurationManagement',
    );

    VERSIONID:
    for my $VersionID (@VersionIDs) {

        # get this version
        my $VersionData = $ConfigItemObject->ConfigItemGet(
            VersionID     => $VersionID,
            DynamicFields => 1
        );

        if ( !$VersionData ) {

            $Self->True(
                0,
                "Test $TestCount: ConfigItemGet(Version Get) - get version data."
            );

            next VERSIONID;
        }

        # save last version id
        $LastVersionIDMust = $VersionData->{VersionID};

        # check all version attributes
        for my $Attribute ( sort keys %{ $Test->{ReferenceData}->{VersionGet}->[$Counter] } ) {

            # extract the needed attributes
            my $VersionAttribute   = $VersionData->{$Attribute};
            my $ReferenceAttribute = $Test->{ReferenceData}->{VersionGet}->[$Counter]->{$Attribute};

            # set content if values are undef
            if ( !defined $VersionAttribute ) {
                $VersionAttribute = 'UNDEF-unittest';
            }
            if ( !defined $ReferenceAttribute ) {
                $ReferenceAttribute = 'UNDEF-unittest';
            }

            # check attributes
            $Self->IsDeeply(
                $VersionAttribute,
                $ReferenceAttribute,
                "Test $TestCount: ConfigItemGet(Version Get) - $Attribute",
            );
        }

        $Counter++;
    }

    # prepare last version id
    my $LastVersionIDActual = 'UNDEF-unittest';
    if ( $ConfigItemData->{LastVersionID} ) {
        $LastVersionIDActual = $ConfigItemData->{LastVersionID};
    }

    # check last version id
    $Self->Is(
        $ConfigItemData->{LastVersionID},
        $LastVersionIDMust,
        "Test $TestCount: last version id identical",
    );

    # check history entries
    if (
        $Test->{ReferenceData}
        && $Test->{ReferenceData}->{HistoryGet}
        && @{ $Test->{ReferenceData}->{HistoryGet} }
        )
    {
        my $CompleteHistory = $ConfigItemObject->HistoryGet(
            ConfigItemID => $ConfigItemID,
        );

        # check nr of history entries
        $Self->Is(
            scalar @{ $Test->{ReferenceData}->{HistoryGet} },
            scalar @{$CompleteHistory},
            "Test $TestCount: nr of history entries",
        );

        # CHECKNR: for my $CheckNr ( 0 .. $#{$CompleteHistory} ) {
        #     my $Check = $Test->{ReferenceData}->{HistoryGet}->[$CheckNr];
        #     my $Data  = $CompleteHistory->[$CheckNr];

        #     next CHECKNR if !( $Check && $Data );

        #     for my $Key ( sort keys %{$Check} ) {

        #         # check history data
        #         $Self->Is(
        #             $Check->{$Key},
        #             $Data->{$Key},
        #             "Test $TestCount: $Key",
        #         );
        #     }
        # }
    }
}
continue {
    $TestCount++;
}

# Following section is pending for check after normalize de
# Incident recalculation funcion

# ------------------------------------------------------------ #
# test for bugfix 4377
# ------------------------------------------------------------ #

# {

#     my $CI1 = $ConfigItemObject->ConfigItemLookup(
#         ConfigItemNumber => $ConfigItemNumbers[72],
#     );

#     my $CI2 = $ConfigItemObject->ConfigItemLookup(
#         ConfigItemNumber => $ConfigItemNumbers[73],
#     );

#     # link the CI with a CI
#     my $LinkResult = $LinkObject->LinkAdd(
#         SourceObject => 'ITSMConfigItem',
#         SourceKey    => $CI1,
#         TargetObject => 'ITSMConfigItem',
#         TargetKey    => $CI2,
#         Type         => 'DependsOn',
#         State        => 'Valid',
#         UserID       => 1,
#     );

#     # update incident state of CI1
#     my $VersionID = $ConfigItemObject->VersionAdd(
#         ConfigItemID => $CI1,
#         Name         => 'UnitTest - Bugfix4377 - CI-A',
#         DeplStateID  => $DeplStateListReverse{Production},
#         InciStateID  => $InciStateListReverse{Incident},
#         UserID       => 1,
#     );

#     # check if version could be added
#     $Self->True(
#         $VersionID,
#         "Test $TestCount: VersionAdd() for $CI1 - Set to 'Incident'",
#     );

#     # get the latest version for CI1
#     my $VersionRef = $ConfigItemObject->ConfigItemGet(
#         ConfigItemID => $CI1,
#     );

#     # check if incident state of CI1 is 'Incident'
#     $Self->Is(
#         $VersionRef->{CurInciState},
#         'Incident',
#         "Test $TestCount: Current incident state of CI $CI1",
#     );

#     # get the latest version for CI2
#     $VersionRef = $ConfigItemObject->ConfigItemGet(
#         ConfigItemID => $CI2,
#     );

#     # check if incident state of CI2 is 'Warning'
#     $Self->Is(
#         $VersionRef->{CurInciState},
#         'Warning',
#         "Test $TestCount: Current incident state of CI $CI2",
#     );

#     # update incident state of CI2 to 'Incident'
#     $VersionID = $ConfigItemObject->VersionAdd(
#         ConfigItemID => $CI2,
#         Name         => 'UnitTest - Bugfix4377 - CI-B',
#         DeplStateID  => $DeplStateListReverse{Production},
#         InciStateID  => $InciStateListReverse{Incident},
#         UserID       => 1,
#     );

#     # check if version could be added
#     $Self->True(
#         $VersionID,
#         "Test $TestCount: VersionAdd() for CI $CI2 - Set to 'Incident'",
#     );

#     # get the latest version for CI2
#     $VersionRef = $ConfigItemObject->ConfigItemGet(
#         ConfigItemID => $CI2,
#     );

#     # check if incident state of CI2 is 'Incident'
#     $Self->Is(
#         $VersionRef->{CurInciState},
#         'Incident',
#         "Test $TestCount: Current incident state of CI $CI2",
#     );

#     # update incident state of CI1 to 'Operational'
#     $VersionID = $ConfigItemObject->VersionAdd(
#         ConfigItemID => $CI1,
#         Name         => 'UnitTest - Bugfix4377 - CI-A',
#         DeplStateID  => $DeplStateListReverse{Production},
#         InciStateID  => $InciStateListReverse{Operational},
#         UserID       => 1,
#     );

#     # check if version could be added
#     $Self->True(
#         $VersionID,
#         "Test $TestCount: VersionAdd() for CI $CI1 - Set to 'Operational'",
#     );

#     # get the latest version for CI1
#     $VersionRef = $ConfigItemObject->ConfigItemGet(
#         ConfigItemID => $CI1,
#     );

#     # check if incident state of CI1 is 'Warning' (because of linked CI2 in state 'incident')
#     $Self->Is(
#         $VersionRef->{CurInciState},
#         'Warning',
#         "Test $TestCount: Current incident state of CI $CI1",
#     );

#     # update incident state of CI2 to 'Operational'
#     $VersionID = $ConfigItemObject->VersionAdd(
#         ConfigItemID => $CI2,
#         Name         => 'UnitTest - Bugfix4377 - CI-B',
#         DeplStateID  => $DeplStateListReverse{Production},
#         InciStateID  => $InciStateListReverse{Operational},
#         UserID       => 1,
#     );

#     # check if version could be added
#     $Self->True(
#         $VersionID,
#         "Test $TestCount: VersionAdd() for CI $CI2 - Set to 'Operational'",
#     );

#     # get the latest version for CI1
#     $VersionRef = $ConfigItemObject->ConfigItemGet(
#         ConfigItemID => $CI1,
#     );

#     # check if incident state of CI1 is 'Operational'
#     $Self->Is(
#         $VersionRef->{CurInciState},
#         'Operational',
#         "Test $TestCount: Current incident state of CI $CI1",
#     );

#     # get the latest version for CI2
#     $VersionRef = $ConfigItemObject->ConfigItemGet(
#         ConfigItemID => $CI2,
#     );

#     # check if incident state of CI2 is 'Warning'
#     $Self->Is(
#         $VersionRef->{CurInciState},
#         'Operational',
#         "Test $TestCount: Current incident state of CI $CI2",
#     );

#     # increase the test counter
#     $TestCount++;
# }

# ------------------------------------------------------------ #
# test for bugfix 10356
# ------------------------------------------------------------ #

# {

#     my $CI1 = $ConfigItemObject->ConfigItemLookup(
#         ConfigItemNumber => $ConfigItemNumbers[72],
#     );

#     # add a version, set incident state to incident
#     my $VersionID = $ConfigItemObject->VersionAdd(
#         ConfigItemID => $CI1,
#         Name         => 'UnitTest - Bugfix10356',
#         DeplStateID  => $DeplStateListReverse{Production},
#         InciStateID  => $InciStateListReverse{Incident},
#         UserID       => 1,
#     );

#     # check if version could be added
#     $Self->True(
#         $VersionID,
#         "Test $TestCount: VersionAdd() for $CI1 - Set to 'Incident'",
#     );

#     # get the latest version for CI1
#     my $VersionRef = $ConfigItemObject->ConfigItemGet(
#         ConfigItemID => $CI1,
#     );

#     # check if incident state of CI1 is 'Incident'
#     $Self->Is(
#         $VersionRef->{CurInciState},
#         'Incident',
#         "Test $TestCount: Current incident state of CI $CI1",
#     );

#     # delete the last version
#     my $VersionDeleteSuccess = $ConfigItemObject->VersionDelete(
#         VersionID => $VersionRef->{VersionID},
#         UserID    => 1,
#     );

#     # check if version could be deleted
#     $Self->True(
#         $VersionDeleteSuccess,
#         "Test $TestCount: VersionDelete() for $CI1'",
#     );

#     # get the history
#     my $HistoryRef = $ConfigItemObject->HistoryGet(
#         ConfigItemID => $CI1,
#     );

#     my $LastHistoryEntry = pop @{$HistoryRef};

#     # check if last history entry has the correct history type
#     $Self->Is(
#         $LastHistoryEntry->{HistoryType},
#         'VersionDelete',
#         "Test $TestCount: HistoryType of last version of CI $CI1",
#     );

#     # increase the test counter
#     $TestCount++;
# }

# ------------------------------------------------------------ #
# define general config item search tests
# ------------------------------------------------------------ #

my @SearchTests = (

    # search ALL config items in the two test classes
    {
        Function   => ['ConfigItemSearch'],
        SearchData => {
            ClassIDs => [ $ConfigItemClassIDs[2], $ConfigItemClassIDs[3] ],
            Result   => 'ARRAY',
            OrderBy  => 'Up'
        },
        ReferenceData => [
            $ConfigItemNumbers[50],
            $ConfigItemNumbers[51],
            $ConfigItemNumbers[52],
            $ConfigItemNumbers[60],
        ],
    },

    # test the number param
    {
        Function   => ['ConfigItemSearch'],
        SearchData => {
            Number => $ConfigItemNumbers[50],
            Result => 'ARRAY',
        },
        ReferenceData => [
            $ConfigItemNumbers[50],
        ],
    },

    # test the number param with wildcards
    {
        Function   => ['ConfigItemSearch'],
        SearchData => {
            Number => '%' . $ConfigItemNumbers[50] . '%',
            Result => 'ARRAY',
        },
        ReferenceData => [
            $ConfigItemNumbers[50],
        ],
    },

    # test the number param with wildcards but with invalid ConfigItem number
    {
        Function   => ['ConfigItemSearch'],
        SearchData => {
            Number => '%dummyname%',
            Result => 'ARRAY',
        },
        ReferenceData => [],
    },

    # test the deployment state param in combination of the class id
    {
        Function   => ['ConfigItemSearch'],
        SearchData => {
            ClassIDs     => [ $ConfigItemClassIDs[2], $ConfigItemClassIDs[3] ],
            DeplStateIDs => [ $DeplStateListReverse{Production} ],
            Result       => 'ARRAY',
            OrderBy      => 'Up'
        },
        ReferenceData => [
            $ConfigItemNumbers[50],
            $ConfigItemNumbers[52],
            $ConfigItemNumbers[60],
        ],
    },

    #test the deployment state param in combination of the class id
    {
        Function   => ['ConfigItemSearch'],
        SearchData => {
            ClassIDs     => [ $ConfigItemClassIDs[2], $ConfigItemClassIDs[3] ],
            DeplStateIDs => [ $DeplStateListReverse{Maintenance} ],
            Result       => 'ARRAY',
        },
        ReferenceData => [
            $ConfigItemNumbers[51],
        ],
    },

    #test the deployment state param in combination of the class id
    {
        Function   => ['ConfigItemSearch'],
        SearchData => {
            ClassIDs     => [ $ConfigItemClassIDs[2], $ConfigItemClassIDs[3] ],
            DeplStateIDs => [
                $DeplStateListReverse{Production},
                $DeplStateListReverse{Maintenance},
            ],
            Result  => 'ARRAY',
            OrderBy => 'Up'
        },
        ReferenceData => [
            $ConfigItemNumbers[50],
            $ConfigItemNumbers[51],
            $ConfigItemNumbers[52],
            $ConfigItemNumbers[60],
        ],
    },

    #test the incident state param in combination of the class id
    {
        Function   => ['ConfigItemSearch'],
        SearchData => {
            ClassIDs     => [ $ConfigItemClassIDs[2], $ConfigItemClassIDs[3] ],
            InciStateIDs => [ $InciStateListReverse{Operational} ],
            Result       => 'ARRAY',
        },
        ReferenceData => [
            $ConfigItemNumbers[60],
        ],
    },

    #test the incident state param in combination of the class id
    {
        Function   => ['ConfigItemSearch'],
        SearchData => {
            ClassIDs     => [ $ConfigItemClassIDs[2], $ConfigItemClassIDs[3] ],
            InciStateIDs => [ $InciStateListReverse{Incident} ],
            Result       => 'ARRAY',
            OrderBy      => 'Up'
        },
        ReferenceData => [
            $ConfigItemNumbers[50],
            $ConfigItemNumbers[51],
            $ConfigItemNumbers[52],
        ],
    },

    #test the incident state param in combination of the class id
    {
        Function   => ['ConfigItemSearch'],
        SearchData => {
            ClassIDs     => [ $ConfigItemClassIDs[2], $ConfigItemClassIDs[3] ],
            InciStateIDs => [
                $InciStateListReverse{Incident},
                $InciStateListReverse{Operational},
            ],
            Result  => 'ARRAY',
            OrderBy => 'Up'
        },
        ReferenceData => [
            $ConfigItemNumbers[50],
            $ConfigItemNumbers[51],
            $ConfigItemNumbers[52],
            $ConfigItemNumbers[60],
        ],
    },

    # test the limit param
    {
        Function   => ['ConfigItemSearch'],
        SearchData => {
            ClassIDs => [ $ConfigItemClassIDs[2], $ConfigItemClassIDs[3] ],
            Limit    => 100,
            Result   => 'ARRAY',
            OrderBy  => 'Up'
        },
        ReferenceData => [
            $ConfigItemNumbers[50],
            $ConfigItemNumbers[51],
            $ConfigItemNumbers[52],
            $ConfigItemNumbers[60],
        ],
    },

    # test the limit param
    {
        Function   => ['ConfigItemSearch'],
        SearchData => {
            ClassIDs => [ $ConfigItemClassIDs[2], $ConfigItemClassIDs[3] ],
            Limit    => 3,
            Result   => 'ARRAY',
            OrderBy  => 'Up'
        },
        ReferenceData => [
            $ConfigItemNumbers[50],
            $ConfigItemNumbers[51],
            $ConfigItemNumbers[52],
        ],
    },

    # test the limit param
    {
        Function   => ['ConfigItemSearch'],
        SearchData => {
            ClassIDs => [ $ConfigItemClassIDs[2], $ConfigItemClassIDs[3] ],
            Limit    => 2,
            Result   => 'ARRAY',
            OrderBy  => 'Up'
        },
        ReferenceData => [
            $ConfigItemNumbers[50],
            $ConfigItemNumbers[51],
        ],
    },

    # test the limit param
    {
        Function   => ['ConfigItemSearch'],
        SearchData => {
            ClassIDs => [ $ConfigItemClassIDs[2], $ConfigItemClassIDs[3] ],
            Limit    => 1,
            Result   => 'ARRAY',
            OrderBy  => 'Up'
        },
        ReferenceData => [
            $ConfigItemNumbers[50],
        ],
    },

    # test the limit param
    {
        Function   => ['ConfigItemSearch'],
        SearchData => {
            ClassIDs => [ $ConfigItemClassIDs[2], $ConfigItemClassIDs[3] ],
            Limit    => 0,
            Result   => 'ARRAY',
            OrderBy  => 'Up'
        },
        ReferenceData => [
            $ConfigItemNumbers[50],
            $ConfigItemNumbers[51],
            $ConfigItemNumbers[52],
            $ConfigItemNumbers[60],
        ],
    },

    #search ALL config items in the two test classes using the version search
    {
        Function   => ['VersionSearch'],
        SearchData => {
            ClassIDs => [ $ConfigItemClassIDs[2], $ConfigItemClassIDs[3] ],
        },
        ReferenceData => [
            $ConfigItemNumbers[50],
            $ConfigItemNumbers[51],
            $ConfigItemNumbers[52],
            $ConfigItemNumbers[60],
        ],
    },

    # test the name param
    {
        Function   => ['VersionSearch'],
        SearchData => {
            Name     => "UnitTest - Class $ConfigItemClassIDs[2] ConfigItem 50 Version 1",
            ClassIDs => [ $ConfigItemClassIDs[2], $ConfigItemClassIDs[3] ],
        },
        ReferenceData => [
            $ConfigItemNumbers[50],
        ],
    },

    #test the name param
    {
        Function   => ['VersionSearch'],
        SearchData => {
            Name     => "UnitTest - Class $ConfigItemClassIDs[2] ConfigItem 52 Version 1",
            ClassIDs => [ $ConfigItemClassIDs[2], $ConfigItemClassIDs[3] ],
        },
        ReferenceData => [
            $ConfigItemNumbers[52],
        ],
    },

    # test the name param with an wildcard
    {
        Function   => ['VersionSearch'],
        SearchData => {
            Name     => 'UnitTest - * 1',
            ClassIDs => [ $ConfigItemClassIDs[2], $ConfigItemClassIDs[3] ],
        },
        ReferenceData => [
            $ConfigItemNumbers[50],
            $ConfigItemNumbers[52],
            $ConfigItemNumbers[60],
        ],
    },

    # test the name param with an wildcard and a previous version search
    {
        Function   => ['VersionSearch'],
        SearchData => {
            Name                  => 'UnitTest - * 1',
            ClassIDs              => [ $ConfigItemClassIDs[2], $ConfigItemClassIDs[3] ],
            PreviousVersionSearch => 1,
        },
        ReferenceData => [
            $ConfigItemNumbers[50],
            $ConfigItemNumbers[51],
            $ConfigItemNumbers[52],
            $ConfigItemNumbers[60],
        ],
    },

    # test the name param with wildcards
    {
        Function   => ['VersionSearch'],
        SearchData => {
            Name     => "UnitTest - Class $ConfigItemClassIDs[2]*",
            ClassIDs => [ $ConfigItemClassIDs[2], $ConfigItemClassIDs[3] ],
        },
        ReferenceData => [
            $ConfigItemNumbers[50],
            $ConfigItemNumbers[51],
            $ConfigItemNumbers[52],
        ],
    },

    # test the name param with wildcards but with deactivated wildcard feature
    {
        Function   => ['VersionSearch'],
        SearchData => {
            Name           => "UnitTest - Class $ConfigItemClassIDs[2]*",
            ClassIDs       => [ $ConfigItemClassIDs[2], $ConfigItemClassIDs[3] ],
            UsingWildcards => 0,
        },
        ReferenceData => [],
    },

    # test the last version search
    {
        Function   => ['VersionSearch'],
        SearchData => {
            Name     => "UnitTest - Class $ConfigItemClassIDs[2] ConfigItem 51 Version 1",
            ClassIDs => [ $ConfigItemClassIDs[2], $ConfigItemClassIDs[3] ],
        },
        ReferenceData => [],
    },

    # test the PreviousVersionSearch param
    {
        Function   => ['VersionSearch'],
        SearchData => {
            Name                  => "UnitTest - Class $ConfigItemClassIDs[2] ConfigItem 51 Version 1",
            ClassIDs              => [ $ConfigItemClassIDs[2], $ConfigItemClassIDs[3] ],
            PreviousVersionSearch => 1,
        },
        ReferenceData => [
            $ConfigItemNumbers[51],
        ],
    },

    # test the limit param
    {
        Function   => ['VersionSearch'],
        SearchData => {
            ClassIDs => [ $ConfigItemClassIDs[2], $ConfigItemClassIDs[3] ],
            Limit    => 100,
        },
        ReferenceData => [
            $ConfigItemNumbers[50],
            $ConfigItemNumbers[51],
            $ConfigItemNumbers[52],
            $ConfigItemNumbers[60],
        ],
    },

    # test the limit param
    {
        Function   => ['VersionSearch'],
        SearchData => {
            ClassIDs => [ $ConfigItemClassIDs[2], $ConfigItemClassIDs[3] ],
            Limit    => 3,
        },
        ReferenceData => [
            $ConfigItemNumbers[50],
            $ConfigItemNumbers[51],
            $ConfigItemNumbers[52],
        ],
    },

    # test the limit param
    {
        Function   => ['VersionSearch'],
        SearchData => {
            ClassIDs => [ $ConfigItemClassIDs[2], $ConfigItemClassIDs[3] ],
            Limit    => 2,
        },
        ReferenceData => [
            $ConfigItemNumbers[50],
            $ConfigItemNumbers[51],
        ],
    },

    # test the limit param
    {
        Function   => ['VersionSearch'],
        SearchData => {
            ClassIDs => [ $ConfigItemClassIDs[2], $ConfigItemClassIDs[3] ],
            Limit    => 1,
        },
        ReferenceData => [
            $ConfigItemNumbers[50],
        ],
    },

    # test the deployment state param
    {
        Function   => ['VersionSearch'],
        SearchData => {
            ClassIDs     => [ $ConfigItemClassIDs[2], $ConfigItemClassIDs[3] ],
            DeplStateIDs => [
                $DeplStateListReverse{Production},
                $DeplStateListReverse{Maintenance},
            ],
        },
        ReferenceData => [
            $ConfigItemNumbers[50],
            $ConfigItemNumbers[51],
            $ConfigItemNumbers[52],
            $ConfigItemNumbers[60],
        ],
    },

    # test the deployment state param
    {
        Function   => ['VersionSearch'],
        SearchData => {
            ClassIDs     => [ $ConfigItemClassIDs[2], $ConfigItemClassIDs[3] ],
            DeplStateIDs => [ $DeplStateListReverse{Production} ],
        },
        ReferenceData => [
            $ConfigItemNumbers[50],
            $ConfigItemNumbers[52],
            $ConfigItemNumbers[60],
        ],
    },

    # test the deployment state param
    {
        Function   => ['VersionSearch'],
        SearchData => {
            ClassIDs     => [ $ConfigItemClassIDs[2], $ConfigItemClassIDs[3] ],
            DeplStateIDs => [ $DeplStateListReverse{Maintenance} ],
        },
        ReferenceData => [
            $ConfigItemNumbers[51],
        ],
    },

    # test the deployment state param with activated previous version search
    {
        Function   => ['VersionSearch'],
        SearchData => {
            ClassIDs     => [ $ConfigItemClassIDs[2], $ConfigItemClassIDs[3] ],
            DeplStateIDs => [
                $DeplStateListReverse{Production},
                $DeplStateListReverse{Maintenance},
            ],
            PreviousVersionSearch => 1,
        },
        ReferenceData => [
            $ConfigItemNumbers[50],
            $ConfigItemNumbers[51],
            $ConfigItemNumbers[52],
            $ConfigItemNumbers[60],
        ],
    },

    # test the deployment state param with activated previous version search
    {
        Function   => ['VersionSearch'],
        SearchData => {
            ClassIDs              => [ $ConfigItemClassIDs[2], $ConfigItemClassIDs[3] ],
            DeplStateIDs          => [ $DeplStateListReverse{Production} ],
            PreviousVersionSearch => 1,
        },
        ReferenceData => [
            $ConfigItemNumbers[50],
            $ConfigItemNumbers[51],
            $ConfigItemNumbers[52],
            $ConfigItemNumbers[60],
        ],
    },

    # test the deployment state param with activated previous version search
    {
        Function   => ['VersionSearch'],
        SearchData => {
            ClassIDs              => [ $ConfigItemClassIDs[2], $ConfigItemClassIDs[3] ],
            DeplStateIDs          => [ $DeplStateListReverse{Maintenance} ],
            PreviousVersionSearch => 1,
        },
        ReferenceData => [
            $ConfigItemNumbers[51],
        ],
    },

    # test the incident state param
    {
        Function   => ['VersionSearch'],
        SearchData => {
            ClassIDs     => [ $ConfigItemClassIDs[2], $ConfigItemClassIDs[3] ],
            InciStateIDs => [
                $InciStateListReverse{Operational},
                $InciStateListReverse{Incident},
            ],
        },
        ReferenceData => [
            $ConfigItemNumbers[50],
            $ConfigItemNumbers[51],
            $ConfigItemNumbers[52],
            $ConfigItemNumbers[60],
        ],
    },

    # test the incident state param
    {
        Function   => ['VersionSearch'],
        SearchData => {
            ClassIDs     => [ $ConfigItemClassIDs[2], $ConfigItemClassIDs[3] ],
            InciStateIDs => [ $InciStateListReverse{Operational} ],
        },
        ReferenceData => [
            $ConfigItemNumbers[60],
        ],
    },

    # test the incident state param
    {
        Function   => ['VersionSearch'],
        SearchData => {
            ClassIDs     => [ $ConfigItemClassIDs[2], $ConfigItemClassIDs[3] ],
            InciStateIDs => [ $InciStateListReverse{Incident} ],
        },
        ReferenceData => [
            $ConfigItemNumbers[50],
            $ConfigItemNumbers[51],
            $ConfigItemNumbers[52],
        ],
    },

    # test the incident state param with activated previous version search
    {
        Function   => ['VersionSearch'],
        SearchData => {
            ClassIDs     => [ $ConfigItemClassIDs[2], $ConfigItemClassIDs[3] ],
            InciStateIDs => [
                $InciStateListReverse{Operational},
                $InciStateListReverse{Incident},
            ],
            PreviousVersionSearch => 1,
        },
        ReferenceData => [
            $ConfigItemNumbers[50],
            $ConfigItemNumbers[51],
            $ConfigItemNumbers[52],
            $ConfigItemNumbers[60],
        ],
    },

    # test the incident state param with activated previous version search
    {
        Function   => ['VersionSearch'],
        SearchData => {
            ClassIDs              => [ $ConfigItemClassIDs[2], $ConfigItemClassIDs[3] ],
            InciStateIDs          => [ $InciStateListReverse{Operational} ],
            PreviousVersionSearch => 1,
        },
        ReferenceData => [
            $ConfigItemNumbers[51],
            $ConfigItemNumbers[52],
            $ConfigItemNumbers[60],
        ],
    },

    # test the incident state param with activated previous version search
    {
        Function   => ['VersionSearch'],
        SearchData => {
            ClassIDs              => [ $ConfigItemClassIDs[2], $ConfigItemClassIDs[3] ],
            InciStateIDs          => [ $InciStateListReverse{Incident} ],
            PreviousVersionSearch => 1,
        },
        ReferenceData => [
            $ConfigItemNumbers[50],
            $ConfigItemNumbers[51],
            $ConfigItemNumbers[52],
        ],
    },

    # test ConfigItemSearch() with Text type DynamicField
    {
        Function   => ['ConfigItemSearch'],
        SearchData => {
            ClassIDs                          => \@ConfigItemClassIDs,
            "DynamicField_Test1$TestIDSuffix" => { Equals => 'Test value for text field Test1' },
            Result                            => 'ARRAY'
        },
        ReferenceData => [
            $ConfigItemNumbers[53],
            $ConfigItemNumbers[52],
        ],
    },

    # test ConfigItemSearch() with Text type DynamicField using Like
    {
        Function   => ['ConfigItemSearch'],
        SearchData => {
            ClassIDs                          => \@ConfigItemClassIDs,
            "DynamicField_Test1$TestIDSuffix" => { Like => 'Test value for*' },
            Result                            => 'ARRAY'
        },
        ReferenceData => [
            $ConfigItemNumbers[53],
            $ConfigItemNumbers[52],
        ],
    },

    # test ConfigItemSearch() with Text type DynamicField using Like (not existing)
    {
        Function   => ['ConfigItemSearch'],
        SearchData => {
            ClassIDs                          => \@ConfigItemClassIDs,
            "DynamicField_Test1$TestIDSuffix" => { Like => 'Unknown data*' },
            Result                            => 'ARRAY'
        },
        ReferenceData => [],
    },

    # test ConfigItemSearch() with TextArea type DynamicField
    {
        Function   => ['ConfigItemSearch'],
        SearchData => {
            ClassIDs                          => \@ConfigItemClassIDs,
            "DynamicField_Test4$TestIDSuffix" => { Equals => 'Test value for text area field Test4' },
            Result                            => 'ARRAY'
        },
        ReferenceData => [
            $ConfigItemNumbers[53],
            $ConfigItemNumbers[52],
        ],
    },

    # test ConfigItemSearch() with TextArea type DynamicField using like
    {
        Function   => ['ConfigItemSearch'],
        SearchData => {
            ClassIDs                          => \@ConfigItemClassIDs,
            "DynamicField_Test4$TestIDSuffix" => { Like => 'Test value for text area*' },
            Result                            => 'ARRAY'
        },
        ReferenceData => [
            $ConfigItemNumbers[53],
            $ConfigItemNumbers[52],
        ],
    },

    # test ConfigItemSearch() with TextArea type DynamicField using like (not existing)
    {
        Function   => ['ConfigItemSearch'],
        SearchData => {
            ClassIDs                          => \@ConfigItemClassIDs,
            "DynamicField_Test4$TestIDSuffix" => { Like => 'Unknown data*' },
            Result                            => 'ARRAY'
        },
        ReferenceData => [],
    },

    # test ConfigItemSearch() with Date type DynamicField
    {
        Function   => ['ConfigItemSearch'],
        SearchData => {
            ClassIDs                          => \@ConfigItemClassIDs,
            "DynamicField_Test3$TestIDSuffix" => { Equals => '2023-09-01 00:00:00' },
            Result                            => 'ARRAY'
        },
        ReferenceData => [
            $ConfigItemNumbers[52],
        ],
    },

    # test ConfigItemSearch() with Date type DynamicField (not matching)
    {
        Function   => ['ConfigItemSearch'],
        SearchData => {
            ClassIDs                          => \@ConfigItemClassIDs,
            "DynamicField_Test3$TestIDSuffix" => { Equals => '2023-09-12 00:00:00' },
            Result                            => 'ARRAY'
        },
        ReferenceData => [],
    },

    # test ConfigItemSearch() with DateTime type DynamicField
    {
        Function   => ['ConfigItemSearch'],
        SearchData => {
            ClassIDs                          => \@ConfigItemClassIDs,
            "DynamicField_Test5$TestIDSuffix" => { Equals => '2023-01-01 12:00:00' },
            Result                            => 'ARRAY'
        },
        ReferenceData => [
            $ConfigItemNumbers[80],
        ],
    },

    # test ConfigItemSearch() with DateTime type DynamicField (not matching)
    {
        Function   => ['ConfigItemSearch'],
        SearchData => {
            ClassIDs                          => \@ConfigItemClassIDs,
            "DynamicField_Test5$TestIDSuffix" => { Equals => '2023-09-01 12:00:00' },
            Result                            => 'ARRAY'
        },
        ReferenceData => [],
    },

    # test ConfigItemSearch() with DateTime type DynamicField - Between
    {
        Function   => ['ConfigItemSearch'],
        SearchData => {
            ClassIDs                          => \@ConfigItemClassIDs,
            "DynamicField_Test5$TestIDSuffix" => {
                GreaterThanEquals => '2023-01-01 00:00:00',
                SmallerThanEquals => '2023-01-02 00:00:00',
            },
            Result => 'ARRAY'
        },
        ReferenceData => [
            $ConfigItemNumbers[80],
        ],
    },

    # test ConfigItemSearch() with DateTime type DynamicField - Between not matching
    {
        Function   => ['ConfigItemSearch'],
        SearchData => {
            ClassIDs                          => \@ConfigItemClassIDs,
            "DynamicField_Test5$TestIDSuffix" => {
                GreaterThanEquals => '2022-01-01 00:00:00',
                SmallerThanEquals => '2022-01-02 00:00:00',
            },
            Result => 'ARRAY'
        },
        ReferenceData => [],
    },

);

# ------------------------------------------------------------ #
# run general config item search tests
# ------------------------------------------------------------ #

# $SearchTestCount provides grouping of test cases
my $SearchTestCount = 1;

TEST:
for my $Test (@SearchTests) {

    # check SearchData attribute
    if ( !$Test->{SearchData} || ref $Test->{SearchData} ne 'HASH' ) {

        $Self->True(
            0,
            "SearchTest $SearchTestCount: No SearchData found for this test.",
        );

        next TEST;
    }

    if ( !$Test->{Function} || ref $Test->{Function} ne 'ARRAY' || !@{ $Test->{Function} } ) {
        $Test->{Function} = ['ConfigItemSearch'];
    }

    for my $Function ( @{ $Test->{Function} } ) {

        # start search
        my $ConfigItemList;

        if ( $Function eq 'ConfigItemSearch' ) {
            $ConfigItemList = [
                $ConfigItemObject->$Function(
                    %{ $Test->{SearchData} },
                )
            ];
        }
        else {
            $ConfigItemList = $ConfigItemObject->$Function(
                %{ $Test->{SearchData} },
            );
        }

        # check the config item list
        if ( $Test->{ReferenceData} ) {

            $Self->True(
                $ConfigItemList && ref $ConfigItemList eq 'ARRAY',
                "SearchTest $SearchTestCount: $Function() - List is an array reference.",
            );

            next TEST if !$ConfigItemList;
        }
        else {

            $Self->False(
                $ConfigItemList,
                "SearchTest $SearchTestCount: $Function() - Return false.",
            );

            next TEST if !$ConfigItemList;
        }

        # check number of found config items
        $Self->Is(
            scalar @{$ConfigItemList},
            scalar @{ $Test->{ReferenceData} },
            "SearchTest $SearchTestCount: $Function() - correct number of found config items",
        );

        my @ReferenceList;
        for my $Number ( @{ $Test->{ReferenceData} } ) {

            # find id of the item
            $DBObject->Prepare(
                SQL => "SELECT id FROM configitem WHERE "
                    . "configitem_number = '$Number' "
                    . "ORDER BY id DESC",
                Limit => 1,
            );

            # fetch the result
            my $ConfigItemID;
            while ( my @Row = $DBObject->FetchrowArray() ) {
                $ConfigItemID = $Row[0];
            }

            push @ReferenceList, $ConfigItemID;
        }

        # check arrays
        $Self->IsDeeply(
            $ConfigItemList,
            \@ReferenceList,
            "SearchTest $SearchTestCount: $Function() - List",
        );
    }
}
continue {
    $SearchTestCount++;
}

# ------------------------------------------------------------ #
# testing adding of invalid definitions
# ------------------------------------------------------------ #

{
    # define some invalid definitions
    my @InvalidConfigItemDefinitions;

    # Data sctructure hash elements contain no data.
    push @InvalidConfigItemDefinitions, "";

    # Data with Syntax errors
    push @InvalidConfigItemDefinitions, " [
    {
        Pages [
            {
                Name => 'Content',
                Layout => {
                    Columns => 2,
                    ColumnWidth => '1fr 1fr'
                }
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

    # generate a random name
    my $ClassName = 'UnitTest' . $Helper->GetRandomID();

    # add an unittest config item class
    my $ClassID = $GeneralCatalogObject->ItemAdd(
        Class   => 'ITSM::ConfigItem::Class',
        Name    => $ClassName,
        ValidID => 1,
        UserID  => 1,
    );

    # check class id
    if ( !$ClassID ) {
        $Self->True(
            0,
            "Can't add new config item class.",
        );
    }

    my @TestConfigItemDefinitions;
    for my $PerlDefinition (@InvalidConfigItemDefinitions) {
        my $YAMLDefinition = $YAMLObject->Dump(
            Data => eval $PerlDefinition,    ## no critic qw(BuiltinFunctions::ProhibitStringyEval)
        );

        push @TestConfigItemDefinitions, $YAMLDefinition;
    }

    for my $Definition (@TestConfigItemDefinitions) {

        # add a definition to the class
        my $Result = $ConfigItemObject->DefinitionAdd(
            ClassID    => $ClassID,
            Definition => $Definition,
            UserID     => 1,
        );

        # check definition id, must be false, because all definitions have errors
        ok( !$Result->{Success}, "As expected, could not add new config item definition." );
    }
}

# ------------------------------------------------------------ #
# testing support for attachments
# ------------------------------------------------------------ #

my $AttachmentTestConfigItemID = $ConfigItemIDs[0];

# verify that initially no attachment exists
my @AttachmentList = $ConfigItemObject->ConfigItemAttachmentList(
    ConfigItemID => $AttachmentTestConfigItemID,
);

$Self->Is(
    scalar @AttachmentList,
    0,
    'No attachments initially',
);

my @TestFileList = (
    {
        Filename    => 'first attachment',
        Content     => 'First attachment from ITSMConfigItem.t',
        ContentType => 'text/plain',
    },
    {
        Filename    => 'second attachment',
        Content     => 'Second attachment from ITSMConfigItem.t',
        ContentType => 'text/plain',
    },
);

my $FileCount;
for my $TestFile (@TestFileList) {

    $FileCount++;

    my $AddOk = $ConfigItemObject->ConfigItemAttachmentAdd(
        %{$TestFile},
        ConfigItemID => $AttachmentTestConfigItemID,
        UserID       => 1,
    );
    $Self->True(
        $AddOk,
        "Attachment $FileCount: attachment added",
    );

    my @AttachmentList = $ConfigItemObject->ConfigItemAttachmentList(
        ConfigItemID => $AttachmentTestConfigItemID,
        UserID       => 1,
    );
    $Self->Is(
        scalar @AttachmentList,
        $FileCount,
        "Attachment $FileCount: number of attachments after adding",
    );

    # check whether the last added attachment is in the list
    my %AttachmentLookup = map { $_ => 1 } @AttachmentList;
    $Self->True(
        $AttachmentLookup{ $TestFile->{Filename} },
        "Attachment $FileCount: filename from ConfigItemAttachmentList()",
    );

    # get the attachment
    my $Attachment = $ConfigItemObject->ConfigItemAttachmentGet(
        ConfigItemID => $AttachmentTestConfigItemID,
        Filename     => $TestFile->{Filename},
    );
    $Self->True(
        $Attachment,
        "Attachment $FileCount: ConfigItemAttachmentGet() returned true",
    );

    # check attachment file attributes
    for my $Attribute (qw(Filename Content ContentType)) {
        $Self->Is(
            $Attachment->{$Attribute},
            $TestFile->{$Attribute},
            "Attachment $FileCount: $Attribute from ConfigItemAttachmentGet",
        );
    }

    # check existence of attachment
    my $AttachmentExists = $ConfigItemObject->ConfigItemAttachmentExists(
        ConfigItemID => $AttachmentTestConfigItemID,
        Filename     => $TestFile->{Filename},
        UserID       => 1,
    );
    $Self->True(
        $AttachmentExists,
        "Attachment $FileCount: attachment exists",
    );

}

# now delete the attachments
$FileCount = 0;
my $MaxTestFiles = scalar @TestFileList;
for my $TestFile (@TestFileList) {

    $FileCount++;

    my $DeleteOk = $ConfigItemObject->ConfigItemAttachmentDelete(
        ConfigItemID => $AttachmentTestConfigItemID,
        Filename     => $TestFile->{Filename},
        UserID       => 1,
    );
    $Self->True(
        $DeleteOk,
        "Attachment $FileCount: attachment deleted",
    );

    my @AttachmentList = $ConfigItemObject->ConfigItemAttachmentList(
        ConfigItemID => $AttachmentTestConfigItemID,
        UserID       => 1,
    );

    $Self->Is(
        scalar @AttachmentList,
        $MaxTestFiles - $FileCount,
        "Attachment $FileCount: number of attachments after deletion",
    );

    my $AttachmentExists = $ConfigItemObject->ConfigItemAttachmentExists(
        Filename     => $TestFile->{Filename},
        ConfigItemID => $AttachmentTestConfigItemID,
        UserID       => 1,
    );
    $Self->False(
        $AttachmentExists,
        "Attachment $FileCount: attachment is gone",
    );
}

# check config item delete
my $DeleteTestCount = 1;
for my $ConfigItemID (@ConfigItemIDs) {
    my $DeleteOk = $ConfigItemObject->ConfigItemDelete(
        ConfigItemID => $ConfigItemID,
        UserID       => 1,
    );
    $Self->True(
        $DeleteOk,
        "DeleteTest $DeleteTestCount - ConfigItemDelete() (ConfigItemID=$ConfigItemID)"
    );

    # double check if config item is really deleted
    my $ConfigItemData = $ConfigItemObject->ConfigItemGet(
        ConfigItemID => $ConfigItemID,
        UserID       => 1,
        Cache        => 0,
    );
    $Self->False(
        $ConfigItemData->{ConfigItemID},
        "DeleteTest $DeleteTestCount - double check (ConfigItemID=$ConfigItemID)",
    );

    $DeleteTestCount++;
}

done_testing;

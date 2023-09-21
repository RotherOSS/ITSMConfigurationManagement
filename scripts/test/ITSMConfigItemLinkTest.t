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

use Kernel::System::UnitTest::RegisterDriver;    # Set up $Kernel::OM and the test driver $Self

our $Self;

# get needed objects
my $ConfigObject         = $Kernel::OM->Get('Kernel::Config');
my $ServiceObject        = $Kernel::OM->Get('Kernel::System::Service');
my $GeneralCatalogObject = $Kernel::OM->Get('Kernel::System::GeneralCatalog');
my $ConfigItemObject     = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');
my $LinkObject           = $Kernel::OM->Get('Kernel::System::LinkObject');

# get helper object
$Kernel::OM->ObjectParamAdd(
    'Kernel::System::UnitTest::Helper' => {
        RestoreDatabase => 1,
    },
);
my $Helper = $Kernel::OM->Get('Kernel::System::UnitTest::Helper');

# define needed variable
my $RandomID = $Helper->GetRandomID();

my $ConfigItemName = 'UnitTestConfigItemTest' . $RandomID;
my $ServiceName    = 'UnitTestServiceTest' . $RandomID;

my @ConfigItemIDs;
my @ServiceIDs;

my $CheckExpectedResults;
$CheckExpectedResults = sub {

    # get parameters
    my (%Param) = @_;

    my %ExpectedIncidentStates = %{ $Param{ExpectedIncidentStates} };
    my %ObjectNameSuffix2ID    = %{ $Param{ObjectNameSuffix2ID} };

    # check the results
    for my $Object ( sort keys %ExpectedIncidentStates ) {

        if ( $Object eq 'ITSMConfigItem' ) {

            for my $NameSuffix ( sort keys %{ $ExpectedIncidentStates{$Object} } ) {

                # get config item data
                my $ConfigItem = $ConfigItemObject->ConfigItemGet(
                    ConfigItemID => $ObjectNameSuffix2ID{$Object}->{$NameSuffix},
                );

                ############################################################
                # COMMENTS AYTE
                ############################################################

                # Check $ConfigItem->{CurInciState}  were is updated ????

                ############################################################
                # END CUSTOMIZING AYTE
                ############################################################

                # check the result
                $Self->Is(
                    $ConfigItem->{CurInciState},
                    $ExpectedIncidentStates{$Object}->{$NameSuffix},
                    "Check incident state of config item $NameSuffix.",
                );
            }
        }
        elsif ( $Object eq 'Service' ) {

            for my $NameSuffix ( sort keys %{ $ExpectedIncidentStates{$Object} } ) {

                # get service data (including the current incident state)
                my %ServiceData = $ServiceObject->ServiceGet(
                    ServiceID     => $ObjectNameSuffix2ID{$Object}->{$NameSuffix},
                    IncidentState => 1,
                    UserID        => 1,
                );

                # check the result
                $Self->Is(
                    $ServiceData{CurInciState},
                    $ExpectedIncidentStates{$Object}->{$NameSuffix},
                    "Check incident state of service $NameSuffix.",
                );
            }
        }
    }

    # Done for second run (after recalculation).
    return 1 if $Param{Recalculate};

    # Trigger recalculation of incident states for each config item.
    my $ExitCode = $Kernel::OM->Get('Kernel::System::Console::Command::Admin::ITSM::IncidentState::Recalculate')->Execute();
    $Self->Is(
        $ExitCode,
        0,
        "Admin::ITSM::IncidentState::Recalculate exit code",
    );

    # Check results again after recalculation (call myself recursively).
    $CheckExpectedResults->(
        %Param,
        Recalculate => 1,
    );

    # Done for first run (before recalculation).
    return 1;
};

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
    my $DefinitionID = $ConfigItemObject->DefinitionAdd(
        ClassID    => $ClassID,
        Definition => $Definition,
        UserID     => 1,
    );

    # check definition id
    if ( !$DefinitionID ) {

        $Self->True(
            0,
            "Can't add new config item definition.",
        );
    }

    push @ConfigItemDefinitionIDs, $DefinitionID;
}

# get definition for 'Test' class
my $DefinitionRef = $ConfigItemObject->DefinitionGet(
    ClassID => $ConfigItemClassIDs[0],
);

my %ObjectNameSuffix2ID;

# create config items
for my $NameSuffix ( 1 .. 7, qw(A B C D E F G) ) {

    # add a configitem
    my $ConfigItemID = $ConfigItemObject->ConfigItemAdd(
        Name         => $ConfigItemName . '_TestItem_' . $NameSuffix,
        ClassID      => $ConfigItemClassIDs[0], 
        DeplStateID  => $DeplStateListReverse{Production},
        InciStateID  => $InciStateListReverse{Operational},        
        UserID       => 1,
    );

    $Self->True(
        $ConfigItemID,
        "Added configitem id $ConfigItemID.",
    );

    # remember the config item id
    $ObjectNameSuffix2ID{ITSMConfigItem}->{$NameSuffix} = $ConfigItemID;

    push @ConfigItemIDs, $ConfigItemID;

    # set a name for each configitem
    my $VersionID = $ConfigItemObject->ConfigItemUpdate(
        ConfigItemID => $ConfigItemID,
        Name         => $ConfigItemName . '_TestItem_' . $NameSuffix,
        DefinitionID => $ConfigItemDefinitionIDs[0],
        DeplStateID  => $DeplStateListReverse{Production},
        InciStateID  => $InciStateListReverse{Operational},
        UserID => 1,
    );

    $Self->True(
        $VersionID,
        "Added a version for the configitem id $ConfigItemID",
    );
}

# create services
for my $NameSuffix ( 1 .. 2 ) {

    my $ServiceID = $ServiceObject->ServiceAdd(
        Name        => $ServiceName . '_' . $NameSuffix,
        ValidID     => 1,
        UserID      => 1,
        TypeID      => 1,
        Criticality => '3 normal',
    );

    $Self->True(
        $ServiceID,
        "Added service id $ServiceID.",
    );

    # remember the service id
    $ObjectNameSuffix2ID{Service}->{$NameSuffix} = $ServiceID;

    push @ServiceIDs, $ServiceID;
}

# read the original setting for IncidentLinkTypeDirection
my $OrigIncidentLinkTypeDirectionSetting = $ConfigObject->Get('ITSM::Core::IncidentLinkTypeDirection');

# set new config for IncidentLinkTypeDirection
$ConfigObject->Set(
    Key   => 'ITSM::Core::IncidentLinkTypeDirection',
    Value => {
        DependsOn => 'Source',
        Includes  => 'Source',
    },
);

# ################################################################################################################
#                                            Link Diagram
# ################################################################################################################
#
#
#
#                     6                         Service 1
#                     |                             ^
#                     |                             |
#                     |                             |
#                     v                             |
#         C <******** 5 ------> 4 ------> 3 ------> 1 *********> A *******> F **********> G
#         *           ^                   |                      ^          ^
#         *           |                   |                      *          *
#         *           |                   |                      *          *
#         *           |                   |                      *          *
#         *           |                   |         B            *          *
#         *           |                   |         *            *          *
#         *           |                   |         *            *          *
#         *           |                   |         *            *          *
#         v           |                   |         v            *          *
#         D ********> 7                   +-------> 2 ************          E
#                                                   ^
#                                                   |
#                                                   |
#                                                   |
#                                                Service 2
#
#
#
#
#  Explanation:
#               1 .. 7 and A .. G are ITSMConfigItems
#
#               DependsOn Links are shown as ----->
#               Includes  Links are shown as *****>
#
# ################################################################################################################

# define the links between CIs and Services
my %Links = (
    DependsOn => {
        ITSMConfigItem => {
            '7' => {
                ITSMConfigItem => ['5'],
            },
            '6' => {
                ITSMConfigItem => ['5'],
            },
            '5' => {
                ITSMConfigItem => ['4'],
            },
            '4' => {
                ITSMConfigItem => ['3'],
            },
            '3' => {
                ITSMConfigItem => [ '1', '2' ],
            },
            '1' => {
                Service => ['1'],
            },
        },
        Service => {
            '2' => {
                ITSMConfigItem => ['2'],
            }
        },
    },
    Includes => {
        ITSMConfigItem => {
            '5' => {
                ITSMConfigItem => ['C'],
            },
            'C' => {
                ITSMConfigItem => ['D'],
            },
            'D' => {
                ITSMConfigItem => ['7'],
            },
            'B' => {
                ITSMConfigItem => ['2'],
            },
            '2' => {
                ITSMConfigItem => ['A'],
            },
            '1' => {
                ITSMConfigItem => ['A'],
            },
            'A' => {
                ITSMConfigItem => ['F'],
            },
            'F' => {
                ITSMConfigItem => ['G'],
            },
            'E' => {
                ITSMConfigItem => ['F'],
            },
        },
    },
);

# link the config items and services as shown in the diagram
for my $LinkType ( sort keys %Links ) {
    for my $TargetObject ( sort keys %{ $Links{$LinkType} } ) {
        for my $TargetKey ( sort keys %{ $Links{$LinkType}->{$TargetObject} } ) {
            for my $SourceObject ( sort keys %{ $Links{$LinkType}->{$TargetObject}->{$TargetKey} } )
            {
                for my $SourceKey (
                    @{ $Links{$LinkType}->{$TargetObject}->{$TargetKey}->{$SourceObject} }
                    )
                {

                    # add the links
                    my $Success = $LinkObject->LinkAdd(
                        SourceObject => $SourceObject,
                        SourceKey    => $ObjectNameSuffix2ID{$SourceObject}->{$SourceKey},
                        TargetObject => $TargetObject,
                        TargetKey    => $ObjectNameSuffix2ID{$TargetObject}->{$TargetKey},
                        Type         => $LinkType,
                        State        => 'Valid',
                        UserID       => 1,
                    );

                    $Self->True(
                        $Success,
                        "LinkAdd() - $SourceObject:$SourceKey linked with $TargetObject:$TargetKey with LinkType '$LinkType'.",
                    );
                }
            }
        }
    }
}

# ------------------------------------------------------------ #
# set CI6 to "Incident" and check the results
# ------------------------------------------------------------ #

{

    my $NameSuffix    = 6;
    my $IncidentState = 'Incident';

    # change incident state
    my $VersionID = $ConfigItemObject->ConfigItemUpdate(
        ConfigItemID => $ObjectNameSuffix2ID{ITSMConfigItem}->{$NameSuffix},
        DefinitionID => $ConfigItemDefinitionIDs[0],
        DeplStateID  => $DeplStateListReverse{Production},
        InciStateID  => $InciStateListReverse{$IncidentState},
        UserID       => 1,
    );

    $Self->True(
        $VersionID,
        "Set config item id $NameSuffix to state '$IncidentState'.",
    );

    $CheckExpectedResults->(
        ExpectedIncidentStates => {
            ITSMConfigItem => {
                '1' => 'Warning',
                '2' => 'Warning',
                '3' => 'Warning',
                '4' => 'Warning',
                '5' => 'Warning',
                '1' => 'Operational',
                '2' => 'Operational',
                '3' => 'Operational',
                '4' => 'Operational',
                '5' => 'Operational',
                '6' => 'Incident',
                '7' => 'Operational',
                'A' => 'Operational',
                'B' => 'Operational',
                'C' => 'Operational',
                'D' => 'Operational',
                'E' => 'Operational',
                'F' => 'Operational',
                'G' => 'Operational',
            },
            Service => {
                '1' => 'Warning',
                '1' => 'Operational',
                '2' => 'Operational',
            },
        },
        ObjectNameSuffix2ID => \%ObjectNameSuffix2ID,
    );

}

# ------------------------------------------------------------ #
# set CI6 back to "Operational" and check the results
# ------------------------------------------------------------ #

{

    my $NameSuffix    = 6;
    my $IncidentState = 'Operational';

    # change incident state
    my $VersionID = $ConfigItemObject->VersionAdd(
        ConfigItemID => $ObjectNameSuffix2ID{ITSMConfigItem}->{$NameSuffix},
        Name         => $ConfigItemName . '_TestItem_' . $NameSuffix,
        DefinitionID => $ConfigItemDefinitionIDs[0],
        DeplStateID  => $DeplStateListReverse{Production},
        InciStateID  => $InciStateListReverse{$IncidentState},
        UserID       => 1,
    );

    $Self->True(
        $VersionID,
        "Set config item id $NameSuffix to state '$IncidentState'.",
    );

    $CheckExpectedResults->(
        ExpectedIncidentStates => {
            ITSMConfigItem => {
                '1' => 'Operational',
                '2' => 'Operational',
                '3' => 'Operational',
                '4' => 'Operational',
                '5' => 'Operational',
                '6' => 'Operational',
                '7' => 'Operational',
                'A' => 'Operational',
                'B' => 'Operational',
                'C' => 'Operational',
                'D' => 'Operational',
                'E' => 'Operational',
                'F' => 'Operational',
                'G' => 'Operational',
            },
            Service => {
                '1' => 'Operational',
                '2' => 'Operational',
            },
        },
        ObjectNameSuffix2ID => \%ObjectNameSuffix2ID,
    );

}

# ------------------------------------------------------------ #
# set CI1 to "Incident" and check the results
# ------------------------------------------------------------ #

{

    my $NameSuffix    = 1;
    my $IncidentState = 'Incident';

    # change incident state
    my $VersionID = $ConfigItemObject->VersionAdd(
        ConfigItemID => $ObjectNameSuffix2ID{ITSMConfigItem}->{$NameSuffix},
        Name         => $ConfigItemName . '_TestItem_' . $NameSuffix,
        DefinitionID => $ConfigItemDefinitionIDs[0],
        DeplStateID  => $DeplStateListReverse{Production},
        InciStateID  => $InciStateListReverse{$IncidentState},
        UserID       => 1,
    );

    $Self->True(
        $VersionID,
        "Set config item id $NameSuffix to state '$IncidentState'.",
    );

    $CheckExpectedResults->(
        ExpectedIncidentStates => {
            ITSMConfigItem => {
                '1' => 'Incident',
                '2' => 'Operational',
                '3' => 'Operational',
                '4' => 'Operational',
                '5' => 'Operational',
                '6' => 'Operational',
                '7' => 'Operational',
                'A' => 'Warning',
                'B' => 'Operational',
                'C' => 'Operational',
                'D' => 'Operational',
                'E' => 'Operational',
                'F' => 'Warning',
                'G' => 'Warning',
            },
            Service => {
                '1' => 'Incident',
                '2' => 'Operational',
            },
        },
        ObjectNameSuffix2ID => \%ObjectNameSuffix2ID,
    );

}

# ------------------------------------------------------------------------ #
# set CI5 to "Incident" and check the results (CI1 is still in "Incident")
# ------------------------------------------------------------------------ #

{

    my $NameSuffix    = 5;
    my $IncidentState = 'Incident';

    # change incident state
    my $VersionID = $ConfigItemObject->VersionAdd(
        ConfigItemID => $ObjectNameSuffix2ID{ITSMConfigItem}->{$NameSuffix},
        Name         => $ConfigItemName . '_TestItem_' . $NameSuffix,
        DefinitionID => $ConfigItemDefinitionIDs[0],
        DeplStateID  => $DeplStateListReverse{Production},
        InciStateID  => $InciStateListReverse{$IncidentState},
        UserID       => 1,
    );

    $Self->True(
        $VersionID,
        "Set config item id $NameSuffix to state '$IncidentState'.",
    );

    $CheckExpectedResults->(
        ExpectedIncidentStates => {
            ITSMConfigItem => {
                '1' => 'Incident',
                '2' => 'Warning',
                '3' => 'Warning',
                '4' => 'Warning',
                '5' => 'Incident',
                '6' => 'Operational',
                '7' => 'Warning',
                'A' => 'Warning',
                'B' => 'Operational',
                'C' => 'Warning',
                'D' => 'Warning',
                'E' => 'Operational',
                'F' => 'Warning',
                'G' => 'Warning',
            },
            Service => {
                '1' => 'Incident',
                '2' => 'Operational',
            },
        },
        ObjectNameSuffix2ID => \%ObjectNameSuffix2ID,
    );

}

# -------------------------------------------------------------------------- #
# set CI1 to "Operational" and check the results (CI5 is still in "Incident")
# -------------------------------------------------------------------------- #

{

    my $NameSuffix    = 1;
    my $IncidentState = 'Operational';

    # change incident state
    my $VersionID = $ConfigItemObject->VersionAdd(
        ConfigItemID => $ObjectNameSuffix2ID{ITSMConfigItem}->{$NameSuffix},
        Name         => $ConfigItemName . '_TestItem_' . $NameSuffix,
        DefinitionID => $ConfigItemDefinitionIDs[0],
        DeplStateID  => $DeplStateListReverse{Production},
        InciStateID  => $InciStateListReverse{$IncidentState},
        UserID       => 1,
    );

    $Self->True(
        $VersionID,
        "Set config item id $NameSuffix to state '$IncidentState'.",
    );

    $CheckExpectedResults->(
        ExpectedIncidentStates => {
            ITSMConfigItem => {
                '1' => 'Warning',
                '2' => 'Warning',
                '3' => 'Warning',
                '4' => 'Warning',
                '5' => 'Incident',
                '6' => 'Operational',
                '7' => 'Warning',
                'A' => 'Operational',
                'B' => 'Operational',
                'C' => 'Warning',
                'D' => 'Warning',
                'E' => 'Operational',
                'F' => 'Operational',
                'G' => 'Operational',
            },
            Service => {
                '1' => 'Warning',
                '2' => 'Operational',
            },
        },
        ObjectNameSuffix2ID => \%ObjectNameSuffix2ID,
    );

}

# -------------------------------------------------------------------------- #
# set CI5 to "Operational" and check the results
# -------------------------------------------------------------------------- #

{

    my $NameSuffix    = 5;
    my $IncidentState = 'Operational';

    # change incident state
    my $VersionID = $ConfigItemObject->VersionAdd(
        ConfigItemID => $ObjectNameSuffix2ID{ITSMConfigItem}->{$NameSuffix},
        Name         => $ConfigItemName . '_TestItem_' . $NameSuffix,
        DefinitionID => $ConfigItemDefinitionIDs[0],
        DeplStateID  => $DeplStateListReverse{Production},
        InciStateID  => $InciStateListReverse{$IncidentState},
        UserID       => 1,
    );

    $Self->True(
        $VersionID,
        "Set config item id $NameSuffix to state '$IncidentState'.",
    );

    $CheckExpectedResults->(
        ExpectedIncidentStates => {
            ITSMConfigItem => {
                '1' => 'Operational',
                '2' => 'Operational',
                '3' => 'Operational',
                '4' => 'Operational',
                '5' => 'Operational',
                '6' => 'Operational',
                '7' => 'Operational',
                'A' => 'Operational',
                'B' => 'Operational',
                'C' => 'Operational',
                'D' => 'Operational',
                'E' => 'Operational',
                'F' => 'Operational',
                'G' => 'Operational',
            },
            Service => {
                '1' => 'Operational',
                '2' => 'Operational',
            },
        },
        ObjectNameSuffix2ID => \%ObjectNameSuffix2ID,
    );

}

# reset the enabled setting for IncidentLinkTypeDirection to its original value
$ConfigObject->Set(
    Key   => 'ITSM::Core::IncidentLinkTypeDirection',
    Value => $OrigIncidentLinkTypeDirectionSetting,
);

# Check CI's incident state update after 'LinkAdd' action (see bug#14382).
# Set some configs for link status.
$ConfigObject->Set(
    Valid => 1,
    Key   => 'ITSMConfigItem::SetIncidentStateOnLink',
    Value => 1,
);
$ConfigObject->Set(
    Valid => 1,
    Key   => 'ITSMConfigItem::LinkStatus::DeploymentStates',
    Value => ['Production'],
);
$ConfigObject->Set(
    Valid => 1,
    Key   => 'ITSMConfigItem::LinkStatus::IncidentStates',
    Value => [ 'Incident', 'Warning', 'Operational' ],
);
$ConfigObject->Set(
    Valid => 1,
    Key   => 'ITSMConfigItem::LinkStatus::LinkTypes',
    Value => {
        RelevantTo => 'Incident',
    },
);
$ConfigObject->Set(
    Valid => 1,
    Key   => 'ITSMConfigItem::LinkStatus::TicketTypes',
    Value => ['Incident'],
);

$RandomID = $Helper->GetRandomID();

my $TicketObject = $Kernel::OM->Get('Kernel::System::Ticket');

# Create test ticket.
my $TicketID = $TicketObject->TicketCreate(
    Title        => "TN-$RandomID",
    Queue        => 'Raw',
    Lock         => 'unlock',
    Priority     => '3 normal',
    State        => 'open',
    Type         => 'Incident',
    CustomerNo   => '123465',
    CustomerUser => 'customer@example.com',
    OwnerID      => 1,
    UserID       => 1,
);
$Self->True(
    $TicketID,
    "TicketID $TicketID is created",
);

my @Tests = (
    {
        Name              => "CI-01-$RandomID",
        DeplStateID       => $DeplStateListReverse{Production},
        InciStateID       => $InciStateListReverse{Operational},
        LinkType          => 'RelevantTo',
        ExpectedInciState => 'Incident',
    },
    {
        Name              => "CI-02-$RandomID",
        DeplStateID       => $DeplStateListReverse{Production},
        InciStateID       => $InciStateListReverse{Operational},
        LinkType          => 'DependsOn',
        ExpectedInciState => 'Operational',
    },
    {
        Name              => "CI-03-$RandomID",
        DeplStateID       => $DeplStateListReverse{Production},
        InciStateID       => $InciStateListReverse{Incident},
        LinkType          => 'RelevantTo',
        ExpectedInciState => 'Incident',
    },
    {
        Name              => "CI-04-$RandomID",
        DeplStateID       => $DeplStateListReverse{Maintenance},
        InciStateID       => $InciStateListReverse{Operational},
        LinkType          => 'RelevantTo',
        ExpectedInciState => 'Operational',
    },
);

my @CIIDs;

for my $Test (@Tests) {

    # Create CI.
    my $ConfigItemID = $ConfigItemObject->ConfigItemAdd(
        Name         => $Test->{Name},
        ClassID      => $ConfigItemClassIDs[0],
        DeplStateID  => $Test->{DeplStateID},
        InciStateID  => $Test->{InciStateID},        
        UserID       => 1,
    );
    $Self->True(
        $ConfigItemID,
        "ConfigItemID $ConfigItemID is created",
    );

    push @CIIDs, $ConfigItemID;

    # Add a version.
    my $VersionID = $ConfigItemObject->ConfigItemUpdate(
        ConfigItemID => $ConfigItemID,
        Name         => $Test->{Name},
        DefinitionID => $ConfigItemDefinitionIDs[0],
        DeplStateID  => $Test->{DeplStateID},
        InciStateID  => $Test->{InciStateID},
        UserID       => 1,
    );
    $Self->True(
        $VersionID,
        "VersionID $VersionID is created",
    );

    # Add a link.
    my $Success = $LinkObject->LinkAdd(
        SourceObject => 'Ticket',
        SourceKey    => $TicketID,
        TargetObject => 'ITSMConfigItem',
        TargetKey    => $ConfigItemID,
        Type         => $Test->{LinkType},
        State        => 'Valid',
        UserID       => 1,
    );
    $Self->True(
        $Success,
        "TicketID $TicketID linked with ConfigItemID $ConfigItemID with LinkType '$Test->{LinkType}'",
    );

    my $ConfigItem = $ConfigItemObject->ConfigItemGet(
        ConfigItemID => $ConfigItemID,
    );

    # Check CI's incident state.
    $Self->Is(
        $ConfigItem->{CurInciState},
        $Test->{ExpectedInciState},
        "$Test->{Name} - CurInciState: $Test->{ExpectedInciState}",
    );
}

# Set ticket type to something different than 'Incident' to verify CI's incident state update.
my $Success = $TicketObject->TicketTypeSet(
    Type     => 'Unclassified',
    TicketID => $TicketID,
    UserID   => 1,
);
$Self->True(
    $Success,
    "Type for TicketID $TicketID is changed to 'Unclassified'",
);

for my $CIID (@CIIDs) {
    my $CI = $ConfigItemObject->ConfigItemGet(
        ConfigItemID => $CIID,
    );
    $Self->Is(
        $CI->{CurInciState},
        'Operational',
        "CIID $CIID is in 'Operational' state after ticket type update",
    );
}

# cleanup is done by RestoreDatabase

$Self->DoneTesting;

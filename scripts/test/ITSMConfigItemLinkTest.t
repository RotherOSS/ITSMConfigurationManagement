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
my $RandomID = $Helper->GetRandomID;

my $ConfigItemName = "UnitTestConfigItem_$RandomID";
my $ServiceName    = "UnitTestService_$RandomID";

sub CheckExpectedResults {
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
                is(
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
                is(
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
    is(
        $ExitCode,
        0,
        "Admin::ITSM::IncidentState::Recalculate exit code"
    );

    # Check results again after recalculation (call myself recursively).
    # There is no change in the expected result.
    CheckExpectedResults(
        %Param,
        Recalculate => 1,
    );

    # Done, two runs were executed
    return 1;
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

# Definitions are added as YAML strings
# define the first test definition (basic definition without DynamicFields)
my @ConfigItemDefinitions = ( <<'END_YAML');
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
END_YAML

# add the test classes, actually only one test class
my ( @ConfigItemClassIDs, @ConfigItemClasses, @ConfigItemDefinitionIDs );
for my $Definition (@ConfigItemDefinitions) {

    # generate a random name
    my $ClassName = 'UnitTest' . $Helper->GetRandomID;
    push @ConfigItemClasses, $ClassName;

    # add an unittest config item class
    my $ClassID = $GeneralCatalogObject->ItemAdd(
        Class   => 'ITSM::ConfigItem::Class',
        Name    => $ClassName,
        ValidID => 1,
        UserID  => 1,
    );
    ok( $ClassID, "Added class $ClassName to the general catalog" );
    push @ConfigItemClassIDs, $ClassID;

    # add a definition to the class
    my $DefinitionID = $ConfigItemObject->DefinitionAdd(
        ClassID    => $ClassID,
        Definition => $Definition,
        UserID     => 1,
    );
    is( ref $DefinitionID, '', "Added a definition, no error was returned" );
    push @ConfigItemDefinitionIDs, $DefinitionID;
}

# get definition for 'Test' class
my $DefinitionRef = $ConfigItemObject->DefinitionGet(
    ClassID => $ConfigItemClassIDs[0],
);
ref_ok( $DefinitionRef, 'HASH', 'added definition could be retrieved' );

my %ObjectNameSuffix2ID;

# create some test config items, all the config items are operational initially
for my $NameSuffix ( 1 .. 7, qw(A B C D E F G) ) {

    # add a configitem
    my $ConfigItemID = $ConfigItemObject->ConfigItemAdd(
        Name        => join( '_', $ConfigItemName, 'TestItem', $NameSuffix ),
        ClassID     => $ConfigItemClassIDs[0],
        DeplStateID => $DeplStateListReverse{Production},
        InciStateID => $InciStateListReverse{Operational},
        UserID      => 1,
    );
    ok( $ConfigItemID, "Added configitem id $ConfigItemID." );

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
        UserID       => 1,
    );
    ok( $VersionID, "Added a version for the configitem id $ConfigItemID" );
}

# create services
my @ServiceIDs;
for my $NameSuffix ( 1 .. 2 ) {

    my $ServiceID = $ServiceObject->ServiceAdd(
        Name        => $ServiceName . '_' . $NameSuffix,
        ValidID     => 1,
        UserID      => 1,
        TypeID      => 1,
        Criticality => '3 normal',
    );
    ok( $ServiceID, "Added service id $ServiceID." );

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
            for my $SourceObject ( sort keys %{ $Links{$LinkType}->{$TargetObject}->{$TargetKey} } ) {
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

                    ok(
                        $Success,
                        "LinkAdd() - $SourceObject:$SourceKey linked with $TargetObject:$TargetKey with LinkType '$LinkType'."
                    );
                }
            }
        }
    }
}

# set CI6 to "Incident" and check the results
subtest 'CI6 set to Incident with ConfigItemUpdate()' => sub {
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
    ok( $VersionID, "Set config item id $NameSuffix to state '$IncidentState'." );

    CheckExpectedResults(
        ExpectedIncidentStates => {
            ITSMConfigItem => {
                '1' => 'Warning',       # because 1 depends on 3
                '2' => 'Warning',       # because 2 depends on 3
                '3' => 'Warning',       # because 3 depends on 4
                '4' => 'Warning',       # because 4 depends on 5
                '5' => 'Warning',       # because 5 depends on 6
                '6' => 'Incident',      # because it was explicitly set
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
                '1' => 'Warning',       # because of connection with CI 1
                '2' => 'Operational',
            },
        },
        ObjectNameSuffix2ID => \%ObjectNameSuffix2ID,
    );
};

# set CI6 back to "Operational" and check the results
subtest 'CI6 set to back to Operational with VersionAdd()' => sub {
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
    ok( $VersionID, "Set config item id $NameSuffix to state '$IncidentState'." );

    CheckExpectedResults(
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

};

# set CI1 to "Incident" and check the results
subtest 'CI1 set to Incident with VersionAdd()' => sub {
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
    ok( $VersionID, "Set config item id $NameSuffix to state '$IncidentState'." );

    CheckExpectedResults(
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
};

# set CI5 to "Incident" and check the results (CI1 is still in "Incident")
subtest 'CI6 set to Incident with VersionAdd()' => sub {
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
    ok( $VersionID, "Set config item id $NameSuffix to state '$IncidentState'." );

    CheckExpectedResults(
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

};

# set CI1 to "Operational" and check the results (CI5 is still in "Incident")
subtest 'CI1 set to Operational with VersionAdd' => sub {
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
    ok( $VersionID, "Set config item id $NameSuffix to state '$IncidentState'." );

    CheckExpectedResults(
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
};

# set CI5 to "Operational" and check the results
subtest 'CI5 set to Operational with VersionAdd' => sub {
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
    ok( $VersionID, "Set config item id $NameSuffix to state '$IncidentState'." );

    CheckExpectedResults(
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
};

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
ok( $TicketID, "TicketID $TicketID is created" );

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
        Name        => $Test->{Name},
        ClassID     => $ConfigItemClassIDs[0],
        DeplStateID => $Test->{DeplStateID},
        InciStateID => $Test->{InciStateID},
        UserID      => 1,
    );
    ok( $ConfigItemID, "ConfigItemID $ConfigItemID is created" );

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
    ok( $VersionID, "VersionID $VersionID is created" );

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
    ok( $Success, "TicketID $TicketID linked with ConfigItemID $ConfigItemID with LinkType '$Test->{LinkType}'" );

    my $ConfigItem = $ConfigItemObject->ConfigItemGet(
        ConfigItemID => $ConfigItemID,
    );

    # Check CI's incident state.
    is(
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
ok( $Success, "Type for TicketID $TicketID is changed to 'Unclassified'" );

for my $CIID (@CIIDs) {
    my $CI = $ConfigItemObject->ConfigItemGet(
        ConfigItemID => $CIID,
    );
    is(
        $CI->{CurInciState},
        'Operational',
        "CIID $CIID is in 'Operational' state after ticket type update",
    );
}

done_testing;

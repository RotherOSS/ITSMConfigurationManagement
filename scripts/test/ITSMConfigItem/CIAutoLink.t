# --
# OTOBO is a web-based ticketing system for service organisations.
# --
# Copyright (C) 2001-2020 OTRS AG, https://otrs.com/
# Copyright (C) 2019-2025 Rother OSS GmbH, https://otobo.io/
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

################################
# test auto inks
# between CI items and Tickets
# example is
#  Subsidiary -> TicketRef
################################

# boilerplate

$Kernel::OM->ObjectParamAdd(
    'Kernel::System::UnitTest::Helper' => {
        RestoreDatabase => 1,
    },
);

my $Helper = $Kernel::OM->Get('Kernel::System::UnitTest::Helper');

my $TestUserLogin = $Helper->TestUserCreate(
    Groups => [ 'admin', 'users' ],
);

my $UserID = $Kernel::OM->Get('Kernel::System::User')->UserLookup(
    UserLogin => $TestUserLogin
);

my $RandomID = $Helper->GetRandomID;

# assure std classes have been imported
_LoadReadyToImportClasses();

# global OM objects
my $DBObject           = $Kernel::OM->Get('Kernel::System::DB');
my $ConfigItemObject   = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');
my $LinkObject         = $Kernel::OM->Get('Kernel::System::LinkObject');
my $DynamicFieldObject = $Kernel::OM->Get('Kernel::System::DynamicField');
my $TicketObject       = $Kernel::OM->Get('Kernel::System::Ticket');

# catch state before test run
my $InitialConfigItemsCount     = _FetchConfigItemCount();
my $InitialConfigItemLinksCount = _FetchConfigItemLinksCount();
my $InitialLinkRelationsCount   = _FetchLinkRelationsCount();

###############################
# prepare environment
###############################

# fetch config state ids
my $IncidientStateOperationalID = _GeneralCatalogID(
    Class => 'ITSM::Core::IncidentState',
    Name  => 'Operational',
);

my $DeploymentStateProductionID = _GeneralCatalogID(
    Class => 'ITSM::ConfigItem::DeploymentState',
    Name  => 'Production',
);

# fetch subsidiary class from general catalog
my $SubsidiaryClassID = _GeneralCatalogID(
    Class => 'ITSM::ConfigItem::Class',
    Name  => 'Subsidiary',
);
ok( $SubsidiaryClassID, "Subsidiary class found." );

# possible link types configured
my %PossibleTypesList = $LinkObject->PossibleTypesList(
    Object1 => 'Ticket',
    Object2 => 'ITSMConfigItem',
);

my @LinkTypes = keys %PossibleTypesList;

###############################
# iterate over avail LinkTypes
###############################

for my $LinkType (@LinkTypes) {

    subtest "Testing LinkType=$LinkType" => sub {

        my $TypeID = $LinkObject->TypeLookup(
            Name   => $LinkType,
            UserID => $UserID,
        );

        my %TypeData = $LinkObject->TypeGet(
            TypeID => $TypeID,
        );

        my $IsPointed = $TypeData{Pointed};

        my $DynamicFieldConfig = _CreateDFReferenceToTicket( LinkType => $LinkType );
        ok( $DynamicFieldConfig, "ReferenceToTicket DF $LinkType created." );

        ok(
            _ChangeSubsidiaryDefinitionAddTicketRefDF( LinkType => $LinkType ),
            'Updated Subsidiary Definition to include ReferenceToTicket DF successfully.'
        );
        _SyncConfigItemDFs( LinkType => $LinkType );

        ###############################
        # create test config items
        ###############################

        # create test ticket

        my $TestTicket1ID = _CreateTestTicket(
            Title              => "TestTicket1_$LinkType$RandomID",
            DynamicFieldConfig => $DynamicFieldConfig,
        );

        # create a test subsidiary with a DF reference to Ticket
        my $TestSubsidiaryID = $ConfigItemObject->ConfigItemAdd(
            ClassID                                            => $SubsidiaryClassID,
            Name                                               => 'DerBauernhof' . $LinkType . $RandomID,
            DeplStateID                                        => $DeploymentStateProductionID,
            InciStateID                                        => $IncidientStateOperationalID,
            Description                                        => 'ABCD',
            UserID                                             => $UserID,
            "DynamicField_TicketRef" . $LinkType . "$RandomID" => [
                $TestTicket1ID
            ],
        );

        subtest "Single Link has been created for LinkType=$LinkType" => sub {

            ok(
                $TestSubsidiaryID,
                "TestSubsidiary 'DerBauernhof$LinkType$RandomID' ($TestSubsidiaryID) with link to Ticket $TestTicket1ID created"
            );

            ok(
                _AssertHasLinkObjectLinks(
                    SubsidiaryID => $TestSubsidiaryID,
                    LinkType     => $LinkType,
                    Links        => [
                        $IsPointed
                        ?
                            [ Target => $TestTicket1ID ]
                        :
                            [ Source => $TestTicket1ID ],
                    ]
                ),
                "Has One Link Source => TicketID:$TestTicket1ID."
            );
        };

        subtest "Change link direction does not change existing links" => sub {

            $DynamicFieldConfig = _UpdateReferenceToTicketDFLinkDirection(
                LinkType      => $LinkType,
                LinkDirection => 'ReferencingIsTarget'
            );

            ok(
                _AssertHasLinkObjectLinks(
                    SubsidiaryID => $TestSubsidiaryID,
                    LinkType     => $LinkType,
                    Links        => [
                        $IsPointed
                        ?
                            [ Target => $TestTicket1ID ]
                        :
                            [ Source => $TestTicket1ID ],
                    ]
                ),
                "Has One Link Source => TicketID:$TestTicket1ID."
            );
        };

        my $TestTicket2ID;
        subtest "Add another link" => sub {

            $TestTicket2ID = _CreateTestTicket(
                Title              => "TestTicket2_$LinkType$RandomID",
                DynamicFieldConfig => $DynamicFieldConfig,
            );

            ok(
                $ConfigItemObject->ConfigItemUpdate(
                    ConfigItemID                                       => $TestSubsidiaryID,
                    UserID                                             => $UserID,
                    "DynamicField_TicketRef" . $LinkType . "$RandomID" => [
                        $TestTicket2ID
                    ],
                ),
                "Updated ConfigItem to point to TestTickt 2"
            );

            ok(
                _AssertHasLinkObjectLinks(
                    SubsidiaryID => $TestSubsidiaryID,
                    LinkType     => $LinkType,
                    Links        => [
                        $IsPointed
                        ?
                            [ Target => $TestTicket1ID ]
                        :
                            [ Source => $TestTicket1ID ],
                        [ Source => $TestTicket2ID ],
                    ]
                ),
                "Has Two Links ($TestTicket1ID, $TestTicket2ID)."
            );
        };

        # add links twice
        # switch back to first linked object,
        # and again to second one. no new
        # links expected to be created

        subtest "Add links twice - no duplication of existing links" => sub {

            ok(
                $ConfigItemObject->ConfigItemUpdate(
                    ConfigItemID                                       => $TestSubsidiaryID,
                    UserID                                             => $UserID,
                    "DynamicField_TicketRef" . $LinkType . "$RandomID" => [
                        $TestTicket1ID
                    ],
                ),
                "Updated ConfigItem to point to TestTicket 1"
            );

            ok(
                _AssertHasLinkObjectLinks(
                    SubsidiaryID => $TestSubsidiaryID,
                    LinkType     => $LinkType,
                    Links        => [
                        $IsPointed
                        ?
                            [ Target => $TestTicket1ID ]
                        :
                            [ Source => $TestTicket1ID ],
                        [ Source => $TestTicket2ID ],
                    ]
                ),
                "Has Two Links ($TestTicket1ID, $TestTicket2ID)."
            );

            ok(
                $ConfigItemObject->ConfigItemUpdate(
                    ConfigItemID                                       => $TestSubsidiaryID,
                    UserID                                             => $UserID,
                    "DynamicField_TicketRef" . $LinkType . "$RandomID" => [
                        $TestTicket2ID
                    ],
                ),
                "Updated ConfigItem to point to TestTicket 1"
            );

            ok(
                _AssertHasLinkObjectLinks(
                    SubsidiaryID => $TestSubsidiaryID,
                    LinkType     => $LinkType,
                    Links        => [
                        $IsPointed
                        ?
                            [ Target => $TestTicket1ID ]
                        :
                            [ Source => $TestTicket1ID ],
                        [ Source => $TestTicket2ID ],
                    ]
                ),
                "Has Two Links ($TestTicket1ID, $TestTicket2ID)."
            );

        };

        ###############################
        # cleanup
        ###############################

        $ConfigItemObject->EventHandlerTransaction();

        # cleanup
        ok(
            $ConfigItemObject->ConfigItemDelete(
                ConfigItemID => $TestSubsidiaryID,
                UserID       => $UserID
            ),
            "TestSubsidiary deleted"
        );

        # assert we didn't leak config items and config item links and link_relations
        my $FinalConfigItemsCount     = _FetchConfigItemCount();
        my $FinalConfigItemLinksCount = _FetchConfigItemLinksCount();
        my $FinalLinkRelationsCount   = _FetchLinkRelationsCount();

        is(
            $InitialConfigItemsCount,
            $FinalConfigItemsCount,
            "No CI have been leaked"
        );

        is(
            $InitialConfigItemLinksCount,
            $FinalConfigItemLinksCount,
            "No CI links have been leaked"
        );

        is(
            $InitialLinkRelationsCount,
            $FinalLinkRelationsCount,
            "No LinkObjects have been leaked"
        );
    };
}

done_testing;

###############################
# procedural helper methods
###############################

# Prepare the General Catalog classes by reloading
# (and updating) the whole ready2load bundle

sub _LoadReadyToImportClasses {

    my $Home = $Kernel::OM->Get('Kernel::Config')->Get('Home');

    my $MainObject = $Kernel::OM->Get('Kernel::System::Main');

    my $Content = $MainObject->FileRead(

        #        Location => "$Home/var/itsm/configitemclasses/IT-Servicemanagement-11_0_2.yml",
        Location => "$Home/scripts/test/sample/ITSMConfigurationManagement/Links/unittest.yml",
        Mode     => 'utf8',
    );

    ok( $Content, "Classes have been loaded." );

    $Content = ${ $Content || \'' };

    $Content = $Kernel::OM->Get('Kernel::System::YAML')->Load(
        Data => $Content,
    );

    if ( ref $Content eq 'HASH' ) {
        $Content = [$Content];
    }

    my $ConfigItemObject = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');

    # import the class YAML file
    my $Result = $ConfigItemObject->ClassImport(
        Content     => $Content,
        ClassExists => 'UPDATE',
    );

    ok( $Result, "Classes have been imported." );

    return;
}

sub _FetchConfigItemCount {

    my $Success = $DBObject->Prepare(
        SQL => 'SELECT Count(id) FROM configitem',
    );

    if ( my @Row = $DBObject->FetchrowArray ) {
        return $Row[0];
    }

    return 0;
}

sub _FetchConfigItemLinksCount {

    my $Success = $DBObject->Prepare(
        SQL => 'SELECT Count(id) FROM configitem_link',
    );

    if ( my @Row = $DBObject->FetchrowArray ) {
        return $Row[0];
    }

    return 0;
}

sub _FetchLinkRelationsCount {

    my $Success = $DBObject->Prepare(
        SQL => 'SELECT * FROM link_relation',
    );

    my $Count = 0;
    while ( my @Row = $DBObject->FetchrowArray ) {
        $Count++;
    }

    return $Count;
}

sub _GetVersionIDFromVersionString {

    my %Param = @_;

    my $Versions      = $Param{Versions};
    my $VersionString = $Param{VersionString};

    for my $Version (@$Versions) {

        if ( $Version->{VersionString} eq $VersionString ) {
            return $Version->{VersionID};
        }
    }

    return;
}

sub _GeneralCatalogID {

    my %Param = @_;

    my $GeneralCatalogObject = $Kernel::OM->Get('Kernel::System::GeneralCatalog');

    my $CatalogItem = $GeneralCatalogObject->ItemGet(
        Class => $Param{Class},
        Name  => $Param{Name},
    );

    return $CatalogItem->{ItemID};
}

sub _CreateDFReferenceToTicket {

    my %Param = @_;

    my $ConfigHashRef = {
        DisplayType                => 'TicketNumberTitle',
        EditFieldMode              => 'Dropdown',
        ImportSearchAttribute      => '',
        LinkDirection              => 'ReferencingIsSource',
        LinkObjectForReferenceType => $Param{LinkType},        #'RelevantTo',
        MultiValue                 => '0',
        Multiselect                => 0,
        PossibleNone               => '1',
        Queue                      => [ 1, 2, 3, 4 ],
        ReferenceFilterList        => [],
        ReferencedObjectType       => 'Ticket',
        SearchAttribute            => 'Title',
        Tooltip                    => '',
    };

    my $DynamicFieldObject = $Kernel::OM->Get('Kernel::System::DynamicField');
    my $ID                 = $DynamicFieldObject->DynamicFieldAdd(
        Name       => 'TicketRef' . $Param{LinkType} . $RandomID,
        Label      => 'Ticket Reference' . $Param{LinkType} . $RandomID,
        FieldOrder => 4711,                                                # mandatory, display order
        FieldType  => 'Ticket',
        ObjectType => 'ITSMConfigItem',
        Config     => $ConfigHashRef,
        Reorder    => 1,                                                   # or 0, to trigger reorder function, default 1
        ValidID    => 1,
        UserID     => $UserID,
    );

    my $DynamicFieldConfig = $DynamicFieldObject->DynamicFieldGet( ID => $ID );
    return $DynamicFieldConfig;
}

sub _ChangeSubsidiaryDefinitionAddTicketRefDF {

    my %Param = @_;

    my $Definition = $ConfigItemObject->DefinitionGet(
        ClassID => $SubsidiaryClassID,
    );

    my $DefinitionRef = $Definition->{DefinitionRef};

    # add the TicketRef DF

    $DefinitionRef->{Sections}->{Address}->{Content} = [
        {
            'Header' => 'Address'
        },
        {
            'DF' => 'Location-Street'
        },
        {
            'DF' => 'Location-City'
        },
        {
            'DF' => 'Location-ReferenceToCountry'
        },
        {
            'DF' => 'Location-Latitude'
        },
        {
            'DF' => 'Location-Longitude'
        },

        # add this one:
        {
            'DF' => 'TicketRef' . $Param{LinkType} . $RandomID
        },
    ];

    my $YAMLObject = $Kernel::OM->Get('Kernel::System::YAML');
    my $YAMLString = $YAMLObject->Dump(
        Data => $DefinitionRef,
    );

    return $ConfigItemObject->DefinitionAdd(
        ClassID    => $SubsidiaryClassID,
        Definition => $YAMLString,
        UserID     => $UserID,

        #    Force      => 1,        # hm
    )->{Success};
}

sub _CreateTestTicket {

    my %Param = @_;

    my $TicketID = $TicketObject->TicketCreate(
        Title        => $Param{Title},
        Queue        => 'Raw',
        Lock         => 'unlock',
        Priority     => '3 normal',
        State        => 'closed successful',
        CustomerNo   => '123465',
        CustomerUser => 'unittest@otobo.org',
        OwnerID      => $UserID,
        UserID       => $UserID,
    );

    ok( $TicketID, "Ticket '$Param{Title}' ($TicketID) created" );

    return $TicketID;
}

# call as
# _AssertHasLinkObjectLinks(
#   SubsidiaryID => $TestSubsidiaryID,
#   LinkType => $LinkType,
#   Links => [
#       [ Source => $SomeID ],
#       [ Source => $SomeID ],
#       [ Target => $SomeID ],
# ....
#   ]
# )

sub _AssertHasLinkObjectLinks {

    my %Param = @_;

    my $LinkType     = $Param{LinkType};
    my $SubsidiaryID = $Param{SubsidiaryID};

    my @Links             = $Param{Links}->@*;
    my $ExpectedLinkCount = scalar @Links;

    my $LinkRelationsCount = _FetchLinkRelationsCount() - $InitialLinkRelationsCount;
    is( $LinkRelationsCount, $ExpectedLinkCount, "There are  $LinkRelationsCount LinkObject-Links of Type $LinkType." );

    my $LinkList = $LinkObject->LinkList(
        Object    => 'ITSMConfigItem',
        Key       => $SubsidiaryID,
        Object2   => 'Ticket',
        State     => 'Valid',
        Type      => $LinkType,
        Direction => 'Both',
        UserID    => $UserID,
    );

    for my $Link (@Links) {

        my $LinkDest = $Link->[0];
        my $LinkedID = $Link->[1];
        if ( exists $LinkList->{'Ticket'}->{$LinkType}->{$LinkDest} ) {

            my $IDs = $LinkList->{'Ticket'}->{$LinkType}->{$LinkDest};

            return 0 if !exists $IDs->{$LinkedID};
        }
        else {
            return 0;
        }
    }

    return 1;
}

sub _UpdateReferenceToTicketDFLinkDirection {

    my %Param = @_;

    my $LinkType      = $Param{LinkType};
    my $LinkDirection = $Param{LinkDirection} || 'ReferencingIsSource';

    my $DynamicField = $DynamicFieldObject->DynamicFieldGet( Name => 'TicketRef' . $Param{LinkType} . $RandomID );

    my $DynamicFieldConfig;

    subtest "TicketRef DF definition updated, link direction changed to $LinkDirection." => sub {

        ok( $DynamicField, 'TicketRef DF found.' );

        my $ConfigHashRef = $DynamicField->{Config};

        $ConfigHashRef->{LinkDirection} = $LinkDirection;

        my $Success = $DynamicFieldObject->DynamicFieldUpdate(
            ID         => $DynamicField->{ID},      # mandatory
            Name       => $DynamicField->{Name},    #'NameForField',  # mandatory
            Label      => 'a description',          # mandatory, label to show
            FieldOrder => 4711,                     # mandatory, display order
            FieldType  => 'Ticket',                 # mandatory, selects the DF backend to use for this field
            ObjectType => 'ITSMConfigItem',         # this controls which object the dynamic field links to
                                                    # allow only lowercase letters
            Config     => $ConfigHashRef,           # it is stored on YAML format
                                                    # to individual articles, otherwise to tickets
            ValidID    => 1,
            Reorder    => 1,                        # or 0, to trigger reorder function, default 1
                                                    # 0 is only used internally to prevent redundant execution on order change
                                                    # no update event will be triggered for 0
            UserID     => $UserID,
        );

        ok( $Success, "TicketRef DF definition updated, link direction changed to $LinkDirection." );

        _SyncConfigItemDFs( LinkType => $LinkType );

        $DynamicFieldConfig = $DynamicFieldObject->DynamicFieldGet( ID => $DynamicField->{ID} );
    };

    return $DynamicFieldConfig;
}

sub _SyncConfigItemDFs {

    my %Param = @_;

    my $LinkType = $Param{LinkType};

    my $DynamicFieldConfig = $DynamicFieldObject->DynamicFieldGet(
        Name => 'TicketRef' . $Param{LinkType} . $RandomID,
    );

    $ConfigItemObject->DefinitionSetOutOfSync(
        Classes => {
            $SubsidiaryClassID => [ $DynamicFieldConfig->{ID} ],
        },
    );
    $ConfigItemObject->EventHandlerTransaction();

    $ConfigItemObject->DefinitionSync();

    $ConfigItemObject->EventHandlerTransaction();

    return;
}

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

##################################
# test auto inks
# between Ticket items and CIs
# example is
#  TicketDF -> ConfigItemReference
##################################

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
my $BackendObject      = $Kernel::OM->Get('Kernel::System::DynamicField::Backend');
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
ok( $SubsidiaryClassID, "Subsidiary class found" );

# possible link types configured
my %PossibleTypesList = $LinkObject->PossibleTypesList(
    Object1 => 'Ticket',
    Object2 => 'ITSMConfigItem',
);

my @LinkTypes = keys %PossibleTypesList;

###############################
# iterate over avail LinkTypes
###############################

my $TestSubsidiaryID;
my $TicketID;

for my $LinkType (@LinkTypes) {

    subtest "Testing with LinkType $LinkType" => sub {

        my $TypeID = $LinkObject->TypeLookup(
            Name   => $LinkType,
            UserID => $UserID,
        );

        my %TypeData = $LinkObject->TypeGet(
            TypeID => $TypeID,
        );

        my $IsPointed = $TypeData{Pointed};

        my $DynamicFieldConfig = _CreateDFReferenceToCI( LinkType => $LinkType );
        ok( $DynamicFieldConfig, "DF $LinkType Created." );

        subtest "a) AutoLink gets created" => sub {

            ###############################
            # create test config items
            ###############################

            # create a test subsidiary
            $TestSubsidiaryID = $ConfigItemObject->ConfigItemAdd(
                ClassID     => $SubsidiaryClassID,
                Name        => 'DerBauernhof' . $RandomID,
                DeplStateID => $DeploymentStateProductionID,
                InciStateID => $IncidientStateOperationalID,
                Description => 'ABCD',
                UserID      => $UserID,
            );

            ok(
                $TestSubsidiaryID,
                "TestSubsidiary $TestSubsidiaryID created"
            );

            # create test ticket

            $TicketID = _CreateTestTicket(
                Title              => "TestTicket1_$LinkType$RandomID",
                DynamicFieldConfig => $DynamicFieldConfig,
                ConfigItemID       => $TestSubsidiaryID,
            );

            ok(
                _AssertHasLinkObjectLinks(
                    TicketID => $TicketID,
                    LinkType => $LinkType,
                    Links    => [
                        $IsPointed
                        ?
                            [ Target => $TestSubsidiaryID ]
                        :
                            [ Source => $TestSubsidiaryID ],
                    ]
                ),
                "There is one Link of type $LinkType to CI $TestSubsidiaryID."
            );
        };

        subtest "b) change Link Direction" => sub {

            $DynamicFieldConfig = _UpdateReferenceToCIDFLinkDirection(
                LinkType      => $LinkType,
                LinkDirection => 'ReferencingIsTarget',
            );

            ok(
                _AssertHasLinkObjectLinks(
                    TicketID => $TicketID,
                    LinkType => $LinkType,
                    Links    => [
                        $IsPointed
                        ?
                            [ Target => $TestSubsidiaryID ]
                        :
                            [ Source => $TestSubsidiaryID ],
                    ]
                ),
                "There is one Link of type $LinkType to CI $TestSubsidiaryID."
            );

        };

        subtest "c) new Ticket with new LinkDirection" => sub {

            $TicketID = _CreateTestTicket(
                Title              => "TestTicket2_$LinkType$RandomID",
                DynamicFieldConfig => $DynamicFieldConfig,
                ConfigItemID       => $TestSubsidiaryID,
            );

            ok(
                _AssertHasLinkObjectLinks(
                    TicketID => $TicketID,
                    LinkType => $LinkType,
                    Links    => [
                        [ Source => $TestSubsidiaryID ]
                    ]
                ),
                "There is one Link of type $LinkType to CI $TestSubsidiaryID."
            );
        };

        ###############################
        # cleanup
        ###############################

        subtest "d) Cleanup $LinkType" => sub {

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
        }
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
    my ($Count) = $DBObject->SelectRowArray(
        SQL => 'SELECT COUNT(id) FROM configitem',
    );

    return $Count // 0;
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

sub _CreateDFReferenceToCI {

    my %Param = @_;

    my $ConfigHashRef = {
        DisplayType           => 'ConfigItemName',
        EditFieldMode         => 'Dropdown',
        ImportSearchAttribute => '',
        LinkDirection         => 'ReferencingIsSource',
        LinkType              => $Param{LinkType},        #'RelevantTo',
        MultiValue            => '0',
        Multiselect           => 0,
        PossibleNone          => '1',
        ReferenceFilterList   => [],
        ReferencedObjectType  => 'ITSMConfigItem',
        SearchAttribute       => 'Name',
        Tooltip               => '',
    };

    my $DynamicFieldObject = $Kernel::OM->Get('Kernel::System::DynamicField');
    my $ID                 = $DynamicFieldObject->DynamicFieldAdd(
        Name       => 'ConfigItemRef' . $Param{LinkType} . $RandomID,
        Label      => 'Config Item Reference' . $Param{LinkType} . $RandomID,
        FieldOrder => 4711,                                                     # mandatory, display order
        FieldType  => 'ConfigItem',
        ObjectType => 'Ticket',
        Config     => $ConfigHashRef,
        Reorder    => 1,                                                        # or 0, to trigger reorder function, default 1
        ValidID    => 1,
        UserID     => $UserID,
    );

    my $DynamicFieldConfig = $DynamicFieldObject->DynamicFieldGet( ID => $ID );
    return $DynamicFieldConfig;
}

sub _ChangeTicketDefinitionAddConfigItemRefDF {

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

    ok(
        $BackendObject->ValueSet(
            DynamicFieldConfig => $Param{DynamicFieldConfig},
            ObjectID           => $TicketID,
            Value              => [ $Param{ConfigItemID} ],
            UserID             => $UserID,
        ),
        "DF Value set to $Param{ConfigItemID}."
    );

    return $TicketID;
}

# call as
# _AssertHasLinkObjectLinks(
#   TicketID => $Ticket,
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

    my $LinkType = $Param{LinkType};
    my $TicketID = $Param{TicketID};

    my @Links             = $Param{Links}->@*;
    my $ExpectedLinkCount = scalar @Links;

    my $LinkList = $LinkObject->LinkList(
        Object    => 'Ticket',
        Key       => $TicketID,
        Object2   => 'ITSMConfigItem',
        State     => 'Valid',
        Type      => $LinkType,
        Direction => 'Both',
        UserID    => $UserID,
    );

    for my $Link (@Links) {

        my $LinkDest = $Link->[0];
        my $LinkedID = $Link->[1];
        if ( exists $LinkList->{'ITSMConfigItem'}->{$LinkType}->{$LinkDest} ) {

            my $IDs = $LinkList->{'ITSMConfigItem'}->{$LinkType}->{$LinkDest};

            return 0 if !exists $IDs->{$LinkedID};
        }
        else {
            return 0;
        }
    }

    return 1;
}

sub _UpdateReferenceToCIDFLinkDirection {

    my %Param = @_;

    my $LinkType      = $Param{LinkType};
    my $LinkDirection = $Param{LinkDirection} || 'ReferencingIsSource';

    my $DynamicField = $DynamicFieldObject->DynamicFieldGet(
        Name => 'ConfigItemRef' . $Param{LinkType} . $RandomID,
    );

    my $DynamicFieldConfig;

    subtest "TicketRef DF definition updated, link direction changed to $LinkDirection." => sub {

        ok( $DynamicField, 'TicketRef DF found.' );

        my $ConfigHashRef = $DynamicField->{Config};

        $ConfigHashRef->{LinkDirection} = $LinkDirection;

        my $Success = $DynamicFieldObject->DynamicFieldUpdate(
            ID         => $DynamicField->{ID},      # mandatory
            Name       => $DynamicField->{Name},    #'NameForField',  # mandatory
            Label      => $DynamicField->{Label},
            FieldOrder => 4711,                     # mandatory, display order
            FieldType  => 'ConfigItem',             # mandatory, selects the DF backend to use for this field
            ObjectType => 'Ticket',                 # this controls which object the dynamic field links to
                                                    # allow only lowercase letters
            Config     => $ConfigHashRef,           # it is stored on YAML format
                                                    # to individual articles, otherwise to tickets
            ValidID    => 1,
            Reorder    => 1,                        # or 0, to trigger reorder function, default 1
                                                    # 0 is only used internally to prevent redundant execution on order change
                                                    # no update event will be triggered for 0
            UserID     => $UserID,
        );

        ok( $Success, "TicketRef DF definition updated." );

        _SyncConfigItemDFs( LinkType => $LinkType );

        $DynamicFieldConfig = $DynamicFieldObject->DynamicFieldGet( ID => $DynamicField->{ID} );
    };

    return $DynamicFieldConfig;
}

sub _SyncConfigItemDFs {

    my %Param = @_;

    my $LinkType = $Param{LinkType};

    my $DynamicFieldConfig = $DynamicFieldObject->DynamicFieldGet(
        Name => 'ConfigItemRef' . $LinkType . $RandomID,
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

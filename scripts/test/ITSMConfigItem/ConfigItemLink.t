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

###############################
# boilerplate
###############################

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
my $DBObject         = $Kernel::OM->Get('Kernel::System::DB');
my $ConfigItemObject = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');
my $TicketObject     = $Kernel::OM->Get('Kernel::System::Ticket');
my $LinkObject       = $Kernel::OM->Get('Kernel::System::LinkObject');

###############################
# catch state before test run
###############################

my $InitialConfigItemsCount     = _FetchConfigItemCount();
my $InitialConfigItemLinksCount = _FetchConfigItemLinksCount();

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

# fetch country class from general catalog
my $CountryClassID = _GeneralCatalogID(
    Class => 'ITSM::ConfigItem::Class',
    Name  => 'Country',
);
ok( $CountryClassID, "Country class found" );

# add a version trigger to Country on Name attribute
ok(
    _AddVersionTriggerOnNameChangeToCountryClass(),
    'Updated VersionTrigger'
);

my %PossibleTypesList = $LinkObject->PossibleTypesList(
    Object1 => 'Ticket',
    Object2 => 'ITSMConfigItem',
);

my @LinkTypes = keys %PossibleTypesList;

###############################
# iterate over avail LinkTypes
###############################

for my $LinkType (@LinkTypes) {

    ###############################
    # create test config items
    ###############################

    # create TestLocation1
    my $TestLocation1ID = $ConfigItemObject->ConfigItemAdd(
        ClassID     => $CountryClassID,
        Name        => 'WellblechsHausen' . $LinkType . $RandomID,
        DeplStateID => $DeploymentStateProductionID,
        InciStateID => $IncidientStateOperationalID,
        Description => 'ABCD',
        UserID      => $UserID,
    );
    ok( $TestLocation1ID, "TestLocation1 created" );

    # assert there is 1 version with given name
    _AssertLocationVersion(
        Location => $TestLocation1ID,
        Versions => [
            [ "WellblechsHausen$LinkType$RandomID" => 1 ],
        ]
    );

    # create test ticket

    my $TicketID = $TicketObject->TicketCreate(
        Title        => "TestTicket1_$LinkType$RandomID",
        Queue        => 'Raw',
        Lock         => 'unlock',
        Priority     => '3 normal',
        State        => 'closed successful',
        CustomerNo   => '123465',
        CustomerUser => 'unittest@otobo.org',
        OwnerID      => $UserID,
        UserID       => $UserID,
    );

    ok( $TicketID, 'Ticket created' );

    # create link to Ticket
    ok(
        $LinkObject->LinkAdd(
            SourceObject => 'ITSMConfigItem',
            SourceKey    => $TestLocation1ID,
            TargetObject => 'Ticket',
            TargetKey    => $TicketID,
            Type         => $LinkType,          #'RelevantTo',
            State        => 'Valid',
            UserID       => $UserID,
        ),
        'CI TestLocation1 Linked to Ticket'
    );

    # inspect link data

    my $LinkList = $LinkObject->LinkListWithData(
        Object => 'ITSMConfigItem',
        Key    => $TestLocation1ID,
        UserID => $UserID,
        State  => 'Valid',
    );

    my $Source = $LinkList->{Ticket}->{$LinkType}->{Source}
        ?
        $LinkList->{Ticket}->{$LinkType}->{Source}->{$TicketID}
        :
        $LinkList->{Ticket}->{$LinkType}->{Target}->{$TicketID};

    ok( $Source, 'Found Link' );

    ok(
        $Source->{TicketNumber},
        'Linked item looks like ticket'
    );

    is(
        $Source->{Title},
        "TestTicket1_$LinkType$RandomID",
        'ConfigItem is linked to correct Ticket'
    );

    ###############################
    # cleanup
    ###############################

    $ConfigItemObject->EventHandlerTransaction();

    ok(
        $ConfigItemObject->ConfigItemDelete(
            ConfigItemID => $TestLocation1ID,
            UserID       => $UserID
        ),
        "TestLocation1 deleted"
    );

    # assert we didn't leak config items and config item links
    my $FinalConfigItemsCount     = _FetchConfigItemCount();
    my $FinalConfigItemLinksCount = _FetchConfigItemLinksCount();

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

    ok( $Content, "Classes have been loaded" );

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

    ok( $Result, "Classes have been imported" );

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

sub _AddVersionTriggerOnNameChangeToCountryClass {

    my %Param = @_;

    return $Kernel::OM->Get('Kernel::System::GeneralCatalog')->GeneralCatalogPreferencesSet(
        ItemID => $CountryClassID,
        Key    => 'VersionTrigger',
        Value  => ['Name'],
    );
}

# call like
# _AssertLocationVersion(
#   Location => $TestLocation1ID,
#    Versions => [
#     ["WellblechsHausen$RandomID"    => 1 ],
#     ["Niederkaltenkirchen$RandomID" => 2 ],
# ]);

sub _AssertLocationVersion {

    my %Param      = @_;
    my $LocationID = $Param{Location};
    my $Versions   = $Param{Versions};

    my $VersionListRef = $ConfigItemObject->VersionZoomList(
        ConfigItemID => $LocationID,
    );

    my $VersionCount = @$Versions;

    is(
        scalar @$VersionListRef,
        $VersionCount,
        "Count of Versions is $VersionCount for Location ID $LocationID"
    );

    for ( 0 .. $VersionCount - 1 ) {

        my @Version       = $Versions->[$_]->@*;
        my $Name          = $Version[0];
        my $VersionString = $Version[1];

        my $VersionID = _GetVersionIDFromVersionString(
            Versions      => $VersionListRef,
            VersionString => $VersionString
        );

        my $TestLocationCIVersioned = $ConfigItemObject->ConfigItemGet(
            ConfigItemID  => $LocationID,
            VersionID     => $VersionID,
            DynamicFields => 1,
        );

        is(
            $TestLocationCIVersioned->{Name},
            $Name,
            "$Name is correct"
        );
    }

    return;
}

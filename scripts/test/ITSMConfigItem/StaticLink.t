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
# test static versioned links
# between CI items
# example is
#  Subsidiary -> static
#                 (versioned)
#                 Location
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

my %CountryLookup;
my %SubsidiaryLookup;

# assure std classes have been imported
_LoadReadyToImportClasses();

# global OM objects
my $DBObject           = $Kernel::OM->Get('Kernel::System::DB');
my $ConfigItemObject   = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');
my $LinkObject         = $Kernel::OM->Get('Kernel::System::LinkObject');
my $DynamicFieldObject = $Kernel::OM->Get('Kernel::System::DynamicField');

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

# fetch country and subsidiary classes from general catalog
my $CountryClassID = _GeneralCatalogID(
    Class => 'ITSM::ConfigItem::Class',
    Name  => 'Country',
);
ok( $CountryClassID, "Country class found." );

my $SubsidiaryClassID = _GeneralCatalogID(
    Class => 'ITSM::ConfigItem::Class',
    Name  => 'Subsidiary',
);
ok( $SubsidiaryClassID, "Subsidiary class found." );

# add a version trigger to Country on Name attribute
ok(
    _AddVersionTriggerOnNameChangeToCountryClass(),
    "Updated VersionTrigger on Country Class to 'OnNameChange.' "
);

my %PossibleTypesList = $LinkObject->PossibleTypesList(
    Object1 => 'ITSMConfigItem',
    Object2 => 'ITSMConfigItem',
);

my @LinkTypes = keys %PossibleTypesList;

###############################
# iterate over avail LinkTypes
###############################

for my $LinkType (@LinkTypes) {

    subtest "Test Static DF References for LinkType='$LinkType'" => sub {

        # create DF similar to Location-ReferenceToCountry
        # but with LinkReferencingType => Static and
        # ReferencedObjectType => ITSMConfigItemVersion
        ok(
            _CreateDFStaticReferenceToCountry( LinkType => $LinkType ),
            "DF 'StaticReferenceToCountry' Created."
        );

        # change Subsidiary Class Def to use Location-StaticReferenceToCountry
        ok(
            _ChangeSubsidiaryDefinitionToUseStaticCountry( LinkType => $LinkType ),
            'Updated Subsidiary Class Definition to use StaticReferenceToCountry DF.'
        );

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
        $CountryLookup{$TestLocation1ID} = 'WellblechsHausen' . $LinkType . $RandomID;
        ok( $TestLocation1ID, "TestLocation1 '" . $CountryLookup{$TestLocation1ID} . "' ($TestLocation1ID) created." );

        subtest "Assert there is 1 version of TestLocation1 ID $TestLocation1ID" => sub {
            _AssertLocationVersion(
                LocationID => $TestLocation1ID,
                Versions   => [
                    [ "WellblechsHausen$LinkType$RandomID" => 1 ],
                ]
            );
        };

        # get current VersionID for TestLocation
        my $TestLocationFirstVersionID = _GetConfigItemCurrentVersion(
            ConfigItemID => $TestLocation1ID
        );

        # create a test subsidiary with a link to testlocation1 v1
        my $TestSubsidiaryID = $ConfigItemObject->ConfigItemAdd(
            ClassID                                                                    => $SubsidiaryClassID,
            Name                                                                       => 'DerBauernhof' . $LinkType . $RandomID,
            DeplStateID                                                                => $DeploymentStateProductionID,
            InciStateID                                                                => $IncidientStateOperationalID,
            Description                                                                => 'ABCD',
            UserID                                                                     => $UserID,
            "DynamicField_Location-StaticReferenceToCountry" . $LinkType . "$RandomID" => [
                $TestLocationFirstVersionID
            ],
        );
        $SubsidiaryLookup{$TestSubsidiaryID} = 'DerBauernhof' . $LinkType . $RandomID;
        ok(
            $TestSubsidiaryID,
            "TestSubsidiary" . $SubsidiaryLookup{$TestSubsidiaryID} . " ($TestSubsidiaryID) with static link to " . $CountryLookup{$TestLocation1ID} . " created."
        );

        $ConfigItemObject->EventHandlerTransaction();

        subtest "Assert Subsidiary has 1 version that points to '" . $CountryLookup{$TestLocation1ID} . "'" => sub {
            _AssertSubsidiaryVersionsAndLocation(
                LinkType     => $LinkType,
                Direction    => 'Source',
                LocationID   => $TestSubsidiaryID,
                LocationName => "WellblechsHausen$LinkType$RandomID",
            );
        };

        ###############################
        # change TestLocation Name
        ###############################

        my $CountryDefinition = $ConfigItemObject->DefinitionGet(
            ClassID => $CountryClassID,
        );

        ok(
            $ConfigItemObject->ConfigItemUpdate(
                ConfigItemID => $TestLocation1ID,
                DefinitionID => $CountryDefinition->{DefinitionID},
                Name         => "Niederkaltenkirchen$LinkType$RandomID",
                UserID       => $UserID,
            ),
            "TestLocation1 Name updated successfully to Niederkaltenkirchen$LinkType$RandomID."
        );
        $CountryLookup{$TestLocation1ID} = "Niederkaltenkirchen$LinkType$RandomID";
        $ConfigItemObject->EventHandlerTransaction();

        # assert there are now two versions

        subtest "Assert there are two versions of TestLocation1 $TestLocation1ID after name change" => sub {
            _AssertLocationVersion(
                LocationID => $TestLocation1ID,
                Versions   => [
                    [ "WellblechsHausen$LinkType$RandomID"    => 1 ],
                    [ "Niederkaltenkirchen$LinkType$RandomID" => 2 ],
                ]
            );
        };
        ###############################
        # now look at the Subsidiary
        # again and assert it *still*
        # has 1 version and *still*
        # points to static Location v1
        ###############################

        subtest "Assert Subsidiary *still* has 1 version and *still* points to '" . $CountryLookup{$TestLocation1ID} . "'" => sub {
            _AssertSubsidiaryVersionsAndLocation(
                LinkType     => $LinkType,
                Direction    => 'Source',
                LocationID   => $TestSubsidiaryID,
                LocationName => "WellblechsHausen$LinkType$RandomID",
            );
        };

        # create TestLocation2
        my $TestLocation2ID = $ConfigItemObject->ConfigItemAdd(
            ClassID     => $CountryClassID,
            Name        => 'Tuntenhausen' . $LinkType . $RandomID,
            DeplStateID => $DeploymentStateProductionID,
            InciStateID => $IncidientStateOperationalID,
            Description => 'ABCD',
            UserID      => $UserID,
        );
        $CountryLookup{$TestLocation2ID} = 'Tuntenhausen' . $LinkType . $RandomID;
        ok( $TestLocation2ID, "TestLocation2 '" . $CountryLookup{$TestLocation2ID} . "'created." );
        $ConfigItemObject->EventHandlerTransaction();

        subtest "Assert there is one version of TestLocation2 $TestLocation2ID after creation" => sub {

            _AssertLocationVersion(
                LocationID => $TestLocation2ID,
                Versions   => [
                    [ "Tuntenhausen$LinkType$RandomID" => 1 ],
                ]
            );
        };

        # change Link Direction in StaticRefrenceToCOuntry DF
        _UpdateStaticReferenceToCountryDFLinkDirection( LinkType => $LinkType );

        # get current VersionID for TestLocation
        my $TestLocation2FirstVersionID = _GetConfigItemCurrentVersion(
            ConfigItemID => $TestLocation2ID
        );

        # now update the subsidiary link to point to testlocation2 instead
        $ConfigItemObject->ConfigItemUpdate(
            ConfigItemID                                                       => $TestSubsidiaryID,
            "DynamicField_Location-StaticReferenceToCountry$LinkType$RandomID" => [
                $TestLocation2FirstVersionID
            ],
            UserID => $UserID,
        );
        $ConfigItemObject->EventHandlerTransaction();

        subtest "Assert Subsidiary has 1 version and now points to '" . $CountryLookup{$TestLocation2ID} . "'" => sub {

            _AssertSubsidiaryVersionsAndLocation(
                LinkType     => $LinkType,
                Direction    => 'Target',
                LocationID   => $TestSubsidiaryID,
                LocationName => "Tuntenhausen$LinkType$RandomID",
            );
        };

        ###############################
        # cleanup
        ###############################

        $ConfigItemObject->EventHandlerTransaction();

        subtest "Cleanup and delete all Test ConfigItems" => sub {
            ok(
                $ConfigItemObject->ConfigItemDelete(
                    ConfigItemID => $TestSubsidiaryID,
                    UserID       => $UserID
                ),
                "TestSubsidiary deleted."
            );

            ok(
                $ConfigItemObject->ConfigItemDelete(
                    ConfigItemID => $TestLocation1ID,
                    UserID       => $UserID
                ),
                "TestLocation1 deleted."
            );

            ok(
                $ConfigItemObject->ConfigItemDelete(
                    ConfigItemID => $TestLocation2ID,
                    UserID       => $UserID
                ),
                "TestLocation2 deleted."
            );
        };

        subtest "assert we didn't leak config items and config item links" => sub {
            my $FinalConfigItemsCount     = _FetchConfigItemCount();
            my $FinalConfigItemLinksCount = _FetchConfigItemLinksCount();
            my $FinalLinkRelationsCount   = _FetchLinkRelationsCount();

            is(
                $InitialConfigItemsCount,
                $FinalConfigItemsCount,
                "No CI have been leaked."
            );

            is(
                $InitialConfigItemLinksCount,
                $FinalConfigItemLinksCount,
                "No CI links have been leaked."
            );

            is(
                $InitialLinkRelationsCount,
                $FinalLinkRelationsCount,
                "No LinkObjects have been leaked."
            );
        };
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

sub _CreateDFStaticReferenceToCountry {

    my %Param = @_;

    my $ConfigHashRef = {
        ClassIDs              => ["$CountryClassID"],
        DisplayType           => 'ConfigItemName',
        EditFieldMode         => 'Dropdown',
        ImportSearchAttribute => '',
        LinkDirection         => 'ReferencingIsSource',
        LinkReferencingType   => 'Static',
        LinkType              => $Param{LinkType},
        MultiValue            => '0',
        Multiselect           => 0,
        PossibleNone          => '1',
        ReferenceFilterList   => [],
        ReferencedObjectType  => 'ITSMConfigItemVersion',
        SearchAttribute       => 'Name',
        Tooltip               => '',
    };

    my $DynamicFieldObject = $Kernel::OM->Get('Kernel::System::DynamicField');
    return $DynamicFieldObject->DynamicFieldAdd(
        Name       => 'Location-StaticReferenceToCountry' . $Param{LinkType} . $RandomID,
        Label      => 'Location-StaticReferenceToCountry' . $Param{LinkType} . $RandomID,
        FieldOrder => 4711,                                                                 # mandatory, display order
        Namespace  => 'Location',
        FieldType  => 'ConfigItemVersion',
        ObjectType => 'ITSMConfigItem',
        Config     => $ConfigHashRef,
        Reorder    => 1,                                                                    # or 0, to trigger reorder function, default 1
        ValidID    => 1,
        UserID     => $UserID,
    );
}

sub _ChangeSubsidiaryDefinitionToUseStaticCountry {

    my %Param = @_;

    my $Definition = $ConfigItemObject->DefinitionGet(
        ClassID => $SubsidiaryClassID,
    );

    my $DefinitionRef = $Definition->{DefinitionRef};

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

        # here it is, the change:
        {
            'DF' => 'Location-StaticReferenceToCountry' . $Param{LinkType} . $RandomID
        },
        {
            'DF' => 'Location-Latitude'
        },
        {
            'DF' => 'Location-Longitude'
        }
    ];

    my $YAMLObject = $Kernel::OM->Get('Kernel::System::YAML');
    my $YAMLString = $YAMLObject->Dump(
        Data => $DefinitionRef,
    );

    return $ConfigItemObject->DefinitionAdd(
        ClassID    => $SubsidiaryClassID,
        Definition => $YAMLString,
        UserID     => $UserID,
    )->{Success};
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
#    LocationID => $TestLocation1ID,
#    Versions => [
#       ["WellblechsHausen$RandomID"    => 1 ],
#       ["Niederkaltenkirchen$RandomID" => 2 ],
#   ]
# );

sub _AssertLocationVersion {

    my %Param      = @_;
    my $Versions   = $Param{Versions};
    my $LocationID = $Param{LocationID};

    my $VersionListRef = $ConfigItemObject->VersionZoomList(
        ConfigItemID => $LocationID,
    );

    my $VersionCount = @$Versions;

    is(
        scalar @$VersionListRef,
        $VersionCount,
        "Count of Versions is $VersionCount for CI $LocationID."
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
            "$Name for version $_ is correct"
        );
    }

    return;
}

# asserts that version count of TestLocation
# is one and points to first version of Country

sub _AssertSubsidiaryVersionsAndLocation {

    my %Param        = @_;
    my $LocationID   = $Param{LocationID};
    my $LocationName = $Param{LocationName};
    my $LinkType     = $Param{LinkType};
    my $Direction    = $Param{Direction} || 'Target';

    my $SubsidiaryVersionListRef = $ConfigItemObject->VersionZoomList(
        ConfigItemID => $LocationID,
    );

    my $SubsidiaryVersionID = _GetVersionIDFromVersionString(
        Versions      => $SubsidiaryVersionListRef,
        VersionString => '1'
    );

    is(
        scalar @$SubsidiaryVersionListRef,
        1,
        "There is one Version of TestSubsidiary $LocationID Version $SubsidiaryVersionID."
    );

    my $TestSubsidiaryCIVersionend = $ConfigItemObject->ConfigItemGet(
        ConfigItemID  => $LocationID,
        VersionID     => $SubsidiaryVersionID,
        DynamicFields => 1,
    );

    my $LocationRefID = $TestSubsidiaryCIVersionend->{ "DynamicField_Location-StaticReferenceToCountry" . $Param{LinkType} . "$RandomID" }->[0];

    # note lookup by *VersionID*
    my $StaticLocationCI = $ConfigItemObject->ConfigItemGet(
        VersionID     => $LocationRefID,
        DynamicFields => 1,
    );
    is(
        $StaticLocationCI->{Name},
        $LocationName,
        "name '$LocationName' is correct for CI VersionID: $LocationRefID."
    );

    my $LinkedConfigItems = $ConfigItemObject->LinkedConfigItems(

        #ConfigItemID => $LocationID,
        VersionID => $SubsidiaryVersionID,

        # Types        => [ $LinkType ], # optional
        Direction => 'Both',    # one of Source, Target, Both
        UserID    => $UserID,
    );

    is( scalar $LinkedConfigItems->@*,        1,              'There is one CI link' );
    is( $LinkedConfigItems->[0]->{Direction}, $Direction,     "CI Link Direction is '$Direction'." );
    is( $LinkedConfigItems->[0]->{VersionID}, $LocationRefID, "CI Link points to *VersionID* $LocationRefID." );

    return;
}

sub _GetConfigItemCurrentVersion {

    my %Param = @_;

    my $CI = $ConfigItemObject->ConfigItemGet(
        ConfigItemID  => $Param{ConfigItemID},
        DynamicFields => 0,
    );
    return $CI->{VersionID};
}

sub _UpdateStaticReferenceToCountryDFLinkDirection {

    my %Param = @_;

    my $LinkType = $Param{LinkType};

    my $DynamicField = $DynamicFieldObject->DynamicFieldGet( Name => 'Location-StaticReferenceToCountry' . $LinkType . $RandomID );

    ok( $DynamicField, 'Got RefrenceToCountry DF' );

    my $ConfigHashRef = $DynamicField->{Config};

    $ConfigHashRef->{LinkDirection} = 'ReferencingIsTarget';

    my $Success = $DynamicFieldObject->DynamicFieldUpdate(
        ID         => $DynamicField->{ID},      # mandatory
        Name       => $DynamicField->{Name},    #'NameForField',  # mandatory
        Label      => 'a description',          # mandatory, label to show
        FieldOrder => 4711,                     # mandatory, display order
        FieldType  => 'ConfigItemVersion',      # mandatory, selects the DF backend to use for this field
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

    ok( $Success, "DF definition updated, link direction changed to 'ReferencingIsTarget' ." );

    $ConfigItemObject->EventHandlerTransaction();

    _SyncConfigItemDFs( LinkType => $LinkType );

    return;
}

sub _SyncConfigItemDFs {

    my %Param = @_;

    my $LinkType = $Param{LinkType};

    my $DynamicFieldConfig = $DynamicFieldObject->DynamicFieldGet( Name => 'Location-StaticReferenceToCountry' . $LinkType . $RandomID );

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

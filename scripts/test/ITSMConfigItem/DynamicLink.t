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
# test simple dynamic links
# between CI items
# example is
#  Subsidiary -> Location
################################

# test boilerplate

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
my $DynamicFieldObject = $Kernel::OM->Get('Kernel::System::DynamicField');
my $LinkObject         = $Kernel::OM->Get('Kernel::System::LinkObject');

# catch DB state before test run
my $InitialConfigItemsCount     = _FetchConfigItemCount();
my $InitialConfigItemLinksCount = _FetchConfigItemLinksCount();

################################
# prepare environment
################################

# fetch config ids
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

# possible link types for ConfigItem <-> ConfigItem
my %PossibleTypesList = $LinkObject->PossibleTypesList(
    Object1 => 'ITSMConfigItem',
    Object2 => 'ITSMConfigItem',
);

my %CountryLookup;
my %SubsidiaryLookup;

my @LinkTypes = keys %PossibleTypesList;

for my $LinkType (@LinkTypes) {

    subtest "Dynamic Links with LinkType='$LinkType'" => sub {

        _SetVersionTriggerOnSubsidiaryClass(
            Value => []
        );

        _UpdateReferenceToCountryDFLinkDirection( LinkDirection => 'ReferencingIsTarget' );

        ################################
        # create Test Config Items
        ################################

        # create first testlocation
        my $TestLocation1ID = $ConfigItemObject->ConfigItemAdd(
            ClassID     => $CountryClassID,
            Name        => 'WellblechsHausen' . $LinkType . $RandomID,
            DeplStateID => $DeploymentStateProductionID,
            InciStateID => $IncidientStateOperationalID,
            Description => 'ABCD',
            UserID      => $UserID,
        );
        ok( $TestLocation1ID, "TestLocation1 $TestLocation1ID created." );
        $CountryLookup{$TestLocation1ID} = 'WellblechsHausen' . $LinkType . $RandomID;

        # create second testlocation
        my $TestLocation2ID = $ConfigItemObject->ConfigItemAdd(
            ClassID     => $CountryClassID,
            Name        => 'Niederkaltenkirchen' . $LinkType . $RandomID,
            DeplStateID => $DeploymentStateProductionID,
            InciStateID => $IncidientStateOperationalID,
            Description => 'ABCD',
            UserID      => $UserID,
        );
        ok( $TestLocation2ID, "TestLocation2 $TestLocation2ID created." );
        $CountryLookup{$TestLocation2ID} = 'Niederkaltenkirchen' . $LinkType . $RandomID;

        ################################
        # a) make updates with no
        # version triggers
        ################################

        # create a test subsidiary with a link to testlocation1
        my $TestSubsidiaryID = $ConfigItemObject->ConfigItemAdd(
            ClassID                                    => $SubsidiaryClassID,
            Name                                       => 'DerBauernhof' . $LinkType . $RandomID,
            DeplStateID                                => $DeploymentStateProductionID,
            InciStateID                                => $IncidientStateOperationalID,
            Description                                => 'ABCD',
            UserID                                     => $UserID,
            "DynamicField_Location-ReferenceToCountry" => [
                $TestLocation1ID
            ],
        );

        ok(
            $TestSubsidiaryID,
            "TestSubsidiary $TestSubsidiaryID with link to TestLocation1 created."
        );

        $SubsidiaryLookup{$TestSubsidiaryID} = 'DerBauernhof' . $LinkType . $RandomID;
        $ConfigItemObject->EventHandlerTransaction();

        subtest "a) Assert on CIs with LinkType '$LinkType' (no version triggers)" => sub {
            _AssertConfigItemLinks(
                ConfigItemID => $TestSubsidiaryID,
                Direction    => 'Target',
                TargetID     => $TestLocation1ID,
            );

            _AssertLocationID(
                ConfigItemID => $TestSubsidiaryID,
                LocationID   => $TestLocation1ID,
            );

            _AssertLocationVersion(
                LocationID => $TestSubsidiaryID,
                Versions   => [
                    [ "WellblechsHausen$LinkType$RandomID" => 1 ],
                ],
            );

            _AssertNoLeaks(
                ConfigItemsCount     => $InitialConfigItemsCount + 3,
                ConfigItemLinksCount => $InitialConfigItemLinksCount + 1,
            );
        };

        ################################
        # now update the subsidiary link
        # to point to testlocation2
        # instead
        ################################

        $ConfigItemObject->ConfigItemUpdate(
            ConfigItemID                               => $TestSubsidiaryID,
            "DynamicField_Location-ReferenceToCountry" => [
                $TestLocation2ID
            ],
            UserID => $UserID,
        );
        $ConfigItemObject->EventHandlerTransaction();

        subtest "a) Assert on CIs with LinkType '$LinkType' (no version triggers) after CI ReferenceToCountry change" => sub {

            _AssertConfigItemLinks(
                ConfigItemID => $TestSubsidiaryID,
                Direction    => 'Target',
                TargetID     => $TestLocation2ID,
            );

            _AssertLocationID(
                ConfigItemID => $TestSubsidiaryID,
                LocationID   => $TestLocation2ID,
            );

            _AssertLocationVersion(
                LocationID => $TestSubsidiaryID,
                Versions   => [
                    [ "Niederkaltenkirchen$LinkType$RandomID" => 1 ],
                ],
            );

            _AssertNoLeaks(
                ConfigItemsCount     => $InitialConfigItemsCount + 3,
                ConfigItemLinksCount => $InitialConfigItemLinksCount + 1,
            );
        };
        ################################
        # change LinkDirection
        # on ReferenceToCountry DF
        ################################

        _UpdateReferenceToCountryDFLinkDirection( LinkDirection => 'ReferencingIsSource' );

        subtest "a) Assert on CIs with LinkType '$LinkType' (no version triggers) after LinkDirection changed to 'ReferencingIsSource'" => sub {

            # this must have updated the Direction of the Link!
            _AssertConfigItemLinks(
                ConfigItemID => $TestSubsidiaryID,
                Direction    => 'Source',
                TargetID     => $TestLocation2ID,
            );

            _AssertLocationID(
                ConfigItemID => $TestSubsidiaryID,
                LocationID   => $TestLocation2ID,
            );

            _AssertLocationVersion(
                LocationID => $TestSubsidiaryID,
                Versions   => [
                    [ "Niederkaltenkirchen$LinkType$RandomID" => 1 ],
                ],
            );

            _AssertNoLeaks(
                ConfigItemsCount     => $InitialConfigItemsCount + 3,
                ConfigItemLinksCount => $InitialConfigItemLinksCount + 1,
            );
        };

        ################################
        # b) now set a version trigger
        # on subsidiary for changes of
        # the Country Reference and
        # update again
        ################################

        ok(
            _SetVersionTriggerOnSubsidiaryClass(
                Value => ["DynamicField_Location-ReferenceToCountry"]
            ),
            "Set Subsidiary Version Trigger on 'ReferenceToCountry' DF."
        );
        $ConfigItemObject->EventHandlerTransaction();

        # switch back to reference is target
        _UpdateReferenceToCountryDFLinkDirection( LinkDirection => 'ReferencingIsTarget' );

        # update the subsidiary link to point to testlocation1 again
        $ConfigItemObject->ConfigItemUpdate(
            ConfigItemID                               => $TestSubsidiaryID,
            "DynamicField_Location-ReferenceToCountry" => [
                $TestLocation1ID
            ],
            UserID => $UserID,
        );
        $ConfigItemObject->EventHandlerTransaction();

        subtest "b) Assert on CIs with LinkType '$LinkType' (with version triggers) after LinkDirection changed back to 'ReferencingIsTarget'" => sub {

            _AssertConfigItemLinks(
                ConfigItemID => $TestSubsidiaryID,
                Direction    => 'Target',
                TargetID     => $TestLocation1ID,
            );

            _AssertLocationID(
                ConfigItemID => $TestSubsidiaryID,
                LocationID   => $TestLocation1ID,
            );

            # assert there are now two version snapshots
            _AssertLocationVersion(
                LocationID => $TestSubsidiaryID,
                Versions   => [
                    [ "Niederkaltenkirchen$LinkType$RandomID" => 1 ],
                    [ "WellblechsHausen$LinkType$RandomID"    => 2 ],
                ],
            );

            _AssertNoLeaks(
                ConfigItemsCount     => $InitialConfigItemsCount + 3,
                ConfigItemLinksCount => $InitialConfigItemLinksCount + 1,
            );
        };

        ################################
        # DF update change link dir on
        # ReferenceToCountryDF
        ################################

        _UpdateReferenceToCountryDFLinkDirection( LinkDirection => 'ReferencingIsSource' );

        subtest "b) Assert on CIs with LinkType '$LinkType' (with version triggers) after LinkDirection changed to 'ReferencingIsSource'" => sub {

            _AssertConfigItemLinks(
                ConfigItemID => $TestSubsidiaryID,
                Direction    => 'Source',
                TargetID     => $TestLocation1ID,
            );

            _AssertLocationID(
                ConfigItemID => $TestSubsidiaryID,
                LocationID   => $TestLocation1ID,
            );

            # assert there are now two version snapshots
            _AssertLocationVersion(
                LocationID => $TestSubsidiaryID,
                Versions   => [
                    [ "Niederkaltenkirchen$LinkType$RandomID" => 1 ],
                    [ "WellblechsHausen$LinkType$RandomID"    => 2 ],
                ],
            );

            _AssertNoLeaks(
                ConfigItemsCount     => $InitialConfigItemsCount + 3,
                ConfigItemLinksCount => $InitialConfigItemLinksCount + 1,
            );
        };

        ################################
        # update the subsidiary link to
        # point to testlocation1 again
        ################################

        $ConfigItemObject->ConfigItemUpdate(
            ConfigItemID                               => $TestSubsidiaryID,
            "DynamicField_Location-ReferenceToCountry" => [
                $TestLocation2ID
            ],
            UserID => $UserID,
        );
        $ConfigItemObject->EventHandlerTransaction();

        subtest "b) Assert on CIs with LinkType '$LinkType' (with version triggers) after ReferenceToCountry change" => sub {

            _AssertConfigItemLinks(
                ConfigItemID => $TestSubsidiaryID,
                Direction    => 'Source',
                TargetID     => $TestLocation2ID,
            );

            _AssertLocationID(
                ConfigItemID => $TestSubsidiaryID,
                LocationID   => $TestLocation2ID,
            );

            # assert there are now three version snapshots
            _AssertLocationVersion(
                LocationID => $TestSubsidiaryID,
                Versions   => [
                    [ "Niederkaltenkirchen$LinkType$RandomID" => 1 ],
                    [ "WellblechsHausen$LinkType$RandomID"    => 2 ],
                    [ "Niederkaltenkirchen$LinkType$RandomID" => 3 ],
                ],
            );

            _AssertNoLeaks(
                ConfigItemsCount     => $InitialConfigItemsCount + 3,
                ConfigItemLinksCount => $InitialConfigItemLinksCount + 1,
            );
        };

        ################################
        # c) now set a version trigger
        # on subsidiary for changes of
        # the Definition
        ################################

        ok(
            _SetVersionTriggerOnSubsidiaryClass(
                Value => ["DefinitionUpdate"]
            ),
            "Set Subsidiary Version Trigger to 'DefinitionUpdate'."
        );
        $ConfigItemObject->EventHandlerTransaction();

        # switch back to reference is target
        # this now triggers a new version
        _UpdateReferenceToCountryDFLinkDirection( LinkDirection => 'ReferencingIsTarget' );

        subtest "c) Assert on CIs with LinkType '$LinkType' (with version triggers on Country and DefinitionUpdate trigger on Subsidiary)" => sub {

            _AssertConfigItemLinks(
                ConfigItemID => $TestSubsidiaryID,
                Direction    => 'Target',
                TargetID     => $TestLocation2ID,
            );

            _AssertLocationID(
                ConfigItemID => $TestSubsidiaryID,
                LocationID   => $TestLocation2ID,
            );

            # assert there are now four version snapshots
            _AssertLocationVersion(
                LocationID => $TestSubsidiaryID,
                Versions   => [
                    [ "Niederkaltenkirchen$LinkType$RandomID" => 1 ],
                    [ "WellblechsHausen$LinkType$RandomID"    => 2 ],
                    [ "Niederkaltenkirchen$LinkType$RandomID" => 3 ],
                    [ "Niederkaltenkirchen$LinkType$RandomID" => 4 ],
                ],
            );

            _AssertNoLeaks(
                ConfigItemsCount     => $InitialConfigItemsCount + 3,
                ConfigItemLinksCount => $InitialConfigItemLinksCount + 1,
            );
        };

        ################################
        # DF update change link dir on
        # ReferenceToCountryDF
        ################################

        # also triggers new version
        _UpdateReferenceToCountryDFLinkDirection( LinkDirection => 'ReferencingIsSource' );

        subtest
            "c) Assert on CIs with LinkType '$LinkType' (with version triggers on Country and Subsidiary) after LinkDirection changed to 'ReferencingIsSource'" => sub {

                _AssertConfigItemLinks(
                    ConfigItemID => $TestSubsidiaryID,
                    Direction    => 'Source',
                    TargetID     => $TestLocation2ID,
                );

                _AssertLocationID(
                    ConfigItemID => $TestSubsidiaryID,
                    LocationID   => $TestLocation2ID,
                );

                # assert there are now two version snapshots
                _AssertLocationVersion(
                    LocationID => $TestSubsidiaryID,
                    Versions   => [
                        [ "Niederkaltenkirchen$LinkType$RandomID" => 1 ],
                        [ "WellblechsHausen$LinkType$RandomID"    => 2 ],
                        [ "Niederkaltenkirchen$LinkType$RandomID" => 3 ],
                        [ "Niederkaltenkirchen$LinkType$RandomID" => 4 ],
                        [ "Niederkaltenkirchen$LinkType$RandomID" => 5 ],
                    ],
                );

                _AssertNoLeaks(
                    ConfigItemsCount     => $InitialConfigItemsCount + 3,
                    ConfigItemLinksCount => $InitialConfigItemLinksCount + 1,
                );
            };

        ################################
        # cleanup
        ################################

        subtest "Cleanup LinkType='$LinkType': delete all test CI objects" => sub {
            ok(
                $ConfigItemObject->ConfigItemDelete(
                    ConfigItemID => $TestSubsidiaryID,
                    UserID       => $UserID
                ),
                "TestSubsidiary deleted"
            );

            ok(
                $ConfigItemObject->ConfigItemDelete(
                    ConfigItemID => $TestLocation1ID,
                    UserID       => $UserID
                ),
                "TestLocation1 deleted"
            );

            ok(
                $ConfigItemObject->ConfigItemDelete(
                    ConfigItemID => $TestLocation2ID,
                    UserID       => $UserID
                ),
                "TestLocation2 deleted"
            );
        };

        subtest "Assert no CI items and links have been leaked" => sub {
            my $LinkedConfigItems = $ConfigItemObject->LinkedConfigItems(
                ConfigItemID => $TestSubsidiaryID,

                # Types        => [ $LinkType ], # optional
                Direction => 'Both',    # one of Source, Target, Both
                UserID    => $UserID,
            );

            is( scalar $LinkedConfigItems->@*, 0, 'There are no CI links left' );

            # assert we didn't leak config items and config item links again, after cleanup
            _AssertNoLeaks(
                ConfigItemsCount     => $InitialConfigItemsCount,
                ConfigItemLinksCount => $InitialConfigItemLinksCount,
            );
        };
    };
}
done_testing;

################################
# procedural helper methods
################################

# Prepare the General Catalog classes by reloading (and updating) the whole ready2load bundl

sub _LoadReadyToImportClasses {

    my $Home = $Kernel::OM->Get('Kernel::Config')->Get('Home');

    my $MainObject = $Kernel::OM->Get('Kernel::System::Main');

    my $Content = $MainObject->FileRead(

        #       Location => "$Home/var/itsm/configitemclasses/IT-Servicemanagement-11_0_2.yml",
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

    my %Param = @_;

    my $Success = $DBObject->Prepare(
        SQL => 'SELECT Count(id) FROM configitem',
    );

    if ( my @Row = $DBObject->FetchrowArray ) {
        return $Row[0];
    }

    return 0;
}

sub _FetchConfigItemLinksCount {

    my %Param = @_;

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

sub _SetVersionTriggerOnSubsidiaryClass {

    my %Param = @_;
    my $Value = $Param{Value};

    my $Result = $Kernel::OM->Get('Kernel::System::GeneralCatalog')->GeneralCatalogPreferencesSet(
        ItemID => $SubsidiaryClassID,
        Key    => 'VersionTrigger',
        Value  => $Value,
    );

    $ConfigItemObject->EventHandlerTransaction();

    return $Result;
}

# call like
# _AssertLocationVersion(
#    LocationID => $TestLocaiton1ID,
#    Versions => [
#       ["WellblechsHausen$RandomID"    => 1 ],
#       ["Niederkaltenkirchen$RandomID" => 2 ],
#     ]
#);

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
        "Count of Versions is $VersionCount for " . $SubsidiaryLookup{$LocationID} . " ($LocationID)"
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

        my $ReferencedConfigItemID = $TestLocationCIVersioned->{"DynamicField_Location-ReferenceToCountry"}->[0];

        my $ReferencedConfigItem = $ConfigItemObject->ConfigItemGet(
            ConfigItemID  => $ReferencedConfigItemID,
            DynamicFields => 1,
        );

        is(
            $ReferencedConfigItem->{Name},
            $Name,
            "Version " . ( $_ + 1 ) . " ReferenceToCountry DF Points to '$Name'."
        );
    }

    return;
}

sub _UpdateReferenceToCountryDFLinkDirection {

    my %Param = @_;

    my $LinkDirection = $Param{LinkDirection} || 'ReferencingIsSource';

    my $DynamicField = $DynamicFieldObject->DynamicFieldGet( Name => 'Location-ReferenceToCountry' );

    ok( $DynamicField, 'ReferenceToCountry DF found.' );

    my $ConfigHashRef = $DynamicField->{Config};

    $ConfigHashRef->{LinkDirection} = $LinkDirection;

    my $Success = $DynamicFieldObject->DynamicFieldUpdate(
        ID         => $DynamicField->{ID},      # mandatory
        Name       => $DynamicField->{Name},    #'NameForField',  # mandatory
        Label      => 'a description',          # mandatory, label to show
        FieldOrder => 4711,                     # mandatory, display order
        FieldType  => 'ConfigItem',             # mandatory, selects the DF backend to use for this field
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

    ok( $Success, "ReferenceToCountry DF definition updated, link direction changed to $LinkDirection." );

    _SyncConfigItemDFs();

    return;
}

sub _SyncConfigItemDFs {

    my %Param = @_;

    my $DynamicFieldConfig = $DynamicFieldObject->DynamicFieldGet( Name => 'Location-ReferenceToCountry' );

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

sub _AssertConfigItemLinks {

    my %Param = @_;

    my $Direction    = $Param{Direction};
    my $TargetID     = $Param{TargetID};
    my $ConfigItemID = $Param{ConfigItemID};

    my $LinkedConfigItems = $ConfigItemObject->LinkedConfigItems(
        ConfigItemID => $ConfigItemID,

        # Types        => [ $LinkType ], # optional
        Direction => 'Both',    # one of Source, Target, Both
        UserID    => $UserID,
    );

    is( scalar $LinkedConfigItems->@*,           1,          'There is one CI link for ' . $SubsidiaryLookup{$ConfigItemID} );
    is( $LinkedConfigItems->[0]->{Direction},    $Direction, "CI Link Direction is '$Direction'." );
    is( $LinkedConfigItems->[0]->{ConfigItemID}, $TargetID,  "CI Link points to" . $CountryLookup{$TargetID} . " ($TargetID)." );

    return;
}

sub _AssertNoLeaks {

    my %Param = @_;

    my $ExpectedConfigItemsCount     = $Param{ConfigItemsCount};
    my $ExpectedConfigItemLinksCount = $Param{ConfigItemLinksCount};

    my $CurrentConfigItemsCount     = _FetchConfigItemCount();
    my $CurrentConfigItemLinksCount = _FetchConfigItemLinksCount();

    is(
        $CurrentConfigItemsCount,
        $ExpectedConfigItemsCount,
        "No CI have been leaked"
    );

    is(
        $CurrentConfigItemLinksCount,
        $ExpectedConfigItemLinksCount,
        "No CI links have been leaked"
    );

    return;
}

sub _AssertLocationID {

    my %Param = @_;

    my $LocationID   = $Param{LocationID};
    my $ConfigItemID = $Param{ConfigItemID};

    my $Updated = $ConfigItemObject->ConfigItemGet(
        ConfigItemID  => $ConfigItemID,
        DynamicFields => 1,
    );

    my $TestLocationId = $Updated->{"DynamicField_Location-ReferenceToCountry"}->[0];
    is(
        $TestLocationId,
        $LocationID,
        "CI ReferenceToCounty DF got updated to " . $CountryLookup{$LocationID} . " ($LocationID)"
    );

    return;
}

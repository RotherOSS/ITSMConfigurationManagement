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

package Kernel::System::Console::Command::Admin::ITSM::IncidentState::Recalculate;

use v5.24;
use strict;
use warnings;
use namespace::autoclean;

use parent qw(Kernel::System::Console::BaseCommand);

our @ObjectDependencies = (
    'Kernel::System::GeneralCatalog',
    'Kernel::System::ITSMConfigItem',
    'Kernel::System::Service',
);

sub Configure {
    my ( $Self, %Param ) = @_;

    $Self->Description('Recalculates the incident state of config items.');

    $Self->AddOption(
        Name        => 'configitem-number',
        Description => "Recalculate listed config items.",
        Required    => 0,
        HasValue    => 1,
        ValueRegex  => qr/\d+/smx,
        Multiple    => 1,
    );

    return;
}

sub Run {
    my ( $Self, %Param ) = @_;

    $Self->Print("<yellow>Recalculating the incident state of config items...</yellow>\n\n");

    my @ConfigItemIDs;    # either explicit list or all valid classes
    my $ConfigItemObject = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');

    my @ConfigItemNumbers = @{ $Self->GetOption('configitem-number') // [] };
    if (@ConfigItemNumbers) {

        CONFIG_ITEM_NUMBER:
        for my $ConfigItemNumber (@ConfigItemNumbers) {

            # checks the validity of the config item id
            my $ID = $ConfigItemObject->ConfigItemLookup(
                ConfigItemNumber => $ConfigItemNumber,
            );

            if ($ID) {
                push @ConfigItemIDs, $ID;

                next CONFIG_ITEM_NUMBER;
            }

            $Self->Print("<yellow>Unable to find config item $ConfigItemNumber.</yellow>\n");
        }
    }
    else {

        # get the valid class ids
        my $ClassList = $Kernel::OM->Get('Kernel::System::GeneralCatalog')->ItemList(
            Class => 'ITSM::ConfigItem::Class',
        );
        my @ValidClassIDs = sort keys $ClassList->%*;

        # get all config items ids form all valid classes
        my %ConfigItemsIDsRef = $ConfigItemObject->ConfigItemSearch(
            ClassIDs => \@ValidClassIDs,
            Result   => 'HASH'
        );

        @ConfigItemIDs = keys %ConfigItemsIDsRef;
    }

    # get number of config items
    my $CICount = scalar @ConfigItemIDs;

    $Self->Print("<yellow>Recalculating incident state for $CICount config items.</yellow>\n");

    # Remember config item results through multiple runs of CurInciStateRecalc().
    my %NewConfigItemIncidentState;
    my %ScannedConfigItemIDs;

    my $Count = 0;
    CONFIGITEM:
    for my $ConfigItemID (@ConfigItemIDs) {

        my $Success = $ConfigItemObject->CurInciStateRecalc(
            ConfigItemID               => $ConfigItemID,
            NewConfigItemIncidentState => \%NewConfigItemIncidentState,
            ScannedConfigItemIDs       => \%ScannedConfigItemIDs,
        );

        if ( !$Success ) {
            $Self->Print("<red>... could not recalculate incident state for config item id '$ConfigItemID'!</red>\n");

            next CONFIGITEM;
        }

        $Count++;

        if ( $Count % 100 == 0 ) {
            $Self->Print("<green>... $Count config items recalculated.</green>\n");
        }
    }

    $Self->Print("\n<green>Ready. Recalculated $Count config items.</green>\n\n");

    # get service object
    my $ServiceObject = $Kernel::OM->Get('Kernel::System::Service');

    # get list of all services (valid and invalid)
    my %ServiceList = $ServiceObject->ServiceList(
        Valid  => 0,
        UserID => 1,
    );

    my $NumberOfServices = scalar keys %ServiceList;

    $Self->Print(
        "<green>Resetting ServicePreferences 'CurInciStateTypeFromCIs' for $NumberOfServices services...</green>\n"
    );

    for my $ServiceID ( sort keys %ServiceList ) {

        # update the current incident state type from CIs of the service with an empty value
        # this is necessary to force a recalculation on a ServiceGet()
        $ServiceObject->ServicePreferencesSet(
            ServiceID => $ServiceID,
            Key       => 'CurInciStateTypeFromCIs',
            Value     => '',
            UserID    => 1,
        );
    }

    $Self->Print("<green>Ready.</green>\n");

    return $Self->ExitCodeOk();
}

1;

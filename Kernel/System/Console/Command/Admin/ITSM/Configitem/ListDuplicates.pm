# --
# OTOBO is a web-based ticketing system for service organisations.
# --
# Copyright (C) 2001-2020 OTRS AG, https://otrs.com/
# Copyright (C) 2019-2024 Rother OSS GmbH, https://otobo.io/
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

package Kernel::System::Console::Command::Admin::ITSM::Configitem::ListDuplicates;

use v5.24;
use strict;
use warnings;
use namespace::autoclean;
use utf8;

use parent qw(Kernel::System::Console::BaseCommand);

# core modules

# CPAN modules

# OTOBO modules
use Kernel::System::VariableCheck qw(IsArrayRefWithData);

our @ObjectDependencies = (
    'Kernel::Config',
    'Kernel::System::GeneralCatalog',
    'Kernel::System::ITSMConfigItem',
);

sub Configure {
    my ( $Self, %Param ) = @_;

    $Self->Description('List ConfigItems which have a non-unique name.');
    $Self->AddOption(
        Name        => 'class',
        Description => "Check only config items of this class.",
        Required    => 0,
        HasValue    => 1,
        ValueRegex  => qr/.*/smx,
    );
    $Self->AddOption(
        Name        => 'scope',
        Description => "Define the scope for the uniqueness check (global|class)",
        Required    => 0,
        HasValue    => 1,
        ValueRegex  => qr/(global|class)/smx,
    );
    $Self->AddOption(
        Name        => 'all-states',
        Description => "Also check config items in non-productive states.",
        Required    => 0,
        HasValue    => 0,
    );

    return;
}

sub PreRun {
    my ( $Self, %Param ) = @_;

    # get class argument
    my $Class = $Self->GetOption('class') // '';

    if ($Class) {

        # get class list
        my $ClassList = $Kernel::OM->Get('Kernel::System::GeneralCatalog')->ItemList(
            Class => 'ITSM::ConfigItem::Class',
        );

        # invert the hash to have the classes' names as keys
        my %ClassName2ID = reverse $ClassList->%*;

        # check, whether this class exists
        if ( $ClassName2ID{$Class} ) {
            my $ID = $ClassName2ID{$Class};

            # get ids of this class' config items
            $Self->{SearchCriteria}->{ClassIDs} = [$ID];
        }
        else {
            die "Class $Class does not exist...\n";
        }
    }

    return;
}

sub Run {
    my ( $Self, %Param ) = @_;

    $Self->Print("<yellow>Listing duplicates of config items...</yellow>\n\n");

    if ( !$Self->GetOption('all-states') ) {

        # Limit the checked config items by deployment state
        my $StateList = $Kernel::OM->Get('Kernel::System::GeneralCatalog')->ItemList(
            Class       => 'ITSM::ConfigItem::DeploymentState',
            Preferences => {
                Functionality => [ 'preproductive', 'productive' ],
            },
        );

        $Self->{SearchCriteria}->{DeplStateIDs} = [ keys $StateList->%* ];
    }

    # get ITSMConfigitem object
    my $ITSMConfigitemObject = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');

    # get all config items ids
    my @ConfigItemIDs = $ITSMConfigitemObject->ConfigItemSearch(
        $Self->{SearchCriteria}->%*,
        Result => 'ARRAY',
    );

    # get number of config items
    my $CICount = scalar @ConfigItemIDs;

    # get class argument
    my $Class = $Self->GetOption('class') // '';

    # if there are any CI to check
    if ($CICount) {

        # if the scope was explicitely defined, set it, otherwise this script will fall back to the
        # value set in SysConfig
        my $Scope = $Self->GetOption('scope');
        if ($Scope) {
            $Kernel::OM->Get('Kernel::Config')->Set(
                Key   => 'UniqueCIName::UniquenessCheckScope',
                Value => $Scope,
            );
        }

        if ($Class) {
            $Self->Print("<yellow>Checking config items of class $Class...</yellow>\n");
        }
        else {
            $Self->Print("<yellow>Checking all config items...\n</yellow>\n");
        }

        $Self->Print( "<green>" . ( '=' x 69 ) . "</green>\n" );

        my $DuplicatesFound = 0;

        # check config items
        CONFIG_ITEM_ID:
        for my $ConfigItemID (@ConfigItemIDs) {

            # get the latest version of this config item
            my $Version = $ITSMConfigitemObject->ConfigItemGet(
                ConfigItemID  => $ConfigItemID,
                DynamicFields => 1,
            );

            next CONFIG_ITEM_ID unless $Version;

            if ( !$Version->{Name} ) {
                $Self->Print("<red>Skipping ConfigItem $ConfigItemID as it doesn't have a name.\n</red>\n");

                next CONFIG_ITEM_ID;
            }

            my $Duplicates = $ITSMConfigitemObject->UniqueNameCheck(
                ConfigItemID => $ConfigItemID,
                ClassID      => $Version->{ClassID},
                Name         => $Version->{Name}
            );

            if ( IsArrayRefWithData($Duplicates) ) {

                $DuplicatesFound = 1;

                my @DuplicateData =
                    map { $ITSMConfigitemObject->ConfigItemGet( ConfigItemID => $_ ) }
                    $Duplicates->@*;

                $Self->Print(
                    "<yellow>ConfigItem $Version->{Number} (Name: $Version->{Name}, ConfigItemID: "
                        . "$Version->{ConfigItemID}) has the following duplicates:</yellow>\n"
                );

                # list all the details of the duplicates
                for my $DuplicateVersion (@DuplicateData) {
                    $Self->Print(
                        "\n<green>\t * $DuplicateVersion->{Number} (ConfigItemID: $DuplicateVersion->{ConfigItemID})</green>\n"
                    );
                }

                $Self->Print( "<green>" . ( '-' x 69 ) . "</green>\n" );
            }
        }

        if ($DuplicatesFound) {
            $Self->Print("<green>Finished checking for duplicate names.\n</green>\n");
        }
        else {
            $Self->Print("<yellow>No duplicate names found.\n</yellow>\n");
        }
    }
    else {
        $Self->Print("<yellow>There are NO config items to check.\n</yellow>\n");
    }

    $Self->Print("<green>Done.</green>\n");

    return $Self->ExitCodeOk();
}

1;

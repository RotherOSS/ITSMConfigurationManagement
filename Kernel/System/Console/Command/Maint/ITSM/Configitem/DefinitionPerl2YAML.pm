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

package Kernel::System::Console::Command::Maint::ITSM::Configitem::DefinitionPerl2YAML;

use strict;
use warnings;

use Kernel::Language qw(Translatable);
use Kernel::System::VariableCheck qw(:all);

use parent qw(Kernel::System::Console::BaseCommand);

our @ObjectDependencies = (
    'Kernel::System::DB',
    'Kernel::System::GeneralCatalog',
    'Kernel::System::ITSMConfigItem',
    'Kernel::System::YAML',
);

sub Configure {
    my ( $Self, %Param ) = @_;

    $Self->Description('Convert config items definitions from legacy Perl code to a YAML structure.');

    return;
}

sub Run {
    my ( $Self, %Param ) = @_;

    $Self->Print("<yellow>Converting config item definitions...</yellow>\n\n");

    my $ClassList = $Kernel::OM->Get('Kernel::System::GeneralCatalog')->ItemList(
        Class => 'ITSM::ConfigItem::Class',
        Valid => 0,

        #Preferences   => { },
    );

    my $DBObject = $Kernel::OM->Get('Kernel::System::DB');

    return if !$Kernel::OM->Get('Kernel::System::DB')->Prepare(
        SQL => "
            SELECT id, class_id, configitem_definition, version
            FROM configitem_definition
            WHERE configitem_definition NOT LIKE '---%'
            ORDER BY class_id ASC, version ASC",
    );

    my @DefinitionList;
    while ( my @Row = $Kernel::OM->Get('Kernel::System::DB')->FetchrowArray() ) {
        my %Definition;
        $Definition{DefinitionID} = $Row[0];
        $Definition{ClassID}      = $Row[1];
        $Definition{Definition}   = $Row[2];
        $Definition{Version}      = $Row[3];

        push @DefinitionList, \%Definition;
    }

    if ( !scalar @DefinitionList ) {
        $Self->Print("  No config items using legacy Perl code found\n\n");

        $Self->Print("<green>Done.</green>\n");
        return $Self->ExitCodeOk();
    }

    my $Success    = 1;
    my $YAMLObject = $Kernel::OM->Get('Kernel::System::YAML');

    DEFINITION:
    for my $Definition (@DefinitionList) {

        my $CurrentRecord
            = "   Processing definition for class: <yellow>$ClassList->{ $Definition->{ClassID} }</yellow> version: <yellow>$Definition->{Version}</yellow>...";

        # Try to evaluate perl structure.
        my $PerlStructure = eval $Definition->{Definition};    ## no critic qw(BuiltinFunctions::ProhibitStringyEval)
        if ($@) {
            my $Error = $@;
            $Self->Print("$CurrentRecord <red>Failed evaluate perl structure: $Error</red>\n");
            $Success = 0;
            next DEFINITION;
        }

        # Try to convert from Perl to YAML.
        my $YAMLStr = $YAMLObject->Dump(
            Data => $PerlStructure,
        );
        if ( !$YAMLStr ) {
            $Self->Print("$CurrentRecord <red>Failed to convert to YAML</red>\n");
            $Success = 0;
            next DEFINITION;
        }

        return if !$DBObject->Do(
            SQL => '
                UPDATE configitem_definition
                SET configitem_definition = ?
                WHERE id = ?',
            Bind => [ \$YAMLStr, \$Definition->{DefinitionID} ],
        );

        $Self->Print("$CurrentRecord <green>OK</green>\n");

    }

    if ( !$Success ) {
        $Self->PrintError("\nUnable to convert all config item definitions.");
        return $Self->ExitCodeError();
    }

    $Self->Print("\n<green>Done.</green>\n");
    return $Self->ExitCodeOk();
}

1;

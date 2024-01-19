# --
# OTOBO is a web-based ticketing system for service organisations.
# --
# Copyright (C) 2019-2024 Rother OSS GmbH, https://otobo.de/
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

package Kernel::System::Console::Command::Admin::ITSM::Configitem::DumpGraph;

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

our @ObjectDependencies = qw(
    Kernel::System::DB
    Kernel::System::Main
);

sub Configure {
    my ( $Self, %Param ) = @_;

    $Self->Description('Dump the graph of config items as SVG to the file OTOBO_ITSM_Config_Items.svg.');

    return;
}

sub PreRun {
    my ( $Self, %Param ) = @_;

    return;
}

sub Run {
    my ( $Self, %Param ) = @_;

    # Check whether the optional module GraphViz2 is installed
    my $MainObject = $Kernel::OM->Get('Kernel::System::Main');
    if ( !$MainObject->Require('GraphViz2') ) {
        $Self->PrintError("The optional Perl module 'GraphViz2' is not installed");

        return $Self->ExitCodeError;
    }

    my $DBObject = $Kernel::OM->Get('Kernel::System::DB');
    my $Rows     = $DBObject->SelectAll(
        SQL => <<'END_SQL',
SELECT source_configitem_id, source_configitem_version_id, target_configitem_id, target_configitem_version_id,link_type_id
  FROM configitem_link
END_SQL
    );

    my $Graph = GraphViz2->new(
        edge   => { color    => 'grey' },
        global => { directed => 1 },
        graph  => {
            label   => 'OTOBO ITSM Config Items',
            rankdir => 'TB'
        },
        node => {
            shape => 'oval',
            color => 'blue',
        },
    );

    # look over the edges, add nodes, add the edges
    my %NodeSeen;
    for my $Row ( $Rows->@* ) {
        my ( $SourceConfigItemID, $SourceVersionID, $TargetConfigItemID, $TargetVersionID, $LinkTypeID ) = $Row->@*;

        my $SourceName = $SourceConfigItemID ? "CI $SourceConfigItemID" : "Version $SourceVersionID";
        if ( !$NodeSeen{$SourceName}++ ) {
            my $Shape = $SourceConfigItemID ? 'circle' : 'diamond';
            $Graph->add_node(
                name  => $SourceName,
                shape => $Shape,
            );
        }

        my $TargetName = $TargetConfigItemID ? "CI $TargetConfigItemID" : "Version $TargetVersionID";
        if ( !$NodeSeen{$TargetName}++ ) {
            my $Shape = $TargetConfigItemID ? 'circle' : 'diamond';
            $Graph->add_node(
                name  => $TargetName,
                shape => $Shape
            );
        }

        $Graph->add_edge(
            from  => $SourceName,
            to    => $TargetName,
            label => "Link Type $LinkTypeID",
        );

        # TODO: cluster and order the versions of a CI
        #$Graph->push_subgraph(
        #    name  => 'cluster_1',
        #    graph => {label => 'Child'},
        #    node  => {color => 'magenta', shape => 'diamond'},
        #);
        # $Graph->add_edge(from => 'Chadstone', to => 'Waverley');
        # $Graph->pop_subgraph;
    }

    my $OutputFile = 'OTOBO_ITSM_Config_Items.svg';
    $Graph->run( output_file => $OutputFile );

    $Self->Print("Dump graph in $OutputFile\n");

    return $Self->ExitCodeOk;
}

1;

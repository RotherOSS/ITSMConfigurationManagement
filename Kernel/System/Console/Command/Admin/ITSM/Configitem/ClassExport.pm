# --
# OTOBO is a web-based ticketing system for service organisations.
# --
# Copyright (C) 2001-2020 OTRS AG, https://otrs.com/
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

package Kernel::System::Console::Command::Admin::ITSM::Configitem::ClassExport;

use v5.24;
use strict;
use warnings;
use namespace::autoclean;
use utf8;

use parent qw(Kernel::System::Console::BaseCommand);

# core modules

# CPAN modules

# OTOBO modules
use Kernel::System::VariableCheck qw(:all);

## nofilter(TidyAll::Plugin::OTOBO::Perl::ForeachToFor)

# Inform the object manager about the hard dependencies.
# This module must be discarded when one of the hard dependencies has been discarded.
our @ObjectDependencies = (
    'Kernel::System::DynamicField',
    'Kernel::System::GeneralCatalog',
    'Kernel::System::ITSMConfigItem',
    'Kernel::System::Main',
);

=head1 NAME

Kernel::System::Console::Command::Admin::ITSM::Configitem::ClassExport - support for upgrading the CMDB

=head1 DESCRIPTION

Module for the console command C<Admin::ITSM::Configitem::ClassExport>.

=head1 PUBLIC INTERFACE

=cut

sub Configure {
    my ( $Self, %Param ) = @_;

    $Self->Description(
        'Export dynamic field classes and their respective dynamic fields.'
    );
    $Self->AddOption(
        Name        => 'class',
        Description => "The name of the class to be exported.",
        Required    => 1,
        HasValue    => 1,
        ValueRegex  => qr/./,
        Multiple    => 1,
    );
    $Self->AddOption(
        Name        => 'file',
        Description =>
            "The output YAML file containing the exported class definition and its dynamic field configuration. Defaults to a local file with the name of the first class in the list.",
        Required   => 0,
        HasValue   => 1,
        ValueRegex => qr/./,
    );
    $Self->AddOption(
        Name        => 'force',
        Description => "If the output YAML file already exists, overwrite it without asking.",
        Required    => 0,
        HasValue    => 0,
        ValueRegex  => qr/./,
    );

    return;
}

sub PreRun {
    my ( $Self, %Param ) = @_;

    return 1;
}

sub Run {
    my ( $Self, %Param ) = @_;

    my $ClassNameList  = $Self->GetOption('class');
    my $FileName       = $Self->GetOption('file') || "$ClassNameList->[0].yml";    # by default file has the name of the first class
    my $ForceOverwrite = $Self->GetOption('force');

    my $GeneralCatalogObject = $Kernel::OM->Get('Kernel::System::GeneralCatalog');
    my $ConfigItemObject     = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');

    # lists of existing classes and roles
    my %ClassLookup = reverse %{
        $GeneralCatalogObject->ItemList(
            Class => 'ITSM::ConfigItem::Class',
        ) // {}
    };
    my %RoleLookup = reverse %{
        $GeneralCatalogObject->ItemList(
            Class => 'ITSM::ConfigItem::Role',
        ) // {}
    };

    my $Error = sub {
        $Self->Print("<red>$_[0]</red>\n");
        $Self->ExitCodeError();
    };

    my @ClassIDList;
    for my $ClassName ( @{$ClassNameList} ) {

        if ( $ClassLookup{$ClassName} ) {
            push @ClassIDList, $ClassLookup{$ClassName};

            $Self->Print("<green>Exporting existing configitem</green> $ClassName <green>class</green>\n");
        }
        elsif ( $RoleLookup{$ClassName} ) {
            push @ClassIDList, $RoleLookup{$ClassName};

            $Self->Print("<green>Exporting existing configitem</green> $ClassName <green>role</green>\n");
        }
        else {
            return $Error->( 'Class or Role ' . $ClassName . ' does not exist.' );
        }
    }

    if ( -e $FileName && !$ForceOverwrite ) {
        $Self->Print("<yellow>File '$FileName' already exists. Overwrite it?</yellow>\n");
        $Self->Print("\n<yellow>Please confirm by typing 'y'es</yellow>\n\t");

        return $Self->ExitCodeOk() if <STDIN> !~ /^ye?s?$/i;
    }

    my $YAMLContent = $ConfigItemObject->ClassExport( ItemIDList => \@ClassIDList );

    my $Success = $Kernel::OM->Get('Kernel::System::Main')->FileWrite(
        Location => $FileName,
        Content  => \$YAMLContent,
    );
    return $Error->("Could not write file.") unless $Success;

    $Self->Print("<green>Done with all</green>\n");

    return $Self->ExitCodeOk();
}

1;

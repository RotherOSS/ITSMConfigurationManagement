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

package Kernel::System::Console::Command::Admin::ITSM::ConfigItem::ClassImport;

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
    'Kernel::System::SysConfig',
    'Kernel::System::YAML',
);

=head1 NAME

Kernel::System::Console::Command::Admin::ITSM::ConfigItem::ClassImport - support for upgrading the CMDB

=head1 DESCRIPTION

Module for the console command C<Admin::ITSM::ConfigItem::ClassImport>.

=head1 PUBLIC INTERFACE

=cut

sub Configure {
    my ( $Self, %Param ) = @_;

    $Self->Description(
        'Import dynamic field classes and their respective dynamic fields.'
    );
    $Self->AddOption(
        Name        => 'file',
        Description => "The file containing the class definition and dynamic field configuration as YAML.",
        Required    => 1,
        HasValue    => 1,
        ValueRegex  => qr/./,
    );

    $Self->AddOption(
        Name        => 'update',
        Description => "If the class already exists, update it.",
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

    $Self->Print("<green>Importing new configitem class</green>\n");

    my $File = $Self->GetOption('file');

    my $ConfigItemObject = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');
    my $YAMLObject       = $Kernel::OM->Get('Kernel::System::YAML');

    my $Error = sub {
        $Self->Print("<red>$_[0]</red>\n");

        $Self->ExitCodeError();
    };

    my $DefinitionYAML = $Kernel::OM->Get('Kernel::System::Main')->FileRead(
        Location => $File,
    );

    my $DefinitionRaw = $YAMLObject->Load(
        Data => ${$DefinitionYAML},
    );

    if ( ref $DefinitionRaw eq 'HASH' ) {
        $DefinitionRaw = [$DefinitionRaw];
    }

    return $Error->('Definition is no valid YAML hash.') unless IsArrayRefWithData($DefinitionRaw);

    my $ClassExists = $Self->GetOption('update') ? 'UPDATE' : 'ERROR';
    my $Result      = $ConfigItemObject->ClassImport(
        Content     => $DefinitionRaw,
        ClassExists => $ClassExists,
    );

    return $Error->( $Result->{ErrorMessage} || "Could not import definitions from file." ) unless $Result->{Success};

    $Self->Print("<green>Done with all</green>\n");

    return $Self->ExitCodeOk();
}

1;

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

package Kernel::System::Console::Command::Admin::ITSM::Configitem::ClassImport;

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

Kernel::System::Console::Command::Admin::ITSM::Configitem::ClassImport - support for upgrading the CMDB

=head1 DESCRIPTION

Module for the console command C<Admin::ITSM::Configitem::UpgradeTo11>.

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

    my $ConfigItemObject     = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');
    my $GeneralCatalogObject = $Kernel::OM->Get('Kernel::System::GeneralCatalog');
    my $YAMLObject           = $Kernel::OM->Get('Kernel::System::YAML');

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

    # list of configitem classes
    my %ClassLookup = reverse %{
        $GeneralCatalogObject->ItemList(
            Class => 'ITSM::ConfigItem::Class',
        ) // {}
    };

    # create all imported classes first because dynamic fields might depend on them
    for my $ClassDefinition ( $DefinitionRaw->@* ) {

        return $Error->('Definition is no valid YAML hash.') unless IsHashRefWithData($ClassDefinition);

        my $ClassName = $ClassDefinition->{ClassName};

        return $Error->('No valid class name present.') unless $ClassName;

        $Self->Print("<yellow>Creating class $ClassName...</yellow>\n");

        # handle class creation
        return $Error->("Class $ClassName already exists.") if $ClassLookup{$ClassName};

        my $ClassID = $GeneralCatalogObject->ItemAdd(
            Class   => 'ITSM::ConfigItem::Class',
            Name    => $ClassName,
            ValidID => 1,
            UserID  => 1,
        );

        return $Error->("Could not add class $ClassName.") unless $ClassID;

        $Self->Print("<green>Done</green>\n");
    }

    for my $ClassDefinition ( $DefinitionRaw->@* ) {

        return $Error->('Definition is no valid YAML hash.') unless IsHashRefWithData($ClassDefinition);

        $Self->Print("<yellow>Importing definition for class $ClassDefinition->{ClassName}...\n</yellow>");

        my $Success = $ConfigItemObject->ClassImport(
            DefinitionRaw => $ClassDefinition,
            ClassHandled  => 1,
        );

        return $Error->("Could not import class $ClassDefinition->{ClassName}.") unless $Success;

        $Self->Print("<green>Done</green>\n");
    }

    $Self->Print("<green>Done with all</green>\n");

    return $Self->ExitCodeOk();
}

1;

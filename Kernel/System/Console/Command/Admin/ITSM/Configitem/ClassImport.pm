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
    'Kernel::System::YAML',
);

=head1 NAME

Kernel::System::Console::Command::Admin::ITSM::Configitem::UpgradeTo11 - support for upgrading the CMDB

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

    my $GeneralCatalogObject = $Kernel::OM->Get('Kernel::System::GeneralCatalog');
    my $DynamicFieldObject   = $Kernel::OM->Get('Kernel::System::DynamicField');
    my $YAMLObject           = $Kernel::OM->Get('Kernel::System::YAML');
    my $ConfigItemObject     = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');

    # list of configitem classes
    my %ClassLookup = reverse %{ $GeneralCatalogObject->ItemList(
        Class => 'ITSM::ConfigItem::Class',
    ) // {} };

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

    return $Error->('Definition is no valid YAML hash.') if !IsHashRefWithData( $DefinitionRaw );

    my $ClassName = delete $DefinitionRaw->{ClassName};

    return $Error->('Need attribute "ClassName" to determine the name of the new class.') if !$ClassName;
    return $Error->('Class '. $ClassName .' already exists.') if $ClassLookup{ $ClassName };

    for my $Key ( qw/Pages Sections DynamicFields/ ) {
        return $Error->('Need '. $Key .' in Definition.') if !$DefinitionRaw->{$Key};
    }

    my $DynamicFields = delete $DefinitionRaw->{DynamicFields};

    my $FinalDefinition = $YAMLObject->Dump(
        Data => $DefinitionRaw,
    );

    return $Error->('Error recreating the definition yaml.') if !$FinalDefinition;

    my %DynamicFieldLookup = reverse %{ $DynamicFieldObject->DynamicFieldList(
        Valid      => 0,
        ResultType => 'HASH',
    ) || {} };

    my %SetDFs;
    for my $Field ( keys $DynamicFields->%* ) {
        if ( $DynamicFields->{$Field}{FieldType} eq 'Set' ) {
            my %SetFields = map { $_->{DF} => $_->{Definition} } $DynamicFields->{$Field}{Config}{Include}->@*;

            return $Error->('Erroneous configuration of Set '. $Field .'.') if !%SetFields;

            %SetDFs = (
                %SetDFs,
                %SetFields,
            );
        }
    }

    my %AllFields = ( $DynamicFields->%*, %SetDFs );
    my %Namespaces;
    for my $Field ( keys %AllFields ) {
        if ( $DynamicFieldLookup{ $Field } ) {
            my $DynamicField = $DynamicFieldObject->DynamicFieldGet(
                Name => $Field,
            );

            if ( $DynamicField->{FieldType} ne $AllFields{$Field}{FieldType} || $DynamicField->{ObjectType} ne 'ITSMConfigItem' ) {
                return $Error->("DynamicField $Field exists but does not have the required Object- and/or FieldType.");
            }

            if ( $DynamicField->{MultiValue} xor $AllFields{$Field}{MultiValue} ) {
                return $Error->("DynamicField $Field exists but does not match the multivalue setting.");
            }
        }

        if ( $Field !~ m{ \A [a-zA-Z\d\-]+ \z }xms ) {
            return $Error->("Invalid DynamicField name '$Field'.");
        }

        if ( $Field =~ /^([^-]+)-/ ) {
            $Namespaces{$1} = 1;
        }
    }

    $Self->Print("<yellow>Please confirm the creation of the new config item class</yellow> $ClassName <yellow>using the following dynamic fields</yellow>\n");

    for my $Field ( sort keys $DynamicFields->%* ) {
        my $Status = $DynamicFieldLookup{ $Field } ? " <green>(use existing)</green>\n" : " <yellow>(create)</yellow>";
        $Self->Print( $Field . $Status . "\n" );
    }

    $Self->Print("\n<yellow>Please confirm by typing 'y'es</yellow>\n\t");

    return $Self->ExitCodeOk() if <STDIN> !~ /^ye?s?$/i;

    my $ClassID = $GeneralCatalogObject->ItemAdd(
        Class   => 'ITSM::ConfigItem::Class',
        Name    => $ClassName,
        ValidID => 1,
        UserID  => 1,
    );

    return $Error->('Could not add class '. $ClassName .'.') if !$ClassID;

    my $Order = scalar ( keys %DynamicFieldLookup );

    # create dynamic fields
    FIELD:
    for my $Field ( keys %SetDFs, keys $DynamicFields->%* ) {
        next FIELD if $DynamicFieldLookup{ $Field };

        my %SetConfig;
        if ( $AllFields{$Field}{FieldType} eq 'Set' ) {
            my @Included = map { { DF => $_->{DF} } } $AllFields{$Field}{Config}{Include}->@*;
            %SetConfig = (
                Config => {
                    $AllFields{$Field}{Config}->%*,
                    Include => \@Included,
                },
            );
        }

        $AllFields{$Field}{ID} = $DynamicFieldObject->DynamicFieldAdd(
            $AllFields{$Field}->%*,
            %SetConfig,
            FieldOrder => ++$Order,
            ObjectType => 'ITSMConfigItem',
            Reorder    => 0,
            ValidID    => 1,
            UserID     => 1,
        );

        return $Error->('Could not add dynamic field '. $Field .'.') if !$AllFields{$Field}{ID};
    }

    my $DefinitionID = $ConfigItemObject->DefinitionAdd(
        ClassID    => $ClassID,
        Definition => $FinalDefinition,
        UserID     => 1,
    );

    return $Error->('Could not store definition.') if !$DefinitionID;

    $Self->Print("<green>Done</green>\n");

    return $Self->ExitCodeOk();
}

1;

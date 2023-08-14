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

package Kernel::System::Console::Command::Admin::ITSM::Configitem::UpgradeTo11;

use v5.24;
use strict;
use warnings;
use namespace::autoclean;
use utf8;

use parent qw(Kernel::System::Console::BaseCommand);

# core modules
use Path::Class qw(dir);

# OTOBO modules
use Kernel::System::VariableCheck qw(:all);

## nofilter(TidyAll::Plugin::OTOBO::Perl::ForeachToFor)

# Inform the object manager about the hard dependencies.
# This module must be discarded when one of the hard dependencies has been discarded.
our @ObjectDependencies = (
    'Kernel::Config',
    'Kernel::System::GeneralCatalog',
    'Kernel::System::ITSMConfigItem',
    'Kernel::System::Main',
    'Kernel::System::YAML',
);

sub Configure {
    my ( $Self, %Param ) = @_;

    $Self->Description(
        'Upgrade the complete CMDB from OTOBO 10 to OTOBO 11. All config item definitions will be changed, for each config item attribute a dynamic field will be prepared and the data will be migrated.'
    );
    $Self->AddOption(
        Name        => 'use-defaults',
        Description => "Make the script non interactive. Always use default suggestions and do not give the chance to customize the schemata.",
        Required    => 0,
        HasValue    => 0,
    );
    $Self->AddOption(
        Name        => 'start-at',
        Description => "Start at a certain step. Valid values are: 0 - Restart completely; 1 -",
        Required    => 0,
        HasValue    => 1,
        ValueRegex  => qr/^[0-4]$/,
    );
    $Self->AddOption(
        Name        => 'tmpdir',
        Description => "Provide a temporary directory to store mappings and schemata.",
        Required    => 0,
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

    my @Steps = (
        'Prepare Attribute Mapping',

        #        'Prepare DynamicFields',  # necessary? what do we want to make configurable besides the name? (step 0)
        'Prepare Definitions',
        'Migrate Definitions',
        'Migrate Attribute Data',
        'Delete Legacy Data',
    );

    my %StepHandlers = (
        'Prepare Attribute Mapping' => \&_PrepareAttributeMapping,

        #        'Prepare DynamicFields'     => \&_PrepareDynamicFieldConfigs,
        'Prepare Definitions'    => \&_PrepareDefinitions,
        'Migrate Definitions'    => \&_MigrateDefinitions,
        'Migrate Attribute Data' => \&_MigrateAttributeData,
        'Delete Legacy Data'     => \&_DeleteLegacyData,
    );

    my $TempDir = $Kernel::OM->Get('Kernel::Config')->Get('TempDir');

    $Self->{WorkingDir}  = $Self->GetOption('tmpdir') || "$TempDir/CMDBUpgradeTo11Schemata";
    $Self->{UseDefaults} = $Self->GetOption('use-defaults');
    my $StartAt = $Self->GetOption('start-at') // $Self->_GetCurrentStep();

    if ($StartAt) {
        if ( !-d $Self->{WorkingDir} ) {
            $Self->Print("<red>Need existing working directory '$Self->{WorkingDir}'.</red>\n");

            die;
        }

        $Self->Print("<yellow>Continue CMDB upgrade at: '$Steps[ $StartAt ]'!</yellow>\n");
    }
    else {
        $Self->Print("<yellow>Starting CMDB upgrade!</yellow>\n");
    }

    $Self->{GeneralCatalogObject} = $Kernel::OM->Get('Kernel::System::GeneralCatalog');
    $Self->{ConfigItemObject}     = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');
    $Self->{YAMLObject}           = $Kernel::OM->Get('Kernel::System::YAML');

    # list of configitem classes, either in OTOBO 10 or OTOBO 11 format
    $Self->{ClassList} = $Self->{GeneralCatalogObject}->ItemList(
        Class => 'ITSM::ConfigItem::Class',
    );

    for my $ClassID ( keys $Self->{ClassList}->%* ) {
        $Self->{DefinitionList}{$ClassID} = $Self->{ConfigItemObject}->DefinitionList(
            ClassID => $ClassID,
        );
    }

    my $Success;
    STEP:
    for my $CurrentStep ( $StartAt .. $#Steps ) {
        $Success = $StepHandlers{ $Steps[$CurrentStep] }->(
            $Self,
            CurrentStep => $CurrentStep,
        );

        last STEP unless $Success;
        last STEP unless $Success eq 'Next';
    }

    if ($Success) {
        $Self->Print("<green>Done!</green>\n");

        return $Self->ExitCodeOk();
    }
    else {
        $Self->Print("<green>An error occured!</green>\n");

        return $Self->ExitCodeError();
    }
}

sub _GetCurrentStep {
    my ( $Self, %Param ) = @_;

    return 0;
}

sub _PrepareAttributeMapping {
    my ( $Self, %Param ) = @_;

    # TODO: create dir in a init subroutine
    if ( !-d $Self->{WorkingDir} ) {
        dir( $Self->{WorkingDir} )->mkpath( 0, oct('770') );    # 0 turns off verbosity
    }

    if ( !-d $Self->{WorkingDir} ) {
        $Self->Print("<red>Could not create the working directory '$Self->{WorkingDir}'.</red>\n");

        die;
    }

    $Self->Print("<yellow>Writing attribute maps into $Self->{WorkingDir}</yellow>\n");

    my $MainObject = $Kernel::OM->Get('Kernel::System::Main');

    CLASS_ID:
    for my $ClassID ( keys $Self->{ClassList}->%* ) {
        my %Attributes;

        for my $Definition ( $Self->{DefinitionList}{$ClassID}->@* ) {
            my @CurAttributes = $Self->_GetAttributesFromLegacyYAML(
                Definition => $Definition->{Definition},
                Subs       => 1,
            );

            %Attributes = (
                %Attributes,
                map { $_->{Key} => 1 } @CurAttributes,
            );
        }

        # do not write an attribute map for OTOBO 11 config items
        next CLASS_ID unless %Attributes;

        my %AttributeMap = map { $_ => $_ =~ s/[^\w\d]//gr } keys %Attributes;
        my $MapYAML      = $Self->{YAMLObject}->Dump(
            Data => \%AttributeMap,
        );

        #TODO: add extension '.yml'
        $MainObject->FileWrite(
            Directory => $Self->{WorkingDir},
            Filename  => 'AttributeMap_' . $Self->{ClassList}{$ClassID},
            Content   => \$MapYAML,
        );
    }

    return $Self->_ContinueOrNot( CurrentStep => $Param{CurrentStep} );
}

sub _PrepareDefinitions {
    my ( $Self, %Param ) = @_;

    $Self->Print("<yellow>Writing class definitions.</yellow>\n");

    my $MainObject = $Kernel::OM->Get('Kernel::System::Main');

    CLASS_ID:
    for my $ClassID ( keys $Self->{ClassList}->%* ) {

        # TODO: add extension .yml
        my $MapRef = $MainObject->FileRead(
            Directory => $Self->{WorkingDir},
            Filename  => 'AttributeMap_' . $Self->{ClassList}{$ClassID},
        );

        # Skip the class when there is no attribute mapping.
        # This happens when the file was removed or when the class already was in OTOBO 12 format.
        next CLASS_ID unless defined $MapRef;

        my $AttributeMap = $Self->{YAMLObject}->Load(
            Data => ${$MapRef},
        );

        # a sanity check
        next CLASS_ID unless ref $AttributeMap eq 'HASH';

        for my $Definition ( $Self->{DefinitionList}{$ClassID}->@* ) {
            my @Attributes = $Self->_GetAttributesFromLegacyYAML(
                Definition => $Definition->{Definition},
            );

            my $DefinitionYAML = $Self->_GenerateDefinitionYAML(
                Attributes   => \@Attributes,
                AttributeMap => $AttributeMap,
                Class        => $Self->{ClassList}{$ClassID},
            );

            #TODO: add extension '.yml'
            my $FileLocation = $MainObject->FileWrite(
                Directory => $Self->{WorkingDir},
                Filename  => 'DefinitionMap_' . $Self->{ClassList}{$ClassID} . '_' . $Definition->{DefinitionID},
                Content   => \$DefinitionYAML,
            );
        }
    }

    return $Self->_ContinueOrNot( CurrentStep => $Param{CurrentStep} );
}

sub _MigrateDefinitions {
    my ( $Self, %Param ) = @_;

    $Self->Print("<yellow>Import definitions.</yellow>\n");

    return 'Next';
}

sub _MigrateAttributeData {
    my ( $Self, %Param ) = @_;

    $Self->Print("<yellow>Copy attribute data.</yellow>\n");

    return 'Next';
}

sub _DeleteLegacyData {
    my ( $Self, %Param ) = @_;

    $Self->Print(
        "<yellow>Optionally all legacy data can be deleted. This step is not necessary for the migrated CMDB to work and can be done at any later time.</yellow>\n"
    );
    $Self->Print("\n<red>Do you really want to permanently delete all legacy data from the system? (yes/no)</red>\n");

    return 'Next';
}

sub _GenerateDefinitionYAML {
    my ( $Self, %Param ) = @_;

    my $YAML = <<'END_YAML';
---
Pages:
  - Name: Content
    Layout:
      Columns: 1
      ColumnWidth: 1fr
    Content:
      - Section: Attributes
        ColumnStart: 1
        RowStart: 1

Sections:
  Attributes:
    Content:
END_YAML

    #my %DynamicFields; # in progress
    for my $Attribute ( $Param{Attributes}->@* ) {
        $YAML .= "      - DF: $Param{AttributeMap}{ $Attribute->{Key} }\n";

        my %DFBasic = (
            Name       => $Param{AttributeMap}{ $Attribute->{Key} },
            Label      => $Attribute->{Name},
            ObjectType => 'ITSMConfigItem',
            CIClass    => $Param{Class},
        );

        # Continue reading out FieldType and Config
        if ( $Attribute->{Sub} ) {
        }
        else {

        }
    }
    $YAML .= "\n";

    return $YAML;
}

sub _GetAttributesFromLegacyYAML {
    my ( $Self, %Param ) = @_;

    my $DefinitionRef = $Param{DefinitionRef} // $Self->{YAMLObject}->Load(
        Data => $Param{Definition},
    );

    # Skip definitions that are already in the format for OTOBO 11
    if ( ref $DefinitionRef eq 'HASH' ) {
        return if $DefinitionRef->{Pages};
        return if $DefinitionRef->{Sections};
    }

    # a sanity test whether this is possibly in the format for OTOBO 10
    if ( ref $DefinitionRef ne 'ARRAY' ) {
        $Self->Print("<red>Need a valid legacy definition!</red>\n");

        die;
    }

    my @Attributes;
    for my $Attribute ( $DefinitionRef->@* ) {
        push @Attributes, $Attribute;

        if ( $Attribute->{Subs} ) {
            push @Attributes, $Self->_GetAttributesFromLegacyYAML( DefinitionRef => delete $Attribute->{Sub} );

            $Attribute->{Key}  .= '<SubPrimaryAttribute>';
            $Attribute->{Name} .= ' Name';

            push @Attributes, $Attribute;
        }
    }

    return @Attributes;
}

sub _ContinueOrNot {
    my ( $Self, %Param ) = @_;

    return 'Next' if $Self->{UseDefaults};

    $Self->Print(
        "<yellow>You can pause here to review and possibly alter the suggestions by inspecting and changing the files. Calling the script again later should automatically resume at the right step, you can manually enforce this by calling via:</yellow>\n"
    );
    $Self->Print( "\tbin/otobo.Console.pl Admin::ITSM::ConfigItem::UpgradeTo11 --start-at " . ( $Param{CurrentStep} + 1 ) . "\n" );
    $Self->Print("\n<yellow>To finish the script now, just press enter. To directly continue with the default suggestions without review write 'def'.</yellow>\n");

    return 'Next' if <STDIN> =~ m/^def(ault)?$/;

    return 'Exit';
}

1;

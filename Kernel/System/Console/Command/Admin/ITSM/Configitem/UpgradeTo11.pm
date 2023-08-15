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
use List::Util qw(uniq);

# CPAN modules

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

=head1 NAME

Kernel::System::Console::Command::Admin::ITSM::Configitem::UpgradeTo11 - support for upgrading the CMDB

=head1 DESCRIPTION

Module for the console command C<Admin::ITSM::Configitem::UpgradeTo11>.

=head1 PUBLIC INTERFACE

=cut

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

    # Declaration of processing steps.
    # This allows picking up processing at a specific step. On the command line
    # the steps are numbered, starting at 1.
    my @StepDeclarations = (
        {
            Name    => 'Prepare Attribute Mapping',
            Handler => \&_PrepareAttributeMapping,
        },

        # 'Prepare DynamicFields',  # necessary? what do we want to make configurable besides the name? (step 0)
        {
            Name    => 'Prepare Definitions',
            Handler => \&_PrepareDefinitions,
        },
        {
            Name    => 'Migrate Definitions',
            Handler => \&_MigrateDefinitions,
        },
        {
            Name    => 'Migrate Attribute Data',
            Handler => \&_MigrateAttributeData,
        },
        {
            Name    => 'Delete Legacy Data',
            Handler => \&_DeleteLegacyData,
        },
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

        $Self->Print("<yellow>Continue CMDB upgrade at: '$StepDeclarations[ $StartAt ]->{Name}'!</yellow>\n");
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

    # get complete history of the definitions for the configitem class
    for my $ClassID ( keys $Self->{ClassList}->%* ) {
        $Self->{DefinitionList}{$ClassID} = $Self->{ConfigItemObject}->DefinitionList(
            ClassID => $ClassID,
        );
    }

    my $Success;
    STEP:
    for my $CurrentStep ( $StartAt .. $#StepDeclarations ) {
        my $StepDeclaration = $StepDeclarations[$CurrentStep];
        $Self->Print("<green>Start working on $StepDeclaration->{Name}</green>\n");
        $Success = $StepDeclaration->{Handler}->(
            $Self,
            CurrentStep => $CurrentStep,
        );

        last STEP unless $Success;
        last STEP unless $Success eq 'Next';
    }

    if ($Success) {
        $Self->Print("<green>Done!</green>\n");

        return $Self->ExitCodeOk;
    }
    else {
        $Self->Print("<green>An error occured!</green>\n");

        return $Self->ExitCodeError;
    }
}

=head1 PRIVATE METHODS

=head2  _GetCurrentStep()

This method is not implemented yet.

=cut

sub _GetCurrentStep {
    my ( $Self, %Param ) = @_;

    return 0;
}

=head2 _PrepareAttributeMapping()

Collect the attributes that are referenced in any version of any of the legacy config item classes.

One mapping is dumped per config item class. This mapping maps the key of the legacy attribute
to the name that should be used for the config item in OTOBO 11.

=cut

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

        # Loop over all versions of definitions for that config item class
        my @AttributeKeys;
        for my $Definition ( $Self->{DefinitionList}{$ClassID}->@* ) {
            my @AttributesForVersion = $Self->_GetAttributesFromLegacyYAML(
                Definition => $Definition->{Definition},
                RecuSubs   => 1,
            );

            # not caring about duplicates here
            push @AttributeKeys, map { $_->{Key} } @AttributesForVersion;
        }

        # do not write an attribute map for OTOBO 11 config items
        # TODO: maybe check for a mix of OTOBO 10 and OTOBO 11 formats
        next CLASS_ID unless @AttributeKeys;

        my %AttributeMap = map { $_ => $_ =~ s/[^\w\d]//gr } uniq @AttributeKeys;
        my $MapYAML      = $Self->{YAMLObject}->Dump(
            Data => \%AttributeMap,
        );

        $MainObject->FileWrite(
            Directory => $Self->{WorkingDir},
            Filename  => 'AttributeMap_' . $Self->{ClassList}{$ClassID} . '.yml',
            Content   => \$MapYAML,
        );

        return 'Next';
    }

    return $Self->_ContinueOrNot( CurrentStep => $Param{CurrentStep} );
}

sub _PrepareDefinitions {
    my ( $Self, %Param ) = @_;

    $Self->Print("<yellow>Writing class definitions.</yellow>\n");

    my $MainObject = $Kernel::OM->Get('Kernel::System::Main');

    CLASS_ID:
    for my $ClassID ( keys $Self->{ClassList}->%* ) {

        my $MapRef = $MainObject->FileRead(
            Directory => $Self->{WorkingDir},
            Filename  => 'AttributeMap_' . $Self->{ClassList}{$ClassID} . '.yml',
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

    # Explictily generate a YAML string in order to have better control
    # of the layout.
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

    my %DynamicFields;

    ATTRIBUTE:
    for my $Attribute ( $Param{Attributes}->@* ) {
        my $YAMLLine = "      - DF: $Param{AttributeMap}{ $Attribute->{Key} }\n";

        if ( $Attribute->{Input}{Required} ) {
            $YAMLLine .= "        Mandatory: 1\n";
        }

        my %DFBasic = (
            Name       => $Param{AttributeMap}{ $Attribute->{Key} },
            Label      => $Attribute->{Name},
            ObjectType => 'ITSMConfigItem',
            CIClass    => $Param{Class},
        );

        my %DFSpecific = $Self->_DFConfigFromLegacy(
            Attribute    => $Attribute,
            AttributeMap => $Param{AttributeMap},
            Class        => $Param{Class},
        );

        if ( !%DFSpecific ) {
            $Self->Print("<red>Could not convert "$Attribute->{Name}" to DynamicField (Class: "$Param{Class}")!</red>\n");

            next ATTRIBUTE;
        }

        $YAML .= $YAMLLine;

        $DynamicFields{ $Param{AttributeMap}{ $Attribute->{Key} } } = { %DFBasic, %DFSpecific };
    }
    $YAML .= "\n";

    $YAML .= $Kernel::OM->Get('Kernel::System::YAML')->Dump(
        Data => \%DynamicFields;
    );

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

        if ( $Attribute->{Subs} && $Param{RecuSubs} ) {
            push @Attributes, $Self->_GetAttributesFromLegacyYAML( DefinitionRef => delete $Attribute->{Sub} );

            $Attribute->{Key}  .= '<SubPrimaryAttribute>';
            $Attribute->{Name} .= ' Name';

            push @Attributes, $Attribute;
        }
    }

    return @Attributes;
}

sub _DFConfigFromLegacy {
    my ( $Self, %Param ) = @_;

    if ( !$Param{Attribute}{Input}{Type} ) {
        $Self->Print("<red>Attribute without Input Type!</red>\n");

        return;
    }

    my $Type = $Param{Attribute}{Input}{Type};
    my %DF;

    if ( any { $Param{Attribute}{$_} } qw/CountMin CountMax CountDefault/ ) {
        $DF{Config}{MultiValue} = 1;
    }

    if ( $Param{Attribute}{Sub} ) {
        if ( $Param{InSub} ) {
            $Self->Print("<red>Subs of subs are not supported!</red>\n");

            return;
        }

        my $Sub = delete $Param{Attribute}{Sub};

        $Param{Attribute}{Key}  .= '<SubPrimaryAttribute>';
        $Param{Attribute}{Name} .= ' Name';

        my @Include;

        ATTRIBUTE:
        for my $Attribute ( $Param{Attribute}, $Sub->@* ) {
            my %DFBasic = (
                Name       => $Param{AttributeMap}{ $Attribute->{Key} },
                Label      => $Attribute->{Name},
                ObjectType => 'ITSMConfigItem',
                CIClass    => $Param{Class},
            );

            my %DFSpecific = $Self->_DFConfigFromLegacy(
                Attribute    => $Attribute,
                AttributeMap => $Param{AttributeMap},
                Class        => $Param{Class},
            );

            if ( !%DFSpecific ) {
                $Self->Print("<red>Could not convert "$Attribute->{Name}" to DynamicField (Class: "$Param{Class}")!</red>\n");

                next ATTRIBUTE;
            }

            push @Include, {
                DF         => $Param{AttributeMap}{ $Attribute->{Key} },
                Definition => { %DFBasic, %DFSpecific },
            };
        }

        $DF{Config}{Include} = \@Include;
    }
    elsif ( $Type eq 'Text' || $Type eq 'TextArea' ) {
        $DF{FieldType}         = $Type;
        $DF{Config}{RegExList} = [];

        if ( $Param{Attribute}{Input}{RegEx} ) {
            $DF{Config}{RegExList} = [{
                Value        => $Param{Attribute}{Input}{RegEx},
                ErrorMessage => $Param{Attribute}{Input}{RegExErrorMessage} // 'Format invalid!',
            }];
        }

        if ( $Param{Attribute}{Input}{ValueDefault} ) {
            $DF{Config}{DefaultValue} = $Param{Attribute}{Input}{ValueDefault};
        }
    }
    elsif ( $Type eq 'GeneralCatalog' ) {
        $DF{FieldType} = $Type;

        if ( !$Param{Attribute}{Input}{Class} ) {
            $Self->Print("<red>GeneralCatalog attribute without class!</red>\n");

            return;
        }

        $DF{Config}{Class} = $Param{Attribute}{Input}{Class};

        if ( $Param{Attribute}{Input}{Translation} ) {
            $DF{Config}{TranslatableValues} = 1;
        }
    }
    elsif ( $Type eq 'CustomerCompany' ) {
        $DF{FieldType} = $Type;
    }
    elsif ( $Type eq 'Customer' ) {
        $DF{FieldType} = 'CustomerUser';
    }
    elsif ( $Type eq 'Date' || $Type eq 'DateTime') {
        $DF{FieldType} = $Type;

        $DF{Config}{YearsInFuture} = 5;
        $DF{Config}{YearsInPast}   = 5;
        $DF{Config}{YearsPeriod}   = 0;

        if ( $Param{Attribute}{Input}{YearPeriodFuture} ) {
            $DF{Config}{YearsPeriod}   = 1;
            $DF{Config}{YearsInFuture} = $Param{Attribute}{Input}{YearPeriodFuture};
        }
        if ( $Param{Attribute}{Input}{YearPeriodPast} ) {
            $DF{Config}{YearsPeriod}   = 1;
            $DF{Config}{YearsInPast}   = $Param{Attribute}{Input}{YearPeriodPast};
        }
    }
    elsif ( $Type eq 'Integer' ) {
        $DF{FieldType} = 'Dropdown';

        if ( !$Param{Attribute}{Input}{ValueMin} || !$Param{Attribute}{Input}{ValueMax} ) {
            $Self->Print("<red>Need ValueMin and ValueMax for integer fields!</red>\n");

            return;
        }

        $DF{Config}{PossibleValues} = { map { $_ => $_ } ( $Param{Attribute}{Input}{ValueMin} .. $Param{Attribute}{Input}{ValueMax} ) };

        if ( $Param{Attribute}{Input}{ValueDefault} ) {
            $DF{Config}{DefaultValue} = $Param{Attribute}{Input}{ValueDefault};
        }
    }
    else {
        $Self->Print("<red>Unknown input type "$Type"!</red>\n");

        return;
    }

    return %DF;
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

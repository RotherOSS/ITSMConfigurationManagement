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

package Kernel::System::Console::Command::Admin::ITSM::ConfigItem::UpgradeTo11;

use v5.24;
use strict;
use warnings;
use namespace::autoclean;
use utf8;

use parent qw(Kernel::System::Console::BaseCommand);

# core modules
use Path::Class qw(dir);
use List::Util  qw(any uniq);

# CPAN modules

# OTOBO modules
use Kernel::System::VariableCheck qw(:all);

## nofilter(TidyAll::Plugin::OTOBO::Perl::ForeachToFor)

# Inform the object manager about the hard dependencies.
# This module must be discarded when one of the hard dependencies has been discarded.
our @ObjectDependencies = (
    'Kernel::Config',
    'Kernel::System::DB',
    'Kernel::System::Cache',
    'Kernel::System::CIAttachmentStorage::AttachmentStorage',
    'Kernel::System::DynamicField',
    'Kernel::System::DynamicField::Backend',
    'Kernel::System::GeneralCatalog',
    'Kernel::System::Group',
    'Kernel::System::ITSMConfigItem',
    'Kernel::System::Main',
    'Kernel::System::Package',
    'Kernel::System::SysConfig',
    'Kernel::System::XML',
    'Kernel::System::YAML',
);

=head1 NAME

Kernel::System::Console::Command::Admin::ITSM::ConfigItem::UpgradeTo11 - support for upgrading the CMDB

=head1 DESCRIPTION

Module for the console command C<Admin::ITSM::ConfigItem::UpgradeTo11>.

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
    $Self->AddOption(
        Name        => 'no-namespace',
        Description => "Provide a comma separated list of attributes which are to be generated without namespace.",
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
    $Self->{NoNamespace} = $Self->GetOption('no-namespace');
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

    # list of ConfigItem classes, either in OTOBO 10 or OTOBO 11 format
    $Self->{ClassList} = $Self->{GeneralCatalogObject}->ItemList(
        Class => 'ITSM::ConfigItem::Class',
    );

    # get complete history of the definitions for the configitem class
    for my $ClassID ( sort { $a <=> $b } keys $Self->{ClassList}->%* ) {
        $Self->{DefinitionList}{$ClassID} = $Self->{ConfigItemObject}->DefinitionList(
            ClassID => $ClassID,
        );
    }

    my $Success;
    STEP:
    for my $CurrentStep ( $StartAt .. $#StepDeclarations ) {
        my $StepDeclaration = $StepDeclarations[$CurrentStep];
        $Self->Print("\n<green>~~ Step $CurrentStep ~~\nStart working on $StepDeclaration->{Name}</green>\n");
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
        $Self->Print("<red>An error occurred!</red>\n");

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

    # TODO: create directory in an initialization subroutine
    if ( !-d $Self->{WorkingDir} ) {
        dir( $Self->{WorkingDir} )->mkpath( 0, oct('770') );    # 0 turns off verbosity
    }

    if ( !-d $Self->{WorkingDir} ) {
        $Self->Print("<red>Could not create the working directory '</red>$Self->{WorkingDir}<red>'.</red>\n");

        die;
    }

    $Self->Print("<yellow>Writing attribute maps into</yellow> $Self->{WorkingDir}\n");

    my $MainObject = $Kernel::OM->Get('Kernel::System::Main');

    my %NoNamespace;
    if ( $Self->{NoNamespace} ) {
        %NoNamespace = map { $_ => 1 } split( /\s*,\s*/, $Self->{NoNamespace} );
    }

    CLASS_ID:
    for my $ClassID ( sort { $a <=> $b } keys $Self->{ClassList}->%* ) {

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

        my $Namespace = $Self->{ClassList}{$ClassID} =~ s/[^\w\d]//gr;

        # TODO: what is special about Umlauts and ß
        my %Substitions = (
            'ä' => 'ae',
            'ö' => 'oe',
            'ü' => 'ue',
            'ß' => 'ss',
            '_'  => '',
        );

        for my $Sub ( sort keys %Substitions ) {
            $Namespace =~ s/$Sub/$Substitions{$Sub}/;
        }

        my %AttributeMap;
        for my $Key ( uniq @AttributeKeys ) {
            my $FieldName = $Key =~ s/[^\w\d]//gr;
            for my $Sub ( sort keys %Substitions ) {
                $FieldName =~ s/$Sub/$Substitions{$Sub}/;
            }

            $AttributeMap{$Key} = $NoNamespace{$Key} ? $FieldName : $Namespace . '-' . $FieldName;
        }

        my $MapYAML = $Self->{YAMLObject}->Dump(
            Data => \%AttributeMap,
        );

        $MainObject->FileWrite(
            Directory => $Self->{WorkingDir},
            Filename  => 'AttributeMap_' . $Self->{ClassList}{$ClassID} . '.yml',
            Content   => \$MapYAML,
        );
    }

    return $Self->_ContinueOrNot( CurrentStep => $Param{CurrentStep} );
}

sub _PrepareDefinitions {
    my ( $Self, %Param ) = @_;

    $Self->Print("<yellow>Writing class definitions.</yellow>\n");

    my $MainObject = $Kernel::OM->Get('Kernel::System::Main');

    # when checking for the necessary packages to install without --use-defaults
    # if exists more than one element or more than one version of an element that requires a package
    # the same message is issued repeatedly referring to the same package
    # this hash is used to prevent message repetition
    my %CheckedPackages;

    $Self->{MissingPackages} = 0;

    CLASS_ID:
    for my $ClassID ( sort { $a <=> $b } keys $Self->{ClassList}->%* ) {

        my $FilenameClean = $MainObject->FilenameCleanUp(
            Filename => 'AttributeMap_' . $Self->{ClassList}{$ClassID} . '.yml',
        );

        # Skip the class when there is no attribute mapping.
        next CLASS_ID unless -e $Self->{WorkingDir} . '/' . $FilenameClean;

        my $MapRef = $MainObject->FileRead(
            Directory => $Self->{WorkingDir},
            Filename  => $FilenameClean,
        );

        # Skip the class when there is no attribute mapping.
        # This happens when the file was removed or when the class already was in OTOBO 11 format.
        # TODO: here it is an error now, we don't even try if the file is removed
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
                Attributes      => \@Attributes,
                AttributeMap    => $AttributeMap,
                Class           => $Self->{ClassList}{$ClassID},
                DefinitionID    => $Definition->{DefinitionID},
                CheckedPackages => \%CheckedPackages,
            );

            my $FileLocation = $MainObject->FileWrite(
                Directory => $Self->{WorkingDir},
                Filename  => $Self->{ClassList}{$ClassID} . '_CIDefinition_' . $Definition->{DefinitionID} . '.yml',
                Content   => \$DefinitionYAML->{ConfigItem},
            );

            $FileLocation = $MainObject->FileWrite(
                Directory => $Self->{WorkingDir},
                Filename  => $Self->{ClassList}{$ClassID} . '_DFDefinition_' . $Definition->{DefinitionID} . '.yml',
                Content   => \$DefinitionYAML->{DynamicField},
            );
        }
    }

    if ( $Self->{MissingPackages} ) {
        $Self->Print("\n<red>Import failed. There are $Self->{MissingPackages} necessary package(s) missing installation.</red>\n");
        return 'Exit';
    }

    return $Self->_ContinueOrNot( CurrentStep => $Param{CurrentStep} );
}

sub _MigrateDefinitions {
    my ( $Self, %Param ) = @_;

    $Self->Print("<yellow>Import definitions.</yellow>\n");

    my $MainObject         = $Kernel::OM->Get('Kernel::System::Main');
    my $DBObject           = $Kernel::OM->Get('Kernel::System::DB');
    my $YAMLObject         = $Kernel::OM->Get('Kernel::System::YAML');
    my $DynamicFieldObject = $Kernel::OM->Get('Kernel::System::DynamicField');
    my $XMLObject          = $Kernel::OM->Get('Kernel::System::XML');

    # keep the legacy definition for now
    my $ColumnAddXML = <<'END_XML';
<TableAlter Name="configitem_definition">
  <ColumnAdd Name="configitem_definition_legacy" Required="false" Type="LONGBLOB" />
</TableAlter>
END_XML

    # Create database specific SQL and PostSQL commands out of XML.
    my @AddXMLARRAY = $XMLObject->XMLParse( String => $ColumnAddXML );

    # Create database specific SQL.
    my @ColumnAddSQL = $DBObject->SQLProcessor(
        Database => \@AddXMLARRAY,
    );

    # Create database specific PostSQL.
    my @ColumnAddSQLPost = $DBObject->SQLProcessorPost();

    # Execute SQL.
    for my $SQL ( @ColumnAddSQL, @ColumnAddSQLPost ) {
        my $Success = $DBObject->Do( SQL => $SQL );
        if ( !$Success ) {
            $Self->Print(
                "<yellow>Could not clone the configitem_definition column DB table. If you attempted this step earlier, please write 'con' to continue.</yellow>\n\t"
            );

            return if <STDIN> !~ m/^con(tinue)?$/;
        }
    }

    $DBObject->Do(
        SQL => 'UPDATE configitem_definition SET configitem_definition_legacy = configitem_definition',
    );

    my %DynamicFields;
    my %Definitions;
    my %Namespaces;

    # collect data
    CLASS_ID:
    for my $ClassID ( sort { $a <=> $b } keys $Self->{ClassList}->%* ) {

        my $FilenameClean = $MainObject->FilenameCleanUp(
            Filename => 'AttributeMap_' . $Self->{ClassList}{$ClassID} . '.yml',
        );

        # Skip the class when there is no attribute mapping.
        next CLASS_ID unless -e $Self->{WorkingDir} . '/' . $FilenameClean;

        DEFINITION:
        for my $Definition ( $Self->{DefinitionList}{$ClassID}->@* ) {

            my $FilenameClean = $MainObject->FilenameCleanUp(
                Filename => $Self->{ClassList}{$ClassID} . '_CIDefinition_' . $Definition->{DefinitionID} . '.yml',
            );

            # skip definitions if files are not provided; TODO: only skip without error if this is for the whole class
            next DEFINITION unless -e $Self->{WorkingDir} . '/' . $FilenameClean;

            my $ConfigItemYAML = $MainObject->FileRead(
                Directory => $Self->{WorkingDir},
                Filename  => $FilenameClean,
            );

            my $ConfigItemDefinition = $YAMLObject->Load(
                Data => ${$ConfigItemYAML},
            );

            # TODO: Add and use a DefinitionCheck of Kernel::System::ITSMConfigItem::Definition

            if ( !$ConfigItemDefinition ) {
                $Self->Print( "<red>Could not interpret" . $Self->{ClassList}{$ClassID} . '_CIDefinition_' . $Definition->{DefinitionID} . ".yml!</red>\n" );

                return;
            }

            $FilenameClean = $MainObject->FilenameCleanUp(
                Filename => $Self->{ClassList}{$ClassID} . '_DFDefinition_' . $Definition->{DefinitionID} . '.yml',
            );

            my $DynamicFieldYAML = $MainObject->FileRead(
                Directory => $Self->{WorkingDir},
                Filename  => $FilenameClean,
            );

            my $DynamicFieldDefinition = $YAMLObject->Load(
                Data => ${$DynamicFieldYAML},
            );

            if ( !$DynamicFieldDefinition ) {
                $Self->Print( "<red>Could not interpret" . $Self->{ClassList}{$ClassID} . '_DFDefinition_' . $Definition->{DefinitionID} . ".yml!</red>\n" );

                return;
            }

            $Definitions{$ClassID}{ $Definition->{DefinitionID} } = {
                ConfigItemYAML => ${$ConfigItemYAML},
                DynamicField   => $DynamicFieldDefinition,
            };

            for my $Name ( sort keys $DynamicFieldDefinition->%* ) {
                $DynamicFields{$Name} = $DynamicFieldDefinition->{$Name};

                if ( $Name =~ /^([^-]+)-/ ) {
                    $Namespaces{$1} = 1;
                }

                if ( $DynamicFieldDefinition->{$Name}{FieldType} eq 'Set' ) {
                    for my $Included ( $DynamicFieldDefinition->{$Name}{Config}{Include}->@* ) {
                        if ( $Included->{DF} =~ /^([^-]+)-/ ) {
                            $Namespaces{$1} = 1;
                        }

                        $DynamicFields{ $Included->{DF} } = $Included->{Definition};
                    }
                }
            }
        }
    }

    # set namespace setting if empty
    my $NamespacesSetting = $Kernel::OM->Get('Kernel::Config')->Get('DynamicField::Namespaces');
    if ( %Namespaces && ( !$NamespacesSetting || !$NamespacesSetting->@* ) ) {
        my $SysConfigObject = $Kernel::OM->Get('Kernel::System::SysConfig');

        my $ExclusiveLockGUID = $SysConfigObject->SettingLock(
            LockAll => 1,
            Force   => 1,
            UserID  => 1,
        );

        $SysConfigObject->SettingUpdate(
            Name              => 'DynamicField::Namespaces',
            IsValid           => 1,
            EffectiveValue    => [ sort keys %Namespaces ],
            ExclusiveLockGUID => $ExclusiveLockGUID,
            UserID            => 1,
        );

        $SysConfigObject->SettingUnlock(
            UnlockAll => 1,
        );

        # 'Rebuild' the configuration.
        $SysConfigObject->ConfigurationDeploy(
            Comments    => "CMDB Upgrade: Add dynamic field namespaces.",
            AllSettings => 1,
            UserID      => 1,
        );
    }
    elsif (%Namespaces) {
        $Self->Print(
            "\n<yellow>You already have dynamic field namespaces deployed, thus the new ones will not automatically be set. Please add them manually:</yellow>\n"
        );
        for my $Namespace ( sort keys %Namespaces ) {
            $Self->Print("\t$Namespace\n");
        }
        $Self->Print("\n");
    }

    # get current field order
    my $DynamicFieldList = $DynamicFieldObject->DynamicFieldListGet(
        Valid => 0,
    );
    my $Order = $DynamicFieldList->@*;

    # create dynamic fields
    for my $Field ( sort keys %DynamicFields ) {
        my %SetConfig;
        if ( $DynamicFields{$Field}{FieldType} eq 'Set' ) {
            my @Included = map { { DF => $_->{DF} } } $DynamicFields{$Field}{Config}{Include}->@*;
            %SetConfig = (
                Config => {
                    $DynamicFields{$Field}{Config}->%*,
                    Include => \@Included,
                },
            );
        }

        $DynamicFields{$Field}{ID} = $DynamicFieldObject->DynamicFieldAdd(
            $DynamicFields{$Field}->%*,
            %SetConfig,
            FieldOrder => ++$Order,
            ObjectType => 'ITSMConfigItem',
            Reorder    => 0,
            ValidID    => 1,
            UserID     => 1,
        );

        if ( !$DynamicFields{$Field}{ID} ) {

            # TODO: alternatively try to get the DF, and check whether its definition fits. Maybe still ask
            $Self->Print(
                "<red>Could not create dynamic field $Field! Fix its definitions and delete all other dynamic fields created by this process before retrying.</red>\n"
            );

            return;
        }
    }

    my $AllSuccess = 1;

    # set new definitions
    CLASS_ID:
    for my $ClassID ( sort { $a <=> $b } keys %Definitions ) {

        my $FilenameClean = $MainObject->FilenameCleanUp(
            Filename => 'AttributeMap_' . $Self->{ClassList}{$ClassID} . '.yml',
        );

        # Skip the class when there is no attribute mapping.
        next CLASS_ID unless -e $Self->{WorkingDir} . '/' . $FilenameClean;

        DEFINITION:
        for my $DefinitionID ( sort { $a <=> $b } keys $Definitions{$ClassID}->%* ) {

            # add the ID of the newly created dynamic fields to their definition specific configs
            for my $DynamicField ( values $Definitions{$ClassID}{$DefinitionID}{DynamicField}->%* ) {
                $DynamicField->{ID} = $DynamicFields{ $DynamicField->{Name} }{ID};

                if ( $DynamicField->{FieldType} eq 'Set' ) {
                    for my $Included ( $DynamicField->{Config}{Include}->@* ) {
                        $Included->{Definition}{ID} = $DynamicFields{ $Included->{DF} }{ID};
                    }
                }
            }

            my $DynamicFieldYAML = $YAMLObject->Dump(
                Data => $Definitions{$ClassID}{$DefinitionID}{DynamicField},
            );

            my $Success = $DBObject->Do(
                SQL  => 'UPDATE configitem_definition SET configitem_definition = ?, dynamicfield_definition = ? WHERE id = ?',
                Bind => [ \$Definitions{$ClassID}{$DefinitionID}{ConfigItemYAML}, \$DynamicFieldYAML, \$DefinitionID ],
            );

            # TODO: If an error occurs, ask, whether we should continue or not probably. Here it would start to get messy...
            if ( !$Success ) {
                $Self->Print("<red>Could not update DB entry of definition id '$DefinitionID'!</red>\n");
                $AllSuccess = 0;
            }
        }

        my $PermissionGroupID = $Kernel::OM->Get('Kernel::System::Group')->GroupLookup(
            Group => 'itsm-configitem',
        );

        # update class preferences
        my %PreferencesDefaults = (
            Permission          => [$PermissionGroupID],
            NumberModule        => ['AutoIncrement'],
            VersionStringModule => ['Incremental'],
            Categories          => ['All'],
        );
        for my $Preference ( keys %PreferencesDefaults ) {
            my $Success = $Self->{GeneralCatalogObject}->GeneralCatalogPreferencesSet(
                ItemID => $ClassID,
                Key    => $Preference,
                Value  => $PreferencesDefaults{$Preference},
            );

            if ( !$Success ) {
                $Self->Print("<red>Could not set preference '$Preference' for class '$ClassID'!</red>\n");
            }
        }
    }

    return unless $AllSuccess;
    return 'Next';
}

sub _MigrateAttributeData {
    my ( $Self, %Param ) = @_;

    $Self->Print("<yellow>Copy attribute data.</yellow>\n");

    my $MainObject                = $Kernel::OM->Get('Kernel::System::Main');
    my $DynamicFieldBackendObject = $Kernel::OM->Get('Kernel::System::DynamicField::Backend');
    my $SysConfigObject           = $Kernel::OM->Get('Kernel::System::SysConfig');
    my $DBObject                  = $Kernel::OM->Get('Kernel::System::DB');

    $Kernel::OM->Get('Kernel::System::DB')->Do(
        SQL => 'UPDATE configitem_version SET change_time=create_time, change_by=create_by WHERE change_by IS NULL;',
    );

    my %BaseArrayFields = map { $_ => 1 } qw/GeneralCatalog CustomerCompany CustomerUser Ticket ConfigItem Agent Service Queue SLA Type/;
    my $DisabledHistory;
    my $HistorySetting = q{ITSMConfigItem::EventModulePost###100-History};

    delete $Self->{ConfigItemObject}{Cache}{DefinitionGet};
    local $| = 1;

    CLASS_ID:
    for my $ClassID ( sort { $a <=> $b } keys $Self->{ClassList}->%* ) {

        my $FilenameClean = $MainObject->FilenameCleanUp(
            Filename => 'AttributeMap_' . $Self->{ClassList}{$ClassID} . '.yml',
        );

        # Skip the class when there is no attribute mapping.
        next CLASS_ID unless -e $Self->{WorkingDir} . '/' . $FilenameClean;

        my %Definition;
        my $MapRef = $MainObject->FileRead(
            Directory => $Self->{WorkingDir},
            Filename  => $FilenameClean,
        );

        # Skip the class when there is no attribute mapping.
        # This happens when the file was removed or when the class already was in OTOBO 11 format.
        next CLASS_ID unless defined $MapRef;

        my $AttributeMap = $Self->{YAMLObject}->Load(
            Data => ${$MapRef},
        );

        # a sanity check
        next CLASS_ID unless ref $AttributeMap eq 'HASH';

        # for sets
        my $AttributeLookup = { reverse $AttributeMap->%* };

        for my $DefinitionID ( map { $_->{DefinitionID} } $Self->{DefinitionList}{$ClassID}->@* ) {
            $Definition{$DefinitionID} = $Self->{ConfigItemObject}->DefinitionGet(
                DefinitionID => $DefinitionID,
            );
        }

        # get all versions of a class in one go
        # TODO: Do we need batches for really large CMDBs?
        my $Rows = $Kernel::OM->Get('Kernel::System::DB')->SelectAll(
            SQL => <<'END_SQL',
SELECT v.id, v.definition_id, v.configitem_id
  FROM configitem_version v
  INNER JOIN configitem ci ON v.configitem_id = ci.id
  WHERE ci.class_id = ?
  ORDER BY v.id
END_SQL
            Bind => [ \$ClassID ],
        );

        # TODO: disable history before the loop over the classes
        if ( !$DisabledHistory && $Kernel::OM->Get('Kernel::Config')->Get($HistorySetting) ) {

            # do not write a history
            my $ExclusiveLockGUID = $SysConfigObject->SettingLock(
                LockAll => 1,
                Force   => 1,
                UserID  => 1,
            );

            $SysConfigObject->SettingUpdate(
                Name              => $HistorySetting,
                IsValid           => 0,
                ExclusiveLockGUID => $ExclusiveLockGUID,
                UserID            => 1,
            );

            $SysConfigObject->SettingUnlock(
                UnlockAll => 1,
            );

            # 'Rebuild' the configuration.
            # TODO: why must this setting be deployed? It should suffice to change is temporarily
            $SysConfigObject->ConfigurationDeploy(
                Comments    => "CMDB Upgrade: Temporarily disable CMDB history for the data transfer.",
                AllSettings => 1,
                UserID      => 1,
            );

            $DisabledHistory = 1;
        }

        my @Skipped;
        my %CIVersionStringCounter;
        my $Count = scalar $Rows->@*;
        my $Frac  = int( $Count / 10 );
        my $c     = 0;

        $Self->Print("\tWorking on <yellow>$Self->{ClassList}{$ClassID}</yellow> ($Count Versions)");

        ROW:
        for my $Row ( $Rows->@* ) {
            my ( $VersionID, $DefinitionID, $ConfigItemID ) = $Row->@*;

            # set configitem version string
            $CIVersionStringCounter{$ConfigItemID} //= 1;
            my $UpdateSuccess = $DBObject->Do(
                SQL => <<'END_SQL',
UPDATE configitem_version
  SET version_string = ?, change_time = current_timestamp, change_by = ?
  WHERE id = ?
END_SQL
                Bind => [
                    \$CIVersionStringCounter{$ConfigItemID},
                    \1,
                    \$VersionID,
                ],
            );
            if ( !$UpdateSuccess ) {
                $Self->Print("<red>Could not set VersionString for ConfigItem $ConfigItemID, Version $VersionID!</red>\n");
            }
            $CIVersionStringCounter{$ConfigItemID}++;

            if ( ++$c == $Frac ) {
                $Self->Print(".");
                $c = 0;
            }

            if ( !$Definition{$DefinitionID}{DynamicFieldRef} ) {
                push @Skipped, $VersionID;

                next ROW;
            }

            # get version
            my @XML = $Kernel::OM->Get('Kernel::System::XML')->XMLHashGet(
                Type => "ITSM::ConfigItem::$ClassID",
                Key  => $VersionID,
            );

            # try archive
            if ( !@XML ) {
                @XML = $Kernel::OM->Get('Kernel::System::XML')->XMLHashGet(
                    Type => "ITSM::ConfigItem::Archiv::$ClassID",
                    Key  => $VersionID,
                );
            }

            ATTRIBUTE:
            for my $Attribute ( sort keys $XML[1]{Version}[1]->%* ) {
                next ATTRIBUTE unless $AttributeMap->{$Attribute};

                my $DynamicField = $Definition{$DefinitionID}{DynamicFieldRef}{ $AttributeMap->{$Attribute} };

                next ATTRIBUTE unless $DynamicField;

                my $Value;
                if ( $DynamicField->{FieldType} eq 'Set' ) {
                    for my $Set ( @{ $XML[1]{Version}[1]{$Attribute} }[ 1 .. $XML[1]{Version}[1]{$Attribute}->$#* ] ) {
                        my %SetValue;

                        for my $Included ( $DynamicField->{Config}{Include}->@* ) {
                            if ( $AttributeLookup->{ $Included->{DF} } eq $Attribute . '::<SubPrimaryAttribute>' ) {

                                if ( $Included->{Definition}{FieldType} eq 'DateTime' ) {
                                    $Set->{Content} .= ':00';
                                }

                                $SetValue{ $Included->{DF} } = $BaseArrayFields{ $Included->{Definition}{FieldType} } ? [ $Set->{Content} ] : $Set->{Content};
                            }
                            else {
                                my $Name    = $AttributeLookup->{ $Included->{DF} } =~ s/^.+?:://r;
                                my $SubAttr = $Set->{$Name};
                                my $SubAttrValue;
                                if ( $BaseArrayFields{ $Included->{Definition}{FieldType} } || $Included->{Definition}{Config}{MultiValue} ) {
                                    $SubAttrValue = [ map { $_->{Content} } @{$SubAttr}[ 1 .. $SubAttr->$#* ] ];
                                }
                                else {
                                    $SubAttrValue = $SubAttr->[1]{Content};
                                }
                                my %Values = (
                                    $Included->{DF} => $SubAttrValue,
                                );

                                if ( $Included->{Definition}{FieldType} eq 'DateTime' ) {
                                    %Values = map { ( $_ => $Values{$_} . ':00' ) } keys %Values;
                                }

                                %SetValue = (
                                    %SetValue,
                                    %Values,
                                );
                            }
                        }

                        push $Value->@*, \%SetValue;
                    }
                }
                elsif ( $DynamicField->{Config}{MultiValue} ) {
                    my @Values = map { $_->{Content} } @{ $XML[1]{Version}[1]{$Attribute} }[ 1 .. $XML[1]{Version}[1]{$Attribute}->$#* ];

                    INDEX:
                    while (@Values) {
                        if ( !defined $Values[-1] || $Values[-1] eq '' ) {
                            pop @Values;
                        }
                        else {
                            last INDEX;
                        }
                    }

                    next ATTRIBUTE if !@Values;

                    if ( $DynamicField->{FieldType} eq 'DateTime' ) {
                        @Values = map { $_ . ':00' } @Values;
                    }

                    $Value = \@Values;
                }
                else {
                    $Value = $BaseArrayFields{ $DynamicField->{FieldType} } ? [ $XML[1]{Version}[1]{$Attribute}[1]{Content} ] : $XML[1]{Version}[1]{$Attribute}[1]{Content};

                    if ( $DynamicField->{FieldType} eq 'DateTime' ) {
                        $Value .= ':00';
                    }
                    elsif ( $DynamicField->{FieldType} eq 'Attachment' ) {
                        my $AttachmentBackendObject = $Kernel::OM->Get('Kernel::System::CIAttachmentStorage::AttachmentStorage');
                        my $Attachment              = $AttachmentBackendObject->AttachmentStorageGet(
                            ID => $Value,
                        );

                        $Value = [
                            {
                                Content     => ${ $Attachment->{ContentRef} },
                                ContentType => $Attachment->{Preferences}{DataType},
                                Filename    => $Attachment->{FileName},
                                FileSize    => $Attachment->{Preferences}{FileSizeBytes},
                            }
                        ];
                    }

                    next ATTRIBUTE if !defined $Value || $Value eq '';
                }

                if ( $DynamicField->{FieldType} eq 'Set' ) {
                    if ( !( ref $Value ) || ( ref $Value ne 'ARRAY' ) ) {
                        $Value = [$Value];
                    }
                }

                $DynamicFieldBackendObject->ValueSet(
                    DynamicFieldConfig => $DynamicField,
                    ObjectID           => $VersionID,
                    Value              => $Value,
                    UserID             => 1,
                    ConfigItemHandled  => 1,
                );
            }
        }
        $Self->Print("\n");
    }

    if ($DisabledHistory) {

        # reactivate wrinting history
        my $ExclusiveLockGUID = $SysConfigObject->SettingLock(
            LockAll => 1,
            Force   => 1,
            UserID  => 1,
        );

        $SysConfigObject->SettingUpdate(
            Name              => $HistorySetting,
            IsValid           => 1,
            ExclusiveLockGUID => $ExclusiveLockGUID,
            UserID            => 1,
        );

        $SysConfigObject->SettingUnlock(
            UnlockAll => 1,
        );

        # 'Rebuild' the configuration.
        $SysConfigObject->ConfigurationDeploy(
            Comments    => "CMDB Upgrade: Reenable CMDB history.",
            AllSettings => 1,
            UserID      => 1,
        );
    }

    $Kernel::OM->Get('Kernel::System::Cache')->CleanUp(
        Type => 'ITSMConfigurationManagement'
    );

    return 'Next';
}

sub _DeleteLegacyData {
    my ( $Self, %Param ) = @_;

    $Self->Print(
        "<yellow>Optionally all legacy data can be deleted. This step is not necessary for the migrated CMDB to work and can be done at any later time.</yellow>\n"
    );
    $Self->Print("\n<red>Do you really want to permanently delete all backup legacy data from the system? (type 'yes')</red>\n");

    if ( <STDIN> =~ m/^yes$/i ) {    ## no critic qw(InputOutput::ProhibitExplicitStdin);

        # get necessary objects
        my $MainObject      = $Kernel::OM->Get('Kernel::System::Main');
        my $SysConfigObject = $Kernel::OM->Get('Kernel::System::SysConfig');
        my $PackageObject   = $Kernel::OM->Get('Kernel::System::Package');

        # 1. delete files from temporary directory
        $Self->Print("<yellow>Deleting previously created temporary files from disk...</yellow>\n");
        my @FilesInDirectory = $MainObject->DirectoryRead(
            Directory => $Self->{WorkingDir},
            Filter    => '*',
        );
        for my $File ( sort @FilesInDirectory ) {
            my $Success = $MainObject->FileDelete(
                Location => $File,
            );
            if ( !$Success ) {
                $Self->Print("<red>Could not delete file $File!</red>");
            }
        }
        $Self->Print("<green>Done deleting temporary files.</green>\n");

        # 2. delete configitem_definition_legacy database column
        $Self->Print("<yellow>Deleting database column configitem_definition_legacy from table configitem_definition...</yellow>\n");
        $Kernel::OM->Get('Kernel::System::DB')->Do(
            SQL => 'ALTER TABLE configitem_definition DROP COLUMN configitem_definition_legacy',
        );
        $Self->Print("<green>Done deleting the database column.</green>\n");

        # 3. clean up xml storage
        # get all versions and corresponding class ids in one go
        # TODO: Do we need batches for really large CMDBs?
        $Self->Print("<yellow>Deleting configitem data from xml storage...</yellow>\n");
        my $Rows = $Kernel::OM->Get('Kernel::System::DB')->SelectAll(
            SQL => <<'END_SQL',
SELECT v.id, ci.class_id
  FROM configitem_version v
  INNER JOIN configitem ci ON v.configitem_id = ci.id
  ORDER BY v.id
END_SQL
        );

        # TODO: disable history before the loop over the classes
        my $DisabledHistory;
        my $HistorySetting = q{ITSMConfigItem::EventModulePost###100-History};
        if ( !$DisabledHistory && $Kernel::OM->Get('Kernel::Config')->Get($HistorySetting) ) {

            # do not write a history
            my $ExclusiveLockGUID = $SysConfigObject->SettingLock(
                LockAll => 1,
                Force   => 1,
                UserID  => 1,
            );

            $SysConfigObject->SettingUpdate(
                Name              => $HistorySetting,
                IsValid           => 0,
                ExclusiveLockGUID => $ExclusiveLockGUID,
                UserID            => 1,
            );

            $SysConfigObject->SettingUnlock(
                UnlockAll => 1,
            );

            # 'Rebuild' the configuration.
            # TODO: why must this setting be deployed? It should suffice to change is temporarily
            $SysConfigObject->ConfigurationDeploy(
                Comments    => "CMDB Upgrade: Temporarily disable CMDB history for the data transfer.",
                AllSettings => 1,
                UserID      => 1,
            );

            $DisabledHistory = 1;
        }

        ROW:
        for my $Row ( $Rows->@* ) {
            my ( $VersionID, $ClassID ) = $Row->@*;

            $Kernel::OM->Get('Kernel::System::XML')->XMLHashDelete(
                Type => "ITSM::ConfigItem::$ClassID",
                Key  => $VersionID,
            );
        }
        $Self->Print("<green>Done deleting config item data from xml storage.</green>\n");

        # remove CIAttributeCollection package if present
        my $PackageName = 'ITSM-CIAttributeCollection';
        my @Repos       = $PackageObject->RepositoryList(
            Result => 'Short'
        );
        my @PackageEntry = grep { $_->{Name} eq $PackageName } @Repos;
        if (@PackageEntry) {
            $Self->Print("<yellow>Uninstalling $PackageName package...</yellow>\n");
            my $PackageVersion = $PackageEntry[0]{Version};
            $Self->Print("<yellow>Found $PackageName Version $PackageVersion</yellow>\n");

            # reset settings that this legacy package unsuccessfully attempts to reset upon uninstallation (lock is missing)
            $Self->_ResetSettings(
                SettingName => 'Loader::Agent::CommonJS###100-ConfigurationManagement',
            );

            my $Package = $PackageObject->RepositoryGet(
                Name    => $PackageName,
                Version => $PackageVersion,
            );
            my $Success = $PackageObject->PackageUninstall(
                String => $Package,
            );
            if ($Success) {
                $Self->Print("<green>Done uninstalling $PackageName package.</green>\n");
            }
            else {
                $Self->Print("<red>Could not uninstall $PackageName package!</red>\n");
            }
        }
    }
    else {
        $Self->Print(
            "<green>Continuing without deleting legacy data.</green>\n"
        );
    }

    return 'Next';
}

sub _GenerateDefinitionYAML {
    my ( $Self, %Param ) = @_;

    # Explicitly generate a YAML string in order to have better control
    # of the layout.
    my $CIYAML = <<'END_YAML';
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
        next ATTRIBUTE if !$Param{AttributeMap}{ $Attribute->{Key} };

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
            DefinitionID => $Param{DefinitionID},
        );

        if ( !%DFSpecific ) {
            $Self->Print(
                "<red>Could not convert '$Attribute->{Name}' to DynamicField (Class: '$Param{Class}'; DefinitionID: '$Param{DefinitionID}') - skipping attribute!</red>\n"
            );

            next ATTRIBUTE;
        }

        $CIYAML .= $YAMLLine;

        $DynamicFields{ $Param{AttributeMap}{ $Attribute->{Key} } } = { %DFBasic, %DFSpecific };
    }

    my $DFYAML = $Kernel::OM->Get('Kernel::System::YAML')->Dump(
        Data => \%DynamicFields,
    );

    return {
        ConfigItem   => $CIYAML,
        DynamicField => $DFYAML,
    };
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

        if ( $Attribute->{Sub} && $Param{RecuSubs} ) {
            my $PrimarySub = { Key => $Attribute->{Key} . '::<SubPrimaryAttribute>' };

            push @Attributes, $PrimarySub;
            my @SubAttributes = $Self->_GetAttributesFromLegacyYAML( DefinitionRef => $Attribute->{Sub} );
            push @Attributes, map { { Key => $Attribute->{Key} . '::' . $_->{Key} } } @SubAttributes;
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

    my $DynamicFieldObject        = $Kernel::OM->Get('Kernel::System::DynamicField');
    my $DynamicFieldBackendObject = $Kernel::OM->Get('Kernel::System::DynamicField::Backend');

    my $Type = $Param{Attribute}{Input}{Type};
    my %DF;

    if ( any { defined $Param{Attribute}{$_} } qw/CountMin CountMax CountDefault/ ) {
        unless ( !$Param{Attribute}{CountMax} || ( $Param{Attribute}{CountMax} && $Param{Attribute}{CountMax} <= 1 ) ) {    ## no critic qw(ControlStructures::ProhibitUnlessBlocks)
            $DF{Config}{MultiValue} = 1;
        }
    }

    if ( $Param{Attribute}{Sub} ) {
        $DF{FieldType} = 'Set';

        if ( $Param{InSub} ) {
            $Self->Print("<red>Subs of subs are not supported!</red>\n");

            return;
        }

        my $Sub     = delete $Param{Attribute}{Sub};
        my $Primary = {
            $Param{Attribute}->%*,
            Key  => '<SubPrimaryAttribute>',
            Name => 'Name',
        };

        # primary attribute cannot be multivalue in XML schema
        for my $Delete (qw/CountMin CountMax CountDefault/) {
            delete $Primary->{$Delete};
        }

        my @Include;

        ATTRIBUTE:
        for my $Attribute ( $Primary, $Sub->@* ) {
            $Attribute->{Key} = $Param{Attribute}{Key} . '::' . $Attribute->{Key};

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
                DefinitionID => $Param{DefinitionID},
            );

            if ( !%DFSpecific ) {
                $Self->Print(
                    "<red>Could not convert sub attribute '$Attribute->{Name}' ($Param{Attribute}{Key}::$Attribute->{Key}) to DynamicField (Class: '$Param{Class}';  DefinitionID: '$Param{DefinitionID}') - skipped attribute!</red>\n"
                );

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
        $DF{FieldType} = $Type;
        $DF{Config}{RegExList} = [];

        if ( $Param{Attribute}{Input}{RegEx} ) {
            $DF{Config}{RegExList} = [
                {
                    Value        => $Param{Attribute}{Input}{RegEx},
                    ErrorMessage => $Param{Attribute}{Input}{RegExErrorMessage} // 'Format invalid!',
                }
            ];
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

        $DF{Config}{PossibleNone} = 1;
    }
    elsif ( $Type eq 'CustomerCompany' ) {
        $DF{FieldType} = $Type;

        $DF{Config}{PossibleNone}  = 1;
        $DF{Config}{EditFieldMode} = 'Dropdown';
    }
    elsif ( $Type eq 'Customer' ) {
        $DF{FieldType} = 'CustomerUser';

        $DF{Config}{PossibleNone}  = 1;
        $DF{Config}{EditFieldMode} = 'AutoComplete';
    }
    elsif ( $Type eq 'Date' || $Type eq 'DateTime' ) {
        $DF{FieldType} = $Type;

        $DF{Config}{YearsInFuture} = 5;
        $DF{Config}{YearsInPast}   = 5;
        $DF{Config}{YearsPeriod}   = 0;

        if ( $Param{Attribute}{Input}{YearPeriodFuture} ) {
            $DF{Config}{YearsPeriod}   = 1;
            $DF{Config}{YearsInFuture} = $Param{Attribute}{Input}{YearPeriodFuture};
        }
        if ( $Param{Attribute}{Input}{YearPeriodPast} ) {
            $DF{Config}{YearsPeriod} = 1;
            $DF{Config}{YearsInPast} = $Param{Attribute}{Input}{YearPeriodPast};
        }
    }
    elsif ( $Type eq 'Integer' ) {
        $DF{FieldType} = 'Dropdown';

        $Param{Attribute}{Input}{ValueMin} ||= 0;
        $Param{Attribute}{Input}{ValueMax} ||= 30;

        $DF{Config}{PossibleValues} = { map { $_ => $_ } ( $Param{Attribute}{Input}{ValueMin} .. $Param{Attribute}{Input}{ValueMax} ) };

        if ( $Param{Attribute}{Input}{ValueDefault} ) {
            $DF{Config}{DefaultValue} = $Param{Attribute}{Input}{ValueDefault};
        }
        else {
            $DF{Config}{PossibleNone} = 1;
        }
    }
    elsif ( $Type eq 'TicketReference' ) {
        $DF{FieldType}                    = 'Ticket';
        $DF{Config}{PossibleNone}         = 1;
        $DF{Config}{EditFieldMode}        = 'AutoComplete';
        $DF{Config}{ReferencedObjectType} = 'Ticket';
    }
    elsif ( $Type eq 'CIClassReference' ) {
        $DF{FieldType}               = 'ConfigItem';
        $DF{Config}{EditFieldMode}   = 'AutoComplete';
        $DF{Config}{SearchAttribute} = 'Name';

        if ( $Param{Attribute}{Input}{ReferencedCIClassName} ) {
            my $ReferencedCIClassName = $Param{Attribute}{Input}{ReferencedCIClassName};
            my %ClassName2ID          = reverse %{
                $Kernel::OM->Get('Kernel::System::GeneralCatalog')->ItemList(
                    Class => 'ITSM::ConfigItem::Class',
                ) // {}
            };
            if ( $ClassName2ID{$ReferencedCIClassName} ) {
                $DF{Config}{ClassIDs} = [ $ClassName2ID{$ReferencedCIClassName} ];
            }
            else {
                my $AttrKey = $Param{Attribute}{Key};
                $Self->Print("<yellow>The ReferencedCIClassName '$ReferencedCIClassName' in attribute '$AttrKey' has no match</yellow>\n");
            }
        }
    }
    elsif ( $Type eq 'User' ) {
        $DF{FieldType} = 'Agent';
        $DF{Config}{EditFieldMode} = 'AutoComplete';
    }
    elsif ( $Type eq 'CIACCustomerCompany' ) {
        $DF{FieldType} = 'CustomerCompany';
        $DF{Config}{EditFieldMode} = 'AutoComplete';
    }
    elsif ( $Type eq 'CustomerUserCompany' ) {
        $DF{FieldType} = 'CustomerCompany';
        $DF{Config}{EditFieldMode} = 'AutoComplete';
    }
    elsif ( $Type eq 'CIAttachment' ) {
        my $CheckPackage = $Self->_CheckInstalledPackage(
            %Param,
            Package => 'DynamicFieldAttachment',
        );

        if ( !$CheckPackage && $Self->{UseDefaults} ) {
            $Self->{MissingPackages}++;
        }
        $DF{FieldType} = 'Attachment';
        $DF{Config}{EditFieldMode} = 'AutoComplete';
    }
    elsif ( $Type eq 'ServiceReference' ) {
        $DF{FieldType} = 'Service';
        $DF{Config}{EditFieldMode} = 'AutoComplete';
    }
    elsif ( $Type eq 'QueueReference' ) {
        my $CheckPackage = $Self->_CheckInstalledPackage(
            %Param,
            Package => 'DynamicFieldTicketsAttributes',
        );

        if ( !$CheckPackage && $Self->{UseDefaults} ) {
            $Self->{MissingPackages}++;
        }
        $DF{FieldType} = 'Queue';
        $DF{Config}{EditFieldMode} = 'AutoComplete';
    }
    elsif ( $Type eq 'SLAReference' ) {
        my $CheckPackage = $Self->_CheckInstalledPackage(
            %Param,
            Package => 'DynamicFieldTicketsAttributes',
        );

        if ( !$CheckPackage && $Self->{UseDefaults} ) {
            $Self->{MissingPackages}++;
        }
        $DF{FieldType} = 'SLA';
        $DF{Config}{EditFieldMode} = 'AutoComplete';
    }
    elsif ( $Type eq 'TypeReference' ) {
        my $CheckPackage = $Self->_CheckInstalledPackage(
            %Param,
            Package => 'DynamicFieldTicketsAttributes',
        );

        if ( !$CheckPackage && $Self->{UseDefaults} ) {
            $Self->{MissingPackages}++;
        }
        $DF{FieldType} = 'Type';
        $DF{Config}{EditFieldMode} = 'AutoComplete';
    }
    elsif ( $Type eq 'TextLink' ) {
        $DF{FieldType} = 'Text';
        $DF{Config}{Link} = '[% Data.Value | url %]';
    }

    # Legacy DF type 'DynamicField' from the package CIAttributesCollection
    # This type references a generic DF whose type must be specified by the legacy attribute Name
    elsif ( $Type eq 'DynamicField' ) {
        if ( $Param{Attribute}{Input}{Name} ) {
            my $LegacyField = $DynamicFieldObject->DynamicFieldGet(
                Name => $Param{Attribute}{Input}{Name},
            );
            $DF{FieldType}              = 'Dropdown';
            $DF{Config}{MultiValue}     = ( $Param{Attribute}{CountMax} && $Param{Attribute}{CountMax} > 1 ) ? 1 : 0;
            $DF{Config}{PossibleValues} = $DynamicFieldBackendObject->PossibleValuesGet(
                DynamicFieldConfig => $LegacyField,
            );
        }
        else {
            $Self->Print("<red>Field type 'DynamicField' requires Name specification!</red>\n");

            return;
        }
    }
    else {
        $Self->Print("<red>Unknown input type '$Type'!</red>\n");

        return;
    }

    return %DF;
}

sub _ContinueOrNot {
    my ( $Self, %Param ) = @_;

    return 'Next' if $Self->{UseDefaults};

    $Self->Print(
        "<yellow>Done.\n\nYou can pause here to review and possibly alter the suggestions by inspecting and changing the files. Calling the script again later should automatically resume at the right step, you can manually enforce this by calling via:</yellow>\n"
    );
    $Self->Print( "\tbin/otobo.Console.pl Admin::ITSM::ConfigItem::UpgradeTo11 --start-at " . ( $Param{CurrentStep} + 1 ) . "\n" );
    $Self->Print(
        "\n<yellow>To finish the script now, just press enter. To directly continue with the default suggestions without review write 'def'.</yellow>\n\t"
    );

    return 'Next' if <STDIN> =~ m/^def(ault)?$/;

    return 'Exit';
}

sub _CheckInstalledPackage {
    my ( $Self, %Param ) = @_;

    my $Pass = 1;

    return $Pass if $Self->{CheckedTypes}{ $Param{Attribute}{Input}{Type} };

    $Pass = $Kernel::OM->Get('Kernel::System::Package')->PackageIsInstalled(
        Name => $Param{Package},
    );
    if ( !$Pass ) {
        my $Class        = $Param{Class};
        my $DefinitionID = $Param{DefinitionID};
        my $FieldType    = $Param{Attribute}{Input}{Type};
        my $FieldName    = $Param{Attribute}{Name};
        $Self->Print("<red>\nError converting DF (Class: $Class, DefinitionID: $DefinitionID, Field Type: $FieldType, Field Name: $FieldName). </red>");
        $Self->Print("<red>The $Param{Package} package is required.</red>\n");
    }
    $Self->{CheckedTypes}{ $Param{Attribute}{Input}{Type} } = 1;

    return $Pass;
}

sub _ResetSettings {
    my ( $Self, %Param ) = @_;

    my $SysConfigObject   = $Kernel::OM->Get('Kernel::System::SysConfig');
    my $SettingName       = $Param{SettingName};
    my $ExclusiveLockGUID = $SysConfigObject->SettingLock(
        UserID => 1,
        Force  => 1,
        Name   => $SettingName,
    );
    if ( !$ExclusiveLockGUID ) {
        $Self->Print("<red>Could not lock '$SettingName' for reset</red>\n");

        return;
    }
    my $Success = $SysConfigObject->SettingReset(
        Name              => $SettingName,
        ExclusiveLockGUID => $ExclusiveLockGUID,
        UserID            => 1,
    );
    if ( !$Success ) {
        $Self->Print("<red>Could not reset '$SettingName'</red>\n");

        return;
    }
    $Success = $SysConfigObject->SettingUnlock(
        UserID => 1,
        Name   => $SettingName,
    );
    if ( !$Success ) {
        $Self->Print("<red>Could not unlock '$SettingName'</red>\n");

        return;
    }
    my %DeploymentResult = $SysConfigObject->ConfigurationDeploy(
        Comments => "Reset $SettingName.",
        UserID   => 1,
        Force    => 1,
    );
    if ( !$DeploymentResult{Success} ) {
        $Self->Print("<red>Could not deploy reset of '$SettingName'</red>\n");

        return;
    }
    $Self->Print("<green>Successfully reset '$SettingName'.</green>\n");
    return;
}

1;

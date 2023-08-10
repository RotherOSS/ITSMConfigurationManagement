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

use strict;
use warnings;

use Kernel::System::VariableCheck qw(:all);

use parent qw(Kernel::System::Console::BaseCommand);

## nofilter(TidyAll::Plugin::OTOBO::Perl::ForeachToFor)

# Inform the object manager about the hard dependencies.
# This module must be discarded when one of the hard dependencies has been discarded.
our @ObjectDependencies = (
    'Kernel::Config',
);

sub Configure {
    my ( $Self, %Param ) = @_;

    $Self->Description('Upgrade the complete CMDB from OTOBO 10 to OTOBO 11. All config item definitions will be changed, for each config item attribute a dynamic field will be prepared and the data will be migrated.');
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

    my %Sub = (
        'Prepare Attribute Mapping' => \&_PrepareAttributeMapping,
#        'Prepare DynamicFields'     => \&_PrepareDynamicFieldConfigs,
        'Prepare Definitions'       => \&_PrepareDefinitions,
        'Migrate Definitions'       => \&_MigrateDefinitions,
        'Migrate Attribute Data'    => \&_MigrateAttributeData,
        'Delete Legacy Data'        => \&_DeleteLegacyData,
    );

    $Self->{WorkingDir}  = $Self->GetOption('tmpdir') || 'var/tmp/CMDBUpgradeTo11Schemata';
    $Self->{UseDefaults} = $Self->GetOption('use-defaults');
    my $StartAt          = $Self->GetOption('start-at') // $Self->_GetCurrentStep();

    if ( $StartAt ) {
        $Self->Print("<yellow>Continue CMDB upgrade at: '$Steps[ $StartAt ]'!</yellow>\n");
    }
    else {
        $Self->Print("<yellow>Starting CMDB upgrade!</yellow>\n");
    }

    $Self->{GeneralCatalogObject} = $Kernel::OM->Get('Kernel::System::GeneralCatalog');
    $Self->{ConfigItemObject}     = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');

    $Self->{ClassList} = $Self->{GeneralCatalogObject}->ItemList(
        Class => 'ITSM::ConfigItem::Class',
    );

    for my $ClassID ( keys $Self->{ClassList}->%* ) {
        $Self->{DefinitionList}{ $ClassID } = $Self->{ConfigItemObject}->DefinitionList(
            ClassID => $ClassID,
        );
    }

    my $Success;
    STEP:
    for my $i ( $StartAt .. $#Steps ) {
        $Success = $Sub{ $Steps[ $i ] }->(
            $Self,
            CurrentStep => $i,
        );

        last STEP if !$Success;
        last STEP if $Success ne 'Next';
    }

    if ( $Success ) {
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

    $Self->Print("<yellow>Writing attribute maps.</yellow>\n");

    for my $ClassID ( keys $Self->{ClassList}->%* ) {
        my %Attributes;

        for my $Definition ( $Self->{DefinitionList}{ $ClassID }->@* ) {
            my @CurAttributes = $Self->_GetAttributesFromLegacyYAML(
                Definition => $Definition,
                Subs       => 1,
            );

            %Attributes = (
                %Attributes,
                map { $_->{Key} => 1 } @CurAttributes,
            );
        }

        for my $Key ( keys %Attributes ) {
            my $DFName = $Key =~ s/[^\w\d]//gr;

            # write file
        }
    }

    return $Self->_ContinueOrNot( CurrentStep => $Param{CurrentStep} );
}

sub _PrepareDefinitions {
    my ( $Self, %Param ) = @_;

    $Self->Print("<yellow>Writing class definitions.</yellow>\n");


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

    $Self->Print("<yellow>Optionally all legacy data can be deleted. This step is not necessary for the migrated CMDB to work and can be done at any later time.</yellow>\n");
    $Self->Print("\n<red>Do you really want to permanently delete all legacy data from the system? (yes/no)</red>\n");

    return 'Next';
}

sub _GetAttributesFromLegacyYAML {
    my ( $Self, %Param ) = @_;

    my @Attributes;
    my $DefinitionRef = $Param{DefinitionRef} // $Kernel::OM->Get('Kernel::System::YAML')->Load(
        Data => $Param{Definition},
    );

    if ( ref $DefinitionRef ne 'ARRAY' ) {
        $Self->Print("<red>Need a valid legacy definition!</red>\n");

        die;
    }

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

    $Self->Print("<yellow>You can pause here to review and possibly alter the suggestions by inspecting and changing the files. Calling the script again later should automatically resume at the right step, you can manually enforce this by calling via:</yellow>\n");
    $Self->Print("\tbin/otobo.Console.pl Admin::ITSM::ConfigItem::UpgradeTo11 --start-at ". $Param{CurrentStep} + 1 ."\n");
    $Self->Print("\n<yellow>To exit the script now, just press enter. To directly continue with the default suggestions without review write 'def'.</yellow>\n");

    return 'Next' if <STDIN> =~ /^def(ault)?$/;

    return 'Exit';
}

1;

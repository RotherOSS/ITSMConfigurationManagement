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

    my $Success;
    STEP:
    for my $i ( $StartAt .. $#Steps ) {
        $Success = $Sub{ $Steps[ $i ] }->( $Self );

        last STEP if !$Success;
        last STEP if $Success ne 'Next';
    }

    return $Self->ExitCodeOk();
}

sub _GetCurrentStep {
    my ( $Self, %Param ) = @_;

    return 0;
}

sub _PrepareAttributeMapping {
    my ( $Self, %Param ) = @_;

    $Self->Print("<yellow>Writing attribute maps.</yellow>\n");

    return 'Next';
}

sub _PrepareDefinitions {
    my ( $Self, %Param ) = @_;

    $Self->Print("<yellow>Writing class definitions.</yellow>\n");

    return 'Next';
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
    $Self->Print("<red>Do you really want to permanently delete all legacy data from the system? (yes/no)</red>\n");

    return 'Next';
}

1;

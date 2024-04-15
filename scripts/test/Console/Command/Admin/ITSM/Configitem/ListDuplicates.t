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

use strict;
use warnings;
use utf8;

use Kernel::System::UnitTest::RegisterDriver;    # Set up $Kernel::OM and the test driver $Self

our $Self;

# get command object
my $CommandObject = $Kernel::OM->Get('Kernel::System::Console::Command::Admin::ITSM::Configitem::ListDuplicates');

# get helper object
$Kernel::OM->ObjectParamAdd(
    'Kernel::System::UnitTest::Helper' => {
        RestoreDatabase => 1,
    },
);
my $Helper = $Kernel::OM->Get('Kernel::System::UnitTest::Helper');

# check command without any options
my $ExitCode = $CommandObject->Execute();

$Self->Is(
    $ExitCode,
    0,
    "No options - list all config items in productive states",
);

# check command with --class options (invalid class)
my $RandomClass = 'NonExistingClass' . $Helper->GetRandomID();
$ExitCode = $CommandObject->Execute( '--class', $RandomClass );

$Self->Is(
    $ExitCode,
    1,
    "Option 'class' (but class $RandomClass doesn't exist) ",
);

# add test config item
my $GeneralCatalogObject = $Kernel::OM->Get('Kernel::System::GeneralCatalog');

# get 'Hardware' catalog class IDs
my $ConfigItemDataRef = $GeneralCatalogObject->ItemGet(
    Class => 'ITSM::ConfigItem::Class',
    Name  => 'Hardware',
);
my $HardwareConfigItemID = $ConfigItemDataRef->{ItemID};

# get 'Production' deployment state IDs
my $ProductionDeplStateDataRef = $GeneralCatalogObject->ItemGet(
    Class => 'ITSM::ConfigItem::DeploymentState',
    Name  => 'Production',
);
my $ProductionDeplStateID = $ProductionDeplStateDataRef->{ItemID};

# get ConfigItem object
my $ConfigItemObject = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');

# create ConfigItem number
my $ConfigItemNumber = $ConfigItemObject->ConfigItemNumberCreate(
    Type    => 'Kernel::System::ITSMConfigItem::Number::AutoIncrement',
    ClassID => $HardwareConfigItemID,
);

my $ConfigItemName = 'TestConfigItem' . $Helper->GetRandomID();

my @ConfigItemID;

# add the new ConfigItem
my $ConfigItemID = $ConfigItemObject->ConfigItemAdd(
    Number      => $ConfigItemNumber,
    Name        => $ConfigItemName,
    ClassID     => $HardwareConfigItemID,
    DeplStateID => $ProductionDeplStateID,
    InciStateID => 1,
    UserID      => 1,
);
push @ConfigItemID, $ConfigItemID;

# add the new duplicate ConfigItem
$ConfigItemID = $ConfigItemObject->ConfigItemAdd(
    Name        => $ConfigItemName,
    ClassID     => $HardwareConfigItemID,
    DeplStateID => $ProductionDeplStateID,
    InciStateID => 1,
    UserID      => 1,
);
push @ConfigItemID, $ConfigItemID;

# add the new duplicate ConfigItem in Software catalog class
# get 'Software' catalog class IDs
$ConfigItemDataRef = $GeneralCatalogObject->ItemGet(
    Class => 'ITSM::ConfigItem::Class',
    Name  => 'Software',
);
my $SoftwareConfigItemID = $ConfigItemDataRef->{ItemID};

$ConfigItemID = $ConfigItemObject->ConfigItemAdd(
    Name        => $ConfigItemName,
    ClassID     => $SoftwareConfigItemID,
    DeplStateID => $ProductionDeplStateID,
    InciStateID => 1,
    UserID      => 1,
);
push @ConfigItemID, $ConfigItemID;

# check command with --class Hardware options
$ExitCode = $CommandObject->Execute( '--class', "Hardware" );

$Self->Is(
    $ExitCode,
    0,
    "Option 'class' (Hardware) ",
);

# check command with --scope options (invalid scope)
my $RandomScope = 'scope' . $Helper->GetRandomID();
$ExitCode = $CommandObject->Execute( '--scope', $RandomScope );

$Self->Is(
    $ExitCode,
    1,
    "Option 'scope' (but provided invalid value for option '--scope' - $RandomScope ) ",
);

# check command with --scope class options
$ExitCode = $CommandObject->Execute( '--scope', 'class' );

$Self->Is(
    $ExitCode,
    0,
    "Option 'scope' (class) ",
);

# check command with --scope global options
$ExitCode = $CommandObject->Execute( '--scope', 'global' );

$Self->Is(
    $ExitCode,
    0,
    "Option 'scope' (global) ",
);

# check command with --all-states options
$ExitCode = $CommandObject->Execute('--all-states');

$Self->Is(
    $ExitCode,
    0,
    "Option 'scope' (all-states) ",
);

# cleanup is done by RestoreDatabse

$Self->DoneTesting;

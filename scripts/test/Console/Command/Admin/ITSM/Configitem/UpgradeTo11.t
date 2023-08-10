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

use v5.24;
use strict;
use warnings;
use utf8;

# core modules

# CPAN modules
use Test2::V0;

# OTOBO modules
use Kernel::System::UnitTest::RegisterOM;    # Set up $Kernel::OM

my $CommandObject = $Kernel::OM->Get('Kernel::System::Console::Command::Admin::ITSM::Configitem::UpgradeTo11');

# get helper object, database changes should be restored
$Kernel::OM->ObjectParamAdd(
    'Kernel::System::UnitTest::Helper' => {
        RestoreDatabase => 1,
    },
);
my $Helper = $Kernel::OM->Get('Kernel::System::UnitTest::Helper');

my $ExitCode = $CommandObject->Execute;
is(
    $ExitCode,
    1,
    "Admin::ITSM::Configitem::UpgradeTo11 exit code without options",
);

my $DBObject = $Kernel::OM->Get('Kernel::System::DB');

# Setup of test data, which conforms to the OTOBO 10.1 format
{
    # The names of the config item classes are kept in the general catalog.
    # Let's add classes with names that have the prefix 'TestUpgrade',
    # Try to now meddle with existing data.
    my $GeneralCatalogClass = 'ITSM::ConfigItem::Class';
    my $ValidID             = 1;
    my @Names               = map { join '_', 'TestUpgrade', $_ } qw(Computer Hardware Location Netword Software);
    $DBObject->DoArray(
        SQL => <<'END_SQL',
INSERT INTO general_catalog ( general_catalog_class, name, valid_id, create_time, create_by, change_time, change_by )
  VALUES (?, ?, ?, current_timestamp, 1, current_timestamp, 1)
END_SQL
        Bind => [ $GeneralCatalogClass, \@Names, $ValidID ],
    );

    my %Name2ID = $DBObject->SelectMapping(
        SQL => 'SELECT name, id FROM general_catalog WHERE name LIKE "TestUpgrade_%"',
    );
    my %ExpectedName2OD = map { $_ => match(qr/[0-9]+/) } @Names;
    is( \%Name2ID, \%ExpectedName2OD, 'config item names were inserted' );
}

done_testing;

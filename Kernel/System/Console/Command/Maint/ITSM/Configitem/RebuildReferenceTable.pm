# --
# OTOBO is a web-based ticketing system for service organisations.
# --
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

package Kernel::System::Console::Command::Maint::ITSM::Configitem::RebuildReferenceTable;

use v5.24;
use strict;
use warnings;
use namespace::autoclean;
use utf8;

# core modules

# CPAN modules

# OTOBO modules

use parent qw(Kernel::System::Console::BaseCommand);

our @ObjectDependencies = qw(
    Kernel::System::DB
    Kernel::System::DynamicField
    Kernel::System::ITSMConfigItem
);

sub Configure {
    my ( $Self, %Param ) = @_;

    $Self->Description(<<'END_TXT');
Rebuild the table configitem_reference from the Reference dynamic fields. Only the fields linking config items are
considered here.
END_TXT

    return;
}

sub Run {
    my ( $Self, %Param ) = @_;

    $Self->Print("<yellow>Rebuilding the table configitem_reference...</yellow>\n\n");

    my $ConfigItemObject = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');
    my $Result           = $ConfigItemObject->RebuildReferenceTable;

    $Self->Print("<$Result->{Color}>$Result->{Message}</$Result->{Color}>\n\n");

    return $Self->ExitCodeError unless $Result->{Success};
    return $Self->ExitCodeOk;
}

1;

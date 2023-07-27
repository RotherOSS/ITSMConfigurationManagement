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

package Kernel::System::ITSMConfigItem::Event::ReferenceSync;

use v5.24;
use strict;
use warnings;
use namespace::autoclean;
use utf8;

# core modules

# CPAN modules

# OTOBO modules

our @ObjectDependencies = (
    'Kernel::System::ITSMConfigItem',
    'Kernel::System::Log',
);

=head1 NAME

Kernel::System::ITSMConfigItem::Event::ReferenceSync - Event handler keeps a lookup table for References

=head1 PUBLIC INTERFACE

=head2 new()

create an object

    use Kernel::System::ObjectManager;

    local $Kernel::OM = Kernel::System::ObjectManager->new();
    my $HandlerObject = $Kernel::OM->Get('Kernel::System::ITSMConfigItem::Event::ReferenceSync');

=cut

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    return bless {}, $Type;
}

# TODO: add complete Data hash to POD

=head2 Run()

This method handles the event.

    $DoHistoryObject->Run(
        Event => 'ConfigItemDynamicFieldUpdate_MyNiceReference',
        Data  => {
            Comment      => 'new value: 1',
            ConfigItemID => 123,
        },
        UserID => 1,
    );

=cut

sub Run {
    my ( $Self, %Param ) = @_;

    # as DefinitionCreate does not belong to an item, we don't create
    # a history entry
    if ( $Param{Event} && $Param{Event} eq 'DefinitionCreate' ) {
        return;
    }

    # check needed stuff
    for my $Missing ( grep { !$Param{$_} } qw(Data Event UserID) ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "Need $Missing!",
        );

        return;
    }

    # This event module only cares about initial assignments, udates and deletes of dynamic fields.
    # Everything als will be graciously ignored.
    return 1 unless $Param{Event} =~ m/^ConfigItemDynamicFieldUpdate_/;

    my $ConfigItemObject = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');

    # TODO: actually update configitem_reference
    my $Success = 1;

    return unless $Success;
    return 1;
}

1;

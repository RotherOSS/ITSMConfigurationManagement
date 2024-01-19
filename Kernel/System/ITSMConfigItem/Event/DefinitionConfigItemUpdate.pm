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

package Kernel::System::ITSMConfigItem::Event::DefinitionConfigItemUpdate;

use v5.24;
use strict;
use warnings;
use namespace::autoclean;
use utf8;

# core modules

# CPAN modules

# OTOBO modules

our @ObjectDependencies = (
    'Kernel::System::DB',
    'Kernel::System::Log',
);

=head1 NAME

Kernel::System::ITSMConfigItem::Event::DefinitionConfigItemUpdate - Event handler that updates config items on definition changes

=head1 PUBLIC INTERFACE

=head2 new()

create an object

    use Kernel::System::ObjectManager;

    local $Kernel::OM = Kernel::System::ObjectManager->new();
    my $EventObject = $Kernel::OM->Get('Kernel::System::ITSMConfigItem::Event::DefinitionConfigItemUpdate');

=cut

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    return bless {}, $Type;
}

=head2 Run()

This method handles the event.

    $EventObject->Run(
        Event => 'DefinitionCreate',
        Data  => {
            DefinitionID => $DefinitionID,
            ClassID      => $Param{ClassID},
        },
        UserID => 1,
    );

=cut

sub Run {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Needed (qw(Data Event UserID)) {
        if ( !$Param{$Needed} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Needed!",
            );
            return;
        }
    }

    return if $Param{Event} ne 'DefinitionCreate';

    # check needed stuff
    for my $Needed (qw(DefinitionID ClassID)) {
        if ( !$Param{Data}{$Needed} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Needed in Data!",
            );
            return;
        }
    }

    # TODO: Consider using ConfigItemUpdate() for history entries in CIs, and also allowing Definition updates trigger VersionAdd instead of updating them
    #           make this configurable though, as it will be more computationally expensive

    return $Kernel::OM->Get('Kernel::System::DB')->Do(
        SQL  => 'UPDATE configitem_version v INNER JOIN configitem ci ON v.id = ci.last_version_id SET v.definition_id = ? WHERE ci.class_id = ?',
        Bind => [ \$Param{Data}{DefinitionID}, \$Param{Data}{ClassID} ],
    );
}

1;

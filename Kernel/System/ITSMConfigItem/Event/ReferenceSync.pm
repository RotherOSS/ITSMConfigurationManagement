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

our @ObjectDependencies = qw(
    Kernel::System::DynamicField
    Kernel::System::ITSMConfigItem
    Kernel::System::Log
);

=head1 NAME

Kernel::System::ITSMConfigItem::Event::ReferenceSync - Event handler that maintains a lookup table for Reference dynamic fields

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

=head2 Run()

This method handles the event.

    $HandlerObject->Run(
        Config      => {
            Event => "^ConfigItemDynamicFieldUpdate_",
            Module => "Kernel::System::ITSMConfigItem::Event::ReferenceSync",
            Transaction => 1,
        },
        Data        => {
            ConfigItemID        => 10,
            ConfigItemVersionID => 20,
            FieldName           => "ReferenceToComputer",
            OldValue            => undef,
            ReadableOldValue    => "",
            ReadableValue       => 7,
            UserID              => 3,
            Value               => 7,
        },
        Event       => "ConfigItemDynamicFieldUpdate_StoneCheckbox",
        Transaction => 1,
        UserID      => 3,
    );

=cut

sub Run {
    my ( $Self, %Param ) = @_;

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

    # This event module care only about Reference dynamic fields.
    return 1 unless $Param{Data}->{FieldName};

    my $DynamicFieldObject = $Kernel::OM->Get('Kernel::System::DynamicField');
    my $DynamicField       = $DynamicFieldObject->DynamicFieldGet(
        Name => $Param{Data}->{FieldName},
    );

    return 1 unless $DynamicField;
    return 1 unless $DynamicField->{FieldType};
    return 1 unless $DynamicField->{FieldType} eq 'Reference';

    # This event module care only about references to other config items
    return 1 unless $DynamicField->{Config};
    return 1 unless $DynamicField->{Config}->{ReferencedObjectType};
    return 1 unless $DynamicField->{Config}->{ReferencedObjectType} =~ m/^ITSMConfigItem/;

    # actually update configitem_reference
    my $ConfigItemObject = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');

    return $ConfigItemObject->SyncReferenceTable(
        DynamicField              => $DynamicField,
        SourceConfigItemID        => $Param{Data}->{ConfigItemID},          # currently not used
        SourceConfigItemVersionID => $Param{Data}->{ConfigItemVersionID},
        OldValue                  => $Param{Data}->{OldValue},
        Value                     => $Param{Data}->{Value},
    );
}

1;

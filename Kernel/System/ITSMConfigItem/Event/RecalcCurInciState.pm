# --
# OTOBO is a web-based ticketing system for service organisations.
# --
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

package Kernel::System::ITSMConfigItem::Event::RecalcCurInciState;

use v5.24;
use strict;
use warnings;
use namespace::autoclean;
use utf8;

use parent qw(Kernel::System::AsynchronousExecutor);

# core modules

# CPAN modules

# OTOBO modules

our @ObjectDependencies = (
    'Kernel::System::DynamicField',
    'Kernel::System::ITSMConfigItem',
    'Kernel::System::Log',
);

=head1 NAME

Kernel::System::ITSMConfigItem::Event::RecalcCurInciState - Event handler that recalculates incident states from Reference dynamic fields

=head1 PUBLIC INTERFACE

=head2 new()

create an object

    use Kernel::System::ObjectManager;

    local $Kernel::OM = Kernel::System::ObjectManager->new();
    my $HandlerObject = $Kernel::OM->Get('Kernel::System::ITSMConfigItem::Event::RecalcCurInciState');

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
            Module => "Kernel::System::ITSMConfigItem::Event::RecalcCurInciState",
            Transaction => 1,
        },
        Data        => {
            ConfigItemID            => 10,
            ConfigItemVersionID     => 20,
            ConfigItemLastVersionID => 21,
            FieldName               => "ReferenceToComputer",
            OldValue                => undef,
            ReadableOldValue        => "",
            ReadableValue           => 7,
            UserID                  => 3,
            Value                   => 7,
        },
        Event       => "ConfigItemDynamicFieldUpdate_ReferenceToComputer",
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
    my $DynamicFieldConfig = $DynamicFieldObject->DynamicFieldGet(
        Name => $Param{Data}->{FieldName},
    );

    # only references to config items are relevant
    return 1 unless $DynamicFieldConfig;
    return 1 unless $DynamicFieldConfig->{FieldType};
    return 1 unless $DynamicFieldConfig->{FieldType} eq 'ConfigItem';

    my $DFDetails = $DynamicFieldConfig->{Config};

    # This event module care only about references to other config items
    # that are marked as links.
    return 1 unless $DFDetails;
    return 1 unless $DFDetails->{LinkType};

    # find the relevant config items and call CurInciStateRecalc()

    # sometimes only the setting of the most recent version is relevant
    # The default is Dynamic linking
    my $LinkIsDynamic = 0;
    $DFDetails->{LinkReferencingType} //= 'Dynamic';
    if ( $DFDetails->{LinkReferencingType} eq '' || $DFDetails->{LinkReferencingType} eq 'Dynamic' ) {
        return 1 unless $Param{Data}->{ConfigItemVersionID} == $Param{Data}->{ConfigItemLastVersionID};

        $LinkIsDynamic = 1;
    }

    # The incident state is recalculated only when both sides are config items, not config item versions
    return 1 unless $LinkIsDynamic;

    my $ConfigItemObject = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');

    my %ConfigItemIDs;

    ID:
    for my $ID ( ( $Param{Data}->{OldValue} // [] )->@* ) {
        next ID if !$ID;

        $ConfigItemIDs{$ID} = 1;
    }

    for my $ID ( ( $Param{Data}->{Value} // [] )->@* ) {
        next ID if !$ID;

        if ( $ConfigItemIDs{$ID} ) {
            delete $ConfigItemIDs{$ID};
        }
        else {
            $ConfigItemIDs{$ID} = 1;
        }
    }

    return 1 unless %ConfigItemIDs;

    $ConfigItemIDs{ $Param{Data}->{ConfigItemID} } = 1;

    # handle incident state recalc an asynchronous call
    return $Self->AsyncCall(
        ObjectName     => 'Kernel::System::ITSMConfigItem',
        FunctionName   => 'CurInciStateRecalc',
        FunctionParams => {
            ConfigItemIDs => [ sort keys %ConfigItemIDs ],
        },
        MaximumParallelInstances => 1,
    );
}

1;

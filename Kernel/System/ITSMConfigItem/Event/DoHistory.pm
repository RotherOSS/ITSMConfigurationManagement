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

package Kernel::System::ITSMConfigItem::Event::DoHistory;

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

Kernel::System::ITSMConfigItem::Event::DoHistory - Event handler that records the history

=head1 PUBLIC INTERFACE

=head2 new()

create an object

    use Kernel::System::ObjectManager;

    local $Kernel::OM = Kernel::System::ObjectManager->new();
    my $DoHistoryObject = $Kernel::OM->Get('Kernel::System::ITSMConfigItem::Event::DoHistory');

=cut

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    return bless {}, $Type;
}

=head2 Run()

This method handles the event.

    $DoHistoryObject->Run(
        Event => 'ConfigItemCreate',
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
    for my $Needed (qw(Data Event UserID)) {
        if ( !$Param{$Needed} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Needed!",
            );
            return;
        }
    }

    # check for dynamic fields first, most events will be this,
    # ReadableValue and ReadableOldValue are expected to the strings
    if ( $Param{Event} =~ m/^ConfigItemDynamicFieldUpdate_/ ) {
        return $Self->_HistoryAdd(
            ConfigItemID => $Param{Data}{ConfigItemID},
            HistoryType  => 'ValueUpdate',
            Comment      => "$Param{Data}{FieldName}%%$Param{Data}{ReadableOldValue}%%$Param{Data}{ReadableValue}",
            UserID       => $Param{UserID},
        );
    }

    # due to consistency with ticket history, we need HistoryType
    $Param{HistoryType} = $Param{Event};

    # dispatch table for all events
    my %Dispatcher = (
        ConfigItemCreate      => \&_HistoryAdd,
        ConfigItemDelete      => \&_ConfigItemDelete,
        LinkAdd               => \&_HistoryAdd,
        LinkDelete            => \&_HistoryAdd,
        NameUpdate            => \&_HistoryAdd,
        IncidentStateUpdate   => \&_HistoryAdd,
        DeploymentStateUpdate => \&_HistoryAdd,
        DefinitionUpdate      => \&_HistoryAdd,
        VersionCreate         => \&_HistoryAdd,
        VersionUpdate         => \&_HistoryAdd,
        DefinitionCreate      => \&_HistoryAdd,
        VersionDelete         => \&_HistoryAdd,
        AttachmentAddPost     => \&_HistoryAdd,
        AttachmentDeletePost  => \&_HistoryAdd,
    );

    # error handling
    if ( !exists $Dispatcher{ $Param{Event} } ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => 'non existant history type: ' . $Param{Event},
        );

        return;
    }

    # call callback
    my $Sub = $Dispatcher{ $Param{Event} };
    $Self->$Sub(
        %Param,
        %{ $Param{Data} },
    );

    return 1;
}

=head1 INTERNAL INTERFACE

=head2 _ConfigItemDelete()

history's event handler for ConfigItemDelete

=cut

sub _ConfigItemDelete {
    my ( $Self, %Param ) = @_;

    # delete history
    $Kernel::OM->Get('Kernel::System::ITSMConfigItem')->HistoryDelete(
        ConfigItemID => $Param{ConfigItemID},
    );

    return 1;
}

=head2 _HistoryAdd()

history's default event handler.

=cut

sub _HistoryAdd {
    my ( $Self, %Param ) = @_;

    # add history entry
    $Kernel::OM->Get('Kernel::System::ITSMConfigItem')->HistoryAdd(
        %Param,
    );

    return 1;
}

1;

=head1 TERMS AND CONDITIONS

This software is part of the OTOBO project (L<https://otobo.org/>).

This software comes with ABSOLUTELY NO WARRANTY. For details, see
the enclosed file COPYING for license information (GPL). If you
did not receive this file, see L<https://www.gnu.org/licenses/gpl-3.0.txt>.

=cut

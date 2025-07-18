# --
# OTOBO is a web-based ticketing system for service organisations.
# --
# Copyright (C) 2001-2020 OTRS AG, https://otrs.com/
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

package Kernel::System::ITSMConfigItem::Number;

use strict;
use warnings;

our $ObjectManagerDisabled = 1;

=head1 NAME

Kernel::System::ITSMConfigItem::Number - sub module of Kernel::System::ITSMConfigItem

=head1 DESCRIPTION

All config item number functions.

=head1 PUBLIC INTERFACE

=head2 ConfigItemNumberLookup()

return config item id or config item number

    my $ConfigItemNumber = $ConfigItemObject->ConfigItemNumberLookup(
        ConfigItemID => 123,
    );

    or

    my $ConfigItemID = $ConfigItemObject->ConfigItemNumberLookup(
        ConfigItemNumber => '123454321',
    );

=cut

sub ConfigItemNumberLookup {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    if ( !$Param{ConfigItemID} && !$Param{ConfigItemNumber} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => 'Need ConfigItemID or ConfigItemNumber!',
        );
        return;
    }

    if ( $Param{ConfigItemID} ) {

        # check if result is already cached
        return $Self->{Cache}->{ConfigItemNumberLookup}->{ID}->{ $Param{ConfigItemID} }
            if $Self->{Cache}->{ConfigItemNumberLookup}->{ID}->{ $Param{ConfigItemID} };

        # ask database
        $Kernel::OM->Get('Kernel::System::DB')->Prepare(
            SQL   => 'SELECT configitem_number FROM configitem WHERE id = ?',
            Bind  => [ \$Param{ConfigItemID} ],
            Limit => 1,
        );

        # fetch the result
        my $ConfigItemNumber;
        while ( my @Row = $Kernel::OM->Get('Kernel::System::DB')->FetchrowArray() ) {
            $ConfigItemNumber = $Row[0];
        }

        # cache the result
        $Self->{Cache}->{ConfigItemNumberLookup}->{ID}->{ $Param{ConfigItemID} } = $ConfigItemNumber;

        return $ConfigItemNumber;
    }

    # check if result is already cached
    return $Self->{Cache}->{ConfigItemNumberLookup}->{Number}->{ $Param{ConfigItemNumber} }
        if $Self->{Cache}->{ConfigItemNumberLookup}->{Number}->{ $Param{ConfigItemNumber} };

    # ask database
    $Kernel::OM->Get('Kernel::System::DB')->Prepare(
        SQL   => 'SELECT id FROM configitem WHERE configitem_number = ?',
        Bind  => [ \$Param{ConfigItemNumber} ],
        Limit => 1,
    );

    # fetch the result
    my $ConfigItemID;
    while ( my @Row = $Kernel::OM->Get('Kernel::System::DB')->FetchrowArray() ) {
        $ConfigItemID = $Row[0];
    }

    # cache the result
    $Self->{Cache}->{ConfigItemNumberLookup}->{Number}->{ $Param{ConfigItemNumber} } = $ConfigItemID;

    return $ConfigItemID;
}

=head2 ConfigItemNumberCreate()

create a new config item number

    my $Number = $ConfigItemObject->ConfigItemNumberCreate(
        Type    => 'AutoIncrement',
        ClassID => 123,
    );

=cut

sub ConfigItemNumberCreate {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Argument (qw(Type ClassID)) {
        if ( !$Param{$Argument} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Argument!",
            );
            return;
        }
    }

    # load backend
    if ( !$Kernel::OM->Get('Kernel::System::Main')->Require( $Param{Type} ) ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "Can't load config item number generator backend module $Param{Type}! $@",
        );
        return;
    }

    # load backend
    return if !$Kernel::OM->Get('Kernel::System::Main')->RequireBaseClass( $Param{Type} );

    # create number
    my $Number = $Self->_ConfigItemNumberCreate(%Param);

    return $Number;
}

=head2 CurrentCounterGet()

return the current counter of a class

    my $Counter = $ConfigItemObject->CurrentCounterGet(
        ClassID => 123,
        Type    => 'AutoIncrement',
    );

=cut

sub CurrentCounterGet {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Argument (qw(ClassID Type)) {
        if ( !$Param{$Argument} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Argument!",
            );
            return;
        }
    }

    # ask the database
    $Kernel::OM->Get('Kernel::System::DB')->Prepare(
        SQL => 'SELECT counter FROM configitem_counter WHERE '
            . 'class_id = ? AND counter_type = ?',
        Bind  => [ \$Param{ClassID}, \$Param{Type} ],
        Limit => 1,
    );

    # fetch the result
    my $Number;
    while ( my @Row = $Kernel::OM->Get('Kernel::System::DB')->FetchrowArray() ) {
        $Number = $Row[0];
    }

    return $Number;
}

=head2 CurrentCounterSet()

set the current counter of a class

    my $True = $ConfigItemObject->CurrentCounterSet(
        ClassID => 123,
        Type    => 'AutoIncrement',
        Counter => '12',
    );

=cut

sub CurrentCounterSet {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Argument (qw(ClassID Type Counter)) {
        if ( !$Param{$Argument} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Argument!",
            );
            return;
        }
    }

    # delete old counter
    $Kernel::OM->Get('Kernel::System::DB')->Do(
        SQL  => 'DELETE FROM configitem_counter WHERE class_id = ?',
        Bind => [ \$Param{ClassID} ],
    );

    # set new counter
    $Kernel::OM->Get('Kernel::System::DB')->Do(
        SQL => 'INSERT INTO configitem_counter '
            . '(class_id, counter_type, counter) VALUES (?, ?, ?)',
        Bind => [ \$Param{ClassID}, \$Param{Type}, \$Param{Counter} ],
    );

    return 1;
}

1;

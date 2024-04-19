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

package Kernel::System::ITSMConfigItem::Permission::ClassGroupCheck;

use strict;
use warnings;

our @ObjectDependencies = (
    'Kernel::System::GeneralCatalog',
    'Kernel::System::Group',
    'Kernel::System::Log',
);

=head1 NAME

Kernel::System::ITSMConfigItem::Permission::ClassGroupCheck - check if a user belongs to a group
=head1 DESCRIPTION

This is a permission module to check the group responsible for a class.

=head1 PUBLIC INTERFACE

=head2 new()

create an object

    use Kernel::System::ObjectManager;

    local $Kernel::OM = Kernel::System::ObjectManager->new();
    my $CheckObject = $Kernel::OM->Get('Kernel::System::ITSMConfigItem::Permission::ClassGroupCheck');

=cut

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {};
    bless( $Self, $Type );

    return $Self;
}

=head2 Run()

this method does the check if the use belongs to a given group

    my $HasAccess = $CheckObject->Run(
        UserID  => 123,
        Type    => 'ro',
        ClassID => 'ITSM::ConfigItem::Class::Computer',
    );

=cut

sub Run {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Needed (qw(UserID Type ClassID)) {
        if ( !$Param{$Needed} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Needed!",
            );
            return;
        }
    }

    # get data for the relevant config item class
    my $ClassItem = $Kernel::OM->Get('Kernel::System::GeneralCatalog')->ItemGet(
        ItemID => $Param{ClassID},
    );

    return unless $ClassItem->{Permission};
    my ($ClassItemPermission) = $ClassItem->{Permission}->@*;
    return unless $ClassItemPermission;

    # get user groups
    my @GroupIDs = $Kernel::OM->Get('Kernel::System::Group')->GroupMemberList(
        UserID => $Param{UserID},
        Type   => $Param{Type},
        Result => 'ID',
        Cached => 1,
    );

    # looking for group id, grant access if user is in group
    for my $GroupID (@GroupIDs) {
        return 1 if $ClassItemPermission && $GroupID eq $ClassItemPermission;
    }

    # refuse access per default
    return;
}

1;

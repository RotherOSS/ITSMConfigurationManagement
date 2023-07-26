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

package Kernel::System::DynamicField::Driver::Reference::ITSMConfigItemVersion;

use v5.24;
use strict;
use warnings;
use namespace::autoclean;
use utf8;

use parent qw(Kernel::System::DynamicField::Driver::Reference::ITSMConfigItem);

# core modules

# CPAN modules

# OTOBO modules

our @ObjectDependencies = (
    'Kernel::Config',
    'Kernel::System::Log',
    'Kernel::System::ITSMConfigItem',
);

=head1 NAME

Kernel::System::DynamicField::Driver::Reference::ITSMConfigItemVersion - backend for the Reference dynamic field

=head1 DESCRIPTION

ITSMConfigItemVersion backend for the Reference dynamic field.

=head1 PUBLIC INTERFACE



=head2 ObjectDescriptionGet()

return a hash of object descriptions.

    my %Description = $PluginObject->ObjectDescriptionGet(
        Key     => 123,
        UserID  => 1,
    );

Return

    %Description = (
        Normal => "CI# 1234455",
        Long   => "CI# 1234455: Need a sample config item title",
    );

=cut

sub ObjectDescriptionGet {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Argument (qw(ObjectID UserID)) {
        if ( !$Param{$Argument} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Argument!",
            );

            return;
        }
    }

    my $ConfigItem = $Kernel::OM->Get('Kernel::System::ITSMConfigItem')->ConfigItemGet(
        VersionID => $Param{ObjectID},
    );

    return unless $ConfigItem;

    # create description
    return (
        # TODO: take attribute from DF-Config
        Normal => $ConfigItem->{Number},

        # TODO: necessary?
        # TODO: add version information?
        Long => "$ConfigItem->{Number}: $ConfigItem->{Name}",
    );
}

=head2 SearchObjects()

This is used in auto completion when searching for possible object IDs.

=cut

sub SearchObjects {
    my ( $Self, %Param ) = @_;

    # get a list of config item IDs
    # TODO: this only searches the latest versions
    my @ConfigItemIDs = $Self->SUPER::SearchObjects(
        %Param,
    );

    # actually store latest version ID
    my @VersionIDs;
    my $ConfigItemObject = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');
    for my $ConfigItemID (@ConfigItemIDs) {
        my $ConfigItem = $ConfigItemObject->ConfigItemGet(
            ConfigItemID => $ConfigItemID,
        );

        push @VersionIDs, $ConfigItem->{VersionID};
    }

    return @VersionIDs;
}

1;

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

package Kernel::Output::HTML::ITSMConfigItem::MenuGeneric;

use v5.24;
use strict;
use warnings;
use namespace::autoclean;
use utf8;

use parent('Kernel::Output::HTML::Base');

our @ObjectDependencies = (
    'Kernel::Config',
    'Kernel::Language',
    'Kernel::Output::HTML::Layout',
    'Kernel::System::Log',
    'Kernel::System::Group',
);

sub Run {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    if ( !$Param{ConfigItem} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => 'Need ConfigItem!',
        );

        return;
    }

    # grant access by default
    my $Access = 1;

    # get action
    my $Action = $Param{Config}->{Action};
    if ( $Action eq 'AgentLinkObject' ) {

        # The Link-link is a special case, as it is not specific to ITSMConfigItem.
        # As a workaround we hardcode that AgentLinkObject is treated like AgentITSMConfigItemEdit
        $Action = 'AgentITSMConfigItemEdit';
    }

    # get config object
    my $ConfigObject = $Kernel::OM->Get('Kernel::Config');

    # get groups
    my $GroupsRo = $ConfigObject->Get('Frontend::Module')->{$Action}->{GroupRo} || [];
    my $GroupsRw = $ConfigObject->Get('Frontend::Module')->{$Action}->{Group}   || [];

    # get layout object
    my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');

    # check permission
    if ( $Action && ( @{$GroupsRo} || @{$GroupsRw} ) ) {

        # deny access by default, when there are groups to check
        $Access = 0;

        # check read only groups
        ROGROUP:
        for my $RoGroup ( @{$GroupsRo} ) {

            next ROGROUP if !$Kernel::OM->Get('Kernel::System::Group')->PermissionCheck(
                UserID    => $Self->{UserID},
                GroupName => $RoGroup,
                Type      => 'ro',
            );

            # set access
            $Access = 1;
            last ROGROUP;
        }

        # check read write groups
        RWGROUP:
        for my $RwGroup ( @{$GroupsRw} ) {

            next RWGROUP if !$Kernel::OM->Get('Kernel::System::Group')->PermissionCheck(
                UserID    => $Self->{UserID},
                GroupName => $RwGroup,
                Type      => 'rw',
            );

            # set access
            $Access = 1;
            last RWGROUP;
        }
    }

    return $Param{Counter} if !$Access;

    # output menu block
    $LayoutObject->Block( Name => 'Menu' );

    # output menu item
    $LayoutObject->Block(
        Name => 'MenuItem',
        Data => {
            %Param,
            %{ $Param{ConfigItem} },
            %{ $Param{Config} },
        },
    );

    # check if a dialog has to be shown
    if ( $Param{Config}->{DialogTitle} ) {
        my $ConfigObject   = $Kernel::OM->Get('Kernel::Config');
        my $LanguageObject = $Kernel::OM->Get('Kernel::Language');

        # Replace the template toolkit expressions with the final value.
        my %JSData = (
            %Param,
            %{ $Param{ConfigItem} },
            %{ $Param{Config} },
        );

        delete $JSData{Config};
        delete $JSData{ConfigItem};

        $JSData{ElementSelector}            =~ s/\[%\s*Data\.MenuID\s*\|\s*html\s*%\]/$JSData{MenuID}/i;
        $JSData{DialogContentQueryString}   =~ s/\[%\s*Data\.ConfigItemID\s*\|\s*html\s*%\]/$JSData{ConfigItemID}/i;
        $JSData{ConfirmedActionQueryString} =~ s/\[%\s*Data\.ConfigItemID\s*\|\s*html\s*%\]/$JSData{ConfigItemID}/i;

        $JSData{DialogTitle} =~ s/\[%\s*Translate\("(.*)"\)\s*\|\s*html\s*%\]/$LanguageObject->Translate($1)/ei;
        $JSData{DialogTitle} =~ s/\[%\s*Config\("(.*)"\)\s*%\]/$ConfigObject->Get($1)/ei;
        $JSData{DialogTitle} =~ s/\[%\s*Data.Number\s*\|\s*html\s*%\]/$JSData{Number}/ei;

        $JSData{MenuID} = 'Menu' . $JSData{MenuID};

        $LayoutObject->AddJSData(
            Key   => 'ITSMShowConfirmDialog.' . $Param{MenuID},
            Value => \%JSData,
        );
    }

    $Param{Counter}++;

    return $Param{Counter};
}

1;

# --
# OTOBO is a web-based ticketing system for service organisations.
# --
# Copyright (C) 2014-2018 Rother OSS Enterprises, http://otrs.ch/
# Copyright (C) 2019-2024 Rother OSS GmbH, https://otobo.io/
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

package Kernel::System::ITSMConfigItem::Event::DoLinkCount;

use strict;
use warnings;

our @ObjectDependencies = (
    'Kernel::Config',
    'Kernel::System::ITSMConfigItem',
    'Kernel::System::LinkObject',
    'Kernel::System::Log',
);

=head1 NAME

Kernel::System::ITSMConfigItem::Event::DoLinkCount - Event handler that count licenses using linked CI's

=head1 SYNOPSIS

All event handler functions for count licenses.

=head1 PUBLIC INTERFACE

=head2 new()

    use Kernel::System::ObjectManager;
    local $Kernel::OM = Kernel::System::ObjectManager->new();
    my $DoHistoryObject = $Kernel::OM->Get('Kernel::System::ITSMConfigItem::Event::DoLinkCount');

=cut

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {};
    bless( $Self, $Type );

    return $Self;
}

=head2 Run()

This method handles the event.

    $DoLinkCountObject->Run(
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

    # check needed stuff
    for my $Needed (qw(Data Event UserID)) {
        if ( !$Param{$Needed} ) {
            $Self->{LogObject}->Log(
                Priority => 'error',
                Message  => "Need $Needed!",
            );
            return;
        }
    }

    # create needed objects
    $Self->{ConfigItemObject} = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');
    $Self->{LinkObject}       = $Kernel::OM->Get('Kernel::System::LinkObject');
    $Self->{ConfigObject}     = $Kernel::OM->Get('Kernel::Config');

    # Get Config options
    my $LicenseDefaultSettings = $Self->{ConfigObject}->Get('ITSMConfigItem::CILicenseDefaultSettings');
    my $LicenseLinkTypSettings = $Self->{ConfigObject}->Get('ITSMConfigItem::CILicenseLinkTypSettings');
    my $LinkTypSoure           = $LicenseLinkTypSettings->{Source};
    my $LinkTypTarget          = $LicenseLinkTypSettings->{Target};

    my %ClassFilter;
    my $LinkedClassRestrictions = $Self->{ConfigObject}->Get('ITSMConfigItem::CILicenseLinkedClassRestrictions');
    if ($LinkedClassRestrictions) {
        %ClassFilter = map { $_ => 1 } @{$LinkedClassRestrictions};
    }

    my $LicenseDeplTypSettings = $Self->{ConfigObject}->Get('ITSMConfigItem::CILicenseDeploymentTypSettings');
    my $Counter                = 0;

    my $ConfigItem;
    if ( $Param{Data}{ConfigItemID} ) {

        $ConfigItem = $Self->{ConfigItemObject}->ConfigItemGet(
            ConfigItemID => $Param{Data}{ConfigItemID},
        );

        if ( $ConfigItem->{Class} ne $LicenseDefaultSettings->{CounterClassName} ) {
            return;
        }
    }

    my $LinkList = $Self->{LinkObject}->LinkListWithData(
        Object  => 'ITSMConfigItem',
        Key     => $Param{Data}{ConfigItemID},
        Object2 => 'ITSMConfigItem',             # (optional)
        State   => 'Valid',
        UserID  => 1,
    );

    if ( !$LinkList->{ITSMConfigItem}->{$LinkTypSoure} ) {
        $ConfigItem->{ $LicenseDefaultSettings->{CounterFieldNameUsedLicense} } = 0;
    }
    else {

        LINKTYPE:
        for my $LinkType ( keys %{ $LinkList->{ITSMConfigItem}->{$LinkTypSoure} } ) {

            # Check if the license is inside the config active
            LINKTYPECONFIG:
            for my $LinkTypeConfig ( keys %{$LicenseLinkTypSettings} ) {
                if ( $LinkType eq $LinkTypeConfig ) {
                    CI:
                    for my $LinkTypeDirection ( keys %{ $LinkList->{ITSMConfigItem}->{$LinkTypSoure}->{$LinkType} } ) {
                        next CI if ( %ClassFilter && !$ClassFilter{ $LinkList->{ITSMConfigItem}->{$LinkTypSoure}->{$LinkType}->{$LinkTypeDirection}->{Class} } );

                        for my $ConfigDeplState ( keys %{$LicenseDeplTypSettings} ) {
                            if ( $LinkList->{ITSMConfigItem}->{$LinkTypSoure}->{$LinkType}->{$LinkTypeDirection}->{CurDeplState} eq $ConfigDeplState ) {
                                $Counter++;
                            }
                        }
                    }
                }
            }
        }
    }

    $ConfigItem->{ $LicenseDefaultSettings->{CounterFieldNameUsedLicense} } = $Counter;
    my $Stock = $ConfigItem->{ $LicenseDefaultSettings->{CounterFieldNameStockLicense} } || 0;
    if ( $Stock > 0 ) {
        $ConfigItem->{ $LicenseDefaultSettings->{CounterFieldNameAvailibleLicense} } = $Stock - $Counter;
    }

    # add a new version with the new incident state
    my $VersionID = $Self->{ConfigItemObject}->ConfigItemUpdate(
        %{$ConfigItem},
        UserID => 1,
    );

    return 1;
}

=head2 _ConfigItemDelete()

history's event handler for ConfigItemDelete

=cut

sub _ConfigItemDelete {
    my ( $Self, %Param ) = @_;

    # delete history
    $Self->{ConfigItemObject}->HistoryDelete(
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
    $Self->{ConfigItemObject}->HistoryAdd(
        %Param,
    );

    return 1;
}

1;

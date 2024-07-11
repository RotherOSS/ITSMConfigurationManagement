# Rother OSS
# --
# Kernel/System/ITSMConfigItem/Event/DoLinkCount.pm - a event module for config items
# Copyright (C) 2014-2018 Rother OSS Enterprises, http://otrs.ch/
# Copyright (C) 2019-2022 Rother OSS GmbH, https://rother-oss.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::System::ITSMConfigItem::Event::DoLinkCount;

use strict;
use warnings;

our @ObjectDependencies = (
    'Kernel::System::ITSMConfigItem',
    'Kernel::System::Log',
    'Kernel::Config',
);

=head1 NAME

Kernel::System::ITSMConfigItem::Event::DoLinkCount - Event handler that count licenses using linked CI´s

=head1 SYNOPSIS

All event handler functions for count licenses.

=head1 PUBLIC INTERFACE

=over 4

=cut

=item new()


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

=item Run()

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
    $Self->{LinkObject} = $Kernel::OM->Get('Kernel::System::LinkObject');
    $Self->{ConfigObject} = $Kernel::OM->Get('Kernel::Config');

    # Get Config options
    my $LicenseDefaultSettings = $Self->{ConfigObject}->Get('ITSMConfigItem::CILicenseDefaultSettings');
    my $LicenseLinkTypSettings = $Self->{ConfigObject}->Get('ITSMConfigItem::CILicenseLinkTypSettings');
    my $LinkTypSoure = $LicenseLinkTypSettings->{Source};
    my $LinkTypTarget = $LicenseLinkTypSettings->{Target};

    my %ClassFilter;
    my $LinkedClassRestrictions = $Self->{ConfigObject}->Get('ITSMConfigItem::CILicenseLinkedClassRestrictions');
    if ( $LinkedClassRestrictions ) {
        %ClassFilter = map { $_ => 1 } @{ $LinkedClassRestrictions };
    }

    my $LicenseDeplTypSettings = $Self->{ConfigObject}->Get('ITSMConfigItem::CILicenseDeploymentTypSettings');
    my $Counter = 0;

    my $ConfigItem;
    if ($Param{Data}{ConfigItemID}) {

        $ConfigItem = $Self->{ConfigItemObject}->ConfigItemGet(
            ConfigItemID => $Param{Data}{ConfigItemID},
        );
    
       if ($ConfigItem->{Class} ne $LicenseDefaultSettings->{CounterClassName}) {
           return;
       }
    }

    my $LinkList = $Self->{LinkObject}->LinkListWithData(
        Object    => 'ITSMConfigItem',
        Key       => $Param{Data}{ConfigItemID},
        Object2   => 'ITSMConfigItem',         # (optional)
        State     => 'Valid',
        UserID    => 1,
    );

    if (!$LinkList->{ITSMConfigItem}->{$LinkTypSoure} ) {
        $ConfigItem->{$LicenseDefaultSettings->{CounterFieldNameUsedLicense}} = 0;
    } else {

        LINKTYPE:
        for my $LinkType ( keys %{$LinkList->{ITSMConfigItem}->{$LinkTypSoure}} ) {

            # Check if the license is inside the config active
            LINKTYPECONFIG:
            for my $LinkTypeConfig ( keys %{$LicenseLinkTypSettings} ) {
                if ( $LinkType eq $LinkTypeConfig ) {
                    CI:
                    for my $LinkTypeDirection (keys %{$LinkList->{ITSMConfigItem}->{$LinkTypSoure}->{$LinkType}} ) {
                        next CI if ( %ClassFilter && !$ClassFilter{ $LinkList->{ITSMConfigItem}->{$LinkTypSoure}->{$LinkType}->{$LinkTypeDirection}->{Class} } );

                        for my $ConfigDeplState (keys %{$LicenseDeplTypSettings}) {
                            if ($LinkList->{ITSMConfigItem}->{$LinkTypSoure}->{$LinkType}->{$LinkTypeDirection}->{CurDeplState} eq $ConfigDeplState ) {
                                $Counter++;
                            } 
                        }
                    }
                }
            }
        }
    }

    $ConfigItem->{$LicenseDefaultSettings->{CounterFieldNameUsedLicense}} = $Counter;
    my $Stock = $ConfigItem->{$LicenseDefaultSettings->{CounterFieldNameStockLicense}} || 0;
    if ( $Stock > 0) {
       $ConfigItem->{$LicenseDefaultSettings->{CounterFieldNameAvailibleLicense}} = $Stock - $Counter;
    }

    # add a new version with the new incident state
    my $VersionID = $Self->{ConfigItemObject}->ConfigItemUpdate(
        %{$ConfigItem},
        UserID      => 1,
    );

    return 1;
}

=item _ConfigItemDelete()

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

=item _HistoryAdd()

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

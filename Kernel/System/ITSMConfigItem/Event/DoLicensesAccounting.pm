# --
# OTOBO is a web-based ticketing system for service organisations.
# --
# Copyright (C) 2019-2026 Rother OSS GmbH, https://otobo.io/
# Copyright (C) 2019-2026 Rother OSS GmbH, https://otobo.io/
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

package Kernel::System::ITSMConfigItem::Event::DoLicensesAccounting;

use strict;
use warnings;
use List::Util qw(any none);

our @ObjectDependencies = (
    'Kernel::System::DynamicField',
    'Kernel::System::DynamicField::Backend',
    'Kernel::System::GeneralCatalog',
    'Kernel::Config',
    'Kernel::System::ITSMConfigItem',
    'Kernel::System::LinkObject',
    'Kernel::System::Log',
);

=head1 NAME

Kernel::System::ITSMConfigItem::Event::DoLicensesAccounting - Event handler that count licenses using linked CI's

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
    my $ConfigItemObject     = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');
    my $GeneralCatalogObject = $Kernel::OM->Get('Kernel::System::GeneralCatalog');
    my $ConfigObject         = $Kernel::OM->Get('Kernel::Config');

    # Get Config options
    my %LicenseSettings = $ConfigObject->Get('ITSMConfigItem::LicenseManagement')->%*;

    my $ConfigItem = $ConfigItemObject->ConfigItemGet(
        ConfigItemID  => $Param{Data}{ConfigItemID},
        DynamicFields => 1,
    );
    my %DeploymentStateList = %{
        $GeneralCatalogObject->ItemList(
            Class => 'ITSM::ConfigItem::DeploymentState',
        )
    };

    if ( $Param{Event} eq 'DeploymentStateUpdate' ) {

        my ( $CurrentDeplStateID, $PreviousDeplStateID ) = $Param{Data}{Comment} =~ /(\d+)%%(\d+)/;
        my $CurrentDeplState  = $DeploymentStateList{$CurrentDeplStateID};
        my $PreviousDeplState = $DeploymentStateList{$PreviousDeplStateID};

        LICENSE_SETTINGS_DEPL_STATE:
        for my $Key ( keys %LicenseSettings ) {
            my $LicenseReferenceDF = $LicenseSettings{$Key}{LicenseReferenceDF};
            next LICENSE_SETTINGS_DEPL_STATE if !$ConfigItem->{"DynamicField_$LicenseReferenceDF"};

            my @ValidDeplStates = ( $LicenseSettings{$Key}{ValidDeplStates} || [] )->@*;
            if (
                ( none { $_ eq $PreviousDeplState } @ValidDeplStates )
                &&
                ( any { $_ eq $CurrentDeplState } @ValidDeplStates )
                )
            {
                for my $LicenseReference ( $ConfigItem->{"DynamicField_$LicenseReferenceDF"}->@* ) {
                    $Self->_LicensesAccountingUpdate(
                        ObjectID            => $LicenseReference,
                        ConfigItemID        => $Param{Data}{ConfigItemID},
                        AvailableLicensesDF => $LicenseSettings{$Key}{AvailableLicensesDF},
                        UserID              => $Param{UserID},
                        Delta               => -1
                    );
                }
            }
            elsif (
                ( any { $_ eq $PreviousDeplState } @ValidDeplStates )
                &&
                ( none { $_ eq $CurrentDeplState } @ValidDeplStates )
                )
            {
                for my $LicenseReference ( $ConfigItem->{"DynamicField_$LicenseReferenceDF"}->@* ) {
                    $Self->_LicensesAccountingUpdate(
                        ObjectID            => $LicenseReference,
                        ConfigItemID        => $Param{Data}{ConfigItemID},
                        AvailableLicensesDF => $LicenseSettings{$Key}{AvailableLicensesDF},
                        UserID              => $Param{UserID},
                        Delta               => 1
                    );
                }
            }
        }
    }
    elsif ( $Param{Event} eq 'ConfigItemDelete' ) {
        LICENSE_SETTINGS_DELETE:
        for my $Key ( keys %LicenseSettings ) {
            my $LicenseReferenceDF = $LicenseSettings{$Key}{LicenseReferenceDF};
            next LICENSE_SETTINGS_DELETE if !$Param{Data}{ConfigItem}->{"DynamicField_$LicenseReferenceDF"};
            my @ValidDeplStates = ( $LicenseSettings{$Key}{ValidDeplStates} || [] )->@*;
            next LICENSE_SETTINGS_DELETE if none { $_ eq $ConfigItem->{CurDeplState} } @ValidDeplStates;
            for my $LicenseReference ( $Param{Data}{ConfigItem}->{"DynamicField_$LicenseReferenceDF"}->@* ) {
                $Self->_LicensesAccountingUpdate(
                    ObjectID            => $LicenseReference,
                    ConfigItemID        => $Param{Data}{ConfigItemID},
                    AvailableLicensesDF => $LicenseSettings{$Key}{AvailableLicensesDF},
                    UserID              => $Param{UserID},
                    Delta               => 1
                );
            }
        }
    }
    elsif ( $Param{Event} =~ /^ConfigItemDynamicFieldUpdate_/ ) {
        LICENSE_SETTINGS_UPDATE:
        for my $Key ( keys %LicenseSettings ) {
            my $LicenseReferenceDF = $LicenseSettings{$Key}{LicenseReferenceDF};
            my $TotalLicensesDF    = $LicenseSettings{$Key}{TotalLicensesDF};
            if ( $Param{Event} eq "ConfigItemDynamicFieldUpdate_$LicenseReferenceDF" ) {
                my @ValidDeplStates = ( $LicenseSettings{$Key}{ValidDeplStates} || [] )->@*;
                next LICENSE_SETTINGS_UPDATE if none { $_ eq $ConfigItem->{CurDeplState} } @ValidDeplStates;
                my @OldLicenseReferencesList = ( $Param{Data}{OldValue} || [] )->@*;
                my @NewLicenseReferencesList = ( $Param{Data}{Value}    || [] )->@*;
                for my $LicenseReference (@OldLicenseReferencesList) {
                    if ( none { $_ eq $LicenseReference } @NewLicenseReferencesList ) {
                        $Self->_LicensesAccountingUpdate(
                            ObjectID            => $LicenseReference,
                            ConfigItemID        => $Param{Data}{ConfigItemID},
                            AvailableLicensesDF => $LicenseSettings{$Key}{AvailableLicensesDF},
                            UserID              => $Param{UserID},
                            Delta               => 1
                        );
                    }
                }
                for my $LicenseReference (@NewLicenseReferencesList) {
                    if ( none { $_ eq $LicenseReference } @OldLicenseReferencesList ) {
                        $Self->_LicensesAccountingUpdate(
                            ObjectID            => $LicenseReference,
                            ConfigItemID        => $Param{Data}{ConfigItemID},
                            AvailableLicensesDF => $LicenseSettings{$Key}{AvailableLicensesDF},
                            UserID              => $Param{UserID},
                            Delta               => -1
                        );
                    }
                }
            }
            elsif ( $Param{Event} eq "ConfigItemDynamicFieldUpdate_$TotalLicensesDF" ) {
                my $LinkObject = $Kernel::OM->Get('Kernel::System::LinkObject');
                my $LinkList   = $LinkObject->LinkListWithData(
                    Object  => 'ITSMConfigItem',
                    Key     => $Param{Data}{ConfigItemID},
                    Object2 => 'ITSMConfigItem',
                    State   => 'Valid',
                    UserID  => $Param{UserID},
                );
                my $CountLinks         = scalar keys $LinkList->{ITSMConfigItem}{RelevantTo}{Source}->%*;
                my $TotalLicenses      = $ConfigItem->{"DynamicField_$TotalLicensesDF"};
                my $DynamicFieldObject = $Kernel::OM->Get('Kernel::System::DynamicField');
                my $DynamicFieldConfig = $DynamicFieldObject->DynamicFieldGet(
                    Name => $LicenseSettings{$Key}{AvailableLicensesDF},
                );
                my $DynamicFieldBackendObject = $Kernel::OM->Get('Kernel::System::DynamicField::Backend');
                my $Success                   = $DynamicFieldBackendObject->ValueSet(
                    DynamicFieldConfig => $DynamicFieldConfig,
                    ObjectID           => $ConfigItem->{LastVersionID},
                    UserID             => $Param{UserID},
                    Value              => $TotalLicenses - $CountLinks,
                );
            }
        }
    }

    return 1;
}

sub _LicensesAccountingUpdate {
    my ( $Self, %Param ) = @_;

    my $DynamicFieldBackendObject = $Kernel::OM->Get('Kernel::System::DynamicField::Backend');
    my $DynamicFieldObject        = $Kernel::OM->Get('Kernel::System::DynamicField');
    my $LogObject                 = $Kernel::OM->Get('Kernel::System::Log');
    my $ConfigItemObject          = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');
    my $LinkObject                = $Kernel::OM->Get('Kernel::System::LinkObject');

    my $DynamicFieldConfig = $DynamicFieldObject->DynamicFieldGet(
        Name => $Param{AvailableLicensesDF},
    );
    my $ConfigItem = $ConfigItemObject->ConfigItemGet(
        ConfigItemID  => $Param{ObjectID},
        DynamicFields => 1,
    );
    my $Success = $DynamicFieldBackendObject->ValueSet(
        DynamicFieldConfig => $DynamicFieldConfig,
        ObjectID           => $ConfigItem->{LastVersionID},
        UserID             => $Param{UserID},
        Value              => $ConfigItem->{ 'DynamicField_' . $Param{AvailableLicensesDF} } + $Param{Delta},
    );
    if ( !$Success ) {
        $LogObject->Log(
            Priority => 'error',
            Message  => "Could not update field '$Param{AvailableLicensesDF}'",
        );
        return;
    }
    if ( $Param{Delta} == 1 ) {
        my $Success = $LinkObject->LinkDelete(
            Object1 => 'ITSMConfigItem',
            Key1    => $Param{ConfigItemID},
            Object2 => 'ITSMConfigItem',
            Key2    => $Param{ObjectID},
            Type    => 'RelevantTo',
            UserID  => $Param{UserID}
        );
        if ( !$Success ) {
            $LogObject->Log(
                Priority => 'error',
                Message  => "Could not remove link",
            );
        }
    }
    elsif ( $Param{Delta} == -1 ) {
        my $Success = $LinkObject->LinkAdd(
            SourceObject => 'ITSMConfigItem',
            SourceKey    => $Param{ConfigItemID},
            TargetObject => 'ITSMConfigItem',
            TargetKey    => $Param{ObjectID},
            Type         => 'RelevantTo',
            State        => 'Valid',
            UserID       => $Param{UserID}
        );
        if ( !$Success ) {
            $LogObject->Log(
                Priority => 'error',
                Message  => "Could not create link",
            );
        }
    }

    return 1;
}

1;

=back

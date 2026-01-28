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

package Kernel::System::ITSMConfigItem::Event::CountLicenseLinks;

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

Kernel::System::ITSMConfigItem::Event::CountLicenseLinks - Event handler that count licenses using linked CI's

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
    my %LicenseSettings = $ConfigObject->Get('ITSMConfigItem::LicenseCount')->%*;

    my %DeploymentStateList = %{
        $GeneralCatalogObject->ItemList(
            Class => 'ITSM::ConfigItem::DeploymentState',
        )
    };

    if ( $Param{Event} eq 'DeploymentStateUpdate' ) {

        my $ConfigItem = $ConfigItemObject->ConfigItemGet(
            ConfigItemID  => $Param{Data}{ConfigItemID},
            DynamicFields => 1,
        );
        my $CurrentDeplStateID  = $Param{Data}{NewKey};
        my $PreviousDeplStateID = $Param{Data}{OldKey};
        my $CurrentDeplState    = $DeploymentStateList{$CurrentDeplStateID};
        my $PreviousDeplState   = $DeploymentStateList{$PreviousDeplStateID};

        LICENSE_SETTINGS_DEPL_STATE:
        for my $Key ( keys %LicenseSettings ) {
            my $LicenseReferenceDF = $LicenseSettings{$Key}{LicenseReferenceDF};

            next LICENSE_SETTINGS_DEPL_STATE if !$ConfigItem->{"DynamicField_$LicenseReferenceDF"};
            my @ValidDeplStates = ( $LicenseSettings{$Key}{ValidDeplStates} || [] )->@*;

            next LICENSE_SETTINGS_DEPL_STATE if !$LicenseSettings{$Key}{ValidDeplStates};
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

            next LICENSE_SETTINGS_DELETE if !$Param{Data}{ConfigItem}{"DynamicField_$LicenseReferenceDF"};
            my @ValidDeplStates = ( $LicenseSettings{$Key}{ValidDeplStates} || [] )->@*;

            next LICENSE_SETTINGS_DELETE if @ValidDeplStates && none { $_ eq $Param{Data}{ConfigItem}{CurDeplState} } @ValidDeplStates;
            for my $LicenseReference ( $Param{Data}{ConfigItem}{"DynamicField_$LicenseReferenceDF"}->@* ) {
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
        my $ConfigItem = $ConfigItemObject->ConfigItemGet(
            ConfigItemID  => $Param{Data}{ConfigItemID},
            DynamicFields => 1,
        );

        LICENSE_SETTINGS_UPDATE:
        for my $Key ( keys %LicenseSettings ) {
            my $LicenseReferenceDF = $LicenseSettings{$Key}{LicenseReferenceDF};
            my $TotalLicensesDF    = $LicenseSettings{$Key}{TotalLicensesDF};
            if ( $Param{Event} eq "ConfigItemDynamicFieldUpdate_$LicenseReferenceDF" ) {
                my @ValidDeplStates = ( $LicenseSettings{$Key}{ValidDeplStates} || [] )->@*;

                next LICENSE_SETTINGS_UPDATE if @ValidDeplStates && none { $_ eq $ConfigItem->{CurDeplState} } @ValidDeplStates;
                my @OldLicenseReferencesList = ( $Param{Data}{OldValue} || [] )->@*;
                my @NewLicenseReferencesList = ( $Param{Data}{Value}    || [] )->@*;
                my %Delta;

                OLD_REFERENCES:
                for my $LicenseReference (@OldLicenseReferencesList) {
                    next OLD_REFERENCES if !$LicenseReference;
                    $Delta{$LicenseReference}++;
                }

                NEW_REFERENCES:
                for my $LicenseReference (@NewLicenseReferencesList) {
                    next NEW_REFERENCES if !$LicenseReference;
                    $Delta{$LicenseReference}--;
                }

                DELTA:
                for my $LicenseReference ( keys %Delta ) {
                    next DELTA if !$Delta{$LicenseReference};

                    $Self->_LicensesAccountingUpdate(
                        ObjectID            => $LicenseReference,
                        ConfigItemID        => $Param{Data}{ConfigItemID},
                        AvailableLicensesDF => $LicenseSettings{$Key}{AvailableLicensesDF},
                        UserID              => $Param{UserID},
                        Delta               => $Delta{$LicenseReference}
                    );
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
                my $LinkedConfigItems = $ConfigItemObject->LinkedConfigItems(
                    ConfigItemID => $Param{Data}{ConfigItemID},
                    Direction    => 'Both',                       # one of Source, Target, Both
                    UserID       => $Param{UserID},
                );
                my $CountLinks = 0;

                LINK:
                for my $Link ( $LinkedConfigItems->@* ) {
                    my $ConfigItem = $ConfigItemObject->ConfigItemGet(
                        ConfigItemID  => $Link->{ConfigItemID},
                        DynamicFields => 1,
                    );

                    next LINK if !$ConfigItem->{"DynamicField_$LicenseReferenceDF"};
                    $CountLinks++;
                }
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

    my $DynamicFieldConfig = $DynamicFieldObject->DynamicFieldGet(
        Name => $Param{AvailableLicensesDF},
    );
    my $ConfigItem = $ConfigItemObject->ConfigItemGet(
        ConfigItemID  => $Param{ObjectID},
        DynamicFields => 1,
    );

    my $AvailableLicensesDF = 'DynamicField_' . $Param{AvailableLicensesDF};
    my $Success             = $ConfigItemObject->ConfigItemUpdate(
        ConfigItemID         => $ConfigItem->{ConfigItemID},
        $AvailableLicensesDF => $ConfigItem->{$AvailableLicensesDF} + $Param{Delta},
        UserID               => $Param{UserID},
    );
    if ( !$Success ) {
        $LogObject->Log(
            Priority => 'error',
            Message  => "Could not update field '$Param{AvailableLicensesDF}'",
        );
        return;
    }

    if ( $Param{Delta} == 1 ) {
        my $Success = $ConfigItemObject->DeleteConfigItemLink(
            SourceConfigItemID => $Param{ConfigItemID},
            TargetConfigItemID => $Param{ObjectID},
            Type               => 'RelevantTo',
        );
        if ( !$Success ) {
            $LogObject->Log(
                Priority => 'error',
                Message  => "Could not remove link",
            );
        }
    }
    elsif ( $Param{Delta} == -1 ) {
        my $Success = $ConfigItemObject->AddConfigItemLink(
            SourceConfigItemID => $Param{ConfigItemID},
            TargetConfigItemID => $Param{ObjectID},
            Type               => 'RelevantTo',
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

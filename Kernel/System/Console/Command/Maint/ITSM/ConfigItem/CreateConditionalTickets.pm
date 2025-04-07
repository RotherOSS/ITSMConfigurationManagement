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

package Kernel::System::Console::Command::Maint::ITSM::ConfigItem::CreateConditionalTickets;

use strict;
use warnings;

use parent qw(Kernel::System::Console::BaseCommand);

use Kernel::System::VariableCheck qw(:all);

our @ObjectDependencies = (
    'Kernel::Config',
    'Kernel::System::DynamicField',
    'Kernel::System::DynamicField::Backend',
    'Kernel::System::GeneralCatalog',
    'Kernel::System::ITSMConfigItem',
    'Kernel::System::LinkObject',
    'Kernel::System::Log',
    'Kernel::System::Ticket',
    'Kernel::System::Ticket::Article',
);

sub Configure {
    my ( $Self, %Param ) = @_;

    $Self->Description('Checks the configured config items and creates tickets as notification if the requirements are fullfilled.');

    return;
}

sub Run {
    my ( $Self, %Param ) = @_;

    my $NotificationConfigs = $Kernel::OM->Get('Kernel::Config')->Get('RotherOSSCMDBNotifications::Rules');

    if ( !$NotificationConfigs ) {
        $Self->Print("\n<green>No notifications configured.</green>\n");
        return $Self->ExitCodeOk();
    }

    my $ConfigItemObject          = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');
    my $GeneralCatalogObject      = $Kernel::OM->Get('Kernel::System::GeneralCatalog');
    my $LinkObject                = $Kernel::OM->Get('Kernel::System::LinkObject');
    my $TicketObject              = $Kernel::OM->Get('Kernel::System::Ticket');
    my $ArticleObject             = $Kernel::OM->Get('Kernel::System::Ticket::Article');
    my $DynamicFieldObject        = $Kernel::OM->Get('Kernel::System::DynamicField');
    my $DynamicFieldBackendObject = $Kernel::OM->Get('Kernel::System::DynamicField::Backend');

    my %ClassList = reverse %{
        $GeneralCatalogObject->ItemList(
            Class => 'ITSM::ConfigItem::Class',
        )
    };
    my %DeplStateList = reverse %{
        $GeneralCatalogObject->ItemList(
            Class => 'ITSM::ConfigItem::DeploymentState',
        )
    };

    # go through all configured notification setups
    CONFIG:
    for my $Config ( values %{$NotificationConfigs} ) {

        # get class and deployment state ids
        my $ClassID      = $ClassList{ $Config->{Class} };
        my $DeplStateIDs = [ map { $DeplStateList{$_} } @{ $Config->{ActiveDeploymentStates} } ];

        if ( !$ClassID || !IsArrayRefWithData($DeplStateIDs) ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "No class '$Config->{Class}', or valid deployment states configured!",
            );
            next CONFIG;
        }

        my @ConfigItemIDs = $ConfigItemObject->ConfigItemSearch(
            ClassIDs     => [$ClassID],
            DeplStateIDs => $DeplStateIDs,
            Result       => 'ARRAY',
        );

        # go through all config items
        CONFIGITEMID:
        for my $ConfigItemID (@ConfigItemIDs) {
            my $LastVersion = $ConfigItemObject->ConfigItemGet(
                ConfigItemID => $ConfigItemID,
            );

            if ( !defined $LastVersion->{ $Config->{TimeCIKey} } ) {
                $Kernel::OM->Get('Kernel::System::Log')->Log(
                    Priority => 'info',
                    Message  => "$Config->{TimeCIKey} field of ConfigItemID $ConfigItemID is empty - skip!",
                );
                next CONFIGITEMID;
            }

            # define the trigger date;
            my $TriggerDateObject;

            # date field format
            if ( $LastVersion->{ $Config->{TimeCIKey} } =~ /^(\d+)-(\d+)-(\d+)/ ) {
                $TriggerDateObject = $Kernel::OM->Create(
                    'Kernel::System::DateTime',
                    ObjectParams => {
                        Year   => $1,
                        Month  => $2,
                        Day    => $3,
                        Hour   => 0,
                        Minute => 0,
                        Second => 0,
                    }
                );
            }

            # try old text field format
            elsif ( $LastVersion->{ $Config->{TimeCIKey} } =~ /^\s*(\d+)\.\s*(\d+)\.\s*(\d+)\s*(\d*):?\s*(\d*):?\s*(\d*)/ ) {
                $TriggerDateObject = $Kernel::OM->Create(
                    'Kernel::System::DateTime',
                    ObjectParams => {
                        Year   => $3,
                        Month  => $2,
                        Day    => $1,
                        Hour   => $4 || 0,
                        Minute => $5 || 0,
                        Second => $6 || 0,
                    }
                );
            }
            else {
                $Kernel::OM->Get('Kernel::System::Log')->Log(
                    Priority => 'error',
                    Message  => "$Config->{TimeCIKey} field of ConfigItemID $ConfigItemID has an invalid format!",
                );
                next CONFIGITEMID;
            }

            # prepare the modifier
            my ( $Sign, $Summand, $Unit ) = ( $Config->{TimeModifier} =~ /^\s*([+-]?)\s*(\d+)\s*([dhm]?)/ );
            $Summand *= ( $Sign && $Sign eq '-' )  ? -1 : 1;
            $Summand *= ( !$Unit || $Unit eq 'd' ) ? 86400 :
                ( $Unit eq 'h' ) ? 3600 : 60;

            # get now
            my $NowObject = $Kernel::OM->Create(
                'Kernel::System::DateTime'
            );

            # only proceed, if now is later than then modified trigger date
            next CONFIGITEMID if ( $NowObject->ToEpoch() < $TriggerDateObject->ToEpoch() + $Summand );

            # check whether a ticket was generated previously and is not closed
            my %LinkList = $LinkObject->LinkKeyList(
                Object1 => 'ITSMConfigItem',
                Key1    => $ConfigItemID,
                Object2 => 'Ticket',
                State   => 'Valid',
                Type    => 'DependsOn',
                UserID  => 1,
            );

            for my $LinkedTicketID ( keys %LinkList ) {
                my %Ticket = $TicketObject->TicketGet(
                    TicketID      => $LinkedTicketID,
                    DynamicFields => 1,
                    UserID        => 1,
                    Silent        => 1,
                );

                # skip config item, if an open ticket was already created
                if (
                    $Ticket{ 'DynamicField_' . $Config->{Ticket}{DynamicField} }
                    && $Ticket{ 'DynamicField_' . $Config->{Ticket}{DynamicField} } == 1
                    && $Ticket{StateType} ne "closed"
                    )
                {
                    next CONFIGITEMID;
                }
            }

            # prepare substitutions
            my %Substitutions = (
                '<OTOBO_CONFIGITEM_NUMBER>' => $LastVersion->{Number},
                '<OTOBO_CONFIGITEM_NAME>'   => $LastVersion->{Name},
                '<OTOBO_CONFIGITEM_DATE>'   => $LastVersion->{ $Config->{TimeCIKey} },
            );
            my %DefinitionRefs = map { $_->{Key} => $_ } @{ $LastVersion->{DefinitionRef} };

            SUBKEY:
            for my $Key ( ( $Config->{Ticket}{Title} . $Config->{Ticket}{Text} ) =~ /<OTOBO_CONFIGITEM_([^>]+)>/g ) {
                next SUBKEY if exists $Substitutions{"<OTOBO_CONFIGITEM_$Key>"};
                next SUBKEY if !$LastVersion->{$Key};

                $Substitutions{"<OTOBO_CONFIGITEM_$Key>"} = $LastVersion->{$Key} // '';
            }

            my $TicketTitle      = $Config->{Ticket}{Title};
            my $NotificationText = $Config->{Ticket}{Text};
            for my $Key ( keys %Substitutions ) {
                $TicketTitle      =~ s/$Key/$Substitutions{ $Key }/g;
                $NotificationText =~ s/$Key/$Substitutions{ $Key }/g;
            }

            # all checks finished -> create a ticket as notification
            my $TicketID = $TicketObject->TicketCreate(
                TN           => $TicketObject->TicketCreateNumber(),
                Title        => $TicketTitle,
                Queue        => $Config->{Ticket}{Queue},
                Lock         => $Config->{Ticket}{Lock}         || 'unlock',
                Priority     => $Config->{Ticket}{Priority}     || '3 normal',
                State        => $Config->{Ticket}{State}        || 'new',
                Type         => $Config->{Ticket}{Type}         || '',
                Service      => $Config->{Ticket}{Service}      || '',
                SLA          => $Config->{Ticket}{SLA}          || '',
                CustomerID   => $Config->{Ticket}{CustomerID}   || '',
                CustomerUser => $Config->{Ticket}{CustomerUser} || '',
                OwnerID      => $Config->{Ticket}{OwnerID}      || '1',
                UserID       => 1,
            );
            if ( !$TicketID ) {
                $Kernel::OM->Get('Kernel::System::Log')->Log(
                    Priority => 'error',
                    Message  => "Could not create a ticket for ConfigItemID: $ConfigItemID!",
                );
                next CONFIGITEMID;
            }

            # do article db insert
            my $InternalArticleBackendObject = $ArticleObject->BackendForChannel( ChannelName => 'Internal' );
            my $ArticleID                    = $InternalArticleBackendObject->ArticleCreate(
                TicketID             => $TicketID,
                ArticleType          => $Config->{Ticket}{ArticleType} || 'note-report',
                SenderType           => $Config->{Ticket}{SenderType}  || 'system',
                ContentType          => 'text/plain; charset=ISO-8859-15',
                Body                 => $NotificationText,
                Subject              => $TicketTitle,
                IsVisibleForCustomer => 0,
                UserID               => 1,
                HistoryType          => 'NewTicket',
                HistoryComment       => "\%\% RotherOSS-CMDBNotification",
            );

            # close ticket if article create failed!
            if ( !$ArticleID ) {
                $TicketObject->TicketDelete(
                    TicketID => $TicketID,
                    UserID   => 1,
                );
                $Kernel::OM->Get('Kernel::System::Log')->Log(
                    Priority => 'error',
                    Message  => "Can't process ticket!",
                );
                next CONFIGITEMID;
            }

            # link ticket and config item
            $LinkObject->LinkAdd(
                SourceObject => 'ITSMConfigItem',
                SourceKey    => $ConfigItemID,
                TargetObject => 'Ticket',
                TargetKey    => $TicketID,
                Type         => 'DependsOn',
                State        => 'Valid',
                UserID       => 1,
            );

            # set the dynamic field  to 1, to mark the ticket as generated by this script
            my $DynamicField = $DynamicFieldObject->DynamicFieldGet(
                Name => $Config->{Ticket}{DynamicField},
            );
            $DynamicFieldBackendObject->ValueSet(
                DynamicFieldConfig => $DynamicField,
                ObjectID           => $TicketID,
                Value              => 1,
                UserID             => 1,
            );

        }
    }

    $Self->Print("\n<green>Done.</green>\n");
    return $Self->ExitCodeOk();
}

1;

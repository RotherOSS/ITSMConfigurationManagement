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

package Kernel::System::ProcessManagement::TransitionAction::ConfigItemAdd;

use strict;
use warnings;
use utf8;

use Kernel::System::VariableCheck qw(:all);

use parent qw(Kernel::System::ProcessManagement::TransitionAction::Base);

our @ObjectDependencies = (
    'Kernel::Config',
    'Kernel::System::DynamicField',
    'Kernel::System::DynamicField::Backend',
    'Kernel::System::GeneralCatalog',
    'Kernel::System::ITSMConfigItem',
    'Kernel::System::LinkObject',
    'Kernel::System::Log',
    'Kernel::System::State',
    'Kernel::System::DateTime',
    'Kernel::System::User',
);

=head1 NAME

Kernel::System::ProcessManagement::TransitionAction::ConfigItemAdd - A module to create a config item

=head1 DESCRIPTION

All ConfigItemCreate functions.

=head1 PUBLIC INTERFACE

=head2 new()

Don't use the constructor directly, use the ObjectManager instead:

    my $ConfigItemCreateObject = $Kernel::OM->Get('Kernel::System::ProcessManagement::TransitionAction::ConfigItemCreate');

=cut

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {};
    bless( $Self, $Type );

    return $Self;
}

=head2 Params()

Returns the configuration params for this transition action module

    my @Params = $Object->Params();

Each element is a hash reference that describes the config parameter.
Currently only the keys I<Key>, I<Value> and I<Optional> are used.

=cut

sub Params {
    my ($Self) = @_;

    my @Params = (
        {
            Key      => 'Name',
            Value    => 'A name (required if no name module is configured)',
            Optional => 1,
        },
        {
            Key   => 'Class',
            Value => 'A class (required)',
        },
        {
            Key   => 'DeplState',
            Value => 'A deployment state (required)',
        },
        {
            Key   => 'InciState',
            Value => 'An incident state (required)',
        },
        {
            Key      => 'DynamicField_<Name> (replace <Name>)',
            Value    => 'A value',
            Optional => 1,
        },
        {
            Key      => 'Attachments',
            Value    => '...',
            Optional => 1,
        },
        {
            Key      => 'LinkAs',
            Value    => 'Alternative to|Depends on|Relevant to',
            Optional => 1,
        },
        {
            Key      => 'UserID',
            Value    => '1 (can overwrite the logged in user)',
            Optional => 1,
        },
    );

    return @Params;
}

=head2 Run()

    Run Data

    my $ConfigItemCreateResult = $ConfigItemCreateActionObject->Run(
        UserID                   => 123,
        Ticket                   => \%Ticket,   # required
        ProcessEntityID          => 'P123',
        ActivityEntityID         => 'A123',
        TransitionEntityID       => 'T123',
        TransitionActionEntityID => 'TA123',
        Config                   => {
            # config item required:
            Class         => 'Class of the Config Item',
            DeplState     => 'Some Deployment State',
            InciState     => 'Some Incident State',

            # config item optional:
            Name          => 'Some Config Item Name',

            %DataPayload,                                               # some parameters depending of each communication channel

            # other:
            DynamicField_NameX => $Value,
            LinkAs => $LinkType,                                        # Normal, Parent, Child, etc. (respective original ticket)
            UserID => 123,                                              # optional, to override the UserID from the logged user
        }
    );
    Ticket contains the result of TicketGet including DynamicFields
    Config is the Config Hash stored in a Process::TransitionAction's  Config key
    Returns:

    $ConfigItemCreateResult = 1; # 0

    );

=cut

sub Run {
    my ( $Self, %Param ) = @_;

    # define a common message to output in case of any error
    my $CommonMessage = "Process: $Param{ProcessEntityID} Activity: $Param{ActivityEntityID}"
        . " Transition: $Param{TransitionEntityID}"
        . " TransitionAction: $Param{TransitionActionEntityID} - ";

    # check for missing or wrong params
    my $Success = $Self->_CheckParams(
        %Param,
        CommonMessage => $CommonMessage,
    );
    return if !$Success;

    # override UserID if specified as a parameter in the TA config
    $Param{UserID} = $Self->_OverrideUserID(%Param);

    # use ticket attributes if needed
    $Self->_ReplaceTicketAttributes(%Param);
    $Self->_ReplaceAdditionalAttributes(%Param);

    # collect ticket params
    my %ConfigItemParam;
    for my $Attribute (qw( Name Class DeplState InciState )) {
        if ( defined $Param{Config}->{$Attribute} ) {
            $ConfigItemParam{$Attribute} = $Param{Config}->{$Attribute};
        }
    }

    # get general catalog object
    my $GeneralCatalogObject = $Kernel::OM->Get('Kernel::System::GeneralCatalog');

    # get class list
    my %Class2IDMap = reverse $GeneralCatalogObject->ItemList(
        Class => 'ITSM::ConfigItem::Class',
    )->%*;

    # translate class name into class id
    $ConfigItemParam{ClassID} = $Class2IDMap{ $ConfigItemParam{Class} };

    # get deployment state list
    my %DeplState2IDMap = reverse $GeneralCatalogObject->ItemList(
        Class => 'ITSM::ConfigItem::DeploymentState',
    )->%*;

    # translate depl state into depl state id
    $ConfigItemParam{DeplStateID} = $DeplState2IDMap{ $ConfigItemParam{DeplState} };

    # get incident state list
    my %InciState2IDMap = reverse $GeneralCatalogObject->ItemList(
        Class => 'ITSM::Core::IncidentState',
    )->%*;

    # translate inci state into inci state id
    $ConfigItemParam{InciStateID} = $InciState2IDMap{ $ConfigItemParam{InciState} };

    # get ticket object
    my $ConfigItemObject = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');

    # create ticket
    my $ConfigItemID = $ConfigItemObject->ConfigItemAdd(
        %ConfigItemParam,
        UserID => $Param{UserID},
    );

    if ( !$ConfigItemID ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => $CommonMessage
                . "Couldn't create New ConfigItem from Ticket: "
                . $Param{Ticket}->{TicketID} . '!',
        );
        return;
    }

    # get dynamic field objects
    my $DynamicFieldBackendObject = $Kernel::OM->Get('Kernel::System::DynamicField::Backend');

    # get class definition
    my $Definition = $ConfigItemObject->DefinitionGet(
        ClassID => $Class2IDMap{ $Param{Config}{Class} },
    );

    if ( !IsHashRefWithData($Definition) || !$Definition->{DefinitionID} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => $CommonMessage
                . "Couldn't fetch config item definition for config item class: "
                . $Param{Config}{Class} . '!',
        );
        return;
    }

    # set dynamic field values
    CONFIGPARAM:
    for my $ConfigParam ( keys $Param{Config}->%* ) {
        next CONFIGPARAM unless $ConfigParam =~ m{\A DynamicField_ ( [a-zA-Z0-9\-]+ ) \z}msx;

        my $DynamicFieldName   = $1;
        my $DynamicFieldConfig = $Definition->{DynamicFieldRef}{$DynamicFieldName};

        next CONFIGPARAM unless IsHashRefWithData($DynamicFieldConfig);
        next CONFIGPARAM unless $DynamicFieldConfig->{Name};
        next CONFIGPARAM unless $DynamicFieldConfig->{ObjectType} eq 'ITSMConfigItem';

        my $ObjectID = $ConfigItemID;

        # set the value
        my $Success = $DynamicFieldBackendObject->ValueSet(
            DynamicFieldConfig => $DynamicFieldConfig,
            ObjectID           => $ObjectID,
            Value              => $Param{Config}->{ 'DynamicField_' . $DynamicFieldConfig->{Name} },
            UserID             => $Param{UserID},
        );

        if ( !$Success ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => $CommonMessage
                    . "Couldn't set DynamicField Value on $DynamicFieldConfig->{ObjectType}:"
                    . " $ObjectID from Ticket: "
                    . $Param{Ticket}->{TicketID} . '!',
            );
            return;
        }
    }

    # link ticket
    if ( $Param{Config}->{LinkAs} ) {

        # get link object
        my $LinkObject = $Kernel::OM->Get('Kernel::System::LinkObject');

        # get config of all types
        my %ConfiguredTypes = $LinkObject->TypeList(
            UserID => 1,
        );

        my $SelectedType;
        my $SelectedDirection;

        TYPE:
        for my $Type ( sort keys %ConfiguredTypes ) {
            if (
                $Param{Config}->{LinkAs} ne $ConfiguredTypes{$Type}->{SourceName}
                && $Param{Config}->{LinkAs} ne $ConfiguredTypes{$Type}->{TargetName}
                )
            {
                next TYPE;
            }
            $SelectedType      = $Type;
            $SelectedDirection = 'Source';
            if ( $Param{Config}->{LinkAs} eq $ConfiguredTypes{$Type}->{TargetName} ) {
                $SelectedDirection = 'Target';
            }
            last TYPE;
        }

        if ( !$SelectedType ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => $CommonMessage
                    . "LinkAs $Param{Config}->{LinkAs} is invalid!"
            );
            return;
        }

        my $SourceObjectID   = $ConfigItemID;
        my $SourceObjectType = 'ITSMConfigItem';
        my $TargetObjectID   = $Param{Ticket}->{TicketID};
        my $TargetObjectType = 'Ticket';
        if ( $SelectedDirection eq 'Target' ) {
            $SourceObjectID   = $Param{Ticket}->{TicketID};
            $SourceObjectType = 'Ticket';
            $TargetObjectID   = $ConfigItemID;
            $TargetObjectType = 'ITSMConfigItem';
        }

        my $Success = $LinkObject->LinkAdd(
            SourceObject => $SourceObjectType,
            SourceKey    => $SourceObjectID,
            TargetObject => $TargetObjectType,
            TargetKey    => $TargetObjectID,
            Type         => $SelectedType,
            State        => 'Valid',
            UserID       => $Param{UserID},
        );

        if ( !$Success ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => $CommonMessage
                    . "Couldn't Link Tickets $SourceObjectID with $TargetObjectID as $Param{Config}->{LinkAs}!",
            );
            return;
        }
    }

    return 1;
}

1;

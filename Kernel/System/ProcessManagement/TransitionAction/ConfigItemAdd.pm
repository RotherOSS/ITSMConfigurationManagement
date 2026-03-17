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

use Kernel::System::VariableCheck qw(IsHashRefWithData);

use parent qw(Kernel::System::ProcessManagement::TransitionAction::Base);

our @ObjectDependencies = (
    'Kernel::Config',
    'Kernel::System::DynamicField',
    'Kernel::System::DynamicField::Backend',
    'Kernel::System::GeneralCatalog',
    'Kernel::System::ITSMConfigItem',
    'Kernel::System::LinkObject',
    'Kernel::System::Log',
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
            Key      => 'Number',
            Value    => 'The number (required if no number module is configured)',
            Optional => 1,
        },
        {
            Key      => 'Name',
            Value    => 'A name (required if no name module is configured)',
            Optional => 1,
        },
        {
            Key      => 'VersionString',
            Value    => 'The version string (required if no version string module is configured)',
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
            Key      => 'LinkAs',
            Value    => 'Alternative to|Depends on|Relevant to',
            Optional => 1,
        },
        {
            Key      => 'StoreConfigItemIDDynamicField',
            Value    => 'NameX (name of DynamicField holding the id of the created ConfigItem in the original ticket)',
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
            %DataPayload,

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

    my $GeneralCatalogObject = $Kernel::OM->Get('Kernel::System::GeneralCatalog');
    my $ConfigItemObject     = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');

    my %Class2IDMap     = reverse $GeneralCatalogObject->ItemList( Class => 'ITSM::ConfigItem::Class' )->%*;
    my %DeplState2IDMap = reverse $GeneralCatalogObject->ItemList( Class => 'ITSM::ConfigItem::DeploymentState' )->%*;
    my %InciState2IDMap = reverse $GeneralCatalogObject->ItemList( Class => 'ITSM::Core::IncidentState' )->%*;

    my %ConfigItemParam;

    for my $OptionalAttribute ( qw/Name Number VersionString/ ) {
        if ( $Param{Config}{ $OptionalAttribute } ) {
            $ConfigItemParam{$OptionalAttribute} = $Param{Config}{ $OptionalAttribute };
        }
    }

    $ConfigItemParam{ClassID}     = $Class2IDMap{     $Param{Config}{Class} };
    $ConfigItemParam{DeplStateID} = $DeplState2IDMap{ $Param{Config}{DeplState} };
    $ConfigItemParam{InciStateID} = $InciState2IDMap{ $Param{Config}{InciState} };

    for my $Needed ( qw/Class DeplState InciState/ ) {
        if ( !$ConfigItemParam{ $Needed . 'ID' } ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => $CommonMessage
                    . "Could not retrieve $Needed" . "ID from '$Param{Config}{ $Needed }' in Ticket:"
                    . $Param{Ticket}->{TicketID} . '!',
            );

            return;
        }
    }

    my $DynamicFieldObject = $Kernel::OM->Get('Kernel::System::DynamicField');
    my $SetMapping         = $Kernel::OM->Get('Kernel::Config')->Get('DynamicFields::DynamicFieldSet::InnerFieldsTicketToCI') // {};

    # add dynamic fields
    CONFIGPARAM:
    for my $ConfigParam ( keys $Param{Config}->%* ) {
        next CONFIGPARAM if $ConfigParam !~ /^DynamicField_(.+)/;

        my $FieldName    = $1;
        my $DynamicField = $DynamicFieldObject->DynamicFieldGet(
            Name => $FieldName,
        );

        next CONFIGPARAM if !IsHashRefWithData( $DynamicField );

        # for set fields we need to map the name of the inner fields
        if ( $DynamicField && $DynamicField->{FieldType} eq 'Set' && ref $Param{Config}{ $ConfigParam } ) {
            SETVALUE:
            for my $SetValue ( $Param{Config}{ $ConfigParam }->@* ) {
                next unless $SetValue;

                for my $InnerField ( keys $SetValue->%* ) {
                    if ( $SetMapping->{ $InnerField } ) {
                        $SetValue->{ $SetMapping->{ $InnerField } } = delete $SetValue->{ $InnerField };
                    }
                }
            }
        }

        $ConfigItemParam{ $ConfigParam } = $Param{Config}{ $ConfigParam };
    }

    # create config item
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

    # store created ConfigItemID
    if ( $Param{Config}->{StoreConfigItemIDDynamicField} ) {
        my $DynamicFieldConfig = $DynamicFieldObject->DynamicFieldGet(
            Name => $Param{Config}->{StoreConfigItemIDDynamicField},
        );

        if ( !$DynamicFieldConfig || !IsHashRefWithData($DynamicFieldConfig) ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => $CommonMessage
                    . "Couldn't get DynamicField $Param{Config}->{StoreConfigItemIDDynamicField} for Ticket $Param{Ticket}->{TicketID}."
            );

            return;
        }

        # set the value
        my $Success = $Kernel::OM->Get('Kernel::System::DynamicField::Backend')->ValueSet(
            DynamicFieldConfig => $DynamicFieldConfig,
            ObjectID           => $Param{Ticket}->{TicketID},
            Value              => $ConfigItemID,
            UserID             => $Param{UserID},
        );

        if ( !$Success ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => $CommonMessage
                    . "Couldn't set DynamicField Value on $DynamicFieldConfig->{ObjectType}:"
                    . " for Ticket: $Param{Ticket}->{TicketID}!",
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

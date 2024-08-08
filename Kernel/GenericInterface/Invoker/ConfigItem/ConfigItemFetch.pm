# --
# OTOBO is a web-based ticketing system for service organisations.
# --
# Copyright (C) 2001-2020 OTRS AG, https://otrs.com/
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

package Kernel::GenericInterface::Invoker::ConfigItem::ConfigItemFetch;

use strict;
use warnings;

our $ObjectManagerDisabled = 1;

use Kernel::System::VariableCheck qw(:all);

=head1 NAME

Kernel::GenericInterface::Invoker::ConfigItem::ConfigItemFetch - GenericInterface for ITSM ConfigItems

=head1 SYNOPSIS

GenericInterface for ITSM ConfigItems

=head1 PUBLIC INTERFACE

=over 4

=cut

=item new()

usually, you want to create an instance of this
by using Kernel::GenericInterface::Invoker->new();

=cut

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {};
    bless( $Self, $Type );

    # check needed params
    for my $Needed (
        qw(DebuggerObject WebserviceID Invoker)
        )
    {
        if ( !$Param{$Needed} ) {
            return {
                Success      => 0,
                ErrorMessage => "Got no $Needed!"
            };
        }

        $Self->{$Needed} = $Param{$Needed};
    }

    return $Self;
}

=item PrepareRequest()

prepare the invocation of the configured remote web service.
This will just return the data that was passed to the function.

    my $Result = $InvokerObject->PrepareRequest(
        Data => {                               # data payload
            ...
        },
    );

    $Result = {
        Success         => 1,                   # 0 or 1
        ErrorMessage    => '',                  # in case of error
        Data            => {                    # data payload after Invoker
            ...
        },
    };

=cut

sub PrepareRequest {
    my ( $Self, %Param ) = @_;

    return {
        Success => 1,
        Data    => IsHashRefWithData( $Param{Data} ) ? $Param{Data} : {},
    };
}

=item HandleResponse()

handle response data of the configured remote web service.
This will just return the data that was passed to the function.

    my $Result = $InvokerObject->HandleResponse(
        ResponseSuccess      => 1,              # success status of the remote web service
        ResponseErrorMessage => '',             # in case of web service error
        Data => {                               # data payload
            ...
        },
    );

    $Result = {
        Success         => 1,                   # 0 or 1
        ErrorMessage    => '',                  # in case of error
        Data            => {                    # data payload after Invoker
            ...
        },
    };

=cut

sub HandleResponse {
    my ( $Self, %Param ) = @_;

    # if there was an error in the response, forward it
    if ( !$Param{ResponseSuccess} ) {

        return $Self->Error(
            ErrorMessage => $Param{ResponseErrorMessage} || 'Unknown Error',
        );
    }

    if ( ref $Param{Data} ne 'HASH' && ref $Param{Data} ne 'ARRAY' ) {

        return $Self->Error(
            ErrorMessage => "Invalid structure for parameter 'Data'.",
        );
    }

    # Nothing to do.
    if ( !IsHashRefWithData( $Param{Data} ) && !IsArrayRefWithData( $Param{Data} ) ) {
        return $Self->Success(
            Data => $Param{Data},
        );
    }

    # remove toplevel ConfigItems if not given as direct array
    if ( IsHashRefWithData( $Param{Data} ) && $Param{Data}{ConfigItems} ) {
        $Param{Data} = $Param{Data}{ConfigItems};
    }

    # transform to array reference
    if ( IsHashRefWithData( $Param{Data} ) ) {
        $Param{Data} = [ $Param{Data} ];
    }

    # get webservice configuration
    my $Webservice = $Kernel::OM->Get('Kernel::System::GenericInterface::Webservice')->WebserviceGet(
        ID => $Self->{WebserviceID},
    );

    # get invoker config
    my $InvokerConfig = $Webservice->{Config}->{Requester}->{Invoker}->{ $Self->{Invoker} };

    # get config item object
    my $ConfigItemObject = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');

    # get general catalog object
    my $GeneralCatalogObject = $Kernel::OM->Get('Kernel::System::GeneralCatalog');

    my %CIClassMapping = (
        IncidentState   => 'ITSM::Core::IncidentState',
        DeploymentState => 'ITSM::ConfigItem::DeploymentState',
        Class           => 'ITSM::ConfigItem::Class',
    );

    my %GeneralCatalogItemLookup;
    my %NameModuleObjects;
    CI:
    for my $RemoteCIData ( @{ $Param{Data} } ) {

        if ( !IsHashRefWithData($RemoteCIData) ) {

            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'notice',
                Message  => "Invalid remote CI structure found. Skipping item.",
            );

            next CI;
        }

        my @RequiredAttributes = qw(Class DeploymentState IncidentState);
        my %RequiredAttributes;
        for my $Needed ( sort @RequiredAttributes ) {

            if ( !IsStringWithData( $RemoteCIData->{$Needed} ) ) {

                my $NoticeInfo = $RemoteCIData->{Number} ? "Number: $RemoteCIData->{Number};" : '';
                $NoticeInfo .= $RemoteCIData->{Name} ? "Name: $RemoteCIData->{Name};" : '';

                $Kernel::OM->Get('Kernel::System::Log')->Log(
                    Priority => 'notice',
                    Message  => "Missing '$Needed' parameter for creating/updating a CI. Skipping item. $NoticeInfo",
                );

                next CI;
            }

            $RequiredAttributes{$Needed} = $RemoteCIData->{$Needed};
        }

        # get IDs for Class, Depl- and InciState
        for my $CurrentCI ( sort keys %CIClassMapping ) {

            # create/get lookup for general catalog items
            my $GeneralCatalogItem;
            if ( $GeneralCatalogItemLookup{ $CIClassMapping{$CurrentCI} }->{ $RequiredAttributes{$CurrentCI} } ) {
                $GeneralCatalogItem = $GeneralCatalogItemLookup{ $CIClassMapping{$CurrentCI} }->{ $RequiredAttributes{$CurrentCI} };
            }
            else {
                $GeneralCatalogItem = $GeneralCatalogObject->ItemGet(
                    Class => $CIClassMapping{$CurrentCI},
                    Name  => $RequiredAttributes{$CurrentCI},
                );
                if (
                    !IsHashRefWithData($GeneralCatalogItem)
                    || !IsStringWithData( $GeneralCatalogItem->{ItemID} )
                    )
                {

                    return $Self->Error(
                        ErrorMessage =>
                            "Error while looking up $CurrentCI '$RequiredAttributes{$CurrentCI}'.",
                    );
                }

                # add to lookup
                $GeneralCatalogItemLookup{ $CIClassMapping{$CurrentCI} }->{ $RequiredAttributes{$CurrentCI} } = $GeneralCatalogItem;
            }
            $RequiredAttributes{ $CurrentCI . 'ID' } = $GeneralCatalogItem->{ItemID};
        }

        my $Identifier = $InvokerConfig->{ 'Identifier' . $RequiredAttributes{ClassID} };
        if ( !$Identifier ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'notice',
                Message  => "Not importing items in class $RequiredAttributes{Class} - skipping.",
            );

            next CI;
        }

        # check whether this item exists (update) or is new (create)
        my $ConfigItemID;
        my $ConfigItemNumber;

        # prepare search
        my %SearchParam;
        ATTRIBUTE:
        for my $Attribute ( $Identifier->@* ) {
            if ( $Attribute =~ /^Dyn/ ) {
                $SearchParam{$Attribute} = {
                    Equals => $RemoteCIData->{$Attribute},
                };
            }
            elsif ( $Attribute eq 'Classes' ) {
                $SearchParam{Classes} = [ $RemoteCIData->{Class} ];
            }
            elsif ( $Attribute eq 'Name' ) {
                $SearchParam{Name} = $RemoteCIData->{Name};
            }
            elsif ( $Attribute eq 'DeplStates' ) {
                $SearchParam{DeplStates} = [ $RemoteCIData->{DeploymentState} ];
            }
            elsif ( $Attribute eq 'Number' ) {
                $ConfigItemNumber = $RemoteCIData->{Number};

                last ATTRIBUTE;
            }
            elsif ( $Attribute eq 'ConfigItemID' ) {
                my $ConfigItem = $ConfigItemObject->ConfigItemGet(
                    ConfigItemID => $RemoteCIData->{ConfigItemID},
                );

                if ( !$ConfigItem ) {
                    $Kernel::OM->Get('Kernel::System::Log')->Log(
                        Priority => 'notice',
                        Message  => "Not importing items in class $RequiredAttributes{Class} - skipping.",
                    );

                    next CI;
                }

                $ConfigItemID = $RemoteCIData->{ConfigItemID};

                last ATTRIBUTE;
            }
            else {
                $Kernel::OM->Get('Kernel::System::Log')->Log(
                    Priority => 'notice',
                    Message  => "Cannot use $Attribute as Identifier - skipping.",
                );

                next CI;
            }
        }

        # if neither Number nor ID are provided directly, perform a the search
        if ($ConfigItemNumber) {
            $ConfigItemID = $ConfigItemObject->ConfigItemLookup(
                ConfigItemNumber => $RemoteCIData->{Number},
            );
        }
        elsif ( !$ConfigItemID ) {
            my @ConfigItemIDs = $ConfigItemObject->ConfigItemSearch(%SearchParam);

            $ConfigItemID = $ConfigItemIDs[0];

            if ( scalar @ConfigItemIDs > 1 ) {
                my $SearchParameters = join( ';', map {"$_ => $SearchParam{$_}"} keys %SearchParam );

                $Kernel::OM->Get('Kernel::System::Log')->Log(
                    Priority => 'notice',
                    Message  => "Cannot use ambiguos search result - skipping. Parameters: $SearchParameters;",
                );

                next CI;
            }
        }

        my $ClassPreferences = $GeneralCatalogObject->ItemGet(
            Class => 'ITSM::ConfigItem::Class',
            Name  => $$RemoteCIData->{Class},
        );
        my $NameModule = $ClassPreferences->{NameModule} ? $ClassPreferences->{NameModule}[0] : '';
        if ($NameModule) {
            if ( !$NameModuleObjects{ $RemoteCIData->{Class} } ) {

                # check if name module exists
                if ( !$Kernel::OM->Get('Kernel::System::Main')->Require( 'Kernel::System::ITSMConfigItem::Name::' . $NameModule ) ) {
                    $Kernel::OM->Get('Kernel::System::Log')->Log(
                        Priority => 'error',
                        Message  => "Can't load name module for class $RemoteCIData->{Class}!",
                    );

                    next CI;
                }

                # create a backend object
                $NameModuleObjects{ $RemoteCIData->{Class} } = $Kernel::OM->Get( 'Kernel::System::ITSMConfigItem::Name::' . $NameModule );
            }

            if ($ConfigItemID) {
                delete $RemoteCIData->{Name};
            }
            else {
                $RemoteCIData->{Name} = $NameModuleObjects{ $RemoteCIData->{Class} }->ConfigItemNameCreate(
                    $RemoteCIData->%*,
                    %RequiredAttributes,
                    DeplStateID => $RequiredAttributes{DeploymentStateID},
                    InciStateID => $RequiredAttributes{IncidentStateID},
                    UserID      => 1,
                );
            }
        }

        if ( !$ConfigItemID && !$RemoteCIData->{Name} ) {
            my $NoticeInfo = $RemoteCIData->{Number} ? "Number: $RemoteCIData->{Number};" : '';

            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'notice',
                Message  => "Missing 'Name' parameter for creating a CI. Skipping item. $NoticeInfo",
            );

            next CI;
        }

        if ($ConfigItemID) {
            my $Success = $ConfigItemObject->ConfigItemUpdate(
                $RemoteCIData->%*,
                %RequiredAttributes,
                ConfigItemID => $ConfigItemID,
                DeplStateID  => $RequiredAttributes{DeploymentStateID},
                InciStateID  => $RequiredAttributes{IncidentStateID},
                UserID       => 1,
            );

            if ( !$Success ) {
                return $Self->Error(
                    ErrorMessage => "Error while updating ConfigItemID $ConfigItemID!",
                );
            }
        }
        else {
            $ConfigItemID = $ConfigItemObject->ConfigItemAdd(
                $RemoteCIData->%*,
                %RequiredAttributes,
                DeplStateID => $RequiredAttributes{DeploymentStateID},
                InciStateID => $RequiredAttributes{IncidentStateID},
                UserID      => 1,
            );

            if ( !$ConfigItemID ) {
                return $Self->Error(
                    ErrorMessage =>
                        "Error while creating CI with Number '$RequiredAttributes{Name}', Class '$RequiredAttributes{Class}' (ClassID: '$RequiredAttributes{ClassID}').",
                );
            }
        }
    }

    return $Self->Success(
        Data => $Param{Data},
    );
}

=item Error()

Write error message to OTOBO log and return exit structure.

    my $ExitStructure = $CommonObject->Error(
        ErrorMessage    => 'an error message',
    );

returns

    $ExitStructure = {
        Success      => 0,
        ErrorMessage => 'an error message',
    };

=cut

sub Error {
    my ( $Self, %Param ) = @_;

    $Kernel::OM->Get('Kernel::System::Log')->Log(
        Priority => 'error',
        Message  => "Error in '" . $Self->{Invoker}
            . "' Invoker (WebserviceID: " . $Self->{WebserviceID} . "):"
            . $Param{ErrorMessage},
    );

    return {
        Success      => 0,
        ErrorMessage => $Param{ErrorMessage},
    };
}

=item Success()

Write LastRunTimestamp cache entry and return exit structure.

    my $ExitStructure = $CommonObject->Success(
        Data => $ReturnData,
    );

returns

    $ExitStructure = {
        Success => 1,
        Data    => $ReturnData,
    };

=cut

sub Success {
    my ( $Self, %Param ) = @_;

    my $LastRunTimestamp = $Kernel::OM->Create('Kernel::System::DateTime')->ToString();

    $Kernel::OM->Get('Kernel::System::Cache')->Set(
        Key   => 'GenericInterface::ITSM::ConfigItem::' . $Self->{Invoker} . '::LastRunTimestamp',
        Value => $LastRunTimestamp,
        Type  => 'ITSMChangeItemWebservice' . $Self->{WebserviceID},
        TTL   => 60 * 60 * 24 * 7,
    );

    # log completion
    $Self->{DebuggerObject}->Debug(
        Summary => 'Successfully completed.',
    );

    return {
        Success => 1,
        Data    => $Param{Data},
    };
}

1;

=back

=head1 TERMS AND CONDITIONS

This software is part of the OTOBO project (L<https://otobo.org/>).

This software comes with ABSOLUTELY NO WARRANTY. For details, see
the enclosed file COPYING for license information (GPL). If you
did not receive this file, see L<https://www.gnu.org/licenses/gpl-3.0.txt>.

=cut

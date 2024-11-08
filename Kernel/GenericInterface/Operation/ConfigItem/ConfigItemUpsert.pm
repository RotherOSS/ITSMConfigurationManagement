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

package Kernel::GenericInterface::Operation::ConfigItem::ConfigItemUpsert;

use v5.24;
use strict;
use warnings;
use namespace::autoclean;
use utf8;

use parent qw(Kernel::GenericInterface::Operation::ConfigItem::Common);

# core modules
use Scalar::Util qw(reftype);

# CPAN modules

# OTOBO modules
use Kernel::System::VariableCheck qw(:all);

our $ObjectManagerDisabled = 1;

=head1 NAME

Kernel::GenericInterface::Operation::ConfigItem::ConfigItemUpsert - GenericInterface Configuration Item Add and Update Operation backend

=head1 PUBLIC INTERFACE

=head2 new()

usually, you want to create an instance of this
by using Kernel::GenericInterface::Operation->new();

=cut

sub new {
    my ( $Type, %Param ) = @_;

    my $Self = {};
    bless( $Self, $Type );

    # check needed objects
    for my $Needed (qw( Operation DebuggerObject WebserviceID )) {
        if ( !$Param{$Needed} ) {
            return {
                Success      => 0,
                ErrorMessage => "Got no $Needed!",
            };
        }

        $Self->{$Needed} = $Param{$Needed};
    }

    $Self->{OperationName} = 'ConfigItemUpsert';

    $Self->{Config} = $Kernel::OM->Get('Kernel::Config')->Get("GenericInterface::Operation::$Self->{OperationName}");

    return $Self;
}

=head2 Run()

perform ConfigItemUpsert Operation. This function is able to accept
one or more ConfigItem entries in one call.

    my $Result = $OperationObject->Run(
        Data => {
            UserLogin  => 'some agent login',                            # UserLogin or SessionID is
            SessionID  => 123,                                           #   required
            Password   => 'some password',                               # if UserLogin is sent then Password is required
            ConfigItem => [                                              # required
                { ... },
                ...
            ]
        },
    );

    $Result = {
        Success      => 1,                                # 0 or 1
        ErrorMessage => '',                               # In case of an error
        Data         => {
            ConfigItem => [
                {
                    Number             => '20101027000001',
                    ConfigItemID       => 123,
                },
                {
                    # . . .
                },
            ],
        },
    };

=cut

sub Run {
    my ( $Self, %Param ) = @_;

    my $Result = $Self->Init(
        WebserviceID => $Self->{WebserviceID},
    );

    if ( !$Result->{Success} ) {
        $Self->ReturnError(
            ErrorCode    => 'Webservice.InvalidConfiguration',
            ErrorMessage => $Result->{ErrorMessage},
        );
    }

    my ($UserID) = $Self->Auth(
        %Param
    );

    if ( !$UserID ) {
        return $Self->ReturnError(
            ErrorCode    => "$Self->{OperationName}.AuthFail",
            ErrorMessage => "$Self->{OperationName}: Authorization failing!",
        );
    }

    # check needed stuff
    for my $Needed (qw(ConfigItem)) {
        if ( !$Param{Data}->{$Needed} ) {
            return $Self->ReturnError(
                ErrorCode    => "$Self->{OperationName}.MissingParameter",
                ErrorMessage => "$Self->{OperationName}: $Needed parameter is missing!",
            );
        }
    }

    # check optional array/hashes
    for my $Optional (qw(DynamicField Attachment)) {
        if (
            defined $Param{Data}->{$Optional}
            && !IsHashRefWithData( $Param{Data}->{$Optional} )
            && !IsArrayRefWithData( $Param{Data}->{$Optional} )
            )
        {
            return $Self->ReturnError(
                ErrorCode    => "$Self->{OperationName}.MissingParameter",
                ErrorMessage => "$Self->{OperationName}: $Optional parameter is missing or not valid!",
            );
        }
    }

    my $ErrorMessage = '';

    # transform single CIs to an array reference
    if ( !IsArrayRefWithData( $Param{Data}{ConfigItem} ) ) {
        $Param{Data}{ConfigItem} = [ $Param{Data}{ConfigItem} ];
    }

    for my $RemoteCIData ( @{ $Param{Data}{ConfigItem} } ) {
        if ( !IsHashRefWithData($RemoteCIData) ) {
            return $Self->ReturnError(
                ErrorCode    => "$Self->{OperationName}.WrongStructure",
                ErrorMessage => "$Self->{OperationName}: Structure for ConfigItem is not correct!",
            );
        }

        my @RequiredAttributes = qw(Class DeploymentState IncidentState);
        for my $Needed ( sort @RequiredAttributes ) {

            if ( !IsStringWithData( $RemoteCIData->{$Needed} ) ) {
                return $Self->ReturnError(
                    ErrorCode    => "$Self->{OperationName}.MissingParameter",
                    ErrorMessage => "$Self->{OperationName}: Need $Needed for every ConfigItem!",
                );
            }
        }
    }

    # get webservice configuration
    my $Webservice = $Kernel::OM->Get('Kernel::System::GenericInterface::Webservice')->WebserviceGet(
        ID => $Self->{WebserviceID},
    );

    # get operation config
    my $OperationConfig = $Webservice->{Config}->{Provider}->{Operation}->{ $Self->{Operation} };

    my $ConfigItemObject     = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');
    my $GeneralCatalogObject = $Kernel::OM->Get('Kernel::System::GeneralCatalog');

    my %CIClassMapping = (
        IncidentState   => 'ITSM::Core::IncidentState',
        DeploymentState => 'ITSM::ConfigItem::DeploymentState',
        Class           => 'ITSM::ConfigItem::Class',
    );

    my %GeneralCatalogItemLookup;
    my @CIsHandled;
    CI:
    for my $RemoteCIData ( @{ $Param{Data}{ConfigItem} } ) {

        if ( !IsHashRefWithData($RemoteCIData) ) {

            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'notice',
                Message  => "Invalid remote CI structure found. Skipping item.",
            );

            next CI;
        }

        my %RequiredAttributes = map { $_ => $RemoteCIData->{$_} } qw(Class DeploymentState IncidentState);

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

        my $Identifier = $OperationConfig->{ 'Identifier' . $RequiredAttributes{ClassID} };
        if ( !$Identifier ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'notice',
                Message  => "Not importing items in class $RequiredAttributes{Class} - skipping.",
            );
            push @CIsHandled, {};

            next CI;
        }

        # check whether this item exists (update) or is new (create)
        my $ConfigItemID;
        my $ConfigItemNumber;

        # prepare search
        my %SearchParam = (
            Result => 'ARRAY',
        );
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
                    push @CIsHandled, {};

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
                push @CIsHandled, {};

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
                push @CIsHandled, {};

                next CI;
            }
        }

        # check permissions
        my $Permission;
        if ($ConfigItemID) {
            $Permission = $ConfigItemObject->Permission(
                Scope  => 'Item',
                ItemID => $ConfigItemID,
                UserID => $UserID,
                Type   => $Self->{Config}->{Permission},
            );
        }
        else {
            $Permission = $ConfigItemObject->Permission(
                Scope   => 'Class',
                ClassID => $RequiredAttributes{ClassID},
                UserID  => $UserID,
                Type    => $Self->{Config}->{Permission},
            );
        }

        if ( !$Permission ) {
            return $Self->ReturnError(
                ErrorCode    => "$Self->{OperationName}.AccessDenied",
                ErrorMessage => "$Self->{OperationName}: Can not write configuration item!",
            );
        }

        my $ClassPreferences = $GeneralCatalogObject->ItemGet(
            Class => 'ITSM::ConfigItem::Class',
            Name  => $RemoteCIData->{Class},
        );

        if ( !$ConfigItemID && !$RemoteCIData->{Name} ) {
            my $NoticeInfo = $RemoteCIData->{Number} ? "Number: $RemoteCIData->{Number};" : '';

            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'notice',
                Message  => "Missing 'Name' parameter for creating a CI. Skipping item. $NoticeInfo",
            );
            push @CIsHandled, {};

            next CI;
        }

        my @AttachmentList;
        if ( defined $RemoteCIData->{Attachment} ) {

            # isolate Attachment parameter
            my $Attachment = $RemoteCIData->{Attachment};

            # homogenate input to array
            if ( ref $Attachment eq 'HASH' ) {
                push @AttachmentList, $Attachment;
            }
            else {
                @AttachmentList = @{$Attachment};
            }

            # check Attachment internal structure
            for my $AttachmentItem (@AttachmentList) {
                if ( !IsHashRefWithData($AttachmentItem) ) {
                    return {
                        ErrorCode    => "$Self->{OperationName}.InvalidParameter",
                        ErrorMessage =>
                            "$Self->{OperationName}: ConfigItem->Attachment parameter is invalid!",
                    };
                }

                # remove leading and trailing spaces
                for my $Attribute ( sort keys $AttachmentItem->%* ) {
                    if ( !reftype $AttachmentItem->{$Attribute} ) {

                        #remove leading spaces
                        $AttachmentItem->{$Attribute} =~ s{\A\s+}{};

                        #remove trailing spaces
                        $AttachmentItem->{$Attribute} =~ s{\s+\z}{};
                    }
                }

                # check Attachment attribute values
                my $AttachmentCheck = $Self->_CheckAttachment(
                    Attachment => $AttachmentItem,
                );

                if ( !$AttachmentCheck->{Success} ) {
                    return $Self->ReturnError( %{$AttachmentCheck} );
                }
            }
        }

        if ($ConfigItemID) {
            my $Success = $ConfigItemObject->ConfigItemUpdate(
                $RemoteCIData->%*,
                %RequiredAttributes,
                ConfigItemID   => $ConfigItemID,
                DeplStateID    => $RequiredAttributes{DeploymentStateID},
                InciStateID    => $RequiredAttributes{IncidentStateID},
                UserID         => $UserID,
                ExternalSource => 1,
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
                DeplStateID    => $RequiredAttributes{DeploymentStateID},
                InciStateID    => $RequiredAttributes{IncidentStateID},
                UserID         => $UserID,
                ExternalSource => 1,
            );

            if ( !$ConfigItemID ) {
                return $Self->Error(
                    ErrorMessage =>
                        "Error while creating CI with Name '$RequiredAttributes{Name}', Class '$RequiredAttributes{Class}' (ClassID: '$RequiredAttributes{ClassID}').",
                );
            }
        }

        # handle config item attachments
        if (@AttachmentList) {

            my @ExistingAttachments = $ConfigItemObject->ConfigItemAttachmentList(
                ConfigItemID => $ConfigItemID,
            );

            for my $Filename (@ExistingAttachments) {
                my $DeleteSuccess = $ConfigItemObject->ConfigItemAttachmentDelete(
                    ConfigItemID => $ConfigItemID,
                    Filename     => $Filename,
                    UserID       => $UserID,
                );

                if ( !$DeleteSuccess ) {
                    return $Self->Error(
                        ErrorMessage =>
                            "Error while deleting existing attachment with Name '$Filename' for ConfigItem ID $ConfigItemID.",
                    );
                }
            }

            for my $Attachment (@AttachmentList) {

                # delete all config item attachments

                my $Success = $ConfigItemObject->ConfigItemAttachmentAdd(
                    $Attachment->%*,
                    ConfigItemID => $ConfigItemID,
                    UserID       => $UserID,
                );

                if ( !$Success ) {
                    return $Self->Error(
                        ErrorMessage =>
                            "Error while adding attachment with Name '$Attachment->{Filename}' for ConfigItem ID $ConfigItemID.",
                    );
                }
            }
        }

        push @CIsHandled, {
            ConfigItemID => $ConfigItemID,
            Name         => $RequiredAttributes{Name},
        };
    }

    return {
        Success => 1,
        Data    => { ConfigItem => \@CIsHandled },
    };
}

1;

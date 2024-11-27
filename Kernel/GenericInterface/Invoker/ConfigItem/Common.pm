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

package Kernel::GenericInterface::Invoker::ConfigItem::Common;

use v5.24;
use strict;
use warnings;

# core modules
use MIME::Base64 qw(encode_base64);
use Storable     qw(dclone);

# CPAN modules

# OTOBO modules
use Kernel::System::VariableCheck qw(:all);

our $ObjectManagerDisabled = 1;

=head1 NAME

Kernel::GenericInterface::Invoker::ConfigItem::Common - common Invoker functions

=head1 DESCRIPTION

All common functions for ConfigItems.

=head1 PUBLIC INTERFACE

=head2 new()

create an object

    use Kernel::GenericInterface::Invoker::ConfigItem::Common;

    my $ConfigItemCommonObject = Kernel::GenericInterface::Invoker::ConfigItem::Common->new(
        DebuggerObject     => $DebuggerObject,
        Invoker            => 'ConfigItemCreate', # example
    );

=cut

sub new {
    my ( $Type, %Param ) = @_;

    my $Self = bless {}, $Type;

    # check needed objects
    for my $Needed (qw( DebuggerObject Invoker WebserviceID )) {
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

=head2 PrepareRequest()

prepare the invocation of the configured remote web-service.

    my $Result = $InvokerObject->PrepareRequest(
        Data => {                                               # data payload
            ConfigItemID => 123,
        },
    );

Result example:

    {
        Data => {
            ConfigItem => {
                Class                  => 'CIClass',
                ClassID                => 1,
                ConfigItemID           => 123,
                DeplState              => 'Production',
                DeplStateID            => 2,
                DeplStateType          => 'productive',
                Description            => 'Some description',
                DynamicField_FieldName => 'DFValue',
                InciState              => 'Operational',
                InciStateID            => 1,
                InciStateType          => 'operational',
                LastVersionID          => 1,
                Name                   => 'ConfigItemName',
                Number                 => 456,
                VersionID              => 1,
                VersionString          => 1,
            },
        },
    };

=cut

sub PrepareRequest {
    my ( $Self, %Param ) = @_;

    my $ConfigItemObject = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');

    # check needed stuff
    if ( !IsHashRefWithData( $Param{Data} ) ) {
        return $Self->ReturnError(
            ErrorCode    => 'ConfigItem.MissingData',
            ErrorMessage => $Self->{Invoker} . ": The request data is invalid!",
        );
    }

    if ( !$Param{Data}{ConfigItemID} ) {
        return $Self->ReturnError(
            ErrorCode    => 'ConfigItem.MissingConfigItemID',
            ErrorMessage => $Self->{Invoker} . ": ConfigItemID is required!",
        );
    }

    # check ConfigItemID
    my $ConfigItemID = $Param{Data}{ConfigItemID};

    if ( !$ConfigItemID ) {
        return $Self->ReturnError(
            ErrorCode    => 'ConfigItem.MissingConfigItemID',
            ErrorMessage => $Self->{Invoker} . ": User does not have access to the config item!",
        );
    }

    my $ConfigItemData = $ConfigItemObject->ConfigItemGet(
        ConfigItemID  => $ConfigItemID,
        DynamicFields => 1,
        UserID        => 1,
    );

    if ( !IsHashRefWithData($ConfigItemData) ) {
        return $Self->ReturnError(
            ErrorCode    => 'ConfigItem.AccessDenied',
            ErrorMessage => $Self->{Invoker} . ": User does not have access to the config item!",
        );
    }

    my @AttachmentData;
    my @ConfigItemAttachmentList = $ConfigItemObject->ConfigItemAttachmentList(
        ConfigItemID => $ConfigItemID,
    );

    ATTACHMENT:
    for my $Filename (@ConfigItemAttachmentList) {
        next ATTACHMENT if !$Filename;
        my $Attachment = $ConfigItemObject->ConfigItemAttachmentGet(
            ConfigItemID  => $ConfigItemID,
            Filename      => $Filename,
            UserID        => 1,
            OnlyMyBackend => 1,
        );

        next ATTACHMENT if !IsHashRefWithData($Attachment);

        # use 'utf8' instead of 'utf-8'
        # because Operation TicketCreate/TicketUpdate
        # currently does not accept 'utf-8'
        $Attachment->{ContentType} =~ s{utf-8}{utf8};

        # convert content to base64
        $Attachment->{Content} = encode_base64( $Attachment->{Content} );

        $Attachment->{Filename} = $Filename;
        $Attachment->{MimeType} = $Attachment->{ContentType};
        $Attachment->{MimeType} =~ s{ [,;] [ ]* charset= .+ \z }{}xmsi;

        # remove empty attributes
        ATTRIBUTE:
        for my $Attribute ( sort keys $Attachment->%* ) {
            next ATTRIBUTE if $Attribute eq 'ContentType';
            next ATTRIBUTE if $Attribute eq 'Content';
            next ATTRIBUTE if IsStringWithData( $Attachment->{$Attribute} );
            delete $Attachment->{$Attribute};
        }

        push @AttachmentData, $Attachment;
    }

    # add attachments with old structure
    if ( IsArrayRefWithData( \@AttachmentData ) ) {
        $ConfigItemData->{Attachment} = \@AttachmentData;
    }

    # replace config item values with readable values
    $ConfigItemData = $Self->_TransitionDynamicFieldData(
        ConfigItem => $ConfigItemData,
    );

    $Self->{RequestData} = \%Param;

    return {
        Success => 1,
        Data    => $ConfigItemData,
    };
}

=head2 HandleResponse()

handle response data of the configured remote web-service.

    my $Result = $InvokerObject->HandleResponse(
        ResponseSuccess      => 1,              # success status of the remote web-service
        ResponseErrorMessage => '',             # in case of web-service error
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
    if ( !$Param{ResponseSuccess} && !$Param{Data} ) {
        if ( !IsStringWithData( $Param{ResponseErrorMessage} ) ) {
            return $Self->ReturnError(
                ErrorCode    => 'ConfigItem.ResponseError',
                ErrorMessage => $Self->{Invoker}
                    . ": Got response error, but no response error message!",
            );
        }
        return {
            Success      => 0,
            ErrorMessage => $Param{ResponseErrorMessage},
        };
    }

    return {
        Success => 1,
        Data    => $Param{Data},
    };
}

=head2 ReturnError()

helper function to return an error message.

    my $Return = $CommonObject->ReturnError(
        ErrorCode    => ConfigItem.AccessDenied,
        ErrorMessage => 'You dont have rights to access this ticket',
    );

=cut

sub ReturnError {
    my ( $Self, %Param ) = @_;

    $Self->{DebuggerObject}->Error(
        Summary => $Param{ErrorCode},
        Data    => $Param{ErrorMessage},
    );

    # return structure
    return {
        Success      => 0,
        ErrorMessage => "$Param{ErrorCode}: $Param{ErrorMessage}",
        Data         => {
            Error => {
                ErrorCode    => $Param{ErrorCode},
                ErrorMessage => $Param{ErrorMessage},
            },
        },
    };
}

sub _TransitionDynamicFieldData {
    my ( $Self, %Param ) = @_;

    return () if !IsHashRefWithData( $Param{ConfigItem} );

    my %ConfigItemData = (
        $Param{ConfigItem}->%*,
    );

    my $DynamicFieldObject        = $Kernel::OM->Get('Kernel::System::DynamicField');
    my $DynamicFieldBackendObject = $Kernel::OM->Get('Kernel::System::DynamicField::Backend');

    KEY:
    for my $Key ( sort keys %ConfigItemData ) {

        next KEY unless $ConfigItemData{$Key};

        if ( $Key =~ /^DynamicField_(.*)$/ ) {
            my $FieldName   = $1;
            my $FieldConfig = $DynamicFieldObject->DynamicFieldGet(
                Name => $FieldName,
            );

            my $ReadableValue = $DynamicFieldBackendObject->ReadableValueRender(
                DynamicFieldConfig => $FieldConfig,
                Value              => $Param{ConfigItem}{$Key},
            );

            if ( IsHashRefWithData($ReadableValue) ) {
                $ConfigItemData{$Key} = $ReadableValue->{Value};
            }
        }
    }

    return \%ConfigItemData;
}

1;

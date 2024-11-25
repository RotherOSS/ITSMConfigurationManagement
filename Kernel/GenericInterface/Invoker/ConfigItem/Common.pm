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
                ConfigItemID           => 123,
                Name                   => 'ConfigItemName',
                Number                 => 456,
                ClassID                => 1,
                DeplState              => 2,
                InciState              => 3,
                VersionString          => '04',
                DynamicField_FieldName => 'DFValue',
            },
        },
    };

=cut

sub PrepareRequest {
    my ( $Self, %Param ) = @_;

    # TODO: Add Authentification for Request:
    # UserLogin
    # CustomerUserLogin
    # SessionID
    # Password

    my $ConfigItemObject = $Kernel::OM->Get('Kernel::System::ConfigItem');

    # check needed stuff
    if ( !IsHashRefWithData( $Param{Data} ) ) {
        return $Self->ReturnError(
            ErrorCode    => 'ConfigItem.MissingData',
            ErrorMessage => $Self->{Invoker} . ": The request data is invalid!",
        );
    }

    if ( !$Param{Data}{ConfigItemID} && !$Param{Data}{Number} ) {
        return $Self->ReturnError(
            ErrorCode    => 'ConfigItem.MissingConfigItemNumber',
            ErrorMessage => $Self->{Invoker} . ": ConfigItemID or Number is required!",
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

    my %ConfigItemData = $ConfigItemObject->ConfigItemGet(
        ConfigItemID  => $ConfigItemID,
        DynamicFields => 0,
        UserID        => 1,
    );

    if ( !IsHashRefWithData( \%ConfigItemData ) ) {
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
        $ConfigItemData{Attachment} = \@AttachmentData;
    }

    # prepare return data
    my %ReturnData = (
        ConfigItemID => $ConfigItemData{ConfigItemID},
        Number       => $ConfigItemData{Number},
        ConfigItem   => \%ConfigItemData,
    );

    $Self->{RequestData} = \%Param;

    return {
        Success => 1,
        Data    => \%ReturnData,
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

    my $ConfigObject              = $Kernel::OM->Get('Kernel::Config');
    my $DynamicFieldObject        = $Kernel::OM->Get('Kernel::System::DynamicField');
    my $DynamicFieldBackendObject = $Kernel::OM->Get('Kernel::System::DynamicField::Backend');

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

    # get webservice configuration
    my $Webservice = $Kernel::OM->Get('Kernel::System::GenericInterface::Webservice')->WebserviceGet(
        ID => $Self->{WebserviceID},
    );

    # get invoker config
    my $InvokerConfig         = $Webservice->{Config}{Requester}{Invoker}{ $Self->{Invoker} };
    my $SelectedDynamicFields = $InvokerConfig->{DynamicFieldList};

    # get data for dynamic field
    my %DynamicFieldData = $Self->_GenerateDynamicFieldData(
        DynamicFieldNames => $SelectedDynamicFields,
        Data              => $Param{Data},
    );

    # transfer the dynamic field values from response data to the matched local dynamic fields
    if (%DynamicFieldData) {
        for my $DynamicFieldName ( sort keys %DynamicFieldData ) {
            my $DynamicFieldConfig = $DynamicFieldObject->DynamicFieldGet(
                Name => $DynamicFieldName,
            );
            if ( IsHashRefWithData($DynamicFieldConfig) ) {
                if (
                    !IsStringWithData( $DynamicFieldData{$DynamicFieldName} )
                    && !IsArrayRefWithData( $DynamicFieldData{$DynamicFieldName} )
                    )
                {
                    $DynamicFieldData{$DynamicFieldName} = '';
                }

                my $Success = $DynamicFieldBackendObject->ValueSet(
                    DynamicFieldConfig => $DynamicFieldConfig,
                    ObjectID           => $Self->{RequestData}{Data}{ConfigItemID},
                    Value              => $DynamicFieldData{$DynamicFieldName},
                    ExternalSource     => 1,
                    UserID             => 1,
                );

                if ( !$Success ) {
                    $Kernel::OM->Get('Kernel::System::Log')->Log(
                        Priority => 'error',
                        Message  => $Self->{Invoker}
                            . ": Can\'t set response values for dynamic field!",
                    );
                }
            }
            else {
                $Kernel::OM->Get('Kernel::System::Log')->Log(
                    Priority => 'error',
                    Message  => $Self->{Invoker}
                        . ": Dynamic field for response values not found!",
                );
            }
        }
    }

    # set the config item id from response data to dynamic field
    # use the sysconfig option as fallback
    my $ResponsibleFieldTicketID = $InvokerConfig->{TicketIdToDynamicField};
    if ( !$ResponsibleFieldTicketID ) {
        my $ResponseDynamicFields = $ConfigObject->Get('GenericInterface::Invoker::Settings::ResponseDynamicField');
        if ( IsHashRefWithData($ResponseDynamicFields) ) {

            DYNAMICFIELD:
            for my $Field ( sort keys %{$ResponseDynamicFields} ) {
                next DYNAMICFIELD if $Field != $Self->{WebserviceID};

                $ResponsibleFieldTicketID = $ResponseDynamicFields->{$Field};
                last DYNAMICFIELD;
            }
        }
    }

    if ( IsStringWithData($ResponsibleFieldTicketID) ) {
        my $DynamicFieldConfig = $DynamicFieldObject->DynamicFieldGet(
            Name => $ResponsibleFieldTicketID,
        );

        if (
            IsHashRefWithData($DynamicFieldConfig)
            && IsStringWithData( $Param{Data}{TicketID} )
            )
        {

            my $Success = $DynamicFieldBackendObject->ValueSet(
                DynamicFieldConfig => $DynamicFieldConfig,
                ObjectID           => $Self->{RequestData}{Data}{TicketID},
                Value              => $Param{Data}{TicketID},
                ExternalSource     => 1,
                UserID             => 1,
            );

            if ( !$Success ) {
                return $Self->ReturnError(
                    ErrorCode    => 'TicketCreate.ResponseDynamicFieldValueSet',
                    ErrorMessage => $Self->{Invoker}
                        . ": Can\'t set response values for dynamic field!",
                );
            }
        }
        elsif ( !IsHashRefWithData($DynamicFieldConfig) ) {
            return $Self->ReturnError(
                ErrorCode    => 'TicketCreate.ResponseDynamicFieldValueGet',
                ErrorMessage => $Self->{Invoker}
                    . ": Dynamic field for response values not found!",
            );
        }
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

sub _GenerateDynamicFieldData {
    my ( $Self, %Param ) = @_;

    return () if !IsArrayRefWithData( $Param{DynamicFieldNames} );

    my $DynamicFieldObject = $Kernel::OM->Get('Kernel::System::DynamicField');

    # Compile received data for ticket and article(s) into one uniform structure.
    my @StructureArray;
    STRUCTURE:
    for my $Structure (
        $Param{Data}{ConfigItem},
        )
    {
        if ( IsHashRefWithData($Structure) ) {
            push @StructureArray, dclone($Structure);
        }
        elsif ( IsArrayRefWithData($Structure) ) {
            push @StructureArray, @{ dclone($Structure) };
        }
    }

    # Extract dynamic fields from structure.
    my @ReceivedDynamicFields;
    STRUCTURE:
    for my $Structure (@StructureArray) {
        if ( IsHashRefWithData( $Structure->{DynamicField} ) ) {
            push @ReceivedDynamicFields, $Structure->{DynamicField};
        }
        elsif ( IsArrayRefWithData( $Structure->{DynamicField} ) ) {
            push @ReceivedDynamicFields, @{ $Structure->{DynamicField} };
        }
    }

    # Get values for configured dynamic fields from received data.
    my %DynamicFieldData;
    DYNAMICFIELDNAME:
    for my $DynamicField ( @{ $Param{DynamicFieldNames} } ) {
        my $DynamicFieldConfig = $DynamicFieldObject->DynamicFieldGet(
            Name => $DynamicField,
        );
        next DYNAMICFIELDNAME if !IsHashRefWithData($DynamicFieldConfig);

        my $DynamicFieldName = $DynamicFieldConfig->{Name};

        my @MatchedFields = grep { $_->{Name} eq $DynamicFieldName } @ReceivedDynamicFields;
        next DYNAMICFIELDNAME if !@MatchedFields;

        # Should we have more than one match (e.g. ArticleDynamicField in more than one received article), the first one wins.
        $DynamicFieldData{$DynamicFieldName} = $MatchedFields[0]{Value};
    }

    return %DynamicFieldData;
}

1;

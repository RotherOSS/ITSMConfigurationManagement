# --
# OTOBO is a web-based ticketing system for service organisations.
# --
# Copyright (C) 2001-2020 OTRS AG, https://otrs.com/
# Copyright (C) 2019-2022 Rother OSS GmbH, https://otobo.de/
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

package Kernel::System::ProcessManagement::TransitionAction::ConfigItemCreate;

use strict;
use warnings;
use utf8;

use Kernel::System::VariableCheck qw(:all);

use parent qw(Kernel::System::ProcessManagement::TransitionAction::Base);

our @ObjectDependencies = (
    'Kernel::Config',
    'Kernel::System::DynamicField',
    'Kernel::System::DynamicField::Backend',
    'Kernel::System::LinkObject',
    'Kernel::System::Log',
    'Kernel::System::State',
    'Kernel::System::Ticket',
    'Kernel::System::Ticket::Article',
    'Kernel::System::DateTime',
    'Kernel::System::User',
);

=head1 NAME

Kernel::System::ProcessManagement::TransitionAction::ConfigItemCreate - A module to create a ITSM ConfigItem

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
            Key   => 'Number',
            Value => 'A configitem number',
            Optional => 1,
        },
        {
            Key   => 'Class',
            Value => 'Config Item Class (required)',
        },
        {
            Key      => 'Name',
            Value    => 'The Name (required)',
        },
        {
            Key      => 'DeplState',
            Value    => 'Deployment state (required)',
        },
        {
            Key   => 'InciState',
            Value => 'Incident state (required)',
        },
        {
            Key   => 'CIXMLData->Key1',
            Value => 'Value1',
            Optional => 1,
        },
        {
            Key   => 'CIXMLData->Key2',
            Value => 'Value2',
            Optional => 1,
        },
        {
            Key   => 'CIXMLData->Key3',
            Value => 'Value3',
            Optional => 1,
        },
        {
            Key   => 'CIXMLData->Key4',
            Value => 'Value4',
            Optional => 1,
        },
        {
            Key   => 'CIXMLData->Key5',
            Value => 'Value5',
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

    perform ConfigItemCreate Operation. This will return the created config item number.

    my $Result = $OperationObject->Run(
        Data => {
            UserLogin         => 'some agent login',        # UserLogin or SessionID is
                                                            #   required
            SessionID         => 123,

            Password  => 'some password',                   # if UserLogin is sent then
                                                            #   Password is required
            ConfigItem => {
                Number       => '111',                      # optional
                Class        => 'Config Item Class',
                Name         => 'The Name',
                DeplState    => 'deployment state',
                InciState    => 'incident state',
                CIXMLData    => $ArrayHashRef,              # it depends on the Configuration Item class and definition

                Attachment => [
                    {
                        Content     => 'content'            # base64 encoded
                        ContentType => 'some content type'
                        Filename    => 'some fine name'
                    },
                    # ...
                ],
                #or
                #Attachment => {
                #    Content     => 'content'
                #    ContentType => 'some content type'
                #    Filename    => 'some fine name'
                #},
            },
        },
    );

    $Result = {
        Success         => 1,                       # 0 or 1
        ErrorMessage    => '',                      # in case of error
        Data            => {                        # result data payload after Operation
            ConfigItemID => 123,                    # Configuration Item  ID number in OTOBO::ITSM (Service desk system)
            Number       => 2324454323322           # Configuration Item  Number in OTOBO::ITSM (Service desk system)
            Error => {                              # should not return errors
                    ErrorCode    => 'ConfigItemCreate.ErrorCode'
                    ErrorMessage => 'Error Description'
            },
        },
    };

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

    my %CIXMLData;

    CIXMLDATA:
    # CIXMLData is not mandatory, but it must be HashRef if exists.
    for my $Key (keys %Param) {
        next CIXMLDATA if $Key !~ m/^CIXMLData.*$/;

        my $CIXMLKey = split("CIXMLData->", $Key);
        my $CIXMLValue = $Param{$Key};

        $CIXMLData{$CIXMLKey} = $CIXMLValue;
    }
        
    if ( !IsHashRefWithData( \%CIXMLData ) ) {
        return $Self->ReturnError(
            ErrorCode    => "$Self->{OperationName}.MissingParameter",
            ErrorMessage => "$Self->{OperationName}: ConfigItem->CIXMLData is missing or invalid!",
        );
    }


    return 1;
}

=head2 _CheckConfigItem()

checks if the given config item parameters are valid.

    my $ConfigItemCheck = $OperationObject->_CheckConfigItem(
        ConfigItem => $ConfigItem,                  # all config item parameters
    );

    returns:

    $ConfigItemCheck = {
        Success => 1,                               # if everything is OK
    }

    $ConfigItemCheck = {
        ErrorCode    => 'Function.Error',           # if error
        ErrorMessage => 'Error description',
    }

=cut

sub _CheckConfigItem {
    my ( $Self, %Param ) = @_;

    my $ConfigItem = $Param{ConfigItem};

    # check config item internally
    for my $Needed (qw(Class Name DeplState InciState)) {
        if ( !$ConfigItem->{$Needed} ) {
            return {
                ErrorCode    => "$Self->{OperationName}.MissingParameter",
                ErrorMessage => "$Self->{OperationName}: ConfigItem->$Needed parameter is missing!",
            };
        }
    }

    # check ConfigItem->Class
    if ( !$Self->ValidateClass( %{$ConfigItem} ) ) {
        return {
            ErrorCode => "$Self->{OperationName}.InvalidParameter",
            ErrorMessage =>
                "$Self->{OperationName}: ConfigItem->Class parameter is invalid!",
        };
    }

    # check ConfigItem->DeplState
    if ( !$Self->ValidateDeplState( %{$ConfigItem} ) ) {
        return {
            ErrorCode => "$Self->{OperationName}.InvalidParameter",
            ErrorMessage =>
                "$Self->{OperationName}: ConfigItem->DeplState parameter is invalid!",
        };
    }

    # check ConfigItem->DeplState
    if ( !$Self->ValidateInciState( %{$ConfigItem} ) ) {
        return {
            ErrorCode => "$Self->{OperationName}.InvalidParameter",
            ErrorMessage =>
                "$Self->{OperationName}: ConfigItem->InciState parameter is invalid!",
        };
    }

    # get last config item defintion
    my $DefinitionData = $Kernel::OM->Get('Kernel::System::ITSMConfigItem')->DefinitionGet(
        ClassID => $Self->{ReverseClassList}->{ $ConfigItem->{Class} },
    );

    my $XMLDataCheckResult = $Self->CheckXMLData(
        Definition => $DefinitionData->{DefinitionRef},
        XMLData    => $ConfigItem->{CIXMLData},
    );

    if ( !$XMLDataCheckResult->{Success} ) {
        return $XMLDataCheckResult;
    }

    # if everything is OK then return Success
    return {
        Success => 1,
    };
}

=head2 _CheckAttachment()

checks if the given attachment parameter is valid.

    my $AttachmentCheck = $OperationObject->_CheckAttachment(
        Attachment => $Attachment,                  # all attachment parameters
    );

    returns:

    $AttachmentCheck = {
        Success => 1,                               # if everething is OK
    }

    $AttachmentCheck = {
        ErrorCode    => 'Function.Error',           # if error
        ErrorMessage => 'Error description',
    }

=cut

sub _CheckAttachment {
    my ( $Self, %Param ) = @_;

    my $Attachment = $Param{Attachment};

    # check attachment item internally
    for my $Needed (qw(Content ContentType Filename)) {
        if ( !$Attachment->{$Needed} ) {
            return {
                ErrorCode => "$Self->{OperationName}.MissingParameter",
                ErrorMessage =>
                    "$Self->{OperationName}: Attachment->$Needed parameter is missing!",
            };
        }
    }

    # check Article->ContentType
    if ( $Attachment->{ContentType} ) {

        $Attachment->{ContentType} = lc $Attachment->{ContentType};

        # check Charset part
        my $Charset = '';
        if ( $Attachment->{ContentType} =~ /charset=/i ) {
            $Charset = $Attachment->{ContentType};
            $Charset =~ s/.+?charset=("|'|)(\w+)/$2/gi;
            $Charset =~ s/"|'//g;
            $Charset =~ s/(.+?);.*/$1/g;
        }

        if ( $Charset && !$Self->ValidateCharset( Charset => $Charset ) )
        {
            return {
                ErrorCode    => "$Self->{OperationName}.InvalidParameter",
                ErrorMessage => "$Self->{OperationName}: Attachment->ContentType is invalid!",
            };
        }

        # check MimeType part
        my $MimeType = '';
        if ( $Attachment->{ContentType} =~ /^(\w+\/\w+)/i ) {
            $MimeType = $1;
            $MimeType =~ s/"|'//g;
        }

        if ( !$Self->ValidateMimeType( MimeType => $MimeType ) ) {
            return {
                ErrorCode    => "$Self->{OperationName}.InvalidParameter",
                ErrorMessage => "$Self->{OperationName}: Attachment->ContentType is invalid!",
            };
        }
    }

    # if everything is OK then return Success
    return {
        Success => 1,
    };
}

=head2 _ConfigItemCreate()

creates a configuration item with attachments if specified.

    my $Response = $OperationObject->_ConfigItemCreate(
        ConfigItem     => $ConfigItem,             # all configuration item parameters
        AttachmentList => $Attachment,             # a list of all attachments
        UserID         => 123,
    );

    returns:

    $Response = {
        Success => 1,                               # if everething is OK
        Data => {
            ConfigItemID => 123,
            ConfigItemNumber => 'CN123',
        }
    }

    $Response = {
        Success      => 0,                         # if unexpected error
        ErrorMessage => "$Param{ErrorCode}: $Param{ErrorMessage}",
    }

=cut

sub _ConfigItemCreate {
    my ( $Self, %Param ) = @_;

    my $ConfigItem     = $Param{ConfigItem};
    my $AttachmentList = $Param{AttachmentList};

    my $DeplStateID = $Self->{ReverseDeplStateList}->{ $ConfigItem->{DeplState} };
    my $InciStateID = $Self->{ReverseInciStateList}->{ $ConfigItem->{InciState} };

    my $RawXMLData = $ConfigItem->{CIXMLData};

    my $ConfigItemObject = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');

    # get last config item defintion
    my $DefinitionData = $ConfigItemObject->DefinitionGet(
        ClassID => $Self->{ReverseClassList}->{ $ConfigItem->{Class} },
    );

    # replace date, date time, customer, company and general catalog values
    my $ReplacedXMLData = $Self->ReplaceXMLData(
        XMLData    => $RawXMLData,
        Definition => $DefinitionData->{DefinitionRef},
    );

    # create an XMLData structure suitable for VersionAdd
    my $XMLData = $Self->FormatXMLData(
        XMLData => $ReplacedXMLData,
    );

    # create new config item
    my $ConfigItemID = $ConfigItemObject->ConfigItemAdd(
        Number  => $ConfigItem->{Number},
        ClassID => $Self->{ReverseClassList}->{ $ConfigItem->{Class} },
        UserID  => $Param{UserID},
    );

    my $VersionID = $ConfigItemObject->VersionAdd(
        ConfigItemID => $ConfigItemID,
        Name         => $ConfigItem->{Name},
        DefinitionID => $DefinitionData->{DefinitionID},
        DeplStateID  => $DeplStateID,
        InciStateID  => $InciStateID,
        XMLData      => $XMLData,
        UserID       => $Param{UserID},
    );

    if ( !$ConfigItemID && !$VersionID ) {
        return {
            Success      => 0,
            ErrorMessage => 'Configuration Item could not be created, please contact the system'
                . 'administrator',
        };
    }

    # set attachments
    if ( IsArrayRefWithData($AttachmentList) ) {

        for my $Attachment ( @{$AttachmentList} ) {
            my $Result = $Self->CreateAttachment(
                Attachment   => $Attachment,
                ConfigItemID => $ConfigItemID,
                UserID       => $Param{UserID},
            );

            if ( !$Result->{Success} ) {
                my $ErrorMessage =
                    $Result->{ErrorMessage} || "Attachment could not be created, please contact"
                    . " the system administrator";

                return {
                    Success      => 0,
                    ErrorMessage => $ErrorMessage,
                };
            }
        }
    }

    # get ConfigItem data
    my $ConfigItemData = $ConfigItemObject->ConfigItemGet(
        ConfigItemID => $ConfigItemID,
    );

    if ( !IsHashRefWithData($ConfigItemData) ) {
        return {
            Success      => 0,
            ErrorMessage => 'Could not get new configuration item information, please contact the'
                . ' system administrator',
        };
    }

    return {
        Success => 1,
        Data    => {
            ConfigItemID => $ConfigItemID,
            Number       => $ConfigItemData->{Number},
        },
    };
}


1;

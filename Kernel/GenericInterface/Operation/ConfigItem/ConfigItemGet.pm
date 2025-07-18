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

package Kernel::GenericInterface::Operation::ConfigItem::ConfigItemGet;

use v5.24;
use strict;
use warnings;
use namespace::autoclean;
use utf8;

use parent qw(Kernel::GenericInterface::Operation::ConfigItem::Common);

# core modules
use MIME::Base64;

# CPAN modules

# OTOBO modules
use Kernel::System::VariableCheck qw(:all);

our $ObjectManagerDisabled = 1;

=head1 NAME

Kernel::GenericInterface::Operation::ConfigItem::ConfigItemGet - GenericInterface Configuration Item Get Operation backend

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
    for my $Needed (qw( DebuggerObject WebserviceID )) {
        if ( !$Param{$Needed} ) {
            return {
                Success      => 0,
                ErrorMessage => "Got no $Needed!",
            };
        }

        $Self->{$Needed} = $Param{$Needed};
    }

    $Self->{OperationName} = 'ConfigItemGet';

    $Self->{Config} = $Kernel::OM->Get('Kernel::Config')->Get('GenericInterface::Operation::ConfigItemGet');

    return $Self;
}

=head2 Run()

perform ConfigItemGet Operation. This function is able to return
one or more ConfigItem entries in one call.

    my $Result = $OperationObject->Run(
        Data => {
            UserLogin         => 'some agent login',                            # UserLogin or SessionID is
            SessionID         => 123,                                           #   required
            Password          => 'some password',                               # if UserLogin is sent then Password is required
            ConfigItemID      => '32,33',                                       # required, could be coma separated IDs or an Array
            Attachments       => 1,                                             # Optional, 1 as default. If it's set with the value 1,
                                                                                # attachments for articles will be included on ConfigItem data
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
                    Name               => 'some name',
                    Class              => 'some class',
                    VersionID          => 123,
                    LastVersionID      => 123,
                    DefinitionID       => 123,
                    InciState          => 'some incident state',
                    InciStateType      => 'some incident state type',
                    DeplState          => 'some deployment state',
                    DeplStateType      => 'some deployment state type',
                    CurInciState       => 'some incident state',
                    CurInciStateType   => 'some incident state type',
                    CurDeplState       => 'some deployment state',
                    CurDeplStateType   => 'some deployment state type',
                    CreateTime         => '2010-10-27 20:15:00'
                    CreateBy           => 123,
                    DynamicField_Name  => $Value,

                    Attachment => [
                        {
                            Content            => "xxxx",     # actual attachment contents, base64 enconded
                            ContentType        => "application/pdf",
                            Filename           => "StdAttachment-Test1.pdf",
                            Filesize           => "4.6 KBytes",
                            Preferences        => $PreferencesHashRef,
                        },
                        {
                           # . . .
                        },
                    ],
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
    for my $Needed (qw(ConfigItemID)) {
        if ( !$Param{Data}->{$Needed} ) {
            return $Self->ReturnError(
                ErrorCode    => "$Self->{OperationName}.MissingParameter",
                ErrorMessage => "$Self->{OperationName}: $Needed parameter is missing!",
            );
        }
    }
    my $ErrorMessage = '';

    # all needed variables
    my @ConfigItemIDs;
    if ( IsStringWithData( $Param{Data}->{ConfigItemID} ) ) {
        @ConfigItemIDs = split( /,/, $Param{Data}->{ConfigItemID} );
    }
    elsif ( IsArrayRefWithData( $Param{Data}->{ConfigItemID} ) ) {
        @ConfigItemIDs = @{ $Param{Data}->{ConfigItemID} };
    }
    else {
        return $Self->ReturnError(
            ErrorCode    => "$Self->{OperationName}.WrongStructure",
            ErrorMessage => "$Self->{OperationName}: Structure for ConfigItemID is not correct!",
        );
    }
    my $Attachments = $Param{Data}->{Attachments} || 0;
    my $ReturnData  = {
        Success => 1,
    };

    my @Item;

    my $ConfigItemObject = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');

    # start ConfigItem loop
    CONFIGITEM:
    for my $ConfigItemID (@ConfigItemIDs) {

        # check create permissions
        my $Permission = $ConfigItemObject->Permission(
            Scope  => 'Item',
            ItemID => $ConfigItemID,
            UserID => $UserID,
            Type   => $Self->{Config}->{Permission},
        );

        if ( !$Permission ) {
            return $Self->ReturnError(
                ErrorCode    => "$Self->{OperationName}.AccessDenied",
                ErrorMessage => "$Self->{OperationName}: Can not get configuration item!",
            );
        }

        # get the latest version of ConfigItem entry
        my $ConfigItem = $ConfigItemObject->ConfigItemGet(
            ConfigItemID  => $ConfigItemID,
            UserID        => $UserID,
            DynamicFields => 1,
        );

        if ( !IsHashRefWithData($ConfigItem) ) {

            $ErrorMessage = 'Could not get ConfigItem data'
                . ' in Kernel::GenericInterface::Operation::ConfigItem::ConfigItemGet::Run()';

            return $Self->ReturnError(
                ErrorCode    => "$Self->{OperationName}.InvalidParameter",
                ErrorMessage => "$Self->{OperationName}: $ErrorMessage",
            );
        }

        # remove unneeded items
        delete $ConfigItem->{ClassID};
        delete $ConfigItem->{CurDeplStateID};
        delete $ConfigItem->{CurInciStateID};
        delete $ConfigItem->{DeplStateID};
        delete $ConfigItem->{InciStateID};
        delete $ConfigItem->{DefinitionID};

        # set ConfigItem entry data
        my $ConfigItemBundle = $ConfigItem;

        if ($Attachments) {

            my @Attachments = $ConfigItemObject->ConfigItemAttachmentList(
                ConfigItemID => $ConfigItemID,
            );

            my @AttachmentDetails;
            ATTACHMENT:
            for my $Filename (@Attachments) {

                next ATTACHMENT if !$Filename;

                my $Attachment = $ConfigItemObject->ConfigItemAttachmentGet(
                    ConfigItemID => $ConfigItemID,
                    Filename     => $Filename,
                );

                # next if not attachment
                next ATTACHMENT if !IsHashRefWithData($Attachment);

                # convert content to base64
                $Attachment->{Content} = encode_base64( $Attachment->{Content} );
                push @AttachmentDetails, $Attachment;
            }

            # set ConfigItem entry data
            $ConfigItemBundle->{Attachment} = '';
            if ( IsArrayRefWithData( \@AttachmentDetails ) ) {
                $ConfigItemBundle->{Attachment} = \@AttachmentDetails;
            }
        }

        # add
        push @Item, $ConfigItemBundle;

    }    # finish ConfigItem loop

    if ( !scalar @Item ) {
        $ErrorMessage = 'Could not get ConfigItem data'
            . ' in Kernel::GenericInterface::Operation::ConfigItem::ConfigItemGet::Run()';

        return $Self->ReturnError(
            ErrorCode    => "$Self->{OperationName}.NoConfigItemData",
            ErrorMessage => "$Self->{OperationName}: $ErrorMessage",
        );
    }

    # set ConfigItem data into return structure
    $ReturnData->{Data}->{ConfigItem} = '';
    if ( IsArrayRefWithData( \@Item ) ) {
        $ReturnData->{Data}->{ConfigItem} = \@Item;
    }

    # return result
    return $ReturnData;
}

1;

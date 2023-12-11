# --
# OTOBO is a web-based ticketing system for service organisations.
# --
# Copyright (C) 2001-2020 OTRS AG, https://otrs.com/
# Copyright (C) 2019-2023 Rother OSS GmbH, https://otobo.de/
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

package Kernel::GenericInterface::Operation::ConfigItem::ConfigItemDelete;

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

Kernel::GenericInterface::Operation::ConfigItem::ConfigItemDelete - GenericInterface Configuration Item Delete Operation backend

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
    for my $Needed (qw(DebuggerObject WebserviceID)) {
        if ( !$Param{$Needed} ) {
            return {
                Success      => 0,
                ErrorMessage => "Got no $Needed!",
            };
        }

        $Self->{$Needed} = $Param{$Needed};
    }

    $Self->{OperationName} = 'ConfigItemDelete';

    $Self->{Config} = $Kernel::OM->Get('Kernel::Config')->Get('GenericInterface::Operation::ConfigItemDelete');

    return $Self;
}

=head2 Run()

perform ConfigItemDelete Operation. This function is able to return
one or more ConfigItem entries in one call.

    my $Result = $OperationObject->Run(
        Data => {
            UserLogin         => 'some agent login',                            # UserLogin or CustomerUserLogin or SessionID is
                                                                                #   required
            CustomerUserLogin => 'some customer login',
            SessionID         => 123,

            Password          => 'some password',                               # if UserLogin or customerUserLogin is sent then
                                                                                #   Password is required
            ConfigItemID      => '32,33',                                       # required, could be coma separated IDs or an Array
        },
    );

    $Result = {
        Success         => 1,                       # 0 or 1
        ErrorMessage    => '',                      # in case of error
        Data            => {                        # result data payload after Operation
            ConfigItemID => [123, 456],         # Configuration Item IDs number in OTOBO::ITSM (Service desk system)
            Error => {                              # should not return errors
                    ErrorCode    => 'ConfigItemDelete.ErrorCode'
                    ErrorMessage => 'Error Description'
            },
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

    my ( $UserID, $UserType ) = $Self->Auth(
        %Param
    );

    if ( !$UserID ) {
        return $Self->ReturnError(
            ErrorCode    => '$Self->{OperationName}.AuthFail',
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
        @ConfigItemIDs = split /\s*,\s*/, $Param{Data}->{ConfigItemID};
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

    my $ConfigItemObject = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');

    my @DeletedConfigItemIDs;

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
                ErrorMessage => "$Self->{OperationName}: Can not delete configuration item!",
            );
        }

        # delete the configitem
        my $DeleteSuccess = $ConfigItemObject->ConfigItemDelete(
            ConfigItemID => $ConfigItemID,
            UserID       => $UserID,
        );

        if ( !$DeleteSuccess ) {

            $ErrorMessage = 'Could not delete ConfigItem ID ' . $ConfigItemID
                . ' in Kernel::GenericInterface::Operation::ConfigItem::ConfigItemDelete::Run()';

            return $Self->ReturnError(
                ErrorCode    => '$Self->{OperationName}.DeleteError',
                ErrorMessage => "$Self->{OperationName}: $ErrorMessage",
            );
        }

        push @DeletedConfigItemIDs, $ConfigItemID;

    }    # finish ConfigItem loop

    if ( !IsArrayRefWithData( \@DeletedConfigItemIDs ) ) {
        return {
            Success      => 0,
            ErrorMessage => 'Could not delete ConfigItems!',
        };
    }

    return {
        Success => 1,
        Data    => {
            ConfigItemID => \@DeletedConfigItemIDs,
        },
    };
}

1;

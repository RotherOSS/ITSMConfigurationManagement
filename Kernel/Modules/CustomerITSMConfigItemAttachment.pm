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

package Kernel::Modules::CustomerITSMConfigItemAttachment;

use strict;
use warnings;
use v5.24;

# core modules

# CPAN modules

# OTOBO modules
use Kernel::System::VariableCheck qw(:all);
use Kernel::Language qw(Translatable);

our $ObjectManagerDisabled = 1;

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    return bless {%Param}, $Type;
}

sub Run {
    my ( $Self, %Param ) = @_;

    # get needed objects
    my $ParamObject  = $Kernel::OM->Get('Kernel::System::Web::Request');
    my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');
    my $LogObject    = $Kernel::OM->Get('Kernel::System::Log');

    # get IDs
    my $ConfigItemID  = $ParamObject->GetParam( Param => 'ConfigItemID' );
    my $Filename    = $ParamObject->GetParam( Param => 'Filename' );

    # check params
    if ( !$Filename || !$ConfigItemID ) {
        my $Output = $LayoutObject->CustomerHeader(
            Title => Translatable('Error'),
        );
        $Output .= $LayoutObject->CustomerError(
            Message => Translatable('Filename and ConfigItemID are needed!'),
            Comment => Translatable('Please contact the administrator.'),
        );
        $LogObject->Log(
            Message  => 'Filename and ConfigItemID are needed!',
            Priority => 'error',
        );
        $Output .= $LayoutObject->CustomerFooter();

        return $Output;
    }

    my $ConfigItemObject = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');

    # check for access rights
    my $HasAccess = $ConfigItemObject->CustomerPermission(
        ConfigItemID => $ConfigItemID,
        UserID       => $Self->{UserID},
    );

    if ( !$HasAccess ) {
        return $LayoutObject->CustomerNoPermission( WithHeader => 'yes' );
    }

    # get an attachment
    my $Data = $ConfigItemObject->ConfigItemAttachmentGet(
        ConfigItemID           => $ConfigItemID,
        Filename               => $Filename,
    );
    if ( !IsHashRefWithData($Data) ) {
        my $Output = $LayoutObject->CustomerHeader(
            Title => Translatable('Error'),
        );
        $Output .= $LayoutObject->CustomerError(
            Message => $LayoutObject->{LanguageObject}->Translate( 'No such attachment (%s)!', $Filename ),
            Comment => Translatable('Please contact the administrator.'),
        );
        $LogObject->Log(
            Message  => "No such attachment ($Filename)! May be an attack!!!",
            Priority => 'error',
        );
        $Output .= $LayoutObject->CustomerFooter();

        return $Output;
    }

    # download it AttachmentDownloadType is configured
    return $LayoutObject->Attachment(
        $Data->%*,
        Sandbox => 1,
    );
}

1;

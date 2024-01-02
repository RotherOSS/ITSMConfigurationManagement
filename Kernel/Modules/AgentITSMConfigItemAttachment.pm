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

package Kernel::Modules::AgentITSMConfigItemAttachment;

## nofilter(TidyAll::Plugin::OTOBO::Perl::Print)

use strict;
use warnings;
use v5.24;

# core modules

# CPAN modules

# OTOBO modules
use Kernel::System::VariableCheck qw(IsHashRefWithData);

our $ObjectManagerDisabled = 1;

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    return bless {%Param}, $Type;
}

sub Run {
    my ( $Self, %Param ) = @_;

    # get config of frontend module
    $Self->{Config} = $Kernel::OM->Get('Kernel::Config')->Get("ITSMConfigItem::Frontend::$Self->{Action}");

    # get needed objects
    my $ParamObject  = $Kernel::OM->Get('Kernel::System::Web::Request');
    my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');
    my $LogObject    = $Kernel::OM->Get('Kernel::System::Log');

    # get IDs
    my $ConfigItemID = $ParamObject->GetParam( Param => 'ConfigItemID' );
    my $Filename       = $ParamObject->GetParam( Param => 'Filename' );

    # check params
    if ( !$Filename || !$ConfigItemID ) {
        $LogObject->Log(
            Message  => 'Filename and ConfigItemID are needed!',
            Priority => 'error',
        );

        return $LayoutObject->ErrorScreen();
    }

    my $ConfigItemObject = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');

    my $ConfigItemNumber = $ConfigItemObject->ConfigItemNumberLookup(
        ConfigItemID => $ConfigItemID,
    );

    # check permissions
    my $ConfigItem = $ConfigItemObject->ConfigItemGet(
        ConfigItemID  => $ConfigItemID,
        DynamicFields => 0,
    );

    # check permissions
    my $HasAccess = $ConfigItemObject->Permission(
        Scope  => 'Item',
        ItemID => $ConfigItem->{ConfigItemID},
        UserID => $Self->{UserID},
        Type   => $Self->{Config}->{Permission},
    );
    if ( !$HasAccess ) {
        return $LayoutObject->NoPermission( WithHeader => 'yes' );
    }

    # Check whether potentially the content should be converted for in browser viewing
    my $ViewerActive = $ParamObject->GetParam( Param => 'Viewer' ) || 0;

    # In most cases we can handle IO-Handle like objects as content.
    # But require a string when the content is possible transformed by a viewer.
    # TODO: check for output filter on AgentITSMConfigItemAttachment or on ALL
    my $ContentMayBeFilehandle = $ViewerActive ? 0 : 1;

    # get an attachment
    my $Data = $ConfigItemObject->ConfigItemAttachmentGet(
        ConfigItemID           => $ConfigItemID,
        Filename               => $Filename,
        ContentMayBeFilehandle => $ContentMayBeFilehandle,
    );
    if ( !IsHashRefWithData($Data) ) {
        $LogObject->Log(
            Message  => "No such attachment ($Filename).",
            Priority => 'error',
        );

        return $LayoutObject->ErrorScreen();
    }

    # find viewer for ContentType
    my $Viewer;
    if ($ViewerActive) {
        my $ConfigObject = $Kernel::OM->Get('Kernel::Config');
        if ( $ConfigObject->Get('MIME-Viewer') ) {
            for ( sort keys $ConfigObject->Get('MIME-Viewer')->%* ) {
                if ( $Data->{ContentType} =~ m/^$_/i ) {
                    $Viewer = $ConfigObject->Get('MIME-Viewer')->{$_};
                    $Viewer =~ s/\<OTOBO_CONFIG_(.+?)\>/$ConfigObject->{$1}/g;
                }
            }
        }
    }

    # show with viewer
    if ($Viewer) {

        # Write temporary file for the HTML generating command.
        # The file will be cleaned up at the end of the current request.
        my $FileTempObject = $Kernel::OM->Get('Kernel::System::FileTemp');
        my ( $FHContent, $FilenameContent ) = $FileTempObject->TempFile();
        print $FHContent $Data->{Content};
        close $FHContent;

        # generate HTML
        my $GeneratedHTML = '';
        if ( open my $ViewerFH, '-|', "$Viewer $FilenameContent" ) {    ## no critic qw(OTOBO::ProhibitOpen)
            while (<$ViewerFH>) {
                $GeneratedHTML .= $_;
            }
            close $ViewerFH;
        }
        else {
            return $LayoutObject->FatalError(
                Message => "Can't open: $Viewer $FilenameContent: $!",
            );
        }

        # return the generated HTML
        return $LayoutObject->Attachment(
            $Data->%*,
            ContentType => 'text/html',
            Content     => $GeneratedHTML,
            Type        => 'inline',
            Sandbox     => 1,
        );
    }

    # download it AttachmentDownloadType is configured
    return $LayoutObject->Attachment(
        $Data->%*,
        Sandbox => 1,
    );
}

1;

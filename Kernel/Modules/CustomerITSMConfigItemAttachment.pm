# --
# OTOBO is a web-based ticketing system for service organisations.
# --
# Copyright (C) 2001-2019 OTRS AG, https://otrs.com/
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

package Kernel::Modules::CustomerITSMConfigItemAttachment;

use strict;
use warnings;
use v5.24;

# core modules

# CPAN modules

# OTOBO modules
use Kernel::Language              qw(Translatable);
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

    # Permission check.
    if ( !$Self->{AccessRo} ) {
        return $LayoutObject->NoPermission(
            Message    => Translatable('You need ro permission!'),
            WithHeader => 'yes',
        );
    }

    # get IDs
    my $ConfigItemID = $ParamObject->GetParam( Param => 'ConfigItemID' );
    my $VersionID    = $ParamObject->GetParam( Param => 'VersionID' );

    # check param
    if ( !$ConfigItemID || !$VersionID ) {
        $LogObject->Log(
            Message  => 'ConfigItemID and VersionID are needed!',
            Priority => 'error',
        );

        return $LayoutObject->ErrorScreen();
    }

    my $ConfigItemObject = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');

    # fetch config item
    my $ConfigItem = $ConfigItemObject->ConfigItemGet(
        VersionID     => $VersionID,
        DynamicFields => 0,
    );

    if ( $ConfigItem->{ConfigItemID} != $ConfigItemID ) {
        $LogObject->Log(
            Message  => 'VersionID does not belong to ConfigItemID!',
            Priority => 'error',
        );

        return $LayoutObject->ErrorScreen();
    }

    # check permissions
    my $HasAccess = $ConfigItemObject->CustomerPermission(
        ConfigItemID => $ConfigItem->{ConfigItemID},
        UserID       => $Self->{UserID},
    );
    if ( !$HasAccess ) {
        return $LayoutObject->CustomerNoPermission( WithHeader => 'yes' );
    }

    my $HTMLUtilsObject = $Kernel::OM->Get('Kernel::System::HTMLUtils');

    # ---------------------------------------------------------- #
    # HTMLView Sub-action
    # ---------------------------------------------------------- #
    if ( $Self->{Subaction} eq 'HTMLView' ) {

        # Get the Field content.
        my $FieldContent = $ConfigItem->{Description};

        # # Build base URL for in-line images.
        # my $SessionID = '';
        # if ( $Self->{SessionID} && !$Self->{SessionIDCookie} ) {
        #     $SessionID = ';' . $Self->{SessionName} . '=' . $Self->{SessionID};
        #     $FieldContent =~ s{
        #         (Action=AgentITSMConfigItemAttachment;Subaction=DownloadAttachment;ConfigItemID=\d+;Filename=\w+)
        #     }{$1$SessionID}gmsx;
        # }

        # fetch config item attachment list for handling inline attachments
        my @AttachmentList = $ConfigItemObject->VersionAttachmentList(
            VersionID => $ConfigItem->{VersionID},
        );

        # fetch attachment data and store in hash for RichTextDocumentServe
        my %Attachments;
        for my $Filename (@AttachmentList) {
            $Attachments{$Filename} = $ConfigItemObject->VersionAttachmentGet(
                VersionID => $ConfigItem->{VersionID},
                Filename  => $Filename,
            );
            $Attachments{$Filename}{ContentID} = $Attachments{$Filename}{Preferences}{ContentID};
        }

        # needed to provide necessary params for RichTextDocumentServe
        my %Data = (
            Content     => $FieldContent,
            ContentType => 'text/html; charset="utf-8"',
            Disposition => 'inline',
        );

        # generate base url
        my $URL = 'Action=' . ( $LayoutObject->{UserType} eq 'User' ? 'Agent' : 'Customer' ) . 'ITSMConfigItemAttachment;Subaction=DownloadAttachment'
            . ";ConfigItemID=$ConfigItem->{ConfigItemID};VersionID=$ConfigItem->{VersionID};Filename=";

        # reformat rich text document to have correct charset and links to
        # inline documents
        %Data = $LayoutObject->RichTextDocumentServe(
            Data               => \%Data,
            URL                => $URL,
            Attachments        => \%Attachments,
            LoadExternalImages => 1,
        );

        $FieldContent = $Data{Content};

        # remove active html content (scripts, applets, etc...)
        my %SafeContent = $HTMLUtilsObject->Safety(
            String       => $FieldContent,
            NoApplet     => 1,
            NoObject     => 1,
            NoEmbed      => 1,
            NoIntSrcLoad => 0,
            NoExtSrcLoad => 0,
            NoJavaScript => 1,
        );

        # take the safe content if neccessary
        if ( $SafeContent{Replace} ) {
            $FieldContent = $SafeContent{String};
        }

        # detect all plain text links and put them into an HTML <a> tag
        $FieldContent = $HTMLUtilsObject->LinkQuote(
            String => $FieldContent,
        );

        # set target="_blank" attribute to all HTML <a> tags
        # the LinkQuote function needs to be called again
        $FieldContent = $HTMLUtilsObject->LinkQuote(
            String    => $FieldContent,
            TargetAdd => 1,
        );

        # add needed HTML headers
        $FieldContent = $HTMLUtilsObject->DocumentComplete(
            String  => $FieldContent,
            Charset => 'utf-8',
        );

        # escape single quotes
        $FieldContent =~ s/'/&#39;/g;

        # Return complete HTML as an attachment.
        return $LayoutObject->Attachment(
            ContentType => 'text/html',
            Content     => $FieldContent,
            Type        => 'inline',
        );
    }

    # ---------------------------------------------------------- #
    # DownloadAttachment Sub-action
    # ---------------------------------------------------------- #
    if ( $Self->{Subaction} eq 'DownloadAttachment' ) {

        my $Filename = $ParamObject->GetParam( Param => 'Filename' );

        # check param
        if ( !$Filename ) {
            $LogObject->Log(
                Message  => 'Filename is needed!',
                Priority => 'error',
            );

            return $LayoutObject->ErrorScreen();
        }

        # get an attachment
        my $Data = $ConfigItemObject->VersionAttachmentGet(
            VersionID => $VersionID,
            Filename  => $Filename,
        );
        if ( !IsHashRefWithData($Data) ) {
            $LogObject->Log(
                Message  => "No such attachment ($Filename).",
                Priority => 'error',
            );

            return $LayoutObject->ErrorScreen();
        }

        if ( IsHashRefWithData($Data) ) {
            return $LayoutObject->Attachment( $Data->%* );
        }
        else {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Message  => "No such attachment ($Filename)! May be an attack!!!",
                Priority => 'error',
            );
            return $LayoutObject->ErrorScreen();
        }
    }

    # No (known) subaction
    return $LayoutObject->ErrorScreen(
        Message => Translatable('Invalid Subaction.'),
    );
}

1;

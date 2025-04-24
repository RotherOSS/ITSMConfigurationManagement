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

package Kernel::Modules::AgentITSMConfigItemTreeView;

use v5.24;
use strict;
use warnings;
use namespace::autoclean;
use utf8;

# core modules

# CPAN modules

# OTOBO modules
use Kernel::Language qw(Translatable);

our $ObjectManagerDisabled = 1;

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    return bless {%Param}, $Type;
}

sub Run {
    my ( $Self, %Param ) = @_;

    my $ParamObject      = $Kernel::OM->Get('Kernel::System::Web::Request');
    my $LayoutObject     = $Kernel::OM->Get('Kernel::Output::HTML::Layout');
    my $ConfigItemObject = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');

    # get needed parameters,
    # only the VersionID is needed as the VersionID determines the ConfigItemID
    my %GetParam;
    for my $Needed (qw(VersionID)) {
        $GetParam{$Needed} //= $ParamObject->GetParam( Param => $Needed );
        if ( !$GetParam{$Needed} ) {
            return $LayoutObject->ErrorScreen(
                Message => $LayoutObject->{LanguageObject}->Translate( 'Need %s', $Needed ),
                Comment => Translatable('Please contact the administrator.'),
            );
        }
    }

    my $VersionID    = $GetParam{VersionID};
    my $ConfigItemID = $ConfigItemObject->VersionConfigItemIDGet( VersionID => $VersionID );

    # check permissions
    my $FrontendConfig = $Kernel::OM->Get('Kernel::Config')->Get("ITSMConfigItem::Frontend::$Self->{Action}");
    my $Access         = $ConfigItemObject->Permission(
        Type   => $FrontendConfig->{Permission},
        Scope  => 'Item',
        Action => $Self->{Action},
        ItemID => $ConfigItemID,
        UserID => $Self->{UserID},
    );

    # error screen
    return $LayoutObject->NoPermission(
        Message    => $LayoutObject->{LanguageObject}->Translate( 'You need %s permissions!', $FrontendConfig->{Permission} ),
        WithHeader => 'yes',
    ) unless $Access;

    my $Depth = $ParamObject->GetParam( Param => 'Depth' )
        ||
        $Kernel::OM->Get('Kernel::Config')->Get("CMDBTreeView::DefaultDepth")
        ||
        1;

    if ( $Self->{Subaction} eq 'LoadTreeView' ) {

        # the HTML contains the information for drawing the graph
        my $CanvasHTML = $LayoutObject->GenerateHierarchyGraph(
            Depth        => $Depth,
            ConfigItemID => $ConfigItemID,
            VersionID    => $VersionID,
            SessionID    => $Self->{SessionID}
        );

        return $LayoutObject->Attachment(
            ContentType => 'text/html',
            Content     => $CanvasHTML,
            Type        => 'inline',
            NoCache     => 1,
        );
    }

    # get name and number for the latest version of the config item
    my $ConfigItem = $ConfigItemObject->ConfigItemGet(
        ConfigItemID => $ConfigItemID,
        Cache        => 1,
    );

    # The actual tree will be written later into the div with the ID 'Canvas'.
    # The information for drawing the graph will be fetched with 'LoadTreeView'.
    # See var/httpd/htdocs/js/Core.Agent.TreeView.js for the function UpdateTree().
    return join '',
        $LayoutObject->Header(
            Type      => 'Small',
            BodyClass => 'Popup',
        ),
        $LayoutObject->Output(
            TemplateFile => 'AgentITSMConfigItemTreeView',
            Data         => {
                %Param,
                ConfigItemID     => $ConfigItemID,
                VersionID        => $VersionID,
                ConfigItemName   => $ConfigItem->{Name},
                ConfigItemNumber => $ConfigItem->{Number},
                Depth            => $Depth,
                SessionID        => $Self->{SessionID},
                ShowLinkLabels   => $Kernel::OM->Get('Kernel::Config')->Get("CMDBTreeView::ShowLinkLabels") || 'Yes',
            },
        ),
        $LayoutObject->Footer( Type => 'Small' );
}

1;

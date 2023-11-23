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

    # get needed parameters
    my $ParamObject  = $Kernel::OM->Get('Kernel::System::Web::Request');
    my $ConfigItemID = $ParamObject->GetParam( Param => 'ConfigItemID' );

    my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');

    # check needed stuff
    if ( !$ConfigItemID ) {
        return $LayoutObject->ErrorScreen(
            Message => Translatable('No ConfigItemID is given!'),
            Comment => Translatable('Please contact the administrator.'),
        );
    }

    # get config item object
    my $ConfigItemObject = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');

    # get config of frontend module
    my $FrontendConfig = $Kernel::OM->Get('Kernel::Config')->Get("ITSMConfigItem::Frontend::$Self->{Action}");

    # check permissions
    my $Access = $ConfigItemObject->Permission(
        Type   => $FrontendConfig->{Permission},
        Scope  => 'Item',
        Action => $Self->{Action},
        ItemID => $ConfigItemID,
        UserID => $Self->{UserID},
    );

    # error screen
    if ( !$Access ) {
        return $LayoutObject->NoPermission(
            Message =>
                $LayoutObject->{LanguageObject}->Translate( 'You need %s permissions!', $FrontendConfig->{Permission} ),
            WithHeader => 'yes',
        );
    }

    my $Depth = $ParamObject->GetParam( Param => 'Depth' ) || $Kernel::OM->Get('Kernel::Config')->Get("CMDBTreeView::DefaultDepth") || 1;

    if ( $Self->{Subaction} eq 'LoadTreeView' ) {

        # the HTML contains the information for drawing the graph
        my $CanvasHTML = $LayoutObject->GenerateHierarchyGraph(
            Depth        => $Depth,
            ConfigItemID => $ConfigItemID,
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

    # The information for drawing the graph will be fetch with 'LoadTreeView'
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

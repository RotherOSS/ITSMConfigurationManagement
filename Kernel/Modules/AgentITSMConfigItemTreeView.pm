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

use strict;
use warnings;

use Kernel::Language qw(Translatable);
use Kernel::System::VariableCheck qw(:all);

our $ObjectManagerDisabled = 1;

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {%Param};
    bless( $Self, $Type );

    return $Self;
}

sub Run {
    my ( $Self, %Param ) = @_;

    # get needed ConfigItemID
    my $ConfigItemID = $Kernel::OM->Get('Kernel::System::Web::Request')->GetParam( Param => 'ConfigItemID' );

    # get layout object
    my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');

    # get param object
    my $ParamObject = $Kernel::OM->Get('Kernel::System::Web::Request');

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
    $Self->{Config} = $Kernel::OM->Get('Kernel::Config')->Get("ITSMConfigItem::Frontend::$Self->{Action}");

    # check permissions
    my $Access = $ConfigItemObject->Permission(
        Type   => $Self->{Config}->{Permission},
        Scope  => 'Item',
        Action => $Self->{Action},
        ItemID => $ConfigItemID,
        UserID => $Self->{UserID},
    );

    # error screen
    if ( !$Access ) {
        return $LayoutObject->NoPermission(
            Message =>
                $LayoutObject->{LanguageObject}->Translate( 'You need %s permissions!', $Self->{Config}->{Permission} ),
            WithHeader => 'yes',
        );
    }

    my $Depth = $ParamObject->GetParam( Param => 'Depth' ) || $Kernel::OM->Get('Kernel::Config')->Get("CMDBTreeView::DefaultDepth") || 1;

    #Gather data from Caller CI
    my $ConfigItem = $ConfigItemObject->ConfigItemGet(
        ConfigItemID => $ConfigItemID,
        Cache        => 1,
    );

    my $VersionRef = $ConfigItemObject->VersionGet(
        VersionID  => $ConfigItem->{LastVersionID},
        XMLDataGet => 1,
    );

    if ( $Self->{Subaction} eq 'LoadTreeView' ) {
        my $GraphData = $LayoutObject->GenerateHierarchyGraph(
            Depth        => $Depth,
            ConfigItemID => $ConfigItemID,
            SessionID    => $Self->{SessionID}
        );

        return $LayoutObject->Attachment(
            ContentType => 'text/html',
            Content     => $GraphData,
            Type        => 'inline',
            NoCache     => 1,
        );
    }

    my $Output = $LayoutObject->Header(
        Type      => 'Small',
        BodyClass => 'Popup',
    );

    # output content
    $Output .= $LayoutObject->Output(
        TemplateFile => 'AgentITSMConfigItemTreeView',
        Data         => {
            %Param,
            ConfigItemID     => $ConfigItemID,
            ConfigItemName   => $VersionRef->{Name},
            ConfigItemNumber => $ConfigItem->{Number},
            Depth            => $Depth,
            DefaultDepth     => $Kernel::OM->Get('Kernel::Config')->Get("CMDBTreeView::DefaultDepth") || 1,
            SessionID        => $Self->{SessionID},
            ShowLinkLabels   => $Kernel::OM->Get('Kernel::Config')->Get("CMDBTreeView::ShowLinkLabels") || 'Yes',
        },
    );

    $Output .= $LayoutObject->Footer( Type => 'Small' );

    return $Output;
}

1;

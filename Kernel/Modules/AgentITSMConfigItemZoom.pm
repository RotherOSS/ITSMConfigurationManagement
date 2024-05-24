# --
# OTOBO is a web-based ticketing system for service organisations.
# --
# Copyright (C) 2001-2020 OTRS AG, https://otrs.com/
# Copyright (C) 2019-2024 Rother OSS GmbH, https://otobo.de/
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

package Kernel::Modules::AgentITSMConfigItemZoom;

use v5.24;
use strict;
use warnings;
use namespace::autoclean;
use utf8;

# core modules
use List::Util qw(any);

# CPAN modules

# OTOBO modules
use Kernel::Language              qw(Translatable);
use Kernel::System::VariableCheck qw(:all);

our $ObjectManagerDisabled = 1;

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    return bless {%Param}, $Type;
}

sub Run {
    my ( $Self, %Param ) = @_;

    # get param object
    my $ParamObject = $Kernel::OM->Get('Kernel::System::Web::Request');

    # get params
    my $ConfigItemID      = $ParamObject->GetParam( Param => 'ConfigItemID' );
    my $GetParamVersionID = $ParamObject->GetParam( Param => 'VersionID' );

    # get layout object
    my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');

    # check needed stuff
    if ( !$ConfigItemID ) {
        return $LayoutObject->ErrorScreen(
            Message => Translatable('No ConfigItemID is given!'),
            Comment => Translatable('Please contact the administrator.'),
        );
    }

    # get needed object
    my $ConfigItemObject = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');
    my $ConfigObject     = $Kernel::OM->Get('Kernel::Config');

    # check for access rights
    my $HasAccess = $ConfigItemObject->Permission(
        Scope  => 'Item',
        ItemID => $ConfigItemID,
        UserID => $Self->{UserID},
        Type   => $ConfigObject->Get("ITSMConfigItem::Frontend::$Self->{Action}")->{Permission},
    );

    if ( !$HasAccess ) {

        # error page
        return $LayoutObject->ErrorScreen(
            Message => Translatable('Can\'t show item, no access rights for ConfigItem are given!'),
            Comment => Translatable('Please contact the administrator.'),
        );
    }

    # get content
    my $ConfigItem = $ConfigItemObject->ConfigItemGet(
        ConfigItemID  => $ConfigItemID,
        VersionID     => $GetParamVersionID,
        DynamicFields => 1,
    );
    if ( !$ConfigItem->{ConfigItemID} ) {
        return $LayoutObject->ErrorScreen(
            Message =>
                $LayoutObject->{LanguageObject}->Translate('ConfigItem not found!'),
            Comment => Translatable('Please contact the administrator.'),
        );
    }

    # get version list
    my $VersionList = $ConfigItemObject->VersionZoomList(
        ConfigItemID => $ConfigItemID,
    );

    if ( !IsArrayRefWithData($VersionList) ) {
        return $LayoutObject->ErrorScreen(
            Message =>
                $LayoutObject->{LanguageObject}->Translate('No versions found!'),
            Comment => Translatable('Please contact the administrator.'),
        );
    }

    # TODO: Compare with legacy code to check whether this is a good place. Line 256 throws an error if not set, else
    my $VersionID = $ConfigItem->{VersionID};

    # run config item menu modules
    if ( ref $ConfigObject->Get('ITSMConfigItem::Frontend::MenuModule') eq 'HASH' ) {
        my %Menus   = %{ $ConfigObject->Get('ITSMConfigItem::Frontend::MenuModule') };
        my $Counter = 0;
        for my $Menu ( sort keys %Menus ) {

            # load module
            if ( $Kernel::OM->Get('Kernel::System::Main')->Require( $Menus{$Menu}->{Module} ) ) {

                my $Object = $Menus{$Menu}->{Module}->new(
                    %{$Self},
                    ConfigItemID => $Self->{ConfigItemID},
                );

                # set classes
                if ( $Menus{$Menu}->{Target} ) {

                    if ( $Menus{$Menu}->{Target} eq 'PopUp' ) {
                        $Menus{$Menu}->{MenuClass} = 'AsPopup';
                    }
                    elsif ( $Menus{$Menu}->{Target} eq 'Back' ) {
                        $Menus{$Menu}->{MenuClass} = 'HistoryBack';
                    }

                }

                # run module
                $Counter = $Object->Run(
                    %Param,
                    ConfigItem => $ConfigItem,
                    Counter    => $Counter,
                    Config     => $Menus{$Menu},
                    MenuID     => $Menu,
                );
            }
            else {
                return $LayoutObject->FatalError();
            }
        }
    }

    # set incident signal
    my %InciSignals = (
        Translatable('operational') => 'greenled',
        Translatable('warning')     => 'yellowled',
        Translatable('incident')    => 'redled',
    );

    # to store the color for the deployment states
    my %DeplSignals;

    # get general catalog object
    my $GeneralCatalogObject = $Kernel::OM->Get('Kernel::System::GeneralCatalog');

    # get list of deployment states
    my $DeploymentStatesList = $GeneralCatalogObject->ItemList(
        Class => 'ITSM::ConfigItem::DeploymentState',
    );

    # set deployment style colors
    my $StyleClasses = '';

    ITEMID:
    for my $ItemID ( sort keys %{$DeploymentStatesList} ) {

        # get deployment state preferences
        my %Preferences = $GeneralCatalogObject->GeneralCatalogPreferencesGet(
            ItemID => $ItemID,
        );

        # check if a color is defined in preferences
        next ITEMID unless $Preferences{Color};
        my ($Color) = $Preferences{Color}->@*;
        next ITEMID unless $Color;

        # get deployment state
        my $DeplState = $DeploymentStatesList->{$ItemID};

        # remove any non ascii word characters
        $DeplState =~ s{ [^a-zA-Z0-9] }{_}msxg;

        # store the original deployment state as key
        # and the ss safe coverted deployment state as value
        $DeplSignals{ $DeploymentStatesList->{$ItemID} } = $DeplState;

        # covert to lower case
        my $DeplStateColor = lc($Color) =~ s/[^0-9a-f]//msgr;

        # add to style classes string
        $StyleClasses .= "
            .Flag span.$DeplState {
                background-color: #$DeplStateColor;
            }
        ";
    }

    # wrap into style tags
    if ($StyleClasses) {
        $StyleClasses = "<style>$StyleClasses</style>";
    }

    # build version selection
    my $BaseLink = $LayoutObject->Output(
        Template => '[% Env("Baselink") %]Action=AgentITSMConfigItemZoom;'
            . "ConfigItemID=$ConfigItem->{ConfigItemID};"
    );

    my @VersionSelectionData = map {
        {
            Key   => ( $BaseLink . "VersionID=$_->{VersionID}" ),
            Value => (
                "Version " . ( $_->{VersionString} || $_->{VersionID} )
            ),
        }
    } $VersionList->@*;

    my $VersionSelection = $LayoutObject->BuildSelection(
        Data         => \@VersionSelectionData,
        Name         => 'VersionSelection',
        Class        => 'Modernize',
        SelectedID   => $VersionID ? $BaseLink . "VersionID=$VersionID" : undef,
        PossibleNone => 1,
    );

    $LayoutObject->Block(
        Name => 'SelectionRow',
        Data => {
            VersionSelection => $VersionSelection,
        },
    );

    # output header
    my $Output = $LayoutObject->Header( Value => $ConfigItem->{Number} );
    $Output .= $LayoutObject->NavigationBar();

    # if a version already exists (TODO: When does it not?)
    if ( $ConfigItem->{Name} ) {

        # transform ascii to html
        my $ConfigItemName = $LayoutObject->Ascii2Html(
            Text           => $ConfigItem->{Name},
            HTMLResultMode => 1,
            LinkFeature    => 1,
        );

        # output name
        $LayoutObject->Block(
            Name => 'Data',
            Data => {
                Name        => Translatable('Name'),
                Description => Translatable('The name of this config item'),
                Value       => $ConfigItemName,
                Identation  => 10,
            },
        );

        # output deployment state
        $LayoutObject->Block(
            Name => 'Data',
            Data => {
                Name        => Translatable('Deployment State'),
                Description => Translatable('The deployment state of this config item'),
                Value       => $LayoutObject->{LanguageObject}->Translate(
                    $ConfigItem->{DeplState},
                ),
                Identation => 10,
            },
        );

        # output incident state
        $LayoutObject->Block(
            Name => 'Data',
            Data => {
                Name        => Translatable('Incident State'),
                Description => Translatable('The incident state of this config item'),
                Value       => $LayoutObject->{LanguageObject}->Translate(
                    $ConfigItem->{InciState},
                ),
                Identation => 10,
            },
        );

        my $Definition = $ConfigItemObject->DefinitionGet(
            DefinitionID => $ConfigItem->{DefinitionID},
        );

        my %GroupLookup;
        my @Pages;
        my $PageShown;
        my $PageRequested = $ParamObject->GetParam( Param => 'Page' );
        PAGE:
        for my $Page ( $Definition->{DefinitionRef}{Pages}->@* ) {

            # Interfaces is optional, effectively default to [ 'Agent' ]
            if ( $Page->{Interfaces} ) {
                next PAGE unless any { $_ eq 'Agent' } $Page->{Interfaces}->@*;
            }

            if ( $Page->{Groups} ) {
                if ( !%GroupLookup ) {
                    %GroupLookup = reverse $Kernel::OM->Get('Kernel::System::Group')->PermissionUserGet(
                        UserID => $Self->{UserID},
                        Type   => 'ro',
                    );
                }

                # grant access to the page only when the user is in one of the specified groups
                next PAGE unless any { $GroupLookup{$_} } $Page->{Groups}->@*;
            }

            push @Pages, $Page;

            if ( $PageRequested && $Page->{Name} eq $PageRequested ) {
                $PageShown = $Page;
            }

        }

        $PageShown //= @Pages ? $Pages[0] : undef;

        if ( scalar @Pages == 1 ) {

            $LayoutObject->Block(
                Name => 'PageName',
                Data => {
                    PageName => $Pages[0]{Name},
                },
            );
        }
        else {
            for my $Page (@Pages) {

                $LayoutObject->Block(
                    Name => 'PageLink',
                    Data => {
                        PageName     => $Page->{Name},
                        ConfigItemID => $ConfigItem->{ConfigItemID},
                        VersionID    => $GetParamVersionID,
                        Selected     => $Page->{Name} eq $PageShown->{Name},
                    },
                );
            }
        }

        if (@Pages) {
            $ConfigItem->{DynamicFieldHTML} = $Kernel::OM->Get('Kernel::Output::HTML::ITSMConfigItem::DynamicField')->PageRender(
                ConfigItem => $ConfigItem,
                Definition => $Definition,
                PageRef    => $PageShown // $Pages[0],
            );
        }

    }

    # get user object
    my $UserObject = $Kernel::OM->Get('Kernel::System::User');

    # get create & change user data
    for my $Key (qw(Create Change)) {
        $ConfigItem->{ $Key . 'ByUserFullName' } = $UserObject->UserName(
            UserID => $ConfigItem->{ $Key . 'By' },
        );
    }

    # output meta block
    $LayoutObject->Block(
        Name => 'Meta',
        Data => {
            %{$ConfigItem},
            CurInciSignal => $InciSignals{ $ConfigItem->{CurInciStateType} },
            CurDeplSignal => $DeplSignals{ $ConfigItem->{CurDeplState} },
        },
    );

    # get linked objects
    my $LinkListWithData = $Kernel::OM->Get('Kernel::System::LinkObject')->LinkListWithData(
        Object => 'ITSMConfigItem',
        Key    => $ConfigItemID,
        State  => 'Valid',
        UserID => $Self->{UserID},
    );

    # get link table view mode
    my $LinkTableViewMode = $ConfigObject->Get('LinkObject::ViewMode');

    # create the link table
    my $LinkTableStrg = $LayoutObject->LinkObjectTableCreate(
        LinkListWithData => $LinkListWithData,
        ViewMode         => $LinkTableViewMode,
        Object           => 'ITSMConfigItem',
        Key              => $ConfigItemID,
    );

    # output the link table
    if ($LinkTableStrg) {
        $LayoutObject->Block(
            Name => 'LinkTable' . $LinkTableViewMode,
            Data => {
                LinkTableStrg => $LinkTableStrg,
            },
        );
    }

    my @Attachments = $ConfigItemObject->ConfigItemAttachmentList(
        ConfigItemID => $ConfigItemID,
    );

    my @NonInlineAttachments;

    ATTACHMENT:
    for my $Attachment (@Attachments) {

        # get the metadata of the current attachment
        my $AttachmentData = $ConfigItemObject->ConfigItemAttachmentGet(
            ConfigItemID => $ConfigItemID,
            Filename     => $Attachment,
        );
        push @NonInlineAttachments, $AttachmentData;
    }

    if (@NonInlineAttachments) {

        $LayoutObject->Block(
            Name => 'Attachments',
        );

        ATTACHMENT:
        for my $AttachmentData (@NonInlineAttachments) {

            $LayoutObject->Block(
                Name => 'AttachmentRow',
                Data => {
                    ConfigItemID => $ConfigItemID,
                    Filename     => $AttachmentData->{Filename},
                    Filesize     => $AttachmentData->{Filesize},
                },
            );
        }
    }

    # handle DownloadAttachment
    if ( $Self->{Subaction} eq 'DownloadAttachment' ) {

        # get data for attachment
        my $Filename       = $ParamObject->GetParam( Param => 'Filename' );
        my $AttachmentData = $ConfigItemObject->ConfigItemAttachmentGet(
            ConfigItemID => $ConfigItemID,
            Filename     => $Filename,
        );

        # return error if file does not exist
        if ( !$AttachmentData ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Message  => "No such attachment ($Filename)!",
                Priority => 'error',
            );
            return $LayoutObject->ErrorScreen();
        }

        return $LayoutObject->Attachment(
            %{$AttachmentData},
            Type => 'attachment',
        );
    }

    # store last screen
    $Kernel::OM->Get('Kernel::System::AuthSession')->UpdateSessionID(
        SessionID => $Self->{SessionID},
        Key       => 'LastScreenView',
        Value     => $Self->{RequestedURL},
    );

    $LayoutObject->AddJSData(
        Key   => 'UserConfigItemZoomTableHeight',
        Value => $Self->{UserConfigItemZoomTableHeight},
    );

    # start template output
    return join '',
        $Output,
        $LayoutObject->Output(
            TemplateFile => 'AgentITSMConfigItemZoom',
            Data         => {
                $ConfigItem->%*,
                CurInciSignal => $InciSignals{ $ConfigItem->{CurInciStateType} },
                CurDeplSignal => $DeplSignals{ $ConfigItem->{CurDeplState} },
                StyleClasses  => $StyleClasses,
            },
        ),
        $LayoutObject->Footer;
}

1;

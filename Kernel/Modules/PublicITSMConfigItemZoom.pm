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

package Kernel::Modules::PublicITSMConfigItemZoom;

use v5.24;
use strict;
use warnings;
use namespace::autoclean;
use utf8;

# core modules
use List::Util qw(any);

# CPAN modules

# OTOBO modules
use Kernel::Language qw(Translatable);

our $ObjectManagerDisabled = 1;

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {%Param};

    # clear any active login to enforce security
    delete $Self->{UserID};

    $Self->{CacheType} = 'ITSMConfigurationManagement';
    $Self->{CacheTTL}  = 60 * 60 * 24 * 20;

    bless( $Self, $Type );

    return $Self;
}

sub Run {
    my ( $Self, %Param ) = @_;

    # get param object
    my $ParamObject = $Kernel::OM->Get('Kernel::System::Web::Request');

    # get params
    my $ConfigItemID = $ParamObject->GetParam( Param => 'ConfigItemID' );
    my $VersionID    = $ParamObject->GetParam( Param => 'VersionID' );

    # get layout object
    my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');

    # check needed stuff
    if ( !$ConfigItemID ) {
        return $LayoutObject->PublicErrorScreen(
            Message => Translatable('No ConfigItemID is given!'),
        );
    }

    # get needed object
    my $ConfigItemObject = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');
    my $ConfigObject     = $Kernel::OM->Get('Kernel::Config');

    # check for access rights
    my $HasAccess = $ConfigItemObject->PublicPermission(
        ConfigItemID => $ConfigItemID,
    );

    if ( !$HasAccess ) {
        return $LayoutObject->PublicNoPermission( WithHeader => 'yes' );
    }

    my $Config = $ConfigObject->Get('ITSMConfigItem::Frontend::PublicITSMConfigItemZoom') // {};

    if ( !$Config->{VersionsEnabled} ) {
        $VersionID = undef;
    }

    # get content
    my $ConfigItem = $ConfigItemObject->ConfigItemGet(
        ConfigItemID  => $ConfigItemID,
        VersionID     => $VersionID,
        DynamicFields => 1,
    );
    if ( !$ConfigItem->{ConfigItemID} ) {

        # additional sanity check - PublicPermission should handle this case usually
        return $LayoutObject->PublicErrorScreen(
            Message => $LayoutObject->{LanguageObject}->Translate('ConfigItem not found!'),
        );
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
        $DeplSignals{ $DeploymentStatesList->{$ItemID} } = 'Color' . $DeplState;

        # covert to lower case
        my $DeplStateColor = lc($Color) =~ s/[^0-9a-f]//msgr;

        # add to style classes string
        $StyleClasses .= "
            .Color$DeplState {
                background-color: #$DeplStateColor;
            }
        ";
    }

    # wrap into style tags
    if ($StyleClasses) {
        $StyleClasses = "<style>$StyleClasses</style>";
    }

    # output header
    my $Output = $LayoutObject->CustomerHeader( Value => $ConfigItem->{Number} );

    if ( $Config->{GeneralInfo} ) {
        if ( $Config->{GeneralInfo}{Number} ) {
            $LayoutObject->Block(
                Name => 'FullSub',
                Data => {
                    Number => $ConfigItem->{Number},
                    Class  => $Config->{GeneralInfo}{Class} ? $ConfigItem->{Class} : 'ConfigItem'
                },
            );
        }
        elsif ( $Config->{GeneralInfo}{Class} ) {
            $LayoutObject->Block(
                Name => 'ClassSub',
                Data => {
                    Class => $ConfigItem->{Class},
                },
            );
        }

        $ConfigItem->{DeplStateColorClass} = $DeplSignals{ $ConfigItem->{CurDeplState} };
        $ConfigItem->{InciStateColorClass} = $InciSignals{ $ConfigItem->{CurInciStateType} };

        INFO:
        for my $Info (qw/DeploymentState IncidentState CreatedTime LastChangedTime/) {
            next INFO if !$Config->{GeneralInfo}{$Info};

            $LayoutObject->Block(
                Name => $Info,
                Data => $ConfigItem,
            );
        }
    }

    my %PublicActions = %{ $ConfigObject->Get('PublicFrontend::Module') // {} };
    if ( $PublicActions{PublicITSMConfigItem} ) {
        $LayoutObject->Block(
            Name => 'OverviewLink',
        );
    }

    # if a version already exists (TODO: When does it not?)
    if ( $ConfigItem->{Name} ) {
        my $Definition = $ConfigItemObject->DefinitionGet(
            DefinitionID => $ConfigItem->{DefinitionID},
        );

        my @Pages;
        my $PageShown;
        my $PageRequested = $ParamObject->GetParam( Param => 'Page' );
        PAGE:
        for my $Page ( $Definition->{DefinitionRef}{Pages}->@* ) {
            next PAGE unless $Page->{Interfaces};
            next PAGE unless any { $_ eq 'Public' } $Page->{Interfaces}->@*;

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
                        VersionID    => $VersionID,
                        Selected     => $Page->{Name} eq $PageShown->{Name},
                    },
                );
            }
        }

        if (@Pages) {
            $ConfigItem->{DynamicFieldHTML} = $Kernel::OM->Get('Kernel::Output::HTML::ITSMConfigItem::DynamicField')->PageRender(
                ConfigItem => $ConfigItem,
                Definition => $Definition,
                PageRef    => $PageShown,
            );
        }

        # prepare version list
        if ( $Config->{VersionsEnabled} && $Config->{VersionsSelectable} ) {

            # get version list
            my $VersionList = $ConfigItemObject->VersionZoomList(
                ConfigItemID => $ConfigItemID,
            );

            my $BaseLink = $LayoutObject->Output(
                Template => '[% Env("Baselink") %]Action=PublicITSMConfigItemZoom;'
                    . "ConfigItemID=$ConfigItem->{ConfigItemID};Page=[% Data.Name | uri %];",
                Data => {
                    Name => $PageShown ? $PageShown->{Name} : '',
                },
            );

            my @VersionSelectionData = map {
                {
                    Key   => ( $BaseLink . "VersionID=$_->{VersionID}" ),
                    Value => (
                        "$_->{Name} "
                            . ( $_->{VersionString} || $_->{VersionID} )
                            . " ($_->{CreateTime})"
                    ),
                }
            } $VersionList->@*;

            my $VersionSelection = $LayoutObject->BuildSelection(
                Data         => \@VersionSelectionData,
                Name         => 'VersionSelection',
                Class        => 'Modernize AlignDropdownRight',
                SelectedID   => $VersionID ? $BaseLink . "VersionID=$VersionID" : undef,
                PossibleNone => 1,
            );

            $LayoutObject->Block(
                Name => 'Versions',
                Data => {
                    VersionSelection => $VersionSelection,
                }
            );
        }
    }

    my @Attachments = $ConfigItemObject->ConfigItemAttachmentList(
        ConfigItemID => $ConfigItemID,
    );

    if (@Attachments) {

        $LayoutObject->Block(
            Name => 'Attachments',
        );

        ATTACHMENT:
        for my $Attachment (@Attachments) {

            # get the metadata of the current attachment
            my $AttachmentData = $ConfigItemObject->ConfigItemAttachmentGet(
                ConfigItemID => $ConfigItemID,
                Filename     => $Attachment,
            );

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

    # start template output
    return join '',
        $Output,
        $LayoutObject->Output(
            TemplateFile => 'PublicITSMConfigItemZoom',
            Data         => {
                $ConfigItem->%*,
                CurInciSignal => $InciSignals{ $ConfigItem->{CurInciStateType} },
                CurDeplSignal => $DeplSignals{ $ConfigItem->{CurDeplState} },
                StyleClasses  => $StyleClasses,
            },
        ),
        $LayoutObject->PublicFooter;
}

1;

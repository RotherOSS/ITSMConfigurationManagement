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

package Kernel::Modules::CustomerITSMConfigItemZoom;

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

    # get param object
    my $ParamObject = $Kernel::OM->Get('Kernel::System::Web::Request');

    # get params
    my $ConfigItemID = $ParamObject->GetParam( Param => 'ConfigItemID' );
    my $VersionID    = $ParamObject->GetParam( Param => 'VersionID' );

    # get layout object
    my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');

    # check needed stuff
    if ( !$ConfigItemID ) {
        return $LayoutObject->CustomerErrorScreen(
            Message => Translatable('No ConfigItemID is given!'),
        );
    }

    # get needed object
    my $ConfigItemObject = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');
    my $ConfigObject     = $Kernel::OM->Get('Kernel::Config');

    # check for access rights
    my $HasAccess = $ConfigItemObject->CustomerPermission(
        ConfigItemID => $ConfigItemID,
        UserID       => $Self->{UserID},
    );

    if ( !$HasAccess ) {
        return $LayoutObject->CustomerNoPermission( WithHeader => 'yes' );
    }

    # set show versions
    $Param{ShowVersions} = 0;
    if ( $ParamObject->GetParam( Param => 'ShowVersions' ) ) {
        $Param{ShowVersions} = 1;
    }

    # get content
    my $ConfigItem = $ConfigItemObject->ConfigItemGet(
        ConfigItemID  => $ConfigItemID,
        VersionID     => $VersionID,
        DynamicFields => 1,
    );
    if ( !$ConfigItem->{ConfigItemID} ) {
        # additional sanety check - CustomerPermission should handle this case usually
        return $LayoutObject->CustomerErrorScreen(
            Message => $LayoutObject->{LanguageObject}->Translate('ConfigItem not found!'),
        );
    }

    # get version list
    my $VersionList = $ConfigItemObject->VersionZoomList(
        ConfigItemID => $ConfigItemID,
    );

    if ( $VersionID && $VersionID ne $VersionList->[-1]->{VersionID} ) {
        $Param{ShowVersions} = 1;
    }

    # TODO: Compare with legacy code to check whether this is a good place. Line 256 throws an error if not set, else
    $VersionID ||= $ConfigItem->{VersionID};

    my $Config = $ConfigObject->Get('ITSMConfigItem::Frontend::CustomerITSMConfigItemZoom') // {};

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
                    Class  => $ConfigItem->{Class},
                },
            );
        }

        INFO:
        for my $Info ( qw/DeploymentState IncidentState CreatedTime LastChangedTime/ ) {
            next INFO if !$Config->{GeneralInfo}{ $Info };

            $LayoutObject->Block(
                Name => $Info,
                Data => $ConfigItem,
            );
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
        next ITEMID if !$Preferences{Color};

        # get deployment state
        my $DeplState = $DeploymentStatesList->{$ItemID};

        # remove any non ascii word characters
        $DeplState =~ s{ [^a-zA-Z0-9] }{_}msxg;

        # store the original deployment state as key
        # and the ss safe coverted deployment state as value
        $DeplSignals{ $DeploymentStatesList->{$ItemID} } = $DeplState;

        # covert to lower case
        my $DeplStateColor = lc $Preferences{Color};

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

    # output header
    my $Output = $LayoutObject->CustomerHeader( Value => $ConfigItem->{Number} );

    # if a version already exists (TODO: When does it not?)
    if ( $ConfigItem->{Name} ) {

        # transform ascii to html
        $ConfigItem->{Name} = $LayoutObject->Ascii2Html(
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
                Value       => $ConfigItem->{Name},
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
            next PAGE unless $Page->{Interfaces};
            next PAGE unless grep { $_ eq 'Customer' } $Page->{Interfaces}->@*;

            if ( $Page->{Groups} ) {
                if ( !%GroupLookup ) {
                    %GroupLookup = reverse $Kernel::OM->Get('Kernel::System::CustomerGroup')->GroupMemberList(
                        UserID => $Self->{UserID},
                        Type   => 'ro',
                        Result => 'HASH',
                    );
                }

                my $AccessOk = 0;
                GROUP:
                for my $GroupName ( $Page->{Groups}-@* ) {
                    next GROUP if !$GroupLookup{ $GroupName };

                    $AccessOk = 1;
                }

                next PAGE unless $AccessOk;
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
            for my $Page ( @Pages ) {
                $LayoutObject->Block(
                    Name => 'PageLink',
                    Data => {
                        PageName     => $Page->{Name},
                        ConfigItemID => $ConfigItem->{ConfigItemID},
                        VersionID    => $Param{VersionID},
                        Selected     => $Page->{Name} eq $PageShown->{Name},
                    },
                );
            }
        }

        if ( @Pages ) {
            $ConfigItem->{DynamicFieldHTML} = $Kernel::OM->Get('Kernel::Output::HTML::ITSMConfigItem::DynamicField')->PageRender(
                ConfigItem => $ConfigItem,
                Definition => $Definition,
                PageRef    => $PageShown,
            );
        }

        my $BaseLink = $LayoutObject->Output(
            Template => '[% Env("Baselink") %]Action=CustomerITSMConfigItemZoom;'
                . "ConfigItemID=$ConfigItem->{ConfigItemID};Page=[% Data.Name | uri %];",
            Data     => {
                Name => $PageShown ? $PageShown->{Name} : '',
            },
        );

        my @VersionSelectionData = map {
            {
                Key   => $BaseLink . "VersionID=$_->{VersionID}",
                Value => "$DeplSignals{ $ConfigItem->{DeplState} } $_->{Name} "
                    . ( $_->{VersionNumber} || $_->{VersionID} )
                    . " ($_->{CreateTime})",
            },
        } $VersionList->@*;

        my $VersionSelection = $LayoutObject->BuildSelection(
            Data           => \@VersionSelectionData,
            Name           => 'VersionSelection',
            Class          => 'Modernize',
            SelectedID     => $Param{VersionID} ? $BaseLink . "VersionID=$Param{VersionID}" : undef,
            PossibleNone   => 1,
            DisabledBranch => $VersionID,
        );
        $LayoutObject->Block(
            Name => 'Versions',
            Data => {
                VersionSelection => $VersionSelection,
            }
        );
    }

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
            TemplateFile => 'CustomerITSMConfigItemZoom',
            Data         => {
                $ConfigItem->%*,
                CurInciSignal => $InciSignals{ $ConfigItem->{CurInciStateType} },
                CurDeplSignal => $DeplSignals{ $ConfigItem->{CurDeplState} },
                StyleClasses  => $StyleClasses,
            },
        ),
        $LayoutObject->CustomerNavigationBar(),
        $LayoutObject->CustomerFooter;
}

1;

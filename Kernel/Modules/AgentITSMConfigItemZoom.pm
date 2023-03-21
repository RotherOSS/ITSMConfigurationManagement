# --
# OTOBO is a web-based ticketing system for service organisations.
# --
# Copyright (C) 2001-2020 OTRS AG, https://otrs.com/
# Copyright (C) 2019-2021 Rother OSS GmbH, https://otobo.de/
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

use strict;
use warnings;

## nofilter(TidyAll::Plugin::OTOBO::Migrations::OTOBO6::SysConfig)

use Kernel::Language qw(Translatable);
use Kernel::System::VariableCheck qw(IsHashRefWithData);

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

    # get param object
    my $ParamObject = $Kernel::OM->Get('Kernel::System::Web::Request');

    # get params
    my $ConfigItemID = $ParamObject->GetParam( Param => 'ConfigItemID' ) || 0;
    my $VersionID    = $ParamObject->GetParam( Param => 'VersionID' )    || 0;

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
    my $ConfigItemObject          = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');
    my $ConfigObject              = $Kernel::OM->Get('Kernel::Config');
    my $DynamicFieldBackendObject = $Kernel::OM->Get('Kernel::System::DynamicField::Backend');

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

    # set show versions
    $Param{ShowVersions} = 0;
    if ( $ParamObject->GetParam( Param => 'ShowVersions' ) ) {
        $Param{ShowVersions} = 1;
    }

    # get content
    my $ConfigItem = $ConfigItemObject->ConfigItemGet(
        ConfigItemID  => $ConfigItemID,
        DynamicFields => 1,
    );
    if ( !$ConfigItem->{ConfigItemID} ) {
        return $LayoutObject->ErrorScreen(
            Message =>
                $LayoutObject->{LanguageObject}->Translate( 'ConfigItemID %s not found in database!', $ConfigItemID ),
            Comment => Translatable('Please contact the administrator.'),
        );
    }

    # get version list
    my $VersionList = $ConfigItemObject->VersionZoomList(
        ConfigItemID => $ConfigItemID,
    );

    # TODO: Catch VersionID not in VersionList
    if ( $VersionID && $VersionID ne $VersionList->[-1]->{VersionID} ) {
        $Param{ShowVersions} = 1;
    }

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

    # build version tree
    $LayoutObject->Block( Name => 'Tree' );
    my $Counter = 1;
    if ( $VersionID && !$Param{ShowVersions} && $VersionID eq $VersionList->[-1]->{VersionID} ) {
        $Counter     = @{$VersionList};
        $VersionList = [ $VersionList->[-1] ];
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

    # output version tree header
    if ( $Param{ShowVersions} ) {
        $LayoutObject->Block(
            Name => 'Collapse',
            Data => {
                ConfigItemID => $ConfigItemID,
            },
        );
    }
    else {
        $LayoutObject->Block(
            Name => 'Expand',
            Data => {
                ConfigItemID => $ConfigItemID,
            },
        );
    }

    # get user object
    my $UserObject = $Kernel::OM->Get('Kernel::System::User');

    # output version tree
    for my $VersionHash ( @{$VersionList} ) {

        $Param{CreateByUserFullName} = $UserObject->UserName(
            UserID => $VersionHash->{CreateBy},
        );

        $LayoutObject->Block(
            Name => 'TreeItem',
            Data => {
                %Param,
                %{$ConfigItem},
                %{$VersionHash},
                Count      => $Counter,
                InciSignal => $InciSignals{ $VersionHash->{InciStateType} },
                DeplSignal => $DeplSignals{ $VersionHash->{DeplState} },
                Active     => $VersionHash->{VersionID} eq $VersionID ? 'Active' : '',
            },
        );

        $Counter++;
    }

    # output header
    my $Output = $LayoutObject->Header( Value => $ConfigItem->{Number} );
    $Output .= $LayoutObject->NavigationBar();

    # get version
    if ( $VersionID ) {
        my $ConfigItem = $ConfigItemObject->VersionGet(
            VersionID     => $VersionID,
            DynamicFields => 1,
        );
    }

    if ( $ConfigItem ) {

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

        # TODO: Remove all XML stuff also from the template files
        my $DynamicFieldObject = $Kernel::OM->Get('Kernel::System::DynamicField');
        my $DynamicFieldBackendObject = $Kernel::OM->Get('Kernel::System::DynamicField::Backend');

        # dynamic fields
        my $DynamicFields = $DynamicFieldObject->DynamicFieldListGet(
            ObjectType => 'ITSMConfigItem',
        );

        DYNAMICFIELD:
        for my $DynamicField ( $DynamicFields->@* ) {
            next DYNAMICFIELD if !IsHashRefWithData($DynamicField);

            my $ValueStrg = $DynamicFieldBackendObject->DisplayValueRender(
                DynamicFieldConfig => $DynamicField,
                Value              => 1, #$Ticket{ 'DynamicField_' . $DynamicFieldConfig->{Name} },
                HTMLOutput         => 1,
                LayoutObject       => $LayoutObject,
            );

            $LayoutObject->Block(
                Name => 'DynamicFieldRow',
                Data => {
                    $ValueStrg->%*,
                    Label => $DynamicField->{Label},
                },
            );

        }
    }

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

    # display dynamic fields
    my $DynamicField = $Kernel::OM->Get('Kernel::System::DynamicField')->DynamicFieldListGet(
        Valid       => 1,
        ObjectType  => [ 'ITSMConfigItem' ],
#         FieldFilter => {},
    );

    DYNAMICFIELD:
    for my $DynamicFieldConfig ( $DynamicField->@* ) {

        # use translation here to be able to reduce the character length in the template
        my $Label = $LayoutObject->{LanguageObject}->Translate( $DynamicFieldConfig->{Label} );

        my $DynamicFieldDisplayData = $DynamicFieldBackendObject->DisplayValueRender(
            DynamicFieldConfig => $DynamicFieldConfig,
            Value              => $ConfigItem->{ 'DynamicField_' . $DynamicFieldConfig->{Name} },
            LayoutObject       => $LayoutObject,
            ValueMaxChars      => 18,
        );

        $LayoutObject->Block(
            Name => 'DynamicField',
            Data => {
                $DynamicFieldConfig->{Name} => $DynamicFieldDisplayData->{Title},
                Label                       => $Label,
                Title                       => $DynamicFieldDisplayData->{Title},
                Value                       => $DynamicFieldDisplayData->{Value},
            },
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

        # get the metadata of the 1st attachment
        my $FirstAttachment = $ConfigItemObject->ConfigItemAttachmentGet(
            ConfigItemID => $ConfigItemID,
            Filename     => $Attachments[0],
        );

        $LayoutObject->Block(
            Name => 'Attachments',
            Data => {
                ConfigItemID => $ConfigItemID,
                Filename     => $FirstAttachment->{Filename},
                Filesize     => $FirstAttachment->{Filesize},
            },
        );

        # the 1st attachment was directly rendered into the 1st row's right cell, all further
        # attachments are rendered into a separate row
        ATTACHMENT:
        for my $Attachment (@Attachments) {

            # skip the 1st attachment
            next ATTACHMENT if $Attachment eq $Attachments[0];

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
    $Output .= $LayoutObject->Output(
        TemplateFile => 'AgentITSMConfigItemZoom',
        Data         => {
            %{$ConfigItem},
            CurInciSignal => $InciSignals{ $ConfigItem->{CurInciStateType} },
            CurDeplSignal => $DeplSignals{ $ConfigItem->{CurDeplState} },
            StyleClasses  => $StyleClasses,
        },
    );

    # add footer
    $Output .= $LayoutObject->Footer();

    return $Output;
}

1;

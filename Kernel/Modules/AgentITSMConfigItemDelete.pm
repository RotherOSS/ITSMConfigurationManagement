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
package Kernel::Modules::AgentITSMConfigItemDelete;

use strict;
use warnings;

use Kernel::Language qw(Translatable);

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

    # get config item data
    my $ConfigItem = $ConfigItemObject->ConfigItemGet(
        ConfigItemID => $ConfigItemID,
        UserID       => $Self->{UserID},
    );

    # check if config item is found
    if ( !$ConfigItem ) {
        return $LayoutObject->ErrorScreen(
            Message =>
                $LayoutObject->{LanguageObject}->Translate( 'Config item "%s" not found in database!', $ConfigItemID ),
            Comment => Translatable('Please contact the administrator.'),
        );
    }

    # delete the config item
    if ( $Self->{Subaction} eq 'ConfigItemDelete' ) {

        # delete the config item
        my $CouldDeleteConfigItem = $ConfigItemObject->ConfigItemDelete(
            ConfigItemID => $ConfigItemID,
            UserID       => $Self->{UserID},
        );

        if ($CouldDeleteConfigItem) {

            # redirect to config item overview, when the deletion was successful
            return $LayoutObject->Redirect(
                OP => "Action=AgentITSMConfigItem",
            );
        }
        else {

            # show error message, when delete failed
            return $LayoutObject->ErrorScreen(
                Message => $LayoutObject->{LanguageObject}->Translate( 'Was not able to delete the configitem ID %s!', $ConfigItemID ),
                Comment => Translatable('Please contact the administrator.'),
            );
        }
    }

    # get latest version data
    my $Version = $ConfigItemObject->VersionGet(
        ConfigItemID => $ConfigItemID,
    );

    if ( !$Version->{VersionID} ) {
        return $LayoutObject->ErrorScreen(
            Message =>
                $LayoutObject->{LanguageObject}->Translate( 'No version found for ConfigItemID %s!', $ConfigItemID ),
            Comment => Translatable('Please contact the administrator.'),
        );
    }

    # set the dialog type. As default, the dialog will have 2 buttons: Yes and No
    my $DialogType = 'Confirmation';

    # output content
    my $Output = $LayoutObject->Output(
        TemplateFile => 'AgentITSMConfigItemDelete',
        Data         => {
            %Param,
            %{$ConfigItem},
            %{$Version},
        },
    );

    # build the returned data structure
    my %Data = (
        HTML       => $Output,
        DialogType => $DialogType,
    );

    # return JSON-String because of AJAX-Mode
    my $OutputJSON = $LayoutObject->JSONEncode( Data => \%Data );

    return $LayoutObject->Attachment(
        ContentType => 'application/json; charset=' . $LayoutObject->{Charset},
        Content     => $OutputJSON,
        Type        => 'inline',
        NoCache     => 1,
    );
}

1;

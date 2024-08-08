# --
# OTOBO is a web-based ticketing system for service organisations.
# --
# Copyright (C) 2001-2020 OTRS AG, https://otrs.com/
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

package Kernel::Modules::AgentITSMConfigItemHistory;

use strict;
use warnings;

use Kernel::Language qw(Translatable);

our $ObjectManagerDisabled = 1;

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    return bless {%Param}, $Type;
}

sub Run {
    my ( $Self, %Param ) = @_;

    # get needed objects
    my $ParamObject  = $Kernel::OM->Get('Kernel::System::Web::Request');
    my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');

    # get and check config item ID
    my $ConfigItemID = $ParamObject->GetParam( Param => 'ConfigItemID' );

    return $LayoutObject->ErrorScreen(
        Message => Translatable('Can\'t show history, no ConfigItemID is given!'),
        Comment => Translatable('Please contact the administrator.'),
    ) unless $ConfigItemID;

    # get neeeded objects
    my $ConfigItemObject     = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');
    my $ConfigObject         = $Kernel::OM->Get('Kernel::Config');
    my $GeneralCatalogObject = $Kernel::OM->Get('Kernel::System::GeneralCatalog');

    # check for access rights
    my $HasAccess = $ConfigItemObject->Permission(
        Scope  => 'Item',
        ItemID => $ConfigItemID,
        UserID => $Self->{UserID},
        Type   => $ConfigObject->Get("ITSMConfigItem::Frontend::$Self->{Action}")->{Permission},
    );

    return $LayoutObject->ErrorScreen(
        Message => Translatable('Can\'t show history, no access rights given!'),
        Comment => Translatable('Please contact the administrator.'),
    ) unless $HasAccess;

    # Define translatable history strings.
    my %HistoryStrings = (
        'CIHistory::ConfigItemCreate'      => Translatable('New ConfigItem (ID=%s)'),
        'CIHistory::VersionCreate'         => Translatable('New version (ID=%s)'),
        'CIHistory::DeploymentStateUpdate' => Translatable('Deployment state updated (new=%s, old=%s)'),
        'CIHistory::IncidentStateUpdate'   => Translatable('Incident state updated (new=%s, old=%s)'),
        'CIHistory::ConfigItemDelete'      => Translatable('ConfigItem (ID=%s) deleted'),
        'CIHistory::LinkAdd'               => Translatable('Link to %s (type=%s) added'),
        'CIHistory::LinkDelete'            => Translatable('Link to %s (type=%s) deleted'),
        'CIHistory::DefinitionUpdate'      => Translatable('ConfigItem definition updated (ID=%s)'),
        'CIHistory::NameUpdate'            => Translatable('Name updated (new=%s, old=%s)'),
        'CIHistory::ValueUpdate'           => Translatable('Attribute %s updated from "%s" to "%s"'),
        'CIHistory::VersionDelete'         => Translatable('Version %s deleted'),
    );

    # get all information about the config item
    my $ConfigItem = $ConfigItemObject->ConfigItemGet(
        ConfigItemID => $ConfigItemID,
    );
    my $ConfigItemName = $ConfigItem->{Number};

    # get all entries in the history for this config item
    my $Lines = $ConfigItemObject->HistoryGet(
        ConfigItemID => $ConfigItemID,
    );

    # get shown user info
    my @NewLines = @{$Lines};
    if ( $ConfigObject->Get('ITSMConfigItem::Frontend::HistoryOrder') eq 'reverse' ) {
        @NewLines = reverse @{$Lines};
    }

    my $Version = 0;
    for my $DataTmp (@NewLines) {
        my %Data = (
            %{$DataTmp},
            VersionID => $Version,
        );

        # trim the comment to only show version number
        if ( $Data{HistoryType} eq 'VersionCreate' ) {
            $Data{Comment} =~ s/\D//g;
            $Data{VersionID} = $Data{Comment};
            $Version = $Data{Comment};
        }
        elsif ( $Data{HistoryType} eq 'DeploymentStateUpdate' ) {

            # get deployment state list
            my $DeplStateList = $GeneralCatalogObject->ItemList(
                Class => 'ITSM::ConfigItem::DeploymentState',
            );

            # show names, first split the reassemble
            $Data{Comment} =
                join '%%',
                map { $DeplStateList->{$_} || '' }
                split m/%%/, $Data{Comment};
        }
        elsif ( $Data{HistoryType} eq 'IncidentStateUpdate' ) {

            # get deployment state list
            my $InciStateList = $GeneralCatalogObject->ItemList(
                Class => 'ITSM::Core::IncidentState',
            );

            # show names, first split the reassemble
            $Data{Comment} =
                join '%%',
                map { $InciStateList->{$_} || '' }
                split m/%%/, $Data{Comment};
        }

        # replace text
        if ( $Data{Comment} ) {
            $Data{Comment} =~ s{ \A %% }{}xmsg;
            my @Values = split /%%/, $Data{Comment};

            $Data{Comment} = $LayoutObject->{LanguageObject}->Translate(
                $HistoryStrings{ 'CIHistory::' . $Data{HistoryType} },
                @Values,
            );

            # remove not needed place holder
            $Data{Comment} =~ s/\%s//g;
        }

        $LayoutObject->Block(
            Name => 'Row',
            Data => {%Data},
        );
    }

    # build page
    return join '',
        $LayoutObject->Header(
            Value => $ConfigItemName,
            Type  => 'Small'
        ),
        $LayoutObject->Output(
            TemplateFile => 'AgentITSMConfigItemHistory',
            Data         => {
                Name         => $ConfigItemName,
                ConfigItemID => $ConfigItemID,
                VersionID    => $ParamObject->GetParam( Param => 'VersionID' ),
            },
        ),
        $LayoutObject->Footer( Type => 'Small' );
}

1;

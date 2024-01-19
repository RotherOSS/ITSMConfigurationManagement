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

package Kernel::Modules::AgentITSMConfigItemAdd;

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

    # get general catalog object
    my $GeneralCatalogObject = $Kernel::OM->Get('Kernel::System::GeneralCatalog');

    # get class list
    my $ClassList = $GeneralCatalogObject->ItemList(
        Class => 'ITSM::ConfigItem::Class',
    );

    # check for access rights
    for my $ClassID ( sort keys %{$ClassList} ) {
        my $HasAccess = $Kernel::OM->Get('Kernel::System::ITSMConfigItem')->Permission(
            Type    => $Kernel::OM->Get('Kernel::Config')->Get("ITSMConfigItem::Frontend::$Self->{Action}")->{Permission},
            Scope   => 'Class',
            ClassID => $ClassID,
            UserID  => $Self->{UserID},
        );

        delete $ClassList->{$ClassID} if !$HasAccess;
    }

    # get layout object
    my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');

    # show the list of CI classes sorted by name
    for my $ItemID ( sort { ${$ClassList}{$a} cmp ${$ClassList}{$b} } keys %{$ClassList} ) {

        # get item data
        my $ItemData = $GeneralCatalogObject->ItemGet(
            ItemID => $ItemID,
        );

        # output overview item list
        $LayoutObject->Block(
            Name => 'OverviewItemList',
            Data => {
                ClassID => $ItemID,
                Name    => $ClassList->{$ItemID},
            },
        );
    }

    # output header
    my $Output = $LayoutObject->Header(
        Title => Translatable('Add'),
    );
    $Output .= $LayoutObject->NavigationBar();

    # output overview
    $Output .= $LayoutObject->Output(
        TemplateFile => 'AgentITSMConfigItemAdd',
        Data         => {
            %Param,
        },
    );

    # output footer
    $Output .= $LayoutObject->Footer();

    return $Output;
}

1;

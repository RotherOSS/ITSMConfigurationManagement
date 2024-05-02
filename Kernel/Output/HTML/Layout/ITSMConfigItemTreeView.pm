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

package Kernel::Output::HTML::Layout::ITSMConfigItemTreeView;

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

=head1 NAME

Kernel::Output::HTML::Layout::ITSMConfigItemTreeView - all ConfigItemTreeView-related HTML functions

=head1 DESCRIPTION

All ConfigItemTreeView-related HTML functions

=head1 PUBLIC INTERFACE

=head2 GenerateHierarchyGraph()

creates HTML containing the information needed for drawing the graph.

    my $CanvasHTML = $LayoutObject->GenerateHierarchyGraph(
        Depth          => 2, # depth level
        ConfigItemID   => 1  # source config item ID
    );

=cut

sub GenerateHierarchyGraph {
    my ( $Self, %Param ) = @_;

    my $ConfigItemID = $Param{ConfigItemID};

    my $LayoutObject     = $Kernel::OM->Get('Kernel::Output::HTML::Layout');
    my $ConfigItemObject = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');

    $Self->{CITreeMaxDepth} = 1;

    # Get first level of linked config objects from the table 'configitem_link'.
    # Irrespective of direction.
    my $LinkedConfigItems = $ConfigItemObject->LinkedConfigItems(
        ConfigItemID => $ConfigItemID,
        Direction    => 'Both',
        UserID       => 1,
    );

    # build first level, Target and Source
    my %LinkOutputDataTargets = $Self->GetLinkOutputData(
        LinkedConfigItems => $LinkedConfigItems,
        Direction         => 'Target',
        Depth             => 1,
        Parent            => $ConfigItemID
    );
    my %LinkOutputDataSources = $Self->GetLinkOutputData(
        LinkedConfigItems => $LinkedConfigItems,
        Direction         => 'Source',
        Depth             => 1,
        Parent            => $ConfigItemID
    );

    # Build Levels Up (Sources)
    $Self->GetCISubTreeData(
        LinkOutputData => \%LinkOutputDataSources,    # will be modified
        Init           => 1,
        Depth          => $Param{Depth},
        Key            => $ConfigItemID,
        Direction      => 'Source'
    );

    # Build Levels Down (Targets)
    $Self->GetCISubTreeData(
        LinkOutputData => \%LinkOutputDataTargets,    # will be modified
        Init           => 2,
        Depth          => $Param{Depth},
        Key            => $ConfigItemID,
        Direction      => 'Target'
    );

    # The needed data has been collected.
    # The following just passes the two trees to the web page.

    # for the sources start with the deepest level
    my $LinkDataSource = '';
    for my $Level ( sort { $b <=> $a } keys %LinkOutputDataSources ) {
        my $Elements = $LinkOutputDataSources{$Level};

        $LayoutObject->Block(
            Name  => 'ChildSourceElementsLevel',
            Level => $Level
        );

        for my $Element ( $Elements->@* ) {

            $LayoutObject->Block(
                Name => 'ChildSourceElements',
                Data => {
                    Name         => $Element->{Name},
                    Contents     => $Element->{Contents},
                    ConfigItemID => $Element->{ID},
                    ID           => "$Element->{ID}-$Level",
                    SessionID    => $Param{SessionID}
                }
            );

            my $NextLevel = $Level - 1;

            $LinkDataSource .= $NextLevel
                ?
                "$Element->{LinkedTo}-$NextLevel,$Element->{ID}-$Level,$Element->{Link};"
                :
                "$Element->{LinkedTo},$Element->{ID}-$Level,$Element->{Link};";
        }
    }

    # Level 0
    # Give information about the root node to the web page.
    # Dynamic field info is not needed.
    {
        my $ConfigItem = $ConfigItemObject->ConfigItemGet(
            ConfigItemID => $ConfigItemID,
            Cache        => 1,
        );
        my $Contents = $Self->_FillColumnAttributes(
            Attributes => [ $Self->CITreeDefaultAttributes ],
            ConfigItem => $ConfigItem,
        );

        $LayoutObject->Block(
            Name => 'OriginElement',
            Data => {
                Name         => $ConfigItem->{Name},
                Contents     => $Contents,
                ConfigItemID => $ConfigItemID,
                ID           => $ConfigItemID,
            }
        );
    }

    # for the targest start with the lowest level
    my $LinkDataTarget = '';
    for my $Level ( sort { $a <=> $b } keys %LinkOutputDataTargets ) {
        my $Elements = $LinkOutputDataTargets{$Level};

        $LayoutObject->Block(
            Name => 'ChildTargetElementsLevel',
            Data => {
                Level => $Level
            }
        );

        for my $Element ( $Elements->@* ) {

            $LayoutObject->Block(
                Name => 'ChildTargetElements',
                Data => {
                    Name         => $Element->{Name},
                    Contents     => $Element->{Contents},
                    ConfigItemID => $Element->{ID},
                    ID           => "$Element->{ID}-$Level",
                    SessionID    => $Param{SessionID}
                }
            );

            my $PreviousLevel = $Level - 1;

            $LinkDataTarget .= ( $Level ne '1' )
                ?
                "$Element->{ID}-$Level,$Element->{LinkedTo}-$PreviousLevel,$Element->{Link};"
                :
                "$Element->{ID}-$Level,$Element->{LinkedTo},$Element->{Link};";
        }
    }

    return $LayoutObject->Output(
        TemplateFile => 'ConfigItemTreeView/ConfigItemTreeViewGraph',
        Data         => {
            MaxDepth       => $Self->{CITreeMaxDepth},
            LinkDataSource => $LinkDataSource,
            LinkDataTarget => $LinkDataTarget,
        }
    );
}

# TODO: the below subs should declared as internal

=head2 CITreeDefaultAttributes()

Get a list of attributes that are shown in the nodes.

    my @Attributes = $LayoutObject->CITreeDefaultAttributes();

=cut

sub CITreeDefaultAttributes {
    return qw/Class CurInciState CurDeplState/;
}

# build Children structure
sub GetCISubTreeData {
    my ( $Self, %Param ) = @_;

    my $LinkOutputData = $Param{LinkOutputData};    # will be modified
    my $Depth          = $Param{Depth};
    my $Init           = $Param{Init};
    my $Direction      = $Param{Direction};

    my $ActualLevel      = 1;
    my $ConfigItemObject = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');

    # build the items for the new levels
    LOOPDEPTH:
    for my $GoDeep ( $Init .. $Depth ) {
        next LOOPDEPTH if exists $LinkOutputData->{$GoDeep};
        next LOOPDEPTH unless $LinkOutputData->{ $GoDeep - 1 };
        next LOOPDEPTH unless $LinkOutputData->{ $GoDeep - 1 }->@*;

        my @ItemsPerLevel;
        for my $Element ( $LinkOutputData->{ $GoDeep - 1 }->@* ) {
            my $ConfigItemID = $Element->{ID};

            # get linked objects
            my $LinkedConfigItems = $ConfigItemObject->LinkedConfigItems(
                ConfigItemID => $ConfigItemID,
                Direction    => 'Both',
                UserID       => 1,
            );

            my %DataForItem = $Self->GetLinkOutputData(
                LinkedConfigItems => $LinkedConfigItems,
                Depth             => $GoDeep,
                Parent            => $ConfigItemID,
                Direction         => $Direction,
            );

            push @ItemsPerLevel, ( $DataForItem{$GoDeep} // [] )->@*;
        }

        if (@ItemsPerLevel) {
            $ActualLevel++;
            $LinkOutputData->{$GoDeep} = \@ItemsPerLevel;
        }
    }

    if ( $ActualLevel > $Self->{CITreeMaxDepth} && $ActualLevel != 0 ) {
        $Self->{CITreeMaxDepth} = $ActualLevel;
    }

    return;
}

# return contents of the nodes
sub _FillColumnAttributes {
    my ( $Self, %Param ) = @_;

    my @Attributes = $Param{Attributes}->@*;
    my $ConfigItem = $Param{ConfigItem};

    my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');

    # fill data with Version attributes
    my @Lines;
    for my $Column ( sort @Attributes ) {

        my $ColumnLabel = $Column;
        if ( index( $Column, '::' ) > 0 ) {
            my @Vals = split /::/, $Column;
            pop @Vals;
            $ColumnLabel = join ' ', @Vals;
        }

        my $Label = $LayoutObject->{LanguageObject}->Translate( $Self->_MapAttributes( Label => $ColumnLabel ) );
        my $Text  = $ConfigItem->{$Column} // '';
        push @Lines, "$Label: " . $LayoutObject->{LanguageObject}->Translate($Text);
    }

    return join '<br>', @Lines;
}

# Get links for related CI.
# This returned output data is not a tree, but an arrayref of items per level.
sub GetLinkOutputData {
    my ( $Self, %Param ) = @_;

    my $Depth = $Param{Depth};

    my $LayoutObject     = $Kernel::OM->Get('Kernel::Output::HTML::Layout');
    my $ConfigItemObject = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');
    my $ConfiguredTypes  = $Kernel::OM->Get('Kernel::Config')->Get('LinkObject::Type');
    my %OutputData;

    for my $LinkedConfigItem ( grep { $_->{Direction} eq $Param{Direction} } $Param{LinkedConfigItems}->@* ) {
        my $ConfigItemID = $LinkedConfigItem->{ConfigItemID};

        # ConfigItemGet() allows for both cases
        my $ConfigItem = $ConfigItemObject->ConfigItemGet(
            ConfigItemID  => $ConfigItemID,
            DynamicFields => 1,
        );

        # Find label for the link. In TreeView the label of the arc
        # should be in accordance to the direction of the arc. The arc
        # is always directed from Source to Target. Therefore the SourceName is the arc label.
        my $LinkType = $LinkedConfigItem->{LinkType};
        my $ArcLabel = $ConfiguredTypes->{$LinkType}->{SourceName} || $LinkType;

        # define item data
        my %Item = (
            ID       => $ConfigItem->{ConfigItemID},
            Name     => $ConfigItem->{Name},
            Contents => $Self->_FillColumnAttributes(
                Attributes => [ $Self->CITreeDefaultAttributes ],
                ConfigItem => $ConfigItem,
            ),
            Link     => $LayoutObject->{LanguageObject}->Translate($ArcLabel),
            LinkedTo => $Param{Parent} || ''
        );

        $OutputData{$Depth} //= [];
        push $OutputData{$Depth}->@*, \%Item;
    }

    return %OutputData;
}

# change labels for translatable values
sub _MapAttributes {
    my ( $Self, %Param ) = @_;

    if ( !$Param{Label} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => 'Need Label!'
        );

        return;
    }

    state $MapTranslations = {
        InciState        => 'Incident State',
        DeplState        => 'Deployment State',
        CurDeplState     => 'Current Deployment State',
        CurInciState     => 'Current Incident State',
        Number           => 'Version Number',
        CurInciStateType => 'Current Incident State Type'
    };

    return $MapTranslations->{ $Param{Label} } // $Param{Label};
}

1;

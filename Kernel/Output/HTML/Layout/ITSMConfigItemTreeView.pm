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

    # get linked objects
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
    my %TreeSources = $Self->GetCISubTreeData(
        Tree      => \%LinkOutputDataSources,
        Init      => 1,
        Depth     => $Param{Depth},
        Key       => $ConfigItemID,
        Direction => 'Source'
    );

    # Build Levels Down (Targets)
    my %TreeTargets = $Self->GetCISubTreeData(
        Tree      => \%LinkOutputDataTargets,
        Init      => 2,
        Depth     => $Param{Depth},
        Key       => $ConfigItemID,
        Direction => 'Target'
    );

    # The needed data has been collected.
    # The following just passes the two trees to the web page.

    # for the sources start with the deepest level
    my $LinkDataSource = '';
    for my $Level ( sort { $b <=> $a } keys %TreeSources ) {
        my %Elements = $TreeSources{$Level}->%*;

        $LayoutObject->Block(
            Name  => 'ChildSourceElementsLevel',
            Level => $Level
        );

        for my $CITop ( sort { $a <=> $b } keys %Elements ) {
            my %Element = %{ $Elements{$CITop} };

            $LayoutObject->Block(
                Name => 'ChildSourceElements',
                Data => {
                    Name         => $Element{Name},
                    Contents     => $Element{Contents},
                    ConfigItemID => $Element{ID},
                    ID           => "$Element{ID}-$Level",
                    SessionID    => $Param{SessionID}
                }
            );

            my $NextLevel = $Level - 1;

            if ($NextLevel) {
                $LinkDataSource .= "$Element{LinkedTo}-$NextLevel,$Element{ID}-$Level,$Element{Link};";
            }
            else {
                $LinkDataSource .= "$Element{LinkedTo},$Element{ID}-$Level,$Element{Link};";
            }
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
    for my $Level ( sort { $a <=> $b } keys %TreeTargets ) {
        my %Elements = %{ $TreeTargets{$Level} };

        $LayoutObject->Block(
            Name => 'ChildTargetElementsLevel',
            Data => {
                Level => $Level
            }
        );

        for my $CITop ( sort { $a <=> $b } keys %Elements ) {
            my %Element = %{ $Elements{$CITop} };

            $LayoutObject->Block(
                Name => 'ChildTargetElements',
                Data => {
                    Name         => $Element{Name},
                    Contents     => $Element{Contents},
                    ConfigItemID => "$Element{ID}",
                    ID           => "$Element{ID}-$Level",
                    SessionID    => $Param{SessionID}
                }
            );

            my $PreviousLevel = $Level - 1;

            if ( $Level ne '1' ) {
                $LinkDataTarget .= "$Element{ID}-$Level,$Element{LinkedTo}-$PreviousLevel,$Element{Link};";
            }
            else {
                $LinkDataTarget .= "$Element{ID}-$Level,$Element{LinkedTo},$Element{Link};";
            }
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

    my %Tree      = %{ $Param{Tree} };
    my $Depth     = $Param{Depth};
    my $Init      = $Param{Init};
    my $Direction = $Param{Direction};

    my $ActualLevel      = 1;
    my $ConfigItemObject = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');

    # build SubTree
    LOOPDEPTH:
    for my $GoDeep ( $Init .. $Depth ) {

        next LOOPDEPTH if exists $Tree{$GoDeep};
        next LOOPDEPTH unless keys $Tree{ $GoDeep - 1 }->%*;

        {
            my %CIsRelated = %{ $Tree{ $GoDeep - 1 } };
            my %SubTree;

            for my $Key ( sort { $a <=> $b } keys %CIsRelated ) {

                # get linked objects
                my $LinkedConfigItems = $ConfigItemObject->LinkedConfigItems(
                    ConfigItemID => $Key,
                    Direction    => 'Both',
                    UserID       => 1,
                );

                my %LinkOutputData = $Self->GetLinkOutputData(
                    LinkedConfigItems => $LinkedConfigItems,
                    Depth             => $GoDeep,
                    Parent            => $Key,
                    Direction         => $Direction,
                    SourceCI          => $Param{Key}
                );

                if ( keys %LinkOutputData ) {
                    my %HashData = %{ $LinkOutputData{$GoDeep} };
                    %SubTree = ( %SubTree, %HashData );
                }
            }

            if ( keys %SubTree ) {
                $ActualLevel++;
                $Tree{$GoDeep} = \%SubTree;
            }
        }
    }

    if ( $ActualLevel > $Self->{CITreeMaxDepth} && $ActualLevel != 0 ) {
        $Self->{CITreeMaxDepth} = $ActualLevel;
    }

    return %Tree;
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

# Get links for related CI
sub GetLinkOutputData {
    my ( $Self, %Param ) = @_;

    my $Depth = $Param{Depth};

    my $LayoutObject     = $Kernel::OM->Get('Kernel::Output::HTML::Layout');
    my $ConfigItemObject = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');
    my $ConfiguredTypes  = $Kernel::OM->Get('Kernel::Config')->Get('LinkObject::Type');
    my %OutputData;

    for my $LinkedConfigItem (
        grep { $_->{Direction} eq $Param{Direction} } $Param{LinkedConfigItems}->@*
        )
    {
        my $ConfigItemID = $LinkedConfigItem->{ConfigItemID};

        my $ConfigItem = $ConfigItemObject->ConfigItemGet(
            ConfigItemID  => $ConfigItemID,
            DynamicFields => 1,
        );

        # Find label for the link
        my $LinkType = $LinkedConfigItem->{LinkType};
        my $Link     = $LinkedConfigItem->{Direction} eq 'Source'
            ?
            $ConfiguredTypes->{$LinkType}->{TargetName}
            :
            $ConfiguredTypes->{$LinkType}->{SourceName};
        $Link ||= $LinkType;

        # define item data
        my %Item = (
            ID       => $ConfigItem->{ConfigItemID},
            Name     => $ConfigItem->{Name},
            Contents => $Self->_FillColumnAttributes(
                Attributes => [ $Self->CITreeDefaultAttributes ],
                ConfigItem => $ConfigItem,
            ),
            Link     => $LayoutObject->{LanguageObject}->Translate($Link),
            LinkedTo => $Param{Parent} || ''
        );

        $OutputData{$Depth}->{ $ConfigItem->{ConfigItemID} } = \%Item;
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

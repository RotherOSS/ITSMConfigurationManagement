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
use Kernel::System::VariableCheck qw(:all);

our $ObjectManagerDisabled = 1;

=head1 NAME

Kernel::Output::HTML::Layout::ITSMConfigItemTreeView - all ConfigItemTreeView-related HTML functions

=head1 DESCRIPTION

All ConfigItemTreeView-related HTML functions

=head1 PUBLIC INTERFACE

=head2 GenerateHierarchyGraph()

create HTML for the graph of config items

    my $HTML = $LayoutObject->GenerateHierarchyGraph(
        Depth          => 2, #Depth Leve
        ConfigItemID   => 1  #Source Config Item ID
    );

=cut

sub GenerateHierarchyGraph {
    my ( $Self, %Param ) = @_;

    my $LayoutObject     = $Kernel::OM->Get('Kernel::Output::HTML::Layout');
    my $ConfigItemObject = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');
    $Self->{MaxDepth} = 1;

    my $ConfigItem = $ConfigItemObject->ConfigItemGet(
        ConfigItemID  => $Param{ConfigItemID},
        DynamicFields => 1,
        Cache         => 1,
    );

    my %SourceCI = (
        ID   => $ConfigItem->{ConfigItemID},
        Name => $ConfigItem->{Name},
        Link => '',
    );

    # Fill attributes for Source CI
    $SourceCI{Contents} = $Self->FillColumnAttributes(
        Attributes => [ $Self->CITreeDefaultAttributes ],
        VersionRef => $ConfigItem,
    );

    # get linked objects
    my $LinkListWithData = $Kernel::OM->Get('Kernel::System::LinkObject')->LinkListWithData(
        Object => 'ITSMConfigItem',
        Key    => $ConfigItem->{ConfigItemID},
        State  => 'Valid',
        UserID => 1,
    );

    my $LinkList = $LinkListWithData->{'ITSMConfigItem'};

    # Build First Level
    my %Tree = $Self->GetLinkOutputData(
        LinkList  => $LinkList,
        Direction => 'Target',
        Depth     => 1,
        Parent    => $ConfigItem->{ConfigItemID}
    );

    my %LinkOutputDataSources = $Self->GetLinkOutputData(
        LinkList  => $LinkList,
        Direction => 'Source',
        Depth     => 1,
        Parent    => $ConfigItem->{ConfigItemID}
    );

    # Build Levels Up (Sources)
    my %TreeSources = $Self->GetCISubTreeData(
        Tree      => \%LinkOutputDataSources,
        Init      => 1,
        Depth     => $Param{Depth},
        Key       => $ConfigItem->{ConfigItemID},
        Direction => 'Source'
    );

    # Build Levels Down (Targets)
    %Tree = $Self->GetCISubTreeData(
        Tree      => \%Tree,
        Init      => 2,
        Depth     => $Param{Depth},
        Key       => $ConfigItem->{ConfigItemID},
        Direction => 'Target'
    );

    my $LinkData       = '';
    my $LinkDataTarget = '';

    for my $TopElement ( sort { $b <=> $a } keys %TreeSources ) {
        my %Elements = %{ $TreeSources{$TopElement} };
        my $Block    = $TopElement eq '1' ? 'ChildSourceElementsLevelStart' : 'TopElementsStart';

        $LayoutObject->Block(
            Name => $Block,
            Data => {}
        );

        for my $CITop ( sort { $a <=> $b } keys %Elements ) {
            my %Element = %{ $Elements{$CITop} };
            my $Block   = $TopElement eq '1' ? 'ChildElements' : 'TopElements';

            $LayoutObject->Block(
                Name => $Block,
                Data => {
                    Name         => $Element{Name},
                    Contents     => $Element{Contents},
                    ConfigItemID => "$Element{ID}",
                    ID           => "$Element{ID}-$TopElement",
                    SessionID    => $Param{SessionID}
                }
            );

            my $NextLevel = $TopElement - 1;

            if ($NextLevel) {
                $LinkData .= "$Element{LinkedTo}-$NextLevel,$Element{ID}-$TopElement,$Element{Link};";
            }
            else {
                $LinkData .= "$Element{LinkedTo},$Element{ID}-$TopElement,$Element{Link};";
            }
        }
    }

    $LayoutObject->Block(
        Name => 'TopTargetElements',
        Data => {
            Name         => $SourceCI{Name},
            Contents     => $SourceCI{Contents},
            ConfigItemID => $SourceCI{ID},
            ID           => $SourceCI{ID}
        }
    );

    for my $TopElement ( sort { $a <=> $b } keys %Tree ) {
        my %Elements = %{ $Tree{$TopElement} };

        $LayoutObject->Block(
            Name => 'ChildTargetElementsLevel',
            Data => {
                Level => $TopElement
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
                    ID           => "$Element{ID}-$TopElement",
                    SessionID    => $Param{SessionID}
                }
            );

            my $PreviousLevel = $TopElement - 1;

            if ( $TopElement ne '1' ) {
                $LinkDataTarget .= "$Element{ID}-$TopElement,$Element{LinkedTo}-$PreviousLevel,$Element{Link};";
            }
            else {
                $LinkDataTarget .= "$Element{ID}-$TopElement,$Element{LinkedTo},$Element{Link};";
            }
        }
    }

    return $LayoutObject->Output(
        TemplateFile => 'ConfigItemTreeView/ConfigItemTreeViewGraph',
        Data         => {
            MaxDepth       => $Self->{MaxDepth},
            LinkData       => $LinkData,
            LinkDataTarget => $LinkDataTarget,
        }
    );
}

# TODO: the below subs should be internal

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

    my $ActualLevel = 1;

    #Build SubTree
    LOOPDEPTH:
    for my $GoDeep ( $Init .. $Depth ) {

        if ( !exists( $Tree{$GoDeep} ) ) {
            next LOOPDEPTH if !keys %{ $Tree{ $GoDeep - 1 } };

            my %CIsRelated = %{ $Tree{ $GoDeep - 1 } };
            my %SubTree;

            for my $Key ( sort { $a <=> $b } keys %CIsRelated ) {

                my $LinkListWithData = $Kernel::OM->Get('Kernel::System::LinkObject')->LinkListWithData(
                    Object => 'ITSMConfigItem',
                    Key    => $Key,
                    State  => 'Valid',
                    UserID => 1,
                );

                my $LinkList       = $LinkListWithData->{'ITSMConfigItem'};
                my %LinkOutputData = $Self->GetLinkOutputData(
                    LinkList  => $LinkList,
                    Depth     => $GoDeep,
                    Parent    => $Key,
                    Direction => $Direction,
                    SourceCI  => $Param{Key}
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

    if ( $ActualLevel > $Self->{MaxDepth} && $ActualLevel != 0 ) {
        $Self->{MaxDepth} = $ActualLevel;
    }

    return %Tree;
}

# Return contents of the nodes
sub FillColumnAttributes {
    my ( $Self, %Param ) = @_;

    my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');
    my @Attributes   = @{ $Param{Attributes} };
    my $VersionRef   = $Param{VersionRef};

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
        my $Text  = $VersionRef->{$Column} // '';
        push @Lines, "$Label: " . $LayoutObject->{LanguageObject}->Translate($Text);
    }

    return join '<br>', @Lines;
}

# Get links for related CI
sub GetLinkOutputData {
    my ( $Self, %Param ) = @_;

    my $LayoutObject     = $Kernel::OM->Get('Kernel::Output::HTML::Layout');
    my $ConfigItemObject = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');
    my %OutputData;
    my $Depth = $Param{Depth};

    for my $LinkType ( sort keys %{ $Param{LinkList} } ) {

        # extract link type List
        my $LinkTypeList = $Param{LinkList}->{$LinkType};

        LINKOUTPUT:
        for my $Direction ( sort keys %{$LinkTypeList} ) {

            next LINKOUTPUT if $Direction ne $Param{Direction};

            # extract direction list
            my $DirectionList = $Param{LinkList}->{$LinkType}->{$Direction};

            my @ItemList;
            for my $ConfigItemID ( sort { $a <=> $b } keys %{$DirectionList} ) {

                # extract config item data
                my $Version = $DirectionList->{$ConfigItemID};

                my $VersionRef = $ConfigItemObject->ConfigItemGet(
                    VersionID     => $Version->{VersionID},
                    DynamicFields => 1,
                );

                if ( $Param{Direction} eq 'Source' ) {
                    my $ConfiguredTypes = $Kernel::OM->Get('Kernel::Config')->Get('LinkObject::Type');
                    my $SourceName      = $ConfiguredTypes->{$LinkType}->{SourceName} || '';
                    my $TargetName      = $ConfiguredTypes->{$LinkType}->{TargetName} || '';

                    if ( $SourceName ne $TargetName ) {
                        $LinkType = $TargetName;
                    }
                }

                # define item data
                my %Item = (
                    ID       => $Version->{ConfigItemID},
                    Name     => $Version->{Name},
                    Contents => $Self->FillColumnAttributes(
                        Attributes => [ $Self->CITreeDefaultAttributes ],
                        VersionRef => $VersionRef
                    ),
                    Link     => $LayoutObject->{LanguageObject}->Translate($LinkType),
                    LinkedTo => $Param{Parent} || ''
                );

                $OutputData{$Depth}->{ $Version->{ConfigItemID} } = \%Item;
                push @ItemList, \%Item;
            }
        }
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

    state %MapTranslations = (
        InciState        => 'Incident State',
        DeplState        => 'Deployment State',
        CurDeplState     => 'Current Deployment State',
        CurInciState     => 'Current Incident State',
        Number           => 'Version Number',
        CurInciStateType => 'Current Incident State Type'
    );

    return $MapTranslations{ $Param{Label} } // $Param{Label};
}

1;

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
        VersionID      => 1  # source config item version ID
    );

=cut

sub GenerateHierarchyGraph {
    my ( $Self, %Param ) = @_;

    my ( $ConfigItemID, $VersionID ) = @Param{qw(ConfigItemID VersionID)};

    my $LayoutObject     = $Kernel::OM->Get('Kernel::Output::HTML::Layout');
    my $ConfigItemObject = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');

    $Self->{CITreeMaxDepth} = 1;

    # Get first level of linked config objects from the table 'configitem_link'.
    # Irrespective of direction.
    my $LinkedConfigItems = $ConfigItemObject->LinkedConfigItems(
        ConfigItemID => $ConfigItemID,
        VersionID    => $VersionID,
        Direction    => 'Both',
        UserID       => 1,
    );

    # Build first level in both directions, Target and Source.
    # The keys in the hashes are the level from 1 to max.
    # The values are arrayrefs with the edges.
    my ( %LinkOutputDataTargets, %LinkOutputDataSources );
    {
        my $OriginID = $Self->_GenerateID(%Param);    # common to both directions

        $LinkOutputDataSources{1} = $Self->GetLinkOutputData(
            LinkedConfigItems => $LinkedConfigItems,
            Direction         => 'Source',
            LinkedTo          => $OriginID,
        );
        $LinkOutputDataTargets{1} = $Self->GetLinkOutputData(
            LinkedConfigItems => $LinkedConfigItems,
            Direction         => 'Target',
            LinkedTo          => $OriginID,
        );
    }

    # Build Levels Up (Sources)
    $Self->GetCISubTreeData(
        LinkOutputData => \%LinkOutputDataSources,    # will be modified
        Init           => 1,
        Depth          => $Param{Depth},
        Direction      => 'Source'
    );

    # Build Levels Down (Targets)
    $Self->GetCISubTreeData(
        LinkOutputData => \%LinkOutputDataTargets,    # will be modified
        Init           => 2,
        Depth          => $Param{Depth},
        Direction      => 'Target'
    );

    # The needed data has been collected.
    # The following just passes the two trees to the web page.

    # for the sources start with the deepest level
    my @LinkDataSource;    # will be used in JavaScript for draing the arcs
    for my $Level ( sort { $b <=> $a } keys %LinkOutputDataSources ) {
        my $Elements = $LinkOutputDataSources{$Level};

        $LayoutObject->Block(
            Name  => 'ChildSourceElementsLevel',
            Level => $Level
        );

        for my $Element ( $Elements->@* ) {

            my $ID = "$Element->{ID}_S$Level";    # only link to the next or previous level, the separator _S indicates Source
            $LayoutObject->Block(
                Name => 'ChildSourceElements',
                Data => {
                    Name         => $Element->{Name},
                    Contents     => $Element->{Contents},
                    ConfigItemID => $Element->{ConfigItemID},
                    ID           => $ID,
                    SessionID    => $Param{SessionID}
                }
            );

            # need to consider the special case when linking to the origin
            my $NextLevel = $Level - 1;
            my $LinkedTo  = $NextLevel ? "$Element->{LinkedTo}_S$NextLevel" : $Element->{LinkedTo};
            push @LinkDataSource, join ',', $LinkedTo, $ID, $Element->{Link};
        }
    }

    # Level 0
    # Give information about the root node to the web page.
    # Dynamic field info is not needed.
    {
        my $ConfigItem = $ConfigItemObject->ConfigItemGet(
            ConfigItemID => $ConfigItemID,
            VersionID    => $VersionID,
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
                ID           => $Self->_GenerateID(
                    ConfigItemID => $ConfigItemID,
                    VersionID    => $VersionID,
                ),
            }
        );
    }

    # for the targets start with the lowest level
    my @LinkDataTarget;    # will be used in JavaScript for draing the arcs
    for my $Level ( sort { $a <=> $b } keys %LinkOutputDataTargets ) {
        my $Elements = $LinkOutputDataTargets{$Level};

        $LayoutObject->Block(
            Name => 'ChildTargetElementsLevel',
            Data => {
                Level => $Level
            }
        );

        for my $Element ( $Elements->@* ) {
            my $ID = "$Element->{ID}_T$Level";    # only link to the next or previous level, the separator _T indicates Target
            $LayoutObject->Block(
                Name => 'ChildTargetElements',
                Data => {
                    Name         => $Element->{Name},
                    Contents     => $Element->{Contents},
                    ConfigItemID => $Element->{ConfigItemID},
                    ID           => $ID,
                    SessionID    => $Param{SessionID}
                }
            );

            # need to consider the special case when linking to the origin
            my $PreviousLevel = $Level - 1;
            my $LinkedTo      = $PreviousLevel ? "$Element->{LinkedTo}_T$PreviousLevel" : $Element->{LinkedTo};
            push @LinkDataTarget, join ',', $ID, $LinkedTo, $Element->{Link};
        }
    }

    return $LayoutObject->Output(
        TemplateFile => 'ConfigItemTreeView/ConfigItemTreeViewGraph',
        Data         => {
            MaxDepth       => $Self->{CITreeMaxDepth},
            LinkDataSource => join( ';', @LinkDataSource ),
            LinkDataTarget => join( ';', @LinkDataTarget ),
        }
    );
}

=head2 CITreeDefaultAttributes()

Get a list of attributes that are shown in the nodes.

    my @Attributes = $LayoutObject->CITreeDefaultAttributes();

=cut

sub CITreeDefaultAttributes {
    return qw/Class CurDeplState CurInciState CurInciStateType/;
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

        # get linked objects for the next level
        my @ItemsPerLevel;
        for my $Element ( $LinkOutputData->{ $GoDeep - 1 }->@* ) {

            my $LinkedConfigItems = $ConfigItemObject->LinkedConfigItems(
                ConfigItemID => $Element->{ConfigItemID},
                VersionID    => $Element->{VersionID},
                Direction    => 'Both',
                UserID       => 1,
            );

            my $DataForItem = $Self->GetLinkOutputData(
                LinkedConfigItems => $LinkedConfigItems,
                LinkedTo          => $Element->{ID},
                Direction         => $Direction,
            );

            push @ItemsPerLevel, ( $DataForItem // [] )->@*;
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

    # fill data with config item attributes
    my @Lines;
    for my $Column ( sort @Attributes ) {

        my $ColumnLabel = $Column;
        if ( index( $Column, '::' ) > 0 ) {
            my @Vals = split /::/, $Column;
            pop @Vals;
            $ColumnLabel = join ' ', @Vals;
        }

        my $Label = $LayoutObject->{LanguageObject}->Translate( $Self->_MapAttributes( Label => $ColumnLabel ) );
        my $Text  = $LayoutObject->{LanguageObject}->Translate( $ConfigItem->{$Column} // '' );

        # special handling for the current incident state. Show the green, yellow, red flags.
        if ( $Column eq 'CurInciStateType' ) {

            # define incident signals
            my %InciSignals = (
                Translatable('operational') => 'greenled',
                Translatable('warning')     => 'yellowled',
                Translatable('incident')    => 'redled',
            );
            my $CurInciSignal = $InciSignals{ $ConfigItem->{CurInciStateType} };
            push @Lines, qq{<span class="Flag Small"> <span class="$CurInciSignal">"$Text"</span></span>};
        }
        else {
            push @Lines, "$Label: $Text";
        }
    }

    return join "<br>\n", @Lines;
}

# generate an ID that is used for drawing the arcs
sub _GenerateID {
    my ( $Self, %Param ) = @_;

    return join '',
        ( defined $Param{ConfigItemID} ? "C$Param{ConfigItemID}" : '' ),
        ( defined $Param{VersionID}    ? "V$Param{VersionID}"    : '' );
}

# Get links for related CI.
# This returned output data is not a tree, but an arrayref of items per level.
sub GetLinkOutputData {
    my ( $Self, %Param ) = @_;

    my $LayoutObject     = $Kernel::OM->Get('Kernel::Output::HTML::Layout');
    my $ConfigItemObject = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');
    my $ConfiguredTypes  = $Kernel::OM->Get('Kernel::Config')->Get('LinkObject::Type');

    my @OutputData;
    for my $LinkedConfigItem ( grep { $_->{Direction} eq $Param{Direction} } $Param{LinkedConfigItems}->@* ) {

        # basic information about the linked config item
        # There are only two cases:
        #   - ConfigItemID is given
        #   - VersionID is given
        my %IncomingIDs = map { $_ => $LinkedConfigItem->{$_} } qw(ConfigItemID VersionID);

        # ConfigItemGet() allows for both cases
        my $ConfigItem = $ConfigItemObject->ConfigItemGet(
            %IncomingIDs,
            DynamicFields => 1,
        );

        # This will be used for finding the next level of links:
        #   - ConfigItemID was given => latest VersionID will be added
        #   - VersionID was given    => ConfigItemID for that version will be added
        my %OutgoingIDs = map { $_ => $ConfigItem->{$_} } qw(ConfigItemID VersionID);

        # Find label for the link. In TreeView the label of the arc
        # should be in accordance to the direction of the arc. The are
        # is always directed from Source to Target. Therefore the SourceName is the arc label.
        my $LinkType = $LinkedConfigItem->{LinkType};
        my $ArcLabel = $ConfiguredTypes->{$LinkType}->{SourceName} || $LinkType;

        # define item data
        push @OutputData, {
            %OutgoingIDs,
            ID       => $Self->_GenerateID(%OutgoingIDs),    # used for linking in the graph
            Name     => $ConfigItem->{Name},
            Contents => $Self->_FillColumnAttributes(
                Attributes => [ $Self->CITreeDefaultAttributes ],
                ConfigItem => $ConfigItem,
            ),
            Link     => $LayoutObject->{LanguageObject}->Translate($ArcLabel),
            LinkedTo => $Param{LinkedTo} || ''
        };
    }

    return \@OutputData;
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
        CurInciStateType => '',
        Number           => 'Version Number',
    };

    return $MapTranslations->{ $Param{Label} } // $Param{Label};
}

1;

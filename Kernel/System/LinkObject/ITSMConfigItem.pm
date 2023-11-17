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

package Kernel::System::LinkObject::ITSMConfigItem;

use v5.24;
use strict;
use warnings;
use namespace::autoclean;
use utf8;

# core modules

# CPAN modules

# OTOBO modules

our @ObjectDependencies = (
    'Kernel::Config',
    'Kernel::System::GeneralCatalog',
    'Kernel::System::ITSMConfigItem',
    'Kernel::System::Log',
);

=head1 NAME

Kernel::System::LinkObject::ITSMConfigItem - LinkObject module for ITSMConfigItem

=head2 new()

create an object. Do not use it directly, instead use:

    use Kernel::System::ObjectManager;

    local $Kernel::OM = Kernel::System::ObjectManager->new();
    my $LinkObjectITSMConfigItemObject = $Kernel::OM->Get('Kernel::System::LinkObject::ITSMConfigItem');

=cut

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    return bless {}, $Type;
}

=head2 LinkListWithData()

fill up the link list with data

    $Success = $LinkObjectBackend->LinkListWithData(
        LinkList => $HashRef,
        UserID   => 1,
    );

=cut

sub LinkListWithData {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Argument (qw(LinkList UserID)) {
        if ( !$Param{$Argument} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Argument!",
            );

            return;
        }
    }

    # check link list
    if ( ref $Param{LinkList} ne 'HASH' ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => 'LinkList must be a hash reference!',
        );

        return;
    }

    for my $LinkType ( sort keys %{ $Param{LinkList} } ) {

        for my $Direction ( sort keys %{ $Param{LinkList}->{$LinkType} } ) {

            CONFIGITEMID:
            for my $ConfigItemID ( sort keys %{ $Param{LinkList}->{$LinkType}->{$Direction} } ) {

                # get last version data
                my $ConfigItem = $Kernel::OM->Get('Kernel::System::ITSMConfigItem')->ConfigItemGet(
                    ConfigItemID => $ConfigItemID,
                );

                # remove id from hash if config item can not get
                if ( !$ConfigItem || ref $ConfigItem ne 'HASH' || !%{$ConfigItem} ) {
                    delete $Param{LinkList}->{$LinkType}->{$Direction}->{$ConfigItemID};
                    next CONFIGITEMID;
                }

                # add version data
                $Param{LinkList}->{$LinkType}->{$Direction}->{$ConfigItemID} = $ConfigItem;
            }
        }
    }

    return 1;
}

=head2 ObjectPermission()

checks read permission for a given object and UserID.

    $Permission = $LinkObject->ObjectPermission(
        Object  => 'ITSMConfigItem',
        Key     => 123,
        UserID  => 1,
    );

=cut

sub ObjectPermission {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Argument (qw(Object Key UserID)) {
        if ( !$Param{$Argument} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Argument!",
            );

            return;
        }
    }

    # get config of configitem zoom frontend module
    $Self->{Config} = $Kernel::OM->Get('Kernel::Config')->Get('ITSMConfigItem::Frontend::AgentITSMConfigItemZoom');

    # check for access rights
    my $Access = $Kernel::OM->Get('Kernel::System::ITSMConfigItem')->Permission(
        Scope  => 'Item',
        ItemID => $Param{Key},
        UserID => $Param{UserID},
        Type   => $Self->{Config}->{Permission},
    );

    return $Access;
}

=head2 ObjectDescriptionGet()

return a hash of object descriptions

    %Description = $LinkObject->ObjectDescriptionGet(
        Key     => 123,
        UserID  => 1,
    );

Returns:

    %Description = (
        Normal => "ConfigItem# 1234455",
        Long   => "ConfigItem# 1234455: The Config Item Title",
    );

=cut

sub ObjectDescriptionGet {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Argument (qw(Object Key UserID)) {
        if ( !$Param{$Argument} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Argument!",
            );

            return;
        }
    }

    # create description
    my %Description = (
        Normal => 'ConfigItem',
        Long   => 'ConfigItem',
    );

    return %Description if $Param{Mode} && $Param{Mode} eq 'Temporary';

    # get last version data
    my $ConfigItem = $Kernel::OM->Get('Kernel::System::ITSMConfigItem')->ConfigItemGet(
        ConfigItemID => $Param{Key},
    );

    return if !$ConfigItem;
    return if ref $ConfigItem ne 'HASH';
    return if !%{$ConfigItem};

    # create description
    %Description = (
        Normal => "ConfigItem# $ConfigItem->{Number}",
        Long   => "ConfigItem# $ConfigItem->{Number}: $ConfigItem->{Name}",
    );

    return %Description;
}

=head2 ObjectSearch()

return a hash list of the search results

    $SearchList = $LinkObjectBackend->ObjectSearch(
        SubObject    => '25',        # (optional)
        SearchParams => $HashRef,    # (optional)
        UserID       => 1,
    );

Returns:

    $SearchList = {
        C<NOTLINKED> => {
            Source => {
                12  => $DataOfItem12,
                212 => $DataOfItem212,
                332 => $DataOfItem332,
            },
        },
    };

=cut

sub ObjectSearch {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    if ( !$Param{UserID} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => 'Need UserID!',
        );

        return;
    }

    # set default params
    $Param{SearchParams} ||= {};

    # set focus
    my %Search;
    for my $Element (qw(Number Name)) {
        if ( $Param{SearchParams}->{$Element} ) {
            $Search{$Element} = '%' . $Param{SearchParams}->{$Element} . '%';
        }
    }

    if ( !$Param{SubObject} ) {

        # get the config with the default subobjects
        my $DefaultSubobject = $Kernel::OM->Get('Kernel::Config')->Get('LinkObject::DefaultSubObject') || {};

        # extract default class name
        my $DefaultClass = $DefaultSubobject->{ITSMConfigItem} || '';

        # get class list
        my $ClassList = $Kernel::OM->Get('Kernel::System::GeneralCatalog')->ItemList(
            Class => 'ITSM::ConfigItem::Class',
        );

        return if !$ClassList;
        return if ref $ClassList ne 'HASH';

        # lookup the class id
        my %ClassListReverse = reverse %{$ClassList};
        $Param{SubObject} = $ClassListReverse{$DefaultClass} || '';
    }

    return if !$Param{SubObject};

    # search the config items
    my @ConfigItemIDs = $Kernel::OM->Get('Kernel::System::ITSMConfigItem')->ConfigItemSearch(
        %{ $Param{SearchParams} },
        %Search,
        ClassIDs       => [ $Param{SubObject} ],
        UsingWildcards => 1,
        SortBy         => ['Number'],
        OrderBy        => ['Up'],
        Limit          => 50,
        UserID         => $Param{UserID},
        Result         => 'ARRAY',
    );

    my %SearchList;
    CONFIGITEMID:
    for my $ConfigItemID (@ConfigItemIDs) {

        # get last version data
        my $ConfigItem = $Kernel::OM->Get('Kernel::System::ITSMConfigItem')->ConfigItemGet(
            ConfigItemID => $ConfigItemID,
        );

        next CONFIGITEMID if !$ConfigItem;
        next CONFIGITEMID if ref $ConfigItem ne 'HASH';
        next CONFIGITEMID if !%{$ConfigItem};

        # add version data
        $SearchList{NOTLINKED}->{Source}->{$ConfigItemID} = $ConfigItem;
    }

    return \%SearchList;
}

=head2 LinkAddPre()

link add pre event module

    $True = $LinkObject->LinkAddPre(
        Key          => 123,
        SourceObject => 'ITSMConfigItem',
        SourceKey    => 321,
        Type         => 'Normal',
        State        => 'Valid',
        UserID       => 1,
    );

or

    $True = $LinkObject->LinkAddPre(
        Key          => 123,
        TargetObject => 'ITSMConfigItem',
        TargetKey    => 321,
        Type         => 'Normal',
        State        => 'Valid',
        UserID       => 1,
    );

=cut

sub LinkAddPre {
    return 1;    # nothing to do
}

=head2 LinkAddPost()

link add post event module

    $True = $LinkObject->LinkAddPost(
        Key          => 123,
        SourceObject => 'ITSMConfigItem',
        SourceKey    => 321,
        Type         => 'Normal',
        State        => 'Valid',
        UserID       => 1,
    );

or

    $True = $LinkObject->LinkAddPost(
        Key          => 123,
        TargetObject => 'ITSMConfigItem',
        TargetKey    => 321,
        Type         => 'Normal',
        State        => 'Valid',
        UserID       => 1,
    );

=cut

sub LinkAddPost {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Argument (qw(Key Type State UserID)) {
        if ( !$Param{$Argument} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Argument!",
            );

            return;
        }
    }

    # do not note update configitem_link table for temporary links
    # do not note recalculate the current in incident state for temporary links
    # do not trigger event for temporary links
    return 1 if $Param{State} eq 'Temporary';

    my $ConfigItemObject = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');

    # sync the new link to the configitem_link table.
    # This is only needed for one direction.
    if ( $Param{TargetKey} && ( $Param{TargetObject} // '' ) eq 'ITSMConfigItem' ) {
        $ConfigItemObject->AddConfigItemLink(
            Type               => $Param{Type},
            SourceConfigItemID => $Param{Key},
            TargetConfigItemID => $Param{TargetKey},
        );
    }

    # Recalculate the current incident state of this CI.
    # This is possible as the table configitem_link is already updated.
    $ConfigItemObject->CurInciStateRecalc(
        ConfigItemID => $Param{Key},
    );

    # trigger LinkAdd event, the comment is a kind of hidden channel
    my $Comment = join '%%',
        ( $Param{TargetKey}    || $Param{SourceKey} ),
        ( $Param{TargetObject} || $Param{SourceObject} );
    $ConfigItemObject->EventHandler(
        Event => 'LinkAdd',
        Data  => {
            ConfigItemID => $Param{Key},
            Comment      => $Comment,
            Type         => $Param{Type},
        },
        UserID => $Param{UserID},
    );

    return 1;
}

=head2 LinkDeletePre()

link delete pre event module

    $True = $LinkObject->LinkDeletePre(
        Key          => 123,
        SourceObject => 'ITSMConfigItem',
        SourceKey    => 321,
        Type         => 'Normal',
        State        => 'Valid',
        UserID       => 1,
    );

or

    $True = $LinkObject->LinkDeletePre(
        Key          => 123,
        TargetObject => 'ITSMConfigItem',
        TargetKey    => 321,
        Type         => 'Normal',
        State        => 'Valid',
        UserID       => 1,
    );

=cut

sub LinkDeletePre {
    return 1;    # nothing to do
}

=head2 LinkDeletePost()

link delete post event module

    $True = $LinkObject->LinkDeletePost(
        Key          => 123,
        SourceObject => 'ITSMConfigItem',
        SourceKey    => 321,
        Type         => 'Normal',
        State        => 'Valid',
        UserID       => 1,
    );

or

    $True = $LinkObject->LinkDeletePost(
        Key          => 123,
        TargetObject => 'ITSMConfigItem',
        TargetKey    => 321,
        Type         => 'Normal',
        State        => 'Valid',
        UserID       => 1,
    );

=cut

sub LinkDeletePost {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Argument (qw(Key Type State UserID)) {
        if ( !$Param{$Argument} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Argument!",
            );

            return;
        }
    }

    # do not note update configitem_link table for temporary links
    # do not note recalculate the current in incident state for temporary links
    # do not trigger event for temporary links
    return 1 if $Param{State} eq 'Temporary';

    my $ConfigItemObject = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');

    # sync the deletee link to the configitem_link table.
    # This is only needed for one direction.
    if ( $Param{TargetKey} && ( $Param{TargetObject} // '' ) eq 'ITSMConfigItem' ) {
        $ConfigItemObject->DeleteConfigItemLink(
            Type               => $Param{Type},
            SourceConfigItemID => $Param{Key},
            TargetConfigItemID => $Param{TargetKey},
        );
    }

    # Recalculate the current incident state of this CI.
    # This is possible as the table configitem_link is already updated.
    $ConfigItemObject->CurInciStateRecalc(
        ConfigItemID => $Param{Key},
    );

    # trigger LinkDelete event, the comment is a kind of hidden channel
    my $Comment = join '::',
        ( $Param{TargetKey}    || $Param{SourceKey} ),
        ( $Param{TargetObject} || $Param{SourceObject} );
    $ConfigItemObject->EventHandler(
        Event => 'LinkDelete',
        Data  => {
            ConfigItemID => $Param{Key},
            Comment      => $Comment,
        },
        UserID => $Param{UserID},
    );

    return 1;
}

1;

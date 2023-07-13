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

package Kernel::System::ITSMConfigItem::Version;

use v5.24;
use strict;
use warnings;
use namespace::autoclean;
use utf8;

# core modules
use List::Util qw(any);

# CPAN modules

# OTOBO modules
use Kernel::System::VariableCheck qw(:all);

our $ObjectManagerDisabled = 1;

=head1 NAME

Kernel::System::ITSMConfigItem::Version - sub module of Kernel::System::ITSMConfigItem

=head1 DESCRIPTION

All version functions for ITSMConfigItem objects.

=head1 PUBLIC INTERFACE

=head2 VersionZoomList()

return a config item version list as array-hash reference

    my $VersionListRef = $ConfigItemObject->VersionZoomList(
        ConfigItemID => 123,
    );

=cut

sub VersionZoomList {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    if ( !$Param{ConfigItemID} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => 'Need ConfigItemID!',
        );
        return;
    }

    # get config item
    my $ConfigItem = $Self->ConfigItemGet(
        ConfigItemID => $Param{ConfigItemID},
    );

    # get version zoom list
    $Kernel::OM->Get('Kernel::System::DB')->Prepare(
        SQL => <<'END_SQL',
SELECT id, name, depl_state_id, inci_state_id, create_time, create_by, change_time, change_by
  FROM configitem_version
  WHERE configitem_id = ?
  ORDER BY id
END_SQL
        Bind => [ \$Param{ConfigItemID} ],
    );

    # fetch the result
    my @VersionList;
    while ( my @Row = $Kernel::OM->Get('Kernel::System::DB')->FetchrowArray() ) {
        push @VersionList,
            {
                VersionID   => $Row[0],
                Name        => $Row[1],
                DeplStateID => $Row[2],
                InciStateID => $Row[3],
                CreateTime  => $Row[4],
                CreateBy    => $Row[5],
                ChangeTime  => $Row[6],
                ChangeBy    => $Row[7],
            };

    }

    for my $Version (@VersionList) {

        # get deployment state functionality
        my $DeplState = $Kernel::OM->Get('Kernel::System::GeneralCatalog')->ItemGet(
            ItemID => $Version->{DeplStateID},
        );

        $Version->{DeplState}     = $DeplState->{Name};
        $Version->{DeplStateType} = $DeplState->{Functionality};

        # get incident state functionality
        my $InciState = $Kernel::OM->Get('Kernel::System::GeneralCatalog')->ItemGet(
            ItemID => $Version->{InciStateID},
        );

        $Version->{InciState}     = $InciState->{Name};
        $Version->{InciStateType} = $InciState->{Functionality};

        # add config item data
        $Version->{ClassID}          = $ConfigItem->{ClassID};
        $Version->{Class}            = $ConfigItem->{Class};
        $Version->{Number}           = $ConfigItem->{Number};
        $Version->{CurDeplStateID}   = $ConfigItem->{CurDeplStateID};
        $Version->{CurDeplState}     = $ConfigItem->{CurDeplState};
        $Version->{CurDeplStateType} = $ConfigItem->{CurDeplStateType};
        $Version->{CurInciStateID}   = $ConfigItem->{CurInciStateID};
        $Version->{CurInciState}     = $ConfigItem->{CurInciState};
        $Version->{CurInciStateType} = $ConfigItem->{CurInciStateType};
    }

    return \@VersionList;
}

=head2 VersionListAll()

Returns a two-dimensional hash reference with the config item ids as keys of the first level
and the corresponding version ids as keys of the second level,
then followed by the version data as hash reference.

    my $VersionListRef = $ConfigItemObject->VersionListAll(
        ConfigItemIDs => [ 1, 2, 3, 4, ...],    # optional

        OlderDate     => '2014-12-22 23:59:59', # optional
                                                # finds versions older than the given date
                                                # Format MUST be
                                                # YYYY-MM-DD HH:MM:SS
                                                # fill missing values with 0 first
                                                # Example: 2014-04-01 07:03:04
                                                # otherwise it won't be taken as
                                                # valid search parameter

        Limit         => 1000000,               # optional
    );

Returns:

    $VersionListRef = {

        # ConfigItemID
        1 => {

            # VersionID
            100 => {
                VersionID    => 100,
                ConfigItemID => 1,
                Name         => 'ConfigItem1',
                DefinitionID => 5,
                DeplStateID  => 3,
                InciStateID  => 2,
                CreateTime   => '2016-03-22 17:58:00',
                CreateBy     => 1,
            },

            # VersionID
            101 => {
                VersionID    => 101,
                ConfigItemID => 1,
                Name         => 'ConfigItem2',
                DefinitionID => 5,
                DeplStateID  => 3,
                InciStateID  => 2,
                CreateTime   => '2016-03-22 17:58:00',
                CreateBy     => 1,
            },
        },

        # ConfigItemID
        2 => {

            # VersionID
            150 => {
                VersionID    => 150,
                ConfigItemID => 2,
                Name         => 'ConfigItem1',
                DefinitionID => 5,
                DeplStateID  => 3,
                InciStateID  => 2,
                CreateTime   => '2016-03-22 17:58:00',
                CreateBy     => 1,
            },

            # VersionID
            151 => {
                VersionID    => 151,
                ConfigItemID => 2,
                Name         => 'ConfigItem1',
                DefinitionID => 5,
                DeplStateID  => 3,
                InciStateID  => 2,
                CreateTime   => '2016-03-22 17:58:00',
                CreateBy     => 1,
            },
        },
    };

=cut

sub VersionListAll {
    my ( $Self, %Param ) = @_;

    # collect the conditions for the WHERE clause
    my @Conditions;
    my @BindParameter;

    # if we got ConfigItemIDs make sure we just have numeric ids,
    # extract those and use it for the query
    if ( IsArrayRefWithData( $Param{ConfigItemIDs} ) ) {
        my @ConfigItemIDs = grep { $_ =~ m/^\d+$/ } @{ $Param{ConfigItemIDs} };
        push @Conditions, 'configitem_id IN (' . join ', ', @ConfigItemIDs . ')';
    }

    if ( $Param{OlderDate} && $Param{OlderDate} =~ m/^\d{4}\-\d{2}\-\d{2}\ \d{2}\:\d{2}:\d{2}$/ ) {
        push @Conditions,    'create_time < ?';
        push @BindParameter, \$Param{OlderDate};
    }

    # build sql
    my $SQL = <<'END_SQL';
SELECT id, configitem_id, name, definition_id, depl_state_id, inci_state_id,
    create_time, create_by, change_time, change_by
  FROM configitem_version
END_SQL

    if (@Conditions) {
        $SQL .= 'WHERE ' . join ' AND ', @Conditions;
    }

    # set limit
    if ( $Param{Limit} ) {
        $Param{Limit} = $Kernel::OM->Get('Kernel::System::DB')->Quote( $Param{Limit}, 'Integer' );
    }

    if (@BindParameter) {
        $Kernel::OM->Get('Kernel::System::DB')->Prepare(
            SQL   => $SQL,
            Bind  => \@BindParameter,
            Limit => $Param{Limit},
        );
    }
    else {
        $Kernel::OM->Get('Kernel::System::DB')->Prepare(
            SQL   => $SQL,
            Limit => $Param{Limit},
        );
    }

    my %Results;
    while ( my @Row = $Kernel::OM->Get('Kernel::System::DB')->FetchrowArray() ) {
        $Results{ $Row[1] }->{ $Row[0] } = {
            VersionID    => $Row[0],
            ConfigItemID => $Row[1],
            Name         => $Row[2] || '',
            DefinitionID => $Row[3] || '',
            DeplStateID  => $Row[4] || '',
            InciStateID  => $Row[5] || '',
            CreateTime   => $Row[6] || '',
            CreateBy     => $Row[7] || '',
            ChangeTime   => $Row[8] || '',
            ChangeBy     => $Row[9] || '',
        };
    }

    return \%Results;
}

=head2 VersionList()

return a config item version list as array reference

    my $VersionListRef = $ConfigItemObject->VersionList(
        ConfigItemID => 123,
    );

=cut

sub VersionList {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    if ( !$Param{ConfigItemID} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => 'Need ConfigItemID!',
        );
        return;
    }

    # get version list
    $Kernel::OM->Get('Kernel::System::DB')->Prepare(
        SQL  => 'SELECT id FROM configitem_version WHERE configitem_id = ? ORDER BY id',
        Bind => [ \$Param{ConfigItemID} ],
    );

    # fetch the result
    my @VersionList;
    while ( my ($Id) = $Kernel::OM->Get('Kernel::System::DB')->FetchrowArray() ) {
        push @VersionList, $Id;
    }

    return \@VersionList;
}

=head2 VersionNameGet()

returns the name of a version of a config item.

    my $VersionName = $ConfigItemObject->VersionNameGet(
        VersionID => 123,
    );

or

    my $VersionName = $ConfigItemObject->VersionNameGet(
        ConfigItemID => 123,
    );

=cut

sub VersionNameGet {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    if ( !$Param{VersionID} && !$Param{ConfigItemID} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => 'Need VersionID or ConfigItemID!',
        );
        return;
    }

    my $CacheObject = $Kernel::OM->Get('Kernel::System::Cache');

    if ( $Param{VersionID} ) {

        # check if result is already cached
        my $CacheKey = 'VersionNameGet::VersionID::' . $Param{VersionID};
        my $Cache    = $CacheObject->Get(
            Type => $Self->{CacheType},
            Key  => $CacheKey,
        );
        return ${$Cache} if $Cache;

        # get version
        $Kernel::OM->Get('Kernel::System::DB')->Prepare(
            SQL => 'SELECT id, name '
                . 'FROM configitem_version WHERE id = ?',
            Bind  => [ \$Param{VersionID} ],
            Limit => 1,
        );
    }
    else {

        # check if result is already cached
        my $CacheKey = 'VersionNameGet::ConfigItemID::' . $Param{ConfigItemID};
        my $Cache    = $CacheObject->Get(
            Type => $Self->{CacheType},
            Key  => $CacheKey,
        );
        return ${$Cache} if $Cache;

        # get version
        $Kernel::OM->Get('Kernel::System::DB')->Prepare(
            SQL => 'SELECT id, name '
                . 'FROM configitem_version '
                . 'WHERE configitem_id = ? ORDER BY id DESC',
            Bind  => [ \$Param{ConfigItemID} ],
            Limit => 1,
        );
    }

    # fetch the result
    my %Version;
    while ( my ( $Id, $Name ) = $Kernel::OM->Get('Kernel::System::DB')->FetchrowArray() ) {
        $Version{VersionID} = $Id;
        $Version{Name}      = $Name;
    }

    # check version
    if ( !$Version{VersionID} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => 'No such config item version!',
        );
        return;
    }

    # set cache for VersionID (always)
    my $CacheKey = 'VersionNameGet::VersionID::' . $Version{VersionID};
    $CacheObject->Set(
        Type  => $Self->{CacheType},
        TTL   => $Self->{CacheTTL},
        Key   => $CacheKey,
        Value => \$Version{Name},
    );

    # set cache for ConfigItemID (only if called with ConfigItemID)
    if ( $Param{ConfigItemID} ) {
        $CacheKey = 'VersionNameGet::ConfigItemID::' . $Param{ConfigItemID};
        $CacheObject->Set(
            Type  => $Self->{CacheType},
            TTL   => $Self->{CacheTTL},
            Key   => $CacheKey,
            Value => \$Version{Name},
        );
    }

    return $Version{Name};
}

=head2 VersionConfigItemIDGet()

return the config item id of a version

    my $ConfigItemID = $ConfigItemObject->VersionConfigItemIDGet(
        VersionID => 123,
    );

=cut

sub VersionConfigItemIDGet {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    if ( !$Param{VersionID} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => 'Need VersionID!',
        );
        return;
    }

    # check if result is already cached
    return $Self->{Cache}->{VersionConfigItemIDGet}->{ $Param{VersionID} }
        if $Self->{Cache}->{VersionConfigItemIDGet}->{ $Param{VersionID} };

    # get config item id
    $Kernel::OM->Get('Kernel::System::DB')->Prepare(
        SQL   => 'SELECT configitem_id FROM configitem_version WHERE id = ?',
        Bind  => [ \$Param{VersionID} ],
        Limit => 1,
    );

    # fetch the result
    my $ConfigItemID;
    while ( my ($Id) = $Kernel::OM->Get('Kernel::System::DB')->FetchrowArray() ) {
        $ConfigItemID = $Id;
    }

    # cache the result
    $Self->{Cache}->{VersionConfigItemIDGet}->{ $Param{VersionID} } = $ConfigItemID;

    return $ConfigItemID;
}

=head2 VersionAdd()

add a new version

    my $VersionID = $ConfigItemObject->VersionAdd(
        ConfigItemID      => 123,
        LastVersion       => {...}          # either ConfigItemID or LastVersion is mandatory
        UserID            => 1,
        Name              => 'The Name',    # optional
        DeplStateID       => 8,             # optional
        InciStateID       => 4,             # optional
        DynamicField_Name => $Value,        # optional
    );

=cut

sub VersionAdd {
    my ( $Self, %Param ) = @_;

    my $LastVersion = $Param{LastVersion} ? $Param{LastVersion} : $Self->ConfigItemGet(
        ConfigItemID  => $Param{ConfigItemID},
        DynamicFields => 1,
    );

    my %Version = (
        $LastVersion->%*,
        %Param,
    );

    # check needed stuff
    for my $Attribute (qw(ConfigItemID Name DeplStateID InciStateID UserID)) {
        if ( !$Version{$Attribute} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Attribute!",
            );

            return;
        }
    }

    my $Definition = $Self->DefinitionGet(
        ClassID => $Version{ClassID},
    );

    if ( !$Definition ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "Need Definition!",
        );

        return;
    }

    my $DBObject = $Kernel::OM->Get('Kernel::System::DB');

    # insert new version
    my $Success = $DBObject->Do(
        SQL => <<'END_SQL',
INSERT INTO configitem_version (
    configitem_id, name, definition_id, depl_state_id, inci_state_id,
    create_time, create_by, change_time, change_by
)
VALUES (
    ?, ?, ?, ?, ?,
   current_timestamp, ?, current_timestamp, ?
)
END_SQL
        Bind => [
            \$Version{ConfigItemID},
            \$Version{Name},
            \$Definition->{DefinitionID},
            \$Version{DeplStateID},
            \$Version{InciStateID},
            \$Param{UserID},
            \$Param{UserID},
        ],
    );

    return unless $Success;

    # get id of new version
    # TODO: what about concurrent inserts ?
    $DBObject->Prepare(
        SQL => 'SELECT id, create_time FROM configitem_version WHERE '
            . 'configitem_id = ? ORDER BY id DESC',
        Bind  => [ \$Version{ConfigItemID} ],
        Limit => 1,
    );

    # fetch the result
    my $VersionID;
    my $CreateTime;
    while ( my ( $Id, $Time ) = $DBObject->FetchrowArray() ) {
        $VersionID  = $Id;
        $CreateTime = $Time;
    }

    # check version id
    if ( !$VersionID ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "Can't get the new version id!",
        );

        return;
    }

    # update last version of config item
    $Success = $Kernel::OM->Get('Kernel::System::DB')->Do(
        SQL  => 'UPDATE configitem SET last_version_id = ?, change_time = ?, change_by = ? WHERE id = ?',
        Bind => [ \$VersionID, \$CreateTime, \$Param{UserID}, \$Version{ConfigItemID} ],
    );

    return unless $Success;

    my $DynamicFieldBackendObject = $Kernel::OM->Get('Kernel::System::DynamicField::Backend');

    DYNAMICFIELD:
    for my $DynamicField ( values $Definition->{DynamicFieldRef}->%* ) {
        next DYNAMICFIELD if !defined $Version{ 'DynamicField_' . $DynamicField->{Name} };

        $DynamicFieldBackendObject->ValueSet(
            DynamicFieldConfig => $DynamicField,
            ObjectID           => $VersionID,
            Value              => $Version{ 'DynamicField_' . $DynamicField->{Name} },
            UserID             => $Param{UserID},
        );
    }

    # trigger VersionCreate event
    $Self->EventHandler(
        Event => 'VersionCreate',
        Data  => {
            ConfigItemID => $Version{ConfigItemID},
            Comment      => $VersionID,
            OldDeplState => $LastVersion->{CurDeplState},
        },
        UserID => $Param{UserID},
    );

    # TODO: Incorporate somewhere probably
    #    # trigger definition update event
    #    if ( $Events->{DefinitionUpdate} ) {
    #        $Self->EventHandler(
    #            Event => 'DefinitionUpdate',
    #            Data  => {
    #                ConfigItemID => $Param{ConfigItemID},
    #                Comment      => $Events->{DefinitionUpdate},
    #            },
    #            UserID => $Param{UserID},
    #        );
    #    }

    my $CacheObject = $Kernel::OM->Get('Kernel::System::Cache');
    for my $DFData (qw(0 1)) {
        $CacheObject->Delete(
            Type => $Self->{CacheType},
            Key  => 'ConfigItemGet::ConfigItemID::' . $Version{ConfigItemID} . '::' . $DFData,
        );
    }

    # recalculate the current incident state of all linked config items
    $Self->CurInciStateRecalc(
        ConfigItemID => $Version{ConfigItemID},
    );

    return $VersionID;
}

=head2 VersionUpdate()

update a version

    my $VersionID = $ConfigItemObject->VersionUpdate(
        VersionID         => 123,
        Version           => {...}          # either VersionID or Version is mandatory
        UserID            => 1,
        Name              => 'The Name',    # optional
        DeplStateID       => 8,             # optional
        InciStateID       => 4,             # optional
        DynamicField_Name => $Value,        # optional
    );

=cut

sub VersionUpdate {
    my ( $Self, %Param ) = @_;

    my $Version = $Param{Version} ? $Param{Version} : $Self->ConfigItemGet(
        VersionID     => $Param{VersionID},
        DynamicFields => 1,
    );

    # check needed stuff
    for my $Attribute (qw(UserID)) {
        if ( !$Param{$Attribute} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Attribute!",
            );

            return;
        }
    }

    if ( !$Version ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "Need Version or VersionID!",
        );

        return;
    }

    my $CurInciStateRecalc = $Param{InciStateID} && $Version->{VersionID} eq $Version->{LastVersionID} ? 1 : 0;

    if ( any { defined $Param{$_} } qw/Name DeplStateID InciStateID DefinitionID/ ) {
        my $DBObject = $Kernel::OM->Get('Kernel::System::DB');

        for my $Attribute (qw/Name DeplStateID InciStateID DefinitionID/) {
            $Param{$Attribute} ||= $Version->{$Attribute};
        }

        # TODO: maybe include change_time change_by
        # insert new version
        my $Success = $DBObject->Do(
            SQL => <<'END_SQL',
UPDATE configitem_version
  SET name = ?, definition_id = ?, depl_state_id = ?, inci_state_id = ?, change_time = current_timestamp, change_by = ?
  WHERE id = ?
END_SQL
            Bind => [
                \$Param{Name},
                \$Param{DefinitionID},
                \$Param{DeplStateID},
                \$Param{InciStateID},
                \$Param{UserID},
                \$Version->{VersionID},
            ],
        );

        return unless $Success;
    }

    my $Definition = $Self->DefinitionGet(
        ClassID => $Version->{ClassID},
    );

    my $DynamicFieldBackendObject = $Kernel::OM->Get('Kernel::System::DynamicField::Backend');

    DYNAMICFIELD:
    for my $Attribute ( keys %Param ) {
        next DYNAMICFIELD unless $Attribute =~ m/^DynamicField_(.+)/;
        next DYNAMICFIELD unless $Definition->{DynamicFieldRef}{$1};

        $DynamicFieldBackendObject->ValueSet(
            DynamicFieldConfig => $Definition->{DynamicFieldRef}{$1},
            ObjectID           => $Version->{VersionID},
            Value              => $Param{$Attribute},
            UserID             => $Param{UserID},
        );
    }

    #    # TODO: a separate VersionUpdate event is probably not necessary
    #    # trigger VersionCreate event
    #    $Self->EventHandler(
    #        Event => 'VersionCreate',
    #        Data  => {
    #            ConfigItemID => $Version{ConfigItemID},
    #            Comment      => $VersionID,
    #            OldDeplState => $LastVersion->{CurDeplState},
    #        },
    #        UserID => $Param{UserID},
    #    );

    my $CacheObject = $Kernel::OM->Get('Kernel::System::Cache');
    for my $DFData (qw(0 1)) {
        $CacheObject->Delete(
            Type => $Self->{CacheType},
            Key  => 'ConfigItemGet::VersionID::' . $Version->{VersionID} . '::' . $DFData,
        );
        $CacheObject->Delete(
            Type => $Self->{CacheType},
            Key  => 'ConfigItemGet::ConfigItemID::' . $Version->{ConfigItemID} . '::' . $DFData,
        );
    }

    # TODO: Think about this when including VersionNumber
    $CacheObject->Delete(
        Type => $Self->{CacheType},
        Key  => 'VersionNameGet::VersionID::' . $Version->{VersionID},
    );

    if ($CurInciStateRecalc) {

        # recalculate the current incident state of all linked config items
        $Self->CurInciStateRecalc(
            ConfigItemID => $Version->{ConfigItemID},
        );
    }

    return 1;
}

=head2 VersionDelete()

delete an existing version or versions

    my $True = $ConfigItemObject->VersionDelete(
        VersionID => 123,
        UserID    => 1,
    );

or

    my $True = $ConfigItemObject->VersionDelete(
        ConfigItemID => 321,
        UserID       => 1,
    );

or

    my $True = $ConfigItemObject->VersionDelete(
        VersionIDs => [ 1, 2, 3, 4 ],
        UserID     => 1,
    );

=cut

sub VersionDelete {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    if ( !$Param{UserID} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => 'Need UserID!',
        );
        return;
    }

    if ( !$Param{VersionID} && !$Param{ConfigItemID} && !IsArrayRefWithData( $Param{VersionIDs} ) ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => 'Need VersionID, ConfigItemID or VersionIDs!',
        );
        return;
    }

    my $VersionList = [];
    if ( $Param{VersionID} ) {
        push @{$VersionList}, $Param{VersionID};
    }
    elsif ( $Param{VersionIDs} ) {
        push @{$VersionList}, @{ $Param{VersionIDs} };
    }
    else {
        # get version list
        $VersionList = $Self->VersionList(
            ConfigItemID => $Param{ConfigItemID},
        );
    }

    return 1 if !scalar @{$VersionList};

    # get config item id for version (needed for event handling)
    my $ConfigItemID = $Param{ConfigItemID};

    my $CacheObject = $Kernel::OM->Get('Kernel::System::Cache');

    # to store unique config item ids if there are versions from different config items
    my %ConfigItemIDs;

    my $Success;
    for my $VersionID ( @{$VersionList} ) {

        # get configitem id if neccessary
        if ( $Param{VersionID} || $Param{VersionIDs} ) {
            $ConfigItemID = $Self->VersionConfigItemIDGet(
                VersionID => $VersionID,
            );
        }

        # remember the unique config item ids
        $ConfigItemIDs{$ConfigItemID} = 1;

        # delete the xml version data
        $Self->_XMLVersionDelete(
            VersionID => $VersionID,
            UserID    => $Param{UserID},
        );

        # delete version
        $Success = $Kernel::OM->Get('Kernel::System::DB')->Do(
            SQL  => 'DELETE FROM configitem_version WHERE id = ?',
            Bind => [ \$VersionID ],
        );

        # trigger VersionDelete event when deletion was successful
        if ($Success) {

            $Self->EventHandler(
                Event => 'VersionDelete',
                Data  => {
                    ConfigItemID => $ConfigItemID,
                    Comment      => $VersionID,
                },
                UserID => $Param{UserID},
            );

            # delete affected caches
            my $CacheKey = 'ConfigItemGet::VersionID::' . $VersionID . '::DFData::';
            for my $DFData (qw(0 1)) {
                $CacheObject->Delete(
                    Type => $Self->{CacheType},
                    Key  => $CacheKey . $DFData,
                );
            }
            $CacheObject->Delete(
                Type => $Self->{CacheType},
                Key  => 'VersionNameGet::VersionID::' . $VersionID,
            );

            delete $Self->{Cache}->{VersionConfigItemIDGet}->{$VersionID};
        }
    }

    for my $ConfigItemID ( sort keys %ConfigItemIDs ) {

        # delete affected caches for ConfigItemID (most recent version might have been removed)
        my $CacheKey = 'ConfigItemGet::ConfigItemID::' . $ConfigItemID . '::DFData::';
        for my $DFData (qw(0 1)) {
            $CacheObject->Delete(
                Type => $Self->{CacheType},
                Key  => $CacheKey . $DFData,
            );
        }
        $CacheObject->Delete(
            Type => $Self->{CacheType},
            Key  => 'VersionNameGet::ConfigItemID::' . $ConfigItemID,
        );
    }

    return $Success;
}

=head2 VersionSearch()

return a config item list as an array reference

    my $ConfigItemIDs = $ConfigItemObject->VersionSearch(
        Name         => 'The Name',      # (optional)
        ClassIDs     => [ 9, 8, 7, 6 ],  # (optional)
        DeplStateIDs => [ 321, 123 ],    # (optional)
        InciStateIDs => [ 321, 123 ],    # (optional)

        PreviousVersionSearch => 1,  # (optional) default 0 (0|1)

        OrderBy => [ 'ConfigItemID', 'Number' ],                  # (optional)
        # default: [ 'ConfigItemID' ]
        # (ConfigItemID, Name, Number, ClassID, DeplStateID, InciStateID
        # CreateTime, CreateBy, ChangeTime, ChangeBy)

        # Additional information for OrderBy:
        # The OrderByDirection can be specified for each OrderBy attribute.
        # The pairing is made by the array indices.

        OrderByDirection => [ 'Up', 'Down' ],                    # (optional)
        # default: [ 'Up' ]
        # (Down | Up)

        Limit          => 122,  # (optional)
        UsingWildcards => 0,    # (optional) default 1
    );

=cut

sub VersionSearch {
    my ( $Self, %Param ) = @_;

    # set default values
    if ( !defined $Param{UsingWildcards} ) {
        $Param{UsingWildcards} = 1;
    }

    # verify that all passed array parameters contain an arrayref
    ARGUMENT:
    for my $Argument (
        qw(
            OrderBy
            OrderByDirection
        )
        )
    {
        if ( !defined $Param{$Argument} ) {
            $Param{$Argument} ||= [];

            next ARGUMENT;
        }

        if ( ref $Param{$Argument} ne 'ARRAY' ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "$Argument must be an array reference!",
            );
            return;
        }
    }

    # set default order and order direction
    if ( !@{ $Param{OrderBy} } ) {
        $Param{OrderBy} = ['ConfigItemID'];
    }
    if ( !@{ $Param{OrderByDirection} } ) {
        $Param{OrderByDirection} = ['Up'];
    }

    # define order table
    my %OrderByTable = (
        ConfigItemID => 'vr.configitem_id',
        Name         => 'vr.name',
        Number       => 'ci.configitem_number',
        ClassID      => 'ci.class_id',
        DeplStateID  => 'vr.depl_state_id',
        InciStateID  => 'vr.inci_state_id',
        CreateTime   => 'ci.create_time',
        CreateBy     => 'ci.create_by',

        # the change time of the CI is the same as the create time of the version!
        ChangeTime => 'vr.create_time',

        ChangeBy => 'ci.change_by',
    );

    # check if OrderBy contains only unique valid values
    my %OrderBySeen;
    for my $OrderBy ( @{ $Param{OrderBy} } ) {

        if ( !$OrderBy || !$OrderByTable{$OrderBy} || $OrderBySeen{$OrderBy} ) {

            # found an error
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "OrderBy contains invalid value '$OrderBy' "
                    . 'or the value is used more than once!',
            );
            return;
        }

        # remember the value to check if it appears more than once
        $OrderBySeen{$OrderBy} = 1;
    }

    # check if OrderByDirection array contains only 'Up' or 'Down'
    DIRECTION:
    for my $Direction ( @{ $Param{OrderByDirection} } ) {

        # only 'Up' or 'Down' allowed
        next DIRECTION if $Direction eq 'Up';
        next DIRECTION if $Direction eq 'Down';

        # found an error
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "OrderByDirection can only contain 'Up' or 'Down'!",
        );
        return;
    }

    # assemble the ORDER BY clause
    my @SQLOrderBy;
    my $Count = 0;
    my @OrderBySelectColumns;
    for my $OrderBy ( @{ $Param{OrderBy} } ) {

        # set the default order direction
        my $Direction = 'DESC';

        # add the given order direction
        if ( $Param{OrderByDirection}->[$Count] ) {
            if ( $Param{OrderByDirection}->[$Count] eq 'Up' ) {
                $Direction = 'ASC';
            }
            elsif ( $Param{OrderByDirection}->[$Count] eq 'Down' ) {
                $Direction = 'DESC';
            }
        }

        # add SQL
        push @SQLOrderBy,           "$OrderByTable{$OrderBy} $Direction";
        push @OrderBySelectColumns, $OrderByTable{$OrderBy};

    }
    continue {
        $Count++;
    }

    # get like escape string needed for some databases (e.g. oracle)
    my $LikeEscapeString = $Kernel::OM->Get('Kernel::System::DB')->GetDatabaseFunction('LikeEscapeString');

    # add name to sql where array
    my @SQLWhere;
    if ( defined $Param{Name} && $Param{Name} ne '' ) {

        # duplicate the name
        my $Name = $Param{Name};

        # quote
        $Name = $Kernel::OM->Get('Kernel::System::DB')->Quote($Name);

        if ( $Param{UsingWildcards} ) {

            # prepare like string
            $Self->_PrepareLikeString( \$Name );

            push @SQLWhere, "LOWER(vr.name) LIKE LOWER('$Name') $LikeEscapeString";
        }
        else {
            push @SQLWhere, "LOWER(vr.name) = LOWER('$Name')";
        }
    }

    # set array params
    my %ArrayParams = (
        ClassIDs     => 'ci.id = vr.configitem_id AND ci.class_id',
        DeplStateIDs => 'vr.depl_state_id',
        InciStateIDs => 'vr.inci_state_id',
    );

    ARRAYPARAM:
    for my $ArrayParam ( sort keys %ArrayParams ) {

        next ARRAYPARAM if !$Param{$ArrayParam};

        if ( ref $Param{$ArrayParam} ne 'ARRAY' ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "$ArrayParam must be an array reference!",
            );
            return;
        }

        next ARRAYPARAM if !@{ $Param{$ArrayParam} };

        # quote as integer
        for my $OneParam ( @{ $Param{$ArrayParam} } ) {
            $OneParam = $Kernel::OM->Get('Kernel::System::DB')->Quote( $OneParam, 'Integer' );
        }

        # create string
        my $InString = join q{, }, @{ $Param{$ArrayParam} };

        push @SQLWhere, "$ArrayParams{ $ArrayParam } IN ($InString)";
    }

    # add previous version param
    if ( !$Param{PreviousVersionSearch} ) {
        push @SQLWhere, 'ci.last_version_id = vr.id';
    }

    # create where string
    my $WhereString = @SQLWhere ? ' WHERE ' . join q{ AND }, @SQLWhere : '';

    # set limit, quote as integer
    if ( $Param{Limit} ) {
        $Param{Limit} = $Kernel::OM->Get('Kernel::System::DB')->Quote( $Param{Limit}, 'Integer' );
    }

    # add the order by columns also to the selected columns
    my $OrderBySelectString = '';
    if (@OrderBySelectColumns) {
        $OrderBySelectString = join ', ', @OrderBySelectColumns;
        $OrderBySelectString = ', ' . $OrderBySelectString;
    }

    # build SQL
    my $SQL = "SELECT DISTINCT vr.configitem_id $OrderBySelectString "
        . 'FROM configitem ci, configitem_version vr '
        . $WhereString;

    # add the ORDER BY clause
    if (@SQLOrderBy) {
        $SQL .= ' ORDER BY ';
        $SQL .= join ', ', @SQLOrderBy;
        $SQL .= ' ';
    }

    # ask the database
    $Kernel::OM->Get('Kernel::System::DB')->Prepare(
        SQL   => $SQL,
        Limit => $Param{Limit},
    );

    # fetch the result
    my @ConfigItemList;
    while ( my ($Id) = $Kernel::OM->Get('Kernel::System::DB')->FetchrowArray() ) {
        push @ConfigItemList, $Id;
    }

    return \@ConfigItemList;
}

1;

# --
# OTOBO is a web-based ticketing system for service organisations.
# --
# Copyright (C) 2001-2020 OTRS AG, https://otrs.com/
# Copyright (C) 2019-2025 Rother OSS GmbH, https://otobo.io/
# --
# $origin: otobo - e44c18aea9abc125fddf9ceeed204db4fab290e0 - Kernel/System/ACL/DB/ACL.pm
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

package Kernel::System::ACL::DB::ACL;

use v5.24;
use strict;
use warnings;

# core modules

# CPAN modules

# OTOBO modules
use Kernel::Language              qw(Translatable);
use Kernel::System::VariableCheck qw(:all);

our @ObjectDependencies = (
    'Kernel::Config',
    'Kernel::System::Cache',
    'Kernel::System::DB',
    'Kernel::System::Encode',
    'Kernel::System::Log',
    'Kernel::System::Main',
    'Kernel::System::Storage::S3',
    'Kernel::System::Ticket::FieldRestrictions',
    'Kernel::System::User',
    'Kernel::System::YAML',
);

=head1 NAME

Kernel::System::ACL::DB::ACL

=head1 DESCRIPTION

ACL DB ACL backend

=head1 PUBLIC INTERFACE

=head2 new()

create a ACL object. Do not use it directly, instead use:

    my $ACLObject = $Kernel::OM->Get('Kernel::System::ACL::DB::ACL');

=cut

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = bless {}, $Type;

    # find out whether loader files are stored in S3 or in the file system
    $Self->{S3Active} = $Kernel::OM->Get('Kernel::Config')->Get('Storage::S3::Active') ? 1 : 0;

    # get the cache TTL (in seconds)
    $Self->{CacheTTL} = int( $Kernel::OM->Get('Kernel::Config')->Get('ACL::CacheTTL') || 3600 );

    # set lower if database is case sensitive
    $Self->{Lower} = '';
    if ( $Kernel::OM->Get('Kernel::System::DB')->GetDatabaseFunction('CaseSensitive') ) {
        $Self->{Lower} = 'LOWER';
    }

    return $Self;
}

=head2 ACLAdd()

add new ACL

returns the id of the created ACL if success or undef otherwise

    my $ID = $ACL->ACLAdd(
        Name           => 'NameOfACL'           # mandatory
        Comment        => 'Comment',            # optional
        Description    => 'Description',        # optional
        StopAfterMatch => 1,                    # optional
        ConfigMatch    => $ConfigMatchHashRef,  # optional
        ConfigChange   => $ConfigChangeHashRef, # optional
        ValidID        => 1,                    # mandatory
        UserID         => 123,                  # mandatory
# RotherOSS / ITSMConfigurationManagement
        ObjectType     => 'Ticket',             # optional (currently Ticket or ConfigItem, defaults to Ticket)
# EO ITSMConfigurationManagement
    );

Returns:

    $ID = 567;

=cut

sub ACLAdd {
    my ( $Self, %Param ) = @_;
# Rother OSS / ITSMConfigurationManagement

    # set default for object type
    $Param{ObjectType} //= 'Ticket';
# EO ITSMConfigurationManagement

    # check needed stuff
    for my $Key (qw(Name ValidID UserID)) {
        if ( !$Param{$Key} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Key!",
            );
            return;
        }
    }

    # get yaml object
    my $YAMLObject = $Kernel::OM->Get('Kernel::System::YAML');

    # define Description field if not present
    $Param{Description} //= '';

    my $ConfigMatch  = '';
    my $ConfigChange = '';

    if ( $Param{ConfigMatch} ) {

        if ( !IsHashRefWithData( $Param{ConfigMatch} ) ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "ConfigMatch needs to be a valid hash with data!",
            );
            return;
        }

        $ConfigMatch = $YAMLObject->Dump( Data => $Param{ConfigMatch} );
    }

    if ( $Param{ConfigChange} ) {

        if ( !IsHashRefWithData( $Param{ConfigChange} ) ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "ConfigChange needs to be a valid hash with data!",
            );
            return;
        }

        $ConfigChange = $YAMLObject->Dump( Data => $Param{ConfigChange} );
    }

    # get database object
    my $DBObject = $Kernel::OM->Get('Kernel::System::DB');

    # check if ACL with this name already exists
    return if !$DBObject->Prepare(
        SQL => "
            SELECT id
            FROM acl
            WHERE $Self->{Lower}(name) = $Self->{Lower}(?)",
        Bind  => [ \$Param{Name} ],
        Limit => 1,
    );

    my $ACLExists;
    while ( my @Data = $DBObject->FetchrowArray() ) {
        $ACLExists = 1;
    }

    if ($ACLExists) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "An ACL with the name '$Param{Name}' already exists.",
        );
        return;
    }

    # SQL
    return if !$DBObject->Do(
# RotherOSS / ITSMConfigurationManagement
#         SQL => '
#             INSERT INTO acl ( name, comments, description, stop_after_match, config_match,
#                 config_change, valid_id, create_time, create_by, change_time, change_by )
#             VALUES (?, ?, ?, ?, ?, ?, ?, current_timestamp, ?, current_timestamp, ?)',
        SQL => '
            INSERT INTO acl ( name, comments, description, stop_after_match, config_match,
                config_change, valid_id, object_type, create_time, create_by, change_time, change_by )
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, current_timestamp, ?, current_timestamp, ?)',
# EO ITSMConfigurationManagement
        Bind => [
            \$Param{Name},   \$Param{Comment}, \$Param{Description}, \$Param{StopAfterMatch},
# RotherOSS / ITSMConfigurationManagement
#             \$ConfigMatch,   \$ConfigChange,   \$Param{ValidID},
            \$ConfigMatch,   \$ConfigChange,   \$Param{ValidID}, \$Param{ObjectType},
# EO ITSMConfigurationManagement
            \$Param{UserID}, \$Param{UserID},
        ],
    );

    return if !$DBObject->Prepare(
        SQL  => 'SELECT id FROM acl WHERE name = ?',
        Bind => [ \$Param{Name} ],
    );

    my $ID;
    while ( my @Row = $DBObject->FetchrowArray() ) {
        $ID = $Row[0];
    }

    return if !$ID;

    # delete cache
    $Kernel::OM->Get('Kernel::System::Cache')->CleanUp(
        Type => 'ACLEditor_ACL',
    );

    return if !$DBObject->Do(
        SQL => '
            INSERT INTO acl_sync ( acl_id, sync_state, create_time, change_time )
            VALUES (?, ?, current_timestamp, current_timestamp)',
        Bind => [ \$ID, \'not_sync' ],
    );

    return $ID;
}

=head2 ACLDelete()

delete an ACL

returns 1 if success or undef otherwise

    my $Success = $ACLObject->ACLDelete(
        ID      => 123,
        UserID  => 123,
    );

=cut

sub ACLDelete {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Key (qw(ID UserID)) {
        if ( !$Param{$Key} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Key!"
            );
            return;
        }
    }

    # check if exists
    my $ACL = $Self->ACLGet(
        ID     => $Param{ID},
        UserID => 1,
    );

    return if !IsHashRefWithData($ACL);

    # get database object
    my $DBObject = $Kernel::OM->Get('Kernel::System::DB');

    # delete ACL
    return if !$DBObject->Do(
        SQL  => 'DELETE FROM acl WHERE id = ?',
        Bind => [ \$Param{ID} ],
    );

    # delete cache
    $Kernel::OM->Get('Kernel::System::Cache')->CleanUp(
        Type => 'ACLEditor_ACL',
    );

    return if !$DBObject->Do(
        SQL => '
            INSERT INTO acl_sync ( acl_id, sync_state, create_time, change_time )
            VALUES (?, ?, current_timestamp, current_timestamp)',
        Bind => [ \$Param{ID}, \'deleted' ],
    );

    return 1;
}

=head2 ACLGet()

get ACL attributes

    my $ACL = $ACLObject->ACLGet(
        ID              => 123,          # ID or name is needed
        Name            => 'ACL1',
        UserID          => 123,          # mandatory
    );

Returns:

    $ACL = {
        ID             => 123,
        Name           => 'some name',
        Comment        => 'Comment',
        Description    => 'Description',
        StopAfterMatch => 1,
        ConfigMatch    => $ConfigMatchHashRef,
        ConfigChange   => $ConfigChangeHashRef,
# RotherOSS / ITSMConfigurationManagement
        ObjectType     => ('Ticket'|'ConfigItem')
# EO ITSMConfigurationManagement
        ValidID        => 1,
        CreateTime     => '2012-07-04 15:08:00',
        ChangeTime     => '2012-07-04 15:08:00',
        CreateBy       => 'user_login',
        ChangeBy       => 'user_login',
    };

=cut

sub ACLGet {
    my ( $Self, %Param ) = @_;
# Rother OSS / ITSMConfigurationManagement

    # set default for object type
    $Param{ObjectType} //= 'Ticket';
# EO ITSMConfigurationManagement

    # check needed stuff
    if ( !$Param{ID} && !$Param{Name} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => 'Need ID or Name!'
        );
        return;
    }

    if ( !$Param{UserID} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => 'Need UserID!',
        );
        return;
    }

    # check cache
    my $CacheKey;
    if ( $Param{ID} ) {
        $CacheKey = 'ACLGet::ID::' . $Param{ID};
    }
    else {
        $CacheKey = 'ACLGet::Name::' . $Param{Name};
    }

    # get cache object
    my $CacheObject = $Kernel::OM->Get('Kernel::System::Cache');

    my $Cache = $CacheObject->Get(
        Type => 'ACLEditor_ACL',
        Key  => $CacheKey,
    );
    return $Cache if $Cache;

    # get database object
    my $DBObject = $Kernel::OM->Get('Kernel::System::DB');

    # SQL
    if ( $Param{ID} ) {
        return if !$DBObject->Prepare(
# RotherOSS / ITSMConfigurationManagement
#             SQL => '
#                 SELECT id, name, comments, description, stop_after_match, valid_id, config_match,
#                     config_change, create_time, change_time, create_by, change_by
#                 FROM acl
#                 WHERE id = ?',
            SQL => '
                SELECT id, name, comments, description, stop_after_match, valid_id, config_match,
                    config_change, object_type, create_time, change_time, create_by, change_by
                FROM acl
                WHERE id = ?',
# EO ITSMConfigurationManagement
            Bind  => [ \$Param{ID} ],
            Limit => 1,
        );
    }
    else {
        return if !$DBObject->Prepare(
# RotherOSS / ITSMConfigurationManagement
#             SQL => '
#                 SELECT id, name, comments, description, stop_after_match, valid_id, config_match,
#                     config_change, create_time, change_time, create_by, change_by
#                 FROM acl
#                 WHERE name = ?',
            SQL => '
                SELECT id, name, comments, description, stop_after_match, valid_id, config_match,
                    config_change, object_type, create_time, change_time, create_by, change_by
                FROM acl
                WHERE name = ?',
# EO ITSMConfigurationManagement
            Bind  => [ \$Param{Name} ],
            Limit => 1,
        );
    }

    # get yaml object
    my $YAMLObject = $Kernel::OM->Get('Kernel::System::YAML');

    my %Data;
    while ( my @Data = $DBObject->FetchrowArray() ) {

        my $ConfigMatch = '';
        if ( $Data[6] ) {
            $ConfigMatch = $YAMLObject->Load( Data => $Data[6] );
        }

        my $ConfigChange = '';
        if ( $Data[7] ) {
            $ConfigChange = $YAMLObject->Load( Data => $Data[7] );
        }

        %Data = (
            ID             => $Data[0],
            Name           => $Data[1],
            Comment        => $Data[2],
            Description    => $Data[3] || '',
            StopAfterMatch => $Data[4] || 0,
            ValidID        => $Data[5],
            ConfigMatch    => $ConfigMatch,
            ConfigChange   => $ConfigChange,
# RotherOSS / ITSMConfigurationManagement
#             CreateTime     => $Data[8],
#             ChangeTime     => $Data[9],
#             CreateBy       => $Data[10],
#             ChangeBy       => $Data[11],
            ObjectType     => $Data[8],
            CreateTime     => $Data[9],
            ChangeTime     => $Data[10],
            CreateBy       => $Data[11],
            ChangeBy       => $Data[12],
# EO ITSMConfigurationManagement

        );
    }

    return if !$Data{ID};

    # get user object
    my $UserObject = $Kernel::OM->Get('Kernel::System::User');

    # convert UserIDs outside of fetchrowArray, otherwise UserLooukup will rise some warnings
    my $CreateUser = $UserObject->UserLookup( UserID => $Data{CreateBy} );
    my $ChangeUser = $UserObject->UserLookup( UserID => $Data{ChangeBy} );
    $Data{CreateBy} = $CreateUser;
    $Data{ChangeBy} = $ChangeUser;

    # set cache
    $CacheObject->Set(
        Type  => 'ACLEditor_ACL',
        Key   => $CacheKey,
        Value => \%Data,
        TTL   => $Self->{CacheTTL},
    );

    return \%Data;
}

=head2 ACLUpdate()

update ACL attributes

returns 1 if success or undef otherwise

    my $Success = $ACLObject->ACLUpdate(
        ID             => 123,                  # mandatory
        Name           => 'NameOfACL',          # mandatory
        Comment        => 'Comment',            # optional
        Description    => 'Description',        # optional
        StopAfterMatch => 1,                    # optional
        ValidID        => 'ValidID',            # mandatory
        ConfigMatch    => $ConfigMatchHashRef,  # optional
        ConfigChange   => $ConfigChangeHashRef, # optional
        UserID         => 123,                  # mandatory
    );

=cut

sub ACLUpdate {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Key (qw(ID Name ValidID UserID)) {
        if ( !$Param{$Key} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Key!"
            );
            return;
        }
    }

    # define Description field if not present
    $Param{Description} //= '';

    # set StopAfterMatch if undefined
    $Param{StopAfterMatch} //= 0;

    my $ConfigMatch  = '';
    my $ConfigChange = '';

    for my $Key (qw(ConfigMatch ConfigChange)) {

        if ( $Param{$Key} && !IsHashRefWithData( $Param{$Key} ) ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "$Key needs to be a valid hash with data!",
            );
            return;
        }
    }

    # get yaml object
    my $YAMLObject = $Kernel::OM->Get('Kernel::System::YAML');

    if ( $Param{ConfigMatch} && IsHashRefWithData( $Param{ConfigMatch} ) ) {
        $ConfigMatch = $YAMLObject->Dump( Data => $Param{ConfigMatch} );
    }

    if ( $Param{ConfigChange} && IsHashRefWithData( $Param{ConfigChange} ) ) {
        $ConfigChange = $YAMLObject->Dump( Data => $Param{ConfigChange} );
    }

    # get database object
    my $DBObject = $Kernel::OM->Get('Kernel::System::DB');

    # check if Name already exists
    return if !$DBObject->Prepare(
        SQL => "
            SELECT id FROM acl
            WHERE $Self->{Lower}(name) = $Self->{Lower}(?)
            AND id != ?",
        Bind  => [ \$Param{Name}, \$Param{ID} ],
        LIMIT => 1,
    );

    my $ACLExists;
    while ( my @Data = $DBObject->FetchrowArray() ) {
        $ACLExists = 1;
    }

    if ($ACLExists) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "An ACL with the name '$Param{Name}' already exists.",
        );
        return;
    }

    # check if need to update db
    return if !$DBObject->Prepare(
        SQL => '
            SELECT name, comments, description, stop_after_match, valid_id, config_match,
                config_change
            FROM acl
            WHERE id = ?',
        Bind  => [ \$Param{ID} ],
        Limit => 1,
    );

    my $CurrentName;
    my $CurrentComment;
    my $CurrentDescription;
    my $CurrentStopAfterMatch;
    my $CurrentValidID;
    my $CurrentConfigMatch;
    my $CurrentConfigChange;
    while ( my @Data = $DBObject->FetchrowArray() ) {
        $CurrentName           = $Data[0];
        $CurrentComment        = $Data[1];
        $CurrentDescription    = $Data[2] || '';
        $CurrentStopAfterMatch = $Data[3] || 0;
        $CurrentValidID        = $Data[4];
        $CurrentConfigMatch    = $Data[5];
        $CurrentConfigChange   = $Data[6];
    }

    if (
        $CurrentName
        && $CurrentName eq $Param{Name}
        && $CurrentComment eq $Param{Comment}
        && $CurrentDescription eq $Param{Description}
        && $CurrentStopAfterMatch eq $Param{StopAfterMatch}
        && $CurrentValidID eq $Param{ValidID}
        && $CurrentConfigMatch eq $ConfigMatch
        && $CurrentConfigChange eq $ConfigChange
        )
    {
        return 1;
    }

    # SQL
    return if !$DBObject->Do(
        SQL => '
            UPDATE acl
            SET name = ?, comments = ?, description = ?, stop_after_match = ?, valid_id = ?,
                config_match = ?, config_change = ?, change_time = current_timestamp,  change_by = ?
            WHERE id = ?',
        Bind => [
            \$Param{Name},    \$Param{Comment}, \$Param{Description}, \$Param{StopAfterMatch},
            \$Param{ValidID}, \$ConfigMatch,    \$ConfigChange,
            \$Param{UserID},  \$Param{ID},
        ],
    );

    # delete cache
    $Kernel::OM->Get('Kernel::System::Cache')->CleanUp(
        Type => 'ACLEditor_ACL',
    );

    return if !$DBObject->Do(
        SQL => '
            INSERT INTO acl_sync ( acl_id, sync_state, create_time, change_time )
            VALUES (?, ?, current_timestamp, current_timestamp)',
        Bind => [ \$Param{ID}, \'not_sync' ],
    );

    return 1;
}

=head2 ACLList()

get an ACL list

    my $List = $ACLObject->ACLList(
        ValidIDs        => ['1','2'],           # optional, to filter ACLs that match listed valid IDs
        UserID          => 1,
# RotherOSS / ITSMConfigurationManagement
        ObjectTypes     => ['Ticket']           # optional, currently Ticket or ConfigItem
# EO ITSMConfigurationManagement
    );

    Returns:

    $List = {
        1 => 'NameOfACL',
    }

=cut

sub ACLList {
    my ( $Self, %Param ) = @_;

    # check needed
    if ( !$Param{UserID} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "Need UserID!"
        );
        return;
    }

    my $ValidIDsStrg;
    if ( !IsArrayRefWithData( $Param{ValidIDs} ) ) {
        $ValidIDsStrg = 'ALL';
    }
    else {
        $ValidIDsStrg = join ',', @{ $Param{ValidIDs} };
    }
# RotherOSS / ITSMConfigurationManagement
    my $ObjectTypesStrg;
    if ( !IsArrayRefWithData( $Param{ObjectTypes} ) ) {
        $ObjectTypesStrg = 'ALL';
    }
    else {
        $ObjectTypesStrg = join ',', @{ $Param{ObjectTypes} };
    }
# EO ITSMConfigurationManagement

    # get cache object
    my $CacheObject = $Kernel::OM->Get('Kernel::System::Cache');

    # check cache
# RotherOSS / ITSMConfigurationManagement
#     my $CacheKey = 'ACLList::ValidIDs::' . $ValidIDsStrg;
    my $CacheKey = 'ACLList::ValidIDs::' . $ValidIDsStrg . '::ObjectTypes::' . $ObjectTypesStrg;
# EO ITSMConfigurationManagement
    my $Cache    = $CacheObject->Get(
        Type => 'ACLEditor_ACL',
        Key  => $CacheKey,
    );
    return $Cache if ref $Cache;

    # get database object
    my $DBObject = $Kernel::OM->Get('Kernel::System::DB');

    my $SQL = '
            SELECT id, name
            FROM acl ';

# RotherOSS / ITSMConfigurationManagement
    my $GlueStrg = 'WHERE';
# EO ITSMConfigurationManagement
    if ( $ValidIDsStrg ne 'ALL' ) {

        my $ValidIDsStrgDB = join ',', map { $DBObject->Quote( $_, 'Integer' ) }
            @{ $Param{ValidIDs} };

        $SQL .= "WHERE valid_id IN ($ValidIDsStrgDB)";
# RotherOSS / ITSMConfigurationManagement
        $GlueStrg = 'AND';
# EO ITSMConfigurationManagement
    }
# RotherOSS / ITSMConfigurationManagement

    if ( IsArrayRefWithData($Param{ObjectTypes}) ) {

        my $ObjectTypesStrgDB = join ',', map { "'" . $DBObject->Quote( $_ ) . "'" } $Param{ObjectTypes}->@*;

        $SQL .= "$GlueStrg object_type IN ($ObjectTypesStrgDB)";

    }

# EO ITSMConfigurationManagement

    return if !$DBObject->Prepare( SQL => $SQL );
    my %Data;
    while ( my @Row = $DBObject->FetchrowArray() ) {
        $Data{ $Row[0] } = $Row[1];
    }

    # set cache
    $CacheObject->Set(
        Type  => 'ACLEditor_ACL',
        Key   => $CacheKey,
        Value => \%Data,
        TTL   => $Self->{CacheTTL},
    );

    return \%Data;
}

=head2 ACLListGet()

get an ACL list with all ACL details

    my $List = $ACLObject->ACLListGet(
        UserID   => 1,
        ValidIDs => ['1','2'], # optional, to filter ACLs that match listed valid IDs
# RotherOSS / ITSMConfigurationManagement
        ObjectType      => ['Ticket']           # optional, currently Ticket or ConfigItem
# EO ITSMConfigurationManagement
    );

Returns:

    $List = [
        {
            ID            => 123,
            Name          => 'some name',
            Comment       => 'Comment',
            Description   => 'Description',
            ValidID       => 1,
            ConfigMatch   => $ConfigMatchHashRef,
            ConfigChange  => $ConfigChangeHashRef,
            CreateTime    => '2012-07-04 15:08:00',
            ChangeTime    => '2012-07-04 15:08:00',
# RotherOSS / ITSMConfigurationManagement
            ObjectTypes   => ['Ticket'],
# EO ITSMConfigurationManagement
        },
        {
            ID            => 123,
            Name          => 'some name',
            Comment       => 'Comment',
            Description   => 'Description',
            ValidID       => 1,
            ConfigMatch   => $ConfigMatchHashRef,
            ConfigChange  => $ConfigChangeHashRef,
            CreateTime    => '2012-07-04 15:08:00',
            ChangeTime    => '2012-07-04 15:08:00',
# RotherOSS / ITSMConfigurationManagement
            ObjectType    => 'ConfigItem',
# EO ITSMConfigurationManagement
        },
    ];

=cut

sub ACLListGet {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    if ( !$Param{UserID} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => 'Need UserID!',
        );
        return;
    }

    my $ValidIDsStrg;
    if ( !IsArrayRefWithData( $Param{ValidIDs} ) ) {
        $ValidIDsStrg = 'ALL';
    }
    else {
        $ValidIDsStrg = join ',', @{ $Param{ValidIDs} };
    }
# RotherOSS / ITSMConfigurationManagement
    my $ObjectTypesStrg;
    if ( !IsArrayRefWithData( $Param{ObjectTypes} ) ) {
        $ObjectTypesStrg = 'ALL';
    }
    else {
        $ObjectTypesStrg = join ',', @{ $Param{ObjectTypes} };
    }
# EO ITSMConfigurationManagement

    # get cache object
    my $CacheObject = $Kernel::OM->Get('Kernel::System::Cache');

    # check cache
# RotherOSS / ITSMConfigurationManagement
#     my $CacheKey = 'ACLListGet::ValidIDs::' . $ValidIDsStrg;
    my $CacheKey = 'ACLListGet::ValidIDs::' . $ValidIDsStrg . '::ObjectTypes::' . $ObjectTypesStrg;
# EO ITSMConfigurationManagement

    my $Cache    = $CacheObject->Get(
        Type => 'ACLEditor_ACL',
        Key  => $CacheKey,
    );
    return $Cache if $Cache;

    # get database object
    my $DBObject = $Kernel::OM->Get('Kernel::System::DB');

    my $SQL = '
            SELECT id
            FROM acl ';

# RotherOSS / ITSMConfigurationManagement
    my $GlueStrg = 'WHERE';
# EO ITSMConfigurationManagement
    if ( $ValidIDsStrg ne 'ALL' ) {

        my $ValidIDsStrgDB = join ',', map { $DBObject->Quote( $_, 'Integer' ) } @{ $Param{ValidIDs} };

        $SQL .= "WHERE valid_id IN ($ValidIDsStrgDB)";
# RotherOSS / ITSMConfigurationManagement
        $GlueStrg = 'AND';
# EO ITSMConfigurationManagement
    }
# RotherOSS / ITSMConfigurationManagement

    if ( IsArrayRefWithData($Param{ObjectTypes}) ) {

        my $ObjectTypesStrgDB = join ',', map { "'" . $DBObject->Quote( $_ ) . "'" } $Param{ObjectTypes}->@*;

        $SQL .= "$GlueStrg object_type IN ($ObjectTypesStrgDB)";

    }

# EO ITSMConfigurationManagement
    $SQL .= 'ORDER BY id';

    # SQL
    return if !$DBObject->Prepare(
        SQL => $SQL,
    );

    my @ACLIDs;
    while ( my @Row = $DBObject->FetchrowArray() ) {
        push @ACLIDs, $Row[0];
    }

    my @Data;
    for my $ItemID (@ACLIDs) {

        my $ACLData = $Self->ACLGet(
            ID     => $ItemID,
            UserID => 1,
        );
        push @Data, $ACLData;
    }

    # set cache
    $CacheObject->Set(
        Type  => 'ACLEditor_ACL',
        Key   => $CacheKey,
        Value => \@Data,
        TTL   => $Self->{CacheTTL},
    );

    return \@Data;
}

=head2 ACLsNeedSync()

Check if there are ACLs that are not yet deployed

    my $SyncCount = $ACLObject->ACLsNeedSync();

    Returns:

    $SyncCount = 0 || Number of ALCs that need to be synced

=cut

sub ACLsNeedSync {
    my ( $Self, %Param ) = @_;

    # get database object
    my $DBObject = $Kernel::OM->Get('Kernel::System::DB');

    my $SQL = '
        SELECT COUNT(*)
        FROM acl_sync';

    return if !$DBObject->Prepare( SQL => $SQL );

    my $NeedSync = 0;
    while ( my @Row = $DBObject->FetchrowArray() ) {
        $NeedSync = $Row[0];
    }

    return $NeedSync;
}

=head2 ACLsNeedSyncReset()

Reset synchronization information for ACLs.

=cut

sub ACLsNeedSyncReset {
    my ( $Self, %Param ) = @_;

    return if !$Kernel::OM->Get('Kernel::System::DB')->Do( SQL => 'DELETE FROM acl_sync' );

    return 1;
}

=head2 ACLDump()

gets a complete ACL information dump from the DB

    my $ACLDump = $ACLObject->ACLDump(
        ResultType  => 'FILE'                                      # default is 'FILE', only 'FILE' is supported
        Location    => '/opt/otobo/Kernel/Config/Files/ZZZACL.pm', # mandatory for ResultType = 'FILE'
        UserID      => 1,                                          # checked, but not really used
    );

Returns:

    $ACLDump = '/opt/otobo/Kernel/Config/Files/ZZZACL.pm';         # or undef if can't write the file

or in case of S3 support

    $ACLDump = 'Kernel/Config/Files/ZZZACL.pm';                    # or undef if can't write to S3

=cut

sub ACLDump {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    if ( !$Param{UserID} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => 'Need UserID!',
        );

        return;
    }

    # get defaults
    $Param{ResultType} //= 'FILE';

    if ( $Param{ResultType} eq 'FILE' ) {
        if ( !$Param{Location} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => 'Need Location for ResultType \'FILE\'!',
            );

        }
    }

# RotherOSS / ITSMConfigurationManagement
#     # get valid ACLs
#     my $ACLList = $Self->ACLListGet(
#         UserID   => 1,
#         ValidIDs => [1],
#     );
#
#     my %ACLDump;
#
#     ACL:
#     for my $ACLData ( @{$ACLList} ) {
#
#         next ACL if !IsHashRefWithData($ACLData);
#
#         my $Properties;
#         my $PropertiesDatabase;
#         if ( IsHashRefWithData( $ACLData->{ConfigMatch} ) ) {
#             $Properties         = $ACLData->{ConfigMatch}->{Properties};
#             $PropertiesDatabase = $ACLData->{ConfigMatch}->{PropertiesDatabase};
#         }
#
#         my $Possible;
#         my $PossibleAdd;
#         my $PossibleNot;
#         if ( IsHashRefWithData( $ACLData->{ConfigChange} ) ) {
#             $Possible    = $ACLData->{ConfigChange}->{Possible};
#             $PossibleAdd = $ACLData->{ConfigChange}->{PossibleAdd};
#             $PossibleNot = $ACLData->{ConfigChange}->{PossibleNot};
#         }
#
#         $ACLDump{ $ACLData->{Name} } = {
#             CreateTime => $ACLData->{CreateTime},
#             ChangeTime => $ACLData->{ChangeTime},
#             CreateBy   => $ACLData->{CreateBy},
#             ChangeBy   => $ACLData->{ChangeBy},
#             Comment    => $ACLData->{Comment},
#             Values     => {
#                 StopAfterMatch     => $ACLData->{StopAfterMatch} || 0,
#                 Properties         => $Properties                || {},
#                 PropertiesDatabase => $PropertiesDatabase        || {},
#                 Possible           => $Possible                  || {},
#                 PossibleAdd        => $PossibleAdd               || {},
#                 PossibleNot        => $PossibleNot               || {},
#             },
#         };
#     }
#
#     # delete cache
#     $Kernel::OM->Get('Kernel::System::Cache')->CleanUp(
#         Type => 'ACLEditor_ACL',
#     );
#
#     my $ACLItemsOutput = '';
#     for my $ACLName ( sort keys %ACLDump ) {
#
#         # create output
#         $ACLItemsOutput .= $Self->_ACLItemOutput(
#             Key        => $ACLName,
#             Value      => $ACLDump{$ACLName}{Values},
#             Comment    => $ACLDump{$ACLName}{Comment},
#             CreateTime => $ACLDump{$ACLName}{CreateTime},
#             ChangeTime => $ACLDump{$ACLName}{ChangeTime},
#             CreateBy   => $ACLDump{$ACLName}{CreateBy},
#             ChangeBy   => $ACLDump{$ACLName}{ChangeBy},
#         );
#     }
#
#     # build comment (therefore we need to trick out the filter)
#     my $PMFileOutput = sprintf <<'END_PM_FILE', $ACLItemsOutput;
# # OTOBO config file (automatically generated)
# # VERSION:1.1
# package Kernel::Config::Files::ZZZACL;
# use strict;
# use warnings;
# no warnings 'redefine'; ## no critic qw(TestingAndDebugging::ProhibitNoWarnings)
# use utf8;
# sub Load {
#     my ($File, $Self) = @_;
#
# %s
#
#     return;
# }
# 1;
# END_PM_FILE
    my $PMFileOutput = <<'END_PM_FILE';
# OTOBO config file (automatically generated)
# VERSION:1.1
package Kernel::Config::Files::ZZZACL;
use strict;
use warnings;
no warnings 'redefine'; ## no critic qw(TestingAndDebugging::ProhibitNoWarnings)
use utf8;
sub Load {
    my ($File, $Self) = @_;

END_PM_FILE
    for my $ObjectType ( qw(Ticket ConfigItem) ) {
        # get valid ACLs
        my $ACLList = $Self->ACLListGet(
            UserID      => 1,
            ValidIDs    => [1],
            ObjectTypes => [$ObjectType],
        );

        my %ACLDump;

        ACL:
        for my $ACLData ( @{$ACLList} ) {

            next ACL if !IsHashRefWithData($ACLData);

            my $Properties;
            my $PropertiesDatabase;
            if ( IsHashRefWithData( $ACLData->{ConfigMatch} ) ) {
                $Properties         = $ACLData->{ConfigMatch}->{Properties};
                $PropertiesDatabase = $ACLData->{ConfigMatch}->{PropertiesDatabase};
            }

            my $Possible;
            my $PossibleAdd;
            my $PossibleNot;
            if ( IsHashRefWithData( $ACLData->{ConfigChange} ) ) {
                $Possible    = $ACLData->{ConfigChange}->{Possible};
                $PossibleAdd = $ACLData->{ConfigChange}->{PossibleAdd};
                $PossibleNot = $ACLData->{ConfigChange}->{PossibleNot};
            }

            $ACLDump{ $ACLData->{Name} } = {
                CreateTime => $ACLData->{CreateTime},
                ChangeTime => $ACLData->{ChangeTime},
                CreateBy   => $ACLData->{CreateBy},
                ChangeBy   => $ACLData->{ChangeBy},
                Comment    => $ACLData->{Comment},
                Values     => {
                    StopAfterMatch     => $ACLData->{StopAfterMatch} || 0,
                    Properties         => $Properties                || {},
                    PropertiesDatabase => $PropertiesDatabase        || {},
                    Possible           => $Possible                  || {},
                    PossibleAdd        => $PossibleAdd               || {},
                    PossibleNot        => $PossibleNot               || {},
                },
            };
        }

        # delete cache
        $Kernel::OM->Get('Kernel::System::Cache')->CleanUp(
            Type => 'ACLEditor_ACL',
        );

        my $ACLItemsOutput = '';
        for my $ACLName ( sort keys %ACLDump ) {

            # create output
            $ACLItemsOutput .= $Self->_ACLItemOutput(
                Key        => $ACLName,
                Value      => $ACLDump{$ACLName}{Values},
                Comment    => $ACLDump{$ACLName}{Comment},
                CreateTime => $ACLDump{$ACLName}{CreateTime},
                ChangeTime => $ACLDump{$ACLName}{ChangeTime},
                CreateBy   => $ACLDump{$ACLName}{CreateBy},
                ChangeBy   => $ACLDump{$ACLName}{ChangeBy},
                ObjectType => $ObjectType,
            );
        }

        # build comment (therefore we need to trick out the filter)
        $PMFileOutput .= sprintf <<'END_PM_FILE', $ACLItemsOutput;
%s
END_PM_FILE
    }
    $PMFileOutput .= <<'END_PM_FILE';
    return;
}
1;
END_PM_FILE
# EO ITSMConfigurationManagement

    if ( $Self->{S3Active} ) {

        # remove the leading /opt/otobo as the home prefix is added automatically in the S3 storage object
        my $Home        = $Kernel::OM->Get('Kernel::Config')->Get('Home');
        my $ZZZFilePath = $Param{Location};
        $ZZZFilePath =~ s{^$Home/*}{};

        my $StorageS3Object = $Kernel::OM->Get('Kernel::System::Storage::S3');

        # only write to S3, no extra copy in the file system
        return $StorageS3Object->StoreObject(
            Key     => $ZZZFilePath,
            Content => $PMFileOutput,
        );
    }

    return $Kernel::OM->Get('Kernel::System::Main')->FileWrite(
        Location => $Param{Location},
        Content  => \$PMFileOutput,
        Mode     => 'utf8',
        Type     => 'Local',
    );

    # update preselection cache
    #my $FieldRestrictionsObject = $Kernel::OM->Get('Kernel::System::Ticket::FieldRestrictions');
    #$FieldRestrictionsObject->SetACLPreselectionCache();
}

=head2 ACLImport()

import an ACL YAML file/content

    my $ACLImport = $ACLObject->ACLImport(
        Content                   => $YAMLContent, # mandatory, YAML format
        OverwriteExistingEntities => 0,            # 0 || 1
        UserID                    => 1,            # mandatory
    );

Returns:

    $ACLImport = {
        Success      => 1,                         # 1 if success or undef if operation could not
                                                   #    be performed
        Message     => 'The Message to show.',     # error message
        AddedACLs   => 'ACL1, ACL2',               # list of ACLs correctly added
        UpdatedACLs => 'ACL3, ACL4',               # list of ACLs correctly updated
        ACLErrors   => 'ACL5',                     # list of ACLs that could not be added or updated
    };

=cut

sub ACLImport {
    my ( $Self, %Param ) = @_;

    for my $Needed (qw(Content UserID)) {

        # check needed stuff
        if ( !$Param{$Needed} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Needed!",
            );
            return {
                Success => 0,
                Message => "$Needed is missing can not continue.",
            };
        }
    }

    my $ACLData = $Kernel::OM->Get('Kernel::System::YAML')->Load( Data => $Param{Content} );

    if ( ref $ACLData ne 'ARRAY' ) {
        return {
            Success => 0,
            Message => Translatable("Couldn't read ACL configuration file. Please make sure the file is valid."),
        };
    }

    my @UpdatedACLs;
    my @AddedACLs;
    my @ACLErrors;

    ACL:
    for my $ACL ( @{$ACLData} ) {

        next ACL if !$ACL;
        next ACL if ref $ACL ne 'HASH';

        $ACL = $Self->_ACLMigrateFrom33(
            ACL    => $ACL,
            UserID => $Param{UserID},
        );

        my @ExistingACLs = @{ $Self->ACLListGet( UserID => $Param{UserID} ) || [] };
        @ExistingACLs = grep { $_->{Name} eq $ACL->{Name} } @ExistingACLs;

        if ( $Param{OverwriteExistingEntities} && $ExistingACLs[0] ) {
            my $Success = $Self->ACLUpdate(
                %{ $ExistingACLs[0] },
                Name           => $ACL->{Name},
                Comment        => $ACL->{Comment},
                Description    => $ACL->{Description}    || '',
                StopAfterMatch => $ACL->{StopAfterMatch} || 0,
                ConfigMatch    => $ACL->{ConfigMatch}    || undef,
                ConfigChange   => $ACL->{ConfigChange}   || undef,
                ValidID        => $ACL->{ValidID}        || 1,
                UserID         => $Param{UserID},
            );

            if ($Success) {
                push @UpdatedACLs, $ACL->{Name};
            }
            else {
                push @ACLErrors, $ACL->{Name};
            }

        }
        else {

            # now add the ACL
            my $Success = $Self->ACLAdd(
                Name           => $ACL->{Name},
                Comment        => $ACL->{Comment},
                Description    => $ACL->{Description}  || '',
                ConfigMatch    => $ACL->{ConfigMatch}  || undef,
                ConfigChange   => $ACL->{ConfigChange} || undef,
                StopAfterMatch => $ACL->{StopAfterMatch},
                ValidID        => $ACL->{ValidID} || 1,
                UserID         => $Param{UserID},
# RotherOSS / ITSMConfigurationManagement
                ObjectType     => $ACL->{ObjectType} || 'Ticket',
# EO ITSMConfigurationManagement
            );

            if ($Success) {
                push @AddedACLs, $ACL->{Name};
            }
            else {
                push @ACLErrors, $ACL->{Name};
            }
        }
    }

    # update preselection cache
# Rother OSS / ITSMConfigurationManagement
#     my $FieldRestrictionsObject = $Kernel::OM->Get('Kernel::System::Ticket::FieldRestrictions');
#     $FieldRestrictionsObject->SetACLPreselectionCache();
    for my $ACLType ( qw(Ticket ITSMConfigItem) ) {
        $Kernel::OM->Get('Kernel::System::' . $ACLType . '::FieldRestrictions')->SetACLPreselectionCache();
    }
# EO ITSMConfigurationManagement


    return {
        Success     => 1,
        AddedACLs   => join( ', ', @AddedACLs )   || '',
        UpdatedACLs => join( ', ', @UpdatedACLs ) || '',
        ACLErrors   => join( ', ', @ACLErrors )   || '',
    };
}

=begin Internal:

=cut

=head2 _ACLItemOutput()

converts an ACL structure to perl code suitable to be saved on a perl file.

    my $Output = $ACLObject->_ACLItemOutput (
        Key => 'some ACL name',
        Value => {
            Properties => {
                Ticket => {
                    Priority => [ 'some priority' ],
                    Queue    => [ 'some queue' ],
                },
            },
            PropertiesDatabase => { },                      # similar to Properties or empty hash ref
            Possible => {
                Ticket => {
                Queue => [ 'some other queue' ],
            },
            PossibleNot => { },                             # similar to Possible or empty hash ref
            PossibleAdd => { },                             # similar to Possible or empty hash ref
            StopAfterMatch => 0,                            # 0 or 1
        },
        Comment    => 'some comment',
# RotherOSS / ITSMConfigurationManagement
        ObjectType => 'Ticket',
# EO ITSMConfigurationManagement
        CreateTime => '2014-06-03 19:03:57',
        ChangeTime => '2014-06-03 19:51:17',
        CreateBy   => 'some user login',
        ChangeBy   => 'some user login',
    );

returns:

    $Output = '
        # Created: 2014-06-03 19:03:57 (some user login)
        # Changed: 2014-06-03 19:51:17 (some user login)
        # Comment: some comment
# RotherOSS / ITSMConfigurationManagement
#         $Self->{TicketAcl}->{"100-Example-ACL"} = {
        $Self->{$Param{ObjectType} . 'Acl'}->{"100-Example-ACL"} = {
# EO ITSMConfigurationManagement
          \\'Possible\\' => {
            \\'Ticket\\' => {
              \\'Queue\\' => [
                \\'some other queue\\'
              ]
            }
          },
          \\'PossibleAdd\\' => {},
          \\'PossibleNot\\' => {},
          \\'Properties\\' => {
            \\'Ticket\\' => {
              \\'Priority\\' => [
                \\'some priority\\'
              ],
              \\'Queue\\' => [
                \\'some queue\\'
              ]
            }
          },
          \\'PropertiesDatabase\\' => {},
          \\'StopAfterMatch\\' => 0
        };
        ';

=cut

sub _ACLItemOutput {
    my ( $Self, %Param ) = @_;
# Rother OSS / ITSMConfigurationManagement

    # set default for object type
    $Param{ObjectType} //= 'Ticket';
# EO ITSMConfigurationManagement

    # those params are expected to only contain one line
    for my $Key (qw( CreateBy ChangeBy Comment )) {
        ( $Param{$Key} ) = $Param{$Key} =~ /(.+?)$/m;
    }

    my $Output = "# Created: $Param{CreateTime} ($Param{CreateBy})\n";
    $Output .= "# Changed: $Param{ChangeTime} ($Param{ChangeBy})\n";

    if ( $Param{Comment} ) {
        $Output .= "# Comment: $Param{Comment}\n";
    }

    $Output .= $Kernel::OM->Get('Kernel::System::Main')->Dump(
        $Param{Value},
    );

    # replace "[empty]" by ''
    $Output =~ s{\[empty\]}{}xmsg;

    my $Name = $Param{Key};
    $Name =~ s{\\}{\\\\}xmsg;
    $Name =~ s{\'}{\\'}xmsg;
# Rother OSS / ITSMConfigurationManagement
#     my $Key = '$Self->{TicketAcl}->{\'' . $Name . '\'}';
    my $Key = '$Self->{' . $Param{ObjectType} . 'Acl}->{\'' . $Name . '\'}';
# EO ITSMConfigurationManagement

    $Output =~ s{\$VAR1}{$Key}mxs;

    return $Output . "\n";
}

=head2 _ACLMigrateFrom33()

Updates ACLs structure my changing the Possible->Action hash ref to a PossibleNot->Action array ref
with just the elements that where set to 0 in the original ACL:

    my $ACL = $ACLObject->_ACLMigrateFrom33 (
        $ACL => {
            ID          => 123,
            Name        => 'some name',
            Description => '',
            Comment     => 'Comment',
            ConfigMatch => {
                Properties' => {},
            },
            ConfigChange => {
                Possible => {}
                    Action => {
                        AgentTicketPhone   => 1,
                        AgentTicketPrint   => 0,
                        AgentTicketZoom    => 1,
                        AgentTicketCLose   => 0,
                        AgentTicketCompose => 0,
                    },
                },
                PossibleNot => {},
            },
            StopAfterMatch => 1,
            ValidID        => 1,
            CreateTime     => '2013-09-20 11:56:05',
            CreateBy       => 'root@localhost',
            ChangeTime     => '2014-06-16 11:31:55',
            ChangeBy       => 'root@localhost',
        };
        UserID => 123,
    )

Returns:

        $ACL = {
            ID          => 123,
            Name        => 'some name',
            Description => '',
            Comment     => 'Comment',
            ConfigMatch => {
                Properties' => {},
            },
            ConfigChange => {
                Possible => {},
                PossibleNot => {
                    Action => [
                        'AgentTicketCLose',
                        'AgentTicketCompose',
                        'AgentTicketPrint'
                    ],
                },
            }
            StopAfterMatch => 1,
            ValidID        => 1,
            CreateBy       => 'root@localhost',
            CreateTime     => '2013-09-20 11:56:05',
            ChangeTime     => '2014-06-16 11:31:55',
            ChangeBy       => 'root@localhost',
        };

=cut

sub _ACLMigrateFrom33 {
    my ( $Self, %Param ) = @_;

    my $ACL = $Param{ACL};

    return $ACL if !ref $ACL->{ConfigChange};
    return $ACL if !$ACL->{ConfigChange}->{Possible}->{Action};
    return $ACL if ref $ACL->{ConfigChange}->{Possible}->{Action} ne 'HASH';

    # convert old hash into an array using only the keys set to 0, and skip those that are set
    # to 1, set them as PossibleNot and delete the Possible->Action section from the ACL.
    my @NewAction = grep { $ACL->{ConfigChange}->{Possible}->{Action}->{$_} == 0 }
        sort keys %{ $ACL->{ConfigChange}->{Possible}->{Action} };

    delete $ACL->{ConfigChange}->{Possible}->{Action};
    $ACL->{ConfigChange}->{PossibleNot}->{Action} = \@NewAction;

    return $ACL;
}

=end Internal:

=cut

1;

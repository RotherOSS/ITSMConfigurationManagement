# --
# OTOBO is a web-based ticketing system for service organisations.
# --
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

package Kernel::System::ITSMConfigItem::Link;

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

Kernel::System::ITSMConfigItem::Link - sub module of Kernel::System::ITSMConfigItem

=head1 DESCRIPTION

This module supports the maintenance of the content of the table B<configitem_link>. This table
is a shadow of the information that is contained in Reference dynamic fields that connect objects
of type C<ITSMConfigItem> and C<ITSMConfigItemVersion>.

The information from the LinkObject feature is also represented in B<configitem_link>. These
case is marked by B<configitem_link.dynamic_field_id> having the value B<NULL>.

There is support for immediate update of the table and for a complete rebuild of the table.

Planned is also support for dumping the complete graph so that it can be used for presentation.

=head1 PUBLIC INTERFACE

=head2 AddConfigItemLink()

This method is specifically for adding a link between two config items. It is needed
for supporting the LinkObject functionality.

The linking of specific versions is not supported.

    my $Success = $ConfigItemObject->AddConfigItemLink(
        Type           => 'DependsOn',
        SourceConfigID => 127,
        TargetConfigID => 128,
    );

=cut

sub AddConfigItemLink {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Argument (qw(Type SourceConfigItemID TargetConfigItemID)) {
        if ( !$Param{$Argument} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Argument!",
            );

            return;
        }
    }

    # lookup type id
    my $TypeID = $Kernel::OM->Get('Kernel::System::LinkObject')->TypeLookup(
        Name   => $Param{Type},
        UserID => 1,
    );
    my $DBObject = $Kernel::OM->Get('Kernel::System::DB');
    $DBObject->Do(
        SQL => <<'END_SQL',
INSERT INTO configitem_link (
    link_type_id, source_configitem_id, target_configitem_id, dynamic_field_id, create_time, create_by
  )
  VALUES (?, ?, ?, NULL, current_timestamp, 1 )
END_SQL
        Bind => [ \( $TypeID, $Param{SourceConfigItemID}, $Param{TargetConfigItemID} ) ],
    );

    return 1;
}

=head2 DeleteConfigItemLink()

This method is specifically for deleting a link between two config items. It is needed
for supporting the LinkObject functionality.

The unlinking of specific versions is not supported.

    my $Success = $ConfigItemObject->DeleteConfigItemLink(
        Type           => 'DependsOn',
        SourceConfigID => 127,
        TargetConfigID => 128,
    );

=cut

sub DeleteConfigItemLink {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Argument (qw(Type SourceConfigItemID TargetConfigItemID)) {
        if ( !$Param{$Argument} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Argument!",
            );

            return;
        }
    }

    # lookup type id
    my $LinkTypeID = $Kernel::OM->Get('Kernel::System::LinkObject')->TypeLookup(
        Name   => $Param{Type},
        UserID => 1,
    );
    my $DBObject = $Kernel::OM->Get('Kernel::System::DB');
    $DBObject->Do(
        SQL => <<'END_SQL',
DELETE FROM configitem_link
  WHERE link_type_id = ?
    AND source_configitem_id = ?
    AND target_configitem_id = ?
    AND dynamic_field_id IS NULL
END_SQL
        Bind => [ \( $LinkTypeID, $Param{SourceConfigItemID}, $Param{TargetConfigItemID} ) ],
    );

    return 1;
}

=head2 LinkedConfigItems()

get the config items that are directly linked to a specific config item. No details
of the linked config items are returned.

    # only linked from a config item
    my $LinkedConfigItems = $ConfigItemObject->LinkedConfigItems(
        ConfigItemID => 321,
        Types        => [ 'ParentChild', 'IsInspiredBy' ], # optional
        Direction    => 'Source', # one of Source, Target, Both
        UserID       => 1,
    );

or

    # only linked from a config item version
    my $LinkedConfigItems = $ConfigItemObject->LinkedConfigItems(
        VersionID  => 489,
        Types      => [ 'ParentChild', 'IsInspiredBy' ], # optional
        Direction  => 'Source', # one of Source, Target, Both
        UserID     => 1,
    );

Passing both config item ID and config item version ID is fine too.

    # link via item of version
    my $LinkedConfigItems = $ConfigItemObject->LinkedConfigItems(
        ConfigItemID => 321,
        VersionID    => 489,
        Types        => [ 'ParentChild', 'IsInspiredBy' ], # optional
        Direction    => 'Both # one of Source, Target, Both
        UserID       => 1,
    );

The semantics of the parameter C<Direction> can be confusing. The above call can be verbalized as:
"Give me all config items that are marked as 'Source' that have a 'ParentChild' relationship
with the the config item 321.

Returns an empty array ref when no relationships were found:

    $LinkedConfigItems = [];

Returns a list when relationships have been found. Either C<ConfigItemID> or C<VersionID> is set.
C<DynamicFieldID> is not defined when LinkObject is used.

    $LinkedConfigItems = [
        {
            ConfigItemID   => 17,
            VersionID      => undef,
            Direction      => 'Source',
            LinkTypeID     => 2,
            LinkType       => 'ParentChild',
            DynamicFieldID => 127,
        },
        {
            ConfigItemID   => undef,
            VersionID      => 22,
            Direction      => 'Source',
            LinkTypeID     => 2,
            LinkType       => 'IsInspiredBy',
            DynamicFieldID => undef,
        },
        ...
    ];

=cut

sub LinkedConfigItems {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Argument (qw(Direction UserID)) {
        if ( !$Param{$Argument} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Argument!",
            );

            return;
        }
    }
    if ( !( $Param{ConfigItemID} || $Param{VersionID} ) ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "Need either ConfigItemID or VersionID !",
        );

        return;
    }

    # Passing both ConfigItemID and VersionID is fine

    my $LinkObject = $Kernel::OM->Get('Kernel::System::LinkObject');

    # get complete list for both directions (or only one if restricted)
    my ( $SQL, @Binds );
    {
        # the link type is optional
        my @TypeConditions;    # 0 or 1 conditions
        my @TypeBinds;         # 0, 1, or many binds
        if ( $Param{Types} && ref $Param{Types} eq 'ARRAY' ) {

            # empty list of types gives no result
            return [] unless $Param{Types}->@*;

            my $Placeholders = join ', ', map {'?'} $Param{Types}->@*;
            push @TypeConditions, "link_type_id IN ($Placeholders)";

            push @TypeBinds, map
                {
                    $LinkObject->TypeLookup(
                        Name   => $_,
                        UserID => $Param{UserID}
                    )
                }
                $Param{Types}->@*;
        }

        # these  arrays have either 1 or 2 elements
        my ( @SourceConditions, @TargetConditions, @IDBinds );
        if ( $Param{ConfigItemID} ) {
            push @SourceConditions, 'target_configitem_id = ?';
            push @TargetConditions, 'source_configitem_id = ?';
            push @IDBinds,          $Param{ConfigItemID};
        }
        if ( $Param{VersionID} ) {
            push @SourceConditions, 'target_configitem_version_id = ?';
            push @TargetConditions, 'source_configitem_version_id = ?';
            push @IDBinds,          $Param{VersionID};
        }

        if ( $Param{Direction} eq 'Source' ) {
            $SQL = <<"END_SQL";
SELECT DISTINCT source_configitem_id, source_configitem_version_id, link_type_id, 'Source', dynamic_field_id
  FROM configitem_link
  WHERE @{[ join ' AND ', ( map { "($_)" } join ' OR ', @SourceConditions ), @TypeConditions ]}
END_SQL
            @Binds = ( @IDBinds, @TypeBinds );
        }
        elsif ( $Param{Direction} eq 'Target' ) {
            $SQL = <<"END_SQL";
SELECT DISTINCT target_configitem_id, target_configitem_version_id, link_type_id, 'Target', dynamic_field_id
  FROM configitem_link
  WHERE @{[ join ' AND ', ( map { "($_)" } join ' OR ', @TargetConditions ), @TypeConditions ]}
END_SQL
            @Binds = ( @IDBinds, @TypeBinds );
        }
        else {
            # Both directions
            # TODO: test with PostgreSQL and Oracle
            $SQL = <<"END_SQL";
(
  SELECT DISTINCT source_configitem_id, source_configitem_version_id, link_type_id, 'Source', dynamic_field_id
    FROM configitem_link
    WHERE @{[ join ' AND ', ( map { "($_)" } join ' OR ', @SourceConditions), @TypeConditions ]}
)
UNION
(
  SELECT DISTINCT target_configitem_id, target_configitem_version_id, link_type_id, 'Target', dynamic_field_id
    FROM configitem_link
    WHERE @{[ join ' AND ', ( map { "($_)" } join ' OR ', @TargetConditions), @TypeConditions ]}
)
END_SQL
            @Binds = ( @IDBinds, @TypeBinds, @IDBinds, @TypeBinds );
        }
    }

    my $Rows = $Kernel::OM->Get('Kernel::System::DB')->SelectAll(
        SQL  => $SQL,
        Bind => [ \(@Binds) ],
    );

    my @Result = map
        {
            {
                ConfigItemID => $_->[0],
                VersionID    => $_->[1],
                LinkTypeID   => $_->[2],
                LinkType     => $LinkObject->TypeLookup(
                    TypeID => $_->[2],
                    UserID => $Param{UserID},
                ),
                Direction      => $_->[3],
                DynamicFieldID => $_->[4],
            }
        }
        $Rows->@*;

    return \@Result;
}

=head2 SyncLinkTable()

This method entails the logic for keeping the table B<configitem_link> in sync
with dynamic field updates.

=cut

sub SyncLinkTable {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Missing ( grep { !$Param{$_} } qw(DynamicFieldConfig ConfigItemID ConfigItemLastVersionID ConfigItemVersionID Value) ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "Need $Missing!",
        );

        return;
    }

    my $DynamicFieldConfig   = $Param{DynamicFieldConfig};
    my $DynamicFieldID       = $DynamicFieldConfig->{ID};
    my $DFDetails            = $DynamicFieldConfig->{Config};
    my $ReferencedObjectType = $DFDetails->{ReferencedObjectType};

    if ( $ReferencedObjectType ne 'ITSMConfigItem' && $ReferencedObjectType ne 'ITSMConfigItemVersion' ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "The parameter ReferencedObjectType must be either ITSMConfigItem or ITSMConfigItemVersion!",
        );

        return;
    }

    # Linking is not necessarily set up. That is fine.
    return 1 unless $DFDetails->{LinkType};

    # When linking is set up we need the complete information for how
    # the linking should be done.
    NEEDED:
    for my $Needed (qw(LinkDirection LinkReferencingType)) {
        next NEEDED if $DFDetails->{$Needed};

        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => qq{Invalid dynamic field configuration. The setting $Needed is missing,},
        );

        return;
    }

    my $LinkObject = $Kernel::OM->Get('Kernel::System::LinkObject');

    my $LinkTypeName = $DFDetails->{LinkType};
    my $LinkTypeID   = $LinkObject->TypeLookup(
        Name   => $LinkTypeName,
        UserID => 1,
    );

    if ( !$LinkTypeID ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "The link type '$LinkTypeName' is not valid'.",
        );

        return;
    }

    # sometimes only the setting of the most recent version is relevant
    # The default is Dynamic.
    my $LinkIsDynamic = 0;
    if ( $DFDetails->{LinkReferencingType} eq 'Dynamic' ) {
        return 1 unless $Param{ConfigItemVersionID} == $Param{ConfigItemLastVersionID};

        $LinkIsDynamic = 1;
    }

    # DoArray() is used below. The bind variables for DoArray() can be simple scalars or array references.
    # A simple scalar is used for all inserted rows.
    #
    # Note that semantics of the bind variables differ between Do() and DoArray().
    #
    # Note that $Param{Value} is per design an array reference,
    # even when there is only a single referenced config item.
    my $DBObject = $Kernel::OM->Get('Kernel::System::DB');

    # The meaning if direction is still a bit confusing. But it was
    # worse in the past.
    #
    # $LinkDirection eq 'ReferencingIsSource':
    #   The config item with the dynamic field is the source,
    #   and the referenced config item is the target.
    #
    # $LinkDirection eq 'ReferencingIsTarget':
    #   The referenced config item is the source,
    #   and the config item that has the dynamic field is the target.
    my $LinkDirection = $DFDetails->{LinkDirection};

    # The attribute of the table configitem_link that holds the IDs of the linked items
    # depends on the type of the dynamic field and on the direction.
    # Possible columns are:
    #   target_configitem_id
    #   target_configitem_version_id,
    #   source_configitem_id,
    #   source_configitem_version_id
    my $FieldType = $DynamicFieldConfig->{FieldType};    # either ConfigItem or ConfigItemVersion
    my $ValueCol  = join '_',
        ( $LinkDirection eq 'ReferencingIsSource' ? 'target'     : 'source' ),
        ( $FieldType eq 'ConfigItem'              ? 'configitem' : 'configitem_version' ),
        'id';

    # The parameter which is used to identify the config item, or config item version,
    # which holds the dynamic field depends on wheter the link should be the same
    # for all versions of the config item.
    my $ItemOrVersion = $LinkIsDynamic ? $Param{ConfigItemID} : $Param{ConfigItemVersionID};

    # The columm for $ItemOrVersion depends on the direction and
    # on wheter the link should be the same for all versions of the config item.
    # The possible values are the same as for $ValueCol.
    my $ItemOrVersionCol = join '_',
        ( $LinkDirection eq 'ReferencingIsSource' ? 'source'     : 'target' ),
        ( $LinkIsDynamic                          ? 'configitem' : 'configitem_version' ),
        'id';

    # Clear out the old value array.
    $DBObject->Do(
        SQL => <<"END_SQL",
DELETE FROM configitem_link
  WHERE dynamic_field_id     = ?
    AND $ItemOrVersionCol = ?
END_SQL
        Bind => [ \( $DynamicFieldID, $ItemOrVersion ) ],
    );

    # INSERT the new value array.
    $DBObject->DoArray(
        SQL => <<"END_SQL",
INSERT INTO configitem_link (
    dynamic_field_id, link_type_id, $ItemOrVersionCol, $ValueCol,
    create_time, create_by
  )
  VALUES (
    ?, ?, ?, ?,
    current_timestamp, 1
  )
END_SQL
        Bind => [ $DynamicFieldID, $LinkTypeID, $ItemOrVersion, $Param{Value} ],
    );

    # assume success
    return 1;
}

=head2 RebuildLinkTable()

purge and repopulate the table B<configitem_link> based on the Reference dynamic fields
and on the LinkObject data.

    my $Result = $ConfigItemObject->RebuildLinkTable;

The result is a hashref like:

    my $Result = {
        Success  => 1, # or 0 in case of failure
        Message  => 'some message',
        Color    => 'green',    # or red, or yellow
    };

=cut

sub RebuildLinkTable {
    my ($Self) = @_;

    # no parameters are supported

    my $DBObject = $Kernel::OM->Get('Kernel::System::DB');

    # purge the table, give up in case of error
    my $SuccessPurge = $DBObject->Do(
        SQL => 'DELETE FROM configitem_link'
    );

    return {
        Success => 0,
        Message => Translatable('Could not purge the table configitem_link.'),
        Color   => 'red',
    } unless $SuccessPurge;

    # Get the relevant dynamic fields. Relevant are only
    # Reference dynamic fields that connect an ITSMConfigItem
    # to another ITSMConfigItem or an ITSMConfigItemVersion.
    # Another condition is that the attribute 'LinkType' is configured for that
    # dynamic field.
    my @DynamicFields;
    {
        my $DynamicFieldObject       = $Kernel::OM->Get('Kernel::System::DynamicField');
        my $CompleteDynamicFieldList = $DynamicFieldObject->DynamicFieldListGet(
            ObjectType => 'ITSMConfigItem'
        );
        @DynamicFields =
            grep { $_->{Config}->{LinkType} }
            grep { ref $_->{Config} eq 'HASH' }
            grep { $_->{FieldType} =~ m/^ConfigItem/ }
            $CompleteDynamicFieldList->@*;
    }

    # nothing to do when there are no dynamic fields
    # TODO: cover the case where only LinkObject is used
    return {
        Success => 1,
        Message => Translatable('No relevant dynamic fields were found'),
        Color   => 'yellow',
    } unless @DynamicFields;

    # Needed for deciding which attribute of configitem_link is used.
    my %LinksToCI =
        map  { $_->{ID} => 1 }
        grep { $_->{FieldType} eq 'ConfigItem' }
        @DynamicFields;
    my %LinksToCIVersion =
        map  { $_->{ID} => 1 }
        grep { $_->{FieldType} eq 'ConfigItemVersion' }
        @DynamicFields;

    # Easy acceed to the dynamic field config.
    my %DFLookupByID =
        map { $_->{ID} => $_ }
        @DynamicFields;

    # Get the relevant dynamic field values.
    # The methods in Kernel::System::DynamicFieldValue are specific to specific fields,
    # so use dedicated SQL here.
    my $Rows;
    {
        my %QueryCondition = $DBObject->QueryInCondition(
            Key      => 'dfv.field_id',
            Values   => [ sort { $a <=> $b } keys %DFLookupByID ],
            BindMode => 1,
        );
        $Rows = $DBObject->SelectAll(
            SQL => << "END_SQL",
SELECT dfv.field_id, v.configitem_id, v.id, dfv.value_int, v_max.max_version_id
  FROM dynamic_field_value dfv
  INNER JOIN configitem_version v
    ON dfv.object_id = v.id
  INNER JOIN (
    SELECT configitem_id, MAX(id) AS max_version_id
      FROM configitem_version
      GROUP BY configitem_id
  ) AS v_max
    ON v_max.configitem_id = v.configitem_id
  WHERE $QueryCondition{SQL}
  ORDER by dfv.id
END_SQL
            Bind => $QueryCondition{Values},
        );
    }

    # prepare the dynamic field values so that it can be used in a batch insert

    # for the link types we neet to do some work
    my $LinkObject = $Kernel::OM->Get('Kernel::System::LinkObject');
    my (
        @LinkTypeIDs,
        @SourceConfigItemIDs,
        @SourceConfigItemVersionIDs,
        @TargetConfigItemIDs,
        @TargetConfigItemVersionIDs,
        @FieldIDs,
    );
    ROW:
    for my $Row ( $Rows->@* ) {
        my ( $FieldID, $ConfigItemID, $VersionID, $Value, $MaxVersionID ) = $Row->@*;

        next ROW unless $DFLookupByID{$FieldID};

        my $DFDetails = $DFLookupByID{$FieldID}->{Config};

        next ROW unless $DFDetails;

        NEEDED:
        for my $Needed (qw(LinkType LinkDirection)) {
            next NEEDED if $DFDetails->{$Needed};

            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => qq{Invalid dynamic field configuration. The setting $Needed is missing for field $DFLookupByID{$FieldID}->{Name},},
            );

            next ROW;
        }

        my $LinkTypeName = $DFDetails->{LinkType};
        my $LinkTypeID   = $LinkObject->TypeLookup(
            Name   => $LinkTypeName,
            UserID => 1,
        );

        if ( !$LinkTypeID ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "The link type '$LinkTypeName' is not valid'.",
            );

            next ROW;
        }

        # sometimes only the setting of the most recent version is relevant
        # The default is Dynamic.
        my $LinkIsDynamic = 0;
        $DFDetails->{LinkReferencingType} //= 'Dynamic';
        if ( $DFDetails->{LinkReferencingType} eq '' || $DFDetails->{LinkReferencingType} eq 'Dynamic' ) {
            next ROW unless $VersionID == $MaxVersionID;

            $LinkIsDynamic = 1;
        }

        # some values are independent of the direction
        push @LinkTypeIDs, $LinkTypeID;
        push @FieldIDs,    $FieldID;

        my $LinkDirection = $DFDetails->{LinkDirection};
        if ( $LinkDirection eq 'ReferencingIsSource' ) {
            push @SourceConfigItemIDs,        $LinkIsDynamic              ? $ConfigItemID : undef;
            push @SourceConfigItemVersionIDs, $LinkIsDynamic              ? undef         : $VersionID;
            push @TargetConfigItemIDs,        $LinksToCI{$FieldID}        ? $Value        : undef;
            push @TargetConfigItemVersionIDs, $LinksToCIVersion{$FieldID} ? $Value        : undef;
        }
        else {

            # as above, but backwards
            push @TargetConfigItemIDs,        $LinkIsDynamic              ? $ConfigItemID : undef;
            push @TargetConfigItemVersionIDs, $LinkIsDynamic              ? undef         : $VersionID;
            push @SourceConfigItemIDs,        $LinksToCI{$FieldID}        ? $Value        : undef;
            push @SourceConfigItemVersionIDs, $LinksToCIVersion{$FieldID} ? $Value        : undef;
        }
    }

    # Multivalue INSERT
    my $NumReferenceRows = $DBObject->DoArray(
        SQL => <<'END_SQL',
INSERT INTO configitem_link (
    link_type_id,
    source_configitem_id,
    source_configitem_version_id,
    target_configitem_id,
    target_configitem_version_id,
    dynamic_field_id,
    create_time,
    create_by
  )
  VALUES (?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP(), 1)
END_SQL
        Bind => [
            \@LinkTypeIDs,
            \@SourceConfigItemIDs,
            \@SourceConfigItemVersionIDs,
            \@TargetConfigItemIDs,
            \@TargetConfigItemVersionIDs,
            \@FieldIDs,
        ],
    );

    return {
        Success => 0,
        Message => Translatable('Could not insert into the table configitem_link'),
        Color   => 'red',
    } unless defined $NumReferenceRows;

    # add rows from LinkObject, that is from the link_relation table
    my $NumLinkObjectRows = 0;
    {
        my $LinkObject = $Kernel::OM->Get('Kernel::System::LinkObject');

        # get a list of possible link types between config items from the SysConfig
        my %PossibleTypesList = $LinkObject->PossibleTypesList(
            Object1 => 'ITSMConfigItem',
            Object2 => 'ITSMConfigItem',
        );

        # for the database SELECT we need the numeric IDs
        my @PossibleLinkTypeIDs =
            map { $LinkObject->TypeLookup( Name => $_, UserID => 1 ) }
            keys %PossibleTypesList;

        my %TypeQueryCondition = $DBObject->QueryInCondition(
            Key      => 'type_id',
            Values   => \@PossibleLinkTypeIDs,
            BindMode => 1,
        );

        # limit to links between config items
        # An ID is created when ObjectLookup() is called the for first time with that name
        my $CIObjectID = $LinkObject->ObjectLookup(
            Name => 'ITSMConfigItem',
        );

        # temporary links are not considered
        my $TemporaryStateID = $LinkObject->StateLookup(
            Name => 'Temporary',
        );

        my $SQL = <<"END_SQL";
SELECT type_id, source_key, target_key
  FROM link_relation
  WHERE state_id <> ?
    AND source_object_id = ?
    AND target_object_id = ?
    AND $TypeQueryCondition{SQL}
END_SQL
        my @Binds = (
            \$TemporaryStateID,
            \$CIObjectID,
            \$CIObjectID,
            $TypeQueryCondition{Values}->@*
        );

        return unless $DBObject->Prepare(
            SQL  => $SQL,
            Bind => \@Binds,
        );

        my ( @LinkTypeIDs, @SourceConfigItemIDs, @TargetConfigItemIDs );
        while ( my ( $LinkTypeID, $SourceConfigItemID, $TargetConfigItemID ) = $DBObject->FetchrowArray ) {
            push @LinkTypeIDs,         $LinkTypeID;
            push @SourceConfigItemIDs, $SourceConfigItemID;
            push @TargetConfigItemIDs, $TargetConfigItemID;
        }

        # Multivalue INSERT
        $NumLinkObjectRows = $DBObject->DoArray(
            SQL => <<'END_SQL',
INSERT INTO configitem_link (
    link_type_id, source_configitem_id, target_configitem_id,
    create_time, create_by
  )
  VALUES (
    ?, ?, ?,
    CURRENT_TIMESTAMP(), 1
  )
END_SQL
            Bind => [
                \@LinkTypeIDs,
                \@SourceConfigItemIDs,
                \@TargetConfigItemIDs,
            ],
        );
    }

    my $NumRows = $NumReferenceRows + $NumLinkObjectRows;

    # warn when there are no links
    return {
        Success => 1,
        Message => Translatable('Inserted 0 rows into the table configitem_link'),
        Color   => 'yellow',
    } if $NumRows == 0;

    # there is at least one link, looks good
    return {
        Success => 1,
        Message => Translatable('Done'),
        Color   => 'green',
    };
}

1;

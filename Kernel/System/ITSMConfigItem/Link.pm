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

get the config items that are directly linked to a specific config item.

    my $LinkedConfigItems = $ConfigItemObject->LinkedConfigItems(
        ConfigItemID => 321,
        Types        => [ 'ParentChild', 'IsInspiredBy' ], # optional
        Direction    => 'Source', # one of Source, Target, Both
        UserID       => 1,
    );

The semantics of the parameter C<Direction> can be confusing. The above call can be verbalized as:
"Give me all config items that are marked as 'Source' that have a 'ParentChild' relationship
with the the config item 321.

Returns an empty array ref when no relationships were found:

    $LinkedConfigItems = [];

Returs a list when relationships have been found.

    $LinkedConfigItems = [
        {
            ConfigItemID => 1,
            Direction    => 'Source',
            LinkTypeID   => 2,
            LinkType     => 'ParentChild',
        },
        {
            ConfigItemID => 22,
            Direction    => 'Source',
            LinkTypeID   => 2,
            LinkType     => 'ParentChild',
        },
        ...
    ];

=cut

sub LinkedConfigItems {
    my ( $Self, %Param ) = @_;

    # TODO: support linked versions

    # check needed stuff
    for my $Argument (qw(ConfigItemID Direction UserID)) {
        if ( !$Param{$Argument} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Argument!",
            );

            return;
        }
    }

    my $LinkObject = $Kernel::OM->Get('Kernel::System::LinkObject');

    # the link type is optional
    my @TypeConditions;    # 0 or 1 conditions
    my @TypeBinds;         # 0, 1, or many binds
    if ( $Param{Types} && ref $Param{Types} eq 'ARRAY' ) {

        # empty list of types gives no result
        return [] unless $Param{Types}->@*;

        my $Placeholders = join ', ', map {'?'} $Param{Types}->@*;
        push @TypeConditions, "link_type_id IN ($Placeholders)";

        my @TypeIDs = map
            {
                $LinkObject->TypeLookup(
                    Name   => $_,
                    UserID => $Param{UserID}
                )
            }
            $Param{Types}->@*;
        push @TypeBinds, @TypeIDs;
    }

    # get complete list for both directions (or only one if restricted)
    my $Direction = $Param{Direction};
    my ( $SQL, @Binds );
    if ( $Direction eq 'Source' ) {
        $SQL = <<"END_SQL";
SELECT DISTINCT source_configitem_id, link_type_id, 'Source'
  FROM configitem_link
  WHERE @{[ join ' AND ', 'target_configitem_id = ?', @TypeConditions ]}
END_SQL
        push @Binds, $Param{ConfigItemID}, @TypeBinds;
    }
    elsif ( $Direction eq 'Target' ) {
        $SQL = <<"END_SQL";
SELECT DISTINCT target_configitem_id, link_type_id, 'Target'
  FROM configitem_link
  WHERE @{[ join ' AND ', 'source_configitem_id = ?', @TypeConditions ]}
END_SQL
        push @Binds, $Param{ConfigItemID}, @TypeBinds;
    }
    else {
        # Both directions
        # TODO: test with PostgreSQL and Oracle
        $SQL = <<"END_SQL";
(
  SELECT DISTINCT source_configitem_id, link_type_id, 'Source'
    FROM configitem_link
    WHERE @{[ join ' AND ', 'target_configitem_id = ?', @TypeConditions ]}
)
UNION
(
  SELECT DISTINCT target_configitem_id, link_type_id, 'Target'
    FROM configitem_link
    WHERE @{[ join ' AND ', 'source_configitem_id = ?', @TypeConditions ]}
)
END_SQL
        push @Binds, $Param{ConfigItemID}, @TypeBinds, $Param{ConfigItemID}, @TypeBinds;
    }

    my $DBObject = $Kernel::OM->Get('Kernel::System::DB');
    my $Rows     = $DBObject->SelectAll(
        SQL  => $SQL,
        Bind => [ \(@Binds) ],
    );

    my @Result = map
        {
            {
                ConfigItemID => $_->[0],
                LinkTypeID   => $_->[1],
                LinkType     => $LinkObject->TypeLookup(
                    TypeID => $_->[1],
                    UserID => $Param{UserID},
                ),
                Direction => $_->[2],
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

    my $DBObject = $Kernel::OM->Get('Kernel::System::DB');

    # Clean up first in all cases.
    $DBObject->Do(
        SQL => <<'END_SQL',
DELETE FROM configitem_link
  WHERE source_configitem_id = ?
    AND dynamic_field_id     = ?
END_SQL
        Bind => [ \$Param{SourceConfigItemID}, \$DynamicFieldID ],
    );

    # Nothing to do when there is no new value
    return 1 unless $Param{Value};

    # TODO: handle the case where the config item should be linked

    # INSERT the new value if there is one.
    # The values for the Reference dynamic field are per design array references,
    # even when there is only a single referenced item.
    # Exactly one of $TargetConfigItemID and $TargetConfigItemVersionID is an arrayref
    # and the other is undef. DoArray() handles this case well, but note that
    # the the parameter Bind has different semantics in DoArrray() as compared to Do()
    my $TargetConfigItemID        = $ReferencedObjectType eq 'ITSMConfigItem'        ? $Param{Value} : undef;
    my $TargetConfigItemVersionID = $ReferencedObjectType eq 'ITSMConfigItemVersion' ? $Param{Value} : undef;
    $DBObject->DoArray(
        SQL => <<'END_SQL',
INSERT INTO configitem_link (
    link_type_id,
    source_configitem_id, target_configitem_id, target_configitem_version_id, dynamic_field_id,
    create_time, create_by
  )
  VALUES (1, ?, ?, ?, ?, current_timestamp, 1 )
END_SQL
        Bind => [ $Param{SourceConfigItemID}, $TargetConfigItemID, $TargetConfigItemVersionID, $DynamicFieldID ],
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
    my @DynamicFields;
    {
        my $DynamicFieldObject       = $Kernel::OM->Get('Kernel::System::DynamicField');
        my $CompleteDynamicFieldList = $DynamicFieldObject->DynamicFieldListGet(
            ObjectType => 'ITSMConfigItem'
        );
        @DynamicFields =
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
        my ( $FieldID, $ConfigItemID, $ConfigItemVersionID, $Value, $MaxConfigItemVersionID ) = $Row->@*;

        next ROW unless $DFLookupByID{$FieldID};

        my $DFDetails = $DFLookupByID{$FieldID}->{Config};

        next ROW unless $DFDetails;

        # a fallback in case the LinkType is not configured
        my $LinkTypeWithDirection = $DFDetails->{LinkType} || 'Normal::Target';

        my ( $LinkTypeName, $Direction ) = $LinkTypeWithDirection =~ m/^ (.*) :: (Source|Target) $/x;

        next ROW unless $LinkTypeName;
        next ROW unless $Direction;

        my $LinkTypeID = $LinkObject->TypeLookup(
            Name   => $LinkTypeName,
            UserID => 1,
        );

        next ROW unless $LinkTypeID;

        # sometimes only the setting of the most recent version is relevant
        # The default is AppliesToAllVersions
        my $AllVersions = 0;
        $DFDetails->{AppliesToAllVersions} //= '';
        if ( $DFDetails->{AppliesToAllVersions} eq '' || $DFDetails->{AppliesToAllVersions} eq 'Yes' ) {
            next ROW unless $ConfigItemVersionID == $MaxConfigItemVersionID;

            $AllVersions = 1;
        }

        # some values are independent of the direction
        push @LinkTypeIDs, $LinkTypeID;
        push @FieldIDs,    $FieldID;

        if ( $Direction eq 'Target' ) {
            push @SourceConfigItemIDs,        $AllVersions                ? $ConfigItemID : undef;
            push @SourceConfigItemVersionIDs, $AllVersions                ? undef         : $ConfigItemVersionID;
            push @TargetConfigItemIDs,        $LinksToCI{$FieldID}        ? $Value        : undef;
            push @TargetConfigItemVersionIDs, $LinksToCIVersion{$FieldID} ? $Value        : undef;
        }
        else {

            # as above, but backwards
            push @TargetConfigItemIDs,        $AllVersions                ? $ConfigItemID : undef;
            push @TargetConfigItemVersionIDs, $AllVersions                ? undef         : $ConfigItemVersionID;
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

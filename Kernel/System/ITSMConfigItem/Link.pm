# --
# OTOBO is a web-based ticketing system for service organisations.
# --
# Copyright (C) 2019-2025 Rother OSS GmbH, https://otobo.io/
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

    $Self->_TriggerCurInciStateRecalc(
        ConfigItemID => $Param{SourceConfigItemID},
        Linked       => [ $Param{TargetConfigItemID} ],
        Unlinked     => [],
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

    $Self->_TriggerCurInciStateRecalc(
        ConfigItemID => $Param{SourceConfigItemID},
        Linked       => [],
        Unlinked     => [ $Param{TargetConfigItemID} ],
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
        Direction    => 'Source', # one of Source, Target, Both
        UserID       => 1,
    );

The semantics of the parameter C<Direction> can be confusing. The above call can be verbalized as:
"Give me all config items that have a 'ParentChild' or 'IsInspiredBy' relationship in which the
config item 321 is the Source object."

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
            push @SourceConditions, 'source_configitem_id = ?';
            push @TargetConditions, 'target_configitem_id = ?';
            push @IDBinds,          $Param{ConfigItemID};
        }
        if ( $Param{VersionID} ) {
            push @SourceConditions, 'source_configitem_version_id = ?';
            push @TargetConditions, 'target_configitem_version_id = ?';
            push @IDBinds,          $Param{VersionID};
        }

        # link directions are read in the same manner as wind directions - north wind comes from the north,
        # a "Source" direction returns all linked CIs where we come from $Param{ConfigItemID} as source
        # ...or so; this is consistent with Kernel/System/LinkObject.pm most importantly
        if ( $Param{Direction} eq 'Source' ) {
            $SQL = <<"END_SQL";
SELECT DISTINCT target_configitem_id, target_configitem_version_id, link_type_id, 'Source', dynamic_field_id
  FROM configitem_link
  WHERE @{[ join ' AND ', ( map { "($_)" } join ' OR ', @SourceConditions ), @TypeConditions ]}
END_SQL
            @Binds = ( @IDBinds, @TypeBinds );
        }
        elsif ( $Param{Direction} eq 'Target' ) {
            $SQL = <<"END_SQL";
SELECT DISTINCT source_configitem_id, source_configitem_version_id, link_type_id, 'Target', dynamic_field_id
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
  SELECT DISTINCT target_configitem_id, target_configitem_version_id, link_type_id, 'Source', dynamic_field_id
    FROM configitem_link
    WHERE @{[ join ' AND ', ( map { "($_)" } join ' OR ', @SourceConditions), @TypeConditions ]}
)
UNION
(
  SELECT DISTINCT source_configitem_id, source_configitem_version_id, link_type_id, 'Target', dynamic_field_id
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

DefinitionUpdates pass OldDynamicFieldConfig as additional parameter because
linking and unlinking might differ.

In the below the object holding the dynamic field is referred to as "Referencing",
the objects which are the values of the dynamic field are "Referenced". This is
important to understand the LinkTypeDirection which can either be
ReferencingIsSource or ReferencingIsTarget.

=cut

sub SyncLinkTable {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Missing ( grep { !$Param{$_} } qw(DynamicFieldConfig ConfigItemID ConfigItemLastVersionID ConfigItemVersionID) ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "Need $Missing!",
        );

        return;
    }

    my $DynamicFieldConfig   = $Param{DynamicFieldConfig};
    my $OldFieldConfig       = $Param{OldDynamicFieldConfig};
    my $DynamicFieldID       = $DynamicFieldConfig->{ID};
    my $DFDetails            = $DynamicFieldConfig->{Config};
    my $OldDFDetails         = $OldFieldConfig ? $OldFieldConfig->{Config} : $DFDetails;
    my $ReferencedObjectType = $DFDetails->{ReferencedObjectType};

    if ( $ReferencedObjectType ne 'ITSMConfigItem' && $ReferencedObjectType ne 'ITSMConfigItemVersion' ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "The parameter ReferencedObjectType must be either ITSMConfigItem or ITSMConfigItemVersion!",
        );

        return;
    }

    {
        my @LinkConfigs;

        push @LinkConfigs, $DFDetails    if $DFDetails->{LinkType};
        push @LinkConfigs, $OldDFDetails if $OldFieldConfig && $OldDFDetails->{LinkType};

        # Linking is not necessarily set up. That is fine.
        return 1 unless @LinkConfigs;

        # When linking is set up we need the complete information for how
        # the linking should be done.
        for my $Config (@LinkConfigs) {
            NEEDED:
            for my $Needed (qw(LinkDirection LinkReferencingType)) {
                next NEEDED if $Config->{$Needed};

                $Kernel::OM->Get('Kernel::System::Log')->Log(
                    Priority => 'error',
                    Message  => qq{Invalid dynamic field configuration. The setting $Needed is missing,},
                );

                return;
            }
        }
    }

    my $LinkObject = $Kernel::OM->Get('Kernel::System::LinkObject');
    my $DBObject   = $Kernel::OM->Get('Kernel::System::DB');

    # We can either build "static" links from specific config item versions
    # or "dynamic" links from a CI directly.
    # Depending on that we use a different object id
    my $ObjectID = $DFDetails->{LinkReferencingType} eq 'Dynamic' ? $Param{ConfigItemID} : $Param{ConfigItemVersionID};

    my $LinkTypeID;
    my $ObjectColumn;
    my $ValueColumn;
    my @OldValues;

    my $GetColumnData = sub {
        my $Config = $_[0];

        my $LinkTypeName = $Config->{LinkType};
        $LinkTypeID = $LinkObject->TypeLookup(
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

        # The column for the (referencing) object id depends on the direction and
        # on whether we link from a specific version (static) or the CI (dynamic)
        # Possible columns are:
        #   target_configitem_id
        #   target_configitem_version_id,
        #   source_configitem_id,
        #   source_configitem_version_id
        $ObjectColumn = join '_',
            ( $Config->{LinkDirection} eq 'ReferencingIsSource' ? 'source'     : 'target' ),
            ( $Config->{LinkReferencingType} eq 'Dynamic'       ? 'configitem' : 'configitem_version' ),
            'id';

        # The column for the (referenced) value also depends on the link direction
        # and here on the field type; if the latter changes between definitions RebuildLinkTable has to be used
        # The possible columns are the same as above
        $ValueColumn = join '_',
            ( $Config->{LinkDirection} eq 'ReferencingIsSource' ? 'target'     : 'source' ),
            ( $DynamicFieldConfig->{FieldType} eq 'ConfigItem'  ? 'configitem' : 'configitem_version' ),
            'id';
    };

    # first delete existing links
    if ( $OldDFDetails->{LinkType} ) {
        $GetColumnData->($OldDFDetails);

        # if we have CI - CI links, we have to trigger CurInciState Recalculation for deleted links
        if ( $DynamicFieldConfig->{FieldType} eq 'ConfigItem' && $OldDFDetails->{LinkReferencingType} eq 'Dynamic' ) {
            @OldValues = $DBObject->SelectColArray(
                SQL  => "SELECT $ValueColumn FROM configitem_link WHERE dynamic_field_id = ? AND $ObjectColumn = ?",
                Bind => [ \$DynamicFieldID, \$ObjectID ],
            );
        }

        $DBObject->Do(
            SQL  => "DELETE FROM configitem_link WHERE dynamic_field_id = ? AND $ObjectColumn = ?",
            Bind => [ \$DynamicFieldID, \$ObjectID ],
        );
    }

    # if we did a definition update, we have to "load" the new DF Config
    if ($OldFieldConfig) {
        $GetColumnData->($DFDetails);
    }

    my @NewValues = $Param{Value}
        ? ref $Param{Value} ? ( grep {$_} $Param{Value}->@* ) : ( $Param{Value} )
        :                     ();

    # finally set the new links
    if ( $DFDetails->{LinkType} && @NewValues ) {

        $DBObject->DoArray(
            SQL => <<"END_SQL",
INSERT INTO configitem_link (
    dynamic_field_id, link_type_id, $ObjectColumn, $ValueColumn,
    create_time, create_by
  )
  VALUES (
    ?, ?, ?, ?,
    current_timestamp, 1
  )
END_SQL
            Bind => [ $DynamicFieldID, $LinkTypeID, $ObjectID, \@NewValues ],
        );
    }

    # lastly we have to recalc current incident states for fully dynamic links
    if (
        @OldValues
        ||
        ( $DynamicFieldConfig->{FieldType} eq 'ConfigItem' && $DFDetails->{LinkReferencingType} eq 'Dynamic' )
        )
    {

        my %Linked;
        my %Unlinked = map { $_ => 1 } @OldValues;

        # if we have a normal field update, we do not need to recalculate links which do not change
        if ( !$OldFieldConfig ) {
            for my $ID (@NewValues) {
                if ( exists $Unlinked{$ID} ) {
                    delete $Unlinked{$ID};
                }
                else {
                    $Linked{$ID} = 1;
                }
            }
        }

        # in case of a definition update (we have an old DF Config) we just have to check whether we still are fully dynamic
        # we do not skip staying links, because direction and type might have changed
        elsif ( $DynamicFieldConfig->{FieldType} eq 'ConfigItem' && $DFDetails->{LinkReferencingType} eq 'Dynamic' ) {
            %Linked = map { $_ => 1 } @NewValues;
        }

        $Self->_TriggerCurInciStateRecalc(
            ConfigItemID => $ObjectID,
            Linked       => [ keys %Linked ],
            Unlinked     => [ keys %Unlinked ],
        );
    }

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
            SQL => <<"END_SQL",
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

    # for the link types we need to do some work
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

sub _TriggerCurInciStateRecalc {
    my ( $Self, %Param ) = @_;

    my $IncidentLinkTypeDirection = $Kernel::OM->Get('Kernel::Config')->Get('ITSM::Core::IncidentLinkTypeDirection');

    return 1 if !$IncidentLinkTypeDirection->%*;

    # the cache for DynamicFields => 0 is already emptied before DFs are written
    my $ReferencingCI = $Self->ConfigItemGet(
        ConfigItemID  => $Param{ConfigItemID},
        DynamicFields => 0,
    );

    # to not always recalculate the complete
    my @CIsToRecalc;

    # if the referencing CI does not have a matching CurInci and Inci state, just recalculate everything
    if ( $ReferencingCI->{CurInciStateID} ne $ReferencingCI->{InciStateID} ) {
        @CIsToRecalc = ( $Param{ConfigItemID} );

        push @CIsToRecalc, $Param{Unlinked}->@*;
    }

    else {
        LINKED:
        for my $ID ( $Param{Linked}->@* ) {
            my $ConfigItem = $Self->ConfigItemGet(
                ConfigItemID  => $ID,
                DynamicFields => 0,
            );

            # only initiate the whole recalculation if there is any difference between the CurInciStates
            if ( $ConfigItem->{CurInciStateID} ne $ReferencingCI->{CurInciStateID} ) {
                @CIsToRecalc = ( $Param{ConfigItemID} );

                last LINKED;
            }
        }

        for my $ID ( $Param{Unlinked}->@* ) {
            my $ConfigItem = $Self->ConfigItemGet(
                ConfigItemID  => $ID,
                DynamicFields => 0,
            );

            # for unlinked CIs we always have to add both sides
            if ( $ConfigItem->{CurInciStateID} ne $ReferencingCI->{CurInciStateID} ) {
                $CIsToRecalc[0] = $Param{ConfigItemID};
                push @CIsToRecalc, $ID;
            }
        }
    }

    return 1 if !@CIsToRecalc;

    return $Self->CurInciStateRecalc(
        ConfigItemIDs => \@CIsToRecalc,
    );
}

1;

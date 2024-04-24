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
    link_type_id, source_configitem_id, target_configitem_id, create_time, create_by
  )
  VALUES (?, ?, ?, current_timestamp, 1 )
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
    my $TypeID = $Kernel::OM->Get('Kernel::System::LinkObject')->TypeLookup(
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
        Bind => [ \( $TypeID, $Param{SourceConfigItemID}, $Param{TargetConfigItemID} ) ],
    );

    return 1;
}

=head2 LinkedConfigItems()

get the linked config items.

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
    for my $Missing ( grep { !$Param{$_} } qw(DynamicFieldConfig SourceConfigItemVersionID Value) ) {
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

    # Get the relevant dynamic fields.
    # Only Reference dynamic fiels that connect an ITSMConfigItem
    # to another ITSMConfigItem or an ITSMConfigItemVersion are relevant.
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
    return {
        Success => 1,
        Message => Translatable('No relevant dynamic fields were found'),
        Color   => 'yellow',
    } unless @DynamicFields;

    my %IsConfigItem =
        map  { $_->{ID} => 1 }
        grep { $_->{FieldType} eq 'ConfigItem' }
        @DynamicFields;
    my %IsConfigItemVersion =
        map  { $_->{ID} => 1 }
        grep { $_->{FieldType} eq 'ConfigItemVersion' }
        @DynamicFields;

    # Get the relevant dynamic field values.
    # The methods in Kernel::System::DynamicFieldValue are specific to specific fields,
    # so use dedicated SQL here.
    my $Rows;
    {
        my @DynamicFieldIDs = map { $_->{ID} } @DynamicFields;
        my $PlaceHolders =
            join ', ',
            map {'?'}
            @DynamicFieldIDs;
        my $Binds = [ map { \$_ } @DynamicFieldIDs ];    # the special case \(@Array) is too strange
        $Rows = $DBObject->SelectAll(
            SQL => << "END_SQL",
SELECT dfv.id, dfv.field_id, v.configitem_id, dfv.value_int
  FROM dynamic_field_value dfv
  INNER JOIN configitem_version v ON dfv.object_id = v.id
  WHERE dfv.field_id IN ( $PlaceHolders )
  ORDER by dfv.id
END_SQL
            Bind => $Binds,
        );
    }

    # prepare the dynamic field values so that it can be used in a batch insert
    my @DynamicFieldIDs = map { $_->[1] } $Rows->@*;

    # TODO: determine the link types
    my @SourceConfigItemIDs        = map { $_->[2] } $Rows->@*;
    my @TargetConfigItemIDs        = map { $IsConfigItem{ $_->[1] }        ? $_->[3] : undef } $Rows->@*;
    my @TargetConfigItemVersionIDs = map { $IsConfigItemVersion{ $_->[1] } ? $_->[3] : undef } $Rows->@*;

    # Multivalue INSERT
    my $NumReferenceRows = $DBObject->DoArray(
        SQL => <<'END_SQL',
INSERT INTO configitem_link (
    link_type_id,
    source_configitem_id,
    target_configitem_id,
    target_configitem_version_id,
    dynamic_field_id,
    create_time,
    create_by
  )
  VALUES (?, ?, ?, ?, ?, CURRENT_TIMESTAMP(), 1)
END_SQL
        Bind => [
            1,
            \@SourceConfigItemIDs,
            \@TargetConfigItemIDs,
            \@TargetConfigItemVersionIDs,
            \@DynamicFieldIDs,
        ],
    );

    return {
        Success => 0,
        Message => Translatable('Could not insert into the table configitem_link'),
        Color   => 'red',
    } unless defined $NumReferenceRows;

    # TODO: add rows from LinkObject
    my $NumLinkObjectRows = 0;

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

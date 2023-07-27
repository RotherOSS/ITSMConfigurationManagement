# --
# OTOBO is a web-based ticketing system for service organisations.
# --
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

package Kernel::System::ITSMConfigItem::Reference;

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

Kernel::System::ITSMConfigItem::Reference - sub module of Kernel::System::ITSMConfigItem

=head1 DESCRIPTION

This modules supports the maintenance of the content of the table B<configitem_reference>. This table
is a shadow of the information that is contained in Reference dynamic fields that connect objects
of type C<ITSMConfigItem> and C<ITSMConfigItemVersion>.

There is support for immediate update of the table and for a complete rebuild of the table.

Planned is also support for dumping the complete graph so that it can be used for presentation.

=head1 PUBLIC INTERFACE

=head2 RebuildReferenceTable()

purge and repopulate the table B<configitem_reference> based on the Reference dynamic fields.

    my $Result = $ConfigItemObject->RebuildReferenceTable;

The result is a hashref like:

    my $Result = {
        Success  => 1, # or 0 in case of failure
        Message  => 'some message',
        Color    => 'green',    # or red, or yellow
    };

=cut

sub RebuildReferenceTable {
    my ($Self) = @_;

    # no parameters are supported

    my $DBObject = $Kernel::OM->Get('Kernel::System::DB');

    # purge the table
    my $SuccessPurge = $DBObject->Do(
        SQL => 'DELETE FROM configitem_reference'
    );
    if ( !$SuccessPurge ) {
        return {
            Success => 0,
            Message => Translatable('Could not purge the table configitem_reference.'),
            Color   => 'red',
        };
    }

    # Get the relevant dynamic fields.
    # Only Reference dynamic fiels that connect an ITSMConfigItem
    # to an ITSMConfigItem or an ITSMConfigItemVersion are relevant.
    my $DynamicFieldObject       = $Kernel::OM->Get('Kernel::System::DynamicField');
    my $CompleteDynamicFieldList = $DynamicFieldObject->DynamicFieldListGet(
        ObjectType => 'ITSMConfigItem'
    );
    my @DynamicFields =
        grep {
            $_->{Config}->{ReferencedObjectType} eq 'ITSMConfigItem'
            ||
            $_->{Config}->{ReferencedObjectType} eq 'ITSMConfigItemVersion'
        }
        grep { $_->{Config}->{ReferencedObjectType} }
        grep { $_->{Config} }
        grep { $_->{FieldType} eq 'Reference' }
        $CompleteDynamicFieldList->@*;

    if ( !@DynamicFields ) {

        # nothing to do when there are no dynamic fields
        return {
            Success => 1,
            Message => Translatable('No relevant dynamic fields were found'),
            Color   => 'yellow',
        };
    }

    my %IsConfigItem = map
        { $_->{ID} => 1 }
        grep
        { $_->{Config}->{ReferencedObjectType} eq 'ITSMConfigItem' }
        @DynamicFields;
    my %IsConfigItemVersion = map
        { $_->{ID} => 1 }
        grep
        { $_->{Config}->{ReferencedObjectType} eq 'ITSMConfigItemVersion' }
        @DynamicFields;

    # Get the relevant dynamic field values.
    # The methods in Kernel::System::DynamicFieldValue are specific to specific fields,
    # so use dedicated SQL here.
    my @DynamicFieldIDs = map { $_->{ID} } @DynamicFields;
    my $PlaceHolders =
        join ', ',
        map {'?'}
        @DynamicFieldIDs;
    my $Binds = [ map { \$_ } @DynamicFieldIDs ];    # the special case \(@Array) is too strange
    my $Rows  = $DBObject->SelectAll(
        SQL => << "END_SQL",
SELECT id, field_id, object_id, value_int
  FROM dynamic_field_value
  WHERE field_id IN ( $PlaceHolders )
  ORDER by id
END_SQL
        Bind => $Binds,
    );

    # prepare the dynamic field values so that it can be used in a batch insert
    my @DynamicFieldValueIDs       = map { $_->[0] } $Rows->@*;
    my @SourceConfigItemVersionIDs = map { $_->[2] } $Rows->@*;
    my @TargetConfigItemIDs        = map { $IsConfigItem{ $_->[1] }        ? $_->[3] : undef } $Rows->@*;
    my @TargetConfigItemVersionIDs = map { $IsConfigItemVersion{ $_->[1] } ? $_->[3] : undef } $Rows->@*;

    # Multivalue INSERT
    # TODO: This is just prove of concept
    my $DBHandle        = $DBObject->Connect;
    my $StatementHandle = $DBHandle->prepare( <<'END_SQL' );
INSERT INTO configitem_reference(link_type_id, source_configitem_version_id, target_configitem_id, target_configitem_version_id, dynamic_field_value_id, create_time, create_by)
  VALUES (?, ?, ?, ?, ?, CURRENT_TIMESTAMP(), 1)
END_SQL
    my $Tuples = $StatementHandle->execute_array(
        { ArrayTupleStatus => \my @TupleStatus },
        1,
        \@SourceConfigItemVersionIDs,
        \@TargetConfigItemIDs,
        \@TargetConfigItemVersionIDs,
        \@DynamicFieldValueIDs,
    );

    if ( !defined $Tuples ) {
        return {
            Success => 0,
            Message => Translatable('Could not insert into the table configitem_reference'),
            Color   => 'red',
        };
    }
    elsif ( $Tuples == 0 ) {
        return {
            Success => 1,
            Message => Translatable('Inserted 0 rows into the table configitem_reference'),
            Color   => 'yellow',
        };
    }

    # no problems
    return {
        Success => 1,
        Message => Translatable('Done'),
        Color   => 'green',
    };
}

1;

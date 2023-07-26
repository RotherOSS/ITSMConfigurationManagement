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

package Kernel::System::Console::Command::Maint::ITSM::Configitem::RebuildReferenceTable;

use v5.24;
use strict;
use warnings;
use namespace::autoclean;
use utf8;

# core modules

# CPAN modules

# OTOBO modules

use parent qw(Kernel::System::Console::BaseCommand);

our @ObjectDependencies = qw(
    Kernel::System::DB
    Kernel::System::DynamicField
);

sub Configure {
    my ( $Self, %Param ) = @_;

    $Self->Description(<<'END_TXT');
Rebuild the table configitem_reference from the Reference dynamic fields. Only the fields linking config items are
considered here.
END_TXT

    return;
}

sub Run {
    my ( $Self, %Param ) = @_;

    $Self->Print("<yellow>Rebuilding the table configitem_reference...</yellow>\n\n");

    my $DBObject = $Kernel::OM->Get('Kernel::System::DB');

    # purge the table
    return unless $DBObject->Do(
        SQL => 'DELETE FROM configitem_reference'
    );

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
        $Self->Print("<yellow>No relevant dynamic fields were found.</yellow>\n");

        return $Self->ExitCodeOk;
    }

    my @DynamicFieldIDs = map { $_->{ID} } @DynamicFields;
    my %IsConfigItem    = map
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
    my $Success = $StatementHandle->execute_array(
        { ArrayTupleStatus => \my @TupleStatus },
        1,
        \@SourceConfigItemVersionIDs,
        \@TargetConfigItemIDs,
        \@TargetConfigItemVersionIDs,
        \@DynamicFieldValueIDs,
    );

    if ( !$Success ) {
        $Self->PrintError("\nUnable to fill the table configitem_reference.");

        return $Self->ExitCodeError;
    }

    # looks good
    $Self->Print("<green>Done.</green>\n");

    return $Self->ExitCodeOk;
}

1;

# --
# OTOBO is a web-based ticketing system for service organisations.
# --
# Copyright (C) 2001-2020 OTRS AG, https://otrs.com/
# Copyright (C) 2019-2025 Rother OSS GmbH, https://otobo.io/
# --
# $origin: otobo - 58ebb59b1c8f1fc866865ea8510e52e3969f62ce - Kernel/System/DynamicField.pm
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

package Kernel::System::DynamicField;

use v5.24;
use strict;
use warnings;
use namespace::autoclean;
use utf8;

use parent qw(Kernel::System::EventHandler);

# core modules

# CPAN modules

# OTOBO modules
use Kernel::System::VariableCheck qw(:all);

our @ObjectDependencies = (
    'Kernel::Config',
    'Kernel::System::Cache',
    'Kernel::System::DB',
    'Kernel::System::Log',
    'Kernel::System::Valid',
    'Kernel::System::YAML',
);

=head1 NAME

Kernel::System::DynamicField - general methods for dynamic fields

=head1 DESCRIPTION

DynamicFields backend.

=head1 PUBLIC INTERFACE

=head2 new()

create a DynamicField object. Do not use it directly, instead use:

    my $DynamicFieldObject = $Kernel::OM->Get('Kernel::System::DynamicField');

=cut

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = bless {}, $Type;

    # get the cache TTL (in seconds)
    $Self->{CacheTTL} = $Kernel::OM->Get('Kernel::Config')->Get('DynamicField::CacheTTL') || 3600;

    # set lower if database is case sensitive
    $Self->{Lower} = '';
    if ( $Kernel::OM->Get('Kernel::System::DB')->GetDatabaseFunction('CaseSensitive') ) {
        $Self->{Lower} = 'LOWER';
    }

    # init of event handler
    $Self->EventHandlerInit(
        Config => 'DynamicField::EventModulePost',
    );

    return $Self;
}

=head2 DynamicFieldAdd()

add new Dynamic Field config

returns the ID of the new dynamic field if successful. Returns undef otherwise.

    my $ID = $DynamicFieldObject->DynamicFieldAdd(
        InternalField => 0,             # optional, 0 or 1, internal fields are protected
        Name        => 'NameForField',  # mandatory, may only consist of ASCII alphanumerics and '-'
        Label       => 'a description', # mandatory, label to show
        FieldOrder  => 123,             # mandatory, display order
        FieldType   => 'Text',          # mandatory, selects the DF backend to use for this field
        ObjectType  => 'Article',       # this controls which object the dynamic field links to
                                        # allow only lowercase letters
        Config      => $ConfigHashRef,  # it is stored on YAML format
                                        # to individual articles, otherwise to tickets
        Reorder     => 1,               # or 0, to trigger reorder function, default 1
        ValidID     => 1,
        UserID      => 123,
    );

Returns:

    $ID = 567;

=cut

sub DynamicFieldAdd {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Key (qw(Name Label FieldOrder FieldType ObjectType Config ValidID UserID)) {
        if ( !$Param{$Key} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Key!"
            );
            return;
        }
    }

    # check needed structure for some fields
    if ( $Param{Name} !~ m{ \A [a-zA-Z\d-]+ \z }axms ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "Not valid letters on Name:$Param{Name}!"
        );
        return;
    }

    # get database object
    my $DBObject = $Kernel::OM->Get('Kernel::System::DB');

    # check if Name already exists
    return if !$DBObject->Prepare(
        SQL   => "SELECT id FROM dynamic_field WHERE $Self->{Lower}(name) = $Self->{Lower}(?)",
        Bind  => [ \$Param{Name} ],
        Limit => 1,
    );

    my $NameExists;
    while ( my @Data = $DBObject->FetchrowArray() ) {
        $NameExists = 1;
    }

    if ($NameExists) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "A dynamic field with the name '$Param{Name}' already exists.",
        );
        return;
    }

    if ( $Param{FieldOrder} !~ m{ \A [\d]+ \z }xms ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "Not valid number on FieldOrder:$Param{FieldOrder}!"
        );
        return;
    }

    # dump config as string
    my $Config = $Kernel::OM->Get('Kernel::System::YAML')->Dump( Data => $Param{Config} );

    my $InternalField = $Param{InternalField} ? 1 : 0;

    # sql
    return if !$DBObject->Do(
        SQL =>
            'INSERT INTO dynamic_field (internal_field, name, label, field_Order, field_type, object_type,'
            .
            ' config, valid_id, create_time, create_by, change_time, change_by)' .
            ' VALUES (?, ?, ?, ?, ?, ?, ?, ?, current_timestamp, ?, current_timestamp, ?)',
        Bind => [
            \$InternalField,     \$Param{Name}, \$Param{Label},   \$Param{FieldOrder}, \$Param{FieldType},
            \$Param{ObjectType}, \$Config,      \$Param{ValidID}, \$Param{UserID},     \$Param{UserID},
        ],
    );

    # get cache object
    my $CacheObject = $Kernel::OM->Get('Kernel::System::Cache');

    # delete cache
    $CacheObject->CleanUp(
        Type => 'DynamicField',
    );
    $CacheObject->CleanUp(
        Type => 'DynamicFieldValue',
    );

    my $DynamicField = $Self->DynamicFieldGet(
        Name => $Param{Name},
    );

    return if !$DynamicField->{ID};

    # trigger event
    $Self->EventHandler(
        Event => 'DynamicFieldAdd',
        Data  => {
            NewData => $DynamicField,
        },
        UserID => $Param{UserID},
    );

    if ( !exists $Param{Reorder} || $Param{Reorder} ) {

        # re-order field list
        $Self->_DynamicFieldReorder(
            ID         => $DynamicField->{ID},
            FieldOrder => $DynamicField->{FieldOrder},
            Mode       => 'Add',
        );
    }

    return $DynamicField->{ID};
}

=head2 DynamicFieldGet()

get Dynamic Field attributes

    my $DynamicField = $DynamicFieldObject->DynamicFieldGet(
        ID   => 123,             # ID or Name must be provided
        Name => 'DynamicField',
    );

Returns:

    $DynamicField = {
        ID            => 123,
        InternalField => 0,
        Name          => 'NameForField',
        Label         => 'The label to show',
        FieldOrder    => 123,
        FieldType     => 'Text',
        ObjectType    => 'Article',
        Config        => $ConfigHashRef,
        ValidID       => 1,
        CreateTime    => '2011-02-08 15:08:00',
        ChangeTime    => '2011-06-11 17:22:00',
    };

=cut

sub DynamicFieldGet {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    if ( !$Param{ID} && !$Param{Name} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => 'Need ID or Name!'
        );
        return;
    }

    # get cache object
    my $CacheObject = $Kernel::OM->Get('Kernel::System::Cache');

    # check cache
    my $CacheKey;
    if ( $Param{ID} ) {
        $CacheKey = 'DynamicFieldGet::ID::' . $Param{ID};
    }
    else {
        $CacheKey = 'DynamicFieldGet::Name::' . $Param{Name};

    }
    my $Cache = $CacheObject->Get(
        Type => 'DynamicField',
        Key  => $CacheKey,
    );
    return $Cache if $Cache;

    # get database object
    my $DBObject = $Kernel::OM->Get('Kernel::System::DB');

    # sql
    if ( $Param{ID} ) {
        return if !$DBObject->Prepare(
            SQL =>
                'SELECT id, internal_field, name, label, field_order, field_type, object_type, config,'
                .
                ' valid_id, create_time, change_time ' .
                'FROM dynamic_field WHERE id = ?',
            Bind => [ \$Param{ID} ],
        );
    }
    else {
        return if !$DBObject->Prepare(
            SQL =>
                'SELECT id, internal_field, name, label, field_order, field_type, object_type, config,'
                .
                ' valid_id, create_time, change_time ' .
                'FROM dynamic_field WHERE name = ?',
            Bind => [ \$Param{Name} ],
        );
    }

    # get yaml object
    my $YAMLObject = $Kernel::OM->Get('Kernel::System::YAML');

    my %Data;
    while ( my @Data = $DBObject->FetchrowArray() ) {

        my $Config = $YAMLObject->Load( Data => $Data[7] );

        %Data = (
            ID            => $Data[0],
            InternalField => $Data[1],
            Name          => $Data[2],
            Label         => $Data[3],
            FieldOrder    => $Data[4],
            FieldType     => $Data[5],
            ObjectType    => $Data[6],
            Config        => $Config,
            ValidID       => $Data[8],
            CreateTime    => $Data[9],
            ChangeTime    => $Data[10],
        );
    }

    if (%Data) {

        # Set the cache only, if the YAML->Load was successful (see bug#12483).
        if ( $Data{Config} ) {

            $CacheObject->Set(
                Type  => 'DynamicField',
                Key   => $CacheKey,
                Value => \%Data,
                TTL   => $Self->{CacheTTL},
            );
        }

        $Data{Config} ||= {};
    }

    return \%Data;
}

=head2 DynamicFieldUpdate()

update Dynamic Field content into database

returns 1 on success or undef on error

    my $Success = $DynamicFieldObject->DynamicFieldUpdate(
        ID          => 1234,            # mandatory
        Name        => 'NameForField',  # mandatory
        Label       => 'a description', # mandatory, label to show
        FieldOrder  => 123,             # mandatory, display order
        FieldType   => 'Text',          # mandatory, selects the DF backend to use for this field
        ObjectType  => 'Article',       # this controls which object the dynamic field links to
                                        # allow only lowercase letters
        Config      => $ConfigHashRef,  # it is stored on YAML format
                                        # to individual articles, otherwise to tickets
        ValidID     => 1,
        Reorder     => 1,               # or 0, to trigger reorder function, default 1
                                        # 0 is only used internally to prevent redundant execution on order change
                                        # no update event will be triggered for 0
        UserID      => 123,
    );

=cut

sub DynamicFieldUpdate {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Key (qw(ID Name Label FieldOrder FieldType ObjectType Config ValidID UserID)) {
        if ( !$Param{$Key} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Key!"
            );
            return;
        }
    }

    my $Reorder;
    if ( !exists $Param{Reorder} || $Param{Reorder} eq 1 ) {
        $Reorder = 1;
    }

    my $YAMLObject = $Kernel::OM->Get('Kernel::System::YAML');

    # get the old dynamic field data
    my $OldDynamicField = $Self->DynamicFieldGet(
        ID => $Param{ID},
    );

    # keep PartOfSet if present, or delete it if explicitly deactivated
    if ( $OldDynamicField->{Config}{PartOfSet} ) {
        $Param{Config}{PartOfSet} //= $OldDynamicField->{Config}{PartOfSet};

        delete $Param{Config}{PartOfSet} if !$Param{Config}{PartOfSet};
    }

    # dump config as string
    my $Config = $YAMLObject->Dump( Data => $Param{Config} );

    return if !$YAMLObject->Load( Data => $Config );

    # check needed structure for some fields
    if ( $Param{Name} !~ m{ \A [a-zA-Z\d\-]+ \z }xms ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "Not valid letters on Name:$Param{Name} or ObjectType:$Param{ObjectType}!",
        );
        return;
    }

    # get database object
    my $DBObject = $Kernel::OM->Get('Kernel::System::DB');

    # check if Name already exists
    return if !$DBObject->Prepare(
        SQL => "SELECT id FROM dynamic_field "
            . "WHERE $Self->{Lower}(name) = $Self->{Lower}(?) "
            . "AND id != ?",
        Bind  => [ \$Param{Name}, \$Param{ID} ],
        LIMIT => 1,
    );

    my $NameExists;
    while ( my @Data = $DBObject->FetchrowArray() ) {
        $NameExists = 1;
    }

    if ($NameExists) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "A dynamic field with the name '$Param{Name}' already exists.",
        );
        return;
    }

    if ( $Param{FieldOrder} !~ m{ \A [\d]+ \z }xms ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "Not valid number on FieldOrder:$Param{FieldOrder}!",
        );
        return;
    }

    # check if FieldOrder is changed
    my $ChangedOrder;
    if ( $OldDynamicField->{FieldOrder} ne $Param{FieldOrder} ) {
        $ChangedOrder = 1;
    }

    # sql
    return if !$DBObject->Do(
        SQL => 'UPDATE dynamic_field SET name = ?, label = ?, field_order =?, field_type = ?, '
            . 'object_type = ?, config = ?, valid_id = ?, change_time = current_timestamp, '
            . ' change_by = ? WHERE id = ?',
        Bind => [
            \$Param{Name}, \$Param{Label}, \$Param{FieldOrder}, \$Param{FieldType},
            \$Param{ObjectType}, \$Config, \$Param{ValidID}, \$Param{UserID}, \$Param{ID},
        ],
    );

    # get cache object
    my $CacheObject = $Kernel::OM->Get('Kernel::System::Cache');

    # delete cache
    $CacheObject->CleanUp(
        Type => 'DynamicField',
    );
    $CacheObject->CleanUp(
        Type => 'DynamicFieldValue',
    );

    # get the new dynamic field data
    my $NewDynamicField = $Self->DynamicFieldGet(
        ID => $Param{ID},
    );

    # trigger event only if potentially the content of the field changed
    # this should not be the case if Reorder => 0 is set
    # consider adding removing the condition and adding Reorder to the event data
    # if we ever need an event to act on fields being only reordered
    if ($Reorder) {
        $Self->EventHandler(
            Event => 'DynamicFieldUpdate',
            Data  => {
                NewData => $NewDynamicField,
                OldData => $OldDynamicField,
            },
            UserID => $Param{UserID},
        );
    }

    # re-order field list if a change in the order was made
    if ( $Reorder && $ChangedOrder ) {
        my $Success = $Self->_DynamicFieldReorder(
            ID            => $Param{ID},
            FieldOrder    => $Param{FieldOrder},
            Mode          => 'Update',
            OldFieldOrder => $OldDynamicField->{FieldOrder},
        );
    }

    return 1;
}

=head2 DynamicFieldDelete()

delete a Dynamic field entry. You need to make sure that all values are
deleted before calling this function, otherwise it will fail on DBMS which check
referential integrity.

returns 1 if successful or undef otherwise

    my $Success = $DynamicFieldObject->DynamicFieldDelete(
        ID      => 123,
        UserID  => 123,
        Reorder => 1,               # or 0, to trigger reorder function, default 1
    );

=cut

sub DynamicFieldDelete {
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
    my $DynamicField = $Self->DynamicFieldGet(
        ID => $Param{ID},
    );
    return if !IsHashRefWithData($DynamicField);

    # re-order before delete
    if ( !exists $Param{Reorder} || $Param{Reorder} ) {
        my $Success = $Self->_DynamicFieldReorder(
            ID         => $DynamicField->{ID},
            FieldOrder => $DynamicField->{FieldOrder},
            Mode       => 'Delete',
        );
    }

    # delete dynamic field
    return if !$Kernel::OM->Get('Kernel::System::DB')->Do(
        SQL  => 'DELETE FROM dynamic_field WHERE id = ?',
        Bind => [ \$Param{ID} ],
    );

    # get cache object
    my $CacheObject = $Kernel::OM->Get('Kernel::System::Cache');

    # delete cache
    $CacheObject->CleanUp(
        Type => 'DynamicField',
    );
    $CacheObject->CleanUp(
        Type => 'DynamicFieldValue',
    );

    # trigger event
    $Self->EventHandler(
        Event => 'DynamicFieldDelete',
        Data  => {
            NewData => $DynamicField,
        },
        UserID => $Param{UserID},
    );

    return 1;
}

=head2 DynamicFieldList()

get DynamicField list ordered by the the "Field Order" field in the DB

    my $List = $DynamicFieldObject->DynamicFieldList();

or

    my $List = $DynamicFieldObject->DynamicFieldList(
        Valid => 0,             # optional, defaults to 1

        # object  type (optional) as STRING or as ARRAYREF
        ObjectType => 'Ticket',
        ObjectType => ['Ticket', 'Article'],

        ResultType => 'HASH',   # optional, 'ARRAY' or 'HASH', defaults to 'ARRAY'

        FieldFilter => {        # optional, only active fields (non 0) will be returned
            ItemOne   => 1,
            ItemTwo   => 2,
            ItemThree => 1,
            ItemFour  => 1,
            ItemFive  => 0,
        },

        Namespace => 'Namespace', # optional, Namespace as string ('<none>' for all fields without namespace)
    );

Returns:

    $List = {
        1 => 'ItemOne',
        2 => 'ItemTwo',
        3 => 'ItemThree',
        4 => 'ItemFour',
    };

or

    $List = (
        1,
        2,
        3,
        4
    );

=cut

sub DynamicFieldList {
    my ( $Self, %Param ) = @_;

    # to store fieldIDs white-list
    my %AllowedFieldIDs;

    if ( defined $Param{FieldFilter} && ref $Param{FieldFilter} eq 'HASH' ) {

        # fill the fieldIDs white-list
        FIELDNAME:
        for my $FieldName ( sort keys %{ $Param{FieldFilter} } ) {
            next FIELDNAME if !$Param{FieldFilter}->{$FieldName};

            my $FieldConfig = $Self->DynamicFieldGet( Name => $FieldName );
            next FIELDNAME if !IsHashRefWithData($FieldConfig);
            next FIELDNAME if !$FieldConfig->{ID};

            $AllowedFieldIDs{ $FieldConfig->{ID} } = 1;
        }
    }

    # check cache
    my $Valid = 1;
    if ( defined $Param{Valid} && $Param{Valid} eq '0' ) {
        $Valid = 0;
    }

    # set cache key object type component depending on the ObjectType parameter
    my $ObjectType = 'All';
    if ( IsArrayRefWithData( $Param{ObjectType} ) ) {
        $ObjectType = join '_', sort @{ $Param{ObjectType} };
    }
    elsif ( IsStringWithData( $Param{ObjectType} ) ) {
        $ObjectType = $Param{ObjectType};
    }

    # set cache key namespace component depending on the Namespace parameter
    my $Namespace = 'All';
    if ( IsStringWithData( $Param{Namespace} ) ) {
        $Namespace = $Param{Namespace};
    }

    my $ResultType = $Param{ResultType} || 'ARRAY';
    $ResultType = $ResultType eq 'HASH' ? 'HASH' : 'ARRAY';

    # get cache object
    my $CacheObject = $Kernel::OM->Get('Kernel::System::Cache');

    my $CacheKey = 'DynamicFieldList::Valid::'
        . $Valid
        . '::ObjectType::'
        . $ObjectType
        . '::Namespace::'
        . $Namespace
        . '::ResultType::'
        . $ResultType;
    my $Cache = $CacheObject->Get(
        Type => 'DynamicField',
        Key  => $CacheKey,
    );

    if ($Cache) {

        # check if FieldFilter is not set
        if ( !defined $Param{FieldFilter} ) {

            # return raw data from cache
            return $Cache;
        }
        elsif ( ref $Param{FieldFilter} ne 'HASH' ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => 'FieldFilter must be a HASH reference!',
            );
            return;
        }

        # otherwise apply the filter
        my $FilteredData;

        # check if cache is ARRAY ref
        if ( $ResultType eq 'ARRAY' ) {

            FIELDID:
            for my $FieldID ( @{$Cache} ) {
                next FIELDID if !$AllowedFieldIDs{$FieldID};

                push @{$FilteredData}, $FieldID;
            }

            # return filtered data from cache
            return $FilteredData;
        }

        # otherwise is a HASH ref
        else {

            FIELDID:
            for my $FieldID ( sort keys %{$Cache} ) {
                next FIELDID if !$AllowedFieldIDs{$FieldID};

                $FilteredData->{$FieldID} = $Cache->{$FieldID};
            }
        }

        # return filtered data from cache
        return $FilteredData;
    }

    else {
        # create sql query
        my $SQL = 'SELECT id, name, field_order FROM dynamic_field';
        my @Bind;

        # get database object
        my $DBObject = $Kernel::OM->Get('Kernel::System::DB');

        # collect where clauses in array for joining them later
        my @WhereClauses;

        if ($Valid) {

            # get valid object
            my $ValidObject = $Kernel::OM->Get('Kernel::System::Valid');

            my @ValidIDs = $ValidObject->ValidIDsGet();

            if (@ValidIDs) {

                # set one question mark for each valid id in order to use bind array
                push @WhereClauses, 'valid_id IN (' . join( ', ', map {'?'} @ValidIDs ) . ')';
                push @Bind,         map { \$_ } @ValidIDs;
            }

        }

        if ( $Param{ObjectType} ) {

            # differentiate whether we have an object type string or array
            if ( IsStringWithData( $Param{ObjectType} ) && $Param{ObjectType} ne 'All' ) {
                push @WhereClauses, 'object_type = ?';
                push @Bind,         \$Param{ObjectType};
            }
            elsif ( IsArrayRefWithData( $Param{ObjectType} ) ) {
                push @WhereClauses, 'object_type IN (' . join( ', ', map {'?'} $Param{ObjectType}->@* ) . ')';
                push @Bind,         map { \$_ } $Param{ObjectType}->@*;
            }

        }

        if ( $Param{Namespace} && $Param{Namespace} ne 'All' ) {

            # select all fields without a namespace
            if ( $Param{Namespace} eq '<none>' ) {
                push @WhereClauses, 'name NOT LIKE ?';
                push @Bind,         \"%-%";
            }

            # select all fields of the given namespace
            else {
                push @WhereClauses, 'name LIKE ?';
                push @Bind,         \"$Param{Namespace}-%";
            }
        }

        if (@WhereClauses) {
            $SQL .= " WHERE " . join( " AND ", @WhereClauses );
        }

        $SQL .= " ORDER BY field_order, id";

        return if !$DBObject->Prepare(
            SQL  => $SQL,
            Bind => \@Bind,
        );

        if ( $ResultType eq 'HASH' ) {
            my %Data;

            while ( my @Row = $DBObject->FetchrowArray() ) {
                $Data{ $Row[0] } = $Row[1];
            }

            # set cache
            $CacheObject->Set(
                Type  => 'DynamicField',
                Key   => $CacheKey,
                Value => \%Data,
                TTL   => $Self->{CacheTTL},
            );

            # check if FieldFilter is not set
            if ( !defined $Param{FieldFilter} ) {

                # return raw data from DB
                return \%Data;
            }
            elsif ( ref $Param{FieldFilter} ne 'HASH' ) {
                $Kernel::OM->Get('Kernel::System::Log')->Log(
                    Priority => 'error',
                    Message  => 'FieldFilter must be a HASH reference!',
                );
                return;
            }

            my %FilteredData;
            FIELDID:
            for my $FieldID ( sort keys %Data ) {
                next FIELDID if !$AllowedFieldIDs{$FieldID};

                $FilteredData{$FieldID} = $Data{$FieldID};
            }

            # return filtered data from DB
            return \%FilteredData;
        }

        else {

            my @Data;
            while ( my @Row = $DBObject->FetchrowArray() ) {
                push @Data, $Row[0];
            }

            # set cache
            $CacheObject->Set(
                Type  => 'DynamicField',
                Key   => $CacheKey,
                Value => \@Data,
                TTL   => $Self->{CacheTTL},
            );

            # check if FieldFilter is not set
            if ( !defined $Param{FieldFilter} ) {

                # return raw data from DB
                return \@Data;
            }
            elsif ( ref $Param{FieldFilter} ne 'HASH' ) {
                $Kernel::OM->Get('Kernel::System::Log')->Log(
                    Priority => 'error',
                    Message  => 'FieldFilter must be a HASH reference!',
                );
                return;
            }

            my @FilteredData;
            FIELDID:
            for my $FieldID (@Data) {
                next FIELDID if !$AllowedFieldIDs{$FieldID};

                push @FilteredData, $FieldID;
            }

            # return filtered data from DB
            return \@FilteredData;
        }
    }

    return;
}

# Rother OSS / ITSMConfigurationManagement
=head2 DynamicFieldListMask()

retrieve DynamicField list from given mask definition

    my $List = $DynamicFieldObject->DynamicFieldListMask();

or

    my $List = $DynamicFieldObject->DynamicFieldListMask(
        Content    => [
            { DF => 'FieldName1' },
            {
                Grid => {
                    Columns => 2,
                    Rows    => [
                        [
                            { DF => 'FieldName2' },
                        ],
                    ],
                }
            }
        ],
    );

Returns:

    $List = [
        'ItemOne',
        'ItemTwo',
        'ItemThree',
        'ItemFour',
    ];

=cut

sub DynamicFieldListMask {
    my ( $Self, %Param ) = @_;

    if ( !IsArrayRefWithData( $Param{Content} ) ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => 'Need Content!',
        );
        return;
    }

    my $ResultType = $Param{ResultType} || 'ARRAY';
    $ResultType = $ResultType eq 'HASH' ? 'HASH' : 'ARRAY';

    # track fields in hash to avoid returning duplicates
    my %DFSeen;
    my @DFList;

    # cycle through content rows
    CONTENTELEMENT:
    for my $Element ( $Param{Content}->@* ) {
        if ( !IsHashRefWithData($Element) ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Misconfigured Definition!",
            );

            next CONTENTELEMENT;
        }

        if ( $Element->{DF} ) {
            next CONTENTELEMENT if $DFSeen{ $Element->{DF} }++;
            push @DFList, $Element->{DF};
        }
        elsif ( $Element->{Grid} ) {
            if ( !IsArrayRefWithData( $Element->{Grid}{Rows} ) ) {
                $Kernel::OM->Get('Kernel::System::Log')->Log(
                    Priority => 'error',
                    Message  => "Misconfigured Grid - need Rows as Array!",
                );

                next ELEMENT;
            }
            if ( $Element->{Grid}{Columns} !~ /^0*[1-9]\d*$/ ) {
                $Kernel::OM->Get('Kernel::System::Log')->Log(
                    Priority => 'error',
                    Message  => "Misconfigured Grid - need Columns as integer > 0!",
                );

                next ELEMENT;
            }

            for my $Row ( $Element->{Grid}{Rows}->@* ) {
                for my $RowElement ( $Row->@* ) {
                    if ( $RowElement->{DF} ) {
                        next CONTENTELEMENT if $DFSeen{ $RowElement->{DF} }++;
                        push @DFList, $RowElement->{DF};
                    }
                }
            }
        }
    }

    return \@DFList;
}
# EO ITSMConfigurationManagement

=head2 DynamicFieldListGet()

get list of valid dynamic fields with complete data ordered by the "Field Order" field in the DB

    my $List = $DynamicFieldObject->DynamicFieldListGet;

Additional restrictions can be applied:

    my $List = $DynamicFieldObject->DynamicFieldListGet(
        Valid        => 0,            # optional, defaults to 1

        # object  type (optional) as STRING or as ARRAYREF
        # The special object type 'All' places no restriction on the object type when
        # it is passed as a single string.
        ObjectType => 'Ticket',
        ObjectType => ['Ticket', 'Article'],

        # optional, filter by name of the dynamic field
        # only the fields where there the field name has a true value are returned
        FieldFilter => {
            nameforfield => 1,
            fieldname    => 2,
            other        => 0,
            otherfield   => 0,
        },
    );

Returns:

    $List = [
        {
            ID            => 123,
            InternalField => 0,
            Name          => 'nameforfield',
            Label         => 'The label to show',
            FieldType     => 'Text',
            ObjectType    => 'Article',
            Config        => $ConfigHashRef,
            ValidID       => 1,
            CreateTime    => '2011-02-08 15:08:00',
            ChangeTime    => '2011-06-11 17:22:00',
        },
        {
            ID            => 321,
            InternalField => 0,
            Name          => 'fieldname',
            Label         => 'It is not a label',
            FieldType     => 'Text',
            ObjectType    => 'Ticket',
            Config        => $ConfigHashRef,
            ValidID       => 1,
            CreateTime    => '2010-09-11 10:08:00',
            ChangeTime    => '2011-01-01 01:01:01',
        },
        ...
    ];

=cut

sub DynamicFieldListGet {
    my ( $Self, %Param ) = @_;

    # check cache
    my $Valid = 1;
    if ( defined $Param{Valid} && $Param{Valid} eq '0' ) {
        $Valid = 0;
    }

    # set cache key object type component depending on the ObjectType parameter
    my @ObjectTypes;
    my $ObjectTypeCacheKey = 'All';
    if ( IsArrayRefWithData( $Param{ObjectType} ) ) {
        @ObjectTypes        = sort $Param{ObjectType}->@*;
        $ObjectTypeCacheKey = join '_', @ObjectTypes;
    }
    elsif ( IsStringWithData( $Param{ObjectType} ) ) {
        @ObjectTypes        = $Param{ObjectType} eq 'All' ? () : ( $Param{ObjectType} );
        $ObjectTypeCacheKey = $Param{ObjectType};
    }

    # get cache object
    my $CacheObject = $Kernel::OM->Get('Kernel::System::Cache');

    my $CacheKey = join '::', 'DynamicFieldListGet',
        Valid      => $Valid,
        ObjectType => $ObjectTypeCacheKey;
    my $Cache = $CacheObject->Get(
        Type => 'DynamicField',
        Key  => $CacheKey,
    );

    if ($Cache) {

        # check if FieldFilter is not set
        if ( !defined $Param{FieldFilter} ) {

            # return raw data from cache
            return $Cache;
        }
        elsif ( ref $Param{FieldFilter} ne 'HASH' ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => 'FieldFilter must be a HASH reference!',
            );

            return;
        }

        my @FilteredData;

        DYNAMICFIELD:
        for my $DynamicFieldConfig ( $Cache->@* ) {
            next DYNAMICFIELD unless IsHashRefWithData($DynamicFieldConfig);
            next DYNAMICFIELD unless $DynamicFieldConfig->{Name};
            next DYNAMICFIELD unless $Param{FieldFilter}->{ $DynamicFieldConfig->{Name} };

            push @FilteredData, $DynamicFieldConfig;
        }

        # return filtered data from cache
        return \@FilteredData;
    }

    # get database object
    my $DBObject = $Kernel::OM->Get('Kernel::System::DB');

    # assemble SQL
    my ( @WhereClauses, @Binds );
    if ($Valid) {
        my $ValidObject = $Kernel::OM->Get('Kernel::System::Valid');

        push @WhereClauses, sprintf 'valid_id IN (%s)', join ', ', $ValidObject->ValidIDsGet;
    }

    if (@ObjectTypes) {
        my %QueryCondition = $DBObject->QueryInCondition(
            Key      => 'object_type',
            Values   => \@ObjectTypes,
            BindMode => 1,
        );

        push @WhereClauses, $QueryCondition{SQL};
        push @Binds,        $QueryCondition{Values}->@*;
    }

    my $WhereSQL = '';
    if (@WhereClauses) {
        $WhereSQL = 'WHERE ' . join ' AND ', @WhereClauses;
    }

    my $SQL = <<"END_SQL";
SELECT id, name, field_order
  FROM dynamic_field
  $WhereSQL
  ORDER BY field_order, id
END_SQL

    return unless $DBObject->Prepare(
        SQL  => $SQL,
        Bind => \@Binds,
    );

    # Fetch first the list of IDs,
    # as DynamicFieldGet() might use Kernell::System::DB as well
    my @DynamicFieldIDs;
    while ( my ($ID) = $DBObject->FetchrowArray ) {
        push @DynamicFieldIDs, $ID;
    }

    # Fetch the list of hashrefs
    my @Data = map { $Self->DynamicFieldGet( ID => $_ ) } @DynamicFieldIDs;

    # set cache
    $CacheObject->Set(
        Type  => 'DynamicField',
        Key   => $CacheKey,
        Value => \@Data,
        TTL   => $Self->{CacheTTL},
    );

    # check if FieldFilter is not set
    return \@Data unless defined $Param{FieldFilter};

    # check sanity of the field name filter
    if ( ref $Param{FieldFilter} ne 'HASH' ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => 'FieldFilter must be a HASH reference!',
        );

        return;
    }

    # Filter by dynamic field name
    my $FilteredData;
    DYNAMICFIELD:
    for my $DynamicFieldConfig (@Data) {
        next DYNAMICFIELD unless IsHashRefWithData($DynamicFieldConfig);
        next DYNAMICFIELD unless $DynamicFieldConfig->{Name};
        next DYNAMICFIELD unless $Param{FieldFilter}->{ $DynamicFieldConfig->{Name} };

        push @{$FilteredData}, $DynamicFieldConfig;
    }

    # return filtered data from DB
    return $FilteredData;
}

=head2 DynamicFieldOrderReset()

sets the order of all dynamic fields based on a consecutive number list starting with number 1.
This function will remove duplicate order numbers and gaps in the numbering.

    my $Success = $DynamicFieldObject->DynamicFieldOrderReset();

Returns:

    $Success = 1;                        # or 0 in case of error

=cut

sub DynamicFieldOrderReset {
    my ( $Self, %Param ) = @_;

    # get all fields
    my $DynamicFieldList = $Self->DynamicFieldListGet(
        Valid => 0,
    );

    # to set the field order
    my $Counter;

    # loop through all the dynamic fields
    DYNAMICFIELD:
    for my $DynamicField ( @{$DynamicFieldList} ) {

        # prepare the new field order
        $Counter++;

        # skip wrong fields (if any)
        next DYNAMICFIELD if !IsHashRefWithData($DynamicField);

        # skip fields with the correct order
        next DYNAMICFIELD if $DynamicField->{FieldOrder} eq $Counter;

        $DynamicField->{FieldOrder} = $Counter;

        # update the database
        my $Success = $Self->DynamicFieldUpdate(
            %{$DynamicField},
            UserID  => 1,
            Reorder => 0,
        );

        # check if the update was successful
        if ( !$Success ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => 'An error was detected while re ordering the field list on field '
                    . "DynamicField->{Name}!",
            );
            return;
        }
    }

    return 1;
}

=head2 DynamicFieldOrderCheck()

checks for duplicate order numbers and gaps in the numbering.

    my $Success = $DynamicFieldObject->DynamicFieldOrderCheck();

Returns:

    $Success = 1;                       # or 0 in case duplicates or gaps in the dynamic fields
                                        #    order numbering

=cut

sub DynamicFieldOrderCheck {
    my ( $Self, %Param ) = @_;

    # get all fields
    my $DynamicFieldList = $Self->DynamicFieldListGet(
        Valid => 0,
    );

    # to had a correct order reference
    my $Counter;

    # flag to be activated if the order is not correct
    my $OrderError;

    # loop through all the dynamic fields
    DYNAMICFIELD:
    for my $DynamicField ( @{$DynamicFieldList} ) {
        $Counter++;

        # skip wrong fields (if any)
        next DYNAMICFIELD if !IsHashRefWithData($DynamicField);

        # skip fields with correct order
        next DYNAMICFIELD if $DynamicField->{FieldOrder} eq $Counter;

        # when finding a field with wrong order, set OrderError flag and exit loop
        $OrderError = 1;
        last DYNAMICFIELD;
    }

    return if $OrderError;

    return 1;
}

=head2 ObjectMappingGet()

(a) Fetches object ID(s) for given object name(s).
(b) Fetches object name(s) for given object ID(s).

NOTE: Only use object mappings for dynamic fields that must support non-integer object IDs,
like customer user logins and customer company IDs.

    my $ObjectMapping = $DynamicFieldObject->ObjectMappingGet(
        ObjectName            => $ObjectName,    # Name or array ref of names of the object(s) to get the ID(s) for
                                                 # Note: either give ObjectName or ObjectID
        ObjectID              => $ObjectID,      # ID or array ref of IDs of the object(s) to get the name(s) for
                                                 # Note: either give ObjectName or ObjectID
        ObjectType            => 'CustomerUser', # Type of object to get mapping for
    );

Returns for parameter ObjectID:

    $ObjectMapping = {
        ObjectID => ObjectName,
        ObjectID => ObjectName,
        ObjectID => ObjectName,
        # ...
    };

Returns for parameter ObjectName:

    $ObjectMapping = {
        ObjectName => ObjectID,
        ObjectName => ObjectID,
        ObjectName => ObjectID,
        # ...
    };

=cut

sub ObjectMappingGet {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Needed (qw( ObjectType )) {
        if ( !$Param{$Needed} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Needed!"
            );

            return;
        }
    }

    if ( $Param{ObjectName} && $Param{ObjectID} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "Either give parameter ObjectName or ObjectID, not both."
        );

        return;
    }

    if ( !$Param{ObjectName} && !$Param{ObjectID} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "You have to give parameter ObjectName or ObjectID."
        );

        return;
    }

    # Get config object
    my $ConfigObject = $Kernel::OM->Get('Kernel::Config');

    # Get configuration for this object type
    my $Config           = $ConfigObject->Get("DynamicFields::ObjectType") || {};
    my $ObjecTypesConfig = $Config->{ $Param{ObjectType} };

    if ( !IsHashRefWithData($ObjecTypesConfig) ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "Configuration for dynamic field object type $Param{ObjectType} is invalid!",
        );

        return;
    }

    if ( !$ObjecTypesConfig->{UseObjectName} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "Dynamic field object type $Param{ObjectType} does not support this function",
        );

        return;
    }

    my $Type = $Param{ObjectName} ? 'ObjectName' : 'ObjectID';
    if ( !IsArrayRefWithData( $Param{$Type} ) ) {
        $Param{$Type} = [
            $Param{$Type},
        ];
    }
    my %LookupValues = map { $_ => '?' } $Param{$Type}->@*;

    my $CacheKey = 'ObjectMappingGet::'
        . $Type . '::'
        . ( join ',', sort keys %LookupValues ) . '::'
        . $Param{ObjectType};
    my $CacheType = 'DynamicFieldObjectMapping' . $Type;

    # Get cache object.
    my $CacheObject = $Kernel::OM->Get('Kernel::System::Cache');
    my $Cache       = $CacheObject->Get(
        Type => $CacheType,
        Key  => $CacheKey,
    );

    return $Cache if IsHashRefWithData($Cache);

    my $SQL;
    if ( $Type eq 'ObjectID' ) {
        $SQL = '
            SELECT object_id, object_name
            FROM  dynamic_field_obj_id_name
            WHERE object_id IN (' . ( join ', ', values %LookupValues ) . ')
                AND object_type = ?';
    }
    else {
        $SQL = '
            SELECT object_name, object_id
            FROM dynamic_field_obj_id_name
            WHERE object_name IN (' . ( join ', ', values %LookupValues ) . ')
                AND object_type = ?';
    }

    my $DBObject = $Kernel::OM->Get('Kernel::System::DB');

    return unless $DBObject->Prepare(
        SQL  => $SQL,
        Bind => [
            \keys %LookupValues,    # creates a list of references
            \$Param{ObjectType},
        ],
    );

    my %ObjectMapping;
    while ( my ( $Key, $Value ) = $DBObject->FetchrowArray ) {
        $ObjectMapping{$Key} = $Value;
    }

    # set cache
    my $CacheTTL = $ConfigObject->Get('DynamicField::CacheTTL') || 60 * 60 * 12;
    $CacheObject->Set(
        Type  => $CacheType,
        Key   => $CacheKey,
        Value => \%ObjectMapping,
        TTL   => $CacheTTL,
    );

    return \%ObjectMapping;
}

=head2 ObjectMappingCreate()

Creates an object mapping for the given given object name.

NOTE: Only use object mappings for dynamic fields that must support non-integer object IDs,
like customer user logins and customer company IDs.

    my $ObjectID = $DynamicFieldObject->ObjectMappingCreate(
        ObjectName => 'customer-1',   # Name of the object to create the mapping for
        ObjectType => 'CustomerUser', # Type of object to create the mapping for
    );

=cut

sub ObjectMappingCreate {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Needed (qw( ObjectName ObjectType )) {
        if ( !defined $Param{$Needed} || !length $Param{$Needed} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Needed!"
            );
            return;
        }
    }

    # Get configuration for this object type
    my $Config           = $Kernel::OM->Get('Kernel::Config')->Get("DynamicFields::ObjectType") || {};
    my $ObjecTypesConfig = $Config->{ $Param{ObjectType} };

    if ( !IsHashRefWithData($ObjecTypesConfig) ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "Configuration for dynamic field object type $Param{ObjectType} is invalid!",
        );
        return;
    }

    if ( !$ObjecTypesConfig->{UseObjectName} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "Dynamic field object type $Param{ObjectType} does not support this function",
        );
        return;
    }

    my $DBObject = $Kernel::OM->Get('Kernel::System::DB');
    return if !$DBObject->Do(
        SQL => '
            INSERT INTO dynamic_field_obj_id_name
                (object_name, object_type)
            VALUES
                (?, ?)',
        Bind => [
            \$Param{ObjectName},
            \$Param{ObjectType},
        ],
    );

    return if !$DBObject->Prepare(
        SQL => '
            SELECT object_id
            FROM dynamic_field_obj_id_name
            WHERE object_name = ?
                AND object_type = ?',
        Bind => [
            \$Param{ObjectName},
            \$Param{ObjectType},
        ],
        Limit => 1,
    );

    my $ObjectID;
    while ( my @Data = $DBObject->FetchrowArray() ) {
        $ObjectID = $Data[0];
    }

    return $ObjectID;
}

=head2 ObjectMappingNameChange()

Changes name of given object mapping.

NOTE: Only use object mappings for dynamic fields that must support non-integer object IDs,
like customer user logins and customer company IDs.


    my $Success = $DynamicFieldObject->ObjectMappingNameChange(
        OldObjectName => 'customer-1',
        NewObjectName => 'customer-2',
        ObjectType    => 'CustomerUser', # Type of object to change name for
    );

    Returns 1 on success.

=cut

sub ObjectMappingNameChange {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Needed (qw( OldObjectName NewObjectName ObjectType )) {
        if ( !defined $Param{$Needed} || !length $Param{$Needed} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Needed!"
            );
            return;
        }
    }

    # Get configuration for this object type
    my $Config           = $Kernel::OM->Get('Kernel::Config')->Get("DynamicFields::ObjectType") || {};
    my $ObjecTypesConfig = $Config->{ $Param{ObjectType} };

    if ( !IsHashRefWithData($ObjecTypesConfig) ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "Configuration for dynamic field object type $Param{ObjectType} is invalid!",
        );
        return;
    }

    if ( !$ObjecTypesConfig->{UseObjectName} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "Dynamic field object type $Param{ObjectType} does not support this function",
        );
        return;
    }

    my $DBObject = $Kernel::OM->Get('Kernel::System::DB');
    return if !$DBObject->Do(
        SQL => '
            UPDATE dynamic_field_obj_id_name
            SET object_name = ?
            WHERE object_name = ?
                AND object_type = ?',
        Bind => [
            \$Param{NewObjectName},
            \$Param{OldObjectName},
            \$Param{ObjectType},
        ],
    );

    # Clean up cache for type DynamicFieldValueObjectName.
    # A cleanup based on the changed object name is not possible.
    my $CacheObject = $Kernel::OM->Get('Kernel::System::Cache');
    $CacheObject->CleanUp(
        Type => 'DynamicFieldObjectMappingObjectID',
    );
    $CacheObject->CleanUp(
        Type => 'DynamicFieldObjectMappingObjectName',
    );

    return 1;
}

sub DESTROY {
    my $Self = shift;

    # execute all transaction events
    $Self->EventHandlerTransaction();

    return 1;
}

=head2 GetValidDynamicFields()

Returns a list of valid dynamic fields.

    my $DynamicFields = $DynamicFieldObject->GetValidDynamicFields(

        # object  type (optional) as STRING or as ARRAYREF
        # The special object type 'All' places no restriction on the object type when
        # it is passed as a single string.
        ObjectType => 'Ticket',
        ObjectType => ['Ticket', 'Article'],

        # optional, filter by name of the dynamic field
        # only the fields where there the field name has a true value are returned
        FieldFilter => {
            nameforfield => 1,
            fieldname    => 2,
            other        => 0,
            otherfield   => 0,
        },
    );

Returns:

    my $DynamicFields = {
        'Field1' => 'Field 1',
        'Field2' => 'Field2',
    };

=cut

sub GetValidDynamicFields {
    my ( $Self, %Param ) = @_;

    my $ConfigObject = $Kernel::OM->Get('Kernel::Config');

    my $DynamicFieldValid = $ConfigObject->Get('Znuny4OTOBOAdvancedDynamicFields::DynamicFieldValid');

    my $DynamicFieldList = $Self->DynamicFieldListGet(
        %Param,
        ResultType => 'HASH',
        Valid      => $DynamicFieldValid,
    );

    my $DynamicFields = {};

    DYNAMICFIELD:
    for my $DynamicField ( @{$DynamicFieldList} ) {

        next DYNAMICFIELD if !IsHashRefWithData($DynamicField);

        $DynamicFields->{ $DynamicField->{Name} } = $DynamicField->{Label};
    }

    return $DynamicFields;
}

=begin Internal:

=cut

=head2 _DynamicFieldReorder()

re-order the list of fields.

    $Success = $DynamicFieldObject->_DynamicFieldReorder(
        ID         => 123,              # mandatory, the field ID that triggers the re-order
        Mode       => 'Add',            # || Update || Delete
        FieldOrder => 2,                # mandatory, the FieldOrder from the trigger field
    );

    $Success = $DynamicFieldObject->_DynamicFieldReorder(
        ID            => 123,           # mandatory, the field ID that triggers the re-order
        Mode          => 'Update',      # || Update || Delete
        FieldOrder    => 2,             # mandatory, the FieldOrder from the trigger field
        OldFieldOrder => 10,            # mandatory for Mode = 'Update', the FieldOrder before the
                                        # update
    );

=cut

sub _DynamicFieldReorder {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Needed (qw(ID FieldOrder Mode)) {
        if ( !$Param{$Needed} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => 'Need $Needed!'
            );
            return;
        }
    }

    if ( $Param{Mode} eq 'Update' ) {

        # check needed stuff
        if ( !$Param{OldFieldOrder} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => 'Need OldFieldOrder!'
            );
            return;
        }
    }

    # get the Dynamic Field trigger
    my $DynamicFieldTrigger = $Self->DynamicFieldGet(
        ID => $Param{ID},
    );

    # extract the field order from the params
    my $TriggerFieldOrder = $Param{FieldOrder};

    # get all fields
    my $DynamicFieldList = $Self->DynamicFieldListGet(
        Valid => 0,
    );

    # to store the fields that need to be updated
    my @NeedToUpdateList;

    # to add or subtract the field order by 1
    my $Substract;

    # update and add has different algorithms to select the fields to be updated
    # check if update
    if ( $Param{Mode} eq 'Update' ) {
        my $OldFieldOrder = $Param{OldFieldOrder};

        # if the new order and the old order are equal no operation should be performed
        # this is a double check from DynamicFieldUpdate (is case of the function is called
        # from outside)
        return if $TriggerFieldOrder eq $OldFieldOrder;

        # set subtract mode for selected fields
        if ( $TriggerFieldOrder > $OldFieldOrder ) {
            $Substract = 1;
        }

        # identify fields that needs to be updated
        DYNAMICFIELD:
        for my $DynamicField ( @{$DynamicFieldList} ) {

            # skip wrong fields (if any)
            next DYNAMICFIELD if !IsHashRefWithData($DynamicField);

            my $CurrentOrder = $DynamicField->{FieldOrder};

            # skip fields with lower order number
            next DYNAMICFIELD
                if $CurrentOrder < $OldFieldOrder && $CurrentOrder < $TriggerFieldOrder;

            # skip trigger field
            next DYNAMICFIELD
                if ( $CurrentOrder eq $TriggerFieldOrder && $DynamicField->{ID} eq $Param{ID} );

            # skip this and the rest if has greater order number
            last DYNAMICFIELD
                if $CurrentOrder > $OldFieldOrder && $CurrentOrder > $TriggerFieldOrder;

            push @NeedToUpdateList, $DynamicField;
        }
    }

    # check if delete action
    elsif ( $Param{Mode} eq 'Delete' ) {

        $Substract = 1;

        # identify fields that needs to be updated
        DYNAMICFIELD:
        for my $DynamicField ( @{$DynamicFieldList} ) {

            # skip wrong fields (if any)
            next DYNAMICFIELD if !IsHashRefWithData($DynamicField);

            my $CurrentOrder = $DynamicField->{FieldOrder};

            # skip fields with lower order number
            next DYNAMICFIELD
                if $CurrentOrder < $TriggerFieldOrder;

            # skip trigger field
            next DYNAMICFIELD
                if ( $CurrentOrder eq $TriggerFieldOrder && $DynamicField->{ID} eq $Param{ID} );

            push @NeedToUpdateList, $DynamicField;
        }
    }

    # otherwise is add action
    else {

        # identify fields that needs to be updated
        DYNAMICFIELD:
        for my $DynamicField ( @{$DynamicFieldList} ) {

            # skip wrong fields (if any)
            next DYNAMICFIELD if !IsHashRefWithData($DynamicField);

            my $CurrentOrder = $DynamicField->{FieldOrder};

            # skip fields with lower order number
            next DYNAMICFIELD
                if $CurrentOrder < $TriggerFieldOrder;

            # skip trigger field
            next DYNAMICFIELD
                if ( $CurrentOrder eq $TriggerFieldOrder && $DynamicField->{ID} eq $Param{ID} );

            push @NeedToUpdateList, $DynamicField;
        }
    }

    # update the fields order incrementing or decrementing by 1
    for my $DynamicField (@NeedToUpdateList) {

        # hash ref validation is not needed since it was validated before
        # check if need to add or subtract
        if ($Substract) {

            # subtract 1 to the dynamic field order value
            $DynamicField->{FieldOrder}--;
        }
        else {

            # add 1 to the dynamic field order value
            $DynamicField->{FieldOrder}++;
        }

        # update the database
        my $Success = $Self->DynamicFieldUpdate(
            %{$DynamicField},
            UserID  => 1,
            Reorder => 0,
        );

        # check if the update was successful
        if ( !$Success ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => 'An error was detected while re ordering the field list on field '
                    . "$DynamicField->{Name}!",
            );
            return;
        }
    }

    # delete cache
    $Kernel::OM->Get('Kernel::System::Cache')->CleanUp(
        Type => 'DynamicField',
    );

    return 1;
}

=end Internal:

=cut

1;

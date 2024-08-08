# --
# OTOBO is a web-based config iteming system for service organisations.
# --
# Copyright (C) 2001-2020 OTRS AG, https://otrs.com/
# Copyright (C) 2019-2024 Rother OSS GmbH, https://otobo.io/
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

package Kernel::System::ITSMConfigItem::ColumnFilter;

use strict;
use warnings;

use Kernel::System::VariableCheck qw(IsArrayRefWithData IsHashRefWithData IsStringWithData);

our @ObjectDependencies = (
    'Kernel::System::DB',
    'Kernel::System::GeneralCatalog',
    'Kernel::System::Log',
    'Kernel::System::Main',
    'Kernel::System::User',
);

=head1 NAME

Kernel::System::ITSMConfigItem::ColumnFilter - Column Filter library

=head1 DESCRIPTION

All functions for Column Filters.

=head1 PUBLIC INTERFACE

=head2 new()

Don't use the constructor directly, use the ObjectManager instead:

    my $ITSMConfigItemColumnFilterObject = $Kernel::OM->Get('Kernel::System::ITSMConfigItem::ColumnFilter');

=cut

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {};
    bless( $Self, $Type );

    return $Self;
}

=head2 ClassFilterValuesGet()

get a list of all config item classes

    my $Values = $ColumnFilterObject->ClassFilterValuesGet();

    returns

    $Values = {
        22 => 'Computer',
        23 => 'Hardware',
        24 => 'Location',
        25 => 'Network',
        26 => 'Software',
    };

=cut

sub ClassFilterValuesGet {
    my ( $Self, %Param ) = @_;

    return $Kernel::OM->Get('Kernel::System::GeneralCatalog')->ItemList(
        Class => 'ITSM::ConfigItem::Class',
        Valid => 1,
    );
}

=head2 DeplStateFilterValuesGet()

get a list of all deployment states

    my $Values = $ColumnFilterObject->DeplStateFilterValuesGet();

    returns

    $Values = {
        27 => "Expired",
        28 => "Inactive",
        29 => "Maintenance",
        30 => "Pilot",
        31 => "Planned",
        32 => "Production",
        33 => "Repair",
        34 => "Retired",
        35 => "Review",
        36 => "Test/QA",
    };

=cut

sub DeplStateFilterValuesGet {
    my ( $Self, %Param ) = @_;

    return $Kernel::OM->Get('Kernel::System::GeneralCatalog')->ItemList(
        Class => 'ITSM::ConfigItem::DeploymentState',
        Valid => 1,
    );
}

=head2 CurDeplStateFilterValuesGet()

get a list of all current deployment states - wraps for DeplStateFilterValuesGet()

    my $Values = $ColumnFilterObject->CurDeplStateFilterValuesGet();

    returns

    $Values = {
        27 => "Expired",
        28 => "Inactive",
        29 => "Maintenance",
        30 => "Pilot",
        31 => "Planned",
        32 => "Production",
        33 => "Repair",
        34 => "Retired",
        35 => "Review",
        36 => "Test/QA",
    };

=cut

sub CurDeplStateFilterValuesGet {
    my ( $Self, %Param ) = @_;

    return $Self->DeplStateFilterValuesGet(%Param);
}

=head2 InciStateFilterValuesGet()

get a list of all incident states

    my $Values = $ColumnFilterObject->InciStateFilterValuesGet();

    returns

    $Values = {
        1 => "Operational",
        2 => "Warning",
        3 => "Incident"
    };

=cut

sub InciStateFilterValuesGet {
    my ( $Self, %Param ) = @_;

    return $Kernel::OM->Get('Kernel::System::GeneralCatalog')->ItemList(
        Class => 'ITSM::Core::IncidentState',
        Valid => 1,
    );
}

=head2 CurInciStateFilterValuesGet()

get a list of all current incident states - wraps InciStateFilterValuesGet()

    my $Values = $ColumnFilterObject->CurInciStateFilterValuesGet();

    returns

    $Values = {
        1 => "Operational",
        2 => "Warning",
        3 => "Incident"
    };

=cut

sub CurInciStateFilterValuesGet {
    my ( $Self, %Param ) = @_;

    return $Self->InciStateFilterValuesGet(%Param);
}

=head2 DynamicFieldFilterValuesGet()

get a list of a specific config item dynamic field values within the given config items list

    my $Values = $ColumnFilterObject->DynamicFieldFilterValuesGet(
        ITSMConfigItemIDs => [23, 1, 56, 74],    # array ref list of config item IDs
        ValueType => 'Text',             # Text | Integer | Date
        FieldID   => $FieldID,           # ID of the dynamic field
    );

    returns

    $Values = {
        ValueA => 'ValueA',
        ValueB => 'ValueB',
        ValueC => 'ValueC'
    };

=cut

sub DynamicFieldFilterValuesGet {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Needed (qw(ITSMConfigItemIDs ValueType FieldID)) {

        if ( !$Param{$Needed} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Needed!",
            );
            return;
        }
    }

    my $ITSMConfigItemIDString = $Self->_ITSMConfigItemIDStringGet(
        ITSMConfigItemIDs => $Param{ITSMConfigItemIDs},
        ColumnName        => 'object_id',
    );

    if ( !IsArrayRefWithData( $Param{ITSMConfigItemIDs} ) ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => 'ITSMConfigItemIDs must be an array ref!',
        );
        return;
    }

    my $ValueType = 'value_text';
    if ( $Param{ValueType} && $Param{ValueType} eq 'DateTime' ) {
        $ValueType = 'value_date';
    }
    elsif ( $Param{ValueType} && $Param{ValueType} eq 'Integer' ) {
        $ValueType = 'value_int';
    }

    # get database object
    my $DBObject = $Kernel::OM->Get('Kernel::System::DB');

    return if !$DBObject->Prepare(
        SQL =>
            "SELECT DISTINCT($ValueType)"
            . ' FROM dynamic_field_value'
            . ' WHERE field_id = ?'
            . $ITSMConfigItemIDString
            . " ORDER BY $ValueType DESC",
        Bind => [ \$Param{FieldID} ],
    );

    my %Data;
    while ( my @Row = $DBObject->FetchrowArray() ) {

        # check if the value is already stored
        if (
            defined $Row[0]
            && $Row[0] ne ''
            && !$Data{ $Row[0] }
            )
        {

            if ( $ValueType eq 'Date' ) {

                # cleanup time stamps (some databases are using e. g. 2008-02-25 22:03:00.000000
                # and 0000-00-00 00:00:00 time stamps)
                if ( $Row[0] eq '0000-00-00 00:00:00' ) {
                    $Row[0] = undef;
                }
                $Row[0] =~ s/^(\d\d\d\d-\d\d-\d\d\s\d\d:\d\d:\d\d)\..+?$/$1/;
            }

            # store the results
            $Data{ $Row[0] } = $Row[0];
        }
    }

    return \%Data;
}

1;

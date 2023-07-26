# --
# OTOBO is a web-based config iteming system for service organisations.
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

=head2 DeplStateFilterValuesGet()

get a list of all deployment states

    my $Values = $ColumnFilterObject->DeplStateFilterValuesGet();

    returns

    $Values = {
        1 => 'New',
        4 => 'Open',
    };

=cut

sub DeplStateFilterValuesGet {
    my ( $Self, %Param ) = @_;

    my $DeplStates = $Kernel::OM->Get('Kernel::System::GeneralCatalog')->ItemList(
        Class => 'ITSM::ConfigItem::DeploymentState',
        Valid => 1,
    );

    return $DeplStates;
}

=head2 InciStateFilterValuesGet()

get a list of all incident states

    my $Values = $ColumnFilterObject->InciStateFilterValuesGet();

    returns

    $Values = {
        1 => 'New',
        4 => 'Open',
    };

=cut

sub InciStateFilterValuesGet {
    my ( $Self, %Param ) = @_;

    my $InciStates = $Kernel::OM->Get('Kernel::System::GeneralCatalog')->ItemList(
        Class => 'ITSM::Core::IncidentState',
        Valid => 1,
    );

    return $InciStates;
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

=begin Internal:

=head2 _GeneralDataGet()

get data list

    my $Values = $ColumnFilterObject->_GeneralDataGet(
            ModuleName   => 'Kernel::System::Object',
            FunctionName => 'FunctionNameList',
            UserID       => $Param{UserID},
    );

    returns

    $Values = {
        1 => 'ValueA',
        2 => 'ValueB',
        3 => 'ValueC'
    };

=cut

sub _GeneralDataGet {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Needed (qw(ModuleName FunctionName UserID)) {
        if ( !$Param{$Needed} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Needed!",
            );
            return;
        }
    }

    my $FunctionName = $Param{FunctionName};

    # set the backend file
    my $BackendModule = $Param{ModuleName};

    # check if backend field exists
    if ( !$Kernel::OM->Get('Kernel::System::Main')->Require($BackendModule) ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "Can't load backend module $BackendModule!",
        );
        return;
    }

    # create a backend object
    my $BackendObject = $BackendModule->new( %{$Self} );

    if ( !$BackendObject ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "Couldn't create a backend object for $BackendModule!",
        );

        return;
    }

    if ( ref $BackendObject ne $BackendModule ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "Backend object for $BackendModule was not created successfully!",
        );

        return;
    }

    # get data list
    my %DataList = $BackendObject->$FunctionName(
        Valid  => 1,
        UserID => $Param{UserID},
    );

    return \%DataList;
}

=end Internal:

=cut

1;

# --
# OTOBO is a web-based ticketing system for service organisations.
# --
# Copyright (C) 2001-2020 OTRS AG, https://otrs.com/
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

package Kernel::System::ITSMConfigItem::XML::Type::GeneralCatalog;

use strict;
use warnings;

our @ObjectDependencies = (
    'Kernel::System::GeneralCatalog',
    'Kernel::System::Log',
);

=head1 NAME

Kernel::System::ITSMConfigItem::XML::Type::GeneralCatalog - xml backend module

=head1 DESCRIPTION

All xml functions of general catalog objects

=head2 new()

create an object

    use Kernel::System::ObjectManager;
    local $Kernel::OM = Kernel::System::ObjectManager->new();
    my $XMLTypeGeneralCatalogBackendObject = $Kernel::OM->Get('Kernel::System::ITSMConfigItem::XML::Type::GeneralCatalog');

=cut

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {};
    bless( $Self, $Type );

    return $Self;
}

=head2 ValueLookup()

get the xml data of a version

    my $Value = $BackendObject->ValueLookup(
        Item  => $ItemRef,
        Value => 11,        # (optional)
    );

=cut

sub ValueLookup {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    if ( !$Param{Item} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => 'Need Item!',
        );
        return;
    }

    return if !$Param{Value};

    # get item list
    my $ItemList = $Kernel::OM->Get('Kernel::System::GeneralCatalog')->ItemList(
        Class => $Param{Item}->{Input}->{Class} || '',
    );

    return if !$ItemList;
    return if ref $ItemList ne 'HASH';

    my $Value = $ItemList->{ $Param{Value} };

    return $Value;
}

=head2 StatsAttributeCreate()

create a attribute array for the stats framework

    my $Attribute = $BackendObject->StatsAttributeCreate(
        Key  => 'Key::Subkey',
        Name => 'Name',
        Item => $ItemRef,
    );

=cut

sub StatsAttributeCreate {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Argument (qw(Key Name Item)) {
        if ( !$Param{$Argument} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Argument!",
            );
            return;
        }
    }

    # get item list
    my $ItemList = $Kernel::OM->Get('Kernel::System::GeneralCatalog')->ItemList(
        Class => $Param{Item}->{Input}->{Class} || '',
    );

    # create attribute
    my $Attribute = [
        {
            Name             => $Param{Name},
            UseAsXvalue      => 1,
            UseAsValueSeries => 1,
            UseAsRestriction => 1,
            Element          => $Param{Key},
            Block            => 'MultiSelectField',
            Values           => $ItemList || {},
        },
    ];

    return $Attribute;
}

=head2 ExportSearchValuePrepare()

prepare search value for export

    my $ArrayRef = $BackendObject->ExportSearchValuePrepare(
        Value => 11, # (optional)
    );

=cut

sub ExportSearchValuePrepare {
    my ( $Self, %Param ) = @_;

    return unless defined $Param{Value};

    my @Values = grep {$_} split /#####/, $Param{Value};

    return \@Values;
}

=head2 ExportValuePrepare()

prepare value for export

    my $Value = $BackendObject->ExportValuePrepare(
        Value => 11, # (optional)
    );

=cut

sub ExportValuePrepare {
    my ( $Self, %Param ) = @_;

    return if !defined $Param{Value};

    # get item list
    my $ItemList = $Kernel::OM->Get('Kernel::System::GeneralCatalog')->ItemList(
        Class => $Param{Item}->{Input}->{Class} || '',
    );

    return $ItemList->{ $Param{Value} } || $Param{Value};
}

=head2 ImportSearchValuePrepare()

prepare search value for import

    my $ArrayRef = $BackendObject->ImportSearchValuePrepare(
        Value => 11,
    );

=cut

sub ImportSearchValuePrepare {
    my ( $Self, %Param ) = @_;

    return if !defined $Param{Value};

    # get item list
    my $ItemList = $Kernel::OM->Get('Kernel::System::GeneralCatalog')->ItemList(
        Class => $Param{Item}->{Input}->{Class} || '',
    );

    # reverse the list
    my %Name2ID = reverse %{$ItemList};

    my $GeneralCatalogID = $Name2ID{ $Param{Value} };

    if ( !$GeneralCatalogID ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "General catalog lookup of'$Param{Value}' failed!",
        );
        return;
    }

    return $GeneralCatalogID;

}

=head2 ImportValuePrepare()

prepare value for import

    my $Value = $BackendObject->ImportValuePrepare(
        Value => 11,
    );

=cut

sub ImportValuePrepare {
    my ( $Self, %Param ) = @_;

    return if !defined $Param{Value};

    # get item list
    my $ItemList = $Kernel::OM->Get('Kernel::System::GeneralCatalog')->ItemList(
        Class => $Param{Item}->{Input}->{Class} || '',
    );

    # reverse the list
    my %Name2ID = reverse %{$ItemList};

    my $GeneralCatalogID = $Name2ID{ $Param{Value} };

    if ( !$GeneralCatalogID ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "General catalog lookup of'$Param{Value}' failed!",
        );
        return;
    }

    return $GeneralCatalogID;
}

1;

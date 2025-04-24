# --
# OTOBO is a web-based ticketing system for service organisations.
# --
# Copyright (C) 2001-2020 OTRS AG, https://otrs.com/
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

package Kernel::System::DynamicField::Driver::ConfigItemVersion;

use v5.24;
use strict;
use warnings;
use namespace::autoclean;
use utf8;

use parent qw(Kernel::System::DynamicField::Driver::ConfigItem);

# core modules

# CPAN modules

# OTOBO modules

our @ObjectDependencies = (
    'Kernel::Config',
    'Kernel::System::Log',
    'Kernel::System::ITSMConfigItem',
);

=head1 NAME

Kernel::System::DynamicField::Driver::ConfigItemVersion - backend for the Reference dynamic field

=head1 DESCRIPTION

ITSMConfigItemVersion backend for the Reference dynamic field.

=head1 PUBLIC INTERFACE

=head2 new()

it is usually not necessary to explicitly create instances of dynamic field drivers.
Instances of the drivers are created in the constructor of the
dynamic field backend object C<Kernel::System::DynamicField::Backend>.

=cut

sub new {
    my ($Type) = @_;

    # allocate new hash for object
    my $Self = bless {}, $Type;

    # Some reference dynamic fields are stored in the database table attribute dynamic_field_value.value_int.
    $Self->{ValueType}      = 'Integer';
    $Self->{ValueKey}       = 'ValueInt';
    $Self->{TableAttribute} = 'value_int';

    # Used for declaring CSS classes
    $Self->{FieldCSSClass} = 'DynamicFieldReference';

    # set field behaviors
    $Self->{Behaviors} = {
        'IsACLReducible'               => 0,
        'IsNotificationEventCondition' => 0,
        'IsSortable'                   => 1,
        'IsFiltrable'                  => 1,
        'IsStatsCondition'             => 0,
        'IsCustomerInterfaceCapable'   => 1,
        'IsHiddenInTicketInformation'  => 0,
        'IsReferenceField'             => 1,
    };

    $Self->{ReferencedObjectType} = 'ITSMConfigItemVersion';

    return $Self;
}

=head2 ObjectDescriptionGet()

return a hash of object descriptions.

    my %Description = $BackendObject->ObjectDescriptionGet(
        DynamicFieldConfig => $DynamicFieldConfig,
        ObjectID           => 123,
        UserID             => 1,
    );

Return

    %Description = (
        Normal => "CI# 1234455",
        Long   => "CI# 1234455: Need a sample config item title",
    );

=cut

sub ObjectDescriptionGet {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Argument (qw(ObjectID)) {
        if ( !$Param{$Argument} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Argument!",
            );

            return;
        }
    }

    my $ConfigItem = $Kernel::OM->Get('Kernel::System::ITSMConfigItem')->ConfigItemGet(
        VersionID => $Param{ObjectID},
        Silent    => 1,
    );

    if ( !$ConfigItem ) {
        return (
            Normal => "$Param{ObjectID} (deleted)",
            Long   => "$Param{ObjectID} (deleted)",
        );
    }

    # prepare translation of class name if possible
    my $ClassNameStrg = $ConfigItem->{Class};
    if ( $Param{LayoutObject} ) {
        $ClassNameStrg = $Param{LayoutObject}{LanguageObject}->Translate($ClassNameStrg);
    }

    my %Descriptions;
    if ( $Param{DynamicFieldConfig} && $Param{DynamicFieldConfig}{Config}{DisplayType} ) {

        # prepare string as configured
        my $DisplayType = $Param{DynamicFieldConfig}{Config}{DisplayType};
        if ( $DisplayType eq 'ConfigItemNumber' ) {
            $Descriptions{Normal} = "$ConfigItem->{ConfigItemNumber}";
            $Descriptions{Long}   = "$ConfigItem->{ConfigItemNumber}";
        }
        elsif ( $DisplayType eq 'ConfigItemName' ) {
            $Descriptions{Normal} = "$ConfigItem->{Name}";
            $Descriptions{Long}   = "$ConfigItem->{Name}";
        }
        elsif ( $DisplayType eq 'ClassConfigItemNumber' ) {
            $Descriptions{Normal} = "$ClassNameStrg: $ConfigItem->{Number}";
            $Descriptions{Long}   = "$ClassNameStrg: $ConfigItem->{Number}";
        }
        elsif ( $DisplayType eq 'ClassConfigItemName' ) {
            $Descriptions{Normal} = "$ClassNameStrg: $ConfigItem->{Name}";
            $Descriptions{Long}   = "$ClassNameStrg: $ConfigItem->{Name}";
        }
    }
    else {
        $Descriptions{Normal} = "$ConfigItem->{Name}";
        $Descriptions{Long}   = "$ClassNameStrg: $ConfigItem->{Name}";
    }

    my $Link;
    if ( $Param{Link} && $Param{LayoutObject}{SessionSource} ) {
        if ( $Param{LayoutObject}{SessionSource} eq 'AgentInterface' ) {

            # TODO: only show the link if the user $Param{UserID} has permissions
            $Link = $Param{LayoutObject}{Baselink} . "Action=AgentITSMConfigItemZoom;ConfigItemID=$ConfigItem->{ConfigItemID};VersionID=$Param{ObjectID}";
        }
    }

    # create description
    return (
        %Descriptions,
        Link => $Link,
    );
}

=head2 SearchObjects()

This is used in auto completion when searching for possible object IDs.

    my @ObjectIDs = $BackendObject->SearchObjects(
        DynamicFieldConfig => $DynamicFieldConfig,
        ObjectID           => $ObjectID,                # (optional) if given, takes precedence over Term
        Term               => $Term,                    # (optional) defaults to wildcard search with empty string
        MaxResults         => $MaxResults,
        UserID             => 1,
        Object             => {
            %Data,
        },
        ParamObject        => $ParamObject,
    );

=cut

sub SearchObjects {
    my ( $Self, %Param ) = @_;

    $Param{Term} //= '';

    # get a list of config item IDs
    # TODO: this only searches the latest versions
    my @ConfigItemIDs = $Self->SUPER::SearchObjects(
        %Param,
    );

    # actually store latest version ID
    my @VersionIDs;
    my $ConfigItemObject = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');
    for my $ConfigItemID (@ConfigItemIDs) {
        my $ConfigItem = $ConfigItemObject->ConfigItemGet(
            ConfigItemID => $ConfigItemID,
        );

        push @VersionIDs, $ConfigItem->{VersionID};
    }

    return @VersionIDs;
}

=head2 ValueForLens()

this method returns the passed value unchanged. It is only implemented so that
the implementation from the parent class C<Kernel::System::DynamicField::Driver::ITSMConfigItemReference> is not used.

=cut

sub ValueForLens {
    my ( $Self, %Param ) = @_;

    return $Param{Value};
}

1;

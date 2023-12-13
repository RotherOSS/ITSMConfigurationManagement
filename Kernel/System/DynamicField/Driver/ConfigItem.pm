# --
# OTOBO is a web-based ticketing system for service organisations.
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

package Kernel::System::DynamicField::Driver::ConfigItem;

## nofilter(TidyAll::Plugin::OTOBO::Perl::ParamObject)

use v5.24;
use strict;
use warnings;
use namespace::autoclean;
use utf8;

use parent qw(Kernel::System::DynamicField::Driver::BaseReference);

# core modules

# CPAN modules

# OTOBO modules
use Kernel::Language qw(Translatable);
use Kernel::System::VariableCheck qw(IsArrayRefWithData IsHashRefWithData);

our @ObjectDependencies = (
    'Kernel::Config',
    'Kernel::System::DynamicField',
    'Kernel::System::DynamicField::Backend',
    'Kernel::System::Log',
    'Kernel::System::GeneralCatalog',
    'Kernel::System::ITSMConfigItem',
);

=head1 NAME

Kernel::System::DynamicField::Driver::ConfigItem - backend for the Reference dynamic field

=head1 DESCRIPTION

ITSMConfigItem backend for the Reference dynamic field.

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

    $Self->{ReferencedObjectType} = 'ITSMConfigItem';

    return $Self;
}

=head2 ValueGet()

This method contains special support for the case of Lenses. A Lens operates directly on dynamic field of an specific object.
The specific object is usually identified by the value of the Reference dynamic field. But there is at least one special case.
When the reference is to an C<ITSMConfigItem> then the relevant ID is the ID of the last version. This case is handled
when the parameter C<ForLens> is passed.

=cut

sub ValueGet {
    my ( $Self, %Param ) = @_;

    # get the value from the parent class
    my $Value = $Self->SUPER::ValueGet(%Param);

    # special handling only for Lens
    return $Value unless $Param{ForLens};

    # for usage in lenses we might have to interpret the values to be usable for their ValueGet()
    return $Self->ValueForLens( Value => $Value );
}

sub EditFieldValueGet {
    my ( $Self, %Param ) = @_;

    # get the value from the parent class
    my $Value = $Self->SUPER::EditFieldValueGet(%Param);

    # for this field the normal return an the ReturnValueStructure are the same
    return $Value unless $Param{ForLens};

    # for usage in lenses we might have to interpret the values to be usable for their ValueGet()
    return $Self->ValueForLens( Value => $Value );
}

=head2 GetFieldTypeSettings()

Get field type settings that are specific to the referenced object type ITSMConfigItem.

=cut

sub GetFieldTypeSettings {
    my ( $Self, %Param ) = @_;

    my @FieldTypeSettings = $Self->SUPER::GetFieldTypeSettings(
        %Param,
    );

    # add the selection for the config item class
    {
        my $ClassID2Name = $Kernel::OM->Get('Kernel::System::GeneralCatalog')->ItemList(
            Class => 'ITSM::ConfigItem::Class',
        );

        push @FieldTypeSettings,
            {
                ConfigParamName => 'ClassIDs',
                Label           => Translatable('Class restrictions for the config item'),
                Explanation     => Translatable('Select one or more classes to restrict selectable config items'),
                InputType       => 'Selection',
                SelectionData   => $ClassID2Name,
                PossibleNone    => 0,                                                                                # the class is required
                Multiple        => 1,
            };
    }

    # Support reference filters
    push @FieldTypeSettings,
        {
            ConfigParamName => 'ReferenceFilterList',
        };

    return @FieldTypeSettings;
}

=head2 ObjectPermission()

checks read permission for a given object and UserID.

    $Permission = $BackendObject->ObjectPermission(
        Key     => 123,
        UserID  => 1,
    );

=cut

sub ObjectPermission {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Argument (qw(Key UserID)) {
        if ( !$Param{$Argument} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Argument!",
            );

            return;
        }
    }

    return $Kernel::OM->Get('Kernel::System::ITSMConfigItem')->Permission(
        Scope  => 'Item',
        ItemID => $Param{Key},
        UserID => $Param{UserID},
        Type   => 'ro',
    );
}

=head2 ObjectDescriptionGet()

return a hash of object descriptions.

    my %Description = $BackendObject->ObjectDescriptionGet(
        ObjectID => 123,
        UserID   => 1,
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
        ConfigItemID => $Param{ObjectID},
    );

    return unless $ConfigItem;

    my $Link;
    if ( $Param{Link} && $Param{LayoutObject}{SessionSource} ) {
        if ( $Param{LayoutObject}{SessionSource} eq 'AgentInterface' ) {

            # TODO: only show the link if the user $Param{UserID} has permissions
            $Link = $Param{LayoutObject}{Baselink} . "Action=AgentITSMConfigItemZoom;ConfigItemID=$Param{ObjectID}";
        }
    }

    # TODO: provide a dynamicfield->config option with two or three alternatives for the string
    # create description
    return (
        # TODO: take attribute from DF-Config
        Normal => $ConfigItem->{Name},

        # TODO: necessary?
        Long => "$ConfigItem->{Class}: $ConfigItem->{Name}",
        Link => $Link,
    );
}

=head2 SearchObjects()

This is used in auto completion when searching for possible object IDs.

    my @ObjectIDs = $BackendObject->SearchObjects(
        DynamicFieldConfig => $DynamicFieldConfig,
        Term               => $Term,
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

    my $DFDetails = $Param{DynamicFieldConfig}->{Config} // {};

    my %SearchParams;

    # Support restriction by class
    if ( IsArrayRefWithData( $DFDetails->{ClassIDs} ) ) {
        $SearchParams{ClassIDs} = $DFDetails->{ClassIDs};
    }

    if ( $Param{Term} ) {

        # substring search
        $SearchParams{Name} = ["%$Param{Term}%"];
    }

    # incorporate referencefilterlist into search params
    if ( $DFDetails->{ReferenceFilterList} ) {
        FILTERITEM:
        for my $FilterItem ( $DFDetails->{ReferenceFilterList}->@* ) {

            # check filter config
            next FILTERITEM unless $FilterItem->{ReferenceObjectAttribute};
            next FILTERITEM unless ( $FilterItem->{EqualsObjectAttribute} || $FilterItem->{EqualsString} );

            if ( $FilterItem->{EqualsObjectAttribute} ) {

                # don't perform search if object attribute to search for is empty
                my $EqualsObjectAttribute;
                if ( IsHashRefWithData( $Param{Object} ) ) {
                    $EqualsObjectAttribute = $Param{Object}{DynamicField}{ $FilterItem->{EqualsObjectAttribute} } // $Param{Object}{ $FilterItem->{EqualsObjectAttribute} };
                }
                elsif ( defined $Param{ParamObject} ) {
                    if ( $FilterItem->{EqualsObjectAttribute} =~ /^DynamicField_(?<DFName>\S+)/ ) {
                        my $FilterItemDFConfig = $Kernel::OM->Get('Kernel::System::DynamicField')->DynamicFieldGet(
                            Name => $+{DFName},
                        );
                        next FILTERITEM unless IsHashRefWithData($FilterItemDFConfig);
                        $EqualsObjectAttribute = $Kernel::OM->Get('Kernel::System::DynamicField::Backend')->EditFieldValueGet(
                            ParamObject        => $Param{ParamObject},
                            DynamicFieldConfig => $FilterItemDFConfig,
                            TransformDates     => 0,
                        );
                    }
                    else {
                        $EqualsObjectAttribute = $Param{ParamObject}->GetParam( Param => $FilterItem->{EqualsObjectAttribute} );
                    }
                }
                return unless $EqualsObjectAttribute;
                return if ( ref $EqualsObjectAttribute eq 'ARRAY' && !$EqualsObjectAttribute->@* );

                # config item attribute
                if ( $FilterItem->{ReferenceObjectAttribute} =~ m{^Con}i ) {
                    $SearchParams{ $FilterItem->{ReferenceObjectAttribute} } = $EqualsObjectAttribute;
                }

                # dynamic field attribute
                elsif ( $FilterItem->{ReferenceObjectAttribute} =~ m{^Dyn}i ) {
                    $SearchParams{ $FilterItem->{ReferenceObjectAttribute} } = {
                        Equals => $EqualsObjectAttribute,
                    };
                }

                # array attribute
                else {
                    $SearchParams{ $FilterItem->{ReferenceObjectAttribute} } = [$EqualsObjectAttribute];
                }
            }
            elsif ( $FilterItem->{EqualsString} ) {

                # config item attribute
                if ( $FilterItem->{ReferenceObjectAttribute} =~ m{^Con}i ) {
                    $SearchParams{ $FilterItem->{ReferenceObjectAttribute} } = $FilterItem->{EqualsString};
                }

                # dynamic field attribute
                elsif ( $FilterItem->{ReferenceObjectAttribute} =~ m{^Dyn}i ) {
                    $SearchParams{ $FilterItem->{ReferenceObjectAttribute} } = {
                        Equals => $FilterItem->{EqualsString},
                    };
                }

                # array attribute
                else {
                    $SearchParams{ $FilterItem->{ReferenceObjectAttribute} } = [ $FilterItem->{EqualsString} ];
                }
            }
        }
    }

    # return a list of config item IDs
    return $Kernel::OM->Get('Kernel::System::ITSMConfigItem')->ConfigItemSearch(
        Limit  => $Param{MaxResults},
        Result => 'ARRAY',
        %SearchParams,
    );
}

=head2 ValueForLens()

return the current last version ids used in dynamic_field_value.
The passed in value is a list of config item IDs. These IDs are
transformed into the respective last version IDs.

    my $Value = $BackendObject->ValueForLens(
        Value => [17,17,19,20],
    );

=cut

sub ValueForLens {
    my ( $Self, %Param ) = @_;

    return if !$Param{Value};

    if ( ref $Param{Value} ne 'ARRAY' ) {
        $Param{Value} = [ $Param{Value} ];
    }

    my @LastVersionIDs;
    CONFIG_ITEM_ID:
    for my $ConfigItemID ( $Param{Value}->@* ) {
        my $ConfigItem = $Kernel::OM->Get('Kernel::System::ITSMConfigItem')->ConfigItemGet(
            ConfigItemID => $ConfigItemID,
        );

        # only valid IDs
        next CONFIG_ITEM_ID unless $ConfigItem;
        next CONFIG_ITEM_ID unless $ConfigItem->{LastVersionID};

        push @LastVersionIDs, $ConfigItem->{LastVersionID};
    }

    return \@LastVersionIDs;
}

1;

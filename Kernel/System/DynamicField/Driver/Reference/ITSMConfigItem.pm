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

package Kernel::System::DynamicField::Driver::Reference::ITSMConfigItem;

use v5.24;
use strict;
use warnings;
use namespace::autoclean;
use utf8;

use parent qw(Kernel::System::DynamicField::Driver::Reference::Base);

# core modules

# CPAN modules

# OTOBO modules
use Kernel::Language qw(Translatable);
use Kernel::System::VariableCheck qw(IsArrayRefWithData);

our @ObjectDependencies = (
    'Kernel::Config',
    'Kernel::System::Log',
    'Kernel::System::GeneralCatalog',
    'Kernel::System::ITSMConfigItem',
);

=head1 NAME

Kernel::System::DynamicField::Driver::Reference::ITSMConfigItem - plugin module for the Reference dynamic field

=head1 DESCRIPTION

ITSMConfigItem plugin for the Reference dynamic field.

=head1 PUBLIC INTERFACE

=head2 GetFieldTypeSettings()

Get field type settings that are specific to the referenced object type ITSMConfigItem.

=cut

sub GetFieldTypeSettings {
    my ( $Self, %Param ) = @_;

    my @FieldTypeSettings;

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
                Mandatory       => 1,
            };
    }

    return @FieldTypeSettings;
}

=head2 ObjectPermission()

checks read permission for a given object and UserID.

    $Permission = $PluginObject->ObjectPermission(
        Key     => 123,
        UserID  => 1,
    );

=cut

sub ObjectPermission {
    my ( $Self, %Param ) = @_;

    # TODO: Check how (and if at all) permissions should be checked

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

    my %Description = $PluginObject->ObjectDescriptionGet(
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
    for my $Argument (qw(ObjectID UserID)) {
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

    # create description
    return (
        # TODO: take attribute from DF-Config
        Normal => $ConfigItem->{Number},

        # TODO: necessary?
        Long => "$ConfigItem->{Number}: $ConfigItem->{Name}",
    );
}

=head2 SearchObjects()

This is used in auto completion when searching for possible object IDs.

=cut

sub SearchObjects {
    my ( $Self, %Param ) = @_;

    my $DynamicFieldConfig = $Param{DynamicFieldConfig};

    # Support restriction by class
    my %SearchParams;
    my $ConfigObject = $Kernel::OM->Get('Kernel::Config');
    {
        if ( defined $DynamicFieldConfig->{Config}->{ClassIDs} && IsArrayRefWithData( $DynamicFieldConfig->{Config}->{ClassIDs} ) ) {
            $SearchParams{ClassIDs} = $DynamicFieldConfig->{Config}->{ClassIDs};
        }
    }

    if ( $Param{Term} ) {

        # substring search
        $SearchParams{Name} = ["%$Param{Term}%"];
    }

    # incorporate referencefilterlist into search params
    if ( $DynamicFieldConfig->{Config}{ReferenceFilterList} ) {
        for my $FilterItem ( $DynamicFieldConfig->{Config}{ReferenceFilterList}->@* ) {
            if ( $FilterItem->{ReferenceObjectAttribute} ) {

                # TODO Most likely necessary to do some attribute parsing stuff here ( CustomerUser | CustomerUserID etc. )
                if ( $FilterItem->{EqualsObjectAttribute} ) {

                    # config item attribute
                    if ( $FilterItem->{ReferenceObjectAttribute} =~ m{^Con}i ) {
                        $SearchParams{ $FilterItem->{ReferenceObjectAttribute} } = $Param{Object}->{ $FilterItem->{EqualsObjectAttribute} };
                    }

                    # dynamic field attribute
                    elsif ( $FilterItem->{ReferenceObjectAttribute} =~ m{^Dyn}i ) {
                        $SearchParams{ $FilterItem->{ReferenceObjectAttribute} } = {
                            Equals => $Param{Object}->{ $FilterItem->{EqualsObjectAttribute} },
                        };
                    }

                    # array attribute
                    else {
                        $SearchParams{ $FilterItem->{ReferenceObjectAttribute} } = [ $Param{Object}->{ $FilterItem->{EqualsObjectAttribute} } ];
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
    }

    # return a list of config item IDs
    my $ConfigItemObject = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');

    return $ConfigItemObject->ConfigItemSearch(
        Limit  => $Param{MaxResults},
        Result => 'ARRAY',
        %SearchParams,
    );
}

=head2 ValueForLens()

return the current last version ids used in dynamic_field_value

    my $Value = $PluginObject->ValueForLens(
        Value => $Value,
    );

=cut

sub ValueForLens {
    my ( $Self, %Param ) = @_;

    # MultiValue lenses are not supported
    my $Value = ref $Param{Value} ? $Param{Value}[0] : $Param{Value};

    return if !$Value;

    my $ConfigItem = $Kernel::OM->Get('Kernel::System::ITSMConfigItem')->ConfigItemGet(
        ConfigItemID => $Value,
    );

    return $ConfigItem->{LastVersionID};
}

1;

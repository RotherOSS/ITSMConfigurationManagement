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

package Kernel::System::DynamicField::ObjectType::ITSMConfigItem;

use strict;
use warnings;

use Scalar::Util;
use Kernel::System::VariableCheck qw(:all);

our @ObjectDependencies = (
    'Kernel::System::ITSMConfigItem',
    'Kernel::System::Log',
    'Kernel::System::Web::Request',
);

=head1 NAME

Kernel::System::DynamicField::ObjectType::ITSMConfigItem - ITSMConfigItem as an object type

=head1 DESCRIPTION

Attach dynamic fields to an ITSMConfigItem.

=head1 PUBLIC INTERFACE

=head2 new()

Usually, you want to create an instance of this
by using Kernel::System::DynamicField::ObjectType::ITSMChange->new();

=cut

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    return bless {}, $Type;
}

=head2 PreValueSet()

Perform specific functions before the Value set for this object type.

    my $Success = $DynamicFieldITSMChangeHandlerObject->PreValueSet(
        Param              => \%Param,
        ConfigItemHandled  => 1,            # optional, skips this if handled elsewhere
    );

=cut

sub PreValueSet {
    my ( $Self, %Param ) = @_;

    # if we are coming from Version.pm nothing has to be changed
    return 1 if $Param{ConfigItemHandled};

    # all needed params are checked by the backend before
    if ( !$Param{Param} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "Need Param of backend!",
        );

        return;
    }
    
    # make sure to upgrade version of subsequent dynamic field changes if a version was added request
    if ( $Self->{VersionUpgrade} && $Self->{VersionUpgrade}{ $Param{Param}{ObjectID} } ) {
        $Param{Param}{ObjectID} = $Self->{VersionUpgrade}{ $Param{Param}{ObjectID} };

        return 1;
    }

    # check whether the changed field triggers a new configitem version and if so, add a new one
    if ( $Param{Param}{DynamicFieldConfig}{NewVersionTrigger} && $Param{Param}{DynamicFieldConfig}{NewVersionTrigger} eq 1 ) {
        my $ConfigItemObject = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');

        my $NewVersionID = $Kernel::OM->Get('Kernel::System::ITSMConfigItem')->VersionAdd(
            LastVersionID => $Param{Param}{ObjectID},
        );

        if ( !$NewVersionID ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Could not create new version for LastVersionID $Param{Param}{ObjectID}!",
            );

            return;
        }

        $Self->{VersionUpgrade}{ $Param{Param}{ObjectID} } = $NewVersionID;
        $Param{Param}{ObjectID}                            = $NewVersionID;
    }

    return 1;
}

=head2 PostValueSet()

Perform specific functions after the Value set for this object type.

    my $Success = $DynamicFieldITSMChangeHandlerObject->PostValueSet(
        DynamicFieldConfig => $DynamicFieldConfig,      # complete config of the DynamicField
        ObjectID           => $ObjectID,                # ID of the current object that the field
                                                        # must be linked to, e. g. ITSMChangeID
        Value              => $Value,                   # Value to store, depends on backend type
        UserID             => 123,
        ConfigItemHandled  => 1,                        # optional, skips this if handled elsewhere
    );

=cut

sub PostValueSet {
    my ( $Self, %Param ) = @_;

    # if we are coming from Version.pm nothing has to be changed
    return 1 if $Param{ConfigItemHandled};
    
    # all needed params are checked by the backend before

    my $ConfigItemObject          = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');
    my $CacheObject               = $Kernel::OM->Get('Kernel::System::Cache');
    my $DynamicFieldBackendObject = $Kernel::OM->Get('Kernel::System::DynamicField::Backend');

    my $ConfigItemID = $ConfigItemObject->VersionConfigItemIDGet( VersionID => $Param{ObjectID} );

    # delete cache
    $CacheObject->Delete(
        Type => $ConfigItemObject->{CacheType},
        Key  => 'ConfigItemGet::VersionID::' . $Param{ObjectID} . '::1',
    );
    $CacheObject->Delete(
        Type => $ConfigItemObject->{CacheType},
        Key  => 'ConfigItemGet::ConfigItemID::' . $ConfigItemID . '::1',
    );

    # prepare readable values for the history
    my $ReadableValue    = $DynamicFieldBackendObject->ReadableValueRender(
        DynamicFieldConfig => $Param{DynamicFieldConfig},
        Value              => $Param{Value}
    );
    my $ReadableOldValue = $DynamicFieldBackendObject->ReadableValueRender(
        DynamicFieldConfig => $Param{DynamicFieldConfig},
        Value              => $Param{Value},
    );

    # trigger event
    $ConfigItemObject->EventHandler(
        Event => 'ConfigItemDynamicFieldUpdate_' . $Param{DynamicFieldConfig}{Name},
        Data  => {
            FieldName        => $Param{DynamicFieldConfig}{Name},
            Value            => $Param{Value},
            OldValue         => $Param{OldValue},
            ReadableValue    => $ReadableValue,
            ReadableOldValue => $ReadableOldValue,
            ConfigItemID     => $ConfigItemID,
            UserID           => $Param{UserID},
        },
        UserID => $Param{UserID},
    );

    return 1;
}

=head2 ObjectDataGet()

retrieves the data of the current object.

    my %ObjectData = $DynamicFieldITSMChangeHandlerObject->ObjectDataGet(
        DynamicFieldConfig => $DynamicFieldConfig,      # complete config of the DynamicField
        UserID             => 123,
    );

returns:

    %ObjectData = (
        ObjectID => 123,
        Data     => {
            ChangeNumber => '20101027000001',
            Title        => 'some title',
            ChangeID     => 123,
            # ...
        }
    );

=cut

sub ObjectDataGet {
    my ( $Self, %Param ) = @_;

    # Check needed stuff.
    for my $Needed (qw(DynamicFieldConfig UserID)) {
        if ( !$Param{$Needed} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Needed!",
            );
            return;
        }
    }

    # Check DynamicFieldConfig (general).
    if ( !IsHashRefWithData( $Param{DynamicFieldConfig} ) ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "The field configuration is invalid",
        );
        return;
    }

    # Check DynamicFieldConfig (internally).
    for my $Needed (qw(ID FieldType ObjectType)) {
        if ( !$Param{DynamicFieldConfig}->{$Needed} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Needed in DynamicFieldConfig!",
            );
            return;
        }
    }

    my $ConfigItemID = $Kernel::OM->Get('Kernel::System::Web::Request')->GetParam(
        Param => 'ConfigItemID',
    );

    return unless $ConfigItemID;

    my %ConfigItem = $Kernel::OM->Get('Kernel::System::ITSMConfigItem')->ConfigItemGet(
        ConfigItemID => $ConfigItemID,
    );

    return (
        ObjectID => $ConfigItemID,
        Data     => \%ConfigItem,
    );
}

1;

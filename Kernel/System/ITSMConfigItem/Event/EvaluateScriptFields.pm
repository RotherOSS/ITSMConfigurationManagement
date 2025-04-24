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

package Kernel::System::ITSMConfigItem::Event::EvaluateScriptFields;

use strict;
use warnings;

use Kernel::System::VariableCheck qw(:all);

our @ObjectDependencies = (
    'Kernel::System::Cache',
    'Kernel::System::Log',
    'Kernel::System::DynamicField',
    'Kernel::System::DynamicField::Backend',
    'Kernel::System::DynamicField::Driver::BaseScript',
    'Kernel::System::ITSMConfigItem',
);

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {};
    bless( $Self, $Type );

    return $Self;
}

sub Run {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Argument (qw(Data Event)) {
        if ( !$Param{$Argument} ) {

            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Argument!",
            );

            return;
        }
    }

    return if !$Param{Data}{ConfigItemID};

    my $Events = $Kernel::OM->Get('Kernel::System::DynamicField::Driver::BaseScript')->GetUpdateEvents();

    return 1 if !IsHashRefWithData($Events);
    return 1 if !$Events->{ $Param{Event} };

    my $DynamicFieldObject        = $Kernel::OM->Get('Kernel::System::DynamicField');
    my $DynamicFieldBackendObject = $Kernel::OM->Get('Kernel::System::DynamicField::Backend');

    my $ConfigItem = $Kernel::OM->Get('Kernel::System::ITSMConfigItem')->ConfigItemGet(
        ConfigItemID  => $Param{Data}{ConfigItemID},
        DynamicFields => 1,
    );

    for my $FieldID ( $Events->{ $Param{Event} }->@* ) {

        my $DynamicField = $DynamicFieldObject->DynamicFieldGet(
            ID => $FieldID,
        );

        # if we store set values, store as many values as there are in ticket data for the set
        my $Value;
        if ( $DynamicField->{Config}{PartOfSet} ) {
            my @Values;
            my $SetConfig = $DynamicFieldObject->DynamicFieldGet(
                ID => $DynamicField->{Config}{PartOfSet},
            );

            for my $SetValue ( $ConfigItem->{"DynamicField_$SetConfig->{Name}"}->@* ) {
                my %SetValuesMapped = map { ( "DynamicField_$_" => $SetValue->{$_} ) } keys $SetValue->%*;
                push @Values, $DynamicFieldBackendObject->Evaluate(
                    DynamicFieldConfig => $DynamicField,
                    Object             => {
                        $ConfigItem->%*,
                        %SetValuesMapped,
                    },
                );
            }
            $Value = \@Values;
        }
        else {
            $Value = $DynamicFieldBackendObject->Evaluate(
                DynamicFieldConfig => $DynamicField,
                Object             => $ConfigItem,
            );
        }

        $DynamicFieldBackendObject->ValueSet(
            DynamicFieldConfig => $DynamicField,
            ObjectID           => $ConfigItem->{VersionID},
            Value              => $Value,
            Set                => $DynamicField->{Config}{PartOfSet},
            UserID             => 1,
            Store              => 1,
        );
    }

    return 1;
}

1;

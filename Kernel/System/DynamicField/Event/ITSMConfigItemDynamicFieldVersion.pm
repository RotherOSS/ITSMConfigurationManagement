# --
# OTOBO is a web-based ticketing system for service organisations.
# --
# Copyright (C) 2001-2020 OTRS AG, https://otrs.com/
# Copyright (C) 2019-2021 Rother OSS GmbH, https://otobo.de/
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

package Kernel::System::DynamicField::Event::ITSMConfigItemDynamicFieldVersion;

use strict;
use warnings;

use Kernel::System::VariableCheck qw(:all);

our @ObjectDependencies = (
    'Kernel::System::Cache',
    'Kernel::System::DB',
    'Kernel::System::ITSMChange::ITSMCondition',
    'Kernel::System::Log',
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
    for my $Argument (qw(Data Event Config UserID)) {
        if ( !$Param{$Argument} ) {

            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Argument!",
            );

            return;
        }
    }

    return 1 if !$Param{Data}{NewData}{ObjectType} || $Param{Data}{NewData}{ObjectType} ne 'ITSMConfigItem';

    # dynamic field has been added
    if ( $Param{Event} eq 'DynamicFieldAdd' ) {
        $Kernel::OM->Get('Kernel::System::DynamicField')->DynamicFieldAdd(
            $Param{Data}{NewData}->%*,
            ObjectType => 'ITSMConfigItemVersion',
            Name       => $Param{Data}{NewData}{Name} . '-Version',
            Config     => {},
            FieldOrder => $Param{Data}{NewData}{FieldOrder} + 1,
            UserID     => $Param{UserID},
        );
    }

    # dynamic field has been updated
    elsif ( $Param{Event} eq 'DynamicFieldUpdate' ) {
        # TODO - probably only name relevant
    }

    # dynamic field has been deleted
    elsif ( $Param{Event} eq 'DynamicFieldDelete' ) {
        # TODO - maybe not
    }

    return 1;
}

1;

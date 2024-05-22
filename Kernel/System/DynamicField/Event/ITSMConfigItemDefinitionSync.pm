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

package Kernel::System::DynamicField::Event::ITSMConfigItemDefinitionSync;

use strict;
use warnings;

use Kernel::System::VariableCheck qw(:all);

our @ObjectDependencies = (
    'Kernel::System::DB',
    'Kernel::System::GeneralCatalog',
    'Kernel::System::ITSMConfigItem',
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

    return 1 if $Param{Data}{NewData}{ObjectType} ne 'ITSMConfigItem';
    return   if $Param{Event} ne 'DynamicFieldUpdate';

    # TODO: DynamicFieldDelete

    my $ConfigItemObject = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');

    my $ClassList = $Kernel::OM->Get('Kernel::System::GeneralCatalog')->ItemList(
        Class => 'ITSM::ConfigItem::Class',
    );

    my %OutOfSyncDefinitions;

    # Loop over all classes and check whether they include the changed dynamic field
    for my $ClassID ( keys $ClassList->%* ) {
        my $DefinitionRef = $ConfigItemObject->DefinitionGet(
            ClassID => $ClassID,
        );

        # use OldData to account for name changes
        if ( $DefinitionRef->{DynamicFieldRef}{ $Param{Data}{OldData}{Name} } ) {
            push @{ $OutOfSyncDefinitions{$ClassID} }, $Param{Data}{NewData}{ID};
        }
    }

    $ConfigItemObject->DefinitionSetOutOfSync(
        Classes => \%OutOfSyncDefinitions,
    );

    return 1;
}

1;
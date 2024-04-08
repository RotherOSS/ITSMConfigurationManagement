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

package Kernel::System::ITSMConfigItem::VersionString::TemplateToolkitModule;

use strict;
use warnings;

# core modules

# CPAN modules

# OTOBO modules
use Kernel::System::VariableCheck qw(IsHashRefWithData);

our @ObjectDependencies = (
    'Kernel::Config',
    'Kernel::System::ITSMConfigItem',
);

=head1 NAME

Kernel::System::ITSMConfigItem::VersionString::TemplateToolkitModule - Evaluating a Template::Toolkit expression for the version string

=head1 PUBLIC INTERFACE

=head2 new()

create an object. Do not use it directly, instead use:

my $TemplateToolkitModuleObject = $Kernel::OM->Get('Kernel::System::ITSMConfigItem::VersionString::TemplateToolkitModule');

=cut

sub new {
    my ($Type) = @_;

    # allocate new hash for object
    return bless( {}, $Type );
}

sub VersionStringGet {
    my ( $Self, %Param ) = @_;

    my $ModuleConfig = $Kernel::OM->Get('Kernel::Config')->Get('ITSMConfigItem::VersionStringModule::TemplateToolkit');

    return unless IsHashRefWithData($ModuleConfig);

    # evaluate expression defined in sysconfig
    my $VersionString = $Kernel::OM->Create('Kernel::Output::HTML::Layout')->Output(
        Template => $ModuleConfig->{VersionStringExpression},
        Data     => $Param{Version},
    );

    return unless $VersionString;

    # remove newlines and carriage returns to enable matching with edit field value
    $VersionString =~ s/(\n|\r)//g;

    # if previous versions exist, check if string is taken
    # fetch versions
    my $VersionListRef = $Kernel::OM->Get('Kernel::System::ITSMConfigItem')->VersionListAll(
        ConfigItemIDs => [ $Param{Version}{ConfigItemID} ],
    );

    if ( grep { $_->{VersionString} eq $VersionString } values $VersionListRef->{ $Param{Version}{ConfigItemID} }->%* ) {
        return;
    }

    return $VersionString;
}

1;

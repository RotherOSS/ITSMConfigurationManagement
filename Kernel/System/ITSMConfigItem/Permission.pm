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

package Kernel::System::ITSMConfigItem::Permission;

use strict;
use warnings;

use List::Util qw(any none);

our $ObjectManagerDisabled = 1;

=head1 NAME

Kernel::System::ITSMConfigItem::Permission - module for ITSMConfigItem.pm with Permission functions

=head1 DESCRIPTION

All Permission functions.

=head1 PUBLIC INTERFACE

=head2 Permission()

returns whether the user has permissions or not

    my $Access = $ConfigItemObject->Permission(
        Type     => 'ro',
        Scope    => 'Class', # Class || Item
        ClassID  => 123,     # if Scope is 'Class'
        ItemID   => 123,     # if Scope is 'Item'
        UserID   => 123,
    );

or without logging, for example for to check if a link/action should be shown

    my $Access = $ConfigItemObject->Permission(
        Type     => 'ro',
        Scope    => 'Class', # Class || Item
        ClassID  => 123,     # if Scope is 'Class'
        ItemID   => 123,     # if Scope is 'Item'
        LogNo    => 1,
        UserID   => 123,
    );

=cut

sub Permission {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Needed (qw(Type Scope UserID)) {
        if ( !$Param{$Needed} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Needed!",
            );
            return;
        }
    }

    # check for existence of ItemID or ClassID dependent
    # on the Scope
    if (
        ( $Param{Scope} eq 'Class' && !$Param{ClassID} )
        ||
        ( $Param{Scope} eq 'Item' && !$Param{ItemID} )
        )
    {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "Need ClassID if Scope is 'Class' or ItemID if Scope is 'Item'!",
        );

        return;
    }

    # Run all ITSMConfigItem Permission modules.
    #
    # The idea is the the permission modules are ordered and can be divided into two phases.
    # In the first phase 'Required' is on and 'Granted' is off. This assures that all required
    # preconditions are met. In the second phase 'Required' is off and 'Granted' is on. It suffices
    # when only on second phase module grants access.
    #
    # Other combinations are possible but might bring surprising results.
    if (
        ref $Kernel::OM->Get('Kernel::Config')->Get( 'ITSMConfigItem::Permission::' . $Param{Scope} ) eq 'HASH'
        )
    {
        my %Modules = %{
            $Kernel::OM->Get('Kernel::Config')->Get( 'ITSMConfigItem::Permission::' . $Param{Scope} )
        };
        MODULE:
        for my $Module ( sort keys %Modules ) {

            # load module
            next MODULE unless $Kernel::OM->Get('Kernel::System::Main')->Require( $Modules{$Module}->{Module} );

            # create object
            my $ModuleObject = $Modules{$Module}->{Module}->new;

            # execute Run()
            my $AccessOk = $ModuleObject->Run(%Param);

            # check granted option (should I say ok)
            if ( $AccessOk && $Modules{$Module}->{Granted} ) {

                # access ok
                return 1;
            }

            # refuse access  because access is false but it's required
            if ( !$AccessOk && $Modules{$Module}->{Required} ) {
                if ( !$Param{LogNo} ) {
                    $Kernel::OM->Get('Kernel::System::Log')->Log(
                        Priority => 'notice',
                        Message  => "Permission denied because module "
                            . "($Modules{$Module}->{Module}) is required "
                            . "(UserID: $Param{UserID} '$Param{Type}' "
                            . "on $Param{Scope}: " . $Param{ $Param{Scope} . 'ID' } . ")!",
                    );
                }

                # refuse access
                return;
            }
        }
    }

    # don't grant access
    if ( !$Param{LogNo} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'notice',
            Message  => "Permission denied (UserID: $Param{UserID} '$Param{Type}' "
                . "on $Param{Scope}: " . $Param{ $Param{Scope} . 'ID' } . ")!",
        );
    }

    return;
}

=head2 CustomerPermission()

returns whether the user has permissions or not

    my $Access = $ConfigItemObject->CustomerPermission(
        ConfigItemID => 123,
        UserID       => 123,
        LogNo        => 1,    # optional, do not log, default: 0
    );

=cut

sub CustomerPermission {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Needed (qw(ConfigItemID UserID)) {
        if ( !$Param{$Needed} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Needed!",
            );
            return;
        }
    }

    my $CustomerGroupObject = $Kernel::OM->Get('Kernel::System::CustomerGroup');
    my %GroupLookup;

    my %Conditions = %{ $Kernel::OM->Get('Kernel::Config')->Get('Customer::ConfigItem::PermissionConditions') // {} };
    my $ConfigItem = $Self->ConfigItemGet(
        ConfigItemID  => $Param{ConfigItemID},
        DynamicFields => any { $_->{CustomerUserDynamicField} || $_->{CustomerCompanyDynamicField} } values %Conditions,
    );

    CONDITION:
    for my $ConditionSet ( values %Conditions ) {
        if ( $ConditionSet->{Groups} && $ConditionSet->{Groups}->@* ) {
            if ( !%GroupLookup ) {
                %GroupLookup = reverse $CustomerGroupObject->GroupMemberList(
                    UserID => $Param{UserID},
                    Type   => 'ro',
                    Result => 'HASH',
                );
            }

            next CONDITION if none { $GroupLookup{$_} } $ConditionSet->{Groups}->@*;
        }

        if ( $ConditionSet->{Classes} ) {
            my @Classes = ref $ConditionSet->{Classes} ? $ConditionSet->{Classes}->@* : ( $ConditionSet->{Classes} );

            next CONDITION if @Classes && !grep { $_ eq $ConfigItem->{Class} } @Classes;
        }

        if ( $ConditionSet->{DeploymentStates} ) {
            my @DeplStates = ref $ConditionSet->{DeploymentStates} ? $ConditionSet->{DeploymentStates}->@* : ( $ConditionSet->{DeploymentStates} );

            next CONDITION if @DeplStates && !grep { $_ eq $ConfigItem->{DeplState} } @DeplStates;
        }

        if ( $ConditionSet->{DynamicFieldValues} ) {
            for my $FieldName ( keys $ConditionSet->{DynamicFieldValues}->%* ) {
                my $FieldValue = $ConditionSet->{DynamicFieldValues}{$FieldName};
                next CONDITION if $FieldValue && !$ConfigItem->{"DynamicField_$FieldName"} eq $FieldValue;
            }
        }

        if ( $ConditionSet->{CustomerUserDynamicField} ) {
            my $CustomerUserDFArrayRef = [];
            if ( !ref $ConfigItem->{ 'DynamicField_' . $ConditionSet->{CustomerUserDynamicField} } ) {
                $CustomerUserDFArrayRef = [ $ConfigItem->{ 'DynamicField_' . $ConditionSet->{CustomerUserDynamicField} } ];
            }
            else {
                $CustomerUserDFArrayRef = $ConfigItem->{ 'DynamicField_' . $ConditionSet->{CustomerUserDynamicField} };
            }
            next CONDITION if !$ConfigItem->{ 'DynamicField_' . $ConditionSet->{CustomerUserDynamicField} };
            next CONDITION if none { $_ eq $Param{UserID} } $CustomerUserDFArrayRef->@*;
        }

        if ( $ConditionSet->{CustomerCompanyDynamicField} ) {
            next CONDITION if !$ConfigItem->{ 'DynamicField_' . $ConditionSet->{CustomerCompanyDynamicField} };

            my %AccessibleCustomers = $Kernel::OM->Get('Kernel::System::CustomerGroup')->GroupContextCustomers(
                CustomerUserID => $Param{UserID},
            );

            my $CustomerCompanyDFArrayRef = [];
            if ( !ref $ConfigItem->{ 'DynamicField_' . $ConditionSet->{CustomerCompanyDynamicField} } ) {
                $CustomerCompanyDFArrayRef = [ $ConfigItem->{ 'DynamicField_' . $ConditionSet->{CustomerCompanyDynamicField} } ];
            }
            else {
                $CustomerCompanyDFArrayRef = $ConfigItem->{ 'DynamicField_' . $ConditionSet->{CustomerCompanyDynamicField} };
            }

            next CONDITION if none { $AccessibleCustomers{$_} } $CustomerCompanyDFArrayRef->@*;
        }

        # grant access
        return 1;
    }

    if ( !$Param{LogNo} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'notice',
            Message  => "Permission denied (CustomerUserID: $Param{UserID} "
                . "on ConfigItem: " . $Param{ConfigItemID} . ")!",
        );
    }

    # don't grant access
    return;
}

1;

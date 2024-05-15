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

package Kernel::GenericInterface::Operation::ConfigItem::ConfigItemSearch;

use v5.24;
use strict;
use warnings;
use namespace::autoclean;
use utf8;

use parent qw(Kernel::GenericInterface::Operation::ConfigItem::Common);

# core modules

# CPAN modules

# OTOBO modules
use Kernel::System::VariableCheck qw(:all);

our $ObjectManagerDisabled = 1;

=head1 NAME

Kernel::GenericInterface::Operation::ConfigItem::ConfigItemSearch - GenericInterface ConfigItem ConfigItemSearch Operation backend

=head1 PUBLIC INTERFACE

=head2 new()

usually, you want to create an instance of this
by using Kernel::GenericInterface::Operation->new();

=cut

sub new {
    my ( $Type, %Param ) = @_;

    my $Self = {};
    bless( $Self, $Type );

    # check needed objects
    for my $Needed (qw(DebuggerObject WebserviceID)) {
        if ( !$Param{$Needed} ) {
            return {
                Success      => 0,
                ErrorMessage => "Got no $Needed!",
            };
        }

        $Self->{$Needed} = $Param{$Needed};
    }

    # get config for this screen
    $Self->{Config} = $Kernel::OM->Get('Kernel::Config')->Get('GenericInterface::Operation::ConfigItemSearch');

    return $Self;
}

=head2 Run()

perform ConfigItemSearch Operation. This will return a ConfigItem ID list.

    my $Result = $OperationObject->Run(
        UserLogin => 'some agent login',                                # UserLogin or SessionID is
        Password  => 'some password',                                   # if UserLogin is sent then
                                                                        #   Password is required

        # limit the number of found config items (optional, default is 10000)
        Limit => 100,

        # Use ConfigItemSearch as a config item filter on a single config item,
        # or a predefined config item list
        ConfigItemID     => 1234,
        ConfigItemID     => [1234, 1235],

        # config item number (optional) as STRING or as ARRAYREF
        # The value will be treated as a SQL query expression.
        Number => '%123546%',
        Number => ['%123546%', '%123666%'],

        # config item name (optional) as STRING or as ARRAYREF
        # The value will be treated as a SQL query expression.
        # When ConditionInline is set then remaining whitespace will be treated as a && condition and
        # and the settings of ContentSearchPrefix and ContentSearchSuffix will be honored.
        Name => '%SomeText%',
        Name => ['%SomeTest1%', '%SomeTest2%'],

        Classes         => ['Computer', 'Network']   # (optional)
        ClassIDs        => [9, 8, 7, 6],             # (optional)

        DeplStates      => ['Production']            # (optional)
        DeplStateIDs    => [1, 2, 3, 4],             # (optional)

        CurDeplStates   => ['Production']            # (optional)
        CurDeplStateIDs => [1, 2, 3, 4],             # (optional)

        InciStates      => ['Warning']               # (optional)
        InciStateIDs    => [1, 2, 3, 4],             # (optional)

        CurInciStates   => ['Warning']               # (optional)
        CurInciStateIDs => [1, 2, 3, 4],             # (optional)

        CreateBy        => [1, 2, 3],                # (optional)
        ChangeBy        => [3, 2, 1],                # (optional)

        # DynamicFields
        #   At least one operator must be specified. Operators will be connected with AND,
        #       values in an operator with OR.
        #   You can also pass more than one argument to an operator: ['value1', 'value2']
        DynamicField_FieldNameX => {
            Empty             => 1,                       # will return dynamic fields without a value
                                                          #     set to 0 to search fields with a value present.
            Equals            => 123,
            Like              => 'value*',                # "equals" operator with wildcard support
            GreaterThan       => '2001-01-01 01:01:01',
            GreaterThanEquals => '2001-01-01 01:01:01',
            SmallerThan       => '2002-02-02 02:02:02',
            SmallerThanEquals => '2002-02-02 02:02:02',
        },

        # config items created more than 60 minutes ago (config item older than 60 minutes)  (optional)
        ConfigItemCreateTimeOlderMinutes => 60,
        # config items created less than 120 minutes ago (config item newer than 120 minutes) (optional)
        ConfigItemCreateTimeNewerMinutes => 120,

        # config items with create time after ... (config item newer than this date) (optional)
        ConfigItemCreateTimeNewerDate => '2006-01-09 00:00:01',
        # config items with created time before ... (config item older than this date) (optional)
        ConfigItemCreateTimeOlderDate => '2006-01-19 23:59:59',

        # config items changed more than 60 minutes ago (optional)
        ConfigItemLastChangeTimeOlderMinutes => 60,
        # config items changed less than 120 minutes ago (optional)
        ConfigItemLastChangeTimeNewerMinutes => 120,

        # config items with changed time after ... (config item changed newer than this date) (optional)
        ConfigItemLastChangeTimeNewerDate => '2006-01-09 00:00:01',
        # config items with changed time before ... (config item changed older than this date) (optional)
        ConfigItemLastChangeTimeOlderDate => '2006-01-19 23:59:59',

        # OrderBy and SortBy (optional)
        OrderBy => 'Down',   # Down|Up
        SortBy  => 'Number', # ConfigItem|Number|Name|DeplState|InciState
                             # |CurDeplState|CurInciState|Age|Created|Changed

        # OrderBy and SortBy as ARRAY for sub sorting (optional)
        OrderBy => ['Down', 'Up'],
        SortBy  => ['ConfigItem', 'Number'],
        },
    );

    $Result = {
        Success      => 1,                                # 0 or 1
        ErrorMessage => '',                               # In case of an error
        Data         => {                                 # result data payload after Operation
            ConfigItemID => [ 1, 2, 3, 4 ],
        },
    };
    # TODO Update
            Error => {                              # should not return errors
                    ErrorCode    => 'ConfigItemSearch.ErrorCode'
                    ErrorMessage => 'Error Description'
            },

=cut

sub Run {
    my ( $Self, %Param ) = @_;

    my $Result = $Self->Init(
        WebserviceID => $Self->{WebserviceID},
    );

    if ( !$Result->{Success} ) {
        $Self->ReturnError(
            ErrorCode    => 'Webservice.InvalidConfiguration',
            ErrorMessage => $Result->{ErrorMessage},
        );
    }

    # authenticate user
    my ( $UserID, $UserType ) = $Self->Auth(
        %Param,
    );

    return $Self->ReturnError(
        ErrorCode    => 'ConfigItemSearch.AuthFail',
        ErrorMessage => "ConfigItemSearch: Authorization failing!",
    ) if !$UserID;

    # all needed variables
    $Self->{SearchLimit} = $Param{Data}->{Limit}
        || $Self->{Config}->{SearchLimit}
        || 500;
    $Self->{SortBy} = $Param{Data}->{SortBy}
        || $Self->{Config}->{'SortBy::Default'}
        || 'Age';
    $Self->{OrderBy} = $Param{Data}->{OrderBy}
        || $Self->{Config}->{'Order::Default'}
        || 'Down';

    # get parameter from data
    my %GetParam = $Self->_GetParams( %{ $Param{Data} } );

    # get dynamic fields
    my %DynamicFieldSearchParameters = $Self->_GetDynamicFields( %{ $Param{Data} } );

    # perform configitem search
    $UserType = ( $UserType eq 'Customer' ) ? 'CustomerUserID' : 'UserID';
    my @ConfigItemIDs = $Kernel::OM->Get('Kernel::System::ITSMConfigItem')->ConfigItemSearch(
        %GetParam,
        %DynamicFieldSearchParameters,
        Result    => 'ARRAY',
        SortBy    => $Self->{SortBy},
        OrderBy   => $Self->{OrderBy},
        Limit     => $Self->{SearchLimit},
        $UserType => $UserID,
    );
    if (@ConfigItemIDs) {
        return {
            Success => 1,
            Data    => {
                ConfigItemID => \@ConfigItemIDs,
            },
        };
    }

    # return result
    return {
        Success => 1,
        Data    => {},
    };

}

=head1 INTERNAL INTERFACE

=head2 _GetParams()

get search parameters.

    my %GetParam = _GetParams(
        %Params,                          # all configitem parameters
    );

    returns:

    %GetParam = {
        AllowedParams => 'WithContent', # return not empty parameters for search
    }

=cut

sub _GetParams {
    my ( $Self, %Param ) = @_;

    # get single params
    my %GetParam;

    # get array params
    for my $Item (
        qw(ConfigItemID Number Name Classes ClassIDs DeplStates DeplStateIDs
        CurDeplStates CurDeplStateIDs InciStates InciStateIDs CurInciStates
        CurInciStateIDs CreateBy ChangeBy OrderBy SortBy)
        )
    {

        # get search array params
        my @Values;
        if ( IsArrayRefWithData( $Param{$Item} ) ) {
            @Values = @{ $Param{$Item} };
        }
        elsif ( IsStringWithData( $Param{$Item} ) ) {
            @Values = ( $Param{$Item} );
        }
        $GetParam{$Item} = \@Values if scalar @Values;
    }

    my @Prefixes = (
        'ConfigItemCreateTime',
        'ConfigItemLastChangeTime',
    );

    my @Postfixes = (
        'OlderMinutes',
        'NewerMinutes',
        'OlderDate',
        'NewerDate',
    );

    for my $Prefix (@Prefixes) {

        # get search string params (get submitted params)
        if ( IsStringWithData( $Param{$Prefix} ) ) {
            $GetParam{$Prefix} = $Param{$Prefix};

            # remove white space on the start and end
            $GetParam{$Prefix} =~ s/\s+$//g;
            $GetParam{$Prefix} =~ s/^\s+//g;
        }

        for my $Postfix (@Postfixes) {
            my $Item = $Prefix . $Postfix;

            # get search string params (get submitted params)
            if ( IsStringWithData( $Param{$Item} ) ) {
                $GetParam{$Item} = $Param{$Item};

                # remove white space on the start and end
                $GetParam{$Item} =~ s/\s+$//g;
                $GetParam{$Item} =~ s/^\s+//g;
            }
        }
    }

    return %GetParam;

}

=head2 _GetDynamicFields()

get search parameters.

    my %DynamicFieldSearchParameters = _GetDynamicFields(
        %Params,                          # all configitem parameters
    );

    returns:

    %DynamicFieldSearchParameters = {
        'AllAllowedDF' => 'WithData',   # return not empty parameters for search
    }

=cut

sub _GetDynamicFields {
    my ( $Self, %Param ) = @_;

    # dynamic fields search parameters for configitem search
    my %DynamicFieldSearchParameters;

    # get the dynamic fields for configitem object
    $Self->{DynamicField} = $Kernel::OM->Get('Kernel::System::DynamicField')->DynamicFieldListGet(
        Valid      => 1,
        ObjectType => ['ITSMConfigItem'],
    );

    my %DynamicFieldsRaw;
    if ( $Param{DynamicField} ) {
        if ( IsHashRefWithData( $Param{DynamicField} ) ) {
            $DynamicFieldsRaw{ $Param{DynamicField}->{Name} } = $Param{DynamicField};
        }
        elsif ( IsArrayRefWithData( $Param{DynamicField} ) ) {
            %DynamicFieldsRaw = map { $_->{Name} => $_ } @{ $Param{DynamicField} };
        }
        else {
            return %DynamicFieldSearchParameters;
        }

    }
    else {

        # Compatibility with older versions of the web service.
        for my $ParameterName ( sort keys %Param ) {
            if ( $ParameterName =~ m{\A DynamicField_ ( [a-zA-Z\d\-]+ ) \z}xms ) {
                $DynamicFieldsRaw{$1} = $Param{$ParameterName};
            }
        }
    }

    # loop over the dynamic fields configured
    DYNAMICFIELD:
    for my $DynamicFieldConfig ( @{ $Self->{DynamicField} } ) {
        next DYNAMICFIELD if !IsHashRefWithData($DynamicFieldConfig);
        next DYNAMICFIELD if !$DynamicFieldConfig->{Name};

        # skip all fields that does not match with current field name
        next DYNAMICFIELD if !$DynamicFieldsRaw{ $DynamicFieldConfig->{Name} };

        next DYNAMICFIELD if !IsHashRefWithData( $DynamicFieldsRaw{ $DynamicFieldConfig->{Name} } );

        my %SearchOperators = %{ $DynamicFieldsRaw{ $DynamicFieldConfig->{Name} } };

        delete $SearchOperators{Name};

        # set search parameter
        $DynamicFieldSearchParameters{ 'DynamicField_' . $DynamicFieldConfig->{Name} } = \%SearchOperators;
    }

    # allow free fields

    return %DynamicFieldSearchParameters;

}

1;

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

package Kernel::System::ITSMConfigItem::FieldRestrictions;

use v5.24;
use strict;
use warnings;
use namespace::autoclean;
use utf8;

# core modules
use List::Util qw(any);

# CPAN modules

# OTOBO modules
use Kernel::System::VariableCheck qw(:all);

our @ObjectDependencies = (
    'Kernel::Config',
    'Kernel::System::Cache',
    'Kernel::System::DynamicField',
    'Kernel::System::Log',
    'Kernel::System::User',
);

=head1 NAME

Kernel::System::ITSMConfigItem::FieldRestrictions - functions to restrict DynamicField content and field visibility for various forms

=head1 SYNOPSIS

Create FieldRestrictions object
    use Kernel::System::ObjectManager;
    local $Kernel::OM = Kernel::System::ObjectManager->new();
    my $FieldRestrictionsObject = $Kernel::OM->Get('Kernel::System::ITSMConfigItem::FieldRestrictions');

=head1 PUBLIC INTERFACE

=head2 new()

Don't use the constructor directly, use the ObjectManager instead:

    my $FieldRestrictionsObject = $Kernel::OM->Get('Kernel::System::ITSMConfigItem::FieldRestrictions');

=cut

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = bless {}, $Type;

    $Self->{CacheObject} = $Kernel::OM->Get('Kernel::System::Cache');

    return $Self;
}

=head2 GetFieldStates()

Returns possible values, selected values, and visibility of fields

    my $LoopProtection = 100;

    my %States = $FieldRestrictionsObject->GetFieldStates(
        ConfigItemObject          => $ConfigItemObject,
        DynamicFields             => $DynamicFieldConfigs,
        DynamicFieldBackendObject => $DynamicFieldBackendObject,
        ChangedElements           => {},
        Action                    => $Action,
        UserID                    => $UserID,
        ConfigItemID              => $ConfigItemID,
        FormID                    => $Self->{FormID},
        GetParam                  => {
            %GetParam,
        },
        LoopProtection            => \$LoopProtection,              # restricts number of recursive calls; passing a reference to 'undef' will lead to a warning
        Autoselect                => {},                            # optional; default: undef; {Field => 0,1,2, ...}
        ACLPreselection           => 0|1,                           # optional
        InitialRun                => 1,                             # optional; evaluate e.g. script fields without AJAX Trigger once
        PossibleValuesOnly        => 1,                             # optional; assume all fields are visible e.g. for sets
    );

Returns:

    my %States = (
        Fields => [
            {
                Name            => $FieldName,
                Index           => <Index within @{ $DynamicFieldConfigs }>
                PossibleValues  => $PossibleValues,
            }
            ...
        ],
        Visibility => {
            Field1  => 1,
            Field2  => 0,
        },
        NewValues => {
            ...
        },
    );

=cut

sub GetFieldStates {
    my ( $Self, %Param ) = @_;

    # check needed
    for (qw(Action GetParam)) {
        if ( !$Param{$_} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $_!"
            );

            return;
        }
    }

    if ( !$Param{UserID} && !$Param{CustomerUser} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "Need UserID or CustomerUserID!"
        );

        return;
    }

    # decrement on undef result in '-1', so if LoopProtection is undef, function aborts here
    if ( ${ $Param{LoopProtection} }-- < 1 ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "Ran into unresolvable loop!",
        );

        return;
    }

    # get the current visibility
    my $CachedVisibility = $Param{ACLPreselection}
        ? $Self->{CacheObject}->Get(
            Type => 'HiddenFields',
            Key  => $Param{FormID},
        )
        : undef;

    # don't skip any fields initially or if ACLPreselction is disabled
    my $CompleteRun = $CachedVisibility ? 0 : 1;

    # shortcut
    my $DFParam = $Param{GetParam}{DynamicField};

    # TODO: needed, because ConfigItemAcl tampers with the DynamicField reference, if ConfigItemID is given
    for my $Name ( keys $Param{DynamicFields}->%* ) {
        $Param{GetParam}{DynamicField}{ 'DynamicField_' . $Name } //= $Param{GetParam}{DynamicField}{ 'DynamicField_' . $Name };    # all keys have to exist
    }

    # transform dynamic field data into DFName => DFName pair
    my %DynamicFieldAcl = map { $_ => $_ } keys $Param{DynamicFields}->%*;

    my %UserPreferences;
    my %Visibility;
    my $VisCheck = 1;

    # in the special case of assuming visible fields we still want to know whether we do a $CompleteRun
    # but we discard all visibility checks
    if ( $Param{PossibleValuesOnly} ) {
        $VisCheck = 0;

        # treat all fields as always visible
        $CachedVisibility = {
            map { 'DynamicField_' . $_ => 1 } keys $Param{DynamicFields}->%*
        };
    }

    # in the standard case and if we use ACL-Preselection only vis check if necessary
    elsif ( !$CompleteRun ) {
        $VisCheck = 0;

        # check whether form-ACLs are affected by any of the changed elements
        ELEMENT:
        for my $Element ( sort keys %{ $Param{ChangedElements} } ) {

            # autovivification could be avoided
            if ( $Param{ACLPreselection}{Rules}{Form}{$Element} ) {
                $VisCheck = 1;
                last ELEMENT;
            }
            elsif ( !$Param{ACLPreselection}{Fields}{$Element} ) {
                $VisCheck = 1;
                $Kernel::OM->Get('Kernel::System::Log')->Log(
                    Priority => 'debug',
                    Message  => "$Element not defined in ConfigItemACL preselection rules!"
                );
                last ELEMENT;
            }
        }
    }

    if ($VisCheck) {

        # call config item ACLs for DynamicFields to check field visibility
        my $ACLResult = $Param{ConfigItemObject}->ConfigItemAcl(
            %{ $Param{GetParam} },
            ConfigItemID  => $Param{ConfigItemID},
            Action        => $Param{Action},
            UserID        => $Param{UserID},
            ReturnType    => 'Form',
            ReturnSubType => '-',
            Data          => \%DynamicFieldAcl,
        );

        if ($ACLResult) {
            %Visibility = map { 'DynamicField_' . $_ => 0 } keys $Param{DynamicFields}->%*;
            my %AclData = $Param{ConfigItemObject}->ConfigItemAclData();
            for my $Field ( sort keys %AclData ) {
                $Visibility{ 'DynamicField_' . $Field } = 1;
            }
        }
        else {
            %Visibility = map { 'DynamicField_' . $_ => 1 } keys $Param{DynamicFields}->%*;
        }

        # get user preferences for possible user default values
        if ( $Param{UserID} ) {
            %UserPreferences = $Kernel::OM->Get('Kernel::System::User')->GetUserData(
                UserID => $Param{UserID},
            );
        }
    }
    elsif ($CachedVisibility) {
        %Visibility = %{$CachedVisibility};
    }

    my ( %Fields, %NewValues, %Sets );
    DYNAMICFIELD:
    for my $DynamicFieldConfig ( values $Param{DynamicFields}->%* ) {
        next DYNAMICFIELD unless IsHashRefWithData($DynamicFieldConfig);
        next DYNAMICFIELD if !IsHashRefWithData($DynamicFieldConfig);

        my $DFName         = $DynamicFieldConfig->{Name};
        my $IsACLReducible = $Param{DynamicFieldBackendObject}->HasBehavior(
            DynamicFieldConfig => $DynamicFieldConfig,
            Behavior           => 'IsACLReducible',
        );

        # 1. handle hidden fields - values of invisible fields are deleted
        if ( %Visibility && $Visibility{"DynamicField_$DFName"} == 0 ) {

            my $NotEmpty = !defined $DFParam->{"DynamicField_$DFName"} ? 0 :
                ref( $DFParam->{"DynamicField_$DFName"} )
                ?
                ( IsArrayRefWithData( $DFParam->{"DynamicField_$DFName"} ) ? 1 : 0 )
                :
                $DFParam->{"DynamicField_$DFName"} =~ m/^-?$/ ? 0 : 1;

            # if values are present, Fieldrestrictions have to be checked again for the newly changed elements
            if ($NotEmpty) {

                # delete entry and remember change
                $NewValues{"DynamicField_$DFName"} = ref( $DFParam->{"DynamicField_$DFName"} ) ? [] : '';

                # fields have to be added to correctly remove all content
                if ( !$IsACLReducible ) {
                    $Fields{$DFName} = {
                        PossibleValues  => undef,
                        NotACLReducible => 1,
                    };
                }
                else {
                    $Fields{$DFName} = {
                        PossibleValues => {},
                    };
                }
            }

            next DYNAMICFIELD;
        }

        # 2. handle fields which set their dynamic content themselves
        if (
            $Param{DynamicFieldBackendObject}->HasBehavior(
                DynamicFieldConfig => $DynamicFieldConfig,
                Behavior           => 'SetsDynamicContent',
            )
            )
        {
            my %Content = $Param{DynamicFieldBackendObject}->GetFieldState(
                %Param,
                CachedVisibility        => $CachedVisibility,
                DynamicFieldConfig      => $DynamicFieldConfig,
                FieldRestrictionsObject => $Self,
            );

            # check if autoselection is activated and field changed in any way
            if ( $Content{PossibleValues} && $Param{Autoselect} && $Param{Autoselect}{DynamicField}{$DFName} ) {

                my $Selected = exists $Content{NewValue} ? $Content{NewValue} : $DFParam->{"DynamicField_$DFName"};

                my $Autoselected = $Self->Autoselect(
                    Current        => $Selected,
                    PossibleValues => $Content{PossibleValues},
                );

                if ( defined $Autoselected ) {
                    $Content{NewValue} = $Autoselected;
                }
            }

            # set new value if necessary
            if ( exists $Content{NewValue} ) {
                $NewValues{"DynamicField_$DFName"} = $Content{NewValue};
                $DFParam->{"DynamicField_$DFName"} = $Content{NewValue};
            }

            if ( exists $Content{PossibleValues} ) {
                $Fields{$DFName} = {
                    PossibleValues => $Content{PossibleValues},
                };
            }
            elsif ( exists $Content{Set} ) {
                %Sets = (
                    %Sets,
                    $Content{Set}->%*,
                );
            }
            elsif ( exists $Content{NewValue} ) {
                $Fields{$DFName} = {
                    PossibleValues  => undef,
                    NotACLReducible => 1,
                };
            }

            next DYNAMICFIELD;
        }

        next DYNAMICFIELD if $DynamicFieldConfig->{Readonly};

        # 3. skip non ACL reducible fields...
        if ( !$IsACLReducible ) {

            # ...but set default values of reappearing fields first
            if ( $CachedVisibility && $CachedVisibility->{"DynamicField_$DFName"} == 0 ) {
                if ( defined $UserPreferences{"UserDynamicField_$DFName"} ) {
                    $NewValues{"DynamicField_$DFName"} = $UserPreferences{"UserDynamicField_$DFName"};
                    $Fields{$DFName} = {
                        PossibleValues  => undef,
                        NotACLReducible => 1,
                    };
                }
                elsif ( defined $DynamicFieldConfig->{Config}{DefaultValue} ) {
                    $NewValues{"DynamicField_$DFName"} = $DynamicFieldConfig->{Config}{DefaultValue};
                    $Fields{$DFName} = {
                        PossibleValues  => undef,
                        NotACLReducible => 1,
                    };
                }
            }

            next DYNAMICFIELD;
        }

        my $CheckACLs = 1;

        # 4. handle all standard ACL reducible fields
        # evaluate preselection
        if ( !$CompleteRun ) {
            if ( !$Param{ACLPreselection}{Fields}{ 'DynamicField_' . $DFName } ) {

                # no way to tell if there are acls which connect the changed element to the affected field
                $Kernel::OM->Get('Kernel::System::Log')->Log(
                    Priority => 'error',
                    Message  => "DynamicField_$DFName not defined in ConfigItemACL preselection rules!"
                );
            }
            else {
                $CheckACLs = 0;

                # check acls if...
                # ...a field reappears: possible values have to be recalculated;
                if ( $CachedVisibility->{"DynamicField_$DFName"} == 0 ) {
                    $CheckACLs = 1;

                    # take the default value and put it also into NewValues; in the unlikely case that they will be deleted again, this will just cause a redundant second run
                    if ( defined $UserPreferences{"UserDynamicField_$DFName"} ) {
                        $DFParam->{"DynamicField_$DFName"} = $UserPreferences{"UserDynamicField_$DFName"};
                        $NewValues{"DynamicField_$DFName"} = $UserPreferences{"UserDynamicField_$DFName"};
                    }
                    elsif ( defined $DynamicFieldConfig->{Config}{DefaultValue} ) {
                        $DFParam->{"DynamicField_$DFName"} = $DynamicFieldConfig->{Config}{DefaultValue};
                        $NewValues{"DynamicField_$DFName"} = $DynamicFieldConfig->{Config}{DefaultValue};
                    }
                }

                # ...autoselect is turned on for the changed field (refill a field emptied by hand)
                elsif (
                    $Param{Autoselect}
                    && $Param{Autoselect}{DynamicField}{$DFName}
                    && $Param{ChangedElements}{"DynamicField_$DFName"}
                    )
                {
                    $CheckACLs = 1;
                }

                else {
                    ELEMENT:
                    for my $Element ( sort keys %{ $Param{ChangedElements} } ) {

                        # ...the changed element affects the current field
                        if (
                            $Param{ACLPreselection}{Rules}{ConfigItem}{$Element}
                            { 'DynamicField_' . $DFName }
                            )
                        {
                            $CheckACLs = 1;
                            last ELEMENT;
                        }

                        # ...the element is not defined in the cache and thus there is no way to tell if there are acls which connect it to the affected field
                        elsif ( !$Param{ACLPreselection}{Fields}{$Element} ) {
                            $CheckACLs = 1;
                            $Kernel::OM->Get('Kernel::System::Log')->Log(
                                Priority => 'debug',
                                Message  => "$Element not defined in ConfigItemACL preselection rules!"
                            );
                            last ELEMENT;
                        }
                    }
                }
            }
        }

        # if nothing changed, omit this field
        next DYNAMICFIELD unless $CheckACLs;

        # else check ACLs
        my $PossibleValues = $Param{DynamicFieldBackendObject}->PossibleValuesGet(
            DynamicFieldConfig => $DynamicFieldConfig,
        );

        # convert possible values key => value to key => key for ACLs using a Hash slice
        my %AclData = %{$PossibleValues};
        @AclData{ keys %AclData } = keys %AclData;

        # set possible values filter from ACLs
        my $ACL = $Param{ConfigItemObject}->ConfigItemAcl(
            %{ $Param{GetParam} },
            ConfigItemID  => $Param{ConfigItemID},
            Action        => $Param{Action},
            UserID        => $Param{UserID},
            ReturnType    => 'ConfigItem',
            ReturnSubType => 'DynamicField_' . $DFName,
            Data          => \%AclData,
        );
        if ($ACL) {
            my %Filter = $Param{ConfigItemObject}->ConfigItemAclData();

            # convert Filter key => key back to key => value using map
            %{$PossibleValues} = map { $_ => $PossibleValues->{$_} } keys %Filter;
        }

        $Fields{$DFName} = {
            PossibleValues => $PossibleValues,
        };

        # check whether all selected entries are still valid
        if (
            defined $DFParam->{"DynamicField_$DFName"}
            &&
            (
                $DFParam->{"DynamicField_$DFName"}
                || $DFParam->{"DynamicField_$DFName"} eq '0'
            )
            )
        {

            # multiselect and -value fields
            if ( ref( $DFParam->{"DynamicField_$DFName"} ) ) {
                SELECTED:
                for my $Selected ( @{ $DFParam->{"DynamicField_$DFName"} } ) {

                    # skip empty values (possible only for multivalue)
                    next SELECTED if !defined $Selected;

                    # if a selected value is not possible anymore
                    if ( !defined $PossibleValues->{$Selected} ) {
                        if ( $DynamicFieldConfig->{Config}{MultiValue} ) {
                            $NewValues{"DynamicField_$DFName"} = [
                                map { defined $_ && !defined $PossibleValues->{$_} ? undef : $_ } $DFParam->{"DynamicField_$DFName"}->@*
                            ];
                        }
                        else {
                            $NewValues{"DynamicField_$DFName"} = [
                                grep { defined $PossibleValues->{$Selected} } $DFParam->{"DynamicField_$DFName"}->@*
                            ];
                        }

                        last SELECTED;
                    }
                }
            }

            # singleselect fields
            else {
                if ( !defined $PossibleValues->{ $DFParam->{"DynamicField_$DFName"} } ) {
                    $NewValues{"DynamicField_$DFName"} = '';
                }
            }
        }

        # autoselect if applicable
        if ( $Param{Autoselect} && $Param{Autoselect}{DynamicField}{$DFName} ) {

            my $Selected = $NewValues{"DynamicField_$DFName"}
                // $DFParam->{"DynamicField_$DFName"} // '';

            my $Autoselected = $Self->Autoselect(
                Current        => $Selected,
                PossibleValues => $PossibleValues,
            );

            if ( defined $Autoselected ) {
                $NewValues{"DynamicField_$DFName"} = $Autoselected;
            }
        }
    }

    # cache the new visibility
    if ( $Param{ACLPreselection} && $VisCheck ) {
        $Self->{CacheObject}->Set(
            Type  => 'HiddenFields',
            Key   => $Param{FormID},
            Value => {%Visibility},
            TTL   => 60 * 20,          # 20 min
        );
    }

    # if additional elements are changed by the routine, recursively call GetFieldStates, until all dependencies are worked through
    if (%NewValues) {

        my %Recu = $Self->GetFieldStates(
            %Param,
            GetParam => {
                %{ $Param{GetParam} },
                DynamicField => {
                    %{ $Param{GetParam}{DynamicField} },
                    %NewValues,
                },
            },
            ChangedElements => { map { $_ => 1 } keys %NewValues },
        );

        # always take the innermost visibility
        if ( IsHashRefWithData( $Recu{Visibility} ) ) {
            %Visibility = %{ $Recu{Visibility} };
        }

        # combine the field info, inner values take precedence
        if ( IsHashRefWithData( $Recu{Fields} ) ) {
            %Fields = (
                %Fields,
                %{ $Recu{Fields} },
            );
        }

        # combine all changed elements
        if ( IsHashRefWithData( $Recu{NewValues} ) ) {
            %NewValues = (
                %NewValues,
                %{ $Recu{NewValues} },
            );
        }

        # finally take care of set information
        if ( IsHashRefWithData( $Recu{Sets} ) ) {
            %Sets = (
                %Sets,
                %{ $Recu{Sets} },
            );
        }
    }

    return (
        Fields     => \%Fields,
        Visibility => \%Visibility,
        NewValues  => \%NewValues,
        Sets       => \%Sets,
    );
}

=head2 Autoselect()

Autoselects a value if the current selection is empty and only one valid option is present, else undef is returned

    my $Selected = $FieldRestrictionsObject->Autoselect(
        Current        => $Value,   # undef, '', or []
        PossibleValues => {},
    );

=cut

sub Autoselect {
    my ( $Self, %Param ) = @_;

    # return, if already filled ( '0' is valid! )
    if (
        defined $Param{Current}
        && ( ( !ref( $Param{Current} ) && $Param{Current} !~ /^-?$/ ) || IsArrayRefWithData( $Param{Current} ) )
        )
    {
        return undef;    ## no critic qw(Subroutines::ProhibitExplicitReturnUndef)
    }

    # check possible values
    if ( !$Param{PossibleValues} ) {
        return undef;    ## no critic qw(Subroutines::ProhibitExplicitReturnUndef)
    }
    if ( ref( $Param{PossibleValues} ) ne 'HASH' ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "PossibleValues has to be a Hash ref!"
        );
        return undef;    ## no critic qw(Subroutines::ProhibitExplicitReturnUndef)
    }

    my ( $ValidKeys, $UsedKey );
    for my $Key ( sort keys %{ $Param{PossibleValues} } ) {

        # exclude empty values; '-' for backwards compatibility
        if ( $Key !~ /^-?$/ ) {
            if ( ++$ValidKeys > 1 ) {
                return undef;    ## no critic qw(Subroutines::ProhibitExplicitReturnUndef)
            }
            $UsedKey = $Key;
        }
    }
    if ( !$ValidKeys ) {
        return undef;    ## no critic qw(Subroutines::ProhibitExplicitReturnUndef)
    }    # else $ValidKeys == 1 => autoselect

    # fill the field if and add it to the changed elements
    if ( ref( $Param{Current} ) ) {
        return [$UsedKey];
    }
    else {
        return $UsedKey;
    }

}

=head2 SetACLPreselectionCache()

Calculates and stores simple field relations and groups ACLs via their output types to preselect them when used, later on

    my $ACLPreselection = $ConfigItemObject->SetACLPreselectionCache();

=cut

sub SetACLPreselectionCache {
    my ( $Self, %Param ) = @_;

    my $Acls = $Kernel::OM->Get('Kernel::Config')->Get('ConfigItemAcl');

    # standard fields
    my %Fields = (
        DeplState => 'DeplState',
        InciState => 'InciState',
    );

    # dynamic fields
    my $DynamicFieldObject = $Kernel::OM->Get('Kernel::System::DynamicField');
    for my $DynamicFieldName ( values %{ $DynamicFieldObject->DynamicFieldList( ResultType => 'HASH' ) } ) {
        $Fields{"DynamicField_$DynamicFieldName"} = "DynamicField_$DynamicFieldName";
    }

    my %PreselectionRules;

    # parse Acls
    ACL:
    for my $ACL ( values %{$Acls} ) {

        # get controlling elements (ElementChanged later on)
        my %Controller;
        for my $PropertiesHash (qw(Properties PropertiesDatabase)) {
            if ( $ACL->{$PropertiesHash}{ConfigItem} ) {
                NAME:
                for my $Name ( sort keys %{ $ACL->{$PropertiesHash}{ConfigItem} } ) {
                    if ( !$Fields{$Name} ) {
                        $Kernel::OM->Get('Kernel::System::Log')->Log(
                            Priority => 'info',
                            Message  => "Field $Name used in ACLs, is not defined!"
                        );
                        next NAME;
                    }
                    $Controller{$Name} = 1;
                }
            }
            if ( $ACL->{$PropertiesHash}{DynamicField} ) {
                NAME:
                for my $Name ( sort keys %{ $ACL->{$PropertiesHash}{DynamicField} } ) {
                    if ( !$Fields{$Name} ) {
                        $Kernel::OM->Get('Kernel::System::Log')->Log(
                            Priority => 'info',
                            Message  => "Field $Name used in ACLs, is not defined!"
                        );
                        next NAME;
                    }
                    $Controller{$Name} = 1;
                }
            }
            for my $Field (qw/DeplState InciState/) {
                if ( $ACL->{$PropertiesHash}{$Field} ) {
                    $Controller{$Field} = 1;
                }
            }
        }
        if ( !%Controller ) { next ACL }

        # get affected elements
        for my $Impact (qw(Possible PossibleAdd PossibleNot)) {

            # ConfigItem Rules
            if ( $ACL->{$Impact}{ConfigItem} ) {
                AFFECTED:
                for my $Affected ( sort keys %{ $ACL->{$Impact}{ConfigItem} } ) {
                    if ( !$Fields{$Affected} ) {
                        $Kernel::OM->Get('Kernel::System::Log')->Log(
                            Priority => 'info',
                            Message  => "Field $Affected used in ACLs, is not defined!"
                        );
                        next AFFECTED;
                    }
                    for my $ElementChanged ( sort keys %Controller ) {
                        $PreselectionRules{ConfigItem}{ $Fields{$ElementChanged} }{ $Fields{$Affected} } = 1;
                    }
                }
            }

            # Form Rules
            if ( $ACL->{$Impact}->{Form} ) {
                for my $ElementChanged ( sort keys %Controller ) {
                    $PreselectionRules{Form}{ $Fields{$ElementChanged} } = 1;
                }
            }

        }

    }

    my $Return = {
        Fields => { map { $_ => 1 } ( values %Fields ) },
        Rules  => \%PreselectionRules,
    };

    $Self->{CacheObject}->Set(
        Type  => 'ConfigItemACL',       # only [a-zA-Z0-9_] chars usable
        Key   => 'Preselection',
        Value => $Return,
        TTL   => 60 * 60 * 24 * 100,    # seconds, this means 100 days
    );

    return $Return;

}

1;

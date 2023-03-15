# --
# OTOBO is a web-based config iteming system for service organisations.
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

package Kernel::System::ITSMConfigItem::ITSMConfigItemACL;

use strict;
use warnings;

use Kernel::System::VariableCheck qw(:all);

our $ObjectManagerDisabled = 1;

=head1 NAME

Kernel::System::ITSMConfigItem::ITSMConfigItemACL - config item ACL lib

=head1 DESCRIPTION

All config item ACL functions.


=head2 ITSMConfigItemAcl()

Restricts the Data parameter sent to a subset of it, depending on a group of user defied rules
called ACLs. The reduced subset can be access from ITSMConfigItemACLData() if ReturnType parameter is set
to: ITSMConfigItem, or in ITSMConfigItemACLActionData(), if ReturnType Action is used.

Each ACL can contain different restrictions for different objects the ReturnType parameter defines
which object is considered for this restrictions, in the case of the Config Item object a second
parameter called ReturnSubtype is needed, to specify the config item attribute to be restricted, like:
TBD, etc. While for the rest of the objects a "-" value must be set. The ReturnType
and ReturnSubType must be set according to the Data parameter sent.

The rest of the attributes define the matching options for the ACL rules.

Example to restrict config item actions:

    my $Success = $ITSMConfigItemObject->ITSMConfigItemAcl(
        Data => {                            # Values to restrict
            1 => AgentITSMConfigItemEdit,
            # ...
        },

        Action        => ITSMConfigItemEdit',         # Optional
        ConfigItemID  => 123,                         # Optional
        DynamicField  => {                            # Optional
            DynamicField_NameX => 123,
            DynamicField_NameZ => 'some value',
        },

        ReturnType     => 'Action',                   # To match Possible, PossibleAdd or
                                                      #   PossibleNot key in ACL
        ReturnSubType  => '-',                        # To match Possible, PossibleAdd or
                                                      #   PossibleNot sub-key in ACL

        UserID         => 123,                        # UserID => 1 is not affected by this function
    );

or to restrict config item states:

    $Success = $ITSMConfigItemObject->ITSMConfigItemAcl(
        Data => {
            1 => 'new',
            2 => 'open',
            # ...
        },
        ReturnType    => 'ITSMConfigItem',
        ReturnSubType => 'State',
        UserID        => 123,
    );

returns:
    $Success = 1,                                     # if an ACL matches, or false otherwise.

If ACL modules are configured in the C<ITSMConfigItem::Acl::Module> config key, they are invoked
during the call to C<ITSMConfigItemAcl>. The configuration of a module looks like this:

     $ConfigObject->{'ITSMConfigItem::Acl::Module'}->{'TheName'} = {
         Module => 'Kernel::System::ITSMConfigItem::Acl::TheAclModule',
         Checks => ['TBD'],
         ReturnType => 'ITSMConfigItem',
         ReturnSubType => ['TBD'],
     };

Each time the C<ReturnType> and one of the C<ReturnSubType> entries is identical to the same
arguments passed to C<ITSMConfigItemAcl>, the module of the name in C<Module> is loaded, the C<new> method
is called on it, and then the C<Run> method is called.

The C<Checks> array reference in the configuration controls what arguments are passed. to the
C<Run> method.
Valid keys are C<DynamicField>, C<Frontend>, C<Process>, C<State>, C<ITSMConfigItem> and C<Type>.
If any of those are present, the C<Checks> argument passed to C<Run> contains an entry with the same
name, and as a value the associated data.

The C<Run> method can add entries to the C<Acl> param hash, which are then evaluated along with all
other ACL. It should only add entries whose conditionals can be checked with the data specified in
the C<Checks> configuration entry.

The return value of the C<Run> method is ignored.

=cut

sub ITSMConfigItemAcl {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Needed (qw(UserID ReturnSubType ReturnType Data)) {
        if ( !$Param{$Needed} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Needed!"
            );
            return;
        }
    }

    # do not execute ACLs if UserID 1 is used
    return if $Param{UserID} && $Param{UserID} == 1;

    # get config object
    my $ConfigObject = $Kernel::OM->Get('Kernel::Config');

    my $ACLs       = $ConfigObject->Get('ITSMConfigItemAcl');
    my $AclModules = $ConfigObject->Get('ITSMConfigItem::Acl::Module');

    # only execute ACLs if ACL or ACL module is configured
    if ( !$ACLs && !$AclModules ) {
        return;
    }

    # find out which data we actually need
    my %ApplicableAclModules;
    my %RequiredChecks;
    my $CheckAll = 0;

    MODULENAME:
    for my $ModuleName ( sort keys %{ $AclModules // {} } ) {
        my $Module = $AclModules->{$ModuleName};
        if ( $Module->{ReturnType} && $Module->{ReturnType} ne $Param{ReturnType} ) {
            next MODULENAME;
        }
        if ( $Module->{ReturnSubType} ) {
            if ( ref( $Module->{ReturnSubType} ) eq 'HASH' ) {
                next MODULENAME if !grep { $Param{ReturnSubType} eq $_ }
                    @{ $Module->{ReturnSubType} };
            }
            else {

                # a scalar, we hope
                next MODULENAME if !$Module->{ReturnSubType} eq $Param{ReturnSubType};
            }
        }

        # here only modules applicable to this ACL invocation remain
        $ApplicableAclModules{$ModuleName} = $Module;

        if ( $Module->{Checks} && ref( $Module->{Checks} ) eq 'ARRAY' ) {
            $RequiredChecks{$_} = 1 for @{ $Module->{Checks} };
        }
        elsif ( $Module->{Checks} ) {
            $RequiredChecks{ $Module->{Checks} } = 1;
        }
        else {
            $CheckAll = 1;
        }
    }

    return if !%ApplicableAclModules && !$ACLs && !$CheckAll;

    for my $ACL ( values %{ $ACLs // {} } ) {
        for my $Source (qw/ Properties PropertiesDatabase/) {
            for my $Check ( sort keys %{ $ACL->{$Source} } ) {
                my $CleanedUp = $Check;
                $CleanedUp =~ s/(?:ID|Name|Login)$//;
                $CleanedUp =~ s/^(?:Next|New|Old)//;
                $RequiredChecks{$CleanedUp} = 1;
                if ( $Check eq 'ITSMConfigItem' ) {
                    if ( ref( $ACL->{Properties}{$Check} ) eq 'HASH' ) {
                        for my $InnerCheck ( sort keys %{ $ACL->{$Source}{$Check} } ) {
                            $InnerCheck =~ s/(?:ID|Name|Login)$//;
                            $InnerCheck =~ s/^(?:Next|New|Old)//;
                            $RequiredChecks{$InnerCheck} = 1;
                        }
                    }
                }
            }
        }
    }

    # gather all required data to be compared against the ACLs
    my $CheckResult = $Self->_GetChecks(
        %Param,
        CheckAll       => $CheckAll,
        RequiredChecks => \%RequiredChecks,
    );
    my %Checks         = %{ $CheckResult->{Checks}         || {} };
    my %ChecksDatabase = %{ $CheckResult->{ChecksDatabase} || {} };

    # check ACL configuration
    my %Acls;
    if ( $ConfigObject->Get('ITSMConfigItemAcl') ) {
        %Acls = %{ $ConfigObject->Get('ITSMConfigItemAcl') };
    }

    # check ACL module
    MODULE:
    for my $ModuleName ( sort keys %ApplicableAclModules ) {

        my $Module = $ApplicableAclModules{$ModuleName};

        next MODULE if !$Kernel::OM->Get('Kernel::System::Main')->Require( $Module->{Module} );

        my $Generic = $Module->{Module}->new();

        $Generic->Run(
            %Param,
            Acl    => \%Acls,
            Checks => \%Checks,
            Config => $Module,
        );
    }

    # get used data
    my %Data;
    if ( ref $Param{Data} ) {
        %Data = %{ $Param{Data} };
    }

    my %NewData;
    my $UseNewMasterParams = 0;

    if ( $Param{ReturnType} eq 'Action' ) {

        if ( !IsHashRefWithData( $Param{Data} ) ) {

            # use Data if is a string and it is not '-'
            if ( IsStringWithData( $Param{Data} ) && $Param{Data} ne '-' ) {
                %Data = ( 1 => $Param{Data} );
            }

            # otherwise use the param Action
            elsif ( IsStringWithData( $Param{Action} ) ) {
                %Data = ( 1 => $Param{Action} );
            }
        }

        my %NewActionData = %Data;

        # calculate default config item action ACL data
        my @ActionsToDelete;
        my $DefaultActionData = $ConfigObject->Get('ITSMConfigItemACL::Default::Action') || {};

        if ( IsHashRefWithData($DefaultActionData) ) {

            for my $Index ( sort keys %NewActionData ) {

                my $Action = $NewActionData{$Index};
                if ( !$DefaultActionData->{$Index} ) {
                    push @ActionsToDelete, $Action;
                }
            }
        }

        $Self->{DefaultITSMConfigItemAclActionData} = \%NewActionData;

        for my $Action (@ActionsToDelete) {
            delete $Self->{DefaultITSMConfigItemAclActionData}->{$Action};
        }
    }

    # set NewTmpData after Possible Data recalculation on ReturnType Action
    my %NewTmpData = %Data;

    # get the debug parameters
    $Self->{ACLDebug}            = $ConfigObject->Get('ITSMConfigItemACL::Debug::Enabled')     || 0;
    $Self->{ACLDebugLogPriority} = $ConfigObject->Get('ITSMConfigItemACL::Debug::LogPriority') || 'debug';

    my $ACLDebugConfigFilters = $ConfigObject->Get('ITSMConfigItemACL::Debug::Filter') || {};
    for my $FilterName ( sort keys %{$ACLDebugConfigFilters} ) {
        my %Filter = %{ $ACLDebugConfigFilters->{$FilterName} };
        for my $FilterItem ( sort keys %Filter ) {
            $Self->{ACLDebugFilters}->{$FilterItem} = $Filter{$FilterItem};
        }
    }

    # check if debug filters apply (config item)
    if ( $Self->{ACLDebug} ) {

        DEBUGFILTER:
        for my $DebugFilter ( sort keys %{ $Self->{ACLDebugFilters} } ) {
            next DEBUGFILTER if $DebugFilter eq 'ACLName';
            next DEBUGFILTER if !$Self->{ACLDebugFilters}->{$DebugFilter};

            if ( $DebugFilter =~ m{<OTOBO_ITSMCONFIGITEM_([^>]+)>}msx ) {
                my $ITSMConfigItemParam = $1;

                if (
                    defined $ChecksDatabase{ITSMConfigItem}->{$ITSMConfigItemParam}
                    && $ChecksDatabase{ITSMConfigItem}->{$ITSMConfigItemParam}
                    && $Self->{ACLDebugFilters}->{$DebugFilter} ne
                    $ChecksDatabase{ITSMConfigItem}->{$ITSMConfigItemParam}
                    )
                {
                    $Self->{ACLDebug} = 0;
                    last DEBUGFILTER;
                }
            }
        }
    }

    # remember last ACLDebug state (before ACLs loop)
    $Self->{ACLDebugRecovery} = $Self->{ACLDebug};

    ACLRULES:
    for my $Acl ( sort keys %Acls ) {

        # check if debug filters apply (ACL) (only if ACLDebug is active)
        if (
            $Self->{ACLDebugRecovery}
            && defined $Self->{ACLDebugFilters}->{'ACLName'}
            && $Self->{ACLDebugFilters}->{'ACLName'}
            )
        {
            # if not match current ACL disable ACLDebug
            if ( $Self->{ACLDebugFilters}->{'ACLName'} ne $Acl ) {
                $Self->{ACLDebug} = 0;
            }

            # reenable otherwise (we are sure it was enabled before)
            else {
                $Self->{ACLDebug} = 1;
            }
        }

        my %Step = %{ $Acls{$Acl} };

        # check force match
        my $ForceMatch;
        if (
            !IsHashRefWithData( $Step{Properties} )
            && !IsHashRefWithData( $Step{PropertiesDatabase} )
            )
        {
            $ForceMatch = 1;
        }

        my $PropertiesMatch;
        my $PropertiesMatchTry;
        my $PropertiesDatabaseMatch;
        my $PropertiesDatabaseMatchTry;
        my $UseNewParams = 0;

        for my $PropertiesHash (qw(Properties PropertiesDatabase)) {

            my %UsedChecks = %Checks;
            if ( $PropertiesHash eq 'PropertiesDatabase' ) {
                %UsedChecks = %ChecksDatabase;
            }

            # set match params
            my $Match    = 1;
            my $MatchTry = 0;
            for my $Key ( sort keys %{ $Step{$PropertiesHash} } ) {
                for my $Data ( sort keys %{ $Step{$PropertiesHash}->{$Key} } ) {
                    my $MatchProperty = 0;
                    for my $Item ( @{ $Step{$PropertiesHash}->{$Key}->{$Data} } ) {
                        if ( ref $UsedChecks{$Key}->{$Data} eq 'ARRAY' ) {
                            my $MatchItem = 0;
                            if ( substr( $Item, 0, length '[Not' ) eq '[Not' ) {
                                $MatchItem = 1;
                            }
                            my $MatchedArrayDataItem;
                            ARRAYDATAITEM:
                            for my $ArrayDataItem ( @{ $UsedChecks{$Key}->{$Data} } ) {
                                $MatchedArrayDataItem = $ArrayDataItem;
                                my $LoopMatchResult = $Self->_CompareMatchWithData(
                                    Match      => $Item,
                                    Data       => $ArrayDataItem,
                                    SingleItem => 0,
                                );
                                if ( !$LoopMatchResult->{Skip} )
                                {
                                    $MatchItem = $LoopMatchResult->{Match};
                                    last ARRAYDATAITEM;
                                }
                            }
                            if ($MatchItem) {
                                $MatchProperty = 1;

                                # debug log
                                if ( $Self->{ACLDebug} ) {
                                    $Kernel::OM->Get('Kernel::System::Log')->Log(
                                        Priority => $Self->{ACLDebugLogPriority},
                                        Message  =>
                                            "ITSMConfigItemACL '$Acl' $PropertiesHash:'$Key->$Data' MatchedARRAY ($Item eq $MatchedArrayDataItem)",
                                    );
                                }
                            }
                        }
                        elsif ( defined $UsedChecks{$Key}->{$Data} ) {

                            my $DataItem    = $UsedChecks{$Key}->{$Data};
                            my $MatchResult = $Self->_CompareMatchWithData(
                                Match      => $Item,
                                Data       => $DataItem,
                                SingleItem => 1
                            );

                            if ( $MatchResult->{Match} ) {
                                $MatchProperty = 1;

                                # debug
                                if ( $Self->{ACLDebug} ) {
                                    $Kernel::OM->Get('Kernel::System::Log')->Log(
                                        Priority => $Self->{ACLDebugLogPriority},
                                        Message  =>
                                            "ITSMConfigItemACL '$Acl' $PropertiesHash:'$Key->$Data' Matched ($Item eq $UsedChecks{$Key}->{$Data})",
                                    );
                                }
                            }
                        }
                    }
                    if ( !$MatchProperty ) {
                        $Match = 0;
                    }
                    $MatchTry = 1;
                }
            }

            # check force option
            if ($ForceMatch) {
                $Match    = 1;
                $MatchTry = 1;
            }

            if ( $PropertiesHash eq 'Properties' ) {
                $PropertiesMatch    = $Match;
                $PropertiesMatchTry = $MatchTry;
            }
            else {
                $PropertiesDatabaseMatch    = $Match;
                $PropertiesDatabaseMatchTry = $MatchTry;
            }

            # check if properties is missing
            if ( !IsHashRefWithData( $Step{Properties} ) ) {
                $PropertiesMatch    = $PropertiesDatabaseMatch;
                $PropertiesMatchTry = $PropertiesDatabaseMatchTry;
            }

            # check if properties database is missing
            if ( !IsHashRefWithData( $Step{PropertiesDatabase} ) ) {
                $PropertiesDatabaseMatch    = $PropertiesMatch;
                $PropertiesDatabaseMatchTry = $PropertiesMatchTry;
            }
        }

        # the following logic should be applied to calculate if an ACL matches:
        # if both Properties and PropertiesDatabase match => match
        # if Properties matches, and PropertiesDatabase does not match => no match
        # if PropertiesDatabase matches, but Properties does not match => no match
        # if PropertiesDatabase matches, and Properties is missing => match
        # if Properties matches, and PropertiesDatabase is missing => match.
        my $Match;
        if ( $PropertiesMatch && $PropertiesDatabaseMatch ) {
            $Match = 1;
        }

        my $MatchTry;
        if ( $PropertiesMatchTry && $PropertiesDatabaseMatchTry ) {
            $MatchTry = 1;
        }

        # debug log
        if ( $Match && $MatchTry ) {
            if ( $Self->{ACLDebug} ) {
                $Kernel::OM->Get('Kernel::System::Log')->Log(
                    Priority => $Self->{ACLDebugLogPriority},
                    Message  =>
                        "ITSMConfigItemACL '$Acl' Matched for return data:'$Param{ReturnType}:$Param{ReturnSubType}'",
                );
            }
        }

        my %SpecialReturnTypes = (
            Action         => 1,
            Process        => 1,
            ActivityDialog => 1,
            Form           => 1,
            FormStd        => 1,
        );

        if ( $SpecialReturnTypes{ $Param{ReturnType} } ) {

            # build new Special ReturnType data hash (ProcessManagement)
            # for Special ReturnType Step{Possible}
            if (
                ( %Checks || %ChecksDatabase )
                && $Match
                && $MatchTry
                && $Step{Possible}->{ $Param{ReturnType} }
                && IsArrayRefWithData( $Step{Possible}->{ $Param{ReturnType} } )
                )
            {
                $UseNewParams = 1;

                # reset return data as it will be filled with just the Possible Items excluded the
                #    ones that are not in the possible section, this is the same as remove all
                #    missing items from the original data
                %NewTmpData = ();

                # debug log
                if ( $Self->{ACLDebug} ) {
                    $Kernel::OM->Get('Kernel::System::Log')->Log(
                        Priority => $Self->{ACLDebugLogPriority},
                        Message  =>
                            "ITSMConfigItemACL '$Acl' Used with Possible:'$Param{ReturnType}:$Param{ReturnSubType}'",
                    );
                    $Kernel::OM->Get('Kernel::System::Log')->Log(
                        Priority => $Self->{ACLDebugLogPriority},
                        Message  =>
                            "ITSMConfigItemACL '$Acl' Reset return data:'$Param{ReturnType}:$Param{ReturnSubType}''",
                    );
                }

                # possible list
                for my $ID ( sort keys %Data ) {

                    for my $New ( @{ $Step{Possible}->{ $Param{ReturnType} } } ) {
                        my $MatchResult = $Self->_CompareMatchWithData(
                            Match      => $New,
                            Data       => $Data{$ID},
                            SingleItem => 1
                        );
                        if ( $MatchResult->{Match} ) {
                            $NewTmpData{$ID} = $Data{$ID};
                            if ( $Self->{ACLDebug} ) {
                                $Kernel::OM->Get('Kernel::System::Log')->Log(
                                    Priority => $Self->{ACLDebugLogPriority},
                                    Message  =>
                                        "ITSMConfigItemACL '$Acl' Possible param '$Data{$ID}' added to return data:'$Param{ReturnType}:$Param{ReturnSubType}'",
                                );
                            }
                        }
                        else {
                            if ( $Self->{ACLDebug} ) {
                                $Kernel::OM->Get('Kernel::System::Log')->Log(
                                    Priority => $Self->{ACLDebugLogPriority},
                                    Message  =>
                                        "ITSMConfigItemACL '$Acl' Possible param '$Data{$ID}' skipped from return data:'$Param{ReturnType}:$Param{ReturnSubType}'",
                                );
                            }
                        }
                    }
                }
            }

            # for Special ReturnType Step{PossibleAdd}
            if (
                ( %Checks || %ChecksDatabase )
                && $Match
                && $MatchTry
                && $Step{PossibleAdd}->{ $Param{ReturnType} }
                && IsArrayRefWithData( $Step{PossibleAdd}->{ $Param{ReturnType} } )
                )
            {

                $UseNewParams = 1;

                # debug log
                if ( $Self->{ACLDebug} ) {
                    $Kernel::OM->Get('Kernel::System::Log')->Log(
                        Priority => $Self->{ACLDebugLogPriority},
                        Message  =>
                            "ITSMConfigItemACL '$Acl' Used with PossibleAdd:'$Param{ReturnType}:$Param{ReturnSubType}'",
                    );
                }

                # possible add list
                for my $ID ( sort keys %Data ) {

                    for my $New ( @{ $Step{PossibleAdd}->{ $Param{ReturnType} } } ) {
                        my $MatchResult = $Self->_CompareMatchWithData(
                            Match      => $New,
                            Data       => $Data{$ID},
                            SingleItem => 1
                        );
                        if ( $MatchResult->{Match} ) {
                            $NewTmpData{$ID} = $Data{$ID};
                            if ( $Self->{ACLDebug} ) {
                                $Kernel::OM->Get('Kernel::System::Log')->Log(
                                    Priority => $Self->{ACLDebugLogPriority},
                                    Message  =>
                                        "ITSMConfigItemACL '$Acl' PossibleAdd param '$Data{$ID}' added to return data:'$Param{ReturnType}:$Param{ReturnSubType}'",
                                );
                            }
                        }
                        else {
                            if ( $Self->{ACLDebug} ) {
                                $Kernel::OM->Get('Kernel::System::Log')->Log(
                                    Priority => $Self->{ACLDebugLogPriority},
                                    Message  =>
                                        "ITSMConfigItemACL '$Acl' PossibleAdd param '$Data{$ID}' skipped from return data:'$Param{ReturnType}:$Param{ReturnSubType}'",
                                );
                            }
                        }
                    }
                }
            }

            # for Special Step{PossibleNot}
            if (
                ( %Checks || %ChecksDatabase )
                && $Match
                && $MatchTry
                && $Step{PossibleNot}->{ $Param{ReturnType} }
                && IsArrayRefWithData( $Step{PossibleNot}->{ $Param{ReturnType} } )
                )
            {

                $UseNewParams = 1;

                # debug log
                if ( $Self->{ACLDebug} ) {
                    $Kernel::OM->Get('Kernel::System::Log')->Log(
                        Priority => $Self->{ACLDebugLogPriority},
                        Message  =>
                            "ITSMConfigItemACL '$Acl' Used with PossibleNot:'$Param{ReturnType}:$Param{ReturnSubType}'",
                    );
                }

                # not possible list
                for my $ID ( sort keys %Data ) {
                    my $Match = 1;
                    for my $New ( @{ $Step{PossibleNot}->{ $Param{ReturnType} } } ) {
                        my $LoopMatchResult = $Self->_CompareMatchWithData(
                            Match      => $New,
                            Data       => $Data{$ID},
                            SingleItem => 1
                        );
                        if ( $LoopMatchResult->{Match} ) {
                            $Match = 0;
                        }
                    }
                    if ( !$Match ) {
                        if ( $Self->{ACLDebug} ) {
                            $Kernel::OM->Get('Kernel::System::Log')->Log(
                                Priority => $Self->{ACLDebugLogPriority},
                                Message  =>
                                    "ITSMConfigItemACL '$Acl' PossibleNot param '$Data{$ID}' removed from return data:'$Param{ReturnType}:$Param{ReturnSubType}'",
                            );
                        }
                        if ( $NewTmpData{$ID} ) {
                            delete $NewTmpData{$ID};
                        }
                    }
                    else {
                        if ( $Self->{ACLDebug} ) {
                            $Kernel::OM->Get('Kernel::System::Log')->Log(
                                Priority => $Self->{ACLDebugLogPriority},
                                Message  =>
                                    "ITSMConfigItemACL '$Acl' PossibleNot param '$Data{$ID}' leaved for return data:'$Param{ReturnType}:$Param{ReturnSubType}'",
                            );
                        }
                    }
                }
            }
        }

        elsif ( $Param{ReturnType} eq 'ITSMConfigItem' ) {

            # build new config item data hash
            # Step ITSMConfigItem Possible (Resets White list)
            if (
                ( %Checks || %ChecksDatabase )
                && $Match
                && $MatchTry
                && $Step{Possible}->{ITSMConfigItem}->{ $Param{ReturnSubType} }
                )
            {
                $UseNewParams = 1;

                # reset return data as it will be filled with just the Possible Items excluded the ones
                # that are not in the possible section, this is the same as remove all missing items from
                # the original data
                %NewTmpData = ();

                # debug log
                if ( $Self->{ACLDebug} ) {
                    $Kernel::OM->Get('Kernel::System::Log')->Log(
                        Priority => $Self->{ACLDebugLogPriority},
                        Message  =>
                            "ITSMConfigItemACL '$Acl' Used with Possible:'$Param{ReturnType}:$Param{ReturnSubType}'",
                    );
                    $Kernel::OM->Get('Kernel::System::Log')->Log(
                        Priority => $Self->{ACLDebugLogPriority},
                        Message  =>
                            "ITSMConfigItemACL '$Acl' Reset return data:'$Param{ReturnType}:$Param{ReturnSubType}''",
                    );
                }

                # possible list
                for my $ID ( sort keys %Data ) {

                    for my $New ( @{ $Step{Possible}->{ITSMConfigItem}->{ $Param{ReturnSubType} } } ) {
                        my $MatchResult = $Self->_CompareMatchWithData(
                            Match      => $New,
                            Data       => $Data{$ID},
                            SingleItem => 1
                        );
                        if ( $MatchResult->{Match} ) {
                            $NewTmpData{$ID} = $Data{$ID};
                            if ( $Self->{ACLDebug} ) {
                                $Kernel::OM->Get('Kernel::System::Log')->Log(
                                    Priority => $Self->{ACLDebugLogPriority},
                                    Message  =>
                                        "ITSMConfigItemACL '$Acl' Possible param '$Data{$ID}' added to return data:'$Param{ReturnType}:$Param{ReturnSubType}'",
                                );
                            }
                        }
                        else {
                            if ( $Self->{ACLDebug} ) {
                                $Kernel::OM->Get('Kernel::System::Log')->Log(
                                    Priority => $Self->{ACLDebugLogPriority},
                                    Message  =>
                                        "ITSMConfigItemACL '$Acl' Possible param '$Data{$ID}' skipped from return data:'$Param{ReturnType}:$Param{ReturnSubType}'",
                                );
                            }
                        }
                    }
                }
            }

            # Step ITSMConfigItem PossibleAdd (Add new options to the white list)
            if (
                ( %Checks || %ChecksDatabase )
                && $Match
                && $MatchTry
                && $Step{PossibleAdd}->{ITSMConfigItem}->{ $Param{ReturnSubType} }
                )
            {
                $UseNewParams = 1;

                # debug log
                if ( $Self->{ACLDebug} ) {
                    $Kernel::OM->Get('Kernel::System::Log')->Log(
                        Priority => $Self->{ACLDebugLogPriority},
                        Message  =>
                            "ITSMConfigItemACL '$Acl' Used with PossibleAdd:'$Param{ReturnType}:$Param{ReturnSubType}'",
                    );
                }

                # possible add list
                for my $ID ( sort keys %Data ) {

                    for my $New ( @{ $Step{PossibleAdd}->{ITSMConfigItem}->{ $Param{ReturnSubType} } } ) {
                        my $MatchResult = $Self->_CompareMatchWithData(
                            Match      => $New,
                            Data       => $Data{$ID},
                            SingleItem => 1
                        );
                        if ( $MatchResult->{Match} ) {
                            $NewTmpData{$ID} = $Data{$ID};
                            if ( $Self->{ACLDebug} ) {
                                $Kernel::OM->Get('Kernel::System::Log')->Log(
                                    Priority => $Self->{ACLDebugLogPriority},
                                    Message  =>
                                        "ITSMConfigItemACL '$Acl' PossibleAdd param '$Data{$ID}' added to return data:'$Param{ReturnType}:$Param{ReturnSubType}'",
                                );
                            }
                        }
                        else {
                            if ( $Self->{ACLDebug} ) {
                                $Kernel::OM->Get('Kernel::System::Log')->Log(
                                    Priority => $Self->{ACLDebugLogPriority},
                                    Message  =>
                                        "ITSMConfigItemACL '$Acl' PossibleAdd param '$Data{$ID}' skipped from return data:'$Param{ReturnType}:$Param{ReturnSubType}'",
                                );
                            }
                        }
                    }
                }
            }

            # Step ITSMConfigItem PossibleNot (removes options from white list)
            if (
                ( %Checks || %ChecksDatabase )
                && $Match
                && $MatchTry
                && $Step{PossibleNot}->{ITSMConfigItem}->{ $Param{ReturnSubType} }
                )
            {
                $UseNewParams = 1;

                # debug log
                if ( $Self->{ACLDebug} ) {
                    $Kernel::OM->Get('Kernel::System::Log')->Log(
                        Priority => $Self->{ACLDebugLogPriority},
                        Message  =>
                            "ITSMConfigItemACL '$Acl' Used with PossibleNot:'$Param{ReturnType}:$Param{ReturnSubType}'",
                    );
                }

                # not possible list
                for my $ID ( sort keys %Data ) {
                    my $Match = 1;
                    for my $New ( @{ $Step{PossibleNot}->{ITSMConfigItem}->{ $Param{ReturnSubType} } } ) {
                        my $LoopMatchResult = $Self->_CompareMatchWithData(
                            Match      => $New,
                            Data       => $Data{$ID},
                            SingleItem => 1
                        );
                        if ( $LoopMatchResult->{Match} ) {
                            $Match = 0;
                        }
                    }
                    if ( !$Match ) {
                        if ( $Self->{ACLDebug} ) {
                            $Kernel::OM->Get('Kernel::System::Log')->Log(
                                Priority => $Self->{ACLDebugLogPriority},
                                Message  =>
                                    "ITSMConfigItemACL '$Acl' PossibleNot param '$Data{$ID}' removed from return data:'$Param{ReturnType}:$Param{ReturnSubType}'",
                            );
                        }
                        if ( $NewTmpData{$ID} ) {
                            delete $NewTmpData{$ID};
                        }
                    }
                    else {
                        if ( $Self->{ACLDebug} ) {
                            $Kernel::OM->Get('Kernel::System::Log')->Log(
                                Priority => $Self->{ACLDebugLogPriority},
                                Message  =>
                                    "ITSMConfigItemACL '$Acl' PossibleNot param '$Data{$ID}' leaved for return data:'$Param{ReturnType}:$Param{ReturnSubType}'",
                            );
                        }
                    }
                }
            }
        }

        # remember to new params if given
        if ($UseNewParams) {
            %NewData            = %NewTmpData;
            $UseNewMasterParams = 1;
        }

        # return new params if stop after this step
        if ( $UseNewParams && $Step{StopAfterMatch} ) {
            $Self->{ITSMConfigItemAclData} = \%NewData;

            # if we stop after the first match
            # exit the ACLRULES loop
            last ACLRULES;
        }
    }

    # return if no new param exists
    return if !$UseNewMasterParams;

    $Self->{ITSMConfigItemAclData} = \%NewData;

    return 1;
}

=head2 ITSMConfigItemAclData()

return the current ACL data hash after ITSMConfigItemAcl()

    my %Acl = $ITSMConfigItemObject->ITSMConfigItemAclData();

=cut

sub ITSMConfigItemAclData {
    my ( $Self, %Param ) = @_;

    return %{ $Self->{ITSMConfigItemAclData} || {} };
}

=head2 ITSMConfigItemAclActionData()

return the current ACL action data hash after ITSMConfigItemAcl()

    my %AclAction = $ITSMConfigItemObject->ITSMConfigItemAclActionData();

=cut

sub ITSMConfigItemAclActionData {
    my ( $Self, %Param ) = @_;

    if ( $Self->{ITSMConfigItemAclData} ) {
        return %{ $Self->{ITSMConfigItemAclData} };
    }
    return %{ $Self->{DefaultITSMConfigItemActionData} || {} };
}

=begin Internal:

=cut

=head2 _GetChecks()

creates two check hashes (one for current data updatable via AJAX refreshes and another for
static config item data stored in the DB) with the required data to use as a basis to match the ACLs

    my $ChecskResult = $ITSMConfigItemObject->_GetChecks(
        CheckAll => '1',                              # Optional
        RequiredChecks => $RequiredCheckHashRef,      # Optional a hash reference with the
                                                      #    attributes to gather:
                                                      #    e. g. User => 1, will fetch all user
                                                      #    information from the database, this data
                                                      #    will be tried to match with current ACLs
        Action        => 'AgentITSMConfigItemZoom',           # Optional
        ITSMConfigItemID      => 123,                         # Optional
        DynamicField  => {                            # Optional
            DynamicField_NameX => 123,
            DynamicField_NameZ => 'some value',
        },

        ResponsibleID    => 123,                      # Optional
        NewResponsibleID => 123,                      # Optional, ResponsibleID or NewResposibleID
                                                      #   can be used and they both refers to
                                                      #     ResponsibleID
        Responsible      => 'some user login'         # Optional

        UserID         => 123,                        # UserID => 1 is not affected by this function
    );

returns:
    $ChecksResult = {
        Checks => {
            # ...
            ITSMConfigItem => {
                ITSMConfigItemID => 123,
                # ...
            },
            # ...
        },
        ChecksDatabase =>
            # ...
            ITSMConfigItem => {
                ITSMConfigItemID => 123,
                # ...
            },
            # ...
        },
    };

=cut

sub _GetChecks {
    my ( $Self, %Param ) = @_;

    my $CheckAll       = $Param{CheckAll};
    my %RequiredChecks = %{ $Param{RequiredChecks} };

    # get used interface for process management checks
    my $Interface = 'AgentInterface';
    if ( !$Param{UserID} ) {
        $Interface = 'CustomerInterface';
    }

    my %Checks;
    my %ChecksDatabase;

    if ( $Param{Action} ) {
        $Checks{Frontend} = {
            Action => $Param{Action},
        };
        $ChecksDatabase{Frontend} = {
            Action => $Param{Action},
        };
    }

    # get config object
    my $ConfigObject = $Kernel::OM->Get('Kernel::Config');

    # use config item data if config item id is given
    # do that always, even if $RequiredChecks{ITSMConfigItem} is not that
    # (because too much stuff depends on it)
    if ( $Param{ITSMConfigItemID} ) {
        my %ITSMConfigItem = $Self->ITSMConfigItemGet(
            %Param,
            DynamicFields => 1,
        );
        $Checks{ITSMConfigItem} = \%ITSMConfigItem;

        # keep database config item data separated since the reference is affected below
        my %ITSMConfigItemDatabase = %ITSMConfigItem;
        $ChecksDatabase{ITSMConfigItem} = \%ITSMConfigItemDatabase;
    }

    # check for dynamic fields
    if ( IsHashRefWithData( $Param{DynamicField} ) ) {
        $Checks{DynamicField} = $Param{DynamicField};

        # update or add dynamic fields information to the config item check
        for my $DynamicFieldName ( sort keys %{ $Param{DynamicField} } ) {
            $Checks{ITSMConfigItem}->{$DynamicFieldName} = $Param{DynamicField}->{$DynamicFieldName};
        }
    }

    # always get info from config item too and set it to the Dynamic Field check hash if the info is
    # different. this can be done because in the previous step config item info was updated. but maybe
    # config item has more information stored than in the DynamicField parameter.
    ITSMCONFIGITEMATTRIBUTE:
    for my $ITSMConfigItemAttribute ( sort keys %{ $Checks{ITSMConfigItem} // {} } ) {
        next ITSMCONFIGITEMATTRIBUTE if !$ITSMConfigItemAttribute;

        # check if is a dynamic field with data
        next ITSMCONFIGITEMATTRIBUTE if $ITSMConfigItemAttribute !~ m{ \A DynamicField_ }smx;
        next ITSMCONFIGITEMATTRIBUTE if !defined $Checks{ITSMConfigItem}->{$ITSMConfigItemAttribute};
        next ITSMCONFIGITEMATTRIBUTE if !length $Checks{ITSMConfigItem}->{$ITSMConfigItemAttribute};

        if (
            ref $Checks{ITSMConfigItem}->{$ITSMConfigItemAttribute} eq 'ARRAY'
            && !IsArrayRefWithData( $Checks{ITSMConfigItem}->{$ITSMConfigItemAttribute} )
            )
        {
            next ITSMCONFIGITEMATTRIBUTE;
        }

        # compare if data is different and skip on same data
        if (
            $Checks{DynamicField}->{$ITSMConfigItemAttribute}
            && !DataIsDifferent(
                Data1 => $Checks{ITSMConfigItem}->{$ITSMConfigItemAttribute},
                Data2 => $Checks{DynamicField}->{$ITSMConfigItemAttribute},
            )
            )
        {
            next ITSMCONFIGITEMATTRIBUTE;
        }

        $Checks{DynamicField}->{$ITSMConfigItemAttribute} = $Checks{ITSMConfigItem}->{$ITSMConfigItemAttribute};
    }

    # also copy the database information to the appropriate hash
    ITSMCONFIGITEMATTRIBUTE:
    for my $ITSMConfigItemAttribute ( sort keys %{ $ChecksDatabase{ITSMConfigItem} } ) {
        next ITSMCONFIGITEMATTRIBUTE if !$ITSMConfigItemAttribute;

        # check if is a dynamic field with data
        next ITSMCONFIGITEMATTRIBUTE if $ITSMConfigItemAttribute !~ m{ \A DynamicField_ }smx;
        next ITSMCONFIGITEMATTRIBUTE if !defined $ChecksDatabase{ITSMConfigItem}->{$ITSMConfigItemAttribute};
        next ITSMCONFIGITEMATTRIBUTE if !length $ChecksDatabase{ITSMConfigItem}->{$ITSMConfigItemAttribute};

        if (
            ref $ChecksDatabase{ITSMConfigItem}->{$ITSMConfigItemAttribute} eq 'ARRAY'
            && !IsArrayRefWithData( $ChecksDatabase{ITSMConfigItem}->{$ITSMConfigItemAttribute} )
            )
        {
            next ITSMCONFIGITEMATTRIBUTE;
        }

        $ChecksDatabase{DynamicField}->{$ITSMConfigItemAttribute} = $ChecksDatabase{ITSMConfigItem}->{$ITSMConfigItemAttribute};
    }

    # use user data
    if ( ( $CheckAll || $RequiredChecks{User} ) && $Param{UserID} ) {

        my %User = $Kernel::OM->Get('Kernel::System::User')->GetUserData(
            UserID => $Param{UserID},
        );

        # get group object
        my $GroupObject = $Kernel::OM->Get('Kernel::System::Group');

        for my $Type ( @{ $ConfigObject->Get('System::Permission') } ) {

            my %Groups = $GroupObject->PermissionUserGet(
                UserID => $Param{UserID},
                Type   => $Type,
            );

            my @GroupNames = sort values %Groups;

            $User{"Group_$Type"} = \@GroupNames;
        }

        my %RoleIDs = $GroupObject->PermissionUserRoleGet(
            UserID => $Param{UserID},
        );

        my @RoleNames = sort values %RoleIDs;

        $User{Role}           = \@RoleNames;
        $Checks{User}         = \%User;
        $ChecksDatabase{User} = \%User;
    }

    # use type data (if given)
    if ( $CheckAll || $RequiredChecks{Type} ) {

        # get type object
        my $TypeObject = $Kernel::OM->Get('Kernel::System::Type');

        if ( $Param{TypeID} ) {
            my %Type = $TypeObject->TypeGet(
                ID     => $Param{TypeID},
                UserID => 1,
            );
            $Checks{Type} = \%Type;

            # update or add config item type information to the config item check
            $Checks{ITSMConfigItem}->{Type}   = $Checks{Type}->{Name};
            $Checks{ITSMConfigItem}->{TypeID} = $Checks{Type}->{ID};
        }
        elsif ( $Param{Type} ) {

            # TODO Attention!
            #
            # The parameter type can contain not only the wanted config item type, because also
            # some other functions in Kernel/System/ITSMConfigItem.pm use a type parameter, for example
            # MoveList() etc... These functions could be rewritten to not
            # use a Type parameter, or the functions that call ITSMConfigItemAcl() could be modified to
            # not just pass the complete Param-Hash, but instead a new parameter, like FrontEndParameter.
            #
            # As a workaround we lookup the TypeList first, and compare if the type parameter
            # is found in the list, so we can be more sure that it is the type that we want here.

            # lookup the type list (workaround for described problem)
            my %TypeList = reverse $TypeObject->TypeList();

            # check if type is in the type list (workaround for described problem)
            if ( $TypeList{ $Param{Type} } ) {
                my %Type = $TypeObject->TypeGet(
                    Name   => $Param{Type},
                    UserID => 1,
                );
                $Checks{Type} = \%Type;

                # update or add config item type information to the config item check
                $Checks{ITSMConfigItem}->{Type}   = $Checks{Type}->{Name};
                $Checks{ITSMConfigItem}->{TypeID} = $Checks{Type}->{ID};
            }
        }
        elsif ( !$Param{TypeID} && !$Param{Type} ) {
            if ( IsPositiveInteger( $Checks{ITSMConfigItem}->{TypeID} ) ) {

                # get type data from the config item
                my %Type = $TypeObject->TypeGet(
                    ID     => $Checks{ITSMConfigItem}->{TypeID},
                    UserID => 1,
                );
                $Checks{Type} = \%Type;
            }
        }

        # create hash with the config item information stored in the database
        if ( IsPositiveInteger( $ChecksDatabase{ITSMConfigItem}->{TypeID} ) ) {

            # check if database data matches current data (performance)
            if (
                defined $Checks{Type}->{ID}
                && $ChecksDatabase{ITSMConfigItem}->{TypeID} eq $Checks{Type}->{ID}
                )
            {
                $ChecksDatabase{Type} = $Checks{Type};
            }

            # otherwise complete the data querying the database again
            else {
                my %Type = $TypeObject->TypeGet(
                    ID     => $ChecksDatabase{ITSMConfigItem}->{TypeID},
                    UserID => 1,
                );
                $ChecksDatabase{Type} = \%Type;
            }
        }
    }

    # within this function %Param is modified by replacements like:
    #    $Param{PriorityID} = $Param{NewPriorityID}
    #    apparently this changes are not longer needed outside this function and it is not necessary
    #    to return such replacements

    return {
        Checks         => \%Checks,
        ChecksDatabase => \%ChecksDatabase,
    };
}

=head2 _CompareMatchWithData()

Compares a properties element with the data sent to the ACL, the compare results varies on how the
ACL properties where defined including normal, negated, regular expression and negated regular
expression comparisons.

    my $Result = $ITSMConfigItemObject->_CompareMatchWithData(
        Match => 'a value',         # or '[Not]a value', or '[RegExp]val' or '[NotRegExp]val'
                                    #    or '[Notregexp]val' or '[Notregexp]'
        Data => 'a value',
        SingleItem => 1,            # or 0, optional, default 0
    );

Returns:

    $Result = {
        Success => 1,               # or false
        Match   => 1,               # or false
        Skip    => 1,               # or false (in certain cases where SingleItem is set)
    };

=cut

sub _CompareMatchWithData {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Needed (qw(Match Data)) {
        if ( !defined $Param{$Needed} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Needed!",
            );
            return {
                Success => 0,
            };
        }
    }

    my $Match = $Param{Match};
    my $Data  = $Param{Data};

    # Negated matches requires a different logic.
    if ( substr( $Match, 0, length '[Not' ) eq '[Not' ) {

        # Not equal match
        if ( substr( $Match, 0, length '[Not]' ) eq '[Not]' ) {
            my $NotValue = substr $Match, length '[Not]';
            if ( $NotValue eq $Data ) {
                return {
                    Success => 1,
                    Match   => 0,
                };
            }
        }

        # Not reg-exp match case-sensitive.
        elsif ( substr( $Match, 0, length '[NotRegExp]' ) eq '[NotRegExp]' ) {
            my $RegExp = substr $Match, length '[NotRegExp]';
            if ( $Data =~ /$RegExp/ ) {
                return {
                    Success => 1,
                    Match   => 0,
                };
            }
        }

        # Not reg-exp match case-insensitive.
        elsif ( substr( $Match, 0, length '[Notregexp]' ) eq '[Notregexp]' ) {
            my $RegExp = substr $Match, length '[Notregexp]';
            if ( $Data =~ /$RegExp/i ) {
                return {
                    Success => 1,
                    Match   => 0,
                };
            }
        }

        if ( $Param{SingleItem} ) {
            return {
                Success => 1,
                Match   => 1,
                Skip    => 0,
            };
        }
        else {
            return {
                Success => 1,
                Match   => 1,
                Skip    => 1,
            };
        }
    }
    else {

        # Equal match.
        if ( $Match eq $Data ) {
            return {
                Success => 1,
                Match   => 1,
            };
        }

        # Reg-exp match case-sensitive.
        elsif ( substr( $Match, 0, length '[RegExp]' ) eq '[RegExp]' ) {
            my $RegExp = substr $Match, length '[RegExp]';
            if ( $Data =~ /$RegExp/ ) {
                return {
                    Success => 1,
                    Match   => 1,
                };
            }
        }

        # Reg-exp match case-insensitive.
        elsif ( substr( $Match, 0, length '[regexp]' ) eq '[regexp]' ) {
            my $RegExp = substr $Match, length '[regexp]';
            if ( $Data =~ /$RegExp/i ) {
                return {
                    Success => 1,
                    Match   => 1,
                };
            }
        }

        if ( $Param{SingleItem} ) {
            return {
                Success => 1,
                Match   => 0,
                Skip    => 0,
            };
        }
        else {
            return {
                Success => 1,
                Match   => 0,
                Skip    => 1,
            };
        }
    }
}

=end Internal:

=cut

1;

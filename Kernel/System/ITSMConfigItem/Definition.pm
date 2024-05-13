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

package Kernel::System::ITSMConfigItem::Definition;

=head1 NAME

Kernel::System::ITSMConfigItem::Definition - sub module of Kernel::System::ITSMConfigItem

=head1 DESCRIPTION

All functions related to the definition of config item classes and roles.

=head1 PUBLIC INTERFACE

=cut

use v5.24;
use strict;
use warnings;
use namespace::autoclean;
use utf8;

# core modules
use List::Util qw(any none uniq);

# CPAN modules

# OTOBO modules
use Kernel::Language              qw(Translatable);
use Kernel::System::VariableCheck qw(:all);

our $ObjectManagerDisabled = 1;

=head2 DefinitionList()

return a config item definition list for a class as an array-hash reference. The list
is sorted by version.

    my $DefinitionListRef = $ConfigItemObject->DefinitionList(
        ClassID => 123,
    );

returns

    my $DefinitionListRef = [
          {
            'Version'      => '1',
            'CreateTime'   => '2012-06-12 14:09:43',
            'DefinitionID' => '1',
            'CreateBy'     => '123',
            'Definition'   => '---
- Key: Vendor
  Name: Vendor
  Searchable: 1
  Input:
  - Type: Text
    Size: 50
    MaxLength: 50

- Key: Description
  Name: Description
  Searchable: 1
  Input:
  - Type: TextArea

- Key: Type
  Name: Type
  Searchable: 1
  Input:
  - Type: TextArea
  - Type: GeneralCatalog\
    Class: ITSM::ConfigItem::Computer::Type
    Translation: 1
# ... etc ...
',
          },
    ];

=cut

sub DefinitionList {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    if ( !$Param{ClassID} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => 'Need ClassID!',
        );

        return;
    }

    # ask database
    my $Rows = $Kernel::OM->Get('Kernel::System::DB')->SelectAll(
        SQL => <<'END_SQL',
SELECT id, configitem_definition, version, create_time, create_by
  FROM configitem_definition
  WHERE class_id = ?
  ORDER BY version
END_SQL
        Bind => [ \$Param{ClassID} ],
    );

    return unless defined $Rows;

    my @DefinitionList;
    for my $Row ( $Rows->@* ) {
        my %Definition;
        $Definition{DefinitionID} = $Row->[0];
        $Definition{Definition}   = $Row->[1] || "--- []";
        $Definition{Version}      = $Row->[2];
        $Definition{CreateTime}   = $Row->[3];
        $Definition{CreateBy}     = $Row->[4];

        # Check if definition code is not a YAML string.
        if ( substr( $Definition{Definition}, 0, 3 ) ne '---' ) {

            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'notice',
                Message  => "DefinitionID: $Definition{DefinitionID}"
                    . " ClassID: $Param{ClassID}"
                    . " found in legacy Perl code format, can not continue",
            );

            $Definition{Definition} = "--- []";
        }

        push @DefinitionList, \%Definition;
    }

    return \@DefinitionList;
}

=head2 RoleDefinitionList()

return a config item definition list for a role as an array-hash reference. The list
is sorted by version. This the same as C<DefinitionList>, but the parameter C<RoleID> is
used instead of C<ClassID>.

=cut

sub RoleDefinitionList {
    my ( $Self, %Param ) = @_;

    # rename the parameter
    $Param{ClassID} = delete $Param{RoleID};

    return $Self->DefinitionList(%Param);
}

=head2 DefinitionGet()

return a config item definition as hash reference

    my $DefinitionRef = $ConfigItemObject->DefinitionGet(
        DefinitionID => 123,
    );

or

    my $DefinitionRef = $ConfigItemObject->DefinitionGet(
        ClassID => 123,
    );

Returns:

    $Definition->{DefinitionID}
    $Definition->{ClassID}
    $Definition->{Class}
    $Definition->{Definition}
    $Definition->{DefinitionRef}
    $Definition->{DynamicFieldRef}
    $Definition->{Version}
    $Definition->{CreateTime}
    $Definition->{CreateBy}

=cut

sub DefinitionGet {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    if ( !$Param{DefinitionID} && !$Param{ClassID} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => 'Need DefinitionID or ClassID!',
        );

        return;
    }

    my @Row;
    if ( $Param{DefinitionID} ) {

        # check if result is already cached
        return $Self->{Cache}->{DefinitionGet}->{ $Param{DefinitionID} }
            if $Self->{Cache}->{DefinitionGet}->{ $Param{DefinitionID} };

        # ask database for the specified definition version
        @Row = $Kernel::OM->Get('Kernel::System::DB')->SelectRowArray(
            SQL => 'SELECT id, class_id, configitem_definition, dynamicfield_definition, version, create_time, create_by '
                . 'FROM configitem_definition WHERE id = ?',
            Bind => [ \$Param{DefinitionID} ],
        );
    }
    else {

        # ask database for the newest version for the class
        @Row = $Kernel::OM->Get('Kernel::System::DB')->SelectRowArray(
            SQL => 'SELECT id, class_id, configitem_definition, dynamicfield_definition, version, create_time, create_by '
                . 'FROM configitem_definition '
                . 'WHERE class_id = ? ORDER BY version DESC',
            Bind => [ \$Param{ClassID} ],
        );
    }

    # fetch the result
    my %Definition;
    $Definition{DefinitionID} = $Row[0];
    $Definition{ClassID}      = $Row[1];
    $Definition{Definition}   = $Row[2] || "--- []";
    my $DynamicFields = $Row[3] || "--- {}";
    $Definition{Version}    = $Row[4];
    $Definition{CreateTime} = $Row[5];
    $Definition{CreateBy}   = $Row[6];

    return {} unless $Definition{DefinitionID};

    # Check if definition code is not a YAML string.
    if ( substr( $Definition{Definition}, 0, 3 ) ne '---' ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'notice',
            Message  => "DefinitionID: $Definition{DefinitionID}"
                . " ClassID: $Definition{ClassID}"
                . " found in legacy Perl code format, can not continue",
        );

        $Definition{Definition} = "--- []";
    }

    $Definition{DefinitionRef} = $Kernel::OM->Get('Kernel::System::YAML')->Load(
        Data => $Definition{Definition},
    );
    $Definition{DynamicFieldRef} = $Kernel::OM->Get('Kernel::System::YAML')->Load(
        Data => $DynamicFields,
    );

    # merge the roles into the DefinitionRef, the passed in reference is modified in place
    $Self->_ProcessRoles(
        DefinitionRef => $Definition{DefinitionRef},
    );

    # prepare definition
    # TODO: Rework?
    #if ( $Definition{DefinitionRef} && ref $Definition{DefinitionRef} eq 'ARRAY' ) {
    #    $Self->_DefinitionPrepare(
    #        DefinitionRef => $Definition{DefinitionRef},
    #    );
    #}
    #else {
    #    $Definition{DefinitionRef} = '';
    #}

    # get class list
    my $ClassList = $Kernel::OM->Get('Kernel::System::GeneralCatalog')->ItemList(
        Class => 'ITSM::ConfigItem::Class',
    );

    # add class
    $Definition{Class} = $ClassList->{ $Definition{ClassID} };

    # cache the result
    $Self->{Cache}->{DefinitionGet}->{ $Definition{DefinitionID} } = \%Definition;

    return \%Definition;
}

=head2 RoleDefinitionGet()

return a config item definition as hash reference

Return

    $Definition->{DefinitionID}
    $Definition->{ClassID}
    $Definition->{Class}
    $Definition->{Definition}
    $Definition->{DefinitionRef}
    $Definition->{DynamicFieldRef}
    $Definition->{Version}
    $Definition->{CreateTime}
    $Definition->{CreateBy}

Get a specific version when the technical ID is known:

    my $DefinitionRef = $ConfigItemObject->RoleDefinitionGet(
        DefinitionID => 12,
    );

Or get the latest version:

    my $DefinitionRef = $ConfigItemObject->RoleDefinitionGet(
        RoleID => 123,
    );

Or get a specific version when the version is known.

    my $DefinitionRef = $ConfigItemObject->RoleDefinitionGet(
        RoleID  => 123,
        Version => 2,
    );

=cut

sub RoleDefinitionGet {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    if ( !$Param{DefinitionID} && !$Param{RoleID} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => 'Need DefinitionID or RoleID!',
        );
        return;
    }

    # create SQL
    my ( @Where, @Binds );
    if ( $Param{DefinitionID} ) {

        # check if result is already cached
        return $Self->{Cache}->{RoleDefinitionGet}->{ $Param{DefinitionID} }
            if $Self->{Cache}->{RoleDefinitionGet}->{ $Param{DefinitionID} };

        push @Where, 'id = ?';
        push @Binds, \$Param{DefinitionID};
    }
    else {
        # ask database for the newest version for the class
        push @Where, 'class_id = ?';
        push @Binds, \$Param{RoleID};

        # or request a specific version
        if ( $Param{Version} ) {
            push @Where, 'version = ?';
            push @Binds, \$Param{Version};
        }
    }

    my $SQL = sprintf <<'END_SQL', join( ' AND ', @Where );
SELECT id, class_id, configitem_definition, version, create_time, create_by
  FROM configitem_definition
  WHERE %s
  ORDER BY version DESC
END_SQL

    my @Row = $Kernel::OM->Get('Kernel::System::DB')->SelectRowArray(
        SQL  => $SQL,
        Bind => \@Binds,
    );

    # fetch the result
    my %Definition;
    $Definition{DefinitionID} = $Row[0];
    $Definition{RoleID}       = $Row[1];
    $Definition{Definition}   = $Row[2] || "--- []";
    $Definition{Version}      = $Row[3];
    $Definition{CreateTime}   = $Row[4];
    $Definition{CreateBy}     = $Row[5];

    return {} unless $Definition{DefinitionID};

    # Check if definition code is not a YAML string.
    if ( substr( $Definition{Definition}, 0, 3 ) ne '---' ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'notice',
            Message  => "DefinitionID: $Definition{DefinitionID}"
                . " RoleID: $Definition{RoleID}"
                . " found in legacy Perl code format, can not continue",
        );

        $Definition{Definition} = "--- []";
    }

    $Definition{DefinitionRef} = $Kernel::OM->Get('Kernel::System::YAML')->Load(
        Data => $Definition{Definition},
    );

    # get class list
    my $RoleList = $Kernel::OM->Get('Kernel::System::GeneralCatalog')->ItemList(
        Class => 'ITSM::ConfigItem::Role',
    );

    # add class
    $Definition{Role} = $RoleList->{ $Definition{RoleID} };

    # cache the result
    $Self->{Cache}->{RoleDefinitionGet}->{ $Definition{DefinitionID} } = \%Definition;

    return \%Definition;
}

=head2 DefinitionAdd()

adds a new definition.

    my $Result = $ConfigItemObject->DefinitionAdd(
        ClassID    => 123,
        Definition => 'the definition code',
        UserID     => 1,
        Force      => 1,    # optional, for internal use, force add even if definition is unchanged
                            # (used if dynamic fields changed)
    );

Returns in the case of success:

    $Result = {
        Success      => 1,
        DefinitionID => 123,
    };

Returns an error message in the case of failure:

    $Result = {
        Success   => 0,
        Error     => "Need %s!",
        ErrorArgs => [ 'Definition' ],
    };

Only two arguments of the error message are supported.

=cut

sub DefinitionAdd {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Argument (qw(ClassID Definition UserID)) {
        if ( !$Param{$Argument} ) {
            my $Message = "Need %s!";
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => sprintf( $Message, $Argument ),
            );

            return {
                Success   => 0,
                Error     => $Message,
                ErrorArgs => [$Argument],
            };
        }
    }

    # check sanity of the definition
    {
        my $CheckResult = $Self->DefinitionCheck(
            Definition => $Param{Definition},
        );

        return $CheckResult unless $CheckResult->{Success};
    }

    # get last definition
    my $LastDefinition = $Self->DefinitionGet(
        ClassID => $Param{ClassID},
    );

    # check whether the definition itself or the containing dynamic fields changed
    my $DefinitionChanged =
        ( !$LastDefinition->{DefinitionID} )
        ||
        ( $LastDefinition->{Definition} ne $Param{Definition} );

    # TODO: $Param{Force} || $Self->_CheckDynamicFieldChange(); can be taken out of _DefinitionSync() with a little adaption
    $DefinitionChanged ||= $Param{Force};

    # stop add, if definition was not changed
    if ( !$DefinitionChanged ) {
        my $Message = "Can't add new definition! The definition was not changed.";
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => $Message,
        );

        return {
            Success => 0,
            Error   => $Message,
        };
    }

    # add dynamic field info, roles are already considered in _DefinitionDynamicFieldGet
    my $DynamicFieldDefinition = $Self->_DefinitionDynamicFieldGet(
        %Param,
    ) || '--- []';

    # increment version
    my $Version = ( $LastDefinition->{Version} || 0 ) + 1;

    # insert new definition
    my $Success = $Kernel::OM->Get('Kernel::System::DB')->Do(
        SQL => 'INSERT INTO configitem_definition '
            . '(class_id, configitem_definition, dynamicfield_definition, version, create_time, create_by) VALUES '
            . '(?, ?, ?, ?, current_timestamp, ?)',
        Bind => [ \$Param{ClassID}, \$Param{Definition}, \$DynamicFieldDefinition, \$Version, \$Param{UserID} ],
    );

    return {
        Success => 0,
        Error   => 'Insert into the table configitem_definition was not successful',
    } unless $Success;

    # get id of new definition
    my ($DefinitionID) = $Kernel::OM->Get('Kernel::System::DB')->SelectRowArray(
        SQL => 'SELECT id FROM configitem_definition WHERE '
            . 'class_id = ? AND version = ? '
            . 'ORDER BY version DESC',
        Bind  => [ \$Param{ClassID}, \$Version ],
        Limit => 1,
    );

    # dynamic fields are synced
    $Self->DefinitionSetSynced(
        ClassID => $Param{ClassID},
    );

    # trigger DefinitionCreate event
    $Self->EventHandler(
        Event => 'DefinitionCreate',
        Data  => {
            DefinitionID => $DefinitionID,
            ClassID      => $Param{ClassID},
            Comment      => $DefinitionID,
        },
        UserID => $Param{UserID},
    );

    return {
        Success      => 1,
        DefinitionID => $DefinitionID,
        Version      => $Version,
    };
}

=head2 RoleDefinitionAdd()

add a new role definition

    my $Result = $ConfigItemObject->RoleDefinitionAdd(
        RoleID     => 123,
        Definition => 'the definition code',
        UserID     => 1,
        Force      => 1,    # optional, for internal use, force add even if definition is unchanged
                            # (used if dynamic fields changed)
    );

Returns in the case of success:

    $Result = {
        Success      => 1,
        DefinitionID => 123, # even though it is a role
        Version      => 4,
    };

Returns an error message in the case of failure:

    $Result = {
        Success   => 0,
        Error     => "Need %s!",
        ErrorArgs => [ 'Definition' ],
    };

Only two arguments of the error message are supported.

=cut

sub RoleDefinitionAdd {
    my ( $Self, %Param ) = @_;

    # TODO: reunify with DefinitionAdd()

    # check needed stuff
    for my $Argument (qw(RoleID Definition UserID)) {
        if ( !$Param{$Argument} ) {
            my $Message = "Need %s!";
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => sprintf( $Message, $Argument ),
            );

            return {
                Success   => 0,
                Error     => $Message,
                ErrorArgs => [$Argument],
            };
        }
    }

    # check sanity of the role definition
    {
        my $CheckResult = $Self->RoleDefinitionCheck(
            Definition => $Param{Definition},
        );

        return $CheckResult unless $CheckResult->{Success};
    }

    # get last definition, even though this is role
    my $LastDefinition = $Self->DefinitionGet(
        ClassID => $Param{RoleID},
    );

    # check whether the definition itself or the containing dynamic fields changed
    my $DefinitionChanged =
        ( !$LastDefinition->{DefinitionID} )
        ||
        ( $LastDefinition->{Definition} ne $Param{Definition} );

    # TODO: $Param{Force} || $Self->_CheckDynamicFieldChange(); can be taken out of _DefinitionSync() with a little adaption
    $DefinitionChanged ||= $Param{Force};

    # stop add, if definition was not changed
    if ( !$DefinitionChanged ) {
        my $Message = "Can't add new definition! The definition was not changed.";
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => $Message,
        );

        return {
            Success => 0,
            Error   => $Message,
        };
    }

    # increment version
    my $Version = ( $LastDefinition->{Version} || 0 ) + 1;

    # insert new definition
    my $Success = $Kernel::OM->Get('Kernel::System::DB')->Do(
        SQL => 'INSERT INTO configitem_definition '
            . '(class_id, configitem_definition, version, create_time, create_by) VALUES '
            . '(?, ?, ?, current_timestamp, ?)',
        Bind => [ \( $Param{RoleID}, $Param{Definition}, $Version, $Param{UserID} ) ],
    );

    return {
        Success => 0,
        Error   => 'Insert into the table configitem_definition was not successful',
    } unless $Success;

    # get id of new definition
    my ($DefinitionID) = $Kernel::OM->Get('Kernel::System::DB')->SelectRowArray(
        SQL => 'SELECT id FROM configitem_definition WHERE '
            . 'class_id = ? AND version = ? '
            . 'ORDER BY version DESC',
        Bind  => [ \( $Param{RoleID}, $Version ) ],
        Limit => 1,
    );

    return {
        Success      => 1,
        DefinitionID => $DefinitionID,
        Version      => $Version,
    };
}

=head2 DefinitionCheck()

checks the syntax of a new definition. Both class and role definitions can be checked
with this method.

    my $Result = $ConfigItemObject->DefinitionCheck(
        Definition      => 'the definition code',
        CheckSubElement => 1,                 # optional, default is 0, to check sub elements recursively)
        Type            => 'Class',           # optional, default is 'Class', possible values are 'Class' and 'Role'
    );

Returns in the case of a valid definition:

    my $Result = {
        Success => 1,
    };

Indicates the first found problem in the case of an invalid definition:

    my $Result = {
        Success => 0,
        Error   => '
        Error   => q{%s is missing. Please provide data for %s in the definition.},
        ErrorArgs => [ 'Sections', 'Sections' ],
    };

Note that the error message is split up in constant and variable parts. This allows translation in the user interface.

=cut

sub DefinitionCheck {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    if ( !$Param{Definition} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => 'Need Definition!',
        );

        return;
    }

    # This method is used for roles and classes
    my $Type = $Param{Type} // 'Class';

    # just for convenience
    my $ReturnError = sub {
        return {
            Success   => 0,
            Error     => $_[0],
            ErrorArgs => [ ( $_[1] // '' ), ( $_[2] // '' ) ],    # only two args are supported
        };
    };

    # simple YAML parsing, without using YAML tags
    my $DefinitionRef = $Kernel::OM->Get('Kernel::System::YAML')->Load(
        Data => $Param{Definition},
    );

    # YAML invalid
    if ( !IsHashRefWithData($DefinitionRef) ) {
        return $ReturnError->(
            Translatable('Base structure is not valid. Please provide an array with data in YAML format.')
        );
    }

    # Merge the roles into the DefinitionRef. The passed in reference is modified in place.
    # This might creates the 'Sections' attribute when it doesn't already exist.
    if ( $Type eq 'Class' ) {
        my $Result = $Self->_ProcessRoles(
            DefinitionRef => $DefinitionRef,
        );

        return $Result unless $Result->{Success};
    }

    # check the data structures of the top level attributes
    my %ExpectedFormat = (
        Sections => 'Hash',
    );
    if ( $Type eq 'Class' ) {
        $ExpectedFormat{Pages} = 'Array';
    }
    for my $Key ( sort keys %ExpectedFormat ) {

        # either pages or sections data invalid
        if ( !$DefinitionRef->{$Key} ) {
            return $ReturnError->(
                Translatable(q{%s is missing. Please provide data for %s in the definition.}),
                $Key,
                $Key,
            );
        }

        # TODO: this is not translateable
        if ( ref $DefinitionRef->{$Key} ne uc( $ExpectedFormat{$Key} ) ) {
            return $ReturnError->(
                Translatable(q{Data for %s is not a %s. Please correct the syntax.}),
                $Key,
                $ExpectedFormat{$Key}
            );
        }

        my $ValidateFunctionRef = \&{"Kernel::System::VariableCheck::Is$ExpectedFormat{$Key}RefWithData"};
        if ( !$ValidateFunctionRef->( $DefinitionRef->{$Key} ) ) {
            return $ReturnError->(
                Translatable(q{Data for %s is empty. Please provide data for %s in the definition.}),
                $Key,
                $Key,
            );
        }
    }

    # check second level data format
    my %SectionIsMissing;

    # check structure for defined pages
    if ( $ExpectedFormat{Pages} ) {
        for my $PageIndex ( 0 .. $#{ $DefinitionRef->{Pages} } ) {
            my $Page = $DefinitionRef->{Pages}->[$PageIndex];
            for my $Needed (qw(Name Content)) {
                if ( !$Page->{$Needed} ) {
                    return $ReturnError->(
                        Translatable(q{Key '%s' is missing in the definition of page %s.}),
                        $Needed,
                        $PageIndex,
                    );
                }
            }

            # check structure for defined page content data
            if ( ref $Page->{Content} ne 'ARRAY' ) {
                return $ReturnError->(
                    Translatable(q{Key %s for page %s is not an Array.}),
                    'Content',
                    $PageIndex,
                );
            }
            elsif ( !IsArrayRefWithData( $Page->{Content} ) ) {
                return $ReturnError->(
                    Translatable(q{Key %s for page %s is empty.}),
                    'Content',
                    $PageIndex,
                );
            }
            else {

                # check structure for defined page content sections
                for my $SectionIndex ( 0 .. $#{ $Page->{Content} } ) {
                    my $Section = $Page->{Content}->[$SectionIndex];

                    if ( !$Section ) {
                        return $ReturnError->(
                            Translatable(q{A section in page %s is invalid. Please provide data for the section or remove it.}),
                            $PageIndex,
                        );
                    }
                    elsif ( ref $Section ne 'HASH' ) {
                        return $ReturnError->(
                            Translatable(q{Data for a section in page %s is not a Hash. Please correct the syntax.}),
                            $PageIndex,
                        );
                    }
                    elsif ( !$Section->%* ) {
                        return $ReturnError->(
                            Translatable(q{Data for a section in page %s is empty. Please provide data for the section.}),
                            $PageIndex,
                        );
                    }

                    if ( !$Section->{Section} ) {
                        return $ReturnError->(
                            Translatable(q{A section in page %s is missing the key 'Section', which has to be filled with the section name.}),
                            $PageIndex,
                        );
                    }
                    else {

                        # store section name for checking data integrity later on
                        $SectionIsMissing{ $Section->{Section} } = 1;
                    }
                }
            }

            # check for the optional array references
            KEY:
            for my $Key (qw(Interfaces Groups)) {
                next KEY unless $Page->{$Key};               # is optional
                next KEY if ref $Page->{$Key} eq 'ARRAY';    # must be arrayref when it exists

                return $ReturnError->(
                    Translatable(q{Key %s for page %s is not an Array.}),
                    $Key,
                    $PageIndex,
                );
            }
        }
    }

    my %DefinedDynamicFields;
    my @NeededContentEntry = qw/DF Grid Header/;

    # sections data in pages content are valid, go on checking
    SECTION:
    for my $SectionName ( keys $DefinitionRef->{Sections}->%* ) {

        # remove defined sections to later identify undefined ones
        delete $SectionIsMissing{$SectionName};

        my $Section = $DefinitionRef->{Sections}{$SectionName};

        # skip description sections
        next SECTION if $Section->{Type} && $Section->{Type} eq 'Description';

        if ( !$Section || !IsHashRefWithData($Section) ) {
            return $ReturnError->(
                Translatable(q{Either the content of section %s is entirely missing or not a hash.}),
                $SectionName,
            );
        }

        if ( $Section->{Type} && $Section->{Type} ne 'DynamicFields' ) {
            if ( !any { $Section->{Type} eq $_ } qw/ConfigItemLinks Description ReferencedSection/ ) {
                return $ReturnError->(
                    Translatable(q{Invalid type in section %s.}),
                    $SectionName,
                );
            }
        }
        elsif ( !$Section->{Content} ) {
            return $ReturnError->(
                Translatable(q{Key 'Content' is missing in section %s.}),
                $SectionName,
            );
        }
        elsif ( !IsArrayRefWithData( $Section->{Content} ) ) {
            return $ReturnError->(
                Translatable(q{Data for 'Content' in section %s is not an array.}),
                $SectionName
            );
        }

        my @Grids;
        for my $ContentItem ( $Section->{Content}->@* ) {
            if ( !any { $ContentItem->{$_} } @NeededContentEntry ) {
                return $ReturnError->(
                    Translatable(q{Section %s has content which doesn't provide one of the following entries <%s>.}),
                    $SectionName,
                    "@NeededContentEntry",
                );
            }
            if ( $ContentItem->{DF} ) {
                $DefinedDynamicFields{ $ContentItem->{DF} } = $SectionName;
            }
            elsif ( $ContentItem->{Grid} ) {
                push @Grids, $ContentItem->{Grid};
            }
        }

        for my $GridItem (@Grids) {

            # TODO some more basic checks
            for my $Row ( $GridItem->{Rows}->@* ) {
                for my $Cell ( $Row->@* ) {
                    if ( !$Cell->{DF} ) {
                        return $ReturnError->(
                            Translatable(q{Data for 'Content' of %s contains a grid without DF in a cell.}),
                            $SectionName
                        );
                    }
                    $DefinedDynamicFields{ $Cell->{DF} } = $SectionName;
                }
            }
        }
    }

    if (%SectionIsMissing) {
        return $ReturnError->(
            Translatable(q{The following sections are used in pages, but are not defined: %s}),
            join( ', ', sort keys %SectionIsMissing )
        );
    }

    # check if all used dynamic fields are valid
    my $DFID2NameListRef = $Kernel::OM->Get('Kernel::System::DynamicField')->DynamicFieldList(
        Valid      => 1,
        ObjectType => ['ITSMConfigItem'],
        ResultType => 'HASH',
    );

    my %DFName2IDList = reverse $DFID2NameListRef->%*;

    for my $DefinedFieldName ( keys %DefinedDynamicFields ) {

        # check with dynamic field list
        if ( !$DFName2IDList{$DefinedFieldName} ) {
            return $ReturnError->(
                Translatable(q{Dynamic field %s is used in section %s, but does not exist in the system. Perhaps you forgot to create it or misspelled its name?}),
                $DefinedFieldName,
                $DefinedDynamicFields{$DefinedFieldName},
            );
        }
    }

    return {
        Success => 1,
    };
}

=head2 RoleDefinitionCheck()

checks the syntax and the sanity of a new role definition:

    my $True = $ConfigItemObject->RoleDefinitionCheck(
        Definition      => 'the definition code',
        CheckSubElement => 1,                 # (optional, default 0, to check sub elements recursively)
    );

=cut

sub RoleDefinitionCheck {
    my ( $Self, %Param ) = @_;

    return $Self->DefinitionCheck( %Param, Type => 'Role' );
}

=head2 DefinitionNeedSync()

return a hash of class ids with current definitions with dynamic fields not synced

    my %DefinitionsOutOfSync = $ConfigItemObject->DefinitionNeedSync();

Return
    %DefinitionsOutOfSync = (
        ClassID1 => [ DynamicFieldID1, DynamicFieldID2 ],
        ClassID2 => [ DynamicFieldID1, DynamicFieldID3 ],
    );

=cut

sub DefinitionNeedSync {
    my ( $Self, %Param ) = @_;

    my $DBObject = $Kernel::OM->Get('Kernel::System::DB');

    my $Cache = $Kernel::OM->Get('Kernel::System::Cache')->Get(
        Type => 'ConfigItemDefinition',
        Key  => 'OutOfSyncClasses',
    );

    $DBObject->Prepare(
        SQL => 'SELECT class_id, field_id FROM configitem_definition_sync',
    );

    my %OutOfSync;
    while ( my @Row = $DBObject->FetchrowArray() ) {
        push @{ $OutOfSync{ $Row[0] } }, $Row[1];
    }

    # cache the result
    $Kernel::OM->Get('Kernel::System::Cache')->Set(
        Type  => 'ConfigItemDefinition',
        Key   => 'OutOfSyncClasses',
        Value => \%OutOfSync,
        TTL   => 72000,                    # 20 d
    );

    return %OutOfSync;
}

=head2 DefinitionSetOutOfSync()

Declare current class definitions as out of sync with their dynamic fields

    my $Success = $ConfigItemObject->DefinitionSetOutOfSync(
        Classes => {
            ClassID1 => [ DynamicFieldID1, DynamicFieldID2 ],
            ClassID2 => [ DynamicFieldID1, DynamicFieldID3 ],
        },
    );

=cut

sub DefinitionSetOutOfSync {
    my ( $Self, %Param ) = @_;

    # check needed
    if ( !$Param{Classes} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => 'Need Classes hash!',
        );

        return;
    }

    my %Current = $Self->DefinitionNeedSync();
    my %New;

    CLASS:
    for my $ClassID ( keys $Param{Classes}->%* ) {
        if ( !$Current{$ClassID} ) {
            $New{$ClassID} = $Param{Classes}{$ClassID};

            next CLASS;
        }

        for my $FieldID ( $Param{Classes}{$ClassID}->@* ) {
            if ( !grep { $_ == $FieldID } $Current{$ClassID}->@* ) {
                push @{ $New{$ClassID} }, $FieldID;
            }
        }
    }

    return 1 unless %New;

    my $DBObject = $Kernel::OM->Get('Kernel::System::DB');

    my $Success = 1;
    for my $ClassID ( keys %New ) {
        for my $FieldID ( $New{$ClassID}->@* ) {

            # insert new out of sync relations
            $Success = $DBObject->Do(
                SQL  => 'INSERT INTO configitem_definition_sync (class_id, field_id) VALUES (?, ?)',
                Bind => [ \$ClassID, \$FieldID ],
            ) ? $Success : 0;
        }
    }

    $Kernel::OM->Get('Kernel::System::Cache')->Delete(
        Type => 'ConfigItemDefinition',
        Key  => 'OutOfSyncClasses',
    );

    return $Success;
}

=head2 DefinitionSetSynced()

Declare current class definition as in sync with its dynamic fields

    my $Success = $ConfigItemObject->DefinitionSetSynced(
        ClassID => 123,
    );

=cut

sub DefinitionSetSynced {
    my ( $Self, %Param ) = @_;

    # check needed
    if ( !$Param{ClassID} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => 'Need ClassID!',
        );

        return;
    }

    my $Success = $Kernel::OM->Get('Kernel::System::DB')->Do(
        SQL  => 'DELETE FROM configitem_definition_sync WHERE class_id = ?',
        Bind => [ \$Param{ClassID} ],
    );

    $Kernel::OM->Get('Kernel::System::Cache')->Delete(
        Type => 'ConfigItemDefinition',
        Key  => 'OutOfSyncClasses',
    );

    return $Success;
}

=head2 DefinitionSync()

Add new definitions for all classes where dynamic field contents changed compared to the current definition

    my $Success = $ConfigItemObject->DefinitionSync();

=cut

sub DefinitionSync {
    my ( $Self, %Param ) = @_;

    my %OutOfSync = $Self->DefinitionNeedSync();

    return 1 unless %OutOfSync;

    my $DynamicFieldObject = $Kernel::OM->Get('Kernel::System::DynamicField');

    my @ClassIDs = keys %OutOfSync;

    CLASS:
    for my $ClassID (@ClassIDs) {

        # check whether meaningful content is (still) affected
        my $NeedsSync  = 0;
        my $Definition = $Self->DefinitionGet(
            ClassID => $ClassID,
        );
        my $DynamicFieldDefinition;

        DYNAMICFIELD:
        for my $FieldID ( $OutOfSync{$ClassID}->@* ) {
            my $DynamicField = $DynamicFieldObject->DynamicFieldGet(
                ID => $FieldID,
            );

            my $OldDynamicField = $Definition->{DynamicFieldRef}{ $DynamicField->{Name} };
            if ( !$OldDynamicField || $OldDynamicField->{ID} ne $DynamicField->{ID} ) {

                # consider name changes
                $NeedsSync = 1;

                last DYNAMICFIELD;
            }

            if ( $OldDynamicField->{Label} ne $DynamicField->{Label} ) {

                # different labels can be due to the section definition
                if ( !$DynamicFieldDefinition ) {
                    my $DynamicFieldDefinitionYAML = $Self->_DefinitionDynamicFieldGet(
                        Definition => $Definition->{Definition},
                        ClassID    => $ClassID,
                    ) || '--- []';

                    $DynamicFieldDefinition = $Kernel::OM->Get('Kernel::System::YAML')->Load(
                        Data => $DynamicFieldDefinitionYAML,
                    );
                }

                if ( $OldDynamicField->{Label} ne $DynamicFieldDefinition->{ $DynamicField->{Name} }{Label} ) {
                    $NeedsSync = 1;

                    last DYNAMICFIELD;
                }
            }

            if (
                DataIsDifferent(
                    Data1 => $OldDynamicField->{Config},
                    Data2 => $DynamicField->{Config},
                )
                )
            {
                $NeedsSync = 1;

                last DYNAMICFIELD;
            }
        }

        if ( !$NeedsSync ) {
            $Self->DefinitionSetSynced(
                ClassID => $ClassID,
            );

            next CLASS unless $NeedsSync;
        }

        $Self->DefinitionAdd(
            ClassID    => $ClassID,
            Definition => $Definition->{Definition},
            UserID     => 1,
            Force      => 1,
        );
    }

    return 1;
}

=head2 ClassImport()

Import config item class including dynamic fields and namespaces, based on class definition

    my $Success = $ConfigItemObject->ClassImport(
        Content     => $Content,
        ClassExists => "(ERROR|IGNORE|UPDATE)"   # (optional) how to handle import of already existing classes, default ERROR
    );

=cut

sub ClassImport {
    my ( $Self, %Param ) = @_;

    $Param{ClassExists} ||= 'ERROR';

    # get needed objects
    my $ConfigItemObject     = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');
    my $GeneralCatalogObject = $Kernel::OM->Get('Kernel::System::GeneralCatalog');
    my $DynamicFieldObject   = $Kernel::OM->Get('Kernel::System::DynamicField');
    my $YAMLObject           = $Kernel::OM->Get('Kernel::System::YAML');

    # expect array ref of definitions
    my $DefinitionList = $Param{Content};
    if ( !IsArrayRefWithData($DefinitionList) ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => 'Param DefinitionList is empty or not an array reference.',
        );
        return;
    }

    # initialize needed variables
    my %ClassDefinitions;
    my %RoleDefinitions;
    my @ClassCategories;
    my %DynamicFields;
    my %Namespaces;
    my %SetDFs;
    my %ClassLookup = reverse %{
        $GeneralCatalogObject->ItemList(
            Class => 'ITSM::ConfigItem::Class',
        ) // {}
    };
    my %DynamicFieldLookup = reverse %{
        $DynamicFieldObject->DynamicFieldList(
            Valid      => 0,
            ResultType => 'HASH',
        ) || {}
    };
    my %RoleLookup = reverse %{
        $GeneralCatalogObject->ItemList(
            Class => 'ITSM::ConfigItem::Role',
        ) // {}
    };

    # 0. perform sanity checks
    for my $DefinitionItem ( $DefinitionList->@* ) {

        my %ClassData;

        # check definition for validity
        for my $Key (qw/Sections DynamicFields/) {
            if ( !$DefinitionItem->{$Key} ) {
                $Kernel::OM->Get('Kernel::System::Log')->Log(
                    Priority => 'error',
                    Message  => "Need $Key in Definition.",
                );
                return;
            }
        }
        if ( !( $DefinitionItem->{Class} || $DefinitionItem->{RoleName} ) ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need Class or RoleName in Definition.",
            );
            return;
        }
        if ( $DefinitionItem->{Class} && !$DefinitionItem->{Pages} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need Pages in Class Definition.",
            );
            return;
        }

        # set class data and check for duplicate
        if ( $DefinitionItem->{Class} ) {
            %ClassData = $DefinitionItem->{Class}->%*;
            if ( $ClassLookup{ $ClassData{Name} } && $Param{ClassExists} eq 'ERROR' ) {
                $Kernel::OM->Get('Kernel::System::Log')->Log(
                    Priority => 'error',
                    Message  => "Class $ClassData{Name} already exists.",
                );
                return;
            }
        }
        if ( $DefinitionItem->{RoleName} ) {
            if ( $RoleLookup{ $DefinitionItem->{RoleName} } && $Param{ClassExists} eq 'ERROR' ) {
                $Kernel::OM->Get('Kernel::System::Log')->Log(
                    Priority => 'error',
                    Message  => "Role $DefinitionItem->{RoleName} already exists.",
                );
                return;
            }
        }

        # collect class tags
        @ClassCategories = uniq( @ClassCategories, ( $ClassData{Categories} // [] )->@* );

        # collect dynamic fields
        %DynamicFields = (
            %DynamicFields,
            $DefinitionItem->{DynamicFields}->%*,
        );
    }

    # fetch existing categories to check for duplicates
    my $ExistingCategories = $GeneralCatalogObject->ItemList(
        Class => 'ITSM::ConfigItem::Class::Category',
        Valid => 0,
    ) // {};

    # handle creation of config item class categories
    CATEGORY:
    for my $Category (@ClassCategories) {

        next CATEGORY if any { $_ eq $Category } values $ExistingCategories->%*;

        my $Success = $GeneralCatalogObject->ItemAdd(
            Class   => 'ITSM::ConfigItem::Class::Category',
            Name    => $Category,
            ValidID => 1,
            UserID  => 1,
        );
        if ( !$Success ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'notice',
                Message  => "Couldn't add config item class category $Category.",
            );
        }
    }

    # add inner fields of set DFs to hash
    for my $Field ( keys %DynamicFields ) {
        if ( $DynamicFields{$Field}{FieldType} eq 'Set' ) {
            my %SetFields = map { $_->{DF} => $_->{Definition} } $DynamicFields{$Field}{Config}{Include}->@*;

            if ( !%SetFields ) {
                $Kernel::OM->Get('Kernel::System::Log')->Log(
                    Priority => 'error',
                    Message  => "Erroneous configuration of Set $Field.",
                );
            }

            %SetDFs = (
                %SetDFs,
                %SetFields,
            );
        }
    }

    # check dynamic fields
    my %AllFields = ( %DynamicFields, %SetDFs );
    for my $Field ( keys %AllFields ) {
        if ( $DynamicFieldLookup{$Field} ) {
            my $DynamicField = $DynamicFieldObject->DynamicFieldGet(
                Name => $Field,
            );

            if ( $DynamicField->{FieldType} ne $AllFields{$Field}{FieldType} || $DynamicField->{ObjectType} ne 'ITSMConfigItem' ) {
                $Kernel::OM->Get('Kernel::System::Log')->Log(
                    Priority => 'error',
                    Message  => "DynamicField $Field exists but does not have the required Object- and/or FieldType.",
                );
                return;
            }

            if ( $DynamicField->{MultiValue} xor $AllFields{$Field}{MultiValue} ) {
                $Kernel::OM->Get('Kernel::System::Log')->Log(
                    Priority => 'error',
                    Message  => "DynamicField $Field exists but does not match the multivalue setting.",
                );
                return;
            }
        }

        if ( $Field !~ m{ \A [a-zA-Z\d\-]+ \z }xms ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Invalid DynamicField name '$Field'.",
            );
            return;
        }

        if ( $Field =~ /^([^-]+)-/ ) {
            $Namespaces{$1} = 1;
        }
    }

    # 1. create all classes
    CLASSDEFINITION:
    for my $ClassDefinition ( grep { $_->{Class} } $DefinitionList->@* ) {

        my %ClassData = %{ delete $ClassDefinition->{Class} };

        # handle duplications according param ClassExists
        my $ClassID;
        if ( $ClassLookup{ $ClassData{Name} } ) {
            if ( $Param{ClassExists} eq 'UPDATE' ) {
                my $Success = $GeneralCatalogObject->ItemUpdate(
                    ItemID  => $ClassLookup{ $ClassData{Name} },
                    Name    => $ClassData{Name},
                    ValidID => 1,
                    UserID  => 1,
                );
                if ( !$Success ) {
                    $Kernel::OM->Get('Kernel::System::Log')->Log(
                        Priority => 'error',
                        Message  => "Could not update class $ClassData{Name}.",
                    );
                    return;
                }
                $ClassID = $ClassLookup{ $ClassData{Name} };
            }
            else {
                next CLASSDEFINITION;
            }
        }
        else {
            $ClassID = $GeneralCatalogObject->ItemAdd(
                Class   => 'ITSM::ConfigItem::Class',
                Name    => $ClassData{Name},
                ValidID => 1,
                UserID  => 1,
            );
        }

        if ( !$ClassID ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Could not add class $ClassData{Name}.",
            );
            return;
        }

        # set class preferences
        PREFERENCEKEY:
        for my $PreferenceKey (qw(NameModule NumberModule VersionStringModule Permission Categories VersionTrigger)) {

            # transition: preference Permission is named PermissionGroup in definition syntax
            my $PreferenceValue;
            if ( $PreferenceKey eq 'Permission' ) {

                next PREFERENCEKEY unless $ClassData{PermissionGroup};

                $PreferenceValue = $Kernel::OM->Get('Kernel::System::Group')->GroupLookup(
                    Group => $ClassData{PermissionGroup},
                );
            }
            else {
                $PreferenceValue = $ClassData{$PreferenceKey};
            }

            next PREFERENCEKEY unless $PreferenceValue;

            if ( !ref $PreferenceValue ) {
                $PreferenceValue = [$PreferenceValue];
            }

            next PREFERENCEKEY unless IsArrayRefWithData($PreferenceValue);

            my $Success = $GeneralCatalogObject->GeneralCatalogPreferencesSet(
                ItemID => $ClassID,
                Key    => $PreferenceKey,
                Value  => $PreferenceValue,
            );
            if ( !$Success ) {
                $Kernel::OM->Get('Kernel::System::Log')->Log(
                    Priority => 'notice',
                    Message  => "Couldn't update preference $PreferenceKey for config item class $ClassID.",
                );
            }
        }

        # clean up definition data
        delete $ClassDefinition->{DynamicFields};

        # collect definition
        $ClassDefinitions{$ClassID} = $YAMLObject->Dump(
            Data => $ClassDefinition,
        );
        if ( !$ClassDefinitions{$ClassID} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => 'Error recreating the definition in yaml.',
            );
            return;
        }
    }

    # 2. create all roles
    ROLEDEFINITION:
    for my $RoleDefinition ( grep { $_->{RoleName} } $DefinitionList->@* ) {

        my $RoleName = delete $RoleDefinition->{RoleName};

        # handle duplications according param ClassExists
        my $RoleID;
        if ( $RoleLookup{$RoleName} ) {
            if ( $Param{ClassExists} eq 'UPDATE' ) {
                my $Success = $GeneralCatalogObject->ItemUpdate(
                    ItemID  => $RoleLookup{$RoleName},
                    Name    => $RoleName,
                    ValidID => 1,
                    UserID  => 1,
                );
                if ( !$Success ) {
                    $Kernel::OM->Get('Kernel::System::Log')->Log(
                        Priority => 'error',
                        Message  => "Could not update role $RoleName.",
                    );
                    return;
                }
                $RoleID = $RoleLookup{$RoleName};
            }
            else {
                next ROLEDEFINITION;
            }
        }
        else {
            $RoleID = $GeneralCatalogObject->ItemAdd(
                Class   => 'ITSM::ConfigItem::Role',
                Name    => $RoleName,
                ValidID => 1,
                UserID  => 1,
            );
        }

        if ( !$RoleID ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Could not add role $RoleName.",
            );
            return;
        }

        # clean up definition data
        delete $RoleDefinition->{DynamicFields};

        # collect definition
        $RoleDefinitions{$RoleID} = $YAMLObject->Dump(
            Data => $RoleDefinition,
        );
        if ( !$RoleDefinitions{$RoleID} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => 'Error recreating the definition in yaml.',
            );
            return;
        }
    }

    # namespace handling
    if (%Namespaces) {

        my $SysConfigObject = $Kernel::OM->Get('Kernel::System::SysConfig');

        # Get current setting value.
        my %Setting = $SysConfigObject->SettingGet(
            Name => 'DynamicField::Namespaces',
        );

        my $ExistingNamespaces = $Setting{EffectiveValue};
        my %AllNamespaces      = (
            ( map { $_ => 1 } $ExistingNamespaces->@* ),
            %Namespaces,
        );

        # check if namespaces need to be changed
        my $UpdateNamespaces = 0;
        NEWNAMESPACE:
        for my $NewNamespace ( keys %AllNamespaces ) {
            if ( none { $NewNamespace eq $_ } $ExistingNamespaces->@* ) {
                $UpdateNamespaces = 1;
                last NEWNAMESPACE;
            }
        }
        if ($UpdateNamespaces) {

            my $ExclusiveLockGUID = $SysConfigObject->SettingLock(
                UserID    => 1,
                Force     => 1,
                DefaultID => $Setting{DefaultID},
            );

            # Update setting with modified data
            my %Result = $SysConfigObject->SettingUpdate(
                Name              => 'DynamicField::Namespaces',
                IsValid           => 1,
                EffectiveValue    => [ keys %AllNamespaces ],
                ExclusiveLockGUID => $ExclusiveLockGUID,
                UserID            => 1,
            );
            if ( !$Result{Success} ) {
                $Kernel::OM->Get('Kernel::System::Log')->Log(
                    Priority => 'error',
                    Message  => 'Could not update setting DynamicField::Namespaces.',
                );
                return;
            }

            my $Success = $SysConfigObject->SettingUnlock(
                UserID    => 1,
                DefaultID => $Setting{DefaultID},
            );
            if ( !$Success ) {
                $Kernel::OM->Get('Kernel::System::Log')->Log(
                    Priority => 'error',
                    Message  => 'Could not unlock setting DynamicField::Namespaces.',
                );
                return;
            }

            my %DeploymentResult = $SysConfigObject->ConfigurationDeploy(
                Comments      => "ClassImport updating DynamicField::Namespaces",
                UserID        => 1,
                Force         => 1,
                DirtySettings => ['DynamicField::Namespaces'],
            );

            if ( !$DeploymentResult{Success} ) {
                $Kernel::OM->Get('Kernel::System::Log')->Log(
                    Priority => 'error',
                    Message  => 'Deployment failed!',
                );
                return;
            }
        }
    }

    # split dynamic fields in three separate groups
    my @NormalFieldNames = grep { $AllFields{$_}{FieldType} ne 'Lens' && $AllFields{$_}{FieldType} ne 'Set' } keys %AllFields;
    my @LensFieldNames   = grep { $AllFields{$_}{FieldType} eq 'Lens' } keys %AllFields;
    my @SetFieldNames    = grep { $AllFields{$_}{FieldType} eq 'Set' } keys %AllFields;

    # sort lens fields in case a lens has another lens as attribute dynamic field
    my @LensFieldNamesSorted = sort {
        ( $AllFields{$b}{Name} eq $AllFields{$a}{Config}{AttributeDF} ) <=> ( $AllFields{$a}{Name} eq $AllFields{$b}{Config}{AttributeDF} )
    } @LensFieldNames;

    # 3. create dynamic fields
    my $Order = scalar( keys %DynamicFieldLookup );
    FIELD:
    for my $FieldName ( @NormalFieldNames, @LensFieldNamesSorted, @SetFieldNames ) {
        next FIELD if $DynamicFieldLookup{$FieldName};

        my $FieldConfig = $AllFields{$FieldName};

        my %SetConfig;
        if ( $FieldConfig->{FieldType} eq 'Set' ) {
            my @Included = map { { DF => $_->{DF} } } $FieldConfig->{Config}{Include}->@*;
            %SetConfig = (
                Config => {
                    $FieldConfig->{Config}->%*,
                    Include => \@Included,
                },
            );
        }

        # if needed, perform neccessary transformations
        $FieldConfig = $Self->_DynamicFieldConfigTransform(
            DynamicFieldConfig => $FieldConfig,
            Action             => 'Import',
        );

        my $FieldID = $DynamicFieldObject->DynamicFieldAdd(
            $FieldConfig->%*,
            %SetConfig,
            FieldOrder => ++$Order,
            ObjectType => 'ITSMConfigItem',
            Reorder    => 0,
            ValidID    => 1,
            UserID     => 1,
        );

        if ( !$FieldID ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Could not add dynamic field $FieldConfig->{Name}.",
            );
        }
    }

    # 4. add definitions
    for my $ClassID ( keys %ClassDefinitions ) {
        my $Return = $ConfigItemObject->DefinitionAdd(
            ClassID    => $ClassID,
            Definition => $ClassDefinitions{$ClassID},
            UserID     => 1,
            Force      => 1,
        );

        if ( !$Return->{Success} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => 'Could not store definition.',
            );
            return;
        }
    }
    for my $RoleID ( keys %RoleDefinitions ) {
        my $Return = $ConfigItemObject->RoleDefinitionAdd(
            RoleID     => $RoleID,
            Definition => $RoleDefinitions{$RoleID},
            UserID     => 1,
            Force      => 1,
        );

        if ( !$Return->{Success} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => 'Could not store definition.',
            );
            return;
        }
    }

    return 1;
}

=head2 ClassExport()

Export config item classes, including dynamic fields and namespaces, into a YAML string

    my $YAMLString = $ConfigItemObject->ClassExport(
        ItemIDList => [ClassID1, ClassID2, ClassID3, ...],      # list of class or / and role IDs to export
    );

In case of a failure C<undef> is returned.

=cut

sub ClassExport {
    my ( $Self, %Param ) = @_;

    my $GeneralCatalogObject = $Kernel::OM->Get('Kernel::System::GeneralCatalog');
    my $YAMLObject           = $Kernel::OM->Get('Kernel::System::YAML');

    my $AllExportedClassesRef;

    for my $ExportItemID ( @{ $Param{ItemIDList} } ) {

        # check if item is role or class
        my $ItemData = $GeneralCatalogObject->ItemGet(
            ItemID => $ExportItemID,
        );
        if ( !IsHashRefWithData($ItemData) ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "ID $ExportItemID is invalid!",
            );
        }
        if ( $ItemData->{Class} ne 'ITSM::ConfigItem::Class' && $ItemData->{Class} ne 'ITSM::ConfigItem::Role' ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Item with ID $ExportItemID is neither a config item class nor a config item role!",
            );
        }

        my %ExportItem;
        my $DefinitionRef;
        if ( $ItemData->{Class} eq 'ITSM::ConfigItem::Class' ) {

            # fetch class definition
            $DefinitionRef = $Self->DefinitionGet( ClassID => $ExportItemID );
            $ExportItem{Class}{Name} = $DefinitionRef->{Class};

            # fetch class preferences
            my %ClassPreferences = $GeneralCatalogObject->GeneralCatalogPreferencesGet(
                ItemID => $ExportItemID,
            );
            if ( !%ClassPreferences ) {
                $Kernel::OM->Get('Kernel::System::Log')->Log(
                    Priority => 'notice',
                    Message  => "Could not get preference data for class $DefinitionRef->{Class}!",
                );
            }

            PREFERENCESKEY:
            for my $PreferenceKey ( keys %ClassPreferences ) {

                next PREFERENCESKEY unless $ClassPreferences{$PreferenceKey};
                next PREFERENCESKEY unless $ClassPreferences{$PreferenceKey}[0];

                # transition of Permission to PermissionGroup
                if ( $PreferenceKey eq 'Permission' ) {

                    # translate group id into group name
                    my $PreferenceValue = $Kernel::OM->Get('Kernel::System::Group')->GroupLookup(
                        GroupID => $ClassPreferences{$PreferenceKey}[0],
                    );

                    $ExportItem{Class}{PermissionGroup} = $PreferenceValue;
                }

                # single-value attributes
                elsif ( grep { $_ eq $PreferenceKey } qw(NameModule NumberModule VersionStringModule) ) {
                    $ExportItem{Class}{$PreferenceKey} = $ClassPreferences{$PreferenceKey}[0];
                }

                # multi-value attributes
                elsif ( grep { $_ eq $PreferenceKey } qw(Categories VersionTrigger) ) {
                    $ExportItem{Class}{$PreferenceKey} = $ClassPreferences{$PreferenceKey};
                }
            }
        }
        elsif ( $ItemData->{Class} eq 'ITSM::ConfigItem::Role' ) {

            # fetch role definition
            $DefinitionRef = $Self->RoleDefinitionGet( RoleID => $ExportItemID );
            $ExportItem{RoleName} = $DefinitionRef->{Role};
        }

        # perform dynamic field transformation
        for my $DynamicFieldName ( keys $DefinitionRef->{DynamicFieldRef}->%* ) {
            my $TransformedDFConfig = $Self->_DynamicFieldConfigTransform(
                DynamicFieldConfig => $DefinitionRef->{DynamicFieldRef}{$DynamicFieldName},
                Action             => 'Export',
            );
            $ExportItem{DynamicFields}{$DynamicFieldName} = $TransformedDFConfig;
        }

        for my $DefinitionKey ( sort keys %{ $DefinitionRef->{DefinitionRef} } ) {
            $ExportItem{$DefinitionKey} = $DefinitionRef->{DefinitionRef}->{$DefinitionKey};
        }

        push @{$AllExportedClassesRef}, \%ExportItem;
    }

    return $YAMLObject->Dump( Data => $AllExportedClassesRef );
}

=begin Internal:

=head2 _ProcessRoles

For convenience the YAML for a config item class may contain a subtree called Roles. Usually these Roles
load other YAML documents which contain a Section hash. These section a merged into the toplevel Section hash.
The keys of the merged in sections are the Role key joined with the loaded section name. The join marker is C<::>.

The passed in hash reference is modified in place.

=cut

sub _ProcessRoles {
    my ( $Self, %Param ) = @_;

    # check definition
    if ( !$Param{DefinitionRef} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => 'Need DefinitionRef!',
        );

        return;
    }

    # roles are optional
    my $DefinitionRef = $Param{DefinitionRef};
    my $Roles         = $DefinitionRef->{Roles};

    return { Success => 1 } unless $Roles;

    # just for convenience
    my $ReturnError = sub {
        return {
            Success   => 0,
            Error     => $_[0],
            ErrorArgs => [ ( $_[1] // '' ), ( $_[2] // '' ) ],    # only two args are supported
        };
    };

    if ( ref $Roles ne 'HASH' ) {
        return $ReturnError->(
            Translatable(q{Key %s is not a Hash.}),
            'Roles',
        );
    }

    # nothing to do
    return { Success => 1 } unless $Roles->%*;

    my $ConfigItemObject = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');

    # get role list for mapping name to ID
    my %RoleName2ID;
    {
        my $GeneralCatalogObject = $Kernel::OM->Get('Kernel::System::GeneralCatalog');
        my $RoleList             = $GeneralCatalogObject->ItemList(
            Class => 'ITSM::ConfigItem::Role',
        );
        %RoleName2ID = reverse $RoleList->%*;
    }

    # overwrite without mercy
    ROLE_KEY:
    for my $RoleKey ( keys $Roles->%* ) {
        my $RoleSource = $Roles->{$RoleKey};

        # The name of the role is per default the key in the Roles hash,
        # but can be overridden by an explicit attribute 'Name'.
        # This allows to use a more convenient name in the class definition.
        my $RoleName = $RoleSource->{Name} // $RoleKey;

        # Version is required
        if ( !$RoleSource->{Version} ) {
            return $ReturnError->(
                Translatable(q{Key %s is missing for the role %s}),
                'Version',
                $RoleName,
            );
        }

        # the fetching is done via the ID
        my $RoleID = $RoleName2ID{$RoleName};

        if ( !$RoleID ) {
            return $ReturnError->(
                Translatable(q{The role %s was not found.}),
                $RoleName,
            );
        }

        # This already parses the YAML
        my $RoleDefinition = $ConfigItemObject->RoleDefinitionGet(
            RoleID  => $RoleID,
            Version => $RoleSource->{Version},
        );

        if ( !$RoleDefinition ) {
            return $ReturnError->(
                Translatable(q{The role %s with version %s was not found.}),
                $RoleName,
                $RoleSource->{Version},
            );
        }

        if ( ref $RoleDefinition ne 'HASH' ) {
            return $ReturnError->(
                Translatable(q{The role %s with version %s is not a hash.}),
                $RoleName,
                $RoleSource->{Version},
            );
        }

        if (
            !$RoleDefinition->{Definition}
            ||
            !$RoleDefinition->{DefinitionRef}
            ||
            !$RoleDefinition->{DefinitionRef}->{Sections}
            ||
            ref $RoleDefinition->{DefinitionRef}->{Sections} ne 'HASH'
            )
        {
            return $ReturnError->(
                Translatable(q{The role %s with version %s is not valid.}),
                $RoleName,
                $RoleSource->{Version},
            );
        }

        # Add the sections from the Role to the Sections of the class.
        # Note that the convenient name from the class definition is used here
        my $RoleSections = $RoleDefinition->{DefinitionRef}->{Sections};
        for my $RoleSectionKey ( keys $RoleSections->%* ) {

            # if a class has valid roles, then Sections is not required
            $DefinitionRef->{Sections} //= {};

            my $SectionName = join '::', $RoleKey, $RoleSectionKey;
            $DefinitionRef->{Sections}->{$SectionName} = $RoleSections->{$RoleSectionKey};
        }
    }

    return { Success => 1 };
}

=head2 _DefinitionPrepare()

Prepare the syntax of a new definition.

    my $True = $ConfigItemObject->_DefinitionPrepare(
        DefinitionRef => $ArrayRef,
    );

=cut

sub _DefinitionPrepare {
    my ( $Self, %Param ) = @_;

    # check definition
    if ( !$Param{DefinitionRef} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => 'Need DefinitionRef!',
        );
        return;
    }

    for my $Item ( @{ $Param{DefinitionRef} } ) {

        # set CountMin
        $Item->{CountMin} //= 1;

        # set CountMax
        $Item->{CountMax} ||= 1;

        # set CountMin
        if ( $Item->{CountMin} > $Item->{CountMax} ) {
            $Item->{CountMin} = $Item->{CountMax};
        }

        # set CountDefault
        $Item->{CountDefault} //= 1;
        if ( $Item->{CountDefault} < $Item->{CountMin} ) {
            $Item->{CountDefault} = $Item->{CountMin};
        }
        if ( $Item->{CountDefault} > $Item->{CountMax} ) {
            $Item->{CountDefault} = $Item->{CountMax};
        }

        # start recursion, if "Sub" is defined.
        if ( $Item->{Sub} && ref $Item->{Sub} eq 'ARRAY' ) {
            $Self->_DefinitionPrepare(
                DefinitionRef => $Item->{Sub},
            );
        }
        else {
            delete $Item->{Sub};
        }
    }

    return 1;
}

sub _DefinitionDynamicFieldGet {
    my ( $Self, %Param ) = @_;

    my $IsInitialCall = defined $Param{Definition};    # the YAML definition

    # In the initial call the Definition is passed as YAML,
    # in the recursive calls, DefinitionPerl is passed
    if ($IsInitialCall) {
        $Param{DefinitionPerl} = $Kernel::OM->Get('Kernel::System::YAML')->Load(
            Data => $Param{Definition},
        );

        # merge the roles into the DefinitionRef, the passed in reference is modified in place
        $Self->_ProcessRoles(
            DefinitionRef => $Param{DefinitionPerl},
        );
    }

    my %ContentHash  = ref $Param{DefinitionPerl} eq 'HASH'  ? $Param{DefinitionPerl}->%* : ();
    my @ContentArray = ref $Param{DefinitionPerl} eq 'ARRAY' ? $Param{DefinitionPerl}->@* : ();

    # log, even when empty arrays or hashes are allowed
    if ( !%ContentHash && !@ContentArray ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "Need Definition or DefinitionPerl as hash or array!",
        );

        return;
    }

    # recurively collect the dynamic fields
    my %DynamicFields;

    # TODO: specify the path where DF fields are expected, maybe with JSON::Path
    KEY:
    for my $Key ( keys %ContentHash ) {
        if ( $Key eq 'DF' ) {
            $DynamicFields{ $ContentHash{$Key} } = \%ContentHash;

            next KEY;
        }

        # do not descend into Interfaces and Groups,
        # as these may be empty and would be logged as errors
        next KEY if $Key eq 'Interfaces';
        next KEY if $Key eq 'Groups';

        next KEY unless ref $ContentHash{$Key};

        # descend
        %DynamicFields = (
            %DynamicFields,
            $Self->_DefinitionDynamicFieldGet(
                DefinitionPerl => $ContentHash{$Key},
                ClassID        => $Param{ClassID},
            ),
        );
    }

    for my $Entry (@ContentArray) {
        if ( ref $Entry ) {
            %DynamicFields = (
                %DynamicFields,
                $Self->_DefinitionDynamicFieldGet( DefinitionPerl => $Entry ),
            );
        }
    }

    # the recursive calls only collect the dynamice fields
    return %DynamicFields unless $IsInitialCall;

    # some more work to do in the initial call
    my %ReturnDynamicFields;
    {
        my $DynamicFieldObject = $Kernel::OM->Get('Kernel::System::DynamicField');

        # Store config item class to check for version triggers in dynamic field object handler
        my $ClassList = $Kernel::OM->Get('Kernel::System::GeneralCatalog')->ItemList(
            Class => 'ITSM::ConfigItem::Class',
        );
        my $Class = $ClassList->{ $Param{ClassID} };

        DYNAMICFIELD:
        for my $Name ( keys %DynamicFields ) {
            my $DynamicField = $DynamicFieldObject->DynamicFieldGet( Name => $Name );

            # only return valid dynamic fields
            next DYNAMICFIELD unless $DynamicField;
            next DYNAMICFIELD unless $DynamicField->{ValidID} eq '1';

            # for set fields also the contained dynamic fields have to be versioned
            if ( $DynamicField->{FieldType} eq 'Set' ) {
                next DYNAMICFIELD unless IsArrayRefWithData( $DynamicField->{Config}{Include} );

                INCLUDED:
                for my $IncludedDF ( $DynamicField->{Config}{Include}->@* ) {
                    next INCLUDED unless $IncludedDF->{DF};

                    my $IncludedDFConfig = $DynamicFieldObject->DynamicFieldGet( Name => $IncludedDF->{DF} );

                    $IncludedDF->{Definition} = {
                        ID         => $IncludedDFConfig->{ID},
                        Name       => $IncludedDFConfig->{Name},
                        Label      => $IncludedDFConfig->{Label},
                        Config     => $IncludedDFConfig->{Config},
                        FieldType  => $IncludedDFConfig->{FieldType},
                        ObjectType => $IncludedDFConfig->{ObjectType},
                        CIClass    => $Class,
                    };
                }
            }

            $ReturnDynamicFields{$Name} = {
                ID         => $DynamicField->{ID},
                Name       => $DynamicField->{Name},
                Label      => $DynamicField->{Label},
                Config     => $DynamicField->{Config},       # may contain included DF
                FieldType  => $DynamicField->{FieldType},
                ObjectType => $DynamicField->{ObjectType},
                CIClass    => $Class,
            };

            for my $Attribute (qw/Mandatory Label Readonly/) {
                if ( defined $DynamicFields{$Name}{$Attribute} ) {
                    $ReturnDynamicFields{$Name}{$Attribute} = $DynamicFields{$Name}{$Attribute};
                }
            }
        }
    }

    # the initial call returns YAML
    return $Kernel::OM->Get('Kernel::System::YAML')->Dump(
        Data => \%ReturnDynamicFields,
    );
}

sub _DynamicFieldConfigTransform {
    my ( $Self, %Param ) = @_;

    for my $Needed (qw(Action DynamicFieldConfig)) {
        if ( !$Param{$Needed} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Needed!",
            );
            return;
        }
    }

    my $DynamicFieldConfig = $Param{DynamicFieldConfig};

    if ( grep { $Param{DynamicFieldConfig}{FieldType} eq $_ } qw(Agent ConfigItem ConfigItemVersion CustomerCompany CustomerUser FAQ Ticket) ) {

        # needed transformation: Name -> ID
        if ( $Param{Action} eq 'Import' ) {

            if ( $DynamicFieldConfig->{Config}{Queue} ) {
                my @QueueIDs;
                for my $QueueName ( $DynamicFieldConfig->{Config}{Queue}->@* ) {
                    push @QueueIDs, $Kernel::OM->Get('Kernel::System::Queue')->QueueLookup( Queue => $QueueName );
                }
                $DynamicFieldConfig->{Config}{Queue} = \@QueueIDs;
            }
            if ( $DynamicFieldConfig->{Config}{TicketType} ) {
                my @TypeIDs;
                for my $TypeName ( $DynamicFieldConfig->{Config}{TicketType}->@* ) {
                    push @TypeIDs, $Kernel::OM->Get('Kernel::System::Type')->TypeLookup( TypeID => $TypeName );
                }
                $DynamicFieldConfig->{Config}{TicketType} = \@TypeIDs;
            }
            if ( $DynamicFieldConfig->{Config}{ClassIDs} ) {
                my %ClassLookup = reverse %{
                    $Kernel::OM->Get('Kernel::System::GeneralCatalog')->ItemList(
                        Class => 'ITSM::ConfigItem::Class',
                    )
                };
                my @ClassIDs;
                for my $ClassName ( $DynamicFieldConfig->{Config}{ClassIDs}->@* ) {
                    push @ClassIDs, $ClassLookup{$ClassName};
                }
                $DynamicFieldConfig->{Config}{ClassIDs} = \@ClassIDs;
            }
        }

        # needed transformation: ID -> Name
        elsif ( $Param{Action} eq 'Export' ) {

            if ( $DynamicFieldConfig->{Config}{Queue} ) {
                my @QueueNames;
                for my $QueueID ( $DynamicFieldConfig->{Config}{Queue}->@* ) {
                    push @QueueNames, $Kernel::OM->Get('Kernel::System::Queue')->QueueLookup( QueueID => $QueueID );
                }
                $DynamicFieldConfig->{Config}{Queue} = \@QueueNames;
            }
            if ( $DynamicFieldConfig->{Config}{TicketType} ) {
                my @TypeNames;
                for my $TypeID ( $DynamicFieldConfig->{Config}{TicketType}->@* ) {
                    push @TypeNames, $Kernel::OM->Get('Kernel::System::Type')->TypeLookup( TypeID => $TypeID );
                }
                $DynamicFieldConfig->{Config}{TicketType} = \@TypeNames;
            }
            if ( $DynamicFieldConfig->{Config}{ClassIDs} ) {
                my %ClassLookup = %{
                    $Kernel::OM->Get('Kernel::System::GeneralCatalog')->ItemList(
                        Class => 'ITSM::ConfigItem::Class',
                    )
                };
                my @ClassNames;
                for my $ClassID ( $DynamicFieldConfig->{Config}{ClassIDs}->@* ) {
                    push @ClassNames, $ClassLookup{$ClassID};
                }
                $DynamicFieldConfig->{Config}{ClassIDs} = \@ClassNames;
            }
        }
    }
    elsif ( $Param{DynamicFieldConfig}{FieldType} eq 'Lens' ) {

        my $DynamicFieldObject = $Kernel::OM->Get('Kernel::System::DynamicField');

        if ( $Param{Action} eq 'Import' ) {
            my $AttributeDF = $DynamicFieldObject->DynamicFieldGet(
                Name => $Param{DynamicFieldConfig}{Config}{AttributeDF},
            );
            $Param{DynamicFieldConfig}{Config}{AttributeDF} = $AttributeDF->{ID};
            my $ReferenceDF = $DynamicFieldObject->DynamicFieldGet(
                Name => $Param{DynamicFieldConfig}{Config}{ReferenceDF},
            );
            $Param{DynamicFieldConfig}{Config}{ReferenceDF} = $ReferenceDF->{ID};
        }
        elsif ( $Param{Action} eq 'Export' ) {
            my $AttributeDF = $DynamicFieldObject->DynamicFieldGet(
                ID => $Param{DynamicFieldConfig}{Config}{AttributeDF},
            );
            $Param{DynamicFieldConfig}{Config}{AttributeDF} = $AttributeDF->{Name};
            my $ReferenceDF = $DynamicFieldObject->DynamicFieldGet(
                ID => $Param{DynamicFieldConfig}{Config}{ReferenceDF},
            );
            $Param{DynamicFieldConfig}{Config}{ReferenceDF} = $ReferenceDF->{Name};
        }
    }

    return $Param{DynamicFieldConfig};
}

=end Internal:

=cut

1;

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

package Kernel::System::ITSMConfigItem::Definition;

use strict;
use warnings;

use List::Util qw(any);

use Kernel::Language qw(Translatable);
use Kernel::System::VariableCheck qw(:all);

our $ObjectManagerDisabled = 1;

=head1 NAME

Kernel::System::ITSMConfigItem::Definition - sub module of Kernel::System::ITSMConfigItem

=head1 PUBLIC INTERFACE

=head1 DESCRIPTION

All definition functions.

=head2 DefinitionList()

return a config item definition list as array-hash reference

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
    $Kernel::OM->Get('Kernel::System::DB')->Prepare(
        SQL => 'SELECT id, configitem_definition, version, create_time, create_by '
            . 'FROM configitem_definition WHERE class_id = ? ORDER BY version',
        Bind => [ \$Param{ClassID} ],
    );

    my @DefinitionList;
    while ( my @Row = $Kernel::OM->Get('Kernel::System::DB')->FetchrowArray() ) {
        my %Definition;
        $Definition{DefinitionID} = $Row[0];
        $Definition{Definition}   = $Row[1] || "--- []";
        $Definition{Version}      = $Row[2];
        $Definition{CreateTime}   = $Row[3];
        $Definition{CreateBy}     = $Row[4];

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

=head2 DefinitionGet()

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

    my $DefinitionRef = $ConfigItemObject->DefinitionGet(
        DefinitionID => 123,
    );

or

    my $DefinitionRef = $ConfigItemObject->DefinitionGet(
        ClassID => 123,
    );

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

    return {} unless $Definition{DefinitionID};

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

=head2 DefinitionAdd()

add a new definition

    my $DefinitionID = $ConfigItemObject->DefinitionAdd(
        ClassID    => 123,
        Definition => 'the definition code',
        UserID     => 1,
        Force      => 1,    # optional, for internal use, force add even if definition is unchanged
                            # (used if dynamic fields changed)
    );

=cut

sub DefinitionAdd {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Argument (qw(ClassID Definition UserID)) {
        if ( !$Param{$Argument} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Argument!",
            );
            return;
        }
    }

    # check definition
    my $CheckResult = $Self->DefinitionCheck(
        Definition => $Param{Definition},
    );

    return $CheckResult if !$CheckResult->{Success};

    # get last definition
    my $LastDefinition = $Self->DefinitionGet(
        ClassID => $Param{ClassID},
    );

    # check whether the definition itself or the containing dynamic fields changed
    my $DefinitionChanged = !$LastDefinition->{DefinitionID} || $LastDefinition->{Definition} ne $Param{Definition};

    # TODO: $Param{Force} || $Self->_CheckDynamicFieldChange(); can be taken out of _DefinitionSync() with a little adaption
    $DefinitionChanged ||= $Param{Force};

    # stop add, if definition was not changed
    if ( !$DefinitionChanged ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "Can't add new definition! The definition was not changed.",
        );

        return;
    }

    # add dynamic field info
    my $DynamicFieldDefinition = $Self->_DefinitionDynamicFieldGet(
        %Param,
    ) || '--- []';

    # set version
    my $Version = 1;
    if ( $LastDefinition->{Version} ) {
        $Version = $LastDefinition->{Version};
        $Version++;
    }

    # insert new definition
    my $Success = $Kernel::OM->Get('Kernel::System::DB')->Do(
        SQL => 'INSERT INTO configitem_definition '
            . '(class_id, configitem_definition, dynamicfield_definition, version, create_time, create_by) VALUES '
            . '(?, ?, ?, ?, current_timestamp, ?)',
        Bind => [ \$Param{ClassID}, \$Param{Definition}, \$DynamicFieldDefinition, \$Version, \$Param{UserID} ],
    );

    return if !$Success;

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

    return $DefinitionID;
}

=head2 DefinitionCheck()

check the syntax of a new definition

    my $True = $ConfigItemObject->DefinitionCheck(
        Definition      => 'the definition code',
        CheckSubElement => 1,                 # (optional, default 0, to check sub elements recursively)
    );

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

    my $YAMLObject  = $Kernel::OM->Get('Kernel::System::YAML');
    my $ReturnError = sub {
        return {
            Success => 0,
            Error   => $_[0],
        };
    };

    my $DefinitionRef = $YAMLObject->Load(
        Data => $Param{Definition},
    );

    # YAML invalid
    if ( !IsHashRefWithData($DefinitionRef) ) {
        return $ReturnError->( Translatable('Base structure is not valid. Please provide an array with data in YAML format.') );
    }

    # check first level data format
    my %ExpectedFormat = (
        Pages    => 'Array',
        Sections => 'Hash',
    );
    for my $Key (qw(Pages Sections)) {
        my $FunctionName = \&{"Is$ExpectedFormat{$Key}RefWithData"};

        # either pages or sections data invalid
        if ( !$DefinitionRef->{$Key} ) {
            return $ReturnError->( Translatable("$Key is missing. Please provide data for $Key in the definition.") );
        }
        elsif ( ref $DefinitionRef->{$Key} ne uc( $ExpectedFormat{$Key} ) ) {
            return $ReturnError->( Translatable("Data for $Key is not a $ExpectedFormat{$Key}. Please correct the syntax.") );
        }
        elsif ( !( $FunctionName->( $DefinitionRef->{$Key} ) ) ) {
            return $ReturnError->( Translatable("Data for $Key is empty. Please provide data for $Key in the definition.") );
        }
    }

    # check second level data format
    my %SectionNames;

    # check structure for defined pages
    for my $PageIndex ( 0 .. $#{ $DefinitionRef->{Pages} } ) {
        my $Page = $DefinitionRef->{Pages}->[$PageIndex];
        for my $Needed (qw(Name Content)) {
            if ( !$Page->{$Needed} ) {
                return $ReturnError->( Translatable("Key '$Needed' is missing in the definition of page $PageIndex.") );
            }
        }

        # check structure for defined page content data
        if ( ref $Page->{Content} ne 'ARRAY' ) {
            return $ReturnError->( Translatable("Key Content for page $PageIndex is not an Array.") );
        }
        elsif ( !IsArrayRefWithData( $Page->{Content} ) ) {
            return $ReturnError->( Translatable("Key Content for page $PageIndex is empty.") );
        }
        else {

            # check structure for defined page content sections
            for my $SectionIndex ( 0 .. $#{ $Page->{Content} } ) {
                my $Section = $Page->{Content}->[$SectionIndex];

                if ( !$Section ) {
                    return $ReturnError->( Translatable("A section in page $PageIndex is invalid. Please provide data for the section or remove it.") );
                }
                elsif ( ref $Section ne 'HASH' ) {
                    return $ReturnError->( Translatable("Data for a section in page $PageIndex is not a Hash. Please correct the syntax.") );
                }
                elsif ( !$Section->%* ) {
                    return $ReturnError->( Translatable("Data for a section in page $PageIndex is empty. Please provide data for the section.") );
                }

                if ( !$Section->{Section} ) {
                    return $ReturnError->( Translatable("A section in page $PageIndex is missing the key 'Section', which has to be filled with the section name.") );
                }
                else {

                    # store section name for checking data integrity later on
                    $SectionNames{ $Section->{Section} } = 1;
                }
            }
        }
    }

    my @Grids;
    my %DefinedDynamicFields;
    my @NeededContentEntry = qw/DF Grid Header/;

    # sections data in pages content are valid, go on checking
    for my $SectionName ( keys $DefinitionRef->{Sections}->%* ) {

        # remove defined sections to later identify undefined ones
        delete $SectionNames{$SectionName};

        my $Section = $DefinitionRef->{Sections}{$SectionName};

        if ( !$Section || !IsHashRefWithData($Section) ) {
            return $ReturnError->( Translatable("Either the content of section $SectionName is entirely missing or not a hash.") );
        }

        if ( !$Section->{Content} ) {
            return $ReturnError->( Translatable("Key 'Content' is missing in section $SectionName.") );
        }
        elsif ( !IsArrayRefWithData( $Section->{Content} ) ) {
            return $ReturnError->( sprintf Translatable("Data for 'Content' in section %s is not an array."), $SectionName );
        }

        my @Grids;
        for my $ContentItem ( $Section->{Content}->@* ) {
            if ( !any { $ContentItem->{$_} } @NeededContentEntry ) {
                return $ReturnError->( Translatable("Section $SectionName has content which doesn't provide one of the following entries <@NeededContentEntry>.") );
            }
            if ( $ContentItem->{DF} ) {
                $DefinedDynamicFields{ $ContentItem->{DF} } = $SectionName;
            }
            elsif ( $ContentItem->{Grid} ) {
                push @Grids, $ContentItem->{Grid};
            }
        }

        for my $GridItem ( @Grids ) {
            # TODO some more basic checks
            for my $Row ( $GridItem->{Rows}->@* ) {
                for my $Cell ( $Row->@* ) {
                    if ( !$Cell->{DF} ) {
                        return $ReturnError->( sprintf Translatable("Data for 'Content' of %s contains a grid without DF in a cell."), $SectionName );
                    }
                    $DefinedDynamicFields{ $Cell->{DF} } = $SectionName;
                }
            }
        }
    }

    if ( %SectionNames ) {
        return $ReturnError->( Translatable("The following sections are used in pages, but not defined: " . join(', ', keys %SectionNames)) );
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
                Translatable(
                    "Dynamic field $DefinedFieldName is used in section $DefinedDynamicFields{$DefinedFieldName}, but does not exist in the system. Perhaps you forgot to create it or misspelled its name?"
                )
            );
        }
    }

    return {
        Success => 1,
    };
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

    return 1 if !%New;

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

    my $Cache = $Kernel::OM->Get('Kernel::System::Cache')->Delete(
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

    return 1 if !%OutOfSync;

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
                ClassID => $Param{ClassID},
            );

            next CLASS if !$NeedsSync;
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

=begin Internal:

=head2 _DefinitionPrepare()

Prepare the syntax of a new definition

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
        if ( !defined $Item->{CountMin} ) {
            $Item->{CountMin} = 1;
        }

        # set CountMax
        $Item->{CountMax} ||= 1;

        # set CountMin
        if ( $Item->{CountMin} > $Item->{CountMax} ) {
            $Item->{CountMin} = $Item->{CountMax};
        }

        # set CountDefault
        if ( !defined $Item->{CountDefault} ) {
            $Item->{CountDefault} = 1;
        }
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

    $Param{DefinitionPerl} //= $Kernel::OM->Get('Kernel::System::YAML')->Load(
        Data => $Param{Definition},
    );

    my %ContentHash  = ref $Param{DefinitionPerl} && ref $Param{DefinitionPerl} eq 'HASH'  ? $Param{DefinitionPerl}->%* : ();
    my @ContentArray = ref $Param{DefinitionPerl} && ref $Param{DefinitionPerl} eq 'ARRAY' ? $Param{DefinitionPerl}->@* : ();

    if ( !%ContentHash && !@ContentArray ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "Need Definition or DefinitionPerl as hash or array!",
        );

        return;
    }

    my %DynamicFields;

    for my $Key ( keys %ContentHash ) {
        if ( $Key eq 'DF' ) {
            $DynamicFields{ $ContentHash{$Key} } = \%ContentHash;
        }
        elsif ( ref $ContentHash{$Key} ) {
            %DynamicFields = (
                %DynamicFields,
                $Self->_DefinitionDynamicFieldGet(
                    DefinitionPerl => $ContentHash{$Key},
                    ClassID        => $Param{ClassID},
                ),
            );
        }
    }

    for my $Entry (@ContentArray) {
        if ( ref $Entry ) {
            %DynamicFields = (
                %DynamicFields,
                $Self->_DefinitionDynamicFieldGet( DefinitionPerl => $Entry ),
            );
        }
    }

    if ( $Param{Definition} ) {
        my $DynamicFieldObject = $Kernel::OM->Get('Kernel::System::DynamicField');

        # Store config item class to check for version triggers in dynamic field object handler
        my $ClassList = $Kernel::OM->Get('Kernel::System::GeneralCatalog')->ItemList(
            Class => 'ITSM::ConfigItem::Class',
        );
        my $Class = $ClassList->{ $Param{ClassID} };

        my %ReturnDynamicFields;

        DYNAMICFIELD:
        for my $Name ( keys %DynamicFields ) {
            my $DynamicField = $DynamicFieldObject->DynamicFieldGet( Name => $Name );

            next DYNAMICFIELD if !$DynamicField;
            next DYNAMICFIELD if !$DynamicField->{ValidID} eq '1';

            # for set fields also the contained dynamic fields have to be versioned
            if ( $DynamicField->{FieldType} eq 'Set' ) {
                next DYNAMICFIELD if !IsArrayRefWithData( $DynamicField->{Config}{Include} );

                INCLUDED:
                for my $IncludedDF ( $DynamicField->{Config}{Include}->@* ) {
                    next INCLUDED if !$IncludedDF->{DF};

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
                Config     => $DynamicField->{Config},
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

        return $Kernel::OM->Get('Kernel::System::YAML')->Dump(
            Data => \%ReturnDynamicFields,
        );
    }

    return %DynamicFields;
}

=end Internal:

=cut

1;

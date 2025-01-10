# --
# OTOBO is a web-based ticketing system for service organisations.
# --
# Copyright (C) 2001-2020 OTRS AG, https://otrs.com/
# Copyright (C) 2019-2024 Rother OSS GmbH, https://otobo.io/
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

# NOTAS:
# Pode não repetir valores ou pode ter o autocomplete, um dos comportamentos fica excluído.
# AutoComplete => MultiSelect = 0 incondicionalmente
#
# Para permitir múltiplos valores sem repetição, só com MultiSelect = 1
# Compromisso:
# Se legado MaxArraySize = 1 então Autocomplete, senão MultiSelect


package Kernel::System::Console::Command::Admin::ITSM::Configitem::ConvertLegacyRefDFs;

use strict;
use warnings;

use parent qw(Kernel::System::Console::BaseCommand);

# core modules

# CPAN modules

# OTOBO modules
use Kernel::System::Console::InterfaceConsole;    ## no perlimports

use Data::Dumper;

our @ObjectDependencies = (
    'Kernel::Config',
    'Kernel::System::Main',
    'Kernel::System::DB',
    'Kernel::System::Log',
    'Kernel::System::DynamicField',
    'Kernel::System::DynamicFieldValue',
    'Kernel::System::Package',
);

sub Configure {
    my ( $Self, %Param ) = @_;

    $Self->Description(
        'Convert legacy OtoboPar DFs of type ITSMConfigItemReference to standard ConfigItem fields.'
    );
    $Self->AddOption(
        Name        => 'file',
        Description => "File name for the constrictions report, by default 'constrictions.txt'.",
        Required    => 0,
        HasValue    => 1,
        ValueRegex  => qr/./,
        Multiple    => 0,
    );
    $Self->AddOption(
        Name        => 'force',
        Description => "If the report file already exists, overwrite without prompting.",
        Required    => 0,
        HasValue    => 0,
        ValueRegex  => qr/./,
    );

    return;
}

sub Run {
    my ( $Self, %Param ) = @_;

    my $FileName       = $Self->GetOption('file') || "constrictions.txt";
    my $ForceOverwrite = $Self->GetOption('force');

    if ( -e $FileName && !$ForceOverwrite ) {
        $Self->Print("<yellow>Constrictions report file '$FileName' already exists. Overwrite it?</yellow>");
        $Self->Print("\n<yellow>Please confirm by typing 'y'es</yellow>: ");
        return $Self->ExitCodeOk() if <STDIN> !~ /^ye?s?$/i;
    }

    # get needed objects
    my $DBObject                = $Kernel::OM->Get('Kernel::System::DB');
    my $DynamicFieldObject      = $Kernel::OM->Get('Kernel::System::DynamicField');
    my $DynamicFieldValueObject = $Kernel::OM->Get('Kernel::System::DynamicFieldValue');
    my $PackageObject           = $Kernel::OM->Get('Kernel::System::Package');

    # support console command
    if( !defined $DBObject->{dbh} ) {
        $DBObject->Connect();
    }
    if( !defined $DBObject->{dbh} ) {
        die ("unable to connect to Database.");
    }

    $DBObject->BeginWork();
    my @IDs = $Self->_GetDFTypeIDs(
        DBObject => $DBObject,
        DFType => 'ITSMConfigItemReference',
    );

    my $CountFieldUpdates = 0;
    my $CountValueUpdates = 0;
    my @ConstrictionsList;

    for my $ID (@IDs) {
        $Self->_UpdateDynamicFieldConfig(
            ID => $ID,
            DynamicFieldObject => $DynamicFieldObject,
            ConstrictionsList => \@ConstrictionsList,
        );
        $CountFieldUpdates++;
        $CountValueUpdates += $Self->_UpdateDynamicFieldValues(
            ID => $ID,
            DBObject => $DBObject,
            DynamicFieldValueObject => $DynamicFieldValueObject,
        );
    }

    $DBObject->{dbh}->commit();

    $Self->Print("$CountFieldUpdates fields updated\n");
    $Self->Print("$CountValueUpdates field values updated\n");

    $Self->_ReportConstrictions(
                ConstrictionsList => \@ConstrictionsList,
                FileName => $FileName,
            );
    $Self->Print("<green>Done</green>\n");
    return $Self->ExitCodeOk();
}

sub _UpdateDynamicFieldConfig {

    my ( $Self, %Param ) = @_;

    my $ID                  = $Param{'ID'};
    my $DynamicFieldObject  = $Param{'DynamicFieldObject'};
    my $ConstrictionsList   = $Param{'ConstrictionsList'};

    my $DF = $DynamicFieldObject->DynamicFieldGet( ID => $ID );

    my $NewConfig = {
        'ImportSearchAttribute' => '',
        'Multiselect' => ( $DF->{Config}->{MaxArraySize} > 1 ? 1 : 0 ),
        'ReferenceFilterList' => [],
        'SearchAttribute' => '',
        'PossibleNone' => '1',
        'EditFieldMode' => 'AutoComplete',
        'MultiValue' => 0,
        'LinkType' => '',
        'LinkDirection' => 'ReferencingIsSource',
        'DisplayType' => $Self->_ConvertFromDisplayPattern( Pattern => $DF->{Config}->{DisplayPattern} ),
        'ClassIDs' => $DF->{Config}->{ITSMConfigItemClasses},
        'DeplStateIDs' => $DF->{Config}->{DeploymentStates},
        'Tooltip' => '',
        'ReferencedObjectType' => 'ITSMConfigItem',
    };

    my $Success = $DynamicFieldObject->DynamicFieldUpdate(
        ID         => $ID,
        Name       => $DF->{Name},
        Label      => $DF->{Label},
        FieldOrder => $DF->{FieldOrder},
        FieldType  => 'ConfigItem',
        ObjectType => $DF->{ObjectType},
        ValidID    => $DF->{ValidID},
        Config     => $NewConfig,
        UserID     => 1,
    );

    if ( !$Success ) {
        $Self->Print("<red>Unable to set DF Config for " . $DF->{Name} . " ($ID) with:\n $NewConfig</red>\n");
        return $Self->ExitCodeError();
    }

    my @LocalConstrictions = split("\r\n", $DF->{Config}->{Constrictions});
    for my $Constriction (@LocalConstrictions) {
        push @{$ConstrictionsList}, {
                    ID => $ID,
                    Constriction => $Constriction,
                };
    }
    return;
}

sub _ConvertFromDisplayPattern {
    my ( $Self, %Param ) = @_;

    my $Pattern = $Param{'Pattern'};

    if ($Pattern =~ /<CI_Class>/ && $Pattern =~ /<CI_Name>/) {
        return 'ClassConfigItemName';
    }
    elsif ($Pattern =~ /<CI_Class>/ && $Pattern =~ /<CI_Number>/) {
        return 'ClassConfigItemNumber';
    }
    elsif ($Pattern =~ /<CI_Name>/) {
        return 'ConfigItemName';
    }
    else {
        return 'ConfigItemNumber';
    }
}

sub _UpdateDynamicFieldValues {
    my ( $Self, %Param ) = @_;

    my $FieldID                 = $Param{'ID'};
    my $DBObject                = $Param{'DBObject'};
    my $DynamicFieldValueObject = $Param{'DynamicFieldValueObject'};

    my @ObjectIDs;
    $DBObject->Prepare(
        SQL  => 'SELECT DISTINCT object_id FROM dynamic_field_value WHERE field_id = ?',
        Bind => [ \$FieldID ],
    );
    while ( my @Row = $DBObject->FetchrowArray() ) {
        push @ObjectIDs, $Row[0];
    }

    my $CountValueUpdates = 0;
    for my $ObjectID (@ObjectIDs) {

        my $ExistingValues = $DynamicFieldValueObject->ValueGet(
            FieldID  => $FieldID,
            ObjectID => $ObjectID
        );

        my @NewValues;
        my $IndexValue = 0;
        for my $ExistingValue ( $ExistingValues->@* ) {
            my $NewValue = {
                ValueText  => undef,
                ValueInt   => $ExistingValue->{ValueText},
            };
            if ( scalar $ExistingValues->@* > 1 ) {
                $NewValue->{IndexValue} = $IndexValue;
                $IndexValue++;
            }
            push @NewValues, $NewValue;
        }
            
        my $Success = $DynamicFieldValueObject->ValueSet(
            FieldID  => $FieldID,
            ObjectID => $ObjectID,
            Value    => \@NewValues,
            UserID   => 1,
        );

        if ( !$Success ) {
            $Self->Print("<red>Unable to set DF Value for object $ObjectID field $FieldID.</red>\n");
            return $Self->ExitCodeError();
        }

        $CountValueUpdates += scalar $ExistingValues->@*;
    }

    return $CountValueUpdates;
}

sub _GetDFTypeIDs {

    my ( $Self, %Param ) = @_;

    my $DBObject = $Param{'DBObject'};
    my $DFType   = $Param{'DFType'};

    my @Result;
    $DBObject->Prepare(
        SQL  => 'SELECT id FROM dynamic_field WHERE field_type = ?',
        Bind => [ \$DFType ],
    );

    while ( my @Row = $DBObject->FetchrowArray() ) {
        push @Result, $Row[0];
    }

    return @Result;
}

sub _ReportConstrictions {
    my ( $Self, %Param ) = @_;

    my $ConstrictionsList = $Param{'ConstrictionsList'};
    my $FileName = $Param{'FileName'};

    if (@{$ConstrictionsList}) {
        my $ConstrictionsStr = "object_id\tconstriction\n";
        for my $Constriction (@{$ConstrictionsList}) {
            $ConstrictionsStr .= $Constriction->{ID} . "\t" . $Constriction->{Constriction} . "\n";
        }
        my $Success = $Kernel::OM->Get('Kernel::System::Main')->FileWrite(
            Location => $FileName,
            Content  => \$ConstrictionsStr,
        );
        if (!$Success) {
            $Self->Print("<red>Could not write file.</red>\n");
        }
        my $Count = scalar @{$ConstrictionsList};
        $Self->Print("<yellow>Found $Count constrictions, they require manual configuration. Please check the report file '$FileName'.</yellow>\n");
    }
    else {
        $Self->Print("No constrictions were found.\n");
    }
}

1;

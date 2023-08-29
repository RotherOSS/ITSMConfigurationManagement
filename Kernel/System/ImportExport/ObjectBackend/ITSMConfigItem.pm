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

package Kernel::System::ImportExport::ObjectBackend::ITSMConfigItem;

use v5.24;
use strict;
use warnings;
use namespace::autoclean;
use utf8;

# core modules

# CPAN modules

# OTOBO modules
use Kernel::Language qw(Translatable);
use Kernel::System::VariableCheck qw(IsStringWithData IsArrayRefWithData);

our @ObjectDependencies = (
    'Kernel::Config',
    'Kernel::System::GeneralCatalog',
    'Kernel::System::ITSMConfigItem',
    'Kernel::System::ImportExport',
    'Kernel::System::Log',
);

=head1 NAME

Kernel::System::ImportExport::ObjectBackend::ITSMConfigItem - import/export backend for ITSMConfigItem

=head1 DESCRIPTION

All functions to import and export ITSM config items.

=head1 PUBLIC INTERFACE

=head2 new()

create an object

    use Kernel::System::ObjectManager;

    local $Kernel::OM = Kernel::System::ObjectManager->new();
    my $BackendObject = $Kernel::OM->Get('Kernel::System::ImportExport::ObjectBackend::ITSMConfigItem');

=cut

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    return bless {}, $Type;
}

=head2 ObjectAttributesGet()

get the object attributes of an object as a ref to an array of hash references

    my $Attributes = $ObjectBackend->ObjectAttributesGet(
        UserID => 1,
    );

=cut

sub ObjectAttributesGet {
    my ( $Self, %Param ) = @_;

    # check needed object
    if ( !$Param{UserID} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => 'Need UserID!',
        );

        return;
    }

    # get class list
    my $ClassList = $Kernel::OM->Get('Kernel::System::GeneralCatalog')->ItemList(
        Class => 'ITSM::ConfigItem::Class',
    );

    my $Attributes = [
        {
            Key   => 'ClassID',
            Name  => Translatable('Class'),
            Input => {
                Type         => 'Selection',
                Data         => $ClassList,
                Required     => 1,
                Translation  => 0,
                PossibleNone => 1,
            },
        },
        {
            Key   => 'CountMax',
            Name  => Translatable('Maximum number of one element'),
            Input => {
                Type         => 'Text',
                ValueDefault => '10',
                Required     => 1,
                Regex        => qr{ \A \d+ \z }xms,
                Translation  => 0,
                Size         => 5,
                MaxLength    => 5,
                DataType     => 'IntegerBiggerThanZero',
            },
        },
        {
            Key   => 'EmptyFieldsLeaveTheOldValues',
            Name  => Translatable('Empty fields indicate that the current values are kept'),
            Input => {
                Type => 'Checkbox',
            },
        },
    ];

    return $Attributes;
}

=head2 MappingObjectAttributesGet()

gets the mapping attributes of an object as reference to an array of hash references.

    my $Attributes = $ObjectBackend->MappingObjectAttributesGet(
        TemplateID => 123,
        UserID     => 1,
    );

Returns:

    my $Attributes = [
        {
          Input => {
                     Data => [
                       { Key => "Number", Value => "Number" },
                       { Key => "Name", Value => "Name" },
                       { Key => "DeplState", Value => "Deployment State" },
                       { Key => "InciState", Value => "Incident State" },
                       {
                         Key => "NamespaceBoden-Bodenfarbe::1",
                         Value => "NamespaceBoden-Bodenfarbe::1",
                       },
                       {
                         Key => "NamespaceBoden-Bodenfarbe::2",
                         Value => "NamespaceBoden-Bodenfarbe::2",
                       },
                       {
                         Key => "NamespaceBoden-Bodenfarbe::3",
                         Value => "NamespaceBoden-Bodenfarbe::3",
                       },
                       {
                         Key => "NamespaceBoden-Bodenfarbe::4",
                         Value => "NamespaceBoden-Bodenfarbe::4",
                       },
                       {
                         Key => "NamespaceBoden-Bodenfarbe::5",
                         Value => "NamespaceBoden-Bodenfarbe::5",
                       },
                       {
                         Key => "NamespaceBoden-Bodenfarbe::6",
                         Value => "NamespaceBoden-Bodenfarbe::6",
                       },
                       {
                         Key => "NamespaceBoden-Bodenfarbe::7",
                         Value => "NamespaceBoden-Bodenfarbe::7",
                       },
                       {
                         Key => "NamespaceBoden-Bodenfarbe::8",
                         Value => "NamespaceBoden-Bodenfarbe::8",
                       },
                       {
                         Key => "NamespaceBoden-Bodenfarbe::9",
                         Value => "NamespaceBoden-Bodenfarbe::9",
                       },
                       {
                         Key => "NamespaceBoden-Bodenfarbe::10",
                         Value => "NamespaceBoden-Bodenfarbe::10",
                       },
                     ],
                     PossibleNone => 1,
                     Required => 1,
                     Translation => 0,
                     Type => "Selection",
                   },
          Key   => "Key",
          Name  => "Key",
        },
        {
          Input => { Type => "Checkbox" },
          Key   => "Identifier",
          Name  => "Identifier",
        },
    ];

=cut

sub MappingObjectAttributesGet {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Argument (qw(TemplateID UserID)) {
        if ( !$Param{$Argument} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Argument!",
            );

            return;
        }
    }

    my $ImportExportObject = $Kernel::OM->Get('Kernel::System::ImportExport');

    # get object data
    my $ObjectData = $ImportExportObject->ObjectDataGet(
        TemplateID => $Param{TemplateID},
        UserID     => $Param{UserID},
    );

    return [] unless $ObjectData;
    return [] unless ref $ObjectData eq 'HASH';
    return [] unless $ObjectData->{ClassID};

    # get definition for the config item class
    my $Definition = $Kernel::OM->Get('Kernel::System::ITSMConfigItem')->DefinitionGet(
        ClassID => $ObjectData->{ClassID},
    );

    # no error handling
    return unless $Definition;
    return unless ref $Definition eq 'HASH';
    return unless $Definition->{DynamicFieldRef};
    return unless ref $Definition->{DynamicFieldRef} eq 'HASH';

    my @Elements = (
        {
            Key   => 'Number',
            Value => Translatable('Number'),
        },
        {
            Key   => 'Name',
            Value => Translatable('Name'),
        },
        {
            Key   => 'DeplState',
            Value => Translatable('Deployment State'),
        },
        {
            Key   => 'InciState',
            Value => Translatable('Incident State'),
        },
    );

    # add elements
    push @Elements, $Self->_MappingObjectAttributesGet(
        DynamicFieldRef => $Definition->{DynamicFieldRef},    # page layout is ignored here
        ElementList     => \@Elements,                        # TODO: return the elements
        CountMaxLimit   => $ObjectData->{CountMax} || 10,
    );

    return [
        {
            Key   => 'Key',
            Name  => Translatable('Key'),
            Input => {
                Type         => 'Selection',
                Data         => \@Elements,
                Required     => 1,
                Translation  => 0,
                PossibleNone => 1,
            },
        },
        {
            Key   => 'Identifier',
            Name  => Translatable('Identifier'),
            Input => {
                Type => 'Checkbox',
            },
        },
    ];
}

=head2 SearchAttributesGet()

get the search object attributes of an object as array/hash reference

    my $AttributeList = $ObjectBackend->SearchAttributesGet(
        TemplateID => 123,
        UserID     => 1,
    );

=cut

sub SearchAttributesGet {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Argument (qw(TemplateID UserID)) {
        if ( !$Param{$Argument} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Argument!",
            );

            return;
        }
    }

    my $ImportExportObject = $Kernel::OM->Get('Kernel::System::ImportExport');

    # get object data
    my $ObjectData = $ImportExportObject->ObjectDataGet(
        TemplateID => $Param{TemplateID},
        UserID     => $Param{UserID},
    );

    return [] unless $ObjectData;
    return [] unless ref $ObjectData eq 'HASH';
    return [] unless $ObjectData->{ClassID};

    # get definition
    my $Definition = $Kernel::OM->Get('Kernel::System::ITSMConfigItem')->DefinitionGet(
        ClassID => $ObjectData->{ClassID},
    );

    return [] unless $Definition;
    return [] unless ref $Definition eq 'HASH';
    return [] unless $Definition->{DynamicFieldRef};
    return [] unless ref $Definition->{DynamicFieldRef} eq 'HASH';

    # get deployment and incident state lists, ignoring errors
    my $DeplStateList = $Kernel::OM->Get('Kernel::System::GeneralCatalog')->ItemList(
        Class => 'ITSM::ConfigItem::DeploymentState',
    );

    return [] unless defined $DeplStateList;

    my $InciStateList = $Kernel::OM->Get('Kernel::System::GeneralCatalog')->ItemList(
        Class => 'ITSM::Core::IncidentState',
    );

    return [] unless defined $InciStateList;

    my @Attributes = (
        {
            Key   => 'Number',
            Name  => Translatable('Number'),
            Input => {
                Type      => 'Text',
                Size      => 80,
                MaxLength => 255,
            },
        },
        {
            Key   => 'Name',
            Name  => Translatable('Name'),
            Input => {
                Type      => 'Text',
                Size      => 80,
                MaxLength => 255,
            },
        },
        {
            Key   => 'DeplStateIDs',
            Name  => Translatable('Deployment State'),
            Input => {
                Type        => 'Selection',
                Data        => $DeplStateList,
                Translation => 1,
                Size        => 5,
                Multiple    => 1,
            },
        },
        {
            Key   => 'InciStateIDs',
            Name  => Translatable('Incident State'),
            Input => {
                Type        => 'Selection',
                Data        => $InciStateList,
                Translation => 1,
                Size        => 5,
                Multiple    => 1,
            },
        },
    );

    # add dynamic field attributes
    push @Attributes, $Self->_DFSearchAttributesGet(
        DynamicFieldRef => $Definition->{DynamicFieldRef},
    );

    return \@Attributes;
}

=head2 ExportDataGet()

get export data as C<2D-array-hash> reference

    my $ExportData = $ObjectBackend->ExportDataGet(
        TemplateID => 123,
        UserID     => 1,
    );

=cut

sub ExportDataGet {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Argument (qw(TemplateID UserID)) {
        if ( !$Param{$Argument} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Argument!",
            );

            return;
        }
    }

    my $ImportExportObject = $Kernel::OM->Get('Kernel::System::ImportExport');

    # get object data
    my $ObjectData = $ImportExportObject->ObjectDataGet(
        TemplateID => $Param{TemplateID},
        UserID     => $Param{UserID},
    );

    # check object data
    if ( !$ObjectData || ref $ObjectData ne 'HASH' ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "No object data found for the template id $Param{TemplateID}",
        );

        return;
    }

    # check the class id from the template
    {
        my $ClassList = $Kernel::OM->Get('Kernel::System::GeneralCatalog')->ItemList(
            Class => 'ITSM::ConfigItem::Class',
        );

        return unless defined $ClassList;

        if ( !$ObjectData->{ClassID} || !$ClassList->{ $ObjectData->{ClassID} } ) {

            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "No valid class id found for the template id $Param{TemplateID}",
            );

            return;
        }
    }

    # get the IDs for the mapping in this template
    my $MappingIDs = $ImportExportObject->MappingList(
        TemplateID => $Param{TemplateID},
        UserID     => $Param{UserID},
    );

    # check the mapping list
    if ( !$MappingIDs || ref $MappingIDs ne 'ARRAY' || !$MappingIDs->@* ) {

        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "No valid mapping list found for the template id $Param{TemplateID}",
        );

        return;
    }

    # create the mapping object list
    my @MappingObjectList;
    for my $MappingID ( $MappingIDs->@* ) {

        # get mapping object data
        my $MappingObjectData = $ImportExportObject->MappingObjectDataGet(
            MappingID => $MappingID,
            UserID    => $Param{UserID},
        );

        # check mapping object data
        if ( !$MappingObjectData || ref $MappingObjectData ne 'HASH' ) {

            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "No valid mapping list found for the template id $Param{TemplateID}",
            );

            return;
        }

        push @MappingObjectList, $MappingObjectData;
    }

    # get search data
    my $SearchData = $ImportExportObject->SearchDataGet(
        TemplateID => $Param{TemplateID},
        UserID     => $Param{UserID},
    );

    return unless $SearchData;
    return unless ref $SearchData eq 'HASH';

    # get deployment state list, for translating the numeric IDs into readable names
    my $DeplStateList = $Kernel::OM->Get('Kernel::System::GeneralCatalog')->ItemList(
        Class => 'ITSM::ConfigItem::DeploymentState',
    );
    if ( !$DeplStateList || ref $DeplStateList ne 'HASH' ) {

        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "Can't get the general catalog list ITSM::ConfigItem::DeploymentState!",
        );

        return;
    }

    # get incident state list, for translating the numeric IDs into readable names
    my $InciStateList = $Kernel::OM->Get('Kernel::System::GeneralCatalog')->ItemList(
        Class => 'ITSM::Core::IncidentState',
    );
    if ( !$InciStateList || ref $InciStateList ne 'HASH' ) {

        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "Can't get the general catalog list ITSM::Core::IncidentState!",
        );

        return;
    }

    # get current definition of this class
    my $Definition = $Kernel::OM->Get('Kernel::System::ITSMConfigItem')->DefinitionGet(
        ClassID => $ObjectData->{ClassID},
        UserID  => $Param{UserID},
    );

    my %SearchParams;

    # add number to the search params
    if ( $SearchData->{Number} ) {
        $SearchParams{Number} = delete $SearchData->{Number};
    }

    # add name to the search params
    if ( $SearchData->{Name} ) {
        $SearchParams{Name} = delete $SearchData->{Name};
    }

    # add deployment state to the search params
    if ( $SearchData->{DeplStateIDs} ) {
        my @DeplStateIDs = split /#####/, $SearchData->{DeplStateIDs};
        $SearchParams{DeplStateIDs} = \@DeplStateIDs;
        delete $SearchData->{DeplStateIDs};
    }

    # add incident state to the search params
    if ( $SearchData->{InciStateIDs} ) {
        my @InciStateIDs = split /#####/, $SearchData->{InciStateIDs};
        $SearchParams{InciStateIDs} = \@InciStateIDs;
        delete $SearchData->{InciStateIDs};
    }

    # add all XML data to the search params
    my %DFSearchParams = $Self->_DFSearchDataPrepare(
        DynamicFieldRef => $Definition->{DynamicFieldRef},
        SearchData      => $SearchData,
    );
    @SearchParams{ keys %DFSearchParams } = values %DFSearchParams;

    # search the config items
    my @ConfigItemIDs = $Kernel::OM->Get('Kernel::System::ITSMConfigItem')->ConfigItemSearch(
        %SearchParams,
        ClassIDs              => [ $ObjectData->{ClassID} ],
        PreviousVersionSearch => 0,
        UserID                => $Param{UserID},
        Result                => 'ARRAY',
    );

    my @ExportData;
    CONFIGITEMID:
    for my $ConfigItemID (@ConfigItemIDs) {

        # get the latest version of the config item, including the dynamic fields
        my $ConfigItem = $Kernel::OM->Get('Kernel::System::ITSMConfigItem')->ConfigItemGet(
            ConfigItemID  => $ConfigItemID,
            DynamicFields => 1,
        );

        next CONFIGITEMID unless $ConfigItem;
        next CONFIGITEMID unless ref $ConfigItem eq 'HASH';

        # add data to the export data array
        my @Item;
        MAPPINGOBJECT:
        for my $MappingObject (@MappingObjectList) {

            # extract key
            my $Key = $MappingObject->{Key};

            # handle empty key
            if ( !$Key ) {
                push @Item, '';

                next MAPPINGOBJECT;
            }

            # handle config item number
            if ( $Key eq 'Number' ) {
                push @Item, $ConfigItem->{Number};

                next MAPPINGOBJECT;
            }

            # handle current config item name
            if ( $Key eq 'Name' ) {
                push @Item, $ConfigItem->{Name};

                next MAPPINGOBJECT;
            }

            # handle deployment state
            if ( $Key eq 'DeplState' ) {
                $ConfigItem->{DeplStateID} ||= 'DUMMY';
                push @Item, $DeplStateList->{ $ConfigItem->{DeplStateID} };

                next MAPPINGOBJECT;
            }

            # handle incident state
            if ( $Key eq 'InciState' ) {
                $ConfigItem->{InciStateID} ||= 'DUMMY';
                push @Item, $InciStateList->{ $ConfigItem->{InciStateID} };

                next MAPPINGOBJECT;
            }

            # All other attributes indicate dynamic fields.
            # This gets whatever ConfigItemGet() puts into the object. E.g. for GeneralCatalog dynamic fields
            # we get the item ID into the general catalog. This is fine for Import/Export, but not really human readable.
            # Note that things like the incident state are looked up.

            # The Key encodes some extra information.
            # Note that the indexes start at 1 in the key names
            # TODO: support for Set
            my ( $DFName, $IndexValue ) = split /::/, $Key;
            my $Value = $ConfigItem->{"DynamicField_$DFName"};

            if ( !defined $Value ) {
                push @Item, '';

                next MAPPINGOBJECT;
            }

            if ( ref $Value eq 'ARRAY' ) {
                if ( $IndexValue >= 1 ) {
                    push @Item, $Value->[ $IndexValue - 1 ] // '';
                }
                else {
                    push @Item, '';
                }

                next MAPPINGOBJECT;
            }

            # else
            {
                push @Item, $Value;

                next MAPPINGOBJECT;
            }
        }

        push @ExportData, \@Item;
    }

    return \@ExportData;
}

=head2 ImportDataSave()

imports a single entity of the import data. The C<TemplateID> points to the definition
of the current import. C<ImportDataRow> holds the data. C<Counter> is only used in
error messages, for indicating which item was not imported successfully.

The current version of the config item will never be deleted. When there are no
changes in the data, the import will be skipped. When there is new or changed data,
then a new config item or a new version is created.

In the case of changed data, the new version of the config item will contain the
attributes of the C<ImportDataRow> plus the old attributes that are
not part of the import definition.
Thus ImportDataSave() guarantees to not overwrite undeclared attributes.

The behavior when imported attributes are empty depends on the setting in the object data.
When C<EmptyFieldsLeaveTheOldValues> is not set, then empty values will wipe out
the old data. This is the default behavior. When C<EmptyFieldsLeaveTheOldValues> is set,
then empty values will leave the old values.

The decision what constitute an empty value is a bit hairy.
Here are the rules.
Fields that are not even mentioned in the Import definition are empty. These are the 'not defined' fields.
Empty strings and undefined values constitute empty fields.
Fields with with only one or more whitespace characters are not empty.
Fields with the digit '0' are not empty.

    my ( $ConfigItemID, $RetCode ) = $ObjectBackend->ImportDataSave(
        TemplateID    => 123,
        ImportDataRow => $ArrayRef,
        Counter       => 367,
        UserID        => 1,
    );

An empty C<ConfigItemID> indicates failure. Otherwise it indicates the
location of the imported data.
C<RetCode> is either 'Created', 'Updated' or 'Skipped'. 'Created' means that a new
config item has been created. 'Updated' means that a new version has been added to
an existing config item. 'Skipped' means that no new version has been created,
as the new data is identical to the latest version of an existing config item.

No codes have yet been defined for the failure case.

=cut

sub ImportDataSave {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Argument (qw(TemplateID ImportDataRow Counter UserID)) {
        if ( !$Param{$Argument} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Argument!",
            );

            return;
        }
    }

    # check import data row
    if ( ref $Param{ImportDataRow} ne 'ARRAY' ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  =>
                "Can't import entity $Param{Counter}: "
                . "ImportDataRow must be an array reference",
        );

        return;
    }

    my $ImportExportObject = $Kernel::OM->Get('Kernel::System::ImportExport');

    # get object data
    my $ObjectData = $ImportExportObject->ObjectDataGet(
        TemplateID => $Param{TemplateID},
        UserID     => $Param{UserID},
    );

    # check object data
    if ( !$ObjectData || ref $ObjectData ne 'HASH' ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  =>
                "Can't import entity $Param{Counter}: "
                . "No object data found for the template id '$Param{TemplateID}'",
        );

        return;
    }

    # just for convenience
    my $EmptyFieldsLeaveTheOldValues = $ObjectData->{EmptyFieldsLeaveTheOldValues};

    # check the class id
    {
        my $ClassList = $Kernel::OM->Get('Kernel::System::GeneralCatalog')->ItemList(
            Class => 'ITSM::ConfigItem::Class',
        );
        if ( !$ClassList || ref $ClassList ne 'HASH' ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  =>
                    "Can't import entity $Param{Counter}: "
                    . "Can't get the general catalog list ITSM::ConfigItem::Class",
            );

            return;
        }

        if ( !$ObjectData->{ClassID} || !$ClassList->{ $ObjectData->{ClassID} } ) {

            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  =>
                    "Can't import entity $Param{Counter}: "
                    . "No class found for the template id '$Param{TemplateID}'",
            );

            return;
        }
    }

    # get the mapping list
    my $MappingIDs = $ImportExportObject->MappingList(
        TemplateID => $Param{TemplateID},
        UserID     => $Param{UserID},
    );

    # check the mapping list
    if ( !$MappingIDs || ref $MappingIDs ne 'ARRAY' || !@{$MappingIDs} ) {

        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  =>
                "Can't import entity $Param{Counter}: "
                . "No valid mapping list found for the template id '$Param{TemplateID}'",
        );

        return;
    }

    # create the mapping object list
    # TODO: why is this called for every row of the import file ?
    my @MappingObjectList;
    for my $MappingID ( $MappingIDs->@* ) {

        # get mapping object data
        my $MappingObjectData = $ImportExportObject->MappingObjectDataGet(
            MappingID => $MappingID,
            UserID    => $Param{UserID},
        );

        # check mapping object data
        if ( !$MappingObjectData || ref $MappingObjectData ne 'HASH' ) {

            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  =>
                    "Can't import entity $Param{Counter}: "
                    . "No mapping object data found for the mapping id '$MappingID'",
            );

            return;
        }

        push @MappingObjectList, $MappingObjectData;
    }

    # check and remember the Identifiers
    # the Identifiers identify the config item that should be updated
    my %Identifier;
    my $RowIndex = 0;
    MAPPINGOBJECTDATA:
    for my $MappingObjectData (@MappingObjectList) {

        next MAPPINGOBJECTDATA unless $MappingObjectData->{Identifier};

        # check if identifier already exists
        if ( $Identifier{ $MappingObjectData->{Key} } ) {

            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  =>
                    "Can't import entity $Param{Counter}: "
                    . "'$MappingObjectData->{Key}' has been used multiple times as an identifier",
            );

            return;
        }

        # set identifier value
        $Identifier{ $MappingObjectData->{Key} } = $Param{ImportDataRow}->[$RowIndex];

        next MAPPINGOBJECTDATA if $MappingObjectData->{Key} && $Param{ImportDataRow}->[$RowIndex];

        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  =>
                "Can't import entity $Param{Counter}: "
                . "Identifier field is empty",
        );

        return;
    }
    continue {
        $RowIndex++;
    }

    # get deployment state list
    my $DeplStateList = $Kernel::OM->Get('Kernel::System::GeneralCatalog')->ItemList(
        Class => 'ITSM::ConfigItem::DeploymentState',
    );
    if ( !$DeplStateList || ref $DeplStateList ne 'HASH' ) {

        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  =>
                "Can't import entity $Param{Counter}: "
                . "Can't get the general catalog list ITSM::ConfigItem::DeploymentState!",
        );

        return;
    }

    # reverse the deployment state list
    my %DeplStateListReverse = reverse $DeplStateList->%*;

    # get incident state list
    my $InciStateList = $Kernel::OM->Get('Kernel::System::GeneralCatalog')->ItemList(
        Class => 'ITSM::Core::IncidentState',
    );

    # check incident state list
    if ( !$InciStateList || ref $InciStateList ne 'HASH' ) {

        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  =>
                "Can't import entity $Param{Counter}: "
                . "Can't get the general catalog list ITSM::Core::IncidentState",
        );

        return;
    }

    # reverse the incident state list
    my %InciStateListReverse = reverse $InciStateList->%*;

    # get current definition of this class
    my $Definition = $Kernel::OM->Get('Kernel::System::ITSMConfigItem')->DefinitionGet(
        ClassID => $ObjectData->{ClassID},
        UserID  => $Param{UserID},
    );

    # check definition data
    if ( !$Definition || ref $Definition ne 'HASH' ) {

        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  =>
                "Can't import entity $Param{Counter}: "
                . "Can't get the definition of class id $ObjectData->{ClassID}",
        );

        return;
    }

    # try to get the config item id when there is at least one identifier
    my $ConfigItemID;
    if (%Identifier) {

        my %SearchParams;

        # add number to the search params
        if ( $Identifier{Number} ) {
            $SearchParams{Number} = delete $Identifier{Number};
        }

        # add name to the search params
        if ( $Identifier{Name} ) {
            $SearchParams{Name} = delete $Identifier{Name};
        }

        # add deployment state to the search params
        if ( $Identifier{DeplState} ) {

            # extract deployment state id
            my $DeplStateID = $DeplStateListReverse{ $Identifier{DeplState} } || '';

            if ( !$DeplStateID ) {

                $Kernel::OM->Get('Kernel::System::Log')->Log(
                    Priority => 'error',
                    Message  =>
                        "Can't import entity $Param{Counter}: "
                        . "The deployment state '$Identifier{DeplState}' is invalid",
                );

                return;
            }

            $SearchParams{DeplStateIDs} = [$DeplStateID];
            delete $Identifier{DeplState};
        }

        # add incident state to the search params
        if ( $Identifier{InciState} ) {

            # extract incident state id
            my $InciStateID = $InciStateListReverse{ $Identifier{InciState} } || '';

            if ( !$InciStateID ) {

                $Kernel::OM->Get('Kernel::System::Log')->Log(
                    Priority => 'error',
                    Message  =>
                        "Can't import entity $Param{Counter}: "
                        . "The incident state '$Identifier{InciState}' is invalid",
                );

                return;
            }

            $SearchParams{InciStateIDs} = [$InciStateID];
            delete $Identifier{InciState};
        }

        # add all XML data to the search params
        my %DFImportSearchParams = $Self->_DFImportSearchDataPrepare(
            DynamicFieldRef => $Definition->{DynamicFieldRef},
            Identifier      => \%Identifier,
        );
        @SearchParams{ keys %DFImportSearchParams } = values %DFImportSearchParams;

        # search existing config item with the same identifiers
        ( $ConfigItemID, my @OtherConfigItemIDs ) = $Kernel::OM->Get('Kernel::System::ITSMConfigItem')->ConfigItemSearch(
            %SearchParams,
            ClassIDs              => [ $ObjectData->{ClassID} ],
            PreviousVersionSearch => 0,
            UsingWildcards        => 0,
            UserID                => $Param{UserID},
            Result                => 'ARRAY',
        );

        if (@OtherConfigItemIDs) {

            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  =>
                    "Can't import entity $Param{Counter}: "
                    . "Identifier fields NOT unique!",
            );

            return;
        }
    }

    # get version data of the config item
    my $VersionData = {};
    if ($ConfigItemID) {

        # get latest version
        $VersionData = $Kernel::OM->Get('Kernel::System::ITSMConfigItem')->ConfigItemGet(
            ConfigItemID  => $ConfigItemID,
            DynamicFields => 1,
        );
    }

    my %MappingObjectKeyData = map { $_->{Key} => 1 } @MappingObjectList;

    # Check if current definition of this class has required attribute which does not exist in mapping list.
    DF_NAME:
    for my $DFName ( sort keys $Param{DynamicFieldRef}->%* ) {
        my $DynamicFieldConfig = $Param{DynamicFieldRef}->{$DFName};

        next DF_NAME unless $DynamicFieldConfig->{Required};    # TODO: is this correct ???

        my $Key = $DynamicFieldConfig->{Name};

        next DF_NAME if $MappingObjectKeyData{$Key};

        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  =>
                "Can't import entity $Param{Counter}: "
                . "Attribute '$Key' is required, but does not exist in mapping list!",
        );

        return;
    }

    # set up fields in VersionData and in the XML attributes
    my %NewVersionData;
    $RowIndex = 0;
    for my $MappingObjectData (@MappingObjectList) {

        # just for convenience
        my $Key   = $MappingObjectData->{Key};
        my $Value = $Param{ImportDataRow}->[ $RowIndex++ ];

        if ( $Key eq 'Number' ) {

            # do nothing
            # Import does not override the config item number
        }
        elsif ( $Key eq 'Name' ) {

            if ( $EmptyFieldsLeaveTheOldValues && ( !defined $Value || $Value eq '' ) ) {

                # do nothing, keep the old value
            }
            else {
                if ( !$Value ) {
                    $Kernel::OM->Get('Kernel::System::Log')->Log(
                        Priority => 'error',
                        Message  =>
                            "Can't import entity $Param{Counter}: "
                            . "The name '$Value' is invalid!",
                    );

                    return;
                }

                $VersionData->{$Key} = $Value;
            }
        }
        elsif ( $Key eq 'DeplState' ) {

            if ( $EmptyFieldsLeaveTheOldValues && ( !defined $Value || $Value eq '' ) ) {

                # do nothing, keep the old value
            }
            else {

                # extract deployment state id
                my $DeplStateID = $DeplStateListReverse{$Value} || '';
                if ( !$DeplStateID ) {
                    $Kernel::OM->Get('Kernel::System::Log')->Log(
                        Priority => 'error',
                        Message  =>
                            "Can't import entity $Param{Counter}: "
                            . "The deployment state '$Value' is invalid!",
                    );

                    return;
                }

                $VersionData->{DeplStateID} = $DeplStateID;
            }
        }
        elsif ( $Key eq 'InciState' ) {

            if ( $EmptyFieldsLeaveTheOldValues && ( !defined $Value || $Value eq '' ) ) {

                # do nothing, keep the old value
            }
            else {

                # extract the deployment state id
                my $InciStateID = $InciStateListReverse{$Value} || '';
                if ( !$InciStateID ) {
                    $Kernel::OM->Get('Kernel::System::Log')->Log(
                        Priority => 'error',
                        Message  =>
                            "Can't import entity $Param{Counter}: "
                            . "The incident state '$Value' is invalid!",
                    );

                    return;
                }

                $VersionData->{InciStateID} = $InciStateID;
            }
        }
        else {

            # handle xml data
            $NewVersionData{$Key} = $Value;
        }
    }

    # Edit $VersionData, so that the values in NewVersionData take precedence.
    my $MergeOk = $Self->_DFImportDataMerge(
        DynamicFieldRef              => $Definition->{DynamicFieldRef},
        VersionData                  => $VersionData,
        NewVersionData               => \%NewVersionData,
        EmptyFieldsLeaveTheOldValues => $EmptyFieldsLeaveTheOldValues,
    );

    # bail out, when the was a problem in _DFImportDataMerge()
    if ( !$MergeOk ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "Can't import entity $Param{Counter}: Could not prepare the input!",
        );

        return;
    }

    my $RetCode = $ConfigItemID ? Translatable('Changed') : Translatable('Created');

    # check if the feature to check for a unique name is enabled
    if (
        IsStringWithData( $VersionData->{Name} )
        && $Kernel::OM->Get('Kernel::Config')->Get('UniqueCIName::EnableUniquenessCheck')
        )
    {
        if ( $Kernel::OM->Get('Kernel::Config')->{Debug} > 0 ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'debug',
                Message  => "Checking for duplicate names (ClassID: $ObjectData->{ClassID}, "
                    . "Name: $VersionData->{Name}, ConfigItemID: " . $ConfigItemID || 'NEW' . ')',
            );
        }

        my $NameDuplicates = $Kernel::OM->Get('Kernel::System::ITSMConfigItem')->UniqueNameCheck(
            ConfigItemID => $ConfigItemID || 'NEW',
            ClassID      => $ObjectData->{ClassID},
            Name         => $VersionData->{Name},
        );

        # stop processing if the name is not unique
        if ( IsArrayRefWithData($NameDuplicates) ) {

            # build a string of all duplicate IDs
            my $NameDuplicatesString = join ', ', @{$NameDuplicates};

            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  =>
                    "The name $VersionData->{Name} is already in use by the ConfigItemID(s): "
                    . $NameDuplicatesString,
            );

            # set the return code to also include the duplicate name
            $RetCode = "DuplicateName '$VersionData->{Name}'";

            # return undef for the config item id so it will be counted as 'Failed'
            return undef, $RetCode;    ## no critic qw(Subroutines::ProhibitExplicitReturnUndef)
        }
    }

    if ($ConfigItemID) {

        # the specified config item already exists
        # get id of the latest version, for checking later whether a version was created
        my $VersionList = $Kernel::OM->Get('Kernel::System::ITSMConfigItem')->VersionList(
            ConfigItemID => $ConfigItemID,
        ) || [];
        my $LatestVersionID = $VersionList->[-1] // 0;

        # add new version
        my $VersionID = $Kernel::OM->Get('Kernel::System::ITSMConfigItem')->VersionAdd(
            ConfigItemID => $ConfigItemID,
            Name         => $VersionData->{Name},
            DefinitionID => $Definition->{DefinitionID},
            DeplStateID  => $VersionData->{DeplStateID},
            InciStateID  => $VersionData->{InciStateID},
            UserID       => $Param{UserID},
        );

        if ( !$VersionID ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  =>
                    "Can't import entity $Param{Counter}: "
                    . "Error when adding the new config item version.",
            );

            return;
        }

        # The import was successful as we got a version id

        # When VersionAdd() returns the previous latest version ID, we know that
        # no new version has been added.
        # The import of this config item has been skipped.
        if ( $LatestVersionID && $VersionID == $LatestVersionID ) {
            $RetCode = Translatable('Skipped');
        }

        return $ConfigItemID, $RetCode;
    }
    else {

        # no config item was found, so add new config item
        my $ConfigItemID = $Kernel::OM->Get('Kernel::System::ITSMConfigItem')->ConfigItemAdd(
            ClassID      => $ObjectData->{ClassID},
            Name         => $VersionData->{Name},
            DefinitionID => $Definition->{DefinitionID},
            DeplStateID  => $VersionData->{DeplStateID},
            InciStateID  => $VersionData->{InciStateID},
            UserID       => $Param{UserID},
            UserID       => $Param{UserID},

            # TODO: dynamic fields
        );

        # check the new config item id
        if ( !$ConfigItemID ) {

            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  =>
                    "Can't import entity $Param{Counter}: "
                    . "Error when adding the new config item.",
            );

            return;
        }

        return $ConfigItemID, $RetCode;
    }
}

=head1 INTERNAL INTERFACE

=head2 _MappingObjectAttributesGet()

recursive function for MappingObjectAttributesGet().
Definitions for object attributes are passed in C<Definition>.
The new object attributes are appended to C<ElementList>.
C<CountMaxLimit> limits the max length of importable arrays.

    push @Elements, $ObjectBackend->_MappingObjectAttributesGet(
        DynamicFieldRef => $HashRef,
        CountMaxLimit   => 10,
    );

=cut

sub _MappingObjectAttributesGet {
    my ( $Self, %Param ) = @_;

    return unless $Param{CountMaxLimit};
    return unless ref $Param{CountMaxLimit} eq '';
    return unless $Param{DynamicFieldRef};
    return unless ref $Param{DynamicFieldRef} eq 'HASH';

    my @Elements;
    for my $DFName ( sort keys $Param{DynamicFieldRef}->%* ) {
        my $DynamicFieldConfig = $Param{DynamicFieldRef}->{$DFName};
        my $DFDetails          = $DynamicFieldConfig->{Config};

        # limit the length of importable arrays, even if more elements can be set via the GUI
        my $CountMax = ( $DFDetails->{Multiselect} || $DFDetails->{MultiValue} ) ? $Param{CountMaxLimit} : 1;

        COUNT:
        for my $Count ( 1 .. $CountMax ) {

            # create key string, including a potential prefix and a potential count
            my $Key = join '::',
                ( $Param{KeyPrefix} || () ),
                $DFName,
                ( $CountMax == 1 ? () : $Count );

            # create key string, including a potential prefix and a potential count
            my $Value = join '::',
                ( $Param{ValuePrefix} || () ),
                $DFName,
                ( $CountMax == 1 ? () : $Count );

            # add row
            push @Elements,
                {
                    Key   => $Key,
                    Value => $Value,
                };

            # TODO: support for Set
            #next COUNT unless $Item->{Sub};
            next COUNT if 1;

            # start recursion
            push @Elements, $Self->_MappingObjectAttributesGet(
                DynamicFieldRef => $DFDetails->{Sub},               # Sub is now handled in Set
                KeyPrefix       => $Key,
                ValuePrefix     => $Value,
                CountMaxLimit   => $Param{CountMaxLimit} || '10',
            );
        }
    }

    return @Elements;
}

=head2 _DFSearchAttributesGet()

recursive function for SearchAttributesGet()

    $ObjectBackend->_DFSearchAttributesGet(
        XMLDefinition => $ArrayRef,
        AttributeList => $ArrayRef,
    );

=cut

sub _DFSearchAttributesGet {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    return unless $Param{DynamicFieldRef};
    return unless ref $Param{DynamicFieldRef} eq 'HASH';

    my @Attributes;
    DF_NAME:
    for my $DFName ( sort keys $Param{DynamicFieldRef}->%* ) {
        my $DynamicFieldConfig = $Param{DynamicFieldRef}->{$DFName};

        # create key string, including a potential prefix
        my $Key = join '::',
            ( $Param{KeyPrefix} || () ),
            $DynamicFieldConfig->{Name};

        # create name string, including a potential prefix
        my $Name = join '::',
            ( $Param{NamePrefix} || () ),
            $DynamicFieldConfig->{Label};

        # add attribute, if marked as searchable

        # TODO: determine whether DF is searchable: $DynamicFieldConfig->{Searchable}
        # TODO: use search field from dynamic field driver
        if (1) {

            if ( $DynamicFieldConfig->{Input}->{Type} eq 'Text' || $DynamicFieldConfig->{Input}->{Type} eq 'TextArea' ) {
                push @Attributes,
                    {
                        Key   => $Key,
                        Name  => $Name,
                        Input => {
                            Type        => 'Text',
                            Translation => $DynamicFieldConfig->{Input}->{Input}->{Translation},
                            Size        => $DynamicFieldConfig->{Input}->{Input}->{Size} || 60,
                            MaxLength   => $DynamicFieldConfig->{Input}->{Input}->{MaxLength},
                        },
                    };
            }
            elsif ( $DynamicFieldConfig->{FieldType} eq 'GeneralCatalog' ) {

                # get general catalog list
                my $GeneralCatalogList = $Kernel::OM->Get('Kernel::System::GeneralCatalog')->ItemList(
                    Class => $DynamicFieldConfig->{Config}->{Class},
                );

                push @Attributes,
                    {
                        Key   => $Key,
                        Name  => $Name,
                        Input => {
                            Type        => 'Selection',
                            Data        => $GeneralCatalogList,
                            Translation => 0,                     # TODO: determine whether items should be translated $DynamicFieldConfig->{Input}->{Input}->{Translation},
                            Size        => 5,
                            Multiple    => 1,
                        },
                    };
            }
        }

        # TODO: handle Sets
        next DF_NAME unless $DynamicFieldConfig->{Sub};

        # start recursion, if "Sub" was found
        push @Attributes, $Self->_DFSearchAttributesGet(
            DynamicFieldRef => $DynamicFieldConfig->{Sub},
            KeyPrefix       => $Key,
            NamePrefix      => $Name,
        );
    }

    return @Attributes;
}

=head2 _DFSearchDataPrepare()

recursion function to prepare the export XML search params

    my %DFSearchParams = $ObjectBackend->_DFSearchDataPrepare(
        DynamicFieldRef => $DynamicFieldRef,
        SearchData      => $HashRef,
    );

=cut

sub _DFSearchDataPrepare {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    return unless $Param{DynamicFieldRef};
    return unless ref $Param{DynamicFieldRef} eq 'HASH';
    return unless $Param{SearchData};
    return unless ref $Param{SearchData} eq 'HASH';

    my %DFSearchParams;
    DF_NAME:
    for my $DFName ( sort keys $Param{DynamicFieldRef}->%* ) {
        my $DynamicFieldConfig = $Param{DynamicFieldRef}->{$DFName};

        # create key
        my $Key = $Param{Prefix} ? $Param{Prefix} . '::' . $DynamicFieldConfig->{Name} : $DynamicFieldConfig->{Name};

        next DF_NAME unless $Param{SearchData}->{$Key};    # '#####' separated

        $DFSearchParams{"DynamicField_$Key"} = { Equals => [ split /#####/, $Param{SearchData}->{$Key} ] };

        # TODO: support Sets
        next DF_NAME if !$DynamicFieldConfig->{Sub};

        # start recursion, if "Sub" was found
        my %SetSearchParams = $Self->_DFSearchDataPrepare(
            XMLDefinition => $DynamicFieldConfig->{Sub},
            What          => $Param{What},
            SearchData    => $Param{SearchData},
            Prefix        => $Key,
        );
        @DFSearchParams{ keys %SetSearchParams } = values %SetSearchParams;
    }

    return %DFSearchParams;
}

=head2 _DFImportSearchDataPrepare()

recursion function to prepare the import XML search params

    $ObjectBackend->_DFImportSearchDataPrepare(
        XMLDefinition => $ArrayRef,
        What          => $ArrayRef,
        Identifier    => $HashRef,
    );
    my %DFImportSearchParams = $ObjectBackend->_DFImportSearchDataPrepare(
        DynamicFieldRef => $Definition->{DynamicFieldRef},
        Identifier      => \%Identifier,
    );

=cut

sub _DFImportSearchDataPrepare {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    return unless $Param{DynamicFieldRef};
    return unless ref $Param{DynamicFieldRef} eq 'HASH';
    return unless $Param{Identifier};
    return unless ref $Param{Identifier} eq 'HASH';

    my %DFSearchParams;
    DF_NAME:
    for my $DFName ( sort keys $Param{DynamicFieldRef}->%* ) {

        my $DynamicFieldConfig = $Param{DynamicFieldRef}->{$DFName};

        # create key, TODO: what about identifies in n-th element ?
        my $Key = $Param{Prefix} ? $Param{Prefix} . '::' . $DynamicFieldConfig->{Name} : $DynamicFieldConfig->{Name};

        next DF_NAME unless $Param{Identifier}->{$Key};

        $DFSearchParams{"DynamicField_$Key"} = { Equals => [ split /#####/, $Param{SearchData}->{$Key} ] };

        # TODO: handle Sets
        next DF_NAME if !$DynamicFieldConfig->{Sub};

        # start recursion, if "Sub" was found
        my %SetSearchParams = $Self->_DFImportSearchDataPrepare(
            DynamicFieldRef => $DynamicFieldConfig->{Sub},
            Identifier      => $Param{Identifier},
            Prefix          => $Key,
        );
        @DFSearchParams{ keys %SetSearchParams } = values %SetSearchParams;
    }

    return %DFSearchParams;
}

=head2 _DFImportDataMerge()

recursive function to inplace edit the import XML data.

    my $MergeOk = $ObjectBackend->_DFImportDataMerge(
        DynamicFieldRef => $DynamicFieldRef,
        VersionData     => $VersionData,
        NewVersionData  => $HashRef,
    );

The return value indicates whether the merge was successful.
A merge fails when for example a general catalog item name can't be mapped to an id.

=cut

sub _DFImportDataMerge {
    my ( $Self, %Param ) = @_;

    # check needed stuff

    return unless $Param{DynamicFieldRef};
    return unless ref $Param{DynamicFieldRef} eq 'HASH';    # the attributes of the config item class
    return unless $Param{NewVersionData};
    return unless ref $Param{NewVersionData} eq 'HASH';     # hash with values that should be imported
    return unless $Param{VersionData};
    return unless ref $Param{VersionData} eq 'HASH';        # hash with current values of the config item

    my $VersionData = $Param{VersionData};

    # default value for prefix
    $Param{Prefix} ||= '';

    DF_NAME:
    for my $DFName ( sort keys $Param{DynamicFieldRef}->%* ) {
        my $DynamicFieldConfig = $Param{DynamicFieldRef}->{$DFName};

        COUNTER:
        for my $Counter ( 1 .. 1 ) {

            # create inputkey
            my $Key = $Param{Prefix} . $DynamicFieldConfig->{Name} . '::' . $Counter;

            # TODO: support for Set

            # When the data point is not part of the input definition,
            # then do not overwrite the previous setting.
            # False values are OK.
            next COUNTER unless exists $Param{NewVersionData}->{$Key};

            if ( $Param{EmptyFieldsLeaveTheOldValues} ) {

                # do not override old value with an empty field is imported
                next COUNTER unless defined $Param{NewVersionData}->{$Key};
                next COUNTER if $Param{NewVersionData}->{$Key} eq '';
            }

            # prepare value
            my $Value = $Param{NewVersionData}->{$Key};

            # let merge fail, when a value cannot be prepared
            #return unless defined $Value;

            # save the prepared value
            # TODO: collect the dynamic fields
            #$VersionData->{"DynamicField_$DynamicFieldConfig->{Name}"} = $Value;
        }
    }

    return 1;
}

1;

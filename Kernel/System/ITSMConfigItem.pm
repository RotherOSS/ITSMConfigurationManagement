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

package Kernel::System::ITSMConfigItem;

use v5.24;
use strict;
use warnings;
use namespace::autoclean;
use utf8;

use parent qw(
    Kernel::System::ITSMConfigItem::ConfigItemSearch
    Kernel::System::ITSMConfigItem::ConfigItemACL
    Kernel::System::ITSMConfigItem::Definition
    Kernel::System::ITSMConfigItem::History
    Kernel::System::ITSMConfigItem::Number
    Kernel::System::ITSMConfigItem::Permission
    Kernel::System::ITSMConfigItem::Link
    Kernel::System::ITSMConfigItem::Version
    Kernel::System::ITSMConfigItem::XML
    Kernel::System::EventHandler
);

# core modules
use Storable;

# CPAN modules

# OTOBO modules
use Kernel::System::VariableCheck qw(:all);

our @ObjectDependencies = (
    'Kernel::Config',
    'Kernel::System::DB',
    'Kernel::System::DynamicField',
    'Kernel::System::DynamicField::Backend',
    'Kernel::System::Cache',
    'Kernel::System::GeneralCatalog',
    'Kernel::System::LinkObject',
    'Kernel::System::Log',
    'Kernel::System::Main',
    'Kernel::System::Service',
    'Kernel::System::User',
    'Kernel::System::VirtualFS',
    'Kernel::System::XML',
);

=head1 NAME

Kernel::System::ITSMConfigItem - config item lib

=head1 DESCRIPTION

All config item functions.

=head1 PUBLIC INTERFACE

=head2 new()

create an object

    use Kernel::System::ObjectManager;

    local $Kernel::OM = Kernel::System::ObjectManager->new();
    my $ConfigItemObject = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');

=cut

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = bless {}, $Type;

    $Self->{CacheType} = 'ITSMConfigurationManagement';
    $Self->{CacheTTL}  = 60 * 60 * 24 * 20;

    # init of event handler
    $Self->EventHandlerInit(
        Config => 'ITSMConfigItem::EventModulePost',
    );

    return $Self;
}

=head2 ConfigItemCount()

count all records of a config item class

    my $Count = $ConfigItemObject->ConfigItemCount(
        ClassID => 123,
    );

=cut

sub ConfigItemCount {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    if ( !$Param{ClassID} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => 'Need ClassID!',
        );
        return;
    }

    # get state list
    my $StateList = $Kernel::OM->Get('Kernel::System::GeneralCatalog')->ItemList(
        Class       => 'ITSM::ConfigItem::DeploymentState',
        Preferences => {
            Functionality => [ 'preproductive', 'productive' ],
        },
    );

    return 0 if !%{$StateList};

    # create state string
    my $DeplStateString = join q{, }, keys %{$StateList};

    # ask database
    my ($Count) = $Kernel::OM->Get('Kernel::System::DB')->SelectRowArray(
        SQL => "SELECT COUNT(id) FROM configitem WHERE class_id = ? AND "
            . "cur_depl_state_id IN ( $DeplStateString )",
        Bind  => [ \$Param{ClassID} ],
        Limit => 1,
    );

    return $Count;
}

=head2 ConfigItemResultList()

return a config item list as array hash reference

    my $ConfigItemListRef = $ConfigItemObject->ConfigItemResultList(
        ClassID => 123,
        Start   => 100,
        Limit   => 50,
    );

=cut

sub ConfigItemResultList {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    if ( !$Param{ClassID} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => 'Need ClassID!',
        );
        return;
    }

    # get state list
    my $StateList = $Kernel::OM->Get('Kernel::System::GeneralCatalog')->ItemList(
        Class       => 'ITSM::ConfigItem::DeploymentState',
        Preferences => {
            Functionality => [ 'preproductive', 'productive' ],
        },
    );

    # create state string
    my $DeplStateString = join q{, }, keys %{$StateList};

    # ask database
    $Kernel::OM->Get('Kernel::System::DB')->Prepare(
        SQL => "SELECT id FROM configitem "
            . "WHERE class_id = ? AND cur_depl_state_id IN ( $DeplStateString ) "
            . "ORDER BY change_time DESC",
        Bind  => [ \$Param{ClassID} ],
        Start => $Param{Start},
        Limit => $Param{Limit},
    );

    # fetch the result
    my @ConfigItemIDList;
    while ( my @Row = $Kernel::OM->Get('Kernel::System::DB')->FetchrowArray() ) {
        push @ConfigItemIDList, $Row[0];
    }

    # get last versions data
    my @ConfigItemList;
    for my $ConfigItemID (@ConfigItemIDList) {

        # get version data
        my $ConfigItem = $Self->ConfigItemGet(
            ConfigItemID  => $ConfigItemID,
            DynamicFields => 0,
        );

        push @ConfigItemList, $ConfigItem;
    }

    return \@ConfigItemList;
}

=head2 ConfigItemGet()

return a config item as hash reference. The latest version is retrieved when the config item ID is passed.

    my $ConfigItem = $ConfigItemObject->ConfigItemGet(
        ConfigItemID  => 123,
        DynamicFields => 1,    # (optional) default 0 (0|1)
    );

A specific version is returned when the Version ID is passed.

    my $ConfigItem = $ConfigItemObject->ConfigItemGet(
        VersionID     => 243,
        DynamicFields => 1,    # (optional) default 0 (0|1)
    );

When both C<ConfigItemID> and C<VersionID> are passed, then an consistency check is performed.

A hashref with the following keys is returned:

    $ConfigItem->{ConfigItemID}
    $ConfigItem->{Number}
    $ConfigItem->{ClassID}
    $ConfigItem->{Class}
    $ConfigItem->{LastVersionID}
    $ConfigItem->{CurDeplStateID}
    $ConfigItem->{CurDeplState}
    $ConfigItem->{CurDeplStateType}
    $ConfigItem->{CurInciStateID}
    $ConfigItem->{CurInciState}
    $ConfigItem->{CurInciStateType}
    $ConfigItem->{DefinitionID}
    $ConfigItem->{CreateTime}
    $ConfigItem->{CreateBy}
    $ConfigItem->{ChangeTime}
    $ConfigItem->{ChangeBy}
    # TODO include Version keys

Caching can't be turned off.

=cut

sub ConfigItemGet {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    if ( !$Param{ConfigItemID} && !$Param{VersionID} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => 'Need ConfigItemID or VersionID!',
        );

        return;
    }

    # ignore DynamicFields per default,
    # make sure that the variable is either 0 or 1, as it is used for the cache key
    my $DFData = $Param{DynamicFields} ? 1 : 0;

    # check if result is already cached, considering the DynamicFields parameter
    my $CacheKey = $Param{VersionID}
        ?
        join(
            '::', 'ConfigItemGet',
            VersionID => $Param{VersionID},
            DFData    => $DFData
        )
        :
        join(
            '::', 'ConfigItemGet',
            ConfigItemID => $Param{ConfigItemID},
            DFData       => $DFData
        );

    my $CacheObject = $Kernel::OM->Get('Kernel::System::Cache');
    my $Cache       = $CacheObject->Get(
        Type => $Self->{CacheType},
        Key  => $CacheKey,
    );

    if ($Cache) {
        if ( $Param{VersionID} && $Param{ConfigItemID} && $Param{ConfigItemID} ne $Cache->{ConfigItemID} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "VersionID $Param{VersionID} is not a version of ConfigItemID $Param{ConfigItemID}!",
            );

            return;
        }

        return Storable::dclone($Cache) if $Cache;
    }

    # get specific ConfigItemVersion
    my @Row;
    if ( $Param{VersionID} ) {

        # TODO: implement version string: v.version
        @Row = $Kernel::OM->Get('Kernel::System::DB')->SelectRowArray(
            SQL => <<'END_SQL',
SELECT ci.id, ci.configitem_number, ci.class_id, ci.last_version_id,
    ci.cur_depl_state_id, ci.cur_inci_state_id,
    v.id, v.name, 1, v.definition_id, v.depl_state_id, v.inci_state_id,
    v.create_time, v.create_by, v.change_time, v.change_by
  FROM configitem_version v
  INNER JOIN configitem ci
    ON v.configitem_id = ci.id
  WHERE v.id = ?
END_SQL
            Bind  => [ \$Param{VersionID} ],
            Limit => 1,
        );
    }

    # get latest ConfigItemVersion
    else {

        # TODO: implement version string: v.version
        @Row = $Kernel::OM->Get('Kernel::System::DB')->SelectRowArray(
            SQL => <<'END_SQL',
SELECT ci.id, ci.configitem_number, ci.class_id, ci.last_version_id,
    ci.cur_depl_state_id, ci.cur_inci_state_id,
    v.id, v.name, 1, v.definition_id, v.depl_state_id, v.inci_state_id,
    ci.create_time, ci.create_by, ci.change_time, ci.change_by
  FROM configitem ci
  LEFT JOIN configitem_version v
    ON ci.last_version_id = v.id
  WHERE ci.id = ?
END_SQL
            Bind  => [ \$Param{ConfigItemID} ],
            Limit => 1,
        );
    }

    # fetch the result
    my %ConfigItem;
    $ConfigItem{ConfigItemID}   = $Row[0];
    $ConfigItem{Number}         = $Row[1];
    $ConfigItem{ClassID}        = $Row[2];
    $ConfigItem{LastVersionID}  = $Row[3];
    $ConfigItem{CurDeplStateID} = $Row[4];
    $ConfigItem{CurInciStateID} = $Row[5];
    $ConfigItem{VersionID}      = $Row[6];
    $ConfigItem{Name}           = $Row[7];
    $ConfigItem{Version}        = $Row[8];
    $ConfigItem{DefinitionID}   = $Row[9];
    $ConfigItem{DeplStateID}    = $Row[10];
    $ConfigItem{InciStateID}    = $Row[11];
    $ConfigItem{CreateTime}     = $Row[12];
    $ConfigItem{CreateBy}       = $Row[13];
    $ConfigItem{ChangeTime}     = $Row[14];
    $ConfigItem{ChangeBy}       = $Row[15];

    # check config item
    if ( !$ConfigItem{ConfigItemID} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "No such ConfigItemID ($Param{ConfigItemID})!",
        );

        return;
    }
    if ( $Param{VersionID} && $Param{ConfigItemID} && $Param{ConfigItemID} ne $ConfigItem{ConfigItemID} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "VersionID $Param{VersionID} is not a version of ConfigItemID $Param{ConfigItemID}!",
        );

        return;
    }

    # check if need to return DynamicFields
    if ( $DFData && $ConfigItem{DefinitionID} ) {

        # get dynamic field objects
        my $DynamicFieldObject        = $Kernel::OM->Get('Kernel::System::DynamicField');
        my $DynamicFieldBackendObject = $Kernel::OM->Get('Kernel::System::DynamicField::Backend');

        my $Definition = $Self->DefinitionGet(
            DefinitionID => $ConfigItem{DefinitionID},
        );

        DYNAMICFIELD:
        for my $DynamicFieldConfig ( values $Definition->{DynamicFieldRef}->%* ) {

            # validate each dynamic field
            next DYNAMICFIELD unless $DynamicFieldConfig;
            next DYNAMICFIELD unless IsHashRefWithData($DynamicFieldConfig);
            next DYNAMICFIELD unless $DynamicFieldConfig->{Name};

            # get the current value for each dynamic field
            my $Value = $DynamicFieldBackendObject->ValueGet(
                DynamicFieldConfig => $DynamicFieldConfig,
                ObjectID           => $ConfigItem{VersionID},
            );

            # set the dynamic field name and value into the ticket hash
            $ConfigItem{ 'DynamicField_' . $DynamicFieldConfig->{Name} } = $Value;
        }
    }

    my $GeneralCatalogObject = $Kernel::OM->Get('Kernel::System::GeneralCatalog');

    # get class list
    my $ClassList = $GeneralCatalogObject->ItemList(
        Class => 'ITSM::ConfigItem::Class',
    );

    $ConfigItem{Class} = $ClassList->{ $ConfigItem{ClassID} };

    STATE:
    for my $State (qw/DeplState CurDeplState InciState CurInciState/) {
        next STATE if !$ConfigItem{ $State . 'ID' };

        my $Item = $GeneralCatalogObject->ItemGet(
            ItemID => $ConfigItem{ $State . 'ID' },
        );

        $ConfigItem{$State} = $Item->{Name};
        $ConfigItem{ $State . 'Type' } = $Item->{Functionality};
    }

    # cache the result
    $CacheObject->Set(
        Type  => $Self->{CacheType},
        TTL   => $Self->{CacheTTL},
        Key   => $CacheKey,
        Value => Storable::dclone( \%ConfigItem ),
    );

    return \%ConfigItem;
}

=head2 ConfigItemAdd()

add a new config item

    my $ConfigItemID = $ConfigItemObject->ConfigItemAdd(
        ClassID        => 123,
        Name           => 'Name',
        DeplStateID    => 3,
        InciStateID    => 2,
        UserID         => 1,
        Number         => '111',    # (optional)
        DynamicField_X => $Value,   # optional
    );

=cut

sub ConfigItemAdd {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Argument (qw(ClassID UserID DeplStateID InciStateID)) {
        if ( !$Param{$Argument} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Argument!",
            );

            return;
        }
    }

    my $GeneralCatalogObject = $Kernel::OM->Get('Kernel::System::GeneralCatalog');

    # get class list
    my $ClassList = $GeneralCatalogObject->ItemList(
        Class => 'ITSM::ConfigItem::Class',
    );

    return if !$ClassList;
    return if ref $ClassList ne 'HASH';

    # check the class id
    if ( !$ClassList->{ $Param{ClassID} } ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => 'No valid class id given!',
        );

        return;
    }

    # get deployment state list
    my $DeplStateList = $Kernel::OM->Get('Kernel::System::GeneralCatalog')->ItemList(
        Class => 'ITSM::ConfigItem::DeploymentState',
    );

    return if !$DeplStateList;
    return if ref $DeplStateList ne 'HASH';

    # check the deployment state id
    if ( !$DeplStateList->{ $Param{DeplStateID} } ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => 'No valid deployment state id given!',
        );

        return;
    }

    # get incident state list
    my $InciStateList = $Kernel::OM->Get('Kernel::System::GeneralCatalog')->ItemList(
        Class => 'ITSM::Core::IncidentState',
    );

    return if !$InciStateList;
    return if ref $InciStateList ne 'HASH';

    # check the incident state id
    if ( !$InciStateList->{ $Param{InciStateID} } ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => 'No valid incident state id given!',
        );

        return;
    }

    my $ConfigObject = $Kernel::OM->Get('Kernel::Config');

    # create config item number
    if ( $Param{Number} ) {

        # find existing config item number
        my $Exists = $Self->ConfigItemNumberLookup(
            ConfigItemNumber => $Param{Number},
        );

        if ($Exists) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => 'Config item number already exists!',
            );

            return;
        }
    }
    else {

        # create config item number
        $Param{Number} = $Self->ConfigItemNumberCreate(
            Type    => $ConfigObject->Get('ITSMConfigItem::NumberGenerator'),
            ClassID => $Param{ClassID},
        );
    }

    my $NameModuleConfig = $ConfigObject->Get('ITSMConfigItem::NameModule');
    my $NameModuleObject;
    if ( $NameModuleConfig && $NameModuleConfig->{ $ClassList->{ $Param{ClassID} } } ) {
        my $NameModule = "Kernel::System::ITSMConfigItem::Name::$NameModuleConfig->{ $ClassList->{ $Param{ClassID} } }";

        # check if name module exists
        if ( !$Kernel::OM->Get('Kernel::System::Main')->Require($NameModule) ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Can't load name module for class $ClassList->{ $Param{ClassID} }!",
            );

            return;
        }

        # create a backend object
        $NameModuleObject = $Kernel::OM->Get($NameModule);

        # override possible incoming name
        $Param{Name} = $NameModuleObject->ConfigItemNameCreate(%Param);
    }

    # check needed stuff II
    if ( !$Param{Name} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "Need Name!",
        );

        return;
    }

    # check, whether the feature to check for a unique name is enabled
    if ( $ConfigObject->Get('UniqueCIName::EnableUniquenessCheck') ) {

        my $NameDuplicates = $Self->UniqueNameCheck(
            ConfigItemID => $Param{ConfigItemID},
            ClassID      => $Param{ClassID},
            Name         => $Param{Name},
        );

        # stop processing if the name is not unique
        if ( IsArrayRefWithData($NameDuplicates) ) {

            # build a string of all duplicate IDs
            my $Duplicates = join ', ', @{$NameDuplicates};

            # write an error log message containing all the duplicate IDs
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "The name $Param{Name} is already in use (ConfigItemIDs: $Duplicates)!",
            );

            return;
        }
    }

    # insert new config item
    my $Success = $Kernel::OM->Get('Kernel::System::DB')->Do(
        SQL => 'INSERT INTO configitem ('
            . 'configitem_number, cur_depl_state_id, cur_inci_state_id'
            . ', class_id, create_time, create_by, change_time, change_by'
            . ') VALUES (?, ?, ?, ?, current_timestamp, ?, current_timestamp, ?)',
        Bind => [ \$Param{Number}, \$Param{DeplStateID}, \$Param{InciStateID}, \$Param{ClassID}, \$Param{UserID}, \$Param{UserID} ],
    );

    if ( !$Success ) {
        if ( $NameModuleObject && $NameModuleObject->can('ConfigItemNameDelete') ) {
            $NameModuleObject->ConfigItemNameDelete( $Param{Name} );
        }

        return;
    }

    # find id of new item
    # TODO: what about concurrent INSERTs ???
    my ($ConfigItemID) = $Kernel::OM->Get('Kernel::System::DB')->SelectRowArray(
        SQL => <<'END_SQL',
SELECT id
  FROM configitem
  WHERE configitem_number = ?
    AND class_id = ?
  ORDER BY id DESC
END_SQL
        Bind => [ \$Param{Number}, \$Param{ClassID} ],
    );

    # trigger ConfigItemCreate
    $Self->EventHandler(
        Event => 'ConfigItemCreate',
        Data  => {
            ConfigItemID => $ConfigItemID,
            Comment      => $ConfigItemID . '%%' . $Param{Number},
        },
        UserID => $Param{UserID},
    );

    # add the first version
    my $VersionID = $Self->VersionAdd(
        %Param,
        ConfigItemID => $ConfigItemID,
        LastVersion  => {
            ConfigItemID => $Param{ConfigItemID},
        },
    );

    if ( !$VersionID ) {
        if ( $NameModuleObject && $NameModuleObject->can('ConfigItemNameDelete') ) {
            $NameModuleObject->ConfigItemNameDelete( $Param{Name} );
        }

        # delete config item if no version could be created
        $Kernel::OM->Get('Kernel::System::DB')->Do(
            SQL  => 'DELETE FROM configitem WHERE id = ?',
            Bind => [ \$ConfigItemID ],
        );

        # write an error log message containing all the duplicate IDs
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "Could not create version!",
        );

        return;
    }

    return $ConfigItemID;
}

=head2 ConfigItemDelete()

delete an existing config item

    my $True = $ConfigItemObject->ConfigItemDelete(
        ConfigItemID => 123,
        UserID       => 1,
    );

=cut

sub ConfigItemDelete {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Argument (qw(ConfigItemID UserID)) {
        if ( !$Param{$Argument} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Argument!",
            );

            return;
        }
    }

    # remember config item data before delete
    my $ConfigItemData = $Self->ConfigItemGet(
        ConfigItemID => $Param{ConfigItemID},
    );

    # Delete all links to this config item first, before deleting the versions.
    # LinkDeleteAll() calls LinkDelete() internally, this means that
    # the event handler are honored.
    return unless $Kernel::OM->Get('Kernel::System::LinkObject')->LinkDeleteAll(
        Object => 'ITSMConfigItem',
        Key    => $Param{ConfigItemID},
        UserID => $Param{UserID},
    );

    # delete existing versions
    $Self->VersionDelete(
        ConfigItemID => $Param{ConfigItemID},
        UserID       => $Param{UserID},
    );

    # get a list of all attachments
    my @ExistingAttachments = $Self->ConfigItemAttachmentList(
        ConfigItemID => $Param{ConfigItemID},
    );

    # delete all attachments of this config item
    FILENAME:
    for my $Filename (@ExistingAttachments) {

        # delete the attachment
        my $DeletionSuccess = $Self->ConfigItemAttachmentDelete(
            ConfigItemID => $Param{ConfigItemID},
            Filename     => $Filename,
            UserID       => $Param{UserID},
        );

        if ( !$DeletionSuccess ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Unknown problem when deleting attachment $Filename of ConfigItem "
                    . "$Param{ConfigItemID}. Please check the VirtualFS backend for stale "
                    . "files!",
            );
        }
    }

    my $NameModuleConfig = $Kernel::OM->Get('Kernel::Config')->Get('ITSMConfigItem::NameModule');
    if ( $NameModuleConfig && $NameModuleConfig->{ $ConfigItemData->{Class} } ) {
        my $NameModule = "Kernel::System::ITSMConfigItem::Name::$NameModuleConfig->{ $ConfigItemData->{Class} }";

        # check if name module exists
        if ( $Kernel::OM->Get('Kernel::System::Main')->Require($NameModule) ) {

            # create a backend object
            my $NameModuleObject = $Kernel::OM->Get($NameModule);

            if ( $NameModuleObject->can('ConfigItemNameDelete') ) {
                $NameModuleObject->ConfigItemNameDelete(
                    Name => $ConfigItemData->{Name},
                );
            }
        }
        else {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Can't load name module for class $ConfigItemData->{Class}!",
            );
        }
    }

    # trigger ConfigItemDelete event
    # this must be done before deleting the config item from the database,
    # because of a foreign key constraint in the configitem_history table
    $Self->EventHandler(
        Event => 'ConfigItemDelete',
        Data  => {
            ConfigItemID => $Param{ConfigItemID},
            Comment      => $Param{ConfigItemID},
            Number       => $ConfigItemData->{Number},
            Class        => $ConfigItemData->{Class},
        },
        UserID => $Param{UserID},
    );

    # delete versions
    $Kernel::OM->Get('Kernel::System::DB')->Do(
        SQL  => 'DELETE FROM configitem_version WHERE configitem_id = ?',
        Bind => [ \$Param{ConfigItemID} ],
    );

    # delete config item
    my $Success = $Kernel::OM->Get('Kernel::System::DB')->Do(
        SQL  => 'DELETE FROM configitem WHERE id = ?',
        Bind => [ \$Param{ConfigItemID} ],
    );

    # delete the cache
    for my $DFData ( 0, 1 ) {
        $Kernel::OM->Get('Kernel::System::Cache')->Delete(
            Type => $Self->{CacheType},
            Key  => join(
                'ConfigItemGet',
                ConfigItemID => $Param{ConfigItemID},
                DFData       => $DFData
            ),
        );
    }

    return $Success;
}

=head2 ConfigItemUpdate()

update a config item

    my $Success = $ConfigItemObject->ConfigItemUpdate(
        ConfigItemID   => 27,
        Number         => '111',    # ID or Number is required
        UserID         => 1,
        Name           => 'Name',   # optional
        DeplStateID    => 3,        # optional
        InciStateID    => 2,        # optional
        DynamicField_X => $Value,   # optional
    );

=cut

sub ConfigItemUpdate {
    my ( $Self, %Param ) = @_;

    # lookup
    $Param{ConfigItemID} //= $Self->ConfigItemLookup(
        ConfigItemNumber => $Param{Number},
    );

    # check needed parameters
    for my $Key (qw/ConfigItemID UserID/) {
        if ( !$Param{$Key} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need " . ( $Key eq 'ConfigItemID' ? 'ConfigItemID or Number' : $Key ),
            );

            return;
        }
    }

    my $ConfigObject = $Kernel::OM->Get('Kernel::Config');

    # gather dynamic field keys
    my @DynamicFieldNames;
    KEY:
    for my $Key ( keys %Param ) {
        next KEY unless $Key =~ m/^DynamicField_(.+)/;

        push @DynamicFieldNames, $1;
    }

    # get current
    my $ConfigItem = $Self->ConfigItemGet(
        ConfigItemID  => $Param{ConfigItemID},
        DynamicFields => ( @DynamicFieldNames ? 1 : 0 ),
    );

    my $ClassList = $Kernel::OM->Get('Kernel::System::GeneralCatalog')->ItemList(
        Class => 'ITSM::ConfigItem::Class',
    );
    my $Class = $ClassList->{ $ConfigItem->{ClassID} };

    if ( !$Class ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "No valid class found for id '$ConfigItem->{ClassID}' (ConfigItem#$ConfigItem->{Number})!",
        );

        return;
    }

    my $NameModuleConfig = $ConfigObject->Get('ITSMConfigItem::NameModule');
    if ( $NameModuleConfig && $NameModuleConfig->{ $ConfigItem->{Class} } ) {
        delete $Param{Name};
    }

    my $TriggerConfig  = $ConfigObject->Get('ITSMConfigItem::VersionTrigger') // {};
    my %VersionTrigger = map { $_ => 1 } @{ $TriggerConfig->{$Class} // [] };

    my %Changed;           # track changed values for the Event handler, e.g. for writing history
    my $AddVersion = 0;    # flag for deciding whether a new version is created

    # name, deployment and incident state
    # TODO: check for unique config item name, like it is done in ConfigItemAdd()
    ATTR:
    for my $Attribute (qw/Name DeplStateID InciStateID/) {
        next ATTR unless defined $Param{$Attribute};
        next ATTR if $Param{$Attribute} eq $ConfigItem->{$Attribute};

        $Changed{$Attribute} = {
            Old => $ConfigItem->{$Attribute},
            New => $Param{$Attribute},
        };

        if ( $VersionTrigger{$Attribute} ) {
            $AddVersion = 1;
        }
    }

    # get latest definition for the class
    my $Definition = $Self->DefinitionGet(
        ClassID => $ConfigItem->{ClassID},
    );

    # TODO: Think about DefinitionID changes

    # check for changed dynamic fields to trigger versions and filter history entries
    if (@DynamicFieldNames) {
        my $DynamicFieldObject        = $Kernel::OM->Get('Kernel::System::DynamicField');
        my $DynamicFieldBackendObject = $Kernel::OM->Get('Kernel::System::DynamicField::Backend');

        # dynamic fields
        DYNAMICFIELD:
        for my $Name (@DynamicFieldNames) {
            next DYNAMICFIELD unless $Definition->{DynamicFieldRef}{$Name};

            my $DynamicField = $DynamicFieldObject->DynamicFieldGet(
                Name => $Name,
            );

            if (
                !$DynamicFieldBackendObject->ValueIsDifferent(
                    DynamicFieldConfig => $DynamicField,
                    Value1             => $Param{"DynamicField_$Name"},
                    Value2             => $ConfigItem->{"DynamicField_$Name"},
                )
                )
            {
                delete $Param{"DynamicField_$Name"};

                next DYNAMICFIELD;
            }

            if ( $VersionTrigger{"DynamicField_$Name"} ) {
                $AddVersion = 1;
            }
        }
    }

    if ($AddVersion) {
        $Self->VersionAdd(
            %Param,
            LastVersion => $ConfigItem,
        );
    }
    else {
        $Self->VersionUpdate(
            %Param,
            Version => $ConfigItem,
        );

        # update config item change time
        my $Success = $Kernel::OM->Get('Kernel::System::DB')->Do(
            SQL  => 'UPDATE configitem SET change_time = current_timestamp, change_by = ?',
            Bind => [ \$Param{UserID} ],
        );
    }

    my %Events = (
        Name        => 'NameUpdate',
        DeplStateID => 'DeploymentStateUpdate',
        InciStateID => 'IncidentStateUpdate',
    );

    for my $Key ( keys %Changed ) {
        $Self->EventHandler(
            Event => $Events{$Key},
            Data  => {
                ConfigItemID => $ConfigItem->{ConfigItemID},
                Comment      => $Changed{$Key}{New} . '%%' . $Changed{$Key}{Old},
            },
            UserID => $Param{UserID},
        );
    }

    return 1;
}

=head2 ConfigItemAttachmentAdd()

adds an attachment to a config item

    my $Success = $ConfigItemObject->ConfigItemAttachmentAdd(
        ConfigItemID    => 1,
        Filename        => 'filename',
        Content         => 'content',
        ContentType     => 'text/plain',
        UserID          => 1,
    );

=cut

sub ConfigItemAttachmentAdd {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Needed (qw(ConfigItemID Filename Content ContentType UserID)) {
        if ( !$Param{$Needed} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Needed!",
            );

            return;
        }
    }

    # write to virtual fs
    my $Success = $Kernel::OM->Get('Kernel::System::VirtualFS')->Write(
        Filename    => "ConfigItem/$Param{ConfigItemID}/$Param{Filename}",
        Mode        => 'binary',
        Content     => \$Param{Content},
        Preferences => {
            ContentID    => $Param{ContentID},
            ContentType  => $Param{ContentType},
            ConfigItemID => $Param{ConfigItemID},
            UserID       => $Param{UserID},
        },
    );

    # check for error
    if ($Success) {

        # trigger AttachmentAdd-Event
        $Self->EventHandler(
            Event => 'AttachmentAddPost',
            Data  => {
                %Param,
                ConfigItemID => $Param{ConfigItemID},
                Comment      => $Param{Filename},
                HistoryType  => 'AttachmentAdd',
            },
            UserID => $Param{UserID},
        );
    }
    else {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "Cannot add attachment for config item $Param{ConfigItemID}",
        );

        return;
    }

    return 1;
}

=head2 ConfigItemAttachmentDelete()

Delete the given file from the virtual filesystem.

    my $Success = $ConfigItemObject->ConfigItemAttachmentDelete(
        ConfigItemID => 123,               # used in event handling, e.g. for logging the history
        Filename     => 'Projectplan.pdf', # identifies the attachment (together with the ConfigItemID)
        UserID       => 1,
    );

=cut

sub ConfigItemAttachmentDelete {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Needed (qw(ConfigItemID Filename UserID)) {
        if ( !$Param{$Needed} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Needed!",
            );

            return;
        }
    }

    # add prefix
    my $Filename = 'ConfigItem/' . $Param{ConfigItemID} . '/' . $Param{Filename};

    # delete file
    my $Success = $Kernel::OM->Get('Kernel::System::VirtualFS')->Delete(
        Filename => $Filename,
    );

    # check for error
    if ($Success) {

        # trigger AttachmentDeletePost-Event
        $Self->EventHandler(
            Event => 'AttachmentDeletePost',
            Data  => {
                %Param,
                ConfigItemID => $Param{ConfigItemID},
                Comment      => $Param{Filename},
                HistoryType  => 'AttachmentDelete',
            },
            UserID => $Param{UserID},
        );
    }
    else {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "Cannot delete attachment $Filename!",
        );

        return;
    }

    return $Success;
}

=head2 ConfigItemAttachmentGet()

This method returns information about one specific attachment.

    my $Attachment = $ConfigItemObject->ConfigItemAttachmentGet(
        ConfigItemID => 4,
        Filename     => 'test.txt',
    );

returns

    {
        Preferences => {
            AllPreferences => 'test',
        },
        Filename    => 'test.txt',
        Content     => 'content',
        ContentType => 'text/plain',
        Filesize    => 12348409,
        Type        => 'attachment',
    }

=cut

sub ConfigItemAttachmentGet {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Argument (qw(ConfigItemID Filename)) {
        if ( !$Param{$Argument} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Argument!",
            );
            return;
        }
    }

    # add prefix
    my $Filename = 'ConfigItem/' . $Param{ConfigItemID} . '/' . $Param{Filename};

    # find all attachments of this config item
    my @Attachments = $Kernel::OM->Get('Kernel::System::VirtualFS')->Find(
        Filename    => $Filename,
        Preferences => {
            ConfigItemID => $Param{ConfigItemID},
        },
    );

    # return error if file does not exist
    if ( !@Attachments ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Message  => "No such attachment ($Filename)!",
            Priority => 'error',
        );
        return;
    }

    # get data for attachment
    my %AttachmentData = $Kernel::OM->Get('Kernel::System::VirtualFS')->Read(
        Filename => $Filename,
        Mode     => 'binary',
    );

    my $AttachmentInfo = {
        %AttachmentData,
        Filename    => $Param{Filename},
        Content     => ${ $AttachmentData{Content} },
        ContentType => $AttachmentData{Preferences}->{ContentType},
        Type        => 'attachment',
        Filesize    => $AttachmentData{Preferences}->{FilesizeRaw},
    };

    return $AttachmentInfo;
}

=head2 ConfigItemAttachmentList()

Returns an array with all attachments of the given config item.

    my @Attachments = $ConfigItemObject->ConfigItemAttachmentList(
        ConfigItemID => 123,
    );

returns

    @Attachments = (
        'filename.txt',
        'other_file.pdf',
    );

=cut

sub ConfigItemAttachmentList {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    if ( !$Param{ConfigItemID} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => 'Need ConfigItemID!',
        );

        return;
    }

    # find all attachments of this config item
    my @Attachments = $Kernel::OM->Get('Kernel::System::VirtualFS')->Find(
        Preferences => {
            ConfigItemID => $Param{ConfigItemID},
        },
    );

    for my $Filename (@Attachments) {

        # remove extra information from filename
        $Filename =~ s{ \A ConfigItem / \d+ / }{}xms;
    }

    return @Attachments;
}

=head2 ConfigItemAttachmentExists()

Checks if a file with a given filename exists.

    my $Exists = $ConfigItemObject->ConfigItemAttachmentExists(
        Filename => 'test.txt',
        ConfigItemID => 123,
        UserID   => 1,
    );

=cut

sub ConfigItemAttachmentExists {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Needed (qw(Filename ConfigItemID UserID)) {
        if ( !$Param{$Needed} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Needed!",
            );

            return;
        }
    }

    return if !$Kernel::OM->Get('Kernel::System::VirtualFS')->Find(
        Filename => 'ConfigItem/' . $Param{ConfigItemID} . '/' . $Param{Filename},
    );

    return 1;
}

=head2 ConfigItemLookup()

This method does a lookup for a config-item. If a config-item id is given,
it returns the number of the config-item. If a config-item number is given,
the appropriate id is returned.

    my $Number = $ConfigItemObject->ConfigItemLookup(
        ConfigItemID => 1234,
    );

or

    my $ID = $ConfigItemObject->ConfigItemLookup(
        ConfigItemNumber => 1000001,
    );

=cut

sub ConfigItemLookup {
    my ( $Self, %Param ) = @_;

    my ($Key) = grep { $Param{$_} } qw(ConfigItemID ConfigItemNumber);

    # check for needed stuff
    if ( !$Key ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => 'Need ConfigItemID or ConfigItemNumber!',
        );
        return;
    }

    # if result is cached return that result
    return $Self->{Cache}->{ConfigItemLookup}->{$Key}->{ $Param{$Key} }
        if $Self->{Cache}->{ConfigItemLookup}->{$Key}->{ $Param{$Key} };

    # set the appropriate SQL statement
    my $SQL = 'SELECT configitem_number FROM configitem WHERE id = ?';

    if ( $Key eq 'ConfigItemNumber' ) {
        $SQL = 'SELECT id FROM configitem WHERE configitem_number = ?';
    }

    # fetch the requested value
    return if !$Kernel::OM->Get('Kernel::System::DB')->Prepare(
        SQL   => $SQL,
        Bind  => [ \$Param{$Key} ],
        Limit => 1,
    );

    my $Value;
    while ( my @Row = $Kernel::OM->Get('Kernel::System::DB')->FetchrowArray() ) {
        $Value = $Row[0];
    }

    $Self->{Cache}->{ConfigItemLookup}->{$Key}->{ $Param{$Key} } = $Value;

    return $Value;
}

=head2 UniqueNameCheck()

This method checks all already existing config items, whether the given name does already exist
within the same config item class or among all classes, depending on the SysConfig value of
UniqueCIName::UniquenessCheckScope (Class or Global).

This method requires 3 parameters: ConfigItemID, Name and Class
"ConfigItemID"  is the ID of the ConfigItem, which is to be checked for uniqueness
"Name"          is the config item name to be checked for uniqueness
"ClassID"       is the ID of the config item's class

All parameters are mandatory.

my $DuplicateNames = $ConfigItemObject->UniqueNameCheck(
    ConfigItemID => '73'
    Name         => 'PC#005',
    ClassID      => '32',
);

The given name is not unique
my $NameDuplicates = [ 5, 35, 48, ];    # IDs of ConfigItems with the same name

The given name is unique
my $NameDuplicates = [];

=cut

sub UniqueNameCheck {
    my ( $Self, %Param ) = @_;

    # check for needed stuff
    for my $Needed (qw(ConfigItemID Name ClassID)) {
        if ( !$Param{$Needed} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Missing parameter $Needed!",
            );
            return;
        }
    }

    # check ConfigItemID param for valid format
    if (
        !IsInteger( $Param{ConfigItemID} )
        && ( IsStringWithData( $Param{ConfigItemID} ) && $Param{ConfigItemID} ne 'NEW' )
        )
    {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "The ConfigItemID parameter needs to be an integer or 'NEW'",
        );
        return;
    }

    # check Name param for valid format
    if ( !IsStringWithData( $Param{Name} ) ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "The Name parameter needs to be a string!",
        );
        return;
    }

    # check ClassID param for valid format
    if ( !IsInteger( $Param{ClassID} ) ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "The ClassID parameter needs to be an integer",
        );
        return;
    }

    # get class list
    my $ClassList = $Kernel::OM->Get('Kernel::System::GeneralCatalog')->ItemList(
        Class => 'ITSM::ConfigItem::Class',
    );

    # check class list for validity
    if ( !IsHashRefWithData($ClassList) ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "Unable to retrieve a valid class list!",
        );
        return;
    }

    # get the class name from the class list
    my $Class = $ClassList->{ $Param{ClassID} };

    # check class for validity
    if ( !IsStringWithData($Class) ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "Unable to determine a config item class using the given ClassID!",
        );
        return;
    }
    elsif ( $Kernel::OM->Get('Kernel::Config')->{Debug} > 0 ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'debug',
            Message  => "Resolved ClassID $Param{ClassID} to class $Class",
        );
    }

    # get the uniqueness scope from SysConfig
    my $Scope = $Kernel::OM->Get('Kernel::Config')->Get('UniqueCIName::UniquenessCheckScope');

    # check scope for validity
    if ( !IsStringWithData($Scope) ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "The configuration of UniqueCIName::UniquenessCheckScope is invalid!",
        );

        return;
    }

    if ( $Scope ne 'global' && $Scope ne 'class' ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "UniqueCIName::UniquenessCheckScope is $Scope, but must be either "
                . "'global' or 'class'!",
        );

        return;
    }

    if ( $Kernel::OM->Get('Kernel::Config')->{Debug} > 0 ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'debug',
            Message  => "The scope for checking the uniqueness is $Scope",
        );
    }

    my %SearchCriteria;

    # add the config item class to the search criteria if the uniqueness scope is not global
    if ( $Scope ne 'global' ) {
        $SearchCriteria{ClassIDs} = [ $Param{ClassID} ];
    }

    $SearchCriteria{Name} = $Param{Name};

    # search for a config item matching the given name
    my @ConfigItemIDs = $Self->ConfigItemSearch(
        %SearchCriteria,
        Result => 'ARRAY'
    );

    # remove the provided ConfigItemID from the results, otherwise the duplicate check would fail
    # because the ConfigItem itself is found as duplicate
    my @Duplicates = grep { $_ ne $Param{ConfigItemID} } @ConfigItemIDs;

    # if a config item was found, the given name is not unique
    # if no config item was found, the given name is unique

    # return the result of the config item search for duplicates
    return \@Duplicates;
}

=head2 CurInciStateRecalc()

recalculates the current incident state of this config item and of all linked config items.

The current incident state depends on the incident states that this config depends on.
A change of the incident state might have repercussions on the current incident state
of the config item that depend on this config item.

    my $Success = $ConfigItemObject->CurInciStateRecalc(
        ConfigItemID               => 123,
        NewConfigItemIncidentState => $NewConfigItemIncidentState,  # optional, incident states of already checked CIs
        ScannedConfigItemIDs       => $ScannedConfigItemIDs,        # optional, IDs of already checked CIs
    );

=cut

sub CurInciStateRecalc {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    if ( !$Param{ConfigItemID} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => 'Need ConfigItemID!',
        );
        return;
    }

    # get incident link types and directions from config
    my $IncidentLinkTypeDirection = $Kernel::OM->Get('Kernel::Config')->Get('ITSM::Core::IncidentLinkTypeDirection');

    # to store the new incident state for CIs
    # calculated from all incident link types
    # Incorporate data from previous run(s) and remember known data.
    $Param{NewConfigItemIncidentState} //= {};
    my $KnownNewConfigItemIncidentState = Storable::dclone( $Param{NewConfigItemIncidentState} );

    # to store the relation between services and linked CIs
    my %ServiceCIRelation;

    # remember the scanned config items
    # Incorporate data from previous run(s) and remember known data.
    $Param{ScannedConfigItemIDs} //= {};
    my $KnownScannedConfigItemIDs = Storable::dclone( $Param{ScannedConfigItemIDs} );

    # find all config items with an incident state
    $Self->_FindInciConfigItems(
        ConfigItemID              => $Param{ConfigItemID},
        IncidentLinkTypeDirection => $IncidentLinkTypeDirection,
        ScannedConfigItemIDs      => $Param{ScannedConfigItemIDs},
    );

    # calculate the new CI incident state for each configured linktype
    LINKTYPE:
    for my $LinkType ( sort keys %{$IncidentLinkTypeDirection} ) {

        # get the direction
        my $LinkDirection = $IncidentLinkTypeDirection->{$LinkType};

        # investigate all config items with a warning state
        CONFIGITEMID:
        for my $ConfigItemID ( sort keys %{ $Param{ScannedConfigItemIDs} } ) {

            # Skip config items known from previous execution(s).
            if (
                IsStringWithData( $KnownScannedConfigItemIDs->{$ConfigItemID}->{Type} )
                && $KnownScannedConfigItemIDs->{$ConfigItemID}->{Type} eq
                $Param{ScannedConfigItemIDs}->{$ConfigItemID}->{Type}
                )
            {
                next CONFIGITEMID;
            }

            # investigate only config items with an incident state
            next CONFIGITEMID if $Param{ScannedConfigItemIDs}->{$ConfigItemID}->{Type} ne 'incident';

            $Self->_FindWarnConfigItems(
                ConfigItemID         => $ConfigItemID,
                LinkType             => $LinkType,
                Direction            => $LinkDirection,
                NumberOfLinkTypes    => scalar keys %{$IncidentLinkTypeDirection},
                ScannedConfigItemIDs => $Param{ScannedConfigItemIDs},
            );
        }

        CONFIGITEMID:
        for my $ConfigItemID ( sort keys %{ $Param{ScannedConfigItemIDs} } ) {

            # Skip config items known from previous execution(s).
            if (
                IsStringWithData( $KnownScannedConfigItemIDs->{$ConfigItemID}->{Type} )
                && $KnownScannedConfigItemIDs->{$ConfigItemID}->{Type} eq
                $Param{ScannedConfigItemIDs}->{$ConfigItemID}->{Type}
                )
            {
                next CONFIGITEMID;
            }

            # extract incident state type
            my $InciStateType = $Param{ScannedConfigItemIDs}->{$ConfigItemID}->{Type};

            # find all linked services of this CI
            my %LinkedServiceIDs = $Kernel::OM->Get('Kernel::System::LinkObject')->LinkKeyList(
                Object1   => 'ITSMConfigItem',
                Key1      => $ConfigItemID,
                Object2   => 'Service',
                State     => 'Valid',
                Type      => $LinkType,
                Direction => $LinkDirection,
                UserID    => 1,
            );

            SERVICEID:
            for my $ServiceID ( sort keys %LinkedServiceIDs ) {

                # remember the CIs that are linked with this service
                push @{ $ServiceCIRelation{$ServiceID} }, $ConfigItemID;
            }

            next CONFIGITEMID if $InciStateType eq 'incident';

            $Param{NewConfigItemIncidentState}->{$ConfigItemID} = $InciStateType;
        }
    }

    # get the incident state list of warnings
    my $WarnStateList = $Kernel::OM->Get('Kernel::System::GeneralCatalog')->ItemList(
        Class       => 'ITSM::Core::IncidentState',
        Preferences => {
            Functionality => 'warning',
        },
    );

    if ( !defined $WarnStateList ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "ITSM::Core::IncidentState Warning cannot be invalid.",
        );
    }

    my %ReverseWarnStateList = reverse %{$WarnStateList};
    my @SortedWarnList       = sort keys %ReverseWarnStateList;
    my $WarningStateID       = $ReverseWarnStateList{Warning} || $ReverseWarnStateList{ $SortedWarnList[0] };
    my $CacheObject          = $Kernel::OM->Get('Kernel::System::Cache');

    # set the new current incident state for CIs
    CONFIGITEMID:
    for my $ConfigItemID ( sort keys %{ $Param{NewConfigItemIncidentState} } ) {

        # Skip config items known from previous execution(s).
        if (
            IsStringWithData( $KnownNewConfigItemIncidentState->{$ConfigItemID} )
            && $KnownNewConfigItemIncidentState->{$ConfigItemID} eq $Param{NewConfigItemIncidentState}->{$ConfigItemID}
            )
        {
            next CONFIGITEMID;
        }

        # get new incident state type (can only be 'operational' or 'warning')
        my $InciStateType = $Param{NewConfigItemIncidentState}->{$ConfigItemID};

        # get last version
        my $LastVersion = $Self->ConfigItemGet(
            ConfigItemID  => $ConfigItemID,
            DynamicFields => 0,
        );

        my $CurInciStateID;
        if ( $InciStateType eq 'warning' ) {

            # check the current incident state type is in 'incident'
            # then we do not want to change it to warning
            next CONFIGITEMID if $LastVersion->{InciStateType} eq 'incident';

            $CurInciStateID = $WarningStateID;
        }
        elsif ( $InciStateType eq 'operational' ) {
            $CurInciStateID = $LastVersion->{InciStateID};
        }

        # No update necessary if incident state id of version and config item match.
        next CONFIGITEMID if $LastVersion->{CurInciStateID} eq $CurInciStateID;

        # update current incident state
        $Kernel::OM->Get('Kernel::System::DB')->Do(
            SQL  => 'UPDATE configitem SET cur_inci_state_id = ? WHERE id = ?',
            Bind => [ \$CurInciStateID, \$ConfigItemID ],
        );

        # TODO: Instead of deleting, if present, update cache with new cur_inci
        # TODO: Also the VersionID-caches have to be considered, they also contain CurInciState
        # delete the cache
        for my $DFData ( 0, 1 ) {
            $CacheObject->Delete(
                Type => $Self->{CacheType},
                Key  => join(
                    '::', 'ConfigItemGet',
                    ConfigItemID => $ConfigItemID,
                    DFData       => $DFData
                ),
            );
        }

        # TODO: not necessary, is it?
        $CacheObject->Delete(
            Type => $Self->{CacheType},
            Key  => 'VersionNameGet::ConfigItemID::' . $ConfigItemID,
        );

        # TODO: Check what is necessary here
        # delete affected caches for last version
        my $VersionList = $Self->VersionList(
            ConfigItemID => $ConfigItemID,
        );
        my $VersionID = $VersionList->[-1];

        $CacheObject->Delete(
            Type => $Self->{CacheType},
            Key  => 'VersionNameGet::VersionID::' . $VersionID,
        );
    }

    # set the current incident state type for each service (influenced by linked CIs)
    SERVICEID:
    for my $ServiceID ( sort keys %ServiceCIRelation ) {

        # set default incident state type
        my $CurInciStateTypeFromCIs = 'operational';

        # get the unique config item ids which are direcly linked to this service
        my %UniqueConfigItemIDs = map { $_ => 1 } @{ $ServiceCIRelation{$ServiceID} };

        # investigate the current incident state of each config item
        CONFIGITEMID:
        for my $ConfigItemID ( sort keys %UniqueConfigItemIDs ) {

            # get config item data
            my $ConfigItemData = $Self->ConfigItemGet(
                ConfigItemID => $ConfigItemID,
                Cache        => 0,
            );

            next CONFIGITEMID if $ConfigItemData->{CurDeplStateType} ne 'productive';
            next CONFIGITEMID if $ConfigItemData->{CurInciStateType} eq 'operational';

            # check if service must be set to 'warning'
            if ( $ConfigItemData->{CurInciStateType} eq 'warning' ) {
                $CurInciStateTypeFromCIs = 'warning';
                next CONFIGITEMID;
            }

            # check if service must be set to 'incident'
            if ( $ConfigItemData->{CurInciStateType} eq 'incident' ) {
                $CurInciStateTypeFromCIs = 'incident';
                last CONFIGITEMID;
            }
        }

        # update the current incident state type from CIs of the service
        $Kernel::OM->Get('Kernel::System::Service')->ServicePreferencesSet(
            ServiceID => $ServiceID,
            Key       => 'CurInciStateTypeFromCIs',
            Value     => $CurInciStateTypeFromCIs,
            UserID    => 1,
        );
    }

    return 1;
}

=head1 INTERNAL INTERFACE

=head2 _FindInciConfigItems()

find all config items with an incident state

    $ConfigItemObject->_FindInciConfigItems(
        ConfigItemID              => $ConfigItemID,
        IncidentLinkTypeDirection => $IncidentLinkTypeDirection,
        ScannedConfigItemIDs     => \%ScannedConfigItemIDs,
    );

=cut

sub _FindInciConfigItems {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    return if !$Param{ConfigItemID};

    # ignore already scanned ids (infinite loop protection)
    return if $Param{ScannedConfigItemIDs}->{ $Param{ConfigItemID} };

    $Param{ScannedConfigItemIDs}->{ $Param{ConfigItemID} }->{Type} = 'operational';

    # add own config item id to list of linked config items
    my %ConfigItemIDs = (
        $Param{ConfigItemID} => 1,
    );

    LINKTYPE:
    for my $LinkType ( sort keys %{ $Param{IncidentLinkTypeDirection} } ) {

        # find all linked config items (childs)
        my %LinkedConfigItemIDs = $Kernel::OM->Get('Kernel::System::LinkObject')->LinkKeyList(
            Object1 => 'ITSMConfigItem',
            Key1    => $Param{ConfigItemID},
            Object2 => 'ITSMConfigItem',
            State   => 'Valid',
            Type    => $LinkType,

            # Direction must ALWAYS be 'Both' here as we need to include
            # all linked CIs that could influence this one!
            Direction => 'Both',

            UserID => 1,
        );

        # remember the config item ids
        %ConfigItemIDs = ( %ConfigItemIDs, %LinkedConfigItemIDs );
    }

    CONFIGITEMID:
    for my $ConfigItemID ( sort keys %ConfigItemIDs ) {

        # get config item data
        my $ConfigItem = $Self->ConfigItemGet(
            ConfigItemID => $ConfigItemID,
            Cache        => 0,
        );

        # set incident state
        if ( $ConfigItem->{CurInciStateType} eq 'incident' ) {
            $Param{ScannedConfigItemIDs}->{$ConfigItemID}->{Type} = 'incident';
            next CONFIGITEMID;
        }

        # start recursion
        $Self->_FindInciConfigItems(
            ConfigItemID              => $ConfigItemID,
            IncidentLinkTypeDirection => $Param{IncidentLinkTypeDirection},
            ScannedConfigItemIDs      => $Param{ScannedConfigItemIDs},
        );
    }

    return 1;
}

=head2 _FindWarnConfigItems()

find all config items with a warning

    $ConfigItemObject->_FindWarnConfigItems(
        ConfigItemID         => $ConfigItemID,
        LinkType             => $LinkType,
        Direction            => $LinkDirection,
        NumberOfLinkTypes    => 2,
        ScannedConfigItemIDs => $ScannedConfigItemIDs,
    );

=cut

sub _FindWarnConfigItems {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    return if !$Param{ConfigItemID};

    my $IncidentCount = 0;
    for my $ConfigItemID ( sort keys %{ $Param{ScannedConfigItemIDs} } ) {
        if (
            $Param{ScannedConfigItemIDs}->{$ConfigItemID}->{Type}
            && $Param{ScannedConfigItemIDs}->{$ConfigItemID}->{Type} eq 'incident'
            )
        {
            $IncidentCount++;
        }
    }

    # ignore already scanned ids (infinite loop protection)
    # it is ok that a config item is investigated as many times as there are configured link types * number of incident config iteems
    if (
        $Param{ScannedConfigItemIDs}->{ $Param{ConfigItemID} }->{FindWarn}
        && $Param{ScannedConfigItemIDs}->{ $Param{ConfigItemID} }->{FindWarn}
        >= ( $Param{NumberOfLinkTypes} * $IncidentCount )
        )
    {
        return;
    }

    # increase the visit counter
    $Param{ScannedConfigItemIDs}->{ $Param{ConfigItemID} }->{FindWarn}++;

    # find all linked config items
    my %LinkedConfigItemIDs = $Kernel::OM->Get('Kernel::System::LinkObject')->LinkKeyList(
        Object1   => 'ITSMConfigItem',
        Key1      => $Param{ConfigItemID},
        Object2   => 'ITSMConfigItem',
        State     => 'Valid',
        Type      => $Param{LinkType},
        Direction => $Param{Direction},
        UserID    => 1,
    );

    CONFIGITEMID:
    for my $ConfigItemID ( sort keys %LinkedConfigItemIDs ) {

        # start recursion
        $Self->_FindWarnConfigItems(
            ConfigItemID         => $ConfigItemID,
            LinkType             => $Param{LinkType},
            Direction            => $Param{Direction},
            NumberOfLinkTypes    => $Param{NumberOfLinkTypes},
            ScannedConfigItemIDs => $Param{ScannedConfigItemIDs},
        );

        next CONFIGITEMID
            if $Param{ScannedConfigItemIDs}->{$ConfigItemID}->{Type}
            && $Param{ScannedConfigItemIDs}->{$ConfigItemID}->{Type} eq 'incident';

        # set warning state
        $Param{ScannedConfigItemIDs}->{$ConfigItemID}->{Type} = 'warning';
    }

    return 1;
}

=head2 _PrepareLikeString()

internal function to prepare like strings

    $ConfigItemObject->_PrepareLikeString( $StringRef );

=cut

sub _PrepareLikeString {
    my ( $Self, $Value ) = @_;

    return if !$Value;
    return if ref $Value ne 'SCALAR';

    # Quote
    ${$Value} = $Kernel::OM->Get('Kernel::System::DB')->Quote( ${$Value}, 'Like' );

    # replace * with %
    ${$Value} =~ s{ \*+ }{%}xmsg;

    return;
}

=head1 ITSM Config Item events:

ConfigItemCreate, VersionCreate, DeploymentStateUpdate, IncidentStateUpdate,
ConfigItemDelete, LinkAdd, LinkDelete, DefinitionUpdate, NameUpdate, ValueUpdate
DefinitionCreate, VersionDelete

=cut

1;

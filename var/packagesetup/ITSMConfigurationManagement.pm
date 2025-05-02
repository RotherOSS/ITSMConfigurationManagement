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

package var::packagesetup::ITSMConfigurationManagement;

use v5.24;
use strict;
use warnings;
use namespace::autoclean;
use utf8;

# core modules
use List::Util qw(pairs);

# CPAN modules

# OTOBO modules
use Kernel::Language              qw(Translatable);
use Kernel::System::VariableCheck qw(IsHashRefWithData);

our @ObjectDependencies = (
    'Kernel::System::DB',
    'Kernel::System::DynamicField',
    'Kernel::System::DynamicField::Backend',
    'Kernel::System::GeneralCatalog',
    'Kernel::System::GeneralCatalog::PreferencesDB',
    'Kernel::System::GenericInterface::Webservice',
    'Kernel::System::Group',
    'Kernel::System::ITSMConfigItem',
    'Kernel::System::LinkObject',
    'Kernel::System::Log',
    'Kernel::System::Service',
    'Kernel::System::Stats',
    'Kernel::System::Valid',
);

=head1 NAME

var::packagesetup::ITSMConfigurationManagement - code to execute during package installation

=head1 DESCRIPTION

Functions for installing the ITSMConfigurationManagement package.

=head1 PUBLIC INTERFACE

=head2 new()

create an object

    use Kernel::System::ObjectManager;

    local $Kernel::OM = Kernel::System::ObjectManager->new();
    my $CodeObject = $Kernel::OM->Get('var::packagesetup::ITSMConfigurationManagement');

=cut

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = bless {}, $Type;

    # Force a reload of ZZZAuto.pm and ZZZAAuto.pm to get the fresh configuration values.
    for my $Module ( sort keys %INC ) {
        if ( $Module =~ m/ZZZAA?uto\.pm$/ ) {
            delete $INC{$Module};
        }
    }

    # Create common objects with fresh default config.
    $Kernel::OM->ObjectsDiscard();

    # define UserID parameter for the constructor of the stats object
    $Kernel::OM->ObjectParamAdd(
        'Kernel::System::Stats' => {
            UserID => 1,
        },
    );

    # define file prefix for stats
    $Self->{StatsFilePrefix} = 'ITSMStats';

    return $Self;
}

=head2 CodeInstall()

run the code install part

    my $Result = $CodeObject->CodeInstall();

=cut

sub CodeInstall {
    my ( $Self, %Param ) = @_;

    # add the group itsm-configitem
    $Self->_GroupAdd(
        Name        => 'itsm-configitem',
        Description => 'Group for ITSM ConfigItem mask access in the agent interface.',
    );

    # fill up empty last_version_id rows in C<configitem> table
    $Self->_FillupEmptyLastVersionID();

    # fill up empty inci_state_id rows in C<configitem_version> table
    $Self->_FillupEmptyVersionIncidentStateID();

    # fill up empty C<cur_depl_state_id> or C<cur_inci_state_id> rows in C<configitem> table
    $Self->_FillupEmptyIncidentAndDeploymentStateID();

    # set preferences for deployment states
    $Self->_SetDeploymentStatePreferences();

    # add the ConfigItem management invoker to the Elasticsearch webservice
    $Self->_UpdateElasticsearchWebService( Action => 'Add' );

    # install stats
    $Kernel::OM->Get('Kernel::System::Stats')->StatsInstall(
        FilePrefix => $Self->{StatsFilePrefix},
        UserID     => 1,
    );

    return 1;
}

=head2 CodeReinstall()

run the code reinstall part

    my $Result = $CodeObject->CodeReinstall();

=cut

sub CodeReinstall {
    my ( $Self, %Param ) = @_;

    # add the group itsm-configitem
    $Self->_GroupAdd(
        Name        => 'itsm-configitem',
        Description => 'Group for ITSM ConfigItem mask access in the agent interface.',
    );

    # fill up empty last_version_id rows in C<configitem> table
    $Self->_FillupEmptyLastVersionID();

    # fill up empty inci_state_id rows in C<configitem_version> table
    $Self->_FillupEmptyVersionIncidentStateID();

    # fill up empty cur_depl_state_id or cur_inci_state_id rows in C<configitem> table
    $Self->_FillupEmptyIncidentAndDeploymentStateID();

    # set preferences for some deployment states
    $Self->_SetDeploymentStatePreferences();

    # install stats
    $Kernel::OM->Get('Kernel::System::Stats')->StatsInstall(
        FilePrefix => $Self->{StatsFilePrefix},
        UserID     => 1,
    );

    return 1;
}

=head2 CodeUpgradeFromLowerThan_10_0_3()

This function is only executed if the installed module version is smaller than 10.0.3.

my $Result = $CodeObject->CodeUpgradeFromLowerThan_10_0_3();

=cut

sub CodeUpgradeFromLowerThan_10_0_3 {    ## no critic qw(OTOBO::RequireCamelCase)
    my ( $Self, %Param ) = @_;

    # add the ConfigItem management invoker to the Elasticsearch webservice
    $Self->_UpdateElasticsearchWebService( Action => 'Add' );

    return 1;
}

=head2 CodeUpgrade()

run the code upgrade part

    my $Result = $CodeObject->CodeUpgrade();

=cut

sub CodeUpgrade {
    my ( $Self, %Param ) = @_;

    # fill up empty last_version_id rows in C<configitem> table
    $Self->_FillupEmptyLastVersionID();

    # fill up empty inci_state_id rows in C<configitem_version> table
    $Self->_FillupEmptyVersionIncidentStateID();

    # fill up empty cur_depl_state_id or cur_inci_state_id rows in C<configitem> table
    $Self->_FillupEmptyIncidentAndDeploymentStateID();

    # set preferences for some deployment states
    $Self->_SetDeploymentStatePreferences();

    # install stats
    $Kernel::OM->Get('Kernel::System::Stats')->StatsInstall(
        FilePrefix => $Self->{StatsFilePrefix},
        UserID     => 1,
    );

    return 1;
}

=head2 CodeUninstall()

run the code uninstall part

    my $Result = $CodeObject->CodeUninstall();

=cut

sub CodeUninstall {
    my ( $Self, %Param ) = @_;

    # delete all dynamic fields:
    # of object type config item
    # of field type ITSMConfigItemReference and ITSMConfigItemVersionReference
    $Self->_DynamicFieldsDelete();

    # delete all links with configuration items
    $Self->_LinkDelete();

    # deactivate the group C<itsm-configitem>
    $Self->_GroupDeactivate(
        Name => 'itsm-configitem',
    );

    # delete 'CurInciStateTypeFromCIs' service preferences
    $Self->_DeleteServicePreferences();

    # remove the ConfigItem management invoker from the Elasticsearch webservice
    $Self->_UpdateElasticsearchWebService( Action => 'Remove' );

    return 1;
}

=head2 CodeUninstallPost()

run the code uninstall post part

using a post function because config item definitions hold a foreign key constraint on config item class items

    my $Result = $CodeObject->CodeUninstallPost();

=cut

sub CodeUninstallPost {
    my ( $Self, %Param ) = @_;

    # delete general catalog classes:
    #   ITSM::ConfigItem::Class
    #   ITSM::ConfigItem::Role
    #   ITSM::ConfigItem::Class::Category
    $Self->_GeneralCatalogClassesDelete();

    return 1;
}

=head2 _SetDeploymentStatePreferences()

    my $Result = $CodeObject->_SetDeploymentStatePreferences()

=cut

sub _SetDeploymentStatePreferences {
    my ( $Self, %Param ) = @_;

    my %Map = (
        Expired     => 'productive',
        Inactive    => 'postproductive',
        Maintenance => 'productive',
        Pilot       => 'productive',
        Planned     => 'preproductive',
        Production  => 'productive',
        Repair      => 'productive',
        Retired     => 'postproductive',
        Review      => 'productive',
        'Test/QA'   => 'preproductive',
    );

    NAME:
    for my $Name ( sort keys %Map ) {
        my $Item = $Kernel::OM->Get('Kernel::System::GeneralCatalog')->ItemGet(
            Name  => $Name,
            Class => 'ITSM::ConfigItem::DeploymentState',
        );

        next NAME if !$Item;

        $Kernel::OM->Get('Kernel::System::GeneralCatalog')->GeneralCatalogPreferencesSet(
            ItemID => $Item->{ItemID},
            Key    => 'Functionality',
            Value  => [ $Map{$Name} ],
        );
    }

    return 1;
}

=head2 _GroupAdd()

add a group

    my $Result = $CodeObject->_GroupAdd(
        Name        => 'the-group-name',
        Description => 'The group description.',
    );

=cut

sub _GroupAdd {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Argument (qw(Name Description)) {
        if ( !$Param{$Argument} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Argument!",
            );
            return;
        }
    }

    # get valid list
    my %ValidList = $Kernel::OM->Get('Kernel::System::Valid')->ValidList(
        UserID => 1,
    );
    my %ValidListReverse = reverse %ValidList;

    # get list of all groups
    my %GroupList = $Kernel::OM->Get('Kernel::System::Group')->GroupList();

    # reverse the group list for easier lookup
    my %GroupListReverse = reverse %GroupList;

    # check if group already exists
    my $GroupID = $GroupListReverse{ $Param{Name} };

    # reactivate the group
    if ($GroupID) {

        # get current group data
        my %GroupData = $Kernel::OM->Get('Kernel::System::Group')->GroupGet(
            ID     => $GroupID,
            UserID => 1,
        );

        # reactivate group
        $Kernel::OM->Get('Kernel::System::Group')->GroupUpdate(
            %GroupData,
            ValidID => $ValidListReverse{valid},
            UserID  => 1,
        );

        return 1;
    }

    # add the group
    else {
        return if !$Kernel::OM->Get('Kernel::System::Group')->GroupAdd(
            Name    => $Param{Name},
            Comment => $Param{Description},
            ValidID => $ValidListReverse{valid},
            UserID  => 1,
        );
    }

    # lookup the new group id
    my $NewGroupID = $Kernel::OM->Get('Kernel::System::Group')->GroupLookup(
        Group  => $Param{Name},
        UserID => 1,
    );

    # add user root to the group
    $Kernel::OM->Get('Kernel::System::Group')->GroupMemberAdd(
        GID        => $NewGroupID,
        UID        => 1,
        Permission => {
            ro        => 1,
            move_into => 1,
            create    => 1,
            owner     => 1,
            priority  => 1,
            rw        => 1,
        },
        UserID => 1,
    );

    return 1;
}

=head2 _GroupDeactivate()

deactivate a group

    my $Result = $CodeObject->_GroupDeactivate(
        Name => 'the-group-name',
    );

=cut

sub _GroupDeactivate {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    if ( !$Param{Name} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => 'Need Name!',
        );
        return;
    }

    # lookup group id
    my $GroupID = $Kernel::OM->Get('Kernel::System::Group')->GroupLookup(
        Group => $Param{Name},
    );

    return if !$GroupID;

    # get valid list
    my %ValidList = $Kernel::OM->Get('Kernel::System::Valid')->ValidList(
        UserID => 1,
    );
    my %ValidListReverse = reverse %ValidList;

    # get current group data
    my %GroupData = $Kernel::OM->Get('Kernel::System::Group')->GroupGet(
        ID     => $GroupID,
        UserID => 1,
    );

    # deactivate group
    $Kernel::OM->Get('Kernel::System::Group')->GroupUpdate(
        %GroupData,
        ValidID => $ValidListReverse{invalid},
        UserID  => 1,
    );

    return 1;
}

# TODO verify if all relevant links are deleted

=head2 _LinkDelete()

delete all existing links to configuration items

    my $Result = $CodeObject->_LinkDelete();

=cut

sub _LinkDelete {
    my ( $Self, %Param ) = @_;

    # get all configuration items
    my $ConfigItemIDs = $Kernel::OM->Get('Kernel::System::ITSMConfigItem')->ConfigItemSearch();

    return if !$ConfigItemIDs;
    return if ref $ConfigItemIDs ne 'ARRAY';

    # delete the configuration item links
    for my $ConfigItemID ( @{$ConfigItemIDs} ) {
        $Kernel::OM->Get('Kernel::System::LinkObject')->LinkDeleteAll(
            Object => 'ITSMConfigItem',
            Key    => $ConfigItemID,
            UserID => 1,
        );
    }

    return 1;
}

=head2 _FillupEmptyLastVersionID()

fill up empty entries in the last_version_id column of the C<configitem> table

    my $Result = $CodeObject->_FillupEmptyLastVersionID();

=cut

sub _FillupEmptyLastVersionID {
    my ( $Self, %Param ) = @_;

    # get configuration items with empty last_version_id
    $Kernel::OM->Get('Kernel::System::DB')->Prepare(
        SQL => 'SELECT id FROM configitem WHERE '
            . 'last_version_id = 0 OR last_version_id IS NULL',
    );

    # fetch the result
    my @ConfigItemIDs;
    while ( my @Row = $Kernel::OM->Get('Kernel::System::DB')->FetchrowArray() ) {
        push @ConfigItemIDs, $Row[0];
    }

    CONFIGITEMID:
    for my $ConfigItemID (@ConfigItemIDs) {

        # get the last version of this configuration item
        $Kernel::OM->Get('Kernel::System::DB')->Prepare(
            SQL => 'SELECT id FROM configitem_version '
                . 'WHERE configitem_id = ? ORDER BY id DESC',
            Bind  => [ \$ConfigItemID ],
            Limit => 1,
        );

        # fetch the result
        my $VersionID;
        while ( my @Row = $Kernel::OM->Get('Kernel::System::DB')->FetchrowArray() ) {
            $VersionID = $Row[0];
        }

        next CONFIGITEMID if !$VersionID;

        # update C<inci_state_id>
        $Kernel::OM->Get('Kernel::System::DB')->Do(
            SQL => 'UPDATE configitem '
                . 'SET last_version_id = ? '
                . 'WHERE id = ?',
            Bind => [ \$VersionID, \$ConfigItemID ],
        );
    }

    return 1;
}

=head2 _FillupEmptyVersionIncidentStateID()

fill up empty entries in the C<inci_state_id column> of the C<configitem_version> table

    my $Result = $CodeObject->_FillupEmptyVersionIncidentStateID();

=cut

sub _FillupEmptyVersionIncidentStateID {
    my ( $Self, %Param ) = @_;

    # get operational incident state list
    my $InciStateList = $Kernel::OM->Get('Kernel::System::GeneralCatalog')->ItemList(
        Class       => 'ITSM::Core::IncidentState',
        Preferences => {
            Functionality => 'operational',
        },
    );

    # error handling
    if ( !$InciStateList || ref $InciStateList ne 'HASH' || !%{$InciStateList} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "Can't find any item in general catalog class ITSM::Core::IncidentState!",
        );
        return;
    }

    # sort ids
    my @InciStateKeyList = sort keys %{$InciStateList};

    # update inci_state_id
    return $Kernel::OM->Get('Kernel::System::DB')->Do(
        SQL => 'UPDATE configitem_version '
            . 'SET inci_state_id = ? '
            . 'WHERE inci_state_id = 0 OR inci_state_id IS NULL',
        Bind => [ \$InciStateKeyList[0] ],
    );
}

=head2 _FillupEmptyIncidentAndDeploymentStateID()

fill up empty entries in the cur_depl_state_id or cur_inci_state_id column of the C<configitem> table

    my $Result = $CodeObject->_FillupEmptyIncidentAndDeploymentStateID();

=cut

sub _FillupEmptyIncidentAndDeploymentStateID {
    my ( $Self, %Param ) = @_;

    # get configuration items with empty cur_depl_state_id or cur_inci_state_id
    $Kernel::OM->Get('Kernel::System::DB')->Prepare(
        SQL => 'SELECT id FROM configitem WHERE '
            . 'cur_depl_state_id = 0 OR cur_depl_state_id IS NULL OR '
            . 'cur_inci_state_id = 0 OR cur_inci_state_id IS NULL',
    );

    # fetch the result
    my @ConfigItemIDs;
    while ( my @Row = $Kernel::OM->Get('Kernel::System::DB')->FetchrowArray() ) {
        push @ConfigItemIDs, $Row[0];
    }

    CONFIGITEMID:
    for my $ConfigItemID (@ConfigItemIDs) {

        # get last version
        my $LastVersion = $Kernel::OM->Get('Kernel::System::ITSMConfigItem')->VersionGet(
            ConfigItemID => $ConfigItemID,
        );

        next CONFIGITEMID if !$LastVersion;
        next CONFIGITEMID if ref $LastVersion ne 'HASH';
        next CONFIGITEMID if !$LastVersion->{DeplStateID};
        next CONFIGITEMID if !$LastVersion->{InciStateID};

        # complete configuration item
        $Kernel::OM->Get('Kernel::System::DB')->Do(
            SQL => 'UPDATE configitem SET '
                . 'cur_depl_state_id = ?, '
                . 'cur_inci_state_id = ? '
                . 'WHERE id = ?',
            Bind => [
                \$LastVersion->{DeplStateID},
                \$LastVersion->{InciStateID},
                \$ConfigItemID,
            ],
        );
    }

    return 1;
}

=head2 _DeleteServicePreferences()

Deletes the service preferences for the key 'CurInciStateTypeFromCIs'.

    my $Result = $CodeObject->_DeleteServicePreferences();

=cut

sub _DeleteServicePreferences {
    my ( $Self, %Param ) = @_;

    # get service list
    my %ServiceList = $Kernel::OM->Get('Kernel::System::Service')->ServiceList(
        Valid  => 0,
        UserID => 1,
    );

    SERVICEID:
    for my $ServiceID ( sort keys %ServiceList ) {

        # delete the current incident state type from CIs of the service
        $Kernel::OM->Get('Kernel::System::Service')->ServicePreferencesSet(
            ServiceID => $ServiceID,
            Key       => 'CurInciStateTypeFromCIs',
            Value     => '',
            UserID    => 1,
        );
    }

    return 1;
}

=head2 _UpdateElasticsearchWebService()

Adds the ConfigItem management invoker.

    my $Result = $CodeObject->_UpdateElasticsearchWebService(
        Mode => 'Add|Remove'
    );

=cut

sub _UpdateElasticsearchWebService {
    my ( $Self, %Param ) = @_;

    my $WebserviceObject = $Kernel::OM->Get('Kernel::System::GenericInterface::Webservice');
    my $Webservice       = $WebserviceObject->WebserviceGet(
        Name => 'Elasticsearch',
    );

    if ( !$Webservice ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "Did not find the Elasticsearch webservice!",
        );
        return;
    }

    if ( $Param{Action} eq 'Add' ) {
        $Webservice->{Config}{Requester}{Invoker}{ConfigItemIngestAttachment} = {
            Description => '',
            Type        => 'Elasticsearch::ConfigItemManagement',
        };
        $Webservice->{Config}{Requester}{Invoker}{ConfigItemManagement} = {
            Description => '',
            Events      => [
                {
                    Asynchronous => '0',
                    Event        => 'ConfigItemCreate',
                },
                {
                    Asynchronous => '0',
                    Event        => 'VersionCreate',
                },
                {
                    Asynchronous => '0',
                    Event        => 'VersionUpdate',
                },
                {
                    Asynchronous => '0',
                    Event        => 'NameUpdate',
                },
                {
                    Asynchronous => '0',
                    Event        => 'DeploymentStateUpdate',
                },
                {
                    Asynchronous => '0',
                    Event        => 'AttachmentAddPost',
                },
                {
                    Asynchronous => '0',
                    Event        => 'AttachmentDeletePost',
                },
                {
                    Asynchronous => '0',
                    Event        => 'ConfigItemDelete',
                },
            ],
            Type => 'Elasticsearch::ConfigItemManagement',
        };
        $Webservice->{Config}{Requester}{Transport}{Config}{InvokerControllerMapping}{ConfigItemIngestAttachment} = {
            Command    => 'POST',
            Controller => '/tmpattachments/:docapi/:id?pipeline=:path',
        };
        $Webservice->{Config}{Requester}{Transport}{Config}{InvokerControllerMapping}{ConfigItemManagement} = {
            Command    => 'POST',
            Controller => '/configitem/:docapi/:id',
        };
    }

    elsif ( $Param{Action} eq 'Remove' ) {
        delete $Webservice->{Config}{Requester}{Invoker}{ConfigItemIngestAttachment};
        delete $Webservice->{Config}{Requester}{Invoker}{ConfigItemManagement};
        delete $Webservice->{Config}{Requester}{Transport}{InvokerControllerMapping}{ConfigItemIngestAttachment};
        delete $Webservice->{Config}{Requester}{Transport}{InvokerControllerMapping}{ConfigItemManagement};
    }

    else {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "No Action provided!",
        );
        return;
    }

    my $Success = $WebserviceObject->WebserviceUpdate(
        %{$Webservice},
        UserID => 1,
    );

    if ( !$Success ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "Could not update the Elasticsearch webservice!",
        );
        return;
    }
    return 1;

}

=head2 _DynamicFieldsDelete()

Deletes the dynamic fields which are related to this package, either because they are of object type ITSMConfigItem or because they are of field type ITSMConfigItemReference or ITSMConfigItemVersionReference.

    my $Result = $CodeObject->_DynamicFieldsDelete();

=cut

sub _DynamicFieldsDelete {
    my ( $Self, %Param ) = @_;

    # get necessary objects
    my $DynamicFieldObject        = $Kernel::OM->Get('Kernel::System::DynamicField');
    my $DynamicFieldBackendObject = $Kernel::OM->Get('Kernel::System::DynamicField::Backend');
    my $LogObject                 = $Kernel::OM->Get('Kernel::System::Log');

    # get all dynamic fields because we can't filter for field type in dynamic field list functions
    my $DynamicFields = $DynamicFieldObject->DynamicFieldListGet(
        Valid => 0,
    );

    DYNAMICFIELD:
    for my $DynamicFieldConfig ( $DynamicFields->@* ) {
        next DYNAMICFIELD unless IsHashRefWithData($DynamicFieldConfig);
        next DYNAMICFIELD
            unless (
                $DynamicFieldConfig->{ObjectType} eq 'ITSMConfigItem'
                || $DynamicFieldConfig->{FieldType} eq 'ITSMConfigItemReference'
                || $DynamicFieldConfig->{FieldType} eq 'ITSMConfigItemVersionReference'
            );

        if ( $DynamicFieldConfig->{InternalField} ) {
            $LogObject->Log(
                'Priority' => 'error',
                'Message'  => "Could not delete internal DynamicField $DynamicFieldConfig->{Name}!",
            );
            next DYNAMICFIELD;
        }

        my $ValuesDeleteSuccess = $DynamicFieldBackendObject->AllValuesDelete(
            DynamicFieldConfig => $DynamicFieldConfig,
            UserID             => 1,
        );

        if ( !$ValuesDeleteSuccess ) {
            $LogObject->Log(
                'Priority' => 'error',
                'Message'  => "Could not delete values for DynamicField $DynamicFieldConfig->{Name}!",
            );
            next DYNAMICFIELD;
        }

        my $Success = $DynamicFieldObject->DynamicFieldDelete(
            ID     => $DynamicFieldConfig->{ID},
            UserID => 1,
        );

        if ( !$Success ) {
            $LogObject->Log(
                'Priority' => 'error',
                'Message'  => "Could not delete DynamicField $DynamicFieldConfig->{Name}!",
            );
            next DYNAMICFIELD;
        }
    }

    return 1;
}

=head2 _GeneralCatalogClassesDelete()

Deletes the general catalog class items which are related to this package and their preferences as well.

    my $Result = $CodeObject->_GeneralCatalogClassesDelete();

=cut

sub _GeneralCatalogClassesDelete {
    my ( $Self, %Param ) = @_;

    # get necessary objects
    my $GeneralCatalogObject = $Kernel::OM->Get('Kernel::System::GeneralCatalog');
    my $PreferencesObject    = $Kernel::OM->Get('Kernel::System::GeneralCatalog::PreferencesDB');
    my $DBObject             = $Kernel::OM->Get('Kernel::System::DB');
    my $LogObject            = $Kernel::OM->Get('Kernel::System::Log');

    my @ClassesToDelete
        = qw(ITSM::ConfigItem::Class ITSM::ConfigItem::Role ITSM::ConfigItem::Class::Category ITSM::ConfigItem::DeploymentState ITSM::ConfigItem::YesNo);

    CLASS:
    for my $Class (@ClassesToDelete) {

        my $ItemList = $GeneralCatalogObject->ItemList(
            Class => $Class,
            Valid => 0,
        );

        next CLASS unless IsHashRefWithData($ItemList);

        for my $Item ( pairs $ItemList->%* ) {
            my ( $ID, $Name ) = $Item->@*;

            # unset preferences of item
            my %Preferences = $PreferencesObject->GeneralCatalogPreferencesGet(
                ItemID => $ID,
            );

            if (%Preferences) {
                for my $Preference ( keys %Preferences ) {
                    $PreferencesObject->GeneralCatalogPreferencesSet(
                        ItemID => $ID,
                        Key    => $Preference,
                        Value  => '',
                    );
                }
            }

            # delete item from database
            my $Success = $DBObject->Do(
                SQL  => 'DELETE FROM general_catalog WHERE id = ?',
                Bind => [
                    \$ID,
                ],
            );
            if ( !$Success ) {
                $LogObject->Log(
                    'Priority' => 'error',
                    'Message'  => "Could not delete GeneralCatalog item $Name!",
                );
                next CLASS;
            }
        }
    }

    return 1;
}

1;

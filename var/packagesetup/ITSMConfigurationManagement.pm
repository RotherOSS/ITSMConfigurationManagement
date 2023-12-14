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

package var::packagesetup::ITSMConfigurationManagement;

use strict;
use warnings;

# core modules

# CPAN modules

# OTOBO modules
use Kernel::Language qw(Translatable);

our @ObjectDependencies = (
    'Kernel::Config',
    'Kernel::System::GenericInterface::Webservice',
    'Kernel::System::DB',
    'Kernel::System::GeneralCatalog',
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

    # install configuration item definitions
    $Self->_AddConfigItemDefinitions();

    # fill up empty last_version_id rows in C<configitem> table
    $Self->_FillupEmptyLastVersionID();

    # fill up empty inci_state_id rows in C<configitem_version> table
    $Self->_FillupEmptyVersionIncidentStateID();

    # fill up empty C<cur_depl_state_id> or C<cur_inci_state_id> rows in C<configitem> table
    $Self->_FillupEmptyIncidentAndDeploymentStateID();

    # set preferences for some configuration items
    $Self->_SetPreferences();

    # set default permission group
    $Self->_SetDefaultPermission();

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

    # install configuration item definitions
    $Self->_AddConfigItemDefinitions();

    # fill up empty last_version_id rows in C<configitem> table
    $Self->_FillupEmptyLastVersionID();

    # fill up empty inci_state_id rows in C<configitem_version> table
    $Self->_FillupEmptyVersionIncidentStateID();

    # fill up empty cur_depl_state_id or cur_inci_state_id rows in C<configitem> table
    $Self->_FillupEmptyIncidentAndDeploymentStateID();

    # set preferences for some configuration items
    $Self->_SetPreferences();

    # set default permission group
    $Self->_SetDefaultPermission();

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

    # install configuration item definitions
    $Self->_AddConfigItemDefinitions();

    # fill up empty last_version_id rows in C<configitem> table
    $Self->_FillupEmptyLastVersionID();

    # fill up empty inci_state_id rows in C<configitem_version> table
    $Self->_FillupEmptyVersionIncidentStateID();

    # fill up empty cur_depl_state_id or cur_inci_state_id rows in C<configitem> table
    $Self->_FillupEmptyIncidentAndDeploymentStateID();

    # set preferences for some configuration items
    $Self->_SetPreferences();

    # set default permission group
    $Self->_SetDefaultPermission();

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

=head2 _SetPreferences()

    my $Result = $CodeObject->_SetPreferences()

=cut

sub _SetPreferences {
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
            Value  => $Map{$Name},
        );
    }

    return 1;
}

=head2 _SetDefaultPermission()

set the default group that has access rights

=cut

sub _SetDefaultPermission {
    my ( $Self, %Param ) = @_;

    # get class list
    my $ClassList = $Kernel::OM->Get('Kernel::System::GeneralCatalog')->ItemList(
        Class => 'ITSM::ConfigItem::Class',
    );

    # check if group already exists
    my $GroupID = $Kernel::OM->Get('Kernel::System::Group')->GroupLookup(
        Group  => 'itsm-configitem',
        UserID => 1,
    );

    # check if a permission group is already set. If not, set default permission group
    for my $ClassID ( sort keys %{$ClassList} ) {
        my $Class = $Kernel::OM->Get('Kernel::System::GeneralCatalog')->ItemGet(
            ItemID => $ClassID,
        );

        if ( !$Class->{Permission} ) {
            $Kernel::OM->Get('Kernel::System::GeneralCatalog')->GeneralCatalogPreferencesSet(
                ItemID => $Class->{ItemID},
                Key    => 'Permission',
                Value  => $GroupID,
            );
        }
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

=head2 _AddConfigItemDefinitions()

installs configuration item definitions

    my $Result = $CodeObject->_AddConfigItemDefinitions();

=cut

sub _AddConfigItemDefinitions {
    my ( $Self, %Param ) = @_;

    # This is needed to extract translatable words from the config item definitions.
    my %Translations = (
        Vendor                 => Translatable('Vendor'),
        Model                  => Translatable('Model'),
        Description            => Translatable('Description'),
        Type                   => Translatable('Type'),
        CustomerCompany        => Translatable('Customer Company'),
        Owner                  => Translatable('Owner'),
        SerialNumber           => Translatable('Serial Number'),
        OperatingSystem        => Translatable('Operating System'),
        CPU                    => Translatable('CPU'),
        Ram                    => Translatable('Ram'),
        HardDisk               => Translatable('Hard Disk'),
        Capacity               => Translatable('Capacity'),
        FQDN                   => Translatable('FQDN'),
        NetworkAdapter         => Translatable('Network Adapter'),
        IPoverDHCP             => Translatable('IP over DHCP'),
        IPAddress              => Translatable('IP Address'),
        GraphicAdapter         => Translatable('Graphic Adapter'),
        OtherEquipment         => Translatable('Other Equipment'),
        WarrantyExpirationDate => Translatable('Warranty Expiration Date'),
        InstallDate            => Translatable('Install Date'),
        Note                   => Translatable('Note'),
        Phone1                 => Translatable('Phone 1'),
        Phone2                 => Translatable('Phone 2'),
        Fax                    => Translatable('Fax'),
        EMail                  => Translatable('E-Mail'),
        Address                => Translatable('Address'),
        NetworkAddress         => Translatable('Network Address'),
        SubnetMask             => Translatable('Subnet Mask'),
        Gateway                => Translatable('Gateway'),
        Version                => Translatable('Version'),
        LicenceType            => Translatable('Licence Type'),
        LicenceKey             => Translatable('Licence Key'),
        Quantity               => Translatable('Quantity'),
        ExpirationDate         => Translatable('Expiration Date'),
        Media                  => Translatable('Media'),
    );

    # Config item definitions.
    my %Definition = (
        Computer => << "EOF",
---
- Key: Vendor
  Name: Vendor
  Searchable: 1
  Input:
    Type: Text
    Size: 50
    MaxLength: 50
    # Example for CI attribute syntax check for text and textarea fields
    #RegEx: ^ABC.*
    #RegExErrorMessage: Value must start with ABC!

- Key: Model
  Name: Model
  Searchable: 1
  Input:
    Type: Text
    Size: 50
    MaxLength: 50

- Key: Description
  Name: Description
  Searchable: 1
  Input:
    Type: TextArea

- Key: Type
  Name: Type
  Searchable: 1
  Input:
    Type: GeneralCatalog
    Class: ITSM::ConfigItem::Computer::Type
    Translation: 1

- Key: CustomerID
  Name: Customer Company
  Searchable: 1
  Input:
    Type: CustomerCompany

- Key: Owner
  Name: Owner
  Searchable: 1
  Input:
    Type: Customer

- Key: SerialNumber
  Name: Serial Number
  Searchable: 1
  Input:
    Type: Text
    Size: 50
    MaxLength: 100

- Key: OperatingSystem
  Name: Operating System
  Input:
    Type: Text
    Size: 50
    MaxLength: 100

- Key: CPU
  Name: CPU
  Input:
    Type: Text
    Size: 50
    MaxLength: 100
  CountMax: 16

- Key: Ram
  Name: Ram
  Input:
    Type: Text
    Size: 50
    MaxLength: 100
  CountMax: 10

- Key: HardDisk
  Name: Hard Disk
  Input:
    Type: Text
    Size: 50
    MaxLength: 100
  CountMax: 10
  Sub:
  - Key: Capacity
    Name: Capacity
    Input:
      Type: Text
      Size: 20
      MaxLength: 10

- Key: FQDN
  Name: FQDN
  Searchable: 1
  Input:
    Type: Text
    Size: 50
    MaxLength: 100

- Key: NIC
  Name: Network Adapter
  Input:
    Type: Text
    Size: 50
    MaxLength: 100
    Required: 1
  CountMin: 0
  CountMax: 10
  CountDefault: 1
  Sub:
  - Key: IPoverDHCP
    Name: IP over DHCP
    Input:
      Type: GeneralCatalog
      Class: ITSM::ConfigItem::YesNo
      Translation: 1
      Required: 1
  - Key: IPAddress
    Name: IP Address
    Searchable: 1
    Input:
      Type: Text
      Size: 40
      MaxLength: 40
      Required: 1
    CountMin: 0
    CountMax: 20
    CountDefault: 0

- Key: GraphicAdapter
  Name: Graphic Adapter
  Input:
    Type: Text
    Size: 50
    MaxLength: 100

- Key: OtherEquipment
  Name: Other Equipment
  Input:
    Type: TextArea
    Required: 1
  CountMin: 0
  CountDefault: 0

- Key: WarrantyExpirationDate
  Name: Warranty Expiration Date
  Searchable: 1
  Input:
    Type: Date
    YearPeriodPast: 20
    YearPeriodFuture: 10

- Key: InstallDate
  Name: Install Date
  Searchable: 1
  Input:
    Type: Date
    Required: 1
    YearPeriodPast: 20
    YearPeriodFuture: 10
  CountMin: 0
  CountDefault: 0

- Key: Note
  Name: Note
  Searchable: 1
  Input:
    Type: TextArea
    Required: 1
  CountMin: 0
  CountDefault: 0
EOF
        Hardware => << "EOF",
---
- Key: Vendor
  Name: Vendor
  Searchable: 1
  Input:
    Type: Text
    Size: 50
    MaxLength: 50

- Key: Model
  Name: Model
  Searchable: 1
  Input:
    Type: Text
    Size: 50
    MaxLength: 50

- Key: Description
  Name: Description
  Searchable: 1
  Input:
    Type: TextArea

- Key: Type
  Name: Type
  Searchable: 1
  Input:
    Type: GeneralCatalog
    Class: ITSM::ConfigItem::Hardware::Type
    Translation: 1

- Key: CustomerID
  Name: Customer Company
  Searchable: 1
  Input:
    Type: CustomerCompany

- Key: Owner
  Name: Owner
  Searchable: 1
  Input:
    Type: Customer

- Key: SerialNumber
  Name: Serial Number
  Searchable: 1
  Input:
    Type: Text
    Size: 50
    MaxLength: 100

- Key: WarrantyExpirationDate
  Name: Warranty Expiration Date
  Searchable: 1
  Input:
    Type: Date
    YearPeriodPast: 20
    YearPeriodFuture: 10

- Key: InstallDate
  Name: Install Date
  Searchable: 1
  Input:
    Type: Date
    Required: 1
    YearPeriodPast: 20
    YearPeriodFuture: 10
  CountMin: 0
  CountMax: 1
  CountDefault: 0

- Key: Note
  Name: Note
  Searchable: 1
  Input:
    Type: TextArea
    Required: 1
  CountMin: 0
  CountMax: 1
  CountDefault: 0
EOF
        Location => << "EOF",
---
- Key: Type
  Name: Type
  Searchable: 1
  Input:
    Type: GeneralCatalog
    Class: ITSM::ConfigItem::Location::Type
    Translation: 1

- Key: CustomerID
  Name: Customer Company
  Searchable: 1
  Input:
    Type: CustomerCompany

- Key: Owner
  Name: Owner
  Searchable: 1
  Input:
    Type: Customer

- Key: Phone1
  Name: Phone 1
  Searchable: 1
  Input:
    Type: Text
    Size: 50
    MaxLength: 100

- Key: Phone2
  Name: Phone 2
  Searchable: 1
  Input:
    Type: Text
    Size: 50
    MaxLength: 100

- Key: Fax
  Name: Fax
  Searchable: 1
  Input:
    Type: Text
    Size: 50
    MaxLength: 100

- Key: E-Mail
  Name: E-Mail
  Searchable: 1
  Input:
    Type: Text
    Size: 50
    MaxLength: 100

- Key: Address
  Name: Address
  Searchable: 1
  Input:
    Type: TextArea

- Key: Note
  Name: Note
  Searchable: 1
  Input:
    Type: TextArea
    Required: 1
  CountMin: 0
  CountDefault: 0
EOF
        Network => << "EOF",
---
- Key: Description
  Name: Description
  Searchable: 1
  Input:
    Type: TextArea

- Key: Type
  Name: Type
  Searchable: 1
  Input:
    Type: GeneralCatalog
    Class: ITSM::ConfigItem::Network::Type
    Translation: 1

- Key: CustomerID
  Name: Customer Company
  Searchable: 1
  Input:
    Type: CustomerCompany

- Key: Owner
  Name: Owner
  Searchable: 1
  Input:
    Type: Customer

- Key: NetworkAddress
  Name: Network Address
  Searchable: 1
  Input:
    Type: Text
    Size: 30
    MaxLength: 20
    Required: 1
  CountMin: 0
  CountMax: 100
  CountDefault: 1
  Sub:
  - Key: SubnetMask
    Name: Subnet Mask
    Input:
      Type: Text
      Size: 30
      MaxLength: 20
      ValueDefault: 255.255.255.0
      Required: 1
    CountMin: 0
    CountMax: 1
    CountDefault: 0
  - Key: Gateway
    Name: Gateway
    Input:
      Type: Text
      Size: 30
      MaxLength: 20
      Required: 1
    CountMin: 0
    CountMax: 10
    CountDefault: 0

- Key: Note
  Name: Note
  Searchable: 1
  Input:
    Required: 1
    Type: TextArea
  CountMin: 0
  CountMax: 1
  CountDefault: 0
EOF
        Software => << "EOF",
---
- Key: Vendor
  Name: Vendor
  Searchable: 1
  Input:
    Type: Text
    Size: 50
    MaxLength: 50

- Key: Version
  Name: Version
  Searchable: 1
  Input:
    Type: Text
    Size: 50
    MaxLength: 50

- Key: Description
  Name: Description
  Searchable: 1
  Input:
    Type: TextArea

- Key: Type
  Name: Type
  Searchable: 1
  Input:
    Type: GeneralCatalog
    Class: ITSM::ConfigItem::Software::Type
    Translation: 1

- Key: CustomerID
  Name: Customer Company
  Searchable: 1
  Input:
    Type: CustomerCompany

- Key: Owner
  Name: Owner
  Searchable: 1
  Input:
    Type: Customer

- Key: SerialNumber
  Name: Serial Number
  Searchable: 1
  Input:
    Type: Text
    Size: 50
    MaxLength: 50

- Key: LicenceType
  Name: Licence Type
  Searchable: 1
  Input:
    Type: GeneralCatalog
    Class: ITSM::ConfigItem::Software::LicenceType
    Translation: 1

- Key: LicenceKey
  Name: Licence Key
  Searchable: 1
  Input:
    Type: Text
    Size: 50
    MaxLength: 50
    Required: 1
  CountMin: 0
  CountMax: 100
  CountDefault: 0
  Sub:
  - Key: Quantity
    Name: Quantity
    Input:
      Type: Integer
      ValueMin: 1
      ValueMax: 1000
      ValueDefault: 1
      Required: 1
    CountMin: 0
    CountMax: 1
    CountDefault: 0
  - Key: ExpirationDate
    Name: Expiration Date
    Input:
      Type: Date
      Required: 1
      YearPeriodPast: 20
      YearPeriodFuture: 10
    CountMin: 0
    CountMax: 1
    CountDefault: 0

- Key: Media
  Name: Media
  Input:
    Type: Text
    Size: 40
    MaxLength: 20

- Key: Note
  Name: Note
  Searchable: 1
  Input:
    Type: TextArea
    Required: 1
  CountMin: 0
  CountMax: 1
  CountDefault: 0
EOF
    );

    # get list of installed configuration item classes
    my $ClassList = $Kernel::OM->Get('Kernel::System::GeneralCatalog')->ItemList(
        Class => 'ITSM::ConfigItem::Class',
    );
    my %ReverseClassList = reverse %{$ClassList};

    CLASSNAME:
    for my $ClassName ( sort { lc $a cmp lc $b } keys %Definition ) {

        # check if class exists
        my $ClassID = $ReverseClassList{$ClassName};

        next CLASSNAME if !$ClassID;

        # check if definition already exists
        my $DefinitionList = $Kernel::OM->Get('Kernel::System::ITSMConfigItem')->DefinitionList(
            ClassID => $ClassID,
        );

        next CLASSNAME if !defined $DefinitionList;
        next CLASSNAME if $DefinitionList && ref $DefinitionList eq 'ARRAY' && @{$DefinitionList};

        # add the new definition
        $Kernel::OM->Get('Kernel::System::ITSMConfigItem')->DefinitionAdd(
            ClassID    => $ClassID,
            Definition => $Definition{$ClassName},
            UserID     => 1,
        );
    }

    return 1;
}

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

1;

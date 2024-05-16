# --
# OTOBO is a web-based ticketing system for service organisations.
# --
# Copyright (C) 2001-2020 OTRS AG, https://otrs.com/
# Copyright (C) 2019-2021 Rother OSS GmbH, https://otobo.de/
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

package Kernel::Language::th_TH_ITSMConfigurationManagement;

use strict;
use warnings;
use utf8;

sub Data {
    my $Self = shift;

    # Template: AdminITSMConfigItem
    $Self->{Translation}->{'Config Item Management'} = 'การจัดการ Config Item';
    $Self->{Translation}->{'Change class definition'} = 'นิยามของคลาสการเปลี่ยนแปลง';
    $Self->{Translation}->{'Config Item Class'} = '';
    $Self->{Translation}->{'Definition'} = 'นิยาม';
    $Self->{Translation}->{'Change'} = 'เปลี่ยน';

    # Template: AgentDashboardITSMConfigItemGeneric
    $Self->{Translation}->{'Incident State'} = 'สถานภาพของเหต์การณ์';
    $Self->{Translation}->{'Deployment State'} = 'สถานภาพการใช้งาน';
    $Self->{Translation}->{'Class'} = 'คลาส';
    $Self->{Translation}->{'Deployment State Type'} = 'ประเภทสถานภาพการใช้งาน';
    $Self->{Translation}->{'Current Incident State'} = 'สถานภาพของเหต์การณ์ปัจจุบัน';
    $Self->{Translation}->{'Current Incident State Type'} = 'ประเภทสถานภาพของเหต์การณ์ปัจจุบัน';
    $Self->{Translation}->{'Last changed'} = 'การเปลี่ยนแปลงล่าสุด';

    # Template: AgentITSMConfigItemAdd
    $Self->{Translation}->{'Config Item'} = 'Config Item';
    $Self->{Translation}->{'Filter for Classes'} = 'ตัวกรองสำหรับคลาส';
    $Self->{Translation}->{'Select a Class from the list to create a new Config Item.'} = 'เลือกคลาสจากรายการที่จะสร้าง Config Item ใหม่';

    # Template: AgentITSMConfigItemBulk
    $Self->{Translation}->{'ITSM ConfigItem Bulk Action'} = 'การทำงานเป็นกลุ่มของ ITSM ConfigItem';
    $Self->{Translation}->{'Deployment state'} = 'สถานภาพการใช้งาน';
    $Self->{Translation}->{'Incident state'} = 'สถานภาพของเหตุการณ์';
    $Self->{Translation}->{'Link to another'} = 'เชื่อมโยงไปที่อื่น';
    $Self->{Translation}->{'Invalid Configuration Item number!'} = 'จำนวนรายการการกำหนดค่าไม่ถูกต้อง!';
    $Self->{Translation}->{'The number of another Configuration Item to link with.'} = 'จำนวนของรายการการกำหนดค่าอื่นๆที่ต้องการเชื่อมโยง';

    # Template: AgentITSMConfigItemDelete
    $Self->{Translation}->{'Do you really want to delete this config item?'} = '';

    # Template: AgentITSMConfigItemEdit
    $Self->{Translation}->{'The name of this config item'} = ' ชื่อของรายการการตั้งค่านี้\'';
    $Self->{Translation}->{'Name is already in use by the ConfigItems with the following Number(s): %s'} =
        'ชื่อที่ถูกการใช้งานโดย ConfigItems มีจำนวนดังต่อไปนี้ (s): %s';

    # Template: AgentITSMConfigItemHistory
    $Self->{Translation}->{'History of Config Item: %s'} = '';
    $Self->{Translation}->{'History Content'} = 'เนื้อหาประวัติ';
    $Self->{Translation}->{'Createtime'} = 'เวลาที่สร้าง';
    $Self->{Translation}->{'Zoom view'} = 'มุมมองการซูม';

    # Template: AgentITSMConfigItemOverviewNavBar
    $Self->{Translation}->{'Context Settings'} = 'การตั้งค่าข้อความ';
    $Self->{Translation}->{'Config Items per page'} = 'Config Items ในแต่ละหน้า';

    # Template: AgentITSMConfigItemOverviewSmall
    $Self->{Translation}->{'A generic ITSM Configuration Item table'} = '';

    # Template: AgentITSMConfigItemSearch
    $Self->{Translation}->{'Run Search'} = 'ดำเนินการค้นหา';
    $Self->{Translation}->{'Also search in previous versions?'} = 'ค้นหาเวอร์ชั่นที่แล้วด้วยหรือไม่?';

    # Template: AgentITSMConfigItemZoom
    $Self->{Translation}->{'Configuration Item'} = 'รายการการกำหนดค่า';
    $Self->{Translation}->{'Configuration Item Information'} = 'ข้อมูลรายการการกำหนดค่า';
    $Self->{Translation}->{'Current Deployment State'} = 'สถานภาพการใช้งานปัจจุบัน';
    $Self->{Translation}->{'Last changed by'} = 'การเปลี่ยนแปลงล่าสุดโดย';
    $Self->{Translation}->{'Show one version'} = 'แสดงหนึ่งเวอร์ชั่น';
    $Self->{Translation}->{'Show all versions'} = 'แสดงเวอร์ชั่นทั้งหมด';
    $Self->{Translation}->{'Version Incident State'} = 'เวอร์ชั่นของสถานภาพของเหตุการณ์';
    $Self->{Translation}->{'Version Deployment State'} = 'เว่อร์ชั่นสถานภาพการใช้งาน';
    $Self->{Translation}->{'Version Number'} = 'หมายเลขเวอร์ชั้น';
    $Self->{Translation}->{'Configuration Item Version Details'} = 'เนื้อหาเวอร์ชั่น Configuration Item';
    $Self->{Translation}->{'Property'} = 'คุณสมบัติ';

    # Perl Module: Kernel/Modules/AgentITSMConfigItem.pm
    $Self->{Translation}->{'No access to Class is given!'} = '';
    $Self->{Translation}->{'Overview: ITSM ConfigItem'} = '';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemBulk.pm
    $Self->{Translation}->{'No ConfigItemID is given!'} = '';
    $Self->{Translation}->{'You need at least one selected Configuration Item!'} = '';
    $Self->{Translation}->{'You don\'t have write access to this configuration item: %s.'} =
        '';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemDelete.pm
    $Self->{Translation}->{'Config item "%s" not found in database!'} = '';
    $Self->{Translation}->{'Was not able to delete the configitem ID %s!'} = '';
    $Self->{Translation}->{'No version found for ConfigItemID %s!'} = '';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemEdit.pm
    $Self->{Translation}->{'No ConfigItemID, DuplicateID or ClassID is given!'} = '';
    $Self->{Translation}->{'No access is given!'} = '';
    $Self->{Translation}->{'No definition was defined for class %s!'} = '';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemHistory.pm
    $Self->{Translation}->{'Can\'t show history, no ConfigItemID is given!'} = '';
    $Self->{Translation}->{'Can\'t show history, no access rights given!'} = '';
    $Self->{Translation}->{'New ConfigItem (ID=%s)'} = '';
    $Self->{Translation}->{'New version (ID=%s)'} = '';
    $Self->{Translation}->{'Deployment state updated (new=%s, old=%s)'} = '';
    $Self->{Translation}->{'Incident state updated (new=%s, old=%s)'} = '';
    $Self->{Translation}->{'ConfigItem (ID=%s) deleted'} = '';
    $Self->{Translation}->{'Link to %s (type=%s) added'} = '';
    $Self->{Translation}->{'Link to %s (type=%s) deleted'} = '';
    $Self->{Translation}->{'ConfigItem definition updated (ID=%s)'} = '';
    $Self->{Translation}->{'Name updated (new=%s, old=%s)'} = '';
    $Self->{Translation}->{'Attribute %s updated from "%s" to "%s"'} = '';
    $Self->{Translation}->{'Version %s deleted'} = '';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemPrint.pm
    $Self->{Translation}->{'No ConfigItemID or VersionID is given!'} = '';
    $Self->{Translation}->{'Can\'t show config item, no access rights given!'} = '';
    $Self->{Translation}->{'ConfigItemID %s not found in database!'} = '';
    $Self->{Translation}->{'VersionID %s not found in database!'} = '';
    $Self->{Translation}->{'ConfigItem'} = 'ConfigItem';
    $Self->{Translation}->{'printed by %s at %s'} = '';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemSearch.pm
    $Self->{Translation}->{'Invalid ClassID!'} = '';
    $Self->{Translation}->{'No ClassID is given!'} = '';
    $Self->{Translation}->{'No access rights for this class given!'} = '';
    $Self->{Translation}->{'No Result!'} = 'ไม่มีผลลัพธ์!';
    $Self->{Translation}->{'Config Item Search Results'} = '';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemZoom.pm
    $Self->{Translation}->{'Can\'t show item, no access rights for ConfigItem are given!'} =
        '';
    $Self->{Translation}->{'operational'} = '';
    $Self->{Translation}->{'warning'} = '';
    $Self->{Translation}->{'incident'} = '';
    $Self->{Translation}->{'The deployment state of this config item'} = 'สถานภาพการพัฒนาการของ config item นี้ ';
    $Self->{Translation}->{'The incident state of this config item'} = 'สถานภาพเหตุการณ์ของ config item นี';

    # Perl Module: Kernel/Output/HTML/Dashboard/ITSMConfigItemGeneric.pm
    $Self->{Translation}->{'Shown config items'} = '';

    # Perl Module: Kernel/Output/HTML/ITSMConfigItem/LayoutDate.pm
    $Self->{Translation}->{'Between'} = 'ระหว่าง';

    # Perl Module: Kernel/System/ImportExport/ObjectBackend/ITSMConfigItem.pm
    $Self->{Translation}->{'Maximum number of one element'} = 'จำนวนสูงสุดของหนึ่งอุปกรณ์';
    $Self->{Translation}->{'Empty fields indicate that the current values are kept'} = 'เขตข้อมูลว่างเปล่าบ่งชี้ว่าค่าปัจจุบันจะถูกเก็บไว้';
    $Self->{Translation}->{'Skipped'} = 'ข้ามแล้ว';

    # Perl Module: var/packagesetup/ITSMConfigurationManagement.pm
    $Self->{Translation}->{'Model'} = 'โมเดล';
    $Self->{Translation}->{'Customer Company'} = '';
    $Self->{Translation}->{'Serial Number'} = 'หมายเลขซีเรียล';
    $Self->{Translation}->{'CPU'} = 'ซีพียู';
    $Self->{Translation}->{'Ram'} = 'แรม';
    $Self->{Translation}->{'Hard Disk'} = 'ฮาร์ดดิสก์';
    $Self->{Translation}->{'Capacity'} = 'ความจุ';
    $Self->{Translation}->{'Network Adapter'} = 'การ์ดเชื่อมต่อเครือข่าย';
    $Self->{Translation}->{'IP over DHCP'} = 'IP ผ่าน DHCP';
    $Self->{Translation}->{'IP Address'} = 'ที่อยู่ไอพี';
    $Self->{Translation}->{'Graphic Adapter'} = 'ตัวปรับต่อกราฟฟิค';
    $Self->{Translation}->{'Other Equipment'} = 'อุปกรณ์อื่น ๆ';
    $Self->{Translation}->{'Warranty Expiration Date'} = 'การรับประกันวันหมดอายุ';
    $Self->{Translation}->{'Install Date'} = 'วันติดตั้ง';
    $Self->{Translation}->{'Phone 1'} = 'โทรศัพท์ 1';
    $Self->{Translation}->{'Phone 2'} = 'โทรศัพท์ 2';
    $Self->{Translation}->{'E-Mail'} = '';
    $Self->{Translation}->{'Network Address'} = 'ที่อยู่เครือข่าย';
    $Self->{Translation}->{'Subnet Mask'} = 'เครือข่ายย่อยมาส์ก';
    $Self->{Translation}->{'Gateway'} = 'ประตูสัญญาณ';
    $Self->{Translation}->{'Licence Type'} = 'ประเภทลายเซนต์';
    $Self->{Translation}->{'Licence Key'} = 'กุญแจลายเซนต์';
    $Self->{Translation}->{'Quantity'} = 'จำนวน';
    $Self->{Translation}->{'Expiration Date'} = 'วันหมดอายุ';
    $Self->{Translation}->{'Media'} = 'มีเดีย';

    # Database XML Definition: ITSMConfigurationManagement.sopm
    $Self->{Translation}->{'Computer'} = '';
    $Self->{Translation}->{'Hardware'} = '';
    $Self->{Translation}->{'Network'} = '';
    $Self->{Translation}->{'Software'} = '';
    $Self->{Translation}->{'Expired'} = 'หมดอายุ';
    $Self->{Translation}->{'Maintenance'} = 'การดูแลรักษา';
    $Self->{Translation}->{'Pilot'} = 'การนำร่อง';
    $Self->{Translation}->{'Planned'} = 'การวางแผน';
    $Self->{Translation}->{'Repair'} = 'ซ่อม';
    $Self->{Translation}->{'Retired'} = 'เกษียณ';
    $Self->{Translation}->{'Review'} = 'ตัวอย่าง';
    $Self->{Translation}->{'Test/QA'} = 'ทดสอบ/QA';
    $Self->{Translation}->{'Laptop'} = 'แล็ปท็อป';
    $Self->{Translation}->{'Desktop'} = 'เดสทอป';
    $Self->{Translation}->{'PDA'} = 'PDA';
    $Self->{Translation}->{'Server'} = 'เซิร์ฟเวอร์';
    $Self->{Translation}->{'Other'} = 'อื่นๆ';
    $Self->{Translation}->{'Monitor'} = 'จอภาพ';
    $Self->{Translation}->{'Printer'} = 'เครื่องพิมพ์';
    $Self->{Translation}->{'Switch'} = 'สับเปลี่ยน';
    $Self->{Translation}->{'Router'} = 'เราเตอร์';
    $Self->{Translation}->{'WLAN Access Point'} = 'จุดเชื่อมต่อWLAN';
    $Self->{Translation}->{'Security Device'} = 'อุปกรณ์รักษาความปลอดภัย';
    $Self->{Translation}->{'Backup Device'} = 'อุปกรณ์สำรองข้อมูล';
    $Self->{Translation}->{'Mouse'} = 'เม้าส์';
    $Self->{Translation}->{'Keyboard'} = 'แป้นพิมพ์';
    $Self->{Translation}->{'Camera'} = 'กล้อง';
    $Self->{Translation}->{'Beamer'} = 'ผู้คาน';
    $Self->{Translation}->{'Modem'} = 'โมเดม';
    $Self->{Translation}->{'PCMCIA Card'} = 'บัตร PCMCIA';
    $Self->{Translation}->{'USB Device'} = 'อุปกรณ์ USB';
    $Self->{Translation}->{'Docking Station'} = 'สถานี Docking';
    $Self->{Translation}->{'Scanner'} = 'เครื่องสแกน';
    $Self->{Translation}->{'Building'} = 'การสร้าง';
    $Self->{Translation}->{'Office'} = 'ออฟฟิศ';
    $Self->{Translation}->{'Floor'} = 'ชั้น';
    $Self->{Translation}->{'Room'} = 'ห้อง';
    $Self->{Translation}->{'Rack'} = 'จำพวก';
    $Self->{Translation}->{'Workplace'} = 'ที่ทำงาน';
    $Self->{Translation}->{'Outlet'} = 'เอาท์เล็ท';
    $Self->{Translation}->{'IT Facility'} = 'สิ่งอำนวยความสะดวกด้านไอที';
    $Self->{Translation}->{'LAN'} = 'LAN';
    $Self->{Translation}->{'WLAN'} = 'WLAN';
    $Self->{Translation}->{'Telco'} = 'Telco';
    $Self->{Translation}->{'GSM'} = 'GSM';
    $Self->{Translation}->{'Client Application'} = 'แอพลิเคชันของลูกค้า';
    $Self->{Translation}->{'Middleware'} = 'มิดเดิ้ลแวย์';
    $Self->{Translation}->{'Server Application'} = 'แอพลิเคชันเซิร์ฟเวอร์';
    $Self->{Translation}->{'Client OS'} = 'OS ของลูกค้า';
    $Self->{Translation}->{'Server OS'} = 'OS เซิร์ฟเวอร์';
    $Self->{Translation}->{'Admin Tool'} = 'เครื่องมือแอดมิน';
    $Self->{Translation}->{'User Tool'} = 'เครื่องมือของผู้ใช้';
    $Self->{Translation}->{'Embedded'} = 'การฝังตัว';
    $Self->{Translation}->{'Single Licence'} = 'ลายเซนต์เดียว';
    $Self->{Translation}->{'Per User'} = 'ต่อผู้ใช้';
    $Self->{Translation}->{'Per Processor'} = 'สำหรับตัวประมวลผล';
    $Self->{Translation}->{'Per Server'} = 'ต่อเซิร์ฟเวอร์';
    $Self->{Translation}->{'Per Node'} = 'ต่อหนึ่งโหนด';
    $Self->{Translation}->{'Volume Licence'} = 'ลายเซนต์อุปกรณ์เสียง';
    $Self->{Translation}->{'Enterprise Licence'} = 'ลายเวนต์เอ็นเตอร์ไพรส์';
    $Self->{Translation}->{'Developer Licence'} = 'ลายเซนต์ผู้พัฒนา';
    $Self->{Translation}->{'Demo'} = 'การสาธิต';
    $Self->{Translation}->{'Time Restricted'} = 'เวลา จำกัด';
    $Self->{Translation}->{'Freeware'} = 'ฟรีแวร์';
    $Self->{Translation}->{'Open Source'} = 'โอเพนซอร์ส';
    $Self->{Translation}->{'Unlimited'} = 'ไม่จำกัด';

    # JS File: ITSM.Agent.ConfigItem.Zoom
    $Self->{Translation}->{'Ok'} = 'โอเค';

    # SysConfig
    $Self->{Translation}->{'A precentage value of the minimal translation progress per language, to be usable for documentations.'} =
        '';
    $Self->{Translation}->{'Access repos via http or https.'} = '';
    $Self->{Translation}->{'Autoloading of Znuny4OTRSRepo extensions.'} = '';
    $Self->{Translation}->{'Backend module registration for the config conflict check module.'} =
        '';
    $Self->{Translation}->{'Backend module registration for the file conflict check module.'} =
        '';
    $Self->{Translation}->{'Backend module registration for the function redefine check module.'} =
        '';
    $Self->{Translation}->{'Backend module registration for the manual set module.'} = '';
    $Self->{Translation}->{'Block hooks to be created for BS ad removal.'} = '';
    $Self->{Translation}->{'Block hooks to be created for package manager output filter.'} =
        '';
    $Self->{Translation}->{'Branch View commit limit'} = '';
    $Self->{Translation}->{'CodePolicy'} = '';
    $Self->{Translation}->{'Commit limit per page for Branch view screen'} = '';
    $Self->{Translation}->{'Create analysis file'} = '';
    $Self->{Translation}->{'Creates a analysis file from this ticket and sends to Znuny.'} =
        '';
    $Self->{Translation}->{'Creates a analysis file from this ticket.'} = '';
    $Self->{Translation}->{'Define private addon repos.'} = '';
    $Self->{Translation}->{'Defines the filter that processes the HTML templates.'} = '';
    $Self->{Translation}->{'Defines the test module for checking code policy.'} = '';
    $Self->{Translation}->{'Definition of GIT clone/push URL Prefix.'} = '';
    $Self->{Translation}->{'Definition of a Dynamic Field: Group => Group with access to the Dynamic Fields; AlwaysVisible => Field can be removed (0|1); InformationAreaName => Name of the Widgets; InformationAreaSize => Size and position of the widgets (Large|Small); Name => Name of the Dynamic Field which should be used; Priority => Order of the Dynamic Fields; State => State of the Fields (0 = disabled, 1 = active, 2 = mandatory), FilterRelease => Regex which the repository name has to match to be displayed, FilterPackage => Regex which the package name has to match to be displayed, FilterBranch => Regex which the branch name has to match to be displayed, FilterRelease => Regex which the repelase version string has to match to be displayed.'} =
        '';
    $Self->{Translation}->{'Definition of a Dynamic Field: Group => Group with access to the Dynamic Fields; AlwaysVisible => Field can be removed (0|1); InformationAreaName => Name of the Widgets; InformationAreaSize => Size and position of the widgets (Large|Small); Name => Name of the Dynamic Field which should be used; Priority => Order of the Dynamic Fields; State => State of the Fields (0 = disabled, 1 = active, 2 = mandatory), FilterRepository => Regex which the repository name has to match to be displayed, FilterPackage => Regex which the package name has to match to be displayed, FilterBranch => Regex which the branch name has to match to be displayed, FilterRelease => Regex which the repelase version string has to match to be displayed.'} =
        '';
    $Self->{Translation}->{'Definition of external MD5 sums (key => MD5, Value => Vendor, PackageName, Version, Date).'} =
        '';
    $Self->{Translation}->{'Definition of mappings between public repository requests and internal OPMS repositories.'} =
        '';
    $Self->{Translation}->{'Definition of package states.'} = '';
    $Self->{Translation}->{'Definition of renamed OPMS packages.'} = '';
    $Self->{Translation}->{'Directory, which is used by Git to cache repositories.'} = '';
    $Self->{Translation}->{'Directory, which is used by Git to store temporary data.'} = '';
    $Self->{Translation}->{'Directory, which is used by Git to store working copies.'} = '';
    $Self->{Translation}->{'Disable online repositories.'} = '';
    $Self->{Translation}->{'Do not log git ssh connection authorization results for these users. Useful for automated stuff.'} =
        '';
    $Self->{Translation}->{'Dynamic Fields Screens'} = '';
    $Self->{Translation}->{'DynamicFieldScreen'} = '';
    $Self->{Translation}->{'Export all available public keys to authorized_keys file.'} = '';
    $Self->{Translation}->{'Export all relevant releases to ftp server.'} = '';
    $Self->{Translation}->{'Frontend module registration for the OPMS object in the agent interface.'} =
        '';
    $Self->{Translation}->{'Frontend module registration for the PublicOPMSRepository object in the public interface.'} =
        '';
    $Self->{Translation}->{'Frontend module registration for the PublicOPMSRepositoryLookup object in the public interface.'} =
        '';
    $Self->{Translation}->{'Frontend module registration for the PublicOPMSTestBuild object in the public interface.'} =
        '';
    $Self->{Translation}->{'Frontend module registration for the PublicPackageVerification object in the public interface.'} =
        '';
    $Self->{Translation}->{'Frontend module registration for the admin interface.'} = '';
    $Self->{Translation}->{'GIT Author registration.'} = '';
    $Self->{Translation}->{'Generate HTML comment hooks for the specified blocks so that filters can use them.'} =
        '';
    $Self->{Translation}->{'Generate documentations once per night.'} = '';
    $Self->{Translation}->{'Git'} = '';
    $Self->{Translation}->{'Git Management'} = '';
    $Self->{Translation}->{'Git Repository'} = '';
    $Self->{Translation}->{'Group, whose members have delete admin permissions in OPMS.'} = '';
    $Self->{Translation}->{'Group, whose members have repository admin permissions in OPMS.'} =
        '';
    $Self->{Translation}->{'Group, whose members will see CI test result information in OPMS screens.'} =
        '';
    $Self->{Translation}->{'Groups an authenticated user (by user login and password) must be member of to build test packages via the public interface.'} =
        '';
    $Self->{Translation}->{'Groups which will be set during git project creation processes while adding OPMS repositories.'} =
        '';
    $Self->{Translation}->{'Manage dynamic field in screens.'} = '';
    $Self->{Translation}->{'Manage your public SSH key(s) for Git access here. Make sure to save this preference when you add a new key.'} =
        '';
    $Self->{Translation}->{'Module to generate statistics about the added code lines.'} = '';
    $Self->{Translation}->{'Module to generate statistics about the growth of code.'} = '';
    $Self->{Translation}->{'Module to generate statistics about the number of git commits.'} =
        '';
    $Self->{Translation}->{'Module to generate statistics about the removed code lines.'} = '';
    $Self->{Translation}->{'OPMS'} = '';
    $Self->{Translation}->{'Only users who have rw permissions in one of these groups may access git.'} =
        '';
    $Self->{Translation}->{'Option to set a package compatibility manually.'} = '';
    $Self->{Translation}->{'Parameters for the pages in the BranchView screen.'} = '';
    $Self->{Translation}->{'Pre-Definition of the \'GITProjectName\' Dynamic Field: Group => Group with access to the Dynamic Fields; AlwaysVisible => Field can be removed (0|1); InformationAreaName => Name of the Widgets; InformationAreaSize => Size and position of the widgets (Large|Small); Name => Name of the Dynamic Field which should be used; Priority => Order of the Dynamic Fields; State => State of the Fields (0 = disabled, 1 = active, 2 = mandatory), FilterRepository => Regex which the repository name has to match to be displayed, FilterPackage => Regex which the package name has to match to be displayed, FilterBranch => Regex which the branch name has to match to be displayed, FilterRelease => Regex which the repelase version string has to match to be displayed.'} =
        '';
    $Self->{Translation}->{'Pre-Definition of the \'GITRepositoryName\' Dynamic Field: Group => Group with access to the Dynamic Fields; AlwaysVisible => Field can be removed (0|1); InformationAreaName => Name of the Widgets; InformationAreaSize => Size and position of the widgets (Large|Small); Name => Name of the Dynamic Field which should be used; Priority => Order of the Dynamic Fields; State => State of the Fields (0 = disabled, 1 = active, 2 = mandatory), FilterRepository => Regex which the repository name has to match to be displayed, FilterPackage => Regex which the package name has to match to be displayed, FilterBranch => Regex which the branch name has to match to be displayed, FilterRelease => Regex which the repelase version string has to match to be displayed.'} =
        '';
    $Self->{Translation}->{'Pre-Definition of the \'PackageDeprecated\' Dynamic Field: Group => Group with access to the Dynamic Fields; AlwaysVisible => Field can be removed (0|1); InformationAreaName => Name of the Widgets; InformationAreaSize => Size and position of the widgets (Large|Small); Name => Name of the Dynamic Field which should be used; Priority => Order of the Dynamic Fields; State => State of the Fields (0 = disabled, 1 = active, 2 = mandatory), FilterRepository => Regex which the repository name has to match to be displayed, FilterPackage => Regex which the package name has to match to be displayed, FilterBranch => Regex which the branch name has to match to be displayed, FilterRelease => Regex which the repelase version string has to match to be displayed.'} =
        '';
    $Self->{Translation}->{'Recipients that will be informed by email in case of errors.'} =
        '';
    $Self->{Translation}->{'SSH Keys for Git Access'} = '';
    $Self->{Translation}->{'Send analysis file'} = '';
    $Self->{Translation}->{'Sets the git clone address to be used in repository listings.'} =
        '';
    $Self->{Translation}->{'Sets the home directory for git repositories.'} = '';
    $Self->{Translation}->{'Sets the path for the BugzillaAddComment post receive script location.'} =
        '';
    $Self->{Translation}->{'Sets the path for the OTRSCodePolicy  script location. It is recommended to have a separate clone of the OTRSCodePolicy module that is updated via cron.'} =
        '';
    $Self->{Translation}->{'Sets the path for the OTRSCodePolicy pre receive script location. It is recommended to have a separate clone of the OTRSCodePolicy module that is updated via cron.'} =
        '';
    $Self->{Translation}->{'Show latest commits in git repositories.'} = '';
    $Self->{Translation}->{'Shows a link in the menu to go create a unit test from the current ticket.'} =
        '';
    $Self->{Translation}->{'Synchronize OPMS tables with a remote database.'} = '';
    $Self->{Translation}->{'The minimum version of the sphinx library.'} = '';
    $Self->{Translation}->{'The name of the sphinx theme to be used.'} = '';
    $Self->{Translation}->{'The path to the OTRS CSS file (relative below the static path).'} =
        '';
    $Self->{Translation}->{'The path to the OTRS logo (relative below the static path).'} = '';
    $Self->{Translation}->{'The path to the static folder, containing images and css files.'} =
        '';
    $Self->{Translation}->{'The path to the theme folder, containing the sphinx themes.'} = '';
    $Self->{Translation}->{'This configuration defines all possible screens to enable or disable default columns.'} =
        '';
    $Self->{Translation}->{'This configuration defines all possible screens to enable or disable dynamic fields.'} =
        '';
    $Self->{Translation}->{'This configuration defines if only valids or all (invalids) dynamic fields should be shown.'} =
        '';
    $Self->{Translation}->{'This configuration defines if the OTRS package verification should be active or disabled. If disabled all packages are shown as verified. It\'s still recommended to use only verified packages.'} =
        '';
    $Self->{Translation}->{'This configuration defines the URL to the OTRS CloudService Proxy service. The http or https prefix will be added, depending on selection SysConfig \'Znuny4OTRSRepoType\'.'} =
        '';
    $Self->{Translation}->{'This configuration registers a Output post-filter to extend package verification.'} =
        '';
    $Self->{Translation}->{'This configuration registers an OutputFilter module that removes OTRS Business Solution TM advertisements.'} =
        '';
    $Self->{Translation}->{'This configuration registers an output filter to hide online repository selection in package manager.'} =
        '';
    $Self->{Translation}->{'Tidy unprocessed release that not passed test pomules checks for a long time.'} =
        '';
    $Self->{Translation}->{'Users who have rw permissions in one of these groups are permitted to execute force pushes \'git push --force\'.'} =
        '';
    $Self->{Translation}->{'Users who have rw permissions in one of these groups are permitted to manage projects. Additionally the members have administration permissions to the git management.'} =
        '';


    push @{ $Self->{JavaScriptStrings} // [] }, (
    'No',
    'Ok',
    'Please enter at least one search value or * to find anything.',
    'Settings',
    'Submit',
    'Yes',
    );

}

1;

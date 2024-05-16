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

package Kernel::Language::zh_CN_ITSMConfigurationManagement;

use strict;
use warnings;
use utf8;

sub Data {
    my $Self = shift;

    # Template: AdminITSMConfigItem
    $Self->{Translation}->{'Config Item Management'} = '管理配置项';
    $Self->{Translation}->{'Change class definition'} = '修改类定义';
    $Self->{Translation}->{'Config Item Class'} = '配置项类';
    $Self->{Translation}->{'Definition'} = '定义';
    $Self->{Translation}->{'Change'} = '变更';

    # Template: AgentDashboardITSMConfigItemGeneric
    $Self->{Translation}->{'Incident State'} = '故障状态';
    $Self->{Translation}->{'Deployment State'} = '部署状态';
    $Self->{Translation}->{'Class'} = '类';
    $Self->{Translation}->{'Deployment State Type'} = '部署状态类型';
    $Self->{Translation}->{'Current Incident State'} = '当前的故障状态';
    $Self->{Translation}->{'Current Incident State Type'} = '当前的故障状态类型';
    $Self->{Translation}->{'Last changed'} = '最后修改';

    # Template: AgentITSMConfigItemAdd
    $Self->{Translation}->{'Config Item'} = '配置项';
    $Self->{Translation}->{'Filter for Classes'} = '类过滤器';
    $Self->{Translation}->{'Select a Class from the list to create a new Config Item.'} = '先从列表中选择类，然后创建新的配置项。';

    # Template: AgentITSMConfigItemBulk
    $Self->{Translation}->{'ITSM ConfigItem Bulk Action'} = 'ITSM 配置项 批量操作';
    $Self->{Translation}->{'Deployment state'} = '部署状态';
    $Self->{Translation}->{'Incident state'} = '事件状态';
    $Self->{Translation}->{'Link to another'} = '链接到其他';
    $Self->{Translation}->{'Invalid Configuration Item number!'} = '无效的配置项编号！';
    $Self->{Translation}->{'The number of another Configuration Item to link with.'} = '将要链接的另外一个配置项编号。';

    # Template: AgentITSMConfigItemDelete
    $Self->{Translation}->{'Do you really want to delete this config item?'} = '你真的想要删除这个配置项吗?';

    # Template: AgentITSMConfigItemEdit
    $Self->{Translation}->{'The name of this config item'} = '为这个配置项命名';
    $Self->{Translation}->{'Name is already in use by the ConfigItems with the following Number(s): %s'} =
        '编号为(s):%s的配置项已经使用了此名字';

    # Template: AgentITSMConfigItemHistory
    $Self->{Translation}->{'History of Config Item: %s'} = '配置项：%s 的历史信息';
    $Self->{Translation}->{'History Content'} = '历史值';
    $Self->{Translation}->{'Createtime'} = '创建时间';
    $Self->{Translation}->{'Zoom view'} = '详情视图';

    # Template: AgentITSMConfigItemOverviewNavBar
    $Self->{Translation}->{'Context Settings'} = '上下文设置';
    $Self->{Translation}->{'Config Items per page'} = '每页配置项个数';

    # Template: AgentITSMConfigItemOverviewSmall
    $Self->{Translation}->{'A generic ITSM Configuration Item table'} = '一个通用的ITSM配置项表格';

    # Template: AgentITSMConfigItemSearch
    $Self->{Translation}->{'Run Search'} = '搜索';
    $Self->{Translation}->{'Also search in previous versions?'} = '同时搜索以前的版本吗?';

    # Template: AgentITSMConfigItemZoom
    $Self->{Translation}->{'Configuration Item'} = '配置项';
    $Self->{Translation}->{'Configuration Item Information'} = '配置项信息';
    $Self->{Translation}->{'Current Deployment State'} = '当前的部署状态';
    $Self->{Translation}->{'Last changed by'} = '最后修改人';
    $Self->{Translation}->{'Show one version'} = '显示一个版本';
    $Self->{Translation}->{'Show all versions'} = '显示所有版本';
    $Self->{Translation}->{'Version Incident State'} = '版本故障状态';
    $Self->{Translation}->{'Version Deployment State'} = '版本部署状态';
    $Self->{Translation}->{'Version Number'} = '版本号';
    $Self->{Translation}->{'Configuration Item Version Details'} = '配置项版本详情';
    $Self->{Translation}->{'Property'} = '属性';

    # Perl Module: Kernel/Modules/AgentITSMConfigItem.pm
    $Self->{Translation}->{'No access to Class is given!'} = '没有类的访问权限！';
    $Self->{Translation}->{'Overview: ITSM ConfigItem'} = 'ITSM配置项概览';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemBulk.pm
    $Self->{Translation}->{'No ConfigItemID is given!'} = '没有指定配置项ID！';
    $Self->{Translation}->{'You need at least one selected Configuration Item!'} = '您至少需要一个选定的配置项！';
    $Self->{Translation}->{'You don\'t have write access to this configuration item: %s.'} =
        '你没有此配置项的写权限：%s。';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemDelete.pm
    $Self->{Translation}->{'Config item "%s" not found in database!'} = '在数据库中找不到配置项“%s”！';
    $Self->{Translation}->{'Was not able to delete the configitem ID %s!'} = '无法删除配置项ID %s！';
    $Self->{Translation}->{'No version found for ConfigItemID %s!'} = '找不到配置项ID%s的版本！';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemEdit.pm
    $Self->{Translation}->{'No ConfigItemID, DuplicateID or ClassID is given!'} = '没有指定配置项ID、DuplicateID或ClassID！';
    $Self->{Translation}->{'No access is given!'} = '没有访问权限！';
    $Self->{Translation}->{'No definition was defined for class %s!'} = '没有类 %s的定义！';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemHistory.pm
    $Self->{Translation}->{'Can\'t show history, no ConfigItemID is given!'} = '不能显示历史信息，因为没有指定配置项ID！';
    $Self->{Translation}->{'Can\'t show history, no access rights given!'} = '无法显示历史记录，因为没有访问权限！';
    $Self->{Translation}->{'New ConfigItem (ID=%s)'} = '新建配置项（ID=%s）';
    $Self->{Translation}->{'New version (ID=%s)'} = '新建版本（ID=%s）';
    $Self->{Translation}->{'Deployment state updated (new=%s, old=%s)'} = '部署状态已更新（新=%s，旧=%s）';
    $Self->{Translation}->{'Incident state updated (new=%s, old=%s)'} = '故障状态已更新（新=%s，旧=%s）';
    $Self->{Translation}->{'ConfigItem (ID=%s) deleted'} = '配置项（ID=%s）已删除';
    $Self->{Translation}->{'Link to %s (type=%s) added'} = '到%s链接的（类型=%s）已添加';
    $Self->{Translation}->{'Link to %s (type=%s) deleted'} = '到%s链接的（类型=%s）已删除';
    $Self->{Translation}->{'ConfigItem definition updated (ID=%s)'} = '配置项定义已更新（ID=%s）';
    $Self->{Translation}->{'Name updated (new=%s, old=%s)'} = '名称已更新（新=%s，旧=%s）';
    $Self->{Translation}->{'Attribute %s updated from "%s" to "%s"'} = '属性%s已从“%s”更新为“%s”';
    $Self->{Translation}->{'Version %s deleted'} = '版本%s 已删除';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemPrint.pm
    $Self->{Translation}->{'No ConfigItemID or VersionID is given!'} = '没有指定配置项ID或版本ID！';
    $Self->{Translation}->{'Can\'t show config item, no access rights given!'} = '无法显示配置项，因为没有访问权限！';
    $Self->{Translation}->{'ConfigItemID %s not found in database!'} = '在数据库中找不到配置项ID %s！';
    $Self->{Translation}->{'VersionID %s not found in database!'} = '在数据库中找不到版本ID %s！';
    $Self->{Translation}->{'ConfigItem'} = '配置项';
    $Self->{Translation}->{'printed by %s at %s'} = '打印人：%s ，打印日期：%s';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemSearch.pm
    $Self->{Translation}->{'Invalid ClassID!'} = '无效的类ID！';
    $Self->{Translation}->{'No ClassID is given!'} = '没有指定类ID！';
    $Self->{Translation}->{'No access rights for this class given!'} = '没有这个指定类的访问权限！';
    $Self->{Translation}->{'No Result!'} = '无结果！';
    $Self->{Translation}->{'Config Item Search Results'} = '配置项搜索结果';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemZoom.pm
    $Self->{Translation}->{'Can\'t show item, no access rights for ConfigItem are given!'} =
        '无法显示配置项，因为没有给定配置项的访问权限！';
    $Self->{Translation}->{'operational'} = '正常';
    $Self->{Translation}->{'warning'} = '警告';
    $Self->{Translation}->{'incident'} = '故障';
    $Self->{Translation}->{'The deployment state of this config item'} = '配置项部署状态';
    $Self->{Translation}->{'The incident state of this config item'} = '配置项故障状态';

    # Perl Module: Kernel/Output/HTML/Dashboard/ITSMConfigItemGeneric.pm
    $Self->{Translation}->{'Shown config items'} = '已显示的配置项';

    # Perl Module: Kernel/Output/HTML/ITSMConfigItem/LayoutDate.pm
    $Self->{Translation}->{'Between'} = '时间区间';

    # Perl Module: Kernel/System/ImportExport/ObjectBackend/ITSMConfigItem.pm
    $Self->{Translation}->{'Maximum number of one element'} = '单个元素的最大数量';
    $Self->{Translation}->{'Empty fields indicate that the current values are kept'} = '空字段表示保持当前值';
    $Self->{Translation}->{'Skipped'} = '跳过的';

    # Perl Module: var/packagesetup/ITSMConfigurationManagement.pm
    $Self->{Translation}->{'Model'} = '型号';
    $Self->{Translation}->{'Customer Company'} = '客户单位';
    $Self->{Translation}->{'Serial Number'} = '序列号';
    $Self->{Translation}->{'CPU'} = 'CPU';
    $Self->{Translation}->{'Ram'} = '内存';
    $Self->{Translation}->{'Hard Disk'} = '硬盘';
    $Self->{Translation}->{'Capacity'} = '容量';
    $Self->{Translation}->{'Network Adapter'} = '网卡';
    $Self->{Translation}->{'IP over DHCP'} = '从DHCP获取IP';
    $Self->{Translation}->{'IP Address'} = 'IP地址';
    $Self->{Translation}->{'Graphic Adapter'} = '显卡';
    $Self->{Translation}->{'Other Equipment'} = '其它设备';
    $Self->{Translation}->{'Warranty Expiration Date'} = '保修过期日期';
    $Self->{Translation}->{'Install Date'} = '安装日期';
    $Self->{Translation}->{'Phone 1'} = '电话1';
    $Self->{Translation}->{'Phone 2'} = '电话2';
    $Self->{Translation}->{'E-Mail'} = 'E-Mail';
    $Self->{Translation}->{'Network Address'} = '网络地址';
    $Self->{Translation}->{'Subnet Mask'} = '子网掩码';
    $Self->{Translation}->{'Gateway'} = '网关';
    $Self->{Translation}->{'Licence Type'} = '许可类别';
    $Self->{Translation}->{'Licence Key'} = '许可密钥';
    $Self->{Translation}->{'Quantity'} = '数量';
    $Self->{Translation}->{'Expiration Date'} = '过期日期';
    $Self->{Translation}->{'Media'} = '介质';

    # Database XML Definition: ITSMConfigurationManagement.sopm
    $Self->{Translation}->{'Computer'} = '计算机';
    $Self->{Translation}->{'Hardware'} = '硬件';
    $Self->{Translation}->{'Network'} = '网络';
    $Self->{Translation}->{'Software'} = '软件';
    $Self->{Translation}->{'Expired'} = '已过期';
    $Self->{Translation}->{'Maintenance'} = '维护';
    $Self->{Translation}->{'Pilot'} = '试验';
    $Self->{Translation}->{'Planned'} = '已计划';
    $Self->{Translation}->{'Repair'} = '修复';
    $Self->{Translation}->{'Retired'} = '报废';
    $Self->{Translation}->{'Review'} = '复审';
    $Self->{Translation}->{'Test/QA'} = '测试/品质保证';
    $Self->{Translation}->{'Laptop'} = '笔记本';
    $Self->{Translation}->{'Desktop'} = '台式电脑';
    $Self->{Translation}->{'PDA'} = 'PDA';
    $Self->{Translation}->{'Server'} = '服务器';
    $Self->{Translation}->{'Other'} = '其它';
    $Self->{Translation}->{'Monitor'} = '显示器';
    $Self->{Translation}->{'Printer'} = '打印机';
    $Self->{Translation}->{'Switch'} = '交换机';
    $Self->{Translation}->{'Router'} = '路由器';
    $Self->{Translation}->{'WLAN Access Point'} = 'WLAN 无线访问点';
    $Self->{Translation}->{'Security Device'} = '安全设备';
    $Self->{Translation}->{'Backup Device'} = '备份设备';
    $Self->{Translation}->{'Mouse'} = '鼠标';
    $Self->{Translation}->{'Keyboard'} = '键盘';
    $Self->{Translation}->{'Camera'} = '照相机';
    $Self->{Translation}->{'Beamer'} = '投影仪';
    $Self->{Translation}->{'Modem'} = '调解调器';
    $Self->{Translation}->{'PCMCIA Card'} = 'PCMCIA卡';
    $Self->{Translation}->{'USB Device'} = 'USB 设备';
    $Self->{Translation}->{'Docking Station'} = '坞站';
    $Self->{Translation}->{'Scanner'} = '扫描仪';
    $Self->{Translation}->{'Building'} = '大厦';
    $Self->{Translation}->{'Office'} = '办公室';
    $Self->{Translation}->{'Floor'} = '楼层';
    $Self->{Translation}->{'Room'} = '房间';
    $Self->{Translation}->{'Rack'} = '机架';
    $Self->{Translation}->{'Workplace'} = '工作间';
    $Self->{Translation}->{'Outlet'} = '插座';
    $Self->{Translation}->{'IT Facility'} = 'IT设施';
    $Self->{Translation}->{'LAN'} = '局域网';
    $Self->{Translation}->{'WLAN'} = '无线网络';
    $Self->{Translation}->{'Telco'} = '电话公司';
    $Self->{Translation}->{'GSM'} = 'GSM';
    $Self->{Translation}->{'Client Application'} = '客户端应用程序';
    $Self->{Translation}->{'Middleware'} = '中间件';
    $Self->{Translation}->{'Server Application'} = '服务器应用程序';
    $Self->{Translation}->{'Client OS'} = '客户操作系统';
    $Self->{Translation}->{'Server OS'} = '服务器操作系统';
    $Self->{Translation}->{'Admin Tool'} = '管理工具';
    $Self->{Translation}->{'User Tool'} = '用户工具';
    $Self->{Translation}->{'Embedded'} = '嵌入式';
    $Self->{Translation}->{'Single Licence'} = '单一许可';
    $Self->{Translation}->{'Per User'} = '每个用户';
    $Self->{Translation}->{'Per Processor'} = '每个处理器';
    $Self->{Translation}->{'Per Server'} = '每个服务器';
    $Self->{Translation}->{'Per Node'} = '每个节点';
    $Self->{Translation}->{'Volume Licence'} = '批量授权';
    $Self->{Translation}->{'Enterprise Licence'} = '企业许可';
    $Self->{Translation}->{'Developer Licence'} = '开发许可';
    $Self->{Translation}->{'Demo'} = '演示';
    $Self->{Translation}->{'Time Restricted'} = '时间限制';
    $Self->{Translation}->{'Freeware'} = '免费软件';
    $Self->{Translation}->{'Open Source'} = '开源';
    $Self->{Translation}->{'Unlimited'} = '无限制的';

    # JS File: ITSM.Agent.ConfigItem.Zoom
    $Self->{Translation}->{'Ok'} = '确定';

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

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

package Kernel::Language::zh_TW_ITSMConfigurationManagement;

use strict;
use warnings;
use utf8;

sub Data {
    my $Self = shift;

    # Template: AdminITSMConfigItem
    $Self->{Translation}->{'Config Item Management'} = '管理配置項';
    $Self->{Translation}->{'Change class definition'} = '修改類定義';
    $Self->{Translation}->{'Change role definition'} = '更改角色定义';
    $Self->{Translation}->{'Ready2Import Class Bundles'} = 'Ready2Import 类包';
    $Self->{Translation}->{'Here you can import Ready2Import class bundles showcasing our most usual config items. Please note that some additional configuration may be required.'} =
        '在这里，您可以导入 Ready2Import 类捆绑包，其中展示了我们最常用的配置项。请注意，可能需要一些额外的配置。';
    $Self->{Translation}->{'Update existing entities'} = '更新现有实体';
    $Self->{Translation}->{'Import Ready2Adopt class bundles'} = '导入 Ready2Adopt 类捆绑包';
    $Self->{Translation}->{'Config Item Class'} = '配置项类别';
    $Self->{Translation}->{'Config Item Role'} = '配置项作用';

    # Template: AgentITSMConfigItemAdd
    $Self->{Translation}->{'Config Item'} = '配置項';
    $Self->{Translation}->{'Filter for Classes'} = '過濾類';
    $Self->{Translation}->{'Select a Class from the list to create a new Config Item.'} = '先從列表中選擇類別，然後建立新的配置項。';
    $Self->{Translation}->{'Class'} = '類別';

    # Template: AgentITSMConfigItemBulk
    $Self->{Translation}->{'ITSM ConfigItem Bulk Action'} = 'ITSM 配置项目批量操作';
    $Self->{Translation}->{'Deployment state'} = '部署狀態';
    $Self->{Translation}->{'Incident state'} = '故障狀態';
    $Self->{Translation}->{'Link to another'} = '另一个链接';
    $Self->{Translation}->{'Invalid Configuration Item number!'} = '配置项目编号无效！';
    $Self->{Translation}->{'The number of another Configuration Item to link with.'} = '要链接的另一个配置项的编号。';

    # Template: AgentITSMConfigItemDelete
    $Self->{Translation}->{'Do you really want to delete this config item?'} = '您真的想删除这个配置项吗？';

    # Template: AgentITSMConfigItemEdit
    $Self->{Translation}->{'The name of this config item'} = '為這個配置項命名';
    $Self->{Translation}->{'Name is already in use by the ConfigItems with the following Number(s): %s'} =
        '名称已被配置项使用，编号如下：%s';
    $Self->{Translation}->{'Version Number'} = '版本號碼';
    $Self->{Translation}->{'Version number of this config item'} = '该配置项的版本号';
    $Self->{Translation}->{'Version Number is already in use by the ConfigItems with the following Number(s): %s'} =
        '版本号已被配置项使用，其编号如下：%s';
    $Self->{Translation}->{'Deployment State'} = '部署狀態';
    $Self->{Translation}->{'Incident State'} = '故障狀態';

    # Template: AgentITSMConfigItemHistory
    $Self->{Translation}->{'History of Config Item: %s'} = '配置项历史： %s';
    $Self->{Translation}->{'History Content'} = '歷史内容';
    $Self->{Translation}->{'Createtime'} = '創建時間';
    $Self->{Translation}->{'Zoom view'} = '缩放視圖';

    # Template: AgentITSMConfigItemOverviewNavBar
    $Self->{Translation}->{'Config Items per page'} = '每頁配置項個數';

    # Template: AgentITSMConfigItemOverviewSmall
    $Self->{Translation}->{'No config item data found.'} = '未找到配置项数据。';
    $Self->{Translation}->{'Select this config item'} = '选择该配置项';

    # Template: AgentITSMConfigItemSearch
    $Self->{Translation}->{'Run Search'} = '搜索';
    $Self->{Translation}->{'Also search in previous versions?'} = '同時搜索以前的版本?';

    # Template: AgentITSMConfigItemTreeView
    $Self->{Translation}->{'TreeView for ConfigItem'} = '配置项树形视图';
    $Self->{Translation}->{'Depth Level'} = '深度等级';
    $Self->{Translation}->{'Zoom In/Out'} = '放大/缩小';
    $Self->{Translation}->{'Max links level reached for ConfigItem!'} = 'ConfigItem 已达到最大链接级别！';

    # Template: AgentITSMConfigItemZoom
    $Self->{Translation}->{'Configuration Item'} = '配置項';
    $Self->{Translation}->{'Configuration Item Information'} = '配置項信息';
    $Self->{Translation}->{'Current Deployment State'} = '當前的部署狀態';
    $Self->{Translation}->{'Current Incident State'} = '當前的故障狀態';
    $Self->{Translation}->{'Last changed'} = '最後修改';
    $Self->{Translation}->{'Last changed by'} = '最後修改於';

    # Template: CustomerITSMConfigItem
    $Self->{Translation}->{'Your ConfigItems'} = '您的配置项';

    # Template: CustomerITSMConfigItemSearch
    $Self->{Translation}->{'ConfigItem Search'} = '配置项搜索';

    # Template: AdminACL
    $Self->{Translation}->{'Object Type'} = '对象类型';

    # JS Template: ClassImportConfirm
    $Self->{Translation}->{'The following classes will be imported'} = '将导入以下类别';
    $Self->{Translation}->{'The following roles will be imported'} = '将导入以下角色';
    $Self->{Translation}->{'Note that also corresponding dynamic fields and GeneralCatalog classes will be created and there is no automatic removal.'} =
        '请注意，也会创建相应的动态字段和 GeneralCatalog 类，而且不会自动删除。';
    $Self->{Translation}->{'Do you want to proceed?'} = '你想继续吗？';

    # Perl Module: Kernel/Modules/AdminITSMConfigItem.pm
    $Self->{Translation}->{'Need ExampleClasses!'} = '需要示例类！';
    $Self->{Translation}->{'Definition is no valid YAML hash.'} = '定义没有有效的 YAML 哈希值。';

    # Perl Module: Kernel/Modules/AgentITSMConfigItem.pm
    $Self->{Translation}->{'Overview: ITSM ConfigItem'} = '概述：ITSM 配置项目';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemBulk.pm
    $Self->{Translation}->{'No ConfigItemID is given!'} = '未给出 ConfigItemID！';
    $Self->{Translation}->{'You need at least one selected Configuration Item!'} = '您需要至少一个选定的配置项！';
    $Self->{Translation}->{'You don\'t have write access to this configuration item: %s.'} =
        '您没有写入此配置项的权限：%s.';
    $Self->{Translation}->{'No definition was defined for class %s!'} = '未定义 %s 类的定义！';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemDelete.pm
    $Self->{Translation}->{'Config item "%s" not found in database!'} = '数据库中未发现配置项 "%s"！';
    $Self->{Translation}->{'Was not able to delete the configitem ID %s!'} = '无法删除配置项 ID %s！';
    $Self->{Translation}->{'No version found for ConfigItemID %s!'} = '添加配置项目。';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemEdit.pm
    $Self->{Translation}->{'No ConfigItemID, DuplicateID or ClassID is given!'} = '未给出 ConfigItemID、DuplicateID 或 ClassID！';
    $Self->{Translation}->{'No access is given!'} = '未提供访问权限！';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemHistory.pm
    $Self->{Translation}->{'Can\'t show history, no ConfigItemID is given!'} = '无法显示历史记录，因为没有给出 ConfigItemID！';
    $Self->{Translation}->{'Can\'t show history, no access rights given!'} = '无法显示历史记录，没有访问权限！';
    $Self->{Translation}->{'New ConfigItem (ID=%s)'} = '新配置项（ID=%s）';
    $Self->{Translation}->{'New version (ID=%s)'} = '新版本（ID=%s）';
    $Self->{Translation}->{'Deployment state updated (new=%s, old=%s)'} = '部署状态已更新（新=%s，旧=%s）';
    $Self->{Translation}->{'Incident state updated (new=%s, old=%s)'} = '事件状态已更新（新=%s，旧=%s）';
    $Self->{Translation}->{'ConfigItem (ID=%s) deleted'} = '配置项目（ID=%s）已删除';
    $Self->{Translation}->{'Link to %s (type=%s) added'} = '已添加 %s (type=%s) 链接';
    $Self->{Translation}->{'Link to %s (type=%s) deleted'} = '指向 %s (type=%s) 的链接已删除';
    $Self->{Translation}->{'ConfigItem definition updated (ID=%s)'} = '配置项定义已更新（ID=%s）';
    $Self->{Translation}->{'Name updated (new=%s, old=%s)'} = '名称已更新（新=%s，旧=%s）';
    $Self->{Translation}->{'Attribute %s updated from "%s" to "%s"'} = '属性 %s 从"%s "更新为"%s"';
    $Self->{Translation}->{'Version %s deleted'} = '版本 %s 已删除';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemPrint.pm
    $Self->{Translation}->{'No ConfigItemID or VersionID is given!'} = '未给出 ConfigItemID 或 VersionID！';
    $Self->{Translation}->{'Can\'t show config item, no access rights given!'} = '无法显示配置项，未赋予访问权限！';
    $Self->{Translation}->{'ConfigItemID %s not found in database!'} = '数据库中找不到配置项目编号 %s！';
    $Self->{Translation}->{'ConfigItem'} = '配置項';
    $Self->{Translation}->{'printed by %s at %s'} = '由 %s 在 %s 打印';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemSearch.pm
    $Self->{Translation}->{'Invalid ClassID!'} = '无效 ClassID！';
    $Self->{Translation}->{'No ClassID is given!'} = '未给出 ClassID！';
    $Self->{Translation}->{'No access rights for this class given!'} = '该类没有访问权限！';
    $Self->{Translation}->{'No Result!'} = '沒有結果!';
    $Self->{Translation}->{'Config Item Search Results'} = '配置項目搜尋結果';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemZoom.pm
    $Self->{Translation}->{'Can\'t show item, no access rights for ConfigItem are given!'} =
        '无法显示项目，没有给定 ConfigItem 的访问权限！';
    $Self->{Translation}->{'ConfigItem not found!'} = '未找到配置项！';
    $Self->{Translation}->{'No versions found!'} = '未找到任何版本！';
    $Self->{Translation}->{'operational'} = '业务';
    $Self->{Translation}->{'warning'} = '警告';
    $Self->{Translation}->{'incident'} = '事件';
    $Self->{Translation}->{'The deployment state of this config item'} = '配置項部署狀態';
    $Self->{Translation}->{'The incident state of this config item'} = '配置項故障狀態';

    # Perl Module: Kernel/Modules/CustomerITSMConfigItemSearch.pm
    $Self->{Translation}->{'No permission'} = '沒有權限';
    $Self->{Translation}->{'Filter invalid!'} = '过滤器无效！';
    $Self->{Translation}->{'Search params invalid!'} = '搜索参数无效！';

    # Perl Module: Kernel/Output/HTML/Dashboard/ITSMConfigItemGeneric.pm
    $Self->{Translation}->{'Shown config items'} = '显示的配置项';
    $Self->{Translation}->{'Deployment State Type'} = '部署狀態類型';
    $Self->{Translation}->{'Current Incident State Type'} = '當前的故障狀態類型';

    # Perl Module: Kernel/Output/HTML/ITSMConfigItem/LayoutDate.pm
    $Self->{Translation}->{'Between'} = '之间';

    # Perl Module: Kernel/System/DynamicField/Driver/ConfigItem.pm
    $Self->{Translation}->{'Class restrictions for the config item'} = '配置项的类别限制';
    $Self->{Translation}->{'Select one or more classes to restrict selectable config items'} =
        '选择一个或多个类别来限制可选择的配置项';
    $Self->{Translation}->{'Link type'} = '链接类型';
    $Self->{Translation}->{'Select the link type.'} = '选择链接类型。';
    $Self->{Translation}->{'Forwards: Referencing (Source) -> Referenced (Target)'} = '转发：引用（源） -> 引用（目标）';
    $Self->{Translation}->{'Backwards: Referenced (Source) -> Referencing (Target)'} = '向后引用（源） -> 引用（目标）';
    $Self->{Translation}->{'Link Direction'} = '链接方向';
    $Self->{Translation}->{'The referencing object is the one containing this dynamic field, the referenced object is the one selected as value of the dynamic field.'} =
        '引用对象是包含该动态字段的对象，被引用对象是被选为动态字段值的对象。';
    $Self->{Translation}->{'Dynamic (ConfigItem)'} = '动态（ConfigItem）';
    $Self->{Translation}->{'Static (Version)'} = '静态（版本）';
    $Self->{Translation}->{'Link Referencing Type'} = '链接引用类型';
    $Self->{Translation}->{'Whether this link applies to the ConfigItem or the static version of the referencing object. Current Incident State calculation only is performed on dynamic links.'} =
        '此链接适用于引用对象的配置项还是静态版本。当前事件状态计算仅在动态链接上执行。';
    $Self->{Translation}->{'Select the attribute which config items will be searched by'} = '选择搜索配置项的属性';

    # Perl Module: Kernel/System/ITSMConfigItem/Definition.pm
    $Self->{Translation}->{'Base structure is not valid. Please provide a hash with data in YAML format.'} =
        '基础结构无效。请提供包含 YAML 格式数据的哈希值。';
    $Self->{Translation}->{'Starting the YAML string with \'---\' is required.'} = '必须以"---"开始 YAML 字符串。';

    # Perl Module: Kernel/System/ITSMConfigItem/Link.pm
    $Self->{Translation}->{'Could not purge the table configitem_link.'} = '无法清除表 configitem_link。';
    $Self->{Translation}->{'No relevant dynamic fields were found'} = '未找到相关动态字段';
    $Self->{Translation}->{'Could not insert into the table configitem_link'} = '无法插入表 configitem_link';
    $Self->{Translation}->{'Inserted 0 rows into the table configitem_link'} = '向表 configitem_link 插入了 0 条记录';

    # Perl Module: Kernel/System/ImportExport/ObjectBackend/ITSMConfigItem.pm
    $Self->{Translation}->{'Maximum number of one element'} = '此元素的最大數量';
    $Self->{Translation}->{'Empty fields indicate that the current values are kept'} = '空字段表示當前值被保存';
    $Self->{Translation}->{'Skipped'} = '跳過的';

    # Perl Module: Kernel/Modules/AdminDynamicField.pm
    $Self->{Translation}->{'Error synchronizing the definitions. Please check the log.'} = '同步定义时出错。请查看日志。';
    $Self->{Translation}->{'You have ITSMConfigItem definitions which are not synchronized. Please deploy your ITSMConfigItem dynamic field changes.'} =
        '您的 ITSMConfigItem 定义未同步。请部署您的 ITSMConfigItem 动态字段更改。';

    # Database XML / SOPM Definition: ITSMConfigurationManagement.sopm
    $Self->{Translation}->{'Expired'} = '到期';
    $Self->{Translation}->{'Maintenance'} = '維護';
    $Self->{Translation}->{'Pilot'} = '試驗';
    $Self->{Translation}->{'Planned'} = '已計劃';
    $Self->{Translation}->{'Repair'} = '修復';
    $Self->{Translation}->{'Retired'} = '報廢';
    $Self->{Translation}->{'Review'} = '複審';
    $Self->{Translation}->{'Test/QA'} = '测試/QA';

    # JS File: ITSM.Admin.ITSMConfigItem
    $Self->{Translation}->{'Overview and Confirmation'} = '概述和确认';
    $Self->{Translation}->{'Importing classes/roles and their related fields'} = '导入类/角色及其相关字段';
    $Self->{Translation}->{'An error occurred during class import.'} = '类导入时发生错误。';

    # SysConfig
    $Self->{Translation}->{'0 - Hidden'} = '0 - 隐藏';
    $Self->{Translation}->{'1 - Shown'} = '1 - 显示';
    $Self->{Translation}->{'Allows extended search conditions in config item search of the agent interface. With this feature you can search e. g. config item name with this kind of conditions like "(*key1*&&*key2*)" or "(*key1*||*key2*)".'} =
        '允许在代理界面的配置项搜索中使用扩展搜索条件。利用该功能，您可以使用"(*key1*&&*key2*) "或"(*key1*||*key2*) "等条件搜索配置项名称。';
    $Self->{Translation}->{'Allows extended search conditions in config item search of the customer interface. With this feature you can search e. g. config item name with this kind of conditions like "(*key1*&&*key2*)" or "(*key1*||*key2*)".'} =
        '允许在客户界面的配置项搜索中使用扩展搜索条件。利用该功能，您可以使用"(*key1*&&*key2*) "或"(*key1*||*key2*) "等条件搜索配置项名称。';
    $Self->{Translation}->{'Assigned CIs'} = '分配的 CI';
    $Self->{Translation}->{'At a specific time point create a ticket for config items, if the configured requirements are met. The time point is determined by the value of the field configured under "TimeCIKey" of the ConfigItem, and modified by "TimeModifier". If the latter can be either just a number, or a sign (+/-), a number, and an unit (d/h/m): "7" is equivalent to "+7d". The DynamicField "Ticket->DynamicField" will be used to mark created tickets - it has to exist. The flags \<OTOBO_CONFIGITEM_X\> where X can be NAME, NUMBER and DATE, will be substituted with the respective values in "Ticket->Text".'} =
        '如果符合配置要求，则在特定时间点为配置项创建票据。时间点由配置项 "TimeCIKey "下配置的字段值决定，并由 "TimeModifier "修改。后者可以是一个数字，也可以是一个符号（+/-）、一个数字和一个单位（d/h/m）："7 "相当于 "+7d"。动态字段 "Ticket->DynamicField "将用于标记创建的票单--它必须存在。标记（\<OTOBO_CONFIGITEM_X\>），其中 X 可以是 NAME、NUMBER 和 DATE，将被替换为 "Ticket->Text"（票据->文本）中的相应值。';
    $Self->{Translation}->{'CIs assigned to customer company'} = '分配给客户公司的 CI';
    $Self->{Translation}->{'CIs assigned to customer user'} = '分配给客户用户的 CI';
    $Self->{Translation}->{'CMDB Settings'} = 'CMDB 设置';
    $Self->{Translation}->{'Check for a unique name only within the same ConfigItem class (\'class\') or globally (\'global\'), which means every existing ConfigItem is taken into account when looking for duplicates.'} =
        '仅在同一 ConfigItem 类（"class"）或全局（"global"）内检查唯一名称，这意味着在查找重复时，每个现有的 ConfigItem 都会被考虑在内。';
    $Self->{Translation}->{'Choose a module to enforce a naming scheme.'} = '选择一个模块来执行命名方案。';
    $Self->{Translation}->{'Choose a module to enforce a number scheme.'} = '选择一个模块来执行数字方案。';
    $Self->{Translation}->{'Choose a module to enforce a version string scheme.'} = '选择一个模块来执行版本字符串方案。';
    $Self->{Translation}->{'Choose attributes to trigger the creation of a new version.'} = '选择触发创建新版本的属性。';
    $Self->{Translation}->{'Choose categories to assign to this config item class.'} = '选择要分配给此配置项类别的类别。';
    $Self->{Translation}->{'Column config item filters for ConfigItem Overview.'} = '配置项概览的列配置项过滤器。';
    $Self->{Translation}->{'Columns that can be filtered in the config item overview of the agent interface. Note: Only Config Item attributes and Dynamic Fields (DynamicField_NameX) are allowed.'} =
        '可在代理界面配置项概览中过滤的列。注意：只允许使用配置项属性和动态字段 (DynamicField_NameX)。';
    $Self->{Translation}->{'Columns that can be filtered in the config item overview of the customer interface. Note: Only Config Item attributes and Dynamic Fields (DynamicField_NameX) are allowed.'} =
        '可在客户界面配置项概览中过滤的列。注意：只允许使用配置项属性和动态字段 (DynamicField_NameX)。';
    $Self->{Translation}->{'Columns that can be filtered in the config item search result overview of the agent interface. Note: Only Config Item attributes and Dynamic Fields (DynamicField_NameX) are allowed.'} =
        '可在代理界面的配置项搜索结果概览中过滤的列。注意：只允许使用配置项属性和动态字段 (DynamicField_NameX)。';
    $Self->{Translation}->{'Config Items'} = '配置項';
    $Self->{Translation}->{'Config item add.'} = '添加配置项目。';
    $Self->{Translation}->{'Config item edit.'} = '配置项目编辑。';
    $Self->{Translation}->{'Config item event module that count the licenses for OTOBOCILicenseCount feature.'} =
        '用于计算 OTOBOCILicenseCount 功能许可证的配置项事件模块。';
    $Self->{Translation}->{'Config item event module that enables logging to history in the agent interface.'} =
        '配置项事件模块，可将日志记录到代理界面的历史记录中。';
    $Self->{Translation}->{'Config item event module that updates config items to their current definition.'} =
        '配置项事件模块，用于将配置项更新为当前定义。';
    $Self->{Translation}->{'Config item event module that updates the table configitem_ĺink.'} =
        '更新表 configitem_ĺink 的配置项事件模块。';
    $Self->{Translation}->{'Config item event module updates the current incident state.'} =
        '配置项目事件模块更新当前事件状态。';
    $Self->{Translation}->{'Config item history.'} = '配置项目历史。';
    $Self->{Translation}->{'Config item print.'} = '配置项目打印。';
    $Self->{Translation}->{'Config item zoom.'} = '配置项目缩放。';
    $Self->{Translation}->{'ConfigItem Tree View'} = '配置项树形视图';
    $Self->{Translation}->{'ConfigItem Version'} = '配置项目版本';
    $Self->{Translation}->{'ConfigItems of the following classes will not be stored on the Elasticsearch server. To apply this to existing CIs, the CI migration has to be run via console, after changing this option.'} =
        '以下类别的配置项将不会存储在 Elasticsearch 服务器上。要将此应用于现有的 CI，必须在更改此选项后通过控制台运行 CI 迁移。';
    $Self->{Translation}->{'ConfigItems with the following deployment states will not be stored on the Elasticsearch server. To apply this to existing CIs, the CI migration has to be run via console, after changing this option.'} =
        '具有以下部署状态的配置项将不会存储在 Elasticsearch 服务器上。要将此应用于现有的 CI，必须在更改此选项后通过控制台运行 CI 迁移。';
    $Self->{Translation}->{'Configuration Item Limit'} = '配置项目限制';
    $Self->{Translation}->{'Configuration Item limit per page.'} = '每页配置项目限制。';
    $Self->{Translation}->{'Configuration Management Database.'} = '配置管理数据库。';
    $Self->{Translation}->{'Configuration item bulk module.'} = '配置项批量模块。';
    $Self->{Translation}->{'Configuration item search backend router of the agent interface.'} =
        '配置项搜索代理接口的后端路由器。';
    $Self->{Translation}->{'Create and manage the definitions for Configuration Items.'} = '創建和管理配置項定義';
    $Self->{Translation}->{'Creates Tickets for ConfigItems at specific time points.'} = '在特定时间点为 ConfigItems 创建 Tickets。';
    $Self->{Translation}->{'Customers can see historic CI versions.'} = '客户可以查看历史 CI 版本。';
    $Self->{Translation}->{'Customers have the possibility to manually switch between historic CI versions.'} =
        '客户可以手动切换历史 CI 版本。';
    $Self->{Translation}->{'Default data to use on attribute for config item search screen. Example: "ITSMConfigItemCreateTimePointFormat=year;ITSMConfigItemCreateTimePointStart=Last;ITSMConfigItemCreateTimePoint=2;".'} =
        '在配置项搜索屏幕的属性上使用的默认数据。例如："ITSMConfigItemCreateTimePointFormat=year;ITSMConfigItemCreateTimePointStart=Last;ITSMConfigItemCreateTimePoint=2;"。';
    $Self->{Translation}->{'Default data to use on attribute for config item search screen. Example: "ITSMConfigItemCreateTimeStartYear=2010;ITSMConfigItemCreateTimeStartMonth=10;ITSMConfigItemCreateTimeStartDay=4;ITSMConfigItemCreateTimeStopYear=2010;ITSMConfigItemCreateTimeStopMonth=11;ITSMConfigItemCreateTimeStopDay=3;".'} =
        '在配置项搜索屏幕的属性上使用的默认数据。例如："ITSMConfigItemCreateTimeStartYear=2010;ITSMConfigItemCreateTimeStartMonth=10;ITSMConfigItemCreateTimeStartDay=4;ITSMConfigItemCreateTimeStopYear=2010;ITSMConfigItemCreateTimeStopMonth=11;ITSMConfigItemCreateTimeStopDay=3;"。';
    $Self->{Translation}->{'Define Actions where a settings button is available in the linked objects widget (LinkObject::ViewMode = "complex"). Please note that these Actions must have registered the following JS and CSS files: Core.AllocationList.css, Core.UI.AllocationList.js, Core.UI.Table.Sort.js, Core.Agent.TableFilters.js and Core.Agent.LinkObject.js.'} =
        '定义可在链接对象 widget 中使用设置按钮的操作（LinkObject::ViewMode = "complex"）。请注意，这些操作必须已注册以下 JS 和 CSS 文件：Core.AllocationList.css、Core.UI.AllocationList.js、Core.UI.Table.Sort.js、Core.Agent.TableFilters.js 和 Core.Agent.LinkObject.js。';
    $Self->{Translation}->{'Define a Template::Toolkit scheme for version strings. Only used if Version String Module is set to TemplateToolkit.'} =
        '为版本字符串定义一个 Template::Toolkit 方案。仅在版本字符串模块设置为 TemplateToolkit 时使用。';
    $Self->{Translation}->{'Define a set of conditions under which a customer is allowed to see a config item. Conditions can optionally be restricted to certain customer groups. Name is the only mandatory attribute. If no other options are given, all config items will be visible under that category.'} =
        '定义一组允许客户查看配置项的条件。可选择将条件限制为某些客户组。名称是唯一的强制属性。如果没有给出其他选项，则该类别下的所有配置项都将可见。';
    $Self->{Translation}->{'Defines Required permissions to create ITSM configuration items using the Generic Interface.'} =
        '定义使用通用接口创建 ITSM 配置项所需的权限。';
    $Self->{Translation}->{'Defines Required permissions to delete ITSM configuration items using the Generic Interface.'} =
        '定义使用通用接口删除 ITSM 配置项所需的权限。';
    $Self->{Translation}->{'Defines Required permissions to get ITSM configuration items using the Generic Interface.'} =
        '定义使用通用接口获取 ITSM 配置项所需的权限。';
    $Self->{Translation}->{'Defines Required permissions to search ITSM configuration items using the Generic Interface.'} =
        '定义使用通用接口搜索 ITSM 配置项所需的权限。';
    $Self->{Translation}->{'Defines Required permissions to update ITSM configuration items using the Generic Interface.'} =
        '定义使用通用接口更新 ITSM 配置项所需的权限。';
    $Self->{Translation}->{'Defines an overview module to show the small view of a configuration item list.'} =
        '定义一个概览模块，用于显示配置项目列表的小视图。';
    $Self->{Translation}->{'Defines if the link type labels must be shown in the node connections.'} =
        '定义是否必须在节点连接中显示链接类型标签。';
    $Self->{Translation}->{'Defines regular expressions individually for each ConfigItem class to check the ConfigItem name and to show corresponding error messages.'} =
        '为每个 ConfigItem 类单独定义正则表达式，以检查 ConfigItem 名称并显示相应的错误信息。';
    $Self->{Translation}->{'Defines the available columns of CIs in the config item overview depending on the CI class. Each entry must consist of a class name and an array of available fields for the corresponding class. Dynamic field entries have to honor the scheme DynamicField_FieldName.'} =
        '根据 CI 类别定义配置项概览中 CI 的可用列。每个条目必须包含一个类名和相应类的可用字段数组。动态字段条目必须遵守 DynamicField_FieldName 方案。';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of the agent interface.'} =
        '定义代理界面配置项搜索结果中配置项排序的默认配置项属性。';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of the customer interface.'} =
        '定义客户界面配置项搜索结果中配置项排序的默认配置项属性。';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of this operation.'} =
        '定义此操作的配置项搜索结果的配置项排序默认配置项属性。';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the agent interface. Up: oldest on top. Down: latest on top.'} =
        '定义代理界面配置项搜索结果中的默认配置项顺序。上：最旧的在最前面。下：最新的在上。';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the customer interface. Up: oldest on top. Down: latest on top.'} =
        '定义客户界面配置项搜索结果中的默认配置项顺序。上：最旧的在最前面。下：最新的在上。';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the this operation. Up: oldest on top. Down: latest on top.'} =
        '定义此操作的配置项搜索结果中的默认配置项顺序。上：最旧的在最前面。下：最新的在上。';
    $Self->{Translation}->{'Defines the default displayed columns of CIs in the config item overview depending on the CI class. Each entry must consist of a class name and an array of available fields for the corresponding class. Dynamic field entries have to honor the scheme DynamicField_FieldName.'} =
        '根据 CI 类定义配置项概览中默认显示的 CI 列。每个条目必须包含一个类名和相应类的可用字段数组。动态字段条目必须遵守 DynamicField_FieldName 方案。';
    $Self->{Translation}->{'Defines the default relations depth to be shown.'} = '定义默认显示的关系深度。';
    $Self->{Translation}->{'Defines the default shown config item search attribute for config item search screen.'} =
        '定义配置项目搜索界面默认显示的配置项目搜索属性。';
    $Self->{Translation}->{'Defines the default shown config item search attribute for config item search screen. Example: "Key" must have the name of the Dynamic Field in this case \'X\', "Content" must have the value of the Dynamic Field depending on the Dynamic Field type,  Text: \'a text\', Dropdown: \'1\', Date/Time: \'Search_DynamicField_XTimeSlotStartYear=1974; Search_DynamicField_XTimeSlotStartMonth=01; Search_DynamicField_XTimeSlotStartDay=26; Search_DynamicField_XTimeSlotStartHour=00; Search_DynamicField_XTimeSlotStartMinute=00; Search_DynamicField_XTimeSlotStartSecond=00; Search_DynamicField_XTimeSlotStopYear=2013; Search_DynamicField_XTimeSlotStopMonth=01; Search_DynamicField_XTimeSlotStopDay=26; Search_DynamicField_XTimeSlotStopHour=23; Search_DynamicField_XTimeSlotStopMinute=59; Search_DynamicField_XTimeSlotStopSecond=59;\' and or \'Search_DynamicField_XTimePointFormat=week; Search_DynamicField_XTimePointStart=Before; Search_DynamicField_XTimePointValue=7\';.'} =
        '定义配置项搜索屏幕默认显示的配置项搜索属性。Example: "Key" must have the name of the Dynamic Field in this case \'X\', "Content" must have the value of the Dynamic Field depending on the Dynamic Field type,  Text: \'a text\', Dropdown: \'1\', Date/Time:Search_DynamicField_XTimeSlotStartYear=1974；Search_DynamicField_XTimeSlotStartMonth=01；Search_DynamicField_XTimeSlotStartDay=26；Search_DynamicField_XTimeSlotStartHour=00；Search_DynamicField_XTimeSlotStartMinute=00; Search_DynamicField_XTimeSlotStartSecond=00; Search_DynamicField_XTimeSlotStopYear=2013; Search_DynamicField_XTimeSlotStopMonth=01；Search_DynamicField_XTimeSlotStopDay=26; Search_DynamicField_XTimeSlotStopHour=23; Search_DynamicField_XTimeSlotStopMinute=59; Search_DynamicField_XTimeSlotStopSecond=59；\'和或 \'Search_DynamicField_XTimePointFormat=week; Search_DynamicField_XTimePointStart=Before; Search_DynamicField_XTimePointValue=7\';。';
    $Self->{Translation}->{'Defines the default subobject of the class \'ITSMConfigItem\'.'} =
        '定义 "ITSMConfigItem "类的默认子对象。';
    $Self->{Translation}->{'Defines the initial height for the rich text editor component in pixels.'} =
        '';
    $Self->{Translation}->{'Defines the number of rows for the CI definition editor in the admin interface.'} =
        '定义管理界面中 CI 定义编辑器的行数。';
    $Self->{Translation}->{'Defines the order of incident states from high (e.g. cricital) to low (e.g. functional).'} =
        '定义事件状态从高到低（如环状）的顺序。';
    $Self->{Translation}->{'Defines the relevant deployment states where linked tickets can affect the status of a CI.'} =
        '定义相关部署状态，其中链接的票单可影响 CI 的状态。';
    $Self->{Translation}->{'Defines the search limit for the AgentITSMConfigItem screen.'} =
        '定义 AgentITSMConfigItem 屏幕的搜索限制。';
    $Self->{Translation}->{'Defines the search limit for the AgentITSMConfigItemSearch screen.'} =
        '定义 AgentITSMConfigItemSearch 屏幕的搜索限制。';
    $Self->{Translation}->{'Defines the search limit for the CustomerITSMConfigItem screen.'} =
        '定义客户ITSMConfigItem 屏幕的搜索限制。';
    $Self->{Translation}->{'Defines the search limit for the CustomerITSMConfigItemSearch screen.'} =
        '定义客户ITSMConfigItemSearch 屏幕的搜索限制。';
    $Self->{Translation}->{'Defines the shown columns of CIs in the link table complex view for all CI classes. If there is no entry, then the default columns are shown.'} =
        '定义链接表复合视图中所有 CI 类的 CI 显示列。如果没有条目，则显示默认列。';
    $Self->{Translation}->{'Defines the shown columns of CIs in the link table complex view, depending on the CI class. Each entry must be prefixed with the class name and double colons (i.e. Computer::). There are a few CI-Attributes that common to all CIs (example for the class Computer: Computer::Name, Computer::CurDeplState, Computer::CreateTime). To show individual CI-Attributes as defined in the CI-Definition, the following scheme must be used (example for the class Computer): Computer::HardDisk::1, Computer::HardDisk::1::Capacity::1, Computer::HardDisk::2, Computer::HardDisk::2::Capacity::1. If there is no entry for a CI class, then the default columns are shown.'} =
        '根据 CI 类别，定义链接表复合视图中显示的 CI 列。每个条目都必须以类名和双冒号为前缀（如 Computer::）。所有 CI 都有一些共同的 CI 属性（以 "计算机 "类为例：Computer::Name、Computer::CurDeplState、Computer::CreateTime）。要显示 CI 定义中定义的单个 CI 属性，必须使用以下方案（以计算机类为例）：Computer::HardDisk::1, Computer::HardDisk::1::Capacity::1, Computer::HardDisk::2, Computer::HardDisk::2::Capacity::1.如果没有 CI 类条目，则显示默认列。';
    $Self->{Translation}->{'Defines which items are available for \'Action\' in third level of the ITSM Config Item ACL structure.'} =
        '定义哪些项目可用于 ITSM Config 项目 ACL 结构第三层中的 "操作"。';
    $Self->{Translation}->{'Defines which items are available in first level of the ITSM Config Item ACL structure.'} =
        '定义 ITSM Config 项目 ACL 结构第一层中的可用项目。';
    $Self->{Translation}->{'Defines which items are available in second level of the ITSM Config Item ACL structure.'} =
        '定义 ITSM Config 项目 ACL 结构第二层中的可用项目。';
    $Self->{Translation}->{'Defines which type of link (named from the ticket perspective) can affect the status of a linked CI.'} =
        '定义哪种类型的链接（从票据角度命名）会影响链接 CI 的状态。';
    $Self->{Translation}->{'Defines which type of ticket can affect the status of a linked CI.'} =
        '定义哪种类型的票单会影响链接 CI 的状态。';
    $Self->{Translation}->{'Definition Update'} = '定义更新';
    $Self->{Translation}->{'Delete Configuration Item'} = '删除配置项';
    $Self->{Translation}->{'DeplState'} = 'DeplState';
    $Self->{Translation}->{'Deployment State Color'} = '部署状态颜色';
    $Self->{Translation}->{'DeploymentState'} = '部署状态';
    $Self->{Translation}->{'Duplicate'} = '複製';
    $Self->{Translation}->{'Dynamic field event module that marks config item definitions as out of sync, if containing dynamic fields change.'} =
        '动态字段事件模块，用于在包含的动态字段发生变化时将配置项定义标记为不同步。';
    $Self->{Translation}->{'Dynamic fields shown in the additional ITSM field screen of the agent interface.'} =
        '在代理界面的附加 ITSM 字段屏幕中显示的动态字段。';
    $Self->{Translation}->{'Dynamic fields shown in the config item overview screen of the customer interface.'} =
        '客户界面配置项目概览屏幕中显示的动态字段。';
    $Self->{Translation}->{'Dynamic fields shown in the config item search screen of the agent interface.'} =
        '在代理界面的配置项搜索屏幕中显示的动态字段。';
    $Self->{Translation}->{'Enables configuration item bulk action feature for the agent frontend to work on more than one configuration item at a time.'} =
        '启用配置项批量操作功能，使代理前台能同时处理多个配置项。';
    $Self->{Translation}->{'Enables configuration item bulk action feature only for the listed groups.'} =
        '仅对列出的组启用配置项批量操作功能。';
    $Self->{Translation}->{'Enables/disables the functionality to check ITSM onfiguration items for unique names. Before enabling this option you should check your system for already existing config items with duplicate names. You can do this with the console command Admin::ITSM::Configitem::ListDuplicates.'} =
        '启用/禁用检查 ITSM 配置项是否具有唯一名称的功能。启用此选项前，应检查系统中是否存在名称重复的配置项。您可以使用控制台命令 Admin::ITSM::Configitem::ListDuplicates 进行检查。';
    $Self->{Translation}->{'Event module to set configitem-status on ticket-configitem-link.'} =
        '在 ticket-configitem-link 上设置 configitem-status 的事件模块。';
    $Self->{Translation}->{'Fields of the configuration item index, used for the fulltext search. Fields are also stored, but are not mandatory for the overall functionality. Inclusion of attachments can be disabled by setting the entry to 0 or deleting it.'} =
        '配置项索引字段，用于全文搜索。字段也会被存储，但对于整体功能来说并非必须。可通过将条目设置为 0 或删除来禁用附件的包含。';
    $Self->{Translation}->{'Fields stored in the configuration item index which are used for other things besides fulltext searches. For the complete functionality all fields are mandatory.'} =
        '存储在配置项索引中的字段，除用于全文检索外，还可用于其他用途。为了实现完整的功能，所有字段都是必填字段。';
    $Self->{Translation}->{'For every webservice (key) an array of classes (value) can be defined on which the import is restricted. For all chosen classes, or all existing classes the identifying attributes will have to be chosen in the invoker config.'} =
        '可以为每个 webservice（键）定义一个类（值）数组，在此基础上限制导入。对于所有选定的类或所有现有的类，必须在调用者配置中选择识别属性。';
    $Self->{Translation}->{'GenericInterface module registration for the ConfigItemFetch invoker layer.'} =
        '用于 ConfigItemFetch 调用层的 GenericInterface 模块注册。';
    $Self->{Translation}->{'ITSM ConfigItem'} = 'ITSM 配置项目';
    $Self->{Translation}->{'ITSM config item overview.'} = 'ITSM 配置项目概览。';
    $Self->{Translation}->{'If this option is activated, linked items are only counted if they belong to one of the listed classes.'} =
        '如果激活此选项，则只有属于所列类别之一的链接项才会被计算在内。';
    $Self->{Translation}->{'InciState'} = '状态';
    $Self->{Translation}->{'IncidentState'} = '事件状态';
    $Self->{Translation}->{'Includes deployment states in the config item search of the customer interface.'} =
        '在客户界面的配置项搜索中包含部署状态。';
    $Self->{Translation}->{'Includes incident states in the config item search of the customer interface.'} =
        '在客户界面的配置项目搜索中包含事件状态。';
    $Self->{Translation}->{'Maximum number of config items to be displayed in the result of this operation.'} =
        '在此操作结果中显示的配置项的最大数量。';
    $Self->{Translation}->{'Module to check the group responsible for a class.'} = '检查负责班级的小组的模块。';
    $Self->{Translation}->{'Module to check the group responsible for a configuration item.'} =
        '模块，用于检查负责配置项的组。';
    $Self->{Translation}->{'Module to generate ITSM config item statistics.'} = '生成 ITSM 配置项统计数据的模块。';
    $Self->{Translation}->{'Name Module'} = '名称模块';
    $Self->{Translation}->{'Number Module'} = '编号模块';
    $Self->{Translation}->{'Number of config items to be displayed in each page of a search result in the agent interface.'} =
        '在代理界面搜索结果的每一页中显示的配置项数量。';
    $Self->{Translation}->{'Number of config items to be displayed in each page of a search result in the customer interface.'} =
        '客户界面搜索结果每页显示的配置项数量。';
    $Self->{Translation}->{'Objects to search for, how many entries and which attributs to show. ConfigItem attributes have to explicitly be stored via Elasticsearch.'} =
        '要搜索的对象、条目数量以及要显示的属性。配置项属性必须通过 Elasticsearch 明确存储。';
    $Self->{Translation}->{'Overview.'} = '概況';
    $Self->{Translation}->{'Parameters for the categories for config item classes in the preferences view of the agent interface.'} =
        '代理界面首选项视图中配置项类别的参数。';
    $Self->{Translation}->{'Parameters for the column filters of the small config item overview. Please note: setting \'Active\' to 0 will only prevent agents from editing settings of this group in their personal preferences, but will still allow administrators to edit the settings of another user\'s behalf. Use \'PreferenceGroup\' to control in which area these settings should be shown in the user interface.'} =
        '小配置项目概览的列过滤器参数。请注意：将 "Active（活动）"设置为 0 只会阻止代理在其个人偏好设置中编辑该组的设置，但仍允许管理员编辑其他用户的设置。使用 "PreferenceGroup（偏好组）"可控制这些设置应显示在用户界面的哪个区域。';
    $Self->{Translation}->{'Parameters for the dashboard backend of the customer company config item overview of the agent interface . "Limit" is the number of entries shown by default. "Group" is used to restrict the access to the plugin (e. g. Group: admin;group1;group2;). "Default" determines if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" is the cache time in minutes for the plugin.'} =
        '"限制 "是默认显示的条目数量。"组 "用于限制插件的访问权限（例如，组：admin;group1;group2;）。"默认 "决定插件是默认启用还是用户需要手动启用。"CacheTTLLocal "是插件的缓存时间，以分钟为单位。';
    $Self->{Translation}->{'Parameters for the deployment states color in the preferences view of the agent interface.'} =
        '代理界面首选项视图中部署状态颜色的参数。';
    $Self->{Translation}->{'Parameters for the deployment states in the preferences view of the agent interface.'} =
        '代理界面首选项视图中部署状态的参数。';
    $Self->{Translation}->{'Parameters for the example permission groups of the general catalog attributes.'} =
        '通用目录属性权限组示例的参数。';
    $Self->{Translation}->{'Parameters for the name module for config item classes in the preferences view of the agent interface.'} =
        '代理界面首选项视图中配置项类名称模块的参数。';
    $Self->{Translation}->{'Parameters for the number module for config item classes in the preferences view of the agent interface.'} =
        '代理界面首选项视图中配置项类别的编号模块参数。';
    $Self->{Translation}->{'Parameters for the pages (in which the configuration items are shown).'} =
        '页面（显示配置项的页面）参数。';
    $Self->{Translation}->{'Parameters for the version string module for config item classes in the preferences view of the agent interface.'} =
        '代理界面首选项视图中配置项类的版本字符串模块参数。';
    $Self->{Translation}->{'Parameters for the version string template toolkit module for config item classes in the preferences view of the agent interface.'} =
        '用于代理界面首选项视图中配置项类的版本字符串模板工具包模块参数。';
    $Self->{Translation}->{'Parameters for the version trigger for config item classes in the preferences view of the agent interface.'} =
        '代理界面首选项视图中配置项类的版本触发器参数。';
    $Self->{Translation}->{'Performs the configured action for each event (as an Invoker) for each configured Webservice.'} =
        '为每个配置的 Webservice 的每个事件（作为调用者）执行配置的操作。';
    $Self->{Translation}->{'Permission Group'} = '权限组';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item attachment action in the agent interface.'} =
        '在代理界面中使用 ITSM 配置项目附件操作所需的权限。';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item screen in the agent interface.'} =
        '在代理界面中使用 ITSM 配置项目屏幕所需的权限。';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item search screen in the agent interface.'} =
        '在代理界面中使用 ITSM 配置项目搜索屏幕所需的权限。';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item search screen in the customer interface.'} =
        '在客户界面使用 ITSM 配置项目搜索屏幕所需的权限。';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item tree view screen in the agent interface.'} =
        '在代理界面中使用 ITSM 配置项目树视图屏幕所需的权限。';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item zoom screen in the agent interface.'} =
        '在代理界面中使用 ITSM 配置项目缩放屏幕所需的权限。';
    $Self->{Translation}->{'Required permissions to use the add ITSM configuration item screen in the agent interface.'} =
        '使用代理界面中的添加 ITSM 配置项目屏幕所需的权限。';
    $Self->{Translation}->{'Required permissions to use the bulk ITSM configuration item screen in the agent interface.'} =
        '在代理界面中使用批量 ITSM 配置项目屏幕所需的权限。';
    $Self->{Translation}->{'Required permissions to use the edit ITSM configuration item screen in the agent interface.'} =
        '使用代理界面中的编辑 ITSM 配置项目屏幕所需的权限。';
    $Self->{Translation}->{'Required permissions to use the history ITSM configuration item screen in the agent interface.'} =
        '在代理界面中使用历史 ITSM 配置项目屏幕所需的权限。';
    $Self->{Translation}->{'Required permissions to use the print ITSM configuration item screen in the agent interface.'} =
        '在代理界面中使用打印 ITSM 配置项目屏幕所需的权限。';
    $Self->{Translation}->{'Required privileges to delete config items.'} = '删除配置项所需的权限。';
    $Self->{Translation}->{'Search config items.'} = '搜索配置项。';
    $Self->{Translation}->{'Set the incident state of a CI automatically when a Ticket is Linked to a CI.'} =
        '当票单链接到 CI 时，自动设置 CI 的事件状态。';
    $Self->{Translation}->{'Sets the deployment state in the configuration item bulk screen of the agent interface.'} =
        '在代理界面的配置项批量屏幕中设置部署状态。';
    $Self->{Translation}->{'Sets the incident state in the configuration item bulk screen of the agent interface.'} =
        '在代理界面的配置项目批量界面中设置事件状态。';
    $Self->{Translation}->{'Shows a link in the menu that allows linking a configuration item with another object in the config item zoom view of the agent interface.'} =
        '显示菜单中的链接，允许在代理界面的配置项缩放视图中将一个配置项与另一个对象相链接。';
    $Self->{Translation}->{'Shows a link in the menu to access the history of a configuration item in the configuration item overview of the agent interface.'} =
        '在代理界面的配置项目概览中显示一个菜单链接，用于访问配置项目的历史记录。';
    $Self->{Translation}->{'Shows a link in the menu to access the history of a configuration item in the its zoom view of the agent interface.'} =
        '显示菜单中的链接，以便在代理界面的缩放视图中访问配置项的历史记录。';
    $Self->{Translation}->{'Shows a link in the menu to delete a configuration item in its zoom view of the agent interface.'} =
        '在代理界面缩放视图的菜单中显示删除配置项的链接。';
    $Self->{Translation}->{'Shows a link in the menu to display the configuration item links as a Tree View.'} =
        '在菜单中显示一个链接，以树形视图显示配置项链接。';
    $Self->{Translation}->{'Shows a link in the menu to duplicate a configuration item in the configuration item overview of the agent interface.'} =
        '在代理界面的配置项目概览中显示菜单链接，以复制配置项目。';
    $Self->{Translation}->{'Shows a link in the menu to duplicate a configuration item in the its zoom view of the agent interface.'} =
        '在菜单中显示一个链接，用于在代理界面的缩放视图中复制一个配置项。';
    $Self->{Translation}->{'Shows a link in the menu to edit a configuration item in the its zoom view of the agent interface.'} =
        '在代理界面的缩放视图中显示编辑配置项的菜单链接。';
    $Self->{Translation}->{'Shows a link in the menu to go back in the configuration item zoom view of the agent interface.'} =
        '在菜单中显示一个链接，用于返回代理界面的配置项缩放视图。';
    $Self->{Translation}->{'Shows a link in the menu to print a configuration item in the its zoom view of the agent interface.'} =
        '在代理界面的缩放视图中显示菜单链接，以打印配置项。';
    $Self->{Translation}->{'Shows a link in the menu to zoom into a configuration item in the configuration item overview of the agent interface.'} =
        '在菜单中显示一个链接，用于放大代理界面配置项概览中的配置项。';
    $Self->{Translation}->{'Shows the config item history (reverse ordered) in the agent interface.'} =
        '显示代理界面中的配置项目历史记录（逆序）。';
    $Self->{Translation}->{'The default category which is shown, if none is selected.'} = '如果未选择任何类别，则显示默认类别。';
    $Self->{Translation}->{'The identifier for a configuration item, e.g. ConfigItem#, MyConfigItem#. The default is ConfigItem#.'} =
        '配置项的标识符，如 ConfigItem#、MyConfigItem#。默认为 ConfigItem#。';
    $Self->{Translation}->{'Triggers ConfigItemFetch invoker automatically.'} = '自动触发 ConfigItemFetch 调用器。';
    $Self->{Translation}->{'Version String Expression'} = '版本字符串表达式';
    $Self->{Translation}->{'Version String Module'} = '版本字符串模块';
    $Self->{Translation}->{'Version Trigger'} = '版本触发器';
    $Self->{Translation}->{'Whether the execution of ConfigItemACL can be avoided by checking cached field dependencies. This can improve loading times of formulars, but has to be disabled, if ACLModules are to be used for ITSMConfigItem- and Form-ReturnTypes.'} =
        '是否可以通过检查缓存字段依赖关系来避免执行 ConfigItemACL。这可以缩短表格的加载时间，但如果要在 ITSMConfigItem 和 Form-ReturnType 中使用 ACL 模块，则必须禁用。';
    $Self->{Translation}->{'Which general information is shown in the header.'} = '标题中显示了哪些一般信息。';
    $Self->{Translation}->{'With this option it´s possible to fill automaticly a CI field, depending on the count of linked CI´s with the existing type DependsOn.'} =
        '使用该选项可以根据现有类型为 DependsOn 的链接 CI 的数量自动填充 CI 字段。';
    $Self->{Translation}->{'With this option it´s possible to fill automaticly a CI field, depending on the count of linked CI´s.'} =
        '使用该选项可以根据链接的 CI 数量自动填充 CI 字段。';
    $Self->{Translation}->{'With this option it´s possible to fill automaticly a CI field, depending on the count of linked CI´s. The setting CounterClassName include the name of the class and CounterFieldName is used to store the count of used licence.'} =
        '使用该选项可以根据链接的 CI 数量自动填充 CI 字段。设置 CounterClassName 包含类的名称，CounterFieldName 用于存储已使用许可证的计数。';
    $Self->{Translation}->{'class'} = '类';
    $Self->{Translation}->{'global'} = '全球';
    $Self->{Translation}->{'postproductive'} = '后生产';
    $Self->{Translation}->{'preproductive'} = '生殖前';
    $Self->{Translation}->{'productive'} = '生产性';


    push @{ $Self->{JavaScriptStrings} // [] }, (
    'Add all',
    'An error occurred during class import.',
    'An error occurred during communication.',
    'An item with this name is already present.',
    'Cancel',
    'Confirm',
    'Delete',
    'Dismiss',
    'Do you want to proceed?',
    'Importing classes/roles and their related fields',
    'No',
    'Note that also corresponding dynamic fields and GeneralCatalog classes will be created and there is no automatic removal.',
    'Ok',
    'Overview and Confirmation',
    'Please enter at least one search value or * to find anything.',
    'Search',
    'Settings',
    'Submit',
    'The following classes will be imported',
    'The following roles will be imported',
    'This item still contains sub items. Are you sure you want to remove this item including its sub items?',
    'Yes',
    );

}

1;

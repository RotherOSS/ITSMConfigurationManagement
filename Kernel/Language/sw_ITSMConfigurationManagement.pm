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

package Kernel::Language::sw_ITSMConfigurationManagement;

use strict;
use warnings;
use utf8;

sub Data {
    my $Self = shift;

    # Template: AdminITSMConfigItem
    $Self->{Translation}->{'Config Item Management'} = 'Usanidi wa usimamizi wa kipengele ';
    $Self->{Translation}->{'Change class definition'} = 'Badili ufafanuzi wa tabaka';
    $Self->{Translation}->{'Change role definition'} = '';
    $Self->{Translation}->{'Ready2Import Class Bundles'} = '';
    $Self->{Translation}->{'Here you can import Ready2Import class bundles showcasing our most usual config items. Please note that some additional configuration may be required.'} =
        '';
    $Self->{Translation}->{'Update existing entities'} = '';
    $Self->{Translation}->{'Import Ready2Adopt class bundles'} = '';
    $Self->{Translation}->{'Config Item Class'} = '';
    $Self->{Translation}->{'Config Item Role'} = '';

    # Template: AgentITSMConfigItemAdd
    $Self->{Translation}->{'Config Item'} = 'Usanidi wa Kipengele ';
    $Self->{Translation}->{'Filter for Classes'} = 'Chuja kwa ajili ya matabaka';
    $Self->{Translation}->{'Select a Class from the list to create a new Config Item.'} = 'Chagua tabaka kutoka kwenye orodha ya kutengeneza kipengele cha usanidi kipya. ';
    $Self->{Translation}->{'Class'} = 'Tabaka';

    # Template: AgentITSMConfigItemBulk
    $Self->{Translation}->{'ITSM ConfigItem Bulk Action'} = 'Vitendo vya wingi vya kipengele cha usanidi cha ITSM';
    $Self->{Translation}->{'Deployment state'} = 'Hali ya kutumia';
    $Self->{Translation}->{'Incident state'} = 'Hali ya tukio';
    $Self->{Translation}->{'Link to another'} = 'Unganisha na nyingine';
    $Self->{Translation}->{'Invalid Configuration Item number!'} = 'Namba ya kipengele cha usanidi n batili!';
    $Self->{Translation}->{'The number of another Configuration Item to link with.'} = 'Namba ya kipengele kingine cha usanidi cha kuunganisha nacho.';

    # Template: AgentITSMConfigItemDelete
    $Self->{Translation}->{'Do you really want to delete this config item?'} = '';

    # Template: AgentITSMConfigItemEdit
    $Self->{Translation}->{'The name of this config item'} = 'Jina la hiki kipengele cha usanidi';
    $Self->{Translation}->{'Name is already in use by the ConfigItems with the following Number(s): %s'} =
        'Jina hili tayari limekwisha tumikana kipengele cha usanidi chenye namba i(z)fuatazo: %s';
    $Self->{Translation}->{'Version Number'} = 'Namba ya toleo';
    $Self->{Translation}->{'Version number of this config item'} = '';
    $Self->{Translation}->{'Version Number is already in use by the ConfigItems with the following Number(s): %s'} =
        '';
    $Self->{Translation}->{'Deployment State'} = 'Hali ya kutumia';
    $Self->{Translation}->{'Incident State'} = 'Hali ya tukio';

    # Template: AgentITSMConfigItemHistory
    $Self->{Translation}->{'History of Config Item: %s'} = '';
    $Self->{Translation}->{'History Content'} = 'Maudhui ya historia';
    $Self->{Translation}->{'Createtime'} = 'Muda wa kutengeneza';
    $Self->{Translation}->{'Zoom view'} = 'Mandhari iliyokuzwa';

    # Template: AgentITSMConfigItemOverviewNavBar
    $Self->{Translation}->{'Config Items per page'} = 'Vipengele vya usanidi kwa kila ukurusa';

    # Template: AgentITSMConfigItemOverviewSmall
    $Self->{Translation}->{'No config item data found.'} = '';
    $Self->{Translation}->{'Select this config item'} = '';

    # Template: AgentITSMConfigItemSearch
    $Self->{Translation}->{'Run Search'} = 'Tafuta';
    $Self->{Translation}->{'Also search in previous versions?'} = 'Pia tafuta katika toleo lililopita?';

    # Template: AgentITSMConfigItemTreeView
    $Self->{Translation}->{'TreeView for ConfigItem'} = '';
    $Self->{Translation}->{'Depth Level'} = '';
    $Self->{Translation}->{'Zoom In/Out'} = '';
    $Self->{Translation}->{'Max links level reached for ConfigItem!'} = '';

    # Template: AgentITSMConfigItemZoom
    $Self->{Translation}->{'Configuration Item'} = 'Kipengele cha Usanidi';
    $Self->{Translation}->{'Configuration Item Information'} = 'Taarifa za kipengele cha usanidi';
    $Self->{Translation}->{'Current Deployment State'} = 'Hali ya kutumia ya sasa';
    $Self->{Translation}->{'Current Incident State'} = 'Hali ya tukio la sasa';
    $Self->{Translation}->{'Last changed'} = 'Mwisho kubadilishwa';
    $Self->{Translation}->{'Last changed by'} = 'Mwisho kubadilishwa na';

    # Template: CustomerITSMConfigItem
    $Self->{Translation}->{'Your ConfigItems'} = '';

    # Template: CustomerITSMConfigItemSearch
    $Self->{Translation}->{'ConfigItem Search'} = '';

    # Template: AdminACL
    $Self->{Translation}->{'Object Type'} = 'Aina ya kipengele';

    # JS Template: ClassImportConfirm
    $Self->{Translation}->{'The following classes will be imported'} = '';
    $Self->{Translation}->{'The following roles will be imported'} = '';
    $Self->{Translation}->{'Note that also corresponding dynamic fields and GeneralCatalog classes will be created and there is no automatic removal.'} =
        '';
    $Self->{Translation}->{'Do you want to proceed?'} = 'Unataka kuendelea?';

    # Perl Module: Kernel/Modules/AdminITSMConfigItem.pm
    $Self->{Translation}->{'Need ExampleClasses!'} = '';
    $Self->{Translation}->{'Definition is no valid YAML hash.'} = '';

    # Perl Module: Kernel/Modules/AgentITSMConfigItem.pm
    $Self->{Translation}->{'Overview: ITSM ConfigItem'} = '';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemBulk.pm
    $Self->{Translation}->{'No ConfigItemID is given!'} = '';
    $Self->{Translation}->{'You need at least one selected Configuration Item!'} = '';
    $Self->{Translation}->{'You don\'t have write access to this configuration item: %s.'} =
        '';
    $Self->{Translation}->{'No definition was defined for class %s!'} = '';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemDelete.pm
    $Self->{Translation}->{'Config item "%s" not found in database!'} = '';
    $Self->{Translation}->{'Was not able to delete the configitem ID %s!'} = '';
    $Self->{Translation}->{'No version found for ConfigItemID %s!'} = '';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemEdit.pm
    $Self->{Translation}->{'No ConfigItemID, DuplicateID or ClassID is given!'} = '';
    $Self->{Translation}->{'No access is given!'} = '';

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
    $Self->{Translation}->{'ConfigItem'} = 'Kipengele cha usanidi';
    $Self->{Translation}->{'printed by %s at %s'} = '';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemSearch.pm
    $Self->{Translation}->{'Invalid ClassID!'} = '';
    $Self->{Translation}->{'No ClassID is given!'} = '';
    $Self->{Translation}->{'No access rights for this class given!'} = '';
    $Self->{Translation}->{'No Result!'} = '';
    $Self->{Translation}->{'Config Item Search Results'} = '';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemZoom.pm
    $Self->{Translation}->{'Can\'t show item, no access rights for ConfigItem are given!'} =
        '';
    $Self->{Translation}->{'ConfigItem not found!'} = '';
    $Self->{Translation}->{'No versions found!'} = '';
    $Self->{Translation}->{'operational'} = 'Uendeshaji';
    $Self->{Translation}->{'warning'} = 'Onyo';
    $Self->{Translation}->{'incident'} = 'Tukio';
    $Self->{Translation}->{'The deployment state of this config item'} = 'Hali ya matumizi ya hii kipengele cha usanidi ';
    $Self->{Translation}->{'The incident state of this config item'} = 'Hali ya tukio ya hiki kipengele cha usanidi';

    # Perl Module: Kernel/Modules/CustomerITSMConfigItemSearch.pm
    $Self->{Translation}->{'No permission'} = 'Hakuna ruhusa';
    $Self->{Translation}->{'Filter invalid!'} = '';
    $Self->{Translation}->{'Search params invalid!'} = '';

    # Perl Module: Kernel/Output/HTML/Dashboard/ITSMConfigItemGeneric.pm
    $Self->{Translation}->{'Shown config items'} = '';
    $Self->{Translation}->{'Deployment State Type'} = 'Aina ya hali ya kutumia';
    $Self->{Translation}->{'Current Incident State Type'} = 'Aina ya hali ya tukio la sasa';

    # Perl Module: Kernel/Output/HTML/ITSMConfigItem/LayoutDate.pm
    $Self->{Translation}->{'Between'} = 'Katikati';

    # Perl Module: Kernel/System/DynamicField/Driver/ConfigItem.pm
    $Self->{Translation}->{'Class restrictions for the config item'} = '';
    $Self->{Translation}->{'Select one or more classes to restrict selectable config items'} =
        '';
    $Self->{Translation}->{'Link type'} = '';
    $Self->{Translation}->{'Select the link type.'} = '';
    $Self->{Translation}->{'Forwards: Referencing (Source) -> Referenced (Target)'} = '';
    $Self->{Translation}->{'Backwards: Referenced (Source) -> Referencing (Target)'} = '';
    $Self->{Translation}->{'Link Direction'} = '';
    $Self->{Translation}->{'The referencing object is the one containing this dynamic field, the referenced object is the one selected as value of the dynamic field.'} =
        '';
    $Self->{Translation}->{'Dynamic (ConfigItem)'} = '';
    $Self->{Translation}->{'Static (Version)'} = '';
    $Self->{Translation}->{'Link Referencing Type'} = '';
    $Self->{Translation}->{'Whether this link applies to the ConfigItem or the static version of the referencing object. Current Incident State calculation only is performed on dynamic links.'} =
        '';
    $Self->{Translation}->{'Select the attribute which config items will be searched by'} = '';

    # Perl Module: Kernel/System/ITSMConfigItem/Definition.pm
    $Self->{Translation}->{'Base structure is not valid. Please provide a hash with data in YAML format.'} =
        '';
    $Self->{Translation}->{'Starting the YAML string with \'---\' is required.'} = '';

    # Perl Module: Kernel/System/ITSMConfigItem/Link.pm
    $Self->{Translation}->{'Could not purge the table configitem_link.'} = '';
    $Self->{Translation}->{'No relevant dynamic fields were found'} = '';
    $Self->{Translation}->{'Could not insert into the table configitem_link'} = '';
    $Self->{Translation}->{'Inserted 0 rows into the table configitem_link'} = '';

    # Perl Module: Kernel/System/ImportExport/ObjectBackend/ITSMConfigItem.pm
    $Self->{Translation}->{'Maximum number of one element'} = 'Kima cha juu cha namba ya elementi mojawapo';
    $Self->{Translation}->{'Empty fields indicate that the current values are kept'} = 'Uga zilizowazi zinaonyesha kwamba thamani za sasa zimewekwa.';
    $Self->{Translation}->{'Skipped'} = 'Rukwa';

    # Perl Module: Kernel/Modules/AdminDynamicField.pm
    $Self->{Translation}->{'Error synchronizing the definitions. Please check the log.'} = '';
    $Self->{Translation}->{'You have ITSMConfigItem definitions which are not synchronized. Please deploy your ITSMConfigItem dynamic field changes.'} =
        '';

    # Database XML / SOPM Definition: ITSMConfigurationManagement.sopm
    $Self->{Translation}->{'Expired'} = 'Imeisha';
    $Self->{Translation}->{'Maintenance'} = 'Matengenezo';
    $Self->{Translation}->{'Pilot'} = 'Kwanza';
    $Self->{Translation}->{'Planned'} = 'Iliyopangwa';
    $Self->{Translation}->{'Repair'} = 'Rekebisha';
    $Self->{Translation}->{'Retired'} = 'Staafu';
    $Self->{Translation}->{'Review'} = 'Mapitio';
    $Self->{Translation}->{'Test/QA'} = 'Jaribio/ Maswali na Majibu';

    # JS File: ITSM.Admin.ITSMConfigItem
    $Self->{Translation}->{'Overview and Confirmation'} = '';
    $Self->{Translation}->{'Importing classes/roles and their related fields'} = '';
    $Self->{Translation}->{'An error occurred during class import.'} = '';

    # SysConfig
    $Self->{Translation}->{'0 - Hidden'} = '';
    $Self->{Translation}->{'1 - Shown'} = '';
    $Self->{Translation}->{'Allows extended search conditions in config item search of the agent interface. With this feature you can search e. g. config item name with this kind of conditions like "(*key1*&&*key2*)" or "(*key1*||*key2*)".'} =
        '';
    $Self->{Translation}->{'Allows extended search conditions in config item search of the customer interface. With this feature you can search e. g. config item name with this kind of conditions like "(*key1*&&*key2*)" or "(*key1*||*key2*)".'} =
        '';
    $Self->{Translation}->{'Assigned CIs'} = '';
    $Self->{Translation}->{'CIs assigned to customer company'} = '';
    $Self->{Translation}->{'CIs assigned to customer user'} = '';
    $Self->{Translation}->{'CMDB Settings'} = '';
    $Self->{Translation}->{'Check for a unique name only within the same ConfigItem class (\'class\') or globally (\'global\'), which means every existing ConfigItem is taken into account when looking for duplicates.'} =
        'Angalia majina ya kipekee tu katika tabaka sawa la kipengele cha usanidi (\'Tabaka\') au zote (\'Zote\'), ambayo inamaanisha kila kipengele cha usanidi kilichopo kimejumuishwa wakati nakala pacha zinaangaliwa.';
    $Self->{Translation}->{'Choose a module to enforce a naming scheme.'} = '';
    $Self->{Translation}->{'Choose a module to enforce a number scheme.'} = '';
    $Self->{Translation}->{'Choose a module to enforce a version string scheme.'} = '';
    $Self->{Translation}->{'Choose attributes to trigger the creation of a new version.'} = '';
    $Self->{Translation}->{'Choose categories to assign to this config item class.'} = '';
    $Self->{Translation}->{'Column config item filters for ConfigItem Overview.'} = '';
    $Self->{Translation}->{'Columns that can be filtered in the config item overview of the agent interface. Note: Only Config Item attributes and Dynamic Fields (DynamicField_NameX) are allowed.'} =
        '';
    $Self->{Translation}->{'Columns that can be filtered in the config item overview of the customer interface. Note: Only Config Item attributes and Dynamic Fields (DynamicField_NameX) are allowed.'} =
        '';
    $Self->{Translation}->{'Columns that can be filtered in the config item search result overview of the agent interface. Note: Only Config Item attributes and Dynamic Fields (DynamicField_NameX) are allowed.'} =
        '';
    $Self->{Translation}->{'Config Items'} = 'Vipengele vya usanidi';
    $Self->{Translation}->{'Config item add.'} = '';
    $Self->{Translation}->{'Config item edit.'} = '';
    $Self->{Translation}->{'Config item event module that enables logging to history in the agent interface.'} =
        'Sanidi moduli ya tukio ya kipengele ambacho kinawezesha kuingia katika historia katika kiolesura cha wakala.';
    $Self->{Translation}->{'Config item event module that updates config items to their current definition.'} =
        '';
    $Self->{Translation}->{'Config item event module that updates the table configitem_ĺink.'} =
        '';
    $Self->{Translation}->{'Config item event module updates the current incident state.'} =
        '';
    $Self->{Translation}->{'Config item history.'} = '';
    $Self->{Translation}->{'Config item print.'} = '';
    $Self->{Translation}->{'Config item zoom.'} = '';
    $Self->{Translation}->{'ConfigItem Tree View'} = '';
    $Self->{Translation}->{'ConfigItem Version'} = '';
    $Self->{Translation}->{'ConfigItems of the following classes will not be stored on the Elasticsearch server. To apply this to existing CIs, the CI migration has to be run via console, after changing this option.'} =
        '';
    $Self->{Translation}->{'ConfigItems with the following deployment states will not be stored on the Elasticsearch server. To apply this to existing CIs, the CI migration has to be run via console, after changing this option.'} =
        '';
    $Self->{Translation}->{'Configuration Item Limit'} = 'Kikomo cha kipengele cha usanidi';
    $Self->{Translation}->{'Configuration Item limit per page.'} = '';
    $Self->{Translation}->{'Configuration Management Database.'} = '';
    $Self->{Translation}->{'Configuration item bulk module.'} = '';
    $Self->{Translation}->{'Configuration item search backend router of the agent interface.'} =
        'Kipanga njia cha mazingira ya nyuma cha utafutaji wa kipengele cha usanidi cha kiolesura cha wakala. ';
    $Self->{Translation}->{'Create and manage the definitions for Configuration Items.'} = 'Tengeneza na simamia ufafanuzi wa vipengele vya usanidi.';
    $Self->{Translation}->{'Customers can see historic CI versions.'} = '';
    $Self->{Translation}->{'Customers have the possibility to manually switch between historic CI versions.'} =
        '';
    $Self->{Translation}->{'Default data to use on attribute for config item search screen. Example: "ITSMConfigItemCreateTimePointFormat=year;ITSMConfigItemCreateTimePointStart=Last;ITSMConfigItemCreateTimePoint=2;".'} =
        '';
    $Self->{Translation}->{'Default data to use on attribute for config item search screen. Example: "ITSMConfigItemCreateTimeStartYear=2010;ITSMConfigItemCreateTimeStartMonth=10;ITSMConfigItemCreateTimeStartDay=4;ITSMConfigItemCreateTimeStopYear=2010;ITSMConfigItemCreateTimeStopMonth=11;ITSMConfigItemCreateTimeStopDay=3;".'} =
        '';
    $Self->{Translation}->{'Define Actions where a settings button is available in the linked objects widget (LinkObject::ViewMode = "complex"). Please note that these Actions must have registered the following JS and CSS files: Core.AllocationList.css, Core.UI.AllocationList.js, Core.UI.Table.Sort.js, Core.Agent.TableFilters.js and Core.Agent.LinkObject.js.'} =
        '';
    $Self->{Translation}->{'Define a Template::Toolkit scheme for version strings. Only used if Version String Module is set to TemplateToolkit.'} =
        '';
    $Self->{Translation}->{'Define a set of conditions under which a customer is allowed to see a config item. Conditions can optionally be restricted to certain customer groups. Name is the only mandatory attribute. If no other options are given, all config items will be visible under that category.'} =
        '';
    $Self->{Translation}->{'Defines Required permissions to create ITSM configuration items using the Generic Interface.'} =
        'Inafafanua ruhusa zinazohitajika kutengeneza vipengele vya usanidi vya ITSM kwa kutumia kiolesura cha jeneriki.';
    $Self->{Translation}->{'Defines Required permissions to delete ITSM configuration items using the Generic Interface.'} =
        '';
    $Self->{Translation}->{'Defines Required permissions to get ITSM configuration items using the Generic Interface.'} =
        'Inafafanua ruhusa zinazohitajika kupatavipengele vya usanidi vya ITSM kwa kutumia kiolesura cha jeneriki.';
    $Self->{Translation}->{'Defines Required permissions to search ITSM configuration items using the Generic Interface.'} =
        'Inafafanua ruhusa zinazohitajika kutafuta vipengele vya usanidi vya ITSM kwa kutumia kiolesura cha jeneriki.';
    $Self->{Translation}->{'Defines Required permissions to update ITSM configuration items using the Generic Interface.'} =
        'Inafafanua ruhusa zinazohitajika kusasisha vipengele vya usanidi vya ITSM kwa kutumia kiolesura cha jeneriki.';
    $Self->{Translation}->{'Defines an overview module to show the small view of a configuration item list.'} =
        'Inafafanua moduli ya mapitio kuonyesha mandhari ndogo ya orodha ya vipengele vya usanidi.';
    $Self->{Translation}->{'Defines if the link type labels must be shown in the node connections.'} =
        '';
    $Self->{Translation}->{'Defines regular expressions individually for each ConfigItem class to check the ConfigItem name and to show corresponding error messages.'} =
        'Inafafanua semi za mara kwa mara mojamoja kwa kila tabaka la kipengele ch usanidi kuangalia jina la kipengele cha usanidi na kuonyesha ujumbe wa makosa yanayohusiana.';
    $Self->{Translation}->{'Defines the available columns of CIs in the config item overview depending on the CI class. Each entry must consist of a class name and an array of available fields for the corresponding class. Dynamic field entries have to honor the scheme DynamicField_FieldName.'} =
        '';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of the agent interface.'} =
        '';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of the customer interface.'} =
        '';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of this operation.'} =
        '';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the agent interface. Up: oldest on top. Down: latest on top.'} =
        '';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the customer interface. Up: oldest on top. Down: latest on top.'} =
        '';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the this operation. Up: oldest on top. Down: latest on top.'} =
        '';
    $Self->{Translation}->{'Defines the default displayed columns of CIs in the config item overview depending on the CI class. Each entry must consist of a class name and an array of available fields for the corresponding class. Dynamic field entries have to honor the scheme DynamicField_FieldName.'} =
        '';
    $Self->{Translation}->{'Defines the default relations depth to be shown.'} = '';
    $Self->{Translation}->{'Defines the default shown config item search attribute for config item search screen.'} =
        '';
    $Self->{Translation}->{'Defines the default shown config item search attribute for config item search screen. Example: "Key" must have the name of the Dynamic Field in this case \'X\', "Content" must have the value of the Dynamic Field depending on the Dynamic Field type,  Text: \'a text\', Dropdown: \'1\', Date/Time: \'Search_DynamicField_XTimeSlotStartYear=1974; Search_DynamicField_XTimeSlotStartMonth=01; Search_DynamicField_XTimeSlotStartDay=26; Search_DynamicField_XTimeSlotStartHour=00; Search_DynamicField_XTimeSlotStartMinute=00; Search_DynamicField_XTimeSlotStartSecond=00; Search_DynamicField_XTimeSlotStopYear=2013; Search_DynamicField_XTimeSlotStopMonth=01; Search_DynamicField_XTimeSlotStopDay=26; Search_DynamicField_XTimeSlotStopHour=23; Search_DynamicField_XTimeSlotStopMinute=59; Search_DynamicField_XTimeSlotStopSecond=59;\' and or \'Search_DynamicField_XTimePointFormat=week; Search_DynamicField_XTimePointStart=Before; Search_DynamicField_XTimePointValue=7\';.'} =
        '';
    $Self->{Translation}->{'Defines the default subobject of the class \'ITSMConfigItem\'.'} =
        'Inafafanua kipengele cha chaguo msingi cha tabaka la \'Kipengelecha Usanidi cha ITSM\'.';
    $Self->{Translation}->{'Defines the number of rows for the CI definition editor in the admin interface.'} =
        'Inafafanua namba ya safu mlalo kwa mhariri wa ufafanuzi wa CI katika kiolesura cha kiongozi';
    $Self->{Translation}->{'Defines the order of incident states from high (e.g. cricital) to low (e.g. functional).'} =
        '';
    $Self->{Translation}->{'Defines the relevant deployment states where linked tickets can affect the status of a CI.'} =
        '';
    $Self->{Translation}->{'Defines the search limit for the AgentITSMConfigItem screen.'} =
        'Inawezesha upeo wa kutafuta kwa skerini ya Kipengele cha usanidi cha ITSM cha wakala.';
    $Self->{Translation}->{'Defines the search limit for the AgentITSMConfigItemSearch screen.'} =
        'Inafafanua kikomo cha kutafuta kwa skrini ya Kutafuta Kipengele cha usanidi cha ITSM  cha Wakala.';
    $Self->{Translation}->{'Defines the search limit for the CustomerITSMConfigItem screen.'} =
        '';
    $Self->{Translation}->{'Defines the search limit for the CustomerITSMConfigItemSearch screen.'} =
        '';
    $Self->{Translation}->{'Defines the shown columns of CIs in the link table complex view for all CI classes. If there is no entry, then the default columns are shown.'} =
        '';
    $Self->{Translation}->{'Defines the shown columns of CIs in the link table complex view, depending on the CI class. Each entry must be prefixed with the class name and double colons (i.e. Computer::). There are a few CI-Attributes that common to all CIs (example for the class Computer: Computer::Name, Computer::CurDeplState, Computer::CreateTime). To show individual CI-Attributes as defined in the CI-Definition, the following scheme must be used (example for the class Computer): Computer::HardDisk::1, Computer::HardDisk::1::Capacity::1, Computer::HardDisk::2, Computer::HardDisk::2::Capacity::1. If there is no entry for a CI class, then the default columns are shown.'} =
        'Inafafanua safu wima za CI zilizoonyeshwa katika mandhari ya jedwali tata la kiungo,kutegemeana na tabaka la CI. Kila ingizo lazima liwe na kiambishi awali jina la tabaka na :: ( mfano Tarakilishi::).Kuna viumbi vichache vya CI ambavyo vipo kwa CI zote (mfano kwenye tabaka la tarakilishi: tarakilishi::jina, Tarakilishi::Hali yaCurDep, Tarakilishi::Muda wa kutengeneza). Kuonyesha kiumbi cha CI kimoja kimoja kama vilivyo fafanuliwa kwenye ufafanuzi wa CI, mpangilio ufuatao lazima utumike (mfano kwenye tabaka tarakilishi): Tarakilishi::diski kuu::1, Tarakilishi::Diski kuu ngumu::1Uwezo::1, Tarakilishi::Diski kuu ngumu::2, Tarakilishi::Diski kuu ngumu::2::Uwezo::1. Kama hakuna ingizo kwa tabaka la CI, safuwima chaguo msingi zinaonyeshwa.';
    $Self->{Translation}->{'Defines which items are available for \'Action\' in third level of the ITSM Config Item ACL structure.'} =
        '';
    $Self->{Translation}->{'Defines which items are available in first level of the ITSM Config Item ACL structure.'} =
        '';
    $Self->{Translation}->{'Defines which items are available in second level of the ITSM Config Item ACL structure.'} =
        '';
    $Self->{Translation}->{'Defines which type of link (named from the ticket perspective) can affect the status of a linked CI.'} =
        '';
    $Self->{Translation}->{'Defines which type of ticket can affect the status of a linked CI.'} =
        '';
    $Self->{Translation}->{'Definition Update'} = '';
    $Self->{Translation}->{'Delete Configuration Item'} = '';
    $Self->{Translation}->{'DeplState'} = '';
    $Self->{Translation}->{'Deployment State Color'} = '';
    $Self->{Translation}->{'DeploymentState'} = '';
    $Self->{Translation}->{'Duplicate'} = 'Nakala pacha';
    $Self->{Translation}->{'Dynamic field event module that marks config item definitions as out of sync, if containing dynamic fields change.'} =
        '';
    $Self->{Translation}->{'Dynamic fields shown in the additional ITSM field screen of the agent interface.'} =
        '';
    $Self->{Translation}->{'Dynamic fields shown in the config item overview screen of the customer interface.'} =
        '';
    $Self->{Translation}->{'Dynamic fields shown in the config item search screen of the agent interface.'} =
        '';
    $Self->{Translation}->{'Enables configuration item bulk action feature for the agent frontend to work on more than one configuration item at a time.'} =
        'Inawezesha kipengele cha kitendo ch wingi cha kipengele cha usanidi kwa maingira ya mbele ya wakala kufanya kazi katika kipengele cha usanidi zaidi ya kimoja kwa muda.';
    $Self->{Translation}->{'Enables configuration item bulk action feature only for the listed groups.'} =
        'Inawezesha kipengele cha kitendo cha wingi cha kipengele cha usanidi kwa makundi yaliyoorodheshwa tu.';
    $Self->{Translation}->{'Enables/disables the functionality to check ITSM onfiguration items for unique names. Before enabling this option you should check your system for already existing config items with duplicate names. You can do this with the console command Admin::ITSM::Configitem::ListDuplicates.'} =
        '';
    $Self->{Translation}->{'Event module to set configitem-status on ticket-configitem-link.'} =
        '';
    $Self->{Translation}->{'Fields of the configuration item index, used for the fulltext search. Fields are also stored, but are not mandatory for the overall functionality. Inclusion of attachments can be disabled by setting the entry to 0 or deleting it.'} =
        '';
    $Self->{Translation}->{'Fields stored in the configuration item index which are used for other things besides fulltext searches. For the complete functionality all fields are mandatory.'} =
        '';
    $Self->{Translation}->{'For every webservice (key) an array of classes (value) can be defined on which the import is restricted. For all chosen classes, or all existing classes the identifying attributes will have to be chosen in the invoker config.'} =
        '';
    $Self->{Translation}->{'GenericInterface module registration for the ConfigItemFetch invoker layer.'} =
        '';
    $Self->{Translation}->{'ITSM ConfigItem'} = '';
    $Self->{Translation}->{'ITSM config item overview.'} = '';
    $Self->{Translation}->{'InciState'} = '';
    $Self->{Translation}->{'IncidentState'} = '';
    $Self->{Translation}->{'Includes deployment states in the config item search of the customer interface.'} =
        '';
    $Self->{Translation}->{'Includes incident states in the config item search of the customer interface.'} =
        '';
    $Self->{Translation}->{'Maximum number of config items to be displayed in the result of this operation.'} =
        '';
    $Self->{Translation}->{'Module to check the group responsible for a class.'} = 'Moduli ya kuangalia makundi yanayohusika na tabaka.';
    $Self->{Translation}->{'Module to check the group responsible for a configuration item.'} =
        'Module ya kuangalia makundi yanayohusika na kipengele cha usanidi.';
    $Self->{Translation}->{'Module to generate ITSM config item statistics.'} = 'Moduli ya kutengeneza takwimu za kipengele cha usanidi cha ITSM>';
    $Self->{Translation}->{'Name Module'} = '';
    $Self->{Translation}->{'Number Module'} = '';
    $Self->{Translation}->{'Number of config items to be displayed in each page of a search result in the agent interface.'} =
        '';
    $Self->{Translation}->{'Number of config items to be displayed in each page of a search result in the customer interface.'} =
        '';
    $Self->{Translation}->{'Objects to search for, how many entries and which attributs to show. ConfigItem attributes have to explicitly be stored via Elasticsearch.'} =
        '';
    $Self->{Translation}->{'Overview.'} = 'Mapitio';
    $Self->{Translation}->{'Parameters for the categories for config item classes in the preferences view of the agent interface.'} =
        '';
    $Self->{Translation}->{'Parameters for the column filters of the small config item overview. Please note: setting \'Active\' to 0 will only prevent agents from editing settings of this group in their personal preferences, but will still allow administrators to edit the settings of another user\'s behalf. Use \'PreferenceGroup\' to control in which area these settings should be shown in the user interface.'} =
        '';
    $Self->{Translation}->{'Parameters for the dashboard backend of the customer company config item overview of the agent interface . "Limit" is the number of entries shown by default. "Group" is used to restrict the access to the plugin (e. g. Group: admin;group1;group2;). "Default" determines if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" is the cache time in minutes for the plugin.'} =
        '';
    $Self->{Translation}->{'Parameters for the deployment states color in the preferences view of the agent interface.'} =
        'Vigezo kwa ajili ya rangi ya hali za matumizi kama mandhari ya mapendeleo ya kiolesura cha wakala.';
    $Self->{Translation}->{'Parameters for the deployment states in the preferences view of the agent interface.'} =
        'Vigezo kwa ajili ya hali za matumizi kama mandhari ya mapendeleo ya kiolesura cha wakala.';
    $Self->{Translation}->{'Parameters for the example permission groups of the general catalog attributes.'} =
        'Vigezo kwa mfano ruhusa za vikundi kwa sifa za katalogi za ujumla.';
    $Self->{Translation}->{'Parameters for the name module for config item classes in the preferences view of the agent interface.'} =
        '';
    $Self->{Translation}->{'Parameters for the number module for config item classes in the preferences view of the agent interface.'} =
        '';
    $Self->{Translation}->{'Parameters for the pages (in which the configuration items are shown).'} =
        'Vigezo kwa ajili ya ukurasa (ambavyo vipengele vya usanidi vimeonyeshwa).';
    $Self->{Translation}->{'Parameters for the version string module for config item classes in the preferences view of the agent interface.'} =
        '';
    $Self->{Translation}->{'Parameters for the version string template toolkit module for config item classes in the preferences view of the agent interface.'} =
        '';
    $Self->{Translation}->{'Parameters for the version trigger for config item classes in the preferences view of the agent interface.'} =
        '';
    $Self->{Translation}->{'Performs the configured action for each event (as an Invoker) for each configured Webservice.'} =
        'Fanya kitecndo cha usanidishwaji kwa kila tukio (kama Kichochezi) kwa kila huduma ya wavuti iliyosanidiwa.';
    $Self->{Translation}->{'Permission Group'} = '';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item attachment action in the agent interface.'} =
        '';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item screen in the agent interface.'} =
        'Inahitaji ruhusa kutumia skrini ya kipengele cha usanidi cha ITSM katika kiolesura cha wakala.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item search screen in the agent interface.'} =
        'Inahitaji ruhusa kutumia skrini ya kutafuta kipengele cha usanidi cha ITSM katika kiolesura cha wakala.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item search screen in the customer interface.'} =
        '';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item tree view screen in the agent interface.'} =
        '';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item zoom screen in the agent interface.'} =
        'Inahitaji ruhusa kutumia skrini iliyokuzwa ya kipengele cha usanidi cha ITSM katika kiolesura cha wakala.';
    $Self->{Translation}->{'Required permissions to use the add ITSM configuration item screen in the agent interface.'} =
        'Inahitaji ruhusa kutumia skrini ya kipengele cha usanidi cha ITSM kilichoongeza katika kiolesura cha wakala.';
    $Self->{Translation}->{'Required permissions to use the bulk ITSM configuration item screen in the agent interface.'} =
        '';
    $Self->{Translation}->{'Required permissions to use the edit ITSM configuration item screen in the agent interface.'} =
        'Inahitaji ruhusa kutumia skrini ya kipengele cha usanidi cha ITSM kilichohaririwa katika kiolesura cha wakala.';
    $Self->{Translation}->{'Required permissions to use the history ITSM configuration item screen in the agent interface.'} =
        'Inahitaji ruhusa kutumia skrini ya kipengele cha usanidi cha ITSM cha historia katika kiolesura cha wakala.';
    $Self->{Translation}->{'Required permissions to use the print ITSM configuration item screen in the agent interface.'} =
        'Inahitaji ruhusa kutumia skrini ya kipengele cha usanidi cha ITSM cha kuchapisha katika kiolesura cha wakala.';
    $Self->{Translation}->{'Required privileges to delete config items.'} = '';
    $Self->{Translation}->{'Search config items.'} = '';
    $Self->{Translation}->{'Set the incident state of a CI automatically when a Ticket is Linked to a CI.'} =
        '';
    $Self->{Translation}->{'Sets the deployment state in the configuration item bulk screen of the agent interface.'} =
        'Inaweka hali ya kutumia katika skrini ya wingi wa kipengele cha usanidi ya kiolesura cha wakala.';
    $Self->{Translation}->{'Sets the incident state in the configuration item bulk screen of the agent interface.'} =
        'Inaweka hali ya tukio katika skrini ya kipengele cha usanidi ya kiolesura cha wakala.';
    $Self->{Translation}->{'Shows a link in the menu that allows linking a configuration item with another object in the config item zoom view of the agent interface.'} =
        'Inaonyesha kiongo katika menyu ambacho kinaunganisha kipengele cha usanidi na kipengee kingine katika mandhari iliyokuzwa ya kipengele cha usanidi ya kioleusura cha wakala.';
    $Self->{Translation}->{'Shows a link in the menu to access the history of a configuration item in the configuration item overview of the agent interface.'} =
        'Inaonyesha kiungo kwenye  menyu kuweza kufikia historia ya kipengele cha usanidi katika mapitio ya kipengele ya usanidi ya kiolesura cha wakala.';
    $Self->{Translation}->{'Shows a link in the menu to access the history of a configuration item in the its zoom view of the agent interface.'} =
        'Inaonyesha kiungo kwenye  menyu kuweza kufikia historia ya kipengele cha usanidi katika mandhari yake iliyokuzwa ya kiolesura cha wakala.';
    $Self->{Translation}->{'Shows a link in the menu to delete a configuration item in its zoom view of the agent interface.'} =
        '';
    $Self->{Translation}->{'Shows a link in the menu to display the configuration item links as a Tree View.'} =
        '';
    $Self->{Translation}->{'Shows a link in the menu to duplicate a configuration item in the configuration item overview of the agent interface.'} =
        'Onyesha kiungo katika menyu kutoa nakala pacha ya kipengele cha usanidi katika mapitio ya kipengele cha usanidi ya kiolesura cha wakala.';
    $Self->{Translation}->{'Shows a link in the menu to duplicate a configuration item in the its zoom view of the agent interface.'} =
        'Onyesha kiungo katika menyu kutoa nakala pacha ya kipengele cha usanidi katika mandhari yake ya kipengele cha usanidi cha kiolesura cha wakala.';
    $Self->{Translation}->{'Shows a link in the menu to edit a configuration item in the its zoom view of the agent interface.'} =
        'Onyesha kiungo katika menyu kuhariri  kipengele cha usanidi katika mandhari yake iliyokuzwa ya kiolesura cha wakala.';
    $Self->{Translation}->{'Shows a link in the menu to go back in the configuration item zoom view of the agent interface.'} =
        '';
    $Self->{Translation}->{'Shows a link in the menu to print a configuration item in the its zoom view of the agent interface.'} =
        'Onyesha kiungo katika menyu kuchapisha kipengele cha usanidi katika mandhari yake iliyokuzwa ya kiolesura cha wakala.';
    $Self->{Translation}->{'Shows a link in the menu to zoom into a configuration item in the configuration item overview of the agent interface.'} =
        'Onyesha kiungo katika menyu kukuza katika kipengele cha usanidi katika mapitio ya kipengele cha usanidi ya kiolesura cha wakala.';
    $Self->{Translation}->{'Shows the config item history (reverse ordered) in the agent interface.'} =
        'Inaonyesha historia ya kipengele cha usanidi (kwa mpangilio wa kurudi nyuma) katika kiolesura cha wakala.';
    $Self->{Translation}->{'The default category which is shown, if none is selected.'} = '';
    $Self->{Translation}->{'The identifier for a configuration item, e.g. ConfigItem#, MyConfigItem#. The default is ConfigItem#.'} =
        'Kitambulishi cha kipengele cha usanidi, mfano.ConfigItem#, MyConfigItem#. Chagu-msingi ni ConfigItem#.';
    $Self->{Translation}->{'Triggers ConfigItemFetch invoker automatically.'} = '';
    $Self->{Translation}->{'Version String Expression'} = '';
    $Self->{Translation}->{'Version String Module'} = '';
    $Self->{Translation}->{'Version Trigger'} = '';
    $Self->{Translation}->{'Whether the execution of ConfigItemACL can be avoided by checking cached field dependencies. This can improve loading times of formulars, but has to be disabled, if ACLModules are to be used for ITSMConfigItem- and Form-ReturnTypes.'} =
        '';
    $Self->{Translation}->{'Which general information is shown in the header.'} = '';
    $Self->{Translation}->{'class'} = 'Tabaka';
    $Self->{Translation}->{'global'} = '';
    $Self->{Translation}->{'postproductive'} = '';
    $Self->{Translation}->{'preproductive'} = '';
    $Self->{Translation}->{'productive'} = '';


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

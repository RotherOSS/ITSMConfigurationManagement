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

package Kernel::Language::ms_ITSMConfigurationManagement;

use strict;
use warnings;
use utf8;

sub Data {
    my $Self = shift;

    # Template: AdminGenericInterfaceOperationConfigItem
    $Self->{Translation}->{'General operation data'} = '';
    $Self->{Translation}->{'Settings for incoming request data'} = '';
    $Self->{Translation}->{'Settings for outgoing response data'} = '';

    # Template: AdminITSMConfigItem
    $Self->{Translation}->{'Config Item Management'} = 'Pengurusan Config Item';
    $Self->{Translation}->{'Change class definition'} = 'Ubah definisi kelas';
    $Self->{Translation}->{'Change role definition'} = '';
    $Self->{Translation}->{'Ready2Import Class Bundles'} = '';
    $Self->{Translation}->{'Here you can import Ready2Import class bundles showcasing our most usual config items. Please note that some additional configuration may be required.'} =
        '';
    $Self->{Translation}->{'Update existing entities'} = '';
    $Self->{Translation}->{'Import Ready2Adopt class bundles'} = '';
    $Self->{Translation}->{'Config Item Class'} = '';
    $Self->{Translation}->{'Config Item Role'} = '';

    # Template: AgentITSMConfigItemAdd
    $Self->{Translation}->{'Config Item'} = 'Config Item';
    $Self->{Translation}->{'Filter for Classes'} = 'Menapis Kelas';
    $Self->{Translation}->{'Select a Class from the list to create a new Config Item.'} = 'Pilih Kelas dari senarai untuk mewujudkan Perkara Config baru.';
    $Self->{Translation}->{'Class'} = 'Kelas';

    # Template: AgentITSMConfigItemBulk
    $Self->{Translation}->{'ITSM ConfigItem Bulk Action'} = 'ItemKonfig ITSM Tindakan Pukal';
    $Self->{Translation}->{'Deployment state'} = 'Keadaan pertukaran';
    $Self->{Translation}->{'Incident state'} = 'Keadaan insiden';
    $Self->{Translation}->{'Link to another'} = 'Paut ke lain';
    $Self->{Translation}->{'Invalid Configuration Item number!'} = 'Nombor Barangan Konfigurasi Tidak Sah!';
    $Self->{Translation}->{'The number of another Configuration Item to link with.'} = 'Nombor Barangan Konfigurasi lain untuk dipautkan dengan.';

    # Template: AgentITSMConfigItemDelete
    $Self->{Translation}->{'Do you really want to delete this config item?'} = 'Anda benar ingin membuang item config ini?';

    # Template: AgentITSMConfigItemEdit
    $Self->{Translation}->{'The name of this config item'} = 'Nama config item ini';
    $Self->{Translation}->{'Name is already in use by the ConfigItems with the following Number(s): %s'} =
        'Nama sudah digunakan oleh ConfigItems dengan Nombor(nombor-nombor) berikut: %s';
    $Self->{Translation}->{'Version Number'} = 'Bilangan versi';
    $Self->{Translation}->{'Version number of this config item'} = '';
    $Self->{Translation}->{'Version Number is already in use by the ConfigItems with the following Number(s): %s'} =
        '';
    $Self->{Translation}->{'Deployment State'} = 'Keadaan Pertukaran';
    $Self->{Translation}->{'Incident State'} = 'insiden keadaan';

    # Template: AgentITSMConfigItemHistory
    $Self->{Translation}->{'History of Config Item: %s'} = '';
    $Self->{Translation}->{'History Content'} = 'Kandungan sejarah';
    $Self->{Translation}->{'Createtime'} = 'Cipta masa';
    $Self->{Translation}->{'Zoom view'} = 'Pandangan dibesarkan';

    # Template: AgentITSMConfigItemOverviewNavBar
    $Self->{Translation}->{'Config Items per page'} = 'Item config per halaman';

    # Template: AgentITSMConfigItemOverviewSmall
    $Self->{Translation}->{'No config item data found.'} = '';
    $Self->{Translation}->{'Select this config item'} = '';

    # Template: AgentITSMConfigItemSearch
    $Self->{Translation}->{'Run Search'} = 'Jalankan Carian';
    $Self->{Translation}->{'Also search in previous versions?'} = 'Juga mencari dalam versi sebelumnya?';

    # Template: AgentITSMConfigItemTreeView
    $Self->{Translation}->{'TreeView for ConfigItem'} = '';
    $Self->{Translation}->{'Depth Level'} = '';
    $Self->{Translation}->{'Zoom In/Out'} = '';
    $Self->{Translation}->{'Max links level reached for ConfigItem!'} = '';

    # Template: AgentITSMConfigItemZoom
    $Self->{Translation}->{'Configuration Item'} = 'Perkara konfigurasi';
    $Self->{Translation}->{'Configuration Item Information'} = 'Maklumat Barangan Konfigurasi';
    $Self->{Translation}->{'Current Deployment State'} = 'Pertukaran keadaan semasa';
    $Self->{Translation}->{'Current Incident State'} = 'Insiden keadaan semasa';
    $Self->{Translation}->{'Last changed'} = 'Terkini berubah';
    $Self->{Translation}->{'Last changed by'} = 'Terakhir diubah oleh';

    # Template: CustomerITSMConfigItem
    $Self->{Translation}->{'Your ConfigItems'} = '';

    # Template: CustomerITSMConfigItemSearch
    $Self->{Translation}->{'ConfigItem Search'} = '';

    # Template: AdminACL
    $Self->{Translation}->{'Object Type'} = 'Jenis objek';

    # JS Template: ClassImportConfirm
    $Self->{Translation}->{'The following classes will be imported'} = '';
    $Self->{Translation}->{'The following roles will be imported'} = '';
    $Self->{Translation}->{'Note that also corresponding dynamic fields and GeneralCatalog classes will be created and there is no automatic removal.'} =
        '';
    $Self->{Translation}->{'Do you want to proceed?'} = 'Adakah anda ingin meneruskan?';

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
    $Self->{Translation}->{'ConfigItem'} = 'ConfigItem';
    $Self->{Translation}->{'printed by %s at %s'} = '';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemSearch.pm
    $Self->{Translation}->{'Invalid ClassID!'} = '';
    $Self->{Translation}->{'No ClassID is given!'} = '';
    $Self->{Translation}->{'No access rights for this class given!'} = '';
    $Self->{Translation}->{'No Result!'} = 'Tiada Keputusan!';
    $Self->{Translation}->{'Config Item Search Results'} = 'Hasil carian ConfigItem';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemZoom.pm
    $Self->{Translation}->{'Can\'t show item, no access rights for ConfigItem are given!'} =
        '';
    $Self->{Translation}->{'ConfigItem not found!'} = '';
    $Self->{Translation}->{'No versions found!'} = '';
    $Self->{Translation}->{'operational'} = 'operasi';
    $Self->{Translation}->{'warning'} = 'Amaran';
    $Self->{Translation}->{'incident'} = 'insiden';
    $Self->{Translation}->{'The deployment state of this config item'} = 'Keadaan penempatan item ini config';
    $Self->{Translation}->{'The incident state of this config item'} = 'Keadaan insiden bagi config item ini';

    # Perl Module: Kernel/Modules/CustomerITSMConfigItemSearch.pm
    $Self->{Translation}->{'No permission'} = 'Tiada kebenaran!';
    $Self->{Translation}->{'Filter invalid!'} = '';
    $Self->{Translation}->{'Search params invalid!'} = '';

    # Perl Module: Kernel/Output/HTML/Dashboard/ITSMConfigItemGeneric.pm
    $Self->{Translation}->{'Shown config items'} = '';
    $Self->{Translation}->{'Deployment State Type'} = 'Jenis Pertukaran Keadaan';
    $Self->{Translation}->{'Current Incident State Type'} = 'Nyatakan Jenis Insiden Semasa';

    # Perl Module: Kernel/Output/HTML/ITSMConfigItem/LayoutDate.pm
    $Self->{Translation}->{'Between'} = 'Between';

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
    $Self->{Translation}->{'Maximum number of one element'} = 'Bilangan maksimum satu elemen';
    $Self->{Translation}->{'Empty fields indicate that the current values are kept'} = 'Medan kosong menunjukkan bahawa nilai semasa disimpan';
    $Self->{Translation}->{'Import/Export attachments (as the last entries per line)'} = '';
    $Self->{Translation}->{'Version String'} = '';
    $Self->{Translation}->{'Skipped'} = 'Melangkaui';

    # Perl Module: Kernel/Modules/AdminDynamicField.pm
    $Self->{Translation}->{'Error synchronizing the definitions. Please check the log.'} = '';
    $Self->{Translation}->{'You have ITSMConfigItem definitions which are not synchronized. Please deploy your ITSMConfigItem dynamic field changes.'} =
        '';

    # Database XML / SOPM Definition: ITSMConfigurationManagement.sopm
    $Self->{Translation}->{'Expired'} = 'Tamat Tempoh';
    $Self->{Translation}->{'Maintenance'} = 'penyelenggaraan';
    $Self->{Translation}->{'Pilot'} = 'Pilot';
    $Self->{Translation}->{'Planned'} = 'Dirancang';
    $Self->{Translation}->{'Repair'} = 'Membaiki';
    $Self->{Translation}->{'Retired'} = 'bersara';
    $Self->{Translation}->{'Review'} = 'mengkaji';
    $Self->{Translation}->{'Test/QA'} = 'Ujian/QA';

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
    $Self->{Translation}->{'At a specific time point create a ticket for config items, if the configured requirements are met. The time point is determined by the value of the field configured under "TimeCIKey" of the ConfigItem, and modified by "TimeModifier". If the latter can be either just a number, or a sign (+/-), a number, and an unit (d/h/m): "7" is equivalent to "+7d". The DynamicField "Ticket->DynamicField" will be used to mark created tickets - it has to exist. The flags \<OTOBO_CONFIGITEM_X\> where X can be NAME, NUMBER and DATE, will be substituted with the respective values in "Ticket->Text".'} =
        '';
    $Self->{Translation}->{'CIs assigned to customer company'} = '';
    $Self->{Translation}->{'CIs assigned to customer user'} = '';
    $Self->{Translation}->{'CMDB Settings'} = '';
    $Self->{Translation}->{'Check for a unique name only within the same ConfigItem class (\'class\') or globally (\'global\'), which means every existing ConfigItem is taken into account when looking for duplicates.'} =
        'Semak nama yang unik sahaja di dalam kelas ConfigItem yang sama (\'kelas\') atau di peringkat global (\'global\'), yang bermaksud setiap ConfigItem sedia ada diambil kira ketika mencari pendua.';
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
    $Self->{Translation}->{'Config Items'} = 'Barangan Konfigurasi';
    $Self->{Translation}->{'Config item add.'} = 'Tambah item config.';
    $Self->{Translation}->{'Config item edit.'} = 'Edit item config.';
    $Self->{Translation}->{'Config item event module that count the licenses for OTOBOCILicenseCount feature.'} =
        '';
    $Self->{Translation}->{'Config item event module that enables logging to history in the agent interface.'} =
        'Modul acara barangan konfigurasi yang membenarkan untuk log ke sejarah dalam antara muka agen.';
    $Self->{Translation}->{'Config item event module that updates config items to their current definition.'} =
        '';
    $Self->{Translation}->{'Config item event module that updates the table configitem_ĺink.'} =
        '';
    $Self->{Translation}->{'Config item event module updates the current incident state.'} =
        '';
    $Self->{Translation}->{'Config item history.'} = 'Sejarah item config.';
    $Self->{Translation}->{'Config item print.'} = 'Cetak item config.';
    $Self->{Translation}->{'Config item zoom.'} = 'Zum item config.';
    $Self->{Translation}->{'ConfigItem Tree View'} = '';
    $Self->{Translation}->{'ConfigItem Version'} = '';
    $Self->{Translation}->{'ConfigItems of the following classes will not be stored on the Elasticsearch server. To apply this to existing CIs, the CI migration has to be run via console, after changing this option.'} =
        '';
    $Self->{Translation}->{'ConfigItems with the following deployment states will not be stored on the Elasticsearch server. To apply this to existing CIs, the CI migration has to be run via console, after changing this option.'} =
        '';
    $Self->{Translation}->{'Configuration Item Limit'} = 'Had Barangan Konfigurasi';
    $Self->{Translation}->{'Configuration Item limit per page.'} = '';
    $Self->{Translation}->{'Configuration Management Database.'} = 'Konfigurasi Pengurusan Pangkalan Data.';
    $Self->{Translation}->{'Configuration item bulk module.'} = 'Konfigurasi item modul pukal.';
    $Self->{Translation}->{'Configuration item search backend router of the agent interface.'} =
        ' Router carian belakang barangan konfigurasi antara muka ejen.';
    $Self->{Translation}->{'Create and manage the definitions for Configuration Items.'} = 'Cipta dan urus takrifan untuk Barangan Konfigurasi.';
    $Self->{Translation}->{'Creates Tickets for ConfigItems at specific time points.'} = '';
    $Self->{Translation}->{'Customers can see historic CI versions.'} = '';
    $Self->{Translation}->{'Customers have the possibility to manually switch between historic CI versions.'} =
        '';
    $Self->{Translation}->{'Default data to use on attribute for config item search screen. Example: "ITSMConfigItemCreateTimePointFormat=year;ITSMConfigItemCreateTimePointStart=Last;ITSMConfigItemCreateTimePoint=2;".'} =
        '';
    $Self->{Translation}->{'Default data to use on attribute for config item search screen. Example: "ITSMConfigItemCreateTimeStartYear=2010;ITSMConfigItemCreateTimeStartMonth=10;ITSMConfigItemCreateTimeStartDay=4;ITSMConfigItemCreateTimeStopYear=2010;ITSMConfigItemCreateTimeStopMonth=11;ITSMConfigItemCreateTimeStopDay=3;".'} =
        '';
    $Self->{Translation}->{'Define Actions where a settings button is available in the linked objects widget (LinkObject::ViewMode = "complex"). Please note that these Actions must have registered the following JS and CSS files: Core.AllocationList.css, Core.UI.AllocationList.js, Core.UI.Table.Sort.js, Core.Agent.TableFilters.js and Core.Agent.LinkObject.js.'} =
        'Takrifkan Tindakan dimana butang tetapan itu ada dalam widget objek bersambung (LinkObject::ViewMode = "complex"). Sila pastikan yang Tindakan ini perlu didaftarkan yang berikut fail-fail JS dan CSS: Core.AllocationList.css, Core.UI.AllocationList.js, Core.UI.Table.Sort.js, Core.Agent.TableFilters.js and Core.Agent.LinkObject.js.';
    $Self->{Translation}->{'Define a Template::Toolkit scheme for version strings. Only used if Version String Module is set to TemplateToolkit.'} =
        '';
    $Self->{Translation}->{'Define a set of conditions under which a customer is allowed to see a config item. Conditions can optionally be restricted to certain customer groups. Name is the only mandatory attribute. If no other options are given, all config items will be visible under that category.'} =
        '';
    $Self->{Translation}->{'Defines Required permissions to delete ITSM configuration items using the Generic Interface.'} =
        'Takrifkan keizinan yang diperlukan untuk membuang item konfigurasi ITSM menggunakan Antaramuka Umum.';
    $Self->{Translation}->{'Defines Required permissions to get ITSM configuration items using the Generic Interface.'} =
        'Mentakrifkan kebenaran yang diperlukan untuk mendapatkan barangan konfigurasi ITSM menggunakan Antara Muka Generik.';
    $Self->{Translation}->{'Defines Required permissions to search ITSM configuration items using the Generic Interface.'} =
        'Mentakrifkan kebenaran yang diperlukan untuk mencari barangan konfigurasi ITSM menggunakan Antara Muka Generik.';
    $Self->{Translation}->{'Defines Required permissions to set ITSM configuration items using the Generic Interface.'} =
        '';
    $Self->{Translation}->{'Defines an overview module to show the small view of a configuration item list.'} =
        'Mentakrifkan modul gambaran untuk menunjukkan pandangan yang kecil senarai item konfigurasi.';
    $Self->{Translation}->{'Defines if the link type labels must be shown in the node connections.'} =
        '';
    $Self->{Translation}->{'Defines regular expressions individually for each ConfigItem class to check the ConfigItem name and to show corresponding error messages.'} =
        'Mentakrifkan ungkapan biasa secara individu untuk setiap kelas ItemKonfig untuk memeriksa nama ItemKonfig dan untuk menunjukkan mesej ralat sepadan.';
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
        'Definiert das Standard-Subobject der Klasse';
    $Self->{Translation}->{'Defines the height for the rich text editor component for this screen. Enter number (pixels) or percent value (relative).'} =
        'Mentakrifkan tinggi untuk komponen editor teks kaya untuk skrin ini. Masukkan nombor (piksel) atau nilai peratus (relatif).';
    $Self->{Translation}->{'Defines the number of rows for the CI definition editor in the admin interface.'} =
        'Menentukan bilangan baris untuk editor definisi CI dalam antara muka admin.';
    $Self->{Translation}->{'Defines the order of incident states from high (e.g. cricital) to low (e.g. functional).'} =
        'Takrifkan susunan keadaan insiden daripada tinggi (cth. kritikal) ke rendah (cth. fungsian).';
    $Self->{Translation}->{'Defines the relevant deployment states where linked tickets can affect the status of a CI.'} =
        'Takrifkan keadaan penempatan yang releven dimana tiket bersambung boleh menjejaskan status bagi CI.';
    $Self->{Translation}->{'Defines the search limit for the AgentITSMConfigItem screen.'} =
        'Mentakrifkan had carian untuk skrin ItemKonfigITSMAgen.';
    $Self->{Translation}->{'Defines the search limit for the AgentITSMConfigItemSearch screen.'} =
        'Mentakrifkan had carian untuk skrin CarianItemKonfigITSMAgen.';
    $Self->{Translation}->{'Defines the search limit for the CustomerITSMConfigItem screen.'} =
        '';
    $Self->{Translation}->{'Defines the search limit for the CustomerITSMConfigItemSearch screen.'} =
        '';
    $Self->{Translation}->{'Defines the shown columns of CIs in the link table complex view for all CI classes. If there is no entry, then the default columns are shown.'} =
        '';
    $Self->{Translation}->{'Defines the shown columns of CIs in the link table complex view, depending on the CI class. Each entry must be prefixed with the class name and double colons (i.e. Computer::). There are a few CI-Attributes that common to all CIs (example for the class Computer: Computer::Name, Computer::CurDeplState, Computer::CreateTime). To show individual CI-Attributes as defined in the CI-Definition, the following scheme must be used (example for the class Computer): Computer::HardDisk::1, Computer::HardDisk::1::Capacity::1, Computer::HardDisk::2, Computer::HardDisk::2::Capacity::1. If there is no entry for a CI class, then the default columns are shown.'} =
        'Mentakrifkan ruangan ditunjukkan CIs dalam pandangan pautan jadual kompleks, bergantung kepada kelas CI . Setiap penyertaan hendaklah dimulakan dengan nama kelas dan titik bertindih dua (iaitu Komputer::). Terdapat beberapa Sifat-sifat-CI yang sama kepada semua CIs (contoh untuk kelas Komputer:Komputer::Nama, Komputer::CurDeplState, Komputer::CreateTime). Untuk menunjukkan sifat individu CI sebagaimana yang ditakrifkan dalam Definisi-CI, skim berikut mesti digunakan (contoh untuk kelas Komputer): Komputer::harddisk::1, Komputer::harddisk::1::Kapasiti::1, komputer::harddisk::2, Komputer::harddisk::2::Kapasiti::1. Jika tiada penyertaan untuk kelas CI, maka ruangan default dipaparkan.';
    $Self->{Translation}->{'Defines which items are available for \'Action\' in third level of the ITSM Config Item ACL structure.'} =
        '';
    $Self->{Translation}->{'Defines which items are available in first level of the ITSM Config Item ACL structure.'} =
        '';
    $Self->{Translation}->{'Defines which items are available in second level of the ITSM Config Item ACL structure.'} =
        '';
    $Self->{Translation}->{'Defines which type of link (named from the ticket perspective) can affect the status of a linked CI.'} =
        'Takrifkan jenis sambungan yang mana (dinamakan daripada perspektif tiket) boleh menjejaskan status bagi satu sambungan CI.';
    $Self->{Translation}->{'Defines which type of ticket can affect the status of a linked CI.'} =
        'Takrifkan jenis tiket yang mana boleh menjejaskan status bagi satu sambungan CI.';
    $Self->{Translation}->{'Definition Update'} = '';
    $Self->{Translation}->{'Delete Configuration Item'} = '';
    $Self->{Translation}->{'DeplState'} = '';
    $Self->{Translation}->{'Deployment State Color'} = 'Penempatan Keadaan Warna.';
    $Self->{Translation}->{'DeploymentState'} = '';
    $Self->{Translation}->{'Duplicate'} = 'Gandakan';
    $Self->{Translation}->{'Dynamic field event module that marks config item definitions as out of sync, if containing dynamic fields change.'} =
        '';
    $Self->{Translation}->{'Dynamic fields shown in the additional ITSM field screen of the agent interface.'} =
        '';
    $Self->{Translation}->{'Dynamic fields shown in the config item overview screen of the customer interface.'} =
        '';
    $Self->{Translation}->{'Dynamic fields shown in the config item search screen of the agent interface.'} =
        '';
    $Self->{Translation}->{'Enables configuration item bulk action feature for the agent frontend to work on more than one configuration item at a time.'} =
        'Membolehkan ciri tindakan pukal item konfigurasi untuk frontend ejen untuk bekerja pada lebih daripada satu item konfigurasi pada satu masa.';
    $Self->{Translation}->{'Enables configuration item bulk action feature only for the listed groups.'} =
        'Membolehkan ciri item konfigurasi tindakan pukal hanya untuk kumpulan yang disenaraikan.';
    $Self->{Translation}->{'Enables/disables the functionality to check ITSM onfiguration items for unique names. Before enabling this option you should check your system for already existing config items with duplicate names. You can do this with the console command Admin::ITSM::ConfigItem::ListDuplicates.'} =
        '';
    $Self->{Translation}->{'Event module to set configitem-status on ticket-configitem-link.'} =
        'Model acara untuk menyediakan status-itemconfig atas sambungan-itemconfig-tiket.';
    $Self->{Translation}->{'Fields of the configuration item index, used for the fulltext search. Fields are also stored, but are not mandatory for the overall functionality. Inclusion of attachments can be disabled by setting the entry to 0 or deleting it.'} =
        '';
    $Self->{Translation}->{'Fields stored in the configuration item index which are used for other things besides fulltext searches. For the complete functionality all fields are mandatory.'} =
        '';
    $Self->{Translation}->{'For every webservice (key) an array of classes (value) can be defined on which the import is restricted. For all chosen classes, or all existing classes the identifying attributes will have to be chosen in the invoker config.'} =
        '';
    $Self->{Translation}->{'GenericInterface module registration for the ConfigItemFetch invoker layer.'} =
        '';
    $Self->{Translation}->{'ITSM ConfigItem'} = '';
    $Self->{Translation}->{'ITSM config item overview.'} = 'pandangan item config ITSM.';
    $Self->{Translation}->{'If this option is activated, linked items are only counted if they belong to one of the listed classes.'} =
        '';
    $Self->{Translation}->{'InciState'} = '';
    $Self->{Translation}->{'IncidentState'} = '';
    $Self->{Translation}->{'Includes deployment states in the config item search of the customer interface.'} =
        '';
    $Self->{Translation}->{'Includes incident states in the config item search of the customer interface.'} =
        '';
    $Self->{Translation}->{'Maximum number of config items to be displayed in the result of this operation.'} =
        '';
    $Self->{Translation}->{'Module to check the group responsible for a class.'} = 'Modul untuk menyemak kumpulan bertanggungjawab untuk kelas.';
    $Self->{Translation}->{'Module to check the group responsible for a configuration item.'} =
        'Modul untuk menyemak kumpulan bertanggungjawab untuk item konfigurasi.';
    $Self->{Translation}->{'Module to generate ITSM config item statistics.'} = 'Modul untuk menjana statistik konfig item ITSM.';
    $Self->{Translation}->{'Name Module'} = '';
    $Self->{Translation}->{'Number Module'} = '';
    $Self->{Translation}->{'Number of config items to be displayed in each page of a search result in the agent interface.'} =
        '';
    $Self->{Translation}->{'Number of config items to be displayed in each page of a search result in the customer interface.'} =
        '';
    $Self->{Translation}->{'Objects to search for, how many entries and which attributs to show. ConfigItem attributes have to explicitly be stored via Elasticsearch.'} =
        '';
    $Self->{Translation}->{'Overview.'} = 'Pandangan keseluruhan.';
    $Self->{Translation}->{'Parameters for the categories for config item classes in the preferences view of the agent interface.'} =
        '';
    $Self->{Translation}->{'Parameters for the column filters of the small config item overview. Please note: setting \'Active\' to 0 will only prevent agents from editing settings of this group in their personal preferences, but will still allow administrators to edit the settings of another user\'s behalf. Use \'PreferenceGroup\' to control in which area these settings should be shown in the user interface.'} =
        '';
    $Self->{Translation}->{'Parameters for the dashboard backend of the customer company config item overview of the agent interface . "Limit" is the number of entries shown by default. "Group" is used to restrict the access to the plugin (e. g. Group: admin;group1;group2;). "Default" determines if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" is the cache time in minutes for the plugin.'} =
        '';
    $Self->{Translation}->{'Parameters for the deployment states color in the preferences view of the agent interface.'} =
        'Parameter untuk warna keadaan mengatur kedudukan dalam paparan pilihan dari paparan ejen.';
    $Self->{Translation}->{'Parameters for the deployment states in the preferences view of the agent interface.'} =
        'Parameter untuk keadaan mengatur kedudukan dalam paparan pilihan dari paparan ejen.';
    $Self->{Translation}->{'Parameters for the example permission groups of the general catalog attributes.'} =
        'Parameter untuk contoh kumpulan yang dibenarkan pada ciri-ciri katalog.';
    $Self->{Translation}->{'Parameters for the name module for config item classes in the preferences view of the agent interface.'} =
        '';
    $Self->{Translation}->{'Parameters for the number module for config item classes in the preferences view of the agent interface.'} =
        '';
    $Self->{Translation}->{'Parameters for the pages (in which the configuration items are shown).'} =
        'Parameter untuk muka surat (di mana item konfigurasi ditunjukkan).';
    $Self->{Translation}->{'Parameters for the version string module for config item classes in the preferences view of the agent interface.'} =
        '';
    $Self->{Translation}->{'Parameters for the version string template toolkit module for config item classes in the preferences view of the agent interface.'} =
        '';
    $Self->{Translation}->{'Parameters for the version trigger for config item classes in the preferences view of the agent interface.'} =
        '';
    $Self->{Translation}->{'Performs the configured action for each event (as an Invoker) for each configured Webservice.'} =
        'Melakukan tindakan yang telah dikonfigurasi untuk setiap acara (sebagai pencetus) untuk setiap Webservice yang telah dikonfigurasi.';
    $Self->{Translation}->{'Permission Group'} = '';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item attachment action in the agent interface.'} =
        '';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item screen in the agent interface.'} =
        'Memerlukan kebenaran untuk menggunakan skrin item konfigurasi ITSM dalam paparan ejen.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item search screen in the agent interface.'} =
        'Memerlukan kebenaran untuk menggunakan skrin carian item konfigurasi ITSM dalam paparan ejen.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item search screen in the customer interface.'} =
        '';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item tree view screen in the agent interface.'} =
        '';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item zoom screen in the agent interface.'} =
        'Memerlukan kebenaran untuk menggunakan skrin zum item konfigurasi ITSM dalam paparan ejen.';
    $Self->{Translation}->{'Required permissions to use the add ITSM configuration item screen in the agent interface.'} =
        'Memerlukan kebenaran untuk menggunakan skrin tambah item konfigurasi ITSM dalam paparan ejen.';
    $Self->{Translation}->{'Required permissions to use the bulk ITSM configuration item screen in the agent interface.'} =
        '';
    $Self->{Translation}->{'Required permissions to use the edit ITSM configuration item screen in the agent interface.'} =
        'Memerlukan kebenaran untuk menggunakan skrin edit item konfigurasi ITSM dalam paparan ejen.';
    $Self->{Translation}->{'Required permissions to use the history ITSM configuration item screen in the agent interface.'} =
        'Memerlukan kebenaran untuk menggunakan skrin sejarah item konfigurasi ITSM dalam paparan ejen.';
    $Self->{Translation}->{'Required permissions to use the print ITSM configuration item screen in the agent interface.'} =
        'Memerlukan kebenaran untuk menggunakan skrin cetak item konfigurasi ITSM dalam paparan ejen.';
    $Self->{Translation}->{'Required privileges to delete config items.'} = 'Keistimewaan-keistimewaan dikehendaki untuk memadamkan barang-barang config.';
    $Self->{Translation}->{'Search config items.'} = 'Cari barang-barang config.';
    $Self->{Translation}->{'Set the incident state of a CI automatically when a Ticket is Linked to a CI.'} =
        'Menentukan keadaan insiden bagi CI secara automatik apabila suatu Tiket disambungkan kepada suatu CI.';
    $Self->{Translation}->{'Sets the deployment state in the configuration item bulk screen of the agent interface.'} =
        'Set keadaan penempatan dalam skrin pukal item konfigurasi antara muka ejen.';
    $Self->{Translation}->{'Sets the incident state in the configuration item bulk screen of the agent interface.'} =
        'Set keadaan insiden dalam skrin pukal item konfigurasi antara muka ejen.';
    $Self->{Translation}->{'Shows a link in the menu that allows linking a configuration item with another object in the config item zoom view of the agent interface.'} =
        'Menunjukkan pautan dalam menu yang membolehkan menghubungkan item konfigurasi dengan objek lain dalam pandangan zum item konfig bagi antara muka ejen.';
    $Self->{Translation}->{'Shows a link in the menu to access the history of a configuration item in the configuration item overview of the agent interface.'} =
        'Tunjuk pautan dalam menu untuk mengakses sejarah item konfigurasi di dalam gambaran keseluruhan item konfigurasi antara muka agen.';
    $Self->{Translation}->{'Shows a link in the menu to access the history of a configuration item in the its zoom view of the agent interface.'} =
        'Menunjukkan pautan dalam menu untuk mengakses sejarah item konfigurasi dalam pandangan zum antara muka ejen.';
    $Self->{Translation}->{'Shows a link in the menu to delete a configuration item in its zoom view of the agent interface.'} =
        'Menunjukkan satu sambungan kepada menu untuk memadam satu barang konfigurasi  dalam pandangan zumnya daripada antaramuka ejen.';
    $Self->{Translation}->{'Shows a link in the menu to display the configuration item links as a Tree View.'} =
        '';
    $Self->{Translation}->{'Shows a link in the menu to duplicate a configuration item in the configuration item overview of the agent interface.'} =
        'Tunjuk pautan dalam menu untuk menyalin item konfigurasi di dalam gambaran keseluruhan item konfigurasi antara muka agen.';
    $Self->{Translation}->{'Shows a link in the menu to duplicate a configuration item in the its zoom view of the agent interface.'} =
        'Menunjukkan pautan dalam menu untuk menyalin barangan konfigurasi dalam pandangan zum antara muka ejen.';
    $Self->{Translation}->{'Shows a link in the menu to edit a configuration item in the its zoom view of the agent interface.'} =
        'Menunjukkan pautan dalam menu untuk edit barangan konfigurasi dalam pandangan zum antara muka ejen.';
    $Self->{Translation}->{'Shows a link in the menu to go back in the configuration item zoom view of the agent interface.'} =
        'menunjukkan suatu sambungan pada menu untuk kembali dalam zoom item konfigurasi daripada antara muka agen';
    $Self->{Translation}->{'Shows a link in the menu to print a configuration item in the its zoom view of the agent interface.'} =
        'Menunjukkan pautan dalam menu untuk mencetak barangan konfigurasi dalam pandangan zum antara muka ejen.';
    $Self->{Translation}->{'Shows a link in the menu to zoom into a configuration item in the configuration item overview of the agent interface.'} =
        'Tunjuk pautan dalam menu untuk zum ke dalam barangan konfigurasi di dalam gambaran keseluruhan barangan konfigurasi antara muka agen.';
    $Self->{Translation}->{'Shows the config item history (reverse ordered) in the agent interface.'} =
        'Tunjuk sejarah barangan konfig (urutan terbalik) dalam antara muka agen.';
    $Self->{Translation}->{'The default category which is shown, if none is selected.'} = '';
    $Self->{Translation}->{'The identifier for a configuration item, e.g. ConfigItem#, MyConfigItem#. The default is ConfigItem#.'} =
        'Pengecam untuk item konfigurasi, contoh: ConfigItem#, MyConfigItem#. Default ialah ConfigItem#.';
    $Self->{Translation}->{'Triggers ConfigItemFetch invoker automatically.'} = '';
    $Self->{Translation}->{'Version String Expression'} = '';
    $Self->{Translation}->{'Version String Module'} = '';
    $Self->{Translation}->{'Version Trigger'} = '';
    $Self->{Translation}->{'Whether the execution of ConfigItemACL can be avoided by checking cached field dependencies. This can improve loading times of formulars, but has to be disabled, if ACLModules are to be used for ITSMConfigItem- and Form-ReturnTypes.'} =
        '';
    $Self->{Translation}->{'Which general information is shown in the header.'} = '';
    $Self->{Translation}->{'With this option it´s possible to fill automaticly a CI field, depending on the count of linked CI´s with the existing type DependsOn.'} =
        '';
    $Self->{Translation}->{'With this option it´s possible to fill automaticly a CI field, depending on the count of linked CI´s.'} =
        '';
    $Self->{Translation}->{'With this option it´s possible to fill automaticly a CI field, depending on the count of linked CI´s. The setting CounterClassName include the name of the class and CounterFieldName is used to store the count of used licence.'} =
        '';
    $Self->{Translation}->{'class'} = 'kelas';
    $Self->{Translation}->{'global'} = 'global';
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

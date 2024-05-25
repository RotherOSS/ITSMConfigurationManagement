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

package Kernel::Language::sr_Latn_ITSMConfigurationManagement;

use strict;
use warnings;
use utf8;

sub Data {
    my $Self = shift;

    # Template: AdminITSMConfigItem
    $Self->{Translation}->{'Config Item Management'} = '';
    $Self->{Translation}->{'Change class definition'} = '';
    $Self->{Translation}->{'Config Item Class'} = '';
    $Self->{Translation}->{'Definition'} = '';
    $Self->{Translation}->{'Change'} = '';

    # Template: AgentDashboardITSMConfigItemGeneric
    $Self->{Translation}->{'Incident State'} = '';
    $Self->{Translation}->{'Deployment State'} = '';
    $Self->{Translation}->{'Class'} = '';
    $Self->{Translation}->{'Deployment State Type'} = '';
    $Self->{Translation}->{'Current Incident State'} = '';
    $Self->{Translation}->{'Current Incident State Type'} = '';
    $Self->{Translation}->{'Last changed'} = '';

    # Template: AgentITSMConfigItemAdd
    $Self->{Translation}->{'Config Item'} = '';
    $Self->{Translation}->{'Filter for Classes'} = '';
    $Self->{Translation}->{'Select a Class from the list to create a new Config Item.'} = '';

    # Template: AgentITSMConfigItemBulk
    $Self->{Translation}->{'ITSM ConfigItem Bulk Action'} = '';
    $Self->{Translation}->{'Deployment state'} = '';
    $Self->{Translation}->{'Incident state'} = '';
    $Self->{Translation}->{'Link to another'} = '';
    $Self->{Translation}->{'Invalid Configuration Item number!'} = '';
    $Self->{Translation}->{'The number of another Configuration Item to link with.'} = '';

    # Template: AgentITSMConfigItemDelete
    $Self->{Translation}->{'Do you really want to delete this config item?'} = '';

    # Template: AgentITSMConfigItemEdit
    $Self->{Translation}->{'The name of this config item'} = '';
    $Self->{Translation}->{'Name is already in use by the ConfigItems with the following Number(s): %s'} =
        '';

    # Template: AgentITSMConfigItemHistory
    $Self->{Translation}->{'History of Config Item: %s'} = '';
    $Self->{Translation}->{'History Content'} = '';
    $Self->{Translation}->{'Createtime'} = '';
    $Self->{Translation}->{'Zoom view'} = '';

    # Template: AgentITSMConfigItemOverviewNavBar
    $Self->{Translation}->{'Context Settings'} = '';
    $Self->{Translation}->{'Config Items per page'} = '';

    # Template: AgentITSMConfigItemOverviewSmall
    $Self->{Translation}->{'A generic ITSM Configuration Item table'} = '';

    # Template: AgentITSMConfigItemSearch
    $Self->{Translation}->{'Run Search'} = '';
    $Self->{Translation}->{'Also search in previous versions?'} = '';

    # Template: AgentITSMConfigItemZoom
    $Self->{Translation}->{'Configuration Item'} = '';
    $Self->{Translation}->{'Configuration Item Information'} = '';
    $Self->{Translation}->{'Current Deployment State'} = '';
    $Self->{Translation}->{'Last changed by'} = '';
    $Self->{Translation}->{'Show one version'} = '';
    $Self->{Translation}->{'Show all versions'} = '';
    $Self->{Translation}->{'Version Incident State'} = '';
    $Self->{Translation}->{'Version Deployment State'} = '';
    $Self->{Translation}->{'Version Number'} = '';
    $Self->{Translation}->{'Configuration Item Version Details'} = '';
    $Self->{Translation}->{'Property'} = '';

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
    $Self->{Translation}->{'ConfigItem'} = '';
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
    $Self->{Translation}->{'operational'} = '';
    $Self->{Translation}->{'warning'} = '';
    $Self->{Translation}->{'incident'} = '';
    $Self->{Translation}->{'The deployment state of this config item'} = '';
    $Self->{Translation}->{'The incident state of this config item'} = '';

    # Perl Module: Kernel/Output/HTML/Dashboard/ITSMConfigItemGeneric.pm
    $Self->{Translation}->{'Shown config items'} = '';

    # Perl Module: Kernel/Output/HTML/ITSMConfigItem/LayoutDate.pm
    $Self->{Translation}->{'Between'} = '';

    # Perl Module: Kernel/System/ImportExport/ObjectBackend/ITSMConfigItem.pm
    $Self->{Translation}->{'Maximum number of one element'} = '';
    $Self->{Translation}->{'Empty fields indicate that the current values are kept'} = '';
    $Self->{Translation}->{'Skipped'} = '';

    # Perl Module: var/packagesetup/ITSMConfigurationManagement.pm
    $Self->{Translation}->{'Model'} = '';
    $Self->{Translation}->{'Customer Company'} = '';
    $Self->{Translation}->{'Serial Number'} = '';
    $Self->{Translation}->{'CPU'} = '';
    $Self->{Translation}->{'Ram'} = '';
    $Self->{Translation}->{'Hard Disk'} = '';
    $Self->{Translation}->{'Capacity'} = '';
    $Self->{Translation}->{'Network Adapter'} = '';
    $Self->{Translation}->{'IP over DHCP'} = '';
    $Self->{Translation}->{'IP Address'} = '';
    $Self->{Translation}->{'Graphic Adapter'} = '';
    $Self->{Translation}->{'Other Equipment'} = '';
    $Self->{Translation}->{'Warranty Expiration Date'} = '';
    $Self->{Translation}->{'Install Date'} = '';
    $Self->{Translation}->{'Phone 1'} = '';
    $Self->{Translation}->{'Phone 2'} = '';
    $Self->{Translation}->{'E-Mail'} = '';
    $Self->{Translation}->{'Network Address'} = '';
    $Self->{Translation}->{'Subnet Mask'} = '';
    $Self->{Translation}->{'Gateway'} = '';
    $Self->{Translation}->{'Licence Type'} = '';
    $Self->{Translation}->{'Licence Key'} = '';
    $Self->{Translation}->{'Quantity'} = '';
    $Self->{Translation}->{'Expiration Date'} = '';
    $Self->{Translation}->{'Media'} = '';

    # Database XML / SOPM Definition: ITSMConfigurationManagement.sopm
    $Self->{Translation}->{'Computer'} = '';
    $Self->{Translation}->{'Hardware'} = '';
    $Self->{Translation}->{'Network'} = '';
    $Self->{Translation}->{'Software'} = '';
    $Self->{Translation}->{'Expired'} = '';
    $Self->{Translation}->{'Maintenance'} = '';
    $Self->{Translation}->{'Pilot'} = '';
    $Self->{Translation}->{'Planned'} = '';
    $Self->{Translation}->{'Repair'} = '';
    $Self->{Translation}->{'Retired'} = '';
    $Self->{Translation}->{'Review'} = '';
    $Self->{Translation}->{'Test/QA'} = '';
    $Self->{Translation}->{'Laptop'} = '';
    $Self->{Translation}->{'Desktop'} = '';
    $Self->{Translation}->{'PDA'} = '';
    $Self->{Translation}->{'Other'} = '';
    $Self->{Translation}->{'Monitor'} = '';
    $Self->{Translation}->{'Printer'} = '';
    $Self->{Translation}->{'Switch'} = '';
    $Self->{Translation}->{'Router'} = '';
    $Self->{Translation}->{'WLAN Access Point'} = '';
    $Self->{Translation}->{'Security Device'} = '';
    $Self->{Translation}->{'Backup Device'} = '';
    $Self->{Translation}->{'Mouse'} = '';
    $Self->{Translation}->{'Keyboard'} = '';
    $Self->{Translation}->{'Camera'} = '';
    $Self->{Translation}->{'Beamer'} = '';
    $Self->{Translation}->{'Modem'} = '';
    $Self->{Translation}->{'PCMCIA Card'} = '';
    $Self->{Translation}->{'USB Device'} = '';
    $Self->{Translation}->{'Docking Station'} = '';
    $Self->{Translation}->{'Scanner'} = '';
    $Self->{Translation}->{'Building'} = '';
    $Self->{Translation}->{'Office'} = '';
    $Self->{Translation}->{'Floor'} = '';
    $Self->{Translation}->{'Room'} = '';
    $Self->{Translation}->{'Rack'} = '';
    $Self->{Translation}->{'Workplace'} = '';
    $Self->{Translation}->{'Outlet'} = '';
    $Self->{Translation}->{'IT Facility'} = '';
    $Self->{Translation}->{'LAN'} = '';
    $Self->{Translation}->{'WLAN'} = '';
    $Self->{Translation}->{'Telco'} = '';
    $Self->{Translation}->{'GSM'} = '';
    $Self->{Translation}->{'Client Application'} = '';
    $Self->{Translation}->{'Middleware'} = '';
    $Self->{Translation}->{'Server Application'} = '';
    $Self->{Translation}->{'Client OS'} = '';
    $Self->{Translation}->{'Server OS'} = '';
    $Self->{Translation}->{'Admin Tool'} = '';
    $Self->{Translation}->{'User Tool'} = '';
    $Self->{Translation}->{'Embedded'} = '';
    $Self->{Translation}->{'Single Licence'} = '';
    $Self->{Translation}->{'Per User'} = '';
    $Self->{Translation}->{'Per Processor'} = '';
    $Self->{Translation}->{'Per Server'} = '';
    $Self->{Translation}->{'Per Node'} = '';
    $Self->{Translation}->{'Volume Licence'} = '';
    $Self->{Translation}->{'Enterprise Licence'} = '';
    $Self->{Translation}->{'Developer Licence'} = '';
    $Self->{Translation}->{'Demo'} = '';
    $Self->{Translation}->{'Time Restricted'} = '';
    $Self->{Translation}->{'Freeware'} = '';
    $Self->{Translation}->{'Open Source'} = '';
    $Self->{Translation}->{'Unlimited'} = '';

    # JS File: ITSM.Agent.ConfigItem.Zoom
    $Self->{Translation}->{'Ok'} = '';

    # SysConfig
    $Self->{Translation}->{'Assigned CIs'} = 'Dodeljene konfiguracione stavke';
    $Self->{Translation}->{'CIs assigned to customer company'} = 'Konfiguracione stavke dodeljene firmi klijenta';
    $Self->{Translation}->{'CIs assigned to customer user'} = 'Konfiguracione stavke dodeljene klijentu korisniku';
    $Self->{Translation}->{'CMDB Settings'} = 'CMDB podešavanja';
    $Self->{Translation}->{'Check for a unique name only within the same ConfigItem class (\'class\') or globally (\'global\'), which means every existing ConfigItem is taken into account when looking for duplicates.'} =
        'Provera jedinstvenog imena samo u okviru iste klase konfiguracionih stavki (\'klasa\') ili globalno (\'globalno\'), što znači da je svaka postojeća Konfiguraciona stavka uzeta u obzir u proveri duplikata.';
    $Self->{Translation}->{'Config Items'} = 'Konfiguracione stavke';
    $Self->{Translation}->{'Config item add.'} = 'Dodavanje konfiguracione stavke.';
    $Self->{Translation}->{'Config item edit.'} = 'Uređivanje konfiguracione stavke.';
    $Self->{Translation}->{'Config item event module that enables logging to history in the agent interface.'} =
        'Modul događaja konfiguracionih stavki koji omogućava beleženje u istorijat u interfejsu operatera.';
    $Self->{Translation}->{'Config item history.'} = 'Istorijat konfiguracione stavke.';
    $Self->{Translation}->{'Config item print.'} = 'Štampa konfiguracione stavke';
    $Self->{Translation}->{'Config item zoom.'} = 'Detaljni prikaz konfiguracine stavke.';
    $Self->{Translation}->{'ConfigItemNumber'} = 'Broj konfiguracione stavke';
    $Self->{Translation}->{'ConfigItems of the following classes will not be stored on the Elasticsearch server. To apply this to existing CIs, the CI migration has to be run via console, after changing this option.'} =
        '';
    $Self->{Translation}->{'ConfigItems with the following deployment states will not be stored on the Elasticsearch server. To apply this to existing CIs, the CI migration has to be run via console, after changing this option.'} =
        '';
    $Self->{Translation}->{'Configuration Item Limit'} = 'Ograničenje konfiguracione stavke';
    $Self->{Translation}->{'Configuration Item limit per page.'} = 'Ograničenje konfiguracionih stavki po strani.';
    $Self->{Translation}->{'Configuration Management Database.'} = 'Baza podataka upravljanja konfiguracijom.';
    $Self->{Translation}->{'Configuration item bulk module.'} = 'Modul masovne akcije na konfiguracionim stavkama.';
    $Self->{Translation}->{'Configuration item search backend router of the agent interface.'} =
        'Konfiguraciona stavka pretražuje pozadinski ruter u interfejsu operatera.';
    $Self->{Translation}->{'Create and manage the definitions for Configuration Items.'} = 'Kreiranje i upravljanje definicija za konfiguracione stavke.';
    $Self->{Translation}->{'Define Actions where a settings button is available in the linked objects widget (LinkObject::ViewMode = "complex"). Please note that these Actions must have registered the following JS and CSS files: Core.AllocationList.css, Core.UI.AllocationList.js, Core.UI.Table.Sort.js, Core.Agent.TableFilters.js and Core.Agent.LinkObject.js.'} =
        'Definiše akcije gde je dugme postavki dostupno u povezanom grafičkom elementu objekta (LinkObject::ViewMode = "complex"). Molimo da imate na umu da ove Akcije moraju da budu registrovane u sledećim JS i CSS datotekama: Core.AllocationList.css, Core.UI.AllocationList.js, Core.UI.Table.Sort.js, Core.Agent.TableFilters.js i Core.Agent.LinkObject.js.';
    $Self->{Translation}->{'Defines Required permissions to create ITSM configuration items using the Generic Interface.'} =
        'Definiše neophodne dozvole za kreiranje ITSM konfiguracionih stavki korišćenjem generičkog interfejsa.';
    $Self->{Translation}->{'Defines Required permissions to delete ITSM configuration items using the Generic Interface.'} =
        'Određuje potrebne dozvole za brisanje ITSM konfiguracionih stavki kroz generički interfejs.';
    $Self->{Translation}->{'Defines Required permissions to get ITSM configuration items using the Generic Interface.'} =
        'Definiše neophodne dozvole za dobijanje ITSM konfiguracionih stavki korišćenjem generičkog interfejsa.';
    $Self->{Translation}->{'Defines Required permissions to search ITSM configuration items using the Generic Interface.'} =
        'Definiše neophodne dozvole za pretragu ITSM konfiguracionih stavki korišćenjem generičkog interfejsa.';
    $Self->{Translation}->{'Defines Required permissions to update ITSM configuration items using the Generic Interface.'} =
        'Definiše neophodne dozvole za ažuriranje ITSM konfiguracionih stavki korišćenjem generičkog interfejsa.';
    $Self->{Translation}->{'Defines an overview module to show the small view of a configuration item list.'} =
        'Definiše modul pregleda za mali prikaz liste konfiguracionih stavki. ';
    $Self->{Translation}->{'Defines regular expressions individually for each ConfigItem class to check the ConfigItem name and to show corresponding error messages.'} =
        'Određuje regularne izraze za svaku klasu konfiguracione stavke radi provere naziva konfiguracione stavke i prikaza pripadajućih poruka o greškama.';
    $Self->{Translation}->{'Defines the default frontend (HTML) theme to be used by the agents and customers. If you like, you can add your own theme. Please refer the administrator manual located at https://doc.otobo.org/.'} =
        '';
    $Self->{Translation}->{'Defines the default frontend language. All the possible values are determined by the available language files on the system. These values are listed as the keys in the setting \'DefaultUsedLanguages\'.'} =
        '';
    $Self->{Translation}->{'Defines the default subobject of the class \'ITSMConfigItem\'.'} =
        'Određuje podrazumevani podobjekat klase ITSM konfiguraciona stavka.';
    $Self->{Translation}->{'Defines the number of rows for the CI definition editor in the admin interface.'} =
        'Određuje broj redova za editor definicije CI u administrativnom interfejsu.';
    $Self->{Translation}->{'Defines the order of incident states from high (e.g. cricital) to low (e.g. functional).'} =
        'Određuje redosled incidentnih stanja od visokog (npr kritično) do niskog (npr funkcionalno).';
    $Self->{Translation}->{'Defines the parameters for the dashboard backend. "Cmd" is used to specify command with parameters. "Group" is used to restrict access to the plugin (e. g. Group: admin;group1;group2;). "Default" indicates if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTL" indicates the cache expiration period in minutes for the plugin. "Mandatory" determines if the plugin is always shown and can not be removed by agents. Only works if DashboardBackend::AllowCmdOutput is enabled in Config.pm.'} =
        '';
    $Self->{Translation}->{'Defines the relevant deployment states where linked tickets can affect the status of a CI.'} =
        'Određuje relevantna stanja raspoređivanja gde povezani tiketi mogu da utiču na status CI.';
    $Self->{Translation}->{'Defines the search limit for the AgentITSMConfigItem screen.'} =
        'Definiše granicu pretrage za ekran AgentITSMConfigItem.';
    $Self->{Translation}->{'Defines the search limit for the AgentITSMConfigItemSearch screen.'} =
        'Definiše granicu pretrage za ekran AgentITSMConfigItemSearch.';
    $Self->{Translation}->{'Defines the shown columns in the config item overview. This option has no effect on the position of the column. Note: Class column is always available if filter \'All\' is selected.'} =
        'Određuje prikazane kolone u pregledu konfiguracionih stavki. Ova opcije nema uticaj na pozicije kolona. Napomena: ukoliko je izabran filter \'Sve\' klasa kolone je uvek dostupna.';
    $Self->{Translation}->{'Defines the shown columns in the config item search. This option has no effect on the position of the column.'} =
        'Definiše prikazane kolone u pretrazi konfiguracionih stavki. Ova opcije nema uticaj na pozicije kolona.';
    $Self->{Translation}->{'Defines the shown columns of CIs in the config item overview depending on the CI class. Each entry must be prefixed with the class name and double colons (i.e. Computer::). There are a few CI-Attributes that are common to all CIs (example for the class Computer: Computer::Name, Computer::CurDeplState, Computer::CreateTime). To show individual CI-Attributes as defined in the CI-Definition, the following scheme must be used (example for the class Computer): Computer::HardDisk::1, Computer::HardDisk::1::Capacity::1, Computer::HardDisk::2, Computer::HardDisk::2::Capacity::1. If there is no entry for a CI class, then the default columns are shown as defined in the setting ITSMConfigItem::Frontend::AgentITSMConfigItem###ShowColumns.'} =
        'Definiše prikazane kolone konfiguracionih stavki u pregledu u zavisnosti od klase. Svaki unos mora sadržati prefiks sa nazivom klase i dvotačkom (npr. Computer::). Postoji par atributa koji su zajednički za sve klase (npr. za klasu Computer: Computer::Name, Computer::CurDeplState, Computer::CreateTime). Za prikaz pojedinačnih atributa iz definicije, morate koristiti sledeću šemu (primer za klasu Computer): Computer::HardDisk::1, Computer::HardDisk::1::Capacity::1, Computer::HardDisk::2, Computer::HardDisk::2::Capacity::1. Ukoliko ne postoji unos za pojedinačnu klasu, biće prikazane podrazumevane kolone definisane u ITSMConfigItem::Frontend::AgentITSMConfigItem###ShowColumns.';
    $Self->{Translation}->{'Defines the shown columns of CIs in the config item search depending on the CI class. Each entry must be prefixed with the class name and double colons (i.e. Computer::). There are a few CI-Attributes that are common to all CIs (example for the class Computer: Computer::Name, Computer::CurDeplState, Computer::CreateTime). To show individual CI-Attributes as defined in the CI-Definition, the following scheme must be used (example for the class Computer): Computer::HardDisk::1, Computer::HardDisk::1::Capacity::1, Computer::HardDisk::2, Computer::HardDisk::2::Capacity::1. If there is no entry for a CI class, then the default columns are shown as defined in the setting ITSMConfigItem::Frontend::AgentITSMConfigItem###ShowColumns.'} =
        'Definiše prikazane kolone konfiguracionih stavki u pretrazi u zavisnosti od klase. Svaki unos mora sadržati prefiks sa nazivom klase i dvotačkom (npr. Computer::). Postoji par atributa koji su zajednički za sve klase (npr. za klasu Computer: Computer::Name, Computer::CurDeplState, Computer::CreateTime). Za prikaz pojedinačnih atributa iz definicije, morate koristiti sledeću šemu (primer za klasu Computer): Computer::HardDisk::1, Computer::HardDisk::1::Capacity::1, Computer::HardDisk::2, Computer::HardDisk::2::Capacity::1. Ukoliko ne postoji unos za pojedinačnu klasu, biće prikazane podrazumevane kolone definisane u ITSMConfigItem::Frontend::AgentITSMConfigItem###ShowColumns.';
    $Self->{Translation}->{'Defines the shown columns of CIs in the config item widget depending on the CI class. Each entry must be prefixed with the class name and double colons (i.e. Computer::). There are a few CI-Attributes that are common to all CIs (example for the class Computer: Computer::Name, Computer::CurDeplState, Computer::CreateTime). To show individual CI-Attributes as defined in the CI-Definition, the following scheme must be used (example for the class Computer): Computer::HardDisk::1, Computer::HardDisk::1::Capacity::1, Computer::HardDisk::2, Computer::HardDisk::2::Capacity::1. If there is no entry for a CI class, then the default columns are shown as defined in the setting AgentCustomerInformationCenter::Backend###0060-CIC-ITSMConfigItemCustomerCompany (key DefaultColumns).'} =
        'Definiše prikazane kolone konfiguracionih stavki u dodatku komandne table u zavisnosti od klase. Svaki unos mora sadržati prefiks sa nazivom klase i dvotačkom (npr. Computer::). Postoji par atributa koji su zajednički za sve klase (npr. za klasu Computer: Computer::Name, Computer::CurDeplState, Computer::CreateTime). Za prikaz pojedinačnih atributa iz definicije, morate koristiti sledeću šemu (primer za klasu Computer): Computer::HardDisk::1, Computer::HardDisk::1::Capacity::1, Computer::HardDisk::2, Computer::HardDisk::2::Capacity::1. Ukoliko ne postoji unos za pojedinačnu klasu, biće prikazane podrazumevane kolone definisane u AgentCustomerInformationCenter::Backend###0060-CIC-ITSMConfigItemCustomerCompany (ključ DefaultColumns).';
    $Self->{Translation}->{'Defines the shown columns of CIs in the link table complex view for all CI classes. If there is no entry, then the default columns are shown.'} =
        'Definiše prikazane kolone konfiguracionih stavki u tabeli veza u zavisnosti od klase. Ukoliko ne postoji unos za pojedinačnu klasu, biće prikazane podrazumevane kolone.';
    $Self->{Translation}->{'Defines the shown columns of CIs in the link table complex view, depending on the CI class. Each entry must be prefixed with the class name and double colons (i.e. Computer::). There are a few CI-Attributes that common to all CIs (example for the class Computer: Computer::Name, Computer::CurDeplState, Computer::CreateTime). To show individual CI-Attributes as defined in the CI-Definition, the following scheme must be used (example for the class Computer): Computer::HardDisk::1, Computer::HardDisk::1::Capacity::1, Computer::HardDisk::2, Computer::HardDisk::2::Capacity::1. If there is no entry for a CI class, then the default columns are shown.'} =
        'Definiše prikazane kolone konfiguracionih stavki u tabeli veza u zavisnosti od klase. Svaki unos mora sadržati prefiks sa nazivom klase i dvotačkom (npr. Computer::). Postoji par atributa koji su zajednički za sve klase (npr. za klasu Computer: Computer::Name, Computer::CurDeplState, Computer::CreateTime). Za prikaz pojedinačnih atributa iz definicije, morate koristiti sledeću šemu (primer za klasu Computer): Computer::HardDisk::1, Computer::HardDisk::1::Capacity::1, Computer::HardDisk::2, Computer::HardDisk::2::Capacity::1. Ukoliko ne postoji unos za pojedinačnu klasu, biće prikazane podrazumevane kolone.';
    $Self->{Translation}->{'Defines which type of link (named from the ticket perspective) can affect the status of a linked CI.'} =
        'Određuje koji tip veze (gledano iz perspektive tiketa) može da utiče na povezanu CI.';
    $Self->{Translation}->{'Defines which type of ticket can affect the status of a linked CI.'} =
        'Određuje koji tip tiketa može da utiče na status povezane CI.';
    $Self->{Translation}->{'Delete Configuration Item'} = 'Brisanje konfiguracione stavke';
    $Self->{Translation}->{'Deployment State Color'} = 'Boja statusa raspoređivanja';
    $Self->{Translation}->{'Duplicate'} = 'Duplikat';
    $Self->{Translation}->{'Enables configuration item bulk action feature for the agent frontend to work on more than one configuration item at a time.'} =
        'Omogućava masovnu akciju na konfiguracionim stavkama u pristupnom sistemu operatera na više od jedne stavke istovremeno.';
    $Self->{Translation}->{'Enables configuration item bulk action feature only for the listed groups.'} =
        'Aktivira svojstvo masovne akcije na konfigiracionim stavkama samo za izlistane grupe.';
    $Self->{Translation}->{'Enables/disables the functionality to check ConfigItems for unique names. Before enabling this option you should check your system for already existing config items with duplicate names. You can do this with the script bin/otobo.ITSMConfigItemListDuplicates.pl.'} =
        'Aktivira/deaktivira funkciju za proveru jedinstvenosti imana konfiguracionih stavki. Pre aktiviranja ove opcije trebate proveriti u vašem sistemu postojanje duplikata na postojećim stavkama. To možete uraditi pomoću skripta bin/otobo.ITSMConfigItemListDuplicates.pl. ';
    $Self->{Translation}->{'Event module to set configitem-status on ticket-configitem-link.'} =
        'Modul događaja za podešavanje statusa konfiguracionih stavki prilikom postavljanja veza.';
    $Self->{Translation}->{'Fields of the configuration item index, used for the fulltext search. Fields are also stored, but are not mandatory for the overall functionality. Inclusion of attachments can be disabled by setting the entry to 0 or deleting it.'} =
        '';
    $Self->{Translation}->{'Fields stored in the configuration item index which are used for other things besides fulltext searches. For the complete functionality all fields are mandatory.'} =
        '';
    $Self->{Translation}->{'ITSM config item overview.'} = 'Pregled ITSM konfiguracione stavke.';
    $Self->{Translation}->{'If "LDAP" was selected for Customer::AuthModule and you wish to use TLS security to communicate with the LDAP server, the "verify" parameter can be specified here. See Net::LDAP::start_tls for more information about the parameter.'} =
        '';
    $Self->{Translation}->{'Ignores not ticket related attributes.'} = '';
    $Self->{Translation}->{'Module to check the group responsible for a class.'} = 'Modul za proveru grupe odgovorne za klasu.';
    $Self->{Translation}->{'Module to check the group responsible for a configuration item.'} =
        'Modul za proveru grupe odgovorne za konfiguracionu stavku.';
    $Self->{Translation}->{'Module to generate ITSM config item statistics.'} = 'Modul za generisanje statistike ITSM konfiguracionih stavki.';
    $Self->{Translation}->{'Object backend module registration for the import/export module.'} =
        'Registracija modula objekta za dodatak uvoz/izvoz.';
    $Self->{Translation}->{'Objects to search for, how many entries and which attributs to show. ConfigItem attributes have to explicitly be stored via Elasticsearch.'} =
        '';
    $Self->{Translation}->{'Overview.'} = 'Pregled.';
    $Self->{Translation}->{'Parameters for the dashboard backend of the customer company config item overview of the agent interface . "Limit" is the number of entries shown by default. "Group" is used to restrict the access to the plugin (e. g. Group: admin;group1;group2;). "Default" determines if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" is the cache time in minutes for the plugin.'} =
        'Parametri za pozadinski prikaz kontrolne table liste konfiguracionih stavki firme klijenta u interfejsu operatera. "Limit" definiše podrazumevani broj prikazanih stavki. "Group" se koristi da ograniči pristup dodatku (npr. Group: admin;group1;group2;). "Default" određuje da li je dodatak podrazumevano aktiviran ili da je neophodno da ga korisnik manuelno aktivira. "CacheTTLLocal" je vreme u minutima za keširanje dodatka.';
    $Self->{Translation}->{'Parameters for the deployment states color in the preferences view of the agent interface.'} =
        'Parametri za boje statusa primene na prikazu postavki u interfejsu operatera.';
    $Self->{Translation}->{'Parameters for the deployment states in the preferences view of the agent interface.'} =
        'Parametri za statuse primene na prikazu postavki u interfejsu operatera.';
    $Self->{Translation}->{'Parameters for the example permission groups of the general catalog attributes.'} =
        'Parametri za atribute uzorka grupe za dozvole opšteg kataloga';
    $Self->{Translation}->{'Parameters for the pages (in which the configuration items are shown).'} =
        'Parametri za stranice (na kojima su konfiguracione stavke prikazane).';
    $Self->{Translation}->{'Performs the configured action for each event (as an Invoker) for each configured Webservice.'} =
        '';
    $Self->{Translation}->{'Permission Group'} = 'Grupa pristupa';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item screen in the agent interface.'} =
        'Potrebne dozvole za upotrebu ekrana ITSM konfiguracione stavke u interfejsu operatera.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item search screen in the agent interface.'} =
        'Potrebne dozvole za upotrebu ekrana pretrage ITSM konfiguracione stavke u interfejsu operatera.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item zoom screen in the agent interface.'} =
        'Potrebne dozvole za upotrebu ekrana detalnog prikaza ITSM konfiguracione stavke u interfejsu operatera.';
    $Self->{Translation}->{'Required permissions to use the add ITSM configuration item screen in the agent interface.'} =
        'Potrebne dozvole za upotrebu ekrana dodavanja ITSM konfiguracione stavke u interfejsu operatera.';
    $Self->{Translation}->{'Required permissions to use the edit ITSM configuration item screen in the agent interface.'} =
        'Potrebne dozvole za upotrebu ekrana izmene ITSM konfiguracione stavke u interfejsu operatera.';
    $Self->{Translation}->{'Required permissions to use the history ITSM configuration item screen in the agent interface.'} =
        'Potrebne dozvole za upotrebu ekrana istorijata ITSM konfiguracione stavke u interfejsu operatera.';
    $Self->{Translation}->{'Required permissions to use the print ITSM configuration item screen in the agent interface.'} =
        'Potrebne dozvole za upotrebu ekrana štampe ITSM konfiguracione stavke u interfejsu operatera.';
    $Self->{Translation}->{'Required privileges to delete config items.'} = 'Potrebna prava za brisanje konfiguracione stavke.';
    $Self->{Translation}->{'Search config items.'} = 'Pretraga konfiguracionih stavki.';
    $Self->{Translation}->{'Selects the configuration item number generator module. "AutoIncrement" increments the configuration item number, the SystemID, the ConfigItemClassID and the counter are used. The format is "SystemID.ConfigItemClassID.Counter", e.g. 1205000004, 1205000005.'} =
        'Bira modul operatora automatskog uvećanja konfiguracione stavke. Operator automatskog uvećanja povećava broj stavke, SystemID, ConfigItemClassID i korišćeni brojač. Format je "SystemID.ConfigItemClassID.brojač", npr 1205000004, 1205000005.';
    $Self->{Translation}->{'Set the incident state of a CI automatically when a Ticket is Linked to a CI.'} =
        'Postavlja stanje incidenta konfiguracione stavke kada je tiket povezan sa stavkom.';
    $Self->{Translation}->{'Sets the deployment state in the configuration item bulk screen of the agent interface.'} =
        'Određuje status primene na ekranu masovne akcije konfiguracione stavke u interfejsu operatera.';
    $Self->{Translation}->{'Sets the incident state in the configuration item bulk screen of the agent interface.'} =
        'Određuje status incidenta na ekranu masovne akcije konfiguracione stavke u interfejsu operatera.';
    $Self->{Translation}->{'Shows a link in the menu that allows linking a configuration item with another object in the config item zoom view of the agent interface.'} =
        'U meniju prikazuje vezu koja omogućava povezivanje konfiguracione stavke sa drugim objektom na detaljnom prikazu konfiguracije u interfejsu operatera.';
    $Self->{Translation}->{'Shows a link in the menu to access the history of a configuration item in the configuration item overview of the agent interface.'} =
        'U meniju prikazuje vezu za pristup istorijatu konfiguracione stavke na pregledu konfiguracione stavke u interfejsu operatera.';
    $Self->{Translation}->{'Shows a link in the menu to access the history of a configuration item in the its zoom view of the agent interface.'} =
        'U meniju prikazuje vezu za pristup istorijatu konfiguracione stavke na detaljnom prikazu u interfejsu operatera.';
    $Self->{Translation}->{'Shows a link in the menu to delete a configuration item in its zoom view of the agent interface.'} =
        'U meniju prikazuje vezu za brisanje konfiguracione stavke na njenom detaljnom prikazu u interfejsu operatera.';
    $Self->{Translation}->{'Shows a link in the menu to duplicate a configuration item in the configuration item overview of the agent interface.'} =
        'U meniju prikazuje vezu za umnožavanje konfiguracione stavke na pregledu konfiguracione stavke u interfejsu operatera.';
    $Self->{Translation}->{'Shows a link in the menu to duplicate a configuration item in the its zoom view of the agent interface.'} =
        'U meniju prikazuje vezu za umnožavanje konfiguracione stavke na njenom detaljnom prikazu u interfejsu operatera.';
    $Self->{Translation}->{'Shows a link in the menu to edit a configuration item in the its zoom view of the agent interface.'} =
        'U meniju prikazuje vezu za izmenu konfiguracione stavke na njenom detaljnom prikazu u interfejsu operatera.';
    $Self->{Translation}->{'Shows a link in the menu to go back in the configuration item zoom view of the agent interface.'} =
        'U meniju prikazuje vezu za povratak na detaljni prikaz konfiguracione stavke  u interfejsu operatera.';
    $Self->{Translation}->{'Shows a link in the menu to print a configuration item in the its zoom view of the agent interface.'} =
        'U meniju prikazuje vezu za štampu konfiguracione stavke na njenom detaljnom prikazu u interfejsu operatera.';
    $Self->{Translation}->{'Shows a link in the menu to zoom into a configuration item in the configuration item overview of the agent interface.'} =
        'U meniju prikazuje vezu za detaljni prikaz konfiguracione stavke na pregledu konfiguracione stavke u interfejsu operatera.';
    $Self->{Translation}->{'Shows the config item history (reverse ordered) in the agent interface.'} =
        'Prikazuje istorijat konfiguracione stavke (obrnut redosled) u interfejsu operatera.';
    $Self->{Translation}->{'The identifier for a configuration item, e.g. ConfigItem#, MyConfigItem#. The default is ConfigItem#.'} =
        'Identifikator za konfiguracionu stavku, npr. ConfigItem#, MyConfigItem#. Podrazumevano je ConfigItem#.';
    $Self->{Translation}->{'class'} = 'klasa';
    $Self->{Translation}->{'global'} = 'globalno';
    $Self->{Translation}->{'postproductive'} = 'post-produkcija';
    $Self->{Translation}->{'preproductive'} = 'pre-produkcija';
    $Self->{Translation}->{'productive'} = 'produkcija';


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

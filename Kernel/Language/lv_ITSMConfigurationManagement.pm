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

package Kernel::Language::lv_ITSMConfigurationManagement;

use strict;
use warnings;
use utf8;

sub Data {
    my $Self = shift;

    # Template: AdminITSMConfigItem
    $Self->{Translation}->{'Config Item Management'} = 'Konfigurācijas elementu pārvaldība';
    $Self->{Translation}->{'Change class definition'} = 'Mainīt klases definīciju';
    $Self->{Translation}->{'Change role definition'} = 'Mainīt lomas definīciju';
    $Self->{Translation}->{'Ready2Import Class Bundles'} = 'Ready2Import klašu komplekti';
    $Self->{Translation}->{'Here you can import Ready2Import class bundles showcasing our most usual config items. Please note that some additional configuration may be required.'} =
        'Šeit varat importēt Ready2Import klašu komplektus, kuros parādīti mūsu visbiežāk izmantotie konfigurācijas elementi. Lūdzu, ņemiet vērā, ka var būt nepieciešama papildu konfigurācija.';
    $Self->{Translation}->{'Update existing entities'} = 'Atjaunināt esošās vienības';
    $Self->{Translation}->{'Import Ready2Adopt class bundles'} = 'Importēt Ready2Adopt klases komplektus';
    $Self->{Translation}->{'Config Item Class'} = 'Konfigurācijas vienuma klase';
    $Self->{Translation}->{'Config Item Role'} = 'Konfigurācijas vienuma loma';

    # Template: AgentITSMConfigItemAdd
    $Self->{Translation}->{'Config Item'} = 'Konfigurācijas vienums';
    $Self->{Translation}->{'Filter for Classes'} = 'Klašu filtrs';
    $Self->{Translation}->{'Select a Class from the list to create a new Config Item.'} = 'Lai izveidotu jaunu konfigurācijas elementu, sarakstā atlasiet klasi.';
    $Self->{Translation}->{'Class'} = 'Klase';

    # Template: AgentITSMConfigItemBulk
    $Self->{Translation}->{'ITSM ConfigItem Bulk Action'} = 'ITSM ConfigItem Bulk darbība';
    $Self->{Translation}->{'Deployment state'} = 'Izvietošanas stāvoklis';
    $Self->{Translation}->{'Incident state'} = 'Incidenta stāvoklis';
    $Self->{Translation}->{'Link to another'} = 'Saite uz citu';
    $Self->{Translation}->{'Invalid Configuration Item number!'} = 'Nederīgs konfigurācijas elementa numurs!';
    $Self->{Translation}->{'The number of another Configuration Item to link with.'} = 'Cita konfigurācijas elementa numurs, ar kuru tas jāsasaista.';

    # Template: AgentITSMConfigItemDelete
    $Self->{Translation}->{'Do you really want to delete this config item?'} = 'Vai tiešām vēlaties dzēst šo konfigurācijas elementu?';

    # Template: AgentITSMConfigItemEdit
    $Self->{Translation}->{'The name of this config item'} = 'Šī konfigurācijas elementa nosaukums';
    $Self->{Translation}->{'Name is already in use by the ConfigItems with the following Number(s): %s'} =
        'Nosaukums jau tiek izmantots ConfigItems ar šādu(-iem) numuru(-iem): %s';
    $Self->{Translation}->{'Version Number'} = 'Versijas numurs';
    $Self->{Translation}->{'Version number of this config item'} = 'Šī konfigurācijas elementa versijas numurs';
    $Self->{Translation}->{'Version Number is already in use by the ConfigItems with the following Number(s): %s'} =
        'Versijas numuru jau izmanto ConfigItems ar šādu(-iem) numuru(-iem): %s';
    $Self->{Translation}->{'Deployment State'} = 'Izvietošanas stāvoklis';
    $Self->{Translation}->{'Incident State'} = 'Incidenta valsts';

    # Template: AgentITSMConfigItemHistory
    $Self->{Translation}->{'History of Config Item: %s'} = 'Konfigurācijas elementa vēsture: %s';
    $Self->{Translation}->{'History Content'} = 'Vēstures saturs';
    $Self->{Translation}->{'Createtime'} = 'Createtime';
    $Self->{Translation}->{'Zoom view'} = 'Palielināt skats';

    # Template: AgentITSMConfigItemOverviewNavBar
    $Self->{Translation}->{'Config Items per page'} = 'Config Vienības uz lapu';

    # Template: AgentITSMConfigItemOverviewSmall
    $Self->{Translation}->{'No config item data found.'} = 'Konfigurācijas elementa dati nav atrasti.';
    $Self->{Translation}->{'Select this config item'} = 'Izvēlieties šo konfigurācijas elementu';

    # Template: AgentITSMConfigItemSearch
    $Self->{Translation}->{'Run Search'} = 'Palaist meklēšanu';
    $Self->{Translation}->{'Also search in previous versions?'} = 'Meklēt arī iepriekšējās versijās?';

    # Template: AgentITSMConfigItemTreeView
    $Self->{Translation}->{'TreeView for ConfigItem'} = 'ConfigItem TreeView';
    $Self->{Translation}->{'Depth Level'} = 'Dziļuma līmenis';
    $Self->{Translation}->{'Zoom In/Out'} = 'Palielināt/izslēgt';
    $Self->{Translation}->{'Max links level reached for ConfigItem!'} = 'ConfigItem sasniegts maksimālais saišu līmenis!';

    # Template: AgentITSMConfigItemZoom
    $Self->{Translation}->{'Configuration Item'} = 'Konfigurācijas vienums';
    $Self->{Translation}->{'Configuration Item Information'} = 'Informācija par konfigurācijas elementu';
    $Self->{Translation}->{'Current Deployment State'} = 'Pašreizējais izvietošanas stāvoklis';
    $Self->{Translation}->{'Current Incident State'} = 'Pašreizējais incidenta stāvoklis';
    $Self->{Translation}->{'Last changed'} = 'Pēdējās izmaiņas';
    $Self->{Translation}->{'Last changed by'} = 'Pēdējo reizi mainīts ar';

    # Template: CustomerITSMConfigItem
    $Self->{Translation}->{'Your ConfigItems'} = 'Jūsu ConfigItems';

    # Template: CustomerITSMConfigItemSearch
    $Self->{Translation}->{'ConfigItem Search'} = 'ConfigItem meklēšana';

    # Template: AdminACL
    $Self->{Translation}->{'Object Type'} = 'Objekta tips';

    # JS Template: ClassImportConfirm
    $Self->{Translation}->{'The following classes will be imported'} = 'Tiks importētas šādas klases';
    $Self->{Translation}->{'The following roles will be imported'} = 'Tiks importētas šādas lomas';
    $Self->{Translation}->{'Note that also corresponding dynamic fields and GeneralCatalog classes will be created and there is no automatic removal.'} =
        'Ņemiet vērā, ka tiks izveidoti arī attiecīgie dinamiskie lauki un GeneralCatalog klases, un automātiska noņemšana nenotiks.';
    $Self->{Translation}->{'Do you want to proceed?'} = 'Vai vēlaties turpināt?';

    # Perl Module: Kernel/Modules/AdminITSMConfigItem.pm
    $Self->{Translation}->{'Need ExampleClasses!'} = 'Nepieciešamas piemēru klases!';
    $Self->{Translation}->{'Definition is no valid YAML hash.'} = 'Definīcija nav derīgs YAML hash.';

    # Perl Module: Kernel/Modules/AgentITSMConfigItem.pm
    $Self->{Translation}->{'Overview: ITSM ConfigItem'} = 'Pārskats: ITSM ConfigItem';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemBulk.pm
    $Self->{Translation}->{'No ConfigItemID is given!'} = 'Nav norādīts ConfigItemtemID!';
    $Self->{Translation}->{'You need at least one selected Configuration Item!'} = 'Jums ir nepieciešams vismaz viens izvēlēts konfigurācijas vienums!';
    $Self->{Translation}->{'You don\'t have write access to this configuration item: %s.'} =
        'Jums nav rakstīšanas piekļuves šim konfigurācijas elementam: %s.';
    $Self->{Translation}->{'No definition was defined for class %s!'} = 'Klasei %s nav definēta definīcija!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemDelete.pm
    $Self->{Translation}->{'Config item "%s" not found in database!'} = 'Konfigurācijas vienība "%s" nav atrasta datu bāzē!';
    $Self->{Translation}->{'Was not able to delete the configitem ID %s!'} = 'Nevarēja izdzēst konfigurācijas elementu ID %s!';
    $Self->{Translation}->{'No version found for ConfigItemID %s!'} = 'Nav atrasta versija ConfigItemEMID %s!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemEdit.pm
    $Self->{Translation}->{'No ConfigItemID, DuplicateID or ClassID is given!'} = 'Nav norādīts ConfigItemID, DuplicateID vai ClassID!';
    $Self->{Translation}->{'No access is given!'} = 'Piekļuve nav dota!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemHistory.pm
    $Self->{Translation}->{'Can\'t show history, no ConfigItemID is given!'} = 'Nevar parādīt vēsturi, nav norādīts neviens ConfigItemtemID!';
    $Self->{Translation}->{'Can\'t show history, no access rights given!'} = 'Nevar parādīt vēsturi, nav piešķirtas piekļuves tiesības!';
    $Self->{Translation}->{'New ConfigItem (ID=%s)'} = 'Jauns konfigurācijas elements (ID=%s)';
    $Self->{Translation}->{'New version (ID=%s)'} = 'Jauna versija (ID=%s)';
    $Self->{Translation}->{'Deployment state updated (new=%s, old=%s)'} = 'Atjaunināts izvietošanas stāvoklis (new=%s, old=%s)';
    $Self->{Translation}->{'Incident state updated (new=%s, old=%s)'} = 'Atjaunināts incidenta stāvoklis (new=%s, old=%s)';
    $Self->{Translation}->{'ConfigItem (ID=%s) deleted'} = 'Konfigurācijas elements (ID=%s) dzēsts';
    $Self->{Translation}->{'Link to %s (type=%s) added'} = 'Pievienota saite uz %s (tips=%s)';
    $Self->{Translation}->{'Link to %s (type=%s) deleted'} = 'Saite uz %s (tips=%s) dzēsta';
    $Self->{Translation}->{'ConfigItem definition updated (ID=%s)'} = 'Atjaunināta ConfigItem definīcija (ID=%s)';
    $Self->{Translation}->{'Name updated (new=%s, old=%s)'} = 'Atjaunināts nosaukums (new=%s, old=%s)';
    $Self->{Translation}->{'Attribute %s updated from "%s" to "%s"'} = 'Atribūts %s atjaunināts no "%s" uz "%s"';
    $Self->{Translation}->{'Version %s deleted'} = 'Versija %s dzēsta';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemPrint.pm
    $Self->{Translation}->{'No ConfigItemID or VersionID is given!'} = 'Nav norādīts ConfigItemID vai VersionID!';
    $Self->{Translation}->{'Can\'t show config item, no access rights given!'} = 'Nevar parādīt konfigurācijas elementu, nav piešķirtas piekļuves tiesības!';
    $Self->{Translation}->{'ConfigItemID %s not found in database!'} = 'ConfigItemEMID %s nav atrasts datu bāzē!';
    $Self->{Translation}->{'ConfigItem'} = 'ConfigItem';
    $Self->{Translation}->{'printed by %s at %s'} = 'izdrukāts %s pie %s';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemSearch.pm
    $Self->{Translation}->{'Invalid ClassID!'} = 'Nederīgs klasesID!';
    $Self->{Translation}->{'No ClassID is given!'} = 'Nav norādīts klasesID!';
    $Self->{Translation}->{'No access rights for this class given!'} = 'Šai klasei nav piešķirtas piekļuves tiesības!';
    $Self->{Translation}->{'No Result!'} = 'Nav rezultāta!';
    $Self->{Translation}->{'Config Item Search Results'} = 'Konfigurēšanas vienuma meklēšanas rezultāti';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemZoom.pm
    $Self->{Translation}->{'Can\'t show item, no access rights for ConfigItem are given!'} =
        'Nevar parādīt elementu, nav piešķirtas piekļuves tiesības ConfigItem!';
    $Self->{Translation}->{'ConfigItem not found!'} = 'ConfigItem nav atrasts!';
    $Self->{Translation}->{'No versions found!'} = 'Versijas nav atrastas!';
    $Self->{Translation}->{'operational'} = 'darbības';
    $Self->{Translation}->{'warning'} = 'brīdinājums';
    $Self->{Translation}->{'incident'} = 'incidents';
    $Self->{Translation}->{'The deployment state of this config item'} = 'Šī konfigurācijas elementa izvietošanas stāvoklis';
    $Self->{Translation}->{'The incident state of this config item'} = 'Šī konfigurācijas elementa incidenta stāvoklis';

    # Perl Module: Kernel/Modules/CustomerITSMConfigItemSearch.pm
    $Self->{Translation}->{'No permission'} = 'Nav atļaujas';
    $Self->{Translation}->{'Filter invalid!'} = 'Filtrs nederīgs!';
    $Self->{Translation}->{'Search params invalid!'} = 'Meklēšanas params nederīgs!';

    # Perl Module: Kernel/Output/HTML/Dashboard/ITSMConfigItemGeneric.pm
    $Self->{Translation}->{'Shown config items'} = 'Parādītie konfigurācijas elementi';
    $Self->{Translation}->{'Deployment State Type'} = 'Izvietošanas valsts tips';
    $Self->{Translation}->{'Current Incident State Type'} = 'Pašreizējais incidenta valsts tips';

    # Perl Module: Kernel/Output/HTML/ITSMConfigItem/LayoutDate.pm
    $Self->{Translation}->{'Between'} = 'Starp';

    # Perl Module: Kernel/System/DynamicField/Driver/ConfigItem.pm
    $Self->{Translation}->{'Class restrictions for the config item'} = 'Konfigurācijas elementa klases ierobežojumi';
    $Self->{Translation}->{'Select one or more classes to restrict selectable config items'} =
        'Izvēlieties vienu vai vairākas klases, lai ierobežotu atlasāmos konfigurācijas elementus.';
    $Self->{Translation}->{'Link type'} = 'Saites veids';
    $Self->{Translation}->{'Select the link type.'} = 'Izvēlieties saites veidu.';
    $Self->{Translation}->{'Forwards: Referencing (Source) -> Referenced (Target)'} = 'Uzbrucēji: Atsauce (Avots) -> Atsauce (Mērķis)';
    $Self->{Translation}->{'Backwards: Referenced (Source) -> Referencing (Target)'} = 'Atpakaļ: Atsauce (Avots) -> Atsauce (Mērķis)';
    $Self->{Translation}->{'Link Direction'} = 'Saites virziens';
    $Self->{Translation}->{'The referencing object is the one containing this dynamic field, the referenced object is the one selected as value of the dynamic field.'} =
        'Atsauces objekts ir objekts, kas satur šo dinamisko lauku, bet atsauces objekts ir objekts, kas izvēlēts kā dinamiskā lauka vērtība.';
    $Self->{Translation}->{'Dynamic (ConfigItem)'} = 'Dinamisks (ConfigItem)';
    $Self->{Translation}->{'Static (Version)'} = 'Statisks (versija)';
    $Self->{Translation}->{'Link Referencing Type'} = 'Saite Atsauces veids';
    $Self->{Translation}->{'Whether this link applies to the ConfigItem or the static version of the referencing object. Current Incident State calculation only is performed on dynamic links.'} =
        'Vai šī saite attiecas uz atsauces objekta ConfigItem vai statisko versiju. Pašreizējā incidenta stāvokļa aprēķins tiek veikts tikai dinamiskajām saitēm.';
    $Self->{Translation}->{'Select the attribute which config items will be searched by'} = 'Atlasiet atribūtu, pēc kura tiks meklēti konfigurācijas elementi.';

    # Perl Module: Kernel/System/ITSMConfigItem/Definition.pm
    $Self->{Translation}->{'Base structure is not valid. Please provide a hash with data in YAML format.'} =
        'Bāzes struktūra nav derīga. Lūdzu, norādiet hash ar datiem YAML formātā.';
    $Self->{Translation}->{'Starting the YAML string with \'---\' is required.'} = 'YAML virkne jāsāk ar \'---\'.';

    # Perl Module: Kernel/System/ITSMConfigItem/Link.pm
    $Self->{Translation}->{'Could not purge the table configitem_link.'} = 'Neizdevās attīrīt tabulu configitem_link.';
    $Self->{Translation}->{'No relevant dynamic fields were found'} = 'Netika atrasti attiecīgie dinamiskie lauki';
    $Self->{Translation}->{'Could not insert into the table configitem_link'} = 'Nevar ievietot tabulā configitem_link';
    $Self->{Translation}->{'Inserted 0 rows into the table configitem_link'} = 'Tabulā configitem_link ievietotas 0 rindas';

    # Perl Module: Kernel/System/ImportExport/ObjectBackend/ITSMConfigItem.pm
    $Self->{Translation}->{'Maximum number of one element'} = 'Maksimālais viena elementa skaits';
    $Self->{Translation}->{'Empty fields indicate that the current values are kept'} = 'Tukši lauki norāda, ka pašreizējās vērtības tiek saglabātas.';
    $Self->{Translation}->{'Skipped'} = 'Izlaists';

    # Perl Module: Kernel/Modules/AdminDynamicField.pm
    $Self->{Translation}->{'Error synchronizing the definitions. Please check the log.'} = 'Kļūda, sinhronizējot definīcijas. Lūdzu, pārbaudiet žurnālu.';
    $Self->{Translation}->{'You have ITSMConfigItem definitions which are not synchronized. Please deploy your ITSMConfigItem dynamic field changes.'} =
        'Jums ir ITSMConfigItem definīcijas, kas nav sinhronizētas. Lūdzu, ievietojiet ITSMConfigItem dinamisko lauku izmaiņas.';

    # Database XML / SOPM Definition: ITSMConfigurationManagement.sopm
    $Self->{Translation}->{'Expired'} = 'Darbības termiņš beidzies';
    $Self->{Translation}->{'Maintenance'} = 'Uzturēšana';
    $Self->{Translation}->{'Pilot'} = 'Pilot';
    $Self->{Translation}->{'Planned'} = 'Plānots';
    $Self->{Translation}->{'Repair'} = 'Remonts';
    $Self->{Translation}->{'Retired'} = 'Pensionēts';
    $Self->{Translation}->{'Review'} = 'Pārskats';
    $Self->{Translation}->{'Test/QA'} = 'Testēšana / kvalitātes nodrošināšana';

    # JS File: ITSM.Admin.ITSMConfigItem
    $Self->{Translation}->{'Overview and Confirmation'} = 'Pārskats un apstiprinājums';
    $Self->{Translation}->{'Importing classes/roles and their related fields'} = 'Klašu/ lomu un ar tām saistīto lauku importēšana';
    $Self->{Translation}->{'An error occurred during class import.'} = 'Klases importēšanas laikā notika kļūda.';

    # SysConfig
    $Self->{Translation}->{'0 - Hidden'} = '0 - Slēptas';
    $Self->{Translation}->{'1 - Shown'} = '1 - attēlots';
    $Self->{Translation}->{'Allows extended search conditions in config item search of the agent interface. With this feature you can search e. g. config item name with this kind of conditions like "(*key1*&&*key2*)" or "(*key1*||*key2*)".'} =
        'Ļauj paplašināt meklēšanas nosacījumus aģenta saskarnes konfigurācijas elementu meklēšanā. Izmantojot šo funkciju, jūs varat meklēt, piemēram, konfigurācijas elementa nosaukumu ar šādiem nosacījumiem, piemēram, "(*key1*&&*key2*)" vai "(*key1*||*key2*)".';
    $Self->{Translation}->{'Allows extended search conditions in config item search of the customer interface. With this feature you can search e. g. config item name with this kind of conditions like "(*key1*&&*key2*)" or "(*key1*||*key2*)".'} =
        'Ļauj paplašināt meklēšanas nosacījumus klienta saskarnes konfigurācijas elementu meklēšanā. Izmantojot šo funkciju, jūs varat meklēt, piemēram, konfigurācijas elementa nosaukumu ar šādiem nosacījumiem, piemēram, "(*key1*&&&*key2*)" vai "(*key1*||*key2*)".';
    $Self->{Translation}->{'Assigned CIs'} = 'Piešķirtie KI';
    $Self->{Translation}->{'At a specific time point create a ticket for config items, if the configured requirements are met. The time point is determined by the value of the field configured under "TimeCIKey" of the ConfigItem, and modified by "TimeModifier". If the latter can be either just a number, or a sign (+/-), a number, and an unit (d/h/m): "7" is equivalent to "+7d". The DynamicField "Ticket->DynamicField" will be used to mark created tickets - it has to exist. The flags \<OTOBO_CONFIGITEM_X\> where X can be NAME, NUMBER and DATE, will be substituted with the respective values in "Ticket->Text".'} =
        'Noteiktā brīdī izveidojiet biļeti par konfigurācijas elementiem, ja ir izpildītas konfigurētās prasības. Laika punktu nosaka pēc lauka vērtības, kas konfigurēta ConfigItem "TimeCIKey" (konfigurācijas elementa "TimeCIKey") un modificēta ar "TimeModifier" (laika modifikators). Pēdējais var būt vai nu tikai skaitlis, vai arī zīme (+/-), skaitlis un mērvienība (d/h/m): "7" ir līdzvērtīgs "+7d". Dinamiskais lauks "Ticket->DynamicField" tiks izmantots, lai atzīmētu izveidotās biļetes - tam ir jābūt. Flagus \<OTOBO_CONFIGITEM_X\>, kur X var būt NAME (nosaukums), NUMBER (skaitlis) un DATE (datums), aizstās ar attiecīgajām vērtībām "Ticket->Text".';
    $Self->{Translation}->{'CIs assigned to customer company'} = 'Klienta uzņēmumam piešķirtie KI';
    $Self->{Translation}->{'CIs assigned to customer user'} = 'Klienta lietotājam piešķirtie CI';
    $Self->{Translation}->{'CMDB Settings'} = 'CMDB iestatījumi';
    $Self->{Translation}->{'Check for a unique name only within the same ConfigItem class (\'class\') or globally (\'global\'), which means every existing ConfigItem is taken into account when looking for duplicates.'} =
        'Pārbaudīt unikālu nosaukumu tikai tajā pašā ConfigItem klasē (\'class\') vai globāli (\'global\'), kas nozīmē, ka, meklējot dublikātus, tiek ņemts vērā katrs esošais ConfigItem.';
    $Self->{Translation}->{'Choose a module to enforce a naming scheme.'} = 'Izvēlieties moduli, lai ieviestu nosaukumu shēmu.';
    $Self->{Translation}->{'Choose a module to enforce a number scheme.'} = 'Izvēlieties moduli, lai ieviestu numuru shēmu.';
    $Self->{Translation}->{'Choose a module to enforce a version string scheme.'} = 'Izvēlieties moduli, lai ieviestu versiju virknes shēmu.';
    $Self->{Translation}->{'Choose attributes to trigger the creation of a new version.'} = 'Izvēlieties atribūtus, kas izraisa jaunas versijas izveidi.';
    $Self->{Translation}->{'Choose categories to assign to this config item class.'} = 'Izvēlieties kategorijas, ko piešķirt šai konfigurācijas elementu klasei.';
    $Self->{Translation}->{'Column config item filters for ConfigItem Overview.'} = 'Kolonnu konfigurācijas elementu filtri ConfigItem Pārskats.';
    $Self->{Translation}->{'Columns that can be filtered in the config item overview of the agent interface. Note: Only Config Item attributes and Dynamic Fields (DynamicField_NameX) are allowed.'} =
        'Kolonnas, kuras var filtrēt aģenta saskarnes konfigurācijas elementu pārskatā. Piezīme: Ir atļauti tikai konfigurācijas elementu atribūti un dinamiskie lauki (DynamicField_NameX).';
    $Self->{Translation}->{'Columns that can be filtered in the config item overview of the customer interface. Note: Only Config Item attributes and Dynamic Fields (DynamicField_NameX) are allowed.'} =
        'Kolonnas, kuras var filtrēt klienta saskarnes konfigurācijas elementu pārskatā. Piezīme: Ir atļauti tikai konfigurācijas elementu atribūti un dinamiskie lauki (DynamicField_NameX).';
    $Self->{Translation}->{'Columns that can be filtered in the config item search result overview of the agent interface. Note: Only Config Item attributes and Dynamic Fields (DynamicField_NameX) are allowed.'} =
        'Kolonnas, kuras var filtrēt aģenta saskarnes konfigurēto elementu meklēšanas rezultātu pārskatā. Piezīme: Ir atļauti tikai konfigurācijas elementu atribūti un dinamiskie lauki (DynamicField_NameX).';
    $Self->{Translation}->{'Config Items'} = 'Konfigurācijas elementi';
    $Self->{Translation}->{'Config item add.'} = 'Konfigurācijas elementa pievienošana.';
    $Self->{Translation}->{'Config item edit.'} = 'Konfigurācijas elementa rediģēšana.';
    $Self->{Translation}->{'Config item event module that count the licenses for OTOBOCILicenseCount feature.'} =
        'Konfigurējiet elementu notikumu moduli, kas skaita licences OTOBOCILicenseCount funkcijai.';
    $Self->{Translation}->{'Config item event module that enables logging to history in the agent interface.'} =
        'Konfigurējiet elementu notikumu moduli, kas aģenta saskarnē ļauj reģistrēt vēsturi.';
    $Self->{Translation}->{'Config item event module that updates config items to their current definition.'} =
        'Konfigurācijas elementu notikumu modulis, kas atjaunina konfigurācijas elementu pašreizējo definīciju.';
    $Self->{Translation}->{'Config item event module that updates the table configitem_ĺink.'} =
        'Config item notikumu modulis, kas atjaunina tabulu configitem_ĺink.';
    $Self->{Translation}->{'Config item event module updates the current incident state.'} =
        'Konfigurācijas elementa notikumu modulis atjaunina pašreizējo incidenta stāvokli.';
    $Self->{Translation}->{'Config item history.'} = 'Konfigurēšanas elementu vēsture.';
    $Self->{Translation}->{'Config item print.'} = 'Konfigurācijas elementa drukāšana.';
    $Self->{Translation}->{'Config item zoom.'} = 'Konfigurējiet vienuma tālummaiņu.';
    $Self->{Translation}->{'ConfigItem Tree View'} = 'ConfigItem Tree skats';
    $Self->{Translation}->{'ConfigItem Version'} = 'ConfigItem Versija';
    $Self->{Translation}->{'ConfigItems of the following classes will not be stored on the Elasticsearch server. To apply this to existing CIs, the CI migration has to be run via console, after changing this option.'} =
        'Šādu klašu ConfigItems netiks saglabāti Elasticsearch serverī. Lai to piemērotu esošajiem CI, pēc šīs opcijas maiņas CI migrācija ir jāveic, izmantojot konsoli.';
    $Self->{Translation}->{'ConfigItems with the following deployment states will not be stored on the Elasticsearch server. To apply this to existing CIs, the CI migration has to be run via console, after changing this option.'} =
        'ConfigItems ar šādiem izvietošanas stāvokļiem netiks saglabāti Elasticsearch serverī. Lai to piemērotu esošajiem CI, pēc šīs opcijas maiņas CI migrācija ir jāveic, izmantojot konsoli.';
    $Self->{Translation}->{'Configuration Item Limit'} = 'Konfigurācijas vienuma ierobežojums';
    $Self->{Translation}->{'Configuration Item limit per page.'} = 'Konfigurācijas vienuma ierobežojums vienā lapā.';
    $Self->{Translation}->{'Configuration Management Database.'} = 'Konfigurācijas pārvaldības datubāze.';
    $Self->{Translation}->{'Configuration item bulk module.'} = 'Konfigurācijas elementa liela apjoma modulis.';
    $Self->{Translation}->{'Configuration item search backend router of the agent interface.'} =
        'Konfigurācijas elementa meklēšana aģenta interfeisa aizmugurējā maršrutētājā.';
    $Self->{Translation}->{'Create and manage the definitions for Configuration Items.'} = 'Izveidot un pārvaldīt konfigurācijas elementu definīcijas.';
    $Self->{Translation}->{'Creates Tickets for ConfigItems at specific time points.'} = 'Izveido ConfigItems biļetes konkrētos laika punktos.';
    $Self->{Translation}->{'Customers can see historic CI versions.'} = 'Klienti var skatīt vēsturiskās CI versijas.';
    $Self->{Translation}->{'Customers have the possibility to manually switch between historic CI versions.'} =
        'Klientiem ir iespēja manuāli pārslēgties starp vēsturiskajām CI versijām.';
    $Self->{Translation}->{'Default data to use on attribute for config item search screen. Example: "ITSMConfigItemCreateTimePointFormat=year;ITSMConfigItemCreateTimePointStart=Last;ITSMConfigItemCreateTimePoint=2;".'} =
        'Noklusējuma dati, kas izmantojami atribūta konfigurācijas elementu meklēšanas ekrānā. Piemērs: "ITSMConfigItemCreateTimePointFormat=year;ITSMConfigItemCreateTimePointStart=Last;ITSMConfigItemCreateTimePoint=2;".';
    $Self->{Translation}->{'Default data to use on attribute for config item search screen. Example: "ITSMConfigItemCreateTimeStartYear=2010;ITSMConfigItemCreateTimeStartMonth=10;ITSMConfigItemCreateTimeStartDay=4;ITSMConfigItemCreateTimeStopYear=2010;ITSMConfigItemCreateTimeStopMonth=11;ITSMConfigItemCreateTimeStopDay=3;".'} =
        'Noklusējuma dati, kas izmantojami atribūta konfigurācijas elementu meklēšanas ekrānā. Piemērs: "ITSMConfigItemCreateTimeStartYear=2010;ITSMConfigItemCreateTimeStartMonth=10;ITSMConfigItemCreateTimeStartDay=4;ITSMConfigItemCreateTimeStopYear=2010;ITSMConfigItemCreateTimeStopMonth=11;ITSMConfigItemCreateTimeStopDay=3;".';
    $Self->{Translation}->{'Define Actions where a settings button is available in the linked objects widget (LinkObject::ViewMode = "complex"). Please note that these Actions must have registered the following JS and CSS files: Core.AllocationList.css, Core.UI.AllocationList.js, Core.UI.Table.Sort.js, Core.Agent.TableFilters.js and Core.Agent.LinkObject.js.'} =
        'Definēt Darbības, kurās piesaistīto objektu logrīkā ir pieejama iestatījumu poga (LinkObject::ViewMode = "complex"). Lūdzu, ņemiet vērā, ka šīm darbībām ir jābūt reģistrētiem šādiem JS un CSS failiem: Core.AllocationList.css, Core.UI.AllocationList.js, Core.UI.Table.Sort.js, Core.Agent.TableFilters.js un Core.Agent.LinkObject.js.';
    $Self->{Translation}->{'Define a Template::Toolkit scheme for version strings. Only used if Version String Module is set to TemplateToolkit.'} =
        'Definēt Template::Toolkit shēmu versiju virknēm. Izmanto tikai tad, ja versijas virknes modulis ir iestatīts uz TemplateToolkit.';
    $Self->{Translation}->{'Define a set of conditions under which a customer is allowed to see a config item. Conditions can optionally be restricted to certain customer groups. Name is the only mandatory attribute. If no other options are given, all config items will be visible under that category.'} =
        'Nosakiet nosacījumu kopumu, saskaņā ar kuriem klientam ir atļauts skatīt konfigurācijas elementu. Nosacījumus pēc izvēles var ierobežot līdz noteiktām klientu grupām. Nosaukums ir vienīgais obligātais atribūts. Ja nav norādītas citas opcijas, šajā kategorijā būs redzami visi konfigurācijas elementi.';
    $Self->{Translation}->{'Defines Required permissions to create ITSM configuration items using the Generic Interface.'} =
        'Definē Nepieciešamās atļaujas ITSM konfigurācijas elementu izveidei, izmantojot vispārējo saskarni.';
    $Self->{Translation}->{'Defines Required permissions to delete ITSM configuration items using the Generic Interface.'} =
        'Definē Nepieciešamās atļaujas ITSM konfigurācijas elementu dzēšanai, izmantojot vispārējo saskarni.';
    $Self->{Translation}->{'Defines Required permissions to get ITSM configuration items using the Generic Interface.'} =
        'Definē Nepieciešamās atļaujas, lai iegūtu ITSM konfigurācijas elementus, izmantojot vispārējo saskarni.';
    $Self->{Translation}->{'Defines Required permissions to search ITSM configuration items using the Generic Interface.'} =
        'Definē Nepieciešamās atļaujas ITSM konfigurācijas elementu meklēšanai, izmantojot vispārējo saskarni.';
    $Self->{Translation}->{'Defines Required permissions to update ITSM configuration items using the Generic Interface.'} =
        'Definē Nepieciešamās atļaujas ITSM konfigurācijas elementu atjaunināšanai, izmantojot vispārējo saskarni.';
    $Self->{Translation}->{'Defines an overview module to show the small view of a configuration item list.'} =
        'Definē pārskata moduli, lai parādītu konfigurācijas elementu saraksta mazo skatu.';
    $Self->{Translation}->{'Defines if the link type labels must be shown in the node connections.'} =
        'Nosaka, vai mezglu savienojumos ir jānorāda saites tipa etiķetes.';
    $Self->{Translation}->{'Defines regular expressions individually for each ConfigItem class to check the ConfigItem name and to show corresponding error messages.'} =
        'Definē regulārās izteiksmes katrai ConfigItem klasei atsevišķi, lai pārbaudītu ConfigItem nosaukumu un parādītu atbilstošos kļūdas ziņojumus.';
    $Self->{Translation}->{'Defines the available columns of CIs in the config item overview depending on the CI class. Each entry must consist of a class name and an array of available fields for the corresponding class. Dynamic field entries have to honor the scheme DynamicField_FieldName.'} =
        'Nosaka pieejamās CI kolonnas konfigurācijas elementu pārskatā atkarībā no CI klases. Katram ierakstam jāsastāv no klases nosaukuma un attiecīgās klases pieejamo lauku masīva. Dinamisko lauku ierakstos jāievēro shēma DynamicField_FieldName.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of the agent interface.'} =
        'Nosaka noklusējuma konfigurācijas vienuma atribūtu konfigurācijas vienumu šķirošanai aģenta saskarnes konfigurācijas vienumu meklēšanas rezultātos.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of the customer interface.'} =
        'Nosaka noklusējuma konfigurācijas vienuma atribūtu klienta saskarnes konfigurācijas vienumu meklēšanas rezultātu šķirošanai.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of this operation.'} =
        'Nosaka noklusējuma konfigurācijas vienuma atribūtu šīs operācijas konfigurācijas vienuma meklēšanas rezultāta konfigurācijas vienuma šķirošanai.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the agent interface. Up: oldest on top. Down: latest on top.'} =
        'Nosaka noklusējuma konfigurācijas elementu secību aģenta saskarnes konfigurācijas elementu meklēšanas rezultātos. Augšup: vecākais ir augšpusē. Uz leju: jaunākais augšpusē.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the customer interface. Up: oldest on top. Down: latest on top.'} =
        'Nosaka noklusējuma konfigurācijas elementu secību klienta saskarnes konfigurācijas elementu meklēšanas rezultātos. Uz augšu: vecākais ir augšpusē. Uz leju: jaunākais augšpusē.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the this operation. Up: oldest on top. Down: latest on top.'} =
        'Nosaka noklusējuma konfigurācijas elementu secību šīs operācijas konfigurācijas elementu meklēšanas rezultātā. Uz augšu: vecākais uz augšu. Uz leju: jaunākais augšpusē.';
    $Self->{Translation}->{'Defines the default displayed columns of CIs in the config item overview depending on the CI class. Each entry must consist of a class name and an array of available fields for the corresponding class. Dynamic field entries have to honor the scheme DynamicField_FieldName.'} =
        'Nosaka noklusējuma rādītās CI kolonnas konfigurācijas elementu pārskatā atkarībā no CI klases. Katram ierakstam jāsastāv no klases nosaukuma un attiecīgās klases pieejamo lauku masīva. Dinamisko lauku ierakstos jāievēro shēma DynamicField_FieldName.';
    $Self->{Translation}->{'Defines the default relations depth to be shown.'} = 'Nosaka pēc noklusējuma rādāmo attiecību dziļumu.';
    $Self->{Translation}->{'Defines the default shown config item search attribute for config item search screen.'} =
        'Nosaka noklusējuma rādīto konfigurācijas elementu meklēšanas atribūtu konfigurācijas elementu meklēšanas ekrānam.';
    $Self->{Translation}->{'Defines the default shown config item search attribute for config item search screen. Example: "Key" must have the name of the Dynamic Field in this case \'X\', "Content" must have the value of the Dynamic Field depending on the Dynamic Field type,  Text: \'a text\', Dropdown: \'1\', Date/Time: \'Search_DynamicField_XTimeSlotStartYear=1974; Search_DynamicField_XTimeSlotStartMonth=01; Search_DynamicField_XTimeSlotStartDay=26; Search_DynamicField_XTimeSlotStartHour=00; Search_DynamicField_XTimeSlotStartMinute=00; Search_DynamicField_XTimeSlotStartSecond=00; Search_DynamicField_XTimeSlotStopYear=2013; Search_DynamicField_XTimeSlotStopMonth=01; Search_DynamicField_XTimeSlotStopDay=26; Search_DynamicField_XTimeSlotStopHour=23; Search_DynamicField_XTimeSlotStopMinute=59; Search_DynamicField_XTimeSlotStopSecond=59;\' and or \'Search_DynamicField_XTimePointFormat=week; Search_DynamicField_XTimePointStart=Before; Search_DynamicField_XTimePointValue=7\';.'} =
        'Nosaka noklusējuma rādīto konfigurācijas elementu meklēšanas atribūtu konfigurācijas elementu meklēšanas ekrānam. Piemērs: "Key" jābūt dinamiskā lauka nosaukumam, šajā gadījumā "X", "Content" jābūt dinamiskā lauka vērtībai atkarībā no dinamiskā lauka tipa, Text: "a text", Dropdown: "1", Date/Time: "Search_DynamicField_XTimeSlotStartYear=1974; Search_DynamicField_XTimeSlotStartMonth=01; Search_DynamicField_XTimeSlotStartDay=26; Search_DynamicField_XTimeSlotStartHour=00; Search_DynamicField_XTimeSlotStartMinute=00; Search_DynamicField_XTimeSlotStartSecond=00; Search_DynamicField_XTimeSlotStopYear=2013; Search_DynamicField_XTimeSlotStopMonth=01; Search_DynamicField_XTimeSlotStopDay=26; Search_DynamicField_XTimeSlotStopHour=23; Search_DynamicField_XTimeSlotStopMinute=59; Search_DynamicField_XTimeSlotStopSecond=59;\' un vai \'Search_DynamicField_XTimePointFormat=week; Search_DynamicField_XTimePointStart=Before; Search_DynamicField_XTimePointValue=7\';.';
    $Self->{Translation}->{'Defines the default subobject of the class \'ITSMConfigItem\'.'} =
        'Definē klases "ITSMConfigItem" noklusējuma apakšobjektu.';
    $Self->{Translation}->{'Defines the initial height for the rich text editor component in pixels.'} =
        '';
    $Self->{Translation}->{'Defines the number of rows for the CI definition editor in the admin interface.'} =
        'Nosaka rindu skaitu CI definīciju redaktoram administratora saskarnē.';
    $Self->{Translation}->{'Defines the order of incident states from high (e.g. cricital) to low (e.g. functional).'} =
        'Nosaka incidentu stāvokļu secību no augsta (piemēram, cricital) līdz zemam (piemēram, funkcionāls).';
    $Self->{Translation}->{'Defines the relevant deployment states where linked tickets can affect the status of a CI.'} =
        'Definē attiecīgos izvietošanas stāvokļus, kuros saistītās biļetes var ietekmēt KI statusu.';
    $Self->{Translation}->{'Defines the search limit for the AgentITSMConfigItem screen.'} =
        'Nosaka meklēšanas ierobežojumu ekrānam AgentITSMConfigItem.';
    $Self->{Translation}->{'Defines the search limit for the AgentITSMConfigItemSearch screen.'} =
        'Nosaka meklēšanas ierobežojumu ekrānam AgentITSMConfigItemSearch.';
    $Self->{Translation}->{'Defines the search limit for the CustomerITSMConfigItem screen.'} =
        'Nosaka meklēšanas ierobežojumu ekrānam CustomerITSMConfigItem.';
    $Self->{Translation}->{'Defines the search limit for the CustomerITSMConfigItemSearch screen.'} =
        'Nosaka meklēšanas ierobežojumu ekrānam CustomerITSMConfigItemSearch.';
    $Self->{Translation}->{'Defines the shown columns of CIs in the link table complex view for all CI classes. If there is no entry, then the default columns are shown.'} =
        'Definē parādītās CI kolonnas saišu tabulas sarežģītajā skatā visām CI klasēm. Ja nav ieraksta, tiek parādītas noklusējuma kolonnas.';
    $Self->{Translation}->{'Defines the shown columns of CIs in the link table complex view, depending on the CI class. Each entry must be prefixed with the class name and double colons (i.e. Computer::). There are a few CI-Attributes that common to all CIs (example for the class Computer: Computer::Name, Computer::CurDeplState, Computer::CreateTime). To show individual CI-Attributes as defined in the CI-Definition, the following scheme must be used (example for the class Computer): Computer::HardDisk::1, Computer::HardDisk::1::Capacity::1, Computer::HardDisk::2, Computer::HardDisk::2::Capacity::1. If there is no entry for a CI class, then the default columns are shown.'} =
        'Definē parādītās CI kolonnas saišu tabulas sarežģītajā skatā atkarībā no CI klases. Katram ierakstam jābūt ar prefiksu klases nosaukumam un dubultiem divpunktu komutatoriem (t. i., Computer::). Ir daži CI atribūti, kas ir kopīgi visiem CI (piemērs klasei Computer: Computer::Name, Computer::CurDeplState, Computer::CreateTime). Lai parādītu atsevišķus CI atribūtus, kas definēti CI definīcijā, jāizmanto šāda shēma (piemērs klasei Computer): Computer::HardDisk::1, Computer::HardDisk::1::Capacity::1, Computer::HardDisk::2, Computer::HardDisk::2::Capacity::1. Ja nav ieraksta par CI klasi, tiek parādītas noklusējuma kolonnas.';
    $Self->{Translation}->{'Defines which items are available for \'Action\' in third level of the ITSM Config Item ACL structure.'} =
        'Nosaka, kuri elementi ir pieejami "Action" ITSM Config Item ACL struktūras trešajā līmenī.';
    $Self->{Translation}->{'Defines which items are available in first level of the ITSM Config Item ACL structure.'} =
        'Nosaka, kuri elementi ir pieejami ITSM Config Item ACL struktūras pirmajā līmenī.';
    $Self->{Translation}->{'Defines which items are available in second level of the ITSM Config Item ACL structure.'} =
        'Nosaka, kuri elementi ir pieejami ITSM Config Item ACL struktūras otrajā līmenī.';
    $Self->{Translation}->{'Defines which type of link (named from the ticket perspective) can affect the status of a linked CI.'} =
        'Nosaka, kāda veida saite (nosaukta no biļetes perspektīvas) var ietekmēt saistītās CI statusu.';
    $Self->{Translation}->{'Defines which type of ticket can affect the status of a linked CI.'} =
        'Nosaka, kāda veida biļete var ietekmēt saistītās CI statusu.';
    $Self->{Translation}->{'Definition Update'} = 'Definīcijas atjaunināšana';
    $Self->{Translation}->{'Delete Configuration Item'} = 'Konfigurācijas elementa dzēšana';
    $Self->{Translation}->{'DeplState'} = 'DeplState';
    $Self->{Translation}->{'Deployment State Color'} = 'Izvietošanas valsts krāsa';
    $Self->{Translation}->{'DeploymentState'} = 'DeploymentState';
    $Self->{Translation}->{'Duplicate'} = 'Dublikāts';
    $Self->{Translation}->{'Dynamic field event module that marks config item definitions as out of sync, if containing dynamic fields change.'} =
        'Dinamisko lauku notikumu modulis, kas atzīmē konfigurācijas elementu definīcijas kā nesinhronizētas, ja mainās dinamiskie lauki.';
    $Self->{Translation}->{'Dynamic fields shown in the additional ITSM field screen of the agent interface.'} =
        'Dinamiskie lauki, kas redzami aģenta saskarnes papildu ITSM lauka ekrānā.';
    $Self->{Translation}->{'Dynamic fields shown in the config item overview screen of the customer interface.'} =
        'Dinamiskie lauki, kas redzami klienta saskarnes konfigurācijas elementu pārskata ekrānā.';
    $Self->{Translation}->{'Dynamic fields shown in the config item search screen of the agent interface.'} =
        'Dinamiskie lauki, kas redzami aģenta saskarnes konfigurācijas elementu meklēšanas ekrānā.';
    $Self->{Translation}->{'Enables configuration item bulk action feature for the agent frontend to work on more than one configuration item at a time.'} =
        'Iespējo konfigurācijas vienuma masveida darbību funkciju, lai aģenta frontendā varētu strādāt ar vairāk nekā vienu konfigurācijas vienumu vienlaikus.';
    $Self->{Translation}->{'Enables configuration item bulk action feature only for the listed groups.'} =
        'Ieslēdz konfigurācijas elementu masveida darbību funkciju tikai uzskaitītajām grupām.';
    $Self->{Translation}->{'Enables/disables the functionality to check ITSM onfiguration items for unique names. Before enabling this option you should check your system for already existing config items with duplicate names. You can do this with the console command Admin::ITSM::Configitem::ListDuplicates.'} =
        'Ieslēdz/izslēdz funkcionalitāti, lai pārbaudītu ITSM konfigurācijas elementu unikālos nosaukumus. Pirms šīs opcijas ieslēgšanas jāpārbauda, vai jūsu sistēmā nav jau esošu konfigurācijas elementu ar dublējošiem nosaukumiem. To var izdarīt ar konsoles komandu Admin::ITSM::Configitem::ListDuplicates.';
    $Self->{Translation}->{'Event module to set configitem-status on ticket-configitem-link.'} =
        'Notikumu modulis, lai iestatītu configitem-status uz ticket-configitem-link.';
    $Self->{Translation}->{'Fields of the configuration item index, used for the fulltext search. Fields are also stored, but are not mandatory for the overall functionality. Inclusion of attachments can be disabled by setting the entry to 0 or deleting it.'} =
        'Konfigurācijas elementu indeksa lauki, kas tiek izmantoti pilnteksta meklēšanai. Lauki arī tiek saglabāti, bet tie nav obligāti kopējai funkcionalitātei. Pielikumu iekļaušanu var atspējot, iestatot ierakstam vērtību 0 vai dzēšot to.';
    $Self->{Translation}->{'Fields stored in the configuration item index which are used for other things besides fulltext searches. For the complete functionality all fields are mandatory.'} =
        'Konfigurācijas elementu indeksā saglabātie lauki, kas tiek izmantoti ne tikai pilnteksta meklēšanai, bet arī citām lietām. Pilnīgai funkcionalitātei visi lauki ir obligāti.';
    $Self->{Translation}->{'For every webservice (key) an array of classes (value) can be defined on which the import is restricted. For all chosen classes, or all existing classes the identifying attributes will have to be chosen in the invoker config.'} =
        'Katrai tīmekļa pakalpojumam (atslēga) var definēt klašu masīvu (vērtība), uz kuru imports ir ierobežots. Visām izvēlētajām klasēm vai visām esošajām klasēm invokera konfigurācijā būs jāizvēlas identificējošie atribūti.';
    $Self->{Translation}->{'GenericInterface module registration for the ConfigItemFetch invoker layer.'} =
        'GenericInterface moduļa reģistrācija ConfigItemFetch invokatora slānim.';
    $Self->{Translation}->{'ITSM ConfigItem'} = 'ITSM ConfigItem';
    $Self->{Translation}->{'ITSM config item overview.'} = 'ITSM konfigurācijas elementu pārskats.';
    $Self->{Translation}->{'If this option is activated, linked items are only counted if they belong to one of the listed classes.'} =
        'Ja šī opcija ir aktivizēta, saistītie vienumi tiek ieskaitīti tikai tad, ja tie pieder kādai no uzskaitītajām klasēm.';
    $Self->{Translation}->{'InciState'} = 'InciState';
    $Self->{Translation}->{'IncidentState'} = 'IncidentState';
    $Self->{Translation}->{'Includes deployment states in the config item search of the customer interface.'} =
        'Iekļauj izvietošanas stāvokļus klienta saskarnes konfigurācijas elementu meklēšanā.';
    $Self->{Translation}->{'Includes incident states in the config item search of the customer interface.'} =
        'Ietver incidentu stāvokļus klienta saskarnes konfigurācijas elementu meklēšanā.';
    $Self->{Translation}->{'Maximum number of config items to be displayed in the result of this operation.'} =
        'Maksimālais konfigurācijas elementu skaits, kas tiks parādīts šīs operācijas rezultātā.';
    $Self->{Translation}->{'Module to check the group responsible for a class.'} = 'Modulis, lai pārbaudītu par klasi atbildīgo grupu.';
    $Self->{Translation}->{'Module to check the group responsible for a configuration item.'} =
        'Modulis, lai pārbaudītu grupu, kas ir atbildīga par konfigurācijas elementu.';
    $Self->{Translation}->{'Module to generate ITSM config item statistics.'} = 'Modulis, lai ģenerētu ITSM konfigurācijas elementu statistiku.';
    $Self->{Translation}->{'Name Module'} = 'Nosaukums Modulis';
    $Self->{Translation}->{'Number Module'} = 'Numuru modulis';
    $Self->{Translation}->{'Number of config items to be displayed in each page of a search result in the agent interface.'} =
        'Konfigurācijas elementu skaits, kas tiks parādīts katrā meklēšanas rezultātu lapā aģenta saskarnē.';
    $Self->{Translation}->{'Number of config items to be displayed in each page of a search result in the customer interface.'} =
        'Konfigurācijas elementu skaits, kas tiks parādīts katrā meklēšanas rezultātu lapā klienta saskarnē.';
    $Self->{Translation}->{'Objects to search for, how many entries and which attributs to show. ConfigItem attributes have to explicitly be stored via Elasticsearch.'} =
        'Objekti, kurus meklēt, cik ierakstu un kādus atribūtus parādīt. ConfigItem atribūti ir skaidri jāuzglabā, izmantojot Elasticsearch.';
    $Self->{Translation}->{'Overview.'} = 'Pārskats.';
    $Self->{Translation}->{'Parameters for the categories for config item classes in the preferences view of the agent interface.'} =
        'Parametri konfigurācijas elementu klašu kategoriju kategorijām aģenta saskarnes preferenču skatā.';
    $Self->{Translation}->{'Parameters for the column filters of the small config item overview. Please note: setting \'Active\' to 0 will only prevent agents from editing settings of this group in their personal preferences, but will still allow administrators to edit the settings of another user\'s behalf. Use \'PreferenceGroup\' to control in which area these settings should be shown in the user interface.'} =
        'Parametri mazā konfigurācijas elementu pārskata kolonnu filtriem. Lūdzu, ņemiet vērā: iestatot "Aktīvs" uz 0, aģenti nevarēs rediģēt tikai šīs grupas iestatījumus savās personīgajās preferencēs, bet administratori joprojām varēs rediģēt cita lietotāja iestatījumus savā vārdā. Izmantojiet "PreferenceGroup", lai kontrolētu, kurā apgabalā šie iestatījumi būtu redzami lietotāja saskarnē.';
    $Self->{Translation}->{'Parameters for the dashboard backend of the customer company config item overview of the agent interface . "Limit" is the number of entries shown by default. "Group" is used to restrict the access to the plugin (e. g. Group: admin;group1;group2;). "Default" determines if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" is the cache time in minutes for the plugin.'} =
        'Parametri, kas attiecas uz klienta uzņēmuma aģenta interfeisa konfigurācijas elementu pārskata paneļa backend . "Limit" (Ierobežot) ir pēc noklusējuma rādīto ierakstu skaits. "Group" (Grupa) izmanto, lai ierobežotu piekļuvi spraudnim (piemēram, Group: admin;group1;group2;). "Default" (Pēc noklusējuma) nosaka, vai spraudnis ir ieslēgts pēc noklusējuma, vai arī lietotājam tas jāieslēdz manuāli. "CacheTTLLocal" (CacheTTLLocal) ir spraudņa kešēšanas laiks minūtēs.';
    $Self->{Translation}->{'Parameters for the deployment states color in the preferences view of the agent interface.'} =
        'Parametri izvietošanas stāvokļu krāsai aģenta saskarnes preferenču skatā.';
    $Self->{Translation}->{'Parameters for the deployment states in the preferences view of the agent interface.'} =
        'Izvietošanas stāvokļu parametri aģenta saskarnes preferenču skatā.';
    $Self->{Translation}->{'Parameters for the example permission groups of the general catalog attributes.'} =
        'Vispārīgo kataloga atribūtu atļauju grupu piemēru parametri.';
    $Self->{Translation}->{'Parameters for the name module for config item classes in the preferences view of the agent interface.'} =
        'Parametri nosaukuma moduļa parametriem konfigurācijas elementu klasēm aģenta saskarnes preferenču skatā.';
    $Self->{Translation}->{'Parameters for the number module for config item classes in the preferences view of the agent interface.'} =
        'Parametri konfigurācijas elementu klašu numuru moduļa parametriem aģenta saskarnes preferenču skatā.';
    $Self->{Translation}->{'Parameters for the pages (in which the configuration items are shown).'} =
        'Lapu (kurās tiek parādīti konfigurācijas elementi) parametri.';
    $Self->{Translation}->{'Parameters for the version string module for config item classes in the preferences view of the agent interface.'} =
        'Parametri versijas virknes moduļa parametriem konfigurācijas elementu klasēm aģenta interfeisa preferenču skatā.';
    $Self->{Translation}->{'Parameters for the version string template toolkit module for config item classes in the preferences view of the agent interface.'} =
        'Parametri versijas virknes šablona rīku kopuma moduļa parametriem konfigurācijas elementu klasēm aģenta saskarnes preferenču skatā.';
    $Self->{Translation}->{'Parameters for the version trigger for config item classes in the preferences view of the agent interface.'} =
        'Parametri versijas trigerim konfigurācijas elementu klašu konfigurācijas elementu klasēm aģenta interfeisa preferenču skatā.';
    $Self->{Translation}->{'Performs the configured action for each event (as an Invoker) for each configured Webservice.'} =
        'Veic konfigurēto darbību katram notikumam (kā Invoker) katrai konfigurētajai tīmekļa pakalpojumam.';
    $Self->{Translation}->{'Permission Group'} = 'Atļauju grupa';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item attachment action in the agent interface.'} =
        'Nepieciešamās atļaujas, lai izmantotu ITSM konfigurācijas elementa pievienošanas darbību aģenta saskarnē.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item screen in the agent interface.'} =
        'Nepieciešamās atļaujas, lai izmantotu ITSM konfigurācijas elementu ekrānu aģenta saskarnē.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item search screen in the agent interface.'} =
        'Nepieciešamās atļaujas, lai izmantotu ITSM konfigurācijas elementu meklēšanas ekrānu aģenta saskarnē.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item search screen in the customer interface.'} =
        'Nepieciešamās atļaujas, lai izmantotu ITSM konfigurācijas elementu meklēšanas ekrānu klienta saskarnē.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item tree view screen in the agent interface.'} =
        'Nepieciešamās atļaujas, lai izmantotu ITSM konfigurācijas elementu koka skatījuma ekrānu aģenta saskarnē.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item zoom screen in the agent interface.'} =
        'Nepieciešamās atļaujas, lai izmantotu ITSM konfigurācijas elementu tālummaiņas ekrānu aģenta saskarnē.';
    $Self->{Translation}->{'Required permissions to use the add ITSM configuration item screen in the agent interface.'} =
        'Nepieciešamās atļaujas, lai izmantotu ITSM konfigurācijas elementu pievienošanas ekrānu aģenta saskarnē.';
    $Self->{Translation}->{'Required permissions to use the bulk ITSM configuration item screen in the agent interface.'} =
        'Nepieciešamās atļaujas, lai aģenta saskarnē izmantotu masveida ITSM konfigurācijas elementu ekrānu.';
    $Self->{Translation}->{'Required permissions to use the edit ITSM configuration item screen in the agent interface.'} =
        'Nepieciešamās atļaujas, lai izmantotu ITSM konfigurācijas elementu rediģēšanas ekrānu aģenta saskarnē.';
    $Self->{Translation}->{'Required permissions to use the history ITSM configuration item screen in the agent interface.'} =
        'Nepieciešamās atļaujas, lai aģenta saskarnē izmantotu ekrānu History ITSM configuration item.';
    $Self->{Translation}->{'Required permissions to use the print ITSM configuration item screen in the agent interface.'} =
        'Nepieciešamās atļaujas, lai aģenta saskarnē izmantotu ekrānu drukāt ITSM konfigurācijas elementu.';
    $Self->{Translation}->{'Required privileges to delete config items.'} = 'Nepieciešamās privilēģijas konfigurācijas elementu dzēšanai.';
    $Self->{Translation}->{'Search config items.'} = 'Meklēt konfigurācijas vienumus.';
    $Self->{Translation}->{'Set the incident state of a CI automatically when a Ticket is Linked to a CI.'} =
        'Automātiski iestatiet KI incidenta stāvokli, kad biļete ir saistīta ar KI.';
    $Self->{Translation}->{'Sets the deployment state in the configuration item bulk screen of the agent interface.'} =
        'Iestata izvietošanas stāvokli aģenta interfeisa konfigurācijas elementu kopuma ekrānā.';
    $Self->{Translation}->{'Sets the incident state in the configuration item bulk screen of the agent interface.'} =
        'Iestata incidenta stāvokli aģenta interfeisa konfigurācijas vienuma kopuma ekrānā.';
    $Self->{Translation}->{'Shows a link in the menu that allows linking a configuration item with another object in the config item zoom view of the agent interface.'} =
        'Tiek parādīta saite izvēlnē, kas ļauj savienot konfigurācijas elementu ar citu objektu aģenta interfeisa konfigurācijas elementa tālummaiņas skatā.';
    $Self->{Translation}->{'Shows a link in the menu to access the history of a configuration item in the configuration item overview of the agent interface.'} =
        'Rāda saiti izvēlnē, lai piekļūtu konfigurācijas elementa vēsturei aģenta saskarnes konfigurācijas elementu pārskatā.';
    $Self->{Translation}->{'Shows a link in the menu to access the history of a configuration item in the its zoom view of the agent interface.'} =
        'Rāda saiti izvēlnē, lai piekļūtu konfigurācijas elementa vēsturei aģenta saskarnes tālummaiņas skatā.';
    $Self->{Translation}->{'Shows a link in the menu to delete a configuration item in its zoom view of the agent interface.'} =
        'Rāda saiti izvēlnē, lai dzēstu konfigurācijas elementu aģenta saskarnes tālummaiņas skatā.';
    $Self->{Translation}->{'Shows a link in the menu to display the configuration item links as a Tree View.'} =
        'Rāda saiti izvēlnē, lai konfigurācijas elementu saites tiktu parādītas kā Koku skats.';
    $Self->{Translation}->{'Shows a link in the menu to duplicate a configuration item in the configuration item overview of the agent interface.'} =
        'Rāda saiti izvēlnē, lai dublētu konfigurācijas elementu aģenta saskarnes konfigurācijas elementu pārskatā.';
    $Self->{Translation}->{'Shows a link in the menu to duplicate a configuration item in the its zoom view of the agent interface.'} =
        'Tiek parādīta saite izvēlnē, lai dublētu konfigurācijas elementu aģenta saskarnes tālummaiņas skatā.';
    $Self->{Translation}->{'Shows a link in the menu to edit a configuration item in the its zoom view of the agent interface.'} =
        'Rāda saiti izvēlnē, lai rediģētu konfigurācijas elementu aģenta saskarnes tālummaiņas skatā.';
    $Self->{Translation}->{'Shows a link in the menu to go back in the configuration item zoom view of the agent interface.'} =
        'Tiek parādīta saite izvēlnē, lai atgrieztos atpakaļ aģenta saskarnes konfigurācijas elementu tālummaiņas skatā.';
    $Self->{Translation}->{'Shows a link in the menu to print a configuration item in the its zoom view of the agent interface.'} =
        'Rāda saiti izvēlnē, lai izdrukātu konfigurācijas elementu aģenta saskarnes tālummaiņas skatā.';
    $Self->{Translation}->{'Shows a link in the menu to zoom into a configuration item in the configuration item overview of the agent interface.'} =
        'Rāda saiti izvēlnē, lai palielinātu konfigurācijas elementu aģenta interfeisa konfigurācijas elementu pārskatā.';
    $Self->{Translation}->{'Shows the config item history (reverse ordered) in the agent interface.'} =
        'Rāda konfigurācijas elementu vēsturi (sakārtotu apgrieztā secībā) aģenta saskarnē.';
    $Self->{Translation}->{'The default category which is shown, if none is selected.'} = 'Noklusējuma kategorija, kas tiek rādīta, ja nav izvēlēta neviena.';
    $Self->{Translation}->{'The identifier for a configuration item, e.g. ConfigItem#, MyConfigItem#. The default is ConfigItem#.'} =
        'Konfigurācijas elementa identifikators, piemēram, ConfigItem#, MyConfigItem#. Pēc noklusējuma ir ConfigItem#.';
    $Self->{Translation}->{'Triggers ConfigItemFetch invoker automatically.'} = 'Automātiski iedarbina ConfigItemFetch invokatoru.';
    $Self->{Translation}->{'Version String Expression'} = 'Versija Virknes virknes izteiksme';
    $Self->{Translation}->{'Version String Module'} = 'Versijas virknes modulis';
    $Self->{Translation}->{'Version Trigger'} = 'Versija Trigger';
    $Self->{Translation}->{'Whether the execution of ConfigItemACL can be avoided by checking cached field dependencies. This can improve loading times of formulars, but has to be disabled, if ACLModules are to be used for ITSMConfigItem- and Form-ReturnTypes.'} =
        'Vai ConfigItemACL izpildi var novērst, pārbaudot kešatmiņā esošo lauku atkarības. Tas var uzlabot veidlapu ielādes laiku, bet tas ir jāatslēdz, ja ACLModules ir jāizmanto ITSMConfigItem- un Form-ReturnTypes.';
    $Self->{Translation}->{'Which general information is shown in the header.'} = 'Kāda vispārīga informācija ir norādīta galvenē.';
    $Self->{Translation}->{'With this option it´s possible to fill automaticly a CI field, depending on the count of linked CI´s with the existing type DependsOn.'} =
        'Izmantojot šo opciju, ir iespējams automātiski aizpildīt CI lauku atkarībā no piesaistīto CI skaita ar esošo tipu DependsOn.';
    $Self->{Translation}->{'With this option it´s possible to fill automaticly a CI field, depending on the count of linked CI´s.'} =
        'Izmantojot šo opciju, ir iespējams automātiski aizpildīt CI lauku atkarībā no piesaistīto CI skaita.';
    $Self->{Translation}->{'With this option it´s possible to fill automaticly a CI field, depending on the count of linked CI´s. The setting CounterClassName include the name of the class and CounterFieldName is used to store the count of used licence.'} =
        'Izmantojot šo opciju, ir iespējams automātiski aizpildīt CI lauku atkarībā no piesaistīto CI skaita. Iestatījums CounterClassName (skaitītāja klases nosaukums) ietver klases nosaukumu, bet CounterFieldName (skaitītāja lauka nosaukums) tiek izmantots, lai saglabātu izmantoto licenču skaitu.';
    $Self->{Translation}->{'class'} = 'klase';
    $Self->{Translation}->{'global'} = 'globālā';
    $Self->{Translation}->{'postproductive'} = 'postproduktīvo';
    $Self->{Translation}->{'preproductive'} = 'pirms reproduktīvā perioda';
    $Self->{Translation}->{'productive'} = 'produktīvs';


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

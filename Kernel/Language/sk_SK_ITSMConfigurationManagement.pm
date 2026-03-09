# --
# OTOBO is a web-based ticketing system for service organisations.
# --
# Copyright (C) 2001-2020 OTRS AG, https://otrs.com/
# Copyright (C) 2019-2026 Rother OSS GmbH, https://otobo.io/
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

package Kernel::Language::sk_SK_ITSMConfigurationManagement;

use strict;
use warnings;
use utf8;

sub Data {
    my $Self = shift;

    # Template: AdminGenericInterfaceOperationConfigItem
    $Self->{Translation}->{'General operation data'} = 'Všeobecné prevádzkové údaje';
    $Self->{Translation}->{'Settings for incoming request data'} = 'Nastavenia pre prichádzajúce údaje žiadosti';
    $Self->{Translation}->{'Settings for outgoing response data'} = 'Nastavenia pre údaje odchádzajúcej odpovede';

    # Template: AdminITSMConfigItem
    $Self->{Translation}->{'Config Item Management'} = 'Správa konfiguračných položiek';
    $Self->{Translation}->{'Change class definition'} = 'Zmena definície triedy';
    $Self->{Translation}->{'Change role definition'} = 'Zmena definície úlohy';
    $Self->{Translation}->{'Ready2Import Class Bundles'} = 'Balíky tried Ready2Import';
    $Self->{Translation}->{'Here you can import Ready2Import class bundles showcasing our most usual config items. Please note that some additional configuration may be required.'} =
        'Tu môžete importovať balíky tried Ready2Import, ktoré predstavujú naše najbežnejšie konfiguračné položky. Upozorňujeme, že môže byť potrebná dodatočná konfigurácia.';
    $Self->{Translation}->{'Update existing entities'} = 'Aktualizácia existujúcich subjektov';
    $Self->{Translation}->{'Import Ready2Adopt class bundles'} = 'Import zväzkov tried Ready2Adopt';
    $Self->{Translation}->{'Config Item Class'} = 'Trieda položky konfigurácie';
    $Self->{Translation}->{'Config Item Role'} = 'Úloha položky konfigurácie';

    # Template: AgentITSMConfigItemAdd
    $Self->{Translation}->{'Config Item'} = 'Položka konfigurácie';
    $Self->{Translation}->{'Filter for Classes'} = 'Filter pre triedy';
    $Self->{Translation}->{'Select a Class from the list to create a new Config Item.'} = 'Ak chcete vytvoriť novú položku konfigurácie, vyberte triedu zo zoznamu.';
    $Self->{Translation}->{'Class'} = 'Trieda';

    # Template: AgentITSMConfigItemBulk
    $Self->{Translation}->{'ITSM ConfigItem Bulk Action'} = 'Hromadná akcia ITSM ConfigItem';
    $Self->{Translation}->{'Deployment state'} = 'Stav nasadenia';
    $Self->{Translation}->{'Incident state'} = 'Stav incidentu';
    $Self->{Translation}->{'Link to another'} = 'Prepojenie na iný';
    $Self->{Translation}->{'Invalid Configuration Item number!'} = 'Nesprávne číslo konfiguračnej položky!';
    $Self->{Translation}->{'The number of another Configuration Item to link with.'} = 'Číslo inej položky konfigurácie, s ktorou sa má prepojiť.';

    # Template: AgentITSMConfigItemDelete
    $Self->{Translation}->{'Do you really want to delete this config item?'} = 'Naozaj chcete túto položku konfigurácie odstrániť?';

    # Template: AgentITSMConfigItemEdit
    $Self->{Translation}->{'The name of this config item'} = 'Názov tejto konfiguračnej položky';
    $Self->{Translation}->{'Name is already in use by the ConfigItems with the following Number(s): %s'} =
        'Názov sa už používa v položke ConfigItems s nasledujúcim číslom (číslami): %s';
    $Self->{Translation}->{'Version Number'} = 'Číslo verzie';
    $Self->{Translation}->{'Version number of this config item'} = 'Číslo verzie tejto položky konfigurácie';
    $Self->{Translation}->{'Version Number is already in use by the ConfigItems with the following Number(s): %s'} =
        'Číslo verzie sa už používa v položke ConfigItems s nasledujúcim číslom (číslami): %s';
    $Self->{Translation}->{'Deployment State'} = 'Stav nasadenia';
    $Self->{Translation}->{'Incident State'} = 'Stav incidentu';

    # Template: AgentITSMConfigItemHistory
    $Self->{Translation}->{'History of Config Item: %s'} = 'História položky konfigurácie: %s';
    $Self->{Translation}->{'History Content'} = 'Obsah histórie';
    $Self->{Translation}->{'Createtime'} = 'Createtime';
    $Self->{Translation}->{'Zoom view'} = 'Zväčšiť pohľad';

    # Template: AgentITSMConfigItemOverviewNavBar
    $Self->{Translation}->{'Config Items per page'} = 'Konfiguračné položky na stránku';

    # Template: AgentITSMConfigItemOverviewSmall
    $Self->{Translation}->{'No config item data found.'} = 'Nenašli sa žiadne údaje konfiguračnej položky.';
    $Self->{Translation}->{'Select this config item'} = 'Vyberte túto položku konfigurácie';

    # Template: AgentITSMConfigItemSearch
    $Self->{Translation}->{'Run Search'} = 'Spustiť vyhľadávanie';
    $Self->{Translation}->{'Also search in previous versions?'} = 'Vyhľadávanie aj v predchádzajúcich verziách?';

    # Template: AgentITSMConfigItemTreeView
    $Self->{Translation}->{'TreeView for ConfigItem'} = 'TreeView pre ConfigItem';
    $Self->{Translation}->{'Depth Level'} = 'Úroveň hĺbky';
    $Self->{Translation}->{'Zoom In/Out'} = 'Priblíženie/oddialenie';
    $Self->{Translation}->{'Max links level reached for ConfigItem!'} = 'Maximálna úroveň odkazov dosiahnutá pre ConfigItem!';

    # Template: AgentITSMConfigItemZoom
    $Self->{Translation}->{'Configuration Item'} = 'Položka konfigurácie';
    $Self->{Translation}->{'Configuration Item Information'} = 'Informácie o položke konfigurácie';
    $Self->{Translation}->{'Current Deployment State'} = 'Aktuálny stav nasadenia';
    $Self->{Translation}->{'Current Incident State'} = 'Aktuálny stav incidentu';
    $Self->{Translation}->{'Last changed'} = 'Posledná zmena';
    $Self->{Translation}->{'Last changed by'} = 'Naposledy zmenil';

    # Template: CustomerITSMConfigItem
    $Self->{Translation}->{'Your ConfigItems'} = 'Vaše položky ConfigItems';

    # Template: CustomerITSMConfigItemSearch
    $Self->{Translation}->{'ConfigItem Search'} = 'Vyhľadávanie položky ConfigItem';

    # Template: AdminACL
    $Self->{Translation}->{'Object Type'} = 'Typ objektu';

    # Template: AdminDynamicFieldScreen
    $Self->{Translation}->{'Filter by object type'} = '';

    # JS Template: ClassImportConfirm
    $Self->{Translation}->{'The following classes will be imported'} = 'Importujú sa tieto triedy';
    $Self->{Translation}->{'The following roles will be imported'} = 'Importujú sa tieto úlohy';
    $Self->{Translation}->{'Note that also corresponding dynamic fields and GeneralCatalog classes will be created and there is no automatic removal.'} =
        'Upozorňujeme, že sa vytvoria aj príslušné dynamické polia a triedy GeneralCatalog a nedôjde k ich automatickému odstráneniu.';
    $Self->{Translation}->{'Do you want to proceed?'} = 'Chcete pokračovať?';

    # Perl Module: Kernel/Modules/AdminITSMConfigItem.pm
    $Self->{Translation}->{'Need ExampleClasses!'} = 'Potrebujete príklady tried!';
    $Self->{Translation}->{'Definition is no valid YAML hash.'} = 'Definícia nie je platný hash YAML.';

    # Perl Module: Kernel/Modules/AgentITSMConfigItem.pm
    $Self->{Translation}->{'Overview: ITSM ConfigItem'} = 'Prehľad: ITSM ConfigItem';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemBulk.pm
    $Self->{Translation}->{'No ConfigItemID is given!'} = 'Nie je zadané žiadne ConfigItemID!';
    $Self->{Translation}->{'You need at least one selected Configuration Item!'} = 'Potrebujete aspoň jednu vybranú položku konfigurácie!';
    $Self->{Translation}->{'You don\'t have write access to this configuration item: %s.'} =
        'K tejto konfiguračnej položke nemáte prístup na zápis: %s.';
    $Self->{Translation}->{'No definition was defined for class %s!'} = 'Pre triedu %s nebola definovaná žiadna definícia!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemDelete.pm
    $Self->{Translation}->{'Config item "%s" not found in database!'} = 'Konfiguračná položka "%s" nebola nájdená v databáze!';
    $Self->{Translation}->{'Was not able to delete the configitem ID %s!'} = 'Nepodarilo sa odstrániť konfiguračnú položku ID %s!';
    $Self->{Translation}->{'No version found for ConfigItemID %s!'} = 'Pre ConfigItemID %s nebola nájdená žiadna verzia!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemEdit.pm
    $Self->{Translation}->{'No ConfigItemID, DuplicateID or ClassID is given!'} = 'Nie je uvedené žiadne ConfigItemID, DuplicateID ani ClassID!';
    $Self->{Translation}->{'No access is given!'} = 'Prístup nie je umožnený!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemHistory.pm
    $Self->{Translation}->{'Can\'t show history, no ConfigItemID is given!'} = 'Nemožno zobraziť históriu, nie je zadané žiadne ConfigItemID!';
    $Self->{Translation}->{'Can\'t show history, no access rights given!'} = 'Nemožno zobraziť históriu, nie sú dané žiadne prístupové práva!';
    $Self->{Translation}->{'New ConfigItem (ID=%s)'} = 'Nový prvok ConfigItem (ID=%s)';
    $Self->{Translation}->{'New version (ID=%s)'} = 'Nová verzia (ID=%s)';
    $Self->{Translation}->{'Deployment state updated (new=%s, old=%s)'} = 'Stav nasadenia aktualizovaný (new=%s, old=%s)';
    $Self->{Translation}->{'Incident state updated (new=%s, old=%s)'} = 'Stav incidentu aktualizovaný (new=%s, old=%s)';
    $Self->{Translation}->{'ConfigItem (ID=%s) deleted'} = 'ConfigItem (ID=%s) odstránený';
    $Self->{Translation}->{'Link to %s (type=%s) added'} = 'Pridaný odkaz na %s (type=%s)';
    $Self->{Translation}->{'Link to %s (type=%s) deleted'} = 'Odkaz na %s (type=%s) odstránený';
    $Self->{Translation}->{'ConfigItem definition updated (ID=%s)'} = 'Definícia položky ConfigItem aktualizovaná (ID=%s)';
    $Self->{Translation}->{'Name updated (new=%s, old=%s)'} = 'Názov aktualizovaný (new=%s, old=%s)';
    $Self->{Translation}->{'Attribute %s updated from "%s" to "%s"'} = 'Atribút %s aktualizovaný z "%s" na "%s"';
    $Self->{Translation}->{'Version %s deleted'} = 'Verzia %s odstránená';
    $Self->{Translation}->{'File "%s" uploaded'} = '';
    $Self->{Translation}->{'File "%s" removed'} = '';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemPrint.pm
    $Self->{Translation}->{'No ConfigItemID or VersionID is given!'} = 'Nie je uvedené žiadne ConfigItemID ani VersionID!';
    $Self->{Translation}->{'Can\'t show config item, no access rights given!'} = 'Nie je možné zobraziť položku konfigurácie, nie sú dané žiadne prístupové práva!';
    $Self->{Translation}->{'ConfigItemID %s not found in database!'} = 'ConfigItemID %s sa nenašlo v databáze!';
    $Self->{Translation}->{'ConfigItem'} = 'ConfigItem';
    $Self->{Translation}->{'printed by %s at %s'} = 'vytlačené %s na %s';
    $Self->{Translation}->{'Referenced by'} = '';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemSearch.pm
    $Self->{Translation}->{'Invalid ClassID!'} = 'Neplatné ClassID!';
    $Self->{Translation}->{'No ClassID is given!'} = 'Nie je uvedené žiadne ClassID!';
    $Self->{Translation}->{'No access rights for this class given!'} = 'Pre túto triedu nie sú udelené žiadne prístupové práva!';
    $Self->{Translation}->{'No Result!'} = 'Žiadny výsledok!';
    $Self->{Translation}->{'Config Item Search Results'} = 'Výsledky vyhľadávania konfiguračnej položky';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemZoom.pm
    $Self->{Translation}->{'Can\'t show item, no access rights for ConfigItem are given!'} =
        'Nie je možné zobraziť položku, nie sú dané žiadne prístupové práva pre ConfigItem!';
    $Self->{Translation}->{'ConfigItem not found!'} = 'Položka ConfigItem nebola nájdená!';
    $Self->{Translation}->{'No versions found!'} = 'Nenašli sa žiadne verzie!';
    $Self->{Translation}->{'operational'} = 'prevádzkové';
    $Self->{Translation}->{'warning'} = 'upozornenie';
    $Self->{Translation}->{'incident'} = 'incident';
    $Self->{Translation}->{'The deployment state of this config item'} = 'Stav nasadenia tejto položky konfigurácie';
    $Self->{Translation}->{'The incident state of this config item'} = 'Stav incidentu tejto konfiguračnej položky';

    # Perl Module: Kernel/Modules/CustomerITSMConfigItemSearch.pm
    $Self->{Translation}->{'No permission'} = 'Žiadne povolenie';
    $Self->{Translation}->{'Filter invalid!'} = 'Filter je neplatný!';
    $Self->{Translation}->{'Search params invalid!'} = 'Vyhľadávacie parametre sú neplatné!';

    # Perl Module: Kernel/Output/HTML/Dashboard/ITSMConfigItemGeneric.pm
    $Self->{Translation}->{'Shown config items'} = 'Zobrazené položky konfigurácie';
    $Self->{Translation}->{'Deployment State Type'} = 'Typ stavu nasadenia';
    $Self->{Translation}->{'Current Incident State Type'} = 'Typ aktuálneho incidentu';

    # Perl Module: Kernel/Output/HTML/ITSMConfigItem/LayoutDate.pm
    $Self->{Translation}->{'Between'} = 'Medzi';

    # Perl Module: Kernel/System/DynamicField/Driver/ConfigItem.pm
    $Self->{Translation}->{'Class restrictions for the config item'} = 'Obmedzenia triedy pre položku konfigurácie';
    $Self->{Translation}->{'Select one or more classes to restrict selectable config items'} =
        'Výber jednej alebo viacerých tried na obmedzenie vyberateľných položiek konfigurácie';
    $Self->{Translation}->{'Deployment state restrictions for the config item'} = '';
    $Self->{Translation}->{'Select one or more deployment states to restrict selectable config items'} =
        '';
    $Self->{Translation}->{'Dynamic (ConfigItem)'} = 'Dynamické (ConfigItem)';
    $Self->{Translation}->{'Static (Version)'} = 'Statický (verzia)';
    $Self->{Translation}->{'Link Referencing Type'} = 'Typ odkazu';
    $Self->{Translation}->{'Whether this link applies to the ConfigItem or the static version of the referencing object. Current Incident State calculation only is performed on dynamic links.'} =
        'Či sa toto prepojenie vzťahuje na ConfigItem alebo statickú verziu odkazujúceho objektu. Výpočet aktuálneho stavu incidentu sa vykonáva len pri dynamických odkazoch.';
    $Self->{Translation}->{'Select the attribute which config items will be searched by'} = 'Vyberte atribút, podľa ktorého sa budú vyhľadávať položky konfigurácie';

    # Perl Module: Kernel/System/ITSMConfigItem/Definition.pm
    $Self->{Translation}->{'Base structure is not valid. Please provide a hash with data in YAML format.'} =
        'Základná štruktúra nie je platná. Poskytnite hash s údajmi vo formáte YAML.';
    $Self->{Translation}->{'Starting the YAML string with \'---\' is required.'} = 'Reťazec YAML sa musí začínať znakom \'---\'.';

    # Perl Module: Kernel/System/ITSMConfigItem/Link.pm
    $Self->{Translation}->{'Could not purge the table configitem_link.'} = 'Nepodarilo sa vyčistiť tabuľku configitem_link.';
    $Self->{Translation}->{'No relevant dynamic fields were found'} = 'Neboli nájdené žiadne relevantné dynamické polia';
    $Self->{Translation}->{'Could not insert into the table configitem_link'} = 'Nepodarilo sa vložiť do tabuľky configitem_link';
    $Self->{Translation}->{'Inserted 0 rows into the table configitem_link'} = 'Vloženie 0 riadkov do tabuľky configitem_link';

    # Perl Module: Kernel/System/ImportExport/ObjectBackend/ITSMConfigItem.pm
    $Self->{Translation}->{'Maximum number of one element'} = 'Maximálny počet jedného prvku';
    $Self->{Translation}->{'Maximum number of one Set dynamic field element'} = '';
    $Self->{Translation}->{'Maximum number of one element within a Set dynamic field element'} =
        '';
    $Self->{Translation}->{'Import/Export attachments (as the last entries per line)'} = 'Import/export príloh (ako posledné položky na riadku)';
    $Self->{Translation}->{'Version String'} = 'Reťazec verzie';

    # Perl Module: Kernel/Modules/AdminDynamicField.pm
    $Self->{Translation}->{'Error synchronizing the definitions. Please check the log.'} = 'Chyba pri synchronizácii definícií. Skontrolujte, prosím, protokol.';
    $Self->{Translation}->{'You have ITSMConfigItem definitions which are not synchronized. Please deploy your ITSMConfigItem dynamic field changes.'} =
        'Máte definície ITSMConfigItem, ktoré nie sú synchronizované. Nasaďte dynamické zmeny polí ITSMConfigItem.';

    # Database XML / SOPM Definition: ITSMConfigurationManagement.sopm
    $Self->{Translation}->{'Expired'} = 'Vypršala platnosť';
    $Self->{Translation}->{'Maintenance'} = 'Údržba';
    $Self->{Translation}->{'Pilot'} = 'Pilot';
    $Self->{Translation}->{'Planned'} = 'Plánované';
    $Self->{Translation}->{'Repair'} = 'Oprava';
    $Self->{Translation}->{'Retired'} = 'na dôchodku';
    $Self->{Translation}->{'Review'} = 'Prehľad';
    $Self->{Translation}->{'Test/QA'} = 'Testovanie/QA';

    # JS File: ITSM.Admin.ITSMConfigItem
    $Self->{Translation}->{'Overview and Confirmation'} = 'Prehľad a potvrdenie';
    $Self->{Translation}->{'Importing classes/roles and their related fields'} = 'Importovanie tried/rolí a ich súvisiacich polí';
    $Self->{Translation}->{'An error occurred during class import.'} = 'Počas importu triedy došlo k chybe.';

    # SysConfig
    $Self->{Translation}->{'0 - Hidden'} = '0 - Skryté';
    $Self->{Translation}->{'1 - Shown'} = '1 - Zobrazené';
    $Self->{Translation}->{'A mapping of inner field names used in the Process Management TransitionActions ConfigItemAdd and -Update. The keys are the names of the set inner fields of the set with object type ticket which will be used to create/update the CI, and the values are the names of the inner fields of the set with object type ITSMConfigItem.'} =
        '';
    $Self->{Translation}->{'Allows extended search conditions in config item search of the agent interface. With this feature you can search e. g. config item name with this kind of conditions like "(*key1*&&*key2*)" or "(*key1*||*key2*)".'} =
        'Umožňuje rozšírené podmienky vyhľadávania v konfiguračnej položke vyhľadávania v rozhraní agenta. Pomocou tejto funkcie môžete vyhľadávať napr. názov konfiguračnej položky s podmienkami typu "(*key1*&&*key2*)" alebo "(*key1*||*key2*)".';
    $Self->{Translation}->{'Allows extended search conditions in config item search of the customer interface. With this feature you can search e. g. config item name with this kind of conditions like "(*key1*&&*key2*)" or "(*key1*||*key2*)".'} =
        'Umožňuje rozšírené podmienky vyhľadávania vo vyhľadávaní konfiguračných položiek v rozhraní zákazníka. Pomocou tejto funkcie môžete vyhľadávať napr. názov konfiguračnej položky pomocou podmienok typu "(*key1*&&*key2*)" alebo "(*key1*||*key2*)".';
    $Self->{Translation}->{'Assigned CIs'} = 'Priradené CI';
    $Self->{Translation}->{'At a specific time point create a ticket for config items, if the configured requirements are met. The time point is determined by the value of the dynamic field of type date configured under "TimeCIKey" of the ConfigItem, and modified by "TimeModifier". If the latter can be either just a number, or a sign (+/-), a number, and an unit (d/h/m): "7" is equivalent to "+7d". The DynamicField "Ticket->DynamicField" will be used to mark created tickets - it has to exist. The flags \<OTOBO_CONFIGITEM_X\> where X can be NAME, NUMBER and DATE, will be substituted with the respective values in "Ticket->Text".'} =
        '';
    $Self->{Translation}->{'Attributes for license accounting.'} = '';
    $Self->{Translation}->{'Attributes for licenses counting, where "TotalLicensesDF", "AvailableLicensesDF" and "LicenseReferenceDF" are the names of the dynamic fields used to track the remaining licenses. If used, only deployment states in "ValidDeplStates" are considered. If a threshold is defined in "MinimumLicenses", a ticket will automatically be created if less licenses are available. For this, the checkbox dynamic field "Ticket->DynamicField" must exist. The tags \<OTOBO_CONFIGITEM_X\> where X can be NAME, NUMBER, LICENSES_AVAIL and LICENSES_MIN, will be substituted with the respective values in "Ticket->Text" by the config item name, number, available licenses, and minimum required available licenses, respectively.'} =
        '';
    $Self->{Translation}->{'CIs assigned to customer company'} = 'CI priradené k zákazníckej spoločnosti';
    $Self->{Translation}->{'CIs assigned to customer user'} = 'CI priradené používateľovi zákazníka';
    $Self->{Translation}->{'CMDB Settings'} = 'Nastavenia CMDB';
    $Self->{Translation}->{'Check for a unique name only within the same ConfigItem class (\'class\') or globally (\'global\'), which means every existing ConfigItem is taken into account when looking for duplicates.'} =
        'Kontrolovať jedinečný názov len v rámci tej istej triedy ConfigItem ("class") alebo globálne ("global"), čo znamená, že pri hľadaní duplikátov sa berie do úvahy každý existujúci ConfigItem.';
    $Self->{Translation}->{'Choose a module to enforce a naming scheme.'} = 'Vyberte modul na vynútenie schémy pomenovania.';
    $Self->{Translation}->{'Choose a module to enforce a number scheme.'} = 'Vyberte si modul na vynútenie číselnej schémy.';
    $Self->{Translation}->{'Choose a module to enforce a version string scheme.'} = 'Vyberte modul na vynútenie schémy reťazca verzií.';
    $Self->{Translation}->{'Choose attributes to trigger the creation of a new version.'} = 'Vyberte atribúty, ktoré spustia vytvorenie novej verzie.';
    $Self->{Translation}->{'Choose categories to assign to this config item class.'} = 'Vyberte kategórie, ktoré chcete priradiť tejto triede konfiguračných položiek.';
    $Self->{Translation}->{'Column config item filters for ConfigItem Overview.'} = 'Filtre stĺpcových konfiguračných položiek pre ConfigItem Overview.';
    $Self->{Translation}->{'Columns that can be filtered in the config item overview of the agent interface. Note: Only Config Item attributes and Dynamic Fields (DynamicField_NameX) are allowed.'} =
        'Stĺpce, ktoré možno filtrovať v prehľade konfiguračných položiek v rozhraní agenta. Poznámka: Povolené sú len atribúty konfiguračnej položky a dynamické polia (DynamicField_NameX).';
    $Self->{Translation}->{'Config Items'} = 'Položky konfigurácie';
    $Self->{Translation}->{'Config item add.'} = 'Pridanie položky konfigurácie.';
    $Self->{Translation}->{'Config item edit.'} = 'Úprava položky konfigurácie.';
    $Self->{Translation}->{'Config item event module that enables accounting licenses for a given config item.'} =
        '';
    $Self->{Translation}->{'Config item event module that enables logging to history in the agent interface.'} =
        'Modul udalostí konfiguračnej položky, ktorý umožňuje zaznamenávanie do histórie v rozhraní agenta.';
    $Self->{Translation}->{'Config item event module that updates config items to their current definition.'} =
        'Modul udalostí konfiguračných položiek, ktorý aktualizuje konfiguračné položky podľa ich aktuálnej definície.';
    $Self->{Translation}->{'Config item history.'} = 'Výstup';
    $Self->{Translation}->{'Config item print.'} = 'Tlač konfiguračnej položky.';
    $Self->{Translation}->{'Config item zoom.'} = 'Priblíženie konfiguračnej položky.';
    $Self->{Translation}->{'ConfigItem Tree View'} = 'Stromové zobrazenie položky ConfigItem';
    $Self->{Translation}->{'ConfigItem Version'} = 'Verzia položky ConfigItem';
    $Self->{Translation}->{'ConfigItems of the following classes will not be stored on the Elasticsearch server. To apply this to existing CIs, the CI migration has to be run via console, after changing this option.'} =
        'Položky ConfigItems nasledujúcich tried nebudú uložené na serveri Elasticsearch. Ak chcete túto možnosť použiť na existujúce CI, je potrebné po zmene tejto možnosti spustiť migráciu CI prostredníctvom konzoly.';
    $Self->{Translation}->{'ConfigItems with the following deployment states will not be stored on the Elasticsearch server. To apply this to existing CIs, the CI migration has to be run via console, after changing this option.'} =
        'Položky ConfigItems s nasledujúcimi stavmi nasadenia nebudú uložené na serveri Elasticsearch. Ak chcete túto možnosť použiť na existujúce CI, je potrebné po zmene tejto možnosti spustiť migráciu CI prostredníctvom konzoly.';
    $Self->{Translation}->{'Configuration Item Limit'} = 'Limit položky konfigurácie';
    $Self->{Translation}->{'Configuration Item limit per page.'} = 'Konfigurácia Limit položky na stránku.';
    $Self->{Translation}->{'Configuration Management Database.'} = 'Databáza na správu konfigurácie.';
    $Self->{Translation}->{'Configuration item bulk module.'} = 'Hromadný modul konfiguračnej položky.';
    $Self->{Translation}->{'Configuration item search backend router of the agent interface.'} =
        'Vyhľadávanie konfiguračnej položky backendového smerovača rozhrania agenta.';
    $Self->{Translation}->{'Configure the columns which are available for viewing Permission Conditions in the customer interface, when the corresponding Permission Condition Columns are not specifically configured. This setting is used as a fallback for the other Permission Condition Columns settings.'} =
        '';
    $Self->{Translation}->{'Configure the columns which are available when viewing the corresponding Permission Condition in the customer interface.'} =
        '';
    $Self->{Translation}->{'Create and manage the definitions for Configuration Items.'} = 'Vytvorenie a správa definícií konfiguračných položiek.';
    $Self->{Translation}->{'Creates Tickets for ConfigItems at specific time points.'} = 'Vytvára lístky pre položky ConfigItems v určitých časových bodoch.';
    $Self->{Translation}->{'Customers can see historic CI versions.'} = 'Zákazníci môžu vidieť historické verzie CI.';
    $Self->{Translation}->{'Customers have the possibility to manually switch between historic CI versions.'} =
        'Zákazníci majú možnosť manuálne prepínať medzi historickými verziami CI.';
    $Self->{Translation}->{'Default data to use on attribute for config item search screen. Example: "ITSMConfigItemCreateTimePointFormat=year;ITSMConfigItemCreateTimePointStart=Last;ITSMConfigItemCreateTimePoint=2;".'} =
        'Predvolené údaje, ktoré sa majú použiť na obrazovke vyhľadávania atribútov konfiguračných položiek. Príklad: "ITSMConfigItemCreateTimePointFormat=year;ITSMConfigItemCreateTimePointStart=Last;ITSMConfigItemCreateTimePoint=2;".';
    $Self->{Translation}->{'Default data to use on attribute for config item search screen. Example: "ITSMConfigItemCreateTimeStartYear=2010;ITSMConfigItemCreateTimeStartMonth=10;ITSMConfigItemCreateTimeStartDay=4;ITSMConfigItemCreateTimeStopYear=2010;ITSMConfigItemCreateTimeStopMonth=11;ITSMConfigItemCreateTimeStopDay=3;".'} =
        'Predvolené údaje, ktoré sa majú použiť na obrazovke vyhľadávania atribútov konfiguračných položiek. Príklad: "ITSMConfigItemCreateTimeStartYear=2010;ITSMConfigItemCreateTimeStartMonth=10;ITSMConfigItemCreateTimeStartDay=4;ITSMConfigItemCreateTimeStopYear=2010;ITSMConfigItemCreateTimeStopMonth=11;ITSMConfigItemCreateTimeStopDay=3;".';
    $Self->{Translation}->{'Define Actions where a settings button is available in the linked objects widget (LinkObject::ViewMode = "complex"). Please note that these Actions must have registered the following JS and CSS files: Core.AllocationList.css, Core.UI.AllocationList.js, Core.UI.Table.Sort.js, Core.Agent.TableFilters.js and Core.Agent.LinkObject.js.'} =
        'Definujte Akcie, pri ktorých je vo widgete prepojených objektov k dispozícii tlačidlo nastavenia (LinkObject::ViewMode = "complex"). Upozorňujeme, že tieto Akcie musia mať zaregistrované nasledujúce súbory JS a CSS: Core.AllocationList.css, Core.UI.AllocationList.js, Core.UI.Table.Sort.js, Core.Agent.TableFilters.js a Core.Agent.LinkObject.js.';
    $Self->{Translation}->{'Define a Template::Toolkit scheme for version strings. Only used if Version String Module is set to TemplateToolkit.'} =
        'Definovanie schémy Template::Toolkit pre reťazce verzií. Používa sa len vtedy, ak je modul Version String nastavený na TemplateToolkit.';
    $Self->{Translation}->{'Define a set of conditions under which a customer is allowed to see a config item. Conditions can optionally be restricted to certain customer groups. Name is the only mandatory attribute. If no other options are given, all config items will be visible under that category.'} =
        'Definujte súbor podmienok, za ktorých môže zákazník vidieť položku konfigurácie. Podmienky môžu byť voliteľne obmedzené na určité skupiny zákazníkov. Názov je jediný povinný atribút. Ak nie sú zadané žiadne ďalšie možnosti, všetky konfiguračné položky budú viditeľné v rámci tejto kategórie.';
    $Self->{Translation}->{'Defines Required permissions to delete ITSM configuration items using the Generic Interface.'} =
        'Definuje požadované oprávnenia na vymazanie konfiguračných položiek ITSM pomocou všeobecného rozhrania.';
    $Self->{Translation}->{'Defines Required permissions to get ITSM configuration items using the Generic Interface.'} =
        'Definuje požadované oprávnenia na získanie konfiguračných položiek ITSM pomocou všeobecného rozhrania.';
    $Self->{Translation}->{'Defines Required permissions to search ITSM configuration items using the Generic Interface.'} =
        'Definuje požadované oprávnenia na vyhľadávanie konfiguračných položiek ITSM pomocou všeobecného rozhrania.';
    $Self->{Translation}->{'Defines Required permissions to set ITSM configuration items using the Generic Interface.'} =
        'Definuje požadované oprávnenia na nastavenie konfiguračných položiek ITSM pomocou všeobecného rozhrania.';
    $Self->{Translation}->{'Defines an overview module to show the small view of a configuration item list.'} =
        'Definuje modul prehľadu na zobrazenie malého zobrazenia zoznamu konfiguračných položiek.';
    $Self->{Translation}->{'Defines if the link type labels must be shown in the node connections.'} =
        'Definuje, či sa v spojeniach uzlov musia zobrazovať značky typu spojenia.';
    $Self->{Translation}->{'Defines regular expressions individually for each ConfigItem class to check the ConfigItem name and to show corresponding error messages.'} =
        'Definuje regulárne výrazy jednotlivo pre každú triedu ConfigItem na kontrolu názvu ConfigItem a zobrazenie príslušných chybových správ.';
    $Self->{Translation}->{'Defines the available columns of CIs in the config item overview depending on the CI class. Each entry must consist of a class name and an array of available fields for the corresponding class. Dynamic field entries have to honor the scheme DynamicField_FieldName.'} =
        'Definuje dostupné stĺpce CI v prehľade konfiguračných položiek v závislosti od triedy CI. Každá položka musí pozostávať z názvu triedy a poľa dostupných polí pre príslušnú triedu. Položky dynamických polí musia rešpektovať schému DynamicField_FieldName.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of the agent interface.'} =
        'Definuje predvolený atribút položky konfigurácie pre triedenie položiek konfigurácie vo výsledku vyhľadávania položiek konfigurácie v rozhraní agenta.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of the customer interface.'} =
        'Definuje predvolený atribút položky konfigurácie pre triedenie položiek konfigurácie vo výsledku vyhľadávania položiek konfigurácie v rozhraní zákazníka.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of this operation.'} =
        'Definuje predvolený atribút položky konfigurácie pre triedenie položky konfigurácie vo výsledku vyhľadávania položky konfigurácie tejto operácie.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the agent interface. Up: oldest on top. Down: latest on top.'} =
        'Definuje predvolené poradie konfiguračných položiek vo výsledku vyhľadávania konfiguračných položiek v rozhraní agenta. Nahor: najstaršie na vrchu. Nadol: najnovšie na vrchu.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the customer interface. Up: oldest on top. Down: latest on top.'} =
        'Definuje predvolené poradie položiek konfigurácie vo výsledku vyhľadávania položiek konfigurácie v rozhraní zákazníka. Nahor: najstaršie na vrchu. Nadol: najnovšie na vrchu.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the this operation. Up: oldest on top. Down: latest on top.'} =
        'Definuje predvolené poradie konfiguračných položiek vo výsledku vyhľadávania konfiguračných položiek tejto operácie. Nahor: najstaršie na vrchu. Nadol: najnovšie na vrchu.';
    $Self->{Translation}->{'Defines the default displayed columns of CIs in the config item overview depending on the CI class. Each entry must consist of a class name and an array of available fields for the corresponding class. Dynamic field entries have to honor the scheme DynamicField_FieldName.'} =
        'Definuje predvolené zobrazené stĺpce CI v prehľade konfiguračných položiek v závislosti od triedy CI. Každá položka musí pozostávať z názvu triedy a poľa dostupných polí pre príslušnú triedu. Položky dynamických polí musia rešpektovať schému DynamicField_FieldName.';
    $Self->{Translation}->{'Defines the default relations depth to be shown.'} = 'Definuje predvolenú hĺbku vzťahov, ktoré sa majú zobrazovať.';
    $Self->{Translation}->{'Defines the default shown config item search attribute for config item search screen.'} =
        'Definuje predvolený zobrazený atribút vyhľadávania konfiguračných položiek pre obrazovku vyhľadávania konfiguračných položiek.';
    $Self->{Translation}->{'Defines the default shown config item search attribute for config item search screen. Example: "Key" must have the name of the Dynamic Field in this case \'X\', "Content" must have the value of the Dynamic Field depending on the Dynamic Field type,  Text: \'a text\', Dropdown: \'1\', Date/Time: \'Search_DynamicField_XTimeSlotStartYear=1974; Search_DynamicField_XTimeSlotStartMonth=01; Search_DynamicField_XTimeSlotStartDay=26; Search_DynamicField_XTimeSlotStartHour=00; Search_DynamicField_XTimeSlotStartMinute=00; Search_DynamicField_XTimeSlotStartSecond=00; Search_DynamicField_XTimeSlotStopYear=2013; Search_DynamicField_XTimeSlotStopMonth=01; Search_DynamicField_XTimeSlotStopDay=26; Search_DynamicField_XTimeSlotStopHour=23; Search_DynamicField_XTimeSlotStopMinute=59; Search_DynamicField_XTimeSlotStopSecond=59;\' and or \'Search_DynamicField_XTimePointFormat=week; Search_DynamicField_XTimePointStart=Before; Search_DynamicField_XTimePointValue=7\';.'} =
        'Definuje predvolený zobrazený atribút vyhľadávania konfiguračných položiek pre obrazovku vyhľadávania konfiguračných položiek. Príklad: "Key" (Kľúč) musí mať názov dynamického poľa v tomto prípade "X", "Content" (Obsah) musí mať hodnotu dynamického poľa v závislosti od typu dynamického poľa, Text: "a text", Dropdown: "1", Date/Time: "Search_DynamicField_XTimeSlotStartYear=1974; Search_DynamicField_XTimeSlotStartMonth=01; Search_DynamicField_XTimeSlotStartDay=26; Search_DynamicField_XTimeSlotStartHour=00; Search_DynamicField_XTimeSlotStartMinute=00; Search_DynamicField_XTimeSlotStartSecond=00; Search_DynamicField_XTimeSlotStopYear=2013; Search_DynamicField_XTimeSlotStopMonth=01; Search_DynamicField_XTimeSlotStopDay=26; Search_DynamicField_XTimeSlotStopHour=23; Search_DynamicField_XTimeSlotStopMinute=59; Search_DynamicField_XTimeSlotStopSecond=59;\' a alebo \'Search_DynamicField_XTimePointFormat=týždeň; Search_DynamicField_XTimePointStart=Pred; Search_DynamicField_XTimePointValue=7\';.';
    $Self->{Translation}->{'Defines the default subobject of the class \'ITSMConfigItem\'.'} =
        'Definuje predvolený podobjekt triedy "ITSMConfigItem".';
    $Self->{Translation}->{'Defines the disabled columns of CIs in the config item overview depending on the CI class. Each entry must consist of a class name and an array of available fields for the corresponding class. Dynamic field entries have to honor the scheme DynamicField_FieldName.'} =
        '';
    $Self->{Translation}->{'Defines the height for the rich text editor component for this screen. Enter number (pixels) or percent value (relative).'} =
        'Definuje výšku komponentu textového editora pre túto obrazovku. Zadajte číslo (pixely) alebo percentuálnu hodnotu (relatívnu).';
    $Self->{Translation}->{'Defines the number of rows for the CI definition editor in the admin interface.'} =
        'Definuje počet riadkov pre editor definícií CI v rozhraní správcu.';
    $Self->{Translation}->{'Defines the order of incident states from high (e.g. cricital) to low (e.g. functional).'} =
        'Definuje poradie incidentných stavov od vysokého (napr. cricital) po nízky (napr. functional).';
    $Self->{Translation}->{'Defines the relevant deployment states where linked tickets can affect the status of a CI.'} =
        'Definuje príslušné stavy nasadenia, v ktorých môžu prepojené tipy ovplyvniť stav CI.';
    $Self->{Translation}->{'Defines the search limit for the AgentITSMConfigItem screen.'} =
        'Definuje limit vyhľadávania pre obrazovku AgentITSMConfigItem.';
    $Self->{Translation}->{'Defines the search limit for the AgentITSMConfigItemSearch screen.'} =
        'Definuje limit vyhľadávania pre obrazovku AgentITSMConfigItemSearch.';
    $Self->{Translation}->{'Defines the search limit for the CustomerITSMConfigItem screen.'} =
        'Definuje limit vyhľadávania pre obrazovku CustomerITSMConfigItem.';
    $Self->{Translation}->{'Defines the search limit for the CustomerITSMConfigItemSearch screen.'} =
        'Definuje limit vyhľadávania pre obrazovku CustomerITSMConfigItemSearch.';
    $Self->{Translation}->{'Defines the shown columns of CIs in the link table complex view for all CI classes. If there is no entry, then the default columns are shown.'} =
        'Definuje zobrazené stĺpce CI v komplexnom zobrazení tabuľky prepojení pre všetky triedy CI. Ak neexistuje žiadna položka, zobrazia sa predvolené stĺpce.';
    $Self->{Translation}->{'Defines the shown columns of CIs in the link table complex view, depending on the CI class. Each entry must be prefixed with the class name and double colons (i.e. Computer::). There are a few CI-Attributes that common to all CIs (example for the class Computer: Computer::Name, Computer::CurDeplState, Computer::CreateTime). To show individual CI-Attributes as defined in the CI-Definition, the following scheme must be used (example for the class Computer): Computer::HardDisk::1, Computer::HardDisk::1::Capacity::1, Computer::HardDisk::2, Computer::HardDisk::2::Capacity::1. If there is no entry for a CI class, then the default columns are shown.'} =
        'Definuje zobrazené stĺpce CI v komplexnom zobrazení tabuľky prepojení v závislosti od triedy CI. Každý záznam musí mať predponu s názvom triedy a dvojitými dvojbodkami (t. j. Computer::). Existuje niekoľko CI-Attributes (atribútov CI), ktoré sú spoločné pre všetky CI (príklad pre triedu Computer: Computer::Name, Computer::CurDeplState, Computer::CreateTime). Na zobrazenie jednotlivých CI-atribútov definovaných v CI-definícii sa musí použiť nasledujúca schéma (príklad pre triedu Computer): Computer::HardDisk::1, Computer::HardDisk::1::Capacity::1, Computer::HardDisk::2, Computer::HardDisk::2::Capacity::1. Ak pre triedu CI neexistuje žiadna položka, zobrazia sa predvolené stĺpce.';
    $Self->{Translation}->{'Defines which items are available for \'Action\' in third level of the ITSM Config Item ACL structure.'} =
        'Definuje, ktoré položky sú k dispozícii pre "Action" v tretej úrovni štruktúry ITSM Config Item ACL.';
    $Self->{Translation}->{'Defines which items are available in first level of the ITSM Config Item ACL structure.'} =
        'Definuje, ktoré položky sú dostupné v prvej úrovni štruktúry ITSM Config Item ACL.';
    $Self->{Translation}->{'Defines which items are available in second level of the ITSM Config Item ACL structure.'} =
        'Definuje, ktoré položky sú dostupné v druhej úrovni štruktúry ITSM Config Item ACL.';
    $Self->{Translation}->{'Defines which type of link (named from the ticket perspective) can affect the status of a linked CI.'} =
        'Určuje, ktorý typ prepojenia (pomenovaný z pohľadu tiketu) môže ovplyvniť stav prepojenej CI.';
    $Self->{Translation}->{'Defines which type of ticket can affect the status of a linked CI.'} =
        'Určuje, ktorý typ tipu môže ovplyvniť stav prepojenej CI.';
    $Self->{Translation}->{'Definition Update'} = 'Aktualizácia definície';
    $Self->{Translation}->{'Delete Configuration Item'} = 'Odstránenie položky konfigurácie';
    $Self->{Translation}->{'DeplState'} = 'DeplState';
    $Self->{Translation}->{'Deployment State Color'} = 'Farba stavu nasadenia';
    $Self->{Translation}->{'DeploymentState'} = 'DeploymentState';
    $Self->{Translation}->{'Duplicate'} = 'Duplikát';
    $Self->{Translation}->{'Dynamic field event module that marks config item definitions as out of sync, if containing dynamic fields change.'} =
        'Modul udalostí dynamických polí, ktorý označí definície konfiguračných položiek ako nesynchronizované, ak sa zmenia dynamické polia.';
    $Self->{Translation}->{'Dynamic fields shown in the additional ITSM field screen of the agent interface.'} =
        'Dynamické polia zobrazené na obrazovke ďalších polí ITSM v rozhraní agenta.';
    $Self->{Translation}->{'Dynamic fields shown in the config item overview screen of the customer interface.'} =
        'Dynamické polia zobrazené na obrazovke prehľadu konfiguračných položiek v rozhraní zákazníka.';
    $Self->{Translation}->{'Dynamic fields shown in the config item search screen of the agent interface.'} =
        'Dynamické polia zobrazené na obrazovke vyhľadávania konfiguračných položiek v rozhraní agenta.';
    $Self->{Translation}->{'Enables configuration item bulk action feature for the agent frontend to work on more than one configuration item at a time.'} =
        'Povolí funkciu hromadnej akcie konfiguračnej položky pre frontend agenta na prácu s viac ako jednou konfiguračnou položkou naraz.';
    $Self->{Translation}->{'Enables configuration item bulk action feature only for the listed groups.'} =
        'Stav nasadenia tejto položky konfigurácie';
    $Self->{Translation}->{'Enables/disables the functionality to check ITSM onfiguration items for unique names. Before enabling this option you should check your system for already existing config items with duplicate names. You can do this with the console command Admin::ITSM::ConfigItem::ListDuplicates.'} =
        'Povolí/vypne funkciu kontroly jedinečných názvov položiek konfigurácie ITSM. Pred zapnutím tejto možnosti by ste mali skontrolovať systém, či už neexistujú konfiguračné položky s duplicitnými názvami. Môžete to urobiť pomocou konzolového príkazu Admin::ITSM::ConfigItem::ListDuplicates.';
    $Self->{Translation}->{'Event module to set configitem-status on ticket-configitem-link.'} =
        'Modul udalosti na nastavenie configitem-status na ticket-configitem-link.';
    $Self->{Translation}->{'Fields of the configuration item index, used for the fulltext search. Fields are also stored, but are not mandatory for the overall functionality. Inclusion of attachments can be disabled by setting the entry to 0 or deleting it.'} =
        'Polia indexu konfiguračnej položky, ktoré sa používajú na fulltextové vyhľadávanie. Polia sú tiež uložené, ale nie sú povinné pre celkovú funkčnosť. Zahrnutie príloh možno zakázať nastavením položky na hodnotu 0 alebo jej vymazaním.';
    $Self->{Translation}->{'Fields stored in the configuration item index which are used for other things besides fulltext searches. For the complete functionality all fields are mandatory.'} =
        'Polia uložené v indexe konfiguračnej položky, ktoré sa okrem fulltextového vyhľadávania používajú aj na iné účely. Pre úplnú funkčnosť sú všetky polia povinné.';
    $Self->{Translation}->{'For every webservice (key) an array of classes (value) can be defined on which the import is restricted. For all chosen classes, or all existing classes the identifying attributes will have to be chosen in the invoker config.'} =
        'Pre každú webovú službu (kľúč) možno definovať pole tried (hodnota), na ktoré je import obmedzený. Pre všetky vybrané triedy alebo všetky existujúce triedy sa budú musieť v konfigurácii invokera zvoliť identifikačné atribúty.';
    $Self->{Translation}->{'GenericInterface module registration for the ConfigItemCreate invoker layer.'} =
        '';
    $Self->{Translation}->{'GenericInterface module registration for the ConfigItemFetch invoker layer.'} =
        'Registrácia modulu GenericInterface pre vrstvu vyvolávača ConfigItemFetch.';
    $Self->{Translation}->{'GenericInterface module registration for the ConfigItemUpdate invoker layer.'} =
        '';
    $Self->{Translation}->{'ITSM ConfigItem'} = 'ITSM ConfigItem';
    $Self->{Translation}->{'ITSM config item overview.'} = 'Prehľad konfiguračných položiek ITSM.';
    $Self->{Translation}->{'InciState'} = 'InciState';
    $Self->{Translation}->{'IncidentState'} = 'IncidentState';
    $Self->{Translation}->{'Includes deployment states in the config item search of the customer interface.'} =
        'Zahŕňa stavy nasadenia do vyhľadávania konfiguračných položiek v rozhraní zákazníka.';
    $Self->{Translation}->{'Includes incident states in the config item search of the customer interface.'} =
        'Zahŕňa stavy incidentov do vyhľadávania konfiguračných položiek v rozhraní zákazníka.';
    $Self->{Translation}->{'License accounting configuration item event module.'} = '';
    $Self->{Translation}->{'Maximum number of config items to be displayed in the result of this operation.'} =
        'Maximálny počet konfiguračných položiek, ktoré sa zobrazia vo výsledku tejto operácie.';
    $Self->{Translation}->{'Module to check the group responsible for a class.'} = 'Modul na kontrolu skupiny zodpovednej za triedu.';
    $Self->{Translation}->{'Module to check the group responsible for a configuration item.'} =
        'Modul na kontrolu skupiny zodpovednej za položku konfigurácie.';
    $Self->{Translation}->{'Module to generate ITSM config item statistics.'} = 'Modul na generovanie štatistík konfiguračných položiek ITSM.';
    $Self->{Translation}->{'Name Module'} = 'Názov modulu';
    $Self->{Translation}->{'Number Module'} = 'Modul čísla';
    $Self->{Translation}->{'Number of config items to be displayed in each page of a search result in the agent interface.'} =
        'Počet konfiguračných položiek, ktoré sa majú zobraziť na každej stránke výsledku vyhľadávania v rozhraní agenta.';
    $Self->{Translation}->{'Number of config items to be displayed in each page of a search result in the customer interface.'} =
        'Počet konfiguračných položiek, ktoré sa majú zobraziť na každej stránke výsledku vyhľadávania v rozhraní zákazníka.';
    $Self->{Translation}->{'Objects to search for, how many entries and which attributs to show. ConfigItem attributes have to explicitly be stored via Elasticsearch.'} =
        'Objekty, ktoré sa majú vyhľadávať, koľko záznamov a ktoré atribúty sa majú zobraziť. Atribúty ConfigItem musia byť explicitne uložené prostredníctvom Elasticsearch.';
    $Self->{Translation}->{'Overview.'} = 'Prehľad.';
    $Self->{Translation}->{'Parameters for the categories for config item classes in the preferences view of the agent interface.'} =
        'Parametre pre kategórie tried konfiguračných položiek v zobrazení preferencií rozhrania agenta.';
    $Self->{Translation}->{'Parameters for the column filters of the small config item overview. Please note: setting \'Active\' to 0 will only prevent agents from editing settings of this group in their personal preferences, but will still allow administrators to edit the settings of another user\'s behalf. Use \'PreferenceGroup\' to control in which area these settings should be shown in the user interface.'} =
        'Parametre pre stĺpcové filtre prehľadu malých konfiguračných položiek. Upozornenie: nastavenie hodnoty "Aktívne" na 0 zabráni agentom upravovať nastavenia tejto skupiny iba v ich osobných nastaveniach, ale správcom stále umožní upravovať nastavenia v mene iného používateľa. Pomocou položky \'PreferenceGroup\' môžete ovládať, v ktorej oblasti sa majú tieto nastavenia zobrazovať v používateľskom rozhraní.';
    $Self->{Translation}->{'Parameters for the dashboard backend of the customer company config item overview of the agent interface . "Limit" is the number of entries per config item class shown by default. "Group" is used to restrict the access to the plugin (e. g. Group: admin;group1;group2;). "Default" determines if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" is the cache time in minutes for the plugin. "ConfigItemKey" is used to specify which reference field is used for a ConfigItem class (Key=Class, Value=DynamicFieldName).'} =
        '';
    $Self->{Translation}->{'Parameters for the dashboard backend of the customer company config item overview of the agent interface . "Limit" is the number of entries shown by default. "Group" is used to restrict the access to the plugin (e. g. Group: admin;group1;group2;). "Default" determines if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" is the cache time in minutes for the plugin. "ConfigItemKey" is used to specify which reference field is used for a ConfigItem class (Key=Class, Value=DynamicFieldName).'} =
        '';
    $Self->{Translation}->{'Parameters for the deployment states color in the preferences view of the agent interface.'} =
        'Parametre pre stavy nasadenia sa vyfarbia v zobrazení preferencií rozhrania agenta.';
    $Self->{Translation}->{'Parameters for the deployment states in the preferences view of the agent interface.'} =
        'Parametre pre stavy nasadenia v zobrazení preferencií rozhrania agenta.';
    $Self->{Translation}->{'Parameters for the example permission groups of the general catalog attributes.'} =
        'Parametre pre príklady skupín oprávnení všeobecných atribútov katalógu.';
    $Self->{Translation}->{'Parameters for the name module for config item classes in the preferences view of the agent interface.'} =
        'Parametre modulu názvu pre triedy konfiguračných položiek v zobrazení preferencií rozhrania agenta.';
    $Self->{Translation}->{'Parameters for the number module for config item classes in the preferences view of the agent interface.'} =
        'Parametre pre modul čísla pre triedy konfiguračných položiek v zobrazení preferencií rozhrania agenta.';
    $Self->{Translation}->{'Parameters for the pages (in which the configuration items are shown).'} =
        'Parametre stránok (na ktorých sa zobrazujú konfiguračné položky).';
    $Self->{Translation}->{'Parameters for the version string module for config item classes in the preferences view of the agent interface.'} =
        'Parametre pre modul reťazca verzie pre triedy konfiguračných položiek v zobrazení preferencií rozhrania agenta.';
    $Self->{Translation}->{'Parameters for the version string template toolkit module for config item classes in the preferences view of the agent interface.'} =
        'Parametre pre modul šablóny reťazca verzie pre triedy konfiguračných položiek v zobrazení preferencií rozhrania agenta.';
    $Self->{Translation}->{'Parameters for the version trigger for config item classes in the preferences view of the agent interface.'} =
        'Parametre pre spúšťač verzie pre triedy konfiguračných položiek v zobrazení preferencií rozhrania agenta.';
    $Self->{Translation}->{'Performs the configured action for each event (as an Invoker) for each configured Webservice.'} =
        'Vykoná nakonfigurovanú akciu pre každú udalosť (ako Invoker) pre každú nakonfigurovanú webovú službu.';
    $Self->{Translation}->{'Permission Group'} = 'Skupina oprávnení';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item attachment action in the agent interface.'} =
        'Požadované oprávnenia na použitie akcie pripojenia konfiguračnej položky ITSM v rozhraní agenta.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item screen in the agent interface.'} =
        'Požadované oprávnenia na používanie obrazovky položky konfigurácie ITSM v rozhraní agenta.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item search screen in the agent interface.'} =
        'Požadované oprávnenia na používanie obrazovky na vyhľadávanie konfiguračných položiek ITSM v rozhraní agenta.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item search screen in the customer interface.'} =
        'Požadované oprávnenia na používanie obrazovky vyhľadávania položiek konfigurácie ITSM v rozhraní zákazníka.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item tree view screen in the agent interface.'} =
        'Požadované oprávnenia na používanie obrazovky zobrazenia stromu konfiguračných položiek ITSM v rozhraní agenta.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item zoom screen in the agent interface.'} =
        'Požadované oprávnenia na používanie obrazovky zväčšenia konfiguračnej položky ITSM v rozhraní agenta.';
    $Self->{Translation}->{'Required permissions to use the add ITSM configuration item screen in the agent interface.'} =
        'Požadované oprávnenia na používanie obrazovky pridania položky konfigurácie ITSM v rozhraní agenta.';
    $Self->{Translation}->{'Required permissions to use the bulk ITSM configuration item screen in the agent interface.'} =
        'Požadované oprávnenia na používanie obrazovky položky hromadnej konfigurácie ITSM v rozhraní agenta.';
    $Self->{Translation}->{'Required permissions to use the edit ITSM configuration item screen in the agent interface.'} =
        'Požadované oprávnenia na používanie obrazovky úprav položky konfigurácie ITSM v rozhraní agenta.';
    $Self->{Translation}->{'Required permissions to use the history ITSM configuration item screen in the agent interface.'} =
        'Požadované oprávnenia na používanie obrazovky položky histórie konfigurácie ITSM v rozhraní agenta.';
    $Self->{Translation}->{'Required permissions to use the print ITSM configuration item screen in the agent interface.'} =
        'Požadované oprávnenia na používanie obrazovky tlač položky konfigurácie ITSM v rozhraní agenta.';
    $Self->{Translation}->{'Required privileges to delete config items.'} = 'Požadované oprávnenia na odstránenie konfiguračných položiek.';
    $Self->{Translation}->{'Search config items.'} = 'Vyhľadávanie konfiguračných položiek.';
    $Self->{Translation}->{'Set the incident state of a CI automatically when a Ticket is Linked to a CI.'} =
        'Automatické nastavenie stavu incidentu CI, keď je tiket prepojený s CI.';
    $Self->{Translation}->{'Sets the deployment state in the configuration item bulk screen of the agent interface.'} =
        'Nastaví stav nasadenia na obrazovke hromadnej položky konfigurácie v rozhraní agenta.';
    $Self->{Translation}->{'Sets the incident state in the configuration item bulk screen of the agent interface.'} =
        'Nastaví stav udalosti na obrazovke hromadnej položky konfigurácie rozhrania agenta.';
    $Self->{Translation}->{'Shows a link in the menu that allows linking a configuration item with another object in the config item zoom view of the agent interface.'} =
        'Zobrazí odkaz v ponuke, ktorý umožňuje prepojenie konfiguračnej položky s iným objektom v zobrazení zväčšenia konfiguračnej položky v rozhraní agenta.';
    $Self->{Translation}->{'Shows a link in the menu to access the history of a configuration item in the configuration item overview of the agent interface.'} =
        'Zobrazí odkaz v ponuke na prístup k histórii konfiguračnej položky v prehľade konfiguračných položiek v rozhraní agenta.';
    $Self->{Translation}->{'Shows a link in the menu to access the history of a configuration item in the its zoom view of the agent interface.'} =
        'Zobrazí odkaz v ponuke na prístup k histórii konfiguračnej položky v jej zväčšenom zobrazení v rozhraní agenta.';
    $Self->{Translation}->{'Shows a link in the menu to delete a configuration item in its zoom view of the agent interface.'} =
        'Zobrazí odkaz v ponuke na odstránenie konfiguračnej položky v jej zväčšenom zobrazení rozhrania agenta.';
    $Self->{Translation}->{'Shows a link in the menu to display the configuration item links as a Tree View.'} =
        'Zobrazí odkaz v ponuke na zobrazenie odkazov na konfiguračné položky ako stromové zobrazenie.';
    $Self->{Translation}->{'Shows a link in the menu to duplicate a configuration item in the configuration item overview of the agent interface.'} =
        'Zobrazí odkaz v ponuke na duplikovanie konfiguračnej položky v prehľade konfiguračných položiek v rozhraní agenta.';
    $Self->{Translation}->{'Shows a link in the menu to duplicate a configuration item in the its zoom view of the agent interface.'} =
        'Zobrazí odkaz v ponuke na duplikovanie konfiguračnej položky v jej zväčšenom zobrazení rozhrania agenta.';
    $Self->{Translation}->{'Shows a link in the menu to edit a configuration item in the its zoom view of the agent interface.'} =
        'Zobrazí odkaz v ponuke na úpravu konfiguračnej položky v jej zväčšenom zobrazení rozhrania agenta.';
    $Self->{Translation}->{'Shows a link in the menu to go back in the configuration item zoom view of the agent interface.'} =
        'Zobrazí odkaz v ponuke na návrat do zobrazenia zväčšenia konfiguračnej položky v rozhraní agenta.';
    $Self->{Translation}->{'Shows a link in the menu to print a configuration item in the its zoom view of the agent interface.'} =
        'Zobrazí odkaz v ponuke na tlač konfiguračnej položky v jej zväčšenom zobrazení rozhrania agenta.';
    $Self->{Translation}->{'Shows a link in the menu to zoom into a configuration item in the configuration item overview of the agent interface.'} =
        'Zobrazí odkaz v ponuke na priblíženie konfiguračnej položky v prehľade konfiguračných položiek v rozhraní agenta.';
    $Self->{Translation}->{'Shows the config item history (reverse ordered) in the agent interface.'} =
        'Zobrazí históriu konfiguračných položiek (v opačnom poradí) v rozhraní agenta.';
    $Self->{Translation}->{'The default category which is shown, if none is selected.'} = 'Predvolená kategória, ktorá sa zobrazí, ak nie je vybratá žiadna.';
    $Self->{Translation}->{'The identifier for a configuration item, e.g. ConfigItem#, MyConfigItem#. The default is ConfigItem#.'} =
        'Identifikátor konfiguračnej položky, napr. ConfigItem#, MyConfigItem#. Predvolená hodnota je ConfigItem#.';
    $Self->{Translation}->{'Triggers ConfigItemFetch invoker automatically.'} = 'Automaticky spúšťa invokátor ConfigItemFetch.';
    $Self->{Translation}->{'Version String Expression'} = 'Verzia Reťazec vyjadrenia';
    $Self->{Translation}->{'Version String Module'} = 'Modul reťazca verzie';
    $Self->{Translation}->{'Version Trigger'} = 'Spúšťač verzie';
    $Self->{Translation}->{'Whether fields should be automatically filled (1), and in that case also be hidden from ticket formulars (2).'} =
        '';
    $Self->{Translation}->{'Whether the execution of ConfigItemACL can be avoided by checking cached field dependencies. This can improve loading times of formulars, but has to be disabled, if ACLModules are to be used for ITSMConfigItem- and Form-ReturnTypes.'} =
        'Či je možné vyhnúť sa vykonaniu príkazu ConfigItemACL kontrolou závislostí polí uložených v medzipamäti. Toto môže zlepšiť časy načítania formulárov, ale musí byť vypnuté, ak sa majú používať ACLModuly pre ITSMConfigItem- a Form-ReturnTypes.';
    $Self->{Translation}->{'Which general information is shown in the header.'} = 'Ktoré všeobecné informácie sú uvedené v záhlaví.';
    $Self->{Translation}->{'class'} = 'trieda';
    $Self->{Translation}->{'global'} = 'globálne';
    $Self->{Translation}->{'postproductive'} = 'postprodukčné';
    $Self->{Translation}->{'preproductive'} = 'predprodukčné';
    $Self->{Translation}->{'productive'} = 'produktívne';

    # Ready to adopt classes: IT-Servicemanagement-11_0_3
    $Self->{Translation}->{'10U: 17.5 inches (44.45 cm)'} = '10U: 17,5 palca (44,45 cm)';
    $Self->{Translation}->{'12U: 21 inches (53.34 cm)'} = '12U: 21 palcov (53,34 cm)';
    $Self->{Translation}->{'15U: 26.25 inches (66.68 cm)'} = '15U: 26,25 palca (66,68 cm)';
    $Self->{Translation}->{'18U: 31.5 inches (80.01 cm)'} = '18U: 31,5 palca (80,01 cm)';
    $Self->{Translation}->{'19-inch Rack'} = '19-palcový stojan';
    $Self->{Translation}->{'1U: 1.75 inches (4.45 cm)'} = '1U: 1,75 palca (4,45 cm)';
    $Self->{Translation}->{'20U: 35 inches (88.9 cm)'} = '20U: 35 palcov (88,9 cm)';
    $Self->{Translation}->{'21-inch Rack'} = '21-palcový stojan';
    $Self->{Translation}->{'22U: 38.5 inches (97.79 cm)'} = '22U: 38,5 palca (97,79 cm)';
    $Self->{Translation}->{'23-inch Rack'} = '23-palcový stojan';
    $Self->{Translation}->{'23.6 inches (600 mm)'} = '23,6 palca (600 mm)';
    $Self->{Translation}->{'24U: 42 inches (106.68 cm)'} = '24U: 42 palcov (106,68 cm)';
    $Self->{Translation}->{'27U: 47.25 inches (120.02 cm)'} = '27U: 47,25 palca (120,02 cm)';
    $Self->{Translation}->{'2U: 3.5 inches (8.89 cm)'} = '2U: 3,5 palca (8,89 cm)';
    $Self->{Translation}->{'30U: 52.5 inches (133.35 cm)'} = '30U: 52,5 palca (133,35 cm)';
    $Self->{Translation}->{'31.5 inches (800 mm)'} = '31,5 palca (800 mm)';
    $Self->{Translation}->{'33U: 57.75 inches (146.68 cm)'} = '33U: 57,75 palca (146,68 cm)';
    $Self->{Translation}->{'35.4 inches (900 mm)'} = '35,4 palca (900 mm)';
    $Self->{Translation}->{'36U: 63 inches (160.02 cm)'} = '36U: 63 palcov (160,02 cm)';
    $Self->{Translation}->{'39.4 inches (1000 mm)'} = '39,4 palca (1000 mm)';
    $Self->{Translation}->{'39U: 68.25 inches (173.35 cm)'} = '39U: 68,25 palca (173,35 cm)';
    $Self->{Translation}->{'3U: 5.25 inches (13.34 cm)'} = '3U: 5,25 palca (13,34 cm)';
    $Self->{Translation}->{'42U: 73.5 inches (186.69 cm)'} = '42U: 73,5 palca (186,69 cm)';
    $Self->{Translation}->{'43.3 inches (1100 mm):'} = '43,3 palca (1100 mm):';
    $Self->{Translation}->{'45U: 78.75 inches (200.02 cm)'} = '45U: 78,75 palca (200,02 cm)';
    $Self->{Translation}->{'47.2 inches (1200 mm)'} = '47,2 palca (1200 mm)';
    $Self->{Translation}->{'48U: 84 inches (213.36 cm)'} = '48U: 84 palcov (213,36 cm)';
    $Self->{Translation}->{'4U: 7 inches (17.78 cm)'} = '4U: 7 palcov (17,78 cm)';
    $Self->{Translation}->{'5U: 8.75 inches (22.23 cm)'} = '5U: 8,75 palca (22,23 cm)';
    $Self->{Translation}->{'6U: 10.5 inches (26.67 cm)'} = '6U: 10,5 palca (26,67 cm)';
    $Self->{Translation}->{'7U: 12.25 inches (31.12 cm)'} = '7U: 12,25 palca (31,12 cm)';
    $Self->{Translation}->{'8U: 14 inches (35.56 cm)'} = '8U: 14 palcov (35,56 cm)';
    $Self->{Translation}->{'9U: 15.75 inches (40.01 cm)'} = '9U: 15,75 palca (40,01 cm)';
    $Self->{Translation}->{'AGPL (Affero General Public License)'} = '';
    $Self->{Translation}->{'Accounting'} = 'Účtovníctvo';
    $Self->{Translation}->{'Accounting Information'} = '';
    $Self->{Translation}->{'Address Allocation'} = 'Prideľovanie adries';
    $Self->{Translation}->{'Administrator'} = 'Správca';
    $Self->{Translation}->{'Analog Phone'} = 'Analógový telefón';
    $Self->{Translation}->{'Apache Lizenz'} = '';
    $Self->{Translation}->{'Appliance Type'} = 'Typ spotrebiča';
    $Self->{Translation}->{'BSD Lizenz (Berkeley Software Distribution License)'} = '';
    $Self->{Translation}->{'Battery Capacity (Ah)'} = 'Kapacita batérie (Ah)';
    $Self->{Translation}->{'Battery Type'} = 'Typ batérie';
    $Self->{Translation}->{'Building'} = 'Budova';
    $Self->{Translation}->{'Bus Interface'} = 'Rozhranie zbernice';
    $Self->{Translation}->{'CC0 (Creative Commons Zero)'} = '';
    $Self->{Translation}->{'CIDR'} = 'CIDR';
    $Self->{Translation}->{'CPU'} = 'CPU';
    $Self->{Translation}->{'CPU Class'} = 'Trieda CPU';
    $Self->{Translation}->{'Capacity (GB)'} = 'Kapacita (GB)';
    $Self->{Translation}->{'Capacity per graphics card'} = 'Kapacita na grafickú kartu';
    $Self->{Translation}->{'Card Number'} = 'Číslo karty';
    $Self->{Translation}->{'Card Reader'} = 'Čítačka kariet';
    $Self->{Translation}->{'Card Type'} = 'Typ karty';
    $Self->{Translation}->{'Client Certificates'} = 'Certifikáty klientov';
    $Self->{Translation}->{'Client Software'} = 'Klientsky softvér';
    $Self->{Translation}->{'Client category'} = 'Kategória klientov';
    $Self->{Translation}->{'Clockrate'} = 'Hodiny';
    $Self->{Translation}->{'Clockspeed'} = 'Rýchlosť hodín';
    $Self->{Translation}->{'Code Signing Certificates'} = 'Certifikáty na podpisovanie kódu';
    $Self->{Translation}->{'Conference Phone'} = 'Konferenčný telefón';
    $Self->{Translation}->{'Consulting Agreement'} = 'Dohoda o poradenstve';
    $Self->{Translation}->{'Contact'} = 'Kontakt';
    $Self->{Translation}->{'Contact Distributor'} = 'Kontakt na distribútora';
    $Self->{Translation}->{'Container Management'} = 'Správa kontajnerov';
    $Self->{Translation}->{'Contract'} = 'Zmluva';
    $Self->{Translation}->{'Contract Type'} = 'Typ zmluvy';
    $Self->{Translation}->{'Contract period from'} = 'Zmluvné obdobie od';
    $Self->{Translation}->{'Contract period until'} = 'Obdobie platnosti zmluvy do';
    $Self->{Translation}->{'Cordless Phone (DECT Phone)'} = 'Bezdrôtový telefón (telefón DECT)';
    $Self->{Translation}->{'Cost unit'} = 'Nákladová jednotka';
    $Self->{Translation}->{'Count of licenses'} = 'Počet licencií';
    $Self->{Translation}->{'Creation Date'} = 'Dátum vytvorenia';
    $Self->{Translation}->{'Creative Commons'} = '';
    $Self->{Translation}->{'Custom Rack'} = 'Vlastný stojan';
    $Self->{Translation}->{'DHCP'} = 'DHCP';
    $Self->{Translation}->{'DHCP Reserved'} = 'DHCP Rezervované';
    $Self->{Translation}->{'DNS-Server'} = 'Server DNS';
    $Self->{Translation}->{'DVI'} = 'DVI';
    $Self->{Translation}->{'Date of Invoice'} = 'Dátum faktúry';
    $Self->{Translation}->{'Date of Order'} = 'Dátum objednávky';
    $Self->{Translation}->{'Date of Warranty'} = 'Dátum záruky';
    $Self->{Translation}->{'Date of release'} = 'Dátum vydania';
    $Self->{Translation}->{'Desktop'} = 'Stolný počítač';
    $Self->{Translation}->{'DisplayPort'} = 'DisplayPort';
    $Self->{Translation}->{'Document Signing Certificates'} = 'Certifikáty na podpisovanie dokumentov';
    $Self->{Translation}->{'EPL (Eclipse Public License)'} = '';
    $Self->{Translation}->{'ETSI Rack'} = 'ETSI Rack';
    $Self->{Translation}->{'Email Certificates (S/MIME Certificates)'} = 'E-mailové certifikáty (certifikáty S/MIME)';
    $Self->{Translation}->{'Embedded SIM (eSIM)'} = '';
    $Self->{Translation}->{'Employment Contract'} = 'Pracovná zmluva';
    $Self->{Translation}->{'End IP Address'} = 'Koncová IP adresa';
    $Self->{Translation}->{'End of support'} = 'Ukončenie podpory';
    $Self->{Translation}->{'Expiry Date'} = 'Dátum skončenia platnosti';
    $Self->{Translation}->{'External Hard Drive'} = 'Externý pevný disk';
    $Self->{Translation}->{'Firewall'} = 'Firewall';
    $Self->{Translation}->{'Firmware'} = 'Firmvér';
    $Self->{Translation}->{'Flywheel Energy Storage'} = 'Skladovanie energie na zotrvačníku';
    $Self->{Translation}->{'Form Factor'} = 'Faktor formy';
    $Self->{Translation}->{'Franchise Agreement'} = 'Franchisingová zmluva';
    $Self->{Translation}->{'Freeware'} = 'Freeware';
    $Self->{Translation}->{'GPL (General Public License)'} = '';
    $Self->{Translation}->{'General Information'} = 'Všeobecné informácie';
    $Self->{Translation}->{'Graphics Cards'} = 'Grafické karty';
    $Self->{Translation}->{'Graphics card'} = 'Grafická karta';
    $Self->{Translation}->{'HDMI'} = 'HDMI';
    $Self->{Translation}->{'Hardware'} = 'Hardvér';
    $Self->{Translation}->{'Hardware Model'} = 'Model hardvéru';
    $Self->{Translation}->{'Hardware Weight'} = 'Hmotnosť hardvéru';
    $Self->{Translation}->{'Headset'} = 'Náhlavná súprava';
    $Self->{Translation}->{'IP Protocol'} = 'Protokol IP';
    $Self->{Translation}->{'Identity and Access Management (IAM)'} = 'Správa identít a prístupu (IAM)';
    $Self->{Translation}->{'Inventory Number'} = 'Inventárne číslo';
    $Self->{Translation}->{'Inverstment costs'} = 'Náklady na inverstráciu';
    $Self->{Translation}->{'Invoice Number'} = 'Číslo faktúry';
    $Self->{Translation}->{'Keyboard'} = 'Klávesnica';
    $Self->{Translation}->{'LCD Monitor (Liquid Crystal Display)'} = 'LCD monitor (displej z tekutých kryštálov)';
    $Self->{Translation}->{'LED Monitor (Light Emitting Diode)'} = 'Monitor LED (svetelná dióda)';
    $Self->{Translation}->{'LGPL (Lesser General Public License)'} = '';
    $Self->{Translation}->{'Landline Phone'} = 'Telefón pevnej linky';
    $Self->{Translation}->{'Laptop'} = 'Laptop';
    $Self->{Translation}->{'Latitude'} = 'Zemepisná šírka';
    $Self->{Translation}->{'Layer 1: Physical Layer'} = 'Vrstva 1: Fyzická vrstva';
    $Self->{Translation}->{'Layer 2: Data Link Layer'} = 'Vrstva 2: vrstva dátového spojenia';
    $Self->{Translation}->{'Layer 3: Network Layer'} = 'Vrstva 3: Sieťová vrstva';
    $Self->{Translation}->{'Layer 3: Network Layer (Supernet)'} = 'Vrstva 3: Sieťová vrstva (Supernet)';
    $Self->{Translation}->{'Layer 4: Transport Layer'} = 'Vrstva 4: Transportná vrstva';
    $Self->{Translation}->{'Layer 5: Session Layer'} = 'Vrstva 5: Realizačná vrstva';
    $Self->{Translation}->{'Layer 6: Presentation Layer'} = 'Vrstva 6: prezentačná vrstva';
    $Self->{Translation}->{'Layer 7: Application Layer'} = 'Vrstva 7: Aplikačná vrstva';
    $Self->{Translation}->{'Lease Agreement'} = 'Nájomná zmluva';
    $Self->{Translation}->{'License Agreement'} = 'Licenčná zmluva';
    $Self->{Translation}->{'License Count'} = '';
    $Self->{Translation}->{'License Key'} = 'Licenčný kľúč';
    $Self->{Translation}->{'License Type'} = 'Typ licencie';
    $Self->{Translation}->{'License period from'} = 'Obdobie platnosti licencie od';
    $Self->{Translation}->{'License period until'} = 'Doba platnosti licencie do';
    $Self->{Translation}->{'Lithium Iron Phosphate (LiFePO4) Battery'} = 'Batéria s fosfátom lítia a železa (LiFePO4)';
    $Self->{Translation}->{'Lithium-Ion (Li-ion) Battery'} = 'Lítium-iónová (Li-ion) batéria';
    $Self->{Translation}->{'Loan Agreement'} = 'Zmluva o pôžičke';
    $Self->{Translation}->{'Located in'} = 'Nachádza sa v';
    $Self->{Translation}->{'Longitude'} = 'Zemepisná dĺžka';
    $Self->{Translation}->{'MIT Lizenz'} = '';
    $Self->{Translation}->{'MPL (Mozilla Public License)'} = '';
    $Self->{Translation}->{'Manufacturer'} = 'Výrobca';
    $Self->{Translation}->{'Maximum Load Capacity (W)'} = 'Maximálna nosnosť (W)';
    $Self->{Translation}->{'Memory'} = 'Pamäť';
    $Self->{Translation}->{'Memory Type'} = 'Typ pamäte';
    $Self->{Translation}->{'Micro SIM'} = '';
    $Self->{Translation}->{'Mini-Rack'} = 'Minirack';
    $Self->{Translation}->{'Mobile Number'} = 'Mobilné číslo';
    $Self->{Translation}->{'Mobile/Embedded'} = 'Mobilné/vložené';
    $Self->{Translation}->{'Model'} = 'Model';
    $Self->{Translation}->{'Model Description'} = 'Popis modelu';
    $Self->{Translation}->{'Monitor Resolution'} = 'Rozlíšenie monitora';
    $Self->{Translation}->{'Monitor Size'} = 'Veľkosť monitora';
    $Self->{Translation}->{'Mouse'} = 'Myš';
    $Self->{Translation}->{'Nano SIM'} = '';
    $Self->{Translation}->{'Network'} = 'Sieť';
    $Self->{Translation}->{'Network Info'} = 'Informácie o sieti';
    $Self->{Translation}->{'Network Information'} = 'Informácie o sieti';
    $Self->{Translation}->{'Network Layer'} = 'Sieťová vrstva';
    $Self->{Translation}->{'Nickel-Cadmium (NiCd) Battery'} = 'Nikel-kadmiová (NiCd) batéria';
    $Self->{Translation}->{'Nickel-Metal Hydride (NiMH) Battery'} = 'Nikel-metalhydridová (NiMH) batéria';
    $Self->{Translation}->{'Non-Disclosure Agreement (NDA)'} = 'Dohoda o mlčanlivosti (NDA)';
    $Self->{Translation}->{'Notebook'} = 'Notebook';
    $Self->{Translation}->{'Number of CPUs'} = 'Počet procesorov';
    $Self->{Translation}->{'Number of RAM modules'} = 'Počet modulov RAM';
    $Self->{Translation}->{'Number of graphics cards'} = 'Počet grafických kariet';
    $Self->{Translation}->{'OLED Monitor (Organic Light Emitting Diode)'} = 'Monitor OLED (organická dióda emitujúca svetlo)';
    $Self->{Translation}->{'Operating costs'} = 'Prevádzkové náklady';
    $Self->{Translation}->{'Order Number'} = 'Objednávacie číslo';
    $Self->{Translation}->{'Other'} = 'Iné';
    $Self->{Translation}->{'Outputs'} = 'Výstupy';
    $Self->{Translation}->{'PIN'} = 'PIN';
    $Self->{Translation}->{'PIN 2'} = 'PIN 2';
    $Self->{Translation}->{'PUK'} = 'PUK';
    $Self->{Translation}->{'PUK 2'} = 'PUK 2';
    $Self->{Translation}->{'Partnership Agreement'} = 'Dohoda o partnerstve';
    $Self->{Translation}->{'Perpetual licenses'} = '';
    $Self->{Translation}->{'Phone / VoIP'} = '';
    $Self->{Translation}->{'Phone Number'} = 'Telefónne číslo';
    $Self->{Translation}->{'Phone Type'} = 'Typ telefónu';
    $Self->{Translation}->{'Physical Cores'} = 'Fyzické jadrá';
    $Self->{Translation}->{'Power Delivery'} = 'Dodávka energie';
    $Self->{Translation}->{'Public Domain'} = '';
    $Self->{Translation}->{'Purchased at'} = 'Zakúpené v';
    $Self->{Translation}->{'Rack Depth'} = 'Hĺbka stojana';
    $Self->{Translation}->{'Rack Units (U)'} = 'Regálové jednotky (U)';
    $Self->{Translation}->{'Room'} = 'Izba';
    $Self->{Translation}->{'SIM Card'} = 'Karta SIM';
    $Self->{Translation}->{'SSL/TLS Certificates'} = 'Certifikáty SSL/TLS';
    $Self->{Translation}->{'Sales Contract'} = 'Predajná zmluva';
    $Self->{Translation}->{'Satellite Phone'} = 'Satelitný telefón';
    $Self->{Translation}->{'Sealed Lead-Acid (SLA) Battery'} = 'Uzavretá olovená batéria (SLA)';
    $Self->{Translation}->{'Seat licenses'} = '';
    $Self->{Translation}->{'Serialnumber'} = 'Sériové číslo';
    $Self->{Translation}->{'Server Software'} = 'Serverový softvér';
    $Self->{Translation}->{'Service Agreement'} = 'Zmluva o poskytovaní služieb';
    $Self->{Translation}->{'Service Tag'} = 'Servisný štítok';
    $Self->{Translation}->{'Shareware'} = '';
    $Self->{Translation}->{'Socket Type'} = 'Typ zásuvky';
    $Self->{Translation}->{'Software'} = 'Softvér';
    $Self->{Translation}->{'Speakers'} = 'Reproduktory';
    $Self->{Translation}->{'Standard SIM'} = '';
    $Self->{Translation}->{'Start IP Address'} = 'Počiatočná IP adresa';
    $Self->{Translation}->{'Storage'} = 'Úložisko';
    $Self->{Translation}->{'Storage Partition'} = 'Úložný oddiel';
    $Self->{Translation}->{'Subscription-based licenses'} = '';
    $Self->{Translation}->{'Subsidiary'} = 'Dcérska spoločnosť';
    $Self->{Translation}->{'Summary'} = 'Zhrnutie';
    $Self->{Translation}->{'Thin Client'} = 'Tenký klient';
    $Self->{Translation}->{'Threads'} = 'Vlákna';
    $Self->{Translation}->{'Thunderbolt'} = 'Thunderbolt';
    $Self->{Translation}->{'Total Graphics card RAM (GB)'} = 'Celková pamäť RAM grafickej karty (GB)';
    $Self->{Translation}->{'Total RAM (GB)'} = 'Celková pamäť RAM (GB)';
    $Self->{Translation}->{'Touchscreen Monitor'} = 'Dotykový monitor';
    $Self->{Translation}->{'Tower'} = 'Veža';
    $Self->{Translation}->{'USB Hub'} = 'Rozbočovač USB';
    $Self->{Translation}->{'USB-C'} = 'USB-C';
    $Self->{Translation}->{'VGA'} = 'VGA';
    $Self->{Translation}->{'VPN'} = 'VPN';
    $Self->{Translation}->{'VR Headset'} = 'Náhlavná súprava VR';
    $Self->{Translation}->{'Virtual Client'} = '';
    $Self->{Translation}->{'VirtualLink'} = 'VirtualLink';
    $Self->{Translation}->{'VoIP Phone'} = 'Telefón VoIP';
    $Self->{Translation}->{'Volume licenses'} = '';
    $Self->{Translation}->{'Webcam'} = 'Webová kamera';


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

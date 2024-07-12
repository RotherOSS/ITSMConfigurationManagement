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

package Kernel::Language::cs_ITSMConfigurationManagement;

use strict;
use warnings;
use utf8;

sub Data {
    my $Self = shift;

    # Template: AdminITSMConfigItem
    $Self->{Translation}->{'Config Item Management'} = 'Správa Konfiguračních Položek';
    $Self->{Translation}->{'Change class definition'} = 'Změna definice třídy';
    $Self->{Translation}->{'Change role definition'} = 'Změna definice role';
    $Self->{Translation}->{'Ready2Import Class Bundles'} = 'Svazky tříd Ready2Import';
    $Self->{Translation}->{'Here you can import Ready2Import class bundles showcasing our most usual config items. Please note that some additional configuration may be required.'} =
        'Zde můžete importovat svazky tříd Ready2Import, které představují naše nejobvyklejší položky konfigurace. Vezměte prosím na vědomí, že může být vyžadována další konfigurace.';
    $Self->{Translation}->{'Update existing entities'} = 'Aktualizace stávajících subjektů';
    $Self->{Translation}->{'Import Ready2Adopt class bundles'} = 'Import svazků tříd Ready2Adopt';
    $Self->{Translation}->{'Config Item Class'} = 'Třída položky konfigurace';
    $Self->{Translation}->{'Config Item Role'} = 'Role položky konfigurace';

    # Template: AgentITSMConfigItemAdd
    $Self->{Translation}->{'Config Item'} = 'Konfig. Položka';
    $Self->{Translation}->{'Filter for Classes'} = 'Filtr pro třídy';
    $Self->{Translation}->{'Select a Class from the list to create a new Config Item.'} = 'Chcete-li vytvořit novou položku konfigurace, vyberte ze seznamu třídu.';
    $Self->{Translation}->{'Class'} = 'Třída';

    # Template: AgentITSMConfigItemBulk
    $Self->{Translation}->{'ITSM ConfigItem Bulk Action'} = 'Hromadná akce ITSM ConfigItem';
    $Self->{Translation}->{'Deployment state'} = 'Stav Nasazení';
    $Self->{Translation}->{'Incident state'} = 'Stav Incidentu';
    $Self->{Translation}->{'Link to another'} = 'Odkaz na další';
    $Self->{Translation}->{'Invalid Configuration Item number!'} = 'Nesprávné číslo konfigurační položky!';
    $Self->{Translation}->{'The number of another Configuration Item to link with.'} = 'Číslo jiné položky konfigurace, se kterou se má propojit.';

    # Template: AgentITSMConfigItemDelete
    $Self->{Translation}->{'Do you really want to delete this config item?'} = 'Opravdu chcete tuto položku konfigurace odstranit?';

    # Template: AgentITSMConfigItemEdit
    $Self->{Translation}->{'The name of this config item'} = 'Jméno této Konfig. Položky';
    $Self->{Translation}->{'Name is already in use by the ConfigItems with the following Number(s): %s'} =
        'Název je již používán položkou ConfigItems s následujícím číslem (čísly): %s';
    $Self->{Translation}->{'Version Number'} = 'Číslo verze';
    $Self->{Translation}->{'Version number of this config item'} = 'Číslo verze této položky konfigurace';
    $Self->{Translation}->{'Version Number is already in use by the ConfigItems with the following Number(s): %s'} =
        'Číslo verze je již použito v položce ConfigItems s následujícím číslem (čísly): %s';
    $Self->{Translation}->{'Deployment State'} = 'Stav Nasazení';
    $Self->{Translation}->{'Incident State'} = 'Stav Incidentu';

    # Template: AgentITSMConfigItemHistory
    $Self->{Translation}->{'History of Config Item: %s'} = 'Historie položky konfigurace: %s';
    $Self->{Translation}->{'History Content'} = 'Obsah historie';
    $Self->{Translation}->{'Createtime'} = 'Doba vytvoření';
    $Self->{Translation}->{'Zoom view'} = 'Přiblížení zobrazení';

    # Template: AgentITSMConfigItemOverviewNavBar
    $Self->{Translation}->{'Config Items per page'} = 'Položky konfigurace na stránku';

    # Template: AgentITSMConfigItemOverviewSmall
    $Self->{Translation}->{'No config item data found.'} = 'Nebyla nalezena žádná data položky konfigurace.';
    $Self->{Translation}->{'Select this config item'} = 'Vyberte tuto položku konfigurace';

    # Template: AgentITSMConfigItemSearch
    $Self->{Translation}->{'Run Search'} = 'Spustit vyhledávání';
    $Self->{Translation}->{'Also search in previous versions?'} = 'Hledat také v předchozích verzích?';

    # Template: AgentITSMConfigItemTreeView
    $Self->{Translation}->{'TreeView for ConfigItem'} = 'Zobrazení stromu pro položku ConfigItem';
    $Self->{Translation}->{'Depth Level'} = 'Úroveň hloubky';
    $Self->{Translation}->{'Zoom In/Out'} = 'Přiblížení/oddálení';
    $Self->{Translation}->{'Max links level reached for ConfigItem!'} = 'Pro ConfigItem bylo dosaženo maximální úrovně odkazů!';

    # Template: AgentITSMConfigItemZoom
    $Self->{Translation}->{'Configuration Item'} = 'Položka konfigurace';
    $Self->{Translation}->{'Configuration Item Information'} = 'Informace o položce konfigurace';
    $Self->{Translation}->{'Current Deployment State'} = 'Aktuální Stav Nasazení';
    $Self->{Translation}->{'Current Incident State'} = 'Aktuální Stav Incidentu';
    $Self->{Translation}->{'Last changed'} = 'Poslední změna';
    $Self->{Translation}->{'Last changed by'} = 'Poslední změna od';

    # Template: CustomerITSMConfigItem
    $Self->{Translation}->{'Your ConfigItems'} = 'Vaše položky ConfigItems';

    # Template: CustomerITSMConfigItemSearch
    $Self->{Translation}->{'ConfigItem Search'} = 'Vyhledávání položek ConfigItem';

    # Template: AdminACL
    $Self->{Translation}->{'Object Type'} = 'Typ objektu';

    # JS Template: ClassImportConfirm
    $Self->{Translation}->{'The following classes will be imported'} = 'Budou importovány následující třídy';
    $Self->{Translation}->{'The following roles will be imported'} = 'Budou importovány následující role';
    $Self->{Translation}->{'Note that also corresponding dynamic fields and GeneralCatalog classes will be created and there is no automatic removal.'} =
        'Všimněte si, že budou vytvořena také odpovídající dynamická pole a třídy GeneralCatalog a nedojde k jejich automatickému odstranění.';
    $Self->{Translation}->{'Do you want to proceed?'} = 'Chcete pokračovat?';

    # Perl Module: Kernel/Modules/AdminITSMConfigItem.pm
    $Self->{Translation}->{'Need ExampleClasses!'} = 'Potřebujete příkladové třídy!';
    $Self->{Translation}->{'Definition is no valid YAML hash.'} = 'Definice není platný hash YAML.';

    # Perl Module: Kernel/Modules/AgentITSMConfigItem.pm
    $Self->{Translation}->{'Overview: ITSM ConfigItem'} = 'Přehled: ITSM ConfigItem';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemBulk.pm
    $Self->{Translation}->{'No ConfigItemID is given!'} = 'Není zadáno žádné ConfigItemID!';
    $Self->{Translation}->{'You need at least one selected Configuration Item!'} = 'Potřebujete alespoň jednu vybranou položku konfigurace!';
    $Self->{Translation}->{'You don\'t have write access to this configuration item: %s.'} =
        'K této konfigurační položce nemáte právo zápisu: %s.';
    $Self->{Translation}->{'No definition was defined for class %s!'} = 'Pro třídu %s nebyla definována žádná definice!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemDelete.pm
    $Self->{Translation}->{'Config item "%s" not found in database!'} = 'Konfigurační položka "%s" nebyla v databázi nalezena!';
    $Self->{Translation}->{'Was not able to delete the configitem ID %s!'} = 'Definuje počet řádků editoru definice CI v rozhraní správce.';
    $Self->{Translation}->{'No version found for ConfigItemID %s!'} = 'Pro ConfigItemID %s nebyla nalezena žádná verze!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemEdit.pm
    $Self->{Translation}->{'No ConfigItemID, DuplicateID or ClassID is given!'} = 'Není uvedeno ConfigItemID, DuplicateID ani ClassID!';
    $Self->{Translation}->{'No access is given!'} = 'Přístup není umožněn!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemHistory.pm
    $Self->{Translation}->{'Can\'t show history, no ConfigItemID is given!'} = 'Nelze zobrazit historii, není zadáno ConfigItemID!';
    $Self->{Translation}->{'Can\'t show history, no access rights given!'} = 'Nelze zobrazit historii, nejsou dána žádná přístupová práva!';
    $Self->{Translation}->{'New ConfigItem (ID=%s)'} = 'Nový prvek konfigurace (ID=%s)';
    $Self->{Translation}->{'New version (ID=%s)'} = 'Nová verze (ID=%s)';
    $Self->{Translation}->{'Deployment state updated (new=%s, old=%s)'} = 'Stav nasazení aktualizován (new=%s, old=%s)';
    $Self->{Translation}->{'Incident state updated (new=%s, old=%s)'} = 'Stav incidentu aktualizován (new=%s, old=%s)';
    $Self->{Translation}->{'ConfigItem (ID=%s) deleted'} = 'ConfigItem (ID=%s) odstraněn';
    $Self->{Translation}->{'Link to %s (type=%s) added'} = 'Přidán odkaz na %s (type=%s)';
    $Self->{Translation}->{'Link to %s (type=%s) deleted'} = 'Odkaz na %s (type=%s) odstraněn';
    $Self->{Translation}->{'ConfigItem definition updated (ID=%s)'} = 'Definice položky ConfigItem aktualizována (ID=%s)';
    $Self->{Translation}->{'Name updated (new=%s, old=%s)'} = 'Název aktualizován (new=%s, old=%s)';
    $Self->{Translation}->{'Attribute %s updated from "%s" to "%s"'} = 'Atribut %s aktualizován z "%s" na "%s"';
    $Self->{Translation}->{'Version %s deleted'} = 'Verze %s odstraněna';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemPrint.pm
    $Self->{Translation}->{'No ConfigItemID or VersionID is given!'} = 'Není uvedeno žádné ConfigItemID ani VersionID!';
    $Self->{Translation}->{'Can\'t show config item, no access rights given!'} = 'Nelze zobrazit položku konfigurace, nejsou zadána žádná přístupová práva!';
    $Self->{Translation}->{'ConfigItemID %s not found in database!'} = 'ConfigItemID %s nebylo v databázi nalezeno!';
    $Self->{Translation}->{'ConfigItem'} = 'ConfigItem';
    $Self->{Translation}->{'printed by %s at %s'} = 'vytištěno %s na %s';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemSearch.pm
    $Self->{Translation}->{'Invalid ClassID!'} = 'Parametry stránek (na kterých se zobrazují konfigurační položky).';
    $Self->{Translation}->{'No ClassID is given!'} = 'Není uvedeno žádné ClassID!';
    $Self->{Translation}->{'No access rights for this class given!'} = 'Pro tuto třídu nejsou dána žádná přístupová práva!';
    $Self->{Translation}->{'No Result!'} = 'Žádný výsledek!';
    $Self->{Translation}->{'Config Item Search Results'} = 'Výsledky vyhledávání položek konfigurace';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemZoom.pm
    $Self->{Translation}->{'Can\'t show item, no access rights for ConfigItem are given!'} =
        'Nelze zobrazit položku, nejsou zadána žádná přístupová práva pro ConfigItem!';
    $Self->{Translation}->{'ConfigItem not found!'} = 'Položka ConfigItem nebyla nalezena!';
    $Self->{Translation}->{'No versions found!'} = 'Nebyly nalezeny žádné verze!';
    $Self->{Translation}->{'operational'} = 'provozní';
    $Self->{Translation}->{'warning'} = 'varování';
    $Self->{Translation}->{'incident'} = 'Verze %s odstraněna';
    $Self->{Translation}->{'The deployment state of this config item'} = 'Stav Nasazení této Konfig. Položky';
    $Self->{Translation}->{'The incident state of this config item'} = 'Stav Incidentu této Konfig. Položky';

    # Perl Module: Kernel/Modules/CustomerITSMConfigItemSearch.pm
    $Self->{Translation}->{'No permission'} = 'Žádné povolení';
    $Self->{Translation}->{'Filter invalid!'} = 'Filtr je neplatný!';
    $Self->{Translation}->{'Search params invalid!'} = 'Hledání params je neplatné!';

    # Perl Module: Kernel/Output/HTML/Dashboard/ITSMConfigItemGeneric.pm
    $Self->{Translation}->{'Shown config items'} = 'Zobrazené položky konfigurace';
    $Self->{Translation}->{'Deployment State Type'} = 'Typ stavu nasazení';
    $Self->{Translation}->{'Current Incident State Type'} = 'Typ aktuálního stavu incidentu';

    # Perl Module: Kernel/Output/HTML/ITSMConfigItem/LayoutDate.pm
    $Self->{Translation}->{'Between'} = 'Mezi';

    # Perl Module: Kernel/System/DynamicField/Driver/ConfigItem.pm
    $Self->{Translation}->{'Class restrictions for the config item'} = 'Omezení třídy pro položku konfigurace';
    $Self->{Translation}->{'Select one or more classes to restrict selectable config items'} =
        'Výběrem jedné nebo více tříd omezíte vybíratelné položky konfigurace.';
    $Self->{Translation}->{'Link type'} = 'Typ odkazu';
    $Self->{Translation}->{'Select the link type.'} = 'Vyberte typ odkazu.';
    $Self->{Translation}->{'Forwards: Referencing (Source) -> Referenced (Target)'} = 'Útočníci: Odkazování (Zdroj) -> Odkazování (Cíl)';
    $Self->{Translation}->{'Backwards: Referenced (Source) -> Referencing (Target)'} = 'Zpětně: Odkazování (Zdroj) -> Odkazování (Cíl)';
    $Self->{Translation}->{'Link Direction'} = 'Směr odkazu';
    $Self->{Translation}->{'The referencing object is the one containing this dynamic field, the referenced object is the one selected as value of the dynamic field.'} =
        'Odkazující objekt je ten, který obsahuje toto dynamické pole, odkazovaný objekt je ten, který je vybrán jako hodnota dynamického pole.';
    $Self->{Translation}->{'Dynamic (ConfigItem)'} = 'Dynamické (ConfigItem)';
    $Self->{Translation}->{'Static (Version)'} = 'Static (verze)';
    $Self->{Translation}->{'Link Referencing Type'} = 'Typ odkazu Odkazování';
    $Self->{Translation}->{'Whether this link applies to the ConfigItem or the static version of the referencing object. Current Incident State calculation only is performed on dynamic links.'} =
        'Zda se tento odkaz vztahuje na ConfigItem nebo statickou verzi odkazujícího objektu. Výpočet aktuálního stavu incidentu se provádí pouze u dynamických odkazů.';
    $Self->{Translation}->{'Select the attribute which config items will be searched by'} = 'Vyberte atribut, podle kterého se budou hledat položky konfigurace.';

    # Perl Module: Kernel/System/ITSMConfigItem/Definition.pm
    $Self->{Translation}->{'Base structure is not valid. Please provide a hash with data in YAML format.'} =
        'Základní struktura není platná. Poskytněte hash s daty ve formátu YAML.';
    $Self->{Translation}->{'Starting the YAML string with \'---\' is required.'} = 'Řetězec YAML musí začínat znakem \'---\'.';

    # Perl Module: Kernel/System/ITSMConfigItem/Link.pm
    $Self->{Translation}->{'Could not purge the table configitem_link.'} = 'Nepodařilo se vyčistit tabulku configitem_link.';
    $Self->{Translation}->{'No relevant dynamic fields were found'} = 'Nebyla nalezena žádná relevantní dynamická pole';
    $Self->{Translation}->{'Could not insert into the table configitem_link'} = 'Nelze vložit do tabulky configitem_link';
    $Self->{Translation}->{'Inserted 0 rows into the table configitem_link'} = 'Vloženo 0 řádků do tabulky configitem_link';

    # Perl Module: Kernel/System/ImportExport/ObjectBackend/ITSMConfigItem.pm
    $Self->{Translation}->{'Maximum number of one element'} = 'Max počet jedné Položky';
    $Self->{Translation}->{'Empty fields indicate that the current values are kept'} = 'Prázdná pole znamenají, že aktuální hodnoty jsou zachovány.';
    $Self->{Translation}->{'Skipped'} = 'Přeskočeno';

    # Perl Module: Kernel/Modules/AdminDynamicField.pm
    $Self->{Translation}->{'Error synchronizing the definitions. Please check the log.'} = 'Chyba při synchronizaci definic. Zkontrolujte prosím protokol.';
    $Self->{Translation}->{'You have ITSMConfigItem definitions which are not synchronized. Please deploy your ITSMConfigItem dynamic field changes.'} =
        'Máte definice ITSMConfigItem, které nejsou synchronizovány. Nasaďte změny dynamických polí ITSMConfigItem.';

    # Database XML / SOPM Definition: ITSMConfigurationManagement.sopm
    $Self->{Translation}->{'Expired'} = 'Propadnuté';
    $Self->{Translation}->{'Maintenance'} = 'Údržba';
    $Self->{Translation}->{'Pilot'} = 'Řídící';
    $Self->{Translation}->{'Planned'} = 'Naplánováno';
    $Self->{Translation}->{'Repair'} = 'Oprava/Obnovení';
    $Self->{Translation}->{'Retired'} = 'Mimo provoz';
    $Self->{Translation}->{'Review'} = 'Přehled';
    $Self->{Translation}->{'Test/QA'} = 'Test/Kontrola kvality';

    # JS File: ITSM.Admin.ITSMConfigItem
    $Self->{Translation}->{'Overview and Confirmation'} = 'Přehled a potvrzení';
    $Self->{Translation}->{'Importing classes/roles and their related fields'} = 'Import tříd/rolí a jejich souvisejících polí';
    $Self->{Translation}->{'An error occurred during class import.'} = 'Při importu třídy došlo k chybě.';

    # SysConfig
    $Self->{Translation}->{'0 - Hidden'} = '0 - Skryté';
    $Self->{Translation}->{'1 - Shown'} = '1 - Vyobrazeno';
    $Self->{Translation}->{'Allows extended search conditions in config item search of the agent interface. With this feature you can search e. g. config item name with this kind of conditions like "(*key1*&&*key2*)" or "(*key1*||*key2*)".'} =
        'Umožňuje rozšířené podmínky vyhledávání v konfiguračních položkách rozhraní agenta. Pomocí této funkce můžete vyhledávat např. název konfigurační položky s podmínkami typu "(*key1*&&*key2*)" nebo "(*key1*||*key2*)".';
    $Self->{Translation}->{'Allows extended search conditions in config item search of the customer interface. With this feature you can search e. g. config item name with this kind of conditions like "(*key1*&&*key2*)" or "(*key1*||*key2*)".'} =
        'Umožňuje rozšířené podmínky vyhledávání v konfiguračním vyhledávání položek v zákaznickém rozhraní. Pomocí této funkce můžete vyhledávat např. název konfigurační položky s podmínkami typu "(*key1*&&*key2*)" nebo "(*key1*||*key2*)".';
    $Self->{Translation}->{'Assigned CIs'} = 'Přiřazené CI';
    $Self->{Translation}->{'At a specific time point create a ticket for config items, if the configured requirements are met. The time point is determined by the value of the field configured under "TimeCIKey" of the ConfigItem, and modified by "TimeModifier". If the latter can be either just a number, or a sign (+/-), a number, and an unit (d/h/m): "7" is equivalent to "+7d". The DynamicField "Ticket->DynamicField" will be used to mark created tickets - it has to exist. The flags \<OTOBO_CONFIGITEM_X\> where X can be NAME, NUMBER and DATE, will be substituted with the respective values in "Ticket->Text".'} =
        '';
    $Self->{Translation}->{'CIs assigned to customer company'} = 'CI přidělené společnosti zákazníka';
    $Self->{Translation}->{'CIs assigned to customer user'} = 'CI přiřazené uživateli zákazníka';
    $Self->{Translation}->{'CMDB Settings'} = 'Nastavení CMDB';
    $Self->{Translation}->{'Check for a unique name only within the same ConfigItem class (\'class\') or globally (\'global\'), which means every existing ConfigItem is taken into account when looking for duplicates.'} =
        'Zkontrolujte jedinečný název pouze v rámci stejné třídy ConfigItem ("class") nebo globálně ("global"), což znamená, že při hledání duplicit se bere v úvahu každý existující ConfigItem.';
    $Self->{Translation}->{'Choose a module to enforce a naming scheme.'} = 'Zvolte modul pro vynucení schématu pojmenování.';
    $Self->{Translation}->{'Choose a module to enforce a number scheme.'} = 'Vyberte modul pro vynucení číselného schématu.';
    $Self->{Translation}->{'Choose a module to enforce a version string scheme.'} = 'Zvolte modul pro vynucení schématu řetězce verzí.';
    $Self->{Translation}->{'Choose attributes to trigger the creation of a new version.'} = 'Vyberte atributy, které spustí vytvoření nové verze.';
    $Self->{Translation}->{'Choose categories to assign to this config item class.'} = 'Vyberte kategorie, které chcete přiřadit této třídě položek konfigurace.';
    $Self->{Translation}->{'Column config item filters for ConfigItem Overview.'} = 'Filtry sloupcových konfiguračních položek pro přehled položek ConfigItem.';
    $Self->{Translation}->{'Columns that can be filtered in the config item overview of the agent interface. Note: Only Config Item attributes and Dynamic Fields (DynamicField_NameX) are allowed.'} =
        'Sloupce, které lze filtrovat v přehledu konfiguračních položek rozhraní agenta. Poznámka: Povoleny jsou pouze atributy konfiguračních položek a dynamická pole (DynamicField_NameX).';
    $Self->{Translation}->{'Columns that can be filtered in the config item overview of the customer interface. Note: Only Config Item attributes and Dynamic Fields (DynamicField_NameX) are allowed.'} =
        'Sloupce, které lze filtrovat v přehledu konfiguračních položek zákaznického rozhraní. Poznámka: Povoleny jsou pouze atributy konfiguračních položek a dynamická pole (DynamicField_NameX).';
    $Self->{Translation}->{'Columns that can be filtered in the config item search result overview of the agent interface. Note: Only Config Item attributes and Dynamic Fields (DynamicField_NameX) are allowed.'} =
        'Sloupce, které lze filtrovat v přehledu výsledků vyhledávání položek konfigurace v rozhraní agenta. Poznámka: Povoleny jsou pouze atributy konfiguračních položek a dynamická pole (DynamicField_NameX).';
    $Self->{Translation}->{'Config Items'} = 'Položky konfigurace';
    $Self->{Translation}->{'Config item add.'} = 'Přidání položky konfigurace.';
    $Self->{Translation}->{'Config item edit.'} = 'Úprava položky konfigurace.';
    $Self->{Translation}->{'Config item event module that count the licenses for OTOBOCILicenseCount feature.'} =
        '';
    $Self->{Translation}->{'Config item event module that enables logging to history in the agent interface.'} =
        'Modul událostí položky konfigurace, který umožňuje protokolování do historie v rozhraní agenta.';
    $Self->{Translation}->{'Config item event module that updates config items to their current definition.'} =
        'Modul událostí konfiguračních položek, který aktualizuje konfigurační položky podle jejich aktuální definice.';
    $Self->{Translation}->{'Config item event module that updates the table configitem_ĺink.'} =
        'Modul událostí položky konfigurace, který aktualizuje tabulku configitem_ĺink.';
    $Self->{Translation}->{'Config item event module updates the current incident state.'} =
        'Modul událostí položky konfigurace aktualizuje aktuální stav incidentu.';
    $Self->{Translation}->{'Config item history.'} = 'Historie položek konfigurace.';
    $Self->{Translation}->{'Config item print.'} = 'Tisk konfigurační položky.';
    $Self->{Translation}->{'Config item zoom.'} = 'Přiblížení položky konfigurace.';
    $Self->{Translation}->{'ConfigItem Tree View'} = 'Stromové zobrazení položek konfigurace';
    $Self->{Translation}->{'ConfigItem Version'} = 'Verze položky ConfigItem';
    $Self->{Translation}->{'ConfigItems of the following classes will not be stored on the Elasticsearch server. To apply this to existing CIs, the CI migration has to be run via console, after changing this option.'} =
        'Položky ConfigItems následujících tříd nebudou na serveru Elasticsearch uloženy. Chcete-li tuto možnost použít na existující CI, je třeba po změně této možnosti spustit migraci CI prostřednictvím konzoly.';
    $Self->{Translation}->{'ConfigItems with the following deployment states will not be stored on the Elasticsearch server. To apply this to existing CIs, the CI migration has to be run via console, after changing this option.'} =
        'Položky ConfigItems s následujícími stavy nasazení nebudou na serveru Elasticsearch uloženy. Chcete-li tuto možnost použít na existující CI, je třeba po změně této možnosti spustit migraci CI prostřednictvím konzoly.';
    $Self->{Translation}->{'Configuration Item Limit'} = 'Limit položky konfigurace';
    $Self->{Translation}->{'Configuration Item limit per page.'} = 'Konfigurace Omezení položek na stránku.';
    $Self->{Translation}->{'Configuration Management Database.'} = 'Databáze pro správu konfigurace.';
    $Self->{Translation}->{'Configuration item bulk module.'} = 'Hromadný modul položek konfigurace.';
    $Self->{Translation}->{'Configuration item search backend router of the agent interface.'} =
        'Konfigurační položka vyhledávání backendového směrovače rozhraní agenta.';
    $Self->{Translation}->{'Create and manage the definitions for Configuration Items.'} = 'Vytvářet a spravovat definice položek konfigurace.';
    $Self->{Translation}->{'Creates Tickets for ConfigItems at specific time points.'} = '';
    $Self->{Translation}->{'Customers can see historic CI versions.'} = 'Zákazníci si mohou prohlédnout historické verze CI.';
    $Self->{Translation}->{'Customers have the possibility to manually switch between historic CI versions.'} =
        'Zákazníci mají možnost ručně přepínat mezi historickými verzemi CI.';
    $Self->{Translation}->{'Default data to use on attribute for config item search screen. Example: "ITSMConfigItemCreateTimePointFormat=year;ITSMConfigItemCreateTimePointStart=Last;ITSMConfigItemCreateTimePoint=2;".'} =
        'Výchozí údaje, které se použijí na obrazovce pro vyhledávání položek konfigurace. Příklad: "ITSMConfigItemCreateTimePointFormat=year;ITSMConfigItemCreateTimePointStart=Last;ITSMConfigItemCreateTimePoint=2;".';
    $Self->{Translation}->{'Default data to use on attribute for config item search screen. Example: "ITSMConfigItemCreateTimeStartYear=2010;ITSMConfigItemCreateTimeStartMonth=10;ITSMConfigItemCreateTimeStartDay=4;ITSMConfigItemCreateTimeStopYear=2010;ITSMConfigItemCreateTimeStopMonth=11;ITSMConfigItemCreateTimeStopDay=3;".'} =
        'Výchozí údaje, které se použijí na obrazovce pro vyhledávání položek konfigurace. Příklad: "ITSMConfigItemCreateTimeStartYear=2010;ITSMConfigItemCreateTimeStartMonth=10;ITSMConfigItemCreateTimeStartDay=4;ITSMConfigItemCreateTimeStopYear=2010;ITSMConfigItemCreateTimeStopMonth=11;ITSMConfigItemCreateTimeStopDay=3;".';
    $Self->{Translation}->{'Define Actions where a settings button is available in the linked objects widget (LinkObject::ViewMode = "complex"). Please note that these Actions must have registered the following JS and CSS files: Core.AllocationList.css, Core.UI.AllocationList.js, Core.UI.Table.Sort.js, Core.Agent.TableFilters.js and Core.Agent.LinkObject.js.'} =
        'Definujte Akce, u kterých je ve widgetu propojených objektů k dispozici tlačítko nastavení (LinkObject::ViewMode = "complex"). Upozorňujeme, že tyto Akce musí mít zaregistrované následující soubory JS a CSS: UI.AllocationList.js, Core.UI.Table.Sort.js, Core.Agent.TableFilters.js a Core.Agent.LinkObject.js.';
    $Self->{Translation}->{'Define a Template::Toolkit scheme for version strings. Only used if Version String Module is set to TemplateToolkit.'} =
        'Definice schématu sady Template::Toolkit pro řetězce verzí. Používá se pouze v případě, že je modul Version String nastaven na TemplateToolkit.';
    $Self->{Translation}->{'Define a set of conditions under which a customer is allowed to see a config item. Conditions can optionally be restricted to certain customer groups. Name is the only mandatory attribute. If no other options are given, all config items will be visible under that category.'} =
        'Definujte sadu podmínek, za kterých je zákazníkovi povoleno zobrazit položku konfigurace. Podmínky lze volitelně omezit na určité skupiny zákazníků. Jediným povinným atributem je název. Pokud nejsou zadány žádné další možnosti, budou v dané kategorii viditelné všechny položky konfigurace.';
    $Self->{Translation}->{'Defines Required permissions to create ITSM configuration items using the Generic Interface.'} =
        'Definuje Požadovaná oprávnění k vytváření položek konfigurace ITSM pomocí obecného rozhraní.';
    $Self->{Translation}->{'Defines Required permissions to delete ITSM configuration items using the Generic Interface.'} =
        'Definuje Požadovaná oprávnění k odstraňování položek konfigurace ITSM pomocí obecného rozhraní.';
    $Self->{Translation}->{'Defines Required permissions to get ITSM configuration items using the Generic Interface.'} =
        'Definuje Požadovaná oprávnění pro získání položek konfigurace ITSM pomocí obecného rozhraní.';
    $Self->{Translation}->{'Defines Required permissions to search ITSM configuration items using the Generic Interface.'} =
        'Definuje Požadovaná oprávnění k vyhledávání položek konfigurace ITSM pomocí obecného rozhraní.';
    $Self->{Translation}->{'Defines Required permissions to update ITSM configuration items using the Generic Interface.'} =
        'Definuje Požadovaná oprávnění k aktualizaci položek konfigurace ITSM pomocí obecného rozhraní.';
    $Self->{Translation}->{'Defines an overview module to show the small view of a configuration item list.'} =
        'Definuje modul přehledu pro zobrazení malého zobrazení seznamu konfiguračních položek.';
    $Self->{Translation}->{'Defines if the link type labels must be shown in the node connections.'} =
        'Určuje, zda se v propojení uzlů musí zobrazovat popisky typu propojení.';
    $Self->{Translation}->{'Defines regular expressions individually for each ConfigItem class to check the ConfigItem name and to show corresponding error messages.'} =
        'Definuje regulární výrazy jednotlivě pro každou třídu ConfigItem pro kontrolu názvu ConfigItem a zobrazení příslušných chybových zpráv.';
    $Self->{Translation}->{'Defines the available columns of CIs in the config item overview depending on the CI class. Each entry must consist of a class name and an array of available fields for the corresponding class. Dynamic field entries have to honor the scheme DynamicField_FieldName.'} =
        'Definuje dostupné sloupce CI v přehledu položek konfigurace v závislosti na třídě CI. Každá položka se musí skládat z názvu třídy a pole dostupných polí pro příslušnou třídu. Položky dynamických polí musí respektovat schéma DynamicField_FieldName.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of the agent interface.'} =
        'Definuje výchozí atribut položky konfigurace pro třídění položek konfigurace ve výsledku vyhledávání položek konfigurace v rozhraní agenta.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of the customer interface.'} =
        'Definuje výchozí atribut položky konfigurace pro třídění položek konfigurace ve výsledku vyhledávání položek konfigurace v zákaznickém rozhraní.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of this operation.'} =
        'Definuje výchozí atribut položky konfigurace pro třídění položek konfigurace ve výsledku vyhledávání položek konfigurace této operace.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the agent interface. Up: oldest on top. Down: latest on top.'} =
        'Definuje výchozí pořadí položek konfigurace ve výsledku vyhledávání položek konfigurace v rozhraní agenta. Nahoru: nejstarší nahoře. Dolů: nejnovější nahoře.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the customer interface. Up: oldest on top. Down: latest on top.'} =
        'Definuje výchozí pořadí položek konfigurace ve výsledku vyhledávání položek konfigurace v zákaznickém rozhraní. Nahoru: nejstarší nahoře. Dolů: nejnovější nahoře.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the this operation. Up: oldest on top. Down: latest on top.'} =
        'Definuje výchozí pořadí položek konfigurace ve výsledku vyhledávání položek konfigurace této operace. Nahoru: nejstarší nahoře. Dolů: nejnovější nahoře.';
    $Self->{Translation}->{'Defines the default displayed columns of CIs in the config item overview depending on the CI class. Each entry must consist of a class name and an array of available fields for the corresponding class. Dynamic field entries have to honor the scheme DynamicField_FieldName.'} =
        'Definuje výchozí zobrazené sloupce CI v přehledu položek konfigurace v závislosti na třídě CI. Každá položka se musí skládat z názvu třídy a pole dostupných polí pro příslušnou třídu. Položky dynamických polí musí respektovat schéma DynamicField_FieldName.';
    $Self->{Translation}->{'Defines the default relations depth to be shown.'} = 'Definuje výchozí hloubku vztahů, které se mají zobrazit.';
    $Self->{Translation}->{'Defines the default shown config item search attribute for config item search screen.'} =
        'Definuje výchozí zobrazený atribut vyhledávání položek konfigurace pro obrazovku vyhledávání položek konfigurace.';
    $Self->{Translation}->{'Defines the default shown config item search attribute for config item search screen. Example: "Key" must have the name of the Dynamic Field in this case \'X\', "Content" must have the value of the Dynamic Field depending on the Dynamic Field type,  Text: \'a text\', Dropdown: \'1\', Date/Time: \'Search_DynamicField_XTimeSlotStartYear=1974; Search_DynamicField_XTimeSlotStartMonth=01; Search_DynamicField_XTimeSlotStartDay=26; Search_DynamicField_XTimeSlotStartHour=00; Search_DynamicField_XTimeSlotStartMinute=00; Search_DynamicField_XTimeSlotStartSecond=00; Search_DynamicField_XTimeSlotStopYear=2013; Search_DynamicField_XTimeSlotStopMonth=01; Search_DynamicField_XTimeSlotStopDay=26; Search_DynamicField_XTimeSlotStopHour=23; Search_DynamicField_XTimeSlotStopMinute=59; Search_DynamicField_XTimeSlotStopSecond=59;\' and or \'Search_DynamicField_XTimePointFormat=week; Search_DynamicField_XTimePointStart=Before; Search_DynamicField_XTimePointValue=7\';.'} =
        'Definuje výchozí zobrazený atribut vyhledávání položek konfigurace pro obrazovku vyhledávání položek konfigurace. Příklad: "Key" musí mít název dynamického pole v tomto případě "X", "Content" musí mít hodnotu dynamického pole v závislosti na typu dynamického pole, Text: "a text", Dropdown: "1", Date/Time: "Search_DynamicField_XTimeSlotStartYear=1974; Search_DynamicField_XTimeSlotStartMonth=01; Search_DynamicField_XTimeSlotStartDay=26; Search_DynamicField_XTimeSlotStartHour=00; Search_DynamicField_XTimeSlotStartMinute=00; Search_DynamicField_XTimeSlotStartSecond=00; Search_DynamicField_XTimeSlotStopYear=2013; Search_DynamicField_XTimeSlotStopMonth=01; Search_DynamicField_XTimeSlotStopDay=26; Search_DynamicField_XTimeSlotStopHour=23; Search_DynamicField_XTimeSlotStopMinute=59; Search_DynamicField_XTimeSlotStopSecond=59;\' a nebo \'Search_DynamicField_XTimePointFormat=týden; Search_DynamicField_XTimePointStart=Před; Search_DynamicField_XTimePointValue=7\';.';
    $Self->{Translation}->{'Defines the default subobject of the class \'ITSMConfigItem\'.'} =
        'Definuje výchozí podobjekt třídy \'ITSMConfigItem\'.';
    $Self->{Translation}->{'Defines the number of rows for the CI definition editor in the admin interface.'} =
        'Definuje počet řádků editoru definice CI v rozhraní správce.';
    $Self->{Translation}->{'Defines the order of incident states from high (e.g. cricital) to low (e.g. functional).'} =
        'Definuje pořadí incidentních stavů od vysokého (např. cricital) po nízký (např. functional).';
    $Self->{Translation}->{'Defines the relevant deployment states where linked tickets can affect the status of a CI.'} =
        'Definuje příslušné stavy nasazení, ve kterých mohou propojené tipy ovlivnit stav CI.';
    $Self->{Translation}->{'Defines the search limit for the AgentITSMConfigItem screen.'} =
        'Definuje omezení vyhledávání pro obrazovku AgentITSMConfigItem.';
    $Self->{Translation}->{'Defines the search limit for the AgentITSMConfigItemSearch screen.'} =
        'Definuje limit vyhledávání pro obrazovku AgentITSMConfigItemSearch.';
    $Self->{Translation}->{'Defines the search limit for the CustomerITSMConfigItem screen.'} =
        'Definuje omezení vyhledávání pro obrazovku CustomerITSMConfigItem.';
    $Self->{Translation}->{'Defines the search limit for the CustomerITSMConfigItemSearch screen.'} =
        'Definuje limit vyhledávání pro obrazovku CustomerITSMConfigItemSearch.';
    $Self->{Translation}->{'Defines the shown columns of CIs in the link table complex view for all CI classes. If there is no entry, then the default columns are shown.'} =
        'Definuje zobrazené sloupce CI v komplexním zobrazení tabulky odkazů pro všechny třídy CI. Pokud není k dispozici žádná položka, zobrazí se výchozí sloupce.';
    $Self->{Translation}->{'Defines the shown columns of CIs in the link table complex view, depending on the CI class. Each entry must be prefixed with the class name and double colons (i.e. Computer::). There are a few CI-Attributes that common to all CIs (example for the class Computer: Computer::Name, Computer::CurDeplState, Computer::CreateTime). To show individual CI-Attributes as defined in the CI-Definition, the following scheme must be used (example for the class Computer): Computer::HardDisk::1, Computer::HardDisk::1::Capacity::1, Computer::HardDisk::2, Computer::HardDisk::2::Capacity::1. If there is no entry for a CI class, then the default columns are shown.'} =
        'Filtr pro třídy';
    $Self->{Translation}->{'Defines which items are available for \'Action\' in third level of the ITSM Config Item ACL structure.'} =
        'Určuje, které položky jsou k dispozici pro "Action" ve třetí úrovni struktury ITSM Config Item ACL.';
    $Self->{Translation}->{'Defines which items are available in first level of the ITSM Config Item ACL structure.'} =
        'Určuje, které položky jsou k dispozici v první úrovni struktury ITSM Config Item ACL.';
    $Self->{Translation}->{'Defines which items are available in second level of the ITSM Config Item ACL structure.'} =
        'Určuje, které položky jsou k dispozici ve druhé úrovni struktury ITSM Config Item ACL.';
    $Self->{Translation}->{'Defines which type of link (named from the ticket perspective) can affect the status of a linked CI.'} =
        'Určuje, který typ propojení (pojmenovaný z pohledu tipu) může ovlivnit stav propojené CI.';
    $Self->{Translation}->{'Defines which type of ticket can affect the status of a linked CI.'} =
        'Určuje, který typ tipu může ovlivnit stav propojené CI.';
    $Self->{Translation}->{'Definition Update'} = 'Aktualizace definice';
    $Self->{Translation}->{'Delete Configuration Item'} = 'Odstranění položky konfigurace';
    $Self->{Translation}->{'DeplState'} = 'DeplState';
    $Self->{Translation}->{'Deployment State Color'} = 'Barva stavu nasazení';
    $Self->{Translation}->{'DeploymentState'} = 'DeploymentState';
    $Self->{Translation}->{'Duplicate'} = 'Duplikace';
    $Self->{Translation}->{'Dynamic field event module that marks config item definitions as out of sync, if containing dynamic fields change.'} =
        'Modul událostí dynamických polí, který označí definice položek konfigurace jako nesynchronizované, pokud se změní dynamická pole.';
    $Self->{Translation}->{'Dynamic fields shown in the additional ITSM field screen of the agent interface.'} =
        'Dynamická pole zobrazená na obrazovce dodatečných polí ITSM v rozhraní agenta.';
    $Self->{Translation}->{'Dynamic fields shown in the config item overview screen of the customer interface.'} =
        'Dynamická pole zobrazená na obrazovce přehledu konfiguračních položek v zákaznickém rozhraní.';
    $Self->{Translation}->{'Dynamic fields shown in the config item search screen of the agent interface.'} =
        'Dynamická pole zobrazená na obrazovce vyhledávání položek konfigurace v rozhraní agenta.';
    $Self->{Translation}->{'Enables configuration item bulk action feature for the agent frontend to work on more than one configuration item at a time.'} =
        'Povoluje funkci hromadné akce konfigurační položky pro frontend agenta, aby bylo možné pracovat s více než jednou konfigurační položkou najednou.';
    $Self->{Translation}->{'Enables configuration item bulk action feature only for the listed groups.'} =
        'Povolí funkci hromadné akce konfigurační položky pouze pro uvedené skupiny.';
    $Self->{Translation}->{'Enables/disables the functionality to check ITSM onfiguration items for unique names. Before enabling this option you should check your system for already existing config items with duplicate names. You can do this with the console command Admin::ITSM::Configitem::ListDuplicates.'} =
        'Povoluje/zakazuje funkci kontroly jedinečných názvů položek konfigurace ITSM. Před povolením této možnosti byste měli zkontrolovat systém, zda již neexistují konfigurační položky s duplicitními názvy. To můžete provést pomocí konzolového příkazu Admin::ITSM::Configitem::ListDuplicates.';
    $Self->{Translation}->{'Event module to set configitem-status on ticket-configitem-link.'} =
        'Modul událostí pro nastavení configitem-status na ticket-configitem-link.';
    $Self->{Translation}->{'Fields of the configuration item index, used for the fulltext search. Fields are also stored, but are not mandatory for the overall functionality. Inclusion of attachments can be disabled by setting the entry to 0 or deleting it.'} =
        'Pole indexu položky konfigurace, která se používají pro fulltextové vyhledávání. Pole jsou rovněž uložena, ale pro celkovou funkčnost nejsou povinná. Zahrnutí příloh lze zakázat nastavením položky na hodnotu 0 nebo jejím odstraněním.';
    $Self->{Translation}->{'Fields stored in the configuration item index which are used for other things besides fulltext searches. For the complete functionality all fields are mandatory.'} =
        'Pole uložená v indexu položek konfigurace, která se kromě fulltextového vyhledávání používají i k jiným účelům. Pro úplnou funkčnost jsou všechna pole povinná.';
    $Self->{Translation}->{'For every webservice (key) an array of classes (value) can be defined on which the import is restricted. For all chosen classes, or all existing classes the identifying attributes will have to be chosen in the invoker config.'} =
        'Pro každou webovou službu (klíč) lze definovat pole tříd (hodnota), na které je import omezen. Pro všechny zvolené třídy nebo všechny existující třídy bude třeba v konfiguraci invokeru zvolit identifikační atributy.';
    $Self->{Translation}->{'GenericInterface module registration for the ConfigItemFetch invoker layer.'} =
        'Registrace modulu GenericInterface pro vrstvu vyvolávače ConfigItemFetch.';
    $Self->{Translation}->{'ITSM ConfigItem'} = 'ITSM ConfigItem';
    $Self->{Translation}->{'ITSM config item overview.'} = 'Přehled položek konfigurace ITSM.';
    $Self->{Translation}->{'If this option is activated, linked items are only counted if they belong to one of the listed classes.'} =
        '';
    $Self->{Translation}->{'InciState'} = 'InciState';
    $Self->{Translation}->{'IncidentState'} = 'IncidentState';
    $Self->{Translation}->{'Includes deployment states in the config item search of the customer interface.'} =
        'Zahrnuje stavy nasazení do vyhledávání položek konfigurace v zákaznickém rozhraní.';
    $Self->{Translation}->{'Includes incident states in the config item search of the customer interface.'} =
        'Zahrnuje stavy incidentů do vyhledávání položek konfigurace v zákaznickém rozhraní.';
    $Self->{Translation}->{'Maximum number of config items to be displayed in the result of this operation.'} =
        'Maximální počet konfiguračních položek, které se zobrazí ve výsledku této operace.';
    $Self->{Translation}->{'Module to check the group responsible for a class.'} = 'Modul pro kontrolu skupiny odpovědné za třídu.';
    $Self->{Translation}->{'Module to check the group responsible for a configuration item.'} =
        'Modul pro kontrolu skupiny odpovědné za položku konfigurace.';
    $Self->{Translation}->{'Module to generate ITSM config item statistics.'} = 'Modul pro generování statistik položek konfigurace ITSM.';
    $Self->{Translation}->{'Name Module'} = 'Název modulu';
    $Self->{Translation}->{'Number Module'} = 'Číselný modul';
    $Self->{Translation}->{'Number of config items to be displayed in each page of a search result in the agent interface.'} =
        'Počet konfiguračních položek, které se mají zobrazit na každé stránce výsledku vyhledávání v rozhraní agenta.';
    $Self->{Translation}->{'Number of config items to be displayed in each page of a search result in the customer interface.'} =
        'Počet konfiguračních položek, které se mají zobrazit na každé stránce výsledku vyhledávání v zákaznickém rozhraní.';
    $Self->{Translation}->{'Objects to search for, how many entries and which attributs to show. ConfigItem attributes have to explicitly be stored via Elasticsearch.'} =
        'Objekty, které se mají vyhledat, kolik záznamů a které atributy se mají zobrazit. Atributy ConfigItem musí být explicitně uloženy prostřednictvím Elasticsearch.';
    $Self->{Translation}->{'Overview.'} = 'Přehled.';
    $Self->{Translation}->{'Parameters for the categories for config item classes in the preferences view of the agent interface.'} =
        'Parametry pro kategorie tříd konfiguračních položek v zobrazení předvoleb rozhraní agenta.';
    $Self->{Translation}->{'Parameters for the column filters of the small config item overview. Please note: setting \'Active\' to 0 will only prevent agents from editing settings of this group in their personal preferences, but will still allow administrators to edit the settings of another user\'s behalf. Use \'PreferenceGroup\' to control in which area these settings should be shown in the user interface.'} =
        'Parametry pro filtry sloupců přehledu malých konfiguračních položek. Upozornění: Nastavení hodnoty "Aktivní" na 0 pouze zabrání agentům upravovat nastavení této skupiny v jejich osobních preferencích, ale správcům stále umožní upravovat nastavení jménem jiného uživatele. Pomocí \'PreferenceGroup\' můžete řídit, ve které oblasti se mají tato nastavení v uživatelském rozhraní zobrazovat.';
    $Self->{Translation}->{'Parameters for the dashboard backend of the customer company config item overview of the agent interface . "Limit" is the number of entries shown by default. "Group" is used to restrict the access to the plugin (e. g. Group: admin;group1;group2;). "Default" determines if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" is the cache time in minutes for the plugin.'} =
        'Parametry pro backend dashboardu přehledu konfiguračních položek zákaznické firmy rozhraní agenta . "Limit" je počet položek zobrazených ve výchozím nastavení. "Group" slouží k omezení přístupu k zásuvnému modulu (např. Group: admin;group1;group2;). "Default" určuje, zda je zásuvný modul ve výchozím nastavení povolen, nebo zda jej uživatel musí povolit ručně. "CacheTTLLocal" je doba cache v minutách pro zásuvný modul.';
    $Self->{Translation}->{'Parameters for the deployment states color in the preferences view of the agent interface.'} =
        'Parametry pro stavy nasazení se vybarví v zobrazení předvoleb rozhraní agenta.';
    $Self->{Translation}->{'Parameters for the deployment states in the preferences view of the agent interface.'} =
        'Parametry pro stavy nasazení v zobrazení předvoleb rozhraní agenta.';
    $Self->{Translation}->{'Parameters for the example permission groups of the general catalog attributes.'} =
        'Parametry skupiny pro příklad oprávnění obecných atributů katalogu';
    $Self->{Translation}->{'Parameters for the name module for config item classes in the preferences view of the agent interface.'} =
        'Parametry modulu názvů pro třídy konfiguračních položek v zobrazení předvoleb rozhraní agenta.';
    $Self->{Translation}->{'Parameters for the number module for config item classes in the preferences view of the agent interface.'} =
        'Parametry modulu čísel pro třídy konfiguračních položek v zobrazení předvoleb rozhraní agenta.';
    $Self->{Translation}->{'Parameters for the pages (in which the configuration items are shown).'} =
        'Parametry stránek (na kterých se zobrazují konfigurační položky).';
    $Self->{Translation}->{'Parameters for the version string module for config item classes in the preferences view of the agent interface.'} =
        'Parametry modulu řetězce verze pro třídy konfiguračních položek v zobrazení předvoleb rozhraní agenta.';
    $Self->{Translation}->{'Parameters for the version string template toolkit module for config item classes in the preferences view of the agent interface.'} =
        'Parametry modulu šablony řetězce verze sady nástrojů pro třídy konfiguračních položek v zobrazení předvoleb rozhraní agenta.';
    $Self->{Translation}->{'Parameters for the version trigger for config item classes in the preferences view of the agent interface.'} =
        'Parametry pro spouštěč verze pro třídy položek konfigurace v zobrazení předvoleb rozhraní agenta.';
    $Self->{Translation}->{'Performs the configured action for each event (as an Invoker) for each configured Webservice.'} =
        'Provede nakonfigurovanou akci pro každou událost (jako Invoker) pro každou nakonfigurovanou webovou službu.';
    $Self->{Translation}->{'Permission Group'} = 'Skupina oprávnění';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item attachment action in the agent interface.'} =
        'Požadovaná oprávnění pro použití akce připojení položky konfigurace ITSM v rozhraní agenta.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item screen in the agent interface.'} =
        'Požadovaná oprávnění pro použití obrazovky položky konfigurace ITSM v rozhraní agenta.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item search screen in the agent interface.'} =
        'Požadovaná oprávnění pro použití obrazovky pro vyhledávání položek konfigurace ITSM v rozhraní agenta.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item search screen in the customer interface.'} =
        'Požadovaná oprávnění pro použití obrazovky pro vyhledávání položek konfigurace ITSM v zákaznickém rozhraní.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item tree view screen in the agent interface.'} =
        'Požadovaná oprávnění pro použití obrazovky zobrazení stromu položek konfigurace ITSM v rozhraní agenta.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item zoom screen in the agent interface.'} =
        'Požadovaná oprávnění pro použití obrazovky zvětšení položky konfigurace ITSM v rozhraní agenta.';
    $Self->{Translation}->{'Required permissions to use the add ITSM configuration item screen in the agent interface.'} =
        'Odkaz na %s (type=%s) odstraněn';
    $Self->{Translation}->{'Required permissions to use the bulk ITSM configuration item screen in the agent interface.'} =
        'Požadovaná oprávnění pro použití obrazovky položky hromadné konfigurace ITSM v rozhraní agenta.';
    $Self->{Translation}->{'Required permissions to use the edit ITSM configuration item screen in the agent interface.'} =
        'Požadovaná oprávnění pro použití obrazovky pro úpravu položky konfigurace ITSM v rozhraní agenta.';
    $Self->{Translation}->{'Required permissions to use the history ITSM configuration item screen in the agent interface.'} =
        'Požadovaná oprávnění pro použití obrazovky položky konfigurace historie ITSM v rozhraní agenta.';
    $Self->{Translation}->{'Required permissions to use the print ITSM configuration item screen in the agent interface.'} =
        'Požadovaná oprávnění pro použití obrazovky s položkou konfigurace tisku ITSM v rozhraní agenta.';
    $Self->{Translation}->{'Required privileges to delete config items.'} = 'Požadovaná oprávnění k odstranění položek konfigurace.';
    $Self->{Translation}->{'Search config items.'} = 'Vyhledávání položek konfigurace.';
    $Self->{Translation}->{'Set the incident state of a CI automatically when a Ticket is Linked to a CI.'} =
        'Automatické nastavení stavu incidentu CI, když je tiket propojen s CI.';
    $Self->{Translation}->{'Sets the deployment state in the configuration item bulk screen of the agent interface.'} =
        'Nastaví stav nasazení na obrazovce hromadné položky konfigurace rozhraní agenta.';
    $Self->{Translation}->{'Sets the incident state in the configuration item bulk screen of the agent interface.'} =
        'Nastaví stav události na obrazovce hromadné položky konfigurace rozhraní agenta.';
    $Self->{Translation}->{'Shows a link in the menu that allows linking a configuration item with another object in the config item zoom view of the agent interface.'} =
        'Zobrazí odkaz v nabídce, který umožňuje propojit konfigurační položku s jiným objektem v zobrazení zvětšení konfigurační položky v rozhraní agenta.';
    $Self->{Translation}->{'Shows a link in the menu to access the history of a configuration item in the configuration item overview of the agent interface.'} =
        'Zobrazí odkaz v nabídce pro přístup k historii konfigurační položky v přehledu konfiguračních položek rozhraní agenta.';
    $Self->{Translation}->{'Shows a link in the menu to access the history of a configuration item in the its zoom view of the agent interface.'} =
        'Zobrazí odkaz v nabídce pro přístup k historii položky konfigurace v zobrazení agenta s přiblížením.';
    $Self->{Translation}->{'Shows a link in the menu to delete a configuration item in its zoom view of the agent interface.'} =
        'Zobrazí odkaz v nabídce pro odstranění položky konfigurace v jejím zvětšeném zobrazení rozhraní agenta.';
    $Self->{Translation}->{'Shows a link in the menu to display the configuration item links as a Tree View.'} =
        'Zobrazí odkaz v nabídce pro zobrazení odkazů na položky konfigurace ve stromovém zobrazení.';
    $Self->{Translation}->{'Shows a link in the menu to duplicate a configuration item in the configuration item overview of the agent interface.'} =
        'Zobrazí odkaz v nabídce pro duplikování konfigurační položky v přehledu konfiguračních položek rozhraní agenta.';
    $Self->{Translation}->{'Shows a link in the menu to duplicate a configuration item in the its zoom view of the agent interface.'} =
        'Zobrazí odkaz v nabídce pro duplikování položky konfigurace v zobrazení agenta s přiblížením.';
    $Self->{Translation}->{'Shows a link in the menu to edit a configuration item in the its zoom view of the agent interface.'} =
        'Zobrazí odkaz v nabídce pro úpravu položky konfigurace v zobrazení agenta s přiblížením.';
    $Self->{Translation}->{'Shows a link in the menu to go back in the configuration item zoom view of the agent interface.'} =
        'Zobrazí odkaz v nabídce pro návrat zpět do zobrazení zvětšení konfigurační položky rozhraní agenta.';
    $Self->{Translation}->{'Shows a link in the menu to print a configuration item in the its zoom view of the agent interface.'} =
        'Zobrazí odkaz v nabídce pro tisk konfigurační položky v jejím zvětšeném zobrazení rozhraní agenta.';
    $Self->{Translation}->{'Shows a link in the menu to zoom into a configuration item in the configuration item overview of the agent interface.'} =
        'Zobrazí odkaz v nabídce pro přiblížení konfigurační položky v přehledu konfiguračních položek rozhraní agenta.';
    $Self->{Translation}->{'Shows the config item history (reverse ordered) in the agent interface.'} =
        'Zobrazí historii konfiguračních položek (v opačném pořadí) v rozhraní agenta.';
    $Self->{Translation}->{'The default category which is shown, if none is selected.'} = 'Výchozí kategorie, která se zobrazí, pokud není vybrána žádná.';
    $Self->{Translation}->{'The identifier for a configuration item, e.g. ConfigItem#, MyConfigItem#. The default is ConfigItem#.'} =
        'Identifikátor konfigurační položky, např. ConfigItem#, MyConfigItem#. Výchozí je ConfigItem#.';
    $Self->{Translation}->{'Triggers ConfigItemFetch invoker automatically.'} = 'Automaticky spouští invokátor ConfigItemFetch.';
    $Self->{Translation}->{'Version String Expression'} = 'Verze Řetězcový výraz';
    $Self->{Translation}->{'Version String Module'} = 'Modul Version String';
    $Self->{Translation}->{'Version Trigger'} = 'Spouštěč verze';
    $Self->{Translation}->{'Whether the execution of ConfigItemACL can be avoided by checking cached field dependencies. This can improve loading times of formulars, but has to be disabled, if ACLModules are to be used for ITSMConfigItem- and Form-ReturnTypes.'} =
        'Zda se lze vyhnout provedení ConfigItemACL kontrolou závislostí polí uložených v mezipaměti. To může zlepšit časy načítání formulářů, ale musí to být zakázáno, pokud se mají používat ACLModuly pro typy ITSMConfigItem- a Form-ReturnTypes.';
    $Self->{Translation}->{'Which general information is shown in the header.'} = 'Které obecné informace jsou uvedeny v záhlaví.';
    $Self->{Translation}->{'With this option it´s possible to fill automaticly a CI field, depending on the count of linked CI´s with the existing type DependsOn.'} =
        '';
    $Self->{Translation}->{'With this option it´s possible to fill automaticly a CI field, depending on the count of linked CI´s.'} =
        '';
    $Self->{Translation}->{'With this option it´s possible to fill automaticly a CI field, depending on the count of linked CI´s. The setting CounterClassName include the name of the class and CounterFieldName is used to store the count of used licence.'} =
        '';
    $Self->{Translation}->{'class'} = 'třída';
    $Self->{Translation}->{'global'} = 'globální';
    $Self->{Translation}->{'postproductive'} = 'postproduktivní';
    $Self->{Translation}->{'preproductive'} = 'předprodukční';
    $Self->{Translation}->{'productive'} = 'produktivní';


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

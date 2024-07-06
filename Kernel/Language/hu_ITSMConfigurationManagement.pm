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

package Kernel::Language::hu_ITSMConfigurationManagement;

use strict;
use warnings;
use utf8;

sub Data {
    my $Self = shift;

    # Template: AdminITSMConfigItem
    $Self->{Translation}->{'Config Item Management'} = 'Konfigurációelem-menedzsment';
    $Self->{Translation}->{'Change class definition'} = 'Osztály-meghatározás módosítása';
    $Self->{Translation}->{'Change role definition'} = 'Szerepdefiníció módosítása';
    $Self->{Translation}->{'Ready2Import Class Bundles'} = 'Ready2Import osztálycsomagok';
    $Self->{Translation}->{'Here you can import Ready2Import class bundles showcasing our most usual config items. Please note that some additional configuration may be required.'} =
        'Itt importálhatja a Ready2Import osztálycsomagokat, amelyek a legáltalánosabb konfigurációs elemeket mutatják be. Kérjük, vegye figyelembe, hogy néhány további konfigurációra lehet szükség.';
    $Self->{Translation}->{'Update existing entities'} = 'Meglévő entitások frissítése';
    $Self->{Translation}->{'Import Ready2Adopt class bundles'} = 'Ready2Adopt osztálycsomagok importálása';
    $Self->{Translation}->{'Config Item Class'} = 'Konfigurációelem-osztály';
    $Self->{Translation}->{'Config Item Role'} = 'Konfigurációs elem szerepe';

    # Template: AgentITSMConfigItemAdd
    $Self->{Translation}->{'Config Item'} = 'Konfigurációelem';
    $Self->{Translation}->{'Filter for Classes'} = 'Szűrő az osztályokhoz';
    $Self->{Translation}->{'Select a Class from the list to create a new Config Item.'} = 'Válasszon egy osztályt a listából egy új konfigurációelem létrehozásához.';
    $Self->{Translation}->{'Class'} = 'Osztály';

    # Template: AgentITSMConfigItemBulk
    $Self->{Translation}->{'ITSM ConfigItem Bulk Action'} = 'ITSM konfigurációelem tömeges művelet';
    $Self->{Translation}->{'Deployment state'} = 'Üzembe állítási állapot';
    $Self->{Translation}->{'Incident state'} = 'Incidensállapot';
    $Self->{Translation}->{'Link to another'} = 'Hivatkozás egy másik';
    $Self->{Translation}->{'Invalid Configuration Item number!'} = 'Érvénytelen konfigurációelem-szám!';
    $Self->{Translation}->{'The number of another Configuration Item to link with.'} = 'Egy másik konfigurációelem száma, amellyel össze kell kötni.';

    # Template: AgentITSMConfigItemDelete
    $Self->{Translation}->{'Do you really want to delete this config item?'} = 'Valóban törölni szeretné ezt a konfigurációelemet?';

    # Template: AgentITSMConfigItemEdit
    $Self->{Translation}->{'The name of this config item'} = 'A konfigurációelem neve';
    $Self->{Translation}->{'Name is already in use by the ConfigItems with the following Number(s): %s'} =
        'A nevet már használják a konfigurációelemek a következő számokkal: %s';
    $Self->{Translation}->{'Version Number'} = 'Verziószám';
    $Self->{Translation}->{'Version number of this config item'} = 'A konfigurációs elem verziószáma';
    $Self->{Translation}->{'Version Number is already in use by the ConfigItems with the following Number(s): %s'} =
        'A verziószám már használatban van a ConfigItems által a következő számmal (számokkal): %s';
    $Self->{Translation}->{'Deployment State'} = 'Üzembe állítási állapot';
    $Self->{Translation}->{'Incident State'} = 'Incidensállapot';

    # Template: AgentITSMConfigItemHistory
    $Self->{Translation}->{'History of Config Item: %s'} = 'Konfigurációelem előzményei: %s';
    $Self->{Translation}->{'History Content'} = 'Előzménytartalom';
    $Self->{Translation}->{'Createtime'} = 'Létrehozás ideje';
    $Self->{Translation}->{'Zoom view'} = 'Nagyítási nézet';

    # Template: AgentITSMConfigItemOverviewNavBar
    $Self->{Translation}->{'Config Items per page'} = 'Konfigurációelemek oldalanként';

    # Template: AgentITSMConfigItemOverviewSmall
    $Self->{Translation}->{'No config item data found.'} = 'Nem találtunk konfigurációs elemadatot.';
    $Self->{Translation}->{'Select this config item'} = 'Válassza ki ezt a konfigurációs elemet';

    # Template: AgentITSMConfigItemSearch
    $Self->{Translation}->{'Run Search'} = 'Keresés futtatása';
    $Self->{Translation}->{'Also search in previous versions?'} = 'Keressen az előző verziókban is?';

    # Template: AgentITSMConfigItemTreeView
    $Self->{Translation}->{'TreeView for ConfigItem'} = 'TreeView a ConfigItem számára';
    $Self->{Translation}->{'Depth Level'} = 'Mélységi szint';
    $Self->{Translation}->{'Zoom In/Out'} = 'Nagyítás/ kicsinyítés';
    $Self->{Translation}->{'Max links level reached for ConfigItem!'} = 'A ConfigItem maximális hivatkozási szintje elérte!';

    # Template: AgentITSMConfigItemZoom
    $Self->{Translation}->{'Configuration Item'} = 'Konfigurációelem';
    $Self->{Translation}->{'Configuration Item Information'} = 'Konfigurációelem-információk';
    $Self->{Translation}->{'Current Deployment State'} = 'Jelenlegi üzembe állítási állapot';
    $Self->{Translation}->{'Current Incident State'} = 'Jelenlegi incidensállapot';
    $Self->{Translation}->{'Last changed'} = 'Utolsó módosítás';
    $Self->{Translation}->{'Last changed by'} = 'Utoljára módosította';

    # Template: CustomerITSMConfigItem
    $Self->{Translation}->{'Your ConfigItems'} = 'Az Ön ConfigItems';

    # Template: CustomerITSMConfigItemSearch
    $Self->{Translation}->{'ConfigItem Search'} = 'ConfigItem keresés';

    # Template: AdminACL
    $Self->{Translation}->{'Object Type'} = 'Objektum típusa';

    # JS Template: ClassImportConfirm
    $Self->{Translation}->{'The following classes will be imported'} = 'A következő osztályok kerülnek importálásra';
    $Self->{Translation}->{'The following roles will be imported'} = 'A következő szerepkörök kerülnek importálásra';
    $Self->{Translation}->{'Note that also corresponding dynamic fields and GeneralCatalog classes will be created and there is no automatic removal.'} =
        'Vegye figyelembe, hogy a megfelelő dinamikus mezők és GeneralCatalog osztályok is létrejönnek, és nincs automatikus eltávolítás.';
    $Self->{Translation}->{'Do you want to proceed?'} = 'Szeretné folytatni?';

    # Perl Module: Kernel/Modules/AdminITSMConfigItem.pm
    $Self->{Translation}->{'Need ExampleClasses!'} = 'Szükség van ExampleClasses!';
    $Self->{Translation}->{'Definition is no valid YAML hash.'} = 'A definíció nem érvényes YAML hash.';

    # Perl Module: Kernel/Modules/AgentITSMConfigItem.pm
    $Self->{Translation}->{'Overview: ITSM ConfigItem'} = 'Áttekintés: ITSM konfigurációelem';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemBulk.pm
    $Self->{Translation}->{'No ConfigItemID is given!'} = 'Nincs konfigurációelem-azonosító megadva!';
    $Self->{Translation}->{'You need at least one selected Configuration Item!'} = 'Szüksége van legalább egy kiválasztott konfigurációelemre!';
    $Self->{Translation}->{'You don\'t have write access to this configuration item: %s.'} =
        'Nincs írási hozzáférése ehhez a konfigurációelemhez: %s.';
    $Self->{Translation}->{'No definition was defined for class %s!'} = 'Nincs meghatározás meghatározva a(z) %s osztályhoz!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemDelete.pm
    $Self->{Translation}->{'Config item "%s" not found in database!'} = 'A(z) „%s” konfigurációelem nem található az adatbázisban!';
    $Self->{Translation}->{'Was not able to delete the configitem ID %s!'} = 'Nem volt lehetséges a(z) %s konfigurációelem-azonosító törlése!';
    $Self->{Translation}->{'No version found for ConfigItemID %s!'} = 'Nem található verzió a(z) %s konfigurációelem-azonosítónál!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemEdit.pm
    $Self->{Translation}->{'No ConfigItemID, DuplicateID or ClassID is given!'} = 'Nincs konfigurációelem-azonosító, kettőzésazonosító vagy osztályazonosító megadva!';
    $Self->{Translation}->{'No access is given!'} = 'Nincs hozzáférés megadva!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemHistory.pm
    $Self->{Translation}->{'Can\'t show history, no ConfigItemID is given!'} = 'Nem lehet megjeleníteni az előzményeket, nincs konfigurációelem-azonosító megadva!';
    $Self->{Translation}->{'Can\'t show history, no access rights given!'} = 'Nem lehet megjeleníteni az előzményeket, nincsenek hozzáférési jogok megadva!';
    $Self->{Translation}->{'New ConfigItem (ID=%s)'} = 'Új konfigurációelem (azonosító = %s)';
    $Self->{Translation}->{'New version (ID=%s)'} = 'Új verzió (azonosító = %s)';
    $Self->{Translation}->{'Deployment state updated (new=%s, old=%s)'} = 'Üzembe állítási állapot frissítve (új = %s, régi = %s)';
    $Self->{Translation}->{'Incident state updated (new=%s, old=%s)'} = 'Incidensállapot frissítve (új = %s, régi = %s)';
    $Self->{Translation}->{'ConfigItem (ID=%s) deleted'} = 'Konfigurációelem (azonosító = %s) törölve';
    $Self->{Translation}->{'Link to %s (type=%s) added'} = 'Kapcsolat ehhez: %s (típus = %s) hozzáadva';
    $Self->{Translation}->{'Link to %s (type=%s) deleted'} = 'Kapcsolat ehhez: %s (típus = %s) törölve';
    $Self->{Translation}->{'ConfigItem definition updated (ID=%s)'} = 'Konfigurációelem-meghatározás frissítve (azonosító = %s)';
    $Self->{Translation}->{'Name updated (new=%s, old=%s)'} = 'Név frissítve (új = %s, régi = %s)';
    $Self->{Translation}->{'Attribute %s updated from "%s" to "%s"'} = 'Attribútum (%s) frissítve erről: „%s”, erre: „%s”';
    $Self->{Translation}->{'Version %s deleted'} = '%s. verzió törölve';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemPrint.pm
    $Self->{Translation}->{'No ConfigItemID or VersionID is given!'} = 'Nincs konfigurációelem-azonosító vagy verzióazonosító megadva!';
    $Self->{Translation}->{'Can\'t show config item, no access rights given!'} = 'Nem lehet megjeleníteni a konfigurációelemet, nincsenek hozzáférési jogok megadva!';
    $Self->{Translation}->{'ConfigItemID %s not found in database!'} = 'A(z) %s konfigurációelem-azonosító nem található az adatbázisban!';
    $Self->{Translation}->{'ConfigItem'} = 'Konfigurációelem';
    $Self->{Translation}->{'printed by %s at %s'} = 'nyomtatta: %s – %s';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemSearch.pm
    $Self->{Translation}->{'Invalid ClassID!'} = 'Érvénytelen osztályazonosító!';
    $Self->{Translation}->{'No ClassID is given!'} = 'Nincs osztályazonosító megadva!';
    $Self->{Translation}->{'No access rights for this class given!'} = 'Nincsenek hozzáférési jogok megadva ehhez az osztályhoz!';
    $Self->{Translation}->{'No Result!'} = 'Nincs találat!';
    $Self->{Translation}->{'Config Item Search Results'} = 'Konfigurációelem keresési eredmények';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemZoom.pm
    $Self->{Translation}->{'Can\'t show item, no access rights for ConfigItem are given!'} =
        'Nem lehet megjeleníteni az elemet, nincsenek hozzáférési jogok megadva a konfigurációelemhez!';
    $Self->{Translation}->{'ConfigItem not found!'} = 'ConfigItem nem található!';
    $Self->{Translation}->{'No versions found!'} = 'Nem találtunk verziót!';
    $Self->{Translation}->{'operational'} = 'üzemképes';
    $Self->{Translation}->{'warning'} = 'figyelmeztetés';
    $Self->{Translation}->{'incident'} = 'incidens';
    $Self->{Translation}->{'The deployment state of this config item'} = 'A konfigurációelem üzembe állítási állapota';
    $Self->{Translation}->{'The incident state of this config item'} = 'A konfigurációelem incidensállapota';

    # Perl Module: Kernel/Modules/CustomerITSMConfigItemSearch.pm
    $Self->{Translation}->{'No permission'} = 'Nincs jogosultság';
    $Self->{Translation}->{'Filter invalid!'} = 'Szűrő érvénytelen!';
    $Self->{Translation}->{'Search params invalid!'} = 'Search params érvénytelen!';

    # Perl Module: Kernel/Output/HTML/Dashboard/ITSMConfigItemGeneric.pm
    $Self->{Translation}->{'Shown config items'} = 'Megjelenített konfigurációelemek';
    $Self->{Translation}->{'Deployment State Type'} = 'Üzembe állítási állapottípus';
    $Self->{Translation}->{'Current Incident State Type'} = 'Jelenlegi incidensállapot típus';

    # Perl Module: Kernel/Output/HTML/ITSMConfigItem/LayoutDate.pm
    $Self->{Translation}->{'Between'} = 'Között';

    # Perl Module: Kernel/System/DynamicField/Driver/ConfigItem.pm
    $Self->{Translation}->{'Class restrictions for the config item'} = 'Osztálykorlátozások a konfigurációs elemhez';
    $Self->{Translation}->{'Select one or more classes to restrict selectable config items'} =
        'Egy vagy több osztály kiválasztása a választható konfigurációs elemek korlátozásához';
    $Self->{Translation}->{'Link type'} = 'Link típusa';
    $Self->{Translation}->{'Select the link type.'} = 'Válassza ki a link típusát.';
    $Self->{Translation}->{'Forwards: Referencing (Source) -> Referenced (Target)'} = 'Előre: (Forrás) -> Hivatkozás (Cél)';
    $Self->{Translation}->{'Backwards: Referenced (Source) -> Referencing (Target)'} = 'Hátrafelé: Hivatkozás (Forrás) -> Hivatkozás (Cél)';
    $Self->{Translation}->{'Link Direction'} = 'Link iránya';
    $Self->{Translation}->{'The referencing object is the one containing this dynamic field, the referenced object is the one selected as value of the dynamic field.'} =
        'A hivatkozó objektum az, amelyik tartalmazza ezt a dinamikus mezőt, a hivatkozott objektum pedig az, amelyik a dinamikus mező értékeként van kiválasztva.';
    $Self->{Translation}->{'Dynamic (ConfigItem)'} = 'Dinamikus (ConfigItem)';
    $Self->{Translation}->{'Static (Version)'} = 'Static (változat)';
    $Self->{Translation}->{'Link Referencing Type'} = 'Link hivatkozási típus';
    $Self->{Translation}->{'Whether this link applies to the ConfigItem or the static version of the referencing object. Current Incident State calculation only is performed on dynamic links.'} =
        'A hivatkozás a hivatkozó objektum ConfigItem vagy statikus változatára vonatkozik-e. Az aktuális incidensállapot számítása csak dinamikus hivatkozások esetén történik.';
    $Self->{Translation}->{'Select the attribute which config items will be searched by'} = 'Válassza ki azt az attribútumot, amely alapján a konfigurációs elemeket keresni fogják.';

    # Perl Module: Kernel/System/ITSMConfigItem/Definition.pm
    $Self->{Translation}->{'Base structure is not valid. Please provide a hash with data in YAML format.'} =
        'Az alapszerkezet nem érvényes. Kérjük, adjon meg egy hash-t az adatokkal YAML formátumban.';
    $Self->{Translation}->{'Starting the YAML string with \'---\' is required.'} = 'A YAML karakterláncot \'---\'-val kell kezdeni.';

    # Perl Module: Kernel/System/ITSMConfigItem/Link.pm
    $Self->{Translation}->{'Could not purge the table configitem_link.'} = 'Nem sikerült törölni a configitem_link táblát.';
    $Self->{Translation}->{'No relevant dynamic fields were found'} = 'Nem találtunk releváns dinamikus mezőket';
    $Self->{Translation}->{'Could not insert into the table configitem_link'} = 'Nem sikerült beszúrni a configitem_link táblázatba';
    $Self->{Translation}->{'Inserted 0 rows into the table configitem_link'} = '0 sor beszúrása a configitem_link táblába';

    # Perl Module: Kernel/System/ImportExport/ObjectBackend/ITSMConfigItem.pm
    $Self->{Translation}->{'Maximum number of one element'} = 'Egy elem legnagyobb száma';
    $Self->{Translation}->{'Empty fields indicate that the current values are kept'} = 'Az üres mezők azt jelzik, hogy az aktuális mezők megtartásra kerülnek';
    $Self->{Translation}->{'Skipped'} = 'Kihagyva';

    # Perl Module: Kernel/Modules/AdminDynamicField.pm
    $Self->{Translation}->{'Error synchronizing the definitions. Please check the log.'} = 'Hiba a definíciók szinkronizálásában. Kérjük, ellenőrizze a naplót.';
    $Self->{Translation}->{'You have ITSMConfigItem definitions which are not synchronized. Please deploy your ITSMConfigItem dynamic field changes.'} =
        'ITSMConfigItem definíciói nincsenek szinkronizálva. Kérjük, telepítse az ITSMConfigItem dinamikus mezőinek módosításait.';

    # Database XML / SOPM Definition: ITSMConfigurationManagement.sopm
    $Self->{Translation}->{'Expired'} = 'Lejárt';
    $Self->{Translation}->{'Maintenance'} = 'Karbantartás';
    $Self->{Translation}->{'Pilot'} = 'Próbaüzem';
    $Self->{Translation}->{'Planned'} = 'Tervezett';
    $Self->{Translation}->{'Repair'} = 'Javítás';
    $Self->{Translation}->{'Retired'} = 'Visszavont';
    $Self->{Translation}->{'Review'} = 'Vizsgálat';
    $Self->{Translation}->{'Test/QA'} = 'Tesztelés/QA';

    # JS File: ITSM.Admin.ITSMConfigItem
    $Self->{Translation}->{'Overview and Confirmation'} = 'Áttekintés és megerősítés';
    $Self->{Translation}->{'Importing classes/roles and their related fields'} = 'Osztályok/szerepkörök és kapcsolódó mezőik importálása';
    $Self->{Translation}->{'An error occurred during class import.'} = 'Hiba történt az osztály importálása során.';

    # SysConfig
    $Self->{Translation}->{'0 - Hidden'} = '0 - Rejtett';
    $Self->{Translation}->{'1 - Shown'} = '1 - Megjelenítve';
    $Self->{Translation}->{'Allows extended search conditions in config item search of the agent interface. With this feature you can search e. g. config item name with this kind of conditions like "(*key1*&&*key2*)" or "(*key1*||*key2*)".'} =
        'Lehetővé teszi a kiterjesztett keresési feltételeket az ügynöki felület konfigurációs elemkeresésében. Ezzel a funkcióval kereshet például a konfigurációs elem nevére olyan feltételekkel, mint "(*key1*&&*key2*)" vagy "(*key1*||*key2*)".';
    $Self->{Translation}->{'Allows extended search conditions in config item search of the customer interface. With this feature you can search e. g. config item name with this kind of conditions like "(*key1*&&*key2*)" or "(*key1*||*key2*)".'} =
        'Lehetővé teszi a kiterjesztett keresési feltételeket az ügyfélfelület konfigurációs elemkeresésében. Ezzel a funkcióval kereshet például a konfigurációs elem nevére olyan feltételekkel, mint "(*key1*&&*key2*)" vagy "(*key1*||*key2*)".';
    $Self->{Translation}->{'Assigned CIs'} = 'Hozzárendelt konfigurációelemek';
    $Self->{Translation}->{'CIs assigned to customer company'} = 'Ügyfél-vállalathoz hozzárendelt konfigurációelemek';
    $Self->{Translation}->{'CIs assigned to customer user'} = 'Ügyfél-felhasználóhoz hozzárendelt konfigurációelemek';
    $Self->{Translation}->{'CMDB Settings'} = 'CMDB beállítások';
    $Self->{Translation}->{'Check for a unique name only within the same ConfigItem class (\'class\') or globally (\'global\'), which means every existing ConfigItem is taken into account when looking for duplicates.'} =
        'Egyedi név ellenőrzése kizárólag ugyanabban a konfigurációelem osztályban („osztály”) vagy globálisan („globális”), amely azt jelenti, hogy minden meglévő konfigurációelem egy fiókba lesz felvéve a kettőzések keresésekor.';
    $Self->{Translation}->{'Choose a module to enforce a naming scheme.'} = 'Válasszon egy modult a névséma érvényesítéséhez.';
    $Self->{Translation}->{'Choose a module to enforce a number scheme.'} = 'Válasszon egy modult a számséma érvényesítéséhez.';
    $Self->{Translation}->{'Choose a module to enforce a version string scheme.'} = 'Válasszon ki egy modult a verziós karakterlánc-séma érvényesítéséhez.';
    $Self->{Translation}->{'Choose attributes to trigger the creation of a new version.'} = 'Válassza ki az új verzió létrehozását kiváltó attribútumokat.';
    $Self->{Translation}->{'Choose categories to assign to this config item class.'} = 'Válassza ki a konfigurációs elemosztályhoz rendelendő kategóriákat.';
    $Self->{Translation}->{'Column config item filters for ConfigItem Overview.'} = 'A ConfigItem Overview oszlop konfigurációs elemszűrői.';
    $Self->{Translation}->{'Columns that can be filtered in the config item overview of the agent interface. Note: Only Config Item attributes and Dynamic Fields (DynamicField_NameX) are allowed.'} =
        'Az ügynöki felület konfigurációs elemeinek áttekintésében szűrhető oszlopok. Megjegyzés: Csak a konfigurációs elem attribútumai és a dinamikus mezők (DynamicField_NameX) engedélyezettek.';
    $Self->{Translation}->{'Columns that can be filtered in the config item overview of the customer interface. Note: Only Config Item attributes and Dynamic Fields (DynamicField_NameX) are allowed.'} =
        'Az ügyfélfelület konfigurációs elemeinek áttekintésében szűrhető oszlopok. Megjegyzés: Csak a konfigurációs elem attribútumai és a dinamikus mezők (DynamicField_NameX) engedélyezettek.';
    $Self->{Translation}->{'Columns that can be filtered in the config item search result overview of the agent interface. Note: Only Config Item attributes and Dynamic Fields (DynamicField_NameX) are allowed.'} =
        'Az ügynöki felület konfigurációs elem keresési eredményeinek áttekintésében szűrhető oszlopok. Megjegyzés: Csak a Config Item attribútumok és a dinamikus mezők (DynamicField_NameX) engedélyezettek.';
    $Self->{Translation}->{'Config Items'} = 'Konfigurációelemek';
    $Self->{Translation}->{'Config item add.'} = 'Konfigurációelem hozzáadása.';
    $Self->{Translation}->{'Config item edit.'} = 'Konfigurációelem szerkesztése.';
    $Self->{Translation}->{'Config item event module that enables logging to history in the agent interface.'} =
        'Konfigurációelem esemény modul, amely engedélyezi a naplózást az előzményekbe az ügyintézői felületen.';
    $Self->{Translation}->{'Config item event module that updates config items to their current definition.'} =
        'Konfigurációs elem eseménymodul, amely frissíti a konfigurációs elemeket az aktuális definíciójukra.';
    $Self->{Translation}->{'Config item event module that updates the table configitem_ĺink.'} =
        'Konfigurációs elem eseménymodul, amely frissíti a configitem_ĺink táblázatot.';
    $Self->{Translation}->{'Config item event module updates the current incident state.'} =
        'A konfigurációs elem eseménymodul frissíti az aktuális eseményállapotot.';
    $Self->{Translation}->{'Config item history.'} = 'Konfigurációelem előzményei.';
    $Self->{Translation}->{'Config item print.'} = 'Konfigurációelem nyomtatása.';
    $Self->{Translation}->{'Config item zoom.'} = 'Konfigurációelem nagyítása.';
    $Self->{Translation}->{'ConfigItem Tree View'} = 'ConfigItem fa nézet';
    $Self->{Translation}->{'ConfigItem Version'} = 'ConfigItem verzió';
    $Self->{Translation}->{'ConfigItems of the following classes will not be stored on the Elasticsearch server. To apply this to existing CIs, the CI migration has to be run via console, after changing this option.'} =
        'A következő osztályok ConfigItems nem kerülnek tárolásra az Elasticsearch kiszolgálón. Ahhoz, hogy ezt a meglévő CI-kre alkalmazzuk, a CI migrációt a konzolon keresztül kell futtatni, miután megváltoztattuk ezt az opciót.';
    $Self->{Translation}->{'ConfigItems with the following deployment states will not be stored on the Elasticsearch server. To apply this to existing CIs, the CI migration has to be run via console, after changing this option.'} =
        'A következő telepítési állapotokkal rendelkező ConfigItems nem kerül tárolásra az Elasticsearch-kiszolgálón. A meglévő CI-kre való alkalmazáshoz a CI-migrációt a konzolon keresztül kell futtatni, miután megváltoztattuk ezt az opciót.';
    $Self->{Translation}->{'Configuration Item Limit'} = 'Konfigurációelem-korlát';
    $Self->{Translation}->{'Configuration Item limit per page.'} = 'Konfigurációelem-korlát oldalanként.';
    $Self->{Translation}->{'Configuration Management Database.'} = 'Konfigurációmenedzsment-adatbázis.';
    $Self->{Translation}->{'Configuration item bulk module.'} = 'Konfigurációelem tömeges modul.';
    $Self->{Translation}->{'Configuration item search backend router of the agent interface.'} =
        'Az ügyintézői felület konfigurációelem keresési háttérprogram útválasztója.';
    $Self->{Translation}->{'Create and manage the definitions for Configuration Items.'} = 'Meghatározások létrehozása és kezelése a konfigurációelemeknél.';
    $Self->{Translation}->{'Customers can see historic CI versions.'} = 'Az ügyfelek láthatják a korábbi CI-verziókat.';
    $Self->{Translation}->{'Customers have the possibility to manually switch between historic CI versions.'} =
        'Az ügyfeleknek lehetőségük van manuálisan váltani a korábbi CI-verziók között.';
    $Self->{Translation}->{'Default data to use on attribute for config item search screen. Example: "ITSMConfigItemCreateTimePointFormat=year;ITSMConfigItemCreateTimePointStart=Last;ITSMConfigItemCreateTimePoint=2;".'} =
        'A konfigurációs elem keresési képernyőjének attribútumán használandó alapértelmezett adatok. Példa: "ITSMConfigItemCreateTimePointFormat=year;ITSMConfigItemCreateTimePointStart=Last;ITSMConfigItemCreateTimePoint=2;".';
    $Self->{Translation}->{'Default data to use on attribute for config item search screen. Example: "ITSMConfigItemCreateTimeStartYear=2010;ITSMConfigItemCreateTimeStartMonth=10;ITSMConfigItemCreateTimeStartDay=4;ITSMConfigItemCreateTimeStopYear=2010;ITSMConfigItemCreateTimeStopMonth=11;ITSMConfigItemCreateTimeStopDay=3;".'} =
        'A konfigurációs elem keresési képernyőjének attribútumán használandó alapértelmezett adatok. Példa: "ITSMConfigItemCreateTimeStartYear=2010;ITSMConfigItemCreateTimeStartMonth=10;ITSMConfigItemCreateTimeStartDay=4;ITSMConfigItemCreateTimeStopYear=2010;ITSMConfigItemCreateTimeStopMonth=11;ITSMConfigItemCreateTimeStopDay=3;".';
    $Self->{Translation}->{'Define Actions where a settings button is available in the linked objects widget (LinkObject::ViewMode = "complex"). Please note that these Actions must have registered the following JS and CSS files: Core.AllocationList.css, Core.UI.AllocationList.js, Core.UI.Table.Sort.js, Core.Agent.TableFilters.js and Core.Agent.LinkObject.js.'} =
        'Műveletek meghatározása, ahol egy beállítások gomb érhető el a kapcsolt objektumok felületi elemen (LinkObject::ViewMode = „összetett”). Ne feledje, hogy ezeknek a műveleteknek rendelkezniük kell a következő JS és CSS fájlok regisztrálásával: Core.AllocationList.css, Core.UI.AllocationList.js, Core.UI.Table.Sort.js, Core.Agent.TableFilters.js és Core.Agent.LinkObject.js.';
    $Self->{Translation}->{'Define a Template::Toolkit scheme for version strings. Only used if Version String Module is set to TemplateToolkit.'} =
        'Template::Toolkit séma definiálása a verziósztringekhez. Csak akkor használatos, ha a Version String Module értéke TemplateToolkit.';
    $Self->{Translation}->{'Define a set of conditions under which a customer is allowed to see a config item. Conditions can optionally be restricted to certain customer groups. Name is the only mandatory attribute. If no other options are given, all config items will be visible under that category.'} =
        'Határozza meg azon feltételek körét, amelyek mellett az ügyfél láthat egy konfigurációs elemet. A feltételek opcionálisan korlátozhatók bizonyos ügyfélcsoportokra. A név az egyetlen kötelező attribútum. Ha nincs más opció megadva, akkor az összes konfigurációs elem látható lesz az adott kategória alatt.';
    $Self->{Translation}->{'Defines Required permissions to create ITSM configuration items using the Generic Interface.'} =
        'Meghatározza a szükséges jogosultságokat az ITSM konfigurációelemek létrehozásához az általános felület használatával.';
    $Self->{Translation}->{'Defines Required permissions to delete ITSM configuration items using the Generic Interface.'} =
        'Meghatározza a szükséges jogosultságokat az ITSM konfigurációelemek törléséhez az általános felület használatával.';
    $Self->{Translation}->{'Defines Required permissions to get ITSM configuration items using the Generic Interface.'} =
        'Meghatározza a szükséges jogosultságokat az ITSM konfigurációelemek lekéréséhez az általános felület használatával.';
    $Self->{Translation}->{'Defines Required permissions to search ITSM configuration items using the Generic Interface.'} =
        'Meghatározza a szükséges jogosultságokat az ITSM konfigurációelemek kereséséhez az általános felület használatával.';
    $Self->{Translation}->{'Defines Required permissions to update ITSM configuration items using the Generic Interface.'} =
        'Meghatározza a szükséges jogosultságokat az ITSM konfigurációelemek frissítéséhez az általános felület használatával.';
    $Self->{Translation}->{'Defines an overview module to show the small view of a configuration item list.'} =
        'Egy áttekintő modult határoz meg egy konfigurációelem lista kis nézetének megjelenítéséhez.';
    $Self->{Translation}->{'Defines if the link type labels must be shown in the node connections.'} =
        'Meghatározza, hogy a csomópontkapcsolatokban meg kell-e jeleníteni a kapcsolattípus címkéit.';
    $Self->{Translation}->{'Defines regular expressions individually for each ConfigItem class to check the ConfigItem name and to show corresponding error messages.'} =
        'Reguláris kifejezéseket határoz meg egyénileg minden egyes konfigurációelem osztálynál a konfigurációelem nevének ellenőrzéséhez, valamint a megfelelő hibaüzenetek megjelenítéséhez.';
    $Self->{Translation}->{'Defines the available columns of CIs in the config item overview depending on the CI class. Each entry must consist of a class name and an array of available fields for the corresponding class. Dynamic field entries have to honor the scheme DynamicField_FieldName.'} =
        'Meghatározza a CI-k elérhető oszlopait a konfigurációs elem áttekintésében a CI-osztálytól függően. Minden egyes bejegyzésnek egy osztálynévből és a megfelelő osztályhoz rendelkezésre álló mezők tömbjéből kell állnia. A dinamikus mezőbejegyzéseknek a DynamicField_FieldName sémát kell követniük.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of the agent interface.'} =
        'Meghatározza az alapértelmezett konfigurációs elem attribútumot az ügynöki felület konfigurációs elem keresési eredményének konfigurációs elem rendezéséhez.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of the customer interface.'} =
        'Meghatározza az ügyfélfelület konfigurációs elem keresési eredményének konfigurációs elem rendezéséhez használt alapértelmezett konfigurációs elem attribútumot.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of this operation.'} =
        'Meghatározza az alapértelmezett konfigurációs elem attribútumot a művelet konfigurációs elem keresési eredményének konfigurációs elem rendezéséhez.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the agent interface. Up: oldest on top. Down: latest on top.'} =
        'Meghatározza a konfigurációs elemek alapértelmezett sorrendjét az ügynöki felület konfigurációs elemkeresési eredményében. Felfelé: a legrégebbi a tetején. Lefelé: a legfrissebb van felül.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the customer interface. Up: oldest on top. Down: latest on top.'} =
        'Meghatározza a konfigurációs elemek alapértelmezett sorrendjét az ügyfélfelület konfigurációs elem keresési eredményében. Felfelé: a legrégebbi felül. Lefelé: a legfrissebb van felül.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the this operation. Up: oldest on top. Down: latest on top.'} =
        'Meghatározza a konfigurációs elemek alapértelmezett sorrendjét a konfigurációs elemek keresési eredményében. Felfelé: a legrégebbi felül. Lefelé: a legfrissebb a tetején.';
    $Self->{Translation}->{'Defines the default displayed columns of CIs in the config item overview depending on the CI class. Each entry must consist of a class name and an array of available fields for the corresponding class. Dynamic field entries have to honor the scheme DynamicField_FieldName.'} =
        'Meghatározza a CI-k alapértelmezett megjelenített oszlopait a konfigurációs elem áttekintésében a CI-osztálytól függően. Minden bejegyzésnek egy osztálynévből és a megfelelő osztályhoz rendelkezésre álló mezők tömbjéből kell állnia. A dinamikus mezőbejegyzéseknek a DynamicField_FieldName sémát kell követniük.';
    $Self->{Translation}->{'Defines the default relations depth to be shown.'} = 'Meghatározza a megjelenítendő kapcsolatok alapértelmezett mélységét.';
    $Self->{Translation}->{'Defines the default shown config item search attribute for config item search screen.'} =
        'Meghatározza az alapértelmezett megjelenített konfigurációs elem keresési attribútumot a konfigurációs elem keresési képernyőn.';
    $Self->{Translation}->{'Defines the default shown config item search attribute for config item search screen. Example: "Key" must have the name of the Dynamic Field in this case \'X\', "Content" must have the value of the Dynamic Field depending on the Dynamic Field type,  Text: \'a text\', Dropdown: \'1\', Date/Time: \'Search_DynamicField_XTimeSlotStartYear=1974; Search_DynamicField_XTimeSlotStartMonth=01; Search_DynamicField_XTimeSlotStartDay=26; Search_DynamicField_XTimeSlotStartHour=00; Search_DynamicField_XTimeSlotStartMinute=00; Search_DynamicField_XTimeSlotStartSecond=00; Search_DynamicField_XTimeSlotStopYear=2013; Search_DynamicField_XTimeSlotStopMonth=01; Search_DynamicField_XTimeSlotStopDay=26; Search_DynamicField_XTimeSlotStopHour=23; Search_DynamicField_XTimeSlotStopMinute=59; Search_DynamicField_XTimeSlotStopSecond=59;\' and or \'Search_DynamicField_XTimePointFormat=week; Search_DynamicField_XTimePointStart=Before; Search_DynamicField_XTimePointValue=7\';.'} =
        'Meghatározza az alapértelmezett megjelenített konfigurációs elem keresési attribútumot a konfigurációs elem keresési képernyőn. Példa: "Key" a dinamikus mező neve, ebben az esetben \'X\', "Content" a dinamikus mező értéke a dinamikus mező típusától függően, Text: \'a text\', Dropdown: \'1\', Date/Time: \'Search_DynamicField_XTimeSlotStartYear=1974; Search_DynamicField_XTimeSlotStartMonth=01; Search_DynamicField_XTimeSlotStartDay=26; Search_DynamicField_XTimeSlotStartHour=00; Search_DynamicField_XTimeSlotStartMinute=00; Search_DynamicField_XTimeSlotStartSecond=00; Search_DynamicField_XTimeSlotStopYear=2013; Search_DynamicField_XTimeSlotStopMonth=01; Search_DynamicField_XTimeSlotStopDay=26; Search_DynamicField_XTimeSlotStopHour=23; Search_DynamicField_XTimeSlotStopMinute=59; Search_DynamicField_XTimeSlotStopSecond=59;\' és vagy \'Search_DynamicField_XTimePointFormat=week; Search_DynamicField_XTimePointStart=Before; Search_DynamicField_XTimePointValue=7\';.';
    $Self->{Translation}->{'Defines the default subobject of the class \'ITSMConfigItem\'.'} =
        'Meghatározza az „ITSMConfigItem” osztály alapértelmezett alobjektumát.';
    $Self->{Translation}->{'Defines the number of rows for the CI definition editor in the admin interface.'} =
        'Meghatározza a CI meghatározás-szerkesztő sorainak számát az adminisztrációs felületen.';
    $Self->{Translation}->{'Defines the order of incident states from high (e.g. cricital) to low (e.g. functional).'} =
        'Meghatározza az incidensállapotok sorrendjét a legmagasabbtól (például kritikus) a legalacsonyabbig (például funkcionális).';
    $Self->{Translation}->{'Defines the relevant deployment states where linked tickets can affect the status of a CI.'} =
        'Meghatározza a kapcsolódó üzembe állítási állapotokat, ahol a kapcsolt jegyek befolyásolhatják egy konfigurációelem állapotát.';
    $Self->{Translation}->{'Defines the search limit for the AgentITSMConfigItem screen.'} =
        'Meghatározza a keresési korlátot az AgentITSMConfigItem képernyőn.';
    $Self->{Translation}->{'Defines the search limit for the AgentITSMConfigItemSearch screen.'} =
        'Meghatározza a keresési korlátot az AgentITSMConfigItemSearch képernyőn.';
    $Self->{Translation}->{'Defines the search limit for the CustomerITSMConfigItem screen.'} =
        'Meghatározza a CustomerITSMConfigItem képernyő keresési határát.';
    $Self->{Translation}->{'Defines the search limit for the CustomerITSMConfigItemSearch screen.'} =
        'Meghatározza a CustomerITSMConfigItemSearch képernyő keresési korlátját.';
    $Self->{Translation}->{'Defines the shown columns of CIs in the link table complex view for all CI classes. If there is no entry, then the default columns are shown.'} =
        'Meghatározza a konfigurációelemek megjelenített oszlopait a kapcsolati tábla komplex nézetében az összes konfigurációelem-osztálynál. Ha nincs bejegyzés, akkor az alapértelmezett oszlopok lesznek megjelenítve.';
    $Self->{Translation}->{'Defines the shown columns of CIs in the link table complex view, depending on the CI class. Each entry must be prefixed with the class name and double colons (i.e. Computer::). There are a few CI-Attributes that common to all CIs (example for the class Computer: Computer::Name, Computer::CurDeplState, Computer::CreateTime). To show individual CI-Attributes as defined in the CI-Definition, the following scheme must be used (example for the class Computer): Computer::HardDisk::1, Computer::HardDisk::1::Capacity::1, Computer::HardDisk::2, Computer::HardDisk::2::Capacity::1. If there is no entry for a CI class, then the default columns are shown.'} =
        'Meghatározza a CI-k megjelenített oszlopait a kapcsolati tábla komplex nézetében a CI osztálytól függően. Minden bejegyzést az oszlop neve és dupla kettőspont előtaggal kell ellátni (azaz Computer::). Van néhány olyan CI-attribútum, amely közös minden CI-vel (például a Computer osztálynál: Computer::Name, Computer::CurDeplState, Computer::CreateTime). Az egyéni CI-attribútumok megjelenítéséhez, ahogy azok a CI-meghatározásban meg vannak adva, a következő sémát kell használni (például a Computer osztálynál): Computer::HardDisk::1, Computer::HardDisk::1::Capacity::1, Computer::HardDisk::2, Computer::HardDisk::2::Capacity::1. Ha egy CI osztályhoz nincs bejegyzés, akkor az alapértelmezett oszlopok lesznek megjelenítve.';
    $Self->{Translation}->{'Defines which items are available for \'Action\' in third level of the ITSM Config Item ACL structure.'} =
        'Meghatározza, hogy az ITSM Config Item ACL struktúra harmadik szintjén mely elemek állnak rendelkezésre az "Action" (Művelet) számára.';
    $Self->{Translation}->{'Defines which items are available in first level of the ITSM Config Item ACL structure.'} =
        'Meghatározza, hogy mely elemek állnak rendelkezésre az ITSM Config Item ACL struktúra első szintjén.';
    $Self->{Translation}->{'Defines which items are available in second level of the ITSM Config Item ACL structure.'} =
        'Meghatározza, hogy mely elemek állnak rendelkezésre az ITSM Config Item ACL struktúra második szintjén.';
    $Self->{Translation}->{'Defines which type of link (named from the ticket perspective) can affect the status of a linked CI.'} =
        'Meghatározza, hogy mely kapcsolattípusok (a jegy nézőpontjából elnevezve) befolyásolhatják egy kapcsolt konfigurációelem állapotát.';
    $Self->{Translation}->{'Defines which type of ticket can affect the status of a linked CI.'} =
        'Meghatározza, hogy mely jegytípus befolyásolhatja egy kapcsolt konfigurációelem állapotát.';
    $Self->{Translation}->{'Definition Update'} = 'Meghatározás frissítése';
    $Self->{Translation}->{'Delete Configuration Item'} = 'Konfigurációelem törlése';
    $Self->{Translation}->{'DeplState'} = 'DeplState';
    $Self->{Translation}->{'Deployment State Color'} = 'Üzembe állítási állapot színe';
    $Self->{Translation}->{'DeploymentState'} = 'DeploymentState';
    $Self->{Translation}->{'Duplicate'} = 'Kettőzés';
    $Self->{Translation}->{'Dynamic field event module that marks config item definitions as out of sync, if containing dynamic fields change.'} =
        'Dinamikus mező eseménymodul, amely a konfigurációs elem definícióit szinkronizálatlannak jelöli, ha a dinamikus mezők megváltoznak.';
    $Self->{Translation}->{'Dynamic fields shown in the additional ITSM field screen of the agent interface.'} =
        'Az ügyintézői felület további ITSM mező képernyőjén megjelenített dinamikus mezők.';
    $Self->{Translation}->{'Dynamic fields shown in the config item overview screen of the customer interface.'} =
        'Az ügyfélfelület konfigurációs elem áttekintő képernyőjén megjelenő dinamikus mezők.';
    $Self->{Translation}->{'Dynamic fields shown in the config item search screen of the agent interface.'} =
        'Az ügynöki felület konfigurációs elemkereső képernyőjén megjelenő dinamikus mezők.';
    $Self->{Translation}->{'Enables configuration item bulk action feature for the agent frontend to work on more than one configuration item at a time.'} =
        'Engedélyezi a konfigurációelem tömeges művelet funkciót az ügyintézői előtétprogramnál, hogy egyszerre egynél több konfigurációelemmel dolgozhasson.';
    $Self->{Translation}->{'Enables configuration item bulk action feature only for the listed groups.'} =
        'Csak a felsorolt csoportoknak engedélyezi a konfigurációelem tömeges művelet funkciót.';
    $Self->{Translation}->{'Enables/disables the functionality to check ITSM onfiguration items for unique names. Before enabling this option you should check your system for already existing config items with duplicate names. You can do this with the console command Admin::ITSM::Configitem::ListDuplicates.'} =
        'Az ITSM onfiguration elemek egyedi nevének ellenőrzésére szolgáló funkció engedélyezése/letiltása. Mielőtt engedélyezné ezt a beállítást, ellenőrizze a rendszerét a már meglévő, duplikált nevű konfigurációs elemek tekintetében. Ezt az Admin::ITSM::Configitem::ListDuplicates konzolparanccsal teheti meg.';
    $Self->{Translation}->{'Event module to set configitem-status on ticket-configitem-link.'} =
        'Eseménymodul a konfigurációelem állapotának beállításához egy jegy konfigurációelem hivatkozásán.';
    $Self->{Translation}->{'Fields of the configuration item index, used for the fulltext search. Fields are also stored, but are not mandatory for the overall functionality. Inclusion of attachments can be disabled by setting the entry to 0 or deleting it.'} =
        'A konfigurációs elemindex mezői, amelyeket a teljes szöveges kereséshez használnak. A mezők szintén tárolásra kerülnek, de az általános funkcionalitás szempontjából nem kötelezőek. A mellékletek bevonása letiltható a bejegyzés 0-ra állításával vagy törlésével.';
    $Self->{Translation}->{'Fields stored in the configuration item index which are used for other things besides fulltext searches. For the complete functionality all fields are mandatory.'} =
        'A konfigurációs elemindexben tárolt mezők, amelyeket a teljes szöveges keresésen kívül másra is használnak. A teljes funkcionalitás érdekében minden mező kötelező.';
    $Self->{Translation}->{'For every webservice (key) an array of classes (value) can be defined on which the import is restricted. For all chosen classes, or all existing classes the identifying attributes will have to be chosen in the invoker config.'} =
        'Minden egyes webszolgáltatáshoz (kulcs) megadható egy sor osztály (érték), amelyekre az importálás korlátozva van. Az összes kiválasztott osztályhoz vagy az összes létező osztályhoz az azonosító attribútumokat kell kiválasztani az invoker konfigurációban.';
    $Self->{Translation}->{'GenericInterface module registration for the ConfigItemFetch invoker layer.'} =
        'GenericInterface modul regisztráció a ConfigItemFetch invoker réteghez.';
    $Self->{Translation}->{'ITSM ConfigItem'} = 'ITSM ConfigItem';
    $Self->{Translation}->{'ITSM config item overview.'} = 'ITSM konfigurációelem áttekintés.';
    $Self->{Translation}->{'InciState'} = 'InciState';
    $Self->{Translation}->{'IncidentState'} = 'IncidentState';
    $Self->{Translation}->{'Includes deployment states in the config item search of the customer interface.'} =
        'A telepítési állapotokat tartalmazza az ügyfélfelület konfigurációs elemkeresőjében.';
    $Self->{Translation}->{'Includes incident states in the config item search of the customer interface.'} =
        'Beleértve az incidensállapotokat az ügyfélfelület konfigurációs elemkeresőjében.';
    $Self->{Translation}->{'Maximum number of config items to be displayed in the result of this operation.'} =
        'A művelet eredményében megjelenítendő konfigurációs elemek maximális száma.';
    $Self->{Translation}->{'Module to check the group responsible for a class.'} = 'Egy modul egy osztályért felelős csoport ellenőrzéséhez.';
    $Self->{Translation}->{'Module to check the group responsible for a configuration item.'} =
        'Egy modul egy konfigurációelemért felelős csoport ellenőrzéséhez.';
    $Self->{Translation}->{'Module to generate ITSM config item statistics.'} = 'Egy modul ITSM konfigurációelem statisztikák előállításához.';
    $Self->{Translation}->{'Name Module'} = 'Név modul';
    $Self->{Translation}->{'Number Module'} = 'Szám modul';
    $Self->{Translation}->{'Number of config items to be displayed in each page of a search result in the agent interface.'} =
        'Az ügynöki felületen a keresési eredmények egyes oldalain megjelenítendő konfigurációs elemek száma.';
    $Self->{Translation}->{'Number of config items to be displayed in each page of a search result in the customer interface.'} =
        'Az ügyfélfelületen a keresési eredmények minden egyes oldalán megjelenítendő konfigurációs elemek száma.';
    $Self->{Translation}->{'Objects to search for, how many entries and which attributs to show. ConfigItem attributes have to explicitly be stored via Elasticsearch.'} =
        'A keresendő objektumok, hány bejegyzés és milyen attribútumok jelenjenek meg. A ConfigItem attribútumokat kifejezetten az Elasticsearch segítségével kell tárolni.';
    $Self->{Translation}->{'Overview.'} = 'Áttekintés.';
    $Self->{Translation}->{'Parameters for the categories for config item classes in the preferences view of the agent interface.'} =
        'A konfigurációs elemosztályok kategóriáinak paraméterei az ügynöki felület beállítások nézetében.';
    $Self->{Translation}->{'Parameters for the column filters of the small config item overview. Please note: setting \'Active\' to 0 will only prevent agents from editing settings of this group in their personal preferences, but will still allow administrators to edit the settings of another user\'s behalf. Use \'PreferenceGroup\' to control in which area these settings should be shown in the user interface.'} =
        'A kis konfigurációs elemek áttekintésének oszlopszűrőinek paraméterei. Megjegyzés: az "Aktív" 0-ra állítása csak azt akadályozza meg, hogy az ügynökök szerkesszék a csoport beállításait a személyes beállításaikban, de a rendszergazdáknak továbbra is lehetővé teszi, hogy egy másik felhasználó nevében szerkesszék a beállításokat. A \'PreferenceGroup\' segítségével szabályozhatja, hogy ezek a beállítások melyik területen jelenjenek meg a felhasználói felületen.';
    $Self->{Translation}->{'Parameters for the dashboard backend of the customer company config item overview of the agent interface . "Limit" is the number of entries shown by default. "Group" is used to restrict the access to the plugin (e. g. Group: admin;group1;group2;). "Default" determines if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" is the cache time in minutes for the plugin.'} =
        'Paraméterek az ügyintézői felület ügyfél-vállalat konfigurációelem áttekintőjének vezérlőpult háttérprogramjához. A „Limit” az alapértelmezetten megjelenített bejegyzések száma. A „Group” használható a hozzáférés korlátozásához a bővítményre (például Group: admin;csoport1;csoport2;). A „Default” azt határozza meg, hogy a bővítmény alapértelmezetten engedélyezve van, vagy hogy a felhasználónak kézzel kell engedélyeznie azt. A „CacheTTLLocal” a bővítmény gyorsítótár ideje percben.';
    $Self->{Translation}->{'Parameters for the deployment states color in the preferences view of the agent interface.'} =
        'Paraméterek az üzembe állítási állapotok színeihez az ügyintézői felület beállítások nézetében.';
    $Self->{Translation}->{'Parameters for the deployment states in the preferences view of the agent interface.'} =
        'Paraméterek az üzembe állítási állapotokhoz az ügyintézői felület beállítások nézetében.';
    $Self->{Translation}->{'Parameters for the example permission groups of the general catalog attributes.'} =
        'Paraméterek az általános katalógus attribútumainak példa jogosultság csoportjaihoz.';
    $Self->{Translation}->{'Parameters for the name module for config item classes in the preferences view of the agent interface.'} =
        'A konfigurációs elemosztályok névmoduljának paraméterei az ügynökfelület beállítások nézetében.';
    $Self->{Translation}->{'Parameters for the number module for config item classes in the preferences view of the agent interface.'} =
        'A konfigurációs elemosztályok számmoduljának paraméterei az ügynökfelület beállítások nézetében.';
    $Self->{Translation}->{'Parameters for the pages (in which the configuration items are shown).'} =
        'Paraméterek az oldalakhoz (amelyeken a konfigurációelemek megjelennek).';
    $Self->{Translation}->{'Parameters for the version string module for config item classes in the preferences view of the agent interface.'} =
        'A konfigurációs elemosztályok verziósztring moduljának paraméterei az ügynöki felület beállítások nézetében.';
    $Self->{Translation}->{'Parameters for the version string template toolkit module for config item classes in the preferences view of the agent interface.'} =
        'Az ügynöki felület beállítások nézetében a konfigurációs elemosztályok konfigurációs elemosztályaihoz tartozó verziósztring sablon eszközkészlet moduljának paraméterei.';
    $Self->{Translation}->{'Parameters for the version trigger for config item classes in the preferences view of the agent interface.'} =
        'A konfigurációs elemosztályok verzióindítójának paraméterei az ügynöki felület beállítások nézetében.';
    $Self->{Translation}->{'Performs the configured action for each event (as an Invoker) for each configured Webservice.'} =
        'Végrehajtja a beállított műveletet minden eseménynél (mint egy meghívó) minden egyes beállított webszolgáltatáshoz.';
    $Self->{Translation}->{'Permission Group'} = 'Jogosultsági csoport';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item attachment action in the agent interface.'} =
        'Az ITSM konfigurációs elem csatolási művelet használatához szükséges engedélyek az ügynöki felületen.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item screen in the agent interface.'} =
        'A szükséges jogosultságok az ITSM konfigurációelem képernyőjének használatához az ügyintézői felületen.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item search screen in the agent interface.'} =
        'A szükséges jogosultságok az ITSM konfigurációelem keresési képernyőjének használatához az ügyintézői felületen.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item search screen in the customer interface.'} =
        'Az ITSM konfigurációs elemek keresési képernyőjének használatához szükséges jogosultságok az ügyfélfelületen.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item tree view screen in the agent interface.'} =
        'Az ITSM konfigurációs elemfát megjelenítő képernyő használatához szükséges jogosultságok az ügynöki felületen.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item zoom screen in the agent interface.'} =
        'A szükséges jogosultságok az ITSM konfigurációelem nagyítási képernyőjének használatához az ügyintézői felületen.';
    $Self->{Translation}->{'Required permissions to use the add ITSM configuration item screen in the agent interface.'} =
        'A szükséges jogosultságok az ITSM konfigurációelem hozzáadása képernyőjének használatához az ügyintézői felületen.';
    $Self->{Translation}->{'Required permissions to use the bulk ITSM configuration item screen in the agent interface.'} =
        'Az ITSM konfigurációs elemek ömlesztett képernyőjének használatához szükséges jogosultságok az ügynöki felületen.';
    $Self->{Translation}->{'Required permissions to use the edit ITSM configuration item screen in the agent interface.'} =
        'A szükséges jogosultságok az ITSM konfigurációelem szerkesztése képernyőjének használatához az ügyintézői felületen.';
    $Self->{Translation}->{'Required permissions to use the history ITSM configuration item screen in the agent interface.'} =
        'A szükséges jogosultságok az ITSM konfigurációelem előzmények képernyőjének használatához az ügyintézői felületen.';
    $Self->{Translation}->{'Required permissions to use the print ITSM configuration item screen in the agent interface.'} =
        'A szükséges jogosultságok az ITSM konfigurációelem nyomtatása képernyőjének használatához az ügyintézői felületen.';
    $Self->{Translation}->{'Required privileges to delete config items.'} = 'A szükséges jogosultságok a konfigurációelemek törléséhez.';
    $Self->{Translation}->{'Search config items.'} = 'Konfigurációelemek keresése.';
    $Self->{Translation}->{'Set the incident state of a CI automatically when a Ticket is Linked to a CI.'} =
        'Egy konfigurációelem incidensállapotának automatikus beállítása, amikor egy jegyet kapcsolnak egy konfigurációelemhez.';
    $Self->{Translation}->{'Sets the deployment state in the configuration item bulk screen of the agent interface.'} =
        'Beállítja az üzembe állítási állapotot az ügyintézői felület konfigurációelem tömeges művelet képernyőjén.';
    $Self->{Translation}->{'Sets the incident state in the configuration item bulk screen of the agent interface.'} =
        'Beállítja az incidensállapotot az ügyintézői felület konfigurációelem tömeges művelet képernyőjén.';
    $Self->{Translation}->{'Shows a link in the menu that allows linking a configuration item with another object in the config item zoom view of the agent interface.'} =
        'Egy hivatkozást jelenít meg a menüben, amely lehetővé teszi egy konfigurációelem összekapcsolását egy másik objektummal az ügyintézői felület konfigurációelem nagyítási nézetén.';
    $Self->{Translation}->{'Shows a link in the menu to access the history of a configuration item in the configuration item overview of the agent interface.'} =
        'Egy hivatkozást jelenít meg a menüben egy konfigurációelem előzményeinek eléréséhez az ügyintézői felület konfigurációelem áttekintőjében.';
    $Self->{Translation}->{'Shows a link in the menu to access the history of a configuration item in the its zoom view of the agent interface.'} =
        'Egy hivatkozást jelenít meg a menüben egy konfigurációelem előzményeinek eléréséhez az ügyintézői felületen az elem nagyítási nézetében.';
    $Self->{Translation}->{'Shows a link in the menu to delete a configuration item in its zoom view of the agent interface.'} =
        'Egy hivatkozást jelenít meg a menüben egy konfigurációelem törléséhez az ügyintézői felületen az elem nagyítási nézetében.';
    $Self->{Translation}->{'Shows a link in the menu to display the configuration item links as a Tree View.'} =
        'Megjelenít egy linket a menüben a konfigurációs elemek hivatkozásainak fa nézetben történő megjelenítéséhez.';
    $Self->{Translation}->{'Shows a link in the menu to duplicate a configuration item in the configuration item overview of the agent interface.'} =
        'Egy hivatkozást jelenít meg a menüben egy konfigurációelem kettőzéséhez az ügyintézői felület konfigurációelem áttekintőjében.';
    $Self->{Translation}->{'Shows a link in the menu to duplicate a configuration item in the its zoom view of the agent interface.'} =
        'Egy hivatkozást jelenít meg a menüben egy konfigurációelem kettőzéséhez az ügyintézői felületen az elem nagyítási nézetében.';
    $Self->{Translation}->{'Shows a link in the menu to edit a configuration item in the its zoom view of the agent interface.'} =
        'Egy hivatkozást jelenít meg a menüben egy konfigurációelem szerkesztéséhez az ügyintézői felületen az elem nagyítási nézetében.';
    $Self->{Translation}->{'Shows a link in the menu to go back in the configuration item zoom view of the agent interface.'} =
        'Egy hivatkozást jelenít meg a menüben az ügyintézői felület konfigurációelem nagyítási nézethez való visszatéréshez.';
    $Self->{Translation}->{'Shows a link in the menu to print a configuration item in the its zoom view of the agent interface.'} =
        'Egy hivatkozást jelenít meg a menüben egy konfigurációelem nyomtatásához az ügyintézői felületen az elem nagyítási nézetében.';
    $Self->{Translation}->{'Shows a link in the menu to zoom into a configuration item in the configuration item overview of the agent interface.'} =
        'Egy hivatkozást jelenít meg a menüben egy konfigurációelembe történő nagyításhoz az ügyintézői felület konfigurációelem áttekintőjében.';
    $Self->{Translation}->{'Shows the config item history (reverse ordered) in the agent interface.'} =
        'Megjeleníti a konfigurációelem előzményeit (fordított sorrendben) az ügyintézői felületen.';
    $Self->{Translation}->{'The default category which is shown, if none is selected.'} = 'Az alapértelmezett kategória, amely megjelenik, ha nincs kiválasztva.';
    $Self->{Translation}->{'The identifier for a configuration item, e.g. ConfigItem#, MyConfigItem#. The default is ConfigItem#.'} =
        'Egy konfigurációelem azonosítója, például: ConfigItem#, MyConfigItem#. Az alapértelmezett: ConfigItem#.';
    $Self->{Translation}->{'Triggers ConfigItemFetch invoker automatically.'} = 'Automatikusan kiváltja a ConfigItemFetch hívót.';
    $Self->{Translation}->{'Version String Expression'} = 'Verzió karakterlánc kifejezés';
    $Self->{Translation}->{'Version String Module'} = 'Version String modul';
    $Self->{Translation}->{'Version Trigger'} = 'Verzió kiváltó';
    $Self->{Translation}->{'Whether the execution of ConfigItemACL can be avoided by checking cached field dependencies. This can improve loading times of formulars, but has to be disabled, if ACLModules are to be used for ITSMConfigItem- and Form-ReturnTypes.'} =
        'Elkerülhető-e a ConfigItemACL végrehajtása a gyorsítótárban tárolt mezőfüggőségek ellenőrzésével. Ez javíthatja az űrlapok betöltési idejét, de ki kell kapcsolni, ha az ACLModulokat az ITSMConfigItem- és Form-ReturnType típusok esetében kell használni.';
    $Self->{Translation}->{'Which general information is shown in the header.'} = 'Milyen általános információk jelennek meg a fejlécben.';
    $Self->{Translation}->{'class'} = 'osztály';
    $Self->{Translation}->{'global'} = 'globális';
    $Self->{Translation}->{'postproductive'} = 'beüzemelés után';
    $Self->{Translation}->{'preproductive'} = 'beüzemelés előtt';
    $Self->{Translation}->{'productive'} = 'beüzemelve';


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

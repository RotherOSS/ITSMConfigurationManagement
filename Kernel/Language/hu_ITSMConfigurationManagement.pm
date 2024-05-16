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

package Kernel::Language::hu_ITSMConfigurationManagement;

use strict;
use warnings;
use utf8;

sub Data {
    my $Self = shift;

    # Template: AdminITSMConfigItem
    $Self->{Translation}->{'Config Item Management'} = 'Konfigurációelem-menedzsment';
    $Self->{Translation}->{'Change class definition'} = 'Osztály-meghatározás módosítása';
    $Self->{Translation}->{'Config Item Class'} = 'Konfigurációelem-osztály';
    $Self->{Translation}->{'Definition'} = 'Meghatározás';
    $Self->{Translation}->{'Change'} = 'Változás';

    # Template: AgentDashboardITSMConfigItemGeneric
    $Self->{Translation}->{'Incident State'} = 'Incidensállapot';
    $Self->{Translation}->{'Deployment State'} = 'Üzembe állítási állapot';
    $Self->{Translation}->{'Class'} = 'Osztály';
    $Self->{Translation}->{'Deployment State Type'} = 'Üzembe állítási állapottípus';
    $Self->{Translation}->{'Current Incident State'} = 'Jelenlegi incidensállapot';
    $Self->{Translation}->{'Current Incident State Type'} = 'Jelenlegi incidensállapot típus';
    $Self->{Translation}->{'Last changed'} = 'Utolsó módosítás';

    # Template: AgentITSMConfigItemAdd
    $Self->{Translation}->{'Config Item'} = 'Konfigurációelem';
    $Self->{Translation}->{'Filter for Classes'} = 'Szűrő az osztályokhoz';
    $Self->{Translation}->{'Select a Class from the list to create a new Config Item.'} = 'Válasszon egy osztályt a listából egy új konfigurációelem létrehozásához.';

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

    # Template: AgentITSMConfigItemHistory
    $Self->{Translation}->{'History of Config Item: %s'} = 'Konfigurációelem előzményei: %s';
    $Self->{Translation}->{'History Content'} = 'Előzménytartalom';
    $Self->{Translation}->{'Createtime'} = 'Létrehozás ideje';
    $Self->{Translation}->{'Zoom view'} = 'Nagyítási nézet';

    # Template: AgentITSMConfigItemOverviewNavBar
    $Self->{Translation}->{'Context Settings'} = 'Környezet beállítások';
    $Self->{Translation}->{'Config Items per page'} = 'Konfigurációelemek oldalanként';

    # Template: AgentITSMConfigItemOverviewSmall
    $Self->{Translation}->{'A generic ITSM Configuration Item table'} = 'Egy általános ITSM konfigurációelem táblázat';

    # Template: AgentITSMConfigItemSearch
    $Self->{Translation}->{'Run Search'} = 'Keresés futtatása';
    $Self->{Translation}->{'Also search in previous versions?'} = 'Keressen az előző verziókban is?';

    # Template: AgentITSMConfigItemZoom
    $Self->{Translation}->{'Configuration Item'} = 'Konfigurációelem';
    $Self->{Translation}->{'Configuration Item Information'} = 'Konfigurációelem-információk';
    $Self->{Translation}->{'Current Deployment State'} = 'Jelenlegi üzembe állítási állapot';
    $Self->{Translation}->{'Last changed by'} = 'Utoljára módosította';
    $Self->{Translation}->{'Show one version'} = 'Egy verzió megjelenítése';
    $Self->{Translation}->{'Show all versions'} = 'Összes verzió megjelenítése';
    $Self->{Translation}->{'Version Incident State'} = 'Verzió incidensállapot';
    $Self->{Translation}->{'Version Deployment State'} = 'Verzió üzembe állítási állapot';
    $Self->{Translation}->{'Version Number'} = 'Verziószám';
    $Self->{Translation}->{'Configuration Item Version Details'} = 'Konfigurációelem-verzió részletek';
    $Self->{Translation}->{'Property'} = 'Tulajdonság';

    # Perl Module: Kernel/Modules/AgentITSMConfigItem.pm
    $Self->{Translation}->{'No access to Class is given!'} = 'Nincs hozzáférés megadva az osztályhoz!';
    $Self->{Translation}->{'Overview: ITSM ConfigItem'} = 'Áttekintés: ITSM konfigurációelem';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemBulk.pm
    $Self->{Translation}->{'No ConfigItemID is given!'} = 'Nincs konfigurációelem-azonosító megadva!';
    $Self->{Translation}->{'You need at least one selected Configuration Item!'} = 'Szüksége van legalább egy kiválasztott konfigurációelemre!';
    $Self->{Translation}->{'You don\'t have write access to this configuration item: %s.'} =
        'Nincs írási hozzáférése ehhez a konfigurációelemhez: %s.';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemDelete.pm
    $Self->{Translation}->{'Config item "%s" not found in database!'} = 'A(z) „%s” konfigurációelem nem található az adatbázisban!';
    $Self->{Translation}->{'Was not able to delete the configitem ID %s!'} = 'Nem volt lehetséges a(z) %s konfigurációelem-azonosító törlése!';
    $Self->{Translation}->{'No version found for ConfigItemID %s!'} = 'Nem található verzió a(z) %s konfigurációelem-azonosítónál!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemEdit.pm
    $Self->{Translation}->{'No ConfigItemID, DuplicateID or ClassID is given!'} = 'Nincs konfigurációelem-azonosító, kettőzésazonosító vagy osztályazonosító megadva!';
    $Self->{Translation}->{'No access is given!'} = 'Nincs hozzáférés megadva!';
    $Self->{Translation}->{'No definition was defined for class %s!'} = 'Nincs meghatározás meghatározva a(z) %s osztályhoz!';

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
    $Self->{Translation}->{'VersionID %s not found in database!'} = 'A(z) %s verzióazonosító nem található az adatbázisban!';
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
    $Self->{Translation}->{'operational'} = 'üzemképes';
    $Self->{Translation}->{'warning'} = 'figyelmeztetés';
    $Self->{Translation}->{'incident'} = 'incidens';
    $Self->{Translation}->{'The deployment state of this config item'} = 'A konfigurációelem üzembe állítási állapota';
    $Self->{Translation}->{'The incident state of this config item'} = 'A konfigurációelem incidensállapota';

    # Perl Module: Kernel/Output/HTML/Dashboard/ITSMConfigItemGeneric.pm
    $Self->{Translation}->{'Shown config items'} = 'Megjelenített konfigurációelemek';

    # Perl Module: Kernel/Output/HTML/ITSMConfigItem/LayoutDate.pm
    $Self->{Translation}->{'Between'} = 'Között';

    # Perl Module: Kernel/System/ImportExport/ObjectBackend/ITSMConfigItem.pm
    $Self->{Translation}->{'Maximum number of one element'} = 'Egy elem legnagyobb száma';
    $Self->{Translation}->{'Empty fields indicate that the current values are kept'} = 'Az üres mezők azt jelzik, hogy az aktuális mezők megtartásra kerülnek';
    $Self->{Translation}->{'Skipped'} = 'Kihagyva';

    # Perl Module: var/packagesetup/ITSMConfigurationManagement.pm
    $Self->{Translation}->{'Model'} = 'Modell';
    $Self->{Translation}->{'Customer Company'} = 'Ügyfél-vállalat';
    $Self->{Translation}->{'Serial Number'} = 'Sorozatszám';
    $Self->{Translation}->{'CPU'} = 'CPU';
    $Self->{Translation}->{'Ram'} = 'Ram';
    $Self->{Translation}->{'Hard Disk'} = 'Merevlemez';
    $Self->{Translation}->{'Capacity'} = 'Kapacitás';
    $Self->{Translation}->{'Network Adapter'} = 'Hálózati csatoló';
    $Self->{Translation}->{'IP over DHCP'} = 'IP a DHCP fölött';
    $Self->{Translation}->{'IP Address'} = 'IP-cím';
    $Self->{Translation}->{'Graphic Adapter'} = 'Grafikus csatoló';
    $Self->{Translation}->{'Other Equipment'} = 'Egyéb berendezés';
    $Self->{Translation}->{'Warranty Expiration Date'} = 'Garancia lejárati idő';
    $Self->{Translation}->{'Install Date'} = 'Telepítés dátuma';
    $Self->{Translation}->{'Phone 1'} = '1. telefon';
    $Self->{Translation}->{'Phone 2'} = '2. telefon';
    $Self->{Translation}->{'E-Mail'} = 'E-mail';
    $Self->{Translation}->{'Network Address'} = 'Hálózati cím';
    $Self->{Translation}->{'Subnet Mask'} = 'Alhálózati maszk';
    $Self->{Translation}->{'Gateway'} = 'Átjáró';
    $Self->{Translation}->{'Licence Type'} = 'Licenctípus';
    $Self->{Translation}->{'Licence Key'} = 'Licenc kulcs';
    $Self->{Translation}->{'Quantity'} = 'Mennyiség';
    $Self->{Translation}->{'Expiration Date'} = 'Lejárati idő';
    $Self->{Translation}->{'Media'} = 'Adathordozó';

    # Database XML Definition: ITSMConfigurationManagement.sopm
    $Self->{Translation}->{'Computer'} = 'Számítógép';
    $Self->{Translation}->{'Hardware'} = 'Hardver';
    $Self->{Translation}->{'Network'} = 'Hálózat';
    $Self->{Translation}->{'Software'} = 'Szoftver';
    $Self->{Translation}->{'Expired'} = 'Lejárt';
    $Self->{Translation}->{'Maintenance'} = 'Karbantartás';
    $Self->{Translation}->{'Pilot'} = 'Próbaüzem';
    $Self->{Translation}->{'Planned'} = 'Tervezett';
    $Self->{Translation}->{'Repair'} = 'Javítás';
    $Self->{Translation}->{'Retired'} = 'Visszavont';
    $Self->{Translation}->{'Review'} = 'Vizsgálat';
    $Self->{Translation}->{'Test/QA'} = 'Tesztelés/QA';
    $Self->{Translation}->{'Laptop'} = 'Laptop';
    $Self->{Translation}->{'Desktop'} = 'Asztali';
    $Self->{Translation}->{'PDA'} = 'PDA';
    $Self->{Translation}->{'Server'} = 'Kiszolgáló';
    $Self->{Translation}->{'Other'} = 'Egyéb';
    $Self->{Translation}->{'Monitor'} = 'Monitor';
    $Self->{Translation}->{'Printer'} = 'Nyomtató';
    $Self->{Translation}->{'Switch'} = 'Kapcsoló';
    $Self->{Translation}->{'Router'} = 'Útválasztó';
    $Self->{Translation}->{'WLAN Access Point'} = 'WLAN hozzáférési pont';
    $Self->{Translation}->{'Security Device'} = 'Biztonsági eszköz';
    $Self->{Translation}->{'Backup Device'} = 'Biztonsági mentés eszköz';
    $Self->{Translation}->{'Mouse'} = 'Egér';
    $Self->{Translation}->{'Keyboard'} = 'Billentyűzet';
    $Self->{Translation}->{'Camera'} = 'Kamera';
    $Self->{Translation}->{'Beamer'} = 'Beamer';
    $Self->{Translation}->{'Modem'} = 'Modem';
    $Self->{Translation}->{'PCMCIA Card'} = 'PCMCIA kártya';
    $Self->{Translation}->{'USB Device'} = 'USB eszköz';
    $Self->{Translation}->{'Docking Station'} = 'Dokkoló állomás';
    $Self->{Translation}->{'Scanner'} = 'Lapolvasó';
    $Self->{Translation}->{'Building'} = 'Épület';
    $Self->{Translation}->{'Office'} = 'Iroda';
    $Self->{Translation}->{'Floor'} = 'Emelet';
    $Self->{Translation}->{'Room'} = 'Szoba';
    $Self->{Translation}->{'Rack'} = 'Rack';
    $Self->{Translation}->{'Workplace'} = 'Munkahely';
    $Self->{Translation}->{'Outlet'} = 'Elosztó doboz';
    $Self->{Translation}->{'IT Facility'} = 'IT-létesítmény';
    $Self->{Translation}->{'LAN'} = 'LAN';
    $Self->{Translation}->{'WLAN'} = 'WLAN';
    $Self->{Translation}->{'Telco'} = 'Telco';
    $Self->{Translation}->{'GSM'} = 'GSM';
    $Self->{Translation}->{'Client Application'} = 'Kliens alkalmazás';
    $Self->{Translation}->{'Middleware'} = 'Köztes réteg';
    $Self->{Translation}->{'Server Application'} = 'Kiszolgáló alkalmazás';
    $Self->{Translation}->{'Client OS'} = 'Kliens operációs rendszer';
    $Self->{Translation}->{'Server OS'} = 'Kiszolgáló operációs rendszer';
    $Self->{Translation}->{'Admin Tool'} = 'Adminisztrációs eszköz';
    $Self->{Translation}->{'User Tool'} = 'Felhasználói eszköz';
    $Self->{Translation}->{'Embedded'} = 'Beágyazott';
    $Self->{Translation}->{'Single Licence'} = 'Egyedüli licenc';
    $Self->{Translation}->{'Per User'} = 'Felhasználónként';
    $Self->{Translation}->{'Per Processor'} = 'Processzoronként';
    $Self->{Translation}->{'Per Server'} = 'Kiszolgálónként';
    $Self->{Translation}->{'Per Node'} = 'Csomópontonként';
    $Self->{Translation}->{'Volume Licence'} = 'Mennyiségi licenc';
    $Self->{Translation}->{'Enterprise Licence'} = 'Vállalati licenc';
    $Self->{Translation}->{'Developer Licence'} = 'Fejlesztői licenc';
    $Self->{Translation}->{'Demo'} = 'Bemutató';
    $Self->{Translation}->{'Time Restricted'} = 'Időben korlátozott';
    $Self->{Translation}->{'Freeware'} = 'Freeware';
    $Self->{Translation}->{'Open Source'} = 'Nyílt forrású';
    $Self->{Translation}->{'Unlimited'} = 'Korlátlan';

    # JS File: ITSM.Agent.ConfigItem.Zoom
    $Self->{Translation}->{'Ok'} = 'OK';

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

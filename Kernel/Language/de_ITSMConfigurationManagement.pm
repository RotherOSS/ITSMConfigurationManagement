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

package Kernel::Language::de_ITSMConfigurationManagement;

use strict;
use warnings;
use utf8;

sub Data {
    my $Self = shift;

    # Template: AdminITSMConfigItem
    $Self->{Translation}->{'Config Item Management'} = 'ConfigItem-Verwaltung';
    $Self->{Translation}->{'Change class definition'} = 'Klassen-Definition ändern';
    $Self->{Translation}->{'Config Item Class'} = 'ConfigItem-Klasse';
    $Self->{Translation}->{'Definition'} = 'Definition';
    $Self->{Translation}->{'Change'} = 'Ändern';

    # Template: AgentDashboardITSMConfigItemGeneric
    $Self->{Translation}->{'Incident State'} = 'Vorfallstatus';
    $Self->{Translation}->{'Deployment State'} = 'Verwendungsstatus';
    $Self->{Translation}->{'Class'} = 'Klasse';
    $Self->{Translation}->{'Deployment State Type'} = 'Verwendungsstatus';
    $Self->{Translation}->{'Current Incident State'} = 'Aktueller Vorfallstatus';
    $Self->{Translation}->{'Current Incident State Type'} = 'Aktueller Vorfallsstatus-Typ';
    $Self->{Translation}->{'Last changed'} = 'Zuletzt geändert';

    # Template: AgentITSMConfigItemAdd
    $Self->{Translation}->{'Config Item'} = 'Config Item';
    $Self->{Translation}->{'Filter for Classes'} = 'Filter für Klassen';
    $Self->{Translation}->{'Select a Class from the list to create a new Config Item.'} = 'Wählen Sie eine Klasse aus der Liste aus um ein neues Config Item zu erstellen.';

    # Template: AgentITSMConfigItemBulk
    $Self->{Translation}->{'ITSM ConfigItem Bulk Action'} = 'ITSM ConfigItem Sammelaktion';
    $Self->{Translation}->{'Deployment state'} = 'Verwendungsstatus';
    $Self->{Translation}->{'Incident state'} = 'Vorfallstatus';
    $Self->{Translation}->{'Link to another'} = 'Zu einem anderen verknüpfen';
    $Self->{Translation}->{'Invalid Configuration Item number!'} = 'Ungültige Configuration Item Nummer!';
    $Self->{Translation}->{'The number of another Configuration Item to link with.'} = 'Die Nummer des zu verknüpfenden Configuration Items.';

    # Template: AgentITSMConfigItemDelete
    $Self->{Translation}->{'Do you really want to delete this config item?'} = 'Wollen Sie dieses Configuration Item wirklich löschen?';

    # Template: AgentITSMConfigItemEdit
    $Self->{Translation}->{'The name of this config item'} = 'Der Name dieses Configuration Items';
    $Self->{Translation}->{'Name is already in use by the ConfigItems with the following Number(s): %s'} =
        'Name wird bereits von den Configuration Items mit den folgenden Nummern verwendet: %s';

    # Template: AgentITSMConfigItemHistory
    $Self->{Translation}->{'History of Config Item: %s'} = 'Historie von Configuration Item: %s';
    $Self->{Translation}->{'History Content'} = 'Änderungsverlauf';
    $Self->{Translation}->{'Createtime'} = 'Erstellt am';
    $Self->{Translation}->{'Zoom view'} = 'Detailansicht';

    # Template: AgentITSMConfigItemOverviewNavBar
    $Self->{Translation}->{'Context Settings'} = 'Kontext-Einstellungen';
    $Self->{Translation}->{'Config Items per page'} = 'Configuration Items pro Seite';

    # Template: AgentITSMConfigItemOverviewSmall
    $Self->{Translation}->{'A generic ITSM Configuration Item table'} = 'Eine generische ITSM Configuration Item-Tabelle';

    # Template: AgentITSMConfigItemSearch
    $Self->{Translation}->{'Run Search'} = 'Suche ausführen';
    $Self->{Translation}->{'Also search in previous versions?'} = 'Auch in früheren Versionen suchen?';

    # Template: AgentITSMConfigItemZoom
    $Self->{Translation}->{'Configuration Item'} = 'Configuration Item';
    $Self->{Translation}->{'Configuration Item Information'} = 'Configuration Item Information';
    $Self->{Translation}->{'Current Deployment State'} = 'Aktueller Verwendungsstatus';
    $Self->{Translation}->{'Last changed by'} = 'Zuletzt geändert von';
    $Self->{Translation}->{'Show one version'} = 'Nur eine Version anzeigen';
    $Self->{Translation}->{'Show all versions'} = 'Alle Versionen anzeigen';
    $Self->{Translation}->{'Version Incident State'} = 'Vorfallstatus';
    $Self->{Translation}->{'Version Deployment State'} = 'Verwendungsstatus';
    $Self->{Translation}->{'Version Number'} = 'Versionsnummer';
    $Self->{Translation}->{'Configuration Item Version Details'} = 'Configuration Item-Versionsdetails';
    $Self->{Translation}->{'Property'} = 'Eigenschaft';

    # Perl Module: Kernel/Modules/AgentITSMConfigItem.pm
    $Self->{Translation}->{'No access to Class is given!'} = 'Es wird kein Zugriff auf die Klasse gewährt!';
    $Self->{Translation}->{'Overview: ITSM ConfigItem'} = 'Übersicht: ITSM ConfigItem';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemBulk.pm
    $Self->{Translation}->{'No ConfigItemID is given!'} = 'Keine ID für das Configuration Item angegeben!';
    $Self->{Translation}->{'You need at least one selected Configuration Item!'} = 'Sie benötigen wenigstens ein ausgewähltes Configuration Item!';
    $Self->{Translation}->{'You don\'t have write access to this configuration item: %s.'} =
        'Sie haben keine Schreib-Berechtigungen für dieses Configuration Item: %s.';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemDelete.pm
    $Self->{Translation}->{'Config item "%s" not found in database!'} = 'Configuration Item "%s" in Datenbank nicht gefunden!';
    $Self->{Translation}->{'Was not able to delete the configitem ID %s!'} = 'Es war nicht möglich, die Configuration Item-ID %s zu löschen!';
    $Self->{Translation}->{'No version found for ConfigItemID %s!'} = 'Keine Version für Configuration Item-ID %s gefunden!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemEdit.pm
    $Self->{Translation}->{'No ConfigItemID, DuplicateID or ClassID is given!'} = 'Keine Configuration Item-ID, Duplikats-ID oder Klassen-ID angegeben!';
    $Self->{Translation}->{'No access is given!'} = 'Kein Zugriff gewährt!';
    $Self->{Translation}->{'No definition was defined for class %s!'} = 'Keine Definition für Klasse %s definiert!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemHistory.pm
    $Self->{Translation}->{'Can\'t show history, no ConfigItemID is given!'} = 'Kann Historie nicht anzeigen, keine Configuration Item-ID übermittelt!';
    $Self->{Translation}->{'Can\'t show history, no access rights given!'} = 'Kann Historie nicht anzeigen, keine Configuration Item-ID übermittelt!';
    $Self->{Translation}->{'New ConfigItem (ID=%s)'} = 'Neues Configuration Item (ID=%s)';
    $Self->{Translation}->{'New version (ID=%s)'} = 'Neue Version (ID=%s)';
    $Self->{Translation}->{'Deployment state updated (new=%s, old=%s)'} = 'Verwendungsstatus aktualisiert (neu=%s, alt=%s)';
    $Self->{Translation}->{'Incident state updated (new=%s, old=%s)'} = 'Vorfallstatus aktualisiert (neu=%s, alt=%s)';
    $Self->{Translation}->{'ConfigItem (ID=%s) deleted'} = 'ConfigItem (ID=%s) gelöscht';
    $Self->{Translation}->{'Link to %s (type=%s) added'} = 'Verknüpfung zu %s (Typ=%s) hinzugefügt';
    $Self->{Translation}->{'Link to %s (type=%s) deleted'} = 'Verknüpfung zu %s (Typ=%s) gelöscht';
    $Self->{Translation}->{'ConfigItem definition updated (ID=%s)'} = 'ConfigItem-Definition aktualisiert (ID=%s)';
    $Self->{Translation}->{'Name updated (new=%s, old=%s)'} = 'Name aktualisiert (neu=%s, alt=%s)';
    $Self->{Translation}->{'Attribute %s updated from "%s" to "%s"'} = 'Attribut %s aktualisiert von "%s" nach "%s"';
    $Self->{Translation}->{'Version %s deleted'} = 'Version %s gelöscht';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemPrint.pm
    $Self->{Translation}->{'No ConfigItemID or VersionID is given!'} = 'Keine Configuration Item-ID oder Versions-ID angegeben!';
    $Self->{Translation}->{'Can\'t show config item, no access rights given!'} = 'Configuration Item kann nicht angezeigt werden, keine Zugriffsrechte vergeben!';
    $Self->{Translation}->{'ConfigItemID %s not found in database!'} = 'Configuration Item-ID %s in Datenbank nicht gefunden!';
    $Self->{Translation}->{'VersionID %s not found in database!'} = 'Versions-ID %s in Datenbank nicht gefunden!';
    $Self->{Translation}->{'ConfigItem'} = 'ConfigItem';
    $Self->{Translation}->{'printed by %s at %s'} = 'gedruckt von %s am %s';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemSearch.pm
    $Self->{Translation}->{'Invalid ClassID!'} = 'Ungültige Klassen-ID!';
    $Self->{Translation}->{'No ClassID is given!'} = 'Keine Klassen-ID übermittelt!';
    $Self->{Translation}->{'No access rights for this class given!'} = 'Keine Zugriffsrechte für diese Klasse vergeben!';
    $Self->{Translation}->{'No Result!'} = 'Kein Ergebnis!';
    $Self->{Translation}->{'Config Item Search Results'} = 'Config Item-Suchergebnisse';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemZoom.pm
    $Self->{Translation}->{'Can\'t show item, no access rights for ConfigItem are given!'} =
        'Kann das Element nicht anzeigen, keine Zugriffsrechte für das ConfigItem vergeben!';
    $Self->{Translation}->{'operational'} = 'Operativ';
    $Self->{Translation}->{'warning'} = 'Warnung';
    $Self->{Translation}->{'incident'} = 'Vorfall';
    $Self->{Translation}->{'The deployment state of this config item'} = 'Der Verwendungsstatus dieses Config Items';
    $Self->{Translation}->{'The incident state of this config item'} = 'Der Vorfallstatus dieses Config Items';

    # Perl Module: Kernel/Output/HTML/Dashboard/ITSMConfigItemGeneric.pm
    $Self->{Translation}->{'Shown config items'} = 'Angezeigte Configuration Items';

    # Perl Module: Kernel/Output/HTML/ITSMConfigItem/LayoutDate.pm
    $Self->{Translation}->{'Between'} = 'Zwischen';

    # Perl Module: Kernel/System/ImportExport/ObjectBackend/ITSMConfigItem.pm
    $Self->{Translation}->{'Maximum number of one element'} = 'Maximale Anzahl eines Elements';
    $Self->{Translation}->{'Empty fields indicate that the current values are kept'} = 'Leere Felder zeigen an, dass die aktuellen Werte beibehalten werden';
    $Self->{Translation}->{'Skipped'} = 'Übersprungen';

    # Perl Module: var/packagesetup/ITSMConfigurationManagement.pm
    $Self->{Translation}->{'Model'} = 'Modell';
    $Self->{Translation}->{'Customer Company'} = 'Kundenunternehmen';
    $Self->{Translation}->{'Serial Number'} = 'Seriennummer';
    $Self->{Translation}->{'CPU'} = 'CPU';
    $Self->{Translation}->{'Ram'} = 'RAM';
    $Self->{Translation}->{'Hard Disk'} = 'Festplatte';
    $Self->{Translation}->{'Capacity'} = 'Kapazität';
    $Self->{Translation}->{'Network Adapter'} = 'Netzwerk-Adapter';
    $Self->{Translation}->{'IP over DHCP'} = 'IP über DHCP';
    $Self->{Translation}->{'IP Address'} = 'IP-Addresse';
    $Self->{Translation}->{'Graphic Adapter'} = 'Grafik-Adapter';
    $Self->{Translation}->{'Other Equipment'} = 'Sonstige Ausstattung';
    $Self->{Translation}->{'Warranty Expiration Date'} = 'Garantie Ablaufdatum';
    $Self->{Translation}->{'Install Date'} = 'Installationsdatum';
    $Self->{Translation}->{'Phone 1'} = 'Telefon 1';
    $Self->{Translation}->{'Phone 2'} = 'Telefon 2';
    $Self->{Translation}->{'E-Mail'} = 'E-Mail';
    $Self->{Translation}->{'Network Address'} = 'Netzwerk-Adresse';
    $Self->{Translation}->{'Subnet Mask'} = 'Subnetz-Maske';
    $Self->{Translation}->{'Gateway'} = 'Gateway';
    $Self->{Translation}->{'Licence Type'} = 'Lizenztyp';
    $Self->{Translation}->{'Licence Key'} = 'Lizenzschlüssel';
    $Self->{Translation}->{'Quantity'} = 'Menge';
    $Self->{Translation}->{'Expiration Date'} = 'Ablaufdatum';
    $Self->{Translation}->{'Media'} = 'Medium';

    # Database XML Definition: ITSMConfigurationManagement.sopm
    $Self->{Translation}->{'Computer'} = 'Computer';
    $Self->{Translation}->{'Hardware'} = 'Hardware';
    $Self->{Translation}->{'Network'} = 'Netzwerk';
    $Self->{Translation}->{'Software'} = 'Software';
    $Self->{Translation}->{'Expired'} = 'Abgelaufen';
    $Self->{Translation}->{'Maintenance'} = 'In Wartung';
    $Self->{Translation}->{'Pilot'} = 'Pilotbetrieb';
    $Self->{Translation}->{'Planned'} = 'Geplant';
    $Self->{Translation}->{'Repair'} = 'In Reparatur';
    $Self->{Translation}->{'Retired'} = 'Außer Dienst';
    $Self->{Translation}->{'Review'} = 'Unter Review';
    $Self->{Translation}->{'Test/QA'} = 'Test/QS';
    $Self->{Translation}->{'Laptop'} = 'Laptop';
    $Self->{Translation}->{'Desktop'} = 'Desktop';
    $Self->{Translation}->{'PDA'} = 'PDA';
    $Self->{Translation}->{'Server'} = 'Server';
    $Self->{Translation}->{'Other'} = 'Sonstiges';
    $Self->{Translation}->{'Monitor'} = 'Monitor';
    $Self->{Translation}->{'Printer'} = 'Drucker';
    $Self->{Translation}->{'Switch'} = 'Switch';
    $Self->{Translation}->{'Router'} = 'Router';
    $Self->{Translation}->{'WLAN Access Point'} = 'WLAN-Zugangspunkt';
    $Self->{Translation}->{'Security Device'} = 'Sicherheitsgerät';
    $Self->{Translation}->{'Backup Device'} = 'Backup-Gerät';
    $Self->{Translation}->{'Mouse'} = 'Maus';
    $Self->{Translation}->{'Keyboard'} = 'Tastatur';
    $Self->{Translation}->{'Camera'} = 'Kamera';
    $Self->{Translation}->{'Beamer'} = 'Beamer';
    $Self->{Translation}->{'Modem'} = 'Modem';
    $Self->{Translation}->{'PCMCIA Card'} = 'PCMCIA-Karte';
    $Self->{Translation}->{'USB Device'} = 'USB-Gerät';
    $Self->{Translation}->{'Docking Station'} = 'Docking-Station';
    $Self->{Translation}->{'Scanner'} = 'Scanner';
    $Self->{Translation}->{'Building'} = 'Gebäude';
    $Self->{Translation}->{'Office'} = 'Büro';
    $Self->{Translation}->{'Floor'} = 'Etage';
    $Self->{Translation}->{'Room'} = 'Raum';
    $Self->{Translation}->{'Rack'} = 'Rack';
    $Self->{Translation}->{'Workplace'} = 'Arbeitsplatz';
    $Self->{Translation}->{'Outlet'} = 'Anschlussdose';
    $Self->{Translation}->{'IT Facility'} = 'IT-Einrichtung';
    $Self->{Translation}->{'LAN'} = 'LAN';
    $Self->{Translation}->{'WLAN'} = 'WLAN';
    $Self->{Translation}->{'Telco'} = 'Telko';
    $Self->{Translation}->{'GSM'} = 'GSM';
    $Self->{Translation}->{'Client Application'} = 'Client-Anwendung';
    $Self->{Translation}->{'Middleware'} = 'Middleware';
    $Self->{Translation}->{'Server Application'} = 'Server-Anwendung';
    $Self->{Translation}->{'Client OS'} = 'Client-Betriebssystem';
    $Self->{Translation}->{'Server OS'} = 'Server-Betriebssystem';
    $Self->{Translation}->{'Admin Tool'} = 'Administrator-Tool';
    $Self->{Translation}->{'User Tool'} = 'Benutzer-Tool';
    $Self->{Translation}->{'Embedded'} = 'Embedded';
    $Self->{Translation}->{'Single Licence'} = 'Einzellizenz';
    $Self->{Translation}->{'Per User'} = 'Pro Benutzer';
    $Self->{Translation}->{'Per Processor'} = 'Pro Prozessor';
    $Self->{Translation}->{'Per Server'} = 'Pro Server';
    $Self->{Translation}->{'Per Node'} = 'Pro Knoten';
    $Self->{Translation}->{'Volume Licence'} = 'Volume-Lizenz';
    $Self->{Translation}->{'Enterprise Licence'} = 'Enterprise-Lizenz';
    $Self->{Translation}->{'Developer Licence'} = 'Entwickler-Lizenz';
    $Self->{Translation}->{'Demo'} = 'Demo';
    $Self->{Translation}->{'Time Restricted'} = 'Zeitlich begrenzt';
    $Self->{Translation}->{'Freeware'} = 'Freeware';
    $Self->{Translation}->{'Open Source'} = 'Open Source';
    $Self->{Translation}->{'Unlimited'} = 'Unlimitiert';

    # JS File: ITSM.Agent.ConfigItem.Zoom
    $Self->{Translation}->{'Ok'} = 'Ok';

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
    $Self->{Translation}->{'Branch View commit limit'} = 'Commit-Limit der Zweigansicht';
    $Self->{Translation}->{'CodePolicy'} = '';
    $Self->{Translation}->{'Commit limit per page for Branch view screen'} = 'Commit-Limit pro Seite für die Zweigansicht.';
    $Self->{Translation}->{'Create analysis file'} = 'Erstelle Analysedatei';
    $Self->{Translation}->{'Creates a analysis file from this ticket and sends to Znuny.'} =
        'Erstellt einen Analysedatei von diesem Ticket und sendet ihn an Znuny.';
    $Self->{Translation}->{'Creates a analysis file from this ticket.'} = 'Erstellt einen Analysedatei von diesem Ticket.';
    $Self->{Translation}->{'Define private addon repos.'} = '';
    $Self->{Translation}->{'Defines the filter that processes the HTML templates.'} = '';
    $Self->{Translation}->{'Defines the test module for checking code policy.'} = '';
    $Self->{Translation}->{'Definition of GIT clone/push URL Prefix.'} = 'Definition des GIT clone/push URL Präfix';
    $Self->{Translation}->{'Definition of a Dynamic Field: Group => Group with access to the Dynamic Fields; AlwaysVisible => Field can be removed (0|1); InformationAreaName => Name of the Widgets; InformationAreaSize => Size and position of the widgets (Large|Small); Name => Name of the Dynamic Field which should be used; Priority => Order of the Dynamic Fields; State => State of the Fields (0 = disabled, 1 = active, 2 = mandatory), FilterRelease => Regex which the repository name has to match to be displayed, FilterPackage => Regex which the package name has to match to be displayed, FilterBranch => Regex which the branch name has to match to be displayed, FilterRelease => Regex which the repelase version string has to match to be displayed.'} =
        'Definition eines dynamischen Feldes: Group => Gruppe mit Zugriff zu den dynamischen Feldern; AlwaysVisible => Feld kann entfernt werden (0|1); InformationAreaName => Name des Widgets; InformationAreaSize => Größe und Position des Widgets (Large|Small); Name => Der Name des zu benutzenden dynamischen Feldes; Priority => Sortierung des dynamischen Feldes; State => Status des Feldes (0 = deaktiviert, 1 = aktiviert, 2 = zwingend erforderlich), FilterRelease => Regulärer Ausdruck welcher den Repository Namen beschreibt, der angezeigt werden soll; FilterPackage => Regulärer Ausdruck welcher den Paketnamen beschreibt das angezeigt werden soll; FilterBranch => Regulärer Ausdruck welcher den Namen des Zweigs (Branch) beschreibt, der angezeigt werden soll; FilterRelease => Regulärer Ausdruck den Versions-String eines Releases beschreibt, das angezeigt werden soll.';
    $Self->{Translation}->{'Definition of a Dynamic Field: Group => Group with access to the Dynamic Fields; AlwaysVisible => Field can be removed (0|1); InformationAreaName => Name of the Widgets; InformationAreaSize => Size and position of the widgets (Large|Small); Name => Name of the Dynamic Field which should be used; Priority => Order of the Dynamic Fields; State => State of the Fields (0 = disabled, 1 = active, 2 = mandatory), FilterRepository => Regex which the repository name has to match to be displayed, FilterPackage => Regex which the package name has to match to be displayed, FilterBranch => Regex which the branch name has to match to be displayed, FilterRelease => Regex which the repelase version string has to match to be displayed.'} =
        'Definition eines dynamischen Felds: Group => Gruppe mit Zugriff auf das dynamische Feld; AlwaysVisible => Feld kann entfernt werden (0|1); InformationAreaName => Name des Widgets (Informationsbereich); InformationAreaSize => Größe und Position des Widgets (Large|Small); Name => Name des zu verwendeten dynamischen Feldes; Priority => Anordnung der dynamischen Felder; State => Status der dynamischen Felder (0 = deaktiviert, 1 = aktiviert, 2 = Pflichtfeld), FilterRepository => Regex der den Repository-Namen matchen muss um angezeigt zu werden, FilterPackage => Regex der den Packen-Namen matchen muss um angezeigt zu werden, FilterBranch => Regex der den Branch-Namen matchen muss um angezeigt zu werden, FilterRelease => Regex der den Release Version-String matchen muss um angezeigt zu werden.';
    $Self->{Translation}->{'Definition of external MD5 sums (key => MD5, Value => Vendor, PackageName, Version, Date).'} =
        'Definition externer MD5 Summen (key => MD5, Value => Hersteller, Paketname, Version, Datum).';
    $Self->{Translation}->{'Definition of mappings between public repository requests and internal OPMS repositories.'} =
        'Definition von Mappings zwischen öffentlichen Repository Anfragen und internen OPMS Repositories.';
    $Self->{Translation}->{'Definition of package states.'} = 'Definition der Paket Status.';
    $Self->{Translation}->{'Definition of renamed OPMS packages.'} = 'Definition umbenannter OPMS Pakete.';
    $Self->{Translation}->{'Directory, which is used by Git to cache repositories.'} = '';
    $Self->{Translation}->{'Directory, which is used by Git to store temporary data.'} = '';
    $Self->{Translation}->{'Directory, which is used by Git to store working copies.'} = '';
    $Self->{Translation}->{'Disable online repositories.'} = '';
    $Self->{Translation}->{'Do not log git ssh connection authorization results for these users. Useful for automated stuff.'} =
        'Für diese Benutzer werden keine Authorisierungen von Verbindungen geloggt. Nützlich für automatisierte Anfragen.';
    $Self->{Translation}->{'Dynamic Fields Screens'} = 'Dynamische Felder Oberflächen';
    $Self->{Translation}->{'DynamicFieldScreen'} = '';
    $Self->{Translation}->{'Export all available public keys to authorized_keys file.'} = 'Exportiert alle verfügbaren öffentlichen Schlüssel in die Datei "authorized_keys".';
    $Self->{Translation}->{'Export all relevant releases to ftp server.'} = 'Alle relevanten Releases auf den FTP-Server exportieren.';
    $Self->{Translation}->{'Frontend module registration for the OPMS object in the agent interface.'} =
        'Frontendmodul-Registration für das OPMS-Objekt im Agent-Interface.';
    $Self->{Translation}->{'Frontend module registration for the PublicOPMSRepository object in the public interface.'} =
        'Frontendmodul-Registration des PublicOPMSRepository-Objekts im Public-Interface.';
    $Self->{Translation}->{'Frontend module registration for the PublicOPMSRepositoryLookup object in the public interface.'} =
        'Frontendmodul-Registration für das PublicOPMSRepositoryLookup Objekt im Public-Interface.';
    $Self->{Translation}->{'Frontend module registration for the PublicOPMSTestBuild object in the public interface.'} =
        'Frontendmodul-Registration des PublicOPMSTestBuild-Objekts im Public-Interface.';
    $Self->{Translation}->{'Frontend module registration for the PublicPackageVerification object in the public interface.'} =
        'Frontendmodul-Registration für das PublicPackageVerification Objekt im Public-Interface.';
    $Self->{Translation}->{'Frontend module registration for the admin interface.'} = '';
    $Self->{Translation}->{'GIT Author registration.'} = 'Registrierung der GIT Verfasser';
    $Self->{Translation}->{'Generate HTML comment hooks for the specified blocks so that filters can use them.'} =
        '';
    $Self->{Translation}->{'Generate documentations once per night.'} = '';
    $Self->{Translation}->{'Git'} = 'Git';
    $Self->{Translation}->{'Git Management'} = 'Git-Verwaltung';
    $Self->{Translation}->{'Git Repository'} = '';
    $Self->{Translation}->{'Group, whose members have delete admin permissions in OPMS.'} = 'Gruppe, dessen Mitglieder Delete-Admin-Rechte in OPMS haben.';
    $Self->{Translation}->{'Group, whose members have repository admin permissions in OPMS.'} =
        'Gruppe, dessen Mitglieder Repository-Admin-Rechte in OPMS haben.';
    $Self->{Translation}->{'Group, whose members will see CI test result information in OPMS screens.'} =
        '';
    $Self->{Translation}->{'Groups an authenticated user (by user login and password) must be member of to build test packages via the public interface.'} =
        'Gruppen denen ein authentifizierter Benutzer (durch Benutzernamen und Passwort) angehören muss, um Testpakete über das Public-Interface zu erzeugen.';
    $Self->{Translation}->{'Groups which will be set during git project creation processes while adding OPMS repositories.'} =
        'Gruppen welche automatisch durch das Anlegen von GIT-Projekten gesetzt werden, während OPMS Repositories angelegt werden.';
    $Self->{Translation}->{'Manage dynamic field in screens.'} = 'Verwaltung von dynamischen Feldern in Oberflächen.';
    $Self->{Translation}->{'Manage your public SSH key(s) for Git access here. Make sure to save this preference when you add a new key.'} =
        'Verwalten Sie hier Ihre öffentlichen SSH-Schlüssel für den Git-Zugang. Achten Sie darauf, diese Einstellung zu speichern, wenn Sie einen neuen Schlüssel hinzufügen.';
    $Self->{Translation}->{'Module to generate statistics about the added code lines.'} = 'Modul zur Erstellung von Statistiken über die hinzugefügten Code-Zeilen.';
    $Self->{Translation}->{'Module to generate statistics about the growth of code.'} = 'Modul zur Generierung von Statistiken über das Wachstum von Code.';
    $Self->{Translation}->{'Module to generate statistics about the number of git commits.'} =
        'Modul zur Erstellung von Statistiken über die Anzahl der Git-Commits.';
    $Self->{Translation}->{'Module to generate statistics about the removed code lines.'} = 'Modul zur Erstellung von Statistiken über die gelöschten Code-Zeilen.';
    $Self->{Translation}->{'OPMS'} = 'OPMS';
    $Self->{Translation}->{'Only users who have rw permissions in one of these groups may access git.'} =
        'Nur Benutzer, die über rw-Berechtigungen in einer dieser Gruppen verfügen, können auf Git zugreifen.';
    $Self->{Translation}->{'Option to set a package compatibility manually.'} = '';
    $Self->{Translation}->{'Parameters for the pages in the BranchView screen.'} = 'Parameter für die Seiten in der BranchView-Ansicht.';
    $Self->{Translation}->{'Pre-Definition of the \'GITProjectName\' Dynamic Field: Group => Group with access to the Dynamic Fields; AlwaysVisible => Field can be removed (0|1); InformationAreaName => Name of the Widgets; InformationAreaSize => Size and position of the widgets (Large|Small); Name => Name of the Dynamic Field which should be used; Priority => Order of the Dynamic Fields; State => State of the Fields (0 = disabled, 1 = active, 2 = mandatory), FilterRepository => Regex which the repository name has to match to be displayed, FilterPackage => Regex which the package name has to match to be displayed, FilterBranch => Regex which the branch name has to match to be displayed, FilterRelease => Regex which the repelase version string has to match to be displayed.'} =
        'Vor-Definition des dynamischen Feldes \'GITProjectName\': Group => Gruppe mit Zugriff auf das dynamische Feld; AlwaysVisible => Feld kann entfernt werden (0|1); InformationAreaName => Name des Widgets (Informationsbereich); InformationAreaSize => Größe und Position des Widgets (Large|Small); Name => Name des zu verwendeten dynamischen Feldes; Priority => Anordnung der dynamischen Felder; State => Status der dynamischen Felder (0 = deaktiviert, 1 = aktiviert, 2 = Pflichtfeld), FilterRepository => Regex der den Repository-Namen matchen muss um angezeigt zu werden, FilterPackage => Regex der den Packen-Namen matchen muss um angezeigt zu werden, FilterBranch => Regex der den Branch-Namen matchen muss um angezeigt zu werden, FilterRelease => Regex der den Release Version-String matchen muss um angezeigt zu werden.';
    $Self->{Translation}->{'Pre-Definition of the \'GITRepositoryName\' Dynamic Field: Group => Group with access to the Dynamic Fields; AlwaysVisible => Field can be removed (0|1); InformationAreaName => Name of the Widgets; InformationAreaSize => Size and position of the widgets (Large|Small); Name => Name of the Dynamic Field which should be used; Priority => Order of the Dynamic Fields; State => State of the Fields (0 = disabled, 1 = active, 2 = mandatory), FilterRepository => Regex which the repository name has to match to be displayed, FilterPackage => Regex which the package name has to match to be displayed, FilterBranch => Regex which the branch name has to match to be displayed, FilterRelease => Regex which the repelase version string has to match to be displayed.'} =
        'Vor-Definition des dynamischen Feldes \'GITRepositoryName\': Group => Gruppe mit Zugriff auf das dynamische Feld; AlwaysVisible => Feld kann entfernt werden (0|1); InformationAreaName => Name des Widgets (Informationsbereich); InformationAreaSize => Größe und Position des Widgets (Large|Small); Name => Name des zu verwendeten dynamischen Feldes; Priority => Anordnung der dynamischen Felder; State => Status der dynamischen Felder (0 = deaktiviert, 1 = aktiviert, 2 = Pflichtfeld), FilterRepository => Regex der den Repository-Namen matchen muss um angezeigt zu werden, FilterPackage => Regex der den Packen-Namen matchen muss um angezeigt zu werden, FilterBranch => Regex der den Branch-Namen matchen muss um angezeigt zu werden, FilterRelease => Regex der den Release Version-String matchen muss um angezeigt zu werden.';
    $Self->{Translation}->{'Pre-Definition of the \'PackageDeprecated\' Dynamic Field: Group => Group with access to the Dynamic Fields; AlwaysVisible => Field can be removed (0|1); InformationAreaName => Name of the Widgets; InformationAreaSize => Size and position of the widgets (Large|Small); Name => Name of the Dynamic Field which should be used; Priority => Order of the Dynamic Fields; State => State of the Fields (0 = disabled, 1 = active, 2 = mandatory), FilterRepository => Regex which the repository name has to match to be displayed, FilterPackage => Regex which the package name has to match to be displayed, FilterBranch => Regex which the branch name has to match to be displayed, FilterRelease => Regex which the repelase version string has to match to be displayed.'} =
        'Vor-Definition des dynamischen Feldes \'PackageDeprecated\': Group => Gruppe mit Zugriff auf das dynamische Feld; AlwaysVisible => Feld kann entfernt werden (0|1); InformationAreaName => Name des Widgets (Informationsbereich); InformationAreaSize => Größe und Position des Widgets (Large|Small); Name => Name des zu verwendeten dynamischen Feldes; Priority => Anordnung der dynamischen Felder; State => Status der dynamischen Felder (0 = deaktiviert, 1 = aktiviert, 2 = Pflichtfeld), FilterRepository => Regex der den Repository-Namen matchen muss um angezeigt zu werden, FilterPackage => Regex der den Packen-Namen matchen muss um angezeigt zu werden, FilterBranch => Regex der den Branch-Namen matchen muss um angezeigt zu werden, FilterRelease => Regex der den Release Version-String matchen muss um angezeigt zu werden.';
    $Self->{Translation}->{'Recipients that will be informed by email in case of errors.'} =
        '';
    $Self->{Translation}->{'SSH Keys for Git Access'} = 'SSH-Schlüssel für den Git-Zugang';
    $Self->{Translation}->{'Send analysis file'} = 'Sende Analysedatei';
    $Self->{Translation}->{'Sets the git clone address to be used in repository listings.'} =
        'Legt die Git-Clone-Adresse fest, die in Repository-Listen verwendet werden soll.';
    $Self->{Translation}->{'Sets the home directory for git repositories.'} = 'Legt das Home-Verzeichnis für Git-Repositorys fest.';
    $Self->{Translation}->{'Sets the path for the BugzillaAddComment post receive script location.'} =
        'Legt den Pfad zums BugzillaAddComment post receive Skript fest.';
    $Self->{Translation}->{'Sets the path for the OTRSCodePolicy  script location. It is recommended to have a separate clone of the OTRSCodePolicy module that is updated via cron.'} =
        '';
    $Self->{Translation}->{'Sets the path for the OTRSCodePolicy pre receive script location. It is recommended to have a separate clone of the OTRSCodePolicy module that is updated via cron.'} =
        'Legt den Pfad zum OTRSCodePolicy pre-receive Skript fest. Es wird empfohlen, einen separaten Klon des OTRSCodePolicy-Moduls zu verwenden, der über Cron aktualisiert wird.';
    $Self->{Translation}->{'Show latest commits in git repositories.'} = '';
    $Self->{Translation}->{'Shows a link in the menu to go create a unit test from the current ticket.'} =
        '';
    $Self->{Translation}->{'Synchronize OPMS tables with a remote database.'} = 'Synchronisiert OPMS Tabellen mit einer entfernten Datenbank.';
    $Self->{Translation}->{'The minimum version of the sphinx library.'} = '';
    $Self->{Translation}->{'The name of the sphinx theme to be used.'} = '';
    $Self->{Translation}->{'The path to the OTRS CSS file (relative below the static path).'} =
        '';
    $Self->{Translation}->{'The path to the OTRS logo (relative below the static path).'} = '';
    $Self->{Translation}->{'The path to the static folder, containing images and css files.'} =
        '';
    $Self->{Translation}->{'The path to the theme folder, containing the sphinx themes.'} = '';
    $Self->{Translation}->{'This configuration defines all possible screens to enable or disable default columns.'} =
        'Diese Konfiguration definiert alle möglichen Oberflächen in denen dynamische Felder als DefaultColumns aktiviert/deaktiviert werden können.';
    $Self->{Translation}->{'This configuration defines all possible screens to enable or disable dynamic fields.'} =
        'Diese Konfiguration definiert alle möglichen Oberflächen in denen dynamische Felder als DynamicFields aktiviert/deaktiviert werden können.';
    $Self->{Translation}->{'This configuration defines if only valids or all (invalids) dynamic fields should be shown.'} =
        'Diese Konfiguration definiert ob nur gültige oder alle (ungültige) dynamischen Felder angezeigt werden sollen.';
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
        'Benutzer, die rw-Berechtigungen in einer dieser Gruppen haben, dürfen Force-Pushes \'git push --force\' ausführen.';
    $Self->{Translation}->{'Users who have rw permissions in one of these groups are permitted to manage projects. Additionally the members have administration permissions to the git management.'} =
        'Benutzer die über rw-Berechtigungen in einer dieser Gruppen verfügen, können Projekte verwalten. Zusätzlich haben die Mitglieder Administrationsberechtigungen für die Git-Verwaltung.';


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

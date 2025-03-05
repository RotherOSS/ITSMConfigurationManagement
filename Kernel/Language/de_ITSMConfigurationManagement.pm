# --
# OTOBO is a web-based ticketing system for service organisations.
# --
# Copyright (C) 2001-2020 OTRS AG, https://otrs.com/
# Copyright (C) 2019-2025 Rother OSS GmbH, https://otobo.io/
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

    # Template: AdminGenericInterfaceOperationConfigItem
    $Self->{Translation}->{'General operation data'} = '';
    $Self->{Translation}->{'Settings for incoming request data'} = '';
    $Self->{Translation}->{'Settings for outgoing response data'} = '';

    # Template: AdminITSMConfigItem
    $Self->{Translation}->{'Config Item Management'} = 'ConfigItem-Verwaltung';
    $Self->{Translation}->{'Change class definition'} = 'Klassen-Definition ändern';
    $Self->{Translation}->{'Change role definition'} = 'Rollendefinition ändern';
    $Self->{Translation}->{'Ready2Import Class Bundles'} = 'Ready2Import-Klassenbündel';
    $Self->{Translation}->{'Here you can import Ready2Import class bundles showcasing our most usual config items. Please note that some additional configuration may be required.'} =
        'Hier können Sie Ready2Import-Klassenbündel importieren, die unsere gebräuchlichsten Konfigurationspunkte zeigen. Bitte beachten Sie, dass einige zusätzliche Konfigurationen erforderlich sein können.';
    $Self->{Translation}->{'Update existing entities'} = 'Vorhandene Entitäten aktualisieren';
    $Self->{Translation}->{'Import Ready2Adopt class bundles'} = 'Ready2Adopt-Klassenbündel importieren';
    $Self->{Translation}->{'Config Item Class'} = 'ConfigItem-Klasse';
    $Self->{Translation}->{'Config Item Role'} = 'Config Item-Rolle';

    # Template: AgentITSMConfigItemAdd
    $Self->{Translation}->{'Config Item'} = 'Config Item';
    $Self->{Translation}->{'Filter for Classes'} = 'Filter für Klassen';
    $Self->{Translation}->{'Select a Class from the list to create a new Config Item.'} = 'Wählen Sie eine Klasse aus der Liste aus um ein neues Config Item zu erstellen.';
    $Self->{Translation}->{'Class'} = 'Klasse';

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
    $Self->{Translation}->{'Version Number'} = 'Versionsnummer';
    $Self->{Translation}->{'Version number of this config item'} = 'Versionsnummer dieses Konfigurationselements';
    $Self->{Translation}->{'Version Number is already in use by the ConfigItems with the following Number(s): %s'} =
        'Die Versionsnummer wird bereits von den ConfigItems mit den folgenden Nummern verwendet: %s';
    $Self->{Translation}->{'Deployment State'} = 'Verwendungsstatus';
    $Self->{Translation}->{'Incident State'} = 'Vorfallstatus';

    # Template: AgentITSMConfigItemHistory
    $Self->{Translation}->{'History of Config Item: %s'} = 'Historie von Configuration Item: %s';
    $Self->{Translation}->{'History Content'} = 'Änderungsverlauf';
    $Self->{Translation}->{'Createtime'} = 'Erstellt';
    $Self->{Translation}->{'Zoom view'} = 'Detailansicht';

    # Template: AgentITSMConfigItemOverviewNavBar
    $Self->{Translation}->{'Config Items per page'} = 'Configuration Items pro Seite';

    # Template: AgentITSMConfigItemOverviewSmall
    $Self->{Translation}->{'No config item data found.'} = 'Keine Config Item-Daten gefunden.';
    $Self->{Translation}->{'Select this config item'} = 'Config Item auswählen';

    # Template: AgentITSMConfigItemSearch
    $Self->{Translation}->{'Run Search'} = 'Suche ausführen';
    $Self->{Translation}->{'Also search in previous versions?'} = 'Auch in früheren Versionen suchen?';

    # Template: AgentITSMConfigItemTreeView
    $Self->{Translation}->{'TreeView for ConfigItem'} = 'TreeView für Config Item';
    $Self->{Translation}->{'Depth Level'} = 'Tiefe Ebene';
    $Self->{Translation}->{'Zoom In/Out'} = 'Vergrößern/Verkleinern';
    $Self->{Translation}->{'Max links level reached for ConfigItem!'} = 'Maximale Verknüpfungsebene für ConfigItem erreicht!';

    # Template: AgentITSMConfigItemZoom
    $Self->{Translation}->{'Configuration Item'} = 'Configuration Item';
    $Self->{Translation}->{'Configuration Item Information'} = 'Configuration Item Information';
    $Self->{Translation}->{'Current Deployment State'} = 'Aktueller Verwendungsstatus';
    $Self->{Translation}->{'Current Incident State'} = 'Aktueller Vorfallstatus';
    $Self->{Translation}->{'Last changed'} = 'Zuletzt geändert';
    $Self->{Translation}->{'Last changed by'} = 'Zuletzt geändert von';

    # Template: CustomerITSMConfigItem
    $Self->{Translation}->{'Your ConfigItems'} = 'Ihre Config Items';

    # Template: CustomerITSMConfigItemSearch
    $Self->{Translation}->{'ConfigItem Search'} = 'Config Item-Suche';

    # Template: AdminACL
    $Self->{Translation}->{'Object Type'} = 'Objekt-Typ';

    # JS Template: ClassImportConfirm
    $Self->{Translation}->{'The following classes will be imported'} = 'Die folgenden Klassen werde importiert';
    $Self->{Translation}->{'The following roles will be imported'} = 'Die folgenden Rollen werden importiert';
    $Self->{Translation}->{'Note that also corresponding dynamic fields and GeneralCatalog classes will be created and there is no automatic removal.'} =
        'Beachten Sie, dass auch entsprechende dynamische Felder und GeneralCatalog-Klassen erstellt werden und es keine automatische Löschung gibt.';
    $Self->{Translation}->{'Do you want to proceed?'} = 'Möchten Sie fortfahren?';

    # Perl Module: Kernel/Modules/AdminITSMConfigItem.pm
    $Self->{Translation}->{'Need ExampleClasses!'} = 'Benötige ExampleClasses!';
    $Self->{Translation}->{'Definition is no valid YAML hash.'} = 'Definition ist kein gültiges YAML-Hash.';

    # Perl Module: Kernel/Modules/AgentITSMConfigItem.pm
    $Self->{Translation}->{'Overview: ITSM ConfigItem'} = 'Übersicht: ITSM ConfigItem';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemBulk.pm
    $Self->{Translation}->{'No ConfigItemID is given!'} = 'Keine ID für das Configuration Item angegeben!';
    $Self->{Translation}->{'You need at least one selected Configuration Item!'} = 'Sie benötigen wenigstens ein ausgewähltes Configuration Item!';
    $Self->{Translation}->{'You don\'t have write access to this configuration item: %s.'} =
        'Sie haben keine Schreib-Berechtigungen für dieses Configuration Item: %s.';
    $Self->{Translation}->{'No definition was defined for class %s!'} = 'Keine Definition für Klasse %s definiert!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemDelete.pm
    $Self->{Translation}->{'Config item "%s" not found in database!'} = 'Configuration Item "%s" in Datenbank nicht gefunden!';
    $Self->{Translation}->{'Was not able to delete the configitem ID %s!'} = 'Es war nicht möglich, die Configuration Item-ID %s zu löschen!';
    $Self->{Translation}->{'No version found for ConfigItemID %s!'} = 'Keine Version für Configuration Item-ID %s gefunden!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemEdit.pm
    $Self->{Translation}->{'No ConfigItemID, DuplicateID or ClassID is given!'} = 'Keine Configuration Item-ID, Duplikats-ID oder Klassen-ID angegeben!';
    $Self->{Translation}->{'No access is given!'} = 'Kein Zugriff gewährt!';

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
    $Self->{Translation}->{'ConfigItem not found!'} = 'Config Item nicht gefunden!';
    $Self->{Translation}->{'No versions found!'} = 'Keine Versionen gefunden!';
    $Self->{Translation}->{'operational'} = 'operativ';
    $Self->{Translation}->{'warning'} = 'Warnung';
    $Self->{Translation}->{'incident'} = 'Vorfall';
    $Self->{Translation}->{'The deployment state of this config item'} = 'Der Verwendungsstatus dieses Config Items';
    $Self->{Translation}->{'The incident state of this config item'} = 'Der Vorfallstatus dieses Config Items';

    # Perl Module: Kernel/Modules/CustomerITSMConfigItemSearch.pm
    $Self->{Translation}->{'No permission'} = 'Keine Berechtigung';
    $Self->{Translation}->{'Filter invalid!'} = 'Filter ungültig!';
    $Self->{Translation}->{'Search params invalid!'} = 'Suchparameter ungültig!';

    # Perl Module: Kernel/Output/HTML/Dashboard/ITSMConfigItemGeneric.pm
    $Self->{Translation}->{'Shown config items'} = 'Angezeigte Configuration Items';
    $Self->{Translation}->{'Deployment State Type'} = 'Verwendungsstatus';
    $Self->{Translation}->{'Current Incident State Type'} = 'Aktueller Vorfallsstatus-Typ';

    # Perl Module: Kernel/Output/HTML/ITSMConfigItem/LayoutDate.pm
    $Self->{Translation}->{'Between'} = 'Zwischen';

    # Perl Module: Kernel/System/DynamicField/Driver/ConfigItem.pm
    $Self->{Translation}->{'Class restrictions for the config item'} = 'Klasseneinschränkungen für das Konfigurationsobjekt';
    $Self->{Translation}->{'Select one or more classes to restrict selectable config items'} =
        'Wählen Sie eine oder mehrere Klassen aus, um die auswählbaren Config Items einzuschränken';
    $Self->{Translation}->{'Link type'} = 'Link-Typ';
    $Self->{Translation}->{'Select the link type.'} = 'Link-Typ auswählen.';

    $Self->{Translation}->{'Forwards: Referencing (Source) -> Referenced (Target)'} = 'Vorwärts: Referenzierung (Quelle) -> Referenziert (Ziel)';
    $Self->{Translation}->{'Backwards: Referenced (Source) -> Referencing (Target)'} = 'Rückwärts: Referenziert (Quelle) -> Referenziert (Ziel)';
    $Self->{Translation}->{'Link Direction'} = 'Link Richtung';

    $Self->{Translation}->{'The referencing object is the one containing this dynamic field, the referenced object is the one selected as value of the dynamic field.'} =
        'Das referenzierende Objekt ist dasjenige, das dieses dynamische Feld enthält, das referenzierte Objekt ist dasjenige, das als Wert für das dynamische Feld ausgewählt wurde.';
    $Self->{Translation}->{'Dynamic (ConfigItem)'} = 'Dynamisch (ConfigItem)';
    $Self->{Translation}->{'Static (Version)'} = 'Statisch (Version)';
    $Self->{Translation}->{'Link Referencing Type'} = 'Link-Referenzierungsart';
    $Self->{Translation}->{'Whether this link applies to the ConfigItem or the static version of the referencing object. Current Incident State calculation only is performed on dynamic links.'} =
        'Angabe, ob sich dieser Link auf das ConfigItem oder die statische Version des referenzierenden Objekts bezieht. Die Berechnung des aktuellen Vorfallsstatus wird nur bei dynamischen Links durchgeführt.';
    $Self->{Translation}->{'Select the attribute which config items will be searched by'} = 'Wählen Sie das Attribut aus, nach dem die Konfigurationselemente durchsucht werden sollen';

    # Perl Module: Kernel/System/ITSMConfigItem/Definition.pm
    $Self->{Translation}->{'Base structure is not valid. Please provide a hash with data in YAML format.'} =
        'Basisstruktur ist nicht gültig. Bitte geben Sie einen Hash mit Daten im YAML-Format an.';
    $Self->{Translation}->{'Starting the YAML string with \'---\' is required.'} = 'Der Beginn der YAML-Zeichenkette mit \'---\' ist erforderlich.';

    # Perl Module: Kernel/System/ITSMConfigItem/Link.pm
    $Self->{Translation}->{'Could not purge the table configitem_link.'} = 'Die Tabelle configitem_link konnte nicht gelöscht werden.';
    $Self->{Translation}->{'No relevant dynamic fields were found'} = 'Es wurden keine relevanten dynamischen Felder gefunden';
    $Self->{Translation}->{'Could not insert into the table configitem_link'} = 'Konnte nicht in die Tabelle configitem_link eingefügt werden';
    $Self->{Translation}->{'Inserted 0 rows into the table configitem_link'} = '0 Zeilen in die Tabelle configitem_link eingefügt';

    # Perl Module: Kernel/System/ImportExport/ObjectBackend/ITSMConfigItem.pm
    $Self->{Translation}->{'Maximum number of one element'} = 'Maximale Anzahl eines Elements';
    $Self->{Translation}->{'Empty fields indicate that the current values are kept'} = 'Leere Felder zeigen an, dass die aktuellen Werte beibehalten werden';
    $Self->{Translation}->{'Import/Export attachments (as the last entries per line)'} = '';
    $Self->{Translation}->{'Version String'} = '';
    $Self->{Translation}->{'Skipped'} = 'Übersprungen';

    # Perl Module: Kernel/Modules/AdminDynamicField.pm
    $Self->{Translation}->{'Error synchronizing the definitions. Please check the log.'} = 'Fehler beim Synchronisieren der Definitionen. Bitte prüfen Sie das Protokoll.';
    $Self->{Translation}->{'You have ITSMConfigItem definitions which are not synchronized. Please deploy your ITSMConfigItem dynamic field changes.'} =
        'Sie haben ITSMConfigItem-Definitionen, die nicht synchronisiert sind. Bitte stellen Sie Ihre dynamischen ITSMConfigItem-Feldänderungen bereit.';

    # Database XML / SOPM Definition: ITSMConfigurationManagement.sopm
    $Self->{Translation}->{'Expired'} = 'Abgelaufen';
    $Self->{Translation}->{'Maintenance'} = 'In Wartung';
    $Self->{Translation}->{'Pilot'} = 'Pilotbetrieb';
    $Self->{Translation}->{'Planned'} = 'Geplant';
    $Self->{Translation}->{'Repair'} = 'In Reparatur';
    $Self->{Translation}->{'Retired'} = 'Außer Dienst';
    $Self->{Translation}->{'Review'} = 'Unter Review';
    $Self->{Translation}->{'Test/QA'} = 'Test/QS';

    # JS File: ITSM.Admin.ITSMConfigItem
    $Self->{Translation}->{'Overview and Confirmation'} = 'Überblick und Bestätigung';
    $Self->{Translation}->{'Importing classes/roles and their related fields'} = 'Import von Klassen/Rollen und ihren zugehörigen Feldern';
    $Self->{Translation}->{'An error occurred during class import.'} = 'Beim Klassenimport ist ein Fehler aufgetreten.';

    # SysConfig
    $Self->{Translation}->{'0 - Hidden'} = '0 - Versteckt';
    $Self->{Translation}->{'1 - Shown'} = '1 - Abgebildet';
    $Self->{Translation}->{'Allows extended search conditions in config item search of the agent interface. With this feature you can search e. g. config item name with this kind of conditions like "(*key1*&&*key2*)" or "(*key1*||*key2*)".'} =
        'Ermöglicht erweiterte Suchbedingungen bei der Suche nach Konfigurationsobjekten in der Agentenschnittstelle. Mit dieser Funktion können Sie z. B. den Namen des Konfigurationseintrags mit solchen Bedingungen wie "(*key1*&&*key2*)" oder "(*key1*||*key2*)" suchen.';
    $Self->{Translation}->{'Allows extended search conditions in config item search of the customer interface. With this feature you can search e. g. config item name with this kind of conditions like "(*key1*&&*key2*)" or "(*key1*||*key2*)".'} =
        'Ermöglicht erweiterte Suchbedingungen bei der Suche nach Konfigurationseinträgen in der Kundenschnittstelle. Mit dieser Funktion können Sie z. B. den Namen eines Konfigurationseintrags mit Bedingungen wie "(*key1*&&*key2*)" oder "(*key1*||*key2*)" suchen.';
    $Self->{Translation}->{'Assigned CIs'} = 'Zugewiesene Configuration Items';
    $Self->{Translation}->{'At a specific time point create a ticket for config items, if the configured requirements are met. The time point is determined by the value of the field configured under "TimeCIKey" of the ConfigItem, and modified by "TimeModifier". If the latter can be either just a number, or a sign (+/-), a number, and an unit (d/h/m): "7" is equivalent to "+7d". The DynamicField "Ticket->DynamicField" will be used to mark created tickets - it has to exist. The flags \<OTOBO_CONFIGITEM_X\> where X can be NAME, NUMBER and DATE, will be substituted with the respective values in "Ticket->Text".'} =
        'Zu einem bestimmten Zeitpunkt ein Ticket für ConfigItems erstellen, wenn die konfigurierten Anforderungen erfüllt sind. Der Zeitpunkt wird durch den Wert des unter "TimeCIKey" des ConfigItems konfigurierten Feldes bestimmt und durch "TimeModifier" modifiziert. Letzterer kann entweder nur eine Zahl sein, oder ein Vorzeichen (+/-), eine Zahl und eine Einheit (d/h/m): "7" entspricht "+7d". Das DynamicField "Ticket->DynamicField" wird verwendet, um erstellte Tickets zu markieren - es muss existieren. Die Flags \<OTOBO_CONFIGITEM_X\>, wobei X NAME, NUMBER und DATE sein kann, werden durch die entsprechenden Werte in "Ticket->Text" ersetzt.';
    $Self->{Translation}->{'CIs assigned to customer company'} = 'Zum Kunden zugewiesene Configurations Items';
    $Self->{Translation}->{'CIs assigned to customer user'} = 'Zum Kundenbenutzer zugewiesene Configurations Items';
    $Self->{Translation}->{'CMDB Settings'} = 'CMDB-Einstellungen';
    $Self->{Translation}->{'Check for a unique name only within the same ConfigItem class (\'class\') or globally (\'global\'), which means every existing ConfigItem is taken into account when looking for duplicates.'} =
        'Prüft Namen auf Eindeutigkeit innerhalb der selben Configuration Item-Klasse oder global, d.h. es werden alle Configuration Items jeglicher Configuration Item-Klasse bei der Prüfung auf einen eindeutigen Namen berücksichtigt.';
    $Self->{Translation}->{'Choose a module to enforce a naming scheme.'} = 'Wählen Sie ein Modul, um ein Benennungsschema zu erzwingen.';
    $Self->{Translation}->{'Choose a module to enforce a number scheme.'} = 'Wählen Sie ein Modul, um ein Nummernschema zu erzwingen.';
    $Self->{Translation}->{'Choose a module to enforce a version string scheme.'} = 'Wählen Sie ein Modul, um ein Versionskettenschema zu erzwingen.';
    $Self->{Translation}->{'Choose attributes to trigger the creation of a new version.'} = 'Wählen Sie Attribute, um die Erstellung einer neuen Version auszulösen.';
    $Self->{Translation}->{'Choose categories to assign to this config item class.'} = 'Wählen Sie Kategorien aus, die Sie dieser Konfigurationselementklasse zuordnen möchten.';
    $Self->{Translation}->{'Column config item filters for ConfigItem Overview.'} = 'Spaltenkonfigurationsfilter für ConfigItem Overview.';
    $Self->{Translation}->{'Columns that can be filtered in the config item overview of the agent interface. Note: Only Config Item attributes and Dynamic Fields (DynamicField_NameX) are allowed.'} =
        'Spalten, die in der Config Item Übersicht der Agentenschnittstelle gefiltert werden können. Hinweis: Nur Config Item Attribute und Dynamic Fields (DynamicField_NameX) sind erlaubt.';
    $Self->{Translation}->{'Columns that can be filtered in the config item overview of the customer interface. Note: Only Config Item attributes and Dynamic Fields (DynamicField_NameX) are allowed.'} =
        'Spalten, die in der Config Item Übersicht der Kundenschnittstelle gefiltert werden können. Hinweis: Nur Config Item Attribute und Dynamic Fields (DynamicField_NameX) sind erlaubt.';
    $Self->{Translation}->{'Columns that can be filtered in the config item search result overview of the agent interface. Note: Only Config Item attributes and Dynamic Fields (DynamicField_NameX) are allowed.'} =
        'Spalten, die in der Übersicht der Suchergebnisse der Agentenschnittstelle für Konfigurationsobjekte gefiltert werden können. Hinweis: Nur Config Item Attribute und Dynamic Fields (DynamicField_NameX) sind erlaubt.';
    $Self->{Translation}->{'Config Items'} = 'Configuration Items';
    $Self->{Translation}->{'Config item add.'} = 'Configuration Item hinzufügen.';
    $Self->{Translation}->{'Config item edit.'} = 'Configuration Item bearbeiten.';
    $Self->{Translation}->{'Config item event module that count the licenses for OTOBOCILicenseCount feature.'} =
        'Config item event module, das die Lizenzen für die Funktion OTOBOCILicenseCount zählt.';
    $Self->{Translation}->{'Config item event module that enables logging to history in the agent interface.'} =
        'Configuration Item-Event-Modul, das die Protokollierung der Historie im Agenten-Interface ermöglicht.';
    $Self->{Translation}->{'Config item event module that updates config items to their current definition.'} =
        'Config-Element-Ereignismodul, das Config-Elemente auf ihre aktuelle Definition aktualisiert.';
    $Self->{Translation}->{'Config item event module that updates the table configitem_ĺink.'} =
        'Config item event module, das die Tabelle configitem_ĺink aktualisiert.';
    $Self->{Translation}->{'Config item event module updates the current incident state.'} =
        'Das Config-Item-Ereignismodul aktualisiert den aktuellen Ereignisstatus.';
    $Self->{Translation}->{'Config item history.'} = 'Configuration Item-Historie.';
    $Self->{Translation}->{'Config item print.'} = 'Configuration Item drucken.';
    $Self->{Translation}->{'Config item zoom.'} = 'Configuration Item-Detailansicht.';
    $Self->{Translation}->{'ConfigItem Tree View'} = 'ConfigItem-Strukturansicht';
    $Self->{Translation}->{'ConfigItem Version'} = 'ConfigItem Version';
    $Self->{Translation}->{'ConfigItems of the following classes will not be stored on the Elasticsearch server. To apply this to existing CIs, the CI migration has to be run via console, after changing this option.'} =
        'ConfigItems der folgenden Klassen werden nicht auf dem Elasticsearch-Server gespeichert. Um dies auf bestehende CIs anzuwenden, muss die CI-Migration über die Konsole ausgeführt werden, nachdem diese Option geändert wurde.';
    $Self->{Translation}->{'ConfigItems with the following deployment states will not be stored on the Elasticsearch server. To apply this to existing CIs, the CI migration has to be run via console, after changing this option.'} =
        'ConfigItems mit den folgenden Bereitstellungszuständen werden nicht auf dem Elasticsearch-Server gespeichert. Um dies auf bestehende CIs anzuwenden, muss die CI-Migration über die Konsole ausgeführt werden, nachdem diese Option geändert wurde.';
    $Self->{Translation}->{'Configuration Item Limit'} = 'Configuration Item-Limit';
    $Self->{Translation}->{'Configuration Item limit per page.'} = 'Configuration Item-Limit pro Seite.';
    $Self->{Translation}->{'Configuration Management Database.'} = 'Configuration Management Database.';
    $Self->{Translation}->{'Configuration item bulk module.'} = 'Configuration Item-Sammelaktion.';
    $Self->{Translation}->{'Configuration item search backend router of the agent interface.'} =
        'Configuration Item Such-Backend Navigation des Agenten-Interface.';
    $Self->{Translation}->{'Create and manage the definitions for Configuration Items.'} = 'Die Definitionen von Configuration Item-Limit erstellen und verwalten.';
    $Self->{Translation}->{'Creates Tickets for ConfigItems at specific time points.'} = 'Erzeugt Tickets für ConfigItems zu bestimmten Zeitpunkten.';
    $Self->{Translation}->{'Customers can see historic CI versions.'} = 'Kunden können historische CI-Versionen einsehen.';
    $Self->{Translation}->{'Customers have the possibility to manually switch between historic CI versions.'} =
        'Kunden haben die Möglichkeit, manuell zwischen historischen CI-Versionen zu wechseln.';
    $Self->{Translation}->{'Default data to use on attribute for config item search screen. Example: "ITSMConfigItemCreateTimePointFormat=year;ITSMConfigItemCreateTimePointStart=Last;ITSMConfigItemCreateTimePoint=2;".'} =
        'Standarddaten, die auf dem Attribut für den Suchbildschirm für Konfigurationsobjekte verwendet werden sollen. Beispiel: "ITSMConfigItemCreateTimePointFormat=year;ITSMConfigItemCreateTimePointStart=Last;ITSMConfigItemCreateTimePoint=2;".';
    $Self->{Translation}->{'Default data to use on attribute for config item search screen. Example: "ITSMConfigItemCreateTimeStartYear=2010;ITSMConfigItemCreateTimeStartMonth=10;ITSMConfigItemCreateTimeStartDay=4;ITSMConfigItemCreateTimeStopYear=2010;ITSMConfigItemCreateTimeStopMonth=11;ITSMConfigItemCreateTimeStopDay=3;".'} =
        'Standarddaten, die für das Attribut für den Suchbildschirm für Konfigurationsobjekte verwendet werden sollen. Beispiel: "ITSMConfigItemCreateTimeStartYear=2010;ITSMConfigItemCreateTimeStartMonth=10;ITSMConfigItemCreateTimeStartDay=4;ITSMConfigItemCreateTimeStopYear=2010;ITSMConfigItemCreateTimeStopMonth=11;ITSMConfigItemCreateTimeStopDay=3;".';
    $Self->{Translation}->{'Define Actions where a settings button is available in the linked objects widget (LinkObject::ViewMode = "complex"). Please note that these Actions must have registered the following JS and CSS files: Core.AllocationList.css, Core.UI.AllocationList.js, Core.UI.Table.Sort.js, Core.Agent.TableFilters.js and Core.Agent.LinkObject.js.'} =
        'Definieren Sie Actions, in denen im Verknüpfte-Objekte-Widget ein Einstellungen-Knopf verfügbar sein soll (LinkObject::ViewMode = "complex"). Bitte beachten Sie, dass für diese Actions die folgenden JS- und CSS-Dateien registriert sein müssen: Core.AllocationList.css, Core.UI.AllocationList.js, Core.UI.Table.Sort.js, Core.Agent.TableFilters.js und Core.Agent.LinkObject.js.';
    $Self->{Translation}->{'Define a Template::Toolkit scheme for version strings. Only used if Version String Module is set to TemplateToolkit.'} =
        'Definiert ein Template::Toolkit-Schema für Versionsstrings. Wird nur verwendet, wenn Version String Module auf TemplateToolkit eingestellt ist.';
    $Self->{Translation}->{'Define a set of conditions under which a customer is allowed to see a config item. Conditions can optionally be restricted to certain customer groups. Name is the only mandatory attribute. If no other options are given, all config items will be visible under that category.'} =
        'Definieren Sie eine Reihe von Bedingungen, unter denen ein Kunde ein Konfigurationsobjekt sehen darf. Die Bedingungen können optional auf bestimmte Kundengruppen beschränkt werden. Der Name ist das einzige obligatorische Attribut. Wenn keine anderen Optionen angegeben werden, sind alle Konfigurationsobjekte unter dieser Kategorie sichtbar.';
    $Self->{Translation}->{'Defines Required permissions to delete ITSM configuration items using the Generic Interface.'} =
        'Definiert die benötigten Berechtigungen zum Löschen von ITSM Configuration Items durch das Generic Interface.';
    $Self->{Translation}->{'Defines Required permissions to get ITSM configuration items using the Generic Interface.'} =
        'Definiert die benötigten Berechtigungen, um ITSM-Configuration Items über das Generic Interface abzurufen.';
    $Self->{Translation}->{'Defines Required permissions to search ITSM configuration items using the Generic Interface.'} =
        'Definiert die benötigten Berechtigungen, um nach ITSM-Configuration Items mit dem Generic Interface zu suchen.';
    $Self->{Translation}->{'Defines Required permissions to set ITSM configuration items using the Generic Interface.'} =
        '';
    $Self->{Translation}->{'Defines an overview module to show the small view of a configuration item list.'} =
        'Definiert das Übersichtsmodul um die "Klein"-Ansicht einer Configuration Items-Liste anzuzeigen.';
    $Self->{Translation}->{'Defines if the link type labels must be shown in the node connections.'} =
        'Legt fest, ob die Beschriftungen der Verbindungstypen in den Knotenverbindungen angezeigt werden müssen.';
    $Self->{Translation}->{'Defines regular expressions individually for each ConfigItem class to check the ConfigItem name and to show corresponding error messages.'} =
        'Definiert reguläre Ausdrücke individuell für jedes Configuration Item, um den Namen des Configuration Item zu überprüfen und entsprechende Fehlermeldungen anzuzeigen.';
    $Self->{Translation}->{'Defines the available columns of CIs in the config item overview depending on the CI class. Each entry must consist of a class name and an array of available fields for the corresponding class. Dynamic field entries have to honor the scheme DynamicField_FieldName.'} =
        'Definiert die verfügbaren Spalten der CIs in der Konfigurationsübersicht in Abhängigkeit von der CI-Klasse. Jeder Eintrag muss aus einem Klassennamen und einem Array von verfügbaren Feldern für die entsprechende Klasse bestehen. Dynamische Feldeinträge müssen das Schema DynamicField_FieldName einhalten.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of the agent interface.'} =
        'Definiert das Standard-Konfigurationsattribut für die Sortierung des Konfigurationsergebnisses der Agentenschnittstelle.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of the customer interface.'} =
        'Definiert das Standard-Konfigurationsattribut für die Sortierung des Suchergebnisses der Kundenschnittstelle nach Konfig-Elementen.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of this operation.'} =
        'Definiert das Standard-Konfigurationsattribut für die Sortierung des Konfigurations-Suchergebnisses dieser Operation.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the agent interface. Up: oldest on top. Down: latest on top.'} =
        'Legt die Standardreihenfolge der Konfigurationsobjekte in den Suchergebnissen der Agentenschnittstelle fest. Up: ältester Eintrag oben. Nach unten: das neueste oben.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the customer interface. Up: oldest on top. Down: latest on top.'} =
        'Definiert die Standardreihenfolge der Konfigurationsobjekte in den Suchergebnissen der Kundenschnittstelle. Oben: ältester Eintrag ganz oben. Unten: neueste oben.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the this operation. Up: oldest on top. Down: latest on top.'} =
        'Legt die Standardreihenfolge der Konfigurationsobjekte im Suchergebnis dieser Operation fest. Up: ältester Eintrag oben. Nach unten: das Neueste oben.';
    $Self->{Translation}->{'Defines the default displayed columns of CIs in the config item overview depending on the CI class. Each entry must consist of a class name and an array of available fields for the corresponding class. Dynamic field entries have to honor the scheme DynamicField_FieldName.'} =
        'Definiert die standardmäßig angezeigten Spalten der CIs in der Konfigurationsübersicht in Abhängigkeit von der CI-Klasse. Jeder Eintrag muss aus einem Klassennamen und einem Array von verfügbaren Feldern für die entsprechende Klasse bestehen. Dynamische Feldeinträge müssen das Schema DynamicField_FieldName einhalten.';
    $Self->{Translation}->{'Defines the default relations depth to be shown.'} = 'Legt die Standardtiefe der Beziehungen fest, die angezeigt werden sollen.';
    $Self->{Translation}->{'Defines the default shown config item search attribute for config item search screen.'} =
        'Definiert das standardmäßig angezeigte Suchattribut für die Suche nach Konfigurationsobjekten.';
    $Self->{Translation}->{'Defines the default shown config item search attribute for config item search screen. Example: "Key" must have the name of the Dynamic Field in this case \'X\', "Content" must have the value of the Dynamic Field depending on the Dynamic Field type,  Text: \'a text\', Dropdown: \'1\', Date/Time: \'Search_DynamicField_XTimeSlotStartYear=1974; Search_DynamicField_XTimeSlotStartMonth=01; Search_DynamicField_XTimeSlotStartDay=26; Search_DynamicField_XTimeSlotStartHour=00; Search_DynamicField_XTimeSlotStartMinute=00; Search_DynamicField_XTimeSlotStartSecond=00; Search_DynamicField_XTimeSlotStopYear=2013; Search_DynamicField_XTimeSlotStopMonth=01; Search_DynamicField_XTimeSlotStopDay=26; Search_DynamicField_XTimeSlotStopHour=23; Search_DynamicField_XTimeSlotStopMinute=59; Search_DynamicField_XTimeSlotStopSecond=59;\' and or \'Search_DynamicField_XTimePointFormat=week; Search_DynamicField_XTimePointStart=Before; Search_DynamicField_XTimePointValue=7\';.'} =
        'Definiert das standardmäßig angezeigte Suchattribut für die Suchmaske des Konfigurationsobjekts. Beispiel: "Key" muss den Namen des dynamischen Feldes enthalten, in diesem Fall \'X\', "Content" muss den Wert des dynamischen Feldes enthalten, abhängig vom Typ des dynamischen Feldes, Text: \'a text\', Dropdown: \'1\', Date/Time: \'Search_DynamicField_XTimeSlotStartYear=1974; Search_DynamicField_XTimeSlotStartMonth=01; Search_DynamicField_XTimeSlotStartDay=26; Search_DynamicField_XTimeSlotStartHour=00; Search_DynamicField_XTimeSlotStartMinute=00; Search_DynamicField_XTimeSlotStartSecond=00; Search_DynamicField_XTimeSlotStopYear=2013; Search_DynamicField_XTimeSlotStopMonth=01; Search_DynamicField_XTimeSlotStopDay=26; Search_DynamicField_XTimeSlotStopHour=23; Search_DynamicField_XTimeSlotStopMinute=59; Search_DynamicField_XTimeSlotStopSecond=59;\' und oder \'Search_DynamicField_XTimePointFormat=week; Search_DynamicField_XTimePointStart=Before; Search_DynamicField_XTimePointValue=7\';.';
    $Self->{Translation}->{'Defines the default subobject of the class \'ITSMConfigItem\'.'} =
        'Definiert das Standard-Unterobjekt der Klasse \'ITSMConfigItem\'.';
    $Self->{Translation}->{'Defines the height for the rich text editor component for this screen. Enter number (pixels) or percent value (relative).'} =
        'Definiert die Höhe der RichText-Editor Komponente. Geben Sie einen Zahlen- (Pixel) oder Prozenwert (relativ) an.';
    $Self->{Translation}->{'Defines the number of rows for the CI definition editor in the admin interface.'} =
        'Definiert die Anzahl der Zeilen für den Editor der Configuration Item-Definition im Administrator-Interface.';
    $Self->{Translation}->{'Defines the order of incident states from high (e.g. cricital) to low (e.g. functional).'} =
        'Definiert die Reihenfolge der Vorfallstatus von hoch (bspw. kritisch) nach niedrig (bspw. funktional).';
    $Self->{Translation}->{'Defines the relevant deployment states where linked tickets can affect the status of a CI.'} =
        'Definiert relevante Verwendungsstatus, in denen verknüpfte Tickets den Status eines Configuration Items beeinflussen.';
    $Self->{Translation}->{'Defines the search limit for the AgentITSMConfigItem screen.'} =
        'Definiert das Suchlimit für die ITSM Configuration-Ansicht.';
    $Self->{Translation}->{'Defines the search limit for the AgentITSMConfigItemSearch screen.'} =
        'Definiert das Suchlimit für die Configuration Items-Suche.';
    $Self->{Translation}->{'Defines the search limit for the CustomerITSMConfigItem screen.'} =
        'Definiert die Suchgrenze für den Bildschirm CustomerITSMConfigItem.';
    $Self->{Translation}->{'Defines the search limit for the CustomerITSMConfigItemSearch screen.'} =
        'Legt die Suchgrenze für den Bildschirm CustomerITSMConfigItemSearch fest.';
    $Self->{Translation}->{'Defines the shown columns of CIs in the link table complex view for all CI classes. If there is no entry, then the default columns are shown.'} =
        'Definiert die angezeigten Spalten in der Komplexansicht der Verknüpfungstabelle für alle Configuration Item-Klassen. Wenn es keinen Eintrag gibt, werden die Standardspalten angezeigt.';
    $Self->{Translation}->{'Defines the shown columns of CIs in the link table complex view, depending on the CI class. Each entry must be prefixed with the class name and double colons (i.e. Computer::). There are a few CI-Attributes that common to all CIs (example for the class Computer: Computer::Name, Computer::CurDeplState, Computer::CreateTime). To show individual CI-Attributes as defined in the CI-Definition, the following scheme must be used (example for the class Computer): Computer::HardDisk::1, Computer::HardDisk::1::Capacity::1, Computer::HardDisk::2, Computer::HardDisk::2::Capacity::1. If there is no entry for a CI class, then the default columns are shown.'} =
        'Definiert die angezeigten Spalten von Configuration Items in der Komplexansicht der Verknüpfungstabelle abhängig von der Configuration Item-Klasse. Definiert die angezeigten Spalten von Configuration Items in der Configuration Item-Übersicht in Abhängigkeit von der Configuration Item-Klasse. Jedem Eintrag müssen der Klassenname und Doppelpunkte vorangestellt werden (z.B. Computer:::). Es gibt einige Configuration Item-Attribute, die allen Configuration Items gemeinsam sind (Beispiel für die Klasse Computer: Computer::Name, Computer::CurDeplState, Computer::CreateTime). Um einzelne Configuration Item-Attribute, wie sie in der Configuration Item-Definition definiert sind, darzustellen, muss das folgende Schema verwendet werden (Beispiel für die Klasse Computer): Computer::HardDisk::1, Computer::HardDisk::1::Kapazität::1, Computer::HardDisk::2, Computer::HardDisk::2::Kapazität::1. Wenn es keinen Eintrag für eine Configuration Item-Klasse gibt, werden die Standardspalten angezeigt.';
    $Self->{Translation}->{'Defines which items are available for \'Action\' in third level of the ITSM Config Item ACL structure.'} =
        'Legt fest, welche Elemente in der dritten Ebene der ITSM Config Item ACL-Struktur für "Action" verfügbar sind.';
    $Self->{Translation}->{'Defines which items are available in first level of the ITSM Config Item ACL structure.'} =
        'Legt fest, welche Elemente in der ersten Ebene der ITSM Config Item ACL-Struktur verfügbar sind.';
    $Self->{Translation}->{'Defines which items are available in second level of the ITSM Config Item ACL structure.'} =
        'Legt fest, welche Elemente in der zweiten Ebene der ITSM Config Item ACL-Struktur verfügbar sind.';
    $Self->{Translation}->{'Defines which type of link (named from the ticket perspective) can affect the status of a linked CI.'} =
        'Legt fest, welche Art von Link (aus der Ticketperspektive benannt) den Status eines verlinkten CI beeinflussen kann.';
    $Self->{Translation}->{'Defines which type of ticket can affect the status of a linked CI.'} =
        'Definiert, welcher Typ von Ticket den Status eines verknüpften Configuration Items beeinflussen kann.';
    $Self->{Translation}->{'Definition Update'} = 'Aktualisierung der Definition';
    $Self->{Translation}->{'Delete Configuration Item'} = 'Configuration Item löschen';
    $Self->{Translation}->{'DeplState'} = 'DeplState';
    $Self->{Translation}->{'Deployment State Color'} = 'Farbe Verwendungsstatus';
    $Self->{Translation}->{'DeploymentState'} = 'DeploymentState';
    $Self->{Translation}->{'Duplicate'} = 'Duplizieren';
    $Self->{Translation}->{'Dynamic field event module that marks config item definitions as out of sync, if containing dynamic fields change.'} =
        'Dynamisches Feld-Ereignismodul, das Konfigurationsdefinitionen als nicht mehr synchron markiert, wenn sich die darin enthaltenen dynamischen Felder ändern.';
    $Self->{Translation}->{'Dynamic fields shown in the additional ITSM field screen of the agent interface.'} =
        'Die angezeigten Dynamischen Felder in der Ansicht "zusätzliche ITSM-Felder" im Agenten-Interface.';
    $Self->{Translation}->{'Dynamic fields shown in the config item overview screen of the customer interface.'} =
        'Dynamische Felder, die in der Übersichtsmaske der Kundenschnittstelle angezeigt werden.';
    $Self->{Translation}->{'Dynamic fields shown in the config item search screen of the agent interface.'} =
        'Dynamische Felder, die in der Suchmaske der Agentenschnittstelle für Konfigurationsobjekte angezeigt werden.';
    $Self->{Translation}->{'Enables configuration item bulk action feature for the agent frontend to work on more than one configuration item at a time.'} =
        'Aktiviert die Funktion "Sammelaktion" für das Agenten-Frontend, um zur gleichen Zeit an mehreren Configuration Items arbeiten zu können.';
    $Self->{Translation}->{'Enables configuration item bulk action feature only for the listed groups.'} =
        'Aktiviert die Funktion "Sammelaktion" nur für die gelisteten Gruppen.';
    $Self->{Translation}->{'Enables/disables the functionality to check ITSM onfiguration items for unique names. Before enabling this option you should check your system for already existing config items with duplicate names. You can do this with the console command Admin::ITSM::Configitem::ListDuplicates.'} =
        'Aktiviert/deaktiviert die Funktion, ITSM-Konfigurationselemente auf eindeutige Namen zu prüfen. Bevor Sie diese Option aktivieren, sollten Sie Ihr System auf bereits vorhandene Konfigurationselemente mit doppelten Namen überprüfen. Sie können dies mit dem Konsolenbefehl Admin::ITSM::Configitem::ListDuplicates tun.';
    $Self->{Translation}->{'Event module to set configitem-status on ticket-configitem-link.'} =
        'Ein Ereignismodul das beim Verknüpfen von Tickets mit Configuration Items den Status des Configuration Items verändert.';
    $Self->{Translation}->{'Fields of the configuration item index, used for the fulltext search. Fields are also stored, but are not mandatory for the overall functionality. Inclusion of attachments can be disabled by setting the entry to 0 or deleting it.'} =
        'Felder des Konfigurationselementindex, die für die Volltextsuche verwendet werden. Felder werden ebenfalls gespeichert, sind aber für die Gesamtfunktionalität nicht zwingend erforderlich. Die Aufnahme von Anhängen kann deaktiviert werden, indem der Eintrag auf 0 gesetzt oder gelöscht wird.';
    $Self->{Translation}->{'Fields stored in the configuration item index which are used for other things besides fulltext searches. For the complete functionality all fields are mandatory.'} =
        'Im Index der Konfigurationselemente gespeicherte Felder, die neben der Volltextsuche auch für andere Zwecke verwendet werden. Für die vollständige Funktionalität sind alle Felder obligatorisch.';
    $Self->{Translation}->{'For every webservice (key) an array of classes (value) can be defined on which the import is restricted. For all chosen classes, or all existing classes the identifying attributes will have to be chosen in the invoker config.'} =
        'Für jeden Webservice (Schlüssel) kann ein Array von Klassen (Wert) definiert werden, auf die der Import beschränkt wird. Für alle gewählten Klassen oder alle vorhandenen Klassen müssen die identifizierenden Attribute in der Invokerkonfiguration ausgewählt werden.';
    $Self->{Translation}->{'GenericInterface module registration for the ConfigItemFetch invoker layer.'} =
        'GenericInterface-Modulregistrierung für die ConfigItemFetch-Aufruferschicht.';
    $Self->{Translation}->{'ITSM ConfigItem'} = 'ITSM ConfigElement';
    $Self->{Translation}->{'ITSM config item overview.'} = 'ITSM Configuration Item-Übersicht.';
    $Self->{Translation}->{'If this option is activated, linked items are only counted if they belong to one of the listed classes.'} =
        'Wenn diese Option aktiviert ist, werden verknüpfte Artikel nur dann gezählt, wenn sie zu einer der aufgeführten Klassen gehören.';
    $Self->{Translation}->{'InciState'} = 'InciState';
    $Self->{Translation}->{'IncidentState'} = 'VorfallZustand';
    $Self->{Translation}->{'Includes deployment states in the config item search of the customer interface.'} =
        'Schließt Bereitstellungszustände in die Suche nach Konfigurationselementen in der Kundenschnittstelle ein.';
    $Self->{Translation}->{'Includes incident states in the config item search of the customer interface.'} =
        'Schließt Vorfallszustände in die Konfigurationssuche der Kundenschnittstelle ein.';
    $Self->{Translation}->{'Maximum number of config items to be displayed in the result of this operation.'} =
        'Maximale Anzahl der Konfigurationsobjekte, die im Ergebnis dieser Operation angezeigt werden sollen.';
    $Self->{Translation}->{'Module to check the group responsible for a class.'} = 'Modul zur Überprüfung der Gruppe, die für eine Klasse verantwortlich ist.';
    $Self->{Translation}->{'Module to check the group responsible for a configuration item.'} =
        'Modul, um die Gruppe zu überprüfen, die für ein Configuration Item verantwortlich ist.';
    $Self->{Translation}->{'Module to generate ITSM config item statistics.'} = 'Modul zum Generieren von ITSM-Configuration Item-Statistiken.';
    $Self->{Translation}->{'Name Module'} = 'Name Modul';
    $Self->{Translation}->{'Number Module'} = 'Nummer Modul';
    $Self->{Translation}->{'Number of config items to be displayed in each page of a search result in the agent interface.'} =
        'Anzahl der Konfigurationspunkte, die auf jeder Seite eines Suchergebnisses in der Agentenschnittstelle angezeigt werden sollen.';
    $Self->{Translation}->{'Number of config items to be displayed in each page of a search result in the customer interface.'} =
        'Anzahl der Konfigurationspunkte, die auf jeder Seite eines Suchergebnisses in der Kundenschnittstelle angezeigt werden sollen.';
    $Self->{Translation}->{'Objects to search for, how many entries and which attributs to show. ConfigItem attributes have to explicitly be stored via Elasticsearch.'} =
        'Objekte, nach denen gesucht werden soll, wie viele Einträge und welche Attribute angezeigt werden sollen. ConfigItem-Attribute müssen explizit über Elasticsearch gespeichert werden.';
    $Self->{Translation}->{'Overview.'} = 'Übersicht.';
    $Self->{Translation}->{'Parameters for the categories for config item classes in the preferences view of the agent interface.'} =
        'Parameter für die Kategorien für Konfigurationsobjektklassen in der Einstellungsansicht der Agentenschnittstelle.';
    $Self->{Translation}->{'Parameters for the column filters of the small config item overview. Please note: setting \'Active\' to 0 will only prevent agents from editing settings of this group in their personal preferences, but will still allow administrators to edit the settings of another user\'s behalf. Use \'PreferenceGroup\' to control in which area these settings should be shown in the user interface.'} =
        'Parameter für die Spaltenfilter der kleinen Konfigurationsübersicht. Bitte beachten Sie: Wenn Sie \'Active\' auf 0 setzen, können Agenten die Einstellungen dieser Gruppe nur in ihren persönlichen Präferenzen bearbeiten, Administratoren können jedoch weiterhin die Einstellungen eines anderen Benutzers bearbeiten. Verwenden Sie \'PreferenceGroup\', um zu steuern, in welchem Bereich diese Einstellungen in der Benutzeroberfläche angezeigt werden sollen.';
    $Self->{Translation}->{'Parameters for the dashboard backend of the customer company config item overview of the agent interface . "Limit" is the number of entries shown by default. "Group" is used to restrict the access to the plugin (e. g. Group: admin;group1;group2;). "Default" determines if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" is the cache time in minutes for the plugin.'} =
        'Legt die Parameter für das Dashboard-Backend fest. "Limit" legt die Anzahl an Einträgen fest, die standardmäßig angezeigt werden. "Group" beschränkt den Zugang zum jeweiligen Dashlet (z. B. Group: admin;group1;group2). "Default" bestimmt, ob das Dashlet standardmäßig aktiv ist oder vom Nutzer manuell aktiviert werden muss. "CacheTTLLocal" bestimmt die Cachingdauer für das Dashlet in Minuten.';
    $Self->{Translation}->{'Parameters for the deployment states color in the preferences view of the agent interface.'} =
        'Definition von Farben für Verwendungsstatus in den persönlichen Einstellungen im Agenten-Interface.';
    $Self->{Translation}->{'Parameters for the deployment states in the preferences view of the agent interface.'} =
        'Parameter für Verwendungsstatus in den persönlichen Einstellungen im Agenten-Interface.';
    $Self->{Translation}->{'Parameters for the example permission groups of the general catalog attributes.'} =
        'Parameter für die zugriffsberechtigten Beispielgruppen der General Catalog-Attribute.';
    $Self->{Translation}->{'Parameters for the name module for config item classes in the preferences view of the agent interface.'} =
        'Parameter für das Namensmodul für Konfigurationsobjektklassen in der Einstellungsansicht der Agentenschnittstelle.';
    $Self->{Translation}->{'Parameters for the number module for config item classes in the preferences view of the agent interface.'} =
        'Parameter für das Nummernmodul für Konfigurationsobjektklassen in der Einstellungsansicht der Agentenschnittstelle.';
    $Self->{Translation}->{'Parameters for the pages (in which the configuration items are shown).'} =
        'Parameter für die Seiten, in denen Configuration Items angezeigt werden.';
    $Self->{Translation}->{'Parameters for the version string module for config item classes in the preferences view of the agent interface.'} =
        'Parameter für das Versionsstringmodul für Konfigurationsobjektklassen in der Einstellungsansicht der Agentenschnittstelle.';
    $Self->{Translation}->{'Parameters for the version string template toolkit module for config item classes in the preferences view of the agent interface.'} =
        'Parameter für das Versionstring-Template-Toolkit-Modul für Config-Item-Klassen in der Einstellungsansicht der Agentenschnittstelle.';
    $Self->{Translation}->{'Parameters for the version trigger for config item classes in the preferences view of the agent interface.'} =
        'Parameter für den Versions-Trigger für Config-Item-Klassen in der Einstellungsansicht der Agentenschnittstelle.';
    $Self->{Translation}->{'Performs the configured action for each event (as an Invoker) for each configured Webservice.'} =
        'Führt die konfigurierte Aktion für jedes Ereignis für jeden konfigurierten Webservice aus (als Invoker).';
    $Self->{Translation}->{'Permission Group'} = 'Berechtigungsgruppe';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item attachment action in the agent interface.'} =
        'Erforderliche Berechtigungen für die Verwendung der ITSM-Konfigurationsobjekt-Anhängeaktion in der Agentenschnittstelle.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item screen in the agent interface.'} =
        'Erforderliche Berechtigungen, um die Ansicht zur Konfiguration von Configuration Items im Agenten-Interface nutzen zu können.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item search screen in the agent interface.'} =
        'Erforderliche Berechtigungen, um die Ansicht zur Suche von Configuration Items im Agenten-Interface nutzen zu können.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item search screen in the customer interface.'} =
        'Erforderliche Berechtigungen zur Verwendung des ITSM-Suchbildschirms für Konfigurationselemente in der Kundenschnittstelle.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item tree view screen in the agent interface.'} =
        'Erforderliche Berechtigungen für die Verwendung der ITSM-Konfigurationsbaumansicht in der Agentenschnittstelle.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item zoom screen in the agent interface.'} =
        'Erforderliche Berechtigungen, um die Detailansicht von Configuration Items im Agenten-Interface nutzen zu können.';
    $Self->{Translation}->{'Required permissions to use the add ITSM configuration item screen in the agent interface.'} =
        'Erforderliche Berechtigungen, um die Ansicht zum Hinzufügen von Configuration Items im Agenten-Interface nutzen zu können.';
    $Self->{Translation}->{'Required permissions to use the bulk ITSM configuration item screen in the agent interface.'} =
        'Erforderliche Berechtigungen zur Verwendung des ITSM-Konfigurationsbildschirms in der Agentenschnittstelle.';
    $Self->{Translation}->{'Required permissions to use the edit ITSM configuration item screen in the agent interface.'} =
        'Erforderliche Berechtigungen, um die Ansicht zum Bearbeiten von Configuration Items im Agenten-Interface nutzen zu können.';
    $Self->{Translation}->{'Required permissions to use the history ITSM configuration item screen in the agent interface.'} =
        'Erforderliche Berechtigungen, um die Historien-Ansicht von Configuration Items im Agenten-Interface nutzen zu können.';
    $Self->{Translation}->{'Required permissions to use the print ITSM configuration item screen in the agent interface.'} =
        'Erforderliche Berechtigungen, um die Ansicht zum Drucken von Configuration Items im Agenten-Interface nutzen zu können.';
    $Self->{Translation}->{'Required privileges to delete config items.'} = 'Erforderliche Berechtigungen, um Configuration Items löschen zu können.';
    $Self->{Translation}->{'Search config items.'} = 'Configuration Items suchen.';
    $Self->{Translation}->{'Set the incident state of a CI automatically when a Ticket is Linked to a CI.'} =
        'Settzt den Vorfallstatus eines Configuration Items automatisch, wenn ein Ticket mit einem Configuration Item verknüpft wird.';
    $Self->{Translation}->{'Sets the deployment state in the configuration item bulk screen of the agent interface.'} =
        'Setzt den Verwendungsstatus in der Funktion "Sammelaktion" für Configuration Items im Agenten-Interface.';
    $Self->{Translation}->{'Sets the incident state in the configuration item bulk screen of the agent interface.'} =
        'Setzt den Verwendungsstatus für die Funktion "Sammelaktion" für Configuration Items im Agenten-Interace.';
    $Self->{Translation}->{'Shows a link in the menu that allows linking a configuration item with another object in the config item zoom view of the agent interface.'} =
        'Zeigt eine Verknüpfung im Menü, die es erlaubt ein Configuration Item mit einem anderen Objekt in der Detailansicht des Configuration Items des Agenten-Interface zu verknüpfen.';
    $Self->{Translation}->{'Shows a link in the menu to access the history of a configuration item in the configuration item overview of the agent interface.'} =
        'Zeigt im Menü der Configuration Item-Übersicht die Verknüpfung zur Historie eines Configuration Items.';
    $Self->{Translation}->{'Shows a link in the menu to access the history of a configuration item in the its zoom view of the agent interface.'} =
        'Zeigt im Menü der Configuration Item-Detailansicht die Verknüpfung zur Historie eines Configuration Items.';
    $Self->{Translation}->{'Shows a link in the menu to delete a configuration item in its zoom view of the agent interface.'} =
        'Zeigt im Menü der Detailansicht eines Configuration Items die Verknüpfung zum Löschen eines Configuration Items.';
    $Self->{Translation}->{'Shows a link in the menu to display the configuration item links as a Tree View.'} =
        'Zeigt einen Link im Menü an, um die Links zu den Konfigurationselementen in einer Baumansicht anzuzeigen.';
    $Self->{Translation}->{'Shows a link in the menu to duplicate a configuration item in the configuration item overview of the agent interface.'} =
        'Zeigt im Menü der Configuration Item-Übersicht die Verknüpfung zum Duplizieren eines Configuration Items.';
    $Self->{Translation}->{'Shows a link in the menu to duplicate a configuration item in the its zoom view of the agent interface.'} =
        'Zeigt im Menü der Detailansicht eines Configuration Items die Verknüpfung zum Duplizieren eines Configuration Items.';
    $Self->{Translation}->{'Shows a link in the menu to edit a configuration item in the its zoom view of the agent interface.'} =
        'Zeigt im Menü der Detailansicht eines Configuration Items die Verknüpfung zum Bearbeiten eines Configuration Items.';
    $Self->{Translation}->{'Shows a link in the menu to go back in the configuration item zoom view of the agent interface.'} =
        'Zeigt im Menü der Detailansicht eines Configuration Item eine Verknüpfung zum Zurückgehen auf die vorherige Ansicht.';
    $Self->{Translation}->{'Shows a link in the menu to print a configuration item in the its zoom view of the agent interface.'} =
        'Zeigt im Menü der Detailansicht eines Configuration Items die Verknüpfung zum Drucken eines Configuration Items.';
    $Self->{Translation}->{'Shows a link in the menu to zoom into a configuration item in the configuration item overview of the agent interface.'} =
        'Zeigt eine Verknüpfung im Menü der Ansicht "Configuration Item-Übersicht", um zur Detailansicht des Configuration Items zu gelangen.';
    $Self->{Translation}->{'Shows the config item history (reverse ordered) in the agent interface.'} =
        'Zeigt die Configuration Item-Historie (umgekehrte Reihenfolge) im Agenten-Interface an.';
    $Self->{Translation}->{'The default category which is shown, if none is selected.'} = 'Die Standardkategorie, die angezeigt wird, wenn keine Kategorie ausgewählt ist.';
    $Self->{Translation}->{'The identifier for a configuration item, e.g. ConfigItem#, MyConfigItem#. The default is ConfigItem#.'} =
        'Der Identifikator für ein Configuration Item, bspw. "ConfigItem#" , "MeinConfigItem#". Der Standard ist "ConfigItem#".';
    $Self->{Translation}->{'Triggers ConfigItemFetch invoker automatically.'} = 'Löst automatisch den Aufruf von ConfigItemFetch aus.';
    $Self->{Translation}->{'Version String Expression'} = 'Version String-Ausdruck';
    $Self->{Translation}->{'Version String Module'} = 'Version String-Modul';
    $Self->{Translation}->{'Version Trigger'} = 'Version Auslöser';
    $Self->{Translation}->{'Whether the execution of ConfigItemACL can be avoided by checking cached field dependencies. This can improve loading times of formulars, but has to be disabled, if ACLModules are to be used for ITSMConfigItem- and Form-ReturnTypes.'} =
        'Ob die Ausführung von ConfigItemACL durch Überprüfung von zwischengespeicherten Feldabhängigkeiten vermieden werden kann. Dies kann die Ladezeiten von Formularen verbessern, muss aber deaktiviert werden, wenn ACLModule für ITSMConfigItem- und Form-ReturnTypes verwendet werden sollen.';
    $Self->{Translation}->{'Which general information is shown in the header.'} = 'Die allgemeinen Informationen werden in der Kopfzeile angezeigt.';
    $Self->{Translation}->{'With this option it´s possible to fill automaticly a CI field, depending on the count of linked CI´s with the existing type DependsOn.'} =
        'Mit dieser Option ist es möglich, ein CI-Feld automatisch zu füllen, abhängig von der Anzahl der verknüpften CIs mit dem bestehenden Typ DependsOn.';
    $Self->{Translation}->{'With this option it´s possible to fill automaticly a CI field, depending on the count of linked CI´s.'} =
        'Mit dieser Option ist es möglich, ein CI-Feld automatisch zu füllen, abhängig von der Anzahl der verknüpften CIs.';
    $Self->{Translation}->{'With this option it´s possible to fill automaticly a CI field, depending on the count of linked CI´s. The setting CounterClassName include the name of the class and CounterFieldName is used to store the count of used licence.'} =
        'Mit dieser Option ist es möglich, ein CI-Feld automatisch zu füllen, abhängig von der Anzahl der verknüpften CI\'s. Die Einstellung CounterClassName enthält den Namen der Klasse und CounterFieldName wird verwendet, um die Anzahl der verwendeten Lizenzen zu speichern.';
    $Self->{Translation}->{'class'} = 'Klasse';
    $Self->{Translation}->{'global'} = 'Global';
    $Self->{Translation}->{'postproductive'} = 'Post-produktiv';
    $Self->{Translation}->{'preproductive'} = 'Pre-produktiv';
    $Self->{Translation}->{'productive'} = 'Produktiv';

# Rother OSS 20250304
    $Self->{Translation}->{'Infrastructure'} = 'Infrastruktur';
    $Self->{Translation}->{'Contract'} = 'Vertrag';
    $Self->{Translation}->{'Workplace'} = 'Arbeitsplatz';
    $Self->{Translation}->{'Network Infrastructure'} = 'Netzwerk Infrastruktur';
    $Self->{Translation}->{'Device (unidentified)'} = 'Geräte (unident.)';
    $Self->{Translation}->{'Building'} = 'Gebäude';
    $Self->{Translation}->{'Certificate'} = 'Zertifikat';
    $Self->{Translation}->{'Country'} = 'Land';
    $Self->{Translation}->{'Database'} = 'Datenbank';
    $Self->{Translation}->{'Files'} = 'Dateien';
    $Self->{Translation}->{'License'} = 'Lizenz';
    $Self->{Translation}->{'Mobile Device'} = 'Mobiles Gerät';
    $Self->{Translation}->{'Operating System'} = 'Betriebssystem';
    $Self->{Translation}->{'Other Accessories'} = 'Sonstiges Zubehör';
    $Self->{Translation}->{'Phone'} = 'Telefon';
    $Self->{Translation}->{'Printer'} = 'Drucker';
    $Self->{Translation}->{'Projector'} = 'Beamer';
    $Self->{Translation}->{'Room'} = 'Raum';
    $Self->{Translation}->{'Subsidiary'} = 'Niederlassung';
    $Self->{Translation}->{'Client (virtual)'} = 'Client (virtuell)';
    $Self->{Translation}->{'Server (virtual)'} = 'Server (virtuell)';
    $Self->{Translation}->{'WLAN access point'} = 'WLAN Access Point';
    $Self->{Translation}->{'UPS'} = 'USV';
    $Self->{Translation}->{'Display'} = 'Monitor';
    $Self->{Translation}->{'19-inch Rack'} = '19-Zoll-Rack';
    $Self->{Translation}->{'21-inch Rack'} = '21-Zoll-Rack';
    $Self->{Translation}->{'23-inch Rack'} = '23-Zoll-Rack';
    $Self->{Translation}->{'23.6 inches (600 mm)'} = '23,6 Zoll (600 mm)';
    $Self->{Translation}->{'31.5 inches (800 mm)'} = '31,5 Zoll (800 mm)';
    $Self->{Translation}->{'35.4 inches (900 mm)'} = '35,4 Zoll (900 mm)';
    $Self->{Translation}->{'39.4 inches (1000 mm)'} = '39,4 Zoll (1000 mm)';
    $Self->{Translation}->{'43.3 inches (1100 mm)'} = '43,3 Zoll (1100 mm)';
    $Self->{Translation}->{'47.2 inches (1200 mm)'} = '47,2 Zoll (1200 mm)';
    $Self->{Translation}->{'Accounting'} = 'Buchhaltung';
    $Self->{Translation}->{'Accounting Information'} = 'Buchhaltungsinformationen';
    $Self->{Translation}->{'Active'} = 'Aktiv';
    $Self->{Translation}->{'Address Allocation'} = 'Adresszuweisung';
    $Self->{Translation}->{'Analog Phone'} = 'Analogtelefon';
    $Self->{Translation}->{'Appliance Type'} = 'Appliance-Typ';
    $Self->{Translation}->{'Backlinks'} = 'Verlinkt von';
    $Self->{Translation}->{'Battery Capacity (Ah)'} = 'Batteriekapazität (Ah)';
    $Self->{Translation}->{'Battery Type'} = 'Batterietyp';
    $Self->{Translation}->{'Bus Interface'} = 'Bus-Schnittstelle';
    $Self->{Translation}->{'Capacity (GB)'} = 'Kapazität (GB)';
    $Self->{Translation}->{'Capacity per graphics card'} = 'Kapazität pro Grafikkarte';
    $Self->{Translation}->{'Card Number'} = 'Kartennummer';
    $Self->{Translation}->{'Card Reader'} = 'Kartenleser';
    $Self->{Translation}->{'Card Type'} = 'Kartentyp';
    $Self->{Translation}->{'Client category'} = 'Client-Kategorie';
    $Self->{Translation}->{'Client Certificates'} = 'Client-Zertifikate';
    $Self->{Translation}->{'Client Software'} = 'Client-Software';
    $Self->{Translation}->{'Clockrate'} = 'Taktfrequenz';
    $Self->{Translation}->{'Clockrate'} = 'Taktrate';
    $Self->{Translation}->{'Clockspeed'} = 'Taktfrequenz';
    $Self->{Translation}->{'Code Signing Certificates'} = 'Code-Signing-Zertifikate';
    $Self->{Translation}->{'Conference Phone'} = 'Konferenztelefon';
    $Self->{Translation}->{'Consulting Agreement'} = 'Beratungsvertrag';
    $Self->{Translation}->{'Contact'} = 'Kontakt';
    $Self->{Translation}->{'Contact Distributor'} = 'Kontakt Händler';
    $Self->{Translation}->{'Container Management'} = 'Container-Verwaltung';
    $Self->{Translation}->{'Contract period from'} = 'Vertragslaufzeit von';
    $Self->{Translation}->{'Contract period until'} = 'Vertragslaufzeit bis';
    $Self->{Translation}->{'Contract Type'} = 'Vertragstyp';
    $Self->{Translation}->{'Cordless Phone (DECT Phone)'} = 'Kabelloses Telefon (DECT-Telefon)';
    $Self->{Translation}->{'Cost unit'} = 'Kostenstelle';
    $Self->{Translation}->{'Count of licenses'} = 'Anzahl der Lizenzen';
    $Self->{Translation}->{'CPU Class'} = 'CPU-Klasse';
    $Self->{Translation}->{'Creation Date'} = 'Erstellungsdatum';
    $Self->{Translation}->{'Custom Rack'} = 'Benutzerdefiniertes Rack';
    $Self->{Translation}->{'Customer'} = 'Kunde';
    $Self->{Translation}->{'Date of Invoice'} = 'Rechnungsdatum';
    $Self->{Translation}->{'Date of Order'} = 'Bestelldatum';
    $Self->{Translation}->{'Date of release'} = 'Release-Datum';
    $Self->{Translation}->{'Date of Warranty'} = 'Garantiedatum';
    $Self->{Translation}->{'DHCP Reserved'} = 'DHCP reserviert';
    $Self->{Translation}->{'Document Signing Certificates'} = 'Document-Signing-Zertifikate';
    $Self->{Translation}->{'Email Certificates (S/MIME Certificates)'} = 'E-Mail-Zertifikate (S/MIME-Zertifikate)';
    $Self->{Translation}->{'Employment Contract'} = 'Arbeitsvertrag';
    $Self->{Translation}->{'End IP Address'} = 'End-IP-Adresse';
    $Self->{Translation}->{'End of support'} = 'Support-Ende';
    $Self->{Translation}->{'ETSI Rack'} = 'ETSI-Rack';
    $Self->{Translation}->{'Expiry Date'} = 'Ablaufdatum';
    $Self->{Translation}->{'External Hard Drive'} = 'Externer Festplattenspeicher';
    $Self->{Translation}->{'Flywheel Energy Storage'} = 'Schwungrad-Energiespeicher';
    $Self->{Translation}->{'Form Factor'} = 'Bauform';
    $Self->{Translation}->{'Form Factor'} = 'Formfaktor';
    $Self->{Translation}->{'FQDN'} = 'FQDN';
    $Self->{Translation}->{'Franchise Agreement'} = 'Franchising-Vertrag';
    $Self->{Translation}->{'Graphics Cards'} = 'Grafikkarten';
    $Self->{Translation}->{'Graphics card'} = 'Grafikkarte';
    $Self->{Translation}->{'General Information'} = 'Allgemeine Informationen';
    $Self->{Translation}->{'Hardware Weight'} = 'Hardware-Gewicht';
    $Self->{Translation}->{'Hardware Model'} = 'Hardware-Modell';
    $Self->{Translation}->{'Inventory Number'} = 'Inventarnummer';
    $Self->{Translation}->{'Inverstment costs'} = 'Investitionskosten';
    $Self->{Translation}->{'Invoice Number'} = 'Rechnungsnummer';
    $Self->{Translation}->{'IP Address'} = 'IP-Adresse';
    $Self->{Translation}->{'IP Network'} = 'IP-Netzwerk';
    $Self->{Translation}->{'IP Protocol'} = 'IP-Protokoll';
    $Self->{Translation}->{'Keyboard'} = 'Tastatur';
    $Self->{Translation}->{'Landline Phone'} = 'Festnetztelefon';
    $Self->{Translation}->{'Latitude'} = 'Breitengrad';
    $Self->{Translation}->{'Lease Agreement'} = 'Mietvertrag';
    $Self->{Translation}->{'License Agreement'} = 'Lizenzvereinbarung';
    $Self->{Translation}->{'License Count'} = 'Lizenzanzahl';
    $Self->{Translation}->{'License Key'} = 'Lizenzschlüssel';
    $Self->{Translation}->{'License period from'} = 'Lizenzlaufzeit von';
    $Self->{Translation}->{'License period until'} = 'Lizenzlaufzeit bis';
    $Self->{Translation}->{'License Type'} = 'Lizenztyp';
    $Self->{Translation}->{'Lithium Iron Phosphate (LiFePO4) Battery'} = 'Lithium-Eisen-Phosphat-Akkumulator (LiFePO4)';
    $Self->{Translation}->{'Lithium-Ion (Li-ion) Battery'} = 'Lithium-Ionen-Akkumulator (Li-ion)';
    $Self->{Translation}->{'Loan Agreement'} = 'Darlehensvertrag';
    $Self->{Translation}->{'Located in'} = 'Gelegen in';
    $Self->{Translation}->{'Longitude'} = 'Längengrad';
    $Self->{Translation}->{'MAC Address'} = 'MAC-Adresse';
    $Self->{Translation}->{'Manufacturer'} = 'Hersteller';
    $Self->{Translation}->{'Maximum Load Capacity (W)'} = 'Belastungskapazität (max.) (W)';
    $Self->{Translation}->{'Memory'} = 'Speicher';
    $Self->{Translation}->{'Memory Type'} = 'Speichertyp';
    $Self->{Translation}->{'Mini-Rack'} = 'Mini-Rack';
    $Self->{Translation}->{'Mobile Number'} = 'Mobilfunknummer';
    $Self->{Translation}->{'Mobile/Embedded'} = 'Mobil/Eingebettet';
    $Self->{Translation}->{'Model Description'} = 'Modellbeschreibung';
    $Self->{Translation}->{'Model'} = 'Modell';
    $Self->{Translation}->{'Monitor Resolution'} = 'Monitorauflösung';
    $Self->{Translation}->{'Monitor Size'} = 'Monitorgröße';
    $Self->{Translation}->{'Mouse'} = 'Maus';
    $Self->{Translation}->{'Network'} = 'Netzwerk';
    $Self->{Translation}->{'Network Info'} = 'Netzwerk-Informationen';
    $Self->{Translation}->{'Network Information'} = 'Netzwerkinformationen';
    $Self->{Translation}->{'Network Layer'} = 'Netzwerkschicht';
    $Self->{Translation}->{'Nickel-Cadmium (NiCd) Battery'} = 'Nickel-Cadmium-Akkumulator (NiCd)';
    $Self->{Translation}->{'Nickel-Metal Hydride (NiMH) Battery'} = 'Nickel-Metallhydrid-Akkumulator (NiMH)';
    $Self->{Translation}->{'Non-Disclosure Agreement (NDA)'} = 'Geheimhaltungsvereinbarung (NDA)';
    $Self->{Translation}->{'Number of CPUs'} = 'Anzahl der CPUs';
    $Self->{Translation}->{'Number of graphics cards'} = 'Anzahl der Grafikkarten';
    $Self->{Translation}->{'Number of RAM modules'} = 'Anzahl der RAM-Module';
    $Self->{Translation}->{'Operating costs'} = 'Betriebskosten';
    $Self->{Translation}->{'Order Number'} = 'Bestellnummer';
    $Self->{Translation}->{'Other'} = 'Andere';
    $Self->{Translation}->{'Outputs'} = 'Ausgänge';
    $Self->{Translation}->{'Partition Capacity'} = 'Partition-Kapazität';
    $Self->{Translation}->{'Partition Free Capacity'} = 'Partition freie Kapazität';
    $Self->{Translation}->{'Partition Mount Point'} = 'Partition-Mount-Punkt';
    $Self->{Translation}->{'Partition Name'} = 'Partitionsname';
    $Self->{Translation}->{'Partition Used Capacity'} = 'Partition Verwendete Kapazität';
    $Self->{Translation}->{'Partnership Agreement'} = 'Gesellschaftsvertrag';
    $Self->{Translation}->{'Perpetual licenses'} = 'Unbefristete Lizenzen';
    $Self->{Translation}->{'Phone Number'} = 'Telefonnummer';
    $Self->{Translation}->{'Phone Type'} = 'Telefontyp';
    $Self->{Translation}->{'Physical Cores'} = 'Physische Kerne';
    $Self->{Translation}->{'Primary'} = 'Primär';
    $Self->{Translation}->{'Purchased at'} = 'Erworben bei';
    $Self->{Translation}->{'Rack Depth'} = 'Rack-Tiefe';
    $Self->{Translation}->{'Rack Units (U)'} = 'Rack-Einheiten (U)';
    $Self->{Translation}->{'Sales Contract'} = 'Kaufvertrag';
    $Self->{Translation}->{'Satellite Phone'} = 'Satellitentelefon';
    $Self->{Translation}->{'Sealed Lead-Acid (SLA) Battery'} = 'Gebundener Blei-Säure-Akkumulator (SLA)';
    $Self->{Translation}->{'Seat licenses'} = 'Sitzplatzlizenzen';
    $Self->{Translation}->{'Serialnumber'} = 'Seriennummer';
    $Self->{Translation}->{'Server Software'} = 'Server-Software';
    $Self->{Translation}->{'Service Agreement'} = 'Dienstleistungsvertrag';
    $Self->{Translation}->{'Service Tag'} = 'Service-Tag';
    $Self->{Translation}->{'SIM Card'} = 'SIM-Karte';
    $Self->{Translation}->{'Socket Type'} = 'Sockel-Typ';
    $Self->{Translation}->{'Speakers'} = 'Lautsprecher';
    $Self->{Translation}->{'SSL/TLS Certificates'} = 'SSL/TLS-Zertifikate';
    $Self->{Translation}->{'Start IP Address'} = 'Start-IP-Adresse';
    $Self->{Translation}->{'Static'} = 'Statisch';
    $Self->{Translation}->{'Storage Capacity'} = 'Speicherkapazität';
    $Self->{Translation}->{'Storage Manufacturer'} = 'Speicherhersteller';
    $Self->{Translation}->{'Storage Partition'} = 'Speicherpartition';
    $Self->{Translation}->{'Storage SerialNumber'} = 'Speicher-Seriennummer';
    $Self->{Translation}->{'Storage Type'} = 'Speichertyp';
    $Self->{Translation}->{'Subscription-based licenses'} = 'Abonnement-basierte Lizenzen';
    $Self->{Translation}->{'Summary'} = 'Zusammenfassung';
    $Self->{Translation}->{'Target object port'} = 'Zielobjekt-Port';
    $Self->{Translation}->{'Target Object'} = 'Zielobjekt';
    $Self->{Translation}->{'Total Graphics card RAM (GB)'} = 'Grafikkarte RAM insgesamt (GB)';
    $Self->{Translation}->{'Total RAM (GB)'} = 'Gesamt RAM (GB)';
    $Self->{Translation}->{'Touchscreen Monitor'} = 'Touchscreen-Monitor';
    $Self->{Translation}->{'Type'} = 'Typ';
    $Self->{Translation}->{'VoIP Phone'} = 'VoIP-Telefon';
    $Self->{Translation}->{'Volume licenses'} = 'Volumenlizenzen';
    $Self->{Translation}->{'Deployment state restrictions for the config item'} = 'Verwendungsstatus-Einschränkungen für das Config Item';
    $Self->{Translation}->{'Select one or more deployment states to restrict selectable config items'} = 'Einen oder mehrere Verwendungsstatus auswählen um auswählbare Config Items einzuschränken';

    # EO 20250304    

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

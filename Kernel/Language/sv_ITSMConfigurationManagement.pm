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

package Kernel::Language::sv_ITSMConfigurationManagement;

use strict;
use warnings;
use utf8;

sub Data {
    my $Self = shift;

    # Template: AdminITSMConfigItem
    $Self->{Translation}->{'Config Item Management'} = 'Hantering av konfigurationsenheter';
    $Self->{Translation}->{'Change class definition'} = 'Ändra klassdefinition';
    $Self->{Translation}->{'Change role definition'} = 'Ändra rolldefinition';
    $Self->{Translation}->{'Ready2Import Class Bundles'} = 'Ready2Import-klassbuntar';
    $Self->{Translation}->{'Here you can import Ready2Import class bundles showcasing our most usual config items. Please note that some additional configuration may be required.'} =
        'Här kan du importera Ready2Import-klassbuntar som visar våra vanligaste konfigurationsobjekt. Observera att viss ytterligare konfiguration kan krävas.';
    $Self->{Translation}->{'Update existing entities'} = 'Uppdatera befintliga enheter';
    $Self->{Translation}->{'Import Ready2Adopt class bundles'} = 'Importera Ready2Adopt-klassbuntar';
    $Self->{Translation}->{'Config Item Class'} = 'Klass för konfigurationsobjekt';
    $Self->{Translation}->{'Config Item Role'} = 'Konfig Artikel Roll';

    # Template: AgentITSMConfigItemAdd
    $Self->{Translation}->{'Config Item'} = 'Konfigurationsenhet';
    $Self->{Translation}->{'Filter for Classes'} = 'Filtrera klasser';
    $Self->{Translation}->{'Select a Class from the list to create a new Config Item.'} = 'Välj en klass från listan för att skapa en ny konfigurationsenhet';
    $Self->{Translation}->{'Class'} = 'Klass';

    # Template: AgentITSMConfigItemBulk
    $Self->{Translation}->{'ITSM ConfigItem Bulk Action'} = 'ITSM ConfigItem Massåtgärd';
    $Self->{Translation}->{'Deployment state'} = 'Driftläge';
    $Self->{Translation}->{'Incident state'} = 'Incidentläge';
    $Self->{Translation}->{'Link to another'} = 'Länka till annan';
    $Self->{Translation}->{'Invalid Configuration Item number!'} = 'Ogiltigt nummer på konfigurationsobjektet!';
    $Self->{Translation}->{'The number of another Configuration Item to link with.'} = 'Numret på ett annat Configuration Item att länka till.';

    # Template: AgentITSMConfigItemDelete
    $Self->{Translation}->{'Do you really want to delete this config item?'} = 'Vill du verkligen ta bort det här konfigurationsobjektet?';

    # Template: AgentITSMConfigItemEdit
    $Self->{Translation}->{'The name of this config item'} = 'Namnet på denna konfigurationsenhet';
    $Self->{Translation}->{'Name is already in use by the ConfigItems with the following Number(s): %s'} =
        'Namnet används redan i konfigurationsenheter med förljande nummer: %s';
    $Self->{Translation}->{'Version Number'} = 'Versionsnummer';
    $Self->{Translation}->{'Version number of this config item'} = 'Versionsnummer för detta konfigurationsobjekt';
    $Self->{Translation}->{'Version Number is already in use by the ConfigItems with the following Number(s): %s'} =
        'Versionsnumret används redan av ConfigItems med följande nummer: %s';
    $Self->{Translation}->{'Deployment State'} = 'Driftläge';
    $Self->{Translation}->{'Incident State'} = 'Incidentläge';

    # Template: AgentITSMConfigItemHistory
    $Self->{Translation}->{'History of Config Item: %s'} = 'Historik för konfigureringsobjekt: %s';
    $Self->{Translation}->{'History Content'} = 'Historikinnehåll';
    $Self->{Translation}->{'Createtime'} = 'Tidpunkt för skapande';
    $Self->{Translation}->{'Zoom view'} = 'Fokusvy';

    # Template: AgentITSMConfigItemOverviewNavBar
    $Self->{Translation}->{'Config Items per page'} = 'Konfigurationsenheter per sida';

    # Template: AgentITSMConfigItemOverviewSmall
    $Self->{Translation}->{'No config item data found.'} = 'Inga data för konfigurationsobjekt hittades.';
    $Self->{Translation}->{'Select this config item'} = 'Välj detta konfigurationsobjekt';

    # Template: AgentITSMConfigItemSearch
    $Self->{Translation}->{'Run Search'} = 'Utför sökning';
    $Self->{Translation}->{'Also search in previous versions?'} = 'Sök även i tidigare versioner?';

    # Template: AgentITSMConfigItemTreeView
    $Self->{Translation}->{'TreeView for ConfigItem'} = 'TreeView för ConfigItem';
    $Self->{Translation}->{'Depth Level'} = 'Djupnivå';
    $Self->{Translation}->{'Zoom In/Out'} = 'Zooma in/ut';
    $Self->{Translation}->{'Max links level reached for ConfigItem!'} = 'Max länknivå uppnådd för ConfigItem!';

    # Template: AgentITSMConfigItemZoom
    $Self->{Translation}->{'Configuration Item'} = 'Konfigurationsenhet';
    $Self->{Translation}->{'Configuration Item Information'} = 'Information om konfigurationsenhet';
    $Self->{Translation}->{'Current Deployment State'} = 'Nuvarande driftläge';
    $Self->{Translation}->{'Current Incident State'} = 'Nuvarande incidentläge';
    $Self->{Translation}->{'Last changed'} = 'Senast ändrad';
    $Self->{Translation}->{'Last changed by'} = 'Senast ändrad av';

    # Template: CustomerITSMConfigItem
    $Self->{Translation}->{'Your ConfigItems'} = 'Dina ConfigItems';

    # Template: CustomerITSMConfigItemSearch
    $Self->{Translation}->{'ConfigItem Search'} = 'ConfigItem Sök';

    # Template: AdminACL
    $Self->{Translation}->{'Object Type'} = 'Objekttyp';

    # JS Template: ClassImportConfirm
    $Self->{Translation}->{'The following classes will be imported'} = 'Följande klasser kommer att importeras';
    $Self->{Translation}->{'The following roles will be imported'} = 'Följande roller kommer att importeras';
    $Self->{Translation}->{'Note that also corresponding dynamic fields and GeneralCatalog classes will be created and there is no automatic removal.'} =
        'Observera att även motsvarande dynamiska fält och GeneralCatalog-klasser kommer att skapas och att det inte sker någon automatisk borttagning.';
    $Self->{Translation}->{'Do you want to proceed?'} = 'Vill du fortsätta?';

    # Perl Module: Kernel/Modules/AdminITSMConfigItem.pm
    $Self->{Translation}->{'Need ExampleClasses!'} = 'Behöver exempelklasser!';
    $Self->{Translation}->{'Definition is no valid YAML hash.'} = 'Definitionen är ingen giltig YAML-hash.';

    # Perl Module: Kernel/Modules/AgentITSMConfigItem.pm
    $Self->{Translation}->{'Overview: ITSM ConfigItem'} = 'Översikt: ITSM KonfigItem';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemBulk.pm
    $Self->{Translation}->{'No ConfigItemID is given!'} = 'Inget ConfigItemID anges!';
    $Self->{Translation}->{'You need at least one selected Configuration Item!'} = 'Du behöver minst ett valt Configuration Item!';
    $Self->{Translation}->{'You don\'t have write access to this configuration item: %s.'} =
        'Du har inte skrivbehörighet till det här konfigurationsobjektet: %s.';
    $Self->{Translation}->{'No definition was defined for class %s!'} = 'Ingen definition har definierats för klassen %s!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemDelete.pm
    $Self->{Translation}->{'Config item "%s" not found in database!'} = 'Konfigobjektet "%s" hittades inte i databasen!';
    $Self->{Translation}->{'Was not able to delete the configitem ID %s!'} = 'Det gick inte att ta bort konfigurationsobjektet ID %s!';
    $Self->{Translation}->{'No version found for ConfigItemID %s!'} = 'Ingen version hittades för ConfigItemID %s!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemEdit.pm
    $Self->{Translation}->{'No ConfigItemID, DuplicateID or ClassID is given!'} = 'Inget ConfigItemID, DuplicateID eller ClassID anges!';
    $Self->{Translation}->{'No access is given!'} = 'Ingen åtkomst ges!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemHistory.pm
    $Self->{Translation}->{'Can\'t show history, no ConfigItemID is given!'} = 'Kan inte visa historik, inget ConfigItemID anges!';
    $Self->{Translation}->{'Can\'t show history, no access rights given!'} = 'Kan inte visa historik, inga åtkomsträttigheter ges!';
    $Self->{Translation}->{'New ConfigItem (ID=%s)'} = 'Ny konfigurationspost (ID=%s)';
    $Self->{Translation}->{'New version (ID=%s)'} = 'Ny version (ID=%s)';
    $Self->{Translation}->{'Deployment state updated (new=%s, old=%s)'} = 'Deploymentstatus uppdaterad (ny=%s, gammal=%s)';
    $Self->{Translation}->{'Incident state updated (new=%s, old=%s)'} = 'Incidentstatus uppdaterad (ny=%s, gammal=%s)';
    $Self->{Translation}->{'ConfigItem (ID=%s) deleted'} = 'KonfigItem (ID=%s) borttagen';
    $Self->{Translation}->{'Link to %s (type=%s) added'} = 'Länk till %s (type=%s) tillagd';
    $Self->{Translation}->{'Link to %s (type=%s) deleted'} = 'Länk till %s (type=%s) borttagen';
    $Self->{Translation}->{'ConfigItem definition updated (ID=%s)'} = 'Uppdatering av ConfigItem-definitionen (ID=%s)';
    $Self->{Translation}->{'Name updated (new=%s, old=%s)'} = 'Namn uppdaterat (nytt=%s, gammalt=%s)';
    $Self->{Translation}->{'Attribute %s updated from "%s" to "%s"'} = 'Attribut %s uppdaterat från "%s" till "%s"';
    $Self->{Translation}->{'Version %s deleted'} = 'Version %s raderad';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemPrint.pm
    $Self->{Translation}->{'No ConfigItemID or VersionID is given!'} = 'Inget ConfigItemID eller VersionID har angetts!';
    $Self->{Translation}->{'Can\'t show config item, no access rights given!'} = 'Kan inte visa konfigurationsobjekt, inga åtkomsträttigheter ges!';
    $Self->{Translation}->{'ConfigItemID %s not found in database!'} = 'ConfigItemID %s hittades inte i databasen!';
    $Self->{Translation}->{'ConfigItem'} = 'Konfigurationsenhet';
    $Self->{Translation}->{'printed by %s at %s'} = 'utskriven av %s vid %s';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemSearch.pm
    $Self->{Translation}->{'Invalid ClassID!'} = 'Ogiltigt klass-ID!';
    $Self->{Translation}->{'No ClassID is given!'} = 'Inget klassID anges!';
    $Self->{Translation}->{'No access rights for this class given!'} = 'Inga åtkomsträttigheter för denna klass ges!';
    $Self->{Translation}->{'No Result!'} = 'Inget resultat!';
    $Self->{Translation}->{'Config Item Search Results'} = 'Sökresultat för konfigurerade objekt';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemZoom.pm
    $Self->{Translation}->{'Can\'t show item, no access rights for ConfigItem are given!'} =
        'Kan inte visa objektet, inga åtkomsträttigheter för ConfigItem har getts!';
    $Self->{Translation}->{'ConfigItem not found!'} = 'KonfigItem hittades inte!';
    $Self->{Translation}->{'No versions found!'} = 'Inga versioner hittades!';
    $Self->{Translation}->{'operational'} = 'Operativ';
    $Self->{Translation}->{'warning'} = 'varning';
    $Self->{Translation}->{'incident'} = 'Händelse';
    $Self->{Translation}->{'The deployment state of this config item'} = 'Driftläge för konfigurationsenhet';
    $Self->{Translation}->{'The incident state of this config item'} = 'Incidentläge för konfigurationsenhet';

    # Perl Module: Kernel/Modules/CustomerITSMConfigItemSearch.pm
    $Self->{Translation}->{'No permission'} = 'Saknar rättigheter!';
    $Self->{Translation}->{'Filter invalid!'} = 'Filter ogiltigt!';
    $Self->{Translation}->{'Search params invalid!'} = 'Sökparametrar ogiltiga!';

    # Perl Module: Kernel/Output/HTML/Dashboard/ITSMConfigItemGeneric.pm
    $Self->{Translation}->{'Shown config items'} = 'Visade konfigurationsobjekt';
    $Self->{Translation}->{'Deployment State Type'} = 'Driftlägestyper';
    $Self->{Translation}->{'Current Incident State Type'} = 'Nuvarande typ av incidentläge';

    # Perl Module: Kernel/Output/HTML/ITSMConfigItem/LayoutDate.pm
    $Self->{Translation}->{'Between'} = 'Mellan';

    # Perl Module: Kernel/System/DynamicField/Driver/ConfigItem.pm
    $Self->{Translation}->{'Class restrictions for the config item'} = 'Klassbegränsningar för konfigurationsobjektet';
    $Self->{Translation}->{'Select one or more classes to restrict selectable config items'} =
        'Välj en eller flera klasser för att begränsa valbara konfigurationsobjekt';
    $Self->{Translation}->{'Link type'} = 'Typ av länk';
    $Self->{Translation}->{'Select the link type.'} = 'Välj länktyp.';
    $Self->{Translation}->{'Forwards: Referencing (Source) -> Referenced (Target)'} = 'Framåt i tiden: Referencing (Source) -> Referenced (Target)';
    $Self->{Translation}->{'Backwards: Referenced (Source) -> Referencing (Target)'} = 'Bakåt i tiden: Refererad (Källa) -> Refererande (Mål)';
    $Self->{Translation}->{'Link Direction'} = 'Länkens riktning';
    $Self->{Translation}->{'The referencing object is the one containing this dynamic field, the referenced object is the one selected as value of the dynamic field.'} =
        'Det refererande objektet är det som innehåller det här dynamiska fältet, det refererade objektet är det som valts som värde för det dynamiska fältet.';
    $Self->{Translation}->{'Dynamic (ConfigItem)'} = 'Dynamisk (KonfigItem)';
    $Self->{Translation}->{'Static (Version)'} = 'Statisk (version)';
    $Self->{Translation}->{'Link Referencing Type'} = 'Typ av länkreferens';
    $Self->{Translation}->{'Whether this link applies to the ConfigItem or the static version of the referencing object. Current Incident State calculation only is performed on dynamic links.'} =
        'Om denna länk gäller för ConfigItem eller den statiska versionen av det objekt som refereras till. Beräkningen av Current Incident State utförs endast på dynamiska länkar.';
    $Self->{Translation}->{'Select the attribute which config items will be searched by'} = 'Välj det attribut som konfigurationsobjekten ska sökas efter';

    # Perl Module: Kernel/System/ITSMConfigItem/Definition.pm
    $Self->{Translation}->{'Base structure is not valid. Please provide a hash with data in YAML format.'} =
        'Basstrukturen är inte giltig. Ange en hash med data i YAML-format.';
    $Self->{Translation}->{'Starting the YAML string with \'---\' is required.'} = 'Det krävs att YAML-strängen inleds med "---".';

    # Perl Module: Kernel/System/ITSMConfigItem/Link.pm
    $Self->{Translation}->{'Could not purge the table configitem_link.'} = 'Det gick inte att rensa tabellen configitem_link.';
    $Self->{Translation}->{'No relevant dynamic fields were found'} = 'Inga relevanta dynamiska fält hittades';
    $Self->{Translation}->{'Could not insert into the table configitem_link'} = 'Det gick inte att infoga i tabellen configitem_link';
    $Self->{Translation}->{'Inserted 0 rows into the table configitem_link'} = 'Infogade 0 rader i tabellen configitem_link';

    # Perl Module: Kernel/System/ImportExport/ObjectBackend/ITSMConfigItem.pm
    $Self->{Translation}->{'Maximum number of one element'} = 'Max antal av ett element';
    $Self->{Translation}->{'Empty fields indicate that the current values are kept'} = 'Tomma fält anger att tidigare värden ska användas.';
    $Self->{Translation}->{'Skipped'} = 'Hoppade över';

    # Perl Module: Kernel/Modules/AdminDynamicField.pm
    $Self->{Translation}->{'Error synchronizing the definitions. Please check the log.'} = 'Fel vid synkronisering av definitionerna. Vänligen kontrollera loggen.';
    $Self->{Translation}->{'You have ITSMConfigItem definitions which are not synchronized. Please deploy your ITSMConfigItem dynamic field changes.'} =
        'Du har ITSMConfigItem-definitioner som inte är synkroniserade. Vänligen distribuera dina ITSMConfigItem dynamiska fältändringar.';

    # Database XML / SOPM Definition: ITSMConfigurationManagement.sopm
    $Self->{Translation}->{'Expired'} = 'Löpt ut';
    $Self->{Translation}->{'Maintenance'} = 'Underhåll';
    $Self->{Translation}->{'Pilot'} = 'Pilot';
    $Self->{Translation}->{'Planned'} = 'Planlagd';
    $Self->{Translation}->{'Repair'} = 'Reperation';
    $Self->{Translation}->{'Retired'} = 'Pensionerad';
    $Self->{Translation}->{'Review'} = 'Översyn';
    $Self->{Translation}->{'Test/QA'} = 'Test/QA';

    # JS File: ITSM.Admin.ITSMConfigItem
    $Self->{Translation}->{'Overview and Confirmation'} = 'Översikt och bekräftelse';
    $Self->{Translation}->{'Importing classes/roles and their related fields'} = 'Importera klasser/roller och deras relaterade fält';
    $Self->{Translation}->{'An error occurred during class import.'} = 'Ett fel inträffade under klassimporten.';

    # SysConfig
    $Self->{Translation}->{'0 - Hidden'} = '0 - Dold';
    $Self->{Translation}->{'1 - Shown'} = '1 - Visas';
    $Self->{Translation}->{'Allows extended search conditions in config item search of the agent interface. With this feature you can search e. g. config item name with this kind of conditions like "(*key1*&&*key2*)" or "(*key1*||*key2*)".'} =
        'Tillåter utökade sökvillkor vid sökning av konfigurationsobjekt i agentgränssnittet. Med den här funktionen kan du t.ex. söka efter konfigurationsobjektets namn med villkor av typen "(*key1*&&*key2*)" eller "(*key1*||*key2*)".';
    $Self->{Translation}->{'Allows extended search conditions in config item search of the customer interface. With this feature you can search e. g. config item name with this kind of conditions like "(*key1*&&*key2*)" or "(*key1*||*key2*)".'} =
        'Tillåter utökade sökvillkor vid sökning av konfigurationsobjekt i kundgränssnittet. Med den här funktionen kan du t.ex. söka efter konfigurationsobjektets namn med villkor av typen "(*key1*&&*key2*)" eller "(*key1*||*key2*)".';
    $Self->{Translation}->{'Assigned CIs'} = 'Tilldelade CI';
    $Self->{Translation}->{'At a specific time point create a ticket for config items, if the configured requirements are met. The time point is determined by the value of the field configured under "TimeCIKey" of the ConfigItem, and modified by "TimeModifier". If the latter can be either just a number, or a sign (+/-), a number, and an unit (d/h/m): "7" is equivalent to "+7d". The DynamicField "Ticket->DynamicField" will be used to mark created tickets - it has to exist. The flags \<OTOBO_CONFIGITEM_X\> where X can be NAME, NUMBER and DATE, will be substituted with the respective values in "Ticket->Text".'} =
        'Vid en viss tidpunkt skapa ett ärende för konfigurationsobjekt om de konfigurerade kraven är uppfyllda. Tidpunkten bestäms av värdet på det fält som konfigurerats under "TimeCIKey" i ConfigItem, och modifieras av "TimeModifier". Om den senare kan vara antingen bara ett tal eller ett tecken (+/-), ett tal och en enhet (d/h/m): "7" motsvarar "+7d". DynamicField "Ticket->DynamicField" kommer att användas för att markera skapade biljetter - den måste finnas. Flaggorna \<OTOBO_CONFIGITEM_X\> där X kan vara NAME, NUMBER och DATE, kommer att ersättas med respektive värden i "Ticket->Text".';
    $Self->{Translation}->{'CIs assigned to customer company'} = 'CI:s som tilldelats kundföretag';
    $Self->{Translation}->{'CIs assigned to customer user'} = 'CI:er som tilldelats kundanvändare';
    $Self->{Translation}->{'CMDB Settings'} = 'CMDB-inställningar';
    $Self->{Translation}->{'Check for a unique name only within the same ConfigItem class (\'class\') or globally (\'global\'), which means every existing ConfigItem is taken into account when looking for duplicates.'} =
        'Sök efter ett unikt namn endast inom samma ConfigItem-klass ("class") eller globalt ("global"), vilket innebär att varje befintligt ConfigItem tas med i beräkningen när man letar efter dubbletter.';
    $Self->{Translation}->{'Choose a module to enforce a naming scheme.'} = 'Välj en modul för att genomdriva ett namngivningsschema.';
    $Self->{Translation}->{'Choose a module to enforce a number scheme.'} = 'Välj en modul för att verkställa ett nummersystem.';
    $Self->{Translation}->{'Choose a module to enforce a version string scheme.'} = 'Välj en modul för att genomdriva ett system med versionssträngar.';
    $Self->{Translation}->{'Choose attributes to trigger the creation of a new version.'} = 'Välj attribut för att utlösa skapandet av en ny version.';
    $Self->{Translation}->{'Choose categories to assign to this config item class.'} = 'Välj kategorier som ska tilldelas denna klass av konfigurationsobjekt.';
    $Self->{Translation}->{'Column config item filters for ConfigItem Overview.'} = 'Kolumnfilter för ConfigItem-objekt för ConfigItem Overview.';
    $Self->{Translation}->{'Columns that can be filtered in the config item overview of the agent interface. Note: Only Config Item attributes and Dynamic Fields (DynamicField_NameX) are allowed.'} =
        'Kolumner som kan filtreras i översikten över konfigurationsobjekt i agentgränssnittet. Observera: Endast Config Item-attribut och dynamiska fält (DynamicField_NameX) är tillåtna.';
    $Self->{Translation}->{'Columns that can be filtered in the config item overview of the customer interface. Note: Only Config Item attributes and Dynamic Fields (DynamicField_NameX) are allowed.'} =
        'Kolumner som kan filtreras i översikten över konfigurationsobjekt i kundgränssnittet. Observera: Endast Config Item-attribut och dynamiska fält (DynamicField_NameX) är tillåtna.';
    $Self->{Translation}->{'Columns that can be filtered in the config item search result overview of the agent interface. Note: Only Config Item attributes and Dynamic Fields (DynamicField_NameX) are allowed.'} =
        'Kolumner som kan filtreras i sökresultatöversikten för konfigurationsobjekt i agentgränssnittet. Observera: Endast Config Item-attribut och dynamiska fält (DynamicField_NameX) är tillåtna.';
    $Self->{Translation}->{'Config Items'} = 'Konfigurationsenheter';
    $Self->{Translation}->{'Config item add.'} = 'Lägg till konfigureringsobjekt.';
    $Self->{Translation}->{'Config item edit.'} = 'Redigera konfigureringsobjekt.';
    $Self->{Translation}->{'Config item event module that count the licenses for OTOBOCILicenseCount feature.'} =
        'Konfigureringsobjekt för händelsemodul som räknar licenser för funktionen OTOBOCILicenseCount.';
    $Self->{Translation}->{'Config item event module that enables logging to history in the agent interface.'} =
        'Konfigureringsobjekt för händelsemodul som möjliggör loggning till historik i agentgränssnittet.';
    $Self->{Translation}->{'Config item event module that updates config items to their current definition.'} =
        'Händelsemodul för konfigurationsobjekt som uppdaterar konfigurationsobjekten till deras aktuella definition.';
    $Self->{Translation}->{'Config item event module that updates the table configitem_ĺink.'} =
        'Config item event-modul som uppdaterar tabellen configitem_ĺink.';
    $Self->{Translation}->{'Config item event module updates the current incident state.'} =
        'Config item event-modulen uppdaterar det aktuella incidenttillståndet.';
    $Self->{Translation}->{'Config item history.'} = 'Konfigurerar artikelhistorik.';
    $Self->{Translation}->{'Config item print.'} = 'Utskrift av konfigureringsobjekt.';
    $Self->{Translation}->{'Config item zoom.'} = 'Konfigurera zoom för objekt.';
    $Self->{Translation}->{'ConfigItem Tree View'} = 'KonfigItem trädvy';
    $Self->{Translation}->{'ConfigItem Version'} = 'KonfigItem Version';
    $Self->{Translation}->{'ConfigItems of the following classes will not be stored on the Elasticsearch server. To apply this to existing CIs, the CI migration has to be run via console, after changing this option.'} =
        'ConfigItems av följande klasser kommer inte att lagras på Elasticsearch-servern. Om du vill tillämpa detta på befintliga CI måste CI-migreringen köras via konsolen efter att du har ändrat detta alternativ.';
    $Self->{Translation}->{'ConfigItems with the following deployment states will not be stored on the Elasticsearch server. To apply this to existing CIs, the CI migration has to be run via console, after changing this option.'} =
        'ConfigItems med följande driftsättningsstatus kommer inte att lagras på Elasticsearch-servern. För att tillämpa detta på befintliga CI måste CI-migreringen köras via konsolen efter att detta alternativ har ändrats.';
    $Self->{Translation}->{'Configuration Item Limit'} = 'Begränsning konfigurationsenheter';
    $Self->{Translation}->{'Configuration Item limit per page.'} = 'Konfiguration Artikelgräns per sida.';
    $Self->{Translation}->{'Configuration Management Database.'} = 'Databas för konfigurationshantering.';
    $Self->{Translation}->{'Configuration item bulk module.'} = 'Konfigurationsobjekt bulkmodul.';
    $Self->{Translation}->{'Configuration item search backend router of the agent interface.'} =
        'Konfigurationsobjekt sök backend-router för agentgränssnittet.';
    $Self->{Translation}->{'Create and manage the definitions for Configuration Items.'} = 'Skapa och hantera definitioner för konfigurationsenheter';
    $Self->{Translation}->{'Creates Tickets for ConfigItems at specific time points.'} = 'Skapar biljetter för ConfigItems vid specifika tidpunkter.';
    $Self->{Translation}->{'Customers can see historic CI versions.'} = 'Kunderna kan se historiska CI-versioner.';
    $Self->{Translation}->{'Customers have the possibility to manually switch between historic CI versions.'} =
        'Kunderna har möjlighet att manuellt växla mellan historiska CI-versioner.';
    $Self->{Translation}->{'Default data to use on attribute for config item search screen. Example: "ITSMConfigItemCreateTimePointFormat=year;ITSMConfigItemCreateTimePointStart=Last;ITSMConfigItemCreateTimePoint=2;".'} =
        'Standarddata som ska användas på attributet för sökskärmen för konfigurationsobjekt. Exempel: "ITSMConfigItemCreateTimePointFormat=year;ITSMConfigItemCreateTimePointStart=Last;ITSMConfigItemCreateTimePoint=2;".';
    $Self->{Translation}->{'Default data to use on attribute for config item search screen. Example: "ITSMConfigItemCreateTimeStartYear=2010;ITSMConfigItemCreateTimeStartMonth=10;ITSMConfigItemCreateTimeStartDay=4;ITSMConfigItemCreateTimeStopYear=2010;ITSMConfigItemCreateTimeStopMonth=11;ITSMConfigItemCreateTimeStopDay=3;".'} =
        'Standarddata som ska användas på attribut för sökskärmen för konfigurationsobjekt. Exempel: "ITSMConfigItemCreateTimeStartYear=2010;ITSMConfigItemCreateTimeStartMonth=10;ITSMConfigItemCreateTimeStartDay=4;ITSMConfigItemCreateTimeStopYear=2010;ITSMConfigItemCreateTimeStopMonth=11;ITSMConfigItemCreateTimeStopDay=3;".';
    $Self->{Translation}->{'Define Actions where a settings button is available in the linked objects widget (LinkObject::ViewMode = "complex"). Please note that these Actions must have registered the following JS and CSS files: Core.AllocationList.css, Core.UI.AllocationList.js, Core.UI.Table.Sort.js, Core.Agent.TableFilters.js and Core.Agent.LinkObject.js.'} =
        'Definiera åtgärder där en inställningsknapp är tillgänglig i widgeten för länkade objekt (LinkObject::ViewMode = "complex"). Observera att dessa åtgärder måste ha registrerat följande JS- och CSS-filer: Core.AllocationList.css, Core.UI.AllocationList.js, Core.UI.Table.Sort.js, Core.Agent.TableFilters.js och Core.Agent.LinkObject.js.';
    $Self->{Translation}->{'Define a Template::Toolkit scheme for version strings. Only used if Version String Module is set to TemplateToolkit.'} =
        'Definiera ett Template::Toolkit-schema för versionssträngar. Används endast om Version String Module är inställd på TemplateToolkit.';
    $Self->{Translation}->{'Define a set of conditions under which a customer is allowed to see a config item. Conditions can optionally be restricted to certain customer groups. Name is the only mandatory attribute. If no other options are given, all config items will be visible under that category.'} =
        'Definiera en uppsättning villkor under vilka en kund får se ett konfigurationsobjekt. Villkoren kan eventuellt begränsas till vissa kundgrupper. Namn är det enda obligatoriska attributet. Om inga andra alternativ anges kommer alla konfigurationsobjekt att vara synliga under den kategorin.';
    $Self->{Translation}->{'Defines Required permissions to create ITSM configuration items using the Generic Interface.'} =
        'Definierar nödvändiga behörigheter för att skapa ITSM-konfigurationsobjekt med hjälp av det generiska gränssnittet.';
    $Self->{Translation}->{'Defines Required permissions to delete ITSM configuration items using the Generic Interface.'} =
        'Definierar nödvändiga behörigheter för att ta bort ITSM-konfigurationsobjekt med hjälp av det generiska gränssnittet.';
    $Self->{Translation}->{'Defines Required permissions to get ITSM configuration items using the Generic Interface.'} =
        'Definierar nödvändiga behörigheter för att hämta ITSM-konfigurationsobjekt med hjälp av det generiska gränssnittet.';
    $Self->{Translation}->{'Defines Required permissions to search ITSM configuration items using the Generic Interface.'} =
        'Definierar nödvändiga behörigheter för att söka ITSM-konfigurationsobjekt med hjälp av det generiska gränssnittet.';
    $Self->{Translation}->{'Defines Required permissions to update ITSM configuration items using the Generic Interface.'} =
        'Definierar nödvändiga behörigheter för att uppdatera ITSM-konfigurationsobjekt med hjälp av det generiska gränssnittet.';
    $Self->{Translation}->{'Defines an overview module to show the small view of a configuration item list.'} =
        'Definierar en översiktsmodul som visar den lilla vyn av en lista med konfigurationsobjekt.';
    $Self->{Translation}->{'Defines if the link type labels must be shown in the node connections.'} =
        'Definierar om länktypens etiketter måste visas i nodanslutningarna.';
    $Self->{Translation}->{'Defines regular expressions individually for each ConfigItem class to check the ConfigItem name and to show corresponding error messages.'} =
        'Definierar reguljära uttryck individuellt för varje ConfigItem-klass för att kontrollera ConfigItem-namnet och visa motsvarande felmeddelanden.';
    $Self->{Translation}->{'Defines the available columns of CIs in the config item overview depending on the CI class. Each entry must consist of a class name and an array of available fields for the corresponding class. Dynamic field entries have to honor the scheme DynamicField_FieldName.'} =
        'Definierar de tillgängliga kolumnerna för CI:er i konfigurationsobjektets översikt beroende på CI-klassen. Varje post måste bestå av ett klassnamn och en matris med tillgängliga fält för motsvarande klass. Dynamiska fältposter måste följa schemat DynamicField_FieldName.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of the agent interface.'} =
        'Definierar standardattributet för konfigurationsobjekt för sortering av konfigurationsobjekt i sökresultatet för konfigurationsobjekt i agentgränssnittet.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of the customer interface.'} =
        'Definierar standardattributet för konfigurationsobjekt för sortering av konfigurationsobjekt i sökresultatet för konfigurationsobjekt i kundgränssnittet.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of this operation.'} =
        'Definierar standardattributet för konfigurationsobjekt för sortering av konfigurationsobjekt i resultatet av sökningen efter konfigurationsobjekt i denna åtgärd.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the agent interface. Up: oldest on top. Down: latest on top.'} =
        'Definierar standardordningen för konfigurationsobjekt i sökresultatet för konfigurationsobjekt i agentgränssnittet. Upp: äldst på toppen. Ner: det senaste överst.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the customer interface. Up: oldest on top. Down: latest on top.'} =
        'Definierar standardordningen för konfigurationsobjekt i sökresultatet för konfigurationsobjekt i kundgränssnittet. Upp: äldst överst. Ner: den senaste överst.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the this operation. Up: oldest on top. Down: latest on top.'} =
        'Definierar standardordningen för konfigurationsobjekt i resultatet av sökningen efter konfigurationsobjekt i den här åtgärden. Upp: äldst överst. Ner: senaste överst.';
    $Self->{Translation}->{'Defines the default displayed columns of CIs in the config item overview depending on the CI class. Each entry must consist of a class name and an array of available fields for the corresponding class. Dynamic field entries have to honor the scheme DynamicField_FieldName.'} =
        'Definierar de kolumner som visas som standard för CI:er i konfigurationsobjektets översikt beroende på CI-klassen. Varje post måste bestå av ett klassnamn och en matris med tillgängliga fält för motsvarande klass. Dynamiska fältposter måste följa schemat DynamicField_FieldName.';
    $Self->{Translation}->{'Defines the default relations depth to be shown.'} = 'Definierar det standarddjup för relationer som ska visas.';
    $Self->{Translation}->{'Defines the default shown config item search attribute for config item search screen.'} =
        'Definierar standardattributet för sökning av konfigurationsobjekt som visas för skärmen för sökning av konfigurationsobjekt.';
    $Self->{Translation}->{'Defines the default shown config item search attribute for config item search screen. Example: "Key" must have the name of the Dynamic Field in this case \'X\', "Content" must have the value of the Dynamic Field depending on the Dynamic Field type,  Text: \'a text\', Dropdown: \'1\', Date/Time: \'Search_DynamicField_XTimeSlotStartYear=1974; Search_DynamicField_XTimeSlotStartMonth=01; Search_DynamicField_XTimeSlotStartDay=26; Search_DynamicField_XTimeSlotStartHour=00; Search_DynamicField_XTimeSlotStartMinute=00; Search_DynamicField_XTimeSlotStartSecond=00; Search_DynamicField_XTimeSlotStopYear=2013; Search_DynamicField_XTimeSlotStopMonth=01; Search_DynamicField_XTimeSlotStopDay=26; Search_DynamicField_XTimeSlotStopHour=23; Search_DynamicField_XTimeSlotStopMinute=59; Search_DynamicField_XTimeSlotStopSecond=59;\' and or \'Search_DynamicField_XTimePointFormat=week; Search_DynamicField_XTimePointStart=Before; Search_DynamicField_XTimePointValue=7\';.'} =
        'Definierar standardattributet för sökning av konfigurationsobjekt som visas på skärmen för sökning av konfigurationsobjekt. Exempel: "Key" måste ha namnet på det dynamiska fältet i det här fallet "X", "Content" måste ha värdet på det dynamiska fältet beroende på typen av dynamiskt fält, Text: "a text", Dropdown: "1", Date/Time: \'Search_DynamicField_XTimeSlotStartYear=1974; Search_DynamicField_XTimeSlotStartMonth=01; Search_DynamicField_XTimeSlotStartDay=26; Search_DynamicField_XTimeSlotStartHour=00; Search_DynamicField_XTimeSlotStartMinute=00; Search_DynamicField_XTimeSlotStartSecond=00; Search_DynamicField_XTimeSlotStopYear=2013; Search_DynamicField_XTimeSlotStopMonth=01; Search_DynamicField_XTimeSlotStopDay=26; Search_DynamicField_XTimeSlotStopHour=23; Search_DynamicField_XTimeSlotStopMinute=59; Search_DynamicField_XTimeSlotStopSecond=59;\' och eller \'Search_DynamicField_XTimePointFormat=week; Search_DynamicField_XTimePointStart=Before; Search_DynamicField_XTimePointValue=7\';.';
    $Self->{Translation}->{'Defines the default subobject of the class \'ITSMConfigItem\'.'} =
        'Definierar standardunderobjektet för klassen \'ITSMConfigItem\'.';
    $Self->{Translation}->{'Defines the initial height for the rich text editor component in pixels.'} =
        '';
    $Self->{Translation}->{'Defines the number of rows for the CI definition editor in the admin interface.'} =
        'Anger antal rader för KE-editorn i admingränssnittet.';
    $Self->{Translation}->{'Defines the order of incident states from high (e.g. cricital) to low (e.g. functional).'} =
        'Definierar ordningsföljden för incidenttillstånd från hög (t.ex. cricital) till låg (t.ex. functional).';
    $Self->{Translation}->{'Defines the relevant deployment states where linked tickets can affect the status of a CI.'} =
        'Definierar de relevanta driftsättningsstatusar där länkade ärenden kan påverka statusen för ett CI.';
    $Self->{Translation}->{'Defines the search limit for the AgentITSMConfigItem screen.'} =
        'Definierar sökgränsen för skärmen AgentITSMConfigItem.';
    $Self->{Translation}->{'Defines the search limit for the AgentITSMConfigItemSearch screen.'} =
        'Definierar sökgränsen för skärmen AgentITSMConfigItemSearch.';
    $Self->{Translation}->{'Defines the search limit for the CustomerITSMConfigItem screen.'} =
        'Definierar sökgränsen för skärmen CustomerITSMConfigItem.';
    $Self->{Translation}->{'Defines the search limit for the CustomerITSMConfigItemSearch screen.'} =
        'Definierar sökgränsen för skärmen CustomerITSMConfigItemSearch.';
    $Self->{Translation}->{'Defines the shown columns of CIs in the link table complex view for all CI classes. If there is no entry, then the default columns are shown.'} =
        'Definierar de kolumner som visas för CI i den komplexa vyn för länktabellen för alla CI-klasser. Om det inte finns någon post visas standardkolumnerna.';
    $Self->{Translation}->{'Defines the shown columns of CIs in the link table complex view, depending on the CI class. Each entry must be prefixed with the class name and double colons (i.e. Computer::). There are a few CI-Attributes that common to all CIs (example for the class Computer: Computer::Name, Computer::CurDeplState, Computer::CreateTime). To show individual CI-Attributes as defined in the CI-Definition, the following scheme must be used (example for the class Computer): Computer::HardDisk::1, Computer::HardDisk::1::Capacity::1, Computer::HardDisk::2, Computer::HardDisk::2::Capacity::1. If there is no entry for a CI class, then the default columns are shown.'} =
        'Definierar de kolumner som visas för CI i den komplexa vyn för länktabellen, beroende på CI-klass. Varje post måste inledas med klassnamnet och dubbla kolon (t.ex. Computer::). Det finns ett fåtal CI-attribut som är gemensamma för alla CI (exempel för klassen Computer: Computer::Name, Computer::CurDeplState, Computer::CreateTime). För att visa enskilda CI-attribut som definieras i CI-definitionen måste följande schema användas (exempel för klassen Computer): Computer::HardDisk::1, Computer::HardDisk::1::Capacity::1, Computer::HardDisk::2, Computer::HardDisk::2::Capacity::1. Om det inte finns någon post för en CI-klass visas standardkolumnerna.';
    $Self->{Translation}->{'Defines which items are available for \'Action\' in third level of the ITSM Config Item ACL structure.'} =
        'Definierar vilka objekt som är tillgängliga för "Action" i den tredje nivån i ITSM Config Item ACL-strukturen.';
    $Self->{Translation}->{'Defines which items are available in first level of the ITSM Config Item ACL structure.'} =
        'Definierar vilka objekt som är tillgängliga i den första nivån i ITSM Config Item ACL-strukturen.';
    $Self->{Translation}->{'Defines which items are available in second level of the ITSM Config Item ACL structure.'} =
        'Definierar vilka objekt som är tillgängliga i den andra nivån i ITSM Config Item ACL-strukturen.';
    $Self->{Translation}->{'Defines which type of link (named from the ticket perspective) can affect the status of a linked CI.'} =
        'Definierar vilken typ av länk (namngiven ur ett ärendeperspektiv) som kan påverka statusen för ett länkat CI.';
    $Self->{Translation}->{'Defines which type of ticket can affect the status of a linked CI.'} =
        'Definierar vilken typ av ärende som kan påverka statusen för ett länkat CI.';
    $Self->{Translation}->{'Definition Update'} = 'Definition Uppdatering';
    $Self->{Translation}->{'Delete Configuration Item'} = 'Ta bort konfigurationsobjekt';
    $Self->{Translation}->{'DeplState'} = 'DeplState';
    $Self->{Translation}->{'Deployment State Color'} = 'Deployment State Färg';
    $Self->{Translation}->{'DeploymentState'} = 'DeploymentState';
    $Self->{Translation}->{'Duplicate'} = 'Duplicera';
    $Self->{Translation}->{'Dynamic field event module that marks config item definitions as out of sync, if containing dynamic fields change.'} =
        'Händelsemodul för dynamiska fält som markerar konfigurationsobjektdefinitioner som osynkroniserade om de innehåller dynamiska fält som ändras.';
    $Self->{Translation}->{'Dynamic fields shown in the additional ITSM field screen of the agent interface.'} =
        'Dynamiska fält som visas på skärmen för ytterligare ITSM-fält i agentgränssnittet.';
    $Self->{Translation}->{'Dynamic fields shown in the config item overview screen of the customer interface.'} =
        'Dynamiska fält som visas på skärmen för översikt av konfigurationsobjekt i kundgränssnittet.';
    $Self->{Translation}->{'Dynamic fields shown in the config item search screen of the agent interface.'} =
        'Dynamiska fält som visas på skärmen för sökning av konfigurationsobjekt i agentgränssnittet.';
    $Self->{Translation}->{'Enables configuration item bulk action feature for the agent frontend to work on more than one configuration item at a time.'} =
        'Aktiverar funktionen för massåtgärder för konfigurationsobjekt så att agentens frontend kan arbeta med mer än ett konfigurationsobjekt åt gången.';
    $Self->{Translation}->{'Enables configuration item bulk action feature only for the listed groups.'} =
        'Aktiverar funktionen för massåtgärder för konfigurationsobjekt endast för de grupper som anges i listan.';
    $Self->{Translation}->{'Enables/disables the functionality to check ITSM onfiguration items for unique names. Before enabling this option you should check your system for already existing config items with duplicate names. You can do this with the console command Admin::ITSM::Configitem::ListDuplicates.'} =
        'Aktiverar/inaktiverar funktionen för att kontrollera att ITSM-konfigurationsobjekt har unika namn. Innan du aktiverar det här alternativet bör du kontrollera om det redan finns konfigurationsobjekt med dubbla namn i systemet. Du kan göra detta med konsolkommandot Admin::ITSM::Configitem::ListDuplicates.';
    $Self->{Translation}->{'Event module to set configitem-status on ticket-configitem-link.'} =
        'Händelsemodul för att sätta configitem-status på ticket-configitem-link.';
    $Self->{Translation}->{'Fields of the configuration item index, used for the fulltext search. Fields are also stored, but are not mandatory for the overall functionality. Inclusion of attachments can be disabled by setting the entry to 0 or deleting it.'} =
        'Fält i konfigurationsobjektets index som används för fulltextsökning. Fält lagras också, men är inte obligatoriska för den övergripande funktionaliteten. Inkludering av bilagor kan inaktiveras genom att sätta posten till 0 eller radera den.';
    $Self->{Translation}->{'Fields stored in the configuration item index which are used for other things besides fulltext searches. For the complete functionality all fields are mandatory.'} =
        'Fält som lagras i konfigurationsobjektets index och som används för andra saker än fulltextsökning. För fullständig funktionalitet är alla fält obligatoriska.';
    $Self->{Translation}->{'For every webservice (key) an array of classes (value) can be defined on which the import is restricted. For all chosen classes, or all existing classes the identifying attributes will have to be chosen in the invoker config.'} =
        'För varje webbtjänst (nyckel) kan en array av klasser (värde) definieras för vilka importen är begränsad. För alla valda klasser, eller alla befintliga klasser, måste de identifierande attributen väljas i konfigurationen av invokern.';
    $Self->{Translation}->{'GenericInterface module registration for the ConfigItemFetch invoker layer.'} =
        'Registrering av GenericInterface-modul för ConfigItemFetch-inkallningslagret.';
    $Self->{Translation}->{'ITSM ConfigItem'} = 'ITSM KonfigItem';
    $Self->{Translation}->{'ITSM config item overview.'} = 'Översikt över ITSM-konfigurationsobjekt.';
    $Self->{Translation}->{'If this option is activated, linked items are only counted if they belong to one of the listed classes.'} =
        'Om detta alternativ är aktiverat räknas länkade objekt endast om de tillhör någon av de listade klasserna.';
    $Self->{Translation}->{'InciState'} = 'InciState';
    $Self->{Translation}->{'IncidentState'} = 'HändelseStatus';
    $Self->{Translation}->{'Includes deployment states in the config item search of the customer interface.'} =
        'Inkluderar driftsättningsstatusar i sökningen efter konfigurationsobjekt i kundgränssnittet.';
    $Self->{Translation}->{'Includes incident states in the config item search of the customer interface.'} =
        'Inkluderar incidentstatusar i sökningen efter konfigurationsobjekt i kundgränssnittet.';
    $Self->{Translation}->{'Maximum number of config items to be displayed in the result of this operation.'} =
        'Maximalt antal konfigurationsobjekt som ska visas i resultatet av denna åtgärd.';
    $Self->{Translation}->{'Module to check the group responsible for a class.'} = 'Modul för att kontrollera vilken grupp som är ansvarig för en klass.';
    $Self->{Translation}->{'Module to check the group responsible for a configuration item.'} =
        'Modul för att kontrollera vilken grupp som är ansvarig för ett konfigurationsobjekt.';
    $Self->{Translation}->{'Module to generate ITSM config item statistics.'} = 'Modul för att generera statistik över ITSM-konfigurationsobjekt.';
    $Self->{Translation}->{'Name Module'} = 'Namn Modul';
    $Self->{Translation}->{'Number Module'} = 'Nummer Modul';
    $Self->{Translation}->{'Number of config items to be displayed in each page of a search result in the agent interface.'} =
        'Antal konfigurationsobjekt som ska visas på varje sida i ett sökresultat i agentgränssnittet.';
    $Self->{Translation}->{'Number of config items to be displayed in each page of a search result in the customer interface.'} =
        'Antal konfigurationsobjekt som ska visas på varje sida av ett sökresultat i kundgränssnittet.';
    $Self->{Translation}->{'Objects to search for, how many entries and which attributs to show. ConfigItem attributes have to explicitly be stored via Elasticsearch.'} =
        'Objekt att söka efter, hur många poster och vilka attribut som ska visas. ConfigItem-attribut måste uttryckligen lagras via Elasticsearch.';
    $Self->{Translation}->{'Overview.'} = 'Översikt.';
    $Self->{Translation}->{'Parameters for the categories for config item classes in the preferences view of the agent interface.'} =
        'Parametrar för kategorierna för klasser av konfigurationsobjekt i preferensvyn i agentgränssnittet.';
    $Self->{Translation}->{'Parameters for the column filters of the small config item overview. Please note: setting \'Active\' to 0 will only prevent agents from editing settings of this group in their personal preferences, but will still allow administrators to edit the settings of another user\'s behalf. Use \'PreferenceGroup\' to control in which area these settings should be shown in the user interface.'} =
        'Parametrar för kolumnfiltren i den lilla översikten över konfigurationsobjekt. Observera: om du anger "Active" till 0 förhindras endast handläggare från att redigera inställningar för denna grupp i sina personliga inställningar, men administratörer kan fortfarande redigera inställningarna för en annan användares räkning. Använd "PreferenceGroup" för att styra i vilket område dessa inställningar ska visas i användargränssnittet.';
    $Self->{Translation}->{'Parameters for the dashboard backend of the customer company config item overview of the agent interface . "Limit" is the number of entries shown by default. "Group" is used to restrict the access to the plugin (e. g. Group: admin;group1;group2;). "Default" determines if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" is the cache time in minutes for the plugin.'} =
        'Parametrar för dashboard backend för kundföretagets konfigurationsobjekt översikt över agentgränssnittet. "Limit" är antalet poster som visas som standard. "Group" används för att begränsa åtkomsten till insticksprogrammet (t.ex. Group: admin;group1;group2;). "Default" avgör om insticksprogrammet är aktiverat som standard eller om användaren måste aktivera det manuellt. "CacheTTLLocal" är cachetiden i minuter för insticksprogrammet.';
    $Self->{Translation}->{'Parameters for the deployment states color in the preferences view of the agent interface.'} =
        'Parametrar för färgen för driftsättningsstatus i preferensvyn i agentgränssnittet.';
    $Self->{Translation}->{'Parameters for the deployment states in the preferences view of the agent interface.'} =
        'Parametrar för driftsättningstillstånd i preferensvyn i agentgränssnittet.';
    $Self->{Translation}->{'Parameters for the example permission groups of the general catalog attributes.'} =
        'Parametrar för exempel på behörighetsegrupper i grundkatalogens attribut.';
    $Self->{Translation}->{'Parameters for the name module for config item classes in the preferences view of the agent interface.'} =
        'Parametrar för namnmodulen för klasser av konfigurationsobjekt i preferensvyn i agentgränssnittet.';
    $Self->{Translation}->{'Parameters for the number module for config item classes in the preferences view of the agent interface.'} =
        'Parametrar för nummermodulen för klasser av konfigurationsobjekt i preferensvyn i agentgränssnittet.';
    $Self->{Translation}->{'Parameters for the pages (in which the configuration items are shown).'} =
        'Parametrar för sidorna (där konfigurationsobjekten visas).';
    $Self->{Translation}->{'Parameters for the version string module for config item classes in the preferences view of the agent interface.'} =
        'Parametrar för modulen version string för klasser av konfigurationsobjekt i preferensvyn i agentgränssnittet.';
    $Self->{Translation}->{'Parameters for the version string template toolkit module for config item classes in the preferences view of the agent interface.'} =
        'Parametrar för version string template toolkit module för config item classes i preferensvyn i agentgränssnittet.';
    $Self->{Translation}->{'Parameters for the version trigger for config item classes in the preferences view of the agent interface.'} =
        'Parametrar för versionsutlösaren för klasser av konfigurationsobjekt i preferensvyn i agentgränssnittet.';
    $Self->{Translation}->{'Performs the configured action for each event (as an Invoker) for each configured Webservice.'} =
        'Utför den konfigurerade åtgärden för varje händelse (som en Invoker) för varje konfigurerad webbtjänst.';
    $Self->{Translation}->{'Permission Group'} = 'Behörighetsgrupp';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item attachment action in the agent interface.'} =
        'Behörighet krävs för att använda åtgärden Attachment för ITSM-konfigurationsobjekt i agentgränssnittet.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item screen in the agent interface.'} =
        'Behörighet krävs för att använda skärmen ITSM-konfigurationsobjekt i agentgränssnittet.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item search screen in the agent interface.'} =
        'Behörighet krävs för att använda sökskärmen för ITSM-konfigurationsobjekt i agentgränssnittet.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item search screen in the customer interface.'} =
        'Behörighet krävs för att använda sökskärmen för ITSM-konfigurationsobjekt i kundgränssnittet.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item tree view screen in the agent interface.'} =
        'Behörighet krävs för att använda trädvyn för ITSM-konfigurationsobjekt i agentgränssnittet.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item zoom screen in the agent interface.'} =
        'Behörighet krävs för att använda zoomskärmen för ITSM-konfigurationsobjekt i agentgränssnittet.';
    $Self->{Translation}->{'Required permissions to use the add ITSM configuration item screen in the agent interface.'} =
        'Behörighet krävs för att använda skärmen Lägg till ITSM-konfigurationsobjekt i agentgränssnittet.';
    $Self->{Translation}->{'Required permissions to use the bulk ITSM configuration item screen in the agent interface.'} =
        'Behörighet krävs för att använda skärmen för ITSM-konfigurationsobjekt i bulk i agentgränssnittet.';
    $Self->{Translation}->{'Required permissions to use the edit ITSM configuration item screen in the agent interface.'} =
        'Behörighet krävs för att använda skärmen Redigera ITSM-konfigurationsobjekt i agentgränssnittet.';
    $Self->{Translation}->{'Required permissions to use the history ITSM configuration item screen in the agent interface.'} =
        'Behörighet krävs för att använda skärmen Historik över ITSM-konfigurationsobjekt i agentgränssnittet.';
    $Self->{Translation}->{'Required permissions to use the print ITSM configuration item screen in the agent interface.'} =
        'Behörighet krävs för att använda skärmen Skriv ut ITSM-konfigurationsobjekt i agentgränssnittet.';
    $Self->{Translation}->{'Required privileges to delete config items.'} = 'Behörighet krävs för att ta bort konfigurationsobjekt.';
    $Self->{Translation}->{'Search config items.'} = 'Sök i konfigurationsobjekt.';
    $Self->{Translation}->{'Set the incident state of a CI automatically when a Ticket is Linked to a CI.'} =
        'Ställ in incidentstatus för ett CI automatiskt när en Ticket länkas till ett CI.';
    $Self->{Translation}->{'Sets the deployment state in the configuration item bulk screen of the agent interface.'} =
        'Ställer in driftsättningsstatus i konfigurationsobjektets bulkskärm i agentgränssnittet.';
    $Self->{Translation}->{'Sets the incident state in the configuration item bulk screen of the agent interface.'} =
        'Ställer in incidentstatus i konfigurationsobjektets bulkskärm i agentgränssnittet.';
    $Self->{Translation}->{'Shows a link in the menu that allows linking a configuration item with another object in the config item zoom view of the agent interface.'} =
        'Visar en länk i menyn som gör det möjligt att länka ett konfigurationsobjekt till ett annat objekt i zoomvyn för konfigurationsobjektet i agentgränssnittet.';
    $Self->{Translation}->{'Shows a link in the menu to access the history of a configuration item in the configuration item overview of the agent interface.'} =
        'Visar en länk i menyn för att komma åt historiken för ett konfigurationsobjekt i översikten över konfigurationsobjekt i agentgränssnittet.';
    $Self->{Translation}->{'Shows a link in the menu to access the history of a configuration item in the its zoom view of the agent interface.'} =
        'Visar en länk i menyn för att komma åt historiken för ett konfigurationsobjekt i zoomvyn i agentgränssnittet.';
    $Self->{Translation}->{'Shows a link in the menu to delete a configuration item in its zoom view of the agent interface.'} =
        'Visar en länk i menyn för att ta bort ett konfigurationsobjekt i dess zoomvy av agentgränssnittet.';
    $Self->{Translation}->{'Shows a link in the menu to display the configuration item links as a Tree View.'} =
        'Visar en länk i menyn för att visa länkarna till konfigurationsobjekten som en trädvy.';
    $Self->{Translation}->{'Shows a link in the menu to duplicate a configuration item in the configuration item overview of the agent interface.'} =
        'Visar en länk i menyn för att duplicera ett konfigurationsobjekt i översikten över konfigurationsobjekt i agentgränssnittet.';
    $Self->{Translation}->{'Shows a link in the menu to duplicate a configuration item in the its zoom view of the agent interface.'} =
        'Visar en länk i menyn för att duplicera ett konfigurationsobjekt i zoomvyn av agentgränssnittet.';
    $Self->{Translation}->{'Shows a link in the menu to edit a configuration item in the its zoom view of the agent interface.'} =
        'Visar en länk i menyn för att redigera ett konfigurationsobjekt i zoomvyn av agentgränssnittet.';
    $Self->{Translation}->{'Shows a link in the menu to go back in the configuration item zoom view of the agent interface.'} =
        'Visar en länk i menyn för att gå tillbaka i zoomvyn för konfigurationsobjektet i agentgränssnittet.';
    $Self->{Translation}->{'Shows a link in the menu to print a configuration item in the its zoom view of the agent interface.'} =
        'Visar en länk i menyn för att skriva ut ett konfigurationsobjekt i zoomvyn av agentgränssnittet.';
    $Self->{Translation}->{'Shows a link in the menu to zoom into a configuration item in the configuration item overview of the agent interface.'} =
        'Visar en länk i menyn för att zooma in på ett konfigurationsobjekt i översikten över konfigurationsobjekt i agentgränssnittet.';
    $Self->{Translation}->{'Shows the config item history (reverse ordered) in the agent interface.'} =
        'Visar historiken för konfigurationsobjekt (omvänd ordning) i agentgränssnittet.';
    $Self->{Translation}->{'The default category which is shown, if none is selected.'} = 'Den standardkategori som visas om ingen kategori har valts.';
    $Self->{Translation}->{'The identifier for a configuration item, e.g. ConfigItem#, MyConfigItem#. The default is ConfigItem#.'} =
        'Identifieraren för ett konfigurationsobjekt, t.ex. ConfigItem#, MyConfigItem#. Standardvärdet är ConfigItem#.';
    $Self->{Translation}->{'Triggers ConfigItemFetch invoker automatically.'} = 'Utlöser ConfigItemFetch-inkallaren automatiskt.';
    $Self->{Translation}->{'Version String Expression'} = 'Version String Uttryck';
    $Self->{Translation}->{'Version String Module'} = 'Version String Modul';
    $Self->{Translation}->{'Version Trigger'} = 'Version Trigger';
    $Self->{Translation}->{'Whether the execution of ConfigItemACL can be avoided by checking cached field dependencies. This can improve loading times of formulars, but has to be disabled, if ACLModules are to be used for ITSMConfigItem- and Form-ReturnTypes.'} =
        'Om körningen av ConfigItemACL kan undvikas genom att kontrollera cachelagrade fältberoenden. Detta kan förbättra laddningstiderna för formulär, men måste avaktiveras om ACLModules ska användas för ITSMConfigItem- och Form-ReturnTypes.';
    $Self->{Translation}->{'Which general information is shown in the header.'} = 'Vilken allmän information visas i rubriken.';
    $Self->{Translation}->{'With this option it´s possible to fill automaticly a CI field, depending on the count of linked CI´s with the existing type DependsOn.'} =
        'Med detta alternativ är det möjligt att automatiskt fylla i ett CI-fält, beroende på antalet länkade CI med den befintliga typen DependsOn.';
    $Self->{Translation}->{'With this option it´s possible to fill automaticly a CI field, depending on the count of linked CI´s.'} =
        'Med detta alternativ är det möjligt att automatiskt fylla i ett CI-fält, beroende på antalet länkade CI:er.';
    $Self->{Translation}->{'With this option it´s possible to fill automaticly a CI field, depending on the count of linked CI´s. The setting CounterClassName include the name of the class and CounterFieldName is used to store the count of used licence.'} =
        'Med detta alternativ är det möjligt att automatiskt fylla i ett CI-fält, beroende på antalet länkade CI. Inställningen CounterClassName innehåller namnet på klassen och CounterFieldName används för att lagra antalet använda licenser.';
    $Self->{Translation}->{'class'} = 'klass';
    $Self->{Translation}->{'global'} = 'globala';
    $Self->{Translation}->{'postproductive'} = 'postproduktiv';
    $Self->{Translation}->{'preproductive'} = 'preproduktiv';
    $Self->{Translation}->{'productive'} = 'produktiv';


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

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

package Kernel::Language::nl_ITSMConfigurationManagement;

use strict;
use warnings;
use utf8;

sub Data {
    my $Self = shift;

    # Template: AdminGenericInterfaceOperationConfigItem
    $Self->{Translation}->{'General operation data'} = 'Algemene bedrijfsgegevens';
    $Self->{Translation}->{'Settings for incoming request data'} = 'Instellingen voor inkomende aanvraaggegevens';
    $Self->{Translation}->{'Settings for outgoing response data'} = 'Instellingen voor uitgaande responsgegevens';

    # Template: AdminITSMConfigItem
    $Self->{Translation}->{'Config Item Management'} = 'Configuratie-item beheer';
    $Self->{Translation}->{'Change class definition'} = 'Wijzig definitie';
    $Self->{Translation}->{'Change role definition'} = 'Roldefinitie wijzigen';
    $Self->{Translation}->{'Ready2Import Class Bundles'} = 'Ready2Import klassenbundels';
    $Self->{Translation}->{'Here you can import Ready2Import class bundles showcasing our most usual config items. Please note that some additional configuration may be required.'} =
        'Hier kunt u Ready2Import klassebundels importeren die onze meest gebruikelijke configuratie-items tonen. Houd er rekening mee dat sommige aanvullende configuraties nodig kunnen zijn.';
    $Self->{Translation}->{'Update existing entities'} = 'Bestaande entiteiten bijwerken';
    $Self->{Translation}->{'Import Ready2Adopt class bundles'} = 'Ready2Adopt klassebundels importeren';
    $Self->{Translation}->{'Config Item Class'} = 'Configuratie Item Klasse';
    $Self->{Translation}->{'Config Item Role'} = 'Configuratie-item Rol';

    # Template: AgentITSMConfigItemAdd
    $Self->{Translation}->{'Config Item'} = 'Configuratie-item';
    $Self->{Translation}->{'Filter for Classes'} = 'Filter op klassen';
    $Self->{Translation}->{'Select a Class from the list to create a new Config Item.'} = 'Selecteer een klasse uit de lijst om een nieuw configuratie-item aan te maken.';
    $Self->{Translation}->{'Class'} = 'Klasse';

    # Template: AgentITSMConfigItemBulk
    $Self->{Translation}->{'ITSM ConfigItem Bulk Action'} = 'ITSM-configItem bulkactie';
    $Self->{Translation}->{'Deployment state'} = 'Status';
    $Self->{Translation}->{'Incident state'} = 'Incidentstatus';
    $Self->{Translation}->{'Link to another'} = 'Link naar een andere';
    $Self->{Translation}->{'Invalid Configuration Item number!'} = 'Ongeldig Configuratie Item nummer!';
    $Self->{Translation}->{'The number of another Configuration Item to link with.'} = 'Het nummer van een ander configuratie-item om mee te linken.';

    # Template: AgentITSMConfigItemDelete
    $Self->{Translation}->{'Do you really want to delete this config item?'} = 'Wilt u dit configuratie-item echt verwijderen?';

    # Template: AgentITSMConfigItemEdit
    $Self->{Translation}->{'The name of this config item'} = 'De naam van dit configuratie-item';
    $Self->{Translation}->{'Name is already in use by the ConfigItems with the following Number(s): %s'} =
        'Naam is al in gebruik door de ConfigItems met de volgende Nummer(s): %s';
    $Self->{Translation}->{'Version Number'} = 'Versienummer';
    $Self->{Translation}->{'Version number of this config item'} = 'Versienummer van dit config item';
    $Self->{Translation}->{'Version Number is already in use by the ConfigItems with the following Number(s): %s'} =
        'Versienummer is al in gebruik door de ConfigItems met het volgende nummer: %s';
    $Self->{Translation}->{'Deployment State'} = 'Status';
    $Self->{Translation}->{'Incident State'} = 'Incidentstatus';

    # Template: AgentITSMConfigItemHistory
    $Self->{Translation}->{'History of Config Item: %s'} = 'Geschiedenis van Configuratie-item: %s';
    $Self->{Translation}->{'History Content'} = 'Inhoud';
    $Self->{Translation}->{'Createtime'} = 'Aangemaakt op';
    $Self->{Translation}->{'Zoom view'} = 'Detailoverzicht';

    # Template: AgentITSMConfigItemOverviewNavBar
    $Self->{Translation}->{'Config Items per page'} = 'Aantal configuratie-items per pagina';

    # Template: AgentITSMConfigItemOverviewSmall
    $Self->{Translation}->{'No config item data found.'} = 'Geen config item gegevens gevonden.';
    $Self->{Translation}->{'Select this config item'} = 'Selecteer dit configuratie-item';

    # Template: AgentITSMConfigItemSearch
    $Self->{Translation}->{'Run Search'} = 'Zoeken';
    $Self->{Translation}->{'Also search in previous versions?'} = 'Ook in eerdere versies zoeken?';

    # Template: AgentITSMConfigItemTreeView
    $Self->{Translation}->{'TreeView for ConfigItem'} = 'TreeView voor ConfigItem';
    $Self->{Translation}->{'Depth Level'} = 'Diepte Niveau';
    $Self->{Translation}->{'Zoom In/Out'} = 'In-/uitzoomen';
    $Self->{Translation}->{'Max links level reached for ConfigItem!'} = 'Max. koppelingsniveau bereikt voor ConfigItem!';

    # Template: AgentITSMConfigItemZoom
    $Self->{Translation}->{'Configuration Item'} = 'Configuratie-item';
    $Self->{Translation}->{'Configuration Item Information'} = 'Configuratie-item informatie';
    $Self->{Translation}->{'Current Deployment State'} = 'Actuele status';
    $Self->{Translation}->{'Current Incident State'} = 'Actuele incidentstatus';
    $Self->{Translation}->{'Last changed'} = 'Laaste wijziging';
    $Self->{Translation}->{'Last changed by'} = 'Laaste wijziging door';

    # Template: CustomerITSMConfigItem
    $Self->{Translation}->{'Your ConfigItems'} = 'Uw ConfigItems';

    # Template: CustomerITSMConfigItemSearch
    $Self->{Translation}->{'ConfigItem Search'} = 'ConfigItem zoeken';

    # Template: AdminACL
    $Self->{Translation}->{'Object Type'} = 'Type object';

    # Template: AdminDynamicFieldScreen
    $Self->{Translation}->{'Filter by object type'} = '';

    # JS Template: ClassImportConfirm
    $Self->{Translation}->{'The following classes will be imported'} = 'De volgende klassen worden geïmporteerd';
    $Self->{Translation}->{'The following roles will be imported'} = 'De volgende rollen worden geïmporteerd';
    $Self->{Translation}->{'Note that also corresponding dynamic fields and GeneralCatalog classes will be created and there is no automatic removal.'} =
        'Merk op dat ook overeenkomstige dynamische velden en GeneralCatalog klassen worden aangemaakt en dat deze niet automatisch worden verwijderd.';
    $Self->{Translation}->{'Do you want to proceed?'} = 'Wil je doorgaan?';

    # Perl Module: Kernel/Modules/AdminITSMConfigItem.pm
    $Self->{Translation}->{'Need ExampleClasses!'} = 'Voorbeeldklassen nodig!';
    $Self->{Translation}->{'Definition is no valid YAML hash.'} = 'Definitie is geen geldige YAML hash.';

    # Perl Module: Kernel/Modules/AgentITSMConfigItem.pm
    $Self->{Translation}->{'Overview: ITSM ConfigItem'} = 'Overzicht: ITSM ConfigItem';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemBulk.pm
    $Self->{Translation}->{'No ConfigItemID is given!'} = 'Er is geen ConfigItemID opgegeven!';
    $Self->{Translation}->{'You need at least one selected Configuration Item!'} = 'Je hebt ten minste één geselecteerd configuratie-item nodig!';
    $Self->{Translation}->{'You don\'t have write access to this configuration item: %s.'} =
        'Je hebt geen schrijftoegang tot dit configuratie-item: %s.';
    $Self->{Translation}->{'No definition was defined for class %s!'} = 'Er is geen definitie gedefinieerd voor klasse %s!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemDelete.pm
    $Self->{Translation}->{'Config item "%s" not found in database!'} = 'Config item "%s" niet gevonden in database!';
    $Self->{Translation}->{'Was not able to delete the configitem ID %s!'} = 'Definieert het aantal rijen voor de CI-definitie-editor in de beheerinterface.';
    $Self->{Translation}->{'No version found for ConfigItemID %s!'} = 'Geen versie gevonden voor ConfigItemID %s!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemEdit.pm
    $Self->{Translation}->{'No ConfigItemID, DuplicateID or ClassID is given!'} = 'Er is geen ConfigItemID, DuplicateID of ClassID opgegeven!';
    $Self->{Translation}->{'No access is given!'} = 'Er wordt geen toegang gegeven!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemHistory.pm
    $Self->{Translation}->{'Can\'t show history, no ConfigItemID is given!'} = 'Kan geschiedenis niet weergeven, er is geen ConfigItemID opgegeven!';
    $Self->{Translation}->{'Can\'t show history, no access rights given!'} = 'Kan geschiedenis niet weergeven, geen toegangsrechten gegeven!';
    $Self->{Translation}->{'New ConfigItem (ID=%s)'} = 'Nieuw ConfigItem (ID=%s)';
    $Self->{Translation}->{'New version (ID=%s)'} = 'Nieuwe versie (ID=%s)';
    $Self->{Translation}->{'Deployment state updated (new=%s, old=%s)'} = 'Stationstatus bijgewerkt (nieuw=%s, oud=%s)';
    $Self->{Translation}->{'Incident state updated (new=%s, old=%s)'} = 'Incident status bijgewerkt (nieuw=%s, oud=%s)';
    $Self->{Translation}->{'ConfigItem (ID=%s) deleted'} = 'ConfigItem (ID=%s) verwijderd';
    $Self->{Translation}->{'Link to %s (type=%s) added'} = 'Link naar %s (type=%s) toegevoegd';
    $Self->{Translation}->{'Link to %s (type=%s) deleted'} = 'Link naar %s (type=%s) verwijderd';
    $Self->{Translation}->{'ConfigItem definition updated (ID=%s)'} = 'ConfigItem definitie bijgewerkt (ID=%s)';
    $Self->{Translation}->{'Name updated (new=%s, old=%s)'} = 'Naam bijgewerkt (nieuw=%s, oud=%s)';
    $Self->{Translation}->{'Attribute %s updated from "%s" to "%s"'} = 'Attribuut %s bijgewerkt van "%s" naar "%s"';
    $Self->{Translation}->{'Version %s deleted'} = 'Versie %s verwijderd';
    $Self->{Translation}->{'File "%s" uploaded'} = '';
    $Self->{Translation}->{'File "%s" removed'} = '';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemPrint.pm
    $Self->{Translation}->{'No ConfigItemID or VersionID is given!'} = 'Er is geen ConfigItemID of VersionID opgegeven!';
    $Self->{Translation}->{'Can\'t show config item, no access rights given!'} = 'Kan config item niet tonen, geen toegangsrechten gegeven!';
    $Self->{Translation}->{'ConfigItemID %s not found in database!'} = 'ConfigItemID %s niet gevonden in database!';
    $Self->{Translation}->{'ConfigItem'} = 'ConfigItem';
    $Self->{Translation}->{'printed by %s at %s'} = 'afgedrukt door %s op %s';
    $Self->{Translation}->{'Referenced by'} = '';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemSearch.pm
    $Self->{Translation}->{'Invalid ClassID!'} = 'Ongeldige ClassID!';
    $Self->{Translation}->{'No ClassID is given!'} = 'Er is geen ClassID gegeven!';
    $Self->{Translation}->{'No access rights for this class given!'} = 'Geen toegangsrechten voor deze klasse gegeven!';
    $Self->{Translation}->{'No Result!'} = 'Geen resultaat!';
    $Self->{Translation}->{'Config Item Search Results'} = 'Config item zoekresultaten';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemZoom.pm
    $Self->{Translation}->{'Can\'t show item, no access rights for ConfigItem are given!'} =
        'Kan item niet weergeven, er zijn geen toegangsrechten voor ConfigItem gegeven!';
    $Self->{Translation}->{'ConfigItem not found!'} = 'ConfigItem niet gevonden!';
    $Self->{Translation}->{'No versions found!'} = 'Geen versies gevonden!';
    $Self->{Translation}->{'operational'} = 'operationeel';
    $Self->{Translation}->{'warning'} = 'waarschuwing';
    $Self->{Translation}->{'incident'} = 'incident';
    $Self->{Translation}->{'The deployment state of this config item'} = 'De status van dit configuratie-item';
    $Self->{Translation}->{'The incident state of this config item'} = 'De incidentstatus van dit configuratie-item';

    # Perl Module: Kernel/Modules/CustomerITSMConfigItemSearch.pm
    $Self->{Translation}->{'No permission'} = 'Geen toestemming';
    $Self->{Translation}->{'Filter invalid!'} = 'Filter ongeldig!';
    $Self->{Translation}->{'Search params invalid!'} = 'Zoekparameters ongeldig!';

    # Perl Module: Kernel/Output/HTML/Dashboard/ITSMConfigItemGeneric.pm
    $Self->{Translation}->{'Shown config items'} = 'Weergegeven configuratie-items';
    $Self->{Translation}->{'Deployment State Type'} = 'Type inzetstatus';
    $Self->{Translation}->{'Current Incident State Type'} = 'Type huidig incident';

    # Perl Module: Kernel/Output/HTML/ITSMConfigItem/LayoutDate.pm
    $Self->{Translation}->{'Between'} = 'Tussen';

    # Perl Module: Kernel/System/DynamicField/Driver/ConfigItem.pm
    $Self->{Translation}->{'Class restrictions for the config item'} = 'Klassebeperkingen voor het config item';
    $Self->{Translation}->{'Select one or more classes to restrict selectable config items'} =
        'Selecteer een of meer klassen om selecteerbare configuratie-items te beperken';
    $Self->{Translation}->{'Deployment state restrictions for the config item'} = '';
    $Self->{Translation}->{'Select one or more deployment states to restrict selectable config items'} =
        '';
    $Self->{Translation}->{'Dynamic (ConfigItem)'} = 'Dynamisch (ConfigItem)';
    $Self->{Translation}->{'Static (Version)'} = 'Statisch (versie)';
    $Self->{Translation}->{'Link Referencing Type'} = 'Type verwijzing';
    $Self->{Translation}->{'Whether this link applies to the ConfigItem or the static version of the referencing object. Current Incident State calculation only is performed on dynamic links.'} =
        'Of deze link van toepassing is op het ConfigItem of de statische versie van het object waarnaar verwezen wordt. De berekening van de huidige incidenttoestand wordt alleen uitgevoerd op dynamische links.';
    $Self->{Translation}->{'Select the attribute which config items will be searched by'} = 'Selecteer het attribuut waarop de configuratie-items moeten worden doorzocht';

    # Perl Module: Kernel/System/ITSMConfigItem/Definition.pm
    $Self->{Translation}->{'Base structure is not valid. Please provide a hash with data in YAML format.'} =
        'Basisstructuur is ongeldig. Geef een hash met gegevens in YAML-indeling.';
    $Self->{Translation}->{'Starting the YAML string with \'---\' is required.'} = 'De YAML-string beginnen met \'---\' is vereist.';

    # Perl Module: Kernel/System/ITSMConfigItem/Link.pm
    $Self->{Translation}->{'Could not purge the table configitem_link.'} = 'Kon de tabel configitem_link niet verwijderen.';
    $Self->{Translation}->{'No relevant dynamic fields were found'} = 'Er zijn geen relevante dynamische velden gevonden';
    $Self->{Translation}->{'Could not insert into the table configitem_link'} = 'Kon niet invoegen in de tabel configitem_link';
    $Self->{Translation}->{'Inserted 0 rows into the table configitem_link'} = '0 rijen ingevoegd in de tabel configitem_link';

    # Perl Module: Kernel/System/ImportExport/ObjectBackend/ITSMConfigItem.pm
    $Self->{Translation}->{'Maximum number of one element'} = 'Maximale hoeveelheid';
    $Self->{Translation}->{'Maximum number of one Set dynamic field element'} = '';
    $Self->{Translation}->{'Maximum number of one element within a Set dynamic field element'} =
        '';
    $Self->{Translation}->{'Import/Export attachments (as the last entries per line)'} = 'Bijlagen importeren/exporteren (als laatste invoer per regel)';
    $Self->{Translation}->{'Version String'} = 'Versie String';

    # Perl Module: Kernel/Modules/AdminDynamicField.pm
    $Self->{Translation}->{'Error synchronizing the definitions. Please check the log.'} = 'Fout bij het synchroniseren van de definities. Controleer het logboek.';
    $Self->{Translation}->{'You have ITSMConfigItem definitions which are not synchronized. Please deploy your ITSMConfigItem dynamic field changes.'} =
        'Je hebt ITSMConfigItem definities die niet gesynchroniseerd zijn. Implementeer je ITSMConfigItem dynamische veldwijzigingen.';

    # Database XML / SOPM Definition: ITSMConfigurationManagement.sopm
    $Self->{Translation}->{'Expired'} = 'Verlopen';
    $Self->{Translation}->{'Maintenance'} = 'In onderhoud';
    $Self->{Translation}->{'Pilot'} = 'Pilot';
    $Self->{Translation}->{'Planned'} = 'Geplanned';
    $Self->{Translation}->{'Repair'} = 'In reparatie';
    $Self->{Translation}->{'Retired'} = 'Uitgefaseerd';
    $Self->{Translation}->{'Review'} = 'Review';
    $Self->{Translation}->{'Test/QA'} = 'Test/QA';

    # JS File: ITSM.Admin.ITSMConfigItem
    $Self->{Translation}->{'Overview and Confirmation'} = 'Overzicht en bevestiging';
    $Self->{Translation}->{'Importing classes/roles and their related fields'} = 'Klassen/rollen en hun gerelateerde velden importeren';
    $Self->{Translation}->{'An error occurred during class import.'} = 'Er is een fout opgetreden tijdens het importeren van de klasse.';

    # SysConfig
    $Self->{Translation}->{'0 - Hidden'} = '0 - Verborgen';
    $Self->{Translation}->{'1 - Shown'} = '1 - Afgebeeld';
    $Self->{Translation}->{'A mapping of inner field names used in the Process Management TransitionActions ConfigItemAdd and -Update. The keys are the names of the set inner fields of the set with object type ticket which will be used to create/update the CI, and the values are the names of the inner fields of the set with object type ITSMConfigItem.'} =
        '';
    $Self->{Translation}->{'Allows extended search conditions in config item search of the agent interface. With this feature you can search e. g. config item name with this kind of conditions like "(*key1*&&*key2*)" or "(*key1*||*key2*)".'} =
        'Maakt uitgebreide zoekvoorwaarden mogelijk bij het zoeken naar config items in de agent interface. Met deze functie kun je bijvoorbeeld zoeken op config item naam met dit soort condities zoals "(*key1*&&*key2*)" of "(*key1*|*key2*)".';
    $Self->{Translation}->{'Allows extended search conditions in config item search of the customer interface. With this feature you can search e. g. config item name with this kind of conditions like "(*key1*&&*key2*)" or "(*key1*||*key2*)".'} =
        'Maakt uitgebreide zoekvoorwaarden mogelijk bij het zoeken naar configuraties in de klanteninterface. Met deze functie kun je bijvoorbeeld zoeken op config item naam met dit soort condities zoals "(*key1*&&*key2*)" of "(*key1*|*key2*)".';
    $Self->{Translation}->{'Assigned CIs'} = 'Toegewezen CI\'s';
    $Self->{Translation}->{'At a specific time point create a ticket for config items, if the configured requirements are met. The time point is determined by the value of the dynamic field of type date configured under "TimeCIKey" of the ConfigItem, and modified by "TimeModifier". If the latter can be either just a number, or a sign (+/-), a number, and an unit (d/h/m): "7" is equivalent to "+7d". The DynamicField "Ticket->DynamicField" will be used to mark created tickets - it has to exist. The flags \<OTOBO_CONFIGITEM_X\> where X can be NAME, NUMBER and DATE, will be substituted with the respective values in "Ticket->Text".'} =
        '';
    $Self->{Translation}->{'Attributes for license accounting.'} = '';
    $Self->{Translation}->{'Attributes for licenses counting, where "TotalLicensesDF", "AvailableLicensesDF" and "LicenseReferenceDF" are the names of the dynamic fields used to track the remaining licenses. If used, only deployment states in "ValidDeplStates" are considered. If a threshold is defined in "MinimumLicenses", a ticket will automatically be created if less licenses are available. For this, the checkbox dynamic field "Ticket->DynamicField" must exist. The tags \<OTOBO_CONFIGITEM_X\> where X can be NAME, NUMBER, LICENSES_AVAIL and LICENSES_MIN, will be substituted with the respective values in "Ticket->Text" by the config item name, number, available licenses, and minimum required available licenses, respectively.'} =
        '';
    $Self->{Translation}->{'CIs assigned to customer company'} = 'CI\'s toegewezen aan klantbedrijf';
    $Self->{Translation}->{'CIs assigned to customer user'} = 'CI\'s toegewezen aan klantgebruiker';
    $Self->{Translation}->{'CMDB Settings'} = 'CMDB-instellingen';
    $Self->{Translation}->{'Check for a unique name only within the same ConfigItem class (\'class\') or globally (\'global\'), which means every existing ConfigItem is taken into account when looking for duplicates.'} =
        'Controleer alleen op een unieke naam binnen dezelfde ConfigItem-klasse (\'class\') of globaal (\'global\'), wat betekent dat elk bestaand ConfigItem in aanmerking wordt genomen bij het zoeken naar duplicaten.';
    $Self->{Translation}->{'Choose a module to enforce a naming scheme.'} = 'Kies een module om een naamgevingsschema af te dwingen.';
    $Self->{Translation}->{'Choose a module to enforce a number scheme.'} = 'Kies een module om een cijferschema af te dwingen.';
    $Self->{Translation}->{'Choose a module to enforce a version string scheme.'} = 'Kies een module om een versieschema af te dwingen.';
    $Self->{Translation}->{'Choose attributes to trigger the creation of a new version.'} = 'Kies kenmerken om het aanmaken van een nieuwe versie te activeren.';
    $Self->{Translation}->{'Choose categories to assign to this config item class.'} = 'Kies categorieën om toe te wijzen aan deze config item klasse.';
    $Self->{Translation}->{'Column config item filters for ConfigItem Overview.'} = 'Kolom config item filters voor ConfigItem Overzicht.';
    $Self->{Translation}->{'Columns that can be filtered in the config item overview of the agent interface. Note: Only Config Item attributes and Dynamic Fields (DynamicField_NameX) are allowed.'} =
        'Kolommen die kunnen worden gefilterd in het config item overzicht van de agent interface. Opmerking: Alleen Config Item attributen en Dynamische velden (DynamicField_NameX) zijn toegestaan.';
    $Self->{Translation}->{'Config Items'} = 'Configuratie-items';
    $Self->{Translation}->{'Config item add.'} = 'Configuratie-item toevoegen.';
    $Self->{Translation}->{'Config item edit.'} = 'Configuratie-item bewerken.';
    $Self->{Translation}->{'Config item event module that enables accounting licenses for a given config item.'} =
        '';
    $Self->{Translation}->{'Config item event module that enables logging to history in the agent interface.'} =
        'Configuratie-item gebeurtenismodule die het loggen naar geschiedenis in de agentinterface mogelijk maakt.';
    $Self->{Translation}->{'Config item event module that updates config items to their current definition.'} =
        'Config item event module die config items bijwerkt naar hun huidige definitie.';
    $Self->{Translation}->{'Config item history.'} = 'Configuratie-item geschiedenis.';
    $Self->{Translation}->{'Config item print.'} = 'Configuratie-item afdrukken.';
    $Self->{Translation}->{'Config item zoom.'} = 'Configuratie-item zoom.';
    $Self->{Translation}->{'ConfigItem Tree View'} = 'ConfigItem boomstructuur';
    $Self->{Translation}->{'ConfigItem Version'} = 'ConfigItem Versie';
    $Self->{Translation}->{'ConfigItems of the following classes will not be stored on the Elasticsearch server. To apply this to existing CIs, the CI migration has to be run via console, after changing this option.'} =
        'ConfigItems van de volgende klassen worden niet opgeslagen op de Elasticsearch server. Om dit toe te passen op bestaande CIs, moet de CI-migratie worden uitgevoerd via de console, na het wijzigen van deze optie.';
    $Self->{Translation}->{'ConfigItems with the following deployment states will not be stored on the Elasticsearch server. To apply this to existing CIs, the CI migration has to be run via console, after changing this option.'} =
        'ConfigItems met de volgende deployment states worden niet opgeslagen op de Elasticsearch server. Om dit toe te passen op bestaande CIs, moet de CI-migratie worden uitgevoerd via de console, na het wijzigen van deze optie.';
    $Self->{Translation}->{'Configuration Item Limit'} = 'Configuratie Item Limiet';
    $Self->{Translation}->{'Configuration Item limit per page.'} = 'Configuratie Item limiet per pagina.';
    $Self->{Translation}->{'Configuration Management Database.'} = 'Database voor configuratiebeheer.';
    $Self->{Translation}->{'Configuration item bulk module.'} = 'Configuratie-item bulkmodule.';
    $Self->{Translation}->{'Configuration item search backend router of the agent interface.'} =
        'Configuratie-item zoek backend router van de agentinterface.';
    $Self->{Translation}->{'Configure the columns which are available for viewing Permission Conditions in the customer interface, when the corresponding Permission Condition Columns are not specifically configured. This setting is used as a fallback for the other Permission Condition Columns settings.'} =
        '';
    $Self->{Translation}->{'Configure the columns which are available when viewing the corresponding Permission Condition in the customer interface.'} =
        '';
    $Self->{Translation}->{'Create and manage the definitions for Configuration Items.'} = 'Aanmaken en beheren van definities voor configuratie-items.';
    $Self->{Translation}->{'Creates Tickets for ConfigItems at specific time points.'} = 'Creëert tickets voor ConfigItems op specifieke tijdstippen.';
    $Self->{Translation}->{'Customers can see historic CI versions.'} = 'Klanten kunnen historische CI-versies zien.';
    $Self->{Translation}->{'Customers have the possibility to manually switch between historic CI versions.'} =
        'Klanten hebben de mogelijkheid om handmatig te wisselen tussen historische CI-versies.';
    $Self->{Translation}->{'Default data to use on attribute for config item search screen. Example: "ITSMConfigItemCreateTimePointFormat=year;ITSMConfigItemCreateTimePointStart=Last;ITSMConfigItemCreateTimePoint=2;".'} =
        'Standaard gegevens om te gebruiken op attribuut voor config item zoekscherm. Voorbeeld: "ITSMConfigItemCreateTimePointFormat=year;ITSMConfigItemCreateTimePointStart=Last;ITSMConfigItemCreateTimePoint=2;".';
    $Self->{Translation}->{'Default data to use on attribute for config item search screen. Example: "ITSMConfigItemCreateTimeStartYear=2010;ITSMConfigItemCreateTimeStartMonth=10;ITSMConfigItemCreateTimeStartDay=4;ITSMConfigItemCreateTimeStopYear=2010;ITSMConfigItemCreateTimeStopMonth=11;ITSMConfigItemCreateTimeStopDay=3;".'} =
        'Standaard gegevens om te gebruiken op attribuut voor config item zoekscherm. Voorbeeld: "ITSMConfigItemCreateTimeStartYear=2010;ITSMConfigItemCreateTimeStartMonth=10;ITSMConfigItemCreateTimeStartDay=4;ITSMConfigItemCreateTimeStopYear=2010;ITSMConfigItemCreateTimeStopMonth=11;ITSMConfigItemCreateTimeStopDay=3;".';
    $Self->{Translation}->{'Define Actions where a settings button is available in the linked objects widget (LinkObject::ViewMode = "complex"). Please note that these Actions must have registered the following JS and CSS files: Core.AllocationList.css, Core.UI.AllocationList.js, Core.UI.Table.Sort.js, Core.Agent.TableFilters.js and Core.Agent.LinkObject.js.'} =
        'Definieer acties waarbij een instellingenknop beschikbaar is in de widget van gekoppelde objecten (LinkObject::ViewMode = "complex"). Houd er rekening mee dat deze acties de volgende JS- en CSS-bestanden moeten hebben geregistreerd: Core.AllocationList.css, Core.UI.AllocationList.js, Core.UI.Table.Sort.js, Core.Agent.TableFilters.js en Core.Agent.LinkObject.js.';
    $Self->{Translation}->{'Define a Template::Toolkit scheme for version strings. Only used if Version String Module is set to TemplateToolkit.'} =
        'Definieer een Template::Toolkit schema voor versiestrings. Alleen gebruikt als Version String Module is ingesteld op TemplateToolkit.';
    $Self->{Translation}->{'Define a set of conditions under which a customer is allowed to see a config item. Conditions can optionally be restricted to certain customer groups. Name is the only mandatory attribute. If no other options are given, all config items will be visible under that category.'} =
        'Definieer een set voorwaarden waaronder een klant een configuratie-item mag zien. Voorwaarden kunnen optioneel worden beperkt tot bepaalde klantgroepen. Naam is het enige verplichte attribuut. Als er geen andere opties worden gegeven, zullen alle configuratie-items zichtbaar zijn onder die categorie.';
    $Self->{Translation}->{'Defines Required permissions to delete ITSM configuration items using the Generic Interface.'} =
        'Definieert de vereiste machtigingen om ITSM-configuratie-items te verwijderen met behulp van de Generieke Interface.';
    $Self->{Translation}->{'Defines Required permissions to get ITSM configuration items using the Generic Interface.'} =
        'Definieert de vereiste machtigingen om ITSM-configuratie-items op te halen met de Generieke Interface.';
    $Self->{Translation}->{'Defines Required permissions to search ITSM configuration items using the Generic Interface.'} =
        'Definieert de vereiste machtigingen om ITSM-configuratie-items te doorzoeken met behulp van de Generieke Interface.';
    $Self->{Translation}->{'Defines Required permissions to set ITSM configuration items using the Generic Interface.'} =
        'Definieert de vereiste machtigingen om ITSM-configuratie-items in te stellen met behulp van de Generieke Interface.';
    $Self->{Translation}->{'Defines an overview module to show the small view of a configuration item list.'} =
        'Definieert een overzichtsmodule om de kleine weergave van een lijst met configuratie-items weer te geven.';
    $Self->{Translation}->{'Defines if the link type labels must be shown in the node connections.'} =
        'Definieert of de labels van het linktype moeten worden weergegeven in de knooppuntverbindingen.';
    $Self->{Translation}->{'Defines regular expressions individually for each ConfigItem class to check the ConfigItem name and to show corresponding error messages.'} =
        'Definieert reguliere expressies afzonderlijk voor elke ConfigItem-klasse om de ConfigItem-naam te controleren en overeenkomstige foutmeldingen weer te geven.';
    $Self->{Translation}->{'Defines the available columns of CIs in the config item overview depending on the CI class. Each entry must consist of a class name and an array of available fields for the corresponding class. Dynamic field entries have to honor the scheme DynamicField_FieldName.'} =
        'Definieert de beschikbare kolommen van CIs in het config item overzicht afhankelijk van de CI klasse. Elke entry moet bestaan uit een classnaam en een array van beschikbare velden voor de overeenstemmende class. Dynamische veldregels moeten het schema DynamicField_FieldName respecteren.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of the agent interface.'} =
        'Definieert het standaard config item attribuut voor het sorteren van het config item van het zoekresultaat van de agent interface.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of the customer interface.'} =
        'Definieert het standaard config item attribuut voor config item sortering van het config item zoekresultaat van de klanteninterface.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of this operation.'} =
        'Definieert het standaard config item attribuut voor het sorteren van het config item zoekresultaat van deze bewerking.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the agent interface. Up: oldest on top. Down: latest on top.'} =
        'Definieert de standaard volgorde van config items in het zoekresultaat van de agent interface. Omhoog: oudste bovenaan. Omlaag: nieuwste bovenaan.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the customer interface. Up: oldest on top. Down: latest on top.'} =
        'Definieert de standaard volgorde van config items in het zoekresultaat van de klanteninterface. Omhoog: oudste bovenaan. Omlaag: nieuwste bovenaan.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the this operation. Up: oldest on top. Down: latest on top.'} =
        'Definieert de standaard volgorde van configuratie-items in het zoekresultaat van deze bewerking. Omhoog: oudste bovenaan. Omlaag: nieuwste bovenaan.';
    $Self->{Translation}->{'Defines the default displayed columns of CIs in the config item overview depending on the CI class. Each entry must consist of a class name and an array of available fields for the corresponding class. Dynamic field entries have to honor the scheme DynamicField_FieldName.'} =
        'Definieert de standaard getoonde kolommen van CIs in het configuratie-item overzicht, afhankelijk van de CI klasse. Elk item moet bestaan uit een classnaam en een array van beschikbare velden voor de overeenstemmende class. Dynamische veldregels moeten voldoen aan het schema DynamicField_FieldName.';
    $Self->{Translation}->{'Defines the default relations depth to be shown.'} = 'Bepaalt de standaard te tonen relatiediepte.';
    $Self->{Translation}->{'Defines the default shown config item search attribute for config item search screen.'} =
        'Definieert het standaard getoonde config item zoekkenmerk voor het config item zoekscherm.';
    $Self->{Translation}->{'Defines the default shown config item search attribute for config item search screen. Example: "Key" must have the name of the Dynamic Field in this case \'X\', "Content" must have the value of the Dynamic Field depending on the Dynamic Field type,  Text: \'a text\', Dropdown: \'1\', Date/Time: \'Search_DynamicField_XTimeSlotStartYear=1974; Search_DynamicField_XTimeSlotStartMonth=01; Search_DynamicField_XTimeSlotStartDay=26; Search_DynamicField_XTimeSlotStartHour=00; Search_DynamicField_XTimeSlotStartMinute=00; Search_DynamicField_XTimeSlotStartSecond=00; Search_DynamicField_XTimeSlotStopYear=2013; Search_DynamicField_XTimeSlotStopMonth=01; Search_DynamicField_XTimeSlotStopDay=26; Search_DynamicField_XTimeSlotStopHour=23; Search_DynamicField_XTimeSlotStopMinute=59; Search_DynamicField_XTimeSlotStopSecond=59;\' and or \'Search_DynamicField_XTimePointFormat=week; Search_DynamicField_XTimePointStart=Before; Search_DynamicField_XTimePointValue=7\';.'} =
        'Definieert het standaard getoonde config item zoekkenmerk voor het config item zoekscherm. Voorbeeld: "Key" moet de naam hebben van het dynamische veld in dit geval \'X\', "Content" moet de waarde hebben van het dynamische veld afhankelijk van het dynamische veldtype, Text: "een tekst", Dropdown: "1", Date/Time: \'Search_DynamicField_XTimeSlotStartYear=1974; Search_DynamicField_XTimeSlotStartMonth=01; Search_DynamicField_XTimeSlotStartDay=26; Search_DynamicField_XTimeSlotStartHour=00; Search_DynamicField_XTimeSlotStartMinute=00; Search_DynamicField_XTimeSlotStartSecond=00; Search_DynamicField_XTimeSlotStopYear=2013; Search_DynamicField_XTimeSlotStopMonth=01; Search_DynamicField_XTimeSlotStopDay=26; Search_DynamicField_XTimeSlotStopHour=23; Search_DynamicField_XTimeSlotStopMinute=59; Search_DynamicField_XTimeSlotStopSecond=59;\' en of \'Search_DynamicField_XTimePointFormat=week; Search_DynamicField_XTimePointStart=Before; Search_DynamicField_XTimePointValue=7\';.';
    $Self->{Translation}->{'Defines the default subobject of the class \'ITSMConfigItem\'.'} =
        'Definieert het standaard subobject van de klasse \'ITSMConfigItem\'.';
    $Self->{Translation}->{'Defines the disabled columns of CIs in the config item overview depending on the CI class. Each entry must consist of a class name and an array of available fields for the corresponding class. Dynamic field entries have to honor the scheme DynamicField_FieldName.'} =
        '';
    $Self->{Translation}->{'Defines the height for the rich text editor component for this screen. Enter number (pixels) or percent value (relative).'} =
        'Bepaalt de hoogte voor de rich text editorcomponent voor dit scherm. Voer een getal (pixels) of een procentuele waarde (relatief) in.';
    $Self->{Translation}->{'Defines the number of rows for the CI definition editor in the admin interface.'} =
        'Definieert het aantal rijen voor de CI-definitie-editor in de beheerinterface.';
    $Self->{Translation}->{'Defines the order of incident states from high (e.g. cricital) to low (e.g. functional).'} =
        'Definieert de volgorde van de incidenttoestanden van hoog (bijv. cricitaal) naar laag (bijv. functioneel).';
    $Self->{Translation}->{'Defines the relevant deployment states where linked tickets can affect the status of a CI.'} =
        'Definieert de relevante deployment states waar gekoppelde tickets de status van een CI kunnen beïnvloeden.';
    $Self->{Translation}->{'Defines the search limit for the AgentITSMConfigItem screen.'} =
        'Definieert de zoeklimiet voor het scherm AgentITSMConfigItem.';
    $Self->{Translation}->{'Defines the search limit for the AgentITSMConfigItemSearch screen.'} =
        'Definieert de zoeklimiet voor het scherm AgentITSMConfigItemSearch.';
    $Self->{Translation}->{'Defines the search limit for the CustomerITSMConfigItem screen.'} =
        'Definieert de zoeklimiet voor het scherm CustomerITSMConfigItem.';
    $Self->{Translation}->{'Defines the search limit for the CustomerITSMConfigItemSearch screen.'} =
        'Definieert de zoeklimiet voor het scherm CustomerITSMConfigItemSearch.';
    $Self->{Translation}->{'Defines the shown columns of CIs in the link table complex view for all CI classes. If there is no entry, then the default columns are shown.'} =
        'Definieert de getoonde kolommen van CI\'s in de koppeltabel complexe weergave voor alle CI-klassen. Als er geen invoer is, dan worden de standaard kolommen getoond.';
    $Self->{Translation}->{'Defines the shown columns of CIs in the link table complex view, depending on the CI class. Each entry must be prefixed with the class name and double colons (i.e. Computer::). There are a few CI-Attributes that common to all CIs (example for the class Computer: Computer::Name, Computer::CurDeplState, Computer::CreateTime). To show individual CI-Attributes as defined in the CI-Definition, the following scheme must be used (example for the class Computer): Computer::HardDisk::1, Computer::HardDisk::1::Capacity::1, Computer::HardDisk::2, Computer::HardDisk::2::Capacity::1. If there is no entry for a CI class, then the default columns are shown.'} =
        'Definieert de getoonde kolommen van CIs in de linktabel complexe weergave, afhankelijk van de CI-klasse. Elk item moet voorafgegaan worden door de naam van de klasse en dubbele dubbele punten (bv. Computer::). Er zijn een paar CI-attributen die gemeenschappelijk zijn voor alle CI\'s (voorbeeld voor de klasse Computer: Computer::Name, Computer::CurDeplState, Computer::CreateTime). Om individuele CI-Attributen te tonen zoals gedefinieerd in de CI-definitie, moet het volgende schema gebruikt worden (voorbeeld voor de klasse Computer): Computer::HardDisk::1, Computer::HardDisk::1::Capaciteit::1, Computer::HardDisk::2, Computer::HardDisk::2::Capaciteit::1. Als er geen invoer is voor een CI-klasse, dan worden de standaardkolommen weergegeven.';
    $Self->{Translation}->{'Defines which items are available for \'Action\' in third level of the ITSM Config Item ACL structure.'} =
        'Definieert welke items beschikbaar zijn voor \'Actie\' op het derde niveau van de ITSM Config Item ACL structuur.';
    $Self->{Translation}->{'Defines which items are available in first level of the ITSM Config Item ACL structure.'} =
        'Definieert welke items beschikbaar zijn in het eerste niveau van de ITSM Config Item ACL structuur.';
    $Self->{Translation}->{'Defines which items are available in second level of the ITSM Config Item ACL structure.'} =
        'Definieert welke items beschikbaar zijn in het tweede niveau van de ITSM Config Item ACL structuur.';
    $Self->{Translation}->{'Defines which type of link (named from the ticket perspective) can affect the status of a linked CI.'} =
        'Definieert welk type link (genoemd vanuit het ticketperspectief) de status van een gekoppelde CI kan beïnvloeden.';
    $Self->{Translation}->{'Defines which type of ticket can affect the status of a linked CI.'} =
        'Definieert welk type ticket de status van een gekoppelde CI kan beïnvloeden.';
    $Self->{Translation}->{'Definition Update'} = 'Definitie bijwerken';
    $Self->{Translation}->{'Delete Configuration Item'} = 'Configuratie-item verwijderen';
    $Self->{Translation}->{'DeplState'} = 'DeplState';
    $Self->{Translation}->{'Deployment State Color'} = 'Kleur van de inzetstatus';
    $Self->{Translation}->{'DeploymentState'} = 'DeploymentState';
    $Self->{Translation}->{'Duplicate'} = 'Dupliceren';
    $Self->{Translation}->{'Dynamic field event module that marks config item definitions as out of sync, if containing dynamic fields change.'} =
        'Dynamische veld event module die config item definities markeert als niet gesynchroniseerd, als de dynamische velden die het bevat veranderen.';
    $Self->{Translation}->{'Dynamic fields shown in the additional ITSM field screen of the agent interface.'} =
        'Dynamische velden die worden weergegeven in het extra ITSM-veldscherm van de agentinterface.';
    $Self->{Translation}->{'Dynamic fields shown in the config item overview screen of the customer interface.'} =
        'Dynamische velden die worden weergegeven in het scherm Config itemoverzicht van de klanteninterface.';
    $Self->{Translation}->{'Dynamic fields shown in the config item search screen of the agent interface.'} =
        'Dynamische velden die worden weergegeven in het zoekscherm voor config items van de agentinterface.';
    $Self->{Translation}->{'Enables configuration item bulk action feature for the agent frontend to work on more than one configuration item at a time.'} =
        'Maakt bulkactie voor configuratie-items mogelijk, zodat de agent frontend aan meer dan één configuratie-item tegelijk kan werken.';
    $Self->{Translation}->{'Enables configuration item bulk action feature only for the listed groups.'} =
        'Schakelt de functie bulkactie voor configuratie-items alleen in voor de vermelde groepen.';
    $Self->{Translation}->{'Enables/disables the functionality to check ITSM onfiguration items for unique names. Before enabling this option you should check your system for already existing config items with duplicate names. You can do this with the console command Admin::ITSM::ConfigItem::ListDuplicates.'} =
        'Schakelt de functionaliteit in of uit om ITSM onfiguratie items te controleren op unieke namen. Voordat je deze optie inschakelt, moet je je systeem controleren op bestaande configuratie-items met dubbele namen. Je kunt dit doen met het console commando Admin::ITSM::ConfigItem::ListDuplicates.';
    $Self->{Translation}->{'Event module to set configitem-status on ticket-configitem-link.'} =
        'Gebeurtenismodule om configitem-status in te stellen op ticket-configitem-link.';
    $Self->{Translation}->{'Fields of the configuration item index, used for the fulltext search. Fields are also stored, but are not mandatory for the overall functionality. Inclusion of attachments can be disabled by setting the entry to 0 or deleting it.'} =
        'Velden van de configuratie-itemindex, gebruikt voor het zoeken in de volledige tekst. Velden worden ook opgeslagen, maar zijn niet verplicht voor de algemene functionaliteit. Het opnemen van bijlagen kan worden uitgeschakeld door het item op 0 te zetten of te verwijderen.';
    $Self->{Translation}->{'Fields stored in the configuration item index which are used for other things besides fulltext searches. For the complete functionality all fields are mandatory.'} =
        'Velden die zijn opgeslagen in de index van het configuratie-item en die worden gebruikt voor andere dingen dan zoeken in de volledige tekst. Voor de volledige functionaliteit zijn alle velden verplicht.';
    $Self->{Translation}->{'For every webservice (key) an array of classes (value) can be defined on which the import is restricted. For all chosen classes, or all existing classes the identifying attributes will have to be chosen in the invoker config.'} =
        'Voor elke webservice (key) kan een array van klassen (value) worden gedefinieerd waarop de import wordt beperkt. Voor alle gekozen klassen, of alle bestaande klassen moeten de identificerende attributen worden gekozen in de config van de invoker.';
    $Self->{Translation}->{'GenericInterface module registration for the ConfigItemCreate invoker layer.'} =
        '';
    $Self->{Translation}->{'GenericInterface module registration for the ConfigItemFetch invoker layer.'} =
        'GenericInterface moduleregistratie voor de ConfigItemFetch invoker laag.';
    $Self->{Translation}->{'GenericInterface module registration for the ConfigItemUpdate invoker layer.'} =
        '';
    $Self->{Translation}->{'ITSM ConfigItem'} = 'ITSM ConfigItem';
    $Self->{Translation}->{'ITSM config item overview.'} = 'Overzicht van ITSM-configuratie-items.';
    $Self->{Translation}->{'InciState'} = 'InciState';
    $Self->{Translation}->{'IncidentState'} = 'IncidentState';
    $Self->{Translation}->{'Includes deployment states in the config item search of the customer interface.'} =
        'Omvat deployment states in het zoeken naar configuratie-items in de klanteninterface.';
    $Self->{Translation}->{'Includes incident states in the config item search of the customer interface.'} =
        'Inclusief incidenttoestanden in het zoeken naar configuraties in de klanteninterface.';
    $Self->{Translation}->{'License accounting configuration item event module.'} = '';
    $Self->{Translation}->{'Maximum number of config items to be displayed in the result of this operation.'} =
        'Maximumaantal configuratie-items dat moet worden weergegeven in het resultaat van deze bewerking.';
    $Self->{Translation}->{'Module to check the group responsible for a class.'} = 'Module om de groep te controleren die verantwoordelijk is voor een klas.';
    $Self->{Translation}->{'Module to check the group responsible for a configuration item.'} =
        'Module om de groep te controleren die verantwoordelijk is voor een configuratie-item.';
    $Self->{Translation}->{'Module to generate ITSM config item statistics.'} = 'Module voor het genereren van ITSM-configuratiestatistieken.';
    $Self->{Translation}->{'Name Module'} = 'Naam Module';
    $Self->{Translation}->{'Number Module'} = 'Nummer Module';
    $Self->{Translation}->{'Number of config items to be displayed in each page of a search result in the agent interface.'} =
        'Aantal configuratie-items dat moet worden weergegeven op elke pagina van een zoekresultaat in de agentinterface.';
    $Self->{Translation}->{'Number of config items to be displayed in each page of a search result in the customer interface.'} =
        'Aantal configuratie-items dat moet worden weergegeven op elke pagina van een zoekresultaat in de klanteninterface.';
    $Self->{Translation}->{'Objects to search for, how many entries and which attributs to show. ConfigItem attributes have to explicitly be stored via Elasticsearch.'} =
        'Objecten waarnaar gezocht moet worden, hoeveel items en welke attributen getoond moeten worden. ConfigItem-attributen moeten expliciet worden opgeslagen via Elasticsearch.';
    $Self->{Translation}->{'Overview.'} = 'Overzicht.';
    $Self->{Translation}->{'Parameters for the categories for config item classes in the preferences view of the agent interface.'} =
        'Parameters voor de categorieën voor config item klassen in de voorkeuren weergave van de agent interface.';
    $Self->{Translation}->{'Parameters for the column filters of the small config item overview. Please note: setting \'Active\' to 0 will only prevent agents from editing settings of this group in their personal preferences, but will still allow administrators to edit the settings of another user\'s behalf. Use \'PreferenceGroup\' to control in which area these settings should be shown in the user interface.'} =
        'Parameters voor de kolomfilters van het kleine configuratie-itemoverzicht. Let op: als je \'Actief\' op 0 zet, kunnen agents alleen de instellingen van deze groep niet bewerken in hun persoonlijke voorkeuren, maar kunnen beheerders wel de instellingen van een andere gebruiker bewerken. Gebruik \'PreferenceGroup\' om te bepalen in welk gebied deze instellingen moeten worden weergegeven in de gebruikersinterface.';
    $Self->{Translation}->{'Parameters for the dashboard backend of the customer company config item overview of the agent interface . "Limit" is the number of entries per config item class shown by default. "Group" is used to restrict the access to the plugin (e. g. Group: admin;group1;group2;). "Default" determines if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" is the cache time in minutes for the plugin. "ConfigItemKey" is used to specify which reference field is used for a ConfigItem class (Key=Class, Value=DynamicFieldName).'} =
        '';
    $Self->{Translation}->{'Parameters for the dashboard backend of the customer company config item overview of the agent interface . "Limit" is the number of entries shown by default. "Group" is used to restrict the access to the plugin (e. g. Group: admin;group1;group2;). "Default" determines if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" is the cache time in minutes for the plugin. "ConfigItemKey" is used to specify which reference field is used for a ConfigItem class (Key=Class, Value=DynamicFieldName).'} =
        '';
    $Self->{Translation}->{'Parameters for the deployment states color in the preferences view of the agent interface.'} =
        'Parameters voor de inzetstatussen kleuren in de voorkeurenweergave van de agentinterface.';
    $Self->{Translation}->{'Parameters for the deployment states in the preferences view of the agent interface.'} =
        'Parameters voor de inzetstatussen in de voorkeurenweergave van de agentinterface.';
    $Self->{Translation}->{'Parameters for the example permission groups of the general catalog attributes.'} =
        'Parameters voor de voorbeeld perimssiegroepen van de algemene catalog attributen.';
    $Self->{Translation}->{'Parameters for the name module for config item classes in the preferences view of the agent interface.'} =
        'Parameters voor de naammodule voor config item klassen in de voorkeurenweergave van de agent interface.';
    $Self->{Translation}->{'Parameters for the number module for config item classes in the preferences view of the agent interface.'} =
        'Parameters voor de nummermodule voor config itemklassen in de voorkeurenweergave van de agentinterface.';
    $Self->{Translation}->{'Parameters for the pages (in which the configuration items are shown).'} =
        'Parameters voor de pagina\'s (waarop de configuratie-items worden weergegeven).';
    $Self->{Translation}->{'Parameters for the version string module for config item classes in the preferences view of the agent interface.'} =
        'Parameters voor de versie string module voor config item klassen in de voorkeuren weergave van de agent interface.';
    $Self->{Translation}->{'Parameters for the version string template toolkit module for config item classes in the preferences view of the agent interface.'} =
        'Parameters voor de versie string template toolkit module voor config item klassen in de voorkeuren weergave van de agent interface.';
    $Self->{Translation}->{'Parameters for the version trigger for config item classes in the preferences view of the agent interface.'} =
        'Parameters voor de versieactivering voor config itemklassen in de voorkeurenweergave van de agentinterface.';
    $Self->{Translation}->{'Performs the configured action for each event (as an Invoker) for each configured Webservice.'} =
        'Voert de geconfigureerde actie uit voor elke gebeurtenis (als Invoker) voor elke geconfigureerde webservice.';
    $Self->{Translation}->{'Permission Group'} = 'Permissie groep';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item attachment action in the agent interface.'} =
        'Vereiste machtigingen om de ITSM configuratie item attachment actie te gebruiken in de agent interface.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item screen in the agent interface.'} =
        'Vereiste machtigingen om het ITSM-configuratie-item scherm in de agent interface te gebruiken.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item search screen in the agent interface.'} =
        'Vereiste machtigingen om het zoekscherm voor ITSM-configuratie-items in de agentinterface te gebruiken.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item search screen in the customer interface.'} =
        'Vereiste machtigingen om het zoekscherm voor ITSM-configuratie-items in de klanteninterface te gebruiken.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item tree view screen in the agent interface.'} =
        'Vereiste machtigingen om het ITSM-configuratie item boomstructuur scherm te gebruiken in de agent interface.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item zoom screen in the agent interface.'} =
        'Vereiste machtigingen om het ITSM-configuratie item zoomscherm te gebruiken in de agent interface.';
    $Self->{Translation}->{'Required permissions to use the add ITSM configuration item screen in the agent interface.'} =
        'Vereiste machtigingen om het scherm ITSM-configuratie-item toevoegen in de agentinterface te gebruiken.';
    $Self->{Translation}->{'Required permissions to use the bulk ITSM configuration item screen in the agent interface.'} =
        'Vereiste machtigingen om het bulk ITSM-configuratie-item scherm in de agent interface te gebruiken.';
    $Self->{Translation}->{'Required permissions to use the edit ITSM configuration item screen in the agent interface.'} =
        'Vereiste machtigingen om het scherm ITSM-configuratie-item bewerken in de agentinterface te gebruiken.';
    $Self->{Translation}->{'Required permissions to use the history ITSM configuration item screen in the agent interface.'} =
        'Vereiste machtigingen om het ITSM-configuratie-item geschiedenis scherm in de agent interface te gebruiken.';
    $Self->{Translation}->{'Required permissions to use the print ITSM configuration item screen in the agent interface.'} =
        'Vereiste machtigingen om het scherm met ITSM-configuratie-items afdrukken te gebruiken in de agentinterface.';
    $Self->{Translation}->{'Required privileges to delete config items.'} = 'Vereiste privileges om config items te verwijderen.';
    $Self->{Translation}->{'Search config items.'} = 'Configuratie-items zoeken.';
    $Self->{Translation}->{'Set the incident state of a CI automatically when a Ticket is Linked to a CI.'} =
        'Stel de incidentstatus van een CI automatisch in wanneer een ticket is gekoppeld aan een CI.';
    $Self->{Translation}->{'Sets the deployment state in the configuration item bulk screen of the agent interface.'} =
        'Stelt de uitrolstatus in het bulkscherm voor configuratie-items van de agentinterface in.';
    $Self->{Translation}->{'Sets the incident state in the configuration item bulk screen of the agent interface.'} =
        'Stelt de incidentstatus in in het bulkscherm voor configuratie-items van de agentinterface.';
    $Self->{Translation}->{'Shows a link in the menu that allows linking a configuration item with another object in the config item zoom view of the agent interface.'} =
        'Toont een link in het menu waarmee een configuratie-item kan worden gekoppeld aan een ander object in de zoomweergave van het configuratie-item in de agentinterface.';
    $Self->{Translation}->{'Shows a link in the menu to access the history of a configuration item in the configuration item overview of the agent interface.'} =
        'Toont een link in het menu voor toegang tot de geschiedenis van een configuratie-item in het configuratie-itemoverzicht van de agent interface.';
    $Self->{Translation}->{'Shows a link in the menu to access the history of a configuration item in the its zoom view of the agent interface.'} =
        'Toont een link in het menu voor toegang tot de geschiedenis van een configuratie-item in de zoomweergave van de agentinterface.';
    $Self->{Translation}->{'Shows a link in the menu to delete a configuration item in its zoom view of the agent interface.'} =
        'Toont een link in het menu om een configuratie-item te verwijderen in de zoomweergave van de agentinterface.';
    $Self->{Translation}->{'Shows a link in the menu to display the configuration item links as a Tree View.'} =
        'Toont een link in het menu om de links naar configuratie-items weer te geven als een boomstructuur.';
    $Self->{Translation}->{'Shows a link in the menu to duplicate a configuration item in the configuration item overview of the agent interface.'} =
        'Toont een link in het menu om een configuratie item te dupliceren in het configuratie item overzicht van de agent interface.';
    $Self->{Translation}->{'Shows a link in the menu to duplicate a configuration item in the its zoom view of the agent interface.'} =
        'Toont een link in het menu om een configuratie item te dupliceren in de zoom weergave van de agent interface.';
    $Self->{Translation}->{'Shows a link in the menu to edit a configuration item in the its zoom view of the agent interface.'} =
        'Toont een link in het menu om een configuratie-item te bewerken in de zoomweergave van de agentinterface.';
    $Self->{Translation}->{'Shows a link in the menu to go back in the configuration item zoom view of the agent interface.'} =
        'Toont een link in het menu om terug te gaan in de configuratie item zoom weergave van de agent interface.';
    $Self->{Translation}->{'Shows a link in the menu to print a configuration item in the its zoom view of the agent interface.'} =
        'Toont een link in het menu om een configuratie-item af te drukken in de zoomweergave van de agentinterface.';
    $Self->{Translation}->{'Shows a link in the menu to zoom into a configuration item in the configuration item overview of the agent interface.'} =
        'Toont een link in het menu om in te zoomen op een configuratie-item in het configuratie-itemoverzicht van de agent interface.';
    $Self->{Translation}->{'Shows the config item history (reverse ordered) in the agent interface.'} =
        'Toont de config item geschiedenis (omgekeerd geordend) in de agent interface.';
    $Self->{Translation}->{'The default category which is shown, if none is selected.'} = 'De standaardcategorie die wordt weergegeven als er geen is geselecteerd.';
    $Self->{Translation}->{'The identifier for a configuration item, e.g. ConfigItem#, MyConfigItem#. The default is ConfigItem#.'} =
        'De identifier voor een configuratie-item, bijv. ConfigItem#, MyConfigItem#. De standaardwaarde is ConfigItem#.';
    $Self->{Translation}->{'Triggers ConfigItemFetch invoker automatically.'} = 'Triggert automatisch ConfigItemFetch invoker.';
    $Self->{Translation}->{'Version String Expression'} = 'Versie String Uitdrukking';
    $Self->{Translation}->{'Version String Module'} = 'Versie String Module';
    $Self->{Translation}->{'Version Trigger'} = 'Versie trekker';
    $Self->{Translation}->{'Whether fields should be automatically filled (1), and in that case also be hidden from ticket formulars (2).'} =
        '';
    $Self->{Translation}->{'Whether the execution of ConfigItemACL can be avoided by checking cached field dependencies. This can improve loading times of formulars, but has to be disabled, if ACLModules are to be used for ITSMConfigItem- and Form-ReturnTypes.'} =
        'Of het uitvoeren van ConfigItemACL vermeden kan worden door veldafhankelijkheden in de cache te controleren. Dit kan de laadtijd van formulieren verbeteren, maar moet uitgeschakeld worden als ACLModules gebruikt moeten worden voor ITSMConfigItem- en Form-ReturnTypes.';
    $Self->{Translation}->{'Which general information is shown in the header.'} = 'Welke algemene informatie wordt weergegeven in de koptekst.';
    $Self->{Translation}->{'class'} = 'klasse';
    $Self->{Translation}->{'global'} = 'wereldwijd';
    $Self->{Translation}->{'postproductive'} = 'postproductief';
    $Self->{Translation}->{'preproductive'} = 'preproductief';
    $Self->{Translation}->{'productive'} = 'productief';

    # Ready to adopt classes: IT-Servicemanagement-11_0_3
    $Self->{Translation}->{'10U: 17.5 inches (44.45 cm)'} = '10U: 17,5 inch (44,45 cm)';
    $Self->{Translation}->{'12U: 21 inches (53.34 cm)'} = '12U: 53,34 cm (21 inch)';
    $Self->{Translation}->{'15U: 26.25 inches (66.68 cm)'} = '15U: 26,25 inch (66,68 cm)';
    $Self->{Translation}->{'18U: 31.5 inches (80.01 cm)'} = '18U: 31,5 inch (80,01 cm)';
    $Self->{Translation}->{'19-inch Rack'} = '19-inch rek';
    $Self->{Translation}->{'1U: 1.75 inches (4.45 cm)'} = '1U: 4,45 cm (1,75 inch)';
    $Self->{Translation}->{'20U: 35 inches (88.9 cm)'} = '20U: 88,9 cm (35 inch)';
    $Self->{Translation}->{'21-inch Rack'} = '21-inch rek';
    $Self->{Translation}->{'22U: 38.5 inches (97.79 cm)'} = '22U: 38,5 inch (97,79 cm)';
    $Self->{Translation}->{'23-inch Rack'} = '23-inch rek';
    $Self->{Translation}->{'23.6 inches (600 mm)'} = '23,6 inch (600 mm)';
    $Self->{Translation}->{'24U: 42 inches (106.68 cm)'} = '24U: 42 inch (106,68 cm)';
    $Self->{Translation}->{'27U: 47.25 inches (120.02 cm)'} = '27U: 47,25 inch (120,02 cm)';
    $Self->{Translation}->{'2U: 3.5 inches (8.89 cm)'} = '2U: 3,5 inch (8,89 cm)';
    $Self->{Translation}->{'30U: 52.5 inches (133.35 cm)'} = '30U: 52,5 inch (133,35 cm)';
    $Self->{Translation}->{'31.5 inches (800 mm)'} = '31,5 inch (800 mm)';
    $Self->{Translation}->{'33U: 57.75 inches (146.68 cm)'} = '33U: 57,75 inch (146,68 cm)';
    $Self->{Translation}->{'35.4 inches (900 mm)'} = '35,4 inch (900 mm)';
    $Self->{Translation}->{'36U: 63 inches (160.02 cm)'} = '36U: 63 inch (160,02 cm)';
    $Self->{Translation}->{'39.4 inches (1000 mm)'} = '39,4 inch (1000 mm)';
    $Self->{Translation}->{'39U: 68.25 inches (173.35 cm)'} = '39U: 173,35 cm (68,25 inch)';
    $Self->{Translation}->{'3U: 5.25 inches (13.34 cm)'} = '3U: 13,34 cm (5,25 inch)';
    $Self->{Translation}->{'42U: 73.5 inches (186.69 cm)'} = '42U: 73,5 inch (186,69 cm)';
    $Self->{Translation}->{'43.3 inches (1100 mm):'} = '43,3 inch (1100 mm):';
    $Self->{Translation}->{'45U: 78.75 inches (200.02 cm)'} = '45U: 200,02 cm (78,75 inch)';
    $Self->{Translation}->{'47.2 inches (1200 mm)'} = '47,2 inch (1200 mm)';
    $Self->{Translation}->{'48U: 84 inches (213.36 cm)'} = '48U: 213,36 cm (84 inch)';
    $Self->{Translation}->{'4U: 7 inches (17.78 cm)'} = '4U: 7 inch (17,78 cm)';
    $Self->{Translation}->{'5U: 8.75 inches (22.23 cm)'} = '5U: 8,75 inch (22,23 cm)';
    $Self->{Translation}->{'6U: 10.5 inches (26.67 cm)'} = '6U: 10,5 inch (26,67 cm)';
    $Self->{Translation}->{'7U: 12.25 inches (31.12 cm)'} = '7U: 12,25 inch (31,12 cm)';
    $Self->{Translation}->{'8U: 14 inches (35.56 cm)'} = '8U: 14 inch (35,56 cm)';
    $Self->{Translation}->{'9U: 15.75 inches (40.01 cm)'} = '9U: 15,75 inch (40,01 cm)';
    $Self->{Translation}->{'AGPL (Affero General Public License)'} = '';
    $Self->{Translation}->{'Accounting'} = 'Boekhouding';
    $Self->{Translation}->{'Accounting Information'} = '';
    $Self->{Translation}->{'Address Allocation'} = 'Adrestoewijzing';
    $Self->{Translation}->{'Administrator'} = 'Beheerder';
    $Self->{Translation}->{'Analog Phone'} = 'Analoge telefoon';
    $Self->{Translation}->{'Apache Lizenz'} = '';
    $Self->{Translation}->{'Appliance Type'} = 'Type apparaat';
    $Self->{Translation}->{'BSD Lizenz (Berkeley Software Distribution License)'} = '';
    $Self->{Translation}->{'Battery Capacity (Ah)'} = 'Accucapaciteit (Ah)';
    $Self->{Translation}->{'Battery Type'} = 'Batterijtype';
    $Self->{Translation}->{'Building'} = 'Gebouw';
    $Self->{Translation}->{'Bus Interface'} = 'Businterface';
    $Self->{Translation}->{'CC0 (Creative Commons Zero)'} = '';
    $Self->{Translation}->{'CIDR'} = 'CIDR';
    $Self->{Translation}->{'CPU'} = 'CPU';
    $Self->{Translation}->{'CPU Class'} = 'CPU-klasse';
    $Self->{Translation}->{'Capacity (GB)'} = 'Capaciteit (GB)';
    $Self->{Translation}->{'Capacity per graphics card'} = 'Capaciteit per grafische kaart';
    $Self->{Translation}->{'Card Number'} = 'Kaartnummer';
    $Self->{Translation}->{'Card Reader'} = 'Kaartlezer';
    $Self->{Translation}->{'Card Type'} = 'Kaarttype';
    $Self->{Translation}->{'Client Certificates'} = 'Klantcertificaten';
    $Self->{Translation}->{'Client Software'} = 'Software voor klanten';
    $Self->{Translation}->{'Client category'} = 'Categorie klanten';
    $Self->{Translation}->{'Clockrate'} = 'Kloksnelheid';
    $Self->{Translation}->{'Clockspeed'} = 'Kloksnelheid';
    $Self->{Translation}->{'Code Signing Certificates'} = 'Code ondertekenende certificaten';
    $Self->{Translation}->{'Conference Phone'} = 'Conferentietelefoon';
    $Self->{Translation}->{'Consulting Agreement'} = 'Adviesovereenkomst';
    $Self->{Translation}->{'Contact'} = 'Neem contact op met';
    $Self->{Translation}->{'Contact Distributor'} = 'Neem contact op met distributeur';
    $Self->{Translation}->{'Container Management'} = 'Beheer van containers';
    $Self->{Translation}->{'Contract'} = 'Contract';
    $Self->{Translation}->{'Contract Type'} = 'Type contract';
    $Self->{Translation}->{'Contract period from'} = 'Contractperiode van';
    $Self->{Translation}->{'Contract period until'} = 'Contractperiode tot';
    $Self->{Translation}->{'Cordless Phone (DECT Phone)'} = 'Draadloze telefoon (DECT-telefoon)';
    $Self->{Translation}->{'Cost unit'} = 'Kosteneenheid';
    $Self->{Translation}->{'Count of licenses'} = 'Aantal licenties';
    $Self->{Translation}->{'Creation Date'} = 'Aanmaakdatum';
    $Self->{Translation}->{'Creative Commons'} = '';
    $Self->{Translation}->{'Custom Rack'} = 'Rek op maat';
    $Self->{Translation}->{'DHCP'} = 'DHCP';
    $Self->{Translation}->{'DHCP Reserved'} = 'DHCP Gereserveerd';
    $Self->{Translation}->{'DNS-Server'} = 'DNS-server';
    $Self->{Translation}->{'DVI'} = 'DVI';
    $Self->{Translation}->{'Date of Invoice'} = 'Datum factuur';
    $Self->{Translation}->{'Date of Order'} = 'Datum bestelling';
    $Self->{Translation}->{'Date of Warranty'} = 'Datum van garantie';
    $Self->{Translation}->{'Date of release'} = 'Datum van uitgave';
    $Self->{Translation}->{'Desktop'} = 'Desktop';
    $Self->{Translation}->{'DisplayPort'} = 'DisplayPort';
    $Self->{Translation}->{'Document Signing Certificates'} = 'Certificaten voor documentondertekening';
    $Self->{Translation}->{'EPL (Eclipse Public License)'} = '';
    $Self->{Translation}->{'ETSI Rack'} = 'ETSI-rek';
    $Self->{Translation}->{'Email Certificates (S/MIME Certificates)'} = 'E-mailcertificaten (S/MIME-certificaten)';
    $Self->{Translation}->{'Embedded SIM (eSIM)'} = '';
    $Self->{Translation}->{'Employment Contract'} = 'Arbeidsovereenkomst';
    $Self->{Translation}->{'End IP Address'} = 'IP-adres einde';
    $Self->{Translation}->{'End of support'} = 'Einde ondersteuning';
    $Self->{Translation}->{'Expiry Date'} = 'Vervaldatum';
    $Self->{Translation}->{'External Hard Drive'} = 'Externe harde schijf';
    $Self->{Translation}->{'Firewall'} = 'Firewall';
    $Self->{Translation}->{'Firmware'} = 'Firmware';
    $Self->{Translation}->{'Flywheel Energy Storage'} = 'Vliegwiel Energieopslag';
    $Self->{Translation}->{'Form Factor'} = 'Vormfactor';
    $Self->{Translation}->{'Franchise Agreement'} = 'Franchiseovereenkomst';
    $Self->{Translation}->{'Freeware'} = 'Freeware';
    $Self->{Translation}->{'GPL (General Public License)'} = '';
    $Self->{Translation}->{'General Information'} = 'Algemene informatie';
    $Self->{Translation}->{'Graphics Cards'} = 'Grafische kaarten';
    $Self->{Translation}->{'Graphics card'} = 'Grafische kaart';
    $Self->{Translation}->{'HDMI'} = 'HDMI';
    $Self->{Translation}->{'Hardware'} = 'Hardware';
    $Self->{Translation}->{'Hardware Model'} = 'Hardwaremodel';
    $Self->{Translation}->{'Hardware Weight'} = 'Gewicht hardware';
    $Self->{Translation}->{'Headset'} = 'Hoofdtelefoon';
    $Self->{Translation}->{'IP Protocol'} = 'IP-protocol';
    $Self->{Translation}->{'Identity and Access Management (IAM)'} = 'Identiteits- en toegangsbeheer (IAM)';
    $Self->{Translation}->{'Inventory Number'} = 'Inventarisnummer';
    $Self->{Translation}->{'Inverstment costs'} = 'Inversteringskosten';
    $Self->{Translation}->{'Invoice Number'} = 'Factuurnummer';
    $Self->{Translation}->{'Keyboard'} = 'Toetsenbord';
    $Self->{Translation}->{'LCD Monitor (Liquid Crystal Display)'} = 'LCD-monitor (vloeibaar-kristalscherm)';
    $Self->{Translation}->{'LED Monitor (Light Emitting Diode)'} = 'LED-monitor (lichtemitterende diode)';
    $Self->{Translation}->{'LGPL (Lesser General Public License)'} = '';
    $Self->{Translation}->{'Landline Phone'} = 'Vaste telefoon';
    $Self->{Translation}->{'Laptop'} = 'Laptop';
    $Self->{Translation}->{'Latitude'} = 'Breedte';
    $Self->{Translation}->{'Layer 1: Physical Layer'} = 'Laag 1: Fysieke laag';
    $Self->{Translation}->{'Layer 2: Data Link Layer'} = 'Laag 2: Datalinklaag';
    $Self->{Translation}->{'Layer 3: Network Layer'} = 'Laag 3: netwerklaag';
    $Self->{Translation}->{'Layer 3: Network Layer (Supernet)'} = 'Laag 3: netwerklaag (Supernet)';
    $Self->{Translation}->{'Layer 4: Transport Layer'} = 'Laag 4: Transportlaag';
    $Self->{Translation}->{'Layer 5: Session Layer'} = 'Laag 5: Sessielaag';
    $Self->{Translation}->{'Layer 6: Presentation Layer'} = 'Laag 6: Presentatielaag';
    $Self->{Translation}->{'Layer 7: Application Layer'} = 'Laag 7: Toepassingslaag';
    $Self->{Translation}->{'Lease Agreement'} = 'Huurovereenkomst';
    $Self->{Translation}->{'License Agreement'} = 'Licentieovereenkomst';
    $Self->{Translation}->{'License Count'} = '';
    $Self->{Translation}->{'License Key'} = 'Licentiesleutel';
    $Self->{Translation}->{'License Type'} = 'Licentie Type';
    $Self->{Translation}->{'License period from'} = 'Licentieperiode van';
    $Self->{Translation}->{'License period until'} = 'Licentieperiode tot';
    $Self->{Translation}->{'Lithium Iron Phosphate (LiFePO4) Battery'} = 'Lithium-ijzerfosfaatbatterij (LiFePO4)';
    $Self->{Translation}->{'Lithium-Ion (Li-ion) Battery'} = 'Lithium-Ion (Li-ion) batterij';
    $Self->{Translation}->{'Loan Agreement'} = 'Leningsovereenkomst';
    $Self->{Translation}->{'Located in'} = 'Gevestigd in';
    $Self->{Translation}->{'Longitude'} = 'Lengte';
    $Self->{Translation}->{'MIT Lizenz'} = '';
    $Self->{Translation}->{'MPL (Mozilla Public License)'} = '';
    $Self->{Translation}->{'Manufacturer'} = 'Fabrikant';
    $Self->{Translation}->{'Maximum Load Capacity (W)'} = 'Maximaal draagvermogen (W)';
    $Self->{Translation}->{'Memory'} = 'Geheugen';
    $Self->{Translation}->{'Memory Type'} = 'Type geheugen';
    $Self->{Translation}->{'Micro SIM'} = '';
    $Self->{Translation}->{'Mini-Rack'} = 'Mini-Rack';
    $Self->{Translation}->{'Mobile Number'} = 'Mobiel nummer';
    $Self->{Translation}->{'Mobile/Embedded'} = 'Mobiel ingebed';
    $Self->{Translation}->{'Model'} = 'Model';
    $Self->{Translation}->{'Model Description'} = 'Model Beschrijving';
    $Self->{Translation}->{'Monitor Resolution'} = 'Monitorresolutie';
    $Self->{Translation}->{'Monitor Size'} = 'Afmeting monitor';
    $Self->{Translation}->{'Mouse'} = 'Muis';
    $Self->{Translation}->{'Nano SIM'} = '';
    $Self->{Translation}->{'Network'} = 'Netwerk';
    $Self->{Translation}->{'Network Info'} = 'Netwerk informatie';
    $Self->{Translation}->{'Network Information'} = 'Netwerkinformatie';
    $Self->{Translation}->{'Network Layer'} = 'Netwerklaag';
    $Self->{Translation}->{'Nickel-Cadmium (NiCd) Battery'} = 'Nikkel-cadmiumbatterij (NiCd)';
    $Self->{Translation}->{'Nickel-Metal Hydride (NiMH) Battery'} = 'Nikkelmetaalhydride (NiMH) batterij';
    $Self->{Translation}->{'Non-Disclosure Agreement (NDA)'} = 'Geheimhoudingsovereenkomst (NDA)';
    $Self->{Translation}->{'Notebook'} = 'Notebook';
    $Self->{Translation}->{'Number of CPUs'} = 'Aantal CPU\'s';
    $Self->{Translation}->{'Number of RAM modules'} = 'Aantal RAM-modules';
    $Self->{Translation}->{'Number of graphics cards'} = 'Aantal grafische kaarten';
    $Self->{Translation}->{'OLED Monitor (Organic Light Emitting Diode)'} = 'OLED-monitor (organische lichtemitterende diode)';
    $Self->{Translation}->{'Operating costs'} = 'Bedrijfskosten';
    $Self->{Translation}->{'Order Number'} = 'Bestelnummer';
    $Self->{Translation}->{'Other'} = 'Overige';
    $Self->{Translation}->{'Outputs'} = 'Uitgangen';
    $Self->{Translation}->{'PIN'} = 'PIN';
    $Self->{Translation}->{'PIN 2'} = 'PIN 2';
    $Self->{Translation}->{'PUK'} = 'PUK';
    $Self->{Translation}->{'PUK 2'} = 'PUK 2';
    $Self->{Translation}->{'Partnership Agreement'} = 'Partnerschapsovereenkomst';
    $Self->{Translation}->{'Perpetual licenses'} = '';
    $Self->{Translation}->{'Phone / VoIP'} = '';
    $Self->{Translation}->{'Phone Number'} = 'Telefoonnummer';
    $Self->{Translation}->{'Phone Type'} = 'Telefoon Type';
    $Self->{Translation}->{'Physical Cores'} = 'Fysieke kernen';
    $Self->{Translation}->{'Power Delivery'} = 'Stroomvoorziening';
    $Self->{Translation}->{'Public Domain'} = '';
    $Self->{Translation}->{'Purchased at'} = 'Gekocht bij';
    $Self->{Translation}->{'Rack Depth'} = 'Diepte rek';
    $Self->{Translation}->{'Rack Units (U)'} = 'Eenheden rek (U)';
    $Self->{Translation}->{'Room'} = 'Kamer';
    $Self->{Translation}->{'SIM Card'} = 'SIM-kaart';
    $Self->{Translation}->{'SSL/TLS Certificates'} = 'SSL/TLS-certificaten';
    $Self->{Translation}->{'Sales Contract'} = 'Verkoopcontract';
    $Self->{Translation}->{'Satellite Phone'} = 'Satelliet telefoon';
    $Self->{Translation}->{'Sealed Lead-Acid (SLA) Battery'} = 'Verzegelde loodzuurbatterij (SLA)';
    $Self->{Translation}->{'Seat licenses'} = '';
    $Self->{Translation}->{'Serialnumber'} = 'Serienummer';
    $Self->{Translation}->{'Server Software'} = 'Server Software';
    $Self->{Translation}->{'Service Agreement'} = 'Serviceovereenkomst';
    $Self->{Translation}->{'Service Tag'} = 'Servicetag';
    $Self->{Translation}->{'Shareware'} = '';
    $Self->{Translation}->{'Socket Type'} = 'Type stopcontact';
    $Self->{Translation}->{'Software'} = 'Software';
    $Self->{Translation}->{'Speakers'} = 'Luidsprekers';
    $Self->{Translation}->{'Standard SIM'} = '';
    $Self->{Translation}->{'Start IP Address'} = 'Start IP-adres';
    $Self->{Translation}->{'Storage'} = 'Opslag';
    $Self->{Translation}->{'Storage Partition'} = 'Opslagpartitie';
    $Self->{Translation}->{'Subscription-based licenses'} = '';
    $Self->{Translation}->{'Subsidiary'} = 'Dochteronderneming';
    $Self->{Translation}->{'Summary'} = 'Samenvatting';
    $Self->{Translation}->{'Thin Client'} = 'Thin Client';
    $Self->{Translation}->{'Threads'} = 'Draden';
    $Self->{Translation}->{'Thunderbolt'} = 'Thunderbolt';
    $Self->{Translation}->{'Total Graphics card RAM (GB)'} = 'Totaal RAM-geheugen grafische kaart (GB)';
    $Self->{Translation}->{'Total RAM (GB)'} = 'Totaal RAM-geheugen (GB)';
    $Self->{Translation}->{'Touchscreen Monitor'} = 'Touchscreen monitor';
    $Self->{Translation}->{'Tower'} = 'Toren';
    $Self->{Translation}->{'USB Hub'} = 'USB-hub';
    $Self->{Translation}->{'USB-C'} = 'USB-C';
    $Self->{Translation}->{'VGA'} = 'VGA';
    $Self->{Translation}->{'VPN'} = 'VPN';
    $Self->{Translation}->{'VR Headset'} = 'VR-koptelefoon';
    $Self->{Translation}->{'Virtual Client'} = '';
    $Self->{Translation}->{'VirtualLink'} = 'VirtualLink';
    $Self->{Translation}->{'VoIP Phone'} = 'VoIP-telefoon';
    $Self->{Translation}->{'Volume licenses'} = '';
    $Self->{Translation}->{'Webcam'} = 'Webcam';


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

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

package Kernel::Language::da_ITSMConfigurationManagement;

use strict;
use warnings;
use utf8;

sub Data {
    my $Self = shift;

    # Template: AdminITSMConfigItem
    $Self->{Translation}->{'Config Item Management'} = 'Config Item styring';
    $Self->{Translation}->{'Change class definition'} = 'Skift klassedefinition';
    $Self->{Translation}->{'Change role definition'} = 'Ændring af rolledefinition';
    $Self->{Translation}->{'Ready2Import Class Bundles'} = 'Ready2Import-klassebundter';
    $Self->{Translation}->{'Here you can import Ready2Import class bundles showcasing our most usual config items. Please note that some additional configuration may be required.'} =
        'Her kan du importere Ready2Import-klassebundter, der viser vores mest almindelige konfigurationselementer. Bemærk, at der kan være behov for yderligere konfiguration.';
    $Self->{Translation}->{'Update existing entities'} = 'Opdater eksisterende enheder';
    $Self->{Translation}->{'Import Ready2Adopt class bundles'} = 'Importer Ready2Adopt-klassebundter';
    $Self->{Translation}->{'Config Item Class'} = 'Konfig-elementklasse';
    $Self->{Translation}->{'Config Item Role'} = 'Konfig-elementets rolle';

    # Template: AgentITSMConfigItemAdd
    $Self->{Translation}->{'Config Item'} = 'Config Item';
    $Self->{Translation}->{'Filter for Classes'} = 'ConfigItemID %s findes ikke i databasen!';
    $Self->{Translation}->{'Select a Class from the list to create a new Config Item.'} = 'Vælg en klasse fra listen for at oprette et nyt Config Item.';
    $Self->{Translation}->{'Class'} = 'Klasse';

    # Template: AgentITSMConfigItemBulk
    $Self->{Translation}->{'ITSM ConfigItem Bulk Action'} = 'ITSM ConfigItem Bulk Action';
    $Self->{Translation}->{'Deployment state'} = 'Deployment tilstand';
    $Self->{Translation}->{'Incident state'} = 'Incident tilstand';
    $Self->{Translation}->{'Link to another'} = 'Link til en anden';
    $Self->{Translation}->{'Invalid Configuration Item number!'} = 'Ugyldigt nummer på konfigurationselementet!';
    $Self->{Translation}->{'The number of another Configuration Item to link with.'} = 'Nummeret på et andet konfigurationselement, der skal linkes til.';

    # Template: AgentITSMConfigItemDelete
    $Self->{Translation}->{'Do you really want to delete this config item?'} = 'Vil du virkelig slette dette konfigurationselement?';

    # Template: AgentITSMConfigItemEdit
    $Self->{Translation}->{'The name of this config item'} = 'Navnet på denne Config Item';
    $Self->{Translation}->{'Name is already in use by the ConfigItems with the following Number(s): %s'} =
        'Navnet er allerede i brug af ConfigItems med følgende nummer(e): %s';
    $Self->{Translation}->{'Version Number'} = 'Versionsnummer';
    $Self->{Translation}->{'Version number of this config item'} = 'Versionsnummer for dette konfigurationselement';
    $Self->{Translation}->{'Version Number is already in use by the ConfigItems with the following Number(s): %s'} =
        'Versionsnummeret er allerede i brug af ConfigItems med følgende nummer(e): %s';
    $Self->{Translation}->{'Deployment State'} = 'Deployment tilstand';
    $Self->{Translation}->{'Incident State'} = 'Incident tilstand';

    # Template: AgentITSMConfigItemHistory
    $Self->{Translation}->{'History of Config Item: %s'} = 'Historik for konfigurationselement: %s';
    $Self->{Translation}->{'History Content'} = 'Historik';
    $Self->{Translation}->{'Createtime'} = 'Oprettelsestid';
    $Self->{Translation}->{'Zoom view'} = 'Zoom-visning';

    # Template: AgentITSMConfigItemOverviewNavBar
    $Self->{Translation}->{'Config Items per page'} = 'Konfigurer elementer pr. side';

    # Template: AgentITSMConfigItemOverviewSmall
    $Self->{Translation}->{'No config item data found.'} = 'Ingen data om konfigurationselementet fundet.';
    $Self->{Translation}->{'Select this config item'} = 'Vælg dette konfigurationselement';

    # Template: AgentITSMConfigItemSearch
    $Self->{Translation}->{'Run Search'} = 'Kør søgning';
    $Self->{Translation}->{'Also search in previous versions?'} = 'Søg også i tidligere versioner?';

    # Template: AgentITSMConfigItemTreeView
    $Self->{Translation}->{'TreeView for ConfigItem'} = 'TreeView til ConfigItem';
    $Self->{Translation}->{'Depth Level'} = 'Dybdeniveau';
    $Self->{Translation}->{'Zoom In/Out'} = 'Zoom ind/ud';
    $Self->{Translation}->{'Max links level reached for ConfigItem!'} = 'Maks. linkniveau nået for ConfigItem!';

    # Template: AgentITSMConfigItemZoom
    $Self->{Translation}->{'Configuration Item'} = 'Konfigurationselement';
    $Self->{Translation}->{'Configuration Item Information'} = 'Information om konfigurationselementer';
    $Self->{Translation}->{'Current Deployment State'} = 'Nuværende deployment status';
    $Self->{Translation}->{'Current Incident State'} = 'Nuværende Incident tilstand';
    $Self->{Translation}->{'Last changed'} = 'Sidst ændret';
    $Self->{Translation}->{'Last changed by'} = 'Sidst ændret af';

    # Template: CustomerITSMConfigItem
    $Self->{Translation}->{'Your ConfigItems'} = 'Dine ConfigItems';

    # Template: CustomerITSMConfigItemSearch
    $Self->{Translation}->{'ConfigItem Search'} = 'ConfigItem-søgning';

    # Template: AdminACL
    $Self->{Translation}->{'Object Type'} = 'Objekttype';

    # JS Template: ClassImportConfirm
    $Self->{Translation}->{'The following classes will be imported'} = 'Følgende klasser vil blive importeret';
    $Self->{Translation}->{'The following roles will be imported'} = 'Følgende roller vil blive importeret';
    $Self->{Translation}->{'Note that also corresponding dynamic fields and GeneralCatalog classes will be created and there is no automatic removal.'} =
        'Bemærk, at der også oprettes tilsvarende dynamiske felter og GeneralCatalog-klasser, og at der ikke sker nogen automatisk fjernelse.';
    $Self->{Translation}->{'Do you want to proceed?'} = 'Vil du fortsætte?';

    # Perl Module: Kernel/Modules/AdminITSMConfigItem.pm
    $Self->{Translation}->{'Need ExampleClasses!'} = 'Brug for eksempelklasser!';
    $Self->{Translation}->{'Definition is no valid YAML hash.'} = 'Definitionen er ikke en gyldig YAML-hash.';

    # Perl Module: Kernel/Modules/AgentITSMConfigItem.pm
    $Self->{Translation}->{'Overview: ITSM ConfigItem'} = 'ITSM ConfigItem Bulk Action';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemBulk.pm
    $Self->{Translation}->{'No ConfigItemID is given!'} = 'Der er ikke angivet noget ConfigItemID!';
    $Self->{Translation}->{'You need at least one selected Configuration Item!'} = 'Du skal bruge mindst ét valgt konfigurationselement!';
    $Self->{Translation}->{'You don\'t have write access to this configuration item: %s.'} =
        'Du har ikke skriveadgang til dette konfigurationselement: %s.';
    $Self->{Translation}->{'No definition was defined for class %s!'} = 'Der blev ikke defineret nogen definition for klassen %s!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemDelete.pm
    $Self->{Translation}->{'Config item "%s" not found in database!'} = 'Konfig-elementet "%s" blev ikke fundet i databasen!';
    $Self->{Translation}->{'Was not able to delete the configitem ID %s!'} = 'Definerer antallet af rækker for CI-definitionseditoren i administrationsgrænsefladen.';
    $Self->{Translation}->{'No version found for ConfigItemID %s!'} = 'Ingen version fundet for ConfigItemID %s!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemEdit.pm
    $Self->{Translation}->{'No ConfigItemID, DuplicateID or ClassID is given!'} = 'Der er ikke angivet noget ConfigItemID, DuplicateID eller ClassID!';
    $Self->{Translation}->{'No access is given!'} = 'Der gives ingen adgang!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemHistory.pm
    $Self->{Translation}->{'Can\'t show history, no ConfigItemID is given!'} = 'Kan ikke vise historik, da der ikke er angivet noget ConfigItemID!';
    $Self->{Translation}->{'Can\'t show history, no access rights given!'} = 'Kan ikke vise historik, ingen adgangsrettigheder givet!';
    $Self->{Translation}->{'New ConfigItem (ID=%s)'} = 'Nyt ConfigItem (ID=%s)';
    $Self->{Translation}->{'New version (ID=%s)'} = 'Ny version (ID=%s)';
    $Self->{Translation}->{'Deployment state updated (new=%s, old=%s)'} = 'Implementeringsstatus opdateret (ny=%s, gammel=%s)';
    $Self->{Translation}->{'Incident state updated (new=%s, old=%s)'} = 'Hændelsesstatus opdateret (ny=%s, gammel=%s)';
    $Self->{Translation}->{'ConfigItem (ID=%s) deleted'} = 'ConfigItem (ID=%s) slettet';
    $Self->{Translation}->{'Link to %s (type=%s) added'} = 'Link til %s (type=%s) tilføjet';
    $Self->{Translation}->{'Link to %s (type=%s) deleted'} = 'Link til %s (type=%s) slettet';
    $Self->{Translation}->{'ConfigItem definition updated (ID=%s)'} = 'ConfigItem-definition opdateret (ID=%s)';
    $Self->{Translation}->{'Name updated (new=%s, old=%s)'} = 'Navn opdateret (nyt=%s, gammelt=%s)';
    $Self->{Translation}->{'Attribute %s updated from "%s" to "%s"'} = 'Attribut %s opdateret fra "%s" til "%s"';
    $Self->{Translation}->{'Version %s deleted'} = 'Version %s slettet';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemPrint.pm
    $Self->{Translation}->{'No ConfigItemID or VersionID is given!'} = 'Der er ikke angivet noget ConfigItemID eller VersionID!';
    $Self->{Translation}->{'Can\'t show config item, no access rights given!'} = 'Kan ikke vise konfigurationselement, ingen adgangsrettigheder givet!';
    $Self->{Translation}->{'ConfigItemID %s not found in database!'} = 'ConfigItemID %s findes ikke i databasen!';
    $Self->{Translation}->{'ConfigItem'} = 'KonfigItem';
    $Self->{Translation}->{'printed by %s at %s'} = 'udskrevet af %s på %s';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemSearch.pm
    $Self->{Translation}->{'Invalid ClassID!'} = 'Ugyldigt klasse-ID!';
    $Self->{Translation}->{'No ClassID is given!'} = 'Der er ikke angivet noget ClassID!';
    $Self->{Translation}->{'No access rights for this class given!'} = 'Der er ikke givet adgangsrettigheder til denne klasse!';
    $Self->{Translation}->{'No Result!'} = 'Intet resultat!';
    $Self->{Translation}->{'Config Item Search Results'} = 'Søgeresultater for konfigurationselementer';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemZoom.pm
    $Self->{Translation}->{'Can\'t show item, no access rights for ConfigItem are given!'} =
        'Kan ikke vise element, ingen adgangsrettigheder til ConfigItem er givet!';
    $Self->{Translation}->{'ConfigItem not found!'} = 'ConfigItem ikke fundet!';
    $Self->{Translation}->{'No versions found!'} = 'Ingen versioner fundet!';
    $Self->{Translation}->{'operational'} = 'operationel';
    $Self->{Translation}->{'warning'} = 'advarsel';
    $Self->{Translation}->{'incident'} = 'hændelse';
    $Self->{Translation}->{'The deployment state of this config item'} = 'Deployment tilstand for denne Config item';
    $Self->{Translation}->{'The incident state of this config item'} = 'Incident tilstand for denne Config Item';

    # Perl Module: Kernel/Modules/CustomerITSMConfigItemSearch.pm
    $Self->{Translation}->{'No permission'} = 'Ingen tilladelse';
    $Self->{Translation}->{'Filter invalid!'} = 'Filteret er ugyldigt!';
    $Self->{Translation}->{'Search params invalid!'} = 'Søgeparametre ugyldige!';

    # Perl Module: Kernel/Output/HTML/Dashboard/ITSMConfigItemGeneric.pm
    $Self->{Translation}->{'Shown config items'} = 'Viste konfigurationselementer';
    $Self->{Translation}->{'Deployment State Type'} = 'Type af udrulningstilstand';
    $Self->{Translation}->{'Current Incident State Type'} = 'Nuværende hændelsestilstand Type';

    # Perl Module: Kernel/Output/HTML/ITSMConfigItem/LayoutDate.pm
    $Self->{Translation}->{'Between'} = 'Mellem';

    # Perl Module: Kernel/System/DynamicField/Driver/ConfigItem.pm
    $Self->{Translation}->{'Class restrictions for the config item'} = 'Klassebegrænsninger for konfigurationselementet';
    $Self->{Translation}->{'Select one or more classes to restrict selectable config items'} =
        'Vælg en eller flere klasser for at begrænse valgbare konfigurationselementer';
    $Self->{Translation}->{'Link type'} = 'Link-type';
    $Self->{Translation}->{'Select the link type.'} = 'Vælg linktype.';
    $Self->{Translation}->{'Forwards: Referencing (Source) -> Referenced (Target)'} = 'Fremadrettet: Referencing (Source) -> Referenced (Target)';
    $Self->{Translation}->{'Backwards: Referenced (Source) -> Referencing (Target)'} = 'Baglæns: Referenced (Source) -> Referencing (Target)';
    $Self->{Translation}->{'Link Direction'} = 'Link retning';
    $Self->{Translation}->{'The referencing object is the one containing this dynamic field, the referenced object is the one selected as value of the dynamic field.'} =
        'Det refererende objekt er det, der indeholder dette dynamiske felt, og det refererede objekt er det, der er valgt som værdi for det dynamiske felt.';
    $Self->{Translation}->{'Dynamic (ConfigItem)'} = 'Dynamisk (ConfigItem)';
    $Self->{Translation}->{'Static (Version)'} = 'Statisk (version)';
    $Self->{Translation}->{'Link Referencing Type'} = 'Type af linkhenvisning';
    $Self->{Translation}->{'Whether this link applies to the ConfigItem or the static version of the referencing object. Current Incident State calculation only is performed on dynamic links.'} =
        'Om dette link gælder for ConfigItem eller den statiske version af det refererende objekt. Beregning af aktuel hændelsestilstand udføres kun på dynamiske links.';
    $Self->{Translation}->{'Select the attribute which config items will be searched by'} = 'Vælg den attribut, som konfigurationselementer skal søges efter';

    # Perl Module: Kernel/System/ITSMConfigItem/Definition.pm
    $Self->{Translation}->{'Base structure is not valid. Please provide a hash with data in YAML format.'} =
        'Basisstrukturen er ikke gyldig. Angiv venligst en hash med data i YAML-format.';
    $Self->{Translation}->{'Starting the YAML string with \'---\' is required.'} = 'Det er nødvendigt at starte YAML-strengen med \'---\'.';

    # Perl Module: Kernel/System/ITSMConfigItem/Link.pm
    $Self->{Translation}->{'Could not purge the table configitem_link.'} = 'Kunne ikke rense tabellen configitem_link.';
    $Self->{Translation}->{'No relevant dynamic fields were found'} = 'Der blev ikke fundet nogen relevante dynamiske felter';
    $Self->{Translation}->{'Could not insert into the table configitem_link'} = 'Kunne ikke indsætte i tabellen configitem_link';
    $Self->{Translation}->{'Inserted 0 rows into the table configitem_link'} = 'Indsat 0 rækker i tabellen configitem_link';

    # Perl Module: Kernel/System/ImportExport/ObjectBackend/ITSMConfigItem.pm
    $Self->{Translation}->{'Maximum number of one element'} = 'Maximum antal af et element';
    $Self->{Translation}->{'Empty fields indicate that the current values are kept'} = 'Tomme felter angiver, at de aktuelle værdier bevares';
    $Self->{Translation}->{'Skipped'} = 'Sprang over';

    # Perl Module: Kernel/Modules/AdminDynamicField.pm
    $Self->{Translation}->{'Error synchronizing the definitions. Please check the log.'} = 'Fejl ved synkronisering af definitionerne. Tjek venligst loggen.';
    $Self->{Translation}->{'You have ITSMConfigItem definitions which are not synchronized. Please deploy your ITSMConfigItem dynamic field changes.'} =
        'Du har ITSMConfigItem-definitioner, som ikke er synkroniserede. Implementer venligst dine ITSMConfigItem dynamiske feltændringer.';

    # Database XML / SOPM Definition: ITSMConfigurationManagement.sopm
    $Self->{Translation}->{'Expired'} = 'Udløbet';
    $Self->{Translation}->{'Maintenance'} = 'Vedligeholdelse';
    $Self->{Translation}->{'Pilot'} = 'Pilot';
    $Self->{Translation}->{'Planned'} = 'Planlagt';
    $Self->{Translation}->{'Repair'} = 'Reperation';
    $Self->{Translation}->{'Retired'} = 'Persioneret';
    $Self->{Translation}->{'Review'} = 'Anmeldelse';
    $Self->{Translation}->{'Test/QA'} = 'Test/QA';

    # JS File: ITSM.Admin.ITSMConfigItem
    $Self->{Translation}->{'Overview and Confirmation'} = 'Oversigt og bekræftelse';
    $Self->{Translation}->{'Importing classes/roles and their related fields'} = 'Import af klasser/roller og deres relaterede felter';
    $Self->{Translation}->{'An error occurred during class import.'} = 'Der opstod en fejl under klasseimporten.';

    # SysConfig
    $Self->{Translation}->{'0 - Hidden'} = '0 - Skjult';
    $Self->{Translation}->{'1 - Shown'} = '1 - vist på billedet';
    $Self->{Translation}->{'Allows extended search conditions in config item search of the agent interface. With this feature you can search e. g. config item name with this kind of conditions like "(*key1*&&*key2*)" or "(*key1*||*key2*)".'} =
        'Tillader udvidede søgebetingelser ved søgning efter konfigurationselementer i agentgrænsefladen. Med denne funktion kan du f.eks. søge efter navnet på et konfigurationselement med betingelser som "(*key1*&&*key2*)" eller "(*key1*||*key2*)".';
    $Self->{Translation}->{'Allows extended search conditions in config item search of the customer interface. With this feature you can search e. g. config item name with this kind of conditions like "(*key1*&&*key2*)" or "(*key1*||*key2*)".'} =
        'Tillader udvidede søgebetingelser i søgning efter konfigurationselementer i kundegrænsefladen. Med denne funktion kan du f.eks. søge i navnet på et konfigurationselement med betingelser som "(*key1*&&*key2*)" eller "(*key1*||*key2*)".';
    $Self->{Translation}->{'Assigned CIs'} = 'Tildelte CI\'er';
    $Self->{Translation}->{'At a specific time point create a ticket for config items, if the configured requirements are met. The time point is determined by the value of the field configured under "TimeCIKey" of the ConfigItem, and modified by "TimeModifier". If the latter can be either just a number, or a sign (+/-), a number, and an unit (d/h/m): "7" is equivalent to "+7d". The DynamicField "Ticket->DynamicField" will be used to mark created tickets - it has to exist. The flags \<OTOBO_CONFIGITEM_X\> where X can be NAME, NUMBER and DATE, will be substituted with the respective values in "Ticket->Text".'} =
        '';
    $Self->{Translation}->{'CIs assigned to customer company'} = 'CI\'er tildelt kundevirksomhed';
    $Self->{Translation}->{'CIs assigned to customer user'} = 'CI\'er tildelt kundebruger';
    $Self->{Translation}->{'CMDB Settings'} = 'CMDB-indstillinger';
    $Self->{Translation}->{'Check for a unique name only within the same ConfigItem class (\'class\') or globally (\'global\'), which means every existing ConfigItem is taken into account when looking for duplicates.'} =
        'Tjek kun for et unikt navn inden for den samme ConfigItem-klasse (\'class\') eller globalt (\'global\'), hvilket betyder, at alle eksisterende ConfigItems tages i betragtning, når der ledes efter dubletter.';
    $Self->{Translation}->{'Choose a module to enforce a naming scheme.'} = 'Vælg et modul til at håndhæve et navneskema.';
    $Self->{Translation}->{'Choose a module to enforce a number scheme.'} = 'Vælg et modul til at håndhæve et nummerskema.';
    $Self->{Translation}->{'Choose a module to enforce a version string scheme.'} = 'Vælg et modul til at håndhæve en versionsstrengordning.';
    $Self->{Translation}->{'Choose attributes to trigger the creation of a new version.'} = 'Vælg de attributter, der skal udløse oprettelsen af en ny version.';
    $Self->{Translation}->{'Choose categories to assign to this config item class.'} = 'Vælg kategorier, der skal tildeles denne klasse af konfigurationselementer.';
    $Self->{Translation}->{'Column config item filters for ConfigItem Overview.'} = 'Kolonne-konfigurationselementfiltre til ConfigItem Overview.';
    $Self->{Translation}->{'Columns that can be filtered in the config item overview of the agent interface. Note: Only Config Item attributes and Dynamic Fields (DynamicField_NameX) are allowed.'} =
        'Kolonner, der kan filtreres i oversigten over konfigurationselementer i agentgrænsefladen. Bemærk: Kun Config Item-attributter og dynamiske felter (DynamicField_NameX) er tilladt.';
    $Self->{Translation}->{'Columns that can be filtered in the config item overview of the customer interface. Note: Only Config Item attributes and Dynamic Fields (DynamicField_NameX) are allowed.'} =
        'Kolonner, der kan filtreres i oversigten over konfigurationselementer i kundegrænsefladen. Bemærk: Kun Config Item-attributter og dynamiske felter (DynamicField_NameX) er tilladt.';
    $Self->{Translation}->{'Columns that can be filtered in the config item search result overview of the agent interface. Note: Only Config Item attributes and Dynamic Fields (DynamicField_NameX) are allowed.'} =
        'Kolonner, der kan filtreres i oversigten over søgeresultater for konfigurationselementer i agentgrænsefladen. Bemærk: Kun Config Item-attributter og dynamiske felter (DynamicField_NameX) er tilladt.';
    $Self->{Translation}->{'Config Items'} = 'Konfigurationselementer';
    $Self->{Translation}->{'Config item add.'} = 'Tilføj konfig-element.';
    $Self->{Translation}->{'Config item edit.'} = 'Rediger konfigurationselement.';
    $Self->{Translation}->{'Config item event module that count the licenses for OTOBOCILicenseCount feature.'} =
        '';
    $Self->{Translation}->{'Config item event module that enables logging to history in the agent interface.'} =
        'Config item-hændelsesmodul, der muliggør logning til historik i agentgrænsefladen.';
    $Self->{Translation}->{'Config item event module that updates config items to their current definition.'} =
        'Config item event-modul, der opdaterer config items til deres aktuelle definition.';
    $Self->{Translation}->{'Config item event module that updates the table configitem_ĺink.'} =
        'Config item event-modul, der opdaterer tabellen configitem_ĺink.';
    $Self->{Translation}->{'Config item event module updates the current incident state.'} =
        'Config item event-modulet opdaterer den aktuelle hændelsesstatus.';
    $Self->{Translation}->{'Config item history.'} = 'Konfigurer elementets historik.';
    $Self->{Translation}->{'Config item print.'} = 'Print af konfigurationselementer.';
    $Self->{Translation}->{'Config item zoom.'} = 'Konfigurer elementzoom.';
    $Self->{Translation}->{'ConfigItem Tree View'} = 'ConfigItem-trævisning';
    $Self->{Translation}->{'ConfigItem Version'} = 'ConfigItem Version';
    $Self->{Translation}->{'ConfigItems of the following classes will not be stored on the Elasticsearch server. To apply this to existing CIs, the CI migration has to be run via console, after changing this option.'} =
        'ConfigItems i følgende klasser vil ikke blive gemt på Elasticsearch-serveren. For at anvende dette på eksisterende CI\'er skal CI-migreringen køres via konsollen, efter at denne indstilling er ændret.';
    $Self->{Translation}->{'ConfigItems with the following deployment states will not be stored on the Elasticsearch server. To apply this to existing CIs, the CI migration has to be run via console, after changing this option.'} =
        'ConfigItems med følgende implementeringstilstande vil ikke blive gemt på Elasticsearch-serveren. For at anvende dette på eksisterende CI\'er skal CI-migreringen køres via konsollen, efter at denne indstilling er ændret.';
    $Self->{Translation}->{'Configuration Item Limit'} = 'Grænse for konfigurationselement';
    $Self->{Translation}->{'Configuration Item limit per page.'} = 'Konfiguration Elementgrænse pr. side.';
    $Self->{Translation}->{'Configuration Management Database.'} = 'Database for konfigurationsstyring.';
    $Self->{Translation}->{'Configuration item bulk module.'} = 'Konfigurationselementets bulk-modul.';
    $Self->{Translation}->{'Configuration item search backend router of the agent interface.'} =
        'Konfigurationselement søg backend-router for agentgrænsefladen.';
    $Self->{Translation}->{'Create and manage the definitions for Configuration Items.'} = 'Opret og administrer definitionerne for Configuration Items.';
    $Self->{Translation}->{'Creates Tickets for ConfigItems at specific time points.'} = '';
    $Self->{Translation}->{'Customers can see historic CI versions.'} = 'Kunder kan se historiske CI-versioner.';
    $Self->{Translation}->{'Customers have the possibility to manually switch between historic CI versions.'} =
        'Kunderne har mulighed for manuelt at skifte mellem historiske CI-versioner.';
    $Self->{Translation}->{'Default data to use on attribute for config item search screen. Example: "ITSMConfigItemCreateTimePointFormat=year;ITSMConfigItemCreateTimePointStart=Last;ITSMConfigItemCreateTimePoint=2;".'} =
        'Standarddata, der skal bruges på attributten for skærmbilledet til søgning efter konfigurationselementer. Eksempel: "ITSMConfigItemCreateTimePointFormat=year;ITSMConfigItemCreateTimePointStart=Last;ITSMConfigItemCreateTimePoint=2;".';
    $Self->{Translation}->{'Default data to use on attribute for config item search screen. Example: "ITSMConfigItemCreateTimeStartYear=2010;ITSMConfigItemCreateTimeStartMonth=10;ITSMConfigItemCreateTimeStartDay=4;ITSMConfigItemCreateTimeStopYear=2010;ITSMConfigItemCreateTimeStopMonth=11;ITSMConfigItemCreateTimeStopDay=3;".'} =
        'Standarddata, der skal bruges på attributten for skærmbilledet til søgning efter konfigurationselementer. Eksempel: "ITSMConfigItemCreateTimeStartYear=2010;ITSMConfigItemCreateTimeStartMonth=10;ITSMConfigItemCreateTimeStartDay=4;ITSMConfigItemCreateTimeStopYear=2010;ITSMConfigItemCreateTimeStopMonth=11;ITSMConfigItemCreateTimeStopDay=3;".';
    $Self->{Translation}->{'Define Actions where a settings button is available in the linked objects widget (LinkObject::ViewMode = "complex"). Please note that these Actions must have registered the following JS and CSS files: Core.AllocationList.css, Core.UI.AllocationList.js, Core.UI.Table.Sort.js, Core.Agent.TableFilters.js and Core.Agent.LinkObject.js.'} =
        'Definer handlinger, hvor en indstillingsknap er tilgængelig i de linkede objekters widget (LinkObject::ViewMode = "complex"). Bemærk, at disse handlinger skal have registreret følgende JS- og CSS-filer: Core.AllocationList.css, Core.UI.AllocationList.js, Core.UI.Table.Sort.js, Core.Agent.TableFilters.js og Core.Agent.LinkObject.js.';
    $Self->{Translation}->{'Define a Template::Toolkit scheme for version strings. Only used if Version String Module is set to TemplateToolkit.'} =
        'Definer et Template::Toolkit-skema til versionsstrenge. Bruges kun, hvis Version String Module er sat til TemplateToolkit.';
    $Self->{Translation}->{'Define a set of conditions under which a customer is allowed to see a config item. Conditions can optionally be restricted to certain customer groups. Name is the only mandatory attribute. If no other options are given, all config items will be visible under that category.'} =
        'Definer et sæt betingelser, under hvilke en kunde har lov til at se et konfigurationselement. Betingelserne kan eventuelt begrænses til bestemte kundegrupper. Navn er den eneste obligatoriske attribut. Hvis der ikke er angivet andre muligheder, vil alle konfigurationselementer være synlige under den pågældende kategori.';
    $Self->{Translation}->{'Defines Required permissions to create ITSM configuration items using the Generic Interface.'} =
        'Definerer nødvendige tilladelser til at oprette ITSM-konfigurationselementer ved hjælp af den generiske grænseflade.';
    $Self->{Translation}->{'Defines Required permissions to delete ITSM configuration items using the Generic Interface.'} =
        'Definerer nødvendige tilladelser til at slette ITSM-konfigurationselementer ved hjælp af den generiske grænseflade.';
    $Self->{Translation}->{'Defines Required permissions to get ITSM configuration items using the Generic Interface.'} =
        'Definerer nødvendige tilladelser til at hente ITSM-konfigurationselementer ved hjælp af den generiske grænseflade.';
    $Self->{Translation}->{'Defines Required permissions to search ITSM configuration items using the Generic Interface.'} =
        'Definerer nødvendige tilladelser til at søge i ITSM-konfigurationselementer ved hjælp af den generiske grænseflade.';
    $Self->{Translation}->{'Defines Required permissions to update ITSM configuration items using the Generic Interface.'} =
        'Definerer nødvendige tilladelser til at opdatere ITSM-konfigurationselementer ved hjælp af den generiske grænseflade.';
    $Self->{Translation}->{'Defines an overview module to show the small view of a configuration item list.'} =
        'Definerer et oversigtsmodul til at vise den lille visning af en liste over konfigurationselementer.';
    $Self->{Translation}->{'Defines if the link type labels must be shown in the node connections.'} =
        'Definerer, om linktypeetiketterne skal vises i nodeforbindelserne.';
    $Self->{Translation}->{'Defines regular expressions individually for each ConfigItem class to check the ConfigItem name and to show corresponding error messages.'} =
        'Definerer regulære udtryk individuelt for hver ConfigItem-klasse for at kontrollere ConfigItem-navnet og for at vise tilsvarende fejlmeddelelser.';
    $Self->{Translation}->{'Defines the available columns of CIs in the config item overview depending on the CI class. Each entry must consist of a class name and an array of available fields for the corresponding class. Dynamic field entries have to honor the scheme DynamicField_FieldName.'} =
        'Definerer de tilgængelige kolonner med CI\'er i oversigten over konfigurationselementer afhængigt af CI-klassen. Hver post skal bestå af et klassenavn og et array af tilgængelige felter for den tilsvarende klasse. Dynamiske feltindgange skal overholde skemaet DynamicField_FieldName.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of the agent interface.'} =
        'Definerer standardkonfigurationselementattributten for sortering af konfigurationselementer i søgeresultatet for konfigurationselementer i agentgrænsefladen.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of the customer interface.'} =
        'Definerer standardkonfigurationselementattributten for sortering af konfigurationselementer i søgeresultatet for konfigurationselementer i kundegrænsefladen.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of this operation.'} =
        'Definerer standardkonfigurationselementattributten for sortering af konfigurationselementet i søgeresultatet for denne handling.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the agent interface. Up: oldest on top. Down: latest on top.'} =
        'Definerer standardrækkefølgen for konfigurationselementer i søgeresultatet for konfigurationselementer i agentgrænsefladen. Op: ældste øverst. Ned: nyeste øverst.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the customer interface. Up: oldest on top. Down: latest on top.'} =
        'Definerer standardrækkefølgen for konfigurationselementer i søgeresultatet for konfigurationselementer i kundegrænsefladen. Op: ældste øverst. Ned: nyeste øverst.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the this operation. Up: oldest on top. Down: latest on top.'} =
        'Definerer standardrækkefølgen for konfigurationselementer i søgeresultatet for denne handling. Op: ældste øverst. Ned: nyeste øverst.';
    $Self->{Translation}->{'Defines the default displayed columns of CIs in the config item overview depending on the CI class. Each entry must consist of a class name and an array of available fields for the corresponding class. Dynamic field entries have to honor the scheme DynamicField_FieldName.'} =
        'Definerer de kolonner, der som standard vises for CI\'er i oversigten over konfigurationselementer, afhængigt af CI-klassen. Hver post skal bestå af et klassenavn og et array af tilgængelige felter for den tilsvarende klasse. Dynamiske feltindgange skal overholde skemaet DynamicField_FieldName.';
    $Self->{Translation}->{'Defines the default relations depth to be shown.'} = 'Definerer den standardrelationsdybde, der skal vises.';
    $Self->{Translation}->{'Defines the default shown config item search attribute for config item search screen.'} =
        'Definerer den viste standardattribut for søgning efter konfigurationselementer på skærmen til søgning efter konfigurationselementer.';
    $Self->{Translation}->{'Defines the default shown config item search attribute for config item search screen. Example: "Key" must have the name of the Dynamic Field in this case \'X\', "Content" must have the value of the Dynamic Field depending on the Dynamic Field type,  Text: \'a text\', Dropdown: \'1\', Date/Time: \'Search_DynamicField_XTimeSlotStartYear=1974; Search_DynamicField_XTimeSlotStartMonth=01; Search_DynamicField_XTimeSlotStartDay=26; Search_DynamicField_XTimeSlotStartHour=00; Search_DynamicField_XTimeSlotStartMinute=00; Search_DynamicField_XTimeSlotStartSecond=00; Search_DynamicField_XTimeSlotStopYear=2013; Search_DynamicField_XTimeSlotStopMonth=01; Search_DynamicField_XTimeSlotStopDay=26; Search_DynamicField_XTimeSlotStopHour=23; Search_DynamicField_XTimeSlotStopMinute=59; Search_DynamicField_XTimeSlotStopSecond=59;\' and or \'Search_DynamicField_XTimePointFormat=week; Search_DynamicField_XTimePointStart=Before; Search_DynamicField_XTimePointValue=7\';.'} =
        'Definerer den standard viste søgeattribut for konfigurationselementer på skærmen til søgning efter konfigurationselementer. Eksempel: "Key" skal have navnet på det dynamiske felt, i dette tilfælde \'X\', "Content" skal have værdien af det dynamiske felt afhængigt af den dynamiske felttype, Text: \'a text\', Dropdown: \'1\', Date/Time: \'Search_DynamicField_XTimeSlotStartYear=1974; Search_DynamicField_XTimeSlotStartMonth=01; Search_DynamicField_XTimeSlotStartDay=26; Search_DynamicField_XTimeSlotStartHour=00; Search_DynamicField_XTimeSlotStartMinute=00; Search_DynamicField_XTimeSlotStartSecond=00; Search_DynamicField_XTimeSlotStopYear=2013; Search_DynamicField_XTimeSlotStopMonth=01; Search_DynamicField_XTimeSlotStopDay=26; Search_DynamicField_XTimeSlotStopHour=23; Search_DynamicField_XTimeSlotStopMinute=59; Search_DynamicField_XTimeSlotStopSecond=59;\' og eller \'Search_DynamicField_XTimePointFormat=week; Search_DynamicField_XTimePointStart=Before; Search_DynamicField_XTimePointValue=7\';.';
    $Self->{Translation}->{'Defines the default subobject of the class \'ITSMConfigItem\'.'} =
        'Definerer standardunderobjektet i klassen \'ITSMConfigItem\'.';
    $Self->{Translation}->{'Defines the number of rows for the CI definition editor in the admin interface.'} =
        'Definerer antallet af rækker for CI-definitionseditoren i administrationsgrænsefladen.';
    $Self->{Translation}->{'Defines the order of incident states from high (e.g. cricital) to low (e.g. functional).'} =
        'Definerer rækkefølgen af hændelsestilstande fra høj (f.eks. cricital) til lav (f.eks. funktionel).';
    $Self->{Translation}->{'Defines the relevant deployment states where linked tickets can affect the status of a CI.'} =
        'Definerer de relevante implementeringstilstande, hvor tilknyttede tickets kan påvirke status for et CI.';
    $Self->{Translation}->{'Defines the search limit for the AgentITSMConfigItem screen.'} =
        'Definerer søgegrænsen for skærmbilledet AgentITSMConfigItem.';
    $Self->{Translation}->{'Defines the search limit for the AgentITSMConfigItemSearch screen.'} =
        'Definerer søgegrænsen for skærmbilledet AgentITSMConfigItemSearch.';
    $Self->{Translation}->{'Defines the search limit for the CustomerITSMConfigItem screen.'} =
        'Definerer søgegrænsen for CustomerITSMConfigItem-skærmen.';
    $Self->{Translation}->{'Defines the search limit for the CustomerITSMConfigItemSearch screen.'} =
        'Definerer søgegrænsen for skærmbilledet CustomerITSMConfigItemSearch.';
    $Self->{Translation}->{'Defines the shown columns of CIs in the link table complex view for all CI classes. If there is no entry, then the default columns are shown.'} =
        'ConfigItem (ID=%s) slettet';
    $Self->{Translation}->{'Defines the shown columns of CIs in the link table complex view, depending on the CI class. Each entry must be prefixed with the class name and double colons (i.e. Computer::). There are a few CI-Attributes that common to all CIs (example for the class Computer: Computer::Name, Computer::CurDeplState, Computer::CreateTime). To show individual CI-Attributes as defined in the CI-Definition, the following scheme must be used (example for the class Computer): Computer::HardDisk::1, Computer::HardDisk::1::Capacity::1, Computer::HardDisk::2, Computer::HardDisk::2::Capacity::1. If there is no entry for a CI class, then the default columns are shown.'} =
        'Definerer de viste kolonner af CI\'er i den komplekse visning af linktabellen, afhængigt af CI-klassen. Hver post skal indledes med klassens navn og dobbelt kolon (f.eks. Computer::). Der er nogle få CI-attributter, som er fælles for alle CI\'er (eksempel for klassen Computer: Computer::Name, Computer::CurDeplState, Computer::CreateTime). For at vise individuelle CI-attributter som defineret i CI-definitionen skal følgende skema bruges (eksempel for klassen Computer): Computer::HardDisk::1, Computer::HardDisk::1::Capacity::1, Computer::HardDisk::2, Computer::HardDisk::2::Capacity::1. Hvis der ikke er nogen post for en CI-klasse, vises standardkolonnerne.';
    $Self->{Translation}->{'Defines which items are available for \'Action\' in third level of the ITSM Config Item ACL structure.'} =
        'Definerer, hvilke elementer der er tilgængelige for \'Handling\' på tredje niveau i ITSM Config Item ACL-strukturen.';
    $Self->{Translation}->{'Defines which items are available in first level of the ITSM Config Item ACL structure.'} =
        'Definerer, hvilke elementer der er tilgængelige på første niveau i ITSM Config Item ACL-strukturen.';
    $Self->{Translation}->{'Defines which items are available in second level of the ITSM Config Item ACL structure.'} =
        'Definerer, hvilke elementer der er tilgængelige på andet niveau i ITSM Config Item ACL-strukturen.';
    $Self->{Translation}->{'Defines which type of link (named from the ticket perspective) can affect the status of a linked CI.'} =
        'Definerer, hvilken type link (navngivet fra ticket-perspektivet) der kan påvirke status for et linket CI.';
    $Self->{Translation}->{'Defines which type of ticket can affect the status of a linked CI.'} =
        'Definerer, hvilken type ticket der kan påvirke status for et linket CI.';
    $Self->{Translation}->{'Definition Update'} = 'Opdatering af definition';
    $Self->{Translation}->{'Delete Configuration Item'} = 'Slet konfigurationselement';
    $Self->{Translation}->{'DeplState'} = 'DeplState';
    $Self->{Translation}->{'Deployment State Color'} = 'Farve på implementeringsstatus';
    $Self->{Translation}->{'DeploymentState'} = 'DeploymentState';
    $Self->{Translation}->{'Duplicate'} = 'Dupliker';
    $Self->{Translation}->{'Dynamic field event module that marks config item definitions as out of sync, if containing dynamic fields change.'} =
        'Hændelsesmodul for dynamiske felter, der markerer konfigurationselementdefinitioner som usynkroniserede, hvis de indeholder dynamiske felter, der ændres.';
    $Self->{Translation}->{'Dynamic fields shown in the additional ITSM field screen of the agent interface.'} =
        'Dynamiske felter, der vises i den ekstra ITSM-feltskærm i agentgrænsefladen.';
    $Self->{Translation}->{'Dynamic fields shown in the config item overview screen of the customer interface.'} =
        'Dynamiske felter, der vises i oversigtsskærmen for konfigurationselementer i kundegrænsefladen.';
    $Self->{Translation}->{'Dynamic fields shown in the config item search screen of the agent interface.'} =
        'Dynamiske felter, der vises i skærmbilledet til søgning efter konfigurationselementer i agentgrænsefladen.';
    $Self->{Translation}->{'Enables configuration item bulk action feature for the agent frontend to work on more than one configuration item at a time.'} =
        'Aktiverer funktionen til massehandling af konfigurationselementer, så agentens frontend kan arbejde på mere end ét konfigurationselement ad gangen.';
    $Self->{Translation}->{'Enables configuration item bulk action feature only for the listed groups.'} =
        'Definerer de relevante implementeringstilstande, hvor tilknyttede tickets kan påvirke status for et CI.';
    $Self->{Translation}->{'Enables/disables the functionality to check ITSM onfiguration items for unique names. Before enabling this option you should check your system for already existing config items with duplicate names. You can do this with the console command Admin::ITSM::Configitem::ListDuplicates.'} =
        'Aktiverer/deaktiverer funktionen til at kontrollere ITSM-konfigurationselementer for unikke navne. Før du aktiverer denne mulighed, bør du tjekke dit system for allerede eksisterende konfigurationselementer med duplikatnavne. Det kan du gøre med konsolkommandoen Admin::ITSM::Configitem::ListDuplicates.';
    $Self->{Translation}->{'Event module to set configitem-status on ticket-configitem-link.'} =
        'Hændelsesmodul til at sætte configitem-status på ticket-configitem-link.';
    $Self->{Translation}->{'Fields of the configuration item index, used for the fulltext search. Fields are also stored, but are not mandatory for the overall functionality. Inclusion of attachments can be disabled by setting the entry to 0 or deleting it.'} =
        'Felter i konfigurationselementets indeks, der bruges til fuldtekstsøgning. Felter gemmes også, men er ikke obligatoriske for den overordnede funktionalitet. Inkludering af vedhæftede filer kan deaktiveres ved at sætte posten til 0 eller slette den.';
    $Self->{Translation}->{'Fields stored in the configuration item index which are used for other things besides fulltext searches. For the complete functionality all fields are mandatory.'} =
        'Felter gemt i konfigurationselementets indeks, som bruges til andre ting end fuldtekstsøgning. For at få fuld funktionalitet er alle felter obligatoriske.';
    $Self->{Translation}->{'For every webservice (key) an array of classes (value) can be defined on which the import is restricted. For all chosen classes, or all existing classes the identifying attributes will have to be chosen in the invoker config.'} =
        'For hver webtjeneste (nøgle) kan der defineres et array af klasser (værdi), som importen er begrænset til. For alle valgte klasser eller alle eksisterende klasser skal de identificerende attributter vælges i invoker-konfigurationen.';
    $Self->{Translation}->{'GenericInterface module registration for the ConfigItemFetch invoker layer.'} =
        'Registrering af GenericInterface-modul til ConfigItemFetch-invokatorlaget.';
    $Self->{Translation}->{'ITSM ConfigItem'} = 'ITSM ConfigItem';
    $Self->{Translation}->{'ITSM config item overview.'} = 'Oversigt over ITSM-konfigurationselementer.';
    $Self->{Translation}->{'If this option is activated, linked items are only counted if they belong to one of the listed classes.'} =
        '';
    $Self->{Translation}->{'InciState'} = 'InciState';
    $Self->{Translation}->{'IncidentState'} = 'Hændelsesstatus';
    $Self->{Translation}->{'Includes deployment states in the config item search of the customer interface.'} =
        'Inkluderer implementeringstilstande i søgningen efter konfigurationselementer i kundegrænsefladen.';
    $Self->{Translation}->{'Includes incident states in the config item search of the customer interface.'} =
        'Inkluderer hændelsestilstande i konfigurationselement-søgningen i kundegrænsefladen.';
    $Self->{Translation}->{'Maximum number of config items to be displayed in the result of this operation.'} =
        'Maksimalt antal konfigurationselementer, der skal vises i resultatet af denne handling.';
    $Self->{Translation}->{'Module to check the group responsible for a class.'} = 'Modul til at kontrollere den gruppe, der er ansvarlig for en klasse.';
    $Self->{Translation}->{'Module to check the group responsible for a configuration item.'} =
        'Modul til at kontrollere den gruppe, der er ansvarlig for et konfigurationselement.';
    $Self->{Translation}->{'Module to generate ITSM config item statistics.'} = 'Modul til at generere statistik over ITSM-konfigurationselementer.';
    $Self->{Translation}->{'Name Module'} = 'Navn Modul';
    $Self->{Translation}->{'Number Module'} = 'Nummermodul';
    $Self->{Translation}->{'Number of config items to be displayed in each page of a search result in the agent interface.'} =
        'Antal konfigurationselementer, der skal vises på hver side af et søgeresultat i agentgrænsefladen.';
    $Self->{Translation}->{'Number of config items to be displayed in each page of a search result in the customer interface.'} =
        'Antal konfigurationselementer, der skal vises på hver side af et søgeresultat i kundegrænsefladen.';
    $Self->{Translation}->{'Objects to search for, how many entries and which attributs to show. ConfigItem attributes have to explicitly be stored via Elasticsearch.'} =
        'Objekter, der skal søges efter, hvor mange poster og hvilke attributter, der skal vises. ConfigItem-attributter skal eksplicit gemmes via Elasticsearch.';
    $Self->{Translation}->{'Overview.'} = 'Overblik.';
    $Self->{Translation}->{'Parameters for the categories for config item classes in the preferences view of the agent interface.'} =
        'Parametre for kategorierne for konfigurationselementklasser i præferencevisningen i agentgrænsefladen.';
    $Self->{Translation}->{'Parameters for the column filters of the small config item overview. Please note: setting \'Active\' to 0 will only prevent agents from editing settings of this group in their personal preferences, but will still allow administrators to edit the settings of another user\'s behalf. Use \'PreferenceGroup\' to control in which area these settings should be shown in the user interface.'} =
        'Parametre for kolonnefiltrene i oversigten over små konfigurationselementer. Bemærk: Hvis \'Aktiv\' sættes til 0, forhindrer det kun agenter i at redigere indstillingerne for denne gruppe i deres personlige præferencer, men det giver stadig administratorer mulighed for at redigere indstillingerne på en anden brugers vegne. Brug \'PreferenceGroup\' til at styre, i hvilket område disse indstillinger skal vises i brugergrænsefladen.';
    $Self->{Translation}->{'Parameters for the dashboard backend of the customer company config item overview of the agent interface . "Limit" is the number of entries shown by default. "Group" is used to restrict the access to the plugin (e. g. Group: admin;group1;group2;). "Default" determines if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" is the cache time in minutes for the plugin.'} =
        'Parametre til dashboard-backend for kundevirksomhedens konfigurationselementoversigt over agentgrænsefladen. "Limit" er antallet af poster, der vises som standard. "Group" bruges til at begrænse adgangen til plugin\'et (f.eks. Group: admin;group1;group2;). "Default" bestemmer, om plugin\'et er aktiveret som standard, eller om brugeren skal aktivere det manuelt. "CacheTTLLocal" er cache-tiden i minutter for plugin\'et.';
    $Self->{Translation}->{'Parameters for the deployment states color in the preferences view of the agent interface.'} =
        'Parametre for udrulningstilstandenes farve i præferencevisningen i agentgrænsefladen.';
    $Self->{Translation}->{'Parameters for the deployment states in the preferences view of the agent interface.'} =
        'Parametre for udrulningstilstande i præferencevisningen i agentgrænsefladen.';
    $Self->{Translation}->{'Parameters for the example permission groups of the general catalog attributes.'} =
        'Parametre for eksemplerne på tilladelsesgrupper for de generelle katalogattributter.';
    $Self->{Translation}->{'Parameters for the name module for config item classes in the preferences view of the agent interface.'} =
        'Parametre til navnemodulet for konfigurationselementklasser i præferencevisningen af agentgrænsefladen.';
    $Self->{Translation}->{'Parameters for the number module for config item classes in the preferences view of the agent interface.'} =
        'Parametre for nummermodulet for konfigurationselementklasser i præferencevisningen i agentgrænsefladen.';
    $Self->{Translation}->{'Parameters for the pages (in which the configuration items are shown).'} =
        'Parametre for siderne (hvor konfigurationselementerne vises).';
    $Self->{Translation}->{'Parameters for the version string module for config item classes in the preferences view of the agent interface.'} =
        'Parametre for versionsstrengmodulet for konfigurationselementklasser i præferencevisningen i agentgrænsefladen.';
    $Self->{Translation}->{'Parameters for the version string template toolkit module for config item classes in the preferences view of the agent interface.'} =
        'Parametre for version string template toolkit module for config item classes i præferencevisningen i agentgrænsefladen.';
    $Self->{Translation}->{'Parameters for the version trigger for config item classes in the preferences view of the agent interface.'} =
        'Parametre for versionsudløseren for konfigurationselementklasser i agentgrænsefladens præferencevisning.';
    $Self->{Translation}->{'Performs the configured action for each event (as an Invoker) for each configured Webservice.'} =
        'Udfører den konfigurerede handling for hver begivenhed (som en Invoker) for hver konfigureret webtjeneste.';
    $Self->{Translation}->{'Permission Group'} = 'Tilladelsesgruppe';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item attachment action in the agent interface.'} =
        'Nødvendige tilladelser til at bruge ITSM-konfigurationselementets vedhæftningshandling i agentgrænsefladen.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item screen in the agent interface.'} =
        'Nødvendige tilladelser til at bruge ITSM-konfigurationselementskærmen i agentgrænsefladen.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item search screen in the agent interface.'} =
        'Nødvendige tilladelser til at bruge skærmbilledet til søgning efter ITSM-konfigurationselementer i agentgrænsefladen.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item search screen in the customer interface.'} =
        'Nødvendige tilladelser til at bruge skærmbilledet til søgning efter ITSM-konfigurationselementer i kundegrænsefladen.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item tree view screen in the agent interface.'} =
        'Nødvendige tilladelser til at bruge skærmbilledet med trævisning af ITSM-konfigurationselementer i agentgrænsefladen.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item zoom screen in the agent interface.'} =
        'Nødvendige tilladelser til at bruge zoomskærmen for ITSM-konfigurationselementer i agentgrænsefladen.';
    $Self->{Translation}->{'Required permissions to use the add ITSM configuration item screen in the agent interface.'} =
        'Nødvendige tilladelser til at bruge skærmbilledet Tilføj ITSM-konfigurationselement i agentgrænsefladen.';
    $Self->{Translation}->{'Required permissions to use the bulk ITSM configuration item screen in the agent interface.'} =
        'Nødvendige tilladelser til at bruge skærmbilledet med ITSM-konfigurationselementer i bulk i agentgrænsefladen.';
    $Self->{Translation}->{'Required permissions to use the edit ITSM configuration item screen in the agent interface.'} =
        'Nødvendige tilladelser til at bruge skærmbilledet Rediger ITSM-konfigurationselement i agentgrænsefladen.';
    $Self->{Translation}->{'Required permissions to use the history ITSM configuration item screen in the agent interface.'} =
        'Nødvendige tilladelser til at bruge skærmbilledet med historik for ITSM-konfigurationselementer i agentgrænsefladen.';
    $Self->{Translation}->{'Required permissions to use the print ITSM configuration item screen in the agent interface.'} =
        'Nødvendige tilladelser til at bruge skærmbilledet Udskriv ITSM-konfigurationselement i agentgrænsefladen.';
    $Self->{Translation}->{'Required privileges to delete config items.'} = 'Nødvendige rettigheder for at slette konfigurationselementer.';
    $Self->{Translation}->{'Search config items.'} = 'Søg i konfigurationselementer.';
    $Self->{Translation}->{'Set the incident state of a CI automatically when a Ticket is Linked to a CI.'} =
        'Indstil automatisk hændelsesstatus for en CI, når en ticket er linket til en CI.';
    $Self->{Translation}->{'Sets the deployment state in the configuration item bulk screen of the agent interface.'} =
        'Indstiller implementeringstilstanden i konfigurationselementets bulkskærm i agentgrænsefladen.';
    $Self->{Translation}->{'Sets the incident state in the configuration item bulk screen of the agent interface.'} =
        'Indstiller hændelsestilstanden i konfigurationselementets bulkskærm i agentgrænsefladen.';
    $Self->{Translation}->{'Shows a link in the menu that allows linking a configuration item with another object in the config item zoom view of the agent interface.'} =
        'Viser et link i menuen, der gør det muligt at forbinde et konfigurationselement med et andet objekt i zoomvisningen af konfigurationselementet i agentgrænsefladen.';
    $Self->{Translation}->{'Shows a link in the menu to access the history of a configuration item in the configuration item overview of the agent interface.'} =
        'Viser et link i menuen for at få adgang til historikken for et konfigurationselement i oversigten over konfigurationselementer i agentgrænsefladen.';
    $Self->{Translation}->{'Shows a link in the menu to access the history of a configuration item in the its zoom view of the agent interface.'} =
        'Viser et link i menuen for at få adgang til historikken for et konfigurationselement i agentgrænsefladens zoomvisning.';
    $Self->{Translation}->{'Shows a link in the menu to delete a configuration item in its zoom view of the agent interface.'} =
        'Viser et link i menuen til at slette et konfigurationselement i zoomvisningen af agentgrænsefladen.';
    $Self->{Translation}->{'Shows a link in the menu to display the configuration item links as a Tree View.'} =
        'Viser et link i menuen for at vise links til konfigurationselementer som en trævisning.';
    $Self->{Translation}->{'Shows a link in the menu to duplicate a configuration item in the configuration item overview of the agent interface.'} =
        'Viser et link i menuen til at duplikere et konfigurationselement i oversigten over konfigurationselementer i agentgrænsefladen.';
    $Self->{Translation}->{'Shows a link in the menu to duplicate a configuration item in the its zoom view of the agent interface.'} =
        'Viser et link i menuen til at duplikere et konfigurationselement i zoomvisningen af agentgrænsefladen.';
    $Self->{Translation}->{'Shows a link in the menu to edit a configuration item in the its zoom view of the agent interface.'} =
        'Viser et link i menuen til redigering af et konfigurationselement i agentgrænsefladens zoomvisning.';
    $Self->{Translation}->{'Shows a link in the menu to go back in the configuration item zoom view of the agent interface.'} =
        'Viser et link i menuen til at gå tilbage i zoomvisningen af konfigurationselementet i agentgrænsefladen.';
    $Self->{Translation}->{'Shows a link in the menu to print a configuration item in the its zoom view of the agent interface.'} =
        'Viser et link i menuen til at udskrive et konfigurationselement i agentgrænsefladens zoomvisning.';
    $Self->{Translation}->{'Shows a link in the menu to zoom into a configuration item in the configuration item overview of the agent interface.'} =
        'Viser et link i menuen til at zoome ind på et konfigurationselement i oversigten over konfigurationselementer i agentgrænsefladen.';
    $Self->{Translation}->{'Shows the config item history (reverse ordered) in the agent interface.'} =
        'Viser konfigurationselementets historik (i omvendt rækkefølge) i agentgrænsefladen.';
    $Self->{Translation}->{'The default category which is shown, if none is selected.'} = 'Standardkategorien, som vises, hvis ingen er valgt.';
    $Self->{Translation}->{'The identifier for a configuration item, e.g. ConfigItem#, MyConfigItem#. The default is ConfigItem#.'} =
        'Identifikatoren for et konfigurationselement, f.eks. ConfigItem#, MyConfigItem#. Standard er ConfigItem#.';
    $Self->{Translation}->{'Triggers ConfigItemFetch invoker automatically.'} = 'Udløser automatisk ConfigItemFetch invoker.';
    $Self->{Translation}->{'Version String Expression'} = 'Version String-udtryk';
    $Self->{Translation}->{'Version String Module'} = 'Version String Module';
    $Self->{Translation}->{'Version Trigger'} = 'Version udløser';
    $Self->{Translation}->{'Whether the execution of ConfigItemACL can be avoided by checking cached field dependencies. This can improve loading times of formulars, but has to be disabled, if ACLModules are to be used for ITSMConfigItem- and Form-ReturnTypes.'} =
        'Om udførelsen af ConfigItemACL kan undgås ved at tjekke cachelagrede feltafhængigheder. Dette kan forbedre indlæsningstiden for formularer, men skal deaktiveres, hvis ACLModules skal bruges til ITSMConfigItem- og Form-ReturnTypes.';
    $Self->{Translation}->{'Which general information is shown in the header.'} = 'Hvilke generelle oplysninger vises i overskriften.';
    $Self->{Translation}->{'With this option it´s possible to fill automaticly a CI field, depending on the count of linked CI´s with the existing type DependsOn.'} =
        '';
    $Self->{Translation}->{'With this option it´s possible to fill automaticly a CI field, depending on the count of linked CI´s.'} =
        '';
    $Self->{Translation}->{'With this option it´s possible to fill automaticly a CI field, depending on the count of linked CI´s. The setting CounterClassName include the name of the class and CounterFieldName is used to store the count of used licence.'} =
        '';
    $Self->{Translation}->{'class'} = 'klasse';
    $Self->{Translation}->{'global'} = 'globalt';
    $Self->{Translation}->{'postproductive'} = 'postproduktiv';
    $Self->{Translation}->{'preproductive'} = 'Detaljer om version af konfigurationselement';
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

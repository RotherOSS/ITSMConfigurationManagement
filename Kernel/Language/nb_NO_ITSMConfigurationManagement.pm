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

package Kernel::Language::nb_NO_ITSMConfigurationManagement;

use strict;
use warnings;
use utf8;

sub Data {
    my $Self = shift;

    # Template: AdminITSMConfigItem
    $Self->{Translation}->{'Config Item Management'} = 'Administrasjon av konfigurasjonsenheter';
    $Self->{Translation}->{'Change class definition'} = 'Endre klassedefinisjon';
    $Self->{Translation}->{'Change role definition'} = 'Endre rolledefinisjon';
    $Self->{Translation}->{'Ready2Import Class Bundles'} = 'Ready2Import-klassepakker';
    $Self->{Translation}->{'Here you can import Ready2Import class bundles showcasing our most usual config items. Please note that some additional configuration may be required.'} =
        'Her kan du importere Ready2Import-klassepakker som viser de vanligste konfigurasjonselementene våre. Vær oppmerksom på at det kan være nødvendig med ytterligere konfigurasjon.';
    $Self->{Translation}->{'Update existing entities'} = 'Oppdater eksisterende enheter';
    $Self->{Translation}->{'Import Ready2Adopt class bundles'} = 'Importer Ready2Adopt-klassepakker';
    $Self->{Translation}->{'Config Item Class'} = 'Konfigurasjonsenhetsklasse';
    $Self->{Translation}->{'Config Item Role'} = 'Konfigureringselementets rolle';

    # Template: AgentITSMConfigItemAdd
    $Self->{Translation}->{'Config Item'} = 'Konfigurasjonsenhet';
    $Self->{Translation}->{'Filter for Classes'} = 'Filter for klasser';
    $Self->{Translation}->{'Select a Class from the list to create a new Config Item.'} = 'Velg en klasse fra listen for å opprette en ny konfigurasjonsenhet';
    $Self->{Translation}->{'Class'} = 'Klasse';

    # Template: AgentITSMConfigItemBulk
    $Self->{Translation}->{'ITSM ConfigItem Bulk Action'} = 'Masseredigering av konfigurasjonsenheter';
    $Self->{Translation}->{'Deployment state'} = 'Produksjonssettingstilstand';
    $Self->{Translation}->{'Incident state'} = 'Hendelsestilstand';
    $Self->{Translation}->{'Link to another'} = 'Koble til en annen';
    $Self->{Translation}->{'Invalid Configuration Item number!'} = 'Ugyldig konfigurasjonselementnummer!';
    $Self->{Translation}->{'The number of another Configuration Item to link with.'} = 'Nummeret på et annet konfigurasjonselement som skal kobles til.';

    # Template: AgentITSMConfigItemDelete
    $Self->{Translation}->{'Do you really want to delete this config item?'} = 'Vil du virkelig fjerne denne konfigurasjonsenheten?';

    # Template: AgentITSMConfigItemEdit
    $Self->{Translation}->{'The name of this config item'} = 'Navnet til denne konfigurasjonsenheten';
    $Self->{Translation}->{'Name is already in use by the ConfigItems with the following Number(s): %s'} =
        'Navnet er allerede i bruk av ConfigItems med følgende nummer: %s';
    $Self->{Translation}->{'Version Number'} = 'Versjon';
    $Self->{Translation}->{'Version number of this config item'} = 'Versjonsnummer for dette konfigurasjonselementet';
    $Self->{Translation}->{'Version Number is already in use by the ConfigItems with the following Number(s): %s'} =
        'Versjonsnummeret er allerede i bruk av ConfigItems med følgende nummer: %s';
    $Self->{Translation}->{'Deployment State'} = 'Produksjonssettingstilstand';
    $Self->{Translation}->{'Incident State'} = 'Hendelsestilstand';

    # Template: AgentITSMConfigItemHistory
    $Self->{Translation}->{'History of Config Item: %s'} = 'Historien til konfigurasjonsenheten: %s';
    $Self->{Translation}->{'History Content'} = 'Historikk';
    $Self->{Translation}->{'Createtime'} = 'Opprettet';
    $Self->{Translation}->{'Zoom view'} = 'Zoom visning';

    # Template: AgentITSMConfigItemOverviewNavBar
    $Self->{Translation}->{'Config Items per page'} = 'Konfigurasjonsenheter per side';

    # Template: AgentITSMConfigItemOverviewSmall
    $Self->{Translation}->{'No config item data found.'} = 'Ingen data for konfigurasjonselementet funnet.';
    $Self->{Translation}->{'Select this config item'} = 'Velg dette konfigurasjonselementet';

    # Template: AgentITSMConfigItemSearch
    $Self->{Translation}->{'Run Search'} = 'Utfør søket';
    $Self->{Translation}->{'Also search in previous versions?'} = 'Også søke i tidligere versjoner?';

    # Template: AgentITSMConfigItemTreeView
    $Self->{Translation}->{'TreeView for ConfigItem'} = 'TreeView for ConfigItem';
    $Self->{Translation}->{'Depth Level'} = 'Dybdenivå';
    $Self->{Translation}->{'Zoom In/Out'} = 'Zoom inn/ut';
    $Self->{Translation}->{'Max links level reached for ConfigItem!'} = 'Maks lenkenivå nådd for ConfigItem!';

    # Template: AgentITSMConfigItemZoom
    $Self->{Translation}->{'Configuration Item'} = 'Konfigurasjonsenhet';
    $Self->{Translation}->{'Configuration Item Information'} = 'Opplysninger om konfigurasjonsenheten';
    $Self->{Translation}->{'Current Deployment State'} = 'Nåværende produksjonssettingstilstand';
    $Self->{Translation}->{'Current Incident State'} = 'Nåværende hendelsestilstand';
    $Self->{Translation}->{'Last changed'} = 'Sist endret';
    $Self->{Translation}->{'Last changed by'} = 'Sist endret av';

    # Template: CustomerITSMConfigItem
    $Self->{Translation}->{'Your ConfigItems'} = 'Dine ConfigItems';

    # Template: CustomerITSMConfigItemSearch
    $Self->{Translation}->{'ConfigItem Search'} = 'ConfigItem-søk';

    # Template: AdminACL
    $Self->{Translation}->{'Object Type'} = 'Objekttype';

    # JS Template: ClassImportConfirm
    $Self->{Translation}->{'The following classes will be imported'} = 'Følgende klasser vil bli importert';
    $Self->{Translation}->{'The following roles will be imported'} = 'Følgende roller vil bli importert';
    $Self->{Translation}->{'Note that also corresponding dynamic fields and GeneralCatalog classes will be created and there is no automatic removal.'} =
        'Vær oppmerksom på at også tilsvarende dynamiske felt og GeneralCatalog-klasser blir opprettet, og at de ikke fjernes automatisk.';
    $Self->{Translation}->{'Do you want to proceed?'} = 'Ønsker du å fortsette?';

    # Perl Module: Kernel/Modules/AdminITSMConfigItem.pm
    $Self->{Translation}->{'Need ExampleClasses!'} = 'Trenger eksempelklasser!';
    $Self->{Translation}->{'Definition is no valid YAML hash.'} = 'Definisjonen er ingen gyldig YAML-hash.';

    # Perl Module: Kernel/Modules/AgentITSMConfigItem.pm
    $Self->{Translation}->{'Overview: ITSM ConfigItem'} = 'Oversikt: ITSM ConfigItem';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemBulk.pm
    $Self->{Translation}->{'No ConfigItemID is given!'} = 'Ingen ConfigItemID er oppgitt!';
    $Self->{Translation}->{'You need at least one selected Configuration Item!'} = 'Du trenger minst ett valgt konfigurasjonselement!';
    $Self->{Translation}->{'You don\'t have write access to this configuration item: %s.'} =
        'Du har ikke skrivetilgang til dette konfigurasjonselementet: %s.';
    $Self->{Translation}->{'No definition was defined for class %s!'} = 'Ingen definisjon ble definert for klassen %s!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemDelete.pm
    $Self->{Translation}->{'Config item "%s" not found in database!'} = 'Konfigureringselementet "%s" ble ikke funnet i databasen!';
    $Self->{Translation}->{'Was not able to delete the configitem ID %s!'} = 'Kunne ikke slette konfigurasjonselement-ID %s!';
    $Self->{Translation}->{'No version found for ConfigItemID %s!'} = 'Ingen versjon funnet for ConfigItemID %s!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemEdit.pm
    $Self->{Translation}->{'No ConfigItemID, DuplicateID or ClassID is given!'} = 'Ingen ConfigItemID, DuplicateID eller ClassID er oppgitt!';
    $Self->{Translation}->{'No access is given!'} = 'Ingen tilgang er gitt!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemHistory.pm
    $Self->{Translation}->{'Can\'t show history, no ConfigItemID is given!'} = 'Kan ikke vise historikk, ingen ConfigItemID er oppgitt!';
    $Self->{Translation}->{'Can\'t show history, no access rights given!'} = 'Kan ikke vise historikk, ingen tilgangsrettigheter gitt!';
    $Self->{Translation}->{'New ConfigItem (ID=%s)'} = 'Nytt ConfigItem (ID=%s)';
    $Self->{Translation}->{'New version (ID=%s)'} = 'Ny versjon (ID=%s)';
    $Self->{Translation}->{'Deployment state updated (new=%s, old=%s)'} = 'Oppdatering av distribusjonsstatus (new=%s, old=%s)';
    $Self->{Translation}->{'Incident state updated (new=%s, old=%s)'} = 'Hendelsesstatus oppdatert (ny=%s, gammel=%s)';
    $Self->{Translation}->{'ConfigItem (ID=%s) deleted'} = 'ConfigItem (ID=%s) slettet';
    $Self->{Translation}->{'Link to %s (type=%s) added'} = 'Lenke til %s (type=%s) lagt til';
    $Self->{Translation}->{'Link to %s (type=%s) deleted'} = 'Kobling til %s (type=%s) slettet';
    $Self->{Translation}->{'ConfigItem definition updated (ID=%s)'} = 'ConfigItem-definisjon oppdatert (ID=%s)';
    $Self->{Translation}->{'Name updated (new=%s, old=%s)'} = 'Navn oppdatert (ny=%s, gammel=%s)';
    $Self->{Translation}->{'Attribute %s updated from "%s" to "%s"'} = 'Attributt %s oppdatert fra "%s" til "%s"';
    $Self->{Translation}->{'Version %s deleted'} = 'Versjon %s slettet';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemPrint.pm
    $Self->{Translation}->{'No ConfigItemID or VersionID is given!'} = 'Ingen ConfigItemID eller VersionID er oppgitt!';
    $Self->{Translation}->{'Can\'t show config item, no access rights given!'} = 'Kan ikke vise konfigurasjonselementet, ingen tilgangsrettigheter gitt!';
    $Self->{Translation}->{'ConfigItemID %s not found in database!'} = 'ConfigItemID %s ble ikke funnet i databasen!';
    $Self->{Translation}->{'ConfigItem'} = 'Konfigurasjonsenhet';
    $Self->{Translation}->{'printed by %s at %s'} = 'skrevet ut av %s på %s';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemSearch.pm
    $Self->{Translation}->{'Invalid ClassID!'} = 'Ugyldig ClassID!';
    $Self->{Translation}->{'No ClassID is given!'} = 'Ingen ClassID er oppgitt!';
    $Self->{Translation}->{'No access rights for this class given!'} = 'Ingen tilgangsrettigheter for denne klassen gitt!';
    $Self->{Translation}->{'No Result!'} = 'Ingen resultater';
    $Self->{Translation}->{'Config Item Search Results'} = 'Søkeresultater for konfigureringselementer';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemZoom.pm
    $Self->{Translation}->{'Can\'t show item, no access rights for ConfigItem are given!'} =
        'Kan ikke vise elementet, ingen tilgangsrettigheter for ConfigItem er gitt!';
    $Self->{Translation}->{'ConfigItem not found!'} = 'ConfigItem ble ikke funnet!';
    $Self->{Translation}->{'No versions found!'} = 'Ingen versjoner funnet!';
    $Self->{Translation}->{'operational'} = 'operativ';
    $Self->{Translation}->{'warning'} = 'advarsel';
    $Self->{Translation}->{'incident'} = 'hendelse';
    $Self->{Translation}->{'The deployment state of this config item'} = 'Produksjonssettingstilstand for denne konfigurasjonsenheten';
    $Self->{Translation}->{'The incident state of this config item'} = 'Hendelsestilstanden for denne konfigurasjonsenheten';

    # Perl Module: Kernel/Modules/CustomerITSMConfigItemSearch.pm
    $Self->{Translation}->{'No permission'} = 'Ingen tillatelse';
    $Self->{Translation}->{'Filter invalid!'} = 'Filter ugyldig!';
    $Self->{Translation}->{'Search params invalid!'} = 'Søkeparametere ugyldige!';

    # Perl Module: Kernel/Output/HTML/Dashboard/ITSMConfigItemGeneric.pm
    $Self->{Translation}->{'Shown config items'} = 'Viste konfigurasjonselementer';
    $Self->{Translation}->{'Deployment State Type'} = 'Type produksjonssettingstilstand';
    $Self->{Translation}->{'Current Incident State Type'} = 'Nåværende type hendelsestilstand';

    # Perl Module: Kernel/Output/HTML/ITSMConfigItem/LayoutDate.pm
    $Self->{Translation}->{'Between'} = 'Mellom';

    # Perl Module: Kernel/System/DynamicField/Driver/ConfigItem.pm
    $Self->{Translation}->{'Class restrictions for the config item'} = 'Klassebegrensninger for konfigurasjonselementet';
    $Self->{Translation}->{'Select one or more classes to restrict selectable config items'} =
        'Velg én eller flere klasser for å begrense valgbare konfigurasjonselementer';
    $Self->{Translation}->{'Link type'} = 'Type lenke';
    $Self->{Translation}->{'Select the link type.'} = 'Velg koblingstype.';
    $Self->{Translation}->{'Forwards: Referencing (Source) -> Referenced (Target)'} = 'Fremover Refererer (Kilde) -> Referert (Mål)';
    $Self->{Translation}->{'Backwards: Referenced (Source) -> Referencing (Target)'} = 'Baklengs: Referert (Kilde) -> Referering (Mål)';
    $Self->{Translation}->{'Link Direction'} = 'Lenkeretning';
    $Self->{Translation}->{'The referencing object is the one containing this dynamic field, the referenced object is the one selected as value of the dynamic field.'} =
        'Det refererende objektet er det som inneholder dette dynamiske feltet, og det refererte objektet er det som er valgt som verdi for det dynamiske feltet.';
    $Self->{Translation}->{'Dynamic (ConfigItem)'} = 'Dynamisk (ConfigItem)';
    $Self->{Translation}->{'Static (Version)'} = 'Statisk (versjon)';
    $Self->{Translation}->{'Link Referencing Type'} = 'Type lenkehenvisning';
    $Self->{Translation}->{'Whether this link applies to the ConfigItem or the static version of the referencing object. Current Incident State calculation only is performed on dynamic links.'} =
        'Om denne koblingen gjelder ConfigItem eller den statiske versjonen av referanseobjektet. Beregning av gjeldende hendelsesstatus utføres bare på dynamiske koblinger.';
    $Self->{Translation}->{'Select the attribute which config items will be searched by'} = 'Velg attributtet som konfigurasjonselementene skal søkes etter';

    # Perl Module: Kernel/System/ITSMConfigItem/Definition.pm
    $Self->{Translation}->{'Base structure is not valid. Please provide a hash with data in YAML format.'} =
        'Basisstrukturen er ikke gyldig. Oppgi en hash med data i YAML-format.';
    $Self->{Translation}->{'Starting the YAML string with \'---\' is required.'} = 'Det er nødvendig å starte YAML-strengen med \'---\'.';

    # Perl Module: Kernel/System/ITSMConfigItem/Link.pm
    $Self->{Translation}->{'Could not purge the table configitem_link.'} = 'Kunne ikke rense tabellen configitem_link.';
    $Self->{Translation}->{'No relevant dynamic fields were found'} = 'Ingen relevante dynamiske felt ble funnet';
    $Self->{Translation}->{'Could not insert into the table configitem_link'} = 'Kunne ikke sette inn i tabellen configitem_link';
    $Self->{Translation}->{'Inserted 0 rows into the table configitem_link'} = 'Satte inn 0 rader i tabellen configitem_link';

    # Perl Module: Kernel/System/ImportExport/ObjectBackend/ITSMConfigItem.pm
    $Self->{Translation}->{'Maximum number of one element'} = 'Maks. antall av ett element';
    $Self->{Translation}->{'Empty fields indicate that the current values are kept'} = 'Tomme felter indikerer at de nåværende verdiene beholdes';
    $Self->{Translation}->{'Skipped'} = 'Hoppet over';

    # Perl Module: Kernel/Modules/AdminDynamicField.pm
    $Self->{Translation}->{'Error synchronizing the definitions. Please check the log.'} = 'Feil ved synkronisering av definisjonene. Vennligst sjekk loggen.';
    $Self->{Translation}->{'You have ITSMConfigItem definitions which are not synchronized. Please deploy your ITSMConfigItem dynamic field changes.'} =
        'Du har ITSMConfigItem-definisjoner som ikke er synkronisert. Vennligst distribuer endringene i de dynamiske feltene i ITSMConfigItem.';

    # Database XML / SOPM Definition: ITSMConfigurationManagement.sopm
    $Self->{Translation}->{'Expired'} = 'Utgått';
    $Self->{Translation}->{'Maintenance'} = 'Vedlikehold';
    $Self->{Translation}->{'Pilot'} = 'Pilot';
    $Self->{Translation}->{'Planned'} = 'Planlagt';
    $Self->{Translation}->{'Repair'} = 'Reparasjon';
    $Self->{Translation}->{'Retired'} = 'Utfaset';
    $Self->{Translation}->{'Review'} = 'Evaluering';
    $Self->{Translation}->{'Test/QA'} = 'Test/Kvalitetskontroll';

    # JS File: ITSM.Admin.ITSMConfigItem
    $Self->{Translation}->{'Overview and Confirmation'} = 'Oversikt og bekreftelse';
    $Self->{Translation}->{'Importing classes/roles and their related fields'} = 'Importere klasser/roller og tilhørende felt';
    $Self->{Translation}->{'An error occurred during class import.'} = 'Det oppstod en feil under klasseimporten.';

    # SysConfig
    $Self->{Translation}->{'0 - Hidden'} = '0 - Skjult';
    $Self->{Translation}->{'1 - Shown'} = '1 - Vist';
    $Self->{Translation}->{'Allows extended search conditions in config item search of the agent interface. With this feature you can search e. g. config item name with this kind of conditions like "(*key1*&&*key2*)" or "(*key1*||*key2*)".'} =
        'Tillater utvidede søkebetingelser i konfigurasjonsobjektsøk i agentgrensesnittet. Med denne funksjonen kan du f.eks. søke etter navn på konfigurasjonselementer med denne typen betingelser som "(*nøkkel1*&&*nøkkel2*)" eller "(*nøkkel1*||*nøkkel2*)".';
    $Self->{Translation}->{'Allows extended search conditions in config item search of the customer interface. With this feature you can search e. g. config item name with this kind of conditions like "(*key1*&&*key2*)" or "(*key1*||*key2*)".'} =
        'Tillater utvidede søkebetingelser i konfigureringselement-søk i kundegrensesnittet. Med denne funksjonen kan du f.eks. søke etter konfigurasjonselementnavn med denne typen betingelser som "(*nøkkel1*&&*nøkkel2*)" eller "(*nøkkel1*||*nøkkel2*)".';
    $Self->{Translation}->{'Assigned CIs'} = 'Tildelte KI-er';
    $Self->{Translation}->{'At a specific time point create a ticket for config items, if the configured requirements are met. The time point is determined by the value of the field configured under "TimeCIKey" of the ConfigItem, and modified by "TimeModifier". If the latter can be either just a number, or a sign (+/-), a number, and an unit (d/h/m): "7" is equivalent to "+7d". The DynamicField "Ticket->DynamicField" will be used to mark created tickets - it has to exist. The flags \<OTOBO_CONFIGITEM_X\> where X can be NAME, NUMBER and DATE, will be substituted with the respective values in "Ticket->Text".'} =
        'På et bestemt tidspunkt opprettes en billett for konfigurasjonselementer hvis de konfigurerte kravene er oppfylt. Tidspunktet bestemmes av verdien i feltet som er konfigurert under "TimeCIKey" i ConfigItem, og modifiseres av "TimeModifier". Sistnevnte kan enten bare være et tall, eller et tegn (+/-), et tall og en enhet (d/h/m): "7" tilsvarer "+7d". Det dynamiske feltet "Ticket->DynamicField" brukes til å merke opprettede billetter - det må eksistere. Flaggene \<OTOBO_CONFIGITEM_X\>, der X kan være NAME, NUMBER og DATE, vil bli erstattet med de respektive verdiene i "Ticket->Text".';
    $Self->{Translation}->{'CIs assigned to customer company'} = 'CI-er som er tildelt kundeselskapet';
    $Self->{Translation}->{'CIs assigned to customer user'} = 'CI-er tilordnet kundebruker';
    $Self->{Translation}->{'CMDB Settings'} = 'CMDB-innstillinger';
    $Self->{Translation}->{'Check for a unique name only within the same ConfigItem class (\'class\') or globally (\'global\'), which means every existing ConfigItem is taken into account when looking for duplicates.'} =
        'Se etter et unikt navn bare innenfor samme ConfigItem-klasse (\'class\') eller globalt (\'global\'), noe som betyr at alle eksisterende ConfigItems tas med i betraktningen når man leter etter duplikater.';
    $Self->{Translation}->{'Choose a module to enforce a naming scheme.'} = 'Velg en modul for å håndheve et navneskjema.';
    $Self->{Translation}->{'Choose a module to enforce a number scheme.'} = 'Velg en modul for å håndheve et tallskjema.';
    $Self->{Translation}->{'Choose a module to enforce a version string scheme.'} = 'Velg en modul for å håndheve et versjonsstrengskjema.';
    $Self->{Translation}->{'Choose attributes to trigger the creation of a new version.'} = 'Velg attributter som skal utløse opprettelsen av en ny versjon.';
    $Self->{Translation}->{'Choose categories to assign to this config item class.'} = 'Velg kategorier som skal tilordnes denne konfigurasjonselementklassen.';
    $Self->{Translation}->{'Column config item filters for ConfigItem Overview.'} = 'Kolonnekonfigurasjonselementfiltre for ConfigItem Overview.';
    $Self->{Translation}->{'Columns that can be filtered in the config item overview of the agent interface. Note: Only Config Item attributes and Dynamic Fields (DynamicField_NameX) are allowed.'} =
        'Kolonner som kan filtreres i oversikten over konfigurasjonselementer i agentgrensesnittet. Merk: Bare attributter for konfigurasjonselementer og dynamiske felt (DynamicField_NameX) er tillatt.';
    $Self->{Translation}->{'Columns that can be filtered in the config item overview of the customer interface. Note: Only Config Item attributes and Dynamic Fields (DynamicField_NameX) are allowed.'} =
        'Kolonner som kan filtreres i oversikten over konfigurasjonselementer i kundegrensesnittet. Merk: Bare attributter for konfigurasjonselementer og dynamiske felt (DynamicField_NameX) er tillatt.';
    $Self->{Translation}->{'Columns that can be filtered in the config item search result overview of the agent interface. Note: Only Config Item attributes and Dynamic Fields (DynamicField_NameX) are allowed.'} =
        'Kolonner som kan filtreres i søkeresultatoversikten for konfigurasjonselementer i agentgrensesnittet. Merk: Bare attributter for konfigurasjonselementer og dynamiske felt (DynamicField_NameX) er tillatt.';
    $Self->{Translation}->{'Config Items'} = 'Konfigurasjonsenheter';
    $Self->{Translation}->{'Config item add.'} = 'Legg til konfigureringselement.';
    $Self->{Translation}->{'Config item edit.'} = 'Rediger konfigureringselement.';
    $Self->{Translation}->{'Config item event module that count the licenses for OTOBOCILicenseCount feature.'} =
        'Hendelsesmodul for konfigurasjonselement som teller lisenser for funksjonen OTOBOCILicenseCount.';
    $Self->{Translation}->{'Config item event module that enables logging to history in the agent interface.'} =
        'Konfigurer hendelsesmodul for konfigureringselementet som muliggjør logging til historikk i agentgrensesnittet.';
    $Self->{Translation}->{'Config item event module that updates config items to their current definition.'} =
        'Hendelsesmodul for konfigurasjonselementer som oppdaterer konfigurasjonselementene til deres gjeldende definisjon.';
    $Self->{Translation}->{'Config item event module that updates the table configitem_ĺink.'} =
        'Config item-hendelsesmodul som oppdaterer tabellen configitem_ĺink.';
    $Self->{Translation}->{'Config item event module updates the current incident state.'} =
        'Hendelsesmodulen for konfigureringselementet oppdaterer gjeldende hendelsesstatus.';
    $Self->{Translation}->{'Config item history.'} = 'Konfigurer elementhistorikk.';
    $Self->{Translation}->{'Config item print.'} = 'Konfigurer elementutskrift.';
    $Self->{Translation}->{'Config item zoom.'} = 'Konfigurer elementzoom.';
    $Self->{Translation}->{'ConfigItem Tree View'} = 'KonfigItem-trevisning';
    $Self->{Translation}->{'ConfigItem Version'} = 'ConfigItem Versjon';
    $Self->{Translation}->{'ConfigItems of the following classes will not be stored on the Elasticsearch server. To apply this to existing CIs, the CI migration has to be run via console, after changing this option.'} =
        'ConfigItems av følgende klasser vil ikke bli lagret på Elasticsearch-serveren. Hvis du vil bruke dette på eksisterende CI-er, må CI-migreringen kjøres via konsollen etter at du har endret dette alternativet.';
    $Self->{Translation}->{'ConfigItems with the following deployment states will not be stored on the Elasticsearch server. To apply this to existing CIs, the CI migration has to be run via console, after changing this option.'} =
        'ConfigItems med følgende distribusjonsstatus vil ikke bli lagret på Elasticsearch-serveren. For å bruke dette på eksisterende CI-er må CI-migreringen kjøres via konsollen etter at du har endret dette alternativet.';
    $Self->{Translation}->{'Configuration Item Limit'} = 'Konfigurasjon Elementgrense';
    $Self->{Translation}->{'Configuration Item limit per page.'} = 'Konfigurasjon Elementbegrensning per side.';
    $Self->{Translation}->{'Configuration Management Database.'} = 'Database for konfigurasjonsstyring.';
    $Self->{Translation}->{'Configuration item bulk module.'} = 'Konfigurasjonselementets bulkmodul.';
    $Self->{Translation}->{'Configuration item search backend router of the agent interface.'} =
        'Konfigurasjonselement for søk i backend-ruteren til agentgrensesnittet.';
    $Self->{Translation}->{'Create and manage the definitions for Configuration Items.'} = 'Opprett og administrer definisjonene for konfigurasjonselementer.';
    $Self->{Translation}->{'Creates Tickets for ConfigItems at specific time points.'} = 'Oppretter billetter for ConfigItems på bestemte tidspunkter.';
    $Self->{Translation}->{'Customers can see historic CI versions.'} = 'Kunder kan se historiske CI-versjoner.';
    $Self->{Translation}->{'Customers have the possibility to manually switch between historic CI versions.'} =
        'Kundene har mulighet til å bytte manuelt mellom historiske CI-versjoner.';
    $Self->{Translation}->{'Default data to use on attribute for config item search screen. Example: "ITSMConfigItemCreateTimePointFormat=year;ITSMConfigItemCreateTimePointStart=Last;ITSMConfigItemCreateTimePoint=2;".'} =
        'Standarddata som skal brukes på attributtet for søkeskjermen for konfigurasjonselementer. Eksempel: "ITSMConfigItemCreateTimePointFormat=year;ITSMConfigItemCreateTimePointStart=Last;ITSMConfigItemCreateTimePoint=2;".';
    $Self->{Translation}->{'Default data to use on attribute for config item search screen. Example: "ITSMConfigItemCreateTimeStartYear=2010;ITSMConfigItemCreateTimeStartMonth=10;ITSMConfigItemCreateTimeStartDay=4;ITSMConfigItemCreateTimeStopYear=2010;ITSMConfigItemCreateTimeStopMonth=11;ITSMConfigItemCreateTimeStopDay=3;".'} =
        'Standarddata som skal brukes på attributtet for søkeskjermen for konfigurasjonselementer. Eksempel: "ITSMConfigItemCreateTimeStartYear=2010;ITSMConfigItemCreateTimeStartMonth=10;ITSMConfigItemCreateTimeStartDay=4;ITSMConfigItemCreateTimeStopYear=2010;ITSMConfigItemCreateTimeStopMonth=11;ITSMConfigItemCreateTimeStopDay=3;".';
    $Self->{Translation}->{'Define Actions where a settings button is available in the linked objects widget (LinkObject::ViewMode = "complex"). Please note that these Actions must have registered the following JS and CSS files: Core.AllocationList.css, Core.UI.AllocationList.js, Core.UI.Table.Sort.js, Core.Agent.TableFilters.js and Core.Agent.LinkObject.js.'} =
        'Definer handlinger der en innstillingsknapp er tilgjengelig i widgeten for koblede objekter (LinkObject::ViewMode = "complex"). Vær oppmerksom på at disse handlingene må ha registrert følgende JS- og CSS-filer: Core.AllocationList.css, Core.UI.AllocationList.js, Core.UI.Table.Sort.js, Core.Agent.TableFilters.js.';
    $Self->{Translation}->{'Define a Template::Toolkit scheme for version strings. Only used if Version String Module is set to TemplateToolkit.'} =
        'Definer et Template::Toolkit-skjema for versjonsstrenger. Brukes bare hvis Versjonsstrengmodul er satt til TemplateToolkit.';
    $Self->{Translation}->{'Define a set of conditions under which a customer is allowed to see a config item. Conditions can optionally be restricted to certain customer groups. Name is the only mandatory attribute. If no other options are given, all config items will be visible under that category.'} =
        'Definer et sett med betingelser for at en kunde skal kunne se et konfigurasjonselement. Betingelsene kan eventuelt begrenses til bestemte kundegrupper. Navn er det eneste obligatoriske attributtet. Hvis ingen andre alternativer er angitt, vil alle konfigurasjonselementer være synlige under den aktuelle kategorien.';
    $Self->{Translation}->{'Defines Required permissions to create ITSM configuration items using the Generic Interface.'} =
        'Definerer nødvendige tillatelser for å opprette ITSM-konfigurasjonselementer ved hjelp av det generiske grensesnittet.';
    $Self->{Translation}->{'Defines Required permissions to delete ITSM configuration items using the Generic Interface.'} =
        'Definerer nødvendige tillatelser for å slette ITSM-konfigurasjonselementer ved hjelp av det generiske grensesnittet.';
    $Self->{Translation}->{'Defines Required permissions to get ITSM configuration items using the Generic Interface.'} =
        'Definerer nødvendige tillatelser for å hente ITSM-konfigurasjonselementer ved hjelp av det generiske grensesnittet.';
    $Self->{Translation}->{'Defines Required permissions to search ITSM configuration items using the Generic Interface.'} =
        'Definerer nødvendige tillatelser for å søke i ITSM-konfigurasjonselementer ved hjelp av det generiske grensesnittet.';
    $Self->{Translation}->{'Defines Required permissions to update ITSM configuration items using the Generic Interface.'} =
        'Definerer nødvendige tillatelser for å oppdatere ITSM-konfigurasjonselementer ved hjelp av det generiske grensesnittet.';
    $Self->{Translation}->{'Defines an overview module to show the small view of a configuration item list.'} =
        'Definerer en oversiktsmodul som viser den lille visningen av en liste med konfigurasjonselementer.';
    $Self->{Translation}->{'Defines if parent-child translations for queues and services should be generated automatically.'} =
        '';
    $Self->{Translation}->{'Defines if the link type labels must be shown in the node connections.'} =
        'Angir om lenketypeetikettene skal vises i nodeforbindelsene.';
    $Self->{Translation}->{'Defines regular expressions individually for each ConfigItem class to check the ConfigItem name and to show corresponding error messages.'} =
        'Definerer regulære uttrykk individuelt for hver ConfigItem-klasse for å kontrollere ConfigItem-navnet og vise tilsvarende feilmeldinger.';
    $Self->{Translation}->{'Defines the available columns of CIs in the config item overview depending on the CI class. Each entry must consist of a class name and an array of available fields for the corresponding class. Dynamic field entries have to honor the scheme DynamicField_FieldName.'} =
        'Definerer tilgjengelige kolonner med CI-er i oversikten over konfigurasjonselementer avhengig av CI-klassen. Hver oppføring må bestå av et klassenavn og en matrise med tilgjengelige felt for den tilsvarende klassen. Dynamiske feltoppføringer må følge skjemaet DynamicField_FieldName.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of the agent interface.'} =
        'Definerer standard konfig-elementattributt for sortering av konfig-elementer i søkeresultatet for konfig-elementer i agentgrensesnittet.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of the customer interface.'} =
        'Definerer standard konfigurasjonselementattributt for sortering av konfigurasjonselementer i søkeresultatet for konfigurasjonselementer i kundegrensesnittet.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of this operation.'} =
        'Definerer standard konfig-elementattributt for sortering av konfig-elementet i søkeresultatet for denne operasjonen.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the agent interface. Up: oldest on top. Down: latest on top.'} =
        'Definerer standardrekkefølgen for konfigurasjonselementer i søkeresultatet for konfigurasjonselementer i agentgrensesnittet. Opp: eldst på toppen. Ned: nyeste øverst.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the customer interface. Up: oldest on top. Down: latest on top.'} =
        'Definerer standardrekkefølgen for konfigurasjonselementer i søkeresultatet for konfigurasjonselementer i kundegrensesnittet. Opp: eldst på toppen. Ned: nyeste øverst.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the this operation. Up: oldest on top. Down: latest on top.'} =
        'Definerer standardrekkefølgen på konfigurasjonselementene i søkeresultatet for denne operasjonen. Opp: eldste øverst. Ned: nyeste øverst.';
    $Self->{Translation}->{'Defines the default displayed columns of CIs in the config item overview depending on the CI class. Each entry must consist of a class name and an array of available fields for the corresponding class. Dynamic field entries have to honor the scheme DynamicField_FieldName.'} =
        'Definerer standardkolonnene som vises for CI-er i oversikten over konfigurasjonselementer, avhengig av CI-klassen. Hver oppføring må bestå av et klassenavn og en matrise med tilgjengelige felt for den tilsvarende klassen. Dynamiske feltoppføringer må følge skjemaet DynamicField_FieldName.';
    $Self->{Translation}->{'Defines the default relations depth to be shown.'} = 'Definerer standard relasjonsdybde som skal vises.';
    $Self->{Translation}->{'Defines the default shown config item search attribute for config item search screen.'} =
        'Definerer standardattributtet for søkeattributtet som vises for skjermbildet for konfigurasjonsobjektsøk.';
    $Self->{Translation}->{'Defines the default shown config item search attribute for config item search screen. Example: "Key" must have the name of the Dynamic Field in this case \'X\', "Content" must have the value of the Dynamic Field depending on the Dynamic Field type,  Text: \'a text\', Dropdown: \'1\', Date/Time: \'Search_DynamicField_XTimeSlotStartYear=1974; Search_DynamicField_XTimeSlotStartMonth=01; Search_DynamicField_XTimeSlotStartDay=26; Search_DynamicField_XTimeSlotStartHour=00; Search_DynamicField_XTimeSlotStartMinute=00; Search_DynamicField_XTimeSlotStartSecond=00; Search_DynamicField_XTimeSlotStopYear=2013; Search_DynamicField_XTimeSlotStopMonth=01; Search_DynamicField_XTimeSlotStopDay=26; Search_DynamicField_XTimeSlotStopHour=23; Search_DynamicField_XTimeSlotStopMinute=59; Search_DynamicField_XTimeSlotStopSecond=59;\' and or \'Search_DynamicField_XTimePointFormat=week; Search_DynamicField_XTimePointStart=Before; Search_DynamicField_XTimePointValue=7\';.'} =
        'Definerer standardattributtet som vises for søkeattributtet for konfigurasjonselementet på søkeskjermen. Eksempel: "Key" må ha navnet på det dynamiske feltet, i dette tilfellet "X", "Content" må ha verdien til det dynamiske feltet, avhengig av den dynamiske felttypen, Text: "en tekst", Dropdown: "1", Date/Time: \'Search_DynamicField_XTimeSlotStartYear=1974; Search_DynamicField_XTimeSlotStartMonth=01; Search_DynamicField_XTimeSlotStartDay=26; Search_DynamicField_XTimeSlotStartHour=00; Search_DynamicField_XTimeSlotStartMinute=00; Search_DynamicField_XTimeSlotStartSecond=00; Search_DynamicField_XTimeSlotStopYear=2013; Search_DynamicField_XTimeSlotStopMonth=01; Search_DynamicField_XTimeSlotStopDay=26; Search_DynamicField_XTimeSlotStopHour=23; Search_DynamicField_XTimeSlotStopMinute=59; Search_DynamicField_XTimeSlotStopSecond=59;\' og eller \'Search_DynamicField_XTimePointFormat=week; Search_DynamicField_XTimePointStart=Before; Search_DynamicField_XTimePointValue=7\';.';
    $Self->{Translation}->{'Defines the default subobject of the class \'ITSMConfigItem\'.'} =
        'Definerer standardunderobjektet for klassen \'ITSMConfigItem\'.';
    $Self->{Translation}->{'Defines the initial height for the rich text editor component in pixels.'} =
        '';
    $Self->{Translation}->{'Defines the initial height in pixels for the rich text editor component for this screen.'} =
        '';
    $Self->{Translation}->{'Defines the number of rows for the CI definition editor in the admin interface.'} =
        'Definerer antall rader for CI-definisjonsredigeringsprogrammet i administratorgrensesnittet.';
    $Self->{Translation}->{'Defines the order of incident states from high (e.g. cricital) to low (e.g. functional).'} =
        'Definerer rekkefølgen av hendelsestilstander fra høy (f.eks. kritisk) til lav (f.eks. funksjonell).';
    $Self->{Translation}->{'Defines the relevant deployment states where linked tickets can affect the status of a CI.'} =
        'Definerer de relevante distribusjonsstatusene der tilknyttede tickets kan påvirke statusen til en CI.';
    $Self->{Translation}->{'Defines the search limit for the AgentITSMConfigItem screen.'} =
        'Definerer søkegrensen for skjermbildet AgentITSMConfigItem.';
    $Self->{Translation}->{'Defines the search limit for the AgentITSMConfigItemSearch screen.'} =
        'Definerer søkegrensen for skjermbildet AgentITSMConfigItemSearch.';
    $Self->{Translation}->{'Defines the search limit for the CustomerITSMConfigItem screen.'} =
        'Definerer søkegrensen for skjermbildet CustomerITSMConfigItem.';
    $Self->{Translation}->{'Defines the search limit for the CustomerITSMConfigItemSearch screen.'} =
        'Definerer søkegrensen for skjermbildet CustomerITSMConfigItemSearch.';
    $Self->{Translation}->{'Defines the shown columns of CIs in the link table complex view for all CI classes. If there is no entry, then the default columns are shown.'} =
        'Definerer hvilke kolonner som skal vises for CI-er i den komplekse visningen av koblingstabellen for alle CI-klasser. Hvis det ikke finnes noen oppføring, vises standardkolonnene.';
    $Self->{Translation}->{'Defines the shown columns of CIs in the link table complex view, depending on the CI class. Each entry must be prefixed with the class name and double colons (i.e. Computer::). There are a few CI-Attributes that common to all CIs (example for the class Computer: Computer::Name, Computer::CurDeplState, Computer::CreateTime). To show individual CI-Attributes as defined in the CI-Definition, the following scheme must be used (example for the class Computer): Computer::HardDisk::1, Computer::HardDisk::1::Capacity::1, Computer::HardDisk::2, Computer::HardDisk::2::Capacity::1. If there is no entry for a CI class, then the default columns are shown.'} =
        'Definerer de viste kolonnene med CI-er i den komplekse visningen av koblingstabellen, avhengig av CI-klassen. Hver oppføring må innledes med klassenavnet og to kolon (f.eks. Computer::). Det finnes noen få CI-attributter som er felles for alle CI-er (eksempel for klassen Computer: Computer::Name, Computer::CurDeplState, Computer::CreateTime). For å vise individuelle CI-attributter som definert i CI-definisjonen, må følgende skjema brukes (eksempel for klassen Computer): Computer::HardDisk::1, Computer::HardDisk::1::Capacity::1, Computer::HardDisk::2, Computer::HardDisk::2::Capacity::1. Hvis det ikke finnes noen oppføring for en CI-klasse, vises standardkolonnene.';
    $Self->{Translation}->{'Defines which items are available for \'Action\' in third level of the ITSM Config Item ACL structure.'} =
        'Definerer hvilke elementer som er tilgjengelige for "Handling" på tredje nivå i ITSM Config Item ACL-strukturen.';
    $Self->{Translation}->{'Defines which items are available in first level of the ITSM Config Item ACL structure.'} =
        'Definerer hvilke elementer som er tilgjengelige på første nivå i ITSM Config Item ACL-strukturen.';
    $Self->{Translation}->{'Defines which items are available in second level of the ITSM Config Item ACL structure.'} =
        'Definerer hvilke elementer som er tilgjengelige på andre nivå i ITSM Config Item ACL-strukturen.';
    $Self->{Translation}->{'Defines which type of link (named from the ticket perspective) can affect the status of a linked CI.'} =
        'Definerer hvilken type kobling (navngitt fra ticket-perspektivet) som kan påvirke statusen til et koblet CI.';
    $Self->{Translation}->{'Defines which type of ticket can affect the status of a linked CI.'} =
        'Definerer hvilken type billett som kan påvirke statusen til en koblet CI.';
    $Self->{Translation}->{'Definition Update'} = 'Oppdatering av definisjoner';
    $Self->{Translation}->{'Delete Configuration Item'} = 'Slett konfigurasjonselement';
    $Self->{Translation}->{'DeplState'} = 'DeplState';
    $Self->{Translation}->{'Deployment State Color'} = 'Farge for produksjonssettingstilstand';
    $Self->{Translation}->{'DeploymentState'} = 'DeploymentState';
    $Self->{Translation}->{'Duplicate'} = 'Duplisér';
    $Self->{Translation}->{'Dynamic field event module that marks config item definitions as out of sync, if containing dynamic fields change.'} =
        'Modul for dynamiske felthendelser som markerer konfigurasjonselementdefinisjoner som usynkroniserte hvis de dynamiske feltene endres.';
    $Self->{Translation}->{'Dynamic fields shown in the additional ITSM field screen of the agent interface.'} =
        'Dynamiske felt som vises i skjermbildet for ITSM-tilleggsfelt i agentgrensesnittet.';
    $Self->{Translation}->{'Dynamic fields shown in the config item overview screen of the customer interface.'} =
        'Dynamiske felt som vises i skjermbildet for oversikt over konfigurasjonselementer i kundegrensesnittet.';
    $Self->{Translation}->{'Dynamic fields shown in the config item search screen of the agent interface.'} =
        'Dynamiske felt som vises i skjermbildet for søk etter konfigurasjonselementer i agentgrensesnittet.';
    $Self->{Translation}->{'Enables configuration item bulk action feature for the agent frontend to work on more than one configuration item at a time.'} =
        'Aktiverer funksjonen for massehandlinger for konfigurasjonselementer, slik at agentens frontend kan arbeide med mer enn ett konfigurasjonselement om gangen.';
    $Self->{Translation}->{'Enables configuration item bulk action feature only for the listed groups.'} =
        'Aktiverer funksjonen for massehandling av konfigurasjonselementer bare for de oppførte gruppene.';
    $Self->{Translation}->{'Enables/disables the functionality to check ITSM onfiguration items for unique names. Before enabling this option you should check your system for already existing config items with duplicate names. You can do this with the console command Admin::ITSM::Configitem::ListDuplicates.'} =
        'Aktiverer/deaktiverer funksjonaliteten for å sjekke om ITSM-konfigurasjonselementer har unike navn. Før du aktiverer dette alternativet, bør du sjekke systemet for allerede eksisterende konfigurasjonselementer med dupliserte navn. Du kan gjøre dette med konsollkommandoen Admin::ITSM::Configitem::ListDuplicates.';
    $Self->{Translation}->{'Event module to set configitem-status on ticket-configitem-link.'} =
        'Hendelsesmodul for å angi configitem-status på ticket-configitem-link.';
    $Self->{Translation}->{'Fields of the configuration item index, used for the fulltext search. Fields are also stored, but are not mandatory for the overall functionality. Inclusion of attachments can be disabled by setting the entry to 0 or deleting it.'} =
        'Felt i konfigurasjonselementindeksen, som brukes til fulltekstsøk. Feltene lagres også, men er ikke obligatoriske for den generelle funksjonaliteten. Inkludering av vedlegg kan deaktiveres ved å sette oppføringen til 0 eller slette den.';
    $Self->{Translation}->{'Fields stored in the configuration item index which are used for other things besides fulltext searches. For the complete functionality all fields are mandatory.'} =
        'Felt som er lagret i konfigurasjonselementindeksen, og som brukes til andre ting enn fulltekstsøk. Alle feltene er obligatoriske for å få full funksjonalitet.';
    $Self->{Translation}->{'For every webservice (key) an array of classes (value) can be defined on which the import is restricted. For all chosen classes, or all existing classes the identifying attributes will have to be chosen in the invoker config.'} =
        'For hver webtjeneste (nøkkel) kan det defineres en rekke klasser (verdi) som importen er begrenset til. For alle valgte klasser, eller alle eksisterende klasser, må de identifiserende attributtene velges i konfigurasjonen av påkalleren.';
    $Self->{Translation}->{'GenericInterface module registration for the ConfigItemFetch invoker layer.'} =
        'Registrering av GenericInterface-modulen for ConfigItemFetch-invokeringslaget.';
    $Self->{Translation}->{'ITSM ConfigItem'} = 'ITSM ConfigItem';
    $Self->{Translation}->{'ITSM config item overview.'} = 'Oversikt over ITSM konfigurasjonsenheter.';
    $Self->{Translation}->{'If this option is activated, linked items are only counted if they belong to one of the listed classes.'} =
        'Hvis dette alternativet er aktivert, telles koblede elementer bare hvis de tilhører en av de oppførte klassene.';
    $Self->{Translation}->{'InciState'} = 'InciState';
    $Self->{Translation}->{'IncidentState'} = 'IncidentState';
    $Self->{Translation}->{'Includes deployment states in the config item search of the customer interface.'} =
        'Inkluderer distribusjonsstatus i søket etter konfigurasjonselementer i kundegrensesnittet.';
    $Self->{Translation}->{'Includes incident states in the config item search of the customer interface.'} =
        'Inkluderer hendelsestilstander i konfigurasjonssøket i kundegrensesnittet.';
    $Self->{Translation}->{'Maximum number of config items to be displayed in the result of this operation.'} =
        'Maksimalt antall konfigurasjonselementer som skal vises i resultatet av denne operasjonen.';
    $Self->{Translation}->{'Module to check the group responsible for a class.'} = 'Modul for å sjekke hvilken gruppe som er ansvarlig for en klasse.';
    $Self->{Translation}->{'Module to check the group responsible for a configuration item.'} =
        'Modul for å sjekke hvilken gruppe som er ansvarlig for et konfigurasjonselement.';
    $Self->{Translation}->{'Module to generate ITSM config item statistics.'} = 'Modul for å generere statistikk over ITSM-konfigurasjonselementer.';
    $Self->{Translation}->{'Name Module'} = 'Navn Modul';
    $Self->{Translation}->{'Number Module'} = 'Nummermodul';
    $Self->{Translation}->{'Number of config items to be displayed in each page of a search result in the agent interface.'} =
        'Antall konfigurasjonselementer som skal vises på hver side av et søkeresultat i agentgrensesnittet.';
    $Self->{Translation}->{'Number of config items to be displayed in each page of a search result in the customer interface.'} =
        'Antall konfigurasjonselementer som skal vises på hver side av et søkeresultat i kundegrensesnittet.';
    $Self->{Translation}->{'Objects to search for, how many entries and which attributs to show. ConfigItem attributes have to explicitly be stored via Elasticsearch.'} =
        'Objekter det skal søkes etter, hvor mange oppføringer og hvilke attributter som skal vises. ConfigItem-attributter må lagres eksplisitt via Elasticsearch.';
    $Self->{Translation}->{'Overview.'} = 'Oversikt.';
    $Self->{Translation}->{'Parameters for the categories for config item classes in the preferences view of the agent interface.'} =
        'Parametere for kategoriene for konfigurasjonselementklasser i preferansevisningen i agentgrensesnittet.';
    $Self->{Translation}->{'Parameters for the column filters of the small config item overview. Please note: setting \'Active\' to 0 will only prevent agents from editing settings of this group in their personal preferences, but will still allow administrators to edit the settings of another user\'s behalf. Use \'PreferenceGroup\' to control in which area these settings should be shown in the user interface.'} =
        'Parametere for kolonnefiltrene i oversikten over små konfigurasjonselementer. Merk: Hvis du setter "Active" til 0, vil det bare hindre agenter i å redigere innstillingene for denne gruppen i sine personlige preferanser, men det vil fortsatt være mulig for administratorer å redigere innstillingene på vegne av en annen bruker. Bruk "PreferenceGroup" til å kontrollere i hvilket område disse innstillingene skal vises i brukergrensesnittet.';
    $Self->{Translation}->{'Parameters for the dashboard backend of the customer company config item overview of the agent interface . "Limit" is the number of entries shown by default. "Group" is used to restrict the access to the plugin (e. g. Group: admin;group1;group2;). "Default" determines if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" is the cache time in minutes for the plugin.'} =
        'Parametere for dashbordets backend for kundebedriftens konfigurasjonselementoversikt over agentgrensesnittet. "Limit" er antallet oppføringer som vises som standard. "Group" brukes til å begrense tilgangen til programtillegget (f.eks. Group: admin;group1;group2;). "Default" avgjør om programtillegget er aktivert som standard, eller om brukeren må aktivere det manuelt. "CacheTTLLocal" er hurtigbuffertiden i minutter for programtillegget.';
    $Self->{Translation}->{'Parameters for the deployment states color in the preferences view of the agent interface.'} =
        'Parametere for fargene for distribusjonsstatusene i preferansevisningen i agentgrensesnittet.';
    $Self->{Translation}->{'Parameters for the deployment states in the preferences view of the agent interface.'} =
        'Parametere for distribusjonsstatusene i preferansevisningen i agentgrensesnittet.';
    $Self->{Translation}->{'Parameters for the example permission groups of the general catalog attributes.'} =
        'Parametere for tilgangsgruppe-eksempel i attributtene for generell katalog.';
    $Self->{Translation}->{'Parameters for the name module for config item classes in the preferences view of the agent interface.'} =
        'Parametere for navnemodulen for konfigurasjonselementklasser i preferansevisningen i agentgrensesnittet.';
    $Self->{Translation}->{'Parameters for the number module for config item classes in the preferences view of the agent interface.'} =
        'Parametere for nummermodulen for konfigurasjonselementklasser i preferansevisningen i agentgrensesnittet.';
    $Self->{Translation}->{'Parameters for the pages (in which the configuration items are shown).'} =
        'Parametere for sidene (der konfigurasjonselementene vises).';
    $Self->{Translation}->{'Parameters for the version string module for config item classes in the preferences view of the agent interface.'} =
        'Parametere for versjonsstrengmodulen for konfigurasjonselementklasser i preferansevisningen i agentgrensesnittet.';
    $Self->{Translation}->{'Parameters for the version string template toolkit module for config item classes in the preferences view of the agent interface.'} =
        'Parametere for versjonsstrengmalverktøymodulen for konfigurasjonselementklasser i preferansevisningen i agentgrensesnittet.';
    $Self->{Translation}->{'Parameters for the version trigger for config item classes in the preferences view of the agent interface.'} =
        'Parametere for versjonsutløseren for konfigurasjonselementklasser i preferansevisningen i agentgrensesnittet.';
    $Self->{Translation}->{'Performs the configured action for each event (as an Invoker) for each configured Webservice.'} =
        'Utfører den konfigurerte handlingen for hver hendelse (som en Invoker) for hver konfigurerte webtjeneste.';
    $Self->{Translation}->{'Permission Group'} = 'Tillatelsesgruppe';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item attachment action in the agent interface.'} =
        'Nødvendige tillatelser for å bruke ITSM-konfigurasjonselementets vedleggshandling i agentgrensesnittet.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item screen in the agent interface.'} =
        'Nødvendige tillatelser for å bruke skjermbildet for ITSM-konfigurasjonselementer i agentgrensesnittet.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item search screen in the agent interface.'} =
        'Nødvendige tillatelser for å bruke skjermbildet for søk etter ITSM-konfigurasjonselementer i agentgrensesnittet.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item search screen in the customer interface.'} =
        'Nødvendige tillatelser for å bruke søkeskjermen for ITSM-konfigurasjonselementer i kundegrensesnittet.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item tree view screen in the agent interface.'} =
        'Nødvendige tillatelser for å bruke skjermbildet for trevisning av ITSM-konfigurasjonselementer i agentgrensesnittet.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item zoom screen in the agent interface.'} =
        'Nødvendige tillatelser for å bruke zoomskjermbildet for ITSM-konfigurasjonselementer i agentgrensesnittet.';
    $Self->{Translation}->{'Required permissions to use the add ITSM configuration item screen in the agent interface.'} =
        'Nødvendige tillatelser for å bruke skjermbildet Legg til ITSM-konfigurasjonselement i agentgrensesnittet.';
    $Self->{Translation}->{'Required permissions to use the bulk ITSM configuration item screen in the agent interface.'} =
        'Nødvendige tillatelser for å bruke skjermbildet for ITSM-konfigurasjonselementer i agentgrensesnittet.';
    $Self->{Translation}->{'Required permissions to use the edit ITSM configuration item screen in the agent interface.'} =
        'Nødvendige tillatelser for å bruke skjermbildet Rediger ITSM-konfigurasjonselement i agentgrensesnittet.';
    $Self->{Translation}->{'Required permissions to use the history ITSM configuration item screen in the agent interface.'} =
        'Nødvendige tillatelser for å bruke skjermbildet for historikk for ITSM-konfigurasjonselementer i agentgrensesnittet.';
    $Self->{Translation}->{'Required permissions to use the print ITSM configuration item screen in the agent interface.'} =
        'Nødvendige tillatelser for å bruke skjermbildet for utskrift av ITSM-konfigurasjonselementer i agentgrensesnittet.';
    $Self->{Translation}->{'Required privileges to delete config items.'} = 'Nødvendige rettigheter for å slette konfigurasjonselementer.';
    $Self->{Translation}->{'Search config items.'} = 'Søk etter konfigurasjonsenheter.';
    $Self->{Translation}->{'Set the incident state of a CI automatically when a Ticket is Linked to a CI.'} =
        'Angi hendelsesstatus for en CI automatisk når en Ticket kobles til en CI.';
    $Self->{Translation}->{'Sets the deployment state in the configuration item bulk screen of the agent interface.'} =
        'Angir distribusjonsstatus i skjermbildet for konfigurasjonselementer i agentgrensesnittet.';
    $Self->{Translation}->{'Sets the incident state in the configuration item bulk screen of the agent interface.'} =
        'Angir hendelsesstatus i skjermbildet for konfigurasjonselementet i agentgrensesnittet.';
    $Self->{Translation}->{'Shows a link in the menu that allows linking a configuration item with another object in the config item zoom view of the agent interface.'} =
        'Viser en lenke i menyen som gjør det mulig å koble et konfigurasjonselement til et annet objekt i zoomvisningen for konfigurasjonselementer i agentgrensesnittet.';
    $Self->{Translation}->{'Shows a link in the menu to access the history of a configuration item in the configuration item overview of the agent interface.'} =
        'Viser en lenke i menyen for å få tilgang til historikken for et konfigurasjonselement i oversikten over konfigurasjonselementer i agentgrensesnittet.';
    $Self->{Translation}->{'Shows a link in the menu to access the history of a configuration item in the its zoom view of the agent interface.'} =
        'Viser en lenke i menyen for å få tilgang til historikken til et konfigurasjonselement i zoomvisningen av agentgrensesnittet.';
    $Self->{Translation}->{'Shows a link in the menu to delete a configuration item in its zoom view of the agent interface.'} =
        'Viser en lenke i menyen for å slette et konfigurasjonselement i zoomvisningen av agentgrensesnittet.';
    $Self->{Translation}->{'Shows a link in the menu to display the configuration item links as a Tree View.'} =
        'Viser en lenke i menyen for å vise konfigurasjonselementlenkene som en trevisning.';
    $Self->{Translation}->{'Shows a link in the menu to duplicate a configuration item in the configuration item overview of the agent interface.'} =
        'Viser en lenke i menyen for å duplisere et konfigurasjonselement i oversikten over konfigurasjonselementer i agentgrensesnittet.';
    $Self->{Translation}->{'Shows a link in the menu to duplicate a configuration item in the its zoom view of the agent interface.'} =
        'Viser en kobling i menyen for å duplisere et konfigurasjonselement i zoomvisningen av agentgrensesnittet.';
    $Self->{Translation}->{'Shows a link in the menu to edit a configuration item in the its zoom view of the agent interface.'} =
        'Viser en lenke i menyen for å redigere et konfigurasjonselement i zoomvisningen av agentgrensesnittet.';
    $Self->{Translation}->{'Shows a link in the menu to go back in the configuration item zoom view of the agent interface.'} =
        'Viser en lenke i menyen for å gå tilbake i zoomvisningen av konfigurasjonselementet i agentgrensesnittet.';
    $Self->{Translation}->{'Shows a link in the menu to print a configuration item in the its zoom view of the agent interface.'} =
        'Viser en lenke i menyen for å skrive ut et konfigurasjonselement i zoomvisningen av agentgrensesnittet.';
    $Self->{Translation}->{'Shows a link in the menu to zoom into a configuration item in the configuration item overview of the agent interface.'} =
        'Viser en lenke i menyen for å zoome inn på et konfigurasjonselement i oversikten over konfigurasjonselementer i agentgrensesnittet.';
    $Self->{Translation}->{'Shows the config item history (reverse ordered) in the agent interface.'} =
        'Viser konfigureringselementets historikk (i omvendt rekkefølge) i agentgrensesnittet.';
    $Self->{Translation}->{'The default category which is shown, if none is selected.'} = 'Standardkategorien som vises hvis ingen er valgt.';
    $Self->{Translation}->{'The identifier for a configuration item, e.g. ConfigItem#, MyConfigItem#. The default is ConfigItem#.'} =
        'Identifikatoren for et konfigurasjonselement, f.eks. ConfigItem#, MyConfigItem#. Standardinnstillingen er ConfigItem#.';
    $Self->{Translation}->{'Triggers ConfigItemFetch invoker automatically.'} = 'Utløser ConfigItemFetch-invokatoren automatisk.';
    $Self->{Translation}->{'Version String Expression'} = 'Versjonsstrenguttrykk';
    $Self->{Translation}->{'Version String Module'} = 'Versjonsstrengmodul';
    $Self->{Translation}->{'Version Trigger'} = 'Versjonsutløser';
    $Self->{Translation}->{'Whether the execution of ConfigItemACL can be avoided by checking cached field dependencies. This can improve loading times of formulars, but has to be disabled, if ACLModules are to be used for ITSMConfigItem- and Form-ReturnTypes.'} =
        'Om kjøringen av ConfigItemACL kan unngås ved å sjekke bufrede feltavhengigheter. Dette kan forbedre innlastingstiden for formularer, men må deaktiveres hvis ACLModules skal brukes for ITSMConfigItem- og Form-ReturnTypes.';
    $Self->{Translation}->{'Which general information is shown in the header.'} = 'Hvilken generell informasjon som vises i toppteksten.';
    $Self->{Translation}->{'With this option it´s possible to fill automaticly a CI field, depending on the count of linked CI´s with the existing type DependsOn.'} =
        'Med dette alternativet er det mulig å fylle ut et CI-felt automatisk, avhengig av antall koblede CI-er med den eksisterende typen DependsOn.';
    $Self->{Translation}->{'With this option it´s possible to fill automaticly a CI field, depending on the count of linked CI´s.'} =
        'Med dette alternativet er det mulig å fylle ut et CI-felt automatisk, avhengig av antall koblede CI-er.';
    $Self->{Translation}->{'With this option it´s possible to fill automaticly a CI field, depending on the count of linked CI´s. The setting CounterClassName include the name of the class and CounterFieldName is used to store the count of used licence.'} =
        'Med dette alternativet er det mulig å fylle ut et CI-felt automatisk, avhengig av antall koblede CI-er. Innstillingen CounterClassName inneholder navnet på klassen, og CounterFieldName brukes til å lagre antall brukte lisenser.';
    $Self->{Translation}->{'class'} = 'klasse';
    $Self->{Translation}->{'global'} = 'global';
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

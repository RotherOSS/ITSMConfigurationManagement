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

package Kernel::Language::et_ITSMConfigurationManagement;

use strict;
use warnings;
use utf8;

sub Data {
    my $Self = shift;

    # Template: AdminITSMConfigItem
    $Self->{Translation}->{'Config Item Management'} = 'Server OS';
    $Self->{Translation}->{'Change class definition'} = 'Muuda klassi määratlust';
    $Self->{Translation}->{'Change role definition'} = 'Muuda rolli määratlust';
    $Self->{Translation}->{'Ready2Import Class Bundles'} = 'Ready2Import klassikomplektid';
    $Self->{Translation}->{'Here you can import Ready2Import class bundles showcasing our most usual config items. Please note that some additional configuration may be required.'} =
        'Siit saate importida Ready2Import-klasside pakette, mis tutvustavad meie kõige tavalisemaid konfiguratsioonielemente. Pange tähele, et mõned täiendavad konfiguratsioonid võivad olla vajalikud.';
    $Self->{Translation}->{'Update existing entities'} = 'Olemasolevate üksuste ajakohastamine';
    $Self->{Translation}->{'Import Ready2Adopt class bundles'} = 'Impordi Ready2Adopt klassi paketid';
    $Self->{Translation}->{'Config Item Class'} = 'Config Item Class';
    $Self->{Translation}->{'Config Item Role'} = 'Config Item Role (seadistuselemendi roll)';

    # Template: AgentITSMConfigItemAdd
    $Self->{Translation}->{'Config Item'} = 'Config Item';
    $Self->{Translation}->{'Filter for Classes'} = 'Klasside filter';
    $Self->{Translation}->{'Select a Class from the list to create a new Config Item.'} = 'Uue Config Item\'i loomiseks valige nimekirjast klass.';
    $Self->{Translation}->{'Class'} = 'Klass';

    # Template: AgentITSMConfigItemBulk
    $Self->{Translation}->{'ITSM ConfigItem Bulk Action'} = 'ITSM ConfigItem Bulk Action';
    $Self->{Translation}->{'Deployment state'} = 'Kasutuselevõtu seisund';
    $Self->{Translation}->{'Incident state'} = 'Intsidentide olukord';
    $Self->{Translation}->{'Link to another'} = 'Link teisele';
    $Self->{Translation}->{'Invalid Configuration Item number!'} = 'Vigane konfiguratsiooni kirje number!';
    $Self->{Translation}->{'The number of another Configuration Item to link with.'} = 'Teise konfiguratsioonielemendi number, millega siduda.';

    # Template: AgentITSMConfigItemDelete
    $Self->{Translation}->{'Do you really want to delete this config item?'} = 'Võrk';

    # Template: AgentITSMConfigItemEdit
    $Self->{Translation}->{'The name of this config item'} = 'Selle konfiguratsioonielemendi nimi';
    $Self->{Translation}->{'Name is already in use by the ConfigItems with the following Number(s): %s'} =
        'Nimi on juba kasutusel ConfigItems\'i poolt järgmise(te) numbri(de)ga: %s';
    $Self->{Translation}->{'Version Number'} = 'Versiooni number';
    $Self->{Translation}->{'Version number of this config item'} = 'Selle konfiguratsioonielemendi versiooni number';
    $Self->{Translation}->{'Version Number is already in use by the ConfigItems with the following Number(s): %s'} =
        'Versiooninumber on juba kasutusel ConfigItems\'is, mille number(d) on järgmine(d): %s';
    $Self->{Translation}->{'Deployment State'} = 'Kasutuselevõtu riik';
    $Self->{Translation}->{'Incident State'} = 'Intsidentide riik';

    # Template: AgentITSMConfigItemHistory
    $Self->{Translation}->{'History of Config Item: %s'} = 'Config Item\'i ajalugu: %s';
    $Self->{Translation}->{'History Content'} = 'Ajalugu Sisu';
    $Self->{Translation}->{'Createtime'} = 'Createtime';
    $Self->{Translation}->{'Zoom view'} = 'Suurendusvaade';

    # Template: AgentITSMConfigItemOverviewNavBar
    $Self->{Translation}->{'Config Items per page'} = 'Config Items per page (seadistuselemendid lehekülje kohta)';

    # Template: AgentITSMConfigItemOverviewSmall
    $Self->{Translation}->{'No config item data found.'} = 'Config-elemendi andmeid ei leitud.';
    $Self->{Translation}->{'Select this config item'} = 'Valige see konfiguratsioonielement';

    # Template: AgentITSMConfigItemSearch
    $Self->{Translation}->{'Run Search'} = 'Käivita otsing';
    $Self->{Translation}->{'Also search in previous versions?'} = 'Otsi ka eelmistes versioonides?';

    # Template: AgentITSMConfigItemTreeView
    $Self->{Translation}->{'TreeView for ConfigItem'} = 'ConfigItem\'i TreeView';
    $Self->{Translation}->{'Depth Level'} = 'Sügavuse tase';
    $Self->{Translation}->{'Zoom In/Out'} = 'Suumimine sisse/välja';
    $Self->{Translation}->{'Max links level reached for ConfigItem!'} = 'ConfigItem\'i maksimaalne linkide tase on saavutatud!';

    # Template: AgentITSMConfigItemZoom
    $Self->{Translation}->{'Configuration Item'} = 'Konfigureerimisobjekt';
    $Self->{Translation}->{'Configuration Item Information'} = 'Konfigureerimiselemendi teave';
    $Self->{Translation}->{'Current Deployment State'} = 'Praegune kasutuselevõtu olukord';
    $Self->{Translation}->{'Current Incident State'} = 'Praegune juhtumite olukord';
    $Self->{Translation}->{'Last changed'} = 'Viimati muudetud';
    $Self->{Translation}->{'Last changed by'} = 'Viimati muutis';

    # Template: CustomerITSMConfigItem
    $Self->{Translation}->{'Your ConfigItems'} = 'Teie ConfigItems';

    # Template: CustomerITSMConfigItemSearch
    $Self->{Translation}->{'ConfigItem Search'} = 'ConfigItem otsing';

    # Template: AdminACL
    $Self->{Translation}->{'Object Type'} = 'Objekti tüüp';

    # JS Template: ClassImportConfirm
    $Self->{Translation}->{'The following classes will be imported'} = 'Imporditakse järgmised klassid';
    $Self->{Translation}->{'The following roles will be imported'} = 'Imporditakse järgmised rollid';
    $Self->{Translation}->{'Note that also corresponding dynamic fields and GeneralCatalog classes will be created and there is no automatic removal.'} =
        'Pange tähele, et ka vastavad dünaamilised väljad ja GeneralCatalogi klassid luuakse ja neid ei eemaldata automaatselt.';
    $Self->{Translation}->{'Do you want to proceed?'} = 'Kas soovite jätkata?';

    # Perl Module: Kernel/Modules/AdminITSMConfigItem.pm
    $Self->{Translation}->{'Need ExampleClasses!'} = 'Vajad ExampleClasses!';
    $Self->{Translation}->{'Definition is no valid YAML hash.'} = 'Määratlus ei ole kehtiv YAML-hash.';

    # Perl Module: Kernel/Modules/AgentITSMConfigItem.pm
    $Self->{Translation}->{'Overview: ITSM ConfigItem'} = 'Ülevaade: ITSM ConfigItem';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemBulk.pm
    $Self->{Translation}->{'No ConfigItemID is given!'} = 'ConfigItemID ei ole antud!';
    $Self->{Translation}->{'You need at least one selected Configuration Item!'} = 'Teil on vaja vähemalt ühte valitud konfiguratsioonielementi!';
    $Self->{Translation}->{'You don\'t have write access to this configuration item: %s.'} =
        'Teil ei ole sellele konfiguratsioonielemendile kirjutamisõigust: %s.';
    $Self->{Translation}->{'No definition was defined for class %s!'} = 'Klassile %s ei ole määratletud definitsiooni!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemDelete.pm
    $Self->{Translation}->{'Config item "%s" not found in database!'} = 'Config item "%s" ei ole andmebaasis leitud!';
    $Self->{Translation}->{'Was not able to delete the configitem ID %s!'} = 'Ei õnnestunud kustutada konfiguratsioonielementi ID %s!';
    $Self->{Translation}->{'No version found for ConfigItemID %s!'} = 'ConfigItemID %s jaoks ei leitud versiooni!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemEdit.pm
    $Self->{Translation}->{'No ConfigItemID, DuplicateID or ClassID is given!'} = 'ConfigItemID, DuplicateID või ClassID ei ole antud!';
    $Self->{Translation}->{'No access is given!'} = 'Juurdepääsu ei anta!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemHistory.pm
    $Self->{Translation}->{'Can\'t show history, no ConfigItemID is given!'} = 'Ei saa näidata ajalugu, ConfigItemID ei ole antud!';
    $Self->{Translation}->{'Can\'t show history, no access rights given!'} = 'Ei saa näidata ajalugu, juurdepääsuõigust ei ole antud!';
    $Self->{Translation}->{'New ConfigItem (ID=%s)'} = 'Uus ConfigItem (ID=%s)';
    $Self->{Translation}->{'New version (ID=%s)'} = 'Uus versioon (ID=%s)';
    $Self->{Translation}->{'Deployment state updated (new=%s, old=%s)'} = 'Üldiste kataloogi atribuutide näidisõiguste rühmade parameetrid.';
    $Self->{Translation}->{'Incident state updated (new=%s, old=%s)'} = 'Juhtumite seisundi uuendamine (new=%s, old=%s)';
    $Self->{Translation}->{'ConfigItem (ID=%s) deleted'} = 'ConfigItem (ID=%s) kustutatud';
    $Self->{Translation}->{'Link to %s (type=%s) added'} = 'Lisatud link %s (type=%s)';
    $Self->{Translation}->{'Link to %s (type=%s) deleted'} = 'Link %s (type=%s) kustutatud';
    $Self->{Translation}->{'ConfigItem definition updated (ID=%s)'} = 'ConfigItem määratlus uuendatud (ID=%s)';
    $Self->{Translation}->{'Name updated (new=%s, old=%s)'} = 'Nimi uuendatud (new=%s, old=%s)';
    $Self->{Translation}->{'Attribute %s updated from "%s" to "%s"'} = 'Ei saa näidata elementi, ConfigItemile ei ole antud juurdepääsuõigusi!';
    $Self->{Translation}->{'Version %s deleted'} = 'Versioon %s kustutatud';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemPrint.pm
    $Self->{Translation}->{'No ConfigItemID or VersionID is given!'} = 'ConfigItemID või VersionID ei ole antud!';
    $Self->{Translation}->{'Can\'t show config item, no access rights given!'} = 'Ei saa kuvada konfiguratsioonielementi, ei ole antud juurdepääsuõigusi!';
    $Self->{Translation}->{'ConfigItemID %s not found in database!'} = 'ConfigItemID %s ei leitud andmebaasis!';
    $Self->{Translation}->{'ConfigItem'} = 'ConfigItem';
    $Self->{Translation}->{'printed by %s at %s'} = 'trükitud %s poolt aadressil %s';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemSearch.pm
    $Self->{Translation}->{'Invalid ClassID!'} = 'Vale ClassID!';
    $Self->{Translation}->{'No ClassID is given!'} = 'ClassID ei ole antud!';
    $Self->{Translation}->{'No access rights for this class given!'} = 'Sellele klassile ei ole juurdepääsuõigust antud!';
    $Self->{Translation}->{'No Result!'} = 'Tulemust ei ole!';
    $Self->{Translation}->{'Config Item Search Results'} = 'Config Item otsingu tulemused';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemZoom.pm
    $Self->{Translation}->{'Can\'t show item, no access rights for ConfigItem are given!'} =
        'Ei saa näidata elementi, ConfigItemile ei ole antud juurdepääsuõigusi!';
    $Self->{Translation}->{'ConfigItem not found!'} = 'ConfigItem ei leitud!';
    $Self->{Translation}->{'No versions found!'} = 'Ühtegi versiooni ei leitud!';
    $Self->{Translation}->{'operational'} = 'operatiivne';
    $Self->{Translation}->{'warning'} = 'hoiatus';
    $Self->{Translation}->{'incident'} = 'juhtum';
    $Self->{Translation}->{'The deployment state of this config item'} = 'Selle konfiguratsioonielemendi kasutuselevõtu olek';
    $Self->{Translation}->{'The incident state of this config item'} = 'Selle konfiguratsioonielemendi intsidentne olek';

    # Perl Module: Kernel/Modules/CustomerITSMConfigItemSearch.pm
    $Self->{Translation}->{'No permission'} = 'Luba puudub';
    $Self->{Translation}->{'Filter invalid!'} = 'Filter kehtetu!';
    $Self->{Translation}->{'Search params invalid!'} = 'Search params kehtetu!';

    # Perl Module: Kernel/Output/HTML/Dashboard/ITSMConfigItemGeneric.pm
    $Self->{Translation}->{'Shown config items'} = 'Näidatud konfiguratsiooni elemendid';
    $Self->{Translation}->{'Deployment State Type'} = 'Kasutuselevõtu riigi tüüp';
    $Self->{Translation}->{'Current Incident State Type'} = 'Praegune õnnetusjuhtumi seisunditüüp';

    # Perl Module: Kernel/Output/HTML/ITSMConfigItem/LayoutDate.pm
    $Self->{Translation}->{'Between'} = 'Between';

    # Perl Module: Kernel/System/DynamicField/Driver/ConfigItem.pm
    $Self->{Translation}->{'Class restrictions for the config item'} = 'Klassi piirangud konfiguratsioonielemendi jaoks';
    $Self->{Translation}->{'Select one or more classes to restrict selectable config items'} =
        'Valige üks või mitu klassi, et piirata valitavaid konfiguratsioonielemente.';
    $Self->{Translation}->{'Link type'} = 'Lingi tüüp';
    $Self->{Translation}->{'Select the link type.'} = 'Valige lingi tüüp.';
    $Self->{Translation}->{'Forwards: Referencing (Source) -> Referenced (Target)'} = 'Forwardid: Viidatud (Allikas) -> Viidatud (Siht)';
    $Self->{Translation}->{'Backwards: Referenced (Source) -> Referencing (Target)'} = 'Tagasi: Viidatud (Allikas) -> Viitamine (Sihtmärk): Viidatud (Allikas) -> Viidatud (Sihtmärk)';
    $Self->{Translation}->{'Link Direction'} = 'Link Suund';
    $Self->{Translation}->{'The referencing object is the one containing this dynamic field, the referenced object is the one selected as value of the dynamic field.'} =
        'Viitav objekt on see, mis sisaldab seda dünaamilist välja, viidatav objekt on see, mis on valitud dünaamilise välja väärtuseks.';
    $Self->{Translation}->{'Dynamic (ConfigItem)'} = 'Dünaamiline (ConfigItem)';
    $Self->{Translation}->{'Static (Version)'} = 'Staatiline (versioon)';
    $Self->{Translation}->{'Link Referencing Type'} = 'Linkide viitamise tüüp';
    $Self->{Translation}->{'Whether this link applies to the ConfigItem or the static version of the referencing object. Current Incident State calculation only is performed on dynamic links.'} =
        'Kas see link kehtib viitava objekti ConfigItem\'i või staatilise versiooni kohta. Current Incident State\'i arvutamine toimub ainult dünaamiliste linkide puhul.';
    $Self->{Translation}->{'Select the attribute which config items will be searched by'} = 'Valige atribuut, mille järgi konfiguratsioonielemente otsitakse';

    # Perl Module: Kernel/System/ITSMConfigItem/Definition.pm
    $Self->{Translation}->{'Base structure is not valid. Please provide a hash with data in YAML format.'} =
        'Baasstruktuur ei ole kehtiv. Palun esitage YAML-vormingus andmete hash.';
    $Self->{Translation}->{'Starting the YAML string with \'---\' is required.'} = 'YAML-stringi alustamine sõnaga \'---\' on nõutav.';

    # Perl Module: Kernel/System/ITSMConfigItem/Link.pm
    $Self->{Translation}->{'Could not purge the table configitem_link.'} = 'Tabelit configitem_link ei õnnestunud puhastada.';
    $Self->{Translation}->{'No relevant dynamic fields were found'} = 'Asjakohaseid dünaamilisi välju ei leitud';
    $Self->{Translation}->{'Could not insert into the table configitem_link'} = 'Ei õnnestunud sisestada tabelisse configitem_link';
    $Self->{Translation}->{'Inserted 0 rows into the table configitem_link'} = 'Sisestatud 0 rida tabelisse configitem_link';

    # Perl Module: Kernel/System/ImportExport/ObjectBackend/ITSMConfigItem.pm
    $Self->{Translation}->{'Maximum number of one element'} = 'Ühe elemendi maksimaalne arv';
    $Self->{Translation}->{'Empty fields indicate that the current values are kept'} = 'Tühjad väljad näitavad, et praegused väärtused jäävad alles.';
    $Self->{Translation}->{'Skipped'} = 'Välja jäetud';

    # Perl Module: Kernel/Modules/AdminDynamicField.pm
    $Self->{Translation}->{'Error synchronizing the definitions. Please check the log.'} = 'Viga määratluste sünkroniseerimisel. Palun kontrollige logi.';
    $Self->{Translation}->{'You have ITSMConfigItem definitions which are not synchronized. Please deploy your ITSMConfigItem dynamic field changes.'} =
        'Teil on ITSMConfigItem määratlused, mis ei ole sünkroniseeritud. Palun võtke kasutusele oma ITSMConfigItem dünaamiliste väljade muudatused.';

    # Database XML / SOPM Definition: ITSMConfigurationManagement.sopm
    $Self->{Translation}->{'Expired'} = 'Aegunud';
    $Self->{Translation}->{'Maintenance'} = 'Hooldus';
    $Self->{Translation}->{'Pilot'} = 'Piloot';
    $Self->{Translation}->{'Planned'} = 'Planeeritud';
    $Self->{Translation}->{'Repair'} = 'Remont';
    $Self->{Translation}->{'Retired'} = 'Pensionile jäänud';
    $Self->{Translation}->{'Review'} = 'Ülevaade';
    $Self->{Translation}->{'Test/QA'} = 'Test/QA';

    # JS File: ITSM.Admin.ITSMConfigItem
    $Self->{Translation}->{'Overview and Confirmation'} = 'Ülevaade ja kinnitus';
    $Self->{Translation}->{'Importing classes/roles and their related fields'} = 'Klasside/rollide ja nendega seotud väljade importimine';
    $Self->{Translation}->{'An error occurred during class import.'} = 'Klassi importimisel tekkis viga.';

    # SysConfig
    $Self->{Translation}->{'0 - Hidden'} = '0 - peidetud';
    $Self->{Translation}->{'1 - Shown'} = '1 - näidatud';
    $Self->{Translation}->{'Allows extended search conditions in config item search of the agent interface. With this feature you can search e. g. config item name with this kind of conditions like "(*key1*&&*key2*)" or "(*key1*||*key2*)".'} =
        'Võimaldab laiendatud otsingutingimusi agentide kasutajaliidese konfiguratsioonielementide otsingus. Selle funktsiooniga saate otsida nt config-elemendi nime selliste tingimustega nagu "(*key1*&&*key2*)" või "(*key1*||*key2*)".';
    $Self->{Translation}->{'Allows extended search conditions in config item search of the customer interface. With this feature you can search e. g. config item name with this kind of conditions like "(*key1*&&*key2*)" or "(*key1*||*key2*)".'} =
        'Võimaldab laiendatud otsingutingimusi kliendi kasutajaliidese konfiguratsioonielemendi otsingus. Selle funktsiooniga saate otsida nt konfiguratsioonielemendi nime selliste tingimustega nagu "(*key1*&&*key2*)" või "(*key1*||*key2*)".';
    $Self->{Translation}->{'Assigned CIs'} = 'Määratud elutähtsad infrastruktuurid';
    $Self->{Translation}->{'At a specific time point create a ticket for config items, if the configured requirements are met. The time point is determined by the value of the field configured under "TimeCIKey" of the ConfigItem, and modified by "TimeModifier". If the latter can be either just a number, or a sign (+/-), a number, and an unit (d/h/m): "7" is equivalent to "+7d". The DynamicField "Ticket->DynamicField" will be used to mark created tickets - it has to exist. The flags \<OTOBO_CONFIGITEM_X\> where X can be NAME, NUMBER and DATE, will be substituted with the respective values in "Ticket->Text".'} =
        'Teatud ajahetkel loo pilet konfigureeritud elementide jaoks, kui konfigureeritud nõuded on täidetud. Ajahetk määratakse kindlaks ConfigItem\'i "TimeCIKey" all konfigureeritud välja väärtusega ja seda muudetakse "TimeModifier" abil. Kui viimane võib olla kas lihtsalt number või märk (+/-), number ja ühik (d/h/m): "7" vastab "+7d". DynamicFieldi "Ticket->DynamicField" kasutatakse loodud piletite märgistamiseks - see peab olema olemas. Lipud \\<OTOBO_CONFIGITEM_X\\>, kus X võib olla NAME, NUMBER ja DATE, asendatakse vastavate väärtustega jaotises "Ticket->Text".';
    $Self->{Translation}->{'CIs assigned to customer company'} = 'Klientidele määratud CId kliendiettevõttele';
    $Self->{Translation}->{'CIs assigned to customer user'} = 'Kliendikasutajale määratud CId';
    $Self->{Translation}->{'CMDB Settings'} = 'CMDB seaded';
    $Self->{Translation}->{'Check for a unique name only within the same ConfigItem class (\'class\') or globally (\'global\'), which means every existing ConfigItem is taken into account when looking for duplicates.'} =
        'Kontrollida unikaalset nime ainult sama ConfigItem klassi (\'class\') või globaalselt (\'global\'), mis tähendab, et dubleeringute otsimisel võetakse arvesse iga olemasolevat ConfigItem\'i.';
    $Self->{Translation}->{'Choose a module to enforce a naming scheme.'} = 'Valige moodul nimeskeemi jõustamiseks.';
    $Self->{Translation}->{'Choose a module to enforce a number scheme.'} = 'Valige moodul numbriskeemi jõustamiseks.';
    $Self->{Translation}->{'Choose a module to enforce a version string scheme.'} = 'Valige moodul, et kehtestada versioonijada skeem.';
    $Self->{Translation}->{'Choose attributes to trigger the creation of a new version.'} = 'Valige atribuudid, mis käivitavad uue versiooni loomise.';
    $Self->{Translation}->{'Choose categories to assign to this config item class.'} = 'Valige kategooriad, mis määratakse sellele konfiguratsioonielemendi klassile.';
    $Self->{Translation}->{'Column config item filters for ConfigItem Overview.'} = 'ConfigItem Overview veergu ConfigItem elemendi filtrid.';
    $Self->{Translation}->{'Columns that can be filtered in the config item overview of the agent interface. Note: Only Config Item attributes and Dynamic Fields (DynamicField_NameX) are allowed.'} =
        'Veerud, mida saab filtreerida agentide kasutajaliidese konfiguratsioonielemendi ülevaates. Märkus: Lubatud on ainult Config Item atribuudid ja dünaamilised väljad (DynamicField_NameX).';
    $Self->{Translation}->{'Columns that can be filtered in the config item overview of the customer interface. Note: Only Config Item attributes and Dynamic Fields (DynamicField_NameX) are allowed.'} =
        'Veerud, mida saab filtreerida kliendi kasutajaliidese konfiguratsioonielemendi ülevaates. Märkus: Lubatud on ainult Config Item atribuudid ja dünaamilised väljad (DynamicField_NameX).';
    $Self->{Translation}->{'Columns that can be filtered in the config item search result overview of the agent interface. Note: Only Config Item attributes and Dynamic Fields (DynamicField_NameX) are allowed.'} =
        'Veerud, mida saab filtreerida agentide kasutajaliidese konfiguratsioonielemendi otsingutulemuste ülevaates. Märkus: Lubatud on ainult Config Item atribuudid ja dünaamilised väljad (DynamicField_NameX).';
    $Self->{Translation}->{'Config Items'} = 'Konfigureerimisobjektid';
    $Self->{Translation}->{'Config item add.'} = 'Config item add.';
    $Self->{Translation}->{'Config item edit.'} = 'Config item edit.';
    $Self->{Translation}->{'Config item event module that count the licenses for OTOBOCILicenseCount feature.'} =
        'Config item event moodul, mis loeb OTOBOCILicenseCount funktsiooni jaoks litsentse.';
    $Self->{Translation}->{'Config item event module that enables logging to history in the agent interface.'} =
        'Config item event moodul, mis võimaldab agendi kasutajaliideses ajalukku logida.';
    $Self->{Translation}->{'Config item event module that updates config items to their current definition.'} =
        'Config elementide sündmuste moodul, mis uuendab config elemente nende praeguse määratluse järgi.';
    $Self->{Translation}->{'Config item event module that updates the table configitem_ĺink.'} =
        'Config item sündmuse moodul, mis uuendab tabelit configitem_ĺink.';
    $Self->{Translation}->{'Config item event module updates the current incident state.'} =
        'Config item\'i sündmuse moodul uuendab praegust intsidendi olekut.';
    $Self->{Translation}->{'Config item history.'} = 'Väljalaskeava';
    $Self->{Translation}->{'Config item print.'} = 'Config item print.';
    $Self->{Translation}->{'Config item zoom.'} = 'Config item zoom.';
    $Self->{Translation}->{'ConfigItem Tree View'} = 'ConfigItem Tree View';
    $Self->{Translation}->{'ConfigItem Version'} = 'ConfigItem versioon';
    $Self->{Translation}->{'ConfigItems of the following classes will not be stored on the Elasticsearch server. To apply this to existing CIs, the CI migration has to be run via console, after changing this option.'} =
        'Järgmiste klasside ConfigItems ei salvestata Elasticsearchi serverisse. Et seda olemasolevatele CI-dele rakendada, tuleb pärast selle valiku muutmist käivitada CI migratsioon konsooli kaudu.';
    $Self->{Translation}->{'ConfigItems with the following deployment states will not be stored on the Elasticsearch server. To apply this to existing CIs, the CI migration has to be run via console, after changing this option.'} =
        'ConfigItems, millel on järgmised kasutuselevõtu olekud, ei salvestata Elasticsearchi serverisse. Selle kohaldamiseks olemasolevatele CI-dele tuleb pärast selle valiku muutmist käivitada CI-migratsioon konsooli kaudu.';
    $Self->{Translation}->{'Configuration Item Limit'} = 'Konfigureerimisüksuse piirang';
    $Self->{Translation}->{'Configuration Item limit per page.'} = 'Konfiguratsioon Elementide piirarv lehekülje kohta.';
    $Self->{Translation}->{'Configuration Management Database.'} = 'Konfiguratsiooni juhtimise andmebaas.';
    $Self->{Translation}->{'Configuration item bulk module.'} = 'Konfiguratsioonielemendi lahtine moodul.';
    $Self->{Translation}->{'Configuration item search backend router of the agent interface.'} =
        'Konfigureerimiselemendi otsing agentide liidese tagasiside marsruuter.';
    $Self->{Translation}->{'Create and manage the definitions for Configuration Items.'} = 'Luua ja hallata konfiguratsiooniobjektide määratlusi.';
    $Self->{Translation}->{'Creates Tickets for ConfigItems at specific time points.'} = 'Loob ConfigItems\'i piletid teatud ajahetkedel.';
    $Self->{Translation}->{'Customers can see historic CI versions.'} = 'Kliendid saavad näha ajaloolisi CI-versioone.';
    $Self->{Translation}->{'Customers have the possibility to manually switch between historic CI versions.'} =
        'Klientidel on võimalus käsitsi vahetada varasemate CI-versioonide vahel.';
    $Self->{Translation}->{'Default data to use on attribute for config item search screen. Example: "ITSMConfigItemCreateTimePointFormat=year;ITSMConfigItemCreateTimePointStart=Last;ITSMConfigItemCreateTimePoint=2;".'} =
        'Vaikimisi andmed, mida kasutatakse atribuutide puhul konfiguratsioonielemendi otsingu ekraanil. Näide: "ITSMConfigItemCreateTimePointFormat=year;ITSMConfigItemCreateTimePointStart=Last;ITSMConfigItemCreateTimePoint=2;".';
    $Self->{Translation}->{'Default data to use on attribute for config item search screen. Example: "ITSMConfigItemCreateTimeStartYear=2010;ITSMConfigItemCreateTimeStartMonth=10;ITSMConfigItemCreateTimeStartDay=4;ITSMConfigItemCreateTimeStopYear=2010;ITSMConfigItemCreateTimeStopMonth=11;ITSMConfigItemCreateTimeStopDay=3;".'} =
        'Vaikimisi andmed, mida kasutatakse atribuutide puhul konfiguratsioonielemendi otsingu ekraanil. Näide: "ITSMConfigItemCreateTimeStartYear=2010;ITSMConfigItemCreateTimeStartMonth=10;ITSMConfigItemCreateTimeStartDay=4;ITSMConfigItemCreateTimeStopYear=2010;ITSMConfigItemCreateTimeStopMonth=11;ITSMConfigItemCreateTimeStopDay=3;".';
    $Self->{Translation}->{'Define Actions where a settings button is available in the linked objects widget (LinkObject::ViewMode = "complex"). Please note that these Actions must have registered the following JS and CSS files: Core.AllocationList.css, Core.UI.AllocationList.js, Core.UI.Table.Sort.js, Core.Agent.TableFilters.js and Core.Agent.LinkObject.js.'} =
        'Määrake toimingud, mille puhul on seotud objektide vidina (LinkObject::ViewMode = "complex") saadaval seadete nupp (LinkObject::ViewMode = "complex"). Pange tähele, et need toimingud peavad olema registreeritud järgmised JS- ja CSS-failid: Core.AllocationList.css, Core.UI.AllocationList.js, Core.UI.Table.Sort.js, Core.Agent.TableFilters.js ja Core.Agent.LinkObject.js.';
    $Self->{Translation}->{'Define a Template::Toolkit scheme for version strings. Only used if Version String Module is set to TemplateToolkit.'} =
        'Määrake malli::Toolkit skeem versiooni stringide jaoks. Kasutatakse ainult siis, kui Version String Module\'ile on määratud TemplateToolkit.';
    $Self->{Translation}->{'Define a set of conditions under which a customer is allowed to see a config item. Conditions can optionally be restricted to certain customer groups. Name is the only mandatory attribute. If no other options are given, all config items will be visible under that category.'} =
        'Määrake tingimused, mille alusel kliendil on lubatud konfiguratsioonielementi näha. Tingimusi saab valikuliselt piirata teatud kliendirühmadele. Nimi on ainus kohustuslik atribuut. Kui muid valikuid ei ole antud, on kõik konfiguratsioonielemendid selle kategooria all nähtavad.';
    $Self->{Translation}->{'Defines Required permissions to create ITSM configuration items using the Generic Interface.'} =
        'Määratleb nõutavad õigused ITSM-konfiguratsiooni elementide loomiseks, kasutades üldist liidest.';
    $Self->{Translation}->{'Defines Required permissions to delete ITSM configuration items using the Generic Interface.'} =
        'Määratleb nõutavad õigused ITSMi konfiguratsiooniobjektide kustutamiseks üldise liidese abil.';
    $Self->{Translation}->{'Defines Required permissions to get ITSM configuration items using the Generic Interface.'} =
        'Määratleb nõutavad õigused ITSMi konfiguratsioonielementide saamiseks üldise liidese abil.';
    $Self->{Translation}->{'Defines Required permissions to search ITSM configuration items using the Generic Interface.'} =
        'Määratleb nõutavad õigused ITSMi konfiguratsiooniobjektide otsimiseks üldise liidese abil.';
    $Self->{Translation}->{'Defines Required permissions to update ITSM configuration items using the Generic Interface.'} =
        'Kuvab menüüs lingi, mille abil saab seadistusobjekti redigeerida agentide kasutajaliidese suumivaates.';
    $Self->{Translation}->{'Defines an overview module to show the small view of a configuration item list.'} =
        'Määratleb ülevaatemooduli, mis näitab konfiguratsioonielementide loendi väikest vaadet.';
    $Self->{Translation}->{'Defines if the link type labels must be shown in the node connections.'} =
        'Määrab, kas lingitüübi sildid peavad olema kuvatud sõlmeühendustes.';
    $Self->{Translation}->{'Defines regular expressions individually for each ConfigItem class to check the ConfigItem name and to show corresponding error messages.'} =
        'Määratleb iga ConfigItem-klassi jaoks eraldi regulaaravaldised ConfigItem-nime kontrollimiseks ja vastavate veateadete kuvamiseks.';
    $Self->{Translation}->{'Defines the available columns of CIs in the config item overview depending on the CI class. Each entry must consist of a class name and an array of available fields for the corresponding class. Dynamic field entries have to honor the scheme DynamicField_FieldName.'} =
        'Määratleb CIde olemasolevad veerud konfiguratsioonielemendi ülevaates sõltuvalt CI-klassist. Iga kirje peab koosnema klassi nimest ja vastava klassi jaoks kättesaadavate väljade massiivi. Dünaamiliste väljade kirjed peavad järgima skeemi DynamicField_FieldName.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of the agent interface.'} =
        'Määratleb vaikimisi konfiguratsioonielemendi atribuudi, mis on vajalik agentide kasutajaliidese konfiguratsioonielemendi otsingutulemuse sorteerimiseks.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of the customer interface.'} =
        'Määrab vaikimisi konfiguratsioonielemendi atribuudi kliendi kasutajaliidese konfiguratsioonielemendi otsingutulemuse sorteerimiseks.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of this operation.'} =
        'Määrab vaikimisi konfiguratsioonielemendi atribuudi selle operatsiooni konfiguratsioonielemendi otsingutulemuse sorteerimiseks.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the agent interface. Up: oldest on top. Down: latest on top.'} =
        'Määrab vaikimisi konfiguratsioonielemendi järjekorra agentide kasutajaliidese konfiguratsioonielemendi otsingutulemuses. Üles: vanim on üleval. Alla: uusim üleval.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the customer interface. Up: oldest on top. Down: latest on top.'} =
        'Määrab vaikimisi konfiguratsioonielemendi järjekorra kliendi kasutajaliidese konfiguratsioonielemendi otsingutulemuses. Üles: vanim on üleval. Alla: uusim üleval.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the this operation. Up: oldest on top. Down: latest on top.'} =
        'Määrab vaikimisi konfiguratsioonielemendi järjekorra selle operatsiooni konfiguratsioonielemendi otsingutulemuses. Üles: vanim peal. Alla: uusim üleval.';
    $Self->{Translation}->{'Defines the default displayed columns of CIs in the config item overview depending on the CI class. Each entry must consist of a class name and an array of available fields for the corresponding class. Dynamic field entries have to honor the scheme DynamicField_FieldName.'} =
        'Määratleb CIde vaikimisi kuvatavad veerud konfiguratsioonielemendi ülevaates sõltuvalt CI-klassist. Iga kirje peab koosnema klassi nimest ja vastava klassi jaoks kättesaadavate väljade massiivi. Dünaamiliste väljade kirjed peavad järgima skeemi DynamicField_FieldName.';
    $Self->{Translation}->{'Defines the default relations depth to be shown.'} = 'Määrab vaikimisi kuvatavate suhete sügavuse.';
    $Self->{Translation}->{'Defines the default shown config item search attribute for config item search screen.'} =
        'Määratleb vaikimisi kuvatava konfiguratsioonielemendi otsingu atribuudi konfiguratsioonielemendi otsingu ekraanil.';
    $Self->{Translation}->{'Defines the default shown config item search attribute for config item search screen. Example: "Key" must have the name of the Dynamic Field in this case \'X\', "Content" must have the value of the Dynamic Field depending on the Dynamic Field type,  Text: \'a text\', Dropdown: \'1\', Date/Time: \'Search_DynamicField_XTimeSlotStartYear=1974; Search_DynamicField_XTimeSlotStartMonth=01; Search_DynamicField_XTimeSlotStartDay=26; Search_DynamicField_XTimeSlotStartHour=00; Search_DynamicField_XTimeSlotStartMinute=00; Search_DynamicField_XTimeSlotStartSecond=00; Search_DynamicField_XTimeSlotStopYear=2013; Search_DynamicField_XTimeSlotStopMonth=01; Search_DynamicField_XTimeSlotStopDay=26; Search_DynamicField_XTimeSlotStopHour=23; Search_DynamicField_XTimeSlotStopMinute=59; Search_DynamicField_XTimeSlotStopSecond=59;\' and or \'Search_DynamicField_XTimePointFormat=week; Search_DynamicField_XTimePointStart=Before; Search_DynamicField_XTimePointValue=7\';.'} =
        'Määratleb vaikimisi kuvatava konfiguratsioonielemendi otsingu atribuudi konfiguratsioonielemendi otsingu ekraanil. Näide: "Key" peab olema dünaamilise välja nimi, antud juhul \'X\', "Content" peab olema dünaamilise välja väärtus sõltuvalt dünaamilise välja tüübist, Text: \'a text\', Dropdown: \'1\', Date/Time: Search_DynamicField_XTimeSlotStartYear=1974; Search_DynamicField_XTimeSlotStartMonth=01; Search_DynamicField_XTimeSlotStartDay=26; Search_DynamicField_XTimeSlotStartHour=00; Search_DynamicField_XTimeSlotStartMinute=00; Search_DynamicField_XTimeSlotStartSecond=00; Search_DynamicField_XTimeSlotStopYear=2013; Search_DynamicField_XTimeSlotStopMonth=01; Search_DynamicField_XTimeSlotStopDay=26; Search_DynamicField_XTimeSlotStopHour=23; Search_DynamicField_XTimeSlotStopMinute=59; Search_DynamicField_XTimeSlotStopSecond=59;\' ja või \'Search_DynamicField_XTimePointFormat=week; Search_DynamicField_XTimePointStart=Before; Search_DynamicField_XTimePointValue=7\';.';
    $Self->{Translation}->{'Defines the default subobject of the class \'ITSMConfigItem\'.'} =
        'Määratleb klassi \'ITSMConfigItem\' vaikimisi alamobjekti.';
    $Self->{Translation}->{'Defines the height for the rich text editor component for this screen. Enter number (pixels) or percent value (relative).'} =
        '';
    $Self->{Translation}->{'Defines the number of rows for the CI definition editor in the admin interface.'} =
        'Määratleb CI määratluse redaktori ridade arvu haldusliideses.';
    $Self->{Translation}->{'Defines the order of incident states from high (e.g. cricital) to low (e.g. functional).'} =
        'Määratleb juhtumi seisundite järjekorra kõrgest (nt kritsiaalne) kuni madalani (nt funktsionaalne).';
    $Self->{Translation}->{'Defines the relevant deployment states where linked tickets can affect the status of a CI.'} =
        'Määratleb asjaomased kasutuselevõtu olekud, mille puhul seotud piletid võivad mõjutada CI olekut.';
    $Self->{Translation}->{'Defines the search limit for the AgentITSMConfigItem screen.'} =
        'Määratleb agentITSMConfigItem ekraani otsingupiirangu.';
    $Self->{Translation}->{'Defines the search limit for the AgentITSMConfigItemSearch screen.'} =
        'Määratleb otsingupiirangu ekraani AgentITSMConfigItemSearch jaoks.';
    $Self->{Translation}->{'Defines the search limit for the CustomerITSMConfigItem screen.'} =
        'Määrab otsingupiirangu ekraani CustomerITSMConfigItem jaoks.';
    $Self->{Translation}->{'Defines the search limit for the CustomerITSMConfigItemSearch screen.'} =
        'Määrab otsingupiirangu ekraanil CustomerITSMConfigItemSearch.';
    $Self->{Translation}->{'Defines the shown columns of CIs in the link table complex view for all CI classes. If there is no entry, then the default columns are shown.'} =
        'Määratleb kõikide CI-klasside jaoks lingitabelis kompleksvaates näidatud CIde veerud. Kui kanne puudub, kuvatakse vaikimisi veerud.';
    $Self->{Translation}->{'Defines the shown columns of CIs in the link table complex view, depending on the CI class. Each entry must be prefixed with the class name and double colons (i.e. Computer::). There are a few CI-Attributes that common to all CIs (example for the class Computer: Computer::Name, Computer::CurDeplState, Computer::CreateTime). To show individual CI-Attributes as defined in the CI-Definition, the following scheme must be used (example for the class Computer): Computer::HardDisk::1, Computer::HardDisk::1::Capacity::1, Computer::HardDisk::2, Computer::HardDisk::2::Capacity::1. If there is no entry for a CI class, then the default columns are shown.'} =
        'Määratleb lingitabelis kompleksvaates näidatud CIde veerud sõltuvalt CI-klassist. Iga kirje ees peab olema klassi nimi ja kaks koolonit (nt Computer::). On olemas mõned CI-Attribuudid, mis on kõigile CIdele ühised (näiteks klassi Computer: Computer::Name, Computer::CurDeplState, Computer::CreateTime). Üksikute CI-Attribuutide näitamiseks, nagu on määratletud CI-Definitsioonis, tuleb kasutada järgmist skeemi (näide klassi Computer puhul): Computer::HardDisk::1, Computer::HardDisk::1::Capacity::1, Computer::HardDisk::2, Computer::HardDisk::2::Capacity::1. Kui CI-klassi kohta puudub kanne, kuvatakse vaikimisi veerud.';
    $Self->{Translation}->{'Defines which items are available for \'Action\' in third level of the ITSM Config Item ACL structure.'} =
        'Määrab, millised elemendid on saadaval "Action" jaoks ITSM Config Item ACLi struktuuri kolmandal tasandil.';
    $Self->{Translation}->{'Defines which items are available in first level of the ITSM Config Item ACL structure.'} =
        'Määrab, millised elemendid on saadaval ITSM Config Item ACLi struktuuri esimesel tasandil.';
    $Self->{Translation}->{'Defines which items are available in second level of the ITSM Config Item ACL structure.'} =
        'Määrab, millised elemendid on saadaval ITSM Config Item ACLi struktuuri teisel tasandil.';
    $Self->{Translation}->{'Defines which type of link (named from the ticket perspective) can affect the status of a linked CI.'} =
        'Määrab, millist tüüpi link (nimega pileti vaatenurgast) võib mõjutada seotud CI staatust.';
    $Self->{Translation}->{'Defines which type of ticket can affect the status of a linked CI.'} =
        'Määrab, millist tüüpi piletid võivad mõjutada seotud CI staatust.';
    $Self->{Translation}->{'Definition Update'} = 'Määratluse ajakohastamine';
    $Self->{Translation}->{'Delete Configuration Item'} = 'Kustuta konfiguratsioonielement';
    $Self->{Translation}->{'DeplState'} = 'DeplState';
    $Self->{Translation}->{'Deployment State Color'} = 'Kasutuselevõtu olek Värv';
    $Self->{Translation}->{'DeploymentState'} = 'DeploymentState';
    $Self->{Translation}->{'Duplicate'} = 'Duplikaat';
    $Self->{Translation}->{'Dynamic field event module that marks config item definitions as out of sync, if containing dynamic fields change.'} =
        'Dünaamiliste väljade sündmuste moodul, mis märgib konfiguratsioonielemendi määratlused sünkroonist väljas olevaks, kui dünaamilisi välju sisaldavad dünaamilised väljad muutuvad.';
    $Self->{Translation}->{'Dynamic fields shown in the additional ITSM field screen of the agent interface.'} =
        'Dünaamilised väljad, mis kuvatakse agentide kasutajaliidese täiendavate ITSM-väljade ekraanil.';
    $Self->{Translation}->{'Dynamic fields shown in the config item overview screen of the customer interface.'} =
        'Dünaamilised väljad, mis kuvatakse kliendi kasutajaliidese konfiguratsioonielemendi ülevaate ekraanil.';
    $Self->{Translation}->{'Dynamic fields shown in the config item search screen of the agent interface.'} =
        'Dünaamilised väljad, mis kuvatakse agendi kasutajaliidese konfiguratsioonielemendi otsingu ekraanil.';
    $Self->{Translation}->{'Enables configuration item bulk action feature for the agent frontend to work on more than one configuration item at a time.'} =
        'Võimaldab konfiguratsioonielemendi massitegevuse funktsiooni, et agentide frontend saaks töötada korraga rohkem kui ühe konfiguratsioonielemendiga.';
    $Self->{Translation}->{'Enables configuration item bulk action feature only for the listed groups.'} =
        'Selle konfiguratsioonielemendi kasutuselevõtu olek';
    $Self->{Translation}->{'Enables/disables the functionality to check ITSM onfiguration items for unique names. Before enabling this option you should check your system for already existing config items with duplicate names. You can do this with the console command Admin::ITSM::Configitem::ListDuplicates.'} =
        'Võimaldab/välja lülitab ITSMi konfiguratsioonielementide kontrollimise funktsiooni unikaalsete nimede osas. Enne selle suvandi lubamist peaksite kontrollima oma süsteemi juba olemasolevate dubleerivate nimedega konfiguratsioonielementide suhtes. Seda saate teha konsooli käsuga Admin::ITSM::Configitem::ListDuplicates.';
    $Self->{Translation}->{'Event module to set configitem-status on ticket-configitem-link.'} =
        'Sündmuse moodul, et määrata configitem-status ticket-configitem-linkile.';
    $Self->{Translation}->{'Fields of the configuration item index, used for the fulltext search. Fields are also stored, but are not mandatory for the overall functionality. Inclusion of attachments can be disabled by setting the entry to 0 or deleting it.'} =
        'Konfiguratsioonielemendi indeksi väljad, mida kasutatakse täistekstiotsinguks. Väljad on samuti salvestatud, kuid ei ole üldise funktsionaalsuse jaoks kohustuslikud. Manuste lisamise saab keelata, kui määrata kirje väärtuseks 0 või kustutada see.';
    $Self->{Translation}->{'Fields stored in the configuration item index which are used for other things besides fulltext searches. For the complete functionality all fields are mandatory.'} =
        'Konfiguratsioonielemendi indeksisse salvestatud väljad, mida kasutatakse lisaks täistekstotsingutele ka muudeks asjadeks. Täieliku funktsionaalsuse tagamiseks on kõik väljad kohustuslikud.';
    $Self->{Translation}->{'For every webservice (key) an array of classes (value) can be defined on which the import is restricted. For all chosen classes, or all existing classes the identifying attributes will have to be chosen in the invoker config.'} =
        'Iga veebiteenuse (võti) jaoks saab määratleda klasside massiivi (väärtus), mille puhul on import piiratud. Kõigi valitud klasside või kõigi olemasolevate klasside jaoks tuleb invoker\'i konfiguratsioonis valida identifitseerivad atribuudid.';
    $Self->{Translation}->{'GenericInterface module registration for the ConfigItemFetch invoker layer.'} =
        'GenericInterface\'i mooduli registreerimine ConfigItemFetch kutsuva kihi jaoks.';
    $Self->{Translation}->{'ITSM ConfigItem'} = 'ITSM ConfigItem';
    $Self->{Translation}->{'ITSM config item overview.'} = 'ITSMi konfiguratsioonielemendi ülevaade.';
    $Self->{Translation}->{'If this option is activated, linked items are only counted if they belong to one of the listed classes.'} =
        'Kui see valik on aktiveeritud, arvestatakse lingitud elemendid ainult siis, kui nad kuuluvad ühte loetletud klassidest.';
    $Self->{Translation}->{'InciState'} = 'InciState';
    $Self->{Translation}->{'IncidentState'} = 'IncidentState';
    $Self->{Translation}->{'Includes deployment states in the config item search of the customer interface.'} =
        'Sisaldab kliendi kasutajaliidese konfiguratsioonielemendi otsingusse kasutuselevõtu olekuid.';
    $Self->{Translation}->{'Includes incident states in the config item search of the customer interface.'} =
        'Sisaldab kliendiliidese konfiguratsioonielemendi otsingusse intsidentide olekud.';
    $Self->{Translation}->{'Maximum number of config items to be displayed in the result of this operation.'} =
        'Selle operatsiooni tulemusel kuvatavate konfiguratsioonielementide maksimaalne arv.';
    $Self->{Translation}->{'Module to check the group responsible for a class.'} = 'Moodul, et kontrollida klassi eest vastutavat rühma.';
    $Self->{Translation}->{'Module to check the group responsible for a configuration item.'} =
        'Moodul, et kontrollida konfiguratsioonielemendi eest vastutavat rühma.';
    $Self->{Translation}->{'Module to generate ITSM config item statistics.'} = 'Moodul ITSM-i konfiguratsioonielementide statistika genereerimiseks.';
    $Self->{Translation}->{'Name Module'} = 'Nimi Moodul';
    $Self->{Translation}->{'Number Module'} = 'Numbrimoodul';
    $Self->{Translation}->{'Number of config items to be displayed in each page of a search result in the agent interface.'} =
        'Konfigureerimisobjektide arv, mis kuvatakse agendi kasutajaliideses igal otsingutulemuse lehel.';
    $Self->{Translation}->{'Number of config items to be displayed in each page of a search result in the customer interface.'} =
        'Klientide kasutajaliideses igal otsingutulemuse lehel kuvatavate konfiguratsioonielementide arv.';
    $Self->{Translation}->{'Objects to search for, how many entries and which attributs to show. ConfigItem attributes have to explicitly be stored via Elasticsearch.'} =
        'objektid, mida otsida, kui palju kirjeid ja milliseid atribuute näidata. ConfigItem atribuudid tuleb selgesõnaliselt salvestada Elasticsearchi kaudu.';
    $Self->{Translation}->{'Overview.'} = 'Ülevaade.';
    $Self->{Translation}->{'Parameters for the categories for config item classes in the preferences view of the agent interface.'} =
        'Parameetrid konfiguratsioonielemendi klasside kategooriate jaoks agentide kasutajaliidese eelistuste vaates.';
    $Self->{Translation}->{'Parameters for the column filters of the small config item overview. Please note: setting \'Active\' to 0 will only prevent agents from editing settings of this group in their personal preferences, but will still allow administrators to edit the settings of another user\'s behalf. Use \'PreferenceGroup\' to control in which area these settings should be shown in the user interface.'} =
        'Parameetrid väikese konfiguratsioonielemendi ülevaate veergude filtrite jaoks. Pange tähele: kui määrata \'Active\' väärtuseks 0, takistab see ainult agentidel selle grupi seadete muutmist oma isiklikes eelistustes, kuid lubab administraatoritel siiski teise kasutaja nimel seadete muutmist. Kasutage \'PreferenceGroup\', et kontrollida, millises piirkonnas neid seadeid kasutajaliideses näidatakse.';
    $Self->{Translation}->{'Parameters for the dashboard backend of the customer company config item overview of the agent interface . "Limit" is the number of entries shown by default. "Group" is used to restrict the access to the plugin (e. g. Group: admin;group1;group2;). "Default" determines if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" is the cache time in minutes for the plugin.'} =
        'Parameetrid armatuurlaua tagaküljel kliendi ettevõtte config item ülevaate agent liides . "Limit" on vaikimisi kuvatavate kirjete arv. "Group" kasutatakse pluginale juurdepääsu piiramiseks (nt Group: admin;group1;group2;). "Default" määrab, kas plugin on vaikimisi lubatud või peab kasutaja selle käsitsi lubama. "CacheTTLLocal" on pluginale määratud vahemälu aeg minutites.';
    $Self->{Translation}->{'Parameters for the deployment states color in the preferences view of the agent interface.'} =
        'Kasutuselevõtu olekute parameetrite värv agentide kasutajaliidese eelistuste vaates.';
    $Self->{Translation}->{'Parameters for the deployment states in the preferences view of the agent interface.'} =
        'kasutuselevõtu olekute parameetrid agentide kasutajaliidese eelistuste vaates.';
    $Self->{Translation}->{'Parameters for the example permission groups of the general catalog attributes.'} =
        'Üldiste kataloogi atribuutide näidisõiguste rühmade parameetrid.';
    $Self->{Translation}->{'Parameters for the name module for config item classes in the preferences view of the agent interface.'} =
        'Nimemooduli parameetrid konfigureeritud elemendiklasside jaoks agentide kasutajaliidese eelistuste vaates.';
    $Self->{Translation}->{'Parameters for the number module for config item classes in the preferences view of the agent interface.'} =
        'Parameetrid numbrimooduli jaoks konfigureeritud elemendiklasside jaoks agentide kasutajaliidese eelistuste vaates.';
    $Self->{Translation}->{'Parameters for the pages (in which the configuration items are shown).'} =
        'Lehekülgede parameetrid (kus kuvatakse konfiguratsioonielemente).';
    $Self->{Translation}->{'Parameters for the version string module for config item classes in the preferences view of the agent interface.'} =
        'Parameetrid versiooni stringi mooduli jaoks config elementide klasside jaoks agentide liidese eelistuste vaates.';
    $Self->{Translation}->{'Parameters for the version string template toolkit module for config item classes in the preferences view of the agent interface.'} =
        'Parameetrid versiooni stringi malli tööriistakomplekti mooduli jaoks konfigureeritud elemendiklasside jaoks agentide liidese eelistuste vaates.';
    $Self->{Translation}->{'Parameters for the version trigger for config item classes in the preferences view of the agent interface.'} =
        'Parameetrid versiooni käivitamiseks konfiguratsioonielemendi klasside jaoks agentide liidese eelistuste vaates.';
    $Self->{Translation}->{'Performs the configured action for each event (as an Invoker) for each configured Webservice.'} =
        'Teostab seadistatud toimingu iga sündmuse jaoks (kui kutsuja) iga konfigureeritud veebiteenuse jaoks.';
    $Self->{Translation}->{'Permission Group'} = 'Loa grupp';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item attachment action in the agent interface.'} =
        'Nõutavad õigused ITSMi konfiguratsioonielemendi kinnitamise toimingu kasutamiseks agendi kasutajaliideses.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item screen in the agent interface.'} =
        'Vajalikud õigused ITSMi konfiguratsioonielemendi ekraani kasutamiseks agentide kasutajaliideses.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item search screen in the agent interface.'} =
        'Vajalikud õigused ITSMi konfiguratsioonielemendi otsingu ekraani kasutamiseks agendi kasutajaliideses.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item search screen in the customer interface.'} =
        'Nõutavad õigused ITSMi konfiguratsioonielemendi otsingu ekraani kasutamiseks kliendi kasutajaliideses.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item tree view screen in the agent interface.'} =
        'Vajalikud õigused ITSMi konfiguratsioonielemendi puu vaate ekraani kasutamiseks agentide kasutajaliideses.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item zoom screen in the agent interface.'} =
        'Vajalikud õigused ITSMi konfiguratsioonielemendi suumimisekraani kasutamiseks agendi kasutajaliideses.';
    $Self->{Translation}->{'Required permissions to use the add ITSM configuration item screen in the agent interface.'} =
        'Vajalikud õigused, et kasutada ITSMi konfiguratsioonielemendi lisamise ekraani agentide kasutajaliideses.';
    $Self->{Translation}->{'Required permissions to use the bulk ITSM configuration item screen in the agent interface.'} =
        'Vajalikud õigused, et kasutada ITSMi masskonfiguratsiooni elemendi ekraani agentide kasutajaliideses.';
    $Self->{Translation}->{'Required permissions to use the edit ITSM configuration item screen in the agent interface.'} =
        'Vajalikud õigused, et kasutada ITSMi konfiguratsioonielemendi redigeerimise ekraani agentide kasutajaliideses.';
    $Self->{Translation}->{'Required permissions to use the history ITSM configuration item screen in the agent interface.'} =
        'Vajalikud õigused, et kasutada ITSMi konfiguratsioonielemendi ajaloo ekraani agentide kasutajaliideses.';
    $Self->{Translation}->{'Required permissions to use the print ITSM configuration item screen in the agent interface.'} =
        'Vajalikud õigused, et kasutada ITSMi konfiguratsioonielemendi ekraani printimine agentide kasutajaliideses.';
    $Self->{Translation}->{'Required privileges to delete config items.'} = 'Nõutavad õigused konfiguratsioonielementide kustutamiseks.';
    $Self->{Translation}->{'Search config items.'} = 'Otsi konfigureeritud elemente.';
    $Self->{Translation}->{'Set the incident state of a CI automatically when a Ticket is Linked to a CI.'} =
        'Seadistage CI intsidendi staatus automaatselt, kui pilet on seotud CIga.';
    $Self->{Translation}->{'Sets the deployment state in the configuration item bulk screen of the agent interface.'} =
        'Määrab kasutuselevõtu oleku agentide kasutajaliidese konfiguratsioonielemendi hulgiaknas.';
    $Self->{Translation}->{'Sets the incident state in the configuration item bulk screen of the agent interface.'} =
        'Määrab intsidendi oleku agentide liidese konfiguratsioonielemendi hulgiaknas.';
    $Self->{Translation}->{'Shows a link in the menu that allows linking a configuration item with another object in the config item zoom view of the agent interface.'} =
        'preproduktiivne';
    $Self->{Translation}->{'Shows a link in the menu to access the history of a configuration item in the configuration item overview of the agent interface.'} =
        'Kuvab menüüs lingi, mille abil pääseb konfiguratsioonielemendi ajalukku agentide kasutajaliidese konfiguratsioonielemendi ülevaates.';
    $Self->{Translation}->{'Shows a link in the menu to access the history of a configuration item in the its zoom view of the agent interface.'} =
        'Kuvab menüüs lingi, mille abil saab juurdepääsu konfiguratsioonielemendi ajaloole agendi kasutajaliidese suumivaates.';
    $Self->{Translation}->{'Shows a link in the menu to delete a configuration item in its zoom view of the agent interface.'} =
        'Kuvab menüüs lingi, mille abil saab kustutada konfiguratsioonielementi oma agendi kasutajaliidese suumivaates.';
    $Self->{Translation}->{'Shows a link in the menu to display the configuration item links as a Tree View.'} =
        'Kuvab menüüs lingi, et kuvada konfiguratsioonielementide lingid puuvaatena.';
    $Self->{Translation}->{'Shows a link in the menu to duplicate a configuration item in the configuration item overview of the agent interface.'} =
        'Kuvab menüüs lingi, mille abil saab konfigureerimisobjekti dubleerida agentide kasutajaliidese konfiguratsiooniobjektide ülevaates.';
    $Self->{Translation}->{'Shows a link in the menu to duplicate a configuration item in the its zoom view of the agent interface.'} =
        'Kuvab menüüs lingi, mille abil saab konfigureerimisobjekti dubleerida selle suumivaates agentide kasutajaliideses.';
    $Self->{Translation}->{'Shows a link in the menu to edit a configuration item in the its zoom view of the agent interface.'} =
        'Kuvab menüüs lingi, mille abil saab seadistusobjekti redigeerida agentide kasutajaliidese suumivaates.';
    $Self->{Translation}->{'Shows a link in the menu to go back in the configuration item zoom view of the agent interface.'} =
        'Näitab menüüs linki, mille abil saab minna tagasi agentide kasutajaliidese konfiguratsioonielemendi suumivaates.';
    $Self->{Translation}->{'Shows a link in the menu to print a configuration item in the its zoom view of the agent interface.'} =
        'Kuvab menüüs lingi, et printida konfiguratsioonielementi selle suumivaates agendi kasutajaliideses.';
    $Self->{Translation}->{'Shows a link in the menu to zoom into a configuration item in the configuration item overview of the agent interface.'} =
        'Näitab menüüs linki, mille abil saab konfiguratsioonielementi suurendama asjandusliidese konfiguratsioonielemendi ülevaates.';
    $Self->{Translation}->{'Shows the config item history (reverse ordered) in the agent interface.'} =
        'Näitab konfigureeritud elemendi ajalugu (vastupidises järjekorras) agendi kasutajaliideses.';
    $Self->{Translation}->{'The default category which is shown, if none is selected.'} = 'Vaikimisi kategooria, mis kuvatakse, kui ükski kategooria ei ole valitud.';
    $Self->{Translation}->{'The identifier for a configuration item, e.g. ConfigItem#, MyConfigItem#. The default is ConfigItem#.'} =
        'Konfiguratsioonielemendi identifikaator, nt ConfigItem#, MyConfigItem#. Vaikimisi on ConfigItem#.';
    $Self->{Translation}->{'Triggers ConfigItemFetch invoker automatically.'} = 'Käivitab ConfigItemFetch-i kutsuja automaatselt.';
    $Self->{Translation}->{'Version String Expression'} = 'Versioon String Väljend';
    $Self->{Translation}->{'Version String Module'} = 'Versiooni string moodul';
    $Self->{Translation}->{'Version Trigger'} = 'Versiooni vallandaja';
    $Self->{Translation}->{'Whether the execution of ConfigItemACL can be avoided by checking cached field dependencies. This can improve loading times of formulars, but has to be disabled, if ACLModules are to be used for ITSMConfigItem- and Form-ReturnTypes.'} =
        'Kas ConfigItemACLi täitmist saab vältida, kontrollides vahemälu väljaliste sõltuvusi. See võib parandada vormide laadimisaega, kuid tuleb keelata, kui ACLModules\'i kasutatakse ITSMConfigItem- ja Form-ReturnTypes\'i puhul.';
    $Self->{Translation}->{'Which general information is shown in the header.'} = 'Millised üldandmed on esitatud päises.';
    $Self->{Translation}->{'With this option it´s possible to fill automaticly a CI field, depending on the count of linked CI´s with the existing type DependsOn.'} =
        'Selle valikuga on võimalik automaatselt täita CI-välja, sõltuvalt olemasoleva tüübiga DependsOn seotud CI-de arvust.';
    $Self->{Translation}->{'With this option it´s possible to fill automaticly a CI field, depending on the count of linked CI´s.'} =
        'Selle valikuga on võimalik automaatselt täita CI-välja, sõltuvalt seotud CI-de arvust.';
    $Self->{Translation}->{'With this option it´s possible to fill automaticly a CI field, depending on the count of linked CI´s. The setting CounterClassName include the name of the class and CounterFieldName is used to store the count of used licence.'} =
        'Selle valikuga on võimalik automaatselt täita CI-välja, sõltuvalt seotud CI-de arvust. Seade CounterClassName sisaldab klassi nime ja CounterFieldName salvestab kasutatud litsentsi arvu.';
    $Self->{Translation}->{'class'} = 'klass';
    $Self->{Translation}->{'global'} = 'globaalne';
    $Self->{Translation}->{'postproductive'} = 'postproduktiivne';
    $Self->{Translation}->{'preproductive'} = 'preproduktiivne';
    $Self->{Translation}->{'productive'} = 'produktiivne';


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

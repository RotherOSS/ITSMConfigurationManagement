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

package Kernel::Language::fi_ITSMConfigurationManagement;

use strict;
use warnings;
use utf8;

sub Data {
    my $Self = shift;

    # Template: AdminITSMConfigItem
    $Self->{Translation}->{'Config Item Management'} = 'Config Item Management';
    $Self->{Translation}->{'Change class definition'} = 'Muuta luokan määritelmää';
    $Self->{Translation}->{'Change role definition'} = 'Muuta roolin määritelmää';
    $Self->{Translation}->{'Ready2Import Class Bundles'} = 'Ready2Import-luokkakokonaisuudet';
    $Self->{Translation}->{'Here you can import Ready2Import class bundles showcasing our most usual config items. Please note that some additional configuration may be required.'} =
        'Täältä voit tuoda Ready2Import-luokkakokonaisuuksia, jotka esittelevät tavallisimpia konfigurointikohteitamme. Huomaa, että joitakin lisäkonfiguraatioita saatetaan tarvita.';
    $Self->{Translation}->{'Update existing entities'} = 'Päivitetään olemassa olevat yksiköt';
    $Self->{Translation}->{'Import Ready2Adopt class bundles'} = 'Tuo Ready2Adopt-luokan nippuja';
    $Self->{Translation}->{'Config Item Class'} = 'Config Item -luokka';
    $Self->{Translation}->{'Config Item Role'} = 'Config Item rooli';

    # Template: AgentITSMConfigItemAdd
    $Self->{Translation}->{'Config Item'} = 'Config Item';
    $Self->{Translation}->{'Filter for Classes'} = 'Luokkien suodatin';
    $Self->{Translation}->{'Select a Class from the list to create a new Config Item.'} = 'Valitse luokka luettelosta luodaksesi uuden Config Itemin.';
    $Self->{Translation}->{'Class'} = 'Luokka';

    # Template: AgentITSMConfigItemBulk
    $Self->{Translation}->{'ITSM ConfigItem Bulk Action'} = 'ITSM ConfigItem Bulk-toiminto';
    $Self->{Translation}->{'Deployment state'} = 'Käyttöönoton tila';
    $Self->{Translation}->{'Incident state'} = 'Tapahtuman tila';
    $Self->{Translation}->{'Link to another'} = 'Linkki toiseen';
    $Self->{Translation}->{'Invalid Configuration Item number!'} = 'Virheellinen konfigurointikohteen numero!';
    $Self->{Translation}->{'The number of another Configuration Item to link with.'} = 'Toisen kokoonpanokohteen numero, johon linkitetään.';

    # Template: AgentITSMConfigItemDelete
    $Self->{Translation}->{'Do you really want to delete this config item?'} = 'Haluatko todella poistaa tämän konfiguraatioelementin?';

    # Template: AgentITSMConfigItemEdit
    $Self->{Translation}->{'The name of this config item'} = 'Tämän konfiguraatioelementin nimi';
    $Self->{Translation}->{'Name is already in use by the ConfigItems with the following Number(s): %s'} =
        'Nimi on jo käytössä ConfigItems-kohteissa seuraavalla numerolla (seuraavilla numeroilla): %s.';
    $Self->{Translation}->{'Version Number'} = 'Version numero';
    $Self->{Translation}->{'Version number of this config item'} = '';
    $Self->{Translation}->{'Version Number is already in use by the ConfigItems with the following Number(s): %s'} =
        'Versioluku on jo käytössä ConfigItemsissa, joilla on seuraava(t) numero(t): %s';
    $Self->{Translation}->{'Deployment State'} = 'Käyttöönoton tila';
    $Self->{Translation}->{'Incident State'} = 'Tapahtuman tila';

    # Template: AgentITSMConfigItemHistory
    $Self->{Translation}->{'History of Config Item: %s'} = 'Config Itemin historia: %s';
    $Self->{Translation}->{'History Content'} = 'Historia Sisältö';
    $Self->{Translation}->{'Createtime'} = 'Createtime';
    $Self->{Translation}->{'Zoom view'} = 'Zoomausnäkymä';

    # Template: AgentITSMConfigItemOverviewNavBar
    $Self->{Translation}->{'Config Items per page'} = 'Config Kohteet per sivu';

    # Template: AgentITSMConfigItemOverviewSmall
    $Self->{Translation}->{'No config item data found.'} = 'Konfigurointikohdetietoja ei löytynyt.';
    $Self->{Translation}->{'Select this config item'} = 'Valitse tämä konfigurointikohta';

    # Template: AgentITSMConfigItemSearch
    $Self->{Translation}->{'Run Search'} = 'Suorita haku';
    $Self->{Translation}->{'Also search in previous versions?'} = 'Myös haku aiemmissa versioissa?';

    # Template: AgentITSMConfigItemTreeView
    $Self->{Translation}->{'TreeView for ConfigItem'} = 'ConfigItem-puunäkymä';
    $Self->{Translation}->{'Depth Level'} = 'Syvyystaso';
    $Self->{Translation}->{'Zoom In/Out'} = 'Zoomaus sisään/ulos';
    $Self->{Translation}->{'Max links level reached for ConfigItem!'} = 'ConfigItemin enimmäislinkkien taso saavutettu!';

    # Template: AgentITSMConfigItemZoom
    $Self->{Translation}->{'Configuration Item'} = 'Konfigurointi Kohde';
    $Self->{Translation}->{'Configuration Item Information'} = 'Konfigurointikohteen tiedot';
    $Self->{Translation}->{'Current Deployment State'} = 'Nykyinen käyttöönottotilanne';
    $Self->{Translation}->{'Current Incident State'} = 'Nykyinen tapahtumatilanne';
    $Self->{Translation}->{'Last changed'} = 'Viimeksi muutettu';
    $Self->{Translation}->{'Last changed by'} = 'Viimeksi muuttanut';

    # Template: CustomerITSMConfigItem
    $Self->{Translation}->{'Your ConfigItems'} = 'Sinun ConfigItems';

    # Template: CustomerITSMConfigItemSearch
    $Self->{Translation}->{'ConfigItem Search'} = 'ConfigItem-haku';

    # Template: AdminACL
    $Self->{Translation}->{'Object Type'} = 'Kohteen tyyppi';

    # JS Template: ClassImportConfirm
    $Self->{Translation}->{'The following classes will be imported'} = 'Seuraavat luokat tuodaan';
    $Self->{Translation}->{'The following roles will be imported'} = 'Seuraavat roolit tuodaan';
    $Self->{Translation}->{'Note that also corresponding dynamic fields and GeneralCatalog classes will be created and there is no automatic removal.'} =
        'Huomaa, että myös vastaavat dynaamiset kentät ja GeneralCatalog-luokat luodaan, eikä niitä poisteta automaattisesti.';
    $Self->{Translation}->{'Do you want to proceed?'} = 'Haluatteko jatkaa?';

    # Perl Module: Kernel/Modules/AdminITSMConfigItem.pm
    $Self->{Translation}->{'Need ExampleClasses!'} = 'Tarvitaan ExampleClasses!';
    $Self->{Translation}->{'Definition is no valid YAML hash.'} = 'Määritelmä ei ole kelvollinen YAML-hash.';

    # Perl Module: Kernel/Modules/AgentITSMConfigItem.pm
    $Self->{Translation}->{'Overview: ITSM ConfigItem'} = 'Yleiskatsaus: ITSM ConfigItem';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemBulk.pm
    $Self->{Translation}->{'No ConfigItemID is given!'} = 'ConfigItemID:tä ei ole annettu!';
    $Self->{Translation}->{'You need at least one selected Configuration Item!'} = 'Tarvitset vähintään yhden valitun määrityskohteen!';
    $Self->{Translation}->{'You don\'t have write access to this configuration item: %s.'} =
        'Sinulla ei ole kirjoitusoikeutta tähän määrityskohteeseen: %s.';
    $Self->{Translation}->{'No definition was defined for class %s!'} = 'Luokalle %s ei ole määritelty määritelmää!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemDelete.pm
    $Self->{Translation}->{'Config item "%s" not found in database!'} = 'Konfiguraatioelementtiä "%s" ei löydy tietokannasta!';
    $Self->{Translation}->{'Was not able to delete the configitem ID %s!'} = 'Konfigikohdetunnusta %s ei pystytty poistamaan!';
    $Self->{Translation}->{'No version found for ConfigItemID %s!'} = 'ConfigItemID %s:lle ei löytynyt versiota!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemEdit.pm
    $Self->{Translation}->{'No ConfigItemID, DuplicateID or ClassID is given!'} = 'ConfigItemID-, DuplicateID- tai ClassID-numeroa ei ole annettu!';
    $Self->{Translation}->{'No access is given!'} = 'Pääsyä ei anneta!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemHistory.pm
    $Self->{Translation}->{'Can\'t show history, no ConfigItemID is given!'} = 'Historiaa ei voi näyttää, koska ConfigItemID:tä ei ole annettu!';
    $Self->{Translation}->{'Can\'t show history, no access rights given!'} = 'Historiaa ei voi näyttää, koska käyttöoikeuksia ei ole annettu!';
    $Self->{Translation}->{'New ConfigItem (ID=%s)'} = 'Uusi ConfigItem (ID=%s)';
    $Self->{Translation}->{'New version (ID=%s)'} = 'Uusi versio (ID=%s)';
    $Self->{Translation}->{'Deployment state updated (new=%s, old=%s)'} = 'Yleisen luettelon attribuuttien esimerkkioikeusryhmien parametrit.';
    $Self->{Translation}->{'Incident state updated (new=%s, old=%s)'} = 'Tapahtuman tila päivitetty (new=%s, old=%s)';
    $Self->{Translation}->{'ConfigItem (ID=%s) deleted'} = 'ConfigItem (ID=%s) poistettu.';
    $Self->{Translation}->{'Link to %s (type=%s) added'} = 'Linkki %s (type=%s) lisätty.';
    $Self->{Translation}->{'Link to %s (type=%s) deleted'} = 'Linkki %s (type=%s) poistettu';
    $Self->{Translation}->{'ConfigItem definition updated (ID=%s)'} = 'ConfigItem-määritelmä päivitetty (ID=%s)';
    $Self->{Translation}->{'Name updated (new=%s, old=%s)'} = 'Nimi päivitetty (uusi=%s, vanha=%s)';
    $Self->{Translation}->{'Attribute %s updated from "%s" to "%s"'} = 'Attribuutti %s päivitetty "%s"-arvosta "%s" arvoon "%s".';
    $Self->{Translation}->{'Version %s deleted'} = 'Versio %s poistettu';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemPrint.pm
    $Self->{Translation}->{'No ConfigItemID or VersionID is given!'} = 'ConfigItemID- tai VersionID-numeroa ei ole annettu!';
    $Self->{Translation}->{'Can\'t show config item, no access rights given!'} = 'Konfiguraatioelementtiä ei voi näyttää, koska käyttöoikeuksia ei ole annettu!';
    $Self->{Translation}->{'ConfigItemID %s not found in database!'} = 'ConfigItemID %s ei löydy tietokannasta!';
    $Self->{Translation}->{'ConfigItem'} = 'ConfigItem';
    $Self->{Translation}->{'printed by %s at %s'} = 'tulostanut %s osoitteessa %s';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemSearch.pm
    $Self->{Translation}->{'Invalid ClassID!'} = 'Väärä ClassID!';
    $Self->{Translation}->{'No ClassID is given!'} = 'ClassID:tä ei ole annettu!';
    $Self->{Translation}->{'No access rights for this class given!'} = 'Tälle luokalle ei ole annettu käyttöoikeuksia!';
    $Self->{Translation}->{'No Result!'} = 'Ei tulosta!';
    $Self->{Translation}->{'Config Item Search Results'} = 'Config Item hakutulokset';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemZoom.pm
    $Self->{Translation}->{'Can\'t show item, no access rights for ConfigItem are given!'} =
        'Elementtiä ei voi näyttää, ConfigItemille ei ole annettu käyttöoikeuksia!';
    $Self->{Translation}->{'ConfigItem not found!'} = 'ConfigItem ei löytynyt!';
    $Self->{Translation}->{'No versions found!'} = 'Versioita ei löytynyt!';
    $Self->{Translation}->{'operational'} = 'toiminta';
    $Self->{Translation}->{'warning'} = 'varoitus';
    $Self->{Translation}->{'incident'} = 'tapahtuma';
    $Self->{Translation}->{'The deployment state of this config item'} = 'Tämän konfiguraatioelementin käyttöönottotila';
    $Self->{Translation}->{'The incident state of this config item'} = 'Tämän konfiguraatioelementin tapahtumatila';

    # Perl Module: Kernel/Modules/CustomerITSMConfigItemSearch.pm
    $Self->{Translation}->{'No permission'} = 'Ei lupaa';
    $Self->{Translation}->{'Filter invalid!'} = 'Suodatin on virheellinen!';
    $Self->{Translation}->{'Search params invalid!'} = 'Search params invalid!';

    # Perl Module: Kernel/Output/HTML/Dashboard/ITSMConfigItemGeneric.pm
    $Self->{Translation}->{'Shown config items'} = 'Näytetyt konfigurointikohteet';
    $Self->{Translation}->{'Deployment State Type'} = 'Käyttöönottotilan tyyppi';
    $Self->{Translation}->{'Current Incident State Type'} = 'Nykyinen tapahtumatila Tyyppi';

    # Perl Module: Kernel/Output/HTML/ITSMConfigItem/LayoutDate.pm
    $Self->{Translation}->{'Between'} = 'Välillä';

    # Perl Module: Kernel/System/DynamicField/Driver/ConfigItem.pm
    $Self->{Translation}->{'Class restrictions for the config item'} = 'Luokkarajoitukset konfigurointikohdetta varten';
    $Self->{Translation}->{'Select one or more classes to restrict selectable config items'} =
        'Valitse yksi tai useampi luokka rajoittaaksesi valittavissa olevia konfiguraatiokohteita.';
    $Self->{Translation}->{'Link type'} = 'Linkin tyyppi';
    $Self->{Translation}->{'Select the link type.'} = 'Valitse linkin tyyppi.';
    $Self->{Translation}->{'Forwards: Referencing (Source) -> Referenced (Target)'} = 'Hyökkääjät: Viittaus (Lähde) -> Viitattu (Kohde)';
    $Self->{Translation}->{'Backwards: Referenced (Source) -> Referencing (Target)'} = 'Takaperin: Viitattu (Lähde) -> Viittaus (Kohde).';
    $Self->{Translation}->{'Link Direction'} = 'Linkki Suunta';
    $Self->{Translation}->{'The referencing object is the one containing this dynamic field, the referenced object is the one selected as value of the dynamic field.'} =
        'Viittaava objekti on se, joka sisältää tämän dynaamisen kentän, ja viitattu objekti on se, joka on valittu dynaamisen kentän arvoksi.';
    $Self->{Translation}->{'Dynamic (ConfigItem)'} = 'Dynaaminen (ConfigItem)';
    $Self->{Translation}->{'Static (Version)'} = 'Static (versio)';
    $Self->{Translation}->{'Link Referencing Type'} = 'Linkki Viittaustyyppi';
    $Self->{Translation}->{'Whether this link applies to the ConfigItem or the static version of the referencing object. Current Incident State calculation only is performed on dynamic links.'} =
        'Koskeeko tämä linkki ConfigItem-objektia vai viittaavan objektin staattista versiota. Current Incident State -laskenta suoritetaan vain dynaamisille linkeille.';
    $Self->{Translation}->{'Select the attribute which config items will be searched by'} = 'Valitse attribuutti, jonka mukaan konfigurointikohteita etsitään.';

    # Perl Module: Kernel/System/ITSMConfigItem/Definition.pm
    $Self->{Translation}->{'Starting the YAML string with \'---\' is required.'} = 'YAML-merkkijono on aloitettava kirjaimella \'---\'.';

    # Perl Module: Kernel/System/ITSMConfigItem/Link.pm
    $Self->{Translation}->{'Could not purge the table configitem_link.'} = 'Taulukkoa configitem_link ei voitu tyhjentää.';
    $Self->{Translation}->{'No relevant dynamic fields were found'} = 'Merkityksellisiä dynaamisia kenttiä ei löytynyt';
    $Self->{Translation}->{'Could not insert into the table configitem_link'} = 'Taulukkoon configitem_link ei voitu lisätä tietoja.';
    $Self->{Translation}->{'Inserted 0 rows into the table configitem_link'} = 'Lisätty 0 riviä taulukkoon configitem_linkki';

    # Perl Module: Kernel/System/ImportExport/ObjectBackend/ITSMConfigItem.pm
    $Self->{Translation}->{'Maximum number of one element'} = 'Yhden elementin enimmäismäärä';
    $Self->{Translation}->{'Empty fields indicate that the current values are kept'} = 'Tyhjät kentät osoittavat, että nykyiset arvot säilytetään.';
    $Self->{Translation}->{'Skipped'} = 'Ohitettu';

    # Perl Module: Kernel/Modules/AdminDynamicField.pm
    $Self->{Translation}->{'Error synchronizing the definitions. Please check the log.'} = 'Virhe määritelmien synkronoinnissa. Tarkista loki.';
    $Self->{Translation}->{'You have ITSMConfigItem definitions which are not synchronized. Please deploy your ITSMConfigItem dynamic field changes.'} =
        'Sinulla on ITSMConfigItem-määrityksiä, joita ei ole synkronoitu. Ota käyttöön ITSMConfigItem-dynaamisten kenttien muutokset.';

    # Database XML / SOPM Definition: ITSMConfigurationManagement.sopm
    $Self->{Translation}->{'Expired'} = 'Vanhentunut';
    $Self->{Translation}->{'Maintenance'} = 'Huolto';
    $Self->{Translation}->{'Pilot'} = 'Pilotti';
    $Self->{Translation}->{'Planned'} = 'Suunniteltu';
    $Self->{Translation}->{'Repair'} = 'Korjaus';
    $Self->{Translation}->{'Retired'} = 'Eläkkeellä';
    $Self->{Translation}->{'Review'} = 'Arvostelu';
    $Self->{Translation}->{'Test/QA'} = 'Testi/QA';

    # JS File: ITSM.Admin.ITSMConfigItem
    $Self->{Translation}->{'Overview and Confirmation'} = 'Yleiskatsaus ja vahvistus';
    $Self->{Translation}->{'Importing classes/roles and their related fields'} = '';
    $Self->{Translation}->{'An error occurred during class import.'} = 'Luokan tuonnin aikana tapahtui virhe.';

    # SysConfig
    $Self->{Translation}->{'0 - Hidden'} = '0 - Piilotettu';
    $Self->{Translation}->{'1 - Shown'} = '1 - Kuvassa';
    $Self->{Translation}->{'Allows extended search conditions in config item search of the agent interface. With this feature you can search e. g. config item name with this kind of conditions like "(*key1*&&*key2*)" or "(*key1*||*key2*)".'} =
        'Mahdollistaa laajennetut hakuehdot agentin käyttöliittymän konfigurointikohdehaussa. Tämän ominaisuuden avulla voit hakea esim. konfiguraatioelementin nimeä tällaisilla ehdoilla kuten "(*key1*&&*key2*)" tai "(*key1*||*key2*)".';
    $Self->{Translation}->{'Allows extended search conditions in config item search of the customer interface. With this feature you can search e. g. config item name with this kind of conditions like "(*key1*&&*key2*)" or "(*key1*||*key2*)".'} =
        'Mahdollistaa laajennetut hakuehdot asiakkaan käyttöliittymän konfiguraatiokohteiden haussa. Tämän ominaisuuden avulla voit hakea esim. konfiguraatioelementin nimeä tällaisilla ehdoilla kuten "(*key1*&&*key2*)" tai "(*key1*||*key2*)".';
    $Self->{Translation}->{'Assigned CIs'} = 'Myönnetyt CI:t';
    $Self->{Translation}->{'CIs assigned to customer company'} = 'Asiakasyritykselle osoitetut CI:t';
    $Self->{Translation}->{'CIs assigned to customer user'} = 'Asiakaskäyttäjälle määritetyt CI:t';
    $Self->{Translation}->{'CMDB Settings'} = 'CMDB-asetukset';
    $Self->{Translation}->{'Check for a unique name only within the same ConfigItem class (\'class\') or globally (\'global\'), which means every existing ConfigItem is taken into account when looking for duplicates.'} =
        'Tarkista, että nimi on yksilöllinen vain saman ConfigItem-luokan (\'class\') sisällä tai globaalisti (\'global\'), mikä tarkoittaa, että jokainen olemassa oleva ConfigItem otetaan huomioon, kun etsitään kaksoiskappaleita.';
    $Self->{Translation}->{'Choose a module to enforce a naming scheme.'} = 'Valitse moduuli nimeämissuunnitelman käyttöönottoa varten.';
    $Self->{Translation}->{'Choose a module to enforce a number scheme.'} = 'Valitse moduuli numerojärjestelmän käyttöönottoa varten.';
    $Self->{Translation}->{'Choose a module to enforce a version string scheme.'} = 'Valitse moduuli, joka ottaa käyttöön versiojonojärjestelmän.';
    $Self->{Translation}->{'Choose attributes to trigger the creation of a new version.'} = 'Valitse attribuutit, jotka käynnistävät uuden version luomisen.';
    $Self->{Translation}->{'Choose categories to assign to this config item class.'} = 'Valitse luokat, jotka osoitetaan tälle määrityskohdeluokalle.';
    $Self->{Translation}->{'Column config item filters for ConfigItem Overview.'} = 'Sarakkeen ConfigItem-kohteen suodattimet ConfigItem Overview -kohteelle.';
    $Self->{Translation}->{'Columns that can be filtered in the config item overview of the agent interface. Note: Only Config Item attributes and Dynamic Fields (DynamicField_NameX) are allowed.'} =
        'Sarakkeet, joita voidaan suodattaa agentin käyttöliittymän määrityskohteiden yleiskatsauksessa. Huomautus: Vain Config Item -attribuutit ja dynaamiset kentät (DynamicField_NameX) ovat sallittuja.';
    $Self->{Translation}->{'Columns that can be filtered in the config item overview of the customer interface. Note: Only Config Item attributes and Dynamic Fields (DynamicField_NameX) are allowed.'} =
        'Sarakkeet, joita voidaan suodattaa asiakkaan käyttöliittymän määrityskohteiden yleiskatsauksessa. Huomautus: Vain Config Item -attribuutit ja dynaamiset kentät (DynamicField_NameX) ovat sallittuja.';
    $Self->{Translation}->{'Columns that can be filtered in the config item search result overview of the agent interface. Note: Only Config Item attributes and Dynamic Fields (DynamicField_NameX) are allowed.'} =
        '';
    $Self->{Translation}->{'Config Items'} = 'Määrityskohteet';
    $Self->{Translation}->{'Config item add.'} = 'Määrityskohteen lisääminen.';
    $Self->{Translation}->{'Config item edit.'} = 'Määrityskohteen muokkaus.';
    $Self->{Translation}->{'Config item event module that enables logging to history in the agent interface.'} =
        'Määritä kohteen tapahtumamoduuli, joka mahdollistaa kirjaamisen historiaan agentin käyttöliittymässä.';
    $Self->{Translation}->{'Config item event module that updates config items to their current definition.'} =
        'Konfig-kohteen tapahtumamoduuli, joka päivittää konfig-kohteet niiden nykyiseen määritelmään.';
    $Self->{Translation}->{'Config item event module that updates the table configitem_ĺink.'} =
        'Config item -tapahtumamoduuli, joka päivittää taulukon configitem_ĺink.';
    $Self->{Translation}->{'Config item event module updates the current incident state.'} =
        'Config item -tapahtumamoduuli päivittää nykyisen tapahtumatilan.';
    $Self->{Translation}->{'Config item history.'} = 'Määritä kohteen historia.';
    $Self->{Translation}->{'Config item print.'} = 'Määrityskohteen tulostus.';
    $Self->{Translation}->{'Config item zoom.'} = 'Määritä kohteen zoomaus.';
    $Self->{Translation}->{'ConfigItem Tree View'} = 'ConfigItem-puunäkymä';
    $Self->{Translation}->{'ConfigItem Version'} = 'ConfigItem Version';
    $Self->{Translation}->{'ConfigItems of the following classes will not be stored on the Elasticsearch server. To apply this to existing CIs, the CI migration has to be run via console, after changing this option.'} =
        'Seuraavien luokkien ConfigItems-elementtejä ei tallenneta Elasticsearch-palvelimelle. Jotta tätä voidaan soveltaa olemassa oleviin CI:hin, CI-siirto on suoritettava konsolin kautta tämän vaihtoehdon muuttamisen jälkeen.';
    $Self->{Translation}->{'ConfigItems with the following deployment states will not be stored on the Elasticsearch server. To apply this to existing CIs, the CI migration has to be run via console, after changing this option.'} =
        'ConfigItems-kohteita, joilla on seuraavat käyttöönottotilat, ei tallenneta Elasticsearch-palvelimelle. Jotta tätä voidaan soveltaa olemassa oleviin CI:hin, CI-siirto on suoritettava konsolin kautta tämän vaihtoehdon muuttamisen jälkeen.';
    $Self->{Translation}->{'Configuration Item Limit'} = 'Konfigurointi Kohteen raja';
    $Self->{Translation}->{'Configuration Item limit per page.'} = 'Konfigurointi Kohteen raja sivua kohti.';
    $Self->{Translation}->{'Configuration Management Database.'} = 'Konfiguraationhallinnan tietokanta.';
    $Self->{Translation}->{'Configuration item bulk module.'} = 'Määrityskohteen irtotavaramoduuli.';
    $Self->{Translation}->{'Configuration item search backend router of the agent interface.'} =
        'Määrityskohteen haku agenttiliittymän taustareitittimeen.';
    $Self->{Translation}->{'Create and manage the definitions for Configuration Items.'} = 'Luo ja hallitse määrittelyjä määrityskohteille.';
    $Self->{Translation}->{'Customers can see historic CI versions.'} = 'Asiakkaat voivat nähdä historialliset CI-versiot.';
    $Self->{Translation}->{'Customers have the possibility to manually switch between historic CI versions.'} =
        'Asiakkailla on mahdollisuus vaihtaa manuaalisesti historiallisten CI-versioiden välillä.';
    $Self->{Translation}->{'Default data to use on attribute for config item search screen. Example: "ITSMConfigItemCreateTimePointFormat=year;ITSMConfigItemCreateTimePointStart=Last;ITSMConfigItemCreateTimePoint=2;".'} =
        'Oletusarvoiset tiedot, joita käytetään määritteen määrittelykohteen hakunäytössä. Esimerkki: "ITSMConfigItemCreateTimePointFormat=year;ITSMConfigItemCreateTimePointStart=Last;ITSMConfigItemCreateTimePoint=2;".';
    $Self->{Translation}->{'Default data to use on attribute for config item search screen. Example: "ITSMConfigItemCreateTimeStartYear=2010;ITSMConfigItemCreateTimeStartMonth=10;ITSMConfigItemCreateTimeStartDay=4;ITSMConfigItemCreateTimeStopYear=2010;ITSMConfigItemCreateTimeStopMonth=11;ITSMConfigItemCreateTimeStopDay=3;".'} =
        'Oletusarvoiset tiedot, joita käytetään määritteen määrittelykohteen hakunäytössä. Esimerkki: "ITSMConfigItemCreateTimeStartYear=2010;ITSMConfigItemCreateTimeStartMonth=10;ITSMConfigItemCreateTimeStartDay=4;ITSMConfigItemCreateTimeStopYear=2010;ITSMConfigItemCreateTimeStopMonth=11;ITSMConfigItemCreateTimeStopDay=3;".';
    $Self->{Translation}->{'Define Actions where a settings button is available in the linked objects widget (LinkObject::ViewMode = "complex"). Please note that these Actions must have registered the following JS and CSS files: Core.AllocationList.css, Core.UI.AllocationList.js, Core.UI.Table.Sort.js, Core.Agent.TableFilters.js and Core.Agent.LinkObject.js.'} =
        'Määritä toiminnot, joissa asetuspainike on käytettävissä linkitettyjen objektien widgetissä (LinkObject::ViewMode = "complex"). Huomaa, että näillä toiminnoilla on oltava rekisteröidyt seuraavat JS- ja CSS-tiedostot: Core.UI.AllocationList.js, Core.UI.Table.Sort.js, Core.Agent.TableFilters.js ja Core.Agent.LinkObject.js.';
    $Self->{Translation}->{'Define a Template::Toolkit scheme for version strings. Only used if Version String Module is set to TemplateToolkit.'} =
        'Määritä Template::Toolkit-skeema versiojonoja varten. Käytetään vain, jos Version String Module -moduulin arvoksi on asetettu TemplateToolkit.';
    $Self->{Translation}->{'Define a set of conditions under which a customer is allowed to see a config item. Conditions can optionally be restricted to certain customer groups. Name is the only mandatory attribute. If no other options are given, all config items will be visible under that category.'} =
        'Määritä joukko ehtoja, joiden mukaisesti asiakas saa nähdä konfigurointikohteen. Ehdot voidaan valinnaisesti rajoittaa tiettyihin asiakasryhmiin. Nimi on ainoa pakollinen määrite. Jos muita vaihtoehtoja ei anneta, kaikki konfigurointikohteet näkyvät kyseisessä luokassa.';
    $Self->{Translation}->{'Defines Required permissions to create ITSM configuration items using the Generic Interface.'} =
        'Määrittää vaaditut oikeudet ITSM-kokoonpanokohteiden luomiseen yleisen käyttöliittymän avulla.';
    $Self->{Translation}->{'Defines Required permissions to delete ITSM configuration items using the Generic Interface.'} =
        'Määrittää vaaditut oikeudet ITSM-kokoonpanokohteiden poistamiseen yleisen käyttöliittymän avulla.';
    $Self->{Translation}->{'Defines Required permissions to get ITSM configuration items using the Generic Interface.'} =
        'Määrittää vaaditut oikeudet ITSM-kokoonpanokohteiden hakemiseen yleisen käyttöliittymän avulla.';
    $Self->{Translation}->{'Defines Required permissions to search ITSM configuration items using the Generic Interface.'} =
        'Määrittää vaaditut oikeudet ITSM-kokoonpanokohteiden hakuun yleisen käyttöliittymän avulla.';
    $Self->{Translation}->{'Defines Required permissions to update ITSM configuration items using the Generic Interface.'} =
        'Määrittää vaaditut oikeudet ITSM-kokoonpanokohteiden päivittämiseen yleisen käyttöliittymän avulla.';
    $Self->{Translation}->{'Defines an overview module to show the small view of a configuration item list.'} =
        'Määrittää yleiskatsausmoduulin, joka näyttää kokoonpanokohdeluettelon pienen näkymän.';
    $Self->{Translation}->{'Defines if the link type labels must be shown in the node connections.'} =
        'Määrittää, onko linkin tyypin merkinnät näytettävä solmujen yhteyksissä.';
    $Self->{Translation}->{'Defines regular expressions individually for each ConfigItem class to check the ConfigItem name and to show corresponding error messages.'} =
        'Määrittää säännölliset lausekkeet erikseen kullekin ConfigItem-luokalle ConfigItem-nimen tarkistamiseksi ja vastaavien virheilmoitusten näyttämiseksi.';
    $Self->{Translation}->{'Defines the available columns of CIs in the config item overview depending on the CI class. Each entry must consist of a class name and an array of available fields for the corresponding class. Dynamic field entries have to honor the scheme DynamicField_FieldName.'} =
        'Määrittää käytettävissä olevat CI-sarakkeet konfigurointikohteen yleiskatsauksessa CI-luokan mukaan. Jokaisen merkinnän on koostuttava luokan nimestä ja kyseisen luokan käytettävissä olevien kenttien joukosta. Dynaamisten kenttien merkintöjen on noudatettava kaavaa DynamicField_FieldName.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of the agent interface.'} =
        'Määrittää oletusarvoisen konfigurointikohdetta koskevan attribuutin agenttiliittymän konfigurointikohdehakutuloksen lajittelua varten.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of the customer interface.'} =
        'Määrittää oletusarvoisen konfiguraatiokohdeattribuutin asiakkaan käyttöliittymän konfiguraatiokohteiden hakutuloksen lajittelua varten.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of this operation.'} =
        'Määrittää oletusarvoisen konfiguraatiokohteen attribuutin konfiguraatiokohteen lajittelua varten tämän toiminnon konfiguraatiokohteen hakutuloksessa.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the agent interface. Up: oldest on top. Down: latest on top.'} =
        'Määrittää konfiguraatiokohteiden oletusjärjestyksen agenttiliittymän konfiguraatiokohteiden hakutuloksissa. Ylös: vanhin päällimmäisenä. Alas: uusin on päällimmäisenä.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the customer interface. Up: oldest on top. Down: latest on top.'} =
        'Määrittää konfiguraatiokohteiden oletusjärjestyksen asiakkaan käyttöliittymän konfiguraatiokohteiden hakutuloksissa. Ylös: vanhin päällimmäisenä. Alas: uusin on ylhäällä.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the this operation. Up: oldest on top. Down: latest on top.'} =
        'Määrittää konfiguraatiokohteiden oletusjärjestyksen tämän toiminnon konfiguraatiokohteiden hakutuloksessa. Ylös: Vanhin on ylhäällä. Alas: uusin on ylhäällä.';
    $Self->{Translation}->{'Defines the default displayed columns of CIs in the config item overview depending on the CI class. Each entry must consist of a class name and an array of available fields for the corresponding class. Dynamic field entries have to honor the scheme DynamicField_FieldName.'} =
        'Määrittää CI:iden oletussarakkeet, jotka näkyvät konfigurointikohteen yleiskatsauksessa CI-luokasta riippuen. Jokaisen merkinnän on koostuttava luokan nimestä ja kyseisen luokan käytettävissä olevien kenttien joukosta. Dynaamisten kenttien merkintöjen on noudatettava kaavaa DynamicField_FieldName.';
    $Self->{Translation}->{'Defines the default relations depth to be shown.'} = 'Määrittää näytettävien suhteiden oletussyvyyden.';
    $Self->{Translation}->{'Defines the default shown config item search attribute for config item search screen.'} =
        'Määrittää oletusarvoisesti näytettävän konfiguraatiokohteen hakuattribuutin konfiguraatiokohteen hakunäytölle.';
    $Self->{Translation}->{'Defines the default shown config item search attribute for config item search screen. Example: "Key" must have the name of the Dynamic Field in this case \'X\', "Content" must have the value of the Dynamic Field depending on the Dynamic Field type,  Text: \'a text\', Dropdown: \'1\', Date/Time: \'Search_DynamicField_XTimeSlotStartYear=1974; Search_DynamicField_XTimeSlotStartMonth=01; Search_DynamicField_XTimeSlotStartDay=26; Search_DynamicField_XTimeSlotStartHour=00; Search_DynamicField_XTimeSlotStartMinute=00; Search_DynamicField_XTimeSlotStartSecond=00; Search_DynamicField_XTimeSlotStopYear=2013; Search_DynamicField_XTimeSlotStopMonth=01; Search_DynamicField_XTimeSlotStopDay=26; Search_DynamicField_XTimeSlotStopHour=23; Search_DynamicField_XTimeSlotStopMinute=59; Search_DynamicField_XTimeSlotStopSecond=59;\' and or \'Search_DynamicField_XTimePointFormat=week; Search_DynamicField_XTimePointStart=Before; Search_DynamicField_XTimePointValue=7\';.'} =
        'Määrittää oletusarvoisesti näytettävän konfiguraatiokohteen hakuattribuutin konfiguraatiokohteen hakunäytölle. Esimerkki: "Avain" on oltava dynaamisen kentän nimi tässä tapauksessa \'X\', "Sisältö" on oltava dynaamisen kentän arvo dynaamisen kentän tyypistä riippuen, Teksti: \'teksti\', Pudotusvalikko: \'1\', Päivämäärä/Aika: \'Search_DynamicField_XTimeSlotStartYear=1974; Search_DynamicField_XTimeSlotStartMonth=01; Search_DynamicField_XTimeSlotStartDay=26; Search_DynamicField_XTimeSlotStartHour=00; Search_DynamicField_XTimeSlotStartMinute=00; Search_DynamicField_XTimeSlotStartSecond=00; Search_DynamicField_XTimeSlotStopYear=2013; Search_DynamicField_XTimeSlotStopMonth=01; Search_DynamicField_XTimeSlotStopDay=26; Search_DynamicField_XTimeSlotStopHour=23; Search_DynamicField_XTimeSlotStopMinute=59; Search_DynamicField_XTimeSlotStopSecond=59;\' ja tai \'Search_DynamicField_XTimePointFormat=week; Search_DynamicField_XTimePointStart=Before; Search_DynamicField_XTimePointValue=7\';.';
    $Self->{Translation}->{'Defines the default subobject of the class \'ITSMConfigItem\'.'} =
        'Määrittää luokan \'ITSMConfigItem\' oletusarvoisen aliobjektin.';
    $Self->{Translation}->{'Defines the number of rows for the CI definition editor in the admin interface.'} =
        'Määrittää hallintakäyttöliittymän CI-määrittelyeditorin rivien määrän.';
    $Self->{Translation}->{'Defines the order of incident states from high (e.g. cricital) to low (e.g. functional).'} =
        'Määrittää tapahtumatilojen järjestyksen korkeasta (esim. sydänkohtaus) matalaan (esim. toiminnallinen).';
    $Self->{Translation}->{'Defines the relevant deployment states where linked tickets can affect the status of a CI.'} =
        'Määrittää asiaankuuluvat käyttöönottotilat, joissa linkitetyt liput voivat vaikuttaa CI:n tilaan.';
    $Self->{Translation}->{'Defines the search limit for the AgentITSMConfigItem screen.'} =
        'Määrittää AgentITSMConfigItem-näytön hakurajan.';
    $Self->{Translation}->{'Defines the search limit for the AgentITSMConfigItemSearch screen.'} =
        'Määrittää AgentITSMConfigItemSearch-näytön hakurajan.';
    $Self->{Translation}->{'Defines the search limit for the CustomerITSMConfigItem screen.'} =
        'Määrittää CustomerITSMConfigItem-näytön hakurajan.';
    $Self->{Translation}->{'Defines the search limit for the CustomerITSMConfigItemSearch screen.'} =
        'Määrittää CustomerITSMConfigItemSearch-näytön hakurajan.';
    $Self->{Translation}->{'Defines the shown columns of CIs in the link table complex view for all CI classes. If there is no entry, then the default columns are shown.'} =
        'Määrittää kaikkien CI-luokkien yhteystietotaulukon monitahoisessa näkymässä näkyvät CI-sarakkeet. Jos merkintää ei ole, näytetään oletussarakkeet.';
    $Self->{Translation}->{'Defines the shown columns of CIs in the link table complex view, depending on the CI class. Each entry must be prefixed with the class name and double colons (i.e. Computer::). There are a few CI-Attributes that common to all CIs (example for the class Computer: Computer::Name, Computer::CurDeplState, Computer::CreateTime). To show individual CI-Attributes as defined in the CI-Definition, the following scheme must be used (example for the class Computer): Computer::HardDisk::1, Computer::HardDisk::1::Capacity::1, Computer::HardDisk::2, Computer::HardDisk::2::Capacity::1. If there is no entry for a CI class, then the default columns are shown.'} =
        'Määrittää linkkitaulukon monitahoisessa näkymässä näkyvät CI-sarakkeet CI-luokasta riippuen. Jokaisen merkinnän etuliitteenä on oltava luokan nimi ja kaksoispiste (esim. Computer::). On olemassa muutamia CI-attribuutteja, jotka ovat yhteisiä kaikille CI:ille (esimerkki luokan Computer: Computer::Name, Computer::CurDeplState, Computer::CreateTime). Yksittäisten CI-attribuuttien näyttämiseksi CI-määrittelyssä määritellyllä tavalla on käytettävä seuraavaa kaavaa (esimerkki luokan Computer osalta): Computer::HardDisk::1, Computer::HardDisk::1::Capacity::1, Computer::HardDisk::2, Computer::HardDisk::2::Capacity::1. Jos CI-luokalle ei ole merkintää, näytetään oletussarakkeet.';
    $Self->{Translation}->{'Defines which items are available for \'Action\' in third level of the ITSM Config Item ACL structure.'} =
        'Määrittää, mitkä kohteet ovat käytettävissä "Action" -toimintoa varten ITSM Config Item ACL -rakenteen kolmannella tasolla.';
    $Self->{Translation}->{'Defines which items are available in first level of the ITSM Config Item ACL structure.'} =
        'Määrittää, mitkä kohteet ovat käytettävissä ITSM Config Item ACL -rakenteen ensimmäisellä tasolla.';
    $Self->{Translation}->{'Defines which items are available in second level of the ITSM Config Item ACL structure.'} =
        'Määrittää, mitkä kohteet ovat käytettävissä ITSM Config Item ACL -rakenteen toisella tasolla.';
    $Self->{Translation}->{'Defines which type of link (named from the ticket perspective) can affect the status of a linked CI.'} =
        'Määrittää, minkä tyyppinen linkki (nimetty tiketin näkökulmasta) voi vaikuttaa linkitetyn CI:n tilaan.';
    $Self->{Translation}->{'Defines which type of ticket can affect the status of a linked CI.'} =
        'Määrittää, minkä tyyppinen lippu voi vaikuttaa linkitetyn CI:n tilaan.';
    $Self->{Translation}->{'Definition Update'} = 'Määritelmän päivitys';
    $Self->{Translation}->{'Delete Configuration Item'} = 'Poista konfiguraatioelementti';
    $Self->{Translation}->{'DeplState'} = 'DeplState';
    $Self->{Translation}->{'Deployment State Color'} = 'Käyttöönoton tila Väri';
    $Self->{Translation}->{'DeploymentState'} = 'DeploymentState';
    $Self->{Translation}->{'Duplicate'} = 'Kaksoiskappaleet';
    $Self->{Translation}->{'Dynamic field event module that marks config item definitions as out of sync, if containing dynamic fields change.'} =
        'Dynaamisten kenttien tapahtumamoduuli, joka merkitsee konfiguraatiokohteen määritelmät epäsynkronisiksi, jos dynaamisia kenttiä sisältävät kentät muuttuvat.';
    $Self->{Translation}->{'Dynamic fields shown in the additional ITSM field screen of the agent interface.'} =
        'Dynaamiset kentät, jotka näkyvät asiamiehen käyttöliittymän ITSM-lisäkenttänäytössä.';
    $Self->{Translation}->{'Dynamic fields shown in the config item overview screen of the customer interface.'} =
        'Dynaamiset kentät, jotka näkyvät asiakkaan käyttöliittymän konfigurointikohteen yleiskatsausnäytössä.';
    $Self->{Translation}->{'Dynamic fields shown in the config item search screen of the agent interface.'} =
        'Dynaamiset kentät, jotka näkyvät agentin käyttöliittymän määrityskohteen hakunäytössä.';
    $Self->{Translation}->{'Enables configuration item bulk action feature for the agent frontend to work on more than one configuration item at a time.'} =
        'Ottaa käyttöön konfiguraatiokohteen massatoiminto-ominaisuuden, jonka avulla agentin etusivu voi käsitellä useampaa kuin yhtä konfiguraatiokohdetta kerrallaan.';
    $Self->{Translation}->{'Enables configuration item bulk action feature only for the listed groups.'} =
        'Ottaa käyttöön määrityskohteiden massatoimintatoiminnon vain luetelluille ryhmille.';
    $Self->{Translation}->{'Enables/disables the functionality to check ITSM onfiguration items for unique names. Before enabling this option you should check your system for already existing config items with duplicate names. You can do this with the console command Admin::ITSM::Configitem::ListDuplicates.'} =
        'Ottaa käyttöön tai poistaa käytöstä toiminnon, jolla tarkistetaan ITSM onfiguration -kohteiden yksilölliset nimet. Ennen tämän vaihtoehdon ottamista käyttöön sinun tulisi tarkistaa järjestelmäsi jo olemassa olevien konfigurointielementtien kaksoiskappaleiden nimet. Voit tehdä tämän konsolin komennolla Admin::ITSM::Configitem::ListDuplicates.';
    $Self->{Translation}->{'Event module to set configitem-status on ticket-configitem-link.'} =
        'Tapahtumamoduuli, joka asettaa konfigitem-tilan ticket-configitem-linkille.';
    $Self->{Translation}->{'Fields of the configuration item index, used for the fulltext search. Fields are also stored, but are not mandatory for the overall functionality. Inclusion of attachments can be disabled by setting the entry to 0 or deleting it.'} =
        'Kokotekstihaussa käytettävät konfiguraatiokohteen indeksin kentät. Kentät tallennetaan myös, mutta ne eivät ole pakollisia yleisen toiminnallisuuden kannalta. Liitetiedostojen sisällyttäminen voidaan estää asettamalla merkinnän arvoksi 0 tai poistamalla se.';
    $Self->{Translation}->{'Fields stored in the configuration item index which are used for other things besides fulltext searches. For the complete functionality all fields are mandatory.'} =
        'Määrityskohdeindeksiin tallennetut kentät, joita käytetään muuhun kuin kokotekstihakuun. Täydellisen toiminnallisuuden kannalta kaikki kentät ovat pakollisia.';
    $Self->{Translation}->{'For every webservice (key) an array of classes (value) can be defined on which the import is restricted. For all chosen classes, or all existing classes the identifying attributes will have to be chosen in the invoker config.'} =
        'Jokaiselle verkkopalvelulle (avain) voidaan määritellä joukko luokkia (arvo), joihin tuonti on rajoitettu. Kaikille valituille luokille tai kaikille olemassa oleville luokille on valittava tunnistavat attribuutit kutsujan konfiguraatiossa.';
    $Self->{Translation}->{'GenericInterface module registration for the ConfigItemFetch invoker layer.'} =
        'GenericInterface-moduulin rekisteröinti ConfigItemFetch-kutsukerrosta varten.';
    $Self->{Translation}->{'ITSM ConfigItem'} = 'ITSM ConfigItem';
    $Self->{Translation}->{'ITSM config item overview.'} = 'ITSM-määrityskohteen yleiskatsaus.';
    $Self->{Translation}->{'InciState'} = 'InciState';
    $Self->{Translation}->{'IncidentState'} = 'IncidentState';
    $Self->{Translation}->{'Includes deployment states in the config item search of the customer interface.'} =
        'Sisältää käyttöönottotilat asiakkaan käyttöliittymän konfigurointikohdehaussa.';
    $Self->{Translation}->{'Includes incident states in the config item search of the customer interface.'} =
        'Sisältää vaaratilanteiden tilat asiakkaan käyttöliittymän konfigurointikohdehaussa.';
    $Self->{Translation}->{'Maximum number of config items to be displayed in the result of this operation.'} =
        'Tämän toiminnon tuloksena näytettävien konfigurointielementtien enimmäismäärä.';
    $Self->{Translation}->{'Module to check the group responsible for a class.'} = 'Moduuli luokasta vastaavan ryhmän tarkistamiseksi.';
    $Self->{Translation}->{'Module to check the group responsible for a configuration item.'} =
        'Moduuli, jolla voit tarkistaa konfiguraatioelementistä vastaavan ryhmän.';
    $Self->{Translation}->{'Module to generate ITSM config item statistics.'} = 'Moduuli ITSM-konfiguraatiotilastojen tuottamiseen.';
    $Self->{Translation}->{'Name Module'} = 'Nimi Moduuli';
    $Self->{Translation}->{'Number Module'} = 'Numeromoduuli';
    $Self->{Translation}->{'Number of config items to be displayed in each page of a search result in the agent interface.'} =
        'Agentin käyttöliittymässä kullakin hakutulossivulla näytettävien määrityskohteiden määrä.';
    $Self->{Translation}->{'Number of config items to be displayed in each page of a search result in the customer interface.'} =
        'Asiakkaan käyttöliittymässä kullakin hakutulossivulla näytettävien määrityskohteiden määrä.';
    $Self->{Translation}->{'Objects to search for, how many entries and which attributs to show. ConfigItem attributes have to explicitly be stored via Elasticsearch.'} =
        'Etsittävät kohteet, kuinka monta merkintää ja mitkä ominaisuudet näytetään. ConfigItem-attribuutit on tallennettava nimenomaisesti Elasticsearchin kautta.';
    $Self->{Translation}->{'Overview.'} = 'Yleiskatsaus.';
    $Self->{Translation}->{'Parameters for the categories for config item classes in the preferences view of the agent interface.'} =
        'Agenttikäyttöliittymän preferences-näkymän konfigurointikohdeluokkien luokkien parametrit.';
    $Self->{Translation}->{'Parameters for the column filters of the small config item overview. Please note: setting \'Active\' to 0 will only prevent agents from editing settings of this group in their personal preferences, but will still allow administrators to edit the settings of another user\'s behalf. Use \'PreferenceGroup\' to control in which area these settings should be shown in the user interface.'} =
        'Parametrit pienten konfigurointikohteiden yleiskatsauksen sarakesuodattimia varten. Huomaa: \'Aktiivinen\'-asetuksen asettaminen arvoon 0 estää vain agentteja muokkaamasta tämän ryhmän asetuksia henkilökohtaisissa asetuksissaan, mutta sallii silti järjestelmänvalvojien muokata toisen käyttäjän asetuksia. Käytä \'PreferenceGroup\'-kohtaa, kun haluat hallita, millä alueella nämä asetukset näytetään käyttöliittymässä.';
    $Self->{Translation}->{'Parameters for the dashboard backend of the customer company config item overview of the agent interface . "Limit" is the number of entries shown by default. "Group" is used to restrict the access to the plugin (e. g. Group: admin;group1;group2;). "Default" determines if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" is the cache time in minutes for the plugin.'} =
        'Parametrit asiakasyrityksen kojelaudan taustapäätteelle config item overview of the agent interface . "Limit" on oletusarvoisesti näytettävien merkintöjen määrä. "Group" rajoittaa lisäosan käyttöoikeuksia (esim. Group: admin;group1;group2;). "Default" määrittää, onko lisäosa oletusarvoisesti käytössä vai pitääkö käyttäjän ottaa se käyttöön manuaalisesti. "CacheTTLLocal" on liitännäisen välimuistiaika minuutteina.';
    $Self->{Translation}->{'Parameters for the deployment states color in the preferences view of the agent interface.'} =
        'Käyttöönottotilojen värin parametrit agentin käyttöliittymän preferences-näkymässä.';
    $Self->{Translation}->{'Parameters for the deployment states in the preferences view of the agent interface.'} =
        'Käyttöönottotilojen parametrit agentin käyttöliittymän preferences-näkymässä.';
    $Self->{Translation}->{'Parameters for the example permission groups of the general catalog attributes.'} =
        'Yleisen luettelon attribuuttien esimerkkioikeusryhmien parametrit.';
    $Self->{Translation}->{'Parameters for the name module for config item classes in the preferences view of the agent interface.'} =
        'Agentin käyttöliittymän preferences-näkymässä olevien konfigurointikohdeluokkien nimimoduulin parametrit.';
    $Self->{Translation}->{'Parameters for the number module for config item classes in the preferences view of the agent interface.'} =
        'Agenttikäyttöliittymän preferences-näkymässä olevien konfigurointikohdeluokkien numeromoduulin parametrit.';
    $Self->{Translation}->{'Parameters for the pages (in which the configuration items are shown).'} =
        'Sivujen parametrit (joissa asetuskohteet näytetään).';
    $Self->{Translation}->{'Parameters for the version string module for config item classes in the preferences view of the agent interface.'} =
        'Agentin käyttöliittymän preferences-näkymässä olevien konfigurointiluokkien version merkkijonomoduulin parametrit.';
    $Self->{Translation}->{'Parameters for the version string template toolkit module for config item classes in the preferences view of the agent interface.'} =
        'Agentin käyttöliittymän preferences-näkymässä olevien konfigurointikohdeluokkien version merkkijonomalli-työkalupakkimoduulin parametrit.';
    $Self->{Translation}->{'Parameters for the version trigger for config item classes in the preferences view of the agent interface.'} =
        'Agenttikäyttöliittymän preferences-näkymässä olevien konfigurointiluokkien versiolaukaisimen parametrit.';
    $Self->{Translation}->{'Performs the configured action for each event (as an Invoker) for each configured Webservice.'} =
        'Suorittaa määritetyn toiminnon kullekin tapahtumalle (kutsujana) kunkin määritetyn verkkopalvelun osalta.';
    $Self->{Translation}->{'Permission Group'} = 'Luparyhmä';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item attachment action in the agent interface.'} =
        'Tarvittavat käyttöoikeudet ITSM-kokoonpanokohteen kiinnitystoiminnon käyttämiseen agentin käyttöliittymässä.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item screen in the agent interface.'} =
        'Tarvittavat oikeudet ITSM-konfiguraatiokohteiden näytön käyttämiseen agenttikäyttöliittymässä.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item search screen in the agent interface.'} =
        'Tarvittavat käyttöoikeudet ITSM-konfiguraatiokohteiden hakunäytön käyttämiseen agentin käyttöliittymässä.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item search screen in the customer interface.'} =
        'Tarvittavat käyttöoikeudet ITSM-konfiguraatiokohteiden hakunäytön käyttämiseen asiakkaan käyttöliittymässä.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item tree view screen in the agent interface.'} =
        'Tarvittavat käyttöoikeudet ITSM-kokoonpanokohteiden puunäkymän näyttöön agenttikäyttöliittymässä.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item zoom screen in the agent interface.'} =
        'Tarvittavat käyttöoikeudet ITSM-konfiguraatiokohteen zoomausnäytön käyttämiseen agentin käyttöliittymässä.';
    $Self->{Translation}->{'Required permissions to use the add ITSM configuration item screen in the agent interface.'} =
        'Tarvittavat käyttöoikeudet agenttikäyttöliittymän add ITSM configuration item -näytön käyttämiseen.';
    $Self->{Translation}->{'Required permissions to use the bulk ITSM configuration item screen in the agent interface.'} =
        'Tarvittavat käyttöoikeudet ITSM:n määrityskohteiden irtotavaranäytön käyttämiseen agenttikäyttöliittymässä.';
    $Self->{Translation}->{'Required permissions to use the edit ITSM configuration item screen in the agent interface.'} =
        'Tarvittavat käyttöoikeudet ITSM-kokoonpanokohteen muokkausnäytön käyttämiseen agenttikäyttöliittymässä.';
    $Self->{Translation}->{'Required permissions to use the history ITSM configuration item screen in the agent interface.'} =
        'Tarvittavat käyttöoikeudet ITSM-konfiguraatiokohteiden historia-näytön käyttämiseen agentin käyttöliittymässä.';
    $Self->{Translation}->{'Required permissions to use the print ITSM configuration item screen in the agent interface.'} =
        'Tarvittavat käyttöoikeudet ITSM-kokoonpanokohteiden tulostaminen -näytön käyttämiseen agenttikäyttöliittymässä.';
    $Self->{Translation}->{'Required privileges to delete config items.'} = 'Määrityskohteiden poistamiseen tarvittavat oikeudet.';
    $Self->{Translation}->{'Search config items.'} = 'Haku konfigurointielementit.';
    $Self->{Translation}->{'Set the incident state of a CI automatically when a Ticket is Linked to a CI.'} =
        'Aseta CI:n tapahtumatila automaattisesti, kun lippu linkitetään CI:hen.';
    $Self->{Translation}->{'Sets the deployment state in the configuration item bulk screen of the agent interface.'} =
        'Asettaa käyttöönoton tilan agenttiliittymän määrityskohteen bulk-näytössä.';
    $Self->{Translation}->{'Sets the incident state in the configuration item bulk screen of the agent interface.'} =
        'Asettaa tapahtumatilan agenttiliittymän määrityskohteen bulk-näytössä.';
    $Self->{Translation}->{'Shows a link in the menu that allows linking a configuration item with another object in the config item zoom view of the agent interface.'} =
        'Näyttää valikossa linkin, jonka avulla konfigurointikohde voidaan yhdistää toiseen kohteeseen agentin käyttöliittymän konfigurointikohteen zoomausnäkymässä.';
    $Self->{Translation}->{'Shows a link in the menu to access the history of a configuration item in the configuration item overview of the agent interface.'} =
        'Näyttää valikossa linkin, jonka avulla pääsee määrityskohteen historiaan agenttikäyttöliittymän määrityskohteiden yleiskatsauksessa.';
    $Self->{Translation}->{'Shows a link in the menu to access the history of a configuration item in the its zoom view of the agent interface.'} =
        'Näyttää valikossa linkin, jonka avulla pääsee määrityskohteen historiaan agentin käyttöliittymän zoomausnäkymässä.';
    $Self->{Translation}->{'Shows a link in the menu to delete a configuration item in its zoom view of the agent interface.'} =
        'Näyttää valikossa linkin, jonka avulla voit poistaa määrityskohteen agentin käyttöliittymän zoomausnäkymässä.';
    $Self->{Translation}->{'Shows a link in the menu to display the configuration item links as a Tree View.'} =
        'Näyttää valikossa linkin, joka näyttää määrityskohteiden linkit puunäkymässä.';
    $Self->{Translation}->{'Shows a link in the menu to duplicate a configuration item in the configuration item overview of the agent interface.'} =
        'Näyttää valikossa linkin, jolla voit kopioida määrityskohteen agenttiliittymän määrityskohteiden yleiskatsauksessa.';
    $Self->{Translation}->{'Shows a link in the menu to duplicate a configuration item in the its zoom view of the agent interface.'} =
        'Näyttää valikossa linkin, jonka avulla voit kopioida määrityskohteen agentin käyttöliittymän zoomausnäkymässä.';
    $Self->{Translation}->{'Shows a link in the menu to edit a configuration item in the its zoom view of the agent interface.'} =
        'Näyttää linkin valikkoon, jonka avulla voit muokata määrityskohdetta agentin käyttöliittymän zoomausnäkymässä.';
    $Self->{Translation}->{'Shows a link in the menu to go back in the configuration item zoom view of the agent interface.'} =
        'Näyttää valikossa linkin, jonka avulla voit palata takaisin agentin käyttöliittymän määrityskohteen zoomausnäkymään.';
    $Self->{Translation}->{'Shows a link in the menu to print a configuration item in the its zoom view of the agent interface.'} =
        'Näyttää valikossa linkin, jonka avulla voit tulostaa määrityskohteen agentin käyttöliittymän zoomausnäkymässä.';
    $Self->{Translation}->{'Shows a link in the menu to zoom into a configuration item in the configuration item overview of the agent interface.'} =
        'Näyttää valikossa linkin, jonka avulla voit zoomata määrityskohteeseen agenttikäyttöliittymän määrityskohteiden yleiskatsauksessa.';
    $Self->{Translation}->{'Shows the config item history (reverse ordered) in the agent interface.'} =
        'Näyttää määrityskohteiden historian (käänteisessä järjestyksessä) agenttiliittymässä.';
    $Self->{Translation}->{'The default category which is shown, if none is selected.'} = 'Oletusluokka, joka näytetään, jos mitään ei ole valittu.';
    $Self->{Translation}->{'The identifier for a configuration item, e.g. ConfigItem#, MyConfigItem#. The default is ConfigItem#.'} =
        'Konfiguraatioelementin tunniste, esim. ConfigItem#, MyConfigItem#. Oletusarvo on ConfigItem#.';
    $Self->{Translation}->{'Triggers ConfigItemFetch invoker automatically.'} = 'Käynnistää ConfigItemFetch-kutsuajan automaattisesti.';
    $Self->{Translation}->{'Version String Expression'} = 'Versio String Expression';
    $Self->{Translation}->{'Version String Module'} = 'Versio merkkijono Moduuli';
    $Self->{Translation}->{'Version Trigger'} = 'Versio Laukaisin';
    $Self->{Translation}->{'Whether the execution of ConfigItemACL can be avoided by checking cached field dependencies. This can improve loading times of formulars, but has to be disabled, if ACLModules are to be used for ITSMConfigItem- and Form-ReturnTypes.'} =
        'Voidaanko ConfigItemACL:n suorittaminen välttää tarkistamalla välimuistiin tallennettujen kenttien riippuvuudet. Tämä voi parantaa lomakkeiden latausaikoja, mutta se on poistettava käytöstä, jos ACLModuleja käytetään ITSMConfigItem- ja Form-ReturnTypes-tyypeissä.';
    $Self->{Translation}->{'Which general information is shown in the header.'} = 'Mitkä yleiset tiedot näkyvät otsikossa.';
    $Self->{Translation}->{'class'} = 'luokka';
    $Self->{Translation}->{'global'} = 'maailmanlaajuinen';
    $Self->{Translation}->{'postproductive'} = 'postproductive';
    $Self->{Translation}->{'preproductive'} = 'preproductive';
    $Self->{Translation}->{'productive'} = 'tuottava';


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

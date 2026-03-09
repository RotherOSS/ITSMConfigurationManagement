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

package Kernel::Language::lt_ITSMConfigurationManagement;

use strict;
use warnings;
use utf8;

sub Data {
    my $Self = shift;

    # Template: AdminGenericInterfaceOperationConfigItem
    $Self->{Translation}->{'General operation data'} = 'Bendrieji veikimo duomenys';
    $Self->{Translation}->{'Settings for incoming request data'} = 'Įeinančių užklausų duomenų nustatymai';
    $Self->{Translation}->{'Settings for outgoing response data'} = 'Išeinančių atsakymo duomenų nustatymai';

    # Template: AdminITSMConfigItem
    $Self->{Translation}->{'Config Item Management'} = 'Konfigūracijos elementų valdymas';
    $Self->{Translation}->{'Change class definition'} = 'Keisti klasės apibrėžtį';
    $Self->{Translation}->{'Change role definition'} = 'Keisti vaidmens apibrėžtį';
    $Self->{Translation}->{'Ready2Import Class Bundles'} = '"Ready2Import" klasių paketai';
    $Self->{Translation}->{'Here you can import Ready2Import class bundles showcasing our most usual config items. Please note that some additional configuration may be required.'} =
        'Čia galite importuoti "Ready2Import" klasių paketus, kuriuose demonstruojami įprastiniai konfigūracijos elementai. Atkreipkite dėmesį, kad gali prireikti tam tikros papildomos konfigūracijos.';
    $Self->{Translation}->{'Update existing entities'} = 'Atnaujinti esamus subjektus';
    $Self->{Translation}->{'Import Ready2Adopt class bundles'} = 'Importuoti "Ready2Adopt" klasės paketus';
    $Self->{Translation}->{'Config Item Class'} = 'Konfigūracijos elemento klasė';
    $Self->{Translation}->{'Config Item Role'} = 'Konfigūracijos elemento vaidmuo';

    # Template: AgentITSMConfigItemAdd
    $Self->{Translation}->{'Config Item'} = 'Konfigūracijos elementas';
    $Self->{Translation}->{'Filter for Classes'} = 'Klasių filtras';
    $Self->{Translation}->{'Select a Class from the list to create a new Config Item.'} = 'Norėdami sukurti naują konfigūracijos elementą, sąraše pasirinkite klasę.';
    $Self->{Translation}->{'Class'} = 'Klasė';

    # Template: AgentITSMConfigItemBulk
    $Self->{Translation}->{'ITSM ConfigItem Bulk Action'} = 'ITSM ConfigItem Bulk Action';
    $Self->{Translation}->{'Deployment state'} = 'Diegimo būsena';
    $Self->{Translation}->{'Incident state'} = 'Incidento būsena';
    $Self->{Translation}->{'Link to another'} = 'Nuoroda į kitą';
    $Self->{Translation}->{'Invalid Configuration Item number!'} = 'Neteisingas konfigūracijos elemento numeris!';
    $Self->{Translation}->{'The number of another Configuration Item to link with.'} = 'Kito konfigūracijos elemento, su kuriuo norite susieti, numeris.';

    # Template: AgentITSMConfigItemDelete
    $Self->{Translation}->{'Do you really want to delete this config item?'} = 'Ar tikrai norite ištrinti šį konfigūracijos elementą?';

    # Template: AgentITSMConfigItemEdit
    $Self->{Translation}->{'The name of this config item'} = 'Šio konfigūracijos elemento pavadinimas';
    $Self->{Translation}->{'Name is already in use by the ConfigItems with the following Number(s): %s'} =
        'Pavadinimas jau naudojamas ConfigItems su šiuo (-iais) numeriu (-iais): %s';
    $Self->{Translation}->{'Version Number'} = 'Versijos numeris';
    $Self->{Translation}->{'Version number of this config item'} = 'Šio konfigūracijos elemento versijos numeris';
    $Self->{Translation}->{'Version Number is already in use by the ConfigItems with the following Number(s): %s'} =
        'Versijos numeris jau naudojamas "ConfigItems" su šiuo (-iais) numeriu (-iais): %s';
    $Self->{Translation}->{'Deployment State'} = 'Diegimo būsena';
    $Self->{Translation}->{'Incident State'} = 'Incidento būklė';

    # Template: AgentITSMConfigItemHistory
    $Self->{Translation}->{'History of Config Item: %s'} = 'Konfigūracijos elemento istorija: %s';
    $Self->{Translation}->{'History Content'} = 'Istorijos turinys';
    $Self->{Translation}->{'Createtime'} = 'Createtime';
    $Self->{Translation}->{'Zoom view'} = 'Pritraukti apžvalgą';

    # Template: AgentITSMConfigItemOverviewNavBar
    $Self->{Translation}->{'Config Items per page'} = 'Konfigūracijos elementai viename puslapyje';

    # Template: AgentITSMConfigItemOverviewSmall
    $Self->{Translation}->{'No config item data found.'} = 'Konfigūracijos elemento duomenų nerasta.';
    $Self->{Translation}->{'Select this config item'} = 'Pasirinkite šį konfigūracijos elementą';

    # Template: AgentITSMConfigItemSearch
    $Self->{Translation}->{'Run Search'} = 'Vykdyti paiešką';
    $Self->{Translation}->{'Also search in previous versions?'} = 'Taip pat ieškoti ankstesnėse versijose?';

    # Template: AgentITSMConfigItemTreeView
    $Self->{Translation}->{'TreeView for ConfigItem'} = '"ConfigItem" medžio rodinys';
    $Self->{Translation}->{'Depth Level'} = 'Gylio lygis';
    $Self->{Translation}->{'Zoom In/Out'} = 'Padidinti / sumažinti mastelį';
    $Self->{Translation}->{'Max links level reached for ConfigItem!'} = 'Pasiektas maksimalus ConfigItem nuorodų lygis!';

    # Template: AgentITSMConfigItemZoom
    $Self->{Translation}->{'Configuration Item'} = 'Konfigūracijos elementas';
    $Self->{Translation}->{'Configuration Item Information'} = 'Konfigūracijos elemento informacija';
    $Self->{Translation}->{'Current Deployment State'} = 'Dabartinė diegimo būsena';
    $Self->{Translation}->{'Current Incident State'} = 'Dabartinė incidento būsena';
    $Self->{Translation}->{'Last changed'} = 'Paskutinį kartą pakeista';
    $Self->{Translation}->{'Last changed by'} = 'Paskutinį kartą pakeitė';

    # Template: CustomerITSMConfigItem
    $Self->{Translation}->{'Your ConfigItems'} = 'Jūsų ConfigItems';

    # Template: CustomerITSMConfigItemSearch
    $Self->{Translation}->{'ConfigItem Search'} = 'ConfigItem Paieška';

    # Template: AdminACL
    $Self->{Translation}->{'Object Type'} = 'Objekto tipas';

    # Template: AdminDynamicFieldScreen
    $Self->{Translation}->{'Filter by object type'} = '';

    # JS Template: ClassImportConfirm
    $Self->{Translation}->{'The following classes will be imported'} = 'Importuojamos šios klasės';
    $Self->{Translation}->{'The following roles will be imported'} = 'Bus importuojami šie vaidmenys';
    $Self->{Translation}->{'Note that also corresponding dynamic fields and GeneralCatalog classes will be created and there is no automatic removal.'} =
        'Atkreipkite dėmesį, kad taip pat bus sukurti atitinkami dinaminiai laukai ir "GeneralCatalog" klasės, o automatinio pašalinimo nebus.';
    $Self->{Translation}->{'Do you want to proceed?'} = 'Ar norite tęsti?';

    # Perl Module: Kernel/Modules/AdminITSMConfigItem.pm
    $Self->{Translation}->{'Need ExampleClasses!'} = 'Reikia pavyzdžių klasių!';
    $Self->{Translation}->{'Definition is no valid YAML hash.'} = 'Apibrėžtis nėra galiojantis YAML hash.';

    # Perl Module: Kernel/Modules/AgentITSMConfigItem.pm
    $Self->{Translation}->{'Overview: ITSM ConfigItem'} = 'Apžvalga: ITSM ConfigItem';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemBulk.pm
    $Self->{Translation}->{'No ConfigItemID is given!'} = 'Nenurodytas joks ConfigItemID!';
    $Self->{Translation}->{'You need at least one selected Configuration Item!'} = 'Reikia bent vieno pasirinkto konfigūracijos elemento!';
    $Self->{Translation}->{'You don\'t have write access to this configuration item: %s.'} =
        'Jūs neturite prieigos prie šio konfigūracijos elemento rašyti: %s.';
    $Self->{Translation}->{'No definition was defined for class %s!'} = 'Klasei %s neapibrėžtas joks apibrėžimas!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemDelete.pm
    $Self->{Translation}->{'Config item "%s" not found in database!'} = 'Konfigūracijos elementas "%s" nerastas duomenų bazėje!';
    $Self->{Translation}->{'Was not able to delete the configitem ID %s!'} = 'Nepavyko ištrinti konfigūracijos elemento ID %s!';
    $Self->{Translation}->{'No version found for ConfigItemID %s!'} = 'ConfigItemID %s versija nerasta!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemEdit.pm
    $Self->{Translation}->{'No ConfigItemID, DuplicateID or ClassID is given!'} = 'Nenurodytas ConfigItemID, DuplicateID arba ClassID!';
    $Self->{Translation}->{'No access is given!'} = 'Prieiga nesuteikiama!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemHistory.pm
    $Self->{Translation}->{'Can\'t show history, no ConfigItemID is given!'} = 'Negalima rodyti istorijos, nepateiktas ConfigItemID!';
    $Self->{Translation}->{'Can\'t show history, no access rights given!'} = 'Negalima rodyti istorijos, nes nesuteiktos prieigos teisės!';
    $Self->{Translation}->{'New ConfigItem (ID=%s)'} = 'Naujas konfigūracijos elementas (ID=%s)';
    $Self->{Translation}->{'New version (ID=%s)'} = 'Nauja versija (ID=%s)';
    $Self->{Translation}->{'Deployment state updated (new=%s, old=%s)'} = 'Atnaujinta diegimo būsena (new=%s, old=%s)';
    $Self->{Translation}->{'Incident state updated (new=%s, old=%s)'} = 'Atnaujinta incidento būsena (new=%s, old=%s)';
    $Self->{Translation}->{'ConfigItem (ID=%s) deleted'} = 'Konfigūracijos elementas (ID=%s) ištrintas';
    $Self->{Translation}->{'Link to %s (type=%s) added'} = 'Pridėta nuoroda į %s (type=%s)';
    $Self->{Translation}->{'Link to %s (type=%s) deleted'} = 'Nuoroda į %s (type=%s) pašalinta';
    $Self->{Translation}->{'ConfigItem definition updated (ID=%s)'} = 'Atnaujinta ConfigItem apibrėžtis (ID=%s)';
    $Self->{Translation}->{'Name updated (new=%s, old=%s)'} = 'Pavadinimas atnaujintas (new=%s, old=%s)';
    $Self->{Translation}->{'Attribute %s updated from "%s" to "%s"'} = 'Atributas %s atnaujintas iš "%s" į "%s"';
    $Self->{Translation}->{'Version %s deleted'} = 'Versija %s ištrinta';
    $Self->{Translation}->{'File "%s" uploaded'} = '';
    $Self->{Translation}->{'File "%s" removed'} = '';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemPrint.pm
    $Self->{Translation}->{'No ConfigItemID or VersionID is given!'} = 'Nenurodytas ConfigItemID arba VersionID!';
    $Self->{Translation}->{'Can\'t show config item, no access rights given!'} = 'Negalima parodyti konfigūracijos elemento, nes nesuteiktos prieigos teisės!';
    $Self->{Translation}->{'ConfigItemID %s not found in database!'} = 'Duomenų bazėje nerasta ConfigItemID %s!';
    $Self->{Translation}->{'ConfigItem'} = 'ConfigItem';
    $Self->{Translation}->{'printed by %s at %s'} = '%s spausdina %s adresu %s';
    $Self->{Translation}->{'Referenced by'} = '';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemSearch.pm
    $Self->{Translation}->{'Invalid ClassID!'} = 'Neteisingas ClassID!';
    $Self->{Translation}->{'No ClassID is given!'} = 'Nenurodytas joks ClassID!';
    $Self->{Translation}->{'No access rights for this class given!'} = 'Šiai klasei prieigos teisės nesuteiktos!';
    $Self->{Translation}->{'No Result!'} = 'Jokio rezultato!';
    $Self->{Translation}->{'Config Item Search Results'} = 'Konfigūracijos elemento paieškos rezultatai';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemZoom.pm
    $Self->{Translation}->{'Can\'t show item, no access rights for ConfigItem are given!'} =
        'Negalima parodyti elemento, nes nesuteiktos prieigos teisės prie ConfigItem!';
    $Self->{Translation}->{'ConfigItem not found!'} = 'ConfigItem nerastas!';
    $Self->{Translation}->{'No versions found!'} = 'Versijų nerasta!';
    $Self->{Translation}->{'operational'} = 'veiklos';
    $Self->{Translation}->{'warning'} = 'įspėjimas';
    $Self->{Translation}->{'incident'} = 'incidentas';
    $Self->{Translation}->{'The deployment state of this config item'} = 'Šio konfigūracijos elemento diegimo būsena';
    $Self->{Translation}->{'The incident state of this config item'} = 'Šio konfigūracijos elemento incidento būsena';

    # Perl Module: Kernel/Modules/CustomerITSMConfigItemSearch.pm
    $Self->{Translation}->{'No permission'} = 'Leidimo nėra';
    $Self->{Translation}->{'Filter invalid!'} = 'Filtras negalioja!';
    $Self->{Translation}->{'Search params invalid!'} = 'Paieškos parametrai negalioja!';

    # Perl Module: Kernel/Output/HTML/Dashboard/ITSMConfigItemGeneric.pm
    $Self->{Translation}->{'Shown config items'} = 'Rodomi konfigūracijos elementai';
    $Self->{Translation}->{'Deployment State Type'} = 'Diegimo būsenos tipas';
    $Self->{Translation}->{'Current Incident State Type'} = 'Dabartinis incidento būsenos tipas';

    # Perl Module: Kernel/Output/HTML/ITSMConfigItem/LayoutDate.pm
    $Self->{Translation}->{'Between'} = 'Tarp';

    # Perl Module: Kernel/System/DynamicField/Driver/ConfigItem.pm
    $Self->{Translation}->{'Class restrictions for the config item'} = 'Konfigūracijos elemento klasės apribojimai';
    $Self->{Translation}->{'Select one or more classes to restrict selectable config items'} =
        'Pasirinkite vieną ar daugiau klasių, kad apribotumėte pasirenkamus konfigūracijos elementus';
    $Self->{Translation}->{'Deployment state restrictions for the config item'} = '';
    $Self->{Translation}->{'Select one or more deployment states to restrict selectable config items'} =
        '';
    $Self->{Translation}->{'Dynamic (ConfigItem)'} = 'Dinaminis (ConfigItem)';
    $Self->{Translation}->{'Static (Version)'} = 'Statinis (versija)';
    $Self->{Translation}->{'Link Referencing Type'} = 'Nuorodos tipas';
    $Self->{Translation}->{'Whether this link applies to the ConfigItem or the static version of the referencing object. Current Incident State calculation only is performed on dynamic links.'} =
        'Ar ši sąsaja taikoma ConfigItem, ar statinei nuorodą pateikiančio objekto versijai. Dabartinės incidento būsenos skaičiavimas atliekamas tik dinaminėms nuorodoms.';
    $Self->{Translation}->{'Select the attribute which config items will be searched by'} = 'Pasirinkite atributą, pagal kurį bus ieškoma konfigūracijos elementų';

    # Perl Module: Kernel/System/ITSMConfigItem/Definition.pm
    $Self->{Translation}->{'Base structure is not valid. Please provide a hash with data in YAML format.'} =
        'Bazinė struktūra negalioja. Pateikite hash su duomenimis YAML formatu.';
    $Self->{Translation}->{'Starting the YAML string with \'---\' is required.'} = 'YAML eilutę reikia pradėti nuo \'---\'.';

    # Perl Module: Kernel/System/ITSMConfigItem/Link.pm
    $Self->{Translation}->{'Could not purge the table configitem_link.'} = 'Nepavyko išvalyti lentelės configitem_link.';
    $Self->{Translation}->{'No relevant dynamic fields were found'} = 'Nerastas nė vienas svarbus dinaminis laukas';
    $Self->{Translation}->{'Could not insert into the table configitem_link'} = 'Nepavyko įterpti į lentelę configitem_link';
    $Self->{Translation}->{'Inserted 0 rows into the table configitem_link'} = 'Į lentelę configitem_link įterpta 0 eilučių';

    # Perl Module: Kernel/System/ImportExport/ObjectBackend/ITSMConfigItem.pm
    $Self->{Translation}->{'Maximum number of one element'} = 'Didžiausias vieno elemento skaičius';
    $Self->{Translation}->{'Maximum number of one Set dynamic field element'} = '';
    $Self->{Translation}->{'Maximum number of one element within a Set dynamic field element'} =
        '';
    $Self->{Translation}->{'Import/Export attachments (as the last entries per line)'} = 'Importuoti ir (arba) eksportuoti priedus (kaip paskutinius įrašus eilutėje)';
    $Self->{Translation}->{'Version String'} = 'Versijos eilutė';

    # Perl Module: Kernel/Modules/AdminDynamicField.pm
    $Self->{Translation}->{'Error synchronizing the definitions. Please check the log.'} = 'Klaida sinchronizuojant apibrėžtis. Patikrinkite žurnalą.';
    $Self->{Translation}->{'You have ITSMConfigItem definitions which are not synchronized. Please deploy your ITSMConfigItem dynamic field changes.'} =
        'Turite ITSMConfigItem apibrėžtis, kurios nėra sinchronizuotos. Įdiekite savo ITSMConfigItem dinaminių laukų pakeitimus.';

    # Database XML / SOPM Definition: ITSMConfigurationManagement.sopm
    $Self->{Translation}->{'Expired'} = 'Pasibaigęs';
    $Self->{Translation}->{'Maintenance'} = 'Techninė priežiūra';
    $Self->{Translation}->{'Pilot'} = 'Bandomasis';
    $Self->{Translation}->{'Planned'} = 'Planuojama';
    $Self->{Translation}->{'Repair'} = 'Remontas';
    $Self->{Translation}->{'Retired'} = 'Išėjęs į pensiją';
    $Self->{Translation}->{'Review'} = 'Peržiūrėkite';
    $Self->{Translation}->{'Test/QA'} = 'Testavimas / kokybės užtikrinimas';

    # JS File: ITSM.Admin.ITSMConfigItem
    $Self->{Translation}->{'Overview and Confirmation'} = 'Apžvalga ir patvirtinimas';
    $Self->{Translation}->{'Importing classes/roles and their related fields'} = 'Klasių ir (arba) vaidmenų bei su jais susijusių laukų importavimas';
    $Self->{Translation}->{'An error occurred during class import.'} = 'Importuojant klasę įvyko klaida.';

    # SysConfig
    $Self->{Translation}->{'0 - Hidden'} = '0 - Paslėpta';
    $Self->{Translation}->{'1 - Shown'} = '1 - parodyta';
    $Self->{Translation}->{'A mapping of inner field names used in the Process Management TransitionActions ConfigItemAdd and -Update. The keys are the names of the set inner fields of the set with object type ticket which will be used to create/update the CI, and the values are the names of the inner fields of the set with object type ITSMConfigItem.'} =
        '';
    $Self->{Translation}->{'Allows extended search conditions in config item search of the agent interface. With this feature you can search e. g. config item name with this kind of conditions like "(*key1*&&*key2*)" or "(*key1*||*key2*)".'} =
        'Leidžia taikyti išplėstines paieškos sąlygas agento sąsajos konfigūracijos elementų paieškai. Naudodami šią funkciją galite ieškoti, pvz., konfigūracijos elemento pavadinimo su tokiomis sąlygomis, kaip "(*key1*&&*key2*)" arba "(*key1*||*key2*)".';
    $Self->{Translation}->{'Allows extended search conditions in config item search of the customer interface. With this feature you can search e. g. config item name with this kind of conditions like "(*key1*&&*key2*)" or "(*key1*||*key2*)".'} =
        'Leidžia taikyti išplėstines paieškos sąlygas klientų sąsajos konfigūracijos elementų paieškoje. Naudodami šią funkciją galite ieškoti, pvz., konfigūracijos elemento pavadinimo su tokiomis sąlygomis, kaip "(*key1*&&*key2*)" arba "(*key1*||*key2*)".';
    $Self->{Translation}->{'Assigned CIs'} = 'Priskirti KI';
    $Self->{Translation}->{'At a specific time point create a ticket for config items, if the configured requirements are met. The time point is determined by the value of the dynamic field of type date configured under "TimeCIKey" of the ConfigItem, and modified by "TimeModifier". If the latter can be either just a number, or a sign (+/-), a number, and an unit (d/h/m): "7" is equivalent to "+7d". The DynamicField "Ticket->DynamicField" will be used to mark created tickets - it has to exist. The flags \<OTOBO_CONFIGITEM_X\> where X can be NAME, NUMBER and DATE, will be substituted with the respective values in "Ticket->Text".'} =
        '';
    $Self->{Translation}->{'Attributes for license accounting.'} = '';
    $Self->{Translation}->{'Attributes for licenses counting, where "TotalLicensesDF", "AvailableLicensesDF" and "LicenseReferenceDF" are the names of the dynamic fields used to track the remaining licenses. If used, only deployment states in "ValidDeplStates" are considered. If a threshold is defined in "MinimumLicenses", a ticket will automatically be created if less licenses are available. For this, the checkbox dynamic field "Ticket->DynamicField" must exist. The tags \<OTOBO_CONFIGITEM_X\> where X can be NAME, NUMBER, LICENSES_AVAIL and LICENSES_MIN, will be substituted with the respective values in "Ticket->Text" by the config item name, number, available licenses, and minimum required available licenses, respectively.'} =
        '';
    $Self->{Translation}->{'CIs assigned to customer company'} = 'Kliento įmonei priskirti KI';
    $Self->{Translation}->{'CIs assigned to customer user'} = 'Kliento naudotojui priskirti CI';
    $Self->{Translation}->{'CMDB Settings'} = 'CMDB nustatymai';
    $Self->{Translation}->{'Check for a unique name only within the same ConfigItem class (\'class\') or globally (\'global\'), which means every existing ConfigItem is taken into account when looking for duplicates.'} =
        'Unikalaus pavadinimo tikrinama tik toje pačioje ConfigItem klasėje ("class") arba pasauliniu mastu ("global"), todėl ieškant pasikartojimų atsižvelgiama į kiekvieną esamą ConfigItem.';
    $Self->{Translation}->{'Choose a module to enforce a naming scheme.'} = 'Pasirinkite modulį, kuris užtikrins pavadinimų schemą.';
    $Self->{Translation}->{'Choose a module to enforce a number scheme.'} = 'Pasirinkite modulį, kuris užtikrins numerių schemą.';
    $Self->{Translation}->{'Choose a module to enforce a version string scheme.'} = 'Pasirinkite modulį, kuris užtikrins versijų eilučių schemą.';
    $Self->{Translation}->{'Choose attributes to trigger the creation of a new version.'} = 'Pasirinkite atributus, kad būtų sukurta nauja versija.';
    $Self->{Translation}->{'Choose categories to assign to this config item class.'} = 'Pasirinkite kategorijas, kurias norite priskirti šiai konfigūracijos elementų klasei.';
    $Self->{Translation}->{'Column config item filters for ConfigItem Overview.'} = 'Stulpelio konfigūracijos elementų filtrai ConfigItem Overview.';
    $Self->{Translation}->{'Columns that can be filtered in the config item overview of the agent interface. Note: Only Config Item attributes and Dynamic Fields (DynamicField_NameX) are allowed.'} =
        'Stulpeliai, kuriuos galima filtruoti agento sąsajos konfigūracijos elementų apžvalgoje. Pastaba: Leidžiami tik konfigūracijos elemento atributai ir dinaminiai laukai (DynamicField_NameX).';
    $Self->{Translation}->{'Config Items'} = 'Konfigūracijos elementai';
    $Self->{Translation}->{'Config item add.'} = 'Konfigūracijos elemento pridėjimas.';
    $Self->{Translation}->{'Config item edit.'} = 'Konfigūracijos elemento redagavimas.';
    $Self->{Translation}->{'Config item event module that enables accounting licenses for a given config item.'} =
        '';
    $Self->{Translation}->{'Config item event module that enables logging to history in the agent interface.'} =
        'Konfigūruokite elemento įvykių modulį, kuris leidžia registruoti istoriją agento sąsajoje.';
    $Self->{Translation}->{'Config item event module that updates config items to their current definition.'} =
        'Konfigūracijos elementų įvykių modulis, kuris atnaujina konfigūracijos elementų dabartinę apibrėžtį.';
    $Self->{Translation}->{'Config item history.'} = 'Konfigūracijos elementų istorija.';
    $Self->{Translation}->{'Config item print.'} = 'Konfigūracijos elemento spausdinimas.';
    $Self->{Translation}->{'Config item zoom.'} = 'Konfigūruoti elemento priartinimą.';
    $Self->{Translation}->{'ConfigItem Tree View'} = 'Konfigūracijos elementų medžio vaizdas';
    $Self->{Translation}->{'ConfigItem Version'} = 'ConfigItem Versija';
    $Self->{Translation}->{'ConfigItems of the following classes will not be stored on the Elasticsearch server. To apply this to existing CIs, the CI migration has to be run via console, after changing this option.'} =
        'Šių klasių ConfigItems nebus saugomi "Elasticsearch" serveryje. Norint tai pritaikyti esamiems CI, CI migraciją reikia paleisti per konsolę, pakeitus šią parinktį.';
    $Self->{Translation}->{'ConfigItems with the following deployment states will not be stored on the Elasticsearch server. To apply this to existing CIs, the CI migration has to be run via console, after changing this option.'} =
        '"Elasticsearch" serveryje nebus saugomi "ConfigItems" su šiomis diegimo būsenomis. Norint tai pritaikyti esamiems CI, CI perkėlimą reikia paleisti per konsolę, pakeitus šią parinktį.';
    $Self->{Translation}->{'Configuration Item Limit'} = 'Konfigūracijos elemento riba';
    $Self->{Translation}->{'Configuration Item limit per page.'} = 'Konfigūracijos elementų limitas viename puslapyje.';
    $Self->{Translation}->{'Configuration Management Database.'} = 'Konfigūracijos valdymo duomenų bazė.';
    $Self->{Translation}->{'Configuration item bulk module.'} = 'Konfigūracijos elemento masinis modulis.';
    $Self->{Translation}->{'Configuration item search backend router of the agent interface.'} =
        'Konfigūracijos elemento paieška agento sąsajos galiniame maršrutizatoriuje.';
    $Self->{Translation}->{'Configure the columns which are available for viewing Permission Conditions in the customer interface, when the corresponding Permission Condition Columns are not specifically configured. This setting is used as a fallback for the other Permission Condition Columns settings.'} =
        '';
    $Self->{Translation}->{'Configure the columns which are available when viewing the corresponding Permission Condition in the customer interface.'} =
        '';
    $Self->{Translation}->{'Create and manage the definitions for Configuration Items.'} = 'Sukurkite ir tvarkykite konfigūracijos elementų apibrėžtis.';
    $Self->{Translation}->{'Creates Tickets for ConfigItems at specific time points.'} = 'Sukuria "ConfigItems" bilietus tam tikrais laiko momentais.';
    $Self->{Translation}->{'Customers can see historic CI versions.'} = 'Klientai gali matyti istorines CI versijas.';
    $Self->{Translation}->{'Customers have the possibility to manually switch between historic CI versions.'} =
        'Klientai turi galimybę rankiniu būdu perjungti istorines CI versijas.';
    $Self->{Translation}->{'Default data to use on attribute for config item search screen. Example: "ITSMConfigItemCreateTimePointFormat=year;ITSMConfigItemCreateTimePointStart=Last;ITSMConfigItemCreateTimePoint=2;".'} =
        'Numatytieji duomenys, kuriuos reikia naudoti konfigūracijos elemento paieškos ekrano atributui. Pavyzdys: "ITSMConfigItemCreateTimePointFormat=year;ITSMConfigItemCreateTimePointStart=Last;ITSMConfigItemCreateTimePoint=2;".';
    $Self->{Translation}->{'Default data to use on attribute for config item search screen. Example: "ITSMConfigItemCreateTimeStartYear=2010;ITSMConfigItemCreateTimeStartMonth=10;ITSMConfigItemCreateTimeStartDay=4;ITSMConfigItemCreateTimeStopYear=2010;ITSMConfigItemCreateTimeStopMonth=11;ITSMConfigItemCreateTimeStopDay=3;".'} =
        'Numatytieji duomenys, kuriuos reikia naudoti konfigūracijos elemento paieškos ekrano atributui. Pavyzdys: "ITSMConfigItemCreateTimeStartYear=2010;ITSMConfigItemCreateTimeStartMonth=10;ITSMConfigItemCreateTimeStartDay=4;ITSMConfigItemCreateTimeStopYear=2010;ITSMConfigItemCreateTimeStopMonth=11;ITSMConfigItemCreateTimeStopDay=3;".';
    $Self->{Translation}->{'Define Actions where a settings button is available in the linked objects widget (LinkObject::ViewMode = "complex"). Please note that these Actions must have registered the following JS and CSS files: Core.AllocationList.css, Core.UI.AllocationList.js, Core.UI.Table.Sort.js, Core.Agent.TableFilters.js and Core.Agent.LinkObject.js.'} =
        'Apibrėžti veiksmus, kai susietų objektų valdiklyje (LinkObject::ViewMode = "complex") yra nustatymų mygtukas. Atkreipkite dėmesį, kad šiuose veiksmuose turi būti užregistruoti šie JS ir CSS failai: Core.AllocationList.css, Core.UI.AllocationList.js, Core.UI.Table.Sort.js, Core.Agent.TableFilters.js ir Core.Agent.LinkObject.js.';
    $Self->{Translation}->{'Define a Template::Toolkit scheme for version strings. Only used if Version String Module is set to TemplateToolkit.'} =
        'Apibrėžkite "Template::Toolkit" schemą, skirtą versijų eilutėms. Naudojama tik tada, jei versijų eilučių modulis nustatytas į TemplateToolkit.';
    $Self->{Translation}->{'Define a set of conditions under which a customer is allowed to see a config item. Conditions can optionally be restricted to certain customer groups. Name is the only mandatory attribute. If no other options are given, all config items will be visible under that category.'} =
        'Apibrėžkite sąlygų, kuriomis klientui leidžiama matyti konfigūracijos elementą, rinkinį. Sąlygas galima apriboti tam tikroms klientų grupėms. Pavadinimas yra vienintelis privalomas atributas. Jei kitų parinkčių nenurodyta, visi konfigūracijos elementai bus matomi toje kategorijoje.';
    $Self->{Translation}->{'Defines Required permissions to delete ITSM configuration items using the Generic Interface.'} =
        'Apibrėžiami reikalingi leidimai ištrinti ITSM konfigūracijos elementus naudojant bendrąją sąsają.';
    $Self->{Translation}->{'Defines Required permissions to get ITSM configuration items using the Generic Interface.'} =
        'Apibrėžiami reikalingi leidimai gauti ITSM konfigūracijos elementus naudojant bendrąją sąsają.';
    $Self->{Translation}->{'Defines Required permissions to search ITSM configuration items using the Generic Interface.'} =
        'Apibrėžiami reikalingi leidimai ieškoti ITSM konfigūracijos elementų naudojant bendrąją sąsają.';
    $Self->{Translation}->{'Defines Required permissions to set ITSM configuration items using the Generic Interface.'} =
        'Apibrėžia Reikalingi leidimai nustatyti ITSM konfigūracijos elementus naudojant bendrąją sąsają.';
    $Self->{Translation}->{'Defines an overview module to show the small view of a configuration item list.'} =
        'Apibrėžia apžvalgos modulį, skirtą mažajam konfigūracijos elementų sąrašo vaizdui rodyti.';
    $Self->{Translation}->{'Defines if the link type labels must be shown in the node connections.'} =
        'Nustato, ar mazgų jungtyse turi būti rodomos nuorodos tipo etiketės.';
    $Self->{Translation}->{'Defines regular expressions individually for each ConfigItem class to check the ConfigItem name and to show corresponding error messages.'} =
        'Apibrėžia reguliarias išraiškas atskirai kiekvienai "ConfigItem" klasei, kad būtų galima patikrinti "ConfigItem" pavadinimą ir rodyti atitinkamus klaidų pranešimus.';
    $Self->{Translation}->{'Defines the available columns of CIs in the config item overview depending on the CI class. Each entry must consist of a class name and an array of available fields for the corresponding class. Dynamic field entries have to honor the scheme DynamicField_FieldName.'} =
        'Nustato galimus KI stulpelius konfigūracijos elementų apžvalgoje, priklausomai nuo KI klasės. Kiekvieną įrašą turi sudaryti klasės pavadinimas ir atitinkamos klasės galimų laukų masyvas. Dinaminių laukų įrašai turi atitikti schemą DynamicField_FieldName.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of the agent interface.'} =
        'Nustato numatytojo konfigūracijos elemento atributą konfigūracijos elementų rūšiavimui agento sąsajos konfigūracijos elementų paieškos rezultatuose.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of the customer interface.'} =
        'Nustato numatytąjį konfigūracijos elemento atributą konfigūracijos elementų rūšiavimui klientų sąsajos konfigūracijos elementų paieškos rezultatuose.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of this operation.'} =
        'Nustato numatytojo konfigūracijos elemento atributą, skirtą šios operacijos konfigūracijos elementų paieškos rezultatui rūšiuoti.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the agent interface. Up: oldest on top. Down: latest on top.'} =
        'Nustato numatytąją konfigūracijos elementų tvarką agento sąsajos konfigūracijos elementų paieškos rezultatuose. Aukštyn: seniausias viršuje. Žemyn: naujausias viršuje.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the customer interface. Up: oldest on top. Down: latest on top.'} =
        'Nustato numatytoji konfigūracijos elementų tvarka kliento sąsajos konfigūracijos elementų paieškos rezultatuose. Aukštyn: seniausias viršuje. Žemyn: naujausias viršuje.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the this operation. Up: oldest on top. Down: latest on top.'} =
        'Nustato numatytoji konfigūracijos elementų tvarka šios operacijos konfigūracijos elementų paieškos rezultate. Į viršų: seniausia viršuje. Žemyn: naujausias viršuje.';
    $Self->{Translation}->{'Defines the default displayed columns of CIs in the config item overview depending on the CI class. Each entry must consist of a class name and an array of available fields for the corresponding class. Dynamic field entries have to honor the scheme DynamicField_FieldName.'} =
        'Nustato pagal nutylėjimą rodomus KI stulpelius konfigūracijos elementų apžvalgoje, priklausomai nuo KI klasės. Kiekvieną įrašą turi sudaryti klasės pavadinimas ir atitinkamos klasės galimų laukų masyvas. Dinaminių laukų įrašai turi atitikti schemą DynamicField_FieldName.';
    $Self->{Translation}->{'Defines the default relations depth to be shown.'} = 'Apibrėžiamas numatytasis rodomų santykių gylis.';
    $Self->{Translation}->{'Defines the default shown config item search attribute for config item search screen.'} =
        'Nustato pagal nutylėjimą rodomą konfigūracijos elementų paieškos atributą konfigūracijos elementų paieškos ekrane.';
    $Self->{Translation}->{'Defines the default shown config item search attribute for config item search screen. Example: "Key" must have the name of the Dynamic Field in this case \'X\', "Content" must have the value of the Dynamic Field depending on the Dynamic Field type,  Text: \'a text\', Dropdown: \'1\', Date/Time: \'Search_DynamicField_XTimeSlotStartYear=1974; Search_DynamicField_XTimeSlotStartMonth=01; Search_DynamicField_XTimeSlotStartDay=26; Search_DynamicField_XTimeSlotStartHour=00; Search_DynamicField_XTimeSlotStartMinute=00; Search_DynamicField_XTimeSlotStartSecond=00; Search_DynamicField_XTimeSlotStopYear=2013; Search_DynamicField_XTimeSlotStopMonth=01; Search_DynamicField_XTimeSlotStopDay=26; Search_DynamicField_XTimeSlotStopHour=23; Search_DynamicField_XTimeSlotStopMinute=59; Search_DynamicField_XTimeSlotStopSecond=59;\' and or \'Search_DynamicField_XTimePointFormat=week; Search_DynamicField_XTimePointStart=Before; Search_DynamicField_XTimePointValue=7\';.'} =
        'Nustato pagal nutylėjimą rodomą konfigūracijos elementų paieškos atributą konfigūracijos elementų paieškos ekrane. Pavyzdys: "Key" (raktas) turi turėti dinaminio lauko pavadinimą, šiuo atveju "X", "Content" (turinys) turi turėti dinaminio lauko reikšmę, priklausančią nuo dinaminio lauko tipo, "Text" (tekstas): "a text" (tekstas), "Dropdown" (išskleidžiama): "1" (išskleidžiama), "Date/Time" (data ir laikas): Paieška_DynamicField_XTimeSlotStartYear=1974; Search_DynamicField_XTimeSlotStartMonth=01; Search_DynamicField_XTimeSlotStartDay=26; Search_DynamicField_XTimeSlotStartHour=00; Search_DynamicField_XTimeSlotStartMinute=00; Search_DynamicField_XTimeSlotStartSecond=00; Search_DynamicField_XTimeSlotStopYear=2013; Search_DynamicField_XTimeSlotStopMonth=01; Search_DynamicField_XTimeSlotStopDay=26; Search_DynamicField_XTimeSlotStopHour=23; Search_DynamicField_XTimeSlotStopMinute=59; Search_DynamicField_XTimeSlotStopSecond=59;\' ir arba \'Search_DynamicField_XTimePointFormat=savaitė; Search_DynamicField_XTimePointStart=Before; Search_DynamicField_XTimePointValue=7\';.';
    $Self->{Translation}->{'Defines the default subobject of the class \'ITSMConfigItem\'.'} =
        'Apibrėžia numatytąjį klasės "ITSMConfigItem" subobjektą.';
    $Self->{Translation}->{'Defines the disabled columns of CIs in the config item overview depending on the CI class. Each entry must consist of a class name and an array of available fields for the corresponding class. Dynamic field entries have to honor the scheme DynamicField_FieldName.'} =
        '';
    $Self->{Translation}->{'Defines the height for the rich text editor component for this screen. Enter number (pixels) or percent value (relative).'} =
        'Nustato šio ekrano teksto redaktoriaus komponento aukštį. Įveskite skaičių (pikseliai) arba procentinę vertę (santykinė).';
    $Self->{Translation}->{'Defines the number of rows for the CI definition editor in the admin interface.'} =
        'Nustato CI apibrėžimo redaktoriaus eilučių skaičių administratoriaus sąsajoje.';
    $Self->{Translation}->{'Defines the order of incident states from high (e.g. cricital) to low (e.g. functional).'} =
        'Nustato įvykio būsenų eiliškumą nuo aukštų (pvz., kritiškų) iki žemų (pvz., funkcinių).';
    $Self->{Translation}->{'Defines the relevant deployment states where linked tickets can affect the status of a CI.'} =
        'Apibrėžiamos atitinkamos diegimo būsenos, kuriose susieti bilietai gali turėti įtakos CI būsenai.';
    $Self->{Translation}->{'Defines the search limit for the AgentITSMConfigItem screen.'} =
        'Nustato AgentITSMConfigItem ekrano paieškos ribą.';
    $Self->{Translation}->{'Defines the search limit for the AgentITSMConfigItemSearch screen.'} =
        'Nustato AgentITSMConfigItemSearch ekrano paieškos ribą.';
    $Self->{Translation}->{'Defines the search limit for the CustomerITSMConfigItem screen.'} =
        'Nustato CustomerITSMConfigItem ekrano paieškos ribą.';
    $Self->{Translation}->{'Defines the search limit for the CustomerITSMConfigItemSearch screen.'} =
        'Nustato CustomerITSMConfigItemSearch ekrano paieškos ribą.';
    $Self->{Translation}->{'Defines the shown columns of CIs in the link table complex view for all CI classes. If there is no entry, then the default columns are shown.'} =
        'Nustato nuorodų lentelės sudėtingame rodinyje rodomus visų klasių KI stulpelius. Jei įrašo nėra, rodomi numatytieji stulpeliai.';
    $Self->{Translation}->{'Defines the shown columns of CIs in the link table complex view, depending on the CI class. Each entry must be prefixed with the class name and double colons (i.e. Computer::). There are a few CI-Attributes that common to all CIs (example for the class Computer: Computer::Name, Computer::CurDeplState, Computer::CreateTime). To show individual CI-Attributes as defined in the CI-Definition, the following scheme must be used (example for the class Computer): Computer::HardDisk::1, Computer::HardDisk::1::Capacity::1, Computer::HardDisk::2, Computer::HardDisk::2::Capacity::1. If there is no entry for a CI class, then the default columns are shown.'} =
        'Nustato nuorodų lentelės sudėtingame rodinyje rodomus KI stulpelius, priklausomai nuo KI klasės. Prieš kiekvieną įrašą turi būti įrašytas klasės pavadinimas ir dvigubi dvitaškiai (t. y. Computer::). Yra keletas CI atributų, kurie bendri visiems CI (pavyzdys klasės Computer (Kompiuteris): Computer::Name, Computer::CurDeplState, Computer::CreateTime). Norint parodyti atskirus CI atributus, apibrėžtus CI apibrėžtyje, reikia naudoti tokią schemą (klasės Computer pavyzdys): Computer::HardDisk::1, Computer::HardDisk::1::Capacity::1, Computer::HardDisk::2, Computer::HardDisk::2::Capacity::1. Jei nėra CI klasės įrašo, rodomi numatytuosius nustatymus atitinkantys stulpeliai.';
    $Self->{Translation}->{'Defines which items are available for \'Action\' in third level of the ITSM Config Item ACL structure.'} =
        'Apibrėžia, kuriuos elementus galima naudoti "Action" trečiajame ITSM Config Item ACL struktūros lygyje.';
    $Self->{Translation}->{'Defines which items are available in first level of the ITSM Config Item ACL structure.'} =
        'Nustato, kurie elementai yra prieinami pirmojo lygio ITSM Config Item ACL struktūroje.';
    $Self->{Translation}->{'Defines which items are available in second level of the ITSM Config Item ACL structure.'} =
        'Nustato, kurie elementai yra prieinami antrajame ITSM Config Item ACL struktūros lygyje.';
    $Self->{Translation}->{'Defines which type of link (named from the ticket perspective) can affect the status of a linked CI.'} =
        'Apibrėžia, kokio tipo nuoroda (įvardyta iš bilieto perspektyvos) gali turėti įtakos susietos CI būklei.';
    $Self->{Translation}->{'Defines which type of ticket can affect the status of a linked CI.'} =
        'Nustato, kokio tipo bilietas gali turėti įtakos susietos CI būklei.';
    $Self->{Translation}->{'Definition Update'} = 'Apibrėžimo atnaujinimas';
    $Self->{Translation}->{'Delete Configuration Item'} = 'Ištrinti konfigūracijos elementą';
    $Self->{Translation}->{'DeplState'} = 'DeplState';
    $Self->{Translation}->{'Deployment State Color'} = 'Diegimo būsenos spalva';
    $Self->{Translation}->{'DeploymentState'} = 'Diegimo būsena';
    $Self->{Translation}->{'Duplicate'} = 'Dublikatas';
    $Self->{Translation}->{'Dynamic field event module that marks config item definitions as out of sync, if containing dynamic fields change.'} =
        'Dinaminių laukų įvykių modulis, kuris žymi konfigūracijos elementų apibrėžtis kaip nesinchronizuotas, jei pasikeičia dinaminiai laukai.';
    $Self->{Translation}->{'Dynamic fields shown in the additional ITSM field screen of the agent interface.'} =
        'Dinaminiai laukai, rodomi agento sąsajos papildomo ITSM lauko ekrane.';
    $Self->{Translation}->{'Dynamic fields shown in the config item overview screen of the customer interface.'} =
        'Dinaminiai laukai, rodomi kliento sąsajos konfigūracijos elemento apžvalgos ekrane.';
    $Self->{Translation}->{'Dynamic fields shown in the config item search screen of the agent interface.'} =
        'Dinaminiai laukai, rodomi agento sąsajos konfigūracijos elementų paieškos ekrane.';
    $Self->{Translation}->{'Enables configuration item bulk action feature for the agent frontend to work on more than one configuration item at a time.'} =
        'Įjungiama konfigūracijos elemento masinio veiksmo funkcija, kad agento priekinėje dalyje vienu metu būtų galima dirbti su daugiau nei vienu konfigūracijos elementu.';
    $Self->{Translation}->{'Enables configuration item bulk action feature only for the listed groups.'} =
        'Įjungiama konfigūracijos elemento masinio veiksmo funkcija tik išvardytoms grupėms.';
    $Self->{Translation}->{'Enables/disables the functionality to check ITSM onfiguration items for unique names. Before enabling this option you should check your system for already existing config items with duplicate names. You can do this with the console command Admin::ITSM::ConfigItem::ListDuplicates.'} =
        'Įjungiama / išjungiama funkcija, skirta patikrinti ITSM konfigūracijos elementų unikalius pavadinimus. Prieš įjungdami šią parinktį, turėtumėte patikrinti, ar jūsų sistemoje nėra jau esamų konfigūracijos elementų su pasikartojančiais pavadinimais. Tai galite padaryti naudodami konsolės komandą Admin::ITSM::ConfigItem::ListDuplicates.';
    $Self->{Translation}->{'Event module to set configitem-status on ticket-configitem-link.'} =
        'Įvykių modulis, skirtas nustatyti "ticket-configitem-link" konfigūracijos elemento būseną.';
    $Self->{Translation}->{'Fields of the configuration item index, used for the fulltext search. Fields are also stored, but are not mandatory for the overall functionality. Inclusion of attachments can be disabled by setting the entry to 0 or deleting it.'} =
        'Konfigūracijos elemento indekso laukai, naudojami viso teksto paieškai. Laukai taip pat saugomi, tačiau nėra privalomi bendrai funkcijai. Priedų įtraukimą galima išjungti nustatant įrašo reikšmę 0 arba jį ištrinant.';
    $Self->{Translation}->{'Fields stored in the configuration item index which are used for other things besides fulltext searches. For the complete functionality all fields are mandatory.'} =
        'Konfigūracijos elemento indekse saugomi laukai, kurie naudojami ne tik viso teksto paieškai, bet ir kitiems dalykams. Kad funkcijos būtų pilnai išnaudotos, visi laukai yra privalomi.';
    $Self->{Translation}->{'For every webservice (key) an array of classes (value) can be defined on which the import is restricted. For all chosen classes, or all existing classes the identifying attributes will have to be chosen in the invoker config.'} =
        'Kiekvienai žiniatinklio paslaugai (raktas) galima apibrėžti klasių masyvą (reikšmė), kurio importas yra ribojamas. Visoms pasirinktoms klasėms arba visoms esamoms klasėms identifikuojantys atributai turės būti pasirinkti invokerio konfigūracijoje.';
    $Self->{Translation}->{'GenericInterface module registration for the ConfigItemCreate invoker layer.'} =
        '';
    $Self->{Translation}->{'GenericInterface module registration for the ConfigItemFetch invoker layer.'} =
        '"GenericInterface" modulio registracija "ConfigItemFetch" iškvietėjo sluoksniui.';
    $Self->{Translation}->{'GenericInterface module registration for the ConfigItemUpdate invoker layer.'} =
        '';
    $Self->{Translation}->{'ITSM ConfigItem'} = 'ITSM ConfigItem';
    $Self->{Translation}->{'ITSM config item overview.'} = 'ITSM konfigūracijos elementų apžvalga.';
    $Self->{Translation}->{'InciState'} = 'InciState';
    $Self->{Translation}->{'IncidentState'} = 'IncidentState';
    $Self->{Translation}->{'Includes deployment states in the config item search of the customer interface.'} =
        'Įtraukti diegimo būsenas į konfigūracijos elementų paiešką kliento sąsajoje.';
    $Self->{Translation}->{'Includes incident states in the config item search of the customer interface.'} =
        'Įtraukti incidento būsenas į konfigūracijos elementų paiešką klientų sąsajoje.';
    $Self->{Translation}->{'License accounting configuration item event module.'} = '';
    $Self->{Translation}->{'Maximum number of config items to be displayed in the result of this operation.'} =
        'Didžiausias konfigūracijos elementų, kurie bus rodomi šios operacijos rezultate, skaičius.';
    $Self->{Translation}->{'Module to check the group responsible for a class.'} = 'Modulis, skirtas už klasę atsakingai grupei patikrinti.';
    $Self->{Translation}->{'Module to check the group responsible for a configuration item.'} =
        'Modulis, skirtas patikrinti grupę, atsakingą už konfigūracijos elementą.';
    $Self->{Translation}->{'Module to generate ITSM config item statistics.'} = 'ITSM konfigūracijos elementų statistikos generavimo modulis.';
    $Self->{Translation}->{'Name Module'} = 'Pavadinimo modulis';
    $Self->{Translation}->{'Number Module'} = 'Numerio modulis';
    $Self->{Translation}->{'Number of config items to be displayed in each page of a search result in the agent interface.'} =
        'Konfigūracijos elementų, rodomų kiekviename paieškos rezultatų puslapyje agento sąsajoje, skaičius.';
    $Self->{Translation}->{'Number of config items to be displayed in each page of a search result in the customer interface.'} =
        'Konfigūracijos elementų, kurie bus rodomi kiekviename paieškos rezultatų puslapyje kliento sąsajoje, skaičius.';
    $Self->{Translation}->{'Objects to search for, how many entries and which attributs to show. ConfigItem attributes have to explicitly be stored via Elasticsearch.'} =
        'Objektų, kurių reikia ieškoti, kiek įrašų ir kokius atributus rodyti. ConfigItem atributai turi būti aiškiai saugomi per "Elasticsearch".';
    $Self->{Translation}->{'Overview.'} = 'Apžvalga.';
    $Self->{Translation}->{'Parameters for the categories for config item classes in the preferences view of the agent interface.'} =
        'Parametrai, skirti konfigūracijos elementų klasių kategorijoms agento sąsajos nuostatų rodinyje.';
    $Self->{Translation}->{'Parameters for the column filters of the small config item overview. Please note: setting \'Active\' to 0 will only prevent agents from editing settings of this group in their personal preferences, but will still allow administrators to edit the settings of another user\'s behalf. Use \'PreferenceGroup\' to control in which area these settings should be shown in the user interface.'} =
        'Mažosios konfigūracijos elementų apžvalgos stulpelių filtrų parametrai. Atkreipkite dėmesį: nustačius "Active" vertę 0, agentai negalės redaguoti tik šios grupės nustatymų savo asmeninėse parinktyse, tačiau administratoriams vis tiek bus leidžiama redaguoti kito naudotojo nustatymus. Naudokite "PreferenceGroup", norėdami valdyti, kurioje srityje šie nustatymai turėtų būti rodomi naudotojo sąsajoje.';
    $Self->{Translation}->{'Parameters for the dashboard backend of the customer company config item overview of the agent interface . "Limit" is the number of entries per config item class shown by default. "Group" is used to restrict the access to the plugin (e. g. Group: admin;group1;group2;). "Default" determines if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" is the cache time in minutes for the plugin. "ConfigItemKey" is used to specify which reference field is used for a ConfigItem class (Key=Class, Value=DynamicFieldName).'} =
        '';
    $Self->{Translation}->{'Parameters for the dashboard backend of the customer company config item overview of the agent interface . "Limit" is the number of entries shown by default. "Group" is used to restrict the access to the plugin (e. g. Group: admin;group1;group2;). "Default" determines if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" is the cache time in minutes for the plugin. "ConfigItemKey" is used to specify which reference field is used for a ConfigItem class (Key=Class, Value=DynamicFieldName).'} =
        '';
    $Self->{Translation}->{'Parameters for the deployment states color in the preferences view of the agent interface.'} =
        'Įdiegimo būsenų parametrai nuspalvinti agento sąsajos nuostatų rodinyje.';
    $Self->{Translation}->{'Parameters for the deployment states in the preferences view of the agent interface.'} =
        'diegimo būsenų parametrai agento sąsajos nuostatų rodinyje.';
    $Self->{Translation}->{'Parameters for the example permission groups of the general catalog attributes.'} =
        'Bendrųjų katalogo atributų leidimų grupių pavyzdžių parametrai.';
    $Self->{Translation}->{'Parameters for the name module for config item classes in the preferences view of the agent interface.'} =
        'Agento sąsajos nuostatų rodinyje esančių konfigūracijos elementų klasių vardų modulio parametrai.';
    $Self->{Translation}->{'Parameters for the number module for config item classes in the preferences view of the agent interface.'} =
        'Agento sąsajos nuostatų rodinyje esančių konfigūracijos elementų klasių numerio modulio parametrai.';
    $Self->{Translation}->{'Parameters for the pages (in which the configuration items are shown).'} =
        'Puslapių (kuriuose rodomi konfigūracijos elementai) parametrai.';
    $Self->{Translation}->{'Parameters for the version string module for config item classes in the preferences view of the agent interface.'} =
        'Agento sąsajos nuostatų rodinyje esančių konfigūracijos elementų klasių versijos eilutės modulio parametrai.';
    $Self->{Translation}->{'Parameters for the version string template toolkit module for config item classes in the preferences view of the agent interface.'} =
        'Agento sąsajos nuostatų rodinyje esančių konfigūracijos elementų klasių konfigūracijos eilutės šablono įrankių rinkinio modulio parametrai.';
    $Self->{Translation}->{'Parameters for the version trigger for config item classes in the preferences view of the agent interface.'} =
        'Agento sąsajos nuostatų rodinyje esančių konfigūracijos elementų klasių versijos trigerio parametrai.';
    $Self->{Translation}->{'Performs the configured action for each event (as an Invoker) for each configured Webservice.'} =
        'Atlieka sukonfigūruotą veiksmą kiekvienam įvykiui (kaip Invoker) kiekvienai sukonfigūruotai žiniatinklio paslaugai.';
    $Self->{Translation}->{'Permission Group'} = 'Leidimų grupė';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item attachment action in the agent interface.'} =
        'Reikalingi leidimai naudoti ITSM konfigūracijos elemento prijungimo veiksmą agento sąsajoje.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item screen in the agent interface.'} =
        'Reikalingi leidimai naudoti ITSM konfigūracijos elemento ekraną agento sąsajoje.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item search screen in the agent interface.'} =
        'Reikalingi leidimai naudoti ITSM konfigūracijos elementų paieškos langą agento sąsajoje.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item search screen in the customer interface.'} =
        'Reikalingi leidimai naudoti ITSM konfigūracijos elementų paieškos ekraną kliento sąsajoje.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item tree view screen in the agent interface.'} =
        'Reikalingi leidimai naudoti ITSM konfigūracijos elementų medžio peržiūros ekraną agento sąsajoje.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item zoom screen in the agent interface.'} =
        'Reikalingi leidimai naudoti ITSM konfigūracijos elemento priartinimo ekraną agento sąsajoje.';
    $Self->{Translation}->{'Required permissions to use the add ITSM configuration item screen in the agent interface.'} =
        'Reikalingi leidimai naudoti ITSM konfigūracijos elemento pridėjimo langą agento sąsajoje.';
    $Self->{Translation}->{'Required permissions to use the bulk ITSM configuration item screen in the agent interface.'} =
        'Reikalingi leidimai, kad būtų galima naudoti agento sąsajos ITSM konfigūracijos elemento ekraną.';
    $Self->{Translation}->{'Required permissions to use the edit ITSM configuration item screen in the agent interface.'} =
        'Reikalingi leidimai naudoti ITSM konfigūracijos elemento redagavimo ekraną agento sąsajoje.';
    $Self->{Translation}->{'Required permissions to use the history ITSM configuration item screen in the agent interface.'} =
        'Reikalingi leidimai, kad būtų galima naudoti agento sąsajos istorijos ITSM konfigūracijos elemento ekraną.';
    $Self->{Translation}->{'Required permissions to use the print ITSM configuration item screen in the agent interface.'} =
        'Reikalingi leidimai, kad būtų galima naudoti agento sąsajos ITSM konfigūracijos elemento spausdinimo ekraną.';
    $Self->{Translation}->{'Required privileges to delete config items.'} = 'Reikalingos privilegijos norint ištrinti konfigūracijos elementus.';
    $Self->{Translation}->{'Search config items.'} = 'Ieškoti konfigūracijos elementų.';
    $Self->{Translation}->{'Set the incident state of a CI automatically when a Ticket is Linked to a CI.'} =
        'Automatiškai nustatykite KI incidento būseną, kai bilietas susiejamas su KI.';
    $Self->{Translation}->{'Sets the deployment state in the configuration item bulk screen of the agent interface.'} =
        'Nustato diegimo būseną agento sąsajos konfigūracijos elemento didmeniniame ekrane.';
    $Self->{Translation}->{'Sets the incident state in the configuration item bulk screen of the agent interface.'} =
        'Nustato incidento būseną agento sąsajos konfigūracijos elemento didmeninės konfigūracijos ekrane.';
    $Self->{Translation}->{'Shows a link in the menu that allows linking a configuration item with another object in the config item zoom view of the agent interface.'} =
        'Meniu rodoma nuoroda, leidžianti susieti konfigūracijos elementą su kitu objektu agento sąsajos konfigūracijos elemento priartinimo rodinyje.';
    $Self->{Translation}->{'Shows a link in the menu to access the history of a configuration item in the configuration item overview of the agent interface.'} =
        'Rodo meniu nuorodą, skirtą pasiekti konfigūracijos elemento istoriją agento sąsajos konfigūracijos elementų apžvalgoje.';
    $Self->{Translation}->{'Shows a link in the menu to access the history of a configuration item in the its zoom view of the agent interface.'} =
        'Meniu rodoma nuoroda, kuria galima pasiekti konfigūracijos elemento istoriją agento sąsajos priartinimo rodinyje.';
    $Self->{Translation}->{'Shows a link in the menu to delete a configuration item in its zoom view of the agent interface.'} =
        'Rodoma meniu nuoroda, skirta ištrinti konfigūracijos elementą jo priartintame agento sąsajos rodinyje.';
    $Self->{Translation}->{'Shows a link in the menu to display the configuration item links as a Tree View.'} =
        'Rodo meniu nuorodą, kad konfigūracijos elementų nuorodos būtų rodomos medžio rodinyje.';
    $Self->{Translation}->{'Shows a link in the menu to duplicate a configuration item in the configuration item overview of the agent interface.'} =
        'Rodoma meniu nuoroda, skirta dubliuoti konfigūracijos elementą agento sąsajos konfigūracijos elementų apžvalgoje.';
    $Self->{Translation}->{'Shows a link in the menu to duplicate a configuration item in the its zoom view of the agent interface.'} =
        'Meniu rodoma nuoroda, skirta konfigūracijos elementui dubliuoti agento sąsajos priartinimo rodinyje.';
    $Self->{Translation}->{'Shows a link in the menu to edit a configuration item in the its zoom view of the agent interface.'} =
        'Rodoma meniu nuoroda, skirta redaguoti konfigūracijos elementą agento sąsajos priartintame rodinyje.';
    $Self->{Translation}->{'Shows a link in the menu to go back in the configuration item zoom view of the agent interface.'} =
        'Meniu rodoma nuoroda, kuria galima grįžti į agento sąsajos konfigūracijos elemento priartinimo rodinį.';
    $Self->{Translation}->{'Shows a link in the menu to print a configuration item in the its zoom view of the agent interface.'} =
        'Rodoma meniu nuoroda, skirta spausdinti konfigūracijos elementą agento sąsajos priartintame rodinyje.';
    $Self->{Translation}->{'Shows a link in the menu to zoom into a configuration item in the configuration item overview of the agent interface.'} =
        'Rodoma meniu nuoroda, skirta priartinti konfigūracijos elementą agento sąsajos konfigūracijos elementų apžvalgoje.';
    $Self->{Translation}->{'Shows the config item history (reverse ordered) in the agent interface.'} =
        'Rodo konfigūracijos elementų istoriją (atvirkštine tvarka) agento sąsajoje.';
    $Self->{Translation}->{'The default category which is shown, if none is selected.'} = 'Numatytoji kategorija, kuri rodoma, jei nepasirinkta nė viena.';
    $Self->{Translation}->{'The identifier for a configuration item, e.g. ConfigItem#, MyConfigItem#. The default is ConfigItem#.'} =
        'Konfigūracijos elemento identifikatorius, pvz., ConfigItem#, MyConfigItem#. Numatytoji reikšmė yra ConfigItem#.';
    $Self->{Translation}->{'Triggers ConfigItemFetch invoker automatically.'} = 'Automatiškai paleidžia ConfigItemFetch invokatorių.';
    $Self->{Translation}->{'Version String Expression'} = 'Versija Styginių eilutė Išraiška';
    $Self->{Translation}->{'Version String Module'} = 'Versijos eilutės modulis';
    $Self->{Translation}->{'Version Trigger'} = 'Versija Triggeris';
    $Self->{Translation}->{'Whether fields should be automatically filled (1), and in that case also be hidden from ticket formulars (2).'} =
        '';
    $Self->{Translation}->{'Whether the execution of ConfigItemACL can be avoided by checking cached field dependencies. This can improve loading times of formulars, but has to be disabled, if ACLModules are to be used for ITSMConfigItem- and Form-ReturnTypes.'} =
        'Ar galima išvengti "ConfigItemACL" vykdymo tikrinant talpykloje esančių laukų priklausomybes. Tai gali pagerinti formuliarų įkėlimo laiką, tačiau turi būti išjungta, jei ACLModules turi būti naudojami ITSMConfigItem- ir Form-ReturnTypes.';
    $Self->{Translation}->{'Which general information is shown in the header.'} = 'Kokia bendra informacija pateikiama antraštėje.';
    $Self->{Translation}->{'class'} = 'klasė';
    $Self->{Translation}->{'global'} = 'pasaulinis';
    $Self->{Translation}->{'postproductive'} = 'postprodukcinis';
    $Self->{Translation}->{'preproductive'} = 'priešprodukcinis';
    $Self->{Translation}->{'productive'} = 'produktyvus';

    # Ready to adopt classes: IT-Servicemanagement-11_0_3
    $Self->{Translation}->{'10U: 17.5 inches (44.45 cm)'} = '10U: 17,5 colio (44,45 cm)';
    $Self->{Translation}->{'12U: 21 inches (53.34 cm)'} = '12U: 21 colis (53,34 cm)';
    $Self->{Translation}->{'15U: 26.25 inches (66.68 cm)'} = '15U: 26,25 colio (66,68 cm)';
    $Self->{Translation}->{'18U: 31.5 inches (80.01 cm)'} = '18U: 31,5 colio (80,01 cm)';
    $Self->{Translation}->{'19-inch Rack'} = '19 colių stovas';
    $Self->{Translation}->{'1U: 1.75 inches (4.45 cm)'} = '1U: 1,75 colio (4,45 cm)';
    $Self->{Translation}->{'20U: 35 inches (88.9 cm)'} = '20U: 35 coliai (88,9 cm)';
    $Self->{Translation}->{'21-inch Rack'} = '21 colio stovas';
    $Self->{Translation}->{'22U: 38.5 inches (97.79 cm)'} = '22U: 38,5 colio (97,79 cm)';
    $Self->{Translation}->{'23-inch Rack'} = '23 colių stovas';
    $Self->{Translation}->{'23.6 inches (600 mm)'} = '23,6 colio (600 mm)';
    $Self->{Translation}->{'24U: 42 inches (106.68 cm)'} = '24U: 42 coliai (106,68 cm)';
    $Self->{Translation}->{'27U: 47.25 inches (120.02 cm)'} = '27U: 47,25 colio (120,02 cm)';
    $Self->{Translation}->{'2U: 3.5 inches (8.89 cm)'} = '2U: 3,5 colio (8,89 cm)';
    $Self->{Translation}->{'30U: 52.5 inches (133.35 cm)'} = '30U: 52,5 colio (133,35 cm)';
    $Self->{Translation}->{'31.5 inches (800 mm)'} = '31,5 colio (800 mm)';
    $Self->{Translation}->{'33U: 57.75 inches (146.68 cm)'} = '33U: 57,75 colio (146,68 cm)';
    $Self->{Translation}->{'35.4 inches (900 mm)'} = '35,4 colio (900 mm)';
    $Self->{Translation}->{'36U: 63 inches (160.02 cm)'} = '36U: 63 coliai (160,02 cm)';
    $Self->{Translation}->{'39.4 inches (1000 mm)'} = '39,4 colio (1000 mm)';
    $Self->{Translation}->{'39U: 68.25 inches (173.35 cm)'} = '39U: 68,25 colio (173,35 cm)';
    $Self->{Translation}->{'3U: 5.25 inches (13.34 cm)'} = '3U: 5,25 colio (13,34 cm)';
    $Self->{Translation}->{'42U: 73.5 inches (186.69 cm)'} = '42U: 73,5 colio (186,69 cm)';
    $Self->{Translation}->{'43.3 inches (1100 mm):'} = '43,3 colio (1100 mm):';
    $Self->{Translation}->{'45U: 78.75 inches (200.02 cm)'} = '45U: 78,75 colio (200,02 cm)';
    $Self->{Translation}->{'47.2 inches (1200 mm)'} = '47,2 colio (1200 mm)';
    $Self->{Translation}->{'48U: 84 inches (213.36 cm)'} = '48U: 84 coliai (213,36 cm)';
    $Self->{Translation}->{'4U: 7 inches (17.78 cm)'} = '4U: 7 coliai (17,78 cm)';
    $Self->{Translation}->{'5U: 8.75 inches (22.23 cm)'} = '5U: 8,75 colio (22,23 cm)';
    $Self->{Translation}->{'6U: 10.5 inches (26.67 cm)'} = '6U: 10,5 colio (26,67 cm)';
    $Self->{Translation}->{'7U: 12.25 inches (31.12 cm)'} = '7U: 12,25 colio (31,12 cm)';
    $Self->{Translation}->{'8U: 14 inches (35.56 cm)'} = '8U: 14 colių (35,56 cm)';
    $Self->{Translation}->{'9U: 15.75 inches (40.01 cm)'} = '9U: 15,75 colio (40,01 cm)';
    $Self->{Translation}->{'AGPL (Affero General Public License)'} = '';
    $Self->{Translation}->{'Accounting'} = 'Apskaita';
    $Self->{Translation}->{'Accounting Information'} = '';
    $Self->{Translation}->{'Address Allocation'} = 'Adresų priskyrimas';
    $Self->{Translation}->{'Administrator'} = 'Administratorius';
    $Self->{Translation}->{'Analog Phone'} = 'Analoginis telefonas';
    $Self->{Translation}->{'Apache Lizenz'} = '';
    $Self->{Translation}->{'Appliance Type'} = 'Prietaiso tipas';
    $Self->{Translation}->{'BSD Lizenz (Berkeley Software Distribution License)'} = '';
    $Self->{Translation}->{'Battery Capacity (Ah)'} = 'Akumuliatoriaus talpa (Ah)';
    $Self->{Translation}->{'Battery Type'} = 'Akumuliatoriaus tipas';
    $Self->{Translation}->{'Building'} = 'Pastatas';
    $Self->{Translation}->{'Bus Interface'} = 'Magistralės sąsaja';
    $Self->{Translation}->{'CC0 (Creative Commons Zero)'} = '';
    $Self->{Translation}->{'CIDR'} = 'CIDR';
    $Self->{Translation}->{'CPU'} = 'CPU';
    $Self->{Translation}->{'CPU Class'} = 'CPU klasė';
    $Self->{Translation}->{'Capacity (GB)'} = 'Talpa (GB)';
    $Self->{Translation}->{'Capacity per graphics card'} = 'Vienos vaizdo plokštės talpa';
    $Self->{Translation}->{'Card Number'} = 'Kortelės numeris';
    $Self->{Translation}->{'Card Reader'} = 'Kortelių skaitytuvas';
    $Self->{Translation}->{'Card Type'} = 'Kortelės tipas';
    $Self->{Translation}->{'Client Certificates'} = 'Klientų sertifikatai';
    $Self->{Translation}->{'Client Software'} = 'Kliento programinė įranga';
    $Self->{Translation}->{'Client category'} = 'Kliento kategorija';
    $Self->{Translation}->{'Clockrate'} = 'Laikrodžio rodyklė';
    $Self->{Translation}->{'Clockspeed'} = 'Laikrodžių greitis';
    $Self->{Translation}->{'Code Signing Certificates'} = 'Kodo pasirašymo sertifikatai';
    $Self->{Translation}->{'Conference Phone'} = 'Konferencinis telefonas';
    $Self->{Translation}->{'Consulting Agreement'} = 'Konsultavimo sutartis';
    $Self->{Translation}->{'Contact'} = 'Susisiekite su';
    $Self->{Translation}->{'Contact Distributor'} = 'Susisiekite su platintoju';
    $Self->{Translation}->{'Container Management'} = 'Konteinerių valdymas';
    $Self->{Translation}->{'Contract'} = 'Sutartis';
    $Self->{Translation}->{'Contract Type'} = 'Sutarties tipas';
    $Self->{Translation}->{'Contract period from'} = 'Sutarties laikotarpis nuo';
    $Self->{Translation}->{'Contract period until'} = 'Sutarties laikotarpis iki';
    $Self->{Translation}->{'Cordless Phone (DECT Phone)'} = 'Belaidis telefonas (DECT telefonas)';
    $Self->{Translation}->{'Cost unit'} = 'Išlaidų vienetas';
    $Self->{Translation}->{'Count of licenses'} = 'Licencijų skaičius';
    $Self->{Translation}->{'Creation Date'} = 'Sukūrimo data';
    $Self->{Translation}->{'Creative Commons'} = '';
    $Self->{Translation}->{'Custom Rack'} = 'Pasirinktinis stovas';
    $Self->{Translation}->{'DHCP'} = 'DHCP';
    $Self->{Translation}->{'DHCP Reserved'} = 'DHCP rezervuota';
    $Self->{Translation}->{'DNS-Server'} = 'DNS serveris';
    $Self->{Translation}->{'DVI'} = 'DVI';
    $Self->{Translation}->{'Date of Invoice'} = 'Sąskaitos faktūros data';
    $Self->{Translation}->{'Date of Order'} = 'Užsakymo data';
    $Self->{Translation}->{'Date of Warranty'} = 'Garantijos išdavimo data';
    $Self->{Translation}->{'Date of release'} = 'Išleidimo data';
    $Self->{Translation}->{'Desktop'} = 'Stalinis kompiuteris';
    $Self->{Translation}->{'DisplayPort'} = 'DisplayPort';
    $Self->{Translation}->{'Document Signing Certificates'} = 'Dokumentų pasirašymo sertifikatai';
    $Self->{Translation}->{'EPL (Eclipse Public License)'} = '';
    $Self->{Translation}->{'ETSI Rack'} = 'ETSI stelažas';
    $Self->{Translation}->{'Email Certificates (S/MIME Certificates)'} = 'El. pašto sertifikatai (S/MIME sertifikatai)';
    $Self->{Translation}->{'Embedded SIM (eSIM)'} = '';
    $Self->{Translation}->{'Employment Contract'} = 'Darbo sutartis';
    $Self->{Translation}->{'End IP Address'} = 'Galinis IP adresas';
    $Self->{Translation}->{'End of support'} = 'Paramos pabaiga';
    $Self->{Translation}->{'Expiry Date'} = 'Galiojimo data';
    $Self->{Translation}->{'External Hard Drive'} = 'Išorinis kietasis diskas';
    $Self->{Translation}->{'Firewall'} = 'Ugniasienė';
    $Self->{Translation}->{'Firmware'} = 'Programinė įranga';
    $Self->{Translation}->{'Flywheel Energy Storage'} = 'Energijos kaupimas smagračiu';
    $Self->{Translation}->{'Form Factor'} = 'Formos faktorius';
    $Self->{Translation}->{'Franchise Agreement'} = 'Franšizės sutartis';
    $Self->{Translation}->{'Freeware'} = 'Nemokama programinė įranga';
    $Self->{Translation}->{'GPL (General Public License)'} = '';
    $Self->{Translation}->{'General Information'} = 'Bendra informacija';
    $Self->{Translation}->{'Graphics Cards'} = 'Vaizdo plokštės';
    $Self->{Translation}->{'Graphics card'} = 'Vaizdo plokštė';
    $Self->{Translation}->{'HDMI'} = 'HDMI';
    $Self->{Translation}->{'Hardware'} = 'Techninė įranga';
    $Self->{Translation}->{'Hardware Model'} = 'Techninės įrangos modelis';
    $Self->{Translation}->{'Hardware Weight'} = 'Techninės įrangos svoris';
    $Self->{Translation}->{'Headset'} = 'Ausinės';
    $Self->{Translation}->{'IP Protocol'} = 'IP protokolas';
    $Self->{Translation}->{'Identity and Access Management (IAM)'} = 'Tapatybės ir prieigos valdymas (IAM)';
    $Self->{Translation}->{'Inventory Number'} = 'Inventorinis numeris';
    $Self->{Translation}->{'Inverstment costs'} = 'Inverstravimo išlaidos';
    $Self->{Translation}->{'Invoice Number'} = 'Sąskaitos faktūros numeris';
    $Self->{Translation}->{'Keyboard'} = 'Klaviatūra';
    $Self->{Translation}->{'LCD Monitor (Liquid Crystal Display)'} = 'LCD monitorius (skystųjų kristalų ekranas)';
    $Self->{Translation}->{'LED Monitor (Light Emitting Diode)'} = 'LED monitorius (šviesos diodas)';
    $Self->{Translation}->{'LGPL (Lesser General Public License)'} = '';
    $Self->{Translation}->{'Landline Phone'} = 'Stacionarusis telefonas';
    $Self->{Translation}->{'Laptop'} = 'Nešiojamasis kompiuteris';
    $Self->{Translation}->{'Latitude'} = 'Platuma';
    $Self->{Translation}->{'Layer 1: Physical Layer'} = '1 sluoksnis: fizinis sluoksnis';
    $Self->{Translation}->{'Layer 2: Data Link Layer'} = '2 sluoksnis: duomenų ryšio sluoksnis';
    $Self->{Translation}->{'Layer 3: Network Layer'} = '3 sluoksnis: tinklo sluoksnis';
    $Self->{Translation}->{'Layer 3: Network Layer (Supernet)'} = '3 sluoksnis: tinklo sluoksnis (supernetas)';
    $Self->{Translation}->{'Layer 4: Transport Layer'} = '4 sluoksnis: transporto sluoksnis';
    $Self->{Translation}->{'Layer 5: Session Layer'} = '5 sluoksnis: sesijos sluoksnis';
    $Self->{Translation}->{'Layer 6: Presentation Layer'} = '6 sluoksnis: pateikimo sluoksnis';
    $Self->{Translation}->{'Layer 7: Application Layer'} = '7 sluoksnis: taikomųjų programų sluoksnis';
    $Self->{Translation}->{'Lease Agreement'} = 'Nuomos sutartis';
    $Self->{Translation}->{'License Agreement'} = 'Licencijos sutartis';
    $Self->{Translation}->{'License Count'} = '';
    $Self->{Translation}->{'License Key'} = 'Licencijos raktas';
    $Self->{Translation}->{'License Type'} = 'Licencijos tipas';
    $Self->{Translation}->{'License period from'} = 'Licencijos laikotarpis nuo';
    $Self->{Translation}->{'License period until'} = 'Licencijos laikotarpis iki';
    $Self->{Translation}->{'Lithium Iron Phosphate (LiFePO4) Battery'} = 'Ličio geležies fosfato (LiFePO4) akumuliatorius';
    $Self->{Translation}->{'Lithium-Ion (Li-ion) Battery'} = 'Ličio jonų (ličio jonų) akumuliatorius';
    $Self->{Translation}->{'Loan Agreement'} = 'Paskolos sutartis';
    $Self->{Translation}->{'Located in'} = 'Įsikūręs';
    $Self->{Translation}->{'Longitude'} = 'Ilguma';
    $Self->{Translation}->{'MIT Lizenz'} = '';
    $Self->{Translation}->{'MPL (Mozilla Public License)'} = '';
    $Self->{Translation}->{'Manufacturer'} = 'Gamintojas';
    $Self->{Translation}->{'Maximum Load Capacity (W)'} = 'Didžiausia apkrovos galia (W)';
    $Self->{Translation}->{'Memory'} = 'Atmintis';
    $Self->{Translation}->{'Memory Type'} = 'Atminties tipas';
    $Self->{Translation}->{'Micro SIM'} = '';
    $Self->{Translation}->{'Mini-Rack'} = 'Mini stelažas';
    $Self->{Translation}->{'Mobile Number'} = 'Mobiliojo telefono numeris';
    $Self->{Translation}->{'Mobile/Embedded'} = 'Mobilusis / įterptasis';
    $Self->{Translation}->{'Model'} = 'Modelis';
    $Self->{Translation}->{'Model Description'} = 'Modelis Aprašymas';
    $Self->{Translation}->{'Monitor Resolution'} = 'Monitoriaus skiriamoji geba';
    $Self->{Translation}->{'Monitor Size'} = 'Monitoriaus dydis';
    $Self->{Translation}->{'Mouse'} = 'Pelė';
    $Self->{Translation}->{'Nano SIM'} = '';
    $Self->{Translation}->{'Network'} = 'Tinklas';
    $Self->{Translation}->{'Network Info'} = 'Tinklo informacija';
    $Self->{Translation}->{'Network Information'} = 'Tinklo informacija';
    $Self->{Translation}->{'Network Layer'} = 'Tinklo lygmuo';
    $Self->{Translation}->{'Nickel-Cadmium (NiCd) Battery'} = 'Nikelio-kadmio (NiCd) akumuliatorius';
    $Self->{Translation}->{'Nickel-Metal Hydride (NiMH) Battery'} = 'Nikelio-metalo hidrido (NiMH) akumuliatorius';
    $Self->{Translation}->{'Non-Disclosure Agreement (NDA)'} = 'Susitarimas dėl informacijos neatskleidimo (NDA)';
    $Self->{Translation}->{'Notebook'} = 'Nešiojamasis kompiuteris';
    $Self->{Translation}->{'Number of CPUs'} = 'Procesorių skaičius';
    $Self->{Translation}->{'Number of RAM modules'} = 'Operatyviosios atminties modulių skaičius';
    $Self->{Translation}->{'Number of graphics cards'} = 'Vaizdo plokščių skaičius';
    $Self->{Translation}->{'OLED Monitor (Organic Light Emitting Diode)'} = 'OLED monitorius (organinis šviesos diodas)';
    $Self->{Translation}->{'Operating costs'} = 'Veiklos sąnaudos';
    $Self->{Translation}->{'Order Number'} = 'Užsakymo numeris';
    $Self->{Translation}->{'Other'} = 'Kita';
    $Self->{Translation}->{'Outputs'} = 'Išėjimai';
    $Self->{Translation}->{'PIN'} = 'PIN KODAS';
    $Self->{Translation}->{'PIN 2'} = 'PIN 2';
    $Self->{Translation}->{'PUK'} = 'PUK';
    $Self->{Translation}->{'PUK 2'} = 'PUK 2';
    $Self->{Translation}->{'Partnership Agreement'} = 'Partnerystės susitarimas';
    $Self->{Translation}->{'Perpetual licenses'} = '';
    $Self->{Translation}->{'Phone / VoIP'} = '';
    $Self->{Translation}->{'Phone Number'} = 'Telefono numeris';
    $Self->{Translation}->{'Phone Type'} = 'Telefono tipas';
    $Self->{Translation}->{'Physical Cores'} = 'Fiziniai branduoliai';
    $Self->{Translation}->{'Power Delivery'} = 'Maitinimo tiekimas';
    $Self->{Translation}->{'Public Domain'} = '';
    $Self->{Translation}->{'Purchased at'} = 'Įsigyta';
    $Self->{Translation}->{'Rack Depth'} = 'Stovo gylis';
    $Self->{Translation}->{'Rack Units (U)'} = 'Stovo vienetai (U)';
    $Self->{Translation}->{'Room'} = 'Kambarys';
    $Self->{Translation}->{'SIM Card'} = 'SIM kortelė';
    $Self->{Translation}->{'SSL/TLS Certificates'} = 'SSL/TLS sertifikatai';
    $Self->{Translation}->{'Sales Contract'} = 'Pardavimo sutartis';
    $Self->{Translation}->{'Satellite Phone'} = 'Palydovinis telefonas';
    $Self->{Translation}->{'Sealed Lead-Acid (SLA) Battery'} = 'Sandarus švino rūgštinis (SLA) akumuliatorius';
    $Self->{Translation}->{'Seat licenses'} = '';
    $Self->{Translation}->{'Serialnumber'} = 'Serijos numeris';
    $Self->{Translation}->{'Server Software'} = 'Serverio programinė įranga';
    $Self->{Translation}->{'Service Agreement'} = 'Paslaugų sutartis';
    $Self->{Translation}->{'Service Tag'} = 'Paslaugos žyma';
    $Self->{Translation}->{'Shareware'} = '';
    $Self->{Translation}->{'Socket Type'} = 'Lizdo tipas';
    $Self->{Translation}->{'Software'} = 'Programinė įranga';
    $Self->{Translation}->{'Speakers'} = 'Garsiakalbiai';
    $Self->{Translation}->{'Standard SIM'} = '';
    $Self->{Translation}->{'Start IP Address'} = 'Pradinis IP adresas';
    $Self->{Translation}->{'Storage'} = 'Saugykla';
    $Self->{Translation}->{'Storage Partition'} = 'Saugyklos skirsnis';
    $Self->{Translation}->{'Subscription-based licenses'} = '';
    $Self->{Translation}->{'Subsidiary'} = 'Dukterinė įmonė';
    $Self->{Translation}->{'Summary'} = 'Santrauka';
    $Self->{Translation}->{'Thin Client'} = 'Plonasis klientas';
    $Self->{Translation}->{'Threads'} = 'Siūlai';
    $Self->{Translation}->{'Thunderbolt'} = '"Thunderbolt"';
    $Self->{Translation}->{'Total Graphics card RAM (GB)'} = 'Iš viso grafinės plokštės operatyviosios atminties (GB)';
    $Self->{Translation}->{'Total RAM (GB)'} = 'Iš viso RAM (GB)';
    $Self->{Translation}->{'Touchscreen Monitor'} = 'Jutiklinio ekrano monitorius';
    $Self->{Translation}->{'Tower'} = 'Bokštas';
    $Self->{Translation}->{'USB Hub'} = 'USB šakotuvas';
    $Self->{Translation}->{'USB-C'} = 'USB-C';
    $Self->{Translation}->{'VGA'} = 'VGA';
    $Self->{Translation}->{'VPN'} = 'VPN';
    $Self->{Translation}->{'VR Headset'} = 'VR ausinės';
    $Self->{Translation}->{'Virtual Client'} = '';
    $Self->{Translation}->{'VirtualLink'} = 'VirtualLink';
    $Self->{Translation}->{'VoIP Phone'} = 'VoIP telefonas';
    $Self->{Translation}->{'Volume licenses'} = '';
    $Self->{Translation}->{'Webcam'} = 'Interneto kamera';


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

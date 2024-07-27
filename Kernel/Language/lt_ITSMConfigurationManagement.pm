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

package Kernel::Language::lt_ITSMConfigurationManagement;

use strict;
use warnings;
use utf8;

sub Data {
    my $Self = shift;

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

    # Perl Module: Kernel/Modules/AgentITSMConfigItemPrint.pm
    $Self->{Translation}->{'No ConfigItemID or VersionID is given!'} = 'Nenurodytas ConfigItemID arba VersionID!';
    $Self->{Translation}->{'Can\'t show config item, no access rights given!'} = 'Negalima parodyti konfigūracijos elemento, nes nesuteiktos prieigos teisės!';
    $Self->{Translation}->{'ConfigItemID %s not found in database!'} = 'Duomenų bazėje nerasta ConfigItemID %s!';
    $Self->{Translation}->{'ConfigItem'} = 'ConfigItem';
    $Self->{Translation}->{'printed by %s at %s'} = '%s spausdina %s adresu %s';

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
    $Self->{Translation}->{'Link type'} = 'Nuorodos tipas';
    $Self->{Translation}->{'Select the link type.'} = 'Pasirinkite nuorodos tipą.';
    $Self->{Translation}->{'Forwards: Referencing (Source) -> Referenced (Target)'} = 'Įžaidėjai: (Šaltinis) -> Nuoroda (Tikslas)';
    $Self->{Translation}->{'Backwards: Referenced (Source) -> Referencing (Target)'} = 'Atgal: (Šaltinis) -> Nuoroda (Tikslas)';
    $Self->{Translation}->{'Link Direction'} = 'Nuorodos kryptis';
    $Self->{Translation}->{'The referencing object is the one containing this dynamic field, the referenced object is the one selected as value of the dynamic field.'} =
        'Nuorodos objektas yra tas, kuriame yra šis dinaminis laukas, o nuorodos objektas yra tas, kuris pasirinktas kaip dinaminio lauko reikšmė.';
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
    $Self->{Translation}->{'Empty fields indicate that the current values are kept'} = 'Tušti laukai rodo, kad dabartinės reikšmės paliekamos.';
    $Self->{Translation}->{'Skipped'} = 'Praleistas';

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
    $Self->{Translation}->{'Allows extended search conditions in config item search of the agent interface. With this feature you can search e. g. config item name with this kind of conditions like "(*key1*&&*key2*)" or "(*key1*||*key2*)".'} =
        'Leidžia taikyti išplėstines paieškos sąlygas agento sąsajos konfigūracijos elementų paieškai. Naudodami šią funkciją galite ieškoti, pvz., konfigūracijos elemento pavadinimo su tokiomis sąlygomis, kaip "(*key1*&&*key2*)" arba "(*key1*||*key2*)".';
    $Self->{Translation}->{'Allows extended search conditions in config item search of the customer interface. With this feature you can search e. g. config item name with this kind of conditions like "(*key1*&&*key2*)" or "(*key1*||*key2*)".'} =
        'Leidžia taikyti išplėstines paieškos sąlygas klientų sąsajos konfigūracijos elementų paieškoje. Naudodami šią funkciją galite ieškoti, pvz., konfigūracijos elemento pavadinimo su tokiomis sąlygomis, kaip "(*key1*&&*key2*)" arba "(*key1*||*key2*)".';
    $Self->{Translation}->{'Assigned CIs'} = 'Priskirti KI';
    $Self->{Translation}->{'At a specific time point create a ticket for config items, if the configured requirements are met. The time point is determined by the value of the field configured under "TimeCIKey" of the ConfigItem, and modified by "TimeModifier". If the latter can be either just a number, or a sign (+/-), a number, and an unit (d/h/m): "7" is equivalent to "+7d". The DynamicField "Ticket->DynamicField" will be used to mark created tickets - it has to exist. The flags \<OTOBO_CONFIGITEM_X\> where X can be NAME, NUMBER and DATE, will be substituted with the respective values in "Ticket->Text".'} =
        'Tam tikru metu sukurkite bilietą dėl konfigūracijos elementų, jei įvykdyti nustatyti reikalavimai. Laiko momentas nustatomas pagal lauko, sukonfigūruoto ConfigItem "TimeCIKey", reikšmę ir modifikuojamas pagal "TimeModifier". Jei pastarasis gali būti tik skaičius arba ženklas (+/-), skaičius ir vienetas (d/h/m): "7" atitinka "+7d". Dinaminis laukas "Ticket->DynamicField" bus naudojamas sukurtiems bilietams žymėti - jis turi egzistuoti. Žymos \<OTOBO_CONFIGITEM_X\>, kur X gali būti NAME (pavadinimas), NUMBER (skaičius) ir DATE (data), bus pakeistos atitinkamomis reikšmėmis "Ticket->Text" (bilietas->tekstas).';
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
    $Self->{Translation}->{'Columns that can be filtered in the config item overview of the customer interface. Note: Only Config Item attributes and Dynamic Fields (DynamicField_NameX) are allowed.'} =
        'Stulpeliai, kuriuos galima filtruoti kliento sąsajos konfigūracijos elementų apžvalgoje. Pastaba: leidžiama naudoti tik konfigūracijos elemento atributus ir dinaminius laukus (DynamicField_NameX).';
    $Self->{Translation}->{'Columns that can be filtered in the config item search result overview of the agent interface. Note: Only Config Item attributes and Dynamic Fields (DynamicField_NameX) are allowed.'} =
        'Stulpeliai, kuriuos galima filtruoti agento sąsajos konfigūracijos elemento paieškos rezultatų apžvalgoje. Pastaba: Leidžiami tik konfigūracijos elemento atributai ir dinaminiai laukai (DynamicField_NameX).';
    $Self->{Translation}->{'Config Items'} = 'Konfigūracijos elementai';
    $Self->{Translation}->{'Config item add.'} = 'Konfigūracijos elemento pridėjimas.';
    $Self->{Translation}->{'Config item edit.'} = 'Konfigūracijos elemento redagavimas.';
    $Self->{Translation}->{'Config item event module that count the licenses for OTOBOCILicenseCount feature.'} =
        'Konfigūruoti elemento įvykių modulį, kuris skaičiuoja OTOBOCILicenseCount funkcijos licencijas.';
    $Self->{Translation}->{'Config item event module that enables logging to history in the agent interface.'} =
        'Konfigūruokite elemento įvykių modulį, kuris leidžia registruoti istoriją agento sąsajoje.';
    $Self->{Translation}->{'Config item event module that updates config items to their current definition.'} =
        'Konfigūracijos elementų įvykių modulis, kuris atnaujina konfigūracijos elementų dabartinę apibrėžtį.';
    $Self->{Translation}->{'Config item event module that updates the table configitem_ĺink.'} =
        'Konfigūracijos elemento įvykių modulis, kuris atnaujina lentelę configitem_ĺink.';
    $Self->{Translation}->{'Config item event module updates the current incident state.'} =
        'Konfigūracijos elemento įvykio modulis atnaujina esamą incidento būseną.';
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
    $Self->{Translation}->{'Defines Required permissions to create ITSM configuration items using the Generic Interface.'} =
        'Apibrėžiami reikalingi leidimai kurti ITSM konfigūracijos elementus naudojant bendrąją sąsają.';
    $Self->{Translation}->{'Defines Required permissions to delete ITSM configuration items using the Generic Interface.'} =
        'Apibrėžiami reikalingi leidimai ištrinti ITSM konfigūracijos elementus naudojant bendrąją sąsają.';
    $Self->{Translation}->{'Defines Required permissions to get ITSM configuration items using the Generic Interface.'} =
        'Apibrėžiami reikalingi leidimai gauti ITSM konfigūracijos elementus naudojant bendrąją sąsają.';
    $Self->{Translation}->{'Defines Required permissions to search ITSM configuration items using the Generic Interface.'} =
        'Apibrėžiami reikalingi leidimai ieškoti ITSM konfigūracijos elementų naudojant bendrąją sąsają.';
    $Self->{Translation}->{'Defines Required permissions to update ITSM configuration items using the Generic Interface.'} =
        'Apibrėžiami reikalingi leidimai atnaujinti ITSM konfigūracijos elementus naudojant bendrąją sąsają.';
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
    $Self->{Translation}->{'Enables/disables the functionality to check ITSM onfiguration items for unique names. Before enabling this option you should check your system for already existing config items with duplicate names. You can do this with the console command Admin::ITSM::Configitem::ListDuplicates.'} =
        'Įjungiama / išjungiama funkcija, skirta patikrinti ITSM konfigūracijos elementų unikalius pavadinimus. Prieš įjungdami šią parinktį, turėtumėte patikrinti, ar jūsų sistemoje nėra jau esamų konfigūracijos elementų su pasikartojančiais pavadinimais. Tai galite padaryti naudodami konsolės komandą Admin::ITSM::Configitem::ListDuplicates.';
    $Self->{Translation}->{'Event module to set configitem-status on ticket-configitem-link.'} =
        'Įvykių modulis, skirtas nustatyti "ticket-configitem-link" konfigūracijos elemento būseną.';
    $Self->{Translation}->{'Fields of the configuration item index, used for the fulltext search. Fields are also stored, but are not mandatory for the overall functionality. Inclusion of attachments can be disabled by setting the entry to 0 or deleting it.'} =
        'Konfigūracijos elemento indekso laukai, naudojami viso teksto paieškai. Laukai taip pat saugomi, tačiau nėra privalomi bendrai funkcijai. Priedų įtraukimą galima išjungti nustatant įrašo reikšmę 0 arba jį ištrinant.';
    $Self->{Translation}->{'Fields stored in the configuration item index which are used for other things besides fulltext searches. For the complete functionality all fields are mandatory.'} =
        'Konfigūracijos elemento indekse saugomi laukai, kurie naudojami ne tik viso teksto paieškai, bet ir kitiems dalykams. Kad funkcijos būtų pilnai išnaudotos, visi laukai yra privalomi.';
    $Self->{Translation}->{'For every webservice (key) an array of classes (value) can be defined on which the import is restricted. For all chosen classes, or all existing classes the identifying attributes will have to be chosen in the invoker config.'} =
        'Kiekvienai žiniatinklio paslaugai (raktas) galima apibrėžti klasių masyvą (reikšmė), kurio importas yra ribojamas. Visoms pasirinktoms klasėms arba visoms esamoms klasėms identifikuojantys atributai turės būti pasirinkti invokerio konfigūracijoje.';
    $Self->{Translation}->{'GenericInterface module registration for the ConfigItemFetch invoker layer.'} =
        '"GenericInterface" modulio registracija "ConfigItemFetch" iškvietėjo sluoksniui.';
    $Self->{Translation}->{'ITSM ConfigItem'} = 'ITSM ConfigItem';
    $Self->{Translation}->{'ITSM config item overview.'} = 'ITSM konfigūracijos elementų apžvalga.';
    $Self->{Translation}->{'If this option is activated, linked items are only counted if they belong to one of the listed classes.'} =
        'Jei ši parinktis įjungta, susieti elementai skaičiuojami tik tada, jei jie priklauso vienai iš išvardytų klasių.';
    $Self->{Translation}->{'InciState'} = 'InciState';
    $Self->{Translation}->{'IncidentState'} = 'IncidentState';
    $Self->{Translation}->{'Includes deployment states in the config item search of the customer interface.'} =
        'Įtraukti diegimo būsenas į konfigūracijos elementų paiešką kliento sąsajoje.';
    $Self->{Translation}->{'Includes incident states in the config item search of the customer interface.'} =
        'Įtraukti incidento būsenas į konfigūracijos elementų paiešką klientų sąsajoje.';
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
    $Self->{Translation}->{'Parameters for the dashboard backend of the customer company config item overview of the agent interface . "Limit" is the number of entries shown by default. "Group" is used to restrict the access to the plugin (e. g. Group: admin;group1;group2;). "Default" determines if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" is the cache time in minutes for the plugin.'} =
        'Kliento įmonės konfigūracijos elemento peržiūros agento sąsajos prietaisų skydelio backend parametrai . "Limit" (riba) - pagal numatytuosius nustatymus rodomų įrašų skaičius. "Group" (grupė) naudojama norint apriboti prieigą prie įskiepio (pvz., Group: admin;group1;group2;). "Default" (pagal numatytuosius nustatymus) nustato, ar įskiepis įjungtas pagal numatytuosius nustatymus, ar naudotojas turi jį įjungti rankiniu būdu. "CacheTTLLocal" (spartinančioji atmintinė) - įskiepio spartinančiosios atmintinės laikas minutėmis.';
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
    $Self->{Translation}->{'Whether the execution of ConfigItemACL can be avoided by checking cached field dependencies. This can improve loading times of formulars, but has to be disabled, if ACLModules are to be used for ITSMConfigItem- and Form-ReturnTypes.'} =
        'Ar galima išvengti "ConfigItemACL" vykdymo tikrinant talpykloje esančių laukų priklausomybes. Tai gali pagerinti formuliarų įkėlimo laiką, tačiau turi būti išjungta, jei ACLModules turi būti naudojami ITSMConfigItem- ir Form-ReturnTypes.';
    $Self->{Translation}->{'Which general information is shown in the header.'} = 'Kokia bendra informacija pateikiama antraštėje.';
    $Self->{Translation}->{'With this option it´s possible to fill automaticly a CI field, depending on the count of linked CI´s with the existing type DependsOn.'} =
        'Naudojant šią parinktį galima automatiškai užpildyti KI lauką, atsižvelgiant į susietų KI, turinčių esamą tipą DependsOn, skaičių.';
    $Self->{Translation}->{'With this option it´s possible to fill automaticly a CI field, depending on the count of linked CI´s.'} =
        'Naudojant šią parinktį galima automatiškai užpildyti CI lauką, atsižvelgiant į susietų CI skaičių.';
    $Self->{Translation}->{'With this option it´s possible to fill automaticly a CI field, depending on the count of linked CI´s. The setting CounterClassName include the name of the class and CounterFieldName is used to store the count of used licence.'} =
        'Naudojant šią parinktį galima automatiškai užpildyti CI lauką, atsižvelgiant į susietų CI skaičių. Nustatyme CounterClassName (Skaitiklio klasės pavadinimas) įrašomas klasės pavadinimas, o CounterFieldName (Skaitiklio lauko pavadinimas) naudojamas naudojamų licencijų skaičiui saugoti.';
    $Self->{Translation}->{'class'} = 'klasė';
    $Self->{Translation}->{'global'} = 'pasaulinis';
    $Self->{Translation}->{'postproductive'} = 'postprodukcinis';
    $Self->{Translation}->{'preproductive'} = 'priešprodukcinis';
    $Self->{Translation}->{'productive'} = 'produktyvus';


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

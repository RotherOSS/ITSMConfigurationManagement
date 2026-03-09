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

package Kernel::Language::sl_ITSMConfigurationManagement;

use strict;
use warnings;
use utf8;

sub Data {
    my $Self = shift;

    # Template: AdminGenericInterfaceOperationConfigItem
    $Self->{Translation}->{'General operation data'} = 'Splošni podatki o delovanju';
    $Self->{Translation}->{'Settings for incoming request data'} = 'Nastavitve za vhodne podatke zahtevka';
    $Self->{Translation}->{'Settings for outgoing response data'} = 'Nastavitve za izhodne odzivne podatke';

    # Template: AdminITSMConfigItem
    $Self->{Translation}->{'Config Item Management'} = 'Upravljanje elementov konfiguracije';
    $Self->{Translation}->{'Change class definition'} = 'Sprememba definicije razreda';
    $Self->{Translation}->{'Change role definition'} = 'Sprememba opredelitve vloge';
    $Self->{Translation}->{'Ready2Import Class Bundles'} = 'Paketi razredov Ready2Import';
    $Self->{Translation}->{'Here you can import Ready2Import class bundles showcasing our most usual config items. Please note that some additional configuration may be required.'} =
        'Tu lahko uvozite svežnje razredov Ready2Import, ki prikazujejo naše najbolj običajne elemente konfiguracije. Upoštevajte, da bo morda potrebna dodatna konfiguracija.';
    $Self->{Translation}->{'Update existing entities'} = 'Posodobitev obstoječih entitet';
    $Self->{Translation}->{'Import Ready2Adopt class bundles'} = 'Uvozite svežnje razredov Ready2Adopt';
    $Self->{Translation}->{'Config Item Class'} = 'Razred elementa konfiguracije';
    $Self->{Translation}->{'Config Item Role'} = 'Vloga elementa konfiguracije';

    # Template: AgentITSMConfigItemAdd
    $Self->{Translation}->{'Config Item'} = 'Element konfiguracije';
    $Self->{Translation}->{'Filter for Classes'} = 'Filter za razrede';
    $Self->{Translation}->{'Select a Class from the list to create a new Config Item.'} = 'Če želite ustvariti nov element konfiguracije, s seznama izberite razred.';
    $Self->{Translation}->{'Class'} = 'Razred';

    # Template: AgentITSMConfigItemBulk
    $Self->{Translation}->{'ITSM ConfigItem Bulk Action'} = 'Množično dejanje ITSM ConfigItem';
    $Self->{Translation}->{'Deployment state'} = 'Stanje namestitve';
    $Self->{Translation}->{'Incident state'} = 'Stanje incidenta';
    $Self->{Translation}->{'Link to another'} = 'Povezava na drugo';
    $Self->{Translation}->{'Invalid Configuration Item number!'} = 'Nepravilna številka elementa konfiguracije!';
    $Self->{Translation}->{'The number of another Configuration Item to link with.'} = 'Številka drugega elementa konfiguracije, s katerim se poveže.';

    # Template: AgentITSMConfigItemDelete
    $Self->{Translation}->{'Do you really want to delete this config item?'} = 'Ali res želite izbrisati ta element konfiguracije?';

    # Template: AgentITSMConfigItemEdit
    $Self->{Translation}->{'The name of this config item'} = 'Ime tega elementa konfiguracije';
    $Self->{Translation}->{'Name is already in use by the ConfigItems with the following Number(s): %s'} =
        'Ime je že v uporabi v ConfigItems z naslednjo(-imi) številko(-ami): %s';
    $Self->{Translation}->{'Version Number'} = 'Številka različice';
    $Self->{Translation}->{'Version number of this config item'} = 'Številka različice tega elementa konfiguracije';
    $Self->{Translation}->{'Version Number is already in use by the ConfigItems with the following Number(s): %s'} =
        'Številka različice je že v uporabi pri ConfigItems z naslednjo številko (številkami): %s';
    $Self->{Translation}->{'Deployment State'} = 'Stanje uvajanja';
    $Self->{Translation}->{'Incident State'} = 'Država incidenta';

    # Template: AgentITSMConfigItemHistory
    $Self->{Translation}->{'History of Config Item: %s'} = 'Zgodovina elementa konfiguracije: %s';
    $Self->{Translation}->{'History Content'} = 'Zgodovina Vsebina';
    $Self->{Translation}->{'Createtime'} = 'Createtime';
    $Self->{Translation}->{'Zoom view'} = 'Povečan pogled';

    # Template: AgentITSMConfigItemOverviewNavBar
    $Self->{Translation}->{'Config Items per page'} = 'Konfiguracija Elementi na stran';

    # Template: AgentITSMConfigItemOverviewSmall
    $Self->{Translation}->{'No config item data found.'} = 'Podatkov o elementu konfiguracije ni bilo mogoče najti.';
    $Self->{Translation}->{'Select this config item'} = 'Izberite ta element konfiguracije';

    # Template: AgentITSMConfigItemSearch
    $Self->{Translation}->{'Run Search'} = 'Zagnati iskanje';
    $Self->{Translation}->{'Also search in previous versions?'} = 'Iskanje tudi v prejšnjih različicah?';

    # Template: AgentITSMConfigItemTreeView
    $Self->{Translation}->{'TreeView for ConfigItem'} = 'Drevesni pogled za ConfigItem';
    $Self->{Translation}->{'Depth Level'} = 'Raven globine';
    $Self->{Translation}->{'Zoom In/Out'} = 'Povečanje/izklop';
    $Self->{Translation}->{'Max links level reached for ConfigItem!'} = 'Dosežena največja raven povezav za ConfigItem!';

    # Template: AgentITSMConfigItemZoom
    $Self->{Translation}->{'Configuration Item'} = 'Element konfiguracije';
    $Self->{Translation}->{'Configuration Item Information'} = 'Informacije o postavki konfiguracije';
    $Self->{Translation}->{'Current Deployment State'} = 'Trenutno stanje uvajanja';
    $Self->{Translation}->{'Current Incident State'} = 'Trenutno stanje incidenta';
    $Self->{Translation}->{'Last changed'} = 'Zadnja sprememba';
    $Self->{Translation}->{'Last changed by'} = 'Nazadnje spremenil';

    # Template: CustomerITSMConfigItem
    $Self->{Translation}->{'Your ConfigItems'} = 'Vaši elementi ConfigItems';

    # Template: CustomerITSMConfigItemSearch
    $Self->{Translation}->{'ConfigItem Search'} = 'ConfigItem Iskanje';

    # Template: AdminACL
    $Self->{Translation}->{'Object Type'} = 'Vrsta predmeta';

    # Template: AdminDynamicFieldScreen
    $Self->{Translation}->{'Filter by object type'} = '';

    # JS Template: ClassImportConfirm
    $Self->{Translation}->{'The following classes will be imported'} = 'Uvoženi bodo naslednji razredi';
    $Self->{Translation}->{'The following roles will be imported'} = 'Uvožene bodo naslednje vloge';
    $Self->{Translation}->{'Note that also corresponding dynamic fields and GeneralCatalog classes will be created and there is no automatic removal.'} =
        'Upoštevajte, da bodo ustvarjena tudi ustrezna dinamična polja in razredi GeneralCatalog, ki ne bodo samodejno odstranjeni.';
    $Self->{Translation}->{'Do you want to proceed?'} = 'Ali želite nadaljevati?';

    # Perl Module: Kernel/Modules/AdminITSMConfigItem.pm
    $Self->{Translation}->{'Need ExampleClasses!'} = 'Potrebujete razrede primerov!';
    $Self->{Translation}->{'Definition is no valid YAML hash.'} = 'Definicija ni veljavni hash YAML.';

    # Perl Module: Kernel/Modules/AgentITSMConfigItem.pm
    $Self->{Translation}->{'Overview: ITSM ConfigItem'} = 'Pregled: ITSM ConfigItem';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemBulk.pm
    $Self->{Translation}->{'No ConfigItemID is given!'} = 'ConfigItemID ni podan!';
    $Self->{Translation}->{'You need at least one selected Configuration Item!'} = 'Potrebujete vsaj en izbrani element konfiguracije!';
    $Self->{Translation}->{'You don\'t have write access to this configuration item: %s.'} =
        'Nimate dostopa za pisanje v to konfiguracijsko postavko: %s.';
    $Self->{Translation}->{'No definition was defined for class %s!'} = 'Za razred %s ni bila opredeljena nobena definicija!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemDelete.pm
    $Self->{Translation}->{'Config item "%s" not found in database!'} = 'Konfiguracijskega elementa "%s" ni mogoče najti v zbirki podatkov!';
    $Self->{Translation}->{'Was not able to delete the configitem ID %s!'} = 'Ni bilo mogoče izbrisati konfiguracijskega elementa ID %s!';
    $Self->{Translation}->{'No version found for ConfigItemID %s!'} = 'Za ConfigItemID %s ni bila najdena nobena različica!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemEdit.pm
    $Self->{Translation}->{'No ConfigItemID, DuplicateID or ClassID is given!'} = 'Ni podan ConfigItemID, DuplicateID ali ClassID!';
    $Self->{Translation}->{'No access is given!'} = 'Dostop ni omogočen!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemHistory.pm
    $Self->{Translation}->{'Can\'t show history, no ConfigItemID is given!'} = 'Ne morem prikazati zgodovine, ker ni podan ConfigItemID!';
    $Self->{Translation}->{'Can\'t show history, no access rights given!'} = 'Ne morem prikazati zgodovine, ni podanih pravic dostopa!';
    $Self->{Translation}->{'New ConfigItem (ID=%s)'} = 'Nov element konfiguracije (ID=%s)';
    $Self->{Translation}->{'New version (ID=%s)'} = 'Nova različica (ID=%s)';
    $Self->{Translation}->{'Deployment state updated (new=%s, old=%s)'} = 'Posodobljeno stanje namestitve (novo=%s, staro=%s)';
    $Self->{Translation}->{'Incident state updated (new=%s, old=%s)'} = 'Posodobljeno stanje incidenta (novo=%s, staro=%s)';
    $Self->{Translation}->{'ConfigItem (ID=%s) deleted'} = 'ConfigItem (ID=%s) izbrisan';
    $Self->{Translation}->{'Link to %s (type=%s) added'} = 'Dodana povezava na %s (type=%s)';
    $Self->{Translation}->{'Link to %s (type=%s) deleted'} = 'Povezava na %s (tip=%s) izbrisana';
    $Self->{Translation}->{'ConfigItem definition updated (ID=%s)'} = 'Opredelitev elementa ConfigItem je posodobljena (ID=%s)';
    $Self->{Translation}->{'Name updated (new=%s, old=%s)'} = 'Ime posodobljeno (novo=%s, staro=%s)';
    $Self->{Translation}->{'Attribute %s updated from "%s" to "%s"'} = 'Atribut %s posodobljen iz "%s" v "%s"';
    $Self->{Translation}->{'Version %s deleted'} = 'Različica %s izbrisana';
    $Self->{Translation}->{'File "%s" uploaded'} = '';
    $Self->{Translation}->{'File "%s" removed'} = '';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemPrint.pm
    $Self->{Translation}->{'No ConfigItemID or VersionID is given!'} = 'Ni podan ConfigItemID ali VersionID!';
    $Self->{Translation}->{'Can\'t show config item, no access rights given!'} = 'Ni mogoče prikazati elementa konfiguracije, ni podanih pravic dostopa!';
    $Self->{Translation}->{'ConfigItemID %s not found in database!'} = 'ConfigItemID %s ni najden v podatkovni bazi!';
    $Self->{Translation}->{'ConfigItem'} = 'ConfigItem';
    $Self->{Translation}->{'printed by %s at %s'} = 'natisnil %s na %s';
    $Self->{Translation}->{'Referenced by'} = '';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemSearch.pm
    $Self->{Translation}->{'Invalid ClassID!'} = 'Nepravilen ID razreda!';
    $Self->{Translation}->{'No ClassID is given!'} = 'ID razreda ni naveden!';
    $Self->{Translation}->{'No access rights for this class given!'} = 'Pravice dostopa za ta razred niso podane!';
    $Self->{Translation}->{'No Result!'} = 'Brez rezultata!';
    $Self->{Translation}->{'Config Item Search Results'} = 'Rezultati iskanja elementa konfiguracije';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemZoom.pm
    $Self->{Translation}->{'Can\'t show item, no access rights for ConfigItem are given!'} =
        'Elementa ni mogoče prikazati, pravice dostopa za ConfigItem niso podane!';
    $Self->{Translation}->{'ConfigItem not found!'} = 'ConfigItem ni najden!';
    $Self->{Translation}->{'No versions found!'} = 'Ni bilo najdenih različic!';
    $Self->{Translation}->{'operational'} = 'delovanje';
    $Self->{Translation}->{'warning'} = 'opozorilo';
    $Self->{Translation}->{'incident'} = 'incident';
    $Self->{Translation}->{'The deployment state of this config item'} = 'Stanje uvajanja tega elementa konfiguracije';
    $Self->{Translation}->{'The incident state of this config item'} = 'Stanje incidenta tega elementa konfiguracije';

    # Perl Module: Kernel/Modules/CustomerITSMConfigItemSearch.pm
    $Self->{Translation}->{'No permission'} = 'Brez dovoljenja';
    $Self->{Translation}->{'Filter invalid!'} = 'Filter je neveljaven!';
    $Self->{Translation}->{'Search params invalid!'} = 'Neveljavni parami iskanja!';

    # Perl Module: Kernel/Output/HTML/Dashboard/ITSMConfigItemGeneric.pm
    $Self->{Translation}->{'Shown config items'} = 'Prikazani elementi konfiguracije';
    $Self->{Translation}->{'Deployment State Type'} = 'Vrsta stanja namestitve';
    $Self->{Translation}->{'Current Incident State Type'} = 'Vrsta trenutnega stanja incidenta';

    # Perl Module: Kernel/Output/HTML/ITSMConfigItem/LayoutDate.pm
    $Self->{Translation}->{'Between'} = 'Med';

    # Perl Module: Kernel/System/DynamicField/Driver/ConfigItem.pm
    $Self->{Translation}->{'Class restrictions for the config item'} = 'Omejitve razreda za element konfiguracije';
    $Self->{Translation}->{'Select one or more classes to restrict selectable config items'} =
        'Izberite enega ali več razredov za omejitev izbirnih elementov konfiguracije';
    $Self->{Translation}->{'Deployment state restrictions for the config item'} = '';
    $Self->{Translation}->{'Select one or more deployment states to restrict selectable config items'} =
        '';
    $Self->{Translation}->{'Dynamic (ConfigItem)'} = 'Dinamično (ConfigItem)';
    $Self->{Translation}->{'Static (Version)'} = 'Statično (različica)';
    $Self->{Translation}->{'Link Referencing Type'} = 'Vrsta sklicevanja na povezavo';
    $Self->{Translation}->{'Whether this link applies to the ConfigItem or the static version of the referencing object. Current Incident State calculation only is performed on dynamic links.'} =
        'Ali ta povezava velja za ConfigItem ali statično različico objekta, na katerega se sklicuje. Izračun trenutnega stanja incidenta se izvede samo pri dinamičnih povezavah.';
    $Self->{Translation}->{'Select the attribute which config items will be searched by'} = 'Izberite atribut, po katerem se bodo iskali elementi konfiguracije';

    # Perl Module: Kernel/System/ITSMConfigItem/Definition.pm
    $Self->{Translation}->{'Base structure is not valid. Please provide a hash with data in YAML format.'} =
        'Osnovna struktura ni veljavna. Navedite hash s podatki v obliki YAML.';
    $Self->{Translation}->{'Starting the YAML string with \'---\' is required.'} = 'Niz YAML se mora začeti z \'---\'.';

    # Perl Module: Kernel/System/ITSMConfigItem/Link.pm
    $Self->{Translation}->{'Could not purge the table configitem_link.'} = 'Tabele configitem_link ni bilo mogoče očistiti.';
    $Self->{Translation}->{'No relevant dynamic fields were found'} = 'Ustrezna dinamična polja niso bila najdena.';
    $Self->{Translation}->{'Could not insert into the table configitem_link'} = 'Ni bilo mogoče vstaviti v tabelo configitem_link';
    $Self->{Translation}->{'Inserted 0 rows into the table configitem_link'} = 'Vstavljenih 0 vrstic v tabelo configitem_link';

    # Perl Module: Kernel/System/ImportExport/ObjectBackend/ITSMConfigItem.pm
    $Self->{Translation}->{'Maximum number of one element'} = 'Največje število enega elementa';
    $Self->{Translation}->{'Maximum number of one Set dynamic field element'} = '';
    $Self->{Translation}->{'Maximum number of one element within a Set dynamic field element'} =
        '';
    $Self->{Translation}->{'Import/Export attachments (as the last entries per line)'} = 'Uvoz/izvoz priponk (kot zadnji vnosi v vrstici)';
    $Self->{Translation}->{'Version String'} = 'Verzija String';

    # Perl Module: Kernel/Modules/AdminDynamicField.pm
    $Self->{Translation}->{'Error synchronizing the definitions. Please check the log.'} = 'Napaka pri sinhronizaciji definicij. Preverite dnevnik.';
    $Self->{Translation}->{'You have ITSMConfigItem definitions which are not synchronized. Please deploy your ITSMConfigItem dynamic field changes.'} =
        'Imate definicije ITSMConfigItem, ki niso sinhronizirane. Umeščajte spremembe dinamičnih polj ITSMConfigItem.';

    # Database XML / SOPM Definition: ITSMConfigurationManagement.sopm
    $Self->{Translation}->{'Expired'} = 'Pretekla veljavnost';
    $Self->{Translation}->{'Maintenance'} = 'Vzdrževanje';
    $Self->{Translation}->{'Pilot'} = 'Pilot';
    $Self->{Translation}->{'Planned'} = 'Načrtovano';
    $Self->{Translation}->{'Repair'} = 'Popravila';
    $Self->{Translation}->{'Retired'} = 'Upokojeni';
    $Self->{Translation}->{'Review'} = 'Pregled';
    $Self->{Translation}->{'Test/QA'} = 'Testiranje/QA';

    # JS File: ITSM.Admin.ITSMConfigItem
    $Self->{Translation}->{'Overview and Confirmation'} = 'Pregled in potrditev';
    $Self->{Translation}->{'Importing classes/roles and their related fields'} = 'Uvoz razredov/vlog in z njimi povezanih polj';
    $Self->{Translation}->{'An error occurred during class import.'} = 'Pri uvozu razreda je prišlo do napake.';

    # SysConfig
    $Self->{Translation}->{'0 - Hidden'} = '0 - Skrito';
    $Self->{Translation}->{'1 - Shown'} = '1 - prikazano';
    $Self->{Translation}->{'A mapping of inner field names used in the Process Management TransitionActions ConfigItemAdd and -Update. The keys are the names of the set inner fields of the set with object type ticket which will be used to create/update the CI, and the values are the names of the inner fields of the set with object type ITSMConfigItem.'} =
        '';
    $Self->{Translation}->{'Allows extended search conditions in config item search of the agent interface. With this feature you can search e. g. config item name with this kind of conditions like "(*key1*&&*key2*)" or "(*key1*||*key2*)".'} =
        'Omogoča razširjene pogoje iskanja pri iskanju elementov konfiguracije v vmesniku agenta. S to funkcijo lahko iščete npr. ime elementa konfiguracije s takšnimi pogoji, kot so "(*key1*&&*key2*)" ali "(*key1*||*key2*)".';
    $Self->{Translation}->{'Allows extended search conditions in config item search of the customer interface. With this feature you can search e. g. config item name with this kind of conditions like "(*key1*&&*key2*)" or "(*key1*||*key2*)".'} =
        'Omogoča razširjene pogoje iskanja v iskanju elementov konfiguracije v vmesniku za stranke. S to funkcijo lahko iščete npr. ime elementa konfiguracije s takšnimi pogoji, kot so "(*key1*&&*key2*)" ali "(*key1*||*key2*)".';
    $Self->{Translation}->{'Assigned CIs'} = 'Dodeljeni KI';
    $Self->{Translation}->{'At a specific time point create a ticket for config items, if the configured requirements are met. The time point is determined by the value of the dynamic field of type date configured under "TimeCIKey" of the ConfigItem, and modified by "TimeModifier". If the latter can be either just a number, or a sign (+/-), a number, and an unit (d/h/m): "7" is equivalent to "+7d". The DynamicField "Ticket->DynamicField" will be used to mark created tickets - it has to exist. The flags \<OTOBO_CONFIGITEM_X\> where X can be NAME, NUMBER and DATE, will be substituted with the respective values in "Ticket->Text".'} =
        '';
    $Self->{Translation}->{'Attributes for license accounting.'} = '';
    $Self->{Translation}->{'Attributes for licenses counting, where "TotalLicensesDF", "AvailableLicensesDF" and "LicenseReferenceDF" are the names of the dynamic fields used to track the remaining licenses. If used, only deployment states in "ValidDeplStates" are considered. If a threshold is defined in "MinimumLicenses", a ticket will automatically be created if less licenses are available. For this, the checkbox dynamic field "Ticket->DynamicField" must exist. The tags \<OTOBO_CONFIGITEM_X\> where X can be NAME, NUMBER, LICENSES_AVAIL and LICENSES_MIN, will be substituted with the respective values in "Ticket->Text" by the config item name, number, available licenses, and minimum required available licenses, respectively.'} =
        '';
    $Self->{Translation}->{'CIs assigned to customer company'} = 'KI, dodeljeni podjetju stranke';
    $Self->{Translation}->{'CIs assigned to customer user'} = 'CI, dodeljeni uporabniku stranke';
    $Self->{Translation}->{'CMDB Settings'} = 'Nastavitve CMDB';
    $Self->{Translation}->{'Check for a unique name only within the same ConfigItem class (\'class\') or globally (\'global\'), which means every existing ConfigItem is taken into account when looking for duplicates.'} =
        'Preverjanje edinstvenega imena samo znotraj istega razreda ConfigItem (\'class\') ali globalno (\'global\'), kar pomeni, da se pri iskanju podvojitev upošteva vsak obstoječi ConfigItem.';
    $Self->{Translation}->{'Choose a module to enforce a naming scheme.'} = 'Izberite modul za uveljavitev sheme poimenovanja.';
    $Self->{Translation}->{'Choose a module to enforce a number scheme.'} = 'Izberite modul za uveljavitev številske sheme.';
    $Self->{Translation}->{'Choose a module to enforce a version string scheme.'} = 'Izberite modul za uveljavitev sheme verižnih nizov različic.';
    $Self->{Translation}->{'Choose attributes to trigger the creation of a new version.'} = 'Izberite atribute za sprožitev ustvarjanja nove različice.';
    $Self->{Translation}->{'Choose categories to assign to this config item class.'} = 'Izberite kategorije, ki jih želite dodeliti temu razredu elementov konfiguracije.';
    $Self->{Translation}->{'Column config item filters for ConfigItem Overview.'} = 'Filtri elementa konfiguracije stolpca za pregled elementa konfiguracije.';
    $Self->{Translation}->{'Columns that can be filtered in the config item overview of the agent interface. Note: Only Config Item attributes and Dynamic Fields (DynamicField_NameX) are allowed.'} =
        'Stolpci, ki jih je mogoče filtrirati v pregledu elementov konfiguracije v vmesniku agenta. Opomba: Dovoljeni so samo atributi elementa konfiguracije in dinamična polja (DynamicField_NameX).';
    $Self->{Translation}->{'Config Items'} = 'Elementi konfiguracije';
    $Self->{Translation}->{'Config item add.'} = 'Dodajanje elementa konfiguracije.';
    $Self->{Translation}->{'Config item edit.'} = 'Urejanje elementa konfiguracije.';
    $Self->{Translation}->{'Config item event module that enables accounting licenses for a given config item.'} =
        '';
    $Self->{Translation}->{'Config item event module that enables logging to history in the agent interface.'} =
        'Modul za dogodke elementa konfiguracije, ki omogoča beleženje v zgodovino v vmesniku agenta.';
    $Self->{Translation}->{'Config item event module that updates config items to their current definition.'} =
        'Modul dogodkov za elemente konfiguracije, ki posodobi elemente konfiguracije na njihovo trenutno definicijo.';
    $Self->{Translation}->{'Config item history.'} = 'Zgodovina elementov konfiguracije.';
    $Self->{Translation}->{'Config item print.'} = 'Tiskanje elementa konfiguracije.';
    $Self->{Translation}->{'Config item zoom.'} = 'Konfiguracija povečave elementa.';
    $Self->{Translation}->{'ConfigItem Tree View'} = 'Drevesni prikaz elementov konfiguracije';
    $Self->{Translation}->{'ConfigItem Version'} = 'ConfigItem Različica';
    $Self->{Translation}->{'ConfigItems of the following classes will not be stored on the Elasticsearch server. To apply this to existing CIs, the CI migration has to be run via console, after changing this option.'} =
        'Konfiguracijski elementi naslednjih razredov ne bodo shranjeni v strežniku Elasticsearch. Če želite to uporabiti za obstoječe CI, je treba po spremembi te možnosti zagnati migracijo CI prek konzole.';
    $Self->{Translation}->{'ConfigItems with the following deployment states will not be stored on the Elasticsearch server. To apply this to existing CIs, the CI migration has to be run via console, after changing this option.'} =
        'Konfiguracijski elementi z naslednjimi stanji namestitve ne bodo shranjeni v strežniku Elasticsearch. Če želite to uporabiti za obstoječe CI, je treba po spremembi te možnosti zagnati migracijo CI prek konzole.';
    $Self->{Translation}->{'Configuration Item Limit'} = 'Omejitev postavke konfiguracije';
    $Self->{Translation}->{'Configuration Item limit per page.'} = 'Konfiguracija Omejitev elementov na stran.';
    $Self->{Translation}->{'Configuration Management Database.'} = 'Podatkovna zbirka za upravljanje konfiguracije.';
    $Self->{Translation}->{'Configuration item bulk module.'} = 'Postavka za konfiguracijo modula v razsutem stanju.';
    $Self->{Translation}->{'Configuration item search backend router of the agent interface.'} =
        'Element konfiguracije za iskanje zalednega usmerjevalnika vmesnika agenta.';
    $Self->{Translation}->{'Configure the columns which are available for viewing Permission Conditions in the customer interface, when the corresponding Permission Condition Columns are not specifically configured. This setting is used as a fallback for the other Permission Condition Columns settings.'} =
        '';
    $Self->{Translation}->{'Configure the columns which are available when viewing the corresponding Permission Condition in the customer interface.'} =
        '';
    $Self->{Translation}->{'Create and manage the definitions for Configuration Items.'} = 'Ustvarjanje in upravljanje definicij za elemente konfiguracije.';
    $Self->{Translation}->{'Creates Tickets for ConfigItems at specific time points.'} = 'Ustvari vozovnice za elemente ConfigItems v določenih časovnih točkah.';
    $Self->{Translation}->{'Customers can see historic CI versions.'} = 'Stranke si lahko ogledajo pretekle različice CI.';
    $Self->{Translation}->{'Customers have the possibility to manually switch between historic CI versions.'} =
        'Stranke lahko ročno preklapljajo med preteklimi različicami CI.';
    $Self->{Translation}->{'Default data to use on attribute for config item search screen. Example: "ITSMConfigItemCreateTimePointFormat=year;ITSMConfigItemCreateTimePointStart=Last;ITSMConfigItemCreateTimePoint=2;".'} =
        'Privzete podatke, ki se uporabijo v atributu za zaslon za iskanje elementov konfiguracije. Primer: "ITSMConfigItemCreateTimePointFormat=leto;ITSMConfigItemCreateTimePointStart=Last;ITSMConfigItemCreateTimePoint=2;".';
    $Self->{Translation}->{'Default data to use on attribute for config item search screen. Example: "ITSMConfigItemCreateTimeStartYear=2010;ITSMConfigItemCreateTimeStartMonth=10;ITSMConfigItemCreateTimeStartDay=4;ITSMConfigItemCreateTimeStopYear=2010;ITSMConfigItemCreateTimeStopMonth=11;ITSMConfigItemCreateTimeStopDay=3;".'} =
        'Privzete podatke, ki se uporabijo v atributu za zaslon za iskanje elementov konfiguracije. Primer: "ITSMConfigItemCreateTimeStartYear=2010;ITSMConfigItemCreateTimeStartMonth=10;ITSMConfigItemCreateTimeStartDay=4;ITSMConfigItemCreateTimeStopYear=2010;ITSMConfigItemCreateTimeStopMonth=11;ITSMConfigItemCreateTimeStopDay=3;".';
    $Self->{Translation}->{'Define Actions where a settings button is available in the linked objects widget (LinkObject::ViewMode = "complex"). Please note that these Actions must have registered the following JS and CSS files: Core.AllocationList.css, Core.UI.AllocationList.js, Core.UI.Table.Sort.js, Core.Agent.TableFilters.js and Core.Agent.LinkObject.js.'} =
        'Opredelite dejanja, pri katerih je v gradniku povezanih predmetov na voljo gumb za nastavitve (LinkObject::ViewMode = "complex"). Upoštevajte, da morajo te akcije registrirati naslednje datoteke JS in CSS: V tem primeru je treba za uporabo nastavitev in funkcij za povezovanje objektov in njihovih funkcij v sistemu nastaviti naslednje datoteke: Core.AllocationList.css, Core.UI.AllocationList.js, Core.UI.Table.Sort.js, Core.Agent.TableFilters.js in Core.Agent.LinkObject.js.';
    $Self->{Translation}->{'Define a Template::Toolkit scheme for version strings. Only used if Version String Module is set to TemplateToolkit.'} =
        'Opredelitev sheme Template::Toolkit za niza različic. Uporablja se samo, če je modul Version String Module nastavljen na TemplateToolkit.';
    $Self->{Translation}->{'Define a set of conditions under which a customer is allowed to see a config item. Conditions can optionally be restricted to certain customer groups. Name is the only mandatory attribute. If no other options are given, all config items will be visible under that category.'} =
        'Opredelite niz pogojev, pod katerimi lahko stranka vidi element konfiguracije. Pogoji so lahko po želji omejeni na določene skupine strank. Ime je edini obvezni atribut. Če ne navedete drugih možnosti, bodo v tej kategoriji vidni vsi elementi konfiguracije.';
    $Self->{Translation}->{'Defines Required permissions to delete ITSM configuration items using the Generic Interface.'} =
        'Opredeljuje Zahtevana dovoljenja za brisanje elementov konfiguracije ITSM z uporabo splošnega vmesnika.';
    $Self->{Translation}->{'Defines Required permissions to get ITSM configuration items using the Generic Interface.'} =
        'Opredeljuje Zahtevana dovoljenja za pridobitev elementov konfiguracije ITSM z uporabo splošnega vmesnika.';
    $Self->{Translation}->{'Defines Required permissions to search ITSM configuration items using the Generic Interface.'} =
        'Opredeljuje Zahtevana dovoljenja za iskanje elementov konfiguracije ITSM z uporabo splošnega vmesnika.';
    $Self->{Translation}->{'Defines Required permissions to set ITSM configuration items using the Generic Interface.'} =
        'Opredeljuje Zahtevana dovoljenja za nastavljanje elementov konfiguracije ITSM z uporabo splošnega vmesnika.';
    $Self->{Translation}->{'Defines an overview module to show the small view of a configuration item list.'} =
        'Opredeljuje modul za pregled, ki prikazuje majhen pogled seznama elementov konfiguracije.';
    $Self->{Translation}->{'Defines if the link type labels must be shown in the node connections.'} =
        'Določa, ali morajo biti v povezavah vozlišč prikazane oznake vrste povezave.';
    $Self->{Translation}->{'Defines regular expressions individually for each ConfigItem class to check the ConfigItem name and to show corresponding error messages.'} =
        'Za vsak razred ConfigItem posebej določa regularne izraze za preverjanje imena ConfigItem in prikaz ustreznih sporočil o napakah.';
    $Self->{Translation}->{'Defines the available columns of CIs in the config item overview depending on the CI class. Each entry must consist of a class name and an array of available fields for the corresponding class. Dynamic field entries have to honor the scheme DynamicField_FieldName.'} =
        'Opredeljuje razpoložljive stolpce CI v pregledu elementa konfiguracije glede na razred CI. Vsak vnos mora biti sestavljen iz imena razreda in polja razpoložljivih polj za ustrezni razred. Vnosi dinamičnih polj morajo upoštevati shemo DynamicField_FieldName.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of the agent interface.'} =
        'Določa privzeti atribut elementa konfiguracije za razvrščanje elementov konfiguracije v rezultatu iskanja elementov konfiguracije v vmesniku agenta.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of the customer interface.'} =
        'Določa privzeti atribut elementa konfiguracije za razvrščanje elementov konfiguracije v rezultatu iskanja elementov konfiguracije v vmesniku za stranke.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of this operation.'} =
        'Določa privzeti atribut elementa konfiguracije za razvrščanje elementa konfiguracije v rezultat iskanja elementa konfiguracije te operacije.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the agent interface. Up: oldest on top. Down: latest on top.'} =
        'Določa privzeti vrstni red elementov konfiguracije v rezultatu iskanja elementov konfiguracije v vmesniku agenta. Navzgor: najstarejši na vrhu. Navzdol: najnovejši na vrhu.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the customer interface. Up: oldest on top. Down: latest on top.'} =
        'Določa privzeti vrstni red elementov konfiguracije v rezultatu iskanja elementov konfiguracije v vmesniku za stranke. Navzgor: najstarejši na vrhu. Navzdol: najnovejši na vrhu.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the this operation. Up: oldest on top. Down: latest on top.'} =
        'Določa privzeti vrstni red elementov konfiguracije v rezultatu iskanja elementov konfiguracije te operacije. Navzgor: najstarejši na vrhu. Navzdol: najnovejši na vrhu.';
    $Self->{Translation}->{'Defines the default displayed columns of CIs in the config item overview depending on the CI class. Each entry must consist of a class name and an array of available fields for the corresponding class. Dynamic field entries have to honor the scheme DynamicField_FieldName.'} =
        'Določa privzete prikazane stolpce CI v pregledu elementa konfiguracije glede na razred CI. Vsak vnos mora biti sestavljen iz imena razreda in polja razpoložljivih polj za ustrezni razred. Vnosi dinamičnih polj morajo upoštevati shemo DynamicField_FieldName.';
    $Self->{Translation}->{'Defines the default relations depth to be shown.'} = 'Določa privzeto globino odnosov, ki se prikažejo.';
    $Self->{Translation}->{'Defines the default shown config item search attribute for config item search screen.'} =
        'Določa privzeto prikazan atribut iskanja elementa konfiguracije za zaslon iskanja elementa konfiguracije.';
    $Self->{Translation}->{'Defines the default shown config item search attribute for config item search screen. Example: "Key" must have the name of the Dynamic Field in this case \'X\', "Content" must have the value of the Dynamic Field depending on the Dynamic Field type,  Text: \'a text\', Dropdown: \'1\', Date/Time: \'Search_DynamicField_XTimeSlotStartYear=1974; Search_DynamicField_XTimeSlotStartMonth=01; Search_DynamicField_XTimeSlotStartDay=26; Search_DynamicField_XTimeSlotStartHour=00; Search_DynamicField_XTimeSlotStartMinute=00; Search_DynamicField_XTimeSlotStartSecond=00; Search_DynamicField_XTimeSlotStopYear=2013; Search_DynamicField_XTimeSlotStopMonth=01; Search_DynamicField_XTimeSlotStopDay=26; Search_DynamicField_XTimeSlotStopHour=23; Search_DynamicField_XTimeSlotStopMinute=59; Search_DynamicField_XTimeSlotStopSecond=59;\' and or \'Search_DynamicField_XTimePointFormat=week; Search_DynamicField_XTimePointStart=Before; Search_DynamicField_XTimePointValue=7\';.'} =
        'Določa privzeto prikazan atribut iskanja elementa konfiguracije za zaslon iskanja elementa konfiguracije. Primer: "Key" mora imeti ime dinamičnega polja, v tem primeru "X", "Content" mora imeti vrednost dinamičnega polja, odvisno od vrste dinamičnega polja, Text: "a text", Dropdown: "1", Date/Time: "Search_DynamicField_XTimeSlotStartYear=1974; Search_DynamicField_XTimeSlotStartMonth=01; Search_DynamicField_XTimeSlotStartDay=26; Search_DynamicField_XTimeSlotStartHour=00; Search_DynamicField_XTimeSlotStartMinute=00; Search_DynamicField_XTimeSlotStartSecond=00; Search_DynamicField_XTimeSlotStopYear=2013; Search_DynamicField_XTimeSlotStopMonth=01; Search_DynamicField_XTimeSlotStopDay=26; Search_DynamicField_XTimeSlotStopHour=23; Search_DynamicField_XTimeSlotStopMinute=59; Search_DynamicField_XTimeSlotStopSecond=59;\' in ali \'Search_DynamicField_XTimePointFormat=teden; Search_DynamicField_XTimePointStart=Pred; Search_DynamicField_XTimePointValue=7\';.';
    $Self->{Translation}->{'Defines the default subobject of the class \'ITSMConfigItem\'.'} =
        'Opredeljuje privzeti podobjekt razreda \'ITSMConfigItem\'.';
    $Self->{Translation}->{'Defines the disabled columns of CIs in the config item overview depending on the CI class. Each entry must consist of a class name and an array of available fields for the corresponding class. Dynamic field entries have to honor the scheme DynamicField_FieldName.'} =
        '';
    $Self->{Translation}->{'Defines the height for the rich text editor component for this screen. Enter number (pixels) or percent value (relative).'} =
        'Določa višino komponente urejevalnika bogatega besedila za ta zaslon. Vnesite število (piksli) ali odstotno vrednost (relativno).';
    $Self->{Translation}->{'Defines the number of rows for the CI definition editor in the admin interface.'} =
        'Določa število vrstic za urejevalnik definicij CI v upraviteljskem vmesniku.';
    $Self->{Translation}->{'Defines the order of incident states from high (e.g. cricital) to low (e.g. functional).'} =
        'Opredeljuje vrstni red stanj incidenta od visokega (npr. cricitalno) do nizkega (npr. funkcionalno).';
    $Self->{Translation}->{'Defines the relevant deployment states where linked tickets can affect the status of a CI.'} =
        'Opredeljuje ustrezna stanja uvajanja, v katerih lahko povezane vozovnice vplivajo na stanje CI.';
    $Self->{Translation}->{'Defines the search limit for the AgentITSMConfigItem screen.'} =
        'Določa omejitev iskanja za zaslon AgentITSMConfigItem.';
    $Self->{Translation}->{'Defines the search limit for the AgentITSMConfigItemSearch screen.'} =
        'Določa omejitev iskanja za zaslon AgentITSMConfigItemSearch.';
    $Self->{Translation}->{'Defines the search limit for the CustomerITSMConfigItem screen.'} =
        'Določa omejitev iskanja za zaslon CustomerITSMConfigItem.';
    $Self->{Translation}->{'Defines the search limit for the CustomerITSMConfigItemSearch screen.'} =
        'Določa omejitev iskanja za zaslon CustomerITSMConfigItemSearch.';
    $Self->{Translation}->{'Defines the shown columns of CIs in the link table complex view for all CI classes. If there is no entry, then the default columns are shown.'} =
        'Opredeljuje prikazane stolpce KI v kompleksnem pogledu preglednice povezav za vse razrede KI. Če vnosa ni, so prikazani privzeti stolpci.';
    $Self->{Translation}->{'Defines the shown columns of CIs in the link table complex view, depending on the CI class. Each entry must be prefixed with the class name and double colons (i.e. Computer::). There are a few CI-Attributes that common to all CIs (example for the class Computer: Computer::Name, Computer::CurDeplState, Computer::CreateTime). To show individual CI-Attributes as defined in the CI-Definition, the following scheme must be used (example for the class Computer): Computer::HardDisk::1, Computer::HardDisk::1::Capacity::1, Computer::HardDisk::2, Computer::HardDisk::2::Capacity::1. If there is no entry for a CI class, then the default columns are shown.'} =
        'Opredeljuje prikazane stolpce KI v kompleksnem pogledu preglednice povezav, odvisno od razreda KI. Vsak vnos mora biti opremljen z imenom razreda in dvojnimi dvopičji (npr. Computer::). Obstaja nekaj atributov CI-Attributes, ki so skupni vsem CI (primer za razred Računalnik: Computer::Name, Computer::CurDeplState, Computer::CreateTime). Za prikaz posameznih CI-atributov, kot so opredeljeni v definiciji CI, je treba uporabiti naslednjo shemo (primer za razred Computer): Computer::HardDisk::1, Computer::HardDisk::1::Capacity::1, Computer::HardDisk::2, Computer::HardDisk::2::Capacity::1. Če za razred CI ni vnosa, so prikazani privzeti stolpci.';
    $Self->{Translation}->{'Defines which items are available for \'Action\' in third level of the ITSM Config Item ACL structure.'} =
        'Opredeljuje, kateri elementi so na voljo za "Action" na tretji ravni strukture ITSM Config Item ACL.';
    $Self->{Translation}->{'Defines which items are available in first level of the ITSM Config Item ACL structure.'} =
        'Določa, kateri elementi so na voljo na prvi ravni strukture ITSM Config Item ACL.';
    $Self->{Translation}->{'Defines which items are available in second level of the ITSM Config Item ACL structure.'} =
        'Določa, kateri elementi so na voljo na drugi ravni strukture ITSM Config Item ACL.';
    $Self->{Translation}->{'Defines which type of link (named from the ticket perspective) can affect the status of a linked CI.'} =
        'Določa, katera vrsta povezave (poimenovana z vidika vozovnice) lahko vpliva na stanje povezanega CI.';
    $Self->{Translation}->{'Defines which type of ticket can affect the status of a linked CI.'} =
        'Določa, katera vrsta vozovnice lahko vpliva na stanje povezanega CI.';
    $Self->{Translation}->{'Definition Update'} = 'Posodobitev definicije';
    $Self->{Translation}->{'Delete Configuration Item'} = 'Brisanje elementa konfiguracije';
    $Self->{Translation}->{'DeplState'} = 'DeplState';
    $Self->{Translation}->{'Deployment State Color'} = 'Barva stanja namestitve';
    $Self->{Translation}->{'DeploymentState'} = 'DeploymentState';
    $Self->{Translation}->{'Duplicate'} = 'Duplikatni';
    $Self->{Translation}->{'Dynamic field event module that marks config item definitions as out of sync, if containing dynamic fields change.'} =
        'Modul za dogodke dinamičnih polj, ki označi definicije elementov konfiguracije kot nesinhronizirane, če se spremenijo dinamična polja, ki jih vsebujejo.';
    $Self->{Translation}->{'Dynamic fields shown in the additional ITSM field screen of the agent interface.'} =
        'Dinamična polja, prikazana na zaslonu dodatnega polja ITSM v vmesniku agenta.';
    $Self->{Translation}->{'Dynamic fields shown in the config item overview screen of the customer interface.'} =
        'Dinamična polja, prikazana na zaslonu za pregled elementa konfiguracije v vmesniku za stranke.';
    $Self->{Translation}->{'Dynamic fields shown in the config item search screen of the agent interface.'} =
        'Dinamična polja, prikazana na zaslonu za iskanje elementov konfiguracije v vmesniku agenta.';
    $Self->{Translation}->{'Enables configuration item bulk action feature for the agent frontend to work on more than one configuration item at a time.'} =
        'Omogoča funkcijo množičnega delovanja za konfiguracijske elemente za sprednji del agenta, ki deluje na več kot enem konfiguracijskem elementu naenkrat.';
    $Self->{Translation}->{'Enables configuration item bulk action feature only for the listed groups.'} =
        'Omogoči funkcijo množičnega delovanja konfiguracijskih elementov samo za navedene skupine.';
    $Self->{Translation}->{'Enables/disables the functionality to check ITSM onfiguration items for unique names. Before enabling this option you should check your system for already existing config items with duplicate names. You can do this with the console command Admin::ITSM::ConfigItem::ListDuplicates.'} =
        'Omogoči/odklopi funkcionalnost preverjanja edinstvenih imen elementov konfiguracije ITSM. Preden omogočite to možnost, morate preveriti svoj sistem za že obstoječe elemente konfiguracije s podvojenimi imeni. To lahko storite s konzolnim ukazom Admin::ITSM::ConfigItem::ListDuplicates.';
    $Self->{Translation}->{'Event module to set configitem-status on ticket-configitem-link.'} =
        'Modul dogodkov za nastavitev stanja konfiguracije na povezavi ticket-configitem-link.';
    $Self->{Translation}->{'Fields of the configuration item index, used for the fulltext search. Fields are also stored, but are not mandatory for the overall functionality. Inclusion of attachments can be disabled by setting the entry to 0 or deleting it.'} =
        'Polja indeksa elementa konfiguracije, ki se uporabljajo za iskanje po celotnem besedilu. Polja so prav tako shranjena, vendar niso obvezna za celotno funkcionalnost. Vključevanje prilog lahko onemogočite tako, da vnos nastavite na 0 ali ga izbrišete.';
    $Self->{Translation}->{'Fields stored in the configuration item index which are used for other things besides fulltext searches. For the complete functionality all fields are mandatory.'} =
        'Polja, shranjena v indeksu elementov konfiguracije, ki se poleg iskanja po celotnem besedilu uporabljajo tudi za druge stvari. Za popolno funkcionalnost so vsa polja obvezna.';
    $Self->{Translation}->{'For every webservice (key) an array of classes (value) can be defined on which the import is restricted. For all chosen classes, or all existing classes the identifying attributes will have to be chosen in the invoker config.'} =
        'Za vsako spletno storitev (ključ) lahko določite niz razredov (vrednost), za katere je uvoz omejen. Za vse izbrane razrede ali vse obstoječe razrede bo treba v konfiguraciji invokerja izbrati identifikacijske atribute.';
    $Self->{Translation}->{'GenericInterface module registration for the ConfigItemCreate invoker layer.'} =
        '';
    $Self->{Translation}->{'GenericInterface module registration for the ConfigItemFetch invoker layer.'} =
        'Registracija modula GenericInterface za sloj invokatorja ConfigItemFetch.';
    $Self->{Translation}->{'GenericInterface module registration for the ConfigItemUpdate invoker layer.'} =
        '';
    $Self->{Translation}->{'ITSM ConfigItem'} = 'ITSM ConfigItem';
    $Self->{Translation}->{'ITSM config item overview.'} = 'Pregled elementa konfiguracije ITSM.';
    $Self->{Translation}->{'InciState'} = 'InciState';
    $Self->{Translation}->{'IncidentState'} = 'IncidentState';
    $Self->{Translation}->{'Includes deployment states in the config item search of the customer interface.'} =
        'Vključuje stanja uvajanja v iskanje elementov konfiguracije v uporabniškem vmesniku.';
    $Self->{Translation}->{'Includes incident states in the config item search of the customer interface.'} =
        'Vključuje stanja incidentov v iskanje elementov konfiguracije v uporabniškem vmesniku.';
    $Self->{Translation}->{'License accounting configuration item event module.'} = '';
    $Self->{Translation}->{'Maximum number of config items to be displayed in the result of this operation.'} =
        'Največje število elementov konfiguracije, ki se prikažejo v rezultatu te operacije.';
    $Self->{Translation}->{'Module to check the group responsible for a class.'} = 'Modul za preverjanje skupine, odgovorne za razred.';
    $Self->{Translation}->{'Module to check the group responsible for a configuration item.'} =
        'Modul za preverjanje skupine, odgovorne za element konfiguracije.';
    $Self->{Translation}->{'Module to generate ITSM config item statistics.'} = 'Modul za ustvarjanje statistike elementov konfiguracije ITSM.';
    $Self->{Translation}->{'Name Module'} = 'Ime Modul';
    $Self->{Translation}->{'Number Module'} = 'Modul števila';
    $Self->{Translation}->{'Number of config items to be displayed in each page of a search result in the agent interface.'} =
        'Število elementov konfiguracije, ki se prikažejo na vsaki strani rezultata iskanja v vmesniku agenta.';
    $Self->{Translation}->{'Number of config items to be displayed in each page of a search result in the customer interface.'} =
        'Število elementov konfiguracije, ki se prikažejo na vsaki strani rezultata iskanja v uporabniškem vmesniku.';
    $Self->{Translation}->{'Objects to search for, how many entries and which attributs to show. ConfigItem attributes have to explicitly be stored via Elasticsearch.'} =
        'Predmeti za iskanje, koliko vnosov in kateri atributi naj se prikažejo. Atributi ConfigItem morajo biti izrecno shranjeni prek storitve Elasticsearch.';
    $Self->{Translation}->{'Overview.'} = 'Pregled.';
    $Self->{Translation}->{'Parameters for the categories for config item classes in the preferences view of the agent interface.'} =
        'Parametri za kategorije za razrede elementov konfiguracije v pogledu nastavitev v vmesniku agenta.';
    $Self->{Translation}->{'Parameters for the column filters of the small config item overview. Please note: setting \'Active\' to 0 will only prevent agents from editing settings of this group in their personal preferences, but will still allow administrators to edit the settings of another user\'s behalf. Use \'PreferenceGroup\' to control in which area these settings should be shown in the user interface.'} =
        'Parametri za filtre stolpcev v pregledu majhnih elementov konfiguracije. Upoštevajte: z nastavitvijo "Aktivno" na 0 bo agentom preprečeno le urejanje nastavitev te skupine v njihovih osebnih nastavitvah, vendar bo administratorjem še vedno omogočeno urejanje nastavitev v imenu drugega uporabnika. S funkcijo \'PreferenceGroup\' lahko nadzirate, v katerem območju naj bodo te nastavitve prikazane v uporabniškem vmesniku.';
    $Self->{Translation}->{'Parameters for the dashboard backend of the customer company config item overview of the agent interface . "Limit" is the number of entries per config item class shown by default. "Group" is used to restrict the access to the plugin (e. g. Group: admin;group1;group2;). "Default" determines if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" is the cache time in minutes for the plugin. "ConfigItemKey" is used to specify which reference field is used for a ConfigItem class (Key=Class, Value=DynamicFieldName).'} =
        '';
    $Self->{Translation}->{'Parameters for the dashboard backend of the customer company config item overview of the agent interface . "Limit" is the number of entries shown by default. "Group" is used to restrict the access to the plugin (e. g. Group: admin;group1;group2;). "Default" determines if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" is the cache time in minutes for the plugin. "ConfigItemKey" is used to specify which reference field is used for a ConfigItem class (Key=Class, Value=DynamicFieldName).'} =
        '';
    $Self->{Translation}->{'Parameters for the deployment states color in the preferences view of the agent interface.'} =
        'Parametri za barvo stanja uvajanja v pogledu nastavitev v vmesniku agenta.';
    $Self->{Translation}->{'Parameters for the deployment states in the preferences view of the agent interface.'} =
        'Parametri za stanja uvajanja v pogledu nastavitev v vmesniku agenta.';
    $Self->{Translation}->{'Parameters for the example permission groups of the general catalog attributes.'} =
        'Parametri za primer skupin dovoljenj splošnih atributov kataloga.';
    $Self->{Translation}->{'Parameters for the name module for config item classes in the preferences view of the agent interface.'} =
        'Parametri za modul imena za razrede elementov konfiguracije v pogledu nastavitev vmesnika agenta.';
    $Self->{Translation}->{'Parameters for the number module for config item classes in the preferences view of the agent interface.'} =
        'Parametri za modul števila za razrede elementov konfiguracije v pogledu nastavitev v vmesniku agenta.';
    $Self->{Translation}->{'Parameters for the pages (in which the configuration items are shown).'} =
        'Parametri za strani (na katerih so prikazani elementi konfiguracije).';
    $Self->{Translation}->{'Parameters for the version string module for config item classes in the preferences view of the agent interface.'} =
        'Parametri za modul verzije niza za razrede elementov konfiguracije v pogledu nastavitev v vmesniku agenta.';
    $Self->{Translation}->{'Parameters for the version string template toolkit module for config item classes in the preferences view of the agent interface.'} =
        'Parametri za modul predloge niza različic za razrede elementov konfiguracije v pogledu nastavitev v vmesniku agenta.';
    $Self->{Translation}->{'Parameters for the version trigger for config item classes in the preferences view of the agent interface.'} =
        'Parametri za sprožilec različice za razrede elementov konfiguracije v pogledu nastavitev vmesnika agenta.';
    $Self->{Translation}->{'Performs the configured action for each event (as an Invoker) for each configured Webservice.'} =
        'Izvede konfigurirano dejanje za vsak dogodek (kot Invoker) za vsako konfigurirano spletno storitev.';
    $Self->{Translation}->{'Permission Group'} = 'Skupina dovoljenj';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item attachment action in the agent interface.'} =
        'Zahtevana dovoljenja za uporabo dejanja pritrditve elementa konfiguracije ITSM v vmesniku agenta.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item screen in the agent interface.'} =
        'Zahtevana dovoljenja za uporabo zaslona elementa konfiguracije ITSM v vmesniku agenta.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item search screen in the agent interface.'} =
        'Zahtevana dovoljenja za uporabo zaslona za iskanje elementov konfiguracije ITSM v vmesniku agenta.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item search screen in the customer interface.'} =
        'Zahtevana dovoljenja za uporabo zaslona za iskanje elementov konfiguracije ITSM v uporabniškem vmesniku.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item tree view screen in the agent interface.'} =
        'Zahtevana dovoljenja za uporabo zaslona drevesnega prikaza elementov konfiguracije ITSM v vmesniku agenta.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item zoom screen in the agent interface.'} =
        'Zahtevana dovoljenja za uporabo zaslona za povečavo elementa konfiguracije ITSM v vmesniku agenta.';
    $Self->{Translation}->{'Required permissions to use the add ITSM configuration item screen in the agent interface.'} =
        'Zahtevana dovoljenja za uporabo zaslona Dodaj element konfiguracije ITSM v vmesniku agenta.';
    $Self->{Translation}->{'Required permissions to use the bulk ITSM configuration item screen in the agent interface.'} =
        'Zahtevana dovoljenja za uporabo zaslona za postavko skupinske konfiguracije ITSM v vmesniku agenta.';
    $Self->{Translation}->{'Required permissions to use the edit ITSM configuration item screen in the agent interface.'} =
        'Zahtevana dovoljenja za uporabo zaslona za urejanje elementa konfiguracije ITSM v vmesniku agenta.';
    $Self->{Translation}->{'Required permissions to use the history ITSM configuration item screen in the agent interface.'} =
        'Zahtevana dovoljenja za uporabo zaslona za zgodovino elementa konfiguracije ITSM v vmesniku agenta.';
    $Self->{Translation}->{'Required permissions to use the print ITSM configuration item screen in the agent interface.'} =
        'Zahtevana dovoljenja za uporabo zaslona za tiskanje elementa konfiguracije ITSM v vmesniku agenta.';
    $Self->{Translation}->{'Required privileges to delete config items.'} = 'Zahtevani privilegiji za brisanje elementov konfiguracije.';
    $Self->{Translation}->{'Search config items.'} = 'Iskanje elementov konfiguracije.';
    $Self->{Translation}->{'Set the incident state of a CI automatically when a Ticket is Linked to a CI.'} =
        'samodejno nastavite stanje incidenta v CI, ko je vozovnica povezana s CI.';
    $Self->{Translation}->{'Sets the deployment state in the configuration item bulk screen of the agent interface.'} =
        'Nastavi stanje uvajanja na zaslonu za množične elemente konfiguracije v vmesniku agenta.';
    $Self->{Translation}->{'Sets the incident state in the configuration item bulk screen of the agent interface.'} =
        'Nastavi stanje incidenta na zaslonu za množično konfiguracijo elementov v vmesniku agenta.';
    $Self->{Translation}->{'Shows a link in the menu that allows linking a configuration item with another object in the config item zoom view of the agent interface.'} =
        'Prikaže povezavo v meniju, ki omogoča povezavo elementa konfiguracije z drugim objektom v pogledu povečave elementa konfiguracije v vmesniku agenta.';
    $Self->{Translation}->{'Shows a link in the menu to access the history of a configuration item in the configuration item overview of the agent interface.'} =
        'Prikaže povezavo v meniju za dostop do zgodovine elementa konfiguracije v pregledu elementa konfiguracije v vmesniku agenta.';
    $Self->{Translation}->{'Shows a link in the menu to access the history of a configuration item in the its zoom view of the agent interface.'} =
        'Prikaže povezavo v meniju za dostop do zgodovine elementa konfiguracije v pogledu povečave vmesnika agenta.';
    $Self->{Translation}->{'Shows a link in the menu to delete a configuration item in its zoom view of the agent interface.'} =
        'V meniju prikaže povezavo za brisanje elementa konfiguracije v povečanem pogledu vmesnika agenta.';
    $Self->{Translation}->{'Shows a link in the menu to display the configuration item links as a Tree View.'} =
        'Prikaže povezavo v meniju za prikaz povezav elementov konfiguracije v obliki drevesnega pogleda.';
    $Self->{Translation}->{'Shows a link in the menu to duplicate a configuration item in the configuration item overview of the agent interface.'} =
        'V meniju prikaže povezavo za podvojitev konfiguracijske elementa v pregledu konfiguracijskih elementov v vmesniku agenta.';
    $Self->{Translation}->{'Shows a link in the menu to duplicate a configuration item in the its zoom view of the agent interface.'} =
        'Prikaže povezavo v meniju za podvojitev elementa konfiguracije v pogledu povečave vmesnika agenta.';
    $Self->{Translation}->{'Shows a link in the menu to edit a configuration item in the its zoom view of the agent interface.'} =
        'Prikaže povezavo v meniju za urejanje elementa konfiguracije v pogledu povečave vmesnika agenta.';
    $Self->{Translation}->{'Shows a link in the menu to go back in the configuration item zoom view of the agent interface.'} =
        'V meniju prikaže povezavo za vrnitev v pogled povečave konfiguracijske enote v vmesniku agenta.';
    $Self->{Translation}->{'Shows a link in the menu to print a configuration item in the its zoom view of the agent interface.'} =
        'Prikaže povezavo v meniju za tiskanje elementa konfiguracije v pogledu povečave vmesnika agenta.';
    $Self->{Translation}->{'Shows a link in the menu to zoom into a configuration item in the configuration item overview of the agent interface.'} =
        'Prikaže povezavo v meniju za povečavo elementa konfiguracije v pregledu elementov konfiguracije v vmesniku agenta.';
    $Self->{Translation}->{'Shows the config item history (reverse ordered) in the agent interface.'} =
        'Prikaže zgodovino elementov konfiguracije (v obratnem vrstnem redu) v vmesniku agenta.';
    $Self->{Translation}->{'The default category which is shown, if none is selected.'} = 'Privzeta kategorija, ki se prikaže, če ni izbrana nobena.';
    $Self->{Translation}->{'The identifier for a configuration item, e.g. ConfigItem#, MyConfigItem#. The default is ConfigItem#.'} =
        'Identifikator elementa konfiguracije, npr. ConfigItem#, MyConfigItem#. Privzeto je ConfigItem#.';
    $Self->{Translation}->{'Triggers ConfigItemFetch invoker automatically.'} = 'Samodejno sproži sprožilca ConfigItemFetch.';
    $Self->{Translation}->{'Version String Expression'} = 'Različica String Izraz';
    $Self->{Translation}->{'Version String Module'} = 'Različica String Modul';
    $Self->{Translation}->{'Version Trigger'} = 'Sprožilnik različice';
    $Self->{Translation}->{'Whether fields should be automatically filled (1), and in that case also be hidden from ticket formulars (2).'} =
        '';
    $Self->{Translation}->{'Whether the execution of ConfigItemACL can be avoided by checking cached field dependencies. This can improve loading times of formulars, but has to be disabled, if ACLModules are to be used for ITSMConfigItem- and Form-ReturnTypes.'} =
        'Ali se lahko izvedbi ConfigItemACL izognemo s preverjanjem odvisnosti polj v predpomnilniku. To lahko izboljša čas nalaganja obrazcev, vendar mora biti onemogočeno, če se za tipe ITSMConfigItem- in Form-ReturnType uporabljajo moduli ACL.';
    $Self->{Translation}->{'Which general information is shown in the header.'} = 'Kateri splošni podatki so prikazani v glavi.';
    $Self->{Translation}->{'class'} = 'razred';
    $Self->{Translation}->{'global'} = 'globalno';
    $Self->{Translation}->{'postproductive'} = 'postproduktivni';
    $Self->{Translation}->{'preproductive'} = 'predproduktivni';
    $Self->{Translation}->{'productive'} = 'produktivno';

    # Ready to adopt classes: IT-Servicemanagement-11_0_3
    $Self->{Translation}->{'10U: 17.5 inches (44.45 cm)'} = '10U: 17,5 palca (44,45 cm)';
    $Self->{Translation}->{'12U: 21 inches (53.34 cm)'} = '12U: 21 palcev (53,34 cm)';
    $Self->{Translation}->{'15U: 26.25 inches (66.68 cm)'} = '15U: 26,25 palca (66,68 cm)';
    $Self->{Translation}->{'18U: 31.5 inches (80.01 cm)'} = '18U: 31,5 palca (80,01 cm)';
    $Self->{Translation}->{'19-inch Rack'} = '19-palčni nosilec';
    $Self->{Translation}->{'1U: 1.75 inches (4.45 cm)'} = '1U: 1,75 palca (4,45 cm)';
    $Self->{Translation}->{'20U: 35 inches (88.9 cm)'} = '20U: 35 palcev (88,9 cm)';
    $Self->{Translation}->{'21-inch Rack'} = '21-palčni nosilec';
    $Self->{Translation}->{'22U: 38.5 inches (97.79 cm)'} = '22U: 38,5 palca (97,79 cm)';
    $Self->{Translation}->{'23-inch Rack'} = '23-palčno stojalo';
    $Self->{Translation}->{'23.6 inches (600 mm)'} = '23,6 palca (600 mm)';
    $Self->{Translation}->{'24U: 42 inches (106.68 cm)'} = '24U: 42 palcev (106,68 cm)';
    $Self->{Translation}->{'27U: 47.25 inches (120.02 cm)'} = '27U: 47,25 palca (120,02 cm)';
    $Self->{Translation}->{'2U: 3.5 inches (8.89 cm)'} = '2U: 3,5 palca (8,89 cm)';
    $Self->{Translation}->{'30U: 52.5 inches (133.35 cm)'} = '30U: 52,5 palca (133,35 cm)';
    $Self->{Translation}->{'31.5 inches (800 mm)'} = '31,5 palca (800 mm)';
    $Self->{Translation}->{'33U: 57.75 inches (146.68 cm)'} = '33U: 57,75 palca (146,68 cm)';
    $Self->{Translation}->{'35.4 inches (900 mm)'} = '35,4 palca (900 mm)';
    $Self->{Translation}->{'36U: 63 inches (160.02 cm)'} = '36U: 63 palcev (160,02 cm)';
    $Self->{Translation}->{'39.4 inches (1000 mm)'} = '39,4 palca (1000 mm)';
    $Self->{Translation}->{'39U: 68.25 inches (173.35 cm)'} = '39U: 68,25 palca (173,35 cm)';
    $Self->{Translation}->{'3U: 5.25 inches (13.34 cm)'} = '3U: 5,25 palca (13,34 cm)';
    $Self->{Translation}->{'42U: 73.5 inches (186.69 cm)'} = '42U: 73,5 palca (186,69 cm)';
    $Self->{Translation}->{'43.3 inches (1100 mm):'} = '43,3 palca (1100 mm):';
    $Self->{Translation}->{'45U: 78.75 inches (200.02 cm)'} = '45U: 78,75 palca (200,02 cm)';
    $Self->{Translation}->{'47.2 inches (1200 mm)'} = '47,2 palca (1200 mm)';
    $Self->{Translation}->{'48U: 84 inches (213.36 cm)'} = '48U: 84 palcev (213,36 cm)';
    $Self->{Translation}->{'4U: 7 inches (17.78 cm)'} = '4U: 7 palcev (17,78 cm)';
    $Self->{Translation}->{'5U: 8.75 inches (22.23 cm)'} = '5U: 8,75 palca (22,23 cm)';
    $Self->{Translation}->{'6U: 10.5 inches (26.67 cm)'} = '6U: 10,5 palca (26,67 cm)';
    $Self->{Translation}->{'7U: 12.25 inches (31.12 cm)'} = '7U: 12,25 palca (31,12 cm)';
    $Self->{Translation}->{'8U: 14 inches (35.56 cm)'} = '8U: 14 palcev (35,56 cm)';
    $Self->{Translation}->{'9U: 15.75 inches (40.01 cm)'} = '9U: 15,75 palca (40,01 cm)';
    $Self->{Translation}->{'AGPL (Affero General Public License)'} = '';
    $Self->{Translation}->{'Accounting'} = 'Računovodstvo';
    $Self->{Translation}->{'Accounting Information'} = '';
    $Self->{Translation}->{'Address Allocation'} = 'Dodeljevanje naslovov';
    $Self->{Translation}->{'Administrator'} = 'Upravitelj';
    $Self->{Translation}->{'Analog Phone'} = 'Analogni telefon';
    $Self->{Translation}->{'Apache Lizenz'} = '';
    $Self->{Translation}->{'Appliance Type'} = 'Vrsta naprave';
    $Self->{Translation}->{'BSD Lizenz (Berkeley Software Distribution License)'} = '';
    $Self->{Translation}->{'Battery Capacity (Ah)'} = 'Zmogljivost baterije (Ah)';
    $Self->{Translation}->{'Battery Type'} = 'Vrsta baterije';
    $Self->{Translation}->{'Building'} = 'Stavba';
    $Self->{Translation}->{'Bus Interface'} = 'Vmesnik vodila';
    $Self->{Translation}->{'CC0 (Creative Commons Zero)'} = '';
    $Self->{Translation}->{'CIDR'} = 'CIDR';
    $Self->{Translation}->{'CPU'} = 'CPU';
    $Self->{Translation}->{'CPU Class'} = 'Razred procesorja';
    $Self->{Translation}->{'Capacity (GB)'} = 'Zmogljivost (GB)';
    $Self->{Translation}->{'Capacity per graphics card'} = 'Zmogljivost na grafično kartico';
    $Self->{Translation}->{'Card Number'} = 'Številka kartice';
    $Self->{Translation}->{'Card Reader'} = 'Bralnik kartic';
    $Self->{Translation}->{'Card Type'} = 'Vrsta kartice';
    $Self->{Translation}->{'Client Certificates'} = 'Potrdila strank';
    $Self->{Translation}->{'Client Software'} = 'Odjemalska programska oprema';
    $Self->{Translation}->{'Client category'} = 'Kategorija strank';
    $Self->{Translation}->{'Clockrate'} = 'Časovna stopnja';
    $Self->{Translation}->{'Clockspeed'} = 'Hitrost ur';
    $Self->{Translation}->{'Code Signing Certificates'} = 'Potrdila za podpisovanje kode';
    $Self->{Translation}->{'Conference Phone'} = 'Konferenčni telefon';
    $Self->{Translation}->{'Consulting Agreement'} = 'Pogodba o svetovanju';
    $Self->{Translation}->{'Contact'} = 'Pišite na';
    $Self->{Translation}->{'Contact Distributor'} = 'Stik z distributerjem';
    $Self->{Translation}->{'Container Management'} = 'Upravljanje zabojnikov';
    $Self->{Translation}->{'Contract'} = 'Pogodba';
    $Self->{Translation}->{'Contract Type'} = 'Vrsta pogodbe';
    $Self->{Translation}->{'Contract period from'} = 'Pogodbeno obdobje od';
    $Self->{Translation}->{'Contract period until'} = 'Pogodbeno obdobje do';
    $Self->{Translation}->{'Cordless Phone (DECT Phone)'} = 'Brezžični telefon (telefon DECT)';
    $Self->{Translation}->{'Cost unit'} = 'Stroškovna enota';
    $Self->{Translation}->{'Count of licenses'} = 'Število licenc';
    $Self->{Translation}->{'Creation Date'} = 'Datum ustanovitve';
    $Self->{Translation}->{'Creative Commons'} = '';
    $Self->{Translation}->{'Custom Rack'} = 'Stojalo po meri';
    $Self->{Translation}->{'DHCP'} = 'DHCP';
    $Self->{Translation}->{'DHCP Reserved'} = 'DHCP Rezervirano';
    $Self->{Translation}->{'DNS-Server'} = 'Strežnik DNS';
    $Self->{Translation}->{'DVI'} = 'DVI';
    $Self->{Translation}->{'Date of Invoice'} = 'Datum računa';
    $Self->{Translation}->{'Date of Order'} = 'Datum naročila';
    $Self->{Translation}->{'Date of Warranty'} = 'Datum garancije';
    $Self->{Translation}->{'Date of release'} = 'Datum izdaje';
    $Self->{Translation}->{'Desktop'} = 'Namizni računalnik';
    $Self->{Translation}->{'DisplayPort'} = 'DisplayPort';
    $Self->{Translation}->{'Document Signing Certificates'} = 'Potrdila za podpisovanje dokumentov';
    $Self->{Translation}->{'EPL (Eclipse Public License)'} = '';
    $Self->{Translation}->{'ETSI Rack'} = 'ETSI Rack';
    $Self->{Translation}->{'Email Certificates (S/MIME Certificates)'} = 'Potrdila za e-pošto (potrdila S/MIME)';
    $Self->{Translation}->{'Embedded SIM (eSIM)'} = '';
    $Self->{Translation}->{'Employment Contract'} = 'Pogodba o zaposlitvi';
    $Self->{Translation}->{'End IP Address'} = 'Končni naslov IP';
    $Self->{Translation}->{'End of support'} = 'Konec podpore';
    $Self->{Translation}->{'Expiry Date'} = 'Datum izteka veljavnosti';
    $Self->{Translation}->{'External Hard Drive'} = 'Zunanji trdi disk';
    $Self->{Translation}->{'Firewall'} = 'Požarni zid';
    $Self->{Translation}->{'Firmware'} = 'Vdelana programska oprema';
    $Self->{Translation}->{'Flywheel Energy Storage'} = 'Skladiščenje energije z vztrajnikom';
    $Self->{Translation}->{'Form Factor'} = 'Faktor oblike';
    $Self->{Translation}->{'Franchise Agreement'} = 'Pogodba o franšizi';
    $Self->{Translation}->{'Freeware'} = 'Brezplačna programska oprema';
    $Self->{Translation}->{'GPL (General Public License)'} = '';
    $Self->{Translation}->{'General Information'} = 'Splošne informacije';
    $Self->{Translation}->{'Graphics Cards'} = 'Grafične kartice';
    $Self->{Translation}->{'Graphics card'} = 'Grafična kartica';
    $Self->{Translation}->{'HDMI'} = 'HDMI';
    $Self->{Translation}->{'Hardware'} = 'Strojna oprema';
    $Self->{Translation}->{'Hardware Model'} = 'Model strojne opreme';
    $Self->{Translation}->{'Hardware Weight'} = 'Teža strojne opreme';
    $Self->{Translation}->{'Headset'} = 'Slušalke';
    $Self->{Translation}->{'IP Protocol'} = 'Protokol IP';
    $Self->{Translation}->{'Identity and Access Management (IAM)'} = 'Upravljanje identitet in dostopa (IAM)';
    $Self->{Translation}->{'Inventory Number'} = 'Inventarna številka';
    $Self->{Translation}->{'Inverstment costs'} = 'Stroški inverzije';
    $Self->{Translation}->{'Invoice Number'} = 'Številka računa';
    $Self->{Translation}->{'Keyboard'} = 'Tipkovnica';
    $Self->{Translation}->{'LCD Monitor (Liquid Crystal Display)'} = 'Monitor LCD (zaslon s tekočimi kristali)';
    $Self->{Translation}->{'LED Monitor (Light Emitting Diode)'} = 'Monitor LED (svetleča dioda)';
    $Self->{Translation}->{'LGPL (Lesser General Public License)'} = '';
    $Self->{Translation}->{'Landline Phone'} = 'Stacionarni telefon';
    $Self->{Translation}->{'Laptop'} = 'Prenosni računalnik';
    $Self->{Translation}->{'Latitude'} = 'Zemljepisna širina';
    $Self->{Translation}->{'Layer 1: Physical Layer'} = 'Plast 1: fizična plast';
    $Self->{Translation}->{'Layer 2: Data Link Layer'} = 'Plast 2: plast podatkovnih povezav';
    $Self->{Translation}->{'Layer 3: Network Layer'} = 'Plast 3: omrežna plast';
    $Self->{Translation}->{'Layer 3: Network Layer (Supernet)'} = '3. plast: omrežna plast (nadomrežje)';
    $Self->{Translation}->{'Layer 4: Transport Layer'} = 'Sloj 4: Transportni sloj';
    $Self->{Translation}->{'Layer 5: Session Layer'} = 'Sloj 5: Sejni sloj';
    $Self->{Translation}->{'Layer 6: Presentation Layer'} = 'Sloj 6: Predstavitveni sloj';
    $Self->{Translation}->{'Layer 7: Application Layer'} = 'Sloj 7: aplikacijski sloj';
    $Self->{Translation}->{'Lease Agreement'} = 'Pogodba o najemu';
    $Self->{Translation}->{'License Agreement'} = 'Licenčna pogodba';
    $Self->{Translation}->{'License Count'} = '';
    $Self->{Translation}->{'License Key'} = 'Licenčni ključ';
    $Self->{Translation}->{'License Type'} = 'Vrsta licence';
    $Self->{Translation}->{'License period from'} = 'Obdobje licence od';
    $Self->{Translation}->{'License period until'} = 'Obdobje licence do';
    $Self->{Translation}->{'Lithium Iron Phosphate (LiFePO4) Battery'} = 'Baterije iz litij-železovega fosfata (LiFePO4)';
    $Self->{Translation}->{'Lithium-Ion (Li-ion) Battery'} = 'Litij-ionska (Li-ion) baterija';
    $Self->{Translation}->{'Loan Agreement'} = 'Pogodba o posojilu';
    $Self->{Translation}->{'Located in'} = 'Nahaja se v';
    $Self->{Translation}->{'Longitude'} = 'Zemljepisna dolžina';
    $Self->{Translation}->{'MIT Lizenz'} = '';
    $Self->{Translation}->{'MPL (Mozilla Public License)'} = '';
    $Self->{Translation}->{'Manufacturer'} = 'Proizvajalec';
    $Self->{Translation}->{'Maximum Load Capacity (W)'} = 'Največja zmogljivost obremenitve (W)';
    $Self->{Translation}->{'Memory'} = 'Spomin';
    $Self->{Translation}->{'Memory Type'} = 'Vrsta pomnilnika';
    $Self->{Translation}->{'Micro SIM'} = '';
    $Self->{Translation}->{'Mini-Rack'} = 'Mini stojalo';
    $Self->{Translation}->{'Mobile Number'} = 'Mobilna številka';
    $Self->{Translation}->{'Mobile/Embedded'} = 'Mobilni/vgrajeni';
    $Self->{Translation}->{'Model'} = 'Model';
    $Self->{Translation}->{'Model Description'} = 'Opis modela';
    $Self->{Translation}->{'Monitor Resolution'} = 'Ločljivost monitorja';
    $Self->{Translation}->{'Monitor Size'} = 'Velikost monitorja';
    $Self->{Translation}->{'Mouse'} = 'Miška';
    $Self->{Translation}->{'Nano SIM'} = '';
    $Self->{Translation}->{'Network'} = 'Omrežje';
    $Self->{Translation}->{'Network Info'} = 'Informacije o omrežju';
    $Self->{Translation}->{'Network Information'} = 'Informacije o omrežju';
    $Self->{Translation}->{'Network Layer'} = 'Omrežna plast';
    $Self->{Translation}->{'Nickel-Cadmium (NiCd) Battery'} = 'Nikelj-kadmijeva (NiCd) baterija';
    $Self->{Translation}->{'Nickel-Metal Hydride (NiMH) Battery'} = 'Nikelj-metalhidridna (NiMH) baterija';
    $Self->{Translation}->{'Non-Disclosure Agreement (NDA)'} = 'Sporazum o nerazkrivanju (NDA)';
    $Self->{Translation}->{'Notebook'} = 'Beležnica';
    $Self->{Translation}->{'Number of CPUs'} = 'Število procesorjev';
    $Self->{Translation}->{'Number of RAM modules'} = 'Število modulov RAM';
    $Self->{Translation}->{'Number of graphics cards'} = 'Število grafičnih kartic';
    $Self->{Translation}->{'OLED Monitor (Organic Light Emitting Diode)'} = 'Monitor OLED (organska svetleča dioda)';
    $Self->{Translation}->{'Operating costs'} = 'Stroški poslovanja';
    $Self->{Translation}->{'Order Number'} = 'Številka naročila';
    $Self->{Translation}->{'Other'} = 'Drugo';
    $Self->{Translation}->{'Outputs'} = 'Izhodi';
    $Self->{Translation}->{'PIN'} = 'PIN';
    $Self->{Translation}->{'PIN 2'} = 'PIN 2';
    $Self->{Translation}->{'PUK'} = 'PUK';
    $Self->{Translation}->{'PUK 2'} = 'PUK 2';
    $Self->{Translation}->{'Partnership Agreement'} = 'Sporazum o partnerstvu';
    $Self->{Translation}->{'Perpetual licenses'} = '';
    $Self->{Translation}->{'Phone / VoIP'} = '';
    $Self->{Translation}->{'Phone Number'} = 'Telefonska številka';
    $Self->{Translation}->{'Phone Type'} = 'Vrsta telefona';
    $Self->{Translation}->{'Physical Cores'} = 'Fizična jedra';
    $Self->{Translation}->{'Power Delivery'} = 'Zagotavljanje napajanja';
    $Self->{Translation}->{'Public Domain'} = '';
    $Self->{Translation}->{'Purchased at'} = 'Kupljeno v';
    $Self->{Translation}->{'Rack Depth'} = 'Globina regala';
    $Self->{Translation}->{'Rack Units (U)'} = 'Enote stojala (U)';
    $Self->{Translation}->{'Room'} = 'Soba';
    $Self->{Translation}->{'SIM Card'} = 'Kartica SIM';
    $Self->{Translation}->{'SSL/TLS Certificates'} = 'Potrdila SSL/TLS';
    $Self->{Translation}->{'Sales Contract'} = 'Prodajna pogodba';
    $Self->{Translation}->{'Satellite Phone'} = 'Satelitski telefon';
    $Self->{Translation}->{'Sealed Lead-Acid (SLA) Battery'} = 'Zaprta svinčeno-kislinska baterija (SLA)';
    $Self->{Translation}->{'Seat licenses'} = '';
    $Self->{Translation}->{'Serialnumber'} = 'Serijska številka';
    $Self->{Translation}->{'Server Software'} = 'Programska oprema za strežnike';
    $Self->{Translation}->{'Service Agreement'} = 'Sporazum o storitvah';
    $Self->{Translation}->{'Service Tag'} = 'Storitvena oznaka';
    $Self->{Translation}->{'Shareware'} = '';
    $Self->{Translation}->{'Socket Type'} = 'Vrsta vtičnice';
    $Self->{Translation}->{'Software'} = 'Programska oprema';
    $Self->{Translation}->{'Speakers'} = 'Zvočniki';
    $Self->{Translation}->{'Standard SIM'} = '';
    $Self->{Translation}->{'Start IP Address'} = 'Začetni naslov IP';
    $Self->{Translation}->{'Storage'} = 'Shranjevanje';
    $Self->{Translation}->{'Storage Partition'} = 'Razdelek za shranjevanje';
    $Self->{Translation}->{'Subscription-based licenses'} = '';
    $Self->{Translation}->{'Subsidiary'} = 'Podružnica';
    $Self->{Translation}->{'Summary'} = 'Povzetek';
    $Self->{Translation}->{'Thin Client'} = 'Tanek odjemalec';
    $Self->{Translation}->{'Threads'} = 'Niti';
    $Self->{Translation}->{'Thunderbolt'} = 'Thunderbolt';
    $Self->{Translation}->{'Total Graphics card RAM (GB)'} = 'Skupaj RAM grafične kartice (GB)';
    $Self->{Translation}->{'Total RAM (GB)'} = 'Skupni RAM (GB)';
    $Self->{Translation}->{'Touchscreen Monitor'} = 'Monitor z zaslonom na dotik';
    $Self->{Translation}->{'Tower'} = 'Stolp';
    $Self->{Translation}->{'USB Hub'} = 'Vozlišče USB';
    $Self->{Translation}->{'USB-C'} = 'USB-C';
    $Self->{Translation}->{'VGA'} = 'VGA';
    $Self->{Translation}->{'VPN'} = 'VPN';
    $Self->{Translation}->{'VR Headset'} = 'Naglavna slušalka VR';
    $Self->{Translation}->{'Virtual Client'} = '';
    $Self->{Translation}->{'VirtualLink'} = 'VirtualLink';
    $Self->{Translation}->{'VoIP Phone'} = 'Telefon VoIP';
    $Self->{Translation}->{'Volume licenses'} = '';
    $Self->{Translation}->{'Webcam'} = 'Spletna kamera';


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

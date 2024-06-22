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

package Kernel::Language::ro_ITSMConfigurationManagement;

use strict;
use warnings;
use utf8;

sub Data {
    my $Self = shift;

    # Template: AdminITSMConfigItem
    $Self->{Translation}->{'Config Item Management'} = 'Gestionarea elementelor de configurare';
    $Self->{Translation}->{'Change class definition'} = 'Modificarea definiției clasei';
    $Self->{Translation}->{'Change role definition'} = 'Modificarea definiției rolului';
    $Self->{Translation}->{'Ready2Import Class Bundles'} = 'Pachete de clase Ready2Import';
    $Self->{Translation}->{'Here you can import Ready2Import class bundles showcasing our most usual config items. Please note that some additional configuration may be required.'} =
        'Aici puteți importa pachete de clase Ready2Import care prezintă cele mai uzuale elemente de configurare. Vă rugăm să rețineți că este posibil să fie necesară o anumită configurare suplimentară.';
    $Self->{Translation}->{'Update existing entities'} = 'Actualizarea entităților existente';
    $Self->{Translation}->{'Import Ready2Adopt class bundles'} = 'Importați pachetele de clase Ready2Adopt';
    $Self->{Translation}->{'Config Item Class'} = 'Clasa de elemente de configurare';
    $Self->{Translation}->{'Config Item Role'} = 'Rolul elementului de configurare';

    # Template: AgentITSMConfigItemAdd
    $Self->{Translation}->{'Config Item'} = 'Config Element';
    $Self->{Translation}->{'Filter for Classes'} = 'Filtru pentru clase';
    $Self->{Translation}->{'Select a Class from the list to create a new Config Item.'} = 'Selectați o clasă din listă pentru a crea un nou element de configurare.';
    $Self->{Translation}->{'Class'} = 'Clasa';

    # Template: AgentITSMConfigItemBulk
    $Self->{Translation}->{'ITSM ConfigItem Bulk Action'} = 'ITSM ConfigItem Bulk Action';
    $Self->{Translation}->{'Deployment state'} = 'Starea de desfășurare';
    $Self->{Translation}->{'Incident state'} = 'Starea incidentului';
    $Self->{Translation}->{'Link to another'} = 'Legătura cu un alt';
    $Self->{Translation}->{'Invalid Configuration Item number!'} = 'Număr de element de configurare invalid!';
    $Self->{Translation}->{'The number of another Configuration Item to link with.'} = 'Numărul unui alt element de configurare cu care se face legătura.';

    # Template: AgentITSMConfigItemDelete
    $Self->{Translation}->{'Do you really want to delete this config item?'} = 'Chiar doriți să ștergeți acest element de configurare?';

    # Template: AgentITSMConfigItemEdit
    $Self->{Translation}->{'The name of this config item'} = 'Numele acestui element de configurare';
    $Self->{Translation}->{'Name is already in use by the ConfigItems with the following Number(s): %s'} =
        'Numele este deja utilizat de ConfigItems cu următorul număr (numere): %s';
    $Self->{Translation}->{'Version Number'} = 'Numărul versiunii';
    $Self->{Translation}->{'Version number of this config item'} = '';
    $Self->{Translation}->{'Version Number is already in use by the ConfigItems with the following Number(s): %s'} =
        'Numărul de versiune este deja utilizat de ConfigItems cu următorul număr (numere): %s';
    $Self->{Translation}->{'Deployment State'} = 'Starea de desfășurare';
    $Self->{Translation}->{'Incident State'} = 'Statul incidentului';

    # Template: AgentITSMConfigItemHistory
    $Self->{Translation}->{'History of Config Item: %s'} = 'Istoricul elementului de configurare: %s';
    $Self->{Translation}->{'History Content'} = 'Istorie Conținut';
    $Self->{Translation}->{'Createtime'} = 'Createtime';
    $Self->{Translation}->{'Zoom view'} = 'Vedere de detaliu';

    # Template: AgentITSMConfigItemOverviewNavBar
    $Self->{Translation}->{'Config Items per page'} = 'Config Elemente pe pagină';

    # Template: AgentITSMConfigItemOverviewSmall
    $Self->{Translation}->{'No config item data found.'} = 'Nu s-au găsit date despre elementul de configurare.';
    $Self->{Translation}->{'Select this config item'} = 'Selectați acest element de configurare';

    # Template: AgentITSMConfigItemSearch
    $Self->{Translation}->{'Run Search'} = 'Rulați căutarea';
    $Self->{Translation}->{'Also search in previous versions?'} = 'De asemenea, căutați în versiunile anterioare?';

    # Template: AgentITSMConfigItemTreeView
    $Self->{Translation}->{'TreeView for ConfigItem'} = 'TreeView pentru ConfigItem';
    $Self->{Translation}->{'Depth Level'} = 'Nivelul de adâncime';
    $Self->{Translation}->{'Zoom In/Out'} = 'Zoom In/Out';
    $Self->{Translation}->{'Max links level reached for ConfigItem!'} = 'Nivelul maxim de legături a fost atins pentru ConfigItem!';

    # Template: AgentITSMConfigItemZoom
    $Self->{Translation}->{'Configuration Item'} = 'Element de configurare';
    $Self->{Translation}->{'Configuration Item Information'} = 'Informații despre elementul de configurare';
    $Self->{Translation}->{'Current Deployment State'} = 'Starea actuală de desfășurare';
    $Self->{Translation}->{'Current Incident State'} = 'Starea actuală a incidentului';
    $Self->{Translation}->{'Last changed'} = 'Ultima modificare';
    $Self->{Translation}->{'Last changed by'} = 'Modificat ultima dată de';

    # Template: CustomerITSMConfigItem
    $Self->{Translation}->{'Your ConfigItems'} = 'Elementele de configurare';

    # Template: CustomerITSMConfigItemSearch
    $Self->{Translation}->{'ConfigItem Search'} = 'Căutare ConfigItem';

    # Template: AdminACL
    $Self->{Translation}->{'Object Type'} = 'Tip de obiect';

    # JS Template: ClassImportConfirm
    $Self->{Translation}->{'The following classes will be imported'} = 'Se vor importa următoarele clase';
    $Self->{Translation}->{'The following roles will be imported'} = 'Următoarele roluri vor fi importate';
    $Self->{Translation}->{'Note that also corresponding dynamic fields and GeneralCatalog classes will be created and there is no automatic removal.'} =
        'Rețineți că vor fi create și câmpurile dinamice corespunzătoare și clasele GeneralCatalog și că nu există o eliminare automată.';
    $Self->{Translation}->{'Do you want to proceed?'} = 'Vreți să continuați?';

    # Perl Module: Kernel/Modules/AdminITSMConfigItem.pm
    $Self->{Translation}->{'Need ExampleClasses!'} = 'Aveți nevoie de ExampleClasses!';
    $Self->{Translation}->{'Definition is no valid YAML hash.'} = 'Definiția nu este un hash YAML valid.';

    # Perl Module: Kernel/Modules/AgentITSMConfigItem.pm
    $Self->{Translation}->{'Overview: ITSM ConfigItem'} = 'Prezentare generală: ITSM ConfigItem';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemBulk.pm
    $Self->{Translation}->{'No ConfigItemID is given!'} = 'Nu este dat niciun ConfigItemID!';
    $Self->{Translation}->{'You need at least one selected Configuration Item!'} = 'Aveți nevoie de cel puțin un element de configurare selectat!';
    $Self->{Translation}->{'You don\'t have write access to this configuration item: %s.'} =
        'Nu aveți acces de scriere la acest element de configurare: %s.';
    $Self->{Translation}->{'No definition was defined for class %s!'} = 'Nu a fost definită nicio definiție pentru clasa %s!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemDelete.pm
    $Self->{Translation}->{'Config item "%s" not found in database!'} = 'Elementul de configurare "%s" nu se găsește în baza de date!';
    $Self->{Translation}->{'Was not able to delete the configitem ID %s!'} = 'Nu a fost posibilă ștergerea configitemului ID %s!';
    $Self->{Translation}->{'No version found for ConfigItemID %s!'} = 'Nu s-a găsit nicio versiune pentru ConfigItemID %s!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemEdit.pm
    $Self->{Translation}->{'No ConfigItemID, DuplicateID or ClassID is given!'} = 'Nu este indicat niciun ConfigItemID, DuplicateID sau ClassID!';
    $Self->{Translation}->{'No access is given!'} = 'Nu se oferă acces!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemHistory.pm
    $Self->{Translation}->{'Can\'t show history, no ConfigItemID is given!'} = 'Nu se poate afișa istoricul, nu este dat niciun ConfigItemID!';
    $Self->{Translation}->{'Can\'t show history, no access rights given!'} = 'Nu se poate afișa istoricul, nu se acordă drepturi de acces!';
    $Self->{Translation}->{'New ConfigItem (ID=%s)'} = 'Nou ConfigItem (ID=%s)';
    $Self->{Translation}->{'New version (ID=%s)'} = 'Versiune nouă (ID=%s)';
    $Self->{Translation}->{'Deployment state updated (new=%s, old=%s)'} = 'Starea de implementare actualizată (new=%s, old=%s)';
    $Self->{Translation}->{'Incident state updated (new=%s, old=%s)'} = 'Starea incidentului a fost actualizată (new=%s, old=%s)';
    $Self->{Translation}->{'ConfigItem (ID=%s) deleted'} = 'ConfigItem (ID=%s) șters';
    $Self->{Translation}->{'Link to %s (type=%s) added'} = 'Link către %s (tip=%s) adăugat';
    $Self->{Translation}->{'Link to %s (type=%s) deleted'} = 'Link către %s (tip=%s) șters';
    $Self->{Translation}->{'ConfigItem definition updated (ID=%s)'} = 'Definiție ConfigItem actualizată (ID=%s)';
    $Self->{Translation}->{'Name updated (new=%s, old=%s)'} = 'Nume actualizat (nou=%s, vechi=%s)';
    $Self->{Translation}->{'Attribute %s updated from "%s" to "%s"'} = 'Atributul %s a fost actualizat de la "%s" la "%s"';
    $Self->{Translation}->{'Version %s deleted'} = 'Versiunea %s ștearsă';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemPrint.pm
    $Self->{Translation}->{'No ConfigItemID or VersionID is given!'} = 'Nu este indicat niciun ConfigItemID sau VersionID!';
    $Self->{Translation}->{'Can\'t show config item, no access rights given!'} = 'Nu se poate afișa elementul de configurare, nu sunt acordate drepturi de acces!';
    $Self->{Translation}->{'ConfigItemID %s not found in database!'} = 'ConfigItemID %s nu a fost găsit în baza de date!';
    $Self->{Translation}->{'ConfigItem'} = 'ConfigItem';
    $Self->{Translation}->{'printed by %s at %s'} = 'tipărit de %s la %s';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemSearch.pm
    $Self->{Translation}->{'Invalid ClassID!'} = 'ClassID invalid!';
    $Self->{Translation}->{'No ClassID is given!'} = 'Nu este dat niciun ClassID!';
    $Self->{Translation}->{'No access rights for this class given!'} = 'Nu se acordă drepturi de acces pentru această clasă!';
    $Self->{Translation}->{'No Result!'} = 'Nici un rezultat!';
    $Self->{Translation}->{'Config Item Search Results'} = 'Rezultatele căutării elementelor de configurare';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemZoom.pm
    $Self->{Translation}->{'Can\'t show item, no access rights for ConfigItem are given!'} =
        'Nu se poate afișa elementul, nu sunt acordate drepturi de acces pentru ConfigItem!';
    $Self->{Translation}->{'ConfigItem not found!'} = 'ConfigItem nu a fost găsit!';
    $Self->{Translation}->{'No versions found!'} = 'Nu s-au găsit versiuni!';
    $Self->{Translation}->{'operational'} = 'operațional';
    $Self->{Translation}->{'warning'} = 'avertizare';
    $Self->{Translation}->{'incident'} = 'incident';
    $Self->{Translation}->{'The deployment state of this config item'} = 'Starea de desfășurare a acestui element de configurare';
    $Self->{Translation}->{'The incident state of this config item'} = 'Starea incidentă a acestui element de configurare';

    # Perl Module: Kernel/Modules/CustomerITSMConfigItemSearch.pm
    $Self->{Translation}->{'No permission'} = 'Nu ai permisiuni.';
    $Self->{Translation}->{'Filter invalid!'} = 'Filtru invalid!';
    $Self->{Translation}->{'Search params invalid!'} = 'Search params invalid!';

    # Perl Module: Kernel/Output/HTML/Dashboard/ITSMConfigItemGeneric.pm
    $Self->{Translation}->{'Shown config items'} = 'Elemente de configurare afișate';
    $Self->{Translation}->{'Deployment State Type'} = 'Tip de stat de desfășurare';
    $Self->{Translation}->{'Current Incident State Type'} = 'Tipul de stat al incidentului curent';

    # Perl Module: Kernel/Output/HTML/ITSMConfigItem/LayoutDate.pm
    $Self->{Translation}->{'Between'} = 'Între';

    # Perl Module: Kernel/System/DynamicField/Driver/ConfigItem.pm
    $Self->{Translation}->{'Class restrictions for the config item'} = 'Restricții de clasă pentru elementul de configurare';
    $Self->{Translation}->{'Select one or more classes to restrict selectable config items'} =
        'Selectați una sau mai multe clase pentru a restricționa elementele de configurare selectabile';
    $Self->{Translation}->{'Link type'} = 'Tipul de legătură';
    $Self->{Translation}->{'Select the link type.'} = 'Selectați tipul de legătură.';
    $Self->{Translation}->{'Forwards: Referencing (Source) -> Referenced (Target)'} = 'Atacanți: Referință (Sursă) -> Referință (Țintă)';
    $Self->{Translation}->{'Backwards: Referenced (Source) -> Referencing (Target)'} = 'Înapoi: Referință (Sursă) -> Referință (Țintă)';
    $Self->{Translation}->{'Link Direction'} = 'Direcția legăturii';
    $Self->{Translation}->{'The referencing object is the one containing this dynamic field, the referenced object is the one selected as value of the dynamic field.'} =
        'Obiectul de referință este cel care conține acest câmp dinamic, iar obiectul referit este cel selectat ca valoare a câmpului dinamic.';
    $Self->{Translation}->{'Dynamic (ConfigItem)'} = 'Dinamic (ConfigItem)';
    $Self->{Translation}->{'Static (Version)'} = 'Static (Versiune)';
    $Self->{Translation}->{'Link Referencing Type'} = 'Tipul de referință a legăturii';
    $Self->{Translation}->{'Whether this link applies to the ConfigItem or the static version of the referencing object. Current Incident State calculation only is performed on dynamic links.'} =
        'Dacă această legătură se aplică la ConfigItem sau la versiunea statică a obiectului de referință. Calculul "Current Incident State" se efectuează numai în cazul legăturilor dinamice.';
    $Self->{Translation}->{'Select the attribute which config items will be searched by'} = 'Selectați atributul după care vor fi căutate elementele de configurare';

    # Perl Module: Kernel/System/ITSMConfigItem/Definition.pm
    $Self->{Translation}->{'Starting the YAML string with \'---\' is required.'} = 'Este necesar ca șirul YAML să înceapă cu "---".';

    # Perl Module: Kernel/System/ITSMConfigItem/Link.pm
    $Self->{Translation}->{'Could not purge the table configitem_link.'} = 'Nu s-a putut curăța tabelul configitem_link.';
    $Self->{Translation}->{'No relevant dynamic fields were found'} = 'Nu au fost găsite câmpuri dinamice relevante';
    $Self->{Translation}->{'Could not insert into the table configitem_link'} = 'Nu s-a putut insera în tabelul configitem_link';
    $Self->{Translation}->{'Inserted 0 rows into the table configitem_link'} = 'Inserate 0 rânduri în tabelul configitem_link';

    # Perl Module: Kernel/System/ImportExport/ObjectBackend/ITSMConfigItem.pm
    $Self->{Translation}->{'Maximum number of one element'} = 'Numărul maxim al unui element';
    $Self->{Translation}->{'Empty fields indicate that the current values are kept'} = 'Câmpurile goale indică faptul că se păstrează valorile curente.';
    $Self->{Translation}->{'Skipped'} = 'Sărit';

    # Perl Module: Kernel/Modules/AdminDynamicField.pm
    $Self->{Translation}->{'Error synchronizing the definitions. Please check the log.'} = 'Eroare de sincronizare a definițiilor. Vă rugăm să verificați jurnalul.';
    $Self->{Translation}->{'You have ITSMConfigItem definitions which are not synchronized. Please deploy your ITSMConfigItem dynamic field changes.'} =
        'Aveți definiții ITSMConfigItem care nu sunt sincronizate. Vă rugăm să implementați modificările câmpurilor dinamice ale ITSMConfigItem.';

    # Database XML / SOPM Definition: ITSMConfigurationManagement.sopm
    $Self->{Translation}->{'Expired'} = 'Expirat';
    $Self->{Translation}->{'Maintenance'} = 'Întreținere';
    $Self->{Translation}->{'Pilot'} = 'Pilot';
    $Self->{Translation}->{'Planned'} = 'Planificat';
    $Self->{Translation}->{'Repair'} = 'Reparații';
    $Self->{Translation}->{'Retired'} = 'Pensionat';
    $Self->{Translation}->{'Review'} = 'Revizuire';
    $Self->{Translation}->{'Test/QA'} = 'Testare/QA';

    # JS File: ITSM.Admin.ITSMConfigItem
    $Self->{Translation}->{'Overview and Confirmation'} = 'Prezentare generală și confirmare';
    $Self->{Translation}->{'Importing classes/roles and their related fields'} = '';
    $Self->{Translation}->{'An error occurred during class import.'} = 'S-a produs o eroare în timpul importului clasei.';

    # SysConfig
    $Self->{Translation}->{'0 - Hidden'} = '0 - Ascuns';
    $Self->{Translation}->{'1 - Shown'} = '1 - Afișat';
    $Self->{Translation}->{'Allows extended search conditions in config item search of the agent interface. With this feature you can search e. g. config item name with this kind of conditions like "(*key1*&&*key2*)" or "(*key1*||*key2*)".'} =
        'Permite condiții de căutare extinse în căutarea elementelor de configurare din interfața agentului. Cu această funcție puteți căuta, de exemplu, numele elementului de configurare cu acest tip de condiții, cum ar fi "(*key1*&&&*key2*)" sau "(*key1*|||*key2*)".';
    $Self->{Translation}->{'Allows extended search conditions in config item search of the customer interface. With this feature you can search e. g. config item name with this kind of conditions like "(*key1*&&*key2*)" or "(*key1*||*key2*)".'} =
        'Permite condiții de căutare extinse în căutarea elementelor de configurare din interfața cu clienții. Cu această funcție puteți căuta, de exemplu, numele elementului de configurare cu acest tip de condiții, cum ar fi "(*key1*&&&*key2*)" sau "(*key1*|||*key2*)".';
    $Self->{Translation}->{'Assigned CIs'} = 'IC atribuite';
    $Self->{Translation}->{'CIs assigned to customer company'} = 'IC atribuite societății client';
    $Self->{Translation}->{'CIs assigned to customer user'} = 'IC atribuite utilizatorului client';
    $Self->{Translation}->{'CMDB Settings'} = 'Setări CMDB';
    $Self->{Translation}->{'Check for a unique name only within the same ConfigItem class (\'class\') or globally (\'global\'), which means every existing ConfigItem is taken into account when looking for duplicates.'} =
        'Verifică un nume unic numai în cadrul aceleiași clase de ConfigItem ("class") sau la nivel global ("global"), ceea ce înseamnă că fiecare ConfigItem existent este luat în considerare atunci când se caută duplicate.';
    $Self->{Translation}->{'Choose a module to enforce a naming scheme.'} = 'Alegeți un modul pentru a impune o schemă de denumire.';
    $Self->{Translation}->{'Choose a module to enforce a number scheme.'} = 'Alegeți un modul pentru a aplica o schemă de numere.';
    $Self->{Translation}->{'Choose a module to enforce a version string scheme.'} = 'Alegeți un modul pentru a aplica o schemă de șiruri de versiuni.';
    $Self->{Translation}->{'Choose attributes to trigger the creation of a new version.'} = 'Alegeți atributele pentru a declanșa crearea unei noi versiuni.';
    $Self->{Translation}->{'Choose categories to assign to this config item class.'} = 'Alegeți categoriile pe care să le atribuiți acestei clase de elemente de configurare.';
    $Self->{Translation}->{'Column config item filters for ConfigItem Overview.'} = 'Filtre de coloană pentru elementele de configurare pentru ConfigItem Overview.';
    $Self->{Translation}->{'Columns that can be filtered in the config item overview of the agent interface. Note: Only Config Item attributes and Dynamic Fields (DynamicField_NameX) are allowed.'} =
        'Coloane care pot fi filtrate în prezentarea generală a elementelor de configurare din interfața agentului. Notă: Sunt permise numai atributele elementelor de configurare și câmpurile dinamice (DynamicField_NameX).';
    $Self->{Translation}->{'Columns that can be filtered in the config item overview of the customer interface. Note: Only Config Item attributes and Dynamic Fields (DynamicField_NameX) are allowed.'} =
        'Coloane care pot fi filtrate în prezentarea generală a elementelor de configurare din interfața cu clienții. Notă: Sunt permise numai atributele elementelor de configurare și câmpurile dinamice (DynamicField_NameX).';
    $Self->{Translation}->{'Columns that can be filtered in the config item search result overview of the agent interface. Note: Only Config Item attributes and Dynamic Fields (DynamicField_NameX) are allowed.'} =
        '';
    $Self->{Translation}->{'Config Items'} = 'Elemente de configurare';
    $Self->{Translation}->{'Config item add.'} = 'Adăugare element de configurare.';
    $Self->{Translation}->{'Config item edit.'} = 'Editare element de configurare.';
    $Self->{Translation}->{'Config item event module that enables logging to history in the agent interface.'} =
        'Modulul de evenimente al elementului de configurare care permite înregistrarea în istoric în interfața agentului.';
    $Self->{Translation}->{'Config item event module that updates config items to their current definition.'} =
        'Modul de eveniment al elementelor de configurare care actualizează elementele de configurare la definiția lor curentă.';
    $Self->{Translation}->{'Config item event module that updates the table configitem_ĺink.'} =
        'Modulul de evenimente pentru elemente de configurare care actualizează tabelul configitem_ĺink.';
    $Self->{Translation}->{'Config item event module updates the current incident state.'} =
        'Modulul de eveniment al elementelor de configurare actualizează starea curentă a incidentului.';
    $Self->{Translation}->{'Config item history.'} = 'Istoricul elementelor de configurare.';
    $Self->{Translation}->{'Config item print.'} = 'Imprimare element de configurare.';
    $Self->{Translation}->{'Config item zoom.'} = 'Configurați zoomul elementului.';
    $Self->{Translation}->{'ConfigItem Tree View'} = 'ConfigItem Tree View';
    $Self->{Translation}->{'ConfigItem Version'} = 'Versiunea ConfigItem';
    $Self->{Translation}->{'ConfigItems of the following classes will not be stored on the Elasticsearch server. To apply this to existing CIs, the CI migration has to be run via console, after changing this option.'} =
        'ConfigItems din următoarele clase nu vor fi stocate pe serverul Elasticsearch. Pentru a aplica acest lucru la IC-urile existente, migrarea IC-urilor trebuie să fie executată prin intermediul consolei, după modificarea acestei opțiuni.';
    $Self->{Translation}->{'ConfigItems with the following deployment states will not be stored on the Elasticsearch server. To apply this to existing CIs, the CI migration has to be run via console, after changing this option.'} =
        'ConfigItems cu următoarele stări de implementare nu vor fi stocate pe serverul Elasticsearch. Pentru a aplica acest lucru la IC-urile existente, migrarea IC-urilor trebuie să fie executată prin intermediul consolei, după modificarea acestei opțiuni.';
    $Self->{Translation}->{'Configuration Item Limit'} = 'Configurație Element limită';
    $Self->{Translation}->{'Configuration Item limit per page.'} = 'Configurație Limita de elemente pe pagină.';
    $Self->{Translation}->{'Configuration Management Database.'} = 'Baza de date de gestionare a configurației.';
    $Self->{Translation}->{'Configuration item bulk module.'} = 'Element de configurare modul bulk.';
    $Self->{Translation}->{'Configuration item search backend router of the agent interface.'} =
        'Elementul de configurare căutare router backend al interfeței agentului.';
    $Self->{Translation}->{'Create and manage the definitions for Configuration Items.'} = 'Creați și gestionați definițiile pentru elementele de configurare.';
    $Self->{Translation}->{'Customers can see historic CI versions.'} = 'Clienții pot vedea versiunile istorice ale CI.';
    $Self->{Translation}->{'Customers have the possibility to manually switch between historic CI versions.'} =
        'Clienții au posibilitatea de a comuta manual între versiunile istorice CI.';
    $Self->{Translation}->{'Default data to use on attribute for config item search screen. Example: "ITSMConfigItemCreateTimePointFormat=year;ITSMConfigItemCreateTimePointStart=Last;ITSMConfigItemCreateTimePoint=2;".'} =
        'Date implicite care trebuie utilizate în atributul pentru ecranul de căutare a elementelor de configurare. Exemplu: "ITSMConfigItemCreateTimePointFormat=year;ITSMConfigItemCreateTimePointStart=Last;ITSMConfigItemCreateTimePoint=2;".';
    $Self->{Translation}->{'Default data to use on attribute for config item search screen. Example: "ITSMConfigItemCreateTimeStartYear=2010;ITSMConfigItemCreateTimeStartMonth=10;ITSMConfigItemCreateTimeStartDay=4;ITSMConfigItemCreateTimeStopYear=2010;ITSMConfigItemCreateTimeStopMonth=11;ITSMConfigItemCreateTimeStopDay=3;".'} =
        'Date implicite care trebuie utilizate în atributul pentru ecranul de căutare a elementelor de configurare. Exemplu: "ITSMConfigItemCreateTimeStartYear=2010;ITSMConfigItemCreateTimeStartMonth=10;ITSMConfigItemCreateTimeStartDay=4;ITSMConfigItemCreateTimeStopYear=2010;ITSMConfigItemCreateTimeStopMonth=11;ITSMConfigItemCreateTimeStopDay=3;".';
    $Self->{Translation}->{'Define Actions where a settings button is available in the linked objects widget (LinkObject::ViewMode = "complex"). Please note that these Actions must have registered the following JS and CSS files: Core.AllocationList.css, Core.UI.AllocationList.js, Core.UI.Table.Sort.js, Core.Agent.TableFilters.js and Core.Agent.LinkObject.js.'} =
        'Definiți acțiunile în care este disponibil un buton de setări în widgetul obiectelor legate (LinkObject::ViewMode = "complex"). Rețineți că aceste acțiuni trebuie să aibă înregistrate următoarele fișiere JS și CSS: Core.AllocationList.css, Core.UI.AllocationList.js, Core.UI.Table.Sort.js, Core.Agent.TableFilters.js și Core.Agent.LinkObject.js.';
    $Self->{Translation}->{'Define a Template::Toolkit scheme for version strings. Only used if Version String Module is set to TemplateToolkit.'} =
        'Definiți o schemă Template::Toolkit pentru șirurile de versiuni. Se utilizează numai dacă modulul de șiruri de versiuni este setat la TemplateToolkit.';
    $Self->{Translation}->{'Define a set of conditions under which a customer is allowed to see a config item. Conditions can optionally be restricted to certain customer groups. Name is the only mandatory attribute. If no other options are given, all config items will be visible under that category.'} =
        'Definiți un set de condiții în care un client are voie să vadă un element de configurare. Condițiile pot fi opțional restricționate la anumite grupuri de clienți. Numele este singurul atribut obligatoriu. Dacă nu se oferă alte opțiuni, toate elementele de configurare vor fi vizibile în categoria respectivă.';
    $Self->{Translation}->{'Defines Required permissions to create ITSM configuration items using the Generic Interface.'} =
        'Definește permisiunile necesare pentru a crea elemente de configurare ITSM utilizând interfața generică.';
    $Self->{Translation}->{'Defines Required permissions to delete ITSM configuration items using the Generic Interface.'} =
        'Definește permisiunile necesare pentru a șterge elementele de configurare ITSM utilizând interfața generică.';
    $Self->{Translation}->{'Defines Required permissions to get ITSM configuration items using the Generic Interface.'} =
        'Definește permisiunile necesare pentru a obține elemente de configurare ITSM utilizând interfața generică.';
    $Self->{Translation}->{'Defines Required permissions to search ITSM configuration items using the Generic Interface.'} =
        'Definește permisiunile necesare pentru a căuta elemente de configurare ITSM utilizând interfața generică.';
    $Self->{Translation}->{'Defines Required permissions to update ITSM configuration items using the Generic Interface.'} =
        'Definește permisiunile necesare pentru actualizarea elementelor de configurare ITSM utilizând interfața generică.';
    $Self->{Translation}->{'Defines an overview module to show the small view of a configuration item list.'} =
        'Definește un modul de prezentare generală pentru a afișa vizualizarea mică a unei liste de elemente de configurare.';
    $Self->{Translation}->{'Defines if the link type labels must be shown in the node connections.'} =
        'Definește dacă etichetele tipului de legătură trebuie să fie afișate în conexiunile nodurilor.';
    $Self->{Translation}->{'Defines regular expressions individually for each ConfigItem class to check the ConfigItem name and to show corresponding error messages.'} =
        'Definește expresii regulate individual pentru fiecare clasă ConfigItem pentru a verifica numele ConfigItem și pentru a afișa mesajele de eroare corespunzătoare.';
    $Self->{Translation}->{'Defines the available columns of CIs in the config item overview depending on the CI class. Each entry must consist of a class name and an array of available fields for the corresponding class. Dynamic field entries have to honor the scheme DynamicField_FieldName.'} =
        'Definește coloanele disponibile pentru IC în prezentarea generală a elementelor de configurare în funcție de clasa IC. Fiecare intrare trebuie să fie compusă dintr-un nume de clasă și o matrice de câmpuri disponibile pentru clasa corespunzătoare. Intrările de câmpuri dinamice trebuie să respecte schema DynamicField_FieldName.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of the agent interface.'} =
        'Definește atributul implicit al elementului de configurare pentru sortarea elementelor de configurare din rezultatul căutării elementelor de configurare din interfața agentului.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of the customer interface.'} =
        'Definește atributul implicit al elementului de configurare pentru sortarea elementelor de configurare din rezultatul căutării elementelor de configurare din interfața cu clienții.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of this operation.'} =
        'Definește atributul implicit al elementului de configurare pentru sortarea elementului de configurare al rezultatului căutării elementelor de configurare din această operațiune.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the agent interface. Up: oldest on top. Down: latest on top.'} =
        'Definește ordinea implicită a elementelor de configurare în rezultatul căutării elementelor de configurare din interfața agentului. Sus: cel mai vechi în partea de sus. Jos: cel mai recent în partea de sus.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the customer interface. Up: oldest on top. Down: latest on top.'} =
        'Definește ordinea implicită a elementelor de configurare în rezultatul căutării elementelor de configurare din interfața cu clienții. Sus: cel mai vechi în partea de sus. Jos: cel mai recent în partea de sus.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the this operation. Up: oldest on top. Down: latest on top.'} =
        'Definește ordinea implicită a elementelor de configurare în rezultatul căutării elementelor de configurare din această operațiune. În sus: cel mai vechi în sus. Jos: cel mai recent în partea de sus.';
    $Self->{Translation}->{'Defines the default displayed columns of CIs in the config item overview depending on the CI class. Each entry must consist of a class name and an array of available fields for the corresponding class. Dynamic field entries have to honor the scheme DynamicField_FieldName.'} =
        'Definește coloanele afișate în mod implicit ale IC în prezentarea generală a elementelor de configurare în funcție de clasa IC. Fiecare intrare trebuie să fie compusă dintr-un nume de clasă și o matrice de câmpuri disponibile pentru clasa corespunzătoare. Intrările de câmpuri dinamice trebuie să respecte schema DynamicField_FieldName.';
    $Self->{Translation}->{'Defines the default relations depth to be shown.'} = 'Definește adâncimea implicită a relațiilor care urmează să fie afișate.';
    $Self->{Translation}->{'Defines the default shown config item search attribute for config item search screen.'} =
        'Definește atributul de căutare a elementelor de configurare afișat în mod implicit pentru ecranul de căutare a elementelor de configurare.';
    $Self->{Translation}->{'Defines the default shown config item search attribute for config item search screen. Example: "Key" must have the name of the Dynamic Field in this case \'X\', "Content" must have the value of the Dynamic Field depending on the Dynamic Field type,  Text: \'a text\', Dropdown: \'1\', Date/Time: \'Search_DynamicField_XTimeSlotStartYear=1974; Search_DynamicField_XTimeSlotStartMonth=01; Search_DynamicField_XTimeSlotStartDay=26; Search_DynamicField_XTimeSlotStartHour=00; Search_DynamicField_XTimeSlotStartMinute=00; Search_DynamicField_XTimeSlotStartSecond=00; Search_DynamicField_XTimeSlotStopYear=2013; Search_DynamicField_XTimeSlotStopMonth=01; Search_DynamicField_XTimeSlotStopDay=26; Search_DynamicField_XTimeSlotStopHour=23; Search_DynamicField_XTimeSlotStopMinute=59; Search_DynamicField_XTimeSlotStopSecond=59;\' and or \'Search_DynamicField_XTimePointFormat=week; Search_DynamicField_XTimePointStart=Before; Search_DynamicField_XTimePointValue=7\';.'} =
        'Definește atributul de căutare a elementelor de configurare afișat în mod implicit pentru ecranul de căutare a elementelor de configurare. Exemplu: "Key" trebuie să aibă numele câmpului dinamic, în acest caz "X", "Content" trebuie să aibă valoarea câmpului dinamic în funcție de tipul de câmp dinamic, Text: "a text", Dropdown: "1", Date/Time: "Search_DynamicField_XTimeSlotStartYear=1974; Search_DynamicField_XTimeSlotStartMonth=01; Search_DynamicField_XTimeSlotStartDay=26; Search_DynamicField_XTimeSlotStartHour=00; Search_DynamicField_XTimeSlotSlotStartMinute=00; Search_DynamicField_XTimeSlotSlotStartSecond=00; Search_DynamicField_XTimeSlotStopYear=2013; Search_DynamicField_XTimeSlotStopMonth=01; Search_DynamicField_XTimeSlotStopDay=26; Search_DynamicField_XTimeSlotStopHour=23; Search_DynamicField_XTimeSlotStopMinute=59; Search_DynamicField_XTimeSlotStopStopSecond=59;\' și sau \'Search_DynamicField_XTimePointFormat=week; Search_DynamicField_XTimePointStart=Before; Search_DynamicField_XTimePointValue=7\';.';
    $Self->{Translation}->{'Defines the default subobject of the class \'ITSMConfigItem\'.'} =
        'Definește subobiectul implicit al clasei "ITSMConfigItem".';
    $Self->{Translation}->{'Defines the number of rows for the CI definition editor in the admin interface.'} =
        'Definește numărul de rânduri pentru editorul de definiții CI din interfața de administrare.';
    $Self->{Translation}->{'Defines the order of incident states from high (e.g. cricital) to low (e.g. functional).'} =
        'Definește ordinea stărilor incidente de la mare (de exemplu, cricitală) la mică (de exemplu, funcțională).';
    $Self->{Translation}->{'Defines the relevant deployment states where linked tickets can affect the status of a CI.'} =
        'Definește stările de implementare relevante în care biletele legate pot afecta starea unui IC.';
    $Self->{Translation}->{'Defines the search limit for the AgentITSMConfigItem screen.'} =
        'Definește limita de căutare pentru ecranul AgentITSMConfigItem.';
    $Self->{Translation}->{'Defines the search limit for the AgentITSMConfigItemSearch screen.'} =
        'Definește limita de căutare pentru ecranul AgentITSMConfigItemSearch.';
    $Self->{Translation}->{'Defines the search limit for the CustomerITSMConfigItem screen.'} =
        'Definește limita de căutare pentru ecranul CustomerITSMConfigItem.';
    $Self->{Translation}->{'Defines the search limit for the CustomerITSMConfigItemSearch screen.'} =
        'Definește limita de căutare pentru ecranul CustomerITSMConfigItemSearch.';
    $Self->{Translation}->{'Defines the shown columns of CIs in the link table complex view for all CI classes. If there is no entry, then the default columns are shown.'} =
        'Definește coloanele afișate ale IC în vizualizarea complexă a tabelului de legături pentru toate clasele de IC. Dacă nu există nicio intrare, sunt afișate coloanele implicite.';
    $Self->{Translation}->{'Defines the shown columns of CIs in the link table complex view, depending on the CI class. Each entry must be prefixed with the class name and double colons (i.e. Computer::). There are a few CI-Attributes that common to all CIs (example for the class Computer: Computer::Name, Computer::CurDeplState, Computer::CreateTime). To show individual CI-Attributes as defined in the CI-Definition, the following scheme must be used (example for the class Computer): Computer::HardDisk::1, Computer::HardDisk::1::Capacity::1, Computer::HardDisk::2, Computer::HardDisk::2::Capacity::1. If there is no entry for a CI class, then the default columns are shown.'} =
        'Definește coloanele afișate ale IC în vizualizarea complexă a tabelului de legături, în funcție de clasa IC. Fiecare intrare trebuie să fie precedată de numele clasei și de două puncte de suspensie (de exemplu, Computer:::). Există câteva CI-Attributes care sunt comune tuturor IC-urilor (exemplu pentru clasa Computer: Computer::Name, Computer::CurDeplState, Computer::CreateTime). Pentru a afișa atributele individuale ale IC, astfel cum sunt definite în definiția IC, trebuie utilizată următoarea schemă (exemplu pentru clasa Computer): Computer::HardDisk::1, Computer::HardDisk::1::Capacity::1, Computer::HardDisk::2, Computer::HardDisk::2::Capacity::1. Dacă nu există nicio intrare pentru o clasă de IC, sunt afișate coloanele implicite.';
    $Self->{Translation}->{'Defines which items are available for \'Action\' in third level of the ITSM Config Item ACL structure.'} =
        'Definește elementele care sunt disponibile pentru "Acțiune" în al treilea nivel al structurii ITSM Config Item ACL.';
    $Self->{Translation}->{'Defines which items are available in first level of the ITSM Config Item ACL structure.'} =
        'Definește ce elemente sunt disponibile în primul nivel al structurii ITSM Config Item ACL.';
    $Self->{Translation}->{'Defines which items are available in second level of the ITSM Config Item ACL structure.'} =
        'Definește ce elemente sunt disponibile în al doilea nivel al structurii ITSM Config Item ACL.';
    $Self->{Translation}->{'Defines which type of link (named from the ticket perspective) can affect the status of a linked CI.'} =
        'Definește ce tip de legătură (numită din perspectiva biletului) poate afecta starea unui IC legat.';
    $Self->{Translation}->{'Defines which type of ticket can affect the status of a linked CI.'} =
        'Definește ce tip de tichet poate afecta starea unui IC legat.';
    $Self->{Translation}->{'Definition Update'} = 'Actualizare definiție';
    $Self->{Translation}->{'Delete Configuration Item'} = 'Ștergerea elementului de configurare';
    $Self->{Translation}->{'DeplState'} = 'DeplState';
    $Self->{Translation}->{'Deployment State Color'} = 'Culoarea stării de desfășurare';
    $Self->{Translation}->{'DeploymentState'} = 'DeploymentState';
    $Self->{Translation}->{'Duplicate'} = 'Duplicat';
    $Self->{Translation}->{'Dynamic field event module that marks config item definitions as out of sync, if containing dynamic fields change.'} =
        'Modul de eveniment pentru câmpuri dinamice care marchează definițiile elementelor de configurare ca fiind nesincronizate, dacă se modifică câmpurile dinamice care le conțin.';
    $Self->{Translation}->{'Dynamic fields shown in the additional ITSM field screen of the agent interface.'} =
        'Câmpuri dinamice afișate în ecranul câmpului ITSM suplimentar din interfața agentului.';
    $Self->{Translation}->{'Dynamic fields shown in the config item overview screen of the customer interface.'} =
        'Câmpuri dinamice afișate în ecranul de prezentare generală a elementelor de configurare din interfața cu clienții.';
    $Self->{Translation}->{'Dynamic fields shown in the config item search screen of the agent interface.'} =
        'Câmpuri dinamice afișate în ecranul de căutare a elementelor de configurare din interfața agentului.';
    $Self->{Translation}->{'Enables configuration item bulk action feature for the agent frontend to work on more than one configuration item at a time.'} =
        'Activează caracteristica de acțiune în masă a elementelor de configurare pentru ca frontend-ul agentului să lucreze la mai mult de un element de configurare odată.';
    $Self->{Translation}->{'Enables configuration item bulk action feature only for the listed groups.'} =
        'Activează funcția de acțiune în bloc a elementelor de configurare numai pentru grupurile enumerate.';
    $Self->{Translation}->{'Enables/disables the functionality to check ITSM onfiguration items for unique names. Before enabling this option you should check your system for already existing config items with duplicate names. You can do this with the console command Admin::ITSM::Configitem::ListDuplicates.'} =
        'Activează/dezactivează funcționalitatea de verificare a elementelor de onfigurare ITSM pentru nume unice. Înainte de a activa această opțiune, ar trebui să verificați dacă există deja elemente de configurare cu nume duplicate în sistem. Puteți face acest lucru cu ajutorul comenzii de consolă Admin::ITSM::Configitem::ListDuplicates.';
    $Self->{Translation}->{'Event module to set configitem-status on ticket-configitem-link.'} =
        'Modulul de eveniment pentru a seta starea articolului de configurare pe biletul-configitem-link.';
    $Self->{Translation}->{'Fields of the configuration item index, used for the fulltext search. Fields are also stored, but are not mandatory for the overall functionality. Inclusion of attachments can be disabled by setting the entry to 0 or deleting it.'} =
        'Câmpuri ale indexului elementului de configurare, utilizate pentru căutarea fulltext. Câmpurile sunt, de asemenea, stocate, dar nu sunt obligatorii pentru funcționalitatea generală. Includerea atașamentelor poate fi dezactivată prin setarea intrării la 0 sau prin ștergerea acesteia.';
    $Self->{Translation}->{'Fields stored in the configuration item index which are used for other things besides fulltext searches. For the complete functionality all fields are mandatory.'} =
        'Câmpuri stocate în indexul elementului de configurare care sunt utilizate pentru alte scopuri în afară de căutările fulltext. Pentru o funcționalitate completă, toate câmpurile sunt obligatorii.';
    $Self->{Translation}->{'For every webservice (key) an array of classes (value) can be defined on which the import is restricted. For all chosen classes, or all existing classes the identifying attributes will have to be chosen in the invoker config.'} =
        'Pentru fiecare serviciu web (cheie) se poate defini o serie de clase (valoare) pentru care se limitează importul. Pentru toate clasele alese sau pentru toate clasele existente, atributele de identificare vor trebui să fie alese în configurația invocatorului.';
    $Self->{Translation}->{'GenericInterface module registration for the ConfigItemFetch invoker layer.'} =
        'Înregistrarea modulului GenericInterface pentru stratul de invocare ConfigItemFetch.';
    $Self->{Translation}->{'ITSM ConfigItem'} = 'ITSM ConfigItem';
    $Self->{Translation}->{'ITSM config item overview.'} = 'Prezentare generală a elementelor de configurare ITSM.';
    $Self->{Translation}->{'InciState'} = 'InciState';
    $Self->{Translation}->{'IncidentState'} = 'IncidentState';
    $Self->{Translation}->{'Includes deployment states in the config item search of the customer interface.'} =
        'Include stările de implementare în căutarea elementelor de configurare din interfața cu clienții.';
    $Self->{Translation}->{'Includes incident states in the config item search of the customer interface.'} =
        'Include stările incidentelor în căutarea elementelor de configurare din interfața cu clienții.';
    $Self->{Translation}->{'Maximum number of config items to be displayed in the result of this operation.'} =
        'Numărul maxim de elemente de configurare care urmează să fie afișate în rezultatul acestei operațiuni.';
    $Self->{Translation}->{'Module to check the group responsible for a class.'} = 'Modul de verificare a grupului responsabil pentru o clasă.';
    $Self->{Translation}->{'Module to check the group responsible for a configuration item.'} =
        'Modul de verificare a grupului responsabil pentru un element de configurare.';
    $Self->{Translation}->{'Module to generate ITSM config item statistics.'} = 'Modul de generare a statisticilor elementelor de configurare ITSM.';
    $Self->{Translation}->{'Name Module'} = 'Denumire modul';
    $Self->{Translation}->{'Number Module'} = 'Număr Modulul de numere';
    $Self->{Translation}->{'Number of config items to be displayed in each page of a search result in the agent interface.'} =
        'Numărul de elemente de configurare care urmează să fie afișate în fiecare pagină a unui rezultat de căutare în interfața agentului.';
    $Self->{Translation}->{'Number of config items to be displayed in each page of a search result in the customer interface.'} =
        'Numărul de elemente de configurare care urmează să fie afișate pe fiecare pagină a unui rezultat de căutare în interfața cu clienții.';
    $Self->{Translation}->{'Objects to search for, how many entries and which attributs to show. ConfigItem attributes have to explicitly be stored via Elasticsearch.'} =
        'Obiectele care trebuie căutate, câte intrări și ce atribute trebuie afișate. Atributele ConfigItem trebuie să fie stocate în mod explicit prin Elasticsearch.';
    $Self->{Translation}->{'Overview.'} = 'Prezentare generală.';
    $Self->{Translation}->{'Parameters for the categories for config item classes in the preferences view of the agent interface.'} =
        'Parametrii pentru categoriile pentru clasele de elemente de configurare în vizualizarea preferințelor din interfața agentului.';
    $Self->{Translation}->{'Parameters for the column filters of the small config item overview. Please note: setting \'Active\' to 0 will only prevent agents from editing settings of this group in their personal preferences, but will still allow administrators to edit the settings of another user\'s behalf. Use \'PreferenceGroup\' to control in which area these settings should be shown in the user interface.'} =
        'Parametrii pentru filtrele de coloană din prezentarea generală a elementelor de configurare mici. Vă rugăm să rețineți: setarea "Active" la 0 va împiedica doar agenții să editeze setările acestui grup în preferințele lor personale, dar va permite în continuare administratorilor să editeze setările în numele unui alt utilizator. Utilizați "PreferenceGroup" pentru a controla în ce zonă trebuie afișate aceste setări în interfața cu utilizatorul.';
    $Self->{Translation}->{'Parameters for the dashboard backend of the customer company config item overview of the agent interface . "Limit" is the number of entries shown by default. "Group" is used to restrict the access to the plugin (e. g. Group: admin;group1;group2;). "Default" determines if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" is the cache time in minutes for the plugin.'} =
        'Parametrii pentru backend-ul tabloului de bord al firmei clientului configurare element de prezentare generală a interfeței agentului . "Limit" este numărul de intrări afișate în mod implicit. "Group" este utilizat pentru a restricționa accesul la plugin (de exemplu, Group: admin;group1;group2;). "Default" determină dacă plugin-ul este activat în mod implicit sau dacă utilizatorul trebuie să îl activeze manual. "CacheTTLLocal" este timpul de cache în minute pentru plugin.';
    $Self->{Translation}->{'Parameters for the deployment states color in the preferences view of the agent interface.'} =
        'Parametrii pentru culoarea stărilor de desfășurare în vizualizarea preferințelor din interfața agentului.';
    $Self->{Translation}->{'Parameters for the deployment states in the preferences view of the agent interface.'} =
        'Parametrii pentru stările de desfășurare din vizualizarea preferințelor din interfața agentului.';
    $Self->{Translation}->{'Parameters for the example permission groups of the general catalog attributes.'} =
        'Parametrii pentru grupurile de permisiuni de exemplu ale atributelor generale ale catalogului.';
    $Self->{Translation}->{'Parameters for the name module for config item classes in the preferences view of the agent interface.'} =
        'Parametrii pentru modulul de nume pentru clasele de elemente de configurare în vizualizarea preferințelor din interfața agentului.';
    $Self->{Translation}->{'Parameters for the number module for config item classes in the preferences view of the agent interface.'} =
        'Parametrii pentru modulul de numere pentru clasele de elemente de configurare în vizualizarea preferințelor din interfața agentului.';
    $Self->{Translation}->{'Parameters for the pages (in which the configuration items are shown).'} =
        'Parametrii pentru pagini (în care sunt afișate elementele de configurare).';
    $Self->{Translation}->{'Parameters for the version string module for config item classes in the preferences view of the agent interface.'} =
        'Parametrii pentru modulul de șiruri de versiuni pentru clasele de elemente de configurare în vizualizarea preferințelor din interfața agentului.';
    $Self->{Translation}->{'Parameters for the version string template toolkit module for config item classes in the preferences view of the agent interface.'} =
        'Parametrii pentru modulul setului de instrumente de șabloane de șiruri de versiuni pentru clasele de elemente de configurare în vizualizarea preferințelor din interfața agentului.';
    $Self->{Translation}->{'Parameters for the version trigger for config item classes in the preferences view of the agent interface.'} =
        'Parametrii pentru declanșarea versiunii pentru clasele de elemente de configurare în vizualizarea preferințelor din interfața agentului.';
    $Self->{Translation}->{'Performs the configured action for each event (as an Invoker) for each configured Webservice.'} =
        'Efectuează acțiunea configurată pentru fiecare eveniment (ca Invoker) pentru fiecare serviciu web configurat.';
    $Self->{Translation}->{'Permission Group'} = 'Drepturi Grup';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item attachment action in the agent interface.'} =
        'Permisiuni necesare pentru a utiliza acțiunea de atașare a elementului de configurare ITSM în interfața agentului.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item screen in the agent interface.'} =
        'Permisiuni necesare pentru a utiliza ecranul elementului de configurare ITSM din interfața agentului.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item search screen in the agent interface.'} =
        'Permisiuni necesare pentru a utiliza ecranul de căutare a elementelor de configurare ITSM în interfața agentului.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item search screen in the customer interface.'} =
        'Permisiuni necesare pentru a utiliza ecranul de căutare a elementelor de configurare ITSM în interfața cu clienții.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item tree view screen in the agent interface.'} =
        'Permisiuni necesare pentru a utiliza ecranul de vizualizare a arborelui de elemente de configurare ITSM în interfața agentului.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item zoom screen in the agent interface.'} =
        'Permisiuni necesare pentru a utiliza ecranul de mărire a elementelor de configurare ITSM în interfața agentului.';
    $Self->{Translation}->{'Required permissions to use the add ITSM configuration item screen in the agent interface.'} =
        'Permisiuni necesare pentru a utiliza ecranul de adăugare a unui element de configurare ITSM în interfața agentului.';
    $Self->{Translation}->{'Required permissions to use the bulk ITSM configuration item screen in the agent interface.'} =
        'Permisiuni necesare pentru a utiliza ecranul de elemente de configurare ITSM în masă din interfața agentului.';
    $Self->{Translation}->{'Required permissions to use the edit ITSM configuration item screen in the agent interface.'} =
        'Permisiuni necesare pentru a utiliza ecranul de editare a elementului de configurare ITSM din interfața agentului.';
    $Self->{Translation}->{'Required permissions to use the history ITSM configuration item screen in the agent interface.'} =
        'Permisiuni necesare pentru a utiliza ecranul cu elemente de configurare ITSM istoric în interfața agentului.';
    $Self->{Translation}->{'Required permissions to use the print ITSM configuration item screen in the agent interface.'} =
        'Permisiuni necesare pentru a utiliza ecranul de tipărire a elementelor de configurare ITSM din interfața agentului.';
    $Self->{Translation}->{'Required privileges to delete config items.'} = 'Privilegii necesare pentru a șterge elementele de configurare.';
    $Self->{Translation}->{'Search config items.'} = 'Căutarea elementelor de configurare.';
    $Self->{Translation}->{'Set the incident state of a CI automatically when a Ticket is Linked to a CI.'} =
        'Setați automat starea de incident a unui IC atunci când un bilet este legat de un IC.';
    $Self->{Translation}->{'Sets the deployment state in the configuration item bulk screen of the agent interface.'} =
        'Stabilește starea de desfășurare în ecranul de ansamblu al elementelor de configurare din interfața agentului.';
    $Self->{Translation}->{'Sets the incident state in the configuration item bulk screen of the agent interface.'} =
        'Stabilește starea incidentului în ecranul de ansamblu al elementelor de configurare din interfața agentului.';
    $Self->{Translation}->{'Shows a link in the menu that allows linking a configuration item with another object in the config item zoom view of the agent interface.'} =
        'Afișează o legătură în meniu care permite corelarea unui element de configurare cu un alt obiect în vizualizarea cu zoom a elementului de configurare din interfața agentului.';
    $Self->{Translation}->{'Shows a link in the menu to access the history of a configuration item in the configuration item overview of the agent interface.'} =
        'Afișează o legătură în meniu pentru a accesa istoricul unui element de configurare în prezentarea generală a elementelor de configurare din interfața agentului.';
    $Self->{Translation}->{'Shows a link in the menu to access the history of a configuration item in the its zoom view of the agent interface.'} =
        'Afișează o legătură în meniu pentru a accesa istoricul unui element de configurare în vizualizarea cu zoom a interfeței agentului.';
    $Self->{Translation}->{'Shows a link in the menu to delete a configuration item in its zoom view of the agent interface.'} =
        'Afișează o legătură în meniu pentru a șterge un element de configurare în vizualizarea sa cu zoom a interfeței agentului.';
    $Self->{Translation}->{'Shows a link in the menu to display the configuration item links as a Tree View.'} =
        'Afișează o legătură în meniu pentru a afișa legăturile elementelor de configurare sub formă de Tree View.';
    $Self->{Translation}->{'Shows a link in the menu to duplicate a configuration item in the configuration item overview of the agent interface.'} =
        'Afișează o legătură în meniu pentru a duplica un element de configurare în prezentarea generală a elementelor de configurare din interfața agentului.';
    $Self->{Translation}->{'Shows a link in the menu to duplicate a configuration item in the its zoom view of the agent interface.'} =
        'Afișează o legătură în meniu pentru a duplica un element de configurare în vizualizarea cu zoom a interfeței agentului.';
    $Self->{Translation}->{'Shows a link in the menu to edit a configuration item in the its zoom view of the agent interface.'} =
        'Afișează o legătură în meniu pentru a edita un element de configurare în vizualizarea cu zoom a interfeței agentului.';
    $Self->{Translation}->{'Shows a link in the menu to go back in the configuration item zoom view of the agent interface.'} =
        'Afișează o legătură în meniu pentru a reveni în vizualizarea cu zoom a elementelor de configurare din interfața agentului.';
    $Self->{Translation}->{'Shows a link in the menu to print a configuration item in the its zoom view of the agent interface.'} =
        'Afișează o legătură în meniu pentru a imprima un element de configurare în vizualizarea cu zoom a interfeței agentului.';
    $Self->{Translation}->{'Shows a link in the menu to zoom into a configuration item in the configuration item overview of the agent interface.'} =
        'Afișează o legătură în meniu pentru a mări un element de configurare în prezentarea generală a elementelor de configurare din interfața agentului.';
    $Self->{Translation}->{'Shows the config item history (reverse ordered) in the agent interface.'} =
        'Afișează istoricul elementelor de configurare (în ordine inversă) în interfața agentului.';
    $Self->{Translation}->{'The default category which is shown, if none is selected.'} = 'Categoria implicită care este afișată dacă nu este selectată niciuna.';
    $Self->{Translation}->{'The identifier for a configuration item, e.g. ConfigItem#, MyConfigItem#. The default is ConfigItem#.'} =
        'Identificatorul pentru un element de configurare, de exemplu ConfigItem#, MyConfigItem#. Valoarea implicită este ConfigItem#.';
    $Self->{Translation}->{'Triggers ConfigItemFetch invoker automatically.'} = 'Declanșează automat invocatorul ConfigItemFetch.';
    $Self->{Translation}->{'Version String Expression'} = 'Versiune Expresie șir de caractere';
    $Self->{Translation}->{'Version String Module'} = 'Versiune Șir de caractere Modul';
    $Self->{Translation}->{'Version Trigger'} = 'Versiune Trigger';
    $Self->{Translation}->{'Whether the execution of ConfigItemACL can be avoided by checking cached field dependencies. This can improve loading times of formulars, but has to be disabled, if ACLModules are to be used for ITSMConfigItem- and Form-ReturnTypes.'} =
        'Dacă execuția ConfigItemACL poate fi evitată prin verificarea dependențelor de câmpuri din memoria cache. Acest lucru poate îmbunătăți timpii de încărcare a formularelor, dar trebuie dezactivat dacă se utilizează ACLModules pentru ITSMConfigItem- și Form-ReturnTypes.';
    $Self->{Translation}->{'Which general information is shown in the header.'} = 'Ce informații generale sunt afișate în antet.';
    $Self->{Translation}->{'class'} = 'clasa';
    $Self->{Translation}->{'global'} = 'global';
    $Self->{Translation}->{'postproductive'} = 'postproductiv';
    $Self->{Translation}->{'preproductive'} = 'preproductivă';
    $Self->{Translation}->{'productive'} = 'productiv';


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

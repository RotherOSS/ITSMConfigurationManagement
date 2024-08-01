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

package Kernel::Language::pl_ITSMConfigurationManagement;

use strict;
use warnings;
use utf8;

sub Data {
    my $Self = shift;

    # Template: AdminITSMConfigItem
    $Self->{Translation}->{'Config Item Management'} = 'Zarządzanie CI';
    $Self->{Translation}->{'Change class definition'} = 'Zmień definicję klasy';
    $Self->{Translation}->{'Change role definition'} = 'Zmiana definicji roli';
    $Self->{Translation}->{'Ready2Import Class Bundles'} = 'Pakiety klas Ready2Import';
    $Self->{Translation}->{'Here you can import Ready2Import class bundles showcasing our most usual config items. Please note that some additional configuration may be required.'} =
        'Tutaj można importować pakiety klas Ready2Import prezentujące nasze najbardziej typowe elementy konfiguracji. Należy pamiętać, że może być wymagana dodatkowa konfiguracja.';
    $Self->{Translation}->{'Update existing entities'} = 'Aktualizacja istniejących podmiotów';
    $Self->{Translation}->{'Import Ready2Adopt class bundles'} = 'Importuj pakiety klas Ready2Adopt';
    $Self->{Translation}->{'Config Item Class'} = 'Klasa CI';
    $Self->{Translation}->{'Config Item Role'} = 'Rola elementu konfiguracji';

    # Template: AgentITSMConfigItemAdd
    $Self->{Translation}->{'Config Item'} = 'CI';
    $Self->{Translation}->{'Filter for Classes'} = 'Filtr dla klas';
    $Self->{Translation}->{'Select a Class from the list to create a new Config Item.'} = 'Zaznacz klasę na liście aby utworzyć nowe CI.';
    $Self->{Translation}->{'Class'} = 'Klasa';

    # Template: AgentITSMConfigItemBulk
    $Self->{Translation}->{'ITSM ConfigItem Bulk Action'} = 'Akcja grupowa na CI';
    $Self->{Translation}->{'Deployment state'} = 'Stan wdrożenia';
    $Self->{Translation}->{'Incident state'} = 'Stan zdarzenia';
    $Self->{Translation}->{'Link to another'} = 'Połącz z innym';
    $Self->{Translation}->{'Invalid Configuration Item number!'} = 'Nieprawidłowy numer CI!';
    $Self->{Translation}->{'The number of another Configuration Item to link with.'} = 'Numer innego elementu konfiguracji, z którym należy się połączyć.';

    # Template: AgentITSMConfigItemDelete
    $Self->{Translation}->{'Do you really want to delete this config item?'} = 'Czy naprawdę chcesz usunąć ten element konfiguracji?';

    # Template: AgentITSMConfigItemEdit
    $Self->{Translation}->{'The name of this config item'} = 'Nazwa tego CI';
    $Self->{Translation}->{'Name is already in use by the ConfigItems with the following Number(s): %s'} =
        'Nazwa jest już używana przez CI o następujących numerach: %s';
    $Self->{Translation}->{'Version Number'} = 'Wersja';
    $Self->{Translation}->{'Version number of this config item'} = 'Numer wersji tego elementu konfiguracji';
    $Self->{Translation}->{'Version Number is already in use by the ConfigItems with the following Number(s): %s'} =
        'Numer wersji jest już używany przez ConfigItems z następującym numerem (numerami): %s';
    $Self->{Translation}->{'Deployment State'} = 'Stan wdrożenia';
    $Self->{Translation}->{'Incident State'} = 'Stan zdarzenia';

    # Template: AgentITSMConfigItemHistory
    $Self->{Translation}->{'History of Config Item: %s'} = 'Historia elementu konfiguracji: %s';
    $Self->{Translation}->{'History Content'} = 'Zawartość historii';
    $Self->{Translation}->{'Createtime'} = 'Utworzone';
    $Self->{Translation}->{'Zoom view'} = 'Widok szczegółowy';

    # Template: AgentITSMConfigItemOverviewNavBar
    $Self->{Translation}->{'Config Items per page'} = 'Liczba CI na stronie';

    # Template: AgentITSMConfigItemOverviewSmall
    $Self->{Translation}->{'No config item data found.'} = 'Nie znaleziono danych elementu konfiguracji.';
    $Self->{Translation}->{'Select this config item'} = 'Wybierz ten element konfiguracji';

    # Template: AgentITSMConfigItemSearch
    $Self->{Translation}->{'Run Search'} = 'Uruchom wyszukiwanie';
    $Self->{Translation}->{'Also search in previous versions?'} = 'Uwzględnić poprzednie wersje?';

    # Template: AgentITSMConfigItemTreeView
    $Self->{Translation}->{'TreeView for ConfigItem'} = 'TreeView dla ConfigItem';
    $Self->{Translation}->{'Depth Level'} = 'Poziom głębokości';
    $Self->{Translation}->{'Zoom In/Out'} = 'Powiększanie/usuwanie';
    $Self->{Translation}->{'Max links level reached for ConfigItem!'} = 'Osiągnięto maksymalny poziom linków dla ConfigItem!';

    # Template: AgentITSMConfigItemZoom
    $Self->{Translation}->{'Configuration Item'} = 'CI';
    $Self->{Translation}->{'Configuration Item Information'} = 'Informacje o CI';
    $Self->{Translation}->{'Current Deployment State'} = 'Aktualny stan wdrożenia';
    $Self->{Translation}->{'Current Incident State'} = 'Aktualny stan';
    $Self->{Translation}->{'Last changed'} = 'Ostatnio zmienione';
    $Self->{Translation}->{'Last changed by'} = 'Ostatnio zmienione przez';

    # Template: CustomerITSMConfigItem
    $Self->{Translation}->{'Your ConfigItems'} = 'Elementy konfiguracji';

    # Template: CustomerITSMConfigItemSearch
    $Self->{Translation}->{'ConfigItem Search'} = 'Wyszukiwanie ConfigItem';

    # Template: AdminACL
    $Self->{Translation}->{'Object Type'} = 'Typ obiektu';

    # JS Template: ClassImportConfirm
    $Self->{Translation}->{'The following classes will be imported'} = 'Zaimportowane zostaną następujące klasy';
    $Self->{Translation}->{'The following roles will be imported'} = 'Zaimportowane zostaną następujące role';
    $Self->{Translation}->{'Note that also corresponding dynamic fields and GeneralCatalog classes will be created and there is no automatic removal.'} =
        'Należy pamiętać, że zostaną również utworzone odpowiednie pola dynamiczne i klasy GeneralCatalog, które nie zostaną automatycznie usunięte.';
    $Self->{Translation}->{'Do you want to proceed?'} = 'Czy chcesz kontynuować?';

    # Perl Module: Kernel/Modules/AdminITSMConfigItem.pm
    $Self->{Translation}->{'Need ExampleClasses!'} = 'Need ExampleClasses!';
    $Self->{Translation}->{'Definition is no valid YAML hash.'} = 'Definicja nie jest prawidłowym hashem YAML.';

    # Perl Module: Kernel/Modules/AgentITSMConfigItem.pm
    $Self->{Translation}->{'Overview: ITSM ConfigItem'} = 'Przegląd: ITSM ConfigItem';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemBulk.pm
    $Self->{Translation}->{'No ConfigItemID is given!'} = 'Nie podano identyfikatora ConfigItemID!';
    $Self->{Translation}->{'You need at least one selected Configuration Item!'} = 'Potrzebny jest co najmniej jeden wybrany element konfiguracji!';
    $Self->{Translation}->{'You don\'t have write access to this configuration item: %s.'} =
        'Nie masz dostępu do zapisu tego elementu konfiguracji: %s.';
    $Self->{Translation}->{'No definition was defined for class %s!'} = 'Nie zdefiniowano definicji dla klasy %s!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemDelete.pm
    $Self->{Translation}->{'Config item "%s" not found in database!'} = 'Element konfiguracji "%s" nie został znaleziony w bazie danych!';
    $Self->{Translation}->{'Was not able to delete the configitem ID %s!'} = 'Nie udało się usunąć elementu konfiguracji ID %s!';
    $Self->{Translation}->{'No version found for ConfigItemID %s!'} = 'Nie znaleziono wersji dla ConfigItemID %s!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemEdit.pm
    $Self->{Translation}->{'No ConfigItemID, DuplicateID or ClassID is given!'} = 'Nie podano identyfikatora ConfigItemID, DuplicateID ani ClassID!';
    $Self->{Translation}->{'No access is given!'} = 'Brak dostępu!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemHistory.pm
    $Self->{Translation}->{'Can\'t show history, no ConfigItemID is given!'} = 'Nie można wyświetlić historii, nie podano identyfikatora ConfigItemID!';
    $Self->{Translation}->{'Can\'t show history, no access rights given!'} = 'Nie można wyświetlić historii, nie podano praw dostępu!';
    $Self->{Translation}->{'New ConfigItem (ID=%s)'} = 'Nowy element konfiguracji (ID=%s)';
    $Self->{Translation}->{'New version (ID=%s)'} = 'Nowa wersja (ID=%s)';
    $Self->{Translation}->{'Deployment state updated (new=%s, old=%s)'} = 'Zaktualizowano stan wdrożenia (nowy=%s, stary=%s)';
    $Self->{Translation}->{'Incident state updated (new=%s, old=%s)'} = 'Zaktualizowano stan incydentu (nowy=%s, stary=%s)';
    $Self->{Translation}->{'ConfigItem (ID=%s) deleted'} = 'Usunięto ConfigItem (ID=%s)';
    $Self->{Translation}->{'Link to %s (type=%s) added'} = 'Dodano link do %s (type=%s)';
    $Self->{Translation}->{'Link to %s (type=%s) deleted'} = 'Link do %s (type=%s) usunięty';
    $Self->{Translation}->{'ConfigItem definition updated (ID=%s)'} = 'Zaktualizowano definicję ConfigItem (ID=%s)';
    $Self->{Translation}->{'Name updated (new=%s, old=%s)'} = 'Nazwa zaktualizowana (new=%s, old=%s)';
    $Self->{Translation}->{'Attribute %s updated from "%s" to "%s"'} = 'Atrybut %s zaktualizowany z "%s" do "%s"';
    $Self->{Translation}->{'Version %s deleted'} = 'Wersja %s usunięta';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemPrint.pm
    $Self->{Translation}->{'No ConfigItemID or VersionID is given!'} = 'Nie podano identyfikatora ConfigItemID lub VersionID!';
    $Self->{Translation}->{'Can\'t show config item, no access rights given!'} = 'Nie można wyświetlić elementu konfiguracji, nie podano praw dostępu!';
    $Self->{Translation}->{'ConfigItemID %s not found in database!'} = 'ConfigItemID %s nie został znaleziony w bazie danych!';
    $Self->{Translation}->{'ConfigItem'} = 'CI';
    $Self->{Translation}->{'printed by %s at %s'} = 'wydrukowany przez %s w %s';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemSearch.pm
    $Self->{Translation}->{'Invalid ClassID!'} = 'Nieprawidłowy identyfikator ClassID!';
    $Self->{Translation}->{'No ClassID is given!'} = 'Nie podano identyfikatora ClassID!';
    $Self->{Translation}->{'No access rights for this class given!'} = 'Nie przyznano praw dostępu dla tej klasy!';
    $Self->{Translation}->{'No Result!'} = 'Brak Wyników!';
    $Self->{Translation}->{'Config Item Search Results'} = 'Wyniki wyszukiwania pozycji konfiguracji';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemZoom.pm
    $Self->{Translation}->{'Can\'t show item, no access rights for ConfigItem are given!'} =
        'Nie można wyświetlić elementu, nie podano praw dostępu do ConfigItem!';
    $Self->{Translation}->{'ConfigItem not found!'} = 'Nie znaleziono elementu ConfigItem!';
    $Self->{Translation}->{'No versions found!'} = 'Nie znaleziono żadnych wersji!';
    $Self->{Translation}->{'operational'} = 'operacyjny';
    $Self->{Translation}->{'warning'} = 'ostrzeżenie';
    $Self->{Translation}->{'incident'} = 'incydent';
    $Self->{Translation}->{'The deployment state of this config item'} = 'Stan wdrożenia tego CI';
    $Self->{Translation}->{'The incident state of this config item'} = 'Stan zdarzenia tego CI';

    # Perl Module: Kernel/Modules/CustomerITSMConfigItemSearch.pm
    $Self->{Translation}->{'No permission'} = 'Brak uprawnień';
    $Self->{Translation}->{'Filter invalid!'} = 'Filtr nieprawidłowy!';
    $Self->{Translation}->{'Search params invalid!'} = 'Parametry wyszukiwania są nieprawidłowe!';

    # Perl Module: Kernel/Output/HTML/Dashboard/ITSMConfigItemGeneric.pm
    $Self->{Translation}->{'Shown config items'} = 'Wyświetlane elementy konfiguracji';
    $Self->{Translation}->{'Deployment State Type'} = 'Typ stanu wdrożenia';
    $Self->{Translation}->{'Current Incident State Type'} = 'Aktualny typ stanu';

    # Perl Module: Kernel/Output/HTML/ITSMConfigItem/LayoutDate.pm
    $Self->{Translation}->{'Between'} = 'Pomiędzy';

    # Perl Module: Kernel/System/DynamicField/Driver/ConfigItem.pm
    $Self->{Translation}->{'Class restrictions for the config item'} = 'Ograniczenia klasy dla elementu konfiguracji';
    $Self->{Translation}->{'Select one or more classes to restrict selectable config items'} =
        'Wybierz jedną lub więcej klas, aby ograniczyć wybierane elementy konfiguracji';
    $Self->{Translation}->{'Link type'} = 'Typ łącza';
    $Self->{Translation}->{'Select the link type.'} = 'Wybierz typ łącza.';
    $Self->{Translation}->{'Forwards: Referencing (Source) -> Referenced (Target)'} = 'Do przodu: Odniesienie (Źródło) -> Odniesienie (Cel)';
    $Self->{Translation}->{'Backwards: Referenced (Source) -> Referencing (Target)'} = 'Wstecz: Odwołanie (Źródło) -> Odwołanie (Cel)';
    $Self->{Translation}->{'Link Direction'} = 'Kierunek łącza';
    $Self->{Translation}->{'The referencing object is the one containing this dynamic field, the referenced object is the one selected as value of the dynamic field.'} =
        'Obiektem odniesienia jest obiekt zawierający to pole dynamiczne, a obiektem odniesienia jest obiekt wybrany jako wartość pola dynamicznego.';
    $Self->{Translation}->{'Dynamic (ConfigItem)'} = 'Dynamiczny (ConfigItem)';
    $Self->{Translation}->{'Static (Version)'} = 'Static (wersja)';
    $Self->{Translation}->{'Link Referencing Type'} = 'Typ odnośnika';
    $Self->{Translation}->{'Whether this link applies to the ConfigItem or the static version of the referencing object. Current Incident State calculation only is performed on dynamic links.'} =
        'Określa, czy powiązanie dotyczy ConfigItem, czy statycznej wersji obiektu odniesienia. Obliczanie bieżącego stanu incydentu jest wykonywane tylko w przypadku łączy dynamicznych.';
    $Self->{Translation}->{'Select the attribute which config items will be searched by'} = 'Wybierz atrybut, według którego będą wyszukiwane elementy konfiguracji';

    # Perl Module: Kernel/System/ITSMConfigItem/Definition.pm
    $Self->{Translation}->{'Base structure is not valid. Please provide a hash with data in YAML format.'} =
        'Struktura bazowa jest nieprawidłowa. Podaj hash z danymi w formacie YAML.';
    $Self->{Translation}->{'Starting the YAML string with \'---\' is required.'} = 'Wymagane jest rozpoczęcie ciągu YAML od "---".';

    # Perl Module: Kernel/System/ITSMConfigItem/Link.pm
    $Self->{Translation}->{'Could not purge the table configitem_link.'} = 'Nie można wyczyścić tabeli configitem_link.';
    $Self->{Translation}->{'No relevant dynamic fields were found'} = 'Nie znaleziono odpowiednich pól dynamicznych';
    $Self->{Translation}->{'Could not insert into the table configitem_link'} = 'Nie można wstawić do tabeli configitem_link';
    $Self->{Translation}->{'Inserted 0 rows into the table configitem_link'} = 'Wstawiono 0 wierszy do tabeli configitem_link';

    # Perl Module: Kernel/System/ImportExport/ObjectBackend/ITSMConfigItem.pm
    $Self->{Translation}->{'Maximum number of one element'} = 'Maksymalna liczba wystąpień pojednyczego elemetntu';
    $Self->{Translation}->{'Empty fields indicate that the current values are kept'} = 'Puste pola znaczają, że zatrzymane będą bieżące wartości';
    $Self->{Translation}->{'Skipped'} = 'Pominięte';

    # Perl Module: Kernel/Modules/AdminDynamicField.pm
    $Self->{Translation}->{'Error synchronizing the definitions. Please check the log.'} = 'Błąd synchronizacji definicji. Sprawdź dziennik.';
    $Self->{Translation}->{'You have ITSMConfigItem definitions which are not synchronized. Please deploy your ITSMConfigItem dynamic field changes.'} =
        'Masz definicje ITSMConfigItem, które nie są zsynchronizowane. Należy wdrożyć zmiany pola dynamicznego ITSMConfigItem.';

    # Database XML / SOPM Definition: ITSMConfigurationManagement.sopm
    $Self->{Translation}->{'Expired'} = 'Wygasło';
    $Self->{Translation}->{'Maintenance'} = 'Utrzymanie';
    $Self->{Translation}->{'Pilot'} = 'Pilotaż';
    $Self->{Translation}->{'Planned'} = 'Planowany';
    $Self->{Translation}->{'Repair'} = 'Naprawa';
    $Self->{Translation}->{'Retired'} = 'Wycofany';
    $Self->{Translation}->{'Review'} = 'Przegląd';
    $Self->{Translation}->{'Test/QA'} = 'Test/QA';

    # JS File: ITSM.Admin.ITSMConfigItem
    $Self->{Translation}->{'Overview and Confirmation'} = 'Przegląd i potwierdzenie';
    $Self->{Translation}->{'Importing classes/roles and their related fields'} = 'Importowanie klas/ról i powiązanych z nimi pól';
    $Self->{Translation}->{'An error occurred during class import.'} = 'Wystąpił błąd podczas importowania klasy.';

    # SysConfig
    $Self->{Translation}->{'0 - Hidden'} = '0 - Ukryty';
    $Self->{Translation}->{'1 - Shown'} = '1 - pokazano';
    $Self->{Translation}->{'Allows extended search conditions in config item search of the agent interface. With this feature you can search e. g. config item name with this kind of conditions like "(*key1*&&*key2*)" or "(*key1*||*key2*)".'} =
        'Umożliwia rozszerzone warunki wyszukiwania w interfejsie agenta. Dzięki tej funkcji można wyszukiwać np. nazwę elementu konfiguracji za pomocą tego rodzaju warunków, takich jak "(*key1*&&*key2*)" lub "(*key1*||*key2*)".';
    $Self->{Translation}->{'Allows extended search conditions in config item search of the customer interface. With this feature you can search e. g. config item name with this kind of conditions like "(*key1*&&*key2*)" or "(*key1*||*key2*)".'} =
        'Umożliwia rozszerzone warunki wyszukiwania w interfejsie klienta. Dzięki tej funkcji można wyszukiwać np. nazwę elementu konfiguracji za pomocą tego rodzaju warunków, takich jak "(*key1*&&*key2*)" lub "(*key1*||*key2*)".';
    $Self->{Translation}->{'Assigned CIs'} = 'Przypisane CI';
    $Self->{Translation}->{'At a specific time point create a ticket for config items, if the configured requirements are met. The time point is determined by the value of the field configured under "TimeCIKey" of the ConfigItem, and modified by "TimeModifier". If the latter can be either just a number, or a sign (+/-), a number, and an unit (d/h/m): "7" is equivalent to "+7d". The DynamicField "Ticket->DynamicField" will be used to mark created tickets - it has to exist. The flags \<OTOBO_CONFIGITEM_X\> where X can be NAME, NUMBER and DATE, will be substituted with the respective values in "Ticket->Text".'} =
        'W określonym punkcie czasowym tworzy bilet dla elementów konfiguracji, jeśli spełnione są skonfigurowane wymagania. Punkt czasowy jest określony przez wartość pola skonfigurowanego w "TimeCIKey" elementu ConfigItem i zmodyfikowanego przez "TimeModifier". Jeśli ten ostatni może być albo tylko liczbą, albo znakiem (+/-), liczbą i jednostką (d/h/m): "7" jest równoważne "+7d". Pole dynamiczne "Ticket->DynamicField" będzie używane do oznaczania utworzonych biletów - musi istnieć. Flagi \<OTOBO_CONFIGITEM_X\>, gdzie X może być NAZWĄ, LICZBĄ i DATĄ, zostaną zastąpione odpowiednimi wartościami w "Ticket->Text".';
    $Self->{Translation}->{'CIs assigned to customer company'} = 'CI przypisani do firmy klienta';
    $Self->{Translation}->{'CIs assigned to customer user'} = 'CI przypisane do użytkownika klienta';
    $Self->{Translation}->{'CMDB Settings'} = 'Ustawienia CMDB';
    $Self->{Translation}->{'Check for a unique name only within the same ConfigItem class (\'class\') or globally (\'global\'), which means every existing ConfigItem is taken into account when looking for duplicates.'} =
        'Sprawdzanie unikalnej nazwy tylko w obrębie tej samej klasy ConfigItem ("class") lub globalnie ("global"), co oznacza, że każdy istniejący ConfigItem jest brany pod uwagę podczas wyszukiwania duplikatów.';
    $Self->{Translation}->{'Choose a module to enforce a naming scheme.'} = 'Wybierz moduł, aby wymusić schemat nazewnictwa.';
    $Self->{Translation}->{'Choose a module to enforce a number scheme.'} = 'Wybierz moduł, aby wymusić schemat liczbowy.';
    $Self->{Translation}->{'Choose a module to enforce a version string scheme.'} = 'Wybierz moduł, aby wymusić schemat ciągów wersji.';
    $Self->{Translation}->{'Choose attributes to trigger the creation of a new version.'} = 'Wybierz atrybuty, aby uruchomić tworzenie nowej wersji.';
    $Self->{Translation}->{'Choose categories to assign to this config item class.'} = 'Wybierz kategorie, które chcesz przypisać do tej klasy elementów konfiguracji.';
    $Self->{Translation}->{'Column config item filters for ConfigItem Overview.'} = 'Filtry kolumn elementów konfiguracji dla ConfigItem Overview.';
    $Self->{Translation}->{'Columns that can be filtered in the config item overview of the agent interface. Note: Only Config Item attributes and Dynamic Fields (DynamicField_NameX) are allowed.'} =
        'Kolumny, które można filtrować w przeglądzie elementów konfiguracji interfejsu agenta. Uwaga: Dozwolone są tylko atrybuty pozycji konfiguracji i pola dynamiczne (DynamicField_NameX).';
    $Self->{Translation}->{'Columns that can be filtered in the config item overview of the customer interface. Note: Only Config Item attributes and Dynamic Fields (DynamicField_NameX) are allowed.'} =
        'Kolumny, które można filtrować w przeglądzie elementów konfiguracji interfejsu klienta. Uwaga: Dozwolone są tylko atrybuty pozycji konfiguracji i pola dynamiczne (DynamicField_NameX).';
    $Self->{Translation}->{'Columns that can be filtered in the config item search result overview of the agent interface. Note: Only Config Item attributes and Dynamic Fields (DynamicField_NameX) are allowed.'} =
        'Kolumny, które można filtrować w przeglądzie wyników wyszukiwania elementów konfiguracji w interfejsie agenta. Uwaga: Dozwolone są tylko atrybuty pozycji konfiguracji i pola dynamiczne (DynamicField_NameX).';
    $Self->{Translation}->{'Config Items'} = 'Elementy konfiguracji';
    $Self->{Translation}->{'Config item add.'} = 'Dodanie elementu konfiguracji.';
    $Self->{Translation}->{'Config item edit.'} = 'Edycja elementu konfiguracji.';
    $Self->{Translation}->{'Config item event module that count the licenses for OTOBOCILicenseCount feature.'} =
        'Moduł zdarzeń elementu konfiguracji zliczający licencje dla funkcji OTOBOCILicenseCount.';
    $Self->{Translation}->{'Config item event module that enables logging to history in the agent interface.'} =
        'Moduł zdarzeń elementu konfiguracji, który umożliwia rejestrowanie do historii w interfejsie agenta.';
    $Self->{Translation}->{'Config item event module that updates config items to their current definition.'} =
        'Moduł zdarzeń elementów konfiguracji, który aktualizuje elementy konfiguracji do ich bieżącej definicji.';
    $Self->{Translation}->{'Config item event module that updates the table configitem_ĺink.'} =
        'Moduł zdarzeń elementu konfiguracji, który aktualizuje tabelę configitem_ĺink.';
    $Self->{Translation}->{'Config item event module updates the current incident state.'} =
        'Moduł zdarzeń elementu konfiguracji aktualizuje bieżący stan zdarzenia.';
    $Self->{Translation}->{'Config item history.'} = 'Historia elementów konfiguracji.';
    $Self->{Translation}->{'Config item print.'} = 'Wydruk elementu konfiguracji.';
    $Self->{Translation}->{'Config item zoom.'} = 'Powiększenie elementu konfiguracji.';
    $Self->{Translation}->{'ConfigItem Tree View'} = 'Widok drzewa elementów konfiguracji';
    $Self->{Translation}->{'ConfigItem Version'} = 'ConfigItem Version';
    $Self->{Translation}->{'ConfigItems of the following classes will not be stored on the Elasticsearch server. To apply this to existing CIs, the CI migration has to be run via console, after changing this option.'} =
        'ConfigItems następujących klas nie będą przechowywane na serwerze Elasticsearch. Aby zastosować to do istniejących CI, migracja CI musi zostać uruchomiona za pośrednictwem konsoli, po zmianie tej opcji.';
    $Self->{Translation}->{'ConfigItems with the following deployment states will not be stored on the Elasticsearch server. To apply this to existing CIs, the CI migration has to be run via console, after changing this option.'} =
        'Elementy ConfigItems z następującymi stanami wdrożenia nie będą przechowywane na serwerze Elasticsearch. Aby zastosować to do istniejących CI, migracja CI musi zostać uruchomiona za pośrednictwem konsoli, po zmianie tej opcji.';
    $Self->{Translation}->{'Configuration Item Limit'} = 'Limit liczby CI';
    $Self->{Translation}->{'Configuration Item limit per page.'} = 'Limit pozycji konfiguracji na stronę.';
    $Self->{Translation}->{'Configuration Management Database.'} = 'Baza danych zarządzania konfiguracją.';
    $Self->{Translation}->{'Configuration item bulk module.'} = 'Moduł zbiorczy elementu konfiguracji.';
    $Self->{Translation}->{'Configuration item search backend router of the agent interface.'} =
        'Element konfiguracji wyszukiwania routera zaplecza interfejsu agenta.';
    $Self->{Translation}->{'Create and manage the definitions for Configuration Items.'} = 'Tworzenie i zarządzanie definicjami elementów konfiguracji.';
    $Self->{Translation}->{'Creates Tickets for ConfigItems at specific time points.'} = 'Tworzy bilety dla ConfigItems w określonych punktach czasowych.';
    $Self->{Translation}->{'Customers can see historic CI versions.'} = 'Klienci mogą zobaczyć historyczne wersje CI.';
    $Self->{Translation}->{'Customers have the possibility to manually switch between historic CI versions.'} =
        'Klienci mają możliwość ręcznego przełączania się między historycznymi wersjami CI.';
    $Self->{Translation}->{'Default data to use on attribute for config item search screen. Example: "ITSMConfigItemCreateTimePointFormat=year;ITSMConfigItemCreateTimePointStart=Last;ITSMConfigItemCreateTimePoint=2;".'} =
        'Domyślne dane do użycia w atrybucie dla ekranu wyszukiwania elementów konfiguracji. Przykład: "ITSMConfigItemCreateTimePointFormat=year;ITSMConfigItemCreateTimePointStart=Last;ITSMConfigItemCreateTimePoint=2;".';
    $Self->{Translation}->{'Default data to use on attribute for config item search screen. Example: "ITSMConfigItemCreateTimeStartYear=2010;ITSMConfigItemCreateTimeStartMonth=10;ITSMConfigItemCreateTimeStartDay=4;ITSMConfigItemCreateTimeStopYear=2010;ITSMConfigItemCreateTimeStopMonth=11;ITSMConfigItemCreateTimeStopDay=3;".'} =
        'Domyślne dane do użycia w atrybucie dla ekranu wyszukiwania elementów konfiguracji. Przykład: "ITSMConfigItemCreateTimeStartYear=2010;ITSMConfigItemCreateTimeStartMonth=10;ITSMConfigItemCreateTimeStartDay=4;ITSMConfigItemCreateTimeStopYear=2010;ITSMConfigItemCreateTimeStopMonth=11;ITSMConfigItemCreateTimeStopDay=3;".';
    $Self->{Translation}->{'Define Actions where a settings button is available in the linked objects widget (LinkObject::ViewMode = "complex"). Please note that these Actions must have registered the following JS and CSS files: Core.AllocationList.css, Core.UI.AllocationList.js, Core.UI.Table.Sort.js, Core.Agent.TableFilters.js and Core.Agent.LinkObject.js.'} =
        'Definiuje akcje, w których przycisk ustawień jest dostępny w widżecie połączonych obiektów (LinkObject::ViewMode = "complex"). Należy pamiętać, że te akcje muszą mieć zarejestrowane następujące pliki JS i CSS: Core.AllocationList.css, Core.UI.AllocationList.js, Core.UI.Table.Sort.js, Core.Agent.TableFilters.js i Core.Agent.LinkObject.js.';
    $Self->{Translation}->{'Define a Template::Toolkit scheme for version strings. Only used if Version String Module is set to TemplateToolkit.'} =
        'Definiuje schemat Template::Toolkit dla ciągów wersji. Używane tylko jeśli Version String Module jest ustawiony na TemplateToolkit.';
    $Self->{Translation}->{'Define a set of conditions under which a customer is allowed to see a config item. Conditions can optionally be restricted to certain customer groups. Name is the only mandatory attribute. If no other options are given, all config items will be visible under that category.'} =
        'Definiuje zestaw warunków, na podstawie których klient może zobaczyć element konfiguracji. Warunki mogą być opcjonalnie ograniczone do określonych grup klientów. Nazwa jest jedynym obowiązkowym atrybutem. Jeśli nie podano żadnych innych opcji, wszystkie elementy konfiguracji będą widoczne w tej kategorii.';
    $Self->{Translation}->{'Defines Required permissions to create ITSM configuration items using the Generic Interface.'} =
        'Definiuje wymagane uprawnienia do tworzenia elementów konfiguracji ITSM przy użyciu interfejsu ogólnego.';
    $Self->{Translation}->{'Defines Required permissions to delete ITSM configuration items using the Generic Interface.'} =
        'Określa wymagane uprawnienia do usuwania elementów konfiguracji ITSM przy użyciu interfejsu ogólnego.';
    $Self->{Translation}->{'Defines Required permissions to get ITSM configuration items using the Generic Interface.'} =
        'Definiuje wymagane uprawnienia do uzyskiwania elementów konfiguracji ITSM przy użyciu interfejsu ogólnego.';
    $Self->{Translation}->{'Defines Required permissions to search ITSM configuration items using the Generic Interface.'} =
        'Definiuje wymagane uprawnienia do wyszukiwania elementów konfiguracji ITSM przy użyciu interfejsu ogólnego.';
    $Self->{Translation}->{'Defines Required permissions to update ITSM configuration items using the Generic Interface.'} =
        'Definiuje wymagane uprawnienia do aktualizacji elementów konfiguracji ITSM przy użyciu interfejsu ogólnego.';
    $Self->{Translation}->{'Defines an overview module to show the small view of a configuration item list.'} =
        'Definiuje moduł przeglądu do wyświetlania małego widoku listy elementów konfiguracji.';
    $Self->{Translation}->{'Defines if parent-child translations for queues and services should be generated automatically.'} =
        '';
    $Self->{Translation}->{'Defines if the link type labels must be shown in the node connections.'} =
        'Określa, czy etykiety typu łącza muszą być wyświetlane w połączeniach węzłów.';
    $Self->{Translation}->{'Defines regular expressions individually for each ConfigItem class to check the ConfigItem name and to show corresponding error messages.'} =
        'Definiuje wyrażenia regularne indywidualnie dla każdej klasy ConfigItem w celu sprawdzenia nazwy ConfigItem i wyświetlenia odpowiednich komunikatów o błędach.';
    $Self->{Translation}->{'Defines the available columns of CIs in the config item overview depending on the CI class. Each entry must consist of a class name and an array of available fields for the corresponding class. Dynamic field entries have to honor the scheme DynamicField_FieldName.'} =
        'Definiuje dostępne kolumny CI w przeglądzie elementów konfiguracji w zależności od klasy CI. Każdy wpis musi składać się z nazwy klasy i tablicy dostępnych pól dla odpowiedniej klasy. Wpisy pól dynamicznych muszą być zgodne ze schematem DynamicField_FieldName.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of the agent interface.'} =
        'Definiuje domyślny atrybut elementu konfiguracji dla sortowania elementów konfiguracji w wynikach wyszukiwania elementów konfiguracji interfejsu agenta.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of the customer interface.'} =
        'Definiuje domyślny atrybut pozycji konfiguracji dla sortowania pozycji konfiguracji w wynikach wyszukiwania pozycji konfiguracji interfejsu klienta.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of this operation.'} =
        'Określa domyślny atrybut elementu konfiguracji dla sortowania wyników wyszukiwania elementu konfiguracji tej operacji.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the agent interface. Up: oldest on top. Down: latest on top.'} =
        'Określa domyślną kolejność elementów konfiguracji w wynikach wyszukiwania elementów konfiguracji w interfejsie agenta. W górę: najstarszy na górze. W dół: najnowsze na górze.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the customer interface. Up: oldest on top. Down: latest on top.'} =
        'Określa domyślną kolejność elementów konfiguracji w wynikach wyszukiwania elementów konfiguracji w interfejsie klienta. W górę: najstarsze na górze. W dół: najnowsze na górze.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the this operation. Up: oldest on top. Down: latest on top.'} =
        'Określa domyślną kolejność elementów konfiguracji w wynikach wyszukiwania elementów konfiguracji tej operacji. W górę: najstarsze na górze. W dół: najnowsze na górze.';
    $Self->{Translation}->{'Defines the default displayed columns of CIs in the config item overview depending on the CI class. Each entry must consist of a class name and an array of available fields for the corresponding class. Dynamic field entries have to honor the scheme DynamicField_FieldName.'} =
        'Definiuje domyślnie wyświetlane kolumny CI w przeglądzie elementów konfiguracji w zależności od klasy CI. Każdy wpis musi składać się z nazwy klasy i tablicy dostępnych pól dla odpowiedniej klasy. Wpisy pól dynamicznych muszą być zgodne ze schematem DynamicField_FieldName.';
    $Self->{Translation}->{'Defines the default relations depth to be shown.'} = 'Określa domyślną głębokość wyświetlanych relacji.';
    $Self->{Translation}->{'Defines the default shown config item search attribute for config item search screen.'} =
        'Określa domyślnie wyświetlany atrybut wyszukiwania elementów konfiguracji dla ekranu wyszukiwania elementów konfiguracji.';
    $Self->{Translation}->{'Defines the default shown config item search attribute for config item search screen. Example: "Key" must have the name of the Dynamic Field in this case \'X\', "Content" must have the value of the Dynamic Field depending on the Dynamic Field type,  Text: \'a text\', Dropdown: \'1\', Date/Time: \'Search_DynamicField_XTimeSlotStartYear=1974; Search_DynamicField_XTimeSlotStartMonth=01; Search_DynamicField_XTimeSlotStartDay=26; Search_DynamicField_XTimeSlotStartHour=00; Search_DynamicField_XTimeSlotStartMinute=00; Search_DynamicField_XTimeSlotStartSecond=00; Search_DynamicField_XTimeSlotStopYear=2013; Search_DynamicField_XTimeSlotStopMonth=01; Search_DynamicField_XTimeSlotStopDay=26; Search_DynamicField_XTimeSlotStopHour=23; Search_DynamicField_XTimeSlotStopMinute=59; Search_DynamicField_XTimeSlotStopSecond=59;\' and or \'Search_DynamicField_XTimePointFormat=week; Search_DynamicField_XTimePointStart=Before; Search_DynamicField_XTimePointValue=7\';.'} =
        'Określa domyślnie wyświetlany atrybut wyszukiwania elementu konfiguracji dla ekranu wyszukiwania elementu konfiguracji. Przykład: "Klucz" musi mieć nazwę pola dynamicznego, w tym przypadku "X", "Zawartość" musi mieć wartość pola dynamicznego w zależności od typu pola dynamicznego, Tekst: "tekst", Lista rozwijana: "1", Data/godzina: \'Search_DynamicField_XTimeSlotStartYear=1974; Search_DynamicField_XTimeSlotStartMonth=01; Search_DynamicField_XTimeSlotStartDay=26; Search_DynamicField_XTimeSlotStartHour=00; Search_DynamicField_XTimeSlotStartMinute=00; Search_DynamicField_XTimeSlotStartSecond=00; Search_DynamicField_XTimeSlotStopYear=2013; Search_DynamicField_XTimeSlotStopMonth=01; Search_DynamicField_XTimeSlotStopDay=26; Search_DynamicField_XTimeSlotStopHour=23; Search_DynamicField_XTimeSlotStopMinute=59; Search_DynamicField_XTimeSlotStopSecond=59;\' i lub \'Search_DynamicField_XTimePointFormat=week; Search_DynamicField_XTimePointStart=Before; Search_DynamicField_XTimePointValue=7\';.';
    $Self->{Translation}->{'Defines the default subobject of the class \'ITSMConfigItem\'.'} =
        'Definiuje domyślny podobiekt klasy "ITSMConfigItem".';
    $Self->{Translation}->{'Defines the initial height for the rich text editor component in pixels.'} =
        '';
    $Self->{Translation}->{'Defines the initial height in pixels for the rich text editor component for this screen.'} =
        '';
    $Self->{Translation}->{'Defines the number of rows for the CI definition editor in the admin interface.'} =
        'Określa liczbę wierszy edytora definicji CI w interfejsie administratora.';
    $Self->{Translation}->{'Defines the order of incident states from high (e.g. cricital) to low (e.g. functional).'} =
        'Określa kolejność stanów zdarzenia od wysokiego (np. stan krytyczny) do niskiego (np. stan funkcjonalny).';
    $Self->{Translation}->{'Defines the relevant deployment states where linked tickets can affect the status of a CI.'} =
        'Definiuje odpowiednie stany wdrożenia, w których powiązane zgłoszenia mogą wpływać na stan CI.';
    $Self->{Translation}->{'Defines the search limit for the AgentITSMConfigItem screen.'} =
        'Określa limit wyszukiwania dla ekranu AgentITSMConfigItem.';
    $Self->{Translation}->{'Defines the search limit for the AgentITSMConfigItemSearch screen.'} =
        'Określa limit wyszukiwania dla ekranu AgentITSMConfigItemSearch.';
    $Self->{Translation}->{'Defines the search limit for the CustomerITSMConfigItem screen.'} =
        'Określa limit wyszukiwania dla ekranu CustomerITSMConfigItem.';
    $Self->{Translation}->{'Defines the search limit for the CustomerITSMConfigItemSearch screen.'} =
        'Określa limit wyszukiwania dla ekranu CustomerITSMConfigItemSearch.';
    $Self->{Translation}->{'Defines the shown columns of CIs in the link table complex view for all CI classes. If there is no entry, then the default columns are shown.'} =
        'Określa wyświetlane kolumny CI w widoku złożonym tabeli linków dla wszystkich klas CI. Jeśli nie ma wpisu, wyświetlane są kolumny domyślne.';
    $Self->{Translation}->{'Defines the shown columns of CIs in the link table complex view, depending on the CI class. Each entry must be prefixed with the class name and double colons (i.e. Computer::). There are a few CI-Attributes that common to all CIs (example for the class Computer: Computer::Name, Computer::CurDeplState, Computer::CreateTime). To show individual CI-Attributes as defined in the CI-Definition, the following scheme must be used (example for the class Computer): Computer::HardDisk::1, Computer::HardDisk::1::Capacity::1, Computer::HardDisk::2, Computer::HardDisk::2::Capacity::1. If there is no entry for a CI class, then the default columns are shown.'} =
        'Definiuje wyświetlane kolumny CI w widoku złożonym tabeli linków, w zależności od klasy CI. Każdy wpis musi być poprzedzony nazwą klasy i podwójnymi dwukropkami (np. Computer::). Istnieje kilka atrybutów CI, które są wspólne dla wszystkich CI (przykład dla klasy Computer: Computer::Name, Computer::CurDeplState, Computer::CreateTime). Aby wyświetlić poszczególne atrybuty CI zdefiniowane w definicji CI, należy użyć następującego schematu (przykład dla klasy Computer): Computer::HardDisk::1, Computer::HardDisk::1::Capacity::1, Computer::HardDisk::2, Computer::HardDisk::2::Capacity::1. Jeśli nie ma wpisu dla klasy CI, wyświetlane są kolumny domyślne.';
    $Self->{Translation}->{'Defines which items are available for \'Action\' in third level of the ITSM Config Item ACL structure.'} =
        'Określa, które elementy są dostępne dla "Action" na trzecim poziomie struktury ITSM Config Item ACL.';
    $Self->{Translation}->{'Defines which items are available in first level of the ITSM Config Item ACL structure.'} =
        'Określa, które elementy są dostępne na pierwszym poziomie struktury ITSM Config Item ACL.';
    $Self->{Translation}->{'Defines which items are available in second level of the ITSM Config Item ACL structure.'} =
        'Określa, które elementy są dostępne na drugim poziomie struktury ITSM Config Item ACL.';
    $Self->{Translation}->{'Defines which type of link (named from the ticket perspective) can affect the status of a linked CI.'} =
        'Określa, który typ powiązania (nazwany z perspektywy zgłoszenia) może wpływać na status powiązanego CI.';
    $Self->{Translation}->{'Defines which type of ticket can affect the status of a linked CI.'} =
        'Określa, który typ zgłoszenia może wpływać na status powiązanego CI.';
    $Self->{Translation}->{'Definition Update'} = 'Aktualizacja definicji';
    $Self->{Translation}->{'Delete Configuration Item'} = 'Usuń element konfiguracji';
    $Self->{Translation}->{'DeplState'} = 'DeplState';
    $Self->{Translation}->{'Deployment State Color'} = 'Kolor stanu wdrożenia';
    $Self->{Translation}->{'DeploymentState'} = 'DeploymentState';
    $Self->{Translation}->{'Duplicate'} = 'Duplikat';
    $Self->{Translation}->{'Dynamic field event module that marks config item definitions as out of sync, if containing dynamic fields change.'} =
        'Moduł zdarzeń pól dynamicznych, który oznacza definicje elementów konfiguracji jako niezsynchronizowane, jeśli zawierające je pola dynamiczne ulegną zmianie.';
    $Self->{Translation}->{'Dynamic fields shown in the additional ITSM field screen of the agent interface.'} =
        'Pola dynamiczne wyświetlane na ekranie dodatkowych pól ITSM interfejsu agenta.';
    $Self->{Translation}->{'Dynamic fields shown in the config item overview screen of the customer interface.'} =
        'Dynamiczne pola wyświetlane na ekranie przeglądu elementów konfiguracji interfejsu klienta.';
    $Self->{Translation}->{'Dynamic fields shown in the config item search screen of the agent interface.'} =
        'Dynamiczne pola wyświetlane na ekranie wyszukiwania elementów konfiguracji w interfejsie agenta.';
    $Self->{Translation}->{'Enables configuration item bulk action feature for the agent frontend to work on more than one configuration item at a time.'} =
        'Włącza funkcję masowej akcji elementu konfiguracji dla interfejsu agenta, aby pracować na więcej niż jednym elemencie konfiguracji naraz.';
    $Self->{Translation}->{'Enables configuration item bulk action feature only for the listed groups.'} =
        'Włącza funkcję akcji zbiorczej elementu konfiguracji tylko dla wymienionych grup.';
    $Self->{Translation}->{'Enables/disables the functionality to check ITSM onfiguration items for unique names. Before enabling this option you should check your system for already existing config items with duplicate names. You can do this with the console command Admin::ITSM::Configitem::ListDuplicates.'} =
        'Włącza/wyłącza funkcję sprawdzania elementów konfiguracji ITSM pod kątem unikalnych nazw. Przed włączeniem tej opcji należy sprawdzić system pod kątem już istniejących elementów konfiguracji ze zduplikowanymi nazwami. Można to zrobić za pomocą polecenia konsoli Admin::ITSM::Configitem::ListDuplicates.';
    $Self->{Translation}->{'Event module to set configitem-status on ticket-configitem-link.'} =
        'Moduł zdarzeń do ustawiania statusu elementu konfiguracji na ticket-configitem-link.';
    $Self->{Translation}->{'Fields of the configuration item index, used for the fulltext search. Fields are also stored, but are not mandatory for the overall functionality. Inclusion of attachments can be disabled by setting the entry to 0 or deleting it.'} =
        'Pola indeksu pozycji konfiguracji, używane do wyszukiwania pełnotekstowego. Pola są również przechowywane, ale nie są obowiązkowe dla ogólnej funkcjonalności. Dołączanie załączników można wyłączyć, ustawiając wartość wpisu na 0 lub usuwając go.';
    $Self->{Translation}->{'Fields stored in the configuration item index which are used for other things besides fulltext searches. For the complete functionality all fields are mandatory.'} =
        'Pola przechowywane w indeksie pozycji konfiguracji, które są wykorzystywane do innych celów niż wyszukiwanie pełnotekstowe. Dla pełnej funkcjonalności wszystkie pola są obowiązkowe.';
    $Self->{Translation}->{'For every webservice (key) an array of classes (value) can be defined on which the import is restricted. For all chosen classes, or all existing classes the identifying attributes will have to be chosen in the invoker config.'} =
        'Dla każdej usługi webservice (klucz) można zdefiniować tablicę klas (wartość), dla których import jest ograniczony. Dla wszystkich wybranych klas lub wszystkich istniejących klas atrybuty identyfikujące będą musiały zostać wybrane w konfiguracji wywołującego.';
    $Self->{Translation}->{'GenericInterface module registration for the ConfigItemFetch invoker layer.'} =
        'Rejestracja modułu GenericInterface dla warstwy wywołującej ConfigItemFetch.';
    $Self->{Translation}->{'ITSM ConfigItem'} = 'ITSM ConfigItem';
    $Self->{Translation}->{'ITSM config item overview.'} = 'Przegląd elementów konfiguracji ITSM.';
    $Self->{Translation}->{'If this option is activated, linked items are only counted if they belong to one of the listed classes.'} =
        'Jeśli ta opcja jest aktywna, połączone elementy są liczone tylko wtedy, gdy należą do jednej z wymienionych klas.';
    $Self->{Translation}->{'InciState'} = 'InciState';
    $Self->{Translation}->{'IncidentState'} = 'IncidentState';
    $Self->{Translation}->{'Includes deployment states in the config item search of the customer interface.'} =
        'Obejmuje stany wdrożenia w wyszukiwaniu elementów konfiguracji interfejsu klienta.';
    $Self->{Translation}->{'Includes incident states in the config item search of the customer interface.'} =
        'Obejmuje stany incydentów w wyszukiwaniu elementów konfiguracji interfejsu klienta.';
    $Self->{Translation}->{'Maximum number of config items to be displayed in the result of this operation.'} =
        'Maksymalna liczba elementów konfiguracji do wyświetlenia w wyniku tej operacji.';
    $Self->{Translation}->{'Module to check the group responsible for a class.'} = 'Moduł sprawdzający grupę odpowiedzialną za klasę.';
    $Self->{Translation}->{'Module to check the group responsible for a configuration item.'} =
        'Moduł do sprawdzania grupy odpowiedzialnej za element konfiguracji.';
    $Self->{Translation}->{'Module to generate ITSM config item statistics.'} = 'Moduł do generowania statystyk elementów konfiguracji ITSM.';
    $Self->{Translation}->{'Name Module'} = 'Nazwa modułu';
    $Self->{Translation}->{'Number Module'} = 'Moduł numeryczny';
    $Self->{Translation}->{'Number of config items to be displayed in each page of a search result in the agent interface.'} =
        'Liczba elementów konfiguracji wyświetlanych na każdej stronie wyników wyszukiwania w interfejsie agenta.';
    $Self->{Translation}->{'Number of config items to be displayed in each page of a search result in the customer interface.'} =
        'Liczba elementów konfiguracji wyświetlanych na każdej stronie wyników wyszukiwania w interfejsie klienta.';
    $Self->{Translation}->{'Objects to search for, how many entries and which attributs to show. ConfigItem attributes have to explicitly be stored via Elasticsearch.'} =
        'Obiekty do wyszukania, ile wpisów i które atrybuty pokazać. Atrybuty ConfigItem muszą być jawnie przechowywane przez Elasticsearch.';
    $Self->{Translation}->{'Overview.'} = 'Przegląd.';
    $Self->{Translation}->{'Parameters for the categories for config item classes in the preferences view of the agent interface.'} =
        'Parametry dla kategorii klas elementów konfiguracji w widoku preferencji interfejsu agenta.';
    $Self->{Translation}->{'Parameters for the column filters of the small config item overview. Please note: setting \'Active\' to 0 will only prevent agents from editing settings of this group in their personal preferences, but will still allow administrators to edit the settings of another user\'s behalf. Use \'PreferenceGroup\' to control in which area these settings should be shown in the user interface.'} =
        'Parametry dla filtrów kolumn w małym przeglądzie elementów konfiguracji. Uwaga: ustawienie "Active" na 0 uniemożliwi agentom edycję ustawień tej grupy w ich osobistych preferencjach, ale nadal pozwoli administratorom edytować ustawienia w imieniu innego użytkownika. Użyj "PreferenceGroup", aby kontrolować, w którym obszarze te ustawienia powinny być wyświetlane w interfejsie użytkownika.';
    $Self->{Translation}->{'Parameters for the dashboard backend of the customer company config item overview of the agent interface . "Limit" is the number of entries shown by default. "Group" is used to restrict the access to the plugin (e. g. Group: admin;group1;group2;). "Default" determines if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" is the cache time in minutes for the plugin.'} =
        'Parametry dla zaplecza pulpitu nawigacyjnego elementu konfiguracji firmy klienta w interfejsie agenta. "Limit" to liczba domyślnie wyświetlanych wpisów. "Grupa" służy do ograniczenia dostępu do wtyczki (np. Grupa: admin;grupa1;grupa2;). "Domyślnie" określa, czy wtyczka jest domyślnie włączona, czy też użytkownik musi ją włączyć ręcznie. "CacheTTLLocal" to czas pamięci podręcznej w minutach dla wtyczki.';
    $Self->{Translation}->{'Parameters for the deployment states color in the preferences view of the agent interface.'} =
        'Parametry kolorów stanów wdrożenia w widoku preferencji interfejsu agenta.';
    $Self->{Translation}->{'Parameters for the deployment states in the preferences view of the agent interface.'} =
        'Parametry stanów wdrożenia w widoku preferencji interfejsu agenta.';
    $Self->{Translation}->{'Parameters for the example permission groups of the general catalog attributes.'} =
        'Parametry dla przykładowych grup uprawnień atrybutów katalogu głównego.';
    $Self->{Translation}->{'Parameters for the name module for config item classes in the preferences view of the agent interface.'} =
        'Parametry modułu nazwy dla klas elementów konfiguracji w widoku preferencji interfejsu agenta.';
    $Self->{Translation}->{'Parameters for the number module for config item classes in the preferences view of the agent interface.'} =
        'Parametry dla modułu liczby dla klas elementów konfiguracji w widoku preferencji interfejsu agenta.';
    $Self->{Translation}->{'Parameters for the pages (in which the configuration items are shown).'} =
        'Parametry dla stron (na których wyświetlane są elementy konfiguracji).';
    $Self->{Translation}->{'Parameters for the version string module for config item classes in the preferences view of the agent interface.'} =
        'Parametry dla modułu łańcucha wersji dla klas elementów konfiguracji w widoku preferencji interfejsu agenta.';
    $Self->{Translation}->{'Parameters for the version string template toolkit module for config item classes in the preferences view of the agent interface.'} =
        'Parametry dla modułu szablonu łańcucha wersji dla klas elementów konfiguracji w widoku preferencji interfejsu agenta.';
    $Self->{Translation}->{'Parameters for the version trigger for config item classes in the preferences view of the agent interface.'} =
        'Parametry wyzwalacza wersji dla klas elementów konfiguracji w widoku preferencji interfejsu agenta.';
    $Self->{Translation}->{'Performs the configured action for each event (as an Invoker) for each configured Webservice.'} =
        'Wykonuje zaplanowane akcje dla każdego wydażenia (jako Wzywający) dla każdej skonfigurowanej usługi sieciowej.';
    $Self->{Translation}->{'Permission Group'} = 'Grupa Uprawnień';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item attachment action in the agent interface.'} =
        'Wymagane uprawnienia do korzystania z akcji dołączania elementu konfiguracji ITSM w interfejsie agenta.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item screen in the agent interface.'} =
        'Wymagane uprawnienia do korzystania z ekranu elementu konfiguracji ITSM w interfejsie agenta.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item search screen in the agent interface.'} =
        'Wymagane uprawnienia do korzystania z ekranu wyszukiwania elementów konfiguracji ITSM w interfejsie agenta.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item search screen in the customer interface.'} =
        'Wymagane uprawnienia do korzystania z ekranu wyszukiwania elementów konfiguracji ITSM w interfejsie klienta.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item tree view screen in the agent interface.'} =
        'Wymagane uprawnienia do korzystania z ekranu widoku drzewa elementów konfiguracji ITSM w interfejsie agenta.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item zoom screen in the agent interface.'} =
        'Wymagane uprawnienia do korzystania z ekranu powiększenia elementu konfiguracji ITSM w interfejsie agenta.';
    $Self->{Translation}->{'Required permissions to use the add ITSM configuration item screen in the agent interface.'} =
        'Wymagane uprawnienia do korzystania z ekranu dodawania elementu konfiguracji ITSM w interfejsie agenta.';
    $Self->{Translation}->{'Required permissions to use the bulk ITSM configuration item screen in the agent interface.'} =
        'Wymagane uprawnienia do korzystania z ekranu elementu konfiguracji zbiorczej ITSM w interfejsie agenta.';
    $Self->{Translation}->{'Required permissions to use the edit ITSM configuration item screen in the agent interface.'} =
        'Uprawnienia wymagane do korzystania z ekranu edycji elementu konfiguracji ITSM w interfejsie agenta.';
    $Self->{Translation}->{'Required permissions to use the history ITSM configuration item screen in the agent interface.'} =
        'Uprawnienia wymagane do korzystania z ekranu elementu konfiguracji ITSM historii w interfejsie agenta.';
    $Self->{Translation}->{'Required permissions to use the print ITSM configuration item screen in the agent interface.'} =
        'Wymagane uprawnienia do korzystania z ekranu drukowania elementu konfiguracji ITSM w interfejsie agenta.';
    $Self->{Translation}->{'Required privileges to delete config items.'} = 'Wymagane uprawnienia do usuwania elementów konfiguracji.';
    $Self->{Translation}->{'Search config items.'} = 'Wyszukaj elementy konfiguracji.';
    $Self->{Translation}->{'Set the incident state of a CI automatically when a Ticket is Linked to a CI.'} =
        'Ustaw stan incydentu CI automatycznie, gdy Ticket jest powiązany z CI.';
    $Self->{Translation}->{'Sets the deployment state in the configuration item bulk screen of the agent interface.'} =
        'Ustawia stan wdrożenia na ekranie zbiorczym elementu konfiguracji interfejsu agenta.';
    $Self->{Translation}->{'Sets the incident state in the configuration item bulk screen of the agent interface.'} =
        'Ustawia stan zdarzenia na ekranie zbiorczym elementu konfiguracji interfejsu agenta.';
    $Self->{Translation}->{'Shows a link in the menu that allows linking a configuration item with another object in the config item zoom view of the agent interface.'} =
        'Wyświetla łącze w menu, które umożliwia powiązanie elementu konfiguracji z innym obiektem w widoku powiększenia elementu konfiguracji interfejsu agenta.';
    $Self->{Translation}->{'Shows a link in the menu to access the history of a configuration item in the configuration item overview of the agent interface.'} =
        'Wyświetla łącze w menu umożliwiające dostęp do historii elementu konfiguracji w przeglądzie elementów konfiguracji interfejsu agenta.';
    $Self->{Translation}->{'Shows a link in the menu to access the history of a configuration item in the its zoom view of the agent interface.'} =
        'Wyświetla łącze w menu umożliwiające dostęp do historii elementu konfiguracji w widoku powiększenia interfejsu agenta.';
    $Self->{Translation}->{'Shows a link in the menu to delete a configuration item in its zoom view of the agent interface.'} =
        'Wyświetla łącze w menu umożliwiające usunięcie elementu konfiguracji w widoku powiększenia interfejsu agenta.';
    $Self->{Translation}->{'Shows a link in the menu to display the configuration item links as a Tree View.'} =
        'Wyświetla łącze w menu, aby wyświetlić łącza elementów konfiguracji w widoku drzewa.';
    $Self->{Translation}->{'Shows a link in the menu to duplicate a configuration item in the configuration item overview of the agent interface.'} =
        'Wyświetla łącze w menu do duplikowania elementu konfiguracji w przeglądzie elementów konfiguracji interfejsu agenta.';
    $Self->{Translation}->{'Shows a link in the menu to duplicate a configuration item in the its zoom view of the agent interface.'} =
        'Wyświetla łącze w menu w celu powielenia elementu konfiguracji w widoku powiększenia interfejsu agenta.';
    $Self->{Translation}->{'Shows a link in the menu to edit a configuration item in the its zoom view of the agent interface.'} =
        'Wyświetla łącze w menu umożliwiające edycję elementu konfiguracji w widoku powiększenia interfejsu agenta.';
    $Self->{Translation}->{'Shows a link in the menu to go back in the configuration item zoom view of the agent interface.'} =
        'Wyświetla łącze w menu umożliwiające powrót do widoku powiększenia elementu konfiguracji w interfejsie agenta.';
    $Self->{Translation}->{'Shows a link in the menu to print a configuration item in the its zoom view of the agent interface.'} =
        'Wyświetla łącze w menu umożliwiające wydrukowanie elementu konfiguracji w widoku powiększenia interfejsu agenta.';
    $Self->{Translation}->{'Shows a link in the menu to zoom into a configuration item in the configuration item overview of the agent interface.'} =
        'Wyświetla łącze w menu umożliwiające powiększenie elementu konfiguracji w przeglądzie elementów konfiguracji interfejsu agenta.';
    $Self->{Translation}->{'Shows the config item history (reverse ordered) in the agent interface.'} =
        'Wyświetla historię elementów konfiguracji (w odwrotnej kolejności) w interfejsie agenta.';
    $Self->{Translation}->{'The default category which is shown, if none is selected.'} = 'Domyślna kategoria, która jest wyświetlana, jeśli nie wybrano żadnej.';
    $Self->{Translation}->{'The identifier for a configuration item, e.g. ConfigItem#, MyConfigItem#. The default is ConfigItem#.'} =
        'Identyfikator elementu konfiguracji, np. ConfigItem#, MyConfigItem#. Domyślnie jest to ConfigItem#.';
    $Self->{Translation}->{'Triggers ConfigItemFetch invoker automatically.'} = 'Automatycznie uruchamia wywołanie ConfigItemFetch.';
    $Self->{Translation}->{'Version String Expression'} = 'Wersja Wyrażenie łańcuchowe';
    $Self->{Translation}->{'Version String Module'} = 'Moduł ciągu wersji';
    $Self->{Translation}->{'Version Trigger'} = 'Wyzwalacz wersji';
    $Self->{Translation}->{'Whether the execution of ConfigItemACL can be avoided by checking cached field dependencies. This can improve loading times of formulars, but has to be disabled, if ACLModules are to be used for ITSMConfigItem- and Form-ReturnTypes.'} =
        'Czy można uniknąć wykonania ConfigItemACL poprzez sprawdzenie zależności pól w pamięci podręcznej. Może to poprawić czas ładowania formularzy, ale musi być wyłączone, jeśli ACLModules mają być używane dla ITSMConfigItem- i Form-ReturnTypes.';
    $Self->{Translation}->{'Which general information is shown in the header.'} = 'Informacje ogólne są wyświetlane w nagłówku.';
    $Self->{Translation}->{'With this option it´s possible to fill automaticly a CI field, depending on the count of linked CI´s with the existing type DependsOn.'} =
        'Dzięki tej opcji możliwe jest automatyczne wypełnienie pola CI, w zależności od liczby powiązanych CI z istniejącym typem DependsOn.';
    $Self->{Translation}->{'With this option it´s possible to fill automaticly a CI field, depending on the count of linked CI´s.'} =
        'Dzięki tej opcji możliwe jest automatyczne wypełnienie pola CI, w zależności od liczby połączonych CI.';
    $Self->{Translation}->{'With this option it´s possible to fill automaticly a CI field, depending on the count of linked CI´s. The setting CounterClassName include the name of the class and CounterFieldName is used to store the count of used licence.'} =
        'Dzięki tej opcji możliwe jest automatyczne wypełnienie pola CI, w zależności od liczby połączonych CI. Ustawienie CounterClassName zawiera nazwę klasy, a CounterFieldName służy do przechowywania liczby użytych licencji.';
    $Self->{Translation}->{'class'} = 'klasa';
    $Self->{Translation}->{'global'} = 'globalny';
    $Self->{Translation}->{'postproductive'} = 'postprodukcyjny';
    $Self->{Translation}->{'preproductive'} = 'przedprodukcyjny';
    $Self->{Translation}->{'productive'} = 'produktywny';


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

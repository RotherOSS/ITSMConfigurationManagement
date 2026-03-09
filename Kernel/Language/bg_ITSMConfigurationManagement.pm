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

package Kernel::Language::bg_ITSMConfigurationManagement;

use strict;
use warnings;
use utf8;

sub Data {
    my $Self = shift;

    # Template: AdminGenericInterfaceOperationConfigItem
    $Self->{Translation}->{'General operation data'} = 'Общи данни за работа';
    $Self->{Translation}->{'Settings for incoming request data'} = 'Настройки за входящи данни за заявки';
    $Self->{Translation}->{'Settings for outgoing response data'} = 'Настройки за изходящите данни за отговор';

    # Template: AdminITSMConfigItem
    $Self->{Translation}->{'Config Item Management'} = 'Управление на конфигурационните единици CI';
    $Self->{Translation}->{'Change class definition'} = 'Промяна на дефиницията на класа';
    $Self->{Translation}->{'Change role definition'} = 'Промяна на дефиницията на ролята';
    $Self->{Translation}->{'Ready2Import Class Bundles'} = 'Пакети от класове Ready2Import';
    $Self->{Translation}->{'Here you can import Ready2Import class bundles showcasing our most usual config items. Please note that some additional configuration may be required.'} =
        'Тук можете да импортирате пакети от класове Ready2Import, които показват най-обичайните елементи на конфигурацията. Моля, обърнете внимание, че може да се наложи допълнителна конфигурация.';
    $Self->{Translation}->{'Update existing entities'} = 'Актуализиране на съществуващи структури';
    $Self->{Translation}->{'Import Ready2Adopt class bundles'} = 'Импортиране на пакети от класове Ready2Adopt';
    $Self->{Translation}->{'Config Item Class'} = 'Клас на конфигурационен елемент';
    $Self->{Translation}->{'Config Item Role'} = 'Роля на елемента на конфигурацията';

    # Template: AgentITSMConfigItemAdd
    $Self->{Translation}->{'Config Item'} = 'Конфигурационен елемент';
    $Self->{Translation}->{'Filter for Classes'} = 'Филтър за класове';
    $Self->{Translation}->{'Select a Class from the list to create a new Config Item.'} = 'Изберете клас от списъка, за да създадете нов конфигурационен елемент.';
    $Self->{Translation}->{'Class'} = 'Клас';

    # Template: AgentITSMConfigItemBulk
    $Self->{Translation}->{'ITSM ConfigItem Bulk Action'} = 'Групово действие на ITSM ConfigItem';
    $Self->{Translation}->{'Deployment state'} = 'Състояние на използване';
    $Self->{Translation}->{'Incident state'} = 'Състояние на инцидент';
    $Self->{Translation}->{'Link to another'} = 'Линк към друг';
    $Self->{Translation}->{'Invalid Configuration Item number!'} = 'Невалиден номер на конфигурационен елемент!';
    $Self->{Translation}->{'The number of another Configuration Item to link with.'} = 'Номерът на друг конфигурационен елемент, с който да се свържете.';

    # Template: AgentITSMConfigItemDelete
    $Self->{Translation}->{'Do you really want to delete this config item?'} = 'Наистина ли искате да изтриете този конфигурационен елемент?';

    # Template: AgentITSMConfigItemEdit
    $Self->{Translation}->{'The name of this config item'} = 'Името на този конфигурационен елемент';
    $Self->{Translation}->{'Name is already in use by the ConfigItems with the following Number(s): %s'} =
        'Името вече се използва от Конфигурационни елементи със следния Номер(а): %s';
    $Self->{Translation}->{'Version Number'} = 'Номер на версията';
    $Self->{Translation}->{'Version number of this config item'} = 'Номер на версията на този елемент от конфигурацията';
    $Self->{Translation}->{'Version Number is already in use by the ConfigItems with the following Number(s): %s'} =
        'Номерът на версията вече се използва от елементите на конфигурацията със следния номер(и): %s';
    $Self->{Translation}->{'Deployment State'} = 'Състояние на използване';
    $Self->{Translation}->{'Incident State'} = 'Състояние на инцидента';

    # Template: AgentITSMConfigItemHistory
    $Self->{Translation}->{'History of Config Item: %s'} = 'История на Конфигурационен елемент: %s';
    $Self->{Translation}->{'History Content'} = 'Съдържание на историята';
    $Self->{Translation}->{'Createtime'} = 'Време на създаване';
    $Self->{Translation}->{'Zoom view'} = 'Увеличен изглед';

    # Template: AgentITSMConfigItemOverviewNavBar
    $Self->{Translation}->{'Config Items per page'} = 'Конфигурационни елементи на страница';

    # Template: AgentITSMConfigItemOverviewSmall
    $Self->{Translation}->{'No config item data found.'} = 'Не са намерени данни за елемента на конфигурацията.';
    $Self->{Translation}->{'Select this config item'} = 'Изберете този елемент от конфигурацията';

    # Template: AgentITSMConfigItemSearch
    $Self->{Translation}->{'Run Search'} = 'Стартирайте Търсене';
    $Self->{Translation}->{'Also search in previous versions?'} = 'Да търси и в предишните версии?';

    # Template: AgentITSMConfigItemTreeView
    $Self->{Translation}->{'TreeView for ConfigItem'} = 'Дървовиден изглед за ConfigItem';
    $Self->{Translation}->{'Depth Level'} = 'Ниво на дълбочина';
    $Self->{Translation}->{'Zoom In/Out'} = 'Увеличаване/изключване';
    $Self->{Translation}->{'Max links level reached for ConfigItem!'} = 'Максималното ниво на връзките е достигнато за ConfigItem!';

    # Template: AgentITSMConfigItemZoom
    $Self->{Translation}->{'Configuration Item'} = 'Конфигурационен елемент';
    $Self->{Translation}->{'Configuration Item Information'} = 'Информация за конфигурационен елемент';
    $Self->{Translation}->{'Current Deployment State'} = 'Текущо състояние на използване';
    $Self->{Translation}->{'Current Incident State'} = 'Текущо състояние на инцидента';
    $Self->{Translation}->{'Last changed'} = 'Последна промяна';
    $Self->{Translation}->{'Last changed by'} = 'Последно променен от';

    # Template: CustomerITSMConfigItem
    $Self->{Translation}->{'Your ConfigItems'} = 'Вашите елементи на конфигурацията';

    # Template: CustomerITSMConfigItemSearch
    $Self->{Translation}->{'ConfigItem Search'} = 'Търсене на елементи на конфигурацията';

    # Template: AdminACL
    $Self->{Translation}->{'Object Type'} = 'Тип на обекта';

    # Template: AdminDynamicFieldScreen
    $Self->{Translation}->{'Filter by object type'} = '';

    # JS Template: ClassImportConfirm
    $Self->{Translation}->{'The following classes will be imported'} = 'Ще бъдат импортирани следните класове';
    $Self->{Translation}->{'The following roles will be imported'} = 'Ще бъдат импортирани следните роли';
    $Self->{Translation}->{'Note that also corresponding dynamic fields and GeneralCatalog classes will be created and there is no automatic removal.'} =
        'Обърнете внимание, че ще бъдат създадени и съответните динамични полета и класове GeneralCatalog и няма да има автоматично премахване.';
    $Self->{Translation}->{'Do you want to proceed?'} = 'Искате ли да продължите?';

    # Perl Module: Kernel/Modules/AdminITSMConfigItem.pm
    $Self->{Translation}->{'Need ExampleClasses!'} = 'Нуждаете се от примерни класове!';
    $Self->{Translation}->{'Definition is no valid YAML hash.'} = 'Дефиницията не е валиден хеш на YAML.';

    # Perl Module: Kernel/Modules/AgentITSMConfigItem.pm
    $Self->{Translation}->{'Overview: ITSM ConfigItem'} = 'Преглед: ITSM конфигурационен елемент';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemBulk.pm
    $Self->{Translation}->{'No ConfigItemID is given!'} = 'Не е даден ID на конфигурационен елемент!';
    $Self->{Translation}->{'You need at least one selected Configuration Item!'} = 'Имате нужда от поне един избран конфигурационен елемент!';
    $Self->{Translation}->{'You don\'t have write access to this configuration item: %s.'} =
        'Нямате достъп за запис до този конфигурационен елемент: %s.';
    $Self->{Translation}->{'No definition was defined for class %s!'} = 'Не е дефинирана дефиниция за клас %s!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemDelete.pm
    $Self->{Translation}->{'Config item "%s" not found in database!'} = 'Конфигурационният елемент "%s" не е намерен в базата данни!';
    $Self->{Translation}->{'Was not able to delete the configitem ID %s!'} = 'Не можах да изтрия ID на конфигурационния елемент %s!';
    $Self->{Translation}->{'No version found for ConfigItemID %s!'} = 'Не е намерена версия за ID на конфигурационен елемент %s!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemEdit.pm
    $Self->{Translation}->{'No ConfigItemID, DuplicateID or ClassID is given!'} = 'Не е даден идентификатор на конфигурационен елемент, дублиран идентификатор или идентификатор на клас!';
    $Self->{Translation}->{'No access is given!'} = 'Няма достъп!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemHistory.pm
    $Self->{Translation}->{'Can\'t show history, no ConfigItemID is given!'} = 'Не може да се покаже хронология, не е даден ID на елемент от конфигурацията!';
    $Self->{Translation}->{'Can\'t show history, no access rights given!'} = 'Не може да се покаже история, не са дадени права за достъп!';
    $Self->{Translation}->{'New ConfigItem (ID=%s)'} = 'Нов конфигурационен елемент (ID=%s)';
    $Self->{Translation}->{'New version (ID=%s)'} = 'Нова версия (ID=%s)';
    $Self->{Translation}->{'Deployment state updated (new=%s, old=%s)'} = 'Състоянието на използване е актуализирано (ново=%s, старо=%s)';
    $Self->{Translation}->{'Incident state updated (new=%s, old=%s)'} = 'Състоянието на инцидента е актуализирано (ново=%s, старо=%s)';
    $Self->{Translation}->{'ConfigItem (ID=%s) deleted'} = 'Конфигурационен елемент (ID=%s) е изтрит';
    $Self->{Translation}->{'Link to %s (type=%s) added'} = 'Добавена е връзка към %s (type=%s)';
    $Self->{Translation}->{'Link to %s (type=%s) deleted'} = 'Връзката към %s (type=%s) е изтрита';
    $Self->{Translation}->{'ConfigItem definition updated (ID=%s)'} = 'Дефиницията на конфигурационен елемент е актуализирана (ID=%s)';
    $Self->{Translation}->{'Name updated (new=%s, old=%s)'} = 'Името е актуализирано (ново=%s, старо=%s)';
    $Self->{Translation}->{'Attribute %s updated from "%s" to "%s"'} = 'Атрибутът %s е актуализиран от „%s“ на „%s“';
    $Self->{Translation}->{'Version %s deleted'} = 'Версия %s е изтрита';
    $Self->{Translation}->{'File "%s" uploaded'} = '';
    $Self->{Translation}->{'File "%s" removed'} = '';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemPrint.pm
    $Self->{Translation}->{'No ConfigItemID or VersionID is given!'} = 'Не е даден ID на конфигурационен елемент или ID на версия!';
    $Self->{Translation}->{'Can\'t show config item, no access rights given!'} = 'Не може да се покаже конфигурационен елемент, не са дадени права за достъп!';
    $Self->{Translation}->{'ConfigItemID %s not found in database!'} = 'ID на конфигурационен елемент %s не е намерен в базата данни!';
    $Self->{Translation}->{'ConfigItem'} = 'Конфигурационен елемент';
    $Self->{Translation}->{'printed by %s at %s'} = 'отпечатано от %s в %s';
    $Self->{Translation}->{'Referenced by'} = '';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemSearch.pm
    $Self->{Translation}->{'Invalid ClassID!'} = 'Невалиден идентификатор на клас!';
    $Self->{Translation}->{'No ClassID is given!'} = 'Не е даден идентификатор на клас!';
    $Self->{Translation}->{'No access rights for this class given!'} = 'Няма дадени права за достъп за този клас!';
    $Self->{Translation}->{'No Result!'} = 'Без резултат!';
    $Self->{Translation}->{'Config Item Search Results'} = 'Резултати от търсенето на конфигурационен елемент';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemZoom.pm
    $Self->{Translation}->{'Can\'t show item, no access rights for ConfigItem are given!'} =
        'Не може да се покаже елемент, не са дадени права за достъп за конфигурационен елемент!';
    $Self->{Translation}->{'ConfigItem not found!'} = 'Не е намерен елемент от конфигурацията!';
    $Self->{Translation}->{'No versions found!'} = 'Не са намерени версии!';
    $Self->{Translation}->{'operational'} = 'оперативен';
    $Self->{Translation}->{'warning'} = 'внимание';
    $Self->{Translation}->{'incident'} = 'инцидент';
    $Self->{Translation}->{'The deployment state of this config item'} = 'Състоянието за използване на този конфигурационен елемент';
    $Self->{Translation}->{'The incident state of this config item'} = 'Състояние на инцидента за този конфигурационен елемент';

    # Perl Module: Kernel/Modules/CustomerITSMConfigItemSearch.pm
    $Self->{Translation}->{'No permission'} = 'Няма разрешение';
    $Self->{Translation}->{'Filter invalid!'} = 'Филтърът е невалиден!';
    $Self->{Translation}->{'Search params invalid!'} = 'Невалидни параметри за търсене!';

    # Perl Module: Kernel/Output/HTML/Dashboard/ITSMConfigItemGeneric.pm
    $Self->{Translation}->{'Shown config items'} = 'Показани конфигурационни елементи';
    $Self->{Translation}->{'Deployment State Type'} = 'Тип състояние на използване';
    $Self->{Translation}->{'Current Incident State Type'} = 'Текущ тип състояние на инцидент';

    # Perl Module: Kernel/Output/HTML/ITSMConfigItem/LayoutDate.pm
    $Self->{Translation}->{'Between'} = 'Между';

    # Perl Module: Kernel/System/DynamicField/Driver/ConfigItem.pm
    $Self->{Translation}->{'Class restrictions for the config item'} = 'Ограничения на класа за елемента от конфигурацията';
    $Self->{Translation}->{'Select one or more classes to restrict selectable config items'} =
        'Изберете един или повече класове, за да ограничите избираемите елементи на конфигурацията';
    $Self->{Translation}->{'Deployment state restrictions for the config item'} = '';
    $Self->{Translation}->{'Select one or more deployment states to restrict selectable config items'} =
        '';
    $Self->{Translation}->{'Dynamic (ConfigItem)'} = 'Динамичен (ConfigItem)';
    $Self->{Translation}->{'Static (Version)'} = 'Статичен (версия)';
    $Self->{Translation}->{'Link Referencing Type'} = 'Тип препратка към връзката';
    $Self->{Translation}->{'Whether this link applies to the ConfigItem or the static version of the referencing object. Current Incident State calculation only is performed on dynamic links.'} =
        'Дали тази връзка се отнася за ConfigItem или за статичната версия на обекта, към който се препраща. Изчисляването на текущото състояние на инцидента се извършва само за динамични връзки.';
    $Self->{Translation}->{'Select the attribute which config items will be searched by'} = 'Изберете атрибута, по който ще се търсят елементите на конфигурацията';

    # Perl Module: Kernel/System/ITSMConfigItem/Definition.pm
    $Self->{Translation}->{'Base structure is not valid. Please provide a hash with data in YAML format.'} =
        'Базовата структура не е валидна. Моля, предоставете хеш с данни във формат YAML.';
    $Self->{Translation}->{'Starting the YAML string with \'---\' is required.'} = 'Изисква се низът YAML да започва с \'---\'.';

    # Perl Module: Kernel/System/ITSMConfigItem/Link.pm
    $Self->{Translation}->{'Could not purge the table configitem_link.'} = 'Не може да се изчисти таблицата configitem_link.';
    $Self->{Translation}->{'No relevant dynamic fields were found'} = 'Не бяха открити подходящи динамични полета';
    $Self->{Translation}->{'Could not insert into the table configitem_link'} = 'Не може да се вмъкне в таблицата configitem_link';
    $Self->{Translation}->{'Inserted 0 rows into the table configitem_link'} = 'Вмъкнати 0 реда в таблицата configitem_link';

    # Perl Module: Kernel/System/ImportExport/ObjectBackend/ITSMConfigItem.pm
    $Self->{Translation}->{'Maximum number of one element'} = 'Максимален брой на един елемент';
    $Self->{Translation}->{'Maximum number of one Set dynamic field element'} = '';
    $Self->{Translation}->{'Maximum number of one element within a Set dynamic field element'} =
        '';
    $Self->{Translation}->{'Import/Export attachments (as the last entries per line)'} = 'Импортиране/експортиране на прикачени файлове (като последни записи на ред)';
    $Self->{Translation}->{'Version String'} = 'Версия Редица';

    # Perl Module: Kernel/Modules/AdminDynamicField.pm
    $Self->{Translation}->{'Error synchronizing the definitions. Please check the log.'} = 'Грешка при синхронизирането на дефинициите. Моля, проверете дневника.';
    $Self->{Translation}->{'You have ITSMConfigItem definitions which are not synchronized. Please deploy your ITSMConfigItem dynamic field changes.'} =
        'Имате дефиниции на ITSMConfigItem, които не са синхронизирани. Моля, внедрете промените в динамичните полета на вашия ITSMConfigItem.';

    # Database XML / SOPM Definition: ITSMConfigurationManagement.sopm
    $Self->{Translation}->{'Expired'} = 'Изтекли';
    $Self->{Translation}->{'Maintenance'} = 'Поддръжка';
    $Self->{Translation}->{'Pilot'} = 'Пилот-водач';
    $Self->{Translation}->{'Planned'} = 'Планиран';
    $Self->{Translation}->{'Repair'} = 'Ремонт/Възстановяване';
    $Self->{Translation}->{'Retired'} = 'Излязъл от употреба';
    $Self->{Translation}->{'Review'} = 'Преглеждан';
    $Self->{Translation}->{'Test/QA'} = 'Тест/Качествен контрол';

    # JS File: ITSM.Admin.ITSMConfigItem
    $Self->{Translation}->{'Overview and Confirmation'} = 'Преглед и потвърждение';
    $Self->{Translation}->{'Importing classes/roles and their related fields'} = 'Импортиране на класове/роли и свързаните с тях полета';
    $Self->{Translation}->{'An error occurred during class import.'} = 'По време на импортирането на класа е възникнала грешка.';

    # SysConfig
    $Self->{Translation}->{'0 - Hidden'} = '0 - Скрито';
    $Self->{Translation}->{'1 - Shown'} = '1 - показано';
    $Self->{Translation}->{'A mapping of inner field names used in the Process Management TransitionActions ConfigItemAdd and -Update. The keys are the names of the set inner fields of the set with object type ticket which will be used to create/update the CI, and the values are the names of the inner fields of the set with object type ITSMConfigItem.'} =
        '';
    $Self->{Translation}->{'Allows extended search conditions in config item search of the agent interface. With this feature you can search e. g. config item name with this kind of conditions like "(*key1*&&*key2*)" or "(*key1*||*key2*)".'} =
        'Позволява разширени условия за търсене при търсене на елементи от конфигурацията в интерфейса на агента. С тази функция можете да търсите например името на елемента от конфигурацията с такива условия като "(*key1*&&*key2*)" или "(*key1*||*key2*)".';
    $Self->{Translation}->{'Allows extended search conditions in config item search of the customer interface. With this feature you can search e. g. config item name with this kind of conditions like "(*key1*&&*key2*)" or "(*key1*||*key2*)".'} =
        'Позволява разширени условия за търсене в търсенето на елементи от конфигурацията в интерфейса на клиента. С тази функция можете да търсите например името на елемента от конфигурацията с такива условия като "(*key1*&&*key2*)" или "(*key1*||*key2*)".';
    $Self->{Translation}->{'Assigned CIs'} = 'Зачислени KE';
    $Self->{Translation}->{'At a specific time point create a ticket for config items, if the configured requirements are met. The time point is determined by the value of the dynamic field of type date configured under "TimeCIKey" of the ConfigItem, and modified by "TimeModifier". If the latter can be either just a number, or a sign (+/-), a number, and an unit (d/h/m): "7" is equivalent to "+7d". The DynamicField "Ticket->DynamicField" will be used to mark created tickets - it has to exist. The flags \<OTOBO_CONFIGITEM_X\> where X can be NAME, NUMBER and DATE, will be substituted with the respective values in "Ticket->Text".'} =
        '';
    $Self->{Translation}->{'Attributes for license accounting.'} = '';
    $Self->{Translation}->{'Attributes for licenses counting, where "TotalLicensesDF", "AvailableLicensesDF" and "LicenseReferenceDF" are the names of the dynamic fields used to track the remaining licenses. If used, only deployment states in "ValidDeplStates" are considered. If a threshold is defined in "MinimumLicenses", a ticket will automatically be created if less licenses are available. For this, the checkbox dynamic field "Ticket->DynamicField" must exist. The tags \<OTOBO_CONFIGITEM_X\> where X can be NAME, NUMBER, LICENSES_AVAIL and LICENSES_MIN, will be substituted with the respective values in "Ticket->Text" by the config item name, number, available licenses, and minimum required available licenses, respectively.'} =
        '';
    $Self->{Translation}->{'CIs assigned to customer company'} = 'KE зачислени на компанията клиент';
    $Self->{Translation}->{'CIs assigned to customer user'} = 'КЕ, зачислени на потребител';
    $Self->{Translation}->{'CMDB Settings'} = 'Настройка на CMDB';
    $Self->{Translation}->{'Check for a unique name only within the same ConfigItem class (\'class\') or globally (\'global\'), which means every existing ConfigItem is taken into account when looking for duplicates.'} =
        'Проверявайте за уникално име само в рамките на един и същ клас на конфигурационен елемент („клас“) или глобално („глобален“), което означава, че всеки съществуващ конфигурационен елемент се взема предвид, когато се търсят дубликати.';
    $Self->{Translation}->{'Choose a module to enforce a naming scheme.'} = 'Изберете модул за налагане на схема за именуване.';
    $Self->{Translation}->{'Choose a module to enforce a number scheme.'} = 'Изберете модул за налагане на схема на номерата.';
    $Self->{Translation}->{'Choose a module to enforce a version string scheme.'} = 'Изберете модул, който да налага схема с низ от версии.';
    $Self->{Translation}->{'Choose attributes to trigger the creation of a new version.'} = 'Изберете атрибути, които да задействат създаването на нова версия.';
    $Self->{Translation}->{'Choose categories to assign to this config item class.'} = 'Изберете категории, които да присвоите на този клас елементи на конфигурацията.';
    $Self->{Translation}->{'Column config item filters for ConfigItem Overview.'} = 'Филтри за елементи на колоната за ConfigItem Overview.';
    $Self->{Translation}->{'Columns that can be filtered in the config item overview of the agent interface. Note: Only Config Item attributes and Dynamic Fields (DynamicField_NameX) are allowed.'} =
        'Колони, които могат да се филтрират в прегледа на елементите на конфигурацията в интерфейса на агента. Забележка: Разрешени са само атрибути на елемента на конфигурацията и динамични полета (DynamicField_NameX).';
    $Self->{Translation}->{'Config Items'} = 'Конфигурационни елементи';
    $Self->{Translation}->{'Config item add.'} = 'Добавяне на конфигурационен елемент.';
    $Self->{Translation}->{'Config item edit.'} = 'Редактиране на конфигурационен елемент.';
    $Self->{Translation}->{'Config item event module that enables accounting licenses for a given config item.'} =
        '';
    $Self->{Translation}->{'Config item event module that enables logging to history in the agent interface.'} =
        'Модул за събитие за конфигуриране на елемент, който позволява записване в хронология в интерфейса на агента.';
    $Self->{Translation}->{'Config item event module that updates config items to their current definition.'} =
        'Модул за събития на елементите на конфигурацията, който актуализира елементите на конфигурацията до текущата им дефиниция.';
    $Self->{Translation}->{'Config item history.'} = 'Конфигурирайте хронологията на елементите.';
    $Self->{Translation}->{'Config item print.'} = 'Печат на конфигурационен елемент.';
    $Self->{Translation}->{'Config item zoom.'} = 'Конфигуриране на мащаба на елемента.';
    $Self->{Translation}->{'ConfigItem Tree View'} = 'Изглед на дървото на елементите на конфигурацията';
    $Self->{Translation}->{'ConfigItem Version'} = 'Версия на елемента ConfigItem';
    $Self->{Translation}->{'ConfigItems of the following classes will not be stored on the Elasticsearch server. To apply this to existing CIs, the CI migration has to be run via console, after changing this option.'} =
        'ConfigItems от следните класове няма да се съхраняват на сървъра Elasticsearch. За да приложите това към съществуващи CI, миграцията на CI трябва да се стартира чрез конзолата, след като промените тази опция.';
    $Self->{Translation}->{'ConfigItems with the following deployment states will not be stored on the Elasticsearch server. To apply this to existing CIs, the CI migration has to be run via console, after changing this option.'} =
        'ConfigItems със следните състояния на внедряване няма да се съхраняват на сървъра Elasticsearch. За да приложите това към съществуващи CI, миграцията на CI трябва да се стартира чрез конзолата, след като промените тази опция.';
    $Self->{Translation}->{'Configuration Item Limit'} = 'Лимит за конфигурационен елемент';
    $Self->{Translation}->{'Configuration Item limit per page.'} = 'Лимит за конфигурационен елемент на страница.';
    $Self->{Translation}->{'Configuration Management Database.'} = 'База данни за управление на конфигурацията.';
    $Self->{Translation}->{'Configuration item bulk module.'} = 'Групов модул за конфигурационен елемент.';
    $Self->{Translation}->{'Configuration item search backend router of the agent interface.'} =
        'Модул за търсене на конфигурационен елемент на интерфейса на агента.';
    $Self->{Translation}->{'Configure the columns which are available for viewing Permission Conditions in the customer interface, when the corresponding Permission Condition Columns are not specifically configured. This setting is used as a fallback for the other Permission Condition Columns settings.'} =
        '';
    $Self->{Translation}->{'Configure the columns which are available when viewing the corresponding Permission Condition in the customer interface.'} =
        '';
    $Self->{Translation}->{'Create and manage the definitions for Configuration Items.'} = 'Създавайте и управлявайте дефинициите за конфигурационни елементи.';
    $Self->{Translation}->{'Creates Tickets for ConfigItems at specific time points.'} = 'Създава билети за ConfigItems в определени моменти от време.';
    $Self->{Translation}->{'Customers can see historic CI versions.'} = 'Клиентите могат да виждат исторически версии на CI.';
    $Self->{Translation}->{'Customers have the possibility to manually switch between historic CI versions.'} =
        'Клиентите имат възможност ръчно да превключват между историческите версии на CI.';
    $Self->{Translation}->{'Default data to use on attribute for config item search screen. Example: "ITSMConfigItemCreateTimePointFormat=year;ITSMConfigItemCreateTimePointStart=Last;ITSMConfigItemCreateTimePoint=2;".'} =
        'Данни по подразбиране, които да се използват в атрибута за екрана за търсене на елементи от конфигурацията. Пример: "ITSMConfigItemCreateTimePointFormat=year;ITSMConfigItemCreateTimePointStart=Last;ITSMConfigItemCreateTimePoint=2;".';
    $Self->{Translation}->{'Default data to use on attribute for config item search screen. Example: "ITSMConfigItemCreateTimeStartYear=2010;ITSMConfigItemCreateTimeStartMonth=10;ITSMConfigItemCreateTimeStartDay=4;ITSMConfigItemCreateTimeStopYear=2010;ITSMConfigItemCreateTimeStopMonth=11;ITSMConfigItemCreateTimeStopDay=3;".'} =
        'Данни по подразбиране, които да се използват в атрибута за екрана за търсене на елементи от конфигурацията. Пример: "ITSMConfigItemCreateTimeStartYear=2010;ITSMConfigItemCreateTimeStartMonth=10;ITSMConfigItemCreateTimeStartDay=4;ITSMConfigItemCreateTimeStopYear=2010;ITSMConfigItemCreateTimeStopMonth=11;ITSMConfigItemCreateTimeStopDay=3;".';
    $Self->{Translation}->{'Define Actions where a settings button is available in the linked objects widget (LinkObject::ViewMode = "complex"). Please note that these Actions must have registered the following JS and CSS files: Core.AllocationList.css, Core.UI.AllocationList.js, Core.UI.Table.Sort.js, Core.Agent.TableFilters.js and Core.Agent.LinkObject.js.'} =
        'Дефинирайте действия, при които е наличен бутон за настройки в приспособлението за свързани обекти (LinkObject::ViewMode = "complex"). Моля, обърнете внимание, че тези действия трябва да са регистрирали следните JS и CSS файлове: Core.AllocationList.css, Core.UI.AllocationList.js, Core.UI.Table.Sort.js, Core.Agent.TableFilters.js и Core.Agent .LinkObject.js.';
    $Self->{Translation}->{'Define a Template::Toolkit scheme for version strings. Only used if Version String Module is set to TemplateToolkit.'} =
        'Дефиниране на схема на Template::Toolkit за низове на версии. Използва се само ако модулът Version String Module е зададен на TemplateToolkit.';
    $Self->{Translation}->{'Define a set of conditions under which a customer is allowed to see a config item. Conditions can optionally be restricted to certain customer groups. Name is the only mandatory attribute. If no other options are given, all config items will be visible under that category.'} =
        'Дефинирайте набор от условия, при които на клиента се разрешава да вижда даден елемент от конфигурацията. Условията могат по желание да бъдат ограничени до определени групи клиенти. Името е единственият задължителен атрибут. Ако не са зададени други опции, всички елементи на конфигурацията ще бъдат видими в тази категория.';
    $Self->{Translation}->{'Defines Required permissions to delete ITSM configuration items using the Generic Interface.'} =
        'Дефинира необходимите разрешения за изтриване на елементи от конфигурацията на ITSM с помощта на общия интерфейс.';
    $Self->{Translation}->{'Defines Required permissions to get ITSM configuration items using the Generic Interface.'} =
        'Дефинира необходимите разрешения за получаване на ITSM конфигурационни елементи с помощта на общия интерфейс.';
    $Self->{Translation}->{'Defines Required permissions to search ITSM configuration items using the Generic Interface.'} =
        'Дефинира необходимите разрешения за търсене на ITSM конфигурационни елементи с помощта на общия интерфейс.';
    $Self->{Translation}->{'Defines Required permissions to set ITSM configuration items using the Generic Interface.'} =
        'Дефинира Задължителни разрешения за задаване на елементи от конфигурацията на ITSM с помощта на общия интерфейс.';
    $Self->{Translation}->{'Defines an overview module to show the small view of a configuration item list.'} =
        'Дефинира модул за преглед, за да покаже малък изглед на списък с конфигурационни елементи.';
    $Self->{Translation}->{'Defines if the link type labels must be shown in the node connections.'} =
        'Определя дали етикетите за типа на връзката трябва да се показват във връзките на възлите.';
    $Self->{Translation}->{'Defines regular expressions individually for each ConfigItem class to check the ConfigItem name and to show corresponding error messages.'} =
        'Дефинира регулярни изрази индивидуално за всеки клас на конфигурационен елемент, за да провери името на конфигурационния елемент и да покаже съответните съобщения за грешка.';
    $Self->{Translation}->{'Defines the available columns of CIs in the config item overview depending on the CI class. Each entry must consist of a class name and an array of available fields for the corresponding class. Dynamic field entries have to honor the scheme DynamicField_FieldName.'} =
        'Определя наличните колони на CI в прегледа на елементите на конфигурацията в зависимост от класа CI. Всеки запис трябва да се състои от име на клас и масив от налични полета за съответния клас. Записите за динамични полета трябва да отговарят на схемата DynamicField_FieldName.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of the agent interface.'} =
        'Определя атрибута по подразбиране на елемента на конфигурацията за сортиране на елементите на конфигурацията в резултата от търсенето на елементите на конфигурацията в интерфейса на агента.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of the customer interface.'} =
        'Дефинира атрибута на елемента на конфигурацията по подразбиране за сортиране на елементите на конфигурацията в резултата от търсенето на елементите на конфигурацията в клиентския интерфейс.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of this operation.'} =
        'Определя атрибута по подразбиране на елемента на конфигурацията за сортиране на елементите на конфигурацията в резултата от търсенето на елемента на конфигурацията на тази операция.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the agent interface. Up: oldest on top. Down: latest on top.'} =
        'Определя реда по подразбиране на елементите на конфигурацията в резултата от търсенето на елементите на конфигурацията в интерфейса на агента. Нагоре: най-старият отгоре. Надолу: най-новият отгоре.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the customer interface. Up: oldest on top. Down: latest on top.'} =
        'Определя реда по подразбиране на елементите на конфигурацията в резултата от търсенето на елементи на конфигурацията в интерфейса на клиента. Нагоре: най-старият отгоре. Надолу: най-новият отгоре.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the this operation. Up: oldest on top. Down: latest on top.'} =
        'Определя реда по подразбиране на елементите на конфигурацията в резултата от търсенето на елементите на конфигурацията на тази операция. Нагоре: най-старият отгоре. Надолу: най-новите отгоре.';
    $Self->{Translation}->{'Defines the default displayed columns of CIs in the config item overview depending on the CI class. Each entry must consist of a class name and an array of available fields for the corresponding class. Dynamic field entries have to honor the scheme DynamicField_FieldName.'} =
        'Дефинира колоните по подразбиране, които се показват на CI в прегледа на елементите на конфигурацията, в зависимост от класа на CI. Всеки запис трябва да се състои от име на клас и масив от наличните полета за съответния клас. Записите за динамични полета трябва да отговарят на схемата DynamicField_FieldName.';
    $Self->{Translation}->{'Defines the default relations depth to be shown.'} = 'Определя дълбочината на отношенията по подразбиране, които ще се показват.';
    $Self->{Translation}->{'Defines the default shown config item search attribute for config item search screen.'} =
        'Дефинира показания по подразбиране атрибут за търсене на елементи на конфигурацията за екрана за търсене на елементи на конфигурацията.';
    $Self->{Translation}->{'Defines the default shown config item search attribute for config item search screen. Example: "Key" must have the name of the Dynamic Field in this case \'X\', "Content" must have the value of the Dynamic Field depending on the Dynamic Field type,  Text: \'a text\', Dropdown: \'1\', Date/Time: \'Search_DynamicField_XTimeSlotStartYear=1974; Search_DynamicField_XTimeSlotStartMonth=01; Search_DynamicField_XTimeSlotStartDay=26; Search_DynamicField_XTimeSlotStartHour=00; Search_DynamicField_XTimeSlotStartMinute=00; Search_DynamicField_XTimeSlotStartSecond=00; Search_DynamicField_XTimeSlotStopYear=2013; Search_DynamicField_XTimeSlotStopMonth=01; Search_DynamicField_XTimeSlotStopDay=26; Search_DynamicField_XTimeSlotStopHour=23; Search_DynamicField_XTimeSlotStopMinute=59; Search_DynamicField_XTimeSlotStopSecond=59;\' and or \'Search_DynamicField_XTimePointFormat=week; Search_DynamicField_XTimePointStart=Before; Search_DynamicField_XTimePointValue=7\';.'} =
        'Дефинира показания по подразбиране атрибут за търсене на елементи на конфигурацията за екрана за търсене на елементи на конфигурацията. Пример: "Key" (Ключ) трябва да съдържа името на динамичното поле в този случай "X", "Content" (Съдържание) трябва да съдържа стойността на динамичното поле в зависимост от типа на динамичното поле, Text (Текст): "a text" (текст), Dropdown (падащо): "1" (1), Date/Time (Дата/час): "Search_DynamicField_XTimeSlotStartYear=1974; Search_DynamicField_XTimeSlotStartMonth=01; Search_DynamicField_XTimeSlotStartDay=26; Search_DynamicField_XTimeSlotStartHour=00; Search_DynamicField_XTimeSlotStartMinute=00; Search_DynamicField_XTimeSlotStartSecond=00; Search_DynamicField_XTimeSlotStopYear=2013; Search_DynamicField_XTimeSlotStopMonth=01; Search_DynamicField_XTimeSlotStopDay=26; Search_DynamicField_XTimeSlotStopHour=23; Search_DynamicField_XTimeSlotStopMinute=59; Search_DynamicField_XTimeSlotStopSecond=59;\' и или \'Search_DynamicField_XTimePointFormat=седмица; Search_DynamicField_XTimePointStart=Преди; Search_DynamicField_XTimePointValue=7\';.';
    $Self->{Translation}->{'Defines the default subobject of the class \'ITSMConfigItem\'.'} =
        'Дефинира подобекта по подразбиране на класа „ITSM конфигурационен елемент“.';
    $Self->{Translation}->{'Defines the disabled columns of CIs in the config item overview depending on the CI class. Each entry must consist of a class name and an array of available fields for the corresponding class. Dynamic field entries have to honor the scheme DynamicField_FieldName.'} =
        '';
    $Self->{Translation}->{'Defines the height for the rich text editor component for this screen. Enter number (pixels) or percent value (relative).'} =
        'Определя височината на компонента на редактора за богат текст за този екран. Въведете число (пиксели) или процентна стойност (относителна).';
    $Self->{Translation}->{'Defines the number of rows for the CI definition editor in the admin interface.'} =
        'Определя броя на редовете за редактора на КЕ дефиниции в администраторския интерфейс.';
    $Self->{Translation}->{'Defines the order of incident states from high (e.g. cricital) to low (e.g. functional).'} =
        'Определя реда на инцидентните състояния от високо (напр. критично) до ниско (напр. функционално).';
    $Self->{Translation}->{'Defines the relevant deployment states where linked tickets can affect the status of a CI.'} =
        'Дефинира съответните състояния на внедряване, при които свързаните билети могат да повлияят на състоянието на КЕ.';
    $Self->{Translation}->{'Defines the search limit for the AgentITSMConfigItem screen.'} =
        'Определя ограничението за търсене на екрана за ITSM конфигурационен елемент на агента.';
    $Self->{Translation}->{'Defines the search limit for the AgentITSMConfigItemSearch screen.'} =
        'Определя ограничението за търсене в екрана за търсене на елемент за конфигурация на агента ITSM.';
    $Self->{Translation}->{'Defines the search limit for the CustomerITSMConfigItem screen.'} =
        'Определя ограничението за търсене на екрана CustomerITSMConfigItem.';
    $Self->{Translation}->{'Defines the search limit for the CustomerITSMConfigItemSearch screen.'} =
        'Определя ограничението за търсене на екрана CustomerITSMConfigItemSearch.';
    $Self->{Translation}->{'Defines the shown columns of CIs in the link table complex view for all CI classes. If there is no entry, then the default columns are shown.'} =
        'Дефинира показаните колони от КЕ в комплексния изглед на таблицата за връзки за всички класове КЕ. Ако няма запис, се показват колоните по подразбиране.';
    $Self->{Translation}->{'Defines the shown columns of CIs in the link table complex view, depending on the CI class. Each entry must be prefixed with the class name and double colons (i.e. Computer::). There are a few CI-Attributes that common to all CIs (example for the class Computer: Computer::Name, Computer::CurDeplState, Computer::CreateTime). To show individual CI-Attributes as defined in the CI-Definition, the following scheme must be used (example for the class Computer): Computer::HardDisk::1, Computer::HardDisk::1::Capacity::1, Computer::HardDisk::2, Computer::HardDisk::2::Capacity::1. If there is no entry for a CI class, then the default columns are shown.'} =
        'Дефинира показаните колони от КЕ в сложния изглед на таблицата с връзки, в зависимост от класа на КЕ. Всеки запис трябва да има префикс с името на класа и двойно двоеточие (т.е. компютър ::). Има няколко КЕ-атрибута, които са общи за всички КЕ (пример за класа Computer: Computer::Name, Computer::CurDeplState, Computer::CreateTime). За да се покажат отделни КЕ-атрибути, както са дефинирани в КЕ-дефиницията, трябва да се използва следната схема (пример за класа Computer): Computer::HardDisk::1, Computer::HardDisk::1::Capacity::1, Computer::HardDisk::2, Computer::HardDisk::2::Capacity::1. Ако няма запис за КЕ клас, тогава се показват колоните по подразбиране.';
    $Self->{Translation}->{'Defines which items are available for \'Action\' in third level of the ITSM Config Item ACL structure.'} =
        'Определя кои елементи са достъпни за "Действие" в третото ниво на структурата ITSM Config Item ACL.';
    $Self->{Translation}->{'Defines which items are available in first level of the ITSM Config Item ACL structure.'} =
        'Определя кои елементи са налични в първото ниво на структурата ITSM Config Item ACL.';
    $Self->{Translation}->{'Defines which items are available in second level of the ITSM Config Item ACL structure.'} =
        'Определя кои елементи са налични във второто ниво на структурата ITSM Config Item ACL.';
    $Self->{Translation}->{'Defines which type of link (named from the ticket perspective) can affect the status of a linked CI.'} =
        'Определя кой тип връзка (назован от гледна точка на билета) може да повлияе на състоянието на свързан КЕ.';
    $Self->{Translation}->{'Defines which type of ticket can affect the status of a linked CI.'} =
        'Определя кой тип билет може да повлияе на състоянието на свързан КЕ.';
    $Self->{Translation}->{'Definition Update'} = 'Актуализация на определението';
    $Self->{Translation}->{'Delete Configuration Item'} = 'Изтриване на елемент от конфигурацията';
    $Self->{Translation}->{'DeplState'} = 'DeplState';
    $Self->{Translation}->{'Deployment State Color'} = 'Цвят за състоянието на използване';
    $Self->{Translation}->{'DeploymentState'} = 'Състояние на внедряване';
    $Self->{Translation}->{'Duplicate'} = 'Направи копие';
    $Self->{Translation}->{'Dynamic field event module that marks config item definitions as out of sync, if containing dynamic fields change.'} =
        'Модул за събития с динамични полета, който маркира дефинициите на елементите на конфигурацията като несинхронизирани, ако съдържащите ги динамични полета се променят.';
    $Self->{Translation}->{'Dynamic fields shown in the additional ITSM field screen of the agent interface.'} =
        'Динамични полета, показани в екрана за допълнителни полета на ITSM интерфейса на агента.';
    $Self->{Translation}->{'Dynamic fields shown in the config item overview screen of the customer interface.'} =
        'Динамични полета, показани в екрана за преглед на елементите на конфигурацията в клиентския интерфейс.';
    $Self->{Translation}->{'Dynamic fields shown in the config item search screen of the agent interface.'} =
        'Динамични полета, показани в екрана за търсене на елементи на конфигурацията в интерфейса на агента.';
    $Self->{Translation}->{'Enables configuration item bulk action feature for the agent frontend to work on more than one configuration item at a time.'} =
        'Разрешава функцията за групово действие на конфигурационен елемент за интерфейса на агента да работи върху повече от един конфигурационен елемент наведнъж.';
    $Self->{Translation}->{'Enables configuration item bulk action feature only for the listed groups.'} =
        'Активира функцията за групово действие на конфигурационен елемент само за изброените групи.';
    $Self->{Translation}->{'Enables/disables the functionality to check ITSM onfiguration items for unique names. Before enabling this option you should check your system for already existing config items with duplicate names. You can do this with the console command Admin::ITSM::ConfigItem::ListDuplicates.'} =
        'Активира/деактивира функционалността за проверка на елементите от конфигурацията на ITSM за уникални имена. Преди да активирате тази опция, трябва да проверите системата си за вече съществуващи елементи на конфигурацията с дублиращи се имена. Можете да направите това с конзолната команда Admin::ITSM::ConfigItem::ListDuplicates.';
    $Self->{Translation}->{'Event module to set configitem-status on ticket-configitem-link.'} =
        'Модул на събитие за задаване за състояние на конфигурационен елемент за връзка за билет-конфигурационен елемент.';
    $Self->{Translation}->{'Fields of the configuration item index, used for the fulltext search. Fields are also stored, but are not mandatory for the overall functionality. Inclusion of attachments can be disabled by setting the entry to 0 or deleting it.'} =
        'Полета от индекса на елемента на конфигурацията, използвани за пълнотекстово търсене. Полетата също се съхраняват, но не са задължителни за цялостната функционалност. Включването на прикачени файлове може да бъде забранено чрез задаване на стойност 0 или изтриване на записа.';
    $Self->{Translation}->{'Fields stored in the configuration item index which are used for other things besides fulltext searches. For the complete functionality all fields are mandatory.'} =
        'Полета, съхранявани в индекса на елемента на конфигурацията, които се използват за други цели, освен за пълнотекстово търсене. За пълната функционалност всички полета са задължителни.';
    $Self->{Translation}->{'For every webservice (key) an array of classes (value) can be defined on which the import is restricted. For all chosen classes, or all existing classes the identifying attributes will have to be chosen in the invoker config.'} =
        'За всяка уеб услуга (ключ) може да се дефинира масив от класове (стойност), за които вносът е ограничен. За всички избрани класове или за всички съществуващи класове идентифициращите атрибути ще трябва да бъдат избрани в конфигурацията на извикващия.';
    $Self->{Translation}->{'GenericInterface module registration for the ConfigItemCreate invoker layer.'} =
        '';
    $Self->{Translation}->{'GenericInterface module registration for the ConfigItemFetch invoker layer.'} =
        'Регистриране на модул GenericInterface за слоя за извикване на ConfigItemFetch.';
    $Self->{Translation}->{'GenericInterface module registration for the ConfigItemUpdate invoker layer.'} =
        '';
    $Self->{Translation}->{'ITSM ConfigItem'} = 'ITSM ConfigItem';
    $Self->{Translation}->{'ITSM config item overview.'} = 'Преглед на ITSM конфигурационен елемент.';
    $Self->{Translation}->{'InciState'} = 'InciState';
    $Self->{Translation}->{'IncidentState'} = 'IncidentState';
    $Self->{Translation}->{'Includes deployment states in the config item search of the customer interface.'} =
        'Включва състояния на внедряване в търсенето на елементи на конфигурацията в клиентския интерфейс.';
    $Self->{Translation}->{'Includes incident states in the config item search of the customer interface.'} =
        'Включва състояния на инциденти в търсенето на елементи от конфигурацията в интерфейса на клиента.';
    $Self->{Translation}->{'License accounting configuration item event module.'} = '';
    $Self->{Translation}->{'Maximum number of config items to be displayed in the result of this operation.'} =
        'Максимален брой елементи на конфигурацията, които да бъдат показани в резултата от тази операция.';
    $Self->{Translation}->{'Module to check the group responsible for a class.'} = 'Модул за проверка на групата, отговаряща за даден клас.';
    $Self->{Translation}->{'Module to check the group responsible for a configuration item.'} =
        'Модул за проверка на групата, отговорна за конфигурационен елемент.';
    $Self->{Translation}->{'Module to generate ITSM config item statistics.'} = 'Модул за генериране на статистически данни за ITSM конфигурационен елемент.';
    $Self->{Translation}->{'Name Module'} = 'Име на модула';
    $Self->{Translation}->{'Number Module'} = 'Номер на модула';
    $Self->{Translation}->{'Number of config items to be displayed in each page of a search result in the agent interface.'} =
        'Брой на елементите на конфигурацията, които да се показват на всяка страница от резултата от търсенето в интерфейса на агента.';
    $Self->{Translation}->{'Number of config items to be displayed in each page of a search result in the customer interface.'} =
        'Брой на елементите на конфигурацията, които да се показват на всяка страница на резултата от търсенето в интерфейса на клиента.';
    $Self->{Translation}->{'Objects to search for, how many entries and which attributs to show. ConfigItem attributes have to explicitly be stored via Elasticsearch.'} =
        'Обекти, които да се търсят, колко записи и кои атрибути да се показват. Атрибутите на ConfigItem трябва изрично да се съхраняват чрез Elasticsearch.';
    $Self->{Translation}->{'Overview.'} = 'Преглед.';
    $Self->{Translation}->{'Parameters for the categories for config item classes in the preferences view of the agent interface.'} =
        'Параметри за категориите за класовете на елементите на конфигурацията в изгледа на предпочитанията на интерфейса на агента.';
    $Self->{Translation}->{'Parameters for the column filters of the small config item overview. Please note: setting \'Active\' to 0 will only prevent agents from editing settings of this group in their personal preferences, but will still allow administrators to edit the settings of another user\'s behalf. Use \'PreferenceGroup\' to control in which area these settings should be shown in the user interface.'} =
        'Параметри за филтрите на колоните в прегледа на малкия елемент на конфигурацията. Моля, обърнете внимание: задаването на стойност "Активен" на 0 ще попречи само на агентите да редактират настройките на тази група в личните си предпочитания, но все пак ще позволи на администраторите да редактират настройките от името на друг потребител. Използвайте \'PreferenceGroup\' (Група предпочитания), за да контролирате в коя област на потребителския интерфейс да се показват тези настройки.';
    $Self->{Translation}->{'Parameters for the dashboard backend of the customer company config item overview of the agent interface . "Limit" is the number of entries per config item class shown by default. "Group" is used to restrict the access to the plugin (e. g. Group: admin;group1;group2;). "Default" determines if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" is the cache time in minutes for the plugin. "ConfigItemKey" is used to specify which reference field is used for a ConfigItem class (Key=Class, Value=DynamicFieldName).'} =
        '';
    $Self->{Translation}->{'Parameters for the dashboard backend of the customer company config item overview of the agent interface . "Limit" is the number of entries shown by default. "Group" is used to restrict the access to the plugin (e. g. Group: admin;group1;group2;). "Default" determines if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" is the cache time in minutes for the plugin. "ConfigItemKey" is used to specify which reference field is used for a ConfigItem class (Key=Class, Value=DynamicFieldName).'} =
        '';
    $Self->{Translation}->{'Parameters for the deployment states color in the preferences view of the agent interface.'} =
        'Параметрите за състоянието на използване се оцветяват в изгледа с предпочитания от интерфейса на агента.';
    $Self->{Translation}->{'Parameters for the deployment states in the preferences view of the agent interface.'} =
        'Параметри за състоянията на използване в изгледа с предпочитания от интерфейса на агента.';
    $Self->{Translation}->{'Parameters for the example permission groups of the general catalog attributes.'} =
        'Параметри за примерните разрешителни групи от атрибутите на общия каталог.';
    $Self->{Translation}->{'Parameters for the name module for config item classes in the preferences view of the agent interface.'} =
        'Параметри за модула на имената за класовете на елементите на конфигурацията в изгледа на предпочитанията на интерфейса на агента.';
    $Self->{Translation}->{'Parameters for the number module for config item classes in the preferences view of the agent interface.'} =
        'Параметри за модула за номера на класовете на елементите на конфигурацията в изгледа на предпочитанията на интерфейса на агента.';
    $Self->{Translation}->{'Parameters for the pages (in which the configuration items are shown).'} =
        'Параметри за страниците (в които се показват конфигурационните елементи).';
    $Self->{Translation}->{'Parameters for the version string module for config item classes in the preferences view of the agent interface.'} =
        'Параметри за модула за низ от версии за класовете на елементите на конфигурацията в изгледа за предпочитания на интерфейса на агента.';
    $Self->{Translation}->{'Parameters for the version string template toolkit module for config item classes in the preferences view of the agent interface.'} =
        'Параметри за модула на набора от инструменти за шаблони за низ от версии за класовете на елементите на конфигурацията в изгледа на предпочитанията на интерфейса на агента.';
    $Self->{Translation}->{'Parameters for the version trigger for config item classes in the preferences view of the agent interface.'} =
        'Параметри за задействане на версията за класовете елементи на конфигурацията в изгледа за предпочитания на интерфейса на агента.';
    $Self->{Translation}->{'Performs the configured action for each event (as an Invoker) for each configured Webservice.'} =
        'Извършва конфигурираното действие за всяко събитие (като Invoker) за всяка конфигурирана уеб услуга.';
    $Self->{Translation}->{'Permission Group'} = 'Група разрешения';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item attachment action in the agent interface.'} =
        'Необходими разрешения за използване на действието за прикачване на елемент от конфигурацията на ITSM в интерфейса на агента.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item screen in the agent interface.'} =
        'Необходими права за използване на екрана за ITSM конфигурационен елемент в интерфейса на агента.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item search screen in the agent interface.'} =
        'Необходими права за използване на екрана за търсене на ITSM конфигурационен елемент в интерфейса на агента.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item search screen in the customer interface.'} =
        'Необходими разрешения за използване на екрана за търсене на елементи от конфигурацията на ITSM в клиентския интерфейс.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item tree view screen in the agent interface.'} =
        'Необходими разрешения за използване на екрана с дървовидния изглед на елементите на конфигурацията на ITSM в интерфейса на агента.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item zoom screen in the agent interface.'} =
        'Необходими права за използване на екрана за мащабиране на ITSM конфигурационен елемент в интерфейса на агента.';
    $Self->{Translation}->{'Required permissions to use the add ITSM configuration item screen in the agent interface.'} =
        'Необходими права за използване на екрана за добавяне на ITSM конфигурационен елемент в интерфейса на агента.';
    $Self->{Translation}->{'Required permissions to use the bulk ITSM configuration item screen in the agent interface.'} =
        'Необходими разрешения за използване на екрана с елементите за групова конфигурация на ITSM в интерфейса на агента.';
    $Self->{Translation}->{'Required permissions to use the edit ITSM configuration item screen in the agent interface.'} =
        'Необходими права за използване на екрана за редактиране на ITSM конфигурационен елемент в интерфейса на агента.';
    $Self->{Translation}->{'Required permissions to use the history ITSM configuration item screen in the agent interface.'} =
        'Необходими права за използване на екрана за хронологията на ITSM конфигурационния елемент в интерфейса на агента.';
    $Self->{Translation}->{'Required permissions to use the print ITSM configuration item screen in the agent interface.'} =
        'Необходими права за използване на екрана за печат на ITSM конфигурационен елемент в интерфейса на агента.';
    $Self->{Translation}->{'Required privileges to delete config items.'} = 'Необходими права за изтриване на елементи от конфигурацията.';
    $Self->{Translation}->{'Search config items.'} = 'Търсене на конфигурационни елементи.';
    $Self->{Translation}->{'Set the incident state of a CI automatically when a Ticket is Linked to a CI.'} =
        'Задайте автоматично състоянието на инцидент на КЕ, когато билетът е свързан с КЕ.';
    $Self->{Translation}->{'Sets the deployment state in the configuration item bulk screen of the agent interface.'} =
        'Задава състоянието на използване в груповия екран на конфигурационния елемент за интерфейса за агента.';
    $Self->{Translation}->{'Sets the incident state in the configuration item bulk screen of the agent interface.'} =
        'Задава състоянието на инцидента в груповия екран за конфигурационния елемент от интерфейса на агента.';
    $Self->{Translation}->{'Shows a link in the menu that allows linking a configuration item with another object in the config item zoom view of the agent interface.'} =
        'Показва връзка в менюто, което позволява свързване на конфигурационен елемент с друг обект в изгледа за мащабиране на конфигурационен елемент от интерфейса на агента.';
    $Self->{Translation}->{'Shows a link in the menu to access the history of a configuration item in the configuration item overview of the agent interface.'} =
        'Показва връзка в менюто за достъп до хронологията на конфигурационен елемент в общия преглед на конфигурационния елемент от интерфейса на агента.';
    $Self->{Translation}->{'Shows a link in the menu to access the history of a configuration item in the its zoom view of the agent interface.'} =
        'Показва връзка в менюто за достъп до хронологията на конфигурационен елемент в неговия мащабиран изглед от интерфейса на агента.';
    $Self->{Translation}->{'Shows a link in the menu to delete a configuration item in its zoom view of the agent interface.'} =
        'Показва връзка в менюто за изтриване на конфигурационен елемент в неговия увеличен изглед от интерфейса на агента.';
    $Self->{Translation}->{'Shows a link in the menu to display the configuration item links as a Tree View.'} =
        'Показва връзка в менюто за показване на връзките на елементите на конфигурацията като дървовиден изглед.';
    $Self->{Translation}->{'Shows a link in the menu to duplicate a configuration item in the configuration item overview of the agent interface.'} =
        'Показва връзка в менюто за дублиране на конфигурационен елемент при прегледа на конфигурационния елемент на интерфейса на агента.';
    $Self->{Translation}->{'Shows a link in the menu to duplicate a configuration item in the its zoom view of the agent interface.'} =
        'Показва връзка в менюто за дублиране на конфигурационен елемент в неговия мащабиран изглед от интерфейса на агента.';
    $Self->{Translation}->{'Shows a link in the menu to edit a configuration item in the its zoom view of the agent interface.'} =
        'Показва връзка в менюто за редактиране на конфигурационен елемент в неговия мащабиран изглед от интерфейса на агента.';
    $Self->{Translation}->{'Shows a link in the menu to go back in the configuration item zoom view of the agent interface.'} =
        'Показва връзка в менюто за връщане в изгледа за мащабиране на конфигурационния елемент от интерфейса на агента.';
    $Self->{Translation}->{'Shows a link in the menu to print a configuration item in the its zoom view of the agent interface.'} =
        'Показва връзка в менюто за отпечатване на конфигурационен елемент в неговия мащабиран изглед от интерфейса на агента.';
    $Self->{Translation}->{'Shows a link in the menu to zoom into a configuration item in the configuration item overview of the agent interface.'} =
        'Показва връзка в менюто за увеличаване конфигурационен елемент в прегледа на конфигурационния елемент от интерфейса на агента.';
    $Self->{Translation}->{'Shows the config item history (reverse ordered) in the agent interface.'} =
        'Показва хронологията на конфигурационния елемент (в обратен ред) в интерфейса на агента.';
    $Self->{Translation}->{'The default category which is shown, if none is selected.'} = 'Категория по подразбиране, която се показва, ако не е избрана такава.';
    $Self->{Translation}->{'The identifier for a configuration item, e.g. ConfigItem#, MyConfigItem#. The default is ConfigItem#.'} =
        'Идентификаторът за конфигурационен елемент, напр. ConfigItem#, MyConfigItem#. По подразбиране е ConfigItem#.';
    $Self->{Translation}->{'Triggers ConfigItemFetch invoker automatically.'} = 'Задейства автоматично извикването на ConfigItemFetch.';
    $Self->{Translation}->{'Version String Expression'} = 'Версия Стринг изразяване';
    $Self->{Translation}->{'Version String Module'} = 'Версия Струнен модул';
    $Self->{Translation}->{'Version Trigger'} = 'Версия Trigger';
    $Self->{Translation}->{'Whether fields should be automatically filled (1), and in that case also be hidden from ticket formulars (2).'} =
        '';
    $Self->{Translation}->{'Whether the execution of ConfigItemACL can be avoided by checking cached field dependencies. This can improve loading times of formulars, but has to be disabled, if ACLModules are to be used for ITSMConfigItem- and Form-ReturnTypes.'} =
        'Дали изпълнението на ConfigItemACL може да бъде избегнато чрез проверка на кешираните зависимости на полетата. Това може да подобри времето за зареждане на формулярите, но трябва да бъде деактивирано, ако ACLModules трябва да се използват за ITSMConfigItem- и Form-ReturnTypes.';
    $Self->{Translation}->{'Which general information is shown in the header.'} = 'Коя обща информация е показана в заглавието.';
    $Self->{Translation}->{'class'} = 'клас';
    $Self->{Translation}->{'global'} = 'глобален';
    $Self->{Translation}->{'postproductive'} = 'постпродуктивен';
    $Self->{Translation}->{'preproductive'} = 'препродуктивен';
    $Self->{Translation}->{'productive'} = 'продуктивен';

    # Ready to adopt classes: IT-Servicemanagement-11_0_3
    $Self->{Translation}->{'10U: 17.5 inches (44.45 cm)'} = '10U: 17,5 инча (44,45 см)';
    $Self->{Translation}->{'12U: 21 inches (53.34 cm)'} = '12U: 21 инча (53,34 см)';
    $Self->{Translation}->{'15U: 26.25 inches (66.68 cm)'} = '15U: 26,25 инча (66,68 см)';
    $Self->{Translation}->{'18U: 31.5 inches (80.01 cm)'} = '18U: 31,5 инча (80,01 см)';
    $Self->{Translation}->{'19-inch Rack'} = '19-инчов стелаж';
    $Self->{Translation}->{'1U: 1.75 inches (4.45 cm)'} = '1U: 1,75 инча (4,45 см)';
    $Self->{Translation}->{'20U: 35 inches (88.9 cm)'} = '20U: 35 инча (88,9 см)';
    $Self->{Translation}->{'21-inch Rack'} = '21-инчов багажник';
    $Self->{Translation}->{'22U: 38.5 inches (97.79 cm)'} = '22U: 38,5 инча (97,79 см)';
    $Self->{Translation}->{'23-inch Rack'} = '23-инчова стойка';
    $Self->{Translation}->{'23.6 inches (600 mm)'} = '23,6 инча (600 мм)';
    $Self->{Translation}->{'24U: 42 inches (106.68 cm)'} = '24U: 42 инча (106,68 см)';
    $Self->{Translation}->{'27U: 47.25 inches (120.02 cm)'} = '27U: 47,25 инча (120,02 см)';
    $Self->{Translation}->{'2U: 3.5 inches (8.89 cm)'} = '2U: 3,5 инча (8,89 см)';
    $Self->{Translation}->{'30U: 52.5 inches (133.35 cm)'} = '30U: 52,5 инча (133,35 см)';
    $Self->{Translation}->{'31.5 inches (800 mm)'} = '31,5 инча (800 мм)';
    $Self->{Translation}->{'33U: 57.75 inches (146.68 cm)'} = '33U: 57,75 инча (146,68 см)';
    $Self->{Translation}->{'35.4 inches (900 mm)'} = '35,4 инча (900 мм)';
    $Self->{Translation}->{'36U: 63 inches (160.02 cm)'} = '36U: 63 инча (160,02 см)';
    $Self->{Translation}->{'39.4 inches (1000 mm)'} = '39,4 инча (1000 мм)';
    $Self->{Translation}->{'39U: 68.25 inches (173.35 cm)'} = '39U: 68,25 инча (173,35 см)';
    $Self->{Translation}->{'3U: 5.25 inches (13.34 cm)'} = '3U: 5,25 инча (13,34 см)';
    $Self->{Translation}->{'42U: 73.5 inches (186.69 cm)'} = '42U: 73,5 инча (186,69 см)';
    $Self->{Translation}->{'43.3 inches (1100 mm):'} = '43,3 инча (1100 мм):';
    $Self->{Translation}->{'45U: 78.75 inches (200.02 cm)'} = '45U: 78,75 инча (200,02 см)';
    $Self->{Translation}->{'47.2 inches (1200 mm)'} = '47,2 инча (1200 мм)';
    $Self->{Translation}->{'48U: 84 inches (213.36 cm)'} = '48U: 84 инча (213,36 см)';
    $Self->{Translation}->{'4U: 7 inches (17.78 cm)'} = '4U: 7 инча (17,78 см)';
    $Self->{Translation}->{'5U: 8.75 inches (22.23 cm)'} = '5U: 8,75 инча (22,23 см)';
    $Self->{Translation}->{'6U: 10.5 inches (26.67 cm)'} = '6U: 10,5 инча (26,67 см)';
    $Self->{Translation}->{'7U: 12.25 inches (31.12 cm)'} = '7U: 12,25 инча (31,12 см)';
    $Self->{Translation}->{'8U: 14 inches (35.56 cm)'} = '8U: 14 инча (35,56 см)';
    $Self->{Translation}->{'9U: 15.75 inches (40.01 cm)'} = '9U: 15,75 инча (40,01 см)';
    $Self->{Translation}->{'AGPL (Affero General Public License)'} = '';
    $Self->{Translation}->{'Accounting'} = 'Счетоводство';
    $Self->{Translation}->{'Accounting Information'} = '';
    $Self->{Translation}->{'Address Allocation'} = 'Разпределение на адреси';
    $Self->{Translation}->{'Administrator'} = 'Администратор';
    $Self->{Translation}->{'Analog Phone'} = 'Аналогов телефон';
    $Self->{Translation}->{'Apache Lizenz'} = '';
    $Self->{Translation}->{'Appliance Type'} = 'Тип на уреда';
    $Self->{Translation}->{'BSD Lizenz (Berkeley Software Distribution License)'} = '';
    $Self->{Translation}->{'Battery Capacity (Ah)'} = 'Капацитет на батерията (Ah)';
    $Self->{Translation}->{'Battery Type'} = 'Тип батерия';
    $Self->{Translation}->{'Building'} = 'Сграда';
    $Self->{Translation}->{'Bus Interface'} = 'Интерфейс на шината';
    $Self->{Translation}->{'CC0 (Creative Commons Zero)'} = '';
    $Self->{Translation}->{'CIDR'} = 'CIDR';
    $Self->{Translation}->{'CPU'} = 'Процесор';
    $Self->{Translation}->{'CPU Class'} = 'Клас на процесора';
    $Self->{Translation}->{'Capacity (GB)'} = 'Капацитет (GB)';
    $Self->{Translation}->{'Capacity per graphics card'} = 'Капацитет на графична карта';
    $Self->{Translation}->{'Card Number'} = 'Номер на картата';
    $Self->{Translation}->{'Card Reader'} = 'Четец на карти';
    $Self->{Translation}->{'Card Type'} = 'Тип карта';
    $Self->{Translation}->{'Client Certificates'} = 'Клиентски сертификати';
    $Self->{Translation}->{'Client Software'} = 'Клиентски софтуер';
    $Self->{Translation}->{'Client category'} = 'Категория на клиента';
    $Self->{Translation}->{'Clockrate'} = 'Часовник';
    $Self->{Translation}->{'Clockspeed'} = 'Скорост на часовника';
    $Self->{Translation}->{'Code Signing Certificates'} = 'Сертификати за подписване на код';
    $Self->{Translation}->{'Conference Phone'} = 'Конферентен телефон';
    $Self->{Translation}->{'Consulting Agreement'} = 'Споразумение за консултиране';
    $Self->{Translation}->{'Contact'} = 'Свържете се с';
    $Self->{Translation}->{'Contact Distributor'} = 'Свържете се с дистрибутора';
    $Self->{Translation}->{'Container Management'} = 'Управление на контейнери';
    $Self->{Translation}->{'Contract'} = 'Договор';
    $Self->{Translation}->{'Contract Type'} = 'Вид на договора';
    $Self->{Translation}->{'Contract period from'} = 'Срок на договора от';
    $Self->{Translation}->{'Contract period until'} = 'Срок на договора до';
    $Self->{Translation}->{'Cordless Phone (DECT Phone)'} = 'Безжичен телефон (DECT телефон)';
    $Self->{Translation}->{'Cost unit'} = 'Разходна единица';
    $Self->{Translation}->{'Count of licenses'} = 'Брой на лицензите';
    $Self->{Translation}->{'Creation Date'} = 'Дата на създаване';
    $Self->{Translation}->{'Creative Commons'} = '';
    $Self->{Translation}->{'Custom Rack'} = 'Потребителски стелаж';
    $Self->{Translation}->{'DHCP'} = 'DHCP';
    $Self->{Translation}->{'DHCP Reserved'} = 'DHCP Запазено';
    $Self->{Translation}->{'DNS-Server'} = 'DNS-сървър';
    $Self->{Translation}->{'DVI'} = 'DVI';
    $Self->{Translation}->{'Date of Invoice'} = 'Дата на фактурата';
    $Self->{Translation}->{'Date of Order'} = 'Дата на поръчката';
    $Self->{Translation}->{'Date of Warranty'} = 'Дата на издаване на гаранцията';
    $Self->{Translation}->{'Date of release'} = 'Дата на издаване';
    $Self->{Translation}->{'Desktop'} = 'Настолен';
    $Self->{Translation}->{'DisplayPort'} = 'DisplayPort';
    $Self->{Translation}->{'Document Signing Certificates'} = 'Сертификати за подписване на документи';
    $Self->{Translation}->{'EPL (Eclipse Public License)'} = '';
    $Self->{Translation}->{'ETSI Rack'} = 'ETSI Rack';
    $Self->{Translation}->{'Email Certificates (S/MIME Certificates)'} = 'Сертификати за електронна поща (S/MIME сертификати)';
    $Self->{Translation}->{'Embedded SIM (eSIM)'} = '';
    $Self->{Translation}->{'Employment Contract'} = 'Трудов договор';
    $Self->{Translation}->{'End IP Address'} = 'Краен IP адрес';
    $Self->{Translation}->{'End of support'} = 'Край на подкрепата';
    $Self->{Translation}->{'Expiry Date'} = 'Дата на изтичане на валидността';
    $Self->{Translation}->{'External Hard Drive'} = 'Външен твърд диск';
    $Self->{Translation}->{'Firewall'} = 'Защитна стена';
    $Self->{Translation}->{'Firmware'} = 'Фърмуер';
    $Self->{Translation}->{'Flywheel Energy Storage'} = 'Съхранение на енергия чрез маховик';
    $Self->{Translation}->{'Form Factor'} = 'Фактор на формата';
    $Self->{Translation}->{'Franchise Agreement'} = 'Споразумение за франчайз';
    $Self->{Translation}->{'Freeware'} = 'Безплатно разпространяван';
    $Self->{Translation}->{'GPL (General Public License)'} = '';
    $Self->{Translation}->{'General Information'} = 'Обща информация';
    $Self->{Translation}->{'Graphics Cards'} = 'Графични карти';
    $Self->{Translation}->{'Graphics card'} = 'Графична карта';
    $Self->{Translation}->{'HDMI'} = 'HDMI';
    $Self->{Translation}->{'Hardware'} = 'Хардуер';
    $Self->{Translation}->{'Hardware Model'} = 'Модел на хардуера';
    $Self->{Translation}->{'Hardware Weight'} = 'Тегло на хардуера';
    $Self->{Translation}->{'Headset'} = 'Слушалки';
    $Self->{Translation}->{'IP Protocol'} = 'IP протокол';
    $Self->{Translation}->{'Identity and Access Management (IAM)'} = 'Управление на идентичността и достъпа (IAM)';
    $Self->{Translation}->{'Inventory Number'} = 'Инвентарен номер';
    $Self->{Translation}->{'Inverstment costs'} = 'Разходи за инвертиране';
    $Self->{Translation}->{'Invoice Number'} = 'Номер на фактурата';
    $Self->{Translation}->{'Keyboard'} = 'Клавиатура';
    $Self->{Translation}->{'LCD Monitor (Liquid Crystal Display)'} = 'LCD монитор (дисплей с течни кристали)';
    $Self->{Translation}->{'LED Monitor (Light Emitting Diode)'} = 'LED монитор (светлоизлъчващ диод)';
    $Self->{Translation}->{'LGPL (Lesser General Public License)'} = '';
    $Self->{Translation}->{'Landline Phone'} = 'Стационарен телефон';
    $Self->{Translation}->{'Laptop'} = 'Преносим';
    $Self->{Translation}->{'Latitude'} = 'Географска ширина';
    $Self->{Translation}->{'Layer 1: Physical Layer'} = 'Слой 1: Физически слой';
    $Self->{Translation}->{'Layer 2: Data Link Layer'} = 'Слой 2: Слой за връзка с данни';
    $Self->{Translation}->{'Layer 3: Network Layer'} = 'Слой 3: Мрежов слой';
    $Self->{Translation}->{'Layer 3: Network Layer (Supernet)'} = 'Слой 3: Мрежов слой (супермрежа)';
    $Self->{Translation}->{'Layer 4: Transport Layer'} = 'Слой 4: Транспортен слой';
    $Self->{Translation}->{'Layer 5: Session Layer'} = 'Слой 5: Слой на сесията';
    $Self->{Translation}->{'Layer 6: Presentation Layer'} = 'Слой 6: Слой на представяне';
    $Self->{Translation}->{'Layer 7: Application Layer'} = 'Слой 7: Слой на приложението';
    $Self->{Translation}->{'Lease Agreement'} = 'Споразумение за лизинг';
    $Self->{Translation}->{'License Agreement'} = 'Споразумение за лиценз';
    $Self->{Translation}->{'License Count'} = '';
    $Self->{Translation}->{'License Key'} = 'Ключ за лиценз';
    $Self->{Translation}->{'License Type'} = 'Вид лиценз';
    $Self->{Translation}->{'License period from'} = 'Период на лиценза от';
    $Self->{Translation}->{'License period until'} = 'Срок на лиценза до';
    $Self->{Translation}->{'Lithium Iron Phosphate (LiFePO4) Battery'} = 'Батерия от литиево-железен фосфат (LiFePO4)';
    $Self->{Translation}->{'Lithium-Ion (Li-ion) Battery'} = 'Литиево-йонна (Li-ion) батерия';
    $Self->{Translation}->{'Loan Agreement'} = 'Споразумение за заем';
    $Self->{Translation}->{'Located in'} = 'Намира се в';
    $Self->{Translation}->{'Longitude'} = 'Дължина';
    $Self->{Translation}->{'MIT Lizenz'} = '';
    $Self->{Translation}->{'MPL (Mozilla Public License)'} = '';
    $Self->{Translation}->{'Manufacturer'} = 'Производител';
    $Self->{Translation}->{'Maximum Load Capacity (W)'} = 'Максимален капацитет на натоварване (W)';
    $Self->{Translation}->{'Memory'} = 'Памет';
    $Self->{Translation}->{'Memory Type'} = 'Тип памет';
    $Self->{Translation}->{'Micro SIM'} = '';
    $Self->{Translation}->{'Mini-Rack'} = 'Mini-Rack';
    $Self->{Translation}->{'Mobile Number'} = 'Мобилен номер';
    $Self->{Translation}->{'Mobile/Embedded'} = 'Мобилни/вградени';
    $Self->{Translation}->{'Model'} = 'Модел';
    $Self->{Translation}->{'Model Description'} = 'Описание на модела';
    $Self->{Translation}->{'Monitor Resolution'} = 'Резолюция на монитора';
    $Self->{Translation}->{'Monitor Size'} = 'Размер на монитора';
    $Self->{Translation}->{'Mouse'} = 'Мишка';
    $Self->{Translation}->{'Nano SIM'} = '';
    $Self->{Translation}->{'Network'} = 'Мрежа';
    $Self->{Translation}->{'Network Info'} = 'Информация за мрежата';
    $Self->{Translation}->{'Network Information'} = 'Информация за мрежата';
    $Self->{Translation}->{'Network Layer'} = 'Мрежово ниво';
    $Self->{Translation}->{'Nickel-Cadmium (NiCd) Battery'} = 'Никел-кадмиева (NiCd) батерия';
    $Self->{Translation}->{'Nickel-Metal Hydride (NiMH) Battery'} = 'Никел-металхидридна (NiMH) батерия';
    $Self->{Translation}->{'Non-Disclosure Agreement (NDA)'} = 'Споразумение за неразкриване на информация (NDA)';
    $Self->{Translation}->{'Notebook'} = 'Бележник';
    $Self->{Translation}->{'Number of CPUs'} = 'Брой процесори';
    $Self->{Translation}->{'Number of RAM modules'} = 'Брой модули RAM';
    $Self->{Translation}->{'Number of graphics cards'} = 'Брой графични карти';
    $Self->{Translation}->{'OLED Monitor (Organic Light Emitting Diode)'} = 'OLED монитор (органичен светоизлъчващ диод)';
    $Self->{Translation}->{'Operating costs'} = 'Оперативни разходи';
    $Self->{Translation}->{'Order Number'} = 'Номер на поръчката';
    $Self->{Translation}->{'Other'} = 'Други';
    $Self->{Translation}->{'Outputs'} = 'Изходи';
    $Self->{Translation}->{'PIN'} = 'PIN';
    $Self->{Translation}->{'PIN 2'} = 'ПИН 2';
    $Self->{Translation}->{'PUK'} = 'PUK';
    $Self->{Translation}->{'PUK 2'} = 'PUK 2';
    $Self->{Translation}->{'Partnership Agreement'} = 'Споразумение за партньорство';
    $Self->{Translation}->{'Perpetual licenses'} = '';
    $Self->{Translation}->{'Phone / VoIP'} = '';
    $Self->{Translation}->{'Phone Number'} = 'Телефонен номер';
    $Self->{Translation}->{'Phone Type'} = 'Тип на телефона';
    $Self->{Translation}->{'Physical Cores'} = 'Физически ядра';
    $Self->{Translation}->{'Power Delivery'} = 'Доставка на енергия';
    $Self->{Translation}->{'Public Domain'} = '';
    $Self->{Translation}->{'Purchased at'} = 'Закупено в';
    $Self->{Translation}->{'Rack Depth'} = 'Дълбочина на стелажа';
    $Self->{Translation}->{'Rack Units (U)'} = 'Единици за стелаж (U)';
    $Self->{Translation}->{'Room'} = 'Стая';
    $Self->{Translation}->{'SIM Card'} = 'SIM карта';
    $Self->{Translation}->{'SSL/TLS Certificates'} = 'SSL/TLS сертификати';
    $Self->{Translation}->{'Sales Contract'} = 'Договор за продажба';
    $Self->{Translation}->{'Satellite Phone'} = 'Сателитен телефон';
    $Self->{Translation}->{'Sealed Lead-Acid (SLA) Battery'} = 'Запечатана оловно-киселинна батерия (SLA)';
    $Self->{Translation}->{'Seat licenses'} = '';
    $Self->{Translation}->{'Serialnumber'} = 'Сериен номер';
    $Self->{Translation}->{'Server Software'} = 'Софтуер за сървъри';
    $Self->{Translation}->{'Service Agreement'} = 'Споразумение за услуги';
    $Self->{Translation}->{'Service Tag'} = 'Сервизен етикет';
    $Self->{Translation}->{'Shareware'} = '';
    $Self->{Translation}->{'Socket Type'} = 'Тип гнездо';
    $Self->{Translation}->{'Software'} = 'Софтуер';
    $Self->{Translation}->{'Speakers'} = 'Високоговорители';
    $Self->{Translation}->{'Standard SIM'} = '';
    $Self->{Translation}->{'Start IP Address'} = 'Начален IP адрес';
    $Self->{Translation}->{'Storage'} = 'Съхранение';
    $Self->{Translation}->{'Storage Partition'} = 'Раздел за съхранение';
    $Self->{Translation}->{'Subscription-based licenses'} = '';
    $Self->{Translation}->{'Subsidiary'} = 'Дъщерно дружество';
    $Self->{Translation}->{'Summary'} = 'Резюме';
    $Self->{Translation}->{'Thin Client'} = 'Тънък клиент';
    $Self->{Translation}->{'Threads'} = 'Нишки';
    $Self->{Translation}->{'Thunderbolt'} = 'Thunderbolt';
    $Self->{Translation}->{'Total Graphics card RAM (GB)'} = 'Обща оперативна памет на графичната карта (GB)';
    $Self->{Translation}->{'Total RAM (GB)'} = 'Общо RAM (GB)';
    $Self->{Translation}->{'Touchscreen Monitor'} = 'Монитор със сензорен екран';
    $Self->{Translation}->{'Tower'} = 'Кула';
    $Self->{Translation}->{'USB Hub'} = 'USB концентратор';
    $Self->{Translation}->{'USB-C'} = 'USB-C';
    $Self->{Translation}->{'VGA'} = 'VGA';
    $Self->{Translation}->{'VPN'} = 'VPN';
    $Self->{Translation}->{'VR Headset'} = 'Слушалки за VR';
    $Self->{Translation}->{'Virtual Client'} = '';
    $Self->{Translation}->{'VirtualLink'} = 'VirtualLink';
    $Self->{Translation}->{'VoIP Phone'} = 'VoIP телефон';
    $Self->{Translation}->{'Volume licenses'} = '';
    $Self->{Translation}->{'Webcam'} = 'Уеб камера';


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

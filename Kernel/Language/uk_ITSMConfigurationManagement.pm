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

package Kernel::Language::uk_ITSMConfigurationManagement;

use strict;
use warnings;
use utf8;

sub Data {
    my $Self = shift;

    # Template: AdminITSMConfigItem
    $Self->{Translation}->{'Config Item Management'} = 'Керування елементами конфігурації';
    $Self->{Translation}->{'Change class definition'} = 'Змінити визначення класу';
    $Self->{Translation}->{'Change role definition'} = 'Змінити визначення ролі';
    $Self->{Translation}->{'Ready2Import Class Bundles'} = 'Пакети класу Ready2Import';
    $Self->{Translation}->{'Here you can import Ready2Import class bundles showcasing our most usual config items. Please note that some additional configuration may be required.'} =
        'Тут ви можете імпортувати пакунки класів Ready2Import, що містять найпоширеніші елементи конфігурації. Зверніть увагу, що може знадобитися додаткова конфігурація.';
    $Self->{Translation}->{'Update existing entities'} = 'Оновлення існуючих сутностей';
    $Self->{Translation}->{'Import Ready2Adopt class bundles'} = 'Імпорт пакетів класів Ready2Adopt';
    $Self->{Translation}->{'Config Item Class'} = 'Клас елемента конфігурації';
    $Self->{Translation}->{'Config Item Role'} = 'Елемент конфігурації Роль';

    # Template: AgentITSMConfigItemAdd
    $Self->{Translation}->{'Config Item'} = 'Елемент конфігурації';
    $Self->{Translation}->{'Filter for Classes'} = 'Фільтр для класів';
    $Self->{Translation}->{'Select a Class from the list to create a new Config Item.'} = 'Виберіть клас зі списку, щоб створити новий елемент конфігурації.';
    $Self->{Translation}->{'Class'} = 'Клас.';

    # Template: AgentITSMConfigItemBulk
    $Self->{Translation}->{'ITSM ConfigItem Bulk Action'} = 'ITSM ConfigItem Bulk Action';
    $Self->{Translation}->{'Deployment state'} = 'Стан розгортання';
    $Self->{Translation}->{'Incident state'} = 'Стан інциденту';
    $Self->{Translation}->{'Link to another'} = 'Посилання на інший';
    $Self->{Translation}->{'Invalid Configuration Item number!'} = 'Неправильний номер елемента конфігурації!';
    $Self->{Translation}->{'The number of another Configuration Item to link with.'} = 'Номер іншого елемента конфігурації, з яким потрібно зв\'язати.';

    # Template: AgentITSMConfigItemDelete
    $Self->{Translation}->{'Do you really want to delete this config item?'} = 'Ви дійсно хочете видалити цей елемент конфігурації?';

    # Template: AgentITSMConfigItemEdit
    $Self->{Translation}->{'The name of this config item'} = 'Назва цього елемента конфігурації';
    $Self->{Translation}->{'Name is already in use by the ConfigItems with the following Number(s): %s'} =
        'Ім\'я вже використовується елементами конфігурації з такими номерами: %s';
    $Self->{Translation}->{'Version Number'} = 'Номер версії';
    $Self->{Translation}->{'Version number of this config item'} = 'Номер версії цього елемента конфігурації';
    $Self->{Translation}->{'Version Number is already in use by the ConfigItems with the following Number(s): %s'} =
        'Номер версії вже використовується елементами конфігурації з такими номерами: %s';
    $Self->{Translation}->{'Deployment State'} = 'Стан розгортання';
    $Self->{Translation}->{'Incident State'} = 'Стан інциденту';

    # Template: AgentITSMConfigItemHistory
    $Self->{Translation}->{'History of Config Item: %s'} = 'Історія елемента конфігурації: %s';
    $Self->{Translation}->{'History Content'} = 'Зміст історії';
    $Self->{Translation}->{'Createtime'} = 'Час створення';
    $Self->{Translation}->{'Zoom view'} = 'Збільшений вид';

    # Template: AgentITSMConfigItemOverviewNavBar
    $Self->{Translation}->{'Config Items per page'} = 'Елементи конфігурації на сторінці';

    # Template: AgentITSMConfigItemOverviewSmall
    $Self->{Translation}->{'No config item data found.'} = 'Не знайдено даних про елемент конфігурації.';
    $Self->{Translation}->{'Select this config item'} = 'Виберіть цей елемент конфігурації';

    # Template: AgentITSMConfigItemSearch
    $Self->{Translation}->{'Run Search'} = 'Запустити пошук';
    $Self->{Translation}->{'Also search in previous versions?'} = 'Також шукати в попередніх версіях?';

    # Template: AgentITSMConfigItemTreeView
    $Self->{Translation}->{'TreeView for ConfigItem'} = 'TreeView для ConfigItem';
    $Self->{Translation}->{'Depth Level'} = 'Рівень глибини';
    $Self->{Translation}->{'Zoom In/Out'} = 'Збільшити/зменшити';
    $Self->{Translation}->{'Max links level reached for ConfigItem!'} = 'Досягнуто максимального рівня посилань для ConfigItem!';

    # Template: AgentITSMConfigItemZoom
    $Self->{Translation}->{'Configuration Item'} = 'Елемент конфігурації';
    $Self->{Translation}->{'Configuration Item Information'} = 'Інформація про елемент конфігурації';
    $Self->{Translation}->{'Current Deployment State'} = 'Поточний стан розгортання';
    $Self->{Translation}->{'Current Incident State'} = 'Поточний стан інциденту';
    $Self->{Translation}->{'Last changed'} = 'Останній раз змінено';
    $Self->{Translation}->{'Last changed by'} = 'Останній раз змінено';

    # Template: CustomerITSMConfigItem
    $Self->{Translation}->{'Your ConfigItems'} = 'Ваші елементи конфігурації';

    # Template: CustomerITSMConfigItemSearch
    $Self->{Translation}->{'ConfigItem Search'} = 'Пошук елемента конфігурації';

    # Template: AdminACL
    $Self->{Translation}->{'Object Type'} = 'Тип об\'єкта';

    # JS Template: ClassImportConfirm
    $Self->{Translation}->{'The following classes will be imported'} = 'Буде імпортовано наступні класи';
    $Self->{Translation}->{'The following roles will be imported'} = 'Будуть імпортовані наступні ролі';
    $Self->{Translation}->{'Note that also corresponding dynamic fields and GeneralCatalog classes will be created and there is no automatic removal.'} =
        'Зверніть увагу, що також будуть створені відповідні динамічні поля і класи GeneralCatalog, і автоматичне видалення не передбачено.';
    $Self->{Translation}->{'Do you want to proceed?'} = 'Хочете продовжити?';

    # Perl Module: Kernel/Modules/AdminITSMConfigItem.pm
    $Self->{Translation}->{'Need ExampleClasses!'} = 'Потрібні приклади класів!';
    $Self->{Translation}->{'Definition is no valid YAML hash.'} = 'Визначення не є коректним YAML хешем.';

    # Perl Module: Kernel/Modules/AgentITSMConfigItem.pm
    $Self->{Translation}->{'Overview: ITSM ConfigItem'} = 'Огляд: Елемент конфігурації ITSM';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemBulk.pm
    $Self->{Translation}->{'No ConfigItemID is given!'} = 'ConfigItemID не вказується!';
    $Self->{Translation}->{'You need at least one selected Configuration Item!'} = 'Вам потрібен принаймні один вибраний елемент конфігурації!';
    $Self->{Translation}->{'You don\'t have write access to this configuration item: %s.'} =
        'У вас немає прав на запис до цього елемента конфігурації: %s.';
    $Self->{Translation}->{'No definition was defined for class %s!'} = 'Для класу %s не визначено визначення!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemDelete.pm
    $Self->{Translation}->{'Config item "%s" not found in database!'} = 'Елемент конфігурації "%s" не знайдено в базі даних!';
    $Self->{Translation}->{'Was not able to delete the configitem ID %s!'} = 'Не вдалося видалити ідентифікатор конфігурації %s!';
    $Self->{Translation}->{'No version found for ConfigItemID %s!'} = 'Версію для ConfigItemID %s не знайдено!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemEdit.pm
    $Self->{Translation}->{'No ConfigItemID, DuplicateID or ClassID is given!'} = 'ConfigItemID, DuplicateID або ClassID не вказуються!';
    $Self->{Translation}->{'No access is given!'} = 'Доступ не надається!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemHistory.pm
    $Self->{Translation}->{'Can\'t show history, no ConfigItemID is given!'} = 'Неможливо показати історію, не вказано ConfigItemID!';
    $Self->{Translation}->{'Can\'t show history, no access rights given!'} = 'Неможливо показати історію, немає прав доступу!';
    $Self->{Translation}->{'New ConfigItem (ID=%s)'} = 'New ConfigItem (ID=%s)';
    $Self->{Translation}->{'New version (ID=%s)'} = 'Нова версія (ID=%s)';
    $Self->{Translation}->{'Deployment state updated (new=%s, old=%s)'} = 'Оновлено стан розгортання (новий=%s, старий=%s)';
    $Self->{Translation}->{'Incident state updated (new=%s, old=%s)'} = 'Оновлений стан інциденту (новий=%s, старий=%s)';
    $Self->{Translation}->{'ConfigItem (ID=%s) deleted'} = 'ConfigItem (ID=%s) видалено';
    $Self->{Translation}->{'Link to %s (type=%s) added'} = 'Додано посилання на %s (тип=%s)';
    $Self->{Translation}->{'Link to %s (type=%s) deleted'} = 'Посилання на %s (type=%s) видалено';
    $Self->{Translation}->{'ConfigItem definition updated (ID=%s)'} = 'Оновлено визначення ConfigItem (ID=%s)';
    $Self->{Translation}->{'Name updated (new=%s, old=%s)'} = 'Ім\'я оновлено (нове=%s, старе=%s)';
    $Self->{Translation}->{'Attribute %s updated from "%s" to "%s"'} = 'Атрибут %s змінено з "%s" на "%s"';
    $Self->{Translation}->{'Version %s deleted'} = 'Видалено версію %s';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemPrint.pm
    $Self->{Translation}->{'No ConfigItemID or VersionID is given!'} = 'ConfigItemID або VersionID не вказуються!';
    $Self->{Translation}->{'Can\'t show config item, no access rights given!'} = 'Неможливо показати елемент конфігурації, немає прав доступу!';
    $Self->{Translation}->{'ConfigItemID %s not found in database!'} = 'ConfigItemID %s не знайдено в базі даних!';
    $Self->{Translation}->{'ConfigItem'} = 'ConfigItem';
    $Self->{Translation}->{'printed by %s at %s'} = 'надруковано за допомогою %s в %s';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemSearch.pm
    $Self->{Translation}->{'Invalid ClassID!'} = 'Неправильний ClassID!';
    $Self->{Translation}->{'No ClassID is given!'} = 'ClassID не надається!';
    $Self->{Translation}->{'No access rights for this class given!'} = 'Права доступу для цього класу не надано!';
    $Self->{Translation}->{'No Result!'} = 'Безрезультатно!';
    $Self->{Translation}->{'Config Item Search Results'} = 'Результати пошуку елементів конфігурації';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemZoom.pm
    $Self->{Translation}->{'Can\'t show item, no access rights for ConfigItem are given!'} =
        'Неможливо показати елемент, немає прав доступу для ConfigItem!';
    $Self->{Translation}->{'ConfigItem not found!'} = 'ConfigItem не знайдено!';
    $Self->{Translation}->{'No versions found!'} = 'Версій не знайдено!';
    $Self->{Translation}->{'operational'} = 'оперативний';
    $Self->{Translation}->{'warning'} = 'попередження';
    $Self->{Translation}->{'incident'} = 'інцидент';
    $Self->{Translation}->{'The deployment state of this config item'} = 'Стан розгортання цього елемента конфігурації';
    $Self->{Translation}->{'The incident state of this config item'} = 'Стан інциденту цього елемента конфігурації';

    # Perl Module: Kernel/Modules/CustomerITSMConfigItemSearch.pm
    $Self->{Translation}->{'No permission'} = 'Немає прав доступу';
    $Self->{Translation}->{'Filter invalid!'} = 'Фільтр недійсний!';
    $Self->{Translation}->{'Search params invalid!'} = 'Параметри пошуку невірні!';

    # Perl Module: Kernel/Output/HTML/Dashboard/ITSMConfigItemGeneric.pm
    $Self->{Translation}->{'Shown config items'} = 'Показані елементи конфігурації';
    $Self->{Translation}->{'Deployment State Type'} = 'Тип стану розгортання';
    $Self->{Translation}->{'Current Incident State Type'} = 'Поточний стан інциденту Тип інциденту';

    # Perl Module: Kernel/Output/HTML/ITSMConfigItem/LayoutDate.pm
    $Self->{Translation}->{'Between'} = ' Між';

    # Perl Module: Kernel/System/DynamicField/Driver/ConfigItem.pm
    $Self->{Translation}->{'Class restrictions for the config item'} = 'Обмеження класів для елемента конфігурації';
    $Self->{Translation}->{'Select one or more classes to restrict selectable config items'} =
        'Виберіть один або декілька класів, щоб обмежити вибір елементів конфігурації';
    $Self->{Translation}->{'Link type'} = 'Тип посилання';
    $Self->{Translation}->{'Select the link type.'} = 'Виберіть тип посилання.';
    $Self->{Translation}->{'Forwards: Referencing (Source) -> Referenced (Target)'} = 'Вперед: Посилання (Джерело) -> Посилання (Ціль)';
    $Self->{Translation}->{'Backwards: Referenced (Source) -> Referencing (Target)'} = 'Назад: Посилання (джерело) -> Посилання (мета)';
    $Self->{Translation}->{'Link Direction'} = 'Напрямок посилання';
    $Self->{Translation}->{'The referencing object is the one containing this dynamic field, the referenced object is the one selected as value of the dynamic field.'} =
        'Об\'єкт-посилання - це об\'єкт, що містить це динамічне поле, об\'єкт, на який посилаються, - це об\'єкт, вибраний як значення динамічного поля.';
    $Self->{Translation}->{'Dynamic (ConfigItem)'} = 'Динамічний (ConfigItem)';
    $Self->{Translation}->{'Static (Version)'} = 'Статичний (версія)';
    $Self->{Translation}->{'Link Referencing Type'} = 'Тип посилання на посилання';
    $Self->{Translation}->{'Whether this link applies to the ConfigItem or the static version of the referencing object. Current Incident State calculation only is performed on dynamic links.'} =
        'Чи стосується це посилання ConfigItem або статичної версії об\'єкта, на який посилається посилання. Для динамічних посилань виконується лише обчислення поточного стану інциденту.';
    $Self->{Translation}->{'Select the attribute which config items will be searched by'} = 'Виберіть атрибут, за яким буде здійснюватися пошук елементів конфігурації';

    # Perl Module: Kernel/System/ITSMConfigItem/Definition.pm
    $Self->{Translation}->{'Base structure is not valid. Please provide a hash with data in YAML format.'} =
        'Структура бази даних невірна. Будь ласка, надайте хеш з даними у форматі YAML.';
    $Self->{Translation}->{'Starting the YAML string with \'---\' is required.'} = 'Рядок YAML потрібно починати з \'---\'.';

    # Perl Module: Kernel/System/ITSMConfigItem/Link.pm
    $Self->{Translation}->{'Could not purge the table configitem_link.'} = 'Не вдалося очистити таблицю configitem_link.';
    $Self->{Translation}->{'No relevant dynamic fields were found'} = 'Відповідних динамічних полів не знайдено';
    $Self->{Translation}->{'Could not insert into the table configitem_link'} = 'Не вдалося вставити в таблицю configitem_link';
    $Self->{Translation}->{'Inserted 0 rows into the table configitem_link'} = 'Вставив 0 рядків у таблицю configitem_link';

    # Perl Module: Kernel/System/ImportExport/ObjectBackend/ITSMConfigItem.pm
    $Self->{Translation}->{'Maximum number of one element'} = 'Максимальна кількість одного елемента';
    $Self->{Translation}->{'Empty fields indicate that the current values are kept'} = 'Порожні поля означають, що поточні значення зберігаються';
    $Self->{Translation}->{'Skipped'} = 'Пропущено.';

    # Perl Module: Kernel/Modules/AdminDynamicField.pm
    $Self->{Translation}->{'Error synchronizing the definitions. Please check the log.'} = 'Помилка синхронізації визначень. Будь ласка, перевірте лог.';
    $Self->{Translation}->{'You have ITSMConfigItem definitions which are not synchronized. Please deploy your ITSMConfigItem dynamic field changes.'} =
        'У вас є визначення ITSMConfigItem, які не синхронізовані. Будь ласка, розгорніть динамічні зміни полів ITSMConfigItem.';

    # Database XML / SOPM Definition: ITSMConfigurationManagement.sopm
    $Self->{Translation}->{'Expired'} = 'Закінчився';
    $Self->{Translation}->{'Maintenance'} = 'Обслуговування';
    $Self->{Translation}->{'Pilot'} = 'Пілот';
    $Self->{Translation}->{'Planned'} = 'Заплановано';
    $Self->{Translation}->{'Repair'} = 'Ремонт';
    $Self->{Translation}->{'Retired'} = 'На пенсії.';
    $Self->{Translation}->{'Review'} = 'Огляд';
    $Self->{Translation}->{'Test/QA'} = 'Тестування/QA';

    # JS File: ITSM.Admin.ITSMConfigItem
    $Self->{Translation}->{'Overview and Confirmation'} = 'Огляд та підтвердження';
    $Self->{Translation}->{'Importing classes/roles and their related fields'} = 'Імпорт класів/ролей та пов\'язаних з ними полів';
    $Self->{Translation}->{'An error occurred during class import.'} = 'Виникла помилка під час імпорту класу.';

    # SysConfig
    $Self->{Translation}->{'0 - Hidden'} = '0 - Приховано';
    $Self->{Translation}->{'1 - Shown'} = '1 - Показано';
    $Self->{Translation}->{'Allows extended search conditions in config item search of the agent interface. With this feature you can search e. g. config item name with this kind of conditions like "(*key1*&&*key2*)" or "(*key1*||*key2*)".'} =
        'Дозволяє використовувати розширені умови пошуку для пошуку елементів конфігурації в інтерфейсі агента. За допомогою цієї функції ви можете шукати, наприклад, назву елемента конфігурації з такими умовами, як "(*key1*&&*key2*)" або "(*key1*||*key2*)".';
    $Self->{Translation}->{'Allows extended search conditions in config item search of the customer interface. With this feature you can search e. g. config item name with this kind of conditions like "(*key1*&&*key2*)" or "(*key1*||*key2*)".'} =
        'Дозволяє розширені умови пошуку у пошуку елементів конфігурації в інтерфейсі клієнта. За допомогою цієї функції ви можете шукати, наприклад, назву елемента конфігурації з такими умовами, як "(*key1*&&*key2*)" або "(*key1*||*key2*)".';
    $Self->{Translation}->{'Assigned CIs'} = 'Призначені КІ';
    $Self->{Translation}->{'CIs assigned to customer company'} = 'КІ, призначені компанії-клієнту';
    $Self->{Translation}->{'CIs assigned to customer user'} = 'Пілот';
    $Self->{Translation}->{'CMDB Settings'} = 'Налаштування CMDB';
    $Self->{Translation}->{'Check for a unique name only within the same ConfigItem class (\'class\') or globally (\'global\'), which means every existing ConfigItem is taken into account when looking for duplicates.'} =
        'Перевіряти унікальне ім\'я тільки в межах одного класу ConfigItem (\'class\') або глобально (\'global\'), що означає, що при пошуку дублікатів враховується кожен існуючий ConfigItem.';
    $Self->{Translation}->{'Choose a module to enforce a naming scheme.'} = 'Виберіть модуль, щоб застосувати схему іменування.';
    $Self->{Translation}->{'Choose a module to enforce a number scheme.'} = 'Виберіть модуль, щоб застосувати номерну схему.';
    $Self->{Translation}->{'Choose a module to enforce a version string scheme.'} = 'Виберіть модуль для застосування схеми рядків версій.';
    $Self->{Translation}->{'Choose attributes to trigger the creation of a new version.'} = 'Виберіть атрибути, щоб запустити створення нової версії.';
    $Self->{Translation}->{'Choose categories to assign to this config item class.'} = 'Виберіть категорії, які слід призначити цьому класу елементів конфігурації.';
    $Self->{Translation}->{'Column config item filters for ConfigItem Overview.'} = 'Фільтри елементів конфігурації стовпця для Огляду елементів конфігурації.';
    $Self->{Translation}->{'Columns that can be filtered in the config item overview of the agent interface. Note: Only Config Item attributes and Dynamic Fields (DynamicField_NameX) are allowed.'} =
        'Стовпці, які можна відфільтрувати в огляді елементів конфігурації в інтерфейсі агента. Примітка: Допускаються лише атрибути елементів конфігурації та динамічні поля (DynamicField_NameX).';
    $Self->{Translation}->{'Columns that can be filtered in the config item overview of the customer interface. Note: Only Config Item attributes and Dynamic Fields (DynamicField_NameX) are allowed.'} =
        'Стовпці, які можна відфільтрувати в огляді елементів конфігурації в клієнтському інтерфейсі. Примітка: Допускаються лише атрибути елементів конфігурації та динамічні поля (DynamicField_NameX).';
    $Self->{Translation}->{'Columns that can be filtered in the config item search result overview of the agent interface. Note: Only Config Item attributes and Dynamic Fields (DynamicField_NameX) are allowed.'} =
        'Стовпці, які можна відфільтрувати в огляді результатів пошуку елементів конфігурації в інтерфейсі агента. Примітка: Допускаються лише атрибути елементів конфігурації та динамічні поля (DynamicField_NameX).';
    $Self->{Translation}->{'Config Items'} = 'Елементи конфігурації';
    $Self->{Translation}->{'Config item add.'} = 'Додати елемент конфігурації.';
    $Self->{Translation}->{'Config item edit.'} = 'Редагування елементів конфігурації.';
    $Self->{Translation}->{'Config item event module that enables logging to history in the agent interface.'} =
        'Налаштування модуля подій, який дозволяє записувати історію в інтерфейсі агента.';
    $Self->{Translation}->{'Config item event module that updates config items to their current definition.'} =
        'Модуль подій для елементів конфігурації, який оновлює елементи конфігурації до їх поточного визначення.';
    $Self->{Translation}->{'Config item event module that updates the table configitem_ĺink.'} =
        'Модуль події елементу конфігурації, який оновлює таблицю configitem_ĺink.';
    $Self->{Translation}->{'Config item event module updates the current incident state.'} =
        'Модуль подій конфігурації оновлює поточний стан інциденту.';
    $Self->{Translation}->{'Config item history.'} = 'Історія елементів конфігурації.';
    $Self->{Translation}->{'Config item print.'} = 'Друк елемента конфігурації.';
    $Self->{Translation}->{'Config item zoom.'} = 'Масштаб елемента конфігурації.';
    $Self->{Translation}->{'ConfigItem Tree View'} = 'Дерево елемента налаштування';
    $Self->{Translation}->{'ConfigItem Version'} = 'ConfigItem Версія';
    $Self->{Translation}->{'ConfigItems of the following classes will not be stored on the Elasticsearch server. To apply this to existing CIs, the CI migration has to be run via console, after changing this option.'} =
        'ConfigItems наступних класів не будуть зберігатися на сервері Elasticsearch. Щоб застосувати це до існуючих CI, міграція CI повинна бути запущена через консоль після зміни цієї опції.';
    $Self->{Translation}->{'ConfigItems with the following deployment states will not be stored on the Elasticsearch server. To apply this to existing CIs, the CI migration has to be run via console, after changing this option.'} =
        'ConfigItems з наступними станами розгортання не будуть зберігатися на сервері Elasticsearch. Щоб застосувати це до існуючих CI, міграція CI повинна бути запущена через консоль після зміни цієї опції.';
    $Self->{Translation}->{'Configuration Item Limit'} = 'Обмеження елемента конфігурації';
    $Self->{Translation}->{'Configuration Item limit per page.'} = 'Конфігурація Обмеження кількості елементів на сторінці.';
    $Self->{Translation}->{'Configuration Management Database.'} = 'База даних управління конфігурацією.';
    $Self->{Translation}->{'Configuration item bulk module.'} = 'Елемент конфігурації масового модуля.';
    $Self->{Translation}->{'Configuration item search backend router of the agent interface.'} =
        'Конфігурація елемента пошуку бекенд-маршрутизатора інтерфейсу агента.';
    $Self->{Translation}->{'Create and manage the definitions for Configuration Items.'} = 'Створюйте та керуйте визначеннями для елементів конфігурації.';
    $Self->{Translation}->{'Customers can see historic CI versions.'} = 'Клієнти можуть переглядати історичні версії CI.';
    $Self->{Translation}->{'Customers have the possibility to manually switch between historic CI versions.'} =
        'Клієнти мають можливість вручну перемикатися між історичними версіями CI.';
    $Self->{Translation}->{'Default data to use on attribute for config item search screen. Example: "ITSMConfigItemCreateTimePointFormat=year;ITSMConfigItemCreateTimePointStart=Last;ITSMConfigItemCreateTimePoint=2;".'} =
        'Дані за замовчуванням для використання в атрибуті на екрані пошуку елемента конфігурації. Приклад: "ITSMConfigItemCreateTimePointFormat=year;ITSMConfigItemCreateTimePointStart=Last;ITSMConfigItemCreateTimePoint=2;".';
    $Self->{Translation}->{'Default data to use on attribute for config item search screen. Example: "ITSMConfigItemCreateTimeStartYear=2010;ITSMConfigItemCreateTimeStartMonth=10;ITSMConfigItemCreateTimeStartDay=4;ITSMConfigItemCreateTimeStopYear=2010;ITSMConfigItemCreateTimeStopMonth=11;ITSMConfigItemCreateTimeStopDay=3;".'} =
        'Дані за замовчуванням для використання в атрибуті на екрані пошуку елемента конфігурації. Приклад: "ITSMConfigItemCreateTimeStartYear=2010;ITSMConfigItemCreateTimeStartMonth=10;ITSMConfigItemCreateTimeStartDay=4;ITSMConfigItemCreateTimeStopYear=2010;ITSMConfigItemCreateTimeStopMonth=11;ITSMConfigItemCreateTimeStopDay=3;"';
    $Self->{Translation}->{'Define Actions where a settings button is available in the linked objects widget (LinkObject::ViewMode = "complex"). Please note that these Actions must have registered the following JS and CSS files: Core.AllocationList.css, Core.UI.AllocationList.js, Core.UI.Table.Sort.js, Core.Agent.TableFilters.js and Core.Agent.LinkObject.js.'} =
        'Визначте дії, для яких кнопка налаштувань доступна у віджеті пов\'язаних об\'єктів (LinkObject::ViewMode = "complex"). Зверніть увагу, що в цих діях повинні бути зареєстровані наступні JS і CSS файли: Core.AllocationList.css, Core.UI.AllocationList.js, Core.UI.Table.Sort.js, Core.Agent.TableFilters.js і Core.Agent.LinkObject.js.';
    $Self->{Translation}->{'Define a Template::Toolkit scheme for version strings. Only used if Version String Module is set to TemplateToolkit.'} =
        'Визначає схему Template::Toolkit для рядків версій. Використовується лише у випадку, якщо модуль рядків версій має значення TemplateToolkit.';
    $Self->{Translation}->{'Define a set of conditions under which a customer is allowed to see a config item. Conditions can optionally be restricted to certain customer groups. Name is the only mandatory attribute. If no other options are given, all config items will be visible under that category.'} =
        'Визначте набір умов, за яких користувачеві дозволено бачити елемент конфігурації. За бажанням, умови можуть бути обмежені певними групами користувачів. Єдиним обов\'язковим атрибутом є назва. Якщо не вказано жодних інших параметрів, всі елементи конфігурації будуть видимими у цій категорії.';
    $Self->{Translation}->{'Defines Required permissions to create ITSM configuration items using the Generic Interface.'} =
        'Визначає необхідні дозволи для створення елементів конфігурації ITSM за допомогою загального інтерфейсу.';
    $Self->{Translation}->{'Defines Required permissions to delete ITSM configuration items using the Generic Interface.'} =
        'Визначає необхідні дозволи для видалення елементів конфігурації ITSM за допомогою загального інтерфейсу.';
    $Self->{Translation}->{'Defines Required permissions to get ITSM configuration items using the Generic Interface.'} =
        'Визначає необхідні дозволи для отримання елементів конфігурації ITSM за допомогою загального інтерфейсу.';
    $Self->{Translation}->{'Defines Required permissions to search ITSM configuration items using the Generic Interface.'} =
        'Визначає необхідні дозволи для пошуку елементів конфігурації ITSM за допомогою загального інтерфейсу.';
    $Self->{Translation}->{'Defines Required permissions to update ITSM configuration items using the Generic Interface.'} =
        'Визначає необхідні дозволи для оновлення елементів конфігурації ITSM за допомогою загального інтерфейсу.';
    $Self->{Translation}->{'Defines an overview module to show the small view of a configuration item list.'} =
        'Визначає модуль огляду для відображення невеликого списку елементів конфігурації.';
    $Self->{Translation}->{'Defines if the link type labels must be shown in the node connections.'} =
        'Визначає, чи потрібно показувати мітки типу зв\'язку у з\'єднаннях вузлів.';
    $Self->{Translation}->{'Defines regular expressions individually for each ConfigItem class to check the ConfigItem name and to show corresponding error messages.'} =
        'Визначає межу пошуку для екрана AgentITSMConfigItem.';
    $Self->{Translation}->{'Defines the available columns of CIs in the config item overview depending on the CI class. Each entry must consist of a class name and an array of available fields for the corresponding class. Dynamic field entries have to honor the scheme DynamicField_FieldName.'} =
        'Визначає доступні стовпці CI в огляді елементів конфігурації залежно від класу CI. Кожен запис має складатися з назви класу та масиву доступних полів для відповідного класу. Записи динамічних полів повинні відповідати схемі DynamicField_FieldName.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of the agent interface.'} =
        'Визначає атрибут за замовчуванням для сортування елементів конфігурації у результатах пошуку елементів конфігурації в інтерфейсі агента.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of the customer interface.'} =
        'Визначає атрибут за замовчуванням для сортування елементів конфігурації у результатах пошуку елементів конфігурації у клієнтському інтерфейсі.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of this operation.'} =
        'Визначає атрибут за замовчуванням для сортування елементів конфігурації у результатах пошуку елементів конфігурації за цією операцією.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the agent interface. Up: oldest on top. Down: latest on top.'} =
        'Визначає порядок елементів конфігурації за замовчуванням у результатах пошуку елементів конфігурації в інтерфейсі агента. Вгору: найстаріші зверху. Вниз: найновіші зверху.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the customer interface. Up: oldest on top. Down: latest on top.'} =
        'Визначає порядок елементів конфігурації за замовчуванням у результатах пошуку елементів конфігурації у клієнтському інтерфейсі. Вгору: найстаріші зверху. Вниз: найновіші зверху.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the this operation. Up: oldest on top. Down: latest on top.'} =
        'Визначає порядок елементів конфігурації за замовчуванням у результатах пошуку елементів конфігурації для цієї операції. Вгору: найстаріший зверху. Вниз: найновіший зверху.';
    $Self->{Translation}->{'Defines the default displayed columns of CIs in the config item overview depending on the CI class. Each entry must consist of a class name and an array of available fields for the corresponding class. Dynamic field entries have to honor the scheme DynamicField_FieldName.'} =
        'Визначає стовпці CI, що відображаються за замовчуванням в огляді елементів конфігурації залежно від класу CI. Кожен запис має складатися з назви класу та масиву доступних полів для відповідного класу. Записи динамічних полів мають відповідати схемі DynamicField_FieldName.';
    $Self->{Translation}->{'Defines the default relations depth to be shown.'} = 'Визначає глибину зв\'язків за замовчуванням, яку буде показано.';
    $Self->{Translation}->{'Defines the default shown config item search attribute for config item search screen.'} =
        'Визначає атрибут пошуку елемента конфігурації, який буде показано за замовчуванням на екрані пошуку елемента конфігурації.';
    $Self->{Translation}->{'Defines the default shown config item search attribute for config item search screen. Example: "Key" must have the name of the Dynamic Field in this case \'X\', "Content" must have the value of the Dynamic Field depending on the Dynamic Field type,  Text: \'a text\', Dropdown: \'1\', Date/Time: \'Search_DynamicField_XTimeSlotStartYear=1974; Search_DynamicField_XTimeSlotStartMonth=01; Search_DynamicField_XTimeSlotStartDay=26; Search_DynamicField_XTimeSlotStartHour=00; Search_DynamicField_XTimeSlotStartMinute=00; Search_DynamicField_XTimeSlotStartSecond=00; Search_DynamicField_XTimeSlotStopYear=2013; Search_DynamicField_XTimeSlotStopMonth=01; Search_DynamicField_XTimeSlotStopDay=26; Search_DynamicField_XTimeSlotStopHour=23; Search_DynamicField_XTimeSlotStopMinute=59; Search_DynamicField_XTimeSlotStopSecond=59;\' and or \'Search_DynamicField_XTimePointFormat=week; Search_DynamicField_XTimePointStart=Before; Search_DynamicField_XTimePointValue=7\';.'} =
        'Визначає типовий атрибут пошуку елемента конфігурації, який буде показано на екрані пошуку елемента конфігурації. Приклад: "Ключ" має містити назву динамічного поля, у цьому випадку \'X\', "Зміст" має містити значення динамічного поля залежно від типу динамічного поля, Текст: \'текст\', Випадаючий список: \'1\', Дата/Час: \'Search_DynamicField_XTimeSlotStartYear=1974; Search_DynamicField_XTimeSlotStartMonth=01; Search_DynamicField_XTimeSlotStartDay=26; Search_DynamicField_XTimeSlotStartHour=00; Search_DynamicField_XTimeSlotStartMinute=00; Search_DynamicField_XTimeSlotStartSecond=00; Search_DynamicField_XTimeSlotStopYear=2013; Search_DynamicField_XTimeSlotStopMonth=01; Search_DynamicField_XTimeSlotStopDay=26; Search_DynamicField_XTimeSlotStopHour=23; Search_DynamicField_XTimeSlotStopMinute=59; Search_DynamicField_XTimeSlotStopSecond=59;\' та або \'Search_DynamicField_XTimePointFormat=week; Search_DynamicField_XTimePointStart=Before; Search_DynamicField_XTimePointValue=7\';.';
    $Self->{Translation}->{'Defines the default subobject of the class \'ITSMConfigItem\'.'} =
        'Визначає підоб\'єкт за замовчуванням класу \'ITSMConfigItem\'.';
    $Self->{Translation}->{'Defines the number of rows for the CI definition editor in the admin interface.'} =
        'Визначає кількість рядків для редактора визначень CI в інтерфейсі адміністратора.';
    $Self->{Translation}->{'Defines the order of incident states from high (e.g. cricital) to low (e.g. functional).'} =
        'Визначає порядок станів інциденту від високого (наприклад, критичного) до низького (наприклад, функціонального).';
    $Self->{Translation}->{'Defines the relevant deployment states where linked tickets can affect the status of a CI.'} =
        'Визначає відповідні стани розгортання, в яких пов\'язані тікети можуть впливати на статус CI.';
    $Self->{Translation}->{'Defines the search limit for the AgentITSMConfigItem screen.'} =
        'Визначає межу пошуку для екрана AgentITSMConfigItem.';
    $Self->{Translation}->{'Defines the search limit for the AgentITSMConfigItemSearch screen.'} =
        'Визначає межу пошуку для екрана AgentITSMConfigItemSearch.';
    $Self->{Translation}->{'Defines the search limit for the CustomerITSMConfigItem screen.'} =
        'Визначає межу пошуку для екрана CustomerITSMConfigItem.';
    $Self->{Translation}->{'Defines the search limit for the CustomerITSMConfigItemSearch screen.'} =
        'Визначає межу пошуку для екрана CustomerITSMConfigItemSearch.';
    $Self->{Translation}->{'Defines the shown columns of CIs in the link table complex view for all CI classes. If there is no entry, then the default columns are shown.'} =
        'Визначає стовпці КІ, що відображаються в комплексному поданні таблиці посилань для всіх класів КІ. Якщо запис відсутній, то показуються стовпці за замовчуванням.';
    $Self->{Translation}->{'Defines the shown columns of CIs in the link table complex view, depending on the CI class. Each entry must be prefixed with the class name and double colons (i.e. Computer::). There are a few CI-Attributes that common to all CIs (example for the class Computer: Computer::Name, Computer::CurDeplState, Computer::CreateTime). To show individual CI-Attributes as defined in the CI-Definition, the following scheme must be used (example for the class Computer): Computer::HardDisk::1, Computer::HardDisk::1::Capacity::1, Computer::HardDisk::2, Computer::HardDisk::2::Capacity::1. If there is no entry for a CI class, then the default columns are shown.'} =
        'Визначає, які стовпці КІ відображатимуться у комплексному поданні таблиці посилань, залежно від класу КІ. Кожен запис має починатися з назви класу та подвійного двокрапки (наприклад, Computer::). Існує декілька атрибутів КІ, які є спільними для всіх КІ (наприклад, для класу Computer: Computer::Name, Computer::CurDeplState, Computer::CreateTime). Для відображення окремих CI-атрибутів, визначених у CI-визначенні, слід використовувати наступну схему (приклад для класу Computer): Computer::HardDisk::1, Computer::HardDisk::1::Capacity::1, Computer::HardDisk::2, Computer::HardDisk::2::Capacity::1. Якщо для класу CI немає жодного запису, буде показано стовпчики за замовчуванням.';
    $Self->{Translation}->{'Defines which items are available for \'Action\' in third level of the ITSM Config Item ACL structure.'} =
        'Визначає, які елементи доступні для "Дії" на третьому рівні структури ITSM Config Item ACL.';
    $Self->{Translation}->{'Defines which items are available in first level of the ITSM Config Item ACL structure.'} =
        'Визначає, які елементи доступні на першому рівні структури ITSM Config Item ACL.';
    $Self->{Translation}->{'Defines which items are available in second level of the ITSM Config Item ACL structure.'} =
        'Визначає, які елементи доступні на другому рівні структури ITSM Config Item ACL.';
    $Self->{Translation}->{'Defines which type of link (named from the ticket perspective) can affect the status of a linked CI.'} =
        'Визначає, який тип зв\'язку (названий з точки зору квитка) може впливати на статус зв\'язаного КІ.';
    $Self->{Translation}->{'Defines which type of ticket can affect the status of a linked CI.'} =
        'Визначає, який тип квитка може впливати на статус пов\'язаної КІ.';
    $Self->{Translation}->{'Definition Update'} = 'Оновлення визначення';
    $Self->{Translation}->{'Delete Configuration Item'} = 'Видалити елемент конфігурації';
    $Self->{Translation}->{'DeplState'} = 'DeplState';
    $Self->{Translation}->{'Deployment State Color'} = 'Колір стану розгортання';
    $Self->{Translation}->{'DeploymentState'} = 'DeploymentState';
    $Self->{Translation}->{'Duplicate'} = 'Дублікат';
    $Self->{Translation}->{'Dynamic field event module that marks config item definitions as out of sync, if containing dynamic fields change.'} =
        'Модуль подій динамічних полів, який позначає визначення елементів конфігурації як несинхронізовані, якщо змінюються динамічні поля.';
    $Self->{Translation}->{'Dynamic fields shown in the additional ITSM field screen of the agent interface.'} =
        'Динамічні поля, показані на додатковому екрані полів ITSM в інтерфейсі агента.';
    $Self->{Translation}->{'Dynamic fields shown in the config item overview screen of the customer interface.'} =
        'Динамічні поля, що відображаються на екрані огляду елементів конфігурації клієнтського інтерфейсу.';
    $Self->{Translation}->{'Dynamic fields shown in the config item search screen of the agent interface.'} =
        'Динамічні поля, що відображаються на екрані пошуку елементів конфігурації в інтерфейсі агента.';
    $Self->{Translation}->{'Enables configuration item bulk action feature for the agent frontend to work on more than one configuration item at a time.'} =
        'Вмикає функцію масових дій з елементами конфігурації для інтерфейсу агента, що дозволяє працювати з декількома елементами конфігурації одночасно.';
    $Self->{Translation}->{'Enables configuration item bulk action feature only for the listed groups.'} =
        'Вмикає функцію масових дій для елементів конфігурації лише для перелічених груп.';
    $Self->{Translation}->{'Enables/disables the functionality to check ITSM onfiguration items for unique names. Before enabling this option you should check your system for already existing config items with duplicate names. You can do this with the console command Admin::ITSM::Configitem::ListDuplicates.'} =
        'Дозволяє ввімкнути/вимкнути функцію перевірки елементів конфігурації ITSM на наявність унікальних імен. Перш ніж увімкнути цю опцію, вам слід перевірити систему на наявність елементів конфігурації з повторюваними іменами. Це можна зробити за допомогою консольної команди Admin::ITSM::Configitem::ListDuplicates.';
    $Self->{Translation}->{'Event module to set configitem-status on ticket-configitem-link.'} =
        'Модуль подій для встановлення configitem-status за посиланням ticket-configitem-link.';
    $Self->{Translation}->{'Fields of the configuration item index, used for the fulltext search. Fields are also stored, but are not mandatory for the overall functionality. Inclusion of attachments can be disabled by setting the entry to 0 or deleting it.'} =
        'Поля індексу елементів конфігурації, що використовуються для повнотекстового пошуку. Поля також зберігаються, але не є обов\'язковими для загальної функціональності. Включення вкладень можна вимкнути, встановивши значення 0 або видаливши їх.';
    $Self->{Translation}->{'Fields stored in the configuration item index which are used for other things besides fulltext searches. For the complete functionality all fields are mandatory.'} =
        'Поля, що зберігаються в індексі елементів конфігурації, які використовуються для інших цілей, окрім повнотекстового пошуку. Для повної функціональності всі поля є обов\'язковими.';
    $Self->{Translation}->{'For every webservice (key) an array of classes (value) can be defined on which the import is restricted. For all chosen classes, or all existing classes the identifying attributes will have to be chosen in the invoker config.'} =
        'Для кожного веб-сервісу (ключ) можна визначити масив класів (значення), для яких імпорт обмежено. Для всіх вибраних класів або всіх існуючих класів потрібно буде вибрати ідентифікаційні атрибути у конфігурації інвокера.';
    $Self->{Translation}->{'GenericInterface module registration for the ConfigItemFetch invoker layer.'} =
        'Реєстрація модуля GenericInterface для шару виклику ConfigItemFetch.';
    $Self->{Translation}->{'ITSM ConfigItem'} = 'ITSM ConfigItem';
    $Self->{Translation}->{'ITSM config item overview.'} = 'Огляд елементів конфігурації ITSM.';
    $Self->{Translation}->{'InciState'} = 'InciState';
    $Self->{Translation}->{'IncidentState'} = 'IncidentState';
    $Self->{Translation}->{'Includes deployment states in the config item search of the customer interface.'} =
        'Включає стани розгортання до пошуку елементів конфігурації у клієнтському інтерфейсі.';
    $Self->{Translation}->{'Includes incident states in the config item search of the customer interface.'} =
        'Включає стани інцидентів у пошук елементів конфігурації клієнтського інтерфейсу.';
    $Self->{Translation}->{'Maximum number of config items to be displayed in the result of this operation.'} =
        'Максимальна кількість елементів конфігурації, які буде відображено в результаті цієї операції.';
    $Self->{Translation}->{'Module to check the group responsible for a class.'} = 'Модуль для перевірки групи, відповідальної за клас.';
    $Self->{Translation}->{'Module to check the group responsible for a configuration item.'} =
        'Модуль для перевірки групи, відповідальної за елемент конфігурації.';
    $Self->{Translation}->{'Module to generate ITSM config item statistics.'} = 'Модуль для генерації статистики елементів конфігурації ITSM.';
    $Self->{Translation}->{'Name Module'} = 'Модуль імен';
    $Self->{Translation}->{'Number Module'} = 'Модуль числа';
    $Self->{Translation}->{'Number of config items to be displayed in each page of a search result in the agent interface.'} =
        'Кількість елементів конфігурації, які будуть відображатися на кожній сторінці результатів пошуку в інтерфейсі агента.';
    $Self->{Translation}->{'Number of config items to be displayed in each page of a search result in the customer interface.'} =
        'Кількість елементів конфігурації, які будуть відображатися на кожній сторінці результатів пошуку в інтерфейсі клієнта.';
    $Self->{Translation}->{'Objects to search for, how many entries and which attributs to show. ConfigItem attributes have to explicitly be stored via Elasticsearch.'} =
        'Об\'єкти для пошуку, кількість записів і які атрибути показувати. Атрибути ConfigItem мають бути явно збережені через Elasticsearch.';
    $Self->{Translation}->{'Overview.'} = 'Огляд.';
    $Self->{Translation}->{'Parameters for the categories for config item classes in the preferences view of the agent interface.'} =
        'Параметри категорій для класів елементів конфігурації у вікні налаштувань інтерфейсу агента.';
    $Self->{Translation}->{'Parameters for the column filters of the small config item overview. Please note: setting \'Active\' to 0 will only prevent agents from editing settings of this group in their personal preferences, but will still allow administrators to edit the settings of another user\'s behalf. Use \'PreferenceGroup\' to control in which area these settings should be shown in the user interface.'} =
        'Параметри для фільтрів стовпців в огляді малих елементів конфігурації. Зверніть увагу: встановлення значення "Активний" на 0 лише заборонить агентам редагувати налаштування цієї групи у своїх особистих налаштуваннях, але дозволить адміністраторам редагувати налаштування від імені іншого користувача. Використовуйте "PreferenceGroup", щоб контролювати, в якій області користувацького інтерфейсу відображати ці налаштування.';
    $Self->{Translation}->{'Parameters for the dashboard backend of the customer company config item overview of the agent interface . "Limit" is the number of entries shown by default. "Group" is used to restrict the access to the plugin (e. g. Group: admin;group1;group2;). "Default" determines if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" is the cache time in minutes for the plugin.'} =
        'Параметри для бекенду дашборду компанії-замовника елемент конфігурації огляду інтерфейсу агента. "Limit" - кількість записів, що відображаються за замовчуванням. "Group" використовується для обмеження доступу до плагіна (наприклад, Group: admin;group1;group2;). "Default" визначає, чи буде плагін увімкнений за замовчуванням, чи користувачеві потрібно увімкнути його вручну. "CacheTTLLocal" - час кешування плагіна в хвилинах.';
    $Self->{Translation}->{'Parameters for the deployment states color in the preferences view of the agent interface.'} =
        'Параметри для станів розгортання позначаються кольором у вікні налаштувань інтерфейсу агента.';
    $Self->{Translation}->{'Parameters for the deployment states in the preferences view of the agent interface.'} =
        'Параметри для станів розгортання у вікні налаштувань інтерфейсу агента.';
    $Self->{Translation}->{'Parameters for the example permission groups of the general catalog attributes.'} =
        'Параметри для прикладу дозволу груп загальних атрибутів каталогу.';
    $Self->{Translation}->{'Parameters for the name module for config item classes in the preferences view of the agent interface.'} =
        'Параметри модуля імен для класів елементів конфігурації у вікні налаштувань інтерфейсу агента.';
    $Self->{Translation}->{'Parameters for the number module for config item classes in the preferences view of the agent interface.'} =
        'Параметри модуля числа для класів елементів конфігурації у вікні налаштувань інтерфейсу агента.';
    $Self->{Translation}->{'Parameters for the pages (in which the configuration items are shown).'} =
        'Параметри для сторінок (на яких відображаються елементи конфігурації).';
    $Self->{Translation}->{'Parameters for the version string module for config item classes in the preferences view of the agent interface.'} =
        'Параметри для модуля рядка версії для класів елементів конфігурації у вікні налаштувань інтерфейсу агента.';
    $Self->{Translation}->{'Parameters for the version string template toolkit module for config item classes in the preferences view of the agent interface.'} =
        'Параметри для модуля шаблону рядка версії інструментарію для класів елементів конфігурації у поданні налаштувань інтерфейсу агента.';
    $Self->{Translation}->{'Parameters for the version trigger for config item classes in the preferences view of the agent interface.'} =
        'Параметри для тригера версії для класів елементів конфігурації у вікні налаштувань інтерфейсу агента.';
    $Self->{Translation}->{'Performs the configured action for each event (as an Invoker) for each configured Webservice.'} =
        'Виконує налаштовану дію для кожної події (як інвокер) для кожного налаштованого вебсервісу.';
    $Self->{Translation}->{'Permission Group'} = 'Група дозволів';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item attachment action in the agent interface.'} =
        'Необхідні дозволи для використання дії прикріплення елемента конфігурації ITSM в інтерфейсі агента.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item screen in the agent interface.'} =
        'Необхідні дозволи для використання екрана елементів конфігурації ITSM в інтерфейсі агента.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item search screen in the agent interface.'} =
        'Необхідні дозволи для використання екрана пошуку елементів конфігурації ITSM в інтерфейсі агента.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item search screen in the customer interface.'} =
        'Необхідні дозволи для використання екрана пошуку елементів конфігурації ITSM в інтерфейсі клієнта.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item tree view screen in the agent interface.'} =
        'Необхідні дозволи для використання екрана перегляду дерева елементів конфігурації ITSM в інтерфейсі агента.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item zoom screen in the agent interface.'} =
        'Необхідні дозволи для використання екрана масштабування елементів конфігурації ITSM в інтерфейсі агента.';
    $Self->{Translation}->{'Required permissions to use the add ITSM configuration item screen in the agent interface.'} =
        'Необхідні дозволи для використання екрана додавання елемента конфігурації ITSM в інтерфейсі агента.';
    $Self->{Translation}->{'Required permissions to use the bulk ITSM configuration item screen in the agent interface.'} =
        'Необхідні дозволи для використання екрана масових елементів конфігурації ITSM в інтерфейсі агента.';
    $Self->{Translation}->{'Required permissions to use the edit ITSM configuration item screen in the agent interface.'} =
        'Необхідні дозволи для використання екрана редагування елементів конфігурації ITSM в інтерфейсі агента.';
    $Self->{Translation}->{'Required permissions to use the history ITSM configuration item screen in the agent interface.'} =
        'Необхідні дозволи для використання екрана елементів конфігурації історії ITSM в інтерфейсі агента.';
    $Self->{Translation}->{'Required permissions to use the print ITSM configuration item screen in the agent interface.'} =
        'Необхідні дозволи для використання екрана друку елементів конфігурації ITSM в інтерфейсі агента.';
    $Self->{Translation}->{'Required privileges to delete config items.'} = 'Необхідні привілеї для видалення елементів конфігурації.';
    $Self->{Translation}->{'Search config items.'} = 'Пошук елементів конфігурації.';
    $Self->{Translation}->{'Set the incident state of a CI automatically when a Ticket is Linked to a CI.'} =
        'Автоматично встановлювати стан інциденту для КІ, коли Тікет прив\'язаний до КІ.';
    $Self->{Translation}->{'Sets the deployment state in the configuration item bulk screen of the agent interface.'} =
        'Встановлює стан розгортання на основному екрані елемента конфігурації інтерфейсу агента.';
    $Self->{Translation}->{'Sets the incident state in the configuration item bulk screen of the agent interface.'} =
        'Встановлює стан інциденту на основному екрані елемента конфігурації в інтерфейсі агента.';
    $Self->{Translation}->{'Shows a link in the menu that allows linking a configuration item with another object in the config item zoom view of the agent interface.'} =
        'Показує посилання в меню, яке дозволяє зв\'язати елемент конфігурації з іншим об\'єктом у вікні масштабування елемента конфігурації в інтерфейсі агента.';
    $Self->{Translation}->{'Shows a link in the menu to access the history of a configuration item in the configuration item overview of the agent interface.'} =
        'Показує посилання в меню для доступу до історії елемента конфігурації в огляді елементів конфігурації в інтерфейсі агента.';
    $Self->{Translation}->{'Shows a link in the menu to access the history of a configuration item in the its zoom view of the agent interface.'} =
        'Показує посилання в меню для доступу до історії елемента конфігурації у вікні масштабування інтерфейсу агента.';
    $Self->{Translation}->{'Shows a link in the menu to delete a configuration item in its zoom view of the agent interface.'} =
        'Показує посилання в меню для видалення елемента конфігурації у збільшеному вигляді інтерфейсу агента.';
    $Self->{Translation}->{'Shows a link in the menu to display the configuration item links as a Tree View.'} =
        'Показує посилання в меню для відображення посилань на елементи конфігурації у вигляді дерева.';
    $Self->{Translation}->{'Shows a link in the menu to duplicate a configuration item in the configuration item overview of the agent interface.'} =
        'Показує посилання в меню для дублювання елемента конфігурації в огляді елементів конфігурації в інтерфейсі агента.';
    $Self->{Translation}->{'Shows a link in the menu to duplicate a configuration item in the its zoom view of the agent interface.'} =
        'Показує посилання в меню для дублювання елемента конфігурації в його збільшеному вигляді в інтерфейсі агента.';
    $Self->{Translation}->{'Shows a link in the menu to edit a configuration item in the its zoom view of the agent interface.'} =
        'Показує посилання в меню для редагування елемента конфігурації у вікні масштабування інтерфейсу агента.';
    $Self->{Translation}->{'Shows a link in the menu to go back in the configuration item zoom view of the agent interface.'} =
        'Показує посилання в меню для повернення до пункту налаштування масштабування інтерфейсу агента.';
    $Self->{Translation}->{'Shows a link in the menu to print a configuration item in the its zoom view of the agent interface.'} =
        'Показує посилання в меню для друку елемента конфігурації у збільшеному вигляді інтерфейсу агента.';
    $Self->{Translation}->{'Shows a link in the menu to zoom into a configuration item in the configuration item overview of the agent interface.'} =
        'Показує посилання в меню для збільшення елемента конфігурації в огляді елементів конфігурації в інтерфейсі агента.';
    $Self->{Translation}->{'Shows the config item history (reverse ordered) in the agent interface.'} =
        'Показує історію елементів конфігурації (у зворотному порядку) в інтерфейсі агента.';
    $Self->{Translation}->{'The default category which is shown, if none is selected.'} = 'Категорія за замовчуванням, яка відображається, якщо не вибрано жодної.';
    $Self->{Translation}->{'The identifier for a configuration item, e.g. ConfigItem#, MyConfigItem#. The default is ConfigItem#.'} =
        'Ідентифікатор елемента конфігурації, наприклад, ConfigItem#, MyConfigItem#. За замовчуванням це ConfigItem#.';
    $Self->{Translation}->{'Triggers ConfigItemFetch invoker automatically.'} = 'Автоматично запускає викличник ConfigItemFetch.';
    $Self->{Translation}->{'Version String Expression'} = 'Вираз рядка версії';
    $Self->{Translation}->{'Version String Module'} = 'Модуль рядка версії';
    $Self->{Translation}->{'Version Trigger'} = 'Тригер версії';
    $Self->{Translation}->{'Whether the execution of ConfigItemACL can be avoided by checking cached field dependencies. This can improve loading times of formulars, but has to be disabled, if ACLModules are to be used for ITSMConfigItem- and Form-ReturnTypes.'} =
        'Чи можна уникнути виконання ConfigItemACL шляхом перевірки кешованих залежностей полів. Це може покращити час завантаження формул, але його слід вимкнути, якщо ACLM-модулі буде використано для ITSMConfigItem- і Form-ReturnTypes.';
    $Self->{Translation}->{'Which general information is shown in the header.'} = 'Яка загальна інформація відображається в заголовку.';
    $Self->{Translation}->{'class'} = 'клас';
    $Self->{Translation}->{'global'} = 'глобальний';
    $Self->{Translation}->{'postproductive'} = 'постпродуктивний';
    $Self->{Translation}->{'preproductive'} = 'препродуктивний';
    $Self->{Translation}->{'productive'} = 'продуктивний';


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

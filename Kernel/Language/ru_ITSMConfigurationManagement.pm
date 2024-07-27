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

package Kernel::Language::ru_ITSMConfigurationManagement;

use strict;
use warnings;
use utf8;

sub Data {
    my $Self = shift;

    # Template: AdminITSMConfigItem
    $Self->{Translation}->{'Config Item Management'} = 'Управление Конфигурационными единицами';
    $Self->{Translation}->{'Change class definition'} = 'Изменить описание класса';
    $Self->{Translation}->{'Change role definition'} = 'Изменение определения роли';
    $Self->{Translation}->{'Ready2Import Class Bundles'} = 'Пакеты классов Ready2Import';
    $Self->{Translation}->{'Here you can import Ready2Import class bundles showcasing our most usual config items. Please note that some additional configuration may be required.'} =
        'Здесь вы можете импортировать пакеты классов Ready2Import, демонстрирующие наши самые обычные элементы конфигурации. Обратите внимание, что может потребоваться дополнительная настройка.';
    $Self->{Translation}->{'Update existing entities'} = 'Обновление существующих сущностей';
    $Self->{Translation}->{'Import Ready2Adopt class bundles'} = 'Импортируйте пакеты классов Ready2Adopt';
    $Self->{Translation}->{'Config Item Class'} = 'Класс конфигурационной единицы';
    $Self->{Translation}->{'Config Item Role'} = 'Роль элемента конфигурации';

    # Template: AgentITSMConfigItemAdd
    $Self->{Translation}->{'Config Item'} = 'Основные средства';
    $Self->{Translation}->{'Filter for Classes'} = 'Фильтр для классов';
    $Self->{Translation}->{'Select a Class from the list to create a new Config Item.'} = 'Выберите класс из списка для создания новой КЕ';
    $Self->{Translation}->{'Class'} = 'Класс';

    # Template: AgentITSMConfigItemBulk
    $Self->{Translation}->{'ITSM ConfigItem Bulk Action'} = 'ITSM ConfigItem массовое действие';
    $Self->{Translation}->{'Deployment state'} = 'Состояние использования';
    $Self->{Translation}->{'Incident state'} = 'Состояние инцидента';
    $Self->{Translation}->{'Link to another'} = 'Связать с другим';
    $Self->{Translation}->{'Invalid Configuration Item number!'} = 'Неверный номер конфигурационной единицы!';
    $Self->{Translation}->{'The number of another Configuration Item to link with.'} = 'Количество других КЕ для связывания.';

    # Template: AgentITSMConfigItemDelete
    $Self->{Translation}->{'Do you really want to delete this config item?'} = 'Вы действительно хотите удалить эту конфигурационную единицу?';

    # Template: AgentITSMConfigItemEdit
    $Self->{Translation}->{'The name of this config item'} = 'Имя этого учетного элемента';
    $Self->{Translation}->{'Name is already in use by the ConfigItems with the following Number(s): %s'} =
        'Имя уже используется другой КЕ со следующим номером (ами): %s';
    $Self->{Translation}->{'Version Number'} = 'Номер версии';
    $Self->{Translation}->{'Version number of this config item'} = 'Номер версии этого элемента конфигурации';
    $Self->{Translation}->{'Version Number is already in use by the ConfigItems with the following Number(s): %s'} =
        'Номер версии уже используется ConfigItems со следующим номером (номерами): %s';
    $Self->{Translation}->{'Deployment State'} = 'Состояние использования';
    $Self->{Translation}->{'Incident State'} = 'Состояние инцидента';

    # Template: AgentITSMConfigItemHistory
    $Self->{Translation}->{'History of Config Item: %s'} = 'История конфигурационной единицы: %s';
    $Self->{Translation}->{'History Content'} = 'Содержимое истории';
    $Self->{Translation}->{'Createtime'} = 'Время создания';
    $Self->{Translation}->{'Zoom view'} = 'Подробный показ';

    # Template: AgentITSMConfigItemOverviewNavBar
    $Self->{Translation}->{'Config Items per page'} = 'Конфигурационных единиц на страницу';

    # Template: AgentITSMConfigItemOverviewSmall
    $Self->{Translation}->{'No config item data found.'} = 'Данные об элементах конфигурации не найдены.';
    $Self->{Translation}->{'Select this config item'} = 'Выберите этот элемент конфигурации';

    # Template: AgentITSMConfigItemSearch
    $Self->{Translation}->{'Run Search'} = 'Выполнить поиск';
    $Self->{Translation}->{'Also search in previous versions?'} = 'Искать и в предыдущих версиях?';

    # Template: AgentITSMConfigItemTreeView
    $Self->{Translation}->{'TreeView for ConfigItem'} = 'TreeView для ConfigItem';
    $Self->{Translation}->{'Depth Level'} = 'Уровень глубины';
    $Self->{Translation}->{'Zoom In/Out'} = 'Увеличение/уменьшение';
    $Self->{Translation}->{'Max links level reached for ConfigItem!'} = 'Достигнут максимальный уровень ссылок для ConfigItem!';

    # Template: AgentITSMConfigItemZoom
    $Self->{Translation}->{'Configuration Item'} = 'Конфигурационная единица';
    $Self->{Translation}->{'Configuration Item Information'} = ' Информация о Конф. ед.';
    $Self->{Translation}->{'Current Deployment State'} = 'Текущее состояние использования';
    $Self->{Translation}->{'Current Incident State'} = 'Текущее состояние инцидента';
    $Self->{Translation}->{'Last changed'} = 'Время последнего изменения';
    $Self->{Translation}->{'Last changed by'} = 'Автор последнего изменения';

    # Template: CustomerITSMConfigItem
    $Self->{Translation}->{'Your ConfigItems'} = 'Ваши ConfigItems';

    # Template: CustomerITSMConfigItemSearch
    $Self->{Translation}->{'ConfigItem Search'} = 'Поиск ConfigItem';

    # Template: AdminACL
    $Self->{Translation}->{'Object Type'} = 'Тип объекта';

    # JS Template: ClassImportConfirm
    $Self->{Translation}->{'The following classes will be imported'} = 'Будут импортированы следующие классы';
    $Self->{Translation}->{'The following roles will be imported'} = 'Следующие роли будут импортированы';
    $Self->{Translation}->{'Note that also corresponding dynamic fields and GeneralCatalog classes will be created and there is no automatic removal.'} =
        'Обратите внимание, что также будут созданы соответствующие динамические поля и классы GeneralCatalog, и автоматического удаления не произойдет.';
    $Self->{Translation}->{'Do you want to proceed?'} = 'Желаете продолжить?';

    # Perl Module: Kernel/Modules/AdminITSMConfigItem.pm
    $Self->{Translation}->{'Need ExampleClasses!'} = 'Нужны примеры классов!';
    $Self->{Translation}->{'Definition is no valid YAML hash.'} = 'Определение не является действительным хэшем YAML.';

    # Perl Module: Kernel/Modules/AgentITSMConfigItem.pm
    $Self->{Translation}->{'Overview: ITSM ConfigItem'} = 'Обзор: ITSM ConfigItem';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemBulk.pm
    $Self->{Translation}->{'No ConfigItemID is given!'} = 'Нет ConfigItemID!';
    $Self->{Translation}->{'You need at least one selected Configuration Item!'} = 'Вам нужна хотя бы одна выбранная конфигурационная единица!';
    $Self->{Translation}->{'You don\'t have write access to this configuration item: %s.'} =
        'У вас нет доступа на запись этой конфигурационной единицы: %s.';
    $Self->{Translation}->{'No definition was defined for class %s!'} = 'Класс %s не был определен!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemDelete.pm
    $Self->{Translation}->{'Config item "%s" not found in database!'} = 'Конфигурационная единица "%s" не найдена в базе!';
    $Self->{Translation}->{'Was not able to delete the configitem ID %s!'} = 'Не удалось удалить конфигурационную единицу с ID %s!';
    $Self->{Translation}->{'No version found for ConfigItemID %s!'} = 'Не найдена версия конфигурационной единицы %s!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemEdit.pm
    $Self->{Translation}->{'No ConfigItemID, DuplicateID or ClassID is given!'} = 'Не присвоен ConfigItemID, DuplicateID или ClassID!';
    $Self->{Translation}->{'No access is given!'} = 'Нет доступа!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemHistory.pm
    $Self->{Translation}->{'Can\'t show history, no ConfigItemID is given!'} = 'Невозможно показать историю, нет ConfigItemID!';
    $Self->{Translation}->{'Can\'t show history, no access rights given!'} = 'Невозможно показать историю, недостаточно прав!';
    $Self->{Translation}->{'New ConfigItem (ID=%s)'} = 'Новая КЕ (ID=%s)';
    $Self->{Translation}->{'New version (ID=%s)'} = 'Новая версия (ID=%s)';
    $Self->{Translation}->{'Deployment state updated (new=%s, old=%s)'} = 'Состояние использования обновлено (новое=%s, старое=%s)';
    $Self->{Translation}->{'Incident state updated (new=%s, old=%s)'} = 'Состояние инцидента обновлено (новое=%s, старое=%s)';
    $Self->{Translation}->{'ConfigItem (ID=%s) deleted'} = 'КЕ (ID=%s) удалена';
    $Self->{Translation}->{'Link to %s (type=%s) added'} = 'Связь с %s (тип=%s) добавлена';
    $Self->{Translation}->{'Link to %s (type=%s) deleted'} = 'Связь с %s (тип=%s) удалена';
    $Self->{Translation}->{'ConfigItem definition updated (ID=%s)'} = 'Описание КЕ обновлено (ID=%s)';
    $Self->{Translation}->{'Name updated (new=%s, old=%s)'} = 'Имя обновлено (новое=%s, старое=%s)';
    $Self->{Translation}->{'Attribute %s updated from "%s" to "%s"'} = 'Атрибут %s обновлен с "%s" до "%s"';
    $Self->{Translation}->{'Version %s deleted'} = 'Версия %s удалена';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemPrint.pm
    $Self->{Translation}->{'No ConfigItemID or VersionID is given!'} = 'Не присвоен ConfigItemID или VersionID!';
    $Self->{Translation}->{'Can\'t show config item, no access rights given!'} = 'Невозможно отобразить конфигурационную единицу, нет доступа!';
    $Self->{Translation}->{'ConfigItemID %s not found in database!'} = 'Конфигурационная единица %s не найдена в базе!';
    $Self->{Translation}->{'ConfigItem'} = 'Конфигурационная единица';
    $Self->{Translation}->{'printed by %s at %s'} = 'напечатано %s в %s';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemSearch.pm
    $Self->{Translation}->{'Invalid ClassID!'} = 'Неверный ClassID!';
    $Self->{Translation}->{'No ClassID is given!'} = 'ClassID не присвоен!';
    $Self->{Translation}->{'No access rights for this class given!'} = 'Нет доступа для этого класса!';
    $Self->{Translation}->{'No Result!'} = 'Нет результата/Решения!';
    $Self->{Translation}->{'Config Item Search Results'} = 'Результаты поиска конфигурационных единиц';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemZoom.pm
    $Self->{Translation}->{'Can\'t show item, no access rights for ConfigItem are given!'} =
        'Невозможно отобразить элемент, недостаточно прав для КЕ!';
    $Self->{Translation}->{'ConfigItem not found!'} = 'ConfigItem не найден!';
    $Self->{Translation}->{'No versions found!'} = 'Версии не найдены!';
    $Self->{Translation}->{'operational'} = 'оперативная';
    $Self->{Translation}->{'warning'} = 'предупреждение';
    $Self->{Translation}->{'incident'} = 'инцидент';
    $Self->{Translation}->{'The deployment state of this config item'} = 'Состояние использования этой КЕ';
    $Self->{Translation}->{'The incident state of this config item'} = 'Состояние инцидента для этой КЕ';

    # Perl Module: Kernel/Modules/CustomerITSMConfigItemSearch.pm
    $Self->{Translation}->{'No permission'} = 'Нет разрешения';
    $Self->{Translation}->{'Filter invalid!'} = 'Фильтр недействителен!';
    $Self->{Translation}->{'Search params invalid!'} = 'Недопустимые параметры поиска!';

    # Perl Module: Kernel/Output/HTML/Dashboard/ITSMConfigItemGeneric.pm
    $Self->{Translation}->{'Shown config items'} = 'Показанные элементы настройки';
    $Self->{Translation}->{'Deployment State Type'} = 'Тип Состояния использования';
    $Self->{Translation}->{'Current Incident State Type'} = 'Тип Текущего состояния инцидента';

    # Perl Module: Kernel/Output/HTML/ITSMConfigItem/LayoutDate.pm
    $Self->{Translation}->{'Between'} = 'Между';

    # Perl Module: Kernel/System/DynamicField/Driver/ConfigItem.pm
    $Self->{Translation}->{'Class restrictions for the config item'} = 'Ограничения класса для элемента конфигурации';
    $Self->{Translation}->{'Select one or more classes to restrict selectable config items'} =
        'Выберите один или несколько классов, чтобы ограничить выбор элементов конфигурации';
    $Self->{Translation}->{'Link type'} = 'Тип ссылки';
    $Self->{Translation}->{'Select the link type.'} = 'Выберите тип ссылки.';
    $Self->{Translation}->{'Forwards: Referencing (Source) -> Referenced (Target)'} = 'Форварды: Ссылающийся (Источник) -> Ссылающийся (Цель)';
    $Self->{Translation}->{'Backwards: Referenced (Source) -> Referencing (Target)'} = 'Обратно: Ссылающийся (Источник) -> Ссылающийся (Цель)';
    $Self->{Translation}->{'Link Direction'} = 'Направление ссылки';
    $Self->{Translation}->{'The referencing object is the one containing this dynamic field, the referenced object is the one selected as value of the dynamic field.'} =
        'Ссылающийся объект - это объект, содержащий данное динамическое поле, а ссылающийся объект - это объект, выбранный в качестве значения динамического поля.';
    $Self->{Translation}->{'Dynamic (ConfigItem)'} = 'Динамический (ConfigItem)';
    $Self->{Translation}->{'Static (Version)'} = 'Статика (версия)';
    $Self->{Translation}->{'Link Referencing Type'} = 'Тип ссылки';
    $Self->{Translation}->{'Whether this link applies to the ConfigItem or the static version of the referencing object. Current Incident State calculation only is performed on dynamic links.'} =
        'Применяется ли эта ссылка к ConfigItem или к статической версии ссылающегося объекта. Расчет текущего состояния инцидента выполняется только для динамических ссылок.';
    $Self->{Translation}->{'Select the attribute which config items will be searched by'} = 'Выберите атрибут, по которому будет осуществляться поиск элементов конфигурации';

    # Perl Module: Kernel/System/ITSMConfigItem/Definition.pm
    $Self->{Translation}->{'Base structure is not valid. Please provide a hash with data in YAML format.'} =
        'Базовая структура недействительна. Пожалуйста, предоставьте хэш с данными в формате YAML.';
    $Self->{Translation}->{'Starting the YAML string with \'---\' is required.'} = 'Необходимо начинать строку YAML с \'---\'.';

    # Perl Module: Kernel/System/ITSMConfigItem/Link.pm
    $Self->{Translation}->{'Could not purge the table configitem_link.'} = 'Не удалось очистить таблицу configitem_link.';
    $Self->{Translation}->{'No relevant dynamic fields were found'} = 'Соответствующие динамические поля не найдены';
    $Self->{Translation}->{'Could not insert into the table configitem_link'} = 'Не удалось вставить в таблицу configitem_link';
    $Self->{Translation}->{'Inserted 0 rows into the table configitem_link'} = 'Вставлено 0 строк в таблицу configitem_link';

    # Perl Module: Kernel/System/ImportExport/ObjectBackend/ITSMConfigItem.pm
    $Self->{Translation}->{'Maximum number of one element'} = 'Максимальное количество одного элемента';
    $Self->{Translation}->{'Empty fields indicate that the current values are kept'} = 'Пустые поля показывают, что текущие значения сохранятся';
    $Self->{Translation}->{'Skipped'} = 'Пропущено';

    # Perl Module: Kernel/Modules/AdminDynamicField.pm
    $Self->{Translation}->{'Error synchronizing the definitions. Please check the log.'} = 'Ошибка синхронизации определений. Пожалуйста, проверьте журнал.';
    $Self->{Translation}->{'You have ITSMConfigItem definitions which are not synchronized. Please deploy your ITSMConfigItem dynamic field changes.'} =
        'У вас есть определения ITSMConfigItem, которые не синхронизированы. Пожалуйста, разверните изменения динамических полей ITSMConfigItem.';

    # Database XML / SOPM Definition: ITSMConfigurationManagement.sopm
    $Self->{Translation}->{'Expired'} = 'Устарело';
    $Self->{Translation}->{'Maintenance'} = 'Техническое обслуживание';
    $Self->{Translation}->{'Pilot'} = 'Эксперимент';
    $Self->{Translation}->{'Planned'} = 'Запланированно';
    $Self->{Translation}->{'Repair'} = 'Ремонт';
    $Self->{Translation}->{'Retired'} = 'Списано';
    $Self->{Translation}->{'Review'} = 'Экспертиза';
    $Self->{Translation}->{'Test/QA'} = 'Тестирование';

    # JS File: ITSM.Admin.ITSMConfigItem
    $Self->{Translation}->{'Overview and Confirmation'} = 'Обзор и подтверждение';
    $Self->{Translation}->{'Importing classes/roles and their related fields'} = 'Импорт классов/ролей и связанных с ними полей';
    $Self->{Translation}->{'An error occurred during class import.'} = 'Во время импорта класса произошла ошибка.';

    # SysConfig
    $Self->{Translation}->{'0 - Hidden'} = '0 - Скрытый';
    $Self->{Translation}->{'1 - Shown'} = '1 - показано';
    $Self->{Translation}->{'Allows extended search conditions in config item search of the agent interface. With this feature you can search e. g. config item name with this kind of conditions like "(*key1*&&*key2*)" or "(*key1*||*key2*)".'} =
        'Позволяет расширить условия поиска при поиске элементов конфигурации в интерфейсе агента. С помощью этой функции вы можете искать, например, имя элемента конфигурации с такими условиями, как "(*key1*&&*key2*)" или "(*key1*||*key2*)".';
    $Self->{Translation}->{'Allows extended search conditions in config item search of the customer interface. With this feature you can search e. g. config item name with this kind of conditions like "(*key1*&&*key2*)" or "(*key1*||*key2*)".'} =
        'Позволяет расширить условия поиска при поиске элементов конфигурации в клиентском интерфейсе. С помощью этой функции вы можете искать, например, имя элемента конфигурации с такими условиями, как "(*key1*&&*key2*)" или "(*key1*||*key2*)".';
    $Self->{Translation}->{'Assigned CIs'} = 'Назначаемые КИ';
    $Self->{Translation}->{'At a specific time point create a ticket for config items, if the configured requirements are met. The time point is determined by the value of the field configured under "TimeCIKey" of the ConfigItem, and modified by "TimeModifier". If the latter can be either just a number, or a sign (+/-), a number, and an unit (d/h/m): "7" is equivalent to "+7d". The DynamicField "Ticket->DynamicField" will be used to mark created tickets - it has to exist. The flags \<OTOBO_CONFIGITEM_X\> where X can be NAME, NUMBER and DATE, will be substituted with the respective values in "Ticket->Text".'} =
        'В определенный момент времени создайте тикет для элементов конфигурации, если выполняются заданные требования. Временная точка определяется значением поля, настроенного под "TimeCIKey" ConfigItem, и модифицируется "TimeModifier". В качестве последнего может выступать либо просто число, либо знак (+/-), число и единица измерения (д/ч/м): "7" эквивалентно "+7d". Динамическое поле "Ticket->DynamicField" будет использоваться для маркировки созданных билетов - оно должно существовать. Флаги \\<OTOBO_CONFIGITEM_X\>, где X может быть NAME, NUMBER и DATE, будут заменены соответствующими значениями в "Ticket->Text".';
    $Self->{Translation}->{'CIs assigned to customer company'} = 'КИ, закрепленные за компанией-клиентом';
    $Self->{Translation}->{'CIs assigned to customer user'} = 'КИ, назначенные пользователю клиента';
    $Self->{Translation}->{'CMDB Settings'} = 'Настройки CMDB';
    $Self->{Translation}->{'Check for a unique name only within the same ConfigItem class (\'class\') or globally (\'global\'), which means every existing ConfigItem is taken into account when looking for duplicates.'} =
        'Проверка уникальности Имени внутри текущего класса КЕ(\'class\') или глобально (\'global\'),что означает, что любая существующая КЕ учитывается при поиске дубликатов ';
    $Self->{Translation}->{'Choose a module to enforce a naming scheme.'} = 'Выберите модуль для применения схемы именования.';
    $Self->{Translation}->{'Choose a module to enforce a number scheme.'} = 'Выберите модуль для применения схемы счисления.';
    $Self->{Translation}->{'Choose a module to enforce a version string scheme.'} = 'Выберите модуль для применения схемы строк версий.';
    $Self->{Translation}->{'Choose attributes to trigger the creation of a new version.'} = 'Выберите атрибуты для запуска создания новой версии.';
    $Self->{Translation}->{'Choose categories to assign to this config item class.'} = 'Выберите категории, которые будут назначены этому классу элементов конфигурации.';
    $Self->{Translation}->{'Column config item filters for ConfigItem Overview.'} = 'Фильтры столбцов элементов конфигурации для ConfigItem Overview.';
    $Self->{Translation}->{'Columns that can be filtered in the config item overview of the agent interface. Note: Only Config Item attributes and Dynamic Fields (DynamicField_NameX) are allowed.'} =
        'Столбцы, которые можно фильтровать в обзоре элементов конфигурации в интерфейсе агента. Примечание: Разрешены только атрибуты элементов конфигурации и динамические поля (DynamicField_NameX).';
    $Self->{Translation}->{'Columns that can be filtered in the config item overview of the customer interface. Note: Only Config Item attributes and Dynamic Fields (DynamicField_NameX) are allowed.'} =
        'Столбцы, которые можно фильтровать в обзоре элементов конфигурации в интерфейсе клиента. Примечание: Разрешены только атрибуты элементов конфигурации и динамические поля (DynamicField_NameX).';
    $Self->{Translation}->{'Columns that can be filtered in the config item search result overview of the agent interface. Note: Only Config Item attributes and Dynamic Fields (DynamicField_NameX) are allowed.'} =
        'Столбцы, которые можно фильтровать в обзоре результатов поиска элементов конфигурации в интерфейсе агента. Примечание: Разрешены только атрибуты элементов конфигурации и динамические поля (DynamicField_NameX).';
    $Self->{Translation}->{'Config Items'} = 'Конфигурационные единицы';
    $Self->{Translation}->{'Config item add.'} = 'Создать конфигурационную единицу';
    $Self->{Translation}->{'Config item edit.'} = 'Редактировать конфигурационную единицу';
    $Self->{Translation}->{'Config item event module that count the licenses for OTOBOCILicenseCount feature.'} =
        'Модуль событий элемента конфигурации, который подсчитывает количество лицензий для функции OTOBOCILicenseCount.';
    $Self->{Translation}->{'Config item event module that enables logging to history in the agent interface.'} =
        'Config item (КЕ) event module ведущий запись в историю в агентском интерфейсе.';
    $Self->{Translation}->{'Config item event module that updates config items to their current definition.'} =
        'Модуль событий элементов конфигурации, который обновляет элементы конфигурации в соответствии с их текущим определением.';
    $Self->{Translation}->{'Config item event module that updates the table configitem_ĺink.'} =
        'Модуль событий элементов конфигурации, который обновляет таблицу configitem_ĺink.';
    $Self->{Translation}->{'Config item event module updates the current incident state.'} =
        'Модуль событий элемента конфигурации обновляет текущее состояние инцидента.';
    $Self->{Translation}->{'Config item history.'} = 'История конфигурационной единицы';
    $Self->{Translation}->{'Config item print.'} = 'Печать конфигурационной единицы';
    $Self->{Translation}->{'Config item zoom.'} = 'Просмотр конфигурационной единицы';
    $Self->{Translation}->{'ConfigItem Tree View'} = 'Древовидное представление ConfigItem';
    $Self->{Translation}->{'ConfigItem Version'} = 'Версия ConfigItem';
    $Self->{Translation}->{'ConfigItems of the following classes will not be stored on the Elasticsearch server. To apply this to existing CIs, the CI migration has to be run via console, after changing this option.'} =
        'ConfigItems следующих классов не будут храниться на сервере Elasticsearch. Чтобы применить это к существующим CI, необходимо запустить миграцию CI через консоль после изменения этой опции.';
    $Self->{Translation}->{'ConfigItems with the following deployment states will not be stored on the Elasticsearch server. To apply this to existing CIs, the CI migration has to be run via console, after changing this option.'} =
        'ConfigItems со следующими состояниями развертывания не будут храниться на сервере Elasticsearch. Чтобы применить это к существующим CI, необходимо запустить миграцию CI через консоль после изменения этой опции.';
    $Self->{Translation}->{'Configuration Item Limit'} = ' Лимит КЕ';
    $Self->{Translation}->{'Configuration Item limit per page.'} = 'Лимит КЕ на страницу';
    $Self->{Translation}->{'Configuration Management Database.'} = 'База управления конфигурацией';
    $Self->{Translation}->{'Configuration item bulk module.'} = 'Объемный модуль КЕ';
    $Self->{Translation}->{'Configuration item search backend router of the agent interface.'} =
        'Модуль поиска КЕ в агентском интерфейсе';
    $Self->{Translation}->{'Create and manage the definitions for Configuration Items.'} = 'Создание и управление описаниями конфигурационных единиц.';
    $Self->{Translation}->{'Creates Tickets for ConfigItems at specific time points.'} = 'Создает тикеты для ConfigItems в определенные моменты времени.';
    $Self->{Translation}->{'Customers can see historic CI versions.'} = 'Клиенты могут видеть исторические версии CI.';
    $Self->{Translation}->{'Customers have the possibility to manually switch between historic CI versions.'} =
        'У клиентов есть возможность вручную переключаться между историческими версиями CI.';
    $Self->{Translation}->{'Default data to use on attribute for config item search screen. Example: "ITSMConfigItemCreateTimePointFormat=year;ITSMConfigItemCreateTimePointStart=Last;ITSMConfigItemCreateTimePoint=2;".'} =
        'Данные по умолчанию, используемые в атрибуте для экрана поиска элементов конфигурации. Пример: "ITSMConfigItemCreateTimePointFormat=year;ITSMConfigItemCreateTimePointStart=Last;ITSMConfigItemCreateTimePoint=2;".';
    $Self->{Translation}->{'Default data to use on attribute for config item search screen. Example: "ITSMConfigItemCreateTimeStartYear=2010;ITSMConfigItemCreateTimeStartMonth=10;ITSMConfigItemCreateTimeStartDay=4;ITSMConfigItemCreateTimeStopYear=2010;ITSMConfigItemCreateTimeStopMonth=11;ITSMConfigItemCreateTimeStopDay=3;".'} =
        'Данные по умолчанию, используемые в атрибуте для экрана поиска элементов конфигурации. Пример: "ITSMConfigItemCreateTimeStartYear=2010;ITSMConfigItemCreateTimeStartMonth=10;ITSMConfigItemCreateTimeStartDay=4;ITSMConfigItemCreateTimeStopYear=2010;ITSMConfigItemCreateTimeStopMonth=11;ITSMConfigItemCreateTimeStopDay=3;".';
    $Self->{Translation}->{'Define Actions where a settings button is available in the linked objects widget (LinkObject::ViewMode = "complex"). Please note that these Actions must have registered the following JS and CSS files: Core.AllocationList.css, Core.UI.AllocationList.js, Core.UI.Table.Sort.js, Core.Agent.TableFilters.js and Core.Agent.LinkObject.js.'} =
        'Задает Действия/Actions когда кнопка настройки доступна в связанном виджете (LinkObject::ViewMode = "complex"). Обратите внимание, что эти Действия/Actions должны иметь зарегистрированные JS или CSS файлы: Core.AllocationList.css, Core.UI.AllocationList.js, Core.UI.Table.Sort.js, Core.Agent.TableFilters.js и Core.Agent.LinkObject.js.';
    $Self->{Translation}->{'Define a Template::Toolkit scheme for version strings. Only used if Version String Module is set to TemplateToolkit.'} =
        'Определяет схему Template::Toolkit для строк версий. Используется только в том случае, если для Version String Module установлено значение TemplateToolkit.';
    $Self->{Translation}->{'Define a set of conditions under which a customer is allowed to see a config item. Conditions can optionally be restricted to certain customer groups. Name is the only mandatory attribute. If no other options are given, all config items will be visible under that category.'} =
        'Определите набор условий, при которых клиенту разрешается видеть элемент конфигурации. Условия могут быть ограничены определенными группами клиентов. Название - единственный обязательный атрибут. Если другие параметры не указаны, все элементы конфигурации будут видны в этой категории.';
    $Self->{Translation}->{'Defines Required permissions to create ITSM configuration items using the Generic Interface.'} =
        'Задать требуемые права для создания ITSM КЕ с использованием Generic Interface.';
    $Self->{Translation}->{'Defines Required permissions to delete ITSM configuration items using the Generic Interface.'} =
        'Задать требуемые права для удаления ITSM КЕ с использованием Generic Interface.';
    $Self->{Translation}->{'Defines Required permissions to get ITSM configuration items using the Generic Interface.'} =
        'Задает требуемые права для получения ITSM КЕ с использованием Generic Interface.';
    $Self->{Translation}->{'Defines Required permissions to search ITSM configuration items using the Generic Interface.'} =
        'Задает требуемые права для поиска ITSM КЕ с использованием Generic Interface';
    $Self->{Translation}->{'Defines Required permissions to update ITSM configuration items using the Generic Interface.'} =
        'Задает требуемые права для одновления ITSM КЕ с использованием Generic Interface';
    $Self->{Translation}->{'Defines an overview module to show the small view of a configuration item list.'} =
        'Задает модуль просмотра КЕ в кратком виде.';
    $Self->{Translation}->{'Defines if the link type labels must be shown in the node connections.'} =
        'Определяет, должны ли метки типов связей отображаться в соединениях узлов.';
    $Self->{Translation}->{'Defines regular expressions individually for each ConfigItem class to check the ConfigItem name and to show corresponding error messages.'} =
        'Задает регулярные выражения для каждого отдельного класса для проверки имен КЕ и выдачи сообщений об ошибках.';
    $Self->{Translation}->{'Defines the available columns of CIs in the config item overview depending on the CI class. Each entry must consist of a class name and an array of available fields for the corresponding class. Dynamic field entries have to honor the scheme DynamicField_FieldName.'} =
        'Определяет доступные столбцы CI в обзоре элементов конфигурации в зависимости от класса CI. Каждая запись должна состоять из имени класса и массива доступных полей для соответствующего класса. Записи динамических полей должны соответствовать схеме DynamicField_FieldName.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of the agent interface.'} =
        'Определяет атрибут элемента конфигурации по умолчанию для сортировки элементов конфигурации в результатах поиска элементов конфигурации в интерфейсе агента.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of the customer interface.'} =
        'Определяет атрибут элемента конфигурации по умолчанию для сортировки элементов конфигурации в результатах поиска элементов конфигурации в клиентском интерфейсе.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of this operation.'} =
        'Определяет атрибут элемента конфигурации по умолчанию для сортировки элементов конфигурации в результате поиска элементов конфигурации в этой операции.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the agent interface. Up: oldest on top. Down: latest on top.'} =
        'Определяет порядок элементов конфигурации по умолчанию в результатах поиска элементов конфигурации в интерфейсе агента. Вверх: самый старый сверху. Вниз: самый последний сверху.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the customer interface. Up: oldest on top. Down: latest on top.'} =
        'Определяет порядок элементов конфигурации по умолчанию в результатах поиска элементов конфигурации в интерфейсе клиента. Вверх: самый старый сверху. Вниз: самый последний сверху.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the this operation. Up: oldest on top. Down: latest on top.'} =
        'Определяет порядок элементов конфигурации по умолчанию в результатах поиска элементов конфигурации при выполнении этой операции. Вверх: самый старый сверху. Вниз: самый последний сверху.';
    $Self->{Translation}->{'Defines the default displayed columns of CIs in the config item overview depending on the CI class. Each entry must consist of a class name and an array of available fields for the corresponding class. Dynamic field entries have to honor the scheme DynamicField_FieldName.'} =
        'Определяет отображаемые по умолчанию столбцы CI в обзоре элементов конфигурации в зависимости от класса CI. Каждая запись должна состоять из имени класса и массива доступных полей для соответствующего класса. Записи динамических полей должны соответствовать схеме DynamicField_FieldName.';
    $Self->{Translation}->{'Defines the default relations depth to be shown.'} = 'Определяет глубину отображения отношений по умолчанию.';
    $Self->{Translation}->{'Defines the default shown config item search attribute for config item search screen.'} =
        'Определяет отображаемый по умолчанию атрибут поиска элемента конфигурации для экрана поиска элемента конфигурации.';
    $Self->{Translation}->{'Defines the default shown config item search attribute for config item search screen. Example: "Key" must have the name of the Dynamic Field in this case \'X\', "Content" must have the value of the Dynamic Field depending on the Dynamic Field type,  Text: \'a text\', Dropdown: \'1\', Date/Time: \'Search_DynamicField_XTimeSlotStartYear=1974; Search_DynamicField_XTimeSlotStartMonth=01; Search_DynamicField_XTimeSlotStartDay=26; Search_DynamicField_XTimeSlotStartHour=00; Search_DynamicField_XTimeSlotStartMinute=00; Search_DynamicField_XTimeSlotStartSecond=00; Search_DynamicField_XTimeSlotStopYear=2013; Search_DynamicField_XTimeSlotStopMonth=01; Search_DynamicField_XTimeSlotStopDay=26; Search_DynamicField_XTimeSlotStopHour=23; Search_DynamicField_XTimeSlotStopMinute=59; Search_DynamicField_XTimeSlotStopSecond=59;\' and or \'Search_DynamicField_XTimePointFormat=week; Search_DynamicField_XTimePointStart=Before; Search_DynamicField_XTimePointValue=7\';.'} =
        'Определяет отображаемый по умолчанию атрибут поиска элемента конфигурации для экрана поиска элемента конфигурации. Пример: "Key" должно содержать имя динамического поля, в данном случае \'X\', "Content" должно содержать значение динамического поля в зависимости от типа динамического поля, Text: \'a text\', Dropdown: \'1\', Date/Time: \'Search_DynamicField_XTimeSlotStartYear=1974; Search_DynamicField_XTimeSlotStartMonth=01; Search_DynamicField_XTimeSlotStartDay=26; Search_DynamicField_XTimeSlotStartHour=00; Search_DynamicField_XTimeSlotStartMinute=00; Search_DynamicField_XTimeSlotStartSecond=00; Search_DynamicField_XTimeSlotStopYear=2013; Search_DynamicField_XTimeSlotStopMonth=01; Search_DynamicField_XTimeSlotStopDay=26; Search_DynamicField_XTimeSlotStopHour=23; Search_DynamicField_XTimeSlotStopMinute=59; Search_DynamicField_XTimeSlotStopSecond=59;\' и или \'Search_DynamicField_XTimePointFormat=week; Search_DynamicField_XTimePointStart=Before; Search_DynamicField_XTimePointValue=7\';.';
    $Self->{Translation}->{'Defines the default subobject of the class \'ITSMConfigItem\'.'} =
        'Задает умалчивамый подобъект для класса \'ITSMConfigItem\'.';
    $Self->{Translation}->{'Defines the number of rows for the CI definition editor in the admin interface.'} =
        'Задает количество строк для редактора описаний КЕ (CI) в интерфейсе админа.';
    $Self->{Translation}->{'Defines the order of incident states from high (e.g. cricital) to low (e.g. functional).'} =
        'Задает порядок состояний инцидентов от высоких (например, критических) до низких (например, функциональных).';
    $Self->{Translation}->{'Defines the relevant deployment states where linked tickets can affect the status of a CI.'} =
        'Задает соответствующие состояния развертывания, когда связанные заявки могут влиять на статус КЕ.';
    $Self->{Translation}->{'Defines the search limit for the AgentITSMConfigItem screen.'} =
        'Задает лимит поиска объектов для экрана AgentITSMConfigItem';
    $Self->{Translation}->{'Defines the search limit for the AgentITSMConfigItemSearch screen.'} =
        'Задает лимит поиска объектов для экрана AgentITSMConfigItemSearch';
    $Self->{Translation}->{'Defines the search limit for the CustomerITSMConfigItem screen.'} =
        'Определяет предел поиска для экрана CustomerITSMConfigItem.';
    $Self->{Translation}->{'Defines the search limit for the CustomerITSMConfigItemSearch screen.'} =
        'Определяет предел поиска для экрана CustomerITSMConfigItemSearch.';
    $Self->{Translation}->{'Defines the shown columns of CIs in the link table complex view for all CI classes. If there is no entry, then the default columns are shown.'} =
        'Определяет отображаемые столбцы КИ в комплексном представлении таблицы связей для всех классов КИ. Если запись отсутствует, то отображаются столбцы по умолчанию.';
    $Self->{Translation}->{'Defines the shown columns of CIs in the link table complex view, depending on the CI class. Each entry must be prefixed with the class name and double colons (i.e. Computer::). There are a few CI-Attributes that common to all CIs (example for the class Computer: Computer::Name, Computer::CurDeplState, Computer::CreateTime). To show individual CI-Attributes as defined in the CI-Definition, the following scheme must be used (example for the class Computer): Computer::HardDisk::1, Computer::HardDisk::1::Capacity::1, Computer::HardDisk::2, Computer::HardDisk::2::Capacity::1. If there is no entry for a CI class, then the default columns are shown.'} =
        'Задает перечень отображаемых столбцов отображаемых КЕ в таблице при создании связи, в зависимости от класса. Каждое имя атрибута должно иметь в качестве префикса - имя класса и два двоеточия (i.e. Computer::). Есть ряд атрибутов, общих для всех классов (например, для класса Computer: Computer::Name, Computer::CurDeplState, Computer::CreateTime). Для отображения индивидуальных атрибутов, специфичных для конкретного класса из описания КЕ (CI-Definition), используется следующий синтаксис (например, для класса Computer): Computer::HardDisk::1, Computer::HardDisk::1::Capacity::1, Computer::HardDisk::2, Computer::HardDisk::2::Capacity::1. Если нет атрибутов для конкретного класса, отображаются столбцы заданные параметром ITSMConfigItem::Frontend::AgentITSMConfigItem###ShowColumns.';
    $Self->{Translation}->{'Defines which items are available for \'Action\' in third level of the ITSM Config Item ACL structure.'} =
        'Определяет, какие элементы доступны для "Действия" на третьем уровне структуры ITSM Config Item ACL.';
    $Self->{Translation}->{'Defines which items are available in first level of the ITSM Config Item ACL structure.'} =
        'Определяет, какие элементы доступны на первом уровне структуры ITSM Config Item ACL.';
    $Self->{Translation}->{'Defines which items are available in second level of the ITSM Config Item ACL structure.'} =
        'Определяет, какие элементы доступны на втором уровне структуры ITSM Config Item ACL.';
    $Self->{Translation}->{'Defines which type of link (named from the ticket perspective) can affect the status of a linked CI.'} =
        'Определяет, какой тип связи (названный с точки зрения заявки) может повлиять на статус связанной КЕ.';
    $Self->{Translation}->{'Defines which type of ticket can affect the status of a linked CI.'} =
        'Определяет, какой тип заявки может повлиять на статус связанной КЕ.';
    $Self->{Translation}->{'Definition Update'} = 'Обновление определений';
    $Self->{Translation}->{'Delete Configuration Item'} = 'Удалить конфигурационную единицу';
    $Self->{Translation}->{'DeplState'} = 'DeplState';
    $Self->{Translation}->{'Deployment State Color'} = 'Цвет состояния использования';
    $Self->{Translation}->{'DeploymentState'} = 'DeploymentState';
    $Self->{Translation}->{'Duplicate'} = 'Резерв';
    $Self->{Translation}->{'Dynamic field event module that marks config item definitions as out of sync, if containing dynamic fields change.'} =
        'Модуль событий динамических полей, который помечает определения элементов конфигурации как рассинхронизированные, если содержащиеся в них динамические поля изменяются.';
    $Self->{Translation}->{'Dynamic fields shown in the additional ITSM field screen of the agent interface.'} =
        'Динамические поля, показанные на дополнительном экране поля ITSM интерфейса агента.';
    $Self->{Translation}->{'Dynamic fields shown in the config item overview screen of the customer interface.'} =
        'Динамические поля, отображаемые на экране обзора элементов конфигурации в интерфейсе клиента.';
    $Self->{Translation}->{'Dynamic fields shown in the config item search screen of the agent interface.'} =
        'Динамические поля, отображаемые на экране поиска элементов конфигурации в интерфейсе агента.';
    $Self->{Translation}->{'Enables configuration item bulk action feature for the agent frontend to work on more than one configuration item at a time.'} =
        'Включает возможность массовых действий с КЕ для интерфейса агента для работы с несколькими КЕ одновременно.';
    $Self->{Translation}->{'Enables configuration item bulk action feature only for the listed groups.'} =
        'Включает возможность массовых действий с КЕ только для перечисленных групп.';
    $Self->{Translation}->{'Enables/disables the functionality to check ITSM onfiguration items for unique names. Before enabling this option you should check your system for already existing config items with duplicate names. You can do this with the console command Admin::ITSM::Configitem::ListDuplicates.'} =
        'Включает/выключает функцию проверки элементов конфигурации ITSM на наличие уникальных имен. Перед включением этой опции необходимо проверить систему на наличие уже существующих элементов конфигурации с дублирующимися именами. Это можно сделать с помощью консольной команды Admin::ITSM::Configitem::ListDuplicates.';
    $Self->{Translation}->{'Event module to set configitem-status on ticket-configitem-link.'} =
        'Модуль установки статуса КЕ для связанной с ней заявки.';
    $Self->{Translation}->{'Fields of the configuration item index, used for the fulltext search. Fields are also stored, but are not mandatory for the overall functionality. Inclusion of attachments can be disabled by setting the entry to 0 or deleting it.'} =
        'Поля индекса элемента конфигурации, используемые для полнотекстового поиска. Поля также сохраняются, но не являются обязательными для общей функциональности. Включение вложений можно отключить, установив для записи значение 0 или удалив ее.';
    $Self->{Translation}->{'Fields stored in the configuration item index which are used for other things besides fulltext searches. For the complete functionality all fields are mandatory.'} =
        'Поля, хранящиеся в индексе элемента конфигурации, которые используются не только для полнотекстового поиска. Для полной функциональности все поля являются обязательными.';
    $Self->{Translation}->{'For every webservice (key) an array of classes (value) can be defined on which the import is restricted. For all chosen classes, or all existing classes the identifying attributes will have to be chosen in the invoker config.'} =
        'Для каждого веб-сервиса (ключ) может быть определен массив классов (значение), для которых импорт ограничен. Для всех выбранных классов или для всех существующих классов в конфигурации инвокера необходимо будет выбрать идентифицирующие атрибуты.';
    $Self->{Translation}->{'GenericInterface module registration for the ConfigItemFetch invoker layer.'} =
        'Регистрация модуля GenericInterface для уровня инвокера ConfigItemFetch.';
    $Self->{Translation}->{'ITSM ConfigItem'} = 'ITSM ConfigItem';
    $Self->{Translation}->{'ITSM config item overview.'} = 'Обзор конфигурационных единиц ITSM.';
    $Self->{Translation}->{'If this option is activated, linked items are only counted if they belong to one of the listed classes.'} =
        'Если этот параметр активирован, связанные элементы будут учитываться только в том случае, если они принадлежат к одному из перечисленных классов.';
    $Self->{Translation}->{'InciState'} = 'InciState';
    $Self->{Translation}->{'IncidentState'} = 'IncidentState';
    $Self->{Translation}->{'Includes deployment states in the config item search of the customer interface.'} =
        'Включает состояния развертывания в поиск элементов конфигурации в интерфейсе клиента.';
    $Self->{Translation}->{'Includes incident states in the config item search of the customer interface.'} =
        'Включает состояния инцидента в поиск элементов конфигурации в интерфейсе клиента.';
    $Self->{Translation}->{'Maximum number of config items to be displayed in the result of this operation.'} =
        'Максимальное количество элементов конфигурации, которые будут отображаться в результате этой операции.';
    $Self->{Translation}->{'Module to check the group responsible for a class.'} = 'Модуль для проверки группы ответственной за класс';
    $Self->{Translation}->{'Module to check the group responsible for a configuration item.'} =
        'Модуль для проверки группы ответственной за КЕ';
    $Self->{Translation}->{'Module to generate ITSM config item statistics.'} = 'Модуль формирования статистики по КЕ.';
    $Self->{Translation}->{'Name Module'} = 'Модуль имени';
    $Self->{Translation}->{'Number Module'} = 'Номерной модуль';
    $Self->{Translation}->{'Number of config items to be displayed in each page of a search result in the agent interface.'} =
        'Количество элементов конфигурации, отображаемых на каждой странице результатов поиска в интерфейсе агента.';
    $Self->{Translation}->{'Number of config items to be displayed in each page of a search result in the customer interface.'} =
        'Количество элементов конфигурации, отображаемых на каждой странице результатов поиска в интерфейсе клиента.';
    $Self->{Translation}->{'Objects to search for, how many entries and which attributs to show. ConfigItem attributes have to explicitly be stored via Elasticsearch.'} =
        'Объекты для поиска, количество записей и атрибуты для отображения. Атрибуты ConfigItem должны быть явно сохранены через Elasticsearch.';
    $Self->{Translation}->{'Overview.'} = 'Обзор';
    $Self->{Translation}->{'Parameters for the categories for config item classes in the preferences view of the agent interface.'} =
        'Параметры для категорий классов элементов конфигурации в представлении предпочтений интерфейса агента.';
    $Self->{Translation}->{'Parameters for the column filters of the small config item overview. Please note: setting \'Active\' to 0 will only prevent agents from editing settings of this group in their personal preferences, but will still allow administrators to edit the settings of another user\'s behalf. Use \'PreferenceGroup\' to control in which area these settings should be shown in the user interface.'} =
        'Параметры для фильтров столбцов обзора элементов малой конфигурации. Обратите внимание: при установке значения \'Active\' в 0 агенты не смогут редактировать настройки этой группы в своих личных предпочтениях, но администраторы смогут редактировать настройки от имени другого пользователя. Используйте \'PreferenceGroup\' для управления тем, в какой области пользовательского интерфейса должны отображаться эти настройки.';
    $Self->{Translation}->{'Parameters for the dashboard backend of the customer company config item overview of the agent interface . "Limit" is the number of entries shown by default. "Group" is used to restrict the access to the plugin (e. g. Group: admin;group1;group2;). "Default" determines if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" is the cache time in minutes for the plugin.'} =
        'Определяет отображаемые столбцы КИ в комплексном представлении таблицы связей для всех классов КИ. Если запись отсутствует, то отображаются столбцы по умолчанию.';
    $Self->{Translation}->{'Parameters for the deployment states color in the preferences view of the agent interface.'} =
        'Параметры для цветов обозначающих состояния использования КЕ в настройках обзоров в интерфейсе агента.';
    $Self->{Translation}->{'Parameters for the deployment states in the preferences view of the agent interface.'} =
        'Параметры для состояний использования КЕ в настройках обзоров в интерфейсе агента.';
    $Self->{Translation}->{'Parameters for the example permission groups of the general catalog attributes.'} =
        'Параметры для примерных групповых прав для атрибутов Общего каталога';
    $Self->{Translation}->{'Parameters for the name module for config item classes in the preferences view of the agent interface.'} =
        'Параметры модуля имени для классов элементов конфигурации в представлении предпочтений интерфейса агента.';
    $Self->{Translation}->{'Parameters for the number module for config item classes in the preferences view of the agent interface.'} =
        'Параметры для модуля количества классов элементов конфигурации в представлении предпочтений интерфейса агента.';
    $Self->{Translation}->{'Parameters for the pages (in which the configuration items are shown).'} =
        'Параметры страниц (на которых отображаются КЕ)';
    $Self->{Translation}->{'Parameters for the version string module for config item classes in the preferences view of the agent interface.'} =
        'Параметры модуля строки версии для классов элементов конфигурации в представлении предпочтений интерфейса агента.';
    $Self->{Translation}->{'Parameters for the version string template toolkit module for config item classes in the preferences view of the agent interface.'} =
        'Параметры модуля инструментария шаблона строки версии для классов элементов конфигурации в представлении предпочтений интерфейса агента.';
    $Self->{Translation}->{'Parameters for the version trigger for config item classes in the preferences view of the agent interface.'} =
        'Параметры для триггера версии для классов элементов конфигурации в представлении предпочтений интерфейса агента.';
    $Self->{Translation}->{'Performs the configured action for each event (as an Invoker) for each configured Webservice.'} =
        'Выполняет заданное действие для каждого события (как Invoker) для каждого настроенного Webservice.';
    $Self->{Translation}->{'Permission Group'} = 'Группа разрешений';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item attachment action in the agent interface.'} =
        'Необходимые разрешения для использования действия прикрепления элемента конфигурации ITSM в интерфейсе агента.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item screen in the agent interface.'} =
        'Требуемые права для использования обзора КЕ в CMDB агентом';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item search screen in the agent interface.'} =
        'Требуемые права для использования поиска в CMDB агентом';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item search screen in the customer interface.'} =
        'Необходимые разрешения для использования экрана поиска элементов конфигурации ITSM в интерфейсе клиента.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item tree view screen in the agent interface.'} =
        'Необходимые разрешения для использования экрана просмотра дерева элементов конфигурации ITSM в интерфейсе агента.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item zoom screen in the agent interface.'} =
        'Требуемые права для использования полного просмотра КЕ (zoom view) в CMDB агентом';
    $Self->{Translation}->{'Required permissions to use the add ITSM configuration item screen in the agent interface.'} =
        'Требуемые права для добавления КЕ в CMDB агентом';
    $Self->{Translation}->{'Required permissions to use the bulk ITSM configuration item screen in the agent interface.'} =
        'Необходимые разрешения для использования экрана элементов конфигурации ITSM в интерфейсе агента.';
    $Self->{Translation}->{'Required permissions to use the edit ITSM configuration item screen in the agent interface.'} =
        'Требуемые права для редактирования содержимого КЕ в CMDB агентом';
    $Self->{Translation}->{'Required permissions to use the history ITSM configuration item screen in the agent interface.'} =
        'Требуемые права для просмотра истории содержимого КЕ в CMDB агентом';
    $Self->{Translation}->{'Required permissions to use the print ITSM configuration item screen in the agent interface.'} =
        'Требуемые права для печати характеристик КЕ в CMDB агентом';
    $Self->{Translation}->{'Required privileges to delete config items.'} = 'Необходимы права для удаления конфигурационных единиц.';
    $Self->{Translation}->{'Search config items.'} = 'Поиск конфигурационных единиц.';
    $Self->{Translation}->{'Set the incident state of a CI automatically when a Ticket is Linked to a CI.'} =
        'Установить состояние инцидента КЕ автоматически, когда заявка связана с КЕ.';
    $Self->{Translation}->{'Sets the deployment state in the configuration item bulk screen of the agent interface.'} =
        'Задает состояние использования на экране массовых действий с КЕ в интерфейсе агента.';
    $Self->{Translation}->{'Sets the incident state in the configuration item bulk screen of the agent interface.'} =
        'Задает состояние инцидента на экране массовых действий с КЕ в интерфейсе агента.';
    $Self->{Translation}->{'Shows a link in the menu that allows linking a configuration item with another object in the config item zoom view of the agent interface.'} =
        'Показывает пункт меню Связать (Link) для организации связи КЕ с другим объектом на экране полного (zoom view) просмотра';
    $Self->{Translation}->{'Shows a link in the menu to access the history of a configuration item in the configuration item overview of the agent interface.'} =
        'Показывает пункт меню для доступа к истории КЕ при просмотре КЕ в интерфейсе агента.';
    $Self->{Translation}->{'Shows a link in the menu to access the history of a configuration item in the its zoom view of the agent interface.'} =
        'Показывает пункт меню История для просмотра истории КЕ';
    $Self->{Translation}->{'Shows a link in the menu to delete a configuration item in its zoom view of the agent interface.'} =
        'Показывает пункт меню для удаления конфигурационной единицы при подробном просмотре в интерфейсе агента.';
    $Self->{Translation}->{'Shows a link in the menu to display the configuration item links as a Tree View.'} =
        'Указывает ссылку в меню для отображения ссылок на элементы конфигурации в виде древовидного представления.';
    $Self->{Translation}->{'Shows a link in the menu to duplicate a configuration item in the configuration item overview of the agent interface.'} =
        'Показывает пункт меню Дублировать для создания новой КЕ путем копирования характеристик текущей КЕ';
    $Self->{Translation}->{'Shows a link in the menu to duplicate a configuration item in the its zoom view of the agent interface.'} =
        'Показывает пункт меню Дублировать для создания новой КЕ путем копирования характеристик текущей КЕ';
    $Self->{Translation}->{'Shows a link in the menu to edit a configuration item in the its zoom view of the agent interface.'} =
        'Показывает пункт меню Редактировать для изменения характеристик КЕ';
    $Self->{Translation}->{'Shows a link in the menu to go back in the configuration item zoom view of the agent interface.'} =
        'Показывает пункт меню Назад при подробном просмотре конфигурационных единиц в интерфейсе агента.';
    $Self->{Translation}->{'Shows a link in the menu to print a configuration item in the its zoom view of the agent interface.'} =
        'Показывает пункт меню Печать для печати характеристик КЕ';
    $Self->{Translation}->{'Shows a link in the menu to zoom into a configuration item in the configuration item overview of the agent interface.'} =
        'Показывает пункт меню для подробного просмотра КЕ при обзоре КЕ в интерфейсе агента';
    $Self->{Translation}->{'Shows the config item history (reverse ordered) in the agent interface.'} =
        'Показ истории содержимого КЕ (порядок показа)';
    $Self->{Translation}->{'The default category which is shown, if none is selected.'} = 'Категория по умолчанию, которая отображается, если не выбрана ни одна из них.';
    $Self->{Translation}->{'The identifier for a configuration item, e.g. ConfigItem#, MyConfigItem#. The default is ConfigItem#.'} =
        'Идентификатор (префикс) к номеру КЕ, т.е КЕ_№, КЕ#, Учетный_элемент_№. По умолчанию - ConfigItem# (или его перевод).';
    $Self->{Translation}->{'Triggers ConfigItemFetch invoker automatically.'} = 'Автоматически запускает инвокер ConfigItemFetch.';
    $Self->{Translation}->{'Version String Expression'} = 'Версия Строковое выражение';
    $Self->{Translation}->{'Version String Module'} = 'Модуль строк версий';
    $Self->{Translation}->{'Version Trigger'} = 'Триггер версии';
    $Self->{Translation}->{'Whether the execution of ConfigItemACL can be avoided by checking cached field dependencies. This can improve loading times of formulars, but has to be disabled, if ACLModules are to be used for ITSMConfigItem- and Form-ReturnTypes.'} =
        'Можно ли избежать выполнения ConfigItemACL, проверяя кэшированные зависимости полей. Это может улучшить время загрузки формуляров, но должно быть отключено, если ACLM-модули будут использоваться для ITSMConfigItem- и Form-ReturnTypes.';
    $Self->{Translation}->{'Which general information is shown in the header.'} = 'Какая общая информация отображается в заголовке.';
    $Self->{Translation}->{'With this option it´s possible to fill automaticly a CI field, depending on the count of linked CI´s with the existing type DependsOn.'} =
        'С помощью этой опции можно автоматически заполнить поле CI в зависимости от количества связанных CI с существующим типом DependsOn.';
    $Self->{Translation}->{'With this option it´s possible to fill automaticly a CI field, depending on the count of linked CI´s.'} =
        'С помощью этой опции можно автоматически заполнять поле CI в зависимости от количества связанных CI.';
    $Self->{Translation}->{'With this option it´s possible to fill automaticly a CI field, depending on the count of linked CI´s. The setting CounterClassName include the name of the class and CounterFieldName is used to store the count of used licence.'} =
        'С помощью этой опции можно автоматически заполнять поле CI в зависимости от количества связанных CI. Настройка CounterClassName включает имя класса, а CounterFieldName используется для хранения количества использованных лицензий.';
    $Self->{Translation}->{'class'} = 'класс';
    $Self->{Translation}->{'global'} = 'глобальный';
    $Self->{Translation}->{'postproductive'} = 'постпродуктивный';
    $Self->{Translation}->{'preproductive'} = 'предпродуктивный';
    $Self->{Translation}->{'productive'} = 'продуктивный';


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

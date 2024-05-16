# --
# OTOBO is a web-based ticketing system for service organisations.
# --
# Copyright (C) 2001-2020 OTRS AG, https://otrs.com/
# Copyright (C) 2019-2021 Rother OSS GmbH, https://otobo.de/
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
    $Self->{Translation}->{'Config Item Class'} = 'Класс конфигурационной единицы';
    $Self->{Translation}->{'Definition'} = 'Описание';
    $Self->{Translation}->{'Change'} = 'Изменение';

    # Template: AgentDashboardITSMConfigItemGeneric
    $Self->{Translation}->{'Incident State'} = 'Состояние инцидента';
    $Self->{Translation}->{'Deployment State'} = 'Состояние использования';
    $Self->{Translation}->{'Class'} = 'Класс';
    $Self->{Translation}->{'Deployment State Type'} = 'Тип Состояния использования';
    $Self->{Translation}->{'Current Incident State'} = 'Текущее состояние инцидента';
    $Self->{Translation}->{'Current Incident State Type'} = 'Тип Текущего состояния инцидента';
    $Self->{Translation}->{'Last changed'} = 'Время последнего изменения';

    # Template: AgentITSMConfigItemAdd
    $Self->{Translation}->{'Config Item'} = 'Основные средства';
    $Self->{Translation}->{'Filter for Classes'} = 'Фильтр для классов';
    $Self->{Translation}->{'Select a Class from the list to create a new Config Item.'} = 'Выберите класс из списка для создания новой КЕ';

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

    # Template: AgentITSMConfigItemHistory
    $Self->{Translation}->{'History of Config Item: %s'} = 'История конфигурационной единицы: %s';
    $Self->{Translation}->{'History Content'} = 'Содержимое истории';
    $Self->{Translation}->{'Createtime'} = 'Время создания';
    $Self->{Translation}->{'Zoom view'} = 'Подробный показ';

    # Template: AgentITSMConfigItemOverviewNavBar
    $Self->{Translation}->{'Context Settings'} = 'Параметры контекста';
    $Self->{Translation}->{'Config Items per page'} = 'Конфигурационных единиц на страницу';

    # Template: AgentITSMConfigItemOverviewSmall
    $Self->{Translation}->{'A generic ITSM Configuration Item table'} = 'Общая таблица элементов конфигурации ITSM';

    # Template: AgentITSMConfigItemSearch
    $Self->{Translation}->{'Run Search'} = 'Выполнить поиск';
    $Self->{Translation}->{'Also search in previous versions?'} = 'Искать и в предыдущих версиях?';

    # Template: AgentITSMConfigItemZoom
    $Self->{Translation}->{'Configuration Item'} = 'Конфигурационная единица';
    $Self->{Translation}->{'Configuration Item Information'} = ' Информация о Конф. ед.';
    $Self->{Translation}->{'Current Deployment State'} = 'Текущее состояние использования';
    $Self->{Translation}->{'Last changed by'} = 'Автор последнего изменения';
    $Self->{Translation}->{'Show one version'} = 'Показать одну версию';
    $Self->{Translation}->{'Show all versions'} = 'Показать все версии';
    $Self->{Translation}->{'Version Incident State'} = 'Состояние инцидента версии';
    $Self->{Translation}->{'Version Deployment State'} = 'Состояние использования версии объекта';
    $Self->{Translation}->{'Version Number'} = 'Номер версии';
    $Self->{Translation}->{'Configuration Item Version Details'} = 'Полная информация о КЕ выбранной версии';
    $Self->{Translation}->{'Property'} = 'Свойство';

    # Perl Module: Kernel/Modules/AgentITSMConfigItem.pm
    $Self->{Translation}->{'No access to Class is given!'} = 'Нет доступа к классу!';
    $Self->{Translation}->{'Overview: ITSM ConfigItem'} = 'Обзор: ITSM ConfigItem';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemBulk.pm
    $Self->{Translation}->{'No ConfigItemID is given!'} = 'Нет ConfigItemID!';
    $Self->{Translation}->{'You need at least one selected Configuration Item!'} = 'Вам нужна хотя бы одна выбранная конфигурационная единица!';
    $Self->{Translation}->{'You don\'t have write access to this configuration item: %s.'} =
        'У вас нет доступа на запись этой конфигурационной единицы: %s.';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemDelete.pm
    $Self->{Translation}->{'Config item "%s" not found in database!'} = 'Конфигурационная единица "%s" не найдена в базе!';
    $Self->{Translation}->{'Was not able to delete the configitem ID %s!'} = 'Не удалось удалить конфигурационную единицу с ID %s!';
    $Self->{Translation}->{'No version found for ConfigItemID %s!'} = 'Не найдена версия конфигурационной единицы %s!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemEdit.pm
    $Self->{Translation}->{'No ConfigItemID, DuplicateID or ClassID is given!'} = 'Не присвоен ConfigItemID, DuplicateID или ClassID!';
    $Self->{Translation}->{'No access is given!'} = 'Нет доступа!';
    $Self->{Translation}->{'No definition was defined for class %s!'} = 'Класс %s не был определен!';

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
    $Self->{Translation}->{'VersionID %s not found in database!'} = 'Версия %s не найдена в базе!';
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
    $Self->{Translation}->{'operational'} = '';
    $Self->{Translation}->{'warning'} = '';
    $Self->{Translation}->{'incident'} = '';
    $Self->{Translation}->{'The deployment state of this config item'} = 'Состояние использования этой КЕ';
    $Self->{Translation}->{'The incident state of this config item'} = 'Состояние инцидента для этой КЕ';

    # Perl Module: Kernel/Output/HTML/Dashboard/ITSMConfigItemGeneric.pm
    $Self->{Translation}->{'Shown config items'} = '';

    # Perl Module: Kernel/Output/HTML/ITSMConfigItem/LayoutDate.pm
    $Self->{Translation}->{'Between'} = 'Между';

    # Perl Module: Kernel/System/ImportExport/ObjectBackend/ITSMConfigItem.pm
    $Self->{Translation}->{'Maximum number of one element'} = 'Максимальное количество одного элемента';
    $Self->{Translation}->{'Empty fields indicate that the current values are kept'} = 'Пустые поля показывают, что текущие значения сохранятся';
    $Self->{Translation}->{'Skipped'} = 'Пропущено';

    # Perl Module: var/packagesetup/ITSMConfigurationManagement.pm
    $Self->{Translation}->{'Model'} = 'Модель';
    $Self->{Translation}->{'Customer Company'} = '';
    $Self->{Translation}->{'Serial Number'} = 'Серийный номер';
    $Self->{Translation}->{'CPU'} = 'ЦПУ';
    $Self->{Translation}->{'Ram'} = 'ОЗУ';
    $Self->{Translation}->{'Hard Disk'} = 'Жесткий диск';
    $Self->{Translation}->{'Capacity'} = 'Объем';
    $Self->{Translation}->{'Network Adapter'} = 'Сетевой адаптер';
    $Self->{Translation}->{'IP over DHCP'} = 'IP по DHCP';
    $Self->{Translation}->{'IP Address'} = 'IP адрес';
    $Self->{Translation}->{'Graphic Adapter'} = 'Видео адаптер';
    $Self->{Translation}->{'Other Equipment'} = 'Другое оборудование';
    $Self->{Translation}->{'Warranty Expiration Date'} = 'Срок истечения гарантии';
    $Self->{Translation}->{'Install Date'} = 'Дата установки';
    $Self->{Translation}->{'Phone 1'} = 'Телефон 1';
    $Self->{Translation}->{'Phone 2'} = 'Телефон 2';
    $Self->{Translation}->{'E-Mail'} = 'E-Mail';
    $Self->{Translation}->{'Network Address'} = 'Сетевой адрес';
    $Self->{Translation}->{'Subnet Mask'} = 'Маска подсети';
    $Self->{Translation}->{'Gateway'} = 'Шлюз';
    $Self->{Translation}->{'Licence Type'} = 'Тип лицензии';
    $Self->{Translation}->{'Licence Key'} = 'Лицензионный ключ';
    $Self->{Translation}->{'Quantity'} = 'Количество';
    $Self->{Translation}->{'Expiration Date'} = 'Срок лицензии';
    $Self->{Translation}->{'Media'} = 'Мультимедийные средства';

    # Database XML Definition: ITSMConfigurationManagement.sopm
    $Self->{Translation}->{'Computer'} = 'Компьютер';
    $Self->{Translation}->{'Hardware'} = 'Аппаратное обеспечение';
    $Self->{Translation}->{'Network'} = 'Сеть';
    $Self->{Translation}->{'Software'} = 'Программное обеспечение';
    $Self->{Translation}->{'Expired'} = 'Устарело';
    $Self->{Translation}->{'Maintenance'} = 'Техническое обслуживание';
    $Self->{Translation}->{'Pilot'} = 'Эксперимент';
    $Self->{Translation}->{'Planned'} = 'Запланированно';
    $Self->{Translation}->{'Repair'} = 'Ремонт';
    $Self->{Translation}->{'Retired'} = 'Списано';
    $Self->{Translation}->{'Review'} = 'Экспертиза';
    $Self->{Translation}->{'Test/QA'} = 'Тестирование';
    $Self->{Translation}->{'Laptop'} = 'Ноутбук';
    $Self->{Translation}->{'Desktop'} = 'Настольный ПК';
    $Self->{Translation}->{'PDA'} = 'PDA';
    $Self->{Translation}->{'Server'} = 'Сервер';
    $Self->{Translation}->{'Other'} = 'Другое';
    $Self->{Translation}->{'Monitor'} = 'Монитор';
    $Self->{Translation}->{'Printer'} = 'Принтер';
    $Self->{Translation}->{'Switch'} = 'Коммутатор';
    $Self->{Translation}->{'Router'} = 'Маршрутизатор';
    $Self->{Translation}->{'WLAN Access Point'} = 'WLAN точка доступа';
    $Self->{Translation}->{'Security Device'} = 'Смарт-карта';
    $Self->{Translation}->{'Backup Device'} = 'Устройство бэкапа';
    $Self->{Translation}->{'Mouse'} = 'Мышка';
    $Self->{Translation}->{'Keyboard'} = 'Клавиатура';
    $Self->{Translation}->{'Camera'} = 'Камера';
    $Self->{Translation}->{'Beamer'} = 'Проектор';
    $Self->{Translation}->{'Modem'} = 'Модем';
    $Self->{Translation}->{'PCMCIA Card'} = 'PCMCIA карта';
    $Self->{Translation}->{'USB Device'} = 'USB устройство';
    $Self->{Translation}->{'Docking Station'} = 'Док-станция';
    $Self->{Translation}->{'Scanner'} = 'Сканер';
    $Self->{Translation}->{'Building'} = 'Здание';
    $Self->{Translation}->{'Office'} = 'Офис';
    $Self->{Translation}->{'Floor'} = 'Этаж';
    $Self->{Translation}->{'Room'} = 'Кабинет';
    $Self->{Translation}->{'Rack'} = 'Стойка';
    $Self->{Translation}->{'Workplace'} = 'Рабочее место';
    $Self->{Translation}->{'Outlet'} = 'Розетка';
    $Self->{Translation}->{'IT Facility'} = 'ИТ объект';
    $Self->{Translation}->{'LAN'} = 'Сетевая карта';
    $Self->{Translation}->{'WLAN'} = 'WLAN';
    $Self->{Translation}->{'Telco'} = 'Telco';
    $Self->{Translation}->{'GSM'} = 'GSM';
    $Self->{Translation}->{'Client Application'} = 'Клиентское приложение';
    $Self->{Translation}->{'Middleware'} = 'Промежуточное ПО';
    $Self->{Translation}->{'Server Application'} = 'Серверное приложение';
    $Self->{Translation}->{'Client OS'} = 'Клиентская ОС';
    $Self->{Translation}->{'Server OS'} = 'Серверная ОС';
    $Self->{Translation}->{'Admin Tool'} = 'Системные утилиты';
    $Self->{Translation}->{'User Tool'} = 'Пользовательские утилиты';
    $Self->{Translation}->{'Embedded'} = 'Встроенный';
    $Self->{Translation}->{'Single Licence'} = 'Однократная лицензия';
    $Self->{Translation}->{'Per User'} = 'На пользователя';
    $Self->{Translation}->{'Per Processor'} = 'На ЦПУ';
    $Self->{Translation}->{'Per Server'} = 'На сервер';
    $Self->{Translation}->{'Per Node'} = 'На ноду(узел)';
    $Self->{Translation}->{'Volume Licence'} = 'Корпоративная лицензия';
    $Self->{Translation}->{'Enterprise Licence'} = 'Корпоративная лицензия';
    $Self->{Translation}->{'Developer Licence'} = 'Лицензия для разработчика';
    $Self->{Translation}->{'Demo'} = 'Демо-версия';
    $Self->{Translation}->{'Time Restricted'} = 'Ограниченная по времени';
    $Self->{Translation}->{'Freeware'} = 'Бесплатное ПО';
    $Self->{Translation}->{'Open Source'} = 'ПО с открытым кодом';
    $Self->{Translation}->{'Unlimited'} = 'Без ограничений';

    # JS File: ITSM.Agent.ConfigItem.Zoom
    $Self->{Translation}->{'Ok'} = 'Ok';

    # SysConfig
    $Self->{Translation}->{'A precentage value of the minimal translation progress per language, to be usable for documentations.'} =
        '';
    $Self->{Translation}->{'Access repos via http or https.'} = '';
    $Self->{Translation}->{'Autoloading of Znuny4OTRSRepo extensions.'} = '';
    $Self->{Translation}->{'Backend module registration for the config conflict check module.'} =
        '';
    $Self->{Translation}->{'Backend module registration for the file conflict check module.'} =
        '';
    $Self->{Translation}->{'Backend module registration for the function redefine check module.'} =
        '';
    $Self->{Translation}->{'Backend module registration for the manual set module.'} = '';
    $Self->{Translation}->{'Block hooks to be created for BS ad removal.'} = '';
    $Self->{Translation}->{'Block hooks to be created for package manager output filter.'} =
        '';
    $Self->{Translation}->{'Branch View commit limit'} = '';
    $Self->{Translation}->{'CodePolicy'} = '';
    $Self->{Translation}->{'Commit limit per page for Branch view screen'} = '';
    $Self->{Translation}->{'Create analysis file'} = '';
    $Self->{Translation}->{'Creates a analysis file from this ticket and sends to Znuny.'} =
        '';
    $Self->{Translation}->{'Creates a analysis file from this ticket.'} = '';
    $Self->{Translation}->{'Define private addon repos.'} = '';
    $Self->{Translation}->{'Defines the filter that processes the HTML templates.'} = '';
    $Self->{Translation}->{'Defines the test module for checking code policy.'} = '';
    $Self->{Translation}->{'Definition of GIT clone/push URL Prefix.'} = '';
    $Self->{Translation}->{'Definition of a Dynamic Field: Group => Group with access to the Dynamic Fields; AlwaysVisible => Field can be removed (0|1); InformationAreaName => Name of the Widgets; InformationAreaSize => Size and position of the widgets (Large|Small); Name => Name of the Dynamic Field which should be used; Priority => Order of the Dynamic Fields; State => State of the Fields (0 = disabled, 1 = active, 2 = mandatory), FilterRelease => Regex which the repository name has to match to be displayed, FilterPackage => Regex which the package name has to match to be displayed, FilterBranch => Regex which the branch name has to match to be displayed, FilterRelease => Regex which the repelase version string has to match to be displayed.'} =
        '';
    $Self->{Translation}->{'Definition of a Dynamic Field: Group => Group with access to the Dynamic Fields; AlwaysVisible => Field can be removed (0|1); InformationAreaName => Name of the Widgets; InformationAreaSize => Size and position of the widgets (Large|Small); Name => Name of the Dynamic Field which should be used; Priority => Order of the Dynamic Fields; State => State of the Fields (0 = disabled, 1 = active, 2 = mandatory), FilterRepository => Regex which the repository name has to match to be displayed, FilterPackage => Regex which the package name has to match to be displayed, FilterBranch => Regex which the branch name has to match to be displayed, FilterRelease => Regex which the repelase version string has to match to be displayed.'} =
        '';
    $Self->{Translation}->{'Definition of external MD5 sums (key => MD5, Value => Vendor, PackageName, Version, Date).'} =
        '';
    $Self->{Translation}->{'Definition of mappings between public repository requests and internal OPMS repositories.'} =
        '';
    $Self->{Translation}->{'Definition of package states.'} = '';
    $Self->{Translation}->{'Definition of renamed OPMS packages.'} = '';
    $Self->{Translation}->{'Directory, which is used by Git to cache repositories.'} = '';
    $Self->{Translation}->{'Directory, which is used by Git to store temporary data.'} = '';
    $Self->{Translation}->{'Directory, which is used by Git to store working copies.'} = '';
    $Self->{Translation}->{'Disable online repositories.'} = '';
    $Self->{Translation}->{'Do not log git ssh connection authorization results for these users. Useful for automated stuff.'} =
        '';
    $Self->{Translation}->{'Dynamic Fields Screens'} = '';
    $Self->{Translation}->{'DynamicFieldScreen'} = '';
    $Self->{Translation}->{'Export all available public keys to authorized_keys file.'} = '';
    $Self->{Translation}->{'Export all relevant releases to ftp server.'} = '';
    $Self->{Translation}->{'Frontend module registration for the OPMS object in the agent interface.'} =
        '';
    $Self->{Translation}->{'Frontend module registration for the PublicOPMSRepository object in the public interface.'} =
        '';
    $Self->{Translation}->{'Frontend module registration for the PublicOPMSRepositoryLookup object in the public interface.'} =
        '';
    $Self->{Translation}->{'Frontend module registration for the PublicOPMSTestBuild object in the public interface.'} =
        '';
    $Self->{Translation}->{'Frontend module registration for the PublicPackageVerification object in the public interface.'} =
        '';
    $Self->{Translation}->{'Frontend module registration for the admin interface.'} = '';
    $Self->{Translation}->{'GIT Author registration.'} = '';
    $Self->{Translation}->{'Generate HTML comment hooks for the specified blocks so that filters can use them.'} =
        '';
    $Self->{Translation}->{'Generate documentations once per night.'} = '';
    $Self->{Translation}->{'Git'} = '';
    $Self->{Translation}->{'Git Management'} = '';
    $Self->{Translation}->{'Git Repository'} = '';
    $Self->{Translation}->{'Group, whose members have delete admin permissions in OPMS.'} = '';
    $Self->{Translation}->{'Group, whose members have repository admin permissions in OPMS.'} =
        '';
    $Self->{Translation}->{'Group, whose members will see CI test result information in OPMS screens.'} =
        '';
    $Self->{Translation}->{'Groups an authenticated user (by user login and password) must be member of to build test packages via the public interface.'} =
        '';
    $Self->{Translation}->{'Groups which will be set during git project creation processes while adding OPMS repositories.'} =
        '';
    $Self->{Translation}->{'Manage dynamic field in screens.'} = '';
    $Self->{Translation}->{'Manage your public SSH key(s) for Git access here. Make sure to save this preference when you add a new key.'} =
        '';
    $Self->{Translation}->{'Module to generate statistics about the added code lines.'} = '';
    $Self->{Translation}->{'Module to generate statistics about the growth of code.'} = '';
    $Self->{Translation}->{'Module to generate statistics about the number of git commits.'} =
        '';
    $Self->{Translation}->{'Module to generate statistics about the removed code lines.'} = '';
    $Self->{Translation}->{'OPMS'} = '';
    $Self->{Translation}->{'Only users who have rw permissions in one of these groups may access git.'} =
        '';
    $Self->{Translation}->{'Option to set a package compatibility manually.'} = '';
    $Self->{Translation}->{'Parameters for the pages in the BranchView screen.'} = '';
    $Self->{Translation}->{'Pre-Definition of the \'GITProjectName\' Dynamic Field: Group => Group with access to the Dynamic Fields; AlwaysVisible => Field can be removed (0|1); InformationAreaName => Name of the Widgets; InformationAreaSize => Size and position of the widgets (Large|Small); Name => Name of the Dynamic Field which should be used; Priority => Order of the Dynamic Fields; State => State of the Fields (0 = disabled, 1 = active, 2 = mandatory), FilterRepository => Regex which the repository name has to match to be displayed, FilterPackage => Regex which the package name has to match to be displayed, FilterBranch => Regex which the branch name has to match to be displayed, FilterRelease => Regex which the repelase version string has to match to be displayed.'} =
        '';
    $Self->{Translation}->{'Pre-Definition of the \'GITRepositoryName\' Dynamic Field: Group => Group with access to the Dynamic Fields; AlwaysVisible => Field can be removed (0|1); InformationAreaName => Name of the Widgets; InformationAreaSize => Size and position of the widgets (Large|Small); Name => Name of the Dynamic Field which should be used; Priority => Order of the Dynamic Fields; State => State of the Fields (0 = disabled, 1 = active, 2 = mandatory), FilterRepository => Regex which the repository name has to match to be displayed, FilterPackage => Regex which the package name has to match to be displayed, FilterBranch => Regex which the branch name has to match to be displayed, FilterRelease => Regex which the repelase version string has to match to be displayed.'} =
        '';
    $Self->{Translation}->{'Pre-Definition of the \'PackageDeprecated\' Dynamic Field: Group => Group with access to the Dynamic Fields; AlwaysVisible => Field can be removed (0|1); InformationAreaName => Name of the Widgets; InformationAreaSize => Size and position of the widgets (Large|Small); Name => Name of the Dynamic Field which should be used; Priority => Order of the Dynamic Fields; State => State of the Fields (0 = disabled, 1 = active, 2 = mandatory), FilterRepository => Regex which the repository name has to match to be displayed, FilterPackage => Regex which the package name has to match to be displayed, FilterBranch => Regex which the branch name has to match to be displayed, FilterRelease => Regex which the repelase version string has to match to be displayed.'} =
        '';
    $Self->{Translation}->{'Recipients that will be informed by email in case of errors.'} =
        '';
    $Self->{Translation}->{'SSH Keys for Git Access'} = '';
    $Self->{Translation}->{'Send analysis file'} = '';
    $Self->{Translation}->{'Sets the git clone address to be used in repository listings.'} =
        '';
    $Self->{Translation}->{'Sets the home directory for git repositories.'} = '';
    $Self->{Translation}->{'Sets the path for the BugzillaAddComment post receive script location.'} =
        '';
    $Self->{Translation}->{'Sets the path for the OTRSCodePolicy  script location. It is recommended to have a separate clone of the OTRSCodePolicy module that is updated via cron.'} =
        '';
    $Self->{Translation}->{'Sets the path for the OTRSCodePolicy pre receive script location. It is recommended to have a separate clone of the OTRSCodePolicy module that is updated via cron.'} =
        '';
    $Self->{Translation}->{'Show latest commits in git repositories.'} = '';
    $Self->{Translation}->{'Shows a link in the menu to go create a unit test from the current ticket.'} =
        '';
    $Self->{Translation}->{'Synchronize OPMS tables with a remote database.'} = '';
    $Self->{Translation}->{'The minimum version of the sphinx library.'} = '';
    $Self->{Translation}->{'The name of the sphinx theme to be used.'} = '';
    $Self->{Translation}->{'The path to the OTRS CSS file (relative below the static path).'} =
        '';
    $Self->{Translation}->{'The path to the OTRS logo (relative below the static path).'} = '';
    $Self->{Translation}->{'The path to the static folder, containing images and css files.'} =
        '';
    $Self->{Translation}->{'The path to the theme folder, containing the sphinx themes.'} = '';
    $Self->{Translation}->{'This configuration defines all possible screens to enable or disable default columns.'} =
        '';
    $Self->{Translation}->{'This configuration defines all possible screens to enable or disable dynamic fields.'} =
        '';
    $Self->{Translation}->{'This configuration defines if only valids or all (invalids) dynamic fields should be shown.'} =
        '';
    $Self->{Translation}->{'This configuration defines if the OTRS package verification should be active or disabled. If disabled all packages are shown as verified. It\'s still recommended to use only verified packages.'} =
        '';
    $Self->{Translation}->{'This configuration defines the URL to the OTRS CloudService Proxy service. The http or https prefix will be added, depending on selection SysConfig \'Znuny4OTRSRepoType\'.'} =
        '';
    $Self->{Translation}->{'This configuration registers a Output post-filter to extend package verification.'} =
        '';
    $Self->{Translation}->{'This configuration registers an OutputFilter module that removes OTRS Business Solution TM advertisements.'} =
        '';
    $Self->{Translation}->{'This configuration registers an output filter to hide online repository selection in package manager.'} =
        '';
    $Self->{Translation}->{'Tidy unprocessed release that not passed test pomules checks for a long time.'} =
        '';
    $Self->{Translation}->{'Users who have rw permissions in one of these groups are permitted to execute force pushes \'git push --force\'.'} =
        '';
    $Self->{Translation}->{'Users who have rw permissions in one of these groups are permitted to manage projects. Additionally the members have administration permissions to the git management.'} =
        '';


    push @{ $Self->{JavaScriptStrings} // [] }, (
    'No',
    'Ok',
    'Please enter at least one search value or * to find anything.',
    'Settings',
    'Submit',
    'Yes',
    );

}

1;

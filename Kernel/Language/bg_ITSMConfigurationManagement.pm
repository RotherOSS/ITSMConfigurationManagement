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

package Kernel::Language::bg_ITSMConfigurationManagement;

use strict;
use warnings;
use utf8;

sub Data {
    my $Self = shift;

    # Template: AdminITSMConfigItem
    $Self->{Translation}->{'Config Item Management'} = 'Управление на конфигурационните единици CI';
    $Self->{Translation}->{'Change class definition'} = 'Промяна на дефиницията на класа';
    $Self->{Translation}->{'Config Item Class'} = 'Клас на конфигурационен елемент';
    $Self->{Translation}->{'Definition'} = 'Описание';
    $Self->{Translation}->{'Change'} = 'Промяна';

    # Template: AgentDashboardITSMConfigItemGeneric
    $Self->{Translation}->{'Incident State'} = 'Състояние на инцидента';
    $Self->{Translation}->{'Deployment State'} = 'Състояние на използване';
    $Self->{Translation}->{'Class'} = 'Клас';
    $Self->{Translation}->{'Deployment State Type'} = 'Тип състояние на използване';
    $Self->{Translation}->{'Current Incident State'} = 'Текущо състояние на инцидента';
    $Self->{Translation}->{'Current Incident State Type'} = 'Текущ тип състояние на инцидент';
    $Self->{Translation}->{'Last changed'} = 'Последна промяна';

    # Template: AgentITSMConfigItemAdd
    $Self->{Translation}->{'Config Item'} = 'Конфигурационен елемент';
    $Self->{Translation}->{'Filter for Classes'} = 'Филтър за класове';
    $Self->{Translation}->{'Select a Class from the list to create a new Config Item.'} = 'Изберете клас от списъка, за да създадете нов конфигурационен елемент.';

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

    # Template: AgentITSMConfigItemHistory
    $Self->{Translation}->{'History of Config Item: %s'} = 'История на Конфигурационен елемент: %s';
    $Self->{Translation}->{'History Content'} = 'Съдържание на историята';
    $Self->{Translation}->{'Createtime'} = 'Време на създаване';
    $Self->{Translation}->{'Zoom view'} = 'Увеличен изглед';

    # Template: AgentITSMConfigItemOverviewNavBar
    $Self->{Translation}->{'Context Settings'} = 'Настройки на контекста';
    $Self->{Translation}->{'Config Items per page'} = 'Конфигурационни елементи на страница';

    # Template: AgentITSMConfigItemOverviewSmall
    $Self->{Translation}->{'A generic ITSM Configuration Item table'} = 'Обща ITSM таблица с конфигурационни елементи';

    # Template: AgentITSMConfigItemSearch
    $Self->{Translation}->{'Run Search'} = 'Стартирайте Търсене';
    $Self->{Translation}->{'Also search in previous versions?'} = 'Да търси и в предишните версии?';

    # Template: AgentITSMConfigItemZoom
    $Self->{Translation}->{'Configuration Item'} = 'Конфигурационен елемент';
    $Self->{Translation}->{'Configuration Item Information'} = 'Информация за конфигурационен елемент';
    $Self->{Translation}->{'Current Deployment State'} = 'Текущо състояние на използване';
    $Self->{Translation}->{'Last changed by'} = 'Последно променен от';
    $Self->{Translation}->{'Show one version'} = 'Покажи една версия';
    $Self->{Translation}->{'Show all versions'} = 'Покажи всички версии';
    $Self->{Translation}->{'Version Incident State'} = 'Състояние на инцидент версията';
    $Self->{Translation}->{'Version Deployment State'} = 'Състояние на използване версията';
    $Self->{Translation}->{'Version Number'} = 'Номер на версията';
    $Self->{Translation}->{'Configuration Item Version Details'} = 'Подробности за версията на конфигурационен елемент';
    $Self->{Translation}->{'Property'} = 'Свойство';

    # Perl Module: Kernel/Modules/AgentITSMConfigItem.pm
    $Self->{Translation}->{'No access to Class is given!'} = 'Няма достъп до класа!';
    $Self->{Translation}->{'Overview: ITSM ConfigItem'} = 'Преглед: ITSM конфигурационен елемент';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemBulk.pm
    $Self->{Translation}->{'No ConfigItemID is given!'} = 'Не е даден ID на конфигурационен елемент!';
    $Self->{Translation}->{'You need at least one selected Configuration Item!'} = 'Имате нужда от поне един избран конфигурационен елемент!';
    $Self->{Translation}->{'You don\'t have write access to this configuration item: %s.'} =
        'Нямате достъп за запис до този конфигурационен елемент: %s.';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemDelete.pm
    $Self->{Translation}->{'Config item "%s" not found in database!'} = 'Конфигурационният елемент "%s" не е намерен в базата данни!';
    $Self->{Translation}->{'Was not able to delete the configitem ID %s!'} = 'Не можах да изтрия ID на конфигурационния елемент %s!';
    $Self->{Translation}->{'No version found for ConfigItemID %s!'} = 'Не е намерена версия за ID на конфигурационен елемент %s!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemEdit.pm
    $Self->{Translation}->{'No ConfigItemID, DuplicateID or ClassID is given!'} = 'Не е даден идентификатор на конфигурационен елемент, дублиран идентификатор или идентификатор на клас!';
    $Self->{Translation}->{'No access is given!'} = 'Няма достъп!';
    $Self->{Translation}->{'No definition was defined for class %s!'} = 'Не е дефинирана дефиниция за клас %s!';

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

    # Perl Module: Kernel/Modules/AgentITSMConfigItemPrint.pm
    $Self->{Translation}->{'No ConfigItemID or VersionID is given!'} = 'Не е даден ID на конфигурационен елемент или ID на версия!';
    $Self->{Translation}->{'Can\'t show config item, no access rights given!'} = 'Не може да се покаже конфигурационен елемент, не са дадени права за достъп!';
    $Self->{Translation}->{'ConfigItemID %s not found in database!'} = 'ID на конфигурационен елемент %s не е намерен в базата данни!';
    $Self->{Translation}->{'VersionID %s not found in database!'} = 'ID на версията %s не е намерен в базата данни!';
    $Self->{Translation}->{'ConfigItem'} = 'Конфигурационен елемент';
    $Self->{Translation}->{'printed by %s at %s'} = 'отпечатано от %s в %s';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemSearch.pm
    $Self->{Translation}->{'Invalid ClassID!'} = 'Невалиден идентификатор на клас!';
    $Self->{Translation}->{'No ClassID is given!'} = 'Не е даден идентификатор на клас!';
    $Self->{Translation}->{'No access rights for this class given!'} = 'Няма дадени права за достъп за този клас!';
    $Self->{Translation}->{'No Result!'} = 'Без резултат!';
    $Self->{Translation}->{'Config Item Search Results'} = 'Резултати от търсенето на конфигурационен елемент';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemZoom.pm
    $Self->{Translation}->{'Can\'t show item, no access rights for ConfigItem are given!'} =
        'Не може да се покаже елемент, не са дадени права за достъп за конфигурационен елемент!';
    $Self->{Translation}->{'operational'} = 'оперативен';
    $Self->{Translation}->{'warning'} = 'внимание';
    $Self->{Translation}->{'incident'} = 'инцидент';
    $Self->{Translation}->{'The deployment state of this config item'} = 'Състоянието за използване на този конфигурационен елемент';
    $Self->{Translation}->{'The incident state of this config item'} = 'Състояние на инцидента за този конфигурационен елемент';

    # Perl Module: Kernel/Output/HTML/Dashboard/ITSMConfigItemGeneric.pm
    $Self->{Translation}->{'Shown config items'} = 'Показани конфигурационни елементи';

    # Perl Module: Kernel/Output/HTML/ITSMConfigItem/LayoutDate.pm
    $Self->{Translation}->{'Between'} = 'Между';

    # Perl Module: Kernel/System/ImportExport/ObjectBackend/ITSMConfigItem.pm
    $Self->{Translation}->{'Maximum number of one element'} = 'Максимален брой на един елемент';
    $Self->{Translation}->{'Empty fields indicate that the current values are kept'} = 'Празните полета показват, че текущите стойности се запазват';
    $Self->{Translation}->{'Skipped'} = 'Пропуснато';

    # Perl Module: var/packagesetup/ITSMConfigurationManagement.pm
    $Self->{Translation}->{'Model'} = 'Модел';
    $Self->{Translation}->{'Customer Company'} = 'Фирма клиент';
    $Self->{Translation}->{'Serial Number'} = 'Сериен Номер';
    $Self->{Translation}->{'CPU'} = 'Процесор';
    $Self->{Translation}->{'Ram'} = 'Памет';
    $Self->{Translation}->{'Hard Disk'} = 'Твърд диск';
    $Self->{Translation}->{'Capacity'} = 'Капацитет';
    $Self->{Translation}->{'Network Adapter'} = 'Мрежов адаптер';
    $Self->{Translation}->{'IP over DHCP'} = 'IP от DHCP';
    $Self->{Translation}->{'IP Address'} = 'IP адрес';
    $Self->{Translation}->{'Graphic Adapter'} = 'Графична карта';
    $Self->{Translation}->{'Other Equipment'} = 'Друго оборудване';
    $Self->{Translation}->{'Warranty Expiration Date'} = 'Дата на изтичане на гаранцията';
    $Self->{Translation}->{'Install Date'} = 'Дата на инсталация';
    $Self->{Translation}->{'Phone 1'} = 'Телефон 1';
    $Self->{Translation}->{'Phone 2'} = 'Телефон 2';
    $Self->{Translation}->{'E-Mail'} = 'Е-поща';
    $Self->{Translation}->{'Network Address'} = 'Мрежов адрес';
    $Self->{Translation}->{'Subnet Mask'} = 'Маска на подмрежата';
    $Self->{Translation}->{'Gateway'} = 'Гейт преход';
    $Self->{Translation}->{'Licence Type'} = 'Тип на лиценза';
    $Self->{Translation}->{'Licence Key'} = 'Лицензен ключ';
    $Self->{Translation}->{'Quantity'} = 'Количество';
    $Self->{Translation}->{'Expiration Date'} = 'Дата на изтичане';
    $Self->{Translation}->{'Media'} = 'Медия';

    # Database XML / SOPM Definition: ITSMConfigurationManagement.sopm
    $Self->{Translation}->{'Computer'} = 'Компютър';
    $Self->{Translation}->{'Hardware'} = 'Хардуер';
    $Self->{Translation}->{'Network'} = 'Мрежа';
    $Self->{Translation}->{'Software'} = 'Софтуер';
    $Self->{Translation}->{'Expired'} = 'Изтекли';
    $Self->{Translation}->{'Maintenance'} = 'Поддръжка';
    $Self->{Translation}->{'Pilot'} = 'Пилот-водач';
    $Self->{Translation}->{'Planned'} = 'Планиран';
    $Self->{Translation}->{'Repair'} = 'Ремонт/Възстановяване';
    $Self->{Translation}->{'Retired'} = 'Излязъл от употреба';
    $Self->{Translation}->{'Review'} = 'Преглеждан';
    $Self->{Translation}->{'Test/QA'} = 'Тест/Качествен контрол';
    $Self->{Translation}->{'Laptop'} = 'Преносим';
    $Self->{Translation}->{'Desktop'} = 'Настолен';
    $Self->{Translation}->{'PDA'} = 'PDA';
    $Self->{Translation}->{'Other'} = 'Други';
    $Self->{Translation}->{'Monitor'} = 'Монитор';
    $Self->{Translation}->{'Printer'} = 'Принтер';
    $Self->{Translation}->{'Switch'} = 'Концентратор';
    $Self->{Translation}->{'Router'} = 'Рутер';
    $Self->{Translation}->{'WLAN Access Point'} = 'WLAN точка за достъп';
    $Self->{Translation}->{'Security Device'} = 'У-во за сигурност';
    $Self->{Translation}->{'Backup Device'} = 'Архивиращо у-во';
    $Self->{Translation}->{'Mouse'} = 'Мишка';
    $Self->{Translation}->{'Keyboard'} = 'Клавиатура';
    $Self->{Translation}->{'Camera'} = 'Камера';
    $Self->{Translation}->{'Beamer'} = 'Бимер';
    $Self->{Translation}->{'Modem'} = 'Модем';
    $Self->{Translation}->{'PCMCIA Card'} = 'PCMCIA карта';
    $Self->{Translation}->{'USB Device'} = 'USB Устройство';
    $Self->{Translation}->{'Docking Station'} = 'Докинг станция';
    $Self->{Translation}->{'Scanner'} = 'Скенер';
    $Self->{Translation}->{'Building'} = 'Сграда';
    $Self->{Translation}->{'Office'} = 'Офис';
    $Self->{Translation}->{'Floor'} = 'Етаж';
    $Self->{Translation}->{'Room'} = 'Стая';
    $Self->{Translation}->{'Rack'} = 'Стойка';
    $Self->{Translation}->{'Workplace'} = 'Работно място';
    $Self->{Translation}->{'Outlet'} = 'Розетка';
    $Self->{Translation}->{'IT Facility'} = 'ИТ съоръжение';
    $Self->{Translation}->{'LAN'} = 'LAN';
    $Self->{Translation}->{'WLAN'} = 'WLAN';
    $Self->{Translation}->{'Telco'} = 'Telco';
    $Self->{Translation}->{'GSM'} = 'GSM';
    $Self->{Translation}->{'Client Application'} = 'Потребителски приложения';
    $Self->{Translation}->{'Middleware'} = 'Средно ниво';
    $Self->{Translation}->{'Server Application'} = 'Сървърно приложение';
    $Self->{Translation}->{'Client OS'} = 'Потребителска Опер.с-ма';
    $Self->{Translation}->{'Server OS'} = 'сървърна Опер.с-ма';
    $Self->{Translation}->{'Admin Tool'} = 'Административнен инструмент';
    $Self->{Translation}->{'User Tool'} = 'Клиентски инструмент';
    $Self->{Translation}->{'Embedded'} = 'Вградена';
    $Self->{Translation}->{'Single Licence'} = 'Единичен лиценз';
    $Self->{Translation}->{'Per User'} = 'Лицензиране за потребител';
    $Self->{Translation}->{'Per Processor'} = 'Лицензиране за процесор';
    $Self->{Translation}->{'Per Server'} = 'Лицензиране за сървър';
    $Self->{Translation}->{'Per Node'} = 'Лицензиране на точка';
    $Self->{Translation}->{'Volume Licence'} = 'Специални обемни програми';
    $Self->{Translation}->{'Enterprise Licence'} = 'Ентърпрайс лиценз';
    $Self->{Translation}->{'Developer Licence'} = 'Лиценз за разработчици';
    $Self->{Translation}->{'Demo'} = 'Демо';
    $Self->{Translation}->{'Time Restricted'} = 'Лиценз, ограничен по време';
    $Self->{Translation}->{'Freeware'} = 'Безплатно разпространяван';
    $Self->{Translation}->{'Open Source'} = 'Софтуер с отворен код';
    $Self->{Translation}->{'Unlimited'} = 'Неограничен лиценз';

    # JS File: ITSM.Agent.ConfigItem.Zoom
    $Self->{Translation}->{'Ok'} = 'Да';

    # SysConfig
    $Self->{Translation}->{'Assigned CIs'} = 'Зачислени KE';
    $Self->{Translation}->{'CIs assigned to customer company'} = 'KE зачислени на компанията клиент';
    $Self->{Translation}->{'CIs assigned to customer user'} = 'КЕ, зачислени на потребител';
    $Self->{Translation}->{'CMDB Settings'} = 'Настройка на CMDB';
    $Self->{Translation}->{'Check for a unique name only within the same ConfigItem class (\'class\') or globally (\'global\'), which means every existing ConfigItem is taken into account when looking for duplicates.'} =
        'Проверявайте за уникално име само в рамките на един и същ клас на конфигурационен елемент („клас“) или глобално („глобален“), което означава, че всеки съществуващ конфигурационен елемент се взема предвид, когато се търсят дубликати.';
    $Self->{Translation}->{'Config Items'} = 'Конфигурационни елементи';
    $Self->{Translation}->{'Config item add.'} = 'Добавяне на конфигурационен елемент.';
    $Self->{Translation}->{'Config item edit.'} = 'Редактиране на конфигурационен елемент.';
    $Self->{Translation}->{'Config item event module that enables logging to history in the agent interface.'} =
        'Модул за събитие за конфигуриране на елемент, който позволява записване в хронология в интерфейса на агента.';
    $Self->{Translation}->{'Config item history.'} = 'Конфигурирайте хронологията на елементите.';
    $Self->{Translation}->{'Config item print.'} = 'Печат на конфигурационен елемент.';
    $Self->{Translation}->{'Config item zoom.'} = 'Конфигуриране на мащаба на елемента.';
    $Self->{Translation}->{'ConfigItemNumber'} = 'Номер на конфигурационен елемент';
    $Self->{Translation}->{'ConfigItems of the following classes will not be stored on the Elasticsearch server. To apply this to existing CIs, the CI migration has to be run via console, after changing this option.'} =
        '';
    $Self->{Translation}->{'ConfigItems with the following deployment states will not be stored on the Elasticsearch server. To apply this to existing CIs, the CI migration has to be run via console, after changing this option.'} =
        '';
    $Self->{Translation}->{'Configuration Item Limit'} = 'Лимит за конфигурационен елемент';
    $Self->{Translation}->{'Configuration Item limit per page.'} = 'Лимит за конфигурационен елемент на страница.';
    $Self->{Translation}->{'Configuration Management Database.'} = 'База данни за управление на конфигурацията.';
    $Self->{Translation}->{'Configuration item bulk module.'} = 'Групов модул за конфигурационен елемент.';
    $Self->{Translation}->{'Configuration item search backend router of the agent interface.'} =
        'Модул за търсене на конфигурационен елемент на интерфейса на агента.';
    $Self->{Translation}->{'Create and manage the definitions for Configuration Items.'} = 'Създавайте и управлявайте дефинициите за конфигурационни елементи.';
    $Self->{Translation}->{'Define Actions where a settings button is available in the linked objects widget (LinkObject::ViewMode = "complex"). Please note that these Actions must have registered the following JS and CSS files: Core.AllocationList.css, Core.UI.AllocationList.js, Core.UI.Table.Sort.js, Core.Agent.TableFilters.js and Core.Agent.LinkObject.js.'} =
        'Дефинирайте действия, при които е наличен бутон за настройки в приспособлението за свързани обекти (LinkObject::ViewMode = "complex"). Моля, обърнете внимание, че тези действия трябва да са регистрирали следните JS и CSS файлове: Core.AllocationList.css, Core.UI.AllocationList.js, Core.UI.Table.Sort.js, Core.Agent.TableFilters.js и Core.Agent .LinkObject.js.';
    $Self->{Translation}->{'Defines Required permissions to create ITSM configuration items using the Generic Interface.'} =
        'Дефинира необходимите разрешения за създаване на ITSM конфигурационни елементи с помощта на генеричния интерфейс.';
    $Self->{Translation}->{'Defines Required permissions to delete ITSM configuration items using the Generic Interface.'} =
        'Дефинира необходимите разрешения за изтриване на елементи от конфигурацията на ITSM с помощта на общия интерфейс.';
    $Self->{Translation}->{'Defines Required permissions to get ITSM configuration items using the Generic Interface.'} =
        'Дефинира необходимите разрешения за получаване на ITSM конфигурационни елементи с помощта на общия интерфейс.';
    $Self->{Translation}->{'Defines Required permissions to search ITSM configuration items using the Generic Interface.'} =
        'Дефинира необходимите разрешения за търсене на ITSM конфигурационни елементи с помощта на общия интерфейс.';
    $Self->{Translation}->{'Defines Required permissions to update ITSM configuration items using the Generic Interface.'} =
        'Дефинира необходимите разрешения за актуализиране на ITSM конфигурационни елементи с помощта на общия интерфейс.';
    $Self->{Translation}->{'Defines an overview module to show the small view of a configuration item list.'} =
        'Дефинира модул за преглед, за да покаже малък изглед на списък с конфигурационни елементи.';
    $Self->{Translation}->{'Defines regular expressions individually for each ConfigItem class to check the ConfigItem name and to show corresponding error messages.'} =
        'Дефинира регулярни изрази индивидуално за всеки клас на конфигурационен елемент, за да провери името на конфигурационния елемент и да покаже съответните съобщения за грешка.';
    $Self->{Translation}->{'Defines the default subobject of the class \'ITSMConfigItem\'.'} =
        'Дефинира подобекта по подразбиране на класа „ITSM конфигурационен елемент“.';
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
    $Self->{Translation}->{'Defines the shown columns in the config item overview. This option has no effect on the position of the column. Note: Class column is always available if filter \'All\' is selected.'} =
        'Дефинира показаните колони в общия преглед на конфигурационния елемент. Тази опция няма ефект върху позицията на колоната. Забележка: Колоната за клас е винаги налична, ако е избран филтър „Всички“.';
    $Self->{Translation}->{'Defines the shown columns in the config item search. This option has no effect on the position of the column.'} =
        'Дефинира показаните колони в търсенето на конфигурационен елемент. Тази опция няма ефект върху позицията на колоната.';
    $Self->{Translation}->{'Defines the shown columns of CIs in the config item overview depending on the CI class. Each entry must be prefixed with the class name and double colons (i.e. Computer::). There are a few CI-Attributes that are common to all CIs (example for the class Computer: Computer::Name, Computer::CurDeplState, Computer::CreateTime). To show individual CI-Attributes as defined in the CI-Definition, the following scheme must be used (example for the class Computer): Computer::HardDisk::1, Computer::HardDisk::1::Capacity::1, Computer::HardDisk::2, Computer::HardDisk::2::Capacity::1. If there is no entry for a CI class, then the default columns are shown as defined in the setting ITSMConfigItem::Frontend::AgentITSMConfigItem###ShowColumns.'} =
        'Дефинира показаните колони на КЕ в прегледа на конфигурационния елемент в зависимост от класа на КЕ. Всеки запис трябва да има префикс с името на класа и двойно двоеточие (т.е. компютър ::). Има няколко КЕ-атрибута, които са общи за всички КЕ (пример за класа Computer: Computer::Name, Computer::CurDeplState, Computer::CreateTime). За да се покажат отделни КЕ-атрибути, както са дефинирани в КЕ-дефиницията, трябва да се използва следната схема (пример за класа Computer): Computer::HardDisk::1, Computer::HardDisk::1::Capacity::1, Computer::HardDisk::2, Computer::HardDisk::2::Capacity::1. Ако няма запис за КЕ клас, колоните по подразбиране се показват, както е дефинирано в настройката ITSMConfigItem::Frontend::AgentITSMConfigItem###ShowColumns.';
    $Self->{Translation}->{'Defines the shown columns of CIs in the config item search depending on the CI class. Each entry must be prefixed with the class name and double colons (i.e. Computer::). There are a few CI-Attributes that are common to all CIs (example for the class Computer: Computer::Name, Computer::CurDeplState, Computer::CreateTime). To show individual CI-Attributes as defined in the CI-Definition, the following scheme must be used (example for the class Computer): Computer::HardDisk::1, Computer::HardDisk::1::Capacity::1, Computer::HardDisk::2, Computer::HardDisk::2::Capacity::1. If there is no entry for a CI class, then the default columns are shown as defined in the setting ITSMConfigItem::Frontend::AgentITSMConfigItem###ShowColumns.'} =
        'Дефинира показаните колони на КЕ в търсенето на конфигурационен елемент в зависимост от класа на КЕ. Всеки запис трябва да има префикс с името на класа и двойно двоеточие (т.е. компютър ::). Има няколко КЕ-атрибута, които са общи за всички КЕ (пример за класа Computer: Computer::Name, Computer::CurDeplState, Computer::CreateTime). За да се покажат отделни КЕ-атрибути, както са дефинирани в КЕ-дефиницията, трябва да се използва следната схема (пример за класа Computer): Computer::HardDisk::1, Computer::HardDisk::1::Capacity::1, Computer::HardDisk::2, Computer::HardDisk::2::Capacity::1. Ако няма запис за КЕ клас, колоните по подразбиране се показват, както е дефинирано в настройката ITSMConfigItem::Frontend::AgentITSMConfigItem###ShowColumns.';
    $Self->{Translation}->{'Defines the shown columns of CIs in the config item widget depending on the CI class. Each entry must be prefixed with the class name and double colons (i.e. Computer::). There are a few CI-Attributes that are common to all CIs (example for the class Computer: Computer::Name, Computer::CurDeplState, Computer::CreateTime). To show individual CI-Attributes as defined in the CI-Definition, the following scheme must be used (example for the class Computer): Computer::HardDisk::1, Computer::HardDisk::1::Capacity::1, Computer::HardDisk::2, Computer::HardDisk::2::Capacity::1. If there is no entry for a CI class, then the default columns are shown as defined in the setting AgentCustomerInformationCenter::Backend###0060-CIC-ITSMConfigItemCustomerCompany (key DefaultColumns).'} =
        'Дефинира показаните колони от КЕ в изпълнимия модул за конфигурационен елемент в зависимост от класа на КЕ. Всеки запис трябва да има префикс с името на класа и двойно двоеточие (т.е. компютър ::). Има няколко КЕ-атрибута, които са общи за всички КЕ (пример за класа Computer: Computer::Name, Computer::CurDeplState, Computer::CreateTime). За да се покажат отделни КЕ-атрибути, както са дефинирани в КЕ-дефиницията, трябва да се използва следната схема (пример за класа Computer): Computer::HardDisk::1, Computer::HardDisk::1::Capacity::1, Computer::HardDisk::2, Computer::HardDisk::2::Capacity::1. Ако няма запис за КЕ клас, тогава колоните по подразбиране се показват, както е дефинирано в настройката AgentCustomerInformationCenter::Backend###0060-CIC-ITSMConfigItemCustomerCompany (ключ DefaultColumns).';
    $Self->{Translation}->{'Defines the shown columns of CIs in the link table complex view for all CI classes. If there is no entry, then the default columns are shown.'} =
        'Дефинира показаните колони от КЕ в комплексния изглед на таблицата за връзки за всички класове КЕ. Ако няма запис, се показват колоните по подразбиране.';
    $Self->{Translation}->{'Defines the shown columns of CIs in the link table complex view, depending on the CI class. Each entry must be prefixed with the class name and double colons (i.e. Computer::). There are a few CI-Attributes that common to all CIs (example for the class Computer: Computer::Name, Computer::CurDeplState, Computer::CreateTime). To show individual CI-Attributes as defined in the CI-Definition, the following scheme must be used (example for the class Computer): Computer::HardDisk::1, Computer::HardDisk::1::Capacity::1, Computer::HardDisk::2, Computer::HardDisk::2::Capacity::1. If there is no entry for a CI class, then the default columns are shown.'} =
        'Дефинира показаните колони от КЕ в сложния изглед на таблицата с връзки, в зависимост от класа на КЕ. Всеки запис трябва да има префикс с името на класа и двойно двоеточие (т.е. компютър ::). Има няколко КЕ-атрибута, които са общи за всички КЕ (пример за класа Computer: Computer::Name, Computer::CurDeplState, Computer::CreateTime). За да се покажат отделни КЕ-атрибути, както са дефинирани в КЕ-дефиницията, трябва да се използва следната схема (пример за класа Computer): Computer::HardDisk::1, Computer::HardDisk::1::Capacity::1, Computer::HardDisk::2, Computer::HardDisk::2::Capacity::1. Ако няма запис за КЕ клас, тогава се показват колоните по подразбиране.';
    $Self->{Translation}->{'Defines which type of link (named from the ticket perspective) can affect the status of a linked CI.'} =
        'Определя кой тип връзка (назован от гледна точка на билета) може да повлияе на състоянието на свързан КЕ.';
    $Self->{Translation}->{'Defines which type of ticket can affect the status of a linked CI.'} =
        'Определя кой тип билет може да повлияе на състоянието на свързан КЕ.';
    $Self->{Translation}->{'Delete Configuration Item'} = 'Изтриване на елемент от конфигурацията';
    $Self->{Translation}->{'Deployment State Color'} = 'Цвят за състоянието на използване';
    $Self->{Translation}->{'Duplicate'} = 'Направи копие';
    $Self->{Translation}->{'Enables configuration item bulk action feature for the agent frontend to work on more than one configuration item at a time.'} =
        'Разрешава функцията за групово действие на конфигурационен елемент за интерфейса на агента да работи върху повече от един конфигурационен елемент наведнъж.';
    $Self->{Translation}->{'Enables configuration item bulk action feature only for the listed groups.'} =
        'Активира функцията за групово действие на конфигурационен елемент само за изброените групи.';
    $Self->{Translation}->{'Enables/disables the functionality to check ConfigItems for unique names. Before enabling this option you should check your system for already existing config items with duplicate names. You can do this with the script bin/otobo.ITSMConfigItemListDuplicates.pl.'} =
        'Активира/деактивира функционалността за проверка на ConfigItems за уникални имена. Преди да активирате тази опция, трябва да проверите системата си за вече съществуващи конфигурационни елементи с дублирани имена. Можете да направите това със скрипта bin/otobo.ITSMConfigItemListDuplicates.pl.';
    $Self->{Translation}->{'Event module to set configitem-status on ticket-configitem-link.'} =
        'Модул на събитие за задаване за състояние на конфигурационен елемент за връзка за билет-конфигурационен елемент.';
    $Self->{Translation}->{'Fields of the configuration item index, used for the fulltext search. Fields are also stored, but are not mandatory for the overall functionality. Inclusion of attachments can be disabled by setting the entry to 0 or deleting it.'} =
        '';
    $Self->{Translation}->{'Fields stored in the configuration item index which are used for other things besides fulltext searches. For the complete functionality all fields are mandatory.'} =
        '';
    $Self->{Translation}->{'ITSM config item overview.'} = 'Преглед на ITSM конфигурационен елемент.';
    $Self->{Translation}->{'Module to check the group responsible for a class.'} = 'Модул за проверка на групата, отговаряща за даден клас.';
    $Self->{Translation}->{'Module to check the group responsible for a configuration item.'} =
        'Модул за проверка на групата, отговорна за конфигурационен елемент.';
    $Self->{Translation}->{'Module to generate ITSM config item statistics.'} = 'Модул за генериране на статистически данни за ITSM конфигурационен елемент.';
    $Self->{Translation}->{'Object backend module registration for the import/export module.'} =
        'Регистрация на модула за бекенд на обект за модула за импортиране/експортиране.';
    $Self->{Translation}->{'Objects to search for, how many entries and which attributs to show. ConfigItem attributes have to explicitly be stored via Elasticsearch.'} =
        '';
    $Self->{Translation}->{'Overview.'} = 'Преглед.';
    $Self->{Translation}->{'Parameters for the dashboard backend of the customer company config item overview of the agent interface . "Limit" is the number of entries shown by default. "Group" is used to restrict the access to the plugin (e. g. Group: admin;group1;group2;). "Default" determines if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" is the cache time in minutes for the plugin.'} =
        'Параметри за задната част на таблото за управление на клиентската компания конфигурационен елемент преглед на интерфейса на агента. „Ограничение“ е броят на записите, показан по подразбиране. „Група“ се използва за ограничаване на достъпа до плъгина (напр. Група: admin;group1;group2;). „По подразбиране“ определя дали приставката е активирана по подразбиране или потребителят трябва да я активира ръчно. „CacheTTLLocal“ е времето за кеширане в минути за плъгина.';
    $Self->{Translation}->{'Parameters for the deployment states color in the preferences view of the agent interface.'} =
        'Параметрите за състоянието на използване се оцветяват в изгледа с предпочитания от интерфейса на агента.';
    $Self->{Translation}->{'Parameters for the deployment states in the preferences view of the agent interface.'} =
        'Параметри за състоянията на използване в изгледа с предпочитания от интерфейса на агента.';
    $Self->{Translation}->{'Parameters for the example permission groups of the general catalog attributes.'} =
        'Параметри за примерните разрешителни групи от атрибутите на общия каталог.';
    $Self->{Translation}->{'Parameters for the pages (in which the configuration items are shown).'} =
        'Параметри за страниците (в които се показват конфигурационните елементи).';
    $Self->{Translation}->{'Performs the configured action for each event (as an Invoker) for each configured Webservice.'} =
        '';
    $Self->{Translation}->{'Permission Group'} = 'Група разрешения';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item screen in the agent interface.'} =
        'Необходими права за използване на екрана за ITSM конфигурационен елемент в интерфейса на агента.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item search screen in the agent interface.'} =
        'Необходими права за използване на екрана за търсене на ITSM конфигурационен елемент в интерфейса на агента.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item zoom screen in the agent interface.'} =
        'Необходими права за използване на екрана за мащабиране на ITSM конфигурационен елемент в интерфейса на агента.';
    $Self->{Translation}->{'Required permissions to use the add ITSM configuration item screen in the agent interface.'} =
        'Необходими права за използване на екрана за добавяне на ITSM конфигурационен елемент в интерфейса на агента.';
    $Self->{Translation}->{'Required permissions to use the edit ITSM configuration item screen in the agent interface.'} =
        'Необходими права за използване на екрана за редактиране на ITSM конфигурационен елемент в интерфейса на агента.';
    $Self->{Translation}->{'Required permissions to use the history ITSM configuration item screen in the agent interface.'} =
        'Необходими права за използване на екрана за хронологията на ITSM конфигурационния елемент в интерфейса на агента.';
    $Self->{Translation}->{'Required permissions to use the print ITSM configuration item screen in the agent interface.'} =
        'Необходими права за използване на екрана за печат на ITSM конфигурационен елемент в интерфейса на агента.';
    $Self->{Translation}->{'Required privileges to delete config items.'} = 'Необходими права за изтриване на елементи от конфигурацията.';
    $Self->{Translation}->{'Search config items.'} = 'Търсене на конфигурационни елементи.';
    $Self->{Translation}->{'Selects the configuration item number generator module. "AutoIncrement" increments the configuration item number, the SystemID, the ConfigItemClassID and the counter are used. The format is "SystemID.ConfigItemClassID.Counter", e.g. 1205000004, 1205000005.'} =
        'Избира модула за генериране на номера на конфигурационни елементи. „AutoIncrement“ увеличава номера на конфигурационния елемент, използва се SystemID, ConfigItemClassID и брояча. Форматът е "SystemID.ConfigItemClassID.Counter", напр. 1205000004, 1205000005.';
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
    $Self->{Translation}->{'The identifier for a configuration item, e.g. ConfigItem#, MyConfigItem#. The default is ConfigItem#.'} =
        'Идентификаторът за конфигурационен елемент, напр. ConfigItem#, MyConfigItem#. По подразбиране е ConfigItem#.';
    $Self->{Translation}->{'class'} = 'клас';
    $Self->{Translation}->{'global'} = 'глобален';
    $Self->{Translation}->{'postproductive'} = 'постпродуктивен';
    $Self->{Translation}->{'preproductive'} = 'препродуктивен';
    $Self->{Translation}->{'productive'} = 'продуктивен';


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

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

    # Database XML Definition: ITSMConfigurationManagement.sopm
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
    $Self->{Translation}->{'Server'} = 'Сървър';
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

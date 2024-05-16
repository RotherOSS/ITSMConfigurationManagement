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

package Kernel::Language::sr_Cyrl_ITSMConfigurationManagement;

use strict;
use warnings;
use utf8;

sub Data {
    my $Self = shift;

    # Template: AdminITSMConfigItem
    $Self->{Translation}->{'Config Item Management'} = 'Управљање конфигурационим ставкама';
    $Self->{Translation}->{'Change class definition'} = 'Дефиниција класе промене';
    $Self->{Translation}->{'Config Item Class'} = 'Класа конфигурационе ставке';
    $Self->{Translation}->{'Definition'} = 'Дефиниција';
    $Self->{Translation}->{'Change'} = 'Промени';

    # Template: AgentDashboardITSMConfigItemGeneric
    $Self->{Translation}->{'Incident State'} = 'Стање инцидента';
    $Self->{Translation}->{'Deployment State'} = 'Статус распоређивања';
    $Self->{Translation}->{'Class'} = 'Класа';
    $Self->{Translation}->{'Deployment State Type'} = 'Тип статуса распоређивања';
    $Self->{Translation}->{'Current Incident State'} = 'Тренутно стање инцидента';
    $Self->{Translation}->{'Current Incident State Type'} = 'Тип тренутног статуса инцидента';
    $Self->{Translation}->{'Last changed'} = 'Задњи пут промењено';

    # Template: AgentITSMConfigItemAdd
    $Self->{Translation}->{'Config Item'} = 'Конфигурациона ставка';
    $Self->{Translation}->{'Filter for Classes'} = 'Филтер за класе';
    $Self->{Translation}->{'Select a Class from the list to create a new Config Item.'} = 'Изаберите класу из листе ради креирања нове конфигурационе ставке.';

    # Template: AgentITSMConfigItemBulk
    $Self->{Translation}->{'ITSM ConfigItem Bulk Action'} = 'ITSM масовна акција на тикету';
    $Self->{Translation}->{'Deployment state'} = 'Статус распоређивања';
    $Self->{Translation}->{'Incident state'} = 'Стање инцидента';
    $Self->{Translation}->{'Link to another'} = 'Повежи са другим';
    $Self->{Translation}->{'Invalid Configuration Item number!'} = 'Неисправан број конфигурационе ставке!';
    $Self->{Translation}->{'The number of another Configuration Item to link with.'} = 'Број друге конфигурационе ставке за повезивање.';

    # Template: AgentITSMConfigItemDelete
    $Self->{Translation}->{'Do you really want to delete this config item?'} = 'Да ли стварно желите да обришете ову конфигурациону ставку?';

    # Template: AgentITSMConfigItemEdit
    $Self->{Translation}->{'The name of this config item'} = 'Назив ове конфигурационе ставке';
    $Self->{Translation}->{'Name is already in use by the ConfigItems with the following Number(s): %s'} =
        'Назив је већ у употреби на конфигурационим ставкама број: %s';

    # Template: AgentITSMConfigItemHistory
    $Self->{Translation}->{'History of Config Item: %s'} = 'Историјат конфигурационе ставке: %s';
    $Self->{Translation}->{'History Content'} = 'Садржај историје';
    $Self->{Translation}->{'Createtime'} = 'Време креирања';
    $Self->{Translation}->{'Zoom view'} = 'Увећани преглед';

    # Template: AgentITSMConfigItemOverviewNavBar
    $Self->{Translation}->{'Context Settings'} = 'Подешавање контекста';
    $Self->{Translation}->{'Config Items per page'} = 'Конфигурационе ставке по страни';

    # Template: AgentITSMConfigItemOverviewSmall
    $Self->{Translation}->{'A generic ITSM Configuration Item table'} = 'Генеричка табела ITSM конфигурационе ставке';

    # Template: AgentITSMConfigItemSearch
    $Self->{Translation}->{'Run Search'} = 'Покрени претрагу';
    $Self->{Translation}->{'Also search in previous versions?'} = 'Претражите и у претхотним верзијама?';

    # Template: AgentITSMConfigItemZoom
    $Self->{Translation}->{'Configuration Item'} = 'Конфигурациона ставка';
    $Self->{Translation}->{'Configuration Item Information'} = 'Информација о конфигурационој ставки';
    $Self->{Translation}->{'Current Deployment State'} = 'Тренутни статус распоређивања';
    $Self->{Translation}->{'Last changed by'} = 'Променио';
    $Self->{Translation}->{'Show one version'} = 'Прикажи једну верзију';
    $Self->{Translation}->{'Show all versions'} = 'Покажи све верзије';
    $Self->{Translation}->{'Version Incident State'} = 'Верзија - статус инцидента';
    $Self->{Translation}->{'Version Deployment State'} = 'Верзија - статус примене';
    $Self->{Translation}->{'Version Number'} = 'Број верзије';
    $Self->{Translation}->{'Configuration Item Version Details'} = 'Детаљи верзије конфигурационе ставке';
    $Self->{Translation}->{'Property'} = 'Својство';

    # Perl Module: Kernel/Modules/AgentITSMConfigItem.pm
    $Self->{Translation}->{'No access to Class is given!'} = 'Није дат приступ класи!';
    $Self->{Translation}->{'Overview: ITSM ConfigItem'} = 'Преглед: ITSM конфигурационе ставке';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemBulk.pm
    $Self->{Translation}->{'No ConfigItemID is given!'} = 'Није дат ConfigItemID!';
    $Self->{Translation}->{'You need at least one selected Configuration Item!'} = 'Потребна је бар једна изабрана конфигурациона ставка!';
    $Self->{Translation}->{'You don\'t have write access to this configuration item: %s.'} =
        'Немате право уписа за ову конфигурациону ставку: %s.';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemDelete.pm
    $Self->{Translation}->{'Config item "%s" not found in database!'} = 'Конфигурациона ставка "%s" није нађена у бази података!';
    $Self->{Translation}->{'Was not able to delete the configitem ID %s!'} = 'Није било могуће обрисати ConfigItemID %s!';
    $Self->{Translation}->{'No version found for ConfigItemID %s!'} = 'Није пронађена верзија за ConfigItemID %s!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemEdit.pm
    $Self->{Translation}->{'No ConfigItemID, DuplicateID or ClassID is given!'} = 'Нису дати ConfigItemID, DuplicateID или ClassID!';
    $Self->{Translation}->{'No access is given!'} = 'Није дат приступ!';
    $Self->{Translation}->{'No definition was defined for class %s!'} = 'Није пронађена дефиниција за класу %s!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemHistory.pm
    $Self->{Translation}->{'Can\'t show history, no ConfigItemID is given!'} = 'Не може се приказати историјат, јер није дат ConfigItemID!';
    $Self->{Translation}->{'Can\'t show history, no access rights given!'} = 'Не може се приказати историјат, није дозвољен приступ!';
    $Self->{Translation}->{'New ConfigItem (ID=%s)'} = 'Нова конфигурациона ставка (ID=%s)';
    $Self->{Translation}->{'New version (ID=%s)'} = 'Нова верзија (ID=%s)';
    $Self->{Translation}->{'Deployment state updated (new=%s, old=%s)'} = 'Ажурирано стање распореда (ново=%s, старо=%s) ';
    $Self->{Translation}->{'Incident state updated (new=%s, old=%s)'} = 'Ажурирано стање инцидента (ново=%s, старо=%s)';
    $Self->{Translation}->{'ConfigItem (ID=%s) deleted'} = 'Обрисана конфигурациона ставка (ID=%s)';
    $Self->{Translation}->{'Link to %s (type=%s) added'} = 'Повезано са %s (тип=%s)';
    $Self->{Translation}->{'Link to %s (type=%s) deleted'} = 'Обрисана веза са %s (тип=%s)';
    $Self->{Translation}->{'ConfigItem definition updated (ID=%s)'} = 'Ажурирана дефиниција конфигурационе ставке (ID=%s)';
    $Self->{Translation}->{'Name updated (new=%s, old=%s)'} = 'Ажуриран назив (нови=%s, стари=%s)';
    $Self->{Translation}->{'Attribute %s updated from "%s" to "%s"'} = 'Ажуриран атрибут%s са "%s" на "%s"';
    $Self->{Translation}->{'Version %s deleted'} = 'Верзија %s је обрисана';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemPrint.pm
    $Self->{Translation}->{'No ConfigItemID or VersionID is given!'} = 'Нису дати ConfigItemID или VersionID!';
    $Self->{Translation}->{'Can\'t show config item, no access rights given!'} = 'Не може се приказати конфигурациона ставка, није дат приступ!';
    $Self->{Translation}->{'ConfigItemID %s not found in database!'} = 'ИД конфигурационе ставке %s није нађен у бази података!';
    $Self->{Translation}->{'VersionID %s not found in database!'} = 'Ид верзије %s није нађен у бази података!';
    $Self->{Translation}->{'ConfigItem'} = 'Конфигурациона ставка';
    $Self->{Translation}->{'printed by %s at %s'} = 'штампану од стране %s у %s';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemSearch.pm
    $Self->{Translation}->{'Invalid ClassID!'} = 'Неисправан ИД класе!';
    $Self->{Translation}->{'No ClassID is given!'} = 'Није дат ИД класе!';
    $Self->{Translation}->{'No access rights for this class given!'} = 'Није дат приступ овој класи!';
    $Self->{Translation}->{'No Result!'} = 'Нема резултата!';
    $Self->{Translation}->{'Config Item Search Results'} = 'Резултат претраге конфигурационих ставки';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemZoom.pm
    $Self->{Translation}->{'Can\'t show item, no access rights for ConfigItem are given!'} =
        'Не може се приказати ставка, није дат приступ за ову конфигурациону ставку!';
    $Self->{Translation}->{'operational'} = 'оперативни';
    $Self->{Translation}->{'warning'} = 'упозорење';
    $Self->{Translation}->{'incident'} = 'инцидент';
    $Self->{Translation}->{'The deployment state of this config item'} = 'Статус примене ове конфигурационе ставке';
    $Self->{Translation}->{'The incident state of this config item'} = 'Статус инцидента ове конфигурационе ставке';

    # Perl Module: Kernel/Output/HTML/Dashboard/ITSMConfigItemGeneric.pm
    $Self->{Translation}->{'Shown config items'} = 'Приказане конфигурационе ставке';

    # Perl Module: Kernel/Output/HTML/ITSMConfigItem/LayoutDate.pm
    $Self->{Translation}->{'Between'} = 'Између';

    # Perl Module: Kernel/System/ImportExport/ObjectBackend/ITSMConfigItem.pm
    $Self->{Translation}->{'Maximum number of one element'} = 'Максимални број једног елемента';
    $Self->{Translation}->{'Empty fields indicate that the current values are kept'} = 'Празна поља указују да ће актуелне вредности бити задржане';
    $Self->{Translation}->{'Skipped'} = 'Прескочено';

    # Perl Module: var/packagesetup/ITSMConfigurationManagement.pm
    $Self->{Translation}->{'Model'} = 'Модел';
    $Self->{Translation}->{'Customer Company'} = 'Фирма клијента';
    $Self->{Translation}->{'Serial Number'} = 'Серијски број';
    $Self->{Translation}->{'CPU'} = 'Процесор';
    $Self->{Translation}->{'Ram'} = 'RAM';
    $Self->{Translation}->{'Hard Disk'} = 'Хард диск';
    $Self->{Translation}->{'Capacity'} = 'Капацитет';
    $Self->{Translation}->{'Network Adapter'} = 'Мрежни адаптер';
    $Self->{Translation}->{'IP over DHCP'} = 'IP преко DHCP';
    $Self->{Translation}->{'IP Address'} = 'IP адреса';
    $Self->{Translation}->{'Graphic Adapter'} = 'Графички адаптер';
    $Self->{Translation}->{'Other Equipment'} = 'Друга опрема';
    $Self->{Translation}->{'Warranty Expiration Date'} = 'Датум истицања гаранције';
    $Self->{Translation}->{'Install Date'} = 'Датум инсталације';
    $Self->{Translation}->{'Phone 1'} = 'Телефон 1';
    $Self->{Translation}->{'Phone 2'} = 'Телефон 2';
    $Self->{Translation}->{'E-Mail'} = 'Имејл';
    $Self->{Translation}->{'Network Address'} = 'Мрежна адреса';
    $Self->{Translation}->{'Subnet Mask'} = 'Подмрежна маска';
    $Self->{Translation}->{'Gateway'} = 'Мрежни пролаз';
    $Self->{Translation}->{'Licence Type'} = 'Тип лиценце';
    $Self->{Translation}->{'Licence Key'} = 'Лиценцни кључ';
    $Self->{Translation}->{'Quantity'} = 'Количина';
    $Self->{Translation}->{'Expiration Date'} = 'Датум истицања';
    $Self->{Translation}->{'Media'} = 'Медија';

    # Database XML Definition: ITSMConfigurationManagement.sopm
    $Self->{Translation}->{'Computer'} = 'Рачунар';
    $Self->{Translation}->{'Hardware'} = 'Хардвер';
    $Self->{Translation}->{'Network'} = 'Мрежа';
    $Self->{Translation}->{'Software'} = 'Софтвер';
    $Self->{Translation}->{'Expired'} = 'Истекло';
    $Self->{Translation}->{'Maintenance'} = 'Одржавање';
    $Self->{Translation}->{'Pilot'} = 'Пилот';
    $Self->{Translation}->{'Planned'} = 'Планирано';
    $Self->{Translation}->{'Repair'} = 'На поправци';
    $Self->{Translation}->{'Retired'} = 'Расходовано';
    $Self->{Translation}->{'Review'} = 'Рецензија';
    $Self->{Translation}->{'Test/QA'} = 'Тест/QA';
    $Self->{Translation}->{'Laptop'} = 'Лаптоп';
    $Self->{Translation}->{'Desktop'} = 'Десктоп';
    $Self->{Translation}->{'PDA'} = 'PDA';
    $Self->{Translation}->{'Server'} = 'Сервер';
    $Self->{Translation}->{'Other'} = 'Друго';
    $Self->{Translation}->{'Monitor'} = 'Монитор';
    $Self->{Translation}->{'Printer'} = 'Штампач';
    $Self->{Translation}->{'Switch'} = 'Свич';
    $Self->{Translation}->{'Router'} = 'Рутер';
    $Self->{Translation}->{'WLAN Access Point'} = 'WLAN приступна тачка';
    $Self->{Translation}->{'Security Device'} = 'Сигурносни уређај';
    $Self->{Translation}->{'Backup Device'} = 'Уређај за резервне копије';
    $Self->{Translation}->{'Mouse'} = 'Миш';
    $Self->{Translation}->{'Keyboard'} = 'Тастатура';
    $Self->{Translation}->{'Camera'} = 'Камера';
    $Self->{Translation}->{'Beamer'} = 'Пројектор';
    $Self->{Translation}->{'Modem'} = 'Модем';
    $Self->{Translation}->{'PCMCIA Card'} = 'PCMCIA картица';
    $Self->{Translation}->{'USB Device'} = 'USB уређај';
    $Self->{Translation}->{'Docking Station'} = 'Прикључна станица';
    $Self->{Translation}->{'Scanner'} = 'Скенер';
    $Self->{Translation}->{'Building'} = 'Зграда';
    $Self->{Translation}->{'Office'} = 'Канцеларија';
    $Self->{Translation}->{'Floor'} = 'Спрат';
    $Self->{Translation}->{'Room'} = 'Соба';
    $Self->{Translation}->{'Rack'} = 'Рек';
    $Self->{Translation}->{'Workplace'} = 'Радно место';
    $Self->{Translation}->{'Outlet'} = 'Утичница';
    $Self->{Translation}->{'IT Facility'} = 'ИТ објекат';
    $Self->{Translation}->{'LAN'} = 'LAN';
    $Self->{Translation}->{'WLAN'} = 'WLAN';
    $Self->{Translation}->{'Telco'} = 'Telco';
    $Self->{Translation}->{'GSM'} = 'GSM';
    $Self->{Translation}->{'Client Application'} = 'Клијентска апликација';
    $Self->{Translation}->{'Middleware'} = 'Посреднички програм';
    $Self->{Translation}->{'Server Application'} = 'Серверска апликација';
    $Self->{Translation}->{'Client OS'} = 'Клијентски OS';
    $Self->{Translation}->{'Server OS'} = 'Серверски OS';
    $Self->{Translation}->{'Admin Tool'} = 'Административни алат';
    $Self->{Translation}->{'User Tool'} = 'Кориснички алат';
    $Self->{Translation}->{'Embedded'} = 'Уграђен';
    $Self->{Translation}->{'Single Licence'} = 'Појединачна лиценца';
    $Self->{Translation}->{'Per User'} = 'По кориснику';
    $Self->{Translation}->{'Per Processor'} = 'По процесору';
    $Self->{Translation}->{'Per Server'} = 'По серверу';
    $Self->{Translation}->{'Per Node'} = 'По чвору';
    $Self->{Translation}->{'Volume Licence'} = 'Количинске лиценце';
    $Self->{Translation}->{'Enterprise Licence'} = 'Компанијска лиценца';
    $Self->{Translation}->{'Developer Licence'} = 'Развојна лиценца';
    $Self->{Translation}->{'Demo'} = 'Демонстрациони';
    $Self->{Translation}->{'Time Restricted'} = 'Временски ограничено';
    $Self->{Translation}->{'Freeware'} = 'Бесплатни **';
    $Self->{Translation}->{'Open Source'} = 'Отворени код';
    $Self->{Translation}->{'Unlimited'} = 'Неограничено';

    # JS File: ITSM.Agent.ConfigItem.Zoom
    $Self->{Translation}->{'Ok'} = 'У реду';

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
    $Self->{Translation}->{'Branch View commit limit'} = 'Ограничење броја комитова у приказу гране';
    $Self->{Translation}->{'CodePolicy'} = '';
    $Self->{Translation}->{'Commit limit per page for Branch view screen'} = 'Ограничење броја комитова по страни у екрану приказа гране';
    $Self->{Translation}->{'Create analysis file'} = '';
    $Self->{Translation}->{'Creates a analysis file from this ticket and sends to Znuny.'} =
        '';
    $Self->{Translation}->{'Creates a analysis file from this ticket.'} = '';
    $Self->{Translation}->{'Define private addon repos.'} = '';
    $Self->{Translation}->{'Defines the filter that processes the HTML templates.'} = '';
    $Self->{Translation}->{'Defines the test module for checking code policy.'} = '';
    $Self->{Translation}->{'Definition of GIT clone/push URL Prefix.'} = 'Дефиниција адресног префикса за GIT клонирање и слање.';
    $Self->{Translation}->{'Definition of a Dynamic Field: Group => Group with access to the Dynamic Fields; AlwaysVisible => Field can be removed (0|1); InformationAreaName => Name of the Widgets; InformationAreaSize => Size and position of the widgets (Large|Small); Name => Name of the Dynamic Field which should be used; Priority => Order of the Dynamic Fields; State => State of the Fields (0 = disabled, 1 = active, 2 = mandatory), FilterRelease => Regex which the repository name has to match to be displayed, FilterPackage => Regex which the package name has to match to be displayed, FilterBranch => Regex which the branch name has to match to be displayed, FilterRelease => Regex which the repelase version string has to match to be displayed.'} =
        'Дефиниција динамичког поља: Group => група за приступ динамичким пољима; AlwaysVisible => поље може бити уклоњено (0|1); InformationAreaName => наслов додатака; InformationAreaSize => величина и позиција додатака (Large|Small); Name => назив динамичког поља; Priority => редослед динамичких поља; State => статус поља (0 = онемогућено, 1 = омогућено, 2 = обавезно); FilterRepository => регуларни израз који назив складишта мора да задовољава да би поље било приказано; FilterPackage => регуларни израз које назив пакета мора да задовољава да би поље било приказано; FilterBranch => регуларни израз који назив гране мора да задовољава да би поље било приказано; FilterRelease => регуларни израз који верзија издања мора да задовољава да би поље било приказано.';
    $Self->{Translation}->{'Definition of a Dynamic Field: Group => Group with access to the Dynamic Fields; AlwaysVisible => Field can be removed (0|1); InformationAreaName => Name of the Widgets; InformationAreaSize => Size and position of the widgets (Large|Small); Name => Name of the Dynamic Field which should be used; Priority => Order of the Dynamic Fields; State => State of the Fields (0 = disabled, 1 = active, 2 = mandatory), FilterRepository => Regex which the repository name has to match to be displayed, FilterPackage => Regex which the package name has to match to be displayed, FilterBranch => Regex which the branch name has to match to be displayed, FilterRelease => Regex which the repelase version string has to match to be displayed.'} =
        'Дефиниција динамичког поља: Group => група за приступ динамичким пољима; AlwaysVisible => поље може бити уклоњено (0|1); InformationAreaName => наслов додатака; InformationAreaSize => величина и позиција додатака (Large|Small); Name => назив динамичког поља; Priority => редослед динамичких поља; State => статус поља (0 = онемогућено, 1 = омогућено, 2 = обавезно); FilterRepository => регуларни израз који назив складишта мора да задовољава да би поље било приказано; FilterPackage => регуларни израз које назив пакета мора да задовољава да би поље било приказано; FilterBranch => регуларни израз који назив гране мора да задовољава да би поље било приказано; FilterRelease => регуларни израз који верзија издања мора да задовољава да би поље било приказано.';
    $Self->{Translation}->{'Definition of external MD5 sums (key => MD5, Value => Vendor, PackageName, Version, Date).'} =
        'Дефиниција екстерних MD5 вредности (кључ => MD5, вредност => Vendor, PackageName, Version, Date).';
    $Self->{Translation}->{'Definition of mappings between public repository requests and internal OPMS repositories.'} =
        'Мапирање складишта у јавним захтевима са интерним OPMS складиштима.';
    $Self->{Translation}->{'Definition of package states.'} = 'Дефиниција стања пакета.';
    $Self->{Translation}->{'Definition of renamed OPMS packages.'} = 'Дефиниција OPMS пакета са промењеним именом.';
    $Self->{Translation}->{'Directory, which is used by Git to cache repositories.'} = '';
    $Self->{Translation}->{'Directory, which is used by Git to store temporary data.'} = '';
    $Self->{Translation}->{'Directory, which is used by Git to store working copies.'} = '';
    $Self->{Translation}->{'Disable online repositories.'} = '';
    $Self->{Translation}->{'Do not log git ssh connection authorization results for these users. Useful for automated stuff.'} =
        'Искључи бележење ауторизација приликом остваривања Git SSH конекција за ове кориснике. Корисно за аутоматизацију.';
    $Self->{Translation}->{'Dynamic Fields Screens'} = '';
    $Self->{Translation}->{'DynamicFieldScreen'} = '';
    $Self->{Translation}->{'Export all available public keys to authorized_keys file.'} = 'Извези све доступне јавне кључеве у датотеку authorized_keys.';
    $Self->{Translation}->{'Export all relevant releases to ftp server.'} = 'Извоз свих релевантних издања на FTP сервер.';
    $Self->{Translation}->{'Frontend module registration for the OPMS object in the agent interface.'} =
        'Модул регистрације за OPMS објекат у интерфејсу оператера.';
    $Self->{Translation}->{'Frontend module registration for the PublicOPMSRepository object in the public interface.'} =
        'Модул регистрације за PublicOPMSRepository објекат у јавном интерфејсу.';
    $Self->{Translation}->{'Frontend module registration for the PublicOPMSRepositoryLookup object in the public interface.'} =
        'Модул регистрације за PublicOPMSRepositoryLookup објекат у јавном интерфејсу.';
    $Self->{Translation}->{'Frontend module registration for the PublicOPMSTestBuild object in the public interface.'} =
        'Модул регистрације за PublicOPMSTestBuild објекат у јавном интерфејсу.';
    $Self->{Translation}->{'Frontend module registration for the PublicPackageVerification object in the public interface.'} =
        'Модул регистрације за PublicPackageVerification објекат у јавном интерфејсу.';
    $Self->{Translation}->{'Frontend module registration for the admin interface.'} = '';
    $Self->{Translation}->{'GIT Author registration.'} = 'Регистрација Git аутора.';
    $Self->{Translation}->{'Generate HTML comment hooks for the specified blocks so that filters can use them.'} =
        '';
    $Self->{Translation}->{'Generate documentations once per night.'} = '';
    $Self->{Translation}->{'Git'} = 'Git';
    $Self->{Translation}->{'Git Management'} = 'Git управљање';
    $Self->{Translation}->{'Git Repository'} = '';
    $Self->{Translation}->{'Group, whose members have delete admin permissions in OPMS.'} = 'Група чији чланови имају дозволу за брисање у OPMS.';
    $Self->{Translation}->{'Group, whose members have repository admin permissions in OPMS.'} =
        'Група чији чланови имају администраторске дозволе у OPMS.';
    $Self->{Translation}->{'Group, whose members will see CI test result information in OPMS screens.'} =
        '';
    $Self->{Translation}->{'Groups an authenticated user (by user login and password) must be member of to build test packages via the public interface.'} =
        'Групе у којима регистровани корисник (по корисничком имену и лозинци) мора бити члан да би имао дозволу за креирање тест издања пакета у јавном интерфејсу.';
    $Self->{Translation}->{'Groups which will be set during git project creation processes while adding OPMS repositories.'} =
        'Групе које ће бити подешене приликом креирања GIT пројекта у случају додавања OPMS складишта.';
    $Self->{Translation}->{'Manage dynamic field in screens.'} = '';
    $Self->{Translation}->{'Manage your public SSH key(s) for Git access here. Make sure to save this preference when you add a new key.'} =
        'Уредите своје јавне SSH кључеве за Git приступ. Обратите пажњу да морате сачувати ово подешавање приликом додавања новог кључа.';
    $Self->{Translation}->{'Module to generate statistics about the added code lines.'} = 'Модул за генерисање статистика о броју додатих линија кода.';
    $Self->{Translation}->{'Module to generate statistics about the growth of code.'} = 'Модул за генерисање статистика о увећању кода.';
    $Self->{Translation}->{'Module to generate statistics about the number of git commits.'} =
        'Модул за генерисање статистика о броју Git комитова.';
    $Self->{Translation}->{'Module to generate statistics about the removed code lines.'} = 'Модул за генерисање статистика о броју уклоњених линија кода.';
    $Self->{Translation}->{'OPMS'} = 'OPMS';
    $Self->{Translation}->{'Only users who have rw permissions in one of these groups may access git.'} =
        'Само корисници који имају rw дозволу у једној од ових група имаће Git приступ.';
    $Self->{Translation}->{'Option to set a package compatibility manually.'} = '';
    $Self->{Translation}->{'Parameters for the pages in the BranchView screen.'} = 'Параметри за странице у екрану приказа гране.';
    $Self->{Translation}->{'Pre-Definition of the \'GITProjectName\' Dynamic Field: Group => Group with access to the Dynamic Fields; AlwaysVisible => Field can be removed (0|1); InformationAreaName => Name of the Widgets; InformationAreaSize => Size and position of the widgets (Large|Small); Name => Name of the Dynamic Field which should be used; Priority => Order of the Dynamic Fields; State => State of the Fields (0 = disabled, 1 = active, 2 = mandatory), FilterRepository => Regex which the repository name has to match to be displayed, FilterPackage => Regex which the package name has to match to be displayed, FilterBranch => Regex which the branch name has to match to be displayed, FilterRelease => Regex which the repelase version string has to match to be displayed.'} =
        'Предефинисање динамичког поља \'GITProjectName\': Group => група за приступ динамичким пољима; AlwaysVisible => поље може бити уклоњено (0|1); InformationAreaName => наслов додатака; InformationAreaSize => величина и позиција додатака (Large|Small); Name => назив динамичког поља; Priority => редослед динамичких поља; State => статус поља (0 = онемогућено, 1 = омогућено, 2 = обавезно); FilterRepository => регуларни израз који назив складишта мора да задовољава да би поље било приказано; FilterPackage => регуларни израз које назив пакета мора да задовољава да би поље било приказано; FilterBranch => регуларни израз који назив гране мора да задовољава да би поље било приказано; FilterRelease => регуларни израз који верзија издања мора да задовољава да би поље било приказано.';
    $Self->{Translation}->{'Pre-Definition of the \'GITRepositoryName\' Dynamic Field: Group => Group with access to the Dynamic Fields; AlwaysVisible => Field can be removed (0|1); InformationAreaName => Name of the Widgets; InformationAreaSize => Size and position of the widgets (Large|Small); Name => Name of the Dynamic Field which should be used; Priority => Order of the Dynamic Fields; State => State of the Fields (0 = disabled, 1 = active, 2 = mandatory), FilterRepository => Regex which the repository name has to match to be displayed, FilterPackage => Regex which the package name has to match to be displayed, FilterBranch => Regex which the branch name has to match to be displayed, FilterRelease => Regex which the repelase version string has to match to be displayed.'} =
        'Предефинисање динамичког поља \'GITRepositoryName\': Group => група за приступ динамичким пољима; AlwaysVisible => поље може бити уклоњено (0|1); InformationAreaName => наслов додатака; InformationAreaSize => величина и позиција додатака (Large|Small); Name => назив динамичког поља; Priority => редослед динамичких поља; State => статус поља (0 = онемогућено, 1 = омогућено, 2 = обавезно); FilterRepository => регуларни израз који назив складишта мора да задовољава да би поље било приказано; FilterPackage => регуларни израз које назив пакета мора да задовољава да би поље било приказано; FilterBranch => регуларни израз који назив гране мора да задовољава да би поље било приказано; FilterRelease => регуларни израз који верзија издања мора да задовољава да би поље било приказано.';
    $Self->{Translation}->{'Pre-Definition of the \'PackageDeprecated\' Dynamic Field: Group => Group with access to the Dynamic Fields; AlwaysVisible => Field can be removed (0|1); InformationAreaName => Name of the Widgets; InformationAreaSize => Size and position of the widgets (Large|Small); Name => Name of the Dynamic Field which should be used; Priority => Order of the Dynamic Fields; State => State of the Fields (0 = disabled, 1 = active, 2 = mandatory), FilterRepository => Regex which the repository name has to match to be displayed, FilterPackage => Regex which the package name has to match to be displayed, FilterBranch => Regex which the branch name has to match to be displayed, FilterRelease => Regex which the repelase version string has to match to be displayed.'} =
        'Предефинисање динамичког поља \'PackageDeprecated\': Group => група за приступ динамичким пољима; AlwaysVisible => поље може бити уклоњено (0|1); InformationAreaName => наслов додатака; InformationAreaSize => величина и позиција додатака (Large|Small); Name => назив динамичког поља; Priority => редослед динамичких поља; State => статус поља (0 = онемогућено, 1 = омогућено, 2 = обавезно); FilterRepository => регуларни израз који назив складишта мора да задовољава да би поље било приказано; FilterPackage => регуларни израз које назив пакета мора да задовољава да би поље било приказано; FilterBranch => регуларни израз који назив гране мора да задовољава да би поље било приказано; FilterRelease => регуларни израз који верзија издања мора да задовољава да би поље било приказано.';
    $Self->{Translation}->{'Recipients that will be informed by email in case of errors.'} =
        '';
    $Self->{Translation}->{'SSH Keys for Git Access'} = 'SSH кључеви за Git приступ';
    $Self->{Translation}->{'Send analysis file'} = '';
    $Self->{Translation}->{'Sets the git clone address to be used in repository listings.'} =
        'Дефинише адресу за Git клонирање која ће бити коришћена у приказу репозиторија.';
    $Self->{Translation}->{'Sets the home directory for git repositories.'} = 'Дефинише директоријум за Git репозиторије.';
    $Self->{Translation}->{'Sets the path for the BugzillaAddComment post receive script location.'} =
        'Дефинише путању до BugzillaAddComment скрипта.';
    $Self->{Translation}->{'Sets the path for the OTRSCodePolicy  script location. It is recommended to have a separate clone of the OTRSCodePolicy module that is updated via cron.'} =
        '';
    $Self->{Translation}->{'Sets the path for the OTRSCodePolicy pre receive script location. It is recommended to have a separate clone of the OTRSCodePolicy module that is updated via cron.'} =
        'Дефинише путању до OTRSCodePolicy скрипта. Препоручено је да постоји посебан клон OTRSCodePolicy модула који се редовно освежава путем cron.';
    $Self->{Translation}->{'Show latest commits in git repositories.'} = '';
    $Self->{Translation}->{'Shows a link in the menu to go create a unit test from the current ticket.'} =
        '';
    $Self->{Translation}->{'Synchronize OPMS tables with a remote database.'} = 'Синхронизација OPMS табела са удаљеном базом.';
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
        'Корисници који имају rw дозволу у једној од ових група имаће могућност извршавања команде \'git push --force\'.';
    $Self->{Translation}->{'Users who have rw permissions in one of these groups are permitted to manage projects. Additionally the members have administration permissions to the git management.'} =
        'Корисници који имају rw дозволу у једној од ових група имаће могућност управљања пројектима. Додатно припадници ће имати администрационе привилегије за Git управљање.';


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

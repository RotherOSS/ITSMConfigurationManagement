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

package Kernel::Language::ko_ITSMConfigurationManagement;

use strict;
use warnings;
use utf8;

sub Data {
    my $Self = shift;

    # Template: AdminGenericInterfaceOperationConfigItem
    $Self->{Translation}->{'General operation data'} = '일반 운영 데이터';
    $Self->{Translation}->{'Settings for incoming request data'} = '수신 요청 데이터 설정';
    $Self->{Translation}->{'Settings for outgoing response data'} = '발신 응답 데이터 설정';

    # Template: AdminITSMConfigItem
    $Self->{Translation}->{'Config Item Management'} = '구성 항목 관리';
    $Self->{Translation}->{'Change class definition'} = '클래스 정의 변경';
    $Self->{Translation}->{'Change role definition'} = '역할 정의 변경';
    $Self->{Translation}->{'Ready2Import Class Bundles'} = 'Ready2Import 클래스 번들';
    $Self->{Translation}->{'Here you can import Ready2Import class bundles showcasing our most usual config items. Please note that some additional configuration may be required.'} =
        '여기에서 가장 일반적인 구성 항목을 보여주는 Ready2Import 클래스 번들을 가져올 수 있습니다. 몇 가지 추가 구성이 필요할 수 있습니다.';
    $Self->{Translation}->{'Update existing entities'} = '기존 엔터티 업데이트';
    $Self->{Translation}->{'Import Ready2Adopt class bundles'} = 'Ready2Adopt 클래스 번들 가져오기';
    $Self->{Translation}->{'Config Item Class'} = '구성 항목 클래스';
    $Self->{Translation}->{'Config Item Role'} = '구성 항목 역할';

    # Template: AgentITSMConfigItemAdd
    $Self->{Translation}->{'Config Item'} = '구성 항목';
    $Self->{Translation}->{'Filter for Classes'} = '수업 필터링';
    $Self->{Translation}->{'Select a Class from the list to create a new Config Item.'} = '목록에서 클래스를 선택하여 새 구성 항목을 만듭니다.';
    $Self->{Translation}->{'Class'} = '클래스';

    # Template: AgentITSMConfigItemBulk
    $Self->{Translation}->{'ITSM ConfigItem Bulk Action'} = 'ITSM 구성 항목 일괄 작업';
    $Self->{Translation}->{'Deployment state'} = '배포 상태';
    $Self->{Translation}->{'Incident state'} = '인시던트 상태';
    $Self->{Translation}->{'Link to another'} = '다른 링크';
    $Self->{Translation}->{'Invalid Configuration Item number!'} = '구성 항목 번호가 잘못되었습니다!';
    $Self->{Translation}->{'The number of another Configuration Item to link with.'} = '연결할 다른 구성 항목의 번호입니다.';

    # Template: AgentITSMConfigItemDelete
    $Self->{Translation}->{'Do you really want to delete this config item?'} = '이 구성 항목을 정말 삭제하시겠습니까?';

    # Template: AgentITSMConfigItemEdit
    $Self->{Translation}->{'The name of this config item'} = '이 구성 항목의 이름';
    $Self->{Translation}->{'Name is already in use by the ConfigItems with the following Number(s): %s'} =
        '이름이 이미 다음 번호의 구성 항목에서 사용 중입니다: %s.';
    $Self->{Translation}->{'Version Number'} = '버전 번호';
    $Self->{Translation}->{'Version number of this config item'} = '이 구성 항목의 버전 번호';
    $Self->{Translation}->{'Version Number is already in use by the ConfigItems with the following Number(s): %s'} =
        '버전 번호가 다음 번호의 ConfigItems에서 이미 사용 중입니다: %s.';
    $Self->{Translation}->{'Deployment State'} = '배포 상태';
    $Self->{Translation}->{'Incident State'} = '인시던트 상태';

    # Template: AgentITSMConfigItemHistory
    $Self->{Translation}->{'History of Config Item: %s'} = '구성 항목 기록: %s';
    $Self->{Translation}->{'History Content'} = '기록 콘텐츠';
    $Self->{Translation}->{'Createtime'} = '크리에이타임';
    $Self->{Translation}->{'Zoom view'} = '확대 보기';

    # Template: AgentITSMConfigItemOverviewNavBar
    $Self->{Translation}->{'Config Items per page'} = '페이지당 구성 항목';

    # Template: AgentITSMConfigItemOverviewSmall
    $Self->{Translation}->{'No config item data found.'} = '구성 항목 데이터를 찾을 수 없습니다.';
    $Self->{Translation}->{'Select this config item'} = '이 구성 항목을 선택합니다.';

    # Template: AgentITSMConfigItemSearch
    $Self->{Translation}->{'Run Search'} = '검색 실행';
    $Self->{Translation}->{'Also search in previous versions?'} = '이전 버전에서도 검색하시나요?';

    # Template: AgentITSMConfigItemTreeView
    $Self->{Translation}->{'TreeView for ConfigItem'} = '구성 항목용 트리뷰';
    $Self->{Translation}->{'Depth Level'} = '깊이 레벨';
    $Self->{Translation}->{'Zoom In/Out'} = '확대/축소';
    $Self->{Translation}->{'Max links level reached for ConfigItem!'} = '구성 항목의 최대 링크 레벨에 도달했습니다!';

    # Template: AgentITSMConfigItemZoom
    $Self->{Translation}->{'Configuration Item'} = '구성 항목';
    $Self->{Translation}->{'Configuration Item Information'} = '구성 항목 정보';
    $Self->{Translation}->{'Current Deployment State'} = '현재 배포 상태';
    $Self->{Translation}->{'Current Incident State'} = '현재 인시던트 상태';
    $Self->{Translation}->{'Last changed'} = '마지막 변경됨';
    $Self->{Translation}->{'Last changed by'} = '마지막 변경자';

    # Template: CustomerITSMConfigItem
    $Self->{Translation}->{'Your ConfigItems'} = '구성 항목';

    # Template: CustomerITSMConfigItemSearch
    $Self->{Translation}->{'ConfigItem Search'} = '구성 항목 검색';

    # Template: AdminACL
    $Self->{Translation}->{'Object Type'} = '개체 유형';

    # Template: AdminDynamicFieldScreen
    $Self->{Translation}->{'Filter by object type'} = '';

    # JS Template: ClassImportConfirm
    $Self->{Translation}->{'The following classes will be imported'} = '다음 클래스를 가져옵니다.';
    $Self->{Translation}->{'The following roles will be imported'} = '다음 역할을 가져옵니다.';
    $Self->{Translation}->{'Note that also corresponding dynamic fields and GeneralCatalog classes will be created and there is no automatic removal.'} =
        '해당 동적 필드와 일반 카탈로그 클래스도 생성되며 자동으로 제거되지 않는다는 점에 유의하세요.';
    $Self->{Translation}->{'Do you want to proceed?'} = '계속 진행하시겠습니까?';

    # Perl Module: Kernel/Modules/AdminITSMConfigItem.pm
    $Self->{Translation}->{'Need ExampleClasses!'} = '예제 클래스가 필요합니다!';
    $Self->{Translation}->{'Definition is no valid YAML hash.'} = '정의에 유효한 YAML 해시가 없습니다.';

    # Perl Module: Kernel/Modules/AgentITSMConfigItem.pm
    $Self->{Translation}->{'Overview: ITSM ConfigItem'} = '개요: ITSM 구성 항목';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemBulk.pm
    $Self->{Translation}->{'No ConfigItemID is given!'} = 'ConfigItemID가 지정되지 않았습니다!';
    $Self->{Translation}->{'You need at least one selected Configuration Item!'} = '선택한 구성 항목이 하나 이상 필요합니다!';
    $Self->{Translation}->{'You don\'t have write access to this configuration item: %s.'} =
        '이 구성 항목에 대한 쓰기 권한이 없습니다: %s.';
    $Self->{Translation}->{'No definition was defined for class %s!'} = '클래스에 대한 정의가 정의되지 않았습니다!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemDelete.pm
    $Self->{Translation}->{'Config item "%s" not found in database!'} = '데이터베이스에서 구성 항목 "%s"를 찾을 수 없습니다!';
    $Self->{Translation}->{'Was not able to delete the configitem ID %s!'} = '구성 항목 ID %s를 삭제할 수 없습니다!';
    $Self->{Translation}->{'No version found for ConfigItemID %s!'} = 'ConfigItemID %s에 대한 버전을 찾을 수 없습니다!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemEdit.pm
    $Self->{Translation}->{'No ConfigItemID, DuplicateID or ClassID is given!'} = '구성 항목 ID, 중복 ID 또는 클래스 ID가 지정되지 않았습니다!';
    $Self->{Translation}->{'No access is given!'} = '액세스 권한이 없습니다!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemHistory.pm
    $Self->{Translation}->{'Can\'t show history, no ConfigItemID is given!'} = '히스토리를 표시할 수 없고, ConfigItemID가 지정되지 않았습니다!';
    $Self->{Translation}->{'Can\'t show history, no access rights given!'} = '기록을 표시할 수 없으며 액세스 권한이 부여되지 않았습니다!';
    $Self->{Translation}->{'New ConfigItem (ID=%s)'} = '새 구성 항목(ID=%s)';
    $Self->{Translation}->{'New version (ID=%s)'} = '새 버전 (ID=%s)';
    $Self->{Translation}->{'Deployment state updated (new=%s, old=%s)'} = '배포 상태 업데이트됨(새=%s, 이전=%s)';
    $Self->{Translation}->{'Incident state updated (new=%s, old=%s)'} = '인시던트 상태 업데이트(새=%s, 이전=%s)';
    $Self->{Translation}->{'ConfigItem (ID=%s) deleted'} = '구성 항목(ID=%s) 삭제됨';
    $Self->{Translation}->{'Link to %s (type=%s) added'} = 's(유형=%s)에 대한 링크가 추가되었습니다.';
    $Self->{Translation}->{'Link to %s (type=%s) deleted'} = 's(유형=%s)에 대한 링크 삭제됨';
    $Self->{Translation}->{'ConfigItem definition updated (ID=%s)'} = '구성 항목 정의 업데이트됨(ID=%s)';
    $Self->{Translation}->{'Name updated (new=%s, old=%s)'} = '이름 업데이트(새=%s, 이전=%s)';
    $Self->{Translation}->{'Attribute %s updated from "%s" to "%s"'} = '속성 %s가 "%s"에서 "%s"로 업데이트되었습니다.';
    $Self->{Translation}->{'Version %s deleted'} = '버전 %s 삭제됨';
    $Self->{Translation}->{'File "%s" uploaded'} = '';
    $Self->{Translation}->{'File "%s" removed'} = '';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemPrint.pm
    $Self->{Translation}->{'No ConfigItemID or VersionID is given!'} = '구성 항목 ID 또는 버전 ID가 지정되지 않았습니다!';
    $Self->{Translation}->{'Can\'t show config item, no access rights given!'} = '설정 항목을 표시할 수 없으며 액세스 권한이 없습니다!';
    $Self->{Translation}->{'ConfigItemID %s not found in database!'} = 'ConfigItemID %s를 데이터베이스에서 찾을 수 없습니다!';
    $Self->{Translation}->{'ConfigItem'} = '구성 항목';
    $Self->{Translation}->{'printed by %s at %s'} = '에서 %s가 인쇄했습니다.';
    $Self->{Translation}->{'Referenced by'} = '';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemSearch.pm
    $Self->{Translation}->{'Invalid ClassID!'} = '잘못된 ClassID입니다!';
    $Self->{Translation}->{'No ClassID is given!'} = 'ClassID가 제공되지 않습니다!';
    $Self->{Translation}->{'No access rights for this class given!'} = '이 클래스에 대한 액세스 권한이 부여되지 않았습니다!';
    $Self->{Translation}->{'No Result!'} = '결과 없음!';
    $Self->{Translation}->{'Config Item Search Results'} = '구성 항목 검색 결과';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemZoom.pm
    $Self->{Translation}->{'Can\'t show item, no access rights for ConfigItem are given!'} =
        '항목을 표시할 수 없습니다. 구성 항목에 대한 액세스 권한이 부여되지 않았습니다!';
    $Self->{Translation}->{'ConfigItem not found!'} = '구성 항목을 찾을 수 없습니다!';
    $Self->{Translation}->{'No versions found!'} = '버전을 찾을 수 없습니다!';
    $Self->{Translation}->{'operational'} = '운영';
    $Self->{Translation}->{'warning'} = '경고';
    $Self->{Translation}->{'incident'} = '인시던트';
    $Self->{Translation}->{'The deployment state of this config item'} = '이 구성 항목의 배포 상태';
    $Self->{Translation}->{'The incident state of this config item'} = '이 구성 항목의 인시던트 상태';

    # Perl Module: Kernel/Modules/CustomerITSMConfigItemSearch.pm
    $Self->{Translation}->{'No permission'} = '비허가';
    $Self->{Translation}->{'Filter invalid!'} = '필터가 유효하지 않습니다!';
    $Self->{Translation}->{'Search params invalid!'} = '검색 매개변수가 잘못되었습니다!';

    # Perl Module: Kernel/Output/HTML/Dashboard/ITSMConfigItemGeneric.pm
    $Self->{Translation}->{'Shown config items'} = '표시된 구성 항목';
    $Self->{Translation}->{'Deployment State Type'} = '배포 상태 유형';
    $Self->{Translation}->{'Current Incident State Type'} = '현재 인시던트 상태 유형';

    # Perl Module: Kernel/Output/HTML/ITSMConfigItem/LayoutDate.pm
    $Self->{Translation}->{'Between'} = '사이';

    # Perl Module: Kernel/System/DynamicField/Driver/ConfigItem.pm
    $Self->{Translation}->{'Class restrictions for the config item'} = '구성 항목의 클래스 제한';
    $Self->{Translation}->{'Select one or more classes to restrict selectable config items'} =
        '하나 이상의 클래스를 선택하여 선택 가능한 구성 항목을 제한합니다.';
    $Self->{Translation}->{'Deployment state restrictions for the config item'} = '';
    $Self->{Translation}->{'Select one or more deployment states to restrict selectable config items'} =
        '';
    $Self->{Translation}->{'Dynamic (ConfigItem)'} = '동적(구성 항목)';
    $Self->{Translation}->{'Static (Version)'} = '정적(버전)';
    $Self->{Translation}->{'Link Referencing Type'} = '링크 참조 유형';
    $Self->{Translation}->{'Whether this link applies to the ConfigItem or the static version of the referencing object. Current Incident State calculation only is performed on dynamic links.'} =
        '이 링크가 구성 항목에 적용되는지 또는 참조 개체의 정적 버전에 적용되는지 여부입니다. 현재 인시던트 상태 계산은 동적 링크에서만 수행됩니다.';
    $Self->{Translation}->{'Select the attribute which config items will be searched by'} = '구성 항목을 검색할 속성을 선택합니다.';

    # Perl Module: Kernel/System/ITSMConfigItem/Definition.pm
    $Self->{Translation}->{'Base structure is not valid. Please provide a hash with data in YAML format.'} =
        '기본 구조가 유효하지 않습니다. YAML 형식의 데이터 해시를 입력하세요.';
    $Self->{Translation}->{'Starting the YAML string with \'---\' is required.'} = 'YAML 문자열은 \'---\'로 시작해야 합니다.';

    # Perl Module: Kernel/System/ITSMConfigItem/Link.pm
    $Self->{Translation}->{'Could not purge the table configitem_link.'} = 'configitem_link 테이블을 제거할 수 없습니다.';
    $Self->{Translation}->{'No relevant dynamic fields were found'} = '관련 동적 필드를 찾을 수 없습니다.';
    $Self->{Translation}->{'Could not insert into the table configitem_link'} = 'configitem_link 테이블에 삽입할 수 없습니다.';
    $Self->{Translation}->{'Inserted 0 rows into the table configitem_link'} = 'configitem_link 테이블에 행 0개를 삽입했습니다.';

    # Perl Module: Kernel/System/ImportExport/ObjectBackend/ITSMConfigItem.pm
    $Self->{Translation}->{'Maximum number of one element'} = '하나의 요소의 최대 개수';
    $Self->{Translation}->{'Maximum number of one Set dynamic field element'} = '';
    $Self->{Translation}->{'Maximum number of one element within a Set dynamic field element'} =
        '';
    $Self->{Translation}->{'Import/Export attachments (as the last entries per line)'} = '첨부파일 가져오기/내보내기(한 줄의 마지막 항목으로)';
    $Self->{Translation}->{'Version String'} = '버전 문자열';

    # Perl Module: Kernel/Modules/AdminDynamicField.pm
    $Self->{Translation}->{'Error synchronizing the definitions. Please check the log.'} = '정의 동기화 중 오류가 발생했습니다. 로그를 확인해 주세요.';
    $Self->{Translation}->{'You have ITSMConfigItem definitions which are not synchronized. Please deploy your ITSMConfigItem dynamic field changes.'} =
        '동기화되지 않은 ITSMConfigItem 정의가 있습니다. ITSMConfigItem 동적 필드 변경 사항을 배포하세요.';

    # Database XML / SOPM Definition: ITSMConfigurationManagement.sopm
    $Self->{Translation}->{'Expired'} = '만료됨';
    $Self->{Translation}->{'Maintenance'} = '유지 관리';
    $Self->{Translation}->{'Pilot'} = '파일럿';
    $Self->{Translation}->{'Planned'} = '계획된';
    $Self->{Translation}->{'Repair'} = '수리';
    $Self->{Translation}->{'Retired'} = '은퇴';
    $Self->{Translation}->{'Review'} = '검토';
    $Self->{Translation}->{'Test/QA'} = '테스트/QA';

    # JS File: ITSM.Admin.ITSMConfigItem
    $Self->{Translation}->{'Overview and Confirmation'} = '개요 및 확인';
    $Self->{Translation}->{'Importing classes/roles and their related fields'} = '클래스/역할 및 관련 필드 가져오기';
    $Self->{Translation}->{'An error occurred during class import.'} = '클래스 가져오기 중에 오류가 발생했습니다.';

    # SysConfig
    $Self->{Translation}->{'0 - Hidden'} = '0 - 숨김';
    $Self->{Translation}->{'1 - Shown'} = '1 - 표시됨';
    $Self->{Translation}->{'A mapping of inner field names used in the Process Management TransitionActions ConfigItemAdd and -Update. The keys are the names of the set inner fields of the set with object type ticket which will be used to create/update the CI, and the values are the names of the inner fields of the set with object type ITSMConfigItem.'} =
        '';
    $Self->{Translation}->{'Allows extended search conditions in config item search of the agent interface. With this feature you can search e. g. config item name with this kind of conditions like "(*key1*&&*key2*)" or "(*key1*||*key2*)".'} =
        '상담원 인터페이스의 구성 항목 검색에서 확장 검색 조건을 허용합니다. 이 기능을 사용하면 예를 들어 "(*key1*&&*key2*)" 또는 "(*key1*||*key2*)"와 같은 조건으로 구성 항목 이름을 검색할 수 있습니다.';
    $Self->{Translation}->{'Allows extended search conditions in config item search of the customer interface. With this feature you can search e. g. config item name with this kind of conditions like "(*key1*&&*key2*)" or "(*key1*||*key2*)".'} =
        '고객 인터페이스의 설정 항목 검색에서 확장 검색 조건을 허용합니다. 이 기능을 사용하면 예를 들어 "(*key1*&&*key2*)" 또는 "(*key1*||*key2*)"와 같은 조건으로 구성 항목 이름을 검색할 수 있습니다.';
    $Self->{Translation}->{'Assigned CIs'} = '할당된 CI';
    $Self->{Translation}->{'At a specific time point create a ticket for config items, if the configured requirements are met. The time point is determined by the value of the dynamic field of type date configured under "TimeCIKey" of the ConfigItem, and modified by "TimeModifier". If the latter can be either just a number, or a sign (+/-), a number, and an unit (d/h/m): "7" is equivalent to "+7d". The DynamicField "Ticket->DynamicField" will be used to mark created tickets - it has to exist. The flags \<OTOBO_CONFIGITEM_X\> where X can be NAME, NUMBER and DATE, will be substituted with the respective values in "Ticket->Text".'} =
        '';
    $Self->{Translation}->{'Attributes for license accounting.'} = '';
    $Self->{Translation}->{'Attributes for licenses counting, where "TotalLicensesDF", "AvailableLicensesDF" and "LicenseReferenceDF" are the names of the dynamic fields used to track the remaining licenses. If used, only deployment states in "ValidDeplStates" are considered. If a threshold is defined in "MinimumLicenses", a ticket will automatically be created if less licenses are available. For this, the checkbox dynamic field "Ticket->DynamicField" must exist. The tags \<OTOBO_CONFIGITEM_X\> where X can be NAME, NUMBER, LICENSES_AVAIL and LICENSES_MIN, will be substituted with the respective values in "Ticket->Text" by the config item name, number, available licenses, and minimum required available licenses, respectively.'} =
        '';
    $Self->{Translation}->{'CIs assigned to customer company'} = '고객사에 할당된 CI';
    $Self->{Translation}->{'CIs assigned to customer user'} = '고객 사용자에게 할당된 CI';
    $Self->{Translation}->{'CMDB Settings'} = 'CMDB 설정';
    $Self->{Translation}->{'Check for a unique name only within the same ConfigItem class (\'class\') or globally (\'global\'), which means every existing ConfigItem is taken into account when looking for duplicates.'} =
        '동일한 구성항목 클래스(\'class\') 또는 전역(\'global\') 내에서만 고유한 이름을 확인하므로 중복을 찾을 때 기존의 모든 구성항목이 고려됩니다.';
    $Self->{Translation}->{'Choose a module to enforce a naming scheme.'} = '명명 체계를 적용할 모듈을 선택합니다.';
    $Self->{Translation}->{'Choose a module to enforce a number scheme.'} = '번호 체계를 적용할 모듈을 선택합니다.';
    $Self->{Translation}->{'Choose a module to enforce a version string scheme.'} = '버전 문자열 체계를 적용할 모듈을 선택합니다.';
    $Self->{Translation}->{'Choose attributes to trigger the creation of a new version.'} = '새 버전 생성을 트리거할 속성을 선택합니다.';
    $Self->{Translation}->{'Choose categories to assign to this config item class.'} = '이 구성 항목 클래스에 할당할 카테고리를 선택합니다.';
    $Self->{Translation}->{'Column config item filters for ConfigItem Overview.'} = '구성 항목 개요에 대한 열 구성 항목 필터.';
    $Self->{Translation}->{'Columns that can be filtered in the config item overview of the agent interface. Note: Only Config Item attributes and Dynamic Fields (DynamicField_NameX) are allowed.'} =
        '상담원 인터페이스의 구성 항목 개요에서 필터링할 수 있는 열입니다. 참고: 구성 항목 속성과 동적 필드(DynamicField_NameX) 만 허용됩니다.';
    $Self->{Translation}->{'Config Items'} = '구성 항목';
    $Self->{Translation}->{'Config item add.'} = '구성 항목 추가.';
    $Self->{Translation}->{'Config item edit.'} = '구성 항목 편집.';
    $Self->{Translation}->{'Config item event module that enables accounting licenses for a given config item.'} =
        '';
    $Self->{Translation}->{'Config item event module that enables logging to history in the agent interface.'} =
        '상담원 인터페이스에서 기록에 로깅할 수 있는 구성 항목 이벤트 모듈입니다.';
    $Self->{Translation}->{'Config item event module that updates config items to their current definition.'} =
        '구성 항목을 현재 정의로 업데이트하는 구성 항목 이벤트 모듈입니다.';
    $Self->{Translation}->{'Config item history.'} = '구성 항목 기록.';
    $Self->{Translation}->{'Config item print.'} = '구성 항목 인쇄.';
    $Self->{Translation}->{'Config item zoom.'} = '구성 항목 확대/축소.';
    $Self->{Translation}->{'ConfigItem Tree View'} = '구성 항목 트리 보기';
    $Self->{Translation}->{'ConfigItem Version'} = '구성 항목 버전';
    $Self->{Translation}->{'ConfigItems of the following classes will not be stored on the Elasticsearch server. To apply this to existing CIs, the CI migration has to be run via console, after changing this option.'} =
        '다음 클래스의 구성 항목은 Elasticsearch 서버에 저장되지 않습니다. 이를 기존 CI에 적용하려면 이 옵션을 변경한 후 콘솔을 통해 CI 마이그레이션을 실행해야 합니다.';
    $Self->{Translation}->{'ConfigItems with the following deployment states will not be stored on the Elasticsearch server. To apply this to existing CIs, the CI migration has to be run via console, after changing this option.'} =
        '다음 배포 상태의 구성 항목은 Elasticsearch 서버에 저장되지 않습니다. 이를 기존 CI에 적용하려면 이 옵션을 변경한 후 콘솔을 통해 CI 마이그레이션을 실행해야 합니다.';
    $Self->{Translation}->{'Configuration Item Limit'} = '구성 항목 제한';
    $Self->{Translation}->{'Configuration Item limit per page.'} = '페이지당 구성 항목 제한.';
    $Self->{Translation}->{'Configuration Management Database.'} = '구성 관리 데이터베이스.';
    $Self->{Translation}->{'Configuration item bulk module.'} = '구성 항목 일괄 모듈.';
    $Self->{Translation}->{'Configuration item search backend router of the agent interface.'} =
        '상담원 인터페이스의 구성 항목 검색 백엔드 라우터입니다.';
    $Self->{Translation}->{'Configure the columns which are available for viewing Permission Conditions in the customer interface, when the corresponding Permission Condition Columns are not specifically configured. This setting is used as a fallback for the other Permission Condition Columns settings.'} =
        '';
    $Self->{Translation}->{'Configure the columns which are available when viewing the corresponding Permission Condition in the customer interface.'} =
        '';
    $Self->{Translation}->{'Create and manage the definitions for Configuration Items.'} = '구성 항목에 대한 정의를 만들고 관리합니다.';
    $Self->{Translation}->{'Creates Tickets for ConfigItems at specific time points.'} = '특정 시점에 구성 항목에 대한 티켓을 만듭니다.';
    $Self->{Translation}->{'Customers can see historic CI versions.'} = '고객은 과거 CI 버전을 볼 수 있습니다.';
    $Self->{Translation}->{'Customers have the possibility to manually switch between historic CI versions.'} =
        '고객은 이전 CI 버전 간에 수동으로 전환할 수 있습니다.';
    $Self->{Translation}->{'Default data to use on attribute for config item search screen. Example: "ITSMConfigItemCreateTimePointFormat=year;ITSMConfigItemCreateTimePointStart=Last;ITSMConfigItemCreateTimePoint=2;".'} =
        '구성 항목 검색 화면의 속성에 사용할 기본 데이터입니다. 예: "ITSMConfigItemCreateTimePointFormat=year;ITSMConfigItemCreateTimePointStart=Last;ITSMConfigItemCreateTimePoint=2;".';
    $Self->{Translation}->{'Default data to use on attribute for config item search screen. Example: "ITSMConfigItemCreateTimeStartYear=2010;ITSMConfigItemCreateTimeStartMonth=10;ITSMConfigItemCreateTimeStartDay=4;ITSMConfigItemCreateTimeStopYear=2010;ITSMConfigItemCreateTimeStopMonth=11;ITSMConfigItemCreateTimeStopDay=3;".'} =
        '구성 항목 검색 화면의 속성에 사용할 기본 데이터입니다. 예: "ITSMConfigItemCreateTimeStartYear=2010;ITSMConfigItemCreateTimeStartMonth=10;ITSMConfigItemCreateTimeStartDay=4;ITSMConfigItemCreateTimeStopYear=2010;ITSMConfigItemCreateTimeStopMonth=11;ITSMConfigItemCreateTimeStopDay=3;".';
    $Self->{Translation}->{'Define Actions where a settings button is available in the linked objects widget (LinkObject::ViewMode = "complex"). Please note that these Actions must have registered the following JS and CSS files: Core.AllocationList.css, Core.UI.AllocationList.js, Core.UI.Table.Sort.js, Core.Agent.TableFilters.js and Core.Agent.LinkObject.js.'} =
        '링크 객체 위젯에서 설정 버튼을 사용할 수있는 액션 정의 (LinkObject :: ViewMode = "complex"). 이러한 작업은 다음 JS 및 CSS 파일을 등록해야합니다. Core.AllocationList.css, Core.UI.AllocationList.js, Core.UI.Table.Sort.js, Core.Agent.TableFilters.js.';
    $Self->{Translation}->{'Define a Template::Toolkit scheme for version strings. Only used if Version String Module is set to TemplateToolkit.'} =
        '버전 문자열에 대한 템플릿::툴킷 체계를 정의합니다. 버전 문자열 모듈이 TemplateToolkit으로 설정된 경우에만 사용됩니다.';
    $Self->{Translation}->{'Define a set of conditions under which a customer is allowed to see a config item. Conditions can optionally be restricted to certain customer groups. Name is the only mandatory attribute. If no other options are given, all config items will be visible under that category.'} =
        '고객이 구성 항목을 볼 수 있도록 허용되는 조건 집합을 정의합니다. 조건은 선택적으로 특정 고객 그룹으로 제한할 수 있습니다. 이름은 유일한 필수 속성입니다. 다른 옵션을 지정하지 않으면 모든 구성 항목이 해당 카테고리 아래에 표시됩니다.';
    $Self->{Translation}->{'Defines Required permissions to delete ITSM configuration items using the Generic Interface.'} =
        '일반 인터페이스를 사용하여 ITSM 구성 항목을 삭제하는 데 필요한 권한을 정의합니다.';
    $Self->{Translation}->{'Defines Required permissions to get ITSM configuration items using the Generic Interface.'} =
        '일반 인터페이스를 사용하여 ITSM 구성 항목을 가져오는 데 필요한 권한을 정의합니다.';
    $Self->{Translation}->{'Defines Required permissions to search ITSM configuration items using the Generic Interface.'} =
        '일반 인터페이스를 사용하여 ITSM 구성 항목을 검색하는 데 필요한 권한을 정의합니다.';
    $Self->{Translation}->{'Defines Required permissions to set ITSM configuration items using the Generic Interface.'} =
        '일반 인터페이스를 사용하여 ITSM 구성 항목을 설정하는 데 필요한 권한을 정의합니다.';
    $Self->{Translation}->{'Defines an overview module to show the small view of a configuration item list.'} =
        '구성 항목 목록의 작은 보기를 표시하는 개요 모듈을 정의합니다.';
    $Self->{Translation}->{'Defines if the link type labels must be shown in the node connections.'} =
        '노드 연결에 링크 유형 레이블을 표시할지 여부를 정의합니다.';
    $Self->{Translation}->{'Defines regular expressions individually for each ConfigItem class to check the ConfigItem name and to show corresponding error messages.'} =
        '각 구성 항목 클래스에 대해 개별적으로 정규식을 정의하여 구성 항목 이름을 확인하고 해당 오류 메시지를 표시합니다.';
    $Self->{Translation}->{'Defines the available columns of CIs in the config item overview depending on the CI class. Each entry must consist of a class name and an array of available fields for the corresponding class. Dynamic field entries have to honor the scheme DynamicField_FieldName.'} =
        'CI 클래스에 따라 구성 항목 개요에서 사용 가능한 CI 열을 정의합니다. 각 항목은 클래스 이름과 해당 클래스에서 사용 가능한 필드 배열로 구성되어야 합니다. 동적 필드 항목은 DynamicField_FieldName 스키마를 따라야 합니다.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of the agent interface.'} =
        '상담원 인터페이스의 구성 항목 검색 결과의 구성 항목 정렬을 위한 기본 구성 항목 속성을 정의합니다.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of the customer interface.'} =
        '고객 인터페이스의 구성 항목 검색 결과의 구성 항목 정렬을 위한 기본 구성 항목 속성을 정의합니다.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of this operation.'} =
        '이 작업의 구성 항목 검색 결과의 구성 항목 정렬에 대한 기본 구성 항목 속성을 정의합니다.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the agent interface. Up: oldest on top. Down: latest on top.'} =
        '상담원 인터페이스의 구성 항목 검색 결과에서 기본 구성 항목 순서를 정의합니다. 위쪽: 가장 오래된 항목을 맨 위에 배치합니다. 아래로: 최신 항목이 맨 위에 있습니다.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the customer interface. Up: oldest on top. Down: latest on top.'} =
        '고객 인터페이스의 구성 항목 검색 결과에서 기본 구성 항목 순서를 정의합니다. 위쪽: 가장 오래된 항목을 맨 위에 표시합니다. 아래로: 최신 항목을 맨 위에 배치합니다.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the this operation. Up: oldest on top. Down: latest on top.'} =
        '이 작업의 구성 항목 검색 결과에서 기본 구성 항목 순서를 정의합니다. 위로: 가장 오래된 항목을 위에 표시합니다. 아래로: 최신 항목을 맨 위에 배치합니다.';
    $Self->{Translation}->{'Defines the default displayed columns of CIs in the config item overview depending on the CI class. Each entry must consist of a class name and an array of available fields for the corresponding class. Dynamic field entries have to honor the scheme DynamicField_FieldName.'} =
        'CI 클래스에 따라 구성 항목 개요에 표시되는 CI의 기본 열을 정의합니다. 각 항목은 클래스 이름과 해당 클래스에 사용 가능한 필드 배열로 구성되어야 합니다. 동적 필드 항목은 DynamicField_FieldName 스키마를 따라야 합니다.';
    $Self->{Translation}->{'Defines the default relations depth to be shown.'} = '표시할 기본 관계 깊이를 정의합니다.';
    $Self->{Translation}->{'Defines the default shown config item search attribute for config item search screen.'} =
        '구성 항목 검색 화면에 기본적으로 표시되는 구성 항목 검색 속성을 정의합니다.';
    $Self->{Translation}->{'Defines the default shown config item search attribute for config item search screen. Example: "Key" must have the name of the Dynamic Field in this case \'X\', "Content" must have the value of the Dynamic Field depending on the Dynamic Field type,  Text: \'a text\', Dropdown: \'1\', Date/Time: \'Search_DynamicField_XTimeSlotStartYear=1974; Search_DynamicField_XTimeSlotStartMonth=01; Search_DynamicField_XTimeSlotStartDay=26; Search_DynamicField_XTimeSlotStartHour=00; Search_DynamicField_XTimeSlotStartMinute=00; Search_DynamicField_XTimeSlotStartSecond=00; Search_DynamicField_XTimeSlotStopYear=2013; Search_DynamicField_XTimeSlotStopMonth=01; Search_DynamicField_XTimeSlotStopDay=26; Search_DynamicField_XTimeSlotStopHour=23; Search_DynamicField_XTimeSlotStopMinute=59; Search_DynamicField_XTimeSlotStopSecond=59;\' and or \'Search_DynamicField_XTimePointFormat=week; Search_DynamicField_XTimePointStart=Before; Search_DynamicField_XTimePointValue=7\';.'} =
        '구성 항목 검색 화면에 기본적으로 표시되는 구성 항목 검색 속성을 정의합니다. 예: "키"는 동적 필드의 이름(이 경우 \'X\'), "콘텐츠"는 동적 필드 유형에 따라 동적 필드의 값(텍스트: \'텍스트\', 드롭다운: \'1\', 날짜/시간)이어야 합니다: \'Search_DynamicField_XTimeSlotStartYear=1974; Search_DynamicField_XTimeSlotStartMonth=01; Search_DynamicField_XTimeSlotStartDay=26; Search_DynamicField_XTimeSlotStartHour=00\'; Search_DynamicField_XTimeSlotStartMinute=00; Search_DynamicField_XTimeSlotStartSecond=00; Search_DynamicField_XTimeSlotStopYear=2013; Search_DynamicField_XTimeSlotStopMonth=01; Search_DynamicField_XTimeSlotStopDay=26; Search_DynamicField_XTimeSlotStopHour=23; Search_DynamicField_XTimeSlotStopMinute=59; Search_DynamicField_XTimeSlotStopSecond=59;\' 및 또는 \'Search_DynamicField_XTimePointFormat=week; Search_DynamicField_XTimePointStart=Before; Search_DynamicField_XTimePointValue=7\';.';
    $Self->{Translation}->{'Defines the default subobject of the class \'ITSMConfigItem\'.'} =
        '\'ITSMConfigItem\' 클래스의 기본 하위 객체를 정의합니다.';
    $Self->{Translation}->{'Defines the disabled columns of CIs in the config item overview depending on the CI class. Each entry must consist of a class name and an array of available fields for the corresponding class. Dynamic field entries have to honor the scheme DynamicField_FieldName.'} =
        '';
    $Self->{Translation}->{'Defines the height for the rich text editor component for this screen. Enter number (pixels) or percent value (relative).'} =
        '이 화면의 서식있는 텍스트 편집기 구성 요소의 높이를 정의합니다. 숫자 (픽셀) 또는 퍼센트 값 (상대)을 입력하십시오.';
    $Self->{Translation}->{'Defines the number of rows for the CI definition editor in the admin interface.'} =
        '관리자 인터페이스에서 CI 정의 편집기의 행 수를 정의합니다.';
    $Self->{Translation}->{'Defines the order of incident states from high (e.g. cricital) to low (e.g. functional).'} =
        '인시던트 상태의 순서를 높음(예: 크리시탈)에서 낮음(예: 기능)으로 정의합니다.';
    $Self->{Translation}->{'Defines the relevant deployment states where linked tickets can affect the status of a CI.'} =
        '연결된 티켓이 CI의 상태에 영향을 줄 수 있는 관련 배포 상태를 정의합니다.';
    $Self->{Translation}->{'Defines the search limit for the AgentITSMConfigItem screen.'} =
        'AgentITSMConfigItem 화면의 검색 제한을 정의합니다.';
    $Self->{Translation}->{'Defines the search limit for the AgentITSMConfigItemSearch screen.'} =
        'AgentITSMConfigItemSearch 화면의 검색 제한을 정의합니다.';
    $Self->{Translation}->{'Defines the search limit for the CustomerITSMConfigItem screen.'} =
        'CustomerITSMConfigItem 화면의 검색 제한을 정의합니다.';
    $Self->{Translation}->{'Defines the search limit for the CustomerITSMConfigItemSearch screen.'} =
        'CustomerITSMConfigItemSearch 화면의 검색 제한을 정의합니다.';
    $Self->{Translation}->{'Defines the shown columns of CIs in the link table complex view for all CI classes. If there is no entry, then the default columns are shown.'} =
        '모든 CI 클래스에 대해 링크 테이블 복합 보기에 표시되는 CI 열을 정의합니다. 항목이 없으면 기본 열이 표시됩니다.';
    $Self->{Translation}->{'Defines the shown columns of CIs in the link table complex view, depending on the CI class. Each entry must be prefixed with the class name and double colons (i.e. Computer::). There are a few CI-Attributes that common to all CIs (example for the class Computer: Computer::Name, Computer::CurDeplState, Computer::CreateTime). To show individual CI-Attributes as defined in the CI-Definition, the following scheme must be used (example for the class Computer): Computer::HardDisk::1, Computer::HardDisk::1::Capacity::1, Computer::HardDisk::2, Computer::HardDisk::2::Capacity::1. If there is no entry for a CI class, then the default columns are shown.'} =
        'CI 클래스에 따라 링크 테이블 복합 보기에 표시되는 CI 열을 정의합니다. 각 항목 앞에는 클래스 이름과 이중 콜론(예: 컴퓨터::)이 와야 합니다. 모든 CI에 공통으로 적용되는 몇 가지 CI 속성이 있습니다(예: Computer 클래스의 경우: Computer::Name, Computer::CurDeplState, Computer::CreateTime). CI 정의에 정의된 대로 개별 CI 속성을 표시하려면 다음 스키마를 사용해야 합니다(예: Computer 클래스의 경우): 컴퓨터::하드디스크::1, 컴퓨터::하드디스크::1::용량::1, 컴퓨터::하드디스크::2, 컴퓨터::하드디스크::2::용량::1. CI 클래스에 대한 항목이 없는 경우 기본 열이 표시됩니다.';
    $Self->{Translation}->{'Defines which items are available for \'Action\' in third level of the ITSM Config Item ACL structure.'} =
        'ITSM 구성 항목 ACL 구조의 세 번째 수준에서 \'동작\'에 사용할 수 있는 항목을 정의합니다.';
    $Self->{Translation}->{'Defines which items are available in first level of the ITSM Config Item ACL structure.'} =
        'ITSM 구성 항목 ACL 구조의 첫 번째 수준에서 사용할 수 있는 항목을 정의합니다.';
    $Self->{Translation}->{'Defines which items are available in second level of the ITSM Config Item ACL structure.'} =
        'ITSM 구성 항목 ACL 구조의 두 번째 수준에서 사용할 수 있는 항목을 정의합니다.';
    $Self->{Translation}->{'Defines which type of link (named from the ticket perspective) can affect the status of a linked CI.'} =
        '연결된 CI의 상태에 영향을 미칠 수 있는 링크 유형(티켓 관점에서 명명됨)을 정의합니다.';
    $Self->{Translation}->{'Defines which type of ticket can affect the status of a linked CI.'} =
        '연결된 CI의 상태에 영향을 줄 수 있는 티켓 유형을 정의합니다.';
    $Self->{Translation}->{'Definition Update'} = '정의 업데이트';
    $Self->{Translation}->{'Delete Configuration Item'} = '구성 항목 삭제';
    $Self->{Translation}->{'DeplState'} = 'DeplState';
    $Self->{Translation}->{'Deployment State Color'} = '배포 상태 색상';
    $Self->{Translation}->{'DeploymentState'} = '배포 상태';
    $Self->{Translation}->{'Duplicate'} = '중복';
    $Self->{Translation}->{'Dynamic field event module that marks config item definitions as out of sync, if containing dynamic fields change.'} =
        '동적 필드 변경 사항이 포함된 경우 구성 항목 정의가 동기화되지 않은 것으로 표시하는 동적 필드 이벤트 모듈입니다.';
    $Self->{Translation}->{'Dynamic fields shown in the additional ITSM field screen of the agent interface.'} =
        '상담원 인터페이스의 추가 ITSM 필드 화면에 표시되는 동적 필드입니다.';
    $Self->{Translation}->{'Dynamic fields shown in the config item overview screen of the customer interface.'} =
        '고객 인터페이스의 구성 항목 개요 화면에 표시되는 동적 필드입니다.';
    $Self->{Translation}->{'Dynamic fields shown in the config item search screen of the agent interface.'} =
        '상담원 인터페이스의 구성 항목 검색 화면에 표시되는 동적 필드입니다.';
    $Self->{Translation}->{'Enables configuration item bulk action feature for the agent frontend to work on more than one configuration item at a time.'} =
        '상담원 프런트엔드에서 한 번에 두 개 이상의 구성 항목에 대해 작업할 수 있도록 구성 항목 일괄 작업 기능을 사용 설정합니다.';
    $Self->{Translation}->{'Enables configuration item bulk action feature only for the listed groups.'} =
        '나열된 그룹에 대해서만 구성 항목 일괄 작업 기능을 활성화합니다.';
    $Self->{Translation}->{'Enables/disables the functionality to check ITSM onfiguration items for unique names. Before enabling this option you should check your system for already existing config items with duplicate names. You can do this with the console command Admin::ITSM::ConfigItem::ListDuplicates.'} =
        '고유한 이름이 있는지 ITSM 구성 항목을 확인하는 기능을 사용/사용 안 함으로 설정합니다. 이 옵션을 사용 설정하기 전에 시스템에 이미 존재하는 구성 항목에 중복된 이름이 있는지 확인해야 합니다. 이 작업은 콘솔 명령인 Admin::ITSM::ConfigItem::ListDuplicates를 사용하여 수행할 수 있습니다.';
    $Self->{Translation}->{'Event module to set configitem-status on ticket-configitem-link.'} =
        '이벤트 모듈을 사용하여 티켓-configitem-link에서 configitem-status를 설정합니다.';
    $Self->{Translation}->{'Fields of the configuration item index, used for the fulltext search. Fields are also stored, but are not mandatory for the overall functionality. Inclusion of attachments can be disabled by setting the entry to 0 or deleting it.'} =
        '전체 텍스트 검색에 사용되는 구성 항목 인덱스의 필드입니다. 필드도 저장되지만 전체 기능에 필수적인 것은 아닙니다. 첨부 파일 포함은 항목을 0으로 설정하거나 삭제하여 비활성화할 수 있습니다.';
    $Self->{Translation}->{'Fields stored in the configuration item index which are used for other things besides fulltext searches. For the complete functionality all fields are mandatory.'} =
        '전체 텍스트 검색 외에 다른 용도로 사용되는 구성 항목 인덱스에 저장된 필드입니다. 전체 기능을 사용하려면 모든 필드가 필수입니다.';
    $Self->{Translation}->{'For every webservice (key) an array of classes (value) can be defined on which the import is restricted. For all chosen classes, or all existing classes the identifying attributes will have to be chosen in the invoker config.'} =
        '모든 웹서비스(키)에 대해 가져오기가 제한되는 클래스(값)의 배열을 정의할 수 있습니다. 선택한 모든 클래스 또는 모든 기존 클래스에 대해 식별 속성을 인보커 구성에서 선택해야 합니다.';
    $Self->{Translation}->{'GenericInterface module registration for the ConfigItemCreate invoker layer.'} =
        '';
    $Self->{Translation}->{'GenericInterface module registration for the ConfigItemFetch invoker layer.'} =
        'ConfigItemFetch 인보커 레이어에 대한 GenericInterface 모듈 등록.';
    $Self->{Translation}->{'GenericInterface module registration for the ConfigItemUpdate invoker layer.'} =
        '';
    $Self->{Translation}->{'ITSM ConfigItem'} = 'ITSM 구성 항목';
    $Self->{Translation}->{'ITSM config item overview.'} = 'ITSM 구성 항목 개요.';
    $Self->{Translation}->{'InciState'} = 'InciState';
    $Self->{Translation}->{'IncidentState'} = '인시던트 상태';
    $Self->{Translation}->{'Includes deployment states in the config item search of the customer interface.'} =
        '고객 인터페이스의 구성 항목 검색에 배포 상태를 포함합니다.';
    $Self->{Translation}->{'Includes incident states in the config item search of the customer interface.'} =
        '고객 인터페이스의 구성 항목 검색에 인시던트 상태를 포함합니다.';
    $Self->{Translation}->{'License accounting configuration item event module.'} = '';
    $Self->{Translation}->{'Maximum number of config items to be displayed in the result of this operation.'} =
        '이 작업의 결과에 표시할 최대 구성 항목 수입니다.';
    $Self->{Translation}->{'Module to check the group responsible for a class.'} = '모듈을 사용하여 클래스를 담당하는 그룹을 확인합니다.';
    $Self->{Translation}->{'Module to check the group responsible for a configuration item.'} =
        '모듈을 클릭하여 구성 항목을 담당하는 그룹을 확인합니다.';
    $Self->{Translation}->{'Module to generate ITSM config item statistics.'} = '모듈을 사용하여 ITSM 구성 항목 통계를 생성합니다.';
    $Self->{Translation}->{'Name Module'} = '이름 모듈';
    $Self->{Translation}->{'Number Module'} = '숫자 모듈';
    $Self->{Translation}->{'Number of config items to be displayed in each page of a search result in the agent interface.'} =
        '상담원 인터페이스에서 검색 결과의 각 페이지에 표시할 구성 항목의 수입니다.';
    $Self->{Translation}->{'Number of config items to be displayed in each page of a search result in the customer interface.'} =
        '고객 인터페이스에서 검색 결과의 각 페이지에 표시할 구성 항목 수입니다.';
    $Self->{Translation}->{'Objects to search for, how many entries and which attributs to show. ConfigItem attributes have to explicitly be stored via Elasticsearch.'} =
        '검색할 개체, 표시할 항목 수, 표시할 속성. 구성 항목 속성은 Elasticsearch를 통해 명시적으로 저장해야 합니다.';
    $Self->{Translation}->{'Overview.'} = '개요.';
    $Self->{Translation}->{'Parameters for the categories for config item classes in the preferences view of the agent interface.'} =
        '상담원 인터페이스의 기본 설정 보기에서 구성 항목 클래스의 카테고리에 대한 매개 변수입니다.';
    $Self->{Translation}->{'Parameters for the column filters of the small config item overview. Please note: setting \'Active\' to 0 will only prevent agents from editing settings of this group in their personal preferences, but will still allow administrators to edit the settings of another user\'s behalf. Use \'PreferenceGroup\' to control in which area these settings should be shown in the user interface.'} =
        '작은 구성 항목 개요의 열 필터에 대한 매개 변수입니다. 참고: \'활성\'을 0으로 설정하면 상담원이 개인 기본 설정에서 이 그룹의 설정을 편집할 수 없지만 관리자가 다른 사용자의 설정을 대신 편집할 수 있습니다. 사용자 인터페이스에서 이러한 설정이 표시될 영역을 제어하려면 \'PreferenceGroup\'을 사용하세요.';
    $Self->{Translation}->{'Parameters for the dashboard backend of the customer company config item overview of the agent interface . "Limit" is the number of entries per config item class shown by default. "Group" is used to restrict the access to the plugin (e. g. Group: admin;group1;group2;). "Default" determines if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" is the cache time in minutes for the plugin. "ConfigItemKey" is used to specify which reference field is used for a ConfigItem class (Key=Class, Value=DynamicFieldName).'} =
        '';
    $Self->{Translation}->{'Parameters for the dashboard backend of the customer company config item overview of the agent interface . "Limit" is the number of entries shown by default. "Group" is used to restrict the access to the plugin (e. g. Group: admin;group1;group2;). "Default" determines if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" is the cache time in minutes for the plugin. "ConfigItemKey" is used to specify which reference field is used for a ConfigItem class (Key=Class, Value=DynamicFieldName).'} =
        '';
    $Self->{Translation}->{'Parameters for the deployment states color in the preferences view of the agent interface.'} =
        '상담원 인터페이스의 기본 설정 보기에서 배포 상태의 매개변수 색상을 지정할 수 있습니다.';
    $Self->{Translation}->{'Parameters for the deployment states in the preferences view of the agent interface.'} =
        '상담원 인터페이스의 기본 설정 보기에서 배포 상태에 대한 매개변수입니다.';
    $Self->{Translation}->{'Parameters for the example permission groups of the general catalog attributes.'} =
        '일반 카탈로그 속성의 예시 권한 그룹에 대한 매개변수입니다.';
    $Self->{Translation}->{'Parameters for the name module for config item classes in the preferences view of the agent interface.'} =
        '상담원 인터페이스의 기본 설정 보기에서 구성 항목 클래스의 이름 모듈에 대한 매개 변수입니다.';
    $Self->{Translation}->{'Parameters for the number module for config item classes in the preferences view of the agent interface.'} =
        '상담원 인터페이스의 기본 설정 보기에서 구성 항목 클래스의 번호 모듈에 대한 매개 변수입니다.';
    $Self->{Translation}->{'Parameters for the pages (in which the configuration items are shown).'} =
        '페이지의 매개변수(구성 항목이 표시되는 페이지)입니다.';
    $Self->{Translation}->{'Parameters for the version string module for config item classes in the preferences view of the agent interface.'} =
        '상담원 인터페이스의 기본 설정 보기에서 구성 항목 클래스에 대한 버전 문자열 모듈의 매개 변수입니다.';
    $Self->{Translation}->{'Parameters for the version string template toolkit module for config item classes in the preferences view of the agent interface.'} =
        '상담원 인터페이스의 기본 설정 보기에서 구성 항목 클래스에 대한 버전 문자열 템플릿 툴킷 모듈의 매개 변수입니다.';
    $Self->{Translation}->{'Parameters for the version trigger for config item classes in the preferences view of the agent interface.'} =
        '상담원 인터페이스의 기본 설정 보기에서 구성 항목 클래스에 대한 버전 트리거의 매개 변수입니다.';
    $Self->{Translation}->{'Performs the configured action for each event (as an Invoker) for each configured Webservice.'} =
        '구성된 각 웹서비스의 각 이벤트에 대해 구성된 작업을 (인보커로서) 수행합니다.';
    $Self->{Translation}->{'Permission Group'} = '권한 그룹';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item attachment action in the agent interface.'} =
        '상담원 인터페이스에서 ITSM 구성 항목 첨부 작업을 사용하기 위해 필요한 권한입니다.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item screen in the agent interface.'} =
        '상담원 인터페이스에서 ITSM 구성 항목 화면을 사용하기 위해 필요한 권한입니다.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item search screen in the agent interface.'} =
        '상담원 인터페이스에서 ITSM 구성 항목 검색 화면을 사용하기 위해 필요한 권한입니다.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item search screen in the customer interface.'} =
        '고객 인터페이스에서 ITSM 구성 항목 검색 화면을 사용하기 위해 필요한 권한입니다.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item tree view screen in the agent interface.'} =
        '상담원 인터페이스에서 ITSM 구성 항목 트리 보기 화면을 사용하기 위해 필요한 권한입니다.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item zoom screen in the agent interface.'} =
        '상담원 인터페이스에서 ITSM 구성 항목 확대 화면을 사용하기 위해 필요한 권한입니다.';
    $Self->{Translation}->{'Required permissions to use the add ITSM configuration item screen in the agent interface.'} =
        '상담원 인터페이스에서 ITSM 구성 항목 추가 화면을 사용하기 위해 필요한 권한입니다.';
    $Self->{Translation}->{'Required permissions to use the bulk ITSM configuration item screen in the agent interface.'} =
        '상담원 인터페이스에서 일괄 ITSM 구성 항목 화면을 사용하기 위해 필요한 권한입니다.';
    $Self->{Translation}->{'Required permissions to use the edit ITSM configuration item screen in the agent interface.'} =
        '상담원 인터페이스에서 ITSM 구성 항목 편집 화면을 사용하기 위해 필요한 권한입니다.';
    $Self->{Translation}->{'Required permissions to use the history ITSM configuration item screen in the agent interface.'} =
        '상담원 인터페이스에서 기록 ITSM 구성 항목 화면을 사용하기 위해 필요한 권한입니다.';
    $Self->{Translation}->{'Required permissions to use the print ITSM configuration item screen in the agent interface.'} =
        '상담원 인터페이스에서 ITSM 구성 항목 인쇄 화면을 사용하기 위해 필요한 권한입니다.';
    $Self->{Translation}->{'Required privileges to delete config items.'} = '구성 항목을 삭제하려면 필요한 권한이 필요합니다.';
    $Self->{Translation}->{'Search config items.'} = '구성 항목을 검색합니다.';
    $Self->{Translation}->{'Set the incident state of a CI automatically when a Ticket is Linked to a CI.'} =
        '티켓이 CI에 연결되면 자동으로 CI의 인시던트 상태를 설정합니다.';
    $Self->{Translation}->{'Sets the deployment state in the configuration item bulk screen of the agent interface.'} =
        '상담원 인터페이스의 구성 항목 일괄 화면에서 배포 상태를 설정합니다.';
    $Self->{Translation}->{'Sets the incident state in the configuration item bulk screen of the agent interface.'} =
        '상담원 인터페이스의 구성 항목 일괄 화면에서 인시던트 상태를 설정합니다.';
    $Self->{Translation}->{'Shows a link in the menu that allows linking a configuration item with another object in the config item zoom view of the agent interface.'} =
        '상담원 인터페이스의 구성 항목 확대/축소 보기에서 구성 항목을 다른 개체와 연결할 수 있는 링크를 메뉴에 표시합니다.';
    $Self->{Translation}->{'Shows a link in the menu to access the history of a configuration item in the configuration item overview of the agent interface.'} =
        '상담원 인터페이스의 구성 항목 개요에 있는 구성 항목의 기록에 액세스할 수 있는 링크를 메뉴에 표시합니다.';
    $Self->{Translation}->{'Shows a link in the menu to access the history of a configuration item in the its zoom view of the agent interface.'} =
        '메뉴에 상담원 인터페이스의 확대 보기에서 구성 항목의 기록에 액세스할 수 있는 링크를 표시합니다.';
    $Self->{Translation}->{'Shows a link in the menu to delete a configuration item in its zoom view of the agent interface.'} =
        '메뉴에 상담원 인터페이스의 확대 보기에서 구성 항목을 삭제할 수 있는 링크를 표시합니다.';
    $Self->{Translation}->{'Shows a link in the menu to display the configuration item links as a Tree View.'} =
        '메뉴에 구성 항목 링크를 트리 보기로 표시하는 링크를 표시합니다.';
    $Self->{Translation}->{'Shows a link in the menu to duplicate a configuration item in the configuration item overview of the agent interface.'} =
        '상담원 인터페이스의 구성 항목 개요에 있는 구성 항목을 복제할 수 있는 링크를 메뉴에 표시합니다.';
    $Self->{Translation}->{'Shows a link in the menu to duplicate a configuration item in the its zoom view of the agent interface.'} =
        '메뉴에 링크를 표시하여 상담원 인터페이스의 확대/축소 보기에서 구성 항목을 복제할 수 있습니다.';
    $Self->{Translation}->{'Shows a link in the menu to edit a configuration item in the its zoom view of the agent interface.'} =
        '상담원 인터페이스의 확대 보기에서 구성 항목을 편집할 수 있는 링크를 메뉴에 표시합니다.';
    $Self->{Translation}->{'Shows a link in the menu to go back in the configuration item zoom view of the agent interface.'} =
        '메뉴에 상담원 인터페이스의 구성 항목 확대/축소 보기로 돌아갈 수 있는 링크를 표시합니다.';
    $Self->{Translation}->{'Shows a link in the menu to print a configuration item in the its zoom view of the agent interface.'} =
        '메뉴에 링크를 표시하여 상담원 인터페이스의 확대 보기에서 구성 항목을 인쇄할 수 있습니다.';
    $Self->{Translation}->{'Shows a link in the menu to zoom into a configuration item in the configuration item overview of the agent interface.'} =
        '상담원 인터페이스의 구성 항목 개요에 있는 구성 항목을 확대할 수 있는 링크를 메뉴에 표시합니다.';
    $Self->{Translation}->{'Shows the config item history (reverse ordered) in the agent interface.'} =
        '상담원 인터페이스에 구성 항목 기록을 표시합니다(역순).';
    $Self->{Translation}->{'The default category which is shown, if none is selected.'} = '선택되지 않은 경우 표시되는 기본 카테고리입니다.';
    $Self->{Translation}->{'The identifier for a configuration item, e.g. ConfigItem#, MyConfigItem#. The default is ConfigItem#.'} =
        '구성 항목의 식별자(예: ConfigItem#, MyConfigItem#)입니다. 기본값은 ConfigItem#입니다.';
    $Self->{Translation}->{'Triggers ConfigItemFetch invoker automatically.'} = 'ConfigItemFetch 인보커를 자동으로 트리거합니다.';
    $Self->{Translation}->{'Version String Expression'} = '버전 문자열 표현식';
    $Self->{Translation}->{'Version String Module'} = '버전 문자열 모듈';
    $Self->{Translation}->{'Version Trigger'} = '버전 트리거';
    $Self->{Translation}->{'Whether fields should be automatically filled (1), and in that case also be hidden from ticket formulars (2).'} =
        '';
    $Self->{Translation}->{'Whether the execution of ConfigItemACL can be avoided by checking cached field dependencies. This can improve loading times of formulars, but has to be disabled, if ACLModules are to be used for ITSMConfigItem- and Form-ReturnTypes.'} =
        '캐시된 필드 종속성을 확인하여 ConfigItemACL의 실행을 피할 수 있는지 여부. 이 옵션은 수식의 로딩 시간을 개선할 수 있지만, ACLModule을 ITSMConfigItem 및 Form-ReturnTypes에 사용하려는 경우 비활성화해야 합니다.';
    $Self->{Translation}->{'Which general information is shown in the header.'} = '헤더에 표시되는 일반 정보입니다.';
    $Self->{Translation}->{'class'} = '클래스';
    $Self->{Translation}->{'global'} = '글로벌';
    $Self->{Translation}->{'postproductive'} = '포스트 프로덕션';
    $Self->{Translation}->{'preproductive'} = '사전 생산성';
    $Self->{Translation}->{'productive'} = '생산성';

    # Ready to adopt classes: IT-Servicemanagement-11_0_3
    $Self->{Translation}->{'10U: 17.5 inches (44.45 cm)'} = '10U: 17.5인치(44.45cm)';
    $Self->{Translation}->{'12U: 21 inches (53.34 cm)'} = '12U: 21인치(53.34cm)';
    $Self->{Translation}->{'15U: 26.25 inches (66.68 cm)'} = '15U: 26.25인치(66.68cm)';
    $Self->{Translation}->{'18U: 31.5 inches (80.01 cm)'} = '18U: 31.5인치(80.01cm)';
    $Self->{Translation}->{'19-inch Rack'} = '19인치 랙';
    $Self->{Translation}->{'1U: 1.75 inches (4.45 cm)'} = '1U: 1.75인치(4.45cm)';
    $Self->{Translation}->{'20U: 35 inches (88.9 cm)'} = '20U: 35인치(88.9cm)';
    $Self->{Translation}->{'21-inch Rack'} = '21인치 랙';
    $Self->{Translation}->{'22U: 38.5 inches (97.79 cm)'} = '22U: 38.5인치(97.79cm)';
    $Self->{Translation}->{'23-inch Rack'} = '23인치 랙';
    $Self->{Translation}->{'23.6 inches (600 mm)'} = '23.6인치(600mm)';
    $Self->{Translation}->{'24U: 42 inches (106.68 cm)'} = '24U: 42인치(106.68cm)';
    $Self->{Translation}->{'27U: 47.25 inches (120.02 cm)'} = '27U: 47.25인치(120.02cm)';
    $Self->{Translation}->{'2U: 3.5 inches (8.89 cm)'} = '2U: 3.5인치(8.89cm)';
    $Self->{Translation}->{'30U: 52.5 inches (133.35 cm)'} = '30U: 52.5인치(133.35cm)';
    $Self->{Translation}->{'31.5 inches (800 mm)'} = '31.5인치(800mm)';
    $Self->{Translation}->{'33U: 57.75 inches (146.68 cm)'} = '33U: 57.75인치(146.68cm)';
    $Self->{Translation}->{'35.4 inches (900 mm)'} = '35.4인치(900mm)';
    $Self->{Translation}->{'36U: 63 inches (160.02 cm)'} = '36U: 63인치(160.02cm)';
    $Self->{Translation}->{'39.4 inches (1000 mm)'} = '39.4인치(1000mm)';
    $Self->{Translation}->{'39U: 68.25 inches (173.35 cm)'} = '39U: 68.25인치(173.35cm)';
    $Self->{Translation}->{'3U: 5.25 inches (13.34 cm)'} = '3U: 5.25인치(13.34cm)';
    $Self->{Translation}->{'42U: 73.5 inches (186.69 cm)'} = '42U: 73.5인치(186.69cm)';
    $Self->{Translation}->{'43.3 inches (1100 mm):'} = '43.3인치(1100mm):';
    $Self->{Translation}->{'45U: 78.75 inches (200.02 cm)'} = '45U: 78.75인치(200.02cm)';
    $Self->{Translation}->{'47.2 inches (1200 mm)'} = '47.2인치(1200mm)';
    $Self->{Translation}->{'48U: 84 inches (213.36 cm)'} = '48U: 84인치(213.36cm)';
    $Self->{Translation}->{'4U: 7 inches (17.78 cm)'} = '4U: 7인치(17.78cm)';
    $Self->{Translation}->{'5U: 8.75 inches (22.23 cm)'} = '5U: 8.75인치(22.23cm)';
    $Self->{Translation}->{'6U: 10.5 inches (26.67 cm)'} = '6U: 10.5인치(26.67cm)';
    $Self->{Translation}->{'7U: 12.25 inches (31.12 cm)'} = '7U: 12.25인치(31.12cm)';
    $Self->{Translation}->{'8U: 14 inches (35.56 cm)'} = '8U: 14인치(35.56cm)';
    $Self->{Translation}->{'9U: 15.75 inches (40.01 cm)'} = '9U: 15.75인치(40.01cm)';
    $Self->{Translation}->{'AGPL (Affero General Public License)'} = '';
    $Self->{Translation}->{'Accounting'} = '회계';
    $Self->{Translation}->{'Accounting Information'} = '';
    $Self->{Translation}->{'Address Allocation'} = '주소 할당';
    $Self->{Translation}->{'Administrator'} = '관리자';
    $Self->{Translation}->{'Analog Phone'} = '아날로그 전화';
    $Self->{Translation}->{'Apache Lizenz'} = '';
    $Self->{Translation}->{'Appliance Type'} = '어플라이언스 유형';
    $Self->{Translation}->{'BSD Lizenz (Berkeley Software Distribution License)'} = '';
    $Self->{Translation}->{'Battery Capacity (Ah)'} = '배터리 용량(Ah)';
    $Self->{Translation}->{'Battery Type'} = '배터리 유형';
    $Self->{Translation}->{'Building'} = '빌딩';
    $Self->{Translation}->{'Bus Interface'} = '버스 인터페이스';
    $Self->{Translation}->{'CC0 (Creative Commons Zero)'} = '';
    $Self->{Translation}->{'CIDR'} = 'CIDR';
    $Self->{Translation}->{'CPU'} = 'CPU';
    $Self->{Translation}->{'CPU Class'} = 'CPU 클래스';
    $Self->{Translation}->{'Capacity (GB)'} = '용량(GB)';
    $Self->{Translation}->{'Capacity per graphics card'} = '그래픽 카드당 용량';
    $Self->{Translation}->{'Card Number'} = '카드 번호';
    $Self->{Translation}->{'Card Reader'} = '카드 리더';
    $Self->{Translation}->{'Card Type'} = '카드 유형';
    $Self->{Translation}->{'Client Certificates'} = '클라이언트 인증서';
    $Self->{Translation}->{'Client Software'} = '클라이언트 소프트웨어';
    $Self->{Translation}->{'Client category'} = '고객 카테고리';
    $Self->{Translation}->{'Clockrate'} = '시계 속도';
    $Self->{Translation}->{'Clockspeed'} = '시계 속도';
    $Self->{Translation}->{'Code Signing Certificates'} = '코드 서명 인증서';
    $Self->{Translation}->{'Conference Phone'} = '회의용 전화';
    $Self->{Translation}->{'Consulting Agreement'} = '컨설팅 계약';
    $Self->{Translation}->{'Contact'} = '연락처';
    $Self->{Translation}->{'Contact Distributor'} = '총판 연락처';
    $Self->{Translation}->{'Container Management'} = '컨테이너 관리';
    $Self->{Translation}->{'Contract'} = '계약';
    $Self->{Translation}->{'Contract Type'} = '계약 유형';
    $Self->{Translation}->{'Contract period from'} = '계약 기간';
    $Self->{Translation}->{'Contract period until'} = '계약 기간';
    $Self->{Translation}->{'Cordless Phone (DECT Phone)'} = '무선 전화기(DECT 전화기)';
    $Self->{Translation}->{'Cost unit'} = '비용 단위';
    $Self->{Translation}->{'Count of licenses'} = '라이선스 수';
    $Self->{Translation}->{'Creation Date'} = '생성 날짜';
    $Self->{Translation}->{'Creative Commons'} = '';
    $Self->{Translation}->{'Custom Rack'} = '맞춤형 랙';
    $Self->{Translation}->{'DHCP'} = 'DHCP';
    $Self->{Translation}->{'DHCP Reserved'} = 'DHCP 예약';
    $Self->{Translation}->{'DNS-Server'} = 'DNS 서버';
    $Self->{Translation}->{'DVI'} = 'DVI';
    $Self->{Translation}->{'Date of Invoice'} = '송장 날짜';
    $Self->{Translation}->{'Date of Order'} = '주문 날짜';
    $Self->{Translation}->{'Date of Warranty'} = '보증 기간';
    $Self->{Translation}->{'Date of release'} = '출시 날짜';
    $Self->{Translation}->{'Desktop'} = '데스크톱';
    $Self->{Translation}->{'DisplayPort'} = '디스플레이 포트';
    $Self->{Translation}->{'Document Signing Certificates'} = '문서 서명 인증서';
    $Self->{Translation}->{'EPL (Eclipse Public License)'} = '';
    $Self->{Translation}->{'ETSI Rack'} = 'ETSI 랙';
    $Self->{Translation}->{'Email Certificates (S/MIME Certificates)'} = '이메일 인증서(S/MIME 인증서)';
    $Self->{Translation}->{'Embedded SIM (eSIM)'} = '';
    $Self->{Translation}->{'Employment Contract'} = '고용 계약';
    $Self->{Translation}->{'End IP Address'} = '최종 IP 주소';
    $Self->{Translation}->{'End of support'} = '지원 종료';
    $Self->{Translation}->{'Expiry Date'} = '만료 날짜';
    $Self->{Translation}->{'External Hard Drive'} = '외장 하드 드라이브';
    $Self->{Translation}->{'Firewall'} = '방화벽';
    $Self->{Translation}->{'Firmware'} = '펌웨어';
    $Self->{Translation}->{'Flywheel Energy Storage'} = '플라이휠 에너지 저장';
    $Self->{Translation}->{'Form Factor'} = '폼 팩터';
    $Self->{Translation}->{'Franchise Agreement'} = '프랜차이즈 계약';
    $Self->{Translation}->{'Freeware'} = '프리웨어';
    $Self->{Translation}->{'GPL (General Public License)'} = '';
    $Self->{Translation}->{'General Information'} = '일반 정보';
    $Self->{Translation}->{'Graphics Cards'} = '그래픽 카드';
    $Self->{Translation}->{'Graphics card'} = '그래픽 카드';
    $Self->{Translation}->{'HDMI'} = 'HDMI';
    $Self->{Translation}->{'Hardware'} = '하드웨어';
    $Self->{Translation}->{'Hardware Model'} = '하드웨어 모델';
    $Self->{Translation}->{'Hardware Weight'} = '하드웨어 무게';
    $Self->{Translation}->{'Headset'} = '헤드셋';
    $Self->{Translation}->{'IP Protocol'} = 'IP 프로토콜';
    $Self->{Translation}->{'Identity and Access Management (IAM)'} = 'ID 및 액세스 관리(IAM)';
    $Self->{Translation}->{'Inventory Number'} = '재고 번호';
    $Self->{Translation}->{'Inverstment costs'} = '투자 비용';
    $Self->{Translation}->{'Invoice Number'} = '송장 번호';
    $Self->{Translation}->{'Keyboard'} = '키보드';
    $Self->{Translation}->{'LCD Monitor (Liquid Crystal Display)'} = 'LCD 모니터(액정 디스플레이)';
    $Self->{Translation}->{'LED Monitor (Light Emitting Diode)'} = 'LED 모니터(발광 다이오드)';
    $Self->{Translation}->{'LGPL (Lesser General Public License)'} = '';
    $Self->{Translation}->{'Landline Phone'} = '유선 전화';
    $Self->{Translation}->{'Laptop'} = '노트북';
    $Self->{Translation}->{'Latitude'} = '위도';
    $Self->{Translation}->{'Layer 1: Physical Layer'} = '레이어 1: 물리적 레이어';
    $Self->{Translation}->{'Layer 2: Data Link Layer'} = '레이어 2: 데이터 링크 레이어';
    $Self->{Translation}->{'Layer 3: Network Layer'} = '레이어 3: 네트워크 레이어';
    $Self->{Translation}->{'Layer 3: Network Layer (Supernet)'} = '레이어 3: 네트워크 레이어(슈퍼넷)';
    $Self->{Translation}->{'Layer 4: Transport Layer'} = '레이어 4: 전송 레이어';
    $Self->{Translation}->{'Layer 5: Session Layer'} = '레이어 5: 세션 레이어';
    $Self->{Translation}->{'Layer 6: Presentation Layer'} = '레이어 6: 프레젠테이션 레이어';
    $Self->{Translation}->{'Layer 7: Application Layer'} = '레이어 7: 애플리케이션 레이어';
    $Self->{Translation}->{'Lease Agreement'} = '임대 계약';
    $Self->{Translation}->{'License Agreement'} = '라이선스 계약';
    $Self->{Translation}->{'License Count'} = '';
    $Self->{Translation}->{'License Key'} = '라이선스 키';
    $Self->{Translation}->{'License Type'} = '라이선스 유형';
    $Self->{Translation}->{'License period from'} = '라이선스 기간';
    $Self->{Translation}->{'License period until'} = '라이선스 기간';
    $Self->{Translation}->{'Lithium Iron Phosphate (LiFePO4) Battery'} = '리튬 인산철(LiFePO4) 배터리';
    $Self->{Translation}->{'Lithium-Ion (Li-ion) Battery'} = '리튬 이온(리튬 이온) 배터리';
    $Self->{Translation}->{'Loan Agreement'} = '대출 계약';
    $Self->{Translation}->{'Located in'} = '위치';
    $Self->{Translation}->{'Longitude'} = '경도';
    $Self->{Translation}->{'MIT Lizenz'} = '';
    $Self->{Translation}->{'MPL (Mozilla Public License)'} = '';
    $Self->{Translation}->{'Manufacturer'} = '제조업체';
    $Self->{Translation}->{'Maximum Load Capacity (W)'} = '최대 부하 용량(W)';
    $Self->{Translation}->{'Memory'} = '메모리';
    $Self->{Translation}->{'Memory Type'} = '메모리 유형';
    $Self->{Translation}->{'Micro SIM'} = '';
    $Self->{Translation}->{'Mini-Rack'} = '미니 랙';
    $Self->{Translation}->{'Mobile Number'} = '휴대폰 번호';
    $Self->{Translation}->{'Mobile/Embedded'} = '모바일/임베디드';
    $Self->{Translation}->{'Model'} = '모델';
    $Self->{Translation}->{'Model Description'} = '모델 설명';
    $Self->{Translation}->{'Monitor Resolution'} = '모니터 해상도';
    $Self->{Translation}->{'Monitor Size'} = '모니터 크기';
    $Self->{Translation}->{'Mouse'} = '마우스';
    $Self->{Translation}->{'Nano SIM'} = '';
    $Self->{Translation}->{'Network'} = '네트워크';
    $Self->{Translation}->{'Network Info'} = '네트워크 정보';
    $Self->{Translation}->{'Network Information'} = '네트워크 정보';
    $Self->{Translation}->{'Network Layer'} = '네트워크 계층';
    $Self->{Translation}->{'Nickel-Cadmium (NiCd) Battery'} = '니켈 카드뮴(NiCd) 배터리';
    $Self->{Translation}->{'Nickel-Metal Hydride (NiMH) Battery'} = '니켈-금속 수소 배터리(NiMH)';
    $Self->{Translation}->{'Non-Disclosure Agreement (NDA)'} = '기밀 유지 계약(NDA)';
    $Self->{Translation}->{'Notebook'} = '노트북';
    $Self->{Translation}->{'Number of CPUs'} = 'CPU 수';
    $Self->{Translation}->{'Number of RAM modules'} = 'RAM 모듈 수';
    $Self->{Translation}->{'Number of graphics cards'} = '그래픽 카드 수';
    $Self->{Translation}->{'OLED Monitor (Organic Light Emitting Diode)'} = 'OLED 모니터(유기 발광 다이오드)';
    $Self->{Translation}->{'Operating costs'} = '운영 비용';
    $Self->{Translation}->{'Order Number'} = '주문 번호';
    $Self->{Translation}->{'Other'} = '기타';
    $Self->{Translation}->{'Outputs'} = '출력';
    $Self->{Translation}->{'PIN'} = 'PIN';
    $Self->{Translation}->{'PIN 2'} = 'PIN 2';
    $Self->{Translation}->{'PUK'} = 'PUK';
    $Self->{Translation}->{'PUK 2'} = 'PUK 2';
    $Self->{Translation}->{'Partnership Agreement'} = '파트너십 계약';
    $Self->{Translation}->{'Perpetual licenses'} = '';
    $Self->{Translation}->{'Phone / VoIP'} = '';
    $Self->{Translation}->{'Phone Number'} = '전화번호';
    $Self->{Translation}->{'Phone Type'} = '전화 유형';
    $Self->{Translation}->{'Physical Cores'} = '물리적 코어';
    $Self->{Translation}->{'Power Delivery'} = '전력 공급';
    $Self->{Translation}->{'Public Domain'} = '';
    $Self->{Translation}->{'Purchased at'} = '다음에서 구매';
    $Self->{Translation}->{'Rack Depth'} = '랙 깊이';
    $Self->{Translation}->{'Rack Units (U)'} = '랙 유닛(U)';
    $Self->{Translation}->{'Room'} = '방';
    $Self->{Translation}->{'SIM Card'} = 'SIM 카드';
    $Self->{Translation}->{'SSL/TLS Certificates'} = 'SSL/TLS 인증서';
    $Self->{Translation}->{'Sales Contract'} = '판매 계약';
    $Self->{Translation}->{'Satellite Phone'} = '위성 전화';
    $Self->{Translation}->{'Sealed Lead-Acid (SLA) Battery'} = '밀폐형 납축(SLA) 배터리';
    $Self->{Translation}->{'Seat licenses'} = '';
    $Self->{Translation}->{'Serialnumber'} = '일련번호';
    $Self->{Translation}->{'Server Software'} = '서버 소프트웨어';
    $Self->{Translation}->{'Service Agreement'} = '서비스 계약';
    $Self->{Translation}->{'Service Tag'} = '서비스 태그';
    $Self->{Translation}->{'Shareware'} = '';
    $Self->{Translation}->{'Socket Type'} = '소켓 유형';
    $Self->{Translation}->{'Software'} = '소프트웨어';
    $Self->{Translation}->{'Speakers'} = '스피커';
    $Self->{Translation}->{'Standard SIM'} = '';
    $Self->{Translation}->{'Start IP Address'} = 'IP 주소 시작';
    $Self->{Translation}->{'Storage'} = '스토리지';
    $Self->{Translation}->{'Storage Partition'} = '스토리지 파티션';
    $Self->{Translation}->{'Subscription-based licenses'} = '';
    $Self->{Translation}->{'Subsidiary'} = '자회사';
    $Self->{Translation}->{'Summary'} = '요약';
    $Self->{Translation}->{'Thin Client'} = '씬 클라이언트';
    $Self->{Translation}->{'Threads'} = '스레드';
    $Self->{Translation}->{'Thunderbolt'} = '썬더볼트';
    $Self->{Translation}->{'Total Graphics card RAM (GB)'} = '총 그래픽 카드 RAM(GB)';
    $Self->{Translation}->{'Total RAM (GB)'} = '총 RAM(GB)';
    $Self->{Translation}->{'Touchscreen Monitor'} = '터치스크린 모니터';
    $Self->{Translation}->{'Tower'} = '타워';
    $Self->{Translation}->{'USB Hub'} = 'USB 허브';
    $Self->{Translation}->{'USB-C'} = 'USB-C';
    $Self->{Translation}->{'VGA'} = 'VGA';
    $Self->{Translation}->{'VPN'} = 'VPN';
    $Self->{Translation}->{'VR Headset'} = 'VR 헤드셋';
    $Self->{Translation}->{'Virtual Client'} = '';
    $Self->{Translation}->{'VirtualLink'} = 'VirtualLink';
    $Self->{Translation}->{'VoIP Phone'} = 'VoIP 전화';
    $Self->{Translation}->{'Volume licenses'} = '';
    $Self->{Translation}->{'Webcam'} = '웹캠';


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

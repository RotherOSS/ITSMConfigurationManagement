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

package Kernel::Language::ja_ITSMConfigurationManagement;

use strict;
use warnings;
use utf8;

sub Data {
    my $Self = shift;

    # Template: AdminITSMConfigItem
    $Self->{Translation}->{'Config Item Management'} = '構成アイテム管理';
    $Self->{Translation}->{'Change class definition'} = 'クラス定義を変更';
    $Self->{Translation}->{'Config Item Class'} = '構成アイテムのクラス';
    $Self->{Translation}->{'Definition'} = '記述';
    $Self->{Translation}->{'Change'} = '変更';

    # Template: AgentDashboardITSMConfigItemGeneric
    $Self->{Translation}->{'Incident State'} = 'インシデント状況';
    $Self->{Translation}->{'Deployment State'} = 'デプロイ・ステータス';
    $Self->{Translation}->{'Class'} = 'クラス';
    $Self->{Translation}->{'Deployment State Type'} = 'デプロイ・ステータスのタイプ';
    $Self->{Translation}->{'Current Incident State'} = '現在のインシデント・ステータス';
    $Self->{Translation}->{'Current Incident State Type'} = '現在のインシデント・ステータスのタイプ';
    $Self->{Translation}->{'Last changed'} = '最終変更日時';

    # Template: AgentITSMConfigItemAdd
    $Self->{Translation}->{'Config Item'} = '構成アイテム';
    $Self->{Translation}->{'Filter for Classes'} = 'クラスでフィルタ';
    $Self->{Translation}->{'Select a Class from the list to create a new Config Item.'} = '新規の構成アイテムを作成するには、リストからクラスを選択してください。';

    # Template: AgentITSMConfigItemBulk
    $Self->{Translation}->{'ITSM ConfigItem Bulk Action'} = '構成アイテム一括アクション';
    $Self->{Translation}->{'Deployment state'} = 'デプロイ・ステータス';
    $Self->{Translation}->{'Incident state'} = 'インシデント状況';
    $Self->{Translation}->{'Link to another'} = '他とリンクする';
    $Self->{Translation}->{'Invalid Configuration Item number!'} = '構成アイテムの値が不正です!';
    $Self->{Translation}->{'The number of another Configuration Item to link with.'} = '他の構成アイテムへのリンク数';

    # Template: AgentITSMConfigItemDelete
    $Self->{Translation}->{'Do you really want to delete this config item?'} = '本当にこの構成アイテムを削除しますか？';

    # Template: AgentITSMConfigItemEdit
    $Self->{Translation}->{'The name of this config item'} = 'この 構成アイテム の名称';
    $Self->{Translation}->{'Name is already in use by the ConfigItems with the following Number(s): %s'} =
        'この名称はすでに Number(s): %s の構成アイテムで使用中です。';

    # Template: AgentITSMConfigItemHistory
    $Self->{Translation}->{'History of Config Item: %s'} = '構成アイテムの履歴: %s';
    $Self->{Translation}->{'History Content'} = '履歴内容';
    $Self->{Translation}->{'Createtime'} = '作成日時';
    $Self->{Translation}->{'Zoom view'} = 'ズーム・ビュー';

    # Template: AgentITSMConfigItemOverviewNavBar
    $Self->{Translation}->{'Context Settings'} = 'コンテキストの設定';
    $Self->{Translation}->{'Config Items per page'} = '1ページ毎の設定項目';

    # Template: AgentITSMConfigItemOverviewSmall
    $Self->{Translation}->{'A generic ITSM Configuration Item table'} = 'ジェネリック構成アイテムのテーブル';

    # Template: AgentITSMConfigItemSearch
    $Self->{Translation}->{'Run Search'} = '検索を実行';
    $Self->{Translation}->{'Also search in previous versions?'} = 'プレビュー時、以前のバージョンも検索対象としますか？';

    # Template: AgentITSMConfigItemZoom
    $Self->{Translation}->{'Configuration Item'} = '構成アイテム';
    $Self->{Translation}->{'Configuration Item Information'} = '構成アイテム情報';
    $Self->{Translation}->{'Current Deployment State'} = '現在のデプロイ・ステータス';
    $Self->{Translation}->{'Last changed by'} = '最終変更者';
    $Self->{Translation}->{'Show one version'} = '説明を表示';
    $Self->{Translation}->{'Show all versions'} = 'すべての説明を表示';
    $Self->{Translation}->{'Version Incident State'} = 'インシデント状態';
    $Self->{Translation}->{'Version Deployment State'} = 'バージョンのデプロイ・ステータス';
    $Self->{Translation}->{'Version Number'} = 'バージョンナンバー';
    $Self->{Translation}->{'Configuration Item Version Details'} = '構成アイテムの詳細';
    $Self->{Translation}->{'Property'} = '項目';

    # Perl Module: Kernel/Modules/AgentITSMConfigItem.pm
    $Self->{Translation}->{'No access to Class is given!'} = 'クラスへのアクセス権はありません！';
    $Self->{Translation}->{'Overview: ITSM ConfigItem'} = '一覧: 構成アイテム';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemBulk.pm
    $Self->{Translation}->{'No ConfigItemID is given!'} = 'ConfigItemIDが指定されていません！';
    $Self->{Translation}->{'You need at least one selected Configuration Item!'} = '少なくとも1つの選択された構成アイテムが必要です！';
    $Self->{Translation}->{'You don\'t have write access to this configuration item: %s.'} =
        'この構成アイテムへの書き込みアクセス権がありません: %s';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemDelete.pm
    $Self->{Translation}->{'Config item "%s" not found in database!'} = '構成アイテム "%s"がデータベースに見つかりません！';
    $Self->{Translation}->{'Was not able to delete the configitem ID %s!'} = '構成アイテムID%sを削除できませんでした！';
    $Self->{Translation}->{'No version found for ConfigItemID %s!'} = 'ConfigItemID%sのバージョンが見つかりません！';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemEdit.pm
    $Self->{Translation}->{'No ConfigItemID, DuplicateID or ClassID is given!'} = 'ConfigItemID、DuplicateID、ClassIDは指定されていません！';
    $Self->{Translation}->{'No access is given!'} = 'アクセス権はありません！';
    $Self->{Translation}->{'No definition was defined for class %s!'} = 'クラス%sの定義が定義されていません！';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemHistory.pm
    $Self->{Translation}->{'Can\'t show history, no ConfigItemID is given!'} = '履歴を表示することはできませんが、ConfigItemIDは指定されていません！';
    $Self->{Translation}->{'Can\'t show history, no access rights given!'} = '履歴を表示することはできません。アクセス権は与えられていません！';
    $Self->{Translation}->{'New ConfigItem (ID=%s)'} = '新しい構成アイテム(ID=%s)';
    $Self->{Translation}->{'New version (ID=%s)'} = '新しいバージョン（ID =%s）';
    $Self->{Translation}->{'Deployment state updated (new=%s, old=%s)'} = 'デプロイ・ステータスが更新されました。（新規=%s、前=%s）';
    $Self->{Translation}->{'Incident state updated (new=%s, old=%s)'} = 'インシデント状態が更新されました（新規=%s、古い=%s）';
    $Self->{Translation}->{'ConfigItem (ID=%s) deleted'} = '構成アイテムを削除 (ID=%s)';
    $Self->{Translation}->{'Link to %s (type=%s) added'} = '%s（タイプ=%s）へのリンクが追加されました';
    $Self->{Translation}->{'Link to %s (type=%s) deleted'} = '%s（タイプ=%s）へのリンクが削除されました';
    $Self->{Translation}->{'ConfigItem definition updated (ID=%s)'} = 'ConfigItem定義が更新されました（ID =%s）';
    $Self->{Translation}->{'Name updated (new=%s, old=%s)'} = '名前が更新されました（新規=%s、古い=%s）';
    $Self->{Translation}->{'Attribute %s updated from "%s" to "%s"'} = '属性%sが "%s"から "%s"に更新されました';
    $Self->{Translation}->{'Version %s deleted'} = 'バージョン%sが削除されました';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemPrint.pm
    $Self->{Translation}->{'No ConfigItemID or VersionID is given!'} = 'ConfigItemIDまたはVersionIDは指定されていません！';
    $Self->{Translation}->{'Can\'t show config item, no access rights given!'} = '構成アイテムを表示できません。アクセス権はありません！';
    $Self->{Translation}->{'ConfigItemID %s not found in database!'} = 'ConfigItemID%sはデータベースに見つかりません！';
    $Self->{Translation}->{'VersionID %s not found in database!'} = 'VersionID%sはデータベースに見つかりません！';
    $Self->{Translation}->{'ConfigItem'} = '構成アイテム';
    $Self->{Translation}->{'printed by %s at %s'} = '%sで%sで印刷されました';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemSearch.pm
    $Self->{Translation}->{'Invalid ClassID!'} = 'ClassIDが無効です！';
    $Self->{Translation}->{'No ClassID is given!'} = 'ClassIDは指定されていません！';
    $Self->{Translation}->{'No access rights for this class given!'} = 'このクラスのアクセス権はありません！';
    $Self->{Translation}->{'No Result!'} = '結果がありません。';
    $Self->{Translation}->{'Config Item Search Results'} = '構成アイテムの検索結果';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemZoom.pm
    $Self->{Translation}->{'Can\'t show item, no access rights for ConfigItem are given!'} =
        '構成アイテムを表示できません。構成アイテムのアクセス権は与えられていません！';
    $Self->{Translation}->{'operational'} = '通常運用';
    $Self->{Translation}->{'warning'} = '警告';
    $Self->{Translation}->{'incident'} = 'インシデント';
    $Self->{Translation}->{'The deployment state of this config item'} = 'この構成アイテムのデプロイ・ステータス';
    $Self->{Translation}->{'The incident state of this config item'} = 'この構成アイテムのインシデント状態';

    # Perl Module: Kernel/Output/HTML/Dashboard/ITSMConfigItemGeneric.pm
    $Self->{Translation}->{'Shown config items'} = '';

    # Perl Module: Kernel/Output/HTML/ITSMConfigItem/LayoutDate.pm
    $Self->{Translation}->{'Between'} = 'この間';

    # Perl Module: Kernel/System/ImportExport/ObjectBackend/ITSMConfigItem.pm
    $Self->{Translation}->{'Maximum number of one element'} = '一エレメントあたりの最大数';
    $Self->{Translation}->{'Empty fields indicate that the current values are kept'} = '空欄の項目は現在の値が保持されること意味します';
    $Self->{Translation}->{'Skipped'} = 'スキップされました';

    # Perl Module: var/packagesetup/ITSMConfigurationManagement.pm
    $Self->{Translation}->{'Model'} = 'モデル';
    $Self->{Translation}->{'Customer Company'} = '顧客企業';
    $Self->{Translation}->{'Serial Number'} = 'シリアルナンバー';
    $Self->{Translation}->{'CPU'} = 'CPU';
    $Self->{Translation}->{'Ram'} = 'RAM';
    $Self->{Translation}->{'Hard Disk'} = 'ハードディスク';
    $Self->{Translation}->{'Capacity'} = '容量';
    $Self->{Translation}->{'Network Adapter'} = 'ネットワークアダプタ';
    $Self->{Translation}->{'IP over DHCP'} = 'DHCP有効';
    $Self->{Translation}->{'IP Address'} = 'IP アドレス';
    $Self->{Translation}->{'Graphic Adapter'} = 'グラフィックアダプタ';
    $Self->{Translation}->{'Other Equipment'} = 'その他の機器';
    $Self->{Translation}->{'Warranty Expiration Date'} = 'ワランティ終了日';
    $Self->{Translation}->{'Install Date'} = 'インストール日付';
    $Self->{Translation}->{'Phone 1'} = '電話 1';
    $Self->{Translation}->{'Phone 2'} = '電話 2';
    $Self->{Translation}->{'E-Mail'} = 'メールアドレス';
    $Self->{Translation}->{'Network Address'} = 'ネットワークアドレス';
    $Self->{Translation}->{'Subnet Mask'} = 'サブネットマスク';
    $Self->{Translation}->{'Gateway'} = 'ゲートウェイ';
    $Self->{Translation}->{'Licence Type'} = 'ライセンスタイプ';
    $Self->{Translation}->{'Licence Key'} = 'ライセンスキー';
    $Self->{Translation}->{'Quantity'} = '数量';
    $Self->{Translation}->{'Expiration Date'} = '有効期限';
    $Self->{Translation}->{'Media'} = 'メディア';

    # Database XML Definition: ITSMConfigurationManagement.sopm
    $Self->{Translation}->{'Computer'} = 'コンピューター';
    $Self->{Translation}->{'Hardware'} = 'ハードウェア';
    $Self->{Translation}->{'Network'} = 'ネットワーク';
    $Self->{Translation}->{'Software'} = 'ソフトウェア';
    $Self->{Translation}->{'Expired'} = '期限切れ';
    $Self->{Translation}->{'Maintenance'} = 'メンテナンス';
    $Self->{Translation}->{'Pilot'} = 'パイロット';
    $Self->{Translation}->{'Planned'} = '計画';
    $Self->{Translation}->{'Repair'} = '修理';
    $Self->{Translation}->{'Retired'} = '引退';
    $Self->{Translation}->{'Review'} = 'レビュー';
    $Self->{Translation}->{'Test/QA'} = 'テスト / QA';
    $Self->{Translation}->{'Laptop'} = 'ノートPC';
    $Self->{Translation}->{'Desktop'} = 'デスクトップ';
    $Self->{Translation}->{'PDA'} = 'PDA';
    $Self->{Translation}->{'Server'} = 'サーバ';
    $Self->{Translation}->{'Other'} = '他';
    $Self->{Translation}->{'Monitor'} = 'モニタ';
    $Self->{Translation}->{'Printer'} = 'プリンタ';
    $Self->{Translation}->{'Switch'} = 'スイッチ';
    $Self->{Translation}->{'Router'} = 'ルータ';
    $Self->{Translation}->{'WLAN Access Point'} = 'WLAN アクセスポイント';
    $Self->{Translation}->{'Security Device'} = 'セキュリティデバイス';
    $Self->{Translation}->{'Backup Device'} = 'バックアップ・デバイス';
    $Self->{Translation}->{'Mouse'} = 'マウス';
    $Self->{Translation}->{'Keyboard'} = 'キーボード';
    $Self->{Translation}->{'Camera'} = 'カメラ';
    $Self->{Translation}->{'Beamer'} = 'プロジェクター';
    $Self->{Translation}->{'Modem'} = 'モデム';
    $Self->{Translation}->{'PCMCIA Card'} = 'PCMCIA カード';
    $Self->{Translation}->{'USB Device'} = 'USBデバイス';
    $Self->{Translation}->{'Docking Station'} = 'ドッキングステーション';
    $Self->{Translation}->{'Scanner'} = 'スキャナ';
    $Self->{Translation}->{'Building'} = '構築';
    $Self->{Translation}->{'Office'} = '事務所';
    $Self->{Translation}->{'Floor'} = '切捨て';
    $Self->{Translation}->{'Room'} = '室内';
    $Self->{Translation}->{'Rack'} = 'ラック';
    $Self->{Translation}->{'Workplace'} = '職場';
    $Self->{Translation}->{'Outlet'} = 'アウトレット';
    $Self->{Translation}->{'IT Facility'} = 'ITファシリティ';
    $Self->{Translation}->{'LAN'} = 'LAN';
    $Self->{Translation}->{'WLAN'} = 'WLAN';
    $Self->{Translation}->{'Telco'} = '電話会社';
    $Self->{Translation}->{'GSM'} = 'GSM';
    $Self->{Translation}->{'Client Application'} = 'クライアントソフト';
    $Self->{Translation}->{'Middleware'} = 'ミドルウェア';
    $Self->{Translation}->{'Server Application'} = 'サーバソフト';
    $Self->{Translation}->{'Client OS'} = 'クライアントOS';
    $Self->{Translation}->{'Server OS'} = 'サーバOS';
    $Self->{Translation}->{'Admin Tool'} = '管理ツール';
    $Self->{Translation}->{'User Tool'} = 'ユーザ・ツール';
    $Self->{Translation}->{'Embedded'} = '埋め込みオブジェクト';
    $Self->{Translation}->{'Single Licence'} = 'シングルライセンス';
    $Self->{Translation}->{'Per User'} = 'ユーザ毎';
    $Self->{Translation}->{'Per Processor'} = 'プロセッサ毎';
    $Self->{Translation}->{'Per Server'} = 'サーバ毎';
    $Self->{Translation}->{'Per Node'} = 'ノード毎';
    $Self->{Translation}->{'Volume Licence'} = 'ボリュームライセンス';
    $Self->{Translation}->{'Enterprise Licence'} = 'エンタープライズ・ライセンス';
    $Self->{Translation}->{'Developer Licence'} = '開発者ライセンス';
    $Self->{Translation}->{'Demo'} = 'デモ';
    $Self->{Translation}->{'Time Restricted'} = '時間制限';
    $Self->{Translation}->{'Freeware'} = 'フリーウェア';
    $Self->{Translation}->{'Open Source'} = 'オープンソース';
    $Self->{Translation}->{'Unlimited'} = '無制限';

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

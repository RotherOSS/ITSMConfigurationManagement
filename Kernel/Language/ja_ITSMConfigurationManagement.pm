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

package Kernel::Language::ja_ITSMConfigurationManagement;

use strict;
use warnings;
use utf8;

sub Data {
    my $Self = shift;

    # Template: AdminITSMConfigItem
    $Self->{Translation}->{'Config Item Management'} = '構成アイテム管理';
    $Self->{Translation}->{'Change class definition'} = 'クラス定義を変更';
    $Self->{Translation}->{'Change role definition'} = '役割定義の変更';
    $Self->{Translation}->{'Ready2Import Class Bundles'} = 'Ready2Import クラスバンドル';
    $Self->{Translation}->{'Here you can import Ready2Import class bundles showcasing our most usual config items. Please note that some additional configuration may be required.'} =
        'ここでは、Ready2Importクラスバンドルをインポートすることができます。追加設定が必要な場合もありますのでご注意ください。';
    $Self->{Translation}->{'Update existing entities'} = '既存のエンティティの更新';
    $Self->{Translation}->{'Import Ready2Adopt class bundles'} = 'Ready2Adoptクラスのバンドルをインポートする';
    $Self->{Translation}->{'Config Item Class'} = '構成アイテムのクラス';
    $Self->{Translation}->{'Config Item Role'} = '設定項目 役割';

    # Template: AgentITSMConfigItemAdd
    $Self->{Translation}->{'Config Item'} = '構成アイテム';
    $Self->{Translation}->{'Filter for Classes'} = 'クラスでフィルタ';
    $Self->{Translation}->{'Select a Class from the list to create a new Config Item.'} = '新規の構成アイテムを作成するには、リストからクラスを選択してください。';
    $Self->{Translation}->{'Class'} = 'クラス';

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
    $Self->{Translation}->{'Version Number'} = 'バージョンナンバー';
    $Self->{Translation}->{'Version number of this config item'} = 'この設定項目のバージョン番号';
    $Self->{Translation}->{'Version Number is already in use by the ConfigItems with the following Number(s): %s'} =
        'バージョン番号は、以下の番号の ConfigItems によって既に使用されています: %s';
    $Self->{Translation}->{'Deployment State'} = 'デプロイ・ステータス';
    $Self->{Translation}->{'Incident State'} = 'インシデントのステータス';

    # Template: AgentITSMConfigItemHistory
    $Self->{Translation}->{'History of Config Item: %s'} = '構成アイテムの履歴: %s';
    $Self->{Translation}->{'History Content'} = '履歴内容';
    $Self->{Translation}->{'Createtime'} = '作成日時';
    $Self->{Translation}->{'Zoom view'} = 'ズーム・ビュー';

    # Template: AgentITSMConfigItemOverviewNavBar
    $Self->{Translation}->{'Config Items per page'} = '1ページ毎の設定項目';

    # Template: AgentITSMConfigItemOverviewSmall
    $Self->{Translation}->{'No config item data found.'} = '設定項目のデータが見つかりません。';
    $Self->{Translation}->{'Select this config item'} = 'この設定項目を選択する';

    # Template: AgentITSMConfigItemSearch
    $Self->{Translation}->{'Run Search'} = '検索を実行';
    $Self->{Translation}->{'Also search in previous versions?'} = 'プレビュー時、以前のバージョンも検索対象としますか？';

    # Template: AgentITSMConfigItemTreeView
    $Self->{Translation}->{'TreeView for ConfigItem'} = 'コンフィグ項目のツリービュー';
    $Self->{Translation}->{'Depth Level'} = 'デプスレベル';
    $Self->{Translation}->{'Zoom In/Out'} = 'ズームイン/ズームアウト';
    $Self->{Translation}->{'Max links level reached for ConfigItem!'} = 'ConfigItemの最大リンクレベルに達した！';

    # Template: AgentITSMConfigItemZoom
    $Self->{Translation}->{'Configuration Item'} = '構成アイテム';
    $Self->{Translation}->{'Configuration Item Information'} = '構成アイテム情報';
    $Self->{Translation}->{'Current Deployment State'} = '現在のデプロイ・ステータス';
    $Self->{Translation}->{'Current Incident State'} = '現在のインシデントのステータス';
    $Self->{Translation}->{'Last changed'} = '最終更新日時';
    $Self->{Translation}->{'Last changed by'} = '最終変更者';

    # Template: CustomerITSMConfigItem
    $Self->{Translation}->{'Your ConfigItems'} = '設定項目';

    # Template: CustomerITSMConfigItemSearch
    $Self->{Translation}->{'ConfigItem Search'} = '設定項目検索';

    # Template: AdminACL
    $Self->{Translation}->{'Object Type'} = 'オブジェクトの種類';

    # JS Template: ClassImportConfirm
    $Self->{Translation}->{'The following classes will be imported'} = '以下のクラスがインポートされる。';
    $Self->{Translation}->{'The following roles will be imported'} = '以下の役割がインポートされる。';
    $Self->{Translation}->{'Note that also corresponding dynamic fields and GeneralCatalog classes will be created and there is no automatic removal.'} =
        '対応するダイナミック・フィールドとGeneralCatalogクラスも作成され、自動的に削除されないことに注意してください。';
    $Self->{Translation}->{'Do you want to proceed?'} = '続行しますか？';

    # Perl Module: Kernel/Modules/AdminITSMConfigItem.pm
    $Self->{Translation}->{'Need ExampleClasses!'} = 'ExampleClassesが必要！';
    $Self->{Translation}->{'Definition is no valid YAML hash.'} = '定義は有効な YAML ハッシュではありません。';

    # Perl Module: Kernel/Modules/AgentITSMConfigItem.pm
    $Self->{Translation}->{'Overview: ITSM ConfigItem'} = '一覧: 構成アイテム';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemBulk.pm
    $Self->{Translation}->{'No ConfigItemID is given!'} = 'ConfigItemIDが指定されていません！';
    $Self->{Translation}->{'You need at least one selected Configuration Item!'} = '少なくとも1つの選択された構成アイテムが必要です！';
    $Self->{Translation}->{'You don\'t have write access to this configuration item: %s.'} =
        'この構成アイテムへの書き込みアクセス権がありません: %s';
    $Self->{Translation}->{'No definition was defined for class %s!'} = 'クラス%sの定義が定義されていません！';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemDelete.pm
    $Self->{Translation}->{'Config item "%s" not found in database!'} = '構成アイテム "%s"がデータベースに見つかりません！';
    $Self->{Translation}->{'Was not able to delete the configitem ID %s!'} = '構成アイテムID%sを削除できませんでした！';
    $Self->{Translation}->{'No version found for ConfigItemID %s!'} = 'ConfigItemID%sのバージョンが見つかりません！';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemEdit.pm
    $Self->{Translation}->{'No ConfigItemID, DuplicateID or ClassID is given!'} = 'ConfigItemID、DuplicateID、ClassIDは指定されていません！';
    $Self->{Translation}->{'No access is given!'} = 'アクセス権はありません！';

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
    $Self->{Translation}->{'ConfigItem'} = '構成アイテム';
    $Self->{Translation}->{'printed by %s at %s'} = '%sで%sで印刷されました';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemSearch.pm
    $Self->{Translation}->{'Invalid ClassID!'} = 'ClassIDが無効です！';
    $Self->{Translation}->{'No ClassID is given!'} = 'ClassIDは指定されていません！';
    $Self->{Translation}->{'No access rights for this class given!'} = 'このクラスのアクセス権はありません！';
    $Self->{Translation}->{'No Result!'} = '結果がありません！';
    $Self->{Translation}->{'Config Item Search Results'} = '構成アイテムの検索結果';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemZoom.pm
    $Self->{Translation}->{'Can\'t show item, no access rights for ConfigItem are given!'} =
        '構成アイテムを表示できません。構成アイテムのアクセス権は与えられていません！';
    $Self->{Translation}->{'ConfigItem not found!'} = 'ConfigItemが見つかりません！';
    $Self->{Translation}->{'No versions found!'} = 'バージョンは見つかりませんでした！';
    $Self->{Translation}->{'operational'} = '通常運用';
    $Self->{Translation}->{'warning'} = '警告';
    $Self->{Translation}->{'incident'} = 'インシデント';
    $Self->{Translation}->{'The deployment state of this config item'} = 'この構成アイテムのデプロイ・ステータス';
    $Self->{Translation}->{'The incident state of this config item'} = 'この構成アイテムのインシデント状態';

    # Perl Module: Kernel/Modules/CustomerITSMConfigItemSearch.pm
    $Self->{Translation}->{'No permission'} = '権限がありません';
    $Self->{Translation}->{'Filter invalid!'} = 'フィルター無効！';
    $Self->{Translation}->{'Search params invalid!'} = '検索パラメータが無効です！';

    # Perl Module: Kernel/Output/HTML/Dashboard/ITSMConfigItemGeneric.pm
    $Self->{Translation}->{'Shown config items'} = '表示される構成アイテム';
    $Self->{Translation}->{'Deployment State Type'} = 'デプロイ・ステータスのタイプ';
    $Self->{Translation}->{'Current Incident State Type'} = '現在のインシデント・ステータスのタイプ';

    # Perl Module: Kernel/Output/HTML/ITSMConfigItem/LayoutDate.pm
    $Self->{Translation}->{'Between'} = 'この間';

    # Perl Module: Kernel/System/DynamicField/Driver/ConfigItem.pm
    $Self->{Translation}->{'Class restrictions for the config item'} = '設定項目のクラス制限';
    $Self->{Translation}->{'Select one or more classes to restrict selectable config items'} =
        '選択可能な設定項目を制限するために、1つ以上のクラスを選択します。';
    $Self->{Translation}->{'Link type'} = 'リンクタイプ';
    $Self->{Translation}->{'Select the link type.'} = 'リンクタイプを選択します。';
    $Self->{Translation}->{'Forwards: Referencing (Source) -> Referenced (Target)'} = 'フォワード参照（ソース） -> 参照（ターゲット）';
    $Self->{Translation}->{'Backwards: Referenced (Source) -> Referencing (Target)'} = '後方：参照（ソース） -> 参照（ターゲット）';
    $Self->{Translation}->{'Link Direction'} = 'リンク方向';
    $Self->{Translation}->{'The referencing object is the one containing this dynamic field, the referenced object is the one selected as value of the dynamic field.'} =
        '参照するオブジェクトはこのダイナミック・フィールドを含むもので、参照されるオブジェクトはダイナミック・フィールドの値として選択されたものです。';
    $Self->{Translation}->{'Dynamic (ConfigItem)'} = '動的 (コンフィグ項目)';
    $Self->{Translation}->{'Static (Version)'} = 'スタティック（ヴァージョン）';
    $Self->{Translation}->{'Link Referencing Type'} = 'リンク参照タイプ';
    $Self->{Translation}->{'Whether this link applies to the ConfigItem or the static version of the referencing object. Current Incident State calculation only is performed on dynamic links.'} =
        'このリンクが参照オブジェクトの ConfigItem と静的バージョンのどちらに適用されるか。現在のインシデント・ステートの計算は、ダイナミック・リンクに対してのみ実行されます。';
    $Self->{Translation}->{'Select the attribute which config items will be searched by'} = '設定項目を検索する属性を選択します。';

    # Perl Module: Kernel/System/ITSMConfigItem/Definition.pm
    $Self->{Translation}->{'Starting the YAML string with \'---\' is required.'} = 'YAML文字列を\'---\'で始めることが必要です。';

    # Perl Module: Kernel/System/ITSMConfigItem/Link.pm
    $Self->{Translation}->{'Could not purge the table configitem_link.'} = 'configitem_link テーブルをパージできませんでした。';
    $Self->{Translation}->{'No relevant dynamic fields were found'} = '関連する動的フィールドは見つかりませんでした';
    $Self->{Translation}->{'Could not insert into the table configitem_link'} = 'configitem_linkテーブルに挿入できませんでした。';
    $Self->{Translation}->{'Inserted 0 rows into the table configitem_link'} = 'configitem_linkテーブルに0行を挿入。';

    # Perl Module: Kernel/System/ImportExport/ObjectBackend/ITSMConfigItem.pm
    $Self->{Translation}->{'Maximum number of one element'} = '一エレメントあたりの最大数';
    $Self->{Translation}->{'Empty fields indicate that the current values are kept'} = '空欄の項目は現在の値が保持されること意味します';
    $Self->{Translation}->{'Skipped'} = 'スキップされました';

    # Perl Module: Kernel/Modules/AdminDynamicField.pm
    $Self->{Translation}->{'Error synchronizing the definitions. Please check the log.'} = '定義の同期にエラーが発生しました。ログを確認してください。';
    $Self->{Translation}->{'You have ITSMConfigItem definitions which are not synchronized. Please deploy your ITSMConfigItem dynamic field changes.'} =
        'ITSMConfigItemの定義が同期されていません。ITSMConfigItemの動的フィールドの変更を展開してください。';

    # Database XML / SOPM Definition: ITSMConfigurationManagement.sopm
    $Self->{Translation}->{'Expired'} = '期限切れ';
    $Self->{Translation}->{'Maintenance'} = 'メンテナンス';
    $Self->{Translation}->{'Pilot'} = 'パイロット';
    $Self->{Translation}->{'Planned'} = '計画';
    $Self->{Translation}->{'Repair'} = '修理';
    $Self->{Translation}->{'Retired'} = '引退';
    $Self->{Translation}->{'Review'} = 'レビュー';
    $Self->{Translation}->{'Test/QA'} = 'テスト / QA';

    # JS File: ITSM.Admin.ITSMConfigItem
    $Self->{Translation}->{'Overview and Confirmation'} = '概要と確認';
    $Self->{Translation}->{'Importing classes/roles and their related fields'} = 'クラス/役割とその関連フィールドのインポート';
    $Self->{Translation}->{'An error occurred during class import.'} = 'クラスのインポート中にエラーが発生しました。';

    # SysConfig
    $Self->{Translation}->{'0 - Hidden'} = '0 - 非表示';
    $Self->{Translation}->{'1 - Shown'} = '1 - 表示';
    $Self->{Translation}->{'Allows extended search conditions in config item search of the agent interface. With this feature you can search e. g. config item name with this kind of conditions like "(*key1*&&*key2*)" or "(*key1*||*key2*)".'} =
        'エージェントインタフェースの設定項目検索において、拡張検索条件を許可します。この機能により、"(*key1*&*key2*) "や"(*key1*|*key2*) "のような条件で設定項目名を検索することができます。';
    $Self->{Translation}->{'Allows extended search conditions in config item search of the customer interface. With this feature you can search e. g. config item name with this kind of conditions like "(*key1*&&*key2*)" or "(*key1*||*key2*)".'} =
        'カスタマーインターフェイスの設定項目検索において、検索条件を拡張することができます。この機能を使用すると、"(*key1*&*key2*) "または"(*key1*|*key2*) "のような条件で設定項目名を検索できます。';
    $Self->{Translation}->{'Assigned CIs'} = '割り当てられたCI';
    $Self->{Translation}->{'CIs assigned to customer company'} = '顧客企業に割り当てられたCI';
    $Self->{Translation}->{'CIs assigned to customer user'} = '顧客ユーザーに割り当てられたCI';
    $Self->{Translation}->{'CMDB Settings'} = 'CMDBの設定';
    $Self->{Translation}->{'Check for a unique name only within the same ConfigItem class (\'class\') or globally (\'global\'), which means every existing ConfigItem is taken into account when looking for duplicates.'} =
        '同じConfigItemクラス（ \'class\'）内またはグローバル（ \'global\'）内でのみ一意の名前を確認します。これは、重複を検索するときに既存のConfigItemがすべて考慮されることを意味します。';
    $Self->{Translation}->{'Choose a module to enforce a naming scheme.'} = '命名スキームを強制するモジュールを選択する。';
    $Self->{Translation}->{'Choose a module to enforce a number scheme.'} = '番号スキームを強制するモジュールを選択する。';
    $Self->{Translation}->{'Choose a module to enforce a version string scheme.'} = 'バージョン文字列スキームを強制するモジュールを選択する。';
    $Self->{Translation}->{'Choose attributes to trigger the creation of a new version.'} = '新しいバージョンを作成するトリガーとなる属性を選択する。';
    $Self->{Translation}->{'Choose categories to assign to this config item class.'} = 'この設定項目クラスに割り当てるカテゴリを選択します。';
    $Self->{Translation}->{'Column config item filters for ConfigItem Overview.'} = 'ConfigItem概要のカラム設定項目フィルタ。';
    $Self->{Translation}->{'Columns that can be filtered in the config item overview of the agent interface. Note: Only Config Item attributes and Dynamic Fields (DynamicField_NameX) are allowed.'} =
        'エージェントインタフェースの設定項目概要でフィルタリングできる列。注意: コンフィグ項目属性と動的フィールド (DynamicField_NameX) のみ許可されます。';
    $Self->{Translation}->{'Columns that can be filtered in the config item overview of the customer interface. Note: Only Config Item attributes and Dynamic Fields (DynamicField_NameX) are allowed.'} =
        'カスタマー・インターフェースの構成項目概要でフィルタリングできる列。注: コンフィグ項目属性とダイナミック・フィールド (DynamicField_NameX) のみ許可されます。';
    $Self->{Translation}->{'Columns that can be filtered in the config item search result overview of the agent interface. Note: Only Config Item attributes and Dynamic Fields (DynamicField_NameX) are allowed.'} =
        'エージェントインタフェースの設定項目検索結果の概要でフィルタリングできる列。注意: コンフィグ項目属性と動的フィールド (DynamicField_NameX) のみ許可されます。';
    $Self->{Translation}->{'Config Items'} = '構成アイテム';
    $Self->{Translation}->{'Config item add.'} = '構成アイテムを追加します。';
    $Self->{Translation}->{'Config item edit.'} = '構成アイテムを修正します。';
    $Self->{Translation}->{'Config item event module that enables logging to history in the agent interface.'} =
        '担当者Webインタフェースの履歴を記録する構成アイテムのイベントモジュール';
    $Self->{Translation}->{'Config item event module that updates config items to their current definition.'} =
        'コンフィグ項目を現在の定義に更新するコンフィグ項目イベントモジュール。';
    $Self->{Translation}->{'Config item event module that updates the table configitem_ĺink.'} =
        'configitem_ĺinkテーブルを更新する設定項目イベント・モジュール。';
    $Self->{Translation}->{'Config item event module updates the current incident state.'} =
        'コンフィグ・アイテム・イベント・モジュールは、現在のインシデント状態を更新する。';
    $Self->{Translation}->{'Config item history.'} = '構成アイテムの履歴';
    $Self->{Translation}->{'Config item print.'} = '構成アイテムを印刷';
    $Self->{Translation}->{'Config item zoom.'} = '構成アイテムのズーム';
    $Self->{Translation}->{'ConfigItem Tree View'} = '設定項目ツリービュー';
    $Self->{Translation}->{'ConfigItem Version'} = '設定項目バージョン';
    $Self->{Translation}->{'ConfigItems of the following classes will not be stored on the Elasticsearch server. To apply this to existing CIs, the CI migration has to be run via console, after changing this option.'} =
        '以下のクラスのConfigItemsはElasticsearchサーバに保存されません。既存のCIに適用するには、このオプションを変更した後に、コンソール経由でCIマイグレーションを実行する必要があります。';
    $Self->{Translation}->{'ConfigItems with the following deployment states will not be stored on the Elasticsearch server. To apply this to existing CIs, the CI migration has to be run via console, after changing this option.'} =
        '以下のデプロイ状態のConfigItemsは、Elasticsearchサーバに保存されません。既存のCIに適用するには、このオプションを変更した後に、コンソール経由でCIマイグレーションを実行する必要があります。';
    $Self->{Translation}->{'Configuration Item Limit'} = '構成アイテムの制限';
    $Self->{Translation}->{'Configuration Item limit per page.'} = 'ページあたりの構成アイテムの表示制限';
    $Self->{Translation}->{'Configuration Management Database.'} = '構成管理データベース';
    $Self->{Translation}->{'Configuration item bulk module.'} = '構成アイテムの一括モジュール';
    $Self->{Translation}->{'Configuration item search backend router of the agent interface.'} =
        '担当者インターフェースの構成アイテムの検索バックエンドルーター';
    $Self->{Translation}->{'Create and manage the definitions for Configuration Items.'} = '構成アイテムの作成と管理します。';
    $Self->{Translation}->{'Customers can see historic CI versions.'} = '顧客は過去のCIバージョンを見ることができる。';
    $Self->{Translation}->{'Customers have the possibility to manually switch between historic CI versions.'} =
        '顧客は、過去のCIバージョンを手動で切り替えることができる。';
    $Self->{Translation}->{'Default data to use on attribute for config item search screen. Example: "ITSMConfigItemCreateTimePointFormat=year;ITSMConfigItemCreateTimePointStart=Last;ITSMConfigItemCreateTimePoint=2;".'} =
        '設定項目検索画面の属性で使用するデフォルトデータ。例："ITSMConfigItemCreateTimePointFormat=year;ITSMConfigItemCreateTimePointStart=Last;ITSMConfigItemCreateTimePoint=2;"。';
    $Self->{Translation}->{'Default data to use on attribute for config item search screen. Example: "ITSMConfigItemCreateTimeStartYear=2010;ITSMConfigItemCreateTimeStartMonth=10;ITSMConfigItemCreateTimeStartDay=4;ITSMConfigItemCreateTimeStopYear=2010;ITSMConfigItemCreateTimeStopMonth=11;ITSMConfigItemCreateTimeStopDay=3;".'} =
        'コンフィグ項目検索画面の属性で使用するデフォルトデータ。例："ITSMConfigItemCreateTimeStartYear=2010;ITSMConfigItemCreateTimeStartMonth=10;ITSMConfigItemCreateTimeStartDay=4;ITSMConfigItemCreateTimeStopYear=2010;ITSMConfigItemCreateTimeStopMonth=11;ITSMConfigItemCreateTimeStopDay=3;"。';
    $Self->{Translation}->{'Define Actions where a settings button is available in the linked objects widget (LinkObject::ViewMode = "complex"). Please note that these Actions must have registered the following JS and CSS files: Core.AllocationList.css, Core.UI.AllocationList.js, Core.UI.Table.Sort.js, Core.Agent.TableFilters.js and Core.Agent.LinkObject.js.'} =
        'リンクオブジェクトウィジェット（LinkObject :: ViewMode = "complex"）で設定ボタンを使用できるアクションを定義します。 これらのアクションは、次のJSおよびCSSファイルを登録している必要があります。Core.AllocationList.css、Core.UI.AllocationList.js、Core.UI.Table.Sort.js、Core.Agent.TableFilters.js、及びCore.Agent .LinkObject.js';
    $Self->{Translation}->{'Define a Template::Toolkit scheme for version strings. Only used if Version String Module is set to TemplateToolkit.'} =
        'バージョン文字列用の Template::Toolkit スキームを定義します。バージョン文字列モジュールが TemplateToolkit に設定されている場合にのみ使用されます。';
    $Self->{Translation}->{'Define a set of conditions under which a customer is allowed to see a config item. Conditions can optionally be restricted to certain customer groups. Name is the only mandatory attribute. If no other options are given, all config items will be visible under that category.'} =
        '顧客が設定項目を見ることを許可される一連の条件を定義します。条件は、オプションで特定の顧客グループに制限することができます。名前は唯一の必須属性です。他のオプションが指定されていない場合、すべての設定項目がそのカテゴリの下に表示されます。';
    $Self->{Translation}->{'Defines Required permissions to create ITSM configuration items using the Generic Interface.'} =
        'ジェネリックインターフェイスを活用して構成アイテムを作成する権限を定義する。';
    $Self->{Translation}->{'Defines Required permissions to delete ITSM configuration items using the Generic Interface.'} =
        'ジェネリック・インターフェースを活用して構成アイテムを削除するために必要な権限を定義します。';
    $Self->{Translation}->{'Defines Required permissions to get ITSM configuration items using the Generic Interface.'} =
        'ジェネリックインターフェイスを活用して構成アイテムを取得する権限を定義する。';
    $Self->{Translation}->{'Defines Required permissions to search ITSM configuration items using the Generic Interface.'} =
        'ジェネリックインターフェイスを活用して構成アイテムを検索する権限を定義する。';
    $Self->{Translation}->{'Defines Required permissions to update ITSM configuration items using the Generic Interface.'} =
        'ジェネリックインターフェイスを活用して構成アイテムを変更する権限を定義する。';
    $Self->{Translation}->{'Defines an overview module to show the small view of a configuration item list.'} =
        '構成アイテムを定義して、構成アイテムのリストの小さなビューを表示します。';
    $Self->{Translation}->{'Defines if the link type labels must be shown in the node connections.'} =
        'ノードの接続にリンクタイプのラベルを表示するかどうかを定義します。';
    $Self->{Translation}->{'Defines regular expressions individually for each ConfigItem class to check the ConfigItem name and to show corresponding error messages.'} =
        '各ConfigItemクラスの正規表現を個別に定義して、ConfigItem名を確認し、対応するエラーメッセージを表示します。';
    $Self->{Translation}->{'Defines the available columns of CIs in the config item overview depending on the CI class. Each entry must consist of a class name and an array of available fields for the corresponding class. Dynamic field entries have to honor the scheme DynamicField_FieldName.'} =
        'CIクラスに応じて、設定項目の概要で利用可能なCIの列を定義します。各項目は、クラス名と、対応するクラスで利用可能なフィールドの配列から構成されなければなりません。動的フィールドのエントリは、DynamicField_FieldName スキームに従わなければなりません。';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of the agent interface.'} =
        'エージェントインタフェースの設定項目検索結果の設定項目ソートのデフォルトの設定項目属性を定義します。';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of the customer interface.'} =
        '顧客インタフェースの設定項目検索結果の設定項目ソートのデフォルトの設定項目属性を定義します。';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of this operation.'} =
        'この操作のコンフィグ項目検索結果のコンフィグ項目ソートのデフォルトのコンフィグ項目属性を定義します。';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the agent interface. Up: oldest on top. Down: latest on top.'} =
        'エージェントインタフェースの設定項目検索結果のデフォルトの設定項目順序を定義します。上: 最も古いものが上。Down: 最新が上。';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the customer interface. Up: oldest on top. Down: latest on top.'} =
        'カスタマインタフェースの設定項目検索結果のデフォルトの設定項目順序を定義します。上: 古い順に表示されます。下：最新が上。';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the this operation. Up: oldest on top. Down: latest on top.'} =
        'この操作のコンフィグ項目検索結果のデフォルトのコンフィグ項目順序を定義します。Up:古い順。Down：最新が上。';
    $Self->{Translation}->{'Defines the default displayed columns of CIs in the config item overview depending on the CI class. Each entry must consist of a class name and an array of available fields for the corresponding class. Dynamic field entries have to honor the scheme DynamicField_FieldName.'} =
        'CIクラスに応じて、設定項目の概要に表示されるCIのデフォルトの列を定義します。各項目は、クラス名と、対応するクラスで利用可能なフィールドの配列から構成されなければなりません。動的フィールドのエントリは、DynamicField_FieldNameスキームに従わなければなりません。';
    $Self->{Translation}->{'Defines the default relations depth to be shown.'} = '表示されるデフォルトの関係の深さを定義する。';
    $Self->{Translation}->{'Defines the default shown config item search attribute for config item search screen.'} =
        '設定項目検索画面のデフォルトの表示設定項目検索属性を定義します。';
    $Self->{Translation}->{'Defines the default shown config item search attribute for config item search screen. Example: "Key" must have the name of the Dynamic Field in this case \'X\', "Content" must have the value of the Dynamic Field depending on the Dynamic Field type,  Text: \'a text\', Dropdown: \'1\', Date/Time: \'Search_DynamicField_XTimeSlotStartYear=1974; Search_DynamicField_XTimeSlotStartMonth=01; Search_DynamicField_XTimeSlotStartDay=26; Search_DynamicField_XTimeSlotStartHour=00; Search_DynamicField_XTimeSlotStartMinute=00; Search_DynamicField_XTimeSlotStartSecond=00; Search_DynamicField_XTimeSlotStopYear=2013; Search_DynamicField_XTimeSlotStopMonth=01; Search_DynamicField_XTimeSlotStopDay=26; Search_DynamicField_XTimeSlotStopHour=23; Search_DynamicField_XTimeSlotStopMinute=59; Search_DynamicField_XTimeSlotStopSecond=59;\' and or \'Search_DynamicField_XTimePointFormat=week; Search_DynamicField_XTimePointStart=Before; Search_DynamicField_XTimePointValue=7\';.'} =
        'コンフィグ項目検索画面にデフォルトで表示されるコンフィグ項目検索属性を定義します。例: "Key "にはダイナミック・フィールドの名前 (この場合は \'X\')、"Content" にはダイナミック・フィールドのタイプに応じてダイナミック・フィールドの値、Text: \'a text\'、Dropdown: \'1\'、Date/Time：\'Search_DynamicField_XTimeSlotStartYear=1974; Search_DynamicField_XTimeSlotStartMonth=01; Search_DynamicField_XTimeSlotStartDay=26; Search_DynamicField_XTimeSlotStartHour=00；Search_DynamicField_XTimeSlotStartMinute=00; Search_DynamicField_XTimeSlotStartSecond=00; Search_DynamicField_XTimeSlotStopYear=2013; Search_DynamicField_XTimeSlotStopMonth=01；Search_DynamicField_XTimeSlotStopDay=26; Search_DynamicField_XTimeSlotStopHour=23; Search_DynamicField_XTimeSlotStopMinute=59; Search_DynamicField_XTimeSlotStopSecond=59；\'、または \'Search_DynamicField_XTimePointFormat=week; Search_DynamicField_XTimePointStart=Before; Search_DynamicField_XTimePointValue=7\';.';
    $Self->{Translation}->{'Defines the default subobject of the class \'ITSMConfigItem\'.'} =
        '構成アイテムのクラスのデフォルトのサブオブジェクトを定義する。';
    $Self->{Translation}->{'Defines the number of rows for the CI definition editor in the admin interface.'} =
        '管理インターフェイス Cl 定義エディタの行数を定義する。';
    $Self->{Translation}->{'Defines the order of incident states from high (e.g. cricital) to low (e.g. functional).'} =
        'インシデント状態の高（例: 危険）から低（例: 情報）へのインシデント状態の順序を定義する。';
    $Self->{Translation}->{'Defines the relevant deployment states where linked tickets can affect the status of a CI.'} =
        'リンクされたチケットがCIのステータスに影響を与える可能性がある、関連するデプロイ・ステータスを定義します。';
    $Self->{Translation}->{'Defines the search limit for the AgentITSMConfigItem screen.'} =
        '構成アイテムの画面の検索制限を定義します。';
    $Self->{Translation}->{'Defines the search limit for the AgentITSMConfigItemSearch screen.'} =
        '構成アイテムの検索画面の検索制限を定義します。';
    $Self->{Translation}->{'Defines the search limit for the CustomerITSMConfigItem screen.'} =
        'CustomerITSMConfigItem 画面の検索制限を定義します。';
    $Self->{Translation}->{'Defines the search limit for the CustomerITSMConfigItemSearch screen.'} =
        'CustomerITSMConfigItemSearch 画面の検索制限を定義します。';
    $Self->{Translation}->{'Defines the shown columns of CIs in the link table complex view for all CI classes. If there is no entry, then the default columns are shown.'} =
        '全ての CI クラスのリンク テーブル複合ビューに表示される CI の列を定義します。 エントリがない場合は、デフォルトの列が表示されます。';
    $Self->{Translation}->{'Defines the shown columns of CIs in the link table complex view, depending on the CI class. Each entry must be prefixed with the class name and double colons (i.e. Computer::). There are a few CI-Attributes that common to all CIs (example for the class Computer: Computer::Name, Computer::CurDeplState, Computer::CreateTime). To show individual CI-Attributes as defined in the CI-Definition, the following scheme must be used (example for the class Computer): Computer::HardDisk::1, Computer::HardDisk::1::Capacity::1, Computer::HardDisk::2, Computer::HardDisk::2::Capacity::1. If there is no entry for a CI class, then the default columns are shown.'} =
        'CI クラスに応じて、リンク テーブル複合ビューに表示される CI の列を定義します。 各エントリには、クラス名と二重コロンを接頭辞として付ける必要があります (例: Computer::)。全ての CI に共通する CI 属性がいくつかあります。 (クラス Computer の例: Computer::Name、Computer::CurDeplState、Computer::CreateTime)　 CI 定義で定義されている個々の CI 属性を表示するには、次のスキームを使用する必要があります (クラス Computer の例): Computer::HardDisk::1、Computer::HardDisk::1::Capacity::1　 CI クラスのエントリがない場合は、デフォルトの列が表示されます。';
    $Self->{Translation}->{'Defines which items are available for \'Action\' in third level of the ITSM Config Item ACL structure.'} =
        'ITSM 構成項目 ACL 構造の第 3 レベルで、「アクション」に使用できる項目を定義します。';
    $Self->{Translation}->{'Defines which items are available in first level of the ITSM Config Item ACL structure.'} =
        'ITSM 構成項目 ACL 構造の第 1 レベルで利用可能な項目を定義します。';
    $Self->{Translation}->{'Defines which items are available in second level of the ITSM Config Item ACL structure.'} =
        'ITSM 構成項目 ACL 構造の第 2 レベルで利用可能な項目を定義します。';
    $Self->{Translation}->{'Defines which type of link (named from the ticket perspective) can affect the status of a linked CI.'} =
        'リンクされたCIのステータスに影響するリンクのタイプ（チケットの観点から名前が付けられます）を定義します。';
    $Self->{Translation}->{'Defines which type of ticket can affect the status of a linked CI.'} =
        'リンクされたCIのステータスに影響するチケットのタイプを定義します。';
    $Self->{Translation}->{'Definition Update'} = '定義の更新';
    $Self->{Translation}->{'Delete Configuration Item'} = '構成アイテムを削除';
    $Self->{Translation}->{'DeplState'} = 'デプルステート';
    $Self->{Translation}->{'Deployment State Color'} = 'デプロイ・ステータスのカラー';
    $Self->{Translation}->{'DeploymentState'} = '展開状態';
    $Self->{Translation}->{'Duplicate'} = 'コピー';
    $Self->{Translation}->{'Dynamic field event module that marks config item definitions as out of sync, if containing dynamic fields change.'} =
        'ダイナミック・フィールド・イベント・モジュールは、ダイナミック・フィールドが変更された場合、コンフィグ・アイテムの定義が同期されていないとマークします。';
    $Self->{Translation}->{'Dynamic fields shown in the additional ITSM field screen of the agent interface.'} =
        '担当者インターフェイスの ITSMフィールド画面に表示するダイナミック・フィールド';
    $Self->{Translation}->{'Dynamic fields shown in the config item overview screen of the customer interface.'} =
        '顧客インターフェースの設定項目概要画面に表示される動的フィールド。';
    $Self->{Translation}->{'Dynamic fields shown in the config item search screen of the agent interface.'} =
        'エージェントインターフェースの設定項目検索画面に表示される動的フィールド。';
    $Self->{Translation}->{'Enables configuration item bulk action feature for the agent frontend to work on more than one configuration item at a time.'} =
        '担当者フロントエンドが一度に複数の設定項目で機能するように設定項目一括操作機能を有効にします。';
    $Self->{Translation}->{'Enables configuration item bulk action feature only for the listed groups.'} =
        'リストされたグループの構成アイテム一括処理機能のみを有効にします。';
    $Self->{Translation}->{'Enables/disables the functionality to check ITSM onfiguration items for unique names. Before enabling this option you should check your system for already existing config items with duplicate names. You can do this with the console command Admin::ITSM::Configitem::ListDuplicates.'} =
        'ITSMの設定項目が一意な名前であるかどうかをチェックする機能の有効/無効を設定します。このオプションを有効にする前に、重複した名前を持つ既存の設定項目がないかシステムをチェックする必要があります。これは、コンソールコマンド Admin::ITSM::Configitem::ListDuplicates で実行できます。';
    $Self->{Translation}->{'Event module to set configitem-status on ticket-configitem-link.'} =
        'チケット構成アイテムのリンクに構成アイテムのステータスを設定するイベントモジュール';
    $Self->{Translation}->{'Fields of the configuration item index, used for the fulltext search. Fields are also stored, but are not mandatory for the overall functionality. Inclusion of attachments can be disabled by setting the entry to 0 or deleting it.'} =
        '全文検索に使用される設定項目インデックスのフィールド。フィールドも保存されますが、全体的な機能には必須ではありません。エントリを 0 に設定するか、削除することで、添付ファイルのインクルードを無効にすることができます。';
    $Self->{Translation}->{'Fields stored in the configuration item index which are used for other things besides fulltext searches. For the complete functionality all fields are mandatory.'} =
        '設定項目インデックスに格納されるフィールドで、全文検索以外に使用される。完全な機能のために、すべてのフィールドは必須です。';
    $Self->{Translation}->{'For every webservice (key) an array of classes (value) can be defined on which the import is restricted. For all chosen classes, or all existing classes the identifying attributes will have to be chosen in the invoker config.'} =
        '各Webサービス(キー)に対して、インポートを制限するクラスの配列(値)を定義することができます。選択されたすべてのクラス、あるいは既存のすべてのクラスについて、インボーカの設定で識別属性を選択する必要があります。';
    $Self->{Translation}->{'GenericInterface module registration for the ConfigItemFetch invoker layer.'} =
        'ConfigItemFetch invokerレイヤーのGenericInterfaceモジュール登録。';
    $Self->{Translation}->{'ITSM ConfigItem'} = 'ITSM 設定項目';
    $Self->{Translation}->{'ITSM config item overview.'} = '構成アイテムの一覧';
    $Self->{Translation}->{'InciState'} = 'インシステート';
    $Self->{Translation}->{'IncidentState'} = 'インシデントステート';
    $Self->{Translation}->{'Includes deployment states in the config item search of the customer interface.'} =
        'カスタマーインターフェースの設定項目検索にデプロイメントステートが含まれるようになりました。';
    $Self->{Translation}->{'Includes incident states in the config item search of the customer interface.'} =
        'カスタマーインターフェースの設定項目検索にインシデント状態を含める。';
    $Self->{Translation}->{'Maximum number of config items to be displayed in the result of this operation.'} =
        'この操作の結果に表示されるコンフィグ項目の最大数。';
    $Self->{Translation}->{'Module to check the group responsible for a class.'} = 'クラスを担当するグループをチェックするモジュール';
    $Self->{Translation}->{'Module to check the group responsible for a configuration item.'} =
        '構成アイテムを担当するグループをチェックするモジュール';
    $Self->{Translation}->{'Module to generate ITSM config item statistics.'} = '構成タイテムのレポートを生成するためのモジュール';
    $Self->{Translation}->{'Name Module'} = '名前モジュール';
    $Self->{Translation}->{'Number Module'} = 'ナンバー・モジュール';
    $Self->{Translation}->{'Number of config items to be displayed in each page of a search result in the agent interface.'} =
        'エージェントインターフェースの検索結果の各ページに表示される設定項目の数。';
    $Self->{Translation}->{'Number of config items to be displayed in each page of a search result in the customer interface.'} =
        'カスタマーインターフェースの検索結果の各ページに表示される設定項目の数。';
    $Self->{Translation}->{'Objects to search for, how many entries and which attributs to show. ConfigItem attributes have to explicitly be stored via Elasticsearch.'} =
        '検索するオブジェクト、エントリ数、表示する属性。ConfigItem の属性は、明示的に Elasticsearch 経由で保存する必要があります。';
    $Self->{Translation}->{'Overview.'} = '概要';
    $Self->{Translation}->{'Parameters for the categories for config item classes in the preferences view of the agent interface.'} =
        'エージェントインタフェースの環境設定ビューの設定項目クラスのカテゴリのパラメータ。';
    $Self->{Translation}->{'Parameters for the column filters of the small config item overview. Please note: setting \'Active\' to 0 will only prevent agents from editing settings of this group in their personal preferences, but will still allow administrators to edit the settings of another user\'s behalf. Use \'PreferenceGroup\' to control in which area these settings should be shown in the user interface.'} =
        '小設定項目概要の列フィルタ用のパラメータです。注意: \'Active\' を 0 に設定すると、エージェントは個人設定でこのグループの設定を編集できなくなりますが、管理者は他のユーザの設定を編集することができます。PreferenceGroup\' を使用して、これらの設定をユーザインターフェイスのどのエリアに表示するかを制御します。';
    $Self->{Translation}->{'Parameters for the dashboard backend of the customer company config item overview of the agent interface . "Limit" is the number of entries shown by default. "Group" is used to restrict the access to the plugin (e. g. Group: admin;group1;group2;). "Default" determines if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" is the cache time in minutes for the plugin.'} =
        '担当者インターフェイスの顧客企業の構成アイテムの概要のダッシュボード バックエンドのパラメーター。 「制限」は、デフォルトで表示されるエントリの数です。 「グループ」はプラグインへのアクセスを制限するために使用されます。 (例: グループ: admin;group1;group2;)　「デフォルト」は、プラグインがデフォルトで有効になっているか、ユーザーが手動で有効にする必要があるかを決定します。 「CacheTTLLocal」は、プラグインのキャッシュ時間 (分単位) です。';
    $Self->{Translation}->{'Parameters for the deployment states color in the preferences view of the agent interface.'} =
        'デプロイメントのパラメータは、担当者Webインタフェースの環境設定ビューで色を示します。';
    $Self->{Translation}->{'Parameters for the deployment states in the preferences view of the agent interface.'} =
        '担当者Webインタフェースの環境設定ビューでデプロイ状態のパラメータ';
    $Self->{Translation}->{'Parameters for the example permission groups of the general catalog attributes.'} =
        'ジェネラル・カタログの属性の権限グループの設定値例です。';
    $Self->{Translation}->{'Parameters for the name module for config item classes in the preferences view of the agent interface.'} =
        'エージェントインタフェースの環境設定ビューの設定項目クラスの名前モジュールのパラメータ。';
    $Self->{Translation}->{'Parameters for the number module for config item classes in the preferences view of the agent interface.'} =
        'エージェントインタフェースの環境設定ビューの設定項目クラスの番号モジュールのパラメータ。';
    $Self->{Translation}->{'Parameters for the pages (in which the configuration items are shown).'} =
        'ページのパラメータ（構成アイテムが表示されます）';
    $Self->{Translation}->{'Parameters for the version string module for config item classes in the preferences view of the agent interface.'} =
        'エージェントインタフェースの環境設定ビューの設定項目クラスのバージョン文字列モジュールのパラメータ。';
    $Self->{Translation}->{'Parameters for the version string template toolkit module for config item classes in the preferences view of the agent interface.'} =
        'エージェントインターフェイスの環境設定ビューの設定項目クラス用のバージョン文字列テンプレートツールキットモジュールのパラメータ。';
    $Self->{Translation}->{'Parameters for the version trigger for config item classes in the preferences view of the agent interface.'} =
        'エージェントインタフェースの環境設定ビューの設定項目クラスのバージョントリガーのパラメータ。';
    $Self->{Translation}->{'Performs the configured action for each event (as an Invoker) for each configured Webservice.'} =
        '設定された各Webサービスの各イベントに対して（Invokerとして）設定されたアクションを実行します。';
    $Self->{Translation}->{'Permission Group'} = '権限グループ';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item attachment action in the agent interface.'} =
        'エージェントインターフェイスでITSM構成項目添付アクションを使用するために必要な権限。';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item screen in the agent interface.'} =
        '担当者Webインターフェイスで構成アイテム画面を使用するために必要な権限';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item search screen in the agent interface.'} =
        '担当者Webインターフェイスの構成アイテムの検索画面を使用するために必要な権限';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item search screen in the customer interface.'} =
        'カスタマーインターフェースのITSM構成項目検索画面を使用するために必要な権限。';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item tree view screen in the agent interface.'} =
        'エージェントインターフェイスでITSM構成項目ツリービュー画面を使用するために必要な権限。';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item zoom screen in the agent interface.'} =
        '担当者Webインターフェイス構成アイテムのズーム画面を使用するために必要な権限';
    $Self->{Translation}->{'Required permissions to use the add ITSM configuration item screen in the agent interface.'} =
        '担当者Webインターフェイスで構成アイテムの追加画面を使用するために必要な権限';
    $Self->{Translation}->{'Required permissions to use the bulk ITSM configuration item screen in the agent interface.'} =
        'エージェントインターフェイスの一括ITSM設定項目画面を使用するために必要な権限。';
    $Self->{Translation}->{'Required permissions to use the edit ITSM configuration item screen in the agent interface.'} =
        '担当者Webインターフェイスで構成アイテムの編集画面を使用するために必要な権限';
    $Self->{Translation}->{'Required permissions to use the history ITSM configuration item screen in the agent interface.'} =
        '担当者Webインターフェイスで構成アイテムの履歴画面を使用するために必要な権限';
    $Self->{Translation}->{'Required permissions to use the print ITSM configuration item screen in the agent interface.'} =
        '担当者Webインタフェースで構成アイテムの印刷画面を使用するために必要な権限';
    $Self->{Translation}->{'Required privileges to delete config items.'} = '構成アイテムを削除するために必要な特権';
    $Self->{Translation}->{'Search config items.'} = '構成アイテムを検索';
    $Self->{Translation}->{'Set the incident state of a CI automatically when a Ticket is Linked to a CI.'} =
        'チケットがCIにリンクされている場合、CIのインシデントのステータスを自動的に設定します。';
    $Self->{Translation}->{'Sets the deployment state in the configuration item bulk screen of the agent interface.'} =
        '担当者インターフェイスの構成アイテムの一括画面でデプロイ状態を設定します。';
    $Self->{Translation}->{'Sets the incident state in the configuration item bulk screen of the agent interface.'} =
        '担当者インターフェイスの構成アイテムの一括画面でインシデントのステータスを設定します。';
    $Self->{Translation}->{'Shows a link in the menu that allows linking a configuration item with another object in the config item zoom view of the agent interface.'} =
        '担当者インターフェイスの構成アイテムのズーム ビューで、構成アイテムを別のオブジェクトにリンクできるようにするメニュー内のリンクを表示します。';
    $Self->{Translation}->{'Shows a link in the menu to access the history of a configuration item in the configuration item overview of the agent interface.'} =
        '担当者インターフェイスの構成アイテムの概要にある構成アイテムの履歴にアクセスするためのリンクをメニューに表示します。';
    $Self->{Translation}->{'Shows a link in the menu to access the history of a configuration item in the its zoom view of the agent interface.'} =
        '担当者インターフェイスのズーム ビューで構成アイテムの履歴にアクセスするためのリンクをメニューに表示します。';
    $Self->{Translation}->{'Shows a link in the menu to delete a configuration item in its zoom view of the agent interface.'} =
        'メニューにリンクを表示して、担当者Webインターフェイスのズーム表示で設定項目を削除します。';
    $Self->{Translation}->{'Shows a link in the menu to display the configuration item links as a Tree View.'} =
        '設定項目のリンクをツリー表示するためのリンクをメニューに表示します。';
    $Self->{Translation}->{'Shows a link in the menu to duplicate a configuration item in the configuration item overview of the agent interface.'} =
        '担当者インターフェイスの構成アイテムの概要で構成アイテムを複製するためのメニューのリンクを表示します。';
    $Self->{Translation}->{'Shows a link in the menu to duplicate a configuration item in the its zoom view of the agent interface.'} =
        '担当者インターフェイスのズーム ビューで構成アイテムを複製するためのリンクをメニューに表示します。';
    $Self->{Translation}->{'Shows a link in the menu to edit a configuration item in the its zoom view of the agent interface.'} =
        '担当者インターフェイスのズーム ビューで構成アイテムを編集するためのメニューのリンクを表示します。';
    $Self->{Translation}->{'Shows a link in the menu to go back in the configuration item zoom view of the agent interface.'} =
        '担当者インターフェイスの構成アイテムのズーム ビューに戻るためのリンクをメニューに表示します。';
    $Self->{Translation}->{'Shows a link in the menu to print a configuration item in the its zoom view of the agent interface.'} =
        '担当者インターフェイスのズーム ビューで構成アイテムを印刷するためのメニューのリンクを表示します。';
    $Self->{Translation}->{'Shows a link in the menu to zoom into a configuration item in the configuration item overview of the agent interface.'} =
        '担当者インターフェイスの構成アイテムの概要で構成アイテムを拡大するためのメニューのリンクを表示します。';
    $Self->{Translation}->{'Shows the config item history (reverse ordered) in the agent interface.'} =
        '担当者Webインターフェイスで構成アイテムの履歴（逆順）を表示します。';
    $Self->{Translation}->{'The default category which is shown, if none is selected.'} = '何も選択されていない場合に表示されるデフォルトのカテゴリー。';
    $Self->{Translation}->{'The identifier for a configuration item, e.g. ConfigItem#, MyConfigItem#. The default is ConfigItem#.'} =
        '構成アイテムの識別子。 ConfigItem＃、MyConfigItem＃、 デフォルトはConfigItem＃です。';
    $Self->{Translation}->{'Triggers ConfigItemFetch invoker automatically.'} = 'ConfigItemFetch invokerを自動的に起動する。';
    $Self->{Translation}->{'Version String Expression'} = 'バージョン文字列式';
    $Self->{Translation}->{'Version String Module'} = 'バージョン文字列モジュール';
    $Self->{Translation}->{'Version Trigger'} = 'バージョン・トリガー';
    $Self->{Translation}->{'Whether the execution of ConfigItemACL can be avoided by checking cached field dependencies. This can improve loading times of formulars, but has to be disabled, if ACLModules are to be used for ITSMConfigItem- and Form-ReturnTypes.'} =
        'キャッシュされたフィールドの依存関係をチェックすることで、ConfigItemACLの実行を回避できるかどうか。これはフォームのロード時間を改善することができるが、ACLModule を ITSMConfigItem- と Form-ReturnType で使用する場合は無効にしなければならない。';
    $Self->{Translation}->{'Which general information is shown in the header.'} = 'どの一般的な情報がヘッダーに表示されているか。';
    $Self->{Translation}->{'class'} = 'クラス';
    $Self->{Translation}->{'global'} = 'グローバル';
    $Self->{Translation}->{'postproductive'} = '次の生産';
    $Self->{Translation}->{'preproductive'} = '再生産';
    $Self->{Translation}->{'productive'} = '生産';


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

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

package Kernel::Language::tr_ITSMConfigurationManagement;

use strict;
use warnings;
use utf8;

sub Data {
    my $Self = shift;

    # Template: AdminITSMConfigItem
    $Self->{Translation}->{'Config Item Management'} = 'Konfigürasyon Öğesi Yönetimi';
    $Self->{Translation}->{'Change class definition'} = 'Sınıf tanımını değiştir';
    $Self->{Translation}->{'Change role definition'} = 'Rol tanımını değiştir';
    $Self->{Translation}->{'Ready2Import Class Bundles'} = 'Ready2Import Sınıf Paketleri';
    $Self->{Translation}->{'Here you can import Ready2Import class bundles showcasing our most usual config items. Please note that some additional configuration may be required.'} =
        'Burada, en yaygın yapılandırma öğelerimizi sergileyen Ready2Import sınıf paketlerini içe aktarabilirsiniz. Bazı ek yapılandırmaların gerekli olabileceğini lütfen unutmayın.';
    $Self->{Translation}->{'Update existing entities'} = 'Mevcut varlıkları güncelleyin';
    $Self->{Translation}->{'Import Ready2Adopt class bundles'} = 'Ready2Adopt sınıf paketlerini içe aktarın';
    $Self->{Translation}->{'Config Item Class'} = 'Config Öğe Sınıfı';
    $Self->{Translation}->{'Config Item Role'} = 'Yapılandırma Öğesi Rolü';

    # Template: AgentITSMConfigItemAdd
    $Self->{Translation}->{'Config Item'} = 'Yapılandırma Öğesi';
    $Self->{Translation}->{'Filter for Classes'} = 'Sınıflar için Filtre';
    $Self->{Translation}->{'Select a Class from the list to create a new Config Item.'} = 'Yeni bir Yapılandırma Öğesi oluşturmak için listeden bir Sınıf seçin.';
    $Self->{Translation}->{'Class'} = 'Sınıf';

    # Template: AgentITSMConfigItemBulk
    $Self->{Translation}->{'ITSM ConfigItem Bulk Action'} = 'ITSM ConfigItem Toplu Eylemi';
    $Self->{Translation}->{'Deployment state'} = 'Dağıtım durumu';
    $Self->{Translation}->{'Incident state'} = 'Olay durumu';
    $Self->{Translation}->{'Link to another'} = 'Diğerine bağlantı';
    $Self->{Translation}->{'Invalid Configuration Item number!'} = 'Geçersiz Yapılandırma Öğesi numarası!';
    $Self->{Translation}->{'The number of another Configuration Item to link with.'} = 'Bağlantı kurulacak başka bir Yapılandırma Öğesinin numarası.';

    # Template: AgentITSMConfigItemDelete
    $Self->{Translation}->{'Do you really want to delete this config item?'} = 'Bu yapılandırma öğesini gerçekten silmek istiyor musunuz?';

    # Template: AgentITSMConfigItemEdit
    $Self->{Translation}->{'The name of this config item'} = 'Bu yapılandırma öğesinin adı';
    $Self->{Translation}->{'Name is already in use by the ConfigItems with the following Number(s): %s'} =
        'Ad, aşağıdaki Sayı(lar)a sahip ConfigItems tarafından zaten kullanılıyor: %s';
    $Self->{Translation}->{'Version Number'} = 'Sürüm Numarası';
    $Self->{Translation}->{'Version number of this config item'} = 'Bu yapılandırma öğesinin sürüm numarası';
    $Self->{Translation}->{'Version Number is already in use by the ConfigItems with the following Number(s): %s'} =
        'Sürüm Numarası, aşağıdaki Numaraya/Numaralara sahip ConfigItems tarafından zaten kullanılıyor: %s';
    $Self->{Translation}->{'Deployment State'} = 'Dağıtım Durumu';
    $Self->{Translation}->{'Incident State'} = 'Olay Durumu';

    # Template: AgentITSMConfigItemHistory
    $Self->{Translation}->{'History of Config Item: %s'} = 'Yapılandırma Öğesinin Geçmişi: %s';
    $Self->{Translation}->{'History Content'} = 'Tarih İçeriği';
    $Self->{Translation}->{'Createtime'} = 'Createtime';
    $Self->{Translation}->{'Zoom view'} = 'Yakınlaştırma görünümü';

    # Template: AgentITSMConfigItemOverviewNavBar
    $Self->{Translation}->{'Config Items per page'} = 'Sayfa başına Konfigürasyon Öğeleri';

    # Template: AgentITSMConfigItemOverviewSmall
    $Self->{Translation}->{'No config item data found.'} = 'Yapılandırma öğesi verisi bulunamadı.';
    $Self->{Translation}->{'Select this config item'} = 'Bu yapılandırma öğesini seçin';

    # Template: AgentITSMConfigItemSearch
    $Self->{Translation}->{'Run Search'} = 'Arama Çalıştır';
    $Self->{Translation}->{'Also search in previous versions?'} = 'Ayrıca önceki sürümlerde arama?';

    # Template: AgentITSMConfigItemTreeView
    $Self->{Translation}->{'TreeView for ConfigItem'} = 'ConfigItem için TreeView';
    $Self->{Translation}->{'Depth Level'} = 'Derinlik Seviyesi';
    $Self->{Translation}->{'Zoom In/Out'} = 'Yakınlaştırma/Uzaklaştırma';
    $Self->{Translation}->{'Max links level reached for ConfigItem!'} = 'ConfigItem için maksimum bağlantı düzeyine ulaşıldı!';

    # Template: AgentITSMConfigItemZoom
    $Self->{Translation}->{'Configuration Item'} = 'Yapılandırma Öğesi';
    $Self->{Translation}->{'Configuration Item Information'} = 'Yapılandırma Öğesi Bilgileri';
    $Self->{Translation}->{'Current Deployment State'} = 'Mevcut Dağıtım Durumu';
    $Self->{Translation}->{'Current Incident State'} = 'Mevcut Olay Durumu';
    $Self->{Translation}->{'Last changed'} = 'Son değişiklik';
    $Self->{Translation}->{'Last changed by'} = 'Son değiştiren';

    # Template: CustomerITSMConfigItem
    $Self->{Translation}->{'Your ConfigItems'} = 'ConfigItems öğeleriniz';

    # Template: CustomerITSMConfigItemSearch
    $Self->{Translation}->{'ConfigItem Search'} = 'ConfigItem Arama';

    # Template: AdminACL
    $Self->{Translation}->{'Object Type'} = 'Nesne Türü';

    # JS Template: ClassImportConfirm
    $Self->{Translation}->{'The following classes will be imported'} = 'Aşağıdaki sınıflar içe aktarılacaktır';
    $Self->{Translation}->{'The following roles will be imported'} = 'Aşağıdaki roller içe aktarılacaktır';
    $Self->{Translation}->{'Note that also corresponding dynamic fields and GeneralCatalog classes will be created and there is no automatic removal.'} =
        'İlgili dinamik alanların ve GeneralCatalog sınıflarının da oluşturulacağını ve otomatik olarak kaldırılmayacağını unutmayın.';
    $Self->{Translation}->{'Do you want to proceed?'} = 'Devam etmek istiyor musun?';

    # Perl Module: Kernel/Modules/AdminITSMConfigItem.pm
    $Self->{Translation}->{'Need ExampleClasses!'} = 'Örnek Sınıflara İhtiyaç Var!';
    $Self->{Translation}->{'Definition is no valid YAML hash.'} = 'Tanım geçerli bir YAML karması değildir.';

    # Perl Module: Kernel/Modules/AgentITSMConfigItem.pm
    $Self->{Translation}->{'Overview: ITSM ConfigItem'} = 'Genel Bakış: ITSM ConfigItem';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemBulk.pm
    $Self->{Translation}->{'No ConfigItemID is given!'} = 'ConfigItemID verilmemiş!';
    $Self->{Translation}->{'You need at least one selected Configuration Item!'} = 'En az bir seçili Yapılandırma Öğesine ihtiyacınız var!';
    $Self->{Translation}->{'You don\'t have write access to this configuration item: %s.'} =
        'Bu yapılandırma öğesine yazma erişiminiz yok: %s.';
    $Self->{Translation}->{'No definition was defined for class %s!'} = 'Sınıf %s için tanımlama yapılmadı!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemDelete.pm
    $Self->{Translation}->{'Config item "%s" not found in database!'} = 'Yapılandırma öğesi "%s" veritabanında bulunamadı!';
    $Self->{Translation}->{'Was not able to delete the configitem ID %s!'} = 'Yapılandırma öğesi kimliği %s silinemedi!';
    $Self->{Translation}->{'No version found for ConfigItemID %s!'} = 'ConfigItemID %s için sürüm bulunamadı!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemEdit.pm
    $Self->{Translation}->{'No ConfigItemID, DuplicateID or ClassID is given!'} = 'ConfigItemID, DuplicateID veya ClassID verilmemiştir!';
    $Self->{Translation}->{'No access is given!'} = 'Erişim izni yok!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemHistory.pm
    $Self->{Translation}->{'Can\'t show history, no ConfigItemID is given!'} = 'ConfigItemID verilmediği için geçmiş gösterilemiyor!';
    $Self->{Translation}->{'Can\'t show history, no access rights given!'} = 'Geçmiş gösterilemiyor, erişim hakkı verilmemiş!';
    $Self->{Translation}->{'New ConfigItem (ID=%s)'} = 'Yeni ConfigItem (ID=%s)';
    $Self->{Translation}->{'New version (ID=%s)'} = 'Yeni sürüm (ID=%s)';
    $Self->{Translation}->{'Deployment state updated (new=%s, old=%s)'} = 'Dağıtım durumu güncellendi (new=%s, old=%s)';
    $Self->{Translation}->{'Incident state updated (new=%s, old=%s)'} = 'Olay durumu güncellendi (yeni=%s, eski=%s)';
    $Self->{Translation}->{'ConfigItem (ID=%s) deleted'} = 'ConfigItem (ID=%s) silindi';
    $Self->{Translation}->{'Link to %s (type=%s) added'} = 's (type=%s) bağlantısı eklendi';
    $Self->{Translation}->{'Link to %s (type=%s) deleted'} = 's (type=%s) bağlantısı silindi';
    $Self->{Translation}->{'ConfigItem definition updated (ID=%s)'} = 'ConfigItem tanımı güncellendi (ID=%s)';
    $Self->{Translation}->{'Name updated (new=%s, old=%s)'} = 'Ad güncellendi (yeni=%s, eski=%s)';
    $Self->{Translation}->{'Attribute %s updated from "%s" to "%s"'} = 'Öznitelik %s "%s "den "%s "ye güncellendi';
    $Self->{Translation}->{'Version %s deleted'} = 'Sürüm %s silindi';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemPrint.pm
    $Self->{Translation}->{'No ConfigItemID or VersionID is given!'} = 'ConfigItemID veya VersionID verilmedi!';
    $Self->{Translation}->{'Can\'t show config item, no access rights given!'} = 'Yapılandırma öğesi gösterilemiyor, erişim hakkı verilmemiş!';
    $Self->{Translation}->{'ConfigItemID %s not found in database!'} = 'ConfigItemID %s veritabanında bulunamadı!';
    $Self->{Translation}->{'ConfigItem'} = 'ConfigItem';
    $Self->{Translation}->{'printed by %s at %s'} = 's\'de %s tarafından yazdırıldı';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemSearch.pm
    $Self->{Translation}->{'Invalid ClassID!'} = 'Geçersiz ClassID!';
    $Self->{Translation}->{'No ClassID is given!'} = 'ClassID verilmemiştir!';
    $Self->{Translation}->{'No access rights for this class given!'} = 'Bu sınıf için erişim hakkı verilmemiştir!';
    $Self->{Translation}->{'No Result!'} = 'Sonuç yok!';
    $Self->{Translation}->{'Config Item Search Results'} = 'Konfigürasyon Öğesi Arama Sonuçları';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemZoom.pm
    $Self->{Translation}->{'Can\'t show item, no access rights for ConfigItem are given!'} =
        'Öğe gösterilemiyor, ConfigItem için erişim hakkı verilmemiş!';
    $Self->{Translation}->{'ConfigItem not found!'} = 'ConfigItem bulunamadı!';
    $Self->{Translation}->{'No versions found!'} = 'Hiçbir versiyon bulunamadı!';
    $Self->{Translation}->{'operational'} = 'operasyonel';
    $Self->{Translation}->{'warning'} = 'uyarı';
    $Self->{Translation}->{'incident'} = 'olay';
    $Self->{Translation}->{'The deployment state of this config item'} = 'Bu yapılandırma öğesinin dağıtım durumu';
    $Self->{Translation}->{'The incident state of this config item'} = 'Bu yapılandırma öğesinin olay durumu';

    # Perl Module: Kernel/Modules/CustomerITSMConfigItemSearch.pm
    $Self->{Translation}->{'No permission'} = 'İzin yok';
    $Self->{Translation}->{'Filter invalid!'} = 'Filtre geçersiz!';
    $Self->{Translation}->{'Search params invalid!'} = 'Arama parametreleri geçersiz!';

    # Perl Module: Kernel/Output/HTML/Dashboard/ITSMConfigItemGeneric.pm
    $Self->{Translation}->{'Shown config items'} = 'Gösterilen yapılandırma öğeleri';
    $Self->{Translation}->{'Deployment State Type'} = 'Dağıtım Durumu Türü';
    $Self->{Translation}->{'Current Incident State Type'} = 'Mevcut Olay Durum Türü';

    # Perl Module: Kernel/Output/HTML/ITSMConfigItem/LayoutDate.pm
    $Self->{Translation}->{'Between'} = 'Arasında';

    # Perl Module: Kernel/System/DynamicField/Driver/ConfigItem.pm
    $Self->{Translation}->{'Class restrictions for the config item'} = 'Yapılandırma öğesi için sınıf kısıtlamaları';
    $Self->{Translation}->{'Select one or more classes to restrict selectable config items'} =
        'Seçilebilir yapılandırma öğelerini kısıtlamak için bir veya daha fazla sınıf seçin';
    $Self->{Translation}->{'Link type'} = 'Bağlantı türü';
    $Self->{Translation}->{'Select the link type.'} = 'Bağlantı türünü seçin.';
    $Self->{Translation}->{'Forwards: Referencing (Source) -> Referenced (Target)'} = 'İleriye doğru: Referans Verme (Kaynak) -> Referans Verilen (Hedef)';
    $Self->{Translation}->{'Backwards: Referenced (Source) -> Referencing (Target)'} = 'Geriye doğru: Referanslı (Kaynak) -> Referanslı (Hedef)';
    $Self->{Translation}->{'Link Direction'} = 'Bağlantı Yönü';
    $Self->{Translation}->{'The referencing object is the one containing this dynamic field, the referenced object is the one selected as value of the dynamic field.'} =
        'Referans veren nesne bu dinamik alanı içeren nesnedir, referans alınan nesne ise dinamik alanın değeri olarak seçilen nesnedir.';
    $Self->{Translation}->{'Dynamic (ConfigItem)'} = 'Dinamik (ConfigItem)';
    $Self->{Translation}->{'Static (Version)'} = 'Static (Versiyon)';
    $Self->{Translation}->{'Link Referencing Type'} = 'Bağlantı Referanslama Türü';
    $Self->{Translation}->{'Whether this link applies to the ConfigItem or the static version of the referencing object. Current Incident State calculation only is performed on dynamic links.'} =
        'Bu bağlantının ConfigItem için mi yoksa başvuran nesnenin statik sürümü için mi geçerli olduğu. Geçerli Olay Durumu hesaplaması yalnızca dinamik bağlantılarda gerçekleştirilir.';
    $Self->{Translation}->{'Select the attribute which config items will be searched by'} = 'Yapılandırma öğelerinin aranacağı özniteliği seçin';

    # Perl Module: Kernel/System/ITSMConfigItem/Definition.pm
    $Self->{Translation}->{'Starting the YAML string with \'---\' is required.'} = 'YAML dizesinin \'---\' ile başlaması gereklidir.';

    # Perl Module: Kernel/System/ITSMConfigItem/Link.pm
    $Self->{Translation}->{'Could not purge the table configitem_link.'} = 'configitem_link tablosu temizlenemedi.';
    $Self->{Translation}->{'No relevant dynamic fields were found'} = 'İlgili dinamik alan bulunamadı';
    $Self->{Translation}->{'Could not insert into the table configitem_link'} = 'configitem_link tablosuna eklenemedi';
    $Self->{Translation}->{'Inserted 0 rows into the table configitem_link'} = 'configitem_link tablosuna 0 satır eklendi';

    # Perl Module: Kernel/System/ImportExport/ObjectBackend/ITSMConfigItem.pm
    $Self->{Translation}->{'Maximum number of one element'} = 'Maksimum bir eleman sayısı';
    $Self->{Translation}->{'Empty fields indicate that the current values are kept'} = 'Boş alanlar mevcut değerlerin korunduğunu gösterir';
    $Self->{Translation}->{'Skipped'} = 'Atlandı';

    # Perl Module: Kernel/Modules/AdminDynamicField.pm
    $Self->{Translation}->{'Error synchronizing the definitions. Please check the log.'} = 'Tanımlar senkronize edilirken hata oluştu. Lütfen günlüğü kontrol edin.';
    $Self->{Translation}->{'You have ITSMConfigItem definitions which are not synchronized. Please deploy your ITSMConfigItem dynamic field changes.'} =
        'Senkronize edilmemiş ITSMConfigItem tanımlarınız var. Lütfen ITSMConfigItem dinamik alan değişikliklerinizi dağıtın.';

    # Database XML / SOPM Definition: ITSMConfigurationManagement.sopm
    $Self->{Translation}->{'Expired'} = 'Süresi doldu';
    $Self->{Translation}->{'Maintenance'} = 'Bakım';
    $Self->{Translation}->{'Pilot'} = 'Pilot';
    $Self->{Translation}->{'Planned'} = 'Planlanmış';
    $Self->{Translation}->{'Repair'} = 'Onarım';
    $Self->{Translation}->{'Retired'} = 'Emekli';
    $Self->{Translation}->{'Review'} = 'İnceleme';
    $Self->{Translation}->{'Test/QA'} = 'Test/QA';

    # JS File: ITSM.Admin.ITSMConfigItem
    $Self->{Translation}->{'Overview and Confirmation'} = 'Genel Bakış ve Onay';
    $Self->{Translation}->{'Importing classes/roles and their related fields'} = 'Sınıfları/rolleri ve ilgili alanları içe aktarma';
    $Self->{Translation}->{'An error occurred during class import.'} = 'Sınıf içe aktarımı sırasında bir hata oluştu.';

    # SysConfig
    $Self->{Translation}->{'0 - Hidden'} = '0 - Gizli';
    $Self->{Translation}->{'1 - Shown'} = '1 - Gösterilen';
    $Self->{Translation}->{'Allows extended search conditions in config item search of the agent interface. With this feature you can search e. g. config item name with this kind of conditions like "(*key1*&&*key2*)" or "(*key1*||*key2*)".'} =
        'Aracı arayüzünün yapılandırma öğesi aramasında genişletilmiş arama koşullarına izin verir. Bu özellik sayesinde, örneğin yapılandırma öğesi adını "(*key1*&*key2*)" veya "(*key1*|*key2*)" gibi bu tür koşullarla arayabilirsiniz.';
    $Self->{Translation}->{'Allows extended search conditions in config item search of the customer interface. With this feature you can search e. g. config item name with this kind of conditions like "(*key1*&&*key2*)" or "(*key1*||*key2*)".'} =
        'Müşteri arayüzünün yapılandırma öğesi aramasında genişletilmiş arama koşullarına izin verir. Bu özellik sayesinde, örneğin yapılandırma öğesi adını "(*anahtar1*&*anahtar2*)" veya "(*anahtar1*|*anahtar2*)" gibi bu tür koşullarla arayabilirsiniz.';
    $Self->{Translation}->{'Assigned CIs'} = 'Atanmış CI\'lar';
    $Self->{Translation}->{'CIs assigned to customer company'} = 'Müşteri şirkete atanan CI\'lar';
    $Self->{Translation}->{'CIs assigned to customer user'} = 'Müşteri kullanıcıya atanan CI\'lar';
    $Self->{Translation}->{'CMDB Settings'} = 'CMDB Ayarları';
    $Self->{Translation}->{'Check for a unique name only within the same ConfigItem class (\'class\') or globally (\'global\'), which means every existing ConfigItem is taken into account when looking for duplicates.'} =
        'Yalnızca aynı ConfigItem sınıfı (\'class\') içinde veya genel olarak (\'global\') benzersiz bir ad olup olmadığını kontrol edin; bu, yinelenenleri ararken mevcut her ConfigItem\'ın dikkate alındığı anlamına gelir.';
    $Self->{Translation}->{'Choose a module to enforce a naming scheme.'} = 'Bir adlandırma şeması uygulamak için bir modül seçin.';
    $Self->{Translation}->{'Choose a module to enforce a number scheme.'} = 'Bir sayı şemasını uygulamak için bir modül seçin.';
    $Self->{Translation}->{'Choose a module to enforce a version string scheme.'} = 'Sürüm dizesi şemasını uygulamak için bir modül seçin.';
    $Self->{Translation}->{'Choose attributes to trigger the creation of a new version.'} = 'Yeni bir sürümün oluşturulmasını tetiklemek için öznitelikleri seçin.';
    $Self->{Translation}->{'Choose categories to assign to this config item class.'} = 'Bu yapılandırma öğesi sınıfına atanacak kategorileri seçin.';
    $Self->{Translation}->{'Column config item filters for ConfigItem Overview.'} = 'ConfigItem Overview için sütun yapılandırma öğesi filtreleri.';
    $Self->{Translation}->{'Columns that can be filtered in the config item overview of the agent interface. Note: Only Config Item attributes and Dynamic Fields (DynamicField_NameX) are allowed.'} =
        'Temsilci arayüzünün yapılandırma öğesine genel bakışında filtrelenebilen sütunlar. Not: Yalnızca Yapılandırma Öğesi özniteliklerine ve Dinamik Alanlara (DynamicField_NameX) izin verilir.';
    $Self->{Translation}->{'Columns that can be filtered in the config item overview of the customer interface. Note: Only Config Item attributes and Dynamic Fields (DynamicField_NameX) are allowed.'} =
        'Müşteri arayüzünün yapılandırma öğesine genel bakışında filtrelenebilen sütunlar. Not: Yalnızca Yapılandırma Öğesi özniteliklerine ve Dinamik Alanlara (DynamicField_NameX) izin verilir.';
    $Self->{Translation}->{'Columns that can be filtered in the config item search result overview of the agent interface. Note: Only Config Item attributes and Dynamic Fields (DynamicField_NameX) are allowed.'} =
        'Temsilci arayüzünün yapılandırma öğesi arama sonucu genel bakışında filtrelenebilen sütunlar. Not: Yalnızca Yapılandırma Öğesi özniteliklerine ve Dinamik Alanlara (DynamicField_NameX) izin verilir.';
    $Self->{Translation}->{'Config Items'} = 'Yapılandırma Öğeleri';
    $Self->{Translation}->{'Config item add.'} = 'Yapılandırma öğesi ekle.';
    $Self->{Translation}->{'Config item edit.'} = 'Yapılandırma öğesi düzenleme.';
    $Self->{Translation}->{'Config item event module that enables logging to history in the agent interface.'} =
        'Temsilci arayüzünde geçmişe günlüğe kaydetmeyi sağlayan yapılandırma öğesi olay modülü.';
    $Self->{Translation}->{'Config item event module that updates config items to their current definition.'} =
        'Yapılandırma öğelerini geçerli tanımlarına göre güncelleyen yapılandırma öğesi olay modülü.';
    $Self->{Translation}->{'Config item event module that updates the table configitem_ĺink.'} =
        'configitem_ĺink tablosunu güncelleyen yapılandırma öğesi olay modülü.';
    $Self->{Translation}->{'Config item event module updates the current incident state.'} =
        'Konfigürasyon öğesi olay modülü mevcut olay durumunu günceller.';
    $Self->{Translation}->{'Config item history.'} = 'Yapılandırma öğesi geçmişi.';
    $Self->{Translation}->{'Config item print.'} = 'Yapılandırma öğesi yazdırma.';
    $Self->{Translation}->{'Config item zoom.'} = 'Yapılandırma öğesi yakınlaştırma.';
    $Self->{Translation}->{'ConfigItem Tree View'} = 'ConfigItem Ağaç Görünümü';
    $Self->{Translation}->{'ConfigItem Version'} = 'ConfigItem Sürüm';
    $Self->{Translation}->{'ConfigItems of the following classes will not be stored on the Elasticsearch server. To apply this to existing CIs, the CI migration has to be run via console, after changing this option.'} =
        'Aşağıdaki sınıfların ConfigItems öğeleri Elasticsearch sunucusunda saklanmayacaktır. Bunu mevcut CI\'lara uygulamak için, bu seçenek değiştirildikten sonra CI geçişinin konsol üzerinden çalıştırılması gerekir.';
    $Self->{Translation}->{'ConfigItems with the following deployment states will not be stored on the Elasticsearch server. To apply this to existing CIs, the CI migration has to be run via console, after changing this option.'} =
        'Aşağıdaki dağıtım durumlarına sahip ConfigItems, Elasticsearch sunucusunda depolanmayacaktır. Bunu mevcut CI\'lara uygulamak için, bu seçenek değiştirildikten sonra CI geçişinin konsol üzerinden çalıştırılması gerekir.';
    $Self->{Translation}->{'Configuration Item Limit'} = 'Yapılandırma Öğesi Sınırı';
    $Self->{Translation}->{'Configuration Item limit per page.'} = 'Konfigürasyon Sayfa başına öğe sınırı.';
    $Self->{Translation}->{'Configuration Management Database.'} = 'Konfigürasyon Yönetimi Veritabanı.';
    $Self->{Translation}->{'Configuration item bulk module.'} = 'Yapılandırma öğesi toplu modülü.';
    $Self->{Translation}->{'Configuration item search backend router of the agent interface.'} =
        'Aracı arayüzünün yapılandırma öğesi arama arka uç yönlendiricisi.';
    $Self->{Translation}->{'Create and manage the definitions for Configuration Items.'} = 'Yapılandırma Öğeleri için tanımlar oluşturun ve yönetin.';
    $Self->{Translation}->{'Customers can see historic CI versions.'} = 'Müşteriler geçmiş CI sürümlerini görebilirler.';
    $Self->{Translation}->{'Customers have the possibility to manually switch between historic CI versions.'} =
        'Müşteriler, geçmiş CI sürümleri arasında manuel olarak geçiş yapma olanağına sahiptir.';
    $Self->{Translation}->{'Default data to use on attribute for config item search screen. Example: "ITSMConfigItemCreateTimePointFormat=year;ITSMConfigItemCreateTimePointStart=Last;ITSMConfigItemCreateTimePoint=2;".'} =
        'Yapılandırma öğesi arama ekranı için öznitelikte kullanılacak varsayılan veriler. Örnek: "ITSMConfigItemCreateTimePointFormat=year;ITSMConfigItemCreateTimePointStart=Last;ITSMConfigItemCreateTimePoint=2;".';
    $Self->{Translation}->{'Default data to use on attribute for config item search screen. Example: "ITSMConfigItemCreateTimeStartYear=2010;ITSMConfigItemCreateTimeStartMonth=10;ITSMConfigItemCreateTimeStartDay=4;ITSMConfigItemCreateTimeStopYear=2010;ITSMConfigItemCreateTimeStopMonth=11;ITSMConfigItemCreateTimeStopDay=3;".'} =
        'Yapılandırma öğesi arama ekranı için öznitelikte kullanılacak varsayılan veriler. Örnek: "ITSMConfigItemCreateTimeStartYear=2010;ITSMConfigItemCreateTimeStartMonth=10;ITSMConfigItemCreateTimeStartDay=4;ITSMConfigItemCreateTimeStopYear=2010;ITSMConfigItemCreateTimeStopMonth=11;ITSMConfigItemCreateTimeStopDay=3;".';
    $Self->{Translation}->{'Define Actions where a settings button is available in the linked objects widget (LinkObject::ViewMode = "complex"). Please note that these Actions must have registered the following JS and CSS files: Core.AllocationList.css, Core.UI.AllocationList.js, Core.UI.Table.Sort.js, Core.Agent.TableFilters.js and Core.Agent.LinkObject.js.'} =
        'Bağlantılı nesneler widget\'ında (LinkObject::ViewMode = "complex") bir ayar düğmesinin mevcut olduğu Eylemleri tanımlayın. Lütfen bu Eylemlerin aşağıdaki JS ve CSS dosyalarını kaydetmiş olması gerektiğini unutmayın: Core.AllocationList.css, Core.UI.AllocationList.js, Core.UI.Table.Sort.js, Core.Agent.TableFilters.js ve Core.Agent.LinkObject.js.';
    $Self->{Translation}->{'Define a Template::Toolkit scheme for version strings. Only used if Version String Module is set to TemplateToolkit.'} =
        'Sürüm dizeleri için bir Template::Toolkit şeması tanımlayın. Yalnızca Sürüm Dizesi Modülü TemplateToolkit olarak ayarlanmışsa kullanılır.';
    $Self->{Translation}->{'Define a set of conditions under which a customer is allowed to see a config item. Conditions can optionally be restricted to certain customer groups. Name is the only mandatory attribute. If no other options are given, all config items will be visible under that category.'} =
        'Bir müşterinin bir yapılandırma öğesini görmesine izin verilen bir dizi koşul tanımlayın. Koşullar isteğe bağlı olarak belirli müşteri gruplarıyla sınırlandırılabilir. Ad tek zorunlu niteliktir. Başka bir seçenek belirtilmezse, tüm yapılandırma öğeleri bu kategori altında görünür olacaktır.';
    $Self->{Translation}->{'Defines Required permissions to create ITSM configuration items using the Generic Interface.'} =
        'Genel Arayüzü kullanarak ITSM yapılandırma öğeleri oluşturmak için Gerekli izinleri tanımlar.';
    $Self->{Translation}->{'Defines Required permissions to delete ITSM configuration items using the Generic Interface.'} =
        'Genel Arayüzü kullanarak ITSM yapılandırma öğelerini silmek için Gerekli izinleri tanımlar.';
    $Self->{Translation}->{'Defines Required permissions to get ITSM configuration items using the Generic Interface.'} =
        'Genel Arayüzü kullanarak ITSM yapılandırma öğelerini almak için Gerekli izinleri tanımlar.';
    $Self->{Translation}->{'Defines Required permissions to search ITSM configuration items using the Generic Interface.'} =
        'Genel Arayüzü kullanarak ITSM yapılandırma öğelerini aramak için Gerekli izinleri tanımlar.';
    $Self->{Translation}->{'Defines Required permissions to update ITSM configuration items using the Generic Interface.'} =
        'Genel Arayüzü kullanarak ITSM yapılandırma öğelerini güncellemek için Gerekli izinleri tanımlar.';
    $Self->{Translation}->{'Defines an overview module to show the small view of a configuration item list.'} =
        'Bir yapılandırma öğesi listesinin küçük görünümünü göstermek için bir genel bakış modülü tanımlar.';
    $Self->{Translation}->{'Defines if the link type labels must be shown in the node connections.'} =
        'Bağlantı türü etiketlerinin düğüm bağlantılarında gösterilip gösterilmeyeceğini tanımlar.';
    $Self->{Translation}->{'Defines regular expressions individually for each ConfigItem class to check the ConfigItem name and to show corresponding error messages.'} =
        'ConfigItem adını denetlemek ve ilgili hata iletilerini göstermek için her ConfigItem sınıfı için ayrı ayrı düzenli ifadeler tanımlar.';
    $Self->{Translation}->{'Defines the available columns of CIs in the config item overview depending on the CI class. Each entry must consist of a class name and an array of available fields for the corresponding class. Dynamic field entries have to honor the scheme DynamicField_FieldName.'} =
        'CI sınıfına bağlı olarak yapılandırma öğesi genel görünümündeki kullanılabilir CI sütunlarını tanımlar. Her giriş bir sınıf adı ve ilgili sınıf için kullanılabilir alanlardan oluşan bir diziden oluşmalıdır. Dinamik alan girişleri DynamicField_FieldName şemasına uymak zorundadır.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of the agent interface.'} =
        'Aracı arayüzünün yapılandırma öğesi arama sonucunun yapılandırma öğesi sıralaması için varsayılan yapılandırma öğesi özniteliğini tanımlar.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of the customer interface.'} =
        'Müşteri arayüzünün yapılandırma öğesi arama sonucunun yapılandırma öğesi sıralaması için varsayılan yapılandırma öğesi özniteliğini tanımlar.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of this operation.'} =
        'Bu işlemin yapılandırma öğesi arama sonucunun yapılandırma öğesi sıralaması için varsayılan yapılandırma öğesi özniteliğini tanımlar.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the agent interface. Up: oldest on top. Down: latest on top.'} =
        'Aracı arayüzünün yapılandırma öğesi arama sonucundaki varsayılan yapılandırma öğesi sırasını tanımlar. Yukarı: en eski en üstte. Aşağı: en son üstte.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the customer interface. Up: oldest on top. Down: latest on top.'} =
        'Müşteri arayüzünün yapılandırma öğesi arama sonucundaki varsayılan yapılandırma öğesi sırasını tanımlar. Yukarı: en eski en üstte. Aşağı: en son üstte.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the this operation. Up: oldest on top. Down: latest on top.'} =
        'Bu işlemin yapılandırma öğesi arama sonucundaki varsayılan yapılandırma öğesi sırasını tanımlar. Yukarı: en eski en üstte. Aşağı: en son üstte.';
    $Self->{Translation}->{'Defines the default displayed columns of CIs in the config item overview depending on the CI class. Each entry must consist of a class name and an array of available fields for the corresponding class. Dynamic field entries have to honor the scheme DynamicField_FieldName.'} =
        'CI sınıfına bağlı olarak yapılandırma öğesi genel görünümünde CI\'ların varsayılan görüntülenen sütunlarını tanımlar. Her giriş bir sınıf adı ve ilgili sınıf için kullanılabilir alanların bir dizisinden oluşmalıdır. Dinamik alan girişleri DynamicField_FieldName şemasına uymak zorundadır.';
    $Self->{Translation}->{'Defines the default relations depth to be shown.'} = 'Gösterilecek varsayılan ilişki derinliğini tanımlar.';
    $Self->{Translation}->{'Defines the default shown config item search attribute for config item search screen.'} =
        'Yapılandırma öğesi arama ekranı için varsayılan gösterilen yapılandırma öğesi arama özniteliğini tanımlar.';
    $Self->{Translation}->{'Defines the default shown config item search attribute for config item search screen. Example: "Key" must have the name of the Dynamic Field in this case \'X\', "Content" must have the value of the Dynamic Field depending on the Dynamic Field type,  Text: \'a text\', Dropdown: \'1\', Date/Time: \'Search_DynamicField_XTimeSlotStartYear=1974; Search_DynamicField_XTimeSlotStartMonth=01; Search_DynamicField_XTimeSlotStartDay=26; Search_DynamicField_XTimeSlotStartHour=00; Search_DynamicField_XTimeSlotStartMinute=00; Search_DynamicField_XTimeSlotStartSecond=00; Search_DynamicField_XTimeSlotStopYear=2013; Search_DynamicField_XTimeSlotStopMonth=01; Search_DynamicField_XTimeSlotStopDay=26; Search_DynamicField_XTimeSlotStopHour=23; Search_DynamicField_XTimeSlotStopMinute=59; Search_DynamicField_XTimeSlotStopSecond=59;\' and or \'Search_DynamicField_XTimePointFormat=week; Search_DynamicField_XTimePointStart=Before; Search_DynamicField_XTimePointValue=7\';.'} =
        'Yapılandırma öğesi arama ekranı için varsayılan gösterilen yapılandırma öğesi arama niteliğini tanımlar. Örnek: "Anahtar" Dinamik Alanın adını içermelidir, bu durumda \'X\', "İçerik" Dinamik Alan türüne bağlı olarak Dinamik Alanın değerini içermelidir, Metin: \'bir metin\', Açılır menü: \'1\', Tarih/Saat: \'Search_DynamicField_XTimeSlotStartYear=1974; Search_DynamicField_XTimeSlotStartMonth=01; Search_DynamicField_XTimeSlotStartDay=26; Search_DynamicField_XTimeSlotStartHour=00; Search_DynamicField_XTimeSlotStartMinute=00; Search_DynamicField_XTimeSlotStartSecond=00; Search_DynamicField_XTimeSlotStopYear=2013; Search_DynamicField_XTimeSlotStopMonth=01; Search_DynamicField_XTimeSlotStopDay=26; Search_DynamicField_XTimeSlotStopHour=23; Search_DynamicField_XTimeSlotStopMinute=59; Search_DynamicField_XTimeSlotStopSecond=59;\' ve veya \'Search_DynamicField_XTimePointFormat=week; Search_DynamicField_XTimePointStart=Before; Search_DynamicField_XTimePointValue=7\';.';
    $Self->{Translation}->{'Defines the default subobject of the class \'ITSMConfigItem\'.'} =
        '\'ITSMConfigItem\' sınıfının varsayılan alt nesnesini tanımlar.';
    $Self->{Translation}->{'Defines the number of rows for the CI definition editor in the admin interface.'} =
        'Yönetici arayüzündeki CI tanımı düzenleyicisi için satır sayısını tanımlar.';
    $Self->{Translation}->{'Defines the order of incident states from high (e.g. cricital) to low (e.g. functional).'} =
        'Olay durumlarının yüksek (örn. krikital) ile düşük (örn. fonksiyonel) arasındaki sırasını tanımlar.';
    $Self->{Translation}->{'Defines the relevant deployment states where linked tickets can affect the status of a CI.'} =
        'Bağlantılı destek taleplerinin bir CI\'nın durumunu etkileyebileceği ilgili dağıtım durumlarını tanımlar.';
    $Self->{Translation}->{'Defines the search limit for the AgentITSMConfigItem screen.'} =
        'AgentITSMConfigItem ekranı için arama sınırını tanımlar.';
    $Self->{Translation}->{'Defines the search limit for the AgentITSMConfigItemSearch screen.'} =
        'AgentITSMConfigItemSearch ekranı için arama sınırını tanımlar.';
    $Self->{Translation}->{'Defines the search limit for the CustomerITSMConfigItem screen.'} =
        'CustomerITSMConfigItem ekranı için arama sınırını tanımlar.';
    $Self->{Translation}->{'Defines the search limit for the CustomerITSMConfigItemSearch screen.'} =
        'CustomerITSMConfigItemSearch ekranı için arama sınırını tanımlar.';
    $Self->{Translation}->{'Defines the shown columns of CIs in the link table complex view for all CI classes. If there is no entry, then the default columns are shown.'} =
        'Tüm CI sınıfları için bağlantı tablosu karmaşık görünümünde CI\'ların gösterilen sütunlarını tanımlar. Herhangi bir giriş yoksa, varsayılan sütunlar gösterilir.';
    $Self->{Translation}->{'Defines the shown columns of CIs in the link table complex view, depending on the CI class. Each entry must be prefixed with the class name and double colons (i.e. Computer::). There are a few CI-Attributes that common to all CIs (example for the class Computer: Computer::Name, Computer::CurDeplState, Computer::CreateTime). To show individual CI-Attributes as defined in the CI-Definition, the following scheme must be used (example for the class Computer): Computer::HardDisk::1, Computer::HardDisk::1::Capacity::1, Computer::HardDisk::2, Computer::HardDisk::2::Capacity::1. If there is no entry for a CI class, then the default columns are shown.'} =
        'CI sınıfına bağlı olarak bağlantı tablosu karmaşık görünümünde CI\'ların gösterilen sütunlarını tanımlar. Her girişin önüne sınıf adı ve çift iki nokta üst üste konulmalıdır (örneğin Bilgisayar::). Tüm CI\'larda ortak olan birkaç CI-Özniteliği vardır (Bilgisayar sınıfı için örnek: Computer::Name, Computer::CurDeplState, Computer::CreateTime). CI-Tanımında tanımlandığı gibi bireysel CI-Özniteliklerini göstermek için aşağıdaki şema kullanılmalıdır (Bilgisayar sınıfı için örnek): Bilgisayar::HardDisk::1, Bilgisayar::HardDisk::1::Kapasite::1, Bilgisayar::HardDisk::2, Bilgisayar::HardDisk::2::Kapasite::1. Bir CI sınıfı için giriş yoksa, varsayılan sütunlar gösterilir.';
    $Self->{Translation}->{'Defines which items are available for \'Action\' in third level of the ITSM Config Item ACL structure.'} =
        'ITSM Config Item ACL yapısının üçüncü seviyesinde hangi öğelerin \'Eylem\' için kullanılabilir olduğunu tanımlar.';
    $Self->{Translation}->{'Defines which items are available in first level of the ITSM Config Item ACL structure.'} =
        'ITSM Config Item ACL yapısının birinci seviyesinde hangi öğelerin mevcut olduğunu tanımlar.';
    $Self->{Translation}->{'Defines which items are available in second level of the ITSM Config Item ACL structure.'} =
        'ITSM Config Item ACL yapısının ikinci seviyesinde hangi öğelerin mevcut olduğunu tanımlar.';
    $Self->{Translation}->{'Defines which type of link (named from the ticket perspective) can affect the status of a linked CI.'} =
        'Hangi bağlantı türünün (bilet perspektifinden adlandırılan) bağlantılı bir CI\'nın durumunu etkileyebileceğini tanımlar.';
    $Self->{Translation}->{'Defines which type of ticket can affect the status of a linked CI.'} =
        'Bağlı bir CI\'nın durumunu hangi tür biletlerin etkileyebileceğini tanımlar.';
    $Self->{Translation}->{'Definition Update'} = 'Tanım Güncellemesi';
    $Self->{Translation}->{'Delete Configuration Item'} = 'Yapılandırma Öğesini Sil';
    $Self->{Translation}->{'DeplState'} = 'DeplState';
    $Self->{Translation}->{'Deployment State Color'} = 'Dağıtım Durumu Rengi';
    $Self->{Translation}->{'DeploymentState'} = 'DeploymentState';
    $Self->{Translation}->{'Duplicate'} = 'Yinelenen';
    $Self->{Translation}->{'Dynamic field event module that marks config item definitions as out of sync, if containing dynamic fields change.'} =
        'Dinamik alan olay modülü, dinamik alanların değişmesi durumunda yapılandırma öğesi tanımlarını senkronizasyon dışı olarak işaretler.';
    $Self->{Translation}->{'Dynamic fields shown in the additional ITSM field screen of the agent interface.'} =
        'Temsilci arayüzünün ek ITSM alanı ekranında gösterilen dinamik alanlar.';
    $Self->{Translation}->{'Dynamic fields shown in the config item overview screen of the customer interface.'} =
        'Müşteri arayüzünün yapılandırma öğesine genel bakış ekranında gösterilen dinamik alanlar.';
    $Self->{Translation}->{'Dynamic fields shown in the config item search screen of the agent interface.'} =
        'Temsilci arayüzünün yapılandırma öğesi arama ekranında gösterilen dinamik alanlar.';
    $Self->{Translation}->{'Enables configuration item bulk action feature for the agent frontend to work on more than one configuration item at a time.'} =
        'Temsilci ön ucunun aynı anda birden fazla yapılandırma öğesi üzerinde çalışması için yapılandırma öğesi toplu eylem özelliğini etkinleştirir.';
    $Self->{Translation}->{'Enables configuration item bulk action feature only for the listed groups.'} =
        'Yapılandırma öğesi toplu eylem özelliğini yalnızca listelenen gruplar için etkinleştirir.';
    $Self->{Translation}->{'Enables/disables the functionality to check ITSM onfiguration items for unique names. Before enabling this option you should check your system for already existing config items with duplicate names. You can do this with the console command Admin::ITSM::Configitem::ListDuplicates.'} =
        'ITSM yapılandırma öğelerini benzersiz adlar için kontrol etme işlevini etkinleştirir/devre dışı bırakır. Bu seçeneği etkinleştirmeden önce sisteminizde yinelenen adlara sahip yapılandırma öğeleri olup olmadığını kontrol etmelisiniz. Bunu Admin::ITSM::Configitem::ListDuplicates konsol komutu ile yapabilirsiniz.';
    $Self->{Translation}->{'Event module to set configitem-status on ticket-configitem-link.'} =
        'Bilet-configitem-link üzerinde configitem-status ayarlamak için olay modülü.';
    $Self->{Translation}->{'Fields of the configuration item index, used for the fulltext search. Fields are also stored, but are not mandatory for the overall functionality. Inclusion of attachments can be disabled by setting the entry to 0 or deleting it.'} =
        'Tam metin arama için kullanılan yapılandırma öğesi dizini alanları. Alanlar da saklanır, ancak genel işlevsellik için zorunlu değildir. Eklerin dahil edilmesi, girişi 0 olarak ayarlayarak veya silerek devre dışı bırakılabilir.';
    $Self->{Translation}->{'Fields stored in the configuration item index which are used for other things besides fulltext searches. For the complete functionality all fields are mandatory.'} =
        'Yapılandırma öğesi dizininde depolanan ve tam metin aramalarının yanı sıra başka şeyler için de kullanılan alanlar. Tam işlevsellik için tüm alanlar zorunludur.';
    $Self->{Translation}->{'For every webservice (key) an array of classes (value) can be defined on which the import is restricted. For all chosen classes, or all existing classes the identifying attributes will have to be chosen in the invoker config.'} =
        'Her web hizmeti (anahtar) için, içe aktarmanın kısıtlandığı bir dizi sınıf (değer) tanımlanabilir. Seçilen tüm sınıflar veya mevcut tüm sınıflar için tanımlayıcı niteliklerin invoker yapılandırmasında seçilmesi gerekecektir.';
    $Self->{Translation}->{'GenericInterface module registration for the ConfigItemFetch invoker layer.'} =
        'ConfigItemFetch çağırıcı katmanı için GenericInterface modül kaydı.';
    $Self->{Translation}->{'ITSM ConfigItem'} = 'ITSM ConfigItem';
    $Self->{Translation}->{'ITSM config item overview.'} = 'ITSM yapılandırma öğesine genel bakış.';
    $Self->{Translation}->{'InciState'} = 'InciState';
    $Self->{Translation}->{'IncidentState'} = 'IncidentState';
    $Self->{Translation}->{'Includes deployment states in the config item search of the customer interface.'} =
        'Müşteri arayüzünün yapılandırma öğesi aramasında dağıtım durumlarını içerir.';
    $Self->{Translation}->{'Includes incident states in the config item search of the customer interface.'} =
        'Müşteri arayüzünün yapılandırma öğesi aramasına olay durumlarını dahil eder.';
    $Self->{Translation}->{'Maximum number of config items to be displayed in the result of this operation.'} =
        'Bu işlemin sonucunda görüntülenecek maksimum yapılandırma öğesi sayısı.';
    $Self->{Translation}->{'Module to check the group responsible for a class.'} = 'Bir sınıftan sorumlu grubu kontrol etmek için modül.';
    $Self->{Translation}->{'Module to check the group responsible for a configuration item.'} =
        'Bir yapılandırma öğesinden sorumlu grubu kontrol etmek için modül.';
    $Self->{Translation}->{'Module to generate ITSM config item statistics.'} = 'ITSM yapılandırma öğesi istatistikleri oluşturmak için modül.';
    $Self->{Translation}->{'Name Module'} = 'İsim Modülü';
    $Self->{Translation}->{'Number Module'} = 'Numara Modülü';
    $Self->{Translation}->{'Number of config items to be displayed in each page of a search result in the agent interface.'} =
        'Aracı arayüzünde bir arama sonucunun her sayfasında görüntülenecek yapılandırma öğelerinin sayısı.';
    $Self->{Translation}->{'Number of config items to be displayed in each page of a search result in the customer interface.'} =
        'Müşteri arayüzünde bir arama sonucunun her sayfasında görüntülenecek yapılandırma öğelerinin sayısı.';
    $Self->{Translation}->{'Objects to search for, how many entries and which attributs to show. ConfigItem attributes have to explicitly be stored via Elasticsearch.'} =
        'Aranacak nesneler, kaç giriş ve hangi özniteliklerin gösterileceği. ConfigItem özniteliklerinin Elasticsearch aracılığıyla açıkça depolanması gerekir.';
    $Self->{Translation}->{'Overview.'} = 'Genel bakış.';
    $Self->{Translation}->{'Parameters for the categories for config item classes in the preferences view of the agent interface.'} =
        'Temsilci arayüzünün tercihler görünümünde yapılandırma öğesi sınıfları kategorileri için parametreler.';
    $Self->{Translation}->{'Parameters for the column filters of the small config item overview. Please note: setting \'Active\' to 0 will only prevent agents from editing settings of this group in their personal preferences, but will still allow administrators to edit the settings of another user\'s behalf. Use \'PreferenceGroup\' to control in which area these settings should be shown in the user interface.'} =
        'Küçük yapılandırma öğesine genel bakışın sütun filtreleri için parametreler. Lütfen dikkat: \'Aktif\' değerini 0 olarak ayarlamak, temsilcilerin bu grubun ayarlarını kişisel tercihlerinde düzenlemelerini engeller, ancak yöneticilerin başka bir kullanıcı adına ayarları düzenlemelerine izin verir. Bu ayarların kullanıcı arayüzünde hangi alanda gösterileceğini kontrol etmek için \'PreferenceGroup\' kullanın.';
    $Self->{Translation}->{'Parameters for the dashboard backend of the customer company config item overview of the agent interface . "Limit" is the number of entries shown by default. "Group" is used to restrict the access to the plugin (e. g. Group: admin;group1;group2;). "Default" determines if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" is the cache time in minutes for the plugin.'} =
        'Müşteri temsilcisi arayüzünün müşteri şirketi yapılandırma öğesi genel bakışının gösterge tablosu arka ucu için parametreler. "Limit" varsayılan olarak gösterilen giriş sayısıdır. "Grup" eklentiye erişimi kısıtlamak için kullanılır (örn. Grup: admin;group1;group2;). "Varsayılan" eklentinin varsayılan olarak etkin olup olmadığını veya kullanıcının manuel olarak etkinleştirmesi gerekip gerekmediğini belirler. "CacheTTLLocal" eklenti için dakika cinsinden önbellek süresidir.';
    $Self->{Translation}->{'Parameters for the deployment states color in the preferences view of the agent interface.'} =
        'Dağıtım durumları için parametreler, müşteri temsilcisi arayüzünün tercihler görünümünde renklendirilir.';
    $Self->{Translation}->{'Parameters for the deployment states in the preferences view of the agent interface.'} =
        'Temsilci arayüzünün tercihler görünümündeki dağıtım durumları için parametreler.';
    $Self->{Translation}->{'Parameters for the example permission groups of the general catalog attributes.'} =
        'Genel katalog özniteliklerinin örnek izin gruplarının parametreleri.';
    $Self->{Translation}->{'Parameters for the name module for config item classes in the preferences view of the agent interface.'} =
        'Temsilci arayüzünün tercihler görünümünde yapılandırma öğesi sınıfları için ad modülü parametreleri.';
    $Self->{Translation}->{'Parameters for the number module for config item classes in the preferences view of the agent interface.'} =
        'Temsilci arayüzünün tercihler görünümünde yapılandırma öğesi sınıfları için sayı modülü parametreleri.';
    $Self->{Translation}->{'Parameters for the pages (in which the configuration items are shown).'} =
        'Sayfalar için parametreler (yapılandırma öğelerinin gösterildiği).';
    $Self->{Translation}->{'Parameters for the version string module for config item classes in the preferences view of the agent interface.'} =
        'Temsilci arayüzünün tercihler görünümünde yapılandırma öğesi sınıfları için sürüm dizesi modülü parametreleri.';
    $Self->{Translation}->{'Parameters for the version string template toolkit module for config item classes in the preferences view of the agent interface.'} =
        'Temsilci arayüzünün tercihler görünümündeki yapılandırma öğesi sınıfları için sürüm dizesi şablon araç seti modülü parametreleri.';
    $Self->{Translation}->{'Parameters for the version trigger for config item classes in the preferences view of the agent interface.'} =
        'Temsilci arayüzünün tercihler görünümünde yapılandırma öğesi sınıfları için sürüm tetikleyicisi parametreleri.';
    $Self->{Translation}->{'Performs the configured action for each event (as an Invoker) for each configured Webservice.'} =
        'Yapılandırılmış her Webservice için her olay için (Invoker olarak) yapılandırılmış eylemi gerçekleştirir.';
    $Self->{Translation}->{'Permission Group'} = 'İzin grubu';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item attachment action in the agent interface.'} =
        'Temsilci arayüzünde ITSM yapılandırma öğesi ekleme eylemini kullanmak için gerekli izinler.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item screen in the agent interface.'} =
        'Temsilci arayüzünde ITSM yapılandırma öğesi ekranını kullanmak için gerekli izinler.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item search screen in the agent interface.'} =
        'Temsilci arayüzünde ITSM yapılandırma öğesi arama ekranını kullanmak için gerekli izinler.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item search screen in the customer interface.'} =
        'Müşteri arayüzünde ITSM yapılandırma öğesi arama ekranını kullanmak için gerekli izinler.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item tree view screen in the agent interface.'} =
        'Temsilci arayüzünde ITSM yapılandırma öğesi ağaç görünümü ekranını kullanmak için gerekli izinler.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item zoom screen in the agent interface.'} =
        'Temsilci arayüzünde ITSM yapılandırma öğesi yakınlaştırma ekranını kullanmak için gerekli izinler.';
    $Self->{Translation}->{'Required permissions to use the add ITSM configuration item screen in the agent interface.'} =
        'Temsilci arayüzünde ITSM yapılandırma öğesi ekleme ekranını kullanmak için gerekli izinler.';
    $Self->{Translation}->{'Required permissions to use the bulk ITSM configuration item screen in the agent interface.'} =
        'Temsilci arayüzünde toplu ITSM yapılandırma öğesi ekranını kullanmak için gerekli izinler.';
    $Self->{Translation}->{'Required permissions to use the edit ITSM configuration item screen in the agent interface.'} =
        'Temsilci arayüzünde ITSM yapılandırma öğesi düzenleme ekranını kullanmak için gerekli izinler.';
    $Self->{Translation}->{'Required permissions to use the history ITSM configuration item screen in the agent interface.'} =
        'Temsilci arayüzünde geçmiş ITSM yapılandırma öğesi ekranını kullanmak için gerekli izinler.';
    $Self->{Translation}->{'Required permissions to use the print ITSM configuration item screen in the agent interface.'} =
        'Temsilci arayüzünde ITSM yapılandırma öğesi yazdır ekranını kullanmak için gerekli izinler.';
    $Self->{Translation}->{'Required privileges to delete config items.'} = 'Yapılandırma öğelerini silmek için gerekli ayrıcalıklar.';
    $Self->{Translation}->{'Search config items.'} = 'Yapılandırma öğelerini arayın.';
    $Self->{Translation}->{'Set the incident state of a CI automatically when a Ticket is Linked to a CI.'} =
        'Bir Bilet bir CI\'ya Bağlandığında CI\'nın olay durumunu otomatik olarak ayarlayın.';
    $Self->{Translation}->{'Sets the deployment state in the configuration item bulk screen of the agent interface.'} =
        'Aracı arayüzünün yapılandırma öğesi toplu ekranında dağıtım durumunu ayarlar.';
    $Self->{Translation}->{'Sets the incident state in the configuration item bulk screen of the agent interface.'} =
        'Temsilci arayüzünün yapılandırma öğesi toplu ekranında olay durumunu ayarlar.';
    $Self->{Translation}->{'Shows a link in the menu that allows linking a configuration item with another object in the config item zoom view of the agent interface.'} =
        'Menüde, aracı arayüzünün yapılandırma öğesi yakınlaştırma görünümünde bir yapılandırma öğesini başka bir nesneyle ilişkilendirmeyi sağlayan bir bağlantı gösterir.';
    $Self->{Translation}->{'Shows a link in the menu to access the history of a configuration item in the configuration item overview of the agent interface.'} =
        'Temsilci arayüzünün yapılandırma öğesi genel görünümündeki bir yapılandırma öğesinin geçmişine erişmek için menüde bir bağlantı gösterir.';
    $Self->{Translation}->{'Shows a link in the menu to access the history of a configuration item in the its zoom view of the agent interface.'} =
        'Temsilci arayüzünün yakınlaştırma görünümünde bir yapılandırma öğesinin geçmişine erişmek için menüde bir bağlantı gösterir.';
    $Self->{Translation}->{'Shows a link in the menu to delete a configuration item in its zoom view of the agent interface.'} =
        'Temsilci arayüzünün yakınlaştırma görünümünde bir yapılandırma öğesini silmek için menüde bir bağlantı gösterir.';
    $Self->{Translation}->{'Shows a link in the menu to display the configuration item links as a Tree View.'} =
        'Yapılandırma öğesi bağlantılarını Ağaç Görünümü olarak görüntülemek için menüde bir bağlantı gösterir.';
    $Self->{Translation}->{'Shows a link in the menu to duplicate a configuration item in the configuration item overview of the agent interface.'} =
        'Temsilci arayüzünün yapılandırma öğesi genel görünümünde bir yapılandırma öğesini çoğaltmak için menüde bir bağlantı gösterir.';
    $Self->{Translation}->{'Shows a link in the menu to duplicate a configuration item in the its zoom view of the agent interface.'} =
        'Temsilci arayüzünün yakınlaştırma görünümünde bir yapılandırma öğesini çoğaltmak için menüde bir bağlantı gösterir.';
    $Self->{Translation}->{'Shows a link in the menu to edit a configuration item in the its zoom view of the agent interface.'} =
        'Temsilci arayüzünün yakınlaştırma görünümünde bir yapılandırma öğesini düzenlemek için menüde bir bağlantı gösterir.';
    $Self->{Translation}->{'Shows a link in the menu to go back in the configuration item zoom view of the agent interface.'} =
        'Temsilci arayüzünün yapılandırma öğesi yakınlaştırma görünümüne geri dönmek için menüde bir bağlantı gösterir.';
    $Self->{Translation}->{'Shows a link in the menu to print a configuration item in the its zoom view of the agent interface.'} =
        'Temsilci arayüzünün yakınlaştırma görünümünde bir yapılandırma öğesini yazdırmak için menüde bir bağlantı gösterir.';
    $Self->{Translation}->{'Shows a link in the menu to zoom into a configuration item in the configuration item overview of the agent interface.'} =
        'Temsilci arayüzünün yapılandırma öğesi genel görünümünde bir yapılandırma öğesini yakınlaştırmak için menüde bir bağlantı gösterir.';
    $Self->{Translation}->{'Shows the config item history (reverse ordered) in the agent interface.'} =
        'Temsilci arayüzünde yapılandırma öğesi geçmişini (ters sıralı) gösterir.';
    $Self->{Translation}->{'The default category which is shown, if none is selected.'} = 'Hiçbiri seçilmemişse gösterilen varsayılan kategori.';
    $Self->{Translation}->{'The identifier for a configuration item, e.g. ConfigItem#, MyConfigItem#. The default is ConfigItem#.'} =
        'Bir yapılandırma öğesinin tanımlayıcısı, örneğin ConfigItem#, MyConfigItem#. Varsayılan ConfigItem#\'dir.';
    $Self->{Translation}->{'Triggers ConfigItemFetch invoker automatically.'} = 'ConfigItemFetch çağırıcısını otomatik olarak tetikler.';
    $Self->{Translation}->{'Version String Expression'} = 'Sürüm Dizesi İfadesi';
    $Self->{Translation}->{'Version String Module'} = 'Sürüm Dizesi Modülü';
    $Self->{Translation}->{'Version Trigger'} = 'Sürüm Tetikleyici';
    $Self->{Translation}->{'Whether the execution of ConfigItemACL can be avoided by checking cached field dependencies. This can improve loading times of formulars, but has to be disabled, if ACLModules are to be used for ITSMConfigItem- and Form-ReturnTypes.'} =
        'ConfigItemACL\'nin yürütülmesinin önbelleğe alınmış alan bağımlılıklarını kontrol ederek önlenip önlenemeyeceği. Bu, formülerlerin yükleme sürelerini iyileştirebilir, ancak ACLModülleri ITSMConfigItem- ve Form-ReturnTypes için kullanılacaksa devre dışı bırakılmalıdır.';
    $Self->{Translation}->{'Which general information is shown in the header.'} = 'Başlıkta hangi genel bilgiler gösterilir.';
    $Self->{Translation}->{'class'} = 'sınıf';
    $Self->{Translation}->{'global'} = 'küresel';
    $Self->{Translation}->{'postproductive'} = 'ÜREME SONRASI';
    $Self->{Translation}->{'preproductive'} = 'ÜREME ÖNCESİ';
    $Self->{Translation}->{'productive'} = 'üretken';


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

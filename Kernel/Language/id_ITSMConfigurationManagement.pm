# --
# OTOBO is a web-based ticketing system for service organisations.
# --
# Copyright (C) 2001-2020 OTRS AG, https://otrs.com/
# Copyright (C) 2019-2025 Rother OSS GmbH, https://otobo.io/
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

package Kernel::Language::id_ITSMConfigurationManagement;

use strict;
use warnings;
use utf8;

sub Data {
    my $Self = shift;

    # Template: AdminGenericInterfaceOperationConfigItem
    $Self->{Translation}->{'General operation data'} = '';
    $Self->{Translation}->{'Settings for incoming request data'} = '';
    $Self->{Translation}->{'Settings for outgoing response data'} = '';

    # Template: AdminITSMConfigItem
    $Self->{Translation}->{'Config Item Management'} = 'Pengelolaan item konfigurasi';
    $Self->{Translation}->{'Change class definition'} = 'ubah definisi kelas';
    $Self->{Translation}->{'Change role definition'} = 'Mengubah definisi peran';
    $Self->{Translation}->{'Ready2Import Class Bundles'} = 'Bundel Kelas Ready2Import';
    $Self->{Translation}->{'Here you can import Ready2Import class bundles showcasing our most usual config items. Please note that some additional configuration may be required.'} =
        'Di sini Anda dapat mengimpor bundel kelas Ready2Import yang menampilkan item konfigurasi yang paling umum. Harap dicatat bahwa beberapa konfigurasi tambahan mungkin diperlukan.';
    $Self->{Translation}->{'Update existing entities'} = 'Memperbarui entitas yang ada';
    $Self->{Translation}->{'Import Ready2Adopt class bundles'} = 'Mengimpor bundel kelas Ready2Adopt';
    $Self->{Translation}->{'Config Item Class'} = 'Kelas Item Konfigurasi';
    $Self->{Translation}->{'Config Item Role'} = 'Peran Item Konfigurasi';

    # Template: AgentITSMConfigItemAdd
    $Self->{Translation}->{'Config Item'} = 'Item konfigurasi';
    $Self->{Translation}->{'Filter for Classes'} = 'Saringan untuk kelas-kelas';
    $Self->{Translation}->{'Select a Class from the list to create a new Config Item.'} = 'Pilih satu kelas dari datar untuk membuat sebuah item konfigurasi baru';
    $Self->{Translation}->{'Class'} = 'Kelas';

    # Template: AgentITSMConfigItemBulk
    $Self->{Translation}->{'ITSM ConfigItem Bulk Action'} = 'Tindakan masal ItemKonfigurasi ITSM';
    $Self->{Translation}->{'Deployment state'} = 'Status penyebaran';
    $Self->{Translation}->{'Incident state'} = 'Status insiden';
    $Self->{Translation}->{'Link to another'} = 'Tautan untuk ke lainnya';
    $Self->{Translation}->{'Invalid Configuration Item number!'} = 'Nomor item konfigurasi tidak sah';
    $Self->{Translation}->{'The number of another Configuration Item to link with.'} = 'Jumlah item konfigurasi lainnya yang akan di hubungkan';

    # Template: AgentITSMConfigItemDelete
    $Self->{Translation}->{'Do you really want to delete this config item?'} = 'Apakah Anda benar-benar ingin menghapus item konfigurasi ini?';

    # Template: AgentITSMConfigItemEdit
    $Self->{Translation}->{'The name of this config item'} = 'Nama item konfigurasi ini';
    $Self->{Translation}->{'Name is already in use by the ConfigItems with the following Number(s): %s'} =
        'Nama ini telah di gunakan oleh ItemKonfigurasi dengan nomor(nomor-nomor) berikut: %s';
    $Self->{Translation}->{'Version Number'} = 'Nomor versi';
    $Self->{Translation}->{'Version number of this config item'} = 'Nomor versi item konfigurasi ini';
    $Self->{Translation}->{'Version Number is already in use by the ConfigItems with the following Number(s): %s'} =
        'Nomor Versi sudah digunakan oleh ConfigItems dengan Nomor berikut ini: %s';
    $Self->{Translation}->{'Deployment State'} = 'Status penyebaran';
    $Self->{Translation}->{'Incident State'} = 'Kondisi insiden';

    # Template: AgentITSMConfigItemHistory
    $Self->{Translation}->{'History of Config Item: %s'} = 'Riwayat Item Konfigurasi: %s';
    $Self->{Translation}->{'History Content'} = 'Isi sejarah';
    $Self->{Translation}->{'Createtime'} = 'BuatWaktu';
    $Self->{Translation}->{'Zoom view'} = 'Pandangan dekat';

    # Template: AgentITSMConfigItemOverviewNavBar
    $Self->{Translation}->{'Config Items per page'} = 'Item konfigurasi per halaman';

    # Template: AgentITSMConfigItemOverviewSmall
    $Self->{Translation}->{'No config item data found.'} = 'Tidak ditemukan data item konfigurasi.';
    $Self->{Translation}->{'Select this config item'} = 'Pilih item konfigurasi ini';

    # Template: AgentITSMConfigItemSearch
    $Self->{Translation}->{'Run Search'} = 'Mulai Pencarian';
    $Self->{Translation}->{'Also search in previous versions?'} = 'Cari di versi sebelumnya juga ?';

    # Template: AgentITSMConfigItemTreeView
    $Self->{Translation}->{'TreeView for ConfigItem'} = 'TreeView untuk ConfigItem';
    $Self->{Translation}->{'Depth Level'} = 'Tingkat Kedalaman';
    $Self->{Translation}->{'Zoom In/Out'} = 'Memperbesar/Memperkecil';
    $Self->{Translation}->{'Max links level reached for ConfigItem!'} = 'Tingkat tautan maksimum tercapai untuk ConfigItem!';

    # Template: AgentITSMConfigItemZoom
    $Self->{Translation}->{'Configuration Item'} = 'Item Konfigurasi';
    $Self->{Translation}->{'Configuration Item Information'} = 'Informasi item konfigurasi';
    $Self->{Translation}->{'Current Deployment State'} = 'Status penyebaraan saat ini';
    $Self->{Translation}->{'Current Incident State'} = 'Kondisi insiden saat ini';
    $Self->{Translation}->{'Last changed'} = 'Terakhir diubah';
    $Self->{Translation}->{'Last changed by'} = 'Terakhir dirubah oleh';

    # Template: CustomerITSMConfigItem
    $Self->{Translation}->{'Your ConfigItems'} = 'Item Konfigurasi Anda';

    # Template: CustomerITSMConfigItemSearch
    $Self->{Translation}->{'ConfigItem Search'} = 'Pencarian Item Konfigurasi';

    # Template: AdminACL
    $Self->{Translation}->{'Object Type'} = 'Jenis Objek';

    # JS Template: ClassImportConfirm
    $Self->{Translation}->{'The following classes will be imported'} = 'Kelas-kelas berikut akan diimpor';
    $Self->{Translation}->{'The following roles will be imported'} = 'Peran-peran berikut ini akan diimpor';
    $Self->{Translation}->{'Note that also corresponding dynamic fields and GeneralCatalog classes will be created and there is no automatic removal.'} =
        'Perhatikan bahwa bidang dinamis dan kelas GeneralCatalog yang sesuai juga akan dibuat dan tidak ada penghapusan otomatis.';
    $Self->{Translation}->{'Do you want to proceed?'} = 'Apakah Anda ingin melanjutkan?';

    # Perl Module: Kernel/Modules/AdminITSMConfigItem.pm
    $Self->{Translation}->{'Need ExampleClasses!'} = 'Butuh ExampleClasses!';
    $Self->{Translation}->{'Definition is no valid YAML hash.'} = 'Definisi tidak ada hash YAML yang valid.';

    # Perl Module: Kernel/Modules/AgentITSMConfigItem.pm
    $Self->{Translation}->{'Overview: ITSM ConfigItem'} = 'Gambaran umum: Item Konfigurasi ITSM';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemBulk.pm
    $Self->{Translation}->{'No ConfigItemID is given!'} = 'Tidak ada ConfigItemID yang diberikan!';
    $Self->{Translation}->{'You need at least one selected Configuration Item!'} = 'Anda memerlukan setidaknya satu Item Konfigurasi yang dipilih!';
    $Self->{Translation}->{'You don\'t have write access to this configuration item: %s.'} =
        'Anda tidak memiliki akses tulis ke item konfigurasi ini: %s.';
    $Self->{Translation}->{'No definition was defined for class %s!'} = 'Tidak ada definisi yang didefinisikan untuk kelas %s!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemDelete.pm
    $Self->{Translation}->{'Config item "%s" not found in database!'} = 'Item konfigurasi "%s" tidak ditemukan dalam database!';
    $Self->{Translation}->{'Was not able to delete the configitem ID %s!'} = 'Tidak dapat menghapus ID konfigurasi %s!';
    $Self->{Translation}->{'No version found for ConfigItemID %s!'} = 'Tidak ditemukan versi untuk ConfigItemID %s!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemEdit.pm
    $Self->{Translation}->{'No ConfigItemID, DuplicateID or ClassID is given!'} = 'Tidak ada ConfigItemID, DuplicateID atau ClassID yang diberikan!';
    $Self->{Translation}->{'No access is given!'} = 'Tidak ada akses yang diberikan!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemHistory.pm
    $Self->{Translation}->{'Can\'t show history, no ConfigItemID is given!'} = 'Tidak dapat menampilkan riwayat, tidak ada ConfigItemID yang diberikan!';
    $Self->{Translation}->{'Can\'t show history, no access rights given!'} = 'Tidak dapat menampilkan riwayat, tidak ada hak akses yang diberikan!';
    $Self->{Translation}->{'New ConfigItem (ID=%s)'} = 'Item Konfigurasi Baru (ID=%s)';
    $Self->{Translation}->{'New version (ID=%s)'} = 'Versi baru (ID=%s)';
    $Self->{Translation}->{'Deployment state updated (new=%s, old=%s)'} = 'Status penerapan diperbarui (baru = %s, lama = %s)';
    $Self->{Translation}->{'Incident state updated (new=%s, old=%s)'} = 'Status insiden diperbarui (baru = %s, lama = %s)';
    $Self->{Translation}->{'ConfigItem (ID=%s) deleted'} = 'ConfigItem (ID=%s) dihapus';
    $Self->{Translation}->{'Link to %s (type=%s) added'} = 'Tautan ke %s (tipe = %s) ditambahkan';
    $Self->{Translation}->{'Link to %s (type=%s) deleted'} = 'Tautan ke %s (tipe = %s) dihapus';
    $Self->{Translation}->{'ConfigItem definition updated (ID=%s)'} = 'Definisi ConfigItem diperbarui (ID=%s)';
    $Self->{Translation}->{'Name updated (new=%s, old=%s)'} = 'Nama diperbarui (baru = %s, lama = %s)';
    $Self->{Translation}->{'Attribute %s updated from "%s" to "%s"'} = 'Atribut %s diperbarui dari "%s" menjadi "%s"';
    $Self->{Translation}->{'Version %s deleted'} = 'Versi %s dihapus';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemPrint.pm
    $Self->{Translation}->{'No ConfigItemID or VersionID is given!'} = 'Tidak ada ConfigItemID atau VersionID yang diberikan!';
    $Self->{Translation}->{'Can\'t show config item, no access rights given!'} = 'Tidak dapat menampilkan item konfigurasi, tidak ada hak akses yang diberikan!';
    $Self->{Translation}->{'ConfigItemID %s not found in database!'} = 'ConfigItemID% tidak ditemukan dalam database!';
    $Self->{Translation}->{'ConfigItem'} = 'ItemKonfigurasi';
    $Self->{Translation}->{'printed by %s at %s'} = 'dicetak oleh%s pada%s';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemSearch.pm
    $Self->{Translation}->{'Invalid ClassID!'} = 'ClassID tidak valid!';
    $Self->{Translation}->{'No ClassID is given!'} = 'Tidak ada ClassID yang diberikan!';
    $Self->{Translation}->{'No access rights for this class given!'} = 'Tidak ada hak akses untuk kelas ini!';
    $Self->{Translation}->{'No Result!'} = 'Tidak ada hasil!';
    $Self->{Translation}->{'Config Item Search Results'} = 'Konfigurasi pencarian nilai';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemZoom.pm
    $Self->{Translation}->{'Can\'t show item, no access rights for ConfigItem are given!'} =
        'Tidak dapat menampilkan item, tidak ada hak akses untuk ConfigItem yang diberikan!';
    $Self->{Translation}->{'ConfigItem not found!'} = 'ConfigItem tidak ditemukan!';
    $Self->{Translation}->{'No versions found!'} = 'Tidak ada versi yang ditemukan!';
    $Self->{Translation}->{'operational'} = 'operasional';
    $Self->{Translation}->{'warning'} = 'peringatan';
    $Self->{Translation}->{'incident'} = 'insiden';
    $Self->{Translation}->{'The deployment state of this config item'} = 'Status penyebaran item konfigurasi ini';
    $Self->{Translation}->{'The incident state of this config item'} = 'Status insiden item konfigurasi ini';

    # Perl Module: Kernel/Modules/CustomerITSMConfigItemSearch.pm
    $Self->{Translation}->{'No permission'} = 'Tidak ada izin';
    $Self->{Translation}->{'Filter invalid!'} = 'Filter tidak valid!';
    $Self->{Translation}->{'Search params invalid!'} = 'Parameter pencarian tidak valid!';

    # Perl Module: Kernel/Output/HTML/Dashboard/ITSMConfigItemGeneric.pm
    $Self->{Translation}->{'Shown config items'} = 'Item konfigurasi yang ditampilkan';
    $Self->{Translation}->{'Deployment State Type'} = 'Tipe status penyebaran';
    $Self->{Translation}->{'Current Incident State Type'} = 'Tipe Status insiden saat ini';

    # Perl Module: Kernel/Output/HTML/ITSMConfigItem/LayoutDate.pm
    $Self->{Translation}->{'Between'} = 'Diantara';

    # Perl Module: Kernel/System/DynamicField/Driver/ConfigItem.pm
    $Self->{Translation}->{'Class restrictions for the config item'} = 'Pembatasan kelas untuk item konfigurasi';
    $Self->{Translation}->{'Select one or more classes to restrict selectable config items'} =
        'Pilih satu kelas atau lebih untuk membatasi item konfigurasi yang dapat dipilih';
    $Self->{Translation}->{'Link type'} = 'Jenis tautan';
    $Self->{Translation}->{'Select the link type.'} = 'Pilih jenis tautan.';
    $Self->{Translation}->{'Forwards: Referencing (Source) -> Referenced (Target)'} = 'Ke depan: Merujuk (Sumber) -> Merujuk (Target)';
    $Self->{Translation}->{'Backwards: Referenced (Source) -> Referencing (Target)'} = 'Mundur: Merujuk (Sumber) -> Merujuk (Target)';
    $Self->{Translation}->{'Link Direction'} = 'Arah Tautan';
    $Self->{Translation}->{'The referencing object is the one containing this dynamic field, the referenced object is the one selected as value of the dynamic field.'} =
        'Objek yang direferensikan adalah objek yang berisi bidang dinamis ini, objek yang direferensikan adalah objek yang dipilih sebagai nilai bidang dinamis.';
    $Self->{Translation}->{'Dynamic (ConfigItem)'} = 'Dinamis (ConfigItem)';
    $Self->{Translation}->{'Static (Version)'} = 'Statis (Versi)';
    $Self->{Translation}->{'Link Referencing Type'} = 'Jenis Referensi Tautan';
    $Self->{Translation}->{'Whether this link applies to the ConfigItem or the static version of the referencing object. Current Incident State calculation only is performed on dynamic links.'} =
        'Apakah tautan ini berlaku untuk ConfigItem atau versi statis dari objek referensi. Perhitungan Status Insiden saat ini hanya dilakukan pada tautan dinamis.';
    $Self->{Translation}->{'Select the attribute which config items will be searched by'} = 'Pilih atribut yang akan dicari berdasarkan item konfigurasi';

    # Perl Module: Kernel/System/ITSMConfigItem/Definition.pm
    $Self->{Translation}->{'Base structure is not valid. Please provide a hash with data in YAML format.'} =
        'Struktur dasar tidak valid. Berikan hash dengan data dalam format YAML.';
    $Self->{Translation}->{'Starting the YAML string with \'---\' is required.'} = 'Memulai string YAML dengan \'---\' diperlukan.';

    # Perl Module: Kernel/System/ITSMConfigItem/Link.pm
    $Self->{Translation}->{'Could not purge the table configitem_link.'} = 'Tidak dapat membersihkan tabel configitem_link.';
    $Self->{Translation}->{'No relevant dynamic fields were found'} = 'Tidak ada bidang dinamis yang relevan yang ditemukan';
    $Self->{Translation}->{'Could not insert into the table configitem_link'} = 'Tidak dapat menyisipkan ke dalam tabel configitem_link';
    $Self->{Translation}->{'Inserted 0 rows into the table configitem_link'} = 'Menyisipkan 0 baris ke dalam tabel configitem_link';

    # Perl Module: Kernel/System/ImportExport/ObjectBackend/ITSMConfigItem.pm
    $Self->{Translation}->{'Maximum number of one element'} = 'Jumlah maksimum dari 1 elemen';
    $Self->{Translation}->{'Empty fields indicate that the current values are kept'} = 'Bidang kosong mengindikasikan bahwa nilai saat ini disimpan';
    $Self->{Translation}->{'Import/Export attachments (as the last entries per line)'} = '';
    $Self->{Translation}->{'Version String'} = '';
    $Self->{Translation}->{'Skipped'} = 'Dilewati';

    # Perl Module: Kernel/Modules/AdminDynamicField.pm
    $Self->{Translation}->{'Error synchronizing the definitions. Please check the log.'} = 'Kesalahan menyinkronkan definisi. Silakan periksa log.';
    $Self->{Translation}->{'You have ITSMConfigItem definitions which are not synchronized. Please deploy your ITSMConfigItem dynamic field changes.'} =
        'Anda memiliki definisi ITSMConfigItem yang tidak tersinkronisasi. Terapkan perubahan bidang dinamis ITSMConfigItem Anda.';

    # Database XML / SOPM Definition: ITSMConfigurationManagement.sopm
    $Self->{Translation}->{'Expired'} = 'Telah kadaluarsa';
    $Self->{Translation}->{'Maintenance'} = 'Pemeliharaan';
    $Self->{Translation}->{'Pilot'} = 'Pilot';
    $Self->{Translation}->{'Planned'} = 'Telah direncanakan';
    $Self->{Translation}->{'Repair'} = 'Perbaiki';
    $Self->{Translation}->{'Retired'} = 'Pensiun';
    $Self->{Translation}->{'Review'} = 'Ulasan';
    $Self->{Translation}->{'Test/QA'} = 'Uji/QA';

    # JS File: ITSM.Admin.ITSMConfigItem
    $Self->{Translation}->{'Overview and Confirmation'} = 'Ikhtisar dan Konfirmasi';
    $Self->{Translation}->{'Importing classes/roles and their related fields'} = 'Mengimpor kelas/peran dan bidang terkaitnya';
    $Self->{Translation}->{'An error occurred during class import.'} = 'Terjadi kesalahan saat mengimpor kelas.';

    # SysConfig
    $Self->{Translation}->{'0 - Hidden'} = '0 - Tersembunyi';
    $Self->{Translation}->{'1 - Shown'} = '1 - Ditampilkan';
    $Self->{Translation}->{'Allows extended search conditions in config item search of the agent interface. With this feature you can search e. g. config item name with this kind of conditions like "(*key1*&&*key2*)" or "(*key1*||*key2*)".'} =
        'Memungkinkan kondisi pencarian yang diperluas dalam pencarian item konfigurasi pada antarmuka agen. Dengan fitur ini, Anda dapat mencari, misalnya nama item konfigurasi dengan kondisi seperti ini, seperti "(*key1*&&*key2*)" atau "(*key1*||*key2*)".';
    $Self->{Translation}->{'Allows extended search conditions in config item search of the customer interface. With this feature you can search e. g. config item name with this kind of conditions like "(*key1*&&*key2*)" or "(*key1*||*key2*)".'} =
        'Memungkinkan kondisi pencarian yang diperluas dalam pencarian item konfigurasi pada antarmuka pelanggan. Dengan fitur ini, Anda dapat mencari, misalnya nama item konfigurasi dengan kondisi seperti ini seperti "(*key1*&&*key2*)" atau "(*key1*||*key2*)".';
    $Self->{Translation}->{'Assigned CIs'} = 'CI yang ditugaskan';
    $Self->{Translation}->{'At a specific time point create a ticket for config items, if the configured requirements are met. The time point is determined by the value of the field configured under "TimeCIKey" of the ConfigItem, and modified by "TimeModifier". If the latter can be either just a number, or a sign (+/-), a number, and an unit (d/h/m): "7" is equivalent to "+7d". The DynamicField "Ticket->DynamicField" will be used to mark created tickets - it has to exist. The flags \<OTOBO_CONFIGITEM_X\> where X can be NAME, NUMBER and DATE, will be substituted with the respective values in "Ticket->Text".'} =
        'Pada titik waktu tertentu, buatlah tiket untuk item konfigurasi, jika persyaratan yang dikonfigurasi terpenuhi. Titik waktu ditentukan oleh nilai bidang yang dikonfigurasi di bawah "TimeCIKey" pada ConfigItem, dan dimodifikasi oleh "TimeModifier". Jika yang terakhir ini dapat berupa angka, atau tanda (+/-), angka, dan unit (d/h/m): "7" setara dengan "+7d". DynamicField "Ticket->DynamicField" akan digunakan untuk menandai tiket yang telah dibuat - harus ada. Bendera \<OTOBO_CONFIGITEM_X\> di mana X dapat berupa NAMA, NOMOR dan TANGGAL, akan digantikan dengan nilai masing-masing di "Ticket->Text".';
    $Self->{Translation}->{'CIs assigned to customer company'} = 'CI yang ditugaskan ke perusahaan pelanggan';
    $Self->{Translation}->{'CIs assigned to customer user'} = 'CI yang diberikan kepada pengguna pelanggan';
    $Self->{Translation}->{'CMDB Settings'} = 'Pengaturan CMDB';
    $Self->{Translation}->{'Check for a unique name only within the same ConfigItem class (\'class\') or globally (\'global\'), which means every existing ConfigItem is taken into account when looking for duplicates.'} =
        'Periksa hanya nama unik saja di dalam kelas(\'kelas\') itemkonfigurasi yang sama atau secara global (\'global), yang berarti setiap ItemKonfigurasi yang ada akan diperhitungkan ketika mencari duplikat';
    $Self->{Translation}->{'Choose a module to enforce a naming scheme.'} = 'Pilih modul untuk menerapkan skema penamaan.';
    $Self->{Translation}->{'Choose a module to enforce a number scheme.'} = 'Pilih modul untuk menerapkan skema angka.';
    $Self->{Translation}->{'Choose a module to enforce a version string scheme.'} = 'Pilih modul untuk menerapkan skema string versi.';
    $Self->{Translation}->{'Choose attributes to trigger the creation of a new version.'} = 'Pilih atribut untuk memicu pembuatan versi baru.';
    $Self->{Translation}->{'Choose categories to assign to this config item class.'} = 'Pilih kategori yang akan ditetapkan ke kelas item konfigurasi ini.';
    $Self->{Translation}->{'Column config item filters for ConfigItem Overview.'} = 'Filter item konfigurasi kolom untuk Ikhtisar Item Konfigurasi.';
    $Self->{Translation}->{'Columns that can be filtered in the config item overview of the agent interface. Note: Only Config Item attributes and Dynamic Fields (DynamicField_NameX) are allowed.'} =
        'Kolom yang dapat difilter dalam ikhtisar item konfigurasi pada antarmuka agen. Catatan: Hanya atribut Item Konfigurasi dan Bidang Dinamis (DynamicField_NameX) yang diperbolehkan.';
    $Self->{Translation}->{'Columns that can be filtered in the config item overview of the customer interface. Note: Only Config Item attributes and Dynamic Fields (DynamicField_NameX) are allowed.'} =
        'Kolom yang dapat difilter dalam ikhtisar item konfigurasi pada antarmuka pelanggan. Catatan: Hanya atribut Item Konfigurasi dan Bidang Dinamis (DynamicField_NameX) yang diperbolehkan.';
    $Self->{Translation}->{'Columns that can be filtered in the config item search result overview of the agent interface. Note: Only Config Item attributes and Dynamic Fields (DynamicField_NameX) are allowed.'} =
        'Kolom yang dapat difilter dalam ikhtisar hasil pencarian item konfigurasi pada antarmuka agen. Catatan: Hanya atribut Item Konfigurasi dan Bidang Dinamis (DynamicField_NameX) yang diperbolehkan.';
    $Self->{Translation}->{'Config Items'} = 'item konfigurasi';
    $Self->{Translation}->{'Config item add.'} = 'Tambah item konfigurasi.';
    $Self->{Translation}->{'Config item edit.'} = 'Edit item konfigurasi.';
    $Self->{Translation}->{'Config item event module that count the licenses for OTOBOCILicenseCount feature.'} =
        'Modul peristiwa item konfigurasi yang menghitung lisensi untuk fitur OTOBOCILicenseCount.';
    $Self->{Translation}->{'Config item event module that enables logging to history in the agent interface.'} =
        'Modul peristiwa item konfigurasi yang mengaktifkan logging ke riwayat pada antarmuka agen';
    $Self->{Translation}->{'Config item event module that updates config items to their current definition.'} =
        'Modul peristiwa item konfigurasi yang memperbarui item konfigurasi ke definisi saat ini.';
    $Self->{Translation}->{'Config item event module that updates the table configitem_ĺink.'} =
        'Modul peristiwa item konfigurasi yang memperbarui tabel configitem_ĺink.';
    $Self->{Translation}->{'Config item event module updates the current incident state.'} =
        'Modul peristiwa item konfigurasi memperbarui status insiden saat ini.';
    $Self->{Translation}->{'Config item history.'} = 'Riwayat item konfigurasi.';
    $Self->{Translation}->{'Config item print.'} = 'Cetak item konfigurasi.';
    $Self->{Translation}->{'Config item zoom.'} = 'Zoom item konfigurasi.';
    $Self->{Translation}->{'ConfigItem Tree View'} = 'Tampilan Pohon ConfigItem';
    $Self->{Translation}->{'ConfigItem Version'} = 'Versi ConfigItem';
    $Self->{Translation}->{'ConfigItems of the following classes will not be stored on the Elasticsearch server. To apply this to existing CIs, the CI migration has to be run via console, after changing this option.'} =
        'ConfigItems dari kelas-kelas berikut ini tidak akan disimpan di server Elasticsearch. Untuk menerapkan ini pada CI yang sudah ada, migrasi CI harus dijalankan melalui konsol, setelah mengubah opsi ini.';
    $Self->{Translation}->{'ConfigItems with the following deployment states will not be stored on the Elasticsearch server. To apply this to existing CIs, the CI migration has to be run via console, after changing this option.'} =
        'ConfigItems dengan status penyebaran berikut tidak akan disimpan di server Elasticsearch. Untuk menerapkan ini pada CI yang sudah ada, migrasi CI harus dijalankan melalui konsol, setelah mengubah opsi ini.';
    $Self->{Translation}->{'Configuration Item Limit'} = 'Batas item konfigurasi';
    $Self->{Translation}->{'Configuration Item limit per page.'} = 'Konfigurasi Batas item per halaman.';
    $Self->{Translation}->{'Configuration Management Database.'} = 'Basis Data Manajemen Konfigurasi.';
    $Self->{Translation}->{'Configuration item bulk module.'} = 'Modul massal item konfigurasi.';
    $Self->{Translation}->{'Configuration item search backend router of the agent interface.'} =
        'Router pencarian backend item konfigurasi pada antarmuka agen';
    $Self->{Translation}->{'Create and manage the definitions for Configuration Items.'} = 'Buat dan atur definisi - definisi untuk item konfigurasi';
    $Self->{Translation}->{'Creates Tickets for ConfigItems at specific time points.'} = 'Membuat Tiket untuk ConfigItems pada titik waktu tertentu.';
    $Self->{Translation}->{'Customers can see historic CI versions.'} = 'Pelanggan dapat melihat versi CI historis.';
    $Self->{Translation}->{'Customers have the possibility to manually switch between historic CI versions.'} =
        'Pelanggan dapat beralih secara manual di antara versi CI terdahulu.';
    $Self->{Translation}->{'Default data to use on attribute for config item search screen. Example: "ITSMConfigItemCreateTimePointFormat=year;ITSMConfigItemCreateTimePointStart=Last;ITSMConfigItemCreateTimePoint=2;".'} =
        'Data default yang akan digunakan pada atribut untuk layar pencarian item konfigurasi. Contoh: "ITSMConfigItemCreateTimePointFormat = tahun; ITSMConfigItemCreateTimePointStart = Terakhir; ITSMConfigItemCreateTimePoint = 2;".';
    $Self->{Translation}->{'Default data to use on attribute for config item search screen. Example: "ITSMConfigItemCreateTimeStartYear=2010;ITSMConfigItemCreateTimeStartMonth=10;ITSMConfigItemCreateTimeStartDay=4;ITSMConfigItemCreateTimeStopYear=2010;ITSMConfigItemCreateTimeStopMonth=11;ITSMConfigItemCreateTimeStopDay=3;".'} =
        'Data default yang akan digunakan pada atribut untuk layar pencarian item konfigurasi. Contoh: "ITSMConfigItemCreateTimeStartYear = 2010; ITSMConfigItemCreateTimeStartMonth = 10; ITSMConfigItemCreateTimeStartDay = 4; ITSMConfigItemCreateTimeStopYear = 2010; ITSMConfigItemCreateTimeStopMonth = 11; ITSMConfigItemCreateTimeStopDay = 3;".';
    $Self->{Translation}->{'Define Actions where a settings button is available in the linked objects widget (LinkObject::ViewMode = "complex"). Please note that these Actions must have registered the following JS and CSS files: Core.AllocationList.css, Core.UI.AllocationList.js, Core.UI.Table.Sort.js, Core.Agent.TableFilters.js and Core.Agent.LinkObject.js.'} =
        'Tentukan Tindakan adalah tombol pengaturan tersedia di objek widget terkait (LinkObject::ViewMode = "complex"). Harap dicatat bahwa Tindakan ini harus telah mendaftarkan berikut JS dan CSS file: Core.AllocationList.css, Core.UI.AllocationList.js, Core.UI.Table.Sort.js, Core.Agent.TableFilters.js.';
    $Self->{Translation}->{'Define a Template::Toolkit scheme for version strings. Only used if Version String Module is set to TemplateToolkit.'} =
        'Mendefinisikan skema Template::Toolkit untuk string versi. Hanya digunakan jika Modul String Versi diatur ke TemplateToolkit.';
    $Self->{Translation}->{'Define a set of conditions under which a customer is allowed to see a config item. Conditions can optionally be restricted to certain customer groups. Name is the only mandatory attribute. If no other options are given, all config items will be visible under that category.'} =
        'Tentukan serangkaian kondisi di mana pelanggan diizinkan untuk melihat item konfigurasi. Kondisi dapat secara opsional dibatasi untuk grup pelanggan tertentu. Nama adalah satu-satunya atribut wajib. Jika tidak ada pilihan lain yang diberikan, semua item konfigurasi akan terlihat di bawah kategori tersebut.';
    $Self->{Translation}->{'Defines Required permissions to delete ITSM configuration items using the Generic Interface.'} =
        'Mendefinisikan izin yang diperlukan untuk menghapus item konfigurasi ITSM menggunakan Antarmuka Generik.';
    $Self->{Translation}->{'Defines Required permissions to get ITSM configuration items using the Generic Interface.'} =
        'Definisikan izin yang di butuhkan untuk mendapatkan item konfigurasi ITSM dengan menggunakan antarmuka umum.';
    $Self->{Translation}->{'Defines Required permissions to search ITSM configuration items using the Generic Interface.'} =
        'Definisikan izin yang di butuhkan untuk mencari item konfigurasi ITSM dengan menggunakan antarmuka umum.';
    $Self->{Translation}->{'Defines Required permissions to set ITSM configuration items using the Generic Interface.'} =
        '';
    $Self->{Translation}->{'Defines an overview module to show the small view of a configuration item list.'} =
        'Definisikan modul gambaran untuk menunjukan tampilan kecil dari sebuah daftar item konfigurasi';
    $Self->{Translation}->{'Defines if the link type labels must be shown in the node connections.'} =
        'Menentukan apakah label jenis tautan harus ditampilkan di koneksi node.';
    $Self->{Translation}->{'Defines regular expressions individually for each ConfigItem class to check the ConfigItem name and to show corresponding error messages.'} =
        'Definisikan ekspresi regular secara individual untuk setiap kelas ItemKonfigurasi untuk memeriksa nama ItemKonfigurasi untuk menunjukan pesan error yang sesuai';
    $Self->{Translation}->{'Defines the available columns of CIs in the config item overview depending on the CI class. Each entry must consist of a class name and an array of available fields for the corresponding class. Dynamic field entries have to honor the scheme DynamicField_FieldName.'} =
        'Mendefinisikan kolom CI yang tersedia dalam ikhtisar item konfigurasi tergantung pada kelas CI. Setiap entri harus terdiri dari nama kelas dan larik kolom yang tersedia untuk kelas yang bersangkutan. Entri bidang dinamis harus sesuai dengan skema DynamicField_FieldName.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of the agent interface.'} =
        'Mendefinisikan atribut item konfigurasi default untuk pengurutan item konfigurasi dari hasil pencarian item konfigurasi antarmuka agen.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of the customer interface.'} =
        'Menentukan atribut item konfigurasi default untuk pengurutan item konfigurasi dari hasil pencarian item konfigurasi pada antarmuka pelanggan.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of this operation.'} =
        'Menentukan atribut item konfigurasi default untuk pengurutan item konfigurasi dari hasil pencarian item konfigurasi operasi ini.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the agent interface. Up: oldest on top. Down: latest on top.'} =
        'Menentukan urutan item konfigurasi default dalam hasil pencarian item konfigurasi pada antarmuka agen. Atas: tertua di atas. Turun: terbaru di atas.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the customer interface. Up: oldest on top. Down: latest on top.'} =
        'Menentukan urutan item konfigurasi default dalam hasil pencarian item konfigurasi pada antarmuka pelanggan. Atas: tertua di atas. Turun: terbaru di atas.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the this operation. Up: oldest on top. Down: latest on top.'} =
        'Menentukan urutan item konfigurasi default dalam hasil pencarian item konfigurasi dari operasi ini. Atas: tertua di atas. Turun: terbaru di atas.';
    $Self->{Translation}->{'Defines the default displayed columns of CIs in the config item overview depending on the CI class. Each entry must consist of a class name and an array of available fields for the corresponding class. Dynamic field entries have to honor the scheme DynamicField_FieldName.'} =
        'Menentukan kolom CI yang ditampilkan secara default dalam ikhtisar item konfigurasi tergantung pada kelas CI. Setiap entri harus terdiri dari nama kelas dan larik bidang yang tersedia untuk kelas yang sesuai. Entri bidang dinamis harus sesuai dengan skema DynamicField_FieldName.';
    $Self->{Translation}->{'Defines the default relations depth to be shown.'} = 'Menentukan kedalaman relasi default yang akan ditampilkan.';
    $Self->{Translation}->{'Defines the default shown config item search attribute for config item search screen.'} =
        'Menentukan atribut pencarian item konfigurasi yang ditampilkan secara default untuk layar pencarian item konfigurasi.';
    $Self->{Translation}->{'Defines the default shown config item search attribute for config item search screen. Example: "Key" must have the name of the Dynamic Field in this case \'X\', "Content" must have the value of the Dynamic Field depending on the Dynamic Field type,  Text: \'a text\', Dropdown: \'1\', Date/Time: \'Search_DynamicField_XTimeSlotStartYear=1974; Search_DynamicField_XTimeSlotStartMonth=01; Search_DynamicField_XTimeSlotStartDay=26; Search_DynamicField_XTimeSlotStartHour=00; Search_DynamicField_XTimeSlotStartMinute=00; Search_DynamicField_XTimeSlotStartSecond=00; Search_DynamicField_XTimeSlotStopYear=2013; Search_DynamicField_XTimeSlotStopMonth=01; Search_DynamicField_XTimeSlotStopDay=26; Search_DynamicField_XTimeSlotStopHour=23; Search_DynamicField_XTimeSlotStopMinute=59; Search_DynamicField_XTimeSlotStopSecond=59;\' and or \'Search_DynamicField_XTimePointFormat=week; Search_DynamicField_XTimePointStart=Before; Search_DynamicField_XTimePointValue=7\';.'} =
        'Menentukan atribut pencarian item konfigurasi yang ditampilkan secara default untuk layar pencarian item konfigurasi. Contoh: "Key" harus memiliki nama Bidang Dinamis dalam hal ini \'X\', "Content" harus memiliki nilai Bidang Dinamis tergantung pada jenis Bidang Dinamis, Teks: \'teks\', Dropdown: \'1\', Tanggal/Waktu: \'Search_DynamicField_XTimeSlotStartYear = 1974; Search_DynamicField_XTimeSlotStartMonth = 01; Search_DynamicField_XTimeSlotStartDay = 26; Search_DynamicField_XTimeSlotStartHour = 00; Search_DynamicField_XTimeSlotStartMinute = 00; Search_DynamicField_XTimeSlotStartSecond = 00; Search_DynamicField_XTimeSlotStopYear = 2013; Search_DynamicField_XTimeSlotStopMonth = 01; Search_DynamicField_XTimeSlotStopDay = 26; Search_DynamicField_XTimeSlotStopHour = 23; Search_DynamicField_XTimeSlotStopMinute = 59; Search_DynamicField_XTimeSlotStopSecond = 59;\' dan atau \'Search_DynamicField_XTimePointFormat = minggu; Search_DynamicField_XTimePointStart = Sebelum; Search_DynamicField_XTimePointValue = 7\';.';
    $Self->{Translation}->{'Defines the default subobject of the class \'ITSMConfigItem\'.'} =
        'Definisikan subobjek default dari kelas \'ITSMConfigItem\'.';
    $Self->{Translation}->{'Defines the height for the rich text editor component for this screen. Enter number (pixels) or percent value (relative).'} =
        'Mendefinisikan tinggi untuk komponen editor teks kaya untuk layar ini. Masukkan nomor (piksel) atau nilai persen (relatif).';
    $Self->{Translation}->{'Defines the number of rows for the CI definition editor in the admin interface.'} =
        'Definisikan jumlah baris untuk pengubah definisiCI pada antarmuka Admin';
    $Self->{Translation}->{'Defines the order of incident states from high (e.g. cricital) to low (e.g. functional).'} =
        'Menentukan urutan status insiden dari tinggi (mis. krusial) ke rendah (mis. fungsional).';
    $Self->{Translation}->{'Defines the relevant deployment states where linked tickets can affect the status of a CI.'} =
        'Mendefinisikan status penyebaran yang relevan di mana tiket yang ditautkan dapat memengaruhi status CI.';
    $Self->{Translation}->{'Defines the search limit for the AgentITSMConfigItem screen.'} =
        'Definisikan batas pencarian untuk layar AgentITSMConfigItem ';
    $Self->{Translation}->{'Defines the search limit for the AgentITSMConfigItemSearch screen.'} =
        'Definisikan batas pencarian untuk Layar AgentITSMConfigItemSearch ';
    $Self->{Translation}->{'Defines the search limit for the CustomerITSMConfigItem screen.'} =
        'Menentukan batas pencarian untuk layar CustomerITSMConfigItem.';
    $Self->{Translation}->{'Defines the search limit for the CustomerITSMConfigItemSearch screen.'} =
        'Menentukan batas pencarian untuk layar CustomerITSMConfigItemSearch.';
    $Self->{Translation}->{'Defines the shown columns of CIs in the link table complex view for all CI classes. If there is no entry, then the default columns are shown.'} =
        'Menentukan kolom CI yang ditampilkan dalam tampilan kompleks tabel tautan untuk semua kelas CI. Jika tidak ada entri, maka kolom default akan ditampilkan.';
    $Self->{Translation}->{'Defines the shown columns of CIs in the link table complex view, depending on the CI class. Each entry must be prefixed with the class name and double colons (i.e. Computer::). There are a few CI-Attributes that common to all CIs (example for the class Computer: Computer::Name, Computer::CurDeplState, Computer::CreateTime). To show individual CI-Attributes as defined in the CI-Definition, the following scheme must be used (example for the class Computer): Computer::HardDisk::1, Computer::HardDisk::1::Capacity::1, Computer::HardDisk::2, Computer::HardDisk::2::Capacity::1. If there is no entry for a CI class, then the default columns are shown.'} =
        'Mendefinisikan kolom yang ditampilkan dari CI di link tabel tampilan yang kompleks, tergantung pada kelas CI. Setiap entri harus diawali dengan nama kelas dan titik dua ganda (i.e. Computer::). Ada beberapa CI-Atribut yang umum untuk semua CI (Contoh untuk Komputer kelas: Komputer :: Nama, Komputer :: CurDeplState, Komputer :: CreateTime). Untuk menunjukkan individu CI-Atribut sebagaimana didefinisikan dalam CI-Definition, skema berikut harus digunakan (misalnya untuk Komputer kelas):  Computer::HardDisk::1, Computer::HardDisk::1::Capacity::1, Computer::HardDisk::2, Computer::HardDisk::2::Capacity::1. Jika tidak ada entri untuk kelas CI, maka kolom standar ditampilkan sebagaimana didefinisikan dalam pengaturan ITSMConfigItem::Frontend::AgentITSMConfigItem###ShowColumns.';
    $Self->{Translation}->{'Defines which items are available for \'Action\' in third level of the ITSM Config Item ACL structure.'} =
        'Mendefinisikan item mana yang tersedia untuk \'Tindakan\' di tingkat ketiga dari struktur ACL Item Konfigurasi ITSM.';
    $Self->{Translation}->{'Defines which items are available in first level of the ITSM Config Item ACL structure.'} =
        'Mendefinisikan item mana yang tersedia di tingkat pertama struktur ACL Item Konfigurasi ITSM.';
    $Self->{Translation}->{'Defines which items are available in second level of the ITSM Config Item ACL structure.'} =
        'Mendefinisikan item mana yang tersedia di tingkat kedua dari struktur ACL Item Konfigurasi ITSM.';
    $Self->{Translation}->{'Defines which type of link (named from the ticket perspective) can affect the status of a linked CI.'} =
        'Mendefinisikan jenis tautan mana (dinamai dari perspektif tiket) yang dapat memengaruhi status CI yang ditautkan.';
    $Self->{Translation}->{'Defines which type of ticket can affect the status of a linked CI.'} =
        'Mendefinisikan jenis tiket mana yang dapat memengaruhi status CI yang ditautkan.';
    $Self->{Translation}->{'Definition Update'} = 'Pembaruan Definisi';
    $Self->{Translation}->{'Delete Configuration Item'} = 'Menghapus Item Konfigurasi';
    $Self->{Translation}->{'DeplState'} = 'DeplState';
    $Self->{Translation}->{'Deployment State Color'} = 'Warna Status Penyebaran';
    $Self->{Translation}->{'DeploymentState'} = 'DeploymentState';
    $Self->{Translation}->{'Duplicate'} = 'Duplikat';
    $Self->{Translation}->{'Dynamic field event module that marks config item definitions as out of sync, if containing dynamic fields change.'} =
        'Modul peristiwa bidang dinamis yang menandai definisi item konfigurasi sebagai tidak sinkron, jika mengandung perubahan bidang dinamis.';
    $Self->{Translation}->{'Dynamic fields shown in the additional ITSM field screen of the agent interface.'} =
        'Bidang dinamis yang ditampilkan di layar bidang ITSM tambahan pada antarmuka agen.';
    $Self->{Translation}->{'Dynamic fields shown in the config item overview screen of the customer interface.'} =
        'Bidang dinamis yang ditampilkan di layar ikhtisar item konfigurasi pada antarmuka pelanggan.';
    $Self->{Translation}->{'Dynamic fields shown in the config item search screen of the agent interface.'} =
        'Bidang dinamis yang ditampilkan di layar pencarian item konfigurasi pada antarmuka agen.';
    $Self->{Translation}->{'Enables configuration item bulk action feature for the agent frontend to work on more than one configuration item at a time.'} =
        'Memungkinkan fitur item konfigurasi tindakan massal untuk agen frontend untuk bekerja pada lebih dari satu item konfigurasi pada suatu waktu.';
    $Self->{Translation}->{'Enables configuration item bulk action feature only for the listed groups.'} =
        'Memungkinkan fitur tindakan massal item konfigurasi hanya untuk kelompok terdaftar.';
    $Self->{Translation}->{'Enables/disables the functionality to check ITSM onfiguration items for unique names. Before enabling this option you should check your system for already existing config items with duplicate names. You can do this with the console command Admin::ITSM::ConfigItem::ListDuplicates.'} =
        'Mengaktifkan/menonaktifkan fungsionalitas untuk memeriksa item konfigurasi ITSM untuk nama yang unik. Sebelum mengaktifkan opsi ini, Anda harus memeriksa sistem Anda untuk item konfigurasi yang sudah ada dengan nama ganda. Anda dapat melakukan ini dengan perintah konsol Admin::ITSM::ConfigItem::ListDuplicates.';
    $Self->{Translation}->{'Event module to set configitem-status on ticket-configitem-link.'} =
        'Modul peristiwa untuk mengatur status konfigurasi pada tautan konfigurasi tiket.';
    $Self->{Translation}->{'Fields of the configuration item index, used for the fulltext search. Fields are also stored, but are not mandatory for the overall functionality. Inclusion of attachments can be disabled by setting the entry to 0 or deleting it.'} =
        'Bidang indeks item konfigurasi, digunakan untuk pencarian teks lengkap. Bidang juga disimpan, tetapi tidak wajib untuk fungsionalitas keseluruhan. Penyertaan lampiran dapat dinonaktifkan dengan mengatur entri ke 0 atau menghapusnya.';
    $Self->{Translation}->{'Fields stored in the configuration item index which are used for other things besides fulltext searches. For the complete functionality all fields are mandatory.'} =
        'Bidang yang disimpan dalam indeks item konfigurasi yang digunakan untuk hal-hal lain selain pencarian teks lengkap. Untuk fungsionalitas yang lengkap, semua bidang wajib diisi.';
    $Self->{Translation}->{'For every webservice (key) an array of classes (value) can be defined on which the import is restricted. For all chosen classes, or all existing classes the identifying attributes will have to be chosen in the invoker config.'} =
        'Untuk setiap layanan web (key), sebuah larik kelas (value) dapat didefinisikan di mana impor dibatasi. Untuk semua kelas yang dipilih, atau semua kelas yang ada, atribut pengenal harus dipilih dalam konfigurasi pemanggil.';
    $Self->{Translation}->{'GenericInterface module registration for the ConfigItemFetch invoker layer.'} =
        'Registrasi modul GenericInterface untuk lapisan pemanggil ConfigItemFetch.';
    $Self->{Translation}->{'ITSM ConfigItem'} = 'Item Konfigurasi ITSM';
    $Self->{Translation}->{'ITSM config item overview.'} = 'Ikhtisar item konfigurasi ITSM.';
    $Self->{Translation}->{'If this option is activated, linked items are only counted if they belong to one of the listed classes.'} =
        'Jika opsi ini diaktifkan, item yang ditautkan hanya dihitung jika item tersebut termasuk dalam salah satu kelas yang terdaftar.';
    $Self->{Translation}->{'InciState'} = 'InciState';
    $Self->{Translation}->{'IncidentState'} = 'StatusInsiden';
    $Self->{Translation}->{'Includes deployment states in the config item search of the customer interface.'} =
        'Termasuk status penerapan dalam pencarian item konfigurasi pada antarmuka pelanggan.';
    $Self->{Translation}->{'Includes incident states in the config item search of the customer interface.'} =
        'Termasuk status insiden dalam pencarian item konfigurasi pada antarmuka pelanggan.';
    $Self->{Translation}->{'Maximum number of config items to be displayed in the result of this operation.'} =
        'Jumlah maksimum item konfigurasi yang akan ditampilkan dalam hasil operasi ini.';
    $Self->{Translation}->{'Module to check the group responsible for a class.'} = 'Modul untuk memeriksa kelompok yang bertanggung jawab untuk kelas.';
    $Self->{Translation}->{'Module to check the group responsible for a configuration item.'} =
        'Modul untuk memeriksa kelompok yang bertanggung jawab untuk item konfigurasi.';
    $Self->{Translation}->{'Module to generate ITSM config item statistics.'} = 'Modul untuk menghasilkan statistik config barang ITSM.';
    $Self->{Translation}->{'Name Module'} = 'Modul Nama';
    $Self->{Translation}->{'Number Module'} = 'Modul Angka';
    $Self->{Translation}->{'Number of config items to be displayed in each page of a search result in the agent interface.'} =
        'Jumlah item konfigurasi yang akan ditampilkan di setiap halaman hasil pencarian di antarmuka agen.';
    $Self->{Translation}->{'Number of config items to be displayed in each page of a search result in the customer interface.'} =
        'Jumlah item konfigurasi yang akan ditampilkan di setiap halaman hasil pencarian di antarmuka pelanggan.';
    $Self->{Translation}->{'Objects to search for, how many entries and which attributs to show. ConfigItem attributes have to explicitly be stored via Elasticsearch.'} =
        'Objek yang akan dicari, berapa banyak entri dan atribut mana yang akan ditampilkan. Atribut ConfigItem harus secara eksplisit disimpan melalui Elasticsearch.';
    $Self->{Translation}->{'Overview.'} = 'Gambaran umum.';
    $Self->{Translation}->{'Parameters for the categories for config item classes in the preferences view of the agent interface.'} =
        'Parameter untuk kategori untuk kelas item konfigurasi di tampilan preferensi antarmuka agen.';
    $Self->{Translation}->{'Parameters for the column filters of the small config item overview. Please note: setting \'Active\' to 0 will only prevent agents from editing settings of this group in their personal preferences, but will still allow administrators to edit the settings of another user\'s behalf. Use \'PreferenceGroup\' to control in which area these settings should be shown in the user interface.'} =
        'Parameter untuk filter kolom pada ikhtisar item konfigurasi kecil. Harap diperhatikan: mengatur \'Active\' ke 0 hanya akan mencegah agen mengedit pengaturan grup ini dalam preferensi pribadi mereka, tetapi masih memungkinkan administrator untuk mengedit pengaturan atas nama pengguna lain. Gunakan \'PreferenceGroup\' untuk mengontrol di area mana pengaturan ini harus ditampilkan di antarmuka pengguna.';
    $Self->{Translation}->{'Parameters for the dashboard backend of the customer company config item overview of the agent interface . "Limit" is the number of entries shown by default. "Group" is used to restrict the access to the plugin (e. g. Group: admin;group1;group2;). "Default" determines if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" is the cache time in minutes for the plugin.'} =
        'Parameter untuk backend dasbor dari ikhtisar item konfigurasi perusahaan pelanggan dari antarmuka agen. "Limit" adalah jumlah entri yang ditampilkan secara default. "Group" digunakan untuk membatasi akses ke plugin (mis. Group: admin; group1; group2;). "Default" menentukan apakah plugin diaktifkan secara default atau jika pengguna perlu mengaktifkannya secara manual. "CacheTTLLocal" adalah waktu cache dalam hitungan menit untuk plugin.';
    $Self->{Translation}->{'Parameters for the deployment states color in the preferences view of the agent interface.'} =
        'Parameter untuk warna state penyebaran dalam preferensi melihat antarmuka agen.';
    $Self->{Translation}->{'Parameters for the deployment states in the preferences view of the agent interface.'} =
        'Parameter untuk state penyebaran dalam preferensi melihat antarmuka agen.';
    $Self->{Translation}->{'Parameters for the example permission groups of the general catalog attributes.'} =
        'Parameter untuk grup conoth perizinan dari atribut katalog umum';
    $Self->{Translation}->{'Parameters for the name module for config item classes in the preferences view of the agent interface.'} =
        'Parameter untuk modul nama untuk kelas item konfigurasi dalam tampilan preferensi antarmuka agen.';
    $Self->{Translation}->{'Parameters for the number module for config item classes in the preferences view of the agent interface.'} =
        'Parameter untuk modul nomor untuk kelas item konfigurasi dalam tampilan preferensi antarmuka agen.';
    $Self->{Translation}->{'Parameters for the pages (in which the configuration items are shown).'} =
        'Parameter untuk halaman (di mana item konfigurasi akan ditampilkan).';
    $Self->{Translation}->{'Parameters for the version string module for config item classes in the preferences view of the agent interface.'} =
        'Parameter untuk modul string versi untuk kelas item konfigurasi dalam tampilan preferensi antarmuka agen.';
    $Self->{Translation}->{'Parameters for the version string template toolkit module for config item classes in the preferences view of the agent interface.'} =
        'Parameter untuk modul toolkit template string versi untuk kelas item konfigurasi di tampilan preferensi antarmuka agen.';
    $Self->{Translation}->{'Parameters for the version trigger for config item classes in the preferences view of the agent interface.'} =
        'Parameter untuk pemicu versi untuk kelas item konfigurasi dalam tampilan preferensi antarmuka agen.';
    $Self->{Translation}->{'Performs the configured action for each event (as an Invoker) for each configured Webservice.'} =
        'Melakukan tindakan dikonfigurasi untuk setiap acara (sebagai Invoker) untuk setiap Layanan Web dikonfigurasi.';
    $Self->{Translation}->{'Permission Group'} = 'Grup Izin';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item attachment action in the agent interface.'} =
        'Izin yang diperlukan untuk menggunakan tindakan lampiran item konfigurasi ITSM di antarmuka agen.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item screen in the agent interface.'} =
        'izin yang diperlukan untuk menggunakan layar item konfigurasi ITSM di antarmuka agen.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item search screen in the agent interface.'} =
        'izin yang diperlukan untuk menggunakan konfigurasi ITSM layar pencarian item dalam antarmuka agen.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item search screen in the customer interface.'} =
        'Izin yang diperlukan untuk menggunakan layar pencarian item konfigurasi ITSM di antarmuka pelanggan.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item tree view screen in the agent interface.'} =
        'Izin yang diperlukan untuk menggunakan layar tampilan pohon item konfigurasi ITSM di antarmuka agen.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item zoom screen in the agent interface.'} =
        'izin yang diperlukan untuk menggunakan konfigurasi ITSM item layar zoom di antarmuka agen.';
    $Self->{Translation}->{'Required permissions to use the add ITSM configuration item screen in the agent interface.'} =
        'izin yang diperlukan untuk menggunakan add ITSM layar item konfigurasi dalam antarmuka agen.';
    $Self->{Translation}->{'Required permissions to use the bulk ITSM configuration item screen in the agent interface.'} =
        'Izin yang diperlukan untuk menggunakan layar item konfigurasi ITSM massal di antarmuka agen.';
    $Self->{Translation}->{'Required permissions to use the edit ITSM configuration item screen in the agent interface.'} =
        'izin yang diperlukan untuk menggunakan mengedit ITSM layar item konfigurasi dalam antarmuka agen.';
    $Self->{Translation}->{'Required permissions to use the history ITSM configuration item screen in the agent interface.'} =
        'izin yang diperlukan untuk menggunakan sejarah ITSM layar item konfigurasi dalam antarmuka agen.';
    $Self->{Translation}->{'Required permissions to use the print ITSM configuration item screen in the agent interface.'} =
        'Izin Yang diperlukan untuk review using Sejarah ITSM Layar Item Konfigurasi Antarmuka agen.';
    $Self->{Translation}->{'Required privileges to delete config items.'} = 'Hak istimewa yang diperlukan untuk menghapus item konfigurasi.';
    $Self->{Translation}->{'Search config items.'} = 'Mencari item konfigurasi.';
    $Self->{Translation}->{'Set the incident state of a CI automatically when a Ticket is Linked to a CI.'} =
        'Mengatur status insiden CI secara otomatis ketika Tiket ditautkan ke CI.';
    $Self->{Translation}->{'Sets the deployment state in the configuration item bulk screen of the agent interface.'} =
        'Atur status penyebaran di item konfigurasi layar terbesar dari antarmuka agen.';
    $Self->{Translation}->{'Sets the incident state in the configuration item bulk screen of the agent interface.'} =
        'Atur status kejadian pada item konfigurasi layar terbesar dari antarmuka agen.';
    $Self->{Translation}->{'Shows a link in the menu that allows linking a configuration item with another object in the config item zoom view of the agent interface.'} =
        'Menunjukkan link dalam menu yang memungkinkan menghubungkan item konfigurasi dengan objek lain di config barang pandangan zoom dari antarmuka agen.';
    $Self->{Translation}->{'Shows a link in the menu to access the history of a configuration item in the configuration item overview of the agent interface.'} =
        'Menunjukkan link dalam menu untuk mengakses sejarah item konfigurasi pada item konfigurasi gambaran dari antarmuka agen.';
    $Self->{Translation}->{'Shows a link in the menu to access the history of a configuration item in the its zoom view of the agent interface.'} =
        'Menunjukkan link dalam menu untuk mengakses sejarah item konfigurasi dalam tampilan zoom-nya dari antarmuka agen.';
    $Self->{Translation}->{'Shows a link in the menu to delete a configuration item in its zoom view of the agent interface.'} =
        'Menampilkan tautan dalam menu untuk menghapus item konfigurasi dalam tampilan zoom antarmuka agen.';
    $Self->{Translation}->{'Shows a link in the menu to display the configuration item links as a Tree View.'} =
        'Menampilkan tautan dalam menu untuk menampilkan tautan item konfigurasi sebagai Tampilan Pohon.';
    $Self->{Translation}->{'Shows a link in the menu to duplicate a configuration item in the configuration item overview of the agent interface.'} =
        'Menunjukkan link dalam menu untuk menduplikasi item konfigurasi pada item konfigurasi gambaran dari antarmuka agen.';
    $Self->{Translation}->{'Shows a link in the menu to duplicate a configuration item in the its zoom view of the agent interface.'} =
        'Menunjukkan link dalam menu untuk menduplikasi item konfigurasi dalam tampilan zoom-nya dari antarmuka agen.';
    $Self->{Translation}->{'Shows a link in the menu to edit a configuration item in the its zoom view of the agent interface.'} =
        'Menunjukkan link dalam menu untuk mengedit item konfigurasi dalam tampilan zoom-nya dari antarmuka agen.';
    $Self->{Translation}->{'Shows a link in the menu to go back in the configuration item zoom view of the agent interface.'} =
        'Shows a link in the menu to go back in the configuration item zoom view of the agent interface.';
    $Self->{Translation}->{'Shows a link in the menu to print a configuration item in the its zoom view of the agent interface.'} =
        'Menunjukkan link dalam menu untuk mencetak item konfigurasi dalam tampilan zoom-nya dari antarmuka agen.';
    $Self->{Translation}->{'Shows a link in the menu to zoom into a configuration item in the configuration item overview of the agent interface.'} =
        'Shows a link in the menu to zoom into a configuration item in the configuration item overview of the agent interface.';
    $Self->{Translation}->{'Shows the config item history (reverse ordered) in the agent interface.'} =
        'Menunjukkan sejarah config item (urutan terbalik) di antarmuka agen.';
    $Self->{Translation}->{'The default category which is shown, if none is selected.'} = 'Kategori default yang ditampilkan, jika tidak ada yang dipilih.';
    $Self->{Translation}->{'The identifier for a configuration item, e.g. ConfigItem#, MyConfigItem#. The default is ConfigItem#.'} =
        'Pengenal untuk item konfigurasi, misalnya ConfigItem #, MyConfig Item #. default adalah ConfigItem #.';
    $Self->{Translation}->{'Triggers ConfigItemFetch invoker automatically.'} = 'Memicu pemanggil ConfigItemFetch secara otomatis.';
    $Self->{Translation}->{'Version String Expression'} = 'Ekspresi String Versi';
    $Self->{Translation}->{'Version String Module'} = 'Modul String Versi';
    $Self->{Translation}->{'Version Trigger'} = 'Pemicu Versi';
    $Self->{Translation}->{'Whether the execution of ConfigItemACL can be avoided by checking cached field dependencies. This can improve loading times of formulars, but has to be disabled, if ACLModules are to be used for ITSMConfigItem- and Form-ReturnTypes.'} =
        'Apakah eksekusi ConfigItemACL dapat dihindari dengan memeriksa ketergantungan bidang yang di-cache. Hal ini dapat meningkatkan waktu pemuatan formular, tetapi harus dinonaktifkan, jika ACLModules akan digunakan untuk ITSMConfigItem dan Form-ReturnTypes.';
    $Self->{Translation}->{'Which general information is shown in the header.'} = 'Informasi umum mana yang ditampilkan di header.';
    $Self->{Translation}->{'With this option it´s possible to fill automaticly a CI field, depending on the count of linked CI´s with the existing type DependsOn.'} =
        'Dengan opsi ini, dimungkinkan untuk mengisi bidang CI secara otomatis, tergantung pada jumlah CI yang ditautkan dengan tipe DependsOn yang ada.';
    $Self->{Translation}->{'With this option it´s possible to fill automaticly a CI field, depending on the count of linked CI´s.'} =
        'Dengan opsi ini, dimungkinkan untuk mengisi kolom CI secara otomatis, tergantung pada jumlah CI yang ditautkan.';
    $Self->{Translation}->{'With this option it´s possible to fill automaticly a CI field, depending on the count of linked CI´s. The setting CounterClassName include the name of the class and CounterFieldName is used to store the count of used licence.'} =
        'Dengan opsi ini, dimungkinkan untuk mengisi bidang CI secara otomatis, tergantung pada jumlah CI yang ditautkan. Pengaturan CounterClassName menyertakan nama kelas dan CounterFieldName digunakan untuk menyimpan jumlah lisensi yang digunakan.';
    $Self->{Translation}->{'class'} = 'kelas';
    $Self->{Translation}->{'global'} = 'global';
    $Self->{Translation}->{'postproductive'} = 'pascaproduktif';
    $Self->{Translation}->{'preproductive'} = 'praproduktif';
    $Self->{Translation}->{'productive'} = 'produktif';


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

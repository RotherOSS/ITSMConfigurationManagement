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

package Kernel::Language::ar_SA_ITSMConfigurationManagement;

use strict;
use warnings;
use utf8;

sub Data {
    my $Self = shift;

    # Template: AdminGenericInterfaceOperationConfigItem
    $Self->{Translation}->{'General operation data'} = 'بيانات التشغيل العامة';
    $Self->{Translation}->{'Settings for incoming request data'} = 'إعدادات بيانات الطلبات الواردة';
    $Self->{Translation}->{'Settings for outgoing response data'} = 'إعدادات بيانات الاستجابة الصادرة';

    # Template: AdminITSMConfigItem
    $Self->{Translation}->{'Config Item Management'} = 'إدارة عناصر التكوين';
    $Self->{Translation}->{'Change class definition'} = 'تغيير تعريف الفئة';
    $Self->{Translation}->{'Change role definition'} = 'تغيير تعريف الدور';
    $Self->{Translation}->{'Ready2Import Class Bundles'} = 'حزم فئات Ready2Import Class Bundles';
    $Self->{Translation}->{'Here you can import Ready2Import class bundles showcasing our most usual config items. Please note that some additional configuration may be required.'} =
        'هنا يمكنك استيراد حزم فئات Ready2Import التي تعرض عناصر التكوين الأكثر شيوعًا لدينا. يرجى ملاحظة أن بعض التهيئة الإضافية قد تكون مطلوبة.';
    $Self->{Translation}->{'Update existing entities'} = 'تحديث الكيانات الحالية';
    $Self->{Translation}->{'Import Ready2Adopt class bundles'} = 'استيراد حزم فئات Ready2Adopt';
    $Self->{Translation}->{'Config Item Class'} = 'فئة عنصر التكوين';
    $Self->{Translation}->{'Config Item Role'} = 'دور عنصر التكوين';

    # Template: AgentITSMConfigItemAdd
    $Self->{Translation}->{'Config Item'} = 'عنصر التكوين';
    $Self->{Translation}->{'Filter for Classes'} = 'تصفية للفئات';
    $Self->{Translation}->{'Select a Class from the list to create a new Config Item.'} = 'حدد فئة من القائمة لإنشاء عنصر تكوين جديد.';
    $Self->{Translation}->{'Class'} = 'الفئة';

    # Template: AgentITSMConfigItemBulk
    $Self->{Translation}->{'ITSM ConfigItem Bulk Action'} = 'الإجراء الجماعي لعنصر التهيئة ITSMItem';
    $Self->{Translation}->{'Deployment state'} = 'حالة النشر';
    $Self->{Translation}->{'Incident state'} = 'حالة الحادث';
    $Self->{Translation}->{'Link to another'} = 'رابط إلى آخر';
    $Self->{Translation}->{'Invalid Configuration Item number!'} = 'رقم عنصر التكوين غير صالح!';
    $Self->{Translation}->{'The number of another Configuration Item to link with.'} = 'رقم عنصر التكوين الآخر المراد الربط به.';

    # Template: AgentITSMConfigItemDelete
    $Self->{Translation}->{'Do you really want to delete this config item?'} = 'هل تريد حقاً حذف عنصر التكوين هذا؟';

    # Template: AgentITSMConfigItemEdit
    $Self->{Translation}->{'The name of this config item'} = 'اسم عنصر التكوين هذا';
    $Self->{Translation}->{'Name is already in use by the ConfigItems with the following Number(s): %s'} =
        'الاسم قيد الاستخدام بالفعل من قبل عناصر التكوين بالرقم (الأرقام) التالية: %s';
    $Self->{Translation}->{'Version Number'} = 'رقم الإصدار';
    $Self->{Translation}->{'Version number of this config item'} = 'رقم إصدار عنصر التكوين هذا';
    $Self->{Translation}->{'Version Number is already in use by the ConfigItems with the following Number(s): %s'} =
        'رقم الإصدار مستخدم بالفعل من قبل عناصر التكوين بالرقم (الأرقام) التالية: %s';
    $Self->{Translation}->{'Deployment State'} = 'حالة النشر';
    $Self->{Translation}->{'Incident State'} = 'حالة الحادث';

    # Template: AgentITSMConfigItemHistory
    $Self->{Translation}->{'History of Config Item: %s'} = 'تاريخ عنصر التكوين: %s';
    $Self->{Translation}->{'History Content'} = 'المحتوى التاريخي';
    $Self->{Translation}->{'Createtime'} = 'إنشاء الوقت';
    $Self->{Translation}->{'Zoom view'} = 'عرض التكبير';

    # Template: AgentITSMConfigItemOverviewNavBar
    $Self->{Translation}->{'Config Items per page'} = 'عناصر التكوين لكل صفحة';

    # Template: AgentITSMConfigItemOverviewSmall
    $Self->{Translation}->{'No config item data found.'} = 'لم يتم العثور على بيانات عنصر التكوين.';
    $Self->{Translation}->{'Select this config item'} = 'حدد عنصر التكوين هذا';

    # Template: AgentITSMConfigItemSearch
    $Self->{Translation}->{'Run Search'} = 'بدء البحث';
    $Self->{Translation}->{'Also search in previous versions?'} = 'البحث أيضاً في الإصدارات السابقة؟';

    # Template: AgentITSMConfigItemTreeView
    $Self->{Translation}->{'TreeView for ConfigItem'} = 'طريقة عرض الشجرة لعنصر التكوين';
    $Self->{Translation}->{'Depth Level'} = 'مستوى العمق';
    $Self->{Translation}->{'Zoom In/Out'} = 'التكبير/التصغير';
    $Self->{Translation}->{'Max links level reached for ConfigItem!'} = 'تم الوصول إلى الحد الأقصى لمستوى الروابط لـ ConfigItem!';

    # Template: AgentITSMConfigItemZoom
    $Self->{Translation}->{'Configuration Item'} = 'عنصر التكوين';
    $Self->{Translation}->{'Configuration Item Information'} = 'معلومات عنصر التكوين';
    $Self->{Translation}->{'Current Deployment State'} = 'حالة النشر الحالية';
    $Self->{Translation}->{'Current Incident State'} = 'حالة الحادث الحالي';
    $Self->{Translation}->{'Last changed'} = 'آخر تعديل';
    $Self->{Translation}->{'Last changed by'} = 'آخر تغيير من قبل';

    # Template: CustomerITSMConfigItem
    $Self->{Translation}->{'Your ConfigItems'} = 'عناصر التهيئة الخاصة بك';

    # Template: CustomerITSMConfigItemSearch
    $Self->{Translation}->{'ConfigItem Search'} = 'بحث عن عنصر التكوين';

    # Template: AdminACL
    $Self->{Translation}->{'Object Type'} = 'نوع الكائن';

    # Template: AdminDynamicFieldScreen
    $Self->{Translation}->{'Filter by object type'} = '';

    # JS Template: ClassImportConfirm
    $Self->{Translation}->{'The following classes will be imported'} = 'سيتم استيراد الفئات التالية';
    $Self->{Translation}->{'The following roles will be imported'} = 'سيتم استيراد الأدوار التالية';
    $Self->{Translation}->{'Note that also corresponding dynamic fields and GeneralCatalog classes will be created and there is no automatic removal.'} =
        'لاحظ أنه سيتم أيضًا إنشاء الحقول الديناميكية المقابلة وفئات GeneralCatalog العامة ولن يكون هناك إزالة تلقائية.';
    $Self->{Translation}->{'Do you want to proceed?'} = 'هل تريد المتابعة؟';

    # Perl Module: Kernel/Modules/AdminITSMConfigItem.pm
    $Self->{Translation}->{'Need ExampleClasses!'} = 'تحتاج إلى أمثلة!';
    $Self->{Translation}->{'Definition is no valid YAML hash.'} = 'التعريف لا يوجد تجزئة YAML صالحة.';

    # Perl Module: Kernel/Modules/AgentITSMConfigItem.pm
    $Self->{Translation}->{'Overview: ITSM ConfigItem'} = 'نظرة عامة: عنصر تكوين ITSMItem';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemBulk.pm
    $Self->{Translation}->{'No ConfigItemID is given!'} = 'لم يتم إعطاء معرف عنصر التكوين (ConfigItemID)!';
    $Self->{Translation}->{'You need at least one selected Configuration Item!'} = 'تحتاج إلى عنصر تكوين محدد واحد على الأقل!';
    $Self->{Translation}->{'You don\'t have write access to this configuration item: %s.'} =
        'ليس لديك حق الوصول للكتابة إلى عنصر التكوين هذا: %s.';
    $Self->{Translation}->{'No definition was defined for class %s!'} = 'لم يتم تعريف أي تعريف للفئة %s!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemDelete.pm
    $Self->{Translation}->{'Config item "%s" not found in database!'} = 'عنصر التكوين "%s" غير موجود في قاعدة البيانات!';
    $Self->{Translation}->{'Was not able to delete the configitem ID %s!'} = 'تعذر حذف معرف عنصر التكوين %s!';
    $Self->{Translation}->{'No version found for ConfigItemID %s!'} = 'لم يتم العثور على إصدار ل ConfigItemID %s!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemEdit.pm
    $Self->{Translation}->{'No ConfigItemID, DuplicateID or ClassID is given!'} = 'لم يتم إعطاء معرف التكوين أو معرف التكرار أو معرف الفئة!';
    $Self->{Translation}->{'No access is given!'} = 'لم يتم منح أي تصريح دخول!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemHistory.pm
    $Self->{Translation}->{'Can\'t show history, no ConfigItemID is given!'} = 'لا يمكن إظهار السجل، لم يتم إعطاء معرف التكوين!';
    $Self->{Translation}->{'Can\'t show history, no access rights given!'} = 'لا يمكن عرض السجل، لم يتم منح حقوق الوصول!';
    $Self->{Translation}->{'New ConfigItem (ID=%s)'} = 'عنصر التكوين الجديد (المعرف=%s)';
    $Self->{Translation}->{'New version (ID=%s)'} = 'الإصدار الجديد (المعرف=%s)';
    $Self->{Translation}->{'Deployment state updated (new=%s, old=%s)'} = 'تم تحديث حالة النشر (جديد=%s، قديم=%s)';
    $Self->{Translation}->{'Incident state updated (new=%s, old=%s)'} = 'تم تحديث حالة الحادث (جديد=%s، قديم=%s)';
    $Self->{Translation}->{'ConfigItem (ID=%s) deleted'} = 'تم حذف عنصر التكوين (المعرف=%s)';
    $Self->{Translation}->{'Link to %s (type=%s) added'} = 'تمت إضافة الارتباط إلى %s (النوع=%s)';
    $Self->{Translation}->{'Link to %s (type=%s) deleted'} = 'تم حذف الارتباط إلى %s (النوع=%s)';
    $Self->{Translation}->{'ConfigItem definition updated (ID=%s)'} = 'تم تحديث تعريف عنصر التكوين (المعرف=%s)';
    $Self->{Translation}->{'Name updated (new=%s, old=%s)'} = 'تم تحديث الاسم (جديد=%s، قديم=%s)';
    $Self->{Translation}->{'Attribute %s updated from "%s" to "%s"'} = 'تم تحديث السمة %s من "%s" إلى "%s"';
    $Self->{Translation}->{'Version %s deleted'} = 'تم حذف الإصدار %s';
    $Self->{Translation}->{'File "%s" uploaded'} = '';
    $Self->{Translation}->{'File "%s" removed'} = '';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemPrint.pm
    $Self->{Translation}->{'No ConfigItemID or VersionID is given!'} = 'لم يتم إعطاء معرف التكوين أو معرف الإصدار!';
    $Self->{Translation}->{'Can\'t show config item, no access rights given!'} = 'لا يمكن إظهار عنصر التكوين، لم يتم منح حقوق وصول!';
    $Self->{Translation}->{'ConfigItemID %s not found in database!'} = 'معرّف عنصر التكوين %s غير موجود في قاعدة البيانات!';
    $Self->{Translation}->{'ConfigItem'} = 'عنصر التكوين';
    $Self->{Translation}->{'printed by %s at %s'} = 'تمت طباعتها بواسطة %s في %s';
    $Self->{Translation}->{'Referenced by'} = '';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemSearch.pm
    $Self->{Translation}->{'Invalid ClassID!'} = 'معرّف الفئة غير صالح!';
    $Self->{Translation}->{'No ClassID is given!'} = 'لم يتم إعطاء أي معرّف للفئة!';
    $Self->{Translation}->{'No access rights for this class given!'} = 'لا توجد حقوق وصول لهذه الفئة معطاة!';
    $Self->{Translation}->{'No Result!'} = 'لا توجد نتيجة!';
    $Self->{Translation}->{'Config Item Search Results'} = 'نتائج البحث عن عنصر التكوين';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemZoom.pm
    $Self->{Translation}->{'Can\'t show item, no access rights for ConfigItem are given!'} =
        'لا يمكن إظهار العنصر، لا توجد حقوق وصول لـ ConfigItem!';
    $Self->{Translation}->{'ConfigItem not found!'} = 'لم يتم العثور على ConfigItem!';
    $Self->{Translation}->{'No versions found!'} = 'لم يتم العثور على أي إصدارات!';
    $Self->{Translation}->{'operational'} = 'التشغيلية';
    $Self->{Translation}->{'warning'} = 'تحذير';
    $Self->{Translation}->{'incident'} = 'الحادث';
    $Self->{Translation}->{'The deployment state of this config item'} = 'حالة النشر لعنصر التكوين هذا';
    $Self->{Translation}->{'The incident state of this config item'} = 'الحالة العارضة لعنصر التكوين هذا';

    # Perl Module: Kernel/Modules/CustomerITSMConfigItemSearch.pm
    $Self->{Translation}->{'No permission'} = 'لا توجد صلاحيات';
    $Self->{Translation}->{'Filter invalid!'} = 'الفلتر غير صالح!';
    $Self->{Translation}->{'Search params invalid!'} = 'بارامز البحث غير صالح!';

    # Perl Module: Kernel/Output/HTML/Dashboard/ITSMConfigItemGeneric.pm
    $Self->{Translation}->{'Shown config items'} = 'عناصر التكوين المعروضة';
    $Self->{Translation}->{'Deployment State Type'} = 'نوع حالة النشر';
    $Self->{Translation}->{'Current Incident State Type'} = 'نوع حالة الحادث الحالي';

    # Perl Module: Kernel/Output/HTML/ITSMConfigItem/LayoutDate.pm
    $Self->{Translation}->{'Between'} = 'بين';

    # Perl Module: Kernel/System/DynamicField/Driver/ConfigItem.pm
    $Self->{Translation}->{'Class restrictions for the config item'} = 'قيود الفئة لعنصر التكوين';
    $Self->{Translation}->{'Select one or more classes to restrict selectable config items'} =
        'حدد فئة واحدة أو أكثر لتقييد عناصر التكوين القابلة للتحديد';
    $Self->{Translation}->{'Deployment state restrictions for the config item'} = '';
    $Self->{Translation}->{'Select one or more deployment states to restrict selectable config items'} =
        '';
    $Self->{Translation}->{'Dynamic (ConfigItem)'} = 'ديناميكي (عنصر التكوين)';
    $Self->{Translation}->{'Static (Version)'} = 'ثابت (إصدار)';
    $Self->{Translation}->{'Link Referencing Type'} = 'نوع الإحالة المرجعية للرابط';
    $Self->{Translation}->{'Whether this link applies to the ConfigItem or the static version of the referencing object. Current Incident State calculation only is performed on dynamic links.'} =
        'ما إذا كان هذا الارتباط ينطبق على عنصر التكوين أو النسخة الثابتة من الكائن المرجعي. يتم إجراء حساب حالة الحادث الحالي فقط على الروابط الديناميكية.';
    $Self->{Translation}->{'Select the attribute which config items will be searched by'} = 'حدد السمة التي سيتم البحث عن عناصر التكوين من خلالها';

    # Perl Module: Kernel/System/ITSMConfigItem/Definition.pm
    $Self->{Translation}->{'Base structure is not valid. Please provide a hash with data in YAML format.'} =
        'البنية الأساسية غير صالحة. يرجى تقديم تجزئة مع البيانات بتنسيق YAML.';
    $Self->{Translation}->{'Starting the YAML string with \'---\' is required.'} = 'يلزم بدء سلسلة YAML بـ "---".';

    # Perl Module: Kernel/System/ITSMConfigItem/Link.pm
    $Self->{Translation}->{'Could not purge the table configitem_link.'} = 'تعذر مسح الجدول configitem_link.';
    $Self->{Translation}->{'No relevant dynamic fields were found'} = 'لم يتم العثور على أي حقول ديناميكية ذات صلة';
    $Self->{Translation}->{'Could not insert into the table configitem_link'} = 'تعذّر الإدراج في الجدول configitem_link';
    $Self->{Translation}->{'Inserted 0 rows into the table configitem_link'} = 'تم إدراج 0 صفوف في الجدول configitem_link';

    # Perl Module: Kernel/System/ImportExport/ObjectBackend/ITSMConfigItem.pm
    $Self->{Translation}->{'Maximum number of one element'} = 'الحد الأقصى لعدد عنصر واحد كحد أقصى';
    $Self->{Translation}->{'Maximum number of one Set dynamic field element'} = '';
    $Self->{Translation}->{'Maximum number of one element within a Set dynamic field element'} =
        '';
    $Self->{Translation}->{'Import/Export attachments (as the last entries per line)'} = 'استيراد/تصدير المرفقات (كآخر إدخالات في كل سطر)';
    $Self->{Translation}->{'Version String'} = 'سلسلة الإصدار';

    # Perl Module: Kernel/Modules/AdminDynamicField.pm
    $Self->{Translation}->{'Error synchronizing the definitions. Please check the log.'} = 'حدث خطأ في مزامنة التعريفات. يرجى التحقق من السجل.';
    $Self->{Translation}->{'You have ITSMConfigItem definitions which are not synchronized. Please deploy your ITSMConfigItem dynamic field changes.'} =
        'لديك تعريفات ITSMConfigItem غير متزامنة. يرجى نشر تغييرات الحقل الديناميكي لـ ITSMConfigItem.';

    # Database XML / SOPM Definition: ITSMConfigurationManagement.sopm
    $Self->{Translation}->{'Expired'} = 'منتهية الصلاحية';
    $Self->{Translation}->{'Maintenance'} = 'الصيانة';
    $Self->{Translation}->{'Pilot'} = 'طيّار';
    $Self->{Translation}->{'Planned'} = 'مخطط';
    $Self->{Translation}->{'Repair'} = 'الإصلاح';
    $Self->{Translation}->{'Retired'} = 'متقاعد';
    $Self->{Translation}->{'Review'} = 'المراجعة';
    $Self->{Translation}->{'Test/QA'} = 'الاختبار/ضمان الجودة';

    # JS File: ITSM.Admin.ITSMConfigItem
    $Self->{Translation}->{'Overview and Confirmation'} = 'نظرة عامة وتأكيد';
    $Self->{Translation}->{'Importing classes/roles and their related fields'} = 'استيراد الفئات/الأدوار والحقول المرتبطة بها';
    $Self->{Translation}->{'An error occurred during class import.'} = 'حدث خطأ أثناء استيراد الفئة.';

    # SysConfig
    $Self->{Translation}->{'0 - Hidden'} = '0 - مخفي';
    $Self->{Translation}->{'1 - Shown'} = '1 - معروض';
    $Self->{Translation}->{'A mapping of inner field names used in the Process Management TransitionActions ConfigItemAdd and -Update. The keys are the names of the set inner fields of the set with object type ticket which will be used to create/update the CI, and the values are the names of the inner fields of the set with object type ITSMConfigItem.'} =
        '';
    $Self->{Translation}->{'Allows extended search conditions in config item search of the agent interface. With this feature you can search e. g. config item name with this kind of conditions like "(*key1*&&*key2*)" or "(*key1*||*key2*)".'} =
        'يسمح بشروط بحث موسعة في البحث عن عنصر التكوين في واجهة الوكيل. باستخدام هذه الميزة يمكنك البحث مثلاً عن اسم عنصر التكوين مع هذا النوع من الشروط مثل "(*مفتاح 1*&*مفتاح 2*)" أو "(*مفتاح 1*||مفتاح 2*)".';
    $Self->{Translation}->{'Allows extended search conditions in config item search of the customer interface. With this feature you can search e. g. config item name with this kind of conditions like "(*key1*&&*key2*)" or "(*key1*||*key2*)".'} =
        'يسمح بشروط بحث موسعة في البحث عن عنصر التكوين في واجهة العميل. باستخدام هذه الميزة يمكنك البحث على سبيل المثال عن اسم عنصر التكوين مع هذا النوع من الشروط مثل "(*مفتاح 1*&*مفتاح 2*)" أو "(*مفتاح 1*||مفتاح 2*)".';
    $Self->{Translation}->{'Assigned CIs'} = 'المخبرين السريين المعينين';
    $Self->{Translation}->{'At a specific time point create a ticket for config items, if the configured requirements are met. The time point is determined by the value of the dynamic field of type date configured under "TimeCIKey" of the ConfigItem, and modified by "TimeModifier". If the latter can be either just a number, or a sign (+/-), a number, and an unit (d/h/m): "7" is equivalent to "+7d". The DynamicField "Ticket->DynamicField" will be used to mark created tickets - it has to exist. The flags \<OTOBO_CONFIGITEM_X\> where X can be NAME, NUMBER and DATE, will be substituted with the respective values in "Ticket->Text".'} =
        '';
    $Self->{Translation}->{'Attributes for license accounting.'} = '';
    $Self->{Translation}->{'Attributes for licenses counting, where "TotalLicensesDF", "AvailableLicensesDF" and "LicenseReferenceDF" are the names of the dynamic fields used to track the remaining licenses. If used, only deployment states in "ValidDeplStates" are considered. If a threshold is defined in "MinimumLicenses", a ticket will automatically be created if less licenses are available. For this, the checkbox dynamic field "Ticket->DynamicField" must exist. The tags \<OTOBO_CONFIGITEM_X\> where X can be NAME, NUMBER, LICENSES_AVAIL and LICENSES_MIN, will be substituted with the respective values in "Ticket->Text" by the config item name, number, available licenses, and minimum required available licenses, respectively.'} =
        '';
    $Self->{Translation}->{'CIs assigned to customer company'} = 'المخبرين السريين المعينين لشركة العميل';
    $Self->{Translation}->{'CIs assigned to customer user'} = 'المخبرون السريون المخصصون للمستخدم العميل';
    $Self->{Translation}->{'CMDB Settings'} = 'إعدادات CMDB';
    $Self->{Translation}->{'Check for a unique name only within the same ConfigItem class (\'class\') or globally (\'global\'), which means every existing ConfigItem is taken into account when looking for duplicates.'} =
        'تحقق من وجود اسم فريد فقط داخل نفس فئة ConfigItem (\'class\') أو عالميًا (\'عام\')، مما يعني أن كل عنصر تكوين موجود يؤخذ في الاعتبار عند البحث عن التكرارات.';
    $Self->{Translation}->{'Choose a module to enforce a naming scheme.'} = 'اختر وحدة نمطية لفرض نظام التسمية.';
    $Self->{Translation}->{'Choose a module to enforce a number scheme.'} = 'اختر وحدة نمطية لفرض مخطط أرقام.';
    $Self->{Translation}->{'Choose a module to enforce a version string scheme.'} = 'اختر وحدة نمطية لفرض مخطط سلسلة الإصدار.';
    $Self->{Translation}->{'Choose attributes to trigger the creation of a new version.'} = 'اختر السمات لتشغيل إنشاء إصدار جديد.';
    $Self->{Translation}->{'Choose categories to assign to this config item class.'} = 'اختر الفئات المراد تعيينها لفئة عنصر التكوين هذه.';
    $Self->{Translation}->{'Column config item filters for ConfigItem Overview.'} = 'مرشحات عنصر تكوين العمود لـ نظرة عامة على عنصر التكوين العمود.';
    $Self->{Translation}->{'Columns that can be filtered in the config item overview of the agent interface. Note: Only Config Item attributes and Dynamic Fields (DynamicField_NameX) are allowed.'} =
        'الأعمدة التي يمكن تصفيتها في النظرة العامة لعنصر التكوين في واجهة الوكيل. ملاحظة: يُسمح فقط بسمات عنصر التكوين والحقول الديناميكية (DynamicField_NameX).';
    $Self->{Translation}->{'Config Items'} = 'عناصر التكوين';
    $Self->{Translation}->{'Config item add.'} = 'إضافة عنصر التكوين.';
    $Self->{Translation}->{'Config item edit.'} = 'تعديل عنصر التكوين.';
    $Self->{Translation}->{'Config item event module that enables accounting licenses for a given config item.'} =
        '';
    $Self->{Translation}->{'Config item event module that enables logging to history in the agent interface.'} =
        'وحدة حدث عنصر التكوين النمطية التي تتيح التسجيل في السجل في واجهة الوكيل.';
    $Self->{Translation}->{'Config item event module that updates config items to their current definition.'} =
        'وحدة حدث عنصر التكوين النمطية التي تقوم بتحديث عناصر التكوين إلى تعريفها الحالي.';
    $Self->{Translation}->{'Config item history.'} = 'تاريخ عنصر التكوين.';
    $Self->{Translation}->{'Config item print.'} = 'طباعة عنصر التكوين.';
    $Self->{Translation}->{'Config item zoom.'} = 'تكبير عنصر التكوين.';
    $Self->{Translation}->{'ConfigItem Tree View'} = 'عرض شجرة عناصر التكوين';
    $Self->{Translation}->{'ConfigItem Version'} = 'إصدار عنصر التكوين';
    $Self->{Translation}->{'ConfigItems of the following classes will not be stored on the Elasticsearch server. To apply this to existing CIs, the CI migration has to be run via console, after changing this option.'} =
        'لن يتم تخزين عناصر التكوين من الفئات التالية على خادم Elasticsearch. لتطبيق ذلك على CIs الحالية، يجب تشغيل ترحيل CI عبر وحدة التحكم، بعد تغيير هذا الخيار.';
    $Self->{Translation}->{'ConfigItems with the following deployment states will not be stored on the Elasticsearch server. To apply this to existing CIs, the CI migration has to be run via console, after changing this option.'} =
        'لن يتم تخزين عناصر التكوين ذات حالات النشر التالية على خادم Elasticsearch. لتطبيق ذلك على CIs الحالية، يجب تشغيل ترحيل CI عبر وحدة التحكم، بعد تغيير هذا الخيار.';
    $Self->{Translation}->{'Configuration Item Limit'} = 'حد عنصر التكوين';
    $Self->{Translation}->{'Configuration Item limit per page.'} = 'حد عنصر التكوين لكل صفحة.';
    $Self->{Translation}->{'Configuration Management Database.'} = 'قاعدة بيانات إدارة التهيئة.';
    $Self->{Translation}->{'Configuration item bulk module.'} = 'وحدة تهيئة العنصر المجمّع لعنصر التكوين.';
    $Self->{Translation}->{'Configuration item search backend router of the agent interface.'} =
        'عنصر التكوين البحث عن عنصر التكوين الموجه الخلفي لواجهة الوكيل.';
    $Self->{Translation}->{'Configure the columns which are available for viewing Permission Conditions in the customer interface, when the corresponding Permission Condition Columns are not specifically configured. This setting is used as a fallback for the other Permission Condition Columns settings.'} =
        '';
    $Self->{Translation}->{'Configure the columns which are available when viewing the corresponding Permission Condition in the customer interface.'} =
        '';
    $Self->{Translation}->{'Create and manage the definitions for Configuration Items.'} = 'إنشاء تعريفات لعناصر التكوين وإدارتها.';
    $Self->{Translation}->{'Creates Tickets for ConfigItems at specific time points.'} = 'إنشاء تذاكر لعناصر التكوين في نقاط زمنية محددة.';
    $Self->{Translation}->{'Customers can see historic CI versions.'} = 'يمكن للعملاء الاطلاع على إصدارات CI التاريخية.';
    $Self->{Translation}->{'Customers have the possibility to manually switch between historic CI versions.'} =
        'يمكن للعملاء التبديل يدوياً بين إصدارات CI التاريخية.';
    $Self->{Translation}->{'Default data to use on attribute for config item search screen. Example: "ITSMConfigItemCreateTimePointFormat=year;ITSMConfigItemCreateTimePointStart=Last;ITSMConfigItemCreateTimePoint=2;".'} =
        'البيانات الافتراضية لاستخدامها في السمة لشاشة البحث عن عنصر التكوين. مثال: "ITSMConfigItemCreateTimePointFormat=سنة؛ ITSMConfigItemCreateTimePointStart=آخر؛ ITSMConfigItemCreateTimePoint=2؛"';
    $Self->{Translation}->{'Default data to use on attribute for config item search screen. Example: "ITSMConfigItemCreateTimeStartYear=2010;ITSMConfigItemCreateTimeStartMonth=10;ITSMConfigItemCreateTimeStartDay=4;ITSMConfigItemCreateTimeStopYear=2010;ITSMConfigItemCreateTimeStopMonth=11;ITSMConfigItemCreateTimeStopDay=3;".'} =
        'البيانات الافتراضية لاستخدامها في السمة لشاشة البحث عن عنصر التكوين. Example: "ITSMConfigItemCreateTimeStartYear=2010;ITSMConfigItemCreateTimeStartMonth=10;ITSMConfigItemCreateTimeStartDay=4;ITSMConfigItemCreateTimeStopYear=2010;ITSMConfigItemCreateTimeStopMonth=11;ITSMConfigItemCreateTimeStopDay=3;".';
    $Self->{Translation}->{'Define Actions where a settings button is available in the linked objects widget (LinkObject::ViewMode = "complex"). Please note that these Actions must have registered the following JS and CSS files: Core.AllocationList.css, Core.UI.AllocationList.js, Core.UI.Table.Sort.js, Core.Agent.TableFilters.js and Core.Agent.LinkObject.js.'} =
        'تعريف العمليات التي يجب أن يتوفر بها زر الإعدادات في ودجة كائن الرابط (LinkObject::ViewMode = "complex"). الرجاء ملاحظة أنه يجب تسجيل ملفات JS و CSS التالية لهذه الإجراءات: Core.CustomList.css، Core.UI.AllocationList.js، Core.UI.Table.Sort.js، Core.Agent.TableFilter.js.';
    $Self->{Translation}->{'Define a Template::Toolkit scheme for version strings. Only used if Version String Module is set to TemplateToolkit.'} =
        'تعريف مخطط قالب:::مجموعة أدوات لسلاسل الإصدار. يُستخدم فقط إذا تم تعيين وحدة سلسلة الإصدار إلى TemplateToolkit.';
    $Self->{Translation}->{'Define a set of conditions under which a customer is allowed to see a config item. Conditions can optionally be restricted to certain customer groups. Name is the only mandatory attribute. If no other options are given, all config items will be visible under that category.'} =
        'تحديد مجموعة من الشروط التي يُسمح بموجبها للعميل برؤية عنصر تكوين. يمكن تقييد الشروط اختياريًا على مجموعات معينة من العملاء. الاسم هو السمة الإلزامية الوحيدة. إذا لم يتم إعطاء أي خيارات أخرى، ستكون جميع عناصر التكوين مرئية تحت تلك الفئة.';
    $Self->{Translation}->{'Defines Required permissions to delete ITSM configuration items using the Generic Interface.'} =
        'يحدد الأذونات المطلوبة لحذف عناصر تكوين ITSM باستخدام الواجهة العامة.';
    $Self->{Translation}->{'Defines Required permissions to get ITSM configuration items using the Generic Interface.'} =
        'يحدد الأذونات المطلوبة للحصول على عناصر تكوين ITSM باستخدام الواجهة العامة.';
    $Self->{Translation}->{'Defines Required permissions to search ITSM configuration items using the Generic Interface.'} =
        'يحدد الأذونات المطلوبة للبحث في عناصر تكوين ITSM باستخدام الواجهة العامة.';
    $Self->{Translation}->{'Defines Required permissions to set ITSM configuration items using the Generic Interface.'} =
        'يحدد الأذونات المطلوبة لتعيين عناصر تكوين ITSM باستخدام الواجهة العامة.';
    $Self->{Translation}->{'Defines an overview module to show the small view of a configuration item list.'} =
        'يحدد وحدة نظرة عامة لإظهار العرض الصغير لقائمة عناصر التكوين.';
    $Self->{Translation}->{'Defines if the link type labels must be shown in the node connections.'} =
        'يحدد ما إذا كان يجب إظهار تسميات نوع الارتباط في اتصالات العقدة.';
    $Self->{Translation}->{'Defines regular expressions individually for each ConfigItem class to check the ConfigItem name and to show corresponding error messages.'} =
        'يحدد التعبيرات العادية بشكل فردي لكل فئة من فئات ConfigItem للتحقق من اسم عنصر التكوين وإظهار رسائل الخطأ المقابلة.';
    $Self->{Translation}->{'Defines the available columns of CIs in the config item overview depending on the CI class. Each entry must consist of a class name and an array of available fields for the corresponding class. Dynamic field entries have to honor the scheme DynamicField_FieldName.'} =
        'يحدد الأعمدة المتاحة من CI في النظرة العامة لعنصر التكوين اعتمادًا على فئة CI. يجب أن يتكون كل إدخال من اسم الفئة ومصفوفة من الحقول المتاحة للفئة المقابلة. يجب أن تحترم إدخالات الحقول الديناميكية المخطط DynamicField_FieldName.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of the agent interface.'} =
        'يحدد سمة عنصر التكوين الافتراضية لفرز عنصر التكوين لنتيجة البحث عن عنصر التكوين لواجهة الوكيل.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of the customer interface.'} =
        'يحدد سمة عنصر التكوين الافتراضية لفرز عنصر التكوين لنتيجة البحث عن عنصر التكوين في واجهة العميل.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of this operation.'} =
        'يحدد سمة عنصر التكوين الافتراضية لفرز عنصر التكوين لنتيجة بحث عنصر التكوين لهذه العملية.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the agent interface. Up: oldest on top. Down: latest on top.'} =
        'يحدد الترتيب الافتراضي لعنصر التكوين في نتيجة البحث عن عنصر التكوين في واجهة الوكيل. لأعلى: الأقدم في الأعلى. لأسفل: الأحدث في الأعلى.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the customer interface. Up: oldest on top. Down: latest on top.'} =
        'يحدد ترتيب عنصر التكوين الافتراضي في نتيجة البحث عن عنصر التكوين في واجهة العميل. لأعلى: الأقدم في الأعلى. لأسفل: الأحدث في الأعلى.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the this operation. Up: oldest on top. Down: latest on top.'} =
        'يحدد ترتيب عنصر التكوين الافتراضي في نتيجة البحث عن عنصر التكوين لهذه العملية. لأعلى: الأقدم في الأعلى. لأسفل: الأحدث في الأعلى.';
    $Self->{Translation}->{'Defines the default displayed columns of CIs in the config item overview depending on the CI class. Each entry must consist of a class name and an array of available fields for the corresponding class. Dynamic field entries have to honor the scheme DynamicField_FieldName.'} =
        'يحدد الأعمدة الافتراضية المعروضة من CIs في النظرة العامة لعنصر التكوين اعتمادًا على فئة CI. يجب أن يتكون كل إدخال من اسم الفئة ومصفوفة من الحقول المتاحة للفئة المقابلة. يجب أن تحترم إدخالات الحقول الديناميكية المخطط DynamicField_FieldName.';
    $Self->{Translation}->{'Defines the default relations depth to be shown.'} = 'يحدد عمق العلاقات الافتراضي الذي سيتم عرضه.';
    $Self->{Translation}->{'Defines the default shown config item search attribute for config item search screen.'} =
        'يحدد سمة البحث عن عنصر التكوين المعروضة الافتراضية لشاشة البحث عن عنصر التكوين.';
    $Self->{Translation}->{'Defines the default shown config item search attribute for config item search screen. Example: "Key" must have the name of the Dynamic Field in this case \'X\', "Content" must have the value of the Dynamic Field depending on the Dynamic Field type,  Text: \'a text\', Dropdown: \'1\', Date/Time: \'Search_DynamicField_XTimeSlotStartYear=1974; Search_DynamicField_XTimeSlotStartMonth=01; Search_DynamicField_XTimeSlotStartDay=26; Search_DynamicField_XTimeSlotStartHour=00; Search_DynamicField_XTimeSlotStartMinute=00; Search_DynamicField_XTimeSlotStartSecond=00; Search_DynamicField_XTimeSlotStopYear=2013; Search_DynamicField_XTimeSlotStopMonth=01; Search_DynamicField_XTimeSlotStopDay=26; Search_DynamicField_XTimeSlotStopHour=23; Search_DynamicField_XTimeSlotStopMinute=59; Search_DynamicField_XTimeSlotStopSecond=59;\' and or \'Search_DynamicField_XTimePointFormat=week; Search_DynamicField_XTimePointStart=Before; Search_DynamicField_XTimePointValue=7\';.'} =
        'يحدد سمة بحث عنصر التكوين الافتراضية المعروضة لشاشة بحث عنصر التكوين. مثال: "المفتاح" يجب أن يحتوي على اسم الحقل الديناميكي في هذه الحالة \'X\'، "المحتوى" يجب أن يحتوي على قيمة الحقل الديناميكي حسب نوع الحقل الديناميكي، النص: \'نص\'، القائمة المنسدلة: \'1\'، التاريخ/الوقت: \'Search_DynamicField_XTimeSlotStartYear=1974; Search_DynamicField_XTimeSlotStartMonth=01; Search_DynamicField_XTimeSlotStartDay=26; Search_DynamicField_XTimeSlotStartHour=00; Search_DynamicField_XDynamicField_XT TimeSlotStlotStartMinute=00؛ Search_DynamicField_X TimeSlotStartSecond=00؛ Search_DynamicField_X TimeSlotStopYear=2013؛ Search_DynamicField_X TimeSlotStopMonth=01 Search_DynamicField_XDynamicField_XT TimeSlotStopDay=26؛ Search_DynamicField_XTimeSlotStopHour=23؛ Search_DynamicField_XTimeSlotStopMinute=59؛ Search_DynamicField_XTimeSlotStopSecond=59;" و \'أو \'Search_DynamicField_XT_TimePointFormat=week؛ Search_DynamicField_XT_TimePointStart=قبل؛ Search_DynamicField_XT TimePointValue=7\'؛';
    $Self->{Translation}->{'Defines the default subobject of the class \'ITSMConfigItem\'.'} =
        'يحدد الكائن الفرعي الافتراضي للفئة \'ITSMConfigItem\'.';
    $Self->{Translation}->{'Defines the disabled columns of CIs in the config item overview depending on the CI class. Each entry must consist of a class name and an array of available fields for the corresponding class. Dynamic field entries have to honor the scheme DynamicField_FieldName.'} =
        '';
    $Self->{Translation}->{'Defines the height for the rich text editor component for this screen. Enter number (pixels) or percent value (relative).'} =
        'يحدد ارتفاع مكون محرر النص المنسق. حدد قيمة رقمية (بكسل) أو نسبة مئوية (نسبية).';
    $Self->{Translation}->{'Defines the number of rows for the CI definition editor in the admin interface.'} =
        'يحدد عدد الصفوف لمحرر تعريف CI في واجهة المسؤول.';
    $Self->{Translation}->{'Defines the order of incident states from high (e.g. cricital) to low (e.g. functional).'} =
        'يُحدد ترتيب الحالات العارضة من الأعلى (مثل الحلقية) إلى الأدنى (مثل الوظيفية).';
    $Self->{Translation}->{'Defines the relevant deployment states where linked tickets can affect the status of a CI.'} =
        'يحدد حالات النشر ذات الصلة التي يمكن أن تؤثر فيها التذاكر المرتبطة على حالة المخبر السري.';
    $Self->{Translation}->{'Defines the search limit for the AgentITSMConfigItem screen.'} =
        'يحدد حد البحث لشاشة AgentITSMConfigigItem.';
    $Self->{Translation}->{'Defines the search limit for the AgentITSMConfigItemSearch screen.'} =
        'يحدد حد البحث لشاشة AgentITSMConfigItemSearch.';
    $Self->{Translation}->{'Defines the search limit for the CustomerITSMConfigItem screen.'} =
        'يحدد حد البحث لشاشة CustomerITSMConfigigItem.';
    $Self->{Translation}->{'Defines the search limit for the CustomerITSMConfigItemSearch screen.'} =
        'يحدد حد البحث لشاشة CustomerITSMConfigItemSearch.';
    $Self->{Translation}->{'Defines the shown columns of CIs in the link table complex view for all CI classes. If there is no entry, then the default columns are shown.'} =
        'يحدد الأعمدة الظاهرة من CIs في طريقة العرض المعقدة لجدول الارتباط لجميع فئات CI. إذا لم يكن هناك إدخال، يتم عرض الأعمدة الافتراضية.';
    $Self->{Translation}->{'Defines the shown columns of CIs in the link table complex view, depending on the CI class. Each entry must be prefixed with the class name and double colons (i.e. Computer::). There are a few CI-Attributes that common to all CIs (example for the class Computer: Computer::Name, Computer::CurDeplState, Computer::CreateTime). To show individual CI-Attributes as defined in the CI-Definition, the following scheme must be used (example for the class Computer): Computer::HardDisk::1, Computer::HardDisk::1::Capacity::1, Computer::HardDisk::2, Computer::HardDisk::2::Capacity::1. If there is no entry for a CI class, then the default columns are shown.'} =
        'يحدد الأعمدة المعروضة من CI في طريقة العرض المعقدة لجدول الارتباط، اعتماداً على فئة CI. يجب أن يكون كل إدخال مسبوقًا باسم الفئة ونقطتين (أي الكمبيوتر:::::). هناك عدد قليل من سمات CI-Attributes المشتركة بين جميع CI (مثال لفئة الكمبيوتر: الحاسوب::الاسم، الحاسوب::CurDeplState، الحاسوب::CreateTime). لإظهار سمات CI-Attributes الفردية كما هي معرفة في تعريف CI-Definition، يجب استخدام المخطط التالي (مثال لفئة الكمبيوتر): الكمبيوتر::القرص الصلب::1، الكمبيوتر::القرص الصلب::1::السعة::1، الكمبيوتر: القرص الصلب::2، الكمبيوتر: القرص الصلب::2: السعة::1. في حالة عدم وجود إدخال لفئة CI، يتم عرض الأعمدة الافتراضية.';
    $Self->{Translation}->{'Defines which items are available for \'Action\' in third level of the ITSM Config Item ACL structure.'} =
        'يحدد العناصر المتاحة "للإجراء" في المستوى الثالث من بنية ACL لعنصر تكوين ITSM.';
    $Self->{Translation}->{'Defines which items are available in first level of the ITSM Config Item ACL structure.'} =
        'يحدد العناصر المتوفرة في المستوى الأول من بنية ACL لعنصر تكوين ITSM.';
    $Self->{Translation}->{'Defines which items are available in second level of the ITSM Config Item ACL structure.'} =
        'يحدد العناصر المتوفرة في المستوى الثاني من بنية ACL لعنصر تكوين ITSM.';
    $Self->{Translation}->{'Defines which type of link (named from the ticket perspective) can affect the status of a linked CI.'} =
        'يحدد نوع الارتباط (المسمى من منظور التذكرة) الذي يمكن أن يؤثر على حالة CI المرتبط.';
    $Self->{Translation}->{'Defines which type of ticket can affect the status of a linked CI.'} =
        'يحدد نوع التذكرة التي يمكن أن تؤثر على حالة المخبر المستقل المرتبط.';
    $Self->{Translation}->{'Definition Update'} = 'تحديث التعريف';
    $Self->{Translation}->{'Delete Configuration Item'} = 'حذف عنصر التهيئة';
    $Self->{Translation}->{'DeplState'} = 'ديبلستيت';
    $Self->{Translation}->{'Deployment State Color'} = 'لون حالة النشر';
    $Self->{Translation}->{'DeploymentState'} = 'حالة النشر';
    $Self->{Translation}->{'Duplicate'} = 'مكررة';
    $Self->{Translation}->{'Dynamic field event module that marks config item definitions as out of sync, if containing dynamic fields change.'} =
        'الوحدة النمطية لحدث الحقل الديناميكي التي تحدد تعريفات عناصر التكوين على أنها غير متزامنة، إذا كانت تحتوي على حقول ديناميكية متغيرة.';
    $Self->{Translation}->{'Dynamic fields shown in the additional ITSM field screen of the agent interface.'} =
        'الحقول الديناميكية المعروضة في شاشة حقل إدارة خدمات تكنولوجيا المعلومات والاتصالات الإضافي في واجهة الوكيل.';
    $Self->{Translation}->{'Dynamic fields shown in the config item overview screen of the customer interface.'} =
        'تظهر الحقول الديناميكية في شاشة النظرة العامة على عنصر التكوين في واجهة العميل.';
    $Self->{Translation}->{'Dynamic fields shown in the config item search screen of the agent interface.'} =
        'الحقول الديناميكية التي تظهر في شاشة البحث عن عنصر التكوين في واجهة الوكيل.';
    $Self->{Translation}->{'Enables configuration item bulk action feature for the agent frontend to work on more than one configuration item at a time.'} =
        'تمكين ميزة الإجراءات المجمعة لعنصر التكوين للواجهة الأمامية للوكيل للعمل على أكثر من عنصر تكوين واحد في كل مرة.';
    $Self->{Translation}->{'Enables configuration item bulk action feature only for the listed groups.'} =
        'تمكين ميزة الإجراء المجمع لعنصر التكوين فقط للمجموعات المدرجة.';
    $Self->{Translation}->{'Enables/disables the functionality to check ITSM onfiguration items for unique names. Before enabling this option you should check your system for already existing config items with duplicate names. You can do this with the console command Admin::ITSM::ConfigItem::ListDuplicates.'} =
        'تمكين/تعطيل وظيفة التحقق من عناصر تكوين ITSM بحثاً عن أسماء فريدة. قبل تمكين هذا الخيار، يجب عليك التحقق من النظام الخاص بك بحثًا عن عناصر التكوين الموجودة بالفعل ذات الأسماء المكررة. يمكنك القيام بذلك باستخدام أمر وحدة التحكم Admin::ITSM::ConfigItem::ListDuplicates.';
    $Self->{Translation}->{'Event module to set configitem-status on ticket-configitem-link.'} =
        'وحدة الحدث النمطية لتعيين حالة العنصر التكويني على رابط تذكرة-تكوين-عنصر-تكوين-رابط.';
    $Self->{Translation}->{'Fields of the configuration item index, used for the fulltext search. Fields are also stored, but are not mandatory for the overall functionality. Inclusion of attachments can be disabled by setting the entry to 0 or deleting it.'} =
        'حقول فهرس عناصر التكوين، المستخدمة للبحث عن النص الكامل. يتم تخزين الحقول أيضًا، ولكنها ليست إلزامية للوظيفة العامة. يمكن تعطيل إدراج المرفقات عن طريق تعيين الإدخال إلى 0 أو حذفه.';
    $Self->{Translation}->{'Fields stored in the configuration item index which are used for other things besides fulltext searches. For the complete functionality all fields are mandatory.'} =
        'الحقول المخزنة في فهرس عناصر التكوين التي تُستخدم لأشياء أخرى إلى جانب عمليات البحث عن النص الكامل. للوظائف الكاملة جميع الحقول إلزامية.';
    $Self->{Translation}->{'For every webservice (key) an array of classes (value) can be defined on which the import is restricted. For all chosen classes, or all existing classes the identifying attributes will have to be chosen in the invoker config.'} =
        'لكل خدمة ويب (مفتاح) يمكن تحديد مصفوفة من الفئات (القيمة) التي يتم تقييد الاستيراد عليها. بالنسبة لجميع الفئات المختارة، أو جميع الفئات الموجودة يجب اختيار سمات التعريف في تكوين المستدعي.';
    $Self->{Translation}->{'GenericInterface module registration for the ConfigItemCreate invoker layer.'} =
        '';
    $Self->{Translation}->{'GenericInterface module registration for the ConfigItemFetch invoker layer.'} =
        'تسجيل الوحدة النمطية GenericInterface لطبقة مستدعي ConfigItemFetch.';
    $Self->{Translation}->{'GenericInterface module registration for the ConfigItemUpdate invoker layer.'} =
        '';
    $Self->{Translation}->{'ITSM ConfigItem'} = 'عنصر التكوين ITSMItem';
    $Self->{Translation}->{'ITSM config item overview.'} = 'نظرة عامة على عنصر تكوين ITSM.';
    $Self->{Translation}->{'InciState'} = 'InciState';
    $Self->{Translation}->{'IncidentState'} = 'حالة الحادث';
    $Self->{Translation}->{'Includes deployment states in the config item search of the customer interface.'} =
        'يتضمن حالات النشر في البحث عن عنصر التكوين في واجهة العميل.';
    $Self->{Translation}->{'Includes incident states in the config item search of the customer interface.'} =
        'يتضمن حالات الحوادث في البحث عن عنصر التكوين في واجهة العميل.';
    $Self->{Translation}->{'License accounting configuration item event module.'} = '';
    $Self->{Translation}->{'Maximum number of config items to be displayed in the result of this operation.'} =
        'الحد الأقصى لعدد عناصر التكوين التي سيتم عرضها في نتيجة هذه العملية.';
    $Self->{Translation}->{'Module to check the group responsible for a class.'} = 'الوحدة النمطية للتحقق من المجموعة المسؤولة عن فئة ما.';
    $Self->{Translation}->{'Module to check the group responsible for a configuration item.'} =
        'الوحدة النمطية للتحقق من المجموعة المسؤولة عن عنصر التكوين.';
    $Self->{Translation}->{'Module to generate ITSM config item statistics.'} = 'الوحدة النمطية لإنشاء إحصائيات عناصر تكوين ITSM.';
    $Self->{Translation}->{'Name Module'} = 'وحدة الاسم';
    $Self->{Translation}->{'Number Module'} = 'وحدة الأرقام';
    $Self->{Translation}->{'Number of config items to be displayed in each page of a search result in the agent interface.'} =
        'عدد عناصر التكوين التي سيتم عرضها في كل صفحة من نتائج البحث في واجهة الوكيل.';
    $Self->{Translation}->{'Number of config items to be displayed in each page of a search result in the customer interface.'} =
        'عدد عناصر التكوين التي سيتم عرضها في كل صفحة من نتائج البحث في واجهة العميل.';
    $Self->{Translation}->{'Objects to search for, how many entries and which attributs to show. ConfigItem attributes have to explicitly be stored via Elasticsearch.'} =
        'الكائنات التي يجب البحث عنها، وعدد الإدخالات والسمات التي يجب إظهارها. يجب تخزين سمات ConfigItem بشكل صريح عبر Elasticsearch.';
    $Self->{Translation}->{'Overview.'} = 'نظرة عامة';
    $Self->{Translation}->{'Parameters for the categories for config item classes in the preferences view of the agent interface.'} =
        'المعلمات الخاصة بفئات فئات عناصر التكوين في عرض التفضيلات في واجهة الوكيل.';
    $Self->{Translation}->{'Parameters for the column filters of the small config item overview. Please note: setting \'Active\' to 0 will only prevent agents from editing settings of this group in their personal preferences, but will still allow administrators to edit the settings of another user\'s behalf. Use \'PreferenceGroup\' to control in which area these settings should be shown in the user interface.'} =
        'معلمات مرشحات الأعمدة في النظرة العامة لعنصر التكوين الصغير. يرجى ملاحظة: تعيين \'نشط\' إلى 0 سيمنع الوكلاء فقط من تحرير إعدادات هذه المجموعة في تفضيلاتهم الشخصية، ولكنه سيسمح للمسؤولين بتحرير إعدادات مستخدم آخر نيابةً عن مستخدم آخر. استخدم \'PreferenceGroup\' للتحكم في المنطقة التي يجب أن تظهر فيها هذه الإعدادات في واجهة المستخدم.';
    $Self->{Translation}->{'Parameters for the dashboard backend of the customer company config item overview of the agent interface . "Limit" is the number of entries per config item class shown by default. "Group" is used to restrict the access to the plugin (e. g. Group: admin;group1;group2;). "Default" determines if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" is the cache time in minutes for the plugin. "ConfigItemKey" is used to specify which reference field is used for a ConfigItem class (Key=Class, Value=DynamicFieldName).'} =
        '';
    $Self->{Translation}->{'Parameters for the dashboard backend of the customer company config item overview of the agent interface . "Limit" is the number of entries shown by default. "Group" is used to restrict the access to the plugin (e. g. Group: admin;group1;group2;). "Default" determines if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" is the cache time in minutes for the plugin. "ConfigItemKey" is used to specify which reference field is used for a ConfigItem class (Key=Class, Value=DynamicFieldName).'} =
        '';
    $Self->{Translation}->{'Parameters for the deployment states color in the preferences view of the agent interface.'} =
        'معلمات لون حالات النشر في عرض التفضيلات في واجهة الوكيل.';
    $Self->{Translation}->{'Parameters for the deployment states in the preferences view of the agent interface.'} =
        'معلمات لحالات النشر في عرض التفضيلات في واجهة الوكيل.';
    $Self->{Translation}->{'Parameters for the example permission groups of the general catalog attributes.'} =
        'المعلمات الخاصة بأمثلة مجموعات الأذونات الخاصة بسمات الكتالوج العام.';
    $Self->{Translation}->{'Parameters for the name module for config item classes in the preferences view of the agent interface.'} =
        'معلمات وحدة الاسم النمطية لفئات عناصر التكوين في عرض التفضيلات لواجهة الوكيل.';
    $Self->{Translation}->{'Parameters for the number module for config item classes in the preferences view of the agent interface.'} =
        'معلمات الوحدة النمطية للرقم لفئات عناصر التكوين في عرض التفضيلات لواجهة الوكيل.';
    $Self->{Translation}->{'Parameters for the pages (in which the configuration items are shown).'} =
        'معلمات الصفحات (التي تظهر فيها عناصر التكوين).';
    $Self->{Translation}->{'Parameters for the version string module for config item classes in the preferences view of the agent interface.'} =
        'معلمات الوحدة النمطية لسلسلة الإصدار لفئات عناصر التكوين في طريقة عرض التفضيلات لواجهة الوكيل.';
    $Self->{Translation}->{'Parameters for the version string template toolkit module for config item classes in the preferences view of the agent interface.'} =
        'معلمات للوحدة النمطية لمجموعة أدوات قالب سلسلة الإصدار لفئات عناصر التكوين في عرض التفضيلات لواجهة الوكيل.';
    $Self->{Translation}->{'Parameters for the version trigger for config item classes in the preferences view of the agent interface.'} =
        'معلمات مشغل الإصدار لفئات عناصر التكوين في عرض التفضيلات لواجهة الوكيل.';
    $Self->{Translation}->{'Performs the configured action for each event (as an Invoker) for each configured Webservice.'} =
        'يقوم بتنفيذ الإجراء المكوّن لكل حدث (كمستدعي) لكل خدمة ويب مكوّنة.';
    $Self->{Translation}->{'Permission Group'} = 'مجموعة الإذن';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item attachment action in the agent interface.'} =
        'الأذونات المطلوبة لاستخدام إجراء إرفاق عنصر تكوين ITSM في واجهة الوكيل.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item screen in the agent interface.'} =
        'الأذونات المطلوبة لاستخدام شاشة عنصر تكوين ITSM في واجهة الوكيل.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item search screen in the agent interface.'} =
        'الأذونات المطلوبة لاستخدام شاشة البحث عن عنصر تكوين ITSM في واجهة الوكيل.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item search screen in the customer interface.'} =
        'الأذونات المطلوبة لاستخدام شاشة البحث عن عنصر تكوين ITSM في واجهة العميل.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item tree view screen in the agent interface.'} =
        'الأذونات المطلوبة لاستخدام شاشة عرض شجرة عناصر تكوين ITSM في واجهة الوكيل.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item zoom screen in the agent interface.'} =
        'الأذونات المطلوبة لاستخدام شاشة تكبير عنصر تكوين ITSM في واجهة الوكيل.';
    $Self->{Translation}->{'Required permissions to use the add ITSM configuration item screen in the agent interface.'} =
        'الأذونات المطلوبة لاستخدام شاشة إضافة عنصر تكوين ITSM في واجهة الوكيل.';
    $Self->{Translation}->{'Required permissions to use the bulk ITSM configuration item screen in the agent interface.'} =
        'الأذونات المطلوبة لاستخدام شاشة عناصر تكوين ITSM المجمعة في واجهة الوكيل.';
    $Self->{Translation}->{'Required permissions to use the edit ITSM configuration item screen in the agent interface.'} =
        'الأذونات المطلوبة لاستخدام شاشة تحرير عنصر تكوين ITSM في واجهة الوكيل.';
    $Self->{Translation}->{'Required permissions to use the history ITSM configuration item screen in the agent interface.'} =
        'الأذونات المطلوبة لاستخدام شاشة عنصر تكوين محفوظات ITSM في واجهة الوكيل.';
    $Self->{Translation}->{'Required permissions to use the print ITSM configuration item screen in the agent interface.'} =
        'الأذونات المطلوبة لاستخدام شاشة عنصر تكوين ITSM للطباعة في واجهة الوكيل.';
    $Self->{Translation}->{'Required privileges to delete config items.'} = 'الامتيازات المطلوبة لحذف عناصر التكوين.';
    $Self->{Translation}->{'Search config items.'} = 'عناصر تكوين البحث.';
    $Self->{Translation}->{'Set the incident state of a CI automatically when a Ticket is Linked to a CI.'} =
        'قم بتعيين حالة الحادث لمخبر جنائي تلقائياً عند ربط تذكرة بمخبر جنائي.';
    $Self->{Translation}->{'Sets the deployment state in the configuration item bulk screen of the agent interface.'} =
        'يقوم بتعيين حالة النشر في الشاشة المجمعة لعنصر التكوين في واجهة الوكيل.';
    $Self->{Translation}->{'Sets the incident state in the configuration item bulk screen of the agent interface.'} =
        'يقوم بتعيين حالة الحادث في الشاشة المجمعة لعنصر التكوين الخاص بواجهة الوكيل.';
    $Self->{Translation}->{'Shows a link in the menu that allows linking a configuration item with another object in the config item zoom view of the agent interface.'} =
        'يعرض رابطًا في القائمة يسمح بربط عنصر تكوين مع كائن آخر في عرض تكبير عنصر التكوين في واجهة الوكيل.';
    $Self->{Translation}->{'Shows a link in the menu to access the history of a configuration item in the configuration item overview of the agent interface.'} =
        'إظهار رابط في القائمة للوصول إلى محفوظات عنصر التكوين في نظرة عامة على عنصر التكوين في واجهة الوكيل.';
    $Self->{Translation}->{'Shows a link in the menu to access the history of a configuration item in the its zoom view of the agent interface.'} =
        'يعرض رابطًا في القائمة للوصول إلى محفوظات عنصر التكوين في عرض التكبير الخاص به في واجهة الوكيل.';
    $Self->{Translation}->{'Shows a link in the menu to delete a configuration item in its zoom view of the agent interface.'} =
        'يعرض رابطاً في القائمة لحذف عنصر تكوين في عرض التكبير/التصغير الخاص به في واجهة الوكيل.';
    $Self->{Translation}->{'Shows a link in the menu to display the configuration item links as a Tree View.'} =
        'إظهار رابط في القائمة لعرض روابط عناصر التكوين كطريقة عرض الشجرة.';
    $Self->{Translation}->{'Shows a link in the menu to duplicate a configuration item in the configuration item overview of the agent interface.'} =
        'إظهار ارتباط في القائمة لتكرار عنصر تكوين في نظرة عامة على عنصر التكوين في واجهة الوكيل.';
    $Self->{Translation}->{'Shows a link in the menu to duplicate a configuration item in the its zoom view of the agent interface.'} =
        'يعرض رابط في القائمة لتكرار عنصر تكوين في عرض التكبير الخاص به في واجهة الوكيل.';
    $Self->{Translation}->{'Shows a link in the menu to edit a configuration item in the its zoom view of the agent interface.'} =
        'يعرض رابطاً في القائمة لتحرير عنصر تكوين في عرض التكبير/التصغير الخاص به في واجهة الوكيل.';
    $Self->{Translation}->{'Shows a link in the menu to go back in the configuration item zoom view of the agent interface.'} =
        'إظهار رابط في القائمة للرجوع في عرض تكبير عنصر التكوين لواجهة الوكيل.';
    $Self->{Translation}->{'Shows a link in the menu to print a configuration item in the its zoom view of the agent interface.'} =
        'يعرض رابطًا في القائمة لطباعة عنصر تكوين في عرض التكبير/التصغير الخاص به لواجهة الوكيل.';
    $Self->{Translation}->{'Shows a link in the menu to zoom into a configuration item in the configuration item overview of the agent interface.'} =
        'يعرض رابطاً في القائمة لتكبير عنصر تكوين في نظرة عامة على عنصر التكوين في واجهة الوكيل.';
    $Self->{Translation}->{'Shows the config item history (reverse ordered) in the agent interface.'} =
        'يعرض محفوظات عناصر التكوين (ترتيب عكسي) في واجهة الوكيل.';
    $Self->{Translation}->{'The default category which is shown, if none is selected.'} = 'الفئة الافتراضية التي تظهر، إذا لم يتم تحديد أي فئة.';
    $Self->{Translation}->{'The identifier for a configuration item, e.g. ConfigItem#, MyConfigItem#. The default is ConfigItem#.'} =
        'معرّف عنصر التكوين، على سبيل المثال ConfigItem#، MyConfigItem#. الافتراضي هو ConfigItem#.';
    $Self->{Translation}->{'Triggers ConfigItemFetch invoker automatically.'} = 'يقوم بتشغيل مستدعي ConfigItemFetch تلقائيًا.';
    $Self->{Translation}->{'Version String Expression'} = 'تعبير سلسلة الإصدار';
    $Self->{Translation}->{'Version String Module'} = 'وحدة سلسلة الإصدار';
    $Self->{Translation}->{'Version Trigger'} = 'مشغل الإصدار';
    $Self->{Translation}->{'Whether fields should be automatically filled (1), and in that case also be hidden from ticket formulars (2).'} =
        '';
    $Self->{Translation}->{'Whether the execution of ConfigItemACL can be avoided by checking cached field dependencies. This can improve loading times of formulars, but has to be disabled, if ACLModules are to be used for ITSMConfigItem- and Form-ReturnTypes.'} =
        'ما إذا كان يمكن تجنب تنفيذ ConfigItemACL عن طريق التحقق من تبعيات الحقول المخزنة مؤقتًا. يمكن أن يؤدي ذلك إلى تحسين أوقات تحميل النماذج، ولكن يجب تعطيله، إذا كان سيتم استخدام وحدات ACLModules لـ ITSMConfigonfigItem- و Form-ReturnTypes.';
    $Self->{Translation}->{'Which general information is shown in the header.'} = 'ما هي المعلومات العامة التي تظهر في العنوان.';
    $Self->{Translation}->{'class'} = 'الفئة';
    $Self->{Translation}->{'global'} = 'عالمي';
    $Self->{Translation}->{'postproductive'} = 'ما بعد الإنتاجية';
    $Self->{Translation}->{'preproductive'} = 'ما قبل الإنجاب';
    $Self->{Translation}->{'productive'} = 'منتجة';

    # Ready to adopt classes: IT-Servicemanagement-11_0_3
    $Self->{Translation}->{'10U: 17.5 inches (44.45 cm)'} = '10U: 17.5 بوصة (44.45 سم)';
    $Self->{Translation}->{'12U: 21 inches (53.34 cm)'} = '12U: 21 بوصة (53.34 سم)';
    $Self->{Translation}->{'15U: 26.25 inches (66.68 cm)'} = '15U: 26.25 بوصة (66.68 سم)';
    $Self->{Translation}->{'18U: 31.5 inches (80.01 cm)'} = '18U: 31.5 بوصة (80.01 سم)';
    $Self->{Translation}->{'19-inch Rack'} = 'حامل 19 بوصة';
    $Self->{Translation}->{'1U: 1.75 inches (4.45 cm)'} = '1U: 1.75 بوصة (4.45 سم)';
    $Self->{Translation}->{'20U: 35 inches (88.9 cm)'} = '20U: 35 بوصة (88.9 سم)';
    $Self->{Translation}->{'21-inch Rack'} = 'رف 21 بوصة';
    $Self->{Translation}->{'22U: 38.5 inches (97.79 cm)'} = '22U: 38.5 بوصة (97.79 سم)';
    $Self->{Translation}->{'23-inch Rack'} = 'رف 23 بوصة';
    $Self->{Translation}->{'23.6 inches (600 mm)'} = '23.6 بوصة (600 مم)';
    $Self->{Translation}->{'24U: 42 inches (106.68 cm)'} = '24U: 42 بوصة (106.68 سم)';
    $Self->{Translation}->{'27U: 47.25 inches (120.02 cm)'} = '27U: 47.25 بوصة (120.02 سم)';
    $Self->{Translation}->{'2U: 3.5 inches (8.89 cm)'} = '2U: 3.5 بوصة (8.89 سم)';
    $Self->{Translation}->{'30U: 52.5 inches (133.35 cm)'} = '30U: 52.5 بوصة (133.35 سم)';
    $Self->{Translation}->{'31.5 inches (800 mm)'} = '31.5 بوصة (800 مم)';
    $Self->{Translation}->{'33U: 57.75 inches (146.68 cm)'} = '33U: 57.75 بوصة (146.68 سم)';
    $Self->{Translation}->{'35.4 inches (900 mm)'} = '35.4 بوصة (900 مم)';
    $Self->{Translation}->{'36U: 63 inches (160.02 cm)'} = '36U: 63 بوصة (160.02 سم)';
    $Self->{Translation}->{'39.4 inches (1000 mm)'} = '39.4 بوصة (1000 مم)';
    $Self->{Translation}->{'39U: 68.25 inches (173.35 cm)'} = '39U: 68.25 بوصة (173.35 سم)';
    $Self->{Translation}->{'3U: 5.25 inches (13.34 cm)'} = '3U: 5.25 بوصة (13.34 سم)';
    $Self->{Translation}->{'42U: 73.5 inches (186.69 cm)'} = '42U: 73.5 بوصة (186.69 سم)';
    $Self->{Translation}->{'43.3 inches (1100 mm):'} = '43.3 بوصة (1100 مم):';
    $Self->{Translation}->{'45U: 78.75 inches (200.02 cm)'} = '45U: 78.75 بوصة (200.02 سم)';
    $Self->{Translation}->{'47.2 inches (1200 mm)'} = '47.2 بوصة (1200 مم)';
    $Self->{Translation}->{'48U: 84 inches (213.36 cm)'} = '48U: 84 بوصة (213.36 سم)';
    $Self->{Translation}->{'4U: 7 inches (17.78 cm)'} = '4U: 7 بوصات (17.78 سم)';
    $Self->{Translation}->{'5U: 8.75 inches (22.23 cm)'} = '5U: 8.75 بوصة (22.23 سم)';
    $Self->{Translation}->{'6U: 10.5 inches (26.67 cm)'} = '6U: 10.5 بوصة (26.67 سم)';
    $Self->{Translation}->{'7U: 12.25 inches (31.12 cm)'} = '7U: 12.25 بوصة (31.12 سم)';
    $Self->{Translation}->{'8U: 14 inches (35.56 cm)'} = '8U: 14 بوصة (35.56 سم)';
    $Self->{Translation}->{'9U: 15.75 inches (40.01 cm)'} = '9U: 15.75 بوصة (40.01 سم)';
    $Self->{Translation}->{'AGPL (Affero General Public License)'} = '';
    $Self->{Translation}->{'Accounting'} = 'المحاسبة';
    $Self->{Translation}->{'Accounting Information'} = '';
    $Self->{Translation}->{'Address Allocation'} = 'تخصيص العنوان';
    $Self->{Translation}->{'Administrator'} = 'المدير';
    $Self->{Translation}->{'Analog Phone'} = 'هاتف تناظري';
    $Self->{Translation}->{'Apache Lizenz'} = '';
    $Self->{Translation}->{'Appliance Type'} = 'نوع الجهاز';
    $Self->{Translation}->{'BSD Lizenz (Berkeley Software Distribution License)'} = '';
    $Self->{Translation}->{'Battery Capacity (Ah)'} = 'سعة البطارية (آه)';
    $Self->{Translation}->{'Battery Type'} = 'نوع البطارية';
    $Self->{Translation}->{'Building'} = 'البناء';
    $Self->{Translation}->{'Bus Interface'} = 'واجهة الحافلة';
    $Self->{Translation}->{'CC0 (Creative Commons Zero)'} = '';
    $Self->{Translation}->{'CIDR'} = 'CIDR';
    $Self->{Translation}->{'CPU'} = 'وحدة المعالجة المركزية';
    $Self->{Translation}->{'CPU Class'} = 'فئة وحدة المعالجة المركزية';
    $Self->{Translation}->{'Capacity (GB)'} = 'السعة (غيغابايت)';
    $Self->{Translation}->{'Capacity per graphics card'} = 'السعة لكل بطاقة رسومات';
    $Self->{Translation}->{'Card Number'} = 'رقم البطاقة';
    $Self->{Translation}->{'Card Reader'} = 'قارئ البطاقات';
    $Self->{Translation}->{'Card Type'} = 'نوع البطاقة';
    $Self->{Translation}->{'Client Certificates'} = 'شهادات العميل';
    $Self->{Translation}->{'Client Software'} = 'برنامج العميل';
    $Self->{Translation}->{'Client category'} = 'فئة العميل';
    $Self->{Translation}->{'Clockrate'} = 'عقارب الساعة';
    $Self->{Translation}->{'Clockspeed'} = 'سرعة الساعة';
    $Self->{Translation}->{'Code Signing Certificates'} = 'شهادات توقيع الرموز المشفرة';
    $Self->{Translation}->{'Conference Phone'} = 'هاتف المؤتمر';
    $Self->{Translation}->{'Consulting Agreement'} = 'الاتفاقية الاستشارية';
    $Self->{Translation}->{'Contact'} = 'اتصل بنا';
    $Self->{Translation}->{'Contact Distributor'} = 'اتصل بالموزع';
    $Self->{Translation}->{'Container Management'} = 'إدارة الحاويات';
    $Self->{Translation}->{'Contract'} = 'العقد';
    $Self->{Translation}->{'Contract Type'} = 'نوع العقد';
    $Self->{Translation}->{'Contract period from'} = 'فترة العقد من';
    $Self->{Translation}->{'Contract period until'} = 'فترة العقد حتى';
    $Self->{Translation}->{'Cordless Phone (DECT Phone)'} = 'هاتف لاسلكي (هاتف DECT)';
    $Self->{Translation}->{'Cost unit'} = 'وحدة التكلفة';
    $Self->{Translation}->{'Count of licenses'} = 'عدد التراخيص';
    $Self->{Translation}->{'Creation Date'} = 'تاريخ الإنشاء';
    $Self->{Translation}->{'Creative Commons'} = '';
    $Self->{Translation}->{'Custom Rack'} = 'رف مخصص';
    $Self->{Translation}->{'DHCP'} = 'DHCP';
    $Self->{Translation}->{'DHCP Reserved'} = 'DHCP محجوز';
    $Self->{Translation}->{'DNS-Server'} = 'خادم خوادم DNS';
    $Self->{Translation}->{'DVI'} = 'DVI';
    $Self->{Translation}->{'Date of Invoice'} = 'تاريخ الفاتورة';
    $Self->{Translation}->{'Date of Order'} = 'تاريخ الطلب';
    $Self->{Translation}->{'Date of Warranty'} = 'تاريخ الضمان';
    $Self->{Translation}->{'Date of release'} = 'تاريخ الإصدار';
    $Self->{Translation}->{'Desktop'} = 'سطح المكتب';
    $Self->{Translation}->{'DisplayPort'} = 'منفذ العرض';
    $Self->{Translation}->{'Document Signing Certificates'} = 'شهادات توقيع المستندات';
    $Self->{Translation}->{'EPL (Eclipse Public License)'} = '';
    $Self->{Translation}->{'ETSI Rack'} = 'رف ETSI';
    $Self->{Translation}->{'Email Certificates (S/MIME Certificates)'} = 'شهادات البريد الإلكتروني (شهادات S/MIME)';
    $Self->{Translation}->{'Embedded SIM (eSIM)'} = '';
    $Self->{Translation}->{'Employment Contract'} = 'عقد العمل';
    $Self->{Translation}->{'End IP Address'} = 'عنوان IP النهائي';
    $Self->{Translation}->{'End of support'} = 'نهاية الدعم';
    $Self->{Translation}->{'Expiry Date'} = 'تاريخ انتهاء الصلاحية';
    $Self->{Translation}->{'External Hard Drive'} = 'محرك أقراص صلبة خارجي';
    $Self->{Translation}->{'Firewall'} = 'جدار الحماية';
    $Self->{Translation}->{'Firmware'} = 'البرامج الثابتة';
    $Self->{Translation}->{'Flywheel Energy Storage'} = 'تخزين الطاقة في دولاب الموازنة';
    $Self->{Translation}->{'Form Factor'} = 'عامل الشكل';
    $Self->{Translation}->{'Franchise Agreement'} = 'اتفاقية الامتياز';
    $Self->{Translation}->{'Freeware'} = 'برنامج مجاني';
    $Self->{Translation}->{'GPL (General Public License)'} = '';
    $Self->{Translation}->{'General Information'} = 'معلومات عامة';
    $Self->{Translation}->{'Graphics Cards'} = 'بطاقات الرسومات';
    $Self->{Translation}->{'Graphics card'} = 'بطاقة الرسومات';
    $Self->{Translation}->{'HDMI'} = 'HDMI';
    $Self->{Translation}->{'Hardware'} = 'الأجهزة';
    $Self->{Translation}->{'Hardware Model'} = 'نموذج الأجهزة';
    $Self->{Translation}->{'Hardware Weight'} = 'وزن الأجهزة';
    $Self->{Translation}->{'Headset'} = 'سماعة الرأس';
    $Self->{Translation}->{'IP Protocol'} = 'بروتوكول IP';
    $Self->{Translation}->{'Identity and Access Management (IAM)'} = 'إدارة الهوية والوصول (IAM)';
    $Self->{Translation}->{'Inventory Number'} = 'رقم المخزون';
    $Self->{Translation}->{'Inverstment costs'} = 'تكاليف العاكس';
    $Self->{Translation}->{'Invoice Number'} = 'رقم الفاتورة';
    $Self->{Translation}->{'Keyboard'} = 'لوحة المفاتيح';
    $Self->{Translation}->{'LCD Monitor (Liquid Crystal Display)'} = 'شاشة LCD (شاشة العرض البلورية السائلة)';
    $Self->{Translation}->{'LED Monitor (Light Emitting Diode)'} = 'شاشة LED (الصمام الثنائي الباعث للضوء)';
    $Self->{Translation}->{'LGPL (Lesser General Public License)'} = '';
    $Self->{Translation}->{'Landline Phone'} = 'الهاتف الأرضي';
    $Self->{Translation}->{'Laptop'} = 'كمبيوتر محمول';
    $Self->{Translation}->{'Latitude'} = 'خط العرض';
    $Self->{Translation}->{'Layer 1: Physical Layer'} = 'الطبقة 1: الطبقة الفيزيائية';
    $Self->{Translation}->{'Layer 2: Data Link Layer'} = 'الطبقة 2: طبقة ارتباط البيانات';
    $Self->{Translation}->{'Layer 3: Network Layer'} = 'الطبقة 3: طبقة الشبكة';
    $Self->{Translation}->{'Layer 3: Network Layer (Supernet)'} = 'الطبقة 3: طبقة الشبكة (الشبكة الفائقة)';
    $Self->{Translation}->{'Layer 4: Transport Layer'} = 'الطبقة 4: طبقة النقل 4: طبقة النقل';
    $Self->{Translation}->{'Layer 5: Session Layer'} = 'الطبقة 5: طبقة الجلسة 5: طبقة الجلسة';
    $Self->{Translation}->{'Layer 6: Presentation Layer'} = 'الطبقة 6: طبقة العرض التقديمي';
    $Self->{Translation}->{'Layer 7: Application Layer'} = 'الطبقة 7: طبقة التطبيقات';
    $Self->{Translation}->{'Lease Agreement'} = 'عقد الإيجار';
    $Self->{Translation}->{'License Agreement'} = 'اتفاقية الترخيص';
    $Self->{Translation}->{'License Count'} = '';
    $Self->{Translation}->{'License Key'} = 'مفتاح الترخيص';
    $Self->{Translation}->{'License Type'} = 'نوع الترخيص';
    $Self->{Translation}->{'License period from'} = 'فترة الترخيص من';
    $Self->{Translation}->{'License period until'} = 'فترة الترخيص حتى';
    $Self->{Translation}->{'Lithium Iron Phosphate (LiFePO4) Battery'} = 'بطارية ليثيوم فوسفات الحديد (LiFePO4)';
    $Self->{Translation}->{'Lithium-Ion (Li-ion) Battery'} = 'بطارية ليثيوم أيون (ليثيوم أيون)';
    $Self->{Translation}->{'Loan Agreement'} = 'اتفاقية القرض';
    $Self->{Translation}->{'Located in'} = 'تقع في';
    $Self->{Translation}->{'Longitude'} = 'خط الطول';
    $Self->{Translation}->{'MIT Lizenz'} = '';
    $Self->{Translation}->{'MPL (Mozilla Public License)'} = '';
    $Self->{Translation}->{'Manufacturer'} = 'الشركة المصنعة';
    $Self->{Translation}->{'Maximum Load Capacity (W)'} = 'سعة التحميل القصوى (W)';
    $Self->{Translation}->{'Memory'} = 'الذاكرة';
    $Self->{Translation}->{'Memory Type'} = 'نوع الذاكرة';
    $Self->{Translation}->{'Micro SIM'} = '';
    $Self->{Translation}->{'Mini-Rack'} = 'رف صغير';
    $Self->{Translation}->{'Mobile Number'} = 'رقم الهاتف المحمول';
    $Self->{Translation}->{'Mobile/Embedded'} = 'موبايل/مضمّن';
    $Self->{Translation}->{'Model'} = 'الطراز';
    $Self->{Translation}->{'Model Description'} = 'وصف الطراز';
    $Self->{Translation}->{'Monitor Resolution'} = 'دقة الشاشة';
    $Self->{Translation}->{'Monitor Size'} = 'حجم الشاشة';
    $Self->{Translation}->{'Mouse'} = 'الفأر';
    $Self->{Translation}->{'Nano SIM'} = '';
    $Self->{Translation}->{'Network'} = 'الشبكة';
    $Self->{Translation}->{'Network Info'} = 'معلومات الشبكة';
    $Self->{Translation}->{'Network Information'} = 'معلومات الشبكة';
    $Self->{Translation}->{'Network Layer'} = 'طبقة الشبكة';
    $Self->{Translation}->{'Nickel-Cadmium (NiCd) Battery'} = 'بطارية النيكل والكادميوم (NiCd)';
    $Self->{Translation}->{'Nickel-Metal Hydride (NiMH) Battery'} = 'بطارية هيدريد النيكل-المعدن (NiMH)';
    $Self->{Translation}->{'Non-Disclosure Agreement (NDA)'} = 'اتفاقية عدم الإفصاح (NDA)';
    $Self->{Translation}->{'Notebook'} = 'دفتر الملاحظات';
    $Self->{Translation}->{'Number of CPUs'} = 'عدد وحدات المعالجة المركزية';
    $Self->{Translation}->{'Number of RAM modules'} = 'عدد وحدات ذاكرة الوصول العشوائي (RAM)';
    $Self->{Translation}->{'Number of graphics cards'} = 'عدد بطاقات الرسومات';
    $Self->{Translation}->{'OLED Monitor (Organic Light Emitting Diode)'} = 'شاشة OLED (الصمام الثنائي الباعث للضوء العضوي)';
    $Self->{Translation}->{'Operating costs'} = 'تكاليف التشغيل';
    $Self->{Translation}->{'Order Number'} = 'رقم الطلب';
    $Self->{Translation}->{'Other'} = 'أخرى';
    $Self->{Translation}->{'Outputs'} = 'المخرجات';
    $Self->{Translation}->{'PIN'} = 'رقم التعريف الشخصي';
    $Self->{Translation}->{'PIN 2'} = 'رقم التعريف الشخصي 2';
    $Self->{Translation}->{'PUK'} = 'PUK';
    $Self->{Translation}->{'PUK 2'} = 'PUK 2';
    $Self->{Translation}->{'Partnership Agreement'} = 'اتفاقية الشراكة';
    $Self->{Translation}->{'Perpetual licenses'} = '';
    $Self->{Translation}->{'Phone / VoIP'} = '';
    $Self->{Translation}->{'Phone Number'} = 'رقم الهاتف';
    $Self->{Translation}->{'Phone Type'} = 'نوع الهاتف';
    $Self->{Translation}->{'Physical Cores'} = 'النوى المادية';
    $Self->{Translation}->{'Power Delivery'} = 'توصيل الطاقة';
    $Self->{Translation}->{'Public Domain'} = '';
    $Self->{Translation}->{'Purchased at'} = 'تم شراؤها من';
    $Self->{Translation}->{'Rack Depth'} = 'عمق الحامل';
    $Self->{Translation}->{'Rack Units (U)'} = 'وحدات الحامل (U)';
    $Self->{Translation}->{'Room'} = 'الغرفة';
    $Self->{Translation}->{'SIM Card'} = 'بطاقة SIM';
    $Self->{Translation}->{'SSL/TLS Certificates'} = 'شهادات SSL/TLS';
    $Self->{Translation}->{'Sales Contract'} = 'عقد البيع';
    $Self->{Translation}->{'Satellite Phone'} = 'هاتف يعمل بالأقمار الصناعية';
    $Self->{Translation}->{'Sealed Lead-Acid (SLA) Battery'} = 'بطارية حمض الرصاص المختومة (SLA)';
    $Self->{Translation}->{'Seat licenses'} = '';
    $Self->{Translation}->{'Serialnumber'} = 'الرقم التسلسلي';
    $Self->{Translation}->{'Server Software'} = 'برمجيات الخادم';
    $Self->{Translation}->{'Service Agreement'} = 'اتفاقية الخدمة';
    $Self->{Translation}->{'Service Tag'} = 'بطاقة الخدمة';
    $Self->{Translation}->{'Shareware'} = '';
    $Self->{Translation}->{'Socket Type'} = 'نوع المقبس';
    $Self->{Translation}->{'Software'} = 'البرمجيات';
    $Self->{Translation}->{'Speakers'} = 'مكبرات الصوت';
    $Self->{Translation}->{'Standard SIM'} = '';
    $Self->{Translation}->{'Start IP Address'} = 'بدء عنوان IP';
    $Self->{Translation}->{'Storage'} = 'التخزين';
    $Self->{Translation}->{'Storage Partition'} = 'قسم التخزين';
    $Self->{Translation}->{'Subscription-based licenses'} = '';
    $Self->{Translation}->{'Subsidiary'} = 'شركة فرعية';
    $Self->{Translation}->{'Summary'} = 'الملخص';
    $Self->{Translation}->{'Thin Client'} = 'العميل الرقيق';
    $Self->{Translation}->{'Threads'} = 'الخيوط';
    $Self->{Translation}->{'Thunderbolt'} = 'الصاعقة';
    $Self->{Translation}->{'Total Graphics card RAM (GB)'} = 'إجمالي ذاكرة الوصول العشوائي لبطاقة الرسومات (GB)';
    $Self->{Translation}->{'Total RAM (GB)'} = 'إجمالي ذاكرة الوصول العشوائي (جيجابايت)';
    $Self->{Translation}->{'Touchscreen Monitor'} = 'شاشة تعمل باللمس';
    $Self->{Translation}->{'Tower'} = 'البرج';
    $Self->{Translation}->{'USB Hub'} = 'موزع USB';
    $Self->{Translation}->{'USB-C'} = 'USB-C';
    $Self->{Translation}->{'VGA'} = 'VGA';
    $Self->{Translation}->{'VPN'} = 'VPN';
    $Self->{Translation}->{'VR Headset'} = 'سماعة رأس الواقع الافتراضي';
    $Self->{Translation}->{'Virtual Client'} = '';
    $Self->{Translation}->{'VirtualLink'} = 'فيرتشواللينك';
    $Self->{Translation}->{'VoIP Phone'} = 'هاتف صوتي عبر بروتوكول الإنترنت';
    $Self->{Translation}->{'Volume licenses'} = '';
    $Self->{Translation}->{'Webcam'} = 'كاميرا الويب';


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

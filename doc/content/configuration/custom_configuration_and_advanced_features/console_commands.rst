Console Commands
^^^^^^^^^^^^^^^^
bin/otobo.Console.pl
* Admin::ITSM::Configitem::ClassExport     - Export dynamic field classes and their respective dynamic fields.
* Admin::ITSM::Configitem::ClassImport     - Import dynamic field classes and their respective dynamic fields.
* Admin::ITSM::Configitem::Delete          - Delete config items (all, by class (and deployment state) or by number).
* Admin::ITSM::Configitem::DumpGraph       - Dump the graph of config items as SVG to the file OTOBO_ITSM_Config_Items.svg.
* Admin::ITSM::Configitem::ListDuplicates  - List ConfigItems which have a non-unique name.
* Admin::ITSM::Configitem::UpgradeTo11     - Upgrade the complete CMDB from OTOBO 10 to OTOBO 11. All config item definitions will be changed, for each config item attribute a dynamic field will be prepared and the data will be migrated.
* Maint::ITSM::Configitem::RebuildLinkTable - Rebuild the database table configitem_link from the dynamic fields of the type Reference. Only the fields linking config items are

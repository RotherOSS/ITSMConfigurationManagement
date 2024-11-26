Command-Line Operations
^^^^^^^^^^^^^^^^^^^^^^^

The following commands can be executed using `bin/otobo.Console.pl`:

- **Admin::ITSM::Configitem::ClassExport**  
  Export dynamic field classes and their respective dynamic fields.

- **Admin::ITSM::Configitem::ClassImport**  
  Import dynamic field classes and their respective dynamic fields.

- **Admin::ITSM::Configitem::Delete**  
  Delete Configuration Items (CIs) either completely, by class, or by deployment state and number.

- **Admin::ITSM::Configitem::DumpGraph**  
  Export the graph of Configuration Items as an SVG file named `OTOBO_ITSM_Config_Items.svg`.

- **Admin::ITSM::Configitem::ListDuplicates**  
  List Configuration Items with non-unique names.

- **Admin::ITSM::Configitem::UpgradeTo11**  
  Upgrade the complete Configuration Management Database (CMDB) from OTOBO 10 to OTOBO 11.  
  This includes changing all Configuration Item definitions, preparing dynamic fields for each attribute, and migrating the data.

- **Maint::ITSM::Configitem::RebuildLinkTable**  
  Rebuild the database table `configitem_link` based on dynamic fields of type Reference.  
  Only fields linking Configuration Items are affected.
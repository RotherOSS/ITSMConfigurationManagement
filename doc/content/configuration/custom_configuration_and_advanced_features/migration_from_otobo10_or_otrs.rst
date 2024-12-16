Migration from OTOBO 10 / OTRS
------------------------------

**bin/otobo.Console.pl Admin::ITSM::Configitem::UpgradeTo11**

This command upgrades the entire Configuration Management Database (CMDB) from OTOBO 10 to OTOBO 11. During the process, all Configuration Item definitions will be updated, a dynamic field will be created for each Configuration Item attribute, and the data will be migrated.

The migration is performed in several steps to allow for customization. However, you can bypass this behavior by using the ``--use-defaults`` flag, which is only recommended for test systems.

If you plan to use attributes globally (i.e., shared across multiple Configuration Item classes), you can use the ``--no-namespace`` flag. This prevents creating a separate dynamic field for each class, which is particularly useful for attributes like "Owner" or "Customer" that aren't tied to a specific class.
You can also make more detailed customizations during the migration if needed. Customization options are available after the first and second steps of the process:

1. In the first step, all existing classes are evaluated, and attribute maps are generated to match the previous attributes with the new Dynamic Fields that will be created. These maps are then saved to the working directory. 
You can review the map for each class and freely modify the Dynamic Field names, including their namespaces (the part before the “-”), as long as you follow standard Dynamic Field naming rules, such as maintaining uniqueness (shared across object types like ticket Dynamic Fields). This also allows you to make Dynamic Fields common across multiple classes, if desired.

2. The definitions are prepared during this step, including both the class definitions and the Dynamic Field definitions. By default, each Configuration Item (CI) class will have just one page and one section containing all Dynamic Fields in a long list.
On a production system where you plan to actively use the migrated data, it's recommended to spend some time organizing the Dynamic Fields into different sections, or even multiple pages, to achieve a cleaner and more user-friendly layout. You might find it helpful to review the ready-to-use classes for inspiration.
Since all legacy versions of the classes are being migrated—and older versions can vary significantly—a large number of files may be generated. You’ll need to decide whether to focus on improving only the latest definition for each class or to refine all versions.
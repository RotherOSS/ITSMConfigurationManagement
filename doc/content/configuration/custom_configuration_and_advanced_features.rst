Custom Configuration and Advanced Features
==========================================
.. This should contain more in depth information if applicable. Might be about more complex configuration or use cases. 

Classes and Roles in the General Catalog
----------------------------------------


Config Item Definitions
-----------------------


General Structure
^^^^^^^^^^^^^^^^^
Example class "Domain":

.. code-block:: yaml

   Pages:
   # The individual tabs in AgentITSMConfigItemZoom are called Pages.
   # The fields to be displayed there are defined in the roles
   # listed on the left under "Roles".
      -  Name: Summary
         Layout:
            Columns: 2
            ColumnWidth: 1fr 1fr
         Interfaces:
            -  Agent
         Content:
            -  Section: General Fields::Domain Information
               RowStart: 1
               ColumnStart: 1
            -  Section: CMDB Backlinks::Backlinks
               RowStart: 2
               ColumnStart: 1
            -  Section: CMDB Description::Description
               RowStart: 1
               RowSpan: 2
               ColumnStart: 2
      -  Name: Accounting
         Layout:
            Columns: 2
            ColumnWidth: 1fr 1fr
         Interfaces:
            -  Agent
         Content:
            -  Section: CMDB Accounting::Accounting
               RowStart: 1
               ColumnStart: 1
   Sections:
      Accounting:
         Content:
            -  Header: Accounting
            -  DF: ITSMAccounting-InventoryNumber
            -  Grid:
                  Columns: 3
                  ColumnWidth: 1fr 1fr 1fr
                  Rows:
                     - 
                        - DF: ITSMAccounting-DateOfInvoice
                        - DF: ITSMAccounting-OrderDate
                        - DF: ITSMAccounting-WarrantyDate
                     - 
                        - DF: ITSMAccounting-CostUnit
                        - DF: ITSMAccounting-InvestmentCosts
                        - DF: ITSMAccounting-OperatingCosts
                     - 
                        - DF: ITSMAccounting-OrderNumber
                        - DF: ITSMAccounting-InvoiceNumber
                        - DF: ITSMAccounting-ReferenceToAccount
   Roles: 
      # Roles are used to define the Sections and their individual fields.
      # Of course, sections can also be defined directly here in the class definitions. 
      # We have simply moved them to "Roles" for the sake of clarity.

      # For each class with class-specific fields, there is a "General Fields"
      # definition referring to a role with the name "ITSM GF class name". 
      # This is where the fields of the respective class can be customised.
      General Fields:
         Name: ITSM Domain Information

.. _internal-link-example:

Setting Reference
^^^^^^^^^^^^^^^^^
**Pages**
   * *Name* (required) - The name of the page
   * *Layout* (required) - The layout of the grid on this page

      * *Columns* - number of columns
         e.g. `Columns: 3` will display 3 columns
      * *ColumnWidth* - basic css defining the column widths

   * *Interfaces* (optional) - An array containing the interfaces on which this page is available (default: [Agent])
   * *Groups* (optional) - If defined, an array containing groups which a user has to be member of, to be able to view this page
   * *Content* (required) - The content, i.e. an array of sections and their position on this page

      * *Section* (required) - The section name
      * *RowStart* (optional) - The starting row in the page grid of this section
      * *RowSpan* (optional) - The number of rows this section should span
      * *ColumnStart* (optional) - The starting column in the page grid of this section
      * *ColumnSpan* (optional) - The number of columns this section should span

**Sections**
The *Sections* section of the yaml contains a hash of the *Sections* which can be referenced in the *Pages*. Under each of those sections the following keys are valid:
* *Type* (optional) - Defines the type of the section. Depending on the type other attributes might be available or not. Currently available are:
   
   * DynamicFields (default) - A standard section containing dynamic fields
   * Description - A Richtext description possibly containing images etc., which can be defined on the CI edit masks
   * ConfigItemLinks - Show ConfigItems linked via dynamic fields (not used for edit masks)
   * ReferencedSection - Show a section of a CI referenced in a reference dynamic field (not used for edit masks)

**Type: DynamicFields**
An additional key *Content* is mandatory here. The *Content* is essentially the same as in ticket masks. Additionally a header for the section can be provided.
* *Header* (optional) - A header for this section
* *DF* - A dynamic field (the name)
   
   * *Mandatory* (optional) - 1 if in edit masks the field should be mandatory
   * *Readonly* (optional) - 1 if in edit masks the field should be readonly (only for basic field types)
   * *Label* (optional) - Override the label of the field on edit masks

* *Grid* - A multi column section of dynamic fields
   
   * *Columns* - Number of columns
   * *ColumnWidth* (optional) - Widths of the colums (e.g. "1fr 40px 2fr"; "%" cannot be used)
   * *Rows* - The dynamic field matrix (i.e. an array of arrays [[DF: DF11,DF: DF12, DF: DF13], [DF: DF21, DF: DF22, DF: DF23], ...])

.. putting the DF options (columnstart, columnspan) into another sublist creates "too deep nesting" error for pdflatex

Each row mus look as follows:

\- (The indicator for a each line in the grid as array)
   * *DF* - A dynamic field (the name - see above)
   
      * *ColumnStart*
      * *ColumnSpan*

Example for a dynamic field section (the Type is implicit, if none is given):

.. code-block:: yaml
   
   Sections:
      Info:
         Content:
            - DF: Computer-OS
            - DF: Owner
            Mandatory: 1
            Label: In front of the monitor
            - Grid:
               Columns: 2
               ColumnWidth: 1fr 1fr
               Rows:
                  # The first row of the grid
                  -
                     - DF: DateBought
                        Readonly: 1
                     - DF: DateWarranty
                  # The second row of the grid
                  -
                     - DF: Computer-Application
                     - DF: Computer-LicenseKey

**Type: Description**
No further settings are available.

**Type: ConfigItemLinks**
Lists linked config items.
* *Header* (optional) - A header for this section
* *LinkedAs* (optional) - Source (default), Target, Both
* *LinkTypes* (optional) - An array containing link types

**Type: ReferencedSection**
* *ReferenceField* (required) - The reference field of this config item, containing the referenced config item
* *SectionName* (required) - The name of the section of the referenced config item which should be shown
* *FieldListPre* (optional) - only valid if the referenced section is of type DynamicField (or ReferencedSection, referencing a DynamicField section): Dynamic fields of this Config Item to be rendered in front of the dynamic fields of the referenced section
* *FieldListPost* (optional) - see above, but after the referenced dynamic field section

**Type: Module**
This is not yet implemented
* *Module* (required) - A custom module returning custom HTML to be rendered in this section

Config Item Versioning and History
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


Dynamic Fields specifics
^^^^^^^^^^^^^^^^^^^^^^^^
Fields for CI classes are defined as Dynamic Fields with a new Object Type ITSM ConfigItem. To use fields, you have to define them as a Dynamic Fields for the CI Object Type and then name them in your CI Class Definition.

The following Dynamic Fields might be specifically interesting for your CMDB.
* Reference

   * Agent

      * With this field you can refer to an Agent in OTOBO.
      * This might be valuable to define the responsible of a ConfigItem, e.g. the IT Administrator who is also an Agent.

   * ConfigItem

      * With this field you can refer to another ConfigItem in OTOBO.
      * This might be valuable to link multiple ConfigItems together.
      * This might be valuable to define a hirarchy structure, e.g. Country <-> Subsidiary <-> Building <-> Room>

   * ConfigItemVersion

      * With this field you can refer to a specific Version of another ConfigItem in OTOBO.

   * Customer

      * With this field you can refer to another Customer in OTOBO.
      * This might be valuable to define the Company or Department as connected to the ConfigItem.
      * With this, you are able to see the ConfigItem in the Widget of the Customer Information Center.

   * Customer User

      * With this field you can refer to another Customer User in OTOBO.
      * This might be valuable to define the owner of a ConfigItem, e.g. if it is an internal Customer User (employee).
      * With this, you are able to see the ConfigItem in the Widget of the Customer User Information Center.

* Dynamic Field Lens

   * The idea of this field is to have a referrenced object from which you want to see (like through the lens of a periscope?) specific values.
   * In case you have a reference to a Configuration Item (via a DF Reference ConfigItem), you can look at or change values from that referenced Config Item via the Lens field. It might make sense to use the Readonly functionality to not be able to change those values.
   * It is necessary to have referenced object.
   * The referenced DF: This setting is to define, in which Dynamic Field the referred object is mentioned. This is the Config Item, of which I want to display the value.
   * attribute DF of the referenced object: This is the (Dynamic) Field in this refered object, from which I want to see the value.
   * I can make this field read only by using the "Readonly: 1"
   * For example, you could refer to a Server ConfigItem and have a look at the IP Address and the Server Owner via the Lens fields.

* General Catalog

   * The idea is to have a Dropdown field.
   * You define the values for the General Catalog field in Admin > General Catalog.
   * As a differentiation to a Dynamic Field of type "Dropdown" is, that you don't define the values per Dynamic Field, but per General Catalog.
   * So you can use multiple General Catalog Dynamic Fields which all take the same Catalog as a value base.
   * For example, you could have a two fields with the same Dropdown values, but with a different Name/Label of the Dynamic Field. E.g. a field named "INSERT EXAMPLE HERE" and another field named "INSERT EXAMPLE HERE" in different CI Classes, both with the same values.

Config Item Links
^^^^^^^^^^^^^^^^^
Backlinks
Tree View

Import/Export
^^^^^^^^^^^^^
* CSV
* Automization possible via CronJob & bin/otobo.Console.pl Admin::ITSM::ImportExport::Import
* Alternative: Web Service?

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

Permissions and Access Restrictions
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
* ACLs

   * New Object Type "ITSM ConfigItem"
   * Match settings

      * ConfigItem
      * Frontend
      * User

   * Change settings

      * ConfigItem
      * Form

Migration from OTOBO 10 / OTRS
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
bin/otobo.Console.pl Admin::ITSM::Configitem::UpgradeTo11     - Upgrade the complete CMDB from OTOBO 10 to OTOBO 11. All config item definitions will be changed, for each config item attribute a dynamic field will be prepared and the data will be migrated.




Ready2Import Class Bundles - Wo?
* IT-Servicemanagement


Relations
^^^^^^^^^
When to use which? Which impact has which relation?
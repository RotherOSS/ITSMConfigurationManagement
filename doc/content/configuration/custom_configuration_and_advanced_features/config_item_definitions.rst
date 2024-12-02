Config Item Definitions
^^^^^^^^^^^^^^^^^^^^^^^

General Structure
"""""""""""""""""
A CI definition defines all pages which are shown on the ConfigItemZoom masks and implicitely define which attributes are part of a class (where each attribute corresponds to a dynamic field of the object type "ConfigItem" which has to exists).
Structurally the "Pages" of the definition yml contain a layout on which "Sections" containing bundled sections of information are placed, as well as some additional attributes. The Sections are defined more in detail afterwards, and e.g. contain a list of dynamic fields to be displayed. Sections can also be included as "Roles" and be defined separately in the definition of the respective role.
Example class "Domain":

.. code-block:: yaml

   Pages:
      - Name: Domain Information
        Layout:
           Columns: 2
           ColumnWidth: 1fr 1fr
        Interfaces:
           - Agent
           - Customer
        Content:
           - Section: Domain Info::Summary
             RowStart: 1
             ColumnStart: 1
           - Section: Domain Info::Backlinks
             RowStart: 2
             ColumnStart: 1
           - Section: Domain Info::Description
             RowStart: 1
             RowSpan: 2
             ColumnStart: 2
      - Name: Accounting
        Layout:
           Columns: 2
           ColumnWidth: 1fr 1fr
        Interfaces:
           - Agent
        Groups:
           - accounting
        Content:
           - Section: Accounting

   Sections:
      Accounting:
         Content:
            - Header: Accounting
            - DF: ITSMAccounting-InventoryNumber
            - Grid:
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

   # here the latest version of the role "ITSM Domain Information" is included as "Domain Info"
   # and its sections can be used on the pages above
   Roles: 
      Domain Info:
         Name: ITSM Domain Information

.. _internal-link-example:

Setting Reference
"""""""""""""""""
**Pages**

- **Name** (required): The name of the page.
- **Layout** (required): The layout of the grid on this page.

  - **Columns**: Number of columns.
    Example: ``Columns: 3`` displays three columns.
  - **ColumnWidth**: Basic CSS defining the column widths.

- **Interfaces** (optional): An array containing the interfaces on which this page is available (default: [Agent]).
- **Groups** (optional): If defined, an array containing groups a user must belong to in order to view this page.
- **Content** (required): The content, i.e., an array of sections and their positions on this page.

  - **Section** (required): The section name.
  - **RowStart** (optional): The starting row in the page grid of this section.
  - **RowSpan** (optional): The number of rows this section should span.
  - **ColumnStart** (optional): The starting column in the page grid of this section.
  - **ColumnSpan** (optional): The number of columns this section should span.

**Sections**

The **Sections** section of the YAML contains a hash of the sections referenced in the **Pages**. The following keys are valid for each section:

- **Type** (optional): Defines the type of the section. Depending on the type, other attributes may or may not be available. Available types include:

  - **DynamicFields** (default): A standard section containing dynamic fields.
  - **Description**: A rich-text description possibly containing images, which can be defined on CI edit masks.
  - **ConfigItemLinks**: Displays ConfigItems linked via dynamic fields (not used for edit masks).
  - **ReferencedSection**: Displays a section of a referenced CI in a reference dynamic field (not used for edit masks).

**Type: DynamicFields**

An additional key, **Content**, is mandatory. This works like content in ticket masks. Additionally, a header for the section can be provided.

- **Header** (optional): A header for this section.
- **DF**: A dynamic field (the name).
  - **Mandatory** (optional): Set to `1` if the field is required in edit masks.
  - **Readonly** (optional): Set to `1` if the field is read-only in edit masks (only for basic field types).
  - **Label** (optional): Overrides the label of the field in edit masks.

- **Grid**: A multi-column section of dynamic fields.
  - **Columns**: Number of columns.
  - **ColumnWidth** (optional): Column widths (e.g., "1fr 40px 2fr"; "%" is not supported).
  - **Rows**: A matrix of dynamic fields (array of arrays).

Example:

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
                  # First row
                  - 
                     - DF: DateBought
                       Readonly: 1
                     - DF: DateWarranty
                  # Second row
                  - 
                     - DF: Computer-Application
                     - DF: Computer-LicenseKey

**Type: Description**

No additional settings are available.

**Type: ConfigItemLinks**

Lists linked Config Items.

- **Header** (optional): A header for this section.
- **LinkedAs** (optional): Source (default), Target, or Both.
- **LinkTypes** (optional): An array of link types.

**Type: ReferencedSection**

- **ReferenceField** (required): The reference field containing the referenced Config Item.
- **SectionName** (required): The name of the section of the referenced Config Item to display.
- **FieldListPre** (optional): Dynamic fields of this Config Item rendered before the referenced section.
- **FieldListPost** (optional): Dynamic fields rendered after the referenced section.

**Type: Module**

This type is not yet implemented.

- **Module** (required): A custom module returning HTML to render in this section.

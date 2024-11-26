Dynamic Field Specifics
^^^^^^^^^^^^^^^^^^^^^^^^

Fields for Configuration Item (CI) classes are defined as Dynamic Fields with the new Object Type **ITSM ConfigItem**. To use these fields, you must define them as Dynamic Fields for the CI Object Type and then reference them in your CI Class Definition.

The following Dynamic Fields may be especially relevant for your Configuration Management Database (CMDB):

- **Reference**
   - **Agent**  
     This field allows you to refer to an Agent in OTOBO.  
     It can be useful for defining the person responsible for a Configuration Item (e.g., the IT administrator who is also an Agent).

   - **ConfigItem**  
     This field allows you to refer to another Configuration Item in OTOBO.  
     It can be useful for linking multiple Configuration Items together or defining a hierarchy, such as Country <-> Subsidiary <-> Building <-> Room.

   - **ConfigItemVersion**  
     This field allows you to refer to a specific version of another Configuration Item in OTOBO.

   - **Customer**  
     This field allows you to refer to a Customer in OTOBO.  
     It can be valuable for defining the company or department associated with a Configuration Item.  
     Additionally, this allows the Configuration Item to appear in the Customer Information Center widget.

   - **Customer User**  
     This field allows you to refer to a Customer User in OTOBO.  
     It can be useful for defining the owner of a Configuration Item, such as an internal Customer User (employee).  
     With this, you can also view the Configuration Item in the Customer User Information Center widget.

- **Dynamic Field Lens**  
   The **Lens** field lets you view specific values from a referenced object (like through a periscope).  
   If you have a reference to a Configuration Item (via a **DF Reference ConfigItem**), you can use the Lens field to view or change values from that referenced Configuration Item.  
   It may be useful to set this field as **Readonly** to prevent changes to these values.

   **Required settings for the Lens field**:
   - **Referenced DF**: Defines the Dynamic Field where the referenced object is mentioned. This is the Configuration Item whose values you want to display.
   - **Attribute DF of the referenced object**: This is the (Dynamic) Field within the referenced object from which you want to view the value.
   - You can make this field **Readonly** by using the **Readonly: 1** option.

   **Example**:  
   You could reference a **Server ConfigItem** and view values like the **IP Address** and **Server Owner** through the Lens fields.

- **General Catalog**  
   The **General Catalog** field is essentially a dropdown field.  
   You define the values for this field in the **Admin > General Catalog** section.  
   The difference between a General Catalog field and a regular **Dropdown** Dynamic Field is that with the General Catalog, you define the values globally, allowing them to be reused across multiple Dynamic Fields.

   For example, you could have two fields with the same dropdown values but different names or labels for the Dynamic Field. These fields might appear in different CI classes, but both would pull their options from the same General Catalog.

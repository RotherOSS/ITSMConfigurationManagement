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

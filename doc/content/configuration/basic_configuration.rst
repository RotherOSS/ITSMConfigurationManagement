Basic Configuration
===================
In this section, you will learn all necessary steps to set up a basic but usable CMDB with the most commonly used Configuration Items (CIs).

Assign Agent Permissions
------------------------
Agents who need access to CIs in the Configuration Management Database (CMDB) must be assigned to the group "itsm-configitem".

Import the Ready to Adopt ConfigItem Classes
--------------------------------------------

.. attention::

    Importing the Ready2Import classes will create a large number of dynamic fields and is not automatically reversible. If in doubt, consider trying this on a non-productive system first.

OTOBO provides the option to import class bundles that showcase some of the most commonly used Configuration Items (CIs).  
To get started, perform the following steps:

#. Open the admin view of your OTOBO Web UI.
#. Navigate to **Config Items** in the **CMDB Settings** section.
#. Locate the **Ready2Import Class Bundles** panel on the left side and select the class bundle you want to import.

   .. figure:: ../images/ready2import_class_bundles.png
      :alt: Ready2Import Class Bundles panel

#. Click the button to import the Ready2Adopt class bundles.

Assign Customer Permissions
---------------------------
Enabling customer access to CIs requires, depending on the use case, enabling a subset or all of the following system configurations:

- *CustomerFrontend::Module###CustomerITSMConfigItem*: Enabling the config item overview for the customer interface
- *CustomerFrontend::Module###CustomerITSMConfigItemSearch*: Enabling the config item search for the customer interface
- *CustomerFrontend::Module###CustomerITSMConfigItemZoom*: Enabling the config item zoom view for the customer interface

Furthermore, at least one permission condition needs to be enabled and defined for a customer. A basic example setup which enables the customer user to view all config items across all classes can be used by enabling the system configuration setting *Customer::ConfigItem::PermissionConditions###01*.

Change common settings for Config Item Classes
----------------------------------------------
Classes of CIs provide possibilites for customization. To change attributes of a CI class, perform the following steps:

#. Open the admin view of your OTOBO Web UI.
#. Navigate to **General Catalog** in the **Administration** section.
#. Locate the **Catalog Class** table in the middle and click the entry **ITSM::ConfigItem::Class**.
#. Locate the **Name** table in the middle and click the class name of the class you want to edit.

   .. figure:: ../images/general_catalog_ci_class.png.png
      :alt: General Catalog Class attributes

Among the attributes customizable are for instance the name of the class as well as the version triggers and categories.

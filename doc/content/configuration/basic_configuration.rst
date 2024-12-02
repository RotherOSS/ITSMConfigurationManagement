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
      :scale: 65%
      :alt: Ready2Import Class Bundles panel

#. Click the button to import the Ready2Adopt class bundles.

Assign Customer Permissions (Optional)
--------------------------------------
To provide customer access to CIs, enable the following system configuration settings:

- *CustomerFrontend::Module###CustomerITSMConfigItem*
- *CustomerFrontend::Module###CustomerITSMConfigItemSearch*
- *CustomerFrontend::Module###CustomerITSMConfigItemZoom*
- *Customer::ConfigItem::PermissionConditions###01*: A basic example permission condition granting customer users access to all CIs

If needed, the permission condition can be customized and expanded in the respective system configuration settings.

Change common settings for Config Item Classes (Optional)
---------------------------------------------------------
Classes of CIs provide possibilites for customization. To change attributes of a CI class, perform the following steps:

#. Open the admin view of your OTOBO Web UI.
#. Navigate to **General Catalog** in the **Administration** section.
#. Locate the **Catalog Class** table in the middle and click the entry **ITSM::ConfigItem::Class**.
#. Locate the **Name** table in the middle and click the class name of the class you want to edit.

Among the attributes customizable are for instance the permission groups providing access to CIs of the respective class as well as the categories.

Change advanced settings for Config Item Classes (Optional)
-----------------------------------------------------------
Additionally, appearance and data related to a CI class can be changed in the Admin Config Item screen:

#. Open the admin view of your OTOBO Web UI.
#. Navigate to **Config Items** in the **CMDB Settings** section.
#. Locate the **Actions** panel on the left side and select the class you want to edit.
#. Click the button **Change class definition**.

In the YAML editor on the page you can configure various thing, such as dynamic fields used as attributes for the class and the appearance of CIs belonging to the class in the zoom views.

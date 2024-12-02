Basic Configuration
===================
In this section, you will learn all necessary steps to set up a basic but usable CMDB with the most commonly used Configuration Items (CIs).

Assign Agent Permissions
------------------------
Agents who need access to CIs in the Configuration Management Database (CMDB) must be assigned to the group "itsm-configitem".

Assign Customer Permissions
---------------------------
Enabling customer access to CIs requires, depending on the use case, enabling a subset or all of the following system configurations:

- *CustomerFrontend::Module###CustomerITSMConfigItem*: Enabling the config item overview for the customer interface
- *CustomerFrontend::Module###CustomerITSMConfigItemSearch*: Enabling the config item search for the customer interface
- *CustomerFrontend::Module###CustomerITSMConfigItemZoom*: Enabling the config item zoom view for the customer interface

Furthermore, at least one permission condition needs to be enabled and defined for a customer. This is done via one of the system configuration settings *Customer::ConfigItem::PermissionConditions###01* - *[...]###05*. The structure of these settings is as follows:

Name
  [required] The name displayed in the filter row of the config item overview and search view of the customer interface

Groups
  [optional] Restrict access to this permission condition to members of certain Groups

Classes
  [required] List classes which are included in this condition to filter items by

DeploymentStates
  [optional] Filter displayed CIs by deployment state

CustomerUserDynamicField
  [required] Define the name of the dynamic field holding the customer user to which the CIs are assigned

CustomerCompanyDynamicField
  [required] Define the name of the dynamic field holding the customer company to which the CIs are assigned

DynamicFieldValues
  [optional] Filter displayed CIs by one or more dynamic field values

Import the Ready to Adopt ConfigItem Classes
--------------------------------------------

.. attention::

   Please perform the following steps on a test system first because a large number of dynamic fields will be created by importing the classes.

OTOBO provides the option to import class bundles that showcase some of the most commonly used Configuration Items (CIs).  
To get started, perform the following steps:

#. Open the admin view of your OTOBO Web UI. 
#. Navigate to **Config Items** in the **CMDB Settings** section.
#. Locate the **Ready2Import Class Bundles** panel on the left side and select the class bundle you want to import.

   .. figure:: ../images/ready2import_class_bundles.png
      :alt: Ready2Import Class Bundles panel

#. Click the button to import the Ready2Adopt class bundles.

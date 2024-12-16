.. _basic-configuration:

Basic Configuration
===================
This section provides a basic approach on how to set up an initial CMDB for productive use. It comes with a set of ready to adopt and most common Configuration Item (CIs) classes. You'll save valuable time and can start right away mapping your infrastructure and most valuable assets.

Assign Agent Permissions
------------------------
Agents who need access to CIs in the Configuration Management Database (CMDB) must be assigned to the group "itsm-configitem".

.. _import-ready2import-classes:

Import the Ready to Adopt ConfigItem Classes
--------------------------------------------

.. attention::

    Importing the Ready2Import classes will create a large number of dynamic fields and is not automatically reversible. We recommend trying this on a non-productive system first.

OTOBO provides the option to import class bundles that showcase some of the most commonly used Configuration Items (CIs).  
To get started, perform the following steps:

#. Open the admin view of your OTOBO Web UI.
#. Navigate to **Config Items** in the **CMDB Settings** section.
#. Locate the **Ready2Import Class Bundles** panel on the left side and select the class bundle you want to import.

   .. figure:: ../images/ready2import_class_bundles.png
      :scale: 65%
      :alt: Ready2Import Class Bundles panel

#. Click the button to import the Ready2Import class bundles.

Assign Customer Permissions (Optional)
--------------------------------------
To provide customer access to CIs, enable the following system configuration settings:

- :ref:`Module###CustomerITSMConfigItem`
- :ref:`Module###CustomerITSMConfigItemSearch`
- :ref:`Module###CustomerITSMConfigItemZoom`
- :ref:`PermissionConditions###01`

If needed, the permission condition can be customized and expanded as described in :ref:`acl-section-label`.

Change Common Settings for Config Item Classes (Optional)
---------------------------------------------------------
CI classes offer a ton of flexibility when it comes to tailoring them to your needs. Here's what you need to do to change the general attributes of a CI class:

#. Open the admin view of your OTOBO Web UI.
#. Navigate to **General Catalog** in the **Administration** section.
#. Locate the **Catalog Class** table in the middle, then click on the **ITSM::ConfigItem::Class** entry.
#. Find the **Name** table right in the middle, then click on the class name of the specific class you're looking to modify.

You can customize attributes like permission groups that control who gets access to CIs in a particular class, as well as categories.
A more detailed description is provided in :ref:`general-catalog-classes`.

Change Advanced Settings for Config Item Classes (Optional)
-----------------------------------------------------------
You can also tweak the look and feel of a CI class, as well as its associated data, right from the Admin Config Item screen.

#. Open the admin view of your OTOBO Web UI.
#. Navigate to **Config Items** in the **CMDB Settings** section.
#. Find the **Actions** panel on the left side and select the class you want to edit.
#. Click the button **Change class definition**.

In the `YAML <https://en.wikipedia.org/wiki/YAML>`_ editor on the page you can configure various things, such as Dynamic Fields used as attributes for the Class and the appearance of CIs belonging to the class in the zoom views.
This is covered more in-depth in :ref:`config-item-definitions`.

Customize Attributes Shown in Config Item Overview (Optional)
-------------------------------------------------------------

For configuring the attributes available and visible in the Config Item overviews, the following system configuration settings can be used:

- :ref:`AgentITSMConfigItem###ClassColumnsAvailable`
- :ref:`AgentITSMConfigItem###ClassColumnsDefault`
- :ref:`CustomerITSMConfigItem###ClassColumnsAvailable`
- :ref:`CustomerITSMConfigItem###ClassColumnsDefault`
.. _versioning_and_history:

Config Item Versioning and History
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Config Items (CIs) have a general history listing all changes made over time in list form. This is the standard reference to find when and who made which changes to a CI.
Additionally snapshots of CIs can be stored as (historic) CI versions, which can be selected and viewed. This feature is automatically enabled, if Version Triggers are set in the CI classes in the general catalog.

The following features and settings have important interactions with CI versions:

 - Reference dynamic fields can statically link to a CI version instead of dynamically to the latest version of a CI.
 - Version view for the customers can be enabled or disabled via the SysConfig in ITSMConfigItem::Frontend::CustomerITSMConfigItemZoom
 - To ensure audit-proof documentation, you'll need to disable the option to delete config items.
 .. - TODO: please complete

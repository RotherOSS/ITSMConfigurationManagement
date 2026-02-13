CMDB public interface
^^^^^^^^^^^^^^^^^^^^^

A public interface with the ability to view defined CMDB configuration items is provided. Searching for items and zooming into item details is also possible. Access is limited to read-only mode, meaning that insertions, updates, or deletions are not permitted. Item version details are not available by default.

The system configuration options available for the public interface are analogous to those in the Customer interface.

To fully enable this functionality, the following modules must be activated:

* *PublicFrontend::Module###PublicITSMConfigItem*
* *PublicFrontend::Module###PublicITSMConfigItemZoom*
* *PublicFrontend::Module###PublicITSMConfigItemSearch*
* *PublicFrontend::Module###PublicITSMConfigItemAttachment*

For a configuration item to be visible in the public interface:

1. It must include *Public* in its list of interfaces in the class definition.
2. At least one of the system configuration settings *Public::ConfigItem::PermissionConditions* must be enabled and include the class of that configuration item in its list of authorized classes.

By default, item version details are not traceable. However, this feature can be enabled by activating the system configurations *ITSMConfigItem::Frontend::PublicITSMConfigItemZoom###VersionsEnabled* and *ITSMConfigItem::Frontend::PublicITSMConfigItemZoom###VersionsSelectable*.

All other system configuration options available for the public interface serve the same analogous purposes as their equivalents in the Customer interface.

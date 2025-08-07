Customer Permission Conditions and Permission Condition Columns
---------------------------------------------------------------

Permission Conditions
^^^^^^^^^^^^^^^^^^^^^

The CMDB provides five system configuration settings for permission conditions, namely 'Customer::ConfigItem::PermissionConditions###01' to '###05'. Each of these settings allows to define a set of rules and restrictions to display config items to a customer user in the customer interface.

Permission Condition Columns
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Based on the permission condition settings, the permission condition columns settings replace the previous mechanism to configure columns visible in the config item overview of the customer interface.

Using the system configuration settings 'Customer::ConfgItem::PermissionConditionColumns###01' to '###05', it can be defined which columns are visible to the customer. Note that each numeric index corresponds to the permission condition setting with the same index, e.g. columns defined in 'Customer::ConfgItem::PermissionConditionColumns###01' are applied when the permission condition 'Customer::ConfigItem::PermissionConditions###01' is viewed.

Additionally, the setting 'Customer::ConfigItem::PermissionConditionColumns###Default' exists. It provides a fallback and is used when the corresponding permission condition columns setting for a permission condition is not enabled.

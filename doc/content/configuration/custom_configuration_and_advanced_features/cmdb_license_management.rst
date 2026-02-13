CMDB License Management
^^^^^^^^^^^^^^^^^^

This package includes a license management feature that allows to control and track the number of licenses available in stock. For a licensable configuration item (e.g., software), given the total number of purchased licenses, it is possible to keep track of how many licenses are still available and automatically decrease this number whenever another configuration item (e.g., a server) consumes one of those licenses. This ensures continuous visibility over license usage and helps prevent over-allocation. Additionally, the functionality allows the definition of a minimum available licenses threshold, so that when the number of available licenses falls below this level, a notification ticket is automatically issued.

To use this functionality, one or more license counting profiles must be configured via the system configuration setting ITSMConfigItem::LicenseCount###xx, where xx is an integer value. Different licenses can share a common profile. A predefined default profile ITSMConfigItem::LicenseCount###01 is provided, allowing the feature to be used immediately without additional system configuration.

The system configuration settings required for each license counting profile are listed below.

* **TotalLicensesDF**
  The name of the dynamic field that represents the total number of licenses acquired. When the value of this dynamic field is changed in the config item, the number of available licenses is automatically recalculated.

* **AvailableLicensesDF**
  The name of the dynamic field that indicates the number of licenses currently available for use (read-only field). This value is automatically computed as the total number of licenses minus the number of licenses currently in use.

* **MinimumLicenses**
  If a threshold is defined in this field, a notification ticket will automatically be created whenever the number of available licenses falls below the specified value.

* **LicenseReferenceDF**
  The name of the field on the licensed configuration item that stores the reference to the license. This field must be properly configured in the dynamic field settings in order to create a link between the configuration item and the referenced configuration item.

* **ValidDeplStates**
  Defines the list of deployment states in which a license is considered valid. Only configuration items in one of these states will count as a used license. An empty list means that all deployment states are considered valid.

* **Ticket->DynamicField**
  The dynamic field used in a ticket to mark it as issued by the minimum licenses alert functionality. For a given license that triggered the creation of a notification ticket, no additional alert ticket of the same type will be created while this field remains set. A new alert ticket will only be generated once the existing ticket is closed or the dynamic field is manually unchecked by a user.

* **Ticket->Text**
  The text body used when creating notification tickets. The following tags can be used and will be automatically substituted with the corresponding values:

  * `<OTOBO_CONFIGITEM_NAME>` – Configuration item name
  * `<OTOBO_CONFIGITEM_NUMBER>` – Configuration item number
  * `<OTOBO_CONFIGITEM_LICENSES_AVAIL>` – Number of available licenses
  * `<OTOBO_CONFIGITEM_LICENSES_MIN>` – Minimum required number of available licenses

**Note:** The dynamic fields specified in *TotalLicensesDF*, *AvailableLicensesDF*, *LicenseReferenceDF*, and *Ticket->DynamicField* must previously exist in the system.



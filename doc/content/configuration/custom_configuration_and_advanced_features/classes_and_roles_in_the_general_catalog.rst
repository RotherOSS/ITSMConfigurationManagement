General Catalog classes of the CMDB
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Classes
"""""""
Define the ConfigItem (CI) classes (ITSM::ConfigItem::Class) available on the system, and their basic settings. Those include (not complete):
 - Access Group: Controls user (agent) access to this class.
 - Name Module: No functionality in the standard, allows extensions to automatically set CI names.
 - Number Module: Module used to define visible CI Numbers (in contrast to their internal IDs - compare TicketNumber and -ID)
 - Version-String Module: Versions can either be incremental (1, 2, 3,...) (default), defined by a Template Toolkit expression from the respectively current attributes of the CI, or (if left empty) be manually defined when adding/editing CIs in the frontend.
 - Version-String Expression: Currently only used in combination with the version string module "Template Toolkit"
 - Version Trigger: Defines which attribute changes trigger a creation of a new version. (See versioning chapter)
 - Categories: Which categories this classes should be listed in, in the agent CMDB list.

Categories
""""""""""
A set of categories (ITSM::ConfigItem::Class::Category) which are used to bundle classes in the agent frontend.

Roles
"""""
Roles available on the system (ITSM::ConfigItem::Role). Can be defined and used in Admin->ConfigItem to define common sets of attributes between CI classes in one place.

Deployment States
"""""""""""""""""
ITSM::ConfigItem::DeploymentState - coming soon

Incident States
"""""""""""""""
ITSM::Core::IncidentState - coming soon

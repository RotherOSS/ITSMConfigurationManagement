********
Overview
********

Summary
-------

This documentation is an overview of the functionality of the OTOBO package “ITSMConfigurationManagement”.

With this package, you can extend the functionality of OTOBO to manage assets and Configuration Items and link them to tickets, Customer Users, and more. This allows you to keep track of these items and have a unified solution for managing both your tickets and assets.

We provide a :ref:`basic-configuration` based on a selection of the most commonly used Configuration Items to get you up and running quickly. If you are interested in configuring your own Configuration Items, you should be able to do so using the :ref:`Advanced Configuration<custom-configuration-and-advanced-features>`.

What is a Configuration Management Database (CMDB) ?
----------------------------------------------------

A Configuration Management Database (CMDB) is a centralized hub that keeps track of all the resources your organization owns, including their current state, location, and setup. It's essentially a single source of truth for all IT assets, configurations, service requests, and incidents. Plus, it can also monitor ITIL processes like change management and problem management.

One of the main reasons you'd want to maintain a CMDB is to keep your infrastructure and systems in check. Having access to accurate data - think what IT assets you have, where they are, how they're set up, and how they relate to each other - is crucial for managing their lifecycle, making changes, handling incidents, and scaling your business.

The database serves as a trusted source of information and is a fundamental building block when following :ref:`ITIL practices<Further Reading>`. It gives you a complete view of all your IT configuration items (CIs), their attributes, and relationships. But here's the thing: a CMDB is more than just a massive inventory list for tracking physical assets. It also manages process, documentation, human capital, and how they all fit together with your overall IT infrastructure.

Identifying what we call Configuration Items (or CIs) is a critical step in building a CMDB. According to ITIL, a CI is basically anything that needs to be managed to deliver an IT service. That includes everything from buildings and services to software, documentation, users, and hardware. And get this - these CIs can vary wildly in terms of size and scope depending on how they're configured, used, or related to each other internally and externally.

The Relationship Between Asset Management and the Configuration Management Database (CMDB)
------------------------------------------------------------------------------------------

Asset Management and the Configuration Management Database (CMDB) are two closely related disciplines in IT management, each with its own focus. Asset Management centers on the entire lifecycle of IT resources, including procurement, deployment, maintenance, and decommissioning. Meanwhile, a CMDB focuses on configuration data and the relationships between components within the IT infrastructure.

The OTOBO CMDB serves as a central repository for tracking configuration items (CIs) and their interdependencies, providing critical context for operations and troubleshooting. For example, it helps you understand how systems are connected and the impact that changes to one component might have on others. On the other hand, Asset Management takes a financial and operational perspective, monitoring costs, ownership, and the utilization of resources.

There is some overlap between the two, as both systems often manage information about the same IT assets, such as servers or applications. By integrating these systems, you gain a comprehensive view of your IT environment: the OTOBO CMDB provides technical insights and relationship mapping, while Asset Management optimizes cost efficiency and resource usage. Together, they enable more effective IT asset management, cost reduction, and risk minimization through improved transparency.

Common Usecases and Main Benefits
---------------------------------

**Incident Management and Troubleshooting** - In the event of an IT outage, technicians can quickly analyze the affected configuration items (CIs) and their dependencies. A CMDB helps pinpoint the root cause of the issue and assess potential impacts on other systems, significantly accelerating the resolution process.

**Change Management** - When making changes to IT infrastructure, such as system upgrades or patches, the CMDB enables risk-aware planning. It highlights which systems might be affected by the change, ensuring that potential disruptions are identified and mitigated in advance.

**Asset Management and IT Compliance** - A CMDB facilitates accurate tracking of IT assets, including hardware, software, licenses, warranties, and ownership. This helps organizations stay compliant with regulatory requirements while maintaining better control over IT costs and asset lifecycles. A CMDB with up-to-date data and a clear history of configuration items (CIs) significantly reduces the effort required for future audits.

**Capacity and Resource Planning** - The CMDB provides visibility into infrastructure resources and their current usage. This allows IT teams to optimize resource allocation and plan for future needs more effectively, avoiding over- or underutilization.

**Documentation and Knowledge Management** - Serving as a centralized knowledge base, a CMDB documents all configurations, systems, and their interdependencies. This is particularly valuable when onboarding new team members or planning IT projects, as it ensures comprehensive understanding and better decision-making.

**Proactive Risk Analysis** - By offering transparency into system dependencies, the CMDB helps identify potential vulnerabilities and risks before they escalate. IT teams can proactively address weaknesses, improving overall infrastructure resilience.

Further Reading
---------------

If you are unfamiliar with the concept of a Configuration Management Database, the `article on Wikipedia <https://en.wikipedia.org/wiki/Configuration_management_database>`_ can provide introductory information.

More information about IT Infrastructure Library (ITIL) Practices can be found `here <https://en.wikipedia.org/wiki/ITIL>`_.
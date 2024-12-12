********
Overview
********

Summary
-------

This documentation is an overview of the functionality of the OTOBO package “ITSMConfigurationManagement”.

With this package, you can extend the functionality of OTOBO to manage assets and Configuration Items and link them to tickets, Customer Users, and more. This allows you to keep track of these items and have a unified solution for managing both your tickets and assets.

We provide a Basic Configuration based on a selection of the most commonly used Configuration Items to get you up and running quickly. If you are interested in configuring your own Configuration Items, you should be able to do so using the Advanced Configuration.

Introduction
------------

A Configuration Management Database (CMDB) is a centralized hub that keeps track of all the resources your organization owns, including their current state, location, and setup. It's essentially a single source of truth for all IT assets, configurations, service requests, and incidents. Plus, it can also monitor ITIL processes like change management and problem management.

One of the main reasons you'd want to maintain a CMDB is to keep your infrastructure and systems in check. Having access to accurate data - think what IT assets you have, where they are, how they're set up, and how they relate to each other - is crucial for managing their lifecycle, making changes, handling incidents, and scaling your business.

The database serves as a trusted source of information and is a fundamental building block when following :ref:`ITIL practices<Further Reading>`. It gives you a complete view of all your IT configuration items (CIs), their attributes, and relationships. But here's the thing: a CMDB is more than just a massive inventory list for tracking physical assets. It also manages process, documentation, human capital, and how they all fit together with your overall IT infrastructure.

Identifying what we call Configuration Items (or CIs) is a critical step in building a CMDB. According to ITIL, a CI is basically anything that needs to be managed to deliver an IT service. That includes everything from buildings and services to software, documentation, users, and hardware. And get this - these CIs can vary wildly in terms of size and scope depending on how they're configured, used, or related to each other internally and externally.



Common Usecases
---------------

- The lifecycle of assets and Configuration Items — such as computers, software, or network devices — can be tracked within OTOBO’s Configuration Management Database (CMDB).
- When a support agent receives an incident ticket, the CMDB enables them to view relevant Configuration Items directly associated with the affected systems or users. They can quickly check for recent changes, dependencies, and known issues.
- When planning a system change, the CMDB integration helps teams analyze potential impacts by displaying dependencies between systems, applications, and infrastructure components.
- For recurring or complex issues, support teams can leverage the CMDB to view historical data and relationships between affected Configuration Items, aiding in identifying root causes.
- For organizations with regulatory or compliance requirements, the CMDB serves as a single source of truth for asset configurations and changes.

Further Reading
---------------

If you are unfamiliar with the concept of a Configuration Management Database, the `article on Wikipedia <https://en.wikipedia.org/wiki/Configuration_management_database>`_ can provide introductory information.

More information about IT Infrastructure Library (ITIL) Practices can be found `here <https://en.wikipedia.org/wiki/ITIL>`_.
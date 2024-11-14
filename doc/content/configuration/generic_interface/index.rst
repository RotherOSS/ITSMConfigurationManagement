Configuration: Web Services
==================================================
The ITSMConfigurationManagement package also includes extensions to the existing web service possibilites. For this section, it is assumed that the contents explained in the basic webservice documentation, available at `OTOBO 11 Administration Manual: Webservices <https://doc.otobo.de/manual/admin/11.0/en/content/administration-area/processes-automation/web-services.html are known>`_, are known.

Operations
----------
Most of the actions available via GUI are implemented as operations, such as searching, creating, editing and fetching config item data.

ConfigItemGet
^^^^^^^^^^^^^
With this operation, it is possible to fetch config item data from an OTOBO system. A simple example web service definition could look as follows:

.. code-block:: yaml
    :linenos:

    ---
    Debugger:
      DebugThreshold: debug
      TestMode: '0'
    Description: ''
    FrameworkVersion: 11.0.x
    Provider:
      Operation:
        ConfigItemGet:
          Description: Get Config Item data.
          IncludeTicketData: '0'
          MappingInbound:
            Type: Simple
          MappingOutbound:
            Type: Simple
          Type: ConfigItem::ConfigItemGet
      Transport:
        Config:
          AdditionalHeaders: ~
          KeepAlive: ''
          MaxLength: '1000000'
          RouteOperationMapping:
            ConfigItemGet:
              Route: /ConfigItemGet/:ConfigItemID
        Type: HTTP::REST
    RemoteSystem: ''

Based on this definition, a request may look like this:

.. code-block:: bash

    curl -X POST --header "Content-Type: application/json"
    --data '{
        "UserLogin": "AgentUser",
        "Password": "Password",
        "Attachments": 1
    }'
    https://YOURSERVER/otobo/nph-genericinterface.pl/Webservice/<WEBSERVICE_NAME>/ConfigItemGet/<ConfigItemID>

Possible parameters to pass are:

UserLogin
    either UserLogin and Password or SessionID are required

Password
    Passwords are passed in plaintext

SessionID
    SessionID may be retrieved by using a SessionCreate web service operation

ConfigItemID
    required, could be comma separated IDs or an Array

    .. note::

        In the above curl example, the ConfigItemID is appended to the URL string. This is possible because the example web service definition contains a route mapping which allows this (`Route: /ConfigItemGet/:ConfigItemID`).

Attachments
    optional, 1 as default. If it's set with the value 1, attachments for articles will be included on ConfigItem data

Resulting data may be returned as follows:

.. code-block:: json

    {
      "ConfigItem": [
        {
          "Attachment": "",
          "ChangeBy": 2,
          "ChangeTime": "2024-11-14 09:06:47",
          "Class": "Building",
          "ConfigItemID": 2,
          "CreateBy": 2,
          "CreateTime": "2024-11-14 09:06:47",
          "CurDeplState": "Production",
          "CurDeplStateType": "productive",
          "CurInciState": "Operational",
          "CurInciStateType": "operational",
          "DeplState": "Production",
          "DeplStateType": "productive",
          "Description": "[Description]",
          "DynamicField_Location-ReferenceToSubsidiary": [
            1
          ],
          "InciState": "Operational",
          "InciStateType": "operational",
          "LastVersionID": 2,
          "Name": "Building 01",
          "Number": "1042000001",
          "VersionID": 2,
          "VersionString": "1"
        }
      ]
    }

ConfigItemSearch
^^^^^^^^^^^^^^^^
Search for one or more config items.

 .. code-block:: yaml

    ---
    Debugger:
      DebugThreshold: debug
      TestMode: '0'
    Description: ''
    FrameworkVersion: 11.0.x
    Provider:
      Operation:
        ConfigItemSearch:
          Description: Search for Config Items.
          IncludeTicketData: '0'
          MappingInbound:
            Type: Simple
          MappingOutbound:
            Type: Simple
          Type: ConfigItem::ConfigItemSearch
      Transport:
        Config:
          AdditionalHeaders: ~
          KeepAlive: ''
          MaxLength: '1000000'
          RouteOperationMapping:
            ConfigItemSearch:
              Route: /ConfigItemSearch/
        Type: HTTP::REST
    RemoteSystem: ''

ConfigItemUpsert
^^^^^^^^^^^^^^^^
Add or update one or more config items based on the sent data.

 .. code-block:: yaml

    ---
    Debugger:
      DebugThreshold: debug
      TestMode: '0'
    Description: ''
    FrameworkVersion: 11.0.x
    Provider:
      Operation:
        ConfigItemUpsert:
          Description: Add or update one or more Config Items.
          IncludeTicketData: ~
          MappingInbound:
            Type: Simple
          MappingOutbound:
            Type: Simple
          Type: ConfigItem::ConfigItemUpsert
      Transport:
        Config:
          AdditionalHeaders: ~
          KeepAlive: ''
          MaxLength: '1000000'
          RouteOperationMapping:
            ConfigItemUpsert:
              Route: /ConfigItemUpsert/
        Type: HTTP::REST
    RemoteSystem: ''

ConfigItemDelete
^^^^^^^^^^^^^^^^
Delete a config item.

 .. code-block:: yaml

    ---
    Debugger:
      DebugThreshold: debug
      TestMode: '0'
    Description: ''
    FrameworkVersion: 11.0.x
    Provider:
      Operation:
        ConfigItemDelete:
          Description: Delete a Config Item.
          IncludeTicketData: '0'
          MappingInbound:
            Type: Simple
          MappingOutbound:
            Type: Simple
          Type: ConfigItem::ConfigItemDelete
      Transport:
        Config:
          AdditionalHeaders: ~
          KeepAlive: ''
          MaxLength: '1000000'
          RouteOperationMapping:
            ConfigItemDelete:
              Route: /ConfigItemDelete/:ConfigItemID
        Type: HTTP::REST
    RemoteSystem: ''

Invoker
-------

ConfigItemFetch
^^^^^^^^^^^^^^^
Fetch data from remote endpoint and add or update one or more config items based on that data.

 .. code-block:: yaml

    ---
    Debugger:
      DebugThreshold: debug
      TestMode: '0'
    Description: ''
    FrameworkVersion: 11.0.x
    RemoteSystem: ''
    Requester:
      Invoker:
        ConfigItemFetch:
          Description: Fetch Config Item data.
          MappingInbound:
            Type: Simple
          MappingOutbound:
            Type: Simple
          Type: ConfigItem::ConfigItemFetch
      Transport:
        Config:
          Authentication:
            AuthType: BasicAuth
            BasicAuthPassword: somepassword
            BasicAuthUser: someusername
          DefaultCommand: GET
          Host: web:5000/otobo/nph-genericinterface.pl/WebserviceID/3
          InvokerControllerMapping:
            ConfigItemFetch:
              Controller: /ConfigItemFetch/
          Timeout: '120'
        Type: HTTP::REST

.. toctree::
   :maxdepth: 2
   :caption: Contents

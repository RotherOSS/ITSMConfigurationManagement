Custom Configuration: Web Services
==================================================
This page holds examples for Web Service invoker and operations included in the ITSMConfigurationManagement package.

Operations
----------

ConfigItemGet
^^^^^^^^^^^^^
Provide the config item data for the requested config item.

 .. code-block:: yaml

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
            ConfigItemDelete:
              Route: /ConfigItemDelete/:ConfigItemID
        Type: HTTP::REST
    RemoteSystem: ''

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

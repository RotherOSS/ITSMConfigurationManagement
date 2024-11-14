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
With this operation, it is possible to search for config items based on a wide variety of search query options. A simple example web service definition could look as follows:

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

Based on this definition, a request may look like this:

.. code-block:: bash

    curl -X POST --header "Content-Type: application/json"
    --data '{
        "UserLogin": "AgentUser",
        "Password": "Password",
        "Name": "Building*"
    }'
    https://YOURSERVER/otobo/nph-genericinterface.pl/Webservice/<WEBSERVICE_NAME>/ConfigItemSearch

Possible parameters to pass are:

UserLogin
    either UserLogin and Password or SessionID are required

Password
    Passwords are passed in plaintext

SessionID
    SessionID may be retrieved by using a SessionCreate web service operation

ConfigItemID
    optional, String or array of Strings. Use ConfigItemSearch as a config item filter on a single config item or a predefined config item list

Number
	optional, String or array of Strings. SQL placeholders like `%` are possible

Name
	optional, String or array of Strings. SQL placeholders like `%` are possible

Classes
	optional, array of Strings

ClassIDs
	optional, array of Strings

DeplStates
	optional, deployment state names of config items, array of Strings

DeplStateIDs
	optional, deployment state IDs of config items, array of Strings

CurDeplStates
	optional, current deployment state names of config items, array of Strings

CurDeplStateIDs
	optional, current deployment state IDs of config items, array of Strings

InciStates
	optional, incident state names of config items, array of Strings

InciStateIDs
	optional, incident state IDs of config items, array of Strings

CurInciStates
	optional, current incident state names of config items, array of Strings

CurInciStateIDs
	optional, current incident state IDs of config items, array of Strings

Limit
	optional, maximal number of config items returned, default is 10000

CreateBy
    optional, agent user ID of agent who created the config item, array of Strings

ChangeBy
    optional, agent user ID of agent who performed the latest change to the config item, array of Strings

DynamicFields
    At least one operator must be specified. Operators will be connected with AND, values in an operator with OR. You can also pass more than one argument to an operator: `['value1', 'value2']`. Available operators are:

    .. code-block:: perl

        DynamicField_FieldNameX => {
            Empty             => 1,                       # will return dynamic fields without a value
                                                          #     set to 0 to search fields with a value present.
            Equals            => 123,
            Like              => 'value*',                # "equals" operator with wildcard support
            GreaterThan       => '2001-01-01 01:01:01',
            GreaterThanEquals => '2001-01-01 01:01:01',
            SmallerThan       => '2002-02-02 02:02:02',
            SmallerThanEquals => '2002-02-02 02:02:02',
        }

ConfigItemCreateTimeOlderMinutes
    optional, filter for config items which have been created more than ... minutes ago, number of minutes as String

ConfigItemCreateTimeNewerMinutes
    optional, filter for config items which have been created less than ... minutes ago, number of minutes as String

ConfigItemCreateTimeNewerDate
    optional, filter for config items which have been created later than the given time stamp, DateTime-String in format 'YYYY-MM-DD HH:MM:SS'

ConfigItemCreateTimeOlderDate
    optional, filter for config items which have been created before the given time stamp, DateTime-String in format 'YYYY-MM-DD HH:MM:SS'

ConfigItemLastChangeTimeOlderMinutes
    optional, filter for config items which have been updated more than ... minutes ago, number of minutes as String

ConfigItemLastChangeTimeNewerMinutes
    optional, filter for config items which have been updated less than ... minutes ago, number of minutes as String

ConfigItemLastChangeTimeNewerDate
    optional, filter for config items which have been updated later than the given time stamp, DateTime-String in format 'YYYY-MM-DD HH:MM:SS'

ConfigItemLastChangeTimeOlderDate
    optional, filter for config items which have been updated before the given time stamp, DateTime-String in format 'YYYY-MM-DD HH:MM:SS'

OrderBy
    optional, direction to order result in, possible values: 'Down', 'Up'. Also possible as array for sub sorting

SortBy
    optional, attribute to sort result by, possible values: ConfigItem, Number, Name, DeplState, InciState, CurDeplState, CurInciState, Age, Created, Changed. Also possible as array for sub sorting

Resulting data may be returned as follows:

.. code-block:: json

    {
      "ConfigItemID": [
        "2",
        "1"
      ]
    }

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

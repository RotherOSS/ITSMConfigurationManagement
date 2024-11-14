Configuration: Web Services
==================================================
The ITSMConfigurationManagement package also includes extensions to the existing web service possibilites. For this section, it is assumed that the contents explained in the basic webservice documentation, available at `OTOBO 11 Administration Manual: Webservices <https://doc.otobo.de/manual/admin/11.0/en/content/administration-area/processes-automation/web-services.html>`_, are known.

.. attention::

    Every operation and the invoker listed and described below require an agent account as well as permission to perform the respective action on the respective config item(s). Customer access to these modules is currently not implemented.

Operations
----------
Most of the actions available via GUI are implemented as operations, such as creating, editing or deleting a config item as well as searching and fetching config item data.

ConfigItemGet
^^^^^^^^^^^^^
With this operation, it is possible to fetch config item data from an OTOBO system. A simple example web service definition could look as follows:

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
          "Description": "Some meaningful Description",
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
        "Name": "Building*",
        "DynamicField_FieldNameA": {
            "Empty": 1
        },
        "DynamicField_FieldNameB": {
            "Equals": "SomeString"
        },
        "DynamicField_FieldNameC": {
            "GreaterThan": "1970-01-01 00:00:01",
            "SmallerThan": "1980-12-31 23:59:59"
        },
        "DynamicField_FieldNameD": {
            "GreaterThanEquals": "1970-01-01 00:00:01",
            "SmallerThanEquals": "1980-12-31 23:59:59"
        }
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

    - Empty: will return dynamic fields without a value, set to 0 to search fields with a value present
    - Equals
    - Like: 'Equals' operator with wildcard support
    - GreaterThan
    - GreaterThanEquals
    - SmallerThan
    - SmallerThanEquals

    .. caution::

        The set of operators available is restricted for some dynamic field types. For example, dynamic fields of type checkbox only support the operators 'Empty' and 'Equals'.

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
With this operation, it is possible to add or update one or more config items based on the sent data. A simple example web service definition could look as follows:

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
          Identifier41:
          - Number
          [...]
          Identifier74:
          - Number
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

Based on this definition, a request may look like this:

.. code-block:: bash

    curl -X POST --header "Content-Type: application/json"
    --data '{
        "UserLogin": "AgentUser",
        "Password": "Password",
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
              "Description": "Some meaningful Description",
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
    }'
    https://YOURSERVER/otobo/nph-genericinterface.pl/Webservice/<WEBSERVICE_NAME>/ConfigItemUpsert

.. hint::

   Note that, based on the version trigger configured per class in the admin general catalog interface, a new version may or may not be created based on the data provided via request.

Possible parameters to pass are:

UserLogin
    either UserLogin and Password or SessionID are required

Password
    Passwords are passed in plaintext

SessionID
    SessionID may be retrieved by using a SessionCreate web service operation

ConfigItem
    either a single config item data hash or an array of config item data hashes to add or update

    .. hint::

        The system determines wether to perform an insertion or update based on the identifier configured per class in the web service configuration.

Resulting data may be returned as follows:

.. code-block:: json

    {
      "ConfigItem": [
        {
          "ConfigItemID": "1",
          "Name": "Subsidiary 01"
        },
        {
          "ConfigItemID": "3",
          "Name": "Building 02"
        }
      ]
    }

ConfigItemDelete
^^^^^^^^^^^^^^^^
With this operation, it is possible to delete an existing config item. A simple example web service definition could look as follows:

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

Based on this definition, a request may look like this:

.. code-block:: bash

    curl -X POST --header "Content-Type: application/json"
    --data '{
        "UserLogin": "AgentUser",
        "Password": "Password",
    }'
    https://YOURSERVER/otobo/nph-genericinterface.pl/Webservice/<WEBSERVICE_NAME>/ConfigItemDelete/<ConfigItemID>

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

Resulting data may be returned as follows:

.. code-block:: json

    {
      "ConfigItemID": [
        "4"
      ]
    }

Invoker
-------
When using OTOBO as a requester to other systems API, the ConfigItemFetch invoker adds functionality within the ITSMConfigurationManagement package.

ConfigItemFetch
^^^^^^^^^^^^^^^
Using the ConfigItemFetch invoker, it is possible to fetch data from a remote endpoint and add or update one or more config items based on that data. A simple example web service definition could look as follows:

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
          Events:
          - Asynchronous: '1'
            Condition:
              Condition:
                '1':
                  Fields:
                    Title:
                      Match: .+
                      Type: Regexp
                  Type: and
              ConditionLinking: and
            Event: TicketQueueUpdate
          Identifier41:
          - Number
          [...]
          Identifier74:
          - Number
          MappingInbound:
            Type: Simple
          MappingOutbound:
            Type: Simple
          Type: ConfigItem::ConfigItemFetch
      Transport:
        Config:
          Authentication:
            AuthType: BasicAuth
            BasicAuthPassword: Password
            BasicAuthUser: AgentUser
          DefaultCommand: GET
          Host: https://YOURSERVER/otobo/nph-genericinterface.pl/Webservice/<WEBSERVICE_NAME>
          InvokerControllerMapping:
            ConfigItemFetch:
              Controller: /ConfigItemFetch/
          Timeout: '120'
        Type: HTTP::REST

The ConfigItemFetch invoker works slightly similar to the ConfigItemUpsert operation in terms that it adds or updates one or more config items based on the defined identifier attributes. Upon being triggered by the configured events (in the example above TicketQueueUpdate), the remote system is requested and the returned data are processed.

.. hint::

   Note that, based on the version trigger configured per class in the admin general catalog interface, a new version may or may not be created based on the data fetched via request.

It is also possible to trigger a ConfigItemFetch invoker manually via console command:

.. code-block:: bash

   bin/otobo.Console.pl Maint::WebService::TriggerConfigItemFetch <WEBSERVICE_NAME> <INVOKER_NAME>

.. toctree::
   :maxdepth: 2
   :caption: Contents

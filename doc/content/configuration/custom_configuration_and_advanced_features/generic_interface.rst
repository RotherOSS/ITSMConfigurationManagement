Configuration: Web Services
^^^^^^^^^^^^^^^^^^^^^^^^^^^
The ITSMConfigurationManagement package also extends the existing web service capabilities. Before diving into this section, make sure you're familiar with the basics of OTOBO web services. You can find an introduction in `OTOBO 11 Administration Manual: Webservices <https://doc.otobo.de/manual/admin/11.0/en/content/administration-area/processes-automation/web-services.html>`_.

.. note::

    To keep things easy to read, not all combinations of possible setups are shown here. Instead we provide some basic examples, which serve the purpose to provide a sufficient illustration of possibilites. Here are the presets we're using - and keep in mind that these can be customized to fit your needs:

    **Authentication:** BasicAuth method with username and password

    **Transport:** HTTP\:\:REST

    **Mapping Type:** Simple

.. attention::

    Every operation, as well as the invoker listed and described below, requires authentication via an agent account. The accoubt also needs to have the permissions enabled for the respective action **and** config item(s). Customer user access to these modules is currently not available.

Operations
""""""""""

**ConfigItemGet**

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
    Either UserLogin and Password or SessionID are required.

Password
    Passwords are passed in plain text.

SessionID
    The SessionID may be retrieved by using a SessionCreate web service operation.

ConfigItemID
    Mandatory. Can be comma separated IDs or an Array.

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

**ConfigItemSearch**

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
    Either UserLogin and Password or SessionID are required.

Password
    Passwords are passed in plain text.

SessionID
    The SessionID may be retrieved by using a SessionCreate web service operation.

ConfigItemID
    Optional. Can be either a String or an array of Strings. Use ConfigItemSearch as a config item filter on a single config item or a predefined config item list.

Number
	Optional. Can be either a String or an array of Strings. SQL placeholders like `%` are allowed.

Name
	Optional. Can be either a String or an array of Strings. SQL placeholders like `%` are allowed.

Classes
	Optional. Has to be an Array of Strings.

ClassIDs
	Optional. Has to be an Array of Strings.

DeplStates
	Optional. Deployment state names of config items as an Array of Strings.

DeplStateIDs
	Optional. Deployment state IDs of config items as an Array of Strings.

CurDeplStates
	Optional. Current deployment state names of config itemsas an Array of Strings.

CurDeplStateIDs
	Optional. Current deployment state IDs of config items as an Array of Strings.

InciStates
	Optional. Incident state names of config items as an Array of Strings.

InciStateIDs
	Optional. Incident state IDs of config items as an Array of Strings.

CurInciStates
	Optional. Current incident state names of config items as an Array of Strings.

CurInciStateIDs
	Optional. Current incident state IDs of config items as an Array of Strings.

Limit
	Optional. Maximum number of config items returned, default is 10000.

CreateBy
  Optional. Agent user ID of the agent who created the config item as an Array of Strings.

ChangeBy
  Optional. Agent user ID of agent who performed the latest change to the config item as an Array of Strings.

DynamicFields
    At least one operator must be specified. Operators will be connected with AND, values in an operator with OR. You can also pass more than one argument to an operator: `['value1', 'value2']`. 
    Available operators are:

    - **Empty**: will return dynamic fields without a value, set to 0 to search fields with a value present
    - **Equals**
    - **Like**: 'Equals' operator with wild card support
    - **GreaterThan**
    - **GreaterThanEquals**
    - **SmallerThan**
    - **SmallerThanEquals**

    .. caution::

        The set of operators available is restricted for some dynamic field types. For example, dynamic fields of type checkbox only support the operators 'Empty' and 'Equals'.

ConfigItemCreateTimeOlderMinutes
    Optional. Filter for config items that have been created more than ... minutes ago. Provide the number of minutes as a String.

ConfigItemCreateTimeNewerMinutes
    Optional. Filter for config items that have been created less than ... minutes ago.  Provide the number of minutes as a String.

ConfigItemCreateTimeNewerDate
    Optional. Filter for config items that have been created later than the given time stamp. Provide the time in DateTime-String using format 'YYYY-MM-DD HH:MM:SS'

ConfigItemCreateTimeOlderDate
    Optional. Filter for config items that have been created before the given time stamp. Provide the time in DateTime-String using format 'YYYY-MM-DD HH:MM:SS'

ConfigItemLastChangeTimeOlderMinutes
    Optional. Filter for config items that have been updated more than ... minutes ago. Provide the number of minutes as a String.

ConfigItemLastChangeTimeNewerMinutes
    Optional. Filter for config items that have been updated less than ... minutes ago. Provide the number of minutes as a String.

ConfigItemLastChangeTimeNewerDate
    Optional. Filter for config items that have been updated later than the given time stamp. Provide the time in DateTime-String using format 'YYYY-MM-DD HH:MM:SS'

ConfigItemLastChangeTimeOlderDate
    Optional. Filter for config items that have been updated before the given time stamp. Provide the time in DateTime-String using format 'YYYY-MM-DD HH:MM:SS'

OrderBy
    Optional. The direction to order results in. Possible values are: 'Down', 'Up'. Also possible as array for sub sorting.

SortBy
    Optional. The attribute to sort results by. Possible values are: ConfigItem, Number, Name, DeplState, InciState, CurDeplState, CurInciState, Age, Created, Changed. Also possible as array for sub sorting

Resulting data may be returned as follows:

.. code-block:: json

    {
      "ConfigItemID": [
        "2",
        "1"
      ]
    }

**ConfigItemUpsert**

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
    Either UserLogin and Password or SessionID are required.

Password
    Passwords are passed in plain text.

SessionID
    The SessionID may be retrieved by using a SessionCreate web service operation.

ConfigItem
    Either a single config item data hash or an array of config item data hashes to add or update.

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

**ConfigItemDelete**

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
    Either UserLogin and Password or SessionID are required.

Password
    Passwords are passed in plain text.

SessionID
    The SessionID may be retrieved by using a SessionCreate web service operation.

ConfigItemID
    Required. Can be comma separated IDs or an Array.

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
"""""""

**ConfigItemCreate**

Using the ConfigItemCreate invoker, it is possible to send config item data to a remote endpoint. A simple example web service definition could look as follows:

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
        ConfigItemCreate:
          Description: 'Send Config Item data to remote system.'
          Events:
          - Asynchronous: '1'
            Condition:
              Condition:
                '1':
                  Fields:
                    Number:
                      Match: .+
                      Type: Regexp
                  Type: and
              ConditionLinking: and
            Event: ConfigItemCreate
          MappingInbound:
            Type: Simple
          MappingOutbound:
            Type: Simple
          Type: ConfigItem::ConfigItemCreate
      Transport:
        Config:
          Authentication:
            AuthType: BasicAuth
            BasicAuthPassword: Password
            BasicAuthUser: AgentUser
          DefaultCommand: GET
          Host: https://YOURSERVER/otobo/nph-genericinterface.pl/Webservice/<WEBSERVICE_NAME>
          InvokerControllerMapping:
            ConfigItemCreate:
              Controller: /ConfigItemCreate/
          Timeout: '120'
        Type: HTTP::REST

Without any mapping applied, the outgoing config item data will look like the following:

.. code-block:: json

  {
    "ChangeBy": "2",
    "ChangeTime": "1970-01-01 00:00:01",
    "Class": "Client Software",
    "ClassID": "45",
    "ConfigItemID": "1",
    "CreateBy": "2",
    "CreateTime": "1970-01-01 00:00:01",
    "CurDeplState": "Production",
    "CurDeplStateID": "2",
    "CurDeplStateType": "productive",
    "CurInciState": "Operational",
    "CurInciStateID": "1",
    "CurInciStateType": "operational",
    "DefinitionID": "1",
    "DeplState": "Production",
    "DeplStateID": "2",
    "DeplStateType": "productive",
    "Description": "Some meaningful description",
    "DynamicField_ITSM-LensToLicenseCount": "2",
    "DynamicField_ITSM-LensToLicensePeriodFrom": "1970-01-01 00:00:00",
    "DynamicField_ITSM-LensToLicensePeriodUntil": "2069-12-31 00:00:00",
    "DynamicField_ITSM-LensToLicenseType": "ApacheLizenz",
    "DynamicField_ITSM-ReferenceToLicense": "Name of License",
    "InciState": "Operational",
    "InciStateID": "1",
    "InciStateType": "operational",
    "LastVersionID": "1",
    "Name": "ClientSoftware",
    "Number": "1045000002",
    "VersionID": "1",
    "VersionString": "1"
  }

.. note::

   Note that values of dynamic fields are transformed. E.g. reference fields will not be included with their value ID, but with a readable value. For reference dynamic fields of type ConfigItem, ConfigItemVersion or Ticket, this value can be configured with the attribute 'Display value'.

**ConfigItemFetch**

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

**Mapping of incoming data**

Response data structures of a remote system may vary, but an example is nonetheless helpful for understanding. Given the following data structure:

.. code-block:: json

  [
    {
        "currency": "EUR",
        "currency_symbol": "€",
        "customer_id": 1,
        "customer_ip_address": "127.0.0.1",
        "customer_note": "",
        "discount_tax": "0.00",
        "discount_total": "0.00",
        "fee_lines": [],
        "id": 200,
        "next_payment_date": "01 January 1970",
        "number": "200",
        "parent_id": 0,
        "parent_order_id": 100,
        "recurring_amount": 42,
        "refunds": [],
        "shipping_lines": [],
        "shipping_tax": "0.00",
        "shipping_total": "0.00",
        "status": "pending",
        "subscription_id": 100,
        "subscriptions_expiry_date": "01 January 1970",
        "tax_lines": [],
        "total": "0.05",
        "total_tax": "0.00",
        "transaction_id": "",
        "user_name": "AgentUser"
    },
    {
        "currency": "EUR",
        "currency_symbol": "€",
        "customer_id": 1,
        "customer_ip_address": "127.0.0.1",
        "customer_note": "",
        "discount_tax": "0.00",
        "discount_total": "0.00",
        "fee_lines": [],
        "id": 198,
        "next_payment_date": "01 January 1970",
        "number": "198",
        "parent_id": 0,
        "parent_order_id": 98,
        "recurring_amount": 42,
        "refunds": [],
        "shipping_lines": [],
        "shipping_tax": "0.00",
        "shipping_total": "0.00",
        "status": "processing",
        "subscription_id": 98,
        "subscriptions_expiry_date": "01 January 1970",
        "tax_lines": [],
        "total": "0.00",
        "total_tax": "0.00",
        "transaction_id": "",
        "user_name": "AgentUser"
    }
  ]

The data stems from a WordPress system. A ConfigItemFetch invoker receiving such data needs to also contain a mapping to select and transform it into a data structure for creating or updating a config item. The usable config item attributes are:

.. hint::

   Note that, based on the version trigger configured per class in the admin general catalog interface, a new version may or may not be created based on the data fetched via request.

The data provided by the remote system which is requested by the invoker need to be mapped to the usual config item data, which are the following:

Number
	Optional. Number of config item, will be generated if not provided.

Name
	Optional in case a name module is configured for the class. The Name of the config item.

Class
	Mandatory. The name of the class in which the config item should be created.

VersionString
    Optional if a version string module is configured for the class. The version identifier of the config item.

DeploymentState
	Mandatory. The name of the deployment state the config item is in.

IncidentState
	Mandatory. The name of the incident state the config item is in.

Description
  Optional. The description text if a description is configured for the respective class.

DynamicFields
  Optional. The data of the config item dynamic fields.

.. hint::

    The system determines wether to perform an insertion or update based on the identifier configured per class in the web service configuration.

.. attention::

   When implementing the following mapping, the presets listed at the start of the page get overwritten in the following points:

    **Mapping Type:** Simple -> XSLT

    This also implies that the above webservice config has to be adapted in this case.


Given the incoming data and the needed config item data structure, a mapping may look like this:

.. code-block:: xslt

  <?xml version="1.0" encoding="UTF-8"?>
  <xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml" indent="yes"/>

    <!-- Main template for transformation -->
    <xsl:template match="/RootElement">
      <data>
        <xsl:for-each select="data">
          <ConfigItems>

            <!-- Straight date conversion for next_payment_date -->
            <DynamicField_SUBSC-NextPaymentDate>
              <xsl:variable name="inputDate" select="next_payment_date"/>
              <xsl:variable name="day" select="format-number(substring-before($inputDate, ' '), '00')"/>
              <xsl:variable name="monthName" select="substring-before(substring-after($inputDate, ' '), ' ')"/>
              <xsl:variable name="year" select="substring-after(substring-after($inputDate, ' '), ' ')"/>

              <!-- Conversion of month name into two-digit number -->
              <xsl:variable name="month">
                <xsl:choose>
                  <xsl:when test="$monthName = 'January'">01</xsl:when>
                  <xsl:when test="$monthName = 'February'">02</xsl:when>
                  <xsl:when test="$monthName = 'March'">03</xsl:when>
                  <xsl:when test="$monthName = 'April'">04</xsl:when>
                  <xsl:when test="$monthName = 'May'">05</xsl:when>
                  <xsl:when test="$monthName = 'June'">06</xsl:when>
                  <xsl:when test="$monthName = 'July'">07</xsl:when>
                  <xsl:when test="$monthName = 'August'">08</xsl:when>
                  <xsl:when test="$monthName = 'September'">09</xsl:when>
                  <xsl:when test="$monthName = 'October'">10</xsl:when>
                  <xsl:when test="$monthName = 'November'">11</xsl:when>
                  <xsl:when test="$monthName = 'December'">12</xsl:when>
                </xsl:choose>
              </xsl:variable>

              <!-- Composing the date in format YYYY-MM-DD HH:MM:SS -->
              <xsl:value-of select="concat($year, '-', $month, '-', $day, ' 00:00:00')"/>
            </DynamicField_SUBSC-NextPaymentDate>

            <!-- Conditional printing and date conversion for subscriptions_expiry_date -->
            <xsl:variable name="expiryDate" select="subscriptions_expiry_date"/>
            <xsl:if test="normalize-space($expiryDate) != '' and $expiryDate != '---'">
              <DynamicField_SUBSC-SubscriptionsExpiryDate>

                <!-- Conversion of expiryDate in preferred format -->
                <xsl:variable name="expiryDay" select="format-number(substring-before($expiryDate, ' '), '00')"/>
                <xsl:variable name="expiryMonthName" select="substring-before(substring-after($expiryDate, ' '), ' ')"/>
                <xsl:variable name="expiryYear" select="substring-after(substring-after($expiryDate, ' '), ' ')"/>
                <xsl:variable name="expiryMonth">
                  <xsl:choose>
                      <xsl:when test="$expiryMonthName = 'January'">01</xsl:when>
                      <xsl:when test="$expiryMonthName = 'February'">02</xsl:when>
                      <xsl:when test="$expiryMonthName = 'March'">03</xsl:when>
                      <xsl:when test="$expiryMonthName = 'April'">04</xsl:when>
                      <xsl:when test="$expiryMonthName = 'May'">05</xsl:when>
                      <xsl:when test="$expiryMonthName = 'June'">06</xsl:when>
                      <xsl:when test="$expiryMonthName = 'July'">07</xsl:when>
                      <xsl:when test="$expiryMonthName = 'August'">08</xsl:when>
                      <xsl:when test="$expiryMonthName = 'September'">09</xsl:when>
                      <xsl:when test="$expiryMonthName = 'October'">10</xsl:when>
                      <xsl:when test="$expiryMonthName = 'November'">11</xsl:when>
                      <xsl:when test="$expiryMonthName = 'December'">12</xsl:when>
                  </xsl:choose>
                </xsl:variable>

                <!-- Printing the formatted date -->
                <xsl:value-of select="concat($expiryYear, '-', $expiryMonth, '-', $expiryDay, ' 00:00:00')"/>
              </DynamicField_SUBSC-SubscriptionsExpiryDate>
            </xsl:if>

            <!-- Printing other fields without conversion -->
            <Class>Subscription</Class>
            <DeploymentState>Production</DeploymentState>
            <IncidentState>Operational</IncidentState>
            <Name><xsl:value-of select="parent_order_id"/></Name>
            <DynamicField_SUBSC-OrderID><xsl:value-of select="parent_order_id"/></DynamicField_SUBSC-OrderID>
            <DynamicField_SUBSC-RecurringAmount><xsl:value-of select="recurring_amount"/></DynamicField_SUBSC-RecurringAmount>
            <DynamicField_SUBSC-SubscStatus><xsl:value-of select="status"/></DynamicField_SUBSC-SubscStatus>
            <DynamicField_SUBSC-SubscriptionID><xsl:value-of select="subscription_id"/></DynamicField_SUBSC-SubscriptionID>
            <DynamicField_SUBSC-UserName><xsl:value-of select="user_name"/></DynamicField_SUBSC-UserName>
          </ConfigItems>
        </xsl:for-each>
      </data>
    </xsl:template>
  </xsl:stylesheet>

The combination of the incoming data and the mapping above will result in the following data for config item creation or update, respectively:

.. code-block:: json

  [
    {
      "Class": "Subscription",
      "DeploymentState": "Production",
      "DynamicField_SUBSC-NextPaymentDate": "1970-01-01 00:00:00",
      "DynamicField_SUBSC-OrderID": "100",
      "DynamicField_SUBSC-RecurringAmount": "42",
      "DynamicField_SUBSC-SubscStatus": "pending",
      "DynamicField_SUBSC-SubscriptionID": "100",
      "DynamicField_SUBSC-SubscriptionsExpiryDate": "1970-01-01 00:00:00",
      "DynamicField_SUBSC-UserName": "AgentUser",
      "IncidentState": "Operational",
      "Name": "100"
    },
    {
      "Class": "Subscription",
      "DeploymentState": "Production",
      "DynamicField_SUBSC-NextPaymentDate": "1970-01-01 00:00:00",
      "DynamicField_SUBSC-OrderID": "98",
      "DynamicField_SUBSC-RecurringAmount": "42",
      "DynamicField_SUBSC-SubscStatus": "pending",
      "DynamicField_SUBSC-SubscriptionID": "98",
      "DynamicField_SUBSC-SubscriptionsExpiryDate": "1970-01-01 00:00:00",
      "DynamicField_SUBSC-UserName": "AgentUser",
      "IncidentState": "Operational",
      "Name": "100"
    }
  ]

**ConfigItemUpdate**

Using the ConfigItemUpdate invoker, it is possible to send config item data to a remote endpoint. A simple example web service definition could look as follows:

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
      ConfigItemUpdate:
        Description: 'Send Config Item data to remote system.'
        Events:
        - Asynchronous: '1'
          Condition:
            Condition:
              '1':
                Fields:
                  Number:
                    Match: .+
                    Type: Regexp
                Type: and
            ConditionLinking: and
          Event: VersionCreate
        MappingInbound:
          Type: Simple
        MappingOutbound:
          Type: Simple
        Type: ConfigItem::ConfigItemUpdate
    Transport:
      Config:
        Authentication:
          AuthType: BasicAuth
          BasicAuthPassword: Password
          BasicAuthUser: AgentUser
        DefaultCommand: GET
        Host: https://YOURSERVER/otobo/nph-genericinterface.pl/Webservice/<WEBSERVICE_NAME>
        InvokerControllerMapping:
          ConfigItemUpdate:
            Controller: /ConfigItemUpdate/
        Timeout: '120'
      Type: HTTP::REST

Without any mapping applied, the outgoing config item data will look like the following:

.. code-block:: json

  {
    "ChangeBy": "2",
    "ChangeTime": "1970-01-01 00:00:01",
    "Class": "Client Software",
    "ClassID": "45",
    "ConfigItemID": "1",
    "CreateBy": "2",
    "CreateTime": "1970-01-01 00:00:01",
    "CurDeplState": "Production",
    "CurDeplStateID": "2",
    "CurDeplStateType": "productive",
    "CurInciState": "Operational",
    "CurInciStateID": "1",
    "CurInciStateType": "operational",
    "DefinitionID": "1",
    "DeplState": "Production",
    "DeplStateID": "2",
    "DeplStateType": "productive",
    "Description": "Some meaningful description",
    "DynamicField_ITSM-LensToLicenseCount": "2",
    "DynamicField_ITSM-LensToLicensePeriodFrom": "1970-01-01 00:00:00",
    "DynamicField_ITSM-LensToLicensePeriodUntil": "2069-12-31 00:00:00",
    "DynamicField_ITSM-LensToLicenseType": "ApacheLizenz",
    "DynamicField_ITSM-ReferenceToLicense": "Name of License",
    "InciState": "Operational",
    "InciStateID": "1",
    "InciStateType": "operational",
    "LastVersionID": "1",
    "Name": "ClientSoftware",
    "Number": "1045000002",
    "VersionID": "1",
    "VersionString": "1"
  }

.. note::

  Note that values of dynamic fields are transformed. E.g. reference fields will not be included with their value ID, but with a readable value. For reference dynamic fields of type ConfigItem, ConfigItemVersion and Ticket, this value can be configured with the attribute 'Display value'.

It is also possible to trigger a ConfigItemFetch invoker manually via console command:

.. code-block:: bash

  bin/otobo.Console.pl Maint::WebService::TriggerConfigItemFetch <WEBSERVICE_NAME> <INVOKER_NAME>

.. toctree::
  :maxdepth: 2
  :caption: Contents

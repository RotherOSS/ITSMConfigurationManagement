# --
# OTOBO is a web-based ticketing system for service organisations.
# --
# Copyright (C) 2001-2020 OTRS AG, https://otrs.com/
# Copyright (C) 2019-2023 Rother OSS GmbH, https://otobo.de/
# --
# This program is free software: you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation, either version 3 of the License, or (at your option) any later version.
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <https://www.gnu.org/licenses/>.
# --

use v5.24;
use strict;
use warnings;
use utf8;

# core modules
use MIME::Base64 qw(encode_base64);

# CPAN modules
use Test2::V0;

# OTOBO modules
use Kernel::System::UnitTest::RegisterOM;    # Set up $Kernel::OM
use Kernel::GenericInterface::Debugger;
use Kernel::GenericInterface::Operation::ConfigItem::ConfigItemCreate;
use Kernel::System::VariableCheck qw(:all);

# Skip SSL certificate verification.
$Kernel::OM->ObjectParamAdd(
    'Kernel::System::UnitTest::Helper' => {
        SkipSSLVerify => 1,
    },
);
my $Helper           = $Kernel::OM->Get('Kernel::System::UnitTest::Helper');
my $ConfigObject     = $Kernel::OM->Get('Kernel::Config');
my $ConfigItemObject = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');

my $RandomID = $Helper->GetRandomID();

# Check if SSL Certificate verification is disabled.
is(
    $ENV{PERL_LWP_SSL_VERIFY_HOSTNAME},
    0,
    'Disabled SSL certiticates verification in environment',
);

my $TestCustomerUserLogin = $Helper->TestCustomerUserCreate();

# Create webservice object.
my $WebserviceObject = $Kernel::OM->Get('Kernel::System::GenericInterface::Webservice');
is(
    'Kernel::System::GenericInterface::Webservice',
    ref $WebserviceObject,
    "Create webservice object",
);

# Set webservice name.
my $WebserviceName = '-Test-' . $RandomID;

my $WebserviceID = $WebserviceObject->WebserviceAdd(
    Name   => $WebserviceName,
    Config => {
        Debugger => {
            DebugThreshold => 'debug',
        },
        Provider => {
            Transport => {
                Type => '',
            },
        },
    },
    ValidID => 1,
    UserID  => 1,
);
ok( $WebserviceID, "added web service" );

# Get remote host with some precautions for certain unit test systems.
my $Host = $Helper->GetTestHTTPHostname;

# prepare webservice config
my $RemoteSystem =
    $ConfigObject->Get('HttpType')
    . '://'
    . $Host
    . '/'
    . $ConfigObject->Get('ScriptAlias')
    . '/nph-genericinterface.pl/WebserviceID/'
    . $WebserviceID;

my $WebserviceConfig = {
    Description =>
        'Test for ConfigItem Connector using SOAP transport backend.',
    Debugger => {
        DebugThreshold => 'debug',
        TestMode       => 1,
    },
    Provider => {
        Transport => {
            Type   => 'HTTP::SOAP',
            Config => {
                MaxLength => 10_000_000,
                NameSpace => 'http://otobo.org/SoapTestInterface/',
                Endpoint  => $RemoteSystem,
            },
        },
        Operation => {
            ConfigItemCreate => {
                Type => 'ConfigItem::ConfigItemCreate',
            },
            SessionCreate => {
                Type => 'Session::SessionCreate',
            },
        },
    },
    Requester => {
        Transport => {
            Type   => 'HTTP::SOAP',
            Config => {
                NameSpace => 'http://otobo.org/SoapTestInterface/',
                Encoding  => 'UTF-8',
                Endpoint  => $RemoteSystem,
            },
        },
        Invoker => {
            ConfigItemCreate => {
                Type => 'Test::TestSimple',
            },
            SessionCreate => {
                Type => 'Test::TestSimple',
            },
        },
    },
};

# Update webservice with real config.
my $WebserviceUpdate = $WebserviceObject->WebserviceUpdate(
    ID      => $WebserviceID,
    Name    => $WebserviceName,
    Config  => $WebserviceConfig,
    ValidID => 1,
    UserID  => 1,
);
ok( $WebserviceUpdate, "updated web service $WebserviceID - $WebserviceName" );

# Debugger object.
my $DebuggerObject = Kernel::GenericInterface::Debugger->new(
    DebuggerConfig => {
        DebugThreshold => 'debug',
        TestMode       => 1,
    },
    WebserviceID      => $WebserviceID,
    CommunicationType => 'Provider',
);
isa_ok(
    $DebuggerObject,
    ['Kernel::GenericInterface::Debugger'],
    'DebuggerObject instanciated correctly',
);

# Get SessionID.
# Create requester object.
my $RequesterSessionObject = $Kernel::OM->Get('Kernel::GenericInterface::Requester');
isa_ok(
    $RequesterSessionObject,
    ['Kernel::GenericInterface::Requester'],
    "SessionID - Create requester object",
);

# Create a new user for current test.
my $UserLogin = $Helper->TestUserCreate(
    Groups => [ 'admin', 'users', 'itsm-configitem' ],
);
my $Password = $UserLogin;

# Start requester with our webservice.
my $RequesterSessionResult = $RequesterSessionObject->Run(
    WebserviceID => $WebserviceID,
    Invoker      => 'SessionCreate',
    Data         => {
        UserLogin => $UserLogin,
        Password  => $Password,
    },
);
ref_ok( $RequesterSessionResult, 'HASH', 'got result from SessionID' );

my $NewSessionID = $RequesterSessionResult->{Data}->{SessionID};
like( $NewSessionID, qr/\A[[:alnum:]]{32}\z/, 'sane session ID' );

# Actual tests.
my @Tests = (
    {
        Name           => 'Empty Request',
        SuccessRequest => 1,
        SuccessCreate  => 0,
        RequestData    => {},
        ExpectedData   => {
            Data => {
                Error => {
                    ErrorCode    => 'ConfigItemCreate.MissingParameter',
                    ErrorMessage => 'ConfigItemCreate: ConfigItem parameter is missing or not valid!',
                }
            },
        },
        Operation => 'ConfigItemCreate',
    },
    {
        Name           => 'Invalid ConfigItem',
        SuccessRequest => 1,
        SuccessCreate  => 0,
        RequestData    => {
            ConfigItem => 1,    # should be a hashref
        },
        ExpectedData => {
            Data => {
                Error => {
                    ErrorCode    => 'ConfigItemCreate.MissingParameter',
                    ErrorMessage => 'ConfigItemCreate: ConfigItem parameter is missing or not valid!',
                }
            },
        },
        Operation => 'ConfigItemCreate',
    },
    {
        Todo           => 'mandatory checks are not implemented yet',
        Name           => 'Missing CIXMLData',
        SuccessRequest => 1,
        SuccessCreate  => 0,
        RequestData    => {
            ConfigItem => {
                Class     => 'Computer',
                Name      => 'Test' . $RandomID,
                DeplState => 'Production',
                InciState => 'Operational',
            },
        },
        ExpectedData => {
            Data => {
                Error => {
                    ErrorCode    => 'ConfigItemCreate.MissingParameter',
                    ErrorMessage => 'ConfigItemCreate: ConfigItem->DynamicField->NIC->IPoverDHCP parameter is missing!',
                }
            },
        },
        Operation => 'ConfigItemCreate',
    },
    {
        Name           => 'Invalid CIXMLData',
        SuccessRequest => 1,
        SuccessCreate  => 0,
        RequestData    => {
            ConfigItem => {
                Class     => 'Computer',
                Name      => 'Test' . $RandomID,
                DeplState => 'Production',
                InciState => 'Operational',
                CIXMLData => 0,
            },
        },
        ExpectedData => {
            Data => {
                Error => {
                    ErrorCode    => 'ConfigItemCreate.MissingParameter',
                    ErrorMessage => 'ConfigItemCreate: ConfigItem->CIXMLData is missing or invalid!',
                }
            },
        },
        Operation => 'ConfigItemCreate',
    },
    {
        Name           => 'Missing Class',
        SuccessRequest => 1,
        SuccessCreate  => 0,
        RequestData    => {
            ConfigItem => {
                CIXMLData => {
                    Test => 1,
                },
            },
        },
        ExpectedData => {
            Data => {
                Error => {
                    ErrorCode    => 'ConfigItemCreate.MissingParameter',
                    ErrorMessage => 'ConfigItemCreate: ConfigItem->Class parameter is missing!',
                }
            },
        },
        Operation => 'ConfigItemCreate',
    },
    {
        Name           => 'Missing Name',
        SuccessRequest => 1,
        SuccessCreate  => 0,
        RequestData    => {
            ConfigItem => {
                Class     => 'Computer',
                CIXMLData => {
                    Test => 1,
                },
            },
        },
        ExpectedData => {
            Data => {
                Error => {
                    ErrorCode    => 'ConfigItemCreate.MissingParameter',
                    ErrorMessage => 'ConfigItemCreate: ConfigItem->Name parameter is missing!',
                }
            },
        },
        Operation => 'ConfigItemCreate',
    },
    {
        Name           => 'Missing DeplState',
        SuccessRequest => 1,
        SuccessCreate  => 0,
        RequestData    => {
            ConfigItem => {
                Class     => 'Computer',
                Name      => 'TestCI' . $RandomID,
                CIXMLData => {
                    Test => 1,
                },
            },
        },
        ExpectedData => {
            Data => {
                Error => {
                    ErrorCode    => 'ConfigItemCreate.MissingParameter',
                    ErrorMessage => 'ConfigItemCreate: ConfigItem->DeplState parameter is missing!',
                }
            },
        },
        Operation => 'ConfigItemCreate',
    },
    {
        Name           => 'Missing InciState',
        SuccessRequest => 1,
        SuccessCreate  => 0,
        RequestData    => {
            ConfigItem => {
                Class     => 'Computer',
                Name      => 'TestCI' . $RandomID,
                DeplState => 'Production',
                CIXMLData => {
                    Test => 1,
                },
            },
        },
        ExpectedData => {
            Data => {
                Error => {
                    ErrorCode    => 'ConfigItemCreate.MissingParameter',
                    ErrorMessage => 'ConfigItemCreate: ConfigItem->InciState parameter is missing!',
                }
            },
        },
        Operation => 'ConfigItemCreate',
    },
    {
        Name           => 'Wrong Class',
        SuccessRequest => 1,
        SuccessCreate  => 0,
        RequestData    => {
            ConfigItem => {
                Class     => 'NotExisitng' . $RandomID,
                Name      => 'TestCI' . $RandomID,
                DeplState => 'Production',
                InciState => 'Incident',
                CIXMLData => {
                    Test => 1,
                },
            },
        },
        ExpectedData => {
            Data => {
                Error => {
                    ErrorCode    => 'ConfigItemCreate.InvalidParameter',
                    ErrorMessage => 'ConfigItemCreate: ConfigItem->Class parameter is invalid!',
                }
            },
        },
        Operation => 'ConfigItemCreate',
    },
    {
        Name           => 'Wrong DeplState',
        SuccessRequest => 1,
        SuccessCreate  => 0,
        RequestData    => {
            ConfigItem => {
                Class     => 'Computer',
                Name      => 'TestCI' . $RandomID,
                DeplState => 'Production' . $RandomID,
                InciState => 'Incident',
                CIXMLData => {
                    Test => 1,
                },
            },
        },
        ExpectedData => {
            Data => {
                Error => {
                    ErrorCode    => 'ConfigItemCreate.InvalidParameter',
                    ErrorMessage => 'ConfigItemCreate: ConfigItem->DeplState parameter is invalid!',
                }
            },
        },
        Operation => 'ConfigItemCreate',
    },
    {
        Name           => 'Wrong InciState',
        SuccessRequest => 1,
        SuccessCreate  => 0,
        RequestData    => {
            ConfigItem => {
                Class     => 'Computer',
                Name      => 'TestCI' . $RandomID,
                DeplState => 'Production',
                InciState => 'Incident' . $RandomID,
                CIXMLData => {
                    Test => 1,
                },
            },
        },
        ExpectedData => {
            Data => {
                Error => {
                    ErrorCode    => 'ConfigItemCreate.InvalidParameter',
                    ErrorMessage => 'ConfigItemCreate: ConfigItem->InciState parameter is invalid!',
                }
            },
        },
        Operation => 'ConfigItemCreate',
    },
    {
        Name           => 'Missing NIC->NIC',
        SuccessRequest => 1,
        SuccessCreate  => 0,
        RequestData    => {
            ConfigItem => {
                Class     => 'Computer',
                Name      => 'TestCI' . $RandomID,
                DeplState => 'Production',
                InciState => 'Incident',
                CIXMLData => {
                    NIC => {
                        Test => 1,
                    }
                },
            },
        },
        ExpectedData => {
            Data => {
                Error => {
                    ErrorCode    => 'ConfigItemCreate.MissingParameter',
                    ErrorMessage =>
                        'ConfigItemCreate: ConfigItem->CIXMLData->NIC parameter value is required and is missing!',
                }
            },
        },
        Operation => 'ConfigItemCreate',
    },
    {
        Name           => 'Missing NIC->IpOverDHCP',
        SuccessRequest => 1,
        SuccessCreate  => 0,
        RequestData    => {
            ConfigItem => {
                Class     => 'Computer',
                Name      => 'TestCI' . $RandomID,
                DeplState => 'Production',
                InciState => 'Incident',
                CIXMLData => {
                    NIC => {
                        NIC => 'Eth0',
                    }
                },
            },
        },
        ExpectedData => {
            Data => {
                Error => {
                    ErrorCode    => 'ConfigItemCreate.MissingParameter',
                    ErrorMessage => 'ConfigItemCreate: ConfigItem->CIXMLData->NIC->IPoverDHCP parameter is missing!',
                }
            },
        },
        Operation => 'ConfigItemCreate',
    },
    {
        Name           => 'Missing NIC->NIC in array',
        SuccessRequest => 1,
        SuccessCreate  => 0,
        RequestData    => {
            ConfigItem => {
                Class     => 'Computer',
                Name      => 'TestCI' . $RandomID,
                DeplState => 'Production',
                InciState => 'Incident',
                CIXMLData => {
                    NIC => [
                        {
                            NIC        => 'Eth0',
                            IPoverDHCP => 'No',
                        },
                        {
                            IPoverDHCP => 'No',
                        },
                    ],
                },
            },
        },
        ExpectedData => {
            Data => {
                Error => {
                    ErrorCode    => 'ConfigItemCreate.MissingParameter',
                    ErrorMessage =>
                        'ConfigItemCreate: ConfigItem->CIXMLData->NIC parameter value is required and is missing!',
                },
            },
        },
        Operation => 'ConfigItemCreate',
    },
    {
        Name           => 'Missing NIC->IpOverDHCP in array',
        SuccessRequest => 1,
        SuccessCreate  => 0,
        RequestData    => {
            ConfigItem => {
                Class     => 'Computer',
                Name      => 'TestCI' . $RandomID,
                DeplState => 'Production',
                InciState => 'Incident',
                CIXMLData => {
                    NIC => [
                        {
                            NIC        => 'Eth0',
                            IPoverDHCP => 'No',
                        },
                        {
                            NIC => 'Eth0',
                        },
                    ],
                },
            },
        },
        ExpectedData => {
            Data => {
                Error => {
                    ErrorCode    => 'ConfigItemCreate.MissingParameter',
                    ErrorMessage => 'ConfigItemCreate: ConfigItem->CIXMLData->NIC[1]->IPoverDHCP parameter is missing!',
                },
            },
        },
        Operation => 'ConfigItemCreate',
    },
    {
        Name           => 'Wrong NIC->IpOverDHCP General Catalog in Hash',
        SuccessRequest => 1,
        SuccessCreate  => 0,
        RequestData    => {
            ConfigItem => {
                Class     => 'Computer',
                Name      => 'TestCI' . $RandomID,
                DeplState => 'Production',
                InciState => 'Incident',
                CIXMLData => {
                    NIC => {
                        NIC        => 'Eth0',
                        IPoverDHCP => 'No' . $RandomID,
                    },
                },
            },
        },
        ExpectedData => {
            Data => {
                Error => {
                    ErrorCode    => 'ConfigItemCreate.InvalidParameter',
                    ErrorMessage =>
                        'ConfigItemCreate: ConfigItem->CIXMLData->NIC->IPoverDHCP parameter value is not a valid for General Catalog \'ITSM::ConfigItem::YesNo\'!',
                },
            },
        },
        Operation => 'ConfigItemCreate',
    },
    {
        Name           => 'Wrong NIC->IpOverDHCP General Catalog in Array Hash',
        SuccessRequest => 1,
        SuccessCreate  => 0,
        RequestData    => {
            ConfigItem => {
                Class     => 'Computer',
                Name      => 'TestCI' . $RandomID,
                DeplState => 'Production',
                InciState => 'Incident',
                CIXMLData => {
                    NIC => [
                        {
                            NIC        => 'Eth0',
                            IPoverDHCP => 'No',
                        },
                        {
                            NIC        => 'Eth0',
                            IPoverDHCP => 'No' . $RandomID,
                        },
                    ],
                },
            },
        },
        ExpectedData => {
            Data => {
                Error => {
                    ErrorCode    => 'ConfigItemCreate.InvalidParameter',
                    ErrorMessage =>
                        'ConfigItemCreate: ConfigItem->CIXMLData->NIC[1]->IPoverDHCP parameter value is not a valid for General Catalog \'ITSM::ConfigItem::YesNo\'!',
                },
            },
        },
        Operation => 'ConfigItemCreate',
    },
    {
        Name           => 'Wrong Vendor Long Text ',
        SuccessRequest => 1,
        SuccessCreate  => 0,
        RequestData    => {
            ConfigItem => {
                Class     => 'Computer',
                Name      => 'TestCI' . $RandomID,
                DeplState => 'Production',
                InciState => 'Incident',
                CIXMLData => {
                    Vendor => 'a' x 51,
                    NIC    => [
                        {
                            NIC        => 'Eth0',
                            IPoverDHCP => 'No',
                        },
                        {
                            NIC        => 'Eth1',
                            IPoverDHCP => 'Yes',
                        },
                    ],
                },
            },
        },
        ExpectedData => {
            Data => {
                Error => {
                    ErrorCode    => 'ConfigItemCreate.InvalidParameter',
                    ErrorMessage =>
                        'ConfigItemCreate: ConfigItem->CIXMLData->Vendor parameter value excedes the maxium length!',
                },
            },
        },
        Operation => 'ConfigItemCreate',
    },
    {
        Name           => 'Wrong WarrantyExpirationDate Date',
        SuccessRequest => 1,
        SuccessCreate  => 0,
        RequestData    => {
            ConfigItem => {
                Class     => 'Computer',
                Name      => 'TestCI' . $RandomID,
                DeplState => 'Production',
                InciState => 'Incident',
                CIXMLData => {
                    Vendor => 'Torero Chips',
                    NIC    => [
                        {
                            NIC        => 'Eth0',
                            IPoverDHCP => 'No',
                        },
                        {
                            NIC        => 'Eth1',
                            IPoverDHCP => 'Yes',
                        },
                    ],
                    WarrantyExpirationDate => '1930-30-30',
                },
            },
        },
        ExpectedData => {
            Data => {
                Error => {
                    ErrorCode    => 'ConfigItemCreate.InvalidParameter',
                    ErrorMessage =>
                        'ConfigItemCreate: ConfigItem->CIXMLData->WarrantyExpirationDate parameter value is not a valid Date format!',
                },
            },
        },
        Operation => 'ConfigItemCreate',
    },
    {
        Name           => 'Wrong Owner Customer',
        SuccessRequest => 1,
        SuccessCreate  => 0,
        RequestData    => {
            ConfigItem => {
                Class     => 'Computer',
                Name      => 'TestCI' . $RandomID,
                DeplState => 'Production',
                InciState => 'Incident',
                CIXMLData => {
                    Vendor => 'Torero Chips',
                    NIC    => [
                        {
                            NIC        => 'Eth0',
                            IPoverDHCP => 'No',
                        },
                        {
                            NIC        => 'Eth1',
                            IPoverDHCP => 'Yes',
                        },
                    ],
                    WarrantyExpirationDate => '1977-12-12',
                    Owner                  => $TestCustomerUserLogin . $RandomID,
                },
            },
        },
        ExpectedData => {
            Data => {
                Error => {
                    ErrorCode    => 'ConfigItemCreate.InvalidParameter',
                    ErrorMessage =>
                        'ConfigItemCreate: ConfigItem->CIXMLData->Owner parameter value is not a valid customer!',
                },
            },
        },
        Operation => 'ConfigItemCreate',
    },
    {
        Name           => 'Wrong Ram Too Many',
        SuccessRequest => 1,
        SuccessCreate  => 0,
        RequestData    => {
            ConfigItem => {
                Class     => 'Computer',
                Name      => 'TestCI' . $RandomID,
                DeplState => 'Production',
                InciState => 'Incident',
                CIXMLData => {
                    Vendor => 'Torero Chips',
                    NIC    => [
                        {
                            NIC        => 'Eth0',
                            IPoverDHCP => 'No',
                        },
                        {
                            NIC        => 'Eth1',
                            IPoverDHCP => 'Yes',
                        },
                    ],
                    WarrantyExpirationDate => '1977-12-12',
                    Owner                  => $TestCustomerUserLogin,
                    Ram                    => [
                        1,
                        2,
                        3,
                        4,
                        5,
                        6,
                        7,
                        8,
                        9,
                        10,
                        11,
                    ],
                },
            },
        },
        ExpectedData => {
            Data => {
                Error => {
                    ErrorCode    => 'ConfigItemCreate.InvalidParameter',
                    ErrorMessage =>
                        'ConfigItemCreate: ConfigItem->CIXMLData->Ram parameter repetitions is higher than the maxium value!',
                },
            },
        },
        Operation => 'ConfigItemCreate',
    },
    {
        Name           => 'Wrong Attachment',
        SuccessRequest => 1,
        SuccessCreate  => 0,
        RequestData    => {
            ConfigItem => {
                Class     => 'Computer',
                Name      => 'TestCI' . $RandomID,
                DeplState => 'Production',
                InciState => 'Incident',
                CIXMLData => {
                    Vendor => 'Torero Chips',
                    NIC    => [
                        {
                            NIC        => 'Eth0',
                            IPoverDHCP => 'No',
                        },
                        {
                            NIC        => 'Eth1',
                            IPoverDHCP => 'Yes',
                        },
                    ],
                    WarrantyExpirationDate => '1977-12-12',
                    Owner                  => $TestCustomerUserLogin,
                    Ram                    => [
                        4000,
                        4000,
                    ],
                },
                Attachment => 1,
            },
        },
        ExpectedData => {
            Data => {
                Error => {
                    ErrorCode    => 'ConfigItemCreate.InvalidParameter',
                    ErrorMessage => 'ConfigItemCreate: ConfigItem->Attachment parameter is invalid!',
                },
            },
        },
        Operation => 'ConfigItemCreate',
    },
    {
        Name           => 'Missing Attachment->Content',
        SuccessRequest => 1,
        SuccessCreate  => 0,
        RequestData    => {
            ConfigItem => {
                Class     => 'Computer',
                Name      => 'TestCI' . $RandomID,
                DeplState => 'Production',
                InciState => 'Incident',
                CIXMLData => {
                    Vendor => 'Torero Chips',
                    NIC    => [
                        {
                            NIC        => 'Eth0',
                            IPoverDHCP => 'No',
                        },
                        {
                            NIC        => 'Eth1',
                            IPoverDHCP => 'Yes',
                        },
                    ],
                    WarrantyExpirationDate => '1977-12-12',
                    Owner                  => $TestCustomerUserLogin,
                    Ram                    => [
                        4000,
                        4000,
                    ],
                },
                Attachment => [
                    {
                        Test => 1,
                    },
                ],
            },
        },
        ExpectedData => {
            Data => {
                Error => {
                    ErrorCode    => 'ConfigItemCreate.MissingParameter',
                    ErrorMessage => 'ConfigItemCreate: Attachment->Content parameter is missing!',
                },
            },
        },
        Operation => 'ConfigItemCreate',
    },
    {
        Name           => 'Missing Attachment->ContentType',
        SuccessRequest => 1,
        SuccessCreate  => 0,
        RequestData    => {
            ConfigItem => {
                Class     => 'Computer',
                Name      => 'TestCI' . $RandomID,
                DeplState => 'Production',
                InciState => 'Incident',
                CIXMLData => {
                    Vendor => 'Torero Chips',
                    NIC    => [
                        {
                            NIC        => 'Eth0',
                            IPoverDHCP => 'No',
                        },
                        {
                            NIC        => 'Eth1',
                            IPoverDHCP => 'Yes',
                        },
                    ],
                    WarrantyExpirationDate => '1977-12-12',
                    Owner                  => $TestCustomerUserLogin,
                    Ram                    => [
                        4000,
                        4000,
                    ],
                },
                Attachment => [
                    {
                        Content => 'VGhpcyBpcyBhbiBlbmNvZGVkIHRleHQ=',
                    },
                ],
            },
        },
        ExpectedData => {
            Data => {
                Error => {
                    ErrorCode    => 'ConfigItemCreate.MissingParameter',
                    ErrorMessage => 'ConfigItemCreate: Attachment->ContentType parameter is missing!',
                },
            },
        },
        Operation => 'ConfigItemCreate',
    },
    {
        Name           => 'Missing Attachment->Filename',
        SuccessRequest => 1,
        SuccessCreate  => 0,
        RequestData    => {
            ConfigItem => {
                Class     => 'Computer',
                Name      => 'TestCI' . $RandomID,
                DeplState => 'Production',
                InciState => 'Incident',
                CIXMLData => {
                    Vendor => 'Torero Chips',
                    NIC    => [
                        {
                            NIC        => 'Eth0',
                            IPoverDHCP => 'No',
                        },
                        {
                            NIC        => 'Eth1',
                            IPoverDHCP => 'Yes',
                        },
                    ],
                    WarrantyExpirationDate => '1977-12-12',
                    Owner                  => $TestCustomerUserLogin,
                    Ram                    => [
                        4000,
                        4000,
                    ],
                },
                Attachment => [
                    {
                        Content     => 'VGhpcyBpcyBhbiBlbmNvZGVkIHRleHQ=',
                        ContentType => 'text/plain',
                    },
                ],
            },
        },
        ExpectedData => {
            Data => {
                Error => {
                    ErrorCode    => 'ConfigItemCreate.MissingParameter',
                    ErrorMessage => 'ConfigItemCreate: Attachment->Filename parameter is missing!',
                },
            },
        },
        Operation => 'ConfigItemCreate',
    },
    {
        Name           => 'Correct ConfigItem',
        SuccessRequest => 1,
        SuccessCreate  => 1,
        RequestData    => {
            ConfigItem => {
                Class     => 'Computer',
                Name      => 'Test' . $RandomID,
                DeplState => 'Production',
                InciState => 'Operational',
                CIXMLData => {
                    Vendor          => 'Lenovo',
                    Model           => 'Thinkpad',
                    Description     => 'Thinkpad X300',
                    Type            => 'Desktop',
                    Owner           => $TestCustomerUserLogin,
                    SerialNumber    => 'abc12345abc',
                    OperatingSystem => 'CentOS 6.0',
                    CPU             => 'Intel Core i3',
                    Ram             => [
                        '4000',
                        '2000',
                    ],
                    HardDisk => {
                        HardDisk => '/dev',
                        Capacity => '50000',
                    },
                    FQDN => 'hots.example.com',
                    NIC  => [
                        {
                            NIC        => 'Eth0',
                            IPoverDHCP => 'No',
                            IPAddress  => '192.168.30.1',

                        },
                        {
                            NIC        => 'Eth1',
                            IPoverDHCP => 'Yes',
                            IPAddress  => '200.34.56.78',
                        },
                    ],
                    GraphicAdapter         => 'ATI Radeon 300',
                    WarrantyExpirationDate => '1977-12-12',
                    InstallDate            => '1977-12-12',
                    Note                   => 'This is a Demo CI',
                },
                Attachment => [
                    {
                        Content     => 'VGhpcyBpcyBhbiBlbmNvZGVkIHRleHQ=',
                        ContentType => 'text/plain',
                        Filename    => 'My Text.txt',
                    },
                    {
                        Content     => 'VGhpcyBpcyBhbiBlbmNvZGVkIHRleHQ=',
                        ContentType => 'text/plain; charset=iso-8859-1',
                        Filename    => 'My Text2.txt',
                    },
                ],
            },
        },
        Operation => 'ConfigItemCreate',
    },
    {
        Name           => 'Correct ConfigItem without XSLData',
        SuccessRequest => 1,
        SuccessCreate  => 1,
        RequestData    => {
            ConfigItem => {
                Class     => 'Location',
                Name      => 'Test' . $RandomID,
                DeplState => 'Production',
                InciState => 'Operational',
            },
        },
        Operation => 'ConfigItemCreate',
    },
);

# Start testing.
for my $Test (@Tests) {
    subtest $Test->{Name} => sub {

        my $Todo = defined $Test->{Todo} ? todo( $Test->{Todo} ) : undef;

        # Create local object.
        my $LocalObject = "Kernel::GenericInterface::Operation::ConfigItem::$Test->{Operation}"->new(
            DebuggerObject => $DebuggerObject,
            WebserviceID   => $WebserviceID,
        );
        isa_ok(
            $LocalObject,
            ["Kernel::GenericInterface::Operation::ConfigItem::$Test->{Operation}"],
            "Create local object",
        );

        # Make a deep copy to avoid changing the definition.
        my $ClonedRequestData = Storable::dclone( $Test->{RequestData} );

        # Start requester with our webservice locally
        my $LocalResult = $LocalObject->Run(
            WebserviceID => $WebserviceID,
            Invoker      => $Test->{Operation},
            Data         => {
                UserLogin => $UserLogin,
                Password  => $Password,
                %{ $Test->{RequestData} },
            },
        );

        # Restore cloned data.
        $Test->{RequestData} = $ClonedRequestData;

        # Check result.
        ref_ok(
            $LocalResult,
            'HASH',
            "Local result structure is valid",
        );

        # Create requester object.
        my $RequesterObject = $Kernel::OM->Get('Kernel::GenericInterface::Requester');
        isa_ok(
            $RequesterObject,
            ['Kernel::GenericInterface::Requester'],
            "Create requester object",
        );

        # Start requester with our webservice.
        my $RequesterResult = $RequesterObject->Run(
            WebserviceID => $WebserviceID,
            Invoker      => $Test->{Operation},
            Data         => {
                SessionID => $NewSessionID,
                %{ $Test->{RequestData} },
            },
        );

        # Check result.
        ref_ok(
            $RequesterResult,
            'HASH',
            "Requester result structure is valid",
        );

        is(
            $RequesterResult->{Success},
            $Test->{SuccessRequest},
            "Requester successful result",
        );

        # Tests supposed to succeed.
        if ( $Test->{SuccessCreate} ) {

            # Local results.
            ok( $LocalResult->{Data}->{ConfigItemID}, "Local result got ConfigItemID" );
            ok( $LocalResult->{Data}->{Number},       "Local result Number with True." );
            is(
                $LocalResult->{Data}->{Error},
                undef,
                "Local result Error is undefined.",
            );

            # Requester results.
            ok( $RequesterResult->{Data}->{ConfigItemID}, "Requester result ConfigItemID with True." );
            ok( $RequesterResult->{Data}->{Number},       "Requester result Number with True." );
            is(
                $RequesterResult->{Data}->{Error},
                undef,
                "Requester result Error is undefined.",
            );

            # Get the ConfigItem entry (from local result).
            my $LocalVersionData = $ConfigItemObject->VersionGet(
                ConfigItemID => $LocalResult->{Data}->{ConfigItemID},
                UserID       => 1,
            );

            ok(
                IsHashRefWithData($LocalVersionData),
                "created local version strcture with True.",
            );

            # Get the config item entry (from requester result).
            my $RequesterVersionData = $ConfigItemObject->VersionGet(
                ConfigItemID => $RequesterResult->{Data}->{ConfigItemID},
                UserID       => 1,
            );

            ok(
                IsHashRefWithData($RequesterVersionData),
                "created requester config item strcture with True.",
            );

            # Check config item attributes as defined in the test.
            for my $Attribute (qw(Number Class Name InciState DeplState DeplStateType)) {
                if ( $Test->{RequestData}->{ConfigItem}->{$Attribute} ) {
                    is(
                        $LocalVersionData->{$Attribute},
                        $Test->{RequestData}->{ConfigItem}->{$Attribute},
                        "local ConfigItem->$Attribute" . " match test definition.",
                    );
                }
            }

            if ( $Test->{RequestData}->{ConfigItem}->{CIXMLData} ) {

                # Transform XML data to a comparable format.
                my $Definition = $LocalVersionData->{XMLDefinition};

                # Make a deep copy to avoid changing the result.
                my $ClonedXMLData = Storable::dclone( $LocalVersionData->{XMLData} );

                my $FormatedXMLData = $LocalObject->InvertFormatXMLData(
                    XMLData => $ClonedXMLData->[1]->{Version},
                );

                my $ReplacedXMLData = $LocalObject->InvertReplaceXMLData(
                    XMLData    => $FormatedXMLData,
                    Definition => $Definition,
                );

                # Compare XML data.
                is(
                    $ReplacedXMLData,
                    $Test->{RequestData}->{ConfigItem}->{CIXMLData},
                    "local ConfigItem->CIXMLData match test definition.",
                );
            }

            if ( $Test->{RequestData}->{ConfigItem}->{Attachment} ) {

                # Check attachments.
                my @AttachmentList = $ConfigItemObject->ConfigItemAttachmentList(
                    ConfigItemID => $RequesterResult->{Data}->{ConfigItemID},
                );

                my @Attachments;
                ATTACHMENT:
                for my $FileName (@AttachmentList) {
                    next ATTACHMENT if !$FileName;

                    my $Attachment = $ConfigItemObject->ConfigItemAttachmentGet(
                        ConfigItemID => $RequesterResult->{Data}->{ConfigItemID},
                        Filename     => $FileName,
                    );

                    # Next if not attachment.
                    next ATTACHMENT if !IsHashRefWithData($Attachment);

                    # Convert content to base64.
                    $Attachment->{Content} = encode_base64( $Attachment->{Content}, '' );

                    # Delete not needed attibutes.
                    for my $Attribute (qw(Preferences Filesize Type)) {
                        delete $Attachment->{$Attribute};
                    }
                    push @Attachments, $Attachment;
                }

                my @RequestedAttachments;
                if ( ref $Test->{RequestData}->{Attachment} eq 'HASH' ) {
                    push @RequestedAttachments, $Test->{RequestData}->{ConfigItem}->{Attachment};
                }
                else {
                    @RequestedAttachments = @{ $Test->{RequestData}->{ConfigItem}->{Attachment} };
                }

                is(
                    \@Attachments,
                    \@RequestedAttachments,
                    "local ConfigItem->Attachment match test definition.",
                );
            }

            # Remove attributes that might be different from local and requester responses.
            for my $Attribute (
                qw(ConfigItemID Number CreateTime VersionID LastVersionID)
                )
            {
                delete $LocalVersionData->{$Attribute};
                delete $RequesterVersionData->{$Attribute};
            }

            is(
                $LocalVersionData,
                $RequesterVersionData,
                "Local config item result matched with remote result.",
            );

            # Delete the config items.
            for my $ConfigItemID (
                $LocalResult->{Data}->{ConfigItemID},
                $RequesterResult->{Data}->{ConfigItemID}
                )
            {

                my $ConfigItemDelete = $ConfigItemObject->ConfigItemDelete(
                    ConfigItemID => $ConfigItemID,
                    UserID       => 1,
                );

                # Sanity check.
                ok(
                    $ConfigItemDelete,
                    "ConfigItemDelete() successful for ConfigItem ID $ConfigItemID",
                );
            }
        }

        # Tests supposed to fail.
        else {
            ok(
                !$LocalResult->{ConfigItemID},
                "Local result ConfigItemID with false.",
            );
            ok(
                !$LocalResult->{Number},
                "Local result Number with false.",
            );
            is(
                $LocalResult->{Data}->{Error}->{ErrorCode},
                $Test->{ExpectedData}->{Data}->{Error}->{ErrorCode},
                "Local result ErrorCode matched with expected local call result.",
            );
            is(
                $LocalResult->{Data}->{Error}->{ErrorMessage},
                $Test->{ExpectedData}->{Data}->{Error}->{ErrorMessage},
                "Local result ErrorMessage matched with expected local call result.",
            );
            is(
                $LocalResult->{ErrorMessage},
                $LocalResult->{Data}->{Error}->{ErrorCode}
                    . ': '
                    . $LocalResult->{Data}->{Error}->{ErrorMessage},
                "Local result ErrorMessage (outside Data hash) matched with concatenation"
                    . " of ErrorCode and ErrorMessage within Data hash.",
            );

            # Remove ErrorMessage parameter from direct call.
            # Result to be consistent with SOAP call result.
            if ( $LocalResult->{ErrorMessage} ) {
                delete $LocalResult->{ErrorMessage};
            }

            # Sanity check.
            ok(
                !$LocalResult->{ErrorMessage},
                "Local result ErroMessage (outsise Data hash) got removed to compare"
                    . " local and remote tests.",
            );

            is(
                $LocalResult,
                $RequesterResult,
                "Local result matched with remote result.",
            );
        }
    };
}

# Clean up webservice.
my $WebserviceDelete = $WebserviceObject->WebserviceDelete(
    ID     => $WebserviceID,
    UserID => 1,
);
ok( $WebserviceDelete, "Deleted Webservice $WebserviceID" );

done_testing;

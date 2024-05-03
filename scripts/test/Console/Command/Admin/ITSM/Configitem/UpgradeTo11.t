# --
# OTOBO is a web-based ticketing system for service organisations.
# --
# Copyright (C) 2001-2020 OTRS AG, https://otrs.com/
# Copyright (C) 2019-2024 Rother OSS GmbH, https://otobo.de/
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
use MIME::Base64 qw(decode_base64);

# CPAN modules
use Test2::V0;

# OTOBO modules
use Kernel::System::UnitTest::RegisterOM;    # Set up $Kernel::OM

# TODO: test the command
#my $CommandObject = $Kernel::OM->Get('Kernel::System::Console::Command::Admin::ITSM::Configitem::UpgradeTo11');

# get helper object, database changes should be restored
$Kernel::OM->ObjectParamAdd(
    'Kernel::System::UnitTest::Helper' => {
        RestoreDatabase => 1,
    },
);
my $Helper = $Kernel::OM->Get('Kernel::System::UnitTest::Helper');    ## no critic qw(Variables::ProhibitUnusedVarsStricter)

#my $ExitCode = $CommandObject->Execute;
#is(
#    $ExitCode,
#    1,
#    "Admin::ITSM::Configitem::UpgradeTo11 exit code without options",
#);

my $DBObject = $Kernel::OM->Get('Kernel::System::DB');

# Setup of test data, which conforms to the OTOBO 10.1 format

# table general_catalog
my %ConfigItemClassName2ID;
{
    # The names of the config item classes are kept in the general catalog.
    # Let's add classes with names that have the prefix 'TestUpgrade',
    # Try to now meddle with existing data.
    my $GeneralCatalogClass = 'ITSM::ConfigItem::Class';
    my $ValidID             = 1;
    my @Names               = map { join '_', 'TestUpgrade', $_ } qw(Computer Hardware Location Network Software);
    my $NumRows             = $DBObject->DoArray(
        SQL => <<'END_SQL',
INSERT INTO general_catalog (
    general_catalog_class,
    name,
    valid_id,
    create_time,
    create_by,
    change_time,
    change_by
  )
  VALUES (?, ?, ?, current_timestamp, 1, current_timestamp, 1)
END_SQL
        Bind => [ $GeneralCatalogClass, \@Names, $ValidID ],
    );
    is( $NumRows, scalar @Names, 'number of rows inserted into general_catalog' );

    %ConfigItemClassName2ID = $DBObject->SelectMapping(
        SQL => 'SELECT name, id FROM general_catalog WHERE name LIKE "TestUpgrade_%"',
    );
    my %ExpectedConfigItemClassName2ID = map { $_ => match(qr/[0-9]+/) } @Names;
    is(
        \%ConfigItemClassName2ID,
        \%ExpectedConfigItemClassName2ID,
        'config item names were inserted'
    );
}

# table configitem_definition
{
    # add sample data for the table configitem_definition
    my $Rows = GetConfigItemDefinitionRows();

    # Add the class_id for this run of the test script
    my @ClassIDs    = map { 0 + $ConfigItemClassName2ID{ $_->{class_name} } } $Rows->@*;
    my @Definitions = map { $_->{configitem_definition} } $Rows->@*;

    my $NumRows = $DBObject->DoArray(
        SQL => <<'END_SQL',
INSERT INTO configitem_definition (
    class_id,
    configitem_definition,
    dynamicfield_definition,
    version,
    create_time,
    create_by
  )
  VALUES ( ?, ?, '--- {}', 1, current_timestamp, 1 )
END_SQL
        Bind => [ \@ClassIDs, \@Definitions ],
    );
    is( $NumRows, scalar @ClassIDs, 'number of rows inserted into configitem_definition' );

    # retrieve the definitions as a sanity check
    my $Placeholders         = join ', ', map {'?'} @ClassIDs;
    my @Binds                = map { \$_ } @ClassIDs;
    my @RetrievedDefinitions = $DBObject->SelectColArray(
        SQL => <<"END_SQL",
SELECT configitem_definition
  FROM configitem_definition
  WHERE class_id IN ( $Placeholders )
  ORDER BY configitem_definition
END_SQL
        Bind => \@Binds,
    );
    is(
        \@RetrievedDefinitions,
        [ sort @Definitions ],
        'insert into configitem_definition'
    );
}

sub GetConfigItemDefinitionRows {

    # This is based on the JSON dump of configitem_definition from DBeaver.
    # The class name was added manually, because the class_id changes for every run.
    # Remember that JSON does not allow trailing commas.
    my $JSON = <<'END_JSON';
{
"configitem_definition": [
    {
        "class_name" : "TestUpgrade_Computer",
        "class_id" : null,
        "configitem_definition" : "LS0tCi0gS2V5OiBWZW5kb3IKICBOYW1lOiBWZW5kb3IKICBTZWFyY2hhYmxlOiAxCiAgSW5wdXQ6CiAgICBUeXBlOiBUZXh0CiAgICBTaXplOiA1MAogICAgTWF4TGVuZ3RoOiA1MAogICAgIyBFeGFtcGxlIGZvciBDSSBhdHRyaWJ1dGUgc3ludGF4IGNoZWNrIGZvciB0ZXh0IGFuZCB0ZXh0YXJlYSBmaWVsZHMKICAgICNSZWdFeDogXkFCQy4qCiAgICAjUmVnRXhFcnJvck1lc3NhZ2U6IFZhbHVlIG11c3Qgc3RhcnQgd2l0aCBBQkMhCgotIEtleTogTW9kZWwKICBOYW1lOiBNb2RlbAogIFNlYXJjaGFibGU6IDEKICBJbnB1dDoKICAgIFR5cGU6IFRleHQKICAgIFNpemU6IDUwCiAgICBNYXhMZW5ndGg6IDUwCgotIEtleTogRGVzY3JpcHRpb24KICBOYW1lOiBEZXNjcmlwdGlvbgogIFNlYXJjaGFibGU6IDEKICBJbnB1dDoKICAgIFR5cGU6IFRleHRBcmVhCgotIEtleTogVHlwZQogIE5hbWU6IFR5cGUKICBTZWFyY2hhYmxlOiAxCiAgSW5wdXQ6CiAgICBUeXBlOiBHZW5lcmFsQ2F0YWxvZwogICAgQ2xhc3M6IElUU006OkNvbmZpZ0l0ZW06OkNvbXB1dGVyOjpUeXBlCiAgICBUcmFuc2xhdGlvbjogMQoKLSBLZXk6IEN1c3RvbWVySUQKICBOYW1lOiBDdXN0b21lciBDb21wYW55CiAgU2VhcmNoYWJsZTogMQogIElucHV0OgogICAgVHlwZTogQ3VzdG9tZXJDb21wYW55CgotIEtleTogT3duZXIKICBOYW1lOiBPd25lcgogIFNlYXJjaGFibGU6IDEKICBJbnB1dDoKICAgIFR5cGU6IEN1c3RvbWVyCgotIEtleTogU2VyaWFsTnVtYmVyCiAgTmFtZTogU2VyaWFsIE51bWJlcgogIFNlYXJjaGFibGU6IDEKICBJbnB1dDoKICAgIFR5cGU6IFRleHQKICAgIFNpemU6IDUwCiAgICBNYXhMZW5ndGg6IDEwMAoKLSBLZXk6IE9wZXJhdGluZ1N5c3RlbQogIE5hbWU6IE9wZXJhdGluZyBTeXN0ZW0KICBJbnB1dDoKICAgIFR5cGU6IFRleHQKICAgIFNpemU6IDUwCiAgICBNYXhMZW5ndGg6IDEwMAoKLSBLZXk6IENQVQogIE5hbWU6IENQVQogIElucHV0OgogICAgVHlwZTogVGV4dAogICAgU2l6ZTogNTAKICAgIE1heExlbmd0aDogMTAwCiAgQ291bnRNYXg6IDE2CgotIEtleTogUmFtCiAgTmFtZTogUmFtCiAgSW5wdXQ6CiAgICBUeXBlOiBUZXh0CiAgICBTaXplOiA1MAogICAgTWF4TGVuZ3RoOiAxMDAKICBDb3VudE1heDogMTAKCi0gS2V5OiBIYXJkRGlzawogIE5hbWU6IEhhcmQgRGlzawogIElucHV0OgogICAgVHlwZTogVGV4dAogICAgU2l6ZTogNTAKICAgIE1heExlbmd0aDogMTAwCiAgQ291bnRNYXg6IDEwCiAgU3ViOgogIC0gS2V5OiBDYXBhY2l0eQogICAgTmFtZTogQ2FwYWNpdHkKICAgIElucHV0OgogICAgICBUeXBlOiBUZXh0CiAgICAgIFNpemU6IDIwCiAgICAgIE1heExlbmd0aDogMTAKCi0gS2V5OiBGUUROCiAgTmFtZTogRlFETgogIFNlYXJjaGFibGU6IDEKICBJbnB1dDoKICAgIFR5cGU6IFRleHQKICAgIFNpemU6IDUwCiAgICBNYXhMZW5ndGg6IDEwMAoKLSBLZXk6IE5JQwogIE5hbWU6IE5ldHdvcmsgQWRhcHRlcgogIElucHV0OgogICAgVHlwZTogVGV4dAogICAgU2l6ZTogNTAKICAgIE1heExlbmd0aDogMTAwCiAgICBSZXF1aXJlZDogMQogIENvdW50TWluOiAwCiAgQ291bnRNYXg6IDEwCiAgQ291bnREZWZhdWx0OiAxCiAgU3ViOgogIC0gS2V5OiBJUG92ZXJESENQCiAgICBOYW1lOiBJUCBvdmVyIERIQ1AKICAgIElucHV0OgogICAgICBUeXBlOiBHZW5lcmFsQ2F0YWxvZwogICAgICBDbGFzczogSVRTTTo6Q29uZmlnSXRlbTo6WWVzTm8KICAgICAgVHJhbnNsYXRpb246IDEKICAgICAgUmVxdWlyZWQ6IDEKICAtIEtleTogSVBBZGRyZXNzCiAgICBOYW1lOiBJUCBBZGRyZXNzCiAgICBTZWFyY2hhYmxlOiAxCiAgICBJbnB1dDoKICAgICAgVHlwZTogVGV4dAogICAgICBTaXplOiA0MAogICAgICBNYXhMZW5ndGg6IDQwCiAgICAgIFJlcXVpcmVkOiAxCiAgICBDb3VudE1pbjogMAogICAgQ291bnRNYXg6IDIwCiAgICBDb3VudERlZmF1bHQ6IDAKCi0gS2V5OiBHcmFwaGljQWRhcHRlcgogIE5hbWU6IEdyYXBoaWMgQWRhcHRlcgogIElucHV0OgogICAgVHlwZTogVGV4dAogICAgU2l6ZTogNTAKICAgIE1heExlbmd0aDogMTAwCgotIEtleTogT3RoZXJFcXVpcG1lbnQKICBOYW1lOiBPdGhlciBFcXVpcG1lbnQKICBJbnB1dDoKICAgIFR5cGU6IFRleHRBcmVhCiAgICBSZXF1aXJlZDogMQogIENvdW50TWluOiAwCiAgQ291bnREZWZhdWx0OiAwCgotIEtleTogV2FycmFudHlFeHBpcmF0aW9uRGF0ZQogIE5hbWU6IFdhcnJhbnR5IEV4cGlyYXRpb24gRGF0ZQogIFNlYXJjaGFibGU6IDEKICBJbnB1dDoKICAgIFR5cGU6IERhdGUKICAgIFllYXJQZXJpb2RQYXN0OiAyMAogICAgWWVhclBlcmlvZEZ1dHVyZTogMTAKCi0gS2V5OiBJbnN0YWxsRGF0ZQogIE5hbWU6IEluc3RhbGwgRGF0ZQogIFNlYXJjaGFibGU6IDEKICBJbnB1dDoKICAgIFR5cGU6IERhdGUKICAgIFJlcXVpcmVkOiAxCiAgICBZZWFyUGVyaW9kUGFzdDogMjAKICAgIFllYXJQZXJpb2RGdXR1cmU6IDEwCiAgQ291bnRNaW46IDAKICBDb3VudERlZmF1bHQ6IDAKCi0gS2V5OiBOb3RlCiAgTmFtZTogTm90ZQogIFNlYXJjaGFibGU6IDEKICBJbnB1dDoKICAgIFR5cGU6IFRleHRBcmVhCiAgICBSZXF1aXJlZDogMQogIENvdW50TWluOiAwCiAgQ291bnREZWZhdWx0OiAwCg==",
        "dynamicfield_definition" : "LS0tIHt9Cg==",
        "version" : 1,
        "create_time" : "2023-07-13T10:25:59.000Z",
        "create_by" : 1
    },
    {
        "class_name" : "TestUpgrade_Hardware",
        "class_id" : null,
        "configitem_definition" : "LS0tCi0gS2V5OiBWZW5kb3IKICBOYW1lOiBWZW5kb3IKICBTZWFyY2hhYmxlOiAxCiAgSW5wdXQ6CiAgICBUeXBlOiBUZXh0CiAgICBTaXplOiA1MAogICAgTWF4TGVuZ3RoOiA1MAoKLSBLZXk6IE1vZGVsCiAgTmFtZTogTW9kZWwKICBTZWFyY2hhYmxlOiAxCiAgSW5wdXQ6CiAgICBUeXBlOiBUZXh0CiAgICBTaXplOiA1MAogICAgTWF4TGVuZ3RoOiA1MAoKLSBLZXk6IERlc2NyaXB0aW9uCiAgTmFtZTogRGVzY3JpcHRpb24KICBTZWFyY2hhYmxlOiAxCiAgSW5wdXQ6CiAgICBUeXBlOiBUZXh0QXJlYQoKLSBLZXk6IFR5cGUKICBOYW1lOiBUeXBlCiAgU2VhcmNoYWJsZTogMQogIElucHV0OgogICAgVHlwZTogR2VuZXJhbENhdGFsb2cKICAgIENsYXNzOiBJVFNNOjpDb25maWdJdGVtOjpIYXJkd2FyZTo6VHlwZQogICAgVHJhbnNsYXRpb246IDEKCi0gS2V5OiBDdXN0b21lcklECiAgTmFtZTogQ3VzdG9tZXIgQ29tcGFueQogIFNlYXJjaGFibGU6IDEKICBJbnB1dDoKICAgIFR5cGU6IEN1c3RvbWVyQ29tcGFueQoKLSBLZXk6IE93bmVyCiAgTmFtZTogT3duZXIKICBTZWFyY2hhYmxlOiAxCiAgSW5wdXQ6CiAgICBUeXBlOiBDdXN0b21lcgoKLSBLZXk6IFNlcmlhbE51bWJlcgogIE5hbWU6IFNlcmlhbCBOdW1iZXIKICBTZWFyY2hhYmxlOiAxCiAgSW5wdXQ6CiAgICBUeXBlOiBUZXh0CiAgICBTaXplOiA1MAogICAgTWF4TGVuZ3RoOiAxMDAKCi0gS2V5OiBXYXJyYW50eUV4cGlyYXRpb25EYXRlCiAgTmFtZTogV2FycmFudHkgRXhwaXJhdGlvbiBEYXRlCiAgU2VhcmNoYWJsZTogMQogIElucHV0OgogICAgVHlwZTogRGF0ZQogICAgWWVhclBlcmlvZFBhc3Q6IDIwCiAgICBZZWFyUGVyaW9kRnV0dXJlOiAxMAoKLSBLZXk6IEluc3RhbGxEYXRlCiAgTmFtZTogSW5zdGFsbCBEYXRlCiAgU2VhcmNoYWJsZTogMQogIElucHV0OgogICAgVHlwZTogRGF0ZQogICAgUmVxdWlyZWQ6IDEKICAgIFllYXJQZXJpb2RQYXN0OiAyMAogICAgWWVhclBlcmlvZEZ1dHVyZTogMTAKICBDb3VudE1pbjogMAogIENvdW50TWF4OiAxCiAgQ291bnREZWZhdWx0OiAwCgotIEtleTogTm90ZQogIE5hbWU6IE5vdGUKICBTZWFyY2hhYmxlOiAxCiAgSW5wdXQ6CiAgICBUeXBlOiBUZXh0QXJlYQogICAgUmVxdWlyZWQ6IDEKICBDb3VudE1pbjogMAogIENvdW50TWF4OiAxCiAgQ291bnREZWZhdWx0OiAwCg==",
        "dynamicfield_definition" : "LS0tIHt9Cg==",
        "version" : 1,
        "create_time" : "2023-07-13T10:25:59.000Z",
        "create_by" : 1
    },
    {
        "class_name" : "TestUpgrade_Location",
        "class_id" : null,
        "configitem_definition" : "LS0tCi0gS2V5OiBUeXBlCiAgTmFtZTogVHlwZQogIFNlYXJjaGFibGU6IDEKICBJbnB1dDoKICAgIFR5cGU6IEdlbmVyYWxDYXRhbG9nCiAgICBDbGFzczogSVRTTTo6Q29uZmlnSXRlbTo6TG9jYXRpb246OlR5cGUKICAgIFRyYW5zbGF0aW9uOiAxCgotIEtleTogQ3VzdG9tZXJJRAogIE5hbWU6IEN1c3RvbWVyIENvbXBhbnkKICBTZWFyY2hhYmxlOiAxCiAgSW5wdXQ6CiAgICBUeXBlOiBDdXN0b21lckNvbXBhbnkKCi0gS2V5OiBPd25lcgogIE5hbWU6IE93bmVyCiAgU2VhcmNoYWJsZTogMQogIElucHV0OgogICAgVHlwZTogQ3VzdG9tZXIKCi0gS2V5OiBQaG9uZTEKICBOYW1lOiBQaG9uZSAxCiAgU2VhcmNoYWJsZTogMQogIElucHV0OgogICAgVHlwZTogVGV4dAogICAgU2l6ZTogNTAKICAgIE1heExlbmd0aDogMTAwCgotIEtleTogUGhvbmUyCiAgTmFtZTogUGhvbmUgMgogIFNlYXJjaGFibGU6IDEKICBJbnB1dDoKICAgIFR5cGU6IFRleHQKICAgIFNpemU6IDUwCiAgICBNYXhMZW5ndGg6IDEwMAoKLSBLZXk6IEZheAogIE5hbWU6IEZheAogIFNlYXJjaGFibGU6IDEKICBJbnB1dDoKICAgIFR5cGU6IFRleHQKICAgIFNpemU6IDUwCiAgICBNYXhMZW5ndGg6IDEwMAoKLSBLZXk6IEUtTWFpbAogIE5hbWU6IEUtTWFpbAogIFNlYXJjaGFibGU6IDEKICBJbnB1dDoKICAgIFR5cGU6IFRleHQKICAgIFNpemU6IDUwCiAgICBNYXhMZW5ndGg6IDEwMAoKLSBLZXk6IEFkZHJlc3MKICBOYW1lOiBBZGRyZXNzCiAgU2VhcmNoYWJsZTogMQogIElucHV0OgogICAgVHlwZTogVGV4dEFyZWEKCi0gS2V5OiBOb3RlCiAgTmFtZTogTm90ZQogIFNlYXJjaGFibGU6IDEKICBJbnB1dDoKICAgIFR5cGU6IFRleHRBcmVhCiAgICBSZXF1aXJlZDogMQogIENvdW50TWluOiAwCiAgQ291bnREZWZhdWx0OiAwCg==",
        "dynamicfield_definition" : "LS0tIHt9Cg==",
        "version" : 1,
        "create_time" : "2023-07-13T10:25:59.000Z",
        "create_by" : 1
    },
    {
        "class_name" : "TestUpgrade_Network",
        "class_id" : null,
        "configitem_definition" : "LS0tCi0gS2V5OiBEZXNjcmlwdGlvbgogIE5hbWU6IERlc2NyaXB0aW9uCiAgU2VhcmNoYWJsZTogMQogIElucHV0OgogICAgVHlwZTogVGV4dEFyZWEKCi0gS2V5OiBUeXBlCiAgTmFtZTogVHlwZQogIFNlYXJjaGFibGU6IDEKICBJbnB1dDoKICAgIFR5cGU6IEdlbmVyYWxDYXRhbG9nCiAgICBDbGFzczogSVRTTTo6Q29uZmlnSXRlbTo6TmV0d29yazo6VHlwZQogICAgVHJhbnNsYXRpb246IDEKCi0gS2V5OiBDdXN0b21lcklECiAgTmFtZTogQ3VzdG9tZXIgQ29tcGFueQogIFNlYXJjaGFibGU6IDEKICBJbnB1dDoKICAgIFR5cGU6IEN1c3RvbWVyQ29tcGFueQoKLSBLZXk6IE93bmVyCiAgTmFtZTogT3duZXIKICBTZWFyY2hhYmxlOiAxCiAgSW5wdXQ6CiAgICBUeXBlOiBDdXN0b21lcgoKLSBLZXk6IE5ldHdvcmtBZGRyZXNzCiAgTmFtZTogTmV0d29yayBBZGRyZXNzCiAgU2VhcmNoYWJsZTogMQogIElucHV0OgogICAgVHlwZTogVGV4dAogICAgU2l6ZTogMzAKICAgIE1heExlbmd0aDogMjAKICAgIFJlcXVpcmVkOiAxCiAgQ291bnRNaW46IDAKICBDb3VudE1heDogMTAwCiAgQ291bnREZWZhdWx0OiAxCiAgU3ViOgogIC0gS2V5OiBTdWJuZXRNYXNrCiAgICBOYW1lOiBTdWJuZXQgTWFzawogICAgSW5wdXQ6CiAgICAgIFR5cGU6IFRleHQKICAgICAgU2l6ZTogMzAKICAgICAgTWF4TGVuZ3RoOiAyMAogICAgICBWYWx1ZURlZmF1bHQ6IDI1NS4yNTUuMjU1LjAKICAgICAgUmVxdWlyZWQ6IDEKICAgIENvdW50TWluOiAwCiAgICBDb3VudE1heDogMQogICAgQ291bnREZWZhdWx0OiAwCiAgLSBLZXk6IEdhdGV3YXkKICAgIE5hbWU6IEdhdGV3YXkKICAgIElucHV0OgogICAgICBUeXBlOiBUZXh0CiAgICAgIFNpemU6IDMwCiAgICAgIE1heExlbmd0aDogMjAKICAgICAgUmVxdWlyZWQ6IDEKICAgIENvdW50TWluOiAwCiAgICBDb3VudE1heDogMTAKICAgIENvdW50RGVmYXVsdDogMAoKLSBLZXk6IE5vdGUKICBOYW1lOiBOb3RlCiAgU2VhcmNoYWJsZTogMQogIElucHV0OgogICAgUmVxdWlyZWQ6IDEKICAgIFR5cGU6IFRleHRBcmVhCiAgQ291bnRNaW46IDAKICBDb3VudE1heDogMQogIENvdW50RGVmYXVsdDogMAo=",
        "dynamicfield_definition" : "LS0tIHt9Cg==",
        "version" : 1,
        "create_time" : "2023-07-13T10:25:59.000Z",
        "create_by" : 1
    },
    {
        "class_name" : "TestUpgrade_Software",
        "class_id" : null,
        "configitem_definition" : "LS0tCi0gS2V5OiBWZW5kb3IKICBOYW1lOiBWZW5kb3IKICBTZWFyY2hhYmxlOiAxCiAgSW5wdXQ6CiAgICBUeXBlOiBUZXh0CiAgICBTaXplOiA1MAogICAgTWF4TGVuZ3RoOiA1MAoKLSBLZXk6IFZlcnNpb24KICBOYW1lOiBWZXJzaW9uCiAgU2VhcmNoYWJsZTogMQogIElucHV0OgogICAgVHlwZTogVGV4dAogICAgU2l6ZTogNTAKICAgIE1heExlbmd0aDogNTAKCi0gS2V5OiBEZXNjcmlwdGlvbgogIE5hbWU6IERlc2NyaXB0aW9uCiAgU2VhcmNoYWJsZTogMQogIElucHV0OgogICAgVHlwZTogVGV4dEFyZWEKCi0gS2V5OiBUeXBlCiAgTmFtZTogVHlwZQogIFNlYXJjaGFibGU6IDEKICBJbnB1dDoKICAgIFR5cGU6IEdlbmVyYWxDYXRhbG9nCiAgICBDbGFzczogSVRTTTo6Q29uZmlnSXRlbTo6U29mdHdhcmU6OlR5cGUKICAgIFRyYW5zbGF0aW9uOiAxCgotIEtleTogQ3VzdG9tZXJJRAogIE5hbWU6IEN1c3RvbWVyIENvbXBhbnkKICBTZWFyY2hhYmxlOiAxCiAgSW5wdXQ6CiAgICBUeXBlOiBDdXN0b21lckNvbXBhbnkKCi0gS2V5OiBPd25lcgogIE5hbWU6IE93bmVyCiAgU2VhcmNoYWJsZTogMQogIElucHV0OgogICAgVHlwZTogQ3VzdG9tZXIKCi0gS2V5OiBTZXJpYWxOdW1iZXIKICBOYW1lOiBTZXJpYWwgTnVtYmVyCiAgU2VhcmNoYWJsZTogMQogIElucHV0OgogICAgVHlwZTogVGV4dAogICAgU2l6ZTogNTAKICAgIE1heExlbmd0aDogNTAKCi0gS2V5OiBMaWNlbmNlVHlwZQogIE5hbWU6IExpY2VuY2UgVHlwZQogIFNlYXJjaGFibGU6IDEKICBJbnB1dDoKICAgIFR5cGU6IEdlbmVyYWxDYXRhbG9nCiAgICBDbGFzczogSVRTTTo6Q29uZmlnSXRlbTo6U29mdHdhcmU6OkxpY2VuY2VUeXBlCiAgICBUcmFuc2xhdGlvbjogMQoKLSBLZXk6IExpY2VuY2VLZXkKICBOYW1lOiBMaWNlbmNlIEtleQogIFNlYXJjaGFibGU6IDEKICBJbnB1dDoKICAgIFR5cGU6IFRleHQKICAgIFNpemU6IDUwCiAgICBNYXhMZW5ndGg6IDUwCiAgICBSZXF1aXJlZDogMQogIENvdW50TWluOiAwCiAgQ291bnRNYXg6IDEwMAogIENvdW50RGVmYXVsdDogMAogIFN1YjoKICAtIEtleTogUXVhbnRpdHkKICAgIE5hbWU6IFF1YW50aXR5CiAgICBJbnB1dDoKICAgICAgVHlwZTogSW50ZWdlcgogICAgICBWYWx1ZU1pbjogMQogICAgICBWYWx1ZU1heDogMTAwMAogICAgICBWYWx1ZURlZmF1bHQ6IDEKICAgICAgUmVxdWlyZWQ6IDEKICAgIENvdW50TWluOiAwCiAgICBDb3VudE1heDogMQogICAgQ291bnREZWZhdWx0OiAwCiAgLSBLZXk6IEV4cGlyYXRpb25EYXRlCiAgICBOYW1lOiBFeHBpcmF0aW9uIERhdGUKICAgIElucHV0OgogICAgICBUeXBlOiBEYXRlCiAgICAgIFJlcXVpcmVkOiAxCiAgICAgIFllYXJQZXJpb2RQYXN0OiAyMAogICAgICBZZWFyUGVyaW9kRnV0dXJlOiAxMAogICAgQ291bnRNaW46IDAKICAgIENvdW50TWF4OiAxCiAgICBDb3VudERlZmF1bHQ6IDAKCi0gS2V5OiBNZWRpYQogIE5hbWU6IE1lZGlhCiAgSW5wdXQ6CiAgICBUeXBlOiBUZXh0CiAgICBTaXplOiA0MAogICAgTWF4TGVuZ3RoOiAyMAoKLSBLZXk6IE5vdGUKICBOYW1lOiBOb3RlCiAgU2VhcmNoYWJsZTogMQogIElucHV0OgogICAgVHlwZTogVGV4dEFyZWEKICAgIFJlcXVpcmVkOiAxCiAgQ291bnRNaW46IDAKICBDb3VudE1heDogMQogIENvdW50RGVmYXVsdDogMAo=",
        "dynamicfield_definition" : "LS0tIHt9Cg==",
        "version" : 1,
        "create_time" : "2023-07-13T10:25:59.000Z",
        "create_by" : 1
    }
]}
END_JSON

    my $JSONObject = $Kernel::OM->Get('Kernel::System::JSON');
    my $Thawed     = $JSONObject->Decode( Data => $JSON );

    # configitem_definition and dynamicfield_definition are stored as LONGBLOB
    # in the database. Dumping the binary content breaks the JSON export,
    # therefore these colums are serialized as base64.
    for my $Row ( $Thawed->{configitem_definition}->@* ) {
        $Row->{configitem_definition}   = decode_base64( $Row->{configitem_definition} );
        $Row->{dynamicfield_definition} = decode_base64( $Row->{dynamicfield_definition} );
    }

    # return the arrayref
    return $Thawed->{configitem_definition};
}

done_testing;

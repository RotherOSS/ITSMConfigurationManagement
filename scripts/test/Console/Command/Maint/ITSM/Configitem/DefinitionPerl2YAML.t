# --
# OTOBO is a web-based ticketing system for service organisations.
# --
# Copyright (C) 2001-2020 OTRS AG, https://otrs.com/
# Copyright (C) 2019-2020 Rother OSS GmbH, https://otobo.de/
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

## no critic (Modules::RequireExplicitPackage)
use strict;
use warnings;
use utf8;

use vars (qw($Self));

use Kernel::Language qw(Translatable);

$Kernel::OM->ObjectParamAdd(
    'Kernel::System::UnitTest::Helper' => {
        RestoreDatabase => 1,
    },
);
my $Helper = $Kernel::OM->Get('Kernel::System::UnitTest::Helper');

my $TestUserLogin = $Helper->TestUserCreate(
    Groups => [ 'admin', 'users' ],
);
my $UserID = $Kernel::OM->Get('Kernel::System::User')->UserLookup( UserLogin => $TestUserLogin );

my $RandomID = $Helper->GetRandomID();

my $ClassID = $Kernel::OM->Get('Kernel::System::GeneralCatalog')->ItemAdd(
    Class   => 'ITSM::ConfigItem::Class',
    Name    => $RandomID,
    ValidID => 1,
    UserID  => $UserID,
);
$Self->True(
    $ClassID,
    "Class added to GeneralCatalog",
);

my $Version = 1;

my $PerlDefinition = << 'EOF';
[
    {
        Key        => 'Vendor',
        Name       => Translatable('Vendor'),
        Searchable => 1,
        Input      => {
            Type      => 'Text',
            Size      => 50,
            MaxLength => 50,
        },
        CountMin     => 1,
        CountMax     => 1,
        CountDefault => 1,
    },
]
EOF

my $DBObject = $Kernel::OM->Get('Kernel::System::DB');

return if !$DBObject->Do(
    SQL => '
        INSERT INTO configitem_definition
            (class_id, configitem_definition, version, create_time, create_by)
        VALUES
            (?, ?, ?, current_timestamp, ?)',
    Bind => [ \$ClassID, \$PerlDefinition, \$Version, \$UserID ],
);

return if !$DBObject->Prepare(
    SQL => '
        SELECT id
        FROM configitem_definition
        WHERE class_id = ?
            AND version = ?
        ORDER BY version DESC',
    Bind  => [ \$ClassID, \$Version ],
    Limit => 1,
);

my $DefinitionID;
while ( my @Row = $DBObject->FetchrowArray() ) {
    $DefinitionID = $Row[0];
}

my $GetDefinition = sub {
    my %Param = @_;

    return if !$DBObject->Prepare(
        SQL => '
            SELECT configitem_definition
            FROM configitem_definition
            WHERE id = ?
            ORDER BY version DESC',
        Bind  => [ \$Param{DefinitionID} ],
        Limit => 1,
    );

    my $Definition;
    while ( my @Row = $DBObject->FetchrowArray() ) {
        $Definition = $Row[0];
    }
    return $Definition;
};

my $Definition = $GetDefinition->( DefinitionID => $DefinitionID );

$Self->IsDeeply(
    $Definition,
    $PerlDefinition,
    "Definition before run (Perl)",
);

my $CommandObject = $Kernel::OM->Get('Kernel::System::Console::Command::Maint::ITSM::Configitem::DefinitionPerl2YAML');

my ( $Result, $ExitCode );

{
    local *STDOUT;
    open STDOUT, '>:utf8', \$Result;    ## no critic
    $ExitCode = $CommandObject->Execute();
}

$Self->Is(
    $ExitCode,
    0,
    "Command exit code",
);

$Definition = $GetDefinition->( DefinitionID => $DefinitionID );

my $YAMLDefinition = $Kernel::OM->Get('Kernel::System::YAML')->Dump(
    Data => eval $PerlDefinition,    ## no critic
);

$Self->IsDeeply(
    $Definition,
    $YAMLDefinition,
    "Definition before run (YAML)",
);

1;

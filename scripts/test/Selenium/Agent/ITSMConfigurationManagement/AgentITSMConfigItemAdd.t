# --
# OTOBO is a web-based ticketing system for service organisations.
# --
# Copyright (C) 2001-2020 OTRS AG, https://otrs.com/
# Copyright (C) 2019-2021 Rother OSS GmbH, https://otobo.de/
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

use strict;
use warnings;
use utf8;

use vars (qw($Self));

# get selenium object
my $Selenium = $Kernel::OM->Get('Kernel::System::UnitTest::Selenium');

$Selenium->RunTest(
    sub {

        # get helper object
        my $Helper = $Kernel::OM->Get('Kernel::System::UnitTest::Helper');

        # get catalog class IDs
        my @ConfigItemClassIDs;
        my @ConfigItemClassNames;
        for my $ConfigItemClass (qw(Computer Hardware Location Network Software)) {
            my $ConfigItemDataRef = $Kernel::OM->Get('Kernel::System::GeneralCatalog')->ItemGet(
                Class => 'ITSM::ConfigItem::Class',
                Name  => $ConfigItemClass,
            );
            push @ConfigItemClassIDs,   $ConfigItemDataRef->{ItemID};
            push @ConfigItemClassNames, $ConfigItemDataRef->{Name};
        }

        # create test user and login
        my $TestUserLogin = $Helper->TestUserCreate(
            Groups => [ 'admin', 'itsm-configitem' ],
        ) || die "Did not get test user";

        $Selenium->Login(
            Type     => 'Agent',
            User     => $TestUserLogin,
            Password => $TestUserLogin,
        );

        # get script alias
        my $ScriptAlias = $Kernel::OM->Get('Kernel::Config')->Get('ScriptAlias');

        # navigate to AgentITSMConfigItemAdd
        $Selenium->VerifiedGet("${ScriptAlias}index.pl?Action=AgentITSMConfigItemAdd");

        # check for ITSMConfigItem classes
        for my $ConfigItemClassName (@ConfigItemClassNames) {
            $Self->True(
                index( $Selenium->get_page_source(), $ConfigItemClassName ) > -1,
                "ConfigItem class $ConfigItemClassName - found",
            );
        }

        # check for links to 'Add' new item for each class
        for my $ConfigItemClassAdd (@ConfigItemClassIDs) {
            my $Success = $Selenium->find_element(
                "//a[contains(\@href, \'AgentITSMConfigItemEdit;ClassID=$ConfigItemClassAdd' )]"
            );
            $Self->True(
                $Success,
                "ConfigItem ID $ConfigItemClassAdd add link - found",
            );
        }
    }
);

1;

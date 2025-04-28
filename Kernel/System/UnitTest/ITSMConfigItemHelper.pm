# --
# OTOBO is a web-based ticketing system for service organisations.
# --
# Copyright (C) 2001-2020 OTRS AG, https://otrs.com/
# Copyright (C) 2019-2025 Rother OSS GmbH, https://otobo.io/
# --
# $origin: otobo - 4dade81e7e04433cb2aed36af0c8727d822a1c61 - Kernel/System/UnitTest/Helper.pm
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

package Kernel::System::UnitTest::ITSMConfigItemHelper;

use v5.24;
use strict;
use warnings;
use namespace::autoclean;
use utf8;

# core modules

# CPAN modules
use Test2::V0;
use Test2::API qw/context run_subtest/;

# OTOBO modules
use Kernel::System::VariableCheck qw(:all);

our @ObjectDependencies = (
    'Kernel::Config',
    'Kernel::System::GeneralCatalog',
    'Kernel::System::Group',
    'Kernel::System::ITSMConfigItem',
    'Kernel::System::Main',
    'Kernel::System::UnitTest::Helper',
    'Kernel::System::YAML',
);

=head1 NAME

Kernel::System::UnitTest::ITSMConfigItemHelper - unit test helper functions related to CMDB

=head2 DESCRIPTION

To be used in test scripts. Cleanup will be triggered in the END block.

=head1 METHODS

=head2 new()

construct a helper object.

    use Kernel::System::UnitTest::RegisterOM;    # Set up $Kernel::OM

    # Do not call Kernel::System::UnitTest::ITSMConfigItemHelper->new(),
    # instead pass params via the ObjectManager.
    $Kernel::OM->ObjectParamAdd(
        'Kernel::System::UnitTest::ITSMConfigItemHelper' => {
            RestoreDatabase => 1,    # runs the test in a transaction,
                                     # and roll it back in the destructor
                                     #
                                     # NOTE: Rollback does not work for
                                     # changes in the database layout. If you
                                     # want to do this in your tests, you cannot
                                     # use this option and must handle the rollback
                                     # yourself.
        },
    );

    my $Helper = $Kernel::OM->Get('Kernel::System::UnitTest::ITSMConfigItemHelper');

Valid parameters are:

=over 4

=item SkipSSLVerify

Unset C<$ENV{PERL_LWP_SSL_VERIFY_HOSTNAME}> while this instance exists.

=item UseTmpArticleDir

=item RestoreDatabase

=item DisableAsyncCalls

=back

=cut

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = bless {}, $Type;

    # find out whether loader files are stored in S3 or in the file system
    $Self->{S3Active} = $Kernel::OM->Get('Kernel::Config')->Get('Storage::S3::Active') ? 1 : 0;

    # Remove any leftover custom files from aborted previous runs.
    $Kernel::OM->Get('Kernel::System::UnitTest::Helper')->CustomFileCleanup();

    # set environment variable to skip SSL certificate verification if needed
    if ( $Param{SkipSSLVerify} ) {

        # remember original value, so that it can be reset in DESTROY()
        $Self->{PERL_LWP_SSL_VERIFY_HOSTNAME} = $ENV{PERL_LWP_SSL_VERIFY_HOSTNAME};

        # set environment value to 0
        $ENV{PERL_LWP_SSL_VERIFY_HOSTNAME} = 0;    ## no critic qw(Variables::RequireLocalizedPunctuationVars)

        $Self->{RestoreSSLVerify} = 1;
    }

    # switch article dir to a temporary one to avoid collisions
    if ( $Param{UseTmpArticleDir} ) {
        $Self->UseTmpArticleDir();
    }

    if ( $Param{RestoreDatabase} ) {
        $Self->{RestoreDatabase} = 1;
        $Self->BeginWork();
    }

    if ( $Param{DisableAsyncCalls} ) {
        $Self->DisableAsyncCalls();
    }

    return $Self;
}

=head2 TestConfigItemClassCreate()

creates a test config item class that can be used in tests. Returns
the class id of the new config item class.

    my $TestCIClassName = $Helper->TestConfigItemClassCreate(
        Name                => 'SomeClassName',     # optional, randomly generated if not given
        VersionStringModule => ,                    # optional, default is 'Incremental'
        VersionTrigger      => ,                    # optional, default is ''
        DynamicFields       => ,                    # optional
        Definition          => ,                    # optional
    );

=cut

sub TestConfigItemClassCreate {
    my ( $Self, %Param ) = @_;

    my $Context = context();

    # create random suffix
    my $TestClassID;
    my $GeneralCatalogObject = $Kernel::OM->Get('Kernel::System::GeneralCatalog');

    # Get config item group id
    my $ConfigItemGroupID = $Kernel::OM->Get('Kernel::System::Group')->GroupLookup(
        Group  => 'itsm-configitem',
        UserID => 1,
    );
    bail_out("Got no group id for group name 'itsm-configitem'") unless $ConfigItemGroupID;

    my $VersionStringModule = [($Param{VersionStringModule} ? $Param{VersionStringModule} : 'Incremental')];
    my $Code = sub {

        COUNT:
        for ( 1 .. 10 ) {

            # generate a random name
            my $TestClassName = $Param{Name} || ('UnitTest' . $Kernel::OM->Get('Kernel::System::UnitTest::Helper')->GetRandomID());

            # add both unittest config item classes
            $TestClassID = $GeneralCatalogObject->ItemAdd(
                Class   => 'ITSM::ConfigItem::Class',
                Name    => $TestClassName,
                ValidID => 1,
                UserID  => 1,
            );

            if ( $TestClassID ) {

                # Set permission.
                $GeneralCatalogObject->GeneralCatalogPreferencesSet(
                    ItemID => $TestClassID,
                    Key    => 'Permission',
                    Value  => [$ConfigItemGroupID],
                );
                note("Set config item class Permission to itsm-configitem");

                # set version string module
                $GeneralCatalogObject->GeneralCatalogPreferencesSet(
                    ItemID => $TestClassID,
                    Key    => 'VersionStringModule',
                    Value  => $VersionStringModule,
                );
                note("Set config item class VersionStringModule to Incremental");

                # set category
                $GeneralCatalogObject->GeneralCatalogPreferencesSet(
                    ItemID => $TestClassID,
                    Key    => 'Categories',
                    Value  => ['Default'],
                );
                note("Set config item class categories to Default");

                # Set version triggers.
                $GeneralCatalogObject->GeneralCatalogPreferencesSet(
                    ItemID => $TestClassID,
                    Key    => 'VersionTrigger',
                    Value  => [ 'Name', 'DeplStateID', 'InciStateID' ],
                );

                my $YAMLObject = $Kernel::OM->Get('Kernel::System::YAML');

                my $YAMLDefinition = $YAMLObject->Dump(
                    Data => eval $Param{Definition},    ## no critic qw(BuiltinFunctions::ProhibitStringyEval)
                );

                # add a definition to the class
                my $Result = $Kernel::OM->Get('Kernel::System::ITSMConfigItem')->DefinitionAdd(
                    ClassID    => $TestClassID,
                    Definition => $YAMLDefinition,
                    UserID     => 1,
                );
                bail_out('Could not add definition for test config item class') unless $Result->{Success};

                last COUNT;
            }

        }

        bail_out('Could not create test config item class') unless $TestClassID;
        pass("Created test config item class $TestClassID");

        # Remember UserID of the test user to later set it to invalid
        #   in the destructor.
        $Self->{TestConfigItemClasses} ||= [];
        push( @{ $Self->{TestConfigItemClasses} }, $TestClassID );
    };

    run_subtest(
        'TestConfigItemClass',
        $Code,
        {
            buffered      => 1,
            inherit_trace => 1
        }
    );

    $Context->release();

    return $TestClassID;
}

sub TestConfigItemCreateClasses {
    my ( $Self, %Param ) = @_;

    my $Context = context();

    my $Home = $Kernel::OM->Get('Kernel::Config')->Get('Home');

    my $GeneralCatalogObject = $Kernel::OM->Get('Kernel::System::GeneralCatalog');
    my $MainObject           = $Kernel::OM->Get('Kernel::System::Main');
    my $YAMLObject           = $Kernel::OM->Get('Kernel::System::YAML');

    # TODO import classes combined from one yaml file as array of classes
    my $Content = $MainObject->FileRead(
        Location => "$Home/scripts/test/sample/ITSMConfigurationManagement/LegacyClasses.yml",
        Mode     => 'utf8',
    );

    my $DefinitionRaw = $YAMLObject->Load(
        Data => ${$Content},
    );

    my $Success = $Kernel::OM->Get('Kernel::System::ITSMConfigItem')->ClassImport(
        Content => $DefinitionRaw,
    );

    $Context->release();

    return 1;
}

1;

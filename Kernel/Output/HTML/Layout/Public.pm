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

package Kernel::Output::HTML::Layout::Public;

use v5.24;
use strict;
use warnings;
use namespace::autoclean;
use utf8;

# core modules
use Digest::MD5 qw(md5_hex);
use Scalar::Util qw(blessed);
use File::Basename qw(fileparse);

# CPAN modules
use URI::Escape qw(uri_escape_utf8);
use Plack::Response ();
use Plack::Util     ();

# OTOBO modules
use Kernel::System::VariableCheck qw(:all);
use Kernel::System::Web::Exception ();
use Kernel::Language qw(Translatable);

our @ObjectDependencies = (
    'Kernel::Config',
    'Kernel::Language',
    'Kernel::System::AuthSession',
    'Kernel::System::Cache',
    'Kernel::System::Chat',
    'Kernel::System::CustomerGroup',
    'Kernel::System::CustomerUser',
    'Kernel::System::DateTime',
    'Kernel::System::Group',
    'Kernel::System::Encode',
    'Kernel::System::HTMLUtils',
    'Kernel::System::JSON',
    'Kernel::System::Log',
    'Kernel::System::Main',
    'Kernel::System::State',
    'Kernel::System::Storable',
    'Kernel::System::SystemMaintenance',
    'Kernel::System::User',
    'Kernel::System::VideoChat',
    'Kernel::System::Web::Request',
    'Kernel::System::Web::Response',
);

=head1 NAME

Kernel::Output::HTML::Layout::Public - Helper functions for public module rendering.

=head1 SYNOPSIS

    # No instances of this class should be created directly.
    # Instead the module is loaded implicitly by Kernel::Output::HTML::Layout
    my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');

=cut

sub PublicHeader {
    my ( $Self, %Param ) = @_;

    my $Type = $Param{Type} || '';

    my $ConfigObject = $Kernel::OM->Get('Kernel::Config');

    my $File = $Param{Filename} || $Self->{Action} || 'unknown';

    # set file name for "save page as"
    $Param{ContentDisposition} = "filename=\"$File.html\"";

    # area and title
    if (
        !$Param{Area}
        && $ConfigObject->Get('PublicFrontend::Module')->{ $Self->{Action} }
        )
    {
        $Param{Area} = $ConfigObject->Get('PublicFrontend::Module')->{ $Self->{Action} }
            ->{NavBarName} || '';
    }
    if (
        !$Param{Title}
        && $ConfigObject->Get('PublicFrontend::Module')->{ $Self->{Action} }
        )
    {
        $Param{Title} = $ConfigObject->Get('PublicFrontend::Module')->{ $Self->{Action} }->{Title}
            || '';
    }
    if (
        !$Param{Area}
        && $ConfigObject->Get('PublicFrontend::Module')->{ $Self->{Action} }
        )
    {
        $Param{Area} = $ConfigObject->Get('PublicFrontend::Module')->{ $Self->{Action} }
            ->{NavBarName} || '';
    }
    if (
        !$Param{Title}
        && $ConfigObject->Get('PublicFrontend::Module')->{ $Self->{Action} }
        )
    {
        $Param{Title} = $ConfigObject->Get('PublicFrontend::Module')->{ $Self->{Action} }->{Title}
            || '';
    }
    for my $Word (qw(Value Title Area)) {
        if ( $Param{$Word} ) {
            $Param{TitleArea} .= $Self->{LanguageObject}->Translate( $Param{$Word} ) . ' - ';
        }
    }

    my $Frontend = 'Public';

    # run header meta modules for public frontends
    my $HeaderMetaModule = $ConfigObject->Get( $Frontend . 'Frontend::HeaderMetaModule' );
    if ( ref $HeaderMetaModule eq 'HASH' ) {
        my %Jobs = %{$HeaderMetaModule};

        my $MainObject = $Kernel::OM->Get('Kernel::System::Main');

        MODULE:
        for my $Job ( sort keys %Jobs ) {

            # load and run module
            next MODULE if !$MainObject->Require( $Jobs{$Job}->{Module} );
            my $Object = $Jobs{$Job}->{Module}->new( %{$Self}, LayoutObject => $Self );
            next MODULE if !$Object;
            $Object->Run( %Param, Config => $Jobs{$Job} );
        }
    }

    # set rtl if needed
    if ( $Self->{TextDirection} && $Self->{TextDirection} eq 'rtl' ) {
        $Param{BodyClass} = 'RTL';
    }
    elsif ( $ConfigObject->Get('Frontend::DebugMode') ) {
        $Self->Block(
            Name => 'DebugRTLButton',
        );
    }

    # define (custom) logo
    my $WebPath = $ConfigObject->Get('Frontend::WebPath');
    $Param{URLSignet} = $WebPath . 'skins/Public/default/img/otobo_signet_w.svg';
    if ( defined $ConfigObject->Get('PublicLogo') ) {
        my %PublicLogo = %{ $ConfigObject->Get('PublicLogo') };

        LOGO:
        for my $Statement (qw(URLSignet)) {
            next LOGO if !$PublicLogo{$Statement};

            if ( $PublicLogo{$Statement} !~ /(http|ftp|https):\//i ) {
                $Param{$Statement} = $WebPath . $PublicLogo{$Statement};
            }
            else {
                $Param{$Statement} = $PublicLogo{$Statement};
            }
        }
    }

    # Generate the minified CSS and JavaScript files
    # and the tags referencing them (see LayoutLoader)
    $Self->LoaderCreateCustomerCSSCalls();

    # Load colors based on Skin selection
    # define color scheme
    $Self->{UserSkin} ||= 'default';
    my $ColorDefinitions;
    if ( $Self->{UserSkin} && $Self->{UserSkin} ne 'default' ) {
        $ColorDefinitions = $ConfigObject->Get("PublicSkinColorDefinition::$Self->{UserSkin}") // $ConfigObject->Get('PublicColorDefinitions');
    }
    else {
        $ColorDefinitions = $ConfigObject->Get('PublicColorDefinitions');
    }

    for my $Color ( sort keys %{$ColorDefinitions} ) {
        $Param{ColorDefinitions} .= "--col$Color:$ColorDefinitions->{ $Color };";
    }

    $Self->_AddHeadersToResponseObject(
        ContentDisposition            => $Param{ContentDisposition},
        DisableIFrameOriginRestricted => $Param{DisableIFrameOriginRestricted},
    );

    # create & return output
    return $Self->Output(
        TemplateFile => "PublicHeader$Type",
        Data         => \%Param,
    );
}

sub PublicFooter {
    my ( $Self, %Param ) = @_;

    my $Type          = $Param{Type}           || '';
    my $HasDatepicker = $Self->{HasDatepicker} || 0;

    # Generate the minified CSS and JavaScript files
    # and the tags referencing them (see LayoutLoader)
    $Self->LoaderCreateCustomerJSCalls();
    $Self->LoaderCreateJavaScriptTranslationData();
    $Self->LoaderCreateJavaScriptTemplateData();

    # get datepicker data, if needed in module
    if ($HasDatepicker) {
        my $VacationDays  = $Self->DatepickerGetVacationDays();
        my $TextDirection = $Self->{LanguageObject}->{TextDirection} || '';

        # send data to JS
        $Self->AddJSData(
            Key   => 'Datepicker',
            Value => {
                VacationDays => $VacationDays,
                IsRTL        => ( $TextDirection eq 'rtl' ) ? 1 : 0,
            },
        );
    }

    my $ConfigObject = $Kernel::OM->Get('Kernel::Config');

    # Check if video chat is enabled.
    if ( $Kernel::OM->Get('Kernel::System::Main')->Require( 'Kernel::System::VideoChat', Silent => 1 ) ) {
        $Param{VideoChatEnabled} = $Kernel::OM->Get('Kernel::System::VideoChat')->IsEnabled()
            || $Kernel::OM->Get('Kernel::System::Web::Request')->GetParam( Param => 'UnitTestMode' ) // 0;
    }

    # Check if public user has permission for chat.
    my $PublicChatPermission;
    if ( $Kernel::OM->Get('Kernel::System::Main')->Require( 'Kernel::System::Chat', Silent => 1 ) ) {

        my $PublicChatConfig = $ConfigObject->Get('PublicFrontend::Module')->{'PublicChat'} || {};
        $PublicChatPermission = 1;
    }

    # AutoComplete-Config
    my $AutocompleteConfig = $ConfigObject->Get('AutoComplete::Public');

    for my $ConfigElement ( sort keys %{$AutocompleteConfig} ) {
        $AutocompleteConfig->{$ConfigElement}->{ButtonText}
            = $Self->{LanguageObject}->Translate( $AutocompleteConfig->{$ConfigElement}{ButtonText} );
    }

    my $WebPath = $ConfigObject->Get('Frontend::WebPath');

    # Load rich text libraries only when a RTE has been set up
    if ( $Self->{HasRichTextEditor} ) {

        # ckeditor.js is always loaded when rich text is enabled
        $Self->Block(
            Name => 'RichTextJS',
            Data => {
                JSDirectory => '',
                Filename    => 'ckeditor.js',
            },
        );

        # assemble the path to the translation file based on the relevant URLs
        my $RichTextPath = $ConfigObject->Get('Frontend::RichTextPath');
        if ( $RichTextPath && $WebPath ) {
            my $Home = $ConfigObject->Get('Home');
            $RichTextPath =~ s/$WebPath//s;
            my $TranslationFile = lc "$Self->{UserLanguage}.js";
            $TranslationFile =~ s/_/-/g;
            my $TranslationFullPath = File::Spec->catfile(
                $Home,
                'var/httpd/htdocs',
                $RichTextPath,
                'translations',
                $TranslationFile
            );

            # load the translation file only if it exists
            if ( -f $TranslationFullPath ) {
                $Self->Block(
                    Name => 'RichTextTranslationJS',
                    Data => {
                        JSDirectory => 'translations/',
                        Filename    => $TranslationFile,
                    },
                );
            }
        }
    }

    # add JS data
    my %JSConfig = (
        Baselink                 => $Self->{Baselink},
        CGIHandle                => $Self->{CGIHandle},
        WebPath                  => $WebPath,
        Action                   => $Self->{Action},
        Subaction                => $Self->{Subaction},
        SessionIDCookie          => $Self->{SessionIDCookie},
        SessionName              => $Self->{SessionName},
        SessionID                => $Self->{SessionID},
        SessionUseCookie         => $ConfigObject->Get('SessionUseCookie'),
        ChallengeToken           => $Self->{UserChallengeToken},
        CustomerPanelSessionName => $ConfigObject->Get('CustomerPanelSessionName'),    # Borrow the Customer configuration
        UserLanguage             => $Self->{UserLanguage},
        CheckEmailAddresses      => $ConfigObject->Get('CheckEmailAddresses'),
        InputFieldsActivated     => 1,
        Autocomplete             => $AutocompleteConfig,
        VideoChatEnabled         => $Param{VideoChatEnabled},
        WebMaxFileUpload         => $ConfigObject->Get('WebMaxFileUpload'),
        PublicChatPermission     => $PublicChatPermission,
    );

    for my $Config ( sort keys %JSConfig ) {
        $Self->AddJSData(
            Key   => $Config,
            Value => $JSConfig{$Config},
        );
    }

    # create & return output
    return $Self->Output(
        TemplateFile => "PublicFooter$Type",
        Data         => \%Param,
    );
}

1;

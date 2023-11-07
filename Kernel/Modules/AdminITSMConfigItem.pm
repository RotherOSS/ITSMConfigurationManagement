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

package Kernel::Modules::AdminITSMConfigItem;

use v5.24;
use strict;
use warnings;
use namespace::autoclean;
use utf8;

# core modules

# CPAN modules

# OTOBO modules
use Kernel::System::VariableCheck qw(IsHashRefWithData);

our $ObjectManagerDisabled = 1;

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    return bless {%Param}, $Type;
}

sub Run {
    my ( $Self, %Param ) = @_;

    # get needed objecs
    my $GeneralCatalogObject = $Kernel::OM->Get('Kernel::System::GeneralCatalog');
    my $LayoutObject         = $Kernel::OM->Get('Kernel::Output::HTML::Layout');

    # get class list and check it
    my $ClassList = $GeneralCatalogObject->ItemList(
        Class => 'ITSM::ConfigItem::Class',
    );

    return $LayoutObject->ErrorScreen unless $ClassList;
    return $LayoutObject->ErrorScreen unless ref $ClassList eq 'HASH';
    return $LayoutObject->ErrorScreen unless $ClassList->%*;

    # get needed objects
    my $ParamObject      = $Kernel::OM->Get('Kernel::System::Web::Request');
    my $ConfigItemObject = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');
    my $UserObject       = $Kernel::OM->Get('Kernel::System::User');

    # ------------------------------------------------------------ #
    # list of the versions of the definition of a config item class
    # ------------------------------------------------------------ #
    if ( $Self->{Subaction} eq 'DefinitionList' ) {

        # get class id
        my $ClassID = $ParamObject->GetParam( Param => 'ClassID' );

        return $LayoutObject->Redirect( OP => "Action=$Self->{Action}" ) unless $ClassID;

        # show sidebar, activate the 'Overview' block
        $Self->_ShowSidebar(
            Original         => \%Param,
            ClassList        => $ClassList,
            RoleList         => $RoleList,
            ShowOverviewLink => 1,
        );

        # output overview result
        $LayoutObject->Block(
            Name => 'DefinitionList',
        );

        # get definition list
        my $DefinitionList = $ConfigItemObject->DefinitionList(
            ClassID => $ClassID,
        );

        for my $Definition ( reverse $DefinitionList->@* ) {

            # get user data
            my $FullName = $UserObject->UserName(
                UserID => $Definition->{CreateBy},
            );

            # output definition
            $LayoutObject->Block(
                Name => 'DefinitionListRow',
                Data => {
                    $Definition->%*,
                    Class        => $ClassList->{$ClassID},
                    CreateByUser => $FullName,
                },
            );
        }

        # generate output
        return join '',
            $LayoutObject->Header,
            $LayoutObject->NavigationBar,
            $LayoutObject->Output(
                TemplateFile => 'AdminITSMConfigItem',
                Data         => \%Param,
            ),
            $LayoutObject->Footer;
    }


    # ------------------------------------------------------------ #
    # class definition view
    # ------------------------------------------------------------ #
    if ( $Self->{Subaction} eq 'DefinitionView' ) {

        # get definition id
        my $DefinitionID = $ParamObject->GetParam( Param => 'DefinitionID' );

        return $LayoutObject->Redirect( OP => "Action=$Self->{Action}" ) unless $DefinitionID;

        # get definition
        my $Definition = $ConfigItemObject->DefinitionGet(
            DefinitionID => $DefinitionID,
        );

        # show sidebar, activate the 'Overview' block
        $Self->_ShowSidebar(
            Original      => \%Param,
            ClassList     => $ClassList,
            RoleList      => $RoleList,
            ClassSelected => {
                ID   => $Definition->{ClassID},
                Name => $Definition->{Class},
            },
            ClassVersionSelected => {
                ID      => $DefinitionID,
                Version => $Definition->{Version},
            },
            ShowOverviewLink => 1,
        );

        $Definition->{DefinitionString} = $LayoutObject->Ascii2Html(
            Text => $Definition->{Definition},
        );

        my $UserName = $UserObject->UserName(
            UserID => $Definition->{CreateBy},
        );

        # output overview result
        $LayoutObject->Block(
            Name => 'DefinitionView',
            Data => {
                $Definition->%*,
                CreateByUser => $UserName,
            },
        );

        # generate output
        return join '',
            $LayoutObject->Header,
            $LayoutObject->NavigationBar,
            $LayoutObject->Output(
                TemplateFile => 'AdminITSMConfigItem',
                Data         => \%Param,
            ),
            $LayoutObject->Footer;
    }

    # ------------------------------------------------------------ #
    # class definition change
    # ------------------------------------------------------------ #
    if ( $Self->{Subaction} eq 'DefinitionChange' ) {

        # get class id
        my $ClassID = $ParamObject->GetParam( Param => 'ClassID' );

        return $LayoutObject->Redirect( OP => "Action=$Self->{Action}" ) unless $ClassID;

        # get class definition
        my $Definition = $ConfigItemObject->DefinitionGet(
            ClassID => $ClassID,
        );

        # show sidebar, activate the 'Overview' block
        $Self->_ShowSidebar(
            Original      => \%Param,
            ClassList     => $ClassList,
            RoleList      => $RoleList,
            ClassSelected => {
                ID   => $Definition->{ClassID},
                Name => $Definition->{Class},
            },
            Edit             => 1,
            ShowOverviewLink => 1,
        );

        # output overview result
        $LayoutObject->Block(
            Name => 'DefinitionChange',
            Data => {
                %{$Definition},
                ClassID => $ClassID,
                Class   => $ClassList->{$ClassID},
                Rows    =>
                    $Kernel::OM->Get('Kernel::Config')->Get("ITSMConfigItem::Frontend::$Self->{Action}")->{EditorRows}
                    || 30,
            },
        );

        # generate output
        return join '',
            $LayoutObject->Header,
            $LayoutObject->NavigationBar,
            $LayoutObject->Output(
                TemplateFile => 'AdminITSMConfigItem',
                Data         => \%Param,
            ),
            $LayoutObject->Footer;
    }


    # ------------------------------------------------------------ #
    # class definition save
    # ------------------------------------------------------------ #
    if ( $Self->{Subaction} eq 'DefinitionSave' ) {
        my %Definition;

        # get params
        for my $FormParam (qw(ClassID Definition)) {
            $Definition{$FormParam} = $ParamObject->GetParam( Param => $FormParam ) || '';
        }
        for my $FormParam (qw(ClassID Definition)) {
            if ( !$Definition{$FormParam} ) {
                $Kernel::OM->Get('Kernel::System::Log')->Log(
                    Priority => 'error',
                    Message  => "Need $FormParam!"
                );
                return $LayoutObject->Redirect( OP => "Action=$Self->{Action}" );
            }
        }

        # Validate YAML code by converting it to Perl.
        my $DefinitionRef = $Kernel::OM->Get('Kernel::System::YAML')->Load(
            Data => $Definition{Definition},
        );

        return $LayoutObject->ErrorScreen unless ref $DefinitionRef eq 'HASH';

        # add to database
        my $Result = $ConfigItemObject->DefinitionAdd(
            %Definition,
            UserID => $Self->{UserID},
        );

        # display change screen with error if check failed
        if ( IsHashRefWithData($Result) && $Result->{Error} ) {

            my %Error = (
                Error        => $Result->{Error},
                ErrorClasses => 'ServerError Error',
            );

            # show sidebar, activate the 'Overview' block
            $Self->_ShowSidebar(
                Original      => \%Param,
                ClassList     => $ClassList,
                RoleList      => $RoleList,
                ClassSelected => {
                    ID   => $Definition{ClassID},
                    Name => $ClassList->{ $Definition{ClassID} },
                },
                Edit             => 1,
                ShowOverviewLink => 1,
            );

            # output overview result
            $LayoutObject->Block(
                Name => 'DefinitionChange',
                Data => {
                    %Definition,
                    %Error,
                    ClassID => $Definition{ClassID},
                    Class   => $ClassList->{ $Definition{ClassID} },
                    Rows    =>
                        $Kernel::OM->Get('Kernel::Config')->Get("ITSMConfigItem::Frontend::$Self->{Action}")->{EditorRows}
                        || 30,
                },
            );

            # output header
            # generate output
            return join '',
                $LayoutObject->Header,
                $LayoutObject->NavigationBar,
                $LayoutObject->Output(
                    TemplateFile => 'AdminITSMConfigItem',
                    Data         => {
                        %Param,
                    },
                ),
                $LayoutObject->Footer;
        }

        my $ContinueAfterSave = $ParamObject->GetParam( Param => 'ContinueAfterSave' );
        if ($ContinueAfterSave) {
            return $LayoutObject->Redirect(
                OP => "Action=$Self->{Action};Subaction=DefinitionChange;ClassID=$Definition{ClassID}",
            );
        }

        return $LayoutObject->Redirect( OP => "Action=$Self->{Action}" );
    }

    # ------------------------------------------------------------ #
    # config item class overview is the default
    # ------------------------------------------------------------ #
    if (1) {

        # show sidebar, activate the 'Overview' block
        $Self->_ShowSidebar(
            Original         => \%Param,
            ClassList        => $ClassList,
            RoleList         => $RoleList,
            ShowOverviewLink => 0,
        );

        # output overview result, for roles and definitions
        $LayoutObject->Block(
            Name => 'OverviewList',
        );

        for my $ClassID ( sort { $ClassList->{$a} cmp $ClassList->{$b} } keys $ClassList->%* ) {

            $LayoutObject->Block(
                Name => 'OverviewListRow',
                Data => {
                    ClassID => $ClassID,
                    Name    => $ClassList->{$ClassID},
                },
            );
        }

        # generate output
        return join '',
            $LayoutObject->Header,
            $LayoutObject->NavigationBar,
            $LayoutObject->Output(
                TemplateFile => 'AdminITSMConfigItem',
                Data         => $Param{Original},
            ),
            $LayoutObject->Footer;
    }
}

sub _ShowSidebar {
    my ( $Self, %Param ) = @_;

    my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');
    my $ParamObject  = $Kernel::OM->Get('Kernel::System::Web::Request');

    # generate RoleOptionStrg and ClassOptionStrg which are needed for the sidebox
    my $RoleID         = $Param{RoleSelected} ? $Param{RoleSelected}->{ID} : $ParamObject->GetParam( Param => 'RoleID' );
    my $RoleOptionStrg = $LayoutObject->BuildSelection(
        Data         => $Param{RoleList},
        Name         => 'RoleID',
        SelectedID   => $RoleID,
        PossibleNone => 1,
        Translation  => 0,
        Class        => 'Modernize',
    );
    my $ClassID         = $Param{ClassSelected} ? $Param{ClassSelected}->{ID} : $ParamObject->GetParam( Param => 'ClassID' );
    my $ClassOptionStrg = $LayoutObject->BuildSelection(
        Data         => $Param{ClassList},
        Name         => 'ClassID',
        SelectedID   => $ClassID,
        PossibleNone => 1,
        Translation  => 0,
        Class        => 'Modernize',
    );

    # this will be passed to the Overview block
    my %BlockData = (
        RoleOptionStrg  => $RoleOptionStrg,
        ClassOptionStrg => $ClassOptionStrg,
    );

    # there might be additional data for the Overview block
    KEY:
    for my $Key (qw(ClassSelected ClassVersionSelected RoleSelected RoleVersionSelected Edit)) {
        next KEY unless defined $Param{$Key};

        $BlockData{$Key} = $Param{$Key};
    }

    # the Overview block is the complete page
    $LayoutObject->Block(
        Name => 'Overview',
        Data => \%BlockData,
    );

    if ( $Param{ShowOverviewLink} ) {
        $LayoutObject->Block(
            Name => 'ActionOverview',
        );
    }

    return 1;
}

1;

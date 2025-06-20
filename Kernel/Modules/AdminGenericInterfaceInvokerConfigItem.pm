# --
# OTOBO is a web-based ticketing system for service organisations.
# --
# Copyright (C) 2001-2020 OTRS AG, https://otrs.com/
# Copyright (C) 2019-2025 Rother OSS GmbH, https://otobo.io/
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

package Kernel::Modules::AdminGenericInterfaceInvokerConfigItem;

use v5.24;
use strict;
use warnings;
use namespace::autoclean;

# core modules

# CPAN modules

# OTOBO modules
use Kernel::System::VariableCheck qw(:all);
use Kernel::Language              qw(Translatable);

our $ObjectManagerDisabled = 1;

sub new {
    my ( $Type, %Param ) = @_;

    return bless {%Param}, $Type;
}

sub Run {
    my ( $Self, %Param ) = @_;

    my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');

    my $WebserviceID = $Kernel::OM->Get('Kernel::System::Web::Request')->GetParam( Param => 'WebserviceID' );
    if ( !IsStringWithData($WebserviceID) ) {
        return $LayoutObject->ErrorScreen(
            Message => Translatable('Need WebserviceID!'),
        );
    }

    $LayoutObject->AddJSData(
        Key   => 'WebserviceID',
        Value => $WebserviceID
    );

    my $WebserviceData = $Kernel::OM->Get('Kernel::System::GenericInterface::Webservice')->WebserviceGet(
        ID => $WebserviceID,
    );

    if ( !IsHashRefWithData($WebserviceData) ) {
        return $LayoutObject->ErrorScreen(
            Message =>
                $LayoutObject->{LanguageObject}->Translate( 'Could not get data for WebserviceID %s', $WebserviceID ),
        );
    }

    $Self->_ExtraSettings(
        Webservice => $WebserviceData->{Name},
    );

    if ( $Self->{Subaction} eq 'Add' ) {
        return $Self->_Add(
            %Param,
            WebserviceID   => $WebserviceID,
            WebserviceData => $WebserviceData,
        );
    }
    elsif ( $Self->{Subaction} eq 'AddAction' ) {

        # Challenge token check for write action.
        $LayoutObject->ChallengeTokenCheck();

        return $Self->_AddAction(
            %Param,
            WebserviceID   => $WebserviceID,
            WebserviceData => $WebserviceData,
        );
    }
    elsif ( $Self->{Subaction} eq 'Change' ) {
        return $Self->_Change(
            %Param,
            WebserviceID   => $WebserviceID,
            WebserviceData => $WebserviceData,
        );
    }
    elsif ( $Self->{Subaction} eq 'ChangeAction' ) {

        # Challenge token check for write action.
        $LayoutObject->ChallengeTokenCheck();

        return $Self->_ChangeAction(
            %Param,
            WebserviceID   => $WebserviceID,
            WebserviceData => $WebserviceData,
        );
    }
    elsif ( $Self->{Subaction} eq 'DeleteAction' ) {

        # Challenge token check for write action.
        $LayoutObject->ChallengeTokenCheck();

        return $Self->_DeleteAction(
            %Param,
            WebserviceID   => $WebserviceID,
            WebserviceData => $WebserviceData,
        );
    }
    elsif ( $Self->{Subaction} eq 'AddEvent' ) {

        # Challenge token check for write action.
        $LayoutObject->ChallengeTokenCheck();

        return $Self->_AddEvent(
            %Param,
            WebserviceID   => $WebserviceID,
            WebserviceData => $WebserviceData,
        );
    }
    elsif ( $Self->{Subaction} eq 'DeleteEvent' ) {

        # Challenge token check for write action.
        $LayoutObject->ChallengeTokenCheck();

        return $Self->_DeleteEvent(
            %Param,
            WebserviceID   => $WebserviceID,
            WebserviceData => $WebserviceData,
        );
    }

    return $LayoutObject->ErrorScreen(
        Message => Translatable('Invalid Subaction!'),
    );
}

sub _Add {
    my ( $Self, %Param ) = @_;

    my $GetParam = $Self->_ParamsGet(
        Definition => [
            {
                Name      => 'InvokerType',
                Type      => 'String',
                Mandatory => 1,
                Check     => 'InvokerType',
            },
        ],
    );
    if ( $GetParam->{Error} ) {
        return $Kernel::OM->Get('Kernel::Output::HTML::Layout')->ErrorScreen(
            Message => $GetParam->{Error},
        );
    }

    return $Self->_ShowScreen(
        %Param,
        Mode          => 'Add',
        InvokerConfig => {
            Type => $GetParam->{InvokerType},
        },
    );
}

sub _AddAction {
    my ( $Self, %Param ) = @_;

    my @ExtraParams;
    for my $Section (qw/General Request Response/) {
        if ( $Self->{Settings} && $Self->{Settings}{$Section} ) {
            push @ExtraParams, $Self->{Settings}{$Section}->@*;
        }
    }

    my $GetParam = $Self->_ParamsGet(
        Definition => [
            {
                Name      => 'InvokerType',
                Type      => 'String',
                Mandatory => 1,
                Check     => 'InvokerType',
            },
            {
                Name    => 'Invoker',
                Type    => 'String',
                Default => '',
            },
            {
                Name    => 'Description',
                Type    => 'String',
                Default => '',
            },
            {
                Name  => 'MappingInbound',
                Type  => 'String',
                Check => 'MappingType',
            },
            {
                Name  => 'MappingOutbound',
                Type  => 'String',
                Check => 'MappingType',
            },
            @ExtraParams,
        ],
    );

    my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');
    if ( $GetParam->{Error} ) {
        return $LayoutObject->ErrorScreen(
            Message => $GetParam->{Error},
        );
    }

    my $WebserviceData = $Param{WebserviceData};
    my %Errors;
    if ( !IsStringWithData( $GetParam->{Invoker} ) ) {
        $Errors{InvokerServerError} = 'ServerError';
    }

    # Invoker with same name already exists.
    elsif ( IsHashRefWithData( $WebserviceData->{Config}->{Requester}->{Invoker}->{ $GetParam->{Invoker} } ) ) {
        $Errors{InvokerServerError} = 'ServerError';
    }

    my $InvokerConfig = {
        Description => $GetParam->{Description},
        Type        => $GetParam->{InvokerType},
    };

    for my $ParamConfig (@ExtraParams) {
        if ( exists $ParamConfig->{ErrorFunction} ) {
            my $Error = $ParamConfig->{ErrorFunction}->(
                %Param,
                GetParam => $GetParam,
            );

            if ($Error) {
                $Errors{ $ParamConfig->{Name} . 'ServerError' } = $Error;
            }
        }

        $InvokerConfig->{ $ParamConfig->{Name} } = $GetParam->{ $ParamConfig->{Name} };
    }

    # Validation errors.
    if (%Errors) {
        return $Self->_ShowScreen(
            %Param,
            %{$GetParam},
            %Errors,
            Mode          => 'Add',
            InvokerConfig => $InvokerConfig,
        );
    }

    DIRECTION:
    for my $Direction (qw(MappingInbound MappingOutbound)) {
        next DIRECTION if !$GetParam->{$Direction};

        # Mapping added, initialize with empty config.
        $InvokerConfig->{$Direction} = {
            Type => $GetParam->{$Direction},
        };
    }

    $WebserviceData->{Config}->{Requester}->{Invoker}->{ $GetParam->{Invoker} } = $InvokerConfig;

    my $UpdateSuccess = $Kernel::OM->Get('Kernel::System::GenericInterface::Webservice')->WebserviceUpdate(
        %{$WebserviceData},
        UserID => $Self->{UserID},
    );
    if ( !$UpdateSuccess ) {
        return $LayoutObject->ErrorScreen(
            Message => Translatable('Could not update web service'),
        );
    }

    my $RedirectURL =
        'Action='
        . $Self->{Action}
        . ';Subaction=Change;WebserviceID='
        . $Param{WebserviceID}
        . ';Invoker='
        . $LayoutObject->LinkEncode( $GetParam->{Invoker} )
        . ';';

    return $LayoutObject->Redirect(
        OP => $RedirectURL,
    );
}

sub _Change {
    my ( $Self, %Param ) = @_;

    my $GetParam = $Self->_ParamsGet(
        Definition => [
            {
                Name      => 'Invoker',
                Type      => 'String',
                Mandatory => 1,
            },
            {
                Name    => 'EventType',
                Type    => 'String',
                Default => 'Ticket',
            },
        ],
    );

    my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');
    if ( $GetParam->{Error} ) {
        return $LayoutObject->ErrorScreen(
            Message => $GetParam->{Error},
        );
    }

    my $WebserviceData = $Param{WebserviceData};
    my $InvokerConfig  = $WebserviceData->{Config}->{Requester}->{Invoker}->{ $GetParam->{Invoker} };
    if ( !IsHashRefWithData($InvokerConfig) ) {
        return $LayoutObject->ErrorScreen(
            Message =>
                $LayoutObject->{LanguageObject}->Translate( 'Could not determine config for invoker %s', $GetParam->{Invoker} ),
        );
    }

    return $Self->_ShowScreen(
        %Param,
        %{$GetParam},
        Mode            => 'Change',
        Invoker         => $GetParam->{Invoker},
        InvokerConfig   => $InvokerConfig,
        MappingInbound  => $InvokerConfig->{MappingInbound}->{Type},
        MappingOutbound => $InvokerConfig->{MappingOutbound}->{Type},
    );
}

sub _ChangeAction {
    my ( $Self, %Param ) = @_;

    my @ExtraParams;
    for my $Section (qw/General Request Response/) {
        if ( $Self->{Settings} && $Self->{Settings}{$Section} ) {
            push @ExtraParams, $Self->{Settings}{$Section}->@*;
        }
    }

    my $GetParam = $Self->_ParamsGet(
        Definition => [
            {
                Name      => 'OldInvoker',
                Type      => 'String',
                Mandatory => 1,
            },
            {
                Name    => 'Invoker',
                Type    => 'String',
                Default => '',
            },
            {
                Name    => 'Description',
                Type    => 'String',
                Default => '',
            },
            {
                Name  => 'MappingInbound',
                Type  => 'String',
                Check => 'MappingType',
            },
            {
                Name  => 'MappingOutbound',
                Type  => 'String',
                Check => 'MappingType',
            },
            {
                Name    => 'ContinueAfterSave',
                Type    => 'String',
                Default => '',
            },
            {
                Name    => 'EventType',
                Type    => 'String',
                Default => 'Ticket',
            },
            @ExtraParams,
        ],
    );

    my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');
    if ( $GetParam->{Error} ) {
        return $LayoutObject->ErrorScreen(
            Message => $GetParam->{Error},
        );
    }

    my $WebserviceData = $Param{WebserviceData};
    my $InvokerConfig  = delete $WebserviceData->{Config}->{Requester}->{Invoker}->{ $GetParam->{OldInvoker} };
    if ( !IsHashRefWithData($InvokerConfig) ) {
        return $LayoutObject->ErrorScreen(
            Message => $LayoutObject->{LanguageObject}->Translate( 'Could not determine config for invoker %s', $GetParam->{OldInvoker} ),
        );
    }

    my %Errors;
    if ( !IsStringWithData( $GetParam->{Invoker} ) ) {
        $Errors{InvokerServerError} = 'ServerError';
    }

    # Invoker was renamed and new name already exists.
    elsif (
        $GetParam->{OldInvoker} ne $GetParam->{Invoker}
        && IsHashRefWithData( $WebserviceData->{Config}->{Requester}->{Invoker}->{ $GetParam->{Invoker} } )
        )
    {
        $Errors{InvokerServerError} = 'ServerError';
    }

    $InvokerConfig->{Description} = $GetParam->{Description};

    for my $ParamConfig (@ExtraParams) {
        if ( exists $ParamConfig->{ErrorFunction} ) {
            my $Error = $ParamConfig->{ErrorFunction}->(
                %Param,
                GetParam => $GetParam,
            );

            if ($Error) {
                $Errors{ $ParamConfig->{Name} . 'ServerError' } = $Error;
            }
        }

        $InvokerConfig->{ $ParamConfig->{Name} } = $GetParam->{ $ParamConfig->{Name} };
    }

    if (%Errors) {
        return $Self->_ShowScreen(
            %Param,
            %{$GetParam},
            %Errors,
            Mode          => 'Change',
            Invoker       => $GetParam->{OldInvoker},
            InvokerConfig => $InvokerConfig,
            NewInvoker    => $GetParam->{Invoker},
        );
    }

    # If mapping types were not changed, keep the mapping configuration.
    DIRECTION:
    for my $Direction (qw(MappingInbound MappingOutbound)) {

        # No mapping set, make sure it is not present in the configuration.
        if ( !$GetParam->{$Direction} ) {
            delete $InvokerConfig->{$Direction};
            next DIRECTION;
        }

        # Mapping added or changed, initialize with empty config.
        my $OldMapping = $InvokerConfig->{$Direction}->{Type};
        if ( !$OldMapping || ( $OldMapping && $GetParam->{$Direction} ne $OldMapping ) ) {
            $InvokerConfig->{$Direction} = {
                Type => $GetParam->{$Direction},
            };
        }
    }

    # Update invoker config.
    $WebserviceData->{Config}->{Requester}->{Invoker}->{ $GetParam->{Invoker} } = $InvokerConfig;

    # Take care of error handlers with invoker filters if invoker was renamed.
    if (
        $GetParam->{OldInvoker} ne $GetParam->{Invoker}
        && IsHashRefWithData( $WebserviceData->{Config}->{Requester}->{ErrorHandling} )
        )
    {
        my $ErrorHandlingConfig = $WebserviceData->{Config}->{Requester}->{ErrorHandling};

        ERRORHANDLING:
        for my $ErrorHandling ( sort keys %{$ErrorHandlingConfig} ) {
            next ERRORHANDLING if !IsHashRefWithData( $ErrorHandlingConfig->{$ErrorHandling} );

            my $InvokerFilter = $ErrorHandlingConfig->{$ErrorHandling}->{InvokerFilter};
            next ERRORHANDLING if !IsArrayRefWithData($InvokerFilter);

            next ERRORHANDLING if !grep { $_ eq $GetParam->{OldInvoker} } @{$InvokerFilter};

            # Rename invoker in error handling invoker filter to keep consistency.
            my @NewInvokerFilter = map { $_ eq $GetParam->{OldInvoker} ? $GetParam->{Invoker} : $_ } @{$InvokerFilter};
            $ErrorHandlingConfig->{$ErrorHandling}->{InvokerFilter} = \@NewInvokerFilter;
        }

        $WebserviceData->{Config}->{Requester}->{ErrorHandling} = $ErrorHandlingConfig;
    }

    # added for OTOBOTicketInvoker

    # Take care of invoker dependent configuration if invoker was renamed.
    if ( $GetParam->{OldInvoker} ne $GetParam->{Invoker} ) {

        # Invoker controller mapping.
        if (
            IsHashRefWithData(
                $WebserviceData->{Config}->{Requester}->{Transport}->{Config}->{InvokerControllerMapping}
            )
            )
        {

            my $InvokerControllerMappingConfig
                = $WebserviceData->{Config}->{Requester}->{Transport}->{Config}->{InvokerControllerMapping};

            INVOKER:
            for my $Invoker ( sort keys %{$InvokerControllerMappingConfig} ) {
                next INVOKER if $Invoker ne $GetParam->{OldInvoker};

                $InvokerControllerMappingConfig->{ $GetParam->{Invoker} }
                    = delete $InvokerControllerMappingConfig->{ $GetParam->{OldInvoker} };
            }

            $WebserviceData->{Config}->{Requester}->{Transport}->{Config}->{InvokerControllerMapping}
                = $InvokerControllerMappingConfig;
        }

        # Outbound header config.
        if (
            IsHashRefWithData(
                $WebserviceData->{Config}->{Requester}->{Transport}->{Config}->{OutboundHeaders}->{Specific}
            )
            )
        {

            my $OutboundHeaderConfig
                = $WebserviceData->{Config}->{Requester}->{Transport}->{Config}->{OutboundHeaders}->{Specific};

            INVOKER:
            for my $Invoker ( sort keys %{$OutboundHeaderConfig} ) {
                next INVOKER if $Invoker ne $GetParam->{OldInvoker};

                $OutboundHeaderConfig->{ $GetParam->{Invoker} }
                    = delete $OutboundHeaderConfig->{ $GetParam->{OldInvoker} };
            }

            $WebserviceData->{Config}->{Requester}->{Transport}->{Config}->{OutboundHeaders}->{Specific}
                = $OutboundHeaderConfig;
        }

    }

    my $UpdateSuccess = $Kernel::OM->Get('Kernel::System::GenericInterface::Webservice')->WebserviceUpdate(
        %{$WebserviceData},
        UserID => $Self->{UserID},
    );
    if ( !$UpdateSuccess ) {
        return $LayoutObject->ErrorScreen(
            Message => Translatable('Could not update web service'),
        );
    }

    # If the user would like to continue editing the invoker config, just redirect to the edit screen.
    my $RedirectURL;
    if ( $GetParam->{ContinueAfterSave} eq 1 ) {
        $RedirectURL =
            'Action='
            . $Self->{Action}
            . ';Subaction=Change;WebserviceID='
            . $Param{WebserviceID}
            . ';Invoker='
            . $LayoutObject->LinkEncode( $GetParam->{Invoker} )
            . ';EventType='
            . $GetParam->{EventType}
            . ';';
    }

    # Otherwise return to overview.
    else {
        $RedirectURL =
            'Action=AdminGenericInterfaceWebservice;Subaction=Change;WebserviceID='
            . $Param{WebserviceID}
            . ';';
    }

    return $LayoutObject->Redirect(
        OP => $RedirectURL,
    );
}

sub _DeleteAction {
    my ( $Self, %Param ) = @_;

    my $GetParam = $Self->_ParamsGet(
        Definition => [
            {
                Name      => 'Invoker',
                Type      => 'String',
                Mandatory => 1,
            },
        ],
    );

    if ( $GetParam->{Error} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => $GetParam->{Error},
        );
        return $Self->_JSONResponse( Success => 0 );
    }

    if ( !IsHashRefWithData( $Param{WebserviceData}->{Config}->{Requester}->{Invoker}->{ $GetParam->{Invoker} } ) ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "Could not determine config for invoker " . $GetParam->{Invoker},
        );
        return $Self->_JSONResponse( Success => 0 );
    }

    # Remove invoker from config.
    delete $Param{WebserviceData}->{Config}->{Requester}->{Invoker}->{ $GetParam->{Invoker} };
    my $Success = $Kernel::OM->Get('Kernel::System::GenericInterface::Webservice')->WebserviceUpdate(
        %{ $Param{WebserviceData} },
        UserID => $Self->{UserID},
    );

    return $Self->_JSONResponse( Success => $Success );
}

sub _AddEvent {
    my ( $Self, %Param ) = @_;

    my $GetParam = $Self->_ParamsGet(
        Definition => [
            {
                Name      => 'Invoker',
                Type      => 'String',
                Mandatory => 1,
            },
            {
                Name      => 'NewEvent',
                Type      => 'String',
                Mandatory => 1,
            },
            {
                Name    => 'Asynchronous',
                Type    => 'String',
                Default => 0,
            },
            {
                Name    => 'EventType',
                Type    => 'String',
                Default => 'Ticket',
            },
        ],
    );

    my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');
    if ( $GetParam->{Error} ) {
        return $LayoutObject->ErrorScreen(
            Message => $GetParam->{Error},
        );
    }

    my $WebserviceData = $Param{WebserviceData};
    my $InvokerConfig  = $WebserviceData->{Config}->{Requester}->{Invoker}->{ $GetParam->{Invoker} };
    if ( !IsHashRefWithData($InvokerConfig) ) {
        return $LayoutObject->ErrorScreen(
            Message => $LayoutObject->{LanguageObject}->Translate( 'Could not determine config for invoker %s', $GetParam->{Invoker} ),
        );
    }

    # Add the new event to the list.
    my @Events = IsArrayRefWithData( $InvokerConfig->{Events} ) ? @{ $InvokerConfig->{Events} } : ();
    push @Events, {
        Asynchronous => $GetParam->{Asynchronous},
        Event        => $GetParam->{NewEvent},
    };

    $InvokerConfig->{Events} = \@Events;
    $WebserviceData->{Config}->{Requester}->{Invoker}->{ $GetParam->{Invoker} } = $InvokerConfig;

    my $UpdateSuccess = $Kernel::OM->Get('Kernel::System::GenericInterface::Webservice')->WebserviceUpdate(
        %{$WebserviceData},
        UserID => $Self->{UserID},
    );
    if ( !$UpdateSuccess ) {
        return $LayoutObject->ErrorScreen(
            Message => Translatable('Could not update web service'),
        );
    }

    # Stay in edit mode.
    my $RedirectURL =
        'Action='
        . $Self->{Action}
        . ';Subaction=Change;WebserviceID='
        . $Param{WebserviceID}
        . ';Invoker='
        . $LayoutObject->LinkEncode( $GetParam->{Invoker} )
        . ';EventType='
        . $GetParam->{EventType}
        . ';';

    return $LayoutObject->Redirect(
        OP => $RedirectURL,
    );
}

sub _DeleteEvent {
    my ( $Self, %Param ) = @_;

    my $GetParam = $Self->_ParamsGet(
        Definition => [
            {
                Name      => 'Invoker',
                Type      => 'String',
                Mandatory => 1,
            },
            {
                Name      => 'EventName',
                Type      => 'String',
                Mandatory => 1,
            },
        ],
    );

    if ( $GetParam->{Error} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => $GetParam->{Error},
        );
        return $Self->_JSONResponse( Success => 0 );
    }

    my $WebserviceData = $Param{WebserviceData};
    my $InvokerConfig  = $WebserviceData->{Config}->{Requester}->{Invoker}->{ $GetParam->{Invoker} };
    if ( !IsHashRefWithData($InvokerConfig) ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "Could not determine config for invoker $GetParam->{Invoker}!",
        );
        return $Self->_JSONResponse( Success => 0 );
    }

    # delete selected event from list of events.
    if ( !IsArrayRefWithData( $InvokerConfig->{Events} ) ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "Could not find event to delete in config config for invoker $GetParam->{Invoker}!",
        );
        return $Self->_JSONResponse( Success => 0 );
    }

    @{ $InvokerConfig->{Events} } = grep { $_->{Event} ne $GetParam->{EventName} } @{ $InvokerConfig->{Events} };
    $WebserviceData->{Config}->{Requester}->{Invoker}->{ $GetParam->{Invoker} } = $InvokerConfig;

    my $UpdateSuccess = $Kernel::OM->Get('Kernel::System::GenericInterface::Webservice')->WebserviceUpdate(
        %{$WebserviceData},
        UserID => $Self->{UserID},
    );
    if ( !$UpdateSuccess ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => 'Could not update web service',
        );
        return $Self->_JSONResponse( Success => 0 );
    }

    return $Self->_JSONResponse( Success => 1 );
}

sub _ShowScreen {
    my ( $Self, %Param ) = @_;

    my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');

    my $Output = $LayoutObject->Header();
    $Output .= $LayoutObject->NavigationBar();

    $LayoutObject->AddJSData(
        Key   => 'Invoker',
        Value => $Param{Invoker},
    );

    my %TemplateData = (
        Description => $Param{InvokerConfig}->{Description},
        InvokerType => $Param{InvokerConfig}->{Type},
        Invoker     => $Param{Invoker},
        NewInvoker  => $Param{NewInvoker} // $Param{Invoker},
    );

    # Handle mapping.
    my $MappingModules    = $Kernel::OM->Get('Kernel::Config')->Get('GenericInterface::Mapping::Module') || {};
    my @MappingModuleList = sort keys %{$MappingModules};
    DIRECTION:
    for my $Direction (qw(MappingInbound MappingOutbound)) {
        my $OldMapping = $Param{InvokerConfig}->{$Direction}->{Type};
        my $Mapping    = $Param{$Direction};

        $TemplateData{ $Direction . 'Strg' } = $LayoutObject->BuildSelection(
            Data          => \@MappingModuleList,
            Name          => $Direction,
            SelectedValue => $Mapping,
            Sort          => 'AlphanumericValue',
            PossibleNone  => 1,
            Class         => 'Modernize RegisterChange',
        );

        # Only show configure button if we have an unchanged existing mapping type.
        next DIRECTION if !$OldMapping;
        next DIRECTION if !$Mapping;
        next DIRECTION if $Mapping ne $OldMapping;
        next DIRECTION if !$MappingModules->{$Mapping}->{ConfigDialog};

        $LayoutObject->Block(
            Name => $Direction . 'ConfigureButton',
            Data => {
                $Direction . ConfigDialog => $MappingModules->{$Mapping}->{ConfigDialog},
            },
        );
    }

    SECTION:
    for my $Section (qw/General Request Response/) {
        next SECTION if !$Self->{Settings};
        next SECTION if !$Self->{Settings}{$Section};

        $LayoutObject->Block(
            Name => $Section,
            Data => {},
        );

        for my $Setting ( $Self->{Settings}{$Section}->@* ) {
            my $SettingHTML;
            if ( $Setting->{Type} eq 'Array' ) {
                $SettingHTML = $LayoutObject->BuildSelection(
                    Class => 'Modernize',
                    $Setting->%*,
                    SelectedID => $Param{InvokerConfig}->{ $Setting->{Name} } // $Setting->{SelectedID},
                );
            }

            $LayoutObject->Block(
                Name => 'Setting' . $Section,
                Data => {
                    SettingName        => $Setting->{Name},
                    SettingLabel       => $Setting->{Label},
                    SettingHTML        => $SettingHTML,
                    SettingExplanation => $Setting->{Explanation},
                    ServerError        => $Param{ $Setting->{Name} . 'ServerError' }
                }
            );
        }
    }

    if ( $Param{Mode} eq 'Change' ) {

        # Show all invoker event triggers.
        my $InvokerEvents = $Param{InvokerConfig}->{Events} // [];
        if ( !IsArrayRefWithData($InvokerEvents) ) {
            $LayoutObject->Block(
                Name => 'NoDataFoundMsg',
                Data => {},
            );
        }

        # Create the event triggers table.
        my @Events;
        my %InvokerEventLookup;
        my %RegisteredEvents = $Kernel::OM->Get('Kernel::System::Event')->EventList();
        for my $Event ( @{$InvokerEvents} ) {
            push @Events, $Event->{Event};

            # To store the events that are already assigned to this invoker
            #   the selects should look for this values and omit them from their lists.
            $InvokerEventLookup{ $Event->{Event} } = 1;

            # Set the event type (event object like Article or Ticket).
            # Value not currently in use but kept as it might be needed in the future.
            my $EventType;
            EVENTTYPE:
            for my $Type ( sort keys %RegisteredEvents ) {
                next EVENTTYPE if !IsArrayRefWithData( $RegisteredEvents{$Type} );
                next EVENTTYPE if !grep { $_ eq $Event->{Event} } @{ $RegisteredEvents{$Type} };

                $EventType = $Type;
                last EVENTTYPE;
            }

            $LayoutObject->Block(
                Name => 'EventRow',
                Data => {
                    WebserviceID => $Param{WebserviceID},
                    Invoker      => $Param{Invoker},
                    Event        => $Event->{Event},
                    Type         => $EventType // '-',
                    Asynchronous => $Event->{Asynchronous}                   ? Translatable('Yes') : Translatable('No'),
                    Condition    => IsHashRefWithData( $Event->{Condition} ) ? Translatable('Yes') : Translatable('No'),
                },
            );
        }

        $LayoutObject->AddJSData(
            Key   => 'Events',
            Value => \@Events
        );

        # Create event trigger selectors (one for each type).
        my @EventTypeList;
        TYPE:
        for my $Type ( sort keys %RegisteredEvents ) {
            next EVENTTYPE if !IsArrayRefWithData( $RegisteredEvents{$Type} );

            # Refresh event list for each event type.
            my @EventList = grep { !$InvokerEventLookup{$_} } @{ $RegisteredEvents{$Type} };

            # hide inactive event lists
            my $EventListHidden = '';
            if ( $Type ne $Param{EventType} ) {
                $EventListHidden = 'Hidden';
            }

            my $EventStrg = $LayoutObject->BuildSelection(
                Data         => \@EventList,
                Name         => $Type . 'Event',
                Sort         => 'AlphanumericValue',
                PossibleNone => 0,
                Title        => $LayoutObject->{LanguageObject}->Translate('Event'),
                Class        => 'Modernize EventList GenericInterfaceSpacing ' . $EventListHidden,
            );

            $LayoutObject->Block(
                Name => 'EventAdd',
                Data => {
                    EventStrg => $EventStrg,
                },
            );

            push @EventTypeList, $Type;
        }

        # Create event type selector.
        $TemplateData{EventTypeStrg} = $LayoutObject->BuildSelection(
            Data          => \@EventTypeList,
            Name          => 'EventType',
            Sort          => 'AlphanumericValue',
            SelectedValue => $Param{EventType},
            PossibleNone  => 0,
            Class         => 'Modernize',
        );
    }

    $Output .= $LayoutObject->Output(
        TemplateFile => $Self->{Action},
        Data         => {
            %Param,
            %TemplateData,
            WebserviceName => $Param{WebserviceData}->{Name},
            Action         => $Self->{Action},
        },
    );

    $Output .= $LayoutObject->Footer();
    return $Output;
}

sub _ParamsGet {
    my ( $Self, %Param ) = @_;

    my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');
    my $ParamObject  = $Kernel::OM->Get('Kernel::System::Web::Request');
    my %GetParam;
    DEFINITION:
    for my $Definition ( @{ $Param{Definition} } ) {
        my $Name = $Definition->{Name};

        if ( $Definition->{Type} eq 'String' ) {
            $GetParam{$Name} = $ParamObject->GetParam( Param => $Name ) // $Definition->{Default};
            next DEFINITION if IsStringWithData( $GetParam{$Name} );

            next DEFINITION if !$Definition->{Mandatory};
            $GetParam{Error} = $LayoutObject->{LanguageObject}->Translate( 'Need %s', ( $Definition->{Label} || $Definition->{Name} ) );
            return \%GetParam;
        }

        if ( $Definition->{Type} eq 'Array' ) {
            $GetParam{$Name} = [ $ParamObject->GetArray( Param => $Name ) ];
            next DEFINITION if IsArrayRefWithData( $GetParam{$Name} );

            next DEFINITION if !$Definition->{Mandatory};
            $GetParam{Error} = Translatable( 'Need %s', ( $Definition->{Label} || $Definition->{Name} ) );
            return \%GetParam;
        }
    }

    # Type checks.
    DEFINITION:
    for my $Definition ( @{ $Param{Definition} } ) {
        next DEFINITION if !$Definition->{Check};

        my $Name = $Definition->{Name};

        next DEFINITION if !defined $GetParam{$Name};

        if ( $Definition->{Check} eq 'InvokerType' ) {
            next DEFINITION if $Self->_InvokerTypeCheck( InvokerType => $GetParam{$Name} );

            $GetParam{Error} = $LayoutObject->{LanguageObject}->Translate( 'InvokerType %s is not registered', $GetParam{$Name} );
            return \%GetParam;
        }

        if ( $Definition->{Check} eq 'MappingType' ) {
            next DEFINITION if !IsStringWithData( $GetParam{Name} );
            next DEFINITION if $Self->_MappingTypeCheck( MappingType => $GetParam{$Name} );

            $GetParam{Error} = $LayoutObject->{LanguageObject}->Translate( 'MappingType %s is not registered', $GetParam{$Name} );
            return \%GetParam;
        }
    }

    return \%GetParam;
}

sub _InvokerTypeCheck {
    my ( $Self, %Param ) = @_;

    return if !$Param{InvokerType};

    my $Invokers = $Kernel::OM->Get('Kernel::Config')->Get('GenericInterface::Invoker::Module');
    return if !IsHashRefWithData($Invokers);

    return if !IsHashRefWithData( $Invokers->{ $Param{InvokerType} } );
    return 1;
}

sub _MappingTypeCheck {
    my ( $Self, %Param ) = @_;

    return if !$Param{MappingType};

    my $Mappings = $Kernel::OM->Get('Kernel::Config')->Get('GenericInterface::Mapping::Module');
    return if !IsHashRefWithData($Mappings);

    return if !IsHashRefWithData( $Mappings->{ $Param{MappingType} } );
    return 1;
}

sub _JSONResponse {
    my ( $Self, %Param ) = @_;

    # return JSON output.
    return $Kernel::OM->Get('Kernel::Output::HTML::Layout')->JSONReply(
        Data => {
            Success => $Param{Success} // 0,
        },
    );
}

sub _ExtraSettings {
    my ( $Self, %Param ) = @_;

    my $ClassList         = $Kernel::OM->Get('Kernel::System::GeneralCatalog')->ItemList( Class => 'ITSM::ConfigItem::Class' );
    my $ClassRestrictions = $Kernel::OM->Get('Kernel::Config')->Get('GenericInterface::Invoker::ConfigItemFetch::Classes');
    my @Classes;

    if ( $ClassRestrictions && $ClassRestrictions->{ $Param{Webservice} } ) {
        my %ClassLookup = reverse $ClassList->%*;
        @Classes = map { $ClassLookup{$_} } $ClassRestrictions->{ $Param{Webservice} }->@*;
    }
    else {
        @Classes = keys $ClassList->%*;
    }

    $Self->{Settings}{Response} = [
        map {
            {
                Label       => 'Identifier for ' . $ClassList->{$_},
                Name        => 'Identifier' . $_,
                Type        => 'Array',
                Multiple    => 1,
                SelectedID  => 'Number',
                Explanation => 'Please select an attribute or a combination of attributes which uniquely map the config items.',
                Data        => $Self->_PossibleValuesGet( ClassID => $_ ),
            }
        } @Classes,
    ];

    return;
}

sub _PossibleValuesGet {
    my ( $Self, %Param ) = @_;

    my $Definition = $Kernel::OM->Get('Kernel::System::ITSMConfigItem')->DefinitionGet(
        ClassID => $Param{ClassID},
    );

    return [
        qw/Classes ConfigItemID Number Name DeplStates/,
        map { 'DynamicField_' . $_ } sort keys $Definition->{DynamicFieldRef}->%*,
    ];
}

1;

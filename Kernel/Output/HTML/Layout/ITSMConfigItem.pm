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

package Kernel::Output::HTML::Layout::ITSMConfigItem;

use strict;
use warnings;
use namespace::autoclean;

# core modules

# CPAN modules

# OTOBO modules
use Kernel::System::VariableCheck qw(:all);
use Kernel::Language qw(Translatable);

our $ObjectManagerDisabled = 1;

=head1 NAME

Kernel::Output::HTML::Layout::ITSMConfigItem - all ConfigItem-related HTML functions

=head1 DESCRIPTION

All ITSM Configuration Management-related HTML functions

=head1 PUBLIC INTERFACE

=head2 ITSMConfigItemOutputStringCreate()

returns an output string

    my $String = $LayoutObject->ITSMConfigItemOutputStringCreate(
        Value => 11,       # (optional)
        Item  => $ItemRef,
        Print => 1,        # (optional, default 0)
    );

=cut

sub ITSMConfigItemOutputStringCreate {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    if ( !$Param{Item} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => 'Need Item!',
        );
        return;
    }

    # load backend
    my $BackendObject = $Self->_ITSMLoadLayoutBackend(
        Type => $Param{Item}->{Input}->{Type},
    );

    return '' if !$BackendObject;

    # generate output string
    my $String = $BackendObject->OutputStringCreate(%Param);

    return $String;
}

=head2 ITSMConfigItemFormDataGet()

returns the values from the html form as hash reference

    my $FormDataRef = $LayoutObject->ITSMConfigItemFormDataGet(
        Key          => 'Item::1::Node::3',
        Item         => $ItemRef,
        ConfigItemID => 123,
    );

=cut

sub ITSMConfigItemFormDataGet {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Argument (qw(Key Item ConfigItemID)) {
        if ( !$Param{$Argument} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Argument!"
            );
            return;
        }
    }

    # load backend
    my $BackendObject = $Self->_ITSMLoadLayoutBackend(
        Type => $Param{Item}->{Input}->{Type},
    );

    return {} if !$BackendObject;

    # get form data
    my $FormData = $BackendObject->FormDataGet(%Param);

    return $FormData;
}

=head2 ITSMConfigItemInputCreate()

returns a input field html string

    my $String = $LayoutObject->ITSMConfigItemInputCreate(
        Key => 'Item::1::Node::3',
        Value => 11,                # (optional)
        Item => $ItemRef,
    );

=cut

sub ITSMConfigItemInputCreate {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Argument (qw(Key Item)) {
        if ( !$Param{$Argument} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Argument!"
            );
            return;
        }
    }

    # load backend
    my $BackendObject = $Self->_ITSMLoadLayoutBackend(
        Type => $Param{Item}->{Input}->{Type},
    );

    return '' if !$BackendObject;

    # lookup item value
    my $String = $BackendObject->InputCreate(%Param);

    return $String;
}

=head2 ITSMConfigItemSearchFormDataGet()

returns the values from the search html form

    my $ArrayRef = $LayoutObject->ITSMConfigItemSearchFormDataGet(
        Key => 'Item::1::Node::3',
        Item => $ItemRef,
    );

=cut

sub ITSMConfigItemSearchFormDataGet {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Argument (qw(Key Item)) {
        if ( !$Param{$Argument} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Argument!"
            );
            return;
        }
    }

    # load backend
    my $BackendObject = $Self->_ITSMLoadLayoutBackend(
        Type => $Param{Item}->{Input}->{Type},
    );

    return [] if !$BackendObject;

    # get form data
    my $Values = $BackendObject->SearchFormDataGet(%Param);

    return $Values;
}

=head2 ITSMConfigItemSearchInputCreate()

returns a search input field html string

    my $String = $LayoutObject->ITSMConfigItemSearchInputCreate(
        Key => 'Item::1::Node::3',
        Item => $ItemRef,
    );

=cut

sub ITSMConfigItemSearchInputCreate {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Argument (qw(Key Item)) {
        if ( !$Param{$Argument} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Argument!"
            );
            return;
        }
    }

    # load backend
    my $BackendObject = $Self->_ITSMLoadLayoutBackend(
        Type => $Param{Item}->{Input}->{Type},
    );

    return '' if !$BackendObject;

    # lookup item value
    my $String = $BackendObject->SearchInputCreate(%Param);

    return $String;
}

=head2 _ITSMLoadLayoutBackend()

load a input type backend module

    $BackendObject = $LayoutObject->_ITSMLoadLayoutBackend(
        Type => 'GeneralCatalog',
    );

=cut

sub _ITSMLoadLayoutBackend {
    my ( $Self, %Param ) = @_;

    # get log object
    my $LogObject = $Kernel::OM->Get('Kernel::System::Log');

    if ( !$Param{Type} ) {
        $LogObject->Log(
            Priority => 'error',
            Message  => 'Need Type!',
        );
        return;
    }

    my $GenericModule = "Kernel::Output::HTML::ITSMConfigItem::Layout$Param{Type}";

    # load the backend module
    if ( !$Kernel::OM->Get('Kernel::System::Main')->Require($GenericModule) ) {
        $LogObject->Log(
            Priority => 'error',
            Message  => "Can't load backend module $Param{Type}!"
        );
        return;
    }

    # create new instance
    my $BackendObject = $GenericModule->new(
        %{$Self},
        %Param,
        LayoutObject => $Self,
    );

    if ( !$BackendObject ) {
        $LogObject->Log(
            Priority => 'error',
            Message  => "Can't create a new instance of backend module $Param{Type}!",
        );
        return;
    }

    return $BackendObject;
}

=head2 ITSMConfigItemListShow()

Returns a list of configuration items with sort and pagination capabilities.

This function is similar to L<Kernel::Output::HTML::LayoutTicket::TicketListShow()>
in F<Kernel/Output/HTML/LayoutTicket.pm>.

    my $Output = $LayoutObject->ITSMConfigItemListShow(
        ConfigItemIDs => $ConfigItemIDsRef,                  # total list of config item ids, that can be listed
        Total         => scalar @{ $ConfigItemIDsRef },      # total number of list items, config items in this case
        View          => $Self->{View},                      # optional, the default value is 'Small'
        Filter        => 'All',
        Filters       => \%NavBarFilter,
        FilterLink    => $LinkFilter,
        TitleName     => 'Overview: Config Item: Computer',
        TitleValue    => $Self->{Filter},
        Env           => $Self,
        LinkPage      => $LinkPage,
        LinkSort      => $LinkSort,
        Frontend      => 'Agent',                           # optional (Agent|Customer), default: Agent, indicates from which frontend this function was called
    );

=cut

sub ITSMConfigItemListShow {
    my ( $Self, %Param ) = @_;

    # set frontend per default to agent
    $Param{Frontend} //= 'Agent';

    # take object ref to local, remove it from %Param (prevent memory leak)
    my $Env = delete $Param{Env};

    # lookup latest used view mode
    if ( !$Param{View} && $Self->{ 'UserITSMConfigItemOverview' . $Env->{Action} } ) {
        $Param{View} = $Self->{ 'UserITSMConfigItemOverview' . $Env->{Action} };
    }

    # set default view mode to 'small'
    my $View = $Param{View} || 'Small';

    # store latest view mode
    $Kernel::OM->Get('Kernel::System::AuthSession')->UpdateSessionID(
        SessionID => $Self->{SessionID},
        Key       => 'UserITSMConfigItemOverview' . $Env->{Action},
        Value     => $View,
    );

    # get config object
    my $ConfigObject = $Kernel::OM->Get('Kernel::Config');

    # update preferences if needed
    my $Key = 'UserITSMConfigItemOverview' . $Env->{Action};
    if ( $Param{Frontend} ne 'Customer' ) {
        if ( !$ConfigObject->Get('DemoSystem') && ( $Self->{$Key} // '' ) ne $View ) {
            $Kernel::OM->Get('Kernel::System::User')->SetPreferences(
                UserID => $Self->{UserID},
                Key    => $Key,
                Value  => $View,
            );
        }
    }

    # get backend from config
    my $Backends = $ConfigObject->Get('ITSMConfigItem::Frontend::Overview');
    if ( !$Backends ) {
        return $Self->FatalError(
            Message => 'Need config option ITSMConfigItem::Frontend::Overview',
        );
    }
    if ( ref $Backends ne 'HASH' ) {
        return $Self->FatalError(
            Message => 'Config option ITSMConfigItem::Frontend::Overview needs to be HASH ref!',
        );
    }

    # check if selected view is available
    if ( !$Backends->{$View} ) {

        # try to find fallback, take first configured view mode
        KEY:
        for my $Key ( sort keys %{$Backends} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "No Config option found for view mode $View, took $Key instead!",
            );
            $View = $Key;
            last KEY;
        }
    }

    # get layout object
    my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');

    $LayoutObject->AddJSData(
        Key   => 'View',
        Value => $View,
    );

    # load overview backend module
    if ( !$Kernel::OM->Get('Kernel::System::Main')->Require( $Backends->{$View}->{Module} ) ) {
        return $Env->{LayoutObject}->FatalError();
    }
    my $Object = $Backends->{$View}->{Module}->new( %{$Env} );
    return if !$Object;

    # retrieve filter values
    if ( $Param{FilterContentOnly} ) {
        return $Object->FilterContent(
            %Param,
        );
    }

    # run action row backend module
    $Param{ActionRow} = $Object->ActionRow(
        %Param,
        Config => $Backends->{$View},
    );

    # run overview backend module
    $Param{SortOrderBar} = $Object->SortOrderBar(
        %Param,
        Config => $Backends->{$View},
    );

    # check start option, if higher then tickets available, set
    # it to the last ticket page (Thanks to Stefan Schmidt!)
    my $StartHit = $Kernel::OM->Get('Kernel::System::Web::Request')->GetParam( Param => 'StartHit' ) || 1;

    # get personal page shown count
    my $PageShownPreferencesKey = 'UserConfigItemOverview' . $View . 'PageShown';
    my $PageShown               = $Self->{$PageShownPreferencesKey} || 10;
    my $Group                   = 'ConfigItemOverview' . $View . 'PageShown';

    # get data selection
    my %Data;
    my $Config = $ConfigObject->Get('PreferencesGroups');
    if ( $Config && $Config->{$Group} && $Config->{$Group}->{Data} ) {
        %Data = %{ $Config->{$Group}->{Data} };
    }

    # calculate max. shown per page
    if ( $StartHit > $Param{Total} ) {
        my $Pages = int( ( $Param{Total} / $PageShown ) + 0.99999 );
        $StartHit = ( ( $Pages - 1 ) * $PageShown ) + 1;
    }

    # build nav bar
    my $Limit   = $Param{Limit} || 20_000;
    my %PageNav = $Self->PageNavBar(
        Limit     => $Limit,
        StartHit  => $StartHit,
        PageShown => $PageShown,
        AllHits   => $Param{Total} || 0,
        Action    => 'Action=' . $Self->{Action},
        Link      => $Param{LinkPage},
        IDPrefix  => $Self->{Action},
    );

    # build shown ticket per page
    $Param{RequestedURL}    = $Param{RequestedURL} || "Action=$Self->{Action};$Param{LinkPage}";
    $Param{Group}           = $Group;
    $Param{PreferencesKey}  = $PageShownPreferencesKey;
    $Param{PageShownString} = $Self->BuildSelection(
        Name        => $PageShownPreferencesKey,
        SelectedID  => $PageShown,
        Data        => \%Data,
        Translation => 0,
        Sort        => 'NumericValue',
        Class       => 'Modernize',
    );

    # nav bar at the beginning of a overview
    $Param{View} = $View;
    $Self->Block(
        Name => 'OverviewNavBar',
        Data => \%Param,
    );

    # back link
    if ( $Param{LinkBack} ) {
        $Self->Block(
            Name => 'OverviewNavBarPageBack',
            Data => \%Param,
        );
        $LayoutObject->AddJSData(
            Key   => 'ITSMConfigItemSearch',
            Value => {
                Profile => $Param{Profile},
                ClassID => $Param{ClassID},
            },
        );
    }

    # filter selection
    if ( $Param{Filters} ) {
        my @NavBarFilters;
        for my $Prio ( sort keys %{ $Param{Filters} } ) {
            push @NavBarFilters, $Param{Filters}->{$Prio};
        }
        $Self->Block(
            Name => 'OverviewNavBarFilter',
            Data => {
                %Param,
            },
        );
        my $Count = 0;
        for my $Filter (@NavBarFilters) {
            $Count++;
            if ( $Count == scalar @NavBarFilters ) {
                $Filter->{CSS} = 'Last';
            }
            $Self->Block(
                Name => 'OverviewNavBarFilterItem',
                Data => {
                    %Param,
                    %{$Filter},
                },
            );
            if ( $Filter->{Filter} eq $Param{Filter} ) {
                $Self->Block(
                    Name => 'OverviewNavBarFilterItemSelected',
                    Data => {
                        %Param,
                        %{$Filter},
                    },
                );
            }
            else {
                $Self->Block(
                    Name => 'OverviewNavBarFilterItemSelectedNot',
                    Data => {
                        %Param,
                        %{$Filter},
                    },
                );
            }
        }
    }

    # view mode
    for my $Backend (
        sort { $Backends->{$a}->{ModulePriority} <=> $Backends->{$b}->{ModulePriority} }
        keys %{$Backends}
        )
    {
        $Self->Block(
            Name => 'OverviewNavBarViewMode',
            Data => {
                %Param,
                %{ $Backends->{$Backend} },
                Filter => $Param{Filter},
                View   => $Backend,
            },
        );
        if ( $View eq $Backend ) {
            $Self->Block(
                Name => 'OverviewNavBarViewModeSelected',
                Data => {
                    %Param,
                    %{ $Backends->{$Backend} },
                    Filter => $Param{Filter},
                    View   => $Backend,
                },
            );
        }
        else {
            $Self->Block(
                Name => 'OverviewNavBarViewModeNotSelected',
                Data => {
                    %Param,
                    %{ $Backends->{$Backend} },
                    Filter => $Param{Filter},
                    View   => $Backend,
                },
            );
        }
    }

    if (%PageNav) {
        $Self->Block(
            Name => 'OverviewNavBarPageNavBar',
            Data => \%PageNav,
        );

        # don't show context settings in AJAX case (e. g. in customer ticket history),
        #   because the submit with page reload will not work there
        if ( !$Param{AJAX} ) {
            $Self->Block(
                Name => 'ContextSettings',
                Data => {
                    %PageNav,
                    %Param,
                },
            );

            # show column filter preferences
            if ( $View eq 'Small' ) {

                # set preferences keys
                my $PrefKeyColumns = 'UserFilterColumnsEnabled' . '-' . $Env->{Action} . '-' . $Param{Filter};

                # create extra needed objects
                my $JSONObject = $Kernel::OM->Get('Kernel::System::JSON');

                # configure columns
                my @ColumnsEnabled = @{ $Object->{ColumnsEnabled} };
                my @ColumnsAvailable;

                # remove duplicate columns
                my %UniqueColumns;
                my @ColumnsEnabledAux;

                for my $Column (@ColumnsEnabled) {
                    if ( !$UniqueColumns{$Column} ) {
                        push @ColumnsEnabledAux, $Column;
                    }
                    $UniqueColumns{$Column} = 1;
                }

                # set filtered column list
                @ColumnsEnabled = @ColumnsEnabledAux;

                for my $ColumnName ( sort { $a cmp $b } @{ $Object->{ColumnsAvailable} } ) {
                    if ( !grep { $_ eq $ColumnName } @ColumnsEnabled ) {
                        push @ColumnsAvailable, $ColumnName;
                    }
                }

                my %Columns;
                for my $ColumnName ( sort @ColumnsAvailable ) {
                    $Columns{Columns}->{$ColumnName} = ( grep { $ColumnName eq $_ } @ColumnsEnabled ) ? 1 : 0;
                }

                $Self->Block(
                    Name => 'FilterColumnSettings',
                    Data => {
                        Columns          => $JSONObject->Encode( Data => \%Columns ),
                        ColumnsEnabled   => $JSONObject->Encode( Data => \@ColumnsEnabled ),
                        ColumnsAvailable => $JSONObject->Encode( Data => \@ColumnsAvailable ),
                        NamePref         => $PrefKeyColumns,
                        Desc             => Translatable('Shown Columns'),
                        Name             => $Env->{Action},
                        FilterAction     => $Env->{Action} . '-' . $Param{Filter},
                        View             => $View,
                        GroupName        => 'ConfigItemOverviewFilterSettings',
                        %Param,
                    },
                );
            }
        }    # end show column filters preferences

        # check if there was stored filters, and print a link to delete them
        if ( IsHashRefWithData( $Object->{StoredFilters} ) ) {
            $Self->Block(
                Name => 'DocumentActionRowRemoveColumnFilters',
                Data => {
                    CSS => "ContextSettings RemoveFilters",
                    %Param,
                },
            );
        }
    }

    # create nav bar and run overview backend module
    my $NavBarHTML = '';
    if ( $Param{Frontend} ne 'Customer' ) {
        $NavBarHTML = $Self->Output(
            TemplateFile => 'AgentITSMConfigItemOverviewNavBar',
            Data         => { %Param, },
        );
    }

    return join '',
        $NavBarHTML,
        $Object->Run(
            %Param,
            Config    => $Backends->{$View},
            Limit     => $Limit,
            StartHit  => $StartHit,
            PageShown => $PageShown,
            AllHits   => $Param{Total}  || 0,
            Output    => $Param{Output} || '',
        );
}

=head2 XMLData2Hash()

returns a hash reference with the requested attributes data for a config item

Return

    $Data = {
        'HardDisk::2' => {
            Value => 'HD2',
            Name  => 'Hard Disk',
         },
        'CPU::1' => {
            Value => '',
            Name  => 'CPU',
        },
        'HardDisk::2::Capacity::1' => {
            Value => '780 GB',
            Name  => 'Capacity',
        },
    };

    my $Data = $LayoutObject->XMLData2Hash(
        XMLDefinition => $Version->{XMLDefinition},
        XMLData       => $Version->{XMLData}->[1]->{Version}->[1],
        Attributes    => ['CPU::1', 'HardDrive::2::Capacity::1', ...],
        Data          => \%DataHashRef,                                 # optional
        Prefix        => 'HardDisk::1',                                 # optional
    );

=cut

sub XMLData2Hash {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    return if !$Param{XMLData};
    return if !$Param{XMLDefinition};
    return if !$Param{Attributes};
    return if ref $Param{XMLData} ne 'HASH';
    return if ref $Param{XMLDefinition} ne 'ARRAY';
    return if ref $Param{Attributes} ne 'ARRAY';

    # to store the return data
    my $Data = $Param{Data} || {};

    # create a lookup structure
    my %RelevantAttributes = map { $_ => 1 } @{ $Param{Attributes} };

    ITEM:
    for my $Item ( @{ $Param{XMLDefinition} } ) {

        my $CountMax = $Item->{CountMax} || 1;

        COUNTER:
        for my $Counter ( 1 .. $CountMax ) {

            # add prefix
            my $Prefix = $Item->{Key} . '::' . $Counter;
            if ( $Param{Prefix} ) {
                $Prefix = $Param{Prefix} . '::' . $Prefix;
            }

            # skip not needed elements and sub elements
            next COUNTER if !grep { $_ =~ m{\A$Prefix} } @{ $Param{Attributes} };

            # lookup value
            my $Value = $Kernel::OM->Get('Kernel::System::ITSMConfigItem')->XMLValueLookup(
                Item  => $Item,
                Value => $Param{XMLData}->{ $Item->{Key} }->[$Counter]->{Content} // '',
            );

            # only if value is defined
            if ( defined $Value ) {

                # create output string
                $Value = $Self->ITSMConfigItemOutputStringCreate(
                    Value => $Value,
                    Item  => $Item,
                    Print => $Param{Print},
                );
            }

            if ( $RelevantAttributes{$Prefix} ) {

                # store the item in hash
                $Data->{$Prefix} = {
                    Name  => $Item->{Name},
                    Value => $Value // '',
                };
            }

            # start recursion, if "Sub" was found
            if ( $Item->{Sub} ) {
                $Data = $Self->XMLData2Hash(
                    XMLDefinition => $Item->{Sub},
                    XMLData       => $Param{XMLData}->{ $Item->{Key} }->[$Counter],
                    Prefix        => $Prefix,
                    Data          => $Data,
                    Attributes    => $Param{Attributes},
                );
            }
        }
    }

    return $Data;
}

1;

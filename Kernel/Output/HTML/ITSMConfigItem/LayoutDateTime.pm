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

package Kernel::Output::HTML::ITSMConfigItem::LayoutDateTime;

use strict;
use warnings;

use Kernel::System::VariableCheck qw(:all);

our @ObjectDependencies = (
    'Kernel::System::Log',
    'Kernel::Output::HTML::Layout',
    'Kernel::System::Web::Request',
    'Kernel::System::DateTime',
    'Kernel::System::User',
);

=head1 NAME

Kernel::Output::HTML::ITSMConfigItem::LayoutDateTime - layout backend module

=head1 DESCRIPTION

All layout functions of datetime objects.

=cut

=head2 new()

create an object

    $BackendObject = Kernel::Output::HTML::ITSMConfigItem::LayoutDateTime->new(
        %Param,
    );

=cut

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {};
    bless( $Self, $Type );

    return $Self;
}

=head2 OutputStringCreate()

create output string

    my $Value = $BackendObject->OutputStringCreate(
        Value => '2007-01-01 12:00',  # (optional)
    );

=cut

sub OutputStringCreate {
    my ( $Self, %Param ) = @_;

    return '' if !$Param{Value};

    $Param{Value} = $Kernel::OM->Get('Kernel::Output::HTML::Layout')->Output(
        Template => '[% Data.Date | Localize("TimeLong") %]',
        Data     => {
            Date => $Param{Value} . ':00',
        },
    );

    return $Param{Value} || '';
}

=head2 FormDataGet()

get form data as hash reference

    my $FormDataRef = $BackendObject->FormDataGet(
        Key => 'Item::1::Node::3',
        Item => $ItemRef,
    );

=cut

sub FormDataGet {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Argument (qw(Key Item)) {
        if ( !$Param{$Argument} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Argument!",
            );
            return;
        }
    }

    my %FormData;

    # get param object
    my $ParamObject = $Kernel::OM->Get('Kernel::System::Web::Request');

    # get form data
    my $Day    = $ParamObject->GetParam( Param => $Param{Key} . '::Day' );
    my $Month  = $ParamObject->GetParam( Param => $Param{Key} . '::Month' );
    my $Year   = $ParamObject->GetParam( Param => $Param{Key} . '::Year' );
    my $Hour   = $ParamObject->GetParam( Param => $Param{Key} . '::Hour' )   || 0;
    my $Minute = $ParamObject->GetParam( Param => $Param{Key} . '::Minute' ) || 0;

    my %Preferences = $Kernel::OM->Get('Kernel::System::User')->GetPreferences(
        UserID => $Param{UserID},
    );

    my $DateTimeObject = $Kernel::OM->Create(
        'Kernel::System::DateTime',
        ObjectParams => {
            Year     => $Year,
            Month    => $Month,
            Day      => $Day,
            Hour     => $Hour,                                                                                                     # midnight
            Minute   => $Minute,
            TimeZone => $Preferences{UserTimeZone} || $Kernel::OM->Create('Kernel::System::DateTime')->UserDefaultTimeZoneGet(),
        },
    );

    # Convert start time to local system time zone.
    $DateTimeObject->ToOTOBOTimeZone();
    my $DateTimeSettings = $DateTimeObject->Get();

    if ( IsHashRefWithData($DateTimeSettings) ) {
        $FormData{Value} = sprintf '%02d-%02d-%02d %02d:%02d', $DateTimeSettings->{Year}, $DateTimeSettings->{Month}, $DateTimeSettings->{Day},
            $DateTimeSettings->{Hour}, $DateTimeSettings->{Minute};
    }

    # set invalid param
    if ( $Param{Item}->{Input}->{Required} && !$FormData{Value} ) {
        $FormData{Invalid} = 1;
        $Param{Item}->{Form}->{ $Param{Key} }->{Invalid} = 1;
    }

    # Sanity check of the assembled timestamp
    if ( $FormData{Value} ) {

        my $DateTimeObject = $Kernel::OM->Create(
            'Kernel::System::DateTime',
            ObjectParams => {
                String => $FormData{Value} . ':00',
            },
        );

        if ( !$DateTimeObject ) {
            $FormData{Invalid} = 1;
            $Param{Item}->{Form}->{ $Param{Key} }->{Invalid} = 1;
        }
    }

    return \%FormData;
}

=head2 InputCreate()

create a input string

    my $Value = $BackendObject->InputCreate(
        Key => 'Item::1::Node::3',
        Value => '2007-03-26 12:00',  # (optional)
        Item => $ItemRef,
    );

=cut

sub InputCreate {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Argument (qw(Key Item)) {
        if ( !$Param{$Argument} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Argument!",
            );
            return;
        }
    }

    my $Invalid = $Param{Invalid};

    my %Values;
    my $Class;
    if ( $Param{Value} || $Param{Item}->{Input}->{ValueDefault} ) {
        my $Value = $Param{Value} || $Param{Item}->{Input}->{ValueDefault};

        if ( $Value =~ /^(\d\d\d\d)-(\d\d|\d)-(\d\d|\d) (\d\d|\d):(\d\d|\d)$/i ) {
            $Values{ $Param{Key} . '::Year' }   = $1;
            $Values{ $Param{Key} . '::Month' }  = $2;
            $Values{ $Param{Key} . '::Day' }    = $3;
            $Values{ $Param{Key} . '::Hour' }   = $4;
            $Values{ $Param{Key} . '::Minute' } = $5;

            if ($Invalid) {
                $Class = 'ServerError';
            }
        }
    }

    my $String = $Kernel::OM->Get('Kernel::Output::HTML::Layout')->BuildDateSelection(
        Prefix           => $Param{Key} . '::',
        Format           => 'DateInputFormatLong',
        YearPeriodPast   => $Param{Item}->{Input}->{YearPeriodPast}   || 10,
        YearPeriodFuture => $Param{Item}->{Input}->{YearPeriodFuture} || 10,
        %Values,
        $Param{Key} . '::' . 'Class' => $Class,
        Validate                     => 1,
    );

    return $String;
}

=head2 SearchFormDataGet()

get search form data

    my $Value = $BackendObject->SearchFormDataGet(
        Key => 'Item::1::Node::3',
        Item => $ItemRef,
    );

=cut

sub SearchFormDataGet {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Argument (qw(Key Item)) {
        if ( !$Param{$Argument} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Argument!",
            );
            return;
        }
    }

    my $Used;
    my $StartMinute;
    my $StartHour;
    my $StartDay;
    my $StartMonth;
    my $StartYear;
    my $StopMinute;
    my $StopHour;
    my $StopDay;
    my $StopMonth;
    my $StopYear;

    # get param object
    my $ParamObject = $Kernel::OM->Get('Kernel::System::Web::Request');

    # get form data
    if ( $Param{Value} && ref $Param{Value} eq 'HASH' ) {
        $Used        = $Param{Value}->{ $Param{Key} };
        $StartMinute = $Param{Value}->{ $Param{Key} . '::TimeStart::Minute' };
        $StartHour   = $Param{Value}->{ $Param{Key} . '::TimeStart::Hour' };
        $StartDay    = $Param{Value}->{ $Param{Key} . '::TimeStart::Day' };
        $StartMonth  = $Param{Value}->{ $Param{Key} . '::TimeStart::Month' };
        $StartYear   = $Param{Value}->{ $Param{Key} . '::TimeStart::Year' };
        $StopMinute  = $Param{Value}->{ $Param{Key} . '::TimeStop::Minute' };
        $StopHour    = $Param{Value}->{ $Param{Key} . '::TimeStop::Hour' };
        $StopDay     = $Param{Value}->{ $Param{Key} . '::TimeStop::Day' };
        $StopMonth   = $Param{Value}->{ $Param{Key} . '::TimeStop::Month' };
        $StopYear    = $Param{Value}->{ $Param{Key} . '::TimeStop::Year' };
    }
    else {
        $Used        = $ParamObject->GetParam( Param => $Param{Key} );
        $StartMinute = $ParamObject->GetParam( Param => $Param{Key} . '::TimeStart::Minute' ) || 00;
        $StartHour   = $ParamObject->GetParam( Param => $Param{Key} . '::TimeStart::Hour' )
            || 00;
        $StartDay   = $ParamObject->GetParam( Param => $Param{Key} . '::TimeStart::Day' );
        $StartMonth = $ParamObject->GetParam( Param => $Param{Key} . '::TimeStart::Month' );
        $StartYear  = $ParamObject->GetParam( Param => $Param{Key} . '::TimeStart::Year' );
        $StopMinute = $ParamObject->GetParam( Param => $Param{Key} . '::TimeStop::Minute' )
            || 59;
        $StopHour = $ParamObject->GetParam( Param => $Param{Key} . '::TimeStop::Hour' )
            || 23;
        $StopDay   = $ParamObject->GetParam( Param => $Param{Key} . '::TimeStop::Day' );
        $StopMonth = $ParamObject->GetParam( Param => $Param{Key} . '::TimeStop::Month' );
        $StopYear  = $ParamObject->GetParam( Param => $Param{Key} . '::TimeStop::Year' );
    }

    if (
        $Used
        && $StartMinute && $StartHour && $StartDay && $StartMonth && $StartYear
        && $StopMinute  && $StopHour  && $StopDay  && $StopMonth  && $StopYear
        )
    {

        # add hour, minutes and seconds,
        # so that that the first and the last day is selected as well
        my $StartDate = sprintf '%02d-%02d-%02d %02d:%02d:00'
            , $StartYear, $StartMonth, $StartDay, $StartHour, $StartMinute;
        my $StopDate = sprintf '%02d-%02d-%02d %02d:%02d:59'
            , $StopYear, $StopMonth, $StopDay, $StopHour, $StopMinute;

        return { '-between' => [ $StartDate, $StopDate ] };
    }

    return [];    # no conditions by default
}

=head2 SearchInputCreate()

create a search input string

    my $Value = $BackendObject->SearchInputCreate(
        Key      => 'Item::1::Node::3',
        Item     => $ItemRef,
        Optional => 1,                   # (optional) default 0 (0|1)
    );

=cut

sub SearchInputCreate {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Argument (qw(Key Item)) {
        if ( !$Param{$Argument} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Argument!",
            );
            return;
        }
    }

    # just for convenience
    my $Key         = $Param{Key};
    my $PrefixStart = $Key . '::TimeStart::';
    my $PrefixStop  = $Key . '::TimeStop::';

    # get time related params
    my %GetParam;

    # get param object
    my $ParamObject = $Kernel::OM->Get('Kernel::System::Web::Request');

    if ( $Param{Value} ) {
        %GetParam = %{ $Param{Value} };
    }
    else {
        $GetParam{$Key} = $ParamObject->GetParam( Param => $Key );
        for my $TimeType ( $PrefixStart, $PrefixStop ) {
            for my $Part (qw( Year Month Day )) {
                my $ParamKey = $TimeType . $Part;
                my $ParamVal = $ParamObject->GetParam( Param => $ParamKey );

                # remove white space on the start and end
                if ($ParamVal) {
                    $ParamVal =~ s{ \A \s+ }{}xms;
                    $ParamVal =~ s{ \s+ \z }{}xms;
                }

                # store in %GetParam
                $GetParam{$ParamKey} = $ParamVal;
            }
        }
    }

    # get layout object
    my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');

    # Build selection for the start and stop time.
    my $TimeStartSelectionString = $LayoutObject->BuildDateSelection(
        Prefix           => $PrefixStart,
        Format           => 'DateInputFormatLong',
        YearPeriodPast   => 10,
        YearPeriodFuture => 10,
        %GetParam,
    );
    my $TimeStopSelectionString = $LayoutObject->BuildDateSelection(
        Optional         => 0,
        Prefix           => $PrefixStop,
        Format           => 'DateInputFormatLong',
        YearPeriodPast   => 10,
        YearPeriodFuture => 10,
        %GetParam,
    );

    my $Checkbox = qq{<input type="hidden" name="$Key" value="1"/>};
    if ( $Param{Optional} ) {
        $Checkbox = qq{<input type="checkbox" name="$Key" value="1"/>};
    }

    my $Between = $LayoutObject->{LanguageObject}->Translate('Between');
    my $And     = $LayoutObject->{LanguageObject}->Translate('and');

    return "<div> $Checkbox $Between $TimeStartSelectionString </div>"
        . "<span style=\"margin-left: 27px;\"> $And </span> $TimeStopSelectionString";
}

1;

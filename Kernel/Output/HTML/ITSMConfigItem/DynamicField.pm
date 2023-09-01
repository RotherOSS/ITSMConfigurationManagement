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

# TODO: Maybe rename to AgentZoom or similar
package Kernel::Output::HTML::ITSMConfigItem::DynamicField;

use strict;
use warnings;

# core modules

# CPAN modules

# OTOBO modules
use Kernel::System::VariableCheck qw(IsHashRefWithData IsArrayRefWithData);

our @ObjectDependencies = (
    'Kernel::System::Log',
    'Kernel::Output::HTML::Layout',
    'Kernel::System::DynamicField::Backend',
);

=head1 NAME

Kernel::Output::HTML::ITSMConfigItem::DynamicField - configitem specific dynamic field output

=head1 DESCRIPTION

Functions to generate DynamicField HTML for ConfigItems

=head1 PUBLIC INTERFACE

=head2 new()

create a DynamicFieldOutput object. Do not use it directly, instead use:

    my $DynamicFieldOutputObject = $Kernel::OM->Get('Kernel::Output::HTML::ITSMConfigItem::DynamicField');

=cut

sub new {
    my ( $Type, %Param ) = @_;

    return bless {}, $Type;
}

=head2 PageRender()

Returns the HTML for a page of AgentITSMConfigItemZoom

    my $DynamicFieldHTML = $DynamicFieldOutputObject(
        ConfigItem => $ConfigItem,
        Definition  => $Definition,
        Page       => 'Name',       # optional, default is to render the first page
    );

=cut

sub PageRender {
    my ( $Self, %Param ) = @_;

    # Check needed stuff.
    for my $Needed (qw(ConfigItem Definition)) {
        if ( !IsHashRefWithData( $Param{$Needed} ) ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Needed!",
            );

            return;
        }
    }

    my $Page = $Param{Page}
        ? ( grep { $_->{Name} eq $Param{Page} } $Param{Definition}{DefinitionRef}{Pages}->@* )[0]
        : $Param{Definition}{DefinitionRef}{Pages}[0];

    if ( !IsHashRefWithData($Page) || !IsArrayRefWithData( $Page->{Content} ) ) {
        $Param{Page} //= 1;

        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "Page $Param{Page} not valid for DefinitionID $Param{Definition}{DefinitionID} of class $Param{Definition}{Class}.",
        );

        return;
    }

    my %Layout;
    if ( $Page->{Layout} ) {
        $Layout{Columns} = $Page->{Layout}{Columns} ? int( $Page->{Layout}{Columns} ) : 1;

        # basic corrections for grid-template-rows
        my @Widths = $Page->{Layout}{ColumnWidth} ? ( $Page->{Layout}{ColumnWidth} =~ /([\d\.]*\w+)/g ) : ();

        if ( @Widths < $Layout{Columns} ) {
            push @Widths, ('1fr') x ( $Layout{Columns} - @Widths );
        }

        $Layout{Widths} = join( ' ', @Widths[ 0 .. $Layout{Columns} - 1 ] );
    }
    else {
        %Layout = (
            Columns => 1,
            Widths  => '1fr',
        );
    }

    # TODO: Include "Include"-sections
    my %Sections = $Param{Definition}{DefinitionRef}{Sections} ? $Param{Definition}{DefinitionRef}{Sections}->%* : ();

    my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');

    {
        my %KeyToCss = qw/Row row Column column/;

        CONTENTBLOCK:
        for my $ContentBlock ( $Page->{Content}->@* ) {
            next CONTENTBLOCK if !$Sections{ $ContentBlock->{Section} };

            my $GridArea;
            for my $Key (qw/Row Column/) {
                if ( $ContentBlock->{ $Key . 'Start' } ) {
                    $GridArea .= 'grid-' . $KeyToCss{$Key} . '-start:' . int( $ContentBlock->{ $Key . 'Start' } ) . ';';
                }
                if ( $ContentBlock->{ $Key . 'Span' } ) {
                    $GridArea .= 'grid-' . $KeyToCss{$Key} . '-end:span ' . int( $ContentBlock->{ $Key . 'Span' } ) . ';';
                }
            }

            $LayoutObject->Block(
                Name => 'ContentCell',
                Data => {
                    GridArea => $GridArea,
                },
            );

            $Self->_SectionRender(
                %Param,
                LayoutObject => $LayoutObject,
                Section      => $Sections{ $ContentBlock->{Section} },
            );
        }
    }

    return $LayoutObject->Output(
        TemplateFile => 'ITSMConfigItemDetails',
        Data         => \%Layout,
    );
}

sub _SectionRender {
    my ( $Self, %Param ) = @_;

    # Get HTML from additional modules
    if ( $Param{Section}{Module} ) {

        # TODO: handle non dynamic field stuff
        # my $Object = $MainObject->Require( $ConfigObject->Get('ModuleMap')->{ $Param{Section}{Module} } ) ...;
        # my $HTML = $Object->Run( %Param );
        # $LayoutObject->Block(
        #    Name => 'GenericHTML',
        #    Data => {
        #        HTML => $HTML,
        #    },
        #);

        return 1;
    }

    my $DynamicFieldBackendObject = $Kernel::OM->Get('Kernel::System::DynamicField::Backend');

    my $RowHasValue = sub {
        return 1 if grep { defined $Param{ConfigItem}{ 'DynamicField_' . $_->{DF} } } $_[0]->@*;
        return 0;
    };
    my $GridHasValue = sub {
        for my $Row ( $_[0]->@* ) {
            return 1 if $RowHasValue->($Row);
        }
        return 0;
    };

    my $DynamicFieldList;

    ROW:
    for my $Row ( $Param{Section}{Content}->@* ) {
        if ( $Row->{Header} ) {
            $Param{LayoutObject}->Block(
                Name => 'HeaderRow',
                Data => {
                    Header => $Row->{Header},
                }
            );

            $DynamicFieldList = 0;
        }

        elsif ( $Row->{DF} ) {
            next ROW if !defined $Param{ConfigItem}{ 'DynamicField_' . $Row->{DF} };

            if ( !$DynamicFieldList ) {
                $Param{LayoutObject}->Block(
                    Name => 'FieldDisplayRow',
                    Data => {
                        Widths => '1fr 1fr',
                    }
                );

                $DynamicFieldList = 1;
            }

            my $DynamicField = $Param{Definition}{DynamicFieldRef}{ $Row->{DF} };

            next ROW if !$DynamicField;

            my $DisplayValue = $DynamicFieldBackendObject->DisplayValueRender(
                DynamicFieldConfig => $DynamicField,
                Value              => $Param{ConfigItem}{ 'DynamicField_' . $Row->{DF} },
                LayoutObject       => $Param{LayoutObject},
                HTMLOutput         => 1,
            );

            $Param{LayoutObject}->Block(
                Name => 'FieldDisplayCell',
                Data => {
                    Label => $Row->{Label} || $DynamicField->{Label},
                    Type  => 'Label',
                },
            );

            if ( $DynamicField->{FieldType} eq 'Set' ) {
                $Param{LayoutObject}->Block(
                    Name => 'FieldDisplayCell',
                    Data => {
                        $DisplayValue->%*,
                        Type => 'Set',
                    },
                );
            }
            else {
                $Param{LayoutObject}->Block(
                    Name => 'FieldDisplayCell',
                    Data => {
                        $DisplayValue->%*,
                        Type => 'Value',
                    },
                );
            }
        }

        elsif ( $Row->{Grid} ) {
            next ROW if !$GridHasValue->( $Row->{Grid}{Rows} );

            my $Columns = int( $Row->{Grid}{Columns} );

            # basic corrections for grid-template-rows
            my @Widths = $Row->{Grid}{ColumnWidth} ? ( $Row->{Grid}{ColumnWidth} =~ /([\d\.]*\w+)/g ) : ();

            if ( @Widths < $Columns ) {
                push @Widths, ('1fr') x ( $Columns - @Widths );
            }

            $Param{LayoutObject}->Block(
                Name => 'FieldDisplayRow',
                Data => {
                    Widths => join( ' ', @Widths[ 0 .. $Columns - 1 ] ),
                    ,
                }
            );

            GRIDROW:
            for my $GridRow ( $Row->{Grid}{Rows}->@* ) {
                next GRIDROW if !$RowHasValue->($GridRow);

                my $ColumnIndex = 0;
                my @DisplayValues;
                FIELD:
                for my $Field ( $GridRow->@* ) {
                    next FIELD if !$Field->{DF};

                    $ColumnIndex++;

                    my $DynamicField = $Param{Definition}{DynamicFieldRef}{ $Field->{DF} };

                    $DisplayValues[$ColumnIndex] = $DynamicFieldBackendObject->DisplayValueRender(
                        DynamicFieldConfig => $DynamicField,
                        Value              => $Param{ConfigItem}{ 'DynamicField_' . $Field->{DF} },
                        LayoutObject       => $Param{LayoutObject},
                        HTMLOutput         => 1,
                    );

                    # TODO: grid column from definition
                    $Param{LayoutObject}->Block(
                        Name => 'FieldDisplayCell',
                        Data => {
                            Label      => $Field->{Label} || $DynamicField->{Label},
                            GridColumn => "grid-column-start: $ColumnIndex;",
                            Type       => 'Label',
                        }
                    );
                }

                for my $Index ( 1 .. $ColumnIndex ) {
                    $Param{LayoutObject}->Block(
                        Name => 'FieldDisplayCell',
                        Data => {
                            $DisplayValues[$Index]->%*,
                            GridColumn => "grid-column-start: $Index;",
                            Type       => 'Value',
                        },
                    );
                }
            }

            $DynamicFieldList = 0;
        }
    }

    return 1;
}

1;

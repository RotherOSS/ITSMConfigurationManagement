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

# TODO: Maybe rename to AgentZoom or similar
package Kernel::Output::HTML::ITSMConfigItem::DynamicField;

use strict;
use warnings;

# core modules
use List::Util qw(first);

# CPAN modules

# OTOBO modules
use Kernel::System::VariableCheck qw(IsHashRefWithData IsArrayRefWithData);

our @ObjectDependencies = (
    'Kernel::System::Log',
    'Kernel::Output::HTML::Layout',
    'Kernel::System::DynamicField',
    'Kernel::System::DynamicField::Backend',
    'Kernel::System::ITSMConfigItem',
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
        Definition => $Definition,
        PageRef    => $Page,        # either PageRef or Page is required
        Page       => 'Name',
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

    my $DefinitionRef = $Param{Definition}{DefinitionRef};
    my $Page          = $Param{PageRef} // first { $_->{Name} eq $Param{Page} } $DefinitionRef->{Pages}->@*;
    if ( !IsHashRefWithData($Page) || !IsArrayRefWithData( $Page->{Content} ) ) {
        my $ErrorMessage = defined $Param{PageRef}
            ? 'PageRef not valid.'
            : $Param{Page} ? "Page $Param{Page} not valid for DefinitionID $Param{Definition}{DefinitionID} of class $Param{Definition}{Class}."
            :                'Need Page or PageRef!';

        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => $ErrorMessage,
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

    my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');

    {
        my $Sections = $DefinitionRef->{Sections} // {};
        my %KeyToCss = qw/Row row Column column/;

        CONTENTBLOCK:
        for my $ContentBlock ( $Page->{Content}->@* ) {

            # The role is included in the section name
            my $Section = $Sections->{ $ContentBlock->{Section} };

            next CONTENTBLOCK unless $Section;

            # check for referenced dynamic field value before rendering ReferencedSection
            if ( $Section->{Type} && $Section->{Type} eq 'ReferencedSection' ) {

                my $ConfigItemObject = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');

                # fetch config of referenced field
                my $ReferencedFieldConfig = $Kernel::OM->Get('Kernel::System::DynamicField')->DynamicFieldGet(
                    Name => $Section->{ReferenceField},
                );
                next CONTENTBLOCK unless IsHashRefWithData($ReferencedFieldConfig);

                # fetch config item depending on field type
                my %ConfigItemGetParams = (
                    DynamicFields => 1,
                );

                if ( $ReferencedFieldConfig->{FieldType} eq 'ConfigItem' ) {
                    $ConfigItemGetParams{ConfigItemID} = $Param{ConfigItem}{"DynamicField_$ReferencedFieldConfig->{Name}"}[0];
                }
                elsif ( $ReferencedFieldConfig->{FieldType} eq 'ConfigItem' ) {
                    $ConfigItemGetParams{VersionID} = $Param{ConfigItem}{"DynamicField_$ReferencedFieldConfig->{Name}"}[0];
                }

                next CONTENTBLOCK unless ( $ConfigItemGetParams{ConfigItemID} || $ConfigItemGetParams{VersionID} );

                # get referenced config item
                my $ReferencedConfigItem = $ConfigItemObject->ConfigItemGet(
                    %ConfigItemGetParams,
                );
                next CONTENTBLOCK unless IsHashRefWithData($ReferencedConfigItem);

                $Param{ReferencedConfigItem} = $ReferencedConfigItem;
            }

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
                Section      => $Section,
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

    if ( $Param{Section}{Type} ) {
        if ( $Param{Section}{Type} eq 'ConfigItemLinks' ) {
            return $Self->_RenderCILinks(%Param);
        }
        elsif ( $Param{Section}{Type} eq 'ReferencedSection' ) {
            return $Self->_RenderReferencedSection(%Param);
        }
        elsif ( $Param{Section}{Type} eq 'Description' ) {

            # render description richtext editor
            $Param{LayoutObject}->Block(
                Name => 'FieldDisplayRow',
                Data => {
                    Widths => '1fr',
                },
            );

            $Param{LayoutObject}->Block(
                Name => 'FieldDisplayCell',
                Data => {
                    Label => 'Description',
                    Type  => 'Label',
                },
            );

            $Param{LayoutObject}->Block(
                Name => 'FieldDisplayCell',
                Data => {
                    ConfigItemID => $Param{ConfigItem}{ConfigItemID},
                    VersionID    => $Param{ConfigItem}{VersionID},
                    Frontend     => $Param{LayoutObject}{UserType} eq 'User' ? 'Agent' : 'Customer',
                    Type         => 'Iframe',
                },
            );

            return 1;
        }
        elsif ( $Param{Section}{Type} ne 'DynamicFields' ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Invalid section type '$Param{Section}{Type}'!",
            );

            return;
        }
    }

    elsif ( $Param{Section}{Type} && $Param{Section}{Type} eq 'Description' ) {

        # fetch config item attachment list for handling inline attachments
        my $ConfigItemObject = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');
        my @AttachmentList   = $ConfigItemObject->ConfigItemAttachmentList(
            ConfigItemID => $Param{ConfigItem}{ConfigItemID},
        );

        # fetch attachment data and store in hash for RichTextDocumentServe
        my %Attachments;
        for my $Filename (@AttachmentList) {
            $Attachments{$Filename} = $ConfigItemObject->ConfigItemAttachmentGet(
                ConfigItemID => $Param{ConfigItem}{ConfigItemID},
                Filename     => $Filename,
            );
            $Attachments{$Filename}{ContentID} = $Attachments{$Filename}{Preferences}{ContentID};
        }

        # needed to provide necessary params for RichTextDocumentServe
        my %Data = (
            Content     => $Param{ConfigItem}{Description},
            ContentType => 'text/html; charset="utf-8"',
            Disposition => 'inline',
        );

        # generate base url
        my $URL = 'Action=' . ( $Param{LayoutObject}{UserType} eq 'User' ? 'Agent' : 'Customer' ) . 'ITSMConfigItemAttachment;Subaction=HTMLView'
            . ";ConfigItemID=$Param{ConfigItem}{ConfigItemID};VersionID=$Param{ConfigItem}{VersionID};Filename=";

        # # TODO ask if this is necessary and if, shift it to AgentITSMConfigItemZoom and pass as Param
        # # Do not load external images if 'BlockLoadingRemoteContent' is enabled.
        # my $LoadExternalImages;
        # # TODO ask if dedicated sysconfig for ITSMConfigItem is needed
        # if ( $ConfigObject->Get('Ticket::Frontend::BlockLoadingRemoteContent') ) {
        #     $LoadExternalImages = 0;
        # }
        # else {
        #     $LoadExternalImages = $ParamObject->GetParam(
        #         Param => 'LoadExternalImages'
        #     ) || 0;

        #     # Safety check only on customer article.
        #     if ( !$LoadExternalImages && $Article{SenderType} ne 'customer' ) {
        #         $LoadExternalImages = 1;
        #     }
        # }

        # reformat rich text document to have correct charset and links to
        # inline documents
        %Data = $Param{LayoutObject}->RichTextDocumentServe(
            Data               => \%Data,
            URL                => $URL,
            Attachments        => \%Attachments,
            LoadExternalImages => $Param{LoadExternalImages},
        );

        # render description richtext editor
        $Param{LayoutObject}->Block(
            Name => 'FieldDisplayRow',
            Data => {
                Widths => '1fr',
            },
        );

        $Param{LayoutObject}->Block(
            Name => 'FieldDisplayCell',
            Data => {
                Label => 'Description',
                Type  => 'Label',
            },
        );
        $Param{LayoutObject}->Block(
            Name => 'FieldDisplayCell',
            Data => {
                ConfigItemID => $Param{ConfigItem}{ConfigItemID},
                Value        => $Data{Content},
                Type         => 'Iframe',
            },
        );

        return 1;
    }

    # Get HTML from additional modules
    elsif ( $Param{Section}{Module} ) {

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

            if ( $DynamicField->{FieldType} eq 'Set' || $DynamicField->{FieldType} eq 'RichText' ) {
                $Param{LayoutObject}->Block(
                    Name => 'FieldDisplayCell',
                    Data => {
                        $DisplayValue->%*,
                        Type => 'FullRow',
                    },
                );
            }
            elsif ( $DisplayValue->{Link} ) {
                $Param{LayoutObject}->Block(
                    Name => 'FieldDisplayCell',
                    Data => {
                        $DisplayValue->%*,
                        Type => 'ValueLink',
                    },
                );
            }
            elsif ( $DynamicField->{FieldType} eq 'Attachment' ) {
                $Param{LayoutObject}->Block(
                    Name => 'FieldDisplayCell',
                    Data => {
                        $DisplayValue->%*,
                        Type => 'ValueRaw',
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

sub _RenderCILinks {
    my ( $Self, %Param ) = @_;

    my $ConfigItemObject = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');

    my $LinkedConfigItems = $ConfigItemObject->LinkedConfigItems(

        # TODO: What about versions
        ConfigItemID => $Param{ConfigItem}{ConfigItemID},

        # TODO: We probably need both
        Direction => 'Source',
        UserID    => 1,
    );

    return if !$LinkedConfigItems;

    my %LinkedClasses;

    for my $Link ( $LinkedConfigItems->@* ) {
        my $ConfigItem = $ConfigItemObject->ConfigItemGet(
            ConfigItemID => $Link->{ConfigItemID},
        );

        # TODO: Think about sorting
        push @{ $LinkedClasses{ $ConfigItem->{Class} } }, {
            Name         => $ConfigItem->{Name},
            ConfigItemID => $Link->{ConfigItemID},
        };
    }

    # TODO: Access rights; classes for agents; for customers?
    # TODO: Configuration options for the tile; class restrictions, directions, ?

    if ( $Param{Section}{Header} ) {
        $Param{LayoutObject}->Block(
            Name => 'HeaderRow',
            Data => {
                Header => $Param{Section}{Header},
            }
        );
    }

    my $Action = $Param{LayoutObject}{UserType} && $Param{LayoutObject}{UserType} eq 'Customer'
        ? 'CustomerITSMConfigItemZoom'
        : 'AgentITSMConfigItemZoom';

    for my $Class ( sort keys %LinkedClasses ) {
        $Param{LayoutObject}->Block(
            Name => 'FieldDisplayRow',
            Data => {
                Widths => '1fr 1fr',
            }
        );

        $Param{LayoutObject}->Block(
            Name => 'FieldDisplayCell',
            Data => {
                Label => $Class,
                Type  => 'Label',
            },
        );

        for my $CI ( $LinkedClasses{$Class}->@* ) {
            $Param{LayoutObject}->Block(
                Name => 'FieldDisplayCell',
                Data => {
                    Title      => $CI->{Name},
                    Value      => $CI->{Name},
                    Link       => $Param{LayoutObject}{Baselink} . "Action=$Action;ConfigItemID=$CI->{ConfigItemID}",
                    Type       => 'ValueLink',
                    GridColumn => 'grid-column-start:2',
                },
            );
        }
    }

    return 1;
}

sub _RenderReferencedSection {
    my ( $Self, %Param ) = @_;

    return unless IsHashRefWithData( $Param{ReferencedConfigItem} );

    # get definition of referenced config item and pass it on to _SectionRender
    my $ReferencedCIDefinition = $Kernel::OM->Get('Kernel::System::ITSMConfigItem')->DefinitionGet(
        DefinitionID => $Param{ReferencedConfigItem}{DefinitionID},
    );

    return unless $ReferencedCIDefinition->{DefinitionID};

    return $Self->_SectionRender(
        ConfigItem   => $Param{ReferencedConfigItem},
        Definition   => $ReferencedCIDefinition,
        Section      => $ReferencedCIDefinition->{DefinitionRef}{Sections}{ $Param{Section}{SectionName} },
        LayoutObject => $Param{LayoutObject},
    );
}

1;

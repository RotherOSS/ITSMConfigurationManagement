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

package Kernel::Modules::AgentITSMConfigItemPrint;

use strict;
use warnings;

use Kernel::Language qw(Translatable);

our $ObjectManagerDisabled = 1;

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {%Param};
    bless( $Self, $Type );

    return $Self;
}

sub Run {
    my ( $Self, %Param ) = @_;

    # get param object
    my $ParamObject = $Kernel::OM->Get('Kernel::System::Web::Request');

    # get params
    my $ConfigItemID = $ParamObject->GetParam( Param => 'ConfigItemID' );
    my $VersionID    = $ParamObject->GetParam( Param => 'VersionID' );

    # get layout object
    my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');

    # check needed stuff
    if ( !$ConfigItemID || !$VersionID ) {
        return $LayoutObject->ErrorScreen(
            Message => Translatable('No ConfigItemID or VersionID is given!'),
            Comment => Translatable('Please contact the administrator.'),
        );
    }

    # get needed objects
    my $ConfigItemObject = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');
    my $ConfigObject     = $Kernel::OM->Get('Kernel::Config');

    # check for access rights
    my $HasAccess = $ConfigItemObject->Permission(
        Scope  => 'Item',
        ItemID => $ConfigItemID,
        UserID => $Self->{UserID},
        Type   => $ConfigObject->Get("ITSMConfigItem::Frontend::$Self->{Action}")->{Permission},
    );

    if ( !$HasAccess ) {

        # error page
        return $LayoutObject->ErrorScreen(
            Message => Translatable('Can\'t show config item, no access rights given!'),
            Comment => Translatable('Please contact the administrator.'),
        );
    }

    # get config item
    my $ConfigItem = $ConfigItemObject->ConfigItemGet(
        ConfigItemID  => $ConfigItemID,
        VersionID     => $VersionID,
        DynamicFields => 1,
    );
    if ( !$ConfigItem->{ConfigItemID} ) {
        return $LayoutObject->ErrorScreen(
            Message =>
                $LayoutObject->{LanguageObject}->Translate( 'ConfigItemID %s not found in database!', $ConfigItemID ),
            Comment => Translatable('Please contact the administrator.'),
        );
    }

    # get last version
    my $LastVersion = $ConfigItemObject->ConfigItemGet(
        ConfigItemID => $ConfigItemID,
    );
    $ConfigItem->{CurrentName} = $LastVersion->{Name};

    # get version list
    my $VersionList = $ConfigItemObject->VersionList(
        ConfigItemID => $ConfigItemID,
    );

    my $VersionNumber = 1;
    LISTVERSIONID:
    for my $ListVersionID ( @{$VersionList} ) {

        last LISTVERSIONID if $VersionID eq $ListVersionID;
        $VersionNumber++;
    }

    # get user object
    my $UserObject = $Kernel::OM->Get('Kernel::System::User');

    # get create & change user data
    for my $Key (qw(Create Change)) {
        $ConfigItem->{ $Key . 'ByName' } = $UserObject->UserName(
            UserID => $ConfigItem->{ $Key . 'By' },
        );
    }

    # get user data of version (create by)
    $ConfigItem->{CreateByName} = $UserObject->UserName(
        UserID => $ConfigItem->{CreateBy},
    );

    # get linked objects
    my $LinkObject = $Kernel::OM->Get('Kernel::System::LinkObject');

    my $LinkListWithData = $LinkObject->LinkListWithData(
        Object => 'ITSMConfigItem',
        Key    => $ConfigItemID,
        State  => 'Valid',
        UserID => $Self->{UserID},
    );

    # get link type list
    my %LinkTypeList = $LinkObject->TypeList(
        UserID => $Self->{UserID},
    );

    # get the link data
    my %LinkData;
    if ( $LinkListWithData && ref $LinkListWithData eq 'HASH' && %{$LinkListWithData} ) {
        %LinkData = $LayoutObject->LinkObjectTableCreate(
            LinkListWithData => $LinkListWithData,
            ViewMode         => 'SimpleRaw',
        );
    }

    # get attachments
    my @Attachments = $ConfigItemObject->ConfigItemAttachmentList(
        ConfigItemID => $ConfigItemID,
    );

    # get pdf object
    my $PDFObject = $Kernel::OM->Get('Kernel::System::PDF');

    # generate pdf output
    my %Page;

    # get maximum number of pages
    $Page{MaxPages} = $ConfigObject->Get('PDF::MaxPages');
    if ( !$Page{MaxPages} || $Page{MaxPages} < 1 || $Page{MaxPages} > 1000 ) {
        $Page{MaxPages} = 100;
    }

    my $Title = $ConfigItem->{CurrentName};

    $Page{MarginTop}    = 30;
    $Page{MarginRight}  = 40;
    $Page{MarginBottom} = 40;
    $Page{MarginLeft}   = 40;
    $Page{HeaderRight}  = $LayoutObject->{LanguageObject}->Translate('ConfigItem') . '#'
        . $ConfigItem->{Number};
    $Page{HeadlineLeft} = $ConfigItem->{Name};
    $Page{PageText}     = $LayoutObject->{LanguageObject}->Translate('Page');
    $Page{PageCount}    = 1;

    # create new pdf document
    $PDFObject->DocumentNew(
        Title  => $ConfigObject->Get('Product') . ':' . $ConfigItem->{Name},
        Encode => $LayoutObject->{UserCharset},
    );

    # create first pdf page
    $PDFObject->PageNew(
        %Page,
        FooterRight => $Page{PageText} . ' ' . $Page{PageCount},
    );
    $Page{PageCount}++;

    $PDFObject->PositionSet(
        Move => 'relativ',
        Y    => -6,
    );

    # output title
    $PDFObject->Text(
        Text     => $Title,
        FontSize => 13,
    );

    $PDFObject->PositionSet(
        Move => 'relativ',
        Y    => -6,
    );

    # output "printed by"
    $PDFObject->Text(
        Text => $LayoutObject->{LanguageObject}->Translate(
            'printed by %s at %s',
            $Self->{UserFullname},
            $LayoutObject->{Time},
        ),
        FontSize => 9,
    );

    $PDFObject->PositionSet(
        Move => 'relativ',
        Y    => -14,
    );

    # output general information
    $Self->_PDFOutputGeneralInfos(
        Page       => \%Page,
        ConfigItem => $ConfigItem,
    );

    # output linked objects
    if (%LinkData) {
        $Self->_PDFOutputLinkedObjects(
            PageData     => \%Page,
            LinkData     => \%LinkData,
            LinkTypeList => \%LinkTypeList,
        );
    }

    # output attachments
    if (@Attachments) {
        $Self->_PDFOutputAttachments(
            PageData       => \%Page,
            ConfigItemID   => $ConfigItemID,
            AttachmentData => \@Attachments,
        );
    }

    # output version infos
    $Self->_PDFOutputVersionInfos(
        Page          => \%Page,
        Version       => $ConfigItem,
        VersionNumber => $VersionNumber,
    );

    # Get current system datetime object.
    my $CurrentSystemDTObj = $Kernel::OM->Create('Kernel::System::DateTime');

    # create file name
    my $Filename = sprintf(
        'configitem_%s_%s.pdf',
        $ConfigItem->{Number},
        $CurrentSystemDTObj->Format( Format => '%F_%H-%M' ),
    );
    my $CleanedFilename = $Kernel::OM->Get('Kernel::System::Main')->FilenameCleanUp(
        Filename => $Filename,
        Type     => 'Attachment',
    );

    return $LayoutObject->Attachment(
        Filename    => $CleanedFilename,
        ContentType => 'application/pdf',
        Content     => $PDFObject->DocumentOutput(),
        Type        => 'inline',
    );
}

sub _PDFOutputGeneralInfos {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Argument (qw(Page ConfigItem)) {
        if ( !defined $Param{$Argument} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Argument!",
            );
            return;
        }
    }

    # get layout object
    my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');

    # create left table
    my $TableLeft = [
        {
            Key   => $LayoutObject->{LanguageObject}->Translate('Class') . ':',
            Value => $Param{ConfigItem}->{Class},
        },
        {
            Key   => $LayoutObject->{LanguageObject}->Translate('ConfigItem') . ':',
            Value => $Param{ConfigItem}->{CurrentName},
        },
        {
            Key   => $LayoutObject->{LanguageObject}->Translate('Current Deployment State') . ':',
            Value => $LayoutObject->{LanguageObject}->Translate(
                $Param{ConfigItem}->{CurDeplState},
            ),
        },
        {
            Key   => $LayoutObject->{LanguageObject}->Translate('Current Incident State') . ':',
            Value => $LayoutObject->{LanguageObject}->Translate(
                $Param{ConfigItem}->{CurInciState},
            ),
        },
    ];

    # create right table
    my $TableRight = [
        {
            Key   => $LayoutObject->{LanguageObject}->Translate('Created') . ':',
            Value => $LayoutObject->Output(
                Template => '[% Data.CreateTime | Localize("TimeLong") %]',
                Data     => \%{ $Param{ConfigItem} },
            ),
        },
        {
            Key   => $LayoutObject->{LanguageObject}->Translate('Created by') . ':',
            Value => $Param{ConfigItem}->{CreateByName},
        },
        {
            Key   => $LayoutObject->{LanguageObject}->Translate('Last changed') . ':',
            Value => $LayoutObject->Output(
                Template => '[% Data.ChangeTime | Localize("TimeLong") %]',
                Data     => \%{ $Param{ConfigItem} },
            ),
        },
        {
            Key   => $LayoutObject->{LanguageObject}->Translate('Last changed by') . ':',
            Value => $Param{ConfigItem}->{ChangeByName},
        },
    ];

    my $Rows = @{$TableLeft};
    if ( @{$TableRight} > $Rows ) {
        $Rows = @{$TableRight};
    }

    my %TableParam;
    for my $Row ( 1 .. $Rows ) {
        $Row--;
        $TableParam{CellData}[$Row][0]{Content}         = $TableLeft->[$Row]->{Key};
        $TableParam{CellData}[$Row][0]{Font}            = 'ProportionalBold';
        $TableParam{CellData}[$Row][1]{Content}         = $TableLeft->[$Row]->{Value};
        $TableParam{CellData}[$Row][2]{Content}         = ' ';
        $TableParam{CellData}[$Row][2]{BackgroundColor} = '#FFFFFF';
        $TableParam{CellData}[$Row][3]{Content}         = $TableRight->[$Row]->{Key};
        $TableParam{CellData}[$Row][3]{Font}            = 'ProportionalBold';
        $TableParam{CellData}[$Row][4]{Content}         = $TableRight->[$Row]->{Value};
    }

    $TableParam{ColumnData}[0]{Width} = 80;
    $TableParam{ColumnData}[1]{Width} = 170.5;
    $TableParam{ColumnData}[2]{Width} = 4;
    $TableParam{ColumnData}[3]{Width} = 80;
    $TableParam{ColumnData}[4]{Width} = 170.5;
    $TableParam{Type}                 = 'Cut';
    $TableParam{Border}               = 0;
    $TableParam{FontSize}             = 6;
    $TableParam{BackgroundColorEven}  = '#DDDDDD';
    $TableParam{Padding}              = 1;
    $TableParam{PaddingTop}           = 3;
    $TableParam{PaddingBottom}        = 3;

    # get pdf object
    my $PDFObject = $Kernel::OM->Get('Kernel::System::PDF');

    # output table
    PAGE:
    for ( $Param{Page}->{PageCount} .. $Param{Page}->{MaxPages} ) {

        # output table (or a fragment of it)
        %TableParam = $PDFObject->Table(%TableParam);

        # stop output or output next page
        last PAGE if $TableParam{State};

        $PDFObject->PageNew(
            %{ $Param{Page} },
            FooterRight => $Param{Page}->{PageText} . ' ' . $Param{Page}->{PageCount},
        );
        $Param{Page}->{PageCount}++;
    }

    return 1;
}

sub _PDFOutputLinkedObjects {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Needed (qw(PageData LinkData LinkTypeList)) {
        if ( !defined( $Param{$Needed} ) ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Needed!"
            );
            return;
        }
    }

    my %Page     = %{ $Param{PageData} };
    my %TypeList = %{ $Param{LinkTypeList} };
    my %TableParam;
    my $Row = 0;

    # my layout object
    my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');

    for my $LinkTypeLinkDirection ( sort { lc $a cmp lc $b } keys %{ $Param{LinkData} } ) {

        # investigate link type name
        my @LinkData     = split /::/, $LinkTypeLinkDirection;
        my $LinkTypeName = $TypeList{ $LinkData[0] }->{ $LinkData[1] . 'Name' };
        $LinkTypeName = $LayoutObject->{LanguageObject}->Translate($LinkTypeName);

        # define headline
        $TableParam{CellData}[$Row][0]{Content} = $LinkTypeName . ':';
        $TableParam{CellData}[$Row][0]{Font}    = 'ProportionalBold';
        $TableParam{CellData}[$Row][1]{Content} = '';

        # extract object list
        my $ObjectList = $Param{LinkData}->{$LinkTypeLinkDirection};

        for my $Object ( sort { lc $a cmp lc $b } keys %{$ObjectList} ) {

            for my $Item ( @{ $ObjectList->{$Object} } ) {

                $TableParam{CellData}[$Row][0]{Content} ||= '';
                $TableParam{CellData}[$Row][1]{Content} = $Item->{Title} || '';
            }
            continue {
                $Row++;
            }
        }
    }

    $TableParam{ColumnData}[0]{Width} = 80;
    $TableParam{ColumnData}[1]{Width} = 431;

    # get pdf object
    my $PDFObject = $Kernel::OM->Get('Kernel::System::PDF');

    # set new position
    $PDFObject->PositionSet(
        Move => 'relativ',
        Y    => -15,
    );

    # output headline
    $PDFObject->Text(
        Text     => $LayoutObject->{LanguageObject}->Translate('Linked Objects'),
        Height   => 7,
        Type     => 'Cut',
        Font     => 'ProportionalBoldItalic',
        FontSize => 7,
        Color    => '#666666',
    );

    # set new position
    $PDFObject->PositionSet(
        Move => 'relativ',
        Y    => -4,
    );

    # table params
    $TableParam{Type}            = 'Cut';
    $TableParam{Border}          = 0;
    $TableParam{FontSize}        = 6;
    $TableParam{BackgroundColor} = '#DDDDDD';
    $TableParam{Padding}         = 1;
    $TableParam{PaddingTop}      = 3;
    $TableParam{PaddingBottom}   = 3;

    # output table
    PAGE:
    for ( $Page{PageCount} .. $Page{MaxPages} ) {

        # output table (or a fragment of it)
        %TableParam = $PDFObject->Table(%TableParam);

        # stop output or output next page
        if ( $TableParam{State} ) {
            last PAGE;
        }
        else {
            $PDFObject->PageNew(
                %Page,
                FooterRight => $Page{PageText} . ' ' . $Page{PageCount},
            );
            $Page{PageCount}++;
        }
    }

    return 1;
}

sub _PDFOutputAttachments {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Argument (qw(PageData ConfigItemID AttachmentData)) {
        if ( !defined( $Param{$Argument} ) ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Argument!",
            );
            return;
        }
    }

    my %Page = %{ $Param{PageData} };
    my %TableParam;
    my $Row = 0;

    # attachments are rendered into a separate row
    ATTACHMENT:
    for my $Attachment ( @{ $Param{AttachmentData} } ) {

        # get the metadata of the current attachment
        my $AttachmentData = $Kernel::OM->Get('Kernel::System::ITSMConfigItem')->ConfigItemAttachmentGet(
            ConfigItemID => $Param{ConfigItemID},
            Filename     => $Attachment,
        );

        # define attachment line
        $TableParam{CellData}[$Row][0]{Content} = $AttachmentData->{Filename} . '  (' . $AttachmentData->{Filesize} . ')';

        $Row++;
    }

    $TableParam{ColumnData}[0]{Width} = 80;
    $TableParam{ColumnData}[1]{Width} = 431;

    # get pdf object
    my $PDFObject = $Kernel::OM->Get('Kernel::System::PDF');

    # set new position
    $PDFObject->PositionSet(
        Move => 'relativ',
        Y    => -15,
    );

    # output headline
    $PDFObject->Text(
        Text     => $Kernel::OM->Get('Kernel::Output::HTML::Layout')->{LanguageObject}->Translate('Attachments'),
        Height   => 7,
        Type     => 'Cut',
        Font     => 'ProportionalBoldItalic',
        FontSize => 7,
        Color    => '#666666',
    );

    # set new position
    $PDFObject->PositionSet(
        Move => 'relativ',
        Y    => -4,
    );

    # table params
    $TableParam{Type}            = 'Cut';
    $TableParam{Border}          = 0;
    $TableParam{FontSize}        = 6;
    $TableParam{BackgroundColor} = '#DDDDDD';
    $TableParam{Padding}         = 1;
    $TableParam{PaddingTop}      = 3;
    $TableParam{PaddingBottom}   = 3;

    # output table
    PAGE:
    for ( $Page{PageCount} .. $Page{MaxPages} ) {

        # output table (or a fragment of it)
        %TableParam = $PDFObject->Table(%TableParam);

        # stop output or output next page
        if ( $TableParam{State} ) {
            last PAGE;
        }
        else {
            $PDFObject->PageNew(
                %Page,
                FooterRight => $Page{PageText} . ' ' . $Page{PageCount},
            );
            $Page{PageCount}++;
        }
    }

    return 1;
}

sub _PDFOutputVersionInfos {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Argument (qw(Page Version VersionNumber)) {
        if ( !defined $Param{$Argument} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Argument!"
            );
            return;
        }
    }

    # get pdf object
    my $PDFObject = $Kernel::OM->Get('Kernel::System::PDF');

    # set new position
    $PDFObject->PositionSet(
        Move => 'relativ',
        Y    => -15,
    );

    # get layout object
    my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');

    # output headline
    $PDFObject->Text(
        Text => $LayoutObject->{LanguageObject}->Translate('Version') . ' '
            . $Param{VersionNumber},
        Height   => 7,
        Type     => 'Cut',
        Font     => 'ProportionalBoldItalic',
        FontSize => 7,
        Color    => '#666666',
    );

    # set new position
    $PDFObject->PositionSet(
        Move => 'relativ',
        Y    => -4,
    );

    # create table
    my $Table = [
        {
            Key   => $LayoutObject->{LanguageObject}->Translate('Created') . ':',
            Value => $LayoutObject->Output(
                Template => '[% Data.CreateTime | Localize("TimeLong") %]',
                Data     => \%{ $Param{Version} },
            ),
        },
        {
            Key   => $LayoutObject->{LanguageObject}->Translate('Created by') . ':',
            Value => $Param{Version}->{CreateByName},
        },
        {
            Key   => ' ',
            Value => ' ',
        },
        {
            Key   => $LayoutObject->{LanguageObject}->Translate('Name') . ':',
            Value => $Param{Version}->{Name},
        },
        {
            Key   => $LayoutObject->{LanguageObject}->Translate('Deployment State') . ':',
            Value => $LayoutObject->{LanguageObject}->Translate( $Param{Version}->{DeplState} ),
        },
        {
            Key   => $LayoutObject->{LanguageObject}->Translate('Incident State') . ':',
            Value => $LayoutObject->{LanguageObject}->Translate( $Param{Version}->{InciState} ),
        },
    ];

    # add dynamic field data to table
    $Self->_PDFOutputDFOutput(
        ConfigItem => $Param{Version},
        TableData  => $Table,
    );

    my %TableParam;
    my $Rows = @{$Table};

    for my $Row ( 1 .. $Rows ) {
        $Row--;
        $TableParam{CellData}[$Row][0]{Content} = $Table->[$Row]->{Key};
        $TableParam{CellData}[$Row][0]{Font}    = 'ProportionalBold';
        $TableParam{CellData}[$Row][1]{Content} = $Table->[$Row]->{Value};
    }

    $TableParam{ColumnData}[0]{Width} = 100;
    $TableParam{ColumnData}[1]{Width} = 411;
    $TableParam{Type}                 = 'Cut';
    $TableParam{Border}               = 0;
    $TableParam{FontSize}             = 6;
    $TableParam{BackgroundColor}      = '#DDDDDD';
    $TableParam{Padding}              = 1;
    $TableParam{PaddingTop}           = 3;
    $TableParam{PaddingBottom}        = 3;

    # output table
    PAGE:
    for ( $Param{Page}->{PageCount} .. $Param{Page}->{MaxPages} ) {

        # output table (or a fragment of it)
        %TableParam = $PDFObject->Table(%TableParam);

        # stop output or output next page
        last PAGE if $TableParam{State};

        $PDFObject->PageNew(
            %{ $Param{Page} },
            FooterRight => $Param{Page}->{PageText} . ' ' . $Param{Page}->{PageCount},
        );
        $Param{Page}->{PageCount}++;
    }

    return 1;
}

sub _PDFOutputDFOutput {
    my ( $Self, %Param ) = @_;

    my $Definition = $Kernel::OM->Get('Kernel::System::ITSMConfigItem')->DefinitionGet(
        DefinitionID => $Param{ConfigItem}{DefinitionID},
    );

    return if !$Definition->{DynamicFieldRef};
    return if !$Definition->{DefinitionRef};

    my @DFOrdered;
    my $GrepDF;
    $GrepDF = sub {
        ENTRY:
        for my $Entry (@_) {
            if ( $Entry->{DF} ) {
                push @DFOrdered, $Entry->{DF};
            }
            elsif ( $Entry->{Grid} && $Entry->{Grid}{Rows} ) {
                for my $Row ( $Entry->{Grid}{Rows}->@* ) {
                    $GrepDF->( $Row->@* );
                }
            }
        }
    };

    for my $Page ( $Definition->{DefinitionRef}{Pages}->@* ) {

        SECTION:
        for my $SectionConfig ( $Page->{Content}->@* ) {
            my $Section = $Definition->{DefinitionRef}{Sections}{ $SectionConfig->{Section} };

            next SECTION if !$Section->{Content};

            $GrepDF->( $Section->{Content}->@* );
        }
    }

    my $BackendObject = $Kernel::OM->Get('Kernel::System::DynamicField::Backend');
    my $LayoutObject  = $Kernel::OM->Get('Kernel::Output::HTML::Layout');

    DFNAME:
    for my $DFName (@DFOrdered) {
        next DFNAME unless $Param{ConfigItem}{ 'DynamicField_' . $DFName };

        my $DynamicField = $Definition->{DynamicFieldRef}{$DFName};

        my $DisplayValue = $BackendObject->DisplayValueRender(
            DynamicFieldConfig => $DynamicField,
            Value              => $Param{ConfigItem}{ 'DynamicField_' . $DFName },
            LayoutObject       => $LayoutObject,
        );

        my $Value = $DisplayValue->{Value};

        # replace newlines with <br/> (fix for bug# 5928)
        $Value =~ s{ \n }{<br/>}gxms;

        # convert value to ascii
        $Value = $Kernel::OM->Get('Kernel::System::HTMLUtils')->ToAscii( String => $Value );

        # new row
        my $NewRow = {
            Key   => $LayoutObject->{LanguageObject}->Translate( $DynamicField->{Label} ) . ':',
            Value => $Value,
        };

        # add row data
        push @{ $Param{TableData} }, $NewRow;
    }

    return 1;
}

1;

# --
# OTOBO is a web-based ticketing system for service organisations.
# --
# Copyright (C) 2001-2020 OTRS AG, https://otrs.com/
# Copyright (C) 2019-2024 Rother OSS GmbH, https://otobo.io/
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

package Kernel::GenericInterface::Operation::ConfigItem::Common;

use v5.24;
use strict;
use warnings;
use namespace::autoclean;
use utf8;

use parent qw(Kernel::GenericInterface::Operation::Common);

# core modules
use MIME::Base64();
use Encode;

# CPAN modules

# OTOBO modules
use Kernel::System::VariableCheck qw(:all);

our $ObjectManagerDisabled = 1;

=head1 NAME

Kernel::GenericInterface::Operation::ConfigItem::Common - Base class for all CI Operations

=head1 PUBLIC INTERFACE

=head2 Init()

initialize the operation by checking the web service configuration and gather of the dynamic fields

    my $Return = $CommonObject->Init(
        WebserviceID => 1,
    );

returns:

    $Return = {
        Success => 1,                       # or 0 in case of failure,
        ErrorMessage => 'Error Message',
    }

=cut

sub Init {
    my ( $Self, %Param ) = @_;

    # check needed
    if ( !$Param{WebserviceID} ) {
        return {
            Success      => 0,
            ErrorMessage => "Got no WebserviceID!",
        };
    }

    # get web service configuration
    my $Webservice = $Kernel::OM->Get('Kernel::System::GenericInterface::Webservice')->WebserviceGet(
        ID => $Param{WebserviceID},
    );

    if ( !IsHashRefWithData($Webservice) ) {
        return {
            Success      => 0,
            ErrorMessage =>
                'Could not determine Web service configuration'
                . ' in Kernel::GenericInterface::Operation::ConfigItem::Common::new()',
        };
    }

    return {
        Success => 1,
    };
}

=head2 ValidateClass()

checks if the given Class is valid.

    my $Sucess = $CommonObject->ValidateClass(
        Class => 'some class',
    );

returns

    $Success = 1            # or undef

=cut

sub ValidateClass {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    return unless $Param{Class};

    # check for Class sent
    my $ItemDataRef = $Kernel::OM->Get('Kernel::System::GeneralCatalog')->ItemGet(
        Class => 'ITSM::ConfigItem::Class',
        Name  => $Param{Class},
    );

    # return false if item data is empty
    return unless IsHashRefWithData($ItemDataRef);

    # looks fine
    return 1;
}

=head2 ValidateDeplState()

checks if the given DeplState is valid.

    my $Sucess = $CommonObject->ValidateDeplState(
        DelpState => 'some DeplState',
    );

returns

    $Success = 1            # or undef

=cut

sub ValidateDeplState {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    return unless $Param{DeplState};

    # check for Class sent
    my $ItemDataRef = $Kernel::OM->Get('Kernel::System::GeneralCatalog')->ItemGet(
        Class => 'ITSM::ConfigItem::DeploymentState',
        Name  => $Param{DeplState},
    );

    # return false if item data is empty
    return unless IsHashRefWithData($ItemDataRef);

    # looks fine
    return 1;
}

=head2 ValidateInciState()

checks if the given InciState is valid.

    my $Sucess = $CommonObject->ValidateInciState(
        InciState => 'some InciState',
    );

returns

    $Success = 1            # or undef

=cut

sub ValidateInciState {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    return unless $Param{InciState};

    # check for Class sent
    my $ItemDataRef = $Kernel::OM->Get('Kernel::System::GeneralCatalog')->ItemGet(
        Class => 'ITSM::Core::IncidentState',
        Name  => $Param{InciState},
    );

    # return false if item data is empty
    return unless IsHashRefWithData($ItemDataRef);

    # looks fine
    return 1;
}

=head2 ValidateInputText()

checks if the given value is valid.

    my $Sucess = $CommonObject->ValidateInputText(
        Value     => 'some value',
        MaxLength => 123,
    );

returns

    $Success = 1            # or undef

=cut

sub ValidateInputText {
    my ( $Self, %Param ) = @_;

    # check length
    if (
        defined $Param{Input}->{MaxLength}
        && $Param{Input}->{MaxLength}
        && length $Param{Value} > $Param{Input}->{MaxLength}
        )
    {
        return;
    }

    return 1;
}

=head2 ValidateInputDate()

checks if the given value is valid.

    my $Sucess = $CommonObject->ValidateInputDate(
        Value => '12/12/1977',
    );

or

    my $Sucess = $CommonObject->ValidateInputDate(
        Value => '1977-12-12',
    );

returns

    $Success = 1            # or undef

=cut

sub ValidateInputDate {
    my ( $Self, %Param ) = @_;

    my $Value = $Param{Value};

    # check and convert for date format like "05/18/2011"
    if ( $Value =~ m{\A (\d{2}) / (\d{2}) / (\d{4}) \z}xms ) {
        $Value = $3 . '-' . $1 . '-' . $2 . ' 00:00:00';
    }

    # check and convert for date format like "2011-05-18"
    if ( $Value =~ m{\A (\d{4} - \d{2} - \d{2} \z) }xms ) {
        $Value = $1 . ' 00:00:00';
    }

    # Convert the raw data to a system datetime object.
    my $DateTimeObject = $Kernel::OM->Create(
        'Kernel::System::DateTime',
        ObjectParams => {
            String => $Value,
        },
    );

    return unless $DateTimeObject;

    # looks fine
    return 1;
}

=head2 ValidateInputDateTime()

checks if the given value is valid.

    my $Sucess = $CommonObject->ValidateInputDateTime(
        Value => '12/12/1977 12:00:00',
    );

    or

    my $Sucess = $CommonObject->ValidateInputDateTime(
        Value => '1977-12-12 12:00:00',
    );

returns

    $Success = 1            # or undef

=cut

sub ValidateInputDateTime {
    my ( $Self, %Param ) = @_;

    my $Value = $Param{Value};

    # check and convert for date format like "05/18/2011"
    if ( $Value =~ m{\A (\d{2}) / (\d{2}) / (\d{4}) \z}xms ) {
        $Value = $3 . '-' . $1 . '-' . $2 . ' 00:00:00';
    }
    elsif ( $Value =~ m{\A (\d{2}) / (\d{2}) / (\d{4}) (\d{2} : \d{2} : \d{2}) \z}xms ) {
        $Value = $3 . '-' . $1 . '-' . $2 . $4;
    }

    # check and convert for date format like "2011-05-18"
    if ( $Value =~ m{\A (\d{4} - \d{2} - \d{2} \z) }xms ) {
        $Value = $1 . ' 00:00:00';
    }

    # Convert the raw data to a system datetime object.
    my $DateTimeObject = $Kernel::OM->Create(
        'Kernel::System::DateTime',
        ObjectParams => {
            String => $Value,
        },
    );

    return if !$DateTimeObject;

    return 1;
}

=head2 ValidateInputInteger()

checks if the given value is valid.

    my $Sucess = $CommonObject->ValidateInputInteger(
        Value => 123,
    );

returns

    $Success = 1            # or undef

=cut

sub ValidateInputInteger {
    my ( $Self, %Param ) = @_;

    my $Value = $Param{Value};

    return if !IsInteger($Value);

    return if defined $Param{ValueMin} && $Value < $Param{ValueMin};
    return if defined $Param{ValueMax} && $Value > $Param{ValueMax};

    return 1;
}

=head2 ValidateInputGeneralCatalog()

checks if the given value is valid.

    my $Sucess = $CommonObject->ValidateInputGeneralCatalog(
        Value => 123,
        Class => 'Some general catalog class'
    );

returns

    $Success = 1            # or undef

=cut

sub ValidateInputGeneralCatalog {
    my ( $Self, %Param ) = @_;

    my $Value = $Param{Value};

    # get the values for the General catalog class
    my $ItemList = $Kernel::OM->Get('Kernel::System::GeneralCatalog')->ItemList(
        Class => $Param{Input}->{Class},
    );

    # create a lokup list
    my %ItemListLookup = reverse %{$ItemList};

    return if !$ItemListLookup{$Value};

    return 1;
}

=head2 ValidateInputCustomer()

checks if the given value is valid.

    my $Sucess = $CommonObject->ValidateInputCustomer(
        Value => 'some customer login',
    );

returns

    $Success = 1            # or undef

=cut

sub ValidateInputCustomer {
    my ( $Self, %Param ) = @_;

    my $Value = $Param{Value};

    return if !$Value;

    my %CustomerData = $Kernel::OM->Get('Kernel::System::CustomerUser')->CustomerUserDataGet(
        User => $Param{Value},
    );

    # if customer is not registered in the database
    return if !IsHashRefWithData( \%CustomerData );

    # if ValidID is present, check if it is valid!
    if ( defined $CustomerData{ValidID} ) {

        # return false if customer is not valid
        return
            if $Kernel::OM->Get('Kernel::System::Valid')->ValidLookup( ValidID => $CustomerData{ValidID} ) ne 'valid';
    }

    return 1;
}

=head2 ValidateInputCustomerCompany()

checks if the given value is valid.

    my $Sucess = $CommonObject->ValidateInputCustomerCompany(
        Value => 'some customer company name',
    );

returns

    $Success = 1            # or undef

=cut

sub ValidateInputCustomerCompany {
    my ( $Self, %Param ) = @_;

    my $Value = $Param{Value};

    return if !$Value;

    my %CompanyList = $Kernel::OM->Get('Kernel::System::CustomerCompany')->CustomerCompanyList(
        Limit => 0,    # Display all Customer Companies
    );

    return if !$CompanyList{ $Param{Value} };

    return 1;
}

=head2 ValidateMimeType()

checks if the given MimeType is valid.

    my $Sucess = $CommonObject->ValidateMimeType(
        MimeTypeID => 'some MimeType',
    );

returns

    $Success = 1            # or undef

=cut

sub ValidateMimeType {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    return if !$Param{MimeType};

    return if $Param{MimeType} !~ m{\A\w+\/\w+\z};

    return 1;
}

=head2 ValidateCharset()

checks if the given Charset is valid.

    my $Sucess = $CommonObject->ValidateCharset(
        Charset => 'some charset',
    );

returns

    $Success = 1            # or undef

=cut

sub ValidateCharset {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    return unless $Param{Charset};

    my $CharsetList = $Self->_CharsetList;

    return unless $CharsetList->{ $Param{Charset} };
    return 1;
}

=head2 ReplaceInputDate()

replaces the user value with a system valid value.

    my $NewValue = $CommonObject->ReplaceInputDate(
        Value => '12/12/1977',
    );

    or

    my $NewValue = $CommonObject->ReplaceInputDate(
        Value => '1977-12-12',
    );

returns

    $NewValue = '1977-12-12',

=cut

sub ReplaceInputDate {
    my ( $Self, %Param ) = @_;

    my $Value = $Param{Value};

    # check and convert for date format like "05/18/2011"
    if ( $Value =~ m{\A (\d{2}) / (\d{2}) / (\d{4}) \z}xms ) {
        $Value = $3 . '-' . $1 . '-' . $2 . ' 00:00:00';
    }

    # check and convert for date format like "2011-05-18"
    if ( $Value =~ m{\A (\d{4} - \d{2} - \d{2} \z) }xms ) {
        $Value = $1 . ' 00:00:00';
    }

    # Convert the raw data to a system datetime object.
    my $DateTimeObject = $Kernel::OM->Create(
        'Kernel::System::DateTime',
        ObjectParams => {
            String => $Value,
        },
    );

    return $DateTimeObject->Format( Format => '%F' );
}

=head2 ReplaceInputDateTime()

replaces the user value with a system valid value.

    my $NewValue = $CommonObject->ReplaceInputDateTime(
        Value => '12/12/1977 12:00:00',
    );

    or

    my $NewValue = $CommonObject->ReplaceInputDateTime(
        Value => '1977-12-12 12:00:00',
    );

returns

    $NewValue = '1977-12-12 12:00:00';

=cut

sub ReplaceInputDateTime {
    my ( $Self, %Param ) = @_;

    my $Value = $Param{Value};

    # check and convert for date format like "05/18/2011"
    if ( $Value =~ m{\A (\d{2}) / (\d{2}) / (\d{4}) \z}xms ) {
        $Value = $3 . '-' . $1 . '-' . $2 . ' 00:00:00';
    }
    elsif ( $Value =~ m{\A (\d{2}) / (\d{2}) / (\d{4}) (\d{2} : \d{2} : \d{2}) \z}xms ) {
        $Value = $3 . '-' . $1 . '-' . $2 . $4;
    }

    # check and convert for date format like "2011-05-18"
    if ( $Value =~ m{\A (\d{4} - \d{2} - \d{2} \z) }xms ) {
        $Value = $1 . ' 00:00:00';
    }

    # Convert the raw data to a system datetime object.
    my $DateTimeObject = $Kernel::OM->Create(
        'Kernel::System::DateTime',
        ObjectParams => {
            String => $Value,
        },
    );

    return $DateTimeObject->ToString();
}

=head2 ReplaceInputGeneralCatalog()

replaces the user value with a system valid value.

    my $NewValue = $CommonObject->ReplaceInputGeneralCatalog(
        Value => 'some value',
        Class => 'Some general catalog class'
    );

returns

    $NewValue = 123

=cut

sub ReplaceInputGeneralCatalog {
    my ( $Self, %Param ) = @_;

    my $Value = $Param{Value};

    # get the values for the General catalog class
    my $ItemList = $Kernel::OM->Get('Kernel::System::GeneralCatalog')->ItemList(
        Class => $Param{Input}->{Class},
    );

    # create a lokup list
    my %ItemListLookup = reverse %{$ItemList};

    return $ItemListLookup{$Value};
}

=head2 InvertReplaceInputDate()

replaces the system value with a user value.

    my $NewValue = $CommonObject->InvertReplaceInputDate(
        Value => '12-12-1977 00:00:00',
    );

returns

    $NewValue = '1977-12-12',

=cut

sub InvertReplaceInputDate {
    my ( $Self, %Param ) = @_;

    my $Value = $Param{Value};

    $Value =~ s{\A (\d{4} - \d{2} - \d{2}) [ ] 00:00:00 \z}{$1}xms;

    return $Value;
}

=head2 InvertReplaceInputGeneralCatalog()

replaces the system value with a user value.

    my $NewValue = $CommonObject->InvertReplaceInputGeneralCatalog(
        Value => 123,
        Class => 'Some general catalog class'
    );

returns

    $NewValue = 'some value'

=cut

sub InvertReplaceInputGeneralCatalog {
    my ( $Self, %Param ) = @_;

    my $Value = $Param{Value};

    # get the values for the General catalog class
    my $ItemList = $Kernel::OM->Get('Kernel::System::GeneralCatalog')->ItemList(
        Class => $Param{Input}->{Class},
    );

    # create a lokup list
    return $ItemList->{$Value};
}

=head2 CreateAttachment()

creates a new attachment for the given ConfigItem.

    my $Result = $CommonObject->CreateAttachment(
        Content      => $Data,                   # file content (Base64 encoded)
        ContentType  => 'some content type',
        Filename     => 'some filename',
        ConfigItemID => 456,
        UserID       => 123,
    );

returns

    $Result = {
        Success => 1,                        # if everything is ok
    }

or

    $Result = {
        Success      => 0,
        ErrorMessage => 'Error description'
    }

=cut

sub CreateAttachment {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Needed (qw(Attachment ConfigItemID UserID)) {
        if ( !$Param{$Needed} ) {
            return {
                Success      => 0,
                ErrorMessage => "CreateAttachment() Got no $Needed!",
            };
        }
    }

    # write attachment
    my $Success = $Kernel::OM->Get('Kernel::System::ITSMConfigItem')->ConfigItemAttachmentAdd(
        %{ $Param{Attachment} },
        ConfigItemID => $Param{ConfigItemID},
        Content      => MIME::Base64::decode_base64( $Param{Attachment}->{Content} ),
        UserID       => $Param{UserID},
    );

    return {
        Success => $Success,
    };
}

=head1 INTERNAL INTERFACE

=head2 _CharsetList()

returns a list of all available charsets.

    my $CharsetList = $CommonObject->_CharsetList(
        UserID => 123,
    );

returns

    $CharsetList = {
        #...
        iso-8859-1  => 1,
        iso-8859-15 => 1,
        MacRoman    => 1,
        utf8        => 1,
        #...
    }

=cut

sub _CharsetList {
    my ($Self) = @_;

    my %CharsetHash = map
        { $_ => 1 }
        Encode->encodings(':all');

    return \%CharsetHash;
}

=head2 _CheckValue()

checks if the given value is valid.

    my $ValueCheck = $CommonObject->_CheckValue(
        Value   => $Value                        # $Value could be a string, a time stamp,
                                                 #   general catalog class name, or a integer
        Input   => $InputDefinitionHashRef,      # The definition of the element input extracted
                                                 #   from the Configuration Item definition for
                                                 #   for each value
        ItemKey => 'some key',                   # The name of the value as sent in the SOAP
                                                 #   request
        Parent  => 'soem parent key->',          # The name of the parent followed by -> or empty
                                                 #   for root key items
    );

returns:

    $ValueCheck = {
        Success => 1,                            # if everything is OK
    }

or

    $ValueCheck = {
        ErrorCode    => 'Function.Error',        # if error
        ErrorMessage => 'Error description',
    }

=cut

sub _CheckValue {
    my ( $Self, %Param ) = @_;

    my $Parent  = $Param{Parent};
    my $ItemKey = $Param{ItemKey};

    if (
        defined $Param{Input}->{Required} && $Param{Input}->{Required} && !$Param{Value}
        )
    {
        return {
            ErrorCode    => "$Self->{OperationName}.MissingParameter",
            ErrorMessage =>
                "$Self->{OperationName}: ConfigItem->CIXMLData->$Parent$ItemKey parameter value"
                . " is required and is missing!",
        };
    }

    if ( $Param{Input}->{Type} eq 'Text' || $Param{Input}->{Type} eq 'TextArea' ) {

        # run Text validations
        if ( !$Self->ValidateInputText(%Param) ) {
            return {
                ErrorCode    => "$Self->{OperationName}.InvalidParameter",
                ErrorMessage =>
                    "$Self->{OperationName}: ConfigItem->CIXMLData->$Parent$ItemKey parameter value"
                    . " excedes the maxium length!",
            };
        }
    }
    elsif ( $Param{Input}->{Type} eq 'Date' ) {

        # run Date validations
        if ( !$Self->ValidateInputDate(%Param) ) {
            return {
                ErrorCode    => "$Self->{OperationName}.InvalidParameter",
                ErrorMessage =>
                    "$Self->{OperationName}: ConfigItem->CIXMLData->$Parent$ItemKey parameter value"
                    . " is not a valid Date format!",
            };
        }
    }
    elsif ( $Param{Input}->{Type} eq 'DateTime' ) {

        # run DateTime validations
        if ( !$Self->ValidateInputDateTime(%Param) ) {
            return {
                ErrorCode    => "$Self->{OperationName}.InvalidParameter",
                ErrorMessage =>
                    "$Self->{OperationName}: ConfigItem->CIXMLData->$Parent$ItemKey parameter value"
                    . " is not a valid DateTime format!",
            };
        }
    }
    elsif ( $Param{Input}->{Type} eq 'Customer' ) {

        # run Customer validations
        if ( !$Self->ValidateInputCustomer(%Param) ) {
            return {
                ErrorCode    => "$Self->{OperationName}.InvalidParameter",
                ErrorMessage =>
                    "$Self->{OperationName}: ConfigItem->CIXMLData->$Parent$ItemKey parameter value"
                    . " is not a valid customer!",
            };
        }
    }
    elsif ( $Param{Input}->{Type} eq 'CustomerCompany' ) {

        # run CustomerCompany validations
        if ( !$Self->ValidateInputCustomerCompany(%Param) ) {
            return {
                ErrorCode    => "$Self->{OperationName}.InvalidParameter",
                ErrorMessage =>
                    "$Self->{OperationName}: ConfigItem->CIXMLData->$Parent$ItemKey parameter value"
                    . " is not a valid customer company!",
            };
        }
    }
    elsif ( $Param{Input}->{Type} eq 'Integer' ) {

        # run Integer validations
        if ( !$Self->ValidateInputInteger(%Param) ) {
            return {
                ErrorCode    => "$Self->{OperationName}.InvalidParameter",
                ErrorMessage =>
                    "$Self->{OperationName}: ConfigItem->CIXMLData->$Parent$ItemKey parameter value"
                    . " is not a valid Integer or out of range!",
            };
        }
    }
    elsif ( $Param{Input}->{Type} eq 'GeneralCatalog' ) {

        # run General Catalog validations
        if ( !$Self->ValidateInputGeneralCatalog(%Param) ) {
            return {
                ErrorCode    => "$Self->{OperationName}.InvalidParameter",
                ErrorMessage =>
                    "$Self->{OperationName}: ConfigItem->CIXMLData->$Parent$ItemKey parameter value"
                    . " is not a valid for General Catalog '$Param{Input}->{Class}'!",
            };
        }
    }
    else {

        # The type is dummy, do nothing
    }

    return {
        Success => 1,
    };
}

=head2 _ReplaceValue()

replace user values with system ready values.

    my $NewValue = $CommonObject->_ReplaceValue(
        Value   => $Value                        # $Value could be a string, a time stamp,
                                                 #   general catalog class name, or a integer
        Input   => $InputDefinitionHashRef,      # The definition of the element input extracted
                                                 #   from the Configuration Item definition for
                                                 #   for each value
                                                 #   for root key items
    );

returns:

    $NewValue = $ANewValue

=cut

sub _ReplaceValue {
    my ( $Self, %Param ) = @_;

    # set the list of input types that needs to be replaced
    my %ReplaceInputTypes = (
        Date           => 1,
        DateTime       => 1,
        GeneralCatalog => 1,
    );
    if ( !$ReplaceInputTypes{ $Param{Input}->{Type} } ) {
        return $Param{Value};
    }

    my $NewValue;

    if ( $Param{Input}->{Type} eq 'Date' ) {

        # run Date replace
        $NewValue = $Self->ReplaceInputDate(%Param);
    }
    elsif ( $Param{Input}->{Type} eq 'DateTime' ) {

        # run DateTime replace
        $NewValue = $Self->ReplaceInputDateTime(%Param);
    }
    else {
        # run General Catalog replace
        $NewValue = $Self->ReplaceInputGeneralCatalog(%Param);
    }

    return $NewValue;
}

=head2 _InvertReplaceValue()

replace internal values with user values.

    my $NewValue = $OperationObject->_InvertReplaceValue(
        Value   => $Value                        # $Value could be a string, a time stamp,
                                                 #   general catalog class name, or a integer
        Input   => $InputDefinitionHashRef,      # The definition of the element input extracted
                                                 #   from the Configuration Item definition for
                                                 #   for each value
                                                 #   for root key items
    );

returns:

    $NewValue = $ANewValue

=cut

sub _InvertReplaceValue {
    my ( $Self, %Param ) = @_;

    # set the list of input types that needs to be replaced
    my %ReplaceInputTypes = (
        Date           => 1,
        GeneralCatalog => 1,
    );

    if ( !$ReplaceInputTypes{ $Param{Input}->{Type} } ) {
        return $Param{Value};
    }

    my $NewValue;

    if ( $Param{Input}->{Type} eq 'Date' ) {

        # run Date replace
        $NewValue = $Self->InvertReplaceInputDate(%Param);
    }
    else {
        # run General Catalog replace
        $NewValue = $Self->InvertReplaceInputGeneralCatalog(%Param);
    }

    return $NewValue;
}

1;

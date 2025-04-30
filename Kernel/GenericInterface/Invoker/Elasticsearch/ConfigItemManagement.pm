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

package Kernel::GenericInterface::Invoker::Elasticsearch::ConfigItemManagement;

use v5.24;
use strict;
use warnings;

# core modules
use MIME::Base64 qw(encode_base64);

# CPAN modules

# OTOBO modules
use Kernel::System::VariableCheck qw(:all);

our $ObjectManagerDisabled = 1;

=head1 NAME

Kernel::GenericInterface::Invoker::Elasticsearch::ConfigItemManagement

=head1 PUBLIC INTERFACE

=head2 new()

usually, you want to create an instance of this
by using Kernel::GenericInterface::Invoker->new();

=cut

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = bless {}, $Type;

    # check needed params and store them in $Self
    for my $Needed (qw/DebuggerObject WebserviceID/) {
        if ( !$Param{$Needed} ) {
            return {
                Success      => 0,
                ErrorMessage => "Need $Needed!"
            };
        }

        $Self->{$Needed} = $Param{$Needed};
    }

    return $Self;
}

=head2 PrepareRequest()

prepare the invocation of the configured remote web service.
This will just return the data that was passed to the function.

    my $Result = $InvokerObject->PrepareRequest(
        Data => {                               # data payload
            ...
        },
    );

    $Result = {
        Success         => 1,                   # 0 or 1
        ErrorMessage    => '',                  # in case of error
        Data            => {                    # data payload after Invoker
            ...
        },
    };

=cut

sub PrepareRequest {
    my ( $Self, %Param ) = @_;

    # check needed
    for my $Needed (qw/Event ConfigItemID/) {
        if ( !$Param{Data}{$Needed} ) {
            return {
                Success      => 0,
                ErrorMessage => "Need $Needed!",
            };
        }
    }

    # get needed objects
    my $ConfigObject = $Kernel::OM->Get('Kernel::Config');

    # do nothing if ConfigItems are not configured
    if ( !$ConfigObject->Get('Elasticsearch::ConfigItemStoreFields') ) {
        return {
            Success           => 1,
            StopCommunication => 1,
        };
    }

    # handle all events which are neither update nor creation first

    # delete the config item
    if ( $Param{Data}{Event} eq 'ConfigItemDelete' ) {
        my %Content = (
            query => {
                term => {
                    ConfigItemID => $Param{Data}{ConfigItemID},
                }
            }
        );

        return {
            Success => 1,
            Data    => {
                docapi => '_delete_by_query',
                id     => '',
                %Content,
            },
        };
    }

    # put a single temporary attachment into a queue
    # more than one attachement could be put per call, but this would make error handling harder
    if ( $Param{Data}{Event} eq 'PutTMPAttachment' ) {

        # get file format to be ingested
        my $FileFormat = $ConfigObject->Get('Elasticsearch::IngestAttachmentFormat');
        my %FormatHash = map { $_ => 1 } @{$FileFormat};

        my $MaxFilesize = $ConfigObject->Get('Elasticsearch::IngestMaxFilesize');
        my $Filename    = $Param{Data}{Filename};
        my $ContentType = $Param{Data}{ContentType};
        my $Filesize    = $Param{Data}{Filesize};

        # ingest attachment only if filesize less than defined in sysconfig
        if ( $Filesize > $MaxFilesize ) {
            return {
                Success           => 1,
                StopCommunication => 1,
            };
        }

        my ($TypeFormat) = $ContentType =~ m/^.*?\/([\d\w]+)/;
        my ($NameFormat) = $Filename    =~ m/\.([\d\w]+)$/;

        my %Data;
        if ( $FormatHash{$TypeFormat} || $FormatHash{$NameFormat} ) {
            my $Encoded = encode_base64( $Param{Data}{Content} );
            $Encoded =~ s/\n//g;
            $Data{filename} = $Filename;
            $Data{data}     = $Encoded;
        }
        else {
            # not a valid file type
            return {
                Success           => 1,
                StopCommunication => 1,
            };
        }

        return {
            Success => 1,
            Data    => {
                docapi      => '_doc',
                path        => 'Attachments',    # actually the pipeline
                id          => '',
                Attachments => [ \%Data ],
            },
        };
    }

    # handle the regular updating and creation

    # get needed objects
    my $ConfigItemObject = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');

    # attachment management
    if ( $Param{Data}{Event} eq 'AttachmentAddPost' ) {
        my $RequesterObject = $Kernel::OM->Get('Kernel::GenericInterface::Requester');

        # create a temporary index to "ingest" the attachment
        my $Result = $RequesterObject->Run(
            WebserviceID => $Self->{WebserviceID},
            Invoker      => 'ConfigItemIngestAttachment',
            Asynchronous => 0,
            Data         => {
                %{ $Param{Data} },
                Event => 'PutTMPAttachment',
            },
        );

        # return, if attachment was not added
        if ( !$Result || !$Result->{Data}{_id} ) {
            return {
                Success           => 1,
                StopCommunication => 1,
            };
        }

        # set parameters
        my %Request = (
            id => $Result->{Data}{_id},
        );
        my %API = (
            docapi => '_doc',
        );
        my %IndexName = (
            index => 'tmpattachments',
        );

        # retrieve the result of the ingest-plugin
        $Result = $RequesterObject->Run(
            WebserviceID => $Self->{WebserviceID},
            Invoker      => 'UtilsIngest_GET',
            Asynchronous => 0,
            Data         => {
                IndexName => \%IndexName,
                Request   => \%Request,
                API       => \%API,
            },
        );

        # prepare processed data to be appended to the attachment array of the CI
        my @AttachmentArray;
        for my $AttachmentAttr ( @{ $Result->{Data}{_source}{Attachments} } ) {
            my %Attachment = (
                Filename => $AttachmentAttr->{filename},
                Content  => $AttachmentAttr->{attachment}{content},
            );
            push @AttachmentArray, \%Attachment;
        }

        # delete the doc in tmpattachment
        $Result = $RequesterObject->Run(
            WebserviceID => $Self->{WebserviceID},
            Invoker      => 'UtilsIngest_DELETE',
            Asynchronous => 0,
            Data         => {
                IndexName => \%IndexName,
                Request   => \%Request,
                API       => \%API,
            },
        );

        # update the CI with the extracted data
        my %Content = (
            script => {
                source => 'ctx._source.Attachments.addAll(params.new)',
                params => {
                    new => \@AttachmentArray,
                },
            },
        );

        return {
            Success => 1,
            Data    => {
                docapi => '_update',
                id     => $Param{Data}{ConfigItemID},
                %Content,
            }
        };
    }

    if ( $Param{Data}{Event} eq 'AttachmentDeletePost' ) {
        my $RequesterObject = $Kernel::OM->Get('Kernel::GenericInterface::Requester');

        # set parameters
        my %Request = (
            id => $Param{Data}{ConfigItemID},
        );
        my %API = (
            docapi => '_doc',
        );
        my %IndexName = (
            index => 'configitem',
        );

        # retrieve the current attachments
        my $Result = $RequesterObject->Run(
            WebserviceID => $Self->{WebserviceID},
            Invoker      => 'UtilsIngest_GET',
            Asynchronous => 0,
            Data         => {
                IndexName => \%IndexName,
                Request   => \%Request,
                API       => \%API,
            },
        );

        # prepare processed data to be appended to the attachment array of the CI
        my @AttachmentArray = ();
        for my $Attachment ( @{ $Result->{Data}{_source}{Attachments} } ) {

            # sort out deleted attachment
            if ( $Attachment->{Filename} ne $Param{Data}{Filename} ) {
                push @AttachmentArray, \%{$Attachment};
            }
        }

        my %Content = (
            Attachments => \@AttachmentArray,
        );

        return {
            Success => 1,
            Data    => {
                docapi => '_update',
                id     => $Param{Data}{ConfigItemID},
                doc    => \%Content,
            }
        };
    }

    # ignore events other than ConfigItemCreate or ConfigItemUpdate
    if ( $Param{Data}{Event} !~ /ConfigItemCreate|ConfigItemUpdate/ ) {
        return {
            Success           => 1,
            StopCommunication => 1,
        };
    }

    # handle exclusions
    my $ExcludedClasses    = $ConfigObject->Get('Elasticsearch::ExcludedCIClasses');
    my $ExcludedDeplStates = $ConfigObject->Get('Elasticsearch::ExcludedCIDeploymentStates');
    $ExcludedClasses    = $ExcludedClasses    ? { map { $_ => 1 } @{$ExcludedClasses} }    : undef;
    $ExcludedDeplStates = $ExcludedDeplStates ? { map { $_ => 1 } @{$ExcludedDeplStates} } : undef;

    # define the default API
    my $API = $Param{Data}{Event} eq 'ConfigItemCreate' ? '_doc' : '_update';

    # excluded classes and deployment states
    if ( defined $ExcludedClasses || defined $ExcludedDeplStates ) {
        my $ConfigItem = $ConfigItemObject->ConfigItemGet(
            ConfigItemID => $Param{Data}{ConfigItemID},
        );

        # return if class is excluded
        if ( defined $ExcludedClasses && $ExcludedClasses->{ $ConfigItem->{Class} } ) {
            return {
                Success           => 1,
                StopCommunication => 1,
            };
        }

        # if the DeploymentState is changed, check if the config item has to be created or deleted in ES
        if ( defined $ExcludedDeplStates ) {

            # if the ConfigItem exists (no old state means just created) and is moved to an excluded queue, delete it
            if ( !( $Param{Data}{OldDeplState} && $ExcludedDeplStates->{ $Param{Data}{OldDeplState} } ) && $ExcludedDeplStates->{ $ConfigItem->{CurDeplState} } ) {
                my %Content = (
                    query => {
                        term => {
                            ConfigItemID => $Param{Data}{ConfigItemID},
                        }
                    }
                );

                return {
                    Success => 1,
                    Data    => {
                        docapi => '_delete_by_query',
                        id     => '',
                        %Content,
                    },
                };
            }

            # do nothing if both, the old and the new state are excluded
            elsif ( $ExcludedDeplStates->{ $ConfigItem->{CurDeplState} } ) {
                return {
                    Success           => 1,
                    StopCommunication => 1,
                };
            }

            # create the ConfigItem, if the config item was moved from an excluded deployment state, to an included one
            elsif ( $Param{Data}{OldDeplState} && $ExcludedDeplStates->{ $Param{Data}{OldDeplState} } ) {
                my $ESObject = $Kernel::OM->Get('Kernel::System::Elasticsearch');

                $ESObject->ConfigItemCreate(
                    ConfigItemID => $Param{Data}{ConfigItemID},
                );
            }
        }
    }

    # gather all fields which have to be stored
    my $Store              = $ConfigObject->Get('Elasticsearch::ConfigItemStoreFields');
    my $Search             = $ConfigObject->Get('Elasticsearch::ConfigItemSearchFields');
    my $DynamicFieldObject = $Kernel::OM->Get('Kernel::System::DynamicField');
    my %DataToStore;
    for my $Field ( @{ $Store->{Basic} }, @{ $Search->{Basic} } ) {
        $DataToStore{$Field} = 1;
    }

    DYNAMICFIELD:
    for my $DynamicFieldName ( @{ $Store->{DynamicField} }, @{ $Search->{DynamicField} } ) {
        my $DynamicField = $DynamicFieldObject->DynamicFieldGet(
            Name => $DynamicFieldName,
        );

        next DYNAMICFIELD unless $DynamicField;

        if ( $DynamicField->{ObjectType} eq 'ITSMConfigItem' ) {
            $DataToStore{"DynamicField_$DynamicFieldName"} = 1;
        }
    }

    # prepare request
    my %Content;
    my $GetDynamicFields = ( IsArrayRefWithData( $Search->{DynamicField} ) || IsArrayRefWithData( $Store->{DynamicField} ) ) ? 1 : 0;
    my $Version          = $ConfigItemObject->ConfigItemGet(
        ConfigItemID  => $Param{Data}{ConfigItemID},
        DynamicFields => 1,
    );

    # iterate over dynamic fields and replace value with DisplayValueRender result
    if ($GetDynamicFields) {
        DYNAMICFIELD:
        for my $DFName ( grep { $DataToStore{$_} && $_ =~ /^DynamicField_/ } keys %DataToStore ) {
            my $DFNameShort = substr $DFName, length('DynamicField_');
            my $DFConfig    = $Kernel::OM->Get('Kernel::System::DynamicField')->DynamicFieldGet(
                Name => $DFNameShort,
            );
            next DYNAMICFIELD unless IsHashRefWithData($DFConfig);
            my $DFValueStructure = $Kernel::OM->Get('Kernel::System::DynamicField::Backend')->DisplayValueRender(
                DynamicFieldConfig => $DFConfig,
                Value              => $Version->{$DFName},
                HTMLOutput         => 0,
                LayoutObject       => $Kernel::OM->Get('Kernel::Output::HTML::Layout'),
            );
            $Version->{$DFName} = $DFValueStructure->{Value};
        }
    }
    %Content = (
        ( map { $_ => $Version->{$_} } keys %DataToStore ),
    );
    $Content{Attachments} = [];

    return {
        Success => 1,
        Data    => {
            docapi => $API,
            id     => $Param{Data}{ConfigItemID},
            doc    => \%Content,
        },
    };
}

=head2 HandleResponse()

handle response data of the configured remote web service.
This will just return the data that was passed to the function.

    my $Result = $InvokerObject->HandleResponse(
        ResponseSuccess      => 1,              # success status of the remote web service
        ResponseErrorMessage => '',             # in case of web service error
        Data => {                               # data payload
            ...
        },
    );

    $Result = {
        Success         => 1,                   # 0 or 1
        ErrorMessage    => '',                  # in case of error
        Data            => {                    # data payload after Invoker
            ...
        },
    };

=cut

sub HandleResponse {
    my ( $Self, %Param ) = @_;

    # if there was an error in the response, forward it
    if ( !$Param{ResponseSuccess} ) {
        return {
            Success      => 0,
            ErrorMessage => $Param{ResponseErrorMessage},
        };
    }

    # Per default there is no rescheduling of Elasticsearch::ConfigItemManagement requests,
    # but ErrorHandling::RequestRetry could have been configured manually, e.g. via the admin interface.
    if ( $Param{Data}{ResponseContent} && $Param{Data}{ResponseContent} =~ m{ReSchedule=1} ) {

        # ResponseContent has URI like params, convert them into a hash
        my %QueryParams = split /[&=]/, $Param{Data}{ResponseContent};

        # unescape URI strings in query parameters
        for my $Param ( sort keys %QueryParams ) {
            $QueryParams{$Param} = URI::Escape::uri_unescape( $QueryParams{$Param} );
        }

        # fix ExecutionTime param
        if ( $QueryParams{ExecutionTime} ) {
            $QueryParams{ExecutionTime} =~ s{(\d+)\+(\d+)}{$1 $2};
        }

        return {
            Success      => 0,
            ErrorMessage => 'Re-Scheduling...',
            Data         => \%QueryParams,
        };
    }

    return {
        Success => 1,
        Data    => $Param{Data},
    };
}

1;

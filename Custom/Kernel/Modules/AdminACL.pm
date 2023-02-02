# --
# OTOBO is a web-based ticketing system for service organisations.
# --
# Copyright (C) 2001-2020 OTRS AG, https://otrs.com/
# Copyright (C) 2019-2023 Rother OSS GmbH, https://otobo.de/
# --
# $origin: otobo - a077e914380d1a13d5aa31472ea687353b614622 - Kernel/Modules/AdminACL.pm
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

package Kernel::Modules::AdminACL;

use strict;
use warnings;

our $ObjectManagerDisabled = 1;

use Kernel::System::VariableCheck qw(:all);
use Kernel::Language qw(Translatable);

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {%Param};
    bless( $Self, $Type );

    return $Self;
}

sub Run {
    my ( $Self, %Param ) = @_;

    my $ParamObject = $Kernel::OM->Get('Kernel::System::Web::Request');


    $Self->{Subaction} = $ParamObject->GetParam( Param => 'Subaction' ) || '';
# RotherOSS / ITSMConfigurationManagement
    $Param{ObjectType} = $ParamObject->GetParam( Param => 'ObjectType' ) || 'Ticket';
# EO ITSMConfigurationManagement

    my $ACLID = $ParamObject->GetParam( Param => 'ID' ) || '';

    my $SynchronizeMessage = Translatable(
        'ACL information from database is not in sync with the system configuration, please deploy all ACLs.'
    );

    my $SynchronizedMessageVisible = 0;

    my $ACLObject = $Kernel::OM->Get('Kernel::System::ACL::DB::ACL');

    if ( $ACLObject->ACLsNeedSync() ) {

        # create a notification if system is not up to date
        $Param{NotifyData} = [
            {
                Info => $SynchronizeMessage,
            },
        ];
        $SynchronizedMessageVisible = 1;
    }

    my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');

    # ------------------------------------------------------------ #
    # ACLImport
    # ------------------------------------------------------------ #
    if ( $Self->{Subaction} eq 'ACLImport' ) {

        # challenge token check for write action
        $LayoutObject->ChallengeTokenCheck();

        my $FormID      = $ParamObject->GetParam( Param => 'FormID' ) || '';
        my %UploadStuff = $ParamObject->GetUploadAll(
            Param  => 'FileUpload',
            Source => 'string',
        );

        my $OverwriteExistingEntities = $ParamObject->GetParam( Param => 'OverwriteExistingEntities' ) || '';

        my $ACLImport = $ACLObject->ACLImport(
            Content                   => $UploadStuff{Content},
            OverwriteExistingEntities => $OverwriteExistingEntities,
            UserID                    => $Self->{UserID},
        );

        if ( !$ACLImport->{Success} ) {
            my $Message = $ACLImport->{Message}
                || Translatable(
                    'ACLs could not be Imported due to a unknown error, please check OTOBO logs for more information'
                );
            return $LayoutObject->ErrorScreen(
                Message => $Message,
            );
        }

        if ( $ACLImport->{AddedACLs} ) {
            push @{ $Param{NotifyData} }, {
                Info => $LayoutObject->{LanguageObject}->Translate(
                    'The following ACLs have been added successfully: %s',
                    $ACLImport->{AddedACLs}
                ),
            };
        }
        if ( $ACLImport->{UpdatedACLs} ) {
            push @{ $Param{NotifyData} }, {
                Info => $LayoutObject->{LanguageObject}->Translate(
                    'The following ACLs have been updated successfully: %s',
                    $ACLImport->{UpdatedACLs}
                ),
            };
        }
        if ( $ACLImport->{ACLErrors} ) {
            push @{ $Param{NotifyData} }, {
                Priority => 'Error',
                Info     => $LayoutObject->{LanguageObject}->Translate(
                    'There where errors adding/updating the following ACLs: %s. Please check the log file for more information.',
                    $ACLImport->{ACLErrors}
                ),
            };
        }

        if (
            ( $ACLImport->{UpdatedACLs} || $ACLImport->{AddedACLs} )
            && !$SynchronizedMessageVisible
            )
        {

            $Param{NotifyData} = [
                @{ $Param{NotifyData} || [] },
                {
                    Info => $SynchronizeMessage,
                },
            ];
        }

        return $Self->_ShowOverview(
            %Param,
        );
    }

    # ------------------------------------------------------------ #
    # ACLNew
    # ------------------------------------------------------------ #
    elsif ( $Self->{Subaction} eq 'ACLNew' ) {

        return $Self->_ShowEdit(
            %Param,
            Action => 'New',
        );
    }

    # ------------------------------------------------------------ #
    # ACLNewAction
    # ------------------------------------------------------------ #
    elsif ( $Self->{Subaction} eq 'ACLNewAction' ) {

        # challenge token check for write action
        $LayoutObject->ChallengeTokenCheck();

        # get ACL data
        my $ACLData;

        # get parameter from web browser
        my $GetParam = $Self->_GetParams();

        # set new confguration
        $ACLData->{Name}           = $GetParam->{Name};
        $ACLData->{Comment}        = $GetParam->{Comment};
        $ACLData->{Description}    = $GetParam->{Description};
        $ACLData->{StopAfterMatch} = $GetParam->{StopAfterMatch} || 0;
        $ACLData->{ValidID}        = $GetParam->{ValidID};

        # check required parameters
        my %Error;
        if ( !$GetParam->{Name} ) {

            # add server error error class
            $Error{NameServerError}        = 'ServerError';
            $Error{NameServerErrorMessage} = Translatable('This field is required');
        }

        if ( !$GetParam->{ValidID} ) {

            # add server error error class
            $Error{ValidIDServerError}        = 'ServerError';
            $Error{ValidIDServerErrorMessage} = Translatable('This field is required');
        }

        # if there is an error return to edit screen
        if ( IsHashRefWithData( \%Error ) ) {
            return $Self->_ShowEdit(
                %Error,
                %Param,
                ACLData => $ACLData,
                Action  => 'New',
            );
        }

        # otherwise save configuration and return to overview screen
        my $ACLID = $ACLObject->ACLAdd(
            Name           => $ACLData->{Name},
            Comment        => $ACLData->{Comment},
            Description    => $ACLData->{Description},
            StopAfterMatch => $ACLData->{StopAfterMatch},
            ValidID        => $ACLData->{ValidID},
            UserID         => $Self->{UserID},
# RotherOSS / ITSMConfigurationManagement
            ObjectType     => $Param{ObjectType},
# EO ITSMConfigurationManagement
        );

        # show error if can't create
        if ( !$ACLID ) {
            return $LayoutObject->ErrorScreen(
                Message => Translatable('There was an error creating the ACL'),
            );
        }

        # redirect to edit screen
# RotherOSS / ITSMConfigurationManagement
#         return $LayoutObject->Redirect( OP => "Action=$Self->{Action};Subaction=ACLEdit;ID=$ACLID" );
        return $LayoutObject->Redirect( OP => "Action=$Self->{Action};Subaction=ACLEdit;ID=$ACLID;ObjectType=$Param{ObjectType}" );
# EO ITSMConfigurationManagement
    }

    # ------------------------------------------------------------ #
    # ACLEdit
    # ------------------------------------------------------------ #
    elsif ( $Self->{Subaction} eq 'ACLEdit' ) {

        # check for ACLID
        if ( !$ACLID ) {
            return $LayoutObject->ErrorScreen(
                Message => Translatable('Need ACLID!'),
            );
        }

        # get ACL data
        my $ACLData = $ACLObject->ACLGet(
            ID     => $ACLID,
            UserID => $Self->{UserID},
        );

        # check for valid ACL data
        if ( !IsHashRefWithData($ACLData) ) {
            return $LayoutObject->ErrorScreen(
                Message => $LayoutObject->{LanguageObject}->Translate( 'Could not get data for ACLID %s', $ACLID ),
            );
        }

        my $JSONObject = $Kernel::OM->Get('Kernel::System::JSON');

        if ( $ACLData->{ConfigMatch} ) {
            $ACLData->{ConfigMatch} = $JSONObject->Encode(
                Data => $ACLData->{ConfigMatch},
            );
        }

        if ( $ACLData->{ConfigChange} ) {
            $ACLData->{ConfigChange} = $JSONObject->Encode(
                Data => $ACLData->{ConfigChange},
            );
        }

        return $Self->_ShowEdit(
            %Param,
            ACLID   => $ACLID,
            ACLData => $ACLData,
            Action  => 'Edit',
        );
    }

    # ------------------------------------------------------------ #
    # ACLEditAction
    # ------------------------------------------------------------ #
    elsif ( $Self->{Subaction} eq 'ACLEditAction' ) {

        # challenge token check for write action
        $LayoutObject->ChallengeTokenCheck();

        # get webserice configuration
        my $ACLData;

        # get parameter from web browser
        my $GetParam = $Self->_GetParams();

        # set new confguration
        $ACLData->{Name}           = $GetParam->{Name};
        $ACLData->{Comment}        = $GetParam->{Comment};
        $ACLData->{Description}    = $GetParam->{Description};
        $ACLData->{StopAfterMatch} = $GetParam->{StopAfterMatch} || 0;
        $ACLData->{ValidID}        = $GetParam->{ValidID};
        $ACLData->{ConfigMatch}    = $GetParam->{ConfigMatch}  || '';
        $ACLData->{ConfigChange}   = $GetParam->{ConfigChange} || '';
# RotherOSS / ITSMConfigurationManagement
        $ACLData->{ObjectType}     = $GetParam->{ObjectType} || 'Ticket';
# EO ITSMConfigurationManagement

        # check required parameters
        my %Error;
        if ( !$GetParam->{Name} ) {

            # add server error error class
            $Error{NameServerError}        = 'ServerError';
            $Error{NameServerErrorMessage} = Translatable('This field is required');
        }

        if ( !$GetParam->{ValidID} ) {

            # add server error error class
            $Error{ValidIDServerError}        = 'ServerError';
            $Error{ValidIDServerErrorMessage} = Translatable('This field is required');
        }

        # if there is an error return to edit screen
        if ( IsHashRefWithData( \%Error ) ) {
            return $Self->_ShowEdit(
                %Error,
                %Param,
                ACLData => $ACLData,
                Action  => 'Edit',
            );
        }

        # otherwise save configuration and return to overview screen
        my $Success = $ACLObject->ACLUpdate(
            ID             => $ACLID,
            Name           => $ACLData->{Name},
            Comment        => $ACLData->{Comment},
            Description    => $ACLData->{Description},
            StopAfterMatch => $ACLData->{StopAfterMatch} || 0,
            ValidID        => $ACLData->{ValidID},
            ConfigMatch    => $ACLData->{ConfigMatch}  || '',
            ConfigChange   => $ACLData->{ConfigChange} || '',
            UserID         => $Self->{UserID},
# RotherOSS / ITSMConfigurationManagement
            ObjectType     => $Param{ObjectType},
# EO ITSMConfigurationManagement
        );

        # show error if can't update
        if ( !$Success ) {
            return $LayoutObject->ErrorScreen(
                Message => Translatable('There was an error updating the ACL'),
            );
        }

        if (
            defined $ParamObject->GetParam( Param => 'ContinueAfterSave' )
            && ( $ParamObject->GetParam( Param => 'ContinueAfterSave' ) eq '1' )
            )
        {

            # if the user would like to continue editing the ACL, just redirect to the edit screen
            return $LayoutObject->Redirect(
                OP =>
# RotherOSS / ITSMConfigurationManagement
#                     "Action=AdminACL;Subaction=ACLEdit;ID=$ACLID"
                    "Action=AdminACL;Subaction=ACLEdit;ID=$ACLID;ObjectType=$Param{ObjectType}"
# EO ITSMConfigurationManagement
            );
        }
        else {

            # otherwise return to overview
# RotherOSS / ITSMConfigurationManagement
#             return $LayoutObject->Redirect( OP => "Action=$Self->{Action}" );
            return $LayoutObject->Redirect( OP => "Action=$Self->{Action};ObjectType=$Param{ObjectType}" );
# EO ITSMConfigurationManagement
        }
    }

    # ------------------------------------------------------------ #
    # Sync
    # ------------------------------------------------------------ #
    elsif ( $Self->{Subaction} eq 'ACLDeploy' ) {

        my $Location = $Kernel::OM->Get('Kernel::Config')->Get('Home') . '/Kernel/Config/Files/ZZZACL.pm';

        my $ACLDumpSuccess = $ACLObject->ACLDump(
            ResultType => 'FILE',
            Location   => $Location,
            UserID     => $Self->{UserID},
# RotherOSS / ITSMConfigurationManagement
            ObjectType => $Param{ObjectType},
# EO ITSMConfigurationManagement
        );

        if ($ACLDumpSuccess) {

            my $Success = $ACLObject->ACLsNeedSyncReset();

            # remove preselection cache TODO: rebuild the cache properly (a simple $FieldRestrictionsObject->SetACLPreselectionCache(); uses the old ACLs)
            my $CacheObject = $Kernel::OM->Get('Kernel::System::Cache');
            $CacheObject->Delete(
                Type => 'TicketACL',      # only [a-zA-Z0-9_] chars usable
                Key  => 'Preselection',
            );

            if ($Success) {
# RotherOSS / ITSMConfigurationManagement
#                 return $LayoutObject->Redirect( OP => "Action=$Self->{Action}" );
                return $LayoutObject->Redirect( OP => "Action=$Self->{Action};ObjectType=$Param{ObjectType}" );
# EO ITSMConfigurationManagement
            }
            else {

                # show error if can't set state
                return $LayoutObject->ErrorScreen(
                    Message => Translatable('There was an error setting the entity sync status.'),
                );
            }
        }
        else {

            # show error if can't synch
            return $LayoutObject->ErrorScreen(
                Message => Translatable('There was an error synchronizing the ACLs.'),
            );
        }
    }

    # ------------------------------------------------------------ #
    # ACLDelete AJAX
    # ------------------------------------------------------------ #
    elsif ( $Self->{Subaction} eq 'ACLDelete' ) {

        # challenge token check for write action
        $LayoutObject->ChallengeTokenCheck();

        # check for ACLID
        return if !$ACLID;

        my $CheckResult = $Self->_CheckACLDelete( ID => $ACLID );

        my $JSON;
        if ( $CheckResult->{Success} ) {

            my $Success = $ACLObject->ACLDelete(
                ID     => $ACLID,
                UserID => $Self->{UserID},
            );

            my %DeleteResult = (
                Success => $Success,
            );

            if ( !$Success ) {
                $DeleteResult{Message} = $LayoutObject->{LanguageObject}->Translate( 'ACL %s could not be deleted', $ACLID );
            }

            # build JSON output
            $JSON = $LayoutObject->JSONEncode(
                Data => {
                    %DeleteResult,
                },
            );
        }
        else {

            # build JSON output
            $JSON = $LayoutObject->JSONEncode(
                Data => {
                    %{$CheckResult},
                },
            );
        }

        # send JSON response
        return $LayoutObject->Attachment(
            ContentType => 'application/json; charset=' . $LayoutObject->{Charset},
            Content     => $JSON,
            Type        => 'inline',
            NoCache     => 1,
        );
    }

    # ------------------------------------------------------------ #
    # ACLExport
    # ------------------------------------------------------------ #
    elsif ( $Self->{Subaction} eq 'ACLExport' ) {

        my $ACLID = $ParamObject->GetParam( Param => 'ID' ) || '';
        my $ACLData;
        my $ACLSingleData;
# RotherOSS / ITSMConfigurationManagement
#         my $Filename = 'Export_ACL.yml';
        my $Filename =  'Export_' . $Param{ObjectType} . '_ACL.yml';
# EO ITSMConfigurationManagement

        if ($ACLID) {

            $ACLSingleData = $ACLObject->ACLGet(
                ID     => $ACLID,
                UserID => 1,
            );

            if ( !$ACLSingleData || !IsHashRefWithData($ACLSingleData) ) {
                return $LayoutObject->ErrorScreen(
                    Message => $LayoutObject->{LanguageObject}->Translate( 'There was an error getting data for ACL with ID %s', $ACLID ),
                );
            }

            my $ACLName = $ACLSingleData->{Name};
            $ACLName =~ s{[^a-zA-Z0-9-_]}{_}xmsg;    # cleanup name for saving

# RotherOSS / ITSMConfigurationManagement
#             $Filename = 'Export_ACL_' . $ACLName . '.yml';
            $Filename = 'Export_' . $Param{ObjectType} . '_ACL_' . $ACLName . '.yml';
# EO ITSMConfigurationManagement
            $ACLData  = [$ACLSingleData];
        }
        else {

            # Get all IDs from valid table including invalid-temporarily status.
            # See bug#13592 (https://bugs.otrs.org/show_bug.cgi?id=13592).
            my %ValidList    = $Kernel::OM->Get('Kernel::System::Valid')->ValidList();
            my @ValidListIDs = grep { $ValidList{$_} } sort keys %ValidList;

            $ACLData = $ACLObject->ACLListGet(
                UserID   => 1,
                ValidIDs => \@ValidListIDs,
# RotherOSS / ITSMConfigurationManagement
                ObjectTypes => [$Param{ObjectType}],
# EO ITSMConfigurationManagement
            );
        }

        # convert the ACL data hash to string
        my $ACLDataYAML = $Kernel::OM->Get('Kernel::System::YAML')->Dump( Data => $ACLData );

        # send the result to the browser
        return $LayoutObject->Attachment(
            ContentType => 'text/html; charset=' . $LayoutObject->{Charset},
            Content     => $ACLDataYAML,
            Type        => 'attachment',
            Filename    => $Filename,
            NoCache     => 1,
        );
    }

    # ------------------------------------------------------------ #
    # ACLCopy
    # ------------------------------------------------------------ #
    elsif ( $Self->{Subaction} eq 'ACLCopy' ) {

        # challenge token check for write action
        $LayoutObject->ChallengeTokenCheck();

# RotherOSS / ITSMConfigurationManagement
        # TODO Decide wether aclget should differentiate between object types
# EO ITSMConfigurationManagement
        # get ACL data
        my $ACLData = $ACLObject->ACLGet(
            ID     => $ACLID,
            UserID => $Self->{UserID},
        );
        if ( !$ACLData ) {
            return $LayoutObject->ErrorScreen(
                Message => "Unknown ACL $ACLID!",
            );
        }

        # Create new ACL name.
        my $Count   = 1;
        my $ACLName = $LayoutObject->{LanguageObject}->Translate( '%s (copy) %s', $ACLData->{Name}, $Count );
        while (
            $ACLObject->ACLGet(
                Name   => $ACLName,
                UserID => $Self->{UserID}
            )
            && $Count < 100
            )
        {
            $ACLName =~ s/\d+$/$Count/;
            $Count++;
        }

        # otherwise save configuration and return to overview screen
        my $ACLID = $ACLObject->ACLAdd(
            Name           => $ACLName,
            Comment        => $ACLData->{Comment},
            Description    => $ACLData->{Description},
            ConfigMatch    => $ACLData->{ConfigMatch}    || '',
            ConfigChange   => $ACLData->{ConfigChange}   || '',
            StopAfterMatch => $ACLData->{StopAfterMatch} || 0,
            ValidID        => $ACLData->{ValidID},
            UserID         => $Self->{UserID},
# RotherOSS / ITSMConfigurationManagement
            ObjectType     => $Param{ObjectType},
# EO ITSMConfigurationManagement
        );

        # show error if can't create
        if ( !$ACLID ) {
            return $LayoutObject->ErrorScreen(
                Message => Translatable('There was an error creating the ACL'),
            );
        }

        # return to overview
# RotherOSS / ITSMConfigurationManagement
#         return $LayoutObject->Redirect( OP => "Action=$Self->{Action}" );
        return $LayoutObject->Redirect( OP => "Action=$Self->{Action};ObjectType=$Param{ObjectType}" );
# EO ITSMConfigurationManagement
    }

    # ------------------------------------------------------------ #
    # Overview
    # ------------------------------------------------------------ #
    else {
        return $Self->_ShowOverview(
            %Param,
        );
    }
}

sub _ShowOverview {
    my ( $Self, %Param ) = @_;

    my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');
    my $ACLObject    = $Kernel::OM->Get('Kernel::System::ACL::DB::ACL');
    my $Output       = $LayoutObject->Header();
    $Output .= $LayoutObject->NavigationBar();

    if ( $Self->{UserID} == 1 ) {

        # show error notfy, don't work with user id 1
        $Output .= $LayoutObject->Notify(
            Priority => 'Error',
            Info     =>
                Translatable('Please note that ACL restrictions will be ignored for the Superuser account (UserID 1).'),
        );
    }

    # show notifications if any
    if ( $Param{NotifyData} ) {
        for my $Notification ( @{ $Param{NotifyData} } ) {
            $Output .= $LayoutObject->Notify(
                %{$Notification},
            );
        }
    }

# RotherOSS / ITSMConfigurationManagement
    $Param{ObjectTypeSelectionStrg} = $LayoutObject->BuildSelection(
        Name          => 'ObjectType',
        Data          => {
            Ticket         => 'Ticket',
            ITSMConfigItem => 'ITSM ConfigItem',
        },
        PossibleNone  => 0,
        Translation   => 0,
        SelectedValue => $Param{ObjectType} || 'Ticket',
        Class         => 'Modernize W75pc',
    );
# EO ITSMConfigurationManagement

    # get ACL list
# RotherOSS / ITSMConfigurationManagement
#     my $ACLList = $ACLObject->ACLList( UserID => $Self->{UserID} );
    my $ACLList = $ACLObject->ACLList(
        UserID      => $Self->{UserID},
        ObjectTypes => [$Param{ObjectType}],
    );
# EO ITSMConfigurationManagement


    if ( IsHashRefWithData($ACLList) ) {

        # sort data numerically
        my @ACLIDsSorted = sort { $ACLList->{$a} cmp $ACLList->{$b} } keys %{$ACLList};

        # get each ACLs data
        for my $ACLID (@ACLIDsSorted) {

            my $ACLData = $ACLObject->ACLGet(
                ID     => $ACLID,
                UserID => $Self->{UserID},
            );

            # set the valid state
            $ACLData->{ValidID} = $Kernel::OM->Get('Kernel::System::Valid')->ValidLookup( ValidID => $ACLData->{ValidID} );

            # print each ACL in overview table
            $LayoutObject->Block(
                Name => 'ACLRow',
                Data => {
                    %{$ACLData},
                },
            );
        }
    }
    else {

        # print no data found message
        $LayoutObject->Block(
            Name => 'ACLNoDataRow',
            Data => {},
        );
    }

    $Output .= $LayoutObject->Output(
        TemplateFile => 'AdminACL',
        Data         => \%Param,
    );
    $Output .= $LayoutObject->Footer();

    return $Output;
}

sub _ShowEdit {
    my ( $Self, %Param ) = @_;

    my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');
    my $ConfigObject = $Kernel::OM->Get('Kernel::Config');

    # get ACL information
    my $ACLData = $Param{ACLData} || {};

    # decide whether to show delete button
    if ( $Param{Action} eq 'Edit' && $ACLData && $ACLData->{ValidID} ne '1' ) {
        $LayoutObject->Block(
            Name => 'ACLDeleteAction',
            Data => {
                %{$ACLData},
            },
        );
    }

    # get valid list
    my %ValidList = $Kernel::OM->Get('Kernel::System::Valid')->ValidList();

    $Param{ValidOption} = $LayoutObject->BuildSelection(
        Data       => \%ValidList,
        Name       => 'ValidID',
        SelectedID => $ACLData->{ValidID} || $ValidList{valid},
        Class      => 'Modernize Validate_Required ' . ( $Param{Errors}->{'ValidIDInvalid'} || '' ),
    );

# RotherOSS / ITSMConfigurationManagement
    # TODO Build new ACL Key data
# EO ITSMConfigurationManagement
    my $ACLKeysLevel1Match = $ConfigObject->Get('ACLKeysLevel1Match') || {};
    $Param{ACLKeysLevel1Match} = $LayoutObject->BuildSelection(
        Data         => $ACLKeysLevel1Match,
        Name         => 'ItemAdd',
        Class        => 'Modernize ItemAdd ItemAddLevel1',
        ID           => 'ItemAddLevel1Match',
        TreeView     => 1,
        PossibleNone => 1,
        Translation  => 0,
    );

    my $ACLKeysLevel1Change = $ConfigObject->Get('ACLKeysLevel1Change') || {};
    $Param{ACLKeysLevel1Change} = $LayoutObject->BuildSelection(
        Data         => $ACLKeysLevel1Change,
        Name         => 'ItemAdd',
        Class        => 'Modernize ItemAdd ItemAddLevel1',
        ID           => 'ItemAddLevel1Change',
        TreeView     => 1,
        PossibleNone => 1,
        Translation  => 0,
    );

    my $ACLKeysLevel2Possible = $ConfigObject->Get('ACLKeysLevel2::Possible') || {};
    $Param{ACLKeysLevel2Possible} = $LayoutObject->BuildSelection(
        Data         => $ACLKeysLevel2Possible,
        Name         => 'ItemAdd',
        ID           => 'Possible',
        Class        => 'Modernize ItemAdd LevelToBeAdded',
        Translation  => 0,
        PossibleNone => 1,
    );

    my $ACLKeysLevel2PossibleAdd = $ConfigObject->Get('ACLKeysLevel2::PossibleAdd') || {};
    $Param{ACLKeysLevel2PossibleAdd} = $LayoutObject->BuildSelection(
        Data         => $ACLKeysLevel2PossibleAdd,
        Name         => 'ItemAdd',
        ID           => 'PossibleAdd',
        Class        => 'Modernize ItemAdd LevelToBeAdded',
        Translation  => 0,
        PossibleNone => 1,
    );

    my $ACLKeysLevel2PossibleNot = $ConfigObject->Get('ACLKeysLevel2::PossibleNot') || {};
    $Param{ACLKeysLevel2PossibleNot} = $LayoutObject->BuildSelection(
        Data         => $ACLKeysLevel2PossibleNot,
        Name         => 'ItemAdd',
        ID           => 'PossibleNot',
        Class        => 'Modernize ItemAdd LevelToBeAdded',
        Translation  => 0,
        PossibleNone => 1,
    );

    my $ACLKeysLevel2Properties = $ConfigObject->Get('ACLKeysLevel2::Properties') || {};
    $Param{ACLKeysLevel2Properties} = $LayoutObject->BuildSelection(
        Data         => $ACLKeysLevel2Properties,
        Name         => 'ItemAdd',
        ID           => 'Properties',
        Class        => 'Modernize ItemAdd LevelToBeAdded',
        Translation  => 0,
        PossibleNone => 1,
    );

    my $ACLKeysLevel2PropertiesDatabase = $ConfigObject->Get('ACLKeysLevel2::PropertiesDatabase') || {};
    $Param{ACLKeysLevel2PropertiesDatabase} = $LayoutObject->BuildSelection(
        Data         => $ACLKeysLevel2PropertiesDatabase,
        Name         => 'ItemAdd',
        ID           => 'PropertiesDatabase',
        Class        => 'Modernize ItemAdd LevelToBeAdded',
        Translation  => 0,
        PossibleNone => 1,
    );

    $Param{ACLKeysLevel4Prefixes} = $LayoutObject->BuildSelection(
        Data => {
            ''            => Translatable('Exact match'),
            '[Not]'       => Translatable('Negated exact match'),
            '[RegExp]'    => Translatable('Regular expression'),
            '[regexp]'    => Translatable('Regular expression (ignore case)'),
            '[NotRegExp]' => Translatable('Negated regular expression'),
            '[Notregexp]' => Translatable('Negated regular expression (ignore case)'),
        },
        Name           => 'ItemPrefix',
        Class          => 'ItemPrefix',
        ID             => 'Prefixes',
        Sort           => 'IndividualKey',
        SortIndividual => [ '', '[Not]', '[RegExp]', '[regexp]', '[NotRegExp]', '[Notregexp]' ],
        Translation    => 0,
        AutoComplete   => 'off',
    );

    # get list of all possible dynamic fields
    my $DynamicFieldList = $Kernel::OM->Get('Kernel::System::DynamicField')->DynamicFieldList(
# RotherOSS / ITSMConfigurationManagement
#         ObjectType => 'Ticket',
        ObjectType => $Param{ObjectType},
# EO ITSMConfigurationManagement
        ResultType => 'HASH',
    );
    my %DynamicFieldNames = reverse %{$DynamicFieldList};
    my %DynamicFields;
    for my $DynamicFieldName ( sort keys %DynamicFieldNames ) {
        $DynamicFields{ 'DynamicField_' . $DynamicFieldName } = $DynamicFieldName;
    }
    $Param{ACLKeysLevel3DynamicFields} = $LayoutObject->BuildSelection(
        Data         => \%DynamicFields,
        Name         => 'NewDataKeyDropdown',
        Class        => 'Modernize NewDataKeyDropdown',
        ID           => 'DynamicField',
        Translation  => 0,
        PossibleNone => 1,
    );

    # get list of all possible actions
    my @PossibleActionsList;
    my $ACLKeysLevel3Actions = $ConfigObject->Get('ACLKeysLevel3::Actions') || [];

    for my $Key ( sort keys %{$ACLKeysLevel3Actions} ) {
        push @PossibleActionsList, @{ $ACLKeysLevel3Actions->{$Key} };
    }

    $Param{ACLKeysLevel3Actions} = $LayoutObject->BuildSelection(
        Data         => \@PossibleActionsList,
        Name         => 'NewDataKeyDropdown',
        Class        => 'Modernize NewDataKeyDropdown Boolean',
        ID           => 'Action',
        Translation  => 0,
        PossibleNone => 1,
    );

    $Param{PossibleActionsList} = \@PossibleActionsList;

    if ( defined $ACLData->{StopAfterMatch} && $ACLData->{StopAfterMatch} == 1 ) {
        $Param{Checked} = 'checked="checked"';
    }

    my $Output = $LayoutObject->Header();
    $Output .= $LayoutObject->NavigationBar();

    # show notifications if any
    if ( $Param{NotifyData} ) {
        for my $Notification ( @{ $Param{NotifyData} } ) {
            $Output .= $LayoutObject->Notify(
                %{$Notification},
            );
        }
    }

    # create data for JS
    my @ACLEditPossibleActionsList;
    for my $Item (@PossibleActionsList) {
        my %ACLEdit = (
            label => $Item,
            value => $Item
        );
        push @ACLEditPossibleActionsList, \%ACLEdit;
    }

    # set ACL data
    $LayoutObject->AddJSData(
        Key   => 'PossibleActionsList',
        Value => \@ACLEditPossibleActionsList,
    );

# RotherOSS / ITSMConfigurationManagement
    # TODO Decide wether to handle the object type differentiation
# EO ITSMConfigurationManagement
    $Output .= $LayoutObject->Output(
        TemplateFile => "AdminACL$Param{Action}",
        Data         => {
            %Param,
            %{$ACLData},
        },
    );

    $Output .= $LayoutObject->Footer();

    return $Output;
}

sub _GetParams {
    my ( $Self, %Param ) = @_;

    my $JSONObject = $Kernel::OM->Get('Kernel::System::JSON');
    my $GetParam;

    # get parameters from web browser
    for my $ParamName (
# RotherOSS / ITSMConfigurationManagement
#         qw( Name EntityID Comment Description StopAfterMatch ValidID ConfigMatch ConfigChange )
        qw( Name ObjectType EntityID Comment Description StopAfterMatch ValidID ConfigMatch ConfigChange )
# EO ITSMConfigurationManagement
        )
    {
        $GetParam->{$ParamName} = $Kernel::OM->Get('Kernel::System::Web::Request')->GetParam( Param => $ParamName )
            || '';
    }

    if ( $GetParam->{ConfigMatch} ) {
        $GetParam->{ConfigMatch} = $JSONObject->Decode(
            Data => $GetParam->{ConfigMatch},
        );
        if ( !IsHashRefWithData( $GetParam->{ConfigMatch} ) ) {
            $GetParam->{ConfigMatch} = undef;
        }
    }

    if ( $GetParam->{ConfigChange} ) {
        $GetParam->{ConfigChange} = $JSONObject->Decode(
            Data => $GetParam->{ConfigChange},
        );
        if ( !IsHashRefWithData( $GetParam->{ConfigChange} ) ) {
            $GetParam->{ConfigChange} = undef;
        }
    }

    return $GetParam;
}

sub _CheckACLDelete {
    my ( $Self, %Param ) = @_;

    # get ACL data
    my $ACLData = $Kernel::OM->Get('Kernel::System::ACL::DB::ACL')->ACLGet(
        ID     => $Param{ID},
        UserID => $Self->{UserID},
    );

    # check for valid ACL data
    if ( !IsHashRefWithData($ACLData) ) {
        return {
            Success => 0,
            Message => "Could not get data for ACLID $Param{ID}",
        };
    }

    return {
        Success => 1,
        ACLData => $ACLData,
    };
}

1;

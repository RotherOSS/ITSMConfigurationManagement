# --
# OTOBO is a web-based ticketing system for service organisations.
# --
# Copyright (C) 2001-2020 OTRS AG, https://otrs.com/
# Copyright (C) 2019-2021 Rother OSS GmbH, https://otobo.de/
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

package Kernel::Modules::AgentITSMConfigItemEdit;

use strict;
use warnings;

## nofilter(TidyAll::Plugin::OTOBO::Migrations::OTOBO6::SysConfig)

use Kernel::System::VariableCheck qw(:all);
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

    # my param object
    my $ParamObject = $Kernel::OM->Get('Kernel::System::Web::Request');

    # get configitem id and class id
    my $ConfigItem = {};
    $ConfigItem->{ConfigItemID} = $ParamObject->GetParam( Param => 'ConfigItemID' ) || 0;
    $ConfigItem->{ClassID}      = $ParamObject->GetParam( Param => 'ClassID' )      || 0;
    my $DuplicateID = $ParamObject->GetParam( Param => 'DuplicateID' ) || 0;

    my $HasAccess;

    # get needed objects
    my $ConfigItemObject          = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');
    my $DynamicFieldBackendObject = $Kernel::OM->Get('Kernel::System::DynamicField::Backend');
    my $GeneralCatalogObject      = $Kernel::OM->Get('Kernel::System::GeneralCatalog');
    my $ConfigObject              = $Kernel::OM->Get('Kernel::Config');
    my $LayoutObject              = $Kernel::OM->Get('Kernel::Output::HTML::Layout');

    # get config of frontend module
    $Self->{Config} = $ConfigObject->Get("ITSMConfigItem::Frontend::$Self->{Action}");

    my %DynamicFieldValues;

    # get the dynamic fields for this screen
    my $DynamicFieldList = $Kernel::OM->Get('Kernel::System::DynamicField')->DynamicFieldListGet(
        Valid       => 1,
        ObjectType  => [ 'ITSMConfigItem' ],
#         FieldFilter => {},
    );

    my %DynamicFieldValueCount;
    DYNAMICFIELD:
    for my $DynamicFieldConfig ( $DynamicFieldList->@* ) {
        next DYNAMICFIELD if !IsHashRefWithData($DynamicFieldConfig);

        # extract the dynamic field value from the web request
        $DynamicFieldValues{ $DynamicFieldConfig->{Name} } = $DynamicFieldBackendObject->EditFieldValueGet(
            DynamicFieldConfig => $DynamicFieldConfig,
            ParamObject        => $ParamObject,
            LayoutObject       => $LayoutObject,
        );
        $DynamicFieldValueCount{ $DynamicFieldConfig->{Name} } = 1;
    }

    my %GetParam = ();
    # convert dynamic field values into a structure for ACLs
    my %DynamicFieldACLParameters;
    DYNAMICFIELD:
    for my $DynamicField ( sort keys %DynamicFieldValues ) {
        next DYNAMICFIELD if !$DynamicField;
        next DYNAMICFIELD if !$DynamicFieldValues{$DynamicField};

        $DynamicFieldACLParameters{ 'DynamicField_' . $DynamicField } = $DynamicFieldValues{$DynamicField};
    }
    $GetParam{DynamicField} = \%DynamicFieldACLParameters;

    # create html strings for all dynamic fields
    my %Error;
    my %DynamicFieldHTML;
    DYNAMICFIELD:
    for my $DynamicFieldConfig ( $DynamicFieldList->@* ) {
        next DYNAMICFIELD if !IsHashRefWithData($DynamicFieldConfig);

        my $PossibleValuesFilter;

        # perform ACLs on values
        my $IsACLReducible = $DynamicFieldBackendObject->HasBehavior(
            DynamicFieldConfig => $DynamicFieldConfig,
            Behavior           => 'IsACLReducible'
        );

        if ($IsACLReducible) {

            # get PossibleValues
            my $PossibleValues = $DynamicFieldBackendObject->PossibleValuesGet(
                DynamicFieldConfig => $DynamicFieldConfig,
            );

            # check if field has PossibleValues property in its configuration
            if (IsHashRefWithData($PossibleValues)) {

                # convert possible values key => value to key => key for ACLs using a Hash slice
                my %AclData = %{$PossibleValues};
                @AclData{ keys %AclData } = keys %AclData;

                # set possible values filter from ACLs
                my $ACL = $ConfigItemObject->ConfigItemAcl(
                    %GetParam,
                    Action        => $Self->{Action},
                    ReturnType    => 'ITSMConfigItem',
                    ReturnSubType => 'DynamicField_' . $DynamicFieldConfig->{Name},
                    Data          => \%AclData,
                    UserID        => $Self->{UserID},
                );
                if ($ACL) {
                    my %Filter = $ConfigItemObject->ConfigItemAclData();

                    # convert Filter key => key back to key => value using map
                    %{$PossibleValuesFilter} = map { $_ => $PossibleValues->{$_} } keys %Filter;
                }
            }
        }

        # perform validation
        my $ValidationResult = $DynamicFieldBackendObject->EditFieldValueValidate(
            DynamicFieldConfig   => $DynamicFieldConfig,
            PossibleValuesFilter => $PossibleValuesFilter,
            ParamObject          => $ParamObject,
        );

        if (!IsHashRefWithData($ValidationResult)) {
            return $LayoutObject->ErrorScreen(
                Message => $LayoutObject->{LanguageObject}->Translate("Could not perform validation on field $DynamicFieldConfig->{Label}!"),
                Comment => Translatable('Please contact the administrator.'),
            );
        }

        # propagate validation error to the Error variable to be detected by the frontend
        if ($ValidationResult->{ServerError}) {
            $Error{ $DynamicFieldConfig->{Name} } = ' ServerError';
        }


        # Fill dynamic field values with empty strings till it matches the maximum value count
        if ( $DynamicFieldConfig->{Config}{MultiValue} ) {
            if (ref $GetParam{DynamicField}{"DynamicField_$DynamicFieldConfig->{Name}"} ne 'ARRAY') {
                $GetParam{DynamicField}{"DynamicField_$DynamicFieldConfig->{Name}"} = [ $GetParam{DynamicField}{"DynamicField_$DynamicFieldConfig->{Name}"} ];
            }
            # $GetParam{DynamicField}{"DynamicField_$DynamicFieldConfig->{Name}"} ||= [];

            while ( ( scalar $GetParam{DynamicField}{"DynamicField_$DynamicFieldConfig->{Name}"}->@* ) < $DynamicFieldValueCount{ $DynamicFieldConfig->{Name} } ) {
                push $GetParam{DynamicField}{"DynamicField_$DynamicFieldConfig->{Name}"}->@*, '';
            }
        }

        $DynamicFieldHTML{ $DynamicFieldConfig->{Name} } = $DynamicFieldBackendObject->EditFieldRender(
            DynamicFieldConfig   => $DynamicFieldConfig,
            PossibleValuesFilter => $PossibleValuesFilter,
            ServerError          => $ValidationResult->{ServerError} || '',
            ErrorMessage         => $ValidationResult->{ErrorMessage} || '',
            LayoutObject         => $LayoutObject,
            ParamObject          => $ParamObject,
            AJAXUpdate           => 1,
        );

    }

    $Param{DynamicFieldHTML} = \%DynamicFieldHTML;

    # get needed data
    if ( $ConfigItem->{ConfigItemID} && $ConfigItem->{ConfigItemID} ne 'NEW' ) {

        # check access for config item
        $HasAccess = $ConfigItemObject->Permission(
            Scope  => 'Item',
            ItemID => $ConfigItem->{ConfigItemID},
            UserID => $Self->{UserID},
            Type   => $Self->{Config}->{Permission},
        );

        # get config item
        $ConfigItem = $ConfigItemObject->ConfigItemGet(
            ConfigItemID  => $ConfigItem->{ConfigItemID},
            DynamicFields => 1,
        );
    }
    elsif ($DuplicateID) {

        # TODO: Check duplication
        # get config item to duplicate
        $ConfigItem = $ConfigItemObject->ConfigItemGet(
            ConfigItemID => $DuplicateID,
        );

        # check access for config item
        $HasAccess = $ConfigItemObject->Permission(
            Scope  => 'Item',
            ItemID => $ConfigItem->{ConfigItemID},
            UserID => $Self->{UserID},
            Type   => $Self->{Config}->{Permission},
        );

        # set config item id and number
        $ConfigItem->{ConfigItemID} = 'NEW';
        $ConfigItem->{Number}       = Translatable('New');
    }
    elsif ( $ConfigItem->{ClassID} ) {

        # set config item id and number
        $ConfigItem->{ConfigItemID} = 'NEW';
        $ConfigItem->{Number}       = Translatable('New');

        # check access for config item
        $HasAccess = $ConfigItemObject->Permission(
            Scope   => 'Class',
            ClassID => $ConfigItem->{ClassID},
            UserID  => $Self->{UserID},
            Type    => $Self->{Config}->{Permission},
        );

        # get class list
        my $ClassList = $GeneralCatalogObject->ItemList(
            Class => 'ITSM::ConfigItem::Class',
        );
        $ConfigItem->{Class} = $ClassList->{ $ConfigItem->{ClassID} };
    }
    else {
        return $LayoutObject->ErrorScreen(
            Message => Translatable('No ConfigItemID, DuplicateID or ClassID is given!'),
            Comment => Translatable('Please contact the administrator.'),
        );
    }

    # if user has no access rights show error page
    if ( !$HasAccess ) {
        return $LayoutObject->ErrorScreen(
            Message => Translatable('No access is given!'),
            Comment => Translatable('Please contact the administrator.'),
        );
    }

    # get definition
    my $Definition = $ConfigItemObject->DefinitionGet(
        ClassID => $ConfigItem->{ClassID},
    );

    # abort, if no definition is defined
    if ( !$Definition->{DefinitionID} ) {
        return $LayoutObject->ErrorScreen(
            Message => $LayoutObject->{LanguageObject}->Translate( 'No definition was defined for class %s!', $ConfigItem->{Class} ),
            Comment => Translatable('Please contact the administrator.'),
        );
    }

    # get upload cache object
    my $UploadCacheObject = $Kernel::OM->Get('Kernel::System::Web::UploadCache');

    # get form id
    $Self->{FormID} = $ParamObject->GetParam( Param => 'FormID' );

    # create form id
    if ( !$Self->{FormID} ) {
        $Self->{FormID} = $UploadCacheObject->FormIDCreate();
    }

    # when there's no ClassID it means, an existing config item is edited as the ClassID is only
    # provided as GET param when creating a new config item
    if ( !$ParamObject->GetParam( Param => 'ClassID' ) ) {

        # get all attachments meta data
        my @ExistingAttachments = $ConfigItemObject->ConfigItemAttachmentList(
            ConfigItemID => $ConfigItem->{ConfigItemID},
        );

        # copy all existing attachments to upload cache
        FILENAME:
        for my $Filename (@ExistingAttachments) {

            # get the existing attachment data
            my $AttachmentData = $ConfigItemObject->ConfigItemAttachmentGet(
                ConfigItemID => $ConfigItem->{ConfigItemID},
                Filename     => $Filename,
                UserID       => $Self->{UserID},
            );

            # add attachment to the upload cache
            $UploadCacheObject->FormIDAddFile(
                FormID      => $Self->{FormID},
                Filename    => $AttachmentData->{Filename},
                Content     => $AttachmentData->{Content},
                ContentType => $AttachmentData->{ContentType},
            );
        }
    }

    # get submit save
    my $SubmitSave = $ParamObject->GetParam( Param => 'SubmitSave' );

    # get log object
    my $LogObject = $Kernel::OM->Get('Kernel::System::Log');

    # TODO: do not use "Version" here
    my $Version = {};
    my $NameDuplicates;
    my $CINameRegexErrorMessage;
    if ( $Self->{Subaction} eq 'VersionSave' ) {

        # get the uploaded attachment
        my %UploadStuff = $ParamObject->GetUploadAll(
            Param  => 'FileUpload',
            Source => 'string',
        );

        if (%UploadStuff) {

            # add attachment to the upload cache
            $UploadCacheObject->FormIDAddFile(
                FormID => $Self->{FormID},
                %UploadStuff,
            );
        }

        my $AllRequired = 1;

        # get general form data
        for my $FormParam (qw(Name DeplStateID InciStateID)) {
            $Version->{$FormParam} = $ParamObject->GetParam( Param => $FormParam );
            if ( !$Version->{$FormParam} ) {
                $AllRequired = 0;
            }
        }

        # check, whether the feature to check for a unique name is enabled
        if (
            IsStringWithData( $Version->{Name} )
            && $ConfigObject->Get('UniqueCIName::EnableUniquenessCheck')
            )
        {

            if ( $ConfigObject->{Debug} > 0 ) {
                $LogObject->Log(
                    Priority => 'debug',
                    Message  => "Checking for duplicate names (ClassID: $ConfigItem->{ClassID}, "
                        . "Name: $Version->{Name}, ConfigItemID: $ConfigItem->{ConfigItemID})",
                );
            }

            $NameDuplicates = $ConfigItemObject->UniqueNameCheck(
                ConfigItemID => $ConfigItem->{ConfigItemID},
                ClassID      => $ConfigItem->{ClassID},
                Name         => $Version->{Name},
            );

            # stop processing if the name is not unique
            if ( IsArrayRefWithData($NameDuplicates) ) {

                $AllRequired = 0;

                # build a string of all duplicate IDs
                my $NameDuplicatesString = join ', ', @{$NameDuplicates};

                $LogObject->Log(
                    Priority => 'error',
                    Message =>
                        "The name $Version->{Name} is already in use by the ConfigItemID(s): "
                        . $NameDuplicatesString,
                );
            }
        }

        # get the config option for the name regex checks
        my $CINameRegexConfig = $ConfigObject->Get("ITSMConfigItem::CINameRegex");

        # check if the CI name is given and should be checked with a regular expression
        if ( IsStringWithData( $Version->{Name} ) && $CINameRegexConfig ) {

            # get class list
            my $ClassList = $GeneralCatalogObject->ItemList(
                Class => 'ITSM::ConfigItem::Class',
            );

            # get the class name
            my $ClassName = $ClassList->{ $ConfigItem->{ClassID} } || '';

            # get the regex for this class
            my $CINameRegex = $CINameRegexConfig->{ $ClassName . '::' . 'CINameRegex' } || '';

            # if a regex is defined and the CI name does not match the regular expression
            if ( $CINameRegex && $Version->{Name} !~ m{ $CINameRegex }xms ) {

                $AllRequired = 0;

                # get the error message for this class
                $CINameRegexErrorMessage = $CINameRegexConfig->{ $ClassName . '::' . 'CINameRegexErrorMessage' } || '';
            }
        }

        $AllRequired = %Error ? 0 : 1;

        # save version to database
        if ( $SubmitSave && $AllRequired ) {

            if ( $ConfigItem->{ConfigItemID} eq 'NEW' ) {
                $ConfigItem->{ConfigItemID} = $ConfigItemObject->ConfigItemAdd(
                    ClassID => $ConfigItem->{ClassID},
                    UserID  => $Self->{UserID},
                );
            }

            for my $DynamicFieldConfig ($DynamicFieldList->@*) {
                # set the value
                my $Success = $DynamicFieldBackendObject->ValueSet(
                    DynamicFieldConfig => $DynamicFieldConfig,
                    ObjectID           => $ConfigItem->{ConfigItemID},
                    Value              => $DynamicFieldValues{ $DynamicFieldConfig->{Name} },
                    UserID             => $Self->{UserID},
                );
            }

            # get all attachments from upload cache
            my @Attachments = $UploadCacheObject->FormIDGetAllFilesData(
                FormID => $Self->{FormID},
            );

            # build a lookup lookup hash of the new attachments
            my %NewAttachment;
            for my $Attachment (@Attachments) {

                # the key is the filename + filesize + content type
                my $Key = $Attachment->{Filename}
                    . $Attachment->{Filesize}
                    . $Attachment->{ContentType};

                # store all of the new attachment data
                $NewAttachment{$Key} = $Attachment;
            }

            # get all attachments meta data
            my @ExistingAttachments = $ConfigItemObject->ConfigItemAttachmentList(
                ConfigItemID => $ConfigItem->{ConfigItemID},
            );

            # check the existing attachments
            FILENAME:
            for my $Filename (@ExistingAttachments) {

                # get the existing attachment data
                my $AttachmentData = $ConfigItemObject->ConfigItemAttachmentGet(
                    ConfigItemID => $ConfigItem->{ConfigItemID},
                    Filename     => $Filename,
                    UserID       => $Self->{UserID},
                );

                # the key is the filename + filesize + content type
                # (no content id, as existing attachments don't have it)
                my $Key = $AttachmentData->{Filename}
                    . $AttachmentData->{Filesize}
                    . $AttachmentData->{ContentType};

                # attachment is already existing, we can delete it from the new attachment hash
                if ( $NewAttachment{$Key} ) {
                    delete $NewAttachment{$Key};
                }

                # existing attachment is no longer in new attachments hash
                else {

                    # delete the existing attachment
                    my $DeleteSuccessful = $ConfigItemObject->ConfigItemAttachmentDelete(
                        ConfigItemID => $ConfigItem->{ConfigItemID},
                        Filename     => $Filename,
                        UserID       => $Self->{UserID},
                    );

                    # check error
                    if ( !$DeleteSuccessful ) {
                        return $LayoutObject->FatalError();
                    }
                }
            }

            # write dynamic field values
            DYNAMICFIELD:
            for my $DynamicField ( $Definition->{DynamicFieldRef}->@* ) {
                next DYNAMICFIELD if !IsHashRefWithData($DynamicField);

                $Version->{ 'DynamicField_' . $DynamicField->{Name} } = $DynamicFieldBackendObject->EditFieldValueGet(
                    DynamicFieldConfig => $DynamicField,
                    ParamObject        => $ParamObject,
                    LayoutObject       => $LayoutObject,
                );
            }

            # add version
            $ConfigItemObject->ConfigItemUpdate(
                $Version->%*,
                ConfigItemID => $ConfigItem->{ConfigItemID},
                UserID       => $Self->{UserID},
            );

            # write the new attachments
            ATTACHMENT:
            for my $Attachment ( values %NewAttachment ) {

                # add attachment
                my $Success = $ConfigItemObject->ConfigItemAttachmentAdd(
                    %{$Attachment},
                    ConfigItemID => $ConfigItem->{ConfigItemID},
                    UserID       => $Self->{UserID},
                );

                # check error
                if ( !$Success ) {
                    return $LayoutObject->FatalError();
                }
            }

            # redirect to zoom mask
            my $ScreenType = $ParamObject->GetParam( Param => 'ScreenType' ) || 0;
            if ($ScreenType) {

                my $URL = "Action=AgentITSMConfigItemZoom;ConfigItemID=$ConfigItem->{ConfigItemID}";

                # return to overview or search results instead if called Duplicate from row action
                if (
                    $Self->{LastScreenView} eq 'Action=AgentITSMConfigItem'
                    || $Self->{LastScreenView} =~ m{\A Action=AgentITSMConfigItem(?: Search)?;}msx
                    )
                {
                    $URL = $Self->{LastScreenView};
                }
                return $LayoutObject->PopupClose(
                    URL => $URL,
                );
            }
            else {
                return $LayoutObject->Redirect(
                    OP => "Action=AgentITSMConfigItemZoom;ConfigItemID=$ConfigItem->{ConfigItemID}",
                );
            }
        }
    }
    elsif ($Self->{Subaction} eq 'AJAXUpdate') {

        # getting necessary objects
        my $DynamicFieldObject        = $Kernel::OM->Get('Kernel::System::DynamicField');
        my $DynamicFieldBackendObject = $Kernel::OM->Get('Kernel::System::DynamicField::Backend');

        my $TreeView = 0;
        if ($ConfigObject->Get('Ticket::Frontend::ListType') eq 'tree') {
            $TreeView = 1;
        }

        # fetch Dynamic Fields
        my $DynamicFieldList = $DynamicFieldObject->DynamicFieldListGet(
            ObjectType => 'ITSMConfigItem',
        );

        # update Dynamic Fields Possible Values via AJAX
        my @DynamicFieldAJAX;

        # cycle through the activated Dynamic Fields for this screen
        DYNAMICFIELD:
        for my $DynamicFieldConfig ($DynamicFieldList->@*) {
            next DYNAMICFIELD if !IsHashRefWithData($DynamicFieldConfig);

            my $IsACLReducible = $DynamicFieldBackendObject->HasBehavior(
                DynamicFieldConfig => $DynamicFieldConfig,
                Behavior           => 'IsACLReducible'
            );
            next DYNAMICFIELD if !$IsACLReducible;

            my $PossibleValues = $DynamicFieldBackendObject->PossibleValuesGet(
                DynamicFieldConfig => $DynamicFieldConfig,
            );

            # convert possible values key => value to key => key for ACLs using a Hash slice
            my %AclData = $PossibleValues->%*;
            @AclData{ keys %AclData } = keys %AclData;

            # set possible values filter from ACLs
            my $ACL = $ConfigItemObject->ConfigItemAcl(
                %GetParam,
                Action         => $Self->{Action},
                ReturnType     => 'ITSMConfigItem',
                ReturnSubType  => 'DynamicField_' . $DynamicFieldConfig->{Name},
                Data           => \%AclData,
                UserID         => $Self->{UserID},
            );

            if ($ACL) {
                my %Filter = $ConfigItemObject->ConfigItemAclData();

                # convert Filter key => key back to key => value using map
                %{$PossibleValues} = map { $_ => $PossibleValues->{$_} } keys %Filter;
            }

            my $DataValues = $DynamicFieldBackendObject->BuildSelectionDataGet(
                DynamicFieldConfig => $DynamicFieldConfig,
                PossibleValues     => $PossibleValues,
                Value              => $DynamicFieldValues{ $DynamicFieldConfig->{Name} },
            ) || $PossibleValues;

            # add dynamic field to the list of fields to update
            push @DynamicFieldAJAX, {
                Name        => 'DynamicField_' . $DynamicFieldConfig->{Name},
                Data        => $DataValues,
                SelectedID  => $DynamicFieldValues{ $DynamicFieldConfig->{Name} },
                Translation => $DynamicFieldConfig->{Config}->{TranslatableValues} || 0,
                Max         => 100,
            };
        }

        my $JSON = $LayoutObject->BuildSelectionJSON(
            [
                @DynamicFieldAJAX,
            ],
        );
        return $LayoutObject->Attachment(
            ContentType => 'application/json; charset=' . $LayoutObject->{Charset},
            Content     => $JSON,
            Type        => 'inline',
            NoCache     => 1,
        );

    }
    elsif ($DuplicateID) {
        my $VersionID = $ParamObject->GetParam( Param => 'VersionID' );
        if ($VersionID) {

            # get version data to duplicate config item
            $Version = $ConfigItemObject->VersionGet(
                VersionID => $VersionID,
            );
        }
        else {

            # get last version data to duplicate config item
            # TODO: Use ConfigItemGet for "newest version" - check other instances
            $Version = $ConfigItemObject->VersionGet(
                ConfigItemID => $DuplicateID,
            );
        }
    }
    elsif ( $ConfigItem->{ConfigItemID} ne 'NEW' ) {

        # get last version data
        $Version = $ConfigItemObject->ConfigItemGet(
            ConfigItemID => $ConfigItem->{ConfigItemID},
        );
    }

    # output name invalid block
    my $RowNameInvalid = '';
    if ( !$Version->{Name} && $Self->{Subaction} eq 'VersionSave' && $SubmitSave ) {
        $RowNameInvalid = 'ServerError';
    }

    # check for name duplicates
    if ( IsArrayRefWithData($NameDuplicates) ) {
        $RowNameInvalid = 'ServerError';
    }

    # check for not matched name regex
    if ($CINameRegexErrorMessage) {
        $RowNameInvalid = 'ServerError';
    }

    # output name block
    $LayoutObject->Block(
        Name => 'RowName',
        Data => {
            %{$Version},
            RowNameInvalid => $RowNameInvalid,
        },
    );

    if (
        IsStringWithData($RowNameInvalid)
        && !IsArrayRefWithData($NameDuplicates)
        && !$CINameRegexErrorMessage
        )
    {

        if ( $ConfigObject->{Debug} > 0 ) {
            $LogObject->Log(
                Priority => 'debug',
                Message  => "Rendering default error block",
            );
        }

        $LayoutObject->Block(
            Name => 'RowNameErrorDefault',
        );
    }
    elsif ( IsArrayRefWithData($NameDuplicates) ) {

        # build array with CI-Numbers
        my @NameDuplicatesByCINumber;
        for my $ConfigItemID ( @{$NameDuplicates} ) {

            # lookup the CI number
            my $CINumber = $ConfigItemObject->ConfigItemLookup(
                ConfigItemID => $ConfigItemID,
            );

            push @NameDuplicatesByCINumber, $CINumber;
        }

        my $DuplicateString = join ', ', @NameDuplicatesByCINumber;

        if ( $ConfigObject->{Debug} > 0 ) {
            $LogObject->Log(
                Priority => 'debug',
                Message =>
                    "Rendering block for duplicates (CI-Numbers: $DuplicateString) error message",
            );
        }

        $LayoutObject->Block(
            Name => 'RowNameErrorDuplicates',
            Data => {
                Duplicates => $DuplicateString,
            },
        );
    }

    elsif ($CINameRegexErrorMessage) {

        $LayoutObject->Block(
            Name => 'RowNameErrorRegEx',
            Data => {
                RegExErrorMessage => $CINameRegexErrorMessage,
            },
        );
    }

    # get deployment state list
    my $DeplStateList = $GeneralCatalogObject->ItemList(
        Class => 'ITSM::ConfigItem::DeploymentState',
    );

    # output deployment state invalid block
    my $RowDeplStateInvalid = '';
    if ( !$Version->{DeplStateID} && $Self->{Subaction} eq 'VersionSave' && $SubmitSave ) {
        $RowDeplStateInvalid = ' ServerError';
    }

    # generate DeplStateOptionStrg
    my $DeplStateOptionStrg = $LayoutObject->BuildSelection(
        Data         => $DeplStateList,
        Name         => 'DeplStateID',
        PossibleNone => 1,
        Class        => 'Validate_Required Modernize' . $RowDeplStateInvalid,
        SelectedID   => $Version->{DeplStateID},
    );

    # output deployment state block
    $LayoutObject->Block(
        Name => 'RowDeplState',
        Data => {
            DeplStateOptionStrg => $DeplStateOptionStrg,
        },
    );

    # get incident state list
    my $InciStateList = $GeneralCatalogObject->ItemList(
        Class       => 'ITSM::Core::IncidentState',
        Preferences => {
            Functionality => [ 'operational', 'incident' ],
        },
    );

    # output incident state invalid block
    my $RowInciStateInvalid = '';
    if ( !$Version->{InciStateID} && $Self->{Subaction} eq 'VersionSave' && $SubmitSave ) {
        $RowInciStateInvalid = ' ServerError';
    }

    # generate InciStateOptionStrg
    my $InciStateOptionStrg = $LayoutObject->BuildSelection(
        Data         => $InciStateList,
        Name         => 'InciStateID',
        PossibleNone => 1,
        Class        => 'Validate_Required Modernize' . $RowInciStateInvalid,
        SelectedID   => $Version->{InciStateID},
    );

    # output incident state block
    $LayoutObject->Block(
        Name => 'RowInciState',
        Data => {
            InciStateOptionStrg => $InciStateOptionStrg,
        },
    );

    # cycle trough the activated Dynamic Fields for this screen
    DYNAMICFIELD:
    for my $DynamicFieldConfig ( @{$DynamicFieldList} ) {
        next DYNAMICFIELD if !IsHashRefWithData($DynamicFieldConfig);

        $DynamicFieldValues{ $DynamicFieldConfig->{Name} } = $DynamicFieldBackendObject->ValueGet(
            DynamicFieldConfig => $DynamicFieldConfig,
            ObjectID           => $ConfigItem->{ConfigItemID}
        );

        # get field html
        my $DynamicFieldHTML = $DynamicFieldBackendObject->EditFieldRender(
            DynamicFieldConfig   => $DynamicFieldConfig,
#             PossibleValuesFilter => defined $DynFieldStates{Fields}{$i}
#             ? $DynFieldStates{Fields}{$i}{PossibleValues}
#             : undef,
            Value           => $DynamicFieldValues{ $DynamicFieldConfig->{Name} },
            LayoutObject    => $LayoutObject,
            ParamObject     => $ParamObject,
            AJAXUpdate      => 1,
#             UpdatableFields => $Self->_GetFieldsToUpdate(),
#             Mandatory       => $Config->{DynamicField}->{ $DynamicFieldConfig->{Name} } == 2,
#             %UseDefault,
        );

        $Param{DynamicFieldHTML}->{$DynamicFieldConfig->{Name}} = $DynamicFieldHTML;

    }

    # output dynamic fields
    if ( $Definition->{Definition} ) {
        $Self->{CustomerSearchItemIDs} = [];
        my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');
        # TODO: use only the fields in the definition
        my $DynamicField = $Kernel::OM->Get('Kernel::System::DynamicField')->DynamicFieldListGet(
            ObjectType => 'ITSMConfigItem',
        );
        $Kernel::OM->Get('Kernel::System::ITSMConfigItem::Mask')->RenderInput(
            GetParam            => \%Param,
            LayoutObject        => $LayoutObject,
            MaskDefinition      => $Definition->{DefinitionRef},
            DynamicFieldConfigs => $DynamicField,
        );
    }

    # get all attachments meta data
    $Param{AttachmentList} = [
        $UploadCacheObject->FormIDGetAllFilesMeta(
            FormID => $Self->{FormID},
        )
    ];

    my $Output = '';
    if ( ( $ConfigItem->{ConfigItemID} && $ConfigItem->{ConfigItemID} ne 'NEW' ) || $DuplicateID ) {

        # output block
        $LayoutObject->Block(
            Name => 'StartSmall',
            Data => {
                %Param,
                %{$ConfigItem},
            },
        );
        $LayoutObject->Block( Name => 'EndSmall' );

        # output header
        $Output .= $LayoutObject->Header(
            Title => Translatable('Edit'),
            Type  => 'Small',
        );

        # start template output
        $Output .= $LayoutObject->Output(
            TemplateFile => 'AgentITSMConfigItemEdit',
            Data         => {
                %Param,
                %{$ConfigItem},
                DuplicateID => $DuplicateID,
                FormID      => $Self->{FormID},
            },
        );
        $Output .= $LayoutObject->Footer( Type => 'Small' );
    }
    else {

        # Necessary stuff for Add New
        # get class list
        my $ClassList = $GeneralCatalogObject->ItemList(
            Class => 'ITSM::ConfigItem::Class',
        );

        # check for access rights
        for my $ClassID ( sort keys %{$ClassList} ) {
            my $HasAccess = $ConfigItemObject->Permission(
                Type    => $Self->{Config}->{Permission},
                Scope   => 'Class',
                ClassID => $ClassID,
                UserID  => $Self->{UserID},
            );

            delete $ClassList->{$ClassID} if !$HasAccess;
        }

        # generate ClassOptionStrg
        my $ClassOptionStrg = $LayoutObject->BuildSelection(
            Data         => $ClassList,
            Name         => 'ClassID',
            PossibleNone => 1,
            Translation  => 0,
            Class        => 'W100pc',
            SelectedID   => $ConfigItem->{ClassID},
        );

        # End Necessary stuff for Add New

        # output block
        $LayoutObject->Block(
            Name => 'StartNormal',
            Data => {
                ClassOptionStrg => $ClassOptionStrg,
                %Param,
                %{$ConfigItem},
            },
        );

        $LayoutObject->Block( Name => 'EndNormal' );

        # output header
        $Output .= $LayoutObject->Header(
            Title => Translatable('Edit'),
        );
        $Output .= $LayoutObject->NavigationBar();

        # start template output
        $Output .= $LayoutObject->Output(
            TemplateFile => 'AgentITSMConfigItemEdit',
            Data         => {
                %Param,
                %{$ConfigItem},
                DuplicateID => $DuplicateID,
                FormID      => $Self->{FormID},
            },
        );
        $Output .= $LayoutObject->Footer();
    }

    return $Output;
}

1;

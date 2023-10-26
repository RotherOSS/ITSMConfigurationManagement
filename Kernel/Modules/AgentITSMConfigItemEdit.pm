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

package Kernel::Modules::AgentITSMConfigItemEdit;

use v5.24;
use strict;
use warnings;
use namespace::autoclean;
use utf8;

# core modules

# CPAN modules

# OTOBO modules
use Kernel::System::VariableCheck qw(:all);
use Kernel::Language qw(Translatable);

our $ObjectManagerDisabled = 1;

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    return bless {%Param}, $Type;
}

sub Run {
    my ( $Self, %Param ) = @_;

    # my param object
    my $ParamObject = $Kernel::OM->Get('Kernel::System::Web::Request');

    # get configitem id and class id
    my $ConfigItem  = {};
    my $DuplicateID = $ParamObject->GetParam( Param => 'DuplicateID' ) || 0;
    $ConfigItem->{ConfigItemID} = $ParamObject->GetParam( Param => 'ConfigItemID' ) || 0;
    $ConfigItem->{ClassID}      = $ParamObject->GetParam( Param => 'ClassID' )      || 0;

    my $HasAccess;

    # get needed objects
    my $ConfigItemObject          = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');
    my $DynamicFieldBackendObject = $Kernel::OM->Get('Kernel::System::DynamicField::Backend');
    my $GeneralCatalogObject      = $Kernel::OM->Get('Kernel::System::GeneralCatalog');
    my $ConfigObject              = $Kernel::OM->Get('Kernel::Config');
    my $LayoutObject              = $Kernel::OM->Get('Kernel::Output::HTML::Layout');

    # get config of frontend module
    $Self->{Config} = $ConfigObject->Get("ITSMConfigItem::Frontend::$Self->{Action}");

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

        my $VersionID = $ParamObject->GetParam( Param => 'VersionID' );

        # TODO: Check duplication
        # get config item to duplicate
        $ConfigItem = $ConfigItemObject->ConfigItemGet(
            ConfigItemID  => $DuplicateID,
            VersionID     => $VersionID,
            DynamicFields => 1,
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

    # Edit the config item with the newest config item definition of the relevant class
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

    my %GetParam;
    my %DynamicFieldValues;
    my %ACLReducibleDynamicFields;
    my $DynamicFieldList = $Definition->{DynamicFieldRef} ? [ values $Definition->{DynamicFieldRef}->%* ] : [];

    # get initial values for the configitem
    if ( !$Self->{Subaction} ) {
        if ( $ConfigItem->{ConfigItemID} eq 'NEW' ) {
            my $ConfigItemName;

            if ($DuplicateID) {

                # get Data from duplicate CI
                for my $Param (qw(Name DeplStateID InciStateID)) {
                    $GetParam{$Param} = $ConfigItem->{$Param};
                }

                $ConfigItemName = $GetParam{Name} . ' (Copy)';

                DYNAMICFIELD:
                for my $DynamicFieldConfig ( $DynamicFieldList->@* ) {
                    next DYNAMICFIELD unless IsHashRefWithData($DynamicFieldConfig);

                    $DynamicFieldValues{ $DynamicFieldConfig->{Name} } = $ConfigItem->{ 'DynamicField_' . $DynamicFieldConfig->{Name} };

                    # perform ACLs on values
                    my $IsACLReducible = $DynamicFieldBackendObject->HasBehavior(
                        DynamicFieldConfig => $DynamicFieldConfig,
                        Behavior           => 'IsACLReducible'
                    );

                    if ($IsACLReducible) {
                        $ACLReducibleDynamicFields{ $DynamicFieldConfig->{Name} } = 1;
                    }
                }
            }

            # TODO Prio3: set default data
            #else {
            #for my $Param (qw(Name DeplStateID InciStateID)) {
            #    $GetParam{$Param} = ;
            #}
            #}
        }

        else {
            # get general form data
            for my $Param (qw(Name DeplStateID InciStateID)) {
                $GetParam{$Param} = $ConfigItem->{$Param};
            }

            DYNAMICFIELD:
            for my $DynamicFieldConfig ( $DynamicFieldList->@* ) {
                next DYNAMICFIELD unless IsHashRefWithData($DynamicFieldConfig);

                $DynamicFieldValues{ $DynamicFieldConfig->{Name} } = $ConfigItem->{ 'DynamicField_' . $DynamicFieldConfig->{Name} };

                # perform ACLs on values
                my $IsACLReducible = $DynamicFieldBackendObject->HasBehavior(
                    DynamicFieldConfig => $DynamicFieldConfig,
                    Behavior           => 'IsACLReducible'
                );

                if ($IsACLReducible) {
                    $ACLReducibleDynamicFields{ $DynamicFieldConfig->{Name} } = 1;
                }
            }
        }
    }

    else {
        # get general form data
        for my $Param (qw(Name DeplStateID InciStateID)) {
            $GetParam{$Param} = $ParamObject->GetParam( Param => $Param );
        }

        DYNAMICFIELD:
        for my $DynamicFieldConfig ( $DynamicFieldList->@* ) {
            next DYNAMICFIELD unless IsHashRefWithData($DynamicFieldConfig);

            # extract the dynamic field value from the web request
            $DynamicFieldValues{ $DynamicFieldConfig->{Name} } = $DynamicFieldBackendObject->EditFieldValueGet(
                DynamicFieldConfig => $DynamicFieldConfig,
                ParamObject        => $ParamObject,
                LayoutObject       => $LayoutObject,
            );

            # perform ACLs on values
            my $IsACLReducible = $DynamicFieldBackendObject->HasBehavior(
                DynamicFieldConfig => $DynamicFieldConfig,
                Behavior           => 'IsACLReducible'
            );

            if ($IsACLReducible) {
                $ACLReducibleDynamicFields{ $DynamicFieldConfig->{Name} } = 1;
            }
        }
    }

    my @UpdatableFields = qw(DeplStateID InciStateID);
    push @UpdatableFields, keys %ACLReducibleDynamicFields;

    # convert dynamic field values into a structure for ACLs
    my %DynamicFieldACLParameters;
    DYNAMICFIELD:
    for my $DynamicField ( sort keys %DynamicFieldValues ) {
        next DYNAMICFIELD unless $DynamicField;
        next DYNAMICFIELD unless $DynamicFieldValues{$DynamicField};

        $DynamicFieldACLParameters{ 'DynamicField_' . $DynamicField } = $DynamicFieldValues{$DynamicField};
    }
    $GetParam{DynamicField} = \%DynamicFieldACLParameters;

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

    # get log object
    my $LogObject               = $Kernel::OM->Get('Kernel::System::Log');
    my $FieldRestrictionsObject = $Kernel::OM->Get('Kernel::System::ITSMConfigItem::FieldRestrictions');

    my $Autoselect = $ConfigObject->Get('ConfigItemACL::Autoselect') || undef;
    my $ACLPreselection;
    if ( $ConfigObject->Get('ConfigItemACL::ACLPreselection') ) {

        # get cached preselection rules
        my $CacheObject = $Kernel::OM->Get('Kernel::System::Cache');
        $ACLPreselection = $CacheObject->Get(
            Type => 'ConfigItemACL',
            Key  => 'Preselection',
        );
        if ( !$ACLPreselection ) {
            $ACLPreselection = $FieldRestrictionsObject->SetACLPreselectionCache();
        }
    }

    my %Error;
    my $NameDuplicates;
    my $CINameRegexErrorMessage;
    my %DynamicFieldValidationResult;
    my %DynamicFieldPossibleValues;
    my %DynamicFieldVisibility;
    my $NameModuleObject;
    if ( $Self->{Subaction} eq 'Save' ) {
        my $NameModuleConfig = $ConfigObject->Get('ITSMConfigItem::NameModule');
        if ( $NameModuleConfig && $NameModuleConfig->{ $ConfigItem->{Class} } ) {
            my $NameModule = "Kernel::System::ITSMConfigItem::Name::$NameModuleConfig->{$ConfigItem->{Class}}";

            # check if name module exists
            if ( !$Kernel::OM->Get('Kernel::System::Main')->Require($NameModule) ) {
                $Kernel::OM->Get('Kernel::System::Log')->Log(
                    Priority => 'error',
                    Message  => "Can't load name module for class $ConfigItem->{Class}!",
                );

                return;
            }

            # create a backend object
            $NameModuleObject = $Kernel::OM->Get( $NameModule );
        }

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
        for my $Param (qw(DeplStateID InciStateID)) {
            $ConfigItem->{$Param} = $GetParam{$Param};

            if ( !$ConfigItem->{$Param} ) {
                $AllRequired = 0;
            }
        }

        # get name only if it is not filled by a module
        if ( !$NameModuleObject ) {
            $ConfigItem->{Name} = $GetParam{Name};

            if ( !$ConfigItem->{Name} ) {
                $AllRequired = 0;
            }
        }

        # check, whether the feature to check for a unique name is enabled
        if (
            IsStringWithData( $ConfigItem->{Name} )
            && $ConfigObject->Get('UniqueCIName::EnableUniquenessCheck')
            )
        {

            if ( $ConfigObject->{Debug} > 0 ) {
                $LogObject->Log(
                    Priority => 'debug',
                    Message  => "Checking for duplicate names (ClassID: $ConfigItem->{ClassID}, "
                        . "Name: $ConfigItem->{Name}, ConfigItemID: $ConfigItem->{ConfigItemID})",
                );
            }

            $NameDuplicates = $ConfigItemObject->UniqueNameCheck(
                ConfigItemID => $ConfigItem->{ConfigItemID},
                ClassID      => $ConfigItem->{ClassID},
                Name         => $ConfigItem->{Name},
            );

            # stop processing if the name is not unique
            if ( IsArrayRefWithData($NameDuplicates) ) {

                $AllRequired = 0;

                # build a string of all duplicate IDs
                my $NameDuplicatesString = join ', ', @{$NameDuplicates};

                $LogObject->Log(
                    Priority => 'error',
                    Message  =>
                        "The name $ConfigItem->{Name} is already in use by the ConfigItemID(s): "
                        . $NameDuplicatesString,
                );
            }
        }

        # get the config option for the name regex checks
        my $CINameRegexConfig = $ConfigObject->Get("ITSMConfigItem::CINameRegex");

        # check if the CI name is given and should be checked with a regular expression
        if ( IsStringWithData( $ConfigItem->{Name} ) && $CINameRegexConfig ) {

            # get class list
            my $ClassList = $GeneralCatalogObject->ItemList(
                Class => 'ITSM::ConfigItem::Class',
            );

            # get the class name
            my $ClassName = $ClassList->{ $ConfigItem->{ClassID} } || '';

            # get the regex for this class
            my $CINameRegex = $CINameRegexConfig->{ $ClassName . '::' . 'CINameRegex' } || '';

            # if a regex is defined and the CI name does not match the regular expression
            if ( $CINameRegex && $ConfigItem->{Name} !~ m{ $CINameRegex }xms ) {

                $AllRequired = 0;

                # get the error message for this class
                $CINameRegexErrorMessage = $CINameRegexConfig->{ $ClassName . '::' . 'CINameRegexErrorMessage' } || '';
            }
        }

        # transform dynamic field data into DFName => DFName pair
        my %DynamicFieldAcl = map { $_->{Name} => $_->{Name} } $DynamicFieldList->@*;

        # call ticket ACLs for DynamicFields to check field visibility
        my $ACLResult = $ConfigItemObject->ConfigItemAcl(
            %GetParam,
            Action        => $Self->{Action},
            ReturnType    => 'Form',
            ReturnSubType => '-',
            Data          => \%DynamicFieldAcl,
            UserID        => $Self->{UserID},
        );
        if ($ACLResult) {
            %DynamicFieldVisibility = map { 'DynamicField_' . $_->{Name} => 0 } $DynamicFieldList->@*;
            my %AclData = $ConfigItemObject->ConfigItemAclData();
            for my $Field ( sort keys %AclData ) {
                $DynamicFieldVisibility{ 'DynamicField_' . $Field } = 1;
            }
        }
        else {
            %DynamicFieldVisibility = map { 'DynamicField_' . $_->{Name} => 1 } $DynamicFieldList->@*;
        }

        DYNAMICFIELD:
        for my $DynamicFieldConfig ( $DynamicFieldList->@* ) {
            next DYNAMICFIELD unless IsHashRefWithData($DynamicFieldConfig);

            my $PossibleValuesFilter;

            if ( $ACLReducibleDynamicFields{ $DynamicFieldConfig->{Name} } ) {

                # get PossibleValues
                my $PossibleValues = $DynamicFieldBackendObject->PossibleValuesGet(
                    DynamicFieldConfig => $DynamicFieldConfig,
                );

                # check if field has PossibleValues property in its configuration
                if ( IsHashRefWithData($PossibleValues) ) {

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

            $DynamicFieldPossibleValues{ 'DynamicField_' . $DynamicFieldConfig->{Name} } = $PossibleValuesFilter;

            # perform validation
            my $ValidationResult = $DynamicFieldBackendObject->EditFieldValueValidate(
                DynamicFieldConfig   => $DynamicFieldConfig,
                PossibleValuesFilter => $PossibleValuesFilter,
                ParamObject          => $ParamObject,
            );

            if ( !IsHashRefWithData($ValidationResult) ) {
                return $LayoutObject->ErrorScreen(
                    Message => $LayoutObject->{LanguageObject}->Translate("Could not perform validation on field $DynamicFieldConfig->{Label}!"),
                    Comment => Translatable('Please contact the administrator.'),
                );
            }

            # propagate validation error to the Error variable to be detected by the frontend
            if ( $ValidationResult->{ServerError} ) {
                $Error{ $DynamicFieldConfig->{Name} }                        = ' ServerError';
                $DynamicFieldValidationResult{ $DynamicFieldConfig->{Name} } = $ValidationResult;
            }
        }

        $AllRequired = %Error ? 0 : 1;

        # save version to database
        if ($AllRequired) {

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

            # for existing ConfigItems compare with the current data
            if ( $ConfigItem->{ConfigItemID} ne 'NEW' ) {

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
            }

            # TODO: better align with the initial EditFieldValueGet?
            # TODO: Visibility
            # prepare dynamic field values
            DYNAMICFIELD:
            for my $DynamicField ( values $Definition->{DynamicFieldRef}->%* ) {
                next DYNAMICFIELD if !IsHashRefWithData($DynamicField);

                $ConfigItem->{ 'DynamicField_' . $DynamicField->{Name} } = $DynamicFieldValues{ $DynamicField->{Name} };
            }

            if ( $ConfigItem->{ConfigItemID} eq 'NEW' ) {

                # delete temporary number # TODO: check, whether setting new as number is necessary in the first place
                delete $ConfigItem->{Number};

                $ConfigItem->{ConfigItemID} = $ConfigItemObject->ConfigItemAdd(
                    $ConfigItem->%*,
                    UserID => $Self->{UserID},

                    # DefinitionID => $Definition->{DefinitionID}, # TODO: this is not used yet
                );

                # check error
                if ( !$ConfigItem->{ConfigItemID} ) {
                    return $LayoutObject->FatalError();
                }
            }
            else {
                $ConfigItemObject->ConfigItemUpdate(
                    $ConfigItem->%*,
                    DefinitionID => $Definition->{DefinitionID},
                    UserID       => $Self->{UserID},
                );
            }

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
    elsif ( $Self->{Subaction} eq 'AJAXUpdate' ) {
        my $ElementChanged  = $ParamObject->GetParam( Param => 'ElementChanged' ) || '';
        my %ChangedElements = $ElementChanged ? ( $ElementChanged => 1 ) : ();
        my $LoopProtection  = 100;

        # get values and visibility of dynamic fields
        my %DynFieldStates = $FieldRestrictionsObject->GetFieldStates(
            ConfigItemObject          => $ConfigItemObject,
            DynamicFields             => $Definition->{DynamicFieldRef},
            DynamicFieldBackendObject => $DynamicFieldBackendObject,
            ChangedElements           => \%ChangedElements,                # optional to reduce ACL evaluation
            Action                    => $Self->{Action},
            UserID                    => $Self->{UserID},
            ConfigItemID              => $Self->{ConfigItemID},
            FormID                    => $Self->{FormID},
            GetParam                  => {%GetParam},
            Autoselect                => $Autoselect,
            ACLPreselection           => $ACLPreselection,
            LoopProtection            => \$LoopProtection,
        );

        # store new values
        $GetParam{DynamicField} = {
            %{ $GetParam{DynamicField} },
            %{ $DynFieldStates{NewValues} },
        };

        # update Dynamic Fields Possible Values via AJAX
        my @DynamicFieldAJAX;

        # cycle through the activated Dynamic Fields for this screen
        DYNAMICFIELD:
        for my $Name ( keys %{ $DynFieldStates{Fields} } ) {
            my $DynamicFieldConfig = $Definition->{DynamicFieldRef}{$Name};

            if ( $DynamicFieldConfig->{Config}{MultiValue} && ref $GetParam{DynamicField}{"DynamicField_$Name"} eq 'ARRAY' ) {
                for my $i ( 0 .. $#{ $GetParam{DynamicField}{"DynamicField_$Name"} } ) {
                    my $DataValues = $DynFieldStates{Fields}{$Name}{NotACLReducible}
                        ? $GetParam{DynamicField}{"DynamicField_$Name"}[$i]
                        :
                        (
                            $DynamicFieldBackendObject->BuildSelectionDataGet(
                                DynamicFieldConfig => $DynamicFieldConfig,
                                PossibleValues     => $DynFieldStates{Fields}{$Name}{PossibleValues},
                                Value              => [ $GetParam{DynamicField}{"DynamicField_$Name"}[$i] ],
                            )
                            || $DynFieldStates{Fields}{$Name}{PossibleValues}
                        );

                    # add dynamic field to the list of fields to update
                    push @DynamicFieldAJAX, {
                        Name        => $Name . '_' . $i,
                        Data        => $DataValues,
                        SelectedID  => $GetParam{DynamicField}{"DynamicField_$Name"}[$i],
                        Translation => $DynamicFieldConfig->{Config}->{TranslatableValues} || 0,
                        Max         => 100,
                    };
                }

                next DYNAMICFIELD;
            }

            my $DataValues = $DynFieldStates{Fields}{$Name}{NotACLReducible}
                ? $GetParam{DynamicField}{"DynamicField_$Name"}
                :
                (
                    $DynamicFieldBackendObject->BuildSelectionDataGet(
                        DynamicFieldConfig => $DynamicFieldConfig,
                        PossibleValues     => $DynFieldStates{Fields}{$Name}{PossibleValues},
                        Value              => $GetParam{DynamicField}{"DynamicField_$Name"},
                    )
                    || $DynFieldStates{Fields}{$Name}{PossibleValues}
                );

            # add dynamic field to the list of fields to update
            push @DynamicFieldAJAX, {
                Name        => 'DynamicField_' . $Name,
                Data        => $DataValues,
                SelectedID  => $GetParam{DynamicField}{"DynamicField_$Name"},
                Translation => $DynamicFieldConfig->{Config}->{TranslatableValues} || 0,
                Max         => 100,
            };
        }

        if ( IsHashRefWithData( $DynFieldStates{Visibility} ) ) {
            push @DynamicFieldAJAX, {
                Name => 'Restrictions_Visibility',
                Data => $DynFieldStates{Visibility},
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
    else {
        my $NameModuleConfig = $ConfigObject->Get('ITSMConfigItem::NameModule');
        if ( $NameModuleConfig && $NameModuleConfig->{ $ConfigItem->{Class} } ) {
            my $NameModule = "Kernel::System::ITSMConfigItem::Name::$NameModuleConfig->{$ConfigItem->{Class}}";

            # check if name module exists
            if ( !$Kernel::OM->Get('Kernel::System::Main')->Require($NameModule) ) {
                $Kernel::OM->Get('Kernel::System::Log')->Log(
                    Priority => 'error',
                    Message  => "Can't load name module for class $ConfigItem->{Class}!",
                );

                return;
            }

            # create a backend object
            $NameModuleObject = $Kernel::OM->Get( $NameModule );
        }

        my $LoopProtection = 100;

        # get values and visibility of dynamic fields
        my %DynFieldStates = $FieldRestrictionsObject->GetFieldStates(
            ConfigItemObject          => $ConfigItemObject,
            DynamicFields             => $Definition->{DynamicFieldRef},
            DynamicFieldBackendObject => $DynamicFieldBackendObject,
            Action                    => $Self->{Action},
            UserID                    => $Self->{UserID},
            ConfigItemID              => $Self->{ConfigItemID},
            FormID                    => $Self->{FormID},
            GetParam                  => {%GetParam},
            Autoselect                => $Autoselect,
            ACLPreselection           => $ACLPreselection,
            LoopProtection            => \$LoopProtection,
            InitialRun                => 1,
        );

        # store new values
        $GetParam{DynamicField} = {
            %{ $GetParam{DynamicField} },
            %{ $DynFieldStates{NewValues} },
        };

        %DynamicFieldVisibility     = $DynFieldStates{Visibility}->%*;
        %DynamicFieldPossibleValues = map { 'DynamicField_' . $_ => $DynFieldStates{Fields}{$_}{PossibleValues} } keys $DynFieldStates{Fields}->%*;
    }

    my $NameEditable   = $NameModuleObject ? 0 : 1;
    my $RowNameInvalid = $ConfigItem->{Name}
        # if a name exists mark regex and duplicate errors
        ? $CINameRegexErrorMessage || IsArrayRefWithData($NameDuplicates)
            ? 'ServerError' : undef
        # if it does not exist mark it, if it should
        : $Self->{Subaction} eq 'Save' && $NameEditable
            ? 'ServerError' : undef;

    # output name block
    if ( $ConfigItem->{Name} || $NameEditable ) {
        # output name block
        $LayoutObject->Block(
            Name => 'RowName',
            Data => {
                %GetParam,
                RowNameInvalid => $RowNameInvalid,
                Readonly       => !$NameEditable,
            },
        );
    }

    # show specific errors
    if ( IsArrayRefWithData($NameDuplicates) ) {
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
                Message  =>
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
    elsif ( $RowNameInvalid ) {
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

    # get deployment state list
    my $DeplStateList = $GeneralCatalogObject->ItemList(
        Class => 'ITSM::ConfigItem::DeploymentState',
    );

    # output deployment state invalid block
    my $RowDeplStateInvalid = '';
    if ( !$ConfigItem->{DeplStateID} && $Self->{Subaction} eq 'Save' ) {
        $RowDeplStateInvalid = ' ServerError';
    }

    # generate DeplStateOptionStrg
    my $DeplStateOptionStrg = $LayoutObject->BuildSelection(
        Data         => $DeplStateList,
        Name         => 'DeplStateID',
        PossibleNone => 1,
        Class        => 'Validate_Required Modernize' . $RowDeplStateInvalid,
        SelectedID   => $GetParam{DeplStateID},
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
    if ( !$ConfigItem->{InciStateID} && $Self->{Subaction} eq 'Save' ) {
        $RowInciStateInvalid = ' ServerError';
    }

    # generate InciStateOptionStrg
    my $InciStateOptionStrg = $LayoutObject->BuildSelection(
        Data         => $InciStateList,
        Name         => 'InciStateID',
        PossibleNone => 1,
        Class        => 'Validate_Required Modernize' . $RowInciStateInvalid,
        SelectedID   => $GetParam{InciStateID},
    );

    # output incident state block
    $LayoutObject->Block(
        Name => 'RowInciState',
        Data => {
            InciStateOptionStrg => $InciStateOptionStrg,
        },
    );

    # render dynamic fields
    my $DynamicFieldHTML;
    if ( IsHashRefWithData( $Definition->{DefinitionRef} ) && $Definition->{DefinitionRef}{Sections} ) {

        # TODO: look what this was/is about
        #        $Self->{CustomerSearchItemIDs} = [];

        # TODO: It would be nice to switch between pages for the edit mask, too. Keeping the fields in sync
        #       while editing needs a bit more preparation though
        # Thus for now make sure to show dynamic fields only once, even if present on multiple pages/sections
        my $FieldsSeen = {};

        for my $Page ( $Definition->{DefinitionRef}{Pages}->@* ) {

            SECTION:
            for my $SectionConfig ( $Page->{Content}->@* ) {
                my $Section = $Definition->{DefinitionRef}{Sections}{ $SectionConfig->{Section} };

                next SECTION unless $Section;
                next SECTION if $Section->{Type} && $Section->{Type} ne 'DynamicFields';

                # weed out multiple occurances of dynamic fields - see comment above
                $Section->{Content} = $Self->_DiscardFieldsSeen(
                    Content => $Section->{Content},
                    Seen    => $FieldsSeen,
                );

                $DynamicFieldHTML .= $Kernel::OM->Get('Kernel::Output::HTML::DynamicField::Mask')->EditSectionRender(
                    Content              => $Section->{Content},
                    DynamicFields        => $Definition->{DynamicFieldRef},
                    UpdatableFields      => \@UpdatableFields,
                    LayoutObject         => $LayoutObject,
                    ParamObject          => $ParamObject,
                    DynamicFieldValues   => $GetParam{DynamicField},
                    PossibleValuesFilter => \%DynamicFieldPossibleValues,
                    Errors               => \%DynamicFieldValidationResult,
                    Visibility           => \%DynamicFieldVisibility,
                    Object               => {
                        Class => $ConfigItem->{Class},
                        $GetParam{DynamicField}->%*,
                    },
                );
            }
        }
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
        return join '',
            $LayoutObject->Header(
                Title => Translatable('Edit'),
                Type  => 'Small',
            ),
            $LayoutObject->Output(
                TemplateFile => 'AgentITSMConfigItemEdit',
                Data         => {
                    %Param,
                    %{$ConfigItem},
                    DynamicFieldHTML => $DynamicFieldHTML,
                    DuplicateID      => $DuplicateID,
                    FormID           => $Self->{FormID},
                },
            ),
            $LayoutObject->Footer( Type => 'Small' );
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
        return join '',
            $LayoutObject->Header(
                Title => Translatable('Edit'),
            ),
            $LayoutObject->NavigationBar,
            $LayoutObject->Output(
                TemplateFile => 'AgentITSMConfigItemEdit',
                Data         => {
                    %Param,
                    %{$ConfigItem},
                    DynamicFieldHTML => $DynamicFieldHTML,
                    DuplicateID      => $DuplicateID,
                    FormID           => $Self->{FormID},
                },
            ),
            $LayoutObject->Footer;
    }
}

sub _DiscardFieldsSeen {
    my ( $Self, %Param ) = @_;

    my $Content;
    my $Ref = ref $Param{Content};

    if ( $Ref eq 'ARRAY' ) {
        my @CleanedArray;

        ELEMENT:
        for my $Element ( $Param{Content}->@* ) {
            my $RefElement = ref $Element;

            if ( $RefElement eq 'ARRAY' ) {
                push @CleanedArray, $Self->_DiscardFieldsSeen(
                    Content => $Element,
                    Seen    => $Param{Seen},
                );

                next ELEMENT;
            }

            elsif ( $RefElement eq 'HASH' ) {
                if ( !$Element->{DF} ) {
                    push @CleanedArray, $Self->_DiscardFieldsSeen(
                        Content => $Element,
                        Seen    => $Param{Seen},
                    );

                    next ELEMENT;
                }

                if ( $Param{Seen}{ $Element->{DF} }++ ) {
                    next ELEMENT;
                }
            }

            push @CleanedArray, $Element;
        }

        $Content = \@CleanedArray;
    }

    elsif ( $Ref eq 'HASH' ) {
        my %CleanedHash;

        for my $Key ( keys $Param{Content}->%* ) {
            $CleanedHash{ $Key } = $Self->_DiscardFieldsSeen(
                Content => $Param{Content}{ $Key },
                Seen    => $Param{Seen},
            );
        }

        $Content = \%CleanedHash;
    }

    else {
        $Content = $Param{Content};
    }

    return $Content;
}

1;

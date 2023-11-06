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

package Kernel::Modules::AgentITSMConfigItemSearch;

use strict;
use warnings;

use Kernel::Language qw(Translatable);
use Kernel::System::VariableCheck qw(:all);

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
    my $Output;

    # get neccessary objects
    my $BackendObject        = $Kernel::OM->Get('Kernel::System::DynamicField::Backend');
    my $ConfigItemObject     = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');
    my $ConfigObject         = $Kernel::OM->Get('Kernel::Config');
    my $GeneralCatalogObject = $Kernel::OM->Get('Kernel::System::GeneralCatalog');
    my $LayoutObject         = $Kernel::OM->Get('Kernel::Output::HTML::Layout');
    my $ParamObject          = $Kernel::OM->Get('Kernel::System::Web::Request');
    my $SearchProfileObject  = $Kernel::OM->Get('Kernel::System::SearchProfile');

    # get config of frontend module
    $Self->{Config} = $ConfigObject->Get("ITSMConfigItem::Frontend::$Self->{Action}");

    # get config data
    $Self->{StartHit}    = int( $ParamObject->GetParam( Param => 'StartHit' ) || 1 );
    $Self->{SearchLimit} = $Self->{Config}->{SearchLimit} || 10000;
    $Self->{SortBy}      = $ParamObject->GetParam( Param => 'SortBy' )
        || $Self->{Config}->{'SortBy::Default'}
        || 'Number';
    $Self->{OrderBy} = $ParamObject->GetParam( Param => 'OrderBy' )
        || $Self->{Config}->{'Order::Default'}
        || 'Down';
    $Self->{Profile}        = $ParamObject->GetParam( Param => 'Profile' )     || '';
    $Self->{SaveProfile}    = $ParamObject->GetParam( Param => 'SaveProfile' ) || '';
    $Self->{TakeLastSearch} = $ParamObject->GetParam( Param => 'TakeLastSearch' );

    # get class list
    my $ClassList = $GeneralCatalogObject->ItemList(
        Class => 'ITSM::ConfigItem::Class',
    );

    # check for access rights on the classes
    for my $ClassID ( sort keys %{$ClassList} ) {
        my $HasAccess = $ConfigItemObject->Permission(
            Type    => $Self->{Config}->{Permission},
            Scope   => 'Class',
            ClassID => $ClassID,
            UserID  => $Self->{UserID},
        );

        delete $ClassList->{$ClassID} if !$HasAccess;
    }

    # get class id
    my $ClassID = $ParamObject->GetParam( Param => 'ClassID' );

    # check if class id is valid
    if ( $ClassID && !$ClassList->{$ClassID} ) {
        return $LayoutObject->ErrorScreen(
            Message => Translatable('Invalid ClassID!'),
            Comment => Translatable('Please contact the administrator.'),
        );
    }

    # get single params
    my %GetParam;
    my $Definition;

    if ($ClassID) {

        # get current definition
        $Definition = $ConfigItemObject->DefinitionGet(
            ClassID => $ClassID,
        );

        # abort, if no definition is defined
        if ( !$Definition->{DefinitionID} ) {
            return $LayoutObject->ErrorScreen(
                Message =>
                    $LayoutObject->{LanguageObject}->Translate( 'No definition was defined for class %s!', $ClassID ),
                Comment => Translatable('Please contact the administrator.'),
            );
        }

        # load profiles string params
        if ( ( $Self->{Subaction} eq 'LoadProfile' && $Self->{Profile} ) || $Self->{TakeLastSearch} ) {
            %GetParam = $SearchProfileObject->SearchProfileGet(
                Base      => 'ConfigItemSearch' . $ClassID,
                Name      => $Self->{Profile},
                UserLogin => $Self->{UserLogin},
            );

            # convert attributes
            if ( $GetParam{ShownAttributes} && ref $GetParam{ShownAttributes} eq 'ARRAY' ) {
                $GetParam{ShownAttributes} = join ';', @{ $GetParam{ShownAttributes} };
            }
        }
        else {

            # get search string params (get submitted params)
            for my $Key (qw(Number Name PreviousVersionSearch ResultForm ShownAttributes)) {

                # get search string params (get submitted params)
                $GetParam{$Key} = $ParamObject->GetParam( Param => $Key );

                # remove white space on the start and end
                if ( $GetParam{$Key} ) {
                    $GetParam{$Key} =~ s/\s+$//g;
                    $GetParam{$Key} =~ s/^\s+//g;
                }
            }

            # get array params
            for my $Key (qw(DeplStateIDs InciStateIDs)) {

                # get search array params (get submitted params)
                my @Array = $ParamObject->GetArray( Param => $Key );
                if (@Array) {
                    $GetParam{$Key} = \@Array;
                }
            }

            # get Dynamic fields from param object
            # cycle trough the activated Dynamic Fields for this screen
            DYNAMICFIELD:
            for my $DynamicFieldConfig ( values $Definition->{DynamicFieldRef}->%* ) {
                next DYNAMICFIELD if !IsHashRefWithData($DynamicFieldConfig);
                next DYNAMICFIELD if !$DynamicFieldConfig->{Name};
                next DYNAMICFIELD unless $Self->{Config}{DynamicField}{ $DynamicFieldConfig->{Name} };

                # get search field preferences
                my $SearchFieldPreferences = $BackendObject->SearchFieldPreferences(
                    DynamicFieldConfig => $DynamicFieldConfig,
                );

                next DYNAMICFIELD if !IsArrayRefWithData($SearchFieldPreferences);

                PREFERENCE:
                for my $Preference ( @{$SearchFieldPreferences} ) {

                    # extract the dynamic field value from the web request
                    my $DynamicFieldValue = $BackendObject->SearchFieldValueGet(
                        DynamicFieldConfig     => $DynamicFieldConfig,
                        ParamObject            => $ParamObject,
                        ReturnProfileStructure => 1,
                        LayoutObject           => $LayoutObject,
                        Type                   => $Preference->{Type},
                    );

                    # set the complete value structure in GetParam to store it later in the search profile
                    if ( IsHashRefWithData($DynamicFieldValue) ) {
                        %GetParam = ( %GetParam, %{$DynamicFieldValue} );
                    }
                }
            }
        }
    }

    # ------------------------------------------------------------ #
    # delete search profiles
    # ------------------------------------------------------------ #
    if ( $Self->{Subaction} eq 'AJAXProfileDelete' ) {

        # remove old profile stuff
        $SearchProfileObject->SearchProfileDelete(
            Base      => 'ConfigItemSearch' . $ClassID,
            Name      => $Self->{Profile},
            UserLogin => $Self->{UserLogin},
        );
        my $Output = $LayoutObject->JSONEncode(
            Data => 1,
        );
        return $LayoutObject->Attachment(
            NoCache     => 1,
            ContentType => 'text/html',
            Content     => $Output,
            Type        => 'inline',
        );
    }

    # ------------------------------------------------------------ #
    # init search dialog (select class)
    # ------------------------------------------------------------ #
    elsif ( $Self->{Subaction} eq 'AJAX' ) {

        my $EmptySearch = $ParamObject->GetParam( Param => 'EmptySearch' );
        if ( !$Self->{Profile} ) {
            $EmptySearch = 1;
        }

        # if no profile is used, set default params of default attributes
        if ( !$Self->{Profile} ) {
            if ( $Self->{Config}{Defaults} ) {
                KEY:
                for my $Key ( sort keys %{ $Self->{Config}{Defaults} } ) {
                    next KEY if !$Self->{Config}{Defaults}->{$Key};
                    next KEY if $Key eq 'DynamicField';

                    if ( $Key =~ /^(ConfigItem)(Create|Change)/ ) {
                        my @Items = split /;/, $Self->{Config}{Defaults}->{$Key};
                        for my $Item (@Items) {
                            my ( $Key, $Value ) = split /=/, $Item;
                            $GetParam{$Key} = $Value;
                        }
                    }
                    else {
                        $GetParam{$Key} = $Self->{Config}{Defaults}->{$Key};
                    }
                }
            }
        }

        # convert attributes
        if ( IsArrayRefWithData( $GetParam{ShownAttributes} ) ) {
            my @ShowAttributes = grep {defined} @{ $GetParam{ShownAttributes} };
            $GetParam{ShownAttributes} = join ';', @ShowAttributes;
        }

        # generate dropdown for selecting the class
        # automatically show search mask after selecting a class via AJAX
        my $ClassOptionStrg = $LayoutObject->BuildSelection(
            Data         => $ClassList,
            Name         => 'SearchClassID',
            PossibleNone => 1,
            SelectedID   => $ClassID || '',
            Translation  => 1,
            Class        => 'Modernize',
        );

        # html search mask output
        $LayoutObject->Block(
            Name => 'SearchAJAX',
            Data => {
                ClassOptionStrg => $ClassOptionStrg,
                Profile         => $Self->{Profile},
                ClassID         => $ClassID,
                EmptySearch     => $EmptySearch,
            },
        );

        # output template
        $Output = $LayoutObject->Output(
            TemplateFile => 'AgentITSMConfigItemSearch',
        );

        return $LayoutObject->Attachment(
            NoCache     => 1,
            ContentType => 'text/html',
            Content     => $Output,
            Type        => 'inline',
        );
    }

    # ------------------------------------------------------------ #
    # set search fields for selected class
    # ------------------------------------------------------------ #
    elsif ( $Self->{Subaction} eq 'AJAXUpdate' || $Self->{Subaction} eq 'LoadProfile' ) {

        # ClassID is required for the search mask and for actual searching
        if ( !$ClassID ) {
            return $LayoutObject->ErrorScreen(
                Message => Translatable('No ClassID is given!'),
                Comment => Translatable('Please contact the administrator.'),
            );
        }

        # check if user is allowed to search class
        my $HasAccess = $ConfigItemObject->Permission(
            Type    => $Self->{Config}->{Permission},
            Scope   => 'Class',
            ClassID => $ClassID,
            UserID  => $Self->{UserID},
        );

        # show error screen
        if ( !$HasAccess ) {
            return $LayoutObject->ErrorScreen(
                Message => Translatable('No access rights for this class given!'),
                Comment => Translatable('Please contact the administrator.'),
            );
        }

        # TODO maybe nicer to have this also in a sysconfig setting
        # initializing with common attributes
        my @Attributes = (
            {
                Key   => 'Number',
                Value => Translatable('Number'),
            },
            {
                Key   => 'Name',
                Value => Translatable('Name'),
            },
            {
                Key   => 'DeplStateIDs',
                Value => Translatable('Deployment State'),
            },
            {
                Key   => 'InciStateIDs',
                Value => Translatable('Incident State'),
            },
        );

        # dynamic fields
        my $DynamicFieldSeparator = 1;

        # create dynamic fields search options for attribute select
        # cycle trough the activated Dynamic Fields for this definition
        DYNAMICFIELD:
        for my $DynamicFieldConfig ( values $Definition->{DynamicFieldRef}->%* ) {
            next DYNAMICFIELD if !IsHashRefWithData($DynamicFieldConfig);
            next DYNAMICFIELD if !$DynamicFieldConfig->{Name};
            next DYNAMICFIELD unless $Self->{Config}{DynamicField}{ $DynamicFieldConfig->{Name} };

            # create a separator for dynamic fields attributes
            if ($DynamicFieldSeparator) {
                push @Attributes, (
                    {
                        Key      => '',
                        Value    => '-',
                        Disabled => 1,
                    },
                );
                $DynamicFieldSeparator = 0;
            }

            # get search field preferences
            my $SearchFieldPreferences = $BackendObject->SearchFieldPreferences(
                DynamicFieldConfig => $DynamicFieldConfig,
            );

            next DYNAMICFIELD if !IsArrayRefWithData($SearchFieldPreferences);

            # translate the dynamic field label
            my $TranslatedDynamicFieldLabel = $LayoutObject->{LanguageObject}->Translate(
                $DynamicFieldConfig->{Label},
            );

            PREFERENCE:
            for my $Preference ( @{$SearchFieldPreferences} ) {

                # translate the suffix
                my $TranslatedSuffix = $LayoutObject->{LanguageObject}->Translate(
                    $Preference->{LabelSuffix},
                ) || '';

                if ($TranslatedSuffix) {
                    $TranslatedSuffix = ' (' . $TranslatedSuffix . ')';
                }

                push @Attributes, (
                    {
                        Key => 'Search_DynamicField_'
                            . $DynamicFieldConfig->{Name}
                            . $Preference->{Type},
                        Value => $TranslatedDynamicFieldLabel . $TranslatedSuffix,
                    },
                );
            }
        }

        # create HTML strings for all dynamic fields
        my %DynamicFieldHTML;

        # cycle trough the activated Dynamic Fields for this screen
        DYNAMICFIELD:
        for my $DynamicFieldConfig ( values $Definition->{DynamicFieldRef}->%* ) {
            next DYNAMICFIELD if !IsHashRefWithData($DynamicFieldConfig);
            next DYNAMICFIELD unless $Self->{Config}{DynamicField}{ $DynamicFieldConfig->{Name} };

            my $PossibleValuesFilter;

            my $IsACLReducible = $BackendObject->HasBehavior(
                DynamicFieldConfig => $DynamicFieldConfig,
                Behavior           => 'IsACLReducible',
            );

            if ($IsACLReducible) {

                # get PossibleValues
                my $PossibleValues = $BackendObject->PossibleValuesGet(
                    DynamicFieldConfig => $DynamicFieldConfig,
                );

                # check if field has PossibleValues property in its configuration
                if ( IsHashRefWithData($PossibleValues) ) {

                    # get historical values from database
                    my $HistoricalValues = $BackendObject->HistoricalValuesGet(
                        DynamicFieldConfig => $DynamicFieldConfig,
                    );

                    my $Data = $PossibleValues;

                    # add historic values to current values (if they don't exist anymore)
                    if ( IsHashRefWithData($HistoricalValues) ) {
                        for my $Key ( sort keys %{$HistoricalValues} ) {
                            if ( !$Data->{$Key} ) {
                                $Data->{$Key} = $HistoricalValues->{$Key};
                            }
                        }
                    }

                    # convert possible values key => value to key => key for ACLs using a Hash slice
                    my %AclData = %{$Data};
                    @AclData{ keys %AclData } = keys %AclData;

                    # set possible values filter from ACLs
                    my $ACL = $ConfigItemObject->ConfigItemAcl(
                        Action        => $Self->{Action},
                        ReturnType    => 'ITSMConfigItem',
                        ReturnSubType => 'DynamicField_' . $DynamicFieldConfig->{Name},
                        Data          => \%AclData,
                        UserID        => $Self->{UserID},
                    );
                    if ($ACL) {
                        my %Filter = $ConfigItemObject->ConfigItemAclData();

                        # convert Filer key => key back to key => value using map
                        %{$PossibleValuesFilter} = map { $_ => $Data->{$_} } keys %Filter;
                    }
                }
            }

            # get search field preferences
            my $SearchFieldPreferences = $BackendObject->SearchFieldPreferences(
                DynamicFieldConfig => $DynamicFieldConfig,
            );

            next DYNAMICFIELD if !IsArrayRefWithData($SearchFieldPreferences);

            PREFERENCE:
            for my $Preference ( @{$SearchFieldPreferences} ) {

                # get field HTML
                $DynamicFieldHTML{ $DynamicFieldConfig->{Name} . $Preference->{Type} } = $BackendObject->SearchFieldRender(
                    DynamicFieldConfig   => $DynamicFieldConfig,
                    Profile              => \%GetParam,
                    PossibleValuesFilter => $PossibleValuesFilter,
                    DefaultValue         =>
                        $Self->{Config}{Defaults}{DynamicField}{ $DynamicFieldConfig->{Name} },
                    LayoutObject => $LayoutObject,
                    Type         => $Preference->{Type},
                );
            }
        }

        # build attributes string for attributes list
        $Param{AttributesStrg} = $LayoutObject->BuildSelection(
            PossibleNone => 1,
            Data         => \@Attributes,
            Name         => 'Attribute',
            Multiple     => 0,
            Class        => 'Modernize',
        );

        # build attributes string for recovery on add or subtract search fields
        $Param{AttributesOrigStrg} = $LayoutObject->BuildSelection(
            PossibleNone => 1,
            Data         => \@Attributes,
            Name         => 'AttributeOrig',
            Multiple     => 0,
            Class        => 'Modernize',
        );

        my %Profiles = $SearchProfileObject->SearchProfileList(
            Base      => 'ConfigItemSearch' . $ClassID,
            UserLogin => $Self->{UserLogin},
        );

        $Param{ProfilesStrg} = $LayoutObject->BuildSelection(
            Data         => \%Profiles,
            Name         => 'Profile',
            ID           => 'SearchProfile',
            SelectedID   => $Self->{Profile},
            Class        => 'Modernize',
            PossibleNone => 1,
        );

        # get deployment state list
        my $DeplStateList = $GeneralCatalogObject->ItemList(
            Class => 'ITSM::ConfigItem::DeploymentState',
        );

        # generate dropdown for selecting the wanted deployment states
        my $CurDeplStateOptionStrg = $LayoutObject->BuildSelection(
            Data       => $DeplStateList,
            Name       => 'DeplStateIDs',
            SelectedID => $GetParam{DeplStateIDs} || [],
            Size       => 5,
            Multiple   => 1,
            Class      => 'Modernize',
        );

        # get incident state list
        my $InciStateList = $GeneralCatalogObject->ItemList(
            Class => 'ITSM::Core::IncidentState',
        );

        # generate dropdown for selecting the wanted incident states
        my $CurInciStateOptionStrg = $LayoutObject->BuildSelection(
            Data       => $InciStateList,
            Name       => 'InciStateIDs',
            SelectedID => $GetParam{InciStateIDs} || [],
            Size       => 5,
            Multiple   => 1,
            Class      => 'Modernize',
        );

        # generate PreviousVersionOptionStrg
        my $PreviousVersionOptionStrg = $LayoutObject->BuildSelection(
            Name => 'PreviousVersionSearch',
            Data => {
                0 => Translatable('No'),
                1 => Translatable('Yes'),
            },
            SelectedID => $GetParam{PreviousVersionSearch} || '0',
            Class      => 'Modernize',
        );

        # build output format string
        $Param{ResultFormStrg} = $LayoutObject->BuildSelection(
            Data => {
                Normal => Translatable('Normal'),
                Print  => Translatable('Print'),
                CSV    => Translatable('CSV'),
                Excel  => Translatable('Excel'),
            },
            Name       => 'ResultForm',
            SelectedID => $GetParam{ResultForm} || 'Normal',
            Class      => 'Modernize',
        );

        $LayoutObject->Block(
            Name => 'AJAXContent',
            Data => {
                ClassID                   => $ClassID,
                CurDeplStateOptionStrg    => $CurDeplStateOptionStrg,
                CurInciStateOptionStrg    => $CurInciStateOptionStrg,
                PreviousVersionOptionStrg => $PreviousVersionOptionStrg,
                AttributesStrg            => $Param{AttributesStrg},
                AttributesOrigStrg        => $Param{AttributesOrigStrg},
                ResultFormStrg            => $Param{ResultFormStrg},
                ProfilesStrg              => $Param{ProfilesStrg},
                Number                    => $GetParam{Number} || '',
                Name                      => $GetParam{Name}   || '',
            },
        );

        # output Dynamic fields blocks
        # cycle trough the activated Dynamic Fields for this screen
        DYNAMICFIELD:
        for my $DynamicFieldConfig ( values $Definition->{DynamicFieldRef}->%* ) {
            next DYNAMICFIELD if !IsHashRefWithData($DynamicFieldConfig);
            next DYNAMICFIELD if !$DynamicFieldConfig->{Name};
            next DYNAMICFIELD unless $Self->{Config}{DynamicField}{ $DynamicFieldConfig->{Name} };

            # get search field preferences
            my $SearchFieldPreferences = $BackendObject->SearchFieldPreferences(
                DynamicFieldConfig => $DynamicFieldConfig,
            );

            next DYNAMICFIELD if !IsArrayRefWithData($SearchFieldPreferences);

            PREFERENCE:
            for my $Preference ( @{$SearchFieldPreferences} ) {

                # skip fields that HTML could not be retrieved
                next PREFERENCE if !IsHashRefWithData(
                    $DynamicFieldHTML{ $DynamicFieldConfig->{Name} . $Preference->{Type} }
                );

                $LayoutObject->Block(
                    Name => 'DynamicField',
                    Data => {
                        Label =>
                            $DynamicFieldHTML{ $DynamicFieldConfig->{Name} . $Preference->{Type} }
                            ->{Label},
                        Field =>
                            $DynamicFieldHTML{ $DynamicFieldConfig->{Name} . $Preference->{Type} }
                            ->{Field},
                    },
                );
            }
        }

        # attributes for search
        my @SearchAttributes;

        my %GetParamBackup = %GetParam;

        # show attributes
        my @ShownAttributes;
        if ( $GetParamBackup{ShownAttributes} ) {
            @ShownAttributes = split /;/, $GetParamBackup{ShownAttributes};
        }
        my %AlreadyShown;

        if ( $Self->{Profile} ) {
            ITEM:
            for my $Item (@Attributes) {
                my $Key = $Item->{Key};
                next ITEM if !$Key;

                # check if shown
                if (@ShownAttributes) {
                    my $Show = 0;
                    SHOWN_ATTRIBUTE:
                    for my $ShownAttribute (@ShownAttributes) {
                        if ( 'Label' . $Key eq $ShownAttribute ) {
                            $Show = 1;
                            last SHOWN_ATTRIBUTE;
                        }
                    }
                    next ITEM if !$Show;
                }
                else {
                    # Skip undefined
                    next ITEM if !defined $GetParamBackup{$Key};

                    # Skip empty strings
                    next ITEM if $GetParamBackup{$Key} eq '';

                    # Skip empty arrays
                    if ( ref $GetParamBackup{$Key} eq 'ARRAY' && !@{ $GetParamBackup{$Key} } ) {
                        next ITEM;
                    }
                }

                # show attribute
                next ITEM if $AlreadyShown{$Key};
                $AlreadyShown{$Key} = 1;

                push @SearchAttributes, $Key;
            }
        }

        # No profile, show default screen
        else {

            # Merge regular show/hide settings and the settings for the dynamic fields
            my %Defaults = %{ $Self->{Config}{Defaults} || {} };
            for my $DynamicFields ( sort keys %{ $Self->{Config}{DynamicField} || {} } ) {
                if ( $Self->{Config}{DynamicField}->{$DynamicFields} == 2 ) {
                    $Defaults{"Search_DynamicField_$DynamicFields"} = 1;
                }
            }

            my @OrderedDefaults;
            if (%Defaults) {

                # ordering attributes on the same order like in Attributes
                for my $Item (@Attributes) {
                    my $KeyAtr = $Item->{Key};
                    for my $Key ( sort keys %Defaults ) {
                        if ( $Key eq $KeyAtr ) {
                            push @OrderedDefaults, $Key;
                        }
                    }
                }

                KEY:
                for my $Key (@OrderedDefaults) {
                    next KEY if $Key eq 'DynamicField';    # Ignore entry for DF config
                    next KEY if $AlreadyShown{$Key};
                    $AlreadyShown{$Key} = 1;

                    push @SearchAttributes, $Key;
                }
            }

            # If no attribute is shown, show fulltext search.
            if ( !keys %AlreadyShown ) {
                push @SearchAttributes, 'Fulltext';
            }
        }

        $LayoutObject->AddJSData(
            Key   => 'SearchAttributes',
            Value => \@SearchAttributes,
        );

        my @ProfileAttributes;

        # show attributes
        my $AttributeIsUsed = 0;
        KEY:
        for my $Key ( sort keys %GetParam ) {
            next KEY if !$Key;
            next KEY if !defined $GetParam{$Key};
            next KEY if $GetParam{$Key} eq '';

            $AttributeIsUsed = 1;

            push @ProfileAttributes, $Key;
        }

        # if no attribute is shown, show configitem number
        if ( !$Self->{Profile} ) {
            push @ProfileAttributes, 'Number';
        }

        $LayoutObject->AddJSData(
            Key   => 'ITSMSearchProfileAttributes',
            Value => \@ProfileAttributes,
        );

        # output template
        $Output = $LayoutObject->Output(
            TemplateFile => 'AgentITSMConfigItemSearch',
            AJAX         => 1,
        );

        return $LayoutObject->Attachment(
            NoCache     => 1,
            ContentType => 'text/html',
            Content     => $Output,
            Type        => 'inline',
        );
    }

    # ------------------------------------------------------------ #
    # perform search
    # ------------------------------------------------------------ #
    elsif ( $Self->{Subaction} eq 'Search' ) {

        my $SearchDialog = $ParamObject->GetParam( Param => 'SearchDialog' );

        # fill up profile name (e.g. with last-search)
        if ( !$Self->{Profile} || !$Self->{SaveProfile} ) {
            $Self->{Profile} = 'last-search';
        }

        # store last overview screen
        my $URL = "Action=AgentITSMConfigItemSearch;Profile=$Self->{Profile};"
            . "TakeLastSearch=1;StartHit=$Self->{StartHit};Subaction=Search;"
            . "OrderBy=$Self->{OrderBy};SortBy=$Self->{SortBy}";

        if ($ClassID) {
            $URL .= ";ClassID=$ClassID";
        }

        # get session object
        my $SessionObject = $Kernel::OM->Get('Kernel::System::AuthSession');

        $SessionObject->UpdateSessionID(
            SessionID => $Self->{SessionID},
            Key       => 'LastScreenOverview',
            Value     => $URL,
        );
        $SessionObject->UpdateSessionID(
            SessionID => $Self->{SessionID},
            Key       => 'LastScreenView',
            Value     => $URL,
        );

        # ClassID is required for the search mask and for actual searching
        if ( !$ClassID ) {
            return $LayoutObject->ErrorScreen(
                Message => Translatable('No ClassID is given!'),
                Comment => Translatable('Please contact the administrator.'),
            );
        }

        # check if user is allowed to search class
        my $HasAccess = $ConfigItemObject->Permission(
            Type    => $Self->{Config}->{Permission},
            Scope   => 'Class',
            ClassID => $ClassID,
            UserID  => $Self->{UserID},
        );

        # show error screen
        if ( !$HasAccess ) {
            return $LayoutObject->ErrorScreen(
                Message => Translatable('No access rights for this class given!'),
                Comment => Translatable('Please contact the administrator.'),
            );
        }

        # get current definition
        my $Definition = $ConfigItemObject->DefinitionGet(
            ClassID => $ClassID,
        );

        # abort, if no definition is defined
        if ( !$Definition->{DefinitionID} ) {
            return $LayoutObject->ErrorScreen(
                Message =>
                    $LayoutObject->{LanguageObject}->Translate( 'No definition was defined for class %s!', $ClassID ),
                Comment => Translatable('Please contact the administrator.'),
            );
        }

        # get Dynamic fields from param object
        # cycle trough the activated Dynamic Fields for this screen
        DYNAMICFIELD:
        for my $DynamicFieldConfig ( values $Definition->{DynamicFieldRef}->%* ) {
            next DYNAMICFIELD if !IsHashRefWithData($DynamicFieldConfig);
            next DYNAMICFIELD if !$DynamicFieldConfig->{Name};
            next DYNAMICFIELD unless $Self->{Config}{DynamicField}{ $DynamicFieldConfig->{Name} };

            # get search field preferences
            my $SearchFieldPreferences = $BackendObject->SearchFieldPreferences(
                DynamicFieldConfig => $DynamicFieldConfig,
            );

            next DYNAMICFIELD if !IsArrayRefWithData($SearchFieldPreferences);

            PREFERENCE:
            for my $Preference ( @{$SearchFieldPreferences} ) {

                # extract the dynamic field value from the web request
                my $DynamicFieldValue = $BackendObject->SearchFieldValueGet(
                    DynamicFieldConfig     => $DynamicFieldConfig,
                    ParamObject            => $ParamObject,
                    ReturnProfileStructure => 1,
                    LayoutObject           => $LayoutObject,
                    Type                   => $Preference->{Type},
                );

                # set the complete value structure in GetParam to store it later in the search profile
                if ( IsHashRefWithData($DynamicFieldValue) ) {
                    %GetParam = ( %GetParam, %{$DynamicFieldValue} );
                }
            }
        }

        # save search profile (under last-search or real profile name)
        $Self->{SaveProfile} = 1;

        # remember last search values only if search is called from a search dialog
        # not from results page
        if ( $Self->{SaveProfile} && $Self->{Profile} && $SearchDialog ) {

            # convert attributes
            if ( $GetParam{ShownAttributes} && ref $GetParam{ShownAttributes} eq '' ) {
                $GetParam{ShownAttributes} = [ split /;/, $GetParam{ShownAttributes} ];
            }

            # remove old profile stuff
            $SearchProfileObject->SearchProfileDelete(
                Base      => 'ConfigItemSearch' . $ClassID,
                Name      => $Self->{Profile},
                UserLogin => $Self->{UserLogin},
            );

            # insert new profile params
            for my $Key ( sort keys %GetParam ) {
                if ( $GetParam{$Key} && $Key ne 'What' ) {
                    $SearchProfileObject->SearchProfileAdd(
                        Base      => 'ConfigItemSearch' . $ClassID,
                        Name      => $Self->{Profile},
                        Key       => $Key,
                        Value     => $GetParam{$Key},
                        UserLogin => $Self->{UserLogin},
                    );
                }
            }
        }

        my %AttributeLookup;

        # create attribute lookup table
        for my $Attribute ( @{ $GetParam{ShownAttributes} || [] } ) {
            $AttributeLookup{$Attribute} = 1;
        }

        # dynamic fields search parameters for ticket search
        my %DynamicFieldSearchParameters;

        # cycle trough the activated Dynamic Fields for this screen
        DYNAMICFIELD:
        for my $DynamicFieldConfig ( values $Definition->{DynamicFieldRef}->%* ) {
            next DYNAMICFIELD if !IsHashRefWithData($DynamicFieldConfig);
            next DYNAMICFIELD if !$DynamicFieldConfig->{Name};
            next DYNAMICFIELD unless $Self->{Config}{DynamicField}{ $DynamicFieldConfig->{Name} };

            # get search field preferences
            my $SearchFieldPreferences = $BackendObject->SearchFieldPreferences(
                DynamicFieldConfig => $DynamicFieldConfig,
            );

            next DYNAMICFIELD if !IsArrayRefWithData($SearchFieldPreferences);

            PREFERENCE:
            for my $Preference ( @{$SearchFieldPreferences} ) {

                if (
                    !$AttributeLookup{
                        'LabelSearch_DynamicField_'
                            . $DynamicFieldConfig->{Name}
                            . $Preference->{Type}
                    }
                    )
                {
                    next PREFERENCE;
                }

                # extract the dynamic field value from the profile
                my $SearchParameter = $BackendObject->SearchFieldParameterBuild(
                    DynamicFieldConfig => $DynamicFieldConfig,
                    Profile            => \%GetParam,
                    LayoutObject       => $LayoutObject,
                    Type               => $Preference->{Type},
                );

                # set search parameter
                if ( defined $SearchParameter ) {
                    $DynamicFieldSearchParameters{ 'DynamicField_' . $DynamicFieldConfig->{Name} } = $SearchParameter->{Parameter};
                }
            }
        }

        # attributes for search
        my @SearchAttributes;

        my @SearchResultList;

        # start search if called from a search dialog or from a results page
        if ( $SearchDialog || $Self->{TakeLastSearch} ) {

            # start search
            @SearchResultList = $ConfigItemObject->ConfigItemSearch(
                %GetParam,
                %DynamicFieldSearchParameters,
                OrderBy  => [ $Self->{OrderBy} ],
                SortBy   => [ $Self->{SortBy} ],
                Limit    => $Self->{SearchLimit},
                ClassIDs => [$ClassID],
                Result   => 'ARRAY',
            );
        }

        # get the confconfig item dynamic fields for CSV display
        my $CSVDynamicField = $Kernel::OM->Get('Kernel::System::DynamicField')->DynamicFieldListGet(
            Valid       => 1,
            ObjectType  => ['ITSMConfigItem'],
            FieldFilter => $Self->{Config}{SearchCSVDynamicField} || {},
        );

        # CSV output
        if (
            $GetParam{ResultForm} eq 'CSV'
            ||
            $GetParam{ResultForm} eq 'Excel'
            )
        {
            # create head (actual head and head for data fill)
            my @TmpCSVHead = @{ $Self->{Config}{SearchCSVData} };
            my @CSVHead    = @{ $Self->{Config}{SearchCSVData} };

            # include the selected dynamic fields in CVS results
            DYNAMICFIELD:
            for my $DynamicFieldConfig ( @{$CSVDynamicField} ) {
                next DYNAMICFIELD if !IsHashRefWithData($DynamicFieldConfig);
                next DYNAMICFIELD if !$DynamicFieldConfig->{Name};
                next DYNAMICFIELD if $DynamicFieldConfig->{Name} eq '';

                push @TmpCSVHead, 'DynamicField_' . $DynamicFieldConfig->{Name};
                push @CSVHead,    $DynamicFieldConfig->{Label};
            }

            my @CSVData;

            CONFIGITEMID:
            for my $ConfigItemID (@SearchResultList) {

                # check for access rights
                my $HasAccess = $ConfigItemObject->Permission(
                    Scope  => 'Item',
                    ItemID => $ConfigItemID,
                    UserID => $Self->{UserID},
                    Type   => $Self->{Config}->{Permission},
                );

                next CONFIGITEMID if !$HasAccess;

                # get version
                my $LastVersion = $ConfigItemObject->ConfigItemGet(
                    ConfigItemID  => $ConfigItemID,
                    DynamicFields => 1,
                );

                # csv quote
                if ( !@CSVHead ) {
                    @CSVHead = @{ $Self->{Config}->{SearchCSVData} };
                }

                # store data
                my @Data;
                for my $Header (@TmpCSVHead) {

                    # check if header is a dynamic field and get the value from dynamic field
                    # backend
                    if ( $Header =~ m{\A DynamicField_ ( [a-zA-Z\d\-]+ ) \z}xms ) {

                        # loop over the dynamic fields configured for CSV output
                        DYNAMICFIELD:
                        for my $DynamicFieldConfig ( @{$CSVDynamicField} ) {
                            next DYNAMICFIELD if !IsHashRefWithData($DynamicFieldConfig);
                            next DYNAMICFIELD if !$DynamicFieldConfig->{Name};

                            # skip all fields that does not match with current field name ($1)
                            # with out the 'DynamicField_' prefix
                            next DYNAMICFIELD if $DynamicFieldConfig->{Name} ne $1;

                            # get the value as for print (to correctly display)
                            my $ValueStrg = $BackendObject->DisplayValueRender(
                                DynamicFieldConfig => $DynamicFieldConfig,
                                Value              => $LastVersion->{$Header},
                                HTMLOutput         => 0,
                                LayoutObject       => $LayoutObject,
                            );
                            push @Data, $ValueStrg->{Value};

                            # terminate the DYNAMICFIELD loop
                            last DYNAMICFIELD;
                        }
                    }

                    # otherwise retrieve data from article
                    else {
                        push @Data, $LastVersion->{$Header};
                    }
                }
                push @CSVData, \@Data;
            }

            # csv quote
            # translate non existing header may result in a garbage file
            if ( !@CSVHead ) {
                @CSVHead = @{ $Self->{Config}->{SearchCSVData} };
            }

            # translate headers
            for my $Header (@CSVHead) {

                # replace ConfigItemNumber header with the current ConfigItemNumber hook from sysconfig
                if ( $Header eq 'ConfigItemNumber' ) {
                    $Header = $ConfigObject->Get('ITSMConfigItem::Hook');
                }
                else {
                    $Header = $LayoutObject->{LanguageObject}->Translate($Header);
                }
            }

            my $CSVObject      = $Kernel::OM->Get('Kernel::System::CSV');
            my $CurSysDTObject = $Kernel::OM->Create('Kernel::System::DateTime');
            if ( $GetParam{ResultForm} eq 'CSV' ) {

                # Assemble CSV data.
                my $CSV = $CSVObject->Array2CSV(
                    Head      => \@CSVHead,
                    Data      => \@CSVData,
                    Separator => $Self->{UserCSVSeparator},
                );

                # Return CSV to download.
                return $LayoutObject->Attachment(
                    Filename => sprintf(
                        'change_search_%s.csv',
                        $CurSysDTObject->Format(
                            Format => '%F_%H-%M',
                        ),
                    ),
                    ContentType => "text/csv; charset=" . $LayoutObject->{UserCharset},
                    Content     => $CSV,
                );
            }
            elsif ( $GetParam{ResultForm} eq 'Excel' ) {

                # Assemble Excel data.
                my $Excel = $CSVObject->Array2CSV(
                    Head   => \@CSVHead,
                    Data   => \@CSVData,
                    Format => 'Excel',
                );

                # Return Excel to download.
                return $LayoutObject->Attachment(
                    Filename => sprintf(
                        'change_search_%s.xlsx',
                        $CurSysDTObject->Format(
                            Format => '%F_%H-%M',
                        ),
                    ),
                    ContentType => "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
                    Content     => $Excel,
                );
            }
        }

        # print PDF output
        elsif ( $GetParam{ResultForm} eq 'Print' ) {

            my @PDFData;

            # get pdf object
            my $PDFObject = $Kernel::OM->Get('Kernel::System::PDF');

            CONFIGITEMID:
            for my $ConfigItemID (@SearchResultList) {

                # check for access rights
                my $HasAccess = $ConfigItemObject->Permission(
                    Scope  => 'Item',
                    ItemID => $ConfigItemID,
                    UserID => $Self->{UserID},
                    Type   => $Self->{Config}->{Permission},
                );

                next CONFIGITEMID if !$HasAccess;

                # get version
                my $LastVersion = $ConfigItemObject->ConfigItemGet(
                    ConfigItemID => $ConfigItemID,
                );

                # set pdf rows
                my @PDFRow;
                for my $StoreData (qw(Class InciState Name Number DeplState VersionID CreateTime)) {
                    push @PDFRow, $LastVersion->{$StoreData};
                }
                push @PDFData, \@PDFRow;

            }

            # PDF Output
            my $Title = $LayoutObject->{LanguageObject}->Translate('Configuration Item') . ' '
                . $LayoutObject->{LanguageObject}->Translate('Search');
            my $PrintedBy = $LayoutObject->{LanguageObject}->Translate('printed by');
            my $Page      = $LayoutObject->{LanguageObject}->Translate('Page');
            my $Time      = $LayoutObject->{Time};

            # get maximum number of pages
            my $MaxPages = $ConfigObject->Get('PDF::MaxPages');
            if ( !$MaxPages || $MaxPages < 1 || $MaxPages > 1000 ) {
                $MaxPages = 100;
            }

            # create the header
            my $CellData;

            # output 'No Result', if no content was given
            if (@PDFData) {
                $CellData->[0]->[0]->{Content} = $LayoutObject->{LanguageObject}->Translate('Class');
                $CellData->[0]->[0]->{Font}    = 'ProportionalBold';
                $CellData->[0]->[1]->{Content} = $LayoutObject->{LanguageObject}->Translate('Incident State');
                $CellData->[0]->[1]->{Font}    = 'ProportionalBold';
                $CellData->[0]->[2]->{Content} = $LayoutObject->{LanguageObject}->Translate('Name');
                $CellData->[0]->[2]->{Font}    = 'ProportionalBold';
                $CellData->[0]->[3]->{Content} = $LayoutObject->{LanguageObject}->Translate('Number');
                $CellData->[0]->[3]->{Font}    = 'ProportionalBold';
                $CellData->[0]->[4]->{Content} = $LayoutObject->{LanguageObject}->Translate('Deployment State');
                $CellData->[0]->[4]->{Font}    = 'ProportionalBold';
                $CellData->[0]->[5]->{Content} = $LayoutObject->{LanguageObject}->Translate('Version');
                $CellData->[0]->[5]->{Font}    = 'ProportionalBold';
                $CellData->[0]->[6]->{Content} = $LayoutObject->{LanguageObject}->Translate('Create Time');
                $CellData->[0]->[6]->{Font}    = 'ProportionalBold';

                # create the content array
                my $CounterRow = 1;
                for my $Row (@PDFData) {
                    my $CounterColumn = 0;
                    for my $Content ( @{$Row} ) {
                        $CellData->[$CounterRow]->[$CounterColumn]->{Content} = $Content;
                        $CounterColumn++;
                    }
                    $CounterRow++;
                }
            }
            else {
                $CellData->[0]->[0]->{Content} = $LayoutObject->{LanguageObject}->Translate('No Result!');
            }

            # page params
            my %PageParam;
            $PageParam{PageOrientation} = 'landscape';
            $PageParam{MarginTop}       = 30;
            $PageParam{MarginRight}     = 40;
            $PageParam{MarginBottom}    = 40;
            $PageParam{MarginLeft}      = 40;
            $PageParam{HeaderRight}     = $Title;

            # table params
            my %TableParam;
            $TableParam{CellData}            = $CellData;
            $TableParam{Type}                = 'Cut';
            $TableParam{FontSize}            = 6;
            $TableParam{Border}              = 0;
            $TableParam{BackgroundColorEven} = '#DDDDDD';
            $TableParam{Padding}             = 1;
            $TableParam{PaddingTop}          = 3;
            $TableParam{PaddingBottom}       = 3;

            # create new pdf document
            $PDFObject->DocumentNew(
                Title  => $ConfigObject->Get('Product') . ': ' . $Title,
                Encode => $LayoutObject->{UserCharset},
            );

            # start table output
            $PDFObject->PageNew(
                %PageParam,
                FooterRight => $Page . ' 1',
            );

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
                Text => $PrintedBy . ' '
                    . $Self->{UserFullname} . ' '
                    . $Time,
                FontSize => 9,
            );

            $PDFObject->PositionSet(
                Move => 'relativ',
                Y    => -14,
            );

            PAGE:
            for my $Count ( 2 .. $MaxPages ) {

                # output table (or a fragment of it)
                %TableParam = $PDFObject->Table(%TableParam);

                # stop output or another page
                if ( $TableParam{State} ) {
                    last PAGE;
                }
                else {
                    $PDFObject->PageNew(
                        %PageParam,
                        FooterRight => $Page . ' ' . $Count,
                    );
                }
            }

            # return the pdf document
            my $CurrentSystemDTObj = $Kernel::OM->Create('Kernel::System::DateTime');
            my $PDFString          = $PDFObject->DocumentOutput();
            return $LayoutObject->Attachment(
                Filename => sprintf(
                    'configitem_search_%s_%s.pdf',
                    $CurrentSystemDTObj->Format( Format => '%F_%H-%M' ),
                ),
                ContentType => "application/pdf",
                Content     => $PDFString,
                Type        => 'inline',
            );
        }

        # normal HTML output
        else {

            # start html page
            my $Output = $LayoutObject->Header();
            $Output .= $LayoutObject->NavigationBar();

            # use classname as filter
            $Self->{Filter} = $ClassList->{$ClassID}                    || 'All';
            $Self->{View}   = $ParamObject->GetParam( Param => 'View' ) || '';

            # show config items
            my $LinkPage = 'Filter='
                . $LayoutObject->Ascii2Html( Text => $Self->{Filter} )
                . ';View=' . $LayoutObject->Ascii2Html( Text => $Self->{View} )
                . ';SortBy=' . $LayoutObject->Ascii2Html( Text => $Self->{SortBy} )
                . ';OrderBy='
                . $LayoutObject->Ascii2Html( Text => $Self->{OrderBy} )
                . ';Profile=' . $Self->{Profile} . ';TakeLastSearch=1;Subaction=Search'
                . ';ClassID=' . $ClassID
                . ';';
            my $LinkSort = 'Filter='
                . $LayoutObject->Ascii2Html( Text => $Self->{Filter} )
                . ';View=' . $LayoutObject->Ascii2Html( Text => $Self->{View} )
                . ';Profile=' . $Self->{Profile} . ';TakeLastSearch=1;Subaction=Search'
                . ';ClassID=' . $ClassID
                . ';';
            my $LinkFilter = 'TakeLastSearch=1;Subaction=Search;Profile='
                . $LayoutObject->Ascii2Html( Text => $Self->{Profile} )
                . ';ClassID='
                . $LayoutObject->Ascii2Html( Text => $ClassID )
                . ';';
            my $LinkBack = 'Subaction=LoadProfile;Profile='
                . $LayoutObject->Ascii2Html( Text => $Self->{Profile} )
                . ';ClassID='
                . $LayoutObject->Ascii2Html( Text => $ClassID )
                . ';TakeLastSearch=1;';

            my $ClassName = $ClassList->{$ClassID};
            my $Title     = $LayoutObject->{LanguageObject}->Translate('Config Item Search Results')
                . ' '
                . $LayoutObject->{LanguageObject}->Translate('Class')
                . ' '
                . $LayoutObject->{LanguageObject}->Translate($ClassName);

            $Output .= $LayoutObject->ITSMConfigItemListShow(
                ConfigItemIDs => \@SearchResultList,
                Total         => scalar @SearchResultList,
                View          => $Self->{View},
                Filter        => $ClassName,
                Env           => $Self,
                LinkPage      => $LinkPage,
                LinkSort      => $LinkSort,
                LinkFilter    => $LinkFilter,
                LinkBack      => $LinkBack,
                Profile       => $Self->{Profile},
                TitleName     => $Title,
                SortBy        => $LayoutObject->Ascii2Html( Text => $Self->{SortBy} ),
                OrderBy       => $LayoutObject->Ascii2Html( Text => $Self->{OrderBy} ),
                ClassID       => $ClassID,
                RequestURL    => $Self->{RequestedURL},
                Bulk          => 1,
            );

            $LayoutObject->AddJSData(
                Key   => 'ITSMConfigItemSearch',
                Value => {
                    Profile => $Self->{Profile},
                    ClassID => $ClassID,
                    Action  => $Self->{Action},
                },
            );

            # build footer
            $Output .= $LayoutObject->Footer();

            return $Output;
        }
    }

    # ------------------------------------------------------------ #
    # call search dialog from search empty screen
    # ------------------------------------------------------------ #
    else {

        # show default search screen
        $Output = $LayoutObject->Header();
        $Output .= $LayoutObject->NavigationBar();

        $LayoutObject->AddJSData(
            Key   => 'ITSMConfigItemOpenSearchDialog',
            Value => {
                Profile => $Self->{Profile},
                ClassID => $ClassID,
                Action  => $Self->{Action},
            },
        );

        # output template
        $Output .= $LayoutObject->Output(
            TemplateFile => 'AgentITSMConfigItemSearch',
            Data         => \%Param,
        );

        # output footer
        $Output .= $LayoutObject->Footer();

        return $Output;
    }
}

1;

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

package Kernel::Output::HTML::ITSMConfigItem::CustomerList;

use strict;
use warnings;

use Kernel::System::VariableCheck qw(:all);
use Kernel::Language qw(Translatable);
use Digest::MD5 qw(md5_hex);

our @ObjectDependencies = (
    'Kernel::System::CustomerUser',
    'Kernel::System::DynamicField',
    'Kernel::System::DynamicField::Backend',
    'Kernel::Config',
    'Kernel::System::Group',
    'Kernel::System::Log',
    'Kernel::Output::HTML::Layout',
    'Kernel::System::User',
    'Kernel::System::ITSMConfigItem',
    'Kernel::System::Main',
);

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = \%Param;
    bless( $Self, $Type );

    return $Self;
}

sub Run {
    my ( $Self, %Param ) = @_;

    if ( !defined $Param{ConfigItemIDs} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => 'Need ITSMConfigItemList!',
        );
        return;
    }

    # get needed object
    my $ConfigObject         = $Kernel::OM->Get('Kernel::Config');
    my $LayoutObject         = $Kernel::OM->Get('Kernel::Output::HTML::Layout');
    my $ITSMConfigItemObject = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');

    # generate empty message
    if ( scalar @{ $Param{ConfigItemIDs} } == 0 ) {

        # customeruser has no config items at all
        if ( $Param{NoAllTotal} ) {
            if ( $Param{CustomText} ) {
                $LayoutObject->Block(
                    Name => 'EmptyCustom',
                    Data => $Param{CustomText},
                );
            }
            else {
                $LayoutObject->Block(
                    Name => 'EmptyDefault',
                );
            }
        }

        # customeruser has no config items under the current filter
        else {
            $LayoutObject->Block(
                Name => 'EmptyFilter',
            );
        }
    }

    my $ITSMConfigItemStart = $Param{StartHit} ? $Param{StartHit} - 1 : 0;
    my $ITSMConfigItemEnd   = $Param{PageShown}
        ? ( sort { $a <=> $b } ( $Param{PageShown} - 1 + $ITSMConfigItemStart, $#{ $Param{ConfigItemIDs} } ) )[0]
        : $#{ $Param{ConfigItemIDs} };

    # generate ticket list
    for my $ConfigItemID ( @{ $Param{ConfigItemIDs} }[ $ITSMConfigItemStart .. $ITSMConfigItemEnd ] ) {

        # get ticket info
        my %ConfigItem = $ITSMConfigItemObject->ConfigItemGet(
            ConfigItemID  => $ConfigItemID,
            DynamicFields => 0,
        );

        my $ConfigObject          = $Kernel::OM->Get('Kernel::Config');
        my $SmallViewColumnHeader = $ConfigObject->Get('ITSMConfigItem::Frontend::CustomerITSMConfigItem')->{ColumnHeader};

        # TODO check if to remove or to rewrite
        # if ( $SmallViewColumnHeader eq 'LastCustomerSubject' ) {
        #     $Subject = $Article{Subject} || '';
        # }
        # elsif ( $SmallViewColumnHeader eq 'ITSMConfigItemTitle' && $ArticleList[0] ) {
        #     $Subject = $ITSMConfigItem{Title};
        # }
        # else {
        #     $Subject = Translatable('Untitled!');
        # }

        # Age design.
        $ConfigItem{CustomerAge} = $LayoutObject->CustomerAge(
            Age   => $ConfigItem{Age},
            Space => ' '
        ) || 0;

        # TODO retrieve customer user id from configured identifier field
        # name and avatar
        my %CustomerUser = $Kernel::OM->Get('Kernel::System::CustomerUser')->CustomerUserDataGet(

            # User => $Article{CustomerUserID} || $ITSMConfigItem{CustomerUserID},
            User => $Self->{CustomerUserID},
        );
        my $CustomerName = $Kernel::OM->Get('Kernel::System::CustomerUser')->CustomerName(

            # UserLogin => $Article{CustomerUserID} || $ITSMConfigItem{CustomerUserID},
            User => $Self->{CustomerUserID},
        );
        my ( $Avatar, $UserInitials );
        if ( $ConfigObject->Get('Frontend::AvatarEngine') eq 'Gravatar' && $CustomerUser{UserEmail} ) {
            my $DefaultIcon = $ConfigObject->Get('Frontend::Gravatar::DefaultImage') || 'mm';
            $Avatar = '//www.gravatar.com/avatar/' . md5_hex( lc $CustomerUser{UserEmail} ) . '?s=100&d=' . $DefaultIcon;
        }
        else {
            $UserInitials = substr( $CustomerUser{UserFirstname}, 0, 1 ) . substr( $CustomerUser{UserLastname}, 0, 1 );
        }

        # TODO likely remove
        # gather categories to be shown
        my %Categories;
        my $CategoryConfig = $ConfigObject->Get("ITSMConfigItem::Frontend::CustomerITSMConfigItemCategories");

        # standard config item categories
        CAT:
        for my $CatName (qw/Class Number DeplState InciState/) {
            next CAT if !$ConfigItem{$CatName};
            if ( $CategoryConfig->{$CatName} ) {
                my $Conf = $CategoryConfig->{$CatName};
                my $Text = $Conf->{Text} // $ConfigItem{$CatName};

                $Conf->{ColorSelection} //= {};
                my $Color = $Conf->{ColorSelection}{ $ConfigItem{$CatName} } // $Conf->{ColorDefault};

                push @{ $Categories{ $Conf->{Order} } }, {
                    Text   => $Text,
                    Color  => $Color,
                    Value  => $ConfigItem{$CatName},
                    Config => $Conf,
                };
            }
        }

        # get the dynamic fields for this screen
        my $DynamicFieldObject = $Kernel::OM->Get('Kernel::System::DynamicField');
        my $BackendObject      = $Kernel::OM->Get('Kernel::System::DynamicField::Backend');

        # get dynamic field config for frontend module
        my $DynamicFieldFilter = $ConfigObject->Get("ITSMConfigItem::Frontend::CustomerITSMConfigItem")->{DynamicField};
        my $DynamicField       = $DynamicFieldObject->DynamicFieldListGet(
            Valid       => 1,
            ObjectType  => ['ITSMConfigItem'],
            FieldFilter => $DynamicFieldFilter || {},
        );

        my %DynamicFieldCategories = $CategoryConfig->{DynamicField}
            ?
            map { $CategoryConfig->{DynamicField}{$_}{DynamicField} => $_ } keys %{ $CategoryConfig->{DynamicField} }
            : ();

        # Dynamic fields
        # cycle trough the activated Dynamic Fields for this screen
        DYNAMICFIELD:
        for my $DynamicFieldConfig ( @{$DynamicField} ) {
            next DYNAMICFIELD if !IsHashRefWithData($DynamicFieldConfig);

            my $IsCustomerInterfaceCapable = $BackendObject->HasBehavior(
                DynamicFieldConfig => $DynamicFieldConfig,
                Behavior           => 'IsCustomerInterfaceCapable',
            );
            next DYNAMICFIELD if !$IsCustomerInterfaceCapable;

            # get field value
            my $Value = $BackendObject->ValueGet(
                DynamicFieldConfig => $DynamicFieldConfig,
                ObjectID           => $ConfigItem{ITSMConfigItemID},
            );

            my $ValueStrg = $BackendObject->DisplayValueRender(
                DynamicFieldConfig => $DynamicFieldConfig,
                Value              => $Value,
                ValueMaxChars      => 20,
                LayoutObject       => $LayoutObject,
            );
            next DYNAMICFIELD if ( !defined $ValueStrg->{Value} || $ValueStrg->{Value} eq '' );

            # build %Categories as $Categories{<Order>} = [ {Text => '', Color => ''}, ... ]
            if ( $DynamicFieldCategories{ $DynamicFieldConfig->{Name} } ) {
                my $Conf = $CategoryConfig->{DynamicField}{ $DynamicFieldCategories{ $DynamicFieldConfig->{Name} } };
                my $Text = $Conf->{Text} // $ValueStrg->{Value};

                $Conf->{ColorSelection} //= {};
                my $Color = $Conf->{ColorSelection}{ $ValueStrg->{Value} } // $Conf->{ColorDefault};

                push @{ $Categories{ $Conf->{Order} } }, {
                    Text   => $Text,
                    Color  => $Color,
                    Value  => $ValueStrg->{Value},
                    Config => $Conf,
                };
            }
        }

        $LayoutObject->Block(
            Name => 'ITSMConfigItem',
            Data => {
                %ConfigItem,
                CustomerName => $CustomerName,
                Avatar       => $Avatar,
                UserInitials => $UserInitials,
            },
        );

        for my $Order ( sort { $a <=> $b } keys %Categories ) {
            for my $Category ( @{ $Categories{$Order} } ) {
                $LayoutObject->Block(
                    Name => 'Categories',
                    Data => $Category,
                );
            }
        }
    }

    # create & return output
    return $LayoutObject->Output(
        TemplateFile => 'CustomerITSMConfigItemList',
    );
}

1;

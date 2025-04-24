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

package Kernel::System::ITSMConfigItem::Event::DefinitionConfigItemUpdate;

use v5.24;
use strict;
use warnings;
use namespace::autoclean;
use utf8;

# core modules

# CPAN modules

# OTOBO modules

our @ObjectDependencies = (
    'Kernel::System::Cache',
    'Kernel::System::DB',
    'Kernel::System::GeneralCatalog',
    'Kernel::System::ITSMConfigItem',
    'Kernel::System::Log',
);

=head1 NAME

Kernel::System::ITSMConfigItem::Event::DefinitionConfigItemUpdate - Event handler that updates config items on definition changes

=head1 PUBLIC INTERFACE

=head2 new()

create an object

    use Kernel::System::ObjectManager;

    local $Kernel::OM = Kernel::System::ObjectManager->new();
    my $EventObject = $Kernel::OM->Get('Kernel::System::ITSMConfigItem::Event::DefinitionConfigItemUpdate');

=cut

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    return bless {}, $Type;
}

=head2 Run()

This method handles the event.

    $EventObject->Run(
        Event => 'DefinitionCreate',
        Data  => {
            DefinitionID => $DefinitionID,
            ClassID      => $Param{ClassID},
        },
        UserID => 1,
    );

=cut

sub Run {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Needed (qw(Data Event UserID)) {
        if ( !$Param{$Needed} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Needed!",
            );
            return;
        }
    }

    return if $Param{Event} ne 'DefinitionCreate';

    # check needed stuff
    for my $Needed (qw(DefinitionID ClassID)) {
        if ( !$Param{Data}{$Needed} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Needed in Data!",
            );
            return;
        }
    }

    my $ConfigItemObject = $Kernel::OM->Get('Kernel::System::ITSMConfigItem');
    my $DBObject         = $Kernel::OM->Get('Kernel::System::DB');

    # only consider productive and preproductive CIs
    my $StateList = $Kernel::OM->Get('Kernel::System::GeneralCatalog')->ItemList(
        Class       => 'ITSM::ConfigItem::DeploymentState',
        Preferences => {
            Functionality => [ 'preproductive', 'productive' ],
        },
    );

    my $DeplStateString = join q{, }, keys %{$StateList};

    # only consider productive and preproductive CIs
    my %AffectedCIs = $DBObject->SelectMapping(
        SQL => 'SELECT ci.id, ci.last_version_id FROM configitem ci'
            . " WHERE ci.class_id = ? AND ci.cur_depl_state_id IN ( $DeplStateString )",
        Bind => [ \$Param{Data}{ClassID} ],
    );

    return if !%AffectedCIs;

    # add history entries
    for my $ID ( keys %AffectedCIs ) {
        $ConfigItemObject->HistoryAdd(
            ConfigItemID => $ID,
            HistoryType  => 'DefinitionUpdate',
            UserID       => $Param{UserID},
            Comment      => "$Param{Data}{DefinitionID}",
        );
    }

    my $DefinitionRef = $ConfigItemObject->DefinitionGet(
        ClassID => $Param{Data}->{ClassID},
        DefinitionID => $Param{Data}->{DefinitionID},
    );

    my @DynamicFieldNames = keys $DefinitionRef->{DynamicFieldRef}->%*;
    foreach my $DynamicFieldName ( @DynamicFieldNames ) {

        my $DF = $DefinitionRef->{DynamicFieldRef}->{$DynamicFieldName};

        IDS:
        for my $ID ( keys %AffectedCIs ) {
        
            next IDS unless $DF->{Config}->{ReferencedObjectType};
            next IDS unless $DF->{Config}->{ReferencedObjectType} =~ '^ITSMConfigItem';
            my $ConfigItem = $ConfigItemObject->ConfigItemGet(
                ConfigItemID  => $ID,
                DynamicFields => 1,    # (optional) default 0 (0|1)
            );            

            my $Value = $ConfigItem->{"DynamicField_$DynamicFieldName"};
            next IDS unless $Value;

            $ConfigItemObject->SyncLinkTable(
                DynamicFieldConfig      =>  $DF,
                ConfigItemID            => $ID,
                ConfigItemLastVersionID => $ConfigItem->{LastVersionID},
                ConfigItemVersionID     => $ConfigItem->{VersionID},
  #              OldValue                => $Param{Data}->{OldValue},
                Value                   => $Value,
            );    
        }
    }


    my %ClassPreferences = $Kernel::OM->Get('Kernel::System::GeneralCatalog')->GeneralCatalogPreferencesGet(
        ItemID => $Param{Data}{ClassID},
    );

    # if definition updates should trigger the creation of a new version, call VersionAdd
    if ( grep { $_ eq 'DefinitionUpdate' } @{ $ClassPreferences{VersionTrigger} // [] } ) {
        for my $ID ( keys %AffectedCIs ) {
            $ConfigItemObject->VersionAdd(
                ConfigItemID => $ID,
                UserID       => $Param{UserID},
            );
        }
    }

    # if we do not need to add a new version, update all affected versions and clear the cache
    else {
        $DBObject->Do(
            SQL => 'UPDATE configitem_version'
                . ' SET definition_id = ?'
                . ' WHERE id IN ('
                . ' SELECT last_version_id'
                . ' FROM configitem'
                . ' WHERE class_id = ?'
                . " AND cur_depl_state_id IN ( $DeplStateString )"
                . ' )',
            Bind => [ \$Param{Data}{DefinitionID}, \$Param{Data}{ClassID} ],
        );

        # clear the cache
        my $CacheObject = $Kernel::OM->Get('Kernel::System::Cache');

        for my $ID ( keys %AffectedCIs ) {
            for my $DFData ( 0, 1 ) {
                $CacheObject->Delete(
                    Type => $ConfigItemObject->{CacheType},
                    Key  => join(
                        '::', 'ConfigItemGet',
                        ConfigItemID => $ID,
                        DFData       => $DFData,
                    ),
                );
                $CacheObject->Delete(
                    Type => $ConfigItemObject->{CacheType},
                    Key  => join(
                        '::', 'ConfigItemGet',
                        VersionID => $AffectedCIs{$ID},
                        DFData    => $DFData,
                    ),
                );
            }
        }
    }

    return 1;
}

1;

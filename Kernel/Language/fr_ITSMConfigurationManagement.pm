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

package Kernel::Language::fr_ITSMConfigurationManagement;

use strict;
use warnings;
use utf8;

sub Data {
    my $Self = shift;

    # Template: AdminITSMConfigItem
    $Self->{Translation}->{'Config Item Management'} = 'Gestion des éléments de configuration';
    $Self->{Translation}->{'Change class definition'} = 'Modifier la définition d\'une classe';
    $Self->{Translation}->{'Config Item Class'} = 'Classe d\'élément de configuration';
    $Self->{Translation}->{'Definition'} = 'Définition';
    $Self->{Translation}->{'Change'} = 'Modifier';

    # Template: AgentDashboardITSMConfigItemGeneric
    $Self->{Translation}->{'Incident State'} = 'État d\'incident';
    $Self->{Translation}->{'Deployment State'} = 'État de déploiement';
    $Self->{Translation}->{'Class'} = 'Classe';
    $Self->{Translation}->{'Deployment State Type'} = 'Type d\'état du déploiement';
    $Self->{Translation}->{'Current Incident State'} = 'État actuel de l\'incident';
    $Self->{Translation}->{'Current Incident State Type'} = 'Type d\'état actuel de l\'incident';
    $Self->{Translation}->{'Last changed'} = 'Dernières modifications';

    # Template: AgentITSMConfigItemAdd
    $Self->{Translation}->{'Config Item'} = 'Élément de configuration';
    $Self->{Translation}->{'Filter for Classes'} = 'Filtres pour les classes';
    $Self->{Translation}->{'Select a Class from the list to create a new Config Item.'} = 'Choisissez une classe pour créer un nouvel élément de configuration.';

    # Template: AgentITSMConfigItemBulk
    $Self->{Translation}->{'ITSM ConfigItem Bulk Action'} = '';
    $Self->{Translation}->{'Deployment state'} = 'État du déploiement';
    $Self->{Translation}->{'Incident state'} = 'État de l\'incident';
    $Self->{Translation}->{'Link to another'} = 'Lier à un autre';
    $Self->{Translation}->{'Invalid Configuration Item number!'} = 'Numéro d\'élément de configuration invalide !';
    $Self->{Translation}->{'The number of another Configuration Item to link with.'} = 'Le numéro d\'un autre élément de configuration à lier.';

    # Template: AgentITSMConfigItemDelete
    $Self->{Translation}->{'Do you really want to delete this config item?'} = 'Voulez-vous vraiment supprimer cet élément de configuration ?';

    # Template: AgentITSMConfigItemEdit
    $Self->{Translation}->{'The name of this config item'} = 'Le nom de cet élément de configuration';
    $Self->{Translation}->{'Name is already in use by the ConfigItems with the following Number(s): %s'} =
        'Le nom est déjà utilisé par l\'élément de configuration avec le numéro suivant : %s';

    # Template: AgentITSMConfigItemHistory
    $Self->{Translation}->{'History of Config Item: %s'} = 'Historique de l\'élément de configuration %s';
    $Self->{Translation}->{'History Content'} = 'Contenu de l\'historique';
    $Self->{Translation}->{'Createtime'} = 'Date de création';
    $Self->{Translation}->{'Zoom view'} = 'Vue détaillée';

    # Template: AgentITSMConfigItemOverviewNavBar
    $Self->{Translation}->{'Context Settings'} = 'Réglages de contexte';
    $Self->{Translation}->{'Config Items per page'} = 'Éléments de configuration par page';

    # Template: AgentITSMConfigItemOverviewSmall
    $Self->{Translation}->{'A generic ITSM Configuration Item table'} = '';

    # Template: AgentITSMConfigItemSearch
    $Self->{Translation}->{'Run Search'} = 'Lancer la recherche';
    $Self->{Translation}->{'Also search in previous versions?'} = 'Chercher également dans les versions précédentes ?';

    # Template: AgentITSMConfigItemZoom
    $Self->{Translation}->{'Configuration Item'} = 'Élément de configuration';
    $Self->{Translation}->{'Configuration Item Information'} = 'Informations de l\'élément de configuration';
    $Self->{Translation}->{'Current Deployment State'} = 'État actuel de déploiement';
    $Self->{Translation}->{'Last changed by'} = 'Dernières modifications effectuées par';
    $Self->{Translation}->{'Show one version'} = 'Afficher une seule version';
    $Self->{Translation}->{'Show all versions'} = 'Afficher toutes les versions';
    $Self->{Translation}->{'Version Incident State'} = 'État de la version de l\'incident';
    $Self->{Translation}->{'Version Deployment State'} = 'État de la version du déploiement';
    $Self->{Translation}->{'Version Number'} = 'Numéro de version';
    $Self->{Translation}->{'Configuration Item Version Details'} = 'Détails de la version de l\'élément de configuration';
    $Self->{Translation}->{'Property'} = 'Propriété';

    # Perl Module: Kernel/Modules/AgentITSMConfigItem.pm
    $Self->{Translation}->{'No access to Class is given!'} = 'Aucun accès à la classe n\'a été donné !';
    $Self->{Translation}->{'Overview: ITSM ConfigItem'} = 'Vue d\'ensemble: éléments de configuration';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemBulk.pm
    $Self->{Translation}->{'No ConfigItemID is given!'} = 'Aucun ID d\'élément de configuration n\'a été donné !';
    $Self->{Translation}->{'You need at least one selected Configuration Item!'} = 'Vous devez sélectionner au moins un élément de configuration !';
    $Self->{Translation}->{'You don\'t have write access to this configuration item: %s.'} =
        'Vous n\'avez pas le droit de modifier l\'élément de configuration %s.';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemDelete.pm
    $Self->{Translation}->{'Config item "%s" not found in database!'} = 'L\'élément de configuration "%s" n\'a pas été trouvé dans la base de données !';
    $Self->{Translation}->{'Was not able to delete the configitem ID %s!'} = 'Impossible de supprimer l\'ID de l\'élément de configuration %s !';
    $Self->{Translation}->{'No version found for ConfigItemID %s!'} = 'Aucune version trouvée pour l\'ID de l\'élément de configuration %s !';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemEdit.pm
    $Self->{Translation}->{'No ConfigItemID, DuplicateID or ClassID is given!'} = 'Aucun ID d\'élément de configuration, de duplication ou de classe n\'a été donné !';
    $Self->{Translation}->{'No access is given!'} = 'Aucun accès n\'a été donné !';
    $Self->{Translation}->{'No definition was defined for class %s!'} = 'Aucune définition définie pour la classe %s !';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemHistory.pm
    $Self->{Translation}->{'Can\'t show history, no ConfigItemID is given!'} = 'Impossible d\'afficher l\'historique, aucun ID d\'élément de configuration n\'a été donné !';
    $Self->{Translation}->{'Can\'t show history, no access rights given!'} = 'Impossible d\'afficher l\'historique, aucun accès n\'a été donné !';
    $Self->{Translation}->{'New ConfigItem (ID=%s)'} = 'Nouvel élément de configuration (ID=%s)';
    $Self->{Translation}->{'New version (ID=%s)'} = 'Nouvelle version (ID=%s)';
    $Self->{Translation}->{'Deployment state updated (new=%s, old=%s)'} = 'État de déploiement mis à jour (nouveau=%s, ancien=%s)';
    $Self->{Translation}->{'Incident state updated (new=%s, old=%s)'} = 'État de l\'incident mis à jour (nouveau=%s, ancien=%s)';
    $Self->{Translation}->{'ConfigItem (ID=%s) deleted'} = 'Élément de configuration (ID=%s) supprimé';
    $Self->{Translation}->{'Link to %s (type=%s) added'} = 'Lier à %s (type=%s) ajouté';
    $Self->{Translation}->{'Link to %s (type=%s) deleted'} = 'Lier à %s (type=%s) supprimé';
    $Self->{Translation}->{'ConfigItem definition updated (ID=%s)'} = 'Définition de l\'élément de configuration mise à jour (ID=%s)';
    $Self->{Translation}->{'Name updated (new=%s, old=%s)'} = 'Nom mis à jour (nouveau=%s, ancien=%s)';
    $Self->{Translation}->{'Attribute %s updated from "%s" to "%s"'} = 'Attribue %s mis à jour de "%s" à "%s"';
    $Self->{Translation}->{'Version %s deleted'} = 'Version %s supprimée';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemPrint.pm
    $Self->{Translation}->{'No ConfigItemID or VersionID is given!'} = 'Aucun ID d\'élément de configuration ou de version n\'a été donné !';
    $Self->{Translation}->{'Can\'t show config item, no access rights given!'} = 'Impossible d\'afficher l\'élément de configuration, aucun accès n\'a été donné !';
    $Self->{Translation}->{'ConfigItemID %s not found in database!'} = 'L\'ID de l\'élément de configuration %s n\'a pas été trouvé dans la base de données !';
    $Self->{Translation}->{'VersionID %s not found in database!'} = 'L\'ID de version %s n\'a pas été trouvé dans la base de données !';
    $Self->{Translation}->{'ConfigItem'} = 'Élément de configuration';
    $Self->{Translation}->{'printed by %s at %s'} = 'Imprimé par %s à %s';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemSearch.pm
    $Self->{Translation}->{'Invalid ClassID!'} = 'ID de classe invalide !';
    $Self->{Translation}->{'No ClassID is given!'} = 'Aucun ID de classe n\'a été donné !';
    $Self->{Translation}->{'No access rights for this class given!'} = 'Aucuns droits d\'accès pour cette classe n\'a été donné !';
    $Self->{Translation}->{'No Result!'} = 'Aucuns résultats !';
    $Self->{Translation}->{'Config Item Search Results'} = 'Résultat de la recherche des éléments de configuration';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemZoom.pm
    $Self->{Translation}->{'Can\'t show item, no access rights for ConfigItem are given!'} =
        'Impossible d\'afficher l\'élément, aucuns droits d\'accès pour cet élément de configuration n\'a été donné !';
    $Self->{Translation}->{'operational'} = '';
    $Self->{Translation}->{'warning'} = '';
    $Self->{Translation}->{'incident'} = '';
    $Self->{Translation}->{'The deployment state of this config item'} = 'L\'état de déploiement de cet élément de configuration';
    $Self->{Translation}->{'The incident state of this config item'} = 'L\'état d\'incident de cet élément de configuration';

    # Perl Module: Kernel/Output/HTML/Dashboard/ITSMConfigItemGeneric.pm
    $Self->{Translation}->{'Shown config items'} = 'Afficher les éléments de configuration';

    # Perl Module: Kernel/Output/HTML/ITSMConfigItem/LayoutDate.pm
    $Self->{Translation}->{'Between'} = 'Entre';

    # Perl Module: Kernel/System/ImportExport/ObjectBackend/ITSMConfigItem.pm
    $Self->{Translation}->{'Maximum number of one element'} = 'Quantité maximale pour un élément';
    $Self->{Translation}->{'Empty fields indicate that the current values are kept'} = 'Les champs vides indiquent que les valeurs par défauts sont gardées';
    $Self->{Translation}->{'Skipped'} = 'Passé(s)';

    # Perl Module: var/packagesetup/ITSMConfigurationManagement.pm
    $Self->{Translation}->{'Model'} = 'Modèle';
    $Self->{Translation}->{'Customer Company'} = '';
    $Self->{Translation}->{'Serial Number'} = 'Numéro de série';
    $Self->{Translation}->{'CPU'} = 'CPU';
    $Self->{Translation}->{'Ram'} = 'RAM';
    $Self->{Translation}->{'Hard Disk'} = 'Disque dur';
    $Self->{Translation}->{'Capacity'} = 'Capacité';
    $Self->{Translation}->{'Network Adapter'} = 'Adaptateur réseau';
    $Self->{Translation}->{'IP over DHCP'} = 'IP sur DHCP';
    $Self->{Translation}->{'IP Address'} = 'Adresse IP';
    $Self->{Translation}->{'Graphic Adapter'} = 'Adaptateur graphique';
    $Self->{Translation}->{'Other Equipment'} = 'Autre équipement';
    $Self->{Translation}->{'Warranty Expiration Date'} = 'Date d\'expiration de la garantie';
    $Self->{Translation}->{'Install Date'} = 'Date d\'installation';
    $Self->{Translation}->{'Phone 1'} = 'Téléphone 1';
    $Self->{Translation}->{'Phone 2'} = 'Téléphone 2';
    $Self->{Translation}->{'E-Mail'} = 'Adresse e-mail';
    $Self->{Translation}->{'Network Address'} = 'Adresse réseau';
    $Self->{Translation}->{'Subnet Mask'} = 'Masque du sous réseau';
    $Self->{Translation}->{'Gateway'} = 'Passerelle';
    $Self->{Translation}->{'Licence Type'} = 'Type de la licence';
    $Self->{Translation}->{'Licence Key'} = 'Clé de la licence';
    $Self->{Translation}->{'Quantity'} = 'Quantité';
    $Self->{Translation}->{'Expiration Date'} = 'Date d\'expiration';
    $Self->{Translation}->{'Media'} = 'Média';

    # Database XML Definition: ITSMConfigurationManagement.sopm
    $Self->{Translation}->{'Computer'} = 'Ordinateur';
    $Self->{Translation}->{'Hardware'} = 'Matériel';
    $Self->{Translation}->{'Network'} = 'Réseau';
    $Self->{Translation}->{'Software'} = 'Logiciel';
    $Self->{Translation}->{'Expired'} = 'Expiré';
    $Self->{Translation}->{'Maintenance'} = 'Maintenance';
    $Self->{Translation}->{'Pilot'} = 'Pilote';
    $Self->{Translation}->{'Planned'} = 'Planifié';
    $Self->{Translation}->{'Repair'} = 'En réparation';
    $Self->{Translation}->{'Retired'} = 'Retiré';
    $Self->{Translation}->{'Review'} = 'Revue';
    $Self->{Translation}->{'Test/QA'} = 'Test/QA';
    $Self->{Translation}->{'Laptop'} = 'Ordinateur portable';
    $Self->{Translation}->{'Desktop'} = 'Ordinateur';
    $Self->{Translation}->{'PDA'} = 'PDA';
    $Self->{Translation}->{'Server'} = 'Serveur';
    $Self->{Translation}->{'Other'} = 'Autre';
    $Self->{Translation}->{'Monitor'} = 'Moniteur';
    $Self->{Translation}->{'Printer'} = 'Imprimante';
    $Self->{Translation}->{'Switch'} = 'Commutateur';
    $Self->{Translation}->{'Router'} = 'Routeur';
    $Self->{Translation}->{'WLAN Access Point'} = 'Point d\'access WLAN';
    $Self->{Translation}->{'Security Device'} = 'Périphérique de sécurité';
    $Self->{Translation}->{'Backup Device'} = 'Élément de sauvegarde';
    $Self->{Translation}->{'Mouse'} = 'Souris';
    $Self->{Translation}->{'Keyboard'} = 'Clavier';
    $Self->{Translation}->{'Camera'} = 'Caméra';
    $Self->{Translation}->{'Beamer'} = 'Vidéoprojecteur';
    $Self->{Translation}->{'Modem'} = 'Modem';
    $Self->{Translation}->{'PCMCIA Card'} = 'Carte PCMCIA';
    $Self->{Translation}->{'USB Device'} = 'Périphérique USB';
    $Self->{Translation}->{'Docking Station'} = 'Station d\'accueil';
    $Self->{Translation}->{'Scanner'} = 'Scanner';
    $Self->{Translation}->{'Building'} = 'Bâtiment';
    $Self->{Translation}->{'Office'} = 'Bureau';
    $Self->{Translation}->{'Floor'} = 'Étage';
    $Self->{Translation}->{'Room'} = 'Pièce';
    $Self->{Translation}->{'Rack'} = 'Rack';
    $Self->{Translation}->{'Workplace'} = 'Emplacement';
    $Self->{Translation}->{'Outlet'} = 'Prise';
    $Self->{Translation}->{'IT Facility'} = 'Département "Technologies de l\'Information"';
    $Self->{Translation}->{'LAN'} = 'LAN';
    $Self->{Translation}->{'WLAN'} = 'WLAN';
    $Self->{Translation}->{'Telco'} = 'Telco';
    $Self->{Translation}->{'GSM'} = 'GSM';
    $Self->{Translation}->{'Client Application'} = 'Application cliente';
    $Self->{Translation}->{'Middleware'} = 'Intergiciel (middleware)';
    $Self->{Translation}->{'Server Application'} = 'Application serveur';
    $Self->{Translation}->{'Client OS'} = 'OS client';
    $Self->{Translation}->{'Server OS'} = 'OS serveur';
    $Self->{Translation}->{'Admin Tool'} = 'Outil d\'administration';
    $Self->{Translation}->{'User Tool'} = 'Outil utilisateur';
    $Self->{Translation}->{'Embedded'} = 'Embarqué';
    $Self->{Translation}->{'Single Licence'} = 'License unique';
    $Self->{Translation}->{'Per User'} = 'Par utilisateur';
    $Self->{Translation}->{'Per Processor'} = 'Par processeur';
    $Self->{Translation}->{'Per Server'} = 'Par serveur';
    $Self->{Translation}->{'Per Node'} = 'Par noeud';
    $Self->{Translation}->{'Volume Licence'} = 'License par volume';
    $Self->{Translation}->{'Enterprise Licence'} = 'License entreprise';
    $Self->{Translation}->{'Developer Licence'} = 'License développeur';
    $Self->{Translation}->{'Demo'} = 'Démo';
    $Self->{Translation}->{'Time Restricted'} = 'Limitée dans le temps';
    $Self->{Translation}->{'Freeware'} = 'Logiciel gratuit (freeware)';
    $Self->{Translation}->{'Open Source'} = 'Open-source';
    $Self->{Translation}->{'Unlimited'} = 'Illimité';

    # JS File: ITSM.Agent.ConfigItem.Zoom
    $Self->{Translation}->{'Ok'} = 'Ok';

    # SysConfig
    $Self->{Translation}->{'A precentage value of the minimal translation progress per language, to be usable for documentations.'} =
        '';
    $Self->{Translation}->{'Access repos via http or https.'} = '';
    $Self->{Translation}->{'Autoloading of Znuny4OTRSRepo extensions.'} = '';
    $Self->{Translation}->{'Backend module registration for the config conflict check module.'} =
        '';
    $Self->{Translation}->{'Backend module registration for the file conflict check module.'} =
        '';
    $Self->{Translation}->{'Backend module registration for the function redefine check module.'} =
        '';
    $Self->{Translation}->{'Backend module registration for the manual set module.'} = '';
    $Self->{Translation}->{'Block hooks to be created for BS ad removal.'} = '';
    $Self->{Translation}->{'Block hooks to be created for package manager output filter.'} =
        '';
    $Self->{Translation}->{'Branch View commit limit'} = '';
    $Self->{Translation}->{'CodePolicy'} = '';
    $Self->{Translation}->{'Commit limit per page for Branch view screen'} = '';
    $Self->{Translation}->{'Create analysis file'} = '';
    $Self->{Translation}->{'Creates a analysis file from this ticket and sends to Znuny.'} =
        '';
    $Self->{Translation}->{'Creates a analysis file from this ticket.'} = '';
    $Self->{Translation}->{'Define private addon repos.'} = '';
    $Self->{Translation}->{'Defines the filter that processes the HTML templates.'} = '';
    $Self->{Translation}->{'Defines the test module for checking code policy.'} = '';
    $Self->{Translation}->{'Definition of GIT clone/push URL Prefix.'} = '';
    $Self->{Translation}->{'Definition of a Dynamic Field: Group => Group with access to the Dynamic Fields; AlwaysVisible => Field can be removed (0|1); InformationAreaName => Name of the Widgets; InformationAreaSize => Size and position of the widgets (Large|Small); Name => Name of the Dynamic Field which should be used; Priority => Order of the Dynamic Fields; State => State of the Fields (0 = disabled, 1 = active, 2 = mandatory), FilterRelease => Regex which the repository name has to match to be displayed, FilterPackage => Regex which the package name has to match to be displayed, FilterBranch => Regex which the branch name has to match to be displayed, FilterRelease => Regex which the repelase version string has to match to be displayed.'} =
        '';
    $Self->{Translation}->{'Definition of a Dynamic Field: Group => Group with access to the Dynamic Fields; AlwaysVisible => Field can be removed (0|1); InformationAreaName => Name of the Widgets; InformationAreaSize => Size and position of the widgets (Large|Small); Name => Name of the Dynamic Field which should be used; Priority => Order of the Dynamic Fields; State => State of the Fields (0 = disabled, 1 = active, 2 = mandatory), FilterRepository => Regex which the repository name has to match to be displayed, FilterPackage => Regex which the package name has to match to be displayed, FilterBranch => Regex which the branch name has to match to be displayed, FilterRelease => Regex which the repelase version string has to match to be displayed.'} =
        '';
    $Self->{Translation}->{'Definition of external MD5 sums (key => MD5, Value => Vendor, PackageName, Version, Date).'} =
        '';
    $Self->{Translation}->{'Definition of mappings between public repository requests and internal OPMS repositories.'} =
        '';
    $Self->{Translation}->{'Definition of package states.'} = '';
    $Self->{Translation}->{'Definition of renamed OPMS packages.'} = '';
    $Self->{Translation}->{'Directory, which is used by Git to cache repositories.'} = '';
    $Self->{Translation}->{'Directory, which is used by Git to store temporary data.'} = '';
    $Self->{Translation}->{'Directory, which is used by Git to store working copies.'} = '';
    $Self->{Translation}->{'Disable online repositories.'} = '';
    $Self->{Translation}->{'Do not log git ssh connection authorization results for these users. Useful for automated stuff.'} =
        '';
    $Self->{Translation}->{'Dynamic Fields Screens'} = '';
    $Self->{Translation}->{'DynamicFieldScreen'} = '';
    $Self->{Translation}->{'Export all available public keys to authorized_keys file.'} = '';
    $Self->{Translation}->{'Export all relevant releases to ftp server.'} = '';
    $Self->{Translation}->{'Frontend module registration for the OPMS object in the agent interface.'} =
        '';
    $Self->{Translation}->{'Frontend module registration for the PublicOPMSRepository object in the public interface.'} =
        '';
    $Self->{Translation}->{'Frontend module registration for the PublicOPMSRepositoryLookup object in the public interface.'} =
        '';
    $Self->{Translation}->{'Frontend module registration for the PublicOPMSTestBuild object in the public interface.'} =
        '';
    $Self->{Translation}->{'Frontend module registration for the PublicPackageVerification object in the public interface.'} =
        '';
    $Self->{Translation}->{'Frontend module registration for the admin interface.'} = '';
    $Self->{Translation}->{'GIT Author registration.'} = '';
    $Self->{Translation}->{'Generate HTML comment hooks for the specified blocks so that filters can use them.'} =
        '';
    $Self->{Translation}->{'Generate documentations once per night.'} = '';
    $Self->{Translation}->{'Git'} = '';
    $Self->{Translation}->{'Git Management'} = '';
    $Self->{Translation}->{'Git Repository'} = '';
    $Self->{Translation}->{'Group, whose members have delete admin permissions in OPMS.'} = '';
    $Self->{Translation}->{'Group, whose members have repository admin permissions in OPMS.'} =
        '';
    $Self->{Translation}->{'Group, whose members will see CI test result information in OPMS screens.'} =
        '';
    $Self->{Translation}->{'Groups an authenticated user (by user login and password) must be member of to build test packages via the public interface.'} =
        '';
    $Self->{Translation}->{'Groups which will be set during git project creation processes while adding OPMS repositories.'} =
        '';
    $Self->{Translation}->{'Manage dynamic field in screens.'} = '';
    $Self->{Translation}->{'Manage your public SSH key(s) for Git access here. Make sure to save this preference when you add a new key.'} =
        '';
    $Self->{Translation}->{'Module to generate statistics about the added code lines.'} = '';
    $Self->{Translation}->{'Module to generate statistics about the growth of code.'} = '';
    $Self->{Translation}->{'Module to generate statistics about the number of git commits.'} =
        '';
    $Self->{Translation}->{'Module to generate statistics about the removed code lines.'} = '';
    $Self->{Translation}->{'OPMS'} = '';
    $Self->{Translation}->{'Only users who have rw permissions in one of these groups may access git.'} =
        '';
    $Self->{Translation}->{'Option to set a package compatibility manually.'} = '';
    $Self->{Translation}->{'Parameters for the pages in the BranchView screen.'} = '';
    $Self->{Translation}->{'Pre-Definition of the \'GITProjectName\' Dynamic Field: Group => Group with access to the Dynamic Fields; AlwaysVisible => Field can be removed (0|1); InformationAreaName => Name of the Widgets; InformationAreaSize => Size and position of the widgets (Large|Small); Name => Name of the Dynamic Field which should be used; Priority => Order of the Dynamic Fields; State => State of the Fields (0 = disabled, 1 = active, 2 = mandatory), FilterRepository => Regex which the repository name has to match to be displayed, FilterPackage => Regex which the package name has to match to be displayed, FilterBranch => Regex which the branch name has to match to be displayed, FilterRelease => Regex which the repelase version string has to match to be displayed.'} =
        '';
    $Self->{Translation}->{'Pre-Definition of the \'GITRepositoryName\' Dynamic Field: Group => Group with access to the Dynamic Fields; AlwaysVisible => Field can be removed (0|1); InformationAreaName => Name of the Widgets; InformationAreaSize => Size and position of the widgets (Large|Small); Name => Name of the Dynamic Field which should be used; Priority => Order of the Dynamic Fields; State => State of the Fields (0 = disabled, 1 = active, 2 = mandatory), FilterRepository => Regex which the repository name has to match to be displayed, FilterPackage => Regex which the package name has to match to be displayed, FilterBranch => Regex which the branch name has to match to be displayed, FilterRelease => Regex which the repelase version string has to match to be displayed.'} =
        '';
    $Self->{Translation}->{'Pre-Definition of the \'PackageDeprecated\' Dynamic Field: Group => Group with access to the Dynamic Fields; AlwaysVisible => Field can be removed (0|1); InformationAreaName => Name of the Widgets; InformationAreaSize => Size and position of the widgets (Large|Small); Name => Name of the Dynamic Field which should be used; Priority => Order of the Dynamic Fields; State => State of the Fields (0 = disabled, 1 = active, 2 = mandatory), FilterRepository => Regex which the repository name has to match to be displayed, FilterPackage => Regex which the package name has to match to be displayed, FilterBranch => Regex which the branch name has to match to be displayed, FilterRelease => Regex which the repelase version string has to match to be displayed.'} =
        '';
    $Self->{Translation}->{'Recipients that will be informed by email in case of errors.'} =
        '';
    $Self->{Translation}->{'SSH Keys for Git Access'} = '';
    $Self->{Translation}->{'Send analysis file'} = '';
    $Self->{Translation}->{'Sets the git clone address to be used in repository listings.'} =
        '';
    $Self->{Translation}->{'Sets the home directory for git repositories.'} = '';
    $Self->{Translation}->{'Sets the path for the BugzillaAddComment post receive script location.'} =
        '';
    $Self->{Translation}->{'Sets the path for the OTRSCodePolicy  script location. It is recommended to have a separate clone of the OTRSCodePolicy module that is updated via cron.'} =
        '';
    $Self->{Translation}->{'Sets the path for the OTRSCodePolicy pre receive script location. It is recommended to have a separate clone of the OTRSCodePolicy module that is updated via cron.'} =
        '';
    $Self->{Translation}->{'Show latest commits in git repositories.'} = '';
    $Self->{Translation}->{'Shows a link in the menu to go create a unit test from the current ticket.'} =
        '';
    $Self->{Translation}->{'Synchronize OPMS tables with a remote database.'} = '';
    $Self->{Translation}->{'The minimum version of the sphinx library.'} = '';
    $Self->{Translation}->{'The name of the sphinx theme to be used.'} = '';
    $Self->{Translation}->{'The path to the OTRS CSS file (relative below the static path).'} =
        '';
    $Self->{Translation}->{'The path to the OTRS logo (relative below the static path).'} = '';
    $Self->{Translation}->{'The path to the static folder, containing images and css files.'} =
        '';
    $Self->{Translation}->{'The path to the theme folder, containing the sphinx themes.'} = '';
    $Self->{Translation}->{'This configuration defines all possible screens to enable or disable default columns.'} =
        '';
    $Self->{Translation}->{'This configuration defines all possible screens to enable or disable dynamic fields.'} =
        '';
    $Self->{Translation}->{'This configuration defines if only valids or all (invalids) dynamic fields should be shown.'} =
        '';
    $Self->{Translation}->{'This configuration defines if the OTRS package verification should be active or disabled. If disabled all packages are shown as verified. It\'s still recommended to use only verified packages.'} =
        '';
    $Self->{Translation}->{'This configuration defines the URL to the OTRS CloudService Proxy service. The http or https prefix will be added, depending on selection SysConfig \'Znuny4OTRSRepoType\'.'} =
        '';
    $Self->{Translation}->{'This configuration registers a Output post-filter to extend package verification.'} =
        '';
    $Self->{Translation}->{'This configuration registers an OutputFilter module that removes OTRS Business Solution TM advertisements.'} =
        '';
    $Self->{Translation}->{'This configuration registers an output filter to hide online repository selection in package manager.'} =
        '';
    $Self->{Translation}->{'Tidy unprocessed release that not passed test pomules checks for a long time.'} =
        '';
    $Self->{Translation}->{'Users who have rw permissions in one of these groups are permitted to execute force pushes \'git push --force\'.'} =
        '';
    $Self->{Translation}->{'Users who have rw permissions in one of these groups are permitted to manage projects. Additionally the members have administration permissions to the git management.'} =
        '';


    push @{ $Self->{JavaScriptStrings} // [] }, (
    'No',
    'Ok',
    'Please enter at least one search value or * to find anything.',
    'Settings',
    'Submit',
    'Yes',
    );

}

1;

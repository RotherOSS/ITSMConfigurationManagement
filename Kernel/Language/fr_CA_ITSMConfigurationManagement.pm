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

package Kernel::Language::fr_CA_ITSMConfigurationManagement;

use strict;
use warnings;
use utf8;

sub Data {
    my $Self = shift;

    # Template: AdminITSMConfigItem
    $Self->{Translation}->{'Config Item Management'} = 'Gestion des éléments de configuration';
    $Self->{Translation}->{'Change class definition'} = 'Modifier la définition de la classe';
    $Self->{Translation}->{'Change role definition'} = 'Modifier la définition des rôles';
    $Self->{Translation}->{'Ready2Import Class Bundles'} = 'Les ensembles de classes Ready2Import';
    $Self->{Translation}->{'Here you can import Ready2Import class bundles showcasing our most usual config items. Please note that some additional configuration may be required.'} =
        'Ici, vous pouvez importer des classes Ready2Import qui présentent nos éléments de configuration les plus courants. Veuillez noter que certaines configurations supplémentaires peuvent être nécessaires.';
    $Self->{Translation}->{'Update existing entities'} = 'Mise à jour des entités existantes';
    $Self->{Translation}->{'Import Ready2Adopt class bundles'} = 'Importer les paquets de classes de Ready2Adopt';
    $Self->{Translation}->{'Config Item Class'} = 'Classe d\'élément de configuration';
    $Self->{Translation}->{'Config Item Role'} = 'Rôle de l\'élément de configuration';

    # Template: AgentITSMConfigItemAdd
    $Self->{Translation}->{'Config Item'} = 'Config Item';
    $Self->{Translation}->{'Filter for Classes'} = 'Filtre pour les classes';
    $Self->{Translation}->{'Select a Class from the list to create a new Config Item.'} = 'Sélectionnez une classe dans la liste pour créer un nouvel élément de configuration.';
    $Self->{Translation}->{'Class'} = 'Classe';

    # Template: AgentITSMConfigItemBulk
    $Self->{Translation}->{'ITSM ConfigItem Bulk Action'} = 'ITSM ConfigItem Bulk Action';
    $Self->{Translation}->{'Deployment state'} = 'État du déploiement';
    $Self->{Translation}->{'Incident state'} = 'État de l\'incident';
    $Self->{Translation}->{'Link to another'} = 'Lien vers un autre';
    $Self->{Translation}->{'Invalid Configuration Item number!'} = 'Numéro d\'élément de configuration non valide !';
    $Self->{Translation}->{'The number of another Configuration Item to link with.'} = 'Le numéro d\'un autre élément de configuration avec lequel établir un lien.';

    # Template: AgentITSMConfigItemDelete
    $Self->{Translation}->{'Do you really want to delete this config item?'} = 'Voulez-vous vraiment supprimer cet élément de configuration ?';

    # Template: AgentITSMConfigItemEdit
    $Self->{Translation}->{'The name of this config item'} = 'Le nom de cet élément de configuration';
    $Self->{Translation}->{'Name is already in use by the ConfigItems with the following Number(s): %s'} =
        'Le nom est déjà utilisé par les ConfigItems avec le(s) numéro(s) suivant(s) : %s';
    $Self->{Translation}->{'Version Number'} = 'Numéro de version';
    $Self->{Translation}->{'Version number of this config item'} = 'Numéro de version de cet élément de configuration';
    $Self->{Translation}->{'Version Number is already in use by the ConfigItems with the following Number(s): %s'} =
        'Le numéro de version est déjà utilisé par les ConfigItems avec le(s) numéro(s) suivant(s) : %s';
    $Self->{Translation}->{'Deployment State'} = 'État de déploiement';
    $Self->{Translation}->{'Incident State'} = 'État de l\'incident';

    # Template: AgentITSMConfigItemHistory
    $Self->{Translation}->{'History of Config Item: %s'} = 'Historique de l\'élément de configuration : %s';
    $Self->{Translation}->{'History Content'} = 'Contenu historique';
    $Self->{Translation}->{'Createtime'} = 'Créer un temps';
    $Self->{Translation}->{'Zoom view'} = 'Vue de la synthèse';

    # Template: AgentITSMConfigItemOverviewNavBar
    $Self->{Translation}->{'Config Items per page'} = 'Config Éléments par page';

    # Template: AgentITSMConfigItemOverviewSmall
    $Self->{Translation}->{'No config item data found.'} = 'Aucune donnée de l\'élément de configuration n\'a été trouvée.';
    $Self->{Translation}->{'Select this config item'} = 'Sélectionner cet élément de configuration';

    # Template: AgentITSMConfigItemSearch
    $Self->{Translation}->{'Run Search'} = 'Recherche d\'exécution';
    $Self->{Translation}->{'Also search in previous versions?'} = 'Recherche également dans les versions précédentes ?';

    # Template: AgentITSMConfigItemTreeView
    $Self->{Translation}->{'TreeView for ConfigItem'} = 'TreeView pour ConfigItem';
    $Self->{Translation}->{'Depth Level'} = 'Niveau de profondeur';
    $Self->{Translation}->{'Zoom In/Out'} = 'Zoom avant/arrière';
    $Self->{Translation}->{'Max links level reached for ConfigItem!'} = 'Niveau de liens maximum atteint pour ConfigItem !';

    # Template: AgentITSMConfigItemZoom
    $Self->{Translation}->{'Configuration Item'} = 'Élément de configuration';
    $Self->{Translation}->{'Configuration Item Information'} = 'Informations sur les éléments de configuration';
    $Self->{Translation}->{'Current Deployment State'} = 'État actuel du déploiement';
    $Self->{Translation}->{'Current Incident State'} = 'État actuel de l\'incident';
    $Self->{Translation}->{'Last changed'} = 'Dernière modification';
    $Self->{Translation}->{'Last changed by'} = 'Dernière modification par';

    # Template: CustomerITSMConfigItem
    $Self->{Translation}->{'Your ConfigItems'} = 'Vos éléments de configuration';

    # Template: CustomerITSMConfigItemSearch
    $Self->{Translation}->{'ConfigItem Search'} = 'Recherche d\'éléments de configuration';

    # Template: AdminACL
    $Self->{Translation}->{'Object Type'} = 'Type d\'objet';

    # JS Template: ClassImportConfirm
    $Self->{Translation}->{'The following classes will be imported'} = 'Les classes suivantes seront importées';
    $Self->{Translation}->{'The following roles will be imported'} = 'Les rôles suivants seront importés';
    $Self->{Translation}->{'Note that also corresponding dynamic fields and GeneralCatalog classes will be created and there is no automatic removal.'} =
        'Notez que les champs dynamiques et les classes GeneralCatalog correspondants seront également créés et qu\'il n\'y a pas de suppression automatique.';
    $Self->{Translation}->{'Do you want to proceed?'} = 'Voulez-vous continuer ?';

    # Perl Module: Kernel/Modules/AdminITSMConfigItem.pm
    $Self->{Translation}->{'Need ExampleClasses!'} = 'Besoin de classes d\'exemples !';
    $Self->{Translation}->{'Definition is no valid YAML hash.'} = 'La définition n\'est pas un hachage YAML valide.';

    # Perl Module: Kernel/Modules/AgentITSMConfigItem.pm
    $Self->{Translation}->{'Overview: ITSM ConfigItem'} = 'Vue d\'ensemble : ITSM ConfigItem';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemBulk.pm
    $Self->{Translation}->{'No ConfigItemID is given!'} = 'Aucun ConfigItemID n\'est donné !';
    $Self->{Translation}->{'You need at least one selected Configuration Item!'} = 'Vous avez besoin d\'au moins un élément de configuration sélectionné !';
    $Self->{Translation}->{'You don\'t have write access to this configuration item: %s.'} =
        'Vous n\'avez pas d\'accès en écriture à cet élément de configuration : %s.';
    $Self->{Translation}->{'No definition was defined for class %s!'} = 'Aucune définition n\'a été définie pour la classe %s !';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemDelete.pm
    $Self->{Translation}->{'Config item "%s" not found in database!'} = 'L\'élément de configuration "%s" n\'a pas été trouvé dans la base de données !';
    $Self->{Translation}->{'Was not able to delete the configitem ID %s!'} = 'Il n\'a pas été possible de supprimer le configitem ID %s !';
    $Self->{Translation}->{'No version found for ConfigItemID %s!'} = 'Aucune version trouvée pour ConfigItemID %s !';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemEdit.pm
    $Self->{Translation}->{'No ConfigItemID, DuplicateID or ClassID is given!'} = 'Aucun ConfigItemID, DuplicateID ou ClassID n\'est donné !';
    $Self->{Translation}->{'No access is given!'} = 'Aucun accès n\'est donné !';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemHistory.pm
    $Self->{Translation}->{'Can\'t show history, no ConfigItemID is given!'} = 'Impossible d\'afficher l\'historique, aucun ConfigItemID n\'est donné !';
    $Self->{Translation}->{'Can\'t show history, no access rights given!'} = 'Impossible d\'afficher l\'historique, aucun droit d\'accès n\'a été accordé !';
    $Self->{Translation}->{'New ConfigItem (ID=%s)'} = 'Nouveau ConfigItem (ID=%s)';
    $Self->{Translation}->{'New version (ID=%s)'} = 'Nouvelle version (ID=%s)';
    $Self->{Translation}->{'Deployment state updated (new=%s, old=%s)'} = 'Mise à jour de l\'état du déploiement (new=%s, old=%s)';
    $Self->{Translation}->{'Incident state updated (new=%s, old=%s)'} = 'Mise à jour de l\'état de l\'incident (new=%s, old=%s)';
    $Self->{Translation}->{'ConfigItem (ID=%s) deleted'} = 'ConfigItem (ID=%s) supprimé';
    $Self->{Translation}->{'Link to %s (type=%s) added'} = 'Ajout d\'un lien vers %s (type=%s)';
    $Self->{Translation}->{'Link to %s (type=%s) deleted'} = 'Lien vers %s (type=%s) supprimé';
    $Self->{Translation}->{'ConfigItem definition updated (ID=%s)'} = 'Mise à jour de la définition de ConfigItem (ID=%s)';
    $Self->{Translation}->{'Name updated (new=%s, old=%s)'} = 'Nom mis à jour (new=%s, old=%s)';
    $Self->{Translation}->{'Attribute %s updated from "%s" to "%s"'} = 'Attribut %s mis à jour de "%s" à "%s"';
    $Self->{Translation}->{'Version %s deleted'} = 'Version %s supprimée';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemPrint.pm
    $Self->{Translation}->{'No ConfigItemID or VersionID is given!'} = 'Aucun ConfigItemID ou VersionID n\'est donné !';
    $Self->{Translation}->{'Can\'t show config item, no access rights given!'} = 'Impossible d\'afficher l\'élément de configuration, aucun droit d\'accès n\'a été accordé !';
    $Self->{Translation}->{'ConfigItemID %s not found in database!'} = 'ConfigItemID %s introuvable dans la base de données !';
    $Self->{Translation}->{'ConfigItem'} = 'Élément de configuration';
    $Self->{Translation}->{'printed by %s at %s'} = 'imprimé par %s à %s';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemSearch.pm
    $Self->{Translation}->{'Invalid ClassID!'} = 'ClassID invalide !';
    $Self->{Translation}->{'No ClassID is given!'} = 'Aucun identifiant de classe n\'est donné !';
    $Self->{Translation}->{'No access rights for this class given!'} = 'Aucun droit d\'accès à cette classe n\'a été accordé !';
    $Self->{Translation}->{'No Result!'} = 'Pas de résultat !';
    $Self->{Translation}->{'Config Item Search Results'} = 'Résultats de la recherche d\'éléments de configuration';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemZoom.pm
    $Self->{Translation}->{'Can\'t show item, no access rights for ConfigItem are given!'} =
        'Impossible d\'afficher l\'élément, aucun droit d\'accès n\'est accordé pour ConfigItem !';
    $Self->{Translation}->{'ConfigItem not found!'} = 'ConfigItem introuvable !';
    $Self->{Translation}->{'No versions found!'} = 'Aucune version trouvée !';
    $Self->{Translation}->{'operational'} = 'opérationnel';
    $Self->{Translation}->{'warning'} = 'avertissement';
    $Self->{Translation}->{'incident'} = 'incident';
    $Self->{Translation}->{'The deployment state of this config item'} = 'L\'état de déploiement de cet élément de configuration';
    $Self->{Translation}->{'The incident state of this config item'} = 'L\'état de l\'incident de cet élément de configuration';

    # Perl Module: Kernel/Modules/CustomerITSMConfigItemSearch.pm
    $Self->{Translation}->{'No permission'} = 'Pas d\'autorisation';
    $Self->{Translation}->{'Filter invalid!'} = 'Filtre non valide !';
    $Self->{Translation}->{'Search params invalid!'} = 'Paramètres de recherche non valides !';

    # Perl Module: Kernel/Output/HTML/Dashboard/ITSMConfigItemGeneric.pm
    $Self->{Translation}->{'Shown config items'} = 'Éléments de configuration affichés';
    $Self->{Translation}->{'Deployment State Type'} = 'Type d\'état de déploiement';
    $Self->{Translation}->{'Current Incident State Type'} = 'Type d\'incident actuel';

    # Perl Module: Kernel/Output/HTML/ITSMConfigItem/LayoutDate.pm
    $Self->{Translation}->{'Between'} = 'entre le';

    # Perl Module: Kernel/System/DynamicField/Driver/ConfigItem.pm
    $Self->{Translation}->{'Class restrictions for the config item'} = 'Restrictions de classe pour l\'élément de configuration';
    $Self->{Translation}->{'Select one or more classes to restrict selectable config items'} =
        'Sélectionner une ou plusieurs classes pour restreindre les éléments de configuration sélectionnables';
    $Self->{Translation}->{'Link type'} = 'Type de lien';
    $Self->{Translation}->{'Select the link type.'} = 'Sélectionnez le type de lien.';
    $Self->{Translation}->{'Forwards: Referencing (Source) -> Referenced (Target)'} = 'En avant : Référencement (Source) -> Référencement (Cible)';
    $Self->{Translation}->{'Backwards: Referenced (Source) -> Referencing (Target)'} = 'A l\'envers : Référencé (Source) -> Référencé (Cible)';
    $Self->{Translation}->{'Link Direction'} = 'Direction du lien';
    $Self->{Translation}->{'The referencing object is the one containing this dynamic field, the referenced object is the one selected as value of the dynamic field.'} =
        'L\'objet référent est celui qui contient ce champ dynamique, l\'objet référencé est celui qui est sélectionné comme valeur du champ dynamique.';
    $Self->{Translation}->{'Dynamic (ConfigItem)'} = 'Dynamique (ConfigItem)';
    $Self->{Translation}->{'Static (Version)'} = 'Static (Version)';
    $Self->{Translation}->{'Link Referencing Type'} = 'Type de référencement des liens';
    $Self->{Translation}->{'Whether this link applies to the ConfigItem or the static version of the referencing object. Current Incident State calculation only is performed on dynamic links.'} =
        'Si ce lien s\'applique à l\'élément de configuration ou à la version statique de l\'objet de référence. Le calcul de l\'état actuel de l\'incident n\'est effectué que pour les liens dynamiques.';
    $Self->{Translation}->{'Select the attribute which config items will be searched by'} = 'Sélectionnez l\'attribut par lequel les éléments de configuration seront recherchés.';

    # Perl Module: Kernel/System/ITSMConfigItem/Definition.pm
    $Self->{Translation}->{'Base structure is not valid. Please provide a hash with data in YAML format.'} =
        'La structure de base n\'est pas valide. Veuillez fournir un hachage avec des données au format YAML.';
    $Self->{Translation}->{'Starting the YAML string with \'---\' is required.'} = 'Il est nécessaire de commencer la chaîne YAML par "---".';

    # Perl Module: Kernel/System/ITSMConfigItem/Link.pm
    $Self->{Translation}->{'Could not purge the table configitem_link.'} = 'Impossible de purger la table configitem_link.';
    $Self->{Translation}->{'No relevant dynamic fields were found'} = 'Aucun champ dynamique pertinent n\'a été trouvé';
    $Self->{Translation}->{'Could not insert into the table configitem_link'} = 'Impossible d\'insérer dans la table configitem_link';
    $Self->{Translation}->{'Inserted 0 rows into the table configitem_link'} = 'Inséré 0 lignes dans la table configitem_link';

    # Perl Module: Kernel/System/ImportExport/ObjectBackend/ITSMConfigItem.pm
    $Self->{Translation}->{'Maximum number of one element'} = 'Nombre maximal d\'un élément';
    $Self->{Translation}->{'Empty fields indicate that the current values are kept'} = 'Les champs vides indiquent que les valeurs actuelles sont conservées';
    $Self->{Translation}->{'Skipped'} = 'Sautée';

    # Perl Module: Kernel/Modules/AdminDynamicField.pm
    $Self->{Translation}->{'Error synchronizing the definitions. Please check the log.'} = 'Erreur de synchronisation des définitions. Veuillez vérifier le journal.';
    $Self->{Translation}->{'You have ITSMConfigItem definitions which are not synchronized. Please deploy your ITSMConfigItem dynamic field changes.'} =
        'Vous avez des définitions ITSMConfigItem qui ne sont pas synchronisées. Veuillez déployer vos changements de champs dynamiques ITSMConfigItem.';

    # Database XML / SOPM Definition: ITSMConfigurationManagement.sopm
    $Self->{Translation}->{'Expired'} = 'Expiré';
    $Self->{Translation}->{'Maintenance'} = 'Maintenance';
    $Self->{Translation}->{'Pilot'} = 'Pilote';
    $Self->{Translation}->{'Planned'} = 'Prévu';
    $Self->{Translation}->{'Repair'} = 'Réparation';
    $Self->{Translation}->{'Retired'} = 'Retraité';
    $Self->{Translation}->{'Review'} = 'Révision';
    $Self->{Translation}->{'Test/QA'} = 'Test/QA';

    # JS File: ITSM.Admin.ITSMConfigItem
    $Self->{Translation}->{'Overview and Confirmation'} = 'Vue d\'ensemble et confirmation';
    $Self->{Translation}->{'Importing classes/roles and their related fields'} = 'Importation de classes/rôles et de leurs champs connexes';
    $Self->{Translation}->{'An error occurred during class import.'} = 'Une erreur s\'est produite lors de l\'importation de la classe.';

    # SysConfig
    $Self->{Translation}->{'0 - Hidden'} = '0 - Caché';
    $Self->{Translation}->{'1 - Shown'} = '1 - Montré';
    $Self->{Translation}->{'Allows extended search conditions in config item search of the agent interface. With this feature you can search e. g. config item name with this kind of conditions like "(*key1*&&*key2*)" or "(*key1*||*key2*)".'} =
        'Permet d\'étendre les conditions de recherche dans les éléments de configuration de l\'interface de l\'agent. Grâce à cette fonctionnalité, vous pouvez rechercher, par exemple, le nom d\'un élément de configuration avec des conditions telles que "(*key1*&&*key2*)" ou "(*key1*||*key2*)".';
    $Self->{Translation}->{'Allows extended search conditions in config item search of the customer interface. With this feature you can search e. g. config item name with this kind of conditions like "(*key1*&&*key2*)" or "(*key1*||*key2*)".'} =
        'Permet d\'étendre les conditions de recherche dans les éléments de configuration de l\'interface client. Avec cette fonctionnalité, vous pouvez rechercher par exemple le nom d\'un élément de configuration avec des conditions telles que "(*key1*&&*key2*)" ou "(*key1*||*key2*)".';
    $Self->{Translation}->{'Assigned CIs'} = 'IC assignés';
    $Self->{Translation}->{'CIs assigned to customer company'} = 'CI affectés à l\'entreprise cliente';
    $Self->{Translation}->{'CIs assigned to customer user'} = 'CI attribués à l\'utilisateur client';
    $Self->{Translation}->{'CMDB Settings'} = 'Paramètres CMDB';
    $Self->{Translation}->{'Check for a unique name only within the same ConfigItem class (\'class\') or globally (\'global\'), which means every existing ConfigItem is taken into account when looking for duplicates.'} =
        'Vérifier la présence d\'un nom unique uniquement dans la même classe de ConfigItem ("class") ou globalement ("global"), ce qui signifie que chaque ConfigItem existant est pris en compte lors de la recherche de doublons.';
    $Self->{Translation}->{'Choose a module to enforce a naming scheme.'} = 'Choisissez un module pour appliquer un schéma de dénomination.';
    $Self->{Translation}->{'Choose a module to enforce a number scheme.'} = 'Choisissez un module pour appliquer un système de numérotation.';
    $Self->{Translation}->{'Choose a module to enforce a version string scheme.'} = 'Choisissez un module pour appliquer un schéma de chaîne de version.';
    $Self->{Translation}->{'Choose attributes to trigger the creation of a new version.'} = 'Sélectionnez les attributs qui déclenchent la création d\'une nouvelle version.';
    $Self->{Translation}->{'Choose categories to assign to this config item class.'} = 'Sélectionnez les catégories à affecter à cette classe d\'éléments de configuration.';
    $Self->{Translation}->{'Column config item filters for ConfigItem Overview.'} = 'Filtres d\'éléments de configuration en colonne pour l\'aperçu des éléments de configuration.';
    $Self->{Translation}->{'Columns that can be filtered in the config item overview of the agent interface. Note: Only Config Item attributes and Dynamic Fields (DynamicField_NameX) are allowed.'} =
        'Colonnes pouvant être filtrées dans la vue d\'ensemble des éléments de configuration de l\'interface agent. Remarque : seuls les attributs des éléments de configuration et les champs dynamiques (DynamicField_NameX) sont autorisés.';
    $Self->{Translation}->{'Columns that can be filtered in the config item overview of the customer interface. Note: Only Config Item attributes and Dynamic Fields (DynamicField_NameX) are allowed.'} =
        'Colonnes pouvant être filtrées dans l\'aperçu des éléments de configuration de l\'interface client. Remarque : seuls les attributs des éléments de configuration et les champs dynamiques (DynamicField_NameX) sont autorisés.';
    $Self->{Translation}->{'Columns that can be filtered in the config item search result overview of the agent interface. Note: Only Config Item attributes and Dynamic Fields (DynamicField_NameX) are allowed.'} =
        'Colonnes pouvant être filtrées dans l\'aperçu des résultats de la recherche d\'éléments de configuration dans l\'interface de l\'agent. Remarque : seuls les attributs des éléments de configuration et les champs dynamiques (DynamicField_NameX) sont autorisés.';
    $Self->{Translation}->{'Config Items'} = 'Éléments de configuration';
    $Self->{Translation}->{'Config item add.'} = 'Ajout d\'un élément de configuration.';
    $Self->{Translation}->{'Config item edit.'} = 'Édition d\'un élément de configuration.';
    $Self->{Translation}->{'Config item event module that enables logging to history in the agent interface.'} =
        'Module d\'événement de l\'élément de configuration qui permet l\'enregistrement dans l\'historique dans l\'interface de l\'agent.';
    $Self->{Translation}->{'Config item event module that updates config items to their current definition.'} =
        'Module d\'événement pour les éléments de configuration qui met à jour les éléments de configuration en fonction de leur définition actuelle.';
    $Self->{Translation}->{'Config item event module that updates the table configitem_ĺink.'} =
        'Module d\'événement de l\'élément de configuration qui met à jour la table configitem_ĺink.';
    $Self->{Translation}->{'Config item event module updates the current incident state.'} =
        'Le module d\'événement de l\'élément de configuration met à jour l\'état actuel de l\'incident.';
    $Self->{Translation}->{'Config item history.'} = 'Historique des éléments de configuration.';
    $Self->{Translation}->{'Config item print.'} = 'Impression des éléments de configuration.';
    $Self->{Translation}->{'Config item zoom.'} = 'Config item zoom.';
    $Self->{Translation}->{'ConfigItem Tree View'} = 'Arborescence des éléments de configuration';
    $Self->{Translation}->{'ConfigItem Version'} = 'ConfigItem Version';
    $Self->{Translation}->{'ConfigItems of the following classes will not be stored on the Elasticsearch server. To apply this to existing CIs, the CI migration has to be run via console, after changing this option.'} =
        'Les ConfigItems des classes suivantes ne seront pas stockés sur le serveur Elasticsearch. Pour appliquer cela aux CI existants, la migration des CI doit être exécutée via la console, après avoir changé cette option.';
    $Self->{Translation}->{'ConfigItems with the following deployment states will not be stored on the Elasticsearch server. To apply this to existing CIs, the CI migration has to be run via console, after changing this option.'} =
        'Les ConfigItems avec les états de déploiement suivants ne seront pas stockés sur le serveur Elasticsearch. Pour appliquer cela aux CI existants, la migration des CI doit être exécutée via la console, après avoir changé cette option.';
    $Self->{Translation}->{'Configuration Item Limit'} = 'Limite de l\'élément de configuration';
    $Self->{Translation}->{'Configuration Item limit per page.'} = 'Configuration Limite d\'éléments par page.';
    $Self->{Translation}->{'Configuration Management Database.'} = 'Base de données de gestion de la configuration.';
    $Self->{Translation}->{'Configuration item bulk module.'} = 'Élément de configuration module en vrac.';
    $Self->{Translation}->{'Configuration item search backend router of the agent interface.'} =
        'Élément de configuration recherche routeur backend de l\'interface de l\'agent.';
    $Self->{Translation}->{'Create and manage the definitions for Configuration Items.'} = 'Créer et gérer les définitions des éléments de configuration.';
    $Self->{Translation}->{'Customers can see historic CI versions.'} = 'Les clients peuvent consulter l\'historique des versions de l\'IC.';
    $Self->{Translation}->{'Customers have the possibility to manually switch between historic CI versions.'} =
        'Les clients ont la possibilité de passer manuellement d\'une version historique de CI à l\'autre.';
    $Self->{Translation}->{'Default data to use on attribute for config item search screen. Example: "ITSMConfigItemCreateTimePointFormat=year;ITSMConfigItemCreateTimePointStart=Last;ITSMConfigItemCreateTimePoint=2;".'} =
        'Données par défaut à utiliser sur l\'attribut de l\'écran de recherche des éléments de configuration. Exemple : "ITSMConfigItemCreateTimePointFormat=year;ITSMConfigItemCreateTimePointStart=Last;ITSMConfigItemCreateTimePoint=2 ;".';
    $Self->{Translation}->{'Default data to use on attribute for config item search screen. Example: "ITSMConfigItemCreateTimeStartYear=2010;ITSMConfigItemCreateTimeStartMonth=10;ITSMConfigItemCreateTimeStartDay=4;ITSMConfigItemCreateTimeStopYear=2010;ITSMConfigItemCreateTimeStopMonth=11;ITSMConfigItemCreateTimeStopDay=3;".'} =
        'Données par défaut à utiliser sur l\'attribut de l\'écran de recherche des éléments de configuration. Exemple : "ITSMConfigItemCreateTimeStartYear=2010;ITSMConfigItemCreateTimeStartMonth=10;ITSMConfigItemCreateTimeStartDay=4;ITSMConfigItemCreateTimeStopYear=2010;ITSMConfigItemCreateTimeStopMonth=11;ITSMConfigItemCreateTimeStopDay=3 ;".';
    $Self->{Translation}->{'Define Actions where a settings button is available in the linked objects widget (LinkObject::ViewMode = "complex"). Please note that these Actions must have registered the following JS and CSS files: Core.AllocationList.css, Core.UI.AllocationList.js, Core.UI.Table.Sort.js, Core.Agent.TableFilters.js and Core.Agent.LinkObject.js.'} =
        'Définir les actions pour lesquelles un bouton de configuration est disponible dans le widget des objets liés (LinkObject::ViewMode = "complex"). Veuillez noter que ces actions doivent avoir enregistré les fichiers JS et CSS suivants : Core.AllocationList.css, Core.UI.AllocationList.js, Core.UI.Table.Sort.js, Core.Agent.TableFilters.js et Core.Agent.LinkObject.js.';
    $Self->{Translation}->{'Define a Template::Toolkit scheme for version strings. Only used if Version String Module is set to TemplateToolkit.'} =
        'Définir un schéma Template::Toolkit pour les chaînes de version. Utilisé uniquement si le module de chaîne de version est défini sur TemplateToolkit.';
    $Self->{Translation}->{'Define a set of conditions under which a customer is allowed to see a config item. Conditions can optionally be restricted to certain customer groups. Name is the only mandatory attribute. If no other options are given, all config items will be visible under that category.'} =
        'Définir un ensemble de conditions sous lesquelles un client est autorisé à voir un élément de configuration. Les conditions peuvent éventuellement être limitées à certains groupes de clients. Le nom est le seul attribut obligatoire. Si aucune autre option n\'est donnée, tous les éléments de configuration seront visibles dans cette catégorie.';
    $Self->{Translation}->{'Defines Required permissions to create ITSM configuration items using the Generic Interface.'} =
        'Définit les autorisations requises pour créer des éléments de configuration ITSM à l\'aide de l\'interface générique.';
    $Self->{Translation}->{'Defines Required permissions to delete ITSM configuration items using the Generic Interface.'} =
        'Définit les autorisations requises pour supprimer des éléments de configuration ITSM à l\'aide de l\'interface générique.';
    $Self->{Translation}->{'Defines Required permissions to get ITSM configuration items using the Generic Interface.'} =
        'Définit les autorisations requises pour obtenir des éléments de configuration ITSM à l\'aide de l\'interface générique.';
    $Self->{Translation}->{'Defines Required permissions to search ITSM configuration items using the Generic Interface.'} =
        'Définit les autorisations requises pour rechercher des éléments de configuration ITSM à l\'aide de l\'interface générique.';
    $Self->{Translation}->{'Defines Required permissions to update ITSM configuration items using the Generic Interface.'} =
        'Définit les autorisations requises pour mettre à jour les éléments de configuration ITSM à l\'aide de l\'interface générique.';
    $Self->{Translation}->{'Defines an overview module to show the small view of a configuration item list.'} =
        'Définit un module de vue d\'ensemble pour afficher la petite vue d\'une liste d\'éléments de configuration.';
    $Self->{Translation}->{'Defines if the link type labels must be shown in the node connections.'} =
        'Définit si les étiquettes de type de lien doivent être affichées dans les connexions de nœuds.';
    $Self->{Translation}->{'Defines regular expressions individually for each ConfigItem class to check the ConfigItem name and to show corresponding error messages.'} =
        'Définit des expressions régulières individuellement pour chaque classe ConfigItem afin de vérifier le nom du ConfigItem et d\'afficher les messages d\'erreur correspondants.';
    $Self->{Translation}->{'Defines the available columns of CIs in the config item overview depending on the CI class. Each entry must consist of a class name and an array of available fields for the corresponding class. Dynamic field entries have to honor the scheme DynamicField_FieldName.'} =
        'Définit les colonnes disponibles pour les CI dans l\'aperçu des éléments de configuration en fonction de la classe du CI. Chaque entrée doit être constituée d\'un nom de classe et d\'un tableau de champs disponibles pour la classe correspondante. Les entrées de champs dynamiques doivent respecter le schéma DynamicField_FieldName.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of the agent interface.'} =
        'Définit l\'attribut d\'élément de configuration par défaut pour le tri des éléments de configuration dans le résultat de la recherche d\'éléments de configuration de l\'interface agent.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of the customer interface.'} =
        'Définit l\'attribut de l\'élément de configuration par défaut pour le tri des éléments de configuration dans le résultat de la recherche d\'éléments de configuration de l\'interface client.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of this operation.'} =
        'Définit l\'attribut d\'élément de configuration par défaut pour le tri des éléments de configuration dans le résultat de la recherche d\'éléments de configuration de cette opération.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the agent interface. Up: oldest on top. Down: latest on top.'} =
        'Définit l\'ordre par défaut des éléments de configuration dans le résultat de la recherche d\'éléments de configuration de l\'interface agent. Up : le plus ancien est en haut. En bas : le plus récent en haut.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the customer interface. Up: oldest on top. Down: latest on top.'} =
        'Définit l\'ordre par défaut des éléments de configuration dans le résultat de la recherche d\'éléments de configuration de l\'interface client. En haut : le plus ancien est en haut. En bas : le plus récent en haut.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the this operation. Up: oldest on top. Down: latest on top.'} =
        'Définit l\'ordre par défaut des éléments de configuration dans le résultat de la recherche d\'éléments de configuration de cette opération. En haut : le plus ancien en haut. Vers le bas : le plus récent en haut.';
    $Self->{Translation}->{'Defines the default displayed columns of CIs in the config item overview depending on the CI class. Each entry must consist of a class name and an array of available fields for the corresponding class. Dynamic field entries have to honor the scheme DynamicField_FieldName.'} =
        'Définit les colonnes affichées par défaut des CI dans la vue d\'ensemble des éléments de configuration en fonction de la classe du CI. Chaque entrée doit être constituée d\'un nom de classe et d\'un tableau de champs disponibles pour la classe correspondante. Les entrées de champs dynamiques doivent respecter le schéma DynamicField_FieldName.';
    $Self->{Translation}->{'Defines the default relations depth to be shown.'} = 'Définit la profondeur par défaut des relations à afficher.';
    $Self->{Translation}->{'Defines the default shown config item search attribute for config item search screen.'} =
        'Définit l\'attribut de recherche d\'éléments de configuration affiché par défaut pour l\'écran de recherche d\'éléments de configuration.';
    $Self->{Translation}->{'Defines the default shown config item search attribute for config item search screen. Example: "Key" must have the name of the Dynamic Field in this case \'X\', "Content" must have the value of the Dynamic Field depending on the Dynamic Field type,  Text: \'a text\', Dropdown: \'1\', Date/Time: \'Search_DynamicField_XTimeSlotStartYear=1974; Search_DynamicField_XTimeSlotStartMonth=01; Search_DynamicField_XTimeSlotStartDay=26; Search_DynamicField_XTimeSlotStartHour=00; Search_DynamicField_XTimeSlotStartMinute=00; Search_DynamicField_XTimeSlotStartSecond=00; Search_DynamicField_XTimeSlotStopYear=2013; Search_DynamicField_XTimeSlotStopMonth=01; Search_DynamicField_XTimeSlotStopDay=26; Search_DynamicField_XTimeSlotStopHour=23; Search_DynamicField_XTimeSlotStopMinute=59; Search_DynamicField_XTimeSlotStopSecond=59;\' and or \'Search_DynamicField_XTimePointFormat=week; Search_DynamicField_XTimePointStart=Before; Search_DynamicField_XTimePointValue=7\';.'} =
        'Définit l\'attribut de recherche de l\'élément de configuration affiché par défaut pour l\'écran de recherche de l\'élément de configuration. Exemple : "Key" doit contenir le nom du champ dynamique, dans ce cas "X", "Content" doit contenir la valeur du champ dynamique en fonction du type de champ dynamique, Text : "un texte", Dropdown : "1", Date/Time : "Search_DynamicField_XTimeSlotStartYear=1974 ; Search_DynamicField_XTimeSlotStartYear=1974" : \'Search_DynamicField_XTimeSlotStartYear=1974 ; Search_DynamicField_XTimeSlotStartMonth=01 ; Search_DynamicField_XTimeSlotStartDay=26 ; Search_DynamicField_XTimeSlotStartHour=00 ; Search_DynamicField_XTimeSlotStartMinute=00 ; Search_DynamicField_XTimeSlotStartSecond=00 ; Search_DynamicField_XTimeSlotStopYear=2013 ; Search_DynamicField_XTimeSlotStopMonth=01 ; Search_DynamicField_XTimeSlotStopDay=26 ; Search_DynamicField_XTimeSlotStopHour=23 ; Search_DynamicField_XTimeSlotStopMinute=59 ; Search_DynamicField_XTimeSlotStopSecond=59 ;et ou "Search_DynamicField_XTimePointFormat=week ; Search_DynamicField_XTimePointStart=Before ; Search_DynamicField_XTimePointValue=7" ;.';
    $Self->{Translation}->{'Defines the default subobject of the class \'ITSMConfigItem\'.'} =
        'Définit le sous-objet par défaut de la classe "ITSMConfigItem".';
    $Self->{Translation}->{'Defines the number of rows for the CI definition editor in the admin interface.'} =
        'Définit le nombre de lignes pour l\'éditeur de définition de CI dans l\'interface d\'administration.';
    $Self->{Translation}->{'Defines the order of incident states from high (e.g. cricital) to low (e.g. functional).'} =
        'Définit l\'ordre des états incidents, de haut (par exemple, cricital) à bas (par exemple, fonctionnel).';
    $Self->{Translation}->{'Defines the relevant deployment states where linked tickets can affect the status of a CI.'} =
        'Définit les états de déploiement pertinents dans lesquels les tickets liés peuvent affecter le statut d\'un CI.';
    $Self->{Translation}->{'Defines the search limit for the AgentITSMConfigItem screen.'} =
        'Définit la limite de recherche pour l\'écran AgentITSMConfigItem.';
    $Self->{Translation}->{'Defines the search limit for the AgentITSMConfigItemSearch screen.'} =
        'Définit la limite de recherche pour l\'écran AgentITSMConfigItemSearch.';
    $Self->{Translation}->{'Defines the search limit for the CustomerITSMConfigItem screen.'} =
        'Définit la limite de recherche pour l\'écran CustomerITSMConfigItem.';
    $Self->{Translation}->{'Defines the search limit for the CustomerITSMConfigItemSearch screen.'} =
        'Définit la limite de recherche pour l\'écran CustomerITSMConfigItemSearch.';
    $Self->{Translation}->{'Defines the shown columns of CIs in the link table complex view for all CI classes. If there is no entry, then the default columns are shown.'} =
        'Définit les colonnes affichées des CI dans la vue complexe de la table des liens pour toutes les classes de CI. S\'il n\'y a pas d\'entrée, les colonnes par défaut sont affichées.';
    $Self->{Translation}->{'Defines the shown columns of CIs in the link table complex view, depending on the CI class. Each entry must be prefixed with the class name and double colons (i.e. Computer::). There are a few CI-Attributes that common to all CIs (example for the class Computer: Computer::Name, Computer::CurDeplState, Computer::CreateTime). To show individual CI-Attributes as defined in the CI-Definition, the following scheme must be used (example for the class Computer): Computer::HardDisk::1, Computer::HardDisk::1::Capacity::1, Computer::HardDisk::2, Computer::HardDisk::2::Capacity::1. If there is no entry for a CI class, then the default columns are shown.'} =
        'Définit les colonnes affichées des CI dans la vue complexe de la table des liens, en fonction de la classe du CI. Chaque entrée doit être précédée du nom de la classe et de deux points (par exemple : Ordinateur: :). Quelques attributs de CI sont communs à tous les CI (exemple pour la classe Ordinateur::Nom, Ordinateur::Nom, Ordinateur::Nom, Ordinateur::Nom, Ordinateur::Nom) : Computer::Name, Computer::CurDeplState, Computer::CreateTime). Pour afficher les attributs de CI individuels tels que définis dans la définition de CI, il convient d\'utiliser le schéma suivant (exemple pour la classe Ordinateur) : Ordinateur::HardDisk::1, Ordinateur::HardDisk::1::Capacity::1, Ordinateur::HardDisk::2, Ordinateur::HardDisk::2::Capacity::1. S\'il n\'y a pas d\'entrée pour une classe CI, les colonnes par défaut sont affichées.';
    $Self->{Translation}->{'Defines which items are available for \'Action\' in third level of the ITSM Config Item ACL structure.'} =
        'Définit les éléments disponibles pour "Action" au troisième niveau de la structure ITSM Config Item ACL.';
    $Self->{Translation}->{'Defines which items are available in first level of the ITSM Config Item ACL structure.'} =
        'Définit les éléments disponibles au premier niveau de la structure de l\'ACL des éléments de la Config ITSM.';
    $Self->{Translation}->{'Defines which items are available in second level of the ITSM Config Item ACL structure.'} =
        'Définit les éléments disponibles au deuxième niveau de la structure ITSM Config Item ACL.';
    $Self->{Translation}->{'Defines which type of link (named from the ticket perspective) can affect the status of a linked CI.'} =
        'Définit quel type de lien (nommé du point de vue du ticket) peut affecter le statut d\'un CI lié.';
    $Self->{Translation}->{'Defines which type of ticket can affect the status of a linked CI.'} =
        'Définit quel type de ticket peut affecter le statut d\'un CI lié.';
    $Self->{Translation}->{'Definition Update'} = 'Mise à jour de la définition';
    $Self->{Translation}->{'Delete Configuration Item'} = 'Supprimer un élément de configuration';
    $Self->{Translation}->{'DeplState'} = 'DeplState';
    $Self->{Translation}->{'Deployment State Color'} = 'Couleur de l\'état de déploiement';
    $Self->{Translation}->{'DeploymentState'} = 'État de déploiement';
    $Self->{Translation}->{'Duplicate'} = 'Duplicata';
    $Self->{Translation}->{'Dynamic field event module that marks config item definitions as out of sync, if containing dynamic fields change.'} =
        'Module d\'événement de champ dynamique qui marque les définitions d\'éléments de configuration comme étant désynchronisées, si les champs dynamiques qu\'elles contiennent changent.';
    $Self->{Translation}->{'Dynamic fields shown in the additional ITSM field screen of the agent interface.'} =
        'Champs dynamiques affichés dans l\'écran des champs ITSM supplémentaires de l\'interface agent.';
    $Self->{Translation}->{'Dynamic fields shown in the config item overview screen of the customer interface.'} =
        'Champs dynamiques affichés dans l\'écran de synthèse des éléments de configuration de l\'interface client.';
    $Self->{Translation}->{'Dynamic fields shown in the config item search screen of the agent interface.'} =
        'Champs dynamiques affichés dans l\'écran de recherche des éléments de configuration de l\'interface agent.';
    $Self->{Translation}->{'Enables configuration item bulk action feature for the agent frontend to work on more than one configuration item at a time.'} =
        'Active la fonction d\'action en bloc des éléments de configuration pour que le frontend de l\'agent puisse travailler sur plus d\'un élément de configuration à la fois.';
    $Self->{Translation}->{'Enables configuration item bulk action feature only for the listed groups.'} =
        'Active la fonction d\'action en bloc des éléments de configuration uniquement pour les groupes répertoriés.';
    $Self->{Translation}->{'Enables/disables the functionality to check ITSM onfiguration items for unique names. Before enabling this option you should check your system for already existing config items with duplicate names. You can do this with the console command Admin::ITSM::Configitem::ListDuplicates.'} =
        'Active/désactive la fonctionnalité de vérification des éléments de configuration ITSM pour les noms uniques. Avant d\'activer cette option, vous devez vérifier si des éléments de configuration existants ont des noms en double. Vous pouvez le faire avec la commande de la console Admin::ITSM::Configitem::ListDuplicates.';
    $Self->{Translation}->{'Event module to set configitem-status on ticket-configitem-link.'} =
        'Module d\'événement pour définir le statut de l\'élément de configuration sur le lien ticket-configitem.';
    $Self->{Translation}->{'Fields of the configuration item index, used for the fulltext search. Fields are also stored, but are not mandatory for the overall functionality. Inclusion of attachments can be disabled by setting the entry to 0 or deleting it.'} =
        'Champs de l\'index des éléments de configuration, utilisés pour la recherche en texte intégral. Les champs sont également stockés, mais ne sont pas obligatoires pour la fonctionnalité globale. L\'inclusion des pièces jointes peut être désactivée en mettant l\'entrée à 0 ou en la supprimant.';
    $Self->{Translation}->{'Fields stored in the configuration item index which are used for other things besides fulltext searches. For the complete functionality all fields are mandatory.'} =
        'Champs stockés dans l\'index des éléments de configuration qui sont utilisés pour d\'autres choses que les recherches en texte intégral. Pour une fonctionnalité complète, tous les champs sont obligatoires.';
    $Self->{Translation}->{'For every webservice (key) an array of classes (value) can be defined on which the import is restricted. For all chosen classes, or all existing classes the identifying attributes will have to be chosen in the invoker config.'} =
        'Pour chaque service web (clé), un tableau de classes (valeur) peut être défini sur lequel l\'importation est restreinte. Pour toutes les classes choisies, ou pour toutes les classes existantes, les attributs d\'identification devront être choisis dans la configuration de l\'invocateur.';
    $Self->{Translation}->{'GenericInterface module registration for the ConfigItemFetch invoker layer.'} =
        'Enregistrement du module GenericInterface pour la couche d\'invocation ConfigItemFetch.';
    $Self->{Translation}->{'ITSM ConfigItem'} = 'ITSM ConfigItem';
    $Self->{Translation}->{'ITSM config item overview.'} = 'Aperçu des éléments de configuration ITSM.';
    $Self->{Translation}->{'InciState'} = 'InciState';
    $Self->{Translation}->{'IncidentState'} = 'État de l\'incident';
    $Self->{Translation}->{'Includes deployment states in the config item search of the customer interface.'} =
        'Inclut les états de déploiement dans la recherche d\'éléments de configuration de l\'interface client.';
    $Self->{Translation}->{'Includes incident states in the config item search of the customer interface.'} =
        'Inclut les états d\'incidents dans la recherche d\'éléments de configuration de l\'interface client.';
    $Self->{Translation}->{'Maximum number of config items to be displayed in the result of this operation.'} =
        'Nombre maximum d\'éléments de configuration à afficher dans le résultat de cette opération.';
    $Self->{Translation}->{'Module to check the group responsible for a class.'} = 'Module permettant de vérifier le groupe responsable d\'une classe.';
    $Self->{Translation}->{'Module to check the group responsible for a configuration item.'} =
        'Module permettant de vérifier le groupe responsable d\'un élément de configuration.';
    $Self->{Translation}->{'Module to generate ITSM config item statistics.'} = 'Module permettant de générer des statistiques sur les éléments de configuration ITSM.';
    $Self->{Translation}->{'Name Module'} = 'Nom du module';
    $Self->{Translation}->{'Number Module'} = 'Numéro Module';
    $Self->{Translation}->{'Number of config items to be displayed in each page of a search result in the agent interface.'} =
        'Nombre d\'éléments de configuration à afficher dans chaque page d\'un résultat de recherche dans l\'interface agent.';
    $Self->{Translation}->{'Number of config items to be displayed in each page of a search result in the customer interface.'} =
        'Nombre d\'éléments de configuration à afficher dans chaque page d\'un résultat de recherche dans l\'interface client.';
    $Self->{Translation}->{'Objects to search for, how many entries and which attributs to show. ConfigItem attributes have to explicitly be stored via Elasticsearch.'} =
        'Les objets à rechercher, le nombre d\'entrées et les attributs à afficher. Les attributs des éléments de configuration doivent être explicitement stockés via Elasticsearch.';
    $Self->{Translation}->{'Overview.'} = 'Vue d\'ensemble.';
    $Self->{Translation}->{'Parameters for the categories for config item classes in the preferences view of the agent interface.'} =
        'Paramètres pour les catégories des classes d\'éléments de configuration dans la vue des préférences de l\'interface de l\'agent.';
    $Self->{Translation}->{'Parameters for the column filters of the small config item overview. Please note: setting \'Active\' to 0 will only prevent agents from editing settings of this group in their personal preferences, but will still allow administrators to edit the settings of another user\'s behalf. Use \'PreferenceGroup\' to control in which area these settings should be shown in the user interface.'} =
        'Paramètres pour les filtres de colonne de l\'aperçu des petits éléments de configuration. Remarque : si la valeur "Actif" est fixée à 0, les agents ne pourront pas modifier les paramètres de ce groupe dans leurs préférences personnelles, mais les administrateurs pourront toujours modifier les paramètres au nom d\'un autre utilisateur. Utilisez \'PreferenceGroup\' pour contrôler dans quelle zone ces paramètres doivent être affichés dans l\'interface utilisateur.';
    $Self->{Translation}->{'Parameters for the dashboard backend of the customer company config item overview of the agent interface . "Limit" is the number of entries shown by default. "Group" is used to restrict the access to the plugin (e. g. Group: admin;group1;group2;). "Default" determines if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" is the cache time in minutes for the plugin.'} =
        'Paramètres pour le backend du tableau de bord de l\'entreprise cliente config item overview of the agent interface. "Limit" est le nombre d\'entrées affichées par défaut. "Group" est utilisé pour restreindre l\'accès au plugin (ex. Group : admin;group1;group2 ;). "Default" détermine si le plugin est activé par défaut ou si l\'utilisateur doit l\'activer manuellement. "CacheTTLLocal" est le temps de cache en minutes pour le plugin.';
    $Self->{Translation}->{'Parameters for the deployment states color in the preferences view of the agent interface.'} =
        'Paramètres pour la couleur des états de déploiement dans la vue des préférences de l\'interface de l\'agent.';
    $Self->{Translation}->{'Parameters for the deployment states in the preferences view of the agent interface.'} =
        'Paramètres pour les états de déploiement dans la vue des préférences de l\'interface de l\'agent.';
    $Self->{Translation}->{'Parameters for the example permission groups of the general catalog attributes.'} =
        'Paramètres pour l\'exemple de groupes de permission des attributs généraux du catalogue.';
    $Self->{Translation}->{'Parameters for the name module for config item classes in the preferences view of the agent interface.'} =
        'Paramètres du module de noms pour les classes d\'éléments de configuration dans la vue des préférences de l\'interface de l\'agent.';
    $Self->{Translation}->{'Parameters for the number module for config item classes in the preferences view of the agent interface.'} =
        'Paramètres du module de numérotation des classes d\'éléments de configuration dans la vue des préférences de l\'interface agent.';
    $Self->{Translation}->{'Parameters for the pages (in which the configuration items are shown).'} =
        'Active la fonction d\'action en bloc des éléments de configuration uniquement pour les groupes répertoriés.';
    $Self->{Translation}->{'Parameters for the version string module for config item classes in the preferences view of the agent interface.'} =
        'Paramètres du module de chaîne de version pour les classes d\'éléments de configuration dans la vue des préférences de l\'interface de l\'agent.';
    $Self->{Translation}->{'Parameters for the version string template toolkit module for config item classes in the preferences view of the agent interface.'} =
        'Paramètres du module de la boîte à outils du modèle de chaîne de version pour les classes d\'éléments de configuration dans la vue des préférences de l\'interface de l\'agent.';
    $Self->{Translation}->{'Parameters for the version trigger for config item classes in the preferences view of the agent interface.'} =
        'Paramètres pour le déclencheur de version pour les classes d\'éléments de configuration dans la vue des préférences de l\'interface de l\'agent.';
    $Self->{Translation}->{'Performs the configured action for each event (as an Invoker) for each configured Webservice.'} =
        'Exécute l\'action configurée pour chaque évènement (à titre de demandeur) pour les services Web configurés.';
    $Self->{Translation}->{'Permission Group'} = 'Groupe de permission';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item attachment action in the agent interface.'} =
        'Autorisations requises pour utiliser l\'action d\'attachement d\'un élément de configuration ITSM dans l\'interface de l\'agent.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item screen in the agent interface.'} =
        'Autorisations requises pour utiliser l\'écran des éléments de configuration ITSM dans l\'interface de l\'agent.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item search screen in the agent interface.'} =
        'Autorisations requises pour utiliser l\'écran de recherche des éléments de configuration ITSM dans l\'interface de l\'agent.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item search screen in the customer interface.'} =
        'Autorisations requises pour utiliser l\'écran de recherche des éléments de configuration ITSM dans l\'interface client.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item tree view screen in the agent interface.'} =
        'Autorisations requises pour utiliser l\'écran d\'arborescence des éléments de configuration ITSM dans l\'interface de l\'agent.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item zoom screen in the agent interface.'} =
        'Autorisations requises pour utiliser l\'écran de zoom des éléments de configuration ITSM dans l\'interface de l\'agent.';
    $Self->{Translation}->{'Required permissions to use the add ITSM configuration item screen in the agent interface.'} =
        'Autorisations requises pour utiliser l\'écran d\'ajout d\'éléments de configuration ITSM dans l\'interface de l\'agent.';
    $Self->{Translation}->{'Required permissions to use the bulk ITSM configuration item screen in the agent interface.'} =
        'Autorisations requises pour utiliser l\'écran des éléments de configuration ITSM en vrac dans l\'interface de l\'agent.';
    $Self->{Translation}->{'Required permissions to use the edit ITSM configuration item screen in the agent interface.'} =
        'Autorisations requises pour utiliser l\'écran de modification des éléments de configuration ITSM dans l\'interface de l\'agent.';
    $Self->{Translation}->{'Required permissions to use the history ITSM configuration item screen in the agent interface.'} =
        'Attribut %s mis à jour de "%s" à "%s"';
    $Self->{Translation}->{'Required permissions to use the print ITSM configuration item screen in the agent interface.'} =
        'Autorisations requises pour utiliser l\'écran d\'impression des éléments de configuration ITSM dans l\'interface de l\'agent.';
    $Self->{Translation}->{'Required privileges to delete config items.'} = 'Privilèges requis pour supprimer des éléments de configuration.';
    $Self->{Translation}->{'Search config items.'} = 'Rechercher des éléments de configuration.';
    $Self->{Translation}->{'Set the incident state of a CI automatically when a Ticket is Linked to a CI.'} =
        'Définir automatiquement l\'état d\'incident d\'un CI lorsqu\'un ticket est lié à un CI.';
    $Self->{Translation}->{'Sets the deployment state in the configuration item bulk screen of the agent interface.'} =
        'Définit l\'état de déploiement dans l\'écran d\'ensemble des éléments de configuration de l\'interface de l\'agent.';
    $Self->{Translation}->{'Sets the incident state in the configuration item bulk screen of the agent interface.'} =
        'Définit l\'état de l\'incident dans l\'écran des éléments de configuration de l\'interface agent.';
    $Self->{Translation}->{'Shows a link in the menu that allows linking a configuration item with another object in the config item zoom view of the agent interface.'} =
        'Affiche un lien dans le menu qui permet de lier un élément de configuration à un autre objet dans la vue zoom de l\'élément de configuration de l\'interface agent.';
    $Self->{Translation}->{'Shows a link in the menu to access the history of a configuration item in the configuration item overview of the agent interface.'} =
        'Affiche un lien dans le menu pour accéder à l\'historique d\'un élément de configuration dans l\'aperçu des éléments de configuration de l\'interface agent.';
    $Self->{Translation}->{'Shows a link in the menu to access the history of a configuration item in the its zoom view of the agent interface.'} =
        'Affiche un lien dans le menu pour accéder à l\'historique d\'un élément de configuration dans la vue zoom de l\'interface agent.';
    $Self->{Translation}->{'Shows a link in the menu to delete a configuration item in its zoom view of the agent interface.'} =
        'Affiche un lien dans le menu pour supprimer un élément de configuration dans sa vue zoom de l\'interface de l\'agent.';
    $Self->{Translation}->{'Shows a link in the menu to display the configuration item links as a Tree View.'} =
        'Affiche un lien dans le menu pour afficher les liens des éléments de configuration sous forme d\'arborescence.';
    $Self->{Translation}->{'Shows a link in the menu to duplicate a configuration item in the configuration item overview of the agent interface.'} =
        'Affiche un lien dans le menu pour dupliquer un élément de configuration dans l\'aperçu des éléments de configuration de l\'interface agent.';
    $Self->{Translation}->{'Shows a link in the menu to duplicate a configuration item in the its zoom view of the agent interface.'} =
        'Affiche un lien dans le menu pour dupliquer un élément de configuration dans la vue zoom de l\'interface de l\'agent.';
    $Self->{Translation}->{'Shows a link in the menu to edit a configuration item in the its zoom view of the agent interface.'} =
        'Affiche un lien dans le menu pour modifier un élément de configuration dans la vue zoom de l\'interface de l\'agent.';
    $Self->{Translation}->{'Shows a link in the menu to go back in the configuration item zoom view of the agent interface.'} =
        'Affiche un lien dans le menu pour revenir à la vue zoom des éléments de configuration de l\'interface de l\'agent.';
    $Self->{Translation}->{'Shows a link in the menu to print a configuration item in the its zoom view of the agent interface.'} =
        'Affiche un lien dans le menu pour imprimer un élément de configuration dans la vue zoom de l\'interface agent.';
    $Self->{Translation}->{'Shows a link in the menu to zoom into a configuration item in the configuration item overview of the agent interface.'} =
        'Affiche un lien dans le menu permettant de zoomer sur un élément de configuration dans l\'aperçu des éléments de configuration de l\'interface agent.';
    $Self->{Translation}->{'Shows the config item history (reverse ordered) in the agent interface.'} =
        'Affiche l\'historique des éléments de configuration (ordre inverse) dans l\'interface agent.';
    $Self->{Translation}->{'The default category which is shown, if none is selected.'} = 'La catégorie par défaut qui est affichée si aucune n\'est sélectionnée.';
    $Self->{Translation}->{'The identifier for a configuration item, e.g. ConfigItem#, MyConfigItem#. The default is ConfigItem#.'} =
        'L\'identifiant d\'un élément de configuration, par exemple ConfigItem#, MyConfigItem#. La valeur par défaut est ConfigItem#.';
    $Self->{Translation}->{'Triggers ConfigItemFetch invoker automatically.'} = 'Déclenche automatiquement l\'invoker ConfigItemFetch.';
    $Self->{Translation}->{'Version String Expression'} = 'Expression de la chaîne de la version';
    $Self->{Translation}->{'Version String Module'} = 'Version Chaîne de caractères Module';
    $Self->{Translation}->{'Version Trigger'} = 'Déclencheur de version';
    $Self->{Translation}->{'Whether the execution of ConfigItemACL can be avoided by checking cached field dependencies. This can improve loading times of formulars, but has to be disabled, if ACLModules are to be used for ITSMConfigItem- and Form-ReturnTypes.'} =
        'Si l\'exécution de ConfigItemACL peut être évitée en vérifiant les dépendances des champs mis en cache. Cela peut améliorer les temps de chargement des formulaires, mais doit être désactivé si les modules ACLM doivent être utilisés pour les types ITSMConfigItem et Form-ReturnTypes.';
    $Self->{Translation}->{'Which general information is shown in the header.'} = 'Quelles sont les informations générales qui figurent dans l\'en-tête ?';
    $Self->{Translation}->{'class'} = 'classe';
    $Self->{Translation}->{'global'} = 'mondial';
    $Self->{Translation}->{'postproductive'} = 'postproductif';
    $Self->{Translation}->{'preproductive'} = 'préproductif';
    $Self->{Translation}->{'productive'} = 'productif';


    push @{ $Self->{JavaScriptStrings} // [] }, (
    'Add all',
    'An error occurred during class import.',
    'An error occurred during communication.',
    'An item with this name is already present.',
    'Cancel',
    'Confirm',
    'Delete',
    'Dismiss',
    'Do you want to proceed?',
    'Importing classes/roles and their related fields',
    'No',
    'Note that also corresponding dynamic fields and GeneralCatalog classes will be created and there is no automatic removal.',
    'Ok',
    'Overview and Confirmation',
    'Please enter at least one search value or * to find anything.',
    'Search',
    'Settings',
    'Submit',
    'The following classes will be imported',
    'The following roles will be imported',
    'This item still contains sub items. Are you sure you want to remove this item including its sub items?',
    'Yes',
    );

}

1;

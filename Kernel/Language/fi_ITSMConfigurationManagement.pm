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

package Kernel::Language::fi_ITSMConfigurationManagement;

use strict;
use warnings;
use utf8;

sub Data {
    my $Self = shift;

    # Template: AdminGenericInterfaceInvokerConfigItem
    $Self->{Translation}->{'General invoker data'} = '';
    $Self->{Translation}->{'This OTOBO invoker backend module will be called to prepare the data to be sent to the remote system, and to process its response data.'} =
        '';
    $Self->{Translation}->{'Settings for outgoing request data'} = '';
    $Self->{Translation}->{'Mapping'} = '';
    $Self->{Translation}->{'The data from the invoker of OTOBO will be processed by this mapping, to transform it to the kind of data the remote system expects.'} =
        '';
    $Self->{Translation}->{'The response data will be processed by this mapping, to transform it to the kind of data the invoker of OTOBO expects.'} =
        '';
    $Self->{Translation}->{'Settings for incoming response data'} = '';
    $Self->{Translation}->{'Event data'} = '';
    $Self->{Translation}->{'Add Event'} = '';
    $Self->{Translation}->{'Asynchronous event triggers are handled by the OTOBO Scheduler Daemon in background (recommended).'} =
        '';

    # Template: AdminITSMConfigItem
    $Self->{Translation}->{'Config Item Management'} = '';
    $Self->{Translation}->{'Change class definition'} = '';
    $Self->{Translation}->{'Change role definition'} = '';
    $Self->{Translation}->{'Ready2Import Class Bundles'} = '';
    $Self->{Translation}->{'Here you can import Ready2Import class bundles showcasing our most usual config items. Please note that some additional configuration may be required.'} =
        '';
    $Self->{Translation}->{'Update existing entities'} = '';
    $Self->{Translation}->{'Import Ready2Adopt class bundles'} = '';
    $Self->{Translation}->{'Config Item Class'} = '';
    $Self->{Translation}->{'Config Item Role'} = '';
    $Self->{Translation}->{'Definition'} = '';
    $Self->{Translation}->{'Change'} = '';
    $Self->{Translation}->{'Auto Indent Code'} = '';
    $Self->{Translation}->{'Comment/Uncomment Code'} = '';
    $Self->{Translation}->{'Search & Replace'} = '';
    $Self->{Translation}->{'Select All'} = '';
    $Self->{Translation}->{'Full Screen'} = '';

    # Template: AgentITSMConfigItemAdd
    $Self->{Translation}->{'Config Item'} = '';
    $Self->{Translation}->{'Filter for Classes'} = '';
    $Self->{Translation}->{'Select a Class from the list to create a new Config Item.'} = '';
    $Self->{Translation}->{'Class'} = '';

    # Template: AgentITSMConfigItemBulk
    $Self->{Translation}->{'ITSM ConfigItem Bulk Action'} = '';
    $Self->{Translation}->{'Deployment state'} = '';
    $Self->{Translation}->{'Incident state'} = '';
    $Self->{Translation}->{'Link to another'} = '';
    $Self->{Translation}->{'Invalid Configuration Item number!'} = '';
    $Self->{Translation}->{'The number of another Configuration Item to link with.'} = '';

    # Template: AgentITSMConfigItemDelete
    $Self->{Translation}->{'Do you really want to delete this config item?'} = '';

    # Template: AgentITSMConfigItemEdit
    $Self->{Translation}->{'The name of this config item'} = '';
    $Self->{Translation}->{'Name is already in use by the ConfigItems with the following Number(s): %s'} =
        '';
    $Self->{Translation}->{'Version Number'} = '';
    $Self->{Translation}->{'The version number of this config item'} = '';
    $Self->{Translation}->{'Version Number is already in use by the ConfigItems with the following Number(s): %s'} =
        '';
    $Self->{Translation}->{'Deployment State'} = '';
    $Self->{Translation}->{'Incident State'} = '';

    # Template: AgentITSMConfigItemHistory
    $Self->{Translation}->{'History of Config Item: %s'} = '';
    $Self->{Translation}->{'History Content'} = '';
    $Self->{Translation}->{'Createtime'} = '';
    $Self->{Translation}->{'Zoom view'} = '';

    # Template: AgentITSMConfigItemOverviewNavBar
    $Self->{Translation}->{'Config Items per page'} = '';

    # Template: AgentITSMConfigItemOverviewSmall
    $Self->{Translation}->{'No config item data found.'} = '';
    $Self->{Translation}->{'Select this config item'} = '';

    # Template: AgentITSMConfigItemSearch
    $Self->{Translation}->{'Run Search'} = '';
    $Self->{Translation}->{'Also search in previous versions?'} = '';

    # Template: AgentITSMConfigItemTreeView
    $Self->{Translation}->{'TreeView for ConfigItem'} = '';
    $Self->{Translation}->{'Depth Level'} = '';
    $Self->{Translation}->{'Zoom In/Out'} = '';
    $Self->{Translation}->{'Max links level reached for ConfigItem!'} = '';

    # Template: AgentITSMConfigItemZoom
    $Self->{Translation}->{'Configuration Item'} = '';
    $Self->{Translation}->{'Configuration Item Information'} = '';
    $Self->{Translation}->{'Current Deployment State'} = '';
    $Self->{Translation}->{'Current Incident State'} = '';
    $Self->{Translation}->{'Last changed'} = '';
    $Self->{Translation}->{'Last changed by'} = '';

    # Template: CustomerITSMConfigItem
    $Self->{Translation}->{'Your ConfigItems'} = '';
    $Self->{Translation}->{'ConfigItems'} = '';
    $Self->{Translation}->{'Sort'} = '';

    # Template: CustomerITSMConfigItemSearch
    $Self->{Translation}->{'ConfigItem Search'} = '';

    # Template: AdminACL
    $Self->{Translation}->{'Filter by valid state'} = '';
    $Self->{Translation}->{'Include invalid ACLs'} = '';
    $Self->{Translation}->{'Object Type'} = '';

    # Template: AdminACLEdit
    $Self->{Translation}->{'Check the official %sdocumentation%s.'} = '';

    # Template: AdminDynamicField
    $Self->{Translation}->{'Include invalid dynamic fields'} = '';
    $Self->{Translation}->{'Filter field by object type'} = '';
    $Self->{Translation}->{'Filter field by namespace'} = '';
    $Self->{Translation}->{'New Dynamic Fields'} = '';
    $Self->{Translation}->{'Would you like to benefit from additional dynamic field types? You have full access to the following field types:'} =
        '';
    $Self->{Translation}->{'Copy this field'} = '';

    # JS Template: ClassImportConfirm
    $Self->{Translation}->{'The following classes will be imported'} = '';
    $Self->{Translation}->{'The following roles will be imported'} = '';
    $Self->{Translation}->{'Note that also corresponding dynamic fields and GeneralCatalog classes will be created and there is no automatic removal.'} =
        '';
    $Self->{Translation}->{'Do you want to proceed?'} = '';

    # Perl Module: Kernel/Modules/AdminITSMConfigItem.pm
    $Self->{Translation}->{'Need ExampleClasses!'} = '';
    $Self->{Translation}->{'Definition is no valid YAML hash.'} = '';

    # Perl Module: Kernel/Modules/AgentITSMConfigItem.pm
    $Self->{Translation}->{'Overview: ITSM ConfigItem'} = '';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemBulk.pm
    $Self->{Translation}->{'No ConfigItemID is given!'} = '';
    $Self->{Translation}->{'You need at least one selected Configuration Item!'} = '';
    $Self->{Translation}->{'You don\'t have write access to this configuration item: %s.'} =
        '';
    $Self->{Translation}->{'No definition was defined for class %s!'} = '';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemDelete.pm
    $Self->{Translation}->{'Config item "%s" not found in database!'} = '';
    $Self->{Translation}->{'Was not able to delete the configitem ID %s!'} = '';
    $Self->{Translation}->{'No version found for ConfigItemID %s!'} = '';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemEdit.pm
    $Self->{Translation}->{'No ConfigItemID, DuplicateID or ClassID is given!'} = '';
    $Self->{Translation}->{'No access is given!'} = '';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemHistory.pm
    $Self->{Translation}->{'Can\'t show history, no ConfigItemID is given!'} = '';
    $Self->{Translation}->{'Can\'t show history, no access rights given!'} = '';
    $Self->{Translation}->{'New ConfigItem (ID=%s)'} = '';
    $Self->{Translation}->{'New version (ID=%s)'} = '';
    $Self->{Translation}->{'Deployment state updated (new=%s, old=%s)'} = '';
    $Self->{Translation}->{'Incident state updated (new=%s, old=%s)'} = '';
    $Self->{Translation}->{'ConfigItem (ID=%s) deleted'} = '';
    $Self->{Translation}->{'Link to %s (type=%s) added'} = '';
    $Self->{Translation}->{'Link to %s (type=%s) deleted'} = '';
    $Self->{Translation}->{'ConfigItem definition updated (ID=%s)'} = '';
    $Self->{Translation}->{'Name updated (new=%s, old=%s)'} = '';
    $Self->{Translation}->{'Attribute %s updated from "%s" to "%s"'} = '';
    $Self->{Translation}->{'Version %s deleted'} = '';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemPrint.pm
    $Self->{Translation}->{'No ConfigItemID or VersionID is given!'} = '';
    $Self->{Translation}->{'Can\'t show config item, no access rights given!'} = '';
    $Self->{Translation}->{'ConfigItemID %s not found in database!'} = '';
    $Self->{Translation}->{'ConfigItem'} = '';
    $Self->{Translation}->{'printed by %s at %s'} = '';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemSearch.pm
    $Self->{Translation}->{'Invalid ClassID!'} = '';
    $Self->{Translation}->{'No ClassID is given!'} = '';
    $Self->{Translation}->{'No access rights for this class given!'} = '';
    $Self->{Translation}->{'No Result!'} = '';
    $Self->{Translation}->{'Config Item Search Results'} = '';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemZoom.pm
    $Self->{Translation}->{'Can\'t show item, no access rights for ConfigItem are given!'} =
        '';
    $Self->{Translation}->{'ConfigItem not found!'} = '';
    $Self->{Translation}->{'No versions found!'} = '';
    $Self->{Translation}->{'operational'} = '';
    $Self->{Translation}->{'warning'} = '';
    $Self->{Translation}->{'incident'} = '';
    $Self->{Translation}->{'The deployment state of this config item'} = '';
    $Self->{Translation}->{'The incident state of this config item'} = '';

    # Perl Module: Kernel/Modules/CustomerITSMConfigItemSearch.pm
    $Self->{Translation}->{'No permission'} = '';
    $Self->{Translation}->{'Filter invalid!'} = '';
    $Self->{Translation}->{'Search params invalid!'} = '';

    # Perl Module: Kernel/Output/HTML/Dashboard/ITSMConfigItemGeneric.pm
    $Self->{Translation}->{'Shown config items'} = '';
    $Self->{Translation}->{'Deployment State Type'} = '';
    $Self->{Translation}->{'Current Incident State Type'} = '';

    # Perl Module: Kernel/Output/HTML/ITSMConfigItem/LayoutDate.pm
    $Self->{Translation}->{'Between'} = 'Välillä';

    # Perl Module: Kernel/System/DynamicField/Driver/ConfigItem.pm
    $Self->{Translation}->{'Class restrictions for the config item'} = '';
    $Self->{Translation}->{'Select one or more classes to restrict selectable config items'} =
        '';
    $Self->{Translation}->{'Link type'} = '';
    $Self->{Translation}->{'Select the link type.'} = '';
    $Self->{Translation}->{'Forwards: Referencing (Source) -> Referenced (Target)'} = '';
    $Self->{Translation}->{'Backwards: Referenced (Source) -> Referencing (Target)'} = '';
    $Self->{Translation}->{'Link Direction'} = '';
    $Self->{Translation}->{'The referencing object is the one containing this dynamic field, the referenced object is the one selected as value of the dynamic field.'} =
        '';
    $Self->{Translation}->{'Dynamic (ConfigItem)'} = '';
    $Self->{Translation}->{'Static (Version)'} = '';
    $Self->{Translation}->{'Link Referencing Type'} = '';
    $Self->{Translation}->{'Whether this link applies to the ConfigItem or the static version of the referencing object. Current Incident State calculation only is performed on dynamic links.'} =
        '';
    $Self->{Translation}->{'Attribute which will be searched on autocomplete'} = '';
    $Self->{Translation}->{'Select the attribute which config items will be searched by'} = '';
    $Self->{Translation}->{'External-source key'} = '';
    $Self->{Translation}->{'When set via an external source (e.g. web service or import / export), the value will be interpreted as this attribute.'} =
        '';
    $Self->{Translation}->{'Attribute which is displayed for values'} = '';
    $Self->{Translation}->{'Select the type of display'} = '';

    # Perl Module: Kernel/System/ITSMConfigItem/Definition.pm
    $Self->{Translation}->{'Base structure is not valid. Please provide an array with data in YAML format.'} =
        '';
    $Self->{Translation}->{'Starting the YAML string with \'---\' is required.'} = '';

    # Perl Module: Kernel/System/ITSMConfigItem/Link.pm
    $Self->{Translation}->{'Could not purge the table configitem_link.'} = '';
    $Self->{Translation}->{'No relevant dynamic fields were found'} = '';
    $Self->{Translation}->{'Could not insert into the table configitem_link'} = '';
    $Self->{Translation}->{'Inserted 0 rows into the table configitem_link'} = '';

    # Perl Module: Kernel/System/ImportExport/ObjectBackend/ITSMConfigItem.pm
    $Self->{Translation}->{'Maximum number of one element'} = '';
    $Self->{Translation}->{'Empty fields indicate that the current values are kept'} = '';
    $Self->{Translation}->{'Skipped'} = '';

    # Perl Module: Kernel/Modules/AdminACL.pm
    $Self->{Translation}->{'ACLs could not be Imported due to a unknown error, please check OTOBO logs for more information'} =
        '';
    $Self->{Translation}->{'%s (copy) %s'} = '';

    # Perl Module: Kernel/Modules/AdminDynamicField.pm
    $Self->{Translation}->{'Error synchronizing the definitions. Please check the log.'} = '';
    $Self->{Translation}->{'You have ITSMConfigItem definitions which are not synchronized. Please deploy your ITSMConfigItem dynamic field changes.'} =
        '';

    # Database XML Definition: ITSMConfigurationManagement.sopm
    $Self->{Translation}->{'Expired'} = '';
    $Self->{Translation}->{'Maintenance'} = '';
    $Self->{Translation}->{'Pilot'} = '';
    $Self->{Translation}->{'Planned'} = '';
    $Self->{Translation}->{'Repair'} = '';
    $Self->{Translation}->{'Retired'} = '';
    $Self->{Translation}->{'Review'} = '';
    $Self->{Translation}->{'Test/QA'} = '';

    # JS File: ITSM.Admin.ITSMConfigItem
    $Self->{Translation}->{'Overview and Confirmation'} = '';
    $Self->{Translation}->{'An error occurred during class import.'} = '';

    # JS File: ITSM.Agent.ConfigItem.Zoom
    $Self->{Translation}->{'Ok'} = '';

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

    # ITSM class bundles
    $Self->{Translation}->{'Accounting'} = '';
    $Self->{Translation}->{'Address Allocation'} = '';
    $Self->{Translation}->{'Administrator'} = '';
    $Self->{Translation}->{'Analog Phone'} = '';
    $Self->{Translation}->{'Appliance Type'} = '';
    $Self->{Translation}->{'Backlinks'} = '';
    $Self->{Translation}->{'Battery Capacity (Ah)'} = '';
    $Self->{Translation}->{'Battery Type'} = '';
    $Self->{Translation}->{'Building'} = '';
    $Self->{Translation}->{'Bus Interface'} = '';
    $Self->{Translation}->{'CIDR'} = '';
    $Self->{Translation}->{'CPU'} = '';
    $Self->{Translation}->{'CPU Class'} = '';
    $Self->{Translation}->{'Capacity (GB)'} = '';
    $Self->{Translation}->{'Capacity per graphics card'} = '';
    $Self->{Translation}->{'Card Number'} = '';
    $Self->{Translation}->{'Card Reader'} = '';
    $Self->{Translation}->{'Card Type'} = '';
    $Self->{Translation}->{'Client Certificates'} = '';
    $Self->{Translation}->{'Client Software'} = '';
    $Self->{Translation}->{'Client category'} = '';
    $Self->{Translation}->{'Clockrate'} = '';
    $Self->{Translation}->{'Clockspeed'} = '';
    $Self->{Translation}->{'Code Signing Certificates'} = '';
    $Self->{Translation}->{'Conference Phone'} = '';
    $Self->{Translation}->{'Consulting Agreement'} = '';
    $Self->{Translation}->{'Contact'} = '';
    $Self->{Translation}->{'Contact Distributor'} = '';
    $Self->{Translation}->{'Container Management'} = '';
    $Self->{Translation}->{'Contract'} = '';
    $Self->{Translation}->{'Contract Type'} = '';
    $Self->{Translation}->{'Contract period from'} = '';
    $Self->{Translation}->{'Contract period until'} = '';
    $Self->{Translation}->{'Cordless Phone (DECT Phone)'} = '';
    $Self->{Translation}->{'Cost unit'} = '';
    $Self->{Translation}->{'Count of licenses'} = '';
    $Self->{Translation}->{'Creation Date'} = '';
    $Self->{Translation}->{'DHCP'} = '';
    $Self->{Translation}->{'DHCP Reserved'} = '';
    $Self->{Translation}->{'DNS-Server'} = '';
    $Self->{Translation}->{'Date of Invoice'} = '';
    $Self->{Translation}->{'Date of Order'} = '';
    $Self->{Translation}->{'Date of Warranty'} = '';
    $Self->{Translation}->{'Date of release'} = '';
    $Self->{Translation}->{'Desktop'} = '';
    $Self->{Translation}->{'Document Signing Certificates'} = '';
    $Self->{Translation}->{'Email Certificates (S/MIME Certificates)'} = '';
    $Self->{Translation}->{'Employment Contract'} = '';
    $Self->{Translation}->{'End IP Address'} = '';
    $Self->{Translation}->{'End of support'} = '';
    $Self->{Translation}->{'Expiry Date'} = '';
    $Self->{Translation}->{'External Hard Drive'} = '';
    $Self->{Translation}->{'Firewall'} = '';
    $Self->{Translation}->{'Firmware'} = '';
    $Self->{Translation}->{'Form Factor'} = '';
    $Self->{Translation}->{'Franchise Agreement'} = '';
    $Self->{Translation}->{'General Information'} = '';
    $Self->{Translation}->{'Graphics Cards'} = '';
    $Self->{Translation}->{'Graphics card'} = '';
    $Self->{Translation}->{'Hardware'} = '';
    $Self->{Translation}->{'Hardware Model'} = '';
    $Self->{Translation}->{'Hardware Weight'} = '';
    $Self->{Translation}->{'Headset'} = '';
    $Self->{Translation}->{'IP Protocol'} = '';
    $Self->{Translation}->{'Identity and Access Management (IAM)'} = '';
    $Self->{Translation}->{'Inventory Number'} = '';
    $Self->{Translation}->{'Inverstment costs'} = '';
    $Self->{Translation}->{'Invoice Number'} = '';
    $Self->{Translation}->{'Keyboard'} = '';
    $Self->{Translation}->{'Landline Phone'} = '';
    $Self->{Translation}->{'Laptop'} = '';
    $Self->{Translation}->{'Latitude'} = '';
    $Self->{Translation}->{'Layer 1: Physical Layer'} = '';
    $Self->{Translation}->{'Layer 2: Data Link Layer'} = '';
    $Self->{Translation}->{'Layer 3: Network Layer'} = '';
    $Self->{Translation}->{'Layer 3: Network Layer (Supernet)'} = '';
    $Self->{Translation}->{'Layer 4: Transport Layer'} = '';
    $Self->{Translation}->{'Layer 5: Session Layer'} = '';
    $Self->{Translation}->{'Layer 6: Presentation Layer'} = '';
    $Self->{Translation}->{'Layer 7: Application Layer'} = '';
    $Self->{Translation}->{'Lease Agreement'} = '';
    $Self->{Translation}->{'License Agreement'} = '';
    $Self->{Translation}->{'License Key'} = '';
    $Self->{Translation}->{'License Type'} = '';
    $Self->{Translation}->{'License period from'} = '';
    $Self->{Translation}->{'License period until'} = '';
    $Self->{Translation}->{'Loan Agreement'} = '';
    $Self->{Translation}->{'Located in'} = '';
    $Self->{Translation}->{'Longitude'} = '';
    $Self->{Translation}->{'Manufacturer'} = '';
    $Self->{Translation}->{'Maximum Load Capacity (W)'} = '';
    $Self->{Translation}->{'Memory'} = '';
    $Self->{Translation}->{'Memory Type'} = '';
    $Self->{Translation}->{'Mobile Number'} = '';
    $Self->{Translation}->{'Mobile/Embedded'} = '';
    $Self->{Translation}->{'Model'} = '';
    $Self->{Translation}->{'Model Description'} = '';
    $Self->{Translation}->{'Monitor Resolution'} = '';
    $Self->{Translation}->{'Monitor Size'} = '';
    $Self->{Translation}->{'Mouse'} = '';
    $Self->{Translation}->{'Network'} = '';
    $Self->{Translation}->{'Network Info'} = '';
    $Self->{Translation}->{'Network Information'} = '';
    $Self->{Translation}->{'Network Layer'} = '';
    $Self->{Translation}->{'Non-Disclosure Agreement (NDA)'} = '';
    $Self->{Translation}->{'Notebook'} = '';
    $Self->{Translation}->{'Number of CPUs'} = '';
    $Self->{Translation}->{'Number of RAM modules'} = '';
    $Self->{Translation}->{'Number of graphics cards'} = '';
    $Self->{Translation}->{'OTOBO'} = '';
    $Self->{Translation}->{'Operating costs'} = '';
    $Self->{Translation}->{'Order Number'} = '';
    $Self->{Translation}->{'Other'} = '';
    $Self->{Translation}->{'Outputs'} = '';
    $Self->{Translation}->{'PIN'} = '';
    $Self->{Translation}->{'PIN 2'} = '';
    $Self->{Translation}->{'PUK'} = '';
    $Self->{Translation}->{'PUK 2'} = '';
    $Self->{Translation}->{'Partnership Agreement'} = '';
    $Self->{Translation}->{'Phone / VOIP'} = '';
    $Self->{Translation}->{'Phone Number'} = '';
    $Self->{Translation}->{'Phone Type'} = '';
    $Self->{Translation}->{'Physical Cores'} = '';
    $Self->{Translation}->{'Power Delivery'} = '';
    $Self->{Translation}->{'Purchased at'} = '';
    $Self->{Translation}->{'Rack Depth'} = '';
    $Self->{Translation}->{'Rack Units (U)'} = '';
    $Self->{Translation}->{'Reference to Customer'} = '';
    $Self->{Translation}->{'Room'} = '';
    $Self->{Translation}->{'SIM Card'} = '';
    $Self->{Translation}->{'SSL/TLS Certificates'} = '';
    $Self->{Translation}->{'Sales Contract'} = '';
    $Self->{Translation}->{'Satellite Phone'} = '';
    $Self->{Translation}->{'Serialnumber'} = '';
    $Self->{Translation}->{'Server'} = '';
    $Self->{Translation}->{'Server Software'} = '';
    $Self->{Translation}->{'Service Agreement'} = '';
    $Self->{Translation}->{'Service Tag'} = '';
    $Self->{Translation}->{'Socket Type'} = '';
    $Self->{Translation}->{'Software'} = '';
    $Self->{Translation}->{'Speakers'} = '';
    $Self->{Translation}->{'Start IP Address'} = '';
    $Self->{Translation}->{'Storage'} = '';
    $Self->{Translation}->{'Storage Partition'} = '';
    $Self->{Translation}->{'Subsidiary'} = '';
    $Self->{Translation}->{'Summary'} = '';
    $Self->{Translation}->{'Thin Client'} = '';
    $Self->{Translation}->{'Threads'} = '';
    $Self->{Translation}->{'Total Graphics card RAM (GB)'} = '';
    $Self->{Translation}->{'Total RAM (GB)'} = '';
    $Self->{Translation}->{'USB Hub'} = '';
    $Self->{Translation}->{'VPN'} = '';
    $Self->{Translation}->{'VR Headset'} = '';
    $Self->{Translation}->{'VoIP Phone'} = '';
    $Self->{Translation}->{'Webcam'} = '';


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

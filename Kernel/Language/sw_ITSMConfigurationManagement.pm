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

package Kernel::Language::sw_ITSMConfigurationManagement;

use strict;
use warnings;
use utf8;

sub Data {
    my $Self = shift;

    # Template: AdminITSMConfigItem
    $Self->{Translation}->{'Config Item Management'} = 'Usanidi wa usimamizi wa kipengele ';
    $Self->{Translation}->{'Change class definition'} = 'Badili ufafanuzi wa tabaka';
    $Self->{Translation}->{'Config Item Class'} = '';
    $Self->{Translation}->{'Definition'} = 'Ufafanuzi';
    $Self->{Translation}->{'Change'} = 'Badilisha';

    # Template: AgentDashboardITSMConfigItemGeneric
    $Self->{Translation}->{'Incident State'} = 'Hali ya tukio';
    $Self->{Translation}->{'Deployment State'} = 'Hali ya kutumia';
    $Self->{Translation}->{'Class'} = 'Tabaka';
    $Self->{Translation}->{'Deployment State Type'} = 'Aina ya hali ya kutumia';
    $Self->{Translation}->{'Current Incident State'} = 'Hali ya tukio la sasa';
    $Self->{Translation}->{'Current Incident State Type'} = 'Aina ya hali ya tukio la sasa';
    $Self->{Translation}->{'Last changed'} = 'Mwisho kubadilishwa';

    # Template: AgentITSMConfigItemAdd
    $Self->{Translation}->{'Config Item'} = 'Usanidi wa Kipengele ';
    $Self->{Translation}->{'Filter for Classes'} = 'Chuja kwa ajili ya matabaka';
    $Self->{Translation}->{'Select a Class from the list to create a new Config Item.'} = 'Chagua tabaka kutoka kwenye orodha ya kutengeneza kipengele cha usanidi kipya. ';

    # Template: AgentITSMConfigItemBulk
    $Self->{Translation}->{'ITSM ConfigItem Bulk Action'} = 'Vitendo vya wingi vya kipengele cha usanidi cha ITSM';
    $Self->{Translation}->{'Deployment state'} = 'Hali ya kutumia';
    $Self->{Translation}->{'Incident state'} = 'Hali ya tukio';
    $Self->{Translation}->{'Link to another'} = 'Unganisha na nyingine';
    $Self->{Translation}->{'Invalid Configuration Item number!'} = 'Namba ya kipengele cha usanidi n batili!';
    $Self->{Translation}->{'The number of another Configuration Item to link with.'} = 'Namba ya kipengele kingine cha usanidi cha kuunganisha nacho.';

    # Template: AgentITSMConfigItemDelete
    $Self->{Translation}->{'Do you really want to delete this config item?'} = '';

    # Template: AgentITSMConfigItemEdit
    $Self->{Translation}->{'The name of this config item'} = 'Jina la hiki kipengele cha usanidi';
    $Self->{Translation}->{'Name is already in use by the ConfigItems with the following Number(s): %s'} =
        'Jina hili tayari limekwisha tumikana kipengele cha usanidi chenye namba i(z)fuatazo: %s';

    # Template: AgentITSMConfigItemHistory
    $Self->{Translation}->{'History of Config Item: %s'} = '';
    $Self->{Translation}->{'History Content'} = 'Maudhui ya historia';
    $Self->{Translation}->{'Createtime'} = 'Muda wa kutengeneza';
    $Self->{Translation}->{'Zoom view'} = 'Mandhari iliyokuzwa';

    # Template: AgentITSMConfigItemOverviewNavBar
    $Self->{Translation}->{'Context Settings'} = 'Mipangilio ya muktadha';
    $Self->{Translation}->{'Config Items per page'} = 'Vipengele vya usanidi kwa kila ukurusa';

    # Template: AgentITSMConfigItemOverviewSmall
    $Self->{Translation}->{'A generic ITSM Configuration Item table'} = '';

    # Template: AgentITSMConfigItemSearch
    $Self->{Translation}->{'Run Search'} = 'Tafuta';
    $Self->{Translation}->{'Also search in previous versions?'} = 'Pia tafuta katika toleo lililopita?';

    # Template: AgentITSMConfigItemZoom
    $Self->{Translation}->{'Configuration Item'} = 'Kipengele cha Usanidi';
    $Self->{Translation}->{'Configuration Item Information'} = 'Taarifa za kipengele cha usanidi';
    $Self->{Translation}->{'Current Deployment State'} = 'Hali ya kutumia ya sasa';
    $Self->{Translation}->{'Last changed by'} = 'Mwisho kubadilishwa na';
    $Self->{Translation}->{'Show one version'} = 'Onyesha toleo moja';
    $Self->{Translation}->{'Show all versions'} = 'Onyesha matoleo yote';
    $Self->{Translation}->{'Version Incident State'} = 'Toleo la hali ya tukio';
    $Self->{Translation}->{'Version Deployment State'} = 'Hali ya toleo la kutumia';
    $Self->{Translation}->{'Version Number'} = 'Namba ya toleo';
    $Self->{Translation}->{'Configuration Item Version Details'} = 'Toleo la kipengele cha usanidi kwa undani.';
    $Self->{Translation}->{'Property'} = 'Mali';

    # Perl Module: Kernel/Modules/AgentITSMConfigItem.pm
    $Self->{Translation}->{'No access to Class is given!'} = '';
    $Self->{Translation}->{'Overview: ITSM ConfigItem'} = '';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemBulk.pm
    $Self->{Translation}->{'No ConfigItemID is given!'} = '';
    $Self->{Translation}->{'You need at least one selected Configuration Item!'} = '';
    $Self->{Translation}->{'You don\'t have write access to this configuration item: %s.'} =
        '';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemDelete.pm
    $Self->{Translation}->{'Config item "%s" not found in database!'} = '';
    $Self->{Translation}->{'Was not able to delete the configitem ID %s!'} = '';
    $Self->{Translation}->{'No version found for ConfigItemID %s!'} = '';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemEdit.pm
    $Self->{Translation}->{'No ConfigItemID, DuplicateID or ClassID is given!'} = '';
    $Self->{Translation}->{'No access is given!'} = '';
    $Self->{Translation}->{'No definition was defined for class %s!'} = '';

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
    $Self->{Translation}->{'VersionID %s not found in database!'} = '';
    $Self->{Translation}->{'ConfigItem'} = 'Kipengele cha usanidi';
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
    $Self->{Translation}->{'operational'} = '';
    $Self->{Translation}->{'warning'} = '';
    $Self->{Translation}->{'incident'} = '';
    $Self->{Translation}->{'The deployment state of this config item'} = 'Hali ya matumizi ya hii kipengele cha usanidi ';
    $Self->{Translation}->{'The incident state of this config item'} = 'Hali ya tukio ya hiki kipengele cha usanidi';

    # Perl Module: Kernel/Output/HTML/Dashboard/ITSMConfigItemGeneric.pm
    $Self->{Translation}->{'Shown config items'} = '';

    # Perl Module: Kernel/Output/HTML/ITSMConfigItem/LayoutDate.pm
    $Self->{Translation}->{'Between'} = 'Katikati';

    # Perl Module: Kernel/System/ImportExport/ObjectBackend/ITSMConfigItem.pm
    $Self->{Translation}->{'Maximum number of one element'} = 'Kima cha juu cha namba ya elementi mojawapo';
    $Self->{Translation}->{'Empty fields indicate that the current values are kept'} = 'Uga zilizowazi zinaonyesha kwamba thamani za sasa zimewekwa.';
    $Self->{Translation}->{'Skipped'} = 'Rukwa';

    # Perl Module: var/packagesetup/ITSMConfigurationManagement.pm
    $Self->{Translation}->{'Model'} = 'Mfano';
    $Self->{Translation}->{'Customer Company'} = '';
    $Self->{Translation}->{'Serial Number'} = 'Namba tambulishi';
    $Self->{Translation}->{'CPU'} = 'CPU';
    $Self->{Translation}->{'Ram'} = 'Ram';
    $Self->{Translation}->{'Hard Disk'} = 'Diski kuu';
    $Self->{Translation}->{'Capacity'} = 'Uwezo';
    $Self->{Translation}->{'Network Adapter'} = 'Adapta ya mtandao';
    $Self->{Translation}->{'IP over DHCP'} = 'IP kwa DHCP';
    $Self->{Translation}->{'IP Address'} = 'Anwani ya IP';
    $Self->{Translation}->{'Graphic Adapter'} = 'Adapta ya Mchoro';
    $Self->{Translation}->{'Other Equipment'} = 'Vifaa vingine';
    $Self->{Translation}->{'Warranty Expiration Date'} = 'Tarehe ya kuisha kw audhamini.';
    $Self->{Translation}->{'Install Date'} = 'Tarehe ya kusakinisha';
    $Self->{Translation}->{'Phone 1'} = 'Simu ya 1';
    $Self->{Translation}->{'Phone 2'} = 'Simu ya 2';
    $Self->{Translation}->{'E-Mail'} = '';
    $Self->{Translation}->{'Network Address'} = 'Anwani ya mtandao';
    $Self->{Translation}->{'Subnet Mask'} = 'Subnet mask';
    $Self->{Translation}->{'Gateway'} = 'Kichanganishi mtandao';
    $Self->{Translation}->{'Licence Type'} = 'Aina ya leseni';
    $Self->{Translation}->{'Licence Key'} = 'Neno kuu la leseni';
    $Self->{Translation}->{'Quantity'} = 'Wingi';
    $Self->{Translation}->{'Expiration Date'} = 'Tarehe ya mwisho';
    $Self->{Translation}->{'Media'} = 'Midia';

    # Database XML Definition: ITSMConfigurationManagement.sopm
    $Self->{Translation}->{'Computer'} = '';
    $Self->{Translation}->{'Hardware'} = '';
    $Self->{Translation}->{'Network'} = 'Mtandao';
    $Self->{Translation}->{'Software'} = '';
    $Self->{Translation}->{'Expired'} = 'Imeisha';
    $Self->{Translation}->{'Maintenance'} = 'Matengenezo';
    $Self->{Translation}->{'Pilot'} = 'Kwanza';
    $Self->{Translation}->{'Planned'} = 'Iliyopangwa';
    $Self->{Translation}->{'Repair'} = 'Rekebisha';
    $Self->{Translation}->{'Retired'} = 'Staafu';
    $Self->{Translation}->{'Review'} = 'Mapitio';
    $Self->{Translation}->{'Test/QA'} = 'Jaribio/ Maswali na Majibu';
    $Self->{Translation}->{'Laptop'} = 'Kompyuta ya mkononi';
    $Self->{Translation}->{'Desktop'} = 'Eneo kazi';
    $Self->{Translation}->{'PDA'} = 'PDA';
    $Self->{Translation}->{'Server'} = 'Seva';
    $Self->{Translation}->{'Other'} = 'Engine';
    $Self->{Translation}->{'Monitor'} = 'Monita';
    $Self->{Translation}->{'Printer'} = 'Kichapishi';
    $Self->{Translation}->{'Switch'} = 'Swichi';
    $Self->{Translation}->{'Router'} = 'Kipanga njia';
    $Self->{Translation}->{'WLAN Access Point'} = 'Kiungo ufikivu cha WLAN';
    $Self->{Translation}->{'Security Device'} = 'Kifaa cha ulinzi';
    $Self->{Translation}->{'Backup Device'} = 'Kifaa cha chelezo';
    $Self->{Translation}->{'Mouse'} = 'Kipanya';
    $Self->{Translation}->{'Keyboard'} = 'Boabonye';
    $Self->{Translation}->{'Camera'} = 'Kamera';
    $Self->{Translation}->{'Beamer'} = 'Projector';
    $Self->{Translation}->{'Modem'} = 'Modemu';
    $Self->{Translation}->{'PCMCIA Card'} = 'Kadi ya PCMCIA';
    $Self->{Translation}->{'USB Device'} = 'Kifaa cha USB';
    $Self->{Translation}->{'Docking Station'} = 'Kituo egeshi';
    $Self->{Translation}->{'Scanner'} = 'Kitambazo';
    $Self->{Translation}->{'Building'} = 'Jengo';
    $Self->{Translation}->{'Office'} = 'Ofisi';
    $Self->{Translation}->{'Floor'} = 'Sakafu';
    $Self->{Translation}->{'Room'} = 'Chumba';
    $Self->{Translation}->{'Rack'} = 'Rack';
    $Self->{Translation}->{'Workplace'} = 'Eneo la kazi';
    $Self->{Translation}->{'Outlet'} = 'Sehemu ya kutokea';
    $Self->{Translation}->{'IT Facility'} = 'P';
    $Self->{Translation}->{'LAN'} = 'LAN';
    $Self->{Translation}->{'WLAN'} = 'WLAN';
    $Self->{Translation}->{'Telco'} = 'Telco';
    $Self->{Translation}->{'GSM'} = 'GSM';
    $Self->{Translation}->{'Client Application'} = 'Programu-tumizi a mteja';
    $Self->{Translation}->{'Middleware'} = 'Middleware';
    $Self->{Translation}->{'Server Application'} = 'Seva ya programu-tumizi';
    $Self->{Translation}->{'Client OS'} = 'OS ya mteja';
    $Self->{Translation}->{'Server OS'} = 'OS ya seva';
    $Self->{Translation}->{'Admin Tool'} = 'Kifaa cha kiongozi';
    $Self->{Translation}->{'User Tool'} = 'Kifaa cha mtumiaji';
    $Self->{Translation}->{'Embedded'} = 'Pakichwa';
    $Self->{Translation}->{'Single Licence'} = 'Leseni moja';
    $Self->{Translation}->{'Per User'} = 'Kwa mtumiaji';
    $Self->{Translation}->{'Per Processor'} = 'Kwa kichakato';
    $Self->{Translation}->{'Per Server'} = 'Kwa seva';
    $Self->{Translation}->{'Per Node'} = 'Kwa fundo';
    $Self->{Translation}->{'Volume Licence'} = 'Leseni ya sauti';
    $Self->{Translation}->{'Enterprise Licence'} = 'Leseni ya Enterprie';
    $Self->{Translation}->{'Developer Licence'} = 'Leseni ya mtengenezaji';
    $Self->{Translation}->{'Demo'} = 'Onyesho';
    $Self->{Translation}->{'Time Restricted'} = 'Muda umezuiliwa';
    $Self->{Translation}->{'Freeware'} = 'Programu ya bure';
    $Self->{Translation}->{'Open Source'} = 'Chanzo cha wazi';
    $Self->{Translation}->{'Unlimited'} = 'Haina kikomo';

    # JS File: ITSM.Agent.ConfigItem.Zoom
    $Self->{Translation}->{'Ok'} = 'Sawa';

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

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

package Kernel::Language::it_ITSMConfigurationManagement;

use strict;
use warnings;
use utf8;

sub Data {
    my $Self = shift;

    # Template: AdminITSMConfigItem
    $Self->{Translation}->{'Config Item Management'} = 'Gestione degli elementi di configurazione';
    $Self->{Translation}->{'Change class definition'} = 'Modifica la definizione della classe';
    $Self->{Translation}->{'Config Item Class'} = 'Config Item Class';
    $Self->{Translation}->{'Definition'} = 'Definizione';
    $Self->{Translation}->{'Change'} = 'Modifica';

    # Template: AgentDashboardITSMConfigItemGeneric
    $Self->{Translation}->{'Incident State'} = 'Stato dell\'incidente';
    $Self->{Translation}->{'Deployment State'} = 'Stato di implementazione';
    $Self->{Translation}->{'Class'} = 'Classe';
    $Self->{Translation}->{'Deployment State Type'} = 'Tipo di stato di distribuzione';
    $Self->{Translation}->{'Current Incident State'} = 'Stato attuale dell\'incidente';
    $Self->{Translation}->{'Current Incident State Type'} = 'Tipo di stato dell\'incidente corrente';
    $Self->{Translation}->{'Last changed'} = 'Ultima modifica';

    # Template: AgentITSMConfigItemAdd
    $Self->{Translation}->{'Config Item'} = 'Elemento di configurazione';
    $Self->{Translation}->{'Filter for Classes'} = 'Filtro per classi';
    $Self->{Translation}->{'Select a Class from the list to create a new Config Item.'} = 'Selezionare una classe dall\'elenco per creare un nuovo elemento di configurazione.';

    # Template: AgentITSMConfigItemBulk
    $Self->{Translation}->{'ITSM ConfigItem Bulk Action'} = 'Azione in blocco di ITSM ConfigItem';
    $Self->{Translation}->{'Deployment state'} = 'Stato di distribuzione';
    $Self->{Translation}->{'Incident state'} = 'Stato dell\'incidente';
    $Self->{Translation}->{'Link to another'} = 'Collega a un altro';
    $Self->{Translation}->{'Invalid Configuration Item number!'} = 'Numero articolo di configurazione non valido!';
    $Self->{Translation}->{'The number of another Configuration Item to link with.'} = 'Il numero di un altro elemento di configurazione con cui collegarsi.';

    # Template: AgentITSMConfigItemDelete
    $Self->{Translation}->{'Do you really want to delete this config item?'} = 'Vuoi davvero eliminare questo elemento di configurazione?';

    # Template: AgentITSMConfigItemEdit
    $Self->{Translation}->{'The name of this config item'} = 'Il nome di questo elemento di configurazione';
    $Self->{Translation}->{'Name is already in use by the ConfigItems with the following Number(s): %s'} =
        'Il nome è già in uso da ConfigItems con i seguente/i numer(o)i: %s';

    # Template: AgentITSMConfigItemHistory
    $Self->{Translation}->{'History of Config Item: %s'} = 'Storia della voce di configurazione: %s';
    $Self->{Translation}->{'History Content'} = 'Contenuto dello storico';
    $Self->{Translation}->{'Createtime'} = 'Istante di creazione';
    $Self->{Translation}->{'Zoom view'} = 'Vista di Dettaglio';

    # Template: AgentITSMConfigItemOverviewNavBar
    $Self->{Translation}->{'Context Settings'} = 'Impostazioni di contesto';
    $Self->{Translation}->{'Config Items per page'} = 'Config. articoli per pagina';

    # Template: AgentITSMConfigItemOverviewSmall
    $Self->{Translation}->{'A generic ITSM Configuration Item table'} = 'Una tabella di elementi di configurazione ITSM generica';

    # Template: AgentITSMConfigItemSearch
    $Self->{Translation}->{'Run Search'} = 'Esegui ricerca';
    $Self->{Translation}->{'Also search in previous versions?'} = 'Cercare anche in versioni precedenti?';

    # Template: AgentITSMConfigItemZoom
    $Self->{Translation}->{'Configuration Item'} = 'Elemento di configurazione';
    $Self->{Translation}->{'Configuration Item Information'} = 'Informazioni sull\'elemento di configurazione';
    $Self->{Translation}->{'Current Deployment State'} = 'Stato attuale di implementazione';
    $Self->{Translation}->{'Last changed by'} = 'Ultima modifica di';
    $Self->{Translation}->{'Show one version'} = 'Mostra una versione';
    $Self->{Translation}->{'Show all versions'} = 'Mostra tutte le versioni';
    $Self->{Translation}->{'Version Incident State'} = 'Stato incidente versione';
    $Self->{Translation}->{'Version Deployment State'} = 'Stato di distribuzione della versione';
    $Self->{Translation}->{'Version Number'} = 'Numero di versione';
    $Self->{Translation}->{'Configuration Item Version Details'} = 'Dettagli della versione dell\'elemento di configurazione';
    $Self->{Translation}->{'Property'} = 'Proprietà';

    # Perl Module: Kernel/Modules/AgentITSMConfigItem.pm
    $Self->{Translation}->{'No access to Class is given!'} = 'Non è concesso l\'accesso alla classe!';
    $Self->{Translation}->{'Overview: ITSM ConfigItem'} = 'Panoramica: ITSM ConfigItem';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemBulk.pm
    $Self->{Translation}->{'No ConfigItemID is given!'} = 'Non viene fornito ConfigItemID!';
    $Self->{Translation}->{'You need at least one selected Configuration Item!'} = 'È necessario almeno un elemento di configurazione selezionato!';
    $Self->{Translation}->{'You don\'t have write access to this configuration item: %s.'} =
        'Non hai accesso in scrittura a questo elemento di configurazione: %s.';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemDelete.pm
    $Self->{Translation}->{'Config item "%s" not found in database!'} = 'Voce di configurazione "%s" non trovata nel database!';
    $Self->{Translation}->{'Was not able to delete the configitem ID %s!'} = 'Impossibile eliminare l\'ID di configurazione %s!';
    $Self->{Translation}->{'No version found for ConfigItemID %s!'} = 'Nessuna versione trovata per ConfigItemID %s!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemEdit.pm
    $Self->{Translation}->{'No ConfigItemID, DuplicateID or ClassID is given!'} = 'Non viene fornito ConfigItemID, DuplicateID o ClassID!';
    $Self->{Translation}->{'No access is given!'} = 'Nessun accesso è concesso!';
    $Self->{Translation}->{'No definition was defined for class %s!'} = 'Nessuna definizione è stata definita per la classe %s!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemHistory.pm
    $Self->{Translation}->{'Can\'t show history, no ConfigItemID is given!'} = 'Impossibile mostrare la cronologia, non viene fornito ConfigItemID!';
    $Self->{Translation}->{'Can\'t show history, no access rights given!'} = 'Impossibile mostrare la cronologia, nessun diritto di accesso concesso!';
    $Self->{Translation}->{'New ConfigItem (ID=%s)'} = 'Nuovo ConfigItem (ID =%s)';
    $Self->{Translation}->{'New version (ID=%s)'} = 'Nuova versione (ID =%s)';
    $Self->{Translation}->{'Deployment state updated (new=%s, old=%s)'} = 'Stato di distribuzione aggiornato (nuovo=%s, vecchio=%s)';
    $Self->{Translation}->{'Incident state updated (new=%s, old=%s)'} = 'Stato dell\'incidente aggiornato (nuovo=%s, vecchio= %s)';
    $Self->{Translation}->{'ConfigItem (ID=%s) deleted'} = 'ConfigItem (ID=%s) elimina';
    $Self->{Translation}->{'Link to %s (type=%s) added'} = 'Collegamento a %s (tipo=%s) aggiunta';
    $Self->{Translation}->{'Link to %s (type=%s) deleted'} = 'Collegamento a %s (tipo=%s) eliminata';
    $Self->{Translation}->{'ConfigItem definition updated (ID=%s)'} = 'Definizione di ConfigItem aggiornata (ID=%s)';
    $Self->{Translation}->{'Name updated (new=%s, old=%s)'} = 'Nome aggiornato (nuovo=%s, vecchio=%s)';
    $Self->{Translation}->{'Attribute %s updated from "%s" to "%s"'} = 'Attributo %s aggiornato da "%s" a "%s"';
    $Self->{Translation}->{'Version %s deleted'} = 'Versione %s eliminata';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemPrint.pm
    $Self->{Translation}->{'No ConfigItemID or VersionID is given!'} = 'Non viene fornito ConfigItemID o VersionID!';
    $Self->{Translation}->{'Can\'t show config item, no access rights given!'} = 'Impossibile mostrare l\'elemento di configurazione, nessun diritto di accesso concesso!';
    $Self->{Translation}->{'ConfigItemID %s not found in database!'} = 'ConfigItemID %s non trovato nel database!';
    $Self->{Translation}->{'VersionID %s not found in database!'} = 'VersionID %s non trovato nel database!';
    $Self->{Translation}->{'ConfigItem'} = 'ConfigItem';
    $Self->{Translation}->{'printed by %s at %s'} = 'stampato da %s a %s';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemSearch.pm
    $Self->{Translation}->{'Invalid ClassID!'} = 'ClassID non valido!';
    $Self->{Translation}->{'No ClassID is given!'} = 'Nessun ClassID è dato!';
    $Self->{Translation}->{'No access rights for this class given!'} = 'Nessun diritto di accesso per questa classe dato!';
    $Self->{Translation}->{'No Result!'} = 'Nessun risultato!';
    $Self->{Translation}->{'Config Item Search Results'} = 'Configura i risultati della ricerca degli elementi';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemZoom.pm
    $Self->{Translation}->{'Can\'t show item, no access rights for ConfigItem are given!'} =
        'Impossibile mostrare l\'elemento, non viene concesso alcun diritto di accesso per ConfigItem!';
    $Self->{Translation}->{'operational'} = 'operativo';
    $Self->{Translation}->{'warning'} = 'avvertimento';
    $Self->{Translation}->{'incident'} = 'incidente';
    $Self->{Translation}->{'The deployment state of this config item'} = 'Lo stato di implementazione di questo elemento di configurazione';
    $Self->{Translation}->{'The incident state of this config item'} = 'Lo stato di incidente di questo elemento di configurazione';

    # Perl Module: Kernel/Output/HTML/Dashboard/ITSMConfigItemGeneric.pm
    $Self->{Translation}->{'Shown config items'} = 'Elementi di configurazione mostrati';

    # Perl Module: Kernel/Output/HTML/ITSMConfigItem/LayoutDate.pm
    $Self->{Translation}->{'Between'} = 'fra';

    # Perl Module: Kernel/System/ImportExport/ObjectBackend/ITSMConfigItem.pm
    $Self->{Translation}->{'Maximum number of one element'} = 'Numero massimo di un elemento';
    $Self->{Translation}->{'Empty fields indicate that the current values are kept'} = 'I campi vuoti indicano che i valori correnti sono mantenuti';
    $Self->{Translation}->{'Skipped'} = 'Saltato';

    # Perl Module: var/packagesetup/ITSMConfigurationManagement.pm
    $Self->{Translation}->{'Model'} = 'Modello';
    $Self->{Translation}->{'Customer Company'} = 'Società cliente';
    $Self->{Translation}->{'Serial Number'} = 'Numero seriale';
    $Self->{Translation}->{'CPU'} = 'CPU';
    $Self->{Translation}->{'Ram'} = 'Ram';
    $Self->{Translation}->{'Hard Disk'} = 'Disco fisso';
    $Self->{Translation}->{'Capacity'} = 'Capacità';
    $Self->{Translation}->{'Network Adapter'} = 'Scheda di rete';
    $Self->{Translation}->{'IP over DHCP'} = 'IP su DHCP';
    $Self->{Translation}->{'IP Address'} = 'Indirizzo IP';
    $Self->{Translation}->{'Graphic Adapter'} = 'Scheda grafica';
    $Self->{Translation}->{'Other Equipment'} = 'Altri apparati';
    $Self->{Translation}->{'Warranty Expiration Date'} = 'Data di scadenza della garanzia';
    $Self->{Translation}->{'Install Date'} = 'Data di installazione';
    $Self->{Translation}->{'Phone 1'} = 'Telefono 1';
    $Self->{Translation}->{'Phone 2'} = 'Telefono 2';
    $Self->{Translation}->{'E-Mail'} = 'E-Mail';
    $Self->{Translation}->{'Network Address'} = 'Indirizzo di rete';
    $Self->{Translation}->{'Subnet Mask'} = 'Maschera di rete';
    $Self->{Translation}->{'Gateway'} = 'Gateway';
    $Self->{Translation}->{'Licence Type'} = 'Tipo di licenza';
    $Self->{Translation}->{'Licence Key'} = 'Chiave di licenza';
    $Self->{Translation}->{'Quantity'} = 'Quantità';
    $Self->{Translation}->{'Expiration Date'} = 'Data di scadenza';
    $Self->{Translation}->{'Media'} = 'Supporto';

    # Database XML Definition: ITSMConfigurationManagement.sopm
    $Self->{Translation}->{'Computer'} = 'Computer';
    $Self->{Translation}->{'Hardware'} = 'Hardware';
    $Self->{Translation}->{'Network'} = 'Rete';
    $Self->{Translation}->{'Software'} = 'Software';
    $Self->{Translation}->{'Expired'} = 'Scaduto';
    $Self->{Translation}->{'Maintenance'} = 'Manutenzione';
    $Self->{Translation}->{'Pilot'} = 'Pilot';
    $Self->{Translation}->{'Planned'} = 'Pianificato';
    $Self->{Translation}->{'Repair'} = 'Riparazione';
    $Self->{Translation}->{'Retired'} = 'Ritirato';
    $Self->{Translation}->{'Review'} = 'Revisionato';
    $Self->{Translation}->{'Test/QA'} = 'Test';
    $Self->{Translation}->{'Laptop'} = 'Portatile';
    $Self->{Translation}->{'Desktop'} = 'Desktop';
    $Self->{Translation}->{'PDA'} = 'Palmare';
    $Self->{Translation}->{'Server'} = 'Server';
    $Self->{Translation}->{'Other'} = 'Altro';
    $Self->{Translation}->{'Monitor'} = 'Monitor';
    $Self->{Translation}->{'Printer'} = 'Stampante';
    $Self->{Translation}->{'Switch'} = 'Switch';
    $Self->{Translation}->{'Router'} = 'Router';
    $Self->{Translation}->{'WLAN Access Point'} = 'WLAN Access Point';
    $Self->{Translation}->{'Security Device'} = 'Dispositivo di sicurezza';
    $Self->{Translation}->{'Backup Device'} = 'Dispositivo di copia';
    $Self->{Translation}->{'Mouse'} = 'Mouse';
    $Self->{Translation}->{'Keyboard'} = 'Tastiera';
    $Self->{Translation}->{'Camera'} = 'Videocamera';
    $Self->{Translation}->{'Beamer'} = 'Beamer';
    $Self->{Translation}->{'Modem'} = 'Modem';
    $Self->{Translation}->{'PCMCIA Card'} = 'Scheda PCMCIA';
    $Self->{Translation}->{'USB Device'} = 'Dispositivo USB';
    $Self->{Translation}->{'Docking Station'} = 'Docking Station';
    $Self->{Translation}->{'Scanner'} = 'Scanner';
    $Self->{Translation}->{'Building'} = 'Edificio';
    $Self->{Translation}->{'Office'} = 'Ufficio';
    $Self->{Translation}->{'Floor'} = 'Piano';
    $Self->{Translation}->{'Room'} = 'Stanza';
    $Self->{Translation}->{'Rack'} = 'Armadio';
    $Self->{Translation}->{'Workplace'} = 'Posto di lavoro';
    $Self->{Translation}->{'Outlet'} = 'Presa';
    $Self->{Translation}->{'IT Facility'} = 'Strumento IT';
    $Self->{Translation}->{'LAN'} = 'LAN';
    $Self->{Translation}->{'WLAN'} = 'WLAN';
    $Self->{Translation}->{'Telco'} = 'Telco';
    $Self->{Translation}->{'GSM'} = 'GSM';
    $Self->{Translation}->{'Client Application'} = 'Applicazione client';
    $Self->{Translation}->{'Middleware'} = 'Middleware';
    $Self->{Translation}->{'Server Application'} = 'Applicazione server';
    $Self->{Translation}->{'Client OS'} = 'SO Cliente';
    $Self->{Translation}->{'Server OS'} = 'SO server';
    $Self->{Translation}->{'Admin Tool'} = 'Strumenti di amministrazione';
    $Self->{Translation}->{'User Tool'} = 'Strumenti utente';
    $Self->{Translation}->{'Embedded'} = 'Integrato';
    $Self->{Translation}->{'Single Licence'} = 'Licenza singola';
    $Self->{Translation}->{'Per User'} = 'Per utente';
    $Self->{Translation}->{'Per Processor'} = 'Per processore';
    $Self->{Translation}->{'Per Server'} = 'Per server';
    $Self->{Translation}->{'Per Node'} = 'Per nodo';
    $Self->{Translation}->{'Volume Licence'} = 'Licenza per volume';
    $Self->{Translation}->{'Enterprise Licence'} = 'Licenza aziendale';
    $Self->{Translation}->{'Developer Licence'} = 'Licenza di sviluppo';
    $Self->{Translation}->{'Demo'} = 'Dimostrativo';
    $Self->{Translation}->{'Time Restricted'} = 'Limitata nel tempo';
    $Self->{Translation}->{'Freeware'} = 'Freeware';
    $Self->{Translation}->{'Open Source'} = 'Open Source';
    $Self->{Translation}->{'Unlimited'} = 'Illimitata';

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

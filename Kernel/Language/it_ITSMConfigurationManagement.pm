# --
# OTOBO is a web-based ticketing system for service organisations.
# --
# Copyright (C) 2001-2020 OTRS AG, https://otrs.com/
# Copyright (C) 2019-2026 Rother OSS GmbH, https://otobo.io/
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

    # Template: AdminGenericInterfaceOperationConfigItem
    $Self->{Translation}->{'General operation data'} = 'Dati generali di funzionamento';
    $Self->{Translation}->{'Settings for incoming request data'} = 'Impostazioni per i dati di richiesta in entrata';
    $Self->{Translation}->{'Settings for outgoing response data'} = 'Impostazioni per i dati di risposta in uscita';

    # Template: AdminITSMConfigItem
    $Self->{Translation}->{'Config Item Management'} = 'Gestione degli elementi di configurazione';
    $Self->{Translation}->{'Change class definition'} = 'Modifica la definizione della classe';
    $Self->{Translation}->{'Change role definition'} = 'Modifica della definizione del ruolo';
    $Self->{Translation}->{'Ready2Import Class Bundles'} = 'Pacchetti di classi Ready2Import';
    $Self->{Translation}->{'Here you can import Ready2Import class bundles showcasing our most usual config items. Please note that some additional configuration may be required.'} =
        'Qui è possibile importare i pacchetti di classi Ready2Import, che presentano gli elementi di configurazione più comuni. Si noti che potrebbero essere necessarie alcune configurazioni aggiuntive.';
    $Self->{Translation}->{'Update existing entities'} = 'Aggiornare le entità esistenti';
    $Self->{Translation}->{'Import Ready2Adopt class bundles'} = 'Importare i bundle della classe Ready2Adopt';
    $Self->{Translation}->{'Config Item Class'} = 'Config Item Class';
    $Self->{Translation}->{'Config Item Role'} = 'Config Voce Ruolo';

    # Template: AgentITSMConfigItemAdd
    $Self->{Translation}->{'Config Item'} = 'Elemento di configurazione';
    $Self->{Translation}->{'Filter for Classes'} = 'Filtro per classi';
    $Self->{Translation}->{'Select a Class from the list to create a new Config Item.'} = 'Selezionare una classe dall\'elenco per creare un nuovo elemento di configurazione.';
    $Self->{Translation}->{'Class'} = 'Classe';

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
    $Self->{Translation}->{'Version Number'} = 'Numero di versione';
    $Self->{Translation}->{'Version number of this config item'} = 'Numero di versione di questo elemento di configurazione';
    $Self->{Translation}->{'Version Number is already in use by the ConfigItems with the following Number(s): %s'} =
        'Il numero di versione è già utilizzato dai ConfigItem con il seguente numero: %s';
    $Self->{Translation}->{'Deployment State'} = 'Stato di implementazione';
    $Self->{Translation}->{'Incident State'} = 'Stato dell\'incidente';

    # Template: AgentITSMConfigItemHistory
    $Self->{Translation}->{'History of Config Item: %s'} = 'Storia della voce di configurazione: %s';
    $Self->{Translation}->{'History Content'} = 'Contenuto dello storico';
    $Self->{Translation}->{'Createtime'} = 'Istante di creazione';
    $Self->{Translation}->{'Zoom view'} = 'Vista di Dettaglio';

    # Template: AgentITSMConfigItemOverviewNavBar
    $Self->{Translation}->{'Config Items per page'} = 'Config. articoli per pagina';

    # Template: AgentITSMConfigItemOverviewSmall
    $Self->{Translation}->{'No config item data found.'} = 'Nessun dato di configurazione trovato.';
    $Self->{Translation}->{'Select this config item'} = 'Selezionare questa voce di configurazione';

    # Template: AgentITSMConfigItemSearch
    $Self->{Translation}->{'Run Search'} = 'Esegui ricerca';
    $Self->{Translation}->{'Also search in previous versions?'} = 'Cercare anche in versioni precedenti?';

    # Template: AgentITSMConfigItemTreeView
    $Self->{Translation}->{'TreeView for ConfigItem'} = 'Visualizzazione ad albero per ConfigItem';
    $Self->{Translation}->{'Depth Level'} = 'Livello di profondità';
    $Self->{Translation}->{'Zoom In/Out'} = 'Zoom avanti/indietro';
    $Self->{Translation}->{'Max links level reached for ConfigItem!'} = 'Livello massimo di collegamenti raggiunto per ConfigItem!';

    # Template: AgentITSMConfigItemZoom
    $Self->{Translation}->{'Configuration Item'} = 'Elemento di configurazione';
    $Self->{Translation}->{'Configuration Item Information'} = 'Informazioni sull\'elemento di configurazione';
    $Self->{Translation}->{'Current Deployment State'} = 'Stato attuale di implementazione';
    $Self->{Translation}->{'Current Incident State'} = 'Stato attuale dell\'incidente';
    $Self->{Translation}->{'Last changed'} = 'Ultima modifica';
    $Self->{Translation}->{'Last changed by'} = 'Ultima modifica di';

    # Template: CustomerITSMConfigItem
    $Self->{Translation}->{'Your ConfigItems'} = 'I vostri elementi di configurazione';

    # Template: CustomerITSMConfigItemSearch
    $Self->{Translation}->{'ConfigItem Search'} = 'Ricerca di ConfigItem';

    # Template: AdminACL
    $Self->{Translation}->{'Object Type'} = 'Tipo di oggetto';

    # Template: AdminDynamicFieldScreen
    $Self->{Translation}->{'Filter by object type'} = '';

    # JS Template: ClassImportConfirm
    $Self->{Translation}->{'The following classes will be imported'} = 'Verranno importate le seguenti classi';
    $Self->{Translation}->{'The following roles will be imported'} = 'Verranno importati i seguenti ruoli';
    $Self->{Translation}->{'Note that also corresponding dynamic fields and GeneralCatalog classes will be created and there is no automatic removal.'} =
        'Si noti che verranno creati anche i campi dinamici e le classi GeneralCatalog corrispondenti e non è prevista la rimozione automatica.';
    $Self->{Translation}->{'Do you want to proceed?'} = 'Vuoi continuare?';

    # Perl Module: Kernel/Modules/AdminITSMConfigItem.pm
    $Self->{Translation}->{'Need ExampleClasses!'} = 'Servono classi di esempio!';
    $Self->{Translation}->{'Definition is no valid YAML hash.'} = 'La definizione non è un hash YAML valido.';

    # Perl Module: Kernel/Modules/AgentITSMConfigItem.pm
    $Self->{Translation}->{'Overview: ITSM ConfigItem'} = 'Panoramica: ITSM ConfigItem';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemBulk.pm
    $Self->{Translation}->{'No ConfigItemID is given!'} = 'Non viene fornito ConfigItemID!';
    $Self->{Translation}->{'You need at least one selected Configuration Item!'} = 'È necessario almeno un elemento di configurazione selezionato!';
    $Self->{Translation}->{'You don\'t have write access to this configuration item: %s.'} =
        'Non hai accesso in scrittura a questo elemento di configurazione: %s.';
    $Self->{Translation}->{'No definition was defined for class %s!'} = 'Nessuna definizione è stata definita per la classe %s!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemDelete.pm
    $Self->{Translation}->{'Config item "%s" not found in database!'} = 'Voce di configurazione "%s" non trovata nel database!';
    $Self->{Translation}->{'Was not able to delete the configitem ID %s!'} = 'Impossibile eliminare l\'ID di configurazione %s!';
    $Self->{Translation}->{'No version found for ConfigItemID %s!'} = 'Nessuna versione trovata per ConfigItemID %s!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemEdit.pm
    $Self->{Translation}->{'No ConfigItemID, DuplicateID or ClassID is given!'} = 'Non viene fornito ConfigItemID, DuplicateID o ClassID!';
    $Self->{Translation}->{'No access is given!'} = 'Nessun accesso è concesso!';

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
    $Self->{Translation}->{'File "%s" uploaded'} = '';
    $Self->{Translation}->{'File "%s" removed'} = '';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemPrint.pm
    $Self->{Translation}->{'No ConfigItemID or VersionID is given!'} = 'Non viene fornito ConfigItemID o VersionID!';
    $Self->{Translation}->{'Can\'t show config item, no access rights given!'} = 'Impossibile mostrare l\'elemento di configurazione, nessun diritto di accesso concesso!';
    $Self->{Translation}->{'ConfigItemID %s not found in database!'} = 'ConfigItemID %s non trovato nel database!';
    $Self->{Translation}->{'ConfigItem'} = 'ConfigItem';
    $Self->{Translation}->{'printed by %s at %s'} = 'stampato da %s a %s';
    $Self->{Translation}->{'Referenced by'} = '';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemSearch.pm
    $Self->{Translation}->{'Invalid ClassID!'} = 'ClassID non valido!';
    $Self->{Translation}->{'No ClassID is given!'} = 'Nessun ClassID è dato!';
    $Self->{Translation}->{'No access rights for this class given!'} = 'Nessun diritto di accesso per questa classe dato!';
    $Self->{Translation}->{'No Result!'} = 'Nessun risultato!';
    $Self->{Translation}->{'Config Item Search Results'} = 'Configura i risultati della ricerca degli elementi';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemZoom.pm
    $Self->{Translation}->{'Can\'t show item, no access rights for ConfigItem are given!'} =
        'Impossibile mostrare l\'elemento, non viene concesso alcun diritto di accesso per ConfigItem!';
    $Self->{Translation}->{'ConfigItem not found!'} = 'ConfigItem non trovato!';
    $Self->{Translation}->{'No versions found!'} = 'Nessuna versione trovata!';
    $Self->{Translation}->{'operational'} = 'operativo';
    $Self->{Translation}->{'warning'} = 'avvertimento';
    $Self->{Translation}->{'incident'} = 'incidente';
    $Self->{Translation}->{'The deployment state of this config item'} = 'Lo stato di implementazione di questo elemento di configurazione';
    $Self->{Translation}->{'The incident state of this config item'} = 'Lo stato di incidente di questo elemento di configurazione';

    # Perl Module: Kernel/Modules/CustomerITSMConfigItemSearch.pm
    $Self->{Translation}->{'No permission'} = 'Nessun permesso';
    $Self->{Translation}->{'Filter invalid!'} = 'Filtro non valido!';
    $Self->{Translation}->{'Search params invalid!'} = 'Parametri di ricerca non validi!';

    # Perl Module: Kernel/Output/HTML/Dashboard/ITSMConfigItemGeneric.pm
    $Self->{Translation}->{'Shown config items'} = 'Elementi di configurazione mostrati';
    $Self->{Translation}->{'Deployment State Type'} = 'Tipo di stato di distribuzione';
    $Self->{Translation}->{'Current Incident State Type'} = 'Tipo di stato dell\'incidente corrente';

    # Perl Module: Kernel/Output/HTML/ITSMConfigItem/LayoutDate.pm
    $Self->{Translation}->{'Between'} = 'fra';

    # Perl Module: Kernel/System/DynamicField/Driver/ConfigItem.pm
    $Self->{Translation}->{'Class restrictions for the config item'} = 'Restrizioni di classe per l\'elemento di configurazione';
    $Self->{Translation}->{'Select one or more classes to restrict selectable config items'} =
        'Selezionare una o più classi per limitare gli elementi di configurazione selezionabili';
    $Self->{Translation}->{'Deployment state restrictions for the config item'} = '';
    $Self->{Translation}->{'Select one or more deployment states to restrict selectable config items'} =
        '';
    $Self->{Translation}->{'Dynamic (ConfigItem)'} = 'Dinamico (ConfigItem)';
    $Self->{Translation}->{'Static (Version)'} = 'Statica (versione)';
    $Self->{Translation}->{'Link Referencing Type'} = 'Tipo di riferimento del collegamento';
    $Self->{Translation}->{'Whether this link applies to the ConfigItem or the static version of the referencing object. Current Incident State calculation only is performed on dynamic links.'} =
        'Se questo collegamento si applica al ConfigItem o alla versione statica dell\'oggetto di riferimento. Il calcolo dello Stato corrente dell\'incidente viene eseguito solo sui collegamenti dinamici.';
    $Self->{Translation}->{'Select the attribute which config items will be searched by'} = 'Selezionare l\'attributo in base al quale gli elementi della configurazione verranno ricercati';

    # Perl Module: Kernel/System/ITSMConfigItem/Definition.pm
    $Self->{Translation}->{'Base structure is not valid. Please provide a hash with data in YAML format.'} =
        'La struttura di base non è valida. Fornire un hash con i dati in formato YAML.';
    $Self->{Translation}->{'Starting the YAML string with \'---\' is required.'} = 'È necessario iniziare la stringa YAML con \'---\'.';

    # Perl Module: Kernel/System/ITSMConfigItem/Link.pm
    $Self->{Translation}->{'Could not purge the table configitem_link.'} = 'Impossibile eliminare la tabella configitem_link.';
    $Self->{Translation}->{'No relevant dynamic fields were found'} = 'Non sono stati trovati campi dinamici rilevanti';
    $Self->{Translation}->{'Could not insert into the table configitem_link'} = 'Impossibile inserire nella tabella configitem_link';
    $Self->{Translation}->{'Inserted 0 rows into the table configitem_link'} = 'Inserite 0 righe nella tabella configitem_link';

    # Perl Module: Kernel/System/ImportExport/ObjectBackend/ITSMConfigItem.pm
    $Self->{Translation}->{'Maximum number of one element'} = 'Numero massimo di un elemento';
    $Self->{Translation}->{'Maximum number of one Set dynamic field element'} = '';
    $Self->{Translation}->{'Maximum number of one element within a Set dynamic field element'} =
        '';
    $Self->{Translation}->{'Import/Export attachments (as the last entries per line)'} = 'Importazione/esportazione di allegati (come ultime voci per riga)';
    $Self->{Translation}->{'Version String'} = 'Versione Stringa';

    # Perl Module: Kernel/Modules/AdminDynamicField.pm
    $Self->{Translation}->{'Error synchronizing the definitions. Please check the log.'} = 'Errore nella sincronizzazione delle definizioni. Controllare il registro.';
    $Self->{Translation}->{'You have ITSMConfigItem definitions which are not synchronized. Please deploy your ITSMConfigItem dynamic field changes.'} =
        'Le definizioni di ITSMConfigItem non sono sincronizzate. Distribuire le modifiche ai campi dinamici di ITSMConfigItem.';

    # Database XML / SOPM Definition: ITSMConfigurationManagement.sopm
    $Self->{Translation}->{'Expired'} = 'Scaduto';
    $Self->{Translation}->{'Maintenance'} = 'Manutenzione';
    $Self->{Translation}->{'Pilot'} = 'Pilot';
    $Self->{Translation}->{'Planned'} = 'Pianificato';
    $Self->{Translation}->{'Repair'} = 'Riparazione';
    $Self->{Translation}->{'Retired'} = 'Ritirato';
    $Self->{Translation}->{'Review'} = 'Revisionato';
    $Self->{Translation}->{'Test/QA'} = 'Test';

    # JS File: ITSM.Admin.ITSMConfigItem
    $Self->{Translation}->{'Overview and Confirmation'} = 'Panoramica e conferma';
    $Self->{Translation}->{'Importing classes/roles and their related fields'} = 'Importazione di classi/ruoli e dei relativi campi';
    $Self->{Translation}->{'An error occurred during class import.'} = 'Si è verificato un errore durante l\'importazione della classe.';

    # SysConfig
    $Self->{Translation}->{'0 - Hidden'} = '0 - Nascosto';
    $Self->{Translation}->{'1 - Shown'} = '1 - Mostrato';
    $Self->{Translation}->{'A mapping of inner field names used in the Process Management TransitionActions ConfigItemAdd and -Update. The keys are the names of the set inner fields of the set with object type ticket which will be used to create/update the CI, and the values are the names of the inner fields of the set with object type ITSMConfigItem.'} =
        '';
    $Self->{Translation}->{'Allows extended search conditions in config item search of the agent interface. With this feature you can search e. g. config item name with this kind of conditions like "(*key1*&&*key2*)" or "(*key1*||*key2*)".'} =
        'Consente condizioni di ricerca estese nella ricerca degli elementi di configurazione dell\'interfaccia dell\'agente. Con questa funzione è possibile cercare, ad esempio, il nome dell\'elemento di configurazione con condizioni del tipo "(*key1*&&*key2*)" o "(*key1*||*key2*)".';
    $Self->{Translation}->{'Allows extended search conditions in config item search of the customer interface. With this feature you can search e. g. config item name with this kind of conditions like "(*key1*&&*key2*)" or "(*key1*||*key2*)".'} =
        'Consente condizioni di ricerca estese nella ricerca degli elementi di configurazione dell\'interfaccia cliente. Con questa funzione è possibile cercare, ad esempio, il nome dell\'elemento di configurazione con condizioni del tipo "(*key1*&&*key2*)" o "(*key1*||*key2*)".';
    $Self->{Translation}->{'Assigned CIs'} = 'CIs assegnati';
    $Self->{Translation}->{'At a specific time point create a ticket for config items, if the configured requirements are met. The time point is determined by the value of the dynamic field of type date configured under "TimeCIKey" of the ConfigItem, and modified by "TimeModifier". If the latter can be either just a number, or a sign (+/-), a number, and an unit (d/h/m): "7" is equivalent to "+7d". The DynamicField "Ticket->DynamicField" will be used to mark created tickets - it has to exist. The flags \<OTOBO_CONFIGITEM_X\> where X can be NAME, NUMBER and DATE, will be substituted with the respective values in "Ticket->Text".'} =
        '';
    $Self->{Translation}->{'Attributes for license accounting.'} = '';
    $Self->{Translation}->{'Attributes for licenses counting, where "TotalLicensesDF", "AvailableLicensesDF" and "LicenseReferenceDF" are the names of the dynamic fields used to track the remaining licenses. If used, only deployment states in "ValidDeplStates" are considered. If a threshold is defined in "MinimumLicenses", a ticket will automatically be created if less licenses are available. For this, the checkbox dynamic field "Ticket->DynamicField" must exist. The tags \<OTOBO_CONFIGITEM_X\> where X can be NAME, NUMBER, LICENSES_AVAIL and LICENSES_MIN, will be substituted with the respective values in "Ticket->Text" by the config item name, number, available licenses, and minimum required available licenses, respectively.'} =
        '';
    $Self->{Translation}->{'CIs assigned to customer company'} = 'CIs assegnati alla società cliente';
    $Self->{Translation}->{'CIs assigned to customer user'} = 'CIs assegnati all\'utenza cliente';
    $Self->{Translation}->{'CMDB Settings'} = 'Impostazioni CMDB';
    $Self->{Translation}->{'Check for a unique name only within the same ConfigItem class (\'class\') or globally (\'global\'), which means every existing ConfigItem is taken into account when looking for duplicates.'} =
        'Cerca un nome univoco solo all\'interno della stessa classe ConfigItem (\'class\') o globalmente (\'global\'), il che significa che ogni ConfigItem esistente viene preso in considerazione quando si cercano duplicati.';
    $Self->{Translation}->{'Choose a module to enforce a naming scheme.'} = 'Scegliere un modulo per applicare uno schema di denominazione.';
    $Self->{Translation}->{'Choose a module to enforce a number scheme.'} = 'Scegliere un modulo per applicare uno schema numerico.';
    $Self->{Translation}->{'Choose a module to enforce a version string scheme.'} = 'Scegliere un modulo per applicare uno schema di stringhe di versione.';
    $Self->{Translation}->{'Choose attributes to trigger the creation of a new version.'} = 'Scegliere gli attributi per attivare la creazione di una nuova versione.';
    $Self->{Translation}->{'Choose categories to assign to this config item class.'} = 'Scegliere le categorie da assegnare a questa classe di elementi di configurazione.';
    $Self->{Translation}->{'Column config item filters for ConfigItem Overview.'} = 'Filtri per gli elementi di configurazione della colonna per la panoramica di ConfigItem.';
    $Self->{Translation}->{'Columns that can be filtered in the config item overview of the agent interface. Note: Only Config Item attributes and Dynamic Fields (DynamicField_NameX) are allowed.'} =
        'Colonne che possono essere filtrate nella panoramica degli elementi di configurazione dell\'interfaccia agente. Nota: Sono ammessi solo gli attributi degli elementi di configurazione e i campi dinamici (DynamicField_NameX).';
    $Self->{Translation}->{'Config Items'} = 'Elementi di configurazione';
    $Self->{Translation}->{'Config item add.'} = 'Aggiungi elemento di configurazione.';
    $Self->{Translation}->{'Config item edit.'} = 'Modifica elemento di configurazione.';
    $Self->{Translation}->{'Config item event module that enables accounting licenses for a given config item.'} =
        '';
    $Self->{Translation}->{'Config item event module that enables logging to history in the agent interface.'} =
        'Modulo eventi elemento di configurazione che consente la registrazione nella cronologia nell\'interfaccia agenti.';
    $Self->{Translation}->{'Config item event module that updates config items to their current definition.'} =
        'Modulo evento per gli elementi di configurazione che aggiorna gli elementi di configurazione alla loro definizione corrente.';
    $Self->{Translation}->{'Config item history.'} = 'Configura cronologia articoli.';
    $Self->{Translation}->{'Config item print.'} = 'Stampa elemento di configurazione.';
    $Self->{Translation}->{'Config item zoom.'} = 'Configura lo zoom dell\'oggetto.';
    $Self->{Translation}->{'ConfigItem Tree View'} = 'Vista ad albero ConfigItem';
    $Self->{Translation}->{'ConfigItem Version'} = 'ConfigItem Versione';
    $Self->{Translation}->{'ConfigItems of the following classes will not be stored on the Elasticsearch server. To apply this to existing CIs, the CI migration has to be run via console, after changing this option.'} =
        'I ConfigItem delle seguenti classi non saranno memorizzati sul server Elasticsearch. Per applicare questo ai CI esistenti, è necessario eseguire la migrazione del CI tramite la console, dopo aver modificato questa opzione.';
    $Self->{Translation}->{'ConfigItems with the following deployment states will not be stored on the Elasticsearch server. To apply this to existing CIs, the CI migration has to be run via console, after changing this option.'} =
        'I ConfigItem con i seguenti stati di distribuzione non saranno memorizzati sul server Elasticsearch. Per applicare questo ai CI esistenti, è necessario eseguire la migrazione del CI tramite la console, dopo aver modificato questa opzione.';
    $Self->{Translation}->{'Configuration Item Limit'} = 'Limite elemento di configurazione';
    $Self->{Translation}->{'Configuration Item limit per page.'} = 'Limite elemento di configurazione per pagina.';
    $Self->{Translation}->{'Configuration Management Database.'} = 'Database di gestione della configurazione.';
    $Self->{Translation}->{'Configuration item bulk module.'} = 'Modulo di massa elemento di configurazione.';
    $Self->{Translation}->{'Configuration item search backend router of the agent interface.'} =
        'Voce di configurazione ricerca router backend dell\'interfaccia agente.';
    $Self->{Translation}->{'Configure the columns which are available for viewing Permission Conditions in the customer interface, when the corresponding Permission Condition Columns are not specifically configured. This setting is used as a fallback for the other Permission Condition Columns settings.'} =
        '';
    $Self->{Translation}->{'Configure the columns which are available when viewing the corresponding Permission Condition in the customer interface.'} =
        '';
    $Self->{Translation}->{'Create and manage the definitions for Configuration Items.'} = 'Crea e gestisci le definizioni per gli elementi di configurazione.';
    $Self->{Translation}->{'Creates Tickets for ConfigItems at specific time points.'} = 'Crea biglietti per i ConfigItem in momenti specifici.';
    $Self->{Translation}->{'Customers can see historic CI versions.'} = 'I clienti possono vedere le versioni storiche dei CI.';
    $Self->{Translation}->{'Customers have the possibility to manually switch between historic CI versions.'} =
        'I clienti hanno la possibilità di passare manualmente tra le versioni storiche di CI.';
    $Self->{Translation}->{'Default data to use on attribute for config item search screen. Example: "ITSMConfigItemCreateTimePointFormat=year;ITSMConfigItemCreateTimePointStart=Last;ITSMConfigItemCreateTimePoint=2;".'} =
        'Dati predefiniti da usare nell\'attributo per la schermata di ricerca degli elementi di configurazione. Esempio: "ITSMConfigItemCreateTimePointFormat=anno;ITSMConfigItemCreateTimePointStart=ultimo;ITSMConfigItemCreateTimePoint=2;".';
    $Self->{Translation}->{'Default data to use on attribute for config item search screen. Example: "ITSMConfigItemCreateTimeStartYear=2010;ITSMConfigItemCreateTimeStartMonth=10;ITSMConfigItemCreateTimeStartDay=4;ITSMConfigItemCreateTimeStopYear=2010;ITSMConfigItemCreateTimeStopMonth=11;ITSMConfigItemCreateTimeStopDay=3;".'} =
        'Dati predefiniti da usare nell\'attributo per la schermata di ricerca degli elementi di configurazione. Esempio: "ITSMConfigItemCreateTimeStartYear=2010;ITSMConfigItemCreateTimeStartMonth=10;ITSMConfigItemCreateTimeStartDay=4;ITSMConfigItemCreateTimeStopYear=2010;ITSMConfigItemCreateTimeStopMonth=11;ITSMConfigItemCreateTimeStopDay=3;".';
    $Self->{Translation}->{'Define Actions where a settings button is available in the linked objects widget (LinkObject::ViewMode = "complex"). Please note that these Actions must have registered the following JS and CSS files: Core.AllocationList.css, Core.UI.AllocationList.js, Core.UI.Table.Sort.js, Core.Agent.TableFilters.js and Core.Agent.LinkObject.js.'} =
        'Definire le azioni in cui è disponibile un pulsante di impostazione nel widget degli oggetti collegati (LinkObject::ViewMode = "complex"). Si noti che queste azioni devono aver registrato i seguenti file JS e CSS: Core.AllocationList.css, Core.UI.AllocationList.js, Core.UI.Table.Sort.js, Core.Agent.TableFilters.js e Core.Agent.LinkObject.js.';
    $Self->{Translation}->{'Define a Template::Toolkit scheme for version strings. Only used if Version String Module is set to TemplateToolkit.'} =
        'Definisce uno schema Template::Toolkit per le stringhe di versione. Utilizzato solo se il modulo Stringa di versione è impostato su TemplateToolkit.';
    $Self->{Translation}->{'Define a set of conditions under which a customer is allowed to see a config item. Conditions can optionally be restricted to certain customer groups. Name is the only mandatory attribute. If no other options are given, all config items will be visible under that category.'} =
        'Definire un insieme di condizioni in base alle quali un cliente può vedere un elemento della configurazione. Le condizioni possono essere facoltativamente limitate a determinati gruppi di clienti. Il nome è l\'unico attributo obbligatorio. Se non vengono fornite altre opzioni, tutti gli elementi di configurazione saranno visibili sotto quella categoria.';
    $Self->{Translation}->{'Defines Required permissions to delete ITSM configuration items using the Generic Interface.'} =
        'Definisce i permessi necessari per eliminare gli elementi di configurazione ITSM utilizzando l\'interfaccia generica.';
    $Self->{Translation}->{'Defines Required permissions to get ITSM configuration items using the Generic Interface.'} =
        'Definisce i permessi necessari per ottenere gli elementi di configurazione ITSM utilizzando l\'interfaccia generica.';
    $Self->{Translation}->{'Defines Required permissions to search ITSM configuration items using the Generic Interface.'} =
        'Definisce i permessi necessari per la ricerca degli elementi di configurazione ITSM utilizzando l\'interfaccia generica.';
    $Self->{Translation}->{'Defines Required permissions to set ITSM configuration items using the Generic Interface.'} =
        'Definisce le autorizzazioni necessarie per impostare gli elementi di configurazione ITSM utilizzando l\'interfaccia generica.';
    $Self->{Translation}->{'Defines an overview module to show the small view of a configuration item list.'} =
        'Definisce un modulo di panoramica per mostrare la vista ridotta di un elenco di elementi di configurazione.';
    $Self->{Translation}->{'Defines if the link type labels must be shown in the node connections.'} =
        'Definisce se le etichette del tipo di collegamento devono essere mostrate nelle connessioni dei nodi.';
    $Self->{Translation}->{'Defines regular expressions individually for each ConfigItem class to check the ConfigItem name and to show corresponding error messages.'} =
        'Definisce le espressioni regolari singolarmente per ciascuna classe ConfigItem per controllare il nome ConfigItem e mostrare i messaggi di errore corrispondenti.';
    $Self->{Translation}->{'Defines the available columns of CIs in the config item overview depending on the CI class. Each entry must consist of a class name and an array of available fields for the corresponding class. Dynamic field entries have to honor the scheme DynamicField_FieldName.'} =
        'Definisce le colonne disponibili dei CI nella panoramica degli elementi di configurazione, a seconda della classe del CI. Ogni voce deve essere composta da un nome di classe e da un array di campi disponibili per la classe corrispondente. Le voci dei campi dinamici devono rispettare lo schema DynamicField_FieldName.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of the agent interface.'} =
        'Definisce l\'attributo predefinito dell\'elemento di configurazione per l\'ordinamento degli elementi di configurazione del risultato della ricerca degli elementi di configurazione dell\'interfaccia agente.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of the customer interface.'} =
        'Definisce l\'attributo predefinito dell\'elemento di configurazione per l\'ordinamento dell\'elemento di configurazione nel risultato della ricerca dell\'elemento di configurazione dell\'interfaccia cliente.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of this operation.'} =
        'Definisce l\'attributo predefinito dell\'elemento di configurazione per l\'ordinamento dell\'elemento di configurazione del risultato della ricerca dell\'elemento di configurazione di questa operazione.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the agent interface. Up: oldest on top. Down: latest on top.'} =
        'Definisce l\'ordine predefinito degli elementi di configurazione nel risultato della ricerca degli elementi di configurazione dell\'interfaccia agente. Su: il più vecchio in cima. Giù: l\'ultimo in cima.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the customer interface. Up: oldest on top. Down: latest on top.'} =
        'Definisce l\'ordine predefinito degli elementi di configurazione nel risultato della ricerca degli elementi di configurazione dell\'interfaccia cliente. Su: il più vecchio in cima. Giù: il più recente in cima.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the this operation. Up: oldest on top. Down: latest on top.'} =
        'Definisce l\'ordine predefinito degli elementi di configurazione nel risultato della ricerca degli elementi di configurazione di questa operazione. Su: il più vecchio in cima. Giù: l\'ultimo in cima.';
    $Self->{Translation}->{'Defines the default displayed columns of CIs in the config item overview depending on the CI class. Each entry must consist of a class name and an array of available fields for the corresponding class. Dynamic field entries have to honor the scheme DynamicField_FieldName.'} =
        'Definisce le colonne predefinite dei CI nella panoramica degli elementi di configurazione, a seconda della classe del CI. Ogni voce deve essere composta da un nome di classe e da un array di campi disponibili per la classe corrispondente. Le voci dei campi dinamici devono rispettare lo schema DynamicField_FieldName.';
    $Self->{Translation}->{'Defines the default relations depth to be shown.'} = 'Definisce la profondità predefinita delle relazioni da mostrare.';
    $Self->{Translation}->{'Defines the default shown config item search attribute for config item search screen.'} =
        'Definisce l\'attributo predefinito di ricerca degli elementi di configurazione per la schermata di ricerca degli elementi di configurazione.';
    $Self->{Translation}->{'Defines the default shown config item search attribute for config item search screen. Example: "Key" must have the name of the Dynamic Field in this case \'X\', "Content" must have the value of the Dynamic Field depending on the Dynamic Field type,  Text: \'a text\', Dropdown: \'1\', Date/Time: \'Search_DynamicField_XTimeSlotStartYear=1974; Search_DynamicField_XTimeSlotStartMonth=01; Search_DynamicField_XTimeSlotStartDay=26; Search_DynamicField_XTimeSlotStartHour=00; Search_DynamicField_XTimeSlotStartMinute=00; Search_DynamicField_XTimeSlotStartSecond=00; Search_DynamicField_XTimeSlotStopYear=2013; Search_DynamicField_XTimeSlotStopMonth=01; Search_DynamicField_XTimeSlotStopDay=26; Search_DynamicField_XTimeSlotStopHour=23; Search_DynamicField_XTimeSlotStopMinute=59; Search_DynamicField_XTimeSlotStopSecond=59;\' and or \'Search_DynamicField_XTimePointFormat=week; Search_DynamicField_XTimePointStart=Before; Search_DynamicField_XTimePointValue=7\';.'} =
        'Definisce l\'attributo di ricerca predefinito dell\'elemento di configurazione per la schermata di ricerca dell\'elemento di configurazione. Esempio: "Key" deve avere il nome del campo dinamico, in questo caso \'X\', "Content" deve avere il valore del campo dinamico, a seconda del tipo di campo dinamico, Text: \'un testo\', Dropdown: \'1\', Date/Time: \'Search_DynamicField_XTimeSlotStartYear=1974; Search_DynamicField_XTimeSlotStartMonth=01; Search_DynamicField_XTimeSlotStartDay=26; Search_DynamicField_XTimeSlotStartHour=00; Search_DynamicField_XTimeSlotStartMinute=00; Search_DynamicField_XTimeSlotStartSecond=00; Search_DynamicField_XTimeSlotStopYear=2013; Search_DynamicField_XTimeSlotStopMonth=01; Search_DynamicField_XTimeSlotStopDay=26; Search_DynamicField_XTimeSlotStopHour=23; Search_DynamicField_XTimeSlotStopMinute=59; Search_DynamicField_XTimeSlotStopSecond=59;\' e o \'Search_DynamicField_XTimePointFormat=week; Search_DynamicField_XTimePointStart=Before; Search_DynamicField_XTimePointValue=7\';.';
    $Self->{Translation}->{'Defines the default subobject of the class \'ITSMConfigItem\'.'} =
        'Definisce il sotto-oggetto predefinito della classe \'ITSMConfigItem\'.';
    $Self->{Translation}->{'Defines the disabled columns of CIs in the config item overview depending on the CI class. Each entry must consist of a class name and an array of available fields for the corresponding class. Dynamic field entries have to honor the scheme DynamicField_FieldName.'} =
        '';
    $Self->{Translation}->{'Defines the height for the rich text editor component for this screen. Enter number (pixels) or percent value (relative).'} =
        'Definisce l\'altezza del componente dell\'editor di testo ricco per questa schermata. Inserire un numero (pixel) o un valore percentuale (relativo).';
    $Self->{Translation}->{'Defines the number of rows for the CI definition editor in the admin interface.'} =
        'Definisce il numero di righe per CI l\'editor delle definizioni degli elementi della configurazione nell\'interfaccia di amministrazione.';
    $Self->{Translation}->{'Defines the order of incident states from high (e.g. cricital) to low (e.g. functional).'} =
        'Definisce l\'ordine degli stati degli incidenti da alto (es. critico) a basso (es. funzionale).';
    $Self->{Translation}->{'Defines the relevant deployment states where linked tickets can affect the status of a CI.'} =
        'Definisce gli stati di distribuzione pertinenti in cui i ticket collegati possono influire sullo stato di un CI.';
    $Self->{Translation}->{'Defines the search limit for the AgentITSMConfigItem screen.'} =
        'Definisce il limite di ricerca per la schermata AgentITSMConfigItem.';
    $Self->{Translation}->{'Defines the search limit for the AgentITSMConfigItemSearch screen.'} =
        'Definisce il limite di ricerca per la schermata AgentITSMConfigItemSearch.';
    $Self->{Translation}->{'Defines the search limit for the CustomerITSMConfigItem screen.'} =
        'Definisce il limite di ricerca per la schermata CustomerITSMConfigItem.';
    $Self->{Translation}->{'Defines the search limit for the CustomerITSMConfigItemSearch screen.'} =
        'Definisce il limite di ricerca per la schermata CustomerITSMConfigItemSearch.';
    $Self->{Translation}->{'Defines the shown columns of CIs in the link table complex view for all CI classes. If there is no entry, then the default columns are shown.'} =
        'Definisce le colonne di visualizzate degli elementi della configurazione di CIs nella vista complessa della tabella dei collegamenti per tutte le classi CI. Se non è presente alcuna voce, vengono visualizzate le colonne predefinite.';
    $Self->{Translation}->{'Defines the shown columns of CIs in the link table complex view, depending on the CI class. Each entry must be prefixed with the class name and double colons (i.e. Computer::). There are a few CI-Attributes that common to all CIs (example for the class Computer: Computer::Name, Computer::CurDeplState, Computer::CreateTime). To show individual CI-Attributes as defined in the CI-Definition, the following scheme must be used (example for the class Computer): Computer::HardDisk::1, Computer::HardDisk::1::Capacity::1, Computer::HardDisk::2, Computer::HardDisk::2::Capacity::1. If there is no entry for a CI class, then the default columns are shown.'} =
        'Definisce le colonne visualizzate degli elementi della configurazione nella vista complessa della tabella dei collegamenti, a seconda della classe CI. Ogni voce deve essere preceduta da un nome di classe e due punti (ad esempio Computer::). Esistono alcuni attributi CI comuni a tutti gli elementi della configurazione (esempio per la classe Computer: Computer::Nome, Computer::CurDeplState, Computer::CreateTime). Per mostrare singoli attributi CI come definiti nella definizione CI, è necessario utilizzare il seguente schema (esempio per la classe Computer): Computer::HardDisk::1, Computer::HardDisk::1::Capacity::1, Computer::HardDisk::2, Computer::HardDisk::2::Capacity::1. Se non è presente alcuna voce per una classe CI, vengono visualizzate le colonne predefinite.';
    $Self->{Translation}->{'Defines which items are available for \'Action\' in third level of the ITSM Config Item ACL structure.'} =
        'Definisce quali voci sono disponibili per l\'"Azione" nel terzo livello della struttura ITSM Config Item ACL.';
    $Self->{Translation}->{'Defines which items are available in first level of the ITSM Config Item ACL structure.'} =
        'Definisce quali voci sono disponibili nel primo livello della struttura ITSM Config Item ACL.';
    $Self->{Translation}->{'Defines which items are available in second level of the ITSM Config Item ACL structure.'} =
        'Definisce quali voci sono disponibili nel secondo livello della struttura ITSM Config Item ACL.';
    $Self->{Translation}->{'Defines which type of link (named from the ticket perspective) can affect the status of a linked CI.'} =
        'Definisce quale tipo di collegamento (denominato dalla prospettiva del ticket) può influire sullo stato di un elemento della configurazione collegato CI.';
    $Self->{Translation}->{'Defines which type of ticket can affect the status of a linked CI.'} =
        'Definisce quale tipo di ticket può influire sullo stato di un elemento della configurazione collegato CI. ';
    $Self->{Translation}->{'Definition Update'} = 'Aggiornamento della definizione';
    $Self->{Translation}->{'Delete Configuration Item'} = 'Elimina elemento di configurazione';
    $Self->{Translation}->{'DeplState'} = 'Stato di deplorazione';
    $Self->{Translation}->{'Deployment State Color'} = 'Colore dello stato di distribuzione';
    $Self->{Translation}->{'DeploymentState'} = 'Stato di distribuzione';
    $Self->{Translation}->{'Duplicate'} = 'Duplicato';
    $Self->{Translation}->{'Dynamic field event module that marks config item definitions as out of sync, if containing dynamic fields change.'} =
        'Modulo evento per campi dinamici che contrassegna le definizioni degli elementi della configurazione come non sincronizzate, se i campi dinamici che le contengono cambiano.';
    $Self->{Translation}->{'Dynamic fields shown in the additional ITSM field screen of the agent interface.'} =
        'Campi dinamici visualizzati nella schermata del campo ITSM aggiuntiva dell\'interfaccia agenti.';
    $Self->{Translation}->{'Dynamic fields shown in the config item overview screen of the customer interface.'} =
        'Campi dinamici visualizzati nella schermata di panoramica degli elementi di configurazione dell\'interfaccia cliente.';
    $Self->{Translation}->{'Dynamic fields shown in the config item search screen of the agent interface.'} =
        'Campi dinamici visualizzati nella schermata di ricerca degli elementi di configurazione dell\'interfaccia agente.';
    $Self->{Translation}->{'Enables configuration item bulk action feature for the agent frontend to work on more than one configuration item at a time.'} =
        'Abilita la funzione di azione in blocco degli elementi di configurazione affinché il frontend dell\'agente funzioni su più di un elemento di configurazione alla volta.';
    $Self->{Translation}->{'Enables configuration item bulk action feature only for the listed groups.'} =
        'Abilita la funzione di azione in blocco dell\'elemento di configurazione solo per i gruppi elencati.';
    $Self->{Translation}->{'Enables/disables the functionality to check ITSM onfiguration items for unique names. Before enabling this option you should check your system for already existing config items with duplicate names. You can do this with the console command Admin::ITSM::ConfigItem::ListDuplicates.'} =
        'Abilita/disabilita la funzionalità di controllo delle voci di configurazione ITSM per i nomi univoci. Prima di abilitare questa opzione, è necessario controllare il sistema per verificare che non vi siano elementi di configurazione già esistenti con nomi duplicati. È possibile farlo con il comando della console Admin::ITSM::ConfigItem::ListDuplicates.';
    $Self->{Translation}->{'Event module to set configitem-status on ticket-configitem-link.'} =
        'Modulo evento per impostare lo stato di configurazione su ticket-configitem-link.';
    $Self->{Translation}->{'Fields of the configuration item index, used for the fulltext search. Fields are also stored, but are not mandatory for the overall functionality. Inclusion of attachments can be disabled by setting the entry to 0 or deleting it.'} =
        'Campi dell\'indice degli elementi di configurazione, utilizzati per la ricerca full-text. I campi sono anche memorizzati, ma non sono obbligatori per la funzionalità complessiva. L\'inclusione degli allegati può essere disattivata impostando la voce su 0 o cancellandola.';
    $Self->{Translation}->{'Fields stored in the configuration item index which are used for other things besides fulltext searches. For the complete functionality all fields are mandatory.'} =
        'Campi memorizzati nell\'indice degli elementi di configurazione, utilizzati per altri scopi oltre alla ricerca full-text. Per la funzionalità completa, tutti i campi sono obbligatori.';
    $Self->{Translation}->{'For every webservice (key) an array of classes (value) can be defined on which the import is restricted. For all chosen classes, or all existing classes the identifying attributes will have to be chosen in the invoker config.'} =
        'Per ogni webservice (chiave) è possibile definire un array di classi (valore) su cui limitare l\'importazione. Per tutte le classi scelte, o per tutte le classi esistenti, gli attributi identificativi dovranno essere scelti nella configurazione dell\'invocatore.';
    $Self->{Translation}->{'GenericInterface module registration for the ConfigItemCreate invoker layer.'} =
        '';
    $Self->{Translation}->{'GenericInterface module registration for the ConfigItemFetch invoker layer.'} =
        'Registrazione del modulo GenericInterface per il livello di invocazione ConfigItemFetch.';
    $Self->{Translation}->{'GenericInterface module registration for the ConfigItemUpdate invoker layer.'} =
        '';
    $Self->{Translation}->{'ITSM ConfigItem'} = 'ITSM ConfigItem';
    $Self->{Translation}->{'ITSM config item overview.'} = 'Panoramica degli elementi di configurazione ITSM.';
    $Self->{Translation}->{'InciState'} = 'Stato Inci';
    $Self->{Translation}->{'IncidentState'} = 'Stato dell\'incidente';
    $Self->{Translation}->{'Includes deployment states in the config item search of the customer interface.'} =
        'Include gli stati di distribuzione nella ricerca degli elementi di configurazione dell\'interfaccia cliente.';
    $Self->{Translation}->{'Includes incident states in the config item search of the customer interface.'} =
        'Include gli stati degli incidenti nella ricerca degli elementi di configurazione dell\'interfaccia cliente.';
    $Self->{Translation}->{'License accounting configuration item event module.'} = '';
    $Self->{Translation}->{'Maximum number of config items to be displayed in the result of this operation.'} =
        'Numero massimo di voci di configurazione da visualizzare nel risultato di questa operazione.';
    $Self->{Translation}->{'Module to check the group responsible for a class.'} = 'Modulo per controllare il gruppo responsabile per una classe.';
    $Self->{Translation}->{'Module to check the group responsible for a configuration item.'} =
        'Modulo per verificare il gruppo responsabile di un elemento di configurazione.';
    $Self->{Translation}->{'Module to generate ITSM config item statistics.'} = 'Modulo per generare le statistiche degli elementi di configurazione ITSM.';
    $Self->{Translation}->{'Name Module'} = 'Modulo Nome';
    $Self->{Translation}->{'Number Module'} = 'Numero Modulo';
    $Self->{Translation}->{'Number of config items to be displayed in each page of a search result in the agent interface.'} =
        'Numero di voci di configurazione da visualizzare in ogni pagina di un risultato di ricerca nell\'interfaccia dell\'agente.';
    $Self->{Translation}->{'Number of config items to be displayed in each page of a search result in the customer interface.'} =
        'Numero di voci di configurazione da visualizzare in ogni pagina di un risultato di ricerca nell\'interfaccia cliente.';
    $Self->{Translation}->{'Objects to search for, how many entries and which attributs to show. ConfigItem attributes have to explicitly be stored via Elasticsearch.'} =
        'Oggetti da cercare, quante voci e quali attributi mostrare. Gli attributi di ConfigItem devono essere memorizzati esplicitamente tramite Elasticsearch.';
    $Self->{Translation}->{'Overview.'} = 'Vista Globale.';
    $Self->{Translation}->{'Parameters for the categories for config item classes in the preferences view of the agent interface.'} =
        'Parametri per le categorie delle classi di elementi della configurazione nella vista preferenze dell\'interfaccia agente.';
    $Self->{Translation}->{'Parameters for the column filters of the small config item overview. Please note: setting \'Active\' to 0 will only prevent agents from editing settings of this group in their personal preferences, but will still allow administrators to edit the settings of another user\'s behalf. Use \'PreferenceGroup\' to control in which area these settings should be shown in the user interface.'} =
        'Parametri per i filtri delle colonne della panoramica degli elementi di configurazione piccoli. Nota bene: impostando \'Attivo\' su 0, si impedirà agli agenti di modificare le impostazioni di questo gruppo nelle loro preferenze personali, ma si permetterà agli amministratori di modificare le impostazioni di un altro utente. Usare \'Gruppo di preferenze\' per controllare in quale area queste impostazioni devono essere visualizzate nell\'interfaccia utente.';
    $Self->{Translation}->{'Parameters for the dashboard backend of the customer company config item overview of the agent interface . "Limit" is the number of entries per config item class shown by default. "Group" is used to restrict the access to the plugin (e. g. Group: admin;group1;group2;). "Default" determines if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" is the cache time in minutes for the plugin. "ConfigItemKey" is used to specify which reference field is used for a ConfigItem class (Key=Class, Value=DynamicFieldName).'} =
        '';
    $Self->{Translation}->{'Parameters for the dashboard backend of the customer company config item overview of the agent interface . "Limit" is the number of entries shown by default. "Group" is used to restrict the access to the plugin (e. g. Group: admin;group1;group2;). "Default" determines if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" is the cache time in minutes for the plugin. "ConfigItemKey" is used to specify which reference field is used for a ConfigItem class (Key=Class, Value=DynamicFieldName).'} =
        '';
    $Self->{Translation}->{'Parameters for the deployment states color in the preferences view of the agent interface.'} =
        'I parametri per gli stati di distribuzione colorano nella vista delle preferenze dell\'interfaccia agenti.';
    $Self->{Translation}->{'Parameters for the deployment states in the preferences view of the agent interface.'} =
        'Parametri per gli stati di distribuzione nella vista delle preferenze dell\'interfaccia agenti.';
    $Self->{Translation}->{'Parameters for the example permission groups of the general catalog attributes.'} =
        'Parametri per i gruppi di permessi di esempio degli attributi del catalogo generale.';
    $Self->{Translation}->{'Parameters for the name module for config item classes in the preferences view of the agent interface.'} =
        'Parametri per il modulo dei nomi delle classi di elementi di configurazione nella vista preferenze dell\'interfaccia agente.';
    $Self->{Translation}->{'Parameters for the number module for config item classes in the preferences view of the agent interface.'} =
        'Parametri per il modulo numerico delle classi di elementi di configurazione nella vista preferenze dell\'interfaccia agente.';
    $Self->{Translation}->{'Parameters for the pages (in which the configuration items are shown).'} =
        'Parametri per le pagine (nelle quali gli elementi di configurazione sono mostrati).';
    $Self->{Translation}->{'Parameters for the version string module for config item classes in the preferences view of the agent interface.'} =
        'Parametri per il modulo stringa di versione per le classi di elementi di configurazione nella vista preferenze dell\'interfaccia dell\'agente.';
    $Self->{Translation}->{'Parameters for the version string template toolkit module for config item classes in the preferences view of the agent interface.'} =
        'Parametri per il modulo del toolkit di modelli di stringhe di versione per le classi di elementi di configurazione nella vista preferenze dell\'interfaccia dell\'agente.';
    $Self->{Translation}->{'Parameters for the version trigger for config item classes in the preferences view of the agent interface.'} =
        'Parametri per l\'attivazione della versione per le classi di elementi di configurazione nella vista preferenze dell\'interfaccia dell\'agente.';
    $Self->{Translation}->{'Performs the configured action for each event (as an Invoker) for each configured Webservice.'} =
        'Esegue l\'azione configurata per ogni evento (come Invoker) per ogni Webservice configurato.';
    $Self->{Translation}->{'Permission Group'} = 'Gruppo di autorizzazioni';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item attachment action in the agent interface.'} =
        'Autorizzazioni necessarie per utilizzare l\'azione di collegamento dell\'elemento di configurazione ITSM nell\'interfaccia dell\'agente.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item screen in the agent interface.'} =
        'Permessi necessari per utilizzare la schermata dell\'elemento di configurazione ITSM nell\'interfaccia agenti.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item search screen in the agent interface.'} =
        'Permessi necessari per utilizzare la schermata di ricerca degli elementi della configurazione ITSM nell\'interfaccia agenti.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item search screen in the customer interface.'} =
        'Autorizzazioni necessarie per utilizzare la schermata di ricerca degli elementi di configurazione ITSM nell\'interfaccia cliente.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item tree view screen in the agent interface.'} =
        'Autorizzazioni necessarie per utilizzare la schermata di visualizzazione ad albero degli elementi di configurazione ITSM nell\'interfaccia agente.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item zoom screen in the agent interface.'} =
        'Permessi necessari per utilizzare la schermata di zoom dell\'elemento di configurazione ITSM nell\'interfaccia agenti.';
    $Self->{Translation}->{'Required permissions to use the add ITSM configuration item screen in the agent interface.'} =
        'Permessi necessari per utilizzare la schermata Aggiungi elemento di configurazione ITSM nell\'interfaccia agenti.';
    $Self->{Translation}->{'Required permissions to use the bulk ITSM configuration item screen in the agent interface.'} =
        'Autorizzazioni necessarie per utilizzare la schermata degli elementi di configurazione ITSM di massa nell\'interfaccia dell\'agente.';
    $Self->{Translation}->{'Required permissions to use the edit ITSM configuration item screen in the agent interface.'} =
        'Permessi necessari per utilizzare la schermata di modifica dell\'elemento di configurazione ITSM nell\'interfaccia agenti.';
    $Self->{Translation}->{'Required permissions to use the history ITSM configuration item screen in the agent interface.'} =
        'Permessi necessari per utilizzare la schermata dell\'elemento di configurazione ITSM della cronologia nell\'interfaccia agenti.';
    $Self->{Translation}->{'Required permissions to use the print ITSM configuration item screen in the agent interface.'} =
        'Permessi necessari per utilizzare la schermata di stampa dell\'elemento di configurazione ITSM nell\'interfaccia agenti.';
    $Self->{Translation}->{'Required privileges to delete config items.'} = 'Privilegi richiesti per eliminare gli elementi di configurazione.';
    $Self->{Translation}->{'Search config items.'} = 'Cerca elementi di configurazione.';
    $Self->{Translation}->{'Set the incident state of a CI automatically when a Ticket is Linked to a CI.'} =
        'Imposta automaticamente lo stato dell\'incidente di un elemento della configurazione quando un ticket è collegato a un elemento della configurazione.';
    $Self->{Translation}->{'Sets the deployment state in the configuration item bulk screen of the agent interface.'} =
        'Imposta lo stato di distribuzione nella schermata di massa degli elementi di configurazione dell\'interfaccia agenti.';
    $Self->{Translation}->{'Sets the incident state in the configuration item bulk screen of the agent interface.'} =
        'Imposta lo stato dell\'incidente nella schermata in blocco dell\'articolo di configurazione dell\'interfaccia agenti.';
    $Self->{Translation}->{'Shows a link in the menu that allows linking a configuration item with another object in the config item zoom view of the agent interface.'} =
        'Mostra un collegamento nel menu che consente di collegare un elemento di configurazione con un altro oggetto nella vista zoom elemento di configurazione dell\'interfaccia agenti.';
    $Self->{Translation}->{'Shows a link in the menu to access the history of a configuration item in the configuration item overview of the agent interface.'} =
        'Mostra un collegamento nel menu per accedere alla cronologia di un elemento di configurazione nella panoramica degli elementi di configurazione dell\'interfaccia agenti.';
    $Self->{Translation}->{'Shows a link in the menu to access the history of a configuration item in the its zoom view of the agent interface.'} =
        'Mostra un collegamento nel menu per accedere alla cronologia di un elemento di configurazione nella vista zoom dell\'interfaccia agenti.';
    $Self->{Translation}->{'Shows a link in the menu to delete a configuration item in its zoom view of the agent interface.'} =
        'Mostra un collegamento nel menu per eliminare un elemento di configurazione nella sua vista zoom dell\'interfaccia agenti.';
    $Self->{Translation}->{'Shows a link in the menu to display the configuration item links as a Tree View.'} =
        'Mostra un collegamento nel menu per visualizzare i collegamenti alle voci di configurazione come una struttura ad albero.';
    $Self->{Translation}->{'Shows a link in the menu to duplicate a configuration item in the configuration item overview of the agent interface.'} =
        'Mostra un collegamento nel menu per duplicare un elemento di configurazione nella panoramica degli elementi di configurazione dell\'interfaccia agenti.';
    $Self->{Translation}->{'Shows a link in the menu to duplicate a configuration item in the its zoom view of the agent interface.'} =
        'Mostra un collegamento nel menu per duplicare un elemento di configurazione nella sua vista zoom dell\'interfaccia agenti.';
    $Self->{Translation}->{'Shows a link in the menu to edit a configuration item in the its zoom view of the agent interface.'} =
        'Mostra un collegamento nel menu per modificare un elemento di configurazione nella sua vista zoom dell\'interfaccia agenti.';
    $Self->{Translation}->{'Shows a link in the menu to go back in the configuration item zoom view of the agent interface.'} =
        'Mostra un collegamento nel menu per tornare indietro nella vista zoom della voce di configurazione dell\'interfaccia agenti.';
    $Self->{Translation}->{'Shows a link in the menu to print a configuration item in the its zoom view of the agent interface.'} =
        'Mostra un collegamento nel menu per stampare un elemento di configurazione nella sua vista zoom dell\'interfaccia agenti.';
    $Self->{Translation}->{'Shows a link in the menu to zoom into a configuration item in the configuration item overview of the agent interface.'} =
        'Mostra un collegamento nel menu per ingrandire una voce di configurazione nella panoramica delle voci di configurazione dell\'interfaccia agenti.';
    $Self->{Translation}->{'Shows the config item history (reverse ordered) in the agent interface.'} =
        'Mostra la cronologia degli articoli di configurazione (ordine inverso) nell\'interfaccia agenti.';
    $Self->{Translation}->{'The default category which is shown, if none is selected.'} = 'La categoria predefinita che viene mostrata se non è selezionata nessuna.';
    $Self->{Translation}->{'The identifier for a configuration item, e.g. ConfigItem#, MyConfigItem#. The default is ConfigItem#.'} =
        'L\'identificatore per un elemento di configurazione, ad es. ConfigItem#, MyConfigItem#. L\'impostazione predefinita è ConfigItem#.';
    $Self->{Translation}->{'Triggers ConfigItemFetch invoker automatically.'} = 'Attiva automaticamente l\'invocatore di ConfigItemFetch.';
    $Self->{Translation}->{'Version String Expression'} = 'Versione Espressione stringa';
    $Self->{Translation}->{'Version String Module'} = 'Versione Modulo Stringa';
    $Self->{Translation}->{'Version Trigger'} = 'Versione Trigger';
    $Self->{Translation}->{'Whether fields should be automatically filled (1), and in that case also be hidden from ticket formulars (2).'} =
        '';
    $Self->{Translation}->{'Whether the execution of ConfigItemACL can be avoided by checking cached field dependencies. This can improve loading times of formulars, but has to be disabled, if ACLModules are to be used for ITSMConfigItem- and Form-ReturnTypes.'} =
        'Se l\'esecuzione di ConfigItemACL può essere evitata controllando le dipendenze dei campi nella cache. Questo può migliorare i tempi di caricamento dei moduli, ma deve essere disabilitato se si vogliono usare i moduli ACLM per i tipi ITSMConfigItem e Form-Return.';
    $Self->{Translation}->{'Which general information is shown in the header.'} = 'Le informazioni generali sono riportate nell\'intestazione.';
    $Self->{Translation}->{'class'} = 'classe';
    $Self->{Translation}->{'global'} = 'globale';
    $Self->{Translation}->{'postproductive'} = 'postproductive';
    $Self->{Translation}->{'preproductive'} = 'preproductive';
    $Self->{Translation}->{'productive'} = 'produttiva';

    # Ready to adopt classes: IT-Servicemanagement-11_0_3
    $Self->{Translation}->{'10U: 17.5 inches (44.45 cm)'} = '10U: 17,5 pollici (44,45 cm)';
    $Self->{Translation}->{'12U: 21 inches (53.34 cm)'} = '12U: 21 pollici (53,34 cm)';
    $Self->{Translation}->{'15U: 26.25 inches (66.68 cm)'} = '15U: 26,25 pollici (66,68 cm)';
    $Self->{Translation}->{'18U: 31.5 inches (80.01 cm)'} = '18U: 31,5 pollici (80,01 cm)';
    $Self->{Translation}->{'19-inch Rack'} = 'Rack da 19 pollici';
    $Self->{Translation}->{'1U: 1.75 inches (4.45 cm)'} = '1U: 1,75 pollici (4,45 cm)';
    $Self->{Translation}->{'20U: 35 inches (88.9 cm)'} = '20U: 35 pollici (88,9 cm)';
    $Self->{Translation}->{'21-inch Rack'} = 'Cremagliera da 21 pollici';
    $Self->{Translation}->{'22U: 38.5 inches (97.79 cm)'} = '22U: 38,5 pollici (97,79 cm)';
    $Self->{Translation}->{'23-inch Rack'} = 'Cremagliera da 23 pollici';
    $Self->{Translation}->{'23.6 inches (600 mm)'} = '23,6 pollici (600 mm)';
    $Self->{Translation}->{'24U: 42 inches (106.68 cm)'} = '24U: 42 pollici (106,68 cm)';
    $Self->{Translation}->{'27U: 47.25 inches (120.02 cm)'} = '27U: 47,25 pollici (120,02 cm)';
    $Self->{Translation}->{'2U: 3.5 inches (8.89 cm)'} = '2U: 3,5 pollici (8,89 cm)';
    $Self->{Translation}->{'30U: 52.5 inches (133.35 cm)'} = '30U: 52,5 pollici (133,35 cm)';
    $Self->{Translation}->{'31.5 inches (800 mm)'} = '31,5 pollici (800 mm)';
    $Self->{Translation}->{'33U: 57.75 inches (146.68 cm)'} = '33U: 57,75 pollici (146,68 cm)';
    $Self->{Translation}->{'35.4 inches (900 mm)'} = '35,4 pollici (900 mm)';
    $Self->{Translation}->{'36U: 63 inches (160.02 cm)'} = '36U: 63 pollici (160,02 cm)';
    $Self->{Translation}->{'39.4 inches (1000 mm)'} = '39,4 pollici (1000 mm)';
    $Self->{Translation}->{'39U: 68.25 inches (173.35 cm)'} = '39U: 68,25 pollici (173,35 cm)';
    $Self->{Translation}->{'3U: 5.25 inches (13.34 cm)'} = '3U: 5,25 pollici (13,34 cm)';
    $Self->{Translation}->{'42U: 73.5 inches (186.69 cm)'} = '42U: 73,5 pollici (186,69 cm)';
    $Self->{Translation}->{'43.3 inches (1100 mm):'} = '43,3 pollici (1100 mm):';
    $Self->{Translation}->{'45U: 78.75 inches (200.02 cm)'} = '45U: 78,75 pollici (200,02 cm)';
    $Self->{Translation}->{'47.2 inches (1200 mm)'} = '47,2 pollici (1200 mm)';
    $Self->{Translation}->{'48U: 84 inches (213.36 cm)'} = '48U: 84 pollici (213,36 cm)';
    $Self->{Translation}->{'4U: 7 inches (17.78 cm)'} = '4U: 7 pollici (17,78 cm)';
    $Self->{Translation}->{'5U: 8.75 inches (22.23 cm)'} = '5U: 8,75 pollici (22,23 cm)';
    $Self->{Translation}->{'6U: 10.5 inches (26.67 cm)'} = '6U: 10,5 pollici (26,67 cm)';
    $Self->{Translation}->{'7U: 12.25 inches (31.12 cm)'} = '7U: 12,25 pollici (31,12 cm)';
    $Self->{Translation}->{'8U: 14 inches (35.56 cm)'} = '8U: 14 pollici (35,56 cm)';
    $Self->{Translation}->{'9U: 15.75 inches (40.01 cm)'} = '9U: 15,75 pollici (40,01 cm)';
    $Self->{Translation}->{'AGPL (Affero General Public License)'} = '';
    $Self->{Translation}->{'Accounting'} = 'Contabilità';
    $Self->{Translation}->{'Accounting Information'} = '';
    $Self->{Translation}->{'Address Allocation'} = 'Assegnazione degli indirizzi';
    $Self->{Translation}->{'Administrator'} = 'Amministratore';
    $Self->{Translation}->{'Analog Phone'} = 'Telefono analogico';
    $Self->{Translation}->{'Apache Lizenz'} = '';
    $Self->{Translation}->{'Appliance Type'} = 'Tipo di apparecchio';
    $Self->{Translation}->{'BSD Lizenz (Berkeley Software Distribution License)'} = '';
    $Self->{Translation}->{'Battery Capacity (Ah)'} = 'Capacità della batteria (Ah)';
    $Self->{Translation}->{'Battery Type'} = 'Tipo di batteria';
    $Self->{Translation}->{'Building'} = 'Edificio';
    $Self->{Translation}->{'Bus Interface'} = 'Interfaccia bus';
    $Self->{Translation}->{'CC0 (Creative Commons Zero)'} = '';
    $Self->{Translation}->{'CIDR'} = 'CIDR';
    $Self->{Translation}->{'CPU'} = 'CPU';
    $Self->{Translation}->{'CPU Class'} = 'Classe CPU';
    $Self->{Translation}->{'Capacity (GB)'} = 'Capacità (GB)';
    $Self->{Translation}->{'Capacity per graphics card'} = 'Capacità per scheda grafica';
    $Self->{Translation}->{'Card Number'} = 'Numero di carta';
    $Self->{Translation}->{'Card Reader'} = 'Lettore di schede';
    $Self->{Translation}->{'Card Type'} = 'Tipo di carta';
    $Self->{Translation}->{'Client Certificates'} = 'Certificati cliente';
    $Self->{Translation}->{'Client Software'} = 'Software client';
    $Self->{Translation}->{'Client category'} = 'Categoria di clienti';
    $Self->{Translation}->{'Clockrate'} = 'Frequenza dell\'orologio';
    $Self->{Translation}->{'Clockspeed'} = 'Velocità dell\'orologio';
    $Self->{Translation}->{'Code Signing Certificates'} = 'Certificati di firma del codice';
    $Self->{Translation}->{'Conference Phone'} = 'Telefono di conferenza';
    $Self->{Translation}->{'Consulting Agreement'} = 'Contratto di consulenza';
    $Self->{Translation}->{'Contact'} = 'Contatto';
    $Self->{Translation}->{'Contact Distributor'} = 'Contatto con il distributore';
    $Self->{Translation}->{'Container Management'} = 'Gestione dei contenitori';
    $Self->{Translation}->{'Contract'} = 'Contratto';
    $Self->{Translation}->{'Contract Type'} = 'Tipo di contratto';
    $Self->{Translation}->{'Contract period from'} = 'Durata del contratto da';
    $Self->{Translation}->{'Contract period until'} = 'Durata del contratto fino a';
    $Self->{Translation}->{'Cordless Phone (DECT Phone)'} = 'Telefono cordless (telefono DECT)';
    $Self->{Translation}->{'Cost unit'} = 'Unità di costo';
    $Self->{Translation}->{'Count of licenses'} = 'Numero di licenze';
    $Self->{Translation}->{'Creation Date'} = 'Data di creazione';
    $Self->{Translation}->{'Creative Commons'} = '';
    $Self->{Translation}->{'Custom Rack'} = 'Cremagliera personalizzata';
    $Self->{Translation}->{'DHCP'} = 'DHCP';
    $Self->{Translation}->{'DHCP Reserved'} = 'DHCP Riservato';
    $Self->{Translation}->{'DNS-Server'} = 'Server DNS';
    $Self->{Translation}->{'DVI'} = 'DVI';
    $Self->{Translation}->{'Date of Invoice'} = 'Data della fattura';
    $Self->{Translation}->{'Date of Order'} = 'Data dell\'ordine';
    $Self->{Translation}->{'Date of Warranty'} = 'Data della garanzia';
    $Self->{Translation}->{'Date of release'} = 'Data di rilascio';
    $Self->{Translation}->{'Desktop'} = 'Desktop';
    $Self->{Translation}->{'DisplayPort'} = 'DisplayPort';
    $Self->{Translation}->{'Document Signing Certificates'} = 'Certificati di firma dei documenti';
    $Self->{Translation}->{'EPL (Eclipse Public License)'} = '';
    $Self->{Translation}->{'ETSI Rack'} = 'Rack ETSI';
    $Self->{Translation}->{'Email Certificates (S/MIME Certificates)'} = 'Certificati e-mail (certificati S/MIME)';
    $Self->{Translation}->{'Embedded SIM (eSIM)'} = '';
    $Self->{Translation}->{'Employment Contract'} = 'Contratto di lavoro';
    $Self->{Translation}->{'End IP Address'} = 'Indirizzo IP finale';
    $Self->{Translation}->{'End of support'} = 'Fine del supporto';
    $Self->{Translation}->{'Expiry Date'} = 'Data di scadenza';
    $Self->{Translation}->{'External Hard Drive'} = 'Disco rigido esterno';
    $Self->{Translation}->{'Firewall'} = 'Firewall';
    $Self->{Translation}->{'Firmware'} = 'Firmware';
    $Self->{Translation}->{'Flywheel Energy Storage'} = 'Accumulo di energia a volano';
    $Self->{Translation}->{'Form Factor'} = 'Fattore di forma';
    $Self->{Translation}->{'Franchise Agreement'} = 'Contratto di franchising';
    $Self->{Translation}->{'Freeware'} = 'Freeware';
    $Self->{Translation}->{'GPL (General Public License)'} = '';
    $Self->{Translation}->{'General Information'} = 'Informazioni generali';
    $Self->{Translation}->{'Graphics Cards'} = 'Schede grafiche';
    $Self->{Translation}->{'Graphics card'} = 'Scheda grafica';
    $Self->{Translation}->{'HDMI'} = 'HDMI';
    $Self->{Translation}->{'Hardware'} = 'Hardware';
    $Self->{Translation}->{'Hardware Model'} = 'Modello hardware';
    $Self->{Translation}->{'Hardware Weight'} = 'Peso dell\'hardware';
    $Self->{Translation}->{'Headset'} = 'Cuffia';
    $Self->{Translation}->{'IP Protocol'} = 'Protocollo IP';
    $Self->{Translation}->{'Identity and Access Management (IAM)'} = 'Gestione dell\'identità e dell\'accesso (IAM)';
    $Self->{Translation}->{'Inventory Number'} = 'Numero di inventario';
    $Self->{Translation}->{'Inverstment costs'} = 'Costi di investimento';
    $Self->{Translation}->{'Invoice Number'} = 'Numero di fattura';
    $Self->{Translation}->{'Keyboard'} = 'Tastiera';
    $Self->{Translation}->{'LCD Monitor (Liquid Crystal Display)'} = 'Monitor LCD (display a cristalli liquidi)';
    $Self->{Translation}->{'LED Monitor (Light Emitting Diode)'} = 'Monitor LED (diodo a emissione luminosa)';
    $Self->{Translation}->{'LGPL (Lesser General Public License)'} = '';
    $Self->{Translation}->{'Landline Phone'} = 'Telefono fisso';
    $Self->{Translation}->{'Laptop'} = 'Portatile';
    $Self->{Translation}->{'Latitude'} = 'Latitudine';
    $Self->{Translation}->{'Layer 1: Physical Layer'} = 'Livello 1: livello fisico';
    $Self->{Translation}->{'Layer 2: Data Link Layer'} = 'Livello 2: Livello di collegamento dati';
    $Self->{Translation}->{'Layer 3: Network Layer'} = 'Livello 3: livello di rete';
    $Self->{Translation}->{'Layer 3: Network Layer (Supernet)'} = 'Livello 3: Livello di rete (Supernet)';
    $Self->{Translation}->{'Layer 4: Transport Layer'} = 'Livello 4: livello di trasporto';
    $Self->{Translation}->{'Layer 5: Session Layer'} = 'Livello 5: livello di sessione';
    $Self->{Translation}->{'Layer 6: Presentation Layer'} = 'Livello 6: Livello di presentazione';
    $Self->{Translation}->{'Layer 7: Application Layer'} = 'Livello 7: Livello applicazione';
    $Self->{Translation}->{'Lease Agreement'} = 'Contratto di locazione';
    $Self->{Translation}->{'License Agreement'} = 'Contratto di licenza';
    $Self->{Translation}->{'License Count'} = '';
    $Self->{Translation}->{'License Key'} = 'Chiave di licenza';
    $Self->{Translation}->{'License Type'} = 'Tipo di licenza';
    $Self->{Translation}->{'License period from'} = 'Periodo di licenza da';
    $Self->{Translation}->{'License period until'} = 'Periodo di licenza fino a';
    $Self->{Translation}->{'Lithium Iron Phosphate (LiFePO4) Battery'} = 'Batteria al litio ferro fosfato (LiFePO4)';
    $Self->{Translation}->{'Lithium-Ion (Li-ion) Battery'} = 'Batteria agli ioni di litio (Li-ion)';
    $Self->{Translation}->{'Loan Agreement'} = 'Contratto di prestito';
    $Self->{Translation}->{'Located in'} = 'Situato in';
    $Self->{Translation}->{'Longitude'} = 'Longitudine';
    $Self->{Translation}->{'MIT Lizenz'} = '';
    $Self->{Translation}->{'MPL (Mozilla Public License)'} = '';
    $Self->{Translation}->{'Manufacturer'} = 'Produttore';
    $Self->{Translation}->{'Maximum Load Capacity (W)'} = 'Capacità di carico massima (W)';
    $Self->{Translation}->{'Memory'} = 'Memoria';
    $Self->{Translation}->{'Memory Type'} = 'Tipo di memoria';
    $Self->{Translation}->{'Micro SIM'} = '';
    $Self->{Translation}->{'Mini-Rack'} = 'Mini-Rack';
    $Self->{Translation}->{'Mobile Number'} = 'Numero di cellulare';
    $Self->{Translation}->{'Mobile/Embedded'} = 'Mobile/Embedded';
    $Self->{Translation}->{'Model'} = 'Modello';
    $Self->{Translation}->{'Model Description'} = 'Descrizione del modello';
    $Self->{Translation}->{'Monitor Resolution'} = 'Risoluzione del monitor';
    $Self->{Translation}->{'Monitor Size'} = 'Dimensioni del monitor';
    $Self->{Translation}->{'Mouse'} = 'Mouse';
    $Self->{Translation}->{'Nano SIM'} = '';
    $Self->{Translation}->{'Network'} = 'Rete';
    $Self->{Translation}->{'Network Info'} = 'Informazioni sulla rete';
    $Self->{Translation}->{'Network Information'} = 'Informazioni sulla rete';
    $Self->{Translation}->{'Network Layer'} = 'Livello di rete';
    $Self->{Translation}->{'Nickel-Cadmium (NiCd) Battery'} = 'Batteria al nichel-cadmio (NiCd)';
    $Self->{Translation}->{'Nickel-Metal Hydride (NiMH) Battery'} = 'Batteria al nichel-metallo idruro (NiMH)';
    $Self->{Translation}->{'Non-Disclosure Agreement (NDA)'} = 'Accordo di non divulgazione (NDA)';
    $Self->{Translation}->{'Notebook'} = 'Taccuino';
    $Self->{Translation}->{'Number of CPUs'} = 'Numero di CPU';
    $Self->{Translation}->{'Number of RAM modules'} = 'Numero di moduli RAM';
    $Self->{Translation}->{'Number of graphics cards'} = 'Numero di schede grafiche';
    $Self->{Translation}->{'OLED Monitor (Organic Light Emitting Diode)'} = 'Monitor OLED (diodo organico a emissione di luce)';
    $Self->{Translation}->{'Operating costs'} = 'Costi operativi';
    $Self->{Translation}->{'Order Number'} = 'Numero d\'ordine';
    $Self->{Translation}->{'Other'} = 'Altro';
    $Self->{Translation}->{'Outputs'} = 'Uscite';
    $Self->{Translation}->{'PIN'} = 'PIN';
    $Self->{Translation}->{'PIN 2'} = 'PIN 2';
    $Self->{Translation}->{'PUK'} = 'PUK';
    $Self->{Translation}->{'PUK 2'} = 'PUK 2';
    $Self->{Translation}->{'Partnership Agreement'} = 'Accordo di partenariato';
    $Self->{Translation}->{'Perpetual licenses'} = '';
    $Self->{Translation}->{'Phone / VoIP'} = '';
    $Self->{Translation}->{'Phone Number'} = 'Numero di telefono';
    $Self->{Translation}->{'Phone Type'} = 'Tipo di telefono';
    $Self->{Translation}->{'Physical Cores'} = 'Nuclei fisici';
    $Self->{Translation}->{'Power Delivery'} = 'Erogazione di energia';
    $Self->{Translation}->{'Public Domain'} = '';
    $Self->{Translation}->{'Purchased at'} = 'Acquistato presso';
    $Self->{Translation}->{'Rack Depth'} = 'Profondità del rack';
    $Self->{Translation}->{'Rack Units (U)'} = 'Unità rack (U)';
    $Self->{Translation}->{'Room'} = 'Stanza';
    $Self->{Translation}->{'SIM Card'} = 'Scheda SIM';
    $Self->{Translation}->{'SSL/TLS Certificates'} = 'Certificati SSL/TLS';
    $Self->{Translation}->{'Sales Contract'} = 'Contratto di vendita';
    $Self->{Translation}->{'Satellite Phone'} = 'Telefono satellitare';
    $Self->{Translation}->{'Sealed Lead-Acid (SLA) Battery'} = 'Batteria al piombo sigillata (SLA)';
    $Self->{Translation}->{'Seat licenses'} = '';
    $Self->{Translation}->{'Serialnumber'} = 'Numero di serie';
    $Self->{Translation}->{'Server Software'} = 'Software per server';
    $Self->{Translation}->{'Service Agreement'} = 'Contratto di servizio';
    $Self->{Translation}->{'Service Tag'} = 'Etichetta di servizio';
    $Self->{Translation}->{'Shareware'} = '';
    $Self->{Translation}->{'Socket Type'} = 'Tipo di presa';
    $Self->{Translation}->{'Software'} = 'Software';
    $Self->{Translation}->{'Speakers'} = 'Altoparlanti';
    $Self->{Translation}->{'Standard SIM'} = '';
    $Self->{Translation}->{'Start IP Address'} = 'Indirizzo IP di partenza';
    $Self->{Translation}->{'Storage'} = 'Immagazzinamento';
    $Self->{Translation}->{'Storage Partition'} = 'Partizione di archiviazione';
    $Self->{Translation}->{'Subscription-based licenses'} = '';
    $Self->{Translation}->{'Subsidiary'} = 'Filiale';
    $Self->{Translation}->{'Summary'} = 'Sintesi';
    $Self->{Translation}->{'Thin Client'} = 'Thin Client';
    $Self->{Translation}->{'Threads'} = 'Fili';
    $Self->{Translation}->{'Thunderbolt'} = 'Folgore';
    $Self->{Translation}->{'Total Graphics card RAM (GB)'} = 'RAM totale della scheda grafica (GB)';
    $Self->{Translation}->{'Total RAM (GB)'} = 'RAM totale (GB)';
    $Self->{Translation}->{'Touchscreen Monitor'} = 'Monitor touchscreen';
    $Self->{Translation}->{'Tower'} = 'Torre';
    $Self->{Translation}->{'USB Hub'} = 'Hub USB';
    $Self->{Translation}->{'USB-C'} = 'USB-C';
    $Self->{Translation}->{'VGA'} = 'VGA';
    $Self->{Translation}->{'VPN'} = 'VPN';
    $Self->{Translation}->{'VR Headset'} = 'Cuffie VR';
    $Self->{Translation}->{'Virtual Client'} = '';
    $Self->{Translation}->{'VirtualLink'} = 'VirtualLink';
    $Self->{Translation}->{'VoIP Phone'} = 'Telefono VoIP';
    $Self->{Translation}->{'Volume licenses'} = '';
    $Self->{Translation}->{'Webcam'} = 'Webcam';


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

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

package Kernel::Language::es_ITSMConfigurationManagement;

use strict;
use warnings;
use utf8;

sub Data {
    my $Self = shift;

    # Template: AdminITSMConfigItem
    $Self->{Translation}->{'Config Item Management'} = 'Gestión de Elementos de Configuración';
    $Self->{Translation}->{'Change class definition'} = 'Cambiar definición de la Clase';
    $Self->{Translation}->{'Config Item Class'} = 'Clase de elemento de configuración';
    $Self->{Translation}->{'Definition'} = 'Definición';
    $Self->{Translation}->{'Change'} = 'Modificar';

    # Template: AgentDashboardITSMConfigItemGeneric
    $Self->{Translation}->{'Incident State'} = 'Estado del Incidente';
    $Self->{Translation}->{'Deployment State'} = 'Estado de la Implementación';
    $Self->{Translation}->{'Class'} = 'Clase';
    $Self->{Translation}->{'Deployment State Type'} = 'Tipo de estado de implementación';
    $Self->{Translation}->{'Current Incident State'} = 'Estado del Incidente Actual';
    $Self->{Translation}->{'Current Incident State Type'} = 'Estado actual del Tipo de incidente';
    $Self->{Translation}->{'Last changed'} = 'Último cambio';

    # Template: AgentITSMConfigItemAdd
    $Self->{Translation}->{'Config Item'} = 'Elemento de Configuración';
    $Self->{Translation}->{'Filter for Classes'} = 'Filtro para Clases';
    $Self->{Translation}->{'Select a Class from the list to create a new Config Item.'} = 'Seleccione una Clase de la lista para crear un nuevo Item de Configuración';

    # Template: AgentITSMConfigItemBulk
    $Self->{Translation}->{'ITSM ConfigItem Bulk Action'} = 'ITSM ConfigItem Acción Masiva';
    $Self->{Translation}->{'Deployment state'} = 'Estado de despliegue';
    $Self->{Translation}->{'Incident state'} = 'Estado del incidente';
    $Self->{Translation}->{'Link to another'} = 'Enlazar con otro';
    $Self->{Translation}->{'Invalid Configuration Item number!'} = '¡Número de Ítem de Configuración no valido!';
    $Self->{Translation}->{'The number of another Configuration Item to link with.'} = 'El número de otro elemento de configuración con el que vincular.';

    # Template: AgentITSMConfigItemDelete
    $Self->{Translation}->{'Do you really want to delete this config item?'} = '¿Realmente desea eliminar este elemento de configuración?';

    # Template: AgentITSMConfigItemEdit
    $Self->{Translation}->{'The name of this config item'} = 'El nombre de este elemento de configuración';
    $Self->{Translation}->{'Name is already in use by the ConfigItems with the following Number(s): %s'} =
        'El nombre ya esta en uso por Ítems de Configuración con los siguientes número(s): %s';

    # Template: AgentITSMConfigItemHistory
    $Self->{Translation}->{'History of Config Item: %s'} = 'Historial del Elemento de configuración: %s';
    $Self->{Translation}->{'History Content'} = 'Contenido del historial';
    $Self->{Translation}->{'Createtime'} = 'Fecha de Creación';
    $Self->{Translation}->{'Zoom view'} = 'Vista detallada ';

    # Template: AgentITSMConfigItemOverviewNavBar
    $Self->{Translation}->{'Context Settings'} = 'Ajustes de Contexto';
    $Self->{Translation}->{'Config Items per page'} = 'CIs por página';

    # Template: AgentITSMConfigItemOverviewSmall
    $Self->{Translation}->{'A generic ITSM Configuration Item table'} = 'Una tabla genérica de ítems de configuración de ITSM';

    # Template: AgentITSMConfigItemSearch
    $Self->{Translation}->{'Run Search'} = 'Ejecutar la búsqueda';
    $Self->{Translation}->{'Also search in previous versions?'} = '¿Desea buscar en versiones anteriores?';

    # Template: AgentITSMConfigItemZoom
    $Self->{Translation}->{'Configuration Item'} = 'Elemento de configuración';
    $Self->{Translation}->{'Configuration Item Information'} = 'Información del elemento de configuración';
    $Self->{Translation}->{'Current Deployment State'} = 'Estado Actual de la Implementación';
    $Self->{Translation}->{'Last changed by'} = 'La última vez que se modificó fue por';
    $Self->{Translation}->{'Show one version'} = 'Mostrar una versión';
    $Self->{Translation}->{'Show all versions'} = 'Mostrar todas las versiones';
    $Self->{Translation}->{'Version Incident State'} = 'Estado del incidente de la versión';
    $Self->{Translation}->{'Version Deployment State'} = 'Estado de la versión de implementación';
    $Self->{Translation}->{'Version Number'} = 'Número de versión';
    $Self->{Translation}->{'Configuration Item Version Details'} = 'Elemento de configuración Detalles de la versión';
    $Self->{Translation}->{'Property'} = 'Propiedad';

    # Perl Module: Kernel/Modules/AgentITSMConfigItem.pm
    $Self->{Translation}->{'No access to Class is given!'} = '¡No se ha proporcionado acceso a Clase!';
    $Self->{Translation}->{'Overview: ITSM ConfigItem'} = 'Resumen: ITSM ConfigItem';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemBulk.pm
    $Self->{Translation}->{'No ConfigItemID is given!'} = '¡No se ha proporcionado ConfigItemID!';
    $Self->{Translation}->{'You need at least one selected Configuration Item!'} = '¡Necesita al menos un elemento de configuración seleccionado!';
    $Self->{Translation}->{'You don\'t have write access to this configuration item: %s.'} =
        'No tiene permiso de escritura para este elemento de configuración: %s';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemDelete.pm
    $Self->{Translation}->{'Config item "%s" not found in database!'} = '¡Elemento de configuración "%s"  no se encontró en la base de datos!';
    $Self->{Translation}->{'Was not able to delete the configitem ID %s!'} = '¡No fue posible eliminar el configitem ID %s!';
    $Self->{Translation}->{'No version found for ConfigItemID %s!'} = '¡No se encontró Versión para ConfigItemID %s!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemEdit.pm
    $Self->{Translation}->{'No ConfigItemID, DuplicateID or ClassID is given!'} = '¡No se ha proporcionado ConfigItemID, DuplicateID o ClassID!';
    $Self->{Translation}->{'No access is given!'} = '¡No se ha proporcionado acceso!';
    $Self->{Translation}->{'No definition was defined for class %s!'} = '¡Ninguna definición fue definida para clase %s!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemHistory.pm
    $Self->{Translation}->{'Can\'t show history, no ConfigItemID is given!'} = '¡No se puede mostrar el historial, no se ha proporcionado ConfigItemID!';
    $Self->{Translation}->{'Can\'t show history, no access rights given!'} = '¡No se puede mostrar el historial, no se han proporcionado permisos de acceso!';
    $Self->{Translation}->{'New ConfigItem (ID=%s)'} = 'Nuevo ConfigItem (ID=%s)';
    $Self->{Translation}->{'New version (ID=%s)'} = 'Nueva versión (ID=%s)';
    $Self->{Translation}->{'Deployment state updated (new=%s, old=%s)'} = 'Actualizado estado de despliegue (nuevo=%s, viejo=%s)';
    $Self->{Translation}->{'Incident state updated (new=%s, old=%s)'} = 'Actualizado estado de incidencia (nuevo=%s,viejo=%s)';
    $Self->{Translation}->{'ConfigItem (ID=%s) deleted'} = 'ConfigItem (ID=%s) eliminado';
    $Self->{Translation}->{'Link to %s (type=%s) added'} = 'Enlace a %s (tipo=%s) añadido';
    $Self->{Translation}->{'Link to %s (type=%s) deleted'} = 'Enlace a %s (tipo=%s) eliminado';
    $Self->{Translation}->{'ConfigItem definition updated (ID=%s)'} = 'Actualizada definición de ConfigItem (ID=%s)';
    $Self->{Translation}->{'Name updated (new=%s, old=%s)'} = 'Nombre actualizado (nuevo=%s,viejo=%s)';
    $Self->{Translation}->{'Attribute %s updated from "%s" to "%s"'} = 'Atributo %s actualizado de "%s" a "%s"';
    $Self->{Translation}->{'Version %s deleted'} = 'Versión %s eliminada';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemPrint.pm
    $Self->{Translation}->{'No ConfigItemID or VersionID is given!'} = '¡No se ha proporcionado ConfigItemID o VersionID!';
    $Self->{Translation}->{'Can\'t show config item, no access rights given!'} = '¡No se puede mostrar el elemento de configuración, no se han proporcionado permisos de acceso!';
    $Self->{Translation}->{'ConfigItemID %s not found in database!'} = '¡ConfigItemID %s no se encontró en la base de datos!';
    $Self->{Translation}->{'VersionID %s not found in database!'} = '¡VersionID %s no se encontró en la base de datos!';
    $Self->{Translation}->{'ConfigItem'} = 'ConfigItem';
    $Self->{Translation}->{'printed by %s at %s'} = 'impreso por %s en %s';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemSearch.pm
    $Self->{Translation}->{'Invalid ClassID!'} = '¡ClassID no es válida!';
    $Self->{Translation}->{'No ClassID is given!'} = '¡No se ha proporcionado ClassID!';
    $Self->{Translation}->{'No access rights for this class given!'} = '¡No se ha proporcionado permisos de acceso para esta clase!';
    $Self->{Translation}->{'No Result!'} = '¡Sin resultados!';
    $Self->{Translation}->{'Config Item Search Results'} = 'Resultados de búsqueda de elemento de configuración';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemZoom.pm
    $Self->{Translation}->{'Can\'t show item, no access rights for ConfigItem are given!'} =
        '¡No se puede mostrar el elemento, no se han proporcionado permisos de acceso para ConfigItem!';
    $Self->{Translation}->{'operational'} = 'operacional';
    $Self->{Translation}->{'warning'} = 'advertencia';
    $Self->{Translation}->{'incident'} = 'incidente';
    $Self->{Translation}->{'The deployment state of this config item'} = 'El estado de implementación de este elemento de configuración';
    $Self->{Translation}->{'The incident state of this config item'} = 'El estado de este elemento de configuración';

    # Perl Module: Kernel/Output/HTML/Dashboard/ITSMConfigItemGeneric.pm
    $Self->{Translation}->{'Shown config items'} = 'Se muestran elementos de configuración';

    # Perl Module: Kernel/Output/HTML/ITSMConfigItem/LayoutDate.pm
    $Self->{Translation}->{'Between'} = 'Entre';

    # Perl Module: Kernel/System/ImportExport/ObjectBackend/ITSMConfigItem.pm
    $Self->{Translation}->{'Maximum number of one element'} = 'Número máximo de un elemento ';
    $Self->{Translation}->{'Empty fields indicate that the current values are kept'} = 'Los campos vacíos indican que los valores actuales se mantienen';
    $Self->{Translation}->{'Skipped'} = 'Saltado';

    # Perl Module: var/packagesetup/ITSMConfigurationManagement.pm
    $Self->{Translation}->{'Model'} = 'Modelo';
    $Self->{Translation}->{'Customer Company'} = 'Empresa cliente';
    $Self->{Translation}->{'Serial Number'} = 'Número Serial';
    $Self->{Translation}->{'CPU'} = 'CPU';
    $Self->{Translation}->{'Ram'} = 'RAM';
    $Self->{Translation}->{'Hard Disk'} = 'Disco Duro';
    $Self->{Translation}->{'Capacity'} = 'Capacidad';
    $Self->{Translation}->{'Network Adapter'} = 'Adaptador de Red';
    $Self->{Translation}->{'IP over DHCP'} = 'IP sobre DHCP';
    $Self->{Translation}->{'IP Address'} = 'Dirección IP';
    $Self->{Translation}->{'Graphic Adapter'} = 'Tarjeta Gráfica';
    $Self->{Translation}->{'Other Equipment'} = 'Otro Equipo';
    $Self->{Translation}->{'Warranty Expiration Date'} = 'Fecha de Expiración de la Garantía';
    $Self->{Translation}->{'Install Date'} = 'Fecha de Instalación';
    $Self->{Translation}->{'Phone 1'} = 'Teléfono 1';
    $Self->{Translation}->{'Phone 2'} = 'Teléfono 2';
    $Self->{Translation}->{'E-Mail'} = 'E-Mail';
    $Self->{Translation}->{'Network Address'} = 'Dirección de Red';
    $Self->{Translation}->{'Subnet Mask'} = 'Máscara de Subred';
    $Self->{Translation}->{'Gateway'} = 'Puerta de enlace';
    $Self->{Translation}->{'Licence Type'} = 'Tipo de Licencia';
    $Self->{Translation}->{'Licence Key'} = 'Clave de Licencia';
    $Self->{Translation}->{'Quantity'} = 'Cantidad';
    $Self->{Translation}->{'Expiration Date'} = 'Fecha de Expiración';
    $Self->{Translation}->{'Media'} = 'Medio';

    # Database XML Definition: ITSMConfigurationManagement.sopm
    $Self->{Translation}->{'Computer'} = 'Ordenador';
    $Self->{Translation}->{'Hardware'} = 'Hardware';
    $Self->{Translation}->{'Network'} = 'Red';
    $Self->{Translation}->{'Software'} = 'Software';
    $Self->{Translation}->{'Expired'} = 'Expirado';
    $Self->{Translation}->{'Maintenance'} = 'Mantenimiento';
    $Self->{Translation}->{'Pilot'} = 'Piloto';
    $Self->{Translation}->{'Planned'} = 'Planificado';
    $Self->{Translation}->{'Repair'} = 'Reparación';
    $Self->{Translation}->{'Retired'} = 'Retirado';
    $Self->{Translation}->{'Review'} = 'Revisado';
    $Self->{Translation}->{'Test/QA'} = 'Prueba / Control de calidad';
    $Self->{Translation}->{'Laptop'} = 'Ordenador portátil';
    $Self->{Translation}->{'Desktop'} = 'Escritorio';
    $Self->{Translation}->{'PDA'} = 'Agenda Personal';
    $Self->{Translation}->{'Server'} = 'Servidor';
    $Self->{Translation}->{'Other'} = 'Otro';
    $Self->{Translation}->{'Monitor'} = 'Monitor';
    $Self->{Translation}->{'Printer'} = 'Impresora';
    $Self->{Translation}->{'Switch'} = 'Switch';
    $Self->{Translation}->{'Router'} = 'Enrutador';
    $Self->{Translation}->{'WLAN Access Point'} = 'Punto de Acceso WLAN';
    $Self->{Translation}->{'Security Device'} = 'Dispositivo de Seguridad';
    $Self->{Translation}->{'Backup Device'} = 'Dispositivo de Respaldo';
    $Self->{Translation}->{'Mouse'} = 'Ratón';
    $Self->{Translation}->{'Keyboard'} = 'Teclado';
    $Self->{Translation}->{'Camera'} = 'Cámara';
    $Self->{Translation}->{'Beamer'} = 'Proyector';
    $Self->{Translation}->{'Modem'} = 'Módem';
    $Self->{Translation}->{'PCMCIA Card'} = 'Tarjeta PCMCIA';
    $Self->{Translation}->{'USB Device'} = 'Dispositivo USB';
    $Self->{Translation}->{'Docking Station'} = 'Estación de acoplamiento';
    $Self->{Translation}->{'Scanner'} = 'Escáner';
    $Self->{Translation}->{'Building'} = 'Edificio';
    $Self->{Translation}->{'Office'} = 'Oficina';
    $Self->{Translation}->{'Floor'} = 'Piso';
    $Self->{Translation}->{'Room'} = 'Habitación';
    $Self->{Translation}->{'Rack'} = 'Rack';
    $Self->{Translation}->{'Workplace'} = 'Lugar de trabajo';
    $Self->{Translation}->{'Outlet'} = 'Outlet';
    $Self->{Translation}->{'IT Facility'} = 'Instalaciones de TI';
    $Self->{Translation}->{'LAN'} = 'LAN';
    $Self->{Translation}->{'WLAN'} = 'WLAN';
    $Self->{Translation}->{'Telco'} = 'Conferencia telefónica';
    $Self->{Translation}->{'GSM'} = 'GSM';
    $Self->{Translation}->{'Client Application'} = 'Aplicación Cliente';
    $Self->{Translation}->{'Middleware'} = 'Middleware';
    $Self->{Translation}->{'Server Application'} = 'Aplicación Servidor';
    $Self->{Translation}->{'Client OS'} = 'Sistema Operativo del Cliente';
    $Self->{Translation}->{'Server OS'} = 'Sistema operativo del Servidor';
    $Self->{Translation}->{'Admin Tool'} = 'Herramienta de Administración';
    $Self->{Translation}->{'User Tool'} = 'Herramienta de Usuario';
    $Self->{Translation}->{'Embedded'} = 'Embebido';
    $Self->{Translation}->{'Single Licence'} = 'Licencia Única';
    $Self->{Translation}->{'Per User'} = 'Por Usuario';
    $Self->{Translation}->{'Per Processor'} = 'Por Procesador';
    $Self->{Translation}->{'Per Server'} = 'Por Servidor';
    $Self->{Translation}->{'Per Node'} = 'Por Nodo';
    $Self->{Translation}->{'Volume Licence'} = 'Licencia por Volumen';
    $Self->{Translation}->{'Enterprise Licence'} = 'Licencia Corporativa';
    $Self->{Translation}->{'Developer Licence'} = 'Licencia de Desarrollador';
    $Self->{Translation}->{'Demo'} = 'Demostración';
    $Self->{Translation}->{'Time Restricted'} = 'Tiempo Restringido';
    $Self->{Translation}->{'Freeware'} = 'Freeware';
    $Self->{Translation}->{'Open Source'} = 'Código Abierto';
    $Self->{Translation}->{'Unlimited'} = 'Ilimitada';

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

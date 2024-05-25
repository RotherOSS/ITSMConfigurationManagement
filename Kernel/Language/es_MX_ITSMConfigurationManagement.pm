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

package Kernel::Language::es_MX_ITSMConfigurationManagement;

use strict;
use warnings;
use utf8;

sub Data {
    my $Self = shift;

    # Template: AdminITSMConfigItem
    $Self->{Translation}->{'Config Item Management'} = 'Gestión de elementos de configuración';
    $Self->{Translation}->{'Change class definition'} = 'Cambiar la definición de clase';
    $Self->{Translation}->{'Config Item Class'} = 'Clase elemento de configuración';
    $Self->{Translation}->{'Definition'} = 'Definición';
    $Self->{Translation}->{'Change'} = 'Cambiar';

    # Template: AgentDashboardITSMConfigItemGeneric
    $Self->{Translation}->{'Incident State'} = 'Estado del Incidente';
    $Self->{Translation}->{'Deployment State'} = 'Estado del despliegue';
    $Self->{Translation}->{'Class'} = 'Clase';
    $Self->{Translation}->{'Deployment State Type'} = 'Tipo de Estado de Despliegue';
    $Self->{Translation}->{'Current Incident State'} = 'Estado del Incidente Actual';
    $Self->{Translation}->{'Current Incident State Type'} = 'Tipo actual del estado del incidente';
    $Self->{Translation}->{'Last changed'} = 'Último cambio';

    # Template: AgentITSMConfigItemAdd
    $Self->{Translation}->{'Config Item'} = 'Configurar elemento';
    $Self->{Translation}->{'Filter for Classes'} = 'Filtro por clases';
    $Self->{Translation}->{'Select a Class from the list to create a new Config Item.'} = 'Seleccione una clase de la lista para crear un nuevo elemento de configuración.';

    # Template: AgentITSMConfigItemBulk
    $Self->{Translation}->{'ITSM ConfigItem Bulk Action'} = 'Acción masiva de ITSM ConfigItem';
    $Self->{Translation}->{'Deployment state'} = 'Estado del despliegue';
    $Self->{Translation}->{'Incident state'} = 'Estado del incidente';
    $Self->{Translation}->{'Link to another'} = 'Enlace a otro';
    $Self->{Translation}->{'Invalid Configuration Item number!'} = '¡Número de elemento de configuración no válido!';
    $Self->{Translation}->{'The number of another Configuration Item to link with.'} = 'El número de otro elemento de configuración con el que se va a enlazar.';

    # Template: AgentITSMConfigItemDelete
    $Self->{Translation}->{'Do you really want to delete this config item?'} = '¿Realmente quiere eliminar este elemento de configuración?';

    # Template: AgentITSMConfigItemEdit
    $Self->{Translation}->{'The name of this config item'} = 'El nombre de este elemento de configuración';
    $Self->{Translation}->{'Name is already in use by the ConfigItems with the following Number(s): %s'} =
        'El nombre ya está en uso por los ConfigItems con los siguientes números: %s';

    # Template: AgentITSMConfigItemHistory
    $Self->{Translation}->{'History of Config Item: %s'} = 'Historial del elemento de configuración: %s';
    $Self->{Translation}->{'History Content'} = 'Contenido de la historia';
    $Self->{Translation}->{'Createtime'} = 'Crear tiempo';
    $Self->{Translation}->{'Zoom view'} = 'Vista detallada';

    # Template: AgentITSMConfigItemOverviewNavBar
    $Self->{Translation}->{'Context Settings'} = 'Ajustes de contexto';
    $Self->{Translation}->{'Config Items per page'} = 'Configuración de elementos por página';

    # Template: AgentITSMConfigItemOverviewSmall
    $Self->{Translation}->{'A generic ITSM Configuration Item table'} = 'Una tabla genérica de elementos de configuración de ITSM';

    # Template: AgentITSMConfigItemSearch
    $Self->{Translation}->{'Run Search'} = 'Correr búsqueda';
    $Self->{Translation}->{'Also search in previous versions?'} = '¿También buscar en versiones anteriores?';

    # Template: AgentITSMConfigItemZoom
    $Self->{Translation}->{'Configuration Item'} = 'Elemento de configuración';
    $Self->{Translation}->{'Configuration Item Information'} = 'Información del elemento de configuración';
    $Self->{Translation}->{'Current Deployment State'} = 'Estado actual del despliegue';
    $Self->{Translation}->{'Last changed by'} = 'Modificado por última vez por';
    $Self->{Translation}->{'Show one version'} = 'Mostrar una versión';
    $Self->{Translation}->{'Show all versions'} = 'Mostrar todas las versiones';
    $Self->{Translation}->{'Version Incident State'} = 'Versión Estado del incidente';
    $Self->{Translation}->{'Version Deployment State'} = 'Estado de despliegue de la versión';
    $Self->{Translation}->{'Version Number'} = 'Número de versión';
    $Self->{Translation}->{'Configuration Item Version Details'} = 'Detalles de la versión del elemento de configuración';
    $Self->{Translation}->{'Property'} = 'Propiedad';

    # Perl Module: Kernel/Modules/AgentITSMConfigItem.pm
    $Self->{Translation}->{'No access to Class is given!'} = '¡No se tiene acceso a la clase!';
    $Self->{Translation}->{'Overview: ITSM ConfigItem'} = 'Resumen: ITSM ConfigItem';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemBulk.pm
    $Self->{Translation}->{'No ConfigItemID is given!'} = '¡No se da ningún ConfigItemID!';
    $Self->{Translation}->{'You need at least one selected Configuration Item!'} = '¡Necesita al menos un elemento de configuración seleccionado!';
    $Self->{Translation}->{'You don\'t have write access to this configuration item: %s.'} =
        'No tiene acceso de escritura a este elemento de configuración: %s.';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemDelete.pm
    $Self->{Translation}->{'Config item "%s" not found in database!'} = '¡El elemento de configuración "%s" no se encuentra en la base de datos!';
    $Self->{Translation}->{'Was not able to delete the configitem ID %s!'} = '¡No se ha podido borrar el configitem ID %s!';
    $Self->{Translation}->{'No version found for ConfigItemID %s!'} = '¡No se ha encontrado ninguna versión para ConfigItemID %s!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemEdit.pm
    $Self->{Translation}->{'No ConfigItemID, DuplicateID or ClassID is given!'} = '¡No se tiene ningún ConfigItemID, DuplicateID o ClassID!';
    $Self->{Translation}->{'No access is given!'} = '¡No se tiene acceso!';
    $Self->{Translation}->{'No definition was defined for class %s!'} = '¡No se ha definido la clase %s!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemHistory.pm
    $Self->{Translation}->{'Can\'t show history, no ConfigItemID is given!'} = 'No se puede mostrar el historial, ¡no se tiene el ConfigItemID!';
    $Self->{Translation}->{'Can\'t show history, no access rights given!'} = 'No se puede mostrar el historial, ¡no se tienen derechos de acceso!';
    $Self->{Translation}->{'New ConfigItem (ID=%s)'} = 'Nuevo elemento de configuración (ID=%s)';
    $Self->{Translation}->{'New version (ID=%s)'} = 'Nueva versión (ID=%s)';
    $Self->{Translation}->{'Deployment state updated (new=%s, old=%s)'} = 'Estado de despliegue actualizado (nuevo=%s, antiguo=%s)';
    $Self->{Translation}->{'Incident state updated (new=%s, old=%s)'} = 'Estado del incidente actualizado (nuevo=%s, antiguo=%s)';
    $Self->{Translation}->{'ConfigItem (ID=%s) deleted'} = 'ConfigItem (ID=%s) borrado';
    $Self->{Translation}->{'Link to %s (type=%s) added'} = 'Enlace a %s ( tipo=%s) añadido';
    $Self->{Translation}->{'Link to %s (type=%s) deleted'} = 'Enlace a %s ( tipo=%s) borrado';
    $Self->{Translation}->{'ConfigItem definition updated (ID=%s)'} = 'Definición de ConfigItem actualizada (ID=%s)';
    $Self->{Translation}->{'Name updated (new=%s, old=%s)'} = 'Nombre actualizado (nuevo=%s, antiguo=%s)';
    $Self->{Translation}->{'Attribute %s updated from "%s" to "%s"'} = 'Atributo %s actualizado de "%s" a "%s"';
    $Self->{Translation}->{'Version %s deleted'} = 'Versión %s borrada';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemPrint.pm
    $Self->{Translation}->{'No ConfigItemID or VersionID is given!'} = '¡No se tiene ningún ConfigItemID o VersionID!';
    $Self->{Translation}->{'Can\'t show config item, no access rights given!'} = 'No se puede mostrar el elemento de configuración, ¡no se tienen derechos de acceso!';
    $Self->{Translation}->{'ConfigItemID %s not found in database!'} = '¡ConfigItemID %s no se encuentra en la base de datos!';
    $Self->{Translation}->{'VersionID %s not found in database!'} = '¡VersionID %s no se encuentra en la base de datos!';
    $Self->{Translation}->{'ConfigItem'} = 'ConfigItem';
    $Self->{Translation}->{'printed by %s at %s'} = 'impreso por %s en %s';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemSearch.pm
    $Self->{Translation}->{'Invalid ClassID!'} = '¡ClassID inválido!';
    $Self->{Translation}->{'No ClassID is given!'} = '¡No se tiene ningún ClassID!';
    $Self->{Translation}->{'No access rights for this class given!'} = '¡No se han concedido derechos de acceso para esta clase!';
    $Self->{Translation}->{'No Result!'} = '¡No hay resultado!';
    $Self->{Translation}->{'Config Item Search Results'} = 'Resultados de la búsqueda de elementos de configuración';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemZoom.pm
    $Self->{Translation}->{'Can\'t show item, no access rights for ConfigItem are given!'} =
        'No se puede mostrar el elemento, ¡no se tienen derechos de acceso para ConfigItem!';
    $Self->{Translation}->{'operational'} = 'operacional';
    $Self->{Translation}->{'warning'} = 'advertencia';
    $Self->{Translation}->{'incident'} = 'incidente';
    $Self->{Translation}->{'The deployment state of this config item'} = 'El estado de despliegue de este elemento de configuración';
    $Self->{Translation}->{'The incident state of this config item'} = 'El estado del incidente de este elemento de configuración';

    # Perl Module: Kernel/Output/HTML/Dashboard/ITSMConfigItemGeneric.pm
    $Self->{Translation}->{'Shown config items'} = 'Elementos de configuración mostrados';

    # Perl Module: Kernel/Output/HTML/ITSMConfigItem/LayoutDate.pm
    $Self->{Translation}->{'Between'} = 'Entre';

    # Perl Module: Kernel/System/ImportExport/ObjectBackend/ITSMConfigItem.pm
    $Self->{Translation}->{'Maximum number of one element'} = 'Número máximo de un elemento';
    $Self->{Translation}->{'Empty fields indicate that the current values are kept'} = 'Los campos vacíos indican que se mantienen los valores actuales';
    $Self->{Translation}->{'Skipped'} = 'Omitido';

    # Perl Module: var/packagesetup/ITSMConfigurationManagement.pm
    $Self->{Translation}->{'Model'} = 'Módelo';
    $Self->{Translation}->{'Customer Company'} = 'Empresa cliente';
    $Self->{Translation}->{'Serial Number'} = 'Número de serie';
    $Self->{Translation}->{'CPU'} = 'CPU';
    $Self->{Translation}->{'Ram'} = 'Ram';
    $Self->{Translation}->{'Hard Disk'} = 'Disco Duro';
    $Self->{Translation}->{'Capacity'} = 'Capacidad';
    $Self->{Translation}->{'Network Adapter'} = 'Adaptador de Red';
    $Self->{Translation}->{'IP over DHCP'} = 'IP sobre DHCP';
    $Self->{Translation}->{'IP Address'} = 'Dirección IP';
    $Self->{Translation}->{'Graphic Adapter'} = 'Tarjeta de Video';
    $Self->{Translation}->{'Other Equipment'} = 'Otro Equipamiento';
    $Self->{Translation}->{'Warranty Expiration Date'} = 'Fecha de vencimiento de la garantía';
    $Self->{Translation}->{'Install Date'} = 'Fecha de Instalación';
    $Self->{Translation}->{'Phone 1'} = 'Teléfono 1';
    $Self->{Translation}->{'Phone 2'} = 'Teléfono 2';
    $Self->{Translation}->{'E-Mail'} = 'Correo electrónico';
    $Self->{Translation}->{'Network Address'} = 'Dirección de Red';
    $Self->{Translation}->{'Subnet Mask'} = 'Máscara de subred';
    $Self->{Translation}->{'Gateway'} = 'Puerta de enlace';
    $Self->{Translation}->{'Licence Type'} = 'Tipo de licencia';
    $Self->{Translation}->{'Licence Key'} = 'Clave de licencia';
    $Self->{Translation}->{'Quantity'} = 'Cantidad';
    $Self->{Translation}->{'Expiration Date'} = 'Fecha de caducidad';
    $Self->{Translation}->{'Media'} = 'Medios';

    # Database XML / SOPM Definition: ITSMConfigurationManagement.sopm
    $Self->{Translation}->{'Computer'} = 'Computador';
    $Self->{Translation}->{'Hardware'} = 'Hardware';
    $Self->{Translation}->{'Network'} = 'Red';
    $Self->{Translation}->{'Software'} = 'Software';
    $Self->{Translation}->{'Expired'} = 'Expirado';
    $Self->{Translation}->{'Maintenance'} = 'Mantenimiento';
    $Self->{Translation}->{'Pilot'} = 'Piloto';
    $Self->{Translation}->{'Planned'} = 'Planificado';
    $Self->{Translation}->{'Repair'} = 'Reparar';
    $Self->{Translation}->{'Retired'} = 'Retirado';
    $Self->{Translation}->{'Review'} = 'Revisión';
    $Self->{Translation}->{'Test/QA'} = 'Prueba/Control de calidad';
    $Self->{Translation}->{'Laptop'} = 'Computador Portátil';
    $Self->{Translation}->{'Desktop'} = 'Escritorio';
    $Self->{Translation}->{'PDA'} = 'PDA';
    $Self->{Translation}->{'Other'} = 'Otro';
    $Self->{Translation}->{'Monitor'} = 'Monitor';
    $Self->{Translation}->{'Printer'} = 'Impresora';
    $Self->{Translation}->{'Switch'} = 'Switch';
    $Self->{Translation}->{'Router'} = 'Ruteador';
    $Self->{Translation}->{'WLAN Access Point'} = 'Punto de acceso WLAN';
    $Self->{Translation}->{'Security Device'} = 'Dispositivo de seguridad';
    $Self->{Translation}->{'Backup Device'} = 'Dispositivo de Respaldo';
    $Self->{Translation}->{'Mouse'} = 'Mouse';
    $Self->{Translation}->{'Keyboard'} = 'Teclado';
    $Self->{Translation}->{'Camera'} = 'Cámara';
    $Self->{Translation}->{'Beamer'} = 'Cargador';
    $Self->{Translation}->{'Modem'} = 'Modem';
    $Self->{Translation}->{'PCMCIA Card'} = 'Tarjeta PCMCIA';
    $Self->{Translation}->{'USB Device'} = 'Dispositivo USB';
    $Self->{Translation}->{'Docking Station'} = 'Estación de acoplamiento';
    $Self->{Translation}->{'Scanner'} = 'Escaner';
    $Self->{Translation}->{'Building'} = 'Edificio';
    $Self->{Translation}->{'Office'} = 'Oficina';
    $Self->{Translation}->{'Floor'} = 'Piso';
    $Self->{Translation}->{'Room'} = 'ROM';
    $Self->{Translation}->{'Rack'} = 'Rack';
    $Self->{Translation}->{'Workplace'} = 'Lugar de trabajo';
    $Self->{Translation}->{'Outlet'} = 'Salida';
    $Self->{Translation}->{'IT Facility'} = 'Facilitador IT';
    $Self->{Translation}->{'LAN'} = 'LAN';
    $Self->{Translation}->{'WLAN'} = 'WLAN';
    $Self->{Translation}->{'Telco'} = 'Telco';
    $Self->{Translation}->{'GSM'} = 'GSM';
    $Self->{Translation}->{'Client Application'} = 'Aplicación del Cliente';
    $Self->{Translation}->{'Middleware'} = 'Middleware';
    $Self->{Translation}->{'Server Application'} = 'Aplicación de servidor';
    $Self->{Translation}->{'Client OS'} = 'Sistema Operativo del Cliente';
    $Self->{Translation}->{'Server OS'} = 'Sistema Operativo de Servidor';
    $Self->{Translation}->{'Admin Tool'} = 'Herramienta del Administración';
    $Self->{Translation}->{'User Tool'} = 'herramienta de usuario';
    $Self->{Translation}->{'Embedded'} = 'Embebido';
    $Self->{Translation}->{'Single Licence'} = 'Licencia individual';
    $Self->{Translation}->{'Per User'} = 'Por Usuario';
    $Self->{Translation}->{'Per Processor'} = 'Por Procesador';
    $Self->{Translation}->{'Per Server'} = 'Por Servidor';
    $Self->{Translation}->{'Per Node'} = 'Por Nodo';
    $Self->{Translation}->{'Volume Licence'} = 'Licencia por volumen';
    $Self->{Translation}->{'Enterprise Licence'} = 'Licencia para empresas';
    $Self->{Translation}->{'Developer Licence'} = 'Licencia del Desarrollador';
    $Self->{Translation}->{'Demo'} = 'Demo';
    $Self->{Translation}->{'Time Restricted'} = 'Tiempo limitado';
    $Self->{Translation}->{'Freeware'} = 'Freeware';
    $Self->{Translation}->{'Open Source'} = 'Open Source';
    $Self->{Translation}->{'Unlimited'} = 'Ilimitado';

    # JS File: ITSM.Agent.ConfigItem.Zoom
    $Self->{Translation}->{'Ok'} = 'Bien';

    # SysConfig
    $Self->{Translation}->{'Assigned CIs'} = 'CIs asignados';
    $Self->{Translation}->{'CIs assigned to customer company'} = 'CIs asignados a la empresa cliente';
    $Self->{Translation}->{'CIs assigned to customer user'} = 'CIs asignados al usuario cliente';
    $Self->{Translation}->{'CMDB Settings'} = 'Configuración de la CMDB';
    $Self->{Translation}->{'Check for a unique name only within the same ConfigItem class (\'class\') or globally (\'global\'), which means every existing ConfigItem is taken into account when looking for duplicates.'} =
        'Busca un nombre único sólo dentro de la misma clase de ConfigItem (\'class\') o globalmente (\'global\'), lo que significa que cada ConfigItem existente se tiene en cuenta al buscar duplicados.';
    $Self->{Translation}->{'Config Items'} = 'Elementos de configuración';
    $Self->{Translation}->{'Config item add.'} = 'Añadir elemento de configuración.';
    $Self->{Translation}->{'Config item edit.'} = 'Edición de elemento de configuración.';
    $Self->{Translation}->{'Config item event module that enables logging to history in the agent interface.'} =
        'Módulo de eventos de elementos de configuración que permite el registro en el historial de la interfaz del agente.';
    $Self->{Translation}->{'Config item history.'} = 'Historial de elementos de configuración.';
    $Self->{Translation}->{'Config item print.'} = 'Configurar elemento impresora.';
    $Self->{Translation}->{'Config item zoom.'} = 'Configurar el zoom del elemento.';
    $Self->{Translation}->{'ConfigItemNumber'} = 'ConfigItemNumber';
    $Self->{Translation}->{'ConfigItems of the following classes will not be stored on the Elasticsearch server. To apply this to existing CIs, the CI migration has to be run via console, after changing this option.'} =
        '';
    $Self->{Translation}->{'ConfigItems with the following deployment states will not be stored on the Elasticsearch server. To apply this to existing CIs, the CI migration has to be run via console, after changing this option.'} =
        '';
    $Self->{Translation}->{'Configuration Item Limit'} = 'Configuración Límite de elementos';
    $Self->{Translation}->{'Configuration Item limit per page.'} = 'Configuración Límite de elementos por página.';
    $Self->{Translation}->{'Configuration Management Database.'} = 'Base de datos de gestión de la configuración.';
    $Self->{Translation}->{'Configuration item bulk module.'} = 'Módulo de configuración de elementos individuales.';
    $Self->{Translation}->{'Configuration item search backend router of the agent interface.'} =
        'Elemento de configuración que busca el enrutamiento backend de la interfaz del agente.';
    $Self->{Translation}->{'Create and manage the definitions for Configuration Items.'} = 'Crear y gestionar las definiciones de los elementos de configuración.';
    $Self->{Translation}->{'Define Actions where a settings button is available in the linked objects widget (LinkObject::ViewMode = "complex"). Please note that these Actions must have registered the following JS and CSS files: Core.AllocationList.css, Core.UI.AllocationList.js, Core.UI.Table.Sort.js, Core.Agent.TableFilters.js and Core.Agent.LinkObject.js.'} =
        'Definir acciones en las que un botón de configuración está disponible en el widget de objetos vinculados (LinkObject::ViewMode = "complex"). Tenga en cuenta que estas acciones deben haber registrado los siguientes archivos JS y CSS: Core.AllocationList.css, Core.UI.AllocationList.js, Core.UI.Table.Sort.js, Core.Agent.TableFilters.js y Core.Agent.LinkObject.js.';
    $Self->{Translation}->{'Defines Required permissions to create ITSM configuration items using the Generic Interface.'} =
        'Define los permisos requeridos para crear elementos de configuración ITSM utilizando la Interfaz Genérica.';
    $Self->{Translation}->{'Defines Required permissions to delete ITSM configuration items using the Generic Interface.'} =
        'Define los permisos necesarios para eliminar los elementos de configuración de ITSM mediante la interfaz genérica.';
    $Self->{Translation}->{'Defines Required permissions to get ITSM configuration items using the Generic Interface.'} =
        'Define los permisos necesarios para obtener los elementos de configuración de ITSM utilizando la Interfaz Genérica.';
    $Self->{Translation}->{'Defines Required permissions to search ITSM configuration items using the Generic Interface.'} =
        'Define los permisos necesarios para buscar elementos de configuración de ITSM utilizando la Interfaz Genérica.';
    $Self->{Translation}->{'Defines Required permissions to update ITSM configuration items using the Generic Interface.'} =
        'Define los permisos necesarios para actualizar los elementos de configuración de ITSM mediante la interfaz genérica.';
    $Self->{Translation}->{'Defines an overview module to show the small view of a configuration item list.'} =
        'Define un módulo de resumen para mostrar la vista pequeña de una lista de elementos de configuración.';
    $Self->{Translation}->{'Defines regular expressions individually for each ConfigItem class to check the ConfigItem name and to show corresponding error messages.'} =
        'Define expresiones regulares individualmente para cada clase ConfigItem para comprobar el nombre de ConfigItem y mostrar los mensajes de error correspondientes.';
    $Self->{Translation}->{'Defines the default subobject of the class \'ITSMConfigItem\'.'} =
        'Define el subobjeto por defecto de la clase \'ITSMConfigItem\'.';
    $Self->{Translation}->{'Defines the number of rows for the CI definition editor in the admin interface.'} =
        'Define el número de filas del editor de definiciones CI en la interfaz de administración.';
    $Self->{Translation}->{'Defines the order of incident states from high (e.g. cricital) to low (e.g. functional).'} =
        'Define el orden de los estados de incidencia de alto (por ejemplo, crítico) a bajo (por ejemplo, funcional).';
    $Self->{Translation}->{'Defines the relevant deployment states where linked tickets can affect the status of a CI.'} =
        'Define los estados de despliegue relevantes en los que los tickets vinculados pueden afectar al estado de un CI.';
    $Self->{Translation}->{'Defines the search limit for the AgentITSMConfigItem screen.'} =
        'Define el límite de búsqueda para la pantalla AgentITSMConfigItem.';
    $Self->{Translation}->{'Defines the search limit for the AgentITSMConfigItemSearch screen.'} =
        'Define el límite de búsqueda para la pantalla AgentITSMConfigItemSearch.';
    $Self->{Translation}->{'Defines the shown columns in the config item overview. This option has no effect on the position of the column. Note: Class column is always available if filter \'All\' is selected.'} =
        'Define las columnas mostradas en la vista general de elementos de configuración. Esta opción no tiene efecto sobre la posición de la columna. Nota: La columna "Clase" siempre está disponible si se selecciona el filtro "Todos".';
    $Self->{Translation}->{'Defines the shown columns in the config item search. This option has no effect on the position of the column.'} =
        'Define las columnas mostradas en la búsqueda de elementos de configuración. Esta opción no tiene efecto sobre la posición de la columna.';
    $Self->{Translation}->{'Defines the shown columns of CIs in the config item overview depending on the CI class. Each entry must be prefixed with the class name and double colons (i.e. Computer::). There are a few CI-Attributes that are common to all CIs (example for the class Computer: Computer::Name, Computer::CurDeplState, Computer::CreateTime). To show individual CI-Attributes as defined in the CI-Definition, the following scheme must be used (example for the class Computer): Computer::HardDisk::1, Computer::HardDisk::1::Capacity::1, Computer::HardDisk::2, Computer::HardDisk::2::Capacity::1. If there is no entry for a CI class, then the default columns are shown as defined in the setting ITSMConfigItem::Frontend::AgentITSMConfigItem###ShowColumns.'} =
        'Define las columnas mostradas de los CIs en el resumen de elementos de configuración dependiendo de la clase de CI. Cada entrada debe ir precedida del nombre de la clase y de dos puntos (por ejemplo, Computer::). Hay algunos atributos CI que son comunes a todos los CIs (ejemplo para la clase Computer: Computer::Name, Computer::CurDeplState, Computer::CreateTime). Para mostrar los Atributos-Ci individuales como se definen en la Definición-Ci, se debe utilizar el siguiente esquema (ejemplo para la clase Computadora): Computador::DiscoDuro::1, Computador::DiscoDuro::1::Capacidad::1, Computador::DiscoDuro::2, Computador::DiscoDuro::2::Capacidad::1. Si no hay ninguna entrada para una clase CI, se muestran las columnas por defecto definidas en el ajuste ITSMConfigItem::Frontend::AgentITSMConfigItem###ShowColumns.';
    $Self->{Translation}->{'Defines the shown columns of CIs in the config item search depending on the CI class. Each entry must be prefixed with the class name and double colons (i.e. Computer::). There are a few CI-Attributes that are common to all CIs (example for the class Computer: Computer::Name, Computer::CurDeplState, Computer::CreateTime). To show individual CI-Attributes as defined in the CI-Definition, the following scheme must be used (example for the class Computer): Computer::HardDisk::1, Computer::HardDisk::1::Capacity::1, Computer::HardDisk::2, Computer::HardDisk::2::Capacity::1. If there is no entry for a CI class, then the default columns are shown as defined in the setting ITSMConfigItem::Frontend::AgentITSMConfigItem###ShowColumns.'} =
        'Define las columnas mostradas de CIs en la búsqueda de elementos de configuración dependiendo de la clase de CI. Cada entrada debe ir precedida del nombre de la clase y de dos puntos (por ejemplo, Computer::). Hay algunos atributos CI que son comunes a todos los CIs (ejemplo para la clase Computer: Computer::Name, Computer::CurDeplState, Computer::CreateTime). Para mostrar los Atributos-Ci individuales como se definen en la Definición-Ci, se debe utilizar el siguiente esquema (ejemplo para la clase Computador): Computador::DiscoDuro::1, Computador::DiscoDuro::1::Capacidad::1, Computador::DiscoDuro::2, Computador::DiscoDuro::2::Capacidad::1. Si no hay ninguna entrada para una clase CI, se muestran las columnas por defecto definidas en el ajuste ITSMConfigItem::Frontend::AgentITSMConfigItem###ShowColumns.';
    $Self->{Translation}->{'Defines the shown columns of CIs in the config item widget depending on the CI class. Each entry must be prefixed with the class name and double colons (i.e. Computer::). There are a few CI-Attributes that are common to all CIs (example for the class Computer: Computer::Name, Computer::CurDeplState, Computer::CreateTime). To show individual CI-Attributes as defined in the CI-Definition, the following scheme must be used (example for the class Computer): Computer::HardDisk::1, Computer::HardDisk::1::Capacity::1, Computer::HardDisk::2, Computer::HardDisk::2::Capacity::1. If there is no entry for a CI class, then the default columns are shown as defined in the setting AgentCustomerInformationCenter::Backend###0060-CIC-ITSMConfigItemCustomerCompany (key DefaultColumns).'} =
        'Define las columnas mostradas de CIs en el widget de elementos de configuración dependiendo de la clase de CI. Cada entrada debe ir precedida del nombre de la clase y de dos puntos (por ejemplo, Computer::). Hay algunos atributos CI que son comunes a todos los CIs (ejemplo para la clase Computer: Computer::Name, Computer::CurDeplState, Computer::CreateTime). Para mostrar los Atributos-Ci individuales como se definen en la Definición-Ci, se debe utilizar el siguiente esquema (ejemplo para la clase Computador): Computador::DiscoDuro::1, Computador::DiscoDuro::1::Capacidad::1, Computador::DiscoDuro::2, Computador::DiscoDuro::2::Capacidad::1. Si no hay ninguna entrada para una clase CI, se muestran las columnas por defecto definidas en el ajuste AgentCustomerInformationCenter::Backend##0060-CIC-ITSMConfigItemCustomerCompany (clave DefaultColumns).';
    $Self->{Translation}->{'Defines the shown columns of CIs in the link table complex view for all CI classes. If there is no entry, then the default columns are shown.'} =
        'Define las columnas mostradas de los CIs en la vista compleja de la tabla de enlaces para todas las clases de CI. Si no hay ninguna entrada, se muestran las columnas por defecto.';
    $Self->{Translation}->{'Defines the shown columns of CIs in the link table complex view, depending on the CI class. Each entry must be prefixed with the class name and double colons (i.e. Computer::). There are a few CI-Attributes that common to all CIs (example for the class Computer: Computer::Name, Computer::CurDeplState, Computer::CreateTime). To show individual CI-Attributes as defined in the CI-Definition, the following scheme must be used (example for the class Computer): Computer::HardDisk::1, Computer::HardDisk::1::Capacity::1, Computer::HardDisk::2, Computer::HardDisk::2::Capacity::1. If there is no entry for a CI class, then the default columns are shown.'} =
        'Define las columnas mostradas de los CIs en la vista compleja de la tabla de enlaces, dependiendo de la clase de CI. Cada entrada debe llevar como prefijo el nombre de la clase y dos puntos dobles (por ejemplo, Computer::). Hay algunos atributos CI que son comunes a todos los CIs (ejemplo para la clase Computador: Computer::Name, Computer::CurDeplState, Computer::CreateTime). Para mostrar los Atributos-Ci individuales como se definen en la Definición-Ci, se debe utilizar el siguiente esquema (ejemplo para la clase Computador): Ordenador::DiscoDuro::1, Computador::DiscoDuro::1::Capacidad::1, Computador::DiscoDuro::2, Computador::DiscoDuro::2::Capacidad::1. Si no hay ninguna entrada para una clase CI, se muestran las columnas por defecto.';
    $Self->{Translation}->{'Defines which type of link (named from the ticket perspective) can affect the status of a linked CI.'} =
        'Define qué tipo de enlace (nombrado desde la perspectiva del ticket) puede afectar al estado de un CI vinculado.';
    $Self->{Translation}->{'Defines which type of ticket can affect the status of a linked CI.'} =
        'Define qué tipo de ticket puede afectar al estado de un CI vinculado.';
    $Self->{Translation}->{'Delete Configuration Item'} = 'Borrar elemento de configuración';
    $Self->{Translation}->{'Deployment State Color'} = 'Color del Estado de Despliegue';
    $Self->{Translation}->{'Duplicate'} = 'Duplicado';
    $Self->{Translation}->{'Enables configuration item bulk action feature for the agent frontend to work on more than one configuration item at a time.'} =
        'Activa la función de acción masiva de elementos de configuración para que el frontend del agente trabaje en más de un elemento de configuración a la vez.';
    $Self->{Translation}->{'Enables configuration item bulk action feature only for the listed groups.'} =
        'Activa la función de acción masiva de elementos de configuración sólo para los grupos de la lista.';
    $Self->{Translation}->{'Enables/disables the functionality to check ConfigItems for unique names. Before enabling this option you should check your system for already existing config items with duplicate names. You can do this with the script bin/otobo.ITSMConfigItemListDuplicates.pl.'} =
        'Activa/desactiva la funcionalidad de comprobar que los elementos de configuración tienen nombres únicos. Antes de habilitar esta opción debe comprobar que su sistema no tiene elementos de configuración con nombres duplicados. Puede hacerlo con el script bin/otobo.ITSMConfigItemListDuplicates.pl.';
    $Self->{Translation}->{'Event module to set configitem-status on ticket-configitem-link.'} =
        'Módulo de eventos para establecer el estado del elemento de configuración en el ticket-configitem-enlace.';
    $Self->{Translation}->{'Fields of the configuration item index, used for the fulltext search. Fields are also stored, but are not mandatory for the overall functionality. Inclusion of attachments can be disabled by setting the entry to 0 or deleting it.'} =
        '';
    $Self->{Translation}->{'Fields stored in the configuration item index which are used for other things besides fulltext searches. For the complete functionality all fields are mandatory.'} =
        '';
    $Self->{Translation}->{'ITSM config item overview.'} = 'Resumen de elementos de configuración de ITSM.';
    $Self->{Translation}->{'Module to check the group responsible for a class.'} = 'Módulo para comprobar el grupo responsable de una clase.';
    $Self->{Translation}->{'Module to check the group responsible for a configuration item.'} =
        'Módulo para comprobar el grupo responsable de un elemento de configuración.';
    $Self->{Translation}->{'Module to generate ITSM config item statistics.'} = 'Módulo para generar estadísticas de elementos de configuración ITSM.';
    $Self->{Translation}->{'Object backend module registration for the import/export module.'} =
        'Registro del módulo backend de objetos para el módulo de importación/exportación.';
    $Self->{Translation}->{'Objects to search for, how many entries and which attributs to show. ConfigItem attributes have to explicitly be stored via Elasticsearch.'} =
        '';
    $Self->{Translation}->{'Overview.'} = 'Vista General.';
    $Self->{Translation}->{'Parameters for the dashboard backend of the customer company config item overview of the agent interface . "Limit" is the number of entries shown by default. "Group" is used to restrict the access to the plugin (e. g. Group: admin;group1;group2;). "Default" determines if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" is the cache time in minutes for the plugin.'} =
        'Parámetros para el backend del tablero de mandos de la vista general de elementos de configuración de la empresa cliente de la interfaz del agente . "Límite" es el número de entradas que se muestran por defecto. "Grupo" se utiliza para restringir el acceso al plugin (por ejemplo, Grupo: admin;group1;group2;). "Por defecto" determina si el plugin está habilitado por defecto o si el usuario tiene que habilitarlo manualmente. "CacheTTLLocal" es el tiempo de caché en minutos para el plugin.';
    $Self->{Translation}->{'Parameters for the deployment states color in the preferences view of the agent interface.'} =
        'Parámetros para el color de los estados de despliegue en la vista de preferencias de la interfaz del agente.';
    $Self->{Translation}->{'Parameters for the deployment states in the preferences view of the agent interface.'} =
        'Parámetros para los estados de despliegue en la vista de preferencias de la interfaz del agente.';
    $Self->{Translation}->{'Parameters for the example permission groups of the general catalog attributes.'} =
        'Parámetros para el ejemplo de permisos de grupo del catálogo general de atributos.';
    $Self->{Translation}->{'Parameters for the pages (in which the configuration items are shown).'} =
        'Parámetros para las páginas (en las que se muestran los elementos de configuración).';
    $Self->{Translation}->{'Performs the configured action for each event (as an Invoker) for each configured Webservice.'} =
        '';
    $Self->{Translation}->{'Permission Group'} = 'Permisos de grupo';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item screen in the agent interface.'} =
        'Permisos necesarios para utilizar la pantalla de elementos de configuración de ITSM en la interfaz del agente.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item search screen in the agent interface.'} =
        'Permisos necesarios para utilizar la pantalla de búsqueda de elementos de configuración de ITSM en la interfaz del agente.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item zoom screen in the agent interface.'} =
        'Permisos necesarios para utilizar la pantalla de ampliación de elementos de configuración de ITSM en la interfaz del agente.';
    $Self->{Translation}->{'Required permissions to use the add ITSM configuration item screen in the agent interface.'} =
        'Permisos necesarios para utilizar la pantalla de añadir elementos de configuración ITSM en la interfaz del agente.';
    $Self->{Translation}->{'Required permissions to use the edit ITSM configuration item screen in the agent interface.'} =
        'Permisos necesarios para utilizar la pantalla de edición de elementos de configuración de ITSM en la interfaz del agente.';
    $Self->{Translation}->{'Required permissions to use the history ITSM configuration item screen in the agent interface.'} =
        'Permisos necesarios para utilizar la pantalla de elementos de configuración del historial de ITSM en la interfaz del agente.';
    $Self->{Translation}->{'Required permissions to use the print ITSM configuration item screen in the agent interface.'} =
        'Permisos necesarios para utilizar la pantalla de impresión de elementos de configuración de ITSM en la interfaz del agente..';
    $Self->{Translation}->{'Required privileges to delete config items.'} = 'Privilegios necesarios para eliminar elementos de configuración.';
    $Self->{Translation}->{'Search config items.'} = 'Buscar elementos de configuración.';
    $Self->{Translation}->{'Selects the configuration item number generator module. "AutoIncrement" increments the configuration item number, the SystemID, the ConfigItemClassID and the counter are used. The format is "SystemID.ConfigItemClassID.Counter", e.g. 1205000004, 1205000005.'} =
        'Selecciona el módulo generador de números de elementos de configuración. "AutoIncremento" incrementa el número de elemento de configuración, se utiliza el SystemID, el ConfigItemClassID y el contador. El formato es "SystemID.ConfigItemClassID.Counter", por ejemplo, 1205000004, 1205000005.';
    $Self->{Translation}->{'Set the incident state of a CI automatically when a Ticket is Linked to a CI.'} =
        'Establezca el estado de la incidencia de un CI de forma automática cuando se vincule un ticket a un CI.';
    $Self->{Translation}->{'Sets the deployment state in the configuration item bulk screen of the agent interface.'} =
        'Establece el estado de despliegue en la pantalla de configuración de la interfaz del agente.';
    $Self->{Translation}->{'Sets the incident state in the configuration item bulk screen of the agent interface.'} =
        'Establece el estado de la incidencia en la pantalla de configuración de la interfaz del agente.';
    $Self->{Translation}->{'Shows a link in the menu that allows linking a configuration item with another object in the config item zoom view of the agent interface.'} =
        'Muestra un enlace en el menú que permite vincular un elemento de configuración con otro objeto en la vista de zoom de elementos de configuración de la interfaz del agente.';
    $Self->{Translation}->{'Shows a link in the menu to access the history of a configuration item in the configuration item overview of the agent interface.'} =
        'Muestra un enlace en el menú para acceder al historial de un elemento de configuración en el resumen de elementos de configuración de la interfaz del agente.';
    $Self->{Translation}->{'Shows a link in the menu to access the history of a configuration item in the its zoom view of the agent interface.'} =
        'Muestra un enlace en el menú para acceder al historial de un elemento de configuración en la vista de zoom de la interfaz del agente.';
    $Self->{Translation}->{'Shows a link in the menu to delete a configuration item in its zoom view of the agent interface.'} =
        'Muestra un enlace en el menú para eliminar un elemento de configuración en su vista de zoom de la interfaz del agente.';
    $Self->{Translation}->{'Shows a link in the menu to duplicate a configuration item in the configuration item overview of the agent interface.'} =
        'Muestra un enlace en el menú para duplicar un elemento de configuración en el resumen de elementos de configuración de la interfaz del agente.';
    $Self->{Translation}->{'Shows a link in the menu to duplicate a configuration item in the its zoom view of the agent interface.'} =
        'Muestra un enlace en el menú para duplicar un elemento de configuración en la vista de zoom de la interfaz del agente.';
    $Self->{Translation}->{'Shows a link in the menu to edit a configuration item in the its zoom view of the agent interface.'} =
        'Muestra un enlace en el menú para editar un elemento de configuración en la vista de zoom de la interfaz del agente.';
    $Self->{Translation}->{'Shows a link in the menu to go back in the configuration item zoom view of the agent interface.'} =
        'Muestra un enlace en el menú para volver a la vista de zoom del elemento de configuración de la interfaz del agente.';
    $Self->{Translation}->{'Shows a link in the menu to print a configuration item in the its zoom view of the agent interface.'} =
        'Muestra un enlace en el menú para imprimir un elemento de configuración en su vista de zoom de la interfaz del agente.';
    $Self->{Translation}->{'Shows a link in the menu to zoom into a configuration item in the configuration item overview of the agent interface.'} =
        'Muestra un enlace en el menú para ampliar un elemento de configuración en el resumen de elementos de configuración de la interfaz del agente.';
    $Self->{Translation}->{'Shows the config item history (reverse ordered) in the agent interface.'} =
        'Muestra el historial de elementos de configuración (ordenado de forma inversa) en la interfaz del agente.';
    $Self->{Translation}->{'The identifier for a configuration item, e.g. ConfigItem#, MyConfigItem#. The default is ConfigItem#.'} =
        'El identificador de un elemento de configuración, por ejemplo ConfigItem#, MyConfigItem#. El valor por defecto es ConfigItem#.';
    $Self->{Translation}->{'class'} = 'Clase';
    $Self->{Translation}->{'global'} = 'global';
    $Self->{Translation}->{'postproductive'} = 'postproductivo';
    $Self->{Translation}->{'preproductive'} = 'preproductivo';
    $Self->{Translation}->{'productive'} = 'productivo';


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

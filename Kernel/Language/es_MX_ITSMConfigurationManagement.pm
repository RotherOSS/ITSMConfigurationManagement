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

package Kernel::Language::es_MX_ITSMConfigurationManagement;

use strict;
use warnings;
use utf8;

sub Data {
    my $Self = shift;

    # Template: AdminITSMConfigItem
    $Self->{Translation}->{'Config Item Management'} = 'Gestión de elementos de configuración';
    $Self->{Translation}->{'Change class definition'} = 'Cambiar la definición de clase';
    $Self->{Translation}->{'Change role definition'} = 'Cambiar la definición del rol';
    $Self->{Translation}->{'Ready2Import Class Bundles'} = 'Paquetes de clases Ready2Import';
    $Self->{Translation}->{'Here you can import Ready2Import class bundles showcasing our most usual config items. Please note that some additional configuration may be required.'} =
        'Aquí puedes importar paquetes de clases Ready2Import que muestran nuestros elementos de configuración más habituales. Tenga en cuenta que puede ser necesaria alguna configuración adicional.';
    $Self->{Translation}->{'Update existing entities'} = 'Actualizar las entidades existentes';
    $Self->{Translation}->{'Import Ready2Adopt class bundles'} = 'Importar paquetes de clases Ready2Adopt';
    $Self->{Translation}->{'Config Item Class'} = 'Clase elemento de configuración';
    $Self->{Translation}->{'Config Item Role'} = 'Config Item Rol';

    # Template: AgentITSMConfigItemAdd
    $Self->{Translation}->{'Config Item'} = 'Configurar elemento';
    $Self->{Translation}->{'Filter for Classes'} = 'Filtro por clases';
    $Self->{Translation}->{'Select a Class from the list to create a new Config Item.'} = 'Seleccione una clase de la lista para crear un nuevo elemento de configuración.';
    $Self->{Translation}->{'Class'} = 'Clase';

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
    $Self->{Translation}->{'Version Number'} = 'Número de versión';
    $Self->{Translation}->{'Version number of this config item'} = 'Número de versión de este elemento de configuración';
    $Self->{Translation}->{'Version Number is already in use by the ConfigItems with the following Number(s): %s'} =
        'Número de versión ya está en uso por el ConfigItems con el siguiente número (s): %s';
    $Self->{Translation}->{'Deployment State'} = 'Estado del despliegue';
    $Self->{Translation}->{'Incident State'} = 'Estado del Incidente';

    # Template: AgentITSMConfigItemHistory
    $Self->{Translation}->{'History of Config Item: %s'} = 'Historial del elemento de configuración: %s';
    $Self->{Translation}->{'History Content'} = 'Contenido de la historia';
    $Self->{Translation}->{'Createtime'} = 'Crear tiempo';
    $Self->{Translation}->{'Zoom view'} = 'Vista detallada';

    # Template: AgentITSMConfigItemOverviewNavBar
    $Self->{Translation}->{'Config Items per page'} = 'Configuración de elementos por página';

    # Template: AgentITSMConfigItemOverviewSmall
    $Self->{Translation}->{'No config item data found.'} = 'No se han encontrado datos de elementos de configuración.';
    $Self->{Translation}->{'Select this config item'} = 'Seleccione este elemento de configuración';

    # Template: AgentITSMConfigItemSearch
    $Self->{Translation}->{'Run Search'} = 'Correr búsqueda';
    $Self->{Translation}->{'Also search in previous versions?'} = '¿También buscar en versiones anteriores?';

    # Template: AgentITSMConfigItemTreeView
    $Self->{Translation}->{'TreeView for ConfigItem'} = 'TreeView para ConfigItem';
    $Self->{Translation}->{'Depth Level'} = 'Nivel de profundidad';
    $Self->{Translation}->{'Zoom In/Out'} = 'Acercar/Alejar';
    $Self->{Translation}->{'Max links level reached for ConfigItem!'} = '¡Nivel máximo de enlaces alcanzado para ConfigItem!';

    # Template: AgentITSMConfigItemZoom
    $Self->{Translation}->{'Configuration Item'} = 'Elemento de configuración';
    $Self->{Translation}->{'Configuration Item Information'} = 'Información del elemento de configuración';
    $Self->{Translation}->{'Current Deployment State'} = 'Estado actual del despliegue';
    $Self->{Translation}->{'Current Incident State'} = 'Estado del Incidente Actual';
    $Self->{Translation}->{'Last changed'} = 'Último cambio';
    $Self->{Translation}->{'Last changed by'} = 'Modificado por última vez por';

    # Template: CustomerITSMConfigItem
    $Self->{Translation}->{'Your ConfigItems'} = 'Sus elementos de configuración';

    # Template: CustomerITSMConfigItemSearch
    $Self->{Translation}->{'ConfigItem Search'} = 'Búsqueda ConfigItem';

    # Template: AdminACL
    $Self->{Translation}->{'Object Type'} = 'Tipo de objeto';

    # JS Template: ClassImportConfirm
    $Self->{Translation}->{'The following classes will be imported'} = 'Se importarán las siguientes clases';
    $Self->{Translation}->{'The following roles will be imported'} = 'Se importarán las siguientes funciones';
    $Self->{Translation}->{'Note that also corresponding dynamic fields and GeneralCatalog classes will be created and there is no automatic removal.'} =
        'Tenga en cuenta que también se crearán los campos dinámicos y las clases GeneralCatalog correspondientes y que no se eliminarán automáticamente.';
    $Self->{Translation}->{'Do you want to proceed?'} = '¿Quieres continuar?';

    # Perl Module: Kernel/Modules/AdminITSMConfigItem.pm
    $Self->{Translation}->{'Need ExampleClasses!'} = '¡Necesita ExampleClasses!';
    $Self->{Translation}->{'Definition is no valid YAML hash.'} = 'La definición no es un hash YAML válido.';

    # Perl Module: Kernel/Modules/AgentITSMConfigItem.pm
    $Self->{Translation}->{'Overview: ITSM ConfigItem'} = 'Resumen: ITSM ConfigItem';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemBulk.pm
    $Self->{Translation}->{'No ConfigItemID is given!'} = '¡No se da ningún ConfigItemID!';
    $Self->{Translation}->{'You need at least one selected Configuration Item!'} = '¡Necesita al menos un elemento de configuración seleccionado!';
    $Self->{Translation}->{'You don\'t have write access to this configuration item: %s.'} =
        'No tiene acceso de escritura a este elemento de configuración: %s.';
    $Self->{Translation}->{'No definition was defined for class %s!'} = '¡No se ha definido la clase %s!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemDelete.pm
    $Self->{Translation}->{'Config item "%s" not found in database!'} = '¡El elemento de configuración "%s" no se encuentra en la base de datos!';
    $Self->{Translation}->{'Was not able to delete the configitem ID %s!'} = '¡No se ha podido borrar el configitem ID %s!';
    $Self->{Translation}->{'No version found for ConfigItemID %s!'} = '¡No se ha encontrado ninguna versión para ConfigItemID %s!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemEdit.pm
    $Self->{Translation}->{'No ConfigItemID, DuplicateID or ClassID is given!'} = '¡No se tiene ningún ConfigItemID, DuplicateID o ClassID!';
    $Self->{Translation}->{'No access is given!'} = '¡No se tiene acceso!';

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
    $Self->{Translation}->{'ConfigItem not found!'} = '¡ConfigItem no encontrado!';
    $Self->{Translation}->{'No versions found!'} = 'No se han encontrado versiones.';
    $Self->{Translation}->{'operational'} = 'operacional';
    $Self->{Translation}->{'warning'} = 'advertencia';
    $Self->{Translation}->{'incident'} = 'incidente';
    $Self->{Translation}->{'The deployment state of this config item'} = 'El estado de despliegue de este elemento de configuración';
    $Self->{Translation}->{'The incident state of this config item'} = 'El estado del incidente de este elemento de configuración';

    # Perl Module: Kernel/Modules/CustomerITSMConfigItemSearch.pm
    $Self->{Translation}->{'No permission'} = 'Sin permiso';
    $Self->{Translation}->{'Filter invalid!'} = '¡Filtro inválido!';
    $Self->{Translation}->{'Search params invalid!'} = 'Parámetros de búsqueda inválidos';

    # Perl Module: Kernel/Output/HTML/Dashboard/ITSMConfigItemGeneric.pm
    $Self->{Translation}->{'Shown config items'} = 'Elementos de configuración mostrados';
    $Self->{Translation}->{'Deployment State Type'} = 'Tipo de Estado de Despliegue';
    $Self->{Translation}->{'Current Incident State Type'} = 'Tipo actual del estado del incidente';

    # Perl Module: Kernel/Output/HTML/ITSMConfigItem/LayoutDate.pm
    $Self->{Translation}->{'Between'} = 'Entre';

    # Perl Module: Kernel/System/DynamicField/Driver/ConfigItem.pm
    $Self->{Translation}->{'Class restrictions for the config item'} = 'Restricciones de clase para el elemento de configuración';
    $Self->{Translation}->{'Select one or more classes to restrict selectable config items'} =
        'Seleccione una o más clases para restringir los elementos de configuración seleccionables';
    $Self->{Translation}->{'Link type'} = 'Tipo de enlace';
    $Self->{Translation}->{'Select the link type.'} = 'Seleccione el tipo de enlace.';
    $Self->{Translation}->{'Forwards: Referencing (Source) -> Referenced (Target)'} = 'Hacia adelante: Referenciado (Origen) -> Referenciado (Destino)';
    $Self->{Translation}->{'Backwards: Referenced (Source) -> Referencing (Target)'} = 'Hacia atrás: Referenciado (Origen) -> Referenciado (Destino)';
    $Self->{Translation}->{'Link Direction'} = 'Enlace Dirección';
    $Self->{Translation}->{'The referencing object is the one containing this dynamic field, the referenced object is the one selected as value of the dynamic field.'} =
        'El objeto de referencia es el que contiene este campo dinámico, el objeto referenciado es el seleccionado como valor del campo dinámico.';
    $Self->{Translation}->{'Dynamic (ConfigItem)'} = 'Dinámico (ConfigItem)';
    $Self->{Translation}->{'Static (Version)'} = 'Estática (Versión)';
    $Self->{Translation}->{'Link Referencing Type'} = 'Tipo de referencia de enlace';
    $Self->{Translation}->{'Whether this link applies to the ConfigItem or the static version of the referencing object. Current Incident State calculation only is performed on dynamic links.'} =
        'Si este enlace se aplica al elemento de configuración o a la versión estática del objeto de referencia. El cálculo del estado actual del incidente sólo se realiza en los enlaces dinámicos.';
    $Self->{Translation}->{'Select the attribute which config items will be searched by'} = 'Seleccione el atributo por el que se buscarán los elementos de configuración';

    # Perl Module: Kernel/System/ITSMConfigItem/Definition.pm
    $Self->{Translation}->{'Base structure is not valid. Please provide a hash with data in YAML format.'} =
        'La estructura base no es válida. Por favor, proporcione un hash con datos en formato YAML.';
    $Self->{Translation}->{'Starting the YAML string with \'---\' is required.'} = 'Es necesario que la cadena YAML comience por \'---\'.';

    # Perl Module: Kernel/System/ITSMConfigItem/Link.pm
    $Self->{Translation}->{'Could not purge the table configitem_link.'} = 'No se ha podido purgar la tabla configitem_link.';
    $Self->{Translation}->{'No relevant dynamic fields were found'} = 'No se han encontrado campos dinámicos relevantes';
    $Self->{Translation}->{'Could not insert into the table configitem_link'} = 'No se ha podido insertar en la tabla configitem_link';
    $Self->{Translation}->{'Inserted 0 rows into the table configitem_link'} = 'Insertadas 0 filas en la tabla configitem_link';

    # Perl Module: Kernel/System/ImportExport/ObjectBackend/ITSMConfigItem.pm
    $Self->{Translation}->{'Maximum number of one element'} = 'Número máximo de un elemento';
    $Self->{Translation}->{'Empty fields indicate that the current values are kept'} = 'Los campos vacíos indican que se mantienen los valores actuales';
    $Self->{Translation}->{'Skipped'} = 'Omitido';

    # Perl Module: Kernel/Modules/AdminDynamicField.pm
    $Self->{Translation}->{'Error synchronizing the definitions. Please check the log.'} = 'Error al sincronizar las definiciones. Por favor, compruebe el registro.';
    $Self->{Translation}->{'You have ITSMConfigItem definitions which are not synchronized. Please deploy your ITSMConfigItem dynamic field changes.'} =
        'Tiene definiciones de ITSMConfigItem que no están sincronizadas. Despliegue los cambios en los campos dinámicos de ITSMConfigItem.';

    # Database XML / SOPM Definition: ITSMConfigurationManagement.sopm
    $Self->{Translation}->{'Expired'} = 'Expirado';
    $Self->{Translation}->{'Maintenance'} = 'Mantenimiento';
    $Self->{Translation}->{'Pilot'} = 'Piloto';
    $Self->{Translation}->{'Planned'} = 'Planificado';
    $Self->{Translation}->{'Repair'} = 'Reparar';
    $Self->{Translation}->{'Retired'} = 'Retirado';
    $Self->{Translation}->{'Review'} = 'Revisión';
    $Self->{Translation}->{'Test/QA'} = 'Prueba/Control de calidad';

    # JS File: ITSM.Admin.ITSMConfigItem
    $Self->{Translation}->{'Overview and Confirmation'} = 'Visión general y confirmación';
    $Self->{Translation}->{'Importing classes/roles and their related fields'} = 'Importar clases/roles y sus campos relacionados';
    $Self->{Translation}->{'An error occurred during class import.'} = 'Se ha producido un error durante la importación de la clase.';

    # SysConfig
    $Self->{Translation}->{'0 - Hidden'} = '0 - Oculto';
    $Self->{Translation}->{'1 - Shown'} = '1 - Se muestra';
    $Self->{Translation}->{'Allows extended search conditions in config item search of the agent interface. With this feature you can search e. g. config item name with this kind of conditions like "(*key1*&&*key2*)" or "(*key1*||*key2*)".'} =
        'Permite condiciones de búsqueda extendidas en la búsqueda de elementos de configuración de la interfaz del agente. Con esta función puede buscar, por ejemplo, el nombre de un elemento de configuración con condiciones como "(*clave1*&&*clave2*)" o "(*clave1*||*clave2*)".';
    $Self->{Translation}->{'Allows extended search conditions in config item search of the customer interface. With this feature you can search e. g. config item name with this kind of conditions like "(*key1*&&*key2*)" or "(*key1*||*key2*)".'} =
        'Permite ampliar las condiciones de búsqueda en la búsqueda de elementos de configuración de la interfaz de cliente. Con esta función puede buscar, por ejemplo, el nombre del elemento de configuración con este tipo de condiciones como "(*clave1*&&*clave2*)" o "(*clave1*||*clave2*)".';
    $Self->{Translation}->{'Assigned CIs'} = 'CIs asignados';
    $Self->{Translation}->{'At a specific time point create a ticket for config items, if the configured requirements are met. The time point is determined by the value of the field configured under "TimeCIKey" of the ConfigItem, and modified by "TimeModifier". If the latter can be either just a number, or a sign (+/-), a number, and an unit (d/h/m): "7" is equivalent to "+7d". The DynamicField "Ticket->DynamicField" will be used to mark created tickets - it has to exist. The flags \<OTOBO_CONFIGITEM_X\> where X can be NAME, NUMBER and DATE, will be substituted with the respective values in "Ticket->Text".'} =
        'En un punto de tiempo específico crea un ticket para los elementos config, si se cumplen los requisitos configurados. El punto temporal viene determinado por el valor del campo configurado en "TimeCIKey" del ConfigItem, y modificado por "TimeModifier". Este último puede ser sólo un número, o un signo (+/-), un número y una unidad (d/h/m): "7" equivale a "+7d". El DynamicField "Ticket->DynamicField" se utilizará para marcar los tickets creados - tiene que existir. Los indicadores \<OTOBO_CONFIGITEM_X\> donde X puede ser NOMBRE, NÚMERO y FECHA, se sustituirán por los valores respectivos en "Ticket->Texto".';
    $Self->{Translation}->{'CIs assigned to customer company'} = 'CIs asignados a la empresa cliente';
    $Self->{Translation}->{'CIs assigned to customer user'} = 'CIs asignados al usuario cliente';
    $Self->{Translation}->{'CMDB Settings'} = 'Configuración de la CMDB';
    $Self->{Translation}->{'Check for a unique name only within the same ConfigItem class (\'class\') or globally (\'global\'), which means every existing ConfigItem is taken into account when looking for duplicates.'} =
        'Busca un nombre único sólo dentro de la misma clase de ConfigItem (\'class\') o globalmente (\'global\'), lo que significa que cada ConfigItem existente se tiene en cuenta al buscar duplicados.';
    $Self->{Translation}->{'Choose a module to enforce a naming scheme.'} = 'Elija un módulo para aplicar un esquema de nombres.';
    $Self->{Translation}->{'Choose a module to enforce a number scheme.'} = 'Elija un módulo para aplicar un esquema numérico.';
    $Self->{Translation}->{'Choose a module to enforce a version string scheme.'} = 'Elija un módulo para aplicar un esquema de cadenas de versiones.';
    $Self->{Translation}->{'Choose attributes to trigger the creation of a new version.'} = 'Elija atributos para activar la creación de una nueva versión.';
    $Self->{Translation}->{'Choose categories to assign to this config item class.'} = 'Elija las categorías que desea asignar a esta clase de elemento de configuración.';
    $Self->{Translation}->{'Column config item filters for ConfigItem Overview.'} = 'Filtros de elementos de configuración de columna para ConfigItem Overview.';
    $Self->{Translation}->{'Columns that can be filtered in the config item overview of the agent interface. Note: Only Config Item attributes and Dynamic Fields (DynamicField_NameX) are allowed.'} =
        'Columnas que se pueden filtrar en la vista general de elementos de configuración de la interfaz del agente. Nota: Solo se permiten atributos de elementos de configuración y campos dinámicos (DynamicField_NameX).';
    $Self->{Translation}->{'Columns that can be filtered in the config item overview of the customer interface. Note: Only Config Item attributes and Dynamic Fields (DynamicField_NameX) are allowed.'} =
        'Columnas que pueden filtrarse en la vista general de elementos de configuración de la interfaz de cliente. Nota: Solo se permiten atributos de elementos de configuración y campos dinámicos (DynamicField_NameX).';
    $Self->{Translation}->{'Columns that can be filtered in the config item search result overview of the agent interface. Note: Only Config Item attributes and Dynamic Fields (DynamicField_NameX) are allowed.'} =
        'Número de versión de este elemento de configuración';
    $Self->{Translation}->{'Config Items'} = 'Elementos de configuración';
    $Self->{Translation}->{'Config item add.'} = 'Añadir elemento de configuración.';
    $Self->{Translation}->{'Config item edit.'} = 'Edición de elemento de configuración.';
    $Self->{Translation}->{'Config item event module that count the licenses for OTOBOCILicenseCount feature.'} =
        'Configure el módulo de eventos que cuenta las licencias para la función OTOBOCILicenseCount.';
    $Self->{Translation}->{'Config item event module that enables logging to history in the agent interface.'} =
        'Módulo de eventos de elementos de configuración que permite el registro en el historial de la interfaz del agente.';
    $Self->{Translation}->{'Config item event module that updates config items to their current definition.'} =
        'Módulo de eventos de elementos de configuración que actualiza los elementos de configuración a su definición actual.';
    $Self->{Translation}->{'Config item event module that updates the table configitem_ĺink.'} =
        'Módulo de eventos de elementos de configuración que actualiza la tabla configitem_ĺink.';
    $Self->{Translation}->{'Config item event module updates the current incident state.'} =
        'El módulo de eventos de elementos de configuración actualiza el estado actual del incidente.';
    $Self->{Translation}->{'Config item history.'} = 'Historial de elementos de configuración.';
    $Self->{Translation}->{'Config item print.'} = 'Configurar elemento impresora.';
    $Self->{Translation}->{'Config item zoom.'} = 'Configurar el zoom del elemento.';
    $Self->{Translation}->{'ConfigItem Tree View'} = 'Vista en árbol de ConfigItem';
    $Self->{Translation}->{'ConfigItem Version'} = 'ConfigItem Versión';
    $Self->{Translation}->{'ConfigItems of the following classes will not be stored on the Elasticsearch server. To apply this to existing CIs, the CI migration has to be run via console, after changing this option.'} =
        'Los ConfigItems de las siguientes clases no se almacenarán en el servidor Elasticsearch. Para aplicar esto a los CIs existentes, la migración del CI tiene que ser ejecutada a través de la consola, después de cambiar esta opción.';
    $Self->{Translation}->{'ConfigItems with the following deployment states will not be stored on the Elasticsearch server. To apply this to existing CIs, the CI migration has to be run via console, after changing this option.'} =
        'Los ConfigItems con los siguientes estados de despliegue no se almacenarán en el servidor Elasticsearch. Para aplicar esto a los CIs existentes, la migración del CI tiene que ser ejecutada a través de la consola, después de cambiar esta opción.';
    $Self->{Translation}->{'Configuration Item Limit'} = 'Configuración Límite de elementos';
    $Self->{Translation}->{'Configuration Item limit per page.'} = 'Configuración Límite de elementos por página.';
    $Self->{Translation}->{'Configuration Management Database.'} = 'Base de datos de gestión de la configuración.';
    $Self->{Translation}->{'Configuration item bulk module.'} = 'Módulo de configuración de elementos individuales.';
    $Self->{Translation}->{'Configuration item search backend router of the agent interface.'} =
        'Elemento de configuración que busca el enrutamiento backend de la interfaz del agente.';
    $Self->{Translation}->{'Create and manage the definitions for Configuration Items.'} = 'Crear y gestionar las definiciones de los elementos de configuración.';
    $Self->{Translation}->{'Creates Tickets for ConfigItems at specific time points.'} = 'Con esta opción es posible rellenar automáticamente un campo CI, dependiendo del recuento de CI vinculados con el tipo existente DependsOn.';
    $Self->{Translation}->{'Customers can see historic CI versions.'} = 'Los clientes pueden ver las versiones históricas de CI.';
    $Self->{Translation}->{'Customers have the possibility to manually switch between historic CI versions.'} =
        'Los clientes tienen la posibilidad de cambiar manualmente entre versiones históricas de CI.';
    $Self->{Translation}->{'Default data to use on attribute for config item search screen. Example: "ITSMConfigItemCreateTimePointFormat=year;ITSMConfigItemCreateTimePointStart=Last;ITSMConfigItemCreateTimePoint=2;".'} =
        'Datos predeterminados que se utilizarán en el atributo para la pantalla de búsqueda de elementos de configuración. Ejemplo: "ITSMConfigItemCreateTimePointFormat=año;ITSMConfigItemCreateTimePointStart=Último;ITSMConfigItemCreateTimePoint=2;".';
    $Self->{Translation}->{'Default data to use on attribute for config item search screen. Example: "ITSMConfigItemCreateTimeStartYear=2010;ITSMConfigItemCreateTimeStartMonth=10;ITSMConfigItemCreateTimeStartDay=4;ITSMConfigItemCreateTimeStopYear=2010;ITSMConfigItemCreateTimeStopMonth=11;ITSMConfigItemCreateTimeStopDay=3;".'} =
        'Datos por defecto a utilizar en el atributo para la pantalla de búsqueda de elementos config. Ejemplo: "ITSMConfigItemCreateTimeStartYear=2010;ITSMConfigItemCreateTimeStartMonth=10;ITSMConfigItemCreateTimeStartDay=4;ITSMConfigItemCreateTimeStopYear=2010;ITSMConfigItemCreateTimeStopMonth=11;ITSMConfigItemCreateTimeStopDay=3;".';
    $Self->{Translation}->{'Define Actions where a settings button is available in the linked objects widget (LinkObject::ViewMode = "complex"). Please note that these Actions must have registered the following JS and CSS files: Core.AllocationList.css, Core.UI.AllocationList.js, Core.UI.Table.Sort.js, Core.Agent.TableFilters.js and Core.Agent.LinkObject.js.'} =
        'Definir acciones en las que un botón de configuración está disponible en el widget de objetos vinculados (LinkObject::ViewMode = "complex"). Tenga en cuenta que estas acciones deben haber registrado los siguientes archivos JS y CSS: Core.AllocationList.css, Core.UI.AllocationList.js, Core.UI.Table.Sort.js, Core.Agent.TableFilters.js y Core.Agent.LinkObject.js.';
    $Self->{Translation}->{'Define a Template::Toolkit scheme for version strings. Only used if Version String Module is set to TemplateToolkit.'} =
        'Define un esquema Template::Toolkit para cadenas de versión. Sólo se utiliza si Version String Module se establece en TemplateToolkit.';
    $Self->{Translation}->{'Define a set of conditions under which a customer is allowed to see a config item. Conditions can optionally be restricted to certain customer groups. Name is the only mandatory attribute. If no other options are given, all config items will be visible under that category.'} =
        'Define un conjunto de condiciones bajo las cuales un cliente puede ver un elemento de configuración. Las condiciones pueden restringirse opcionalmente a determinados grupos de clientes. El nombre es el único atributo obligatorio. Si no se indican otras opciones, todos los elementos de configuración serán visibles en esa categoría.';
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
    $Self->{Translation}->{'Defines if the link type labels must be shown in the node connections.'} =
        'Define si las etiquetas de tipo de enlace deben mostrarse en las conexiones de los nodos.';
    $Self->{Translation}->{'Defines regular expressions individually for each ConfigItem class to check the ConfigItem name and to show corresponding error messages.'} =
        'Define expresiones regulares individualmente para cada clase ConfigItem para comprobar el nombre de ConfigItem y mostrar los mensajes de error correspondientes.';
    $Self->{Translation}->{'Defines the available columns of CIs in the config item overview depending on the CI class. Each entry must consist of a class name and an array of available fields for the corresponding class. Dynamic field entries have to honor the scheme DynamicField_FieldName.'} =
        'Define las columnas disponibles de CIs en la vista general de elementos de configuración en función de la clase de CI. Cada entrada debe consistir en un nombre de clase y un array de campos disponibles para la clase correspondiente. Las entradas de campos dinámicos deben respetar el esquema DynamicField_FieldName.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of the agent interface.'} =
        'Define el atributo de elemento de configuración predeterminado para la clasificación de elementos de configuración del resultado de la búsqueda de elementos de configuración de la interfaz del agente.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of the customer interface.'} =
        'Define el atributo de elemento de configuración predeterminado para la clasificación de elementos de configuración del resultado de la búsqueda de elementos de configuración de la interfaz de cliente.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of this operation.'} =
        'Define el atributo de elemento de configuración predeterminado para la clasificación de elementos de configuración del resultado de la búsqueda de elementos de configuración de esta operación.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the agent interface. Up: oldest on top. Down: latest on top.'} =
        'Define el orden predeterminado de los elementos de configuración en el resultado de la búsqueda de elementos de configuración de la interfaz del agente. Arriba: el más antiguo arriba. Abajo: el más reciente arriba.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the customer interface. Up: oldest on top. Down: latest on top.'} =
        'Define el orden predeterminado de los elementos de configuración en el resultado de la búsqueda de elementos de configuración de la interfaz de cliente. Arriba: el más antiguo arriba. Abajo: el más reciente arriba.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the this operation. Up: oldest on top. Down: latest on top.'} =
        'Define el orden predeterminado de los elementos de configuración en el resultado de la búsqueda de elementos de configuración de esta operación. Arriba: el más antiguo arriba. Abajo: el más reciente arriba.';
    $Self->{Translation}->{'Defines the default displayed columns of CIs in the config item overview depending on the CI class. Each entry must consist of a class name and an array of available fields for the corresponding class. Dynamic field entries have to honor the scheme DynamicField_FieldName.'} =
        'Define las columnas mostradas por defecto de los CIs en la vista general de elementos de configuración dependiendo de la clase de CI. Cada entrada debe consistir en un nombre de clase y un array de campos disponibles para la clase correspondiente. Las entradas de campos dinámicos deben respetar el esquema DynamicField_FieldName.';
    $Self->{Translation}->{'Defines the default relations depth to be shown.'} = 'Define la profundidad de las relaciones que se mostrarán por defecto.';
    $Self->{Translation}->{'Defines the default shown config item search attribute for config item search screen.'} =
        'Define el atributo de búsqueda de elementos de configuración mostrado por defecto para la pantalla de búsqueda de elementos de configuración.';
    $Self->{Translation}->{'Defines the default shown config item search attribute for config item search screen. Example: "Key" must have the name of the Dynamic Field in this case \'X\', "Content" must have the value of the Dynamic Field depending on the Dynamic Field type,  Text: \'a text\', Dropdown: \'1\', Date/Time: \'Search_DynamicField_XTimeSlotStartYear=1974; Search_DynamicField_XTimeSlotStartMonth=01; Search_DynamicField_XTimeSlotStartDay=26; Search_DynamicField_XTimeSlotStartHour=00; Search_DynamicField_XTimeSlotStartMinute=00; Search_DynamicField_XTimeSlotStartSecond=00; Search_DynamicField_XTimeSlotStopYear=2013; Search_DynamicField_XTimeSlotStopMonth=01; Search_DynamicField_XTimeSlotStopDay=26; Search_DynamicField_XTimeSlotStopHour=23; Search_DynamicField_XTimeSlotStopMinute=59; Search_DynamicField_XTimeSlotStopSecond=59;\' and or \'Search_DynamicField_XTimePointFormat=week; Search_DynamicField_XTimePointStart=Before; Search_DynamicField_XTimePointValue=7\';.'} =
        'Define el atributo de búsqueda de elementos de configuración mostrado por defecto para la pantalla de búsqueda de elementos de configuración. Ejemplo: "Clave" debe tener el nombre del Campo Dinámico en este caso \'X\', "Contenido" debe tener el valor del Campo Dinámico dependiendo del tipo de Campo Dinámico, Texto: \'a text\', Desplegable: \'1\', Fecha/Hora: \'Search_DynamicField_XTimeSlotStartYear=1974; Search_DynamicField_XTimeSlotStartMonth=01; Search_DynamicField_XTimeSlotStartDay=26; Search_DynamicField_XTimeSlotStartHour=00; Search_DynamicField_XTimeSlotStartMinute=00; Search_DynamicField_XTimeSlotStartSecond=00; Search_DynamicField_XTimeSlotStopYear=2013; Search_DynamicField_XTimeSlotStopMonth=01; Search_DynamicField_XTimeSlotStopDay=26; Search_DynamicField_XTimeSlotStopHour=23; Search_DynamicField_XTimeSlotStopMinute=59; Search_DynamicField_XTimeSlotSecond=59;\' y o \'Search_DynamicField_XTimePointFormat=week; Search_DynamicField_XTimePointStart=Before; Search_DynamicField_XTimePointValue=7\';.';
    $Self->{Translation}->{'Defines the default subobject of the class \'ITSMConfigItem\'.'} =
        'Define el subobjeto por defecto de la clase \'ITSMConfigItem\'.';
    $Self->{Translation}->{'Defines the initial height for the rich text editor component in pixels.'} =
        '';
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
    $Self->{Translation}->{'Defines the search limit for the CustomerITSMConfigItem screen.'} =
        'Define el límite de búsqueda para la pantalla CustomerITSMConfigItem.';
    $Self->{Translation}->{'Defines the search limit for the CustomerITSMConfigItemSearch screen.'} =
        'Define el límite de búsqueda para la pantalla CustomerITSMConfigItemSearch.';
    $Self->{Translation}->{'Defines the shown columns of CIs in the link table complex view for all CI classes. If there is no entry, then the default columns are shown.'} =
        'Define las columnas mostradas de los CIs en la vista compleja de la tabla de enlaces para todas las clases de CI. Si no hay ninguna entrada, se muestran las columnas por defecto.';
    $Self->{Translation}->{'Defines the shown columns of CIs in the link table complex view, depending on the CI class. Each entry must be prefixed with the class name and double colons (i.e. Computer::). There are a few CI-Attributes that common to all CIs (example for the class Computer: Computer::Name, Computer::CurDeplState, Computer::CreateTime). To show individual CI-Attributes as defined in the CI-Definition, the following scheme must be used (example for the class Computer): Computer::HardDisk::1, Computer::HardDisk::1::Capacity::1, Computer::HardDisk::2, Computer::HardDisk::2::Capacity::1. If there is no entry for a CI class, then the default columns are shown.'} =
        'Define las columnas mostradas de los CIs en la vista compleja de la tabla de enlaces, dependiendo de la clase de CI. Cada entrada debe llevar como prefijo el nombre de la clase y dos puntos dobles (por ejemplo, Computer::). Hay algunos atributos CI que son comunes a todos los CIs (ejemplo para la clase Computador: Computer::Name, Computer::CurDeplState, Computer::CreateTime). Para mostrar los Atributos-Ci individuales como se definen en la Definición-Ci, se debe utilizar el siguiente esquema (ejemplo para la clase Computador): Ordenador::DiscoDuro::1, Computador::DiscoDuro::1::Capacidad::1, Computador::DiscoDuro::2, Computador::DiscoDuro::2::Capacidad::1. Si no hay ninguna entrada para una clase CI, se muestran las columnas por defecto.';
    $Self->{Translation}->{'Defines which items are available for \'Action\' in third level of the ITSM Config Item ACL structure.'} =
        'Define qué elementos están disponibles para "Acción" en el tercer nivel de la estructura ITSM Config Item ACL.';
    $Self->{Translation}->{'Defines which items are available in first level of the ITSM Config Item ACL structure.'} =
        'Define qué elementos están disponibles en el primer nivel de la estructura ITSM Config Item ACL.';
    $Self->{Translation}->{'Defines which items are available in second level of the ITSM Config Item ACL structure.'} =
        'Define qué elementos están disponibles en el segundo nivel de la estructura ITSM Config Item ACL.';
    $Self->{Translation}->{'Defines which type of link (named from the ticket perspective) can affect the status of a linked CI.'} =
        'Define qué tipo de enlace (nombrado desde la perspectiva del ticket) puede afectar al estado de un CI vinculado.';
    $Self->{Translation}->{'Defines which type of ticket can affect the status of a linked CI.'} =
        'Define qué tipo de ticket puede afectar al estado de un CI vinculado.';
    $Self->{Translation}->{'Definition Update'} = 'Actualización de la definición';
    $Self->{Translation}->{'Delete Configuration Item'} = 'Borrar elemento de configuración';
    $Self->{Translation}->{'DeplState'} = 'DeplState';
    $Self->{Translation}->{'Deployment State Color'} = 'Color del Estado de Despliegue';
    $Self->{Translation}->{'DeploymentState'} = 'Estado de despliegue';
    $Self->{Translation}->{'Duplicate'} = 'Duplicado';
    $Self->{Translation}->{'Dynamic field event module that marks config item definitions as out of sync, if containing dynamic fields change.'} =
        'Módulo de eventos de campos dinámicos que marca las definiciones de elementos de configuración como no sincronizadas si cambian los campos dinámicos que contienen.';
    $Self->{Translation}->{'Dynamic fields shown in the additional ITSM field screen of the agent interface.'} =
        'Campos dinámicos mostrados en la pantalla de campos adicionales ITSM de la interfaz del agente.';
    $Self->{Translation}->{'Dynamic fields shown in the config item overview screen of the customer interface.'} =
        'Campos dinámicos mostrados en la pantalla de resumen de elementos de configuración de la interfaz de cliente.';
    $Self->{Translation}->{'Dynamic fields shown in the config item search screen of the agent interface.'} =
        'Campos dinámicos mostrados en la pantalla de búsqueda de elementos de configuración de la interfaz del agente.';
    $Self->{Translation}->{'Enables configuration item bulk action feature for the agent frontend to work on more than one configuration item at a time.'} =
        'Activa la función de acción masiva de elementos de configuración para que el frontend del agente trabaje en más de un elemento de configuración a la vez.';
    $Self->{Translation}->{'Enables configuration item bulk action feature only for the listed groups.'} =
        'Activa la función de acción masiva de elementos de configuración sólo para los grupos de la lista.';
    $Self->{Translation}->{'Enables/disables the functionality to check ITSM onfiguration items for unique names. Before enabling this option you should check your system for already existing config items with duplicate names. You can do this with the console command Admin::ITSM::Configitem::ListDuplicates.'} =
        'Activa/desactiva la funcionalidad de comprobar los elementos de configuración ITSM para nombres únicos. Antes de habilitar esta opción debe comprobar si existen elementos de configuración con nombres duplicados. Puede hacerlo con el comando de consola Admin::ITSM::Configitem::ListDuplicates.';
    $Self->{Translation}->{'Event module to set configitem-status on ticket-configitem-link.'} =
        'Módulo de eventos para establecer el estado del elemento de configuración en el ticket-configitem-enlace.';
    $Self->{Translation}->{'Fields of the configuration item index, used for the fulltext search. Fields are also stored, but are not mandatory for the overall functionality. Inclusion of attachments can be disabled by setting the entry to 0 or deleting it.'} =
        'Campos del índice de elementos de configuración, utilizados para la búsqueda de texto completo. Los campos también se almacenan, pero no son obligatorios para la funcionalidad general. La inclusión de anexos puede desactivarse poniendo la entrada a 0 o borrándola.';
    $Self->{Translation}->{'Fields stored in the configuration item index which are used for other things besides fulltext searches. For the complete functionality all fields are mandatory.'} =
        'Campos almacenados en el índice de elementos de configuración que se utilizan para otras cosas además de las búsquedas de texto completo. Para la funcionalidad completa todos los campos son obligatorios.';
    $Self->{Translation}->{'For every webservice (key) an array of classes (value) can be defined on which the import is restricted. For all chosen classes, or all existing classes the identifying attributes will have to be chosen in the invoker config.'} =
        'Para cada webservice (clave) se puede definir un array de clases (valor) sobre las que se restringe la importación. Para todas las clases elegidas, o todas las clases existentes, los atributos de identificación tendrán que ser elegidos en la configuración del invocador.';
    $Self->{Translation}->{'GenericInterface module registration for the ConfigItemFetch invoker layer.'} =
        'Registro del módulo GenericInterface para la capa invocadora ConfigItemFetch.';
    $Self->{Translation}->{'ITSM ConfigItem'} = 'ITSM ConfigItem';
    $Self->{Translation}->{'ITSM config item overview.'} = 'Resumen de elementos de configuración de ITSM.';
    $Self->{Translation}->{'If this option is activated, linked items are only counted if they belong to one of the listed classes.'} =
        'Si esta opción está activada, los elementos vinculados sólo se contabilizan si pertenecen a una de las clases de la lista.';
    $Self->{Translation}->{'InciState'} = 'InciState';
    $Self->{Translation}->{'IncidentState'} = 'EstadoIncidente';
    $Self->{Translation}->{'Includes deployment states in the config item search of the customer interface.'} =
        'Incluye estados de despliegue en la búsqueda de elementos de configuración de la interfaz de cliente.';
    $Self->{Translation}->{'Includes incident states in the config item search of the customer interface.'} =
        'Incluye estados de incidencias en la búsqueda de elementos de configuración de la interfaz de cliente.';
    $Self->{Translation}->{'Maximum number of config items to be displayed in the result of this operation.'} =
        'Número máximo de elementos de configuración que se mostrarán en el resultado de esta operación.';
    $Self->{Translation}->{'Module to check the group responsible for a class.'} = 'Módulo para comprobar el grupo responsable de una clase.';
    $Self->{Translation}->{'Module to check the group responsible for a configuration item.'} =
        'Módulo para comprobar el grupo responsable de un elemento de configuración.';
    $Self->{Translation}->{'Module to generate ITSM config item statistics.'} = 'Módulo para generar estadísticas de elementos de configuración ITSM.';
    $Self->{Translation}->{'Name Module'} = 'Nombre Módulo';
    $Self->{Translation}->{'Number Module'} = 'Módulo numérico';
    $Self->{Translation}->{'Number of config items to be displayed in each page of a search result in the agent interface.'} =
        'Número de elementos de configuración que se mostrarán en cada página de un resultado de búsqueda en la interfaz del agente.';
    $Self->{Translation}->{'Number of config items to be displayed in each page of a search result in the customer interface.'} =
        'Número de elementos de configuración que deben mostrarse en cada página de un resultado de búsqueda en la interfaz del cliente.';
    $Self->{Translation}->{'Objects to search for, how many entries and which attributs to show. ConfigItem attributes have to explicitly be stored via Elasticsearch.'} =
        'Objetos a buscar, cuántas entradas y qué atributos mostrar. Los atributos ConfigItem deben almacenarse explícitamente a través de Elasticsearch.';
    $Self->{Translation}->{'Overview.'} = 'Vista General.';
    $Self->{Translation}->{'Parameters for the categories for config item classes in the preferences view of the agent interface.'} =
        'Parámetros para las categorías de las clases de elementos de configuración en la vista de preferencias de la interfaz del agente.';
    $Self->{Translation}->{'Parameters for the column filters of the small config item overview. Please note: setting \'Active\' to 0 will only prevent agents from editing settings of this group in their personal preferences, but will still allow administrators to edit the settings of another user\'s behalf. Use \'PreferenceGroup\' to control in which area these settings should be shown in the user interface.'} =
        'Parámetros para los filtros de columna de la vista general de elementos de configuración pequeños. Por favor, tenga en cuenta: establecer \'Activo\' a 0 sólo evitará que los agentes editen los ajustes de este grupo en sus preferencias personales, pero seguirá permitiendo a los administradores editar los ajustes en nombre de otro usuario. Utilice \'PreferenceGroup\' para controlar en qué área deben mostrarse estos ajustes en la interfaz de usuario.';
    $Self->{Translation}->{'Parameters for the dashboard backend of the customer company config item overview of the agent interface . "Limit" is the number of entries shown by default. "Group" is used to restrict the access to the plugin (e. g. Group: admin;group1;group2;). "Default" determines if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" is the cache time in minutes for the plugin.'} =
        'Parámetros para el backend del tablero de mandos de la vista general de elementos de configuración de la empresa cliente de la interfaz del agente . "Límite" es el número de entradas que se muestran por defecto. "Grupo" se utiliza para restringir el acceso al plugin (por ejemplo, Grupo: admin;group1;group2;). "Por defecto" determina si el plugin está habilitado por defecto o si el usuario tiene que habilitarlo manualmente. "CacheTTLLocal" es el tiempo de caché en minutos para el plugin.';
    $Self->{Translation}->{'Parameters for the deployment states color in the preferences view of the agent interface.'} =
        'Parámetros para el color de los estados de despliegue en la vista de preferencias de la interfaz del agente.';
    $Self->{Translation}->{'Parameters for the deployment states in the preferences view of the agent interface.'} =
        'Parámetros para los estados de despliegue en la vista de preferencias de la interfaz del agente.';
    $Self->{Translation}->{'Parameters for the example permission groups of the general catalog attributes.'} =
        'Parámetros para el ejemplo de permisos de grupo del catálogo general de atributos.';
    $Self->{Translation}->{'Parameters for the name module for config item classes in the preferences view of the agent interface.'} =
        'Parámetros para el módulo de nombres de las clases de elementos de configuración en la vista de preferencias de la interfaz del agente.';
    $Self->{Translation}->{'Parameters for the number module for config item classes in the preferences view of the agent interface.'} =
        'Parámetros del módulo numérico para las clases de elementos de configuración en la vista de preferencias de la interfaz del agente.';
    $Self->{Translation}->{'Parameters for the pages (in which the configuration items are shown).'} =
        'Parámetros para las páginas (en las que se muestran los elementos de configuración).';
    $Self->{Translation}->{'Parameters for the version string module for config item classes in the preferences view of the agent interface.'} =
        'Parámetros del módulo de cadenas de versión para las clases de elementos de configuración en la vista de preferencias de la interfaz del agente.';
    $Self->{Translation}->{'Parameters for the version string template toolkit module for config item classes in the preferences view of the agent interface.'} =
        'Parámetros para el módulo del kit de herramientas de plantillas de cadenas de versión para las clases de elementos de configuración en la vista de preferencias de la interfaz del agente.';
    $Self->{Translation}->{'Parameters for the version trigger for config item classes in the preferences view of the agent interface.'} =
        'Parámetros para el activador de versión para las clases de elementos de configuración en la vista de preferencias de la interfaz del agente.';
    $Self->{Translation}->{'Performs the configured action for each event (as an Invoker) for each configured Webservice.'} =
        'Realiza la acción configurada para cada evento (como Invoker) para cada Webservice configurado.';
    $Self->{Translation}->{'Permission Group'} = 'Permisos de grupo';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item attachment action in the agent interface.'} =
        'Permisos necesarios para utilizar la acción de adjuntar elementos de configuración ITSM en la interfaz del agente.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item screen in the agent interface.'} =
        'Permisos necesarios para utilizar la pantalla de elementos de configuración de ITSM en la interfaz del agente.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item search screen in the agent interface.'} =
        'Permisos necesarios para utilizar la pantalla de búsqueda de elementos de configuración de ITSM en la interfaz del agente.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item search screen in the customer interface.'} =
        'Permisos necesarios para utilizar la pantalla de búsqueda de elementos de configuración ITSM en la interfaz de cliente.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item tree view screen in the agent interface.'} =
        'Permisos necesarios para utilizar la pantalla de vista de árbol de elementos de configuración ITSM en la interfaz del agente.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item zoom screen in the agent interface.'} =
        'Permisos necesarios para utilizar la pantalla de ampliación de elementos de configuración de ITSM en la interfaz del agente.';
    $Self->{Translation}->{'Required permissions to use the add ITSM configuration item screen in the agent interface.'} =
        'Permisos necesarios para utilizar la pantalla de añadir elementos de configuración ITSM en la interfaz del agente.';
    $Self->{Translation}->{'Required permissions to use the bulk ITSM configuration item screen in the agent interface.'} =
        'Permisos necesarios para utilizar la pantalla de elementos de configuración ITSM masiva en la interfaz del agente.';
    $Self->{Translation}->{'Required permissions to use the edit ITSM configuration item screen in the agent interface.'} =
        'Permisos necesarios para utilizar la pantalla de edición de elementos de configuración de ITSM en la interfaz del agente.';
    $Self->{Translation}->{'Required permissions to use the history ITSM configuration item screen in the agent interface.'} =
        'Permisos necesarios para utilizar la pantalla de elementos de configuración del historial de ITSM en la interfaz del agente.';
    $Self->{Translation}->{'Required permissions to use the print ITSM configuration item screen in the agent interface.'} =
        'Permisos necesarios para utilizar la pantalla de impresión de elementos de configuración de ITSM en la interfaz del agente..';
    $Self->{Translation}->{'Required privileges to delete config items.'} = 'Privilegios necesarios para eliminar elementos de configuración.';
    $Self->{Translation}->{'Search config items.'} = 'Buscar elementos de configuración.';
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
    $Self->{Translation}->{'Shows a link in the menu to display the configuration item links as a Tree View.'} =
        'Muestra un enlace en el menú para visualizar los enlaces de los elementos de configuración como una vista en árbol.';
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
    $Self->{Translation}->{'The default category which is shown, if none is selected.'} = 'La categoría por defecto que se muestra, si no se selecciona ninguna.';
    $Self->{Translation}->{'The identifier for a configuration item, e.g. ConfigItem#, MyConfigItem#. The default is ConfigItem#.'} =
        'El identificador de un elemento de configuración, por ejemplo ConfigItem#, MyConfigItem#. El valor por defecto es ConfigItem#.';
    $Self->{Translation}->{'Triggers ConfigItemFetch invoker automatically.'} = 'Activa automáticamente el invocador ConfigItemFetch.';
    $Self->{Translation}->{'Version String Expression'} = 'Expresión de cadena de versión';
    $Self->{Translation}->{'Version String Module'} = 'Módulo de cadenas de versión';
    $Self->{Translation}->{'Version Trigger'} = 'Activador de versión';
    $Self->{Translation}->{'Whether the execution of ConfigItemACL can be avoided by checking cached field dependencies. This can improve loading times of formulars, but has to be disabled, if ACLModules are to be used for ITSMConfigItem- and Form-ReturnTypes.'} =
        'Si se puede evitar la ejecución de ConfigItemACL comprobando las dependencias de campos en caché. Esto puede mejorar los tiempos de carga de los formularios, pero debe desactivarse si se van a utilizar ACLModules para ITSMConfigItem- y Form-ReturnTypes.';
    $Self->{Translation}->{'Which general information is shown in the header.'} = 'Qué información general se muestra en la cabecera.';
    $Self->{Translation}->{'With this option it´s possible to fill automaticly a CI field, depending on the count of linked CI´s with the existing type DependsOn.'} =
        'Con esta opción es posible rellenar automáticamente un campo CI, dependiendo del recuento de CI vinculados con el tipo existente DependsOn.';
    $Self->{Translation}->{'With this option it´s possible to fill automaticly a CI field, depending on the count of linked CI´s.'} =
        'Con esta opción es posible rellenar automáticamente un campo CI, dependiendo del recuento de CI vinculados.';
    $Self->{Translation}->{'With this option it´s possible to fill automaticly a CI field, depending on the count of linked CI´s. The setting CounterClassName include the name of the class and CounterFieldName is used to store the count of used licence.'} =
        'Con esta opción es posible rellenar automáticamente un campo CI, dependiendo del recuento de CI vinculados. La configuración CounterClassName incluye el nombre de la clase y CounterFieldName se utiliza para almacenar el recuento de la licencia utilizada.';
    $Self->{Translation}->{'class'} = 'Clase';
    $Self->{Translation}->{'global'} = 'global';
    $Self->{Translation}->{'postproductive'} = 'postproductivo';
    $Self->{Translation}->{'preproductive'} = 'preproductivo';
    $Self->{Translation}->{'productive'} = 'productivo';


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

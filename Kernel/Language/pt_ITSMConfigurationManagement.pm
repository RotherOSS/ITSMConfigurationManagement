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

package Kernel::Language::pt_ITSMConfigurationManagement;

use strict;
use warnings;
use utf8;

sub Data {
    my $Self = shift;

    # Template: AdminITSMConfigItem
    $Self->{Translation}->{'Config Item Management'} = 'Gestão de Itens de Configuração';
    $Self->{Translation}->{'Change class definition'} = 'Mudar definição de classe';
    $Self->{Translation}->{'Change role definition'} = 'Modificar definição de função';
    $Self->{Translation}->{'Ready2Import Class Bundles'} = 'Pacotes de classes Ready2Import';
    $Self->{Translation}->{'Here you can import Ready2Import class bundles showcasing our most usual config items. Please note that some additional configuration may be required.'} =
        'Aqui pode importar os pacotes de classes Ready2Import que apresentam os nossos itens de configuração mais comuns. Tenha em atenção que poderá ser necessária alguma configuração adicional.';
    $Self->{Translation}->{'Update existing entities'} = 'Atualizar entidades existentes';
    $Self->{Translation}->{'Import Ready2Adopt class bundles'} = 'Importar os pacotes de classes Ready2Adopt';
    $Self->{Translation}->{'Config Item Class'} = 'Classe de item de configuração';
    $Self->{Translation}->{'Config Item Role'} = 'Item de configuração Função';

    # Template: AgentITSMConfigItemAdd
    $Self->{Translation}->{'Config Item'} = 'Item de Configuração';
    $Self->{Translation}->{'Filter for Classes'} = 'Filtro para Classes';
    $Self->{Translation}->{'Select a Class from the list to create a new Config Item.'} = 'Selecione uma classe a partir da lista para criar um novo item de configuração.';
    $Self->{Translation}->{'Class'} = 'Classe';

    # Template: AgentITSMConfigItemBulk
    $Self->{Translation}->{'ITSM ConfigItem Bulk Action'} = 'Ação em massa ITSM ConfigItem';
    $Self->{Translation}->{'Deployment state'} = 'Estado de Implementação';
    $Self->{Translation}->{'Incident state'} = 'Estado de incidente';
    $Self->{Translation}->{'Link to another'} = 'Ligação a outro';
    $Self->{Translation}->{'Invalid Configuration Item number!'} = 'Número de item de configuração inválido!';
    $Self->{Translation}->{'The number of another Configuration Item to link with.'} = 'O número de outro Item de Configuração a ligar.';

    # Template: AgentITSMConfigItemDelete
    $Self->{Translation}->{'Do you really want to delete this config item?'} = 'Pretende mesmo eliminar este item de configuração?';

    # Template: AgentITSMConfigItemEdit
    $Self->{Translation}->{'The name of this config item'} = 'O nome deste item de configuração';
    $Self->{Translation}->{'Name is already in use by the ConfigItems with the following Number(s): %s'} =
        'O nome já está a ser utilizado pelos ConfigItems com o(s) seguinte(s) número(s): %s';
    $Self->{Translation}->{'Version Number'} = 'Número da versão';
    $Self->{Translation}->{'Version number of this config item'} = 'Número da versão deste item de configuração';
    $Self->{Translation}->{'Version Number is already in use by the ConfigItems with the following Number(s): %s'} =
        'O número da versão já está a ser utilizado pelos ConfigItems com o(s) seguinte(s) número(s): %s';
    $Self->{Translation}->{'Deployment State'} = 'Estado de Implementação';
    $Self->{Translation}->{'Incident State'} = 'Estado de Incidente';

    # Template: AgentITSMConfigItemHistory
    $Self->{Translation}->{'History of Config Item: %s'} = 'Histórico do item de configuração: %s';
    $Self->{Translation}->{'History Content'} = 'Histórico do conteúdo';
    $Self->{Translation}->{'Createtime'} = 'Hora de criação';
    $Self->{Translation}->{'Zoom view'} = 'Vista de detalhe';

    # Template: AgentITSMConfigItemOverviewNavBar
    $Self->{Translation}->{'Config Items per page'} = 'Itens de configuração por página';

    # Template: AgentITSMConfigItemOverviewSmall
    $Self->{Translation}->{'No config item data found.'} = 'Não foram encontrados dados de itens de configuração.';
    $Self->{Translation}->{'Select this config item'} = 'Selecionar este item de configuração';

    # Template: AgentITSMConfigItemSearch
    $Self->{Translation}->{'Run Search'} = 'Executar Pesquisa';
    $Self->{Translation}->{'Also search in previous versions?'} = 'Procurar nas versões anteriores também?';

    # Template: AgentITSMConfigItemTreeView
    $Self->{Translation}->{'TreeView for ConfigItem'} = 'TreeView para ConfigItem';
    $Self->{Translation}->{'Depth Level'} = 'Nível de profundidade';
    $Self->{Translation}->{'Zoom In/Out'} = 'Aumentar e diminuir o zoom';
    $Self->{Translation}->{'Max links level reached for ConfigItem!'} = 'Nível máximo de ligações atingido para ConfigItem!';

    # Template: AgentITSMConfigItemZoom
    $Self->{Translation}->{'Configuration Item'} = 'Item de configuração';
    $Self->{Translation}->{'Configuration Item Information'} = 'Informação do Item de Configuração';
    $Self->{Translation}->{'Current Deployment State'} = 'Estado de Implementação Atual';
    $Self->{Translation}->{'Current Incident State'} = 'Estado do Incidente Atual';
    $Self->{Translation}->{'Last changed'} = 'Última modificação';
    $Self->{Translation}->{'Last changed by'} = 'Última modificação por';

    # Template: CustomerITSMConfigItem
    $Self->{Translation}->{'Your ConfigItems'} = 'Os seus ConfigItems';

    # Template: CustomerITSMConfigItemSearch
    $Self->{Translation}->{'ConfigItem Search'} = 'Pesquisa ConfigItem';

    # Template: AdminACL
    $Self->{Translation}->{'Object Type'} = 'Tipo de objeto';

    # JS Template: ClassImportConfirm
    $Self->{Translation}->{'The following classes will be imported'} = 'Serão importadas as seguintes classes';
    $Self->{Translation}->{'The following roles will be imported'} = 'Serão importadas as seguintes funções';
    $Self->{Translation}->{'Note that also corresponding dynamic fields and GeneralCatalog classes will be created and there is no automatic removal.'} =
        'Note-se que também serão criados os campos dinâmicos e as classes GeneralCatalog correspondentes e não há remoção automática.';
    $Self->{Translation}->{'Do you want to proceed?'} = 'Queres continuar?';

    # Perl Module: Kernel/Modules/AdminITSMConfigItem.pm
    $Self->{Translation}->{'Need ExampleClasses!'} = 'Necessita de ExampleClasses!';
    $Self->{Translation}->{'Definition is no valid YAML hash.'} = 'A definição não é um hash YAML válido.';

    # Perl Module: Kernel/Modules/AgentITSMConfigItem.pm
    $Self->{Translation}->{'Overview: ITSM ConfigItem'} = 'Visão geral: ITSM ConfigItem';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemBulk.pm
    $Self->{Translation}->{'No ConfigItemID is given!'} = 'Não é fornecido nenhum ConfigItemID!';
    $Self->{Translation}->{'You need at least one selected Configuration Item!'} = 'É necessário pelo menos um Item de Configuração selecionado!';
    $Self->{Translation}->{'You don\'t have write access to this configuration item: %s.'} =
        'Não tem acesso de escrita a este item de configuração: %s.';
    $Self->{Translation}->{'No definition was defined for class %s!'} = 'Não foi definida nenhuma definição para a classe %s!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemDelete.pm
    $Self->{Translation}->{'Config item "%s" not found in database!'} = 'Item de configuração "%s" não encontrado na base de dados!';
    $Self->{Translation}->{'Was not able to delete the configitem ID %s!'} = 'Não foi possível eliminar o item de configuração ID %s!';
    $Self->{Translation}->{'No version found for ConfigItemID %s!'} = 'Não foi encontrada nenhuma versão para ConfigItemID %s!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemEdit.pm
    $Self->{Translation}->{'No ConfigItemID, DuplicateID or ClassID is given!'} = 'Não é fornecido nenhum ConfigItemID, DuplicateID ou ClassID!';
    $Self->{Translation}->{'No access is given!'} = 'Não é dado acesso!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemHistory.pm
    $Self->{Translation}->{'Can\'t show history, no ConfigItemID is given!'} = 'Não é possível mostrar o histórico, não é fornecido nenhum ConfigItemID!';
    $Self->{Translation}->{'Can\'t show history, no access rights given!'} = 'Não é possível mostrar o histórico, não foram dados direitos de acesso!';
    $Self->{Translation}->{'New ConfigItem (ID=%s)'} = 'Novo ConfigItem (ID=%s)';
    $Self->{Translation}->{'New version (ID=%s)'} = 'Nova versão (ID=%s)';
    $Self->{Translation}->{'Deployment state updated (new=%s, old=%s)'} = 'Estado da implantação atualizado (novo=%s, antigo=%s)';
    $Self->{Translation}->{'Incident state updated (new=%s, old=%s)'} = 'Estado do incidente atualizado (novo=%s, antigo=%s)';
    $Self->{Translation}->{'ConfigItem (ID=%s) deleted'} = 'ConfigItem (ID=%s) eliminado';
    $Self->{Translation}->{'Link to %s (type=%s) added'} = 'Ligação a %s (tipo=%s) adicionada';
    $Self->{Translation}->{'Link to %s (type=%s) deleted'} = 'Ligação a %s (tipo=%s) eliminada';
    $Self->{Translation}->{'ConfigItem definition updated (ID=%s)'} = 'Definição de ConfigItem actualizada (ID=%s)';
    $Self->{Translation}->{'Name updated (new=%s, old=%s)'} = 'Nome atualizado (novo=%s, antigo=%s)';
    $Self->{Translation}->{'Attribute %s updated from "%s" to "%s"'} = 'Atributo %s atualizado de "%s" para "%s"';
    $Self->{Translation}->{'Version %s deleted'} = 'Versão %s eliminada';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemPrint.pm
    $Self->{Translation}->{'No ConfigItemID or VersionID is given!'} = 'Não é indicado nenhum ConfigItemID ou VersionID!';
    $Self->{Translation}->{'Can\'t show config item, no access rights given!'} = 'Não é possível mostrar o item de configuração, não foram dados direitos de acesso!';
    $Self->{Translation}->{'ConfigItemID %s not found in database!'} = 'ConfigItemID %s não foi encontrado na base de dados!';
    $Self->{Translation}->{'ConfigItem'} = 'Item de configuração';
    $Self->{Translation}->{'printed by %s at %s'} = 'impresso por %s em %s';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemSearch.pm
    $Self->{Translation}->{'Invalid ClassID!'} = 'ClassID inválido!';
    $Self->{Translation}->{'No ClassID is given!'} = 'Não é indicado nenhum ClassID!';
    $Self->{Translation}->{'No access rights for this class given!'} = 'Não são concedidos direitos de acesso a esta classe!';
    $Self->{Translation}->{'No Result!'} = 'Sem resultado!';
    $Self->{Translation}->{'Config Item Search Results'} = 'Resultados da pesquisa de itens de configuração';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemZoom.pm
    $Self->{Translation}->{'Can\'t show item, no access rights for ConfigItem are given!'} =
        'Não é possível mostrar o item, não foram dados direitos de acesso para ConfigItem!';
    $Self->{Translation}->{'ConfigItem not found!'} = 'ConfigItem não encontrado!';
    $Self->{Translation}->{'No versions found!'} = 'Não foram encontradas versões!';
    $Self->{Translation}->{'operational'} = 'operacional';
    $Self->{Translation}->{'warning'} = 'aviso';
    $Self->{Translation}->{'incident'} = 'incidente';
    $Self->{Translation}->{'The deployment state of this config item'} = 'O estado de implementação do item de configuração';
    $Self->{Translation}->{'The incident state of this config item'} = 'O estado de incidente deste item de configuração';

    # Perl Module: Kernel/Modules/CustomerITSMConfigItemSearch.pm
    $Self->{Translation}->{'No permission'} = 'Sem permissão';
    $Self->{Translation}->{'Filter invalid!'} = 'Filtro inválido!';
    $Self->{Translation}->{'Search params invalid!'} = 'Parâmetros de pesquisa inválidos!';

    # Perl Module: Kernel/Output/HTML/Dashboard/ITSMConfigItemGeneric.pm
    $Self->{Translation}->{'Shown config items'} = 'Itens de configuração apresentados';
    $Self->{Translation}->{'Deployment State Type'} = 'Tipo de Estado de Implementação';
    $Self->{Translation}->{'Current Incident State Type'} = 'Estado Atual de Incidente por tipo';

    # Perl Module: Kernel/Output/HTML/ITSMConfigItem/LayoutDate.pm
    $Self->{Translation}->{'Between'} = 'Entre';

    # Perl Module: Kernel/System/DynamicField/Driver/ConfigItem.pm
    $Self->{Translation}->{'Class restrictions for the config item'} = 'Restrições de classe para o item de configuração';
    $Self->{Translation}->{'Select one or more classes to restrict selectable config items'} =
        'Seleccione uma ou mais classes para restringir os itens de configuração seleccionáveis';
    $Self->{Translation}->{'Link type'} = 'Tipo de ligação';
    $Self->{Translation}->{'Select the link type.'} = 'Selecionar o tipo de ligação.';
    $Self->{Translation}->{'Forwards: Referencing (Source) -> Referenced (Target)'} = 'Para a frente: Referenciação (Fonte) -> Referenciado (Destino)';
    $Self->{Translation}->{'Backwards: Referenced (Source) -> Referencing (Target)'} = 'Para trás: Referenciado (Fonte) -> Referenciação (Destino)';
    $Self->{Translation}->{'Link Direction'} = 'Direção da ligação';
    $Self->{Translation}->{'The referencing object is the one containing this dynamic field, the referenced object is the one selected as value of the dynamic field.'} =
        'O objeto de referência é o que contém este campo dinâmico, o objeto referenciado é o que foi selecionado como valor do campo dinâmico.';
    $Self->{Translation}->{'Dynamic (ConfigItem)'} = 'Dinâmico (ConfigItem)';
    $Self->{Translation}->{'Static (Version)'} = 'Estático (Versão)';
    $Self->{Translation}->{'Link Referencing Type'} = 'Tipo de referência de ligação';
    $Self->{Translation}->{'Whether this link applies to the ConfigItem or the static version of the referencing object. Current Incident State calculation only is performed on dynamic links.'} =
        'Se esta ligação se aplica ao ConfigItem ou à versão estática do objeto de referência. O cálculo do estado atual do incidente só é efectuado em ligações dinâmicas.';
    $Self->{Translation}->{'Select the attribute which config items will be searched by'} = 'Seleccione o atributo pelo qual os itens de configuração serão pesquisados';

    # Perl Module: Kernel/System/ITSMConfigItem/Definition.pm
    $Self->{Translation}->{'Starting the YAML string with \'---\' is required.'} = 'É necessário iniciar a cadeia YAML com \'---\'.';

    # Perl Module: Kernel/System/ITSMConfigItem/Link.pm
    $Self->{Translation}->{'Could not purge the table configitem_link.'} = 'Não foi possível purgar a tabela configitem_link.';
    $Self->{Translation}->{'No relevant dynamic fields were found'} = 'Não foram encontrados campos dinâmicos relevantes';
    $Self->{Translation}->{'Could not insert into the table configitem_link'} = 'Não foi possível inserir na tabela configitem_link';
    $Self->{Translation}->{'Inserted 0 rows into the table configitem_link'} = 'Inseriu 0 linhas na tabela configitem_link';

    # Perl Module: Kernel/System/ImportExport/ObjectBackend/ITSMConfigItem.pm
    $Self->{Translation}->{'Maximum number of one element'} = 'Número máximo de um elemento';
    $Self->{Translation}->{'Empty fields indicate that the current values are kept'} = 'Os campos vazios indicam que os valores atuais são mantidos';
    $Self->{Translation}->{'Skipped'} = 'Desconsiderados';

    # Perl Module: Kernel/Modules/AdminDynamicField.pm
    $Self->{Translation}->{'Error synchronizing the definitions. Please check the log.'} = 'Erro ao sincronizar as definições. Verificar o registo.';
    $Self->{Translation}->{'You have ITSMConfigItem definitions which are not synchronized. Please deploy your ITSMConfigItem dynamic field changes.'} =
        'Tem definições ITSMConfigItem que não estão sincronizadas. Por favor, implemente as alterações do campo dinâmico ITSMConfigItem.';

    # Database XML / SOPM Definition: ITSMConfigurationManagement.sopm
    $Self->{Translation}->{'Expired'} = 'Expirado';
    $Self->{Translation}->{'Maintenance'} = 'Manutenção';
    $Self->{Translation}->{'Pilot'} = 'Piloto';
    $Self->{Translation}->{'Planned'} = 'Planeado';
    $Self->{Translation}->{'Repair'} = 'Reparação';
    $Self->{Translation}->{'Retired'} = 'Retirado';
    $Self->{Translation}->{'Review'} = 'Revisão';
    $Self->{Translation}->{'Test/QA'} = 'Teste de Qualidade';

    # JS File: ITSM.Admin.ITSMConfigItem
    $Self->{Translation}->{'Overview and Confirmation'} = 'Visão geral e confirmação';
    $Self->{Translation}->{'Importing classes/roles and their related fields'} = 'Importação de classes/funções e respectivos campos relacionados';
    $Self->{Translation}->{'An error occurred during class import.'} = 'Ocorreu um erro durante a importação da classe.';

    # SysConfig
    $Self->{Translation}->{'0 - Hidden'} = '0 - Oculto';
    $Self->{Translation}->{'1 - Shown'} = '1 - Mostrado';
    $Self->{Translation}->{'Allows extended search conditions in config item search of the agent interface. With this feature you can search e. g. config item name with this kind of conditions like "(*key1*&&*key2*)" or "(*key1*||*key2*)".'} =
        'Permite condições de pesquisa alargadas na pesquisa de itens de configuração da interface do agente. Com esta funcionalidade, é possível pesquisar, por exemplo, o nome do item de configuração com este tipo de condições, como "(*key1*&&*key2*)" ou "(*key1*||*key2*)".';
    $Self->{Translation}->{'Allows extended search conditions in config item search of the customer interface. With this feature you can search e. g. config item name with this kind of conditions like "(*key1*&&*key2*)" or "(*key1*||*key2*)".'} =
        'Permite condições de pesquisa alargadas na pesquisa de itens de configuração da interface do cliente. Com esta funcionalidade, pode pesquisar, por exemplo, o nome do item de configuração com este tipo de condições, como "(*key1*&&*key2*)" ou "(*key1*||*key2*)".';
    $Self->{Translation}->{'Assigned CIs'} = 'ICs atribuídos';
    $Self->{Translation}->{'CIs assigned to customer company'} = 'ICs atribuídas à empresa cliente';
    $Self->{Translation}->{'CIs assigned to customer user'} = 'ICs atribuídas ao utilizador do cliente';
    $Self->{Translation}->{'CMDB Settings'} = 'Definições da CMDB';
    $Self->{Translation}->{'Check for a unique name only within the same ConfigItem class (\'class\') or globally (\'global\'), which means every existing ConfigItem is taken into account when looking for duplicates.'} =
        'Verifica um nome único apenas dentro da mesma classe de ConfigItem (\'class\') ou globalmente (\'global\'), o que significa que todos os ConfigItem existentes são tidos em conta ao procurar duplicados.';
    $Self->{Translation}->{'Choose a module to enforce a naming scheme.'} = 'Escolha um módulo para aplicar um esquema de nomes.';
    $Self->{Translation}->{'Choose a module to enforce a number scheme.'} = 'Selecionar um módulo para aplicar um esquema numérico.';
    $Self->{Translation}->{'Choose a module to enforce a version string scheme.'} = 'Escolha um módulo para aplicar um esquema de cadeia de versões.';
    $Self->{Translation}->{'Choose attributes to trigger the creation of a new version.'} = 'Selecionar atributos para acionar a criação de uma nova versão.';
    $Self->{Translation}->{'Choose categories to assign to this config item class.'} = 'Escolha categorias para atribuir a esta classe de item de configuração.';
    $Self->{Translation}->{'Column config item filters for ConfigItem Overview.'} = 'Filtros de itens de configuração de coluna para Visão geral do ConfigItem.';
    $Self->{Translation}->{'Columns that can be filtered in the config item overview of the agent interface. Note: Only Config Item attributes and Dynamic Fields (DynamicField_NameX) are allowed.'} =
        'Colunas que podem ser filtradas na síntese de itens de configuração da interface do agente. Nota: Apenas são permitidos atributos de Itens de Configuração e Campos Dinâmicos (DynamicField_NameX).';
    $Self->{Translation}->{'Columns that can be filtered in the config item overview of the customer interface. Note: Only Config Item attributes and Dynamic Fields (DynamicField_NameX) are allowed.'} =
        'Colunas que podem ser filtradas na síntese do item de configuração da interface do cliente. Nota: Apenas são permitidos atributos de itens de configuração e campos dinâmicos (DynamicField_NameX).';
    $Self->{Translation}->{'Columns that can be filtered in the config item search result overview of the agent interface. Note: Only Config Item attributes and Dynamic Fields (DynamicField_NameX) are allowed.'} =
        'Colunas que podem ser filtradas na síntese do resultado da pesquisa de itens de configuração da interface do agente. Nota: Apenas são permitidos atributos de Item de Configuração e Campos Dinâmicos (DynamicField_NameX).';
    $Self->{Translation}->{'Config Items'} = 'Itens de Configuração';
    $Self->{Translation}->{'Config item add.'} = 'Adicionar item de configuração.';
    $Self->{Translation}->{'Config item edit.'} = 'Editar item de configuração.';
    $Self->{Translation}->{'Config item event module that enables logging to history in the agent interface.'} =
        'Módulo de evento de item de configuração que permite registar o histórico da interface do agente.';
    $Self->{Translation}->{'Config item event module that updates config items to their current definition.'} =
        'Módulo de evento de item de configuração que actualiza os itens de configuração para a sua definição atual.';
    $Self->{Translation}->{'Config item event module that updates the table configitem_ĺink.'} =
        'Módulo de evento de item de configuração que actualiza a tabela configitem_ĺink.';
    $Self->{Translation}->{'Config item event module updates the current incident state.'} =
        'O módulo de eventos do item de configuração actualiza o estado atual do incidente.';
    $Self->{Translation}->{'Config item history.'} = 'Histórico de itens de configuração.';
    $Self->{Translation}->{'Config item print.'} = 'Imprimir item de configuração.';
    $Self->{Translation}->{'Config item zoom.'} = 'Configurar o zoom do item.';
    $Self->{Translation}->{'ConfigItem Tree View'} = 'Vista em árvore do ConfigItem';
    $Self->{Translation}->{'ConfigItem Version'} = 'ConfigItem Versão';
    $Self->{Translation}->{'ConfigItems of the following classes will not be stored on the Elasticsearch server. To apply this to existing CIs, the CI migration has to be run via console, after changing this option.'} =
        'Os ConfigItems das seguintes classes não serão armazenados no servidor Elasticsearch. Para aplicar isto aos ICs existentes, a migração do IC tem de ser executada através da consola, depois de alterar esta opção.';
    $Self->{Translation}->{'ConfigItems with the following deployment states will not be stored on the Elasticsearch server. To apply this to existing CIs, the CI migration has to be run via console, after changing this option.'} =
        'Os ConfigItems com os seguintes estados de implantação não serão armazenados no servidor Elasticsearch. Para aplicar isto aos ICs existentes, a migração do IC tem de ser executada através da consola, depois de alterar esta opção.';
    $Self->{Translation}->{'Configuration Item Limit'} = 'Limite de Items de Configuração';
    $Self->{Translation}->{'Configuration Item limit per page.'} = 'Configuração Limite de itens por página.';
    $Self->{Translation}->{'Configuration Management Database.'} = 'Base de dados de gestão da configuração.';
    $Self->{Translation}->{'Configuration item bulk module.'} = 'Módulo em bloco do item de configuração.';
    $Self->{Translation}->{'Configuration item search backend router of the agent interface.'} =
        'Router de pesquisa de item de configuração da interface do agente.';
    $Self->{Translation}->{'Create and manage the definitions for Configuration Items.'} = 'Criar e gerir as definições de Itens de Configuração.';
    $Self->{Translation}->{'Customers can see historic CI versions.'} = 'Os clientes podem ver versões históricas de CI.';
    $Self->{Translation}->{'Customers have the possibility to manually switch between historic CI versions.'} =
        'Os clientes têm a possibilidade de alternar manualmente entre versões históricas de IC.';
    $Self->{Translation}->{'Default data to use on attribute for config item search screen. Example: "ITSMConfigItemCreateTimePointFormat=year;ITSMConfigItemCreateTimePointStart=Last;ITSMConfigItemCreateTimePoint=2;".'} =
        'Dados predefinidos a utilizar no atributo para o ecrã de pesquisa de itens de configuração. Exemplo: "ITSMConfigItemCreateTimePointFormat=year;ITSMConfigItemCreateTimePointStart=Last;ITSMConfigItemCreateTimePoint=2;".';
    $Self->{Translation}->{'Default data to use on attribute for config item search screen. Example: "ITSMConfigItemCreateTimeStartYear=2010;ITSMConfigItemCreateTimeStartMonth=10;ITSMConfigItemCreateTimeStartDay=4;ITSMConfigItemCreateTimeStopYear=2010;ITSMConfigItemCreateTimeStopMonth=11;ITSMConfigItemCreateTimeStopDay=3;".'} =
        'Dados predefinidos a utilizar no atributo para o ecrã de pesquisa de itens de configuração. Exemplo: "ITSMConfigItemCreateTimeStartYear=2010;ITSMConfigItemCreateTimeStartMonth=10;ITSMConfigItemCreateTimeStartDay=4;ITSMConfigItemCreateTimeStopYear=2010;ITSMConfigItemCreateTimeStopMonth=11;ITSMConfigItemCreateTimeStopDay=3;".';
    $Self->{Translation}->{'Define Actions where a settings button is available in the linked objects widget (LinkObject::ViewMode = "complex"). Please note that these Actions must have registered the following JS and CSS files: Core.AllocationList.css, Core.UI.AllocationList.js, Core.UI.Table.Sort.js, Core.Agent.TableFilters.js and Core.Agent.LinkObject.js.'} =
        'Definir Acções onde um botão de configurações está disponível na widget the objectos ligados (LinkObject::ViewMode = "complex").  Estas Acções devem estar registadas nos seguintes ficheiros JS e CSS: Core.AllocationList.css, Core.UI.AllocationList.js, Core.UI.Table.Sort.js, Core.Agent.TableFilters.js and Core.Agent.LinkObject.js.';
    $Self->{Translation}->{'Define a Template::Toolkit scheme for version strings. Only used if Version String Module is set to TemplateToolkit.'} =
        'Define um esquema Template::Toolkit para strings de versão. Apenas utilizado se o módulo Version String estiver definido como TemplateToolkit.';
    $Self->{Translation}->{'Define a set of conditions under which a customer is allowed to see a config item. Conditions can optionally be restricted to certain customer groups. Name is the only mandatory attribute. If no other options are given, all config items will be visible under that category.'} =
        'Define um conjunto de condições sob as quais um cliente é autorizado a ver um item de configuração. As condições podem, opcionalmente, ser restringidas a determinados grupos de clientes. O nome é o único atributo obrigatório. Se não forem dadas outras opções, todos os itens de configuração serão visíveis nessa categoria.';
    $Self->{Translation}->{'Defines Required permissions to create ITSM configuration items using the Generic Interface.'} =
        'Define as permissões necessárias para criar itens de configuração ITSM utilizando a Interface Genérica.';
    $Self->{Translation}->{'Defines Required permissions to delete ITSM configuration items using the Generic Interface.'} =
        'Define as permissões necessárias para eliminar itens de configuração ITSM utilizando a interface genérica.';
    $Self->{Translation}->{'Defines Required permissions to get ITSM configuration items using the Generic Interface.'} =
        'Define as permissões necessárias para obter itens de configuração ITSM utilizando a interface genérica.';
    $Self->{Translation}->{'Defines Required permissions to search ITSM configuration items using the Generic Interface.'} =
        'Define as permissões necessárias para pesquisar itens de configuração ITSM utilizando a Interface Genérica.';
    $Self->{Translation}->{'Defines Required permissions to update ITSM configuration items using the Generic Interface.'} =
        'Define as permissões necessárias para atualizar os itens de configuração ITSM utilizando a Interface Genérica.';
    $Self->{Translation}->{'Defines an overview module to show the small view of a configuration item list.'} =
        'Define um módulo de vista geral para mostrar a vista pequena da lista de itens de configuração.';
    $Self->{Translation}->{'Defines if the link type labels must be shown in the node connections.'} =
        'Define se as etiquetas do tipo de ligação devem ser apresentadas nas ligações dos nós.';
    $Self->{Translation}->{'Defines regular expressions individually for each ConfigItem class to check the ConfigItem name and to show corresponding error messages.'} =
        'Define expressões regulares individualmente para cada classe ConfigItem para verificar o nome do ConfigItem e mostrar as mensagens de erro correspondentes.';
    $Self->{Translation}->{'Defines the available columns of CIs in the config item overview depending on the CI class. Each entry must consist of a class name and an array of available fields for the corresponding class. Dynamic field entries have to honor the scheme DynamicField_FieldName.'} =
        'Define as colunas disponíveis de ICs na visão geral do item de configuração, dependendo da classe do IC. Cada entrada deve ser composta por um nome de classe e uma matriz de campos disponíveis para a classe correspondente. As entradas de campos dinâmicos têm de respeitar o esquema DynamicField_FieldName.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of the agent interface.'} =
        'Define o atributo de item de configuração predefinido para a ordenação de itens de configuração do resultado da pesquisa de itens de configuração da interface de agente.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of the customer interface.'} =
        'Define o atributo de item de configuração predefinido para a ordenação de itens de configuração do resultado da pesquisa de itens de configuração da interface de cliente.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of this operation.'} =
        'Define o atributo de item de configuração predefinido para a ordenação de itens de configuração do resultado da pesquisa de itens de configuração desta operação.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the agent interface. Up: oldest on top. Down: latest on top.'} =
        'Define a ordem predefinida dos itens de configuração no resultado da pesquisa de itens de configuração da interface do agente. Acima: o mais antigo no topo. Para baixo: o mais recente no topo.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the customer interface. Up: oldest on top. Down: latest on top.'} =
        'Define a ordem predefinida dos itens de configuração no resultado da pesquisa de itens de configuração da interface do cliente. Acima: o mais antigo no topo. Para baixo: o mais recente no topo.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the this operation. Up: oldest on top. Down: latest on top.'} =
        'Define a ordem predefinida dos itens de configuração no resultado da pesquisa de itens de configuração desta operação. Para cima: o mais antigo no topo. Para baixo: o mais recente no topo.';
    $Self->{Translation}->{'Defines the default displayed columns of CIs in the config item overview depending on the CI class. Each entry must consist of a class name and an array of available fields for the corresponding class. Dynamic field entries have to honor the scheme DynamicField_FieldName.'} =
        'Define as colunas de ICs exibidas por padrão na visão geral do item de configuração, dependendo da classe do IC. Cada entrada deve ser composta por um nome de classe e uma matriz de campos disponíveis para a classe correspondente. As entradas de campos dinâmicos têm de respeitar o esquema DynamicField_FieldName.';
    $Self->{Translation}->{'Defines the default relations depth to be shown.'} = 'Define a profundidade das relações predefinidas a serem mostradas.';
    $Self->{Translation}->{'Defines the default shown config item search attribute for config item search screen.'} =
        'Define o atributo de pesquisa de item de configuração mostrado por defeito para o ecrã de pesquisa de item de configuração.';
    $Self->{Translation}->{'Defines the default shown config item search attribute for config item search screen. Example: "Key" must have the name of the Dynamic Field in this case \'X\', "Content" must have the value of the Dynamic Field depending on the Dynamic Field type,  Text: \'a text\', Dropdown: \'1\', Date/Time: \'Search_DynamicField_XTimeSlotStartYear=1974; Search_DynamicField_XTimeSlotStartMonth=01; Search_DynamicField_XTimeSlotStartDay=26; Search_DynamicField_XTimeSlotStartHour=00; Search_DynamicField_XTimeSlotStartMinute=00; Search_DynamicField_XTimeSlotStartSecond=00; Search_DynamicField_XTimeSlotStopYear=2013; Search_DynamicField_XTimeSlotStopMonth=01; Search_DynamicField_XTimeSlotStopDay=26; Search_DynamicField_XTimeSlotStopHour=23; Search_DynamicField_XTimeSlotStopMinute=59; Search_DynamicField_XTimeSlotStopSecond=59;\' and or \'Search_DynamicField_XTimePointFormat=week; Search_DynamicField_XTimePointStart=Before; Search_DynamicField_XTimePointValue=7\';.'} =
        'Define o atributo de pesquisa de item de configuração mostrado por defeito para o ecrã de pesquisa de item de configuração. Exemplo: "Key" (Chave) deve ter o nome do campo dinâmico, neste caso "X", "Content" (Conteúdo) deve ter o valor do campo dinâmico, dependendo do tipo de campo dinâmico, Text (Texto): "um texto", Dropdown (Menu suspenso): "1", Date/Time (Data/Hora): \'Search_DynamicField_XTimeSlotStartYear=1974; Search_DynamicField_XTimeSlotStartMonth=01; Search_DynamicField_XTimeSlotStartDay=26; Search_DynamicField_XTimeSlotStartHour=00; Search_DynamicField_XTimeSlotStartMinute=00; Search_DynamicField_XTimeSlotStartSecond=00; Search_DynamicField_XTimeSlotStopYear=2013; Search_DynamicField_XTimeSlotStopMonth=01; Search_DynamicField_XTimeSlotStopDay=26; Search_DynamicField_XTimeSlotStopHour=23; Search_DynamicField_XTimeSlotStopMinute=59; Search_DynamicField_XTimeSlotStopSecond=59;\' e ou \'Search_DynamicField_XTimePointFormat=week; Search_DynamicField_XTimePointStart=Before; Search_DynamicField_XTimePointValue=7\';.';
    $Self->{Translation}->{'Defines the default subobject of the class \'ITSMConfigItem\'.'} =
        'Define o subobjeto por omissão da classe \'ITSMConfigItem\'.';
    $Self->{Translation}->{'Defines the number of rows for the CI definition editor in the admin interface.'} =
        'Define o número de linhas para o editor de definição de IC na interface de administração.';
    $Self->{Translation}->{'Defines the order of incident states from high (e.g. cricital) to low (e.g. functional).'} =
        'Define a ordem dos estados incidentes de alto (por exemplo, cricital) para baixo (por exemplo, funcional).';
    $Self->{Translation}->{'Defines the relevant deployment states where linked tickets can affect the status of a CI.'} =
        'Define os estados de implantação relevantes onde os tickets vinculados podem afetar o status de um IC.';
    $Self->{Translation}->{'Defines the search limit for the AgentITSMConfigItem screen.'} =
        'Define o limite de pesquisa para o ecrã AgentITSMConfigItem.';
    $Self->{Translation}->{'Defines the search limit for the AgentITSMConfigItemSearch screen.'} =
        'Define o limite de pesquisa para o ecrã AgentITSMConfigItemSearch.';
    $Self->{Translation}->{'Defines the search limit for the CustomerITSMConfigItem screen.'} =
        'Define o limite de pesquisa para o ecrã CustomerITSMConfigItem.';
    $Self->{Translation}->{'Defines the search limit for the CustomerITSMConfigItemSearch screen.'} =
        'Define o limite de pesquisa para o ecrã CustomerITSMConfigItemSearch.';
    $Self->{Translation}->{'Defines the shown columns of CIs in the link table complex view for all CI classes. If there is no entry, then the default columns are shown.'} =
        'Define as colunas de ICs apresentadas na vista complexa da tabela de ligações para todas as classes de ICs. Se não houver nenhuma entrada, então as colunas padrão são mostradas.';
    $Self->{Translation}->{'Defines the shown columns of CIs in the link table complex view, depending on the CI class. Each entry must be prefixed with the class name and double colons (i.e. Computer::). There are a few CI-Attributes that common to all CIs (example for the class Computer: Computer::Name, Computer::CurDeplState, Computer::CreateTime). To show individual CI-Attributes as defined in the CI-Definition, the following scheme must be used (example for the class Computer): Computer::HardDisk::1, Computer::HardDisk::1::Capacity::1, Computer::HardDisk::2, Computer::HardDisk::2::Capacity::1. If there is no entry for a CI class, then the default columns are shown.'} =
        'Define as colunas mostradas dos ICs na visão complexa da tabela de ligações, dependendo da classe do IC. Cada entrada deve ser prefixada com o nome da classe e dois pontos duplos (por exemplo, Computador::). Existem alguns atributos de IC que são comuns a todos os ICs (exemplo para a classe Computador: Computador::Nome, Computador::CurDeplState, Computador::CreateTime). Para mostrar atributos de IC individuais, tal como definidos na definição de IC, deve ser utilizado o seguinte esquema (exemplo para a classe Computador): Computador::HardDisk::1, Computador::HardDisk::1::Capacidade::1, Computador::HardDisk::2, Computador::HardDisk::2::Capacidade::1. Se não existir qualquer registo para uma classe de IC, são apresentadas as colunas predefinidas.';
    $Self->{Translation}->{'Defines which items are available for \'Action\' in third level of the ITSM Config Item ACL structure.'} =
        'Define os itens que estão disponíveis para "Ação" no terceiro nível da estrutura do ITSM Config Item ACL.';
    $Self->{Translation}->{'Defines which items are available in first level of the ITSM Config Item ACL structure.'} =
        'Define os itens que estão disponíveis no primeiro nível da estrutura do ITSM Config Item ACL.';
    $Self->{Translation}->{'Defines which items are available in second level of the ITSM Config Item ACL structure.'} =
        'Define os itens que estão disponíveis no segundo nível da estrutura do ITSM Config Item ACL.';
    $Self->{Translation}->{'Defines which type of link (named from the ticket perspective) can affect the status of a linked CI.'} =
        'Define que tipo de ligação (nomeada a partir da perspetiva do bilhete) pode afetar o estado de um IC ligado.';
    $Self->{Translation}->{'Defines which type of ticket can affect the status of a linked CI.'} =
        'Define que tipo de bilhete pode afetar o estado de um IC ligado.';
    $Self->{Translation}->{'Definition Update'} = 'Atualização da definição';
    $Self->{Translation}->{'Delete Configuration Item'} = 'Eliminar item de configuração';
    $Self->{Translation}->{'DeplState'} = 'DeplState';
    $Self->{Translation}->{'Deployment State Color'} = 'Cor do estado de implantação';
    $Self->{Translation}->{'DeploymentState'} = 'Estado de implantação';
    $Self->{Translation}->{'Duplicate'} = 'Duplicar';
    $Self->{Translation}->{'Dynamic field event module that marks config item definitions as out of sync, if containing dynamic fields change.'} =
        'Módulo de evento de campo dinâmico que marca as definições de itens de configuração como fora de sincronia, se os campos dinâmicos contidos forem alterados.';
    $Self->{Translation}->{'Dynamic fields shown in the additional ITSM field screen of the agent interface.'} =
        'Campos dinâmicos mostrados no ecrâ adicional ITSM da interface do agente.';
    $Self->{Translation}->{'Dynamic fields shown in the config item overview screen of the customer interface.'} =
        'Campos dinâmicos apresentados no ecrã de síntese de itens de configuração da interface de cliente.';
    $Self->{Translation}->{'Dynamic fields shown in the config item search screen of the agent interface.'} =
        'Campos dinâmicos apresentados no ecrã de pesquisa de itens de configuração da interface do agente.';
    $Self->{Translation}->{'Enables configuration item bulk action feature for the agent frontend to work on more than one configuration item at a time.'} =
        'Ativa a funcionalidade de ação em massa de itens de configuração para que o frontend do agente trabalhe em mais do que um item de configuração de cada vez.';
    $Self->{Translation}->{'Enables configuration item bulk action feature only for the listed groups.'} =
        'Ativa a funcionalidade de ação em massa de itens de configuração apenas para os grupos listados.';
    $Self->{Translation}->{'Enables/disables the functionality to check ITSM onfiguration items for unique names. Before enabling this option you should check your system for already existing config items with duplicate names. You can do this with the console command Admin::ITSM::Configitem::ListDuplicates.'} =
        'Ativa/desactiva a funcionalidade para verificar se os itens de configuração ITSM têm nomes únicos. Antes de ativar esta opção, deve verificar se existem no seu sistema itens de configuração com nomes duplicados. Pode fazê-lo com o comando da consola Admin::ITSM::Configitem::ListDuplicates.';
    $Self->{Translation}->{'Event module to set configitem-status on ticket-configitem-link.'} =
        'Módulo de eventos para definir o estado do item de configuração no link ticket-configitem.';
    $Self->{Translation}->{'Fields of the configuration item index, used for the fulltext search. Fields are also stored, but are not mandatory for the overall functionality. Inclusion of attachments can be disabled by setting the entry to 0 or deleting it.'} =
        'Campos do índice de itens de configuração, utilizados para a pesquisa de texto integral. Os campos também são armazenados, mas não são obrigatórios para a funcionalidade geral. A inclusão de anexos pode ser desactivada definindo a entrada como 0 ou eliminando-a.';
    $Self->{Translation}->{'Fields stored in the configuration item index which are used for other things besides fulltext searches. For the complete functionality all fields are mandatory.'} =
        'Campos armazenados no índice de itens de configuração que são utilizados para outras coisas para além de pesquisas de texto integral. Para uma funcionalidade completa, todos os campos são obrigatórios.';
    $Self->{Translation}->{'For every webservice (key) an array of classes (value) can be defined on which the import is restricted. For all chosen classes, or all existing classes the identifying attributes will have to be chosen in the invoker config.'} =
        'Para cada serviço Web (chave) pode ser definido um conjunto de classes (valor) às quais a importação é limitada. Para todas as classes escolhidas, ou para todas as classes existentes, os atributos de identificação terão de ser escolhidos na configuração do invocador.';
    $Self->{Translation}->{'GenericInterface module registration for the ConfigItemFetch invoker layer.'} =
        'Registo do módulo GenericInterface para a camada do invocador ConfigItemFetch.';
    $Self->{Translation}->{'ITSM ConfigItem'} = 'ITSM ConfigItem';
    $Self->{Translation}->{'ITSM config item overview.'} = 'Síntese do item de configuração ITSM.';
    $Self->{Translation}->{'InciState'} = 'InciState';
    $Self->{Translation}->{'IncidentState'} = 'Estado do incidente';
    $Self->{Translation}->{'Includes deployment states in the config item search of the customer interface.'} =
        'Inclui estados de implantação na pesquisa de itens de configuração da interface do cliente.';
    $Self->{Translation}->{'Includes incident states in the config item search of the customer interface.'} =
        'Inclui estados de incidentes na pesquisa de itens de configuração da interface do cliente.';
    $Self->{Translation}->{'Maximum number of config items to be displayed in the result of this operation.'} =
        'Número máximo de itens de configuração a apresentar no resultado desta operação.';
    $Self->{Translation}->{'Module to check the group responsible for a class.'} = 'Módulo para verificar o grupo responsável por uma classe.';
    $Self->{Translation}->{'Module to check the group responsible for a configuration item.'} =
        'Módulo para verificar o grupo responsável por um item de configuração.';
    $Self->{Translation}->{'Module to generate ITSM config item statistics.'} = 'Módulo para gerar estatísticas do item de configuração ITSM.';
    $Self->{Translation}->{'Name Module'} = 'Nome do módulo';
    $Self->{Translation}->{'Number Module'} = 'Número Módulo';
    $Self->{Translation}->{'Number of config items to be displayed in each page of a search result in the agent interface.'} =
        'Número de itens de configuração a apresentar em cada página de um resultado de pesquisa na interface do agente.';
    $Self->{Translation}->{'Number of config items to be displayed in each page of a search result in the customer interface.'} =
        'Número de itens de configuração a apresentar em cada página de um resultado de pesquisa na interface do cliente.';
    $Self->{Translation}->{'Objects to search for, how many entries and which attributs to show. ConfigItem attributes have to explicitly be stored via Elasticsearch.'} =
        'Objectos a procurar, quantas entradas e quais os atributos a mostrar. Os atributos ConfigItem têm de ser armazenados explicitamente através do Elasticsearch.';
    $Self->{Translation}->{'Overview.'} = 'Visão Geral.';
    $Self->{Translation}->{'Parameters for the categories for config item classes in the preferences view of the agent interface.'} =
        'Parâmetros para as categorias de classes de itens de configuração na vista de preferências da interface do agente.';
    $Self->{Translation}->{'Parameters for the column filters of the small config item overview. Please note: setting \'Active\' to 0 will only prevent agents from editing settings of this group in their personal preferences, but will still allow administrators to edit the settings of another user\'s behalf. Use \'PreferenceGroup\' to control in which area these settings should be shown in the user interface.'} =
        'Parâmetros para os filtros de coluna da visão geral do item de configuração pequeno. Nota: a definição de "Active" (Ativo) para 0 apenas impede os agentes de editarem as definições deste grupo nas suas preferências pessoais, mas continua a permitir que os administradores editem as definições em nome de outro utilizador. Utilize "PreferenceGroup" para controlar em que área estas definições devem ser apresentadas na interface do utilizador.';
    $Self->{Translation}->{'Parameters for the dashboard backend of the customer company config item overview of the agent interface . "Limit" is the number of entries shown by default. "Group" is used to restrict the access to the plugin (e. g. Group: admin;group1;group2;). "Default" determines if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" is the cache time in minutes for the plugin.'} =
        'Parâmetros para o backend do dashboard da visão geral do item de configuração da empresa do cliente da interface do agente. "Limite" é o número de entradas mostradas por defeito. "Grupo" é utilizado para restringir o acesso ao plugin (por exemplo, Grupo: admin;group1;group2;). "Predefinição" determina se o plugin está ativado por defeito ou se o utilizador tem de o ativar manualmente. "CacheTTLLocal" é o tempo de cache em minutos para o plugin.';
    $Self->{Translation}->{'Parameters for the deployment states color in the preferences view of the agent interface.'} =
        'Parâmetros para a cor dos estados de implementação na vista de preferências da interface do agente.';
    $Self->{Translation}->{'Parameters for the deployment states in the preferences view of the agent interface.'} =
        'Parâmetros de estado de implementação nas preferências de visualização da interface de agente.';
    $Self->{Translation}->{'Parameters for the example permission groups of the general catalog attributes.'} =
        'Parâmetros do grupos de permissão de exemplo dos atributos do catálogo geral.';
    $Self->{Translation}->{'Parameters for the name module for config item classes in the preferences view of the agent interface.'} =
        'Parâmetros para o módulo de nomes para classes de itens de configuração na vista de preferências da interface do agente.';
    $Self->{Translation}->{'Parameters for the number module for config item classes in the preferences view of the agent interface.'} =
        'Parâmetros para o módulo de números para classes de itens de configuração na vista de preferências da interface do agente.';
    $Self->{Translation}->{'Parameters for the pages (in which the configuration items are shown).'} =
        'Parâmetros das páginas (nas quais os itens de configuração são visualizados).';
    $Self->{Translation}->{'Parameters for the version string module for config item classes in the preferences view of the agent interface.'} =
        'Parâmetros para o módulo de cadeia de versões para classes de itens de configuração na vista de preferências da interface do agente.';
    $Self->{Translation}->{'Parameters for the version string template toolkit module for config item classes in the preferences view of the agent interface.'} =
        'Parâmetros para o módulo do conjunto de ferramentas do modelo de cadeia de versões para classes de itens de configuração na vista de preferências da interface do agente.';
    $Self->{Translation}->{'Parameters for the version trigger for config item classes in the preferences view of the agent interface.'} =
        'Parâmetros para o acionador de versão para classes de itens de configuração na vista de preferências da interface do agente.';
    $Self->{Translation}->{'Performs the configured action for each event (as an Invoker) for each configured Webservice.'} =
        'Executa a ação configurada para cada evento (como Invocador) para cada Webservice configurado.';
    $Self->{Translation}->{'Permission Group'} = 'Permissão';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item attachment action in the agent interface.'} =
        'Permissões necessárias para utilizar a ação de anexação do item de configuração ITSM na interface do agente.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item screen in the agent interface.'} =
        'Permissões necessárias para usar o formulário de item de configuração ITSM de agente.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item search screen in the agent interface.'} =
        'Permissões necessárias para usar o formulário de pesquisa de item de configuração ITSM de agente.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item search screen in the customer interface.'} =
        'Permissões necessárias para utilizar o ecrã de pesquisa de itens de configuração ITSM na interface do cliente.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item tree view screen in the agent interface.'} =
        'Permissões necessárias para utilizar o ecrã de visualização em árvore do item de configuração ITSM na interface do agente.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item zoom screen in the agent interface.'} =
        'Permissões necessárias para usar o formulário de detalhes do item de configuração ITSM de agente.';
    $Self->{Translation}->{'Required permissions to use the add ITSM configuration item screen in the agent interface.'} =
        'Permissões necessárias para usar o formulário de adição de item de configuração ITSM de agente.';
    $Self->{Translation}->{'Required permissions to use the bulk ITSM configuration item screen in the agent interface.'} =
        'Permissões necessárias para utilizar o ecrã de itens de configuração ITSM em massa na interface do agente.';
    $Self->{Translation}->{'Required permissions to use the edit ITSM configuration item screen in the agent interface.'} =
        'Permissões necessárias para usar o formulário de edição de item de configuração ITSM de agente.';
    $Self->{Translation}->{'Required permissions to use the history ITSM configuration item screen in the agent interface.'} =
        'Permissões necessárias para usar o formulário de histórico de item de configuração ITSM de agente.';
    $Self->{Translation}->{'Required permissions to use the print ITSM configuration item screen in the agent interface.'} =
        'Permissões necessárias para usar o formulário de impressão de item de configuração ITSM na interface do agente.';
    $Self->{Translation}->{'Required privileges to delete config items.'} = 'Privilégios necessários para eliminar itens de configuração.';
    $Self->{Translation}->{'Search config items.'} = 'Procurar itens de configuração.';
    $Self->{Translation}->{'Set the incident state of a CI automatically when a Ticket is Linked to a CI.'} =
        'Definir o estado do incidente de um IC automaticamente quando um ticket é vinculado a um IC.';
    $Self->{Translation}->{'Sets the deployment state in the configuration item bulk screen of the agent interface.'} =
        'Define o estado de implementação no ecrã em bloco do item de configuração da interface do agente.';
    $Self->{Translation}->{'Sets the incident state in the configuration item bulk screen of the agent interface.'} =
        'Define o estado do incidente no ecrã em bloco do item de configuração da interface do agente.';
    $Self->{Translation}->{'Shows a link in the menu that allows linking a configuration item with another object in the config item zoom view of the agent interface.'} =
        'Mostra um link no menu que permite associar um item de configuração a outro objeto na vista de detalhes do item de configuração de agente.';
    $Self->{Translation}->{'Shows a link in the menu to access the history of a configuration item in the configuration item overview of the agent interface.'} =
        'Mostra uma ligação no menu para aceder ao histórico de um item de configuração na síntese de itens de configuração da interface do agente.';
    $Self->{Translation}->{'Shows a link in the menu to access the history of a configuration item in the its zoom view of the agent interface.'} =
        'Mostra um link no menu para aceder o histórico de item de configuração na vista de agente.';
    $Self->{Translation}->{'Shows a link in the menu to delete a configuration item in its zoom view of the agent interface.'} =
        'Mostra uma ligação no menu para eliminar um item de configuração na sua vista de zoom da interface do agente.';
    $Self->{Translation}->{'Shows a link in the menu to display the configuration item links as a Tree View.'} =
        'Mostra uma ligação no menu para apresentar as ligações dos itens de configuração como uma Vista em Árvore.';
    $Self->{Translation}->{'Shows a link in the menu to duplicate a configuration item in the configuration item overview of the agent interface.'} =
        'Mostra uma ligação no menu para duplicar um item de configuração na síntese de itens de configuração da interface do agente.';
    $Self->{Translation}->{'Shows a link in the menu to duplicate a configuration item in the its zoom view of the agent interface.'} =
        'Mostra um link no menu para duplicar um item de configuração na vista de agente.';
    $Self->{Translation}->{'Shows a link in the menu to edit a configuration item in the its zoom view of the agent interface.'} =
        'Mostra um link no menu para editar um item de configuração na vista de agente.';
    $Self->{Translation}->{'Shows a link in the menu to go back in the configuration item zoom view of the agent interface.'} =
        'Mostra uma ligação no menu para voltar à vista de zoom do item de configuração da interface do agente.';
    $Self->{Translation}->{'Shows a link in the menu to print a configuration item in the its zoom view of the agent interface.'} =
        'Mostra um link no menu para imprimir um item de configuração na vista de detalhes de agente.';
    $Self->{Translation}->{'Shows a link in the menu to zoom into a configuration item in the configuration item overview of the agent interface.'} =
        'Mostra uma ligação no menu para ampliar um item de configuração na síntese de itens de configuração da interface do agente.';
    $Self->{Translation}->{'Shows the config item history (reverse ordered) in the agent interface.'} =
        'Mostra o histórico do item configuração (ordem inversa) no interface de agente.';
    $Self->{Translation}->{'The default category which is shown, if none is selected.'} = 'A categoria predefinida que é mostrada, se não for selecionada nenhuma.';
    $Self->{Translation}->{'The identifier for a configuration item, e.g. ConfigItem#, MyConfigItem#. The default is ConfigItem#.'} =
        'O identificador de um item de configuração, por exemplo, ConfigItem#, MyConfigItem#. A predefinição é ConfigItem#.';
    $Self->{Translation}->{'Triggers ConfigItemFetch invoker automatically.'} = 'Acciona automaticamente o invocador ConfigItemFetch.';
    $Self->{Translation}->{'Version String Expression'} = 'Versão Expressão de cadeia de caracteres';
    $Self->{Translation}->{'Version String Module'} = 'Versão String Módulo';
    $Self->{Translation}->{'Version Trigger'} = 'Acionador de versão';
    $Self->{Translation}->{'Whether the execution of ConfigItemACL can be avoided by checking cached field dependencies. This can improve loading times of formulars, but has to be disabled, if ACLModules are to be used for ITSMConfigItem- and Form-ReturnTypes.'} =
        'Se a execução de ConfigItemACL pode ser evitada através da verificação das dependências de campo em cache. Isto pode melhorar os tempos de carregamento dos formulários, mas tem de ser desativado, se os ACLModules tiverem de ser utilizados para ITSMConfigItem- e Form-ReturnTypes.';
    $Self->{Translation}->{'Which general information is shown in the header.'} = 'Que informações gerais são apresentadas no cabeçalho.';
    $Self->{Translation}->{'class'} = 'classe';
    $Self->{Translation}->{'global'} = 'global';
    $Self->{Translation}->{'postproductive'} = 'pós-produtivo';
    $Self->{Translation}->{'preproductive'} = 'pré-produtivo';
    $Self->{Translation}->{'productive'} = 'produtivo';


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

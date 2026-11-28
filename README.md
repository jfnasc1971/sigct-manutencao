# Documentação consolidada

Este arquivo reúne o conteúdo dos arquivos README encontrados nas subpastas do workspace.


## Fonte: RTC22877402/Readme.md

RTC 22877402 - SIGCT - Contrato Especializado - Integração com a aplicação SIMPF

SYSTEM PROPERTY:

<property name="sigct_server" value="https://sigct.fabrica:8443/sigct/"/>

CHAMADA API ATUALIZAR VALOR OS:

http://sigct.fabrica:8080/sigct/api/ordemServico/atualizarValor/708174

Dados de envio:
 
- Layout do arquivo de envio

  - Item de Portifólio (4 dígitos)
  - Squad (chave 5 dígitos)
  - Sprint 
	- ID (4 dígitos)
	- Nome (150 caracteres)
  - ID da Contagem (10 dígitos)
  - Versão Contagem: Texto. Exemplo: v1, v2, v3
  - Tipo: Contagem ou Divergência: C ou D
  - Data da Contagem/Atualização
  - Origem (motivo): Número do RTC ou AIMM que originou a contagem/divergência
      - Número do IB
	    - Valor PF: duas casas decimais
	    - Tipo PF: Incluído PF, Alterado PF, Excluído PF, Incluído Convertido, Alterado Convertido, Excluído Convertido (apenas para tradicional)

Dados de retorno
 
- Layout do arquivo de retorno
  - Item de Portifólio (4 dígitos)
  - Squad (chave 5 dígitos)
  - Sprint 
	- ID (4 dígitos)
	- Nome (150 caracteres)
  - ID da Contagem
  - Versão Contagem: Texto. Exemplo: v1, v2, v3
  - Tipo: Contagem ou Divergência: C ou D
  - Data da Contagem/Atualização
  - Origem (motivo): Número do RTC ou AIMM que originou a contagem/divergência
      - Número do IB
 	    - Valor PF: duas casas decimais
	    - Tipo PF: Incluído PF, Alterado PF, Excluído PF, Incluído Convertido, Alterado Convertido, Excluído Convertido (apenas para tradicional)

  - Código de retorno

      - O: sucesso
      - 1: erro

  - Mensagem de erro: texto

	  - Campo <nome do campo não preenchido> não informado. (Todos os bancos obrigatórios)

	  - <nome do campo> não existe no SIGCT. (Item de Portifólio, Squad, Sprint, Número do IB)
 


---

## Fonte: RTC23452881/Readme.md

RTC 23452881 - SIGCT - Melhoria no Cálculo dos Indicadores de Qualidade

1. Configuração dos Indicadores

Cadastro e Vinculação

Configuração básica dos indicadores e associação ao grupo/contrato nas tabelas:

gct.gcttb112_tipo_indicador
gct.gcttb115_grupo_indicador

Definição de Faixas

Novas Faixas: Criar faixas exclusivas para este contexto (não reutilizar de outros contratos).
Identificador (nu_faixa): Selecionar um ID disponível manualmente em vez de usar sequence. 
Isso garante a criação de um script de carga seguro e previsível.

Tabelas Relacionadas

gct.gcttb056_tipo_faixa: Definição da nova faixa.
gct.gcttb057_valor_faixa: Valores vinculados à faixa criada.
gct.gcttb115_grupo_indicador: Vinculação entre grupo, contrato e indicador.
gct.gcttb131_tipo_faixa_indicador: Relacionamento entre grupo, contrato, indicador e faixa.

O levantamento das situações solicitado anteriormente servirá para popular as tabelas abaixo, conforme a regra de cada indicador:

gct.gcttb191_servico_entregue
gct.gcttb192_servico_contratado
gct.gcttb193_servico_atraso
gct.gcttb194_servico_devolvido

2. Massa de Testes

Solução para permitir os testes e o desenvolvimento, enquanto identifico qual foi problema da vinculação automática.
Escolher 3 equipes por grupo (sendo 2 ativas e 1 concluída).
Associar "N" Serviços de Qualidade a cada uma delas.
Levantar os cenários de teste e desenvolver scripts para manipular esses dados conforme os cenários de teste previstos.
Márcio e Leandro podem auxiliar nesta etapa.

3. Implementação dos indicadores

3.1 FATURAMENTO

Fluxo Principal

src/Objetos_BD/Functions/GCTFN300_FECHAR_FATURAMENTO_DDL.sql

RN1344 - Indicador de Qualidade de Equipes de Contratos de Qualidade IQU

src/Objetos_BD/Functions/GCTFN204_INDICADOR_QUALIDADE_DDL.sql

RN1345 - Indicador de Prazo de Equipes de Contratos de Qualidade IPZECQ

src/Objetos_BD/Functions/GCTFN205_INDICADOR_PRAZO_DDL.sql

RN1346 - indicador de Aderência ao Planejamento de Equipes de Contratos de Qualidade IAPECQ

src/Objetos_BD/Functions/GCTFN206_INDICADOR_PLANEJAMENTO_DDL.sql

RN1347 - Indicador de Produtividade de Equipes de Contratos de Qualidade IPRECQ

src/Objetos_BD/Functions/GCTFN207_INDICADOR_PRODUTIVIDADE_DDL.sql

RN1348 - Indicador de Turnover de Desligamento de Equipes de Contratos de Qualidade ITDCQ

src/Objetos_BD/Functions/GCTFN208_INDICADOR_TURNOVER_DDL.sql

3.1 AJUSTE

Fluxo principal

src/Objetos_BD/Functions/GCTFN303_CALCULAR_INDICADOR_DDL.sql

RN1344 - Indicador de Qualidade de Equipes de Contratos de Qualidade IQU

src/Objetos_BD/Functions/GCTFN214_INDICADOR_QUALIDADE_AJUSTE_DDL.sql

RN1345 - Indicador de Prazo de Equipes de Contratos de Qualidade IPZECQ

src/Objetos_BD/Functions/GCTFN215_INDICADOR_PRAZO_AJUSTE_DDL.sql

RN1346 - indicador de Aderência ao Planejamento de Equipes de Contratos de Qualidade IAPECQ

src/Objetos_BD/Functions/GCTFN216_INDICADOR_PLANEJAMENTO_AJUSTE_DDL.sql

RN1347 - Indicador de Produtividade de Equipes de Contratos de Qualidade IPRECQ

src/Objetos_BD/Functions/GCTFN217_INDICADOR_PRODUTIVIDADE_AJUSTE_DDL.sql

RN1348 - Indicador de Turnover de Desligamento de Equipes de Contratos de Qualidade ITDCQ

src/Objetos_BD/Functions/GCTFN218_INDICADOR_TURNOVER_AJUSTE_DDL.sql

4. Bônus e Descontos

Criar coluna vr_total_desconto (numeric) em gct.gcttb170_termo_equipe.
Criar coluna vr_total_bonus (numeric) em gct.gcttb170_termo_equipe.

TODO: Validar onde este cálculo será integrado no fluxo de faturamento/ajuste.

5. Termos

Ajustar template do Termo Mensal (TME) para mostrar os valores de Bônus e Descontos.
Exibir campos apenas se o grupo do Contrato possuir essas opções habilitadas.

Atenção: Formatar valores numéricos no padrão monetário brasileiro (R$).

6. Empenhos

Ajustar template de Empenhos para detalhar Bônus e Descontos de cada Termo.
Exibir apenas se o grupo do Contrato permitir tais opções.

Atenção: Manter formatação de moeda local (BRL).

7. Relatório de Indicadores

Sem alterações por agora. Vamos avaliar após o início do processamento dos indicadores.


---

## Fonte: RTC23671403/integracao/sinop/Readme.md

# SINOP

URL API: https://sinop-faturamento-api-prd.apps.apl4.caixa/notas-faturamento?ciclo=10/2025

* baixar os arquivos, um para cada mes
* criar a tabela temporaria
* executar TestCargaNotaCodigo.main

---

## Fonte: RTC23671403/Readme.md

RTC 23671403 - SIGCT - Indicadores do contrato especializado

Indicadores aplicados nas equipes de SUPORTE:

ÍNDICE DE EFETIVIDADE
ÍNDICE DE DESEMPENHO DA EQUIPE 
ÍNDICE DE ESTOQUE DE TURNOVER

Indicadores aplicados nas equipes de DESENVOLVIMENTO:
ÍNDICE DE EFETIVIDADE
ÍNDICE DE PRODUTIVIDADE
ÍNDICE DE QUALIDADE
ÍNDICE DE DESEMPENHO DA EQUIPE 
ÍNDICE DE ESTOQUE DE TURNOVER

2. Indicadores Especializado
 
2.1 Estoque de Atendimento
• A CAIXA define as tarefas que a equipe deve atender, com base em critérios de importância e estratégia.
• A CAIXA também define se a equipe atuará como suporte ou desenvolvimento, podendo alterar essa definição conforme necessário.
 
2.2 Aceite ou Recusa de Solicitações
• A equipe tem 24 horas para aceitar ou recusar uma solicitação via ferramenta de gestão.
• Em caso de recusa, é obrigatório registrar a justificativa.
 
2.3 Avaliação de Recusa pela CAIXA
• A CAIXA avalia a justificativa:
• Aceita: a solicitação não entra na medição de desempenho.
• Rejeitada: a solicitação será considerada como aceita desde a data de inclusão no estoque.
 
2.4. Indicadores de Nível de Serviço
Efetividade - Verifica se a entrega corresponde ao que foi planejado.
Produtividade - Mede os pontos de função entregues versus o esperado.
Qualidade - Avalia a redução de defeitos e a nota do código fonte.
Turnover - Mede a rotatividade da equipe.
 
2.5. Cálculo dos Indicadores
• Efetividade, Produtividade e Qualidade: calculados mensalmente por equipe, com base no mês anterior.
• Turnover: calculado trimestralmente, com base nos funcionários ativos no fim do trimestre anterior e nas saídas do trimestre atual.
 
2.6 Índice de Desempenho Global (IDG)
• O IDG é a média ponderada dos indicadores de desempenho das equipes e do índice de Turnover.
• A meta de satisfação é um IDG ≥ 85%.
 
À Caixa,
 
De acordo com reunião realizado no dia 11/08/2025 adicionada às novas informações encaminhadas pela GEPAC ao final do mesmo dia, temos as seguintes definições para o cálculo dos indicadores do especializado:
1. A rotina para calcular os indicadores de desempenho será executada no dia 5 de cada mês, à 01:00h;
2. Para o indicador de Efetividade, serão considerados os Itens de Backlog com data prevista de atendimento compreendida entre o primeiro e o último dia do mês anterior.
3. Para o indicador de Produtividade, serão consideradas as Sprints com data fim compreendida entre o primeiro e o último dia do mês anterior.
4. Para o indicador de Qualidade, a nota recebida da API da GESQI será aplicada em todos os Itens de Backlog, da Sigla informada, que tenham data prevista de atendimento compreendida entre o primeiro e o último dia do mês anterior.
5. Para o indicador de Turnover, será considerada a data fim dos membros que estejam com a opção Turnover selecionada no cadastro do membro na equipe.
 
Diante destas definições, vamos elaborar a documentação e dar andamento ao atendimento.

---

## Fonte: RTC24161898/Readme.md

RTC 24161898 - SIGCT - Atualiza Solicitação e Inclui solicitação no SIGCT - Vincula Solicitação Demanda (CAPEX)


---

## Fonte: RTC24356697/Readme.md

RTC 24356697 - SIGCT - Inclusão do campo "Tipo de Atendimento" na funcionalidade Perfil Profissional

/SIGCT/DDL-DML/RTC24356697_01_DDL.sql
/SIGCT/DDL-DML/RTC24356697_02_DML.sql
/SIGCT/DDL-DML/RTC24356697_RETORNO_01_DDL.sql
/SIGCT/DDL-DML/RTC24356697_RETORNO_02_DML.sql
/SIGCT/Build/sigct_4.39.12.ear
/SIGCT/Build/sigct_backend_4.39.12.ear
/SIGCT/Testes/SIGCT_Evidencia_Teste_RTC24356697.docx


---

## Fonte: RTC24444623/Readme.md

RTC 24444623 - SIGCT - (Auditoria) Criação de Funcionalidade para não permitir sprint vazias

RTC24444623_01_DDL.sql
RTC24444623_02_DDL.sql
RTC24444623_03_DML.sql
RTC24444623_RETORNO_01_DDL.sql
RTC24444623_RETORNO_02_DDL.sql
RTC24444623_RETORNO_03_DML.sql


---

## Fonte: RTC24444760/Readme.md

RTC 24444760 - SIGCT - (Auditoria) O SIGCT não pode permitir preenchimento de Pontos de Função em demandas do tipo Sustentação/Serviço prestado de acordo com cada Grupo

---

## Fonte: RTC24449383/Readme.md

RTC 24449383 - SIGCT - Inclusão de parâmetro para ativar os indicadores do especializado

# Como administrador do sistema
Quero ter uma opção parametrizada para ativar ou desativar os cálculos dos indicadores,
Para que eu possa controlar quando os indicadores devem ser processados, evitando cálculos desnecessários ou fora do contexto.
Observações Técnicas
* Avaliar impacto em processos automáticos (jobs, integrações).
* Garantir que a mudança não afete indicadores históricos.
 
# Critérios de Aceitação
* Deve existir um parâmetro configurável no sistema.
* Quando o parâmetro estiver desativado, nenhum cálculo de indicadores deve ser executado, mesmo que outras rotinas sejam acionadas.
* Quando o parâmetro estiver ativado, os cálculos devem ocorrer normalmente conforme as regras atuais.
* A configuração deve ser persistida e refletir corretamente no comportamento do sistema.
* Deve haver registro (log) indicando quando o parâmetro foi alterado e por quem.

---

## Fonte: RTC24755360/Readme.md

RTC 24755360 - SIGCT - INTEGRAÇÃO  SIGCT x SIPGC3 - Grupos e serviços do contrato

Vamos enviar no ws somente grupos e serviços do Ágil/Especializado
 
No RTC, ficaria assim:
 
GRUPO
 
Ágil: Serviços de Arquitetura
 
SERVIÇOS
 
Ágil: Acompanhamento in-loco Impl. Arquitetura
Ágil: Definição de  Arquiteturas
Ágil: Documentação
Ágil: Prospecção de Tecnologias e Experimentações
Ágil: Serviços de Análise de Arquiteturas e de Negócios
Ágil: Serviços de Suporte às Arquiteturas
 
A regra de vinculação será resscrita assim:
 
Se o noTipoGrupo ou noTipoServioinicia com alguma coisa ':', o sistema considera o que vem depois dos dois pontos par encontrar grupo e serviço

{
  "codigoRetorno": "0",
  "mensagemRetorno": "Operação realizada com sucesso!",
  "resultado": [
    {
      "noTipoGrupo": "Desenvolvimento",
      "noTipoContratacao": "Especializado",
      "servicos": [
        {
          "noTipoServico": "Squad - Contrato Especializado"
        },
        {
          "noTipoServico": "Suporte - Contrato Especializado"
        }
      ]
    }
  ],
  "quantidadeRegistros": 1,
  "dataConsulta": "2026-03-26 14:04"
}



---

## Fonte: service_now/README.md

STRY00052468: SIGCT - Integração Servicenow

COMO gestor do SIGCT
QUERO que o SIGCT realize integração com o ServiceNow para consultar automaticamente as demandas registradas
PARA vincular as demandas do ServiceNow no SIGCT com os campos determinados para aplicação de custo/indicadores


Regras de Negócio
RN-01
O sistema deve consultar demandas do ServiceNow a partir de identificador único (ex: número da solicitação).

RN-02
Para cada demanda do ServiceNow, o sistema deve verificar:
• se existe ID com registro de ServiceNow (nos casos de migração) já criado e vinculado ao SIGCT (se positivo descartar o ID)
• se já existe vínculo com o SIGCT
• se não existe vinculo executar a vinculação no SIGCT


RN-03
A validação deve considerar, no mínimo:
• código da solicitação
• descrição
• sistema
• módulo
• data
• tipo da demanda
(compatível com campos já utilizados na integração SIGCT x RTC)

RN-04
•	Para contratos unificados (especializados), aplicam-se as seguintes regras:
o	Contratos do mesmo fornecedor:
Uma mesma história pode ser vinculada a mais de uma equipe de suporte, mesmo que essas equipes pertençam a contratos distintos do mesmo fornecedor.
Uma mesma história não pode ser vinculada a mais de uma equipe de desenvolvimento, ainda que vinculadas a contratos distintos do mesmo fornecedor, a fim de evitar a apuração duplicada de Pontos de Função (PF).
o	Contratos de fornecedores diferentes:
Uma mesma história não pode ser vinculada a equipes pertencentes a fornecedores distintos.
o	Contratos antigos (não unificados):
Permanece válida a regra vigente


<dependencies>
    <dependency>
        <groupId>io.jsonwebtoken</groupId>
        <artifactId>jjwt</artifactId>
        <version>0.9.1</version>
    </dependency>

    <dependency>
        <groupId>com.fasterxml.jackson.core</groupId>
        <artifactId>jackson-databind</artifactId>
        <version>2.9.10.8</version>
    </dependency>
</dependencies>

Client ID: ae7147c725f04ddc8969b5f68166445e
Client Secret: z~G.!qC:eCGG.K|rie<HGcZ;G,1nWPNz
User ID: spm.integrations
KID: 336a5741b014485d95e5ff15465dafa0

TABELAS
293 | gcttb293 | ----- DISPONIVEL -----
294 | gcttb294 | ----- DISPONIVEL -----
295 | gcttb295 | ----- DISPONIVEL -----
299 | gcttb299 | ----- DISPONIVEL -----
 
FUNCTIONS
190 | gctfn190 | ----- DISPONIVEL -----
191 | gctfn191 | ----- DISPONIVEL -----
192 | gctfn192 | ----- DISPONIVEL -----
193 | gctfn193 | ----- DISPONIVEL -----
194 | gctfn194 | ----- DISPONIVEL -----
195 | gctfn195 | ----- DISPONIVEL -----

---

## Fonte: service-now-client/Readme.md

# SERVICE NOW CLIENT

## VARIAVEIS NO SERVIDOR DE APLICACAO (EXEMPLO JBOSS EAP)

<property name="javax.net.ssl.keyStore" value="C:\\caixa\\service_now\\sigct.cliservicenow.keystore"/>
<property name="javax.net.ssl.keyStorePassword" value="changeit"/>
<property name="service.now.url" value="https://caixaesmhmp.service-now.com"/>
<property name="service.now.keystore.alias" value="sigct.cliservicenow.des.caixa"/>
<property name="service.now.keystore.clientId" value="ae7147c725f04ddc8969b5f68166445e"/>
<property name="service.now.keystore.clientSecret" value="z~G.!qC:eCGG.K|rie&lt;HGcZ;G,1nWPNz"/>
<property name="service.now.keystore.kid" value="336a5741b014485d95e5ff15465dafa0"/>
<property name="service.now.keystore.userId" value="spm.integrations"/>
<property name="service.now.keystore.privateKeyPassword" value="changeit"/>
<property name="service.now.http.proxy3" value="proxydes.caixa:80"/>

---

## Fonte: STRY00023299/Readme.md

STRY00023299: SIGCT - Adaptação de relatórios e indicadores para o Service Now ( RTC 25313232 )

---

## Fonte: STRY00052468/README.md

STRY00052468: SIGCT - Integração Servicenow

COMO gestor do SIGCT
QUERO que o SIGCT realize integração com o ServiceNow para consultar automaticamente as demandas registradas
PARA vincular as demandas do ServiceNow no SIGCT com os campos determinados para aplicação de custo/indicadores


Regras de Negócio
RN-01
O sistema deve consultar demandas do ServiceNow a partir de identificador único (ex: número da solicitação).

RN-02
Para cada demanda do ServiceNow, o sistema deve verificar:
• se existe ID com registro de ServiceNow (nos casos de migração) já criado e vinculado ao SIGCT (se positivo descartar o ID)
• se já existe vínculo com o SIGCT
• se não existe vinculo executar a vinculação no SIGCT


RN-03
A validação deve considerar, no mínimo:
• código da solicitação
• descrição
• sistema
• módulo
• data
• tipo da demanda
(compatível com campos já utilizados na integração SIGCT x RTC)

RN-04
•	Para contratos unificados (especializados), aplicam-se as seguintes regras:
o	Contratos do mesmo fornecedor:
Uma mesma história pode ser vinculada a mais de uma equipe de suporte, mesmo que essas equipes pertençam a contratos distintos do mesmo fornecedor.
Uma mesma história não pode ser vinculada a mais de uma equipe de desenvolvimento, ainda que vinculadas a contratos distintos do mesmo fornecedor, a fim de evitar a apuração duplicada de Pontos de Função (PF).
o	Contratos de fornecedores diferentes:
Uma mesma história não pode ser vinculada a equipes pertencentes a fornecedores distintos.
o	Contratos antigos (não unificados):
Permanece válida a regra vigente


<dependencies>
    <dependency>
        <groupId>io.jsonwebtoken</groupId>
        <artifactId>jjwt</artifactId>
        <version>0.9.1</version>
    </dependency>

    <dependency>
        <groupId>com.fasterxml.jackson.core</groupId>
        <artifactId>jackson-databind</artifactId>
        <version>2.9.10.8</version>
    </dependency>
</dependencies>

Client ID: ae7147c725f04ddc8969b5f68166445e
Client Secret: z~G.!qC:eCGG.K|rie<HGcZ;G,1nWPNz
User ID: spm.integrations
KID: 336a5741b014485d95e5ff15465dafa0

TABELAS
293 | gcttb293 | ----- DISPONIVEL -----
294 | gcttb294 | ----- DISPONIVEL -----
295 | gcttb295 | ----- DISPONIVEL -----
299 | gcttb299 | ----- DISPONIVEL -----
 
FUNCTIONS
190 | gctfn190 | ----- DISPONIVEL -----
191 | gctfn191 | ----- DISPONIVEL -----
192 | gctfn192 | ----- DISPONIVEL -----
193 | gctfn193 | ----- DISPONIVEL -----
194 | gctfn194 | ----- DISPONIVEL -----
195 | gctfn195 | ----- DISPONIVEL -----

<property name="javax.net.ssl.keyStore" value="/projetos/caixa/sigct/opt/EAP-DES-6.4.0/sigct.cliservicenow.keystore"/>
<property name="javax.net.ssl.keyStorePassword" value="changeit"/>
<property name="service.now.url" value="https://caixaesmhmp.service-now.com"/>
<property name="service.now.keystore.alias" value="sigct.cliservicenow.des.caixa"/>
<property name="service.now.keystore.clientId" value="ae7147c725f04ddc8969b5f68166445e"/>
<property name="service.now.keystore.clientSecret" value="z~G.!qC:eCGG.K|rie&lt;HGcZ;G,1nWPNz"/>
<property name="service.now.keystore.kid" value="336a5741b014485d95e5ff15465dafa0"/>
<property name="service.now.keystore.userId" value="spm.integrations"/>
<property name="service.now.keystore.privateKeyPassword" value="changeit"/>        
<property name="service.now.http.proxy" value="proxydes.caixa:80"/>

O servidor sctdeapllx0017.df.caixa [10.116.83.18] não está conseguindo se conectar ao servidor de HMP do Service Now (    
https://caixaesmhmp.service-now.com). Erro de timeout:

2026-08-24 11:21:31,338 INFO [stdout] (EJB default - 1) 2026-08-24 11:21:31,338 INFO ServiceNowService - Integracao SERVICE NOW - IMPORTAR DADOS - Iniciando...

2026-08-24 11:22:34,807 INFO [stdout] (EJB default - 1) 2026-08-24 11:22:34,805 ERROR IntegracaoServiceNow - Tempo esgotado para conexão (Connection timed out)

2026-08-24 11:22:34,807 INFO [stdout] (EJB default - 1) java.net.ConnectException: Tempo esgotado para conexão (Connection timed out)

--
-- SERVICOS
--
Manutenção Evolutiva
Manutenção Perfectiva
Manutenção Adaptativa
Manutenção Corretiva
Serviço Técnico Especializado
Inovações em Tecnologia / Negócio
Desenvolvimento de Novos Sistemas

--
--
--
start_date Data de início planejada
end_date Data de término planejada dh_prevista


"u_department" : "5229-GECPA",
"number" : "STRY00013587",
"short_description" : "SIGCT - Teste",
"type" : "Serviço Técnico Especializado",
"state" : "Pronto",
"cmdb_ci" : "SIGCT-Gestão de Serviços Terceirizados TI",
"cmdb_ci.number" : "APM0002740",
"start_date" : "2026-08-24 00:00:00", -- Data de início planejada -- dh_inicio
"end_date" : "2026-09-20 15:21:32", -- Data de término planejada -- dh_prevista
"work_start" : "2026-08-24 15:21:21", -- Data de início real -- dh_inicio_desenvolvimento
"work_end" : "2026-08-25 15:23:04", -- Data de término real -- dh_resolucao
"u_last_ready_state_update" : "2026-08-25 15:22:56", -- Data pronto -- dh_efetiva
"u_last_return_ready_state" : "2026-08-25 15:27:27", -- Data de devolução
"sys_updated_on" : "2026-08-25 15:23:10", -- dh_modificacao
"eap_team" : "CL080",
"u_capex_criteria" : null,
"iteration" : "",
"iteration.sys_id" : "",
"iteration.state" : null,
"iteration.start_date" : "",
"iteration.end_date" : "",
"assigned_to.employee_number" : "922063",
"assigned_to" : "JOSE FLAVIO LINS DO NASCIMENTO",
"sys_id" : "7da19f2b3bfe87d0d6a4cb8693e45acb",
"sys_created_on" : "2026-08-25 15:20:45" -- Data criação -- dh_criacao

1. se for contrato especializado
  a) recuperar a matricula da tarefa
  b) recuperar a equipe a que pertence à matrícula
  c) vincular à equipe. O serviço será SEMPRE o configurado para o grupo daquela equipe, ou seja:
    Se o membro está numa equipe de Desenvolvimento: 
      Squad - Contrato Especializado
    Se o membro está numa equipe de Suporte: 
      Suporte - Contrato Especializado

2. se NÃO for contrato especializado
  a) recuperar a matricula da tarefa
  b) recuperar a equipe a que pertence à matrícula
  c) vincular à equipe (o serviço, nesse caso, será aquele informado na tarefa)

response.setCharacterEncoding("UTF-8");
response.setContentType("text/html; charset=UTF-8");

#
#
#
javax.net.ssl.keyStore: Verificar o valor com a equipe CAIXA de Produção
javax.net.ssl.keyStorePassword: Verificar o valor com a equipe CAIXA de Produção
service.now.keystore.alias: Verificar o valor com a equipe CAIXA de Produção
service.now.keystore.userId: Verificar o valor com a equipe CAIXA de Produção
service.now.keystore.privateKeyPassword: Verificar o valor com a equipe CAIXA de Produção
service.now.http.proxy: Verificar o valor com a equipe CAIXA de Produção

service.now.url: Verificar valor com a equipe SERVICE NOW de Produção
service.now.keystore.clientId: Verificar valor com a equipe SERVICE NOW de Produção
service.now.keystore.clientSecret: Verificar valor com a equipe SERVICE NOW de Produção
service.now.keystore.kid: Verificar valor com a equipe SERVICE NOW de Produção

javax.net.ssl.keyStore: /opt/EAP-6.4.0/standalone/configuration/sigct.cliservicenow.keystore - ARQUIVO ENCONTRADO: true
javax.net.ssl.keyStorePassword: **************
service.now.url: https://caixaesmhmp.service-now.com
service.now.keystore.alias: sigct.cliservicenow.des.caixa
service.now.keystore.clientId: ae7147c725f04ddc8969b5f68166445e
service.now.keystore.clientSecret: **************
service.now.keystore.kid: 336a5741b014485d95e5ff15465dafa0
service.now.keystore.userId: spm.integrations
service.now.keystore.privateKeyPassword: **************
service.now.http.proxy: proxydes.caixa:80


/SIGCT/DDL-DML/STRY00052468_01_DDL.sql
/SIGCT/DDL-DML/STRY00052468_02_DDL.sql
/SIGCT/DDL-DML/STRY00052468_03_DML.sql
/SIGCT/DDL-DML/RETORNO/STRY00052468_RETORNO_01_DDL.sql
/SIGCT/DDL-DML/RETORNO/STRY00052468_RETORNO_02_DDL.sql
/SIGCT/DDL-DML/RETORNO/STRY00052468_RETORNO_03_DML.sql
/SIGCT/Build/sigct_4.52.0.FINAL.ear
/SIGCT/Build/sigct_backend_4.52.0.FINAL.ear
/SIGCT/Testes/SIGCT_Evidencia_Teste_STRY00052468.docx




---

## Fonte: WebServices/json/README.md

# API de Equipes e Indicadores

## Estrutura dos dados

Os dados desta documentação foram extraídos da planilha `SIGCT_Relatorio_Indicadores_V26.xlsx`.

Os períodos disponíveis vão de **20/08/2025 a 20/11/2026** para a data final da fatura e de **01/08/2025 a 01/11/2026** para a data considerada no cálculo dos indicadores.

## Padrão de filtros

Os endpoints `GET /api/v1/equipes`, `GET /api/v1/indicadores`, `GET /api/v1/contagens`, `GET /api/v1/notas_codigo` e `GET /api/v1/previa_retencao` seguem a seguinte regra:

- `contrato`: parâmetro obrigatório nos endpoints de equipes, indicadores, contagens e prévia de retenção.
- `codigo_equipe`: parâmetro opcional nos endpoints de equipes, indicadores, contagens e prévia de retenção.
- `data_fatura`: parâmetro obrigatório nos endpoints de indicadores e contagens.
- `ciclo_faturamento` e `sigla_sistema`: ao menos um deve ser informado no endpoint de notas por código.

## Endpoint 1: Equipes

`GET /api/v1/equipes`

### Parâmetros

| Parâmetro | Tipo | Obrigatório | Descrição |
|---|---|---|---|
| `contrato` | `varchar` | Sim | Contrato usado para localizar as equipes |
| `codigo_equipe` | `varchar` | Não | Código da equipe para restringir o resultado |

### Resposta

Entrega os dados básicos das equipes a partir do contrato informado e, opcionalmente, do código da equipe:

| Atributo | Descrição |
|---|---|
| `equipe` | Código identificador da equipe |
| `codigo_contrato` | Código do contrato |
| `contrato` | Nome ou descrição do contrato |
| `area` | Área responsável pela equipe |
| `comunidade` | Comunidade ou unidade de negócio |
| `grupo` | Grupo da equipe: `Desenvolvimento` ou `Suporte` |
| `situacao` | Situação encontrada na planilha; pode ser `null` quando não houver registro |
| `data_inicio` | Data inicial do registro, no formato `DD-MM-YYYY`; pode ser `null` |
| `data_fim` | Data efetiva de conclusão do registro, no formato `DD-MM-YYYY`; pode ser `null` |
| `vigencias` | Lista de períodos e perfis associados à equipe, incluindo matrícula, nome, datas, exclusão e turnover |

Exemplo com três equipes: [exemplo_equipes.json](exemplo_equipes.json)

## Endpoint 2: Indicadores

`GET /api/v1/indicadores`

### Parâmetros

| Parâmetro | Tipo | Obrigatório | Descrição |
|---|---|---|---|
| `contrato` | `varchar` | Sim | Contrato usado para localizar as equipes e seus indicadores |
| `codigo_equipe` | `varchar` | Não | Código da equipe para restringir o resultado |
| `data_fatura` | `date` | Sim | Data final da fatura no formato `DD-MM-YYYY`. Deve corresponder ao valor de `DT. FINAL FATURA` |

### Campos comuns

Os registros das abas de indicadores possuem os seguintes campos:

| Atributo | Tipo extraído | Descrição |
|---|---|---|
| `equipe` | texto | Código identificador da equipe |
| `codigo_contrato` | texto | Código do contrato |
| `contrato` | texto | Nome ou descrição do contrato |
| `area` | texto | Área responsável |
| `comunidade` | texto | Comunidade ou unidade de negócio |
| `grupo` | texto | `Desenvolvimento` ou `Suporte` |
| `dt_final_fatura` | data | Data final da fatura |
| `fatura` | texto | Competência da fatura, por exemplo `Novembro/2026` |
| `cod_fatura` | texto/número | Código da fatura |
| `data_considerar_fns` | data | Data usada como referência no cálculo do indicador |
| `indicador` | texto | Sigla do indicador |

## Indicadores de Desenvolvimento

### IE - Desenvolvimento

| Atributo | Tipo | Faixa observada | Descrição |
|---|---|---|---|
| `qt_itens_entregues` | inteiro | 0 a 85 | Quantidade de itens com entregas |
| `qt_itens_contratados` | inteiro | 1 a 86 | Quantidade de itens contratados |
| `valor_indicador` | decimal | 0 a 1 | Valor calculado do indicador IE |
| `valor_indicador_ajustado` | decimal | 0,4 a 1 | Valor ajustado do indicador IE |

Observação: a aba possui 2595 registros. Existem 184 registros sem os campos de itens e valor não ajustado.

### IP - Produtividade - Desenvolvimento

| Atributo | Tipo | Faixa observada | Descrição |
|---|---|---|---|
| `qt_itens_com_contagem` | inteiro | 0 a 83 | Quantidade de itens com contagem |
| `qt_pontos_de_funcao` | decimal | 0 a 628 | Pontos de função considerados |
| `qt_colaboradores` | decimal | 0 a 29,80952380952381 | Quantidade de colaboradores |
| `qt_dias_trabalhados` | inteiro | 0 a 626 | Dias trabalhados no período |
| `qt_defeitos` | inteiro | 0 a 46 | Quantidade de defeitos |
| `qt_dias_trabalhados_defeitos` | inteiro | 0 a 124 | Dias trabalhados associados a defeitos |
| `qt_dias_trabalhados_pf` | inteiro | 0 a 607 | Dias trabalhados associados a pontos de função |
| `dt_inicio_desenvolvimento` | data | 31/08/2023 a 24/08/2026 | Data inicial do desenvolvimento |
| `qt_meses_desenvolvimento` | inteiro | 4 a 19 | Quantidade de meses de desenvolvimento |
| `produtividade_esperada` | decimal | 0,53333 a 1 | Produtividade esperada |
| `valor_indicador` | decimal | 0,3 a 1,27 | Valor calculado do indicador IP |
| `valor_indicador_ajustado` | decimal | 0,3 a 1,27 | Valor ajustado do indicador IP |

### IQ - Desenvolvimento

| Atributo | Tipo | Faixa observada | Descrição |
|---|---|---|---|
| `defeitos_corrigidos_periodo_anterior` | inteiro | 0 a 46 | Defeitos corrigidos no período anterior |
| `defeitos_abertos_periodo_anterior` | inteiro | 0 a 4 | Defeitos ainda abertos no período anterior |
| `defeitos_corrigidos` | inteiro | 0 a 46 | Defeitos corrigidos no período |
| `defeitos_abertos` | inteiro | 0 a 4 | Defeitos abertos no período |
| `razao_iqrd` | decimal | 0 a 3 | Razão usada no cálculo do IQRD |
| `valor_iqrd` | decimal | 0,6 a 1 | Valor calculado do IQRD |
| `peso_iqrd` | decimal | 0,6 | Peso do IQRD |
| `soma_notas` | decimal | 1,3 a 67,4 | Soma das notas consideradas no IQNP |
| `qt_siglas` | inteiro | 0 a 7 | Quantidade de siglas consideradas |
| `nota_media_iqnp` | decimal | 0,8375 a 10 | Nota média do IQNP |
| `valor_iqnp` | decimal | 0 a 1 | Valor calculado do IQNP |
| `peso_iqnp` | decimal | 0,4 | Peso do IQNP |
| `faixa_fns` | decimal | 0 a 1 | Faixa FNS usada no cálculo gravado |
| `valor_indicador` | decimal | 0 a 1 | Valor final do indicador IQ |

Observação: `RAZAO IQRD`, `VALOR IQRD`, `SOMA NOTAS`, `NOTA MEDIA IQNP`, `VALOR IQNP` e `VALOR INDICADOR` podem estar vazios em parte dos registros.

### IT - Desenvolvimento

| Atributo | Tipo | Faixa observada | Descrição |
|---|---|---|---|
| `valor_indicador` | decimal | 0,8549222797927462 a 1 | Valor calculado do indicador IT |
| `faixa_fns` | decimal | 0,93 a 1 | Faixa FNS aplicada ao indicador |
| `dt_inicio_trimestre` | data | 19/06/2025 a 22/07/2026 | Data inicial do trimestre |
| `dt_fim_trimestre` | data | 18/09/2025 a 21/10/2026 | Data final do trimestre |
| `qt_desligamentos_perfis_trimestre_contratada` | inteiro | 0 a 28 | Desligamentos de perfis no trimestre da contratada |
| `perfis_da_contratada_ao_final_do_ultimo_trimestre` | inteiro | 59 a 288 | Perfis da contratada no fim do último trimestre |

### FNS - Desenvolvimento

| Atributo | Tipo | Faixa observada | Descrição |
|---|---|---|---|
| `ie` | decimal | 0,4 a 1 | Valor do indicador IE usado no cálculo |
| `ip` | decimal | 0,3 a 1,27 | Valor do indicador IP usado no cálculo |
| `iq` | decimal | 0 a 1 | Valor do indicador IQ usado no cálculo |
| `it` | decimal | 0,93 a 1 | Valor do indicador IT usado no cálculo |
| `fns_aplicado` | decimal | 0,4075 a 1,0675 | Fator FNS aplicado |

### IDE - Desenvolvimento

| Atributo | Tipo | Faixa observada | Descrição |
|---|---|---|---|
| `ie` | decimal | 0,4 a 1 | Valor do indicador IE usado no cálculo |
| `ie_peso` | decimal | 0,3 | Peso aplicado ao IE |
| `ie_x_peso` | decimal | 0,12 a 0,3 | Resultado de IE multiplicado pelo peso |
| `iq` | decimal | 0 a 1 | Valor do indicador IQ usado no cálculo |
| `iq_peso` | decimal | 0,35 | Peso aplicado ao IQ |
| `iq_x_peso` | decimal | 0 a 0,35 | Resultado de IQ multiplicado pelo peso |
| `ip` | decimal | 0,3 a 1,27 | Valor do indicador IP usado no cálculo |
| `ip_peso` | decimal | 0,35 | Peso aplicado ao IP |
| `ip_x_peso` | decimal | 0,105 a 0,4445 | Resultado de IP multiplicado pelo peso |
| `valor_indicador` | decimal | 0,225 a 1,0945 | Valor final do indicador IDE |

## Indicadores de Suporte

### IE - Suporte

| Atributo | Tipo | Faixa observada | Descrição |
|---|---|---|---|
| `qt_itens_entregues` | inteiro | 0 a 156 | Quantidade de itens com entregas |
| `qt_itens_contratados` | inteiro | 0 a 173 | Quantidade de itens contratados |
| `valor_indicador` | decimal | 0 a 1 | Valor calculado do indicador IE |
| `valor_indicador_ajustado` | decimal | 0,4 a 1 | Valor ajustado do indicador IE |

Observação: a aba possui 1658 registros. Existem 81 registros sem os campos de valor calculado e ajustado.

### IT - Suporte

| Atributo | Tipo | Faixa observada | Descrição |
|---|---|---|---|
| `valor_indicador` | decimal | 0,8549222797927462 a 1 | Valor calculado do indicador IT |
| `faixa_fns` | decimal | 0,93 a 1 | Faixa FNS aplicada ao indicador |
| `dt_inicio_trimestre` | data | 19/06/2025 a 22/07/2026 | Data inicial do trimestre |
| `dt_fim_trimestre` | data | 18/09/2025 a 21/10/2026 | Data final do trimestre |
| `qt_desligamentos_perfis_trimestre_contratada` | inteiro | 0 a 28 | Desligamentos de perfis no trimestre da contratada |
| `perfis_da_contratada_ao_final_do_ultimo_trimestre` | inteiro | 36 a 288 | Perfis da contratada no fim do último trimestre |

### FNS - Suporte

| Atributo | Tipo | Faixa observada | Descrição |
|---|---|---|---|
| `ie` | decimal | 0,4 a 1 | Valor do indicador IE usado no cálculo |
| `it` | decimal | 0,93 a 1 | Valor do indicador IT usado no cálculo |
| `fns_aplicado` | decimal | 0,665 a 1 | Fator FNS aplicado |

## Endpoint 3: Contagens PF

`GET /api/v1/contagens`

### Parâmetros

| Parâmetro | Tipo | Obrigatório | Descrição |
|---|---|---|---|
| `contrato` | `varchar` | Sim | Contrato usado para localizar as contagens |
| `codigo_equipe` | `varchar` | Não | Código da equipe para restringir o resultado |
| `data_fatura` | `date` | Sim | Data final da fatura no formato `DD-MM-YYYY`, usada no filtro das contagens |

### Resposta

A resposta agrupa as contagens por grupo e equipe:

| Atributo | Tipo | Descrição |
|---|---|---|
| `data_consulta` | `timestamp` | Data e hora da consulta no formato `DD-MM-YYYY HH:mm` |
| `codigo_contrato` | `varchar` | Código do contrato associado à consulta |
| `contrato` | `varchar` | Nome ou descrição do contrato associado à consulta |
| `grupos` | `array` | Grupos encontrados na consulta |
| `grupo` | `varchar` | Nome do grupo da equipe, como `Desenvolvimento` ou `Suporte` |
| `equipes` | `array` | Equipes pertencentes ao grupo |
| `equipe` | `varchar` | Código identificador da equipe |
| `codigo_contrato` | `varchar` | Código do contrato da equipe |
| `area` | `varchar` | Área responsável pela equipe |
| `comunidade` | `varchar` | Comunidade ou unidade de negócio da equipe |
| `contagens_pf` | `array` | Lista de contagens de pontos de função da equipe |
| `resultado_da_consulta` | `integer` | Código do resultado: `0` para sucesso ou `1` para erro |

### Atributos de uma contagem PF

| Atributo | Tipo | Descrição |
|---|---|---|
| `co_ciclo_trabalho` | `varchar` | Código do ciclo de trabalho |
| `co_solicitacao` | `varchar` | Código da solicitação |
| `de_tipo_solicitacao` | `varchar` | Tipo da solicitação, como manutenção evolutiva, corretiva ou defeito |
| `de_situacao_solicitacao` | `varchar` | Situação atual da solicitação |
| `nu_tamanho_servico` | `decimal` | Tamanho do serviço em pontos de função |

Exemplo: [exemplo_equipe_contagens.json](exemplo_equipe_contagens.json)

## Endpoint 4: Notas por Código

`GET /api/v1/notas_codigo`

### Parâmetros

| Parâmetro | Tipo | Obrigatório | Descrição |
|---|---|---|---|
| `ciclo_faturamento` | `varchar` | Condicional | Ciclo de faturamento usado no filtro, por exemplo `01/2024`. Deve ser informado caso `sigla_sistema` não seja informado |
| `sigla_sistema` | `varchar` | Condicional | Sigla do sistema usada no filtro. Deve ser informada caso `ciclo_faturamento` não seja informado |

### Regra de filtro

Ao menos um dos dois parâmetros deve ser informado:

- Se somente `ciclo_faturamento` for informado, o endpoint retorna todas as siglas cadastradas para esse ciclo.
- Se somente `sigla_sistema` for informada, o endpoint retorna todas as notas de todos os ciclos cadastrados para essa sigla.
- Se os dois forem informados, o endpoint retorna somente as notas correspondentes ao ciclo e à sigla informados.

### Resposta

| Atributo | Tipo | Descrição |
|---|---|---|
| `data_consulta` | `timestamp` | Data e hora da consulta no formato `DD-MM-YYYY HH:mm` |
| `ciclo_faturamento` | `varchar` | Ciclo de faturamento utilizado na consulta |
| `notas_codigo` | `array` | Lista de notas agrupadas por sigla de sistema |
| `ciclo_faturamento` | `varchar` | Ciclo de faturamento da nota |
| `sigla_sistema` | `varchar` | Sigla do sistema avaliado |
| `nota_apurada` | `decimal` | Nota apurada, em formato brasileiro com mínimo de duas casas decimais |
| `data_modificacao` | `timestamp` | Data da última modificação no formato `DD-MM-YYYY HH:mm:ss,SSS` |
| `resultado_da_consulta` | `integer` | Código do resultado: `0` para sucesso ou `1` para erro |

Exemplo: [exemplo_notas_codigo.json](exemplo_notas_codigo.json)

## Endpoint 5: Prévia de Retenção

`GET /api/v1/previa_retencao`

### Parâmetros

| Parâmetro | Tipo | Obrigatório | Descrição |
|---|---|---|---|
| `contrato` | `varchar` | Sim | Contrato usado para localizar as equipes na prévia de retenção |
| `codigo_equipe` | `varchar` | Não | Código da equipe para restringir o resultado |

### Resposta

A resposta agrupa as equipes por grupo:

| Atributo | Tipo | Descrição |
|---|---|---|
| `data_consulta` | `timestamp` | Data e hora da consulta no formato `DD-MM-YYYY HH:mm` |
| `codigo_contrato` | `varchar` | Código do contrato associado à consulta |
| `contrato` | `varchar` | Nome ou descrição do contrato associado à consulta |
| `grupos` | `array` | Grupos encontrados na consulta |
| `grupo` | `varchar` | Nome do grupo da equipe |
| `equipes` | `array` | Equipes pertencentes ao grupo |
| `codigo_contrato` | `varchar` | Código do contrato da equipe |
| `contrato` | `varchar` | Nome ou descrição do contrato da equipe |
| `area` | `varchar` | Área responsável pela equipe |
| `comunidade` | `varchar` | Comunidade da equipe |
| `equipe` | `varchar` | Código identificador da equipe |
| `data_inicio` | `timestamp` | Data e hora de início no formato `DD-MM-YYYY HH:mm:ss,SSS` |
| `data_fim` | `timestamp` | Data e hora de fim; pode ser `null` |
| `quantidade_atendimentos` | `decimal` | Quantidade de atendimentos; pode ser `null` |
| `sprints_pendentes` | `decimal` | Quantidade de sprints pendentes; pode ser `null` |
| `resultado_da_consulta` | `integer` | Código do resultado: `0` para sucesso ou `1` para erro |

Exemplo: [exemplo_previa_retencao.json](exemplo_previa_retencao.json)

## Exemplos de resposta JSON

Os exemplos completos estão armazenados em arquivos JSON separados:

- [Exemplo do endpoint /api/v1/equipes](exemplo_equipes.json)
- [Exemplo unificado de indicadores](exemplo_equipe_indicadores.json)
- [Exemplo do endpoint /api/v1/contagens](exemplo_equipe_contagens.json)
- [Exemplo do endpoint /api/v1/notas_codigo](exemplo_notas_codigo.json)
- [Exemplo do endpoint /api/v1/previa_retencao](exemplo_previa_retencao.json)

O arquivo completo reúne uma equipe de Desenvolvimento e uma equipe de Suporte. A equipe de Desenvolvimento contém os indicadores IE, IP, IQ, IT e FNS; a equipe de Suporte contém IE, IT e FNS, todos associados à competência de agosto de 2025.

### Atributos de resposta adicionais

Além dos campos específicos de cada indicador, as respostas dos endpoints incluem os seguintes atributos:

| Atributo | Descrição |
|---|---|
| `data_consulta` | Timestamp da consulta no formato `DD-MM-YYYY HH:mm` |
| `grupos` | Lista de grupos; cada grupo contém o nome `grupo` e a lista `equipes` correspondentes |

## Formato dos dados

- Datas: `DD-MM-YYYY`.
- Timestamp de saída: `DD-MM-YYYY HH:mm`.
- Timestamp com milissegundos: `DD-MM-YYYY HH:mm:ss,SSS`.
- Números: representados como texto no padrão brasileiro, com separador decimal de vírgula, mínimo de duas casas decimais e máximo de oito casas decimais.
- Valores nulos continuam representados por `null`.


---

## Fonte: WebServices/wsdl/README.md

# API de Equipes e Indicadores

## Estrutura dos dados

Os dados desta documentação foram extraídos da planilha `SIGCT_Relatorio_Indicadores_V26.xlsx`.

Os períodos disponíveis vão de **20/08/2025 a 20/11/2026** para a data final da fatura e de **01/08/2025 a 01/11/2026** para a data considerada no cálculo dos indicadores.

## Padrão de filtros

Os endpoints `GET /api/v1/equipes`, `GET /api/v1/indicadores`, `GET /api/v1/contagens`, `GET /api/v1/notas_codigo` e `GET /api/v1/previa_retencao` seguem a seguinte regra:

- `contrato`: parâmetro obrigatório nos endpoints de equipes, indicadores, contagens e prévia de retenção.
- `codigo_equipe`: parâmetro opcional nos endpoints de equipes, indicadores, contagens e prévia de retenção.
- `data_fatura`: parâmetro obrigatório nos endpoints de indicadores e contagens.
- `ciclo_faturamento` e `sigla_sistema`: ao menos um deve ser informado no endpoint de notas por código.

## Endpoint 1: Equipes

`GET /api/v1/equipes`

### Parâmetros

| Parâmetro | Tipo | Obrigatório | Descrição |
|---|---|---|---|
| `contrato` | `varchar` | Sim | Contrato usado para localizar as equipes |
| `codigo_equipe` | `varchar` | Não | Código da equipe para restringir o resultado |

### Resposta

Entrega os dados básicos das equipes a partir do contrato informado e, opcionalmente, do código da equipe:

| Atributo | Descrição |
|---|---|
| `equipe` | Código identificador da equipe |
| `codigo_contrato` | Código do contrato |
| `contrato` | Nome ou descrição do contrato |
| `area` | Área responsável pela equipe |
| `comunidade` | Comunidade ou unidade de negócio |
| `grupo` | Grupo da equipe: `Desenvolvimento` ou `Suporte` |
| `situacao` | Situação encontrada na planilha; pode ser `null` quando não houver registro |
| `data_inicio` | Data inicial do registro, no formato `DD-MM-YYYY`; pode ser `null` |
| `data_fim` | Data efetiva de conclusão do registro, no formato `DD-MM-YYYY`; pode ser `null` |
| `vigencias` | Lista de períodos e perfis associados à equipe, incluindo matrícula, nome, datas, exclusão e turnover |

Exemplo com três equipes: [exemplo_equipes.xml](exemplo_equipes.xml)

## Endpoint 2: Indicadores

`GET /api/v1/indicadores`

### Parâmetros

| Parâmetro | Tipo | Obrigatório | Descrição |
|---|---|---|---|
| `contrato` | `varchar` | Sim | Contrato usado para localizar as equipes e seus indicadores |
| `codigo_equipe` | `varchar` | Não | Código da equipe para restringir o resultado |
| `data_fatura` | `date` | Sim | Data final da fatura no formato `DD-MM-YYYY`. Deve corresponder ao valor de `DT. FINAL FATURA` |

### Campos comuns

Os registros das abas de indicadores possuem os seguintes campos:

| Atributo | Tipo extraído | Descrição |
|---|---|---|
| `equipe` | texto | Código identificador da equipe |
| `codigo_contrato` | texto | Código do contrato |
| `contrato` | texto | Nome ou descrição do contrato |
| `area` | texto | Área responsável |
| `comunidade` | texto | Comunidade ou unidade de negócio |
| `grupo` | texto | `Desenvolvimento` ou `Suporte` |
| `dt_final_fatura` | data | Data final da fatura |
| `fatura` | texto | Competência da fatura, por exemplo `Novembro/2026` |
| `cod_fatura` | texto/número | Código da fatura |
| `data_considerar_fns` | data | Data usada como referência no cálculo do indicador |
| `indicador` | texto | Sigla do indicador |

## Indicadores de Desenvolvimento

### IE - Desenvolvimento

| Atributo | Tipo | Faixa observada | Descrição |
|---|---|---|---|
| `qt_itens_entregues` | inteiro | 0 a 85 | Quantidade de itens com entregas |
| `qt_itens_contratados` | inteiro | 1 a 86 | Quantidade de itens contratados |
| `valor_indicador` | decimal | 0 a 1 | Valor calculado do indicador IE |
| `valor_indicador_ajustado` | decimal | 0,4 a 1 | Valor ajustado do indicador IE |

Observação: a aba possui 2595 registros. Existem 184 registros sem os campos de itens e valor não ajustado.

### IP - Produtividade - Desenvolvimento

| Atributo | Tipo | Faixa observada | Descrição |
|---|---|---|---|
| `qt_itens_com_contagem` | inteiro | 0 a 83 | Quantidade de itens com contagem |
| `qt_pontos_de_funcao` | decimal | 0 a 628 | Pontos de função considerados |
| `qt_colaboradores` | decimal | 0 a 29,80952380952381 | Quantidade de colaboradores |
| `qt_dias_trabalhados` | inteiro | 0 a 626 | Dias trabalhados no período |
| `qt_defeitos` | inteiro | 0 a 46 | Quantidade de defeitos |
| `qt_dias_trabalhados_defeitos` | inteiro | 0 a 124 | Dias trabalhados associados a defeitos |
| `qt_dias_trabalhados_pf` | inteiro | 0 a 607 | Dias trabalhados associados a pontos de função |
| `dt_inicio_desenvolvimento` | data | 31/08/2023 a 24/08/2026 | Data inicial do desenvolvimento |
| `qt_meses_desenvolvimento` | inteiro | 4 a 19 | Quantidade de meses de desenvolvimento |
| `produtividade_esperada` | decimal | 0,53333 a 1 | Produtividade esperada |
| `valor_indicador` | decimal | 0,3 a 1,27 | Valor calculado do indicador IP |
| `valor_indicador_ajustado` | decimal | 0,3 a 1,27 | Valor ajustado do indicador IP |

### IQ - Desenvolvimento

| Atributo | Tipo | Faixa observada | Descrição |
|---|---|---|---|
| `defeitos_corrigidos_periodo_anterior` | inteiro | 0 a 46 | Defeitos corrigidos no período anterior |
| `defeitos_abertos_periodo_anterior` | inteiro | 0 a 4 | Defeitos ainda abertos no período anterior |
| `defeitos_corrigidos` | inteiro | 0 a 46 | Defeitos corrigidos no período |
| `defeitos_abertos` | inteiro | 0 a 4 | Defeitos abertos no período |
| `razao_iqrd` | decimal | 0 a 3 | Razão usada no cálculo do IQRD |
| `valor_iqrd` | decimal | 0,6 a 1 | Valor calculado do IQRD |
| `peso_iqrd` | decimal | 0,6 | Peso do IQRD |
| `soma_notas` | decimal | 1,3 a 67,4 | Soma das notas consideradas no IQNP |
| `qt_siglas` | inteiro | 0 a 7 | Quantidade de siglas consideradas |
| `nota_media_iqnp` | decimal | 0,8375 a 10 | Nota média do IQNP |
| `valor_iqnp` | decimal | 0 a 1 | Valor calculado do IQNP |
| `peso_iqnp` | decimal | 0,4 | Peso do IQNP |
| `faixa_fns` | decimal | 0 a 1 | Faixa FNS usada no cálculo gravado |
| `valor_indicador` | decimal | 0 a 1 | Valor final do indicador IQ |

Observação: `RAZAO IQRD`, `VALOR IQRD`, `SOMA NOTAS`, `NOTA MEDIA IQNP`, `VALOR IQNP` e `VALOR INDICADOR` podem estar vazios em parte dos registros.

### IT - Desenvolvimento

| Atributo | Tipo | Faixa observada | Descrição |
|---|---|---|---|
| `valor_indicador` | decimal | 0,8549222797927462 a 1 | Valor calculado do indicador IT |
| `faixa_fns` | decimal | 0,93 a 1 | Faixa FNS aplicada ao indicador |
| `dt_inicio_trimestre` | data | 19/06/2025 a 22/07/2026 | Data inicial do trimestre |
| `dt_fim_trimestre` | data | 18/09/2025 a 21/10/2026 | Data final do trimestre |
| `qt_desligamentos_perfis_trimestre_contratada` | inteiro | 0 a 28 | Desligamentos de perfis no trimestre da contratada |
| `perfis_da_contratada_ao_final_do_ultimo_trimestre` | inteiro | 59 a 288 | Perfis da contratada no fim do último trimestre |

### FNS - Desenvolvimento

| Atributo | Tipo | Faixa observada | Descrição |
|---|---|---|---|
| `ie` | decimal | 0,4 a 1 | Valor do indicador IE usado no cálculo |
| `ip` | decimal | 0,3 a 1,27 | Valor do indicador IP usado no cálculo |
| `iq` | decimal | 0 a 1 | Valor do indicador IQ usado no cálculo |
| `it` | decimal | 0,93 a 1 | Valor do indicador IT usado no cálculo |
| `fns_aplicado` | decimal | 0,4075 a 1,0675 | Fator FNS aplicado |

### IDE - Desenvolvimento

| Atributo | Tipo | Faixa observada | Descrição |
|---|---|---|---|
| `ie` | decimal | 0,4 a 1 | Valor do indicador IE usado no cálculo |
| `ie_peso` | decimal | 0,3 | Peso aplicado ao IE |
| `ie_x_peso` | decimal | 0,12 a 0,3 | Resultado de IE multiplicado pelo peso |
| `iq` | decimal | 0 a 1 | Valor do indicador IQ usado no cálculo |
| `iq_peso` | decimal | 0,35 | Peso aplicado ao IQ |
| `iq_x_peso` | decimal | 0 a 0,35 | Resultado de IQ multiplicado pelo peso |
| `ip` | decimal | 0,3 a 1,27 | Valor do indicador IP usado no cálculo |
| `ip_peso` | decimal | 0,35 | Peso aplicado ao IP |
| `ip_x_peso` | decimal | 0,105 a 0,4445 | Resultado de IP multiplicado pelo peso |
| `valor_indicador` | decimal | 0,225 a 1,0945 | Valor final do indicador IDE |

## Indicadores de Suporte

### IE - Suporte

| Atributo | Tipo | Faixa observada | Descrição |
|---|---|---|---|
| `qt_itens_entregues` | inteiro | 0 a 156 | Quantidade de itens com entregas |
| `qt_itens_contratados` | inteiro | 0 a 173 | Quantidade de itens contratados |
| `valor_indicador` | decimal | 0 a 1 | Valor calculado do indicador IE |
| `valor_indicador_ajustado` | decimal | 0,4 a 1 | Valor ajustado do indicador IE |

Observação: a aba possui 1658 registros. Existem 81 registros sem os campos de valor calculado e ajustado.

### IT - Suporte

| Atributo | Tipo | Faixa observada | Descrição |
|---|---|---|---|
| `valor_indicador` | decimal | 0,8549222797927462 a 1 | Valor calculado do indicador IT |
| `faixa_fns` | decimal | 0,93 a 1 | Faixa FNS aplicada ao indicador |
| `dt_inicio_trimestre` | data | 19/06/2025 a 22/07/2026 | Data inicial do trimestre |
| `dt_fim_trimestre` | data | 18/09/2025 a 21/10/2026 | Data final do trimestre |
| `qt_desligamentos_perfis_trimestre_contratada` | inteiro | 0 a 28 | Desligamentos de perfis no trimestre da contratada |
| `perfis_da_contratada_ao_final_do_ultimo_trimestre` | inteiro | 36 a 288 | Perfis da contratada no fim do último trimestre |

### FNS - Suporte

| Atributo | Tipo | Faixa observada | Descrição |
|---|---|---|---|
| `ie` | decimal | 0,4 a 1 | Valor do indicador IE usado no cálculo |
| `it` | decimal | 0,93 a 1 | Valor do indicador IT usado no cálculo |
| `fns_aplicado` | decimal | 0,665 a 1 | Fator FNS aplicado |

## Endpoint 3: Contagens PF

`GET /api/v1/contagens`

### Parâmetros

| Parâmetro | Tipo | Obrigatório | Descrição |
|---|---|---|---|
| `contrato` | `varchar` | Sim | Contrato usado para localizar as contagens |
| `codigo_equipe` | `varchar` | Não | Código da equipe para restringir o resultado |
| `data_fatura` | `date` | Sim | Data final da fatura no formato `DD-MM-YYYY`, usada no filtro das contagens |

### Resposta

A resposta agrupa as contagens por grupo e equipe:

| Atributo | Tipo | Descrição |
|---|---|---|
| `data_consulta` | `timestamp` | Data e hora da consulta no formato `DD-MM-YYYY HH:mm` |
| `codigo_contrato` | `varchar` | Código do contrato associado à consulta |
| `contrato` | `varchar` | Nome ou descrição do contrato associado à consulta |
| `grupos` | `array` | Grupos encontrados na consulta |
| `grupo` | `varchar` | Nome do grupo da equipe, como `Desenvolvimento` ou `Suporte` |
| `equipes` | `array` | Equipes pertencentes ao grupo |
| `equipe` | `varchar` | Código identificador da equipe |
| `codigo_contrato` | `varchar` | Código do contrato da equipe |
| `area` | `varchar` | Área responsável pela equipe |
| `comunidade` | `varchar` | Comunidade ou unidade de negócio da equipe |
| `contagens_pf` | `array` | Lista de contagens de pontos de função da equipe |
| `resultado_da_consulta` | `integer` | Código do resultado: `0` para sucesso ou `1` para erro |

### Atributos de uma contagem PF

| Atributo | Tipo | Descrição |
|---|---|---|
| `co_ciclo_trabalho` | `varchar` | Código do ciclo de trabalho |
| `co_solicitacao` | `varchar` | Código da solicitação |
| `de_tipo_solicitacao` | `varchar` | Tipo da solicitação, como manutenção evolutiva, corretiva ou defeito |
| `de_situacao_solicitacao` | `varchar` | Situação atual da solicitação |
| `nu_tamanho_servico` | `decimal` | Tamanho do serviço em pontos de função |

Exemplo: [exemplo_equipe_contagens.xml](exemplo_equipe_contagens.xml)

## Endpoint 4: Notas por Código

`GET /api/v1/notas_codigo`

### Parâmetros

| Parâmetro | Tipo | Obrigatório | Descrição |
|---|---|---|---|
| `ciclo_faturamento` | `varchar` | Condicional | Ciclo de faturamento usado no filtro, por exemplo `01/2024`. Deve ser informado caso `sigla_sistema` não seja informado |
| `sigla_sistema` | `varchar` | Condicional | Sigla do sistema usada no filtro. Deve ser informada caso `ciclo_faturamento` não seja informado |

### Regra de filtro

Ao menos um dos dois parâmetros deve ser informado:

- Se somente `ciclo_faturamento` for informado, o endpoint retorna todas as siglas cadastradas para esse ciclo.
- Se somente `sigla_sistema` for informada, o endpoint retorna todas as notas de todos os ciclos cadastrados para essa sigla.
- Se os dois forem informados, o endpoint retorna somente as notas correspondentes ao ciclo e à sigla informados.

### Resposta

| Atributo | Tipo | Descrição |
|---|---|---|
| `data_consulta` | `timestamp` | Data e hora da consulta no formato `DD-MM-YYYY HH:mm` |
| `ciclo_faturamento` | `varchar` | Ciclo de faturamento utilizado na consulta |
| `notas_codigo` | `array` | Lista de notas agrupadas por sigla de sistema |
| `ciclo_faturamento` | `varchar` | Ciclo de faturamento da nota |
| `sigla_sistema` | `varchar` | Sigla do sistema avaliado |
| `nota_apurada` | `decimal` | Nota apurada, em formato brasileiro com mínimo de duas casas decimais |
| `data_modificacao` | `timestamp` | Data da última modificação no formato `DD-MM-YYYY HH:mm:ss,SSS` |
| `resultado_da_consulta` | `integer` | Código do resultado: `0` para sucesso ou `1` para erro |

Exemplo: [exemplo_notas_codigo.xml](exemplo_notas_codigo.xml)

## Endpoint 5: Prévia de Retenção

`GET /api/v1/previa_retencao`

### Parâmetros

| Parâmetro | Tipo | Obrigatório | Descrição |
|---|---|---|---|
| `contrato` | `varchar` | Sim | Contrato usado para localizar as equipes na prévia de retenção |
| `codigo_equipe` | `varchar` | Não | Código da equipe para restringir o resultado |

### Resposta

A resposta agrupa as equipes por grupo:

| Atributo | Tipo | Descrição |
|---|---|---|
| `data_consulta` | `timestamp` | Data e hora da consulta no formato `DD-MM-YYYY HH:mm` |
| `codigo_contrato` | `varchar` | Código do contrato associado à consulta |
| `contrato` | `varchar` | Nome ou descrição do contrato associado à consulta |
| `grupos` | `array` | Grupos encontrados na consulta |
| `grupo` | `varchar` | Nome do grupo da equipe |
| `equipes` | `array` | Equipes pertencentes ao grupo |
| `codigo_contrato` | `varchar` | Código do contrato da equipe |
| `contrato` | `varchar` | Nome ou descrição do contrato da equipe |
| `area` | `varchar` | Área responsável pela equipe |
| `comunidade` | `varchar` | Comunidade da equipe |
| `equipe` | `varchar` | Código identificador da equipe |
| `data_inicio` | `timestamp` | Data e hora de início no formato `DD-MM-YYYY HH:mm:ss,SSS` |
| `data_fim` | `timestamp` | Data e hora de fim; pode ser `null` |
| `quantidade_atendimentos` | `decimal` | Quantidade de atendimentos; pode ser `null` |
| `sprints_pendentes` | `decimal` | Quantidade de sprints pendentes; pode ser `null` |
| `resultado_da_consulta` | `integer` | Código do resultado: `0` para sucesso ou `1` para erro |

Exemplo: [exemplo_previa_retencao.xml](exemplo_previa_retencao.xml)

## Opção SOAP/WSDL

Uma segunda opção de integração está disponível em XML no arquivo [SigctService.wsdl](SigctService.wsdl). Ela expõe os cinco serviços abaixo com SOAP 1.1 e mensagens `document/literal`:

- `consultarEquipes`
- `consultarIndicadores`
- `consultarContagens`
- `consultarNotasCodigo`
- `consultarPreviaRetencao`

O endpoint publicado deverá ser:

```text
/sigct-client/SigctService
```

A descrição do serviço pode ser consultada em:

```text
/sigct-client/SigctService?wsdl
```

Os formatos de data, timestamps, números decimais, valores nulos e os filtros definidos nesta documentação permanecem válidos para a opção SOAP.

## Exemplos de resposta XML

Os exemplos completos estão armazenados em arquivos XML separados:

- [Exemplo do endpoint /api/v1/equipes](exemplo_equipes.xml)
- [Exemplo unificado de indicadores](exemplo_equipe_indicadores.xml)
- [Exemplo do endpoint /api/v1/contagens](exemplo_equipe_contagens.xml)
- [Exemplo do endpoint /api/v1/notas_codigo](exemplo_notas_codigo.xml)
- [Exemplo do endpoint /api/v1/previa_retencao](exemplo_previa_retencao.xml)

O arquivo completo reúne uma equipe de Desenvolvimento e uma equipe de Suporte. A equipe de Desenvolvimento contém os indicadores IE, IP, IQ, IT e FNS; a equipe de Suporte contém IE, IT e FNS, todos associados à competência de agosto de 2025.

### Atributos de resposta adicionais

Além dos campos específicos de cada indicador, as respostas dos endpoints incluem os seguintes atributos:

| Atributo | Descrição |
|---|---|
| `data_consulta` | Timestamp da consulta no formato `DD-MM-YYYY HH:mm` |
| `grupos` | Lista de grupos; cada grupo contém o nome `grupo` e a lista `equipes` correspondentes |

## Formato dos dados

- Datas: `DD-MM-YYYY`.
- Timestamp de saída: `DD-MM-YYYY HH:mm`.
- Timestamp com milissegundos: `DD-MM-YYYY HH:mm:ss,SSS`.
- Números: representados como texto no padrão brasileiro, com separador decimal de vírgula, mínimo de duas casas decimais e máximo de oito casas decimais.
- Valores nulos continuam representados por `null`.


---


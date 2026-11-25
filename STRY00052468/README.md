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



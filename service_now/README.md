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
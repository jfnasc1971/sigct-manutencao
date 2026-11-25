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

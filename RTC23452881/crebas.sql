1. gct.gcttb086_solicitacao_equipe

Incluir a coluna 

nu_membro_rspvel_atendimento

Matrícula da pessoa responsável pelo atendimento
Será preenchido pela Vinculação Automática ou vai pegar do IB ou da Tarefa Ágil *******

2. NOVA TABELA

gct.gcttb289_equipe_produtividade

nu_equipe                 equipe
nu_fatura                 fatura (periodo apurado)
nu_membro                 membro
nu_perfil                 código do perfil
nu_tipo_servico           código do tipo de serviço
qt_atendimentos           quantidade de atendimentos realizados e aceitos
vr_fator_unidade_servico  informado pelo SIPGC??????????????????
vr_produtividade_esperada valor de produtividade esperada (vem da configuração)
qt_dias_trabalhados       Dias de serviço efetivamente prestados (dias trabalhados menos ausências)
qt_dias_faturamento       Dias úteis do período de faturamento mensal
vr_produtividade          apurado pelo cálculo do indicador qt_atendimentos X vr_fator_unidade_servico

gct.gcttb086_solicitacao_equipe
gct.gcttb005_solicitacao

nu_fatura para determinar o periodo de faturamento

para cada membro da equipe,

ACEITOS - solicitações com situacao Aceito e com data efetiva dentro do periodo de faturamento
FATO DE UNIDADE SERVIÇO - fator informado pelo SIPGC

--
--
--
alter table gct.gcttb086_solicitacao_equipe drop column if exists nu_membro_rspvel_atendimento;
alter table gct.gcttb086_solicitacao_equipe add nu_membro_rspvel_atendimento numeric;

--
--
--
-- Table: gct.gcttb086_solicitacao_equipe

DROP TABLE if exists gct.gcttb289_equipe_produtividade;

CREATE TABLE gct.gcttb289_equipe_produtividade
(
  nu_equipe                 numeric(10) NOT NULL, --equipe
  nu_fatura                 numeric NOT NULl, --fatura (periodo apurado)
  nu_membro                 numeric NOT NULl, --membro
  nu_perfil                 numeric NOT NULl, --código do perfil
  nu_tipo_servico           numeric NOT NULl, --código do tipo de serviço
  qt_atendimento            numeric NOT NULl, --quantidade de atendimentos realizados
  qt_atendimento_aceitos    numeric NOT NULl, --quantidade de atendimentos aceitos
  vr_produtividade_esperada numeric NOT NULl, --valor de produtividade esperada (vem da configuração)
  vr_produtividade          numeric NOT NULl, --apurado pelo cálculo do indicador
  CONSTRAINT pk_gcttb289 PRIMARY KEY (nu_equipe, nu_fatura, nu_membro, nu_perfil)
);

ALTER TABLE gct.gcttb289_equipe_produtividade OWNER TO gct;
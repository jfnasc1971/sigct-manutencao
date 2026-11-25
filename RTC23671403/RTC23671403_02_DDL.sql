begin;

--
-- RTC 23671403 - SIGCT - Indicadores do contrato especializado
--

--
-- INICIO
--

--
--
--
DROP INDEX if exists gct.ix_gcttb172_5;
drop index if exists gct.ix_gcttb191_1;
drop index if exists gct.ix_gcttb192_1;
drop index if exists gct.ix_gcttb264_1;
drop index if exists gct.ix_gcttb265_1;
drop index if exists gct.ix_gcttb266_1;
drop index if exists gct.ix_gcttb267_1;
drop index if exists gct.ix_gcttb268_1;
DROP INDEX if exists gct.ix_gcttb170_6;
drop index if exists gct.ix_gcttb186_2;
drop index if exists gct.ix_gcttb186_3;
drop index if exists gct.ix_gcttb401_1;
drop index if exists gct.ix_gcttb402_1;
drop index if exists gct.ix_gcttb264_2;
drop index if exists gct.ix_gcttb265_2;
drop index if exists gct.ix_gcttb266_2;
drop index if exists gct.ix_gcttb267_2;
drop index if exists gct.ix_gcttb268_2;

DROP TABLE if exists gct.gcttb319_hstrco_nota_codigo;
DROP TABLE if exists gct.gcttb283_agendamento_indicador;
DROP TABLE if exists gct.gcttb263_nota_codigo;
DROP TABLE if exists gct.gcttb264_amsta_equipe;
DROP TABLE if exists gct.gcttb265_amsta_solicitacao;
DROP TABLE if exists gct.gcttb266_amsta_slctco_equipe;
DROP TABLE if exists gct.gcttb267_amsta_ciclo_trabalho;
DROP TABLE if exists gct.gcttb268_amsta_membros_equipe;
DROP TABLE if exists gct.gcttb269_valor_indicador_contratada;

DROP SEQUENCE if exists gct.gctsq264_nu_amostra;
DROP SEQUENCE if exists gct.gctsq265_nu_amostra;
DROP SEQUENCE if exists gct.gctsq266_nu_amostra;
DROP SEQUENCE if exists gct.gctsq267_nu_amostra;
DROP SEQUENCE if exists gct.gctsq268_nu_amostra;
DROP SEQUENCE if exists gct.gctsq269_nu_valor_indicador;


alter table gct.gcttb115_grupo_indicador drop column if exists ic_compoe_fns;
alter table gct.gcttb115_grupo_indicador add ic_compoe_fns char(1) not null default 'S';

alter table gct.gcttb087_equipe drop column if exists dt_considerar_fns;
alter table gct.gcttb087_equipe add column dt_considerar_fns date;

alter table gct.gcttb010_contrato drop column if exists dt_considerar_fns;
alter table gct.gcttb010_contrato add column dt_considerar_fns date;

alter table gct.gcttb005_solicitacao drop column if exists dh_inicio_desenvolvimento;
alter table gct.gcttb005_solicitacao add column dh_inicio_desenvolvimento timestamp;

alter table gct.gcttb172_valor_indicador_equipe drop column if exists dt_inicio_indicador; 
alter table gct.gcttb172_valor_indicador_equipe add dt_inicio_indicador date; 

alter table gct.gcttb172_valor_indicador_equipe drop column if exists dt_final_indicador;  
alter table gct.gcttb172_valor_indicador_equipe add dt_final_indicador date; 

--
-- SEQUENCES
--

-- Sequence: gct.gctsq269_nu_valor_indicador

-- DROP SEQUENCE gct.gctsq269_nu_valor_indicador;

CREATE SEQUENCE gct.gctsq269_nu_valor_indicador
  INCREMENT 1
  MINVALUE 1
  START 1000
  CACHE 1;

ALTER TABLE gct.gctsq269_nu_valor_indicador OWNER TO gct;

GRANT USAGE, SELECT, UPDATE ON SEQUENCE gct.gctsq269_nu_valor_indicador TO gct;

-- Sequence: gct.gctsq264_nu_amostra

-- DROP SEQUENCE IF EXISTS gct.gctsq264_nu_amostra;

CREATE SEQUENCE gct.gctsq264_nu_amostra
  INCREMENT 1
  MINVALUE 1
  START 1
  CACHE 1;

ALTER TABLE gct.gctsq264_nu_amostra OWNER TO gct;

GRANT USAGE, SELECT, UPDATE ON SEQUENCE gct.gctsq264_nu_amostra TO gct;

-- Sequence: gct.gctsq265_nu_amostra

-- DROP SEQUENCE IF EXISTS gct.gctsq265_nu_amostra;

CREATE SEQUENCE gct.gctsq265_nu_amostra
  INCREMENT 1
  MINVALUE 1
  START 1
  CACHE 1;

ALTER TABLE gct.gctsq265_nu_amostra OWNER TO gct;

GRANT USAGE, SELECT, UPDATE ON SEQUENCE gct.gctsq265_nu_amostra TO gct;

-- Sequence: gct.gctsq266_nu_amostra

-- DROP SEQUENCE IF EXISTS gct.gctsq266_nu_amostra;

CREATE SEQUENCE gct.gctsq266_nu_amostra
  INCREMENT 1
  MINVALUE 1
  START 1
  CACHE 1;

ALTER TABLE gct.gctsq266_nu_amostra OWNER TO gct;

GRANT USAGE, SELECT, UPDATE ON SEQUENCE gct.gctsq266_nu_amostra TO gct;

-- Sequence: gct.gctsq267_nu_amostra

-- DROP SEQUENCE IF EXISTS gct.gctsq267_nu_amostra;

CREATE SEQUENCE gct.gctsq267_nu_amostra
  INCREMENT 1
  MINVALUE 1
  START 1
  CACHE 1;

ALTER TABLE gct.gctsq267_nu_amostra OWNER TO gct;

GRANT USAGE, SELECT, UPDATE ON SEQUENCE gct.gctsq267_nu_amostra TO gct;

-- Sequence: gct.gctsq268_nu_amostra

-- DROP SEQUENCE IF EXISTS gct.gctsq268_nu_amostra;

CREATE SEQUENCE gct.gctsq268_nu_amostra
  INCREMENT 1
  MINVALUE 1
  START 1
  CACHE 1;

ALTER TABLE gct.gctsq268_nu_amostra OWNER TO gct;

GRANT USAGE, SELECT, UPDATE ON SEQUENCE gct.gctsq268_nu_amostra TO gct;

--
-- TABELAS SINOP
--

-- "sigla": "SIABE",
-- "ciclo": "05/2025",
-- "nota": 10.0

create table gct.gcttb263_nota_codigo(
  no_ciclo_apurado varchar(10)  not null,
  no_sigla_sistema varchar(10)  not null,
  vr_nota_apurada  numeric(6,2) not null,
  ic_situacao_avaliacao char(1),
  de_resultado_avaliacao varchar(1000),
  dh_modificacao   timestamp without time zone not null default current_timestamp,
  constraint pk_gcttb263 primary key(no_sigla_sistema, no_ciclo_apurado)
);

ALTER TABLE gct.gcttb263_nota_codigo OWNER TO gct;

-- Table: gct.gcttb319_hstrco_nota_codigo

-- DROP TABLE gct.gcttb319_hstrco_nota_codigo;

CREATE TABLE gct.gcttb319_hstrco_nota_codigo
(
  no_ciclo_apurado  varchar(10) not null,
  no_sigla_sistema  varchar(10) not null,
  dh_acao_historico timestamp without time zone not null default current_timestamp,
  nu_acao_historico numeric(4,0),
  nu_mtrca_acao_hstro numeric,
  de_campo_alterado text,
  CONSTRAINT pk_gcttb319 PRIMARY KEY (no_ciclo_apurado,no_sigla_sistema,dh_acao_historico)
);

ALTER TABLE gct.gcttb319_hstrco_nota_codigo OWNER TO gct;

--
-- TABELAS DE AMOSTRAS
--

--
-- Name: gcttb264_amsta_equipe; Type: TABLE; Schema: gct; Owner: gct
--

CREATE TABLE gct.gcttb264_amsta_equipe (
    nu_amostra numeric NOT NULL DEFAULT nextval('gct.gctsq264_nu_amostra'::regclass),
    dt_referencia date,
    nu_contrato numeric(6,0),
    nu_equipe numeric(10,0),
    nu_ajuste numeric,
    nu_fatura_ajuste numeric,
    co_equipe character varying(15),
    nu_situacao_equipe numeric(2,0),
    nu_area_interna numeric(5,0),
    nu_tipo_grupo numeric(10,0),
    co_sitio character(2),
    de_equipe character varying(500),
    dt_solicitacao_alocacao timestamp without time zone,
    dt_inicio_atendimento timestamp without time zone,
    dt_final_atendimento timestamp without time zone,
    vr_previsto_calculado numeric(11,2),
    dh_inclusao_informacao timestamp without time zone,
    nu_acao_historico numeric(4,0),
    nu_mtrca_acao_hstro numeric,
    de_justificativa_alteracao character varying(500),
    dh_amostra timestamp with time zone,
    constraint pk_gcttb264 primary key(nu_amostra)
);


ALTER TABLE gct.gcttb264_amsta_equipe OWNER TO gct;

--
-- Name: gcttb265_amsta_solicitacao; Type: TABLE; Schema: gct; Owner: gct
--

CREATE TABLE gct.gcttb265_amsta_solicitacao (
    nu_amostra numeric NOT NULL DEFAULT nextval('gct.gctsq265_nu_amostra'::regclass),
    dt_referencia date,
    nu_contrato numeric(6,0),
    nu_equipe numeric(10,0),
    nu_ajuste numeric,
    nu_fatura_ajuste numeric,    
    nu_solicitacao numeric(10,0),
    nu_unidade_custo numeric(4,0),
    nu_natural_custo numeric(6,0),
    co_solicitacao character varying(15),
    de_solicitacao text,
    de_tipo_solicitacao character varying(500),
    de_tipo_manutencao character varying(500),
    de_pendencia character varying(500),
    de_origem_solicitacao character varying(10),
    de_situacao_solicitacao character varying(500),
    co_siplo character varying(20),
    co_acao_operacional character varying(500),
    no_sigla_sistema character varying(500),
    pc_atendimento_slcto numeric(3,0),
    dh_processamento timestamp without time zone,
    no_solicitacao character varying(1000),
    de_versao_planejada character varying(200),
    nu_quatidade_incluida character varying(20),
    nu_quatidade_alterada character varying(20),
    nu_quatidade_excluida character varying(20),
    nu_sistema_intgo numeric(3,0),
    no_item_portfolio character varying(500),
    de_modulo character varying(500),
    dh_inicio timestamp without time zone,
    dh_prevista timestamp without time zone,
    dh_efetiva timestamp without time zone,
    de_situacao_solicitacao_gct character varying(50),
    co_solicitacao_pai character varying(50),
    dh_cadastro timestamp without time zone,
    dh_resolucao timestamp without time zone,
    dh_modificacao timestamp without time zone,
    nu_situacao_solicitacao numeric,
    dh_acionamento timestamp without time zone,
    de_equipe_responsavel character varying(300),
    nu_acao_historico numeric(4,0),
    nu_mtrca_acao_hstro numeric,
    de_justificativa_alteracao character varying(500),
    nu_execucao numeric,
    nu_mtrca_alteracao_custo numeric,
    dh_alteracao_custo timestamp without time zone,
    co_solicitacao_custo character varying(30),
    ic_acesso_restrito character(1),
    no_tipo_solicitacao character varying(200),
    de_tipo_desenvolvimento character varying(200),
    no_planejado_para character varying(150),
    no_area_projeto character varying(150),
    qt_erro numeric(3,0),
    no_squad character varying(150),
    ic_pendente_atualizacao character(1),
    qt_pontos_historia numeric(2,0),
    nu_item_portfolio numeric(10,0),
    co_matrca_responsavel character varying(10),
    nu_modulo numeric(9,0),
    nu_solicitacao_pai numeric,
    co_area_projeto character varying(100),
    nu_tipo_situacao_vinculacao numeric(1,0),
    no_tipo_grupo character varying(50),
    no_tipo_servico character varying(50),
    co_rubrica character varying(20),
    ic_bef character(1),
    no_modulo character varying(100),
    nu_rubrica numeric(5,0),
    sg_unidade_custo character varying(50),
    co_solicitacao_bef character varying(15),
    dh_avaliacao_bef timestamp without time zone,
    dh_amostra timestamp with time zone,
    constraint pk_gcttb265 primary key(nu_amostra)
);


ALTER TABLE gct.gcttb265_amsta_solicitacao OWNER TO gct;

--
-- Name: gcttb266_amsta_slctco_equipe; Type: TABLE; Schema: gct; Owner: postgres
--

CREATE TABLE gct.gcttb266_amsta_slctco_equipe (
    nu_amostra numeric NOT NULL DEFAULT nextval('gct.gctsq266_nu_amostra'::regclass),
    dt_referencia date,
    nu_contrato numeric(6,0),
    nu_equipe numeric(10,0),    
    nu_ajuste numeric,
    nu_fatura_ajuste numeric,    
    nu_solicitacao_equipe numeric(10,0),
    nu_ciclo_trabalho numeric(10,0),
    nu_solicitacao numeric(10,0),
    nu_tipo_servico numeric(10,0),
    nu_tamanho_servico numeric(14,2),
    nu_demanda numeric(10,0),
    ic_solicitacao_compoe_fns character(1),
    co_falha_solicitacao bpchar,
    vr_questionario_avaliacao numeric(6,3),
    vr_nota_qualidade_produto numeric(6,3),
    vr_total_apurado_avaliacao numeric(6,3),
    nu_mtrca_avaliacao_equipe numeric(6,0),
    dh_avaliacao_solicitacao timestamp without time zone,
    nu_rubrica numeric,
    nu_fatura_previa numeric,
    nu_comunidade numeric(3,0),
    co_rubrica character varying(20),
    no_comunidade character varying(100),
    co_forma_vinculacao character(1),
    de_justificativa_alteracao character varying(500),
    de_justificativa_falha character varying(500),
    nu_acao_historico numeric(4,0),
    nu_execucao numeric,
    nu_mtrca_acao_hstro numeric,
    nu_mtrca_avaliacao_solicitacao numeric(6,0),
    nu_ordem_servico numeric(10,0),
    no_tipo_servico character varying(50),
    ic_bef character(1),
    ic_bef_pode_ajustar_rubrica character(1),
    dh_amostra timestamp with time zone,
    constraint pk_gcttb266 primary key(nu_amostra)
);

ALTER TABLE gct.gcttb266_amsta_slctco_equipe OWNER TO gct;

--
-- Name: gcttb267_amsta_ciclo_trabalho; Type: TABLE; Schema: gct; Owner: gct
--

CREATE TABLE gct.gcttb267_amsta_ciclo_trabalho (
    nu_amostra numeric NOT NULL DEFAULT nextval('gct.gctsq267_nu_amostra'::regclass),
    dt_referencia date,
    nu_contrato numeric(6,0),
    nu_equipe numeric(10,0),
    nu_ajuste numeric,
    nu_fatura_ajuste numeric, 
    nu_ciclo_trabalho numeric(10,0),
    nu_situacao_ciclo_trabalho numeric(2,0),
    de_ciclo_trabalho character varying(500),
    dt_inicio_ciclo_trabalho timestamp without time zone,
    dt_alvo_ciclo_trabalho timestamp without time zone,
    dt_final_ciclo_trabalho timestamp without time zone,
    co_falha_ciclo_trabalho character(2),
    nu_acao_historico numeric(4,0),
    nu_mtrca_acao_hstro numeric,
    vr_questionario_avaliacao numeric(6,3),
    vr_nota_qualidade_produto numeric(6,3),
    vr_total_apurado_avaliacao numeric(6,3),
    nu_mtrca_avaliacao_equipe numeric(6,0),
    de_justificativa_falha character varying(500),
    de_justificativa_alteracao character varying(500),
    nu_mtrca_fechamento_equipe numeric(6,0),
    dt_fechamento_ciclo_trabalho timestamp without time zone,
    de_justificativa_fechamento character varying(500),
    de_justificativa_cancelar_fechamento character varying(500),
    ic_nao_se_aplica character(1),
    dh_amostra timestamp with time zone,
    constraint pk_gcttb267 primary key(nu_amostra)
);


ALTER TABLE gct.gcttb267_amsta_ciclo_trabalho OWNER TO gct;

-- Table: gct.gcttb268_amsta_membros_equipe

-- DROP TABLE if exists gct.gcttb268_amsta_membros_equipe;

CREATE TABLE gct.gcttb268_amsta_membros_equipe (
    nu_amostra numeric NOT NULL DEFAULT nextval('gct.gctsq268_nu_amostra'::regclass),
    dt_referencia date,
    nu_contrato numeric(6),
    nu_equipe numeric(10,0),
    nu_fatura_ajuste numeric,
    nu_ajuste numeric, 
    nu_vigencia_membro numeric(10,0),
    nu_membro numeric,
    nu_perfil numeric(6,0),
    dt_inicio_membro date,
    dt_fim_membro date,
    nu_posicao_membro numeric,
    pc_alocacao_membro numeric(3,2),
    dh_amostra timestamp with time zone NOT NULL,
    constraint pk_gcttb268 primary key(nu_amostra)
);


ALTER TABLE gct.gcttb268_amsta_membros_equipe OWNER TO gct;

-- Table: gct.gcttb269_valor_indicador_contratada

-- DROP TABLE if exists gct.gcttb269_valor_indicador_contratada;

CREATE TABLE gct.gcttb269_valor_indicador_contratada (
  nu_valor_indicador numeric NOT NULL DEFAULT nextval('gct.gctsq269_nu_valor_indicador'::regclass),
  nu_contrato numeric(6,0),
  nu_tipo_indicador numeric(3,0),
  dt_inicio_indicador date,
  dt_final_indicador date,
  vr_calculo_indicador numeric,
  vr_faixa_fns numeric,
  dh_geracao_indicador timestamp without time zone,
  CONSTRAINT pk_gcttb269 PRIMARY KEY (nu_valor_indicador),
  CONSTRAINT fk_gcttb269_gcttb010_1 FOREIGN KEY (nu_contrato)
      REFERENCES gct.gcttb010_contrato (nu_contrato) MATCH SIMPLE
      ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT fk_gcttb269_gcttb112_1 FOREIGN KEY (nu_tipo_indicador)
      REFERENCES gct.gcttb112_tipo_indicador (nu_tipo_indicador) MATCH SIMPLE
      ON UPDATE RESTRICT ON DELETE RESTRICT
);

ALTER TABLE gct.gcttb269_valor_indicador_contratada OWNER TO gct;

-- Table: gct.gcttb283_agendamento_indicador

-- DROP TABLE if exists gct.gcttb283_agendamento_indicador;

CREATE TABLE gct.gcttb283_agendamento_indicador (
  nu_contrato numeric(6) not null,
  nu_tipo_indicador numeric(3) not null,
  dt_inicio date not null,
  dt_final date not null,
  dt_execucao_prevista date not null,
  ic_executado char(1) default 'n',
  dt_execucao date,
  CONSTRAINT pk_gcttb283 PRIMARY KEY (nu_contrato, nu_tipo_indicador, dt_inicio)
);

ALTER TABLE gct.gcttb283_agendamento_indicador OWNER TO gct;

--
-- INDICES
--

-- Index: gct.ix_gcttb264_1
-- DROP INDEX if exists gct.ix_gcttb264_1;
create index ix_gcttb264_1 on gct.gcttb264_amsta_equipe USING btree (dt_referencia, nu_contrato, nu_equipe);

-- Index: gct.ix_gcttb265_1
-- DROP INDEX if exists gct.ix_gcttb265_1;
create index ix_gcttb265_1 on gct.gcttb265_amsta_solicitacao USING btree (dt_referencia, nu_contrato, nu_equipe);

-- Index: gct.ix_gcttb266_1
-- DROP INDEX if exists gct.ix_gcttb266_1;
create index ix_gcttb266_1 on gct.gcttb266_amsta_slctco_equipe USING btree (dt_referencia, nu_contrato, nu_equipe);

-- Index: gct.ix_gcttb267_1
-- DROP INDEX if exists gct.ix_gcttb267_1;
create index ix_gcttb267_1 on gct.gcttb267_amsta_ciclo_trabalho USING btree (dt_referencia, nu_contrato, nu_equipe);

-- Index: gct.ix_gcttb268_1
-- DROP INDEX if exists gct.ix_gcttb268_1;
create index ix_gcttb268_1 on gct.gcttb268_amsta_membros_equipe USING btree (dt_referencia, nu_contrato, nu_equipe);

-- Index: gct.ix_gcttb170_6
-- DROP INDEX if exists gct.ix_gcttb170_6;
CREATE INDEX ix_gcttb170_6 ON gct.gcttb170_termo_equipe USING btree (nu_tipo_termo, nu_situacao_termo, nu_equipe);

-- Index: gct.ix_gcttb269_1
-- DROP INDEX gct.ix_gcttb269_1;
CREATE INDEX ix_gcttb269_1 ON gct.gcttb269_valor_indicador_contratada USING btree (
  nu_contrato,
  nu_tipo_indicador,
  dt_inicio_indicador
);

-- Index: gct.ix_gcttb191_1
-- drop index if exists gct.ix_gcttb191_1;
create index ix_gcttb191_1 on gct.gcttb191_servico_entregue using btree (
  nu_situacao_atendimento,
  nu_contrato,
  nu_tipo_grupo,
  nu_tipo_indicador
);

-- Index: gct.ix_gcttb192_1
-- drop index if exists gct.ix_gcttb192_1;
create index ix_gcttb192_1 on gct.gcttb192_servico_contratado using btree (
  nu_situacao_atendimento,
  nu_contrato,
  nu_tipo_grupo,
  nu_tipo_indicador
);

-- Index: gct.ix_gcttb172_5
-- drop index if exists gct.ix_gcttb172_5;
CREATE INDEX ix_gcttb172_5 ON gct.gcttb172_valor_indicador_equipe USING btree (
  nu_contrato,
  nu_tipo_grupo,
  nu_tipo_indicador,
  dt_inicio_indicador,
  dt_final_indicador
);

-- Index: gct.ix_gcttb186_2
-- drop index if exists gct.ix_gcttb186_2;
CREATE INDEX ix_gcttb186_2 ON gct.gcttb186_termo_ajuste_equipe(nu_termo_equipe_original);

-- Index: gct.ix_gcttb186_3
-- drop index if exists gct.ix_gcttb186_3;
CREATE INDEX ix_gcttb186_3 ON gct.gcttb186_termo_ajuste_equipe(nu_termo_ajuste_gerado);

-- Index: gct.ix_gcttb401_1
-- drop index if exists gct.ix_gcttb401_1;
CREATE INDEX ix_gcttb401_1 ON gct.gcttb401_amsta_termo_ordm_pgmno_equipe(nu_termo_equipe);

-- Index: gct.ix_gcttb402_1
-- drop index if exists gct.ix_gcttb402_1;
CREATE INDEX ix_gcttb402_1 ON gct.gcttb402_ordm_pgmno_ajuste(nu_termo_equipe);

-- Index: gct.ix_gcttb264_2
-- drop index if exists gct.ix_gcttb264_2;
create index ix_gcttb264_2 on gct.gcttb264_amsta_equipe         (nu_ajuste, nu_contrato, nu_equipe);

-- Index: gct.ix_gcttb265_2
-- drop index if exists gct.ix_gcttb265_2;
create index ix_gcttb265_2 on gct.gcttb265_amsta_solicitacao    (nu_ajuste, nu_contrato, nu_equipe);

-- Index: gct.ix_gcttb266_2
-- drop index if exists gct.ix_gcttb266_2;
create index ix_gcttb266_2 on gct.gcttb266_amsta_slctco_equipe  (nu_ajuste, nu_contrato, nu_equipe); 

-- Index: gct.ix_gcttb267_2
-- drop index if exists gct.ix_gcttb267_2;
create index ix_gcttb267_2 on gct.gcttb267_amsta_ciclo_trabalho (nu_ajuste, nu_contrato, nu_equipe);  

-- Index: gct.ix_gcttb268_2
-- drop index if exists gct.ix_gcttb268_2;
create index ix_gcttb268_2 on gct.gcttb268_amsta_membros_equipe (nu_ajuste, nu_contrato, nu_equipe);  

analyze gct.gcttb186_termo_ajuste_equipe;
analyze gct.gcttb402_ordm_pgmno_ajuste;
analyze gct.gcttb172_valor_indicador_equipe;
ANALYZE gct.gcttb170_termo_equipe;
ANALYZE gct.gcttb319_hstrco_nota_codigo;
ANALYZE gct.gcttb263_nota_codigo;
ANALYZE gct.gcttb264_amsta_equipe;
ANALYZE gct.gcttb265_amsta_solicitacao;
ANALYZE gct.gcttb266_amsta_slctco_equipe;
ANALYZE gct.gcttb267_amsta_ciclo_trabalho;
ANALYZE gct.gcttb268_amsta_membros_equipe;
ANALYZE gct.gcttb269_valor_indicador_contratada;
ANALYZE gct.gcttb191_servico_entregue;
ANALYZE gct.gcttb192_servico_contratado;

--
-- FIM
--

commit;

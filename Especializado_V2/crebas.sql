-- Table: gct.gcttb178_amostra_solicitacao

-- DROP TABLE gct.gcttb178_amostra_solicitacao;

CREATE TABLE gct.gcttb178_amostra_solicitacao
(
  nu_amostra numeric(20,0) NOT NULL DEFAULT nextval('gct.gctsq178_nu_amostra'::regclass),
  nu_fatura_amostra numeric,
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
  ic_tipo_contratacao character(1),
  de_equipe_responsavel character varying(300),
  nu_ajuste numeric(10,0),
  nu_fatura_ajuste numeric(10,0),
  nu_fatura_previa numeric(10,0),
  co_area_projeto character varying(100),
  co_matrca_responsavel character varying(10),
  co_rubrica character varying(20),
  co_solicitacao_custo character varying(30),
  de_justificativa_alteracao character varying(500),
  de_tipo_desenvolvimento character varying(200),
  dh_alteracao_custo timestamp without time zone,
  ic_acesso_restrito character varying(1),
  ic_bef character(1) DEFAULT 'N'::bpchar,
  ic_pendente_atualizacao character varying(1),
  no_area_projeto character varying(150),
  no_modulo character varying(100),
  no_planejado_para character varying(150),
  no_squad character varying(150),
  no_tipo_grupo character varying(50),
  no_tipo_servico character varying(50),
  no_tipo_solicitacao character varying(200),
  nu_acao_historico numeric(4,0),
  nu_execucao numeric,
  nu_item_portfolio numeric(10,0),
  nu_modulo numeric(9,0),
  nu_mtrca_acao_hstro numeric,
  nu_mtrca_alteracao_custo numeric,
  nu_rubrica numeric(4,0),
  nu_solicitacao_pai numeric,
  nu_tipo_situacao_vinculacao numeric(1,0),
  qt_erro numeric(3,0),
  qt_pontos_historia numeric(2,0),
  sg_unidade_custo character varying(50),
  CONSTRAINT pk_gctb178 PRIMARY KEY (nu_amostra),
  CONSTRAINT fk_gcttb178_gcttb102_1 FOREIGN KEY (nu_fatura_previa)
      REFERENCES gct.gcttb102_fatura (nu_fatura) MATCH SIMPLE
      ON UPDATE RESTRICT ON DELETE RESTRICT
)
WITH (
  OIDS=FALSE
);
ALTER TABLE gct.gcttb178_amostra_solicitacao
  OWNER TO gct;

-- Index: gct.idx_gcttb178_1

-- DROP INDEX gct.idx_gcttb178_1;

CREATE UNIQUE INDEX idx_gcttb178_1
  ON gct.gcttb178_amostra_solicitacao
  USING btree
  (nu_fatura_amostra, nu_solicitacao, (COALESCE(nu_ajuste, 0::numeric)));

-- Index: gct.idx_gcttb178_2

-- DROP INDEX gct.idx_gcttb178_2;

CREATE INDEX idx_gcttb178_2
  ON gct.gcttb178_amostra_solicitacao
  USING btree
  (nu_solicitacao, (COALESCE(nu_ajuste, 0::numeric)));

-- Index: gct.idx_gcttb178_9

-- DROP INDEX gct.idx_gcttb178_9;

CREATE INDEX idx_gcttb178_9
  ON gct.gcttb178_amostra_solicitacao
  USING btree
  (nu_ajuste);


-- Table: gct.gcttb177_amostra_solicitacao_equipe

-- DROP TABLE gct.gcttb177_amostra_solicitacao_equipe;

CREATE TABLE gct.gcttb177_amostra_solicitacao_equipe
(
  nu_amostra numeric(20,0) NOT NULL DEFAULT nextval('gct.gctsq177_nu_amostra'::regclass),
  nu_fatura_amostra numeric,
  nu_solicitacao_equipe numeric(10,0),
  nu_equipe numeric(10,0),
  nu_ciclo_trabalho numeric(10,0),
  nu_solicitacao numeric(10,0),
  nu_tipo_servico numeric(10,0),
  nu_tamanho_servico numeric(14,2),
  nu_demanda numeric(10,0),
  ic_solicitacao_compoe_fns character(1),
  co_falha_solicitacao character(2),
  vr_questionario_avaliacao numeric(6,3),
  vr_nota_qualidade_produto numeric(6,3),
  vr_total_apurado_avaliacao numeric(6,3),
  nu_mtrca_avaliacao_equipe numeric(6,0),
  dh_avaliacao_solicitacao timestamp without time zone,
  nu_ajuste numeric(10,0),
  nu_fatura_ajuste numeric(10,0),
  nu_rubrica numeric,
  nu_fatura_previa numeric(10,0),
  nu_comunidade numeric(3,0),
  co_forma_vinculacao character varying(1),
  de_justificativa_alteracao character varying(500),
  de_justificativa_falha character varying(500),
  no_comunidade character varying(100),
  nu_acao_historico numeric(4,0),
  nu_execucao numeric,
  nu_mtrca_acao_hstro numeric,
  nu_mtrca_avaliacao_solicitacao numeric(6,0),
  nu_ordem_servico numeric(10,0),
  no_tipo_servico character varying(50),
  co_rubrica character varying(20),
  ic_bef character(1),
  ic_bef_pode_ajustar_rubrica character(1),
  CONSTRAINT pk_gctb177 PRIMARY KEY (nu_amostra),
  CONSTRAINT fk_gcttb177_gcttb102_1 FOREIGN KEY (nu_fatura_previa)
      REFERENCES gct.gcttb102_fatura (nu_fatura) MATCH SIMPLE
      ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT fk_gcttb177_reference_gcttb405 FOREIGN KEY (nu_comunidade)
      REFERENCES gct.gcttb405_comunidade (nu_comunidade) MATCH SIMPLE
      ON UPDATE RESTRICT ON DELETE RESTRICT
)
WITH (
  OIDS=FALSE
);
ALTER TABLE gct.gcttb177_amostra_solicitacao_equipe
  OWNER TO gct;

-- Index: gct.idx_gcttb177_1

-- DROP INDEX gct.idx_gcttb177_1;

CREATE UNIQUE INDEX idx_gcttb177_1
  ON gct.gcttb177_amostra_solicitacao_equipe
  USING btree
  (nu_amostra, nu_fatura_amostra, nu_solicitacao_equipe, (COALESCE(nu_ajuste, 0::numeric)));

-- Index: gct.idx_gcttb177_2

-- DROP INDEX gct.idx_gcttb177_2;

CREATE INDEX idx_gcttb177_2
  ON gct.gcttb177_amostra_solicitacao_equipe
  USING btree
  (nu_ajuste, nu_equipe);

-- Index: gct.idx_gcttb177_3

-- DROP INDEX gct.idx_gcttb177_3;

CREATE INDEX idx_gcttb177_3
  ON gct.gcttb177_amostra_solicitacao_equipe
  USING btree
  (nu_fatura_amostra, nu_equipe);

-- Index: gct.idx_gcttb177_4

-- DROP INDEX gct.idx_gcttb177_4;

CREATE INDEX idx_gcttb177_4
  ON gct.gcttb177_amostra_solicitacao_equipe
  USING btree
  (nu_fatura_amostra, nu_solicitacao_equipe);


-- Table: gct.gcttb172_valor_indicador_equipe

-- DROP TABLE gct.gcttb172_valor_indicador_equipe;

CREATE TABLE gct.gcttb172_valor_indicador_equipe
(
  nu_valor_indicador numeric(20,0) NOT NULL DEFAULT nextval('gct.gctsq172_nu_valor_indicador'::regclass),
  nu_fatura numeric,
  nu_equipe numeric,
  nu_tipo_grupo numeric(10,0),
  nu_contrato numeric(6,0),
  nu_tipo_indicador numeric(3,0),
  dh_geracao_indicador_equipe timestamp without time zone,
  vr_calculo_indicador numeric,
  dt_referencia date,
  vr_peso_tipo_indicador numeric,
  vr_faixa_fns numeric,
  nu_ajuste numeric(10,0),
  nu_fatura_ajuste numeric,
  ic_previa character(1) NOT NULL DEFAULT 'N'::bpchar,
  nu_fatura_previa numeric(10,0),
  CONSTRAINT pk_gctb172 PRIMARY KEY (nu_valor_indicador),
  CONSTRAINT fk_gcttb172_gcttb102_1 FOREIGN KEY (nu_fatura_previa)
      REFERENCES gct.gcttb102_fatura (nu_fatura) MATCH SIMPLE
      ON UPDATE RESTRICT ON DELETE RESTRICT
)
WITH (
  OIDS=FALSE
);
ALTER TABLE gct.gcttb172_valor_indicador_equipe
  OWNER TO gct;

-- Index: gct.ix_gcttb172_1

-- DROP INDEX gct.ix_gcttb172_1;

CREATE INDEX ix_gcttb172_1
  ON gct.gcttb172_valor_indicador_equipe
  USING btree
  (dt_referencia, nu_tipo_grupo, nu_equipe, nu_tipo_indicador);

-- Index: gct.ix_gcttb172_2

-- DROP INDEX gct.ix_gcttb172_2;

CREATE UNIQUE INDEX ix_gcttb172_2
  ON gct.gcttb172_valor_indicador_equipe
  USING btree
  (nu_fatura, nu_equipe, nu_tipo_grupo, nu_contrato, nu_tipo_indicador, (COALESCE(nu_ajuste, 0::numeric)));

-- Index: gct.ix_gcttb172_3

-- DROP INDEX gct.ix_gcttb172_3;

CREATE INDEX ix_gcttb172_3
  ON gct.gcttb172_valor_indicador_equipe
  USING btree
  (dt_referencia, nu_equipe, nu_tipo_indicador);

-- Index: gct.ix_gcttb172_4

-- DROP INDEX gct.ix_gcttb172_4;

CREATE INDEX ix_gcttb172_4
  ON gct.gcttb172_valor_indicador_equipe
  USING btree
  (nu_ajuste);


-- Table: gct.gcttb182_amostra_pendencia_solicitacao

-- DROP TABLE gct.gcttb182_amostra_pendencia_solicitacao;

CREATE TABLE gct.gcttb182_amostra_pendencia_solicitacao
(
  nu_amostra numeric(20,0) NOT NULL DEFAULT nextval('gct.gctsq182_nu_amostra'::regclass),
  nu_fatura_amostra numeric,
  nu_pendencia_solicitacao numeric,
  nu_solicitacao numeric(10,0),
  dh_inicio_pendencia timestamp without time zone,
  dh_fim_pendencia timestamp without time zone,
  qt_intervalo numeric,
  nu_fatura numeric(10,0),
  nu_acao_historico numeric(4,0),
  nu_mtrca_acao_hstro numeric,
  nu_ajuste numeric(10,0),
  nu_fatura_ajuste numeric(10,0),
  nu_fatura_previa numeric(10,0),
  CONSTRAINT pk_gctb182 PRIMARY KEY (nu_amostra),
  CONSTRAINT fk_gcttb182_gcttb102_1 FOREIGN KEY (nu_fatura_previa)
      REFERENCES gct.gcttb102_fatura (nu_fatura) MATCH SIMPLE
      ON UPDATE RESTRICT ON DELETE RESTRICT
)
WITH (
  OIDS=FALSE
);
ALTER TABLE gct.gcttb182_amostra_pendencia_solicitacao
  OWNER TO gct;

-- Index: gct.idx_gcttb182_1

-- DROP INDEX gct.idx_gcttb182_1;

CREATE UNIQUE INDEX idx_gcttb182_1
  ON gct.gcttb182_amostra_pendencia_solicitacao
  USING btree
  (nu_fatura_amostra, nu_pendencia_solicitacao, (COALESCE(nu_ajuste, 0::numeric)));

-- Index: gct.idx_gcttb182_9

-- DROP INDEX gct.idx_gcttb182_9;

CREATE INDEX idx_gcttb182_9
  ON gct.gcttb182_amostra_pendencia_solicitacao
  USING btree
  (nu_ajuste);


-- View: gct.gctvw047_amostra_ciclos_trabalho_empenho

-- DROP VIEW gct.gctvw047_amostra_ciclos_trabalho_empenho;

CREATE OR REPLACE VIEW gct.gctvw047_amostra_ciclos_trabalho_empenho AS 
 SELECT ae.nu_contrato, ae.nu_tipo_grupo, ae.nu_equipe, ae.nu_area_interna, ct.nu_ciclo_trabalho, ct.nu_situacao_ciclo_trabalho, ct.dt_inicio_ciclo_trabalho, ct.dt_alvo_ciclo_trabalho, f.nu_fatura, f.dt_inicio_fatura, f.dt_final_fatura, gct.gctfn305_dias_entre_data(f.dt_inicio_fatura::timestamp without time zone, f.dt_final_fatura::timestamp without time zone, f.co_sitio, gc.ic_dias_calculo_pagamento) AS qt_dias_fat, gct.gctfn305_dias_entre_data(
        CASE
            WHEN ct.dt_inicio_ciclo_trabalho::date < f.dt_inicio_fatura THEN f.dt_inicio_fatura
            ELSE ct.dt_inicio_ciclo_trabalho::date
        END::timestamp without time zone, 
        CASE
            WHEN ct.dt_alvo_ciclo_trabalho::date > f.dt_final_fatura THEN f.dt_final_fatura
            ELSE ct.dt_alvo_ciclo_trabalho::date
        END::timestamp without time zone, f.co_sitio, gc.ic_dias_calculo_pagamento) AS qt_dias_ciclo, ase.nu_solicitacao, ase.nu_tamanho_servico, ase.nu_tipo_servico, ase.ic_solicitacao_compoe_fns
   FROM gct.gcttb177_amostra_solicitacao_equipe ase
   JOIN gct.gcttb102_fatura f ON f.nu_fatura = ase.nu_fatura_amostra
   JOIN gct.gcttb176_amostra_ciclo_trabalho ct ON ct.nu_ciclo_trabalho = ase.nu_ciclo_trabalho AND ct.nu_equipe = ase.nu_equipe AND ct.nu_fatura_amostra = ase.nu_fatura_amostra
   JOIN gct.gcttb175_amostra_equipe ae ON ae.nu_equipe = ase.nu_equipe AND ae.nu_fatura_amostra = ase.nu_fatura_amostra
   JOIN gct.gcttb033_grupo_contrato gc ON gc.nu_contrato = ae.nu_contrato AND gc.nu_tipo_grupo = ae.nu_tipo_grupo
   JOIN gct.gcttb178_amostra_solicitacao s ON s.nu_solicitacao = ase.nu_solicitacao AND s.nu_fatura_amostra = ase.nu_fatura_amostra
   JOIN gct.gcttb001_area_interna ai ON ai.nu_area_interna = ae.nu_area_interna
  WHERE ct.dt_inicio_ciclo_trabalho::date >= f.dt_inicio_fatura AND ct.dt_inicio_ciclo_trabalho::date <= f.dt_final_fatura OR ct.dt_alvo_ciclo_trabalho::date >= f.dt_inicio_fatura AND ct.dt_alvo_ciclo_trabalho::date <= f.dt_final_fatura;

ALTER TABLE gct.gctvw047_amostra_ciclos_trabalho_empenho
  OWNER TO gct;

-- Table: gct.gcttb306_hstro_termo

-- DROP TABLE gct.gcttb306_hstro_termo;

CREATE TABLE gct.gcttb306_hstro_termo
(
  nu_historico numeric(11,0) NOT NULL,
  nu_acao_historico numeric(4,0),
  nu_mtrca_acao_hstro numeric,
  dh_acao_historico timestamp without time zone,
  de_campo_alterado text,
  nu_entrega numeric(10,0),
  nu_ordem_servico numeric(10,0),
  nu_demanda numeric(10,0),
  nu_termo numeric NOT NULL,
  CONSTRAINT pk_gcttb306 PRIMARY KEY (nu_historico)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE gct.gcttb306_hstro_termo
  OWNER TO postgres;

-- Index: gct.ix_gcttb306_1

-- DROP INDEX gct.ix_gcttb306_1;

CREATE INDEX ix_gcttb306_1
  ON gct.gcttb306_hstro_termo
  USING btree
  (nu_mtrca_acao_hstro, nu_acao_historico);

-- Index: gct.ix_gcttb306_2

-- DROP INDEX gct.ix_gcttb306_2;

CREATE INDEX ix_gcttb306_2
  ON gct.gcttb306_hstro_termo
  USING btree
  (nu_entrega);

-- Index: gct.ix_gcttb306_3

-- DROP INDEX gct.ix_gcttb306_3;

CREATE INDEX ix_gcttb306_3
  ON gct.gcttb306_hstro_termo
  USING btree
  (nu_ordem_servico);

-- Index: gct.ix_gcttb306_4

-- DROP INDEX gct.ix_gcttb306_4;

CREATE INDEX ix_gcttb306_4
  ON gct.gcttb306_hstro_termo
  USING btree
  (nu_demanda);

-- Index: gct.ix_gcttb306_5

-- DROP INDEX gct.ix_gcttb306_5;

CREATE INDEX ix_gcttb306_5
  ON gct.gcttb306_hstro_termo
  USING btree
  (dh_acao_historico);

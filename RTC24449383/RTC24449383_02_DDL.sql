begin;

--
-- RTC 24449383 - SIGCT - Inclusão de parâmetro para ativar os indicadores do especializado
--

--
-- INICIO
--

--
-- CLEANUP
--
DROP TRIGGER IF EXISTS ati_gcttb010_1 ON gct.gcttb010_contrato;

alter table gct.gcttb010_contrato drop column if exists de_justificativa_alteracao;
alter table gct.gcttb010_contrato drop column if exists ic_hblta_clclo_indicador;

DROP TABLE if exists gct.gcttb361_hstrco_contrato;
DROP SEQUENCE if exists gct.gctsq361_nu_hstrco_contrato;

--
--
--
alter table gct.gcttb010_contrato 
  add column de_justificativa_alteracao varchar(500) not null default 'S';

comment on column gct.gcttb010_contrato.de_justificativa_alteracao 
  is 'Justificativa informada pelo funcionário Caixa para a alteração no contrato.';

alter table gct.gcttb010_contrato 
  add column ic_hblta_clclo_indicador char(1) not null default 'S';

ALTER TABLE gct.gcttb010_contrato 
  ADD CONSTRAINT chk_ic_hblta_clclo_indicador 
    CHECK (ic_hblta_clclo_indicador IN ('S', 'N'));

comment on column gct.gcttb010_contrato.ic_hblta_clclo_indicador 
  is 'Indica se o calculo dos indicadores será realizado para este contrato. Valores: S(sim) ou N(Não)';

--
--
--

-- Sequence: gct.gctsq361_nu_hstrco_contrato

-- DROP SEQUENCE if exists gct.gctsq361_nu_hstrco_contrato;

CREATE SEQUENCE gct.gctsq361_nu_hstrco_contrato
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  CACHE 1;

ALTER TABLE gct.gctsq361_nu_hstrco_contrato OWNER TO gct;

GRANT USAGE, SELECT ON SEQUENCE gct.gctsq361_nu_hstrco_contrato TO gct;

-- Table: gct.gcttb361_hstrco_contrato

-- DROP TABLE if exists gct.gcttb361_hstrco_contrato;

CREATE TABLE gct.gcttb361_hstrco_contrato
(
  nu_hstrco_contrato numeric(11,0) NOT NULL default nextval('gct.gctsq361_nu_hstrco_contrato'),
  nu_acao_historico numeric(4,0),
  nu_mtrca_acao_hstro numeric,
  dh_acao_historico timestamp without time zone,
  de_campo_alterado text,
  nu_contrato numeric(10,0),
  CONSTRAINT pk_gcttb361 PRIMARY KEY (nu_hstrco_contrato),
  CONSTRAINT fk_gcttb361_gcttb010 FOREIGN KEY (nu_contrato)
      REFERENCES gct.gcttb010_contrato (nu_contrato) MATCH SIMPLE
      ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT fk_gcttb361_gcttb076 FOREIGN KEY (nu_acao_historico)
      REFERENCES gct.gcttb076_acao_perfil (nu_acao_perfil) MATCH SIMPLE
      ON UPDATE RESTRICT ON DELETE RESTRICT      
);

ALTER TABLE gct.gcttb361_hstrco_contrato OWNER TO gct;

-- Index: gct.ix_gcttb308_1

-- DROP INDEX gct.ix_gcttb308_1;

CREATE INDEX ix_gcttb361_1
  ON gct.gcttb361_hstrco_contrato
  USING btree
  (nu_contrato, nu_mtrca_acao_hstro, nu_acao_historico);

--
--
--

-- Trigger: ati_gcttb010_1 on gct.gcttb010_contrato

-- DROP TRIGGER ati_gcttb010_1 ON gct.gcttb010_contrato;

CREATE TRIGGER ati_gcttb010_1
  AFTER INSERT OR UPDATE
  ON gct.gcttb010_contrato
  FOR EACH ROW
  EXECUTE PROCEDURE gct.gctfn001_gravar_hstrco_contrato();

--
-- FIM
--
insert into gct.gcttb900_hstco_objetos_bd(no_objeto) values ('RTC24449383_02_DDL.sql');

commit;

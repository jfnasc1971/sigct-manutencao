begin;

--
-- RTC 22877402 - SIGCT - Contrato Especializado - Integração com a aplicação SIMPF
--

--
-- INICIO
--

drop table if exists gct.gcttb255_qntde_solicitacao;

-- Table: gct.gcttb255_qntde_solicitacao

-- DROP TABLE gct.gcttb255_qntde_solicitacao;

CREATE TABLE gct.gcttb255_qntde_solicitacao(
  nu_solicitacao numeric(10,0) NOT NULL,
  dh_contagem timestamp without time zone NOT NULL,
  no_ciclo character varying(150),
  qt_tamanho_total character varying(150) NOT NULL,
  ic_ativo character(1) DEFAULT 'A'::bpchar,
  nu_execucao numeric,
  nu_acao_historico numeric(4,0),
  nu_mtrca_acao_hstro numeric,
  dh_modificacao timestamp without time zone NOT NULL DEFAULT now(),
  CONSTRAINT pk_gcttb255 PRIMARY KEY (nu_solicitacao, dh_contagem),
  CONSTRAINT fk_gcttb255_gcttb005 FOREIGN KEY (nu_solicitacao)
      REFERENCES gct.gcttb005_solicitacao (nu_solicitacao) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);

ALTER TABLE gct.gcttb255_qntde_solicitacao OWNER TO gct;

DROP SEQUENCE if exists gct.gctsq255_nu_qntde_solicitacao;

--
-- FIM
--

commit;
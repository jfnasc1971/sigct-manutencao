begin;

--
-- RTC 22877402 - SIGCT - Contrato Especializado - Integração com a aplicação SIMPF
--

--
-- INICIO
--

drop table if exists gct.gcttb255_qntde_solicitacao;

-- - Layout do arquivo de envio

--   - Item de Portifólio (4 dígitos)
--   - Squad (chave 5 dígitos)
--   - Sprint 
-- 	- ID (4 dígitos)
-- 	- Nome (150 caracteres)
--   - ID da Contagem (10 dígitos)
--   - Versão Contagem: Texto. Exemplo: v1, v2, v3
--   - Tipo: Contagem ou Divergência: C ou D
--   - Data da Contagem/Atualização
--   - Origem (motivo): Número do RTC ou AIMM que originou a contagem/divergência
--   - Número do IB
--    - Valor PF: duas casas decimais
--    - Tipo PF: Incluído PF, Alterado PF, Excluído PF, Incluído Convertido, Alterado Convertido, Excluído Convertido (apenas para tradicional)

-- Sequence: gct.gctsq255_nu_qntde_solicitacao

-- DROP SEQUENCE gct.gctsq255_nu_qntde_solicitacao;

CREATE SEQUENCE gct.gctsq255_nu_qntde_solicitacao
  INCREMENT 1
  MINVALUE 1000
  CACHE 1;

ALTER TABLE gct.gctsq001_nu_area_interna OWNER TO gct;

-- Table: gct.gcttb255_qntde_solicitacao

-- DROP TABLE gct.gcttb255_qntde_solicitacao;

CREATE TABLE gct.gcttb255_qntde_solicitacao(
  nu_controle_carga numeric not null,
  co_solicitacao character varying(15),
  co_sprint character varying(30),
  nu_item_portfolio numeric(10,0),
  co_equipe_epzdo character varying(20),
  de_equipe_epzdo character varying(200),
  co_versao_contagem character varying(10),
  co_tipo_contagem character(1),
  dh_contagem timestamp without time zone,
  de_motivo_contagem character varying(250),
  qt_total numeric,
  qt_incluido numeric,
  qt_alterado numeric,
  qt_excluido numeric,
  qt_incluido_convertido numeric,
  qt_alterado_convertido numeric,
  qt_excluido_convertido numeric,
  ic_situacao_avaliacao char(1) default 'P',
  de_resultado_avaliacao varchar(1000),
  dh_modificacao timestamp default current_timestamp,
  CONSTRAINT pk_gcttb255 PRIMARY key(nu_controle_carga, co_solicitacao, co_sprint)
);

ALTER TABLE gct.gcttb255_qntde_solicitacao OWNER TO gct;

--
-- FIM
--

commit;
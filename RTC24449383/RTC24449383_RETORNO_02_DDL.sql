begin;

--
-- RTC 24449383 - SIGCT - Inclusão de parâmetro para ativar os indicadores do especializado
--

--
-- INICIO
--

--
--
--
DROP TRIGGER IF EXISTS ati_gcttb010_1 ON gct.gcttb010_contrato;

alter table gct.gcttb010_contrato drop column if exists de_justificativa_alteracao;
alter table gct.gcttb010_contrato drop column if exists ic_hblta_clclo_indicador;

DROP TABLE if exists gct.gcttb361_hstrco_contrato;
DROP SEQUENCE if exists gct.gctsq361_nu_hstrco_contrato;

--
-- FIM
--
insert into gct.gcttb900_hstco_objetos_bd(no_objeto) values ('RTC24449383_RETORNO_02_DDL.sql');

commit;

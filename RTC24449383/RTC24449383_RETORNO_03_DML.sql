begin;

--
-- RTC 24449383 - SIGCT - Inclusão de parâmetro para ativar os indicadores do especializado
--

--
-- INICIO
--

UPDATE gct.gcttb010_contrato SET ic_hblta_clclo_indicador='S', nu_acao_historico=218, nu_mtrca_acao_hstro=1 WHERE nu_contrato=206;
UPDATE gct.gcttb010_contrato SET ic_hblta_clclo_indicador='S', nu_acao_historico=218, nu_mtrca_acao_hstro=1 WHERE nu_contrato=205;
UPDATE gct.gcttb010_contrato SET ic_hblta_clclo_indicador='S', nu_acao_historico=218, nu_mtrca_acao_hstro=1 WHERE nu_contrato=204;
UPDATE gct.gcttb010_contrato SET ic_hblta_clclo_indicador='S', nu_acao_historico=218, nu_mtrca_acao_hstro=1 WHERE nu_contrato=203;
UPDATE gct.gcttb010_contrato SET ic_hblta_clclo_indicador='S', nu_acao_historico=218, nu_mtrca_acao_hstro=1 WHERE nu_contrato=202;
UPDATE gct.gcttb010_contrato SET ic_hblta_clclo_indicador='S', nu_acao_historico=218, nu_mtrca_acao_hstro=1 WHERE nu_contrato=201;
UPDATE gct.gcttb010_contrato SET ic_hblta_clclo_indicador='S', nu_acao_historico=218, nu_mtrca_acao_hstro=1 WHERE nu_contrato=1016;
UPDATE gct.gcttb010_contrato SET ic_hblta_clclo_indicador='S', nu_acao_historico=218, nu_mtrca_acao_hstro=1 WHERE nu_contrato=1017;
UPDATE gct.gcttb010_contrato SET ic_hblta_clclo_indicador='S', nu_acao_historico=218, nu_mtrca_acao_hstro=1 WHERE nu_contrato=1018;
UPDATE gct.gcttb010_contrato SET ic_hblta_clclo_indicador='S', nu_acao_historico=218, nu_mtrca_acao_hstro=1 WHERE nu_contrato=1019;

delete from gct.gcttb361_hstrco_contrato;
delete from gct.gcttb076_acao_perfil where nu_acao_perfil = 218;

update gct.gcttb010_contrato set co_contrato=' 09705/202' where nu_contrato=1017;

--
-- FIM
--
insert into gct.gcttb900_hstco_objetos_bd(no_objeto) values ('RTC24449383_03_DML.sql');

commit;

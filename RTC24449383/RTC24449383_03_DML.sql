begin;

--
-- RTC 24449383 - SIGCT - Inclusão de parâmetro para ativar os indicadores do especializado
--

--
-- INICIO
--

delete from gct.gcttb361_hstrco_contrato;
delete from gct.gcttb076_acao_perfil where nu_acao_perfil = 218;

INSERT INTO gct.gcttb076_acao_perfil (nu_acao_perfil,no_acao_perfil,ic_ativo,nu_entidade_afetada,ic_gera_historico,de_acao_perfil) 
VALUES (218,'Alterar Contrato','S',10,'S',null);

UPDATE gct.gcttb010_contrato SET ic_hblta_clclo_indicador='N', nu_acao_historico=218, nu_mtrca_acao_hstro=1 WHERE nu_contrato=206;
UPDATE gct.gcttb010_contrato SET ic_hblta_clclo_indicador='N', nu_acao_historico=218, nu_mtrca_acao_hstro=1 WHERE nu_contrato=205;
UPDATE gct.gcttb010_contrato SET ic_hblta_clclo_indicador='N', nu_acao_historico=218, nu_mtrca_acao_hstro=1 WHERE nu_contrato=204;
UPDATE gct.gcttb010_contrato SET ic_hblta_clclo_indicador='N', nu_acao_historico=218, nu_mtrca_acao_hstro=1 WHERE nu_contrato=203;
UPDATE gct.gcttb010_contrato SET ic_hblta_clclo_indicador='N', nu_acao_historico=218, nu_mtrca_acao_hstro=1 WHERE nu_contrato=202;
UPDATE gct.gcttb010_contrato SET ic_hblta_clclo_indicador='N', nu_acao_historico=218, nu_mtrca_acao_hstro=1 WHERE nu_contrato=201;
UPDATE gct.gcttb010_contrato SET ic_hblta_clclo_indicador='N', nu_acao_historico=218, nu_mtrca_acao_hstro=1 WHERE nu_contrato=1016;
UPDATE gct.gcttb010_contrato SET ic_hblta_clclo_indicador='N', nu_acao_historico=218, nu_mtrca_acao_hstro=1 WHERE nu_contrato=1017;
UPDATE gct.gcttb010_contrato SET ic_hblta_clclo_indicador='N', nu_acao_historico=218, nu_mtrca_acao_hstro=1 WHERE nu_contrato=1018;
UPDATE gct.gcttb010_contrato SET ic_hblta_clclo_indicador='N', nu_acao_historico=218, nu_mtrca_acao_hstro=1 WHERE nu_contrato=1019;

update gct.gcttb010_contrato set co_contrato='09705/2025' where nu_contrato=1017;

--
-- FIM
--
insert into gct.gcttb900_hstco_objetos_bd(no_objeto) values ('RTC24449383_03_DML.sql');

commit;

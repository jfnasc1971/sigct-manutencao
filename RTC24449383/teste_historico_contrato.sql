\i 'src/Objetos_BD/Functions/GCTFN001_GRAVAR_HSTRCO_CONTRATO_DDL.sql'

begin; 

delete from gct.gcttb361_hstrco_contrato;

UPDATE gct.gcttb010_contrato SET ic_hblta_clclo_indicador='N', nu_acao_historico=218, nu_mtrca_acao_hstro=000001 WHERE nu_contrato=206;
UPDATE gct.gcttb010_contrato SET ic_hblta_clclo_indicador='S', nu_acao_historico=218, nu_mtrca_acao_hstro=138173 WHERE nu_contrato=206;
UPDATE gct.gcttb010_contrato SET ic_hblta_clclo_indicador='N', nu_acao_historico=218, nu_mtrca_acao_hstro=100360 WHERE nu_contrato=206;

UPDATE gct.gcttb010_contrato SET ic_hblta_clclo_indicador='N', nu_acao_historico=218, nu_mtrca_acao_hstro=000001 WHERE nu_contrato=205;
UPDATE gct.gcttb010_contrato SET ic_hblta_clclo_indicador='S', nu_acao_historico=218, nu_mtrca_acao_hstro=138173 WHERE nu_contrato=205;
UPDATE gct.gcttb010_contrato SET ic_hblta_clclo_indicador='N', nu_acao_historico=218, nu_mtrca_acao_hstro=100360 WHERE nu_contrato=205;

UPDATE gct.gcttb010_contrato SET ic_hblta_clclo_indicador='N', nu_acao_historico=218, nu_mtrca_acao_hstro=000001 WHERE nu_contrato=204;
UPDATE gct.gcttb010_contrato SET ic_hblta_clclo_indicador='S', nu_acao_historico=218, nu_mtrca_acao_hstro=138173 WHERE nu_contrato=204;
UPDATE gct.gcttb010_contrato SET ic_hblta_clclo_indicador='N', nu_acao_historico=218, nu_mtrca_acao_hstro=100360 WHERE nu_contrato=204;

UPDATE gct.gcttb010_contrato SET ic_hblta_clclo_indicador='N', nu_acao_historico=218, nu_mtrca_acao_hstro=000001 WHERE nu_contrato=203;
UPDATE gct.gcttb010_contrato SET ic_hblta_clclo_indicador='S', nu_acao_historico=218, nu_mtrca_acao_hstro=138173 WHERE nu_contrato=203;
UPDATE gct.gcttb010_contrato SET ic_hblta_clclo_indicador='N', nu_acao_historico=218, nu_mtrca_acao_hstro=100360 WHERE nu_contrato=203;

UPDATE gct.gcttb010_contrato SET ic_hblta_clclo_indicador='N', nu_acao_historico=218, nu_mtrca_acao_hstro=000001 WHERE nu_contrato=202;
UPDATE gct.gcttb010_contrato SET ic_hblta_clclo_indicador='S', nu_acao_historico=218, nu_mtrca_acao_hstro=138173 WHERE nu_contrato=202;
UPDATE gct.gcttb010_contrato SET ic_hblta_clclo_indicador='N', nu_acao_historico=218, nu_mtrca_acao_hstro=100360 WHERE nu_contrato=202;

UPDATE gct.gcttb010_contrato SET ic_hblta_clclo_indicador='N', nu_acao_historico=218, nu_mtrca_acao_hstro=000001 WHERE nu_contrato=201;
UPDATE gct.gcttb010_contrato SET ic_hblta_clclo_indicador='S', nu_acao_historico=218, nu_mtrca_acao_hstro=138173 WHERE nu_contrato=201;
UPDATE gct.gcttb010_contrato SET ic_hblta_clclo_indicador='N', nu_acao_historico=218, nu_mtrca_acao_hstro=100360 WHERE nu_contrato=201;

UPDATE gct.gcttb010_contrato SET ic_hblta_clclo_indicador='N', nu_acao_historico=218, nu_mtrca_acao_hstro=100360 WHERE nu_contrato=1016;
UPDATE gct.gcttb010_contrato SET ic_hblta_clclo_indicador='N', nu_acao_historico=218, nu_mtrca_acao_hstro=100360 WHERE nu_contrato=1017;
UPDATE gct.gcttb010_contrato SET ic_hblta_clclo_indicador='N', nu_acao_historico=218, nu_mtrca_acao_hstro=100360 WHERE nu_contrato=1018;
UPDATE gct.gcttb010_contrato SET ic_hblta_clclo_indicador='N', nu_acao_historico=218, nu_mtrca_acao_hstro=100360 WHERE nu_contrato=1019;

select * from gct.gcttb361_hstrco_contrato order by nu_contrato;

commit;

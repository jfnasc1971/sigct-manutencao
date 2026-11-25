begin;

--
-- RTC 24444623 - SIGCT - (Auditoria) Cria��o de Funcionalidade para n�o permitir sprint vazias
--

--
-- INICIO
--

DELETE FROM gct.gcttb076_acao_perfil WHERE nu_acao_perfil = 263;

--
-- FIM
--
commit;
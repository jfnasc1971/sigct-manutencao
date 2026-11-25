begin;

--
-- RTC 24444623 - SIGCT - (Auditoria) Cria��o de Funcionalidade para n�o permitir sprint vazias
--

--
-- INICIO
--

INSERT INTO gct.gcttb076_acao_perfil (nu_acao_perfil,no_acao_perfil,ic_ativo,nu_entidade_afetada,ic_gera_historico,de_acao_perfil) VALUES
	 (263,'Incluir Registro de Sprint Fracassada','S',39,'S',NULL);

--
-- FIM
--
commit;
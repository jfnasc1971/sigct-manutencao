begin;

--
-- RTC 24444623 - SIGCT - (Auditoria) Cria��o de Funcionalidade para n�o permitir sprint vazias
--

--
-- INICIO
--

ALTER TABLE gct.gcttb088_ciclo_trabalho 
  ADD COLUMN de_justificativa_fracasso varchar(500);

ALTER TABLE gct.gcttb088_ciclo_trabalho
  DROP CONSTRAINT if exists cc_gcttb088_1;

ALTER TABLE gct.gcttb088_ciclo_trabalho
  ADD CONSTRAINT cc_gcttb088_1
  CHECK (co_falha_ciclo_trabalho = ANY (ARRAY['FC'::bpchar, 'FS'::bpchar, 'NF'::bpchar, 'SF'::bpchar]));

--
-- FIM
--
commit;
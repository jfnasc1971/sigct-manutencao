--
-- INICIO
--

--------------------------------------------------------------------------------
-- -- gcttb521_perfil_profissional
-- --------------------------------------------------------------------------------

-- DROP TABLE gct.gcttb521_perfil_profissional
ALTER TABLE gct.gcttb521_perfil_profissional DROP CONSTRAINT IF EXISTS fk_perfil_tipo_atendimento;

ALTER TABLE gct.gcttb521_perfil_profissional DROP COLUMN IF EXISTS nu_tipo_atendimento;

DROP TABLE IF EXISTS gct.gcttb290_tipo_atendimento;

--
-- FIM
--
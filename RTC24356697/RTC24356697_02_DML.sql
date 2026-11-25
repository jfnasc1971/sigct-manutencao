begin;
--
-- RTC 24356697: SIGCT - Inclusão do campo "Tipo de Atendimento" na funcionalidade Perfil Profissional
--
--
-- INICIO
--

INSERT INTO gct.gcttb290_tipo_atendimento (nu_tipo_atendimento, no_tipo_atendimento)
VALUES 
    (1, 'Plano de Atendimento'),
    (2, 'Catálogo de Serviço');

--
-- FIM
--
commit;
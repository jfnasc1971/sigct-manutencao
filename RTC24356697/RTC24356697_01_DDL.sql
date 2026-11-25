--
-- INICIO
--

--------------------------------------------------------------------------------
-- -- gcttb290_tipo_atendimento
-- --------------------------------------------------------------------------------

-- DROP TABLE gct.gcttb290_tipo_atendimento

CREATE TABLE gct.gcttb290_tipo_atendimento (
    nu_tipo_atendimento numeric(3) NOT NULL, -- Numero identificador do tipo de atendimento
    no_tipo_atendimento varchar(500) NOT NULL, -- Descricao do tipo de atendimento
    CONSTRAINT pk_gcttb290 PRIMARY KEY (nu_tipo_atendimento)
);
COMMENT ON TABLE gct.gcttb290_tipo_atendimento IS 'Este objeto armazena os tipos de atendimento no Perfil Profissional na parametrização.
1	Plano de Atendimento
2	Catálogo de Serviço';

-- Column comments

COMMENT ON COLUMN gct.gcttb290_tipo_atendimento.nu_tipo_atendimento IS 'Numero identificador do tipo de atendimento.';
COMMENT ON COLUMN gct.gcttb290_tipo_atendimento.no_tipo_atendimento IS 'Nome do tipo de atendimento.';

-- Permissions

ALTER TABLE gct.gcttb290_tipo_atendimento OWNER TO gct; -- O OWNER EH SEMPRE GCT

ALTER TABLE gct.gcttb521_perfil_profissional ADD COLUMN nu_tipo_atendimento numeric(3);

COMMENT ON COLUMN gct.gcttb521_perfil_profissional.nu_tipo_atendimento 
  IS 'Código do tipo de atendimento relacionado ao perfil profissional. 1 - Plano de Atendimento; 2 - Catálogo de Serviço';

ALTER TABLE gct.gcttb521_perfil_profissional 
  ADD CONSTRAINT fk_gcttb521_gcttb290
    FOREIGN KEY (nu_tipo_atendimento) REFERENCES gct.gcttb290_tipo_atendimento(nu_tipo_atendimento);

--
-- FIM
--
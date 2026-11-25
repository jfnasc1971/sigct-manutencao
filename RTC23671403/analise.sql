begin;

-- Indicadores aplicados nas equipes de SUPORTE:

-- ÍNDICE DE EFETIVIDADE
-- ÍNDICE DE DESEMPENHO DA EQUIPE 
-- ÍNDICE DE ESTOQUE DE TURNOVER

-- Indicadores aplicados nas equipes de DESENVOLVIMENTO:
-- ÍNDICE DE EFETIVIDADE
-- ÍNDICE DE PRODUTIVIDADE
-- ÍNDICE DE QUALIDADE
-- ÍNDICE DE DESEMPENHO DA EQUIPE 
-- ÍNDICE DE ESTOQUE DE TURNOVER

INSERT INTO
  gct.gcttb112_tipo_indicador (
    nu_tipo_indicador,
    no_tipo_indicador,
    sg_tipo_indicador,
    de_tipo_indicador,
    ic_indicador_reducao,
    nu_acao_historico,
    nu_mtrca_acao_hstro,
    vr_padrao,
    ic_tipo_atendimento,
    de_calculo_tipo_indicador,
    ic_tipo_contratacao,
    ic_fator_conversao_fns,
    ic_grupo_referenciado,
    ic_indicador_referenciado,
    ic_limite_maximo_indicador,
    ic_media_referente_ftrmto_atual,
    ic_peso_indicador,
    ic_produtividade_esperada,
    ic_qtd_ftrmto_media,
    ic_valor_ajuste_indicador
  )
VALUES
  (
    36,
    'Efetividade',
    'IE',
    'Medir a efetividade das equipes',
    'S',
    null,
    null,
    null,
    'S',
    'IE = ((Itens_Prontos_Sprint1 / Itens_Backlog_Sprint1) +(Itens_Prontos_SprintN / Itens_Backlog_SprintN) / N(quantidade de sprints)',
    'E',
    'N',
    'N',
    'N',
    'N',
    'N',
    'N',
    'N',
    'N',
    'N'
  );

INSERT INTO
  gct.gcttb112_tipo_indicador (
    nu_tipo_indicador,
    no_tipo_indicador,
    sg_tipo_indicador,
    de_tipo_indicador,
    ic_indicador_reducao,
    nu_acao_historico,
    nu_mtrca_acao_hstro,
    vr_padrao,
    ic_tipo_atendimento,
    de_calculo_tipo_indicador,
    ic_tipo_contratacao,
    ic_fator_conversao_fns,
    ic_grupo_referenciado,
    ic_indicador_referenciado,
    ic_limite_maximo_indicador,
    ic_media_referente_ftrmto_atual,
    ic_peso_indicador,
    ic_produtividade_esperada,
    ic_qtd_ftrmto_media,
    ic_valor_ajuste_indicador
  )
VALUES
  (
    37,
    'Produtividade',
    'IP',
    'Medir a produtividade das equipes',
    'S',
    null,
    null,
    null,
    'S',
    'IP = Pontos_Funcao / ( Colaboradores * PE * Dias_Uteis )',
    'E',
    'N',
    'N',
    'N',
    'N',
    'N',
    'N',
    'N',
    'N',
    'N'
  );

INSERT INTO
  gct.gcttb112_tipo_indicador (
    nu_tipo_indicador,
    no_tipo_indicador,
    sg_tipo_indicador,
    de_tipo_indicador,
    ic_indicador_reducao,
    nu_acao_historico,
    nu_mtrca_acao_hstro,
    vr_padrao,
    ic_tipo_atendimento,
    de_calculo_tipo_indicador,
    ic_tipo_contratacao,
    ic_fator_conversao_fns,
    ic_grupo_referenciado,
    ic_indicador_referenciado,
    ic_limite_maximo_indicador,
    ic_media_referente_ftrmto_atual,
    ic_peso_indicador,
    ic_produtividade_esperada,
    ic_qtd_ftrmto_media,
    ic_valor_ajuste_indicador
  )
VALUES
  (
    38,
    'Qualidade',
    'IQ',
    'Medir a qualidade das entregas das equipes',
    'S',
    null,
    null,
    null,
    'S',
    'IQE = ((Reducao_defeitos x Peso) + (Nota_Qualidade_Codigo x Peso)) / N',
    'E',
    'N',
    'N',
    'N',
    'N',
    'N',
    'N',
    'N',
    'N',
    'N'
  );

INSERT INTO
  gct.gcttb112_tipo_indicador (
    nu_tipo_indicador,
    no_tipo_indicador,
    sg_tipo_indicador,
    de_tipo_indicador,
    ic_indicador_reducao,
    nu_acao_historico,
    nu_mtrca_acao_hstro,
    vr_padrao,
    ic_tipo_atendimento,
    de_calculo_tipo_indicador,
    ic_tipo_contratacao,
    ic_fator_conversao_fns,
    ic_grupo_referenciado,
    ic_indicador_referenciado,
    ic_limite_maximo_indicador,
    ic_media_referente_ftrmto_atual,
    ic_peso_indicador,
    ic_produtividade_esperada,
    ic_qtd_ftrmto_media,
    ic_valor_ajuste_indicador
  )
VALUES
  (
    39,
    'Produtividade',
    'IP',
    'Medir a produtividade das equipes',
    'S',
    null,
    null,
    null,
    'S',
    'IP = Pontos_Funcao / ( Colaboradores * PE * Dias_Uteis )',
    'E',
    'N',
    'N',
    'N',
    'N',
    'N',
    'N',
    'N',
    'N',
    'N'
  );

INSERT INTO
  gct.gcttb112_tipo_indicador (
    nu_tipo_indicador,
    no_tipo_indicador,
    sg_tipo_indicador,
    de_tipo_indicador,
    ic_indicador_reducao,
    nu_acao_historico,
    nu_mtrca_acao_hstro,
    vr_padrao,
    ic_tipo_atendimento,
    de_calculo_tipo_indicador,
    ic_tipo_contratacao,
    ic_fator_conversao_fns,
    ic_grupo_referenciado,
    ic_indicador_referenciado,
    ic_limite_maximo_indicador,
    ic_media_referente_ftrmto_atual,
    ic_peso_indicador,
    ic_produtividade_esperada,
    ic_qtd_ftrmto_media,
    ic_valor_ajuste_indicador
  )
VALUES
  (
    40,
    'Turnover',
    'IT',
    'Medir o índice de rotatividade baseado na quantidade de saídas',
    'S',
    null,
    null,
    null,
    'S',
    'IT = 1 - (Quantidade_Desligamentos_Trimestral/Quantidade_Perfis_Ultimo_Trimestre)',
    'E',
    'N',
    'N',
    'N',
    'N',
    'N',
    'N',
    'N',
    'N',
    'N'
  );

INSERT INTO
  gct.gcttb112_tipo_indicador (
    nu_tipo_indicador,
    no_tipo_indicador,
    sg_tipo_indicador,
    de_tipo_indicador,
    ic_indicador_reducao,
    nu_acao_historico,
    nu_mtrca_acao_hstro,
    vr_padrao,
    ic_tipo_atendimento,
    de_calculo_tipo_indicador,
    ic_tipo_contratacao,
    ic_fator_conversao_fns,
    ic_grupo_referenciado,
    ic_indicador_referenciado,
    ic_limite_maximo_indicador,
    ic_media_referente_ftrmto_atual,
    ic_peso_indicador,
    ic_produtividade_esperada,
    ic_qtd_ftrmto_media,
    ic_valor_ajuste_indicador
  )
VALUES
  (
    41,
    'Fator de Níveis de Serviço',
    'FNS',
    'Apurar o FATOR DE NIVEIS DE SERVIÇO (FNS)',
    'S',
    null,
    null,
    null,
    'S',
    'FNS = {[(IE) + (IP) + (IQ) + (IT)] / n}',
    'E',
    'N',
    'N',
    'N',
    'N',
    'N',
    'N',
    'N',
    'N',
    'N'
  );

rollback;
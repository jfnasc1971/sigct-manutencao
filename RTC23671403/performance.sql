explain analyze
  SELECT
    vie.*
  FROM
    gct.gcttb172_valor_indicador_equipe vie
  -- JOIN
  --   gct.gcttb102_fatura f ON f.nu_fatura = COALESCE(vie.nu_fatura_ajuste, vie.nu_fatura)
  -- JOIN
  --   gct.gcttb033_grupo_contrato gc ON (
  --     gc.nu_contrato = vie.nu_contrato
  --     AND gc.nu_tipo_grupo = vie.nu_tipo_grupo
  --   )
  WHERE
    1=1
    -- vie.nu_valor_indicador = (
    --   (
    --     SELECT
    --       max(vie2.nu_valor_indicador) AS nu_valor_indicador
    --     FROM
    --       gct.gcttb172_valor_indicador_equipe vie2
    --     WHERE
    --       vie.dt_referencia = vie2.dt_referencia
    --       AND vie.nu_equipe = vie2.nu_equipe
    --       AND vie.nu_tipo_indicador = vie2.nu_tipo_indicador
    --   )
    -- )
    --AND vie.nu_fatura_previa IS NULL
    --AND f.dt_final_fatura > gc.dt_considerar_fns
    and vie.nu_contrato = 719
        and vie.nu_tipo_indicador = 20 --nuTipoIndicador
        and vie.nu_tipo_grupo = 65 --nuTipoGrupo    ;

    --  select
    --     e.co_equipe,
    --     vie.vr_calculo_indicador,
    --     vie.dt_referencia,
    --     vie.dh_geracao_indicador_equipe::date
    --   from
    --     gct.gctvw052_valor_indicador_equipe vie
    --     inner join gct.gcttb087_equipe e on e.nu_equipe = vie.nu_equipe
    --     inner join gct.gcttb001_area_interna ai on ai.nu_area_interna = e.nu_area_interna
    --     inner join gct.gcttb010_contrato c on c.nu_contrato = e.nu_contrato
    --     inner join gct.gcttb102_fatura f on (
    --       f.nu_faturamento = c.nu_faturamento
    --       and f.dt_final_fatura = vie.dt_referencia
    --       and f.co_sitio = ai.co_sitio
    --     )
    --     inner join gct.gcttb173_grupo_indicador_vinculo giv on (
    --       giv.nu_tipo_grupo_vinculado = vie.nu_tipo_grupo
    --       and giv.nu_contrato_vinculado = vie.nu_contrato
    --       and giv.nu_tipo_indicador_vinculado = vie.nu_tipo_indicador
    --     )
    --   where
    --     vie.vr_calculo_indicador is not null
    --     and giv.nu_tipo_indicador = 20 --nuTipoIndicador
    --     and giv.nu_contrato = 719 --nuContrato
    --     and giv.nu_tipo_grupo = 65 --nuTipoGrupo
    --     and f.dt_final_fatura = '2025-10-20' -- dtfinalfatura
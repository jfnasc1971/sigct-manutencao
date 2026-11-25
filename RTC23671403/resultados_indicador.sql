-- Para filtro e join com equipe
CREATE INDEX ix_equipe_contrato_grupo ON gct.gcttb087_equipe(nu_contrato, nu_tipo_grupo, co_equipe);

-- Para join com valor indicador
CREATE INDEX ix_valor_indicador_equipe ON gct.gcttb172_valor_indicador_equipe(nu_equipe, nu_tipo_indicador, dt_inicio_indicador);

-- Para join com tipo indicador
CREATE INDEX ix_tipo_indicador ON gct.gcttb112_tipo_indicador(nu_tipo_indicador, sg_tipo_indicador);

-- Para ordenação
CREATE INDEX ix_ordenacao ON gct.gcttb172_valor_indicador_equipe(dt_inicio_indicador);

---explain --analyze
select
  c.co_contrato,
  e.co_equipe,
  tg.no_tipo_grupo,
  ti.sg_tipo_indicador,
  ti.no_tipo_indicador,
  vie.dt_referencia,
  vie.dt_inicio_indicador,
  vie.dt_final_indicador,
  vie.vr_calculo_indicador,
  vie.vr_faixa_fns
from
  gct.gcttb172_valor_indicador_equipe vie
  inner join gct.gcttb087_equipe e on e.nu_equipe = vie.nu_equipe
  inner join gct.gcttb010_contrato c on c.nu_contrato = e.nu_contrato
  inner join gct.gcttb032_tipo_grupo tg on tg.nu_tipo_grupo = e.nu_tipo_grupo
  inner join gct.gcttb112_tipo_indicador ti on ti.nu_tipo_indicador = vie.nu_tipo_indicador
where
  e.nu_contrato between 201 and 206
  --and ti.sg_tipo_indicador = 'IDE'
  --and e.co_equipe = 'BRE202500206'
order by
  c.co_contrato,
  e.co_equipe,
  tg.no_tipo_grupo,
  ti.sg_tipo_indicador,
  vie.dt_inicio_indicador
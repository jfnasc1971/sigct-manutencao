--
-- VALOR DEVIDO, SEM INDICADORES
--
select
  e.nu_equipe, e.co_equipe
from
  gct.gcttb087_equipe e
  inner join gct.gcttb523_qntde_membro_equipe_perfil q on e.nu_equipe=e.nu_equipe
where
  e.co_equipe = 'BRE202500167';

--
-- TUDO QUE FOI PAGO
--
select
  e.co_equipe, f.nu_fatura, f.dt_final_fatura, te.co_termo, te.vr_financeiro_termo
from
  gct.gcttb087_equipe e
  inner join gct.gcttb170_termo_equipe te on (
    te.nu_equipe = e.nu_equipe
    and te.nu_tipo_termo in (11) --, 12)
    and te.nu_situacao_termo in (1, 3)
  )
  inner join gct.gcttb102_fatura f on f.nu_fatura = te.nu_fatura_gerada
where
  e.co_equipe = 'BRE202500167';

select
  e.co_equipe,
  sum(te.vr_financeiro_termo)
from
  gct.gcttb087_equipe e
  inner join gct.gcttb170_termo_equipe te on (
    te.nu_equipe = e.nu_equipe
    and te.nu_tipo_termo in (11, 12)
    and te.nu_situacao_termo in (1, 3)
  )
  inner join gct.gcttb102_fatura f on f.nu_fatura = te.nu_fatura_paga
where
  e.co_equipe = 'BRE202500167'
group by
  e.co_equipe;

--
-- TERMOS DE AJUSTE
--
select
  e.co_equipe,
  f.dt_final_fatura,
  te.co_termo,
  te.dh_emissao_termo,
  te.vr_financeiro_termo,
  sum(tae.vr_diferenca),
  te.vr_financeiro_termo - sum(tae.vr_diferenca)
from
  gct.gcttb087_equipe e
  inner join gct.gcttb170_termo_equipe te on (
    te.nu_equipe = e.nu_equipe
    and te.nu_tipo_termo in (12)
    and te.nu_situacao_termo in (1, 3)
  )
  inner join gct.gcttb102_fatura f on f.nu_fatura = te.nu_fatura_paga
  inner join gct.gcttb186_termo_ajuste_equipe tae on (
    tae.nu_equipe = te.nu_equipe
    and tae.nu_ajuste = te.nu_ajuste
    and tae.nu_termo_equipe = te.nu_termo_equipe
  )
where
  e.co_equipe = 'BRE202500167'
group by
  e.co_equipe,
  f.dt_final_fatura,
  te.co_termo,
  te.dh_emissao_termo,
  te.vr_financeiro_termo;

select gc.nu_contrato, gc.nu_tipo_grupo,gc.dt_considerar_fns,gc.ic_tipo_atendimento from gct.gcttb033_grupo_contrato gc where gc.nu_contrato=1004


select
  nu_tipo_indicador,
  avg(vr_calculo_indicador) * vr_peso_tipo_indicador vr_media_indicador,
  vr_peso_tipo_indicador
from
  gct.gctvw076_valor_indicador_ciclo_trabalho_ajuste vict
where
  nu_equipe = 3018
  and nu_tipo_indicador in (
    select
      distinct ti.nu_tipo_indicador
    from
      gct.gcttb112_tipo_indicador ti
      inner join gct.gcttb115_grupo_indicador gi on (gi.nu_tipo_indicador = ti.nu_tipo_indicador)
    where
      nu_tipo_grupo = vict.nu_tipo_grupo
      and sg_tipo_indicador <> 'IEQDEP'
      and gi.ic_apenas_faturamento_atual <> 'S'
  )
  and nu_tipo_grupo = 65
  --and nu_ajuste = nuAjuste
  --and co_falha_ciclo_trabalho in ('NF', 'SF')
  --and cast(vict.dt_referencia as date) <= cast('2025-09-20' as date)
  --and cast(vict.dt_referencia as date) >= (
  --  cast('2025-09-20' as date) - ((3 - 1) * '1 Month' :: interval)
  --)
group by
  nu_tipo_indicador,
  vr_peso_tipo_indicador  

    select
      c.nu_contrato,
      e.co_equipe,
      e.nu_equipe,
      e.dt_inicio_atendimento::date,
      e.dt_final_atendimento::date,
      tg.nu_tipo_grupo,
      gc.ic_tipo_atendimento,
      gc.ic_calculo_pro_rata,
      ai.nu_area_interna,
      ai.nu_mtrca_responsavel,
      ai.no_sigla_area,
      ai.co_sitio,
      gc.ic_dias_calculo_pagamento,
      gc.ic_permite_servico_extra,
      gc.ic_permite_registro_ausencia,
      gc.ic_calculo_pro_rata,
      f.nu_fatura,
      f.dt_inicio_fatura,
      f.dt_final_fatura,
      t.nu_termo_equipe,
      t.co_termo,
      t.nu_fatura_gerada,
      c.ic_distribui_profissional,
      r.nu_rubrica as nu_rubrica_padrao,
      r.co_rubrica as co_rubrica_padrao
    from
      gct.gcttb010_contrato c
      inner join gct.gcttb033_grupo_contrato gc on (gc.nu_contrato = c.nu_contrato)
      inner join gct.gcttb175_amostra_equipe e on (
        e.nu_contrato = gc.nu_contrato
        and e.nu_tipo_grupo = gc.nu_tipo_grupo
      )
      inner join gct.gcttb032_tipo_grupo tg on tg.nu_tipo_grupo = gc.nu_tipo_grupo
      inner join gct.gcttb170_termo_equipe t on e.nu_equipe = t.nu_equipe
      inner join gct.gcttb102_fatura f on f.nu_fatura = t.nu_fatura_gerada
      inner join gct.gcttb001_area_interna ai on ai.nu_area_interna = e.nu_area_interna
      inner join gct.gcttb071_rubrica r on r.nu_rubrica = gc.nu_rubrica_padrao
    where
      c.ic_tipo_contratacao = 'E'
      and t.nu_tipo_termo in (11)
      and t.nu_situacao_termo in (1,3)
      and e.nu_ajuste = 650132 --p_nu_ajuste
      and e.nu_equipe = 3018 --p_nu_equipe
      and f.nu_fatura = 5261
    ORDER BY
      f.dt_final_fatura,
      c.nu_contrato,
      e.nu_equipe  
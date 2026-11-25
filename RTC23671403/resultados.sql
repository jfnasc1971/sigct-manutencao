select
  faj.dt_final_fatura "Fatura",  
  c.nu_contrato "Cod. Contrato",
  c.no_contrato "Contrato",
  tg.no_tipo_grupo "Grupo",
  e.co_equipe "Equipe",
  taj.co_termo "Termo Ajustado",
  taj.vr_financeiro_termo :: numeric(10, 2) as "Valor Termo Ajustado",
  te.co_termo "Termo Indicador",
  te.vr_financeiro_termo :: numeric(10, 2) "Valor Termo Indicador"
from
  gct.gcttb087_equipe e
  inner join gct.gcttb010_contrato c on c.nu_contrato = e.nu_contrato
  inner join gct.gcttb032_tipo_grupo tg on tg.nu_tipo_grupo = e.nu_tipo_grupo
  inner join gct.gcttb170_termo_equipe te on te.nu_equipe = e.nu_equipe
  and te.nu_tipo_termo = 21
  inner join gct.gcttb170_termo_equipe taj on taj.nu_termo_equipe = te.nu_termo_ajustado
  inner join gct.gcttb102_fatura faj on faj.nu_fatura = taj.nu_fatura_gerada
where
  e.nu_contrato in (201, 202, 203, 204, 205, 206)
order by
  faj.dt_final_fatura,
  c.no_contrato,
  tg.no_tipo_grupo,
  e.co_equipe,
  taj.co_termo;

select
  c.nu_contrato,
  c.no_contrato,
  tg.no_tipo_grupo,
  sum(taj.vr_financeiro_termo) vr_pago,
  sum(te.vr_financeiro_termo) vr_ajuste
from
  gct.gcttb087_equipe e
  inner join gct.gcttb032_tipo_grupo tg on tg.nu_tipo_grupo = e.nu_tipo_grupo
  inner join gct.gcttb010_contrato c on c.nu_contrato = e.nu_contrato
  inner join gct.gcttb170_termo_equipe te on te.nu_equipe = e.nu_equipe
  and te.nu_tipo_termo = 21
  inner join gct.gcttb170_termo_equipe taj on taj.nu_termo_equipe = te.nu_termo_ajustado
  inner join gct.gcttb102_fatura faj on faj.nu_fatura = taj.nu_fatura_gerada
where
  e.nu_contrato in (201, 202, 203, 204, 205, 206)
group by
  c.nu_contrato,
  c.no_contrato,
  tg.no_tipo_grupo
order by
  c.nu_contrato,
  c.no_contrato,
  tg.no_tipo_grupo;

select
  c.nu_contrato,
  c.no_contrato,
  sum(taj.vr_financeiro_termo) vr_pago,
  sum(te.vr_financeiro_termo) vr_ajuste
from
  gct.gcttb087_equipe e
  inner join gct.gcttb010_contrato c on c.nu_contrato = e.nu_contrato
  inner join gct.gcttb170_termo_equipe te on te.nu_equipe = e.nu_equipe
  and te.nu_tipo_termo = 21
  inner join gct.gcttb170_termo_equipe taj on taj.nu_termo_equipe = te.nu_termo_ajustado
  inner join gct.gcttb102_fatura faj on faj.nu_fatura = taj.nu_fatura_gerada
where
  e.nu_contrato in (201, 202, 203, 204, 205, 206)
group by
  c.nu_contrato,
  c.no_contrato
order by
  c.nu_contrato,
  c.no_contrato;
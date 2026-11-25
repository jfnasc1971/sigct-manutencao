explain analyze
SELECT
  t.nu_contrato,
  f.co_sitio,
  f.nu_fatura,
  sum(t.vr_financeiro_termo) AS vr_financeiro_termo
FROM
  gct.gcttb100_termo t
  JOIN gct.gcttb102_fatura f ON f.nu_fatura = t.nu_fatura_paga
WHERE
  t.nu_situacao_termo in (1,3)
  and NOT exists (
    select
      nu_termo
    from
      gct.gcttb121_amostra_retencao_ta
    where
      nu_termo = t.nu_termo
      and nu_fatura_liberada is null
  )
  and t.nu_contrato = 659  
GROUP BY
  t.nu_contrato,
  f.co_sitio,
  f.nu_fatura
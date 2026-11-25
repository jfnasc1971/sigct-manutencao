--
-- INICIO
--

--------------------------------------------------------------------------------
-- -- gct.gctvw019_pagamento_consolidados
-- --------------------------------------------------------------------------------

-- drop view if exists gct.gctvw019_pagamento_consolidados;

create or replace view gct.gctvw019_pagamento_consolidados as
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
GROUP BY
  t.nu_contrato,
  f.co_sitio,
  f.nu_fatura
UNION
SELECT
  t.nu_contrato :: numeric(6, 0) AS nu_contrato,
  f.co_sitio,
  f.nu_fatura,
  sum(t.vr_financeiro_termo) AS vr_financeiro_termo
FROM
  gct.gcttb170_termo_equipe t 
  INNER JOIN gct.gcttb102_fatura f ON (
    f.nu_fatura = t.nu_fatura_paga
    AND t.nu_tipo_termo in (11, 12, 20, 21, 22, 23, 24)
    AND t.nu_situacao_termo in (1, 3)
    AND t.nu_situacao_pagamento = 1
  )
GROUP BY
  t.nu_contrato,
  f.co_sitio,
  f.nu_fatura
ORDER BY
  nu_contrato,
  co_sitio,
  nu_fatura;

alter view gct.gctvw019_pagamento_consolidados owner to gct;


--
-- FIM
--

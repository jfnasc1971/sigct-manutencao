#!/bin/bash
CO_EQUIPE="$1"
DE_AJUSTE="TESTE AJUSTE"

cat << EOF > /tmp/ajuste_${CO_EQUIPE}.sql

\i 'src/Objetos_BD/Functions/GCTFN340_INDICADOR_PRODUTIVIDADE_AJUSTE_DDL.sql'
\i 'src/Objetos_BD/Functions/GCTFN342_INDICADOR_DESEMPENHO_AJUSTE_DDL.sql'

BEGIN;

SELECT
  gct.gctfn803_remover_termo_ajuste_equipe(a.nu_ajuste),
  a.de_justificativa_alteracao,
  e.co_equipe
FROM
  gct.gcttb184_ajuste_agil a
  inner join gct.gcttb187_ajuste_agil_equipe ae on ae.nu_ajuste = a.nu_ajuste
  inner join gct.gcttb087_equipe e on e.nu_equipe = ae.nu_equipe
WHERE
  a.de_justificativa_alteracao = '${DE_AJUSTE}'
  and e.co_equipe = '${CO_EQUIPE}';

SELECT
  c.nu_contrato,
  c.no_contrato,
  e.co_equipe,
  gct.gctfn905_executar_ajuste_equipe(
    e.co_equipe, 
    '${DE_AJUSTE}', 
    1) nu_ajuste
FROM
  gct.gcttb087_equipe e
  INNER JOIN gct.gcttb010_contrato c ON c.nu_contrato = e.nu_contrato
WHERE
  e.co_equipe = '${CO_EQUIPE}';

SELECT
  c.co_contrato,
  tg.no_tipo_grupo,
  e.co_equipe, t.nu_ajuste, t.co_termo, t.dh_emissao_termo, 
  trunc(t.vr_financeiro_termo_original,2) vr_financeiro_original,
  trunc(t.vr_financeiro_termo,2) vr_financeiro_termo, 
  substr(a.de_justificativa_alteracao,0,13) de_justificativa_alteracao
FROM
  gct.gcttb087_equipe e 
  inner join gct.gcttb010_contrato c on c.nu_contrato = e.nu_contrato
  inner join gct.gcttb170_termo_equipe t on e.nu_equipe = t.nu_equipe
  inner join gct.gcttb184_ajuste_agil a on a.nu_ajuste = t.nu_ajuste
  inner join gct.gcttb032_tipo_grupo tg on tg.nu_tipo_grupo = e.nu_tipo_grupo
WHERE
  e.co_equipe = '${CO_EQUIPE}'
  and t.nu_tipo_termo = 12
  and a.de_justificativa_alteracao = '${DE_AJUSTE}'
order by c.no_contrato, tg.no_tipo_grupo, e.co_equipe;

SELECT
  sum(t.vr_financeiro_termo)
FROM
  gct.gcttb087_equipe e 
  inner join gct.gcttb010_contrato c on c.nu_contrato = e.nu_contrato
  inner join gct.gcttb170_termo_equipe t on e.nu_equipe = t.nu_equipe
  inner join gct.gcttb184_ajuste_agil a on a.nu_ajuste = t.nu_ajuste
  inner join gct.gcttb032_tipo_grupo tg on tg.nu_tipo_grupo = e.nu_tipo_grupo
WHERE
  e.co_equipe = '${CO_EQUIPE}'
  and t.nu_tipo_termo = 12
  and a.de_justificativa_alteracao = '${DE_AJUSTE}';

-- select
--   vie.nu_fatura_ajuste,
--   vie.nu_tipo_indicador,
--   vie.vr_peso_tipo_indicador,
--   vie.vr_calculo_indicador,
--   vie.vr_faixa_fns
-- from
--   gct.gcttb172_valor_indicador_equipe vie
--   inner join gct.gcttb087_equipe e on e.nu_equipe = vie.nu_equipe
-- where
--   vie.nu_ajuste is not null
--   and e.co_equipe = '${CO_EQUIPE}'
--   and vie.nu_ajuste = (
--     select
--       max(ae.nu_ajuste)
--     from
--       gct.gcttb187_ajuste_agil_equipe ae
--     where
--       ae.nu_equipe = e.nu_equipe
--   )
-- order by vie.nu_fatura_ajuste, vie.nu_tipo_indicador;

-- select
--   vie.nu_fatura_ajuste,
--   vie.nu_tipo_indicador,
--   vie.vr_calculo_indicador,
--   vie.vr_faixa_fns
-- from
--   gct.gcttb172_valor_indicador_equipe vie
--   inner join gct.gcttb087_equipe e on e.nu_equipe = vie.nu_equipe
-- where
--   vie.nu_ajuste is not null
--   and e.co_equipe = '${CO_EQUIPE}'
--   and vie.nu_ajuste = (
--     select
--       max(ae.nu_ajuste)
--     from
--       gct.gcttb187_ajuste_agil_equipe ae
--     where
--       ae.nu_equipe = e.nu_equipe
--   )
--   and vie.nu_tipo_indicador = 21
-- order by vie.nu_fatura_ajuste, vie.nu_tipo_indicador;

commit;
EOF

../expsql /tmp/ajuste_${CO_EQUIPE}.sql

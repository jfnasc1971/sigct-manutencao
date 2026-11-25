#!/bin/bash
CO_EQUIPE="$1"
DE_AJUSTE="TESTE AJUSTE"

cat << EOF > /tmp/ajuste_${CO_EQUIPE}.sql

\i 'src/Objetos_BD/Functions/GCTFN349_EXECUTAR_AJUSTE_EQUIPE_DDL.sql'
\i 'src/Objetos_BD/Functions/GCTFN175_GRAVAR_AMSTA_INDCDR_AJUSTE_DDL.sql'
\i 'src/Objetos_BD/Functions/GCTFN176_SIMULAR_TERMO_AJUSTE_EQUIPE_DDL.sql'
\i 'src/Objetos_BD/Functions/GCTFN177_CALCULAR_INDICADOR_AJUSTE_DDL.sql'
\i 'src/Objetos_BD/Functions/GCTFN803_REMOVER_TERMO_AJUSTE_EQUIPE_DDL.sql'
\i 'src/Objetos_BD/Functions/GCTFN178_INDCDR_EFTVDE_AJUSTE_DDL.sql'
\i 'src/Objetos_BD/Functions/GCTFN179_INDCDR_EFTVDE_SPRTE_AJUSTE_DDL.sql'
\i 'src/Objetos_BD/Functions/GCTFN186_REGISTRAR_VALOR_INDCDR_EQUIPE_AJUSTE_DDL.sql'
\i 'src/Objetos_BD/Functions/GCTFN180_INDCDR_PRODUTIVIDADE_AJUSTE_DDL.sql'
\i 'src/Objetos_BD/Functions/GCTFN181_INDCDR_REDUCAO_DEFEITOS_AJUSTE_DDL.sql'
\i 'src/Objetos_BD/Functions/GCTFN182_INDCDR_NOTA_CODIGO_AJUSTE_DDL.sql'
\i 'src/Objetos_BD/Functions/GCTFN183_INDCDR_QUALIDADE_AJUSTE_DDL.sql'
\i 'src/Objetos_BD/Functions/GCTFN184_INDCDR_TURNOVER_EQPE_AJUSTE_DDL.sql'
\i 'src/Objetos_BD/Functions/GCTFN185_CALCULAR_FATOR_NIVEL_SERVICO_AJUSTE_DDL.sql'

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

-- select count(*) from gct.gcttb264_amsta_equipe where nu_ajuste = (select max(nu_ajuste) from gct.gcttb184_ajuste_agil);
-- select count(*) from gct.gcttb266_amsta_slctco_equipe where nu_ajuste = (select max(nu_ajuste) from gct.gcttb184_ajuste_agil);
-- select count(*) from gct.gcttb267_amsta_ciclo_trabalho where nu_ajuste = (select max(nu_ajuste) from gct.gcttb184_ajuste_agil);
-- select count(*) from gct.gcttb265_amsta_solicitacao where nu_ajuste = (select max(nu_ajuste) from gct.gcttb184_ajuste_agil);
-- select count(*) from gct.gcttb268_amsta_membros_equipe where nu_ajuste = (select max(nu_ajuste) from gct.gcttb184_ajuste_agil);

select ti.nu_tipo_indicador, ti.sg_tipo_indicador, vie.nu_fatura, vie.nu_equipe, vie.vr_calculo_indicador, vie.vr_faixa_fns, vie.dt_referencia, vie.nu_ajuste
from gct.gcttb172_valor_indicador_equipe vie
inner join gct.gcttb112_tipo_indicador ti on ti.nu_tipo_indicador = vie.nu_tipo_indicador
where nu_equipe=3063 
--and nu_tipo_indicador=38 
and dt_referencia='2025-08-20'
order by vie.nu_tipo_indicador;

select 
  te.co_termo, te.nu_situacao_termo, f.dt_final_fatura, te.vr_financeiro_termo
from
  gct.gcttb087_equipe e
  inner join gct.gcttb170_termo_equipe te on te.nu_equipe = e.nu_equipe and te.nu_tipo_termo in (11,12,21)
  inner join gct.gcttb102_fatura f on f.nu_fatura = te.nu_fatura_gerada
where
  e.co_equipe = 'BRE202500324';

commit;
EOF

../expsql /tmp/ajuste_${CO_EQUIPE}.sql

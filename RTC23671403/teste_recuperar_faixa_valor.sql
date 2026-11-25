\i 'src/Objetos_BD/Functions/GCTFN120_RECUPERAR_VALOR_FAIXA_DDL.sql'

begin;

-- select gct.gctfn120_recuperar_valor_faixa(204, 10, 39, 0.0000000000000000000000000);
-- 7070 1149 37 0.85714285714285714286 S

select
  e.nu_equipe,
  e.nu_contrato,
  e.nu_tipo_grupo,
  f.nu_fatura,
  f.dt_final_fatura,
  ti.nu_tipo_indicador,
  ti.sg_tipo_indicador,
  ti.no_tipo_indicador,
  gi.vr_peso_tipo_indicador
from
  gct.gcttb175_amostra_equipe e
  inner join gct.gcttb033_grupo_contrato gc on (
    gc.nu_tipo_grupo = e.nu_tipo_grupo
    and gc.nu_contrato = e.nu_contrato
  )
  inner join gct.gcttb115_grupo_indicador gi on (
    gc.nu_contrato = gi.nu_contrato
    and gc.nu_tipo_grupo = gi.nu_tipo_grupo
  )
  inner join gct.gcttb112_tipo_indicador ti on ti.nu_tipo_indicador = gi.nu_tipo_indicador
  inner join gct.gcttb010_contrato c on c.nu_contrato = e.nu_contrato
  inner join gct.gcttb102_fatura f on f.nu_fatura = e.nu_fatura_amostra
where
  gi.nu_tipo_indicador = 37 --p_nu_tipo_indicador
  and e.nu_equipe = 7070 --p_nu_equipe
  and e.nu_fatura_amostra = 1149;

rollback;
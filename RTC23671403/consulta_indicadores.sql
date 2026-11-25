select
  c.nu_contrato, c.no_contrato, tg.nu_tipo_grupo, tg.no_tipo_grupo, ti.nu_tipo_indicador, ti.sg_tipo_indicador, ti.no_tipo_indicador
from 
  gct.gcttb010_contrato c
  inner join gct.gcttb033_grupo_contrato gc on gc.nu_contrato = c.nu_contrato
  inner join gct.gcttb032_tipo_grupo tg on tg.nu_tipo_grupo = gc.nu_tipo_grupo
  inner join gct.gcttb115_grupo_indicador gi on gi.nu_contrato = gc.nu_contrato and gi.nu_tipo_grupo = gc.nu_tipo_grupo
  inner join gct.gcttb112_tipo_indicador ti on ti.nu_tipo_indicador = gi.nu_tipo_indicador
where 
  c.nu_contrato = 204
order by
  c.nu_contrato, c.no_contrato, tg.nu_tipo_grupo, tg.no_tipo_grupo, ti.sg_tipo_indicador
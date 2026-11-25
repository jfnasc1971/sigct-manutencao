select
  distinct c.no_contrato,
  tg.no_tipo_grupo,
  e.co_equipe,
  s.co_solicitacao,
  s.de_tipo_solicitacao,
  ts.no_tipo_servico,
  sc.ic_bef_pode_ajustar_rubrica,
  s.de_tipo_solicitacao,
  s.co_solicitacao_bef,
  s.ic_bef,
  s.dh_avaliacao_bef,
  s.ic_pendente_atualizacao
from
  gct.gcttb005_solicitacao s
  inner join gct.gcttb086_solicitacao_equipe se on se.nu_solicitacao = s.nu_solicitacao
  inner join gct.gcttb087_equipe e on e.nu_equipe = se.nu_equipe
  inner join gct.gcttb010_contrato c on c.nu_contrato = e.nu_contrato
  inner join gct.gcttb032_tipo_grupo tg on tg.nu_tipo_grupo = e.nu_tipo_grupo
  inner join gct.gcttb033_grupo_contrato gc on gc.nu_tipo_grupo = e.nu_tipo_grupo and gc.nu_contrato = e.nu_contrato
  inner join gct.gcttb055_servico_contrato sc on sc.nu_contrato = gc.nu_contrato and sc.nu_tipo_grupo = gc.nu_tipo_grupo and sc.nu_tipo_servico = se.nu_tipo_servico
  inner join gct.gcttb015_tipo_servico ts on ts.nu_tipo_servico = se.nu_tipo_servico
where
  (
    s.dh_prevista :: date > '2025-09-20'
    or s.dh_efetiva > '2025-09-20'
  )
order by
  c.no_contrato,
  tg.no_tipo_grupo,
  e.co_equipe,
  s.co_solicitacao;
  
select 
  s.co_solicitacao, s.de_tipo_solicitacao, s.co_solicitacao_bef, s.ic_bef, s.dh_avaliacao_bef, s.ic_pendente_atualizacao
from 
  gct.gcttb005_solicitacao s
where  
 (s.dh_prevista::date > '2025-09-20' or s.dh_efetiva > '2025-09-20') 
 and  s.ic_bef = 'S';

select
  s.ic_pendente_atualizacao, 
  min(dh_processamento), 
  max(dh_processamento),
  max(dh_processamento) - min(dh_processamento), 
  extract(epoch from max(dh_processamento) - min(dh_processamento)) / count(*), 
  count(*) 
from 
  gct.gcttb005_solicitacao s
where
  (s.dh_prevista::date > '2025-09-20' or s.dh_efetiva > '2025-09-20')
group by
  s.ic_pendente_atualizacao
order by
  s.ic_pendente_atualizacao;

select
  s.ic_bef, 
  count(*) 
from 
  gct.gcttb005_solicitacao s
where
  (s.dh_prevista::date > '2025-09-20' or s.dh_efetiva > '2025-09-20')
group by
  s.ic_bef
order by
  s.ic_bef;

select
  count(*) 
from 
  gct.gcttb005_solicitacao s
where
  (s.dh_prevista::date > '2025-09-20' or s.dh_efetiva > '2025-09-20');

select
  count(*) 
from 
  gct.gcttb005_solicitacao s
where
  ic_pendente_atualizacao = 'S';
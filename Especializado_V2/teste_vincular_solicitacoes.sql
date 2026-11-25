begin;

delete from gct.gcttb086_solicitacao_equipe where nu_equipe = 3012;

insert into
  gct.gcttb086_solicitacao_equipe(
    nu_solicitacao_equipe,
    nu_equipe,
    nu_ciclo_trabalho,
    nu_solicitacao,
    nu_tipo_servico,
    nu_tamanho_servico,
    nu_acao_historico,
    nu_mtrca_acao_hstro,
    co_forma_vinculacao
  )
select
  nextval('gct.gctsq086_nu_solicitacao_equipe'),
  3012,
  1,
  s.nu_solicitacao,
  15,
  100 * random(),
  192,
  1,
  'M'
from
  gct.gcttb005_solicitacao s
where
  s.dh_prevista is not null
  and s.no_squad is not null
  and s.no_tipo_solicitacao = 'com.ibm.team.apt.workItemType.story'
  and s.de_tipo_manutencao = 'História de Usuário'
order by
  s.nu_solicitacao desc
limit
  15;

insert into
  gct.gcttb086_solicitacao_equipe(
    nu_solicitacao_equipe,
    nu_equipe,
    nu_ciclo_trabalho,
    nu_solicitacao,
    nu_tipo_servico,
    nu_tamanho_servico,
    nu_acao_historico,
    nu_mtrca_acao_hstro,
    co_forma_vinculacao
  )
select
  nextval('gct.gctsq086_nu_solicitacao_equipe'),
  3012,
  1,
  s.nu_solicitacao,
  18,
  0,
  192,
  1,
  'M'
from
  gct.gcttb005_solicitacao s
where
  s.dh_prevista is not null
  and s.no_squad is not null
  and s.no_tipo_solicitacao = 'com.ibm.team.apt.workItemType.story'
  and s.de_tipo_manutencao = 'Serviço'
order by
  s.nu_solicitacao desc
limit
  5;

--
--
--
delete from gct.gcttb086_solicitacao_equipe where nu_equipe = 3013;

insert into
  gct.gcttb086_solicitacao_equipe(
    nu_solicitacao_equipe,
    nu_equipe,
    nu_solicitacao,
    nu_tipo_servico,
    nu_acao_historico,
    nu_mtrca_acao_hstro,
    co_forma_vinculacao
  )
select
  nextval('gct.gctsq086_nu_solicitacao_equipe'),
  3013,
  s.nu_solicitacao,
  16,
  192,
  1,
  'M'
from
  gct.gcttb005_solicitacao s
where
  s.dh_prevista is not null
  and s.no_squad is not null
  and s.no_tipo_solicitacao = 'com.ibm.team.apt.workItemType.story'
  and s.de_tipo_manutencao = 'Defeito'
order by
  s.nu_solicitacao desc
limit
  25;

insert into
  gct.gcttb086_solicitacao_equipe(
    nu_solicitacao_equipe,
    nu_equipe,
    nu_solicitacao,
    nu_tipo_servico,
    nu_acao_historico,
    nu_mtrca_acao_hstro,
    co_forma_vinculacao
  )
select
  nextval('gct.gctsq086_nu_solicitacao_equipe'),
  3013,
  s.nu_solicitacao,
  16,
  192,
  1,
  'M'
from
  gct.gcttb005_solicitacao s
where
  s.dh_prevista is not null
  and s.no_squad is not null
  and s.no_tipo_solicitacao = 'com.ibm.team.apt.workItemType.story'
  and s.de_tipo_manutencao = 'Serviço'
order by
  s.nu_solicitacao desc
limit
  10;

commit;
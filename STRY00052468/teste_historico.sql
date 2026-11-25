begin;

delete from gct.gcttb086_solicitacao_equipe se where (se.nu_equipe, se.nu_ciclo_trabalho) in (
  select nu_equipe, nu_ciclo_trabalho from gct.gcttb088_ciclo_trabalho 
  where nu_equipe=2952 and co_sysid_servicenow is not null  
  and nu_ciclo_trabalho=21
);

delete from gct.gcttb308_historico_equipe where nu_equipe=2952 and nu_acao_historico=213;

INSERT INTO 
  gct.gcttb086_solicitacao_equipe ( 
    nu_solicitacao_equipe, 
    nu_equipe, 
    nu_solicitacao, 
    nu_tipo_servico, 
    co_forma_vinculacao, 
    nu_ciclo_trabalho, 
    nu_tamanho_servico, 
    nu_acao_historico, 
    nu_mtrca_acao_hstro 
  ) 
VALUES 
  (nextval('gct.gctsq086_nu_solicitacao_equipe'), 2952, 1519311, 
    938, 'A', 21, 0, 213, 1);

select
  he.*
from
  gct.gcttb087_equipe e
  inner join gct.gcttb308_historico_equipe he on he.nu_equipe = e.nu_equipe
where
  e.co_equipe = 'BRE202500133'
order by
  nu_historico_equipe desc;

rollback;
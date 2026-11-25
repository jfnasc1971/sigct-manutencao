alter table gct.gcttb005_solicitacao disable trigger all;
delete from gct.gcttb005_solicitacao s where co_sysid_servicenow is not null;
delete from gct.gcttb226_devolucao_solicitacao;
alter table gct.gcttb005_solicitacao enable trigger all;

select * from gct.gcttb226_devolucao_solicitacao

select * from gct.gcttb425_carga_service_now WHERE ic_avaliado='P' and item_type='rm_story'

select
  s.co_solicitacao,
  s.no_solicitacao,
  s.de_situacao_solicitacao,
  s.de_tipo_solicitacao,
  s.nu_situacao_solicitacao,
  s.no_sigla_sistema,
  s.dh_inicio,
  s.ic_bef,
  s.dh_prevista,
  s.dh_inicio_desenvolvimento,
  s.dh_efetiva,
  s.nu_mtrca_atribuicao,
  s.no_membro_atribuicao,
  s.dh_modificacao,
  s.no_squad
from
  gct.gcttb005_solicitacao s
where
  co_sysid_servicenow is not null


            select 
              * 
            from 
              gct.gcttb425_carga_service_now s 
            where 
              rm_type='rm_scrum_task'
              and ic_avaliado='P'

select max(nu_solicitacao) from gct.gcttb005_solicitacao

select nu_tipo_situacao_vinculacao from gct.gcttb005_solicitacao where nu_solicitacao >  1515579

select
  distinct a.parent
  --s.co_solicitacao,
  --s.de_tipo_solicitacao
from
  gct.gcttb425_carga_service_now a
  inner join gct.gcttb005_solicitacao s on a.parent = s.co_solicitacao
where
  rm_type = 'rm_scrum_task'
  and s.co_solicitacao = 'STRY00012916'

alter table gct.gcttb005_solicitacao disable trigger all;
delete from gct.gcttb005_solicitacao s where co_sysid_servicenow is not null;
delete from gct.gcttb005_solicitacao where co_solicitacao in (
'STRY00012916',
'STRY00013568',
'STRY00011458',
'STRY00012679'
);
delete from gct.gcttb226_devolucao_solicitacao;
alter table gct.gcttb005_solicitacao enable trigger all;





SELECT * FROM gct.gcttb005_solicitacao s where co_sysid_servicenow is not null and de_tipo_solicitacao is null;  
update gct.gcttb005_solicitacao set de_tipo_solicitacao='Manutenção Adaptativa' where co_sysid_servicenow is not null and de_tipo_solicitacao is null;

select * from gct.gcttb425_carga_service_now where item_number='STRY00012916';
select * from gct.gcttb425_carga_service_now where parent='STRY00012916'

update gct.gcttb425_carga_service_now set item_type='Manutenção Adaptativa'  where rm_type='rm_story' and item_type is null              


select * from gct.gcttb425_carga_service_now

select * from gct.gcttb076_acao_perfil where no_acao_perfil ilike '%solici%'

delete FROM gct.gcttb086_solicitacao_equipe where nu_equipe=10589;

INSERT INTO 
  gct.gcttb086_solicitacao_equipe ( 
    nu_solicitacao_equipe, 
    nu_equipe, 
    nu_solicitacao, 
    nu_tipo_servico, 
    co_forma_vinculacao, 
    nu_acao_historico, 
    nu_mtrca_acao_hstro 
  ) 
VALUES 
  (nextval('gct.gctsq086_nu_solicitacao_equipe'), :nuEquipe, :nuSolicitacao, :nuTipoServico, 'A', 1, 213) 

select     nu_solicitacao_equipe, 
    nu_equipe, 
    nu_solicitacao, 
    nu_tipo_servico, 
    co_forma_vinculacao, 
    nu_acao_historico, 
    nu_mtrca_acao_hstro  from gct.gcttb086_solicitacao_equipe where nu_equipe=10589;-- and nu_solicitacao=1522332

sb.append("UPDATE "); 
sb.append("  gct.gcttb086_solicitacao_equipe "); 
sb.append("SET "); 
sb.append("  nu_tipo_servico = :nuTipoServico, "); 
sb.append("  nu_acao_historico = 1, "); 
sb.append("  nu_mtrca_acao_hstro = 213 "); 
sb.append("WHERE "); 
sb.append("  nu_solicitacao_equipe = :nuSolicitacaoEquipe ");

  
select
  nu_solicitacao_equipe,
  nu_equipe,
  nu_solicitacao,
  nu_tipo_servico,
  co_forma_vinculacao,
  nu_acao_historico,
  nu_mtrca_acao_hstro
from
  gct.gcttb086_solicitacao_equipe se
where
  se.nu_solicitacao_equipe = 460

select * from gct.gcttb076_acao_perfil where nu_acao_perfil in (195,183,213)

select * from gct.gcttb425_carga_service_now where item_number in ('STRY00012916',
'STRY00012679',
'STRY00011458',
'STRY00013568',
'STRY00012916'
);

select ''''||PARENT||''',' from gct.gcttb425_carga_service_now where rm_type='rm_scrum_task';

update gct.gcttb425_carga_service_now a set assigned_to='JOSE FLAVIO LINS DO NASCIMENTO', assigned_to_employee_number=922063  where rm_type='rm_scrum_task';

select * from gct.gcttb038_unidade_caixa

update
  gct.gcttb425_carga_service_now
set
  item_type = 'Serviço Técnico Especializado',
  u_department = '5229-GECPA',
  eap_team = 'CL080'
where
  item_number in (
    'STRY00012916',
    'STRY00012679',
    'STRY00011458',
    'STRY00013568',
    'STRY00012916'
  );
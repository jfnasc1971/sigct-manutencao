drop view if exists gct.gct900_view_solicitacoes;

create view gct.gct900_view_solicitacoes as 
select 
  s.nu_tipo_grupo, s.nu_contrato, s.nu_tipo_indicador, sa.nu_situacao_atendimento, sa.no_situacao_atendimento, 'gcttb191_servico_entregue' as tabela
from
  gct.gcttb191_servico_entregue s
  inner join gct.gcttb092_situacao_atendimento sa on sa.no_situacao_atendimento IN (
    --'Rascunho',
    --'Preparado',
    --'Trabalho em andamento',
    --'Pronto para testes',
    --'Testando',
    'Pronto',
    'Concluído',
    --'Cancelada',
    --'Adiado',
    'Rejeitado'
  )
where 
  not exists (
    select null
      from gct.gcttb191_servico_entregue s1
     where s1.nu_contrato = s.nu_contrato
       and s1.nu_tipo_grupo = s.nu_tipo_grupo
       and s1.nu_situacao_atendimento = sa.nu_situacao_atendimento
  )
group by
  s.nu_tipo_grupo, s.nu_contrato, s.nu_tipo_indicador, sa.nu_situacao_atendimento, sa.no_situacao_atendimento  
union
select
  s.nu_tipo_grupo, s.nu_contrato, s.nu_tipo_indicador, sa.nu_situacao_atendimento, sa.no_situacao_atendimento, 'gcttb192_servico_contratado' as tabela
from 
  gct.gcttb192_servico_contratado s
  inner join gct.gcttb092_situacao_atendimento sa on sa.no_situacao_atendimento IN (
    'Preparado',
    'Trabalho em andamento',
    'Pronto para testes',
    'Testando',
    'Pronto',
    'Concluído',
    'Rejeitado'
  )
where 
  not exists (
    select null
      from gct.gcttb192_servico_contratado s1
     inner join gct.gcttb092_situacao_atendimento sa1 on sa1.nu_situacao_atendimento = s1.nu_situacao_atendimento 
     where s1.nu_contrato = s.nu_contrato
       and s1.nu_tipo_grupo = s.nu_tipo_grupo
       and sa1.no_situacao_atendimento = sa.no_situacao_atendimento
  )
  --and sa.no_situacao_atendimento='Testando'
  --and s.nu_contrato = 201
group by
  s.nu_tipo_grupo, s.nu_contrato, s.nu_tipo_indicador, sa.nu_situacao_atendimento, sa.no_situacao_atendimento
union
select
  s.nu_tipo_grupo, s.nu_contrato, s.nu_tipo_indicador, sa.nu_situacao_atendimento, sa.no_situacao_atendimento, 'gcttb193_servico_atraso' as tabela
from 
  gct.gcttb193_servico_atraso s
  inner join gct.gcttb092_situacao_atendimento sa on sa.no_situacao_atendimento IN (
    --'Rascunho',
    --'Preparado',
    --'Trabalho em andamento',
    --'Pronto para testes',
    --'Testando',
    'Pronto',
    'Concluído',
    --'Cancelada',
    --'Adiado',
    'Rejeitado'
  )
where 
  not exists (
    select null
      from gct.gcttb193_servico_atraso s1
     where s1.nu_contrato = s.nu_contrato
       and s1.nu_tipo_grupo = s.nu_tipo_grupo
       and s1.nu_situacao_atendimento = sa.nu_situacao_atendimento)
group by
  s.nu_tipo_grupo, s.nu_contrato, s.nu_tipo_indicador, sa.nu_situacao_atendimento, sa.no_situacao_atendimento  
union
select
  s.nu_tipo_grupo, s.nu_contrato, s.nu_tipo_indicador, sa.nu_situacao_atendimento, sa.no_situacao_atendimento, 'gcttb194_servico_devolvido' as tabela
from 
  gct.gcttb194_servico_devolvido s
  inner join gct.gcttb092_situacao_atendimento sa on sa.no_situacao_atendimento IN (
    --'Rascunho',
    --'Preparado',
    --'Trabalho em andamento',
    --'Pronto para testes',
    --'Testando',
    'Pronto',
    'Concluído',
    --'Cancelada',
    --'Adiado',
    'Rejeitado'
  )
where 
  not exists (
    select null
      from gct.gcttb194_servico_devolvido s1
     where s1.nu_contrato = s.nu_contrato
       and s1.nu_tipo_grupo = s.nu_tipo_grupo
       and s1.nu_situacao_atendimento = sa.nu_situacao_atendimento)
group by
  s.nu_tipo_grupo, s.nu_contrato, s.nu_tipo_indicador, sa.nu_situacao_atendimento, sa.no_situacao_atendimento ;
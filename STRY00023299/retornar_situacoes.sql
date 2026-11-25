select  
  'delete from gct.'|| tabela ||' where nu_tipo_grupo='||nu_tipo_grupo||' and nu_contrato='||
    nu_contrato||' and nu_tipo_indicador='||nu_tipo_indicador||' and nu_situacao_atendimento='||nu_situacao_atendimento||';' 
from (
select 
  distinct s.nu_tipo_grupo, s.nu_contrato, s.nu_tipo_indicador, sa.nu_situacao_atendimento, 'gcttb191_servico_entregue' as tabela
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
union
select
  distinct s.nu_tipo_grupo, s.nu_contrato, s.nu_tipo_indicador, sa.nu_situacao_atendimento, 'gcttb192_servico_contratado' as tabela
from 
  gct.gcttb192_servico_contratado s
  inner join gct.gcttb092_situacao_atendimento sa on sa.no_situacao_atendimento IN (
    --'Rascunho',
    'Preparado',
    'Trabalho em andamento',
    'Pronto para testes',
    'Testando',
    'Pronto',
    'Concluído',
    --'Cancelada',
    'Adiado',
    'Rejeitado'
  )
where 
  not exists (
    select null
      from gct.gcttb192_servico_contratado s1
     where s1.nu_contrato = s.nu_contrato
       and s1.nu_tipo_grupo = s.nu_tipo_grupo
       and s1.nu_situacao_atendimento = sa.nu_situacao_atendimento)
union
select
  distinct s.nu_tipo_grupo, s.nu_contrato, s.nu_tipo_indicador, sa.nu_situacao_atendimento, 'gcttb193_servico_atraso' as tabela
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
union
select
  distinct s.nu_tipo_grupo, s.nu_contrato, s.nu_tipo_indicador, sa.nu_situacao_atendimento, 'gcttb194_servico_devolvido' as tabela
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
) tb;  

select count(*) from gct.gcttb191_servico_entregue;
select count(*) from gct.gcttb192_servico_contratado;
select count(*) from gct.gcttb193_servico_atraso;
select count(*) from gct.gcttb194_servico_devolvido;       
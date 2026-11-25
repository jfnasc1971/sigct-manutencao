select
  distinct s.nu_tipo_grupo,
  s.nu_contrato,
  s.nu_tipo_indicador,
  sa.nu_situacao_atendimento,
  'gcttb192_servico_contratado' as tabela
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
    select
      null
    from
      gct.gcttb192_servico_contratado s1
    where
      s1.nu_contrato = s.nu_contrato
      and s1.nu_tipo_grupo = s.nu_tipo_grupo
      and s1.nu_situacao_atendimento = sa.nu_situacao_atendimento
  )
  and nu_contrato=205;

  select
  distinct s.nu_tipo_grupo, s.nu_contrato, s.nu_tipo_indicador, sa.nu_situacao_atendimento, 'gcttb192_servico_contratado' as tabela, sa.no_situacao_atendimento
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
       and s1.nu_situacao_atendimento = sa.nu_situacao_atendimento);

alter table gct.gcttb092_situacao_atendimento add nu_ordenacao numeric;

select 'update gct.gcttb092_situacao_atendimento set nu_ordenacao= where nu_situacao_atendimento='|| nu_situacao_atendimento || '; --' || no_situacao_atendimento 
from gct.gcttb092_situacao_atendimento where ic_origem_rtc='S';

select * from gct.gcttb092_situacao_atendimento where ic_origem_rtc='S';


select * from gct.gcttb192_servico_contratado where nu_contrato=205 
and nu_tipo_grupo=10 and nu_tipo_indicador = 36 and nu_situacao_atendimento=602


select
  'delete from gct.gcttb174_grupo_indicador_situacao where '||
  'nu_tipo_grupo=' || nu_tipo_grupo || ' and ' ||
  'nu_contrato=' || nu_contrato || ' and ' ||
  'nu_tipo_indicador=' || nu_tipo_indicador || ' and ' ||
  'nu_situacao_atendimento=' || nu_situacao_atendimento || ' and ' ||
  'no_situacao_atendimento=' || quote_literal(no_situacao_atendimento) || ';'
from
  (
    select
      distinct nu_tipo_grupo,
      nu_contrato,
      nu_tipo_indicador,
      sa.nu_situacao_atendimento,
      s.no_situacao_atendimento
    from
      gct.gcttb174_grupo_indicador_situacao s
      inner join gct.gcttb092_situacao_atendimento sa on sa.no_situacao_atendimento IN (
        --'Rascunho',
        'Preparado',
        'Trabalho em andamento',
        'Pronto para testes',
        'Testando',
        'Pronto',
        'Concluído',
        --'Cancelada',
        --'Adiado',
        'Rejeitado'
      )
    where
      not exists (
        select
          null
        from
          gct.gcttb174_grupo_indicador_situacao s1
        where
          s1.nu_contrato = s.nu_contrato
          and s1.nu_tipo_grupo = s.nu_tipo_grupo
          and s1.nu_situacao_atendimento = sa.nu_situacao_atendimento
          and s1.no_situacao_atendimento = s.no_situacao_atendimento
      )
  ) tb
order by
  1;



select
  'insert into gct.gcttb174_grupo_indicador_situacao values('||
  'nextval(' || quote_literal('gct.gctsq174_nu_grupo_situacao') || '),' ||
  nu_tipo_grupo || ',' ||
  nu_contrato || ',' ||
  nu_tipo_indicador || ',' ||
  nu_situacao_atendimento || ',' ||
  quote_literal(no_situacao_atendimento) || ');'
from
  (
    select
      distinct nu_tipo_grupo,
      nu_contrato,
      nu_tipo_indicador,
      sa.nu_situacao_atendimento,
      s.no_situacao_atendimento
    from
      gct.gcttb174_grupo_indicador_situacao s
      inner join gct.gcttb092_situacao_atendimento sa on sa.no_situacao_atendimento IN (
        --'Rascunho',
        'Preparado',
        'Trabalho em andamento',
        'Pronto para testes',
        'Testando',
        'Pronto',
        'Concluído',
        --'Cancelada',
        --'Adiado',
        'Rejeitado'
      )
    where
      not exists (
        select
          null
        from
          gct.gcttb174_grupo_indicador_situacao s1
        where
          s1.nu_contrato = s.nu_contrato
          and s1.nu_tipo_grupo = s.nu_tipo_grupo
          and s1.nu_situacao_atendimento = sa.nu_situacao_atendimento
          and s1.no_situacao_atendimento = s.no_situacao_atendimento
      )
  ) tb
order by
  1;


select * from GCT.gcttb174_grupo_indicador_situacao

select 
  distinct s.nu_tipo_grupo, s.nu_contrato, s.nu_tipo_indicador, sa.nu_situacao_atendimento
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
  );

select c.no_contrato, * from gct.gcttb191_servico_entregue s
inner join gct.gcttb010_contrato c on c.nu_contrato =s.nu_contrato
where current_date between c.dt_inicio_compromisso and c.dt_final_compromisso

select * from gct.gcttb191_servico_entregue
except
select * from gct.gcttb191_servico_entregue_bkp;

select * from gct.gcttb192_servico_contratado
except
select * from gct.gcttb192_servico_contratado_bkp;

select * from gct.gcttb193_servico_atraso
except
select * from gct.gcttb193_servico_atraso_bkp;

select * from gct.gcttb194_servico_devolvido
except
select * from gct.gcttb194_servico_devolvido_bkp;

select * from gct.gcttb174_grupo_indicador_situacao
except
select * from gct.gcttb174_grupo_indicador_situacao_bkp;


create table gct.gcttb174_grupo_indicador_situacao_bkp as select * from gct.gcttb174_grupo_indicador_situacao

select 
  distinct 'delete from gct.gcttb191_servico_entregue where nu_tipo_grupo='||s.nu_tipo_grupo||' and nu_contrato='||
    s.nu_contrato||' and nu_tipo_indicador='||s.nu_tipo_indicador||' and nu_situacao_atendimento='||sa.nu_situacao_atendimento||');'
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
order by
  1;

select * from gct.gcttb005_solicitacao

select
  *
from
  gct.gcttb092_situacao_atendimento sa
where
  sa.no_situacao_atendimento ilike 'Trabalho%';

--
update gct.gcttb092_situacao_atendimento set no_situacao_atendimento='Pronto para Teste' where nu_situacao_atendimento=603;
update gct.gcttb092_situacao_atendimento set no_situacao_atendimento='Trabalho em Andamento' where nu_situacao_atendimento=602;

--
update gct.gcttb092_situacao_atendimento set no_situacao_atendimento='Pronto para testes' where nu_situacao_atendimento=603;
update gct.gcttb092_situacao_atendimento set no_situacao_atendimento='Trabalho em andamento' where nu_situacao_atendimento=602;

select
  *
from
  gct.gcttb092_situacao_atendimento sa
where
  sa.no_situacao_atendimento in (
'Rascunho',
'Preparado',
'Trabalho em andamento',
'Pronto para testes',
'Testando',
'Pronto',
'Concluído',
'Cancelada',
'Adiado',
'Rejeitado'
  )  

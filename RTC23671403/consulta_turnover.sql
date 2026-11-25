select
  count(*)
from
  gct.gcttb419_vigencia_membros_equipe vme
  inner join gct.gcttb418_membros m on m.nu_membro = vme.nu_membro
  inner join gct.gcttb087_equipe e on e.nu_equipe = vme.nu_equipe
where
  vme.dt_fim_membro between current_date - 3 * interval '1 month' and current_date
  and e.nu_contrato = (select nu_contrato from gct.gcttb087_equipe where nu_equipe = 7028)
  and not exists (
    select
      null
    from
      gct.gcttb419_vigencia_membros_equipe vme1
      inner join gct.gcttb418_membros m1 on m1.nu_membro = vme1.nu_membro
      inner join gct.gcttb087_equipe e1 on e1.nu_equipe = vme1.nu_equipe
    where
      vme1.dt_fim_membro is null
      and e1.nu_contrato = e.nu_contrato
      and m1.nu_matricula = m.nu_matricula
  );

select
  count(*)
from
  gct.gcttb419_vigencia_membros_equipe vme
  inner join gct.gcttb418_membros m on m.nu_membro = vme.nu_membro
  inner join gct.gcttb087_equipe e on e.nu_equipe = vme.nu_equipe
where
  vme.dt_fim_membro is null
  and e.nu_contrato = (select nu_contrato from gct.gcttb087_equipe where nu_equipe = 7028)
; 
\q
select
  vme.nu_equipe,
  vme.nu_membro,
  m.nu_matricula,
  m.no_membro,
  vme.nu_perfil,
  vme.dt_inicio_membro,
  vme.dt_fim_membro,
  current_date - 3 * interval '1 month'
from
  gct.gcttb419_vigencia_membros_equipe vme
  inner join gct.gcttb418_membros m on m.nu_membro = vme.nu_membro
  inner join gct.gcttb087_equipe e on e.nu_equipe = vme.nu_equipe
where
  vme.dt_fim_membro between current_date - 3 * interval '1 month' and current_date
  and e.nu_contrato = (select nu_contrato from gct.gcttb087_equipe where nu_equipe = 7028)
  and not exists (
    select
      null
    from
      gct.gcttb419_vigencia_membros_equipe vme1
      inner join gct.gcttb418_membros m1 on m1.nu_membro = vme1.nu_membro
      inner join gct.gcttb087_equipe e1 on e1.nu_equipe = vme1.nu_equipe
    where
      vme1.dt_fim_membro is null
      and e1.nu_contrato = e.nu_contrato
      and m1.nu_matricula = m.nu_matricula
  );

select
  vme.nu_equipe,
  vme.nu_membro,
  m.nu_matricula,
  m.no_membro,
  vme.nu_perfil,
  vme.dt_inicio_membro,
  vme.dt_fim_membro,
  current_date
from
  gct.gcttb419_vigencia_membros_equipe vme
  inner join gct.gcttb418_membros m on m.nu_membro = vme.nu_membro
  inner join gct.gcttb087_equipe e on e.nu_equipe = vme.nu_equipe
where
  vme.dt_fim_membro is null
  and e.nu_contrato = (select nu_contrato from gct.gcttb087_equipe where nu_equipe = 7028)
; 
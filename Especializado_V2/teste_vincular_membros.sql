begin;

--
--
--
delete from gct.gcttb419_vigencia_membros_equipe where nu_equipe in (3013);
insert into gct.gcttb419_vigencia_membros_equipe
  select 
    nextval('gct.gctsq419_nu_vigencia_membro'), m.nu_membro, vme.nu_perfil, 3013, '2025-06-21'::date, null::date, 1, 1
  from 
    gct.gcttb251_vgnca_mbro_eqpe_epzdo vme 
    inner join gct.gcttb418_membros m on m.nu_membro = vme.nu_membro
  where 
    vme.nu_contrato=106
    and vme.nu_tipo_grupo=11;

delete from gct.gcttb523_qntde_membro_equipe_perfil where nu_equipe in (3013);
insert into gct.gcttb523_qntde_membro_equipe_perfil
select vme.nu_equipe, vme.dt_inicio_membro, vme.nu_perfil, null::date,count(*), 182, 1, current_timestamp, null, 'BR', 1 
from gct.gcttb419_vigencia_membros_equipe vme where nu_equipe=3013
group by vme.nu_equipe, vme.nu_perfil, vme.dt_inicio_membro;

--
--
--
delete from gct.gcttb419_vigencia_membros_equipe where nu_equipe in (3012);
insert into gct.gcttb419_vigencia_membros_equipe
  select 
    nextval('gct.gctsq419_nu_vigencia_membro'), m.nu_membro, vme.nu_perfil, 3012, '2025-06-21'::date, null::date, 1, 1
  from 
    gct.gcttb251_vgnca_mbro_eqpe_epzdo vme 
    inner join gct.gcttb418_membros m on m.nu_membro = vme.nu_membro
  where 
    vme.nu_contrato=106
    and vme.nu_tipo_grupo=10;

delete from gct.gcttb523_qntde_membro_equipe_perfil where nu_equipe in (3012);
insert into gct.gcttb523_qntde_membro_equipe_perfil
select vme.nu_equipe, vme.dt_inicio_membro, vme.nu_perfil, null::date,count(*), 182, 1, current_timestamp, null, 'BR', 1 
from gct.gcttb419_vigencia_membros_equipe vme where nu_equipe=3012
group by vme.nu_equipe, vme.nu_perfil, vme.dt_inicio_membro;

commit;
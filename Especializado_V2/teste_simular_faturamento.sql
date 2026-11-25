select pp.de_perfil, 'F'||m.nu_matricula co_matricula, m.no_membro, p.vr_preco_grupo,
20/gct.gctfn305_dias_entre_data(vme.dt_inicio_membro, '2025-07-20'::Date, 'BR', 'U'),
(20/gct.gctfn305_dias_entre_data(vme.dt_inicio_membro, '2025-07-20'::Date, 'BR', 'U'))*p.vr_preco_grupo
from gct.gcttb087_equipe e
inner join gct.gcttb419_vigencia_membros_equipe vme on vme.nu_equipe = e.nu_equipe
inner join gct.gcttb418_membros m on m.nu_membro = vme.nu_membro
inner join gct.gcttb521_perfil_profissional pp on pp.nu_perfil = vme.nu_perfil
inner join gct.gcttb524_preco_cntrto_equipe_perfil p on p.nu_contrato = e.nu_contrato and p.nu_tipo_grupo=e.nu_tipo_grupo and p.nu_perfil=vme.nu_perfil
where e.co_equipe='BRE202500171';

select sum((20/gct.gctfn305_dias_entre_data(vme.dt_inicio_membro, '2025-07-20'::Date, 'BR', 'U'))*p.vr_preco_grupo)
from gct.gcttb087_equipe e
inner join gct.gcttb419_vigencia_membros_equipe vme on vme.nu_equipe = e.nu_equipe
inner join gct.gcttb418_membros m on m.nu_membro = vme.nu_membro
inner join gct.gcttb521_perfil_profissional pp on pp.nu_perfil = vme.nu_perfil
inner join gct.gcttb524_preco_cntrto_equipe_perfil p on p.nu_contrato = e.nu_contrato and p.nu_tipo_grupo=e.nu_tipo_grupo and p.nu_perfil=vme.nu_perfil
where e.co_equipe='BRE202500171';

select pp.de_perfil, 'F'||m.nu_matricula co_matricula, m.no_membro, p.vr_preco_grupo,
20/gct.gctfn305_dias_entre_data(vme.dt_inicio_membro, '2025-07-20'::Date, 'BR', 'U'),
(20/gct.gctfn305_dias_entre_data(vme.dt_inicio_membro, '2025-07-20'::Date, 'BR', 'U'))*p.vr_preco_grupo
from gct.gcttb087_equipe e
inner join gct.gcttb419_vigencia_membros_equipe vme on vme.nu_equipe = e.nu_equipe
inner join gct.gcttb418_membros m on m.nu_membro = vme.nu_membro
inner join gct.gcttb521_perfil_profissional pp on pp.nu_perfil = vme.nu_perfil
inner join gct.gcttb524_preco_cntrto_equipe_perfil p on p.nu_contrato = e.nu_contrato and p.nu_tipo_grupo=e.nu_tipo_grupo and p.nu_perfil=vme.nu_perfil
where e.co_equipe='BRE202500172';

select sum((20/gct.gctfn305_dias_entre_data(vme.dt_inicio_membro, '2025-07-20'::Date, 'BR', 'U'))*p.vr_preco_grupo)
from gct.gcttb087_equipe e
inner join gct.gcttb419_vigencia_membros_equipe vme on vme.nu_equipe = e.nu_equipe
inner join gct.gcttb418_membros m on m.nu_membro = vme.nu_membro
inner join gct.gcttb521_perfil_profissional pp on pp.nu_perfil = vme.nu_perfil
inner join gct.gcttb524_preco_cntrto_equipe_perfil p on p.nu_contrato = e.nu_contrato and p.nu_tipo_grupo=e.nu_tipo_grupo and p.nu_perfil=vme.nu_perfil
where e.co_equipe='BRE202500172';
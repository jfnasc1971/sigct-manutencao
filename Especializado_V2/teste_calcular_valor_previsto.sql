\i 'src/Objetos_BD/Functions/GCTFN450_CALCULAR_VALOR_EQUIPE_DDL.sql'
\i 'src/Objetos_BD/Functions/GCTFN400_CALCULAR_VALOR_EQUIPE_PERFIL_DDL.sql'

begin;

select e.co_equipe, gct.gctfn450_calcular_valor_equipe(e.nu_equipe) from gct.gcttb087_equipe e where e.co_equipe='BRE202500171';
select e.co_equipe, gct.gctfn450_calcular_valor_equipe(e.nu_equipe) from gct.gcttb087_equipe e where e.co_equipe='BRE202500172';

commit;
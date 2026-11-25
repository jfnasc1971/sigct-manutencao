\i 'src/Objetos_BD/Functions/GCTFN137_OBTER_DT_CONSIDERAR_FNS_EQUIPE_DDL.sql' 

begin;

\i 'atualiza_data_inicio_desenvolvimento.sql'

--
--
--
alter table gct.gcttb087_equipe drop column if exists dt_considerar_fns;
alter table gct.gcttb087_equipe add column dt_considerar_fns date;

--
--
--
update gct.gcttb087_equipe set dt_considerar_fns = null;
delete from gct.gcttb308_historico_equipe where nu_acao_historico in (216,217);
delete from gct.gcttb076_acao_perfil where nu_acao_perfil = 216;
delete from gct.gcttb076_acao_perfil where nu_acao_perfil = 217;

--
--
--
INSERT INTO gct.gcttb076_acao_perfil VALUES (216,'Registrar Data Considerar FNS','S',39,'S',null);
INSERT INTO gct.gcttb076_acao_perfil VALUES (217,'Alterar Data Considerar FNS','S',39,'S',null);

select e.co_equipe, dt_considerar_fns, gct.gctfn137_obter_dt_considerar_fns_equipe(e.nu_equipe) 
from gct.gcttb087_equipe e 
where e.nu_contrato between 201 and 206;

select e.nu_equipe, e.co_equipe, e.dt_inicio_atendimento, e.dt_considerar_fns, e.dt_considerar_fns - e.dt_inicio_atendimento 
from gct.gcttb087_equipe e 
where e.nu_contrato between 201 and 206
and dt_considerar_fns is not null;

commit;
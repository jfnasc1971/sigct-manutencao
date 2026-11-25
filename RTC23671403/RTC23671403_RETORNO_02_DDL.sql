begin;

--
-- RTC 23671403 - SIGCT - Indicadores do contrato especializado
--

--
-- INICIO
--

--
--
--
drop index if exists gct.ix_gcttb264_1;
drop index if exists gct.ix_gcttb265_1;
drop index if exists gct.ix_gcttb266_1;
drop index if exists gct.ix_gcttb267_1;
drop index if exists gct.ix_gcttb268_1;
DROP INDEX if exists gct.ix_gcttb170_6;

--
-- TABELAS
--
DROP TABLE if exists gct.gcttb319_hstrco_nota_codigo;
DROP TABLE if exists gct.gcttb263_nota_codigo;
DROP TABLE if exists gct.gcttb264_amsta_equipe;
DROP TABLE if exists gct.gcttb265_amsta_solicitacao;
DROP TABLE if exists gct.gcttb266_amsta_slctco_equipe;
DROP TABLE if exists gct.gcttb267_amsta_ciclo_trabalho;
DROP TABLE if exists gct.gcttb268_amsta_membros_equipe;
DROP TABLE if exists gct.gcttb269_valor_indicador_contratada;
DROP TABLE if exists gct.gcttb283_agendamento_indicador;;

alter table gct.gcttb115_grupo_indicador drop column if exists ic_compoe_fns;
alter table gct.gcttb005_solicitacao drop column if exists dh_inicio_desenvolvimento;
alter table gct.gcttb087_equipe drop column if exists dt_considerar_fns;
alter table gct.gcttb172_valor_indicador_equipe drop column if exists dt_inicio_indicador; 
alter table gct.gcttb172_valor_indicador_equipe drop column if exists dt_final_indicador;  

--
--
--
DROP SEQUENCE if exists gct.gctsq269_nu_valor_indicador;

--
-- FIM
--

commit;

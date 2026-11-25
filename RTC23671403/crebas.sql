drop table if exists gct.gcttb264_amsta_equipe         ;
drop table if exists gct.gcttb265_amsta_solicitacao    ;
drop table if exists gct.gcttb266_amsta_slctco_equipe  ;
drop table if exists gct.gcttb267_amsta_ciclo_trabalho ;

create table gct.gcttb264_amsta_equipe         as select null::date dt_referencia, *, current_timestamp dt_modificacao from gct.gcttb087_equipe limit 1;
create table gct.gcttb265_amsta_solicitacao    as select null::date dt_referencia, *, current_timestamp dt_modificacao from gct.gcttb005_solicitacao limit 1;
create table gct.gcttb266_amsta_slctco_equipe  as select null::date dt_referencia, *, current_timestamp dt_modificacao from gct.gcttb086_solicitacao_equipe limit 1;
create table gct.gcttb267_amsta_ciclo_trabalho as select null::date dt_referencia, *, current_timestamp dt_modificacao from gct.gcttb088_ciclo_trabalho limit 1;

\d gct.gcttb264_amsta_equipe
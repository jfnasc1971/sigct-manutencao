--
-- gct.gcttb425_carga_service_now
--
drop table if exists gct.gcttb425_carga_service_now;

create table gct.gcttb425_carga_service_now (
    nu_controle_carga             numeric not null, 
    sys_id                        varchar(50) not null,
    rm_type                       varchar(50),
    u_department                  varchar(100),
    item_number                   varchar(50),
    parent_sys_id                 varchar(32),
    parent                        varchar(50),
    short_description             varchar(1000),
    item_type                     varchar(100),
    item_state                    varchar(100),
    cmdb_ci                       varchar(250),
    cmdb_ci_number                varchar(50),
    cmdb_ci_correlation_id        varchar(50),
    start_date                    timestamp,
    end_date                      timestamp,
    work_start                    timestamp,
    work_end                      timestamp,
    u_last_ready_state_update     timestamp,
    u_last_return_ready_state     timestamp,
    sys_updated_on                timestamp,
    eap_team                      varchar(200),
    u_capex_criteria              varchar(200),
    iteration_sys_id              varchar(32),
    iteration                     varchar(500),
    iteration_start_date          timestamp,
    iteration_end_date            timestamp,
    assigned_to_employee_number   varchar(50),
    assigned_to                   varchar(200),
    sys_created_on                timestamp,
    ic_avaliado                   char(1) default 'P',
    de_resultado_avaliacao        varchar(20000),
    dh_avaliacao                  timestamp,
    constraint pk_gcttb425 primary key(nu_controle_carga, sys_id)
);

alter table gct.gcttb425_carga_service_now owner to gct;

-- Table: gct.gcttb426_validacao_service_now

DROP TABLE if exists gct.gcttb426_erro_vinculacao;

CREATE TABLE gct.gcttb426_erro_vinculacao (
  nu_controle_carga numeric NOT null,
  co_solicitacao character varying(50) NOT null,
  co_servicenow character varying(50),
  co_mensagem_erro character varying(20),
  de_mensagem_erro character varying(500),
  dh_registro_erro timestamp with time zone NOT null default current_timestamp,
  constraint pk_gcttb426 primary key(nu_controle_carga, co_solicitacao, co_mensagem_erro)
);

ALTER TABLE gct.gcttb426_erro_vinculacao OWNER TO gct;

-- Table: gct.gcttb427_sprint_service_now

DROP TABLE if exists  gct.gcttb427_iteracao_service_now;

CREATE TABLE gct.gcttb427_iteracao_service_now (
  iteration_sys_id character varying(50) not null,
  iteration character varying(500),
  iteration_start_date timestamp without time zone,
  iteration_end_date timestamp without time zone,
  constraint pk_gcttb427 primary key(iteration_sys_id)
);

ALTER TABLE gct.gcttb427_iteracao_service_now OWNER TO gct;


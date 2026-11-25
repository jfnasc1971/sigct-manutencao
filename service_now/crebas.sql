drop table if exists gct.gcttb425_carga_service_now;

create table gct.gcttb425_carga_service_now (
    nu_controle_carga             numeric not null, 
    sys_id                        varchar(50) not null,
    rm_type                       varchar(50),
    u_department                  varchar(100),
    item_number                   varchar(50),
    short_description             varchar(1000),
    item_type                     varchar(100),
    item_state                    varchar(100),
    cmdb_ci                       varchar(500),
    start_date                    timestamp,
    end_date                      timestamp,
    work_start                    timestamp,
    work_end                      timestamp,
    u_last_ready_state_update     timestamp,
    u_last_return_ready_state     timestamp,
    sys_updated_on                timestamp,
    eap_team                      varchar(200),
    u_capex_criteria              varchar(200),
    iteration                     varchar(500),
    iteration_start_date          date,
    iteration_end_date            date,
    assigned_to_employee_number   varchar(50),
    assigned_to                   varchar(200),
    sys_created_on                timestamp,
    ic_avaliado                   char(1) default 'P',
    constraint pk_gcttb425 primary key(nu_controle_carga, sys_id)
);

alter table gct.gcttb425_carga_service_now owner to gct;
begin;

do
$$
declare

  item record;

  v_nu_unidade_custo numeric;
  v_nu_natural_custo numeric;
  v_nu_situacao_atendimento numeric;
  v_no_situacao_atendimento varchar;
  v_no_sigla_sistema varchar;

begin

  for item in (
    select
      nu_controle_carga,
      sys_id,
      rm_type,
      u_department, -- CENTRO DE CUSTO 5280-GEHPA nu_unidade_custo, nu_natural_custo
      item_number, -- co_solicitacao
      parent,
      short_description, -- no_solicitacao
      item_type, -- de_tipo_solicitacao
      item_state, -- nu_situacao_atendimento, no_situacao_atendimento
      cmdb_ci, -- no_sigla_sistema
      start_date,
      end_date,
      work_start,
      work_end,
      u_last_ready_state_update,
      u_last_return_ready_state,
      sys_updated_on,
      eap_team,
      u_capex_criteria,
      iteration_sys_id,
      iteration,
      iteration_start_date,
      iteration_end_date,
      assigned_to_employee_number,
      assigned_to,
      sys_created_on,
      ic_avaliado
    from
      gct.gcttb425_carga_service_now a
    where
      nu_controle_carga = 4618
      and rm_type = 'rm_story'
  )
  loop
    
    --
    -- CENTRO DE CUSTO
    -- "u_department" : "5229-GECPA",
    --
    select
      nu_unidade,
      nu_natural
    into
      v_nu_unidade_custo,
      v_nu_natural_custo
    from
      gct.gcttb038_unidade_caixa
    where
      nu_unidade :: text = trim(split_part(item.u_department, '-', 1));

    --
    -- SITUACAO
    --
    select
      nu_situacao_atendimento,
      no_situacao_atendimento
    into
      v_nu_situacao_atendimento,
      v_no_situacao_atendimento
    from
      gct.gcttb092_situacao_atendimento
    where
      no_situacao_atendimento = item.item_state;

    --
    -- SIGLA
    --
    select trim(split_part(item.cmdb_ci, '-', 1)) into v_no_sigla_sistema;

    raise notice '% % %', 
      item.u_department, v_nu_unidade_custo, v_nu_natural_custo;
    
    -- "u_last_ready_state_update" : "2026-08-25 15:22:56", -- Data pronto -- dh_efetiva
    -- "u_last_return_ready_state" : "2026-08-25 15:27:27", -- Data de devolução
    -- "eap_team" : "CL080",
    -- "u_capex_criteria" : null,
    -- "iteration" : "",
    -- "iteration.sys_id" : "",
    -- "iteration.state" : null,
    -- "iteration.start_date" : "",
    -- "iteration.end_date" : "",
    -- "assigned_to.employee_number" : "922063",
    -- "assigned_to" : "JOSE FLAVIO LINS DO NASCIMENTO",

    insert into gct.gcttb005_solicitacao (
      nu_solicitacao,
      nu_unidade_custo,
      nu_natural_custo,
      co_solicitacao,
      no_solicitacao,
      de_tipo_solicitacao,
      nu_situacao_solicitacao,
      de_situacao_solicitacao,
      no_sigla_sistema,
      dh_modificacao,
      dh_inicio,
      dh_prevista,
      dh_inicio_desenvolvimento,
      dh_resolucao,
      dh_cadastro,
      nu_sysid_servicenow
    )
    values(
      nextval('gct.gctsq005_nu_solicitacao'),
      v_nu_unidade_custo,
      v_nu_natural_custo,
      -- "number" : "STRY00013587",
      item.item_number,
      -- "short_description" : "SIGCT - Teste",
      item.short_description,
      -- "type" : "Serviço Técnico Especializado",
      item.item_type,
      -- "state" : "Pronto",
      v_nu_situacao_atendimento,
      v_no_situacao_atendimento,
      -- "cmdb_ci" : "SIGCT-Gestão de Serviços Terceirizados TI",
      -- "cmdb_ci.number" : "APM0002740",
      v_no_sigla_sistema,
      -- "sys_updated_on" : "2026-08-25 15:23:10", -- dh_modificacao
      item.sys_created_on::timestamp,
      -- "start_date" : "2026-08-24 00:00:00", -- Data de início planejada -- dh_inicio
      item.start_date::timestamp,
      -- "end_date" : "2026-09-20 15:21:32", -- Data de término planejada -- dh_prevista
      item.end_date::timestamp,
      -- "work_start" : "2026-08-24 15:21:21", -- Data de início real -- dh_inicio_desenvolvimento
      item.work_start::timestamp,
      -- "work_end" : "2026-08-25 15:23:04", -- Data de término real -- dh_resolucao
      item.work_end::timestamp,
      -- "sys_created_on" : "2026-08-25 15:20:45" -- Data criação -- dh_criacao
      item.sys_created_on::timestamp,
      -- "sys_id" : "7da19f2b3bfe87d0d6a4cb8693e45acb",
      item.sys_id
    );

  end loop;

end;
$$;

select
  nu_solicitacao,
  nu_unidade_custo,
  nu_natural_custo,
  co_solicitacao,
  no_solicitacao,
  de_tipo_solicitacao,
  nu_situacao_solicitacao,
  de_situacao_solicitacao,
  no_sigla_sistema,
  dh_modificacao,
  dh_inicio,
  dh_prevista,
  dh_inicio_desenvolvimento,
  dh_resolucao,
  dh_cadastro,
  nu_sysid_servicenow
from
  gct.gcttb005_solicitacao
where
  nu_sysid_servicenow is not null;
  
rollback;
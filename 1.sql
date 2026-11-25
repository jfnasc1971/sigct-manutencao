select
  distinct *
from
  (
    select
      distinct e.nu_equipe_epzdo as nu_equipe,
      e.co_equipe_epzdo as co_equipe,
      e.nu_situacao_atendimento as nu_situacao_equipe,
      e.nu_area_interna,
      ee.nu_tipo_grupo as nu_tipo_grupo,
      ee.nu_contrato as nu_contrato,
      cast(null as varchar) as co_sitio,
      cast(null as varchar) as de_equipe,
      cast(null as date) as dt_solicitacao_alocacao,
      cast(null as date) as dt_inicio_atendimento,
      cast(null as date) as dt_final_atendimento,
      cast(null as numeric) as vr_previsto_calculado,
      cast(null as date) as dh_inclusao_informacao,
      cast(null as numeric) as nu_acao_historico,
      cast(null as numeric) as nu_mtrca_acao_hstro,
      cast(null as varchar) as de_justificativa_alteracao,
      cast(null as date) as dt_considerar_fns
    from
      gct.gcttb250_equipe_epzdo e
      inner join gct.gcttb252_equipe_epzdo_cntro ee on ee.nu_equipe_epzdo = e.nu_equipe_epzdo
  ) e
  inner join gct.gcttb086_solicitacao_equipe se on se.nu_equipe = e.nu_equipe
  inner join gct.gcttb005_solicitacao so on so.nu_solicitacao = se.nu_solicitacao
  inner join gct.gcttb039_sistema s on s.sg_sistema = so.no_sigla_sistema
where
  1 = 1
  and e.nu_contrato in (:contratos)
  and s.nu_sistema in (:sistemas)
  and e.co_sitio in (:sitios)
order by
  e.co_equipe
select
  *,
  lo_export(
    im_empenho,
    --'/home/f922063/arquivos/empenhos' || no_arquivo
    '/projetos/caixa/sigct/Trabalho/RTC21743955/exportados' || no_arquivo
  )
from
  (
    select 
      coalesce(a.im_empenho_geral, a.im_empenho_agil_contratada) as im_empenho,
      case when c.ic_tipo_contratacao='E' then '/AGIL/' else '/TRADICIONAL/' end ||
      'Empenho_' || c.nu_contrato || '_' ||replace(c.co_contrato,'/','_')|| 
      '_' || f.co_sitio  ||
      '_' ||to_char(a.dh_criacao,'yyyy-MM-dd_hh24mi') || '.xls' as no_arquivo,
      a.dh_criacao,
      c.no_contrato,
      f.co_sitio
    from 
      gct.gcttb156_arquivo_empenho a
      inner join gct.gcttb010_contrato c on c.nu_contrato = a.nu_contrato
      inner join gct.gcttb102_fatura f on f.nu_fatura = a.nu_fatura
    where 
      1=1
      and a.nu_arquivo_empenho in (
        --select nu_arquivo_empenho --max(nu_arquivo_empenho) 
        select max(nu_arquivo_empenho) 
        from gct.gcttb156_arquivo_empenho a
        inner join gct.gcttb102_fatura f on f.nu_fatura = a.nu_fatura and f.dt_final_fatura='2024-03-20'
        group by a.nu_fatura, a.nu_contrato
      )
      --and a.nu_contrato = 719
    -- union  
    -- select 
    --   coalesce(a.im_empenho_geral, a.im_empenho_agil_contratada) as im_empenho,
    --   case when c.ic_tipo_contratacao='E' then '/AGIL/' else '/TRADICIONAL/' end ||
    --   'Empenho_' || c.nu_contrato || '_' ||replace(c.co_contrato,'/','_')|| 
    --   '_' || f.co_sitio  ||
    --   '_' ||to_char(a.dh_criacao,'yyyy-MM-dd_hh24mi') || '.xls' as no_arquivo,
    --   a.dh_criacao,
    --   c.no_contrato,
    --   f.co_sitio
    -- from 
    --   gct.gcttb156_arquivo_empenho a
    --   inner join gct.gcttb010_contrato c on c.nu_contrato = a.nu_contrato
    --   inner join gct.gcttb102_fatura f on f.nu_fatura = a.nu_fatura and f.dt_final_fatura='2024-03-20'
    -- where 
    --   1=1
    --   and a.dh_criacao::date = '2024-03-28'
    -- order by
    --   no_contrato, co_sitio
  ) tb;

-- select 
--   a.dh_criacao,
--   c.no_contrato,
--   f.co_sitio,
--   --coalesce(a.im_empenho_geral, a.im_empenho_agil_contratada) as im_empenho,
--   --case when c.ic_tipo_contratacao='E' then '/AGIL/' else '/TRADICIONAL/' end ||
--   'Empenho_' || c.nu_contrato || '_' ||replace(c.co_contrato,'/','_')|| 
--   '_' || f.co_sitio  ||
--   '_' ||to_char(a.dh_criacao,'yyyy-MM-dd_hh24mi') || '.xls' as no_arquivo
-- from 
--   gct.gcttb156_arquivo_empenho a
--   inner join gct.gcttb102_fatura f on f.nu_fatura = a.nu_fatura
--   inner join gct.gcttb010_contrato c on c.nu_contrato = a.nu_contrato
-- where 
--   a.nu_arquivo_empenho in (
--     select max(nu_arquivo_empenho) 
--     from gct.gcttb156_arquivo_empenho a
--     inner join gct.gcttb102_fatura f on f.nu_fatura = a.nu_fatura and f.dt_final_fatura='2024-03-20'
--     group by a.nu_fatura, a.nu_contrato
--   )
-- order by
--   c.no_contrato, f.co_sitio;  
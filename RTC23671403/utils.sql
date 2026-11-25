select * from gct.gcttb056_tipo_faixa where nu_tipo_faixa between 414 and 419;

select
  --ti.nu_tipo_indicador,
  ti.nu_tipo_indicador + 378 as nu_tipo_faixa,
  case 
    when ti.nu_tipo_indicador = 36 then 'Faixas indicador: '|| ti.no_tipo_indicador ||'(Desenvolvimento) - Contratos Especializados' 
    when ti.nu_tipo_indicador = 37 then 'Faixas indicador: '|| ti.no_tipo_indicador ||'(Suporte) - Contratos Especializados'
    else 'Faixas indicador: '|| ti.no_tipo_indicador ||' - Contratos Especializados'
  end as de_tipo_faixa,
  'D'::char as ic_forma_busca,
  'M'::char as ic_operacao,
  ti.sg_tipo_indicador ||' - '|| ti.de_tipo_indicador as de_observacao,
  111 as nu_acao_historico,
  1 as nu_mtrca_acao_hstro --,
  --ti.de_tipo_indicador
from
  gct.gcttb112_tipo_indicador ti
where
  ti.nu_tipo_indicador between 36 and 41;

select * from gct.gcttb056_tipo_faixa where nu_tipo_faixa=184

select a from generate_series(414,415) a where a not in (
  select nu_tipo_faixa from gct.gcttb056_tipo_faixa
)

select * from gct.gcttb056_tipo_faixa where nu_tipo_faixa=411;

select * from gct.gcttb057_valor_faixa;
select * from gct.gcttb131_tipo_faixa_indicador;
select * from gct.gcttb131_tipo_faixa_indicador where nu_tipo_indicador=21;
\pset format unaligned

select
    'delete from gct.' || tabela ||
    E'\nwhere nu_tipo_grupo=' || nu_tipo_grupo ||
    E'\n  and nu_contrato=' || nu_contrato ||
    E'\n  and nu_tipo_indicador=' || nu_tipo_indicador ||
    E'\n  and nu_situacao_atendimento=(' ||
    E'\n      select sa.nu_situacao_atendimento' ||
    E'\n      from gct.gcttb092_situacao_atendimento sa' ||
    E'\n      where sa.no_situacao_atendimento in (' ||
    quote_literal(no_situacao_atendimento) ||
    E')' ||
    E'\n  );\n'
from 
  gct.gct900_view_solicitacoes 
order by 
  1;  
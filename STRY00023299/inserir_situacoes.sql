\pset format unaligned

select
    'insert into gct.' || tabela || '(nu_tipo_grupo,nu_contrato,nu_tipo_indicador,nu_situacao_atendimento) ' ||
    E'\nvalues (' ||
        nu_tipo_grupo || ',' ||
        nu_contrato || ',' ||
        nu_tipo_indicador || ',' ||
    E'\n    (' ||
    E'\n        select sa.nu_situacao_atendimento' ||
    E'\n        from gct.gcttb092_situacao_atendimento sa' ||
    E'\n        where sa.no_situacao_atendimento = ' ||
        quote_literal(no_situacao_atendimento) ||
    E'\n    )' ||
    E'\n);\n'
from 
  gct.gct900_view_solicitacoes 
order by 
  1;  

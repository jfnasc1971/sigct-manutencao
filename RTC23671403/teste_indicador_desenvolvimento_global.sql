\i 'src/Objetos_BD/Functions/GCTFN141_INDICADOR_DESEMPENHO_GLOBAL_DDL.sql'
begin;

-- select gct.gctfn141_indicador_desempenho_global(201, '2025-08-05', 1);
-- select gct.gctfn141_indicador_desempenho_global(201, '2025-09-05', 1);
select gct.gctfn141_indicador_desempenho_global(206, '2025-10-05', 1);

select
  *
from
  gct.gcttb269_valor_indicador_contratada vic
where
  nu_tipo_indicador = 45;
  
rollback;
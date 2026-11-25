\i src/Objetos_BD/Functions/GCTFN303_CALCULAR_INDICADOR_DDL.sql
\i src/Objetos_BD/Functions/GCTFN334_CALCULAR_INDICADOR_AJUSTE_DDL.sql
\i src/Objetos_BD/Functions/GCTFN204_INDICADOR_QUALIDADE_DDL.sql

\i src/Objetos_BD/Functions/GCTFN204_INDICADOR_QUALIDADE_DDL.sql
\i src/Objetos_BD/Functions/GCTFN205_INDICADOR_PRAZO_DDL.sql
\i src/Objetos_BD/Functions/GCTFN206_INDICADOR_PLANEJAMENTO_DDL.sql
\i src/Objetos_BD/Functions/GCTFN207_INDICADOR_PRODUTIVIDADE_DDL.sql
\i src/Objetos_BD/Functions/GCTFN208_INDICADOR_TURNOVER_DDL.sql

\i src/Objetos_BD/Functions/GCTFN214_INDICADOR_QUALIDADE_AJUSTE_DDL.sql
\i src/Objetos_BD/Functions/GCTFN215_INDICADOR_PRAZO_AJUSTE_DDL.sql
\i src/Objetos_BD/Functions/GCTFN216_INDICADOR_PLANEJAMENTO_AJUSTE_DDL.sql
\i src/Objetos_BD/Functions/GCTFN217_INDICADOR_PRODUTIVIDADE_AJUSTE_DDL.sql
\i src/Objetos_BD/Functions/GCTFN218_INDICADOR_TURNOVER_AJUSTE_DDL.sql

begin;

select gct.gctfn300_fechar_faturamento('2026-03-21',849,1948); --, p_nu_contrato numeric DEFAULT NULL::numeric, p_nu_equipe numeric DEFAULT NULL::numeric)

rollback;

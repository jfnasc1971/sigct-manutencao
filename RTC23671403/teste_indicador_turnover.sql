\i 'src/Objetos_BD/Functions/GCTFN111_PROCESSAR_INDICADORES_DDL.sql'
\i 'src/Objetos_BD/Functions/GCTFN174_INDICADOR_TURNOVER_DDL.sql'
\i 'src/Objetos_BD/Functions/GCTFN173_REGISTRAR_VALOR_INDICADOR_DDL.sql'

begin;

delete from gct.gcttb269_valor_indicador_contratada;

select gct.gctfn174_indicador_turnover(203, 1);

select * from gct.gcttb283_agendamento_indicador where nu_contrato=203 order by dt_inicio;

select * from gct.gcttb269_valor_indicador_contratada where nu_contrato=203;

commit;
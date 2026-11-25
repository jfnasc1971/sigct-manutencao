\i 'src/Objetos_BD/Functions/GCTFN300_FECHAR_FATURAMENTO_DDL.sql' 
\i 'src/Objetos_BD/Functions/GCTFN111_PROCESSAR_INDICADORES_DDL.sql' 
\i 'src/Objetos_BD/Functions/GCTFN112_INDICADOR_EFETIVIDADE_DDL.sql' 
\i 'src/Objetos_BD/Functions/GCTFN113_INDICADOR_PRODUTIVIDADE_DDL.sql' 
\i 'src/Objetos_BD/Functions/GCTFN114_INDICADOR_QUALIDADE_DDL.sql' 
\i 'src/Objetos_BD/Functions/GCTFN115_INDICADOR_TURNOVER_EQUIPE_DDL.sql' 
\i 'src/Objetos_BD/Functions/GCTFN116_CALCULAR_FATOR_NIVEL_SERVICO_DDL.sql' 
\i 'src/Objetos_BD/Functions/GCTFN118_GERAR_TERMO_INDICADOR_DDL.sql' 
\i 'src/Objetos_BD/Functions/GCTFN119_REGISTRAR_VALOR_INDICADOR_EQUIPE_DDL.sql' 
\i 'src/Objetos_BD/Functions/GCTFN120_RECUPERAR_VALOR_FAIXA_DDL.sql' 
\i 'src/Objetos_BD/Functions/GCTFN121_COPIAR_TERMO_EQUIPE_DDL.sql' 
\i 'src/Objetos_BD/Functions/GCTFN122_INDICADOR_EFETIVIDADE_SUPORTE_DDL.sql' 
\i 'src/Objetos_BD/Functions/GCTFN123_COLETAR_AMOSTRA_INDICADORES_DDL.sql' 
\i 'src/Objetos_BD/Functions/GCTFN124_INDICADOR_DESEMPENHO_EQUIPE_DDL.sql' 
\i 'src/Objetos_BD/Functions/GCTFN137_OBTER_DT_CONSIDERAR_FNS_EQUIPE_DDL.sql'
\i 'src/Objetos_BD/Functions/GCTFN138_INDICADOR_REDUCAO_DEFEITOS_DDL.sql' 
\i 'src/Objetos_BD/Functions/GCTFN139_INDICADOR_NOTA_CODIGO_DDL.sql' 
\i 'src/Objetos_BD/Functions/GCTFN141_INDICADOR_DESEMPENHO_GLOBAL_DDL.sql'
\i 'src/Objetos_BD/Functions/GCTFN174_INDICADOR_TURNOVER_DDL.sql'
\i 'src/Objetos_BD/Functions/GCTFN173_REGISTRAR_VALOR_INDICADOR_DDL.sql'

--\i 'teste_carga_sinop.sql' 

begin;

update gct.gcttb087_equipe set dt_considerar_fns = '2025-07-01';

delete from gct.gcttb269_valor_indicador_contratada vie where nu_tipo_indicador = 45 and nu_contrato between 201 and 206;
delete from gct.gcttb172_valor_indicador_equipe vie where nu_contrato between 201 and 206;
delete FROM gct.gcttb104_sequencial_termo where nu_tipo_termo = 21;

alter table gct.gcttb170_termo_equipe disable trigger all;
delete from gct.gcttb170_termo_equipe where nu_tipo_termo = 21;
alter table gct.gcttb170_termo_equipe enable trigger all;

select gct.gctfn111_processar_indicadores('2025-07-05', 1);
select gct.gctfn111_processar_indicadores('2025-08-05', 1);
select gct.gctfn111_processar_indicadores('2025-09-05', 1);
select gct.gctfn111_processar_indicadores('2025-10-05', 1);

-- select e.nu_equipe, e.co_equipe, gct.gctfn111_processar_indicadores('2025-08-05',1,e.nu_contrato,e.nu_equipe) 
-- from gct.gcttb087_equipe e 
-- where e.co_equipe='BRE202500251';

-- select e.nu_equipe, e.co_equipe, gct.gctfn111_processar_indicadores('2025-09-05',1,e.nu_contrato,e.nu_equipe) 
-- from gct.gcttb087_equipe e 
-- where e.co_equipe='BRE202500251';

-- select e.nu_equipe, e.co_equipe, gct.gctfn111_processar_indicadores('2025-10-05',1,e.nu_contrato,e.nu_equipe) 
-- from gct.gcttb087_equipe e 
-- where e.co_equipe='BRE202500253';

-- select gct.gctfn111_processar_indicadores('2025-10-05',1,206,3060);
-- select gct.gctfn111_processar_indicadores('2025-10-05',1,204,7028);
-- select gct.gctfn111_processar_indicadores('2025-08-05',1,202,7070);

-- select gct.gctfn111_processar_indicadores('2025-05-05',1,203,7060);
-- select gct.gctfn111_processar_indicadores('2025-06-05',1,203,7060);
-- select gct.gctfn111_processar_indicadores('2025-07-05',1,203,7060);
-- select gct.gctfn111_processar_indicadores('2025-08-05',1,203,7060);
-- select gct.gctfn111_processar_indicadores('2025-09-05',1,205,3063);

--
-- BRE202500231
--
-- select e.nu_equipe, e.co_equipe, gct.gctfn111_processar_indicadores('2025-10-05',1,e.nu_contrato,e.nu_equipe) 
-- from gct.gcttb087_equipe e 
-- where e.co_equipe='BRE202500231';

--
-- BRE202500194
--
-- select e.nu_equipe, e.co_equipe, gct.gctfn111_processar_indicadores('2025-10-05',1,e.nu_contrato,e.nu_equipe) 
-- from gct.gcttb087_equipe e 
-- where e.co_equipe='BRE202500194';


\i resultados.sql 

-- select * from gct.gcttb283_agendamento_indicador where dt_final < '2026-03-01' order by nu_contrato, dt_inicio;

-- select * from gct.gcttb269_valor_indicador_contratada order by nu_contrato, nu_tipo_indicador, dt_inicio_indicador;

commit;
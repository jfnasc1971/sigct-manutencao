\i 'src/Objetos_BD/Functions/GCTFN300_FECHAR_FATURAMENTO_DDL.sql'
\i 'src/Objetos_BD/Functions/GCTFN111_PROCESSAR_INDICADORES_DDL.sql'
\i 'src/Objetos_BD/Functions/GCTFN112_INDICADOR_EFETIVIDADE_DDL.sql'
\i 'src/Objetos_BD/Functions/GCTFN122_INDICADOR_EFETIVIDADE_SUPORTE_DDL.sql'
\i 'src/Objetos_BD/Functions/GCTFN113_INDICADOR_PRODUTIVIDADE_DDL.sql'
\i 'src/Objetos_BD/Functions/GCTFN114_INDICADOR_QUALIDADE_DDL.sql'
\i 'src/Objetos_BD/Functions/GCTFN115_INDICADOR_TURNOVER_DDL.sql'
\i 'src/Objetos_BD/Functions/GCTFN116_CALCULAR_FATOR_NIVEL_SERVICO_DDL.sql'
\i 'src/Objetos_BD/Functions/GCTFN117_INDICADOR_DESEMPENHO_DDL.sql'
\i 'src/Objetos_BD/Functions/GCTFN118_GERAR_TERMO_INDICADOR_DDL.sql'
\i 'src/Objetos_BD/Functions/GCTFN119_REGISTRAR_VALOR_INDICADOR_EQUIPE_DDL.sql'
\i 'src/Objetos_BD/Functions/GCTFN120_RECUPERAR_VALOR_FAIXA_DDL.sql'
\i 'src/Objetos_BD/Functions/GCTFN121_COPIAR_TERMO_EQUIPE_DDL.sql'
\i 'src/Objetos_BD/Functions/GCTFN123_COLETAR_AMOSTRA_INDICADORES_DDL.sql'
\i 'RTC23671403_02_DDL.sql'

begin;

select gct.gctfn123_coletar_amostra_indicadores('2025-07-01'); --,206, 3060); --, p_nu_contrato numeric default NULL::numeric, p_nu_equipe numeric default NULL::numeric)
select gct.gctfn123_coletar_amostra_indicadores('2025-08-01'); --,206, 3060); --, p_nu_contrato numeric default NULL::numeric, p_nu_equipe numeric default NULL::numeric)
select gct.gctfn123_coletar_amostra_indicadores('2025-09-01'); --,206, 3060); --, p_nu_contrato numeric default NULL::numeric, p_nu_equipe numeric default NULL::numeric)

select 'gct.gcttb264_amsta_equipe', count(*) from gct.gcttb264_amsta_equipe;
select 'gct.gcttb266_amsta_slctco_equipe', count(*) from gct.gcttb266_amsta_slctco_equipe;
select 'gct.gcttb267_amsta_ciclo_trabalho', count(*) from gct.gcttb267_amsta_ciclo_trabalho;
select 'gct.gcttb265_amsta_solicitacao', count(*) from gct.gcttb265_amsta_solicitacao;

commit;
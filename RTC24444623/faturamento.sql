\i 'src/Objetos_BD/Functions/GCTFN311_INDICADOR_PRODUTIVIDADE_DDL.sql'
\i 'src/Objetos_BD/Functions/GCTFN313_INDICADOR_DESEMPENHO_DDL.sql'
\i 'src/Objetos_BD/Views/GCTVW051_VALOR_INDICADOR_CICLO_TRABALHO_DDL.sql'

begin;

delete from gct.gcttb175_amostra_equipe where nu_equipe=893 and nu_fatura_amostra=6438;
delete from gct.gcttb176_amostra_ciclo_trabalho where nu_equipe=893 and nu_fatura_amostra=6438;
delete from gct.gcttb177_amostra_solicitacao_equipe where nu_equipe=893 and nu_fatura_amostra=6438;

delete from gct.gcttb088_ciclo_trabalho where nu_equipe=893 and nu_ciclo_trabalho=46;

INSERT INTO gct.gcttb088_ciclo_trabalho (nu_equipe,nu_ciclo_trabalho,nu_situacao_ciclo_trabalho,de_ciclo_trabalho,dt_inicio_ciclo_trabalho,dt_alvo_ciclo_trabalho,dt_final_ciclo_trabalho,co_falha_ciclo_trabalho,nu_acao_historico,nu_mtrca_acao_hstro,vr_questionario_avaliacao,vr_nota_qualidade_produto,vr_total_apurado_avaliacao,nu_mtrca_avaliacao_equipe,de_justificativa_falha,de_justificativa_alteracao,nu_mtrca_fechamento_equipe,dt_fechamento_ciclo_trabalho,de_justificativa_fechamento,de_justificativa_cancelar_fechamento,ic_nao_se_aplica) 
VALUES (893,46,2,'Teste Sprint Fracassada','2025-11-21 12:00:00.0','2025-12-20 12:00:00.0','2025-12-20 19:01:41.464','SF',177,134295,12.000,10.000,null,1,null,null,null,null,null,null,'N');

alter table gct.gcttb170_termo_equipe disable trigger all;
delete from gct.gcttb170_termo_equipe te where te.nu_equipe=893 and te.nu_fatura_gerada=6438 and te.nu_tipo_termo=11;
alter table gct.gcttb170_termo_equipe enable trigger all;

select gct.gctfn300_fechar_faturamento('2025-12-21', 719, 893);

select vie.nu_tipo_indicador, vie.vr_calculo_indicador, vie.vr_peso_tipo_indicador, vr_faixa_fns 
from gct.gcttb172_valor_indicador_equipe vie 
where vie.nu_equipe=893 and dt_referencia='2025-12-20';

select * from gct.gcttb171_valor_indicador_ciclo_trabalho vie
where vie.nu_equipe=893 and nu_ciclo_trabalho=46;

commit;
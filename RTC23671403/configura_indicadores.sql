begin;

delete from gct.gcttb115_grupo_indicador where nu_tipo_indicador between 36 and 41;
delete from gct.gcttb057_valor_faixa where nu_tipo_faixa between 414 and 419;
delete from gct.gcttb056_tipo_faixa where nu_tipo_faixa between 414 and 419;

insert into gct.gcttb115_grupo_indicador
select
  distinct gc.nu_tipo_grupo,
  gc.nu_contrato,
  ti.nu_tipo_indicador,
  case when ti.nu_tipo_indicador <> 41 then 'N':: char else 'S'::char end as ic_aplica_indicador,
  1 as nu_mtrca_acao_hstro,
  175 as nu_acao_historico,
  null::numeric as vr_fator_ajuste,
  null::numeric as nu_tipo_indicador_media,
  null::numeric as qt_faturamento,
  1::numeric as vr_peso_tipo_indicador,
  null::numeric as vr_limite_maximo_indicador,
  'S'::char as ic_apenas_faturamento_atual,
  null::numeric as nu_produtividade_esperada,
  'N'::char ic_avaliacao_por_nota,
  'N'::char ic_avaliacao_por_questionario,
  null::numeric vr_limite_minimo_indicador,
  'N'::char ic_resposta_justificativa,
  null::numeric vr_lmte_rspsta_justificativa
from
  gct.gcttb032_tipo_grupo tg
  inner join gct.gcttb112_tipo_indicador ti on ti.nu_tipo_indicador in (37, 38, 39, 40, 41)
  inner join gct.gcttb033_grupo_contrato gc on (
    gc.nu_tipo_grupo = tg.nu_tipo_grupo
    and gc.nu_tp_frma_calculo_pgto = 4
    and gc.nu_tipo_grupo = 11
  )
order by
  nu_tipo_indicador;

insert into gct.gcttb115_grupo_indicador
select
  distinct gc.nu_tipo_grupo,
  gc.nu_contrato,
  ti.nu_tipo_indicador,
  case when ti.nu_tipo_indicador <> 41 then 'N':: char else 'S'::char end as ic_aplica_indicador,
  1 as nu_mtrca_acao_hstro,
  175 as nu_acao_historico,
  null::numeric as vr_fator_ajuste,
  null::numeric as nu_tipo_indicador_media,
  null::numeric as qt_faturamento,
  1::numeric as vr_peso_tipo_indicador,
  null::numeric as vr_limite_maximo_indicador,
  'S'::char as ic_apenas_faturamento_atual,
  null::numeric as nu_produtividade_esperada,
  'N'::char ic_avaliacao_por_nota,
  'N'::char ic_avaliacao_por_questionario,
  null::numeric vr_limite_minimo_indicador,
  'N'::char ic_resposta_justificativa,
  null::numeric vr_lmte_rspsta_justificativa
from
  gct.gcttb032_tipo_grupo tg
  inner join gct.gcttb112_tipo_indicador ti on ti.nu_tipo_indicador in (36, 38, 39, 40, 41)
  inner join gct.gcttb033_grupo_contrato gc on (
    gc.nu_tipo_grupo = tg.nu_tipo_grupo
    and gc.nu_tp_frma_calculo_pgto = 4
    and gc.nu_tipo_grupo = 10
  )
order by
  nu_tipo_indicador;

--
-- EFETIVIDADE (DESENVOLVIMENTO)
--
INSERT INTO gct.gcttb056_tipo_faixa VALUES (414,'Faixas indicador: Efetividade(Desenvolvimento) - Contratos Especializados','D','M','IE - Mede a efetividade das equipes de Desenvolvimento',111,1);

INSERT INTO 
  gct.gcttb057_valor_faixa (nu_tipo_faixa,qt_inicio_faixa,qt_final_faixa,vr_fator_faixa,nu_acao_historico,nu_mtrca_acao_hstro) 
VALUES 
  (414,1.00,1000,1.00,119,1),
  (414,0.91,0.99,0.90,119,1),
  (414,0.81,0.90,0.80,119,1),
  (414,0.71,0.80,0.70,119,1),
  (414,0.61,0.70,0.60,119,1),
  (414,0.51,0.60,0.50,119,1),
  (414,0.00,0.50,0.40,119,1);

--
-- EFETIVIDADE (SUPORTE)
--
INSERT INTO gct.gcttb056_tipo_faixa VALUES (415,'Faixas indicador: Efetividade(Suporte) - Contratos Especializados','D','M','IE - Mede a efetividade das equipes de Suporte',111,1);

INSERT INTO 
  gct.gcttb057_valor_faixa (nu_tipo_faixa,qt_inicio_faixa,qt_final_faixa,vr_fator_faixa,nu_acao_historico,nu_mtrca_acao_hstro) 
VALUES 
  (415,0.85,1000,1.00,119,1),
  (415,0.75,0.84,0.90,119,1),
  (415,0.65,0.74,0.80,119,1),
  (415,0.55,0.64,0.70,119,1),
  (415,0.45,0.54,0.60,119,1),
  (415,0.35,0.44,0.50,119,1),
  (415,0.00,0.34,0.40,119,1);

--
-- PRODUTIVIDADE
--
INSERT INTO gct.gcttb056_tipo_faixa VALUES (416,'Faixas indicador: Produtividade - Contratos Especializados','D','M','IP - Mede a produtividade das equipes',111,1);

INSERT INTO 
  gct.gcttb057_valor_faixa (nu_tipo_faixa,qt_inicio_faixa,qt_final_faixa,vr_fator_faixa,nu_acao_historico,nu_mtrca_acao_hstro) 
VALUES 
  (416,1.27,1000,1.27,119,1),
  (416,1.01,1.26,1.01,119,1),
  (416,0.91,1.00,1.00,119,1),
  (416,0.51,0.90,0.90,119,1),
  (416,0.41,0.50,0.50,119,1),
  (416,0.31,0.40,0.40,119,1),
  (416,0.00,0.30,0.30,119,1);

--
-- QUALIDADE
--
INSERT INTO gct.gcttb056_tipo_faixa VALUES (417,'Faixas indicador: Qualidade (Redução de Defeitos)- Contratos Especializados','D','M','IQ - Mede a qualidade das entregas das equipes',111,1);

INSERT INTO 
  gct.gcttb057_valor_faixa (nu_tipo_faixa,qt_inicio_faixa,qt_final_faixa,vr_fator_faixa,nu_acao_historico,nu_mtrca_acao_hstro) 
VALUES 
  (417,0.00,0.95,1.00,119,1),
  (417,0.96,0.98,0.90,119,1),
  (417,0.99,1.00,0.70,119,1),
  (417,1.01,1000,0.60,119,1);

INSERT INTO gct.gcttb056_tipo_faixa VALUES (418,'Faixas indicador: Qualidade (Nota do Código)- Contratos Especializados','D','M','IQ - Mede a qualidade das entregas das equipes',111,1);

INSERT INTO 
  gct.gcttb057_valor_faixa (nu_tipo_faixa,qt_inicio_faixa,qt_final_faixa,vr_fator_faixa,nu_acao_historico,nu_mtrca_acao_hstro) 
VALUES 
  (418,0.00,3.00,0.00,119,1),
  (418,3.01,4.49,0.25,119,1),
  (418,4.50,5.50,0.50,119,1),
  (418,5.51,6.99,0.60,119,1),
  (418,7.00,9.00,0.75,119,1),
  (418,9.01,1000,1.00,119,1);

--
-- TURNOVER
--
INSERT INTO gct.gcttb056_tipo_faixa VALUES (419,'Faixas indicador: Turnover - Contratos Especializados','D','M','IT - Mede o índice de rotatividade baseado na quantidade de saídas',111,1);

INSERT INTO 
  gct.gcttb057_valor_faixa (nu_tipo_faixa,qt_inicio_faixa,qt_final_faixa,vr_fator_faixa,nu_acao_historico,nu_mtrca_acao_hstro) 
VALUES 
  (419,1.00,1000,1.00,119,1),
  (419,0.98,0.99,0.99,119,1),
  (419,0.95,0.97,0.97,119,1),
  (419,0.92,0.94,0.95,119,1),
  (419,0.00,0.91,0.93,119,1);

select * from gct.gcttb056_tipo_faixa where nu_tipo_faixa between 414 and 419;
select * from gct.gcttb057_valor_faixa where nu_tipo_faixa between 414 and 419;

COMMIT;
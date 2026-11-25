--
-- INICIO
--

drop function if exists gct.gctfn300_fechar_faturamento(dtbase date, p_nu_contrato numeric, p_nu_equipe numeric);
drop function if exists gct.gctfn111_processar_indicadores(p_dt_referencia date, p_nu_matricula numeric, p_nu_contrato numeric, p_nu_equipe numeric);
drop function if exists gct.gctfn112_indicador_efetividade(p_nu_equipe numeric, p_nu_fatura numeric, p_dt_referencia date, p_nu_matricula numeric);
drop function if exists gct.gctfn113_indicador_produtividade(p_nu_equipe numeric, p_nu_fatura numeric, p_dt_referencia date, p_nu_matricula numeric);
drop function if exists gct.gctfn114_indicador_qualidade(p_nu_equipe numeric, p_nu_fatura numeric, p_dt_referencia date, p_nu_matricula numeric);
drop function if exists gct.gctfn115_indicador_turnover_equipe(p_nu_equipe numeric, p_nu_fatura numeric, p_dt_referencia date, p_nu_matricula numeric);
drop function if exists gct.gctfn116_calcular_fator_nivel_servico(p_nu_equipe numeric, p_nu_fatura numeric, p_dt_referencia date, p_nu_matricula numeric);
drop function if exists gct.gctfn118_gerar_termo_indicador(p_nu_equipe numeric, p_nu_fatura numeric, p_nu_matricula numeric);
drop function if exists gct.gctfn119_registrar_valor_indicador_equipe(p_nu_equipe numeric, p_nu_fatura numeric, p_dt_referencia date, p_nu_tipo_indicador numeric, p_vr_indicador numeric, p_ic_recupera_vr_faixa char);
drop function if exists gct.gctfn120_recuperar_valor_faixa(p_nu_contrato numeric, p_nu_tipo_grupo numeric, p_nu_tipo_indicador numeric, p_vr_calculo_indicador numeric);
drop function if exists gct.gctfn121_copiar_termo_equipe(p_nu_termo_equipe_ajustado numeric, p_nu_tipo_termo numeric, p_nu_fatura numeric, p_vr_finaceiro_termo numeric);
drop function if exists gct.gctfn122_indicador_efetividade_suporte(p_nu_equipe numeric, p_nu_fatura numeric, p_dt_referencia date, p_nu_matricula numeric);
drop function if exists gct.gctfn123_coletar_amostra_indicadores(p_dt_referencia date, p_nu_contrato numeric, p_nu_equipe numeric);
drop function if exists gct.gctfn124_indicador_desempenho_equipe(p_nu_equipe numeric, p_nu_fatura numeric, p_dt_referencia date, p_nu_matricula numeric);
drop function if exists gct.gctfn137_obter_dt_considerar_fns_equipe(p_nu_equipe numeric);
drop function if exists gct.gctfn138_indicador_reducao_defeitos(p_nu_equipe numeric, p_nu_fatura numeric, p_dt_referencia date, p_nu_matricula numeric);
drop function if exists gct.gctfn139_indicador_nota_codigo(p_nu_equipe numeric, p_nu_fatura numeric, p_dt_referencia date, p_nu_matricula numeric);
drop function if exists gct.gctfn141_indicador_desempenho_global(p_nu_contrato numeric, p_dt_referencia date, p_nu_matricula numeric);
drop function if exists gct.gctfn140_agendar_calculo_indicador(p_nu_contrato numeric, p_nu_tipo_indicador numeric, p_data_inicial date, p_periodicidade_mes numeric, p_periodos numeric);
drop function if exists gct.gctfn349_executar_ajuste_equipe(p_nu_ajuste numeric, p_nu_equipe numeric, p_nu_repactuacao numeric, p_nu_repactuacao_ajuste_previo numeric, p_dt_referencia date);
drop function if exists gct.gctfn173_registrar_valor_indicador(p_nu_contrato numeric, p_nu_tipo_indicador numeric, p_dt_inicio date, p_dt_final date, p_vr_indicador numeric, p_ic_recupera_vr_faixa char);
drop function if exists gct.gctfn174_indicador_turnover(p_nu_contrato numeric, p_nu_matricula numeric);
drop function if exists gct.gctfn175_coletar_amsta_indcdr_ajuste(p_nu_ajuste numeric, p_nu_fatura_ajuste numeric, p_nu_equipe numeric);
drop function if exists gct.gctfn176_simular_termo_ajuste_equipe(p_nu_ajuste numeric, p_nu_equipe numeric);
drop function if exists gct.gctfn177_calcular_indicador_ajuste(p_nu_ajuste numeric, p_nu_equipe numeric);
drop function if exists gct.gctfn178_indcdr_eftvde_ajuste(p_nu_equipe numeric, p_nu_fatura numeric, p_nu_ajuste numeric);
drop function if exists gct.gctfn179_indcdr_eftvde_sprte_ajuste(p_nu_equipe numeric, p_nu_fatura numeric, p_dt_referencia date, p_nu_matricula numeric);
drop function if exists gct.gctfn186_registrar_valor_indcdr_equipe_ajuste(p_nu_equipe numeric, p_nu_fatura numeric, p_nu_ajuste numeric, p_nu_tipo_indicador numeric, p_vr_indicador numeric, p_ic_recupera_vr_faixa char);
drop function if exists gct.gctfn180_indcdr_produtividade_ajuste(p_nu_equipe numeric, p_nu_fatura numeric, p_nu_ajuste numeric);
drop function if exists gct.gctfn181_indcdr_reducao_defeitos_ajuste(p_nu_equipe numeric, p_nu_fatura numeric, p_nu_ajuste numeric);
drop function if exists gct.gctfn182_indcdr_nota_codigo_ajuste(p_nu_equipe numeric, p_nu_fatura numeric, p_nu_ajuste numeric);
drop function if exists gct.gctfn183_indcdr_qualidade_ajuste(p_nu_equipe numeric, p_nu_fatura numeric, p_nu_ajuste numeric);
drop function if exists gct.gctfn184_indcdr_turnover_eqpe_ajuste(p_nu_equipe numeric, p_nu_fatura numeric, p_nu_ajuste numeric);
drop function if exists gct.gctfn185_calcular_fator_nivel_servico_ajuste(p_nu_equipe numeric, p_nu_fatura numeric, p_nu_ajuste numeric);

--------------------------------------------------------------------------------
-- -- gctfn300_fechar_faturamento
-- --------------------------------------------------------------------------------

-- drop function if exists gct.gctfn300_fechar_faturamento(dtbase date, p_nu_contrato numeric, p_nu_equipe numeric);

CREATE OR REPLACE FUNCTION gct.gctfn300_fechar_faturamento(dtbase date, p_nu_contrato numeric DEFAULT NULL::numeric, p_nu_equipe numeric DEFAULT NULL::numeric)
 RETURNS void
 LANGUAGE plpgsql
AS $function$ 

/*

RELEASE NOTES

RTC 23728291 - SIGCT - Faturamento contrato especializado - Não gerou os empenhos 08/20205
RTC 22026754 - SIGCT - Erro ao tentar liberar termo retido equipe SPE202300197
RTC 20971453 - GT60 VITEC - Vinculação automática de Item de Backlog nas contratações ágil
RTC 19423998 - SIGCT - Erro na rotina de ajuste dos contratos ágeis
RTC 18298759 - Analise sobre FNS equipe RJE202100039 em novembro [Ref: 18283284]
RTC 17066035 - Erro SIGCT - Processamento do faturamento dos contratos da qualidade do ágil março_2021.
RTC 15791035 - SIGCT - Contrato 09386/2018 - SPREAD - Faturamento AGO 2020 – FNS
RTC 16244576 - SIGCT - Movimentação de termos dos contratos ágeis
*/

DECLARE 

  v_qt_faturas        numeric;
  v_dt_referencia     date;
  v_dt_inicio_fatura  date;
  v_dt_final_fatura   date;
  equipes             record; 

BEGIN 

  v_dt_referencia := dtbase - '1 day' :: interval;
  v_qt_faturas := 0;

  select 
      f.dt_inicio_fatura, f.dt_final_fatura, count(*)
  into
      v_dt_inicio_fatura, v_dt_final_fatura, v_qt_faturas 
  from
  	  gct.gcttb102_fatura f
  	  inner join gct.gcttb103_faturamento fat on (fat.nu_faturamento = f.nu_faturamento)
  	  inner join gct.gcttb010_contrato c on (c.nu_faturamento = fat.nu_faturamento)
  where
  	  f.dt_final_fatura = v_dt_referencia
      and c.nu_tipo_contrato = 2
  	  and c.ic_tipo_contratacao = 'E'
  group by 
      f.dt_inicio_fatura, f.dt_final_fatura; 

  if(v_qt_faturas = 0) then 
    RAISE NOTICE 'FATURAMENTO - NENHUMA FATURA DISPONIVEL DATA REFERENCIA: %', v_dt_referencia;
    return;
  end if;

  RAISE NOTICE 'FATURAMENTO - FATURAS DISPONIVEIS DATA REFERENCIA: %', v_dt_referencia;

  for equipes in (
    
      -- ordena pela quantidade de indicadores vinculados porque
      -- os grupos que possuem tais vinculos devem ser processados no final
      -- (quanto mais vinculos houver, mais é "empurrado" para o fim da fila)
      select
          c.nu_contrato,
          e.co_equipe,
          e.nu_equipe,
          tg.nu_tipo_grupo,
          tg.no_tipo_grupo,
          (
            select
              count(*)
            from
              gct.gcttb173_grupo_indicador_vinculo giv
            where
              giv.nu_contrato = e.nu_contrato
              and giv.nu_tipo_grupo = e.nu_tipo_grupo
          ) qt_vinculo_indicador, -- quantidade de indicadores vinculados,
          tp.nu_tp_frma_calculo_pgto,
          tp.de_tp_frma_calculo_pgto,
          tp.no_tp_frma_calculo_pgto
      from
          gct.gcttb010_contrato c
          inner join gct.gcttb087_equipe e on e.nu_contrato = c.nu_contrato
          inner join gct.gcttb033_grupo_contrato gc on gc.nu_contrato = e.nu_contrato and gc.nu_tipo_grupo = e.nu_tipo_grupo
          inner join gct.gcttb085_situacao_equipe se on se.nu_situacao_equipe = e.nu_situacao_equipe
          inner join gct.gcttb032_tipo_grupo tg on tg.nu_tipo_grupo = e.nu_tipo_grupo
          inner join gct.gcttb240_tp_frma_calculo_pgto tp on tp.nu_tp_frma_calculo_pgto = gc.nu_tp_frma_calculo_pgto
      where
          c.ic_tipo_contratacao = 'E' 
          --and c.nu_contrato in (609, 619, 629)
          --and c.ic_distribui_profissional = 'D'
         	and (
  		        p_nu_contrato is null
  		        or c.nu_contrato = p_nu_contrato
  	      )
         	and (
  		        p_nu_equipe is null
  		        or e.nu_equipe = p_nu_equipe
  	      )
          and (
              (
                  e.dt_final_atendimento is null
                  and e.dt_inicio_atendimento::date <= v_dt_final_fatura
              )
              or (
                  e.dt_inicio_atendimento::date <= v_dt_final_fatura
                  and e.dt_final_atendimento::date <= v_dt_final_fatura
                  and e.dt_final_atendimento::date >= v_dt_inicio_fatura
              )
              or (
                  e.dt_inicio_atendimento::date <= v_dt_final_fatura
                  and e.dt_final_atendimento::date >= v_dt_inicio_fatura
              )
          )
      order by
        c.nu_contrato,
        qt_vinculo_indicador,
        e.nu_tipo_grupo,
        e.nu_equipe
  )
  loop

      BEGIN 

        RAISE NOTICE 'FATURAMENTO - CONTRATO: % | EQUIPE: % - % | GRUPO: % - %',
          equipes.nu_contrato, equipes.nu_equipe, equipes.co_equipe, equipes.nu_tipo_grupo, equipes.no_tipo_grupo;

        RAISE NOTICE 'FATURAMENTO - CONTRATO: % | EQUIPE: % - % | TP_FORMA_CALCULO: % - % (%)',
          equipes.nu_contrato, equipes.nu_equipe, equipes.co_equipe, equipes.nu_tp_frma_calculo_pgto, 
          equipes.no_tp_frma_calculo_pgto, equipes.de_tp_frma_calculo_pgto;

        PERFORM gct.gctfn301_coletar_amostra_faturamento(dtbase, equipes.nu_contrato, equipes.nu_equipe);

        --------------------------------------------------------------------------------------------------------------------------------
        --| nu_tp_frma_calculo_pgto | no_tp_frma_calculo_pgto           | de_tp_frma_calculo_pgto                                      |
        --| ----------------------- | --------------------------------- | ------------------------------------------------------------ |

        --| 1                       | Distribuição de Preços Global     | Distribuição de preços padrão por grupo                      |
        if equipes.nu_tp_frma_calculo_pgto = 1 then
          PERFORM gct.gctfn302_gerar_termo_equipe(dtbase, equipes.nu_contrato, equipes.nu_equipe);
        end if;

        --| 2                       | Distribuição de Preços por Perfil | Distribuição de preços diferenciados por perfil profissional |
        if equipes.nu_tp_frma_calculo_pgto = 2 then
          PERFORM gct.gctfn402_gerar_termo_equipe_perfil(dtbase, equipes.nu_contrato, equipes.nu_equipe);
        end if;

        --| 3                       | Milheiros                         | Milheiros (Contrato UNISYS)                                  |
        if equipes.nu_tp_frma_calculo_pgto = 3 then
          PERFORM gct.gctfn451_gerar_termo_equipe_milheiros(dtbase, equipes.nu_contrato, equipes.nu_equipe);
        end if;
        --------------------------------------------------------------------------------------------------------------------------------
       
        --| 4                       | Contratos Especializados | Contratos Especializados |
        if equipes.nu_tp_frma_calculo_pgto = 4 then
          PERFORM gct.gctfn402_gerar_termo_equipe_perfil(dtbase, equipes.nu_contrato, equipes.nu_equipe);
        end if;

        PERFORM gct.gctfn303_calcular_indicador(dtbase, equipes.nu_contrato, equipes.nu_equipe);
        PERFORM gct.gctfn304_aplicar_indicador(dtbase, equipes.nu_contrato, equipes.nu_equipe);

      EXCEPTION WHEN OTHERS THEN 
  
        RAISE NOTICE 'FATURAMENTO - CONTRATO: % EQUIPE: % ERRO! OCORREU UM PROBLEMA DURANTE O PROCESSAMENTO DA EQUIPE - '
                     'SQLSTATE: % SQLERRM: %', equipes.nu_contrato, equipes.nu_equipe, SQLSTATE, SQLERRM;

      END;

  end loop;

  --
  -- RETENCAO DE PAGAMENTO
  --
  perform gct.gctfn374_processar_rentencao_pagamento(nu_contrato, dt_inicio_fatura, dt_final_fatura) from ( 
    select 
      distinct c.nu_contrato, f.dt_inicio_fatura, f.dt_final_fatura 
    from 
      gct.gcttb010_contrato c
      inner join gct.gcttb087_equipe e on e.nu_contrato = c.nu_contrato
      inner join gct.gcttb033_grupo_contrato gc on gc.nu_contrato = e.nu_contrato and gc.nu_tipo_grupo=e.nu_tipo_grupo
      inner join gct.gcttb102_fatura f on f.nu_faturamento = c.nu_faturamento
    where 
      c.ic_tipo_contratacao = 'E'
      and gc.nu_tp_frma_calculo_pgto not in (3)
      and f.dt_final_fatura = v_dt_referencia
      and (p_nu_contrato is null or c.nu_contrato = p_nu_contrato)
      and (p_nu_equipe is null or e.nu_equipe = p_nu_equipe)
  ) t order by nu_contrato;

END;

$function$;

alter function gct.gctfn300_fechar_faturamento(dtbase date, p_nu_contrato numeric, p_nu_equipe numeric) owner to gct;

--------------------------------------------------------------------------------
-- -- gctfn349_executar_ajuste_equipe
-- --------------------------------------------------------------------------------

-- drop function if exists gct.gctfn349_executar_ajuste_equipe(p_nu_ajuste numeric, p_nu_equipe numeric, p_nu_repactuacao numeric, p_nu_repactuacao_ajuste_previo numeric, p_dt_referencia date);

CREATE OR REPLACE FUNCTION gct.gctfn349_executar_ajuste_equipe(p_nu_ajuste numeric, p_nu_equipe numeric, p_nu_repactuacao numeric DEFAULT NULL::numeric, p_nu_repactuacao_ajuste_previo numeric DEFAULT NULL::numeric, p_dt_referencia date DEFAULT NULL::date)
 RETURNS numeric
 LANGUAGE plpgsql
AS $function$

/**

RELEASE NOTES

RTC 22515315 - SIGCT - Erro funcionalidade de listar repactuação apresenta contrato MAPS-15396/2020 "em processamento"
RTC 21071947 - SIGCT - Evoluir Repactuação dos Contratos Ágeis - Alteração de Repactuação Tradicional e Ágil
RTC 21071845 - SIGCT - Evoluir Repactuação dos Contratos Ágeis - Alteração da Funcionalidade Gerar de Ajuste de Contratações Ágil
RTC 17882046 - SIGCT - Erro no processamento de amostra para calculo de Indicadores (GECEQ)
RTC 19423998 - SIGCT - Erro na rotina de ajuste dos contratos ágeis
RTC 15276626 - SIGCT - Contrato 9520/2018 - FÓTON - Exclusão e Investigação do TMAE0284 da OS BRE201800024
RTC 15776998 - SIGCT - Contrato 0453/2019 - SPREAD - Faturamento JULHO e AGO 2020 - FNS

*/

DECLARE

  v_nu_tp_frma_calculo_pgto   numeric;
  v_vr_financeiro             numeric;
  v_nu_fatura_ajuste          numeric;
  v_ic_distribui_profissional text;
  v_dt_inicio_atendimento     date;
  v_dt_final_atendimento      date;
  v_no_situacao_equipe        text;

BEGIN

  if not exists (

    select null
      from gct.gcttb184_ajuste_agil
     where nu_ajuste = p_nu_ajuste
       and nu_stco_ajuste_equipe in (1,4)

  ) then

    RAISE NOTICE 'AJUSTE EQUIPE - EQUIPE: % AJUSTE % NAO ENCONTRADO', p_nu_equipe, p_nu_ajuste;

  end if;

  if p_dt_referencia is null then
	  
    select 
		  f.nu_fatura, c.ic_distribui_profissional, e.dt_inicio_atendimento, e.dt_final_atendimento, se.no_situacao_equipe,
      gc.nu_tp_frma_calculo_pgto
	  into 
		  v_nu_fatura_ajuste, v_ic_distribui_profissional, v_dt_inicio_atendimento, v_dt_final_atendimento, v_no_situacao_equipe,
      v_nu_tp_frma_calculo_pgto
	  from 
      gct.gcttb102_fatura f
      inner join gct.gcttb087_equipe e on e.co_sitio = f.co_sitio
      inner join gct.gcttb033_grupo_contrato gc on gc.nu_contrato = e.nu_contrato and gc.nu_tipo_grupo=e.nu_tipo_grupo
      inner join gct.gcttb010_contrato c on c.nu_contrato = e.nu_contrato
      inner join gct.gcttb085_situacao_equipe se on se.nu_situacao_equipe = e.nu_situacao_equipe 
	  where 
      e.nu_equipe = p_nu_equipe
      and f.nu_faturamento = c.nu_faturamento
      and f.nu_situacao_fatura = 2
      and current_date between f.dt_inicio_fatura and f.dt_final_fatura;
		
  else 			
	  
    select 
		  f.nu_fatura, c.ic_distribui_profissional, e.dt_inicio_atendimento, e.dt_final_atendimento, se.no_situacao_equipe,
      gc.nu_tp_frma_calculo_pgto
	  into 
		  v_nu_fatura_ajuste, v_ic_distribui_profissional, v_dt_inicio_atendimento, v_dt_final_atendimento, v_no_situacao_equipe,
      v_nu_tp_frma_calculo_pgto
	  from 
      gct.gcttb102_fatura f
      inner join gct.gcttb087_equipe e on e.co_sitio = f.co_sitio
      inner join gct.gcttb033_grupo_contrato gc on gc.nu_contrato = e.nu_contrato and gc.nu_tipo_grupo=e.nu_tipo_grupo
      inner join gct.gcttb010_contrato c on c.nu_contrato = e.nu_contrato
      inner join gct.gcttb085_situacao_equipe se on se.nu_situacao_equipe = e.nu_situacao_equipe 
	  where 
      e.nu_equipe = p_nu_equipe
      and f.nu_faturamento = c.nu_faturamento
      and f.nu_situacao_fatura != 1
      and f.dt_final_fatura = p_dt_referencia;
  
  end if;
  
  raise notice 'AJUSTE EQUIPE - CODIGO: % EQUIPE: % FATURA: % SITUACAO: % DT. INICIO: % DT. FINAL: % FORMA DE CALCULO: %', 
    p_nu_ajuste, p_nu_equipe, v_nu_fatura_ajuste, v_no_situacao_equipe, v_dt_inicio_atendimento, v_dt_final_atendimento,
    v_nu_tp_frma_calculo_pgto;

  if v_nu_fatura_ajuste is not null then 

    --
    -- AMOSTRAS
    --
    perform gct.gctfn328_coletar_amostra_ajuste_equipe(v_nu_fatura_ajuste, p_nu_equipe, p_nu_ajuste);

    --
    -- GLOBAL
    --  
    if v_ic_distribui_profissional = 'G' then 
      perform gct.gctfn347_simular_termo_ajuste_equipe(p_nu_ajuste, p_nu_equipe);
    end if;

    --
    --
    --  
    if v_ic_distribui_profissional = 'D' then
      
      if v_nu_tp_frma_calculo_pgto = 2 then 
        perform gct.gctfn403_simular_termo_ajuste_equipe_perfil(p_nu_ajuste, p_nu_equipe);
      end if;

      if v_nu_tp_frma_calculo_pgto = 3 then
        perform gct.gctfn452_simular_termo_ajuste_equipe_milheiros(p_nu_ajuste, p_nu_equipe);
      end if;  

      if v_nu_tp_frma_calculo_pgto = 4 then 
        perform gct.gctfn403_simular_termo_ajuste_equipe_perfil(p_nu_ajuste, p_nu_equipe);
      end if;

    end if;    

    --
    -- CALCULO DE INDICADORES
    --
    perform gct.gctfn334_calcular_indicador_ajuste(p_nu_ajuste, p_nu_equipe);

    --      
    -- APLICAR INDICADORES
    --
    perform gct.gctfn345_aplicar_indicador_ajuste(p_nu_ajuste, p_nu_equipe);

    --
    -- GERAÇÃO DE TERMOS
    --
    select gct.gctfn333_gerar_termo_ajuste_equipe(p_nu_ajuste, p_nu_equipe, p_nu_repactuacao, 
      p_nu_repactuacao_ajuste_previo, p_dt_referencia) into v_vr_financeiro;

    --
    -- INSUMOS DO TERMOS
    --
    perform gct.gctfn358_processar_insumos_ajuste_agil(p_nu_equipe);

    update gct.gcttb187_ajuste_agil_equipe
       set nu_stco_ajuste_equipe = 2
     where nu_ajuste = p_nu_ajuste
       and nu_equipe = p_nu_equipe;

   if v_vr_financeiro = 0 then
     perform gct.gctfn399_limpar_ajustes_equipe(p_nu_equipe, p_nu_ajuste);
    end if;

  else  

    raise notice 'AJUSTE EQUIPE - CODIGO: % EQUIPE: % FATURA: % (ERRO! NAO FOI ENCONTRADA FATURA ABERTA)', 
      p_nu_ajuste, p_nu_equipe, v_nu_fatura_ajuste;

  end if;

  return p_nu_ajuste;

END;
$function$;

alter function gct.gctfn349_executar_ajuste_equipe(p_nu_ajuste numeric, p_nu_equipe numeric, p_nu_repactuacao numeric, p_nu_repactuacao_ajuste_previo numeric, p_dt_referencia date) owner to gct;

--
-- FIM
--

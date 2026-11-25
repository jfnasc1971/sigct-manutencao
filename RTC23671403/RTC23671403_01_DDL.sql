--
-- INICIO
--

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

RTC 23671403 - SIGCT - Indicadores do contrato especializado
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

        --
        -- PARA OS CONTRATOD ESPECIALIZADOS, O CALCULO DOS INDICADORES SERA FEITO EM OUTRO MOMEMTO
        --
        if equipes.nu_tp_frma_calculo_pgto in (1, 2, 3) then

          PERFORM gct.gctfn303_calcular_indicador(dtbase, equipes.nu_contrato, equipes.nu_equipe);
          PERFORM gct.gctfn304_aplicar_indicador(dtbase, equipes.nu_contrato, equipes.nu_equipe);

        end if;

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
      and gc.nu_tp_frma_calculo_pgto not in (3) -- MILHEIROS NAO PREVE RETENCAO
      and f.dt_final_fatura = v_dt_referencia
      and (p_nu_contrato is null or c.nu_contrato = p_nu_contrato)
      and (p_nu_equipe is null or e.nu_equipe = p_nu_equipe)
  ) t order by nu_contrato;

END;

$function$;

alter function gct.gctfn300_fechar_faturamento(dtbase date, p_nu_contrato numeric, p_nu_equipe numeric) owner to gct;

--------------------------------------------------------------------------------
-- -- gctfn111_processar_indicadores
-- --------------------------------------------------------------------------------

-- drop function if exists gct.gctfn111_processar_indicadores(p_dt_referencia date, p_nu_matricula numeric, p_nu_contrato numeric, p_nu_equipe numeric);

CREATE OR REPLACE FUNCTION gct.gctfn111_processar_indicadores(p_dt_referencia date, p_nu_matricula numeric, p_nu_contrato numeric default NULL::numeric, p_nu_equipe numeric default NULL::numeric)
 RETURNS void
 LANGUAGE plpgsql
AS $function$

/*

RELEASE NOTES

RTC 23671403 - SIGCT - Indicadores do contrato especializado

*/

DECLARE

  v_dt_inicio_indicador date;
  v_dt_final_indicador date;
  v_dt_considerar_fns date;
  v_sql text;

  contrato RECORD;
  equipe RECORD;

BEGIN
  
  raise notice 'INDICADOR - DT. REF.: % - INICIANDO...', p_dt_referencia;

  if p_dt_referencia is null or p_nu_matricula is null then
    raise notice 'INDICADOR - PARAMETROS INVALIDOS! [% %]', p_dt_referencia, p_nu_matricula;
    RETURN;
  end if;

  if extract(day from p_dt_referencia) <> 5 then
    raise notice 'INDICADOR - DT. REF.: % - NADA A FAZER NESSA DATA :)', p_dt_referencia;
    raise notice 'INDICADOR - DT. REF.: % - ENCERRADO.', p_dt_referencia;
    RETURN;
  end if;

  --
  -- DETERMINANDO O PERIODO A SER CALCULADO
  --
  v_dt_inicio_indicador = date_trunc('month', p_dt_referencia::date) - interval '1 month';
  v_dt_final_indicador := date_trunc('month', p_dt_referencia::date) - interval '1 day';

  raise notice 'INDICADOR - DT. REF.: % | DATA INICIO INDICADOR: % | DATA FINAL INDICADOR: %', 
    p_dt_referencia, v_dt_inicio_indicador, v_dt_final_indicador;

  --
  -- AMOSTRAS
  --
  perform gct.gctfn123_coletar_amostra_indicadores(p_dt_referencia, p_nu_contrato, p_nu_equipe);

  --
  -- INDICADORES DA CONTRATADA
  -- 
  -- ESTES INDICADORES SAO INSUMOS PARA OUTROS ENTAO SAO CALCULADOS PARA CADA CONTRATO ANTES DOS DEMAIS
  --
  v_sql := '
    SELECT
      distinct c.nu_contrato,
      c.no_contrato
    FROM
      gct.gcttb010_contrato c
      INNER JOIN gct.gcttb033_grupo_contrato gc ON gc.nu_contrato = c.nu_contrato
    WHERE
      gc.nu_tp_frma_calculo_pgto = 4
    order by
      c.nu_contrato,
      c.no_contrato  
  ';

  FOR contrato IN EXECUTE v_sql LOOP

    --
    -- TURNOVER
    --
    perform gct.gctfn174_indicador_turnover(contrato.nu_contrato, 1);  

  END LOOP;

  --
  -- VAMOS RECUPERAR TODAS AS EQUIPES QUE TEM TERMOS EMITIDOS DENTRO DO PERIODO
  --  
  v_sql := '
    SELECT
      DISTINCT f.nu_fatura,
      f.dt_final_fatura,
      e.nu_contrato,
      e.nu_equipe,
      e.co_equipe,
      e.nu_tipo_grupo,
      cast(gct.gctfn137_obter_dt_considerar_fns_equipe(e.nu_equipe) as date)as dt_considerar_fns
    FROM
      gct.gcttb087_equipe e
      INNER JOIN gct.gcttb033_grupo_contrato gc ON (
        gc.nu_contrato = e.nu_contrato
        AND e.nu_tipo_grupo = gc.nu_tipo_grupo
      )
      INNER JOIN gct.gcttb170_termo_equipe te ON (
        te.nu_tipo_termo = 11
        AND te.nu_situacao_termo in (1, 3)
        AND te.nu_equipe = e.nu_equipe
      )
      INNER JOIN gct.gcttb102_fatura f ON f.nu_fatura = te.nu_fatura_gerada
    WHERE
      gc.nu_tp_frma_calculo_pgto = 4
      AND f.dt_final_fatura BETWEEN $1 AND $2';

  IF p_nu_contrato IS NOT NULL THEN
      v_sql := v_sql || ' AND e.nu_contrato = ' || p_nu_contrato;
  END IF;

  IF p_nu_equipe IS NOT NULL THEN
      v_sql := v_sql || ' AND e.nu_equipe = ' || p_nu_equipe;
  END IF;

  v_sql := v_sql || ' ORDER BY f.nu_fatura, e.nu_contrato, e.co_equipe';

  FOR equipe IN EXECUTE v_sql USING v_dt_inicio_indicador, v_dt_final_indicador LOOP

      --
      -- COMO SE TRATA DE FATURAMENTO, REMOVE OS INDICADORES CALCULADOS ANTERIORMENTE
      --
      delete from gct.gcttb172_valor_indicador_equipe where nu_equipe = equipe.nu_equipe and nu_fatura = equipe.nu_fatura;

  END LOOP;

  FOR equipe IN EXECUTE v_sql USING v_dt_inicio_indicador, v_dt_final_indicador LOOP

    v_dt_considerar_fns = equipe.dt_considerar_fns;

    if equipe.dt_considerar_fns is null then
      
      v_dt_considerar_fns := gct.gctfn137_obter_dt_considerar_fns_equipe(equipe.nu_equipe);
    
    end if;

    if v_dt_considerar_fns <= v_dt_inicio_indicador then

      RAISE NOTICE 'INDICADOR - DT. REF.: % | FATURA: % | CONTRATO: % | DT. CONSIDERAR FNS: % EQUIPE: % %', 
        p_dt_referencia, equipe.nu_fatura, equipe.nu_contrato, v_dt_considerar_fns,
          equipe.nu_equipe, equipe.co_equipe;

      perform gct.gctfn112_indicador_efetividade        (equipe.nu_equipe, equipe.nu_fatura, p_dt_referencia, p_nu_matricula);
      perform gct.gctfn122_indicador_efetividade_suporte(equipe.nu_equipe, equipe.nu_fatura, p_dt_referencia, p_nu_matricula);
      perform gct.gctfn113_indicador_produtividade      (equipe.nu_equipe, equipe.nu_fatura, p_dt_referencia, p_nu_matricula);
      
      --
      -- OS INDICADORES DE QUALIDADE DEVEM PROCESSADOS EXATAMENTE NESSA ORDEM
      --
      perform gct.gctfn138_indicador_reducao_defeitos   (equipe.nu_equipe, equipe.nu_fatura, p_dt_referencia, p_nu_matricula);
      perform gct.gctfn139_indicador_nota_codigo        (equipe.nu_equipe, equipe.nu_fatura, p_dt_referencia, p_nu_matricula);
      perform gct.gctfn114_indicador_qualidade          (equipe.nu_equipe, equipe.nu_fatura, p_dt_referencia, p_nu_matricula);
            
      perform gct.gctfn115_indicador_turnover_equipe    (equipe.nu_equipe, equipe.nu_fatura, p_dt_referencia, p_nu_matricula);
      perform gct.gctfn116_calcular_fator_nivel_servico (equipe.nu_equipe, equipe.nu_fatura, p_dt_referencia, p_nu_matricula);

      --
      --
      --
      perform gct.gctfn118_gerar_termo_indicador        (equipe.nu_equipe, equipe.nu_fatura, p_nu_matricula);

      --
      --
      --
      perform gct.gctfn124_indicador_desempenho_equipe  (equipe.nu_equipe, equipe.nu_fatura, p_dt_referencia, p_nu_matricula);

      raise notice '';

    else
      
      RAISE NOTICE 'INDICADOR - DT. REF.: % | FATURA: % | CONTRATO: % | DT. CONSIDERAR FNS: % EQUIPE: % % - NAO HABILITADO PARA CALCULO', 
        p_dt_referencia, equipe.nu_fatura, equipe.nu_contrato, v_dt_considerar_fns,
          equipe.nu_equipe, equipe.co_equipe;

    end if;  

  END LOOP;

  --
  -- INDICADORES DA CONTRATADA
  -- 
  -- UTILIZAM OS DEMAIS INDICADORES COMO INSUMOS E POR ISSO SAO PROCESSADOS POR ULTIMO
  --
  v_sql := '
    SELECT
      distinct c.nu_contrato,
      c.no_contrato
    FROM
      gct.gcttb010_contrato c
      INNER JOIN gct.gcttb033_grupo_contrato gc ON gc.nu_contrato = c.nu_contrato
    WHERE
      gc.nu_tp_frma_calculo_pgto = 4
    order by
      c.nu_contrato,
      c.no_contrato  
  ';

  FOR contrato IN EXECUTE v_sql LOOP

    --
    -- IDG - INDICE GLOBAL DE DESENVOLVIMENTO
    --
    perform gct.gctfn141_indicador_desempenho_global(contrato.nu_contrato, p_dt_referencia, 1);

  END LOOP;

  raise notice 'INDICADOR - DT. REF.: % - ENCERRADO.', p_dt_referencia;

END;
$function$;

alter function gct.gctfn111_processar_indicadores(p_dt_referencia date, p_nu_matricula numeric, p_nu_contrato numeric, p_nu_equipe numeric) owner to gct;

--------------------------------------------------------------------------------
-- -- gctfn112_indicador_efetividade
-- --------------------------------------------------------------------------------

-- drop function if exists gct.gctfn112_indicador_efetividade(p_nu_equipe numeric, p_nu_fatura numeric, p_dt_referencia date, p_nu_matricula numeric);

CREATE OR REPLACE FUNCTION gct.gctfn112_indicador_efetividade(p_nu_equipe numeric, p_nu_fatura numeric, p_dt_referencia date, p_nu_matricula numeric)
 RETURNS numeric
 LANGUAGE plpgsql
AS $function$

/**

RELEASE NOTES

RTC 23671403 - SIGCT - Indicadores do contrato especializado

*/

DECLARE

  v_nu_tipo_indicador numeric;
  v_nu_tipo_grupo numeric;
  v_sg_tipo_indicador varchar;
  v_no_tipo_indicador varchar;
  v_nu_contrato numeric;
  v_no_tipo_grupo varchar;
  v_co_equipe varchar;
  v_qt_sprints_periodo numeric;
  v_qt_itens_atendidos numeric;
  v_qt_itens_contratados numeric;

  v_vr_calculo_indicador numeric;
  v_dt_inicio_indicador timestamp;
  v_dt_final_indicador timestamp;

  v_sql text;  
				
BEGIN

  --
  -- DETERMINANDO O PERIODO A SER CALCULADO
  --
  v_dt_inicio_indicador = date_trunc('month', p_dt_referencia::date) - interval '1 month';
  v_dt_final_indicador := date_trunc('month', p_dt_referencia::date) - interval '1 day' + time '23:59:59';

  v_nu_tipo_indicador := 36;  -- FIXO CONFORME CARGA FEITA

  select
    trim(ti.sg_tipo_indicador),
    ti.no_tipo_indicador
  into 
    v_sg_tipo_indicador,
    v_no_tipo_indicador
  from
    gct.gcttb010_contrato c
    inner join gct.gcttb264_amsta_equipe e on e.nu_contrato = c.nu_contrato
    inner join gct.gcttb033_grupo_contrato gc on (
      gc.nu_contrato = e.nu_contrato
      and gc.nu_tipo_grupo = e.nu_tipo_grupo
    )
    inner join gct.gcttb032_tipo_grupo tg on tg.nu_tipo_grupo = gc.nu_tipo_grupo
    inner join gct.gcttb115_grupo_indicador gi on (
      gi.nu_tipo_grupo = gc.nu_tipo_grupo
      and gi.nu_contrato = gc.nu_contrato
    )
    inner join gct.gcttb112_tipo_indicador ti on ( 
      ti.nu_tipo_indicador = gi.nu_tipo_indicador
      and ti.nu_tipo_indicador = v_nu_tipo_indicador
    )
  where
    e.dt_referencia = p_dt_referencia
    and e.nu_equipe = p_nu_equipe;

  select 
    e.nu_contrato,
    e.co_equipe,
    tg.nu_tipo_grupo,
    tg.no_tipo_grupo
  into
    v_nu_contrato,
    v_co_equipe,
    v_nu_tipo_grupo,
    v_no_tipo_grupo 
  from
    gct.gcttb264_amsta_equipe e
    inner join gct.gcttb032_tipo_grupo tg on tg.nu_tipo_grupo = e.nu_tipo_grupo
  where
    e.dt_referencia = p_dt_referencia
    and e.nu_equipe = p_nu_equipe;

  if(v_sg_tipo_indicador is null) then
    RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | INDICADOR IE - Efetividade(Desenvolvimento) - NAO FOI CONFIGURADO PARA O GRUPO.', 
      p_nu_equipe, v_co_equipe, v_no_tipo_grupo;
    return v_vr_calculo_indicador;  
  end if;

  --
  -- DESENVOLVIMENTO
  --
  --
  -- IE = (Somatorio(((Quantidade_Itens_Prontos_Sprint1 / Quantidade_Itens_Backlog_Sprint1) + 
  --        (Quantidade_Itens_Prontos_SprintN Quantidade_Itens_Backlog_SprintN))) /
  --                                       N(quantidade de sprints)
  --

  --
  -- Quantidade de sprints periodo
  --
  v_sql := '
    select
      count (distinct cct.nu_ciclo_trabalho)
    from
      gct.gcttb266_amsta_slctco_equipe se
      inner join gct.gcttb264_amsta_equipe e on (
        e.dt_referencia = se.dt_referencia
        and e.nu_contrato = se.nu_contrato
        and e.nu_equipe = se.nu_equipe
      )
      inner join gct.gcttb267_amsta_ciclo_trabalho cct on (
        cct.dt_referencia = se.dt_referencia
        and cct.nu_contrato = se.nu_contrato
        and cct.nu_equipe = se.nu_equipe
        and cct.nu_ciclo_trabalho = se.nu_ciclo_trabalho
      )
      inner join gct.gcttb265_amsta_solicitacao s on (
        s.dt_referencia = se.dt_referencia
        and s.nu_contrato = se.nu_contrato
        and s.nu_equipe = se.nu_equipe
        and se.nu_solicitacao = s.nu_solicitacao
      )
    where
      s.dt_referencia = $1
      and s.nu_contrato = $2
      and se.nu_equipe = $3
      and se.ic_solicitacao_compoe_fns = $4
      and se.co_falha_solicitacao = $5
      and cct.dt_alvo_ciclo_trabalho between $6::date and $7::date';

  execute v_sql 
    using p_dt_referencia, v_nu_contrato, p_nu_equipe, 'S', 'NF', v_dt_inicio_indicador, v_dt_final_indicador
     into v_qt_sprints_periodo;      

  --
  -- Quantidade_Itens_Atendidos
  --
  v_sql := '
    select
      count (distinct s.co_solicitacao)
    from
      gct.gcttb266_amsta_slctco_equipe se
      inner join gct.gcttb264_amsta_equipe e on (
        e.dt_referencia = se.dt_referencia
        and e.nu_contrato = se.nu_contrato
        and e.nu_equipe = se.nu_equipe
      )
      inner join gct.gcttb267_amsta_ciclo_trabalho cct on (
        cct.dt_referencia = se.dt_referencia
        and cct.nu_contrato = se.nu_contrato
        and cct.nu_equipe = se.nu_equipe
        and cct.nu_ciclo_trabalho = se.nu_ciclo_trabalho
      )
      inner join gct.gcttb265_amsta_solicitacao s on (
        s.dt_referencia = se.dt_referencia
        and s.nu_contrato = se.nu_contrato
        and s.nu_equipe = se.nu_equipe
        and s.nu_solicitacao = se.nu_solicitacao
      )
      inner join gct.gcttb191_servico_entregue se1 on (
        s.nu_situacao_solicitacao = se1.nu_situacao_atendimento
        and se1.nu_contrato = e.nu_contrato
        and se1.nu_tipo_grupo = e.nu_tipo_grupo
        and se1.nu_tipo_indicador = $1
      )
    where
      s.dt_referencia = $2
      and s.nu_contrato = $3
      and s.nu_equipe = $4
      and se.ic_solicitacao_compoe_fns = $5
      and se.co_falha_solicitacao = $6
      and cct.dt_alvo_ciclo_trabalho between $7::date and $8::date';

  execute v_sql 
    using v_nu_tipo_indicador, p_dt_referencia, v_nu_contrato, p_nu_equipe, 'S', 'NF', v_dt_inicio_indicador, v_dt_final_indicador
     into v_qt_itens_atendidos;

  --
  -- Quantidade_Itens_Backlog
  --
  v_sql := '
    select
      count (distinct s.co_solicitacao)
    from
      gct.gcttb266_amsta_slctco_equipe se
      inner join gct.gcttb264_amsta_equipe e on (
        e.dt_referencia = se.dt_referencia
        and e.nu_contrato = se.nu_contrato
        and e.nu_equipe = se.nu_equipe
      )
      inner join gct.gcttb267_amsta_ciclo_trabalho cct on (
        cct.dt_referencia = se.dt_referencia
        and cct.nu_contrato = se.nu_contrato
        and cct.nu_equipe = se.nu_equipe
        and cct.nu_ciclo_trabalho = se.nu_ciclo_trabalho
      )
      inner join gct.gcttb265_amsta_solicitacao s on (
        s.dt_referencia = se.dt_referencia
        and s.nu_contrato = se.nu_contrato
        and s.nu_equipe = se.nu_equipe
        and s.nu_solicitacao = se.nu_solicitacao
      )
      inner join gct.gcttb192_servico_contratado se1 on (
        s.nu_situacao_solicitacao = se1.nu_situacao_atendimento
        and se1.nu_contrato = e.nu_contrato
        and se1.nu_tipo_grupo = e.nu_tipo_grupo
        and se1.nu_tipo_indicador = $1
      )
    where
      s.dt_referencia = $2
      and s.nu_contrato = $3
      and s.nu_equipe = $4
      and se.ic_solicitacao_compoe_fns = $5
      and se.co_falha_solicitacao = $6
      and cct.dt_alvo_ciclo_trabalho between $7 and $8';

  execute v_sql 
    using v_nu_tipo_indicador, p_dt_referencia, v_nu_contrato, p_nu_equipe, 'S', 'NF', v_dt_inicio_indicador, v_dt_final_indicador
     into v_qt_itens_contratados;

  v_vr_calculo_indicador := 1::numeric;

  if v_nu_tipo_indicador is not null then

    if v_qt_itens_contratados <> 0 then
      v_vr_calculo_indicador := (v_qt_itens_atendidos / v_qt_itens_contratados) / v_qt_sprints_periodo;
    end if;

    RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | IE - Efetividade(Desenvolvimento) - PERIODO: % a %', 
      p_nu_equipe, v_co_equipe, v_no_tipo_grupo, v_dt_inicio_indicador, v_dt_final_indicador;

    RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | IE - Efetividade(Desenvolvimento) - QT. ITENS ATENDIDOS (A): %', 
      p_nu_equipe, v_co_equipe, v_no_tipo_grupo, v_qt_itens_atendidos;

    RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | IE - Efetividade(Desenvolvimento) - QT. ITENS CONTRATADOS (B): %', 
      p_nu_equipe, v_co_equipe, v_no_tipo_grupo, v_qt_itens_contratados;

    RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | IE - Efetividade(Desenvolvimento) - QT. SPRINTS (C): %', 
      p_nu_equipe, v_co_equipe, v_no_tipo_grupo, v_qt_sprints_periodo;

    RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | IE - Efetividade(Desenvolvimento) - VALOR INDICADOR (A / B) / C: (% / %) / % = %', 
      p_nu_equipe, v_co_equipe, v_no_tipo_grupo, v_qt_itens_atendidos, v_qt_itens_contratados, v_qt_sprints_periodo, v_vr_calculo_indicador;

    PERFORM gct.gctfn119_registrar_valor_indicador_equipe(p_nu_equipe, p_nu_fatura, p_dt_referencia, v_nu_tipo_indicador, v_vr_calculo_indicador, 'S');
  end if;

  return v_vr_calculo_indicador;

END;
$function$;

alter function gct.gctfn112_indicador_efetividade(p_nu_equipe numeric, p_nu_fatura numeric, p_dt_referencia date, p_nu_matricula numeric) owner to gct;

--------------------------------------------------------------------------------
-- -- gctfn113_indicador_produtividade
-- --------------------------------------------------------------------------------

-- drop function if exists gct.gctfn113_indicador_produtividade(p_nu_equipe numeric, p_nu_fatura numeric, p_dt_referencia date, p_nu_matricula numeric);

CREATE OR REPLACE FUNCTION gct.gctfn113_indicador_produtividade(p_nu_equipe numeric, p_nu_fatura numeric, p_dt_referencia date, p_nu_matricula numeric)
 RETURNS numeric
 LANGUAGE plpgsql
AS $function$

/**

RELEASE NOTES

RTC 23671403 - SIGCT - Indicadores do contrato especializado

*/

DECLARE

  v_nu_tipo_indicador numeric;
  v_nu_tipo_grupo numeric;
  v_sg_tipo_indicador varchar;
  v_no_tipo_indicador varchar;
  v_nu_contrato numeric;
  v_no_tipo_grupo varchar;
  v_co_equipe varchar;
  v_qt_tamanho_sprints numeric;
  v_produtividade_esperada numeric;
  v_qt_membros numeric;
  v_qt_dias_uteis numeric;

  v_vr_calculo_indicador numeric;
  v_dt_inicio_indicador timestamp;
  v_dt_final_indicador timestamp;

  v_sql text;  
				
BEGIN

  --
  -- DETERMINANDO O PERIODO A SER CALCULADO
  --
  v_dt_inicio_indicador = date_trunc('month', p_dt_referencia::date) - interval '1 month';
  v_dt_final_indicador := date_trunc('month', p_dt_referencia::date) - interval '1 day' + time '23:59:59';

  select
    ti.nu_tipo_indicador,
    trim(ti.sg_tipo_indicador),
    ti.no_tipo_indicador
  into 
    v_nu_tipo_indicador,
    v_sg_tipo_indicador,
    v_no_tipo_indicador
  from
    gct.gcttb010_contrato c
    inner join gct.gcttb264_amsta_equipe e on e.nu_contrato = c.nu_contrato
    inner join gct.gcttb033_grupo_contrato gc on (
      gc.nu_contrato = e.nu_contrato
      and gc.nu_tipo_grupo = e.nu_tipo_grupo
    )
    inner join gct.gcttb032_tipo_grupo tg on tg.nu_tipo_grupo = gc.nu_tipo_grupo
    inner join gct.gcttb115_grupo_indicador gi on (
      gi.nu_tipo_grupo = gc.nu_tipo_grupo
      and gi.nu_contrato = gc.nu_contrato
    )
    inner join gct.gcttb112_tipo_indicador ti on ( 
      ti.nu_tipo_indicador = gi.nu_tipo_indicador
      and ti.sg_tipo_indicador = 'IP'
    )
  where
    e.dt_referencia = p_dt_referencia
    and e.nu_equipe = p_nu_equipe;

  select 
    e.nu_contrato,
    e.co_equipe,
    tg.nu_tipo_grupo,
    tg.no_tipo_grupo
  into
    v_nu_contrato,
    v_co_equipe,
    v_nu_tipo_grupo,
    v_no_tipo_grupo 
  from
    gct.gcttb264_amsta_equipe e
    inner join gct.gcttb032_tipo_grupo tg on tg.nu_tipo_grupo = e.nu_tipo_grupo
  where
    e.dt_referencia = p_dt_referencia
    and e.nu_equipe = p_nu_equipe;

  if(v_sg_tipo_indicador is null) then
    RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | INDICADOR IP - Produtividade - NAO FOI CONFIGURADO PARA O GRUPO.', 
      p_nu_equipe, v_co_equipe, v_no_tipo_grupo;
    return v_vr_calculo_indicador;  
  end if;

  --
  -- DESENVOLVIMENTO
  --
  --
  -- IP = Pontos_Funcao / ( Colaboradores * PE * Dias_Uteis )
  --

  --
  -- Quantidade de Pontos de Funcao
  --
  v_sql := '
    select
      sum(se.nu_tamanho_servico)
    from
      gct.gcttb266_amsta_slctco_equipe se
      inner join gct.gcttb264_amsta_equipe e on (
        e.dt_referencia = se.dt_referencia
        and e.nu_contrato = se.nu_contrato
        and e.nu_equipe = se.nu_equipe
      )
      inner join gct.gcttb267_amsta_ciclo_trabalho cct on (
        cct.dt_referencia = se.dt_referencia
        and cct.nu_contrato = se.nu_contrato
        and cct.nu_equipe = se.nu_equipe
        and cct.nu_ciclo_trabalho = se.nu_ciclo_trabalho
      )
      inner join gct.gcttb265_amsta_solicitacao s on (
        se.dt_referencia = s.dt_referencia
        and se.nu_equipe = s.nu_equipe
        and se.nu_contrato = s.nu_contrato
        and se.nu_solicitacao = s.nu_solicitacao
      )
    where
      se.dt_referencia = $1
      and se.nu_contrato = $2
      and se.nu_equipe = $3
      and se.ic_solicitacao_compoe_fns = $4
      and se.co_falha_solicitacao = $5
      and cct.dt_alvo_ciclo_trabalho between $6::date and $7::date';

  execute v_sql 
    using p_dt_referencia, v_nu_contrato, p_nu_equipe, 'S', 'NF', v_dt_inicio_indicador, v_dt_final_indicador 
     into v_qt_tamanho_sprints; 

  --
  -- Quantidade efetiva de membros
  --
  v_sql := '
    select
      sum(
        gct.gctfn305_dias_entre_data(
          case when a.dt_inicio_membro < $1 then $1 else a.dt_inicio_membro end, 
          coalesce(a.dt_fim_membro,$2), 
          ai.co_sitio, gc.ic_dias_calculo_pagamento
        ) /
        gct.gctfn305_dias_entre_data($1, $2, ai.co_sitio, gc.ic_dias_calculo_pagamento)
      )
    from
      gct.gcttb268_amsta_membros_equipe a
      inner join gct.gcttb264_amsta_equipe e on (
        a.dt_referencia = e.dt_referencia
        and a.nu_contrato = e.nu_contrato
        and e.nu_equipe = a.nu_equipe
      )
      inner join gct.gcttb010_contrato c on c.nu_contrato = e.nu_contrato
      inner join gct.gcttb033_grupo_contrato gc on gc.nu_contrato = e.nu_contrato and gc.nu_tipo_grupo = e.nu_tipo_grupo
      inner join gct.gcttb001_area_interna ai on ai.nu_area_interna = e.nu_area_interna
    where
      a.dt_referencia = $3
      and a.nu_contrato = $4
      and a.nu_equipe = $5
      and a.dt_inicio_membro <= $2
      and (
        a.dt_fim_membro is null
        or
        a.dt_fim_membro between $1 and $2
      )';

  EXECUTE v_sql 
    USING v_dt_inicio_indicador::date, v_dt_final_indicador::date, p_dt_referencia, v_nu_contrato, p_nu_equipe
     INTO v_qt_membros;

  --
  -- Produtividade esperada
  --

  v_produtividade_esperada := 0.53333;  

  --
  -- Quantidade de dias uteis
  --
  v_sql := '
    select
      gct.gctfn305_dias_entre_data($1, $2, ai.co_sitio, gc.ic_dias_calculo_pagamento)
    from
      gct.gcttb264_amsta_equipe e
      inner join gct.gcttb010_contrato c on c.nu_contrato = e.nu_contrato
      inner join gct.gcttb033_grupo_contrato gc on gc.nu_contrato = e.nu_contrato and gc.nu_tipo_grupo = e.nu_tipo_grupo
      inner join gct.gcttb001_area_interna ai on ai.nu_area_interna = e.nu_area_interna
    where
      e.dt_referencia = $3
      and e.nu_contrato = $4
      and e.nu_equipe = $5';

  EXECUTE v_sql 
    USING v_dt_inicio_indicador::date, v_dt_final_indicador::date, p_dt_referencia, v_nu_contrato, p_nu_equipe 
     INTO v_qt_dias_uteis;

  v_vr_calculo_indicador := 1::numeric;

  if v_nu_tipo_indicador is not null then

    RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | IP - Produtividade - PERIODO: % a %', 
      p_nu_equipe, v_co_equipe, v_no_tipo_grupo, v_dt_inicio_indicador, v_dt_final_indicador;

    RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | IP - Produtividade - QT. PONTOS DE FUNCAO (A): %', 
      p_nu_equipe, v_co_equipe, v_no_tipo_grupo, coalesce(v_qt_tamanho_sprints,0);

    RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | IP - Produtividade - QT. COLABORADORES (B): %', 
      p_nu_equipe, v_co_equipe, v_no_tipo_grupo, v_qt_membros;

    RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | IP - Produtividade - PRODUTIVIDADE ESPERADA (PE): %', 
      p_nu_equipe, v_co_equipe, v_no_tipo_grupo, v_produtividade_esperada;

    RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | IP - Produtividade - QT. DIAS UTEIS (C): %', 
      p_nu_equipe, v_co_equipe, v_no_tipo_grupo, v_qt_dias_uteis;

    if (v_qt_membros * v_produtividade_esperada * v_qt_dias_uteis) <> 0 then
      v_vr_calculo_indicador := coalesce(v_qt_tamanho_sprints,0) / (v_qt_membros * v_produtividade_esperada * v_qt_dias_uteis);
    end if;

    RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | IP - Produtividade - VALOR INDICADOR A/(B * PE * C): %/(% * % * %) = %', 
      p_nu_equipe, v_co_equipe, v_no_tipo_grupo, coalesce(v_qt_tamanho_sprints,0), v_qt_membros, v_produtividade_esperada, v_qt_dias_uteis, v_vr_calculo_indicador;

    PERFORM gct.gctfn119_registrar_valor_indicador_equipe(p_nu_equipe, p_nu_fatura, p_dt_referencia, v_nu_tipo_indicador, v_vr_calculo_indicador, 'S');
  end if;

  return v_vr_calculo_indicador;

END;
$function$;

alter function gct.gctfn113_indicador_produtividade(p_nu_equipe numeric, p_nu_fatura numeric, p_dt_referencia date, p_nu_matricula numeric) owner to gct;

--------------------------------------------------------------------------------
-- -- gctfn114_indicador_qualidade
-- --------------------------------------------------------------------------------

-- drop function if exists gct.gctfn114_indicador_qualidade(p_nu_equipe numeric, p_nu_fatura numeric, p_dt_referencia date, p_nu_matricula numeric);

CREATE OR REPLACE FUNCTION gct.gctfn114_indicador_qualidade(p_nu_equipe numeric, p_nu_fatura numeric, p_dt_referencia date, p_nu_matricula numeric)
 RETURNS numeric
 LANGUAGE plpgsql
AS $function$

/**

RELEASE NOTES

RTC 23671403 - SIGCT - Indicadores do contrato especializado

*/

DECLARE

  v_nu_tipo_indicador numeric;
  v_nu_tipo_grupo numeric;
  v_sg_tipo_indicador varchar;
  v_no_tipo_indicador varchar;
  v_nu_contrato numeric;
  v_no_tipo_grupo varchar;
  v_co_equipe varchar;

  v_vr_iqrd numeric;
  v_vr_iqnp numeric;
  v_vr_soma_indicadores numeric;
  v_vr_soma_pesos numeric;

  v_dt_inicio_indicador date;
  v_dt_final_indicador date;
  v_vr_calculo_indicador numeric;

  insumo record;

  v_sql text;
				
BEGIN

  --
  -- DETERMINANDO O PERIODO A SER CALCULADO
  --
  v_dt_inicio_indicador = date_trunc('month', p_dt_referencia::date) - interval '1 month';
  v_dt_final_indicador := date_trunc('month', p_dt_referencia::date) - interval '1 day' + time '23:59:59';

  select
    ti.nu_tipo_indicador,
    trim(ti.sg_tipo_indicador),
    ti.no_tipo_indicador
  into 
    v_nu_tipo_indicador,
    v_sg_tipo_indicador,
    v_no_tipo_indicador
  from
    gct.gcttb010_contrato c
    inner join gct.gcttb264_amsta_equipe e on e.nu_contrato = c.nu_contrato
    inner join gct.gcttb033_grupo_contrato gc on (
      gc.nu_contrato = e.nu_contrato
      and gc.nu_tipo_grupo = e.nu_tipo_grupo
    )
    inner join gct.gcttb032_tipo_grupo tg on tg.nu_tipo_grupo = gc.nu_tipo_grupo
    inner join gct.gcttb115_grupo_indicador gi on (
      gi.nu_tipo_grupo = gc.nu_tipo_grupo
      and gi.nu_contrato = gc.nu_contrato
    )
    inner join gct.gcttb112_tipo_indicador ti on ( 
      ti.nu_tipo_indicador = gi.nu_tipo_indicador
      and ti.sg_tipo_indicador = 'IQ'
    )
  where
    e.dt_referencia = p_dt_referencia
    and e.nu_equipe = p_nu_equipe;

  select 
    e.nu_contrato,
    e.co_equipe,
    tg.nu_tipo_grupo,
    tg.no_tipo_grupo
  into
    v_nu_contrato,
    v_co_equipe,
    v_nu_tipo_grupo,
    v_no_tipo_grupo 
  from
    gct.gcttb264_amsta_equipe e
    inner join gct.gcttb032_tipo_grupo tg on tg.nu_tipo_grupo = e.nu_tipo_grupo
  where
    e.dt_referencia = p_dt_referencia
    and e.nu_equipe = p_nu_equipe;

  if(v_sg_tipo_indicador is null) then
    RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | O INDICADOR IQ(Qualidade) NAO FOI CONFIGURADO PARA O GRUPO.', 
      p_nu_equipe, v_co_equipe, v_no_tipo_grupo;
    return v_vr_calculo_indicador;  
  end if;

  v_vr_calculo_indicador := 0;
  v_vr_soma_indicadores := 0;

  v_sql := '
    select
      ti.nu_tipo_indicador,
      ti.sg_tipo_indicador,
      vie.vr_peso_tipo_indicador,
      vie.vr_faixa_fns
    from
      gct.gcttb172_valor_indicador_equipe vie
      inner join gct.gcttb112_tipo_indicador ti on ti.nu_tipo_indicador = vie.nu_tipo_indicador
    where
      vie.nu_equipe = $1
      and vie.nu_fatura = $2
      and ti.nu_tipo_indicador in (43,44)';

  v_vr_soma_pesos := 0;

  RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | IQ - Qualidade | PERIODO: % a %', 
    p_nu_equipe, v_co_equipe, v_no_tipo_grupo, v_dt_inicio_indicador, v_dt_final_indicador;

  for insumo in execute v_sql using p_nu_equipe, p_nu_fatura loop
    
    RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | IQ - Qualidade | INDICADOR: % % | PESO: % | FAIXA FNS: % | VALOR: %', 
      p_nu_equipe, v_co_equipe, v_no_tipo_grupo, insumo.nu_tipo_indicador, insumo.sg_tipo_indicador, 
      insumo.vr_peso_tipo_indicador, insumo.vr_faixa_fns, insumo.vr_peso_tipo_indicador * insumo.vr_faixa_fns;

    v_vr_soma_indicadores := v_vr_soma_indicadores + (insumo.vr_faixa_fns * insumo.vr_peso_tipo_indicador);
    v_vr_soma_pesos := v_vr_soma_pesos + insumo.vr_peso_tipo_indicador;

  end loop;

  if v_nu_tipo_indicador is not null then

    if v_vr_soma_pesos <> 0 then

      v_vr_calculo_indicador := v_vr_soma_indicadores / v_vr_soma_pesos;

      RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | IQ - Qualidade | SOMA DOS PESOS: %', 
        p_nu_equipe, v_co_equipe, v_no_tipo_grupo, v_vr_soma_pesos;

      RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | IQ - Qualidade | VALOR INDICADOR (A/B): % / % = %', 
        p_nu_equipe, v_co_equipe, v_no_tipo_grupo, v_vr_soma_indicadores, v_vr_soma_pesos, v_vr_calculo_indicador;
    end if;

    PERFORM gct.gctfn119_registrar_valor_indicador_equipe(p_nu_equipe, p_nu_fatura, p_dt_referencia, v_nu_tipo_indicador, v_vr_calculo_indicador, 'N');
  end if;

  return v_vr_calculo_indicador;

END;
$function$;

alter function gct.gctfn114_indicador_qualidade(p_nu_equipe numeric, p_nu_fatura numeric, p_dt_referencia date, p_nu_matricula numeric) owner to gct;

--------------------------------------------------------------------------------
-- -- gctfn115_indicador_turnover_equipe
-- --------------------------------------------------------------------------------

-- drop function if exists gct.gctfn115_indicador_turnover_equipe(p_nu_equipe numeric, p_nu_fatura numeric, p_dt_referencia date, p_nu_matricula numeric);

CREATE OR REPLACE FUNCTION gct.gctfn115_indicador_turnover_equipe(p_nu_equipe numeric, p_nu_fatura numeric, p_dt_referencia date, p_nu_matricula numeric)
 RETURNS numeric
 LANGUAGE plpgsql
AS $function$

/**

RELEASE NOTES

RTC 23671403 - SIGCT - Indicadores do contrato especializado

*/

DECLARE

  v_nu_tipo_indicador numeric;
  v_nu_tipo_grupo numeric;
  v_sg_tipo_indicador varchar;
  v_no_tipo_indicador varchar;
  v_nu_contrato numeric;
  v_no_tipo_grupo varchar;
  v_co_equipe varchar;

  v_dt_inicio_indicador date;
  v_dt_final_indicador date;
  v_vr_calculo_indicador numeric;

  v_sql text;

BEGIN

  --
  -- DETERMINANDO O PERIODO A SER CALCULADO OU DATA FINAL DO INDICADOR
  --
  v_dt_inicio_indicador = date_trunc('month', p_dt_referencia::date) - interval '1 month';
  v_dt_final_indicador := date_trunc('month', p_dt_referencia::date) - interval '1 day';  

  select
    ti.nu_tipo_indicador,
    trim(ti.sg_tipo_indicador),
    ti.no_tipo_indicador
  into 
    v_nu_tipo_indicador,
    v_sg_tipo_indicador,
    v_no_tipo_indicador
  from
    gct.gcttb010_contrato c
    inner join gct.gcttb264_amsta_equipe e on e.nu_contrato = c.nu_contrato
    inner join gct.gcttb033_grupo_contrato gc on (
      gc.nu_contrato = e.nu_contrato
      and gc.nu_tipo_grupo = e.nu_tipo_grupo
    )
    inner join gct.gcttb032_tipo_grupo tg on tg.nu_tipo_grupo = gc.nu_tipo_grupo
    inner join gct.gcttb115_grupo_indicador gi on (
      gi.nu_tipo_grupo = gc.nu_tipo_grupo
      and gi.nu_contrato = gc.nu_contrato
    )
    inner join gct.gcttb112_tipo_indicador ti on ( 
      ti.nu_tipo_indicador = gi.nu_tipo_indicador
      and ti.sg_tipo_indicador = 'IT'
    )
  where
    e.dt_referencia = p_dt_referencia
    and e.nu_equipe = p_nu_equipe;

  select 
    e.nu_contrato,
    e.co_equipe,
    tg.nu_tipo_grupo,
    tg.no_tipo_grupo
  into
    v_nu_contrato,
    v_co_equipe,
    v_nu_tipo_grupo,
    v_no_tipo_grupo 
  from
    gct.gcttb264_amsta_equipe e
    inner join gct.gcttb032_tipo_grupo tg on tg.nu_tipo_grupo = e.nu_tipo_grupo
  where
    e.dt_referencia = p_dt_referencia
    and e.nu_equipe = p_nu_equipe;

  if(v_sg_tipo_indicador is null) then
    RAISE NOTICE 'INDICADOR - EQUIPE: % | % GRUPO: % | O INDICADOR IT(Turnover) NAO FOI CONFIGURADO PARA O GRUPO.', 
      p_nu_equipe, v_co_equipe, v_no_tipo_grupo;
    return v_vr_calculo_indicador;  
  end if;

  --
  -- TURNOVER EH UM INDICADOR DA CONTRATADA, NAO VAMOS CALCULAR, SOMENTE RECUPERAR
  --
  RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | IT - Turnover | PERIODO: % a %', 
    p_nu_equipe, v_co_equipe, v_no_tipo_grupo, v_dt_inicio_indicador, v_dt_final_indicador;

  v_sql := '
    select
      vic.dt_inicio_indicador,
      vic.dt_final_indicador,
      vic.vr_calculo_indicador
    from
      gct.gcttb269_valor_indicador_contratada vic
      inner join gct.gcttb087_equipe e on e.nu_contrato = vic.nu_contrato
    where
      e.nu_equipe = $1
      and $2 between dt_inicio_indicador and coalesce(dt_final_indicador,$2)';

  execute v_sql 
    using p_nu_equipe, v_dt_final_indicador
     into v_dt_inicio_indicador, v_dt_final_indicador, v_vr_calculo_indicador;

  RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | IT - Turnover | PERIODO INDICADOR (TRIMESTRE): % A %', 
    p_nu_equipe, v_co_equipe, v_no_tipo_grupo, v_dt_inicio_indicador::date, v_dt_final_indicador::date;

  RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | IT - Turnover | VALOR INDICADOR CONTRATADA: %', 
    p_nu_equipe, v_co_equipe, v_no_tipo_grupo, v_vr_calculo_indicador;

  PERFORM gct.gctfn119_registrar_valor_indicador_equipe(p_nu_equipe, p_nu_fatura, p_dt_referencia, v_nu_tipo_indicador, v_vr_calculo_indicador);

  return v_vr_calculo_indicador;

END;
$function$;

alter function gct.gctfn115_indicador_turnover_equipe(p_nu_equipe numeric, p_nu_fatura numeric, p_dt_referencia date, p_nu_matricula numeric) owner to gct;

--------------------------------------------------------------------------------
-- -- gctfn116_calcular_fator_nivel_servico 
-- --------------------------------------------------------------------------------

-- drop function if exists gct.gctfn116_calcular_fator_nivel_servico(p_nu_equipe numeric, p_nu_fatura numeric, p_dt_referencia date, p_nu_matricula numeric);

CREATE OR REPLACE FUNCTION gct.gctfn116_calcular_fator_nivel_servico(p_nu_equipe numeric, p_nu_fatura numeric, p_dt_referencia date, p_nu_matricula numeric)
 RETURNS numeric
 LANGUAGE plpgsql
AS $function$

/**

RELEASE NOTES

RTC 23671403 - SIGCT - Indicadores do contrato especializado

*/

DECLARE

  v_nu_tipo_indicador numeric;
  v_nu_tipo_grupo numeric;
  v_sg_tipo_indicador varchar;
  v_no_tipo_indicador varchar;
  v_nu_contrato numeric;
  v_no_tipo_grupo varchar;
  v_co_equipe varchar;

  v_vr_faixa_fns numeric;
  v_qt_faixa_fns numeric;

  v_dt_inicio_indicador date;
  v_dt_final_indicador date;
  v_vr_calculo_indicador numeric;

  v_sql text;

  insumo record;
				
BEGIN

  --
  -- DETERMINANDO O PERIODO A SER CALCULADO
  --
  v_dt_inicio_indicador = date_trunc('month', p_dt_referencia::date) - interval '1 month';
  v_dt_final_indicador := date_trunc('month', p_dt_referencia::date) - interval '1 day' + time '23:59:59';

  select
    ti.nu_tipo_indicador,
    trim(ti.sg_tipo_indicador),
    ti.no_tipo_indicador
  into 
    v_nu_tipo_indicador,
    v_sg_tipo_indicador,
    v_no_tipo_indicador
  from
    gct.gcttb010_contrato c
    inner join gct.gcttb264_amsta_equipe e on e.nu_contrato = c.nu_contrato
    inner join gct.gcttb033_grupo_contrato gc on (
      gc.nu_contrato = e.nu_contrato
      and gc.nu_tipo_grupo = e.nu_tipo_grupo
    )
    inner join gct.gcttb032_tipo_grupo tg on tg.nu_tipo_grupo = gc.nu_tipo_grupo
    inner join gct.gcttb115_grupo_indicador gi on (
      gi.nu_tipo_grupo = gc.nu_tipo_grupo
      and gi.nu_contrato = gc.nu_contrato
    )
    inner join gct.gcttb112_tipo_indicador ti on ( 
      ti.nu_tipo_indicador = gi.nu_tipo_indicador
      and ti.sg_tipo_indicador = 'FNS'
    )
  where
    e.dt_referencia = p_dt_referencia
    and e.nu_equipe = p_nu_equipe;

  select 
    e.nu_contrato,
    e.co_equipe,
    tg.nu_tipo_grupo,
    tg.no_tipo_grupo
  into
    v_nu_contrato,
    v_co_equipe,
    v_nu_tipo_grupo,
    v_no_tipo_grupo 
  from
    gct.gcttb264_amsta_equipe e
    inner join gct.gcttb032_tipo_grupo tg on tg.nu_tipo_grupo = e.nu_tipo_grupo
  where
    e.dt_referencia = p_dt_referencia
    and e.nu_equipe = p_nu_equipe;

  if(v_sg_tipo_indicador is null) then
    RAISE NOTICE 'INDICADOR - EQUIPE: % | % GRUPO: % | INDICADOR FNS - Fator de Nivel de Servico - NAO FOI CONFIGURADO PARA O GRUPO.', 
      p_nu_equipe, v_co_equipe, v_no_tipo_grupo;
    return v_vr_calculo_indicador;  
  end if;

  v_vr_faixa_fns := 0;
  v_qt_faixa_fns := 0;

  v_sql := '
    select
      ti.nu_tipo_indicador,
      ti.sg_tipo_indicador,
      ti.no_tipo_indicador,
      vie.vr_faixa_fns
    from
      gct.gcttb172_valor_indicador_equipe vie
      inner join gct.gcttb102_fatura f on f.nu_fatura = vie.nu_fatura
      inner join gct.gcttb087_equipe e on e.nu_equipe = vie.nu_equipe
      inner join gct.gcttb115_grupo_indicador gi on (
        gi.nu_contrato = e.nu_contrato
        and gi.nu_tipo_grupo = e.nu_tipo_grupo
        and gi.nu_tipo_indicador = vie.nu_tipo_indicador
        and gi.ic_aplica_indicador = $1
        and gi.ic_compoe_fns = $2
      )
      inner join gct.gcttb112_tipo_indicador ti on ti.nu_tipo_indicador = vie.nu_tipo_indicador
    where
      vie.nu_equipe = $3
      and vie.nu_fatura = $4
      and vie.vr_faixa_fns is not null';

  RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | FNS - Fator de Nivel de Servico | PERIODO: % a %', 
    p_nu_equipe, v_co_equipe, v_no_tipo_grupo, v_dt_inicio_indicador, v_dt_final_indicador;

  for insumo in execute v_sql using 'N', 'S', p_nu_equipe, p_nu_fatura loop
    RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | FNS - Fator de Nivel de Servico | INDICADOR: % % | FAIXA FNS: %', 
      p_nu_equipe, v_co_equipe, v_no_tipo_grupo, insumo.nu_tipo_indicador, trim(insumo.sg_tipo_indicador), insumo.vr_faixa_fns;

    v_vr_faixa_fns := v_vr_faixa_fns + insumo.vr_faixa_fns;
    v_qt_faixa_fns := v_qt_faixa_fns + 1;
  end loop;

  if v_nu_tipo_indicador is not null then
    
    if v_qt_faixa_fns <> 0 then 
      v_vr_calculo_indicador := v_vr_faixa_fns / v_qt_faixa_fns;
    end if;

    RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | FNS - Fator de Nivel de Servico | VALOR INDICADOR (%/%): %', 
      p_nu_equipe, v_co_equipe, v_no_tipo_grupo, v_vr_faixa_fns, v_qt_faixa_fns, v_vr_calculo_indicador;

  end if;

  PERFORM gct.gctfn119_registrar_valor_indicador_equipe(p_nu_equipe, p_nu_fatura, p_dt_referencia, v_nu_tipo_indicador, v_vr_calculo_indicador, 'N');

  return v_vr_calculo_indicador;

END;
$function$;

alter function gct.gctfn116_calcular_fator_nivel_servico(p_nu_equipe numeric, p_nu_fatura numeric, p_dt_referencia date, p_nu_matricula numeric) owner to gct;

--------------------------------------------------------------------------------
-- -- gctfn118_gerar_termo_indicador
-- --------------------------------------------------------------------------------

-- drop function if exists gct.gctfn118_gerar_termo_indicador(p_nu_equipe numeric, p_nu_fatura numeric, p_nu_matricula numeric);

CREATE OR REPLACE FUNCTION gct.gctfn118_gerar_termo_indicador(p_nu_equipe numeric, p_nu_fatura numeric, p_nu_matricula numeric)
 RETURNS void
 LANGUAGE plpgsql
AS $function$

/**

RELEASE NOTES

RTC 23671403 - SIGCT - Indicadores do contrato especializado

*/

DECLARE

  v_vr_faixa_fns numeric;
  v_vr_ajustado numeric;
  v_nu_fatura_gerada numeric;

  termo record;
				
BEGIN

  --
  -- FATURA
  --  
  select
    fa.nu_fatura into v_nu_fatura_gerada
  from
    gct.gcttb102_fatura f
    inner join gct.gcttb102_fatura fa on (
      fa.nu_faturamento = f.nu_faturamento
      and fa.co_sitio = f.co_sitio
      and fa.nu_situacao_fatura = 2
    )
  where
    f.nu_fatura = p_nu_fatura;

  --
  -- ERRO! SE NAO HA FATURA ABERTA
  --  
  if v_nu_fatura_gerada is null then
    raise notice 'ERRO! NAO HA FATURA ABERTA';
    return;
  end if;

  --
  --
  --
  if exists (
    select
      null
    from
      gct.gcttb170_termo_equipe te
    where
      te.nu_equipe = p_nu_equipe
      and te.nu_tipo_termo = 21
      and te.nu_fatura_gerada = p_nu_fatura
      and te.nu_situacao_termo in (1, 3)
  )
  then
    raise notice 'ERRO! JA EXISTE TERMO DE INDICADOR, NAO SERA GERADO OUTRO PARA A FATURA %', p_nu_fatura;
    return;
  end if;

  --
  -- VALOR FNS
  --
  select
    sum(vie.vr_faixa_fns) into v_vr_faixa_fns
  from
    gct.gcttb115_grupo_indicador gi
    inner join gct.gcttb087_equipe e on (
      e.nu_contrato = gi.nu_contrato
      and e.nu_tipo_grupo = gi.nu_tipo_grupo
    )
    inner join gct.gcttb172_valor_indicador_equipe vie on (
      vie.nu_equipe = e.nu_equipe
      and vie.nu_tipo_grupo = gi.nu_tipo_grupo
      and vie.nu_tipo_indicador = gi.nu_tipo_indicador
    )
  where
    e.nu_equipe = p_nu_equipe
    and vie.nu_fatura = p_nu_fatura
    and gi.ic_aplica_indicador = 'S';

  --
  -- ERRO! NAO HA FNS CALCULADO
  --  
  if v_vr_faixa_fns is null then
    raise notice 'ERRO! NAO HA FNS CALCULADO';
    return;
  end if;

  --
  --
  --
  for termo in (
    select
      e.nu_equipe,
      e.co_equipe,
      tg.no_tipo_grupo,
      te.nu_termo_equipe,
      te.co_termo,
      te.vr_financeiro_termo
    from
      gct.gcttb170_termo_equipe te
      inner join gct.gcttb087_equipe e on e.nu_equipe = te.nu_equipe
      inner join gct.gcttb032_tipo_grupo tg on tg.nu_tipo_grupo = e.nu_tipo_grupo
    where
      te.nu_equipe = p_nu_equipe 
      and te.nu_fatura_gerada = p_nu_fatura
      and te.nu_tipo_termo = 11
      and te.nu_situacao_termo in (1, 3)  
  )
  loop

    v_vr_ajustado := (termo.vr_financeiro_termo * v_vr_faixa_fns) - termo.vr_financeiro_termo;

    perform gct.gctfn121_copiar_termo_equipe(termo.nu_termo_equipe, 21, v_nu_fatura_gerada, v_vr_ajustado);

    raise notice 'INDICADOR - EQUIPE: % % | GRUPO: % | TERMO AJUSTADO: % | VALOR FNS(A): % | VALOR TERMO(B): %',
      termo.nu_equipe, termo.co_equipe, termo.no_tipo_grupo, termo.co_termo, v_vr_faixa_fns, trunc(termo.vr_financeiro_termo,2); 
    raise notice 'INDICADOR - EQUIPE: % % | GRUPO: % | TERMO AJUSTADO: % | VALOR AJUSTE: (A * B) - A = (% * %) - % = %',
      termo.nu_equipe, termo.co_equipe, termo.no_tipo_grupo, termo.co_termo, v_vr_faixa_fns, 
      trunc(termo.vr_financeiro_termo,2), trunc(termo.vr_financeiro_termo,2), trunc(v_vr_ajustado,2); 

  end loop;

END;
$function$;

alter function gct.gctfn118_gerar_termo_indicador(p_nu_equipe numeric, p_nu_fatura numeric, p_nu_matricula numeric) owner to gct;

--------------------------------------------------------------------------------
-- -- gctfn119_registrar_valor_indicador_equipe
-- --------------------------------------------------------------------------------

-- drop function if exists gct.gctfn119_registrar_valor_indicador_equipe(p_nu_equipe numeric, p_nu_fatura numeric, p_dt_referencia date, p_nu_tipo_indicador numeric, p_vr_indicador numeric, p_ic_recupera_vr_faixa char);

CREATE OR REPLACE FUNCTION gct.gctfn119_registrar_valor_indicador_equipe(p_nu_equipe numeric, p_nu_fatura numeric, p_dt_referencia date, p_nu_tipo_indicador numeric, p_vr_indicador numeric, p_ic_recupera_vr_faixa char default 'S')
 RETURNS void
 LANGUAGE plpgsql
AS $function$
	
DECLARE 

  indicador record;

  v_dt_inicio_indicador date;
  v_dt_final_indicador date;
  v_vr_calculo_indicador numeric;
  v_vr_faixa_fns numeric;

BEGIN

  --
  -- DETERMINANDO O PERIODO A SER CALCULADO
  --
  v_dt_inicio_indicador = date_trunc('month', p_dt_referencia::date) - interval '1 month';
  v_dt_final_indicador := date_trunc('month', p_dt_referencia::date) - interval '1 day' + time '23:59:59';

  for indicador in (
    select
      e.nu_equipe,
      e.nu_contrato,
      e.nu_tipo_grupo,
      f.nu_fatura,
      f.dt_final_fatura,
      ti.nu_tipo_indicador,
      ti.sg_tipo_indicador,
      ti.no_tipo_indicador,
      gi.vr_peso_tipo_indicador
    from
      gct.gcttb264_amsta_equipe e
      inner join gct.gcttb033_grupo_contrato gc on (
        gc.nu_tipo_grupo = e.nu_tipo_grupo
        and gc.nu_contrato = e.nu_contrato
      )
      inner join gct.gcttb115_grupo_indicador gi on (
        gc.nu_contrato = gi.nu_contrato
        and gc.nu_tipo_grupo = gi.nu_tipo_grupo
      )
      inner join gct.gcttb112_tipo_indicador ti on ti.nu_tipo_indicador = gi.nu_tipo_indicador
      inner join gct.gcttb010_contrato c on c.nu_contrato = e.nu_contrato
      inner join gct.gcttb102_fatura f on f.nu_fatura = p_nu_fatura
    where
      e.dt_referencia = p_dt_referencia
      and gi.nu_tipo_indicador = p_nu_tipo_indicador
      and e.nu_equipe = p_nu_equipe
  )
  loop

    --
    -- REMOVE O CALCULO FEITO ANTEORIORMENTE
    --
    delete 
      from gct.gcttb172_valor_indicador_equipe 
    where 
      nu_fatura = indicador.nu_fatura
      and nu_equipe = indicador.nu_equipe
      and nu_tipo_indicador = indicador.nu_tipo_indicador
      and nu_tipo_grupo = indicador.nu_tipo_grupo
      and nu_contrato = indicador.nu_contrato;    

    v_vr_calculo_indicador := p_vr_indicador;
    v_vr_faixa_fns := null;

    if p_ic_recupera_vr_faixa = 'S' then
      v_vr_faixa_fns := gct.gctfn120_recuperar_valor_faixa(indicador.nu_contrato, indicador.nu_tipo_grupo, indicador.nu_tipo_indicador, p_vr_indicador);
    else
      v_vr_faixa_fns := p_vr_indicador;
    end if;  

    insert into gct.gcttb172_valor_indicador_equipe( 
      nu_fatura,
      nu_equipe,
      nu_tipo_grupo,
      nu_contrato,
      nu_tipo_indicador,
      dh_geracao_indicador_equipe,
      vr_calculo_indicador,
      dt_referencia,
      vr_peso_tipo_indicador,
      vr_faixa_fns,
      dt_inicio_indicador,
      dt_final_indicador
    )
    values (
      indicador.nu_fatura,
      indicador.nu_equipe,
      indicador.nu_tipo_grupo,
      indicador.nu_contrato,
      indicador.nu_tipo_indicador,
      current_timestamp,
      v_vr_calculo_indicador,
      indicador.dt_final_fatura,
      indicador.vr_peso_tipo_indicador,
      v_vr_faixa_fns,
      v_dt_inicio_indicador,
      v_dt_final_indicador
    );		

  end loop;

END;

$function$;

alter function gct.gctfn119_registrar_valor_indicador_equipe(p_nu_equipe numeric, p_nu_fatura numeric, p_dt_referencia date, p_nu_tipo_indicador numeric, p_vr_indicador numeric, p_ic_recupera_vr_faixa char) owner to gct;

--------------------------------------------------------------------------------
-- -- gctfn120_recuperar_valor_faixa
-- --------------------------------------------------------------------------------

-- drop function if exists gct.gctfn120_recuperar_valor_faixa(p_nu_contrato numeric, p_nu_tipo_grupo numeric, p_nu_tipo_indicador numeric, p_vr_calculo_indicador numeric);

CREATE OR REPLACE FUNCTION gct.gctfn120_recuperar_valor_faixa(p_nu_contrato numeric, p_nu_tipo_grupo numeric, p_nu_tipo_indicador numeric, p_vr_calculo_indicador numeric)
 RETURNS numeric
 LANGUAGE plpgsql
AS $function$

/**

RELEASE NOTES

RTC 23671403 - SIGCT - Indicadores do contrato especializado

*/

DECLARE

faixa record;

BEGIN

  -- raise notice '% % % %',
  --   p_nu_contrato, p_nu_tipo_grupo, p_nu_tipo_indicador, p_vr_calculo_indicador;    

  for faixa in (
    select
      ti.nu_tipo_indicador,
      ti.no_tipo_indicador,
      ti.sg_tipo_indicador,
      vf.qt_inicio_faixa,
      vf.qt_final_faixa,
      vf.vr_fator_faixa
    from
      gct.gcttb131_tipo_faixa_indicador tfi
      inner join gct.gcttb057_valor_faixa vf on tfi.nu_tipo_faixa = vf.nu_tipo_faixa
      inner join gct.gcttb056_tipo_faixa tf on tf.nu_tipo_faixa = vf.nu_tipo_faixa
      inner join gct.gcttb115_grupo_indicador gi on (
        gi.nu_contrato = tfi.nu_contrato
        and gi.nu_tipo_grupo = tfi.nu_tipo_grupo
        and gi.nu_tipo_indicador = tfi.nu_tipo_indicador
      )
      inner join gct.gcttb032_tipo_grupo tg on tg.nu_tipo_grupo = gi.nu_tipo_grupo
      inner join gct.gcttb112_tipo_indicador ti on ti.nu_tipo_indicador = tfi.nu_tipo_indicador
    where
      tfi.nu_contrato = p_nu_contrato
      and tfi.nu_tipo_grupo = p_nu_tipo_grupo
      and tfi.nu_tipo_indicador = p_nu_tipo_indicador
      and trunc(p_vr_calculo_indicador, 2) between vf.qt_inicio_faixa and vf.qt_final_faixa
  )
  loop

    RAISE NOTICE 'INDICADOR - VALOR FAIXA - INDICADOR: % - % | FAIXA: % A % | VALOR INDICADOR: % | VALOR FAIXA: %',
      faixa.nu_tipo_indicador, trim(faixa.sg_tipo_indicador), faixa.qt_inicio_faixa, faixa.qt_final_faixa,
      p_vr_calculo_indicador, faixa.vr_fator_faixa;

    return faixa.vr_fator_faixa;  

  end loop;

  return null;

END;

$function$;

alter function gct.gctfn120_recuperar_valor_faixa(p_nu_contrato numeric, p_nu_tipo_grupo numeric, p_nu_tipo_indicador numeric, p_vr_calculo_indicador numeric) owner to gct;

--------------------------------------------------------------------------------
-- -- gctfn121_copiar_termo_equipe
-- --------------------------------------------------------------------------------

-- drop function if exists gct.gctfn121_copiar_termo_equipe(p_nu_termo_equipe_ajustado numeric, p_nu_tipo_termo numeric, p_nu_fatura numeric, p_vr_finaceiro_termo numeric);

CREATE OR REPLACE FUNCTION gct.gctfn121_copiar_termo_equipe(p_nu_termo_equipe_ajustado numeric, p_nu_tipo_termo numeric, p_nu_fatura numeric, p_vr_finaceiro_termo numeric)
 RETURNS void
 LANGUAGE plpgsql
AS $function$

/**

RELEASE NOTES

RTC 23671403 - SIGCT - Indicadores do contrato especializado

Cria uma copia do termo ajusta, alterando o tipo para aquele informado
e cria um relacionamento entre eles

*/

DECLARE

  v_vr_faixa_fns numeric;
  v_vr_ajustado numeric;
  v_co_termo varchar;

  termo record;
				
BEGIN

  --
  -- CODIGO DO TERMO A SER GERADO
  --  
  select 
    gct.gctfn046_gerar_codigo_termo(te.nu_contrato, p_nu_tipo_termo) into v_co_termo
  from 
    gct.gcttb170_termo_equipe te 
  where 
    te.nu_termo_equipe = p_nu_termo_equipe_ajustado;

  insert into gct.gcttb170_termo_equipe
    select
      nextval('gct.gctsq170_nu_termo_equipe') nu_termo_equipe,
      te.nu_equipe,
      p_nu_tipo_termo as nu_tipo_termo,
      p_nu_fatura as nu_fatura_gerada,
      p_nu_fatura as nu_fatura_paga,
      current_timestamp as dh_emissao_termo,
      te.nu_contrato,
      te.co_sitio,
      te.nu_tipo_grupo,
      v_co_termo as co_termo,
      te.nu_situacao_termo,
      te.dt_inicio_atendimento_equipe,
      te.dt_final_atendimento_equipe,
      te.qt_membro_equipe_vigente,
      te.vr_preco_grupo,
      te.vr_previsto_equipe,
      te.vr_previsto_calculado_equipe,
      te.qt_dia_servico_extra,
      te.qt_dia_ausencia,
      te.vr_decrescimo,
      te.vr_acrescimo,
      p_vr_finaceiro_termo as vr_financeiro_termo,
      p_vr_finaceiro_termo as vr_financeiro_termo_original,
      te.nu_area_interna_pagadora,
      te.nu_matricula_responsavel_area_pagadora,
      te.no_sigla_area_pagadora,
      te.ic_tipo_atendimento,
      te.ic_dias_calculo_pagamento,
      te.ic_permite_servico_extra,
      te.ic_permite_registro_ausencia,
      te.ic_calculo_pro_rata,
      te.nu_tipo_preco,
      te.nu_motivo_termo,
      te.ic_aplica_ajuste,
      p_nu_termo_equipe_ajustado as nu_termo_ajustado,
      te.nu_acao_historico,
      te.nu_mtrca_acao_hstro,
      te.nu_ajuste,
      te.nu_situacao_pagamento,
      te.nu_comunidade,
      te.ic_compoe_ajuste,
      te.nu_rubrica_padrao,
      te.co_rubrica_padrao,
      te.no_comunidade,
      te.nu_repactuacao,
      te.nu_repactuacao_ajuste_previo,
      te.pc_desconto_proporcional,
      te.vr_desconto_proporcional,
      te.qt_dias_faturamento,
      te.nu_equipe_epzdo,
      te.qt_dia_util_faturamento,
      te.nu_agrupamento
    from
      gct.gcttb170_termo_equipe te
    where
      te.nu_termo_equipe = p_nu_termo_equipe_ajustado;

END;
$function$;

alter function gct.gctfn121_copiar_termo_equipe(p_nu_termo_equipe_ajustado numeric, p_nu_tipo_termo numeric, p_nu_fatura numeric, p_vr_finaceiro_termo numeric) owner to gct;

--------------------------------------------------------------------------------
-- -- gctfn122_indicador_efetividade_suporte
-- --------------------------------------------------------------------------------

-- drop function if exists gct.gctfn122_indicador_efetividade_suporte(p_nu_equipe numeric, p_nu_fatura numeric, p_dt_referencia date, p_nu_matricula numeric);

CREATE OR REPLACE FUNCTION gct.gctfn122_indicador_efetividade_suporte(p_nu_equipe numeric, p_nu_fatura numeric, p_dt_referencia date, p_nu_matricula numeric)
 RETURNS numeric
 LANGUAGE plpgsql
AS $function$

/**

RELEASE NOTES

RTC 23671403 - SIGCT - Indicadores do contrato especializado

*/

DECLARE

  v_nu_tipo_indicador numeric;
  v_nu_tipo_grupo numeric;
  v_sg_tipo_indicador varchar;
  v_no_tipo_indicador varchar;
  v_nu_contrato numeric;
  v_no_tipo_grupo varchar;
  v_co_equipe varchar;
  v_qt_itens_atendidos numeric;
  v_qt_itens_contratados numeric;

  v_vr_calculo_indicador numeric;
  v_dt_inicio_indicador timestamp;
  v_dt_final_indicador timestamp;

  v_sql text;  
				
BEGIN

  --
  -- DETERMINANDO O PERIODO A SER CALCULADO
  --
  v_dt_inicio_indicador = date_trunc('month', p_dt_referencia::date) - interval '1 month';
  v_dt_final_indicador := date_trunc('month', p_dt_referencia::date) - interval '1 day' + time '23:59:59';

  v_nu_tipo_indicador := 37;  -- FIXO CONFORME CARGA FEITA

  select
    trim(ti.sg_tipo_indicador),
    ti.no_tipo_indicador
  into 
    v_sg_tipo_indicador,
    v_no_tipo_indicador
  from
    gct.gcttb010_contrato c
    inner join gct.gcttb264_amsta_equipe e on e.nu_contrato = c.nu_contrato
    inner join gct.gcttb033_grupo_contrato gc on (
      gc.nu_contrato = e.nu_contrato
      and gc.nu_tipo_grupo = e.nu_tipo_grupo
    )
    inner join gct.gcttb032_tipo_grupo tg on tg.nu_tipo_grupo = gc.nu_tipo_grupo
    inner join gct.gcttb115_grupo_indicador gi on (
      gi.nu_tipo_grupo = gc.nu_tipo_grupo
      and gi.nu_contrato = gc.nu_contrato
    )
    inner join gct.gcttb112_tipo_indicador ti on ( 
      ti.nu_tipo_indicador = gi.nu_tipo_indicador
      and ti.nu_tipo_indicador = v_nu_tipo_indicador
    )
  where
    e.dt_referencia = p_dt_referencia
    and e.nu_equipe = p_nu_equipe;

  select 
    e.nu_contrato,
    e.co_equipe,
    tg.nu_tipo_grupo,
    tg.no_tipo_grupo
  into
    v_nu_contrato,
    v_co_equipe,
    v_nu_tipo_grupo,
    v_no_tipo_grupo 
  from
    gct.gcttb264_amsta_equipe e
    inner join gct.gcttb032_tipo_grupo tg on tg.nu_tipo_grupo = e.nu_tipo_grupo
  where
    e.dt_referencia = p_dt_referencia
    and e.nu_equipe = p_nu_equipe;

  if(v_sg_tipo_indicador is null) then
    RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | O INDICADOR IE - Efetividade(Suporte) NAO FOI CONFIGURADO PARA O GRUPO.', 
      p_nu_equipe, v_co_equipe, v_no_tipo_grupo;
    return v_vr_calculo_indicador;  
  end if;

  --
  -- SUPORTE
  --
  --
  -- IE = Quantidade_Itens_Atendidos / Quantidade_Itens_Backlog
  --

  --
  -- Quantidade_Itens_Atendidos
  --
  v_sql := '
    select
      count(distinct s.co_solicitacao) 
    from
      gct.gcttb266_amsta_slctco_equipe se
      inner join gct.gcttb264_amsta_equipe e on (
        e.dt_referencia = se.dt_referencia
        and e.nu_contrato = se.nu_contrato
        and e.nu_equipe = se.nu_equipe
      )
      inner join gct.gcttb265_amsta_solicitacao s on (
        s.dt_referencia = se.dt_referencia
        and s.nu_contrato = se.nu_contrato
        and s.nu_equipe = se.nu_equipe
      )
      inner join gct.gcttb191_servico_entregue se1 on (
        s.nu_situacao_solicitacao = se1.nu_situacao_atendimento
        and se1.nu_contrato = e.nu_contrato
        and se1.nu_tipo_grupo = e.nu_tipo_grupo
        and se1.nu_tipo_indicador = $1
      )      
    where
      se.dt_referencia = $2
      and se.nu_contrato = $3
      and se.nu_equipe = $4
      and s.dh_efetiva::date between $5::date and $6::date
      and se.ic_solicitacao_compoe_fns = $7
      and se.co_falha_solicitacao = $8';

  execute v_sql 
    using v_nu_tipo_indicador, p_dt_referencia, v_nu_contrato, p_nu_equipe, v_dt_inicio_indicador, v_dt_final_indicador, 'S', 'NF' 
     into v_qt_itens_atendidos;      

  --
  -- Quantidade_Itens_Backlog
  --
  v_sql := '
    select
      count(distinct s.co_solicitacao)
    from
      gct.gcttb266_amsta_slctco_equipe se
      inner join gct.gcttb264_amsta_equipe e on (
        e.dt_referencia = se.dt_referencia
        and e.nu_contrato = se.nu_contrato
        and e.nu_equipe = se.nu_equipe
      )
      inner join gct.gcttb265_amsta_solicitacao s on (
        s.dt_referencia = se.dt_referencia
        and s.nu_contrato = se.nu_contrato
        and s.nu_equipe = se.nu_equipe
      )
      inner join gct.gcttb192_servico_contratado se1 on (
        s.nu_situacao_solicitacao = se1.nu_situacao_atendimento
        and se1.nu_contrato = e.nu_contrato
        and se1.nu_tipo_grupo = e.nu_tipo_grupo
        and se1.nu_tipo_indicador = $1
      )      
    where
      se.dt_referencia = $2
      and se.nu_contrato = $3
      and se.nu_equipe = $4
      and s.dh_prevista::date between $5::date and $6::date
      and se.ic_solicitacao_compoe_fns = $7
      and se.co_falha_solicitacao = $8';

  execute v_sql 
    using v_nu_tipo_indicador, p_dt_referencia, v_nu_contrato, p_nu_equipe, v_dt_inicio_indicador, v_dt_final_indicador, 'S', 'NF' 
     into v_qt_itens_contratados;       

  v_vr_calculo_indicador := 1::numeric;

  if v_nu_tipo_indicador is not null then

    RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | IE - Efetividade(Suporte) - PERIODO: % a %', 
      p_nu_equipe, v_co_equipe, v_no_tipo_grupo, v_dt_inicio_indicador, v_dt_final_indicador;

    RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | IE - Efetividade(Suporte) - QT. ITENS ATENDIDOS (A): %', 
      p_nu_equipe, v_co_equipe, v_no_tipo_grupo, v_qt_itens_atendidos;

    RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | IE - Efetividade(Suporte) - QT. ITENS CONTRATADOS (B): %', 
      p_nu_equipe, v_co_equipe, v_no_tipo_grupo, v_qt_itens_contratados;

    if v_qt_itens_contratados <> 0 then
      v_vr_calculo_indicador := v_qt_itens_atendidos / v_qt_itens_contratados;
    end if;

    RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | IE - Efetividade(Suporte) - VALOR INDICADOR (A/B): %/% = %', 
      p_nu_equipe, v_co_equipe, v_no_tipo_grupo, v_qt_itens_atendidos, v_qt_itens_contratados, v_vr_calculo_indicador;

    PERFORM gct.gctfn119_registrar_valor_indicador_equipe(p_nu_equipe, p_nu_fatura, p_dt_referencia, v_nu_tipo_indicador, v_vr_calculo_indicador, 'S');
  end if;

  return v_vr_calculo_indicador;

END;
$function$;

alter function gct.gctfn122_indicador_efetividade_suporte(p_nu_equipe numeric, p_nu_fatura numeric, p_dt_referencia date, p_nu_matricula numeric) owner to gct;

--------------------------------------------------------------------------------
-- -- gctfn123_coletar_amostra_indicadores
-- --------------------------------------------------------------------------------

-- drop function if exists gct.gctfn123_coletar_amostra_indicadores(p_dt_referencia date, p_nu_contrato numeric, p_nu_equipe numeric);

CREATE OR REPLACE FUNCTION gct.gctfn123_coletar_amostra_indicadores(p_dt_referencia date, p_nu_contrato numeric default NULL::numeric, p_nu_equipe numeric default NULL::numeric)
 RETURNS void
 LANGUAGE plpgsql
AS $function$

/*

RELEASE NOTES

RTC 23671403 - SIGCT - Indicadores do contrato especializado

*/

DECLARE

  v_sql text;

  v_dt_inicio_indicador date;
  v_dt_final_indicador date;  

BEGIN

  --
  -- DETERMINANDO O PERIODO A SER CALCULADO
  --
  v_dt_inicio_indicador = p_dt_referencia - interval '1 month';
  v_dt_final_indicador = p_dt_referencia - interval '1 day';

  --
  --
  --

  --
  -- EQUIPES
  --
  v_sql := 'delete from gct.gcttb264_amsta_equipe a where dt_referencia = $1';

  if p_nu_contrato is not null then
    v_sql := v_sql || ' and a.nu_contrato = ' || p_nu_contrato;
  end if;

  if p_nu_equipe is not null then
    v_sql := v_sql || ' and a.nu_equipe = ' || p_nu_equipe;
  end if;  
  
  execute v_sql using p_dt_referencia;

  v_sql := '
    insert into gct.gcttb264_amsta_equipe(
      dt_referencia,
      nu_contrato,
      nu_equipe,
      co_equipe,
      nu_situacao_equipe,
      nu_area_interna,
      nu_tipo_grupo,
      co_sitio,
      de_equipe,
      dt_solicitacao_alocacao,
      dt_inicio_atendimento,
      dt_final_atendimento,
      vr_previsto_calculado,
      dh_inclusao_informacao,
      nu_acao_historico,
      nu_mtrca_acao_hstro,
      de_justificativa_alteracao,
      dh_amostra
    )
    select
      $1 as dt_referencia, 
      a.nu_contrato,
      a.nu_equipe,
      a.co_equipe,
      a.nu_situacao_equipe,
      a.nu_area_interna,
      a.nu_tipo_grupo,
      a.co_sitio,
      a.de_equipe,
      a.dt_solicitacao_alocacao,
      a.dt_inicio_atendimento,
      a.dt_final_atendimento,
      a.vr_previsto_calculado,
      a.dh_inclusao_informacao,
      a.nu_acao_historico,
      a.nu_mtrca_acao_hstro,
      a.de_justificativa_alteracao,
      current_timestamp as dh_amostra
    from
      gct.gcttb087_equipe a
      inner join gct.gcttb033_grupo_contrato gc on (
        gc.nu_contrato = a.nu_contrato
        and gc.nu_tipo_grupo = a.nu_tipo_grupo
        and gc.nu_tp_frma_calculo_pgto = 4 -- ESPECIALIZADO
      )
    where 1=1 ';

  if p_nu_contrato is not null then
    v_sql := v_sql || ' and gc.nu_contrato = ' || p_nu_contrato;
  end if;

  if p_nu_equipe is not null then
    v_sql := v_sql || ' and a.nu_equipe = ' || p_nu_equipe;
  end if;

  RAISE NOTICE 'INDICADOR - AMOSTRAS EQUIPES: %', p_dt_referencia;
  execute v_sql using p_dt_referencia;

  --
  -- SOLICITACAO EQUIPE
  --
  v_sql := 'delete from gct.gcttb266_amsta_slctco_equipe a where a.dt_referencia = $1';

  if p_nu_contrato is not null then
    v_sql := v_sql || ' and a.nu_contrato = ' || p_nu_contrato;
  end if;

  if p_nu_equipe is not null then
    v_sql := v_sql || ' and a.nu_equipe = ' || p_nu_equipe;
  end if;   

  execute v_sql using p_dt_referencia; 

  v_sql := '
    insert into gct.gcttb266_amsta_slctco_equipe(
      dt_referencia,
      nu_contrato,
      nu_equipe,
      nu_solicitacao_equipe,
      nu_ciclo_trabalho,
      nu_solicitacao,
      nu_tipo_servico,
      nu_tamanho_servico,
      nu_demanda,
      ic_solicitacao_compoe_fns,
      co_falha_solicitacao,
      vr_questionario_avaliacao,
      vr_nota_qualidade_produto,
      vr_total_apurado_avaliacao,
      nu_mtrca_avaliacao_equipe,
      dh_avaliacao_solicitacao,
      nu_ajuste,
      nu_fatura_ajuste,
      nu_rubrica,
      nu_fatura_previa,
      nu_comunidade,
      co_rubrica,
      no_comunidade,
      co_forma_vinculacao,
      de_justificativa_alteracao,
      de_justificativa_falha,
      nu_acao_historico,
      nu_execucao,
      nu_mtrca_acao_hstro,
      nu_mtrca_avaliacao_solicitacao,
      nu_ordem_servico,
      no_tipo_servico,
      ic_bef,
      ic_bef_pode_ajustar_rubrica,
      dh_amostra
    )
    select distinct
      $1 as dt_referencia,
      c.nu_contrato, 
      se.nu_equipe,
      se.nu_solicitacao_equipe,
      se.nu_ciclo_trabalho,
      se.nu_solicitacao,
      se.nu_tipo_servico,
      se.nu_tamanho_servico,
      se.nu_demanda,
      sc.ic_servico_compoe_calculo_fns as ic_solicitacao_compoe_fns,
      coalesce(se.co_falha_solicitacao, ''NF'') as co_falha_solicitacao,
      se.vr_questionario_avaliacao,
      se.vr_nota_qualidade_produto,
      se.vr_total_apurado_avaliacao,
      cct.nu_mtrca_avaliacao_equipe,
      se.dh_avaliacao_solicitacao,
      null::numeric nu_ajuste,
      null::numeric nu_fatura_ajuste,
      gct.gctfn135_recuperar_rubrica(sc.nu_contrato, sc.nu_tipo_grupo, se.nu_tipo_servico, se.nu_solicitacao),
      null::numeric nu_fatura_previa,
      com.nu_comunidade,
      (
        select co_rubrica 
          from gct.gcttb071_rubrica r 
        where r.nu_rubrica = gct.gctfn135_recuperar_rubrica(sc.nu_contrato, sc.nu_tipo_grupo, se.nu_tipo_servico, se.nu_solicitacao)
      ) as co_rubrica,
      com.no_comunidade,
      se.co_forma_vinculacao,
      se.de_justificativa_alteracao,
      se.de_justificativa_falha,
      se.nu_acao_historico,
      se.nu_execucao,
      se.nu_mtrca_acao_hstro,
      se.nu_mtrca_avaliacao_solicitacao,
      se.nu_ordem_servico,
      ts.no_tipo_servico,
      s.ic_bef,
      sc.ic_bef_pode_ajustar_rubrica,
      current_timestamp as dh_amostra 
    from
      gct.gcttb010_contrato c
      inner join gct.gcttb033_grupo_contrato gc on (gc.nu_contrato = c.nu_contrato)
      inner join gct.gcttb032_tipo_grupo tg on (tg.nu_tipo_grupo = gc.nu_tipo_grupo)
      inner join gct.gcttb087_equipe e on (
        e.nu_contrato = gc.nu_contrato
        and e.nu_tipo_grupo = gc.nu_tipo_grupo
        and gc.nu_tp_frma_calculo_pgto = 4 -- ESPECIALIZADO
      )
      inner join gct.gcttb001_area_interna ai on (ai.nu_area_interna = e.nu_area_interna)
      inner join gct.gcttb086_solicitacao_equipe se on (se.nu_equipe = e.nu_equipe)
      inner join gct.gcttb005_solicitacao s on s.nu_solicitacao = se.nu_solicitacao
      inner join gct.gcttb015_tipo_servico ts on ts.nu_tipo_servico = se.nu_tipo_servico
      inner join gct.gcttb055_servico_contrato sc on (
        sc.nu_tipo_servico = se.nu_tipo_servico
        and gc.nu_contrato = sc.nu_contrato
        and gc.nu_tipo_grupo = sc.nu_tipo_grupo
      )
      inner join gct.gcttb405_comunidade com on com.nu_comunidade = ai.nu_comunidade
      left join gct.gcttb088_ciclo_trabalho cct on (
        cct.nu_equipe = se.nu_equipe 
        and se.nu_ciclo_trabalho = cct.nu_ciclo_trabalho
      )
    where 1=1 ';

  if p_nu_contrato is not null then
    v_sql := v_sql || ' and gc.nu_contrato = ' || p_nu_contrato;
  end if;

  if p_nu_equipe is not null then
    v_sql := v_sql || ' and e.nu_equipe = ' || p_nu_equipe;
  end if;

  RAISE NOTICE 'INDICADOR - AMOSTRAS SOLICITACOES EQUIPES: %', p_dt_referencia;
  execute v_sql using p_dt_referencia;

  --
  -- CICLOS
  --
  v_sql := 'delete from gct.gcttb267_amsta_ciclo_trabalho a where a.dt_referencia = $1';
  
  if p_nu_contrato is not null then
    v_sql := v_sql || ' and a.nu_contrato = ' || p_nu_contrato;
  end if;

  if p_nu_equipe is not null then
    v_sql := v_sql || ' and a.nu_equipe = ' || p_nu_equipe;
  end if;    
  
  execute v_sql using p_dt_referencia;

  v_sql := '
    insert into gct.gcttb267_amsta_ciclo_trabalho(
      dt_referencia,
      nu_contrato,
      nu_equipe,
      nu_ciclo_trabalho,
      nu_situacao_ciclo_trabalho,
      de_ciclo_trabalho,
      dt_inicio_ciclo_trabalho,
      dt_alvo_ciclo_trabalho,
      dt_final_ciclo_trabalho,
      co_falha_ciclo_trabalho,
      nu_acao_historico,
      nu_mtrca_acao_hstro,
      vr_questionario_avaliacao,
      vr_nota_qualidade_produto,
      vr_total_apurado_avaliacao,
      nu_mtrca_avaliacao_equipe,
      de_justificativa_falha,
      de_justificativa_alteracao,
      nu_mtrca_fechamento_equipe,
      dt_fechamento_ciclo_trabalho,
      de_justificativa_fechamento,
      de_justificativa_cancelar_fechamento,
      ic_nao_se_aplica,
      dh_amostra
    )
    select
      $1 as dt_referencia, 
      e.nu_contrato,
      a.nu_equipe,
      a.nu_ciclo_trabalho,
      a.nu_situacao_ciclo_trabalho,
      a.de_ciclo_trabalho,
      a.dt_inicio_ciclo_trabalho,
      a.dt_alvo_ciclo_trabalho,
      a.dt_final_ciclo_trabalho,
      a.co_falha_ciclo_trabalho,
      a.nu_acao_historico,
      a.nu_mtrca_acao_hstro,
      a.vr_questionario_avaliacao,
      a.vr_nota_qualidade_produto,
      a.vr_total_apurado_avaliacao,
      a.nu_mtrca_avaliacao_equipe,
      a.de_justificativa_falha,
      a.de_justificativa_alteracao,
      a.nu_mtrca_fechamento_equipe,
      a.dt_fechamento_ciclo_trabalho,
      a.de_justificativa_fechamento,
      a.de_justificativa_cancelar_fechamento,
      a.ic_nao_se_aplica,
      current_timestamp as dh_amostra
    from
      gct.gcttb088_ciclo_trabalho a
      inner join gct.gcttb087_equipe e on e.nu_equipe = a.nu_equipe
      inner join gct.gcttb033_grupo_contrato gc on (
        gc.nu_contrato = e.nu_contrato
        and gc.nu_tipo_grupo = e.nu_tipo_grupo
        and gc.nu_tp_frma_calculo_pgto = 4 -- ESPECIALIZADO
      )
    where 1=1 ';

  if p_nu_contrato is not null then
    v_sql := v_sql || ' and gc.nu_contrato = ' || p_nu_contrato;
  end if;

  if p_nu_equipe is not null then
    v_sql := v_sql || ' and e.nu_equipe = ' || p_nu_equipe;
  end if;

  RAISE NOTICE 'INDICADOR - AMOSTRAS SPRINTS: %', p_dt_referencia;
  execute v_sql using p_dt_referencia;

  --
  -- SOLICITACOES
  --
  v_sql := 'delete from gct.gcttb265_amsta_solicitacao a where a.dt_referencia = $1';
  
  if p_nu_contrato is not null then
    v_sql := v_sql || ' and a.nu_contrato = ' || p_nu_contrato;
  end if;

  if p_nu_equipe is not null then
    v_sql := v_sql || ' and a.nu_equipe = ' || p_nu_equipe;
  end if;    
  
  execute v_sql using p_dt_referencia;

  RAISE NOTICE 'INDICADOR - AMOSTRAS SOLICITACOES: %', p_dt_referencia;
  execute v_sql using p_dt_referencia;  

  v_sql := '
    insert into gct.gcttb265_amsta_solicitacao(
      dt_referencia,
      nu_contrato,
      nu_equipe,
      nu_solicitacao,
      nu_unidade_custo,
      nu_natural_custo,
      co_solicitacao,
      de_solicitacao,
      de_tipo_solicitacao,
      de_tipo_manutencao,
      de_pendencia,
      de_origem_solicitacao,
      de_situacao_solicitacao,
      co_siplo,
      co_acao_operacional,
      no_sigla_sistema,
      pc_atendimento_slcto,
      dh_processamento,
      no_solicitacao,
      de_versao_planejada,
      nu_quatidade_incluida,
      nu_quatidade_alterada,
      nu_quatidade_excluida,
      nu_sistema_intgo,
      no_item_portfolio,
      de_modulo,
      dh_inicio,
      dh_prevista,
      dh_efetiva,
      de_situacao_solicitacao_gct,
      co_solicitacao_pai,
      dh_cadastro,
      dh_resolucao,
      dh_modificacao,
      nu_situacao_solicitacao,
      dh_acionamento,
      de_equipe_responsavel,
      nu_acao_historico,
      nu_mtrca_acao_hstro,
      de_justificativa_alteracao,
      nu_execucao,
      nu_mtrca_alteracao_custo,
      dh_alteracao_custo,
      co_solicitacao_custo,
      ic_acesso_restrito,
      no_tipo_solicitacao,
      de_tipo_desenvolvimento,
      no_planejado_para,
      no_area_projeto,
      qt_erro,
      no_squad,
      ic_pendente_atualizacao,
      qt_pontos_historia,
      nu_item_portfolio,
      co_matrca_responsavel,
      nu_modulo,
      nu_solicitacao_pai,
      co_area_projeto,
      nu_tipo_situacao_vinculacao,
      no_tipo_grupo,
      no_tipo_servico,
      co_rubrica,
      ic_bef,
      no_modulo,
      nu_rubrica,
      sg_unidade_custo,
      co_solicitacao_bef,
      dh_avaliacao_bef,
      dh_amostra
    )
    select distinct on (a.nu_solicitacao)
      $1 as dt_referencia, 
      e.nu_contrato,
      e.nu_equipe,
      a.nu_solicitacao,
      a.nu_unidade_custo,
      a.nu_natural_custo,
      a.co_solicitacao,
      a.de_solicitacao,
      a.de_tipo_solicitacao,
      a.de_tipo_manutencao,
      a.de_pendencia,
      a.de_origem_solicitacao,
      a.de_situacao_solicitacao,
      a.co_siplo,
      a.co_acao_operacional,
      a.no_sigla_sistema,
      a.pc_atendimento_slcto,
      a.dh_processamento,
      a.no_solicitacao,
      a.de_versao_planejada,
      a.nu_quatidade_incluida,
      a.nu_quatidade_alterada,
      a.nu_quatidade_excluida,
      a.nu_sistema_intgo,
      a.no_item_portfolio,
      a.de_modulo,
      a.dh_inicio,
      a.dh_prevista,
      a.dh_efetiva,
      a.de_situacao_solicitacao_gct,
      a.co_solicitacao_pai,
      a.dh_cadastro,
      a.dh_resolucao,
      a.dh_modificacao,
      a.nu_situacao_solicitacao,
      a.dh_acionamento,
      a.de_equipe_responsavel,
      a.nu_acao_historico,
      a.nu_mtrca_acao_hstro,
      a.de_justificativa_alteracao,
      a.nu_execucao,
      a.nu_mtrca_alteracao_custo,
      a.dh_alteracao_custo,
      a.co_solicitacao_custo,
      a.ic_acesso_restrito,
      a.no_tipo_solicitacao,
      a.de_tipo_desenvolvimento,
      a.no_planejado_para,
      a.no_area_projeto,
      a.qt_erro,
      a.no_squad,
      a.ic_pendente_atualizacao,
      a.qt_pontos_historia,
      a.nu_item_portfolio,
      a.co_matrca_responsavel,
      a.nu_modulo,
      a.nu_solicitacao_pai,
      a.co_area_projeto,
      a.nu_tipo_situacao_vinculacao,
      a.no_tipo_grupo,
      a.no_tipo_servico,
      a.co_rubrica,
      a.ic_bef,
      a.no_modulo,
      a.nu_rubrica,
      a.sg_unidade_custo,
      a.co_solicitacao_bef,
      a.dh_avaliacao_bef,
      current_timestamp as dh_amostra
    from
      gct.gcttb005_solicitacao a
      inner join gct.gcttb086_solicitacao_equipe se on se.nu_solicitacao = a.nu_solicitacao
      inner join gct.gcttb087_equipe e on e.nu_equipe = se.nu_equipe
      inner join gct.gcttb033_grupo_contrato gc on (
        gc.nu_contrato = e.nu_contrato
        and gc.nu_tipo_grupo = e.nu_tipo_grupo
        and gc.nu_tp_frma_calculo_pgto = 4 -- ESPECIALIZADO
      )
    where 1=1 ';

  if p_nu_contrato is not null then
    v_sql := v_sql || ' and gc.nu_contrato = ' || p_nu_contrato;
  end if;

  if p_nu_equipe is not null then
    v_sql := v_sql || ' and e.nu_equipe = ' || p_nu_equipe;
  end if;

  v_sql := v_sql || ' order by a.nu_solicitacao';

  execute v_sql using p_dt_referencia;      

  --
  -- MEMBROS DAS EQUIPES
  --
  v_sql := 'delete from gct.gcttb268_amsta_membros_equipe a where a.dt_referencia = $1';
  
  if p_nu_contrato is not null then
    v_sql := v_sql || ' and a.nu_contrato = ' || p_nu_contrato;
  end if;

  if p_nu_equipe is not null then
    v_sql := v_sql || ' and a.nu_equipe = ' || p_nu_equipe;
  end if;    
  
  execute v_sql using p_dt_referencia;

  v_sql := '
    insert into gct.gcttb268_amsta_membros_equipe(
      dt_referencia,
      nu_contrato,
      nu_equipe,
      nu_vigencia_membro,
      nu_membro,
      nu_perfil,
      dt_inicio_membro,
      dt_fim_membro,
      nu_posicao_membro,
      pc_alocacao_membro,
      dh_amostra
    )
    select distinct
      $1 as dt_referencia,
      e.nu_contrato, 
      a.nu_equipe,
      a.nu_vigencia_membro,
      a.nu_membro,
      a.nu_perfil,
      a.dt_inicio_membro,
      a.dt_fim_membro,
      a.nu_posicao_membro,
      a.pc_alocacao_membro,
      current_timestamp as dh_amostra
    from
      gct.gcttb419_vigencia_membros_equipe a
      inner join gct.gcttb087_equipe e on e.nu_equipe = a.nu_equipe
      inner join gct.gcttb033_grupo_contrato gc on (
        gc.nu_contrato = e.nu_contrato
        and gc.nu_tipo_grupo = e.nu_tipo_grupo
        and gc.nu_tp_frma_calculo_pgto = 4 -- ESPECIALIZADO
      )
    where 1=1';

  if p_nu_contrato is not null then
    v_sql := v_sql || ' and gc.nu_contrato = ' || p_nu_contrato;
  end if;

  if p_nu_equipe is not null then
    v_sql := v_sql || ' and a.nu_equipe = ' || p_nu_equipe;
  end if;

  RAISE NOTICE 'INDICADOR - AMOSTRAS MEMBROS DAS EQUIPES: %', p_dt_referencia;
  execute v_sql using p_dt_referencia;

END;
$function$;

alter function gct.gctfn123_coletar_amostra_indicadores(p_dt_referencia date, p_nu_contrato numeric, p_nu_equipe numeric) owner to gct;

--------------------------------------------------------------------------------
-- -- gctfn124_indicador_desempenho_equipe
-- --------------------------------------------------------------------------------

-- drop function if exists gct.gctfn124_indicador_desempenho_equipe(p_nu_equipe numeric, p_nu_fatura numeric, p_dt_referencia date, p_nu_matricula numeric);

CREATE OR REPLACE FUNCTION gct.gctfn124_indicador_desempenho_equipe(p_nu_equipe numeric, p_nu_fatura numeric, p_dt_referencia date, p_nu_matricula numeric)
 RETURNS numeric
 LANGUAGE plpgsql
AS $function$

/**

RELEASE NOTES

RTC 23671403 - SIGCT - Indicadores do contrato especializado

*/

DECLARE

  v_nu_tipo_indicador numeric;
  v_nu_tipo_grupo numeric;
  v_sg_tipo_indicador varchar;
  v_no_tipo_indicador varchar;
  v_nu_contrato numeric;
  v_no_tipo_grupo varchar;
  v_co_equipe varchar;

  v_vr_iqrd numeric;
  v_vr_iqnp numeric;
  v_vr_soma_indicadores numeric;
  v_vr_soma_pesos numeric;

  v_dt_inicio_indicador date;
  v_dt_final_indicador date;
  v_vr_calculo_indicador numeric;

  insumo record;

  v_sql text;
				
BEGIN

  --
  -- DETERMINANDO O PERIODO A SER CALCULADO
  --
  v_dt_inicio_indicador = date_trunc('month', p_dt_referencia::date) - interval '1 month';
  v_dt_final_indicador := date_trunc('month', p_dt_referencia::date) - interval '1 day' + time '23:59:59';

  select
    ti.nu_tipo_indicador,
    trim(ti.sg_tipo_indicador),
    ti.no_tipo_indicador
  into 
    v_nu_tipo_indicador,
    v_sg_tipo_indicador,
    v_no_tipo_indicador
  from
    gct.gcttb010_contrato c
    inner join gct.gcttb264_amsta_equipe e on e.nu_contrato = c.nu_contrato
    inner join gct.gcttb033_grupo_contrato gc on (
      gc.nu_contrato = e.nu_contrato
      and gc.nu_tipo_grupo = e.nu_tipo_grupo
    )
    inner join gct.gcttb032_tipo_grupo tg on tg.nu_tipo_grupo = gc.nu_tipo_grupo
    inner join gct.gcttb115_grupo_indicador gi on (
      gi.nu_tipo_grupo = gc.nu_tipo_grupo
      and gi.nu_contrato = gc.nu_contrato
    )
    inner join gct.gcttb112_tipo_indicador ti on ( 
      ti.nu_tipo_indicador = gi.nu_tipo_indicador
      and ti.sg_tipo_indicador = 'IDE'
    )
  where
    e.dt_referencia = p_dt_referencia
    and e.nu_equipe = p_nu_equipe;

  select 
    e.nu_contrato,
    e.co_equipe,
    tg.nu_tipo_grupo,
    tg.no_tipo_grupo
  into
    v_nu_contrato,
    v_co_equipe,
    v_nu_tipo_grupo,
    v_no_tipo_grupo 
  from
    gct.gcttb264_amsta_equipe e
    inner join gct.gcttb032_tipo_grupo tg on tg.nu_tipo_grupo = e.nu_tipo_grupo
  where
    e.dt_referencia = p_dt_referencia
    and e.nu_equipe = p_nu_equipe;

  if(v_sg_tipo_indicador is null) then
    RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | O INDICADOR IDE(Desempenho da Equipe) NAO FOI CONFIGURADO PARA O GRUPO.', 
      p_nu_equipe, v_co_equipe, v_no_tipo_grupo;
    return v_vr_calculo_indicador;  
  end if;

  v_vr_calculo_indicador := 0;
  v_vr_soma_indicadores := 0;

  v_sql := '
    select
      ti.nu_tipo_indicador,
      ti.sg_tipo_indicador,
      vie.vr_peso_tipo_indicador,
      vie.vr_faixa_fns
    from
      gct.gcttb172_valor_indicador_equipe vie
      inner join gct.gcttb112_tipo_indicador ti on ti.nu_tipo_indicador = vie.nu_tipo_indicador
    where
      vie.nu_equipe = $1
      and vie.nu_fatura = $2
      and ti.nu_tipo_indicador in (36,38,39)';

  v_vr_soma_pesos := 0;

  RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | IDE - Desempenho da Equipe | PERIODO: % a %', 
    p_nu_equipe, v_co_equipe, v_no_tipo_grupo, v_dt_inicio_indicador, v_dt_final_indicador;

  for insumo in execute v_sql using p_nu_equipe, p_nu_fatura loop
    
    RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | IDE - Desempenho da Equipe | INDICADOR: % % | PESO: % | FAIXA FNS: % | VALOR: %', 
      p_nu_equipe, v_co_equipe, v_no_tipo_grupo, insumo.nu_tipo_indicador, trim(insumo.sg_tipo_indicador), 
      insumo.vr_peso_tipo_indicador, insumo.vr_faixa_fns, insumo.vr_peso_tipo_indicador * insumo.vr_faixa_fns;

    v_vr_soma_indicadores := v_vr_soma_indicadores + (insumo.vr_faixa_fns * insumo.vr_peso_tipo_indicador);
    v_vr_soma_pesos := v_vr_soma_pesos + insumo.vr_peso_tipo_indicador;

  end loop;

  if v_nu_tipo_indicador is not null then

    if v_vr_soma_pesos <> 0 then

      v_vr_calculo_indicador := v_vr_soma_indicadores / v_vr_soma_pesos;

      RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | IDE - Desempenho da Equipe | VALOR INDICADOR (A/B): % / % = %', 
        p_nu_equipe, v_co_equipe, v_no_tipo_grupo, v_vr_soma_indicadores, v_vr_soma_pesos, v_vr_calculo_indicador;
    end if;

    PERFORM gct.gctfn119_registrar_valor_indicador_equipe(p_nu_equipe, p_nu_fatura, p_dt_referencia, v_nu_tipo_indicador, v_vr_calculo_indicador, 'N');
  end if;

  return v_vr_calculo_indicador;

END;
$function$;

alter function gct.gctfn124_indicador_desempenho_equipe(p_nu_equipe numeric, p_nu_fatura numeric, p_dt_referencia date, p_nu_matricula numeric) owner to gct;

--------------------------------------------------------------------------------
-- -- gctfn137_obter_dt_considerar_fns_equipe
-- --------------------------------------------------------------------------------

-- drop function if exists gct.gctfn137_obter_dt_considerar_fns_equipe(p_nu_equipe numeric);

CREATE OR REPLACE FUNCTION gct.gctfn137_obter_dt_considerar_fns_equipe(p_nu_equipe numeric)
 RETURNS timestamp
 LANGUAGE plpgsql
AS $function$

/*

RELEASE NOTES

RTC 23671403 - SIGCT - Indicadores do contrato especializado

*/

DECLARE

  v_dt_considerar_fns       timestamp;
  v_co_equipe               varchar;
  v_co_solicitacao          varchar;
  v_no_situacao_solicitacao varchar;
  v_de_situacao_solicitacao varchar;

  v_json_text text;  

BEGIN
  
  select dt_considerar_fns into v_dt_considerar_fns from gct.gcttb087_equipe e where e.nu_equipe = p_nu_equipe;

  if v_dt_considerar_fns is null then

    select
      e.co_equipe,
      s.co_solicitacao,
      s.de_situacao_solicitacao,
      s.dh_inicio_desenvolvimento + interval '4 month' as dt_considerar_fns
    into
      v_co_equipe,
      v_co_solicitacao,
      v_de_situacao_solicitacao,
      v_dt_considerar_fns
    from
      gct.gcttb087_equipe e
      inner join gct.gcttb086_solicitacao_equipe se on se.nu_equipe = e.nu_equipe
      inner join gct.gcttb005_solicitacao s on s.nu_solicitacao = se.nu_solicitacao
    where
      e.nu_equipe = p_nu_equipe
      and s.dh_inicio_desenvolvimento is not null
      and s.dh_inicio_desenvolvimento >= e.dt_inicio_atendimento
    order by
      s.dh_inicio_desenvolvimento
    limit 1;

    if v_dt_considerar_fns is not null then

      update gct.gcttb087_equipe set dt_considerar_fns = v_dt_considerar_fns where nu_equipe = p_nu_equipe;

      v_json_text := '';
      v_json_text := v_json_text || '{';
      v_json_text := v_json_text || '"Equipe" :["' || v_co_equipe ||'"],';
      v_json_text := v_json_text || '"Data para Considerar FNS" :["'|| v_dt_considerar_fns::date ||'"],';
      v_json_text := v_json_text || '"Código da Solicitação" :["'|| v_co_solicitacao ||'"],';
      v_json_text := v_json_text || '"Situação da Solicitação" :["'|| v_de_situacao_solicitacao ||'"]';
      v_json_text := v_json_text || '}';

      INSERT INTO
        gct.gcttb308_historico_equipe (
          nu_historico_equipe,
          nu_acao_historico,
          nu_mtrca_acao_hstro,
          dh_acao_historico,
          de_campo_alterado,
          nu_equipe,
          nu_ciclo_trabalho,
          nu_solicitacao_equipe
        )
      VALUES
        (
          nextval('gct.gctsq308_nu_historico_equipe'),
          216,
          1,
          current_timestamp,
          v_json_text,
          p_nu_equipe,
          null,
          null
        );

    end if;

  end if;  

  return v_dt_considerar_fns;

END;
$function$;

alter function gct.gctfn137_obter_dt_considerar_fns_equipe(p_nu_equipe numeric) owner to gct;

--------------------------------------------------------------------------------
-- -- gctfn138_indicador_reducao_defeitos
-- --------------------------------------------------------------------------------

-- drop function if exists gct.gctfn138_indicador_reducao_defeitos(p_nu_equipe numeric, p_nu_fatura numeric, p_dt_referencia date, p_nu_matricula numeric);

CREATE OR REPLACE FUNCTION gct.gctfn138_indicador_reducao_defeitos(p_nu_equipe numeric, p_nu_fatura numeric, p_dt_referencia date, p_nu_matricula numeric)
 RETURNS numeric
 LANGUAGE plpgsql
AS $function$

/**

RELEASE NOTES

RTC 23671403 - SIGCT - Indicadores do contrato especializado

*/

DECLARE

  v_nu_tipo_indicador numeric;
  v_nu_tipo_grupo numeric;
  v_sg_tipo_indicador varchar;
  v_no_tipo_indicador varchar;
  v_nu_contrato numeric;
  v_no_tipo_grupo varchar;
  v_co_equipe varchar;
  v_dt_inicio_indicador date;
  v_dt_final_indicador date;
  v_dt_inicio_perido_anterior date;
  v_dt_final_perido_anterior date;

  v_qt_itens_estoque numeric;
  v_qt_itens_estoque_anterior numeric;
  v_qt_itens_entregues numeric;
  v_qt_itens_entregues_anterior numeric;

  v_vr_calculo_indicador numeric;

  v_sql text;
				
BEGIN

  --
  -- DETERMINANDO O PERIODO A SER CALCULADO
  --
  v_dt_inicio_indicador = date_trunc('month', p_dt_referencia::date) - interval '1 month';
  v_dt_final_indicador := date_trunc('month', p_dt_referencia::date) - interval '1 day' + time '23:59:59';

  v_dt_inicio_perido_anterior := v_dt_inicio_indicador - interval '1 month';
  v_dt_final_perido_anterior  := v_dt_inicio_indicador - interval '1 day';

  select
    ti.nu_tipo_indicador,
    trim(ti.sg_tipo_indicador),
    ti.no_tipo_indicador
  into 
    v_nu_tipo_indicador,
    v_sg_tipo_indicador,
    v_no_tipo_indicador
  from
    gct.gcttb010_contrato c
    inner join gct.gcttb264_amsta_equipe e on e.nu_contrato = c.nu_contrato
    inner join gct.gcttb033_grupo_contrato gc on (
      gc.nu_contrato = e.nu_contrato
      and gc.nu_tipo_grupo = e.nu_tipo_grupo
    )
    inner join gct.gcttb032_tipo_grupo tg on tg.nu_tipo_grupo = gc.nu_tipo_grupo
    inner join gct.gcttb115_grupo_indicador gi on (
      gi.nu_tipo_grupo = gc.nu_tipo_grupo
      and gi.nu_contrato = gc.nu_contrato
    )
    inner join gct.gcttb112_tipo_indicador ti on ( 
      ti.nu_tipo_indicador = gi.nu_tipo_indicador
      and ti.sg_tipo_indicador = 'IQRD'
    )
  where
    e.dt_referencia = p_dt_referencia
    and e.nu_equipe = p_nu_equipe;
    
  select 
    e.nu_contrato,
    e.co_equipe,
    tg.nu_tipo_grupo,
    tg.no_tipo_grupo
  into
    v_nu_contrato,
    v_co_equipe,
    v_nu_tipo_grupo,
    v_no_tipo_grupo 
  from
    gct.gcttb264_amsta_equipe e
    inner join gct.gcttb032_tipo_grupo tg on tg.nu_tipo_grupo = e.nu_tipo_grupo
  where
    e.dt_referencia = p_dt_referencia
    and e.nu_equipe = p_nu_equipe;

  if(v_sg_tipo_indicador is null) then
    RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | IQRD(Reducao de defeitos) NAO FOI CONFIGURADO PARA O GRUPO.', 
      p_nu_equipe, v_co_equipe, v_no_tipo_grupo;
    return v_vr_calculo_indicador;  
  end if;

  --
  -- Fator = (∑DPanterior + ∑DPatual) / (∑DP Corrigidosatual + ∑ DPanterior)
  --

  --
  -- Somatório da quantidade de Defeitos que constam abertos
  --
  v_sql := '
    select
      count(distinct s.co_solicitacao)
    from
      gct.gcttb266_amsta_slctco_equipe se
      inner join gct.gcttb264_amsta_equipe e on (
        e.dt_referencia = se.dt_referencia
        and e.nu_contrato = se.nu_contrato
        and e.nu_equipe = se.nu_equipe
        and e.dt_referencia = se.dt_referencia
      )
      inner join gct.gcttb265_amsta_solicitacao s on (
        s.dt_referencia = se.dt_referencia
        and s.nu_contrato = se.nu_contrato
        and s.nu_equipe = se.nu_equipe
        and se.nu_solicitacao = s.nu_solicitacao
      )
      inner join gct.gcttb192_servico_contratado se1 on (
        s.nu_situacao_solicitacao = se1.nu_situacao_atendimento
        and se1.nu_contrato = e.nu_contrato
        and se1.nu_tipo_grupo = e.nu_tipo_grupo
        and se1.nu_tipo_indicador = $1
      )      
    where
      se.nu_equipe = $2
      and s.dh_prevista between $3 and $4
      and se.ic_solicitacao_compoe_fns = $5
      and se.co_falha_solicitacao = $6';

  -- Somatório da quantidade de Defeitos que constam abertos (Periodo Anterior)
  execute v_sql 
    using v_nu_tipo_indicador, p_nu_equipe, v_dt_inicio_perido_anterior, v_dt_final_perido_anterior, 'S', 'NF' 
     into v_qt_itens_estoque_anterior;   

  -- Somatório da quantidade de Defeitos que constam abertos (Periodo Atual)
  execute v_sql 
    using v_nu_tipo_indicador, p_nu_equipe, v_dt_inicio_indicador, v_dt_final_indicador, 'S', 'NF' 
     into v_qt_itens_estoque;

  --
  -- Somatório da quantidade de Defeitos corrigidos/resolvidos no período
  --
  v_sql := '
    select
      count(distinct s.co_solicitacao)
    from
      gct.gcttb266_amsta_slctco_equipe se
      inner join gct.gcttb264_amsta_equipe e on (
        e.dt_referencia = se.dt_referencia
        and e.nu_contrato = se.nu_contrato
        and e.nu_equipe = se.nu_equipe
        and e.dt_referencia = se.dt_referencia
      )
      inner join gct.gcttb265_amsta_solicitacao s on (
        s.dt_referencia = se.dt_referencia
        and s.nu_contrato = se.nu_contrato
        and s.nu_equipe = se.nu_equipe
        and se.nu_solicitacao = s.nu_solicitacao
      )
      inner join gct.gcttb191_servico_entregue se1 on (
        s.nu_situacao_solicitacao = se1.nu_situacao_atendimento
        and se1.nu_contrato = e.nu_contrato
        and se1.nu_tipo_grupo = e.nu_tipo_grupo
        and se1.nu_tipo_indicador = $1
      )      
    where
      se.nu_equipe = $2
      and s.dh_prevista between $3 and $4
      and se.ic_solicitacao_compoe_fns = $5
      and se.co_falha_solicitacao = $6';

  -- Somatório da quantidade de Defeitos corrigidos/resolvidos no período anterior
  execute v_sql 
    using v_nu_tipo_indicador, p_nu_equipe, v_dt_inicio_perido_anterior, v_dt_final_perido_anterior, 'S', 'NF' 
     into v_qt_itens_entregues_anterior;   

  -- Somatório da quantidade de Defeitos corrigidos/resolvidos no período
  execute v_sql 
    using v_nu_tipo_indicador, p_nu_equipe, v_dt_inicio_indicador, v_dt_final_indicador, 'S', 'NF' 
     into v_qt_itens_entregues;

  RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | IQRD(Reducao de defeitos) | PERIODO ANTERIOR: % A %', 
    p_nu_equipe, v_co_equipe, v_no_tipo_grupo, v_dt_inicio_perido_anterior, v_dt_final_perido_anterior;

  RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | IQRD(Reducao de defeitos) | PERIODO: % a %', 
    p_nu_equipe, v_co_equipe, v_no_tipo_grupo, v_dt_inicio_indicador, v_dt_final_indicador;

  RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | IQRD(Reducao de defeitos) | ESTOQUE ANTERIOR(A): % | ESTOQUE(B): %', 
    p_nu_equipe, v_co_equipe, v_no_tipo_grupo, v_qt_itens_estoque_anterior, v_qt_itens_estoque;        

  RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | IQRD(Reducao de defeitos) | QT. ENTREGUES ANTERIOR(C): % | QT. ENTREGUES(D): %', 
    p_nu_equipe, v_co_equipe, v_no_tipo_grupo, v_qt_itens_entregues_anterior, v_qt_itens_entregues;        

  v_vr_calculo_indicador := 1::numeric;

  if v_nu_tipo_indicador is not null then

    if v_qt_itens_entregues_anterior + v_qt_itens_entregues_anterior <> 0 then
      v_vr_calculo_indicador := (v_qt_itens_entregues_anterior + v_qt_itens_entregues) / (v_qt_itens_estoque_anterior + v_qt_itens_estoque);
    end if;

    RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | IQRD(Reducao de defeitos) | VALOR INDICADOR (A + B)/(C + D): (% + %) / (% + %) = %', 
      p_nu_equipe, v_co_equipe, v_no_tipo_grupo, v_qt_itens_estoque_anterior, v_qt_itens_estoque, 
      v_qt_itens_entregues_anterior, v_qt_itens_entregues,
      v_vr_calculo_indicador;

    PERFORM gct.gctfn119_registrar_valor_indicador_equipe(p_nu_equipe, p_nu_fatura, p_dt_referencia, v_nu_tipo_indicador, v_vr_calculo_indicador, 'S');
  end if;

  return v_vr_calculo_indicador;

END;
$function$;

alter function gct.gctfn138_indicador_reducao_defeitos(p_nu_equipe numeric, p_nu_fatura numeric, p_dt_referencia date, p_nu_matricula numeric) owner to gct;

--------------------------------------------------------------------------------
-- -- gctfn139_indicador_nota_codigo
-- --------------------------------------------------------------------------------

-- drop function if exists gct.gctfn139_indicador_nota_codigo(p_nu_equipe numeric, p_nu_fatura numeric, p_dt_referencia date, p_nu_matricula numeric);

CREATE OR REPLACE FUNCTION gct.gctfn139_indicador_nota_codigo(p_nu_equipe numeric, p_nu_fatura numeric, p_dt_referencia date, p_nu_matricula numeric)
 RETURNS numeric
 LANGUAGE plpgsql
AS $function$

/**

RELEASE NOTES

RTC 23671403 - SIGCT - Indicadores do contrato especializado

*/

DECLARE

  v_nu_tipo_indicador numeric;
  v_nu_tipo_grupo numeric;
  v_sg_tipo_indicador varchar;
  v_no_tipo_indicador varchar;
  v_nu_contrato numeric;
  v_no_tipo_grupo varchar;
  v_co_equipe varchar;
  v_dt_inicio_indicador date;
  v_dt_final_indicador date;
  v_dt_inicio_perido_anterior date;
  v_dt_final_perido_anterior date;
  v_no_ciclo_apurado varchar;

  v_vr_calculo_indicador numeric;

  v_vr_soma_notas numeric;
  v_vr_soma_qt_atendimentos numeric;

  v_sql text;

  nota record;
				
BEGIN

  --
  -- DETERMINANDO O PERIODO A SER CALCULADO
  --
  v_dt_inicio_indicador = date_trunc('month', p_dt_referencia::date) - interval '1 month';
  v_dt_final_indicador := date_trunc('month', p_dt_referencia::date) - interval '1 day' + time '23:59:59';

  select
    ti.nu_tipo_indicador,
    trim(ti.sg_tipo_indicador),
    ti.no_tipo_indicador
  into 
    v_nu_tipo_indicador,
    v_sg_tipo_indicador,
    v_no_tipo_indicador
  from
    gct.gcttb010_contrato c
    inner join gct.gcttb264_amsta_equipe e on e.nu_contrato = c.nu_contrato
    inner join gct.gcttb033_grupo_contrato gc on (
      gc.nu_contrato = e.nu_contrato
      and gc.nu_tipo_grupo = e.nu_tipo_grupo
    )
    inner join gct.gcttb032_tipo_grupo tg on tg.nu_tipo_grupo = gc.nu_tipo_grupo
    inner join gct.gcttb115_grupo_indicador gi on (
      gi.nu_tipo_grupo = gc.nu_tipo_grupo
      and gi.nu_contrato = gc.nu_contrato
    )
    inner join gct.gcttb112_tipo_indicador ti on ( 
      ti.nu_tipo_indicador = gi.nu_tipo_indicador
      and ti.sg_tipo_indicador = 'IQNP'
    )
  where
    e.dt_referencia = p_dt_referencia
    and e.nu_equipe = p_nu_equipe;

  select 
    e.nu_contrato,
    e.co_equipe,
    tg.nu_tipo_grupo,
    tg.no_tipo_grupo
  into
    v_nu_contrato,
    v_co_equipe,
    v_nu_tipo_grupo,
    v_no_tipo_grupo 
  from
    gct.gcttb264_amsta_equipe e
    inner join gct.gcttb032_tipo_grupo tg on tg.nu_tipo_grupo = e.nu_tipo_grupo
  where
    e.dt_referencia = p_dt_referencia
    and e.nu_equipe = p_nu_equipe;

  if(v_sg_tipo_indicador is null) then
    RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | IQNP - Notas de Código NAO FOI CONFIGURADO PARA O GRUPO.', 
      p_nu_equipe, v_co_equipe, v_no_tipo_grupo;
    return v_vr_calculo_indicador;  
  end if;

  v_no_ciclo_apurado = to_char(v_dt_final_indicador, 'MM/YYYY');

  --
  -- 
  --
  -- Exemplo da média ponderada
  
  -- Exemplo:
  
  -- EQUIPE: A (atende mais de um)
  
  -- SIGCT: Nota 7 - 2 IBs atendidos
  -- SIPGC: Nota 8 - 3 IBs atendidos
  -- SIGID: Nota 6 - 5 IBs atendidos
  -- Média Ponderada = 
  -- (7 x 2) + (8 x 3) + (6 x 5) / 2 + 3 + 5 = 68 / 10 = 6,8
  
  -- EQUIPE: B (atende somente um)
  
  -- SIGID: Nota 6 - 5 IBs atendidos
  -- Média Ponderada = 
  -- (6 x 5) / 5 = 6,00

  --
  -- Somatório da quantidade de Defeitos que constam abertos
  --
  v_sql := '
    select
      s.no_sigla_sistema,
      coalesce(n.vr_nota_apurada, 10) vr_nota,
      count(distinct s.co_solicitacao) qt_solicitacoes
    from
      gct.gcttb266_amsta_slctco_equipe se
      inner join gct.gcttb264_amsta_equipe e on (
        e.dt_referencia = se.dt_referencia
        and e.nu_contrato = se.nu_contrato
        and e.nu_equipe = se.nu_equipe
        and e.dt_referencia = se.dt_referencia
      )
      inner join gct.gcttb265_amsta_solicitacao s on (
        s.dt_referencia = se.dt_referencia
        and s.nu_contrato = se.nu_contrato
        and s.nu_equipe = se.nu_equipe
        and se.nu_solicitacao = s.nu_solicitacao
      )
      inner join gct.gcttb192_servico_contratado se1 on (
        s.nu_situacao_solicitacao = se1.nu_situacao_atendimento
        and se1.nu_contrato = e.nu_contrato
        and se1.nu_tipo_grupo = e.nu_tipo_grupo
        and se1.nu_tipo_indicador = $1
      )
      left join gct.gcttb263_nota_codigo n on (
        n.no_sigla_sistema = s.no_sigla_sistema
        and n.no_ciclo_apurado = $2
      )
    where
      se.nu_equipe = $3
      and s.dh_prevista between $4 and $5
      and se.ic_solicitacao_compoe_fns = $6
      and se.co_falha_solicitacao = $7
    group by
      s.no_sigla_sistema,
      coalesce(n.vr_nota_apurada, 10)';

  v_vr_soma_notas := 0;
  v_vr_soma_qt_atendimentos := 0;

  RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | IQNP - Notas de Código - PERIODO: % a %', 
    p_nu_equipe, v_co_equipe, v_no_tipo_grupo, v_dt_inicio_indicador, v_dt_final_indicador;

  for nota in execute v_sql using v_nu_tipo_indicador, v_no_ciclo_apurado, p_nu_equipe, v_dt_inicio_indicador, v_dt_final_indicador, 'S', 'NF'
  loop
    RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | IQNP - Notas de Código | SIGLA: % | NOTA: % | QT. ATENDIMENTOS: %', 
      p_nu_equipe, v_co_equipe, v_no_tipo_grupo, nota.no_sigla_sistema, nota.vr_nota, nota.qt_solicitacoes;
     v_vr_soma_notas = v_vr_soma_notas + (nota.vr_nota * nota.qt_solicitacoes);    
     v_vr_soma_qt_atendimentos = v_vr_soma_qt_atendimentos + (nota.qt_solicitacoes);    
  end loop;     

  v_vr_calculo_indicador := 1::numeric;

  RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | IQNP - Notas de Código | SOMA NOTAS: % | SOMA QT. ATENDIMENTOS: %', 
    p_nu_equipe, v_co_equipe, v_no_tipo_grupo, v_vr_soma_notas, v_vr_soma_qt_atendimentos;    

  if v_nu_tipo_indicador is not null then

    if v_vr_soma_qt_atendimentos <> 0 then
      v_vr_calculo_indicador := v_vr_soma_notas/v_vr_soma_qt_atendimentos;
    end if;

    RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | IQNP - Notas de Código | VALOR INDICADOR soma(A)/soma(B): (% / %) = %', 
      p_nu_equipe, v_co_equipe, v_no_tipo_grupo, v_vr_soma_notas, v_vr_soma_qt_atendimentos, 
      v_vr_calculo_indicador;

    PERFORM gct.gctfn119_registrar_valor_indicador_equipe(p_nu_equipe, p_nu_fatura, p_dt_referencia, v_nu_tipo_indicador, v_vr_calculo_indicador, 'S');
  end if;

  return v_vr_calculo_indicador;

END;
$function$;

alter function gct.gctfn139_indicador_nota_codigo(p_nu_equipe numeric, p_nu_fatura numeric, p_dt_referencia date, p_nu_matricula numeric) owner to gct;

--------------------------------------------------------------------------------
-- -- gctfn141_indicador_desempenho_global
-- --------------------------------------------------------------------------------

-- drop function if exists gct.gctfn141_indicador_desempenho_global(p_nu_contrato numeric, p_dt_referencia date, p_nu_matricula numeric);

CREATE OR REPLACE FUNCTION gct.gctfn141_indicador_desempenho_global(p_nu_contrato numeric, p_dt_referencia date, p_nu_matricula numeric)
 RETURNS void
 LANGUAGE plpgsql
AS $function$

/**

RELEASE NOTES

RTC 23671403 - SIGCT - Indicadores do contrato especializado

*/

DECLARE

  v_nu_tipo_indicador numeric;
  v_nu_tipo_indicador_ide numeric;
  v_nu_tipo_indicador_turnover numeric;
  v_nu_tipo_grupo numeric;
  v_nu_contrato numeric;
  v_no_contrato varchar;

  v_vr_peso_ide numeric;
  v_vr_peso_turnover numeric;
  v_vr_indicador_turnover numeric;
  v_vr_media_indicador_ide numeric;
  v_dt_inicio_indicador date;
  v_dt_final_indicador date;
  v_dt_inicio_turnover date;
  v_dt_final_turnover date;

  v_vr_calculo_indicador numeric;

  v_sql text;  
				
BEGIN

  --
  -- DETERMINANDO O PERIODO A SER CALCULADO
  --
  v_dt_inicio_indicador := date_trunc('month', p_dt_referencia::date) - interval '3 month';
  v_dt_final_indicador := date_trunc('month', p_dt_referencia::date) - interval '1 day';

  v_nu_tipo_grupo := 10; -- SOMENTE DESENVOLVIMENTO 
  v_nu_tipo_indicador_ide := 42;  -- FIXO CONFORME CARGA FEITA
  v_nu_tipo_indicador_turnover := 40;  -- FIXO CONFORME CARGA FEITA
  v_nu_tipo_indicador := 45;  -- FIXO CONFORME CARGA FEITA
  v_vr_peso_ide := 0.90;  -- DEVERIA RECUPERAR DE ALGUMA CONFIGURACAO?
  v_vr_peso_turnover := 0.10;  -- DEVERIA RECUPERAR DE ALGUMA CONFIGURACAO?

  --
  -- INDICE DE DESEMPENHO GLOBAL
  --
  --
  -- IDG = {{Σ {Σ [IDe x (QPe / QPte)] /Σ (QPe / QPte)} M / 3} x 0,9} + (IT x 0,1)
  --

  --
  -- MEDIA DO IDE NO TRIMESTRE ANTERIOR
  --
  v_sql := '
    select
      c.nu_contrato,
      c.no_contrato,
      coalesce(AVG(vie.vr_faixa_fns),0)
    from
      gct.gcttb010_contrato c
      left join gct.gcttb172_valor_indicador_equipe vie on (
        vie.nu_contrato = c.nu_contrato
        and vie.nu_tipo_grupo = $1
        and vie.nu_tipo_indicador = $2
        and vie.dt_inicio_indicador <= $3
        and vie.dt_final_indicador >= $4
        and vie.vr_faixa_fns is not null
      )
    where
      c.nu_contrato = $5
    group by
      c.nu_contrato,
      c.no_contrato';

  EXECUTE v_sql
    USING v_nu_tipo_grupo, v_nu_tipo_indicador_ide, v_dt_final_indicador, v_dt_inicio_indicador, p_nu_contrato
     INTO v_nu_contrato, v_no_contrato, v_vr_media_indicador_ide;  

  --
  -- TURNOVER VIGENTE NO ULTIMO DIA DO TRIMESTRE
  --
  v_sql := '
    select
      vic.dt_inicio_indicador,
      coalesce(dt_final_indicador, $3) as dt_final_indicador,
      coalesce(vic.vr_faixa_fns,0)
    from
      gct.gcttb269_valor_indicador_contratada vic
    where
      vic.nu_contrato = $1
      and vic.nu_tipo_indicador = $2
      and $3 between dt_inicio_indicador and coalesce(dt_final_indicador, $3)';

  EXECUTE v_sql
    USING p_nu_contrato, v_nu_tipo_indicador_turnover, v_dt_final_indicador
     INTO v_dt_inicio_turnover, v_dt_final_turnover, v_vr_indicador_turnover;  

  v_vr_calculo_indicador := (v_vr_media_indicador_ide * v_vr_peso_ide) + (v_vr_indicador_turnover * v_vr_peso_turnover);

  RAISE NOTICE 'INDICADOR - CONTRATO: % % | IGD(Indice Global de Desenvolvimento) - MEDIA INDICADOR IDE: %', 
    v_nu_contrato, v_no_contrato, v_vr_media_indicador_ide;

  RAISE NOTICE 'INDICADOR - CONTRATO: % % | IGD(Indice Global de Desenvolvimento) - TURNOVER (PERIODO % A %): %', 
    v_nu_contrato, v_no_contrato, v_dt_inicio_turnover, v_dt_final_turnover, v_vr_indicador_turnover;

  RAISE NOTICE 'INDICADOR - CONTRATO: % % | IGD(Indice Global de Desenvolvimento) - VALOR INDICADOR (A * B) + (C * D): (% * %) + (% * %) = %', 
    v_nu_contrato, v_no_contrato, v_vr_media_indicador_ide, v_vr_peso_ide, v_vr_indicador_turnover, v_vr_peso_turnover, v_vr_calculo_indicador;

  PERFORM gct.gctfn173_registrar_valor_indicador(p_nu_contrato, v_nu_tipo_indicador, 
    v_dt_inicio_indicador, v_dt_final_indicador, v_vr_calculo_indicador, 'N');    

END;
$function$;

alter function gct.gctfn141_indicador_desempenho_global(p_nu_contrato numeric, p_dt_referencia date, p_nu_matricula numeric) owner to gct;

--------------------------------------------------------------------------------
-- -- gctfn140_agendar_calculo_indicador
-- --------------------------------------------------------------------------------

-- drop function if exists gct.gctfn140_agendar_calculo_indicador(p_nu_contrato numeric, p_nu_tipo_indicador numeric, p_data_inicial date, p_periodicidade_mes numeric, p_periodos numeric);

CREATE OR REPLACE FUNCTION gct.gctfn140_agendar_calculo_indicador(p_nu_contrato numeric, p_nu_tipo_indicador numeric, p_data_inicial date, p_periodicidade_mes numeric, p_periodos numeric)
RETURNS VOID AS
$$
DECLARE

  v_data_inicio DATE;
  v_data_fim DATE;
  v_data_execucao DATE;
  v_qt_meses_periodo integer;

  i NUMERIC := 0;

BEGIN

  v_data_inicio := p_data_inicial;

  WHILE i < p_periodos LOOP

    v_data_fim := v_data_inicio + (p_periodicidade_mes * INTERVAL '1 month');
    v_data_execucao := v_data_fim + INTERVAL '1 day';

    IF NOT EXISTS (
      SELECT 1
        FROM gct.gcttb283_agendamento_indicador a
       WHERE a.nu_contrato = p_nu_contrato
         AND a.nu_tipo_indicador = p_nu_tipo_indicador
         AND a.dt_inicio = v_data_inicio::date
    ) THEN
      INSERT INTO gct.gcttb283_agendamento_indicador (
          nu_contrato,
          nu_tipo_indicador,
          dt_inicio,
          dt_final,
          dt_execucao_prevista,
          ic_executado
      ) VALUES (
          p_nu_contrato,
          p_nu_tipo_indicador,
          v_data_inicio::date,
          v_data_fim::date,
          v_data_execucao::date,
          'N'
      );
    END IF;

    raise notice '% % %', v_data_inicio, v_data_fim, v_data_execucao;

    v_data_inicio := v_data_fim + INTERVAL '1 day';

    i := i + 1;

  END LOOP;

END;
$$ LANGUAGE plpgsql;
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

RTC 23671403 - SIGCT - Indicadores do contrato especializado
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
  v_nu_contrato               numeric;
  v_nu_equipe                 numeric;

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
      gc.nu_tp_frma_calculo_pgto, c.nu_contrato, e.nu_equipe
	  into 
		  v_nu_fatura_ajuste, v_ic_distribui_profissional, v_dt_inicio_atendimento, v_dt_final_atendimento, v_no_situacao_equipe,
      v_nu_tp_frma_calculo_pgto, v_nu_contrato, v_nu_equipe
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
      gc.nu_tp_frma_calculo_pgto, c.nu_contrato, e.nu_equipe
	  into 
		  v_nu_fatura_ajuste, v_ic_distribui_profissional, v_dt_inicio_atendimento, v_dt_final_atendimento, v_no_situacao_equipe,
      v_nu_tp_frma_calculo_pgto, v_nu_contrato, v_nu_equipe
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

    --------------------------------------------------------------------------------------------------------------------------------
    --| nu_tp_frma_calculo_pgto | no_tp_frma_calculo_pgto           | de_tp_frma_calculo_pgto                                      |
    --| ----------------------- | --------------------------------- | ------------------------------------------------------------ |
    --| 1                       | Distribuição de Preços Global     | Distribuição de preços padrão por grupo                      |      
    --| 3                       | Milheiros                         | Milheiros (Contrato UNISYS)                                  |
    --| 2                       | Distribuição de Preços por Perfil | Distribuição de preços diferenciados por perfil profissional |
    if v_nu_tp_frma_calculo_pgto in (1, 2, 3) then
      perform gct.gctfn328_coletar_amostra_ajuste_equipe(v_nu_fatura_ajuste, p_nu_equipe, p_nu_ajuste);
    end if;

    --| 4                       | Contratos Especializados          | Contratos Especializados                                     |
    if v_nu_tp_frma_calculo_pgto = 4 then
      perform gct.gctfn175_coletar_amsta_indcdr_ajuste(p_nu_ajuste, v_nu_fatura_ajuste, v_nu_equipe);
    end if;

    --
    -- GLOBAL
    --
    --------------------------------------------------------------------------------------------------------------------------------
    --| nu_tp_frma_calculo_pgto | no_tp_frma_calculo_pgto           | de_tp_frma_calculo_pgto                                      |
    --| ----------------------- | --------------------------------- | ------------------------------------------------------------ |
    --| 1                       | Distribuição de Preços Global     | Distribuição de preços padrão por grupo                      |      
    if v_ic_distribui_profissional = 'G' then 
      perform gct.gctfn347_simular_termo_ajuste_equipe(p_nu_ajuste, p_nu_equipe);
    end if;

    --
    --
    --  
    if v_ic_distribui_profissional = 'D' then
      
      --------------------------------------------------------------------------------------------------------------------------------
      --| nu_tp_frma_calculo_pgto | no_tp_frma_calculo_pgto           | de_tp_frma_calculo_pgto                                      |
      --| ----------------------- | --------------------------------- | ------------------------------------------------------------ |
      --| 2                       | Distribuição de Preços por Perfil | Distribuição de preços diferenciados por perfil profissional |
      if v_nu_tp_frma_calculo_pgto = 2 then 
        perform gct.gctfn403_simular_termo_ajuste_equipe_perfil(p_nu_ajuste, p_nu_equipe);
      end if;

      --------------------------------------------------------------------------------------------------------------------------------
      --| nu_tp_frma_calculo_pgto | no_tp_frma_calculo_pgto           | de_tp_frma_calculo_pgto                                      |
      --| ----------------------- | --------------------------------- | ------------------------------------------------------------ |
      --| 4                       | Contratos Especializados | Contratos Especializados |
      if v_nu_tp_frma_calculo_pgto = 4 then 
        perform gct.gctfn176_simular_termo_ajuste_equipe(p_nu_ajuste, p_nu_equipe);
      end if;

      --------------------------------------------------------------------------------------------------------------------------------
      --| nu_tp_frma_calculo_pgto | no_tp_frma_calculo_pgto           | de_tp_frma_calculo_pgto                                      |
      --| ----------------------- | --------------------------------- | ------------------------------------------------------------ |
      --| 3                       | Milheiros                         | Milheiros (Contrato UNISYS)                                  |
      if v_nu_tp_frma_calculo_pgto = 3 then
        perform gct.gctfn452_simular_termo_ajuste_equipe_milheiros(p_nu_ajuste, p_nu_equipe);
      end if;  

    end if;    

    --
    -- CALCULO DE INDICADORES
    --
    --------------------------------------------------------------------------------------------------------------------------------
    --| nu_tp_frma_calculo_pgto | no_tp_frma_calculo_pgto           | de_tp_frma_calculo_pgto                                      |
    --| ----------------------- | --------------------------------- | ------------------------------------------------------------ |
    --| 1                       | Distribuição de Preços Global     | Distribuição de preços padrão por grupo                      |      
    --| 2                       | Distribuição de Preços por Perfil | Distribuição de preços diferenciados por perfil profissional |
    --| 3                       | Milheiros                         | Milheiros (Contrato UNISYS)                                  |
    if v_nu_tp_frma_calculo_pgto in (1, 2, 3) then 
      
      perform gct.gctfn334_calcular_indicador_ajuste(p_nu_ajuste, p_nu_equipe);
    
    end if;
    
    --------------------------------------------------------------------------------------------------------------------------------
    --| nu_tp_frma_calculo_pgto | no_tp_frma_calculo_pgto           | de_tp_frma_calculo_pgto                                      |
    --| ----------------------- | --------------------------------- | ------------------------------------------------------------ |
    --| 4                       | Contratos Especializados | Contratos Especializados |
    if v_nu_tp_frma_calculo_pgto in (4) then 
      
      perform gct.gctfn177_calcular_indicador_ajuste(p_nu_ajuste, p_nu_equipe);
    
    end if;

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

  else  

    raise notice 'AJUSTE EQUIPE - CODIGO: % EQUIPE: % FATURA: % (ERRO! NAO FOI ENCONTRADA FATURA ABERTA)', 
      p_nu_ajuste, p_nu_equipe, v_nu_fatura_ajuste;

  end if;

  return p_nu_ajuste;

END;
$function$;

alter function gct.gctfn349_executar_ajuste_equipe(p_nu_ajuste numeric, p_nu_equipe numeric, p_nu_repactuacao numeric, p_nu_repactuacao_ajuste_previo numeric, p_dt_referencia date) owner to gct;

--------------------------------------------------------------------------------
-- -- gctfn173_registrar_valor_indicador
-- --------------------------------------------------------------------------------

-- drop function if exists gct.gctfn173_registrar_valor_indicador(p_nu_contrato numeric, p_nu_tipo_indicador numeric, p_dt_inicio date, p_dt_final date, p_vr_indicador numeric, p_ic_recupera_vr_faixa char);

CREATE OR REPLACE FUNCTION gct.gctfn173_registrar_valor_indicador(p_nu_contrato numeric, p_nu_tipo_indicador numeric, p_dt_inicio date, p_dt_final date, p_vr_indicador numeric, p_ic_recupera_vr_faixa char default 'S')
 RETURNS void
 LANGUAGE plpgsql
AS $function$
	
DECLARE 

  indicador record;

  v_vr_calculo_indicador numeric;
  v_vr_faixa_fns numeric;

BEGIN

  --
  delete from
    gct.gcttb269_valor_indicador_contratada
  where
    nu_contrato = p_nu_contrato
    and nu_tipo_indicador = p_nu_tipo_indicador
    and dt_inicio_indicador = p_dt_inicio
    and dt_final_indicador = p_dt_final;

  --
  if p_ic_recupera_vr_faixa = 'S' then
    v_vr_faixa_fns := gct.gctfn120_recuperar_valor_faixa(p_nu_contrato, 11, p_nu_tipo_indicador, p_vr_indicador);
  else
    v_vr_faixa_fns := p_vr_indicador;
  end if;   

  insert into gct.gcttb269_valor_indicador_contratada(
    nu_contrato,
    nu_tipo_indicador,
    dt_inicio_indicador,
    dt_final_indicador,
    vr_calculo_indicador,
    vr_faixa_fns,
    dh_geracao_indicador
  ) values (
    p_nu_contrato,
    p_nu_tipo_indicador,
    p_dt_inicio,
    p_dt_final,
    p_vr_indicador,
    v_vr_faixa_fns,
    current_timestamp
  );

END;

$function$;

alter function gct.gctfn173_registrar_valor_indicador(p_nu_contrato numeric, p_nu_tipo_indicador numeric, p_dt_inicio date, p_dt_final date, p_vr_indicador numeric, p_ic_recupera_vr_faixa char) owner to gct;

--------------------------------------------------------------------------------
-- -- gctfn174_indicador_turnover
-- --------------------------------------------------------------------------------

-- drop function if exists gct.gctfn174_indicador_turnover(p_nu_contrato numeric, p_nu_matricula numeric);

CREATE OR REPLACE FUNCTION gct.gctfn174_indicador_turnover(p_nu_contrato numeric, p_nu_matricula numeric)
 RETURNS void
 LANGUAGE plpgsql
AS $function$

/**

RELEASE NOTES

RTC 23671403 - SIGCT - Indicadores do contrato especializado

*/

DECLARE

  v_nu_tipo_indicador numeric;

  v_qt_perfis_contratada numeric;
  v_qt_desligamentos numeric;
  v_no_contrato varchar;

  v_vr_calculo_indicador numeric;
  
  v_sql text;

  agendamento record;

BEGIN

  v_nu_tipo_indicador := 40;

  for agendamento in (
    select
      c.nu_contrato,
      c.no_contrato,
      a.nu_tipo_indicador,
      a.dt_inicio,
      a.dt_final,
      a.dt_execucao_prevista,
      a.ic_executado,
      a.dt_execucao
    from
      gct.gcttb283_agendamento_indicador a
      inner join gct.gcttb010_contrato c on c.nu_contrato = a.nu_contrato
    where
      a.nu_contrato = p_nu_contrato
      and a.ic_executado = 'N'
      and a.dt_execucao_prevista <= current_date
    order by
      c.nu_contrato,
      a.dt_inicio
  )
  loop

    RAISE NOTICE 'INDICADOR - CONTRATO: % % | IT(Turnover) - PERIODO: % A %', 
      agendamento.nu_contrato, agendamento.no_contrato, agendamento.dt_inicio::date, agendamento.dt_final::date;

    --
    -- AMOSTRAS
    --

    --
    -- EQUIPES
    --
    v_sql := 'delete from gct.gcttb264_amsta_equipe where dt_referencia = $1 and nu_contrato = $2';
    execute v_sql using agendamento.dt_execucao_prevista, agendamento.nu_contrato;

    v_sql := '
      insert into gct.gcttb264_amsta_equipe(
        dt_referencia,
        nu_contrato,
        nu_equipe,
        nu_ajuste,
        co_equipe,
        nu_situacao_equipe,
        nu_area_interna,
        nu_tipo_grupo,
        co_sitio,
        de_equipe,
        dt_solicitacao_alocacao,
        dt_inicio_atendimento,
        dt_final_atendimento,
        vr_previsto_calculado,
        dh_inclusao_informacao,
        nu_acao_historico,
        nu_mtrca_acao_hstro,
        de_justificativa_alteracao,
        dh_amostra
      )
      select
        $1 as dt_referencia,
        a.nu_contrato, 
        a.nu_equipe,
        null::numeric as nu_ajuste,
        a.co_equipe,
        a.nu_situacao_equipe,
        a.nu_area_interna,
        a.nu_tipo_grupo,
        a.co_sitio,
        a.de_equipe,
        a.dt_solicitacao_alocacao,
        a.dt_inicio_atendimento,
        a.dt_final_atendimento,
        a.vr_previsto_calculado,
        a.dh_inclusao_informacao,
        a.nu_acao_historico,
        a.nu_mtrca_acao_hstro,
        a.de_justificativa_alteracao,
        current_timestamp as dh_amostra
      from
        gct.gcttb087_equipe a
      where
        a.nu_contrato = $2';

    RAISE NOTICE 'INDICADOR - CONTRATO: % % | IT(Turnover) - AMOSTRA DE EQUIPES', 
      agendamento.nu_contrato, agendamento.no_contrato;
    
    execute v_sql using agendamento.dt_execucao_prevista, agendamento.nu_contrato;

    --
    -- MEMBROS DAS EQUIPES
    --
    v_sql := 'delete from gct.gcttb268_amsta_membros_equipe where dt_referencia = $1 and nu_contrato = $2';
    execute v_sql using agendamento.dt_execucao_prevista, agendamento.nu_contrato;

    v_sql := '
      insert into gct.gcttb268_amsta_membros_equipe(
        dt_referencia,
        nu_contrato,
        nu_equipe,
        nu_ajuste,
        nu_vigencia_membro,
        nu_membro,
        nu_perfil,
        dt_inicio_membro,
        dt_fim_membro,
        nu_posicao_membro,
        pc_alocacao_membro,
        dh_amostra
      )
      select distinct
        $1 as dt_referencia,
        e.nu_contrato,
        a.nu_equipe,
        null::numeric as nu_ajuste,
        a.nu_vigencia_membro,
        a.nu_membro,
        a.nu_perfil,
        a.dt_inicio_membro,
        a.dt_fim_membro,
        a.nu_posicao_membro,
        a.pc_alocacao_membro,
        current_timestamp as dh_amostra
      from
        gct.gcttb419_vigencia_membros_equipe a
        inner join gct.gcttb087_equipe e on e.nu_equipe = a.nu_equipe
      where 
        e.nu_contrato = $2';

    RAISE NOTICE 'INDICADOR - CONTRATO: % % | IT(Turnover) - AMOSTRA DOS MEMBROS DAS EQUIPES', 
      agendamento.nu_contrato, agendamento.no_contrato;
    
    execute v_sql using agendamento.dt_execucao_prevista, agendamento.nu_contrato;   

    --
    -- DESLIGAMENTOS DE PERFIS TRIMESTRAL DA CONTRATADA
    --
    v_sql := '
      SELECT
        COUNT(DISTINCT m.nu_matricula)
      FROM
        gct.gcttb268_amsta_membros_equipe vme
        INNER JOIN gct.gcttb418_membros m 
          ON m.nu_membro = vme.nu_membro
        INNER JOIN gct.gcttb264_amsta_equipe e 
          ON e.nu_equipe = vme.nu_equipe
        AND e.dt_referencia = vme.dt_referencia
      WHERE
        e.nu_contrato = $1
        AND e.dt_referencia = $2
        AND vme.dt_fim_membro BETWEEN $3 AND $4
        AND NOT EXISTS (
          SELECT 1
          FROM gct.gcttb268_amsta_membros_equipe vme1
          INNER JOIN gct.gcttb418_membros m1 
              ON m1.nu_membro = vme1.nu_membro
          INNER JOIN gct.gcttb264_amsta_equipe e1 
              ON e1.nu_equipe = vme1.nu_equipe
            AND e1.dt_referencia = vme1.dt_referencia
          WHERE
              e1.nu_contrato = e.nu_contrato
              AND e1.dt_referencia = e.dt_referencia
              AND m1.nu_matricula = m.nu_matricula
              AND vme1.dt_inicio_membro BETWEEN $3 AND $4
              AND (vme1.dt_fim_membro IS NULL OR vme1.dt_fim_membro > vme.dt_fim_membro)
        )';

    execute v_sql 
      using agendamento.nu_contrato, agendamento.dt_execucao_prevista, agendamento.dt_inicio, agendamento.dt_final
       into v_qt_desligamentos;    

    --
    -- PERFIS DA CONTRATADA AO FINAL DO TRIMESTRE
    --
    v_sql := '
      select
        c.no_contrato,
        count(distinct m.nu_matricula)
      from
        gct.gcttb268_amsta_membros_equipe vme
        inner join gct.gcttb418_membros m on m.nu_membro = vme.nu_membro
        inner join gct.gcttb264_amsta_equipe e on (
          e.nu_equipe = vme.nu_equipe 
          and e.dt_referencia = vme.dt_referencia
        )
        INNER JOIN gct.gcttb010_contrato c on c.nu_contrato = e.nu_contrato  
      where
        e.nu_contrato = $1
        and e.dt_referencia = $2
        and vme.dt_inicio_membro <= $3
        and (vme.dt_fim_membro is null or vme.dt_fim_membro >= $4)
      group by
        c.no_contrato';

    execute v_sql 
      using agendamento.nu_contrato, agendamento.dt_execucao_prevista, agendamento.dt_final, agendamento.dt_inicio
       into v_no_contrato, v_qt_perfis_contratada;

    if coalesce(v_qt_perfis_contratada,0) > 0 then 

      v_vr_calculo_indicador := 1::numeric - (v_qt_desligamentos / v_qt_perfis_contratada);

      RAISE NOTICE 'INDICADOR - CONTRATO: % % | IT(Turnover) - QT. DESLIGAMENTOS: %', 
        agendamento.nu_contrato, agendamento.no_contrato, v_qt_desligamentos;

      RAISE NOTICE 'INDICADOR - CONTRATO: % % | IT(Turnover) - QT. PERFIS CONTRATADA: %', 
        agendamento.nu_contrato, agendamento.no_contrato, v_qt_perfis_contratada;

      RAISE NOTICE 'INDICADOR - CONTRATO: % % | IT(Turnover) - VALOR INDICADOR 1 - (A / B): 1 - (% / %) = %', 
        agendamento.nu_contrato, agendamento.no_contrato, v_qt_desligamentos, v_qt_perfis_contratada, v_vr_calculo_indicador;

      --
      -- FECHO A VIGENCIA DO INDICADOR ANTERIOR
      --
      update
        gct.gcttb269_valor_indicador_contratada
      set
        dt_final_indicador = agendamento.dt_inicio - INTERVAL '1 day'
      where
        nu_contrato = agendamento.nu_contrato
        and nu_tipo_indicador = v_nu_tipo_indicador
        and dt_final_indicador is null;      

      PERFORM gct.gctfn173_registrar_valor_indicador(p_nu_contrato, v_nu_tipo_indicador, agendamento.dt_inicio, 
        null::date, v_vr_calculo_indicador);

      update 
        gct.gcttb283_agendamento_indicador
      set
        ic_executado = 'S'
      where
        nu_contrato = p_nu_contrato
        and dt_execucao_prevista = agendamento.dt_execucao_prevista;

    end if;

  end loop;

END;
$function$;

alter function gct.gctfn174_indicador_turnover(p_nu_contrato numeric, p_nu_matricula numeric) owner to gct;
--------------------------------------------------------------------------------
-- -- gctfn175_coletar_amsta_indcdr_ajuste
-- --------------------------------------------------------------------------------

-- drop function if exists gct.gctfn175_coletar_amsta_indcdr_ajuste(p_nu_ajuste numeric, p_nu_fatura_ajuste numeric, p_nu_equipe numeric);

CREATE OR REPLACE FUNCTION gct.gctfn175_coletar_amsta_indcdr_ajuste(p_nu_ajuste numeric, p_nu_fatura_ajuste numeric, p_nu_equipe numeric)
 RETURNS void
 LANGUAGE plpgsql
AS $function$

/*

RELEASE NOTES

RTC 23671403 - SIGCT - Indicadores do contrato especializado

*/

DECLARE

  v_sql text;

BEGIN

  --
  -- EQUIPES
  --
  v_sql := '
    delete from 
      gct.gcttb264_amsta_equipe a 
    where 
      nu_ajuste = $1
      and a.nu_equipe = $2';
  
  execute v_sql using p_nu_ajuste, p_nu_equipe;

  v_sql := '
    insert into gct.gcttb264_amsta_equipe(
      nu_ajuste,
      nu_fatura_ajuste,
      nu_contrato,
      nu_equipe,
      co_equipe,
      nu_situacao_equipe,
      nu_area_interna,
      nu_tipo_grupo,
      co_sitio,
      de_equipe,
      dt_solicitacao_alocacao,
      dt_inicio_atendimento,
      dt_final_atendimento,
      vr_previsto_calculado,
      dh_inclusao_informacao,
      nu_acao_historico,
      nu_mtrca_acao_hstro,
      de_justificativa_alteracao,
      dh_amostra
    )
    select
      $1 as nu_ajuste, 
      $2 as nu_fatura_ajuste,
      a.nu_contrato,
      a.nu_equipe,
      a.co_equipe,
      a.nu_situacao_equipe,
      a.nu_area_interna,
      a.nu_tipo_grupo,
      a.co_sitio,
      a.de_equipe,
      a.dt_solicitacao_alocacao,
      a.dt_inicio_atendimento,
      a.dt_final_atendimento,
      a.vr_previsto_calculado,
      a.dh_inclusao_informacao,
      a.nu_acao_historico,
      a.nu_mtrca_acao_hstro,
      a.de_justificativa_alteracao,
      current_timestamp as dh_amostra
    from
      gct.gcttb087_equipe a
    where 
      a.nu_equipe = $3';

  RAISE NOTICE 'INDICADOR - AMOSTRAS EQUIPES - AJUSTE: % | FATURA: % | EQUIPE: %', p_nu_ajuste, p_nu_fatura_ajuste, p_nu_equipe;
  execute v_sql using p_nu_ajuste, p_nu_fatura_ajuste, p_nu_equipe;

  --
  -- SOLICITACAO EQUIPE
  --
  v_sql := '
    delete from 
      gct.gcttb266_amsta_slctco_equipe a 
    where 
      nu_ajuste = $1
      and a.nu_equipe = $2';

  execute v_sql using p_nu_ajuste, p_nu_equipe; 

  v_sql := '
    insert into gct.gcttb266_amsta_slctco_equipe(
      nu_contrato,
      nu_equipe,
      nu_ajuste,
      nu_fatura_ajuste,
      nu_solicitacao_equipe,
      nu_ciclo_trabalho,
      nu_solicitacao,
      nu_tipo_servico,
      nu_tamanho_servico,
      nu_demanda,
      ic_solicitacao_compoe_fns,
      co_falha_solicitacao,
      vr_questionario_avaliacao,
      vr_nota_qualidade_produto,
      vr_total_apurado_avaliacao,
      nu_mtrca_avaliacao_equipe,
      dh_avaliacao_solicitacao,
      nu_rubrica,
      nu_fatura_previa,
      nu_comunidade,
      co_rubrica,
      no_comunidade,
      co_forma_vinculacao,
      de_justificativa_alteracao,
      de_justificativa_falha,
      nu_acao_historico,
      nu_execucao,
      nu_mtrca_acao_hstro,
      nu_mtrca_avaliacao_solicitacao,
      nu_ordem_servico,
      no_tipo_servico,
      ic_bef,
      ic_bef_pode_ajustar_rubrica,
      dh_amostra
    )
    select distinct
      c.nu_contrato, 
      se.nu_equipe,
      $1 as nu_ajuste,
      $2 as nu_fatura_ajuste,
      se.nu_solicitacao_equipe,
      se.nu_ciclo_trabalho,
      se.nu_solicitacao,
      se.nu_tipo_servico,
      se.nu_tamanho_servico,
      se.nu_demanda,
      sc.ic_servico_compoe_calculo_fns as ic_solicitacao_compoe_fns,
      coalesce(se.co_falha_solicitacao, ''NF'') as co_falha_solicitacao,
      se.vr_questionario_avaliacao,
      se.vr_nota_qualidade_produto,
      se.vr_total_apurado_avaliacao,
      cct.nu_mtrca_avaliacao_equipe,
      se.dh_avaliacao_solicitacao,
      gct.gctfn135_recuperar_rubrica(sc.nu_contrato, sc.nu_tipo_grupo, se.nu_tipo_servico, se.nu_solicitacao),
      null::numeric nu_fatura_previa,
      com.nu_comunidade,
      (
        select co_rubrica 
          from gct.gcttb071_rubrica r 
        where r.nu_rubrica = gct.gctfn135_recuperar_rubrica(sc.nu_contrato, sc.nu_tipo_grupo, se.nu_tipo_servico, se.nu_solicitacao)
      ) as co_rubrica,
      com.no_comunidade,
      se.co_forma_vinculacao,
      se.de_justificativa_alteracao,
      se.de_justificativa_falha,
      se.nu_acao_historico,
      se.nu_execucao,
      se.nu_mtrca_acao_hstro,
      se.nu_mtrca_avaliacao_solicitacao,
      se.nu_ordem_servico,
      ts.no_tipo_servico,
      s.ic_bef,
      sc.ic_bef_pode_ajustar_rubrica,
      current_timestamp as dh_amostra 
    from
      gct.gcttb010_contrato c
      inner join gct.gcttb033_grupo_contrato gc on (gc.nu_contrato = c.nu_contrato)
      inner join gct.gcttb032_tipo_grupo tg on (tg.nu_tipo_grupo = gc.nu_tipo_grupo)
      inner join gct.gcttb087_equipe e on (
        e.nu_contrato = gc.nu_contrato
        and e.nu_tipo_grupo = gc.nu_tipo_grupo
        and gc.nu_tp_frma_calculo_pgto = 4 -- ESPECIALIZADO
      )
      inner join gct.gcttb001_area_interna ai on (ai.nu_area_interna = e.nu_area_interna)
      inner join gct.gcttb086_solicitacao_equipe se on (se.nu_equipe = e.nu_equipe)
      inner join gct.gcttb005_solicitacao s on s.nu_solicitacao = se.nu_solicitacao
      inner join gct.gcttb015_tipo_servico ts on ts.nu_tipo_servico = se.nu_tipo_servico
      inner join gct.gcttb055_servico_contrato sc on (
        sc.nu_tipo_servico = se.nu_tipo_servico
        and gc.nu_contrato = sc.nu_contrato
        and gc.nu_tipo_grupo = sc.nu_tipo_grupo
      )
      inner join gct.gcttb405_comunidade com on com.nu_comunidade = ai.nu_comunidade
      left join gct.gcttb088_ciclo_trabalho cct on (
        cct.nu_equipe = se.nu_equipe 
        and se.nu_ciclo_trabalho = cct.nu_ciclo_trabalho
      )
    where 
      e.nu_equipe = $3';

  RAISE NOTICE 'INDICADOR - AMOSTRAS SOLICITACOES EQUIPE - AJUSTE: % | FATURA: % | EQUIPE: %', p_nu_ajuste, p_nu_fatura_ajuste, p_nu_equipe;
  execute v_sql using p_nu_ajuste, p_nu_fatura_ajuste, p_nu_equipe;

  --
  -- SPRINTS
  --
  v_sql := '
    delete from 
      gct.gcttb267_amsta_ciclo_trabalho a 
    where 
      nu_ajuste = $1
      and a.nu_equipe = $2';

  execute v_sql using p_nu_ajuste, p_nu_equipe; 

  v_sql := '
    insert into gct.gcttb267_amsta_ciclo_trabalho(
      nu_contrato,
      nu_equipe,
      nu_ajuste,
      nu_fatura_ajuste,
      nu_ciclo_trabalho,
      nu_situacao_ciclo_trabalho,
      de_ciclo_trabalho,
      dt_inicio_ciclo_trabalho,
      dt_alvo_ciclo_trabalho,
      dt_final_ciclo_trabalho,
      co_falha_ciclo_trabalho,
      nu_acao_historico,
      nu_mtrca_acao_hstro,
      vr_questionario_avaliacao,
      vr_nota_qualidade_produto,
      vr_total_apurado_avaliacao,
      nu_mtrca_avaliacao_equipe,
      de_justificativa_falha,
      de_justificativa_alteracao,
      nu_mtrca_fechamento_equipe,
      dt_fechamento_ciclo_trabalho,
      de_justificativa_fechamento,
      de_justificativa_cancelar_fechamento,
      ic_nao_se_aplica,
      dh_amostra
    )
    select
      e.nu_contrato,
      a.nu_equipe,
      $1 as nu_ajuste,
      $2 as nu_fatura_ajuste,
      a.nu_ciclo_trabalho,
      a.nu_situacao_ciclo_trabalho,
      a.de_ciclo_trabalho,
      a.dt_inicio_ciclo_trabalho,
      a.dt_alvo_ciclo_trabalho,
      a.dt_final_ciclo_trabalho,
      a.co_falha_ciclo_trabalho,
      a.nu_acao_historico,
      a.nu_mtrca_acao_hstro,
      a.vr_questionario_avaliacao,
      a.vr_nota_qualidade_produto,
      a.vr_total_apurado_avaliacao,
      a.nu_mtrca_avaliacao_equipe,
      a.de_justificativa_falha,
      a.de_justificativa_alteracao,
      a.nu_mtrca_fechamento_equipe,
      a.dt_fechamento_ciclo_trabalho,
      a.de_justificativa_fechamento,
      a.de_justificativa_cancelar_fechamento,
      a.ic_nao_se_aplica,
      current_timestamp as dh_amostra
    from
      gct.gcttb088_ciclo_trabalho a
      inner join gct.gcttb087_equipe e on e.nu_equipe = a.nu_equipe
      inner join gct.gcttb033_grupo_contrato gc on (
        gc.nu_contrato = e.nu_contrato
        and gc.nu_tipo_grupo = e.nu_tipo_grupo
        and gc.nu_tp_frma_calculo_pgto = 4 -- ESPECIALIZADO
      )
    where 
      e.nu_equipe = $3';

  RAISE NOTICE 'INDICADOR - AMOSTRAS SPRINTS - AJUSTE: % | FATURA: % | EQUIPE: %', p_nu_ajuste, p_nu_fatura_ajuste, p_nu_equipe;
  execute v_sql using p_nu_ajuste, p_nu_fatura_ajuste, p_nu_equipe;

  --
  -- SOLICITACOES
  --
  v_sql := '
    delete from 
      gct.gcttb265_amsta_solicitacao a 
    where 
      nu_ajuste = $1
      and a.nu_equipe = $2';

  execute v_sql using p_nu_ajuste, p_nu_equipe; 

  v_sql := '
    insert into gct.gcttb265_amsta_solicitacao(
      nu_contrato,
      nu_equipe,
      nu_ajuste,
      nu_fatura_ajuste,
      nu_solicitacao,
      nu_unidade_custo,
      nu_natural_custo,
      co_solicitacao,
      de_solicitacao,
      de_tipo_solicitacao,
      de_tipo_manutencao,
      de_pendencia,
      de_origem_solicitacao,
      de_situacao_solicitacao,
      co_siplo,
      co_acao_operacional,
      no_sigla_sistema,
      pc_atendimento_slcto,
      dh_processamento,
      no_solicitacao,
      de_versao_planejada,
      nu_quatidade_incluida,
      nu_quatidade_alterada,
      nu_quatidade_excluida,
      nu_sistema_intgo,
      no_item_portfolio,
      de_modulo,
      dh_inicio,
      dh_prevista,
      dh_efetiva,
      de_situacao_solicitacao_gct,
      co_solicitacao_pai,
      dh_cadastro,
      dh_resolucao,
      dh_modificacao,
      nu_situacao_solicitacao,
      dh_acionamento,
      de_equipe_responsavel,
      nu_acao_historico,
      nu_mtrca_acao_hstro,
      de_justificativa_alteracao,
      nu_execucao,
      nu_mtrca_alteracao_custo,
      dh_alteracao_custo,
      co_solicitacao_custo,
      ic_acesso_restrito,
      no_tipo_solicitacao,
      de_tipo_desenvolvimento,
      no_planejado_para,
      no_area_projeto,
      qt_erro,
      no_squad,
      ic_pendente_atualizacao,
      qt_pontos_historia,
      nu_item_portfolio,
      co_matrca_responsavel,
      nu_modulo,
      nu_solicitacao_pai,
      co_area_projeto,
      nu_tipo_situacao_vinculacao,
      no_tipo_grupo,
      no_tipo_servico,
      co_rubrica,
      ic_bef,
      no_modulo,
      nu_rubrica,
      sg_unidade_custo,
      co_solicitacao_bef,
      dh_avaliacao_bef,
      dh_amostra
    )
    select distinct on (a.nu_solicitacao)
      e.nu_contrato,
      e.nu_equipe,
      $1 as nu_ajuste,
      $2 as nu_fatura_ajuste,
      a.nu_solicitacao,
      a.nu_unidade_custo,
      a.nu_natural_custo,
      a.co_solicitacao,
      a.de_solicitacao,
      a.de_tipo_solicitacao,
      a.de_tipo_manutencao,
      a.de_pendencia,
      a.de_origem_solicitacao,
      a.de_situacao_solicitacao,
      a.co_siplo,
      a.co_acao_operacional,
      a.no_sigla_sistema,
      a.pc_atendimento_slcto,
      a.dh_processamento,
      a.no_solicitacao,
      a.de_versao_planejada,
      a.nu_quatidade_incluida,
      a.nu_quatidade_alterada,
      a.nu_quatidade_excluida,
      a.nu_sistema_intgo,
      a.no_item_portfolio,
      a.de_modulo,
      a.dh_inicio,
      a.dh_prevista,
      a.dh_efetiva,
      a.de_situacao_solicitacao_gct,
      a.co_solicitacao_pai,
      a.dh_cadastro,
      a.dh_resolucao,
      a.dh_modificacao,
      a.nu_situacao_solicitacao,
      a.dh_acionamento,
      a.de_equipe_responsavel,
      a.nu_acao_historico,
      a.nu_mtrca_acao_hstro,
      a.de_justificativa_alteracao,
      a.nu_execucao,
      a.nu_mtrca_alteracao_custo,
      a.dh_alteracao_custo,
      a.co_solicitacao_custo,
      a.ic_acesso_restrito,
      a.no_tipo_solicitacao,
      a.de_tipo_desenvolvimento,
      a.no_planejado_para,
      a.no_area_projeto,
      a.qt_erro,
      a.no_squad,
      a.ic_pendente_atualizacao,
      a.qt_pontos_historia,
      a.nu_item_portfolio,
      a.co_matrca_responsavel,
      a.nu_modulo,
      a.nu_solicitacao_pai,
      a.co_area_projeto,
      a.nu_tipo_situacao_vinculacao,
      a.no_tipo_grupo,
      a.no_tipo_servico,
      a.co_rubrica,
      a.ic_bef,
      a.no_modulo,
      a.nu_rubrica,
      a.sg_unidade_custo,
      a.co_solicitacao_bef,
      a.dh_avaliacao_bef,
      current_timestamp as dh_amostra
    from
      gct.gcttb005_solicitacao a
      inner join gct.gcttb086_solicitacao_equipe se on se.nu_solicitacao = a.nu_solicitacao
      inner join gct.gcttb087_equipe e on e.nu_equipe = se.nu_equipe
      inner join gct.gcttb033_grupo_contrato gc on (
        gc.nu_contrato = e.nu_contrato
        and gc.nu_tipo_grupo = e.nu_tipo_grupo
        and gc.nu_tp_frma_calculo_pgto = 4 -- ESPECIALIZADO
      )
    where
      e.nu_equipe = $3';

  RAISE NOTICE 'INDICADOR - AMOSTRAS SOLICITACOES - AJUSTE: % | FATURA: % | EQUIPE: %', p_nu_ajuste, p_nu_fatura_ajuste, p_nu_equipe;
  execute v_sql using p_nu_ajuste, p_nu_fatura_ajuste, p_nu_equipe;  

  --
  -- MEMBROS DAS EQUIPES
  --
  v_sql := '
    delete from 
      gct.gcttb268_amsta_membros_equipe a 
    where 
      nu_ajuste = $1
      and a.nu_equipe = $2';

  execute v_sql using p_nu_ajuste, p_nu_equipe; 

  v_sql := '
    insert into gct.gcttb268_amsta_membros_equipe(
      nu_contrato,
      nu_equipe,
      nu_ajuste,
      nu_fatura_ajuste,
      nu_vigencia_membro,
      nu_membro,
      nu_perfil,
      dt_inicio_membro,
      dt_fim_membro,
      nu_posicao_membro,
      pc_alocacao_membro,
      dh_amostra
    )
    select distinct
      e.nu_contrato, 
      a.nu_equipe,
      $1 as nu_ajuste,
      $2 as nu_fatura_ajuste,
      a.nu_vigencia_membro,
      a.nu_membro,
      a.nu_perfil,
      a.dt_inicio_membro,
      a.dt_fim_membro,
      a.nu_posicao_membro,
      a.pc_alocacao_membro,
      current_timestamp as dh_amostra
    from
      gct.gcttb419_vigencia_membros_equipe a
      inner join gct.gcttb087_equipe e on e.nu_equipe = a.nu_equipe
    where
      e.nu_equipe = $3';

  RAISE NOTICE 'INDICADOR - AMOSTRAS MEMBROS - AJUSTE: % | FATURA: % | EQUIPE: %', p_nu_ajuste, p_nu_fatura_ajuste, p_nu_equipe;
  execute v_sql using p_nu_ajuste, p_nu_fatura_ajuste, p_nu_equipe;

END;
$function$;

alter function gct.gctfn175_coletar_amsta_indcdr_ajuste(p_nu_ajuste numeric, p_nu_fatura_ajuste numeric, p_nu_equipe numeric) owner to gct;

--------------------------------------------------------------------------------
-- -- gctfn176_simular_termo_ajuste_equipe
-- --------------------------------------------------------------------------------

-- drop function if exists gct.gctfn176_simular_termo_ajuste_equipe(p_nu_ajuste numeric, p_nu_equipe numeric);

CREATE OR REPLACE FUNCTION gct.gctfn176_simular_termo_ajuste_equipe(p_nu_ajuste numeric, p_nu_equipe numeric)
 RETURNS void
 LANGUAGE plpgsql
AS $function$

/*

RELEASE NOTES

RTC 23671403 - SIGCT - Indicadores do contrato especializado

*/

DECLARE

  termo                       record;
  vigencias                   record;
  membros                     record;

  v_nu_termo_gerado           numeric;
  v_qt_faturas                numeric;
  v_nu_tipo_termo             numeric;
  v_nu_situacao_termo         numeric;
  v_qt_termo                  numeric;
  v_nu_seq_termo              numeric;
  v_nu_tipo_preco             numeric;
  v_nu_motivo_termo           numeric;

  v_qt_dias_trabalho          numeric;
  v_qt_membros_equipe         numeric;
  v_qt_membros_efetiva        numeric;
  v_qt_dias_faturamento       numeric;
  v_valor_previsto_perfil     numeric;
  v_valor_previsto_equipe     numeric;
  v_valor_financeiro          numeric;
  v_vr_preco_grupo            numeric;
  v_qt_dias_trabalhados       numeric;
  v_acrescimo                 numeric;
  v_decrescimo                numeric;
  v_qt_dias_servico_extra     numeric;
  v_qt_dias_ausencia          numeric;

  v_dia_trabalho              date;
  v_dt_referencia             date;
  v_dt_inicio_vigencia        date;
  v_dt_final_vigencia         date;

  v_co_termo                  text;
  v_sg_tipo_termo             text;
  v_ic_dias_calculo_pagamento text;

  v_tem_comunidade			      numeric;
  v_nu_comunidade			        numeric;
  v_no_comunidade			        text;
  
BEGIN

  v_nu_tipo_termo := 90; -- Termo Ficticio
  v_nu_situacao_termo := 2;

  FOR termo IN
    
    select
      c.nu_contrato,
      e.co_equipe,
      e.nu_equipe,
      e.dt_inicio_atendimento :: date,
      e.dt_final_atendimento :: date,
      tg.nu_tipo_grupo,
      gc.ic_tipo_atendimento,
      gc.ic_calculo_pro_rata,
      ai.nu_area_interna,
      ai.nu_mtrca_responsavel,
      ai.no_sigla_area,
      ai.co_sitio,
      gc.ic_dias_calculo_pagamento,
      gc.ic_permite_servico_extra,
      gc.ic_permite_registro_ausencia,
      gc.ic_calculo_pro_rata,
      f.nu_fatura,
      f.dt_inicio_fatura,
      f.dt_final_fatura,
      t.nu_termo_equipe,
      t.co_termo,
      t.nu_fatura_gerada,
      c.ic_distribui_profissional,
      r.nu_rubrica as nu_rubrica_padrao,
      r.co_rubrica as co_rubrica_padrao
    from
      gct.gcttb264_amsta_equipe e
      inner join gct.gcttb010_contrato c on e.nu_contrato = c.nu_contrato
      inner join gct.gcttb033_grupo_contrato gc on (
        gc.nu_contrato = e.nu_contrato
        and gc.nu_tipo_grupo = e.nu_tipo_grupo
      )
      inner join gct.gcttb032_tipo_grupo tg on tg.nu_tipo_grupo = gc.nu_tipo_grupo
      inner join gct.gcttb103_faturamento fat on fat.nu_faturamento = c.nu_faturamento
      inner join gct.gcttb170_termo_equipe t on (
        e.nu_equipe = t.nu_equipe
        and t.nu_tipo_termo = 11
        and t.nu_situacao_termo in (1, 3)
      )
      inner join gct.gcttb102_fatura f on f.nu_fatura = t.nu_fatura_gerada
      inner join gct.gcttb001_area_interna ai on (
        ai.nu_area_interna = e.nu_area_interna
        and ai.co_sitio = f.co_sitio
      )
      inner join gct.gcttb071_rubrica r on r.nu_rubrica = gc.nu_rubrica_padrao
    where
      e.nu_ajuste = p_nu_ajuste
      and e.nu_equipe = p_nu_equipe
    ORDER BY
      f.dt_final_fatura,
      c.nu_contrato,
      e.nu_equipe

  LOOP

    RAISE NOTICE '------------------------------------------------------------------';  
    RAISE NOTICE 'EQUIPE: % | FATURA: % | TERMO: % %', termo.nu_equipe, termo.nu_fatura_gerada, termo.nu_termo_equipe, termo.co_termo;
    RAISE NOTICE '------------------------------------------------------------------';

    v_valor_previsto_perfil := 0;
    v_valor_previsto_equipe := 0;
    v_decrescimo := 0;
    v_acrescimo := 0;
    v_qt_membros_efetiva := 0;
    v_dt_referencia = termo.dt_inicio_atendimento;

    RAISE NOTICE 'AJUSTE - CONTRATO: % EQUIPE: % % IC_DISTRIBUI_PROFISSIONAL: % PERIODO FATURAMENTO: % A %', 
      termo.nu_contrato, termo.nu_equipe, termo.co_equipe, termo.ic_distribui_profissional, termo.dt_inicio_fatura, termo.dt_final_fatura;
    RAISE NOTICE 'AJUSTE - CONTRATO: % EQUIPE: % % DT. INICIO ATEND.: % | DT. FINAL ATEND.: %', 
      termo.nu_contrato, termo.nu_equipe, termo.co_equipe, termo.dt_inicio_atendimento, termo.dt_final_atendimento;
    RAISE NOTICE 'AJUSTE - CONTRATO: % EQUIPE: % % GRUPO: % | IC_DIAS_CALCULO_PAGAMENTO: % | IC_CALCULO_PRO_RATA: %', 
      termo.nu_contrato, termo.nu_equipe, termo.co_equipe, termo.nu_tipo_grupo, termo.ic_dias_calculo_pagamento, termo.ic_calculo_pro_rata;

    for membros in(  
      select
        distinct e.nu_contrato,
        e.nu_tipo_grupo,
        e.nu_equipe,
        me.nu_perfil
      from
	   gct.gcttb264_amsta_equipe e
        inner join gct.gcttb268_amsta_membros_equipe me on(
          e.nu_equipe = me.nu_equipe
          and e.nu_ajuste = me.nu_ajuste
        )
      where
        e.nu_equipe = termo.nu_equipe
        and me.nu_ajuste = p_nu_ajuste
      order by
        e.nu_contrato,
        e.nu_tipo_grupo,
        me.nu_perfil    
    )
    loop

      --
      -- RN543 – Valor do Preço da Equipe
      --
      select
        vr_preco_grupo,
        nu_tipo_preco
      into 
        v_vr_preco_grupo, 
        v_nu_tipo_preco     
      from
        gct.gcttb524_preco_cntrto_equipe_perfil p
        inner join gct.gcttb087_equipe e on (
          e.nu_contrato = p.nu_contrato 
          and e.nu_tipo_grupo = p.nu_tipo_grupo
        )
      where
        e.nu_equipe = termo.nu_equipe
        and p.nu_perfil = membros.nu_perfil
        and p.nu_tipo_preco = 1
        and (
          termo.dt_final_fatura between dt_inicio_vigencia and dt_final_vigencia
          or
          e.dt_final_atendimento between dt_inicio_vigencia and dt_final_vigencia
        );

      --    
      -- INICIO CALCULO SEM PRO-RATA
      --
      if termo.ic_calculo_pro_rata = 'N' then

        v_dt_inicio_vigencia := termo.dt_inicio_fatura;

        if termo.dt_inicio_atendimento > termo.dt_inicio_fatura then
          
          v_dt_inicio_vigencia = termo.dt_inicio_atendimento;
        
        end if;

        select
          qmep.qt_membros,
          coalesce(dt_final_vigencia, termo.dt_final_fatura) into v_qt_membros_equipe,
          v_dt_final_vigencia
        from
          gct.gcttb523_qntde_membro_equipe_perfil qmep
          inner join gct.gcttb087_equipe e on e.nu_equipe = qmep.nu_equipe
        where
          e.nu_equipe = termo.nu_equipe
          and qmep.nu_perfil = membros.nu_perfil
          and coalesce(qmep.dt_final_vigencia, termo.dt_final_fatura) = (
            select
              max(
                coalesce(dt_final_vigencia, termo.dt_final_fatura)
              )
            from
              gct.gcttb523_qntde_membro_equipe_perfil q
            where
              q.nu_equipe = e.nu_equipe
              and q.nu_perfil = qmep.nu_perfil
            group by
              qmep.nu_perfil
          );

          -- qt. de dias de faturamento
          select gct.gctfn305_dias_entre_data( termo.dt_inicio_fatura, 
                                               termo.dt_final_fatura, 
                                               termo.co_sitio, 
                                               termo.ic_dias_calculo_pagamento) into v_qt_dias_faturamento;
											   
          -- dias trabalhados
          select gct.gctfn305_dias_entre_data(v_dt_inicio_vigencia, v_dt_final_vigencia, 
                                              termo.co_sitio, termo.ic_dias_calculo_pagamento) 
              into v_qt_dias_trabalhados;
      
          -- somatorio do valor previsto
          v_valor_previsto_equipe := coalesce(v_valor_previsto_equipe, 0) + 
              (coalesce(v_vr_preco_grupo,0) * (v_qt_dias_trabalhados / v_qt_dias_faturamento) * 
              coalesce(v_qt_membros_equipe, 0));

      end if;

      --    
      -- INICIO CALCULO PRO-RATA
      --
      if termo.ic_calculo_pro_rata = 'S' then
  
        for vigencias in (
          
          select
              q.nu_perfil,
              q.qt_membros,
              q.dt_inicio_vigencia,
              q.dt_final_vigencia,
              case when q.pc_alocacao_membro_efetiva > 1 then 1 else q.pc_alocacao_membro_efetiva end as pc_alocacao_membro_efetiva
          from
              (
                  select
                      qmep.nu_perfil,
                      qmep.qt_membros,
                      case
                          when dt_inicio_vigencia > termo.dt_inicio_fatura then dt_inicio_vigencia
                          else termo.dt_inicio_fatura
                      end as dt_inicio_vigencia,
                      case
                          when coalesce(qmep.dt_final_vigencia, termo.dt_final_fatura) > termo.dt_final_fatura then termo.dt_final_fatura
                          else coalesce(qmep.dt_final_vigencia, termo.dt_final_fatura)
                      end as dt_final_vigencia,
                      qmep.pc_alocacao_membro_efetiva
                  from
                      gct.gcttb523_qntde_membro_equipe_perfil qmep
                  where
                      qmep.nu_equipe = membros.nu_equipe
                      and qmep.nu_perfil = membros.nu_perfil
              ) q
          where
              q.dt_final_vigencia between termo.dt_inicio_fatura and termo.dt_final_fatura
          order by
              q.nu_perfil,
              q.dt_inicio_vigencia desc      
        
        )
        loop
  
          -- data de inicio da vigencia
          v_dt_inicio_vigencia := vigencias.dt_inicio_vigencia;
  
          if v_dt_inicio_vigencia < termo.dt_inicio_fatura then
              v_dt_inicio_vigencia := termo.dt_inicio_fatura;
          end if;
  
          -- data final da vigencia    
          v_dt_final_vigencia := vigencias.dt_final_vigencia;

          if v_dt_final_vigencia > termo.dt_final_fatura then
              v_dt_final_vigencia := termo.dt_final_fatura;
          end if;

          -- qt. de dias de faturamento
          select gct.gctfn305_dias_entre_data( termo.dt_inicio_fatura, 
                                               termo.dt_final_fatura, 
                                               termo.co_sitio, 
                                               termo.ic_dias_calculo_pagamento) into v_qt_dias_faturamento;

          -- qt. dias trabalhados
          select gct.gctfn305_dias_entre_data( v_dt_inicio_vigencia, 
                                               v_dt_final_vigencia, 
                                               termo.co_sitio, 
                                               termo.ic_dias_calculo_pagamento) into v_qt_dias_trabalhados;

          -- quantidade de membros
          v_qt_membros_equipe := (v_qt_dias_trabalhados / v_qt_dias_faturamento) * coalesce(vigencias.qt_membros, 0);

          -- somatorio do valor previsto
          v_valor_previsto_perfil := coalesce(v_vr_preco_grupo,0) * v_qt_membros_equipe * coalesce(vigencias.pc_alocacao_membro_efetiva,1);
  
          RAISE NOTICE 'AJUSTE - CONTRATO: % EQUIPE: % % PERFIL: % VIGENCIA: % A %', 
            termo.nu_contrato, termo.nu_equipe, termo.co_equipe, 
            membros.nu_perfil, v_dt_inicio_vigencia, v_dt_final_vigencia;

          RAISE NOTICE 'AJUSTE - CONTRATO: % EQUIPE: % % QT. DIAS FAT.:% QT. DIAS TRAB.: % PRECO: %', 
            termo.nu_contrato, termo.nu_equipe, termo.co_equipe, 
            v_qt_dias_faturamento, v_qt_dias_trabalhados, v_vr_preco_grupo;

          RAISE NOTICE 'AJUSTE - CONTRATO: % EQUIPE: % % QT. MEMBROS: % VR. PREVISTO: %', 
            termo.nu_contrato, termo.nu_equipe, termo.co_equipe, 
            v_qt_membros_equipe, v_valor_previsto_perfil;

          v_qt_membros_efetiva = coalesce(v_qt_membros_equipe, 0) + coalesce(v_qt_membros_efetiva, 0);
          
          v_valor_previsto_equipe = coalesce(v_valor_previsto_perfil, 0) + v_valor_previsto_equipe;

        end loop;

        RAISE NOTICE 'AJUSTE - CONTRATO: % EQUIPE: % % QT. MEMBROS EFETIVA: % VR. PREVISTO EQUIPE: %', 
          termo.nu_contrato, termo.nu_equipe, termo.co_equipe, 
            v_qt_membros_efetiva, v_valor_previsto_equipe;

      end if;

      --
      -- AUSENCIAS
      --
      select sum(coalesce(qt_dia_ausencia,0)) 
        into v_qt_dias_ausencia
        from gct.gcttb180_amostra_ausencia_servico_extra
       where nu_equipe = termo.nu_equipe
         and nu_perfil_ausencia = membros.nu_perfil
         and nu_fatura = termo.nu_fatura_gerada
         and nu_ajuste = p_nu_ajuste;
      
      v_decrescimo :=  v_decrescimo + (v_vr_preco_grupo * (coalesce(v_qt_dias_ausencia, 0) / v_qt_dias_faturamento));
  
      RAISE NOTICE 'AJUSTE - CONTRATO: % EQUIPE: % % DPEC: [% * (% / %)] %',
        termo.nu_contrato, termo.nu_equipe, termo.co_equipe, 
          v_vr_preco_grupo, coalesce(v_qt_dias_ausencia, 0), v_qt_dias_faturamento,
            (v_vr_preco_grupo * (coalesce(v_qt_dias_ausencia, 0) / v_qt_dias_faturamento));

      -- 
      -- SERVICO EXTRA
      --
      select sum(coalesce(qt_dia_servico_extra,0)) 
        into v_qt_dias_servico_extra
        from gct.gcttb180_amostra_ausencia_servico_extra
       where nu_equipe = termo.nu_equipe
         and nu_perfil_servico_extra = membros.nu_perfil
         and nu_fatura = termo.nu_fatura_gerada
         and nu_ajuste = p_nu_ajuste;
  
      v_acrescimo := v_acrescimo + (v_vr_preco_grupo * (coalesce(v_qt_dias_servico_extra,0) / v_qt_dias_faturamento)); 

      RAISE NOTICE 'AJUSTE - CONTRATO: % EQUIPE: % % APEC: [% * (% / %)] %', 
        termo.nu_contrato, termo.nu_equipe, termo.co_equipe, 
          v_vr_preco_grupo, coalesce(v_qt_dias_servico_extra,0), v_qt_dias_faturamento,
            (v_vr_preco_grupo * (coalesce(v_qt_dias_servico_extra,0) / v_qt_dias_faturamento));

    end loop; 

    v_valor_financeiro := v_valor_previsto_equipe + (v_acrescimo - v_decrescimo);
    
    select NEXTVAL ('gct.gctsq170_nu_termo_equipe') into v_nu_termo_gerado;

    RAISE NOTICE 'AJUSTE - CONTRATO: % EQUIPE: % % TERMO GERADO: % | FATURA: %',
      termo.nu_contrato, termo.nu_equipe, termo.co_equipe, v_nu_termo_gerado, termo.nu_fatura;
    RAISE NOTICE 'AJUSTE - CONTRATO: % EQUIPE: % % VR. PRECO: % | VR. PREVISTO: % | VR. FINANC. TERMO: %', 
      termo.nu_contrato, termo.nu_equipe, termo.co_equipe, v_vr_preco_grupo, v_valor_previsto_equipe, v_valor_financeiro;

    select count(*) into v_tem_comunidade FROM gct.gcttb001_area_interna a
    	where a.nu_area_interna = termo.nu_area_interna and a.nu_comunidade is not null;
      
    if(v_tem_comunidade is not null and v_tem_comunidade>0) then

      select 
        com.nu_comunidade, com.no_comunidade into v_nu_comunidade, v_no_comunidade
      FROM 
        gct.gcttb001_area_interna a
        inner join gct.gcttb405_comunidade com on com.nu_comunidade = a.nu_comunidade
      where 
        a.nu_area_interna = termo.nu_area_interna;

    	RAISE NOTICE 'AJUSTE - CONTRATO: % EQUIPE: % % COMUNIDADE: %', 
        termo.nu_contrato, termo.nu_equipe, termo.co_equipe, v_no_comunidade;

    else

      v_nu_comunidade := null;

    	RAISE NOTICE 'AJUSTE - CONTRATO: % EQUIPE: % % COMUNIDADE: NÃO ENCONTRADA', 
        termo.nu_contrato, termo.nu_equipe, termo.co_equipe;

    end if;      
      
    insert into
      gct.gcttb170_termo_equipe (
        nu_termo_equipe,
        nu_equipe,
        nu_tipo_termo,
        nu_fatura_gerada,
        nu_fatura_paga,
        dh_emissao_termo,
        vr_financeiro_termo,
        vr_financeiro_termo_original,
        qt_membro_equipe_vigente,
        vr_preco_grupo,
        vr_previsto_equipe,
        vr_acrescimo,
        vr_decrescimo,
        nu_contrato,
        nu_tipo_grupo,
        nu_situacao_termo,
        co_termo,
        nu_area_interna_pagadora,
        nu_matricula_responsavel_area_pagadora,
        no_sigla_area_pagadora,
        qt_dia_servico_extra,
        qt_dia_ausencia,
        ic_tipo_atendimento,
        ic_dias_calculo_pagamento,
        ic_permite_servico_extra,
        ic_permite_registro_ausencia,
        ic_calculo_pro_rata,
        nu_tipo_preco,
        dt_inicio_atendimento_equipe,
        dt_final_atendimento_equipe,
        co_sitio,
        nu_motivo_termo,
        nu_ajuste,
        nu_comunidade,
        no_comunidade,
        nu_rubrica_padrao,
        co_rubrica_padrao
      )
    values
      (
        v_nu_termo_gerado,
        termo.nu_equipe,
        v_nu_tipo_termo,
        termo.nu_fatura,
        termo.nu_fatura,
        now(),
        v_valor_financeiro,
        v_valor_financeiro,
        v_qt_membros_efetiva,
        v_vr_preco_grupo,
        v_valor_previsto_equipe,
        v_acrescimo,
        v_decrescimo,
        termo.nu_contrato,
        termo.nu_tipo_grupo,
        v_nu_situacao_termo,
        upper(v_co_termo),
        termo.nu_area_interna,
        termo.nu_mtrca_responsavel,
        termo.no_sigla_area,
        v_qt_dias_servico_extra,
        v_qt_dias_ausencia,
        termo.ic_tipo_atendimento,
        termo.ic_dias_calculo_pagamento,
        termo.ic_permite_servico_extra,
        termo.ic_permite_registro_ausencia,
        termo.ic_calculo_pro_rata,
        v_nu_tipo_preco,
        termo.dt_inicio_atendimento,
        termo.dt_final_atendimento,
        termo.co_sitio,
        v_nu_motivo_termo,
        p_nu_ajuste,
        v_nu_comunidade,
        v_no_comunidade,
        termo.nu_rubrica_padrao,
        termo.co_rubrica_padrao
      );
      
      -- raise notice '-----------> % % % %',
        -- p_nu_ajuste, termo.nu_equipe, termo.nu_termo_equipe, v_nu_termo_gerado;

      insert into gct.gcttb186_termo_ajuste_equipe 
      values (p_nu_ajuste, termo.nu_equipe, termo.nu_termo_equipe, v_nu_termo_gerado);

    RAISE NOTICE '';  
 
  END LOOP; -- LOOP TERMO

END;

$function$;

alter function gct.gctfn176_simular_termo_ajuste_equipe(p_nu_ajuste numeric, p_nu_equipe numeric) owner to gct;

--------------------------------------------------------------------------------
-- -- gctfn177_calcular_indicador_ajuste
-- --------------------------------------------------------------------------------

-- drop function if exists gct.gctfn177_calcular_indicador_ajuste(p_nu_ajuste numeric, p_nu_equipe numeric);

CREATE OR REPLACE FUNCTION gct.gctfn177_calcular_indicador_ajuste(p_nu_ajuste numeric, p_nu_equipe numeric)
 RETURNS void
 LANGUAGE plpgsql
AS $function$

/*

RELEASE NOTES

RTC 23671403 - SIGCT - Indicadores do contrato especializado

*/

DECLARE
      
  equipe RECORD;

BEGIN
  
  raise notice 'CALCULO INDICADOR - AJUSTE: % EQUIPE: % - INICIANDO...', p_nu_ajuste, p_nu_equipe;

  raise notice 'CALCULO INDICADOR - AJUSTE: % EQUIPE: % - REMOVENDO INDICADORES...', p_nu_ajuste, p_nu_equipe;
  
  delete from gct.gcttb172_valor_indicador_equipe where nu_ajuste = p_nu_ajuste and nu_equipe = p_nu_equipe;

  for equipe in (
    select
      f.dt_final_fatura,
      f.de_fatura,
      e.nu_equipe,
      gc.nu_tipo_grupo,
      gc.dt_considerar_fns,
      te.nu_fatura_gerada as nu_fatura
    from
      gct.gcttb264_amsta_equipe e
      inner join gct.gcttb010_contrato c on e.nu_contrato = c.nu_contrato
      inner join gct.gcttb033_grupo_contrato gc on (
        gc.nu_contrato = e.nu_contrato
        and gc.nu_tipo_grupo = e.nu_tipo_grupo
      )
      inner join gct.gcttb032_tipo_grupo tg on tg.nu_tipo_grupo = gc.nu_tipo_grupo
      inner join gct.gcttb001_area_interna ai on ai.nu_area_interna = e.nu_area_interna
      inner join gct.gcttb170_termo_equipe te on (
        te.nu_equipe = e.nu_equipe
        and te.nu_ajuste = e.nu_ajuste
        and te.nu_equipe = e.nu_equipe
      )
      inner join gct.gcttb102_fatura f on f.nu_fatura = te.nu_fatura_gerada
      inner join gct.gcttb115_grupo_indicador gi on (
        gi.nu_contrato = e.nu_contrato
        and gi.nu_tipo_grupo = e.nu_tipo_grupo
        and gi.ic_aplica_indicador = 'S'
      )
      inner join gct.gcttb172_valor_indicador_equipe vie on (
        vie.nu_equipe = e.nu_equipe
        and vie.nu_fatura = te.nu_fatura_gerada
        and vie.nu_tipo_indicador = gi.nu_tipo_indicador
      )
    where
      e.nu_ajuste = p_nu_ajuste
      and e.nu_equipe = p_nu_equipe
      and te.nu_tipo_termo = 90 -- FICTICIO
    order by
      f.dt_final_fatura
  )
  loop

    raise notice 'INDICADOR - FATURA: % | DT. FINAL FATURA: %', equipe.nu_fatura, equipe.dt_final_fatura;

    perform gct.gctfn178_indcdr_eftvde_ajuste           (equipe.nu_equipe, equipe.nu_fatura, p_nu_ajuste);
    perform gct.gctfn179_indcdr_eftvde_sprte_ajuste     (equipe.nu_equipe, equipe.nu_fatura, p_nu_ajuste, p_nu_matricula);
    perform gct.gctfn180_indcdr_produtividade_ajuste    (equipe.nu_equipe, equipe.nu_fatura, p_nu_ajuste);
    
    -- --
    -- -- OS INDICADORES DE QUALIDADE DEVEM PROCESSADOS EXATAMENTE NESSA ORDEM
    -- --
    perform gct.gctfn181_indcdr_reducao_defeitos_ajuste (equipe.nu_equipe, equipe.nu_fatura, p_nu_ajuste);
    perform gct.gctfn182_indcdr_nota_codigo_ajuste      (equipe.nu_equipe, equipe.nu_fatura, p_nu_ajuste);
    perform gct.gctfn183_indcdr_qualidade_ajuste        (equipe.nu_equipe, equipe.nu_fatura, p_nu_ajuste);
          
    perform gct.gctfn184_indcdr_turnover_eqpe_ajuste         (equipe.nu_equipe, equipe.nu_fatura, p_nu_ajuste);
    perform gct.gctfn185_calcular_fator_nivel_servico_ajuste (equipe.nu_equipe, equipe.nu_fatura, p_nu_ajuste);

    -- --
    -- --
    -- --
    -- perform gct.gctfn118_gerar_termo_indicador        (equipe.nu_equipe, equipe.nu_fatura, p_nu_matricula);

    -- --
    -- --
    -- --
    -- perform gct.gctfn124_indicador_desempenho_equipe  (equipe.nu_equipe, equipe.nu_fatura, p_dt_referencia, p_nu_matricula);

    raise notice '';
  
  end loop;

  raise notice 'CALCULO INDICADOR - AJUSTE: % - CONCLUIDO.', p_nu_ajuste;

END;
$function$;

alter function gct.gctfn177_calcular_indicador_ajuste(p_nu_ajuste numeric, p_nu_equipe numeric) owner to gct;

--------------------------------------------------------------------------------
-- -- gctfn178_indcdr_eftvde_ajuste
-- --------------------------------------------------------------------------------

-- drop function if exists gct.gctfn178_indcdr_eftvde_ajuste(p_nu_equipe numeric, p_nu_fatura numeric, p_nu_ajuste numeric);

CREATE OR REPLACE FUNCTION gct.gctfn178_indcdr_eftvde_ajuste(p_nu_equipe numeric, p_nu_fatura numeric, p_nu_ajuste numeric)
 RETURNS numeric
 LANGUAGE plpgsql
AS $function$

/**

RELEASE NOTES

RTC 23671403 - SIGCT - Indicadores do contrato especializado

*/

DECLARE

  v_nu_tipo_indicador numeric;
  v_nu_tipo_grupo numeric;
  v_sg_tipo_indicador varchar;
  v_no_tipo_indicador varchar;
  v_nu_contrato numeric;
  v_no_tipo_grupo varchar;
  v_co_equipe varchar;
  v_qt_sprints_periodo numeric;
  v_qt_itens_atendidos numeric;
  v_qt_itens_contratados numeric;

  v_dt_referencia date;
  v_vr_calculo_indicador numeric;
  v_dt_inicio_indicador timestamp;
  v_dt_final_indicador timestamp;

  v_sql text;  
				
BEGIN

  --
  -- DETERMINANDO O PERIODO A SER CALCULADO
  --
  select
    date_trunc('month', f.dt_final_fatura) + interval '1 month' into v_dt_referencia
  from
    gct.gcttb102_fatura f
  where
    nu_fatura = p_nu_fatura;

  v_dt_inicio_indicador = date_trunc('month', v_dt_referencia::date) - interval '1 month';
  v_dt_final_indicador := date_trunc('month', v_dt_referencia::date) - interval '1 day' + time '23:59:59';

  v_nu_tipo_indicador := 36;  -- FIXO CONFORME CARGA FEITA

  select
    trim(ti.sg_tipo_indicador),
    ti.no_tipo_indicador
  into 
    v_sg_tipo_indicador,
    v_no_tipo_indicador
  from
    gct.gcttb264_amsta_equipe e
    inner join gct.gcttb010_contrato c on e.nu_contrato = c.nu_contrato
    inner join gct.gcttb033_grupo_contrato gc on (
      gc.nu_contrato = e.nu_contrato
      and gc.nu_tipo_grupo = e.nu_tipo_grupo
    )
    inner join gct.gcttb032_tipo_grupo tg on tg.nu_tipo_grupo = gc.nu_tipo_grupo
    inner join gct.gcttb115_grupo_indicador gi on (
      gi.nu_tipo_grupo = gc.nu_tipo_grupo
      and gi.nu_contrato = gc.nu_contrato
    )
    inner join gct.gcttb112_tipo_indicador ti on ( 
      ti.nu_tipo_indicador = gi.nu_tipo_indicador
      and ti.nu_tipo_indicador = v_nu_tipo_indicador
    )
  where
    e.nu_ajuste = p_nu_ajuste
    and e.nu_equipe = p_nu_equipe;

  select 
    e.nu_contrato,
    e.co_equipe,
    tg.nu_tipo_grupo,
    tg.no_tipo_grupo
  into
    v_nu_contrato,
    v_co_equipe,
    v_nu_tipo_grupo,
    v_no_tipo_grupo 
  from
    gct.gcttb264_amsta_equipe e
    inner join gct.gcttb032_tipo_grupo tg on tg.nu_tipo_grupo = e.nu_tipo_grupo
  where
    e.nu_ajuste = p_nu_ajuste
    and e.nu_equipe = p_nu_equipe;

  if(v_sg_tipo_indicador is null) then
    RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | INDICADOR IE - Efetividade(Desenvolvimento) - NAO FOI CONFIGURADO PARA O GRUPO.', 
      p_nu_equipe, v_co_equipe, v_no_tipo_grupo;
    return v_vr_calculo_indicador;  
  end if;

  --
  -- DESENVOLVIMENTO
  --
  --
  -- IE = (Somatorio(((Quantidade_Itens_Prontos_Sprint1 / Quantidade_Itens_Backlog_Sprint1) + 
  --        (Quantidade_Itens_Prontos_SprintN Quantidade_Itens_Backlog_SprintN))) /
  --                                       N(quantidade de sprints)
  --

  --
  -- Quantidade de sprints periodo
  --
  v_sql := '
    select
      count (distinct cct.nu_ciclo_trabalho)
    from
      gct.gcttb266_amsta_slctco_equipe se
      inner join gct.gcttb264_amsta_equipe e on (
        e.nu_ajuste = se.nu_ajuste
        and e.nu_contrato = se.nu_contrato
        and e.nu_equipe = se.nu_equipe
      )
      inner join gct.gcttb267_amsta_ciclo_trabalho cct on (
        cct.nu_ajuste = se.nu_ajuste
        and cct.nu_contrato = se.nu_contrato
        and cct.nu_equipe = se.nu_equipe
        and cct.nu_ciclo_trabalho = se.nu_ciclo_trabalho
      )
      inner join gct.gcttb265_amsta_solicitacao s on (
        s.nu_ajuste = se.nu_ajuste
        and s.nu_contrato = se.nu_contrato
        and se.nu_solicitacao = s.nu_solicitacao
      )
    where
      se.nu_ajuste = $1
      and se.nu_contrato = $2
      and se.nu_equipe = $3
      and se.ic_solicitacao_compoe_fns = $4
      and se.co_falha_solicitacao = $5
      and cct.dt_alvo_ciclo_trabalho between $6::date and $7::date';

  execute v_sql 
    using p_nu_ajuste, v_nu_contrato, p_nu_equipe, 'S', 'NF', v_dt_inicio_indicador, v_dt_final_indicador
     into v_qt_sprints_periodo;      

  --
  -- Quantidade_Itens_Atendidos
  --
  v_sql := '
    select
      count (distinct s.co_solicitacao)
    from
      gct.gcttb266_amsta_slctco_equipe se
      inner join gct.gcttb264_amsta_equipe e on (
        e.nu_ajuste = se.nu_ajuste
        and e.nu_contrato = se.nu_contrato
        and e.nu_equipe = se.nu_equipe
      )
      inner join gct.gcttb267_amsta_ciclo_trabalho cct on (
        cct.nu_ajuste = se.nu_ajuste
        and cct.nu_contrato = se.nu_contrato
        and cct.nu_equipe = se.nu_equipe
        and cct.nu_ciclo_trabalho = se.nu_ciclo_trabalho
      )
      inner join gct.gcttb265_amsta_solicitacao s on (
        s.nu_ajuste = se.nu_ajuste
        and s.nu_contrato = se.nu_contrato
        and s.nu_equipe = se.nu_equipe
        and se.nu_solicitacao = s.nu_solicitacao
      )
      inner join gct.gcttb191_servico_entregue se1 on (
        s.nu_situacao_solicitacao = se1.nu_situacao_atendimento
        and se1.nu_contrato = e.nu_contrato
        and se1.nu_tipo_grupo = e.nu_tipo_grupo
        and se1.nu_tipo_indicador = $1
      )
    where
      se.nu_ajuste = $2
      and se.nu_contrato = $3
      and se.nu_equipe = $4
      and se.ic_solicitacao_compoe_fns = $5
      and se.co_falha_solicitacao = $6
      and cct.dt_alvo_ciclo_trabalho between $7::date and $8::date';

  execute v_sql 
    using v_nu_tipo_indicador, p_nu_ajuste, v_nu_contrato, p_nu_equipe, 'S', 'NF', v_dt_inicio_indicador, v_dt_final_indicador
     into v_qt_itens_atendidos;

  --
  -- Quantidade_Itens_Backlog
  --
  v_sql := '
    select
      count (distinct s.co_solicitacao)
    from
      gct.gcttb266_amsta_slctco_equipe se
      inner join gct.gcttb264_amsta_equipe e on (
        e.nu_ajuste = se.nu_ajuste
        and e.nu_contrato = se.nu_contrato
        and e.nu_equipe = se.nu_equipe
      )
      inner join gct.gcttb267_amsta_ciclo_trabalho cct on (
        cct.nu_ajuste = se.nu_ajuste
        and cct.nu_contrato = se.nu_contrato
        and cct.nu_equipe = se.nu_equipe
        and cct.nu_ciclo_trabalho = se.nu_ciclo_trabalho
      )
      inner join gct.gcttb265_amsta_solicitacao s on (
        s.nu_ajuste = se.nu_ajuste
        and s.nu_contrato = se.nu_contrato
        and s.nu_equipe = se.nu_equipe
        and se.nu_solicitacao = s.nu_solicitacao
      )
      inner join gct.gcttb192_servico_contratado se1 on (
        s.nu_situacao_solicitacao = se1.nu_situacao_atendimento
        and se1.nu_contrato = e.nu_contrato
        and se1.nu_tipo_grupo = e.nu_tipo_grupo
        and se1.nu_tipo_indicador = $1
      )
    where
      se.nu_ajuste = $2
      and se.nu_contrato = $3
      and se.nu_equipe = $4
      and se.ic_solicitacao_compoe_fns = $5
      and se.co_falha_solicitacao = $6
      and cct.dt_alvo_ciclo_trabalho between $7 and $8';

  execute v_sql 
    using v_nu_tipo_indicador, p_nu_ajuste, v_nu_contrato, p_nu_equipe, 'S', 'NF', v_dt_inicio_indicador, v_dt_final_indicador
     into v_qt_itens_contratados;

  v_vr_calculo_indicador := 1::numeric;

  if v_nu_tipo_indicador is not null then

    if v_qt_itens_contratados <> 0 then
      v_vr_calculo_indicador := (v_qt_itens_atendidos / v_qt_itens_contratados) / v_qt_sprints_periodo;
    end if;

    RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | IE - Efetividade(Desenvolvimento) - PERIODO: % a %', 
      p_nu_equipe, v_co_equipe, v_no_tipo_grupo, v_dt_inicio_indicador, v_dt_final_indicador;

    RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | IE - Efetividade(Desenvolvimento) - QT. ITENS ATENDIDOS (A): %', 
      p_nu_equipe, v_co_equipe, v_no_tipo_grupo, v_qt_itens_atendidos;

    RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | IE - Efetividade(Desenvolvimento) - QT. ITENS CONTRATADOS (B): %', 
      p_nu_equipe, v_co_equipe, v_no_tipo_grupo, v_qt_itens_contratados;

    RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | IE - Efetividade(Desenvolvimento) - QT. SPRINTS (C): %', 
      p_nu_equipe, v_co_equipe, v_no_tipo_grupo, v_qt_sprints_periodo;

    RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | IE - Efetividade(Desenvolvimento) - VALOR INDICADOR (A / B) / C: (% / %) / % = %', 
      p_nu_equipe, v_co_equipe, v_no_tipo_grupo, v_qt_itens_atendidos, v_qt_itens_contratados, v_qt_sprints_periodo, v_vr_calculo_indicador;

    PERFORM gct.gctfn186_registrar_valor_indcdr_equipe_ajuste(p_nu_equipe, p_nu_fatura, p_nu_ajuste, v_nu_tipo_indicador, v_vr_calculo_indicador);
  end if;

  return v_vr_calculo_indicador;

END;
$function$;

alter function gct.gctfn178_indcdr_eftvde_ajuste(p_nu_equipe numeric, p_nu_fatura numeric, p_nu_ajuste numeric) owner to gct;

--------------------------------------------------------------------------------
-- -- gctfn179_indcdr_eftvde_sprte_ajuste
-- --------------------------------------------------------------------------------

-- drop function if exists gct.gctfn179_indcdr_eftvde_sprte_ajuste(p_nu_equipe numeric, p_nu_fatura numeric, p_dt_referencia date, p_nu_matricula numeric);

CREATE OR REPLACE FUNCTION gct.gctfn179_indcdr_eftvde_sprte_ajuste(p_nu_equipe numeric, p_nu_fatura numeric, p_dt_referencia date, p_nu_matricula numeric)
 RETURNS numeric
 LANGUAGE plpgsql
AS $function$

/**

RELEASE NOTES

RTC 23671403 - SIGCT - Indicadores do contrato especializado

*/

DECLARE

  v_nu_tipo_indicador numeric;
  v_nu_tipo_grupo numeric;
  v_sg_tipo_indicador varchar;
  v_no_tipo_indicador varchar;
  v_nu_contrato numeric;
  v_no_tipo_grupo varchar;
  v_co_equipe varchar;
  v_qt_itens_atendidos numeric;
  v_qt_itens_contratados numeric;

  v_vr_calculo_indicador numeric;
  v_dt_inicio_indicador timestamp;
  v_dt_final_indicador timestamp;

  v_sql text;  
				
BEGIN

  --
  -- DETERMINANDO O PERIODO A SER CALCULADO
  --
  v_dt_inicio_indicador = date_trunc('month', p_dt_referencia::date) - interval '1 month';
  v_dt_final_indicador := date_trunc('month', p_dt_referencia::date) - interval '1 day' + time '23:59:59';

  v_nu_tipo_indicador := 37;  -- FIXO CONFORME CARGA FEITA

  select
    trim(ti.sg_tipo_indicador),
    ti.no_tipo_indicador
  into 
    v_sg_tipo_indicador,
    v_no_tipo_indicador
  from
    gct.gcttb010_contrato c
    inner join gct.gcttb264_amsta_equipe e on e.nu_contrato = c.nu_contrato
    inner join gct.gcttb033_grupo_contrato gc on (
      gc.nu_contrato = e.nu_contrato
      and gc.nu_tipo_grupo = e.nu_tipo_grupo
    )
    inner join gct.gcttb032_tipo_grupo tg on tg.nu_tipo_grupo = gc.nu_tipo_grupo
    inner join gct.gcttb115_grupo_indicador gi on (
      gi.nu_tipo_grupo = gc.nu_tipo_grupo
      and gi.nu_contrato = gc.nu_contrato
    )
    inner join gct.gcttb112_tipo_indicador ti on ( 
      ti.nu_tipo_indicador = gi.nu_tipo_indicador
      and ti.nu_tipo_indicador = v_nu_tipo_indicador
    )
  where
    e.dt_referencia = p_dt_referencia
    and e.nu_equipe = p_nu_equipe;

  select 
    e.nu_contrato,
    e.co_equipe,
    tg.nu_tipo_grupo,
    tg.no_tipo_grupo
  into
    v_nu_contrato,
    v_co_equipe,
    v_nu_tipo_grupo,
    v_no_tipo_grupo 
  from
    gct.gcttb264_amsta_equipe e
    inner join gct.gcttb032_tipo_grupo tg on tg.nu_tipo_grupo = e.nu_tipo_grupo
  where
    e.dt_referencia = p_dt_referencia
    and e.nu_equipe = p_nu_equipe;

  if(v_sg_tipo_indicador is null) then
    RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | O INDICADOR IE - Efetividade(Suporte) NAO FOI CONFIGURADO PARA O GRUPO.', 
      p_nu_equipe, v_co_equipe, v_no_tipo_grupo;
    return v_vr_calculo_indicador;  
  end if;

  --
  -- SUPORTE
  --
  --
  -- IE = Quantidade_Itens_Atendidos / Quantidade_Itens_Backlog
  --

  --
  -- Quantidade_Itens_Atendidos
  --
  v_sql := '
    select
      count(distinct s.co_solicitacao) 
    from
      gct.gcttb266_amsta_slctco_equipe se
      inner join gct.gcttb264_amsta_equipe e on (
        e.nu_equipe = se.nu_equipe
        and e.dt_referencia = se.dt_referencia
      )
      inner join gct.gcttb265_amsta_solicitacao s on (
        se.nu_solicitacao = s.nu_solicitacao
        and s.dt_referencia = se.dt_referencia
      )
      inner join gct.gcttb191_servico_entregue se1 on (
        s.nu_situacao_solicitacao = se1.nu_situacao_atendimento
        and se1.nu_contrato = e.nu_contrato
        and se1.nu_tipo_grupo = e.nu_tipo_grupo
        and se1.nu_tipo_indicador = $1
      )      
    where
      se.dt_referencia = $2
      and se.nu_contrato = $3
      and se.nu_equipe = $4
      and s.dh_efetiva::date between $5::date and $6::date
      and se.ic_solicitacao_compoe_fns = $7
      and se.co_falha_solicitacao = $8';

  execute v_sql 
    using v_nu_tipo_indicador, p_dt_referencia, v_nu_contrato, p_nu_equipe, v_dt_inicio_indicador, v_dt_final_indicador, 'S', 'NF' 
     into v_qt_itens_atendidos;      

  --
  -- Quantidade_Itens_Backlog
  --
  v_sql := '
    select
      count(distinct s.co_solicitacao)
    from
      gct.gcttb266_amsta_slctco_equipe se
      inner join gct.gcttb264_amsta_equipe e on (
        e.nu_equipe = se.nu_equipe
        and e.dt_referencia = se.dt_referencia
      )
      inner join gct.gcttb265_amsta_solicitacao s on (
        se.nu_solicitacao = s.nu_solicitacao
        and s.dt_referencia = se.dt_referencia
      )
      inner join gct.gcttb192_servico_contratado se1 on (
        s.nu_situacao_solicitacao = se1.nu_situacao_atendimento
        and se1.nu_contrato = e.nu_contrato
        and se1.nu_tipo_grupo = e.nu_tipo_grupo
        and se1.nu_tipo_indicador = $1
      )      
    where
      se.dt_referencia = $2
      and se.nu_contrato = $3
      and se.nu_equipe = $4
      and s.dh_efetiva::date between $5::date and $6::date
      and se.ic_solicitacao_compoe_fns = $7
      and se.co_falha_solicitacao = $8';

  execute v_sql 
    using v_nu_tipo_indicador, p_dt_referencia, v_nu_contrato, p_nu_equipe, v_dt_inicio_indicador, v_dt_final_indicador, 'S', 'NF' 
     into v_qt_itens_contratados;       

  v_vr_calculo_indicador := 1::numeric;

  if v_nu_tipo_indicador is not null then

    RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | IE - Efetividade(Suporte) - PERIODO: % a %', 
      p_nu_equipe, v_co_equipe, v_no_tipo_grupo, v_dt_inicio_indicador, v_dt_final_indicador;

    RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | IE - Efetividade(Suporte) - QT. ITENS ATENDIDOS (A): %', 
      p_nu_equipe, v_co_equipe, v_no_tipo_grupo, v_qt_itens_atendidos;

    RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | IE - Efetividade(Suporte) - QT. ITENS CONTRATADOS (B): %', 
      p_nu_equipe, v_co_equipe, v_no_tipo_grupo, v_qt_itens_contratados;

    if v_qt_itens_contratados <> 0 then
      v_vr_calculo_indicador := v_qt_itens_atendidos / v_qt_itens_contratados;
    end if;

    RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | IE - Efetividade(Suporte) - VALOR INDICADOR (A/B): %/% = %', 
      p_nu_equipe, v_co_equipe, v_no_tipo_grupo, v_qt_itens_atendidos, v_qt_itens_contratados, v_vr_calculo_indicador;

    PERFORM gct.gctfn119_registrar_valor_indicador_equipe(p_nu_equipe, p_nu_fatura, p_dt_referencia, v_nu_tipo_indicador, v_vr_calculo_indicador, 'S');
  end if;

  return v_vr_calculo_indicador;

END;
$function$;

alter function gct.gctfn179_indcdr_eftvde_sprte_ajuste(p_nu_equipe numeric, p_nu_fatura numeric, p_dt_referencia date, p_nu_matricula numeric) owner to gct;

--------------------------------------------------------------------------------
-- -- gctfn186_registrar_valor_indcdr_equipe_ajuste_ddl
-- --------------------------------------------------------------------------------

-- drop function if exists gct.gctfn186_registrar_valor_indcdr_equipe_ajuste(p_nu_equipe numeric, p_nu_fatura numeric, p_nu_ajuste numeric, p_nu_tipo_indicador numeric, p_vr_indicador numeric, p_ic_recupera_vr_faixa char);

CREATE OR REPLACE FUNCTION gct.gctfn186_registrar_valor_indcdr_equipe_ajuste(p_nu_equipe numeric, p_nu_fatura numeric, p_nu_ajuste numeric, p_nu_tipo_indicador numeric, p_vr_indicador numeric, p_ic_recupera_vr_faixa char default 'S')
 RETURNS void
 LANGUAGE plpgsql
AS $function$
	
DECLARE 

  indicador record;

  v_dt_inicio_indicador date;
  v_dt_final_indicador date;
  v_vr_calculo_indicador numeric;
  v_vr_faixa_fns numeric;
  v_dt_referencia date;

BEGIN

  --
  -- DETERMINANDO O PERIODO A SER CALCULADO
  --
  select
    date_trunc('month', f.dt_final_fatura) + interval '1 month' into v_dt_referencia
  from
    gct.gcttb102_fatura f
  where
    nu_fatura = p_nu_fatura;

  v_dt_inicio_indicador = date_trunc('month', v_dt_referencia::date) - interval '1 month';
  v_dt_final_indicador := date_trunc('month', v_dt_referencia::date) - interval '1 day' + time '23:59:59';

  for indicador in (
    select
      e.nu_ajuste,
      e.nu_equipe,
      e.nu_contrato,
      e.nu_tipo_grupo,
      f.nu_fatura,
      f.dt_final_fatura,
      ti.nu_tipo_indicador,
      ti.sg_tipo_indicador,
      ti.no_tipo_indicador,
      gi.vr_peso_tipo_indicador
    from
      gct.gcttb264_amsta_equipe e
      inner join gct.gcttb033_grupo_contrato gc on (
        gc.nu_tipo_grupo = e.nu_tipo_grupo
        and gc.nu_contrato = e.nu_contrato
      )
      inner join gct.gcttb115_grupo_indicador gi on (
        gc.nu_contrato = gi.nu_contrato
        and gc.nu_tipo_grupo = gi.nu_tipo_grupo
      )
      inner join gct.gcttb112_tipo_indicador ti on ti.nu_tipo_indicador = gi.nu_tipo_indicador
      inner join gct.gcttb010_contrato c on c.nu_contrato = e.nu_contrato
      inner join gct.gcttb102_fatura f on f.nu_fatura = p_nu_fatura
    where
      e.nu_ajuste = p_nu_ajuste
      and gi.nu_tipo_indicador = p_nu_tipo_indicador
      and e.nu_equipe = p_nu_equipe
  )
  loop

    --
    -- REMOVE O CALCULO FEITO ANTEORIORMENTE
    --
    delete 
      from gct.gcttb172_valor_indicador_equipe 
    where 
      nu_ajuste = indicador.nu_ajuste
      and nu_fatura_ajuste = indicador.nu_fatura
      and nu_equipe = indicador.nu_equipe
      and nu_tipo_indicador = indicador.nu_tipo_indicador
      and nu_tipo_grupo = indicador.nu_tipo_grupo
      and nu_contrato = indicador.nu_contrato;    

    v_vr_calculo_indicador := p_vr_indicador;
    v_vr_faixa_fns := null;

    if p_ic_recupera_vr_faixa = 'S' then
      v_vr_faixa_fns := gct.gctfn120_recuperar_valor_faixa(indicador.nu_contrato, indicador.nu_tipo_grupo, indicador.nu_tipo_indicador, p_vr_indicador);
    else
      v_vr_faixa_fns := p_vr_indicador;
    end if;  

    insert into gct.gcttb172_valor_indicador_equipe( 
      nu_ajuste,
      nu_fatura_ajuste,
      nu_equipe,
      nu_tipo_grupo,
      nu_contrato,
      nu_tipo_indicador,
      dh_geracao_indicador_equipe,
      vr_calculo_indicador,
      dt_referencia,
      vr_peso_tipo_indicador,
      vr_faixa_fns,
      dt_inicio_indicador,
      dt_final_indicador
    )
    values (
      indicador.nu_ajuste,
      indicador.nu_fatura,
      indicador.nu_equipe,
      indicador.nu_tipo_grupo,
      indicador.nu_contrato,
      indicador.nu_tipo_indicador,
      current_timestamp,
      v_vr_calculo_indicador,
      indicador.dt_final_fatura,
      indicador.vr_peso_tipo_indicador,
      v_vr_faixa_fns,
      v_dt_inicio_indicador,
      v_dt_final_indicador
    );		

  end loop;

END;

$function$;

alter function gct.gctfn186_registrar_valor_indcdr_equipe_ajuste(p_nu_equipe numeric, p_nu_fatura numeric, p_nu_ajuste numeric, p_nu_tipo_indicador numeric, p_vr_indicador numeric, p_ic_recupera_vr_faixa char) owner to gct;

--------------------------------------------------------------------------------
-- -- gctfn180_indcdr_produtividade_ajuste
-- --------------------------------------------------------------------------------

-- drop function if exists gct.gctfn180_indcdr_produtividade_ajuste(p_nu_equipe numeric, p_nu_fatura numeric, p_nu_ajuste numeric);

CREATE OR REPLACE FUNCTION gct.gctfn180_indcdr_produtividade_ajuste(p_nu_equipe numeric, p_nu_fatura numeric, p_nu_ajuste numeric)
 RETURNS numeric
 LANGUAGE plpgsql
AS $function$

/**

RELEASE NOTES

RTC 23671403 - SIGCT - Indicadores do contrato especializado

*/

DECLARE

  v_nu_tipo_indicador numeric;
  v_nu_tipo_grupo numeric;
  v_sg_tipo_indicador varchar;
  v_no_tipo_indicador varchar;
  v_nu_contrato numeric;
  v_no_tipo_grupo varchar;
  v_co_equipe varchar;
  v_qt_tamanho_sprints numeric;
  v_produtividade_esperada numeric;
  v_qt_membros numeric;
  v_qt_dias_uteis numeric;

  v_dt_referencia date;
  v_vr_calculo_indicador numeric;
  v_dt_inicio_indicador timestamp;
  v_dt_final_indicador timestamp;

  v_sql text;  
				
BEGIN

  --
  -- DETERMINANDO O PERIODO A SER CALCULADO
  --
  select
    date_trunc('month', f.dt_final_fatura) + interval '1 month' into v_dt_referencia
  from
    gct.gcttb102_fatura f
  where
    nu_fatura = p_nu_fatura;

  v_dt_inicio_indicador = date_trunc('month', v_dt_referencia::date) - interval '1 month';
  v_dt_final_indicador := date_trunc('month', v_dt_referencia::date) - interval '1 day' + time '23:59:59';

  select
    ti.nu_tipo_indicador,
    trim(ti.sg_tipo_indicador),
    ti.no_tipo_indicador
  into 
    v_nu_tipo_indicador,
    v_sg_tipo_indicador,
    v_no_tipo_indicador
  from
    gct.gcttb010_contrato c
    inner join gct.gcttb264_amsta_equipe e on e.nu_contrato = c.nu_contrato
    inner join gct.gcttb033_grupo_contrato gc on (
      gc.nu_contrato = e.nu_contrato
      and gc.nu_tipo_grupo = e.nu_tipo_grupo
    )
    inner join gct.gcttb032_tipo_grupo tg on tg.nu_tipo_grupo = gc.nu_tipo_grupo
    inner join gct.gcttb115_grupo_indicador gi on (
      gi.nu_tipo_grupo = gc.nu_tipo_grupo
      and gi.nu_contrato = gc.nu_contrato
    )
    inner join gct.gcttb112_tipo_indicador ti on ( 
      ti.nu_tipo_indicador = gi.nu_tipo_indicador
      and ti.sg_tipo_indicador = 'IP'
    )
  where
    e.nu_ajuste = nu_ajuste
    and e.nu_equipe = p_nu_equipe;

  select 
    e.nu_contrato,
    e.co_equipe,
    tg.nu_tipo_grupo,
    tg.no_tipo_grupo
  into
    v_nu_contrato,
    v_co_equipe,
    v_nu_tipo_grupo,
    v_no_tipo_grupo 
  from
    gct.gcttb264_amsta_equipe e
    inner join gct.gcttb032_tipo_grupo tg on tg.nu_tipo_grupo = e.nu_tipo_grupo
  where
    e.nu_ajuste = p_nu_ajuste
    and e.nu_equipe = p_nu_equipe;

  if(v_sg_tipo_indicador is null) then
    RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | INDICADOR IP - Produtividade - NAO FOI CONFIGURADO PARA O GRUPO.', 
      p_nu_equipe, v_co_equipe, v_no_tipo_grupo;
    return v_vr_calculo_indicador;  
  end if;

  --
  -- DESENVOLVIMENTO
  --
  --
  -- IP = Pontos_Funcao / ( Colaboradores * PE * Dias_Uteis )
  --

  --
  -- Quantidade de Pontos de Funcao
  --
  v_sql := '
    select
      sum(se.nu_tamanho_servico)
    from
      gct.gcttb266_amsta_slctco_equipe se
      inner join gct.gcttb264_amsta_equipe e on (
        e.nu_ajuste = se.nu_ajuste
        and e.nu_contrato = se.nu_contrato
        and e.nu_equipe = se.nu_equipe
      )
      inner join gct.gcttb267_amsta_ciclo_trabalho cct on (
        cct.nu_ajuste = se.nu_ajuste
        and cct.nu_contrato = se.nu_contrato
        and cct.nu_equipe = se.nu_equipe
        and cct.nu_ciclo_trabalho = se.nu_ciclo_trabalho
      )
      inner join gct.gcttb265_amsta_solicitacao s on (
        se.nu_ajuste = s.nu_ajuste
        and se.nu_equipe = s.nu_equipe
        and se.nu_contrato = s.nu_contrato
        and se.nu_solicitacao = s.nu_solicitacao
      )
    where
      se.nu_ajuste = $1
      and se.nu_contrato = $2
      and se.nu_equipe = $3
      and se.ic_solicitacao_compoe_fns = $4
      and se.co_falha_solicitacao = $5
      and cct.dt_alvo_ciclo_trabalho between $6::date and $7::date';

  execute v_sql 
    using p_nu_ajuste, v_nu_contrato, p_nu_equipe, 'S', 'NF', v_dt_inicio_indicador, v_dt_final_indicador 
     into v_qt_tamanho_sprints; 

  --
  -- Quantidade efetiva de membros
  --
  v_sql := '
    select
      sum(
        gct.gctfn305_dias_entre_data(
          case when a.dt_inicio_membro < $1 then $1 else a.dt_inicio_membro end, 
          coalesce(a.dt_fim_membro,$2), 
          ai.co_sitio, gc.ic_dias_calculo_pagamento
        ) /
        gct.gctfn305_dias_entre_data($1, $2, ai.co_sitio, gc.ic_dias_calculo_pagamento)
      )
    from
      gct.gcttb268_amsta_membros_equipe a
      inner join gct.gcttb264_amsta_equipe e on (
        a.nu_ajuste = e.nu_ajuste
        and a.nu_contrato = e.nu_contrato
        and e.nu_equipe = a.nu_equipe
      )
      inner join gct.gcttb010_contrato c on c.nu_contrato = e.nu_contrato
      inner join gct.gcttb033_grupo_contrato gc on gc.nu_contrato = e.nu_contrato and gc.nu_tipo_grupo = e.nu_tipo_grupo
      inner join gct.gcttb001_area_interna ai on ai.nu_area_interna = e.nu_area_interna
    where
      a.nu_ajuste = $3
      and a.nu_contrato = $4
      and a.nu_equipe = $5
      and a.dt_inicio_membro <= $2
      and (
        a.dt_fim_membro is null
        or
        a.dt_fim_membro between $1 and $2
      )';

  EXECUTE v_sql 
    USING v_dt_inicio_indicador::date, v_dt_final_indicador::date, p_nu_ajuste, v_nu_contrato, p_nu_equipe
     INTO v_qt_membros;

  --
  -- Produtividade esperada
  --

  v_produtividade_esperada := 0.53333;  

  --
  -- Quantidade de dias uteis
  --
  v_sql := '
    select
      gct.gctfn305_dias_entre_data($1, $2, ai.co_sitio, gc.ic_dias_calculo_pagamento)
    from
      gct.gcttb264_amsta_equipe e
      inner join gct.gcttb010_contrato c on c.nu_contrato = e.nu_contrato
      inner join gct.gcttb033_grupo_contrato gc on gc.nu_contrato = e.nu_contrato and gc.nu_tipo_grupo = e.nu_tipo_grupo
      inner join gct.gcttb001_area_interna ai on ai.nu_area_interna = e.nu_area_interna
    where
      e.nu_ajuste = $3
      and e.nu_contrato = $4
      and e.nu_equipe = $5';

  EXECUTE v_sql 
    USING v_dt_inicio_indicador::date, v_dt_final_indicador::date, p_nu_ajuste, v_nu_contrato, p_nu_equipe 
     INTO v_qt_dias_uteis;

  v_vr_calculo_indicador := 1::numeric;

  if v_nu_tipo_indicador is not null then

    RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | IP - Produtividade - PERIODO: % a %', 
      p_nu_equipe, v_co_equipe, v_no_tipo_grupo, v_dt_inicio_indicador, v_dt_final_indicador;

    RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | IP - Produtividade - QT. PONTOS DE FUNCAO (A): %', 
      p_nu_equipe, v_co_equipe, v_no_tipo_grupo, v_qt_tamanho_sprints;

    RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | IP - Produtividade - QT. COLABORADORES (B): %', 
      p_nu_equipe, v_co_equipe, v_no_tipo_grupo, v_qt_membros;

    RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | IP - Produtividade - PRODUTIVIDADE ESPERADA (PE): %', 
      p_nu_equipe, v_co_equipe, v_no_tipo_grupo, v_produtividade_esperada;

    RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | IP - Produtividade - QT. DIAS UTEIS (C): %', 
      p_nu_equipe, v_co_equipe, v_no_tipo_grupo, v_qt_dias_uteis;

    if (v_qt_membros * v_produtividade_esperada * v_qt_dias_uteis) <> 0 then
      v_vr_calculo_indicador := v_qt_tamanho_sprints / (v_qt_membros * v_produtividade_esperada * v_qt_dias_uteis);
    end if;

    RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | IP - Produtividade - VALOR INDICADOR A/(B * PE * C): %/(% * % * %) = %', 
      p_nu_equipe, v_co_equipe, v_no_tipo_grupo, v_qt_tamanho_sprints, v_qt_membros, v_produtividade_esperada, v_qt_dias_uteis, v_vr_calculo_indicador;

    PERFORM gct.gctfn186_registrar_valor_indcdr_equipe_ajuste(p_nu_equipe, p_nu_fatura, p_nu_ajuste, v_nu_tipo_indicador, v_vr_calculo_indicador);
  end if;

  return v_vr_calculo_indicador;

END;
$function$;

alter function gct.gctfn180_indcdr_produtividade_ajuste(p_nu_equipe numeric, p_nu_fatura numeric, p_nu_ajuste numeric) owner to gct;

--------------------------------------------------------------------------------
-- -- gctfn181_indcdr_reducao_defeitos_ajuste
-- --------------------------------------------------------------------------------

-- drop function if exists gct.gctfn181_indcdr_reducao_defeitos_ajuste(p_nu_equipe numeric, p_nu_fatura numeric, p_nu_ajuste numeric);

CREATE OR REPLACE FUNCTION gct.gctfn181_indcdr_reducao_defeitos_ajuste(p_nu_equipe numeric, p_nu_fatura numeric, p_nu_ajuste numeric)
 RETURNS numeric
 LANGUAGE plpgsql
AS $function$

/**

RELEASE NOTES

RTC 23671403 - SIGCT - Indicadores do contrato especializado

*/

DECLARE

  v_nu_tipo_indicador numeric;
  v_nu_tipo_grupo numeric;
  v_sg_tipo_indicador varchar;
  v_no_tipo_indicador varchar;
  v_nu_contrato numeric;
  v_no_tipo_grupo varchar;
  v_co_equipe varchar;
  v_dt_inicio_indicador date;
  v_dt_final_indicador date;
  v_dt_inicio_perido_anterior date;
  v_dt_final_perido_anterior date;

  v_dt_referencia date;
  v_qt_itens_estoque numeric;
  v_qt_itens_estoque_anterior numeric;
  v_qt_itens_entregues numeric;
  v_qt_itens_entregues_anterior numeric;

  v_vr_calculo_indicador numeric;

  v_sql text;
				
BEGIN

  --
  -- DETERMINANDO O PERIODO A SER CALCULADO
  --
  select
    date_trunc('month', f.dt_final_fatura) + interval '1 month' into v_dt_referencia
  from
    gct.gcttb102_fatura f
  where
    nu_fatura = p_nu_fatura;

  v_dt_inicio_indicador = date_trunc('month', v_dt_referencia::date) - interval '1 month';
  v_dt_final_indicador := date_trunc('month', v_dt_referencia::date) - interval '1 day' + time '23:59:59';

  select
    ti.nu_tipo_indicador,
    trim(ti.sg_tipo_indicador),
    ti.no_tipo_indicador
  into 
    v_nu_tipo_indicador,
    v_sg_tipo_indicador,
    v_no_tipo_indicador
  from
    gct.gcttb010_contrato c
    inner join gct.gcttb264_amsta_equipe e on e.nu_contrato = c.nu_contrato
    inner join gct.gcttb033_grupo_contrato gc on (
      gc.nu_contrato = e.nu_contrato
      and gc.nu_tipo_grupo = e.nu_tipo_grupo
    )
    inner join gct.gcttb032_tipo_grupo tg on tg.nu_tipo_grupo = gc.nu_tipo_grupo
    inner join gct.gcttb115_grupo_indicador gi on (
      gi.nu_tipo_grupo = gc.nu_tipo_grupo
      and gi.nu_contrato = gc.nu_contrato
    )
    inner join gct.gcttb112_tipo_indicador ti on ( 
      ti.nu_tipo_indicador = gi.nu_tipo_indicador
      and ti.sg_tipo_indicador = 'IQRD'
    )
  where
    e.nu_ajuste = p_nu_ajuste
    and e.nu_equipe = p_nu_equipe;
    
  select 
    e.nu_contrato,
    e.co_equipe,
    tg.nu_tipo_grupo,
    tg.no_tipo_grupo
  into
    v_nu_contrato,
    v_co_equipe,
    v_nu_tipo_grupo,
    v_no_tipo_grupo 
  from
    gct.gcttb264_amsta_equipe e
    inner join gct.gcttb032_tipo_grupo tg on tg.nu_tipo_grupo = e.nu_tipo_grupo
  where
    e.nu_ajuste = p_nu_ajuste
    and e.nu_equipe = p_nu_equipe;

  if(v_sg_tipo_indicador is null) then
    RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | IQRD(Reducao de defeitos) NAO FOI CONFIGURADO PARA O GRUPO.', 
      p_nu_equipe, v_co_equipe, v_no_tipo_grupo;
    return v_vr_calculo_indicador;  
  end if;

  --
  -- Fator = (∑DPanterior + ∑DPatual) / (∑DP Corrigidosatual + ∑ DPanterior)
  --

  --
  -- Somatório da quantidade de Defeitos que constam abertos
  --
  v_sql := '
    select
      count(distinct s.co_solicitacao)
    from
      gct.gcttb266_amsta_slctco_equipe se
      inner join gct.gcttb264_amsta_equipe e on (
        e.nu_ajuste = se.nu_ajuste
        and e.nu_contrato = se.nu_contrato
        and e.nu_equipe = se.nu_equipe
      )
      inner join gct.gcttb265_amsta_solicitacao s on (
        s.nu_ajuste = se.nu_ajuste
        and s.nu_contrato = se.nu_contrato
        and s.nu_equipe = se.nu_equipe
        and se.nu_solicitacao = s.nu_solicitacao
      )
      inner join gct.gcttb192_servico_contratado se1 on (
        s.nu_situacao_solicitacao = se1.nu_situacao_atendimento
        and se1.nu_contrato = e.nu_contrato
        and se1.nu_tipo_grupo = e.nu_tipo_grupo
        and se1.nu_tipo_indicador = $1
      )      
    where
      se.nu_ajuste = $2
      and se.nu_equipe = $3
      and s.dh_prevista between $4 and $5
      and se.ic_solicitacao_compoe_fns = $6
      and se.co_falha_solicitacao = $7';

  -- Somatório da quantidade de Defeitos que constam abertos (Periodo Anterior)
  execute v_sql 
    using v_nu_tipo_indicador, p_nu_ajuste, p_nu_equipe, v_dt_inicio_perido_anterior, v_dt_final_perido_anterior, 'S', 'NF' 
     into v_qt_itens_estoque_anterior;   

  -- Somatório da quantidade de Defeitos que constam abertos (Periodo Atual)
  execute v_sql 
    using v_nu_tipo_indicador, p_nu_ajuste, p_nu_equipe, v_dt_inicio_perido_anterior, v_dt_final_perido_anterior, 'S', 'NF' 
     into v_qt_itens_estoque;

  --
  -- Somatório da quantidade de Defeitos corrigidos/resolvidos no período
  --
  v_sql := '
    select
      count(distinct s.co_solicitacao)
    from
      gct.gcttb266_amsta_slctco_equipe se
      inner join gct.gcttb264_amsta_equipe e on (
        e.nu_ajuste = se.nu_ajuste
        and e.nu_contrato = se.nu_contrato
        and e.nu_equipe = se.nu_equipe
      )
      inner join gct.gcttb265_amsta_solicitacao s on (
        s.nu_ajuste = se.nu_ajuste
        and s.nu_contrato = se.nu_contrato
        and s.nu_equipe = se.nu_equipe
        and se.nu_solicitacao = s.nu_solicitacao
      )
      inner join gct.gcttb191_servico_entregue se1 on (
        s.nu_situacao_solicitacao = se1.nu_situacao_atendimento
        and se1.nu_contrato = e.nu_contrato
        and se1.nu_tipo_grupo = e.nu_tipo_grupo
        and se1.nu_tipo_indicador = $1
      )      
    where
      se.nu_ajuste = $2
      and se.nu_equipe = $3
      and s.dh_prevista between $4 and $5
      and se.ic_solicitacao_compoe_fns = $6
      and se.co_falha_solicitacao = $7';

  -- Somatório da quantidade de Defeitos corrigidos/resolvidos no período anterior
  execute v_sql 
    using v_nu_tipo_indicador, p_nu_ajuste, p_nu_equipe, v_dt_inicio_perido_anterior, v_dt_final_perido_anterior, 'S', 'NF' 
     into v_qt_itens_entregues_anterior;   

  -- Somatório da quantidade de Defeitos corrigidos/resolvidos no período
  execute v_sql 
    using v_nu_tipo_indicador, p_nu_ajuste, p_nu_equipe, v_dt_inicio_perido_anterior, v_dt_final_perido_anterior, 'S', 'NF' 
     into v_qt_itens_entregues;

  RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | IQRD(Reducao de defeitos) | PERIODO ANTERIOR: % A %', 
    p_nu_equipe, v_co_equipe, v_no_tipo_grupo, v_dt_inicio_perido_anterior, v_dt_final_perido_anterior;

  RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | IQRD(Reducao de defeitos) | PERIODO: % a %', 
    p_nu_equipe, v_co_equipe, v_no_tipo_grupo, v_dt_inicio_indicador, v_dt_final_indicador;

  RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | IQRD(Reducao de defeitos) | ESTOQUE ANTERIOR(A): % | ESTOQUE(B): %', 
    p_nu_equipe, v_co_equipe, v_no_tipo_grupo, v_qt_itens_estoque_anterior, v_qt_itens_estoque;        

  RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | IQRD(Reducao de defeitos) | QT. ENTREGUES ANTERIOR(C): % | QT. ENTREGUES(D): %', 
    p_nu_equipe, v_co_equipe, v_no_tipo_grupo, v_qt_itens_entregues_anterior, v_qt_itens_entregues;        

  v_vr_calculo_indicador := 1::numeric;

  if v_nu_tipo_indicador is not null then

    if v_qt_itens_entregues_anterior + v_qt_itens_entregues_anterior <> 0 then
      v_vr_calculo_indicador := (v_qt_itens_entregues_anterior + v_qt_itens_entregues) / (v_qt_itens_estoque_anterior + v_qt_itens_estoque);
    end if;

    RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | IQRD(Reducao de defeitos) | VALOR INDICADOR (A + B)/(C + D): (% + %) / (% + %) = %', 
      p_nu_equipe, v_co_equipe, v_no_tipo_grupo, v_qt_itens_estoque_anterior, v_qt_itens_estoque, 
      v_qt_itens_entregues_anterior, v_qt_itens_entregues,
      v_vr_calculo_indicador;

    PERFORM gct.gctfn186_registrar_valor_indcdr_equipe_ajuste(p_nu_equipe, p_nu_fatura, p_nu_ajuste, v_nu_tipo_indicador, v_vr_calculo_indicador);
  end if;

  return v_vr_calculo_indicador;

END;
$function$;

alter function gct.gctfn181_indcdr_reducao_defeitos_ajuste(p_nu_equipe numeric, p_nu_fatura numeric, p_nu_ajuste numeric) owner to gct;

--------------------------------------------------------------------------------
-- -- gctfn182_indcdr_nota_codigo_ajuste
-- --------------------------------------------------------------------------------

-- drop function if exists gct.gctfn182_indcdr_nota_codigo_ajuste(p_nu_equipe numeric, p_nu_fatura numeric, p_nu_ajuste numeric);

CREATE OR REPLACE FUNCTION gct.gctfn182_indcdr_nota_codigo_ajuste(p_nu_equipe numeric, p_nu_fatura numeric, p_nu_ajuste numeric)
 RETURNS numeric
 LANGUAGE plpgsql
AS $function$

/**

RELEASE NOTES

RTC 23671403 - SIGCT - Indicadores do contrato especializado

*/

DECLARE

  v_nu_tipo_indicador numeric;
  v_nu_tipo_grupo numeric;
  v_sg_tipo_indicador varchar;
  v_no_tipo_indicador varchar;
  v_nu_contrato numeric;
  v_no_tipo_grupo varchar;
  v_co_equipe varchar;
  v_dt_inicio_indicador date;
  v_dt_final_indicador date;
  v_dt_inicio_perido_anterior date;
  v_dt_final_perido_anterior date;
  v_no_ciclo_apurado varchar;

  v_vr_calculo_indicador numeric;
  v_dt_referencia date;
  v_vr_soma_notas numeric;
  v_vr_soma_qt_atendimentos numeric;

  v_sql text;

  nota record;
				
BEGIN

  --
  -- DETERMINANDO O PERIODO A SER CALCULADO
  --
  select
    date_trunc('month', f.dt_final_fatura) + interval '1 month' into v_dt_referencia
  from
    gct.gcttb102_fatura f
  where
    nu_fatura = p_nu_fatura;

  v_dt_inicio_indicador = date_trunc('month', v_dt_referencia::date) - interval '1 month';
  v_dt_final_indicador := date_trunc('month', v_dt_referencia::date) - interval '1 day' + time '23:59:59';

  select
    ti.nu_tipo_indicador,
    trim(ti.sg_tipo_indicador),
    ti.no_tipo_indicador
  into 
    v_nu_tipo_indicador,
    v_sg_tipo_indicador,
    v_no_tipo_indicador
  from
    gct.gcttb010_contrato c
    inner join gct.gcttb264_amsta_equipe e on e.nu_contrato = c.nu_contrato
    inner join gct.gcttb033_grupo_contrato gc on (
      gc.nu_contrato = e.nu_contrato
      and gc.nu_tipo_grupo = e.nu_tipo_grupo
    )
    inner join gct.gcttb032_tipo_grupo tg on tg.nu_tipo_grupo = gc.nu_tipo_grupo
    inner join gct.gcttb115_grupo_indicador gi on (
      gi.nu_tipo_grupo = gc.nu_tipo_grupo
      and gi.nu_contrato = gc.nu_contrato
    )
    inner join gct.gcttb112_tipo_indicador ti on ( 
      ti.nu_tipo_indicador = gi.nu_tipo_indicador
      and ti.sg_tipo_indicador = 'IQNP'
    )
  where
    e.nu_ajuste = p_nu_ajuste
    and e.nu_equipe = p_nu_equipe;

  select 
    e.nu_contrato,
    e.co_equipe,
    tg.nu_tipo_grupo,
    tg.no_tipo_grupo
  into
    v_nu_contrato,
    v_co_equipe,
    v_nu_tipo_grupo,
    v_no_tipo_grupo 
  from
    gct.gcttb264_amsta_equipe e
    inner join gct.gcttb032_tipo_grupo tg on tg.nu_tipo_grupo = e.nu_tipo_grupo
  where
    e.nu_ajuste = p_nu_ajuste
    and e.nu_equipe = p_nu_equipe;

  if(v_sg_tipo_indicador is null) then
    RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | IQNP - Notas de Código NAO FOI CONFIGURADO PARA O GRUPO.', 
      p_nu_equipe, v_co_equipe, v_no_tipo_grupo;
    return v_vr_calculo_indicador;  
  end if;

  v_no_ciclo_apurado = to_char(v_dt_final_indicador, 'MM/YYYY');

  --
  -- 
  --
  -- Exemplo da média ponderada
  
  -- Exemplo:
  
  -- EQUIPE: A (atende mais de um)
  
  -- SIGCT: Nota 7 - 2 IBs atendidos
  -- SIPGC: Nota 8 - 3 IBs atendidos
  -- SIGID: Nota 6 - 5 IBs atendidos
  -- Média Ponderada = 
  -- (7 x 2) + (8 x 3) + (6 x 5) / 2 + 3 + 5 = 68 / 10 = 6,8
  
  -- EQUIPE: B (atende somente um)
  
  -- SIGID: Nota 6 - 5 IBs atendidos
  -- Média Ponderada = 
  -- (6 x 5) / 5 = 6,00

  --
  -- Somatório da quantidade de Defeitos que constam abertos
  --
  v_sql := '
    select
      s.no_sigla_sistema,
      coalesce(n.vr_nota_apurada, 10) vr_nota,
      count(distinct s.co_solicitacao) qt_solicitacoes
    from
      gct.gcttb266_amsta_slctco_equipe se
      inner join gct.gcttb264_amsta_equipe e on (
        e.nu_ajuste = se.nu_ajuste
        and e.nu_contrato = se.nu_contrato
        and e.nu_equipe = se.nu_equipe
      )
      inner join gct.gcttb265_amsta_solicitacao s on (
        s.nu_ajuste = se.nu_ajuste
        and s.nu_contrato = se.nu_contrato
        and s.nu_equipe = se.nu_equipe
        and se.nu_solicitacao = s.nu_solicitacao
      )
      inner join gct.gcttb192_servico_contratado se1 on (
        s.nu_situacao_solicitacao = se1.nu_situacao_atendimento
        and se1.nu_contrato = e.nu_contrato
        and se1.nu_tipo_grupo = e.nu_tipo_grupo
        and se1.nu_tipo_indicador = $1
      )
      left join gct.gcttb263_nota_codigo n on (
        n.no_sigla_sistema = s.no_sigla_sistema
        and n.no_ciclo_apurado = $2
      )
    where
      se.nu_ajuste = $3
      and se.nu_equipe = $4
      and s.dh_prevista between $5 and $6
      and se.ic_solicitacao_compoe_fns = $7
      and se.co_falha_solicitacao = $8
    group by
      s.no_sigla_sistema,
      coalesce(n.vr_nota_apurada, 10)';

  v_vr_soma_notas := 0;
  v_vr_soma_qt_atendimentos := 0;

  RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | IQNP - Notas de Código - PERIODO: % a %', 
    p_nu_equipe, v_co_equipe, v_no_tipo_grupo, v_dt_inicio_indicador, v_dt_final_indicador;

  for nota in execute v_sql using v_nu_tipo_indicador, v_no_ciclo_apurado, p_nu_ajuste, p_nu_equipe, v_dt_inicio_indicador, v_dt_final_indicador, 'S', 'NF'
  loop
    RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | IQNP - Notas de Código | SIGLA: % | NOTA: % | QT. ATENDIMENTOS: %', 
      p_nu_equipe, v_co_equipe, v_no_tipo_grupo, nota.no_sigla_sistema, nota.vr_nota, nota.qt_solicitacoes;
     v_vr_soma_notas = v_vr_soma_notas + (nota.vr_nota * nota.qt_solicitacoes);    
     v_vr_soma_qt_atendimentos = v_vr_soma_qt_atendimentos + (nota.qt_solicitacoes);    
  end loop;     

  v_vr_calculo_indicador := 1::numeric;

  RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | IQNP - Notas de Código | SOMA NOTAS: % | SOMA QT. ATENDIMENTOS: %', 
    p_nu_equipe, v_co_equipe, v_no_tipo_grupo, v_vr_soma_notas, v_vr_soma_qt_atendimentos;    

  if v_nu_tipo_indicador is not null then

    if v_vr_soma_qt_atendimentos <> 0 then
      v_vr_calculo_indicador := v_vr_soma_notas/v_vr_soma_qt_atendimentos;
    end if;

    RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | IQNP - Notas de Código | VALOR INDICADOR soma(A)/soma(B): (% / %) = %', 
      p_nu_equipe, v_co_equipe, v_no_tipo_grupo, v_vr_soma_notas, v_vr_soma_qt_atendimentos, 
      v_vr_calculo_indicador;

    PERFORM gct.gctfn186_registrar_valor_indcdr_equipe_ajuste(p_nu_equipe, p_nu_fatura, p_nu_ajuste, v_nu_tipo_indicador, v_vr_calculo_indicador);
  end if;

  return v_vr_calculo_indicador;

END;
$function$;

alter function gct.gctfn182_indcdr_nota_codigo_ajuste(p_nu_equipe numeric, p_nu_fatura numeric, p_nu_ajuste numeric) owner to gct;

--------------------------------------------------------------------------------
-- -- gctfn183_indcdr_qualidade_ajuste
-- --------------------------------------------------------------------------------

-- drop function if exists gct.gctfn183_indcdr_qualidade_ajuste(p_nu_equipe numeric, p_nu_fatura numeric, p_nu_ajuste numeric);

CREATE OR REPLACE FUNCTION gct.gctfn183_indcdr_qualidade_ajuste(p_nu_equipe numeric, p_nu_fatura numeric, p_nu_ajuste numeric)
 RETURNS numeric
 LANGUAGE plpgsql
AS $function$

/**

RELEASE NOTES

RTC 23671403 - SIGCT - Indicadores do contrato especializado

*/

DECLARE

  v_nu_tipo_indicador numeric;
  v_nu_tipo_grupo numeric;
  v_sg_tipo_indicador varchar;
  v_no_tipo_indicador varchar;
  v_nu_contrato numeric;
  v_no_tipo_grupo varchar;
  v_co_equipe varchar;

  v_vr_iqrd numeric;
  v_vr_iqnp numeric;
  v_vr_soma_indicadores numeric;
  v_vr_soma_pesos numeric;

  v_dt_referencia date;
  v_dt_inicio_indicador date;
  v_dt_final_indicador date;
  v_vr_calculo_indicador numeric;

  insumo record;

  v_sql text;
				
BEGIN

  --
  -- DETERMINANDO O PERIODO A SER CALCULADO
  --
  select
    date_trunc('month', f.dt_final_fatura) + interval '1 month' into v_dt_referencia
  from
    gct.gcttb102_fatura f
  where
    nu_fatura = p_nu_fatura;

  v_dt_inicio_indicador = date_trunc('month', v_dt_referencia::date) - interval '1 month';
  v_dt_final_indicador := date_trunc('month', v_dt_referencia::date) - interval '1 day' + time '23:59:59';

  select
    ti.nu_tipo_indicador,
    trim(ti.sg_tipo_indicador),
    ti.no_tipo_indicador
  into 
    v_nu_tipo_indicador,
    v_sg_tipo_indicador,
    v_no_tipo_indicador
  from
    gct.gcttb010_contrato c
    inner join gct.gcttb264_amsta_equipe e on e.nu_contrato = c.nu_contrato
    inner join gct.gcttb033_grupo_contrato gc on (
      gc.nu_contrato = e.nu_contrato
      and gc.nu_tipo_grupo = e.nu_tipo_grupo
    )
    inner join gct.gcttb032_tipo_grupo tg on tg.nu_tipo_grupo = gc.nu_tipo_grupo
    inner join gct.gcttb115_grupo_indicador gi on (
      gi.nu_tipo_grupo = gc.nu_tipo_grupo
      and gi.nu_contrato = gc.nu_contrato
    )
    inner join gct.gcttb112_tipo_indicador ti on ( 
      ti.nu_tipo_indicador = gi.nu_tipo_indicador
      and ti.sg_tipo_indicador = 'IQ'
    )
  where
    e.nu_ajuste = p_nu_ajuste
    and e.nu_equipe = p_nu_equipe;

  select 
    e.nu_contrato,
    e.co_equipe,
    tg.nu_tipo_grupo,
    tg.no_tipo_grupo
  into
    v_nu_contrato,
    v_co_equipe,
    v_nu_tipo_grupo,
    v_no_tipo_grupo 
  from
    gct.gcttb264_amsta_equipe e
    inner join gct.gcttb032_tipo_grupo tg on tg.nu_tipo_grupo = e.nu_tipo_grupo
  where
    e.nu_ajuste = p_nu_ajuste
    and e.nu_equipe = p_nu_equipe;

  if(v_sg_tipo_indicador is null) then
    RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | O INDICADOR IQ(Qualidade) NAO FOI CONFIGURADO PARA O GRUPO.', 
      p_nu_equipe, v_co_equipe, v_no_tipo_grupo;
    return v_vr_calculo_indicador;  
  end if;

  v_vr_calculo_indicador := 0;
  v_vr_soma_indicadores := 0;

  v_sql := '
    select
      ti.nu_tipo_indicador,
      ti.sg_tipo_indicador,
      vie.vr_peso_tipo_indicador,
      vie.vr_faixa_fns
    from
      gct.gcttb172_valor_indicador_equipe vie
      inner join gct.gcttb112_tipo_indicador ti on ti.nu_tipo_indicador = vie.nu_tipo_indicador
    where
      vie.nu_ajuste = $1
      and vie.nu_equipe = $2
      and ti.nu_tipo_indicador in (43,44)';

  v_vr_soma_pesos := 0;

  RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | IQ - Qualidade | PERIODO: % a %', 
    p_nu_equipe, v_co_equipe, v_no_tipo_grupo, v_dt_inicio_indicador, v_dt_final_indicador;

  for insumo in execute v_sql using p_nu_ajuste, p_nu_equipe, p_nu_fatura loop
    
    RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | IQ - Qualidade | INDICADOR: % % | PESO: % | FAIXA FNS: % | VALOR: %', 
      p_nu_equipe, v_co_equipe, v_no_tipo_grupo, insumo.nu_tipo_indicador, insumo.sg_tipo_indicador, 
      insumo.vr_peso_tipo_indicador, insumo.vr_faixa_fns, insumo.vr_peso_tipo_indicador * insumo.vr_faixa_fns;

    v_vr_soma_indicadores := v_vr_soma_indicadores + (insumo.vr_faixa_fns * insumo.vr_peso_tipo_indicador);
    v_vr_soma_pesos := v_vr_soma_pesos + insumo.vr_peso_tipo_indicador;

  end loop;

  if v_nu_tipo_indicador is not null then

    if v_vr_soma_pesos <> 0 then

      v_vr_calculo_indicador := v_vr_soma_indicadores / v_vr_soma_pesos;

      RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | IQ - Qualidade | SOMA DOS PESOS: %', 
        p_nu_equipe, v_co_equipe, v_no_tipo_grupo, v_vr_soma_pesos;

      RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | IQ - Qualidade | VALOR INDICADOR (A/B): % / % = %', 
        p_nu_equipe, v_co_equipe, v_no_tipo_grupo, v_vr_soma_indicadores, v_vr_soma_pesos, v_vr_calculo_indicador;
    end if;

    PERFORM gct.gctfn186_registrar_valor_indcdr_equipe_ajuste(p_nu_equipe, p_nu_fatura, p_nu_ajuste, v_nu_tipo_indicador, v_vr_calculo_indicador, 'N');
         
  end if;

  return v_vr_calculo_indicador;

END;
$function$;

alter function gct.gctfn183_indcdr_qualidade_ajuste(p_nu_equipe numeric, p_nu_fatura numeric, p_nu_ajuste numeric) owner to gct;

--------------------------------------------------------------------------------
-- -- gctfn184_indcdr_turnover_eqpe_ajuste
-- --------------------------------------------------------------------------------

-- drop function if exists gct.gctfn184_indcdr_turnover_eqpe_ajuste(p_nu_equipe numeric, p_nu_fatura numeric, p_nu_ajuste numeric);

CREATE OR REPLACE FUNCTION gct.gctfn184_indcdr_turnover_eqpe_ajuste(p_nu_equipe numeric, p_nu_fatura numeric, p_nu_ajuste numeric)
 RETURNS numeric
 LANGUAGE plpgsql
AS $function$

/**

RELEASE NOTES

RTC 23671403 - SIGCT - Indicadores do contrato especializado

*/

DECLARE

  v_nu_tipo_indicador numeric;
  v_nu_tipo_grupo numeric;
  v_sg_tipo_indicador varchar;
  v_no_tipo_indicador varchar;
  v_nu_contrato numeric;
  v_no_tipo_grupo varchar;
  v_co_equipe varchar;

  v_dt_referencia date;
  v_dt_inicio_indicador date;
  v_dt_final_indicador date;
  v_vr_calculo_indicador numeric;

  v_sql text;

BEGIN

  --
  -- DETERMINANDO O PERIODO A SER CALCULADO
  --
  select
    date_trunc('month', f.dt_final_fatura) + interval '1 month' into v_dt_referencia
  from
    gct.gcttb102_fatura f
  where
    nu_fatura = p_nu_fatura;

  v_dt_inicio_indicador = date_trunc('month', v_dt_referencia::date) - interval '1 month';
  v_dt_final_indicador := date_trunc('month', v_dt_referencia::date) - interval '1 day' + time '23:59:59'; 

  select
    ti.nu_tipo_indicador,
    trim(ti.sg_tipo_indicador),
    ti.no_tipo_indicador
  into 
    v_nu_tipo_indicador,
    v_sg_tipo_indicador,
    v_no_tipo_indicador
  from
    gct.gcttb010_contrato c
    inner join gct.gcttb264_amsta_equipe e on e.nu_contrato = c.nu_contrato
    inner join gct.gcttb033_grupo_contrato gc on (
      gc.nu_contrato = e.nu_contrato
      and gc.nu_tipo_grupo = e.nu_tipo_grupo
    )
    inner join gct.gcttb032_tipo_grupo tg on tg.nu_tipo_grupo = gc.nu_tipo_grupo
    inner join gct.gcttb115_grupo_indicador gi on (
      gi.nu_tipo_grupo = gc.nu_tipo_grupo
      and gi.nu_contrato = gc.nu_contrato
    )
    inner join gct.gcttb112_tipo_indicador ti on ( 
      ti.nu_tipo_indicador = gi.nu_tipo_indicador
      and ti.sg_tipo_indicador = 'IT'
    )
  where
    e.nu_ajuste = p_nu_ajuste
    and e.nu_equipe = p_nu_equipe;

  select 
    e.nu_contrato,
    e.co_equipe,
    tg.nu_tipo_grupo,
    tg.no_tipo_grupo
  into
    v_nu_contrato,
    v_co_equipe,
    v_nu_tipo_grupo,
    v_no_tipo_grupo 
  from
    gct.gcttb264_amsta_equipe e
    inner join gct.gcttb032_tipo_grupo tg on tg.nu_tipo_grupo = e.nu_tipo_grupo
  where
    e.nu_ajuste = p_nu_ajuste
    and e.nu_equipe = p_nu_equipe;

  if(v_sg_tipo_indicador is null) then
    RAISE NOTICE 'INDICADOR - EQUIPE: % | % GRUPO: % | O INDICADOR IT(Turnover) NAO FOI CONFIGURADO PARA O GRUPO.', 
      p_nu_equipe, v_co_equipe, v_no_tipo_grupo;
    return v_vr_calculo_indicador;  
  end if;

  --
  -- TURNOVER EH UM INDICADOR DA CONTRATADA, NAO VAMOS CALCULAR, SOMENTE RECUPERAR
  --
  RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | IT - Turnover | PERIODO: % a %', 
    p_nu_equipe, v_co_equipe, v_no_tipo_grupo, v_dt_inicio_indicador, v_dt_final_indicador;

  v_sql := '
    select
      vic.dt_inicio_indicador,
      vic.dt_final_indicador,
      vic.vr_calculo_indicador
    from
      gct.gcttb269_valor_indicador_contratada vic
      inner join gct.gcttb087_equipe e on e.nu_contrato = vic.nu_contrato
    where
      e.nu_equipe = $1
      and $2 between dt_inicio_indicador and coalesce(dt_final_indicador,$2)';

  execute v_sql 
    using p_nu_equipe, v_dt_final_indicador
     into v_dt_inicio_indicador, v_dt_final_indicador, v_vr_calculo_indicador;

  RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | IT - Turnover | PERIODO INDICADOR (TRIMESTRE): % A %', 
    p_nu_equipe, v_co_equipe, v_no_tipo_grupo, v_dt_inicio_indicador::date, v_dt_final_indicador::date;

  RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | IT - Turnover | VALOR INDICADOR CONTRATADA: %', 
    p_nu_equipe, v_co_equipe, v_no_tipo_grupo, v_vr_calculo_indicador;

  PERFORM gct.gctfn186_registrar_valor_indcdr_equipe_ajuste(p_nu_equipe, p_nu_fatura, p_nu_ajuste, v_nu_tipo_indicador, v_vr_calculo_indicador, 'N');

  return v_vr_calculo_indicador;

END;
$function$;

alter function gct.gctfn184_indcdr_turnover_eqpe_ajuste(p_nu_equipe numeric, p_nu_fatura numeric, p_nu_ajuste numeric) owner to gct;

--------------------------------------------------------------------------------
-- -- gctfn185_calcular_fator_nivel_servico_ajuste 
-- --------------------------------------------------------------------------------

-- drop function if exists gct.gctfn185_calcular_fator_nivel_servico_ajuste(p_nu_equipe numeric, p_nu_fatura numeric, p_nu_ajuste numeric);

CREATE OR REPLACE FUNCTION gct.gctfn185_calcular_fator_nivel_servico_ajuste(p_nu_equipe numeric, p_nu_fatura numeric, p_nu_ajuste numeric)
 RETURNS numeric
 LANGUAGE plpgsql
AS $function$

/**

RELEASE NOTES

RTC 23671403 - SIGCT - Indicadores do contrato especializado

*/

DECLARE

  v_nu_tipo_indicador numeric;
  v_nu_tipo_grupo numeric;
  v_sg_tipo_indicador varchar;
  v_no_tipo_indicador varchar;
  v_nu_contrato numeric;
  v_no_tipo_grupo varchar;
  v_co_equipe varchar;

  v_vr_faixa_fns numeric;
  v_qt_faixa_fns numeric;

  v_dt_referencia date;
  v_dt_inicio_indicador date;
  v_dt_final_indicador date;
  v_vr_calculo_indicador numeric;

  v_sql text;

  insumo record;
				
BEGIN

  --
  -- DETERMINANDO O PERIODO A SER CALCULADO
  --
  select
    date_trunc('month', f.dt_final_fatura) + interval '1 month' into v_dt_referencia
  from
    gct.gcttb102_fatura f
  where
    nu_fatura = p_nu_fatura;

  v_dt_inicio_indicador = date_trunc('month', v_dt_referencia::date) - interval '1 month';
  v_dt_final_indicador := date_trunc('month', v_dt_referencia::date) - interval '1 day' + time '23:59:59'; 

  select
    ti.nu_tipo_indicador,
    trim(ti.sg_tipo_indicador),
    ti.no_tipo_indicador
  into 
    v_nu_tipo_indicador,
    v_sg_tipo_indicador,
    v_no_tipo_indicador
  from
    gct.gcttb010_contrato c
    inner join gct.gcttb264_amsta_equipe e on e.nu_contrato = c.nu_contrato
    inner join gct.gcttb033_grupo_contrato gc on (
      gc.nu_contrato = e.nu_contrato
      and gc.nu_tipo_grupo = e.nu_tipo_grupo
    )
    inner join gct.gcttb032_tipo_grupo tg on tg.nu_tipo_grupo = gc.nu_tipo_grupo
    inner join gct.gcttb115_grupo_indicador gi on (
      gi.nu_tipo_grupo = gc.nu_tipo_grupo
      and gi.nu_contrato = gc.nu_contrato
    )
    inner join gct.gcttb112_tipo_indicador ti on ( 
      ti.nu_tipo_indicador = gi.nu_tipo_indicador
      and ti.sg_tipo_indicador = 'FNS'
    )
  where
    e.nu_ajuste = p_nu_ajuste
    and e.nu_equipe = p_nu_equipe;

  select 
    e.nu_contrato,
    e.co_equipe,
    tg.nu_tipo_grupo,
    tg.no_tipo_grupo
  into
    v_nu_contrato,
    v_co_equipe,
    v_nu_tipo_grupo,
    v_no_tipo_grupo 
  from
    gct.gcttb264_amsta_equipe e
    inner join gct.gcttb032_tipo_grupo tg on tg.nu_tipo_grupo = e.nu_tipo_grupo
  where
    e.nu_ajuste = p_nu_ajuste
    and e.nu_equipe = p_nu_equipe;

  if(v_sg_tipo_indicador is null) then
    RAISE NOTICE 'INDICADOR - EQUIPE: % | % GRUPO: % | INDICADOR FNS - Fator de Nivel de Servico - NAO FOI CONFIGURADO PARA O GRUPO.', 
      p_nu_equipe, v_co_equipe, v_no_tipo_grupo;
    return v_vr_calculo_indicador;  
  end if;

  v_vr_faixa_fns := 0;
  v_qt_faixa_fns := 0;

  v_sql := '
    select
      ti.nu_tipo_indicador,
      ti.sg_tipo_indicador,
      ti.no_tipo_indicador,
      vie.vr_faixa_fns
    from
      gct.gcttb172_valor_indicador_equipe vie
      inner join gct.gcttb087_equipe e on e.nu_equipe = vie.nu_equipe
      inner join gct.gcttb115_grupo_indicador gi on (
        gi.nu_contrato = e.nu_contrato
        and gi.nu_tipo_grupo = e.nu_tipo_grupo
        and gi.nu_tipo_indicador = vie.nu_tipo_indicador
        and gi.ic_aplica_indicador = $1
        and gi.ic_compoe_fns = $2
      )
      inner join gct.gcttb112_tipo_indicador ti on ti.nu_tipo_indicador = vie.nu_tipo_indicador
    where
      vie.nu_ajuste = $3
      and vie.nu_equipe = $4
      and vie.vr_faixa_fns is not null';

  RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | FNS - Fator de Nivel de Servico | PERIODO: % a %', 
    p_nu_equipe, v_co_equipe, v_no_tipo_grupo, v_dt_inicio_indicador, v_dt_final_indicador;

  for insumo in execute v_sql using 'N', 'S', p_nu_ajuste, p_nu_equipe loop
    RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | FNS - Fator de Nivel de Servico | INDICADOR: % % | FAIXA FNS: %', 
      p_nu_equipe, v_co_equipe, v_no_tipo_grupo, insumo.nu_tipo_indicador, trim(insumo.sg_tipo_indicador), insumo.vr_faixa_fns;

    v_vr_faixa_fns := v_vr_faixa_fns + insumo.vr_faixa_fns;
    v_qt_faixa_fns := v_qt_faixa_fns + 1;
  end loop;

  if v_nu_tipo_indicador is not null then
    
    if v_qt_faixa_fns <> 0 then 
      v_vr_calculo_indicador := v_vr_faixa_fns / v_qt_faixa_fns;
    end if;

    RAISE NOTICE 'INDICADOR - EQUIPE: % % | GRUPO: % | FNS - Fator de Nivel de Servico | VALOR INDICADOR (%/%): %', 
      p_nu_equipe, v_co_equipe, v_no_tipo_grupo, v_vr_faixa_fns, v_qt_faixa_fns, v_vr_calculo_indicador;

  end if;

  PERFORM gct.gctfn186_registrar_valor_indcdr_equipe_ajuste(p_nu_equipe, p_nu_fatura, p_nu_ajuste, v_nu_tipo_indicador, v_vr_calculo_indicador, 'N');

  return v_vr_calculo_indicador;

END;
$function$;

alter function gct.gctfn185_calcular_fator_nivel_servico_ajuste(p_nu_equipe numeric, p_nu_fatura numeric, p_nu_ajuste numeric) owner to gct;


--
-- FIM
--

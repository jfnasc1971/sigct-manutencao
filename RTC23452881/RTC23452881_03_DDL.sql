--
-- INICIO
--

--------------------------------------------------------------------------------
-- -- gctfn303_calcular_indicador
-- --------------------------------------------------------------------------------

-- drop function if exists gct.gctfn303_calcular_indicador(dtbaseindicador date, p_nu_contrato numeric, p_nu_equipe numeric);

CREATE OR REPLACE FUNCTION gct.gctfn303_calcular_indicador(dtbaseindicador date, p_nu_contrato numeric, p_nu_equipe numeric DEFAULT NULL::numeric)
 RETURNS void
 LANGUAGE plpgsql
AS $function$

/**

RELEASE NOTES

RTC 23452881 - SIGCT - Melhoria Calculo dos Indicadores de Qualidade
RTC 19118958 - SIGCT - Contratos da Qualidade_(KEEGO/MONTREAL/WIPRO) Ativação dos Indicadores
BR202002208 - SIGCT - Adequação de Indicador no Contrato da Qualidade - TESTES
RTC 15828070 - Erro de JAVA ao tentar acessar equipe Agil - contrato TTY

*/

DECLARE
  
  equipe  RECORD;
  dtBaseProcessamento date;
        
BEGIN

  dtBaseProcessamento := dtbaseIndicador - '1 day'::interval;

  FOR equipe IN
    select 
      c.nu_contrato
      ,e.nu_equipe
      ,e.dt_inicio_atendimento
      ,e.dt_final_atendimento
      ,tg.nu_tipo_grupo
      ,gc.ic_tipo_atendimento
      ,gc.dt_considerar_fns
      ,gc.ic_calculo_pro_rata
      ,ai.nu_area_interna
      ,ai.nu_mtrca_responsavel
      ,ai.no_sigla_area
      ,ai.co_sitio
      ,gc.ic_dias_calculo_pagamento
      ,gc.ic_permite_servico_extra
      ,gc.ic_permite_registro_ausencia
      ,gc.ic_calculo_pro_rata
      ,f.dt_inicio_fatura
      ,f.dt_final_fatura
      ,f.nu_fatura
    from 
    gct.gcttb010_contrato c
      inner join gct.gcttb033_grupo_contrato gc on (gc.nu_contrato = c.nu_contrato)
      inner join gct.gcttb032_tipo_grupo tg on (tg.nu_tipo_grupo = gc.nu_tipo_grupo)
      inner join gct.gcttb103_faturamento fat on  (fat.nu_faturamento = c.nu_faturamento)
      inner join gct.gcttb102_fatura f on  (fat.nu_faturamento = f.nu_faturamento)
      inner join gct.gcttb175_amostra_equipe e on (e.nu_contrato = gc.nu_contrato and e.nu_tipo_grupo = gc.nu_tipo_grupo and f.nu_fatura = e.nu_fatura_amostra)
      inner join gct.gcttb001_area_interna ai on (ai.nu_area_interna = e.nu_area_interna)
    where 
    c.ic_tipo_contratacao = 'E'
      and e.nu_situacao_equipe <> 3
      and ai.co_sitio = f.co_sitio
      and f.dt_final_fatura = dtBaseProcessamento
      and ( p_nu_contrato is null or c.nu_contrato = p_nu_contrato )
  and ( p_nu_equipe is null or e.nu_equipe = p_nu_equipe ) 
      --Para não gerar termos pendentes (valor zero) depois que a equipe for concluída.
      and ( 
        (e.dt_final_atendimento is null and date(e.dt_inicio_atendimento) <= f.dt_final_fatura)  
        or
        (date(e.dt_inicio_atendimento) <= f.dt_final_fatura and date(e.dt_final_atendimento) <= f.dt_final_fatura and date(e.dt_final_atendimento) >= f.dt_inicio_fatura)
        or 
        (date(e.dt_inicio_atendimento) <= f.dt_final_fatura and date(e.dt_final_atendimento) >= f.dt_inicio_fatura)
        )
      ORDER BY c.nu_contrato, e.nu_equipe
  LOOP
  
  RAISE NOTICE 'CALCULO DE INDICADORES - DT. REFERENCIA: % | EQUIPE: %', 
    dtBaseProcessamento, equipe.nu_equipe;

  -- remove calculos feitos anteriormente, se hover 
  RAISE NOTICE 'CALCULO DE INDICADORES - DT. REFERENCIA: % | EQUIPE: % REMOVENDO INDICADORES ANTERIORES', 
    dtBaseProcessamento, equipe.nu_equipe;
  delete from gct.gcttb172_valor_indicador_equipe
    where nu_equipe = equipe.nu_equipe
      and nu_tipo_grupo = equipe.nu_tipo_grupo
      and nu_fatura = equipe.nu_fatura;

    if (dtBaseProcessamento >= equipe.dt_considerar_fns ) then

      perform gct.gctfn306_indicador_qualidade(equipe.nu_equipe,equipe.nu_tipo_grupo,equipe.nu_fatura);
      perform gct.gctfn307_indicador_prazo(equipe.nu_equipe,equipe.nu_tipo_grupo,equipe.nu_fatura);
      perform gct.gctfn308_indicador_estoque(equipe.nu_equipe,equipe.nu_tipo_grupo,equipe.nu_fatura);
      perform gct.gctfn309_indicador_valor(equipe.nu_equipe,equipe.nu_tipo_grupo,equipe.nu_fatura);
      perform gct.gctfn310_indicador_produto(equipe.nu_equipe,equipe.nu_tipo_grupo,equipe.nu_fatura);
      perform gct.gctfn311_indicador_produtividade(equipe.nu_equipe,equipe.nu_tipo_grupo,equipe.nu_fatura);
      perform gct.gctfn312_indicador_desenvolvimento(equipe.nu_equipe,equipe.nu_tipo_grupo,equipe.nu_fatura);

      perform gct.gctfn355_indicador_estoque_servico(equipe.nu_equipe,equipe.nu_tipo_grupo,equipe.nu_fatura);
      perform gct.gctfn356_indicador_prazo_servico(equipe.nu_equipe,equipe.nu_tipo_grupo,equipe.nu_fatura);
      perform gct.gctfn357_indicador_qualidade_servico(equipe.nu_equipe,equipe.nu_tipo_grupo,equipe.nu_fatura);

      perform gct.gctfn204_indicador_qualidade(equipe.nu_equipe,equipe.nu_tipo_grupo,equipe.nu_fatura);
      perform gct.gctfn205_indicador_prazo(equipe.nu_equipe,equipe.nu_tipo_grupo,equipe.nu_fatura);
      perform gct.gctfn206_indicador_planejamento(equipe.nu_equipe,equipe.nu_tipo_grupo,equipe.nu_fatura);
      perform gct.gctfn207_indicador_produtividade(equipe.nu_equipe,equipe.nu_tipo_grupo,equipe.nu_fatura);
      perform gct.gctfn208_indicador_turnover(equipe.nu_equipe,equipe.nu_tipo_grupo,equipe.nu_fatura);
      perform gct.gctfn209_calcular_fator_nivel_servico(equipe.nu_equipe,equipe.nu_tipo_grupo,equipe.nu_fatura);

      --
      -- UNISYS
      --
      perform gct.gctfn377_indicador_capacitacao(equipe.nu_equipe,equipe.nu_tipo_grupo,equipe.nu_fatura);
      perform gct.gctfn378_indicador_assistido(equipe.nu_equipe,equipe.nu_tipo_grupo,equipe.nu_fatura);
      perform gct.gctfn379_indicador_disponibilidade_periodo(equipe.nu_equipe,equipe.nu_tipo_grupo,equipe.nu_fatura);
      perform gct.gctfn395_indicador_valor_agregado_sprint(equipe.nu_equipe,equipe.nu_tipo_grupo,equipe.nu_fatura);
      perform gct.gctfn396_indicador_estoque_sprint(equipe.nu_equipe,equipe.nu_tipo_grupo,equipe.nu_fatura);
      perform gct.gctfn398_indicador_desenvolvimento_assistido(equipe.nu_equipe,equipe.nu_tipo_grupo,equipe.nu_fatura);

      perform gct.gctfn313_indicador_desempenho(equipe.nu_equipe,equipe.nu_tipo_grupo,equipe.nu_fatura);

    else

      RAISE NOTICE 'CALCULO DE INDICADORES - O CALCULO DE INDICADORES PARA ESSE GRUPO CONTRATO OCORRERA APENAS APARTIR DE: %',
        equipe.dt_considerar_fns;

    end if;  

  RAISE NOTICE '';

  END LOOP;
END;
$function$;

alter function gct.gctfn303_calcular_indicador(dtbaseindicador date, p_nu_contrato numeric, p_nu_equipe numeric) owner to gct;

--------------------------------------------------------------------------------
-- -- gctfn334_calcular_indicador_ajuste
-- --------------------------------------------------------------------------------

-- drop function if exists gct.gctfn334_calcular_indicador_ajuste(p_nu_ajuste numeric, p_nu_equipe numeric);

CREATE OR REPLACE FUNCTION gct.gctfn334_calcular_indicador_ajuste(p_nu_ajuste numeric, p_nu_equipe numeric)
 RETURNS void
 LANGUAGE plpgsql
AS $function$

/*

RELEASE NOTES

RTC 23452881 - SIGCT - Melhoria no Cálculo dos Indicadores de Qualidade
RTC 17882046 - SIGCT - Erro no processamento de amostra para calculo de Indicadores (GECEQ)
RTC 15276626 - SIGCT - Contrato 9520/2018 - FÓTON - Exclusão e Investigação do TMAE0284 da OS BRE201800024

BR202002208 - SIGCT - Adequação de Indicador no Contrato da Qualidade - TESTES

RTC 14901634 - SIGCT - termos negativos 2812/2018 Stefanini

*/

DECLARE
      
  equipe RECORD;

BEGIN
  
  raise notice 'CALCULO INDICADOR - AJUSTE: % EQUIPE: % - INICIANDO...', p_nu_ajuste, p_nu_equipe;

  raise notice 'CALCULO INDICADOR - AJUSTE: % EQUIPE: % - REMOVENDO INDICADORES...', p_nu_ajuste, p_nu_equipe;
  delete from gct.gcttb172_valor_indicador_equipe 
   where nu_ajuste = p_nu_ajuste 
     and nu_equipe = p_nu_equipe;

  for equipe in (
    select
      f.dt_final_fatura,
      e.nu_equipe,
      gc.nu_tipo_grupo,
      gc.dt_considerar_fns,
      te.nu_fatura_paga
    from
      gct.gcttb010_contrato c
      inner join gct.gcttb033_grupo_contrato gc on (gc.nu_contrato = c.nu_contrato)
      inner join gct.gcttb032_tipo_grupo tg on (tg.nu_tipo_grupo = gc.nu_tipo_grupo)
      inner join gct.gcttb175_amostra_equipe a on (
        a.nu_contrato = gc.nu_contrato
        and a.nu_tipo_grupo = gc.nu_tipo_grupo
      )
      inner join gct.gcttb001_area_interna ai on (ai.nu_area_interna = a.nu_area_interna)
      inner join gct.gcttb087_equipe e on e.nu_contrato = c.nu_contrato
      inner join gct.gcttb170_termo_equipe te on (
        te.nu_equipe = e.nu_equipe
        and te.nu_ajuste = a.nu_ajuste
        and te.nu_equipe = a.nu_equipe
      )  
      inner join gct.gcttb102_fatura f on f.nu_fatura = te.nu_fatura_paga
    where
      a.nu_ajuste = p_nu_ajuste
      and e.nu_equipe = p_nu_equipe
      and te.nu_situacao_termo = 2
    order by
      f.dt_final_fatura
  )
  loop

    if (equipe.dt_final_fatura >= equipe.dt_considerar_fns ) then

      raise notice 'INDICADOR - FATURA: % | DT. FINAL FATURA: % | DT. CONSIDERA FNS: %', 
        equipe.nu_fatura_paga, equipe.dt_final_fatura, equipe.dt_considerar_fns;

      PERFORM gct.gctfn335_indicador_qualidade_ajuste(equipe.nu_equipe, equipe.nu_tipo_grupo, equipe.nu_fatura_paga, p_nu_ajuste);
      PERFORM gct.gctfn336_indicador_prazo_ajuste(equipe.nu_equipe, equipe.nu_tipo_grupo, equipe.nu_fatura_paga, p_nu_ajuste);
      PERFORM gct.gctfn337_indicador_estoque_ajuste(equipe.nu_equipe, equipe.nu_tipo_grupo, equipe.nu_fatura_paga, p_nu_ajuste);
      PERFORM gct.gctfn338_indicador_valor_ajuste(equipe.nu_equipe, equipe.nu_tipo_grupo, equipe.nu_fatura_paga, p_nu_ajuste);
      PERFORM gct.gctfn339_indicador_produto_ajuste(equipe.nu_equipe, equipe.nu_tipo_grupo, equipe.nu_fatura_paga, p_nu_ajuste);
      PERFORM gct.gctfn340_indicador_produtividade_ajuste(equipe.nu_equipe, equipe.nu_tipo_grupo, equipe.nu_fatura_paga, p_nu_ajuste);
      PERFORM gct.gctfn341_indicador_desenvolvimento_ajuste(equipe.nu_equipe, equipe.nu_tipo_grupo, equipe.nu_fatura_paga, p_nu_ajuste);
      
      PERFORM gct.gctfn360_indicador_estoque_servico_ajuste(equipe.nu_equipe, equipe.nu_tipo_grupo, equipe.nu_fatura_paga, p_nu_ajuste);
      PERFORM gct.gctfn361_indicador_prazo_servico_ajuste(equipe.nu_equipe, equipe.nu_tipo_grupo, equipe.nu_fatura_paga, p_nu_ajuste);
      PERFORM gct.gctfn362_indicador_qualidade_servico_ajuste(equipe.nu_equipe, equipe.nu_tipo_grupo, equipe.nu_fatura_paga, p_nu_ajuste);
      
      PERFORM gct.gctfn214_indicador_qualidade_ajuste(equipe.nu_equipe, equipe.nu_tipo_grupo, equipe.nu_fatura_paga, p_nu_ajuste);
      PERFORM gct.gctfn215_indicador_prazo_ajuste(equipe.nu_equipe, equipe.nu_tipo_grupo, equipe.nu_fatura_paga, p_nu_ajuste);
      PERFORM gct.gctfn216_indicador_planejamento_ajuste(equipe.nu_equipe, equipe.nu_tipo_grupo, equipe.nu_fatura_paga, p_nu_ajuste);
      PERFORM gct.gctfn217_indicador_produtividade_ajuste(equipe.nu_equipe, equipe.nu_tipo_grupo, equipe.nu_fatura_paga, p_nu_ajuste);
      PERFORM gct.gctfn218_indicador_turnover_ajuste(equipe.nu_equipe, equipe.nu_tipo_grupo, equipe.nu_fatura_paga, p_nu_ajuste);
      PERFORM gct.gctfn219_calcular_fator_nivel_servico_ajuste(equipe.nu_equipe, equipe.nu_tipo_grupo, equipe.nu_fatura_paga, p_nu_ajuste);

      PERFORM gct.gctfn342_indicador_desempenho_ajuste(equipe.nu_equipe, equipe.nu_tipo_grupo, equipe.nu_fatura_paga, p_nu_ajuste);

      PERFORM gct.gctfn220_calcular_bonus_ajuste(equipe.nu_equipe, equipe.nu_tipo_grupo, equipe.nu_fatura_paga, p_nu_ajuste);
      PERFORM gct.gctfn221_calcular_descontos_ajuste(equipe.nu_equipe, equipe.nu_tipo_grupo, equipe.nu_fatura_paga, p_nu_ajuste);

      raise notice '';

    else
      
      raise notice 'INDICADOR - FATURA: % | DT. FINAL FATURA: % | DT. CONSIDERA FNS: % | NAO HABILITADO PARA CALCULO', 
        equipe.nu_fatura_paga, equipe.dt_final_fatura, equipe.dt_considerar_fns;

    end if;  

  end loop;

  raise notice 'CALCULO INDICADOR - AJUSTE: % - CONCLUIDO.', p_nu_ajuste;

END;
$function$;

alter function gct.gctfn334_calcular_indicador_ajuste(p_nu_ajuste numeric, p_nu_equipe numeric) owner to gct;

--------------------------------------------------------------------------------
-- -- gctfn204_indicador_qualidade
-- --------------------------------------------------------------------------------

-- drop function if exists gct.gctfn204_indicador_qualidade(v_nu_equipe numeric, v_nu_tipo_grupo numeric, v_nu_fatura numeric);

CREATE OR REPLACE FUNCTION gct.gctfn204_indicador_qualidade(v_nu_equipe numeric, v_nu_tipo_grupo numeric, v_nu_fatura numeric)
 RETURNS void
 LANGUAGE plpgsql
AS $function$

/*

RELEASE NOTES

RTC 23452881 - SIGCT - Melhoria Calculo dos Indicadores de Qualidade

*/
    
DECLARE

  v_sg_indicador character varying(6);

  v_vr_indicador numeric;
  v_nu_tipo_indicador numeric;
  v_nu_contrato numeric;
  v_no_tipo_indicador character varying(100);
  v_sg_tipo_indicador character(6);
  v_dt_inicio_fatura date;
  v_dt_final_fatura date;

	--
	-- VARIAVEIS DOS INSUMOS
	--
	  qtTotalDevolvido  numeric;
	  qtTotalEntregue  numeric;
    
BEGIN

  v_sg_indicador := 'IQU';

  --
  -- PERIODO DE FATURAMENTO
  --    
  select
    dt_inicio_fatura,
    dt_final_fatura 
  into 
    v_dt_inicio_fatura,
    v_dt_final_fatura
  from
    gct.gcttb102_fatura
  where
    nu_fatura = v_nu_fatura;                

  --
  -- CONFIGURACAO DO INDICADOR
  --
  select
    ti.nu_tipo_indicador,
    ti.no_tipo_indicador,
    ti.sg_tipo_indicador,
    gi.nu_contrato 
  into 
    v_nu_tipo_indicador,
    v_no_tipo_indicador,
    v_sg_tipo_indicador,
    v_nu_contrato
  from
    gct.gcttb010_contrato c
    inner join gct.gcttb033_grupo_contrato gc on (c.nu_contrato = gc.nu_contrato)
    inner join gct.gcttb115_grupo_indicador gi on(
      gi.nu_tipo_grupo = gc.nu_tipo_grupo
      and gi.nu_contrato = gc.nu_contrato
    )
    inner join gct.gcttb112_tipo_indicador ti on (ti.nu_tipo_indicador = gi.nu_tipo_indicador)
    inner join gct.gcttb175_amostra_equipe e on (e.nu_contrato = c.nu_contrato)
  where
    sg_tipo_indicador = v_sg_indicador
    and e.nu_fatura_amostra = v_nu_fatura
    and e.nu_equipe = v_nu_equipe
    and gc.nu_tipo_grupo = v_nu_tipo_grupo;
    
    if (v_sg_tipo_indicador is null) then
      
      RAISE NOTICE 'INDICADOR % - EQUIPE: % GRUPO: % INDICADOR % NAO CONFIGURADO.', 
        v_sg_indicador, v_nu_equipe, v_nu_tipo_grupo, v_sg_indicador;
    
    else
    
      RAISE NOTICE 'INDICADOR % - EQUIPE: % GRUPO: % INDICADOR: % PERIODO FATURAMENTO: % a % FATURA: %', 
        v_sg_indicador, v_nu_equipe, v_nu_tipo_grupo, v_nu_tipo_indicador, v_dt_inicio_fatura, v_dt_final_fatura, v_nu_fatura;
        
      --
      -- OBTER INSUMOS DO CALCULO
      --

		select
		  count(distinct s.co_solicitacao) into qtTotalDevolvido
		from
		  gct.gcttb177_amostra_solicitacao_equipe se
		  inner join gct.gcttb175_amostra_equipe e on (
			e.nu_equipe = se.nu_equipe
			and e.nu_fatura_amostra = se.nu_fatura_amostra
		  )
		  inner join gct.gcttb178_amostra_solicitacao s on (
			se.nu_solicitacao = s.nu_solicitacao
			and s.nu_fatura_amostra = se.nu_fatura_amostra
		  )
		  inner join gct.gcttb102_fatura f on f.nu_fatura = se.nu_fatura_amostra
		  inner join gct.gcttb181_amostra_devolucao_solicitacao ds on (
			ds.nu_solicitacao = se.nu_solicitacao
			and ds.nu_fatura_amostra = se.nu_fatura_amostra 
		  )
		where
		  se.nu_equipe = v_nu_equipe
		  and se.nu_fatura_amostra = v_nu_fatura
		  and s.dh_efetiva::date between f.dt_inicio_fatura and f.dt_final_fatura
		  and se.ic_solicitacao_compoe_fns = 'S'
		  and coalesce(se.co_falha_solicitacao, 'NF') = 'NF'
		  and exists (
			select null
			  from gct.gcttb194_servico_devolvido se1
			 where se1.nu_tipo_grupo = e.nu_tipo_grupo
			   and se1.nu_contrato = e.nu_contrato
			   and se1.nu_situacao_atendimento = s.nu_situacao_solicitacao
			   and se1.nu_tipo_indicador = v_nu_tipo_indicador
		  );


	  RAISE NOTICE 'INDICADOR IQU - QUANTIDADE DE SERVIÇOS DEVOLVIDOS: %', qtTotalDevolvido;
	  
	  
	  
		 select
			  count(distinct s.co_solicitacao) into qtTotalEntregue
			from
			  gct.gcttb177_amostra_solicitacao_equipe se
			  inner join gct.gcttb175_amostra_equipe e on (
				e.nu_equipe = se.nu_equipe
				and e.nu_fatura_amostra = se.nu_fatura_amostra
			  )
			  inner join gct.gcttb178_amostra_solicitacao s on (
				se.nu_solicitacao = s.nu_solicitacao
				and s.nu_fatura_amostra = se.nu_fatura_amostra
			  )
			  inner join gct.gcttb102_fatura f on f.nu_fatura = se.nu_fatura_amostra
			  inner join gct.gcttb191_servico_entregue se1 on (
				se1.nu_tipo_grupo = e.nu_tipo_grupo
				and se1.nu_contrato = e.nu_contrato
				and se1.nu_situacao_atendimento = s.nu_situacao_solicitacao
			  )
			where
			  se.nu_equipe = v_nu_equipe
			  and se.nu_fatura_amostra = v_nu_fatura
			  and s.dh_efetiva::date between f.dt_inicio_fatura and f.dt_final_fatura
			  and se.ic_solicitacao_compoe_fns = 'S'
			  and coalesce(se.co_falha_solicitacao,'NF') = 'NF'
			  and exists (
				select null
				  from gct.gcttb191_servico_entregue se1
				 where se1.nu_tipo_grupo = e.nu_tipo_grupo
				   and se1.nu_contrato = e.nu_contrato
				   and se1.nu_situacao_atendimento = s.nu_situacao_solicitacao
				   and se1.nu_tipo_indicador = v_nu_tipo_indicador
			  );


	  RAISE NOTICE 'INDICADOR IQU - QUANTIDADE DE SERVIÇOS ENTREGUES: %', qtTotalEntregue;
 

      RAISE NOTICE 'INDICADOR % - EQUIPE: % GRUPO: % INDICADOR: % INSUMO: %', 
        v_sg_indicador, v_nu_equipe, v_nu_tipo_grupo, v_nu_tipo_indicador, qtTotalDevolvido;

      RAISE NOTICE 'INDICADOR % - EQUIPE: % GRUPO: % INDICADOR: % INSUMO: %', 
        v_sg_indicador, v_nu_equipe, v_nu_tipo_grupo, v_nu_tipo_indicador, qtTotalEntregue;
        
      --
      -- EXECUTAR O CALCULO DO VALOR DO INDICADOR
      --
      v_vr_indicador := null;

      if (qtTotalDevolvido > 0) then
        
        v_vr_indicador := 1 - (qtTotalDevolvido / qtTotalEntregue);
        
        RAISE NOTICE 'INDICADOR % - EQUIPE: % GRUPO: % INDICADOR: % VR_INDICADOR: 1 - (%/%)=%', 
          v_sg_indicador, v_nu_equipe, v_nu_tipo_grupo, v_nu_tipo_indicador, qtTotalEntregue, qtTotalDevolvido, v_vr_indicador;
      
      end if;

      RAISE NOTICE 'INDICADOR IQU - CALCULO INDICADOR EQUIPE: % | VALOR: %',v_nu_equipe,v_vr_indicador;
      PERFORM gct.gctfn314_registrar_valor_indicador_equipe(v_nu_fatura,v_nu_equipe,v_nu_tipo_grupo,v_nu_tipo_indicador,v_vr_indicador);

  end if;
END;

$function$;

alter function gct.gctfn204_indicador_qualidade(v_nu_equipe numeric, v_nu_tipo_grupo numeric, v_nu_fatura numeric) owner to gct;

--------------------------------------------------------------------------------
-- -- gctfn205_indicador_prazo
-- --------------------------------------------------------------------------------

-- drop function if exists gct.gctfn205_indicador_prazo(v_nu_equipe numeric, v_nu_tipo_grupo numeric, v_nu_fatura numeric);

CREATE OR REPLACE FUNCTION gct.gctfn205_indicador_prazo(v_nu_equipe numeric, v_nu_tipo_grupo numeric, v_nu_fatura numeric)
 RETURNS void
 LANGUAGE plpgsql
AS $function$

/*

RELEASE NOTES

RTC 23452881 - SIGCT - Melhoria Calculo dos Indicadores de Qualidade

*/
    
DECLARE

  v_sg_indicador character varying(6);

  v_vr_indicador numeric;
  v_nu_tipo_indicador numeric;
  v_nu_contrato numeric;
  v_no_tipo_indicador character varying(100);
  v_sg_tipo_indicador character(6);
  v_dt_inicio_fatura date;
  v_dt_final_fatura date;

	--
	-- VARIAVEIS DOS INSUMOS
	--
	qtTotalAtrasado numeric;
	qtTotalEntregue numeric;
    
BEGIN

  v_sg_indicador := 'IPZECQ';

  --
  -- PERIODO DE FATURAMENTO
  --    
  select
    dt_inicio_fatura,
    dt_final_fatura 
  into 
    v_dt_inicio_fatura,
    v_dt_final_fatura
  from
    gct.gcttb102_fatura
  where
    nu_fatura = v_nu_fatura;                

  --
  -- CONFIGURACAO DO INDICADOR
  --
  select
    ti.nu_tipo_indicador,
    ti.no_tipo_indicador,
    ti.sg_tipo_indicador,
    gi.nu_contrato 
  into 
    v_nu_tipo_indicador,
    v_no_tipo_indicador,
    v_sg_tipo_indicador,
    v_nu_contrato
  from
    gct.gcttb010_contrato c
    inner join gct.gcttb033_grupo_contrato gc on (c.nu_contrato = gc.nu_contrato)
    inner join gct.gcttb115_grupo_indicador gi on(
      gi.nu_tipo_grupo = gc.nu_tipo_grupo
      and gi.nu_contrato = gc.nu_contrato
    )
    inner join gct.gcttb112_tipo_indicador ti on (ti.nu_tipo_indicador = gi.nu_tipo_indicador)
    inner join gct.gcttb175_amostra_equipe e on (e.nu_contrato = c.nu_contrato)
  where
    sg_tipo_indicador = v_sg_indicador
    and e.nu_fatura_amostra = v_nu_fatura
    and e.nu_equipe = v_nu_equipe
    and gc.nu_tipo_grupo = v_nu_tipo_grupo;
    
    if (v_sg_tipo_indicador is null) then
      
      RAISE NOTICE 'INDICADOR % - EQUIPE: % GRUPO: % INDICADOR % NAO CONFIGURADO.', 
        v_sg_indicador, v_nu_equipe, v_nu_tipo_grupo, v_sg_indicador;
    
    else
    
		  RAISE NOTICE 'INDICADOR % - EQUIPE: % GRUPO: % INDICADOR: % PERIODO FATURAMENTO: % a %', 
			v_sg_indicador, v_nu_equipe, v_nu_tipo_grupo, v_nu_tipo_indicador, v_dt_inicio_fatura, v_dt_final_fatura;
			
		  --
		  -- OBTER INSUMOS DO CALCULO
		  --

		select
		  count(distinct s.co_solicitacao) into qtTotalAtrasado
		from
		  gct.gcttb177_amostra_solicitacao_equipe se
		  inner join gct.gcttb175_amostra_equipe e on (
			e.nu_equipe = se.nu_equipe
			and e.nu_fatura_amostra = se.nu_fatura_amostra
		  )
		  inner join gct.gcttb178_amostra_solicitacao s on (
			se.nu_solicitacao = s.nu_solicitacao
			and s.nu_fatura_amostra = se.nu_fatura_amostra
		  )
		  inner join gct.gcttb102_fatura f on f.nu_fatura = se.nu_fatura_amostra
		where
		  se.nu_equipe = v_nu_equipe
		  and se.nu_fatura_amostra = v_nu_fatura
		  and s.dh_efetiva::date between f.dt_inicio_fatura and f.dt_final_fatura
		  and s.dh_efetiva::date > gct.gctfn316_calc_dt_prevista(s.nu_solicitacao, date(s.dh_prevista))::date
		  and se.ic_solicitacao_compoe_fns = 'S'
		  and coalesce(se.co_falha_solicitacao,'NF') = 'NF'
		  and exists (
			select null
			  from gct.gcttb193_servico_atraso se1
			 where se1.nu_tipo_grupo = e.nu_tipo_grupo
			   and se1.nu_contrato = e.nu_contrato
			   and se1.nu_situacao_atendimento = s.nu_situacao_solicitacao
			   and se1.nu_tipo_indicador = v_nu_tipo_indicador
		  );


	  RAISE NOTICE 'INDICADOR IPZECQ - QUANTIDADE DE SERVIÇOS ATRASADOS: %', qtTotalAtrasado;
		 
		 select
			  count(distinct s.co_solicitacao) into qtTotalEntregue
			from
			  gct.gcttb177_amostra_solicitacao_equipe se
			  inner join gct.gcttb175_amostra_equipe e on (
				e.nu_equipe = se.nu_equipe
				and e.nu_fatura_amostra = se.nu_fatura_amostra
			  )
			  inner join gct.gcttb178_amostra_solicitacao s on (
				se.nu_solicitacao = s.nu_solicitacao
				and s.nu_fatura_amostra = se.nu_fatura_amostra
			  )
			  inner join gct.gcttb102_fatura f on f.nu_fatura = se.nu_fatura_amostra
			  inner join gct.gcttb191_servico_entregue se1 on (
				se1.nu_tipo_grupo = e.nu_tipo_grupo
				and se1.nu_contrato = e.nu_contrato
				and se1.nu_situacao_atendimento = s.nu_situacao_solicitacao
			  )
			where
			  se.nu_equipe = v_nu_equipe
			  and se.nu_fatura_amostra = v_nu_fatura
			  and s.dh_efetiva::date between f.dt_inicio_fatura and f.dt_final_fatura
			  and se.ic_solicitacao_compoe_fns = 'S'
			  and coalesce(se.co_falha_solicitacao,'NF') = 'NF'
			  and exists (
				select null
				  from gct.gcttb191_servico_entregue se1
				 where se1.nu_tipo_grupo = e.nu_tipo_grupo
				   and se1.nu_contrato = e.nu_contrato
				   and se1.nu_situacao_atendimento = s.nu_situacao_solicitacao
				   and se1.nu_tipo_indicador = v_nu_tipo_indicador
			  );


	  RAISE NOTICE 'INDICADOR IPZECQ - QUANTIDADE DE SERVIÇOS ENTREGUES: %', qtTotalEntregue;
	  

      RAISE NOTICE 'INDICADOR % - EQUIPE: % GRUPO: % INDICADOR: % INSUMO: %', 
        v_sg_indicador, v_nu_equipe, v_nu_tipo_grupo, v_nu_tipo_indicador, qtTotalAtrasado;

      RAISE NOTICE 'INDICADOR % - EQUIPE: % GRUPO: % INDICADOR: % INSUMO: %', 
        v_sg_indicador, v_nu_equipe, v_nu_tipo_grupo, v_nu_tipo_indicador, qtTotalEntregue;
        
      --
      -- EXECUTAR O CALCULO DO VALOR DO INDICADOR
      --
      v_vr_indicador := null;

      if (qtTotalAtrasado > 0) then
        
        v_vr_indicador := 1 - ( qtTotalAtrasado / qtTotalEntregue);
        
        RAISE NOTICE 'INDICADOR % - EQUIPE: % GRUPO: % INDICADOR: % VR_INDICADOR: (%/%)=%', 
          v_sg_indicador, v_nu_equipe, v_nu_tipo_grupo, v_nu_tipo_indicador, qtTotalEntregue, qtTotalAtrasado, v_vr_indicador;
      
      end if;

      RAISE NOTICE 'INDICADOR IPZECQ - CALCULO INDICADOR EQUIPE: % | VALOR: %',v_nu_equipe,v_vr_indicador;
      PERFORM gct.gctfn314_registrar_valor_indicador_equipe(v_nu_fatura,v_nu_equipe,v_nu_tipo_grupo,v_nu_tipo_indicador,v_vr_indicador);

  end if;
END;

$function$;

alter function gct.gctfn205_indicador_prazo(v_nu_equipe numeric, v_nu_tipo_grupo numeric, v_nu_fatura numeric) owner to gct;

--------------------------------------------------------------------------------
-- -- gctfn206_indicador_planejamento
-- --------------------------------------------------------------------------------

-- drop function if exists gct.gctfn206_indicador_planejamento(v_nu_equipe numeric, v_nu_tipo_grupo numeric, v_nu_fatura numeric);

CREATE OR REPLACE FUNCTION gct.gctfn206_indicador_planejamento(v_nu_equipe numeric, v_nu_tipo_grupo numeric, v_nu_fatura numeric)
 RETURNS void
 LANGUAGE plpgsql
AS $function$

/*

RELEASE NOTES

RTC 23452881 - SIGCT - Melhoria Calculo dos Indicadores de Qualidade

*/
    
DECLARE

  v_sg_indicador character varying(6);

  v_vr_indicador numeric;
  v_nu_tipo_indicador numeric;
  v_nu_contrato numeric;
  v_no_tipo_indicador character varying(100);
  v_sg_tipo_indicador character(6);
  v_dt_inicio_fatura date;
  v_dt_final_fatura date;

	--
	-- VARIAVEIS DOS INSUMOS
	--
	qtTotalEntregue numeric;
	qtTotalContratado numeric;
    
BEGIN

  v_sg_indicador := 'IAPECQ';

  --
  -- PERIODO DE FATURAMENTO
  --    
  select
    dt_inicio_fatura,
    dt_final_fatura 
  into 
    v_dt_inicio_fatura,
    v_dt_final_fatura
  from
    gct.gcttb102_fatura
  where
    nu_fatura = v_nu_fatura;                

  --
  -- CONFIGURACAO DO INDICADOR
  --
  select
    ti.nu_tipo_indicador,
    ti.no_tipo_indicador,
    ti.sg_tipo_indicador,
    gi.nu_contrato 
  into 
    v_nu_tipo_indicador,
    v_no_tipo_indicador,
    v_sg_tipo_indicador,
    v_nu_contrato
  from
    gct.gcttb010_contrato c
    inner join gct.gcttb033_grupo_contrato gc on (c.nu_contrato = gc.nu_contrato)
    inner join gct.gcttb115_grupo_indicador gi on(
      gi.nu_tipo_grupo = gc.nu_tipo_grupo
      and gi.nu_contrato = gc.nu_contrato
    )
    inner join gct.gcttb112_tipo_indicador ti on (ti.nu_tipo_indicador = gi.nu_tipo_indicador)
    inner join gct.gcttb175_amostra_equipe e on (e.nu_contrato = c.nu_contrato)
  where
    sg_tipo_indicador = v_sg_indicador
    and e.nu_fatura_amostra = v_nu_fatura
    and e.nu_equipe = v_nu_equipe
    and gc.nu_tipo_grupo = v_nu_tipo_grupo;
    
    if (v_sg_tipo_indicador is null) then
      
      RAISE NOTICE 'INDICADOR % - EQUIPE: % GRUPO: % INDICADOR % NAO CONFIGURADO.', 
        v_sg_indicador, v_nu_equipe, v_nu_tipo_grupo, v_sg_indicador;
    
    else
    
      RAISE NOTICE 'INDICADOR % - EQUIPE: % GRUPO: % INDICADOR: % PERIODO FATURAMENTO: % a %', 
        v_sg_indicador, v_nu_equipe, v_nu_tipo_grupo, v_nu_tipo_indicador, v_dt_inicio_fatura, v_dt_final_fatura;
        
      --
      -- OBTER INSUMOS DO CALCULO
      --
 	 
		 select
			  count(distinct s.co_solicitacao) into qtTotalEntregue
			from
			  gct.gcttb177_amostra_solicitacao_equipe se
			  inner join gct.gcttb175_amostra_equipe e on (
				e.nu_equipe = se.nu_equipe
				and e.nu_fatura_amostra = se.nu_fatura_amostra
			  )
			  inner join gct.gcttb178_amostra_solicitacao s on (
				se.nu_solicitacao = s.nu_solicitacao
				and s.nu_fatura_amostra = se.nu_fatura_amostra
			  )
			  inner join gct.gcttb102_fatura f on f.nu_fatura = se.nu_fatura_amostra
			  inner join gct.gcttb191_servico_entregue se1 on (
				se1.nu_tipo_grupo = e.nu_tipo_grupo
				and se1.nu_contrato = e.nu_contrato
				and se1.nu_situacao_atendimento = s.nu_situacao_solicitacao
			  )
			where
			  se.nu_equipe = v_nu_equipe
			  and se.nu_fatura_amostra = v_nu_fatura
			  and s.dh_efetiva::date between f.dt_inicio_fatura and f.dt_final_fatura
			  and se.ic_solicitacao_compoe_fns = 'S'
			  and coalesce(se.co_falha_solicitacao,'NF') = 'NF'
			  and exists (
				select null
				  from gct.gcttb191_servico_entregue se1
				 where se1.nu_tipo_grupo = e.nu_tipo_grupo
				   and se1.nu_contrato = e.nu_contrato
				   and se1.nu_situacao_atendimento = s.nu_situacao_solicitacao
				   and se1.nu_tipo_indicador = v_nu_tipo_indicador
			  );


	  RAISE NOTICE 'INDICADOR IAPECQ - QUANTIDADE DE SERVIÇOS ENTREGUES: %', qtTotalEntregue;
	   

	  --
      -- OBTER INSUMOS DO CALCULO
      --
 	 
		 select
			  count(distinct s.co_solicitacao) into qtTotalContratado
			from
			  gct.gcttb177_amostra_solicitacao_equipe se
			  inner join gct.gcttb175_amostra_equipe e on (
				e.nu_equipe = se.nu_equipe
				and e.nu_fatura_amostra = se.nu_fatura_amostra
			  )
			  inner join gct.gcttb178_amostra_solicitacao s on (
				se.nu_solicitacao = s.nu_solicitacao
				and s.nu_fatura_amostra = se.nu_fatura_amostra
			  )
			  inner join gct.gcttb102_fatura f on f.nu_fatura = se.nu_fatura_amostra
			  inner join gct.gcttb192_servico_contratado se1 on (
				se1.nu_tipo_grupo = e.nu_tipo_grupo
				and se1.nu_contrato = e.nu_contrato
				and se1.nu_situacao_atendimento = s.nu_situacao_solicitacao
			  )
			where
			  se.nu_equipe = v_nu_equipe
			  and se.nu_fatura_amostra = v_nu_fatura
			  and s.dh_efetiva::date between f.dt_inicio_fatura and f.dt_final_fatura
			  and se.ic_solicitacao_compoe_fns = 'S'
			  and coalesce(se.co_falha_solicitacao,'NF') = 'NF'
			  and exists (
				select null
				  from gct.gcttb192_servico_contratado se1
				 where se1.nu_tipo_grupo = e.nu_tipo_grupo
				   and se1.nu_contrato = e.nu_contrato
				   and se1.nu_situacao_atendimento = s.nu_situacao_solicitacao
				   and se1.nu_tipo_indicador = v_nu_tipo_indicador
			  );


	  RAISE NOTICE 'INDICADOR IAPECQ - QUANTIDADE DE SERVIÇOS CONTRATADO: %', qtTotalContratado;
	  
        
      --
      -- EXECUTAR O CALCULO DO VALOR DO INDICADOR
      --
      v_vr_indicador := null;

      if (qtTotalEntregue > 0) then
        
        v_vr_indicador := (qtTotalContratado / qtTotalEntregue);
        
        RAISE NOTICE 'INDICADOR % - EQUIPE: % GRUPO: % INDICADOR: % VR_INDICADOR: (%/%)=%', 
          v_sg_indicador, v_nu_equipe, v_nu_tipo_grupo, v_nu_tipo_indicador, qtTotalContratado, qtTotalEntregue, v_vr_indicador;
      
      end if;

      RAISE NOTICE 'INDICADOR IAPECQ - CALCULO INDICADOR EQUIPE: % | VALOR: %',v_nu_equipe,v_vr_indicador;
      PERFORM gct.gctfn314_registrar_valor_indicador_equipe(v_nu_fatura,v_nu_equipe,v_nu_tipo_grupo,v_nu_tipo_indicador,v_vr_indicador);

  end if;
END;

$function$;

alter function gct.gctfn206_indicador_planejamento(v_nu_equipe numeric, v_nu_tipo_grupo numeric, v_nu_fatura numeric) owner to gct;

--------------------------------------------------------------------------------
-- -- gctfn207_indicador_produtividade
-- --------------------------------------------------------------------------------

-- drop function if exists gct.gctfn207_indicador_produtividade(v_nu_equipe numeric, v_nu_tipo_grupo numeric, v_nu_fatura numeric);

CREATE OR REPLACE FUNCTION gct.gctfn207_indicador_produtividade(v_nu_equipe numeric, v_nu_tipo_grupo numeric, v_nu_fatura numeric)
 RETURNS void
 LANGUAGE plpgsql
AS $function$

/*

RELEASE NOTES

RTC 23452881 - SIGCT - Melhoria Calculo dos Indicadores de Qualidade

*/
    
DECLARE

  v_sg_indicador character varying(6);

  v_vr_indicador numeric;
  v_nu_tipo_indicador numeric;
  v_nu_contrato numeric;
  v_no_tipo_indicador character varying(100);
  v_sg_tipo_indicador character(6);
  v_dt_inicio_fatura date;
  v_dt_final_fatura date;

	--
	-- VARIAVEIS DOS INSUMOS
	--
	v_qt_insumo_1 numeric;
	v_qt_insumo_2 numeric;
    
BEGIN

  v_sg_indicador := 'IPRECQ';

  --
  -- PERIODO DE FATURAMENTO
  --    
  select
    dt_inicio_fatura,
    dt_final_fatura 
  into 
    v_dt_inicio_fatura,
    v_dt_final_fatura
  from
    gct.gcttb102_fatura
  where
    nu_fatura = v_nu_fatura;                

  --
  -- CONFIGURACAO DO INDICADOR
  --
  select
    ti.nu_tipo_indicador,
    ti.no_tipo_indicador,
    ti.sg_tipo_indicador,
    gi.nu_contrato 
  into 
    v_nu_tipo_indicador,
    v_no_tipo_indicador,
    v_sg_tipo_indicador,
    v_nu_contrato
  from
    gct.gcttb010_contrato c
    inner join gct.gcttb033_grupo_contrato gc on (c.nu_contrato = gc.nu_contrato)
    inner join gct.gcttb115_grupo_indicador gi on(
      gi.nu_tipo_grupo = gc.nu_tipo_grupo
      and gi.nu_contrato = gc.nu_contrato
    )
    inner join gct.gcttb112_tipo_indicador ti on (ti.nu_tipo_indicador = gi.nu_tipo_indicador)
    inner join gct.gcttb175_amostra_equipe e on (e.nu_contrato = c.nu_contrato)
  where
    sg_tipo_indicador = v_sg_indicador
    and e.nu_fatura_amostra = v_nu_fatura
    and e.nu_equipe = v_nu_equipe
    and gc.nu_tipo_grupo = v_nu_tipo_grupo;
    
    if (v_sg_tipo_indicador is null) then
      
      RAISE NOTICE 'INDICADOR % - EQUIPE: % GRUPO: % INDICADOR % NAO CONFIGURADO.', 
        v_sg_indicador, v_nu_equipe, v_nu_tipo_grupo, v_sg_indicador;
    
    else
    
      RAISE NOTICE 'INDICADOR % - EQUIPE: % GRUPO: % INDICADOR: % PERIODO FATURAMENTO: % a %', 
        v_sg_indicador, v_nu_equipe, v_nu_tipo_grupo, v_nu_tipo_indicador, v_dt_inicio_fatura, v_dt_final_fatura;
        
      --
      -- OBTER INSUMOS DO CALCULO
      --

      v_qt_insumo_1 := 1;
      v_qt_insumo_2 := 1;

      RAISE NOTICE 'INDICADOR % - EQUIPE: % GRUPO: % INDICADOR: % INSUMO: %', 
        v_sg_indicador, v_nu_equipe, v_nu_tipo_grupo, v_nu_tipo_indicador, v_qt_insumo_1;

      RAISE NOTICE 'INDICADOR % - EQUIPE: % GRUPO: % INDICADOR: % INSUMO: %', 
        v_sg_indicador, v_nu_equipe, v_nu_tipo_grupo, v_nu_tipo_indicador, v_qt_insumo_2;
        
      --
      -- EXECUTAR O CALCULO DO VALOR DO INDICADOR
      --
      v_vr_indicador := null;

      if (v_qt_insumo_1 > 0) then
        
        v_vr_indicador := v_qt_insumo_2 / v_qt_insumo_1;
        
        RAISE NOTICE 'INDICADOR % - EQUIPE: % GRUPO: % INDICADOR: % VR_INDICADOR: (%/%)=%', 
          v_sg_indicador, v_nu_equipe, v_nu_tipo_grupo, v_nu_tipo_indicador, v_qt_insumo_2, v_qt_insumo_1, v_vr_indicador;
      
      end if;

      RAISE NOTICE 'INDICADOR IPRECQ - CALCULO INDICADOR EQUIPE: % | VALOR: %',v_nu_equipe,v_vr_indicador;
      PERFORM gct.gctfn314_registrar_valor_indicador_equipe(v_nu_fatura,v_nu_equipe,v_nu_tipo_grupo,v_nu_tipo_indicador,v_vr_indicador);

  end if;
END;

$function$;

alter function gct.gctfn207_indicador_produtividade(v_nu_equipe numeric, v_nu_tipo_grupo numeric, v_nu_fatura numeric) owner to gct;

--------------------------------------------------------------------------------
-- -- gctfn208_indicador_turnover
-- --------------------------------------------------------------------------------

-- drop function if exists gct.gctfn208_indicador_turnover(v_nu_equipe numeric, v_nu_tipo_grupo numeric, v_nu_fatura numeric);

CREATE OR REPLACE FUNCTION gct.gctfn208_indicador_turnover(v_nu_equipe numeric, v_nu_tipo_grupo numeric, v_nu_fatura numeric)
 RETURNS void
 LANGUAGE plpgsql
AS $function$

/*

RELEASE NOTES

RTC 23452881 - SIGCT - Melhoria Calculo dos Indicadores de Qualidade

*/
    
DECLARE

  v_sg_indicador character varying(6);

  v_vr_indicador numeric;
  v_nu_tipo_indicador numeric;
  v_nu_contrato numeric;
  v_no_tipo_indicador character varying(100);
  v_sg_tipo_indicador character(6);
  v_dt_inicio_fatura date;
  v_dt_final_fatura date;

	--
	-- VARIAVEIS DOS INSUMOS
	--
	v_qt_insumo_1 numeric;
	v_qt_insumo_2 numeric;
    
BEGIN

  v_sg_indicador := 'ITDCQ';

  --
  -- PERIODO DE FATURAMENTO
  --    
  select
    dt_inicio_fatura,
    dt_final_fatura 
  into 
    v_dt_inicio_fatura,
    v_dt_final_fatura
  from
    gct.gcttb102_fatura
  where
    nu_fatura = v_nu_fatura;                

  --
  -- CONFIGURACAO DO INDICADOR
  --
  select
    ti.nu_tipo_indicador,
    ti.no_tipo_indicador,
    ti.sg_tipo_indicador,
    gi.nu_contrato 
  into 
    v_nu_tipo_indicador,
    v_no_tipo_indicador,
    v_sg_tipo_indicador,
    v_nu_contrato
  from
    gct.gcttb010_contrato c
    inner join gct.gcttb033_grupo_contrato gc on (c.nu_contrato = gc.nu_contrato)
    inner join gct.gcttb115_grupo_indicador gi on(
      gi.nu_tipo_grupo = gc.nu_tipo_grupo
      and gi.nu_contrato = gc.nu_contrato
    )
    inner join gct.gcttb112_tipo_indicador ti on (ti.nu_tipo_indicador = gi.nu_tipo_indicador)
    inner join gct.gcttb175_amostra_equipe e on (e.nu_contrato = c.nu_contrato)
  where
    sg_tipo_indicador = v_sg_indicador
    and e.nu_fatura_amostra = v_nu_fatura
    and e.nu_equipe = v_nu_equipe
    and gc.nu_tipo_grupo = v_nu_tipo_grupo;
    
    if (v_sg_tipo_indicador is null) then
      
      RAISE NOTICE 'INDICADOR % - EQUIPE: % GRUPO: % INDICADOR % NAO CONFIGURADO.', 
        v_sg_indicador, v_nu_equipe, v_nu_tipo_grupo, v_sg_indicador;
    
    else
    
      RAISE NOTICE 'INDICADOR % - EQUIPE: % GRUPO: % INDICADOR: % PERIODO FATURAMENTO: % a %', 
        v_sg_indicador, v_nu_equipe, v_nu_tipo_grupo, v_nu_tipo_indicador, v_dt_inicio_fatura, v_dt_final_fatura;
        
      --
      -- OBTER INSUMOS DO CALCULO
      --

      v_qt_insumo_1 := 1;
      v_qt_insumo_2 := 1;

      RAISE NOTICE 'INDICADOR % - EQUIPE: % GRUPO: % INDICADOR: % INSUMO: %', 
        v_sg_indicador, v_nu_equipe, v_nu_tipo_grupo, v_nu_tipo_indicador, v_qt_insumo_1;

      RAISE NOTICE 'INDICADOR % - EQUIPE: % GRUPO: % INDICADOR: % INSUMO: %', 
        v_sg_indicador, v_nu_equipe, v_nu_tipo_grupo, v_nu_tipo_indicador, v_qt_insumo_2;
        
      --
      -- EXECUTAR O CALCULO DO VALOR DO INDICADOR
      --
      v_vr_indicador := null;

      if (v_qt_insumo_1 > 0) then
        
        v_vr_indicador := v_qt_insumo_2 / v_qt_insumo_1;
        
        RAISE NOTICE 'INDICADOR % - EQUIPE: % GRUPO: % INDICADOR: % VR_INDICADOR: (%/%)=%', 
          v_sg_indicador, v_nu_equipe, v_nu_tipo_grupo, v_nu_tipo_indicador, v_qt_insumo_2, v_qt_insumo_1, v_vr_indicador;
      
      end if;

      RAISE NOTICE 'INDICADOR ITDCQ - CALCULO INDICADOR EQUIPE: % | VALOR: %',v_nu_equipe,v_vr_indicador;
      PERFORM gct.gctfn314_registrar_valor_indicador_equipe(v_nu_fatura,v_nu_equipe,v_nu_tipo_grupo,v_nu_tipo_indicador,v_vr_indicador);

  end if;
END;

$function$;

alter function gct.gctfn208_indicador_turnover(v_nu_equipe numeric, v_nu_tipo_grupo numeric, v_nu_fatura numeric) owner to gct;

--------------------------------------------------------------------------------
-- -- gctfn209_calcular_fator_nivel_servico
-- --------------------------------------------------------------------------------

-- drop function if exists gct.gctfn209_calcular_fator_nivel_servico(p_nu_equipe numeric, p_nu_fatura numeric, p_dt_referencia date, p_nu_matricula numeric);

CREATE OR REPLACE FUNCTION gct.gctfn209_calcular_fator_nivel_servico(p_nu_equipe numeric, p_nu_fatura numeric, p_dt_referencia date, p_nu_matricula numeric)
 RETURNS numeric
 LANGUAGE plpgsql
AS $function$

/**

RELEASE NOTES

RTC 23452881 - SIGCT - Melhoria no Cálculo dos Indicadores de Qualidade

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

alter function gct.gctfn209_calcular_fator_nivel_servico(p_nu_equipe numeric, p_nu_fatura numeric, p_dt_referencia date, p_nu_matricula numeric) owner to gct;

--------------------------------------------------------------------------------
-- -- gctfn210_calcular_bonus
-- --------------------------------------------------------------------------------

-- drop function if exists gct.gctfn210_calcular_bonus(dtbase date, p_nu_contrato numeric, p_nu_equipe numeric);

CREATE OR REPLACE FUNCTION gct.gctfn210_calcular_bonus(dtbase date, p_nu_contrato numeric, p_nu_equipe numeric DEFAULT NULL::numeric)
 RETURNS void
 LANGUAGE plpgsql
AS $function$

/**

RELEASE NOTES

RTC 23452881 - SIGCT - Melhoria no Cálculo dos Indicadores de Qualidade

*/

DECLARE
          
BEGIN

END;

$function$;

alter function gct.gctfn210_calcular_bonus(dtbase date, p_nu_contrato numeric, p_nu_equipe numeric) owner to gct;

--------------------------------------------------------------------------------
-- -- gctfn211_calcular_descontos
-- --------------------------------------------------------------------------------

-- drop function if exists gct.gctfn211_calcular_descontos(dtbase date, p_nu_contrato numeric, p_nu_equipe numeric);

CREATE OR REPLACE FUNCTION gct.gctfn211_calcular_descontos(dtbase date, p_nu_contrato numeric, p_nu_equipe numeric DEFAULT NULL::numeric)
 RETURNS void
 LANGUAGE plpgsql
AS $function$

/**

RELEASE NOTES

RTC 23452881 - SIGCT - Melhoria no Cálculo dos Indicadores de Qualidade

*/

DECLARE
          
BEGIN

END;

$function$;

alter function gct.gctfn211_calcular_descontos(dtbase date, p_nu_contrato numeric, p_nu_equipe numeric) owner to gct;

--------------------------------------------------------------------------------
-- -- gctfn214_indicador_qualidade_ajuste
-- --------------------------------------------------------------------------------

-- drop function if exists gct.gctfn214_indicador_qualidade_ajuste(v_nu_equipe numeric, v_nu_tipo_grupo numeric, v_nu_fatura numeric, v_nu_ajuste numeric);

CREATE OR REPLACE FUNCTION gct.gctfn214_indicador_qualidade_ajuste(v_nu_equipe numeric, v_nu_tipo_grupo numeric, v_nu_fatura numeric, v_nu_ajuste numeric)
 RETURNS void
 LANGUAGE plpgsql
AS $function$

/**

RELEASE NOTES

RTC 23452881 - SIGCT - Melhoria Calculo dos Indicadores de Qualidade

*/

DECLARE

	v_sg_indicador character varying(6);

	v_vr_indicador numeric;
	v_nu_tipo_indicador numeric;
	v_nu_contrato numeric;
	v_no_tipo_indicador character varying(100);
	v_sg_tipo_indicador character varying(6);
	v_dt_inicio_fatura date;
	v_dt_final_fatura date;

	--
	-- VARIAVEIS DOS INSUMOS
	--
	qtTotalDevolvido numeric;
	qtTotalEntregue numeric;

BEGIN

	v_sg_indicador := 'IQU';

	--
	-- PERIODO DE FATURAMENTO
	--
	select
		dt_inicio_fatura,
		dt_final_fatura
	into 
	  v_dt_inicio_fatura,
		v_dt_final_fatura
	from
		gct.gcttb102_fatura 
	where
		nu_fatura = v_nu_fatura;

	--
	-- CONFIGURACAO DO INDICADOR
	--
	select
		ti.nu_tipo_indicador,
		ti.no_tipo_indicador,
		ti.sg_tipo_indicador,
		gi.nu_contrato 
	into 
	  v_nu_tipo_indicador,
		v_no_tipo_indicador,
		v_sg_tipo_indicador,
		v_nu_contrato
	from
		gct.gcttb010_contrato c
		inner join gct.gcttb033_grupo_contrato gc on (c.nu_contrato = gc.nu_contrato)
		inner join gct.gcttb115_grupo_indicador gi on (
			gi.nu_tipo_grupo = gc.nu_tipo_grupo
			and gi.nu_contrato = gc.nu_contrato
		)
		inner join gct.gcttb112_tipo_indicador ti on (ti.nu_tipo_indicador = gi.nu_tipo_indicador)
		inner join gct.gcttb175_amostra_equipe e on (e.nu_contrato = c.nu_contrato)
	where
		sg_tipo_indicador = v_sg_indicador
		and e.nu_ajuste = v_nu_ajuste
		and e.nu_equipe = v_nu_equipe
		and gc.nu_tipo_grupo = v_nu_tipo_grupo;
	
	if(v_sg_tipo_indicador is null) then
		
      RAISE NOTICE 'INDICADOR % - EQUIPE: % AJUSTE: % GRUPO: % INDICADOR % NAO CONFIGURADO.', 
        v_sg_indicador, v_nu_ajuste, v_nu_equipe, v_nu_tipo_grupo, v_sg_indicador;
	
	else
		
		RAISE NOTICE 'INDICADOR % - EQUIPE: % AJUSTE: % GRUPO: % INDICADOR: % PERIODO FATURAMENTO: % a %', 
			v_sg_indicador, v_nu_equipe, v_nu_ajuste, v_nu_tipo_grupo, v_nu_tipo_indicador, v_dt_inicio_fatura, v_dt_final_fatura;
		
		--
		-- OBTER INSUMOS DO CALCULO
		--

		qtTotalDevolvido := 1;
		qtTotalEntregue := 1;
 
		select
			  count(distinct s.co_solicitacao) into qtTotalDevolvido
			from
			  gct.gcttb177_amostra_solicitacao_equipe se
			  inner join gct.gcttb175_amostra_equipe e on (
				e.nu_equipe = se.nu_equipe
				and e.nu_fatura_amostra = se.nu_fatura_amostra
			  )
			  inner join gct.gcttb178_amostra_solicitacao s on (
				se.nu_solicitacao = s.nu_solicitacao
				and s.nu_fatura_amostra = se.nu_fatura_amostra
			  )
			  inner join gct.gcttb102_fatura f on f.nu_fatura = se.nu_fatura_amostra
			  inner join gct.gcttb181_amostra_devolucao_solicitacao ds on (
				ds.nu_solicitacao = se.nu_solicitacao
				and ds.nu_fatura_amostra = se.nu_fatura_amostra 
			  )
			where
			  se.nu_equipe = v_nu_equipe
			  and se.nu_fatura_amostra = v_nu_fatura
			  and s.dh_efetiva::date between f.dt_inicio_fatura and f.dt_final_fatura
			  and se.ic_solicitacao_compoe_fns = 'S'
			  and coalesce(se.co_falha_solicitacao, 'NF') = 'NF'
			  and exists (
				select null
				  from gct.gcttb194_servico_devolvido se1
				 where se1.nu_tipo_grupo = e.nu_tipo_grupo
				   and se1.nu_contrato = e.nu_contrato
				   and se1.nu_situacao_atendimento = s.nu_situacao_solicitacao
				   and se1.nu_tipo_indicador = v_nu_tipo_indicador
			  );


		RAISE NOTICE 'INDICADOR % - EQUIPE: % AJUSTE: % GRUPO: % INDICADOR: % INSUMO: %', 
			v_sg_indicador, v_nu_equipe, v_nu_ajuste, v_nu_tipo_grupo, v_nu_tipo_indicador, qtTotalDevolvido;
	  
	  
		 select
			  count(distinct s.co_solicitacao) into qtTotalEntregue
			from
			  gct.gcttb177_amostra_solicitacao_equipe se
			  inner join gct.gcttb175_amostra_equipe e on (
				e.nu_equipe = se.nu_equipe
				and e.nu_fatura_amostra = se.nu_fatura_amostra
			  )
			  inner join gct.gcttb178_amostra_solicitacao s on (
				se.nu_solicitacao = s.nu_solicitacao
				and s.nu_fatura_amostra = se.nu_fatura_amostra
			  )
			  inner join gct.gcttb102_fatura f on f.nu_fatura = se.nu_fatura_amostra
			  inner join gct.gcttb191_servico_entregue se1 on (
				se1.nu_tipo_grupo = e.nu_tipo_grupo
				and se1.nu_contrato = e.nu_contrato
				and se1.nu_situacao_atendimento = s.nu_situacao_solicitacao
			  )
			where
			  se.nu_equipe = v_nu_equipe
			  and se.nu_fatura_amostra = v_nu_fatura
			  and s.dh_efetiva::date between f.dt_inicio_fatura and f.dt_final_fatura
			  and se.ic_solicitacao_compoe_fns = 'S'
			  and coalesce(se.co_falha_solicitacao,'NF') = 'NF'
			  and exists (
				select null
				  from gct.gcttb191_servico_entregue se1
				 where se1.nu_tipo_grupo = e.nu_tipo_grupo
				   and se1.nu_contrato = e.nu_contrato
				   and se1.nu_situacao_atendimento = s.nu_situacao_solicitacao
				   and se1.nu_tipo_indicador = v_nu_tipo_indicador
			  );

 
		RAISE NOTICE 'INDICADOR % - EQUIPE: % AJUSTE: % GRUPO: % INDICADOR: % INSUMO: %', 
			v_sg_indicador, v_nu_equipe, v_nu_ajuste, v_nu_tipo_grupo, v_nu_tipo_indicador, qtTotalEntregue;

		--
		-- EXECUTAR O CALCULO DO VALOR DO INDICADOR
		--
		v_vr_indicador := null;

    if (qtTotalDevolvido > 0) then
			
			v_vr_indicador := qtTotalEntregue / qtTotalDevolvido;
		  
			RAISE NOTICE 'INDICADOR % - EQUIPE: % AJUSTE: % GRUPO: % INDICADOR: % VR_INDICADOR: (%/%)=%', 
		    v_sg_indicador, v_nu_equipe, v_nu_ajuste, v_nu_tipo_grupo, v_nu_tipo_indicador, qtTotalEntregue, qtTotalDevolvido, v_vr_indicador;
		
		end if;

		--
		-- GRAVAR O INDICADOR
		--
    PERFORM gct.gctfn343_registrar_vl_ind_equipe_ajuste(v_nu_ajuste, v_nu_fatura, v_nu_equipe, v_nu_tipo_grupo, v_nu_tipo_indicador, v_vr_indicador);

	end if;
END;
$function$;

alter function gct.gctfn214_indicador_qualidade_ajuste(v_nu_equipe numeric, v_nu_tipo_grupo numeric, v_nu_fatura numeric, v_nu_ajuste numeric) owner to gct;

--------------------------------------------------------------------------------
-- -- gctfn215_indicador_prazo_ajuste
-- --------------------------------------------------------------------------------

-- drop function if exists gct.gctfn215_indicador_prazo_ajuste(v_nu_equipe numeric, v_nu_tipo_grupo numeric, v_nu_fatura numeric, v_nu_ajuste numeric);

CREATE OR REPLACE FUNCTION gct.gctfn215_indicador_prazo_ajuste(v_nu_equipe numeric, v_nu_tipo_grupo numeric, v_nu_fatura numeric, v_nu_ajuste numeric)
 RETURNS void
 LANGUAGE plpgsql
AS $function$

/**

RELEASE NOTES

RTC 23452881 - SIGCT - Melhoria Calculo dos Indicadores de Qualidade

*/

DECLARE

	v_sg_indicador character varying(6);

	v_vr_indicador numeric;
	v_nu_tipo_indicador numeric;
	v_nu_contrato numeric;
	v_no_tipo_indicador character varying(100);
	v_sg_tipo_indicador character varying(6);
	v_dt_inicio_fatura date;
	v_dt_final_fatura date;

	--
	-- VARIAVEIS DOS INSUMOS
	--
	qtTotalAtrasado numeric;
	qtTotalEntregue numeric;

BEGIN

	v_sg_indicador := 'IPZECQ';

	--
	-- PERIODO DE FATURAMENTO
	--
	select
		dt_inicio_fatura,
		dt_final_fatura
	into 
	  v_dt_inicio_fatura,
		v_dt_final_fatura
	from
		gct.gcttb102_fatura 
	where
		nu_fatura = v_nu_fatura;

	--
	-- CONFIGURACAO DO INDICADOR
	--
	select
		ti.nu_tipo_indicador,
		ti.no_tipo_indicador,
		ti.sg_tipo_indicador,
		gi.nu_contrato 
	into 
	  v_nu_tipo_indicador,
		v_no_tipo_indicador,
		v_sg_tipo_indicador,
		v_nu_contrato
	from
		gct.gcttb010_contrato c
		inner join gct.gcttb033_grupo_contrato gc on (c.nu_contrato = gc.nu_contrato)
		inner join gct.gcttb115_grupo_indicador gi on (
			gi.nu_tipo_grupo = gc.nu_tipo_grupo
			and gi.nu_contrato = gc.nu_contrato
		)
		inner join gct.gcttb112_tipo_indicador ti on (ti.nu_tipo_indicador = gi.nu_tipo_indicador)
		inner join gct.gcttb175_amostra_equipe e on (e.nu_contrato = c.nu_contrato)
	where
		sg_tipo_indicador = v_sg_indicador
		and e.nu_ajuste = v_nu_ajuste
		and e.nu_equipe = v_nu_equipe
		and gc.nu_tipo_grupo = v_nu_tipo_grupo;
	
	if(v_sg_tipo_indicador is null) then
		
      RAISE NOTICE 'INDICADOR % - EQUIPE: % AJUSTE: % GRUPO: % INDICADOR % NAO CONFIGURADO.', 
        v_sg_indicador, v_nu_ajuste, v_nu_equipe, v_nu_tipo_grupo, v_sg_indicador;
	
	else
		
		RAISE NOTICE 'INDICADOR % - EQUIPE: % AJUSTE: % GRUPO: % INDICADOR: % PERIODO FATURAMENTO: % a %', 
			v_sg_indicador, v_nu_equipe, v_nu_ajuste, v_nu_tipo_grupo, v_nu_tipo_indicador, v_dt_inicio_fatura, v_dt_final_fatura;
		
		--
		-- OBTER INSUMOS DO CALCULO
		--

		qtTotalAtrasado := 1;
		qtTotalEntregue := 1;
		

	    select
		  count(distinct s.co_solicitacao) into qtTotalAtrasado
		from
		  gct.gcttb177_amostra_solicitacao_equipe se
		  inner join gct.gcttb175_amostra_equipe e on (
			e.nu_equipe = se.nu_equipe
			and e.nu_fatura_amostra = se.nu_fatura_amostra
		  )
		  inner join gct.gcttb178_amostra_solicitacao s on (
			se.nu_solicitacao = s.nu_solicitacao
			and s.nu_fatura_amostra = se.nu_fatura_amostra
		  )
		  inner join gct.gcttb102_fatura f on f.nu_fatura = se.nu_fatura_amostra
		where
		  se.nu_equipe = v_nu_equipe
		  and se.nu_fatura_amostra = v_nu_fatura
		  and s.dh_efetiva::date between f.dt_inicio_fatura and f.dt_final_fatura
		  and s.dh_efetiva::date > gct.gctfn316_calc_dt_prevista(s.nu_solicitacao, date(s.dh_prevista))::date
		  and se.ic_solicitacao_compoe_fns = 'S'
		  and coalesce(se.co_falha_solicitacao,'NF') = 'NF'
		  and exists (
			select null
			  from gct.gcttb193_servico_atraso se1
			 where se1.nu_tipo_grupo = e.nu_tipo_grupo
			   and se1.nu_contrato = e.nu_contrato
			   and se1.nu_situacao_atendimento = s.nu_situacao_solicitacao
			   and se1.nu_tipo_indicador = v_nu_tipo_indicador
		  );
		

		RAISE NOTICE 'INDICADOR % - EQUIPE: % AJUSTE: % GRUPO: % INDICADOR: % INSUMO  - QUANTIDADE DE SERVIÇOS ATRASADOS: %', 
			v_sg_indicador, v_nu_equipe, v_nu_ajuste, v_nu_tipo_grupo, v_nu_tipo_indicador, qtTotalAtrasado;
			
 
			select
			  count(distinct s.co_solicitacao) into qtTotalEntregue
			from
			  gct.gcttb177_amostra_solicitacao_equipe se
			  inner join gct.gcttb175_amostra_equipe e on (
				e.nu_equipe = se.nu_equipe
				and e.nu_fatura_amostra = se.nu_fatura_amostra
			  )
			  inner join gct.gcttb178_amostra_solicitacao s on (
				se.nu_solicitacao = s.nu_solicitacao
				and s.nu_fatura_amostra = se.nu_fatura_amostra
			  )
			  inner join gct.gcttb102_fatura f on f.nu_fatura = se.nu_fatura_amostra
			  inner join gct.gcttb191_servico_entregue se1 on (
				se1.nu_tipo_grupo = e.nu_tipo_grupo
				and se1.nu_contrato = e.nu_contrato
				and se1.nu_situacao_atendimento = s.nu_situacao_solicitacao
			  )
			where
			  se.nu_equipe = v_nu_equipe
			  and se.nu_fatura_amostra = v_nu_fatura
			  and s.dh_efetiva::date between f.dt_inicio_fatura and f.dt_final_fatura
			  and se.ic_solicitacao_compoe_fns = 'S'
			  and coalesce(se.co_falha_solicitacao,'NF') = 'NF'
			  and exists (
				select null
				  from gct.gcttb191_servico_entregue se1
				 where se1.nu_tipo_grupo = e.nu_tipo_grupo
				   and se1.nu_contrato = e.nu_contrato
				   and se1.nu_situacao_atendimento = s.nu_situacao_solicitacao
				   and se1.nu_tipo_indicador = v_nu_tipo_indicador
			  );

 

		RAISE NOTICE 'INDICADOR % - EQUIPE: % AJUSTE: % GRUPO: % INDICADOR: % INSUMO  - QUANTIDADE DE SERVIÇOS ENTREGUES: %', 
			v_sg_indicador, v_nu_equipe, v_nu_ajuste, v_nu_tipo_grupo, v_nu_tipo_indicador, qtTotalEntregue;

		--
		-- EXECUTAR O CALCULO DO VALOR DO INDICADOR
		--
		v_vr_indicador := null;

		if (qtTotalAtrasado > 0) then
			
			v_vr_indicador := 1 - ( qtTotalAtrasado / qtTotalEntregue );
		  
			RAISE NOTICE 'INDICADOR % - EQUIPE: % AJUSTE: % GRUPO: % INDICADOR: % VR_INDICADOR: (%/%)=%', 
		    v_sg_indicador, v_nu_equipe, v_nu_ajuste, v_nu_tipo_grupo, v_nu_tipo_indicador, qtTotalEntregue, qtTotalAtrasado, v_vr_indicador;
		
		end if;

		--
		-- GRAVAR O INDICADOR
		--
    PERFORM gct.gctfn343_registrar_vl_ind_equipe_ajuste(v_nu_ajuste, v_nu_fatura, v_nu_equipe, v_nu_tipo_grupo, v_nu_tipo_indicador, v_vr_indicador);

	end if;
END;
$function$;

alter function gct.gctfn215_indicador_prazo_ajuste(v_nu_equipe numeric, v_nu_tipo_grupo numeric, v_nu_fatura numeric, v_nu_ajuste numeric) owner to gct;

--------------------------------------------------------------------------------
-- -- gctfn216_indicador_planejamento_ajuste
-- --------------------------------------------------------------------------------

-- drop function if exists gct.gctfn216_indicador_planejamento_ajuste(v_nu_equipe numeric, v_nu_tipo_grupo numeric, v_nu_fatura numeric, v_nu_ajuste numeric);

CREATE OR REPLACE FUNCTION gct.gctfn216_indicador_planejamento_ajuste(v_nu_equipe numeric, v_nu_tipo_grupo numeric, v_nu_fatura numeric, v_nu_ajuste numeric)
 RETURNS void
 LANGUAGE plpgsql
AS $function$

/**

RELEASE NOTES

RTC 23452881 - SIGCT - Melhoria Calculo dos Indicadores de Qualidade

*/

DECLARE

	v_sg_indicador character varying(6);

	v_vr_indicador numeric;
	v_nu_tipo_indicador numeric;
	v_nu_contrato numeric;
	v_no_tipo_indicador character varying(100);
	v_sg_tipo_indicador character varying(6);
	v_dt_inicio_fatura date;
	v_dt_final_fatura date;

	--
	-- VARIAVEIS DOS INSUMOS
	--
	qtTotalEntregue numeric;
	qtTotalContratado numeric;

BEGIN

	v_sg_indicador := 'IAPECQ';

	--
	-- PERIODO DE FATURAMENTO
	--
	select
		dt_inicio_fatura,
		dt_final_fatura
	into 
	  v_dt_inicio_fatura,
		v_dt_final_fatura
	from
		gct.gcttb102_fatura 
	where
		nu_fatura = v_nu_fatura;

	--
	-- CONFIGURACAO DO INDICADOR
	--
	select
		ti.nu_tipo_indicador,
		ti.no_tipo_indicador,
		ti.sg_tipo_indicador,
		gi.nu_contrato 
	into 
	  v_nu_tipo_indicador,
		v_no_tipo_indicador,
		v_sg_tipo_indicador,
		v_nu_contrato
	from
		gct.gcttb010_contrato c
		inner join gct.gcttb033_grupo_contrato gc on (c.nu_contrato = gc.nu_contrato)
		inner join gct.gcttb115_grupo_indicador gi on (
			gi.nu_tipo_grupo = gc.nu_tipo_grupo
			and gi.nu_contrato = gc.nu_contrato
		)
		inner join gct.gcttb112_tipo_indicador ti on (ti.nu_tipo_indicador = gi.nu_tipo_indicador)
		inner join gct.gcttb175_amostra_equipe e on (e.nu_contrato = c.nu_contrato)
	where
		sg_tipo_indicador = v_sg_indicador
		and e.nu_ajuste = v_nu_ajuste
		and e.nu_equipe = v_nu_equipe
		and gc.nu_tipo_grupo = v_nu_tipo_grupo;
	
	if(v_sg_tipo_indicador is null) then
		
      RAISE NOTICE 'INDICADOR % - EQUIPE: % AJUSTE: % GRUPO: % INDICADOR % NAO CONFIGURADO.', 
        v_sg_indicador, v_nu_ajuste, v_nu_equipe, v_nu_tipo_grupo, v_sg_indicador;
	
	else
		
		RAISE NOTICE 'INDICADOR % - EQUIPE: % AJUSTE: % GRUPO: % INDICADOR: % PERIODO FATURAMENTO: % a %', 
			v_sg_indicador, v_nu_equipe, v_nu_ajuste, v_nu_tipo_grupo, v_nu_tipo_indicador, v_dt_inicio_fatura, v_dt_final_fatura;
		
		--
		-- OBTER INSUMOS DO CALCULO
		--

		qtTotalEntregue := 1;
		qtTotalContratado := 1;


			select
			  count(distinct s.co_solicitacao) into qtTotalEntregue
			from
			  gct.gcttb177_amostra_solicitacao_equipe se
			  inner join gct.gcttb175_amostra_equipe e on (
				e.nu_equipe = se.nu_equipe
				and e.nu_fatura_amostra = se.nu_fatura_amostra
			  )
			  inner join gct.gcttb178_amostra_solicitacao s on (
				se.nu_solicitacao = s.nu_solicitacao
				and s.nu_fatura_amostra = se.nu_fatura_amostra
			  )
			  inner join gct.gcttb102_fatura f on f.nu_fatura = se.nu_fatura_amostra
			  inner join gct.gcttb191_servico_entregue se1 on (
				se1.nu_tipo_grupo = e.nu_tipo_grupo
				and se1.nu_contrato = e.nu_contrato
				and se1.nu_situacao_atendimento = s.nu_situacao_solicitacao
			  )
			where
			  se.nu_equipe = v_nu_equipe
			  and se.nu_fatura_amostra = v_nu_fatura
			  and s.dh_efetiva::date between f.dt_inicio_fatura and f.dt_final_fatura
			  and se.ic_solicitacao_compoe_fns = 'S'
			  and coalesce(se.co_falha_solicitacao,'NF') = 'NF'
			  and exists (
				select null
				  from gct.gcttb191_servico_entregue se1
				 where se1.nu_tipo_grupo = e.nu_tipo_grupo
				   and se1.nu_contrato = e.nu_contrato
				   and se1.nu_situacao_atendimento = s.nu_situacao_solicitacao
				   and se1.nu_tipo_indicador = v_nu_tipo_indicador
			  );
			  
		RAISE NOTICE 'INDICADOR % - EQUIPE: % AJUSTE: % GRUPO: % INDICADOR: % INSUMO - QUANTIDADE DE SERVICOS ENTREGUES: %', 
			v_sg_indicador, v_nu_equipe, v_nu_ajuste, v_nu_tipo_grupo, v_nu_tipo_indicador, qtTotalEntregue;


		 select
			  count(distinct s.co_solicitacao) into qtTotalContratado
			from
			  gct.gcttb177_amostra_solicitacao_equipe se
			  inner join gct.gcttb175_amostra_equipe e on (
				e.nu_equipe = se.nu_equipe
				and e.nu_fatura_amostra = se.nu_fatura_amostra
			  )
			  inner join gct.gcttb178_amostra_solicitacao s on (
				se.nu_solicitacao = s.nu_solicitacao
				and s.nu_fatura_amostra = se.nu_fatura_amostra
			  )
			  inner join gct.gcttb102_fatura f on f.nu_fatura = se.nu_fatura_amostra
			  inner join gct.gcttb192_servico_contratado se1 on (
				se1.nu_tipo_grupo = e.nu_tipo_grupo
				and se1.nu_contrato = e.nu_contrato
				and se1.nu_situacao_atendimento = s.nu_situacao_solicitacao
			  )
			where
			  se.nu_equipe = v_nu_equipe
			  and se.nu_fatura_amostra = v_nu_fatura
			  and s.dh_efetiva::date between f.dt_inicio_fatura and f.dt_final_fatura
			  and se.ic_solicitacao_compoe_fns = 'S'
			  and coalesce(se.co_falha_solicitacao,'NF') = 'NF'
			  and exists (
				select null
				  from gct.gcttb192_servico_contratado se1
				 where se1.nu_tipo_grupo = e.nu_tipo_grupo
				   and se1.nu_contrato = e.nu_contrato
				   and se1.nu_situacao_atendimento = s.nu_situacao_solicitacao
				   and se1.nu_tipo_indicador = v_nu_tipo_indicador
			  );
			  
		RAISE NOTICE 'INDICADOR % - EQUIPE: % AJUSTE: % GRUPO: % INDICADOR: % INSUMO - QUANTIDADE DE SERVICOS ATENDIDOS: %', 
			v_sg_indicador, v_nu_equipe, v_nu_ajuste, v_nu_tipo_grupo, v_nu_tipo_indicador, qtTotalContratado;

		--
		-- EXECUTAR O CALCULO DO VALOR DO INDICADOR
		--
		v_vr_indicador := null;

		if (qtTotalEntregue > 0) then
			
			v_vr_indicador := (qtTotalContratado / qtTotalEntregue);
		  
			RAISE NOTICE 'INDICADOR % - EQUIPE: % AJUSTE: % GRUPO: % INDICADOR: % VR_INDICADOR: (%/%)=%', 
		    v_sg_indicador, v_nu_equipe, v_nu_ajuste, v_nu_tipo_grupo, v_nu_tipo_indicador, qtTotalContratado, qtTotalEntregue, v_vr_indicador;
		
		end if;

		--
		-- GRAVAR O INDICADOR
		--
    PERFORM gct.gctfn343_registrar_vl_ind_equipe_ajuste(v_nu_ajuste, v_nu_fatura, v_nu_equipe, v_nu_tipo_grupo, v_nu_tipo_indicador, v_vr_indicador);

	end if;
END;
$function$;

alter function gct.gctfn216_indicador_planejamento_ajuste(v_nu_equipe numeric, v_nu_tipo_grupo numeric, v_nu_fatura numeric, v_nu_ajuste numeric) owner to gct;

--------------------------------------------------------------------------------
-- -- gctfn217_indicador_produtividade_ajuste
-- --------------------------------------------------------------------------------

-- drop function if exists gct.gctfn217_indicador_produtividade_ajuste(v_nu_equipe numeric, v_nu_tipo_grupo numeric, v_nu_fatura numeric, v_nu_ajuste numeric);

CREATE OR REPLACE FUNCTION gct.gctfn217_indicador_produtividade_ajuste(v_nu_equipe numeric, v_nu_tipo_grupo numeric, v_nu_fatura numeric, v_nu_ajuste numeric)
 RETURNS void
 LANGUAGE plpgsql
AS $function$

/**

RELEASE NOTES

RTC 23452881 - SIGCT - Melhoria Calculo dos Indicadores de Qualidade

*/

DECLARE

	v_sg_indicador character varying(6);

	v_vr_indicador numeric;
	v_nu_tipo_indicador numeric;
	v_nu_contrato numeric;
	v_no_tipo_indicador character varying(100);
	v_sg_tipo_indicador character varying(6);
	v_dt_inicio_fatura date;
	v_dt_final_fatura date;

	--
	-- VARIAVEIS DOS INSUMOS
	--
	v_qt_insumo_1 numeric;
	v_qt_insumo_2 numeric;

BEGIN

	v_sg_indicador := 'IPRECQ';

	--
	-- PERIODO DE FATURAMENTO
	--
	select
		dt_inicio_fatura,
		dt_final_fatura
	into 
	  v_dt_inicio_fatura,
		v_dt_final_fatura
	from
		gct.gcttb102_fatura 
	where
		nu_fatura = v_nu_fatura;

	--
	-- CONFIGURACAO DO INDICADOR
	--
	select
		ti.nu_tipo_indicador,
		ti.no_tipo_indicador,
		ti.sg_tipo_indicador,
		gi.nu_contrato 
	into 
	  v_nu_tipo_indicador,
		v_no_tipo_indicador,
		v_sg_tipo_indicador,
		v_nu_contrato
	from
		gct.gcttb010_contrato c
		inner join gct.gcttb033_grupo_contrato gc on (c.nu_contrato = gc.nu_contrato)
		inner join gct.gcttb115_grupo_indicador gi on (
			gi.nu_tipo_grupo = gc.nu_tipo_grupo
			and gi.nu_contrato = gc.nu_contrato
		)
		inner join gct.gcttb112_tipo_indicador ti on (ti.nu_tipo_indicador = gi.nu_tipo_indicador)
		inner join gct.gcttb175_amostra_equipe e on (e.nu_contrato = c.nu_contrato)
	where
		sg_tipo_indicador = v_sg_indicador
		and e.nu_ajuste = v_nu_ajuste
		and e.nu_equipe = v_nu_equipe
		and gc.nu_tipo_grupo = v_nu_tipo_grupo;
	
	if(v_sg_tipo_indicador is null) then
		
      RAISE NOTICE 'INDICADOR % - EQUIPE: % AJUSTE: % GRUPO: % INDICADOR % NAO CONFIGURADO.', 
        v_sg_indicador, v_nu_ajuste, v_nu_equipe, v_nu_tipo_grupo, v_sg_indicador;
	
	else
		
		RAISE NOTICE 'INDICADOR % - EQUIPE: % AJUSTE: % GRUPO: % INDICADOR: % PERIODO FATURAMENTO: % a %', 
			v_sg_indicador, v_nu_equipe, v_nu_ajuste, v_nu_tipo_grupo, v_nu_tipo_indicador, v_dt_inicio_fatura, v_dt_final_fatura;
		
		--
		-- OBTER INSUMOS DO CALCULO
		--

		v_qt_insumo_1 := 1;
		v_qt_insumo_2 := 1;

		RAISE NOTICE 'INDICADOR % - EQUIPE: % AJUSTE: % GRUPO: % INDICADOR: % INSUMO: %', 
			v_sg_indicador, v_nu_equipe, v_nu_ajuste, v_nu_tipo_grupo, v_nu_tipo_indicador, v_qt_insumo_1;

		RAISE NOTICE 'INDICADOR % - EQUIPE: % AJUSTE: % GRUPO: % INDICADOR: % INSUMO: %', 
			v_sg_indicador, v_nu_equipe, v_nu_ajuste, v_nu_tipo_grupo, v_nu_tipo_indicador, v_qt_insumo_2;

		--
		-- EXECUTAR O CALCULO DO VALOR DO INDICADOR
		--
		v_vr_indicador := null;

    if (v_qt_insumo_1 > 0) then
			
			v_vr_indicador := v_qt_insumo_2 / v_qt_insumo_1;
		  
			RAISE NOTICE 'INDICADOR % - EQUIPE: % AJUSTE: % GRUPO: % INDICADOR: % VR_INDICADOR: (%/%)=%', 
		    v_sg_indicador, v_nu_equipe, v_nu_ajuste, v_nu_tipo_grupo, v_nu_tipo_indicador, v_qt_insumo_2, v_qt_insumo_1, v_vr_indicador;
		
		end if;

		--
		-- GRAVAR O INDICADOR
		--
    PERFORM gct.gctfn343_registrar_vl_ind_equipe_ajuste(v_nu_ajuste, v_nu_fatura, v_nu_equipe, v_nu_tipo_grupo, v_nu_tipo_indicador, v_vr_indicador);

	end if;
END;
$function$;

alter function gct.gctfn217_indicador_produtividade_ajuste(v_nu_equipe numeric, v_nu_tipo_grupo numeric, v_nu_fatura numeric, v_nu_ajuste numeric) owner to gct;

--------------------------------------------------------------------------------
-- -- gctfn218_indicador_turnover_ajuste
-- --------------------------------------------------------------------------------

-- drop function if exists gct.gctfn218_indicador_turnover_ajuste(v_nu_equipe numeric, v_nu_tipo_grupo numeric, v_nu_fatura numeric, v_nu_ajuste numeric);

CREATE OR REPLACE FUNCTION gct.gctfn218_indicador_turnover_ajuste(v_nu_equipe numeric, v_nu_tipo_grupo numeric, v_nu_fatura numeric, v_nu_ajuste numeric)
 RETURNS void
 LANGUAGE plpgsql
AS $function$

/**

RELEASE NOTES

RTC 23452881 - SIGCT - Melhoria Calculo dos Indicadores de Qualidade

*/

DECLARE

	v_sg_indicador character varying(6);

	v_vr_indicador numeric;
	v_nu_tipo_indicador numeric;
	v_nu_contrato numeric;
	v_no_tipo_indicador character varying(100);
	v_sg_tipo_indicador character varying(6);
	v_dt_inicio_fatura date;
	v_dt_final_fatura date;

	--
	-- VARIAVEIS DOS INSUMOS
	--
	v_qt_insumo_1 numeric;
	v_qt_insumo_2 numeric;

BEGIN

	v_sg_indicador := 'ITDCQ';

	--
	-- PERIODO DE FATURAMENTO
	--
	select
		dt_inicio_fatura,
		dt_final_fatura
	into 
	  v_dt_inicio_fatura,
		v_dt_final_fatura
	from
		gct.gcttb102_fatura 
	where
		nu_fatura = v_nu_fatura;

	--
	-- CONFIGURACAO DO INDICADOR
	--
	select
		ti.nu_tipo_indicador,
		ti.no_tipo_indicador,
		ti.sg_tipo_indicador,
		gi.nu_contrato 
	into 
	  v_nu_tipo_indicador,
		v_no_tipo_indicador,
		v_sg_tipo_indicador,
		v_nu_contrato
	from
		gct.gcttb010_contrato c
		inner join gct.gcttb033_grupo_contrato gc on (c.nu_contrato = gc.nu_contrato)
		inner join gct.gcttb115_grupo_indicador gi on (
			gi.nu_tipo_grupo = gc.nu_tipo_grupo
			and gi.nu_contrato = gc.nu_contrato
		)
		inner join gct.gcttb112_tipo_indicador ti on (ti.nu_tipo_indicador = gi.nu_tipo_indicador)
		inner join gct.gcttb175_amostra_equipe e on (e.nu_contrato = c.nu_contrato)
	where
		sg_tipo_indicador = v_sg_indicador
		and e.nu_ajuste = v_nu_ajuste
		and e.nu_equipe = v_nu_equipe
		and gc.nu_tipo_grupo = v_nu_tipo_grupo;
	
	if(v_sg_tipo_indicador is null) then
		
      RAISE NOTICE 'INDICADOR % - EQUIPE: % AJUSTE: % GRUPO: % INDICADOR % NAO CONFIGURADO.', 
        v_sg_indicador, v_nu_ajuste, v_nu_equipe, v_nu_tipo_grupo, v_sg_indicador;
	
	else
		
		RAISE NOTICE 'INDICADOR % - EQUIPE: % AJUSTE: % GRUPO: % INDICADOR: % PERIODO FATURAMENTO: % a %', 
			v_sg_indicador, v_nu_equipe, v_nu_ajuste, v_nu_tipo_grupo, v_nu_tipo_indicador, v_dt_inicio_fatura, v_dt_final_fatura;
		
		--
		-- OBTER INSUMOS DO CALCULO
		--

		v_qt_insumo_1 := 1;
		v_qt_insumo_2 := 1;

		RAISE NOTICE 'INDICADOR % - EQUIPE: % AJUSTE: % GRUPO: % INDICADOR: % INSUMO: %', 
			v_sg_indicador, v_nu_equipe, v_nu_ajuste, v_nu_tipo_grupo, v_nu_tipo_indicador, v_qt_insumo_1;

		RAISE NOTICE 'INDICADOR % - EQUIPE: % AJUSTE: % GRUPO: % INDICADOR: % INSUMO: %', 
			v_sg_indicador, v_nu_equipe, v_nu_ajuste, v_nu_tipo_grupo, v_nu_tipo_indicador, v_qt_insumo_2;

		--
		-- EXECUTAR O CALCULO DO VALOR DO INDICADOR
		--
		v_vr_indicador := null;

    if (v_qt_insumo_1 > 0) then
			
			v_vr_indicador := v_qt_insumo_2 / v_qt_insumo_1;
		  
			RAISE NOTICE 'INDICADOR % - EQUIPE: % AJUSTE: % GRUPO: % INDICADOR: % VR_INDICADOR: (%/%)=%', 
		    v_sg_indicador, v_nu_equipe, v_nu_ajuste, v_nu_tipo_grupo, v_nu_tipo_indicador, v_qt_insumo_2, v_qt_insumo_1, v_vr_indicador;
		
		end if;

		--
		-- GRAVAR O INDICADOR
		--
    PERFORM gct.gctfn343_registrar_vl_ind_equipe_ajuste(v_nu_ajuste, v_nu_fatura, v_nu_equipe, v_nu_tipo_grupo, v_nu_tipo_indicador, v_vr_indicador);

	end if;
END;
$function$;

alter function gct.gctfn218_indicador_turnover_ajuste(v_nu_equipe numeric, v_nu_tipo_grupo numeric, v_nu_fatura numeric, v_nu_ajuste numeric) owner to gct;

--------------------------------------------------------------------------------
-- -- gctfn219_calcular_fator_nivel_servico_ajuste
-- --------------------------------------------------------------------------------

-- drop function if exists gct.gctfn219_calcular_fator_nivel_servico_ajuste(p_nu_equipe numeric, p_nu_fatura numeric, p_nu_ajuste numeric);

CREATE OR REPLACE FUNCTION gct.gctfn219_calcular_fator_nivel_servico_ajuste(p_nu_equipe numeric, p_nu_fatura numeric, p_nu_ajuste numeric)
 RETURNS numeric
 LANGUAGE plpgsql
AS $function$

/**

RELEASE NOTES

RTC 23452881 - SIGCT - Melhoria no Cálculo dos Indicadores de Qualidade

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

alter function gct.gctfn219_calcular_fator_nivel_servico_ajuste(p_nu_equipe numeric, p_nu_fatura numeric, p_nu_ajuste numeric) owner to gct;

--------------------------------------------------------------------------------
-- -- gctfn220_calcular_bonus_ajuste 
-- --------------------------------------------------------------------------------

-- drop function if exists gct.gctfn220_calcular_bonus_ajuste(v_nu_equipe numeric, v_nu_tipo_grupo numeric, v_nu_fatura numeric, v_nu_ajuste numeric);

CREATE OR REPLACE FUNCTION gct.gctfn220_calcular_bonus_ajuste(v_nu_equipe numeric, v_nu_tipo_grupo numeric, v_nu_fatura numeric, v_nu_ajuste numeric)
 RETURNS void
 LANGUAGE plpgsql
AS $function$

/**

RELEASE NOTES

RTC 23452881 - SIGCT - Melhoria no Cálculo dos Indicadores de Qualidade

*/

DECLARE

BEGIN

END;
$function$;

alter function gct.gctfn220_calcular_bonus_ajuste(v_nu_equipe numeric, v_nu_tipo_grupo numeric, v_nu_fatura numeric, v_nu_ajuste numeric) owner to gct;

--------------------------------------------------------------------------------
-- -- gctfn221_calcular_descontos_ajuste
-- --------------------------------------------------------------------------------

-- drop function if exists gct.gctfn221_calcular_descontos_ajuste(v_nu_equipe numeric, v_nu_tipo_grupo numeric, v_nu_fatura numeric, v_nu_ajuste numeric);

CREATE OR REPLACE FUNCTION gct.gctfn221_calcular_descontos_ajuste(v_nu_equipe numeric, v_nu_tipo_grupo numeric, v_nu_fatura numeric, v_nu_ajuste numeric)
 RETURNS void
 LANGUAGE plpgsql
AS $function$

/**

RELEASE NOTES

RTC 23452881 - SIGCT - Melhoria no Cálculo dos Indicadores de Qualidade

*/

DECLARE

BEGIN

END;
$function$;

alter function gct.gctfn221_calcular_descontos_ajuste(v_nu_equipe numeric, v_nu_tipo_grupo numeric, v_nu_fatura numeric, v_nu_ajuste numeric) owner to gct;


--
-- FIM
--

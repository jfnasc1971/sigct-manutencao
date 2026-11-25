--
-- INICIO
--

drop function if exists gct.gctfn303_calcular_indicador(dtbaseindicador date, p_nu_contrato numeric, p_nu_equipe numeric);
drop function if exists gct.gctfn334_calcular_indicador_ajuste(p_nu_ajuste numeric, p_nu_equipe numeric);
drop function if exists gct.gctfn204_indicador_qualidade(v_nu_equipe numeric, v_nu_tipo_grupo numeric, v_nu_fatura numeric);
drop function if exists gct.gctfn205_indicador_prazo(v_nu_equipe numeric, v_nu_tipo_grupo numeric, v_nu_fatura numeric);
drop function if exists gct.gctfn206_indicador_planejamento(v_nu_equipe numeric, v_nu_tipo_grupo numeric, v_nu_fatura numeric);
drop function if exists gct.gctfn207_indicador_produtividade(v_nu_equipe numeric, v_nu_tipo_grupo numeric, v_nu_fatura numeric);
drop function if exists gct.gctfn208_indicador_turnover(v_nu_equipe numeric, v_nu_tipo_grupo numeric, v_nu_fatura numeric);
drop function if exists gct.gctfn209_calcular_fator_nivel_servico(p_nu_equipe numeric, p_nu_fatura numeric, p_dt_referencia date, p_nu_matricula numeric);
drop function if exists gct.gctfn210_calcular_bonus(dtbase date, p_nu_contrato numeric, p_nu_equipe numeric);
drop function if exists gct.gctfn211_calcular_descontos(dtbase date, p_nu_contrato numeric, p_nu_equipe numeric);
drop function if exists gct.gctfn214_indicador_qualidade_ajuste(v_nu_equipe numeric, v_nu_tipo_grupo numeric, v_nu_fatura numeric, v_nu_ajuste numeric);
drop function if exists gct.gctfn215_indicador_prazo_ajuste(v_nu_equipe numeric, v_nu_tipo_grupo numeric, v_nu_fatura numeric, v_nu_ajuste numeric);
drop function if exists gct.gctfn216_indicador_planejamento_ajuste(v_nu_equipe numeric, v_nu_tipo_grupo numeric, v_nu_fatura numeric, v_nu_ajuste numeric);
drop function if exists gct.gctfn217_indicador_produtividade_ajuste(v_nu_equipe numeric, v_nu_tipo_grupo numeric, v_nu_fatura numeric, v_nu_ajuste numeric);
drop function if exists gct.gctfn218_indicador_turnover_ajuste(v_nu_equipe numeric, v_nu_tipo_grupo numeric, v_nu_fatura numeric, v_nu_ajuste numeric);
drop function if exists gct.gctfn219_calcular_fator_nivel_servico_ajuste(p_nu_equipe numeric, p_nu_fatura numeric, p_nu_ajuste numeric);
drop function if exists gct.gctfn220_calcular_bonus_ajuste(v_nu_equipe numeric, v_nu_tipo_grupo numeric, v_nu_fatura numeric, v_nu_ajuste numeric);
drop function if exists gct.gctfn221_calcular_descontos_ajuste(v_nu_equipe numeric, v_nu_tipo_grupo numeric, v_nu_fatura numeric, v_nu_ajuste numeric);

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

RTC19118958 - SIGCT - Contratos da Qualidade_(KEEGO/MONTREAL/WIPRO) Ativação dos Indicadores
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
      PERFORM gct.gctfn342_indicador_desempenho_ajuste(equipe.nu_equipe, equipe.nu_tipo_grupo, equipe.nu_fatura_paga, p_nu_ajuste);

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


--
-- FIM
--

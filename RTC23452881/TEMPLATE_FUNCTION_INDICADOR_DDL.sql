--------------------------------------------------------------------------------
-- -- gctfn308_indicador_estoque
-- --------------------------------------------------------------------------------

-- drop function if exists gct.gctfn999_indicador_xxxx(v_nu_equipe numeric, v_nu_tipo_grupo numeric, v_nu_fatura numeric);

CREATE OR REPLACE FUNCTION gct.gctfn999_indicador_xxxx(v_nu_equipe numeric, v_nu_tipo_grupo numeric, v_nu_fatura numeric)
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

  v_sg_indicador := 'IEQQET';

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

      RAISE NOTICE 'INDICADOR IEQQET - CALCULO INDICADOR EQUIPE: % | VALOR: %',v_nu_equipe,v_vr_indicador;
      PERFORM gct.gctfn314_registrar_valor_indicador_equipe(v_nu_fatura,v_nu_equipe,v_nu_tipo_grupo,v_nu_tipo_indicador,v_vr_indicador);

  end if;
END;

$function$;

alter function gct.gctfn999_indicador_xxxx(v_nu_equipe numeric, v_nu_tipo_grupo numeric, v_nu_fatura numeric) owner to gct;


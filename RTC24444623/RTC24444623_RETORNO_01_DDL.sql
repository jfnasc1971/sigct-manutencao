--
-- INICIO
--

drop function if exists gct.gctfn311_indicador_produtividade(nuequipe numeric, nutipogrupo numeric, nufatura numeric);
drop function if exists gct.gctfn313_indicador_desempenho(nuequipe numeric, nutipogrupo numeric, nufatura numeric);
drop function if exists gct.gctfn340_indicador_produtividade_ajuste(nuequipe numeric, nutipogrupo numeric, nufatura numeric, nuajuste numeric);
drop function if exists gct.gctfn342_indicador_desempenho_ajuste(nuequipe numeric, nutipogrupo numeric, nufatura numeric, nuajuste numeric);

--------------------------------------------------------------------------------
-- -- gctfn311_indicador_produtividade
-- --------------------------------------------------------------------------------

-- drop function if exists gct.gctfn311_indicador_produtividade(nuequipe numeric, nutipogrupo numeric, nufatura numeric);

CREATE OR REPLACE FUNCTION gct.gctfn311_indicador_produtividade(nuequipe numeric, nutipogrupo numeric, nufatura numeric)
 RETURNS void
 LANGUAGE plpgsql
AS $function$

/*

RELEASE NOTES

RTC 19423998 - SIGCT - Erro na rotina de ajuste dos contratos ágeis
RTC 17631087 - SIGCT - Erro em Empenho gerado automaticamente
RTC 17460184 - Contratos ageis - equipes BRE202100042 e CTE202100004 nao geraram Termos Mensais para faturas de Abril

*/

  DECLARE
    registro                         RECORD;
    membros                          RECORD;
    vrIndicador                      numeric;
    vrIndicadorEquipe                numeric;
    qtFaturamento                    numeric;
    nuTipoIndicador                  numeric;
    noTipoIndicador                  character varying(100);
    sgTipoIndicador                  character(6);
    vrCalculo                        numeric;
    vrFat                            numeric;
    vrTotalInicadorCicloTrabalho     numeric;
    qtTotalIndicadorCicloTrabalho    numeric;
    nuVigenciaEncontrada             numeric;
    qtDiasSprint                     numeric;
    qtTotalExtraordinarios           numeric; 
    qtDiasTrabalhadoAtendimento      numeric;
    dtInicioVigenciaMembro           date;
    dtFinalVigenciaMembro            date;
    qtTotalMembrosRecuperados        numeric;
    dtiniciofatura                   date;
    dtfinalfatura                    date;
    vrLimiteMaximoIndicador          numeric;
    qtTotalVigenciaMembrosEncontrada numeric;
    qtDiasVigenciaMembro             numeric;
    vrVigencia                       numeric;
    qtDiasEquipeTrabalho             numeric;
    qtMembroEquipe                   numeric;
    qtMembrosVigentes                numeric;
    qtMembroVigenciaUnica            numeric;
    qtDiasFaturamento                numeric;
                
  BEGIN

    select
      f.dt_inicio_fatura,
      f.dt_final_fatura 
    into 
      dtiniciofatura,
      dtfinalfatura
    from
      gct.gcttb102_fatura f
    where
      nu_fatura = nufatura;
    
    vrTotalInicadorCicloTrabalho := 0;
    qtTotalIndicadorCicloTrabalho := 0;
    qtTotalExtraordinarios = 0;
    
    select
      ti.nu_tipo_indicador,
      ti.no_tipo_indicador,
      ti.sg_tipo_indicador,
      gi.vr_fator_ajuste,
      gi.vr_limite_maximo_indicador into nuTipoIndicador,
      noTipoIndicador,
      sgTipoIndicador,
      vrFat,
      vrLimiteMaximoIndicador
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
      ti.sg_tipo_indicador = 'IEQPR'
      and e.nu_fatura_amostra = nufatura
      and e.nu_equipe = nuequipe
      and gc.nu_tipo_grupo = nutipogrupo;

    --Recuperar o qtFaturamento do indicador 21 Desempenho ('IEQDEP') que eh o unico tem o parametro.
    select
      coalesce(gi.qt_faturamento, 0) into qtFaturamento
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
      sg_tipo_indicador = 'IEQDEP'
      and e.nu_fatura_amostra = nufatura
      and e.nu_equipe = nuequipe
      and gc.nu_tipo_grupo = nutipogrupo;
    
    if (sgTipoIndicador is null) then
    
      RAISE NOTICE 'INDICADOR IEQPR - NAO CONFIGURADO PARA O GRUPO: %',nutipogrupo;
    
    else            

      RAISE NOTICE 'INDICADOR IEQPR - EQUIPE: % | FATURA: % % | GRUPO: %',
        nuEquipe, nufatura, dtfinalfatura, nutipogrupo;

      FOR registro IN
        
        select
          sum(nu_tamanho_servico) as vrTotalTamanhoServico,
          ct.nu_ciclo_trabalho,
          ct.nu_equipe,
          ct.dt_inicio_ciclo_trabalho,
          ct.dt_alvo_ciclo_trabalho,
          ai.co_sitio,
          gc.ic_calculo_pro_rata,
          gc.ic_dias_calculo_pagamento
        from
          gct.gcttb177_amostra_solicitacao_equipe ase
          inner join gct.gcttb176_amostra_ciclo_trabalho ct on (
            ct.nu_ciclo_trabalho = ase.nu_ciclo_trabalho
            and ct.nu_equipe = ase.nu_equipe
          )
          inner join gct.gcttb175_amostra_equipe ae on (ae.nu_equipe = ase.nu_equipe)
          inner join gct.gcttb033_grupo_contrato gc on (
            gc.nu_contrato = ae.nu_contrato
            and gc.nu_tipo_grupo = ae.nu_tipo_grupo
          )
          inner join gct.gcttb001_area_interna ai on (ai.nu_area_interna = ae.nu_area_interna)
        where
          ct.nu_equipe = nuEquipe
          and ase.nu_fatura_amostra = nufatura
          and ct.nu_fatura_amostra = ase.nu_fatura_amostra
          and ae.nu_fatura_amostra = ase.nu_fatura_amostra
          and (
            date(ct.dt_alvo_ciclo_trabalho) between dtInicioFatura
            and dtFinalfatura
          )
          and ct.nu_situacao_ciclo_trabalho = 2 --sprint concluida
          and ct.co_falha_ciclo_trabalho = 'NF' --sprint que nao houve falha
          and ct.nu_ciclo_trabalho in (
            select
              distinct se.nu_ciclo_trabalho
            from
              gct.gcttb177_amostra_solicitacao_equipe se
            where
              se.nu_equipe = ct.nu_equipe
              and se.nu_ciclo_trabalho = ct.nu_ciclo_trabalho
              and se.nu_fatura_amostra = ct.nu_fatura_amostra
              and se.ic_solicitacao_compoe_fns = 'S'
          ) --considerar apenas solicitacoes com marcacao que compoem o FNS. 
        group by
          ct.nu_ciclo_trabalho,
          ct.nu_equipe,
          ct.dt_inicio_ciclo_trabalho,
          ct.dt_alvo_ciclo_trabalho,
          ai.co_sitio,
          gc.ic_calculo_pro_rata,
          gc.ic_dias_calculo_pagamento
        order by
          ct.dt_inicio_ciclo_trabalho      
      
      LOOP

        qtMembrosVigentes := 0;
        qtMembroVigenciaUnica := 0;
        qtTotalMembrosRecuperados :=0;
        vrVigencia := 0;

        --Nao esquecer da funcao date() antes das datas de equipe e ciclo de trabalho.
        --A condicao (where) deste select deve ser exatamente a mesma do select de baixo.
        select
          count(*) into qtTotalVigenciaMembrosEncontrada
        from
          gct.gcttb183_amostra_qntde_membros_equipe
        where
          nu_equipe = registro.nu_equipe
          and nu_fatura_amostra = nufatura
          and (
            (
              date(registro.dt_inicio_ciclo_trabalho) >= dt_inicio_vigencia_membros
              and date(registro.dt_inicio_ciclo_trabalho) <= dt_final_vigencia_membros
            )
            or (
              date(registro.dt_alvo_ciclo_trabalho) >= dt_inicio_vigencia_membros
              and date(registro.dt_inicio_ciclo_trabalho) <= dt_final_vigencia_membros
            )
            or (
              date(registro.dt_inicio_ciclo_trabalho) >= dt_inicio_vigencia_membros
              and dt_final_vigencia_membros is null
            )
            or (
              date(registro.dt_alvo_ciclo_trabalho) >= dt_inicio_vigencia_membros
              and dt_final_vigencia_membros is null
            )
          );

        RAISE NOTICE 'INDICADOR IEQPR - EQUIPE: % | CICLO: % | TAMANHO: % | VIGENCIA DE MEMBROS: % | PERIODO: % A %',
          registro.nu_equipe, registro.nu_ciclo_trabalho, registro.vrTotalTamanhoServico, qtTotalVigenciaMembrosEncontrada, 
            dtiniciofatura, dtfinalfatura;
      
        FOR membros IN
          
          select
            nu_equipe,
            dt_inicio_vigencia_membros,
            dt_final_vigencia_membros,
            qt_membros_equipe
          from
            gct.gcttb183_amostra_qntde_membros_equipe
          where
            nu_equipe = registro.nu_equipe
            and nu_fatura_amostra = nufatura
            and (
              (
                date(registro.dt_inicio_ciclo_trabalho) >= dt_inicio_vigencia_membros
                and date(registro.dt_inicio_ciclo_trabalho) <= dt_final_vigencia_membros
              )
              or (
                date(registro.dt_alvo_ciclo_trabalho) >= dt_inicio_vigencia_membros
                and date(registro.dt_inicio_ciclo_trabalho) <= dt_final_vigencia_membros
              )
              or (
                date(registro.dt_inicio_ciclo_trabalho) >= dt_inicio_vigencia_membros
                and dt_final_vigencia_membros is null
              )
              or (
                date(registro.dt_alvo_ciclo_trabalho) >= dt_inicio_vigencia_membros
                and dt_final_vigencia_membros is null
              )
            )
          order by
            dt_inicio_vigencia_membros          
        
        LOOP

          ---#### Calculo PRORATA                      
          dtInicioVigenciaMembro := membros.dt_inicio_vigencia_membros;
          if(membros.dt_inicio_vigencia_membros < registro.dt_inicio_ciclo_trabalho) then
            dtInicioVigenciaMembro := registro.dt_inicio_ciclo_trabalho;
          end if;

          dtFinalVigenciaMembro := membros.dt_final_vigencia_membros;
          if(membros.dt_final_vigencia_membros is null or membros.dt_final_vigencia_membros > registro.dt_alvo_ciclo_trabalho) then
            dtFinalVigenciaMembro := registro.dt_alvo_ciclo_trabalho;
          end if;
   
          select gct.gctfn305_dias_entre_data(registro.dt_inicio_ciclo_trabalho::date,
                                              registro.dt_alvo_ciclo_trabalho::date,
                                              registro.co_sitio, 
                                              registro.ic_dias_calculo_pagamento) into qtDiasSprint;
  
          if(qtDiasSprint <> 0 and registro.ic_calculo_pro_rata = 'S') then

            select gct.gctfn305_dias_entre_data( dtInicioVigenciaMembro, dtFinalVigenciaMembro, 
                               registro.co_sitio,registro.ic_dias_calculo_pagamento) 
                               into qtDiasVigenciaMembro;

            vrVigencia :=  ((membros.qt_membros_equipe::decimal / (qtDiasSprint)) * qtDiasVigenciaMembro);
            qtMembrosVigentes := qtMembrosVigentes + vrVigencia;

          end if;

          RAISE NOTICE 'INDICADOR IEQPR - EQUIPE: % | CICLO: % | VIGENCIA: % a % | MEMBROS: % | QT. DIAS CICLO: % | DIAS VIGENCIA MEMBRO: %', 
            registro.nu_equipe, registro.nu_ciclo_trabalho, dtInicioVigenciaMembro, dtFinalVigenciaMembro, membros.qt_membros_equipe, 
            qtDiasSprint, qtDiasVigenciaMembro;

          qtTotalMembrosRecuperados := qtTotalMembrosRecuperados + 1;
          qtMembroVigenciaUnica := membros.qt_membros_equipe;
        END LOOP;

      if (qtTotalMembrosRecuperados = 1) then
        qtMembrosVigentes := qtMembroVigenciaUnica;
      end if;

      if (qtTotalVigenciaMembrosEncontrada = 1) then
        qtMembroEquipe := qtMembroVigenciaUnica;
      else 
        qtMembroEquipe := qtMembrosVigentes;  
      end if; 

        IF qtMembrosVigentes > 0 THEN
          
          select 
            sum(coalesce(a.qt_dia_servico_extra,0::numeric)) into qtTotalExtraordinarios
          from 
            gct.gcttb176_amostra_ciclo_trabalho ct
            inner join gct.gcttb180_amostra_ausencia_servico_extra a on (
              a.nu_ciclo_trabalho = ct.nu_ciclo_trabalho
              and a.nu_equipe = ct.nu_equipe
              and a.nu_fatura_amostra = ct.nu_fatura_amostra
            )
            inner join gct.gcttb102_fatura f on f.nu_fatura = a.nu_fatura        
          where 
            ct.nu_equipe = registro.nu_equipe
            and a.nu_fatura_amostra = nufatura
            and a.nu_fatura <= nufatura
            and ct.nu_ciclo_trabalho = registro.nu_ciclo_trabalho;
        
        END IF;
            
        if qtTotalExtraordinarios is null then
          qtTotalExtraordinarios = 0;
        end if;
                  
        qtDiasTrabalhadoAtendimento := qtDiasSprint + (qtTotalExtraordinarios / qtMembrosVigentes);

        if(registro.vrTotalTamanhoServico > 0 and qtMembrosVigentes > 0 and qtDiasTrabalhadoAtendimento > 0) then
          vrIndicador = (registro.vrTotalTamanhoServico / qtMembrosVigentes / qtDiasTrabalhadoAtendimento) / vrFat;
        
          /*
          ProdutividadeSprint: para o cálculo da produtividade de uma Sprint o valor do percentual resultante está limitado a 
          resultado máximo de XXX por cento da produtividade esperada. 
          Caso o resultado ultrapasse este valor, será considerado então este limite máximo.  
          */
          RAISE NOTICE 'INDICADOR IEQPR - EQUIPE: % | CICLO: % | CALCULO: (% / % / %) / %', 
            nuEquipe, registro.nu_ciclo_trabalho, registro.vrTotalTamanhoServico, qtMembrosVigentes, qtDiasTrabalhadoAtendimento, vrFat;

          if(vrIndicador > vrLimiteMaximoIndicador) then
            RAISE NOTICE 'INDICADOR IEQPR - EQUIPE: % | CICLO: % | VALOR: % REDUZIDO PARA: % (VR_MAXIMO_INDICADOR)', 
              nuEquipe, registro.nu_ciclo_trabalho, vrIndicador, vrLimiteMaximoIndicador;
            vrIndicador := vrLimiteMaximoIndicador;             
          end if;

          vrTotalInicadorCicloTrabalho := vrTotalInicadorCicloTrabalho + vrIndicador;
          qtTotalIndicadorCicloTrabalho := qtTotalIndicadorCicloTrabalho + 1;

          PERFORM gct.gctfn315_registrar_valor_indicador_ciclo_trabalho(nuFatura,nuEquipe,registro.nu_ciclo_trabalho,
            nutipogrupo,nuTipoIndicador,vrIndicador);            

          RAISE NOTICE 'INDICADOR IEQPR - EQUIPE: % | CICLO: % | VALOR: %', 
            nuEquipe, registro.nu_ciclo_trabalho, vrIndicador;

        end if;
      END LOOP;

      if(qtTotalIndicadorCicloTrabalho > 0) then
        vrIndicadorEquipe := vrTotalInicadorCicloTrabalho / qtTotalIndicadorCicloTrabalho;
        PERFORM gct.gctfn314_registrar_valor_indicador_equipe(nuFatura,nuEquipe,nutipogrupo,nuTipoIndicador,vrIndicadorEquipe);
        RAISE NOTICE 'INDICADOR IEQPR - EQUIPE: % | CALCULO ( % / % )', nuEquipe, vrTotalInicadorCicloTrabalho,qtTotalIndicadorCicloTrabalho;  
      end if;

      if vrIndicadorEquipe is not null then
        RAISE NOTICE 'INDICADOR IEQPR - EQUIPE: % | VALOR INDICADOR: %', nuEquipe, vrIndicadorEquipe;
        PERFORM gct.gctfn314_registrar_valor_indicador_equipe(nuFatura,nuEquipe,nutipogrupo,nuTipoIndicador,vrIndicadorEquipe);
      else
        RAISE NOTICE 'INDICADOR IEQPR - EQUIPE: % | VALOR INDICADOR: % (NAO GRAVADO)', nuEquipe, vrIndicadorEquipe;  
      end if;
    end if; 
  END;

$function$;

alter function gct.gctfn311_indicador_produtividade(nuequipe numeric, nutipogrupo numeric, nufatura numeric) owner to gct;

--------------------------------------------------------------------------------
-- -- gctfn313_indicador_desempenho
-- --------------------------------------------------------------------------------

-- drop function if exists gct.gctfn313_indicador_desempenho(nuequipe numeric, nutipogrupo numeric, nufatura numeric);

CREATE OR REPLACE FUNCTION gct.gctfn313_indicador_desempenho(nuequipe numeric, nutipogrupo numeric, nufatura numeric)
 RETURNS void
 LANGUAGE plpgsql
AS $function$

/**

RELEASE NOTES

RTC 20673900 - Solicitação de Avaliação de Termos de Ajustes - BRE202200168
RTC 19423998 - SIGCT - Erro na rotina de ajuste dos contratos ágeis
RTC 17882046 - SIGCT - Erro no processamento de amostra para calculo de Indicadores (GECEQ)
RTC 17631087 - SIGCT - Erro em Empenho gerado automaticamente
RTC 17519356 - [Ref AcC 17478927] Termo com redução devido a FNS tendo motivo do atendimento não compor cálculo do indicador
RTC 17460184 - Contratos ageis - equipes BRE202100042 e CTE202100004 nao geraram Termos Mensais para faturas de Abril

*/
    
DECLARE

  vrIndicador numeric;
  nuTipoIndicador numeric;
  noTipoIndicador character varying(100);
  sgTipoIndicador character(6);
  vrPesoTipoIndicador numeric;
  vrIndicadorComPeso numeric;
  vrSomaPesoIndicador numeric;
  qtTotalEncotrado numeric;
  nuTipoIndicadorMedia numeric;
  qtFaturamento numeric;
  dtiniciofatura date;
  dtfinalfatura date;
  --
  vrCalculoIndicador numeric;
  vrSomaIndicador numeric;
  icTipoAtendimento character(1);
  indicadores record;
                    
BEGIN

  select
    dt_inicio_fatura,
    dt_final_fatura
  from
    gct.gcttb102_fatura into dtiniciofatura,
    dtfinalfatura
  where
    nu_fatura = nufatura;

  -- Recuperar os paramentros do indicador. Entretanto, se o "gi.qt_faturamento" for null transformo para zero.
  select
    ti.nu_tipo_indicador,
    ti.no_tipo_indicador,
    ti.sg_tipo_indicador,
    gi.nu_tipo_indicador_media,
    coalesce(gi.qt_faturamento, 0),
    gi.vr_peso_tipo_indicador,
    gc.ic_tipo_atendimento into nuTipoIndicador,
    noTipoIndicador,
    sgTipoIndicador,
    nuTipoIndicadorMedia,
    qtFaturamento,
    vrPesoTipoIndicador,
    icTipoAtendimento
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
    ti.sg_tipo_indicador = 'IEQDEP'
    and e.nu_fatura_amostra = nufatura
    and e.nu_equipe = nuequipe
    and gc.nu_tipo_grupo = nutipogrupo;

  --
  -- Quando tipo atedendimento eh acionamento usar os indicadores das equipes (tb172). 
  -- Quando tipo atedendimento eh sprint usar os indicadores dos ciclos (tb171).
  -- Na tabela tb172 existe calculada a media das sprints da fatura como sendo o indicador da equipe.
  -- Para o Desempenho nao usar a media da equipe, fazer a media ponderada apartir dos indicadores da sprint.
  if icTipoAtendimento = 'A' then
  --
if(sgTipoIndicador is null) then

    RAISE NOTICE 'INDICADOR IEQDEP - NAO CONFIGURADO GRUPO: %',nutipogrupo;

else
    
    RAISE NOTICE 'INDICADOR IEQDEP - EQUIPE: % GRUPO: % PERIODO FATURAMENTO: % a % TIPO ATENDIMENTO: %', 
      nuEquipe, nutipogrupo, dtInicioFatura, dtfinalfatura, icTipoAtendimento;

    vrCalculoIndicador  := 0;
    vrSomaIndicador     := 0;
    vrSomaPesoIndicador := 0;

    for indicadores in 
    (
        select
          nu_tipo_indicador,
          avg(vr_calculo_indicador) * vr_peso_tipo_indicador vr_calculo_media_peso,
          vr_peso_tipo_indicador
        from
          gct.gctvw052_valor_indicador_equipe vict
        where
          nu_equipe = nuEquipe
          and nu_tipo_grupo = nuTipoGrupo
          and vr_calculo_indicador is not null
          and nu_tipo_indicador in (
            select
              distinct ti.nu_tipo_indicador
            from
              gct.gcttb112_tipo_indicador ti
              inner join gct.gcttb115_grupo_indicador gi on (gi.nu_tipo_indicador = ti.nu_tipo_indicador)
            where
              gi.nu_contrato = vict.nu_contrato
              and nu_tipo_grupo = vict.nu_tipo_grupo
              and sg_tipo_indicador <> 'IEQDEP'
              and coalesce(gi.ic_apenas_faturamento_atual,'N') <> 'S'
          )
          and vict.dt_referencia :: date <= dtFinalFatura :: date
          and date(vict.dt_referencia) >= (
            dtFinalFatura :: date - ((qtFaturamento - 1) * '1 Month' :: interval)
          )
        group by
          nu_tipo_indicador,
          vr_peso_tipo_indicador
    )
    loop

        vrSomaIndicador := vrSomaIndicador + indicadores.vr_calculo_media_peso;
        vrSomaPesoIndicador := vrSomaPesoIndicador + indicadores.vr_peso_tipo_indicador;    

        RAISE NOTICE 'INDICADOR IEQDEP - EQUIPE: % | TP. INDICADOR: % | SOMENTE FATURAMENTO ATUAL: N | MEDIA: % | PESO: %', 
            nuEquipe, indicadores.nu_tipo_indicador, indicadores.vr_calculo_media_peso, 
              indicadores.vr_peso_tipo_indicador;

    end loop;

    for indicadores in 
    (
        select
          nu_tipo_indicador,
          avg(vr_calculo_indicador) * vr_peso_tipo_indicador vr_calculo_media_peso,
          vr_peso_tipo_indicador
        from
          gct.gctvw052_valor_indicador_equipe vict
        where
          nu_equipe = nuEquipe
          and nu_tipo_grupo = nuTipoGrupo
          and vr_calculo_indicador is not null
          and nu_tipo_indicador in (
            select
              distinct ti.nu_tipo_indicador
            from
              gct.gcttb112_tipo_indicador ti
              inner join gct.gcttb115_grupo_indicador gi on (gi.nu_tipo_indicador = ti.nu_tipo_indicador)
            where
              gi.nu_contrato = vict.nu_contrato
              and nu_tipo_grupo = vict.nu_tipo_grupo
              and sg_tipo_indicador <> 'IEQDEP'
              and coalesce(gi.ic_apenas_faturamento_atual,'N') = 'S'
          )
          and vict.dt_referencia :: date = dtFinalFatura :: date
        group by
          nu_tipo_indicador,
          vr_peso_tipo_indicador
    )
    loop

        vrSomaIndicador := vrSomaIndicador + indicadores.vr_calculo_media_peso;
        vrSomaPesoIndicador := vrSomaPesoIndicador + indicadores.vr_peso_tipo_indicador;    

        RAISE NOTICE 'INDICADOR IEQDEP - EQUIPE: % | TP. INDICADOR: % | SOMENTE FATURAMENTO ATUAL: S | MEDIA: % | PESO: %', 
            nuEquipe, indicadores.nu_tipo_indicador, indicadores.vr_calculo_media_peso, 
              indicadores.vr_peso_tipo_indicador;

    end loop;


    if (coalesce(vrSomaIndicador,0) <> 0 and coalesce(vrSomaPesoIndicador,0) <> 0) then

        vrCalculoIndicador := vrSomaIndicador / vrSomaPesoIndicador;

        RAISE NOTICE 'INDICADOR IEQDEP - EQUIPE: % GRUPO: % SOMA INDICADOR: % PESO INDICADOR: % VALOR INDICADOR: %', 
            nuEquipe, nutipogrupo, vrSomaIndicador, vrSomaPesoIndicador, vrCalculoIndicador;

        PERFORM gct.gctfn314_registrar_valor_indicador_equipe(nuFatura, nuEquipe, nuTipoGrupo, nuTipoIndicador, vrCalculoIndicador);

    else

        vrCalculoIndicador := null;

        RAISE NOTICE 'INDICADOR IEQDEP - EQUIPE: % GRUPO: % SOMA INDICADOR: % PESO INDICADOR: % VALOR INDICADOR: % (NAO GRAVADO)', 
            nuEquipe, nutipogrupo, vrSomaIndicador, vrSomaPesoIndicador, vrCalculoIndicador;

    end if; 

  end if; 
      --  
        else --icTipoAtendimento=S (Sprint)
      --
          if (nuTipoIndicador is null) then
              RAISE NOTICE 'INDICADOR IEQDEP - NAO CONFIGURADO PARA O GRUPO: %', nuTipoGrupo;
          else                
              RAISE NOTICE 'INDICADOR IEQDEP - EQUIPE: % GRUPO: % PERIODO FATURAMENTO: % a %', nuEquipe, nutipogrupo, dtInicioFatura, dtfinalfatura;

              vrCalculoIndicador  := 0;
              vrSomaIndicador     := 0;
              vrSomaPesoIndicador := 0;

              for indicadores in 
              (
                select
                    nu_tipo_indicador,
                    avg(vr_calculo_indicador) * vr_peso_tipo_indicador vr_calculo_media_peso,
                    vr_peso_tipo_indicador
                  from
                    gct.gctvw051_valor_indicador_ciclo_trabalho vict
                  where
                    nu_equipe = nuEquipe
                    and vr_calculo_indicador is not null
                    and nu_tipo_indicador in (
                      select
                        distinct ti.nu_tipo_indicador
                      from
                        gct.gcttb112_tipo_indicador ti
                        inner join gct.gcttb115_grupo_indicador gi on (gi.nu_tipo_indicador = ti.nu_tipo_indicador)
                      where
                        nu_tipo_grupo = vict.nu_tipo_grupo
                        and sg_tipo_indicador <> 'IEQDEP'
                        and gi.ic_apenas_faturamento_atual <> 'S'
                    )
                    and nu_tipo_grupo = nuTipoGrupo
                    and co_falha_ciclo_trabalho = 'NF'
                    and vict.dt_referencia::date <= dtFinalfatura::date
                    and date(vict.dt_referencia) >= (
                      dtFinalfatura::date - ((qtFaturamento - 1) * '1 Month' :: interval)
                    )
                  group by
                    nu_tipo_indicador,
                    vr_peso_tipo_indicador
              )
              loop

                  vrSomaIndicador := vrSomaIndicador + indicadores.vr_calculo_media_peso;
                  vrSomaPesoIndicador := vrSomaPesoIndicador + indicadores.vr_peso_tipo_indicador;    

                  RAISE NOTICE 'INDICADOR IEQDEP - EQUIPE: % | TP. INDICADOR: % | MEDIA: % | PESO: %', 
                      nuEquipe, indicadores.nu_tipo_indicador, indicadores.vr_calculo_media_peso, 
                        indicadores.vr_peso_tipo_indicador;

              end loop;

              vrCalculoIndicador := null;

              if (coalesce(vrSomaIndicador,0) <> 0 and coalesce(vrSomaPesoIndicador,0) <> 0) then

                  vrCalculoIndicador := vrSomaIndicador / vrSomaPesoIndicador;

              end if; 

              RAISE NOTICE 'INDICADOR IEQDEP - EQUIPE: % GRUPO: % SOMA INDICADOR: % PESO INDICADOR: % VALOR: %', 
                  nuEquipe, nutipogrupo, vrSomaIndicador, vrSomaPesoIndicador, vrCalculoIndicador;

              PERFORM gct.gctfn314_registrar_valor_indicador_equipe(nuFatura, nuEquipe, nuTipoGrupo, nuTipoIndicador, vrCalculoIndicador);

          end if;
      --
      end if;
      --  
  END;
$function$;

alter function gct.gctfn313_indicador_desempenho(nuequipe numeric, nutipogrupo numeric, nufatura numeric) owner to gct;

--------------------------------------------------------------------------------
-- -- gctfn340_indicador_produtividade_ajuste
-- --------------------------------------------------------------------------------

-- drop function if exists gct.gctfn340_indicador_produtividade_ajuste(nuequipe numeric, nutipogrupo numeric, nufatura numeric, nuajuste numeric);

CREATE OR REPLACE FUNCTION gct.gctfn340_indicador_produtividade_ajuste(nuequipe numeric, nutipogrupo numeric, nufatura numeric, nuajuste numeric)
 RETURNS void
 LANGUAGE plpgsql
AS $function$

/*

RELEASE NOTES

RTC 19943774 - SIGCT - ERRO "Definir falha por culpa da Caixa"
RTC 19423998 - SIGCT - Erro na rotina de ajuste dos contratos ágeis
RTC 15545749 - SIGCT - Ágil Contrato no. 9520/2018 - FOTON -  Revisão dos Termos de Ajustes - 2. TA - Repactuação de Preços
RTC 18800925 - SIGCT - Repactuação Contrato 14225/2017 - Ágil
RTC 17251327 - SIGCT - Aplicação do FNS nos contratos ágeis PEDES_8666/2018-FÓTON
RTC 15276626 - SIGCT - Contrato 9520/2018 - FÓTON - Exclusão e Investigação do TMAE0284 da OS BRE201800024
RTC 14901634 - SIGCT - termos negativos 2812/2018 Stefanini
RTC 14841558 - SIGCT - Ajuste de calculo de produtividade - Contrato 8666/2018

*/

/*
PRODUTIVIDADE de Equipe tem por objetivo verificar se a produtividade de uma
equipe está dentro da meta estabelecida, calculada em Pontos de Função e Pontos SNAP
de uma Sprint finalizada.
*/
DECLARE

  ciclo RECORD;
  membros RECORD;
  vrIndicador numeric;
  nuTipoIndicador integer;
  noTipoIndicador character varying(100);
  sgTipoIndicador character(6);
  vrProdutividadeEsperada numeric;
  vrTotalInicadorCicloTrabalho numeric;
  qtTotalIndicadorCicloTrabalho numeric;
  qtTotalExtraordinarios numeric; 
  qtDiasTrabalhadosCiclo numeric;
  dtInicioVigenciaMembro date;
  dtFinalVigenciaMembro date;
  dtiniciofatura date;
  dtfinalfatura date;
  vrLimiteMaximoIndicador numeric;
  qtDiasVigenciaMembro numeric;
  vrVigencia numeric;
  qtMembrosVigentes numeric;
                            
BEGIN

  select
    dt_inicio_fatura,
    dt_final_fatura 
  into 
    dtiniciofatura,
    dtfinalfatura
  from
    gct.gcttb102_fatura
  where
    nu_fatura = nufatura;

  vrTotalInicadorCicloTrabalho := 0;
  qtTotalIndicadorCicloTrabalho := 0;
  qtTotalExtraordinarios = 0;

  select
    ti.nu_tipo_indicador,
    ti.no_tipo_indicador,
    ti.sg_tipo_indicador,
    gi.vr_fator_ajuste,
    gi.vr_limite_maximo_indicador 
  into 
    nuTipoIndicador,
    noTipoIndicador,
    sgTipoIndicador,
    vrProdutividadeEsperada,
    vrLimiteMaximoIndicador
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
    ti.sg_tipo_indicador = 'IEQPR'
    and e.nu_ajuste = nuajuste
    and e.nu_equipe = nuequipe
    and gc.nu_tipo_grupo = nutipogrupo;

  if(sgTipoIndicador is null) then

      RAISE NOTICE 'INDICADOR IEQPR - NAO CONFIGURADO PARA O GRUPO: %',nutipogrupo;

  else
                
    RAISE NOTICE 'INDICADOR IEQPR - EQUIPE: % | AJUSTE: % | INDICADOR: % | FATURA: % % | GRUPO: %', 
      nuEquipe, nuajuste, nuTipoIndicador, nufatura, dtfinalfatura, nutipogrupo;

    FOR ciclo IN

      select
        sum(nu_tamanho_servico) as vrTotalTamanhoServico,
        ct.nu_ciclo_trabalho,
        ct.nu_equipe,
        dt_inicio_ciclo_trabalho,
        dt_alvo_ciclo_trabalho,
        dt_final_ciclo_trabalho,
        co_falha_ciclo_trabalho,
        ai.co_sitio,
        gc.ic_calculo_pro_rata,
        gc.ic_dias_calculo_pagamento,
        gct.gctfn305_dias_entre_data(ct.dt_inicio_ciclo_trabalho::date, 
                                     ct.dt_alvo_ciclo_trabalho::date, 
                                     ai.co_sitio, 
                                     gc.ic_dias_calculo_pagamento) qtDiasSprint
      from
        gct.gcttb177_amostra_solicitacao_equipe ase
        inner join gct.gcttb005_solicitacao s on s.nu_solicitacao = ase.nu_solicitacao
        inner join gct.gcttb176_amostra_ciclo_trabalho ct on (
          ct.nu_ciclo_trabalho = ase.nu_ciclo_trabalho
          and ct.nu_equipe = ase.nu_equipe
          and ct.nu_ajuste = ase.nu_ajuste
        )
        inner join gct.gcttb175_amostra_equipe ae on (
          ae.nu_equipe = ase.nu_equipe
          and ae.nu_ajuste = ase.nu_ajuste
        )
        inner join gct.gcttb033_grupo_contrato gc on (
          gc.nu_contrato = ae.nu_contrato
          and gc.nu_tipo_grupo = ae.nu_tipo_grupo
        )
        inner join gct.gcttb001_area_interna ai on (ai.nu_area_interna = ae.nu_area_interna)
      where
        ct.nu_equipe = nuequipe
        and ct.nu_ajuste = nuajuste
        and ct.dt_alvo_ciclo_trabalho :: date between dtiniciofatura and dtfinalfatura
        and ct.nu_situacao_ciclo_trabalho = 2
        and ct.co_falha_ciclo_trabalho = 'NF'
        and ase.ic_solicitacao_compoe_fns = 'S'
      group by
        ct.nu_ciclo_trabalho,
        ct.nu_equipe,
        dt_inicio_ciclo_trabalho,
        dt_alvo_ciclo_trabalho,
        dt_final_ciclo_trabalho,
        co_falha_ciclo_trabalho,
        ai.co_sitio,
        gc.ic_calculo_pro_rata,
        gc.ic_dias_calculo_pagamento
      order by
        ct.dt_inicio_ciclo_trabalho

    LOOP

      qtMembrosVigentes := 0;
      vrVigencia := 0;

      RAISE NOTICE 'INDICADOR IEQPR - EQUIPE: % | AJUSTE: % | INDICADOR: % | CICLO: % | DT. INICIO: % | DT. ALVO: % | DT. FINAL: % | FALHA CAIXA: %',
        ciclo.nu_equipe, nuajuste, nuTipoIndicador, ciclo.nu_ciclo_trabalho, 
          ciclo.dt_inicio_ciclo_trabalho::date, ciclo.dt_alvo_ciclo_trabalho::date, ciclo.dt_final_ciclo_trabalho::date, ciclo.co_falha_ciclo_trabalho;

      RAISE NOTICE 'INDICADOR IEQPR - EQUIPE: % | AJUSTE: % | INDICADOR: % | CICLO: % | TAMANHO: % | PERIODO: % A % | QT. DIAS CICLO: %',
        ciclo.nu_equipe, nuajuste, nuTipoIndicador, ciclo.nu_ciclo_trabalho, 
          ciclo.vrTotalTamanhoServico, dtiniciofatura, dtfinalfatura, ciclo.qtDiasSprint;

      FOR membros IN
          select 
            nu_equipe,
            dt_inicio_vigencia_membros,
            coalesce(dt_final_vigencia_membros, dtfinalfatura) dt_final_vigencia_membros,
            qt_membros_equipe
          from 
            gct.gcttb183_amostra_qntde_membros_equipe
          where 
            nu_equipe = ciclo.nu_equipe
            and nu_ajuste = nuajuste
            and (
              (
                date(ciclo.dt_inicio_ciclo_trabalho) >= dt_inicio_vigencia_membros and 
                date(ciclo.dt_inicio_ciclo_trabalho) <= dt_final_vigencia_membros
              )
              or
              (
                date(ciclo.dt_alvo_ciclo_trabalho) >= dt_inicio_vigencia_membros and 
                date(ciclo.dt_inicio_ciclo_trabalho) <= dt_final_vigencia_membros
              )
              or
              (
                date(ciclo.dt_inicio_ciclo_trabalho) >= dt_inicio_vigencia_membros and 
                dt_final_vigencia_membros is null
              )
              or
              (
                date(ciclo.dt_alvo_ciclo_trabalho) >= dt_inicio_vigencia_membros and 
                dt_final_vigencia_membros is null
              )
            )
          order by dt_inicio_vigencia_membros
      LOOP

        ---#### Calculo PRORATA

        --
        -- Data inicio da vigencia dos membros
        --                                             
        dtInicioVigenciaMembro := membros.dt_inicio_vigencia_membros;
        
        if(membros.dt_inicio_vigencia_membros < ciclo.dt_inicio_ciclo_trabalho) then
            dtInicioVigenciaMembro := ciclo.dt_inicio_ciclo_trabalho;
        end if;

        --
        -- Data final da vigencia dos membros
        --                                             
        dtFinalVigenciaMembro := membros.dt_final_vigencia_membros;

        if(membros.dt_final_vigencia_membros > dtfinalfatura) then
          dtFinalVigenciaMembro := dtfinalfatura;
        end if;

        if(ciclo.dt_alvo_ciclo_trabalho < membros.dt_final_vigencia_membros) then
          dtFinalVigenciaMembro := ciclo.dt_alvo_ciclo_trabalho;
        end if;

        if(ciclo.ic_calculo_pro_rata = 'S') then

            vrVigencia := 0;

            select gct.gctfn305_dias_entre_data(dtInicioVigenciaMembro::date, 
                                                dtFinalVigenciaMembro::date, 
                                                ciclo.co_sitio,
                                                ciclo.ic_dias_calculo_pagamento) 
                                                into qtDiasVigenciaMembro;
            
            if ciclo.qtDiasSprint > 0 then 

                vrVigencia :=  ((membros.qt_membros_equipe / (ciclo.qtDiasSprint)) * qtDiasVigenciaMembro);

            end if;
            
            qtMembrosVigentes := qtMembrosVigentes + vrVigencia;

        end if;

        RAISE NOTICE 'INDICADOR IEQPR - EQUIPE: % | AJUSTE: % | INDICADOR: % | CICLO: % | QT. MEMBROS: % | QT. DIAS VIG. MEMBRO: % | QT. MEMBROS EFETIVA: %', 
          ciclo.nu_equipe, nuajuste, nuTipoIndicador, ciclo.nu_ciclo_trabalho,  
            membros.qt_membros_equipe, qtDiasVigenciaMembro, vrVigencia;

      END LOOP;

      IF qtMembrosVigentes > 0 THEN

        select sum(coalesce(a.qt_dia_servico_extra,0::numeric)) into qtTotalExtraordinarios
          from gct.gcttb176_amostra_ciclo_trabalho ct
        inner join gct.gcttb180_amostra_ausencia_servico_extra a on (
                a.nu_ajuste = ct.nu_ajuste 
                and a.nu_ciclo_trabalho = ct.nu_ciclo_trabalho
              )
        inner join gct.gcttb102_fatura f on f.nu_fatura = a.nu_fatura        
        where ct.nu_equipe = ciclo.nu_equipe
          and ct.nu_ajuste = nuajuste
          and ct.nu_ciclo_trabalho = ciclo.nu_ciclo_trabalho;

      END IF;

      if qtTotalExtraordinarios is null then
        qtTotalExtraordinarios = 0;
      end if;

      if qtMembrosVigentes > 0 then
          
          qtDiasTrabalhadosCiclo := ciclo.qtDiasSprint + (qtTotalExtraordinarios / qtMembrosVigentes);
          
      end if;

      if(ciclo.vrTotalTamanhoServico > 0 and qtMembrosVigentes > 0 and qtDiasTrabalhadosCiclo > 0) then

        vrIndicador = (ciclo.vrTotalTamanhoServico / qtMembrosVigentes / qtDiasTrabalhadosCiclo) / vrProdutividadeEsperada;

        RAISE NOTICE 'INDICADOR IEQPR - EQUIPE: % | AJUSTE: % | INDICADOR: % | CICLO: % | QT. DIAS TRAB.: % PROD. ESPERADA: %', 
            nuEquipe, nuajuste, nuTipoIndicador, ciclo.nu_ciclo_trabalho, qtDiasTrabalhadosCiclo, vrProdutividadeEsperada;

        /*
        ProdutividadeSprint: para o cálculo da produtividade de uma Sprint o valor do percentual resultante está limitado a 
        resultado máximo de XXX por cento da produtividade esperada. 
        Caso o resultado ultrapasse este valor, será considerado então este limite máximo.  
        */
        RAISE NOTICE 'INDICADOR IEQPR - EQUIPE: % | AJUSTE: % | INDICADOR: % | CICLO: % | CALCULO: % / % / %) / %', 
          nuEquipe, nuajuste, nuTipoIndicador, ciclo.nu_ciclo_trabalho, 
            ciclo.vrTotalTamanhoServico, qtMembrosVigentes, qtDiasTrabalhadosCiclo, vrProdutividadeEsperada;

        if(vrIndicador > vrLimiteMaximoIndicador) then
            RAISE NOTICE 'INDICADOR IEQPR - EQUIPE: % | AJUSTE: % | INDICADOR: % | CICLO: % | VALOR: % | REDUZIDO PARA (MAXIMO CONTRATUAL): %', 
               nuEquipe, nuajuste, nuTipoIndicador, ciclo.nu_ciclo_trabalho, vrIndicador, vrLimiteMaximoIndicador;
            vrIndicador := vrLimiteMaximoIndicador;                         
        end if;

        vrTotalInicadorCicloTrabalho := vrTotalInicadorCicloTrabalho + vrIndicador;
        qtTotalIndicadorCicloTrabalho := qtTotalIndicadorCicloTrabalho + 1;

        PERFORM gct.gctfn344_registrar_vl_ind_ciclo_trabalho_ajuste(nuajuste,nuFatura,nuEquipe,ciclo.nu_ciclo_trabalho,nutipogrupo,nuTipoIndicador,vrIndicador);                        
        
        RAISE NOTICE 'INDICADOR IEQPR - EQUIPE: % | AJUSTE: % | INDICADOR: % | CICLO: % | VALOR INDICADOR CICLO: %', 
          nuEquipe, nuajuste, nuTipoIndicador, ciclo.nu_ciclo_trabalho, vrIndicador;

      else

        PERFORM gct.gctfn344_registrar_vl_ind_ciclo_trabalho_ajuste(nuajuste,nuFatura,nuEquipe,ciclo.nu_ciclo_trabalho,nutipogrupo,nuTipoIndicador,0);                        

        RAISE NOTICE 'INDICADOR IEQPR - EQUIPE: % | AJUSTE: % | INDICADOR: % | CICLO: % | VALOR INDICADOR CICLO: %', 
          nuEquipe, nuajuste, nuTipoIndicador, ciclo.nu_ciclo_trabalho, 0;

      end if;
      
    END LOOP; -- CICLOS

    if(qtTotalIndicadorCicloTrabalho > 0) then
        vrIndicador := vrTotalInicadorCicloTrabalho / qtTotalIndicadorCicloTrabalho;

        RAISE NOTICE 'INDICADOR IEQPR - EQUIPE: % | AJUSTE: % | INDICADOR: % | VALOR INDICADOR: %',
          nuEquipe, nuajuste, nuTipoIndicador, vrIndicador;

        PERFORM gct.gctfn343_registrar_vl_ind_equipe_ajuste(nuajuste, nuFatura, nuEquipe, nutipogrupo, nuTipoIndicador, vrIndicador);              
    end if;

  end if;

END;

$function$;

alter function gct.gctfn340_indicador_produtividade_ajuste(nuequipe numeric, nutipogrupo numeric, nufatura numeric, nuajuste numeric) owner to gct;

--------------------------------------------------------------------------------
-- -- gctfn342_indicador_desempenho_ajuste
-- --------------------------------------------------------------------------------

-- drop function if exists gct.gctfn342_indicador_desempenho_ajuste(nuequipe numeric, nutipogrupo numeric, nufatura numeric, nuajuste numeric);

CREATE OR REPLACE FUNCTION gct.gctfn342_indicador_desempenho_ajuste(nuequipe numeric, nutipogrupo numeric, nufatura numeric, nuajuste numeric)
 RETURNS void
 LANGUAGE plpgsql
AS $function$

/*
DESEMPENHO tem o objetivo de apurar o desempenho da equipe técnica contratada
tendo como insumos a média dos indicadores PRODUTO, VALOR
PRODUTIVIDADE considerando as sprints finalizadas nos 3 (três) últimos periodos de
faturamentos (incluindo o atual), ou nos períodos de faturamentos em que a equipe tiver
sido contratada, caso menor que 3 (três) periodos.
*/

/*

RELEASE NOTES

RTC 23192487 - SIGCT - não geração dos indicadores de Produto e Valor Agregado e o FNS da equipe BRE202200013, contrato 06834.
RTC 20783895 - SIGCT - Análise do cálculo de indicadores WIPRO (Referente à implantação do RTC 17882046)
RTC 17882046 - SIGCT - Erro no processamento de amostra para calculo de Indicadores (GECEQ)
RTC 19943774 - SIGCT - ERRO "Definir falha por culpa da Caixa"
RTC 19423998 - SIGCT - Erro na rotina de ajuste dos contratos ágeis
RTC 15276626 - SIGCT - Contrato 9520/2018 - FÓTON - Exclusão e Investigação do TMAE0284 da OS BRE201800024
RTC 15791035 - SIGCT - Contrato 09386/2018 - SPREAD - Faturamento AGO 2020 – FNS

*/
    
DECLARE
    
    nuTipoIndicador     numeric;
    dtIniciofatura      date;
    dtFinalfatura       date;
    qtFaturamento       integer;
    vrCalculoIndicador  numeric;
    vrSomaIndicador     numeric(10,5);
    vrSomaPesoIndicador numeric(10,5);
    icTipoAtendimento   character(1);
    indicadores         record;

BEGIN
    
    -- recupera a fatura
    select
      dt_inicio_fatura,
      dt_final_fatura 
    into 
      dtInicioFatura,
      dtFinalFatura
    from
      gct.gcttb102_fatura
    where
      nu_fatura = nufatura;

    --Recuperar os paramentros do indicador ,entretanto, se o "gi.qt_faturamento" for null transformo para zero.
    select
      ti.nu_tipo_indicador,
      gi.qt_faturamento,
      gc.ic_tipo_atendimento into nuTipoIndicador,
      qtFaturamento,
      icTipoAtendimento
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
      ti.sg_tipo_indicador = 'IEQDEP'
      and e.nu_ajuste = nuAjuste
      and e.nu_equipe = nuEquipe
      and gc.nu_tipo_grupo = nuTipoGrupo;

    --
    -- Quando tipo atedendimento eh acionamento usar os indicadores das equipes (tb172). 
    -- Quando tipo atedendimento eh sprint usar os indicadores dos ciclos (tb171).
    -- Na tabela tb172 existe calculada a media das sprints da fatura como sendo o indicador da equipe.
    -- Para o Desempenho nao usar a media da equipe, fazer a media ponderada apartir dos indicadores da sprint.
    if icTipoAtendimento = 'A' then
    --
        if (nuTipoIndicador is null) then
            RAISE NOTICE 'INDICADOR IEQDEP - NAO CONFIGURADO PARA O GRUPO: %', nuTipoGrupo;
        else            
            RAISE NOTICE 'INDICADOR IEQDEP - EQUIPE: % | AJUSTE: % | GRUPO: % | TIPO ATENDIMENTO: % | PERIODO FATURAMENTO: % a %',
              nuEquipe, nuajuste, nutipogrupo, icTipoAtendimento, dtInicioFatura, dtfinalfatura;

            vrCalculoIndicador  := 0;
            vrSomaIndicador     := 0;
            vrSomaPesoIndicador := 0;

            for indicadores in 
            (
                select
                  nu_tipo_indicador,
                  avg(vr_calculo_indicador) * vr_peso_tipo_indicador vr_calculo_media_peso,
                  vr_peso_tipo_indicador
                from
                  gct.gctvw052_valor_indicador_equipe vict
                where
                  nu_equipe = nuEquipe
                  and nu_tipo_grupo = nuTipoGrupo
                  and vr_calculo_indicador is not null
                  and nu_tipo_indicador in (
                    select
                      distinct ti.nu_tipo_indicador
                    from
                      gct.gcttb112_tipo_indicador ti
                      inner join gct.gcttb115_grupo_indicador gi on (gi.nu_tipo_indicador = ti.nu_tipo_indicador)
                    where
                      gi.nu_contrato = vict.nu_contrato
                      and nu_tipo_grupo = vict.nu_tipo_grupo
                      and sg_tipo_indicador <> 'IEQDEP'
                      and coalesce(gi.ic_apenas_faturamento_atual,'N') <> 'S'
                  )
                  and vict.dt_referencia :: date <= dtFinalFatura :: date
                  and date(vict.dt_referencia) >= (
                    dtFinalFatura :: date - ((qtFaturamento - 1) * '1 Month' :: interval)
                  )
                group by
                  nu_tipo_indicador,
                  vr_peso_tipo_indicador
            )
            loop

                vrSomaIndicador := vrSomaIndicador + indicadores.vr_calculo_media_peso;
                vrSomaPesoIndicador := vrSomaPesoIndicador + indicadores.vr_peso_tipo_indicador;

                RAISE NOTICE 'INDICADOR IEQDEP - EQUIPE: % | AJUSTE: % | TP. INDICADOR: % | SOMENTE FATURAMENTO ATUAL: N | MEDIA: % | PESO: %', 
                  nuEquipe, nuajuste, indicadores.nu_tipo_indicador, indicadores.vr_calculo_media_peso, indicadores.vr_peso_tipo_indicador;

            end loop;

            for indicadores in 
            (
                select
                  nu_tipo_indicador,
                  avg(vr_calculo_indicador) * vr_peso_tipo_indicador vr_media_indicador,
                  vr_peso_tipo_indicador
                from
                  gct.gctvw052_valor_indicador_equipe vict
                where
                  nu_equipe = nuEquipe
                  and nu_tipo_grupo = nuTipoGrupo
                  and vr_calculo_indicador is not null
                  and nu_tipo_indicador in (
                    select
                      distinct ti.nu_tipo_indicador
                    from
                      gct.gcttb112_tipo_indicador ti
                      inner join gct.gcttb115_grupo_indicador gi on (gi.nu_tipo_indicador = ti.nu_tipo_indicador)
                    where
                      gi.nu_contrato = vict.nu_contrato
                      and nu_tipo_grupo = vict.nu_tipo_grupo
                      and sg_tipo_indicador <> 'IEQDEP'
                      and coalesce(gi.ic_apenas_faturamento_atual,'N') = 'S'
                  )
                  and vict.dt_referencia :: date = dtFinalFatura :: date
                group by
                  nu_tipo_indicador,
                  vr_peso_tipo_indicador
            )
            loop

                vrSomaIndicador := vrSomaIndicador + indicadores.vr_media_indicador;
                vrSomaPesoIndicador := vrSomaPesoIndicador + indicadores.vr_peso_tipo_indicador;

                RAISE NOTICE 'INDICADOR IEQDEP - EQUIPE: % | AJUSTE: % | TP. INDICADOR: % | SOMENTE FATURAMENTO ATUAL: S | MEDIA: % | PESO: % | VALOR: %', 
                  nuEquipe, nuajuste, indicadores.nu_tipo_indicador, indicadores.vr_media_indicador, indicadores.vr_peso_tipo_indicador,
                    indicadores.vr_media_indicador / indicadores.vr_peso_tipo_indicador;

            end loop;

            if (coalesce(vrSomaPesoIndicador,0) <> 0) then
                vrCalculoIndicador := coalesce(vrSomaIndicador,0) / vrSomaPesoIndicador;

                RAISE NOTICE 'INDICADOR IEQDEP - EQUIPE: % | AJUSTE: % | INDICADOR: % | GRUPO: % | SOMA INDICADOR: % | PESO INDICADOR: % | VALOR INDICADOR: %', 
                 nuEquipe, nuajuste, nuTipoIndicador, nutipogrupo, vrSomaIndicador, vrSomaPesoIndicador, vrCalculoIndicador;

                PERFORM gct.gctfn343_registrar_vl_ind_equipe_ajuste(nuAjuste, nuFatura, nuEquipe, nuTipoGrupo, nuTipoIndicador, vrCalculoIndicador);
            else
                RAISE NOTICE 'INDICADOR IEQDEP - EQUIPE: % | AJUSTE: % | INDICADOR: % | GRUPO: % | SOMA INDICADOR: % | PESO INDICADOR: % | VALOR INDICADOR: (NAO GRAVADO)', 
                 nuEquipe, nuajuste, nuTipoIndicador, nutipogrupo, vrSomaIndicador, vrSomaPesoIndicador;
            end if;
        end if;
    end if;     
    

    --
    -- SPRINT
    --
    if icTipoAtendimento = 'S' then
    --
        if (nuTipoIndicador is null) then
            RAISE NOTICE 'INDICADOR IEQDEP - NAO CONFIGURADO PARA O GRUPO: %', nuTipoGrupo;
        else
            RAISE NOTICE 'INDICADOR IEQDEP - EQUIPE: % | AJUSTE: % | GRUPO: % | TIPO ATENDIMENTO: % | PERIODO FATURAMENTO: % a %',
              nuEquipe, nuajuste, nutipogrupo, icTipoAtendimento, dtInicioFatura, dtfinalfatura;

            vrCalculoIndicador  := 0;
            vrSomaIndicador     := 0;
            vrSomaPesoIndicador := 0;

            for indicadores in 
            (
              select
                  nu_tipo_indicador,
                  avg(vr_calculo_indicador) * vr_peso_tipo_indicador vr_media_indicador,
                  vr_peso_tipo_indicador
                from
                  gct.gctvw076_valor_indicador_ciclo_trabalho_ajuste vict
                where
                  nu_equipe = nuEquipe
                  and nu_tipo_indicador in (
                    select
                      distinct ti.nu_tipo_indicador
                    from
                      gct.gcttb112_tipo_indicador ti
                      inner join gct.gcttb115_grupo_indicador gi on (gi.nu_tipo_indicador = ti.nu_tipo_indicador)
                    where
                      nu_tipo_grupo = vict.nu_tipo_grupo
                      and sg_tipo_indicador <> 'IEQDEP'
                      and gi.ic_apenas_faturamento_atual <> 'S'
                  )
                  and nu_tipo_grupo = nuTipoGrupo
                  and nu_ajuste = nuAjuste
                  and co_falha_ciclo_trabalho = 'NF'
                  and cast(vict.dt_referencia as date) <= cast(dtFinalfatura as date)
                  and cast(vict.dt_referencia as date) >= (
                    cast(dtFinalfatura as date) - ((qtFaturamento - 1) * '1 Month' :: interval)
                  )
                group by
                  nu_tipo_indicador,
                  vr_peso_tipo_indicador
            )
            loop

                vrSomaIndicador := vrSomaIndicador + indicadores.vr_media_indicador;
                vrSomaPesoIndicador := vrSomaPesoIndicador + indicadores.vr_peso_tipo_indicador;

                RAISE NOTICE 'INDICADOR IEQDEP - EQUIPE: % | AJUSTE: % | TP. INDICADOR: % | MEDIA: % | PESO: % | VALOR: %', 
                  nuEquipe, nuajuste, indicadores.nu_tipo_indicador,
                    indicadores.vr_media_indicador, indicadores.vr_peso_tipo_indicador, (indicadores.vr_media_indicador / indicadores.vr_peso_tipo_indicador)::numeric(10,5);
            
            end loop;

            if (coalesce(vrSomaIndicador,0) <> 0 and coalesce(vrSomaPesoIndicador,0) <> 0) then
                vrCalculoIndicador := vrSomaIndicador / vrSomaPesoIndicador;

                RAISE NOTICE 'INDICADOR IEQDEP - EQUIPE: % | AJUSTE: % | GRUPO: % | SOMA INDICADOR: % | PESO INDICADOR: % | VALOR: %', 
                  nuEquipe, nuajuste, nutipogrupo, vrSomaIndicador, vrSomaPesoIndicador, vrCalculoIndicador;

                PERFORM gct.gctfn343_registrar_vl_ind_equipe_ajuste(nuAjuste, nuFatura, nuEquipe, nuTipoGrupo, 
                  nuTipoIndicador, vrCalculoIndicador);
            else
                RAISE NOTICE 'INDICADOR IEQDEP - EQUIPE: % | AJUSTE: % | GRUPO: % | NAO GRAVADO', nuEquipe, nuajuste, nutipogrupo;
            end if;                 
        end if; 
    --
    end if;
    --
END;
$function$;

alter function gct.gctfn342_indicador_desempenho_ajuste(nuequipe numeric, nutipogrupo numeric, nufatura numeric, nuajuste numeric) owner to gct;

--------------------------------------------------------------------------------
-- -- gct.gctvw051_valor_indicador_ciclo_trabalho
-- --------------------------------------------------------------------------------

-- drop view if exists gct.gctvw051_valor_indicador_ciclo_trabalho;

create or replace view gct.gctvw051_valor_indicador_ciclo_trabalho as
  SELECT
    vie3.dt_referencia,
    vie3.nu_contrato,
    vie3.nu_tipo_grupo,
    vie3.nu_equipe,
    vie3.nu_ciclo_trabalho,
    COALESCE(vie3.co_falha_ciclo_trabalho,
    'NF'::bpchar) AS co_falha_ciclo_trabalho,
    vie3.dt_alvo_ciclo_trabalho,
    vie3.nu_tipo_indicador,
    vie3.dh_geracao_indicador_ciclo_trabalho,
    vie3.vr_calculo_indicador,
    vie3.vr_peso_tipo_indicador,
    vie3.vr_faixa_fns,
    vie3.nu_ajuste
  FROM
    (     SELECT
      vie.dt_referencia,
      vie.nu_contrato,
      vie.nu_tipo_grupo,
      vie.nu_equipe,
      vie.nu_ciclo_trabalho,
      a.co_falha_ciclo_trabalho,
      a.dt_alvo_ciclo_trabalho,
      vie.nu_tipo_indicador,
      vie.dh_geracao_indicador_ciclo_trabalho,
      vie.vr_calculo_indicador,
      vie.vr_peso_tipo_indicador,
      vie.vr_faixa_fns,
      vie.nu_ajuste
    FROM
      gct.gcttb171_valor_indicador_ciclo_trabalho vie
    JOIN
      gct.gcttb176_amostra_ciclo_trabalho a
        ON a.nu_equipe = vie.nu_equipe
        AND a.nu_fatura_amostra = vie.nu_fatura
        AND a.nu_ciclo_trabalho = vie.nu_ciclo_trabalho
    JOIN
      gct.gcttb175_amostra_equipe e
        ON e.nu_equipe = vie.nu_equipe
        AND e.nu_fatura_amostra = vie.nu_fatura
    JOIN
      gct.gcttb010_contrato c
        ON c.nu_contrato = e.nu_contrato
    JOIN
      gct.gcttb086_solicitacao_equipe se
        ON se.nu_equipe = vie.nu_equipe
        AND se.nu_ciclo_trabalho = vie.nu_ciclo_trabalho
    JOIN
      gct.gcttb055_servico_contrato sc
        ON sc.nu_tipo_servico = se.nu_tipo_servico
        AND e.nu_contrato = sc.nu_contrato
        AND sc.ic_servico_compoe_calculo_fns = 'S'::bpchar
    JOIN
      gct.gcttb102_fatura f
        ON f.dt_final_fatura = vie.dt_referencia
        AND f.co_sitio = e.co_sitio
        AND f.nu_faturamento = c.nu_faturamento
        AND a.dt_alvo_ciclo_trabalho::date >= f.dt_inicio_fatura
        AND a.dt_alvo_ciclo_trabalho::date <= f.dt_final_fatura
    WHERE
      vie.nu_ajuste IS NULL
    UNION
    SELECT
      vie.dt_referencia,
      vie.nu_contrato,
      vie.nu_tipo_grupo,
      vie.nu_equipe,
      vie.nu_ciclo_trabalho,
      a.co_falha_ciclo_trabalho,
      a.dt_alvo_ciclo_trabalho,
      vie.nu_tipo_indicador,
      vie.dh_geracao_indicador_ciclo_trabalho,
      vie.vr_calculo_indicador,
      vie.vr_peso_tipo_indicador,
      vie.vr_faixa_fns,
      vie.nu_ajuste
    FROM
      gct.gcttb171_valor_indicador_ciclo_trabalho vie
    JOIN
      gct.gcttb176_amostra_ciclo_trabalho a
        ON a.nu_equipe = vie.nu_equipe
        AND a.nu_ajuste = vie.nu_ajuste
        AND a.nu_ciclo_trabalho = vie.nu_ciclo_trabalho
    JOIN
      gct.gcttb175_amostra_equipe e
        ON e.nu_equipe = vie.nu_equipe
        AND e.nu_ajuste = vie.nu_ajuste
    JOIN
      gct.gcttb010_contrato c
        ON c.nu_contrato = e.nu_contrato
    JOIN
      gct.gcttb086_solicitacao_equipe se
        ON se.nu_equipe = vie.nu_equipe
        AND se.nu_ciclo_trabalho = vie.nu_ciclo_trabalho
    JOIN
      gct.gcttb055_servico_contrato sc
        ON sc.nu_tipo_servico = se.nu_tipo_servico
        AND e.nu_contrato = sc.nu_contrato
        AND sc.ic_servico_compoe_calculo_fns = 'S'::bpchar
    JOIN
      gct.gcttb102_fatura f
        ON f.dt_final_fatura = vie.dt_referencia
        AND f.co_sitio = e.co_sitio
        AND f.nu_faturamento = c.nu_faturamento
        AND a.dt_alvo_ciclo_trabalho::date >= f.dt_inicio_fatura
        AND a.dt_alvo_ciclo_trabalho::date <= f.dt_final_fatura
    WHERE
      vie.nu_ajuste IS NOT NULL
  ) vie3
WHERE
  vie3.dh_geracao_indicador_ciclo_trabalho = (
    (
      SELECT
        max(vie2.dh_geracao_indicador_ciclo_trabalho) AS max
      FROM
        gct.gcttb171_valor_indicador_ciclo_trabalho vie2
      WHERE
        vie3.dt_referencia = vie2.dt_referencia
        AND vie3.nu_contrato = vie2.nu_contrato
        AND vie3.nu_tipo_grupo = vie2.nu_tipo_grupo
        AND vie3.nu_equipe = vie2.nu_equipe
        AND vie3.nu_ciclo_trabalho = vie2.nu_ciclo_trabalho
        AND vie3.nu_tipo_indicador = vie2.nu_tipo_indicador
    )
  );

alter view gct.gctvw051_valor_indicador_ciclo_trabalho owner to gct;

--------------------------------------------------------------------------------
-- -- gctfn005_gravar_ciclo_trabalho
-- --------------------------------------------------------------------------------

-- drop function if exists gct.gctfn005_gravar_ciclo_trabalho();

CREATE OR REPLACE FUNCTION gct.gctfn005_gravar_ciclo_trabalho()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$

/**

RELEASE NOTES

RTC 20971453 - GT60 VITEC - Vinculação automática de Item de Backlog nas contratações ágil

*/	

	declare
			
            --
        out_json text;	
            --            
		nu_equipe 				numeric(10);
		nu_ciclo_trabalho 			numeric(10);
		nu_situacao_ciclo_trabalho 		numeric(2);
		de_ciclo_trabalho 			varchar(500);
		dt_inicio_ciclo_trabalho 		timestamp;
		dt_alvo_ciclo_trabalho 			timestamp;
		dt_final_ciclo_trabalho 		timestamp;
		co_falha_ciclo_trabalho 		bpchar(2);
		nu_acao_historico 			numeric(4);	
		nu_mtrca_acao_hstro 			numeric;
		vr_questionario_avaliacao 		numeric(6,3);
		vr_nota_qualidade_produto 		numeric(6,3);
		vr_total_apurado_avaliacao 		numeric(6,3);
		nu_mtrca_avaliacao_equipe 		numeric(6);
		de_justificativa_falha 			varchar(500);
		
		new_co_equipe		text;
		new_de_situacao	text;
		old_de_situacao		text;
		new_co_solicitacao text;
		new_solicitacao numeric;
		
		new_vr_nota_qualidade_produto_trunc numeric;
		old_vr_nota_qualidade_produto_trunc numeric;
		
		
		
		new_vr_questionario_avaliacao_trunc numeric;
		old_vr_questionario_avaliacao_trunc	numeric;
		
		new_tamanho_servico	numeric;
		new_situacao text;
		new_dh_avaliacao_solicitacao timestamp;
		
			
	begin
	
	--buscar nome da equipe
	SELECT co_equipe INTO new_co_equipe FROM gct.gcttb087_equipe AS e WHERE e.nu_equipe = NEW.nu_equipe;
	
	--Situação
	SELECT no_situacao_atendimento INTO new_de_situacao FROM gct.gcttb092_situacao_atendimento AS sa WHERE sa.nu_situacao_atendimento = NEW.nu_situacao_ciclo_trabalho;
	
	--buscar solicitacao equipe
	SELECT nu_solicitacao, nu_tamanho_servico, dh_avaliacao_solicitacao INTO new_solicitacao, new_tamanho_servico, new_dh_avaliacao_solicitacao FROM gct.gcttb086_solicitacao_equipe AS so WHERE so.nu_equipe = NEW.nu_equipe and so.nu_ciclo_trabalho = NEW.nu_ciclo_trabalho;
	
	--buscar dados solicitacao
	SELECT co_solicitacao, de_situacao_solicitacao INTO new_co_solicitacao, new_situacao FROM gct.gcttb005_solicitacao AS s WHERE s.nu_solicitacao = new_solicitacao;

      
	--Incluir Sprint Nº Ação Histórico 174
	if (tg_op = 'INSERT') then
	
		-- open json    
		out_json = '{';

		out_json = out_json ||'"Equipe":["'                		|| coalesce(new_co_equipe, '')                   				|| '"],';
		out_json = out_json ||'"Sprint":["'                || coalesce(NEW.nu_ciclo_trabalho::text, '')                   			|| '"],';
		
		if(NEW.de_ciclo_trabalho IS NOT NULL and NEW.de_ciclo_trabalho <> '')then
			out_json = out_json ||'"Descrição":["'             	|| coalesce(NEW.de_ciclo_trabalho, '')                   			|| '"],';
		end if;
		
		if(NEW.dt_inicio_ciclo_trabalho IS NOT NULL)then
			out_json = out_json ||'"Data de Início":["' 		|| coalesce(to_char(NEW.dt_inicio_ciclo_trabalho, 'DD/MM/YYYY HH24:MI'), '') 	|| '"],';
		end if;
		
		out_json = out_json ||'"Data Prevista":["' 		|| coalesce(to_char(NEW.dt_alvo_ciclo_trabalho, 'DD/MM/YYYY HH24:MI'), '') 	|| '"],';
		out_json = out_json ||'"Código Falha do Ciclo Trabalho":["'             || coalesce(NEW.co_falha_ciclo_trabalho, '')                    		|| '"],';
		out_json = out_json ||'"Situação":["'              	|| coalesce(new_de_situacao, '')    			|| '"]';
		
		-- close json
		out_json = out_json || '}';

	end if;

	if( tg_op = 'UPDATE' ) then

		--Alterar Sprint
		if(NEW.nu_acao_historico = 175) then
		
				SELECT no_situacao_atendimento INTO old_de_situacao FROM gct.gcttb092_situacao_atendimento AS sa WHERE sa.nu_situacao_atendimento = OLD.nu_situacao_ciclo_trabalho;
				
				-- open json    
					out_json = '{';
			
				out_json = out_json ||'"Equipe":["'                		|| coalesce(new_co_equipe, '')                   				|| '"],';
				
				
				IF(OLD.de_ciclo_trabalho <> NEW.de_ciclo_trabalho) THEN
					out_json = out_json ||'"Descrição":["' || coalesce(OLD.de_ciclo_trabalho, '')  || '","'  || coalesce(NEW.de_ciclo_trabalho, '') || '"],';
				END IF;
				
				IF(OLD.dt_inicio_ciclo_trabalho <> NEW.dt_inicio_ciclo_trabalho) THEN
					out_json = out_json ||'"Data de Início":["' || coalesce(to_char(OLD.dt_inicio_ciclo_trabalho, 'DD/MM/YYYY HH24:MI'), '')  || '","'  || coalesce(to_char(NEW.dt_inicio_ciclo_trabalho, 'DD/MM/YYYY HH24:MI'), '') || '"],';
				END IF;
				
				IF(OLD.dt_alvo_ciclo_trabalho <> NEW.dt_alvo_ciclo_trabalho) THEN
					out_json = out_json ||'"Data Prevista":["' || coalesce(to_char(OLD.dt_alvo_ciclo_trabalho, 'DD/MM/YYYY HH24:MI'), '')  || '","'  || coalesce(to_char(NEW.dt_alvo_ciclo_trabalho, 'DD/MM/YYYY HH24:MI'), '') || '"],';
				END IF;
				
				IF(OLD.vr_questionario_avaliacao <> NEW.vr_questionario_avaliacao) THEN
					out_json = out_json ||'"Valor Questionario da Avaliação":["' || coalesce(OLD.vr_questionario_avaliacao::text, '')  || '","'  || coalesce(NEW.vr_questionario_avaliacao::text, '') || '"],';
				END IF;
				
				IF(OLD.vr_nota_qualidade_produto <> NEW.vr_nota_qualidade_produto) THEN
					out_json = out_json ||'"Valor da Nota da Qualidade do Produto":["' || coalesce(OLD.vr_nota_qualidade_produto::text, '')  || '","'  || coalesce(NEW.vr_nota_qualidade_produto::text, '') || '"],';
				END IF;
				
				IF(OLD.vr_total_apurado_avaliacao <> NEW.vr_total_apurado_avaliacao) THEN
					out_json = out_json ||'"Valor Total Apurado da Avaliação":["' || coalesce(OLD.vr_total_apurado_avaliacao::text, '')  || '","'  || coalesce(NEW.vr_total_apurado_avaliacao::text, '') || '"],';
				END IF;
				
				IF(OLD.nu_mtrca_avaliacao_equipe <> NEW.nu_mtrca_avaliacao_equipe) THEN
					out_json = out_json ||'"Número da Matrícula da Avaliação Equipe":["' || coalesce(OLD.nu_mtrca_avaliacao_equipe::text, '')  || '","'  || coalesce(NEW.nu_mtrca_avaliacao_equipe::text, '') || '"],';
				END IF;
				
				IF(OLD.de_justificativa_falha <> NEW.de_justificativa_falha) THEN
					out_json = out_json ||'"Descrição da Justificativa Falha":["' || coalesce(OLD.de_justificativa_falha, '')  || '","'  || coalesce(NEW.de_justificativa_falha, '') || '"],';
				END IF;
				
				IF(old_de_situacao <> new_de_situacao) THEN
					out_json = out_json ||'"Situação":["' || coalesce(old_de_situacao, '')  || '","'  || coalesce(new_de_situacao, '') || '"],';
				END IF;
				
				out_json = out_json ||'"Sprint":["'                || coalesce(NEW.nu_ciclo_trabalho::text, '')                   			|| '"]';
				
				-- close json
				out_json = out_json || '}';
		end if;
	
		--Excluir Sprint
		if(NEW.nu_acao_historico = 176) then
		
			-- open json    
				out_json = '{';

			out_json = out_json ||'"Equipe":["'                		|| coalesce(new_co_equipe, '')                   				|| '"],';
			out_json = out_json ||'"Sprint":["'                || coalesce(NEW.nu_ciclo_trabalho::text, '')                   			|| '"],';
			
			if(NEW.de_ciclo_trabalho is not null and NEW.de_ciclo_trabalho <> '') then
				out_json = out_json ||'"Descrição":["'             	|| coalesce(NEW.de_ciclo_trabalho, '')                   			|| '"],';
			end if;
			
			out_json = out_json ||'"Data de Início":["' 		|| coalesce(to_char(NEW.dt_inicio_ciclo_trabalho, 'DD/MM/YYYY HH24:MI'), '') 	|| '"],';		
			out_json = out_json ||'"Data Prevista":["' 		|| coalesce(to_char(NEW.dt_alvo_ciclo_trabalho, 'DD/MM/YYYY HH24:MI'), '') 	|| '"],';
			
			if(NEW.dt_final_ciclo_trabalho IS NOT NULL)then
				out_json = out_json ||'"Data Final":["' 		|| coalesce(to_char(NEW.dt_final_ciclo_trabalho, 'DD/MM/YYYY HH24:MI'), '') 	|| '"],';
			end if;
			
			out_json = out_json ||'"Código Falha do Ciclo Trabalho":["'             || coalesce(NEW.co_falha_ciclo_trabalho, '')                    		|| '"],';
			out_json = out_json ||'"Situação":["'              	|| coalesce(new_de_situacao, '')    			|| '"]';		
			
			-- close json
				out_json = out_json || '}';
				
		end if;
	
		--Incluir Avaliação da Sprint
		if(NEW.nu_acao_historico = 177) then
		
				new_vr_questionario_avaliacao_trunc := trunc(NEW.vr_questionario_avaliacao, 2);
				new_vr_nota_qualidade_produto_trunc := trunc(NEW.vr_nota_qualidade_produto, 2);
		
				-- open json    
				out_json = '{';
				
				out_json = out_json ||'"Equipe":["'              			  || coalesce(new_co_equipe, '')    						 || '"],';
				
				if(new_co_solicitacao is not null and new_co_solicitacao <> '') then
					out_json = out_json ||'"Código da Solicitação":["'				  || coalesce(new_co_solicitacao, '')   					 || '"],';
				end if;
				
				out_json = out_json ||'"Sprint":["'                || coalesce(NEW.nu_ciclo_trabalho::text, '')                   			|| '"],';
				
				out_json = out_json ||'"Valor calculado do questionário":["'				  || coalesce(REPLACE(new_vr_questionario_avaliacao_trunc::text,'.',','), '')  					 || '"],';
				out_json = out_json ||'"Valor de qualidade de produto (nota do código)":["'				  		  || coalesce(REPLACE(new_vr_nota_qualidade_produto_trunc::text,'.',','), '')    					 || '"],';
				
				if(NEW.nu_ciclo_trabalho is not null) then
					out_json = out_json ||'"Tamanho":["'				  || coalesce(REPLACE(new_tamanho_servico::text,'.',','), '')  					 || '"],';
				end if;
		
				
				if(new_dh_avaliacao_solicitacao is not null) then
					out_json = out_json ||'"Data Fim de Atendimento":["'                || coalesce(to_char(new_dh_avaliacao_solicitacao,  'DD/MM/YYYY HH24:MI'), '') || '"],';
				end if;
				
				out_json = out_json ||'"Situação":["'				  || coalesce(new_situacao, '')   					 || '"]';
		
				
					-- close json
				out_json = out_json || '}';

				
		end if;      

		--Alterar Avaliação da Sprint
		if(NEW.nu_acao_historico = 178)then
		
			old_vr_nota_qualidade_produto_trunc := trunc(OLD.vr_nota_qualidade_produto,2);
			new_vr_nota_qualidade_produto_trunc := trunc(NEW.vr_nota_qualidade_produto,2);
			
			new_vr_questionario_avaliacao_trunc := trunc(NEW.vr_questionario_avaliacao, 2);
			old_vr_questionario_avaliacao_trunc := trunc(OLD.vr_questionario_avaliacao, 2);
			
			-- open json    
			out_json = '{';
			
			out_json = out_json ||'"Equipe":["'              			  || coalesce(new_co_equipe, '')    						 || '"],';
			out_json = out_json ||'"Código da Solicitação":["'				  || coalesce(new_co_solicitacao, '')   					 || '"],';
			
			out_json = out_json ||'"Valor calculado do questionário":["' || coalesce(REPLACE(old_vr_questionario_avaliacao_trunc::text,'.',','), '')  
											|| '","' 
											|| coalesce(REPLACE(new_vr_questionario_avaliacao_trunc::text,'.',','), '') || '"],';
			
							
			out_json = out_json ||'"Valor de qualidade de produto (nota do código)":["' || coalesce(REPLACE(old_vr_nota_qualidade_produto_trunc::text,'.',','), '')  
											|| '","' 
											|| coalesce(REPLACE(new_vr_nota_qualidade_produto_trunc::text,'.',','), '')  || '"],';
											
			out_json = out_json ||'"Sprint":["'                || coalesce(NEW.nu_ciclo_trabalho::text, '')                   			|| '"]';
																	
			-- close json
			out_json = out_json || '}';
			
		end if;
	
		--Incluir Registro de Falha Sprint
		if(NEW.nu_acao_historico = 197)then
		
			-- open json    
			out_json = '{';

			out_json = out_json || '"Equipe":["'				             || coalesce(new_co_equipe, '') || '"],';	
			out_json = out_json || '"Código da Solicitação":["'	     || coalesce(new_co_solicitacao, '') || '"],';				
			out_json = out_json || '"Justficativa Falha":["'         || coalesce(NEW.de_justificativa_falha::text, '') || '"],';
			out_json = out_json || '"Justificativa da Alteração":["' || coalesce(NEW.de_justificativa_alteracao::text, '') || '"],';
			out_json = out_json || '"Sprint":["'				             || coalesce(OLD.nu_ciclo_trabalho::text, '') || '"]';
																	
				-- close json
			out_json = out_json || '}';
			
		end if;
	
		--Excluir Registro de Falha Sprint
		if(NEW.nu_acao_historico = 198) then
		
				IF(OLD.de_justificativa_falha <> NEW.de_justificativa_falha) THEN
					-- open json    
					out_json = '{';

					out_json = out_json || '"Equipe":["'                          || coalesce(new_co_equipe, '') || '"],';
					out_json = out_json || '"Código da Solicitação":["'           || coalesce(new_co_solicitacao, '') || '"],';
					out_json = out_json || '"Justficativa Cancelamento Falha":["' || coalesce(NEW.de_justificativa_falha::text, ' ') || '"],';
					out_json = out_json || '"Sprint":["'                          || coalesce(OLD.nu_ciclo_trabalho::text, '') || '"]';
																	
						-- close json
					out_json = out_json || '}';
				
			END IF;
			
		end if;

	
		--Fechar Sprint
		if(NEW.nu_acao_historico = 223) then
		 
					-- open json    
					out_json = '{';

					out_json = out_json || '"Equipe":["'                          || coalesce(new_co_equipe, '') || '"],';
					out_json = out_json || '"Justficativa Fechar Sprint":["' || coalesce(NEW.de_justificativa_fechamento::text, ' ') || '"],';
					out_json = out_json || '"Sprint":["'                          || coalesce(OLD.nu_ciclo_trabalho::text, '') || '"]';
																	
						-- close json
					out_json = out_json || '}';
				 
		end if;
	
		--Reabrir Sprint
		if(NEW.nu_acao_historico = 224) then
		 
					-- open json    
					out_json = '{';

					out_json = out_json || '"Equipe":["'                          || coalesce(new_co_equipe, '') || '"],';
					out_json = out_json || '"Justficativa Reabrir Sprint":["' || coalesce(NEW.de_justificativa_cancelar_fechamento::text, ' ') || '"],';
					out_json = out_json || '"Sprint":["'                          || coalesce(OLD.nu_ciclo_trabalho::text, '') || '"]';
																	
						-- close json
					out_json = out_json || '}';
				 
		end if;
	
	
	end if;

	INSERT INTO gct.gcttb308_historico_equipe(nu_historico_equipe, nu_acao_historico, nu_mtrca_acao_hstro, dh_acao_historico, de_campo_alterado, nu_equipe, nu_ciclo_trabalho)
	VALUES (NEXTVAL('gct.gctsq308_nu_historico_equipe'), NEW.nu_acao_historico, NEW.nu_mtrca_acao_hstro, now() + interval '1 millisecond', out_json::text, NEW.nu_equipe, NEW.nu_ciclo_trabalho);

	RETURN NULL;
end;
$function$;

alter function gct.gctfn005_gravar_ciclo_trabalho() owner to gct;

--
-- FIM
--

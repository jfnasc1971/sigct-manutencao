--
-- INICIO
--

--------------------------------------------------------------------------------
-- -- gctfn001_gravar_hstrco_contrato
-- --------------------------------------------------------------------------------

-- drop function if exists gct.gctfn001_gravar_hstrco_contrato();

CREATE OR REPLACE FUNCTION gct.gctfn001_gravar_hstrco_contrato()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$

/*

RELEASE NOTES

RTC 24449383 - SIGCT - Inclusão de parâmetro para ativar os indicadores do especializado

*/

declare

  v_nu_contrato numeric;
  v_no_contrato text;
  v_co_contrato text;

  out_json text;
  houve_alteracao boolean;
    
begin

  houve_alteracao = false;

  out_json = null;

  if( tg_op = 'UPDATE' ) then

    select
      c.nu_contrato,
      c.no_contrato,
      c.co_contrato
    into
      v_nu_contrato,
      v_no_contrato,
      v_co_contrato
    from
      gct.gcttb010_contrato c
    where
      nu_contrato = NEW.nu_contrato;

    if OLD.ic_hblta_clclo_indicador <> NEW.ic_hblta_clclo_indicador then 

      raise notice '%', NEW.nu_contrato;

      out_json = '{';

      out_json = out_json ||'"Contrato":["' || v_co_contrato || ' - ' ||v_no_contrato || '"],';
      out_json = out_json ||'"Cálculo de Indicadores Habilitado":["' 
                          || case when OLD.ic_hblta_clclo_indicador = 'S' then 'Sim' else 'Não' end
                          || '","' 
                          || case when NEW.ic_hblta_clclo_indicador = 'S' then 'Sim' else 'Não' end
                          || '"],';

      houve_alteracao = true;  

    end if;

  end if;

  out_json = substr(out_json, 0, length(out_json)) || '}';

  raise notice '%', out_json;

  if houve_alteracao and (out_json like '{%}' and length(out_json) > 2) then

    INSERT INTO gct.gcttb361_hstrco_contrato (
      nu_hstrco_contrato,
      nu_acao_historico,
      nu_mtrca_acao_hstro,
      dh_acao_historico,
      de_campo_alterado,
      nu_contrato
    )
    VALUES (
      nextval('gct.gctsq361_nu_hstrco_contrato'),
      NEW.nu_acao_historico,
      NEW.nu_mtrca_acao_hstro,
      current_timestamp,
      out_json :: text,
      OLD.nu_contrato
    );

  end if;

  RETURN NULL;
end;
$function$;

alter function gct.gctfn001_gravar_hstrco_contrato() owner to gct;

--
-- FIM
--

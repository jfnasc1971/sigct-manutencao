CREATE OR REPLACE FUNCTION gct.gctfn900_RTC23671403_3() RETURNS void AS
$BODY$

DECLARE

  v_file_name text := 'RTC23671403_05_DDL.sql';

BEGIN

--
-- RTC 23671403 - SIGCT - Indicadores do contrato especializado
--

--
-- INICIO
--

--
-- MARCA A SOLICITACOES PARA SEREM REPROCESSADAS E O SISTEMA REGISTRAR A DATA DE INICIO DE DESENVOLVIMENTO
--
update
  gct.gcttb005_solicitacao s
set
  ic_pendente_atualizacao = 'S'
from
  gct.gcttb087_equipe e
  inner join gct.gcttb086_solicitacao_equipe se on se.nu_equipe = e.nu_equipe
where
  e.nu_contrato between 201 and 206
  and se.nu_solicitacao = s.nu_solicitacao;

--
-- AGENDAMENTO DO TURNOVER
--
perform 
  c.nu_contrato, gct.gctfn140_agendar_calculo_indicador(c.nu_contrato, 40, c.dt_inicio_compromisso, 3, 36)
from 
  gct.gcttb010_contrato c
where 
  c.nu_contrato between 201 and 206;

--
-- FIM
--

perform  gct.gctfn906_registrar_objetodb(v_file_name);

EXCEPTION WHEN OTHERS THEN 
  raise notice 'ERROR: SQLSTATE: % SQLERRM: %', SQLSTATE, SQLERRM;
    perform gct.gctfn906_registrar_objetodb(v_file_name, SQLERRM, SQLSTATE);

END;
$BODY$
LANGUAGE plpgsql;

ALTER FUNCTION gct.gctfn900_RTC23671403_3() OWNER TO gct;

--
--
--
CREATE OR REPLACE FUNCTION gct.gctfn900_RTC23671403_retornar_3() RETURNS void AS
$BODY$

DECLARE

  v_file_name text := 'RTC23671403_03_DDL.sql';

BEGIN

--
-- RTC 23671403 - SIGCT - Indicadores do contrato especializado
--

--
-- INICIO
--

--
-- DESMARCA A SOLICITACOES PARA SEREM REPROCESSADAS E O SISTEMA REGISTRAR A DATA DE INICIO DE DESENVOLVIMENTO
--
update
  gct.gcttb005_solicitacao s
set
  ic_pendente_atualizacao = 'N'
from
  gct.gcttb087_equipe e
  inner join gct.gcttb086_solicitacao_equipe se on se.nu_equipe = e.nu_equipe
where
  e.nu_contrato between 201 and 206
  and se.nu_solicitacao = s.nu_solicitacao;

--
-- AGENDAMENTO DO TURNOVER
--
delete from gct.gcttb269_valor_indicador_contratada where nu_tipo_indicador=40;
delete from gct.gcttb283_agendamento_indicador;

--
-- FIM
--

perform  gct.gctfn906_registrar_objetodb(v_file_name);

EXCEPTION WHEN OTHERS THEN 
  raise notice 'ERROR: SQLSTATE: % SQLERRM: %', SQLSTATE, SQLERRM;
    perform gct.gctfn906_registrar_objetodb(v_file_name, SQLERRM, SQLSTATE);

END;
$BODY$
LANGUAGE plpgsql;

ALTER FUNCTION gct.gctfn900_RTC23671403_retornar_3() OWNER TO gct;


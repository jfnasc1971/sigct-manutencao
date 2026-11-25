begin;

--
-- RTC 23671403 - SIGCT - Indicadores do contrato especializado
--

--
-- INICIO
--

--
--
--
drop table if exists gct.gcttb900_nota_codigo;

--
--
--

-- "sigla": "SIABE",
-- "ciclo": "05/2025",
-- "nota": 10.0

create table gct.gcttb900_nota_codigo(
  ciclo varchar(10)  not null,
  sigla varchar(10)  not null,
  nota  numeric(5,2) not null
);

ALTER TABLE gct.gcttb900_nota_codigo OWNER TO gct;

--
-- FIM
--

commit;

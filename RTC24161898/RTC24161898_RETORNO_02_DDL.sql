begin;

--
-- RTC 24379532 - SIGCT - Análise e correção do BEF
--

--
-- INICIO
--

drop function if exists gct.gctfn900_rtc24161898();
drop function if exists gct.gctfn900_rtc24161898_retornar();

-- Index: gct.ix_gcttb170_6

DROP INDEX IF EXISTS gct.ix_gcttb170_6;

-- Index: gct.ix_gcttb170_7

DROP INDEX IF EXISTS gct.ix_gcttb170_7;

-- Index: gct.ix_gcttb170_8

DROP INDEX IF EXISTS gct.ix_gcttb170_8;

ANALYZE gct.gcttb170_termo_equipe;

--
-- FIM
--
insert into gct.gcttb900_hstco_objetos_bd(no_objeto) values ('RTC24379532_01_DML.sql');

commit;

begin;

--
-- RTC 23671403 - SIGCT - Indicadores do contrato especializado
--

--
-- INICIO
--

update gct.gcttb087_equipe set dt_considerar_fns = '2025-07-01' where nu_contrato between 201 and 206;

--
-- PONTOS DE FUNCAO
--
ALTER TABLE gct.gcttb086_solicitacao_equipe disable TRIGGER all;  

--explain analyze
UPDATE
  gct.gcttb086_solicitacao_equipe a
SET
  nu_tamanho_servico = substr(a.nu_solicitacao :: text, 4, 2) :: float / 5
FROM
  gct.gcttb087_equipe e
where
  a.nu_equipe = e.nu_equipe
  and e.nu_contrato between 201 and 206;

ALTER TABLE gct.gcttb086_solicitacao_equipe enable TRIGGER all;  

delete from gct.gcttb269_valor_indicador_contratada vie where nu_tipo_indicador = 45 and nu_contrato between 201 and 206;
delete from gct.gcttb172_valor_indicador_equipe vie where nu_contrato between 201 and 206;
delete FROM gct.gcttb104_sequencial_termo where nu_tipo_termo = 21;

alter table gct.gcttb170_termo_equipe disable trigger all;
delete from gct.gcttb170_termo_equipe where nu_tipo_termo = 21;
alter table gct.gcttb170_termo_equipe enable trigger all;

select gct.gctfn111_processar_indicadores('2025-06-05',1);
select gct.gctfn111_processar_indicadores('2025-07-05',1);
select gct.gctfn111_processar_indicadores('2025-08-05',1);
select gct.gctfn111_processar_indicadores('2025-09-05',1);
select gct.gctfn111_processar_indicadores('2025-10-05',1);

-- select gct.gctfn111_processar_indicadores('2025-10-05',1,e.nu_contrato, e.nu_equipe) from gct.gcttb087_equipe e where e.co_equipe='BRE202500345';
-- select gct.gctfn111_processar_indicadores('2025-10-05',1,e.nu_contrato, e.nu_equipe) from gct.gcttb087_equipe e where e.co_equipe='BRE202500189';
-- select gct.gctfn111_processar_indicadores('2025-10-05',1,e.nu_contrato, e.nu_equipe) from gct.gcttb087_equipe e where e.co_equipe='BRE202500206';

--select gct.gctfn111_processar_indicadores('2025-08-05',1,e.nu_contrato, e.nu_equipe) from gct.gcttb087_equipe e where e.co_equipe='BRE202500278';
--select gct.gctfn111_processar_indicadores('2025-09-05',1,e.nu_contrato, e.nu_equipe) from gct.gcttb087_equipe e where e.co_equipe='BRE202500278';
--select gct.gctfn111_processar_indicadores('2025-10-05',1,e.nu_contrato, e.nu_equipe) from gct.gcttb087_equipe e where e.co_equipe='BRE202500278';

--select gct.gctfn111_processar_indicadores('2025-10-05',1,e.nu_contrato, e.nu_equipe) from gct.gcttb087_equipe e where e.co_equipe='BRE202500189';

--\i resultados_indicador.sql
--
-- FIM
--

commit;


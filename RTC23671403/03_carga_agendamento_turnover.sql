begin;

--
--
--

delete from gct.gcttb269_valor_indicador_contratada where nu_tipo_indicador=40;
delete from gct.gcttb283_agendamento_indicador;

select 
  c.nu_contrato, gct.gctfn140_agendar_calculo_indicador(c.nu_contrato, 40, c.dt_inicio_compromisso, 3, 36)
from 
  gct.gcttb010_contrato c
where 
  c.nu_contrato between 201 and 206;

select nu_contrato, count(*) 
from gct.gcttb283_agendamento_indicador 
group by nu_contrato
order by nu_contrato;

select * from gct.gcttb283_agendamento_indicador 
where nu_contrato=203 
order by dt_execucao_prevista; 

-- SELECT
--   c.nu_contrato,
--   c.no_contrato,
--   gct.gctfn174_indicador_turnover(c.nu_contrato, 1)
-- FROM
--   gct.gcttb010_contrato c
-- WHERE
--   1=1
--   --and c.nu_contrato between 201 and 206
--   and c.nu_contrato = 201
-- order by
--   c.nu_contrato,
--   c.no_contrato;

-- select * FROM gct.gcttb283_agendamento_indicador where nu_contrato = 201 order by dt_execucao_prevista;  

commit;
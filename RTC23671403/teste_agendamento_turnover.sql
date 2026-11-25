\i 'src/Objetos_BD/Functions/GCTFN140_AGENDAR_CALCULO_INDICADOR_DDL.sql' 

begin;

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

commit;
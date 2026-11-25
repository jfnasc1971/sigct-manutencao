CREATE OR REPLACE FUNCTION diff_meses_dias(p_data_inicial DATE, p_data_final DATE)
RETURNS TEXT AS $$
DECLARE
  v_meses INTEGER;
  v_dias  INTEGER;
BEGIN
  v_meses := (EXTRACT(YEAR FROM age(p_data_final, p_data_inicial)) * 12 +
              EXTRACT(MONTH FROM age(p_data_final, p_data_inicial)));
  v_dias := p_data_final - (p_data_inicial + (v_meses || ' month')::interval);
  RETURN v_meses || ' mes(es) e ' || v_dias || ' dia(s)';
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION diff_meses(p_data_inicial DATE, p_data_final DATE)
RETURNS INTEGER AS $$
DECLARE
  v_meses INTEGER;
BEGIN
  v_meses := (EXTRACT(YEAR FROM age(p_data_final, p_data_inicial)) * 12 +
              EXTRACT(MONTH FROM age(p_data_final, p_data_inicial)));
  RETURN v_meses;
END;
$$ LANGUAGE plpgsql;

select
  e.dt_inicio_atendimento,
  e.dt_considerar_fns,
  diff_meses(e.dt_inicio_atendimento::date, e.dt_considerar_fns::date),
  e.dt_considerar_fns - e.dt_inicio_atendimento
from
  gct.gcttb087_equipe e
where
  e.dt_considerar_fns is not null
  and e.nu_contrato in (201,202,203,204,205,206);
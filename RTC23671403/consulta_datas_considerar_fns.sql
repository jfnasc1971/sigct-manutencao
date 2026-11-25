select
  c.nu_contrato,
  c.no_contrato "Contrato",
  c.dt_inicio_compromisso "Dt. Início Compromisso",
  min(s.co_solicitacao) "Primeiro IB",
  min(s.dh_cadastro) :: date "Dt. Início Primeiro Atendimento",
  (min(s.dh_cadastro) + 4 * interval '1 month') :: date "Dt. Início Primeiro Atendimento + 4 meses"
from
  gct.gcttb010_contrato c
  inner join gct.gcttb087_equipe e on e.nu_contrato = c.nu_contrato
  inner join gct.gcttb086_solicitacao_equipe se on se.nu_equipe = e.nu_equipe
  inner join gct.gcttb005_solicitacao s on (
    s.nu_solicitacao = se.nu_solicitacao
    and s.dh_cadastro > c.dt_inicio_compromisso
  ) -- o primeiro cadastrado apos o inicio do contrato
where
  c.nu_contrato between 201 and 206
group by
  c.no_contrato,
  c.dt_inicio_compromisso,
  c.nu_contrato
order by
  1;


select
  --'update gct.gcttb033_grupo_contrato set dt_considerar_fns = '|| quote_literal((min(s.dh_cadastro) + 4 * interval '1 month') :: date),
  format('update gct.gcttb033_grupo_contrato set dt_considerar_fns=%L where nu_contrato=%s;',
    (min(s.dh_cadastro) + 4 * interval '1 month') :: date, 
    c.nu_contrato) --,
  --c.no_contrato "Contrato",
  --c.dt_inicio_compromisso "Dt. Início Compromisso",
  --min(s.co_solicitacao) "Primeiro IB",
  --min(s.dh_cadastro) :: date "Dt. Início Primeiro Atendimento",
  --(min(s.dh_cadastro) + 4 * interval '1 month') :: date "Dt. Início Primeiro Atendimento + 4 meses"
from
  gct.gcttb010_contrato c
  inner join gct.gcttb087_equipe e on e.nu_contrato = c.nu_contrato
  inner join gct.gcttb086_solicitacao_equipe se on se.nu_equipe = e.nu_equipe
  inner join gct.gcttb005_solicitacao s on (
    s.nu_solicitacao = se.nu_solicitacao
    and s.dh_cadastro > c.dt_inicio_compromisso
  ) -- o primeiro cadastrado apos o inicio do contrato
where
  c.nu_contrato between 201 and 206
group by
  c.no_contrato,
  c.dt_inicio_compromisso,
  c.nu_contrato
order by
  1;
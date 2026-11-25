begin;

--
--
--

update gct.gcttb087_equipe set dt_considerar_fns = null;

UPDATE
  gct.gcttb005_solicitacao a
SET
  dh_inicio_desenvolvimento = dh_cadastro
FROM
  gct.gcttb087_equipe e
  join gct.gcttb086_solicitacao_equipe se on e.nu_equipe = se.nu_equipe
WHERE
  a.nu_solicitacao = se.nu_solicitacao
  and e.nu_situacao_equipe in (1,2)
  AND e.nu_contrato between 201 and 206;

select
  e.co_equipe, gct.gctfn137_obter_dt_considerar_fns_equipe(e.nu_equipe)
FROM
  gct.gcttb087_equipe e
WHERE
  e.nu_contrato between 201 and 206;

commit;
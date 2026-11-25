begin;
delete from gct.gcttb086_solicitacao_equipe where (nu_equipe, nu_ciclo_trabalho) in (
  select nu_equipe, nu_ciclo_trabalho from gct.gcttb088_ciclo_trabalho where co_sysid_servicenow is not null
);
delete from gct.gcttb088_ciclo_trabalho where co_sysid_servicenow is not null;
commit;

-- co_equipe	co_ciclo_trabalho	co_solicitacao	nu_unidade_custo	nu_natural_custo
-- BRE202600349	CL080 - 2026 PI3 Sprint 2	STRY00011292	5088	8274
-- BRE202600349	CL080 - 2026 PI3 Sprint 3	STRY00012916	5088	8274
-- BRE202600132	FD029 - PI3 (3 sem) Sprint 1	STRY00011322	<null>	<null>
-- BRE202600128	BC101 - SIGEC Comercial - PI3 (3 sem) Sprint 1	STRY00011901	<null>	<null>
-- BRE202500253	FD019 - PI3 (3 sem) Sprint 1	STRY00011126	5088	8274
-- BRE202500495	FS005 - 2026 PI3 Sprint 1	STRY0011043	<null>	<null>
-- BRE202500220	PS009 - 2026 PI3 Sprint 1	STRY00011521	5088	8274
-- BRE202600282	BM003 - BPPMO03 - SIGDU - 2026 PI3 Sprint 1	STRY00011809	5280	8073
-- BRE202600285	FD030 - PI3 (3 sem) Sprint 1	STRY00011093	5088	8274

\i 'src/Objetos_BD/Functions/GCTFN136_REGISTRAR_SOLICITACOES_BEF_DDL.sql'

begin;

update gct.gcttb005_solicitacao set ic_bef = 'N';

select gct.gctfn136_registrar_solicitacoes_bef();--1455972);

-- select
--   s.nu_solicitacao,
--   s.co_solicitacao,
--   s.nu_rubrica,
--   s.co_rubrica,
--   s.ic_bef
-- from
--   gct.gcttb005_solicitacao s
-- where
--   s.co_solicitacao = '24018105';

select s.co_solicitacao, ic_bef from gct.gcttb005_solicitacao s where s.co_solicitacao in ('22392972','22571508');
select s.co_solicitacao, a.ic_bef from gct.gcttb178_amostra_solicitacao a inner join gct.gcttb005_solicitacao s on s.nu_solicitacao = a.nu_solicitacao where s.co_solicitacao in ('22392972','22571508');
select s.co_solicitacao, a.ic_bef from gct.gcttb177_amostra_solicitacao_equipe a inner join gct.gcttb005_solicitacao s on s.nu_solicitacao = a.nu_solicitacao where s.co_solicitacao in ('22392972','22571508');

select
  s.de_tipo_solicitacao, s.ic_bef, count(*)
from
  gct.gcttb005_solicitacao s
where
  s.ic_bef = 'S'
group by
  s.de_tipo_solicitacao, s.ic_bef;


rollback;
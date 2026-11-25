select * from gct.gcttb119_amostra_entrega_indicador where nu_contrato=659 and nu_fatura_impactada=5851;
select * from gct.gcttb124_amostra_termo_indicador where nu_contrato=659 and nu_fatura_impactada=5851;
select * from gct.gcttb113_valor_indicador where nu_contrato=659 and dt_final_indicador='2025-07-20';

select * from gct.gcttb119_amostra_entrega_indicador_bkp where nu_entrega in ('573307','573238','573306')

create table gct.gcttb119_amostra_entrega_indicador_bkp as select * from gct.gcttb119_amostra_entrega_indicador;
create table gct.gcttb124_amostra_termo_indicador_bkp as select * from gct.gcttb124_amostra_termo_indicador;
create table gct.gcttb113_valor_indicador_bkp as select * from gct.gcttb113_valor_indicador;

select * from gct.gcttb119_amostra_entrega_indicador where nu_contrato=659 and nu_fatura_impactada=5851 and dh_efetiva_entrega is null
select * from gct.gcttb119_amostra_entrega_indicador_bkp where nu_contrato=659 and nu_fatura_impactada=5851 and dh_efetiva_entrega is null
select * from gct.gcttb119_amostra_entrega_indicador where nu_contrato=659 and nu_fatura_impactada=5851 and dh_efetiva_entrega > dh_prevista_entrega
select * from gct.gcttb124_amostra_termo_indicador where nu_contrato=659 and nu_fatura_impactada=5851
select * from gct.gcttb113_valor_indicador where nu_contrato=659 and dt_final_indicador='2025-07-20';

select distinct 'insert into gct.gcttb111_ajuste(nu_ajuste,nu_ordem_servico,nu_situacao_ajuste) values (nextval(''gct.gctsq111_nu_ajuste''),'||nu_ordem_servico ||',1);'
from gct.gcttb100_termo where nu_contrato=659 and nu_fatura_gerada=5851 and vr_financeiro_termo <> vr_financeiro_termo_original;

select distinct 'delete from gct.gcttb111_ajuste where nu_situacao_ajuste=1 and nu_ordem_servico='||nu_ordem_servico ||';'
from gct.gcttb100_termo where nu_contrato=659 and nu_fatura_gerada=5851 and vr_financeiro_termo <> vr_financeiro_termo_original;

select 
  com.no_comunidade, ai.no_sigla_area, d.co_demanda, os.co_ordem_servico, te.co_termo, te.vr_financeiro_termo
from 
  gct.gcttb023_ordem_servico os
  inner join gct.gcttb001_area_interna ai on ai.nu_area_interna = os.nu_area_contratante
  inner join gct.gcttb405_comunidade com on com.nu_comunidade = ai.nu_comunidade
  inner join gct.gcttb021_demanda d on d.nu_demanda = os.nu_demanda
  inner join gct.gcttb100_termo te on te.nu_ordem_servico = os.nu_ordem_servico
where 
  os.nu_contrato = 659
  and te.dh_emissao_termo::date = current_date

select s.co_solicitacao, ic_bef, s.co_solicitacao_bef, s.no_sigla_sistema, s.no_item_portfolio from gct.gcttb005_solicitacao s where s.co_solicitacao in ('22392972','22571508');
select s.co_solicitacao, a.ic_bef from gct.gcttb178_amostra_solicitacao a inner join gct.gcttb005_solicitacao s on s.nu_solicitacao = a.nu_solicitacao where s.co_solicitacao in ('22392972','22571508');
select s.co_solicitacao, a.ic_bef from gct.gcttb177_amostra_solicitacao_equipe a inner join gct.gcttb005_solicitacao s on s.nu_solicitacao = a.nu_solicitacao where s.co_solicitacao in ('22392972','22571508');

select
  sbef.nu_solicitacao as nu_necessidade,
  sbef.co_solicitacao as co_necessidade,
  a.co_solicitacao as co_avaliacao,
  a.nu_situacao_solicitacao,
  a.co_solicitacao as co_avaliacao,
  a.no_tipo_solicitacao,
  a.de_situacao_solicitacao,
  a.no_sigla_sistema,
  a.no_item_portfolio,
  a.nu_item_portfolio,
  a.dh_avaliacao_bef
from
  gct.gcttb005_solicitacao a
  inner join gct.gcttb005_solicitacao sbef on sbef.co_solicitacao = a.co_solicitacao_pai
where
  a.no_tipo_solicitacao = 'avaliação_bef_do_ativo'
  and a.de_situacao_solicitacao = 'Aprovado'
  --and a.no_sigla_sistema = 'SICCR'
  and sbef.co_solicitacao in ('22548171','22869862')
order by
  sbef.co_solicitacao,
  a.no_sigla_sistema,
  a.no_item_portfolio;


CREATE INDEX idx_gcttb177_5
  ON gct.gcttb177_amostra_solicitacao_equipe
  USING btree
  (nu_solicitacao);

select
  s.de_tipo_solicitacao, s.ic_bef, count(*)
from
  gct.gcttb005_solicitacao s
where
  s.ic_bef = 'S'
group by
  s.de_tipo_solicitacao, s.ic_bef;


select
  distinct s.ic_bef, count(*)
from
  gct.gcttb005_solicitacao s
  inner join gct.gcttb900_teste t on t.co_solicitacao = s.co_solicitacao
  --inner join gct.gcttb177_amostra_solicitacao_equipe a on a.nu_solicitacao = s.nu_solicitacao and a.nu_fatura_amostra is not null
group by
  s.ic_bef;
      
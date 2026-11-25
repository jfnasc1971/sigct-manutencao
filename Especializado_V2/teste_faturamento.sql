\i 'src/Objetos_BD/Functions/GCTFN300_FECHAR_FATURAMENTO_DDL.sql'

begin;

select gct.gctfn803_remover_termo_ajuste_equipe(e.nu_ajuste) from gct.gcttb170_termo_equipe e where e.nu_equipe in(
   select nu_equipe from gct.gcttb087_equipe e where e.nu_contrato in (101,102,103,104,105,106)
) and e.nu_tipo_termo=12;

delete from gct.gcttb527_preco_grupo_termo e where e.nu_termo_equipe in(
   select nu_termo_equipe from gct.gcttb170_termo_equipe e where e.nu_equipe in(
      select nu_equipe from gct.gcttb087_equipe e where e.nu_contrato in (101,102,103,104,105,106)
   )
);

delete from gct.gcttb170_termo_equipe e where e.nu_equipe in(
   select nu_equipe from gct.gcttb087_equipe e where e.nu_contrato in (101,102,103,104,105,106)
);

select gct.gctfn300_fechar_faturamento('2025-07-21', 106); --, p_nu_equipe numeric DEFAULT NULL::numeric)

select gct.gctfn080_gerar_empenho(5261, 106, 1, 1);

update gct.gcttb102_fatura f set nu_situacao_fatura=5 where nu_fatura=5261;

select gct.gctfn129_consolidar_dstrbco_custos('Julho/2025', 1, 106, 'E');

select e.co_equipe, te.co_termo, te.nu_fatura_paga, te.vr_financeiro_termo 
from gct.gcttb087_equipe e 
inner join gct.gcttb170_termo_equipe te on te.nu_equipe = e.nu_equipe
where e.co_equipe in ('BRE202500171','BRE202500172');

update gct.gcttb102_fatura f set nu_situacao_fatura=4 where nu_fatura=5261;

commit;
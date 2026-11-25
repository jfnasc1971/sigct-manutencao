begin;

update gct.gcttb170_termo_equipe te set nu_situacao_termo=6
from gct.gcttb102_fatura f 
where f.nu_fatura = te.nu_fatura_gerada and f.dt_final_fatura='2025-10-20'
and nu_contrato = 849 and te.nu_tipo_termo=11;

select gct.gctfn300_fechar_faturamento('2025-10-21', 849);

commit;
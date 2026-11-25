
begin;

update gct.gcttb102_fatura f set nu_situacao_fatura=1 where f.de_fatura='Novembro/2025';
update gct.gcttb102_fatura f set nu_situacao_fatura=2 where f.de_fatura='Outubro/2025';

update gct.gcttb170_termo_equipe te 
   set nu_situacao_termo = 6 
  from gct.gcttb102_fatura f 
 where f.nu_fatura = te.nu_fatura_gerada
   and f.dt_final_fatura = '2025-10-20';


--select gct.gctfn300_fechar_faturamento('2025-10-21'); --, 719, 907); --, p_nu_equipe numeric DEFAULT NULL::numeric);

commit;
begin;

--
-- TERMOS
--

delete from gct.gcttb527_preco_grupo_termo e where e.nu_equipe in(
   select nu_equipe from gct.gcttb087_equipe e where e.nu_contrato in (101,102,103,104,105,106)
);

select gct.gctfn803_remover_termo_ajuste_equipe(e.nu_ajuste) from gct.gcttb170_termo_equipe e where e.nu_equipe in(
   select nu_equipe from gct.gcttb087_equipe e where e.nu_contrato in (101,102,103,104,105,106)
) and e.nu_tipo_termo=12;

delete from gct.gcttb170_termo_equipe e where e.nu_equipe in(
   select nu_equipe from gct.gcttb087_equipe e where e.nu_contrato in (101,102,103,104,105,106)
);

delete from gct.gcttb523_qntde_membro_equipe_perfil e where e.nu_equipe in(
   select nu_equipe from gct.gcttb087_equipe e where e.nu_contrato in (101,102,103,104,105,106)
);

delete from gct.gcttb419_vigencia_membros_equipe e where e.nu_equipe in (
   select nu_equipe from gct.gcttb087_equipe e where e.nu_contrato in (101,102,103,104,105,106)
);

delete from gct.gcttb308_historico_equipe e where e.nu_equipe in (
   select nu_equipe from gct.gcttb087_equipe e where e.nu_contrato in (101,102,103,104,105,106)
);

delete from gct.gcttb087_equipe e where e.nu_contrato in (101,102,103,104,105,106);

update gct.gcttb033_grupo_contrato c set nu_tp_frma_calculo_pgto=2 where nu_contrato in (101,102,103,104,105,106);

delete from gct.gcttb240_tp_frma_calculo_pgto where nu_tp_frma_calculo_pgto=4;

delete from gct.gcttb055_servico_contrato where nu_tipo_servico in(17,18);

delete from gct.gcttb015_tipo_servico where nu_tipo_servico in(17,18);

commit;
\i 'src/Objetos_BD/Functions/GCTFN803_REMOVER_TERMO_AJUSTE_EQUIPE_DDL.sql'

create index ix_gcttb264_2 on gct.gcttb264_amsta_equipe         (nu_ajuste, nu_contrato, nu_equipe);
create index ix_gcttb265_2 on gct.gcttb265_amsta_solicitacao    (nu_ajuste, nu_contrato, nu_equipe);
create index ix_gcttb266_2 on gct.gcttb266_amsta_slctco_equipe  (nu_ajuste, nu_contrato, nu_equipe); 
create index ix_gcttb267_2 on gct.gcttb267_amsta_ciclo_trabalho (nu_ajuste, nu_contrato, nu_equipe);  
create index ix_gcttb268_2 on gct.gcttb268_amsta_membros_equipe (nu_ajuste, nu_contrato, nu_equipe);  


begin;

delete from gct.gcttb310_justificativa_ajuste_equipe where nu_ajuste in (604417);

delete from gct.gcttb401_amsta_termo_ordm_pgmno_equipe where nu_termo_equipe in (
  select t.nu_termo_equipe
    from gct.gcttb087_equipe e
    inner join gct.gcttb010_contrato c on c.nu_contrato = e.nu_contrato
    inner join gct.gcttb170_termo_equipe t on t.nu_equipe = e.nu_equipe
    where t.nu_ajuste = 604417
);

delete from gct.gcttb189_movimentacao_termo where nu_termo_equipe in (
  select t.nu_termo_equipe
    from gct.gcttb087_equipe e
    inner join gct.gcttb010_contrato c on c.nu_contrato = e.nu_contrato
    inner join gct.gcttb170_termo_equipe t on t.nu_equipe = e.nu_equipe
    where t.nu_ajuste = 604417
);

delete from gct.gcttb175_amostra_equipe                 where nu_ajuste in (604417);
delete from gct.gcttb176_amostra_ciclo_trabalho         where nu_ajuste in (604417);
delete from gct.gcttb177_amostra_solicitacao_equipe     where nu_ajuste in (604417); 
delete from gct.gcttb178_amostra_solicitacao            where nu_ajuste in (604417);  
delete from gct.gcttb180_amostra_ausencia_servico_extra where nu_ajuste in (604417);  
delete from gct.gcttb181_amostra_devolucao_solicitacao  where nu_ajuste in (604417);  
delete from gct.gcttb182_amostra_pendencia_solicitacao  where nu_ajuste in (604417);   
delete from gct.gcttb183_amostra_qntde_membros_equipe   where nu_ajuste in (604417);  
delete from gct.gcttb525_amostra_qntde_membros_perfil   where nu_ajuste in (604417);

explain analyze delete from gct.gcttb264_amsta_equipe            where nu_ajuste in (604417);
explain analyze delete from gct.gcttb265_amsta_solicitacao       where nu_ajuste in (604417);
explain analyze delete from gct.gcttb266_amsta_slctco_equipe     where nu_ajuste in (604417); 
explain analyze delete from gct.gcttb267_amsta_ciclo_trabalho    where nu_ajuste in (604417);  
explain analyze delete from gct.gcttb268_amsta_membros_equipe    where nu_ajuste in (604417);  

delete from gct.gcttb172_valor_indicador_equipe         where nu_ajuste in (604417);
delete from gct.gcttb171_valor_indicador_ciclo_trabalho where nu_ajuste in (604417);

delete from gct.gcttb186_termo_ajuste_equipe where nu_ajuste in (604417);
delete from gct.gcttb187_ajuste_agil_equipe  where nu_ajuste in (604417);
delete from gct.gcttb184_ajuste_agil         where nu_ajuste in (604417);

delete from gct.gcttb170_termo_equipe        where nu_ajuste in (604417);  

-- if not exists(
--   select null from gct.gcttb187_ajuste_agil_equipe where nu_ajuste in (604417)
-- ) 
-- then
--   delete from gct.gcttb184_ajuste_agil where nu_ajuste in (604417);
-- end if;

rollback;
begin;

delete from gct.gcttb427_iteracao_service_now;
--delete from gct.gcttb426_erro_vinculacao;
--delete from gct.gcttb425_carga_service_now;

--insert into gct.gcttb425_carga_service_now select * from gct.gcttb425_carga_service_now_bkp;

--delete from gct.gcttb425_carga_service_now where item_number <> 'STRY00012893';
update gct.gcttb425_carga_service_now set ic_avaliado='P';-- where nu_controle_carga=5479;

commit;
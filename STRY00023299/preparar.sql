begin;

alter table gct.gcttb092_situacao_atendimento drop column if exists nu_ordenacao;
alter table gct.gcttb092_situacao_atendimento add nu_ordenacao numeric;

update gct.gcttb092_situacao_atendimento set no_situacao_atendimento='Pronto para testes' where no_situacao_atendimento='Pronto para Teste';
update gct.gcttb092_situacao_atendimento set no_situacao_atendimento='Trabalho em andamento' where no_situacao_atendimento='Trabalho em Andamento';

update gct.gcttb092_situacao_atendimento set nu_ordenacao=1 where ic_origem_servicenow='S' and no_situacao_atendimento='Rascunho';
update gct.gcttb092_situacao_atendimento set nu_ordenacao=2 where ic_origem_servicenow='S' and no_situacao_atendimento='Preparado';
update gct.gcttb092_situacao_atendimento set nu_ordenacao=3 where ic_origem_servicenow='S' and no_situacao_atendimento='Trabalho em andamento';
update gct.gcttb092_situacao_atendimento set nu_ordenacao=4 where ic_origem_servicenow='S' and no_situacao_atendimento='Pronto para testes';
update gct.gcttb092_situacao_atendimento set nu_ordenacao=5 where ic_origem_servicenow='S' and no_situacao_atendimento='Testando';
update gct.gcttb092_situacao_atendimento set nu_ordenacao=6 where ic_origem_servicenow='S' and no_situacao_atendimento='Pronto';
update gct.gcttb092_situacao_atendimento set nu_ordenacao=7 where ic_origem_servicenow='S' and no_situacao_atendimento='Adiado';
update gct.gcttb092_situacao_atendimento set nu_ordenacao=8 where ic_origem_servicenow='S' and no_situacao_atendimento='Cancelado';
update gct.gcttb092_situacao_atendimento set nu_ordenacao=9 where ic_origem_servicenow='S' and no_situacao_atendimento='Concluído';

update gct.gcttb092_situacao_atendimento set nu_ordenacao=8  where  ic_origem_servicenow='S' and no_situacao_atendimento='Implantado';
update gct.gcttb092_situacao_atendimento set nu_ordenacao=9  where  ic_origem_servicenow='S' and no_situacao_atendimento='Não Aceito';
update gct.gcttb092_situacao_atendimento set nu_ordenacao=1  where  ic_origem_servicenow='S' and no_situacao_atendimento='Novo';
update gct.gcttb092_situacao_atendimento set nu_ordenacao=3  where  ic_origem_servicenow='S' and no_situacao_atendimento='Em Refinamento';
update gct.gcttb092_situacao_atendimento set nu_ordenacao=7  where  ic_origem_servicenow='S' and no_situacao_atendimento='Aceito';
update gct.gcttb092_situacao_atendimento set nu_ordenacao=5  where  ic_origem_servicenow='S' and no_situacao_atendimento='Implementado';
update gct.gcttb092_situacao_atendimento set nu_ordenacao=4  where  ic_origem_servicenow='S' and no_situacao_atendimento='Em Desenvolvimento';
update gct.gcttb092_situacao_atendimento set nu_ordenacao=10 where  ic_origem_servicenow='S' and no_situacao_atendimento='Adiado';
update gct.gcttb092_situacao_atendimento set nu_ordenacao=11 where  ic_origem_servicenow='S' and no_situacao_atendimento='Cancelado';
update gct.gcttb092_situacao_atendimento set nu_ordenacao=6  where  ic_origem_servicenow='S' and no_situacao_atendimento='Pronto';
update gct.gcttb092_situacao_atendimento set nu_ordenacao=2  where  ic_origem_servicenow='S' and no_situacao_atendimento='Preparado';

-- select * from gct.gcttb092_situacao_atendimento where ic_origem_servicenow='S' order by nu_ordenacao;
-- select * from gct.gcttb092_situacao_atendimento where ic_origem_rtc='S' order by nu_ordenacao;

UPDATE gct.gcttb734_tipo_item_demanda SET nu_tipo_item_demanda=134,no_tipo_item='Hist�ria de Usu�rio',no_tipo_demanda='Inova��es em Tecnologia/N�gocio' WHERE
UPDATE gct.gcttb734_tipo_item_demanda SET nu_tipo_item_demanda=135,no_tipo_item='Hist�ria de Usu�rio',no_tipo_demanda='Manuten��o Corretiva' WHERE

UPDATE gct.gcttb734_tipo_item_demanda SET nu_tipo_item_demanda=134,no_tipo_item='História de Usuário',no_tipo_demanda='Inovações em Tecnologia/Négocio' WHERE
UPDATE gct.gcttb734_tipo_item_demanda SET nu_tipo_item_demanda=135,no_tipo_item='História de Usuário',no_tipo_demanda='Manutenção Corretiva' WHERE

INSERT INTO gct.gcttb092_situacao_atendimento VALUES (15,'Escopo','N','N','N',null);
INSERT INTO gct.gcttb092_situacao_atendimento VALUES (16,'Teste/CQ','N','N','N',null);
INSERT INTO gct.gcttb092_situacao_atendimento VALUES (17,'Implantar/Inicializar','N','N','N',null);

commit;
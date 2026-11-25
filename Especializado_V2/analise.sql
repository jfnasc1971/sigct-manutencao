\i 'src/Objetos_BD/Functions/GCTFN300_FECHAR_FATURAMENTO_DDL.sql'
\i 'src/Objetos_BD/Functions/GCTFN407_GERAR_TERMOS_RETROATIVOS_EQUIPE_DDL.sql'
\i 'src/Objetos_BD/Functions/GCTFN349_EXECUTAR_AJUSTE_EQUIPE_DDL.sql'

begin;

-- Sequence: gct.gctsq522_nu_dstrbco_profissional_perfil

DROP SEQUENCE if exists gct.gctsq522_nu_dstrbco_profissional_perfil;

CREATE SEQUENCE gct.gctsq522_nu_dstrbco_profissional_perfil
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 25000
  CACHE 1;

ALTER TABLE gct.gctsq522_nu_dstrbco_profissional_perfil OWNER TO gct;

--
--
--
INSERT INTO gct.gcttb240_tp_frma_calculo_pgto (nu_tp_frma_calculo_pgto,no_tp_frma_calculo_pgto,de_tp_frma_calculo_pgto) 
VALUES (4,'Contratos Especializados','Contratos Especializados');

--
--
--
update gct.gcttb010_contrato c set nu_tipo_contrato=1 where nu_contrato in (101,102,103,104,105,106);

update gct.gcttb033_grupo_contrato c set nu_tp_frma_calculo_pgto=4 where nu_contrato in (101,102,103,104,105,106);

delete from gct.gcttb522_dstrbco_profissional_perfil where nu_contrato in (101,102,103,104,105,106);

insert into gct.gcttb522_dstrbco_profissional_perfil
  select 
    nextval('gct.gctsq522_nu_dstrbco_profissional_perfil'),nu_perfil,null::varchar as co_sitio,c.nu_contrato,
    case when qt_profissional_perfil > 6 then qt_profissional_perfil/6 else qt_profissional_perfil end
  from 
    gct.gcttb522_dstrbco_profissional_perfil d
    inner join gct.gcttb010_contrato c on c.nu_contrato in (101,102,103,104,105,106)
    --inner join gct.gcttb003_codigo_sitio cs on cs.co_sitio in ('BR','RJ','SP')
  where 
    d.nu_contrato = 80
order by c.nu_contrato;

select 
  d.nu_contrato, count(*)
from 
  gct.gcttb522_dstrbco_profissional_perfil d 
  inner join gct.gcttb521_perfil_profissional pp on pp.nu_perfil = d.nu_perfil 
  inner join gct.gcttb524_preco_cntrto_equipe_perfil p on ( 
    p.nu_contrato = d.nu_contrato 
    and p.nu_perfil = d.nu_perfil 
  ) 
where 
  d.nu_contrato in (101,102,103,104,105,106)
group by
  d.nu_contrato;


-- Desenvolvimento
--   Manutenção Corretiva (Especializado)
--   Manutenção Evolutiva (Especializado)
--   Serviço Técnico (Especializado)

-- Suporte
--   Suporte (Especializado)

UPDATE gct.gcttb015_tipo_servico SET no_tipo_servico='Manutenção Evolutiva (Especializado)',de_observacao='Manutenção Evolutiva (Especializado)' WHERE nu_tipo_servico=15;
UPDATE gct.gcttb015_tipo_servico SET no_tipo_servico='Suporte (Especializado)',de_observacao='Suporte (Especializado)' WHERE nu_tipo_servico=16;

INSERT INTO gct.gcttb015_tipo_servico VALUES (17,'Manutenção Corretiva (Especializado)',null,'Manutenção Corretiva (Especializado)',null,93,1,'S');
INSERT INTO gct.gcttb015_tipo_servico VALUES (18,'Serviço Técnico (Especializado)',null,'Serviço Técnico (Especializado)',null,93,1,'S');

INSERT INTO gct.gcttb055_servico_contrato VALUES (17,106,1,10,null,2,null,null,2,null,null,null,0,'N',null,null,'D','N','N','N',0,'S','F',null,null,null,'S');
INSERT INTO gct.gcttb055_servico_contrato VALUES (18,106,1,10,null,2,null,null,2,null,null,null,0,'N',null,null,'D','N','N','N',0,'S','F',null,null,null,'S');

INSERT INTO gct.gcttb055_servico_contrato VALUES (17,103,1,10,null,2,null,null,2,null,null,null,0,'N',null,null,'D','N','N','N',0,'S','F',null,null,null,'S');
INSERT INTO gct.gcttb055_servico_contrato VALUES (18,103,1,10,null,2,null,null,2,null,null,null,0,'N',null,null,'D','N','N','N',0,'S','F',null,null,null,'S');

update gct.gcttb033_grupo_contrato gc set ic_calculo_pro_rata='S' where nu_contrato in (101,102,103,104,105,106);

commit;
explain analyze
select
  *
from
  gct.gcttb425_carga_service_now s
where
  rm_type = 'rm_story'
  and nu_controle_carga = 5557
  and ic_avaliado='P'
select 
    count(*)
from 
gct.gcttb005_solicitacao s
where 
(
    s.dh_prevista::date > '2025-06-20'
    or s.dh_efetiva > '2025-06-20'
)

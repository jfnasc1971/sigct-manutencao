#!/bin/bash

pg_dump -U postgres -v -h localhost -Fc \
 --exclude-table=gct.gcttb178_amostra_solicitacao \
 --exclude-table=gct.gcttb177_amostra_solicitacao_equipe \
 --exclude-table=gct.gcttb182_amostra_pendencia_solicitacao \
 --exclude-table=gct.gcttb221_erro_integracao_rtc \
 --exclude-table=gct.gcttb111_ajuste \
 -d gctprd01 -f gctprd01.dump
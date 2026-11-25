#!/bin/bash

pg_restore -h localhost -U gct -d gctdes01 -a -Fc gcttb425_carga_service_now.dump
pg_restore -h localhost -U gct -d gctdes01 -a -Fc gcttb427_iteracao_service_now.dump
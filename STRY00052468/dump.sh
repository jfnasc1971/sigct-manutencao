#!/bin/bash

pg_dump -v -Fc -h sctdedadlx0012.df.caixa -U gct -t gcttb425_carga_service_now sigctdes > gcttb425_carga_service_now.dump
pg_dump -v -Fc -h sctdedadlx0012.df.caixa -U gct -t gcttb427_iteracao_service_now sigctdes > gcttb427_iteracao_service_now.dump
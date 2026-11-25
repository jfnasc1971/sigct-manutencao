
##################################################################################################
# LOCALHOST:ragnarok SERVER:localhost DATABASE:gctprd01 USERNAME:postgres PASSWORD:************
##################################################################################################

Output format is unaligned.
?column?
delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=10
  and nu_contrato=1016
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=10
  and nu_contrato=1016
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=10
  and nu_contrato=1017
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=10
  and nu_contrato=1017
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=10
  and nu_contrato=1018
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=10
  and nu_contrato=1018
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=10
  and nu_contrato=1019
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=10
  and nu_contrato=1019
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=10
  and nu_contrato=1025
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=10
  and nu_contrato=1025
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=10
  and nu_contrato=1026
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=10
  and nu_contrato=1026
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=10
  and nu_contrato=1027
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=10
  and nu_contrato=1027
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=10
  and nu_contrato=1028
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=10
  and nu_contrato=1028
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=10
  and nu_contrato=1029
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=10
  and nu_contrato=1029
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=10
  and nu_contrato=1030
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=10
  and nu_contrato=1030
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=10
  and nu_contrato=201
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=10
  and nu_contrato=201
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=10
  and nu_contrato=201
  and nu_tipo_indicador=43
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=10
  and nu_contrato=201
  and nu_tipo_indicador=43
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=10
  and nu_contrato=201
  and nu_tipo_indicador=44
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=10
  and nu_contrato=201
  and nu_tipo_indicador=44
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=10
  and nu_contrato=202
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=10
  and nu_contrato=202
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=10
  and nu_contrato=202
  and nu_tipo_indicador=43
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=10
  and nu_contrato=202
  and nu_tipo_indicador=43
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=10
  and nu_contrato=202
  and nu_tipo_indicador=44
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=10
  and nu_contrato=202
  and nu_tipo_indicador=44
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=10
  and nu_contrato=203
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=10
  and nu_contrato=203
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=10
  and nu_contrato=203
  and nu_tipo_indicador=43
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=10
  and nu_contrato=203
  and nu_tipo_indicador=43
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=10
  and nu_contrato=203
  and nu_tipo_indicador=44
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=10
  and nu_contrato=203
  and nu_tipo_indicador=44
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=10
  and nu_contrato=204
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=10
  and nu_contrato=204
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=10
  and nu_contrato=204
  and nu_tipo_indicador=43
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=10
  and nu_contrato=204
  and nu_tipo_indicador=43
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=10
  and nu_contrato=204
  and nu_tipo_indicador=44
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=10
  and nu_contrato=204
  and nu_tipo_indicador=44
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=10
  and nu_contrato=205
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=10
  and nu_contrato=205
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=10
  and nu_contrato=205
  and nu_tipo_indicador=43
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=10
  and nu_contrato=205
  and nu_tipo_indicador=43
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=10
  and nu_contrato=205
  and nu_tipo_indicador=44
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=10
  and nu_contrato=205
  and nu_tipo_indicador=44
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=10
  and nu_contrato=206
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=10
  and nu_contrato=206
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=10
  and nu_contrato=206
  and nu_tipo_indicador=43
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=10
  and nu_contrato=206
  and nu_tipo_indicador=43
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=10
  and nu_contrato=206
  and nu_tipo_indicador=44
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=10
  and nu_contrato=206
  and nu_tipo_indicador=44
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=11
  and nu_contrato=1016
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=11
  and nu_contrato=1016
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=11
  and nu_contrato=1017
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=11
  and nu_contrato=1017
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=11
  and nu_contrato=1018
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=11
  and nu_contrato=1018
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=11
  and nu_contrato=1019
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=11
  and nu_contrato=1019
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=11
  and nu_contrato=1025
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=11
  and nu_contrato=1025
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=11
  and nu_contrato=1026
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=11
  and nu_contrato=1026
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=11
  and nu_contrato=1027
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=11
  and nu_contrato=1027
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=11
  and nu_contrato=1028
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=11
  and nu_contrato=1028
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=11
  and nu_contrato=1029
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=11
  and nu_contrato=1029
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=11
  and nu_contrato=1030
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=11
  and nu_contrato=1030
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=11
  and nu_contrato=201
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=11
  and nu_contrato=201
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=11
  and nu_contrato=202
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=11
  and nu_contrato=202
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=11
  and nu_contrato=203
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=11
  and nu_contrato=203
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=11
  and nu_contrato=204
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=11
  and nu_contrato=204
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=11
  and nu_contrato=205
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=11
  and nu_contrato=205
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=11
  and nu_contrato=206
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=11
  and nu_contrato=206
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=64
  and nu_contrato=899
  and nu_tipo_indicador=22
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=64
  and nu_contrato=899
  and nu_tipo_indicador=22
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=64
  and nu_contrato=899
  and nu_tipo_indicador=23
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=64
  and nu_contrato=899
  and nu_tipo_indicador=23
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=64
  and nu_contrato=899
  and nu_tipo_indicador=24
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=64
  and nu_contrato=899
  and nu_tipo_indicador=24
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=70
  and nu_contrato=899
  and nu_tipo_indicador=22
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=70
  and nu_contrato=899
  and nu_tipo_indicador=22
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=70
  and nu_contrato=899
  and nu_tipo_indicador=23
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=70
  and nu_contrato=899
  and nu_tipo_indicador=23
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=70
  and nu_contrato=899
  and nu_tipo_indicador=24
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=70
  and nu_contrato=899
  and nu_tipo_indicador=24
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=83
  and nu_contrato=609
  and nu_tipo_indicador=22
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Pronto')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=83
  and nu_contrato=609
  and nu_tipo_indicador=23
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Pronto')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=83
  and nu_contrato=609
  and nu_tipo_indicador=24
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Pronto')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=83
  and nu_contrato=619
  and nu_tipo_indicador=22
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Pronto')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=83
  and nu_contrato=619
  and nu_tipo_indicador=23
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Pronto')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=83
  and nu_contrato=619
  and nu_tipo_indicador=24
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Pronto')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=83
  and nu_contrato=629
  and nu_tipo_indicador=22
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Pronto')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=83
  and nu_contrato=629
  and nu_tipo_indicador=23
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Pronto')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=83
  and nu_contrato=629
  and nu_tipo_indicador=24
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Pronto')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=84
  and nu_contrato=609
  and nu_tipo_indicador=22
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Pronto')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=84
  and nu_contrato=609
  and nu_tipo_indicador=23
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Pronto')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=84
  and nu_contrato=609
  and nu_tipo_indicador=24
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Pronto')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=84
  and nu_contrato=619
  and nu_tipo_indicador=22
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Pronto')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=84
  and nu_contrato=619
  and nu_tipo_indicador=23
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Pronto')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=84
  and nu_contrato=619
  and nu_tipo_indicador=24
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Pronto')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=84
  and nu_contrato=629
  and nu_tipo_indicador=22
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Pronto')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=84
  and nu_contrato=629
  and nu_tipo_indicador=23
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Pronto')
  );

delete from gct.gcttb191_servico_entregue
where nu_tipo_grupo=84
  and nu_contrato=629
  and nu_tipo_indicador=24
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Pronto')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=1016
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=1016
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=1016
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Testando')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=1017
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=1017
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=1017
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Testando')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=1018
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=1018
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=1018
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Testando')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=1019
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=1019
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=1019
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Testando')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=1025
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=1025
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=1025
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Testando')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=1026
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=1026
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=1026
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Testando')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=1027
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=1027
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=1027
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Testando')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=1028
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=1028
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=1028
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Testando')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=1029
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=1029
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=1029
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Testando')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=1030
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=1030
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=1030
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Testando')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=201
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=201
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=201
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Testando')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=201
  and nu_tipo_indicador=43
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=201
  and nu_tipo_indicador=43
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=201
  and nu_tipo_indicador=43
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Testando')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=201
  and nu_tipo_indicador=44
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=201
  and nu_tipo_indicador=44
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=201
  and nu_tipo_indicador=44
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Testando')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=202
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=202
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=202
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Testando')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=202
  and nu_tipo_indicador=43
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=202
  and nu_tipo_indicador=43
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=202
  and nu_tipo_indicador=43
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Testando')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=202
  and nu_tipo_indicador=44
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=202
  and nu_tipo_indicador=44
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=202
  and nu_tipo_indicador=44
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Testando')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=203
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=203
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=203
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Testando')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=203
  and nu_tipo_indicador=43
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=203
  and nu_tipo_indicador=43
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=203
  and nu_tipo_indicador=43
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Testando')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=203
  and nu_tipo_indicador=44
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=203
  and nu_tipo_indicador=44
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=203
  and nu_tipo_indicador=44
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Testando')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=204
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=204
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=204
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Testando')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=204
  and nu_tipo_indicador=43
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=204
  and nu_tipo_indicador=43
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=204
  and nu_tipo_indicador=43
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Testando')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=204
  and nu_tipo_indicador=44
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=204
  and nu_tipo_indicador=44
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=204
  and nu_tipo_indicador=44
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Testando')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=205
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=205
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=205
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Testando')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=205
  and nu_tipo_indicador=43
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=205
  and nu_tipo_indicador=43
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=205
  and nu_tipo_indicador=43
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Testando')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=205
  and nu_tipo_indicador=44
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=205
  and nu_tipo_indicador=44
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=205
  and nu_tipo_indicador=44
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Testando')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=206
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=206
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=206
  and nu_tipo_indicador=36
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Testando')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=206
  and nu_tipo_indicador=43
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=206
  and nu_tipo_indicador=43
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=206
  and nu_tipo_indicador=43
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Testando')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=206
  and nu_tipo_indicador=44
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=206
  and nu_tipo_indicador=44
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=10
  and nu_contrato=206
  and nu_tipo_indicador=44
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Testando')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=119
  and nu_contrato=889
  and nu_tipo_indicador=19
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=119
  and nu_contrato=889
  and nu_tipo_indicador=19
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Preparado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=119
  and nu_contrato=889
  and nu_tipo_indicador=19
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=119
  and nu_contrato=889
  and nu_tipo_indicador=19
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Testando')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=11
  and nu_contrato=1016
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=11
  and nu_contrato=1016
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=11
  and nu_contrato=1016
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Testando')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=11
  and nu_contrato=1017
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=11
  and nu_contrato=1017
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=11
  and nu_contrato=1017
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Testando')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=11
  and nu_contrato=1018
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=11
  and nu_contrato=1018
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=11
  and nu_contrato=1018
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Testando')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=11
  and nu_contrato=1019
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=11
  and nu_contrato=1019
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=11
  and nu_contrato=1019
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Testando')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=11
  and nu_contrato=1025
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=11
  and nu_contrato=1025
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=11
  and nu_contrato=1025
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Testando')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=11
  and nu_contrato=1026
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=11
  and nu_contrato=1026
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=11
  and nu_contrato=1026
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Testando')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=11
  and nu_contrato=1027
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=11
  and nu_contrato=1027
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=11
  and nu_contrato=1027
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Testando')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=11
  and nu_contrato=1028
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=11
  and nu_contrato=1028
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=11
  and nu_contrato=1028
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Testando')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=11
  and nu_contrato=1029
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=11
  and nu_contrato=1029
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=11
  and nu_contrato=1029
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Testando')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=11
  and nu_contrato=1030
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=11
  and nu_contrato=1030
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=11
  and nu_contrato=1030
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Testando')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=11
  and nu_contrato=201
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=11
  and nu_contrato=201
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=11
  and nu_contrato=201
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Testando')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=11
  and nu_contrato=202
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=11
  and nu_contrato=202
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=11
  and nu_contrato=202
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Testando')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=11
  and nu_contrato=203
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=11
  and nu_contrato=203
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=11
  and nu_contrato=203
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Testando')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=11
  and nu_contrato=204
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=11
  and nu_contrato=204
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=11
  and nu_contrato=204
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Testando')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=11
  and nu_contrato=205
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=11
  and nu_contrato=205
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=11
  and nu_contrato=205
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Testando')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=11
  and nu_contrato=206
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=11
  and nu_contrato=206
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=11
  and nu_contrato=206
  and nu_tipo_indicador=37
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Testando')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=135
  and nu_contrato=997
  and nu_tipo_indicador=19
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=135
  and nu_contrato=997
  and nu_tipo_indicador=19
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=135
  and nu_contrato=997
  and nu_tipo_indicador=19
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Testando')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=136
  and nu_contrato=997
  and nu_tipo_indicador=19
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=136
  and nu_contrato=997
  and nu_tipo_indicador=19
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=136
  and nu_contrato=997
  and nu_tipo_indicador=19
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Testando')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=152
  and nu_contrato=1006
  and nu_tipo_indicador=19
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Preparado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=152
  and nu_contrato=1006
  and nu_tipo_indicador=19
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=152
  and nu_contrato=1006
  and nu_tipo_indicador=19
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Testando')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=152
  and nu_contrato=1021
  and nu_tipo_indicador=19
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Preparado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=152
  and nu_contrato=1021
  and nu_tipo_indicador=19
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=152
  and nu_contrato=1021
  and nu_tipo_indicador=19
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Testando')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=153
  and nu_contrato=1006
  and nu_tipo_indicador=19
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Preparado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=153
  and nu_contrato=1006
  and nu_tipo_indicador=19
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=153
  and nu_contrato=1006
  and nu_tipo_indicador=19
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Testando')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=154
  and nu_contrato=1006
  and nu_tipo_indicador=19
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Preparado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=154
  and nu_contrato=1006
  and nu_tipo_indicador=19
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=154
  and nu_contrato=1006
  and nu_tipo_indicador=19
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Testando')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=163
  and nu_contrato=1042
  and nu_tipo_indicador=19
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=163
  and nu_contrato=1042
  and nu_tipo_indicador=19
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Preparado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=163
  and nu_contrato=1042
  and nu_tipo_indicador=19
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=163
  and nu_contrato=1042
  and nu_tipo_indicador=19
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Testando')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=170
  and nu_contrato=1044
  and nu_tipo_indicador=19
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=170
  and nu_contrato=1044
  and nu_tipo_indicador=19
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Preparado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=170
  and nu_contrato=1044
  and nu_tipo_indicador=19
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=170
  and nu_contrato=1044
  and nu_tipo_indicador=19
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Testando')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=62
  and nu_contrato=1002
  and nu_tipo_indicador=19
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=62
  and nu_contrato=1002
  and nu_tipo_indicador=19
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Preparado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=62
  and nu_contrato=1002
  and nu_tipo_indicador=19
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=62
  and nu_contrato=1002
  and nu_tipo_indicador=19
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Testando')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=62
  and nu_contrato=1012
  and nu_tipo_indicador=19
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=62
  and nu_contrato=1012
  and nu_tipo_indicador=19
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Preparado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=62
  and nu_contrato=1012
  and nu_tipo_indicador=19
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=62
  and nu_contrato=1012
  and nu_tipo_indicador=19
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Testando')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=63
  and nu_contrato=1002
  and nu_tipo_indicador=19
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=63
  and nu_contrato=1002
  and nu_tipo_indicador=19
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Preparado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=63
  and nu_contrato=1002
  and nu_tipo_indicador=19
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=63
  and nu_contrato=1002
  and nu_tipo_indicador=19
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Testando')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=63
  and nu_contrato=1004
  and nu_tipo_indicador=19
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=63
  and nu_contrato=1004
  and nu_tipo_indicador=19
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Preparado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=63
  and nu_contrato=1004
  and nu_tipo_indicador=19
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=63
  and nu_contrato=1004
  and nu_tipo_indicador=19
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Testando')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=63
  and nu_contrato=1012
  and nu_tipo_indicador=19
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=63
  and nu_contrato=1012
  and nu_tipo_indicador=19
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Preparado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=63
  and nu_contrato=1012
  and nu_tipo_indicador=19
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=63
  and nu_contrato=1012
  and nu_tipo_indicador=19
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Testando')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=63
  and nu_contrato=719
  and nu_tipo_indicador=19
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Preparado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=63
  and nu_contrato=719
  and nu_tipo_indicador=19
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Pronto')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=63
  and nu_contrato=719
  and nu_tipo_indicador=19
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=63
  and nu_contrato=719
  and nu_tipo_indicador=19
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Testando')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=64
  and nu_contrato=1004
  and nu_tipo_indicador=19
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=64
  and nu_contrato=1004
  and nu_tipo_indicador=19
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Preparado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=64
  and nu_contrato=1004
  and nu_tipo_indicador=19
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=64
  and nu_contrato=1004
  and nu_tipo_indicador=19
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Testando')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=64
  and nu_contrato=719
  and nu_tipo_indicador=19
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Preparado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=64
  and nu_contrato=719
  and nu_tipo_indicador=19
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Pronto')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=64
  and nu_contrato=719
  and nu_tipo_indicador=19
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=64
  and nu_contrato=719
  and nu_tipo_indicador=19
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Testando')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=64
  and nu_contrato=899
  and nu_tipo_indicador=22
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=64
  and nu_contrato=899
  and nu_tipo_indicador=22
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Preparado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=64
  and nu_contrato=899
  and nu_tipo_indicador=22
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=64
  and nu_contrato=899
  and nu_tipo_indicador=22
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Testando')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=65
  and nu_contrato=719
  and nu_tipo_indicador=19
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Preparado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=65
  and nu_contrato=719
  and nu_tipo_indicador=19
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Pronto')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=65
  and nu_contrato=719
  and nu_tipo_indicador=19
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=65
  and nu_contrato=719
  and nu_tipo_indicador=19
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Testando')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=70
  and nu_contrato=899
  and nu_tipo_indicador=22
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=70
  and nu_contrato=899
  and nu_tipo_indicador=22
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Preparado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=70
  and nu_contrato=899
  and nu_tipo_indicador=22
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=70
  and nu_contrato=899
  and nu_tipo_indicador=22
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Testando')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=83
  and nu_contrato=609
  and nu_tipo_indicador=22
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Preparado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=83
  and nu_contrato=609
  and nu_tipo_indicador=22
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Pronto')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=83
  and nu_contrato=609
  and nu_tipo_indicador=22
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Testando')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=83
  and nu_contrato=619
  and nu_tipo_indicador=22
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Preparado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=83
  and nu_contrato=619
  and nu_tipo_indicador=22
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Pronto')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=83
  and nu_contrato=619
  and nu_tipo_indicador=22
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Testando')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=83
  and nu_contrato=629
  and nu_tipo_indicador=22
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Preparado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=83
  and nu_contrato=629
  and nu_tipo_indicador=22
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Pronto')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=83
  and nu_contrato=629
  and nu_tipo_indicador=22
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Testando')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=84
  and nu_contrato=609
  and nu_tipo_indicador=22
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Preparado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=84
  and nu_contrato=609
  and nu_tipo_indicador=22
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Pronto')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=84
  and nu_contrato=609
  and nu_tipo_indicador=22
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Testando')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=84
  and nu_contrato=619
  and nu_tipo_indicador=22
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Preparado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=84
  and nu_contrato=619
  and nu_tipo_indicador=22
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Pronto')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=84
  and nu_contrato=619
  and nu_tipo_indicador=22
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Testando')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=84
  and nu_contrato=629
  and nu_tipo_indicador=22
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Preparado')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=84
  and nu_contrato=629
  and nu_tipo_indicador=22
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Pronto')
  );

delete from gct.gcttb192_servico_contratado
where nu_tipo_grupo=84
  and nu_contrato=629
  and nu_tipo_indicador=22
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Testando')
  );

delete from gct.gcttb193_servico_atraso
where nu_tipo_grupo=64
  and nu_contrato=899
  and nu_tipo_indicador=23
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb193_servico_atraso
where nu_tipo_grupo=64
  and nu_contrato=899
  and nu_tipo_indicador=23
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb193_servico_atraso
where nu_tipo_grupo=70
  and nu_contrato=899
  and nu_tipo_indicador=23
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb193_servico_atraso
where nu_tipo_grupo=70
  and nu_contrato=899
  and nu_tipo_indicador=23
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb193_servico_atraso
where nu_tipo_grupo=83
  and nu_contrato=609
  and nu_tipo_indicador=23
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Pronto')
  );

delete from gct.gcttb193_servico_atraso
where nu_tipo_grupo=83
  and nu_contrato=609
  and nu_tipo_indicador=23
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb193_servico_atraso
where nu_tipo_grupo=83
  and nu_contrato=619
  and nu_tipo_indicador=23
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Pronto')
  );

delete from gct.gcttb193_servico_atraso
where nu_tipo_grupo=83
  and nu_contrato=619
  and nu_tipo_indicador=23
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb193_servico_atraso
where nu_tipo_grupo=83
  and nu_contrato=629
  and nu_tipo_indicador=23
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Pronto')
  );

delete from gct.gcttb193_servico_atraso
where nu_tipo_grupo=83
  and nu_contrato=629
  and nu_tipo_indicador=23
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb193_servico_atraso
where nu_tipo_grupo=84
  and nu_contrato=609
  and nu_tipo_indicador=23
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Pronto')
  );

delete from gct.gcttb193_servico_atraso
where nu_tipo_grupo=84
  and nu_contrato=609
  and nu_tipo_indicador=23
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb193_servico_atraso
where nu_tipo_grupo=84
  and nu_contrato=619
  and nu_tipo_indicador=23
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Pronto')
  );

delete from gct.gcttb193_servico_atraso
where nu_tipo_grupo=84
  and nu_contrato=619
  and nu_tipo_indicador=23
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb193_servico_atraso
where nu_tipo_grupo=84
  and nu_contrato=629
  and nu_tipo_indicador=23
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Pronto')
  );

delete from gct.gcttb193_servico_atraso
where nu_tipo_grupo=84
  and nu_contrato=629
  and nu_tipo_indicador=23
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb194_servico_devolvido
where nu_tipo_grupo=64
  and nu_contrato=899
  and nu_tipo_indicador=24
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb194_servico_devolvido
where nu_tipo_grupo=64
  and nu_contrato=899
  and nu_tipo_indicador=24
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb194_servico_devolvido
where nu_tipo_grupo=70
  and nu_contrato=899
  and nu_tipo_indicador=24
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Concluído')
  );

delete from gct.gcttb194_servico_devolvido
where nu_tipo_grupo=70
  and nu_contrato=899
  and nu_tipo_indicador=24
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Rejeitado')
  );

delete from gct.gcttb194_servico_devolvido
where nu_tipo_grupo=83
  and nu_contrato=609
  and nu_tipo_indicador=24
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Pronto')
  );

delete from gct.gcttb194_servico_devolvido
where nu_tipo_grupo=83
  and nu_contrato=619
  and nu_tipo_indicador=24
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Pronto')
  );

delete from gct.gcttb194_servico_devolvido
where nu_tipo_grupo=83
  and nu_contrato=629
  and nu_tipo_indicador=24
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Pronto')
  );

delete from gct.gcttb194_servico_devolvido
where nu_tipo_grupo=84
  and nu_contrato=609
  and nu_tipo_indicador=24
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Pronto')
  );

delete from gct.gcttb194_servico_devolvido
where nu_tipo_grupo=84
  and nu_contrato=619
  and nu_tipo_indicador=24
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Pronto')
  );

delete from gct.gcttb194_servico_devolvido
where nu_tipo_grupo=84
  and nu_contrato=629
  and nu_tipo_indicador=24
  and nu_situacao_atendimento=(
      select sa.nu_situacao_atendimento
      from gct.gcttb092_situacao_atendimento sa
      where sa.no_situacao_atendimento in ('Pronto')
  );

(368 rows)

-------------------------------------------------------
-- Resultados
-------------------------------------------------------
Log: logs/retornar_situacoes.sql.messages
Tudo certo :)
-------------------------------------------------------

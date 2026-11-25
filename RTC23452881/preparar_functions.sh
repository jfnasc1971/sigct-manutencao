#!/bin/bash
IFS=$'\n'

for l in $(cat lista.txt|grep -v AJUSTE);do
  NAME="$(echo $l|awk '{print $1}')"
  echo $NAME
  cp TEMPLATE_FUNCTION_INDICADOR_DDL.sql $NAME.sql

  FN_NAME="$(echo $l|awk '{print $3}')"
  echo $FN_NAME
  sed -i s/IEQQET/$FN_NAME/gi $NAME.sql

  FN_NAME="$(echo $l|awk '{print $2}')"
  echo $FN_NAME
  sed -i s/gctfn999_indicador_xxxx/$FN_NAME/gi $NAME.sql

done

for l in $(cat lista.txt|grep AJUSTE);do
  NAME="$(echo $l|awk '{print $1}')"
  echo $NAME
  cp TEMPLATE_FUNCTION_INDICADOR_AJUSTE_DDL.sql $NAME.sql

  FN_NAME="$(echo $l|awk '{print $3}')"
  echo $FN_NAME
  sed -i s/IEQQET/$FN_NAME/gi $NAME.sql

  FN_NAME="$(echo $l|awk '{print $2}')"
  echo $FN_NAME
  sed -i s/gctfn999_indicador_xxxx/$FN_NAME/gi $NAME.sql

done


head -n 40 GCTFN204_INDICADOR_QUALIDADE_DDL.sql
#!/bin/bash

for r in $(cat lista.txt);do
  ./consultar_rtc.sh $r |grep -io '<id>[0-9]\+</id>\|<name>[0-9A-Za-záéíóúÁÉÍÓÚãõÃÕâêîôûÂÊÎÔÛçÇ _]\+</name>'|awk '{printf "%s ", $0} END {print ""}'
done
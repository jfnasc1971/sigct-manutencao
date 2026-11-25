#!/bin/bash
export JAVA_HOME=/c/caixa/opt/jdk1.8.0_461
cd src/Fontes/sigct-backend
mvn package -DskipTests=true

#!/bin/bash

#git config --global credential.helper manager #windows
git config --global credential.helper store

git config --global user.name "José Flávio Lins do Nascimento"
git config --global user.email "f922063@corp.caixa.gov.br"

#
#
#
rm -rf src
git clone git@ssh.dev.azure.com:v3/QintessCaixaControladoria/SIGCT/SIGCT src
cd src
git config --global http.postBuffer 524288000

git remote add gitlab git@gitlab.com:grupo-engesoftware/sigct.git

git push -uf gitlab --all
git push -uf gitlab --tags


#
#
#
rm -rf src
git clone git@ssh.dev.azure.com:v3/QintessCaixaControladoria/SIGCT/SIGCT_MEMO src
cd src
git config --global http.postBuffer 524288000

git remote add gitlab git@gitlab.com:grupo-engesoftware/prometheus.git

git push -uf gitlab --all
git push -uf gitlab --tags


#
#
#
rm -rf src
git clone https://f922063_1:glpat-vRPP-jbEtPR1GolFlwMPUGM6MQpvOjEKdTpvNXZucg8.01.1718y29v5@gitlab.com/grupo-engesoftware/sigct.git src
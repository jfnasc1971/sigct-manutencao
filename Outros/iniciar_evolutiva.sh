#!/bin/bash
BASEDIR="$(pwd)"

clear

if [ -z "$1" ] || ([ -z "$(echo $1 | grep 'RTC[0-9]\+')" ] && [ -z "$(echo $1 | grep 'RTC[0-9]\+_RTC[0-9]\+')" ]);then
  echo
  echo "Erro!"
  echo "Informe o codigo do atendimento no formato RTCPAI_RTCTAREFA ou RTC0000000"
  echo "Exemplos: RTC19416648_RTC19416649 ou RTC19416648"
  echo 
  exit
fi

URL="git@ssh.dev.azure.com:v3/QintessCaixaControladoria/SIGCT/SIGCT"
WORKDIR="$(echo "$1" | awk -F '_' '{print $1}')"
BRANCH="feature/$WORKDIR"

#
# cria a pasta em MANUTENCAO
#
if [ ! -d "$BASEDIR/$WORKDIR" ];then

  mkdir -p $BASEDIR/$WORKDIR

  file="$(echo $BASEDIR/$WORKDIR/SIGCT_Evidencia_Teste_RTCXXXXXXX.docx | sed -e "s|RTCXXXXXXX|$WORKDIR|gi")"
  if [ ! -f "$file" ];then
    cp -v /projetos/caixa/sigct/Sustentacao/SIGCT_Evidencia_Teste_RTCXXXXXXX.docx \
      "$(echo $BASEDIR/$WORKDIR/SIGCT_Evidencia_Teste_RTCXXXXXXX.docx | sed -e "s|RTCXXXXXXX|$WORKDIR|gi")"
  fi

  file="$(echo $BASEDIR/$WORKDIR/SIGCT_Entrega_RTCXXXXXXX.xlsx | sed -e "s|RTCXXXXXXX|$WORKDIR|gi")"
  if [ ! -f "$file" ];then
    cp -v /projetos/caixa/sigct/Sustentacao/SIGCT_Entrega_RTCXXXXXXX.xlsx \
      "$(echo $BASEDIR/$WORKDIR/SIGCT_Entrega_RTCXXXXXXX.xlsx | sed -e "s|RTCXXXXXXX|$WORKDIR|gi")"
  fi

  if [ ! -f "$BASEDIR/$WORKDIR/commit" ];then
    cp -v /projetos/caixa/sigct/Sustentacao/template_commit.bash $BASEDIR/$WORKDIR/commit
    chmod +x $BASEDIR/$WORKDIR/commit
  fi

fi

cd "$BASEDIR/$WORKDIR"
echo 
echo
ls -la

if [ ! -d src ];then

  git clone "${URL}" src

  cd src
  git checkout develop
  git pull
  git fetch --tags
  git checkout -b "${BRANCH}"
  git push -u origin "${BRANCH}"
  git pull
  git fetch --all
  git status

else
  cd src
  git checkout "${BRANCH}"
  git pull
  git fetch --all
fi

git config user.name "José Flávio Lins do Nascimento"
git config user.email "re045693@qintess.com"

cd ..

if [ ! -f readme.txt ];then
  echo "Informe a descrição do atendimento"
  read d
  echo "RTC $(echo ${WORKDIR}|sed -e 's|RTC||') - $d"
  echo "RTC $(echo ${WORKDIR}|sed -e 's|RTC||') - $d" >> readme.txt
fi

echo
echo
echo "Diretório base    : $BASEDIR"
echo "URL (Azure GIT)   : $URL"
echo "Pasta de trabalho : $BASEDIR/$WORKDIR"
echo "Branch            : $BRANCH"

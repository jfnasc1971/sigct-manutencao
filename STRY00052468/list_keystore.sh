#/bin/bash

#JAVA_HOME="/c/'Program Files'/Java/jre1.8.0_421/"
JAVA_HOME="/c/caixa/opt/jdk1.8.0_461"


openssl s_client \
-connect gid.caixa:443 \
-showcerts < /dev/null 2>/dev/null |
openssl x509 -outform DER > cert_gid.cer

$JAVA_HOME/bin/keytool.exe -importcert \
  -alias gid \
  -file cert_gid.cer \
  -keystore "$JAVA_HOME/jre/lib/security/cacerts"

exit

clear

$JAVA_HOME/bin/keytool.exe -list -keystore sigct.cliservicenow.keystore
exit

# PASSO 1 - BACKUP

#cp $JAVA_HOME/jre/lib/security/cacerts \
#   $JAVA_HOME/jre/lib/security/cacerts.bkp

ls -la $JAVA_HOME/jre/lib/security/

# PASSO 2 - IMPORTAR CERIFICADO DE SERVICE NOW HMP

#$JAVA_HOME/bin/keytool.exe -importcert \
#  -alias servicenow \
#  -file cert_servinow_hmp.cer \
#  -keystore "$JAVA_HOME/jre/lib/security/cacerts"

$JAVA_HOME/bin/keytool.exe -list -v -alias servicenow \
  -keystore "$JAVA_HOME/jre/lib/security/cacerts"

openssl s_client \
-connect caixaesmhmp.service-now.com:443 \
-showcerts < /dev/null 2>/dev/null |
openssl x509 -outform PEM > cert_servinow_hmp.pem

openssl s_client \
-connect caixaesmhmp.service-now.com:443 \
-showcerts < /dev/null 2>/dev/null |
openssl x509 -outform DER > cert_servinow_hmp.cer

$JAVA_HOME/bin/keytool.exe -importcert \
-alias servicenow \
-file servidor.cer \
-keystore truststore.jks


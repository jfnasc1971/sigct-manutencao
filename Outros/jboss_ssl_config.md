keytool -genkey -alias jboss -keyalg RSA -keystore /projetos/caixa/sigct/opt/EAP-PRD-6.4.0/configuration/keystore.jks -keysize 2048 -validity 3650
keytool -genkey -alias jboss -keyalg RSA -keystore /projetos/caixa/sigct/opt/EAP-DES-6.4.0/configuration/keystore.jks -keysize 2048 -validity 3650


<security-realm name="ManagementRealm">
    <!-- SSL INICIO -->
    <server-identities>
        <ssl>
            <keystore path="keystore.jks"
                    relative-to="jboss.server.config.dir"
                    keystore-password="asdf123"/>
        </ssl>
    </server-identities>
    <!-- SSL FIM -->
    .... 
</security-realm>     

<management-interfaces>
    <native-interface security-realm="ManagementRealm">
        <socket-binding native="management-native"/>
    </native-interface>
    <http-interface security-realm="ManagementRealm">
        <socket-binding http="management-http"/>
        <!--SSL INCIO -->
        <socket-binding https="management-https"/>
        <!--SSL FIM -->
    </http-interface>
</management-interfaces>

<subsystem xmlns="urn:jboss:domain:web:2.2" default-virtual-server="default-host" native="false">
    <connector name="http" protocol="HTTP/1.1" scheme="http" socket-binding="http" max-post-size="0"/>
    <!-- SSL - INICIO -->
    <connector name="https" protocol="HTTP/1.1" scheme="https" socket-binding="https" secure="true">
        <ssl name="ssl" key-alias="jboss" password="asdf123"
            certificate-key-file="${jboss.server.config.dir}/keystore.jks"
            protocol="TLSv1,TLSv1.1,TLSv1.2"/>
    </connector>
    <!-- SSL - FIM -->   
    <virtual-server name="default-host" enable-welcome-root="true">
        <alias name="localhost"/>
        <alias name="example.com"/>
    </virtual-server>
</subsystem>                    
para cada solicitação:
  se tipo == "Item de Backlog":
    se tipo_demanda in ["Manutenção Evolutiva", "Desenvolvimento de Novo Sistema"]:
       se possui_4_perguntas_bef e alguma_resposta_sim:
         BEF = SIM
       senão:
         se item_pai == "Necessidade" e termo_ciencia_bef == true e possui_avaliacao_aprovada:
           para cada avaliacao_aprovada verifica:
             se sigla_sistema_avaliacao == sigla_solicitacao e item_portfolio_avaliacao == item_portfolio_solicitacao:
               BEF = SIM
         senão:
           BEF = NÃO
    senão:
      BEF = NÃO
  senão:
    BEF = NÃO




Para cada Solicitação:

Se o TIPO é com.ibm.team.apt.workItemType.story
  se Tipo de Item de Backlog é História de Usuário e
     Tipo de Demanda é Manutenção Evolutiva ou Desenvolvimento de Novo Sistema e
     Tipo de História de Usuário é História de Usuário
  se NÃO
    marca BEF como NÃO e encerra   
  se possui as 4 perguntas BEF e se para ao menos uma delas a reposta é sim
    marca como BEF e encerra
  se NÂO
    se o ITEM PAI é uma Necessidade e possui termo_ciencia_bef marcado
    se possui ao menos uma Avaliação Gastos de TI Aprovada
      para cada Avaliação Gastos de TI
        se a sigla do sistema e o item de portfolio são iguais aos da solicitação analisada 
          marca como BEF e encerra
Se o TIPO NÂO é com.ibm.team.apt.workItemType.story
  marca BEF como NÃO e encerra


Aumenta o tempo de uso do sistema: 
Aumenta a produtividade do sistema:
Aumenta a eficiência do sistema: 
Aumenta receita, reduz custos ou outros benefícios, inclusive por mais de um exercício (ano): 


https://gid.caixa:9443/ccm/rpt/repository/workitem?fields=workitem/workItem[id=21260199]/booleanExtensions[key=termo_ciencia_bef]/*

https://gid.caixa:9443/ccm/rpt/repository/workitem?fields=workitem/workItem[id=22146887]/type/*

<workItem>
<type>
<id>com.ibm.team.apt.workItemType.story</id>
<name>Item de Backlog</name>
</type>
</workItem>
</workitem>

<allExtensions>
<helperId>__ZhrnlRWEe-8L9z1mbxymQ</helperId>
<key>tipo_item_backlog</key>
<type>smallStringValue</type>
<booleanValue/>
<integerValue/>
<longValue/>
<doubleValue>0.0</doubleValue>
<smallStringValue>tipo_item_backlog.literal.l2</smallStringValue>
<displayName>Tipo de Item de Backlog</displayName>
<displayValue>História de Usuário</displayValue>
<mediumStringValue/>
<largeStringValue/>
<timestampValue/>
<decimalValue/>
</allExtensions>

<allExtensions>
    <helperId>__Zhrk1RWEe-8L9z1mbxymQ</helperId>
    <key>tipo_demanda_item_backlog</key>
    <type>smallStringValue</type>
    <booleanValue/>
    <integerValue/>
    <longValue/>
    <doubleValue>0.0</doubleValue>
    <smallStringValue>tipo_demanda.literal.l8</smallStringValue>
    <displayName>Tipo de Demanda</displayName>
    <displayValue>Manutenção Evolutiva</displayValue>
    <mediumStringValue/>
    <largeStringValue/>
    <timestampValue/>
    <decimalValue/>
    </allExtensions>

<allExtensions>
<helperId>__Zhrk1RWEe-8L9z1mbxymQ</helperId>
<key>tipo_demanda_item_backlog</key>
<type>smallStringValue</type>
<booleanValue/>
<integerValue/>
<longValue/>
<doubleValue>0.0</doubleValue>
<smallStringValue>tipo_demanda.literal.l8</smallStringValue>
<displayName>Tipo de Demanda</displayName>
<displayValue>Manutenção Evolutiva</displayValue>
<mediumStringValue/>
<largeStringValue/>
<timestampValue/>
<decimalValue/>
</allExtensions>

<allExtensions>
<helperId>__ZhrglRWEe-8L9z1mbxymQ</helperId>
<key>tipo_historia_usuario</key>
<type>smallStringValue</type>
<booleanValue/>
<integerValue/>
<longValue/>
<doubleValue>0.0</doubleValue>
<smallStringValue>tipo_historia_usuario.literal.l6</smallStringValue>
<displayName>Tipo de História de Usuário</displayName>
<displayValue>História de Usuário</displayValue>
<mediumStringValue/>
<largeStringValue/>
<timestampValue/>
<decimalValue/>
</allExtensions>


Avaliação Gastos de TI 24270736
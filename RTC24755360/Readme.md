RTC 24755360 - SIGCT - INTEGRAÇÃO  SIGCT x SIPGC3 - Grupos e serviços do contrato

Vamos enviar no ws somente grupos e serviços do Ágil/Especializado
 
No RTC, ficaria assim:
 
GRUPO
 
Ágil: Serviços de Arquitetura
 
SERVIÇOS
 
Ágil: Acompanhamento in-loco Impl. Arquitetura
Ágil: Definição de  Arquiteturas
Ágil: Documentação
Ágil: Prospecção de Tecnologias e Experimentações
Ágil: Serviços de Análise de Arquiteturas e de Negócios
Ágil: Serviços de Suporte às Arquiteturas
 
A regra de vinculação será resscrita assim:
 
Se o noTipoGrupo ou noTipoServioinicia com alguma coisa ':', o sistema considera o que vem depois dos dois pontos par encontrar grupo e serviço

{
  "codigoRetorno": "0",
  "mensagemRetorno": "Operação realizada com sucesso!",
  "resultado": [
    {
      "noTipoGrupo": "Desenvolvimento",
      "noTipoContratacao": "Especializado",
      "servicos": [
        {
          "noTipoServico": "Squad - Contrato Especializado"
        },
        {
          "noTipoServico": "Suporte - Contrato Especializado"
        }
      ]
    }
  ],
  "quantidadeRegistros": 1,
  "dataConsulta": "2026-03-26 14:04"
}


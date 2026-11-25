RTC 22877402 - SIGCT - Contrato Especializado - Integração com a aplicação SIMPF

SYSTEM PROPERTY:

<property name="sigct_server" value="https://sigct.fabrica:8443/sigct/"/>

CHAMADA API ATUALIZAR VALOR OS:

http://sigct.fabrica:8080/sigct/api/ordemServico/atualizarValor/708174

Dados de envio:
 
- Layout do arquivo de envio

  - Item de Portifólio (4 dígitos)
  - Squad (chave 5 dígitos)
  - Sprint 
	- ID (4 dígitos)
	- Nome (150 caracteres)
  - ID da Contagem (10 dígitos)
  - Versão Contagem: Texto. Exemplo: v1, v2, v3
  - Tipo: Contagem ou Divergência: C ou D
  - Data da Contagem/Atualização
  - Origem (motivo): Número do RTC ou AIMM que originou a contagem/divergência
      - Número do IB
	    - Valor PF: duas casas decimais
	    - Tipo PF: Incluído PF, Alterado PF, Excluído PF, Incluído Convertido, Alterado Convertido, Excluído Convertido (apenas para tradicional)

Dados de retorno
 
- Layout do arquivo de retorno
  - Item de Portifólio (4 dígitos)
  - Squad (chave 5 dígitos)
  - Sprint 
	- ID (4 dígitos)
	- Nome (150 caracteres)
  - ID da Contagem
  - Versão Contagem: Texto. Exemplo: v1, v2, v3
  - Tipo: Contagem ou Divergência: C ou D
  - Data da Contagem/Atualização
  - Origem (motivo): Número do RTC ou AIMM que originou a contagem/divergência
      - Número do IB
 	    - Valor PF: duas casas decimais
	    - Tipo PF: Incluído PF, Alterado PF, Excluído PF, Incluído Convertido, Alterado Convertido, Excluído Convertido (apenas para tradicional)

  - Código de retorno

      - O: sucesso
      - 1: erro

  - Mensagem de erro: texto

	  - Campo <nome do campo não preenchido> não informado. (Todos os bancos obrigatórios)

	  - <nome do campo> não existe no SIGCT. (Item de Portifólio, Squad, Sprint, Número do IB)
 

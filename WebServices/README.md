# API SIGCT

Este projeto reúne a especificação e a documentação da API responsável por disponibilizar, por meio de serviços REST JSON, dados operacionais e gerenciais do SIGCT atualmente consolidados em planilhas e no banco PostgreSQL.

## Objetivo

A API SIGCT permite consultas padronizadas sobre equipes, indicadores, contagens de Pontos de Função, notas por código e prévia de retenção. Os consumidores incluem sistemas corporativos, Power BI, Power Platform e portais internos.

A URL base planejada é:

```text
https://sigct.caixa.gov.br/api/v1
```

## Recursos da versão 1

- Equipes
- Indicadores
- Contagens de Pontos de Função
- Notas por Código
- Prévia de Retenção

Os recursos utilizam HTTPS, JSON UTF-8, autenticação por Token e versionamento por URL.

## Documentação do projeto

- [Visão do projeto](VISAO.pdf) — contexto, objetivos, requisitos e benefícios.
- [Projeto da API](PROJETO.pdf) — escopo, arquitetura, segurança e endpoints da versão 1.
- [Arquitetura](ARQUITETURA.pdf) — arquitetura lógica, tecnologias, domínios e observabilidade.
- [Roadmap](ROADMAP.pdf) — descrição da versão 1 e evolução prevista nas versões posteriores.
- [OpenAPI](openapi.yaml) — especificação técnica dos serviços REST.

## Exemplos e artefatos

- [Exemplos JSON](JSON_README.pdf) — respostas de exemplo dos principais endpoints.
- [Exemplos WSDL](WSDL_README.pdf) — documentação e exemplos derivados dos contratos SOAP disponíveis no projeto.
- [SigctService.wsdl](wsdl/SigctService.wsdl) — contrato WSDL de referência.
- [Documentação em PDF](README.pdf) — versões em PDF dos documentos Markdown.

## Estrutura principal

```text
ARQUITETURA.md
VISAO.md
PROJETO.md
ROADMAP.md
openapi.yaml
docs/
json/
wsdl/
utils/
```

Os documentos Markdown concentram a visão funcional e técnica da iniciativa, enquanto `openapi.yaml`, `json/` e `wsdl/` fornecem contratos e exemplos para integração dos consumidores.

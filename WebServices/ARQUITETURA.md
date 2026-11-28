# ARQUITETURA DA API SIGCT

## Visão Geral

A API SIGCT fornecerá acesso padronizado aos dados de Equipes, Indicadores, Contagens PF, Notas por Código e Prévia de Retenção por meio de serviços REST JSON.

URL Base:

https://sigct.caixa.gov.br/api/v1

## Arquitetura Lógica

Consumidores -> API REST -> Serviços de Negócio -> PostgreSQL SIGCT

## Tecnologias

- Java 8
- JBoss EAP 6.4
- RESTEasy (JAX-RS)
- Jackson
- PostgreSQL
- Maven
- OpenAPI 3.0

## Domínios

### Equipes

Responsável por disponibilizar equipes, vigências, contratos, áreas, comunidades e grupos.

### Indicadores

Disponibiliza indicadores IE, IP, IQ, IT, FNS e IDE por equipe e período de faturamento.

### Contagens PF

Disponibiliza métricas de Pontos de Função associadas às equipes.

### Notas por Código

Disponibiliza notas apuradas por sistema e ciclo de faturamento.

### Prévia de Retenção

Disponibiliza informações gerenciais utilizadas em retenções e faturamento.

## Segurança

Authorization: Bearer <token>

As opções de evolução da autenticação e autorização estão descritas em [ROADMAP.md](ROADMAP.md).

## Paginação

Padrão:

GET /recurso?page=0&size=50

Retorno:

- page
- size
- totalElements
- totalPages
- content

## Padronização de Erros

{
  "timestamp": "2026-01-01T00:00:00Z",
  "status": 400,
  "error": "Bad Request",
  "message": "Parâmetro inválido",
  "path": "/api/v1/recurso"
}

## Endpoints

- GET /equipes
- GET /indicadores
- GET /contagens
- GET /notas_codigo
- GET /previa_retencao
- GET /health
- GET /version

## Observabilidade

- Health Check
- Auditoria
- Logs estruturados
- Métricas de consumo
- Tempo de resposta

# PROJETO - API DE INDICADORES SIGCT

## Objetivo

Disponibilizar, por meio de serviços REST JSON, as informações atualmente consolidadas na planilha de indicadores do SIGCT, permitindo consulta por sistemas consumidores, portais corporativos, Power BI, Power Platform e integrações futuras.

URL base da API:

https://sigct.caixa.gov.br/api/v1

---

## Escopo da Versão 1

A primeira versão disponibilizará os seguintes recursos:

| Recurso | Endpoint |
|----------|----------|
| Equipes | GET /api/v1/equipes |
| Indicadores | GET /api/v1/indicadores |
| Contagens PF | GET /api/v1/contagens |
| Notas por Código | GET /api/v1/notas_codigo |
| Prévia de Retenção | GET /api/v1/previa_retencao |

---

## Arquitetura

### Padrões Adotados

- REST
- JSON UTF-8
- HTTPS
- OpenAPI 3.0 (Swagger)
- Versionamento por URL
- Stateless

Exemplo:

```text
https://sigct.caixa.gov.br/api/v1
```

---

## Arquitetura Lógica

```text
+--------------------+
| Sistemas Cliente   |
| Power BI           |
| Power Apps         |
| Portal SIGCT       |
| Sistemas CAIXA     |
+---------+----------+
          |
          v
+--------------------+
| API SIGCT REST     |
+---------+----------+
          |
          v
+--------------------+
| Camada de Serviço  |
+---------+----------+
          |
          v
+--------------------+
| Banco SIGCT        |
| PostgreSQL         |
+--------------------+
```

---

## Tecnologias Propostas

Considerando o ambiente atual:

- Java 8
- JBoss EAP 6.4
- PostgreSQL
- Maven

### Stack sugerida

```text
Java 8
JAX-RS (RESTEasy)
Jackson
Maven
JBoss EAP 6.4
PostgreSQL
Swagger/OpenAPI
```

---

## Segurança

### Autenticação

```http
Authorization: Bearer <token>
```

A evolução da autenticação e autorização está definida no [ROADMAP.md](ROADMAP.md).

---

## Endpoints

### Equipes

```http
GET /api/v1/equipes
```

Parâmetros:

```text
contrato        obrigatório
codigo_equipe   opcional
```

Retorna equipes e vigências associadas.

---

### Indicadores

```http
GET /api/v1/indicadores
```

Parâmetros:

```text
contrato
codigo_equipe
data_fatura
```

Retorna indicadores IE, IP, IQ, IT, FNS e IDE conforme o grupo da equipe.

---

### Contagens PF

```http
GET /api/v1/contagens
```

Parâmetros:

```text
contrato
codigo_equipe
data_fatura
```

Retorna as contagens de Pontos de Função agrupadas por equipe.

---

### Notas por Código

```http
GET /api/v1/notas_codigo
```

Parâmetros:

```text
ciclo_faturamento
sigla_sistema
```

Permite consultas por ciclo, sistema ou ambos.

---

### Prévia de Retenção

```http
GET /api/v1/previa_retencao
```

Parâmetros:

```text
contrato
codigo_equipe
```

Retorna informações consolidadas para apoio ao faturamento e retenções.

---

## Evoluções Futuras

Os itens previstos para futuras versões estão concentrados no [ROADMAP.md](ROADMAP.md).

---

## Benefícios Esperados

- Eliminação da dependência de planilhas.
- Integração com Power BI e Power Platform.
- Disponibilização centralizada dos dados.
- Acesso em tempo real às informações.
- Padronização dos indicadores.
- Redução do esforço operacional de consolidação.

---

## Entregáveis

1. API REST documentada via OpenAPI.
2. Swagger UI.
3. Endpoint de Health Check.
4. Endpoint de versão.
5. Manual de Integração.
6. Pipeline de implantação.
7. Ambiente de homologação.
8. Ambiente de produção.

---

## URL Oficial da API

https://sigct.caixa.gov.br/api/v1

# VISÃO DO PROJETO
# Plataforma de Serviços de Indicadores SIGCT

## Resumo Executivo

O presente projeto tem como objetivo disponibilizar os dados operacionais e gerenciais do SIGCT por meio de uma plataforma de APIs REST, promovendo a evolução do modelo atual baseado em planilhas para uma arquitetura corporativa orientada a serviços.

A iniciativa permitirá que informações de indicadores, equipes, contratos, faturamento, produtividade e retenções sejam consumidas de forma padronizada por sistemas corporativos, Power BI, Power Platform, portais internos e futuras integrações.

A proposta busca estabelecer uma fonte única de dados, reduzindo atividades manuais de consolidação, aumentando a confiabilidade das informações e proporcionando acesso em tempo real aos indicadores gerenciais.

---

## Contexto

Atualmente parte das informações é disponibilizada por meio de planilhas eletrônicas utilizadas para análise, acompanhamento de contratos, faturamento e indicadores.

Embora esse modelo atenda necessidades operacionais, ele apresenta limitações relacionadas a:

- Dependência de processos manuais.
- Distribuição descentralizada dos dados.
- Possibilidade de divergência entre versões.
- Dificuldade de integração com outros sistemas.
- Baixa rastreabilidade do consumo das informações.
- Esforço recorrente para geração e envio de relatórios.

A disponibilização dos mesmos dados através de APIs elimina essas restrições e cria uma base tecnológica preparada para futuras evoluções.

---

## Objetivos Estratégicos

### Objetivos de Negócio

- Centralizar o acesso às informações do SIGCT.
- Aumentar a confiabilidade e consistência dos dados.
- Reduzir atividades operacionais de consolidação.
- Facilitar a integração com soluções corporativas.
- Permitir consultas em tempo real.
- Viabilizar futuras iniciativas analíticas e de automação.

### Objetivos Técnicos

- Implantar arquitetura orientada a serviços.
- Disponibilizar APIs REST padronizadas.
- Documentar interfaces via OpenAPI.
- Garantir escalabilidade e versionamento.
- Facilitar manutenção e evolução funcional.

---

## Arquitetura Proposta

### Princípios

- REST
- JSON UTF-8
- HTTPS
- OpenAPI 3.0
- Stateless
- Versionamento de APIs
- Baixo acoplamento
- Reutilização de serviços

### URL Base

```text
https://sigct.caixa.gov.br/api/v1
```

---

## Arquitetura Conceitual

```text
+------------------------------------------------+
| Consumidores                                   |
|------------------------------------------------|
| Power BI                                       |
| Power Apps                                     |
| Portal SIGCT                                   |
| Sistemas Corporativos                          |
| Aplicações Futuras                             |
+--------------------+---------------------------+
                     |
                     v
+------------------------------------------------+
| API SIGCT                                       |
|------------------------------------------------|
| REST                                            |
| JSON                                            |
| OpenAPI / Swagger                               |
+--------------------+---------------------------+
                     |
                     v
+------------------------------------------------+
| Serviços de Negócio                            |
+--------------------+---------------------------+
                     |
                     v
+------------------------------------------------+
| Base de Dados SIGCT                            |
| PostgreSQL                                     |
+------------------------------------------------+
```

---

## Escopo Inicial

### Equipes

Fornecimento das informações de equipes e respectivas vigências.

```http
GET /equipes
```

### Indicadores

Disponibilização dos indicadores calculados para acompanhamento contratual.

```http
GET /indicadores
```

### Contagens de Pontos de Função

Consulta consolidada de contagens por equipe.

```http
GET /contagens
```

### Notas por Código

Consulta das notas vinculadas aos sistemas e ciclos de faturamento.

```http
GET /notas_codigo
```

### Prévia de Retenção

Consulta dos dados utilizados para análise de retenções.

```http
GET /previa_retencao
```

---

## Requisitos Não Funcionais

### Segurança

- HTTPS obrigatório.
- Autenticação baseada em Token.
- Registro de auditoria de acessos.

As alternativas futuras de autenticação estão descritas no [ROADMAP.md](ROADMAP.md).

### Disponibilidade

- Operação contínua em ambiente corporativo.
- Monitoramento de saúde do serviço.
- Métricas operacionais e logs centralizados.

### Performance

- Respostas em formato JSON.
- Paginação para grandes volumes.

A avaliação futura de cache está descrita no [ROADMAP.md](ROADMAP.md).

### Governança

- Versionamento de APIs.
- Catálogo de serviços.
- Documentação centralizada.

---

## Benefícios Esperados

### Operacionais

- Redução de atividades manuais.
- Eliminação de múltiplas versões de planilhas.
- Simplificação do acesso às informações.

### Gerenciais

- Indicadores atualizados em tempo real.
- Maior transparência dos dados.
- Melhor apoio à tomada de decisão.

### Tecnológicos

- Integração simplificada.
- Reutilização de serviços.
- Evolução incremental da plataforma.

---

## Roadmap Evolutivo

O planejamento das versões, prioridades e evolução da plataforma está documentado em [ROADMAP.md](ROADMAP.md).

---

## Critérios de Sucesso

O projeto será considerado bem-sucedido quando:

- Os dados atualmente distribuídos por planilhas forem disponibilizados por APIs.
- Houver documentação pública interna dos serviços.
- Consumidores puderem integrar-se sem dependência de arquivos intermediários.
- As informações apresentarem consistência com os cálculos atualmente utilizados pelo SIGCT.
- O modelo permitir evolução incremental sem impacto aos consumidores existentes.

---

## Próximos Passos

As perspectivas de evolução da plataforma estão centralizadas em [ROADMAP.md](ROADMAP.md).

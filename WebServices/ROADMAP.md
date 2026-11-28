# Roadmap da API SIGCT

## V1

A primeira versão disponibiliza os cinco serviços REST essenciais para consultas operacionais e gerenciais: Equipes, Indicadores, Contagens de Pontos de Função, Notas por Código e Prévia de Retenção. Os recursos serão documentados em OpenAPI, expostos por HTTPS na URL base `/api/v1` e protegidos por autenticação baseada em Token. Também contemplam consultas padronizadas em JSON, paginação quando aplicável e suporte aos consumidores corporativos, como Power BI, Power Platform e sistemas internos.

## V2

- Disponibilizar o reprocessamento de indicadores sob demanda.
- Disponibilizar histórico de resultados e consultas por períodos anteriores.
- Implementar serviços analíticos.
- Evoluir a autenticação para OAuth2 Client Credentials.
- Avaliar a adoção de JWT.
- Integrar a autorização com o IAM corporativo.
- Avaliar cache para melhorar o desempenho de consultas recorrentes.

## V3

- Disponibilizar serviços de faturamentos.
- Disponibilizar serviços de contratos.
- Disponibilizar serviços de membros das equipes.
- Disponibilizar painéis em tempo real ou serviços que apoiem a atualização analítica.
- Ampliar iniciativas de automação e integrações com aplicações corporativas.

## Evolução transversal

- Manter compatibilidade e evolução incremental da plataforma sem impacto aos consumidores existentes.
- Ampliar monitoramento, auditoria e observabilidade.
- Expandir a documentação e o catálogo centralizado dos serviços.
- Tornar a API SIGCT uma camada oficial de integração dos dados operacionais e gerenciais, como base para relatórios, automação e novas soluções digitais.

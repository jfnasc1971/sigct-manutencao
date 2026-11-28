# API de Equipes e Indicadores

## Estrutura dos dados

Os dados desta documentação foram extraídos da planilha `SIGCT_Relatorio_Indicadores_V26.xlsx`.

Os períodos disponíveis vão de **20/08/2025 a 20/11/2026** para a data final da fatura e de **01/08/2025 a 01/11/2026** para a data considerada no cálculo dos indicadores.

## Padrão de filtros

Os endpoints `GET /api/v1/equipes`, `GET /api/v1/indicadores`, `GET /api/v1/contagens`, `GET /api/v1/notas_codigo` e `GET /api/v1/previa_retencao` seguem a seguinte regra:

- `contrato`: parâmetro obrigatório nos endpoints de equipes, indicadores, contagens e prévia de retenção.
- `codigo_equipe`: parâmetro opcional nos endpoints de equipes, indicadores, contagens e prévia de retenção.
- `data_fatura`: parâmetro obrigatório nos endpoints de indicadores e contagens.
- `ciclo_faturamento` e `sigla_sistema`: ao menos um deve ser informado no endpoint de notas por código.

## Endpoint 1: Equipes

`GET /api/v1/equipes`

### Parâmetros

| Parâmetro | Tipo | Obrigatório | Descrição |
|---|---|---|---|
| `contrato` | `varchar` | Sim | Contrato usado para localizar as equipes |
| `codigo_equipe` | `varchar` | Não | Código da equipe para restringir o resultado |

### Resposta

Entrega os dados básicos das equipes a partir do contrato informado e, opcionalmente, do código da equipe:

| Atributo | Descrição |
|---|---|
| `equipe` | Código identificador da equipe |
| `codigo_contrato` | Código do contrato |
| `contrato` | Nome ou descrição do contrato |
| `area` | Área responsável pela equipe |
| `comunidade` | Comunidade ou unidade de negócio |
| `grupo` | Grupo da equipe: `Desenvolvimento` ou `Suporte` |
| `situacao` | Situação encontrada na planilha; pode ser `null` quando não houver registro |
| `data_inicio` | Data inicial do registro, no formato `DD-MM-YYYY`; pode ser `null` |
| `data_fim` | Data efetiva de conclusão do registro, no formato `DD-MM-YYYY`; pode ser `null` |
| `vigencias` | Lista de períodos e perfis associados à equipe, incluindo matrícula, nome, datas, exclusão e turnover |

Exemplo com três equipes: [exemplo_equipes.json](exemplo_equipes.json)

## Endpoint 2: Indicadores

`GET /api/v1/indicadores`

### Parâmetros

| Parâmetro | Tipo | Obrigatório | Descrição |
|---|---|---|---|
| `contrato` | `varchar` | Sim | Contrato usado para localizar as equipes e seus indicadores |
| `codigo_equipe` | `varchar` | Não | Código da equipe para restringir o resultado |
| `data_fatura` | `date` | Sim | Data final da fatura no formato `DD-MM-YYYY`. Deve corresponder ao valor de `DT. FINAL FATURA` |

### Campos comuns

Os registros das abas de indicadores possuem os seguintes campos:

| Atributo | Tipo | Descrição |
|---|---|---|
| `equipe` | texto | Código identificador da equipe |
| `codigo_contrato` | texto | Código do contrato |
| `contrato` | texto | Nome ou descrição do contrato |
| `area` | texto | Área responsável |
| `comunidade` | texto | Comunidade ou unidade de negócio |
| `grupo` | texto | `Desenvolvimento` ou `Suporte` |
| `dt_final_fatura` | data | Data final da fatura |
| `fatura` | texto | Competência da fatura, por exemplo `Novembro/2026` |
| `cod_fatura` | texto/número | Código da fatura |
| `data_considerar_fns` | data | Data usada como referência no cálculo do indicador |
| `indicador` | texto | Sigla do indicador |

## Indicadores de Desenvolvimento

### IE - Desenvolvimento

| Atributo | Tipo | Descrição |
|---|---|---|
| `qt_itens_entregues` | inteiro | Quantidade de itens com entregas |
| `qt_itens_contratados` | inteiro | Quantidade de itens contratados |
| `valor_indicador` | decimal | Valor calculado do indicador IE |
| `valor_indicador_ajustado` | decimal | Valor ajustado do indicador IE |

### IP - Produtividade - Desenvolvimento

| Atributo | Tipo | Descrição |
|---|---|---|
| `qt_itens_com_contagem` | inteiro | Quantidade de itens com contagem |
| `qt_pontos_de_funcao` | decimal | Pontos de função considerados |
| `qt_colaboradores` | decimal | Quantidade de colaboradores |
| `qt_dias_trabalhados` | inteiro | Dias trabalhados no período |
| `qt_defeitos` | inteiro | Quantidade de defeitos |
| `qt_dias_trabalhados_defeitos` | inteiro | Dias trabalhados associados a defeitos |
| `qt_dias_trabalhados_pf` | inteiro | Dias trabalhados associados a pontos de função |
| `dt_inicio_desenvolvimento` | data | Data inicial do desenvolvimento |
| `qt_meses_desenvolvimento` | inteiro | Quantidade de meses de desenvolvimento |
| `produtividade_esperada` | decimal | Produtividade esperada |
| `valor_indicador` | decimal | Valor calculado do indicador IP |
| `valor_indicador_ajustado` | decimal | Valor ajustado do indicador IP |

### IQ - Desenvolvimento

| Atributo | Tipo | Descrição |
|---|---|---|
| `defeitos_corrigidos_periodo_anterior` | inteiro | Defeitos corrigidos no período anterior |
| `defeitos_abertos_periodo_anterior` | inteiro | Defeitos ainda abertos no período anterior |
| `defeitos_corrigidos` | inteiro | Defeitos corrigidos no período |
| `defeitos_abertos` | inteiro | Defeitos abertos no período |
| `razao_iqrd` | decimal | Razão usada no cálculo do IQRD |
| `valor_iqrd` | decimal | Valor calculado do IQRD |
| `peso_iqrd` | decimal | Peso do IQRD |
| `soma_notas` | decimal | Soma das notas consideradas no IQNP |
| `qt_siglas` | inteiro | Quantidade de siglas consideradas |
| `nota_media_iqnp` | decimal | Nota média do IQNP |
| `valor_iqnp` | decimal | Valor calculado do IQNP |
| `peso_iqnp` | decimal | Peso do IQNP |
| `faixa_fns` | decimal | Faixa FNS usada no cálculo gravado |
| `valor_indicador` | decimal | Valor final do indicador IQ |

Observação: `RAZAO IQRD`, `VALOR IQRD`, `SOMA NOTAS`, `NOTA MEDIA IQNP`, `VALOR IQNP` e `VALOR INDICADOR` podem estar vazios em parte dos registros.

### IT - Desenvolvimento

| Atributo | Tipo | Descrição |
|---|---|---|
| `valor_indicador` | decimal | Valor calculado do indicador IT |
| `faixa_fns` | decimal | Faixa FNS aplicada ao indicador |
| `dt_inicio_trimestre` | data | Data inicial do trimestre |
| `dt_fim_trimestre` | data | Data final do trimestre |
| `qt_desligamentos_perfis_trimestre_contratada` | inteiro | Desligamentos de perfis no trimestre da contratada |
| `perfis_da_contratada_ao_final_do_ultimo_trimestre` | inteiro | Perfis da contratada no fim do último trimestre |

### FNS - Desenvolvimento

| Atributo | Tipo | Descrição |
|---|---|---|
| `ie` | decimal | Valor do indicador IE usado no cálculo |
| `ip` | decimal | Valor do indicador IP usado no cálculo |
| `iq` | decimal | Valor do indicador IQ usado no cálculo |
| `it` | decimal | Valor do indicador IT usado no cálculo |
| `fns_aplicado` | decimal | Fator FNS aplicado |

### IDE - Desenvolvimento

| Atributo | Tipo | Descrição |
|---|---|---|
| `ie` | decimal | Valor do indicador IE usado no cálculo |
| `ie_peso` | decimal | Peso aplicado ao IE |
| `ie_x_peso` | decimal | Resultado de IE multiplicado pelo peso |
| `iq` | decimal | Valor do indicador IQ usado no cálculo |
| `iq_peso` | decimal | Peso aplicado ao IQ |
| `iq_x_peso` | decimal | Resultado de IQ multiplicado pelo peso |
| `ip` | decimal | Valor do indicador IP usado no cálculo |
| `ip_peso` | decimal | Peso aplicado ao IP |
| `ip_x_peso` | decimal | Resultado de IP multiplicado pelo peso |
| `valor_indicador` | decimal | Valor final do indicador IDE |

## Indicadores de Suporte

### IE - Suporte

| Atributo | Tipo | Descrição |
|---|---|---|
| `qt_itens_entregues` | inteiro | Quantidade de itens com entregas |
| `qt_itens_contratados` | inteiro | Quantidade de itens contratados |
| `valor_indicador` | decimal | Valor calculado do indicador IE |
| `valor_indicador_ajustado` | decimal | Valor ajustado do indicador IE |

### IT - Suporte

| Atributo | Tipo | Descrição |
|---|---|---|
| `valor_indicador` | decimal | Valor calculado do indicador IT |
| `faixa_fns` | decimal | Faixa FNS aplicada ao indicador |
| `dt_inicio_trimestre` | data | Data inicial do trimestre |
| `dt_fim_trimestre` | data | Data final do trimestre |
| `qt_desligamentos_perfis_trimestre_contratada` | inteiro | Desligamentos de perfis no trimestre da contratada |
| `perfis_da_contratada_ao_final_do_ultimo_trimestre` | inteiro | Perfis da contratada no fim do último trimestre |

### FNS - Suporte

| Atributo | Tipo | Descrição |
|---|---|---|
| `ie` | decimal | Valor do indicador IE usado no cálculo |
| `it` | decimal | Valor do indicador IT usado no cálculo |
| `fns_aplicado` | decimal | Fator FNS aplicado |

## Endpoint 3: Contagens PF

`GET /api/v1/contagens`

### Parâmetros

| Parâmetro | Tipo | Obrigatório | Descrição |
|---|---|---|---|
| `contrato` | `varchar` | Sim | Contrato usado para localizar as contagens |
| `codigo_equipe` | `varchar` | Não | Código da equipe para restringir o resultado |
| `data_fatura` | `date` | Sim | Data final da fatura no formato `DD-MM-YYYY`, usada no filtro das contagens |

### Resposta

A resposta agrupa as contagens por grupo e equipe:

| Atributo | Tipo | Descrição |
|---|---|---|
| `data_consulta` | `timestamp` | Data e hora da consulta no formato `DD-MM-YYYY HH:mm` |
| `codigo_contrato` | `varchar` | Código do contrato associado à consulta |
| `contrato` | `varchar` | Nome ou descrição do contrato associado à consulta |
| `grupos` | `array` | Grupos encontrados na consulta |
| `grupo` | `varchar` | Nome do grupo da equipe, como `Desenvolvimento` ou `Suporte` |
| `equipes` | `array` | Equipes pertencentes ao grupo |
| `equipe` | `varchar` | Código identificador da equipe |
| `codigo_contrato` | `varchar` | Código do contrato da equipe |
| `area` | `varchar` | Área responsável pela equipe |
| `comunidade` | `varchar` | Comunidade ou unidade de negócio da equipe |
| `contagens_pf` | `array` | Lista de contagens de pontos de função da equipe |
| `resultado_da_consulta` | `integer` | Código do resultado: `0` para sucesso ou `1` para erro |

### Atributos de uma contagem PF

| Atributo | Tipo | Descrição |
|---|---|---|
| `co_ciclo_trabalho` | `varchar` | Código do ciclo de trabalho |
| `co_solicitacao` | `varchar` | Código da solicitação |
| `de_tipo_solicitacao` | `varchar` | Tipo da solicitação, como manutenção evolutiva, corretiva ou defeito |
| `de_situacao_solicitacao` | `varchar` | Situação atual da solicitação |
| `nu_tamanho_servico` | `decimal` | Tamanho do serviço em pontos de função |

Exemplo: [exemplo_equipe_contagens.json](exemplo_equipe_contagens.json)

## Endpoint 4: Notas por Código

`GET /api/v1/notas_codigo`

### Parâmetros

| Parâmetro | Tipo | Obrigatório | Descrição |
|---|---|---|---|
| `ciclo_faturamento` | `varchar` | Condicional | Ciclo de faturamento usado no filtro, por exemplo `01/2024`. Deve ser informado caso `sigla_sistema` não seja informado |
| `sigla_sistema` | `varchar` | Condicional | Sigla do sistema usada no filtro. Deve ser informada caso `ciclo_faturamento` não seja informado |

### Regra de filtro

Ao menos um dos dois parâmetros deve ser informado:

- Se somente `ciclo_faturamento` for informado, o endpoint retorna todas as siglas cadastradas para esse ciclo.
- Se somente `sigla_sistema` for informada, o endpoint retorna todas as notas de todos os ciclos cadastrados para essa sigla.
- Se os dois forem informados, o endpoint retorna somente as notas correspondentes ao ciclo e à sigla informados.

### Resposta

| Atributo | Tipo | Descrição |
|---|---|---|
| `data_consulta` | `timestamp` | Data e hora da consulta no formato `DD-MM-YYYY HH:mm` |
| `ciclo_faturamento` | `varchar` | Ciclo de faturamento utilizado na consulta |
| `notas_codigo` | `array` | Lista de notas agrupadas por sigla de sistema |
| `ciclo_faturamento` | `varchar` | Ciclo de faturamento da nota |
| `sigla_sistema` | `varchar` | Sigla do sistema avaliado |
| `nota_apurada` | `decimal` | Nota apurada, em formato brasileiro com mínimo de duas casas decimais |
| `data_modificacao` | `timestamp` | Data da última modificação no formato `DD-MM-YYYY HH:mm:ss,SSS` |
| `resultado_da_consulta` | `integer` | Código do resultado: `0` para sucesso ou `1` para erro |

Exemplo: [exemplo_notas_codigo.json](exemplo_notas_codigo.json)

## Endpoint 5: Prévia de Retenção

`GET /api/v1/previa_retencao`

### Parâmetros

| Parâmetro | Tipo | Obrigatório | Descrição |
|---|---|---|---|
| `contrato` | `varchar` | Sim | Contrato usado para localizar as equipes na prévia de retenção |
| `codigo_equipe` | `varchar` | Não | Código da equipe para restringir o resultado |

### Resposta

A resposta agrupa as equipes por grupo:

| Atributo | Tipo | Descrição |
|---|---|---|
| `data_consulta` | `timestamp` | Data e hora da consulta no formato `DD-MM-YYYY HH:mm` |
| `codigo_contrato` | `varchar` | Código do contrato associado à consulta |
| `contrato` | `varchar` | Nome ou descrição do contrato associado à consulta |
| `grupos` | `array` | Grupos encontrados na consulta |
| `grupo` | `varchar` | Nome do grupo da equipe |
| `equipes` | `array` | Equipes pertencentes ao grupo |
| `codigo_contrato` | `varchar` | Código do contrato da equipe |
| `contrato` | `varchar` | Nome ou descrição do contrato da equipe |
| `area` | `varchar` | Área responsável pela equipe |
| `comunidade` | `varchar` | Comunidade da equipe |
| `equipe` | `varchar` | Código identificador da equipe |
| `data_inicio` | `timestamp` | Data e hora de início no formato `DD-MM-YYYY HH:mm:ss,SSS` |
| `data_fim` | `timestamp` | Data e hora de fim; pode ser `null` |
| `quantidade_atendimentos` | `decimal` | Quantidade de atendimentos; pode ser `null` |
| `sprints_pendentes` | `decimal` | Quantidade de sprints pendentes; pode ser `null` |
| `resultado_da_consulta` | `integer` | Código do resultado: `0` para sucesso ou `1` para erro |

Exemplo: [exemplo_previa_retencao.json](exemplo_previa_retencao.json)

## Exemplos de resposta JSON

Os exemplos completos estão armazenados em arquivos JSON separados:

- [Exemplo do endpoint /api/v1/equipes](exemplo_equipes.json)
- [Exemplo unificado de indicadores](exemplo_equipe_indicadores.json)
- [Exemplo do endpoint /api/v1/contagens](exemplo_equipe_contagens.json)
- [Exemplo do endpoint /api/v1/notas_codigo](exemplo_notas_codigo.json)
- [Exemplo do endpoint /api/v1/previa_retencao](exemplo_previa_retencao.json)

O arquivo completo reúne uma equipe de Desenvolvimento e uma equipe de Suporte. A equipe de Desenvolvimento contém os indicadores IE, IP, IQ, IT e FNS; a equipe de Suporte contém IE, IT e FNS, todos associados à competência de agosto de 2025.

### Atributos de resposta adicionais

Além dos campos específicos de cada indicador, as respostas dos endpoints incluem os seguintes atributos:

| Atributo | Descrição |
|---|---|
| `data_consulta` | Timestamp da consulta no formato `DD-MM-YYYY HH:mm` |
| `grupos` | Lista de grupos; cada grupo contém o nome `grupo` e a lista `equipes` correspondentes |

## Formato dos dados

- Datas: `DD-MM-YYYY`.
- Timestamp de saída: `DD-MM-YYYY HH:mm`.
- Timestamp com milissegundos: `DD-MM-YYYY HH:mm:ss,SSS`.
- Números: representados como texto no padrão brasileiro, com separador decimal de vírgula, mínimo de duas casas decimais e máximo de oito casas decimais.
- Valores nulos continuam representados por `null`.

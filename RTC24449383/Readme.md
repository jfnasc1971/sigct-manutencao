RTC 24449383 - SIGCT - Inclusão de parâmetro para ativar os indicadores do especializado

# Como administrador do sistema
Quero ter uma opção parametrizada para ativar ou desativar os cálculos dos indicadores,
Para que eu possa controlar quando os indicadores devem ser processados, evitando cálculos desnecessários ou fora do contexto.
Observações Técnicas
* Avaliar impacto em processos automáticos (jobs, integrações).
* Garantir que a mudança não afete indicadores históricos.
 
# Critérios de Aceitação
* Deve existir um parâmetro configurável no sistema.
* Quando o parâmetro estiver desativado, nenhum cálculo de indicadores deve ser executado, mesmo que outras rotinas sejam acionadas.
* Quando o parâmetro estiver ativado, os cálculos devem ocorrer normalmente conforme as regras atuais.
* A configuração deve ser persistida e refletir corretamente no comportamento do sistema.
* Deve haver registro (log) indicando quando o parâmetro foi alterado e por quem.
--
-- REGRAS DE VALIDAÇÃO
--

-- ACIONAMENTO E SPRINT

Se a História não possui "Tipo"
  -> encerra a análise e registra o erro de vinculação

Se a História não possui "Data Prevista"
  -> encerra a análise e registra o erro de vinculação

Se a História não possui "Departamento" (Centro de Custo)
  -> encerra a análise e registra o erro de vinculação

Se a História não possui "IC Afetado" (Sigla do sistema, Item de Portfolio)
  -> encerra a análise e registra o erro de vinculação

Se o estado da História for "Cancelada"
  -> encerra a análise e registra o erro de vinculação

Se a Tarefa vinculada à História não foi atribuída a uma matrícula
  -> encerra a análise e registra o erro de vinculação

Se o estado da Tarefa vinculada à História for "Cancelada"
  -> encerra a análise e registra o erro de vinculação

Se a matricula atribuída à Tarefa vinculada à História pertence à equipe concluída e a 
data prevista da História NÃO está dentro do periodo de atendimento da equipe
  -> encerra a análise e registra o erro de vinculação

Se a matricula atribuída à Tarefa está vinculada à equipe Ativa ou Concluída e a 
data prevista do História é anterior a data de início de atendimento
  -> encerra a análise e registra o erro de vinculação

Se a matricula atribuída à Tarefa está vinculada à equipe Ativa ou Concluída e a 
data prevista ultrapassa a data fim do contrato da Equipe
  -> encerra a análise e registra o erro de vinculação

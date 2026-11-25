select
  s.nu_solicitacao,   -- Código interno no SIGCT
  s.co_solicitacao,   -- Número
  s.nu_unidade_custo, -- Departamento (5229-GECPA)
                      -- O sistema recupera da tabela 038 e se encontrar
                      -- preenche nu_unidade_custo, nu_natural_custo e sg_unidade_custo 
  s.nu_natural_custo,  
  s.sg_unidade_custo,
  s.nu_mtrca_atribuicao,  -- Atribuição a
  s.no_membro_atribuicao,
  s.dh_inicio, -- Data de início planejada
  s.dh_inicio_desenvolvimento, -- Data de início real 
                               -- Preenchido pelo Service Now quando o Estado muda para "Trabalho em Andamento"
  s.dh_prevista, -- Data de término planejada 
                 -- Data prevista informada pelo Gestor/Fábrica
  s.dh_efetiva, -- Esse campo não aparece diretamente na tela do Service, 
                -- é preechido/alterado sempre que o atendimento vira para "Pronto"
  s.dh_resolucao, -- Data de término real 
                  -- Preenchido pelo Service Now quando o Estado muda para "Concluído"
  s.ic_bef, -- Critérios atendidos para o enquadramento da demanda em investimento (CAPEX) 
            -- N - Vazio ou "Não se Aplica"
            -- S - Qualquer outro valor 
  s.ic_capex, -- NAO SEI A UTILIDADE DESSE CAMPO, ANOTEI PARA LEMBRAR DE VERIFICAR
  s.co_sysid_servicenow, -- SYS_ID no Service NOW
                         -- chave única no Service
                         -- deve ser usado para montar os links de acesso
  s.dh_modificacao
from
  gct.gcttb005_solicitacao s
where
  s.co_solicitacao = 'STRY00013656';

--
-- DEVOLUCOES
--
--
-- Sempre que o estado que da Solicitação retorna de "Pronto" para algum um estado anterior
-- o SIGCT registra que houve uma devolução
--
select
  s.co_solicitacao,
  ds.dh_rejeicao
from
  gct.gcttb226_devolucao_solicitacao ds
  inner join gct.gcttb005_solicitacao s on s.nu_solicitacao = ds.nu_solicitacao
where
  s.co_solicitacao = 'STRY00013656';

select
  count(*) as qt_devolucoes
from
  gct.gcttb226_devolucao_solicitacao ds
  inner join gct.gcttb005_solicitacao s on s.nu_solicitacao = ds.nu_solicitacao
where
  s.co_solicitacao = 'STRY00013656';  
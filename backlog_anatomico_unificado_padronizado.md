# Backlog Anatômico Unificado — MVP-1

_Atualizado: 2025-11-08_

## Visão Geral

O backlog anatômico consolida o MVP-1 do Code-Brain em quatro trilhas principais (UC-0001..UC-0004). Cada trilha referencia diretamente as tarefas formais do `code-brain/to-do/tasks.yaml`, garantindo rastreabilidade entre objetivos, critérios de aceite e validações.

| Use Case | Objetivo | Tarefas | Status |
| --- | --- | --- | --- |
| UC-0001 | Sincronizar o gerenciador de contexto (`context.yaml` ↔ `context-index.yaml`) | T-0001 | Done |
| UC-0002 | Mapear o pipeline cognitivo INSIGHT→USE-CASE→TO-DO | T-0002 | Todo |
| UC-0003 | Consolidar templates e validadores de documentação | T-0003, T-0005 | Todo |
| UC-0004 | Estabelecer o workflow Git padrão (branch, PR, validações) | T-0004 | Todo |

## Detalhamento Anatômico

### UC-0001 — Gerenciador de Contexto
- **Task**: T-0001 — Orquestrar o gerenciador de contexto
- **Objetivo**: alinhar metadados, governança e estrutura obrigatória entre `context.yaml` e `context-index.yaml`.
- **Critérios de Aceite**:
  1. `context.yaml` reflete todos os campos do index (metadados, governança, estrutura, MVP tracking).
  2. Divergências são registradas em `structure_alignment` com notas de ação.
  3. Fluxo de atualização do contexto está descrito no AGENTS/prompt e documentado nos logs IA.
- **Status atual**: ✅ Concluído em 2025-11-08; lacuna do backlog anatômico resolvida com este arquivo e registradas validações extras no contexto.

### UC-0002 — Pipeline Cognitivo INSIGHT→USE-CASE→TO-DO
- **Tasks**: T-0002 (principal).
- **Objetivo**: descrever, em guia operacional, como insights se transformam em use cases e, finalmente, em tarefas rastreáveis.
- **Entradas necessárias**: project-guide.md (pipeline cognitivo), AGENTS.md (pipeline operacional), logs recentes.
- **Saídas esperadas**:
  - Documento com entradas/saídas/responsáveis por etapa.
  - Regras de nomenclatura de IDs e dependências atualizadas.
  - Referências cruzadas no AGENTS ou prompt.md.
- **Situação**: ⏳ Aguardando conclusão de T-0001.

### UC-0003 — Templates & Validação de Documentação
- **Tasks**: T-0003 (templates), T-0005 (validadores).
- **Objetivo**: garantir consistência dos templates (developer-notes, project guide, workflows) e criar validadores YAML/Markdown obrigatórios.
- **Critérios**:
  - Templates possuem instruções claras e campos obrigatórios.
  - Exemplos preenchidos garantem entendimento.
  - Validadores (ex.: `yamllint`, markdownlint) integram o estágio TEST do pipeline.
- **Situação**: ⏳ Pendentes; dependem da finalização de T-0001/T-0002 para herdar contexto atualizado.

### UC-0004 — Workflow Git Padronizado
- **Task**: T-0004.
- **Objetivo**: aplicar o padrão `feature/UC-XXX/TXXX`, títulos de PR `[UC-XXX] ...` e validar regras via scripts/guidelines.
- **Artefatos já presentes**:
  - `code-brain/git/workflow-template.md`
  - `code-brain/guidelines/git/workflow-template.md`
- **Próximos passos**:
  1. Sincronizar template e guidelines (evitar drift).
  2. Integrar checagens automáticas (preflight) ao pipeline TEST.
  3. Documentar exemplos no project-guide/guidelines.
- **Situação**: ⏳ Aguardando.

## Próximas Ações Prioritárias
1. Finalizar a documentação do pipeline INSIGHT→USE-CASE→TO-DO (T-0002).
2. Revisar/atualizar templates essenciais e conectar validadores ao pipeline (T-0003/T-0005).
3. Consolidar workflow Git e scripts de validação (T-0004).

> Qualquer atualização neste backlog deve ser refletida simultaneamente no `tasks.yaml` e registrada em um log IA seguindo o template oficial.

# Backlog Anatômico Unificado — MVP-1

_Atualizado: 2025-11-08 19:31 UTC_

## Visão Geral

O backlog anatômico consolida o MVP-1 do Code-Brain em quatro trilhas principais (UC-0001..UC-0004). Cada trilha referencia diretamente as tarefas formais do `code-brain/to-do/tasks.yaml`, garantindo rastreabilidade entre objetivos, critérios de aceite e validações.

| Use Case | Objetivo | Tarefas | Status |
| --- | --- | --- | --- |
| UC-0001 | Sincronizar o gerenciador de contexto (`context.yaml` ↔ `context-index.yaml`) | T-0001 | Done |
| UC-0002 | Mapear o pipeline cognitivo INSIGHT→USE-CASE→TO-DO | T-0002 | Done |
| UC-0003 | Consolidar templates e validadores de documentação | T-0003, T-0005 | Done |
| UC-0004 | Estabelecer o workflow Git padrão (branch, PR, validações) | T-0004 | Done |
| UC-0005 | Estruturar armazenamento de insights/use-cases | T-0006, T-0007 | Done |

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
- **Tasks**: T-0002 (concluída).
- **Objetivo**: descrever, em guia operacional, como insights se transformam em use cases e, finalmente, em tarefas rastreáveis.
- **Entradas utilizadas**: `project-guide.md`, `AGENTS.md`, backlog anatômico e logs IA.
- **Entregas**:
  - `code-brain/guidelines/pipeline-insight-usecase-todo.md` com entradas/saídas/responsáveis e checklist.
  - Referência adicionada ao `prompt.md` para garantir uso do pipeline.
  - Atualizações no `context.yaml` e `tasks.yaml` refletindo a conclusão.
- **Situação**: ✅ Finalizado em 2025-11-08; pipeline pronto para alimentar UC-0003/UC-0004.

### UC-0003 — Templates & Validação de Documentação
- **Tasks**: T-0003 (templates), T-0005 (validadores) — concluídas.
- **Objetivo**: garantir consistência dos templates (developer-notes, project guide) e criar validadores YAML/Markdown obrigatórios.
- **Entregas**:
  - `code-brain/developer/developer-notes.template.md` atualizado com instruções operacionais, checklist de IDs e orientação de validação.
  - `code-brain/project-guide.template.md` reescrito seguindo a estrutura oficial do guia e pipeline cognitivo.
  - `code-brain/scripts/validate-docs.sh` + `validate-docs.py` cobrindo `yamllint` e lint básico de Markdown (sem dependências externas).
  - Referência ao script incluída no `prompt.md` e estado registrado no `context.yaml`.
- **Situação**: ✅ Finalizado em 2025-11-08; próximos passos focam nas integrações Git e no armazenamento dedicado de `IN/UC`.

### UC-0004 — Workflow Git Padronizado
- **Tasks**: T-0004 (workflow) e T-0007 (automação CI).
- **Objetivo**: aplicar o padrão `feature/UC-XXX/TXXX`, títulos de PR `[UC-XXX] ...` e validar regras via scripts/guidelines.
- **Entregas**:
  - `code-brain/git/workflow-template.md` reescrito com ciclo completo, checklist e referências.
  - `code-brain/guidelines/git/guidelines.md` exige `preflight.sh` + `validate-docs.sh`.
  - `code-brain/guidelines/preflight-cicd.md` executa `code-brain/scripts/validate-docs.sh` antes do `preflight.sh` em GitHub/GitLab/Jenkins.
  - `context.yaml` e `tasks.yaml` registram as conclusões.
- **Situação**: ✅ Finalizado em 2025-11-09; próximos passos focam em métricas e exemplos.

### UC-0005 — Estrutura de Armazenamento IN/UC
- **Tasks**: T-0006 — Definir armazenamento para IN/UC. T-0007 contribui ao conectar scripts ao CI.
- **Objetivo**: criar diretórios oficiais e templates para registrar insights (`IN-XXXX`) e use-cases (`UC-XXXX`) de forma rastreável.
- **Entregas**:
  - `code-brain/data/insights/` e `code-brain/use-cases/` com README.
  - Templates `code-brain/templates/insight.template.md` e `code-brain/templates/use-case.template.md`.
  - Atualizações em `context-index.yaml`, `context.yaml`, `tasks.yaml`.
- **Situação**: ✅ Finalizado em 2025-11-09; próximos passos incluem popular diretórios com registros reais e monitorar execuções no CI.

## Próximas Ações Prioritárias
1. Registrar os primeiros documentos `IN-XXXX`/`UC-XXXX` usando os novos templates.
2. Automatizar exemplos e métricas do workflow Git dentro do project-guide/guidelines.
3. Monitorar execuções do validate-docs/preflight nas pipelines e publicar relatórios.

> Qualquer atualização neste backlog deve ser refletida simultaneamente no `tasks.yaml` e registrada em um log IA seguindo o template oficial.

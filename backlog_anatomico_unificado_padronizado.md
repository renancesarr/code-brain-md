# Backlog Anatômico Unificado — MVP-1

_Atualizado: 2025-11-08 19:31 UTC_

## Visão Geral

O backlog anatômico consolida o MVP-1 do Code-Brain em quatro trilhas principais (UC-0001..UC-0004). Cada trilha referencia diretamente as tarefas formais do `code-brain/to-do/tasks.yaml`, garantindo rastreabilidade entre objetivos, critérios de aceite e validações.

| Use Case | Objetivo | Tarefas | Status |
| --- | --- | --- | --- |
| UC-0001 | Sincronizar o gerenciador de contexto (`context.yaml` ↔ `context-index.yaml`) | T-0001 | Done |
| UC-0002 | Mapear o pipeline cognitivo INSIGHT→USE-CASE→TO-DO | T-0002 | Done |
| UC-0003 | Consolidar templates e validadores de documentação | T-0003, T-0005 | Done |
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
1. Consolidar workflow Git e scripts de validação (T-0004).
2. Definir repositório/estrutura física para documentos `UC-XXXX` e `IN-XXXX`.
3. Integrar o script `validate-docs.sh` ao preflight/CI futuro.

> Qualquer atualização neste backlog deve ser refletida simultaneamente no `tasks.yaml` e registrada em um log IA seguindo o template oficial.

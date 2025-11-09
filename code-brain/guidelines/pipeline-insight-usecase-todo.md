# Pipeline Cognitivo — INSIGHT → USE-CASE → TO-DO

> Fonte oficial para transformar ideias em tarefas rastreáveis no Code-Brain.

## Visão Geral

| Etapa   | Objetivo                                        | Entradas                            | Saídas Principais                                    | Responsável primário |
| ------- | ----------------------------------------------- | ----------------------------------- | ---------------------------------------------------- | -------------------- |
| INSIGHT | Capturar sinais, problemas ou oportunidades     | Logs, métricas, feedback, pesquisas | `code-brain/data/insights/IN-0001.md`                | Product / Pesquisa   |
| USE-CASE| Converter insights em objetivos coesos          | `IN-XXXX`, project-guide, backlog   | `code-brain/use-cases/UC-0001.md` com critérios      | Product + AI Planner |
| TO-DO   | Quebrar o use-case em tarefas executáveis       | `UC-XXXX`, context.yaml             | Entradas `T-0001` em `code-brain/to-do/tasks.yaml`   | AI Dev + Engineering |

Checklist mínimo:
1. Sempre valide a etapa anterior antes de avançar.
2. Documente IDs e decisões no log IA correspondente.
3. Atualize `context.yaml` e `backlog_anatomico_unificado_padronizado.md` após qualquer promoção de etapa.

## 1. INSIGHT

- **Quando usar**: surgem problemas, métricas anômalas, pedidos de stakeholders.
- **Insumos obrigatórios**:
  - Fonte do insight (link de log, métrica, feedback).
  - Impacto esperado (qualitativo ou numérico).
  - Evidências já coletadas.
- **Artefato**: entrada `IN-0001` seguindo regex `^IN-\d{4}$`. Guardar em `code-brain/data/insights/IN-0001.md`.
- **Responsável**: Product / Pesquisa (humano) ou IA com autorização explícita.
- **Critérios para promover**:
  1. Insight validado (não duplicado, relevância confirmada).
  2. Há uma hipótese clara de solução.
  3. Stakeholders impactados identificados.
- **Saída**: Pacote de contexto enviado à etapa USE-CASE, anexando links/arquivos relevantes no log IA da sessão.

## 2. USE-CASE

- **Objetivo**: explicar, em alto nível, o que precisa ser entregue para sanar o insight.
- **Entradas**: `IN-XXXX`, `project-guide.md`, `context.yaml::mvp_tracking`, restrições do AGENTS.
- **Artefatos obrigatórios**:
  - Documento `code-brain/use-cases/UC-0001.md` (regex `^UC-\d{4}$`) conforme `context-index`.
  - Critérios de aceite, indicadores de sucesso e dependências.
  - Rascunho de plano de validação (quais scripts/linters serão usados).
- **Responsável**: Product + AI Planner (agente principal).
- **Transição para TO-DO** (tudo deve estar atendido):
  1. Critérios de aceite claros e verificáveis.
  2. Riscos mapeados e mitigação registrada.
  3. Alinhamento com MVP e com prioridades do backlog.
  4. Link para o insight original e localização do documento UC.

## 3. TO-DO

- **Objetivo**: quebrar o use-case em unidades anatômicas executáveis.
- **Fonte**: documento `UC-XXXX` aprovado.
- **Artefato**: entradas em `code-brain/to-do/tasks.yaml` seguindo `code-brain/to-do/tasks.template.yaml`.
- **Responsável**: AI Dev / Engenharia.
- **Campos obrigatórios por tarefa** (reforço do template):
  - `id` (`^T-\d{4}$`), `title`, `description`, `status`, `priority`.
  - `related_use_case`, `decisions`, `insights`, `depends_on`.
  - `acceptance_criteria`, `test_plan`, `rollback_plan`, `assignees`, `updated_at`.
- **Regras de promoção**:
  1. Cada T-XXXX deve mapear 1:1 com um deliverable verificável.
  2. Dependências precisam existir e estar ordenadas.
  3. Logs IA devem citar o ID da tarefa e evidências de validação.
- **Saídas**:
  - Atualização do backlog anatômico.
  - Atualização de `context.yaml::active_tasks`.
  - Opcionalmente, criação de branches `feature/UC-XXX/TXXX` no Git.

## Nomenclatura Oficial

| Tipo     | Regex         | Armazenamento padrão                           | Observações                                  |
| -------- | ------------- | ---------------------------------------------- | -------------------------------------------- |
| Insight  | `^IN-\d{4}$`  | `code-brain/data/insights/` (quando existir)   | Registrar link para métricas/logs            |
| Use-case | `^UC-\d{4}$`  | `code-brain/use-cases/UC-0001.md` (futuro)     | Referenciar T-XXXX relacionados              |
| Task     | `^T-\d{4}$`   | `code-brain/to-do/tasks.yaml`                  | Já implementado                              |
| Branch   | `feature/UC-XXX/TXXX` | Git                                     | Validado via `code-brain/guidelines/git/...` |

## Procedimento Operacional

1. **Capturar Insight**
   - Preencher `IN-XXXX` e citar no log IA.
   - Avaliar duplicidade no backlog/anotações existentes.
2. **Planejar Use-case**
   - Criar `UC-XXXX` com problema, objetivo, DoR, DoD, riscos.
   - Atualizar backlog anatômico na seção correspondente.
3. **Gerar Tarefas**
   - Duplicar template do `tasks.yaml` e preencher atributos.
   - Atualizar `context.yaml` (active/pending/completed).
4. **Executar & Validar**
   - Seguir pipeline do AGENTS (PLAN→READ→PATCH→TEST→NEXT).
   - Rodar validadores (`yamllint`, lint Markdown, testes customizados).
5. **Documentar**
   - Log IA com contexto lido, decisões, riscos e próximos passos.
   - Atualizar backlog anatômico e, se aplicável, `project-guide`.

## Integrações

- **AGENTS.md / Prompt**: referenciam este documento como fonte do pipeline.
- **Context.yaml**: lista o backlog anatômico e as tarefas associadas.
- **Logs IA**: cada passagem pela pipeline deve citar Insight/Use-case/Tarefa ativos.
- **Guidelines Git**: branches e PRs sempre carregam `UC` e `T` no nome/título.

## Auditoria Rápida

- [ ] Existe `IN-XXXX` para cada `UC-XXXX`?
- [ ] Cada `UC-XXXX` referencia seus `T-XXXX` no backlog?
- [ ] `tasks.yaml` mantém `related_use_case` e `insights` preenchidos?
- [ ] `context.yaml` está sincronizado (current/pending/completed)?
- [ ] Logs IA citam IDs e validadores executados?

Se alguma resposta for "não", retorne à etapa correspondente antes de prosseguir.

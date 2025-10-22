# TO-DO — Backlog Cognitivo
> Este arquivo segue o schema `code-brain/to-do/schema.yaml`.
> A IA deve atualizar este documento sempre que modificar `tasks.yaml`.

---

## Estado das Tarefas
Legenda:  
🕓 = `queued` ⚙️ = `in_progress` ⛔ = `blocked` 🔍 = `review` ✅ = `done`

---

### 🕓 T-001 — Normalizar números E.164  
**Status:** `in_progress` **Owner:** `ia` **Prioridade:** `high`  
**Última atualização:** `2025-10-21T11:48:52.509563`  

**Descrição:**  
Implementar regex universal E.164.  

**Contexto:**  
`code-brain/solution-architect/phone-normalization.md`  

**Aceite:**  
- 90%+ dos números válidos seguem E.164  
- Latência p95 < 50ms  

**Metadados:**  
- `ambiguous`: false  
- `estimated_confidence`: 0.94  

---

### 🕓 T-002 — Melhorar logs estruturados  
**Status:** `queued` **Owner:** `ia` **Prioridade:** `medium`  
**Descrição:**  
Adicionar estrutura JSON e níveis de severidade.  

**Contexto:**  
`code-brain/solution-architect/logs.md`  

**Aceite:**  
- Logs no formato JSON com 100% de parseabilidade  

**Metadados:**  
- `ambiguous`: false  
- `estimated_confidence`: 0.88  

---

## Instruções Operacionais
1. A IA deve refletir qualquer alteração neste Markdown também em `tasks.yaml`.  
2. As transições válidas de status estão descritas em `schema.yaml`.  
3. Ao mudar `status: done`, mover a tarefa para `archive.md` e gerar registro em `memory/last-change.yaml`.  
4. Campos `ambiguous` e `estimated_confidence` devem ser atualizados pela IA conforme interpretação do contexto.  

---

## Estrutura YAML equivalente
```yaml
tasks:
- id: T001
  title: Normalizar números E.164
  description: Implementar regex universal E.164.
  status: in_progress
  owner: ia
  priority: high
  context:
    architecture: code-brain/solution-architect/phone-normalization.md
  acceptance:
  - 90%+ dos números válidos seguem E.164
  updated_at: '2025-10-21T11:48:52.509563'
```

# IA Change Template

> Salvar como `code-brain/developer/logs-ai-code/<timestamp>-ia-code.md`

## 1. Contexto consumido

Uma lista estruturada com tudo que a IA (ou o autor) "consumiu" para produzir a alteração.
Preencha esta seção com entradas claras e objetivas — ela é usada para auditoria, revisão humana e para facilitar reprodução.

Exemplo (bloco YAML ou lista):

````yaml
docs_read:
 - path: "code-brain/guidelines/preflight.md"
 
  summary: "Descrição das validações de branch e commit"
  - path: "code-brain/usecases/template.md"
    summary: "Template padrão para use cases"

files_opened:
  - path: "code-brain/guidelines/preflight.sh"
  - reason: "Verificar comandos expostos"
  - path: "code-brain/usecases/schema.yaml"
  - reason: "Conferir schema de validação"

commands_run:
  - cmd: "git status --porcelain"
  - summary: "Verificou mudanças não comitadas"
  - cmd: "git rev-parse --abbrev-ref HEAD"
  - summary: "Obtido branch atual"

repo_state:

  branch: "main"

 > Salvar como `code-brain/developer/logs-ai-code/<timestamp>-ia-code.md`

## 1. Contexto consumido

  Uma lista estruturada com tudo que a IA (ou o autor) "consumiu" para produzir a alteração.
  Preencha esta seção com entradas claras e objetivas — ela é usada para auditoria, revisão humana e para facilitar reprodução.

### Exemplo (bloco YAML ou lista):

```yaml
  docs_read:
    - path: "code-brain/guidelines/preflight.md"
      - summary: "Descrição das validações de branch e commit"
    - path: "code-brain/usecases/template.md"
      - summary: "Template padrão para use cases"

  files_opened:
    - path: "code-brain/guidelines/preflight.sh"
        - reason: "Verificar comandos expostos"
	  - path: "code-brain/usecases/schema.yaml"
	    reason: "Conferir schema de validação"

	commands_run:
	  - cmd: "git status --porcelain"
	    summary: "Verificou mudanças não comitadas"
	  - cmd: "git rev-parse --abbrev-ref HEAD"
	    summary: "Obtido branch atual"

	repo_state:
	  branch: "main"
	  commit: "<short-sha>"
	  uncommitted_changes: false
	  last_push: "2025-11-08T12:34:56Z"

	user_inputs:
	  - prompt: "Solicitado: criar template de use cases"
	    params: "nenhum"
# IA Change Template

> Salvar como `code-brain/developer/logs-ai-code/<timestamp>-ia-code.md`

## 1. Contexto consumido

Uma lista estruturada com tudo que a IA (ou o autor) "consumiu" para produzir a alteração.
Preencha esta seção com entradas claras e objetivas — ela é usada para auditoria, revisão humana e para facilitar reprodução.

Exemplo (bloco YAML ou lista):

```yaml
docs_read:
  - path: "code-brain/guidelines/preflight.md"
    summary: "Descrição das validações de branch e commit"
  - path: "code-brain/usecases/template.md"
    summary: "Template padrão para use cases"

files_opened:
  - path: "code-brain/guidelines/preflight.sh"
    reason: "Verificar comandos expostos"
  - path: "code-brain/usecases/schema.yaml"
    reason: "Conferir schema de validação"

commands_run:
  - cmd: "git status --porcelain"
    summary: "Verificou mudanças não comitadas"
  - cmd: "git rev-parse --abbrev-ref HEAD"
    summary: "Obtido branch atual"

repo_state:
  branch: "main"
  commit: "<short-sha>"
  uncommitted_changes: false
  last_push: "2025-11-08T12:34:56Z"

user_inputs:
  - prompt: "Solicitado: criar template de use cases"
    params: "nenhum"
# IA Change Template

> Salvar como `code-brain/developer/logs-ai-code/<timestamp>-ia-code.md`

## 1. Contexto consumido

Uma lista estruturada com tudo que a IA (ou o autor) "consumiu" para produzir a alteração.
Preencha esta seção com entradas claras e objetivas — ela é usada para auditoria, revisão humana e para facilitar reprodução.

Exemplo (bloco YAML ou lista):

```yaml
docs_read:
  - path: "code-brain/guidelines/preflight.md"
    summary: "Descrição das validações de branch e commit"
  - path: "code-brain/usecases/template.md"
    summary: "Template padrão para use cases"

files_opened:
  - path: "code-brain/guidelines/preflight.sh"
    reason: "Verificar comandos expostos"
  - path: "code-brain/usecases/schema.yaml"
    reason: "Conferir schema de validação"

commands_run:
  - cmd: "git status --porcelain"
    summary: "Verificou mudanças não comitadas"
  - cmd: "git rev-parse --abbrev-ref HEAD"
    summary: "Obtido branch atual"

repo_state:
  branch: "main"
  commit: "<short-sha>"
  uncommitted_changes: false
  last_push: "2025-11-08T12:34:56Z"

user_inputs:
  - prompt: "Solicitado: criar template de use cases"
    params: "nenhum"

external_resources:
  - url: "https://specs.example/doc"
    summary: "Referência externa consultada para política X"

assumptions:
  - "Assumi que a convenção de branch é 'feature/UC-XXX/TYYY'"
  - "Não havia alterações locais não comitadas relevantes"

notes: |
  Observações livres sobre contexto não coberto pelos itens acima.
````

Preenchimento mínimo recomendado:

* ao menos 1 `docs_read` com path + summary
* `repo_state.branch` e `repo_state.commit`
* listar quaisquer comandos importantes executados

## 2. Objetivo da alteração

* resumo (1 linha):
* escopo (inclui/exclui):

## Prompt context

Registre aqui o prompt usado para gerar o código/alteração. Isso facilita auditoria, reprodução e depuração das decisões da IA.

Exemplo (bloco YAML):

```yaml
prompt_context:
  system_instructions: "You are a precise assistant that writes production-ready code. Avoid hallucinations; cite files and refs. Do not execute commands."
  user_prompt: "Gerar template de contexto para IA codebuilders no repositório code-brain"
  clarification_questions:
    - "Deseja exemplos curtos ou completos?"
  prompt_parameters:
    temperature: 0.0
    top_p: 1.0
    max_tokens: 800
  persona: "code-brain assistant"
  constraints:
    - "Não executar comandos"
    - "Não incluir dados sensíveis"
    - "Preferir referências internas ao repositório"
  examples_provided:
    - input: "exemplo mínimo"
      expected_output: "TEMPLATE mínimo preenchido"
  expected_output_format: "markdown: sections (actions, files_changed, notes)"
```

Recomendação mínima: inclua `system_instructions`, `user_prompt` e `prompt_parameters.temperature`.

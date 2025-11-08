# Guia de Preflight para Agentes de IA — Code-Brain

## Visão Geral

Este guia é específico para agentes de IA que interagem com o repositório Code-Brain, focando em como utilizar o sistema de preflight checks de forma eficiente e automatizada.

## Modo de Operação IA

### Características Específicas

1. Nível de validação: `strict`
2. Auto-correção: `enabled`
3. Logging: `verbose`
4. Bloqueio: `all_errors`

### Fluxo de Validação

```yaml
validation_flow:
  pre_action:
    - load_context
    - check_permissions
    - validate_requirements
    
  during_action:
    - monitor_changes
    - apply_guidelines
    - track_metrics
    
  post_action:
    - validate_results
    - generate_report
    - update_logs
```

## Integração com Guidelines

### 1. Carregamento de Contexto

```yaml
# Carregar contexto relevante
load_context:
  module: git
  action: commit
  guidelines:
    - workflow
    - conventions
    - requirements
```

### 2. Validação de Ações

```yaml
# Validar ação pretendida
validate_action:
  type: commit
  requirements:
    - branch_name
    - commit_message
    - file_changes
  guidelines: strict
```

### 3. Execução de Ações

```yaml
# Executar ação com preflight
execute_action:
  pre_checks: true
  auto_fix: true
  validation: strict
  logging: verbose
```

## Exemplos Práticos

### 1. Commit com Preflight

```python
def prepare_commit():
    # 1. Carregar contexto
    context = load_guidelines_context('git/commit')
    
    # 2. Validar alterações
    validation = validate_changes(context)
    if not validation.success:
        apply_auto_fixes(validation.errors)
    
    # 3. Executar commit
    if validation.success:
        execute_git_commit(context)
```

### 2. Push com Preflight

```python
def prepare_push():
    # 1. Validar branch
    branch_check = validate_branch_state()
    
    # 2. Verificar CI
    ci_check = validate_ci_status()
    
    # 3. Push se tudo ok
    if branch_check and ci_check:
        execute_git_push()
```

### 3. PR com Preflight

```python
def prepare_pr():
    # 1. Validar requisitos
    requirements = validate_pr_requirements()
    
    # 2. Gerar PR
    if requirements.met:
        create_pull_request()
    else:
        request_human_review()
```

## Sistema de Auto-correção

### Correções Automáticas

```yaml
auto_fixes:
  branch_name:
    pattern: "^feature/UC-\\d{3}/T\\d{3}$"
    fix: rename_branch
    
  commit_message:
    pattern: "^(feat|fix|docs)\\(.+\\): .+$"
    fix: reword_commit
    
  code_style:
    tool: prettier
    fix: format_code
```

### Processo de Correção

1. Detectar problema
2. Identificar correção
3. Aplicar fix
4. Validar resultado
5. Registrar ação

## Logs e Métricas

### Formato de Log

```yaml
log_entry:
  timestamp: ISO8601
  agent_id: string
  action: string
  validation:
    success: boolean
    errors: array
    fixes_applied: array
  metrics:
    duration: number
    attempts: number
```

### Métricas Importantes

1. Taxa de sucesso de auto-correção
2. Tempo médio de validação
3. Erros mais comuns
4. Uso de guidelines

## Troubleshooting para IAs

### 1. Falha de Validação

```yaml
on_validation_failure:
  steps:
    - log_error_details
    - attempt_auto_fix
    - if_failed: request_human_review
```

### 2. Conflitos

```yaml
on_conflict:
  steps:
    - analyze_conflict
    - suggest_resolution
    - if_complex: escalate_to_human
```

### 3. CI Falhas

```yaml
on_ci_failure:
  steps:
    - analyze_logs
    - identify_cause
    - suggest_fixes
```

## Boas Práticas

### 1. Validação Progressiva

- Comece com validações básicas
- Progrida para checks mais complexos
- Mantenha registro de cada etapa

### 2. Auto-correção Segura

- Aplique fixes em etapas
- Valide após cada correção
- Mantenha backup do estado original

### 3. Logging Eficiente

- Registre contexto completo
- Inclua tentativas de correção
- Documente decisões tomadas

## Referências

### APIs e Endpoints

```yaml
api_endpoints:
  validate: /api/preflight/validate
  auto_fix: /api/preflight/fix
  report: /api/preflight/report
```

### Documentação Relacionada

1. [Guidelines Principais](../guidelines.md)
2. [API Reference](../api-reference.md)
3. [Métricas](../metrics.md)

## Checklist de Implementação

### Pre-execution
- [ ] Carregar contexto
- [ ] Validar permissões
- [ ] Verificar dependências

### Execution
- [ ] Aplicar guidelines
- [ ] Monitorar alterações
- [ ] Registrar métricas

### Post-execution
- [ ] Validar resultado
- [ ] Gerar relatório
- [ ] Atualizar logs
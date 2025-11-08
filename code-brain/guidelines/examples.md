# Exemplos de Uso das Guidelines — Code-Brain

Este documento contém exemplos práticos de como as IAs devem usar as guidelines em diferentes cenários.

## 1. Iniciar Nova Feature

### Contexto
- Use case: UC-001 (Login)
- Task: T001 (Implementar autenticação)
- Branch: feature/UC-001/T001

### Código

```yaml
# 1. Carregar contexto
load_context:
  action: git.feature.start
  usecase: UC-001
  task: T001

# 2. Validar requisitos
validate:
  guidelines:
    - git/workflow-template.md
    - git/commit-convention.md
  context: feature_creation

# 3. Executar ações
execute:
  - create_branch:
      name: feature/UC-001/T001
      base: develop
  - setup_tracking:
      remote: origin
      branch: feature/UC-001/T001
```

## 2. Criar Pull Request

### Contexto
- Branch: feature/UC-001/T001
- Commits: 3 commits de feature
- Status: Pronto para revisão

### Código

```yaml
# 1. Carregar contexto PR
load_context:
  action: git.pr.create
  branch: feature/UC-001/T001

# 2. Validar estado
validate:
  guidelines:
    - git/pr-template.md
    - git/guidelines.md#pr_rules
  checks:
    - branch_status
    - commit_messages
    - ci_status

# 3. Criar PR
execute:
  create_pr:
    title: "[UC-001] Implementa autenticação de usuário"
    template: pr-template.md
    reviewers: required
```

## 3. Code Review

### Contexto
- PR: #123
- Branch: feature/UC-001/T001
- Status: Em revisão

### Código

```yaml
# 1. Carregar contexto review
load_context:
  action: git.pr.review
  pr: 123

# 2. Validar guidelines
validate:
  guidelines:
    - git/guidelines.md#review_rules
  aspects:
    - code_quality
    - test_coverage
    - documentation

# 3. Executar review
execute:
  review:
    type: code_review
    checks:
      - conventions
      - tests
      - docs
    blocking: true
```

## 4. Merge de PR

### Contexto
- PR: #123
- Status: Aprovado
- Destino: develop

### Código

```yaml
# 1. Carregar contexto merge
load_context:
  action: git.merge.execute
  pr: 123

# 2. Validar requisitos
validate:
  guidelines:
    - git/guidelines.md#merge_rules
  requirements:
    - approvals_count
    - ci_status
    - conflicts

# 3. Executar merge
execute:
  merge:
    method: squash
    title: "feat(auth): implementa autenticação de usuário (#123)"
    cleanup: true
```

## Notas Importantes

1. Sempre valide o contexto antes de executar ações
2. Use os templates fornecidos em `git/`
3. Siga estritamente as convenções de nomenclatura
4. Registre todas as ações no log
5. Aguarde validação humana quando requerido

## Tratamento de Erros

```yaml
# Exemplo de tratamento de erro
on_error:
  branch_name_invalid:
    - show_pattern: "feature/UC-XXX/task-description"
    - suggest_fix: "Renomear branch para seguir padrão"
    - block_action: true

  commit_message_invalid:
    - show_convention: "type(scope): message"
    - suggest_fix: "Reescrever mensagem do commit"
    - allow_retry: true
```
# Exemplos e Workflows do Preflight — Code-Brain

Este documento contém exemplos práticos e workflows comuns para uso do sistema de preflight checks.

## Workflows Comuns

### 1. Desenvolvimento de Feature

#### Fluxo Completo

```bash
# 1. Preparar ambiente
git checkout develop
git pull origin develop
./preflight.sh branch feature/UC-001/T001

# 2. Desenvolver
git add .
./preflight.sh commit "feat(auth): implementa login"
git commit -m "feat(auth): implementa login"

# 3. Validar
./preflight.sh test
./preflight.sh lint

# 4. Push e PR
./preflight.sh push
git push origin feature/UC-001/T001
./preflight.sh pr
```

#### Logs Esperados

```yaml
# preflight.log
steps:
  - action: branch_creation
    status: success
    validation:
      - branch_name: passed
      - base_branch: passed

  - action: commit
    status: success
    validation:
      - message_format: passed
      - files_staged: passed

  - action: tests
    status: success
    metrics:
      coverage: 85%
      passing: 42/42

  - action: push
    status: success
    validation:
      - remote_sync: passed
      - ci_status: passed
```

### 2. Correção de Bug

#### Fluxo Rápido

```bash
# 1. Branch de bugfix
./preflight.sh branch feature/UC-002/T002

# 2. Correção
git add .
./preflight.sh commit "fix(auth): corrige validação"
git commit -m "fix(auth): corrige validação"

# 3. Validação
./preflight.sh test --focus auth
./preflight.sh push
```

#### Validações Críticas

```yaml
validations:
  - regression_tests: required
  - coverage_maintained: required
  - bug_documented: required
```

### 3. Atualização de Docs

#### Fluxo Simples

```bash
# 1. Branch de docs
./preflight.sh branch feature/UC-003/T003

# 2. Atualizar
git add .
./preflight.sh commit "docs(readme): atualiza guia"
git commit -m "docs(readme): atualiza guia"

# 3. Validar links e formato
./preflight.sh validate-docs
```

## Cenários Especiais

### 1. Merge Conflicts

```bash
# 1. Detectar conflitos
./preflight.sh check-conflicts

# 2. Resolver
git merge develop
# resolver conflitos
git add .

# 3. Validar resolução
./preflight.sh validate-merge
```

### 2. Rebase Interativo

```bash
# 1. Preparar rebase
./preflight.sh pre-rebase

# 2. Executar
git rebase -i develop

# 3. Validar resultado
./preflight.sh post-rebase
```

### 3. Release

```bash
# 1. Preparar release
./preflight.sh prepare-release v1.0.0

# 2. Validar
./preflight.sh validate-release

# 3. Publicar
./preflight.sh publish-release
```

## Exemplos de Auto-correção

### 1. Branch Name

```yaml
# Erro
branch: feature-login

# Auto-correção
fix_branch:
  from: feature-login
  to: feature/UC-001/T001
  reason: "Padrão: feature/UC-XXX/TXXX"
```

### 2. Commit Message

```yaml
# Erro
message: "adiciona login"

# Auto-correção
fix_commit:
  from: "adiciona login"
  to: "feat(auth): adiciona login"
  reason: "Padrão: type(scope): message"
```

### 3. Code Style

```yaml
# Erro
style:
  indent: spaces
  size: 2

# Auto-correção
fix_style:
  tool: prettier
  config: .prettierrc
  files: ["src/**/*.ts"]
```

## Scripts Úteis

### 1. Validação Completa

```bash
#!/bin/bash
# validate-all.sh

# 1. Checar branch
./preflight.sh branch

# 2. Validar código
./preflight.sh lint
./preflight.sh test

# 3. Verificar docs
./preflight.sh validate-docs

# 4. Gerar relatório
./preflight.sh report
```

### 2. Preparação de PR

```bash
#!/bin/bash
# prepare-pr.sh

# 1. Atualizar branch
git checkout develop
git pull
git checkout -
git rebase develop

# 2. Validar
./preflight.sh validate-all

# 3. Criar PR
./preflight.sh create-pr
```

### 3. Limpeza

```bash
#!/bin/bash
# cleanup.sh

# 1. Remover branches mergeadas
./preflight.sh clean-branches

# 2. Limpar cache
./preflight.sh clean-cache

# 3. Atualizar logs
./preflight.sh rotate-logs
```

## Métricas e Reports

### 1. Relatório de Uso

```yaml
# usage-report.yaml
metrics:
  preflight_runs: 128
  success_rate: 94%
  common_errors:
    - branch_name: 45%
    - commit_message: 30%
    - test_coverage: 25%
```

### 2. Tendências

```yaml
# trends.yaml
weekly_stats:
  preflight_success:
    week1: 85%
    week2: 90%
    week3: 94%
  auto_fixes:
    week1: 35
    week2: 28
    week3: 20
```

### 3. Performance

```yaml
# performance.yaml
timing:
  average_validation: 2.3s
  average_auto_fix: 1.1s
  total_saved_time: 128h
```

## Dicas e Truques

### 1. Aliases Úteis

```bash
# .gitconfig
[alias]
  pf = !./preflight.sh
  pfc = !./preflight.sh commit
  pfp = !./preflight.sh push
  pfv = !./preflight.sh validate-all
```

### 2. VS Code Snippets

```json
{
  "Preflight Commit": {
    "prefix": "pfc",
    "body": [
      "./preflight.sh commit \"${1:type}(${2:scope}): ${3:message}\""
    ]
  }
}
```

### 3. CI Integration

```yaml
# .github/workflows/preflight.yml
name: Preflight CI

on: [push, pull_request]

jobs:
  validate:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Run Preflight
        run: |
          ./preflight.sh validate-all
          ./preflight.sh report
```
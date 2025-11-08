# Guia Avançado de Troubleshooting — Preflight

## Índice

1. [Problemas Comuns](#problemas-comuns)
2. [Casos Especiais](#casos-especiais)
3. [Recuperação e Emergência](#recuperação-e-emergência)
4. [Manutenção e Logs](#manutenção-e-logs)

## Problemas Comuns

### 1. Validação de Branch

#### Erro 1: Branch Inválida

```txt
❌ Branch 'feature/login' não segue convenção
```

#### Como Diagnosticar

1. Verificar formato atual:

```bash
git branch --show-current
```

2. Comparar com padrão:

```txt
feature/UC-XXX/TXXX
```

#### Como Resolver

1. Renomear branch:

```bash
# Local apenas
git branch -m feature/UC-001/T001

# Com remote
git push origin :feature/login
git push -u origin feature/UC-001/T001
```

2. Usar helper:

```bash
./preflight.sh fix-branch
```

### 2. Commits Inválidos

#### Erro 2: Convenção de Commits

```txt
❌ Últimos 3 commits não seguem convenção
```

#### Como Diagnosticar

1. Listar commits:

```bash
git log --oneline -n 3
```

2. Validar formato:

```bash
./preflight.sh validate-commits
```

#### Como Resolver

1. Reescrever último commit:

```bash
git commit --amend -m "feat(auth): implementa login"
```

2. Rebase interativo:

```bash
git rebase -i HEAD~3
# Marcar commits com 'reword'
```

### 3. Falhas de CI

#### Erro 3: Testes Falhando

```txt
❌ CI falhou: test_auth failed
```

#### Como Diagnosticar

1. Verificar logs:

```bash
./preflight.sh show-ci-logs
```

2. Rodar localmente:

```bash
npm test -- --filter=auth
```

#### Como Resolver

1. Corrigir testes:

```bash
# Atualizar teste
./preflight.sh update-test auth

# Verificar cobertura
./preflight.sh check-coverage
```

2. Skip temporário (requer aprovação):

```bash
./preflight.sh skip-ci --reason="Bug conhecido #123"
```

## Casos Especiais

### 1. Conflitos Complexos

#### Erro 4: Conflitos Múltiplos

```txt
❌ Conflitos em múltiplos arquivos core
```

#### Etapas de Análise

1. Mapear conflitos:

```bash
./preflight.sh map-conflicts
```

1. Verificar impacto:

```bash
./preflight.sh impact-analysis
```

#### Passos para Resolução

1. Backup do estado atual:

```bash
./preflight.sh backup-branch
```

1. Resolver por área:

```bash
# Por módulo
./preflight.sh resolve-conflicts auth
./preflight.sh resolve-conflicts user

# Validar cada resolução
./preflight.sh validate-resolution auth
```

### 2. Regressões

#### Erro 5: Falha de Regressão

```txt
❌ Testes de regressão falhando após merge
```

#### Etapas de Debug

1. Identificar commits problemáticos:

```bash
./preflight.sh bisect-regression
```

1. Comparar métricas:

```bash
./preflight.sh compare-metrics HEAD HEAD~5
```

#### Passos de Correção

1. Reverter alterações:

```bash
./preflight.sh smart-revert
```

1. Aplicar correção:

```bash
./preflight.sh apply-hotfix
```

### 3. Performance

#### Erro 6: Lentidão

```txt
⚠️ Preflight demorando >30s
```

#### Etapas de Profiling

1. Profiling:

```bash
./preflight.sh profile-run
```

1. Análise de logs:

```bash
./preflight.sh analyze-performance
```

#### Passos de Otimização

1. Limpar cache:

```bash
./preflight.sh clean-cache
```

1. Otimizar validações:

```bash
./preflight.sh optimize-checks
```

## Recuperação e Emergência

### 1. Backup e Restauração

```bash
# Backup automático
./preflight.sh backup-state

# Restore seletivo
./preflight.sh restore-state --module=auth
```

### Operação 2: Modo Emergencial

```bash
# Ativar modo emergência
./preflight.sh emergency-mode

# Permitir commits críticos
./preflight.sh force-commit --critical
```

### Operação 3: Reset de Estado

```bash
# Reset completo
./preflight.sh reset-state

# Reconstruir índices
./preflight.sh rebuild-indexes
```

## Manutenção e Logs

### Rotina 1: Gestão de Logs

```bash
# Rotacionar logs
./preflight.sh rotate-logs

# Compactar antigos
./preflight.sh compress-logs
```

### Rotina 2: Otimização

```bash
# Otimizar DB
./preflight.sh optimize-db

# Limpar caches
./preflight.sh clean-all-caches
```

### Rotina 3: Updates

```bash
# Update preflight
./preflight.sh self-update

# Update rules
./preflight.sh update-rules
```

## Ferramentas de Diagnóstico

### Script: Verificação Completa

```bash
#!/bin/bash
# diagnose-all.sh

echo "🔍 Iniciando diagnóstico completo..."

# 1. Verificar ambiente
./preflight.sh check-env

# 2. Validar configuração
./preflight.sh validate-config

# 3. Testar integrações
./preflight.sh test-integrations

# 4. Verificar performance
./preflight.sh check-performance

# 5. Gerar relatório
./preflight.sh generate-report
```

### Script: Auto-correção

```bash
#!/bin/bash
# auto-fix.sh

echo "🔧 Iniciando auto-correção..."

# 1. Backup
./preflight.sh backup-state

# 2. Análise
./preflight.sh analyze-issues

# 3. Correções
./preflight.sh apply-fixes

# 4. Validação
./preflight.sh validate-fixes

# 5. Relatório
./preflight.sh fix-report
```

## Métricas e Limites

```yaml
# health-metrics.yaml
checks:
  performance:
    avg_runtime: <5s
    max_runtime: <30s
    
  reliability:
    success_rate: >95%
    auto_fix_rate: >80%
    
  maintenance:
    log_size: <100MB
    cache_size: <1GB
    
  integrations:
    ci_success: >90%
    api_uptime: >99%
```

## Protocolos de Crise

### Protocolo 1: Ativação do Bypass

```bash
# Ativar bypass
export PREFLIGHT_EMERGENCY=1
./preflight.sh bypass-enable

# Registrar motivo
./preflight.sh log-bypass "Emergência: Deploy crítico"
```

### Protocolo 2: Rollback Imediato

```bash
# Reverter última ação
./preflight.sh rollback-last

# Reverter para estado conhecido
./preflight.sh rollback-to HASH
```

### Protocolo 3: Restauração

```bash
# Restaurar configuração
./preflight.sh restore-config

# Restaurar regras
./preflight.sh restore-rules

```
```

## Recuperação de Erros

### 1. Backup e Restore

```bash
# Backup automático
./preflight.sh backup-state

# Restore seletivo
./preflight.sh restore-state --module=auth
```

### 2. Modo de Emergência

```bash
# Ativar modo emergência
./preflight.sh emergency-mode

# Permitir commits críticos
./preflight.sh force-commit --critical
```

### 3. Limpeza de Estado

```bash
# Reset completo
./preflight.sh reset-state

# Reconstruir índices
./preflight.sh rebuild-indexes
```

## Manutenção

### 1. Logs Rotativos

```bash
# Rotacionar logs
./preflight.sh rotate-logs

# Compactar antigos
./preflight.sh compress-logs
```

### 2. Otimização Periódica

```bash
# Otimizar DB
./preflight.sh optimize-db

# Limpar caches
./preflight.sh clean-all-caches
```

### 3. Atualizações

```bash
# Update preflight
./preflight.sh self-update

# Update rules
./preflight.sh update-rules
```

## Scripts de Diagnóstico

### 1. Verificação Completa

```bash
#!/bin/bash
# diagnose-all.sh

echo "🔍 Iniciando diagnóstico completo..."

# 1. Verificar ambiente
./preflight.sh check-env

# 2. Validar configuração
./preflight.sh validate-config

# 3. Testar integrações
./preflight.sh test-integrations

# 4. Verificar performance
./preflight.sh check-performance

# 5. Gerar relatório
./preflight.sh generate-report
```

### 2. Auto-correção

```bash
#!/bin/bash
# auto-fix.sh

echo "🔧 Iniciando auto-correção..."

# 1. Backup
./preflight.sh backup-state

# 2. Análise
./preflight.sh analyze-issues

# 3. Correções
./preflight.sh apply-fixes

# 4. Validação
./preflight.sh validate-fixes

# 5. Relatório
./preflight.sh fix-report
```

## Métricas de Saúde

```yaml
# health-metrics.yaml
checks:
  performance:
    avg_runtime: <5s
    max_runtime: <30s
    
  reliability:
    success_rate: >95%
    auto_fix_rate: >80%
    
  maintenance:
    log_size: <100MB
    cache_size: <1GB
    
  integrations:
    ci_success: >90%
    api_uptime: >99%
```

## Procedimentos de Emergência

### 1. Modo de Bypass

```bash
# Ativar bypass
export PREFLIGHT_EMERGENCY=1
./preflight.sh bypass-enable

# Registrar motivo
./preflight.sh log-bypass "Emergência: Deploy crítico"
```

### 2. Rollback

```bash
# Reverter última ação
./preflight.sh rollback-last

# Reverter para estado conhecido
./preflight.sh rollback-to HASH
```

### 3. Restauração

```bash
# Restaurar configuração
./preflight.sh restore-config

# Restaurar regras
./preflight.sh restore-rules
```
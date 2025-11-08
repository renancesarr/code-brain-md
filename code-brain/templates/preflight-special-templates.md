# Templates Especiais — Preflight

## Rollback de Emergência

### Template: emergency-rollback.yaml

```yaml
# emergency-rollback.yaml
emergency:
  type: rollback
  reason: "Descreva o motivo do rollback"
  severity: critical  # critical, high, medium, low
  
  target:
    branch: main
    commit: "SHA do commit alvo"
    environment: production
    
  validation:
    skip_checks: true
    notify_team: true
    require_approval: true
    
  steps:
    pre_rollback:
      - backup_state
      - notify_stakeholders
      - pause_deployments
      
    rollback:
      - revert_code
      - revert_db
      - revert_config
      
    post_rollback:
      - verify_health
      - restore_deployments
      - send_report

  notifications:
    slack: "#incidents"
    email: "team@company.com"
    pagerduty: true
    
  audit:
    log_level: debug
    retain_logs: 30d
    metrics: true
```

### Script: emergency-rollback.sh

```bash
#!/bin/bash
# emergency-rollback.sh

echo "🚨 Iniciando rollback de emergência..."

# 1. Validar parâmetros
if [ -z "$ROLLBACK_COMMIT" ]; then
    echo "❌ ROLLBACK_COMMIT é obrigatório"
    exit 1
fi

# 2. Carregar configuração
config=$(cat emergency-rollback.yaml)

# 3. Notificar time
./preflight.sh notify-emergency \
    --type="rollback" \
    --severity="critical"

# 4. Backup do estado atual
./preflight.sh backup-state \
    --full \
    --compress

# 5. Pausar deployments
./preflight.sh pause-deployments \
    --reason="emergency-rollback"

# 6. Executar rollback
./preflight.sh rollback \
    --commit="$ROLLBACK_COMMIT" \
    --force \
    --skip-validation

# 7. Verificar saúde
./preflight.sh health-check \
    --comprehensive

# 8. Gerar relatório
./preflight.sh generate-report \
    --type="emergency" \
    --include-metrics
```

## Bypass de Validação

### Template: validation-bypass.yaml

```yaml
# validation-bypass.yaml
bypass:
  type: validation
  reason: "Descreva o motivo do bypass"
  expiration: 2h  # Tempo máximo do bypass
  
  scope:
    rules:
      - branch_naming
      - commit_convention
      - test_coverage
    environments:
      - development
      - staging
    
  requirements:
    min_approvals: 2
    senior_approval: true
    ticket_required: true
    
  monitoring:
    enhanced_logging: true
    alert_threshold: high
    metrics_collection: true
    
  restoration:
    auto_expire: true
    notify_expiration: true
    grace_period: 15m
    
  documentation:
    ticket: "TICKET-123"
    pr_link: "github.com/org/repo/pull/123"
    risks: "Lista de riscos identificados"
```

### Script: validation-bypass.sh

```bash
#!/bin/bash
# validation-bypass.sh

echo "⚠️ Ativando bypass de validação..."

# 1. Validar autorização
./preflight.sh check-auth \
    --level=senior \
    --action=bypass

# 2. Registrar bypass
./preflight.sh register-bypass \
    --type="validation" \
    --duration="2h"

# 3. Configurar monitoramento
./preflight.sh setup-monitoring \
    --enhanced=true \
    --alert-level=high

# 4. Aplicar bypass
./preflight.sh apply-bypass \
    --rules="$BYPASS_RULES" \
    --environments="$BYPASS_ENVS"

# 5. Agendar expiração
./preflight.sh schedule-expiration \
    --time="2h" \
    --action="restore-validation"
```

## Modo de Manutenção

### Template: maintenance-mode.yaml

```yaml
# maintenance-mode.yaml
maintenance:
  type: scheduled  # scheduled, emergency
  reason: "Descreva o motivo da manutenção"
  duration: 2h
  
  schedule:
    start: "2025-11-08T22:00:00Z"
    end: "2025-11-09T00:00:00Z"
    timezone: "UTC"
    
  impact:
    services:
      - validation
      - automation
      - monitoring
    severity: medium
    
  communication:
    announce_before: 24h
    remind_at: [12h, 6h, 1h]
    channels:
      - slack: "#engineering"
      - email: "team@company.com"
      - status_page: true
      
  procedures:
    pre_maintenance:
      - backup_system
      - notify_users
      - scale_down_services
      
    during_maintenance:
      - update_systems
      - run_migrations
      - verify_changes
      
    post_maintenance:
      - restore_services
      - verify_health
      - notify_completion

  rollback:
    plan: "Detalhes do plano de rollback"
    timeframe: 30m
    automatic: false
```

### Script: maintenance-mode.sh

```bash
#!/bin/bash
# maintenance-mode.sh

echo "🔧 Ativando modo de manutenção..."

# 1. Validar agendamento
./preflight.sh validate-maintenance \
    --schedule="$MAINT_SCHEDULE" \
    --duration="$MAINT_DURATION"

# 2. Notificar usuários
./preflight.sh announce-maintenance \
    --time="$MAINT_SCHEDULE" \
    --services="$MAINT_SERVICES"

# 3. Preparar sistema
./preflight.sh prepare-maintenance \
    --backup=true \
    --scale-down=true

# 4. Ativar modo manutenção
./preflight.sh enable-maintenance \
    --message="$MAINT_MESSAGE" \
    --duration="$MAINT_DURATION"

# 5. Monitorar progresso
./preflight.sh monitor-maintenance \
    --alert-on-timeout \
    --status-updates
```

## Scripts Auxiliares

### 1. Validação de Templates

```bash
#!/bin/bash
# validate-templates.sh

echo "✅ Validando templates..."

# Validar sintaxe YAML
for template in *.yaml; do
    ./preflight.sh validate-yaml "$template"
done

# Validar regras de negócio
./preflight.sh validate-business-rules \
    --templates="*.yaml"

# Verificar permissões
./preflight.sh check-permissions \
    --templates="*.yaml"
```

### 2. Atualização de Templates

```bash
#!/bin/bash
# update-templates.sh

echo "🔄 Atualizando templates..."

# Backup dos templates atuais
./preflight.sh backup-templates \
    --compress \
    --timestamp

# Atualizar templates
./preflight.sh update-templates \
    --source="repository" \
    --validate=true

# Verificar compatibilidade
./preflight.sh check-compatibility \
    --templates="*.yaml"
```

### 3. Métricas de Uso

```bash
#!/bin/bash
# template-metrics.sh

echo "📊 Coletando métricas de uso..."

# Análise de uso
./preflight.sh analyze-usage \
    --period="30d" \
    --templates="*.yaml"

# Gerar relatório
./preflight.sh generate-metrics-report \
    --format="html" \
    --include-graphs
```

## Monitoramento de Templates

### 1. Dashboard de Status

```yaml
# template-dashboard.yaml
dashboard:
  refresh: 5m
  panels:
    - name: "Template Usage"
      type: graph
      metrics:
        - emergency_rollbacks
        - validation_bypasses
        - maintenance_windows
        
    - name: "Success Rate"
      type: gauge
      metrics:
        - rollback_success
        - bypass_effectiveness
        - maintenance_completion
        
    - name: "Active Templates"
      type: table
      columns:
        - template_type
        - activation_time
        - status
        - owner
```

### 2. Sistema de Alertas

```yaml
# template-alerts.yaml
alerts:
  high_usage:
    condition: emergency_rollbacks > 3
    period: 24h
    severity: high
    
  long_bypass:
    condition: bypass_duration > 4h
    severity: warning
    
  failed_maintenance:
    condition: maintenance_success < 90%
    period: 7d
    severity: critical
```

### 3. Relatórios Periódicos

```yaml
# template-reports.yaml
reports:
  schedule: daily
  formats:
    - pdf
    - html
    - json
    
  sections:
    usage:
      - template_frequency
      - success_rates
      - duration_stats
      
    performance:
      - execution_time
      - resource_usage
      - error_rates
      
    trends:
      - usage_patterns
      - common_issues
      - improvement_suggestions
```
# Troubleshooting Avançado — Preflight

## Cenários Avançados de Erro

### 1. Race Conditions em Validações Paralelas

#### Sintoma
```txt
❌ Validação inconsistente: estado final != esperado
```

#### Diagnóstico

1. Verificar logs de timing:

```bash
./preflight.sh timing-analysis
```

2. Identificar operações concorrentes:

```bash
./preflight.sh list-concurrent-ops
```

#### Resolução

1. Forçar serialização:

```bash
./preflight.sh force-serial-validation
```

2. Implementar locks:

```bash
./preflight.sh implement-locks --scope=global
```

### 2. Corrupção de Cache

#### Sintoma
```txt
❌ Cache checksum mismatch: expected=abc123 actual=def456
```

#### Diagnóstico

1. Validar integridade:

```bash
./preflight.sh verify-cache-integrity
```

2. Analisar histórico:

```bash
./preflight.sh cache-history --last=24h
```

#### Resolução

1. Limpar cache corrompido:

```bash
./preflight.sh clean-corrupt-cache
```

2. Reconstruir índices:

```bash
./preflight.sh rebuild-cache-indexes
```

### 3. Deadlocks em Hooks

#### Sintoma
```txt
❌ Hook timeout after 30s: pre-commit → prepare-commit-msg
```

#### Diagnóstico

1. Analisar dependências:

```bash
./preflight.sh analyze-hook-deps
```

2. Verificar estado:

```bash
./preflight.sh check-hook-state
```

#### Resolução

1. Quebrar deadlock:

```bash
./preflight.sh break-hook-deadlock
```

2. Otimizar ordem:

```bash
./preflight.sh optimize-hook-order
```

## Métricas de Performance

### 1. Métricas Base

```yaml
baseline_metrics:
  validation_time: 
    p50: <500ms
    p95: <1s
    p99: <2s
  
  memory_usage:
    idle: <50MB
    peak: <200MB
    
  file_operations:
    reads_per_sec: <1000
    writes_per_sec: <100
```

### 2. Métricas de Carga

```yaml
load_metrics:
  concurrent_validations:
    max: 20
    target: 10
    
  queue_depth:
    max: 100
    target: <50
    
  response_time:
    normal: <100ms
    heavy: <500ms
```

### 3. Métricas de Recursos

```yaml
resource_metrics:
  cpu_usage:
    idle: <5%
    normal: <20%
    peak: <50%
    
  disk_io:
    reads: <50MB/s
    writes: <10MB/s
    
  network:
    ingress: <1MB/s
    egress: <1MB/s
```

## Exemplos Práticos

### 1. Análise de Performance

```bash
#!/bin/bash
# performance-analysis.sh

echo "🔍 Analisando performance..."

# 1. Coletar métricas base
base_metrics=$(./preflight.sh collect-metrics --type=base)

# 2. Executar testes de carga
./preflight.sh run-load-test --duration=5m

# 3. Coletar métricas sob carga
load_metrics=$(./preflight.sh collect-metrics --type=load)

# 4. Comparar e analisar
./preflight.sh compare-metrics "$base_metrics" "$load_metrics"

# 5. Gerar relatório
./preflight.sh generate-perf-report
```

### 2. Debug de Race Condition

```bash
#!/bin/bash
# debug-race.sh

echo "🔄 Debugando race condition..."

# 1. Ativar logging detalhado
export PREFLIGHT_DEBUG=trace
export PREFLIGHT_TIMING=true

# 2. Reproduzir cenário
for i in {1..10}; do
  ./preflight.sh validate --parallel &
done

# 3. Coletar traces
./preflight.sh collect-traces --last=1m

# 4. Analisar timing
./preflight.sh analyze-timing-logs

# 5. Identificar padrões
./preflight.sh find-race-patterns
```

### 3. Investigação de Deadlock

```bash
#!/bin/bash
# investigate-deadlock.sh

echo "🔒 Investigando deadlock..."

# 1. Capturar estado atual
./preflight.sh snapshot-state

# 2. Listar locks ativos
./preflight.sh list-active-locks

# 3. Analisar grafo de dependências
./preflight.sh analyze-dep-graph

# 4. Identificar ciclos
./preflight.sh find-dep-cycles

# 5. Resolver deadlock
./preflight.sh resolve-deadlock --auto
```

## Guias de Otimização

### 1. Otimização de Validações

```yaml
# validation-optimizations.yaml
optimizations:
  parallel:
    max_workers: 4
    batch_size: 10
    
  caching:
    strategy: lru
    max_size: 100MB
    ttl: 1h
    
  io:
    buffer_size: 8KB
    read_ahead: true
    write_buffer: 1MB
```

### 2. Otimização de Hooks

```yaml
# hook-optimizations.yaml
hooks:
  pre-commit:
    timeout: 5s
    max_retries: 3
    
  prepare-commit-msg:
    timeout: 2s
    max_retries: 1
    
  commit-msg:
    timeout: 3s
    max_retries: 2
```

### 3. Otimização de Cache

```yaml
# cache-optimizations.yaml
cache:
  storage:
    type: memory+disk
    memory_limit: 100MB
    disk_limit: 1GB
    
  policy:
    eviction: lru
    compression: true
    dedup: true
    
  maintenance:
    gc_interval: 1h
    compact_threshold: 500MB
```

## Monitoramento Avançado

### 1. Dashboards

```yaml
# monitoring-dashboards.yaml
dashboards:
  performance:
    update_interval: 10s
    metrics:
      - validation_time
      - queue_depth
      - error_rate
      
  resources:
    update_interval: 30s
    metrics:
      - cpu_usage
      - memory_usage
      - disk_io
      
  errors:
    update_interval: 5s
    metrics:
      - error_count
      - error_types
      - resolution_time
```

### 2. Alertas

```yaml
# monitoring-alerts.yaml
alerts:
  high_load:
    condition: queue_depth > 100
    severity: warning
    
  error_spike:
    condition: error_rate > 10%
    severity: critical
    
  slow_validation:
    condition: validation_time_p95 > 2s
    severity: warning
```

### 3. Relatórios

```yaml
# monitoring-reports.yaml
reports:
  daily:
    metrics:
      - validation_success_rate
      - avg_response_time
      - total_errors
    format: html
    
  weekly:
    metrics:
      - performance_trends
      - error_patterns
      - resource_usage
    format: pdf
```
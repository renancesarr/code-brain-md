# Tasks de Use Cases

## Estrutura

```bash
tasks/
├── UC-001/                  # Tasks do UC-001
│   ├── task-UC-001.yaml    # Task principal
│   ├── task-UC-001-1.yaml  # Análise
│   ├── task-UC-001-2.yaml  # Implementação
│   ├── task-UC-001-3.yaml  # Testes
│   └── task-UC-001-4.yaml  # Documentação
└── UC-XXX/                  # Próximos UCs...
```

## Processo de Tasks

### 1. Criação

1. Criar pasta para o UC
2. Criar task principal
3. Quebrar em subtasks
4. Definir dependências

### 2. Organização

- Uma pasta por UC
- Task principal + subtasks
- Nomenclatura padronizada
- Links para o UC

### 3. Rastreabilidade

- Tasks linkadas ao UC
- Dependências claras
- Histórico de mudanças
- Métricas de progresso

## Schema

```yaml
# task-schema.yaml
definitions:
  task_type:
    type: string
    enum:
      - feature
      - analysis
      - implementation
      - testing
      - documentation
      
  priority:
    type: string
    enum:
      - low
      - medium
      - high
      - critical
      
  size:
    type: string
    enum:
      - xs
      - small
      - medium
      - large
      - xl

required:
  - metadata
  - description
  - acceptance_criteria

properties:
  metadata:
    type: object
    required:
      - id
      - related_usecase
      - type
      - priority
      - size
    properties:
      id:
        type: string
        pattern: ^task-UC-\d{3}(-\d+)?$
      related_usecase:
        type: string
        pattern: ^UC-\d{3}$
      type:
        $ref: "#/definitions/task_type"
      priority:
        $ref: "#/definitions/priority"
      size:
        $ref: "#/definitions/size"
      parent:
        type: string
        pattern: ^task-UC-\d{3}$
        
  description:
    type: string
    minLength: 10
    
  deliverables:
    type: array
    items:
      type: string
      
  components:
    type: array
    items:
      type: string
      
  acceptance_criteria:
    type: array
    items:
      type: string
    minItems: 1
    
  subtasks:
    type: array
    items:
      type: object
      required:
        - id
        - title
      properties:
        id:
          type: string
          pattern: ^task-UC-\d{3}-\d+$
        title:
          type: string
```

## Métricas

```yaml
# metrics.yaml
metrics:
  completion:
    formula: completed_tasks / total_tasks
    target: ">= 0.8"
    
  quality:
    formula: passed_criteria / total_criteria
    target: "= 1.0"
    
  velocity:
    formula: completed_points / sprint
    target: "> previous_average"
```

## Reports

### 1. Progress Report

```yaml
# progress-report.yaml
report:
  uc_id: "UC-001"
  total_tasks: 5
  completed: 3
  in_progress: 1
  blocked: 1
  
  completion_rate: 0.6
  quality_score: 0.95
  
  metrics:
    velocity: 8
    burndown: "on-track"
    blockers: 1
```

### 2. Quality Report

```yaml
# quality-report.yaml
report:
  uc_id: "UC-001"
  criteria_total: 15
  criteria_passed: 14
  
  test_coverage: 0.95
  code_quality: 0.92
  doc_coverage: 1.0
  
  issues:
    critical: 0
    major: 1
    minor: 3
```
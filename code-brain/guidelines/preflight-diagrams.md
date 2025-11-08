# Diagramas de Fluxo — Preflight Checks

Este documento contém diagramas de fluxo que ilustram os processos do sistema de preflight checks.

## Fluxo Geral do Preflight

```mermaid
graph TB
    A[Início] --> B{Tipo de Ação}
    B -->|Commit| C[Preflight Commit]
    B -->|Push| D[Preflight Push]
    B -->|PR| E[Preflight PR]
    B -->|Merge| F[Preflight Merge]
    
    C --> G{Validação}
    D --> G
    E --> G
    F --> G
    
    G -->|Sucesso| H[Executa Ação]
    G -->|Falha| I[Auto-correção]
    
    I -->|Corrigido| G
    I -->|Não corrigido| J[Bloqueia Ação]
    
    H --> K[Log & Métricas]
    J --> K
    
    K --> L[Fim]
```

## Processo de Commit

```mermaid
sequenceDiagram
    participant Dev
    participant Preflight
    participant Git
    participant CI
    
    Dev->>Preflight: Solicita commit
    Preflight->>Preflight: Valida branch
    Preflight->>Preflight: Valida mensagem
    Preflight->>Git: Verifica estado
    
    alt Validação OK
        Preflight->>Git: Executa commit
        Git->>CI: Trigger CI
        CI->>Preflight: Retorna status
    else Validação falha
        Preflight->>Dev: Retorna erro
        Dev->>Preflight: Corrige e retenta
    end
```

## Pipeline de Validação

```mermaid
graph LR
    A[Input] --> B[Load Context]
    B --> C[Check Rules]
    C --> D[Validate]
    D --> E{Status}
    
    E -->|OK| F[Execute]
    E -->|Error| G[Auto-fix]
    
    G --> H{Fixable?}
    H -->|Yes| C
    H -->|No| I[Block]
    
    F --> J[Log]
    I --> J
```

## Sistema de Auto-correção

```mermaid
stateDiagram-v2
    [*] --> Detectar
    Detectar --> Analisar
    
    state Analisar {
        [*] --> CheckRules
        CheckRules --> IdentifyFix
        IdentifyFix --> ValidateFix
    }
    
    Analisar --> Corrigir
    
    state Corrigir {
        [*] --> ApplyFix
        ApplyFix --> ValidateResult
        ValidateResult --> LogAction
    }
    
    Corrigir --> [*]
```

## Processo de PR

```mermaid
graph TB
    A[Iniciar PR] --> B{Branch OK?}
    B -->|Sim| C{Commits OK?}
    B -->|Não| D[Fix Branch]
    
    C -->|Sim| E{CI Status?}
    C -->|Não| F[Fix Commits]
    
    E -->|Pass| G[Create PR]
    E -->|Fail| H[Fix CI]
    
    D --> B
    F --> C
    H --> E
    
    G --> I{Human Review}
    I -->|Approved| J[Merge]
    I -->|Changes| K[Update]
    
    K --> B
```

## Fluxo de Logs e Métricas

```mermaid
graph LR
    A[Ação] --> B[Coletar Dados]
    B --> C[Processar]
    C --> D{Tipo}
    
    D -->|Error| E[Log Erro]
    D -->|Success| F[Log Sucesso]
    D -->|Warning| G[Log Aviso]
    
    E --> H[Métricas]
    F --> H
    G --> H
    
    H --> I[Relatórios]
```

## Integração CI/CD

```mermaid
graph TB
    A[Push] --> B[Preflight]
    B --> C{Status}
    
    C -->|Pass| D[Trigger CI]
    C -->|Fail| E[Block]
    
    D --> F{CI Check}
    F -->|Pass| G[Deploy]
    F -->|Fail| H[Notify]
    
    G --> I[Monitor]
    H --> J[Fix]
    J --> B
```

## Sistema de Notificações

```mermaid
sequenceDiagram
    participant Action
    participant Preflight
    participant Notification
    participant User
    
    Action->>Preflight: Trigger Check
    
    alt Success
        Preflight->>Notification: Success Event
        Notification->>User: Success Message
    else Warning
        Preflight->>Notification: Warning Event
        Notification->>User: Warning Details
    else Error
        Preflight->>Notification: Error Event
        Notification->>User: Error & Fix
    end
```

## Processo de Recuperação

```mermaid
stateDiagram-v2
    [*] --> Normal
    
    Normal --> Error: Falha detectada
    
    state Error {
        [*] --> Analyze
        Analyze --> AutoFix
        AutoFix --> Validate
        Validate --> [*]
    }
    
    Error --> Recovery: Não corrigido
    
    state Recovery {
        [*] --> Backup
        Backup --> Manual
        Manual --> Verify
        Verify --> [*]
    }
    
    Recovery --> Normal: Corrigido
```

## Legenda

### Símbolos

- 🟢 Sucesso
- 🟡 Aviso
- 🔴 Erro
- ⚙️ Processamento
- 📝 Log
- 👤 Usuário
- 🤖 Automação

### Estados

- **Normal**: Operação padrão
- **Warning**: Requer atenção
- **Error**: Bloqueante
- **Recovery**: Processo de correção

### Ações

- **Validate**: Verifica conformidade
- **Auto-fix**: Correção automática
- **Block**: Impede progresso
- **Log**: Registra evento
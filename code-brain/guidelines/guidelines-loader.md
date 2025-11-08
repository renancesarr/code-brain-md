# Guidelines Loader — Code-Brain

## Sistema de carregamento de guidelines

Este arquivo é o ponto de entrada para carregar guidelines do Code-Brain de forma modular.

## Como carregar guidelines

### Carregamento completo
```yaml
load:
  module: all
  context: complete
```

### Carregamento por módulo
```yaml
load:
  module: git
  sections: 
    - workflow
    - commit
    - pr
```

### Carregamento por seção específica
```yaml
load:
  module: git
  section: commit
  context: minimal
```

## Módulos disponíveis

### Git (`git/`)
- **Workflow** (`workflow-template.md`): Fluxo completo de trabalho
- **Commit** (`commit-convention.md`): Convenções de commit
- **PR** (`pr-template.md`): Template de Pull Request
- **Guidelines** (`guidelines.md`): Regras fundamentais
- **Commands** (`commands-log-template.yaml`): Registro de comandos

## Formato de referência

### Carregar uma seção
```markdown
<load section="git/workflow" />
```

### Carregar múltiplas seções
```markdown
<load sections="git/workflow,git/commit" />
```

### Referenciar outra guideline
```markdown
Ver mais em: <ref to="git/commit-convention.md" />
```

## Regras de carregamento

1. Guidelines são carregadas em ordem de dependência
2. Conflitos são resolvidos pela regra mais específica
3. Contexto mínimo sempre inclui regras fundamentais
4. Todas as ações requerem validação via schema.yaml

## Integração com IA

As IAs devem:
1. Ler este arquivo primeiro
2. Determinar quais seções precisam ser carregadas
3. Carregar guidelines na ordem correta
4. Validar ações contra as regras carregadas
5. Manter log de guidelines aplicadas
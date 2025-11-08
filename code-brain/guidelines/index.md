# Guidelines Index — Code-Brain

## Módulos ativos

### Git
- **Path**: `git/`
- **Schema**: `git/schema.yaml`
- **Guidelines principais**: `git/guidelines.md`

## Como usar este índice

1. Determine o módulo necessário (ex: git)
2. Carregue o schema do módulo
3. Siga as dependências conforme necessário
4. Valide ações contra as regras

## Exemplo de uso por IAs

```yaml
# Carregar workflow git
load:
  module: git
  sections: [workflow]
  validate: true
  log: true

# Resultado esperado
result:
  loaded:
    - git/guidelines.md      # carregado por ser dependência
    - git/workflow.md        # arquivo solicitado
  validated: true
  logged: timestamp
```

## Registro de uso

O arquivo `guidelines.log.yaml` mantém registro de:
- Quais seções foram carregadas
- Quando foram aplicadas
- Resultado da validação

## Formatos aceitos

- Markdown (`.md`): documentação e regras
- YAML (`.yaml`): schemas e logs
- Shell (`.sh`): scripts de automação
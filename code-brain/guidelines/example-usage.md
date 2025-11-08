# Exemplo de uso das Guidelines — Code-Brain

## Cenário: Criar nova feature

```yaml
# 1. Carregar regras git necessárias
load:
  module: git
  sections: 
    - workflow
    - commit
  context: standard
  validate: true
```

### Guidelines carregadas:

1. Fundamentais (`git/guidelines.md`):
   - Trabalhar em feature branches
   - Não fazer push direto em develop/main
   - PR obrigatório
   
2. Workflow (`git/workflow-template.md`):
   ```bash
   git checkout -b feature/UC-001/T001
   git add .
   git commit -m "feat(auth): implementa login"
   ```

3. Commit (`git/commit-convention.md`):
   - Tipo: feat
   - Contexto: auth
   - Descrição: implementa login

### Validação:

```yaml
result:
  loaded_files:
    - git/guidelines.md
    - git/workflow-template.md
    - git/commit-convention.md
  validation:
    schema: true
    dependencies: true
  status: success
```

## Próximos passos:

1. Criar PR usando `git/pr-template.md`
2. Aguardar revisão humana
3. Registrar atividade em `guidelines.log.yaml`
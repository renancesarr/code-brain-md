# Guia Completo de Preflight Checks — Code-Brain

## Índice

1. [Introdução](#introdução)
2. [Instalação e Setup](#instalação-e-setup)
3. [Uso Diário](#uso-diário)
4. [Cenários Comuns](#cenários-comuns)
5. [Resolução de Problemas](#resolução-de-problemas)
6. [Referências](#referências)

## Introdução

### O que é o Preflight?

O sistema de preflight checks do Code-Brain é uma ferramenta de validação automática que garante que todas as alterações de código sigam as guidelines do projeto e mantenham a qualidade do código.

### Por que usar?

- Previne erros comuns
- Mantém consistência no código
- Automatiza verificações repetitivas
- Acelera o processo de revisão
- Reduz retrabalho

### Como funciona?

O preflight atua em pontos críticos do desenvolvimento:

1. Antes de commits
2. Antes de pushes
3. Antes de PRs
4. Antes de merges

## Instalação e Setup

### Requisitos

```bash
# Dependências necessárias
node >= 14.0.0
yq    >= 4.0.0
git   >= 2.30.0
```

### Instalação

1. Clone o repositório:
```bash
git clone git@github.com:renancesarr/code-brain-md.git
cd code-brain-ai
```

2. Configure os hooks do git:
```bash
chmod +x code-brain/guidelines/preflight.sh
cp code-brain/guidelines/preflight.sh .git/hooks/pre-commit
cp code-brain/guidelines/preflight.sh .git/hooks/pre-push
```

3. Verifique a instalação:
```bash
./code-brain/guidelines/preflight.sh --version
```

## Uso Diário

### Fluxo de Trabalho Básico

1. **Iniciar feature**:
```bash
git checkout -b feature/UC-001/T001
./preflight.sh branch  # valida nome da branch
```

2. **Durante desenvolvimento**:
```bash
# Antes de commit
./preflight.sh commit "feat(auth): implementa login"

# Antes de push
./preflight.sh push
```

3. **Criar PR**:
```bash
./preflight.sh pr
gh pr create --title "[UC-001] Implementa autenticação"
```

### Níveis de Validação

#### Nível Standard (Desenvolvedores)
- Sugestões de correção
- Bloqueio em erros críticos
- Logs básicos

#### Nível Strict (IAs)
- Auto-correção quando possível
- Bloqueio em qualquer erro
- Logs detalhados

### Customização

Você pode configurar o preflight editando:

```yaml
# code-brain/guidelines/preflight.yaml
developer_types:
  human:
    preflight_level: standard
    auto_fix: suggest
  
  ai_agent:
    preflight_level: strict
    auto_fix: execute
```

## Cenários Comuns

### 1. Nova Feature

```bash
# 1. Criar branch
git checkout -b feature/UC-001/T001
./preflight.sh branch

# 2. Desenvolver e commitar
git add .
./preflight.sh commit "feat(auth): adiciona login"
git commit -m "feat(auth): adiciona login"

# 3. Push e PR
./preflight.sh push
git push origin feature/UC-001/T001
./preflight.sh pr
```

### 2. Correção de Bug

```bash
# 1. Branch de bugfix
git checkout -b feature/UC-002/T002
./preflight.sh branch

# 2. Corrigir e commitar
git add .
./preflight.sh commit "fix(auth): corrige validação"
git commit -m "fix(auth): corrige validação"

# 3. Testes e push
./preflight.sh test
./preflight.sh push
```

### 3. Atualização de Documentação

```bash
# 1. Branch de docs
git checkout -b feature/UC-003/T003
./preflight.sh branch

# 2. Atualizar e validar
git add .
./preflight.sh commit "docs(readme): atualiza instruções"
git commit -m "docs(readme): atualiza instruções"
```

## Resolução de Problemas

### Problemas Comuns

#### 1. Branch inválida
```
❌ Erro: Branch 'feature-login' inválida
✓ Solução: Renomear para feature/UC-XXX/TXXX
```

```bash
# Corrigir
git branch -m feature/UC-001/T001
```

#### 2. Commit inválido
```
❌ Erro: Commit "adiciona login" inválido
✓ Solução: Usar formato type(scope): message
```

```bash
# Corrigir
git commit --amend -m "feat(auth): adiciona login"
```

#### 3. Testes falhando
```
❌ Erro: Cobertura de testes baixa (70%)
✓ Solução: Adicionar testes até atingir 80%
```

```bash
# Corrigir
npm run test:coverage
```

### Logs e Depuração

#### 1. Ver logs detalhados
```bash
cat preflight.log
```

#### 2. Modo debug
```bash
DEBUG=true ./preflight.sh commit
```

#### 3. Validar configuração
```bash
./preflight.sh check-config
```

## Referências

### Documentos Relacionados

1. [Git Guidelines](../git/guidelines.md)
2. [Commit Convention](../git/commit-convention.md)
3. [PR Template](../git/pr-template.md)

### Ferramentas Integradas

- **Lint**: ESLint, Prettier
- **Testes**: Jest, Coverage
- **CI/CD**: GitHub Actions
- **Validação**: Schema, YQ

### Links Úteis

1. [Wiki do Projeto](https://github.com/renancesarr/code-brain-md/wiki)
2. [Issues](https://github.com/renancesarr/code-brain-md/issues)
3. [Discussions](https://github.com/renancesarr/code-brain-md/discussions)

## Apêndice

### A. Glossário

- **Preflight**: Sistema de validação prévia
- **Hook**: Ponto de interceptação do git
- **Guidelines**: Regras e convenções do projeto

### B. Checklist de Validação

#### Pre-commit
- [ ] Branch válida
- [ ] Commit válido
- [ ] Lint passou
- [ ] Testes unitários

#### Pre-push
- [ ] Testes completos
- [ ] Cobertura > 80%
- [ ] Sem conflitos
- [ ] Documentação atualizada

#### Pre-PR
- [ ] Branch atualizada
- [ ] CI passou
- [ ] Reviewers definidos
- [ ] Template preenchido

### C. Scripts Úteis

```bash
# Validar toda a base
./preflight.sh validate-all

# Limpar cache
./preflight.sh clean-cache

# Gerar relatório
./preflight.sh report
```
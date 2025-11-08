# Preflight Checks — Code-Brain

## Visão Geral

O sistema de preflight checks garante que todo código e alteração sigam as guidelines do projeto antes de serem commitados, enviados ou mergeados.

## Como Funciona

### 1. Pontos de Checagem

O preflight é executado em 4 momentos críticos:

1. **Pre-commit**: Antes de criar um commit
   ```bash
   ./preflight.sh commit "feat(auth): implementa login"
   ```

2. **Pre-push**: Antes de enviar alterações
   ```bash
   ./preflight.sh push
   ```

3. **Pre-PR**: Antes de criar um Pull Request
   ```bash
   ./preflight.sh pr
   ```

4. **Pre-merge**: Antes de mergear
   ```bash
   ./preflight.sh merge
   ```

### 2. O que é Verificado

#### Pre-commit
- Nome da branch
- Mensagem do commit
- Lint do código
- Guidelines básicas

#### Pre-push
- Todos os commits válidos
- Testes passando
- Cobertura de testes
- Sem segredos no código
- Lint completo

#### Pre-PR
- Branch atualizada
- Sem conflitos
- Documentação atualizada
- Cobertura de testes
- Guidelines completas

#### Pre-merge
- Aprovações necessárias
- CI passou
- Cobertura mantida
- Scan de segurança
- Guidelines finais

### 3. Níveis de Validação

#### Para Humanos
- Sugestões de correção
- Bloqueio em erros críticos
- Nível standard

#### Para IAs
- Auto-correção quando possível
- Bloqueio em qualquer erro
- Nível strict

### 4. Auto-correção

O sistema pode corrigir automaticamente:
- Nomes de branch
- Mensagens de commit
- Estilo de código
- Formatação

### 5. Integração com Guidelines

O preflight:
1. Carrega guidelines relevantes
2. Valida contra regras
3. Registra conformidade
4. Gera relatórios

## Exemplos de Uso

### Commit com Preflight

```bash
# 1. Stage alterações
git add .

# 2. Rodar preflight
./preflight.sh commit "feat(auth): implementa login"

# 3. Se passar, criar commit
git commit -m "feat(auth): implementa login"
```

### Push com Preflight

```bash
# 1. Rodar preflight
./preflight.sh push

# 2. Se passar, fazer push
git push origin feature/UC-001/T001
```

### PR com Preflight

```bash
# 1. Rodar preflight
./preflight.sh pr

# 2. Se passar, criar PR
gh pr create --title "[UC-001] Implementa autenticação"
```

## Logs e Relatórios

O sistema mantém logs em:
- `preflight.log`: Registro de execuções
- `metrics.yaml`: Métricas e estatísticas

## Mensagens de Erro

### Branch inválida
```
❌ Branch 'feature-login' não segue convenção
Esperado: feature/UC-XXX/TXXX
Exemplo: feature/UC-001/T001
```

### Commit inválido
```
❌ Commit message não segue convenção
Esperado: type(scope): message
Exemplo: feat(auth): implementa login
```

### Testes insuficientes
```
❌ Cobertura de testes insuficiente: 75%
Mínimo requerido: 80%
```

## Boas Práticas

1. Sempre execute preflight antes de commits
2. Corrija todos os warnings
3. Mantenha logs atualizados
4. Siga sugestões de correção

## Troubleshooting

### Preflight falha
1. Leia mensagem de erro
2. Consulte guidelines relevantes
3. Aplique correções sugeridas
4. Re-execute preflight

### Auto-correção falha
1. Verifique permissões
2. Confira configurações
3. Tente correção manual
4. Consulte logs
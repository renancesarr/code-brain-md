# Guia de Elicitação de Use Cases

## Perguntas Fundamentais

### 1. Objetivo e Contexto

```yaml
perguntas_contexto:
  objetivo:
    - "Qual o principal objetivo deste caso de uso?"
    - "Que problema específico ele resolve?"
    - "Qual o valor entregue ao usuário?"
    
  contexto:
    - "Em que situação este caso de uso se aplica?"
    - "Quais são as condições necessárias?"
    - "Qual o estado atual do sistema/processo?"
    
  beneficios:
    - "Quais os benefícios esperados?"
    - "Como medir o sucesso?"
    - "Qual o impacto nos indicadores?"
```

### 2. Atores e Stakeholders

```yaml
perguntas_atores:
  principais:
    - "Quem são os usuários principais?"
    - "Quais suas responsabilidades?"
    - "Qual seu nível de conhecimento técnico?"
    
  secundarios:
    - "Quais sistemas interagem?"
    - "Existem integrações externas?"
    - "Quem precisa ser notificado?"
    
  stakeholders:
    - "Quem são os interessados no processo?"
    - "Quem precisa aprovar?"
    - "Quem será impactado?"
```

### 3. Requisitos e Restrições

```yaml
perguntas_requisitos:
  funcionais:
    - "Quais as funcionalidades essenciais?"
    - "O que pode ser opcional?"
    - "Existem variações necessárias?"
    
  nao_funcionais:
    - "Quais os requisitos de performance?"
    - "Existem requisitos de segurança?"
    - "Qual a disponibilidade esperada?"
    
  restricoes:
    - "Existem limitações técnicas?"
    - "Há restrições de negócio?"
    - "Quais os prazos críticos?"
```

### 4. Fluxos e Processos

```yaml
perguntas_fluxos:
  principal:
    - "Quais os passos principais?"
    - "O que acontece em cada etapa?"
    - "Quais as validações necessárias?"
    
  alternativos:
    - "Quais os caminhos alternativos?"
    - "Em que condições ocorrem?"
    - "Como retornam ao fluxo principal?"
    
  excecoes:
    - "O que pode dar errado?"
    - "Como tratar os erros?"
    - "Qual o plano de recuperação?"
```

### 5. Dados e Integrações

```yaml
perguntas_dados:
  entrada:
    - "Quais dados são necessários?"
    - "Como são validados?"
    - "Qual o formato esperado?"
    
  processamento:
    - "Como os dados são transformados?"
    - "Quais regras são aplicadas?"
    - "Onde são armazenados?"
    
  saida:
    - "Quais os resultados esperados?"
    - "Como são apresentados?"
    - "Quem precisa receber?"
```

## Template de Tasks

### Task Principal

```yaml
# task-UC-XXX.yaml
metadata:
  id: "task-UC-XXX"
  related_usecase: "UC-XXX"
  type: "feature"
  priority: "medium"
  size: "medium"
  
description: |
  Implementação do caso de uso [Título do UC].
  
  Objetivo principal:
  [Descrição do objetivo]
  
acceptance_criteria:
  - "Critério 1"
  - "Critério 2"
  - "Critério 3"
  
subtasks:
  - id: "task-UC-XXX-1"
    title: "Análise e Design"
  - id: "task-UC-XXX-2"
    title: "Implementação Core"
  - id: "task-UC-XXX-3"
    title: "Testes"
  - id: "task-UC-XXX-4"
    title: "Documentação"
```

### Subtasks

#### 1. Análise e Design

```yaml
# task-UC-XXX-1.yaml
metadata:
  id: "task-UC-XXX-1"
  parent: "task-UC-XXX"
  type: "analysis"
  
description: |
  Análise detalhada e design da solução.
  
deliverables:
  - Diagrama de sequência
  - Modelo de dados
  - Protótipos de interface
  - Documento de design
  
acceptance_criteria:
  - "Design revisado e aprovado"
  - "Protótipos validados"
  - "Arquitetura definida"
```

#### 2. Implementação Core

```yaml
# task-UC-XXX-2.yaml
metadata:
  id: "task-UC-XXX-2"
  parent: "task-UC-XXX"
  type: "implementation"
  
description: |
  Implementação das funcionalidades core.
  
components:
  - Backend API
  - Frontend UI
  - Integrações
  - Banco de dados
  
acceptance_criteria:
  - "Código implementado"
  - "Testes unitários"
  - "Code review aprovado"
```

#### 3. Testes

```yaml
# task-UC-XXX-3.yaml
metadata:
  id: "task-UC-XXX-3"
  parent: "task-UC-XXX"
  type: "testing"
  
description: |
  Testes completos da funcionalidade.
  
test_types:
  - Testes unitários
  - Testes de integração
  - Testes e2e
  - Testes de performance
  
acceptance_criteria:
  - "100% cobertura crítica"
  - "Todos testes passando"
  - "Performance validada"
```

#### 4. Documentação

```yaml
# task-UC-XXX-4.yaml
metadata:
  id: "task-UC-XXX-4"
  parent: "task-UC-XXX"
  type: "documentation"
  
description: |
  Documentação completa da feature.
  
deliverables:
  - Documentação técnica
  - Documentação de API
  - Guia do usuário
  - Release notes
  
acceptance_criteria:
  - "Docs atualizados"
  - "Exemplos incluídos"
  - "Changelog atualizado"
```

## Processo de Criação

1. **Elicitação**
   - Usar perguntas guia
   - Documentar respostas
   - Validar com stakeholders

2. **Use Case**
   - Criar usando template
   - Incluir todos os detalhes
   - Validar estrutura

3. **Tasks**
   - Criar task principal
   - Quebrar em subtasks
   - Definir critérios

4. **Validação**
   - Review com time
   - Ajustes necessários
   - Aprovação final

## Checklist de Qualidade

```yaml
checklist:
  use_case:
    - Objetivo claro e mensurável
    - Fluxos bem definidos
    - Critérios de aceitação claros
    
  tasks:
    - Escopo bem definido
    - Dependências identificadas
    - Critérios verificáveis
    
  documentacao:
    - Completa e clara
    - Exemplos incluídos
    - Formatação correta
```